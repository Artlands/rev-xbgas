
math_log.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	5dc000ef          	jal	106d8 <__call_exitprocs>
   10100:	fd01b503          	ld	a0,-48(gp) # 117f0 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	005000ef          	jal	10918 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00011537          	lui	a0,0x11
   10124:	80050513          	add	a0,a0,-2048 # 10800 <__libc_fini_array>
   10128:	7340006f          	j	1085c <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00001197          	auipc	gp,0x1
   10134:	6f018193          	add	gp,gp,1776 # 11820 <__global_pointer$>
   10138:	fe818513          	add	a0,gp,-24 # 11808 <completed.1>
   1013c:	02018613          	add	a2,gp,32 # 11840 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	4b4000ef          	jal	105fc <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	71050513          	add	a0,a0,1808 # 1085c <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	6a850513          	add	a0,a0,1704 # 10800 <__libc_fini_array>
   10160:	6fc000ef          	jal	1085c <atexit>
   10164:	3fc000ef          	jal	10560 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	add	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	06c000ef          	jal	101e0 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	add	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	fe81c783          	lbu	a5,-24(gp) # 11808 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	00050513          	mv	a0,a0
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	fef18423          	sb	a5,-24(gp) # 11808 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	add	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	ff018593          	add	a1,gp,-16 # 11810 <object.0>
   101d0:	00050513          	mv	a0,a0
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <main>:
   101e0:	fb010113          	add	sp,sp,-80
   101e4:	04113423          	sd	ra,72(sp)
   101e8:	04813023          	sd	s0,64(sp)
   101ec:	02813c27          	fsd	fs0,56(sp)
   101f0:	05010413          	add	s0,sp,80
   101f4:	00050793          	mv	a5,a0
   101f8:	fab43823          	sd	a1,-80(s0)
   101fc:	faf42e23          	sw	a5,-68(s0)
   10200:	fc043c23          	sd	zero,-40(s0)
   10204:	00400793          	li	a5,4
   10208:	fcf42623          	sw	a5,-52(s0)
   1020c:	fcc42783          	lw	a5,-52(s0)
   10210:	d20787d3          	fcvt.d.w	fa5,a5
   10214:	22f78553          	fmv.d	fa0,fa5
   10218:	090000ef          	jal	102a8 <log>
   1021c:	22a50753          	fmv.d	fa4,fa0
   10220:	000117b7          	lui	a5,0x11
   10224:	9487b787          	fld	fa5,-1720(a5) # 10948 <_exit+0x30>
   10228:	1af777d3          	fdiv.d	fa5,fa4,fa5
   1022c:	c22797d3          	fcvt.l.d	a5,fa5,rtz
   10230:	fcf43823          	sd	a5,-48(s0)
   10234:	fd043783          	ld	a5,-48(s0)
   10238:	d227f453          	fcvt.d.l	fs0,a5
   1023c:	fcc42783          	lw	a5,-52(s0)
   10240:	d20787d3          	fcvt.d.w	fa5,a5
   10244:	22f78553          	fmv.d	fa0,fa5
   10248:	060000ef          	jal	102a8 <log>
   1024c:	22a50753          	fmv.d	fa4,fa0
   10250:	000117b7          	lui	a5,0x11
   10254:	9487b787          	fld	fa5,-1720(a5) # 10948 <_exit+0x30>
   10258:	1af777d3          	fdiv.d	fa5,fa4,fa5
   1025c:	a2f417d3          	flt.d	a5,fs0,fa5
   10260:	00078863          	beqz	a5,10270 <main+0x90>
   10264:	fd043783          	ld	a5,-48(s0)
   10268:	00178793          	add	a5,a5,1
   1026c:	fcf43823          	sd	a5,-48(s0)
   10270:	0100006f          	j	10280 <main+0xa0>
   10274:	fd843783          	ld	a5,-40(s0)
   10278:	00178793          	add	a5,a5,1
   1027c:	fcf43c23          	sd	a5,-40(s0)
   10280:	fd843703          	ld	a4,-40(s0)
   10284:	fd043783          	ld	a5,-48(s0)
   10288:	fef746e3          	blt	a4,a5,10274 <main+0x94>
   1028c:	00000793          	li	a5,0
   10290:	00078513          	mv	a0,a5
   10294:	04813083          	ld	ra,72(sp)
   10298:	04013403          	ld	s0,64(sp)
   1029c:	03813407          	fld	fs0,56(sp)
   102a0:	05010113          	add	sp,sp,80
   102a4:	00008067          	ret

