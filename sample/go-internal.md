# 深入理解go
这个系列的博文面向那些已经熟悉go的基本语法并想要深入了解内部原理的读者。今天的博文主要介绍go源码结构和一些go编译器细节。读完这篇文章，你应该可以回答以下问题:
1. go源码的结构是什么样的？
2. go编译器是如何工作的？
3. go的node tree的基本结构是什么样的？
## 开始准备
    当你开始学习一门新的语言时，你通常可以找到许多"helloworld"的教程、入门指导、或者关于语言概念、语法、甚至标准库的书。然而，从这些资料上无法获取到语言runtime分配的内存布局或者当你调用内部函数时生成的汇编代码。显然的，这些答案隐藏来源码之中，但是，按照我的经验，你可能花费了几个小时思考，但是却没有取得什么进展。
在这个主题，我即不会装作是一个专家，也不会尝试解释每个概念。相反，本文的目标是使你独立的识别go的源码。
开始之前，我们需要一份源码的拷贝。简单执行下面的命令。
```shell
    git clone https://github.com/golang/go
```
注意master分支的代码已经更新了许多，因此我们使用 *release-branch.go1.4* 分支。

## 项目结构
如果你看`/src`目录，你可以看到许多子目录。大多数都包含标准库的代码。这里的命名很标准，因此每个package都在一个相同名字的目录下。除了标准库，还有一些其他东西。在我看来，主要的目录如下。

| Folder | Description |
| ------            | ------               | 
| /src/cmd/         |	命令行工具          | 
| /src/cmd/go/      |	包含下载，编译和安装源码的工具。这里收集源码并调用编译器和连接器的命令。|
| /src/cmd/dist/    |	包含一个工具库，用来构建其他的命令行工具。你可能会想分析他的源码来理解每个工具或包都用了那些包。|
|/src/cmd/gc/       |	go编译器平台无关的代码。|
|/src/cmd/ld/       |	连接器平台相关的代码。平台相关的代码都以I开头|
|/src/cmd/5a/, 6a, 8a, and 9a |	go编译器不同平台下的代码。go汇编不是完全匹配这些机器。因此需要一些特殊的转换。|
|/src/lib9/, /src/libbio, /src/liblink |	编译器，连接器，标准库依赖的第三方库|
|/src/runtime/      |	最重要的部分。被所有go程序包含。包含了go的全部功能，如内存管理，垃圾回收，协程创建等。|

## 编译器
正如上面所说，编译器平台无关的代码在`/src/cmd/gc`目录。入口点在`lex.c`文件。除了公共的部分，例如解析命令行参数，编译器做了以下事情：
1. 初始化一些公共的数据结构。
2. 遍历所有提供的go文件，对每个文件调用*yyoarse*方法。这是实际的parser。编译器用*Bison*作为语法解析器。语言的语法全部位于`go.y`文件。这一步产生一个完整的语法数，每个节点都代表被编译程序的一个元素。
3. 多次递归访问生成的语法树，并做一些修改。例如，定义implicit type的类型信息，重写一些语句--例如类型转换--调用runtime包的函数或做一些其他工作。
4. 语法树完成之后开始真正的编译。节点被编译为机器语言。
5. 创建目标文件，包含生成机器码和其他数据，比如符号表。这个会被写入磁盘。
## 深入GO语法
	现在让我们看一下第二步。理解go编译器和语法，包含了语法的`go.y`文件是一个很好的切入点。文件的主要部分包括声明，如下：
```
xfndcl:
     LFUNC fndcl fnbody

fndcl:
     sym '(' oarg_type_list_ocomma ')' fnres
| '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' fnres
```
这个声明中，定义了`xfndcl`和`fundcl`。`fundck`节点有两种形式，
`somefunction(x int, y int) int `或者 `(t *SomeType) somefunction(x int, y int) int`.
`xfndcl`节点包含`func`的关键字，储存在`LFUNC`常量中，跟在`fndcl`和`fnbodynodes`后。
Bison的一个重要特性是他允许在每个定义之后放置c代码。每当匹配到这个定义时，代码就会执行一次。这里你可以引用变量`$$,$1,$2`等。`$$`为返回值，其余为参数。
可以通过下面的例子来理解。以下是一段实际的代码。
```
fndcl:
      sym '(' oarg_type_list_ocomma ')' fnres
        {
          t = nod(OTFUNC, N, N);
          t->list = $3;
          t->rlist = $5;

          $$ = nod(ODCLFUNC, N, N);
          $$->nname = newname($1);
          $$->nname->ntype = t;
          declare($$->nname, PFUNC);
      }
| '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' fnres
```

