# command-line-arguments
"".f13 STEXT nosplit size=50 args=0x8 locals=0x10
	0x0000 00000 (mem_chan.go:3)	TEXT	"".f13(SB), NOSPLIT, $16-8
	0x0000 00000 (mem_chan.go:3)	SUBQ	$16, SP
	0x0004 00004 (mem_chan.go:3)	MOVQ	BP, 8(SP)
	0x0009 00009 (mem_chan.go:3)	LEAQ	8(SP), BP
	0x000e 00014 (mem_chan.go:3)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x000e 00014 (mem_chan.go:3)	FUNCDATA	$1, gclocals·263043c8f03e3241528dfae4e2812ef4(SB)
	0x000e 00014 (mem_chan.go:3)	FUNCDATA	$3, gclocals·33cdeccccebe80329f1fdbee7f5874cb(SB)
	0x000e 00014 (mem_chan.go:3)	PCDATA	$2, $0
	0x000e 00014 (mem_chan.go:3)	PCDATA	$0, $0
	0x000e 00014 (mem_chan.go:3)	MOVQ	$0, "".~r0+24(SP)
	0x0017 00023 (mem_chan.go:4)	MOVQ	$0, "".c(SP)
	0x001f 00031 (mem_chan.go:5)	PCDATA	$0, $1
	// 直接返回空指针
	0x001f 00031 (mem_chan.go:5)	MOVQ	$0, "".~r0+24(SP)
	0x0028 00040 (mem_chan.go:5)	MOVQ	8(SP), BP
	0x002d 00045 (mem_chan.go:5)	ADDQ	$16, SP
	0x0031 00049 (mem_chan.go:5)	RET
	0x0000 48 83 ec 10 48 89 6c 24 08 48 8d 6c 24 08 48 c7  H...H.l$.H.l$.H.
	0x0010 44 24 18 00 00 00 00 48 c7 04 24 00 00 00 00 48  D$.....H..$....H
	0x0020 c7 44 24 18 00 00 00 00 48 8b 6c 24 08 48 83 c4  .D$.....H.l$.H..
	0x0030 10 c3                                            ..
