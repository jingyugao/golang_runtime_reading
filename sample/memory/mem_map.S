# command-line-arguments
"".f10 STEXT size=74 args=0x8 locals=0x18
	0x0000 00000 (mem_map.go:3)	TEXT	"".f10(SB), $24-8
	0x0000 00000 (mem_map.go:3)	MOVQ	(TLS), CX
	0x0009 00009 (mem_map.go:3)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_map.go:3)	JLS	67
	0x000f 00015 (mem_map.go:3)	SUBQ	$24, SP
	0x0013 00019 (mem_map.go:3)	MOVQ	BP, 16(SP)
	0x0018 00024 (mem_map.go:3)	LEAQ	16(SP), BP
	0x001d 00029 (mem_map.go:3)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_map.go:3)	FUNCDATA	$1, gclocals·263043c8f03e3241528dfae4e2812ef4(SB)
	0x001d 00029 (mem_map.go:3)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_map.go:3)	PCDATA	$2, $0
	0x001d 00029 (mem_map.go:3)	PCDATA	$0, $0
	0x001d 00029 (mem_map.go:3)	MOVQ	$0, "".~r0+32(SP)
	// 构造map
	0x0026 00038 (mem_map.go:4)	CALL	runtime.makemap_small(SB)
	0x002b 00043 (mem_map.go:4)	PCDATA	$2, $1
	0x002b 00043 (mem_map.go:4)	MOVQ	(SP), AX
	0x002f 00047 (mem_map.go:4)	MOVQ	AX, "".m+8(SP)
	0x0034 00052 (mem_map.go:5)	PCDATA	$2, $0
	0x0034 00052 (mem_map.go:5)	PCDATA	$0, $1
	0x0034 00052 (mem_map.go:5)	MOVQ	AX, "".~r0+32(SP)
	0x0039 00057 (mem_map.go:5)	MOVQ	16(SP), BP
	0x003e 00062 (mem_map.go:5)	ADDQ	$24, SP
	0x0042 00066 (mem_map.go:5)	RET
	0x0043 00067 (mem_map.go:5)	NOP
	0x0043 00067 (mem_map.go:3)	PCDATA	$0, $-1
	0x0043 00067 (mem_map.go:3)	PCDATA	$2, $-1
	0x0043 00067 (mem_map.go:3)	CALL	runtime.morestack_noctxt(SB)
	0x0048 00072 (mem_map.go:3)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 34 48  eH..%....H;a.v4H
	0x0010 83 ec 18 48 89 6c 24 10 48 8d 6c 24 10 48 c7 44  ...H.l$.H.l$.H.D
	0x0020 24 20 00 00 00 00 e8 00 00 00 00 48 8b 04 24 48  $ .........H..$H
	0x0030 89 44 24 08 48 89 44 24 20 48 8b 6c 24 10 48 83  .D$.H.D$ H.l$.H.
	0x0040 c4 18 c3 e8 00 00 00 00 eb b6                    ..........
	rel 5+4 t=16 TLS+0
	rel 39+4 t=8 runtime.makemap_small+0
	rel 68+4 t=8 runtime.morestack_noctxt+0
"".f11 STEXT nosplit size=50 args=0x8 locals=0x10
	0x0000 00000 (mem_map.go:8)	TEXT	"".f11(SB), NOSPLIT, $16-8
	0x0000 00000 (mem_map.go:8)	SUBQ	$16, SP
	0x0004 00004 (mem_map.go:8)	MOVQ	BP, 8(SP)
	0x0009 00009 (mem_map.go:8)	LEAQ	8(SP), BP
	0x000e 00014 (mem_map.go:8)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x000e 00014 (mem_map.go:8)	FUNCDATA	$1, gclocals·263043c8f03e3241528dfae4e2812ef4(SB)
	0x000e 00014 (mem_map.go:8)	FUNCDATA	$3, gclocals·33cdeccccebe80329f1fdbee7f5874cb(SB)
	0x000e 00014 (mem_map.go:8)	PCDATA	$2, $0
	0x000e 00014 (mem_map.go:8)	PCDATA	$0, $0
	0x000e 00014 (mem_map.go:8)	MOVQ	$0, "".~r0+24(SP)
	0x0017 00023 (mem_map.go:9)	MOVQ	$0, "".m(SP)
	0x001f 00031 (mem_map.go:10)	PCDATA	$0, $1
	// 未初始化的map是个nil指针
	// map是个指向hmap的指针
	// slice和string也是指向slice或stringStruct的指针
	// 只不过有时候go编译器会优化一下，直接传递slice结构体
	// 因为slice和stringStruct结构体比较小。
	0x001f 00031 (mem_map.go:10)	MOVQ	$0, "".~r0+24(SP)
	0x0028 00040 (mem_map.go:10)	MOVQ	8(SP), BP
	0x002d 00045 (mem_map.go:10)	ADDQ	$16, SP
	0x0031 00049 (mem_map.go:10)	RET
	0x0000 48 83 ec 10 48 89 6c 24 08 48 8d 6c 24 08 48 c7  H...H.l$.H.l$.H.
	0x0010 44 24 18 00 00 00 00 48 c7 04 24 00 00 00 00 48  D$.....H..$....H
	0x0020 c7 44 24 18 00 00 00 00 48 8b 6c 24 08 48 83 c4  .D$.....H.l$.H..
	0x0030 10 c3                                            ..
