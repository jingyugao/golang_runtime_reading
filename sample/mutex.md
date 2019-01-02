为了进行同步，我们往往会需要用锁，信号量，条件量。

## mutex

互斥锁对外提供两个操作,`Lock` 和 `Unlock` 。go的mutex是通过信号量实现的，实现一个toy互斥锁很简单。

```
type ToyMutex struct {
        state  int32
        sema uint32
}

func (tm *ToyMutex) Lock() {
        if atomic.AddInt32(&tm.state, 1) == 1 {
                return
        }
        runtime_Semacquire(&m.sema)
}

func (tm *ToyMutex) Unlock() {
        switch v := atomic.AddInt32(&m.state, -1); {
        case v == 0:
                return
        case v == -1:
                panic("sync: unlock of unlocked mutex")
        }
        runtime_Semrelease(&tm.sema)
}
```
这个就是玩具车，虽然能用，但是性能太低。下面来看一下go的超跑。
go的超跑考虑了下面几件事。
1. 唤醒顺序。多个协程等待锁时，该唤醒哪一个？
2. 自旋or挂起。如果很快就能得到锁，协程切换是不划算的。go的mutex会视情况自旋or挂起。

### 唤醒顺序
首先考虑第一个，多个协程等待锁，唤醒哪一个？这跟调度器差不多，本质是资源的合理分配。
说到资源的合理分配，就离不开公平和效率。
- 对于公平，很容易想到的方式就是先来先服务。
- 对于效率，最有效的就是后来先服务。(cpu的局部性)

公平和效率往往要相互妥协。go分为两种模式:
正常模式:如果等待的锁只有1个，进入正常模式。后来先服务。
饥饿模式:如果某个协程等待了1ms，进入饥饿模式。为先来先服务。
mutex源码中许多地方都在考虑资源如何合理分配。

### 自旋or挂起
合理的自旋是可以提高程序的性能。怎么才算合理？
1. 非饥饿模式。前面的协程快饿死了，就别添乱了。
2. 锁被其他协程持有。能拿到锁就别墨迹。
3. 只能自旋少于 4 次。大家都自旋对谁都不好。
4. 运行在多核机器上并且 GOMAXPROCS>1。就一个干活的就别自旋了，徒劳无功。
5. 最少有一个其它正在运行的 P。同上。
6. 本地的运行队列 runq 里没有 G 在等待。

可以看出合理的要求还是很严格的。不合理的自旋会极大的降低程序的性能，如果不确定，建议不要自旋。

## 源码实现
说完了go的设计思想，下面就来看一下实现。为了区别，下面把state的最后一位称为资源。
说之前要提到一个问题。
资源的释放和协程的唤醒。
资源的释放是操作state，协程的唤醒是操作sema，
这是两个步骤，因此被唤醒的协程不一定可以获取资源，需要循环进行。
获取失败，则继续挂起(这有点像信号量，其实信号量也是这么实现的)。
(唤醒协程可以随意一些，比如一次全部唤醒了也ok，只不过会造成惊群效应。
但是获取释放资源必须要严格正确，不然就会死锁或者没限制住。)

1. 被唤醒的协程VS新来的协程。
接下来是具体实现
首先对于标志位可以放入state中，内存复用，提高性能。
但是这么做是难以阅读的，因此建议用struct代替提高阅读效率。
```
// 还是一个uint32，只是方便阅读。
type State struct{
    bool locked
    bool woken
    bool starving
    uint29 waiter
}
```
locked代表资源是否获取。woken代表释放资源后是否要唤醒其他协程。starving代表是饥饿。
对于协程唤醒，唤醒和挂起应该是成对出现的，也就是说，有多少挂起就有多少唤醒。
最简单的方式就是每一个协程释放资源后都应该唤醒等待队列的一个协程(最后一个除外，因为此时已经没有等待者)。
但是go为了局部性，允许新来的协程去抢夺资源。
考虑下面这种情况，有且只有三个协程A,B,C。

|    |   A   |   B   |   C   |
|----|-------|-------|-------|
|t1  |       |挂起   |抢夺资源|
|t2  |释放资源|      |自旋   |
|t3  |       |       |抢到资源|
|t4  |离开   |       |      |

对于t2，如果C在抢夺资源，那么A在离开时不应该唤醒B。
或者说，C应该通知A，这个资源归我了，你就不要去叫B了，待会我爽完了我去叫B就行了。
当然了，既然是通知，那就可能通知不到位，也可能A已经叫醒B了C才开始通知，
这时候有两种情况。
1. C速度很快，瞬间就完事了。然后释放资源，这时候C是不需要去唤醒下一个的。
B醒来揉了揉眼，没有感受到B的存在。
2. C速度很慢，B醒来之后发现资源已经被C占了，只能继续挂起。(挂起前要通知C爽完了记得叫我。
当然了，这个通知是可能丢失的。因此通知完以后还要看一下C是不是还在爽着，
通过cas操作看一下如果C已经爽完了自己立刻接手。)