"".f14 STEXT size=95 args=0x8 locals=0x28
	0x0000 00000 (mem_chan.go:8)	TEXT	"".f14(SB), $40-8
	0x0000 00000 (mem_chan.go:8)	MOVQ	(TLS), CX
	0x0009 00009 (mem_chan.go:8)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_chan.go:8)	JLS	88
	0x000f 00015 (mem_chan.go:8)	SUBQ	$40, SP
	0x0013 00019 (mem_chan.go:8)	MOVQ	BP, 32(SP)
	0x0018 00024 (mem_chan.go:8)	LEAQ	32(SP), BP
	0x001d 00029 (mem_chan.go:8)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_chan.go:8)	FUNCDATA	$1, gclocals·263043c8f03e3241528dfae4e2812ef4(SB)
	0x001d 00029 (mem_chan.go:8)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_chan.go:8)	PCDATA	$2, $0
	0x001d 00029 (mem_chan.go:8)	PCDATA	$0, $0
	0x001d 00029 (mem_chan.go:8)	MOVQ	$0, "".~r0+48(SP)
	0x0026 00038 (mem_chan.go:9)	PCDATA	$2, $1
	// 
	0x0026 00038 (mem_chan.go:9)	LEAQ	type.chan int(SB), AX
	0x002d 00045 (mem_chan.go:9)	PCDATA	$2, $0
	0x002d 00045 (mem_chan.go:9)	MOVQ	AX, (SP)
	0x0031 00049 (mem_chan.go:9)	MOVQ	$0, 8(SP)
	0x003a 00058 (mem_chan.go:9)	CALL	runtime.makechan(SB)
	0x003f 00063 (mem_chan.go:9)	PCDATA	$2, $1
	0x003f 00063 (mem_chan.go:9)	MOVQ	16(SP), AX
	0x0044 00068 (mem_chan.go:9)	MOVQ	AX, "".c+24(SP)
	0x0049 00073 (mem_chan.go:10)	PCDATA	$2, $0
	0x0049 00073 (mem_chan.go:10)	PCDATA	$0, $1
	0x0049 00073 (mem_chan.go:10)	MOVQ	AX, "".~r0+48(SP)
	0x004e 00078 (mem_chan.go:10)	MOVQ	32(SP), BP
	0x0053 00083 (mem_chan.go:10)	ADDQ	$40, SP
	0x0057 00087 (mem_chan.go:10)	RET
	0x0058 00088 (mem_chan.go:10)	NOP
	0x0058 00088 (mem_chan.go:8)	PCDATA	$0, $-1
	0x0058 00088 (mem_chan.go:8)	PCDATA	$2, $-1
	0x0058 00088 (mem_chan.go:8)	CALL	runtime.morestack_noctxt(SB)
	0x005d 00093 (mem_chan.go:8)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 49 48  eH..%....H;a.vIH
	0x0010 83 ec 28 48 89 6c 24 20 48 8d 6c 24 20 48 c7 44  ..(H.l$ H.l$ H.D
	0x0020 24 30 00 00 00 00 48 8d 05 00 00 00 00 48 89 04  $0....H......H..
	0x0030 24 48 c7 44 24 08 00 00 00 00 e8 00 00 00 00 48  $H.D$..........H
	0x0040 8b 44 24 10 48 89 44 24 18 48 89 44 24 30 48 8b  .D$.H.D$.H.D$0H.
	0x0050 6c 24 20 48 83 c4 28 c3 e8 00 00 00 00 eb a1     l$ H..(........
	rel 5+4 t=16 TLS+0
	rel 41+4 t=15 type.chan int+0
	rel 59+4 t=8 runtime.makechan+0
	rel 89+4 t=8 runtime.morestack_noctxt+0
"".f15 STEXT size=95 args=0x8 locals=0x28
	0x0000 00000 (mem_chan.go:14)	TEXT	"".f15(SB), $40-8
	0x0000 00000 (mem_chan.go:14)	MOVQ	(TLS), CX
	0x0009 00009 (mem_chan.go:14)	CMPQ	SP, 16(CX)
	0x000d 00013 (mem_chan.go:14)	JLS	88
	0x000f 00015 (mem_chan.go:14)	SUBQ	$40, SP
	0x0013 00019 (mem_chan.go:14)	MOVQ	BP, 32(SP)
	0x0018 00024 (mem_chan.go:14)	LEAQ	32(SP), BP
	0x001d 00029 (mem_chan.go:14)	FUNCDATA	$0, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_chan.go:14)	FUNCDATA	$1, gclocals·263043c8f03e3241528dfae4e2812ef4(SB)
	0x001d 00029 (mem_chan.go:14)	FUNCDATA	$3, gclocals·9fb7f0986f647f17cb53dda1484e0f7a(SB)
	0x001d 00029 (mem_chan.go:14)	PCDATA	$2, $0
	0x001d 00029 (mem_chan.go:14)	PCDATA	$0, $0
	0x001d 00029 (mem_chan.go:14)	MOVQ	$0, "".~r0+48(SP)
	0x0026 00038 (mem_chan.go:15)	PCDATA	$2, $1
	0x0026 00038 (mem_chan.go:15)	LEAQ	type.chan int(SB), AX
	0x002d 00045 (mem_chan.go:15)	PCDATA	$2, $0
	0x002d 00045 (mem_chan.go:15)	MOVQ	AX, (SP)
	0x0031 00049 (mem_chan.go:15)	MOVQ	$10, 8(SP)
	0x003a 00058 (mem_chan.go:15)	CALL	runtime.makechan(SB)
	0x003f 00063 (mem_chan.go:15)	PCDATA	$2, $1
	0x003f 00063 (mem_chan.go:15)	MOVQ	16(SP), AX
	0x0044 00068 (mem_chan.go:15)	MOVQ	AX, "".c+24(SP)
	0x0049 00073 (mem_chan.go:16)	PCDATA	$2, $0
	0x0049 00073 (mem_chan.go:16)	PCDATA	$0, $1
	0x0049 00073 (mem_chan.go:16)	MOVQ	AX, "".~r0+48(SP)
	0x004e 00078 (mem_chan.go:16)	MOVQ	32(SP), BP
	0x0053 00083 (mem_chan.go:16)	ADDQ	$40, SP
	0x0057 00087 (mem_chan.go:16)	RET
	0x0058 00088 (mem_chan.go:16)	NOP
	0x0058 00088 (mem_chan.go:14)	PCDATA	$0, $-1
	0x0058 00088 (mem_chan.go:14)	PCDATA	$2, $-1
	0x0058 00088 (mem_chan.go:14)	CALL	runtime.morestack_noctxt(SB)
	0x005d 00093 (mem_chan.go:14)	JMP	0
	0x0000 65 48 8b 0c 25 00 00 00 00 48 3b 61 10 76 49 48  eH..%....H;a.vIH
	0x0010 83 ec 28 48 89 6c 24 20 48 8d 6c 24 20 48 c7 44  ..(H.l$ H.l$ H.D
	0x0020 24 30 00 00 00 00 48 8d 05 00 00 00 00 48 89 04  $0....H......H..
	0x0030 24 48 c7 44 24 08 0a 00 00 00 e8 00 00 00 00 48  $H.D$..........H
	0x0040 8b 44 24 10 48 89 44 24 18 48 89 44 24 30 48 8b  .D$.H.D$.H.D$0H.
	0x0050 6c 24 20 48 83 c4 28 c3 e8 00 00 00 00 eb a1     l$ H..(........
	rel 5+4 t=16 TLS+0
	rel 41+4 t=15 type.chan int+0
	rel 59+4 t=8 runtime.makechan+0
	rel 89+4 t=8 runtime.morestack_noctxt+0
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
go.loc."".f13 SDWARFLOC size=0
go.info."".f13 SDWARFINFO size=56
	0x0000 02 22 22 2e 66 31 33 00 00 00 00 00 00 00 00 00  ."".f13.........
	0x0010 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09  ................
	0x0020 63 00 04 00 00 00 00 02 91 68 0e 7e 72 30 00 01  c........h.~r0..
	0x0030 03 00 00 00 00 01 9c 00                          ........
	rel 8+8 t=1 "".f13+0
	rel 16+8 t=1 "".f13+50
	rel 26+4 t=29 gofile..mem_chan.go+0
	rel 35+4 t=28 go.info.chan int+0
	rel 49+4 t=28 go.info.chan int+0
go.range."".f13 SDWARFRANGE size=0
go.isstmt."".f13 SDWARFMISC size=0
	0x0000 08 0e 03 1a 01 0a 00                             .......
go.loc."".f14 SDWARFLOC size=0
go.info."".f14 SDWARFINFO size=56
	0x0000 02 22 22 2e 66 31 34 00 00 00 00 00 00 00 00 00  ."".f14.........
	0x0010 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09  ................
	0x0020 63 00 09 00 00 00 00 02 91 68 0e 7e 72 30 00 01  c........h.~r0..
	0x0030 08 00 00 00 00 01 9c 00                          ........
	rel 8+8 t=1 "".f14+0
	rel 16+8 t=1 "".f14+95
	rel 26+4 t=29 gofile..mem_chan.go+0
	rel 35+4 t=28 go.info.chan int+0
	rel 49+4 t=28 go.info.chan int+0
go.range."".f14 SDWARFRANGE size=0
go.isstmt."".f14 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 10 01 1c 02 05 01 0a 02 07 00     ...............
go.loc."".f15 SDWARFLOC size=0
go.info."".f15 SDWARFINFO size=56
	0x0000 02 22 22 2e 66 31 35 00 00 00 00 00 00 00 00 00  ."".f15.........
	0x0010 00 00 00 00 00 00 00 00 01 9c 00 00 00 00 01 09  ................
	0x0020 63 00 0f 00 00 00 00 02 91 68 0e 7e 72 30 00 01  c........h.~r0..
	0x0030 0e 00 00 00 00 01 9c 00                          ........
	rel 8+8 t=1 "".f15+0
	rel 16+8 t=1 "".f15+95
	rel 26+4 t=29 gofile..mem_chan.go+0
	rel 35+4 t=28 go.info.chan int+0
	rel 49+4 t=28 go.info.<-chan int+0
go.range."".f15 SDWARFRANGE size=0
go.isstmt."".f15 SDWARFMISC size=0
	0x0000 04 0f 04 0e 03 10 01 1c 02 05 01 0a 02 07 00     ...............
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
type..namedata.*<-chan int- SRODATA dupok size=14
	0x0000 00 00 0b 2a 3c 2d 63 68 61 6e 20 69 6e 74        ...*<-chan int
type.*<-chan int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 ff 5e cb 9b 00 08 08 36 00 00 00 00 00 00 00 00  .^.....6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*<-chan int-+0
	rel 48+8 t=1 type.<-chan int+0
type.<-chan int SRODATA dupok size=64
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 23 22 a1 c0 02 08 08 32 00 00 00 00 00 00 00 00  #".....2........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*<-chan int-+0
	rel 44+4 t=6 type.*<-chan int+0
	rel 48+8 t=1 type.int+0
type..namedata.*chan int- SRODATA dupok size=12
	0x0000 00 00 09 2a 63 68 61 6e 20 69 6e 74              ...*chan int
type.*chan int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 ed 7b ed 3b 00 08 08 36 00 00 00 00 00 00 00 00  .{.;...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*chan int-+0
	rel 48+8 t=1 type.chan int+0
type.chan int SRODATA dupok size=64
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 91 55 cb 71 02 08 08 32 00 00 00 00 00 00 00 00  .U.q...2........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00  ................
	rel 24+8 t=1 runtime.algarray+80
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*chan int-+0
	rel 44+4 t=6 type.*chan int+0
	rel 48+8 t=1 type.int+0
gclocals·9fb7f0986f647f17cb53dda1484e0f7a SRODATA dupok size=10
	0x0000 02 00 00 00 01 00 00 00 00 01                    ..........
gclocals·263043c8f03e3241528dfae4e2812ef4 SRODATA dupok size=10
	0x0000 02 00 00 00 01 00 00 00 00 00                    ..........
gclocals·33cdeccccebe80329f1fdbee7f5874cb SRODATA dupok size=8
	0x0000 01 00 00 00 00 00 00 00                          ........
# command-line-arguments
runtime.main_main·f: function main is undeclared in the main package
