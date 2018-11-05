# command-line-arguments
"".f4 STEXT size=172 args=0x18 locals=0x38
	0x0000 00000 (mem_slice.go:3)	TEXT	"".f4(SB), $56-24
	0x0000 00000 (mem_slice.go:3)	MOVQ	(TLS), CX
	0x0009 00009 (mem_slice.go:3)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_slice.go:3)	JLS	162
	0x0013 00019 (mem_slice.go:3)	SUBQ	$56, SP
	0x0017 00023 (mem_slice.go:3)	MOVQ	BP, 48(SP)
	0x001c 00028 (mem_slice.go:3)	LEAQ	48(SP), BP
	0x0021 00033 (mem_slice.go:3)	FUNCDATA	$0, gclocals·9783710103695d7171ee820ce562d18d(SB)
	0x0021 00033 (mem_slice.go:3)	FUNCDATA	$1, gclocals·95ba1b998e251f98233f27a52dca8d52(SB)
	0x0021 00033 (mem_slice.go:3)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x0021 00033 (mem_slice.go:3)	PCDATA	$2, $0
	0x0021 00033 (mem_slice.go:3)	PCDATA	$0, $0
	0x0021 00033 (mem_slice.go:3)	MOVQ	$0, "".~r0+64(SP)
	0x002a 00042 (mem_slice.go:3)	XORPS	X0, X0
	0x002d 00045 (mem_slice.go:3)	MOVUPS	X0, "".~r0+72(SP)
	0x0032 00050 (mem_slice.go:4)	PCDATA	$2, $1
	0x0032 00050 (mem_slice.go:4)	LEAQ	type.[10]uint8(SB), AX
	0x0039 00057 (mem_slice.go:4)	PCDATA	$2, $0
	0x0039 00057 (mem_slice.go:4)	MOVQ	AX, (SP)
	// 构造数组[10]byte
	0x003d 00061 (mem_slice.go:4)	CALL	runtime.newobject(SB)
	0x0042 00066 (mem_slice.go:4)	PCDATA	$2, $1
	0x0042 00066 (mem_slice.go:4)	MOVQ	8(SP), AX
	0x0047 00071 (mem_slice.go:4)	PCDATA	$0, $1
	0x0047 00071 (mem_slice.go:4)	MOVQ	AX, ""..autotmp_2+16(SP)
	0x004c 00076 (mem_slice.go:4)	MOVQ	"".statictmp_0(SB), CX
	0x0053 00083 (mem_slice.go:4)	MOVQ	"".statictmp_0+2(SB), DX
	0x005a 00090 (mem_slice.go:4)	MOVQ	CX, (AX)
	0x005d 00093 (mem_slice.go:4)	PCDATA	$2, $0
	0x005d 00093 (mem_slice.go:4)	MOVQ	DX, 2(AX)
	0x0061 00097 (mem_slice.go:4)	PCDATA	$2, $1
	0x0061 00097 (mem_slice.go:4)	PCDATA	$0, $0
	0x0061 00097 (mem_slice.go:4)	MOVQ	""..autotmp_2+16(SP), AX
	0x0066 00102 (mem_slice.go:4)	TESTB	AL, (AX)
	0x0068 00104 (mem_slice.go:4)	JMP	106
	// 构造slice { data *byte, len int, cap int}
	0x006a 00106 (mem_slice.go:4)	MOVQ	AX, "".ret+24(SP)
	0x006f 00111 (mem_slice.go:4)	MOVQ	$10, "".ret+32(SP)
	0x0078 00120 (mem_slice.go:4)	MOVQ	$10, "".ret+40(SP)
	0x0081 00129 (mem_slice.go:5)	PCDATA	$2, $0
	0x0081 00129 (mem_slice.go:5)	PCDATA	$0, $2
	0x0081 00129 (mem_slice.go:5)	MOVQ	AX, "".~r0+64(SP)
	0x0086 00134 (mem_slice.go:5)	MOVQ	$10, "".~r0+72(SP)
	0x008f 00143 (mem_slice.go:5)	MOVQ	$10, "".~r0+80(SP)
	0x0098 00152 (mem_slice.go:5)	MOVQ	48(SP), BP
	0x009d 00157 (mem_slice.go:5)	ADDQ	$56, SP
	0x00a1 00161 (mem_slice.go:5)	RET
	0x00a2 00162 (mem_slice.go:5)	NOP
	0x00a2 00162 (mem_slice.go:3)	PCDATA	$0, $-1
	0x00a2 00162 (mem_slice.go:3)	PCDATA	$2, $-1
	0x00a2 00162 (mem_slice.go:3)	CALL	runtime.morestack_noctxt(SB)
	0x00a7 00167 (mem_slice.go:3)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 0f 86 8f  eH..%....H;a....
	0x0010 00 00 00 48 83 ec 38 48 89 6c 24 30 48 8d 6c 24  ...H..8H.l$0H.l$
	0x0020 30 48 c7 44 24 40 00 00 00 00 0f 57 c0 0f 11 44  0H.D$@.....W...D
	0x0030 24 48 48 8d 05 00 00 00 00 48 89 04 24 e8 00 00  $HH......H..$...
	0x0040 00 00 48 8b 44 24 08 48 89 44 24 10 48 8b 0d 00  ..H.D$.H.D$.H...
	0x0050 00 00 00 48 8b 15 00 00 00 00 48 89 08 48 89 50  ...H......H..H.P
	0x0060 02 48 8b 44 24 10 84 00 eb 00 48 89 44 24 18 48  .H.D$.....H.D$.H
	0x0070 c7 44 24 20 0a 00 00 00 48 c7 44 24 28 0a 00 00  .D$ ....H.D$(...
	0x0080 00 48 89 44 24 40 48 c7 44 24 48 0a 00 00 00 48  .H.D$@H.D$H....H
	0x0090 c7 44 24 50 0a 00 00 00 48 8b 6c 24 30 48 83 c4  .D$P....H.l$0H..
	0x00a0 38 c3 e8 00 00 00 00 e9 54 ff ff ff              8.......T...
	rel 5+4 t=16 TLS+0
	rel 53+4 t=15 type.[10]uint8+0
	rel 62+4 t=8 runtime.newobject+0
	rel 79+4 t=15 "".statictmp_0+0
	rel 86+4 t=15 "".statictmp_0+2
	rel 163+4 t=8 runtime.morestack_noctxt+0
"".f5 STEXT size=202 args=0x18 locals=0x50
	0x0000 00000 (mem_slice.go:8)	TEXT	"".f5(SB), $80-24
	0x0000 00000 (mem_slice.go:8)	MOVQ	(TLS), CX
	0x0009 00009 (mem_slice.go:8)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_slice.go:8)	JLS	192
	0x0013 00019 (mem_slice.go:8)	SUBQ	$80, SP
	0x0017 00023 (mem_slice.go:8)	MOVQ	BP, 72(SP)
	0x001c 00028 (mem_slice.go:8)	LEAQ	72(SP), BP
	0x0021 00033 (mem_slice.go:8)	FUNCDATA	$0, gclocals·9783710103695d7171ee820ce562d18d(SB)
	0x0021 00033 (mem_slice.go:8)	FUNCDATA	$1, gclocals·291e1a88f43c8277f90a067a6c879210(SB)
	0x0021 00033 (mem_slice.go:8)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x0021 00033 (mem_slice.go:8)	PCDATA	$2, $0
	0x0021 00033 (mem_slice.go:8)	PCDATA	$0, $0
	0x0021 00033 (mem_slice.go:8)	MOVQ	$0, "".~r0+88(SP)
	0x002a 00042 (mem_slice.go:8)	XORPS	X0, X0
	0x002d 00045 (mem_slice.go:8)	MOVUPS	X0, "".~r0+96(SP)
	0x0032 00050 (mem_slice.go:9)	PCDATA	$2, $1
	// 构造[10]数组
	0x0032 00050 (mem_slice.go:9)	LEAQ	type.[10]uint8(SB), AX
	0x0039 00057 (mem_slice.go:9)	PCDATA	$2, $0
	0x0039 00057 (mem_slice.go:9)	MOVQ	AX, (SP)
	0x003d 00061 (mem_slice.go:9)	CALL	runtime.newobject(SB)
	0x0042 00066 (mem_slice.go:9)	PCDATA	$2, $1
	0x0042 00066 (mem_slice.go:9)	MOVQ	8(SP), AX
	0x0047 00071 (mem_slice.go:9)	PCDATA	$0, $1
	0x0047 00071 (mem_slice.go:9)	MOVQ	AX, ""..autotmp_3+16(SP)
	0x004c 00076 (mem_slice.go:9)	MOVQ	"".statictmp_1(SB), CX
	0x0053 00083 (mem_slice.go:9)	MOVQ	"".statictmp_1+2(SB), DX
	0x005a 00090 (mem_slice.go:9)	MOVQ	CX, (AX)
	0x005d 00093 (mem_slice.go:9)	PCDATA	$2, $0
	0x005d 00093 (mem_slice.go:9)	MOVQ	DX, 2(AX)
	0x0061 00097 (mem_slice.go:9)	PCDATA	$2, $1
	0x0061 00097 (mem_slice.go:9)	PCDATA	$0, $0
	0x0061 00097 (mem_slice.go:9)	MOVQ	""..autotmp_3+16(SP), AX
	0x0066 00102 (mem_slice.go:9)	TESTB	AL, (AX)
	0x0068 00104 (mem_slice.go:9)	JMP	106
	0x006a 00106 (mem_slice.go:9)	MOVQ	AX, "".tmp+24(SP)
	0x006f 00111 (mem_slice.go:9)	MOVQ	$10, "".tmp+32(SP)
	0x0078 00120 (mem_slice.go:9)	MOVQ	$10, "".tmp+40(SP)
	0x0081 00129 (mem_slice.go:10)	JMP	131
	0x0083 00131 (mem_slice.go:10)	PCDATA	$2, $-2
	0x0083 00131 (mem_slice.go:10)	PCDATA	$0, $-2
	0x0083 00131 (mem_slice.go:10)	JMP	133
	0x0085 00133 (mem_slice.go:10)	PCDATA	$2, $1
	0x0085 00133 (mem_slice.go:10)	PCDATA	$0, $0
	// 指针+1，即[1:9]的1
	0x0085 00133 (mem_slice.go:10)	INCQ	AX
	// 构造slice，这里len为8，cap为9，len即为[1:9]的9-1=8
	0x0088 00136 (mem_slice.go:10)	MOVQ	AX, "".ret+48(SP)
	0x008d 00141 (mem_slice.go:10)	MOVQ	$8, "".ret+56(SP)
	0x0096 00150 (mem_slice.go:10)	MOVQ	$9, "".ret+64(SP)
	0x009f 00159 (mem_slice.go:11)	PCDATA	$2, $0
	0x009f 00159 (mem_slice.go:11)	PCDATA	$0, $2
	0x009f 00159 (mem_slice.go:11)	MOVQ	AX, "".~r0+88(SP)
	0x00a4 00164 (mem_slice.go:11)	MOVQ	$8, "".~r0+96(SP)
	0x00ad 00173 (mem_slice.go:11)	MOVQ	$9, "".~r0+104(SP)
	0x00b6 00182 (mem_slice.go:11)	MOVQ	72(SP), BP
	0x00bb 00187 (mem_slice.go:11)	ADDQ	$80, SP
	0x00bf 00191 (mem_slice.go:11)	RET
	0x00c0 00192 (mem_slice.go:11)	NOP
	0x00c0 00192 (mem_slice.go:8)	PCDATA	$0, $-1
	0x00c0 00192 (mem_slice.go:8)	PCDATA	$2, $-1
	0x00c0 00192 (mem_slice.go:8)	CALL	runtime.morestack_noctxt(SB)
	0x00c5 00197 (mem_slice.go:8)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 0f 86 ad  eH..%....H;a....
	0x0010 00 00 00 48 83 ec 50 48 89 6c 24 48 48 8d 6c 24  ...H..PH.l$HH.l$
	0x0020 48 48 c7 44 24 58 00 00 00 00 0f 57 c0 0f 11 44  HH.D$X.....W...D
	0x0030 24 60 48 8d 05 00 00 00 00 48 89 04 24 e8 00 00  $`H......H..$...
	0x0040 00 00 48 8b 44 24 08 48 89 44 24 10 48 8b 0d 00  ..H.D$.H.D$.H...
	0x0050 00 00 00 48 8b 15 00 00 00 00 48 89 08 48 89 50  ...H......H..H.P
	0x0060 02 48 8b 44 24 10 84 00 eb 00 48 89 44 24 18 48  .H.D$.....H.D$.H
	0x0070 c7 44 24 20 0a 00 00 00 48 c7 44 24 28 0a 00 00  .D$ ....H.D$(...
	0x0080 00 eb 00 eb 00 48 ff c0 48 89 44 24 30 48 c7 44  .....H..H.D$0H.D
	0x0090 24 38 08 00 00 00 48 c7 44 24 40 09 00 00 00 48  $8....H.D$@....H
	0x00a0 89 44 24 58 48 c7 44 24 60 08 00 00 00 48 c7 44  .D$XH.D$`....H.D
	0x00b0 24 68 09 00 00 00 48 8b 6c 24 48 48 83 c4 50 c3  $h....H.l$HH..P.
	0x00c0 e8 00 00 00 00 e9 36 ff ff ff                    ......6...
	rel 5+4 t=16 TLS+0
	rel 53+4 t=15 type.[10]uint8+0
	rel 62+4 t=8 runtime.newobject+0
	rel 79+4 t=15 "".statictmp_1+0
	rel 86+4 t=15 "".statictmp_1+2
	rel 193+4 t=8 runtime.morestack_noctxt+0
