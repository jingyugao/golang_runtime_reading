# 内存分配的上层接口
## string 内部结构如下
``` go
type stringStruct struct {
	str unsafe.Pointer
	len int
}
```
生成string的方法有三种:
1. 从一个literal string生成。
2. 从一个[]byte转换。
3. 从一个string用append转换
4. 自己构造`strinStruct`，即cgo的做法（略）。

``` go
func f1() string {
	ret := "literial string"
	return ret
}
func f2() string {
	bs := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	ret := string(bs)
	return ret
}
func f3() string {
	var ret string
	ret = ret + "from append"
	return ret
}
```

用命令行工具将其编译为汇编文件，查看内部具体转换。
``` shell
go build -gcflags "-S -l -N" mem_slice.go 2>mem_slice.S
```

关键代码如下:
``` go
    func f1() string {
        ret := "literial string"
        return ret
    }
```
``` asm
    // 这里是data区域的字符串。
go.string.literial string" SRODATA dupok size=15
	0x0000 6c 69 74 65 72 69 61 6c 20 73 74 72 69 6e 67     literial string

    0x0016 00022 (mem_str.go:6)	PCDATA	$2, $1
	// 取字面值的地址,(字面值的数据在.data区域分配)
	0x0016 00022 (mem_str.go:6)	LEAQ	go.string."literial string"(SB), AX
	// 构造stringStruct
	// {
	//   	str=AX
	//		len=$15
	// }
	0x001d 00029 (mem_str.go:6)	MOVQ	AX, "".ret(SP)
	0x0021 00033 (mem_str.go:6)	MOVQ	$15, "".ret+8(SP)
	0x002a 00042 (mem_str.go:7)	PCDATA	$2, $0
	0x002a 00042 (mem_str.go:7)	PCDATA	$0, $1
	0x002a 00042 (mem_str.go:7)	MOVQ	AX, "".~r0+32(SP)
	0x002f 00047 (mem_str.go:7)	MOVQ	$15, "".~r0+40(SP)
	0x0038 00056 (mem_str.go:7)	MOVQ	16(SP), BP
	0x003d 00061 (mem_str.go:7)	ADDQ	$24, SP
	0x0041 00065 (mem_str.go:7)	RET
```

``` go
func f2() string {
	bs := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	ret := string(bs)
	return ret
}
// 相关函数签名
func slicebytetostring(buf *tmpBuf, b []byte) (str string) 
```
``` goasm
// 这里的几个字符也被编码为了字符串。位于data区域
"".statictmp_0 SRODATA size=10
	0x0000 73 6f 6d 65 20 62 79 74 65 73                    some bytes

	// tempbuf为nil。因为这个string要escape(传出函数),因此会在堆上分配一块内存
	// 如果不逃逸，则编译器会在栈上分配一段tempbuf。
	// 这里是go的小细节。
	// 同时也提示我们，[]byte转string时内存不共享。
	0x0070 00112 (mem_str.go:11)	MOVQ	$0, (SP)
	0x0078 00120 (mem_str.go:11)	PCDATA	$2, $1
	0x0078 00120 (mem_str.go:11)	PCDATA	$0, $0
	// 字面值的地址，这里只拷贝了一个地址。
    // len和cap是编译常量，因此没有拷贝。
	0x0078 00120 (mem_str.go:11)	MOVQ	"".bs+88(SP), AX
	0x007d 00125 (mem_str.go:11)	PCDATA	$2, $0
	// []byte如栈，AX为data*,10和10分别为len和cap,
    // 小细节，这里的10编译时知道，因此直接写死了
    // 一般情况下需要把sliceStruct的结构拷过来
	0x007d 00125 (mem_str.go:11)	MOVQ	AX, 8(SP)
	0x0082 00130 (mem_str.go:11)	MOVQ	$10, 16(SP)
	0x008b 00139 (mem_str.go:11)	MOVQ	$10, 24(SP)
	0x0094 00148 (mem_str.go:11)	CALL	runtime.slicebytetostring(SB)
```

