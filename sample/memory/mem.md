内存分配的上层接口
string 内部结构如下
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



