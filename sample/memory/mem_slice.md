slice的分配细节
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