首先，创建了一个新的*node*，这个节点包含了函数的类型信息。`$3`和`$5`代表`oarg_type_list_ocomma`和`fnres`。最后创建了`$$`节点，储存了函数名和类型信息。
语法树节点

|Node |struct field	|Description|
|---- |----         |---        |
|op	  |节点操作符。每个节点都有这个字段。用于区分不同类型的节点。在上个例子中，这个是OTFUNC和ODCLFUNC，(函数定义，和函数声明)|
|type |	引用了其他类型信息节点的类型信息。控制流节点没这个字段|
|val    |	整数，字符串等字面值|
现在你理解了语法树等基本结构。你可以实践一下。在下面的内容，我们会使用一个简单的go程序分析汇编码的生成。

## 深入编译器
你了解当你通过`interface`引用一个变量时，发生了什么么？这不是个无聊的问题，因为go语言中一个类型实现了一个不包含任何自身信息的接口。我们可以试着回答一下，通过编译器的知识。
现在，让我们深入编译器，创建一个go程序看一下类型转换的内部原理。看一下语法树如何生成和使用的。
开始之前
为了完成实验，我们需要直接使用编译器(不是go tool)
```
go tool 6g test.go
```
这会编译test.go并生成目标文件。这里6g时amd64下的编译器名字。不同的平台应该用不同的名字。有时候，我们也需要一些其他的命令行参数。例如，我们用 -W标志打印语法树的结构。
创建一个简单的go程序。
首先，创建一个简单的程序。
```
  1  package main
  2 
  3  type I interface {
  4          DoSomeWork()
  5  }
  6 
  7  type T struct {
  8          a int
  9  }
 10 
 11  func (t *T) DoSomeWork() {
 12  }
 13 
 14  func main() {
 15          t := &T{}
 16          i := I(t)
 17          print(i)
 18  }
```
接着编译它
```
go tool 6g -W test.go
```

之后，你会看到输出中的语法树，每个方法都在其中。这里是`main`和`init`方法。`init`方法是程序隐式定义的，我们现在并不关心。
对于每个方法，编译器有两个打印版本。第一格式解析源文件的到的原始语法树，第二个是类型检查和一些更改之后的到的。