"".f6 STEXT size=184 args=0x18 locals=0x60
	0x0000 00000 (mem_slice.go:14)	TEXT	"".f6(SB), $96-24
	0x0000 00000 (mem_slice.go:14)	MOVQ	(TLS), CX
	0x0009 00009 (mem_slice.go:14)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_slice.go:14)	JLS	174
	0x0013 00019 (mem_slice.go:14)	SUBQ	$96, SP
	0x0017 00023 (mem_slice.go:14)	MOVQ	BP, 88(SP)
	0x001c 00028 (mem_slice.go:14)	LEAQ	88(SP), BP
	0x0021 00033 (mem_slice.go:14)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x0021 00033 (mem_slice.go:14)	FUNCDATA	$1, gclocals·15b76348caca8a511afecadf603e9401(SB)
	0x0021 00033 (mem_slice.go:14)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x0021 00033 (mem_slice.go:14)	PCDATA	$2, $0
	0x0021 00033 (mem_slice.go:14)	PCDATA	$0, $0
	0x0021 00033 (mem_slice.go:14)	MOVQ	$0, "".~r0+104(SP)
	0x002a 00042 (mem_slice.go:14)	XORPS	X0, X0
	0x002d 00045 (mem_slice.go:14)	MOVUPS	X0, "".~r0+112(SP)
	// 构造空的slice，xorps使x0置为0，这里len=0，cap=0
	// movups 可以移动128位即两个int
	0x0032 00050 (mem_slice.go:15)	MOVQ	$0, "".ret+64(SP)
	0x003b 00059 (mem_slice.go:15)	XORPS	X0, X0
	0x003e 00062 (mem_slice.go:15)	MOVUPS	X0, "".ret+72(SP)
	0x0043 00067 (mem_slice.go:16)	PCDATA	$2, $-2
	0x0043 00067 (mem_slice.go:16)	PCDATA	$0, $-2
	0x0043 00067 (mem_slice.go:16)	JMP	69
	0x0045 00069 (mem_slice.go:16)	PCDATA	$2, $1
	0x0045 00069 (mem_slice.go:16)	PCDATA	$0, $0
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
	
	0x006a 00106 (mem_slice.go:16)	CALL	runtime.growslice(SB)
	0x006f 00111 (mem_slice.go:16)	PCDATA	$2, $1
	0x006f 00111 (mem_slice.go:16)	MOVQ	40(SP), AX
	0x0074 00116 (mem_slice.go:16)	MOVQ	48(SP), CX
	0x0079 00121 (mem_slice.go:16)	MOVQ	56(SP), DX
	0x007e 00126 (mem_slice.go:16)	INCQ	CX
	0x0081 00129 (mem_slice.go:16)	JMP	131
	0x0083 00131 (mem_slice.go:16)	MOVB	$120, (AX)
	0x0086 00134 (mem_slice.go:16)	MOVQ	AX, "".ret+64(SP)
	0x008b 00139 (mem_slice.go:16)	MOVQ	CX, "".ret+72(SP)
	0x0090 00144 (mem_slice.go:16)	MOVQ	DX, "".ret+80(SP)
	0x0095 00149 (mem_slice.go:17)	PCDATA	$2, $0
	0x0095 00149 (mem_slice.go:17)	PCDATA	$0, $1
	0x0095 00149 (mem_slice.go:17)	MOVQ	AX, "".~r0+104(SP)
	0x009a 00154 (mem_slice.go:17)	MOVQ	CX, "".~r0+112(SP)
	0x009f 00159 (mem_slice.go:17)	MOVQ	DX, "".~r0+120(SP)
	0x00a4 00164 (mem_slice.go:17)	MOVQ	88(SP), BP
	0x00a9 00169 (mem_slice.go:17)	ADDQ	$96, SP
	0x00ad 00173 (mem_slice.go:17)	RET
	0x00ae 00174 (mem_slice.go:17)	NOP
	0x00ae 00174 (mem_slice.go:14)	PCDATA	$0, $-1
	0x00ae 00174 (mem_slice.go:14)	PCDATA	$2, $-1
	0x00ae 00174 (mem_slice.go:14)	CALL	runtime.morestack_noctxt(SB)
	0x00b3 00179 (mem_slice.go:14)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 0f 86 9b  eH..%....H;a....
	0x0010 00 00 00 48 83 ec 60 48 89 6c 24 58 48 8d 6c 24  ...H..`H.l$XH.l$
	0x0020 58 48 c7 44 24 68 00 00 00 00 0f 57 c0 0f 11 44  XH.D$h.....W...D
	0x0030 24 70 48 c7 44 24 40 00 00 00 00 0f 57 c0 0f 11  $pH.D$@.....W...
	0x0040 44 24 48 eb 00 48 8d 05 00 00 00 00 48 89 04 24  D$H..H......H..$
	0x0050 0f 57 c0 0f 11 44 24 08 48 c7 44 24 18 00 00 00  .W...D$.H.D$....
	0x0060 00 48 c7 44 24 20 01 00 00 00 e8 00 00 00 00 48  .H.D$ .........H
	0x0070 8b 44 24 28 48 8b 4c 24 30 48 8b 54 24 38 48 ff  .D$(H.L$0H.T$8H.
	0x0080 c1 eb 00 c6 00 78 48 89 44 24 40 48 89 4c 24 48  .....xH.D$@H.L$H
	0x0090 48 89 54 24 50 48 89 44 24 68 48 89 4c 24 70 48  H.T$PH.D$hH.L$pH
	0x00a0 89 54 24 78 48 8b 6c 24 58 48 83 c4 60 c3 e8 00  .T$xH.l$XH..`...
	0x00b0 00 00 00 e9 48 ff ff ff                          ....H...
	rel 5+4 t=16 TLS+0
	rel 72+4 t=15 type.uint8+0
	rel 107+4 t=8 runtime.growslice+0
	rel 175+4 t=8 runtime.morestack_noctxt+0
