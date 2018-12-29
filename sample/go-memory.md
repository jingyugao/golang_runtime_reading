# go的内存分配

`glibc`用的malloc为ptmalloc2。往往不能满足我们的需要，造轮子实现一个内存池或者内存分配器几乎是家常便饭。对于ptmalloc2，至少有以下缺点。
1. 内存碎片多。
2. 内存释放方式。ptmalloc 收缩内存是从 top chunk 开始,如果与 top chunk 相邻的 chunk 不能释放, top chunk 以下的 chunk 都无法释放。
3. 锁的开销，并发性能低。
4. 内存释放不可控(free后不会立刻把内存还给os,而且采用)。
5. 线程不均衡。(线程A分配的内存用完之后free掉，这块内存一般不会立刻归还os，线程B malloc的时候不能用这块内存)
6. 元数据较大。
7. 小对象分配速度低。

## glibc和tmalloc对比

|策略|分配速度|回收速度|局部缓存|易用性|通用性|SMP 线程友好度
|---|-------|-------|------|------|----|----|
|glibc|中|快|中|容易|高|中
|tmalloc|快|快|中|容易|高|高
## go的内存分配器
tmalloc是通用的内存分配器，通用性往往会降低性能，因此go借鉴tmalloc的思想实现了一套内存分配器。此外go还有垃圾回收机制，这也增加了分配器的复杂度。
首先，os的内存是以页为单位的，go自己搞了一个页的概念，一页为8k，span是多个页。
分为多级姑且称为(0-3)
- 0级:封装了mmap和ummap，向os申请内存，每次都申请一大块。
- 1级:heap，里面管理了所有的内存，全局唯一。负责把内存切割成span。并且有内存信息统计功能。
- 2级:mcentral，全局唯124个。把内存切割为相同大小的"对象",一个"对象"就是最小的分配单位。(有一点点浪费，但是整齐，方便管理)
- 3级:mcache，每个P一个。相当于TLS变量，不需要加锁，很快。

### span
go的内存是以span组织的，一个span是多个页。span主要是给内存做一个bitmap，标记是否使用，有O(1)的分配效率。
span这个bitmap很巧妙，主要有两个函数。`nextFreeIndex`和`nextFreeFast`
首先看nextFreeFast:
```
func nextFreeFast(s *mspan) gclinkptr {
	// 第几位开始不是0,从0位开始,从右边开始数。
	theBit := sys.Ctz64(s.allocCache) // Is there a free object in the allocCache?
	// 超过了说明没可用的了
	if theBit < 64 {
		result := s.freeindex + uintptr(theBit)
		// 超过了表明无可用的
		if result < s.nelems {
			// 可能有可用的
			freeidx := result + 1
			if freeidx%64 == 0 && freeidx != s.nelems {
				// 不是最后一个，且整除64，返回0
				return 0
			}
			// 真的有可用的
			// 更新一下
			s.allocCache >>= uint(theBit + 1)
			s.freeindex = freeidx
			s.allocCount++
			return gclinkptr(result*s.elemsize + s.base())
		}
	}
	return 0
}
```
看到这难免有些疑问
* allocCache是什么?
* Ctz64又是什么?
* 这段代码又是如何工作的?

首先来看go的注释:
>allocCache 是 allocBit的一段(所以叫cache)，从freeindex开始的64位（可能会溢出，自行考虑）
freeindex 在0-nelems之间，代表了查找空闲对象的起点。
每次分配都会从freeindex开始扫描allocBits直到它为0(allocBits的第x位)，意味着这里是(x)空闲对象
freeindex 调节以使以后的扫描从新发现的freeobject开始。
如果freeindex==nelem 说明没有空闲对象了
allocBits是对象的bitmap，allocBit中1表示使用，allocCache中1表示未使用
如果n>=freeindex而且allocBits[n/8]&(1<<(n%8))为0，(即allocBits的第n位为0),说明这是free的。
否则，n是已经分配的。nelem后的Bits未定义的，不应该被引用
object n 的起使内存是 n\*elemsize+(start<<\pageShift)  (span起使内存+对象偏移)


