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
1. gcAlways:强制触发gc,已经废弃，参考https://go-review.googlesource.com/c/go/+/66090/
2. heap使用率。(基于cpu和内存使用率反馈调节)
3. 手动GC。
4. 2分钟没有gc，触发一次gc。
`memstats.triggerRatio = 7 / 8.0` gc触发比例

## STW
STW有两次

## 相关结构体
gcControllerState:用于调节GC的触发时机，记录了各种时间，堆使用和cpu使用。
memstats:内存状态统计，记录了内存的使用情况。和上面的有重叠。
work:GC工作所需要的数据，包括标记了多少，待完成的任务，以及时间等。还有些信号量用于同步。