"".f12 STEXT size=74 args=0x8 locals=0x18
	0x0000 00000 (mem_map.go:13)	TEXT	"".f12(SB), $24-8
	0x0000 00000 (mem_map.go:13)	MOVQ	(TLS), CX
	0x0009 00009 (mem_map.go:13)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_map.go:13)	JLS	67
	0x000f 00015 (mem_map.go:13)	SUBQ	$24, SP
	0x0013 00019 (mem_map.go:13)	MOVQ	BP, 16(SP)
	0x0018 00024 (mem_map.go:13)	LEAQ	16(SP), BP
	0x001d 00029 (mem_map.go:13)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_map.go:13)	FUNCDATA	$1, gclocals·263043c8f03e3241528dfae4e2812ef4(SB)
	0x001d 00029 (mem_map.go:13)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_map.go:13)	PCDATA	$2, $0
	0x001d 00029 (mem_map.go:13)	PCDATA	$0, $0
	0x001d 00029 (mem_map.go:13)	MOVQ	$0, "".~r0+32(SP)
	// 构造map
	0x0026 00038 (mem_map.go:14)	CALL	runtime.makemap_small(SB)
	0x002b 00043 (mem_map.go:14)	PCDATA	$2, $1
	0x002b 00043 (mem_map.go:14)	MOVQ	(SP), AX
	0x002f 00047 (mem_map.go:14)	MOVQ	AX, "".m+8(SP)
	0x0034 00052 (mem_map.go:15)	PCDATA	$2, $0
	0x0034 00052 (mem_map.go:15)	PCDATA	$0, $1
	0x0034 00052 (mem_map.go:15)	MOVQ	AX, "".~r0+32(SP)
	0x0039 00057 (mem_map.go:15)	MOVQ	16(SP), BP
	0x003e 00062 (mem_map.go:15)	ADDQ	$24, SP
	0x0042 00066 (mem_map.go:15)	RET
	0x0043 00067 (mem_map.go:15)	NOP
	0x0043 00067 (mem_map.go:13)	PCDATA	$0, $-1
	0x0043 00067 (mem_map.go:13)	PCDATA	$2, $-1
	0x0043 00067 (mem_map.go:13)	CALL	runtime.morestack_noctxt(SB)
	0x0048 00072 (mem_map.go:13)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 34 48  eH..%....H;a.v4H
	0x0010 83 ec 18 48 89 6c 24 10 48 8d 6c 24 10 48 c7 44  ...H.l$.H.l$.H.D
	0x0020 24 20 00 00 00 00 e8 00 00 00 00 48 8b 04 24 48  $ .........H..$H
	0x0030 89 44 24 08 48 89 44 24 20 48 8b 6c 24 10 48 83  .D$.H.D$ H.l$.H.
	0x0040 c4 18 c3 e8 00 00 00 00 eb b6                    ..........
	rel 5+4 t=16 TLS+0
	rel 39+4 t=8 runtime.makemap_small+0
	rel 68+4 t=8 runtime.morestack_noctxt+0
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
go.loc."".f10 SDWARFLOC size=0
go.info."".f10 SDWARFINFO size=56
	0x0000 02 22 22 2e 66 31 30 00 00 00 00 00 00 00 00 00  ."".f10.........
	0x0010 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09  ................
	0x0020 6d 00 04 00 00 00 00 02 91 68 0e 7e 72 30 00 01  m........h.~r0..
	0x0030 03 00 00 00 00 01 9c 00                          ........
	rel 8+8 t=1 "".f10+0
	rel 16+8 t=1 "".f10+74
	rel 26+4 t=29 gofile..mem_map.go+0
	rel 35+4 t=28 go.info.map[int]int+0
	rel 49+4 t=28 go.info.map[int]int+0