"".f7 STEXT size=145 args=0x18 locals=0x50
	0x0000 00000 (mem_slice.go:20)	TEXT	"".f7(SB), $80-24
	0x0000 00000 (mem_slice.go:20)	MOVQ	(TLS), CX
	0x0009 00009 (mem_slice.go:20)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_slice.go:20)	JLS	135
	0x000f 00015 (mem_slice.go:20)	SUBQ	$80, SP
	0x0013 00019 (mem_slice.go:20)	MOVQ	BP, 72(SP)
	0x0018 00024 (mem_slice.go:20)	LEAQ	72(SP), BP
	0x001d 00029 (mem_slice.go:20)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_slice.go:20)	FUNCDATA	$1, gclocals·15b76348caca8a511afecadf603e9401(SB)
	0x001d 00029 (mem_slice.go:20)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_slice.go:20)	PCDATA	$2, $0
	0x001d 00029 (mem_slice.go:20)	PCDATA	$0, $0
	0x001d 00029 (mem_slice.go:20)	MOVQ	$0, "".~r0+88(SP)
	0x0026 00038 (mem_slice.go:20)	XORPS	X0, X0
	0x0029 00041 (mem_slice.go:20)	MOVUPS	X0, "".~r0+96(SP)
	0x002e 00046 (mem_slice.go:21)	PCDATA	$2, $1
	0x002e 00046 (mem_slice.go:21)	LEAQ	type.uint8(SB), AX
	0x0035 00053 (mem_slice.go:21)	PCDATA	$2, $0
	// 传入*_type,len,cap 调用makeslice
	0x0035 00053 (mem_slice.go:21)	MOVQ	AX, (SP)
	0x0039 00057 (mem_slice.go:21)	MOVQ	$10, 8(SP)
	0x0042 00066 (mem_slice.go:21)	MOVQ	$10, 16(SP)
	0x004b 00075 (mem_slice.go:21)	CALL	runtime.makeslice(SB)
	0x0050 00080 (mem_slice.go:21)	PCDATA	$2, $1
	0x0050 00080 (mem_slice.go:21)	MOVQ	24(SP), AX
	0x0055 00085 (mem_slice.go:21)	MOVQ	32(SP), CX
	0x005a 00090 (mem_slice.go:21)	MOVQ	40(SP), DX
	0x005f 00095 (mem_slice.go:21)	MOVQ	AX, "".ret+48(SP)
	0x0064 00100 (mem_slice.go:21)	MOVQ	CX, "".ret+56(SP)
	0x0069 00105 (mem_slice.go:21)	MOVQ	DX, "".ret+64(SP)
	0x006e 00110 (mem_slice.go:22)	PCDATA	$2, $0
	0x006e 00110 (mem_slice.go:22)	PCDATA	$0, $1
	0x006e 00110 (mem_slice.go:22)	MOVQ	AX, "".~r0+88(SP)
	0x0073 00115 (mem_slice.go:22)	MOVQ	CX, "".~r0+96(SP)
	0x0078 00120 (mem_slice.go:22)	MOVQ	DX, "".~r0+104(SP)
	0x007d 00125 (mem_slice.go:22)	MOVQ	72(SP), BP
	0x0082 00130 (mem_slice.go:22)	ADDQ	$80, SP
	0x0086 00134 (mem_slice.go:22)	RET
	0x0087 00135 (mem_slice.go:22)	NOP
	0x0087 00135 (mem_slice.go:20)	PCDATA	$0, $-1
	0x0087 00135 (mem_slice.go:20)	PCDATA	$2, $-1
	0x0087 00135 (mem_slice.go:20)	CALL	runtime.morestack_noctxt(SB)
	0x008c 00140 (mem_slice.go:20)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 78 48  eH..%....H;a.vxH
	0x0010 83 ec 50 48 89 6c 24 48 48 8d 6c 24 48 48 c7 44  ..PH.l$HH.l$HH.D
	0x0020 24 58 00 00 00 00 0f 57 c0 0f 11 44 24 60 48 8d  $X.....W...D$`H.
	0x0030 05 00 00 00 00 48 89 04 24 48 c7 44 24 08 0a 00  .....H..$H.D$...
	0x0040 00 00 48 c7 44 24 10 0a 00 00 00 e8 00 00 00 00  ..H.D$..........
	0x0050 48 8b 44 24 18 48 8b 4c 24 20 48 8b 54 24 28 48  H.D$.H.L$ H.T$(H
	0x0060 89 44 24 30 48 89 4c 24 38 48 89 54 24 40 48 89  .D$0H.L$8H.T$@H.
	0x0070 44 24 58 48 89 4c 24 60 48 89 54 24 68 48 8b 6c  D$XH.L$`H.T$hH.l
	0x0080 24 48 48 83 c4 50 c3 e8 00 00 00 00 e9 6f ff ff  $HH..P.......o..
	0x0090 ff                                               .
	rel 5+4 t=16 TLS+0
	rel 49+4 t=15 type.uint8+0
	rel 76+4 t=8 runtime.makeslice+0
	rel 136+4 t=8 runtime.morestack_noctxt+0