00000000000102a8 <log>:
   102a8:	fe010113          	add	sp,sp,-32
   102ac:	00813427          	fsd	fs0,8(sp)
   102b0:	22a50453          	fmv.d	fs0,fa0
   102b4:	00113c23          	sd	ra,24(sp)
   102b8:	064000ef          	jal	1031c <__ieee754_log>
   102bc:	a28427d3          	feq.d	a5,fs0,fs0
   102c0:	02078463          	beqz	a5,102e8 <log+0x40>
   102c4:	f20007d3          	fmv.d.x	fa5,zero
   102c8:	a28797d3          	flt.d	a5,fa5,fs0
   102cc:	00079e63          	bnez	a5,102e8 <log+0x40>
   102d0:	a2f427d3          	feq.d	a5,fs0,fa5
   102d4:	02078263          	beqz	a5,102f8 <log+0x50>
   102d8:	280000ef          	jal	10558 <__errno>
   102dc:	f481b507          	fld	fa0,-184(gp) # 11768 <__SDATA_BEGIN__>
   102e0:	02200793          	li	a5,34
   102e4:	00f52023          	sw	a5,0(a0) # 11000 <__EH_FRAME_BEGIN__>
   102e8:	01813083          	ld	ra,24(sp)
   102ec:	00813407          	fld	fs0,8(sp)
   102f0:	02010113          	add	sp,sp,32
   102f4:	00008067          	ret
   102f8:	260000ef          	jal	10558 <__errno>
   102fc:	01813083          	ld	ra,24(sp)
   10300:	00813407          	fld	fs0,8(sp)
   10304:	02100793          	li	a5,33
   10308:	00f52023          	sw	a5,0(a0)
   1030c:	00011537          	lui	a0,0x11
   10310:	95050513          	add	a0,a0,-1712 # 10950 <_exit+0x38>
   10314:	02010113          	add	sp,sp,32
   10318:	2380006f          	j	10550 <nan>

