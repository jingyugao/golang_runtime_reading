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
``` asm
    // 这里是data区域的字符串。
go.string."literial string" SRODATA dupok size=15
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