"".f8 STEXT size=145 args=0x18 locals=0x50
	0x0000 00000 (mem_slice.go:25)	TEXT	"".f8(SB), $80-24
	0x0000 00000 (mem_slice.go:25)	MOVQ	(TLS), CX
	0x0009 00009 (mem_slice.go:25)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_slice.go:25)	JLS	135
	0x000f 00015 (mem_slice.go:25)	SUBQ	$80, SP
	0x0013 00019 (mem_slice.go:25)	MOVQ	BP, 72(SP)
	0x0018 00024 (mem_slice.go:25)	LEAQ	72(SP), BP
	0x001d 00029 (mem_slice.go:25)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_slice.go:25)	FUNCDATA	$1, gclocals·15b76348caca8a511afecadf603e9401(SB)
	0x001d 00029 (mem_slice.go:25)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_slice.go:25)	PCDATA	$2, $0
	0x001d 00029 (mem_slice.go:25)	PCDATA	$0, $0
	0x001d 00029 (mem_slice.go:25)	MOVQ	$0, "".~r0+88(SP)
	0x0026 00038 (mem_slice.go:25)	XORPS	X0, X0
	0x0029 00041 (mem_slice.go:25)	MOVUPS	X0, "".~r0+96(SP)
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
	0x0050 00080 (mem_slice.go:26)	PCDATA	$2, $1
	0x0050 00080 (mem_slice.go:26)	MOVQ	24(SP), AX
	0x0055 00085 (mem_slice.go:26)	MOVQ	32(SP), CX
	0x005a 00090 (mem_slice.go:26)	MOVQ	40(SP), DX
	0x005f 00095 (mem_slice.go:26)	MOVQ	AX, "".ret+48(SP)
	0x0064 00100 (mem_slice.go:26)	MOVQ	CX, "".ret+56(SP)
	0x0069 00105 (mem_slice.go:26)	MOVQ	DX, "".ret+64(SP)
	0x006e 00110 (mem_slice.go:27)	PCDATA	$2, $0
	0x006e 00110 (mem_slice.go:27)	PCDATA	$0, $1
	0x006e 00110 (mem_slice.go:27)	MOVQ	AX, "".~r0+88(SP)
	0x0073 00115 (mem_slice.go:27)	MOVQ	CX, "".~r0+96(SP)
	0x0078 00120 (mem_slice.go:27)	MOVQ	DX, "".~r0+104(SP)
	0x007d 00125 (mem_slice.go:27)	MOVQ	72(SP), BP
	0x0082 00130 (mem_slice.go:27)	ADDQ	$80, SP
	0x0086 00134 (mem_slice.go:27)	RET
	0x0087 00135 (mem_slice.go:27)	NOP
	0x0087 00135 (mem_slice.go:25)	PCDATA	$0, $-1
	0x0087 00135 (mem_slice.go:25)	PCDATA	$2, $-1
	0x0087 00135 (mem_slice.go:25)	CALL	runtime.morestack_noctxt(SB)
	0x008c 00140 (mem_slice.go:25)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 78 48  eH..%....H;a.vxH
	0x0010 83 ec 50 48 89 6c 24 48 48 8d 6c 24 48 48 c7 44  ..PH.l$HH.l$HH.D
	0x0020 24 58 00 00 00 00 0f 57 c0 0f 11 44 24 60 48 c7  $X.....W...D$`H.
	0x0030 04 24 00 00 00 00 48 8d 05 00 00 00 00 48 89 44  .$....H......H.D
	0x0040 24 08 48 c7 44 24 10 0e 00 00 00 e8 00 00 00 00  $.H.D$..........
	0x0050 48 8b 44 24 18 48 8b 4c 24 20 48 8b 54 24 28 48  H.D$.H.L$ H.T$(H
	0x0060 89 44 24 30 48 89 4c 24 38 48 89 54 24 40 48 89  .D$0H.L$8H.T$@H.
	0x0070 44 24 58 48 89 4c 24 60 48 89 54 24 68 48 8b 6c  D$XH.L$`H.T$hH.l
	0x0080 24 48 48 83 c4 50 c3 e8 00 00 00 00 e9 6f ff ff  $HH..P.......o..
	0x0090 ff                                               .
	rel 5+4 t=16 TLS+0
	rel 57+4 t=15 go.string."literal string"+0
	rel 76+4 t=8 runtime.stringtoslicebyte+0
	rel 136+4 t=8 runtime.morestack_noctxt+0