000000000001031c <__ieee754_log>:
   1031c:	e20507d3          	fmv.x.d	a5,fa0
   10320:	00100637          	lui	a2,0x100
   10324:	4207d713          	sra	a4,a5,0x20
   10328:	0cc75e63          	bge	a4,a2,10404 <__ieee754_log+0xe8>
   1032c:	02171693          	sll	a3,a4,0x21
   10330:	0216d693          	srl	a3,a3,0x21
   10334:	00f6e6b3          	or	a3,a3,a5
   10338:	0006869b          	sext.w	a3,a3
   1033c:	16068c63          	beqz	a3,104b4 <__ieee754_log+0x198>
   10340:	1e074263          	bltz	a4,10524 <__ieee754_log+0x208>
   10344:	f581b787          	fld	fa5,-168(gp) # 11778 <__SDATA_BEGIN__+0x10>
   10348:	7ff006b7          	lui	a3,0x7ff00
   1034c:	fca00613          	li	a2,-54
   10350:	12f577d3          	fmul.d	fa5,fa0,fa5
   10354:	e20787d3          	fmv.x.d	a5,fa5
   10358:	4207d713          	sra	a4,a5,0x20
   1035c:	0ad75a63          	bge	a4,a3,10410 <__ieee754_log+0xf4>
   10360:	00100837          	lui	a6,0x100
   10364:	fff80813          	add	a6,a6,-1 # fffff <__BSS_END__+0xee7bf>
   10368:	000966b7          	lui	a3,0x96
   1036c:	010778b3          	and	a7,a4,a6
   10370:	f646869b          	addw	a3,a3,-156 # 95f64 <__BSS_END__+0x84724>
   10374:	001005b7          	lui	a1,0x100
   10378:	00d886bb          	addw	a3,a7,a3
   1037c:	4147571b          	sraw	a4,a4,0x14
   10380:	00b6f6b3          	and	a3,a3,a1
   10384:	c017071b          	addw	a4,a4,-1023
   10388:	3ff005b7          	lui	a1,0x3ff00
   1038c:	00c7073b          	addw	a4,a4,a2
   10390:	00b6c5b3          	xor	a1,a3,a1
   10394:	fff00613          	li	a2,-1
   10398:	02065613          	srl	a2,a2,0x20
   1039c:	00b8e5b3          	or	a1,a7,a1
   103a0:	02059593          	sll	a1,a1,0x20
   103a4:	00f677b3          	and	a5,a2,a5
   103a8:	00b7e7b3          	or	a5,a5,a1
   103ac:	f601b507          	fld	fa0,-160(gp) # 11780 <__SDATA_BEGIN__+0x18>
   103b0:	f20787d3          	fmv.d.x	fa5,a5
   103b4:	0028851b          	addw	a0,a7,2
   103b8:	01057633          	and	a2,a0,a6
   103bc:	4146d69b          	sraw	a3,a3,0x14
   103c0:	00e686bb          	addw	a3,a3,a4
   103c4:	0006071b          	sext.w	a4,a2
   103c8:	00200613          	li	a2,2
   103cc:	0aa7f553          	fsub.d	fa0,fa5,fa0
   103d0:	0006859b          	sext.w	a1,a3
   103d4:	04e64463          	blt	a2,a4,1041c <__ieee754_log+0x100>
   103d8:	f20007d3          	fmv.d.x	fa5,zero
   103dc:	a2f527d3          	feq.d	a5,fa0,fa5
   103e0:	0e078263          	beqz	a5,104c4 <__ieee754_log+0x1a8>
   103e4:	22f78553          	fmv.d	fa0,fa5
   103e8:	12058863          	beqz	a1,10518 <__ieee754_log+0x1fc>
   103ec:	d2068553          	fcvt.d.w	fa0,a3
   103f0:	f681b787          	fld	fa5,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   103f4:	f701b707          	fld	fa4,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   103f8:	12f577d3          	fmul.d	fa5,fa0,fa5
   103fc:	7ae57543          	fmadd.d	fa0,fa0,fa4,fa5
   10400:	00008067          	ret
   10404:	7ff006b7          	lui	a3,0x7ff00
   10408:	00000613          	li	a2,0
   1040c:	f4d74ae3          	blt	a4,a3,10360 <__ieee754_log+0x44>
   10410:	f20787d3          	fmv.d.x	fa5,a5
   10414:	02f7f553          	fadd.d	fa0,fa5,fa5
   10418:	00008067          	ret
   1041c:	f881b687          	fld	fa3,-120(gp) # 117a8 <__SDATA_BEGIN__+0x40>
   10420:	0006c737          	lui	a4,0x6c
   10424:	fff9f7b7          	lui	a5,0xfff9f
   10428:	02d576d3          	fadd.d	fa3,fa0,fa3
   1042c:	b867879b          	addw	a5,a5,-1146 # fffffffffff9eb86 <__BSS_END__+0xfffffffffff8d346>
   10430:	8517071b          	addw	a4,a4,-1967 # 6b851 <__BSS_END__+0x5a011>
   10434:	4117073b          	subw	a4,a4,a7
   10438:	011787bb          	addw	a5,a5,a7
   1043c:	00e7e7b3          	or	a5,a5,a4
   10440:	1ad576d3          	fdiv.d	fa3,fa0,fa3
   10444:	fa81b707          	fld	fa4,-88(gp) # 117c8 <__SDATA_BEGIN__+0x60>
   10448:	fb01b787          	fld	fa5,-80(gp) # 117d0 <__SDATA_BEGIN__+0x68>
   1044c:	0007879b          	sext.w	a5,a5
   10450:	d20680d3          	fcvt.d.w	ft1,a3
   10454:	12d6f5d3          	fmul.d	fa1,fa3,fa3
   10458:	12b5f653          	fmul.d	fa2,fa1,fa1
   1045c:	7ae67743          	fmadd.d	fa4,fa2,fa4,fa5
   10460:	f901b787          	fld	fa5,-112(gp) # 117b0 <__SDATA_BEGIN__+0x48>
   10464:	f981b007          	fld	ft0,-104(gp) # 117b8 <__SDATA_BEGIN__+0x50>
   10468:	02f677c3          	fmadd.d	fa5,fa2,fa5,ft0
   1046c:	fb81b007          	fld	ft0,-72(gp) # 117d8 <__SDATA_BEGIN__+0x70>
   10470:	02c77743          	fmadd.d	fa4,fa4,fa2,ft0
   10474:	fa01b007          	fld	ft0,-96(gp) # 117c0 <__SDATA_BEGIN__+0x58>
   10478:	02c7f7c3          	fmadd.d	fa5,fa5,fa2,ft0
   1047c:	fc01b007          	fld	ft0,-64(gp) # 117e0 <__SDATA_BEGIN__+0x78>
   10480:	02c77743          	fmadd.d	fa4,fa4,fa2,ft0
   10484:	12b77753          	fmul.d	fa4,fa4,fa1
   10488:	72c7f7c3          	fmadd.d	fa5,fa5,fa2,fa4
   1048c:	06f05663          	blez	a5,104f8 <__ieee754_log+0x1dc>
   10490:	f801b707          	fld	fa4,-128(gp) # 117a0 <__SDATA_BEGIN__+0x38>
   10494:	12e57753          	fmul.d	fa4,fa0,fa4
   10498:	12a77753          	fmul.d	fa4,fa4,fa0
   1049c:	02e7f7d3          	fadd.d	fa5,fa5,fa4
   104a0:	12d7f7d3          	fmul.d	fa5,fa5,fa3
   104a4:	08059863          	bnez	a1,10534 <__ieee754_log+0x218>
   104a8:	0af77753          	fsub.d	fa4,fa4,fa5
   104ac:	0ae57553          	fsub.d	fa0,fa0,fa4
   104b0:	00008067          	ret
   104b4:	f20007d3          	fmv.d.x	fa5,zero
   104b8:	f501b507          	fld	fa0,-176(gp) # 11770 <__SDATA_BEGIN__+0x8>
   104bc:	1af57553          	fdiv.d	fa0,fa0,fa5
   104c0:	00008067          	ret
   104c4:	f781b707          	fld	fa4,-136(gp) # 11798 <__SDATA_BEGIN__+0x30>
   104c8:	f801b687          	fld	fa3,-128(gp) # 117a0 <__SDATA_BEGIN__+0x38>
   104cc:	12a577d3          	fmul.d	fa5,fa0,fa0
   104d0:	6ae5774b          	fnmsub.d	fa4,fa0,fa4,fa3
   104d4:	12e7f7d3          	fmul.d	fa5,fa5,fa4
   104d8:	04058263          	beqz	a1,1051c <__ieee754_log+0x200>
   104dc:	d20686d3          	fcvt.d.w	fa3,a3
   104e0:	f681b707          	fld	fa4,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   104e4:	7ae6f7cb          	fnmsub.d	fa5,fa3,fa4,fa5
   104e8:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
   104ec:	f701b507          	fld	fa0,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   104f0:	7aa6f547          	fmsub.d	fa0,fa3,fa0,fa5
   104f4:	00008067          	ret
   104f8:	0af577d3          	fsub.d	fa5,fa0,fa5
   104fc:	12d7f7d3          	fmul.d	fa5,fa5,fa3
   10500:	00058e63          	beqz	a1,1051c <__ieee754_log+0x200>
   10504:	f681b707          	fld	fa4,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   10508:	7ae0f7cb          	fnmsub.d	fa5,ft1,fa4,fa5
   1050c:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
   10510:	f701b507          	fld	fa0,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   10514:	7aa0f547          	fmsub.d	fa0,ft1,fa0,fa5
   10518:	00008067          	ret
   1051c:	0af57553          	fsub.d	fa0,fa0,fa5
   10520:	00008067          	ret
   10524:	0aa57553          	fsub.d	fa0,fa0,fa0
   10528:	f20007d3          	fmv.d.x	fa5,zero
   1052c:	1af57553          	fdiv.d	fa0,fa0,fa5
   10530:	00008067          	ret
   10534:	f681b687          	fld	fa3,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   10538:	7ad0f7c3          	fmadd.d	fa5,ft1,fa3,fa5
   1053c:	0af77753          	fsub.d	fa4,fa4,fa5
   10540:	0aa77753          	fsub.d	fa4,fa4,fa0
   10544:	f701b507          	fld	fa0,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   10548:	72a0f547          	fmsub.d	fa0,ft1,fa0,fa4
   1054c:	00008067          	ret