go.range."".f10 SDWARFRANGE size=0
go.isstmt."".f10 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 0e 01 09 02 05 01 0a 02 07 00     ...............
go.loc."".f11 SDWARFLOC size=0
go.info."".f11 SDWARFINFO size=56
	0x0000 02 22 22 2e 66 31 31 00 00 00 00 00 00 00 00 00  ."".f11.........
	0x0010 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09  ................
	0x0020 6d 00 09 00 00 00 00 02 91 68 0e 7e 72 30 00 01  m........h.~r0..
	0x0030 08 00 00 00 00 01 9c 00                          ........
	rel 8+8 t=1 "".f11+0
	rel 16+8 t=1 "".f11+50
	rel 26+4 t=29 gofile..mem_map.go+0
	rel 35+4 t=28 go.info.map[int]int+0
	rel 49+4 t=28 go.info.map[int]int+0
go.range."".f11 SDWARFRANGE size=0
go.isstmt."".f11 SDWARFMISC size=0
	0x0000 08 0e 03 1a 01 0a 00                             .......
go.loc."".f12 SDWARFLOC size=0
go.info."".f12 SDWARFINFO size=56
	0x0000 02 22 22 2e 66 31 32 00 00 00 00 00 00 00 00 00  ."".f12.........
	0x0010 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09  ................
	0x0020 6d 00 0e 00 00 00 00 02 91 68 0e 7e 72 30 00 01  m........h.~r0..
	0x0030 0d 00 00 00 00 01 9c 00                          ........
	rel 8+8 t=1 "".f12+0
	rel 16+8 t=1 "".f12+74
	rel 26+4 t=29 gofile..mem_map.go+0
	rel 35+4 t=28 go.info.map[int]int+0
	rel 49+4 t=28 go.info.map[int]int+0
go.range."".f12 SDWARFRANGE size=0
go.isstmt."".f12 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 0e 01 09 02 05 01 0a 02 07 00     ...............
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
type..namedata.*[8]uint8- SRODATA dupok size=12
	0x0000 00 00 09 2a 5b 38 5d 75 69 6e 74 38              ...*[8]uint8
type.*[8]uint8 SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 a9 89 a5 7a 00 08 08 36 00 00 00 00 00 00 00 00  ...z...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[8]uint8-+0
	rel 48+8 t=1 type.[8]uint8+0
runtime.gcbits. SRODATA dupok size=0
type.[8]uint8 SRODATA dupok size=72
	0x0000 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0010 3e f9 30 b4 02 01 01 91 00 00 00 00 00 00 00 00  >.0.............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 08 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.+0
	rel 40+4 t=5 type..namedata.*[8]uint8-+0
	rel 44+4 t=6 type.*[8]uint8+0
	rel 48+8 t=1 type.uint8+0
	rel 56+8 t=1 type.[]uint8+0
type..namedata.*[]int- SRODATA dupok size=9
	0x0000 00 00 06 2a 5b 5d 69 6e 74                       ...*[]int
type.*[]int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 1b 31 52 88 00 08 08 36 00 00 00 00 00 00 00 00  .1R....6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]int-+0
	rel 48+8 t=1 type.[]int+0
type.[]int SRODATA dupok size=56
	0x0000 18 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 8e 66 f9 1b 02 08 08 17 00 00 00 00 00 00 00 00  .f..............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+0
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]int-+0
	rel 44+4 t=6 type.*[]int+0
	rel 48+8 t=1 type.int+0
type..namedata.*[8]int- SRODATA dupok size=10
	0x0000 00 00 07 2a 5b 38 5d 69 6e 74                    ...*[8]int
type.*[8]int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 f3 3f a8 3b 00 08 08 36 00 00 00 00 00 00 00 00  .?.;...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[8]int-+0
	rel 48+8 t=1 type.noalg.[8]int+0
