go time分析

# 时间的测量
在os中，有两个时钟:墙上时钟和单调时钟.
1. 墙上时钟. (wall time, real time)
2. 单调时钟. (monotonic time)

由于石英钟本身的误差，时间会有闰秒等原因，单调时钟与墙上时钟不一致。
两个时钟的具体含义参见《深入理解linux内核》

linux如何获取时间呢，很简单的一个思路是，
系统启动时通过daytime服务获得一个时间t0，并记录此时的单调时钟d0。
下次获得时间时，只需要获得单调时钟d,然后d-d0+t0即可获取墙上时钟。

# Time结构体分析
```go
type Time struct {
    // 省略注释
	wall uint64
	ext  int64

	loc *Location
}
```

顾名思义，loc代表时区信息，wall跟墙上时钟有关，剩下的ext跟模式有关。
通过阅读注释，这里的time 有两种模式，是否包含单调时钟。
(什么时候会不含单调时钟呢？外部输入的时间。因为单调时钟是本机硬件的节拍数，不同机器没有可比性)
* 如果包含单调时钟，那么wall中会包含一个时间戳秒(代表墙上时钟),和一个时间戳纳秒(代表墙上时钟),ext字段储存单调时钟。
* 如果不包含单调时钟,那么wall包含一个时间戳纳秒(代表墙上时钟)，ext包含一个时间戳秒(代表墙上时钟)

实现上，wall被分为3部分，1位的flag，33位的时间戳秒(墙上时钟),还有30位储存纳秒数(墙上时钟)。

下面分析具体的使用，首先是获取时间。
### 获取时间
```go
var startNano int64 = runtimeNano() - 1
func Now() Time {
	sec, nsec, mono := now()
	mono -= startNano
	sec += unixToInternal - minWall
	if uint64(sec)>>33 != 0 {
		return Time{uint64(nsec), sec + minWall, Local}
	}
	return Time{hasMonotonic | uint64(sec)<<nsecShift | uint64(nsec), mono, Local}
}
```
首先调用了now(),这个函数对应`runtime.time_now`,sec,nsec对应墙上时钟的秒和纳秒,
mono对应单调时钟.接下来的`startNano`是go程序启动时的单调时钟.下面几行是为了检测overflow的情况。
因为有墙上时钟的情况，wall中的33位包含一个墙上时钟。33位的秒数只能到2157年，超过则会上溢，
wall这个33位的秒代表了距离1885年的秒数，不是1970年。
* 上溢的时候，time不包含单调时钟，wall存储纳秒数，flag位和秒位都为0,
ext储存里了距离1年1月1日的秒数。(这也是go里面未初始化的时间为1年1月1日的原因)
* 正常情况下，wall第一位置为1，接着的33位为距离1885年的秒数，最后的30位代表了纳秒数。
ext则储存了距离程序启动时单调时钟的差值。
接着分析`now`和`runtimeNaon`。
```go
//go:linkname time_now time.now
func time_now() (sec int64, nsec int32, mono int64) {
	sec, nsec = walltime()
	return sec, nsec, nanotime()
}
```
这个函数从runtime包反向linkname到time包，比较罕见的操作。
nanotime对应了runtimeNaon.
继续分析，下面就是汇编了。分析统一写在行前。
```asm
// func walltime() (sec int64, nsec int32)
TEXT runtime·walltime(SB),NOSPLIT,$0-12
    // 保存sp寄存器，用于上下文切换
	MOVQ	SP, BP	// Save old SP; BP unchanged by C code.
    // tls代表type runtime.g指针，这里把g指针放到CX
	get_tls(CX)
    // 上文有#define	g(r)	0(r)(TLS*1)
    // 这里是
	MOVQ	g(CX), AX
    // 把g.m放到BX里
	MOVQ	g_m(AX), BX // BX unchanged by C code.
    // 下面是vdso，我也不懂，参考https://mzh.io/golang-arm64-vdso/
	// Set vdsoPC and vdsoSP for SIGPROF traceback.
	MOVQ	0(SP), DX
	MOVQ	DX, m_vdsoPC(BX)
	LEAQ	sec+0(SP), DX
	MOVQ	DX, m_vdsoSP(BX)
    // AX是当前的g么。
	CMPQ	AX, m_curg(BX)	// Only switch if on curg.
	JNE	noswitch
    // 把g0放入DX
	MOVQ	m_g0(BX), DX
    // 把栈切到g0的stack
	MOVQ	(g_sched+gobuf_sp)(DX), SP	// Set SP to g0 stack

noswitch:
    // 给clock_gettime的返回值留位置。 
	SUBQ	$16, SP		// Space for results
	ANDQ	$~15, SP	// Align for C code
    // 把函数地址放到AX中
	MOVQ	runtime·vdsoClockgettimeSym(SB), AX
    // 地址是否存在,似乎跟vdso有关。
	CMPQ	AX, $0
	JEQ	fallback
    // 参数入栈
	MOVL	$0, DI // CLOCK_REALTIME
    // SP的地址放入SI中,也是函数入参
	LEAQ	0(SP), SI
    // 函数调用
	CALL	AX
    // 把返回值sec放入AX
	MOVQ	0(SP), AX	// sec
    // nsec放入DX
	MOVQ	8(SP), DX	// nsec
    // 参考第一行，函数调用结束，sp置回之前的状态。
	MOVQ	BP, SP		// Restore real SP
    // 不详
	MOVQ	$0, m_vdsoSP(BX)
    // 函数返回
	MOVQ	AX, sec+0(FP)
	MOVL	DX, nsec+8(FP)
	RET
fallback:
    // 和上面类似，跟vdso有关。
    // 由于用寄存器传递参数，所以参数影响不大。
	LEAQ	0(SP), DI
	MOVQ	$0, SI
	MOVQ	runtime·vdsoGettimeofdaySym(SB), AX
	CALL	AX
	MOVQ	0(SP), AX	// sec
	MOVL	8(SP), DX	// usec
	IMULQ	$1000, DX
	MOVQ	BP, SP		// Restore real SP
	MOVQ	$0, m_vdsoSP(BX)
	MOVQ	AX, sec+0(FP)
	MOVL	DX, nsec+8(FP)
	RET

TEXT runtime·nanotime(SB),NOSPLIT,$0-8
	// Switch to g0 stack. See comment above in runtime·walltime.
    // 切换到g0的栈
	MOVQ	SP, BP	// Save old SP; BP unchanged by C code.

	get_tls(CX)
	MOVQ	g(CX), AX
	MOVQ	g_m(AX), BX // BX unchanged by C code.

	// Set vdsoPC and vdsoSP for SIGPROF traceback.
	MOVQ	0(SP), DX
	MOVQ	DX, m_vdsoPC(BX)
	LEAQ	ret+0(SP), DX
	MOVQ	DX, m_vdsoSP(BX)

	CMPQ	AX, m_curg(BX)	// Only switch if on curg.
	JNE	noswitch

	MOVQ	m_g0(BX), DX
	MOVQ	(g_sched+gobuf_sp)(DX), SP	// Set SP to g0 stack

noswitch:
	SUBQ	$16, SP		// Space for results
	ANDQ	$~15, SP	// Align for C code

	MOVQ	runtime·vdsoClockgettimeSym(SB), AX
	CMPQ	AX, $0
	JEQ	fallback
    // 注意这里的1.
	MOVL	$1, DI // CLOCK_MONOTONIC
	LEAQ	0(SP), SI
	CALL	AX
	MOVQ	0(SP), AX	// sec
	MOVQ	8(SP), DX	// nsec
	MOVQ	BP, SP		// Restore real SP
	MOVQ	$0, m_vdsoSP(BX)
	// sec is in AX, nsec in DX
	// return nsec in AX
    // 单位统一为纳秒
	IMULQ	$1000000000, AX
	ADDQ	DX, AX
	MOVQ	AX, ret+0(FP)
	RET
fallback:
	LEAQ	0(SP), DI
	MOVQ	$0, SI
	MOVQ	runtime·vdsoGettimeofdaySym(SB), AX
	CALL	AX
	MOVQ	0(SP), AX	// sec
	MOVL	8(SP), DX	// usec
	MOVQ	BP, SP		// Restore real SP
	MOVQ	$0, m_vdsoSP(BX)
	IMULQ	$1000, DX
	// sec is in AX, nsec in DX
	// return nsec in AX
	IMULQ	$1000000000, AX
	ADDQ	DX, AX
	MOVQ	AX, ret+0(FP)
	RET
```
上面的分析可以看出，两个最终都调用了`clock_gettime`，只不过一个参数为0，一个为1.
clock_gettime是POSIX规定的。
```c
int clock_gettime(clockid_t clock_id, struct timespec *tp);
```
可以看出，函数参数有两个，第一个是个整数，对应上文的`MOVQ	$0, SI`和`MOVQ	$1, SI`,
0和1的含义如下。
```c
#define CLOCK_REALTIME 0
#define CLOCK_MONOTONIC 1
```
从上可以分析，now需要两次系统调用，nanotime需要一个。
粗略的说，now的开销是nanotime的两倍。