0000000000010550 <nan>:
   10550:	fc81b507          	fld	fa0,-56(gp) # 117e8 <__SDATA_BEGIN__+0x80>
   10554:	00008067          	ret

0000000000010558 <__errno>:
   10558:	fe01b503          	ld	a0,-32(gp) # 11800 <_impure_ptr>
   1055c:	00008067          	ret

0000000000010560 <__libc_init_array>:
   10560:	fe010113          	add	sp,sp,-32
   10564:	00813823          	sd	s0,16(sp)
   10568:	000117b7          	lui	a5,0x11
   1056c:	00011437          	lui	s0,0x11
   10570:	01213023          	sd	s2,0(sp)
   10574:	00478793          	add	a5,a5,4 # 11004 <__preinit_array_end>
   10578:	00440713          	add	a4,s0,4 # 11004 <__preinit_array_end>
   1057c:	00113c23          	sd	ra,24(sp)
   10580:	00913423          	sd	s1,8(sp)
   10584:	40e78933          	sub	s2,a5,a4
   10588:	02e78263          	beq	a5,a4,105ac <__libc_init_array+0x4c>
   1058c:	40395913          	sra	s2,s2,0x3
   10590:	00440413          	add	s0,s0,4
   10594:	00000493          	li	s1,0
   10598:	00043783          	ld	a5,0(s0)
   1059c:	00148493          	add	s1,s1,1
   105a0:	00840413          	add	s0,s0,8
   105a4:	000780e7          	jalr	a5
   105a8:	ff24e8e3          	bltu	s1,s2,10598 <__libc_init_array+0x38>
   105ac:	00011437          	lui	s0,0x11
   105b0:	000117b7          	lui	a5,0x11
   105b4:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   105b8:	00840713          	add	a4,s0,8 # 11008 <__init_array_start>
   105bc:	40e78933          	sub	s2,a5,a4
   105c0:	40395913          	sra	s2,s2,0x3
   105c4:	02e78063          	beq	a5,a4,105e4 <__libc_init_array+0x84>
   105c8:	00840413          	add	s0,s0,8
   105cc:	00000493          	li	s1,0
   105d0:	00043783          	ld	a5,0(s0)
   105d4:	00148493          	add	s1,s1,1
   105d8:	00840413          	add	s0,s0,8
   105dc:	000780e7          	jalr	a5
   105e0:	ff24e8e3          	bltu	s1,s2,105d0 <__libc_init_array+0x70>
   105e4:	01813083          	ld	ra,24(sp)
   105e8:	01013403          	ld	s0,16(sp)
   105ec:	00813483          	ld	s1,8(sp)
   105f0:	00013903          	ld	s2,0(sp)
   105f4:	02010113          	add	sp,sp,32
   105f8:	00008067          	ret

