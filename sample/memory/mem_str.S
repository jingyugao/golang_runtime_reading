# command-line-arguments
"".f1 STEXT nosplit size=66 args=0x10 locals=0x18
	0x0000 00000 (mem_str.go:5)	TEXT	"".f1(SB), NOSPLIT, $24-16
	0x0000 00000 (mem_str.go:5)	SUBQ	$24, SP
	0x0004 00004 (mem_str.go:5)	MOVQ	BP, 16(SP)
	0x0009 00009 (mem_str.go:5)	LEAQ	16(SP), BP
	0x000e 00014 (mem_str.go:5)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x000e 00014 (mem_str.go:5)	FUNCDATA	$1, gclocals·2589ca35330fc0fce83503f4569854a0(SB)
	0x000e 00014 (mem_str.go:5)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x000e 00014 (mem_str.go:5)	PCDATA	$2, $0
	0x000e 00014 (mem_str.go:5)	PCDATA	$0, $0
	0x000e 00014 (mem_str.go:5)	XORPS	X0, X0
	0x0011 00017 (mem_str.go:5)	MOVUPS	X0, "".~r0+32(SP)
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
	0x0000 48 83 ec 18 48 89 6c 24 10 48 8d 6c 24 10 0f 57  H...H.l$.H.l$..W
	0x0010 c0 0f 11 44 24 20 48 8d 05 00 00 00 00 48 89 04  ...D$ H......H..
	0x0020 24 48 c7 44 24 08 0f 00 00 00 48 89 44 24 20 48  $H.D$.....H.D$ H
	0x0030 c7 44 24 28 0f 00 00 00 48 8b 6c 24 10 48 83 c4  .D$(....H.l$.H..
	0x0040 18 c3                                            ..
	rel 25+4 t=15 go.string."literial string"+0
"".f2 STEXT size=209 args=0x10 locals=0x78
	0x0000 00000 (mem_str.go:9)	TEXT	"".f2(SB), $120-16
	0x0000 00000 (mem_str.go:9)	MOVQ	(TLS), CX
	0x0009 00009 (mem_str.go:9)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_str.go:9)	JLS	199
	0x0013 00019 (mem_str.go:9)	SUBQ	$120, SP
	0x0017 00023 (mem_str.go:9)	MOVQ	BP, 112(SP)
	0x001c 00028 (mem_str.go:9)	LEAQ	112(SP), BP
	0x0021 00033 (mem_str.go:9)	FUNCDATA	$0, gclocals·7c4f42204c11e36f20768ac2d97a1c59(SB)
	0x0021 00033 (mem_str.go:9)	FUNCDATA	$1, gclocals·f8e3afc707d9e7ac0395bd7132b1e9c4(SB)
	0x0021 00033 (mem_str.go:9)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x0021 00033 (mem_str.go:9)	PCDATA	$2, $0
	0x0021 00033 (mem_str.go:9)	PCDATA	$0, $0
	0x0021 00033 (mem_str.go:9)	XORPS	X0, X0
	0x0024 00036 (mem_str.go:9)	MOVUPS	X0, "".~r0+128(SP)
	0x002c 00044 (mem_str.go:10)	PCDATA	$2, $1
	0x002c 00044 (mem_str.go:10)	LEAQ	""..autotmp_4+54(SP), AX
	0x0031 00049 (mem_str.go:10)	PCDATA	$0, $1
	0x0031 00049 (mem_str.go:10)	MOVQ	AX, ""..autotmp_3+64(SP)
	0x0036 00054 (mem_str.go:10)	PCDATA	$2, $0
	0x0036 00054 (mem_str.go:10)	TESTB	AL, (AX)
	0x0038 00056 (mem_str.go:10)	MOVQ	"".statictmp_0+2(SB), AX
	0x003f 00063 (mem_str.go:10)	MOVQ	"".statictmp_0(SB), CX
	0x0046 00070 (mem_str.go:10)	MOVQ	CX, ""..autotmp_4+54(SP)
	0x004b 00075 (mem_str.go:10)	MOVQ	AX, ""..autotmp_4+56(SP)
	0x0050 00080 (mem_str.go:10)	PCDATA	$2, $1
	0x0050 00080 (mem_str.go:10)	PCDATA	$0, $0
	0x0050 00080 (mem_str.go:10)	MOVQ	""..autotmp_3+64(SP), AX
	0x0055 00085 (mem_str.go:10)	TESTB	AL, (AX)
	0x0057 00087 (mem_str.go:10)	JMP	89
	0x0059 00089 (mem_str.go:10)	PCDATA	$2, $0
	0x0059 00089 (mem_str.go:10)	PCDATA	$0, $2
	0x0059 00089 (mem_str.go:10)	MOVQ	AX, "".bs+88(SP)
	0x005e 00094 (mem_str.go:10)	MOVQ	$10, "".bs+96(SP)
	0x0067 00103 (mem_str.go:10)	MOVQ	$10, "".bs+104(SP)
	0x0070 00112 (mem_str.go:11)	MOVQ	$0, (SP)
	0x0078 00120 (mem_str.go:11)	PCDATA	$2, $1
	0x0078 00120 (mem_str.go:11)	PCDATA	$0, $0
	0x0078 00120 (mem_str.go:11)	MOVQ	"".bs+88(SP), AX
	0x007d 00125 (mem_str.go:11)	PCDATA	$2, $0
	0x007d 00125 (mem_str.go:11)	MOVQ	AX, 8(SP)
	0x0082 00130 (mem_str.go:11)	MOVQ	$10, 16(SP)
	0x008b 00139 (mem_str.go:11)	MOVQ	$10, 24(SP)
	0x0094 00148 (mem_str.go:11)	CALL	runtime.slicebytetostring(SB)
	0x0099 00153 (mem_str.go:11)	PCDATA	$2, $1
	0x0099 00153 (mem_str.go:11)	MOVQ	32(SP), AX
	0x009e 00158 (mem_str.go:11)	MOVQ	40(SP), CX
	0x00a3 00163 (mem_str.go:11)	MOVQ	AX, "".ret+72(SP)
	0x00a8 00168 (mem_str.go:11)	MOVQ	CX, "".ret+80(SP)
	0x00ad 00173 (mem_str.go:12)	PCDATA	$2, $0
	0x00ad 00173 (mem_str.go:12)	PCDATA	$0, $3
	0x00ad 00173 (mem_str.go:12)	MOVQ	AX, "".~r0+128(SP)
	0x00b5 00181 (mem_str.go:12)	MOVQ	CX, "".~r0+136(SP)
	0x00bd 00189 (mem_str.go:12)	MOVQ	112(SP), BP
	0x00c2 00194 (mem_str.go:12)	ADDQ	$120, SP
	0x00c6 00198 (mem_str.go:12)	RET
	0x00c7 00199 (mem_str.go:12)	NOP
	0x00c7 00199 (mem_str.go:9)	PCDATA	$0, $-1
	0x00c7 00199 (mem_str.go:9)	PCDATA	$2, $-1
	0x00c7 00199 (mem_str.go:9)	CALL	runtime.morestack_noctxt(SB)
	0x00cc 00204 (mem_str.go:9)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 0f 86 b4  eH..%....H;a....
	0x0010 00 00 00 48 83 ec 78 48 89 6c 24 70 48 8d 6c 24  ...H..xH.l$pH.l$
	0x0020 70 0f 57 c0 0f 11 84 24 80 00 00 00 48 8d 44 24  p.W....$....H.D$
	0x0030 36 48 89 44 24 40 84 00 48 8b 05 00 00 00 00 48  6H.D$@..H......H
	0x0040 8b 0d 00 00 00 00 48 89 4c 24 36 48 89 44 24 38  ......H.L$6H.D$8
	0x0050 48 8b 44 24 40 84 00 eb 00 48 89 44 24 58 48 c7  H.D$@....H.D$XH.
	0x0060 44 24 60 0a 00 00 00 48 c7 44 24 68 0a 00 00 00  D$`....H.D$h....
	0x0070 48 c7 04 24 00 00 00 00 48 8b 44 24 58 48 89 44  H..$....H.D$XH.D
	0x0080 24 08 48 c7 44 24 10 0a 00 00 00 48 c7 44 24 18  $.H.D$.....H.D$.
	0x0090 0a 00 00 00 e8 00 00 00 00 48 8b 44 24 20 48 8b  .........H.D$ H.
	0x00a0 4c 24 28 48 89 44 24 48 48 89 4c 24 50 48 89 84  L$(H.D$HH.L$PH..
	0x00b0 24 80 00 00 00 48 89 8c 24 88 00 00 00 48 8b 6c  $....H..$....H.l
	0x00c0 24 70 48 83 c4 78 c3 e8 00 00 00 00 e9 2f ff ff  $pH..x......./..
	0x00d0 ff                                               .
	rel 5+4 t=16 TLS+0
	rel 59+4 t=15 "".statictmp_0+2
	rel 66+4 t=15 "".statictmp_0+0
	rel 149+4 t=8 runtime.slicebytetostring+0
	rel 200+4 t=8 runtime.morestack_noctxt+0
"".f3 STEXT size=137 args=0x10 locals=0x50
	0x0000 00000 (mem_str.go:14)	TEXT	"".f3(SB), $80-16
	0x0000 00000 (mem_str.go:14)	MOVQ	(TLS), CX
	0x0009 00009 (mem_str.go:14)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_str.go:14)	JLS	127
	0x000f 00015 (mem_str.go:14)	SUBQ	$80, SP
	0x0013 00019 (mem_str.go:14)	MOVQ	BP, 72(SP)
	0x0018 00024 (mem_str.go:14)	LEAQ	72(SP), BP
	0x001d 00029 (mem_str.go:14)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_str.go:14)	FUNCDATA	$1, gclocals·2589ca35330fc0fce83503f4569854a0(SB)
	0x001d 00029 (mem_str.go:14)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_str.go:14)	PCDATA	$2, $0
	0x001d 00029 (mem_str.go:14)	PCDATA	$0, $0
	0x001d 00029 (mem_str.go:14)	XORPS	X0, X0
	0x0020 00032 (mem_str.go:14)	MOVUPS	X0, "".~r0+88(SP)
	0x0025 00037 (mem_str.go:15)	XORPS	X0, X0
	0x0028 00040 (mem_str.go:15)	MOVUPS	X0, "".ret+56(SP)
	0x002d 00045 (mem_str.go:17)	MOVQ	$0, (SP)
	0x0035 00053 (mem_str.go:17)	XORPS	X0, X0
	0x0038 00056 (mem_str.go:17)	MOVUPS	X0, 8(SP)
	0x003d 00061 (mem_str.go:17)	PCDATA	$2, $1
	0x003d 00061 (mem_str.go:17)	LEAQ	go.string."from append"(SB), AX
	0x0044 00068 (mem_str.go:17)	PCDATA	$2, $0
	0x0044 00068 (mem_str.go:17)	MOVQ	AX, 24(SP)
	0x0049 00073 (mem_str.go:17)	MOVQ	$11, 32(SP)
	0x0052 00082 (mem_str.go:17)	CALL	runtime.concatstring2(SB)
	0x0057 00087 (mem_str.go:17)	PCDATA	$2, $1
	0x0057 00087 (mem_str.go:17)	MOVQ	40(SP), AX
	0x005c 00092 (mem_str.go:17)	MOVQ	48(SP), CX
	0x0061 00097 (mem_str.go:17)	MOVQ	AX, "".ret+56(SP)
	0x0066 00102 (mem_str.go:17)	MOVQ	CX, "".ret+64(SP)
	0x006b 00107 (mem_str.go:18)	PCDATA	$2, $0
	0x006b 00107 (mem_str.go:18)	PCDATA	$0, $1
	0x006b 00107 (mem_str.go:18)	MOVQ	AX, "".~r0+88(SP)
	0x0070 00112 (mem_str.go:18)	MOVQ	CX, "".~r0+96(SP)
	0x0075 00117 (mem_str.go:18)	MOVQ	72(SP), BP
	0x007a 00122 (mem_str.go:18)	ADDQ	$80, SP
	0x007e 00126 (mem_str.go:18)	RET
	0x007f 00127 (mem_str.go:18)	NOP
	0x007f 00127 (mem_str.go:14)	PCDATA	$0, $-1
	0x007f 00127 (mem_str.go:14)	PCDATA	$2, $-1
	0x007f 00127 (mem_str.go:14)	CALL	runtime.morestack_noctxt(SB)
	0x0084 00132 (mem_str.go:14)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 70 48  eH..%....H;a.vpH
	0x0010 83 ec 50 48 89 6c 24 48 48 8d 6c 24 48 0f 57 c0  ..PH.l$HH.l$H.W.
	0x0020 0f 11 44 24 58 0f 57 c0 0f 11 44 24 38 48 c7 04  ..D$X.W...D$8H..
	0x0030 24 00 00 00 00 0f 57 c0 0f 11 44 24 08 48 8d 05  $.....W...D$.H..
	0x0040 00 00 00 00 48 89 44 24 18 48 c7 44 24 20 0b 00  ....H.D$.H.D$ ..
	0x0050 00 00 e8 00 00 00 00 48 8b 44 24 28 48 8b 4c 24  .......H.D$(H.L$
	0x0060 30 48 89 44 24 38 48 89 4c 24 40 48 89 44 24 58  0H.D$8H.L$@H.D$X
	0x0070 48 89 4c 24 60 48 8b 6c 24 48 48 83 c4 50 c3 e8  H.L$`H.l$HH..P..
	0x0080 00 00 00 00 e9 77 ff ff ff                       .....w...
	rel 5+4 t=16 TLS+0
	rel 64+4 t=15 go.string."from append"+0
	rel 83+4 t=8 runtime.concatstring2+0
	rel 128+4 t=8 runtime.morestack_noctxt+0
