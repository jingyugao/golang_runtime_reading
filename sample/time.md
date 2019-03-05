# Timer和Ticker
编程中经常会通过timer和ticker。其基本用法不在多说，本文结合源码分析其语义内涵。

## timer
timer创建有两种方式，`time.NewTimer(Duration)` 和`time.After(Duration)`。
后者只是对前者的一个包装。这里只分析前者。

```go
type Timer struct {
	C <-chan Time
	r runtimeTimer // 触发时间的结构
}

func NewTimer(d Duration) *Timer {
	c := make(chan Time, 1)
	t := &Timer{
		C: c,
		r: runtimeTimer{
			when: when(d),
			f:    sendTime,
			arg:  c,
		},
	}
	startTimer(&t.r)
	return t
}
```
可以看出timer只是对runtimeTimer的包装。runtimeTimer在`runtime/time`中实现，具体结构稍后分析。

## Ticker
和timer类似，ticker也有两个创建方式，下面看一下创建的代码。
```go
type Ticker struct {
	C <-chan Time // The channel on which the ticks are delivered.
	r runtimeTimer
}       // 可以看出 timer和ticker的结构体都一样

func NewTicker(d Duration) *Ticker {
	if d <= 0 {
		panic(errors.New("non-positive interval for NewTicker"))
	}
	c := make(chan Time, 1)
	t := &Ticker{
		C: c,
		r: runtimeTimer{
			when:   when(d),
			period: int64(d),
			f:      sendTime,
			arg:    c,
		},
	}
	startTimer(&t.r)
	return t
}
```
可以发现，timer和ticker几乎一样，只是runtimeTimer的参数不同，ticker多了一个period，下面具体分析`runtime/time.go`中的机制。

## runtime/time
这里是真正干活的地方，首先猜一下大概的工作原理。
  定时器的实现方式一般有下面几种:
1. 最小堆，最小堆是比较高效的。
2. 红黑树，nginx用的这个，某些情况也比较高效。
3. 链表，redis用的这个，某些情况也比较高效。
4. 时间轮等其变种，linux采用的这种。

最小堆其实是用的比较多的，go也用的是最小堆。关于这几种之间的差异，可以参考论文[1]。
另外定时器一般需要支持单次和重复两种，分别对应tick和timer。

看一下`runtime.timer`的结构。`runtimeTimer`和`runtime.timer`是一样的，他们的layout是一样的。这么做应该是为了解决循环引用。
```
type timer struct {
	tb *timersBucket  // 指向P的时间堆
	i  int      // 堆中的位置
	when   int64 // 第一次触发在when的时候
	period int64 // 周期,如果大于0，第2次在when+period....
	f      func(interface{}, uintptr) // NOTE: must not be closure 
	arg    interface{} // 参数
	seq    uintptr // TODO:
}
```
可以看出最后的活是交给timesBuket干的，timer只是存了一些参数。
```go
type timersBucket struct {
	lock         mutex  
	gp           *g
	created      bool
	sleeping     bool
	rescheduling bool
	sleepUntil   int64
	waitnote     note
	t            []*timer
}
// 所有P的时间堆都在timers中。
var timers [timersLen]struct { //长度64的数组
	timersBucket 
	pad [sys.CacheLineSize - unsafe.Sizeof(timersBucket{})%sys.CacheLineSize]byte // 伪共享
}
// 做了取模，p的id是连续的，P小于64时互不干扰。
// 大于64时不知道会不会出问题。TODO:
func (t *timer) assignBucket() *timersBucket {
	id := uint8(getg().m.p.ptr().id) % timersLen
	t.tb = &timers[id].timersBucket
	return t.tb
}
```
go的实现中每个P都一个时间堆，每个timersBucket都会起一个协程，用来处理时间事件。
(一般情况下，P小于64个)全局一个timers，64个timersBucket，
每个P对应一个timersBucket,每个timersBucket初始化时会新起一个协程
处理时间循环。新建一个定时器即在堆中添加新的一个节点，
停止定时器即移除该节点。
堆处理的相关代码不在赘述，下面分析一下`timerproc`。
这个函数包含了事件循环的主要工作。
```go
func timerproc(tb *timersBucket) {
	tb.gp = getg() // 获得当前的g。每个tb一个。
	for {
		lock(&tb.lock)  
		tb.sleeping = false // 不用休息
		now := nanotime()
		delta := int64(-1)
		for {
			if len(tb.t) == 0 { // 空的，直接sleep就行了。
				delta = -1
				break
			}
			t := tb.t[0]  // 最小堆，第一个是最近要发生的
			delta = t.when - now 
			if delta > 0 {
				break // 第一个未就绪，sleep
			}
            // 此时第一个已经就绪了
			if t.period > 0 { // 如果t是周期的,不要删除这个节点
                // 重制when，并将它放到合适的位置
                // 这里补偿了delta的延迟。
				t.when += t.period * (1 + -delta/t.period)
				siftdownTimer(tb.t, 0)
			} else { // 一次性的，直接移走
                last := len(tb.t) - 1
				if last > 0 {
					tb.t[0] = tb.t[last]
					tb.t[0].i = 0
				}
				tb.t[last] = nil
				tb.t = tb.t[:last]
				if last > 0 {
					siftdownTimer(tb.t, 0)
				}
				t.i = -1 // mark as removed
			}
			f := t.f // 即sendtime，下面分析。
			arg := t.arg
			seq := t.seq
			unlock(&tb.lock)
			if raceenabled {
				raceacquire(unsafe.Pointer(t))
			}
			f(arg, seq) // 同步调用，不能阻塞
			lock(&tb.lock)
		}
		if delta < 0 || faketime > 0 {// faketime用于伪造时间
			tb.rescheduling = true
			goparkunlock(&tb.lock, "timer goroutine (idle)", traceEvGoBlock, 1)
			continue
		}
        // 都未就绪
		tb.sleeping = true
		tb.sleepUntil = now + delta //休息到第一个就绪
		noteclear(&tb.waitnote)
		unlock(&tb.lock)
		notetsleepg(&tb.waitnote, delta)
	}
}
```

下面看一下`sendtime`，这里是具体的处理函数。
```go
func sendTime(c interface{}, seq uintptr) {
	// 很经典的非阻塞操作chan。
    select {
	case c.(chan Time) <- Now():
	default:
	}
}
```


# reference:
1. [http://59.80.44.99/www.cs.columbia.edu/~nahum/w6998/papers/sosp87-timing-wheels.pdf]
2. [https://www.ibm.com/developerworks/cn/linux/l-cn-timers/]
3. [https://www.ibm.com/developerworks/cn/linux/1308_liuming_linuxtime3/]