00000000000105fc <memset>:
   105fc:	00f00313          	li	t1,15
   10600:	00050713          	mv	a4,a0
   10604:	02c37a63          	bgeu	t1,a2,10638 <memset+0x3c>
   10608:	00f77793          	and	a5,a4,15
   1060c:	0a079063          	bnez	a5,106ac <memset+0xb0>
   10610:	06059e63          	bnez	a1,1068c <memset+0x90>
   10614:	ff067693          	and	a3,a2,-16
   10618:	00f67613          	and	a2,a2,15
   1061c:	00e686b3          	add	a3,a3,a4
   10620:	00b73023          	sd	a1,0(a4)
   10624:	00b73423          	sd	a1,8(a4)
   10628:	01070713          	add	a4,a4,16
   1062c:	fed76ae3          	bltu	a4,a3,10620 <memset+0x24>
   10630:	00061463          	bnez	a2,10638 <memset+0x3c>
   10634:	00008067          	ret
   10638:	40c306b3          	sub	a3,t1,a2
   1063c:	00269693          	sll	a3,a3,0x2
   10640:	00000297          	auipc	t0,0x0
   10644:	005686b3          	add	a3,a3,t0
   10648:	00c68067          	jr	12(a3) # 7ff0000c <__BSS_END__+0x7feee7cc>
   1064c:	00b70723          	sb	a1,14(a4)
   10650:	00b706a3          	sb	a1,13(a4)
   10654:	00b70623          	sb	a1,12(a4)
   10658:	00b705a3          	sb	a1,11(a4)
   1065c:	00b70523          	sb	a1,10(a4)
   10660:	00b704a3          	sb	a1,9(a4)
   10664:	00b70423          	sb	a1,8(a4)
   10668:	00b703a3          	sb	a1,7(a4)
   1066c:	00b70323          	sb	a1,6(a4)
   10670:	00b702a3          	sb	a1,5(a4)
   10674:	00b70223          	sb	a1,4(a4)
   10678:	00b701a3          	sb	a1,3(a4)
   1067c:	00b70123          	sb	a1,2(a4)
   10680:	00b700a3          	sb	a1,1(a4)
   10684:	00b70023          	sb	a1,0(a4)
   10688:	00008067          	ret
   1068c:	0ff5f593          	zext.b	a1,a1
   10690:	00859693          	sll	a3,a1,0x8
   10694:	00d5e5b3          	or	a1,a1,a3
   10698:	01059693          	sll	a3,a1,0x10
   1069c:	00d5e5b3          	or	a1,a1,a3
   106a0:	02059693          	sll	a3,a1,0x20
   106a4:	00d5e5b3          	or	a1,a1,a3
   106a8:	f6dff06f          	j	10614 <memset+0x18>
   106ac:	00279693          	sll	a3,a5,0x2
   106b0:	00000297          	auipc	t0,0x0
   106b4:	005686b3          	add	a3,a3,t0
   106b8:	00008293          	mv	t0,ra
   106bc:	f98680e7          	jalr	-104(a3)
   106c0:	00028093          	mv	ra,t0
   106c4:	ff078793          	add	a5,a5,-16
   106c8:	40f70733          	sub	a4,a4,a5
   106cc:	00f60633          	add	a2,a2,a5
   106d0:	f6c374e3          	bgeu	t1,a2,10638 <memset+0x3c>
   106d4:	f3dff06f          	j	10610 <memset+0x14>