"".main STEXT size=147 args=0x0 locals=0x68
	0x0000 00000 (mem_str.go:20)	TEXT	"".main(SB), $104-0
	0x0000 00000 (mem_str.go:20)	MOVQ	(TLS), CX
	0x0009 00009 (mem_str.go:20)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_str.go:20)	JLS	137
	0x000f 00015 (mem_str.go:20)	SUBQ	$104, SP
	0x0013 00019 (mem_str.go:20)	MOVQ	BP, 96(SP)
	0x0018 00024 (mem_str.go:20)	LEAQ	96(SP), BP
	0x001d 00029 (mem_str.go:20)	FUNCDATA	$0, gclocals·69c1753bd5f81501d95132d08af04464(SB)
	0x001d 00029 (mem_str.go:20)	FUNCDATA	$1, gclocals·86da00badb1a277fd4ad05aca8027ea8(SB)
	0x001d 00029 (mem_str.go:20)	FUNCDATA	$3, gclocals·bfec7e55b3f043d1941c093912808913(SB)
	0x001d 00029 (mem_str.go:21)	PCDATA	$2, $0
	0x001d 00029 (mem_str.go:21)	PCDATA	$0, $1
	0x001d 00029 (mem_str.go:21)	XORPS	X0, X0
	0x0020 00032 (mem_str.go:21)	MOVUPS	X0, ""..autotmp_0+56(SP)
	0x0025 00037 (mem_str.go:21)	PCDATA	$2, $1
	0x0025 00037 (mem_str.go:21)	LEAQ	""..autotmp_0+56(SP), AX
	0x002a 00042 (mem_str.go:21)	MOVQ	AX, ""..autotmp_2+48(SP)
	0x002f 00047 (mem_str.go:21)	TESTB	AL, (AX)
	0x0031 00049 (mem_str.go:21)	PCDATA	$2, $2
	0x0031 00049 (mem_str.go:21)	LEAQ	type.string(SB), CX
	0x0038 00056 (mem_str.go:21)	PCDATA	$2, $1
	0x0038 00056 (mem_str.go:21)	MOVQ	CX, ""..autotmp_0+56(SP)
	0x003d 00061 (mem_str.go:21)	PCDATA	$2, $2
	0x003d 00061 (mem_str.go:21)	LEAQ	"".statictmp_1(SB), CX
	0x0044 00068 (mem_str.go:21)	PCDATA	$2, $1
	0x0044 00068 (mem_str.go:21)	MOVQ	CX, ""..autotmp_0+64(SP)
	0x0049 00073 (mem_str.go:21)	TESTB	AL, (AX)
	0x004b 00075 (mem_str.go:21)	JMP	77
	0x004d 00077 (mem_str.go:21)	MOVQ	AX, ""..autotmp_1+72(SP)
	0x0052 00082 (mem_str.go:21)	MOVQ	$1, ""..autotmp_1+80(SP)
	0x005b 00091 (mem_str.go:21)	MOVQ	$1, ""..autotmp_1+88(SP)
	0x0064 00100 (mem_str.go:21)	PCDATA	$2, $0
	0x0064 00100 (mem_str.go:21)	MOVQ	AX, (SP)
	0x0068 00104 (mem_str.go:21)	MOVQ	$1, 8(SP)
	0x0071 00113 (mem_str.go:21)	MOVQ	$1, 16(SP)
	0x007a 00122 (mem_str.go:21)	CALL	fmt.Println(SB)
	0x007f 00127 (mem_str.go:22)	PCDATA	$0, $0
	0x007f 00127 (mem_str.go:22)	MOVQ	96(SP), BP
	0x0084 00132 (mem_str.go:22)	ADDQ	$104, SP
	0x0088 00136 (mem_str.go:22)	RET
	0x0089 00137 (mem_str.go:22)	NOP
	0x0089 00137 (mem_str.go:20)	PCDATA	$0, $-1
	0x0089 00137 (mem_str.go:20)	PCDATA	$2, $-1
	0x0089 00137 (mem_str.go:20)	CALL	runtime.morestack_noctxt(SB)
	0x008e 00142 (mem_str.go:20)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 7a 48  eH..%....H;a.vzH
	0x0010 83 ec 68 48 89 6c 24 60 48 8d 6c 24 60 0f 57 c0  ..hH.l$`H.l$`.W.
	0x0020 0f 11 44 24 38 48 8d 44 24 38 48 89 44 24 30 84  ..D$8H.D$8H.D$0.
	0x0030 00 48 8d 0d 00 00 00 00 48 89 4c 24 38 48 8d 0d  .H......H.L$8H..
	0x0040 00 00 00 00 48 89 4c 24 40 84 00 eb 00 48 89 44  ....H.L$@....H.D
	0x0050 24 48 48 c7 44 24 50 01 00 00 00 48 c7 44 24 58  $HH.D$P....H.D$X
	0x0060 01 00 00 00 48 89 04 24 48 c7 44 24 08 01 00 00  ....H..$H.D$....
	0x0070 00 48 c7 44 24 10 01 00 00 00 e8 00 00 00 00 48  .H.D$..........H
	0x0080 8b 6c 24 60 48 83 c4 68 c3 e8 00 00 00 00 e9 6d  .l$`H..h.......m
	0x0090 ff ff ff                                         ...
	rel 5+4 t=16 TLS+0
	rel 52+4 t=15 type.string+0
	rel 64+4 t=15 "".statictmp_1+0
	rel 123+4 t=8 fmt.Println+0
	rel 138+4 t=8 runtime.morestack_noctxt+0
"".init STEXT size=100 args=0x0 locals=0x8
	0x0000 00000 (<autogenerated>:1)	TEXT	"".init(SB), $8-0
	0x0000 00000 (<autogenerated>:1)	MOVQ	(TLS), CX
	0x0009 00009 (<autogenerated>:1)	CMPQ	SP, 16(CX)
	0x000d 00013 (<autogenerated>:1)	JLS	93
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
	0x0048 00072 (<autogenerated>:1)	CALL	fmt.init(SB)
	0x004d 00077 (<autogenerated>:1)	MOVB	$2, "".initdone·(SB)
	0x0054 00084 (<autogenerated>:1)	MOVQ	(SP), BP
	0x0058 00088 (<autogenerated>:1)	ADDQ	$8, SP
	0x005c 00092 (<autogenerated>:1)	RET
	0x005d 00093 (<autogenerated>:1)	NOP
	0x005d 00093 (<autogenerated>:1)	PCDATA	$0, $-1
	0x005d 00093 (<autogenerated>:1)	PCDATA	$2, $-1
	0x005d 00093 (<autogenerated>:1)	CALL	runtime.morestack_noctxt(SB)
	0x0062 00098 (<autogenerated>:1)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 4e 48  eH..%....H;a.vNH
	0x0010 83 ec 08 48 89 2c 24 48 8d 2c 24 80 3d 00 00 00  ...H.,$H.,$.=...
	0x0020 00 01 77 02 eb 09 48 8b 2c 24 48 83 c4 08 c3 80  ..w...H.,$H.....
	0x0030 3d 00 00 00 00 01 74 02 eb 07 e8 00 00 00 00 0f  =.....t.........
	0x0040 0b c6 05 00 00 00 00 01 e8 00 00 00 00 c6 05 00  ................
	0x0050 00 00 00 02 48 8b 2c 24 48 83 c4 08 c3 e8 00 00  ....H.,$H.......
	0x0060 00 00 eb 9c                                      ....
	rel 5+4 t=16 TLS+0
	rel 29+4 t=15 "".initdone·+-1
	rel 49+4 t=15 "".initdone·+-1
	rel 59+4 t=8 runtime.throwinit+0
	rel 67+4 t=15 "".initdone·+-1
	rel 73+4 t=8 fmt.init+0
	rel 79+4 t=15 "".initdone·+-1
	rel 94+4 t=8 runtime.morestack_noctxt+0
go.cuinfo.producer.main SDWARFINFO dupok size=0
	0x0000 2d 4e 20 2d 6c                                   -N -l
go.string."literial string" SRODATA dupok size=15
	0x0000 6c 69 74 65 72 69 61 6c 20 73 74 72 69 6e 67     literial string
go.loc."".f1 SDWARFLOC size=0
go.info."".f1 SDWARFINFO size=57
	0x0000 02 22 22 2e 66 31 00 00 00 00 00 00 00 00 00 00  ."".f1..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 06 00 00 00 00 02 91 60 0e 7e 72 30 00  et........`.~r0.
	0x0030 01 05 00 00 00 00 01 9c 00                       .........
	rel 7+8 t=1 "".f1+0
	rel 15+8 t=1 "".f1+66
	rel 25+4 t=29 gofile..mem_str.go+0
	rel 36+4 t=28 go.info.string+0
	rel 50+4 t=28 go.info.string+0