``` go
func f3() string {
	var ret string
	ret = ret + "from append"
	return ret
}
// 函数签名，buf如果不escape就是nil
// 2的意思是两个字符串相加
// 如果是str1+str2+str3的话会调用concatstring3
func concatstring2(buf *tmpBuf, a [2]string) string {
	return concatstrings(buf, a[:])
}

```

``` asm
	// 传参数，buf=nil,这里要escape。
	0x002d 00045 (mem_str.go:17)	MOVQ	$0, (SP)
	0x0035 00053 (mem_str.go:17)	XORPS	X0, X0
	// stringStruct{str=nil,len=0}
	0x0038 00056 (mem_str.go:17)	MOVUPS	X0, 8(SP)
	0x003d 00061 (mem_str.go:17)	PCDATA	$2, $1
	// stringStruct{str=AX,len=11}
	0x003d 00061 (mem_str.go:17)	LEAQ	go.string."from append"(SB), AX
	0x0044 00068 (mem_str.go:17)	PCDATA	$2, $0
	0x0044 00068 (mem_str.go:17)	MOVQ	AX, 24(SP)
	0x0049 00073 (mem_str.go:17)	MOVQ	$11, 32(SP)
	0x0052 00082 (mem_str.go:17)	CALL	runtime.concatstring2(SB)
```

## slice的分配细节
slice结构如下
``` go
type slice struct {
	array unsafe.Pointer
	len   int
	cap   int
}
```
分配方式较多但总体来讲只有三种:
1. 编译器直接构造slice结构体
2. 编译器调用growslice
3. 编译器调用stringtoslice
4. 调用makeslice

``` go
func f4() []byte {
	ret := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	return ret
}

```

``` asm
	// AX即指向 _type的指针，这里_type为[10]uint8
    0x0032 00050 (mem_slice.go:4)	LEAQ	type.[10]uint8(SB), AX
	0x0039 00057 (mem_slice.go:4)	PCDATA	$2, $0
	0x0039 00057 (mem_slice.go:4)	MOVQ	AX, (SP)
	// 构造数组[10]byte
	0x003d 00061 (mem_slice.go:4)	CALL	runtime.newobject(SB)
    // ...略去无关代码
    // 构造slice { data *byte, len int, cap int}
	0x006a 00106 (mem_slice.go:4)	MOVQ	AX, "".ret+24(SP)
	0x006f 00111 (mem_slice.go:4)	MOVQ	$10, "".ret+32(SP)
	0x0078 00120 (mem_slice.go:4)	MOVQ	$10, "".ret+40(SP)
```


``` go
func f5() []byte {
	tmp := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	ret := tmp[1:9]
	return ret
}
```

``` asm
	// 构造[10]数组,同上
	0x0032 00050 (mem_slice.go:9)	LEAQ	type.[10]uint8(SB), AX
	0x0039 00057 (mem_slice.go:9)	PCDATA	$2, $0
	0x0039 00057 (mem_slice.go:9)	MOVQ	AX, (SP)
	0x003d 00061 (mem_slice.go:9)	CALL	runtime.newobject(SB)
    // ... 中间是给数组赋值的操作略去。
    // 指针+1，即[1:9]的1
	0x0085 00133 (mem_slice.go:10)	INCQ	AX
	// 构造slice，这里len为8，cap为9，len即为[1:9]的9-1=8
	0x0088 00136 (mem_slice.go:10)	MOVQ	AX, "".ret+48(SP)
	0x008d 00141 (mem_slice.go:10)	MOVQ	$8, "".ret+56(SP)
	0x0096 00150 (mem_slice.go:10)	MOVQ	$9, "".ret+64(SP)
```

``` go
func f6() []byte {
	var ret []byte
	ret = append(ret, 'x')
	return ret
}
func growslice(et *_type, old slice, cap int) slice 
```

