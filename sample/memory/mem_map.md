# map和channel

## map的创建

map的语意为一个指向hmap的指针。
(string的语意是stringStruct。字符串为"" 和 长度为0的语意相同，
即`len(str) == 0` 和 `str == ""` 会被编译为相同的汇编代码，只判断长度。
slice的语意为slice。`sli == nil` 意味着{nil,?,?}的slice，
`len(sli) == 0` 意味着{?,0,?}的slice，cgo中需要注意这点。
因为stringStruct和slice大小比较小，不用指针可以提高缓存命中。
hmap比较大，拷贝开销较大。
)

map的创建方式有三种:
1. m:=map[int]int{}
2. m:=make(map[int]int)
3. var m map[int]int

对于情况12，调用的都是 `func makemap_small() *hmap` ，对于情况3不会调用构造函数，
即一个未初始化的map为nil指针，(string为{nil,0},slice为slice{nil,0,0})

``` go
// map的结构，采用了均摊扩容的机制(参考redis，
// 扩容时写新，双读，每次读都会把这个元素cp到新的里面，
// 扩容完成后删除旧的，得到均摊O(1)的复杂度。)
// A header for a Go map.
type hmap struct {
	// Note: the format of the Hmap is encoded in ../../cmd/internal/gc/reflect.go and
	// ../reflect/type.go. Don't change this structure without also changing that code!
	count     int // # live cells == size of map.  Must be first (used by len() builtin)
	flags     uint8
	B         uint8  // log_2 of # of buckets (can hold up to loadFactor * 2^B items)
	noverflow uint16 // approximate number of overflow buckets; see incrnoverflow for details
	hash0     uint32 // hash seed
    // 选2的倍数，扩容简单。
	buckets    unsafe.Pointer // array of 2^B Buckets. may be nil if count==0.
	oldbuckets unsafe.Pointer // previous bucket array of half the size, non-nil only when growing
	nevacuate  uintptr        // progress counter for evacuation (buckets less than this have been evacuated)

	extra *mapextra // optional fields
}
```

## channel 

channel的语意为指向hchan的指针。
创建方式只有两种:
1. var c chan int
2. c:=make(chan int,0)

查看汇编代码，1中直接返回一个nil指针，
对于2会调用 `func makechan(t *chantype, size int) *hchan` 。
``` asm
	0x0026 00038 (mem_chan.go:9)	LEAQ	type.chan int(SB), AX
	0x002d 00045 (mem_chan.go:9)	PCDATA	$2, $0
	0x002d 00045 (mem_chan.go:9)	MOVQ	AX, (SP)
    // 0为buf大小
	0x0031 00049 (mem_chan.go:9)	MOVQ	$0, 8(SP)
	0x003a 00058 (mem_chan.go:9)	CALL	runtime.makechan(SB)
``` 
其次可以发现，只读chan只是编译断言，由编译器语法分析时保证，
通过unsafe方法把一个只读chan转化为双向chan并进行写入也是可以的。
hchan结构如下:
``` go
type hchan struct {
	qcount   uint           // total data in the queue
	dataqsiz uint           // size of the circular queue
	buf      unsafe.Pointer // points to an array of dataqsiz elements
	elemsize uint16
	closed   uint32
	elemtype *_type // element type
	sendx    uint   // send index
	recvx    uint   // receive index
	recvq    waitq  // list of recv waiters
	sendq    waitq  // list of send waiters

	// lock protects all fields in hchan, as well as several
	// fields in sudogs blocked on this channel.
	//
	// Do not change another G's status while holding this lock
	// (in particular, do not ready a G), as this can deadlock
	// with stack shrinking.
	lock mutex  // chan是协程安全的
}
```

chan的设计思路类似于linux的select机制，
select机制中，如果没有fd可读写(异常)，
挂起线程，并把它加在设备的等待队列上，
设备就绪时，OS唤醒等待队列(把线程投入调度队列中)
go也是类似，只不过是协程和go调度器实现。

select只会通知你有fd就绪，还需要自己循环
查找就绪的fd。
而go自动帮你随机选了一个。