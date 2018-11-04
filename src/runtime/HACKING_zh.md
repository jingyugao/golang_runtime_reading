这是一个简要的文档，以后可能会过时。
它意在说清楚go runtime和普通代码编写的不同。
它注重普适的概念而不是某个接口的细节

调度结构
=======

调度器管理着遍布runtime的三种类型的资源:Gs,Ms 和Ps。
即使你不是从事调度器开发也应该理解这些结构。

Gs, Ms, Ps
----------

一个G就是简单的goroutine。它由类型 `g` 代表。
当一个goroutine存在时，他的 `g` 归还到空闲 `g` 池中
并且可以在稍后被其他goroutine复用
(这里应该是写错了吧。应该是g消亡以后，可以被复用，即 `g` 池

一个 "M" 是可以执行用户代码，runtime代码的系统线程
它由类型 `m` 表示
由于可能存在任意数量的线程陷于系统调用，
因此同一时刻可能会存在任意数量的Ms

最后，一个 "P" 代表了用于执行用户代码的资源，如调度器和内存分配的状态。
它由类型 `p` 表示。P的数量是 `GOMAXPROCS` ，这个数字是确定不变的。
一个P可以被认为像os调度器的cpu，p的状态类似于每个cpu的状态。
这是一个存放共享状态的好地方。（那些非per-thread和per-gouroutine的状态）

调度器的工作是使G(要执行的代码)，M(在哪里执行),和P(执行的权利和资源)相协调。
当一个M在执行用户代码的时候停止了，比如进入系统调用，
他返回持有的P给闲置的P池
为了重新开始执行晕乎代码，例如从系统调用返回，
它(M)必须从空闲的P池中获取一个P

所有的 `g`, `m`, 和 `p` 对象都是在堆中分配的，但是永远不会被释放，
印次他们的内存保持稳定。
因此，runtime可以避免在在调度中的写屏障

用户栈和系统栈
--------------

每个非死亡的G有一个相连的 *用户栈* ，即用户代码在何处执行。
用户栈刚开始很小(比如,2k) 可以动态增长或下降。

每个M有一个相关的 *系统栈* (即M的g0的栈)，以及一个 *信号栈* (即gsingal).
系统栈和信号栈不能增长，但是足够执行runtime的代码以及cgo代码
(在纯go二进制文件中是8k,在cgo中是系统分配)

Runtime代码通过 `systemstack`, `mcall`, 或者 `asmcgocall` 切换到系统栈
来执行不能被抢占的任务，不能扩张用户栈的代码，或者要切换用户goroutine的代码
运行在系统栈上的代码暗含了非抢占的意思且gc不会扫描系统栈。
当在系统栈运行时，当前的用户栈不能用于执行(代码)。

`getg()` 和 `getg().m.curg`
---------------------------

为了得到当前的用户 `g` ，使用 `getg().m.curg` 。

`getg()` 返回当前的 `g` ，但是在系统栈或信号栈上运行时，
会返回当前M的g0(或gsignal)的栈。这可能不是你想要的。

位了判断你是在用户栈还是在系统栈上
使用 `getg() == getg().m.curg` .

错误处理和报告
============

同常用户代码中的可以合理revover的错误应该使用 `panic` 。
然而，有些情况 `panic` 会立即导致致命错误，例如在系统栈上调用，
或者在 `mallocgc` 的期间调用

runtime的大多数错误都是不能recover的。对于这些，使用 `throw` ，
它会储存调用栈回溯并立即结束进程。
通常，`thorw` 应该传入一个字符串常量防止在危险的情况下下进行内存分配。
按照惯例，格外的细节应该在 `throw` 前用 `print` 或 `println` 打印
这些信息会被加上"runtime" 前缀

对于runtime错误调试，可以添加 `GOTRACEBACK=system` 或 `GOTRACEBACK=crash`。

同步
====

runtime有多个同步机制。他们有不同的语意，
尤其是，他们与goroutine调度器和系统调度器相互影响。

最简单的是 `mutex`，通过 `lock` 和 `unlock` 操作。
它可以在短时间内保护共享结构。
在 `mutex` 上阻塞会直接阻塞对应的M，
而不和调度器相互作用。(不需要调度器参与)
这意味着它可以用于runtime的底层代码，
但是也阻止了相关的G和P被重新调度
`rwmutex` 也是类似

对于单次通知，使用 `note` ，它提供了 `notesleep` 和 `notewakeup` 。
不像传统的unix `sleep`/`wakeup`, `note` 是race-free的，
因此如果`notewakeup` 已经发生了， `notesleep` 会立刻返回。
一个 `note` 可以使用 `noteclear` 重制，
但是绝对不能和sleep或wakeup存在竞争。
当一个 `note` 阻塞了M，表现的和 `mutex` 类似。
然而，有多种方式可以在 `note` 上sleep:
`notesleep` 也可以阻止相关的G和P重新调度，
而 `notesleepg` 表现的像一个阻塞系统调用，允许P被复用来跑其他的G。
这不如直接阻塞G效率高因为这消费了一个M

为了直接与调度器交互，使用 `gopark` 和 `goready` 。
`gopark` 把当前的goroutine置为 "waiting" 状态
并把它从调度器的运行队列中移除，
并调度另一个在当前M/P上的G。

`goready` 把一个被寄存的goroutine置为"runnable"状态
并把其放入运行队列中去。

简要概括

<table>
<tr><th></th><th colspan="3">Blocks</th></tr>
<tr><th>Interface</th><th>G</th><th>M</th><th>P</th></tr>
<tr><td>(rw)mutex</td><td>Y</td><td>Y</td><td>Y</td></tr>
<tr><td>note</td><td>Y</td><td>Y</td><td>Y/N</td></tr>
<tr><td>park</td><td>Y</td><td>N</td><td>N</td></tr>
</table>

非托管内存
==========

一般来说，runtime尝试使用普通的堆分配的内存。
然而，有些时候runtime必须使用不在gc堆上的内存，(即 *unmanaged memeory*)
如果对象是内存管理系统本身的一部分或者在某些调用者不含P的情况下分配的。
(即这部分内存不受gc控制，是更底层的接口，直接用mmap分配的)

分配非托管内存有三种方式

* sysAlloc 直接从OS获取内存。可以获取任何系统页大小(4k)整数倍的内存，
也可以被sysFree释放

* persistentalloc 吧多个小内存组合为单次sysAlloc防止内存碎片。
然而，没有办法释放其分配的内存。

* fixalloc 是slab风格的分配器，用于分配固定大小的对象。
fixalloc分配的对象可以被释放，但是这个内存可能会被fixalloc pool复用，
因此它只能给相同类型的对象复用。

一般来说，任何通过上面这些分配的类型都应该标记为`//go:notinheap`

非托管内存分配的对象 *禁止* 含有堆指针，除非一下满足以下条件:

1. 非托管内存的人和指针都必须明确地加入到gc的根对象(`runtime.markroot`)。

2. 如果内存复用，堆指针必须在被gc根可见之前0初始化。
    否则，gc会看到陈旧的堆指针。
    参考 "Zero-initialization versus zeroing"

Zero-initialization versus zeroing
==================================

runtime中有两种置零方式，取决于内存是否已经初始化为类型安全的状态

如果内存不是类型安全的状态，意味着它可能含有垃圾，
因为它是刚刚分配的且初始化以供首次使用，
这样它必须使用 `memclrNoHeapPointers` 或非指针的写来零初始化
这不需要写屏障。
(什么是非指针写 "non-pointer write" ???
类型安全是什么意思，"type-safe" ???

如果内存已经处于类型安全状态且简单的设置为0，这必须使用"regular write"
即 `typedmemclr` ,或 `memclrHasPointers`。这需要写屏障。

runtime-only 编译准则
=================================

除了"go doc compile" 中的"//go:"准则之外，
还有一些只能用于runtime的编译准则。

go:systemstack
--------------

`go:systemstack` 暗示一个函数必须在系统栈运行。
它会由一个特殊函数序言动态检查。
(函数序言即在汇编中，函数开始的那几行代码，
用来调节栈，寄存器之类的。参考wiki)

go:nowritebarrier
-----------------

`go:nowritebarrier` 指示编译器如果发现在下面的函数中包含写屏障，
产生一个错误。
(这不能阻止写屏障的产生，这只是个断言)

通常你需要 `go:nowritebarruerrec`。
`go:nowritebarrier`主要用于最好不要有写屏障的情形，
但是不需要严格保证。
(类似于warning，还是可以运行的)

go:nowritebarrierrec and go:yeswritebarrierrec
----------------------------------------------

`go:nowritebarrierrec` 指示编译器遇到写屏障时产生一个错误，
只不过是递归的，即这个函数调用的其他函数如果有写屏障也会报错。
`go:yeswritebarrierrec` 意思差不多，包含一个写屏障。

逻辑上说，编译器从每个 `go:nowritebarrierrec` 标记的函数开始搜索调用图
如果遇到一个函数包含写屏障就会产生一个错误。
遇到 `go:yeswritebarrierrec` 标记的函数时也会停止。

`go:nowritebarrierrec` 用于写屏障的实现防止死循环。

这两个都则都用于调度器。开启写屏障需要一个活跃的P(`getg().m.p !=nil `)
且调度器代码运行的时候经常没有活跃的P。
这种情况下，`go:nowritebarrierrec` 经常用于刚释放了P或者没有P的函数。
`go:yeswritebarrierrec` 用于代码重新获取了一个活跃的P。

因为他们是函数级别的注视，释放或获取P的代码可能需要分割为两个。


go:notinheap
------------

`go:notinheap` 用于类型声明。它暗示了一个类型不能从gc的堆上分配。
特别地，指向这个类型的指针在 `runtime.inheap` 检查时必须失败。
类型必须用于全局变量，栈变量或者非托管内存。
特别地:

1. `new(T)`, `make([]Y)`, `append([]T, ...)` 和隐式的堆分配是不允许的。
(虽然隐式分配无论如何在runtime中是不允许的)

2. 指向普通类型的指针(不是 `unsafe.Pointer`) 不能被转化为一个指向
`go:notinheap` 标记的类型，即使他们有相同的基类。

3. 任何包含 `go:notinheap` 的类型都是 `go:notinheap` 的。 
结构体和数组是这样。`go:notinheap` 的map和channel不允许的。
为了明确起见，任何实现了 `go:notinheap` 的类型必须标记为 `go:notinheap`

4. 对于一个指向 `go:notinheap` 的类型的指针，写屏障可以忽略。

最后一点是 `go:notinheap` 的好处。
runtime用它做低层次的内部结构，避免调度器和内存分配中的内存屏障，
(内存屏障会引起性能问题甚至是非法的)
这个机制是相当的安全而且不会降低runtime的可读性。