还有一种获取时间的方式是通过`time.Parse`,刨除各种if-else,最终调用了
```go
func unixTime(sec int64, nsec int32) Time {
	return Time{uint64(nsec), sec + unixToInternal, Local}
}
```
可以看出，这是不含单调时钟的。

## 时间运算
时间这里只分析Since，其他的都一样。
```go
func Since(t Time) Duration {
	var now Time
	if t.wall&hasMonotonic != 0 {
		// Common case optimization: if t has monotonic time, then Sub will use only it.
		now = Time{hasMonotonic, runtimeNano() - startNano, nil}
	} else {
		now = Now()
	}
	return now.Sub(t)
}
```

注意这里的优化，很容易的想到，两个时间的差值直接用单调时间求差就可以获得。
(不考虑墙上时钟的调整)
```go
func (t Time) Sub(u Time) Duration {
	if t.wall&u.wall&hasMonotonic != 0 {
		te := t.ext
		ue := u.ext
		d := Duration(te - ue)
		if d < 0 && te > ue {
			return maxDuration // t - u is positive out of range
		}
		if d > 0 && te < ue {
			return minDuration // t - u is negative out of range
		}
		return d
	}
	d := Duration(t.sec()-u.sec())*Second + Duration(t.nsec()-u.nsec())
	// Check for overflow or underflow.
	switch {
	case u.Add(d).Equal(t):
		return d // d is correct
	case t.Before(u):
		return minDuration // t - u is negative out of range
	default:
		return maxDuration // t - u is positive out of range
	}
}
```
sub的代码也很直观，检查一下是否溢出，正常情况下秒数求差即可。


### 其他
严格来说，go程序获取时间不能称作syscall，应该叫做"vsdo"，通过这种技术可以避免context切换。
极大的提高调用速度。