这里比较乱，大概意思是，allocBits是一个bitmap，标记是否使用，通过allocBits已经可以达到O(1)的分配速度，但是go为了极限性能，对其做了一个缓存，allocCache，从freeindex开始，长度是64。

初始状态，freeindex是0,allocCache全是1，allocBit是nil。
- 第一次分配，theBit是0，freeindex为1，allocCache为01111...。
- 第二次分配，theBit还是0，freeinde是2，allocCache为001111...。
...

在一个span清扫之后，情况会又些复杂。
freeindex会为0，不妨假设allocBit为1010....1010。全是1和0交替。
- 第一次分配，theBit是1，freeindex是2,allocCache是001010...10。
- 第二次分配，theBit是1，freeindex是4,allocCache是00001010..10。
...

最终freeindex变为了64返回0，这是会调用`func (s *mspan) nextFreeIndex() uintptr `

```
func (s *mspan) nextFreeIndex() uintptr {//这个函数有硬件优化，性能极高。
	sfreeindex := s.freeindex
	snelems := s.nelems
	if sfreeindex == snelems { // 没有空闲的对象了
		return sfreeindex
	}
	aCache := s.allocCache
	bitIndex := sys.Ctz64(aCache)
	for bitIndex == 64 { //allocCache为0，没有一个空闲对象，说么要更新一下allocCache了
		// 找到下一个缓存的地址。这个是吧sfreeindex取向上64的倍数
		sfreeindex = (sfreeindex + 64) &^ (64 - 1)
		if sfreeindex >= snelems {
			// 说明真的没了
			s.freeindex = snelems
			return snelems
		}
		// 只是缓存的值不行了，更新一下allocCache就好
		whichByte := sfreeindex / 8 // sfreeindex是64的倍数,不需要担心整除的问题
		s.refillAllocCache(whichByte)
		aCache = s.allocCache
		bitIndex = sys.Ctz64(aCache)
	}
	result := sfreeindex + uintptr(bitIndex)
	if result >= snelems {
		s.freeindex = snelems
		return snelems
	}
	s.allocCache >>= uint(bitIndex + 1)
	sfreeindex = result + 1
	if sfreeindex%64 == 0 && sfreeindex != snelems {
		whichByte := sfreeindex / 8
		s.refillAllocCache(whichByte)
	}
	s.freeindex = sfreeindex
	return result
}
```
这个函数会试着移动一下缓存，如果不行就申请新的span。通过这个操作，极大的提高了内存的复用和速度。
回收的时候也只需要标记一下bitmap就可以了。不会出现间隙对象不能复用的情况。
### mcache
对于小块内存(<32k)是从mcache开始分配，若不足则从上一级分配内存。多级分配。mcache每个P一个，分配时不需要加锁，这一层用来解决并发问题。
另外由于go是有gc的，go的gc是标记清楚法，这个算法会从*根对象*开始遍历所有储存指针的地方并递归标记。
这种方法往往需要知道一个地方储存的是指针还是整数，go通过bitmap储存了这个信息。
但是go对此做了一个优化，把内存分为noscan和scan的，对于前者，nosca意味着不含指针，在gc扫描过程中可以被忽略。
我们程序中经常使用的都是一些不含指针的结构体，他们不会被扫描，这样可以提高gc的性能。
对于noscan且非常小的对象(<16byte),为了避免浪费，go做了一个小对象分配器来分配，减小的内存分配效率。

### mcentral
mcentral是固定大小的分配器，有124个。这一级出现了对象的概念，比如class=3的mcentral是对象大小为32byte的分配器。
其中的span以双向链表的方式组织，分为两个。
noempty表示表示确定该span最少有一个未分配的元素，empty表示不确定该span最少有一个未分配的元素。
在查找的时候还会辅助做一些内存回收。如果没有内存可以会继续向上一级分配内存。
mcentral.go文件比较小，有意思的函数是`func (c *mcentral) cacheSpan() *mspan`，这个函数有100多行，占了文件的一半。下面分析一下简要流程。
这个函数是用来给mcache发放span的，分配之前会做一些回收工作，具体做多少根据mcentral的类型决定。
比如class=3的mcentral要做一个pageSize(8k)的gc工作量。(这个8k还需要乘以一个系数，之后得到的是要清扫的页数，这个页数就是工作量)