go.range."".f1 SDWARFRANGE size=0
go.isstmt."".f1 SDWARFMISC size=0
	0x0000 08 0e 03 03 01 05 02 07 01 0d 02 05 01 13 00     ...............
go.loc."".f2 SDWARFLOC size=0
go.info."".f2 SDWARFINFO size=69
	0x0000 02 22 22 2e 66 32 00 00 00 00 00 00 00 00 00 00  ."".f2..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 62  ...............b
	0x0020 73 00 0a 00 00 00 00 02 91 58 09 72 65 74 00 0b  s........X.ret..
	0x0030 00 00 00 00 02 91 48 0e 7e 72 30 00 01 09 00 00  ......H.~r0.....
	0x0040 00 00 01 9c 00                                   .....
	rel 7+8 t=1 "".f2+0
	rel 15+8 t=1 "".f2+209
	rel 25+4 t=29 gofile..mem_str.go+0
	rel 35+4 t=28 go.info.[]uint8+0
	rel 48+4 t=28 go.info.string+0
	rel 62+4 t=28 go.info.string+0
go.range."".f2 SDWARFRANGE size=0
go.isstmt."".f2 SDWARFMISC size=0
	0x0000 04 13 04 0e 03 03 01 08 02 05 01 3f 02 08 01 35  ...........?...5
	0x0010 02 08 01 12 02 0a 00                             .......