00000000000106d8 <__call_exitprocs>:
   106d8:	fb010113          	add	sp,sp,-80
   106dc:	03413023          	sd	s4,32(sp)
   106e0:	fd01ba03          	ld	s4,-48(gp) # 117f0 <_global_impure_ptr>
   106e4:	03213823          	sd	s2,48(sp)
   106e8:	04113423          	sd	ra,72(sp)
   106ec:	1f8a3903          	ld	s2,504(s4)
   106f0:	04813023          	sd	s0,64(sp)
   106f4:	02913c23          	sd	s1,56(sp)
   106f8:	03313423          	sd	s3,40(sp)
   106fc:	01513c23          	sd	s5,24(sp)
   10700:	01613823          	sd	s6,16(sp)
   10704:	01713423          	sd	s7,8(sp)
   10708:	01813023          	sd	s8,0(sp)
   1070c:	04090063          	beqz	s2,1074c <__call_exitprocs+0x74>
   10710:	00050b13          	mv	s6,a0
   10714:	00058b93          	mv	s7,a1
   10718:	00100a93          	li	s5,1
   1071c:	fff00993          	li	s3,-1
   10720:	00892483          	lw	s1,8(s2)
   10724:	fff4841b          	addw	s0,s1,-1
   10728:	02044263          	bltz	s0,1074c <__call_exitprocs+0x74>
   1072c:	00349493          	sll	s1,s1,0x3
   10730:	009904b3          	add	s1,s2,s1
   10734:	040b8463          	beqz	s7,1077c <__call_exitprocs+0xa4>
   10738:	2084b783          	ld	a5,520(s1)
   1073c:	05778063          	beq	a5,s7,1077c <__call_exitprocs+0xa4>
   10740:	fff4041b          	addw	s0,s0,-1
   10744:	ff848493          	add	s1,s1,-8
   10748:	ff3416e3          	bne	s0,s3,10734 <__call_exitprocs+0x5c>
   1074c:	04813083          	ld	ra,72(sp)
   10750:	04013403          	ld	s0,64(sp)
   10754:	03813483          	ld	s1,56(sp)
   10758:	03013903          	ld	s2,48(sp)
   1075c:	02813983          	ld	s3,40(sp)
   10760:	02013a03          	ld	s4,32(sp)
   10764:	01813a83          	ld	s5,24(sp)
   10768:	01013b03          	ld	s6,16(sp)
   1076c:	00813b83          	ld	s7,8(sp)
   10770:	00013c03          	ld	s8,0(sp)
   10774:	05010113          	add	sp,sp,80
   10778:	00008067          	ret
   1077c:	00892783          	lw	a5,8(s2)
   10780:	0084b703          	ld	a4,8(s1)
   10784:	fff7879b          	addw	a5,a5,-1
   10788:	06878263          	beq	a5,s0,107ec <__call_exitprocs+0x114>
   1078c:	0004b423          	sd	zero,8(s1)
   10790:	fa0708e3          	beqz	a4,10740 <__call_exitprocs+0x68>
   10794:	31092783          	lw	a5,784(s2)
   10798:	008a96bb          	sllw	a3,s5,s0
   1079c:	00892c03          	lw	s8,8(s2)
   107a0:	00d7f7b3          	and	a5,a5,a3
   107a4:	0007879b          	sext.w	a5,a5
   107a8:	02079263          	bnez	a5,107cc <__call_exitprocs+0xf4>
   107ac:	000700e7          	jalr	a4
   107b0:	00892703          	lw	a4,8(s2)
   107b4:	1f8a3783          	ld	a5,504(s4)
   107b8:	01871463          	bne	a4,s8,107c0 <__call_exitprocs+0xe8>
   107bc:	f92782e3          	beq	a5,s2,10740 <__call_exitprocs+0x68>
   107c0:	f80786e3          	beqz	a5,1074c <__call_exitprocs+0x74>
   107c4:	00078913          	mv	s2,a5
   107c8:	f59ff06f          	j	10720 <__call_exitprocs+0x48>
   107cc:	31492783          	lw	a5,788(s2)
   107d0:	1084b583          	ld	a1,264(s1)
   107d4:	00d7f7b3          	and	a5,a5,a3
   107d8:	0007879b          	sext.w	a5,a5
   107dc:	00079c63          	bnez	a5,107f4 <__call_exitprocs+0x11c>
   107e0:	000b0513          	mv	a0,s6
   107e4:	000700e7          	jalr	a4
   107e8:	fc9ff06f          	j	107b0 <__call_exitprocs+0xd8>
   107ec:	00892423          	sw	s0,8(s2)
   107f0:	fa1ff06f          	j	10790 <__call_exitprocs+0xb8>
   107f4:	00058513          	mv	a0,a1
   107f8:	000700e7          	jalr	a4
   107fc:	fb5ff06f          	j	107b0 <__call_exitprocs+0xd8>

