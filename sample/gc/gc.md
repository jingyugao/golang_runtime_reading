# GC

go的gc为非分代，非压缩的三色gc。并发扫描。
包含了四个步骤。
1. sweep termination。
2. mark 1 sub-phase。
3. mark 2 sub-phase。
4. mark termination。
5. sweep phase
6. goto  1.

## mark-sweep算法和三色GC
如字面意思一样，m-s算法分为两个阶段，mark和sweep。
mark阶段给所有活动对象做上标记，
sweep阶段负责清除没有标记的对象。
* 在标记阶段，首先会标记root object。
(root object 即根对象，
包括指栈上的对象，包变量和其他全局变量。
这是我们可以直接使用的变量，他们必须不能被清除。
当然，他们引用的变量也不能被清除。）
接着递归标记其引用的对象。(广度搜索或者深度搜索)
即一个图，从若干个起点出发，标记所有可能到达的点。
复杂度为O(n活跃对象数)。
* 在sweep阶段，会清扫不活跃的对象。即将这部分内存换给分配器。
如何进行归还？如何处理内存碎片？

三色GC即采用广度优先的方法遍历变量图。
在广度遍历中，有三个盒子，一个存放已遍历的，一个存放正在遍历的，
另一个即为还未遍历的。
随着标记的进行，当正在遍历的盒子为空时，意味着遍历已完成。
这是已遍历的盒子里为活跃对象，未遍历盒子为不活跃对象。
对于go，未遍历的未白色，正在遍历的为灰色，已遍历的为黑色。
其采用bitmap(黑白)和workbuf(灰)来实现。


## 四种worker
1. mutator assist
2. dedicated mark worker
3. fractional mark worker
4. idel mark worker

## mutator 
这个是Dijkstra发明的词，意思大概是"改变某物"。改变GC对象间的引用关系，简单来说就是用户程序。(到底是什么意思？)
mutator进行的操作有两种
* 生成对象
* 更新指针
mutator在后台进行这些操作，不会影响程序的正常执行。

## GC触发类型 
搜索 `gcStart` 只有三处地方有调用，调用类型如下。
1. gcTriggerAlways:强制触发gc,已经废弃，参考https://go-review.googlesource.com/c/go/+/66090/
2. gcTriggerHeap:内存使用率。(基于cpu和内存使用率反馈调节)。这个在mallocgc时调用。
3. gcTriggerCycle:手动GC。 `runtime.GC()` 时调用。
4. gcTriggerTime:2分钟没有gc，触发一次gc。
下面详细分析上面三种触发类型。

### gcTriggerHeap:
``` go
if shouldhelpgc {   // 当分配新的span时为true
		// 检查是否需要触发gc
		if t := (gcTrigger{kind: gcTriggerHeap}); t.test() {
			// 调用gcStart开始gc
			gcStart(gcBackgroundMode, t)
		}
	}

func (t gcTrigger) test() bool {
	if !memstats.enablegc || panicking != 0 {
		return false    // 禁用了GC或者正在发生panic
	}
	if t.kind == gcTriggerAlways {
		return true     // 这个已经废弃了
	}
	if gcphase != _GCoff {
		return false    // 如果正在GC，则返回false。
	}
	switch t.kind {
	case gcTriggerHeap:
		// Non-atomic access to heap_live for performance. If
		// we are going to trigger on this, this thread just
		// atomically wrote heap_live anyway and we'll see our
		// own write.
        // 当前的heap_live大于gc_trigger阈值是触发GC。
		return memstats.heap_live >= memstats.gc_trigger
	case gcTriggerTime:
		if gcpercent < 0 {
			return false    // 设置GCPersent小于0，不会触发GC
		}
		lastgc := int64(atomic.Load64(&memstats.last_gc_nanotime))
		return lastgc != 0 && t.now-lastgc > forcegcperiod
	case gcTriggerCycle:
		// t.n > work.cycles, but accounting for wraparound.
		return int32(t.n-work.cycles) > 0
	}
	return true
}
```
在mallocgc时，如果分配了span，会尝试进行一次GC测试，如果测试通过，触发GC，否则不触发。
测试即要求当前的 `heap_live >= gc_trigger` ， `heap_live` 为当前的堆使用的byte数,
`gc_trigger` 为阈值，采用反馈调节更新。

### gcTriggerCycle
这个在 `runtime.GC()` 中调用，测试条件为 `int32(t.n-work.cycles) > 0` 。
这个测试条件比较奇怪，先分析一下 `runtime.GC()` 的代码。
``` go
func GC() {
	// We consider a cycle to be: sweep termination, mark, mark
	// termination, and sweep. This function shouldn't return
	// until a full cycle has been completed, from beginning to
	// end. Hence, we always want to finish up the current cycle
	// and start a new one. That means:
	//
	// 1. In sweep termination, mark, or mark termination of cycle
	// N, wait until mark termination N completes and transitions
	// to sweep N.
	//
	// 2. In sweep N, help with sweep N.
	//
	// At this point we can begin a full cycle N+1.
	//
	// 3. Trigger cycle N+1 by starting sweep termination N+1.
	//
	// 4. Wait for mark termination N+1 to complete.
	//
	// 5. Help with sweep N+1 until it's done.
	//
	// This all has to be written to deal with the fact that the
	// GC may move ahead on its own. For example, when we block
	// until mark termination N, we may wake up in cycle N+2.
	// 我们认为一轮完整的GC为，sweep termination，mark，mark termination，sweep。
	// 这个函数在一轮完整的gc结束之前不应该返回。因此我们总是要结束当前GC并开启新的GC。
	// 这意味着：
	// 1. 如果在第N轮的sweep termiantion，mark，mark termination阶段，
	// 阻塞直到mark termination N结束并过渡到sweep N。
	// 2. 在sweep N，辅助sweep N。
	// 此时我们可以开启新一轮的GC N+1
	// 3. 开启sweep termination N+1，N+1轮GC开启
	// 4. 等待mark termination N+1结束
	// 5. 帮助sweep N+1直到结束。
	//
	// 这用来处理以下事实:GC会自己前进。
	// 例如，当阻塞直到mark termintaion N时，我们可能在N+2轮中被唤醒，？？？为什么

	gp := getg()

	// Prevent the GC phase or cycle count from changing.
	lock(&work.sweepWaiters.lock)
	n := atomic.Load(&work.cycles)
	if gcphase == _GCmark {
		// Wait until sweep termination, mark, and mark
		// termination of cycle N complete.
		gp.schedlink = work.sweepWaiters.head
		work.sweepWaiters.head.set(gp)
		goparkunlock(&work.sweepWaiters.lock, "wait for GC cycle", traceEvGoBlock, 1)
	} else {
		// We're in sweep N already.
		unlock(&work.sweepWaiters.lock)
	}

	// We're now in sweep N or later. Trigger GC cycle N+1, which
	// will first finish sweep N if necessary and then enter sweep
	// termination N+1.
	gcStart(gcBackgroundMode, gcTrigger{kind: gcTriggerCycle, n: n + 1})

	// Wait for mark termination N+1 to complete.
	lock(&work.sweepWaiters.lock)
	if gcphase == _GCmark && atomic.Load(&work.cycles) == n+1 {
		gp.schedlink = work.sweepWaiters.head
		work.sweepWaiters.head.set(gp)
		goparkunlock(&work.sweepWaiters.lock, "wait for GC cycle", traceEvGoBlock, 1)
	} else {
		unlock(&work.sweepWaiters.lock)
	}

	// Finish sweep N+1 before returning. We do this both to
	// complete the cycle and because runtime.GC() is often used
	// as part of tests and benchmarks to get the system into a
	// relatively stable and isolated state.
	for atomic.Load(&work.cycles) == n+1 && gosweepone() != ^uintptr(0) {
		sweep.nbgsweep++
		Gosched()
	}

	// Callers may assume that the heap profile reflects the
	// just-completed cycle when this returns (historically this
	// happened because this was a STW GC), but right now the
	// profile still reflects mark termination N, not N+1.
	//
	// As soon as all of the sweep frees from cycle N+1 are done,
	// we can go ahead and publish the heap profile.
	//
	// First, wait for sweeping to finish. (We know there are no
	// more spans on the sweep queue, but we may be concurrently
	// sweeping spans, so we have to wait.)
	for atomic.Load(&work.cycles) == n+1 && atomic.Load(&mheap_.sweepers) != 0 {
		Gosched()
	}

	// Now we're really done with sweeping, so we can publish the
	// stable heap profile. Only do this if we haven't already hit
	// another mark termination.
	mp := acquirem()
	cycle := atomic.Load(&work.cycles)
	if cycle == n+1 || (gcphase == _GCmark && cycle == n+2) {
		mProf_PostSweep()
	}
	releasem(mp)
}
```

`memstats.triggerRatio = 7 / 8.0` gc触发比例

## STW
STW有两次

## 相关结构体
gcControllerState:用于调节GC的触发时机，记录了各种时间，堆使用和cpu使用。
memstats:内存状态统计，记录了内存的使用情况。和上面的有重叠。
work:GC工作所需要的数据，包括标记了多少，待完成的任务，以及时间等。还有些信号量用于同步。


[reference]
https://www.youtube.com/watch?v=q1h2g84EX1M