"".f9 STEXT size=177 args=0x18 locals=0x38
	0x0000 00000 (mem_slice.go:30)	TEXT	"".f9(SB), $56-24
	0x0000 00000 (mem_slice.go:30)	MOVQ	(TLS), CX
	0x0009 00009 (mem_slice.go:30)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_slice.go:30)	JLS	167
	0x0013 00019 (mem_slice.go:30)	SUBQ	$56, SP
	0x0017 00023 (mem_slice.go:30)	MOVQ	BP, 48(SP)
	0x001c 00028 (mem_slice.go:30)	LEAQ	48(SP), BP
	0x0021 00033 (mem_slice.go:30)	FUNCDATA	$0, gclocals·9783710103695d7171ee820ce562d18d(SB)
	0x0021 00033 (mem_slice.go:30)	FUNCDATA	$1, gclocals·95ba1b998e251f98233f27a52dca8d52(SB)
	0x0021 00033 (mem_slice.go:30)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x0021 00033 (mem_slice.go:30)	PCDATA	$2, $0
	0x0021 00033 (mem_slice.go:30)	PCDATA	$0, $0
	0x0021 00033 (mem_slice.go:30)	MOVQ	$0, "".~r0+64(SP)
	0x002a 00042 (mem_slice.go:30)	XORPS	X0, X0
	0x002d 00045 (mem_slice.go:30)	MOVUPS	X0, "".~r0+72(SP)
	0x0032 00050 (mem_slice.go:31)	PCDATA	$2, $1
	0x0032 00050 (mem_slice.go:31)	LEAQ	type.[10]uint8(SB), AX
	0x0039 00057 (mem_slice.go:31)	PCDATA	$2, $0
	0x0039 00057 (mem_slice.go:31)	MOVQ	AX, (SP)
	// 构造一个array
	0x003d 00061 (mem_slice.go:31)	CALL	runtime.newobject(SB)
	0x0042 00066 (mem_slice.go:31)	PCDATA	$2, $1
	0x0042 00066 (mem_slice.go:31)	MOVQ	8(SP), AX
	0x0047 00071 (mem_slice.go:31)	PCDATA	$0, $1
	0x0047 00071 (mem_slice.go:31)	MOVQ	AX, "".&array+16(SP)
	0x004c 00076 (mem_slice.go:31)	MOVQ	"".statictmp_2(SB), CX
	0x0053 00083 (mem_slice.go:31)	MOVQ	"".statictmp_2+2(SB), DX
	0x005a 00090 (mem_slice.go:31)	MOVQ	CX, (AX)
	0x005d 00093 (mem_slice.go:31)	PCDATA	$2, $0
	0x005d 00093 (mem_slice.go:31)	MOVQ	DX, 2(AX)
	0x0061 00097 (mem_slice.go:32)	PCDATA	$2, $1
	0x0061 00097 (mem_slice.go:32)	PCDATA	$0, $0
	0x0061 00097 (mem_slice.go:32)	MOVQ	"".&array+16(SP), AX
	0x0066 00102 (mem_slice.go:32)	TESTB	AL, (AX)
	0x0068 00104 (mem_slice.go:32)	JMP	106
	0x006a 00106 (mem_slice.go:32)	PCDATA	$2, $-2
	0x006a 00106 (mem_slice.go:32)	PCDATA	$0, $-2
	0x006a 00106 (mem_slice.go:32)	JMP	108
	0x006c 00108 (mem_slice.go:32)	PCDATA	$2, $1
	0x006c 00108 (mem_slice.go:32)	PCDATA	$0, $0
	// AX+1 即 [1:5]的1
	0x006c 00108 (mem_slice.go:32)	INCQ	AX
	0x006f 00111 (mem_slice.go:32)	MOVQ	AX, ""..autotmp_3+24(SP)
	// 4即5-1，9为10-1
	0x0074 00116 (mem_slice.go:32)	MOVQ	$4, ""..autotmp_3+32(SP)
	0x007d 00125 (mem_slice.go:32)	MOVQ	$9, ""..autotmp_3+40(SP)
	0x0086 00134 (mem_slice.go:32)	PCDATA	$2, $0
	0x0086 00134 (mem_slice.go:32)	PCDATA	$0, $2
	0x0086 00134 (mem_slice.go:32)	MOVQ	AX, "".~r0+64(SP)
	0x008b 00139 (mem_slice.go:32)	MOVQ	$4, "".~r0+72(SP)
	0x0094 00148 (mem_slice.go:32)	MOVQ	$9, "".~r0+80(SP)
	0x009d 00157 (mem_slice.go:32)	MOVQ	48(SP), BP
	0x00a2 00162 (mem_slice.go:32)	ADDQ	$56, SP
	0x00a6 00166 (mem_slice.go:32)	RET
	0x00a7 00167 (mem_slice.go:32)	NOP
	0x00a7 00167 (mem_slice.go:30)	PCDATA	$0, $-1
	0x00a7 00167 (mem_slice.go:30)	PCDATA	$2, $-1
	0x00a7 00167 (mem_slice.go:30)	CALL	runtime.morestack_noctxt(SB)
	0x00ac 00172 (mem_slice.go:30)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 0f 86 94  eH..%....H;a....
	0x0010 00 00 00 48 83 ec 38 48 89 6c 24 30 48 8d 6c 24  ...H..8H.l$0H.l$
	0x0020 30 48 c7 44 24 40 00 00 00 00 0f 57 c0 0f 11 44  0H.D$@.....W...D
	0x0030 24 48 48 8d 05 00 00 00 00 48 89 04 24 e8 00 00  $HH......H..$...
	0x0040 00 00 48 8b 44 24 08 48 89 44 24 10 48 8b 0d 00  ..H.D$.H.D$.H...
	0x0050 00 00 00 48 8b 15 00 00 00 00 48 89 08 48 89 50  ...H......H..H.P
	0x0060 02 48 8b 44 24 10 84 00 eb 00 eb 00 48 ff c0 48  .H.D$.......H..H
	0x0070 89 44 24 18 48 c7 44 24 20 04 00 00 00 48 c7 44  .D$.H.D$ ....H.D
	0x0080 24 28 09 00 00 00 48 89 44 24 40 48 c7 44 24 48  $(....H.D$@H.D$H
	0x0090 04 00 00 00 48 c7 44 24 50 09 00 00 00 48 8b 6c  ....H.D$P....H.l
	0x00a0 24 30 48 83 c4 38 c3 e8 00 00 00 00 e9 4f ff ff  $0H..8.......O..
	0x00b0 ff                                               .
	rel 5+4 t=16 TLS+0
	rel 53+4 t=15 type.[10]uint8+0
	rel 62+4 t=8 runtime.newobject+0
	rel 79+4 t=15 "".statictmp_2+0
	rel 86+4 t=15 "".statictmp_2+2
	rel 168+4 t=8 runtime.morestack_noctxt+0
"".init STEXT size=95 args=0x0 locals=0x8
	0x0000 00000 (<autogenerated>:1)	TEXT	"".init(SB), $8-0
	0x0000 00000 (<autogenerated>:1)	MOVQ	(TLS), CX
	0x0009 00009 (<autogenerated>:1)	CMPQ	SP, 16(CX)
	0x000d 00013 (<autogenerated>:1)	JLS	88
	0x000f 00015 (<autogenerated>:1)	SUBQ	$8, SP
	0x0013 00019 (<autogenerated>:1)	MOVQ	BP, (SP)
	0x0017 00023 (<autogenerated>:1)	LEAQ	(SP), BP
	0x001b 00027 (<autogenerated>:1)	FUNCDATA	$0, gclocals·33cdeccccebe80329f1fdbee7f5874cb(SB)
	0x001b 00027 (<autogenerated>:1)	FUNCDATA	$1, gclocals·33cdeccccebe80329f1fdbee7f5874cb(SB)
	0x001b 00027 (<autogenerated>:1)	FUNCDATA	$3, gclocals·33cdeccccebe80329f1fdbee7f5874cb(SB)
	0x001b 00027 (<autogenerated>:1)	PCDATA	$2, $0
	0x001b 00027 (<autogenerated>:1)	PCDATA	$0, $0
	0x001b 00027 (<autogenerated>:1)	CMPB	"".initdone·(SB), $1
	0x0022 00034 (<autogenerated>:1)	JHI	38
	0x0024 00036 (<autogenerated>:1)	JMP	47
	0x0026 00038 (<autogenerated>:1)	PCDATA	$2, $-2
	0x0026 00038 (<autogenerated>:1)	PCDATA	$0, $-2
	0x0026 00038 (<autogenerated>:1)	MOVQ	(SP), BP
	0x002a 00042 (<autogenerated>:1)	ADDQ	$8, SP
	0x002e 00046 (<autogenerated>:1)	RET
	0x002f 00047 (<autogenerated>:1)	PCDATA	$2, $0
	0x002f 00047 (<autogenerated>:1)	PCDATA	$0, $0
	0x002f 00047 (<autogenerated>:1)	CMPB	"".initdone·(SB), $1
	0x0036 00054 (<autogenerated>:1)	JEQ	58
	0x0038 00056 (<autogenerated>:1)	JMP	65
	0x003a 00058 (<autogenerated>:1)	CALL	runtime.throwinit(SB)
	0x003f 00063 (<autogenerated>:1)	UNDEF
	0x0041 00065 (<autogenerated>:1)	MOVB	$1, "".initdone·(SB)
	0x0048 00072 (<autogenerated>:1)	MOVB	$2, "".initdone·(SB)
	0x004f 00079 (<autogenerated>:1)	MOVQ	(SP), BP
	0x0053 00083 (<autogenerated>:1)	ADDQ	$8, SP
	0x0057 00087 (<autogenerated>:1)	RET
	0x0058 00088 (<autogenerated>:1)	NOP
	0x0058 00088 (<autogenerated>:1)	PCDATA	$0, $-1
	0x0058 00088 (<autogenerated>:1)	PCDATA	$2, $-1
	0x0058 00088 (<autogenerated>:1)	CALL	runtime.morestack_noctxt(SB)
	0x005d 00093 (<autogenerated>:1)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 49 48  eH..%....H;a.vIH
	0x0010 83 ec 08 48 89 2c 24 48 8d 2c 24 80 3d 00 00 00  ...H.,$H.,$.=...
	0x0020 00 01 77 02 eb 09 48 8b 2c 24 48 83 c4 08 c3 80  ..w...H.,$H.....
	0x0030 3d 00 00 00 00 01 74 02 eb 07 e8 00 00 00 00 0f  =.....t.........
	0x0040 0b c6 05 00 00 00 00 01 c6 05 00 00 00 00 02 48  ...............H
	0x0050 8b 2c 24 48 83 c4 08 c3 e8 00 00 00 00 eb a1     .,$H...........
	rel 5+4 t=16 TLS+0
	rel 29+4 t=15 "".initdone·+-1
	rel 49+4 t=15 "".initdone·+-1
	rel 59+4 t=8 runtime.throwinit+0
	rel 67+4 t=15 "".initdone·+-1
	rel 74+4 t=15 "".initdone·+-1
	rel 89+4 t=8 runtime.morestack_noctxt+0
go.cuinfo.producer.main SDWARFINFO dupok size=0
	0x0000 2d 4e 20 2d 6c                                   -N -l
go.loc."".f4 SDWARFLOC size=0
go.info."".f4 SDWARFINFO size=57
	0x0000 02 22 22 2e 66 34 00 00 00 00 00 00 00 00 00 00  ."".f4..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 04 00 00 00 00 02 91 58 0e 7e 72 30 00  et........X.~r0.
	0x0030 01 03 00 00 00 00 01 9c 00                       .........
	rel 7+8 t=1 "".f4+0
	rel 15+8 t=1 "".f4+172
	rel 25+4 t=29 gofile..mem_slice.go+0
	rel 36+4 t=28 go.info.[]uint8+0
	rel 50+4 t=28 go.info.[]uint8+0
go.range."".f4 SDWARFRANGE size=0
go.isstmt."".f4 SDWARFMISC size=0
	0x0000 04 13 04 0e 03 09 01 08 02 07 01 48 02 05 01 1c  ...........H....
	0x0010 02 0a 00                                         ...
go.loc."".f5 SDWARFLOC size=0
go.info."".f5 SDWARFINFO size=70
	0x0000 02 22 22 2e 66 35 00 00 00 00 00 00 00 00 00 00  ."".f5..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 0a 00 00 00 00 02 91 58 09 74 6d 70 00  et........X.tmp.
	0x0030 09 00 00 00 00 02 91 40 0e 7e 72 30 00 01 08 00  .......@.~r0....
	0x0040 00 00 00 01 9c 00                                ......
	rel 7+8 t=1 "".f5+0
	rel 15+8 t=1 "".f5+202
	rel 25+4 t=29 gofile..mem_slice.go+0
	rel 36+4 t=28 go.info.[]uint8+0
	rel 49+4 t=28 go.info.[]uint8+0
	rel 63+4 t=28 go.info.[]uint8+0
go.range."".f5 SDWARFRANGE size=0
go.isstmt."".f5 SDWARFMISC size=0
	0x0000 04 13 04 0e 03 09 01 08 02 07 01 48 02 02 01 1c  ...........H....
	0x0010 02 05 01 1c 02 0a 00                             .......
go.loc."".f6 SDWARFLOC size=0
go.info."".f6 SDWARFINFO size=57
	0x0000 02 22 22 2e 66 36 00 00 00 00 00 00 00 00 00 00  ."".f6..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 0f 00 00 00 00 02 91 58 0e 7e 72 30 00  et........X.~r0.
	0x0030 01 0e 00 00 00 00 01 9c 00                       .........
	rel 7+8 t=1 "".f6+0
	rel 15+8 t=1 "".f6+184
	rel 25+4 t=29 gofile..mem_slice.go+0
	rel 36+4 t=28 go.info.[]uint8+0
	rel 50+4 t=28 go.info.[]uint8+0
go.range."".f6 SDWARFRANGE size=0
go.isstmt."".f6 SDWARFMISC size=0
	0x0000 04 13 04 0e 03 09 01 08 02 09 01 08 02 02 01 50  ...............P
	0x0010 02 05 01 14 02 0a 00                             .......
go.loc."".f7 SDWARFLOC size=0
go.info."".f7 SDWARFINFO size=57
	0x0000 02 22 22 2e 66 37 00 00 00 00 00 00 00 00 00 00  ."".f7..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 15 00 00 00 00 02 91 58 0e 7e 72 30 00  et........X.~r0.
	0x0030 01 14 00 00 00 00 01 9c 00                       .........
	rel 7+8 t=1 "".f7+0
	rel 15+8 t=1 "".f7+145
	rel 25+4 t=29 gofile..mem_slice.go+0
	rel 36+4 t=28 go.info.[]uint8+0
	rel 50+4 t=28 go.info.[]uint8+0
go.range."".f7 SDWARFRANGE size=0
go.isstmt."".f7 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 09 01 08 02 07 01 39 02 05 01 14  ...........9....
	0x0010 02 0a 00                                         ...
go.string."literal string" SRODATA dupok size=14
	0x0000 6c 69 74 65 72 61 6c 20 73 74 72 69 6e 67        literal string
go.loc."".f8 SDWARFLOC size=0
go.info."".f8 SDWARFINFO size=57
	0x0000 02 22 22 2e 66 38 00 00 00 00 00 00 00 00 00 00  ."".f8..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 1a 00 00 00 00 02 91 58 0e 7e 72 30 00  et........X.~r0.
	0x0030 01 19 00 00 00 00 01 9c 00                       .........
	rel 7+8 t=1 "".f8+0
	rel 15+8 t=1 "".f8+145
	rel 25+4 t=29 gofile..mem_slice.go+0
	rel 36+4 t=28 go.info.[]uint8+0
	rel 50+4 t=28 go.info.[]uint8+0
go.range."".f8 SDWARFRANGE size=0
go.isstmt."".f8 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 09 01 08 02 08 01 38 02 05 01 14  ...........8....
	0x0010 02 0a 00                                         ...
go.loc."".f9 SDWARFLOC size=0
go.info."".f9 SDWARFINFO size=60
	0x0000 02 22 22 2e 66 39 00 00 00 00 00 00 00 00 00 00  ."".f9..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 26  ...............&
	0x0020 61 72 72 61 79 00 1f 00 00 00 00 02 91 50 0e 7e  array........P.~
	0x0030 72 30 00 01 1e 00 00 00 00 01 9c 00              r0..........
	rel 7+8 t=1 "".f9+0
	rel 15+8 t=1 "".f9+177
	rel 25+4 t=29 gofile..mem_slice.go+0
	rel 39+4 t=28 go.info.*[10]uint8+0
	rel 53+4 t=28 go.info.[]uint8+0
go.range."".f9 SDWARFRANGE size=0
go.isstmt."".f9 SDWARFMISC size=0
	0x0000 04 13 04 0e 03 09 01 08 02 07 01 28 02 05 01 06  ...........(....
	0x0010 02 03 01 38 02 0a 00                             ...8...
go.loc."".init SDWARFLOC size=0
go.info."".init SDWARFINFO size=33
	0x0000 02 22 22 2e 69 6e 69 74 00 00 00 00 00 00 00 00  ."".init........
	0x0010 00 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01  ................
	0x0020 00                                               .
	rel 9+8 t=1 "".init+0
	rel 17+8 t=1 "".init+95
	rel 27+4 t=29 gofile..<autogenerated>+0
go.range."".init SDWARFRANGE size=0
go.isstmt."".init SDWARFMISC size=0
	0x0000 04 0f 04 0c 03 07 01 04 02 09 01 10 02 09 01 10  ................
	0x0010 02 07 00                                         ...
"".statictmp_0 SRODATA size=10
	0x0000 73 6f 6d 65 20 62 79 74 65 73                    some bytes
"".statictmp_1 SRODATA size=10
	0x0000 73 6f 6d 65 20 62 79 74 65 73                    some bytes
"".statictmp_2 SRODATA size=10
	0x0000 61 72 72 61 79                                   array
"".initdone· SNOPTRBSS size=1
runtime.gcbits.01 SRODATA dupok size=1
	0x0000 01                                               .
type..namedata.*[]uint8- SRODATA dupok size=11
	0x0000 00 00 08 2a 5b 5d 75 69 6e 74 38                 ...*[]uint8
type.*[]uint8 SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 a5 8e d0 69 00 08 08 36 00 00 00 00 00 00 00 00  ...i...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]uint8-+0
	rel 48+8 t=1 type.[]uint8+0
type.[]uint8 SRODATA dupok size=56
	0x0000 18 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 df 7e 2e 38 02 08 08 17 00 00 00 00 00 00 00 00  .~.8............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+0
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]uint8-+0
	rel 44+4 t=6 type.*[]uint8+0
	rel 48+8 t=1 type.uint8+0