0000000000010800 <__libc_fini_array>:
   10800:	fe010113          	add	sp,sp,-32
   10804:	00813823          	sd	s0,16(sp)
   10808:	000117b7          	lui	a5,0x11
   1080c:	00011437          	lui	s0,0x11
   10810:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   10814:	02040413          	add	s0,s0,32 # 11020 <impure_data>
   10818:	40f40433          	sub	s0,s0,a5
   1081c:	00913423          	sd	s1,8(sp)
   10820:	00113c23          	sd	ra,24(sp)
   10824:	40345493          	sra	s1,s0,0x3
   10828:	02048063          	beqz	s1,10848 <__libc_fini_array+0x48>
   1082c:	ff840413          	add	s0,s0,-8
   10830:	00f40433          	add	s0,s0,a5
   10834:	00043783          	ld	a5,0(s0)
   10838:	fff48493          	add	s1,s1,-1
   1083c:	ff840413          	add	s0,s0,-8
   10840:	000780e7          	jalr	a5
   10844:	fe0498e3          	bnez	s1,10834 <__libc_fini_array+0x34>
   10848:	01813083          	ld	ra,24(sp)
   1084c:	01013403          	ld	s0,16(sp)
   10850:	00813483          	ld	s1,8(sp)
   10854:	02010113          	add	sp,sp,32
   10858:	00008067          	ret