语法树的main函数
```
DCL l(15)
.   NAME-main.t u(1) a(1) g(1) l(15) x(0+0) class(PAUTO) f(1) ld(1) tc(1) used(1) PTR64-*main.T

AS l(15) colas(1) tc(1)
.   NAME-main.t u(1) a(1) g(1) l(15) x(0+0) class(PAUTO) f(1) ld(1) tc(1) used(1) PTR64-*main.T
.   PTRLIT l(15) esc(no) ld(1) tc(1) PTR64-*main.T
.   .   STRUCTLIT l(15) tc(1) main.T
.   .   .   TYPE <S> l(15) tc(1) implicit(1) type=PTR64-*main.T PTR64-*main.T

DCL l(16)
.   NAME-main.i u(1) a(1) g(2) l(16) x(0+0) class(PAUTO) f(1) ld(1) tc(1) used(1) main.I

AS l(16) tc(1)
.   NAME-main.autotmp_0000 u(1) a(1) l(16) x(0+0) class(PAUTO) esc(N) tc(1) used(1) PTR64-*main.T
.   NAME-main.t u(1) a(1) g(1) l(15) x(0+0) class(PAUTO) f(1) ld(1) tc(1) used(1) PTR64-*main.T

AS l(16) colas(1) tc(1)
.   NAME-main.i u(1) a(1) g(2) l(16) x(0+0) class(PAUTO) f(1) ld(1) tc(1) used(1) main.I
.   CONVIFACE l(16) tc(1) main.I
.   .   NAME-main.autotmp_0000 u(1) a(1) l(16) x(0+0) class(PAUTO) esc(N) tc(1) used(1) PTR64-*main.T

VARKILL l(16) tc(1)
.   NAME-main.autotmp_0000 u(1) a(1) l(16) x(0+0) class(PAUTO) esc(N) tc(1) used(1) PTR64-*main.T

PRINT l(17) tc(1)
PRINT-list
.   NAME-main.i u(1) a(1) g(2) l(16) x(0+0) class(PAUTO) f(1) ld(1) tc(1) used(1) main.I
```
为了简要，采取了删减版的代码。
第一个节点很简单:
```
DCL l(15)
.   NAME-main.t l(15) PTR64-*main.T
```
第一个节点是声明节点。I(15)说么这个节点在15行定义。节点引用了代表matin.t变量的节点。这个变量在main包中定义，是一个main.T类型的指针。通过15行可以看出这一点。
下一个有些复杂。
```
AS l(15) 
.   NAME-main.t l(15) PTR64-*main.T
.   PTRLIT l(15) PTR64-*main.T
.   .   STRUCTLIT l(15) main.T
.   .   .   TYPE l(15) type=PTR64-*main.T PTR64-*main.T
```
根节点是赋值节点。第一个孩子是代表`main.t`变量的节点。第二个是要赋给`main.t`的，一个字面值指针。他有一个结构体字面值，其实就是一个指向`main.T`的指针。
第二个节点是另一个声明。这次，他声明了`main.I`类型的`main.i`变量。
```
DCL l(16)
.   NAME-main.i l(16) main.I
```
接下来，编译器创建了另一个变量，`autotmp_0000`，并赋`main.t`值给他。
```
AS l(16) tc(1)
.   NAME-main.autotmp_0000 l(16) PTR64-*main.T
.   NAME-main.t l(15) PTR64-*main.T
```
最后，这是关键的节点。
```
AS l(16) 
.   NAME-main.i l(16)main.I
.   CONVIFACE l(16) main.I
.   .   NAME-main.autotmp_0000 PTR64-*main.T
```
这里，有一个特殊的节点，叫做*CONVIFACE*，编译器把它赋值给`main.i`。但是这没有给我们更多的信息，到底发生了什么。我们需要查看一下经过语法树重写后最终的语法树
编译器如何转换赋值节点
下么你可以看到编译器如何转换赋值节点的。
```
AS-init
.   AS l(16) 
.   .   NAME-main.autotmp_0003 l(16) PTR64-*uint8
.   .   NAME-go.itab.*"".T."".I l(16) PTR64-*uint8

.   IF l(16) 
.   IF-test
.   .   EQ l(16) bool
.   .   .   NAME-main.autotmp_0003 l(16) PTR64-*uint8
.   .   .   LITERAL-nil I(16) PTR64-*uint8
.   IF-body
.   .   AS l(16)
.   .   .   NAME-main.autotmp_0003 l(16) PTR64-*uint8
.   .   .   CALLFUNC l(16) PTR64-*byte
.   .   .   .   NAME-runtime.typ2Itab l(2) FUNC-funcSTRUCT-(FIELD-
.   .   .   .   .   NAME-runtime.typ·2 l(2) PTR64-*byte, FIELD-
.   .   .   .   .   NAME-runtime.typ2·3 l(2) PTR64-*byte PTR64-*byte, FIELD-
.   .   .   .   .   NAME-runtime.cache·4 l(2) PTR64-*PTR64-*byte PTR64-*PTR64-*byte) PTR64-*byte
.   .   .   CALLFUNC-list
.   .   .   .   AS l(16) 
.   .   .   .   .   INDREG-SP l(16) runtime.typ·2 G0 PTR64-*byte
.   .   .   .   .   ADDR l(16) PTR64-*uint8
.   .   .   .   .   .   NAME-type.*"".T l(11) uint8

.   .   .   .   AS l(16)
.   .   .   .   .   INDREG-SP l(16) runtime.typ2·3 G0 PTR64-*byte
.   .   .   .   .   ADDR l(16) PTR64-*uint8
.   .   .   .   .   .   NAME-type."".I l(16) uint8

.   .   .   .   AS l(16) 
.   .   .   .   .   INDREG-SP l(16) runtime.cache·4 G0 PTR64-*PTR64-*byte
.   .   .   .   .   ADDR l(16) PTR64-*PTR64-*uint8
.   .   .   .   .   .   NAME-go.itab.*"".T."".I l(16) PTR64-*uint8
AS l(16) 
.   NAME-main.i l(16) main.I
.   EFACE l(16) main.I
.   .   NAME-main.autotmp_0003 l(16) PTR64-*uint8
.   .   NAME-main.autotmp_0000 l(16) PTR64-*main.T
```
从输出中看到，编译器首先添加了初始化节点列表。在`AS-init`节点中，创建了一个新的变量，`main.autotmp_0003`,并把`go.itab.*””.T.””.I`变量的值赋给他。之后，检查这个变量是否为nil，。如果是nil，编译器调用`runtime.typ2Itab`函数并传递以下参数。
* 一个`main.T`类型的指针
* 一个`main.I`类型的指针
* 一个`go.itab.*””.T.””.I` 的变量
可以看出，这个变量是类型转换的关键。
## getitab函数
接下来要分析`runtime.typ2Itab`。下面是这个函数。
```
func typ2Itab(t *_type, inter *interfacetype, cache **itab) *itab {
	tab := getitab(inter, t, false)
	atomicstorep(unsafe.Pointer(cache), unsafe.Pointer(tab))
	return tab
}
```
显然真正的工作是在getitab中，第二句只是一个简单的赋值。接下来分析getitab，这个函数很大，所以只截取部分。
```
m = 
    (*itab)(persistentalloc(unsafe.Sizeof(itab{})+uintptr(len(inter.mhdr)-1)*ptrSize, 0,
    &memstats.other_sys))
    m.inter = interm._type = typ

ni := len(inter.mhdr)
nt := len(x.mhdr)
j := 0
for k := 0; k < ni; k++ {
	i := &inter.mhdr[k]
	iname := i.name
	ipkgpath := i.pkgpath
	itype := i._type
	for ; j < nt; j++ {
		t := &x.mhdr[j]
		if t.mtyp == itype && t.name == iname && t.pkgpath == ipkgpath {
			if m != nil {
				*(*unsafe.Pointer)(add(unsafe.Pointer(&m.fun[0]), uintptr(k)*ptrSize)) = t.ifn
			}
		}
	}
}
```
首先分配内存，*persistentalloc*是go的一个内存分配器。注意，它分配的内存无法释放，会一直存在。
为什么要用它分配呢？我们看一下itab结构体。
```
type itab struct {
	inter  *interfacetype
	_type  *_type
	link   *itab
	bad    int32
	unused int32
	fun    [1]uintptr // variable sized
}
```
最后一个字段，是定义为了一个只有一个元素的数组,但其实是可变大小的。(参考gcc变长数组)。接着来看这个数组指针。这些方法和interface里的方法一样。go的作者动态分配这个内存。(当你用unsafe时分配的都是这种内存).内存的大小时结构体自身大小加上interface里的函数数量乘以指针大小
```
unsafe.Sizeof(itab{})+uintptr(len(inter.mhdr)-1)*ptrSize
```
接下来，是两个内嵌循环。首先，我们遍历所有的interface方法。对每个方法都试着找出相关的类型(在mhdr表中储存的)。这是为了检查两个方法是否匹配。
如果我们找到一个匹配的，我们吧指针储存在fun字段中。
```
*(*unsafe.Pointer)(add(unsafe.Pointer(&m.fun[0]), uintptr(k)*ptrSize)) = t.ifn
```
一个小知识：由于方法都是按照字典序排序的，这个循环可以是O(m+n)而不是O(n*m)
最后是真正的赋值。
```
AS l(16) 
.   NAME-main.i l(16) main.I
.   EFACE l(16) main.I
.   .   NAME-main.autotmp_0003 l(16) PTR64-*uint8
.   .   NAME-main.autotmp_0000 l(16) PTR64-*main.T
```
这里，我们把*EFACE*节点赋给`main.i`变量。这个*EFACE*节点包含`main.autotmp_0003`变量的引用，`main.autotmp_0003`变量是`runtime.typ2Itab`方法的返回值，一个itab类型的指针。
最后，这个`main.i`变量包含一个iface类型的对象，
```
type iface struct {
	tab  *itab
	data unsafe.Pointer
}
```