type..hashfunc10 SRODATA dupok size=16
	0x0000 00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
	rel 0+8 t=1 runtime.memhash_varlen+0
type..eqfunc10 SRODATA dupok size=16
	0x0000 00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
	rel 0+8 t=1 runtime.memequal_varlen+0
type..alg10 SRODATA dupok size=16
	0x0000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	rel 0+8 t=1 type..hashfunc10+0
	rel 8+8 t=1 type..eqfunc10+0
runtime.gcbits. SRODATA dupok size=0
type..namedata.*[10]uint8- SRODATA dupok size=13
	0x0000 00 00 0a 2a 5b 31 30 5d 75 69 6e 74 38           ...*[10]uint8
type.[10]uint8 SRODATA dupok size=72
	0x0000 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0010 83 76 a9 78 02 01 01 91 00 00 00 00 00 00 00 00  .v.x............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 0a 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 type..alg10+0
	rel 32+8 t=1 runtime.gcbits.+0
	rel 40+4 t=5 type..namedata.*[10]uint8-+0
	rel 44+4 t=6 type.*[10]uint8+0
	rel 48+8 t=1 type.uint8+0
	rel 56+8 t=1 type.[]uint8+0
type.*[10]uint8 SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 c0 e4 a1 72 00 08 08 36 00 00 00 00 00 00 00 00  ...r...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[10]uint8-+0
	rel 48+8 t=1 type.[10]uint8+0
gclocals·9783710103695d7171ee820ce562d18d SRODATA dupok size=11
	0x0000 03 00 00 00 01 00 00 00 00 00 01                 ...........
gclocals·95ba1b998e251f98233f27a52dca8d52 SRODATA dupok size=11
	0x0000 03 00 00 00 04 00 00 00 00 01 00                 ...........
gclocals·9fb7f0986f647f17cb53dda1484e0f7a SRODATA dupok size=10
	0x0000 02 00 00 00 01 00 00 00 00 01                    ..........
gclocals·291e1a88f43c8277f90a067a6c879210 SRODATA dupok size=11
	0x0000 03 00 00 00 07 00 00 00 00 01 00                 ...........
gclocals·15b76348caca8a511afecadf603e9401 SRODATA dupok size=10
	0x0000 02 00 00 00 03 00 00 00 00 00                    ..........
gclocals·33cdeccccebe80329f1fdbee7f5874cb SRODATA dupok size=8
	0x0000 01 00 00 00 00 00 00 00                          ........
# command-line-arguments
runtime.main_main·f: function main is undeclared in the main package