000000000001085c <atexit>:
   1085c:	00050593          	mv	a1,a0
   10860:	00000693          	li	a3,0
   10864:	00000613          	li	a2,0
   10868:	00000513          	li	a0,0
   1086c:	0040006f          	j	10870 <__register_exitproc>

0000000000010870 <__register_exitproc>:
   10870:	fd01b703          	ld	a4,-48(gp) # 117f0 <_global_impure_ptr>
   10874:	1f873783          	ld	a5,504(a4)
   10878:	06078063          	beqz	a5,108d8 <__register_exitproc+0x68>
   1087c:	0087a703          	lw	a4,8(a5)
   10880:	01f00813          	li	a6,31
   10884:	08e84663          	blt	a6,a4,10910 <__register_exitproc+0xa0>
   10888:	02050863          	beqz	a0,108b8 <__register_exitproc+0x48>
   1088c:	00371813          	sll	a6,a4,0x3
   10890:	01078833          	add	a6,a5,a6
   10894:	10c83823          	sd	a2,272(a6)
   10898:	3107a883          	lw	a7,784(a5)
   1089c:	00100613          	li	a2,1
   108a0:	00e6163b          	sllw	a2,a2,a4
   108a4:	00c8e8b3          	or	a7,a7,a2
   108a8:	3117a823          	sw	a7,784(a5)
   108ac:	20d83823          	sd	a3,528(a6)
   108b0:	00200693          	li	a3,2
   108b4:	02d50863          	beq	a0,a3,108e4 <__register_exitproc+0x74>
   108b8:	00270693          	add	a3,a4,2
   108bc:	00369693          	sll	a3,a3,0x3
   108c0:	0017071b          	addw	a4,a4,1
   108c4:	00e7a423          	sw	a4,8(a5)
   108c8:	00d787b3          	add	a5,a5,a3
   108cc:	00b7b023          	sd	a1,0(a5)
   108d0:	00000513          	li	a0,0
   108d4:	00008067          	ret
   108d8:	20070793          	add	a5,a4,512
   108dc:	1ef73c23          	sd	a5,504(a4)
   108e0:	f9dff06f          	j	1087c <__register_exitproc+0xc>
   108e4:	3147a683          	lw	a3,788(a5)
   108e8:	00000513          	li	a0,0
   108ec:	00c6e6b3          	or	a3,a3,a2
   108f0:	30d7aa23          	sw	a3,788(a5)
   108f4:	00270693          	add	a3,a4,2
   108f8:	00369693          	sll	a3,a3,0x3
   108fc:	0017071b          	addw	a4,a4,1
   10900:	00e7a423          	sw	a4,8(a5)
   10904:	00d787b3          	add	a5,a5,a3
   10908:	00b7b023          	sd	a1,0(a5)
   1090c:	00008067          	ret
   10910:	fff00513          	li	a0,-1
   10914:	00008067          	ret

0000000000010918 <_exit>:
   10918:	05d00893          	li	a7,93
   1091c:	00000073          	ecall
   10920:	00054463          	bltz	a0,10928 <_exit+0x10>
   10924:	0000006f          	j	10924 <_exit+0xc>
   10928:	ff010113          	add	sp,sp,-16
   1092c:	00813023          	sd	s0,0(sp)
   10930:	00050413          	mv	s0,a0
   10934:	00113423          	sd	ra,8(sp)
   10938:	4080043b          	negw	s0,s0
   1093c:	c1dff0ef          	jal	10558 <__errno>
   10940:	00852023          	sw	s0,0(a0)
   10944:	0000006f          	j	10944 <_exit+0x2c>
