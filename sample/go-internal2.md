# 链接器和目标文件
今天，我们谈一谈go的linker，目标文件和relocations(重定位，变量地址的分配是在链接时分配的)
为什么要关注这些东西？如果你学习任何语言的内部原理，第一件要做的事就是模块划分。第二就是理解模块暴露出来的接口。对于go，高层的模块是编译器，链接器和runtime。编译器给链接器提供的接口就是目标文件，也是我们今天要说的。
## 生成go目标文件。
做一个简单的小实验，写一段小程序并编译，然后看看目标文件是什么样的。
```
package main

func main() {
	print(1)
}
```
用下面的命令编译。
```
go tool compile test.go
```
为了查看内部结构，我们需要用 *goobj* 库。这是go内部使用的，用来检验生成的目标文件是否正确。我已经写了一个小程序。地址在github上。使用go get安装。
```
go get github.com/s-maktyukevich/goobj_explorer
goobj_explorer -o test.6
```
接着你会看到`gob.Package`的具体结构。(现在这个工具可能会编译不过,需要到~/src/github.com/golang/go下面，检出go1.4分支，接着吧src/cmd/internal文件复制一份，名为src/cmd/inter2,最后把github.com/s-matyukevich/goobj_explorer/main.go里面的import路径改为inter2,当然了，go的版本最好也是1.4的，推荐用docker)
## 分析目标文件
目标文件最有趣的部分是 *Syms array*。这其实是符号表。程序中所有你定义的函数，全局变量，类型，常量等都在其中。接下来看一下*main*函数的入口。(已经略去部分代码)
```
&goobj.Sym{
            SymID: goobj.SymID{Name:"main.main", Version:0},
            Kind:  1,
            DupOK: false,
            Size:  48,
            Type:  goobj.SymID{},
            Data:  goobj.Data{Offset:137, Size:44},
            Reloc: ...,
            Func:  ...,
}
```
goobj.Sum结构的字段如下:

|字段|解释|
|----|----|
|SumID      |符号的唯一id包括了符号名和版本。版本可以区分同名的不同符号|
|Kind       |表明符号的类型|
|DupOK      |符号是否允许重复|
|Size       |符号数据的大小|
|Type       |如果有的话，代表一个到另外符号的引用|
|Data       |包含二进制数据。这个字段区分不同符号的意义。比如，函数的汇编码，字符串的raw数据。|
|Reloc      |relocations 的列表|
|Func       |函数的元数据|

现在看一下符合的种类。符号种类定义在 *goobj* 包中。
```
const (
	_ SymKind = iota

	// readonly, executable
	STEXT
	SELFRXSECT

	// readonly, non-executable
	STYPE
	SSTRING
	SGOSTRING
	SGOFUNC
	SRODATA
	SFUNCTAB
	STYPELINK
	SSYMTAB // TODO: move to unmapped section
	SPCLNTAB
	SELFROSECT
	...
```
可以看出*main.main*是*STEXT*类型的符号。*STEXT*是包含机器码的符号。现在，我们看一下Reloc数组。包含以下结构。
```
type Reloc struct {
	Offset int
	Size   int
	Sym    SymID
	Add    int
	Type int
}
```
每次relocation都意味着位于[offset,offset+size]间的字节需要被一个新的地址代替。这个地址通过Sym符号的地址和字节数相加得到。(直接替换地址，简单粗暴。地址计算还是类似于基地址+偏移量的到的。)
## 理解relocations
现在用一个例子理解relocation如何工作的。
```
go tool compile -S test.go
```
查看main函数的汇编码。(和c的汇编差不多，汇编应该都这种样子)
```
"".main t=1 size=48 value=0 args=0x0 locals=0x8
	0x0000 00000 (test.go:3)	TEXT	"".main+0(SB),$8-0
	0x0000 00000 (test.go:3)	MOVQ	(TLS),CX  //拿到g的指针
	0x0009 00009 (test.go:3)	CMPQ	SP,16(CX) //16(CX)是g里面的preempt字段。
	0x000d 00013 (test.go:3)	JHI	,22 //做其他事，被抢占或者进行栈扩张。
	0x000f 00015 (test.go:3)	CALL	,runtime.morestack_noctxt(SB)
	0x0014 00020 (test.go:3)	JMP	,0
	0x0016 00022 (test.go:3)	SUBQ	$8,SP
	0x001a 00026 (test.go:3)	FUNCDATA	$0,gclocals·3280bececceccd33cb74587feedb1f9f+0(SB)
	0x001a 00026 (test.go:3)	FUNCDATA	$1,gclocals·3280bececceccd33cb74587feedb1f9f+0(SB)
	0x001a 00026 (test.go:4)	MOVQ	$1,(SP)
	0x0022 00034 (test.go:4)	PCDATA	$0,$0
	0x0022 00034 (test.go:4)	CALL	,runtime.printint(SB)
	0x0027 00039 (test.go:5)	ADDQ	$8,SP
	0x002b 00043 (test.go:5)	RET	,
```
这里我们关心这一行:
``` 
0x0022 00034 (test.go:4)	CALL	,runtime.printint(SB)
```
这个语句的偏移量是`0x0022`。这个偏移量是相对于函数数据的。这一行实际上是调用了`runtime.printint`函数。而函数并不知道`runtime.printint`函数的真实地址。这个函数在不同的目标文件中。因此要通过relocation。下面展示了具体的内容。
```
{
                    Offset: 35,// 0x0022的十进制是34
                    Size:   4,
                    Sym:    goobj.SymID{Name:"runtime.printint", Version:0},
                    Add:    0,
                    Type:   3,
                },
```
这个relocation告诉连接器，从偏移量35开始，需要吧4个字节的数据用`runtime.printint`符号的地址代替。(为什么不是35，因为有一个字节是操作符call,后面的是地址)