``` asm
	// 构造空的slice，xorps使x0置为0，这里len=0，cap=0
	// movups 可以移动128位即两个int64,都是0
	0x0032 00050 (mem_slice.go:15)	MOVQ	$0, "".ret+64(SP)
	0x003b 00059 (mem_slice.go:15)	XORPS	X0, X0
	0x003e 00062 (mem_slice.go:15)	MOVUPS	X0, "".ret+72(SP)
    // ... 略去无关代码 
	// AX为*_type,这个_type是byte类型信息
	0x0045 00069 (mem_slice.go:16)	LEAQ	type.uint8(SB), AX
	0x004c 00076 (mem_slice.go:16)	PCDATA	$2, $0
	0x004c 00076 (mem_slice.go:16)	MOVQ	AX, (SP)
	// 传入空slice
	0x0050 00080 (mem_slice.go:16)	XORPS	X0, X0
	0x0053 00083 (mem_slice.go:16)	MOVUPS	X0, 8(SP)
	0x0058 00088 (mem_slice.go:16)	MOVQ	$0, 24(SP)
	// 传入cap，结果的长度是1，因此是1。
	0x0061 00097 (mem_slice.go:16)	MOVQ	$1, 32(SP)
```

``` go
func f7() []byte {
	ret := make([]byte, 10)
	return ret

func makeslice(et *_type, len, cap int) slice 
```

``` asm
	0x002e 00046 (mem_slice.go:21)	LEAQ	type.uint8(SB), AX
	0x0035 00053 (mem_slice.go:21)	PCDATA	$2, $0
	// 传入*_type,len,cap 调用makeslice
	0x0035 00053 (mem_slice.go:21)	MOVQ	AX, (SP)
	0x0039 00057 (mem_slice.go:21)	MOVQ	$10, 8(SP)
	0x0042 00066 (mem_slice.go:21)	MOVQ	$10, 16(SP)
	0x004b 00075 (mem_slice.go:21)	CALL	runtime.makeslice(SB)
```

``` go
func f8() []byte {
	ret := []byte("literal string")
	return ret
}
func stringtoslicbyte(buf *tmpBuf, s string) []byte 
```

``` asm
	// tmpbuf=nil
	0x002e 00046 (mem_slice.go:26)	MOVQ	$0, (SP)
	0x0036 00054 (mem_slice.go:26)	PCDATA	$2, $1
	// 字面值字符串的地址
	0x0036 00054 (mem_slice.go:26)	LEAQ	go.string."literal string"(SB), AX
	0x003d 00061 (mem_slice.go:26)	PCDATA	$2, $0
	// 传入string{data *byte,len int}
	0x003d 00061 (mem_slice.go:26)	MOVQ	AX, 8(SP)
	0x0042 00066 (mem_slice.go:26)	MOVQ	$14, 16(SP)
	// 调用stringtoslicebyte
	0x004b 00075 (mem_slice.go:26)	CALL	runtime.stringtoslicebyte(SB)
```

``` go
func f9() []byte {
	array := [10]byte{'a', 'r', 'r', 'a', 'y'}
	return array[1:5]
}
```

```
    // 这个跟f4一样，看来go会把这两个都当作数组处理了。  
    // 即[]byte声明的时候是数组
    // 可以隐式转换为slice  
	0x0032 00050 (mem_slice.go:31)	LEAQ	type.[10]uint8(SB), AX
	0x0039 00057 (mem_slice.go:31)	PCDATA	$2, $0
	0x0039 00057 (mem_slice.go:31)	MOVQ	AX, (SP)
	// 构造一个array
	0x003d 00061 (mem_slice.go:31)	CALL	runtime.newobject(SB)
    // ... 无关代码略去
    // AX+1 即 [1:5]的1
	0x006c 00108 (mem_slice.go:32)	INCQ	AX
	0x006f 00111 (mem_slice.go:32)	MOVQ	AX, ""..autotmp_3+24(SP)
	// 4即5-1，9为10-1
	0x0074 00116 (mem_slice.go:32)	MOVQ	$4, ""..autotmp_3+32(SP)
	0x007d 00125 (mem_slice.go:32)	MOVQ	$9, ""..autotmp_3+40(SP)
```