type.noalg.[8]int SRODATA dupok size=72
	0x0000 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
	0x0010 96 99 d5 05 02 08 08 91 00 00 00 00 00 00 00 00  ................
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 08 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+0
	rel 32+8 t=1 runtime.gcbits.+0
	rel 40+4 t=5 type..namedata.*[8]int-+0
	rel 44+4 t=6 type.*[8]int+0
	rel 48+8 t=1 type.int+0
	rel 56+8 t=1 type.[]int+0
type..namedata.*map.bucket[int]int- SRODATA dupok size=22
	0x0000 00 00 13 2a 6d 61 70 2e 62 75 63 6b 65 74 5b 69  ...*map.bucket[i
	0x0010 6e 74 5d 69 6e 74                                nt]int
type.*map.bucket[int]int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 2a ff 7c 44 00 08 08 36 00 00 00 00 00 00 00 00  *.|D...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*map.bucket[int]int-+0
	rel 48+8 t=1 type.noalg.map.bucket[int]int+0
type..importpath.. SRODATA dupok size=3
	0x0000 00 00 00                                         ...
type..namedata.topbits- SRODATA dupok size=10
	0x0000 00 00 07 74 6f 70 62 69 74 73                    ...topbits
type..namedata.keys- SRODATA dupok size=7
	0x0000 00 00 04 6b 65 79 73                             ...keys
type..namedata.values- SRODATA dupok size=9
	0x0000 00 00 06 76 61 6c 75 65 73                       ...values
type..namedata.overflow- SRODATA dupok size=11
	0x0000 00 00 08 6f 76 65 72 66 6c 6f 77                 ...overflow
type.noalg.map.bucket[int]int SRODATA dupok size=176
	0x0000 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0010 b3 28 ed bb 02 08 08 99 00 00 00 00 00 00 00 00  .(..............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00  ................
	0x0050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0060 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0070 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
	0x0080 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0090 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x00a0 00 00 00 00 00 00 00 00 10 01 00 00 00 00 00 00  ................
	rel 24+8 t=1 runtime.algarray+0
	rel 32+8 t=1 runtime.gcbits.+0
	rel 40+4 t=5 type..namedata.*map.bucket[int]int-+0
	rel 44+4 t=6 type.*map.bucket[int]int+0
	rel 48+8 t=1 type..importpath..+0
	rel 56+8 t=1 type.noalg.map.bucket[int]int+80
	rel 80+8 t=1 type..namedata.topbits-+0
	rel 88+8 t=1 type.[8]uint8+0
	rel 104+8 t=1 type..namedata.keys-+0
	rel 112+8 t=1 type.noalg.[8]int+0
	rel 128+8 t=1 type..namedata.values-+0
	rel 136+8 t=1 type.noalg.[8]int+0
	rel 152+8 t=1 type..namedata.overflow-+0
	rel 160+8 t=1 type.uintptr+0
type..namedata.*map[int]int- SRODATA dupok size=15
	0x0000 00 00 0c 2a 6d 61 70 5b 69 6e 74 5d 69 6e 74     ...*map[int]int
type.*map[int]int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 ab c4 20 42 00 08 08 36 00 00 00 00 00 00 00 00  .. B...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*map[int]int-+0
	rel 48+8 t=1 type.map[int]int+0
type.map[int]int SRODATA dupok size=80
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 50 1b 58 23 02 08 08 35 00 00 00 00 00 00 00 00  P.X#...5........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0040 00 00 00 00 00 00 00 00 08 00 08 00 90 00 01 00  ................
	rel 24+8 t=1 runtime.algarray+0
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*map[int]int-+0
	rel 44+4 t=6 type.*map[int]int+0
	rel 48+8 t=1 type.int+0
	rel 56+8 t=1 type.int+0
	rel 64+8 t=1 type.noalg.map.bucket[int]int+0
gclocals·9fb7f0986f647f17cb53dda1484e0f7a SRODATA dupok size=10
	0x0000 02 00 00 00 01 00 00 00 00 01                    ..........
gclocals·263043c8f03e3241528dfae4e2812ef4 SRODATA dupok size=10
	0x0000 02 00 00 00 01 00 00 00 00 00                    ..........
gclocals·33cdeccccebe80329f1fdbee7f5874cb SRODATA dupok size=8
	0x0000 01 00 00 00 00 00 00 00                          ........
# command-line-arguments
runtime.main_main·f: function main is undeclared in the main package