## 理解TLS
细心的读者注意到main函数的relocation。这和其他的都不同，他有一个空的symbol:
```
{
                    Offset: 5,
                    Size:   4,
                    Sym:    goobj.SymID{},
                    Add:    0,
                    Type:   9,
                },
```
这是什么意思。偏移量为5，size为4是这条语句。(获取当前g的指针)
```
0x0000 00000 (test.go:3)	MOVQ	(TLS),CX
```
从0开始有9个byte(TEXT和MOVQ两行,CMPQ开始的是9),可以猜到这个重定向是跟tls有关的。但是TLS是什么，又将如何定位呢？(似乎go对TLS也有修改)
TLS是线程局部变量。这个东西在很多语言中都有。简而言之，他可以让一个变量在不同的线程中代表不同的数据。(例如c语言中的errorn.)
在go中，TLS用来储存指向g的指针。因而不同goroutine运行时，其可以指向不同的g(总是指向正在运行的g，不过切换过程中还是会有一些中间态)。链接器知道这个变量的地址并把它移到`CX`寄存器中。TLS在不同的机器上有不同的实现。对于AMD64，TLS是通过FS寄存器，因此这条命令最终会被翻译为`MOVQ FS,CX` (连接器会把这些虚拟寄存器转换成真实的寄存器，这是在relocation的时候进行的)

# 函数
下面谈论一下go的函数结构和垃圾回收的一些细节。
## 元数据
下面看一下`main`函数的结构。(go是支持反射的，func和struct会有一些元信息来支持反射)
```
Func: &goobj.Func{
    Args:    0, //函数参数数目
    Frame:   8, //参数和返回值的byte数，go的参数和返回值都是在栈上，参考go如何返回多个值。
    Leaf:    false,//ARM架构下的，
    NoSplit: false,//参考//go:nosplit，不要进行stack check，自然也不会发生栈扩张。
    Var:     {
    },//局部变量的信息。
    //文件的信息，行数之类的，参考debug.Stack()
    PCSP:   goobj.Data{Offset:255, Size:7},
    PCFile: goobj.Data{Offset:263, Size:3},
    PCLine: goobj.Data{Offset:267, Size:7},
    PCData: {
        {Offset:276, Size:5},
    },
    FuncData: {
        {
            Sym:    goobj.SymID{Name:"gclocals·3280bececceccd33cb74587feedb1f9f", Version:0},
         Offset: 0,
     },
     {
         Sym:    goobj.SymID{Name:"gclocals·3280bececceccd33cb74587feedb1f9f", Version:0},
               Offset: 0,
           },
       },
       File: {"/home/adminone/temp/test.go"},
   },
```
可以发现函数信息在编译的时候加入了目标文件并且被runtime使用。接下来讲述go是如何利用这些元信息的。
在`runtime`包中，元信息的结构体如下。
```
type _func struct {
	entry   uintptr // start pc 这个是函数的地址
	nameoff int32   // function name 函数名

	args  int32 // in/out args size 参数大小
	frame int32 // legacy frame size; use pcsp if possible 

	pcsp      int32
	pcfile    int32
	pcln      int32
	npcdata   int32
	nfuncdata int32
}
```

可以看出并非目标文件中的所有信息都被映射了。一些字段只是用于连接器。而且，最有趣的是`pscp,pcfile,pcln`三个字段，用于程序计数器，被翻译为栈指针，文件名，和行号。(程序计数器,program counter,参考wiki,这里的意思应该是记录了代码的信息)
这是很有用的，比如panic的时候。准确的说，runtime只知道触发panic的汇编码。然后runtime根据程序计数器找到当前的文件名，行号和调用栈。文件名和行号是`pcfile`和`pcln`。调用栈需要递归的查询`pcsp`
既然有了程序计数器，那么如何获取对应的行号呢？查看汇编码中的行号。
```
0x001a 00026 (test.go:4)	MOVQ	$1,(SP)
	0x0022 00034 (test.go:4)	PCDATA	$0,$0
	0x0022 00034 (test.go:4)	CALL	,runtime.printint(SB)
	0x0027 00039 (test.go:5)	ADDQ	$8,SP
	0x002b 00043 (test.go:5)	RET	,
```
可以看出程序计数器从26到38包含了行号4，从39到下一个程序计数器记录了行号5。为了节省空间，可以这样储存。
```
26 - 4
39 - 5
...
```
编译器知道这些信息。`pcln`字段指向当前函数在程序计数器的起点。然后二分法搜索可以找到对应的行号。
在g\o中美这是很普遍的，不只是行号或栈指针映射在程序计数器中，任何整数都映射其中。通过`PCDATA`命令。(这个东西是用来辅助GC的，在go源码中搜索`pcdatavalue`可以看出具体是如何使用的。参考scanframeworker)
```
0x0022 00034 (test.go:4)    PCDATA  $0,$0
```
第一个参数意为，这是一个函数或者是一个变量。第二个是一个包含了gc mask的变量的引用。

