go.string."from append" SRODATA dupok size=11
	0x0000 66 72 6f 6d 20 61 70 70 65 6e 64                 from append
go.loc."".f3 SDWARFLOC size=0
go.info."".f3 SDWARFINFO size=57
	0x0000 02 22 22 2e 66 33 00 00 00 00 00 00 00 00 00 00  ."".f3..........
	0x0010 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09 72  ...............r
	0x0020 65 74 00 0f 00 00 00 00 02 91 60 0e 7e 72 30 00  et........`.~r0.
	0x0030 01 0e 00 00 00 00 01 9c 00                       .........
	rel 7+8 t=1 "".f3+0
	rel 15+8 t=1 "".f3+137
	rel 25+4 t=29 gofile..mem_str.go+0
	rel 36+4 t=28 go.info.string+0
	rel 50+4 t=28 go.info.string+0
go.range."".f3 SDWARFRANGE size=0
go.isstmt."".f3 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 03 01 05 02 03 01 05 02 08 01 36  ...............6
	0x0010 02 05 01 0f 02 0a 00                             .......
go.string."vim-go" SRODATA dupok size=6
	0x0000 76 69 6d 2d 67 6f                                vim-go
go.loc."".main SDWARFLOC size=0
go.info."".main SDWARFINFO size=33
	0x0000 02 22 22 2e 6d 61 69 6e 00 00 00 00 00 00 00 00  ."".main........
	0x0010 00 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01  ................
	0x0020 00                                               .
	rel 9+8 t=1 "".main+0
	rel 17+8 t=1 "".main+147
	rel 27+4 t=29 gofile..mem_str.go+0
go.range."".main SDWARFRANGE size=0
go.isstmt."".main SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 03 01 5f 02 14 00                 ......._...
go.loc."".init SDWARFLOC size=0
go.info."".init SDWARFINFO size=33
	0x0000 02 22 22 2e 69 6e 69 74 00 00 00 00 00 00 00 00  ."".init........
	0x0010 00 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01  ................
	0x0020 00                                               .
	rel 9+8 t=1 "".init+0
	rel 17+8 t=1 "".init+100
	rel 27+4 t=29 gofile..<autogenerated>+0
go.range."".init SDWARFRANGE size=0
go.isstmt."".init SDWARFMISC size=0
	0x0000 04 0f 04 0c 03 07 01 04 02 09 01 10 02 09 01 15  ................
	0x0010 02 07 00                                         ...
"".statictmp_0 SRODATA size=10
	0x0000 73 6f 6d 65 20 62 79 74 65 73                    some bytes
"".statictmp_1 SRODATA size=16
	0x0000 00 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
	rel 0+8 t=1 go.string."vim-go"+0
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
type..namedata.*interface {}- SRODATA dupok size=16
	0x0000 00 00 0d 2a 69 6e 74 65 72 66 61 63 65 20 7b 7d  ...*interface {}
type.*interface {} SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 4f 0f 96 9d 00 08 08 36 00 00 00 00 00 00 00 00  O......6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*interface {}-+0
	rel 48+8 t=1 type.interface {}+0
runtime.gcbits.02 SRODATA dupok size=1
	0x0000 02                                               .
type.interface {} SRODATA dupok size=80
	0x0000 10 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
	0x0010 e7 57 a0 18 02 08 08 14 00 00 00 00 00 00 00 00  .W..............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	rel 24+8 t=1 runtime.algarray+144
	rel 32+8 t=1 runtime.gcbits.02+0
	rel 40+4 t=5 type..namedata.*interface {}-+0
	rel 44+4 t=6 type.*interface {}+0
	rel 56+8 t=1 type.interface {}+80
type..namedata.*[]interface {}- SRODATA dupok size=18
	0x0000 00 00 0f 2a 5b 5d 69 6e 74 65 72 66 61 63 65 20  ...*[]interface 
	0x0010 7b 7d                                            {}
type.*[]interface {} SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 f3 04 9a e7 00 08 08 36 00 00 00 00 00 00 00 00  .......6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]interface {}-+0
	rel 48+8 t=1 type.[]interface {}+0
type.[]interface {} SRODATA dupok size=56
	0x0000 18 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 70 93 ea 2f 02 08 08 17 00 00 00 00 00 00 00 00  p../............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+0
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]interface {}-+0
	rel 44+4 t=6 type.*[]interface {}+0
	rel 48+8 t=1 type.interface {}+0
type..namedata.*[1]interface {}- SRODATA dupok size=19
	0x0000 00 00 10 2a 5b 31 5d 69 6e 74 65 72 66 61 63 65  ...*[1]interface
	0x0010 20 7b 7d                                          {}
type.[1]interface {} SRODATA dupok size=72
	0x0000 10 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
	0x0010 50 91 5b fa 02 08 08 11 00 00 00 00 00 00 00 00  P.[.............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 01 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+144
	rel 32+8 t=1 runtime.gcbits.02+0
	rel 40+4 t=5 type..namedata.*[1]interface {}-+0
	rel 44+4 t=6 type.*[1]interface {}+0
	rel 48+8 t=1 type.interface {}+0
	rel 56+8 t=1 type.[]interface {}+0
type.*[1]interface {} SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 bf 03 a8 35 00 08 08 36 00 00 00 00 00 00 00 00  ...5...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[1]interface {}-+0
	rel 48+8 t=1 type.[1]interface {}+0
type..importpath.fmt. SRODATA dupok size=6
	0x0000 00 00 03 66 6d 74                                ...fmt
gclocals·9fb7f0986f647f17cb53dda1484e0f7a SRODATA dupok size=10
	0x0000 02 00 00 00 01 00 00 00 00 01                    ..........
gclocals·2589ca35330fc0fce83503f4569854a0 SRODATA dupok size=10
	0x0000 02 00 00 00 02 00 00 00 00 00                    ..........
gclocals·7c4f42204c11e36f20768ac2d97a1c59 SRODATA dupok size=12
	0x0000 04 00 00 00 01 00 00 00 00 00 00 01              ............
gclocals·f8e3afc707d9e7ac0395bd7132b1e9c4 SRODATA dupok size=12
	0x0000 04 00 00 00 06 00 00 00 00 01 08 00              ............
gclocals·69c1753bd5f81501d95132d08af04464 SRODATA dupok size=8
	0x0000 02 00 00 00 00 00 00 00                          ........
gclocals·86da00badb1a277fd4ad05aca8027ea8 SRODATA dupok size=10
	0x0000 02 00 00 00 06 00 00 00 00 04                    ..........
gclocals·bfec7e55b3f043d1941c093912808913 SRODATA dupok size=11
	0x0000 03 00 00 00 02 00 00 00 00 01 03                 ...........
gclocals·33cdeccccebe80329f1fdbee7f5874cb SRODATA dupok size=8
	0x0000 01 00 00 00 00 00 00 00                          ........