唤醒一定要做到不漏，最好也不要重复。情况1很容易理解，只要C足够快，快到B感受不到，就没问题。
如何证明不重不漏？
t4时刻C获取了资源。
go种为了实现这个流程，用了两个变量，woken和awoke。
awoke就是表明自己要不要唤醒下一个人。什么情况下要唤醒别人呢？
1. 自己是被唤醒的，要将唤醒传递下去。
2. 自己抢了别人的唤醒，要将唤醒还回去。(唤醒守恒)
这样流程就很清晰了。

第一个拿到资源的协程A要记得唤醒其他的。
剩下的排队休息，这时候协程X准备插队，插队之前先告诉A不要唤醒其他协程，
然后开始进行插队，
插队失败:排队休息，此时A要记得唤醒别人。
插队成功:拿到资源，自己记得唤醒别人。

看完逻辑之后，下面是正式的源码



首先对于第一个协程A，有一个fast-path。
```go
	if atomic.CompareAndSwapInt32(&m.state, 0, mutexLocked) {
		if race.Enabled {
			race.Acquire(unsafe.Pointer(m))
		}
		return
	}
```

接下来是后面的协程。awoke表示是否禁止唤醒。

如果我在自旋，那么必须要禁止唤醒，不然被唤醒的会跟我竞争。
如果我是被唤醒的或者抢了别人的唤醒，那么我解锁时要将唤醒传递下去。

```go
	var waitStartTime int64
	starving := false
		awoke := false
	iter := 0
	old := m.state
```
接下来是一个大的循环

```
for {
		// 最后一位是1,倒数第三位是0。(其他位是多少下文分析，这里不影响)
		// 说名是锁着的，但不是饥饿。(饥饿后面再讲)
		// runtime_canSpin说明可以自旋。
		if old&(mutexLocked|mutexStarving) == mutexLocked && runtime_canSpin(iter) {
			// awoke=false说明我不是被唤醒的，也没有抢到别人的唤醒。(开始插队，再接再厉)
            // old&mutexWoken == 0说明协程A还没有唤醒其他协程(我还有机会去插队)
            // old>>mutexWaiterShift != 0说明还有其他的等待者，(前面有人排队，我要插队)
            // 原子操作先告诉协程A不要唤醒其他人，(插队不能被其他协程发现)
            if !awoke && old&mutexWoken == 0 && old>>mutexWaiterShift != 0 &&
				atomic.CompareAndSwapInt32(&m.state, old, old|mutexWoken) {
				// 关闭了唤醒要记得打开
				awoke = true
			}
			runtime_doSpin()
			iter++
			old = m.state
			continue
		}
		new := old
		// 不是饥饿模式，加锁。饥饿模式就不要插队了。
		if old&mutexStarving == 0 {
			new |= mutexLocked
		}
		// 锁了或者饥饿。自己要等待了。
		if old&(mutexLocked|mutexStarving) != 0 {
			new += 1 << mutexWaiterShift
		}
		// 开启饥饿模式
        if starving && old&mutexLocked != 0 {
			new |= mutexStarving
		}
        // 记得mutexWoken
		if awoke {
			if new&mutexWoken == 0 {
				throw("sync: inconsistent mutex state")
			}
			// 置为零，这样解锁的时候会唤醒。
			new &^= mutexWoken
		}
		if atomic.CompareAndSwapInt32(&m.state, old, new) {
			if old&(mutexLocked|mutexStarving) == 0 {
				// 即没有锁，也不是饥饿模式
                // 说明现在已经拿到了锁。
				break 
			}
			// 没拿到锁，或者是饥饿模式，开始等待
            queueLifo := waitStartTime != 0
			if waitStartTime == 0 {
				waitStartTime = runtime_nanotime()
			}
			runtime_SemacquireMutex(&m.sema, queueLifo)
			// 唤醒时已经进入临界区。可以保证被唤醒的时候没有其他协程来竞争。
            starving = starving || runtime_nanotime()-waitStartTime > starvationThresholdNs
			old = m.state
			if old&mutexStarving != 0 {// 饥饿模式，暂时不考虑
                if old&(mutexLocked|mutexWoken) != 0 || old>>mutexWaiterShift == 0 {
					throw("sync: inconsistent mutex state")
				}
				delta := int32(mutexLocked - 1<<mutexWaiterShift)
				if !starving || old>>mutexWaiterShift == 1 {
					delta -= mutexStarving
				}
				atomic.AddInt32(&m.state, delta)
				break
			}
            // 将唤醒传递下去
			awoke = true
			iter = 0
		} else {
			old = m.state
		}
	}
```
mutexWoken的语意比较复杂，
解锁和解锁之间存在race，mutexWoken阻止重复唤醒。
解锁和加锁之间存在race，
加锁端设置mutexWoken告诉解锁端是否需要唤醒。
解锁端设置mutexWoken告诉加锁端我是否已经唤醒。





