```
retry:
	for s = c.nonempty.first; s != nil; s = s.next {
		if s.sweepgen == sg-2 && atomic.Cas(&s.sweepgen, sg-2, sg-1) {
			//至少有一个可以使用的对象。
            //待会分配完就不保证还有了，所以放入empty中。
            c.nonempty.remove(s)
			c.empty.insertBack(s)
			unlock(&c.lock)
			s.sweep(true)
			goto havespan
		}
		if s.sweepgen == sg-1 {
			// 正在清扫，下一个
			// the span is being swept by background sweeper, skip
			continue
		}
		// 请扫过了 可以直接用
		// we have a nonempty span that does not require sweeping, allocate from it
		c.nonempty.remove(s)
		c.empty.insertBack(s)
		unlock(&c.lock)
		goto havespan
	}
```
这里需要解释一下nonempty 和empty的语意。
nonempty意味着至少有一个对象。
比如class=3，这个span有8k，总共可以有256个对象，nonempty意味着现在最多有255个，也就是说，还有一个空余，也可能更多。
empty意味着不确定只少有一个可用的对象。可能有，也可能没有。只要可能没有，就放进去。
如果没有的话会去empty中碰碰运气，
```
	for s = c.empty.first; s != nil; s = s.next {
		// 需要清扫
		if s.sweepgen == sg-2 && atomic.Cas(&s.sweepgen, sg-2, sg-1) {
			//这个链表遍历操作很秀，下面的remove和inertBack
            c.empty.remove(s)
			c.empty.insertBack(s) //现在s是链表末尾且s.next=nil
			unlock(&c.lock)
			s.sweep(true)
			freeIndex := s.nextFreeIndex()
			if freeIndex != s.nelems {
				s.freeindex = freeIndex
                //找到空闲的就返回了。
                goto havespan
			}
			lock(&c.lock)
			//这里会回到函数开头。
            goto retry
		}
		if s.sweepgen == sg-1 {
			// the span is being swept by background sweeper, skip
			continue
		}
		// already swept empty span,
		// all subsequent ones must also be either swept or in process of sweeping
		break
	}
```

### mheap
堆是负责最终的内存分配，准确的说是span的分配，堆中负责把内存切割为span(以及span再切割，span合并)，
还会统计各种内存信息，gc信息，bitmap信息，还包括了几个特殊的分配器(go内部使用)
首先heap把span分为四类:
- free [MaxMHeapList]mSpanList:小于128页的span，且未使用。是一个数组链表。下标代表span的页数。
- freelarge mTreap:大于128页的span，且未使用。是一个树堆。
- busy [MaxMHeapList]mSpanList:小于128页的span，且已使用。
- busylarge mSpanList:大于128页的span，且已使用。是一个链表。

我们知道，mcentral都是有固定型号的(对象大小，span页数),比如class=34的mcentral需要的span是16k，两页。mheap则负责去查找2页的span。这里是first-fit。
```go
    for i := int(npage); i < len(h.free); i++ {
        list = &h.free[i]
        if !list.isEmpty() {
            s = list.first
            list.remove(s)
            goto HaveSpan
        }
    }
```
如果查找不到则会从freeLarge中查找一个。best-fit。
```
   for t != nil {
        if t.spanKey == nil {
            throw("treap node with nil spanKey found")
        }
        if t.npagesKey < npages {
            t = t.right
        } else if t.left != nil && t.left.npagesKey >= npages {
            t = t.left
        } else {
            result := t.spanKey
            root.removeNode(t)
            return result
        }
    }
```
如果span较大会对其进行切割，将剩余的边角料放入free或者freeLarge中去。
此外，分配之前还会进行回收工作，如果busy中的span有不用了的，会将其放入free中。



