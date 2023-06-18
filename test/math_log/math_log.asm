
math_log.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	add	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	5d0000ef          	jal	106cc <__call_exitprocs>
   10100:	fd01b503          	ld	a0,-48(gp) # 117f0 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	7f8000ef          	jal	1090c <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	7f450513          	add	a0,a0,2036 # 107f4 <__libc_fini_array>
   10128:	7280006f          	j	10850 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00001197          	auipc	gp,0x1
   10134:	6f018193          	add	gp,gp,1776 # 11820 <__global_pointer$>
   10138:	fe818513          	add	a0,gp,-24 # 11808 <completed.1>
   1013c:	02018613          	add	a2,gp,32 # 11840 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	4a8000ef          	jal	105f0 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	70450513          	add	a0,a0,1796 # 10850 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	69c50513          	add	a0,a0,1692 # 107f4 <__libc_fini_array>
   10160:	6f0000ef          	jal	10850 <atexit>
   10164:	3f0000ef          	jal	10554 <__libc_init_array>
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
   10200:	fc043823          	sd	zero,-48(s0)
   10204:	00400793          	li	a5,4
   10208:	fcf42623          	sw	a5,-52(s0)
   1020c:	fcc42783          	lw	a5,-52(s0)
   10210:	d20787d3          	fcvt.d.w	fa5,a5
   10214:	22f78553          	fmv.d	fa0,fa5
   10218:	084000ef          	jal	1029c <log>
   1021c:	22a50753          	fmv.d	fa4,fa0
   10220:	000117b7          	lui	a5,0x11
   10224:	9407b787          	fld	fa5,-1728(a5) # 10940 <_exit+0x34>
   10228:	1af777d3          	fdiv.d	fa5,fa4,fa5
   1022c:	c22797d3          	fcvt.l.d	a5,fa5,rtz
   10230:	fcf43c23          	sd	a5,-40(s0)
   10234:	fd843783          	ld	a5,-40(s0)
   10238:	d227f453          	fcvt.d.l	fs0,a5
   1023c:	fcc42783          	lw	a5,-52(s0)
   10240:	d20787d3          	fcvt.d.w	fa5,a5
   10244:	22f78553          	fmv.d	fa0,fa5
   10248:	054000ef          	jal	1029c <log>
   1024c:	22a50753          	fmv.d	fa4,fa0
   10250:	000117b7          	lui	a5,0x11
   10254:	9407b787          	fld	fa5,-1728(a5) # 10940 <_exit+0x34>
   10258:	1af777d3          	fdiv.d	fa5,fa4,fa5
   1025c:	a2f417d3          	flt.d	a5,fs0,fa5
   10260:	00078863          	beqz	a5,10270 <main+0x90>
   10264:	fd843783          	ld	a5,-40(s0)
   10268:	00178793          	add	a5,a5,1
   1026c:	fcf43c23          	sd	a5,-40(s0)
   10270:	00000013          	nop
   10274:	fd043703          	ld	a4,-48(s0)
   10278:	fd843783          	ld	a5,-40(s0)
   1027c:	fef74ce3          	blt	a4,a5,10274 <main+0x94>
   10280:	00000793          	li	a5,0
   10284:	00078513          	mv	a0,a5
   10288:	04813083          	ld	ra,72(sp)
   1028c:	04013403          	ld	s0,64(sp)
   10290:	03813407          	fld	fs0,56(sp)
   10294:	05010113          	add	sp,sp,80
   10298:	00008067          	ret

000000000001029c <log>:
   1029c:	fe010113          	add	sp,sp,-32
   102a0:	00813427          	fsd	fs0,8(sp)
   102a4:	22a50453          	fmv.d	fs0,fa0
   102a8:	00113c23          	sd	ra,24(sp)
   102ac:	064000ef          	jal	10310 <__ieee754_log>
   102b0:	a28427d3          	feq.d	a5,fs0,fs0
   102b4:	02078463          	beqz	a5,102dc <log+0x40>
   102b8:	f20007d3          	fmv.d.x	fa5,zero
   102bc:	a28797d3          	flt.d	a5,fa5,fs0
   102c0:	00079e63          	bnez	a5,102dc <log+0x40>
   102c4:	a2f427d3          	feq.d	a5,fs0,fa5
   102c8:	02078263          	beqz	a5,102ec <log+0x50>
   102cc:	280000ef          	jal	1054c <__errno>
   102d0:	f481b507          	fld	fa0,-184(gp) # 11768 <__SDATA_BEGIN__>
   102d4:	02200793          	li	a5,34
   102d8:	00f52023          	sw	a5,0(a0) # 11000 <__EH_FRAME_BEGIN__>
   102dc:	01813083          	ld	ra,24(sp)
   102e0:	00813407          	fld	fs0,8(sp)
   102e4:	02010113          	add	sp,sp,32
   102e8:	00008067          	ret
   102ec:	260000ef          	jal	1054c <__errno>
   102f0:	01813083          	ld	ra,24(sp)
   102f4:	00813407          	fld	fs0,8(sp)
   102f8:	02100793          	li	a5,33
   102fc:	00f52023          	sw	a5,0(a0)
   10300:	00011537          	lui	a0,0x11
   10304:	94850513          	add	a0,a0,-1720 # 10948 <_exit+0x3c>
   10308:	02010113          	add	sp,sp,32
   1030c:	2380006f          	j	10544 <nan>

0000000000010310 <__ieee754_log>:
   10310:	e20507d3          	fmv.x.d	a5,fa0
   10314:	00100637          	lui	a2,0x100
   10318:	4207d713          	sra	a4,a5,0x20
   1031c:	0cc75e63          	bge	a4,a2,103f8 <__ieee754_log+0xe8>
   10320:	02171693          	sll	a3,a4,0x21
   10324:	0216d693          	srl	a3,a3,0x21
   10328:	00f6e6b3          	or	a3,a3,a5
   1032c:	0006869b          	sext.w	a3,a3
   10330:	16068c63          	beqz	a3,104a8 <__ieee754_log+0x198>
   10334:	1e074263          	bltz	a4,10518 <__ieee754_log+0x208>
   10338:	f581b787          	fld	fa5,-168(gp) # 11778 <__SDATA_BEGIN__+0x10>
   1033c:	7ff006b7          	lui	a3,0x7ff00
   10340:	fca00613          	li	a2,-54
   10344:	12f577d3          	fmul.d	fa5,fa0,fa5
   10348:	e20787d3          	fmv.x.d	a5,fa5
   1034c:	4207d713          	sra	a4,a5,0x20
   10350:	0ad75a63          	bge	a4,a3,10404 <__ieee754_log+0xf4>
   10354:	00100837          	lui	a6,0x100
   10358:	fff80813          	add	a6,a6,-1 # fffff <__BSS_END__+0xee7bf>
   1035c:	000966b7          	lui	a3,0x96
   10360:	010778b3          	and	a7,a4,a6
   10364:	f646869b          	addw	a3,a3,-156 # 95f64 <__BSS_END__+0x84724>
   10368:	001005b7          	lui	a1,0x100
   1036c:	00d886bb          	addw	a3,a7,a3
   10370:	4147571b          	sraw	a4,a4,0x14
   10374:	00b6f6b3          	and	a3,a3,a1
   10378:	c017071b          	addw	a4,a4,-1023
   1037c:	3ff005b7          	lui	a1,0x3ff00
   10380:	00c7073b          	addw	a4,a4,a2
   10384:	00b6c5b3          	xor	a1,a3,a1
   10388:	fff00613          	li	a2,-1
   1038c:	02065613          	srl	a2,a2,0x20
   10390:	00b8e5b3          	or	a1,a7,a1
   10394:	02059593          	sll	a1,a1,0x20
   10398:	00f677b3          	and	a5,a2,a5
   1039c:	00b7e7b3          	or	a5,a5,a1
   103a0:	f601b507          	fld	fa0,-160(gp) # 11780 <__SDATA_BEGIN__+0x18>
   103a4:	f20787d3          	fmv.d.x	fa5,a5
   103a8:	0028851b          	addw	a0,a7,2
   103ac:	01057633          	and	a2,a0,a6
   103b0:	4146d69b          	sraw	a3,a3,0x14
   103b4:	00e686bb          	addw	a3,a3,a4
   103b8:	0006071b          	sext.w	a4,a2
   103bc:	00200613          	li	a2,2
   103c0:	0aa7f553          	fsub.d	fa0,fa5,fa0
   103c4:	0006859b          	sext.w	a1,a3
   103c8:	04e64463          	blt	a2,a4,10410 <__ieee754_log+0x100>
   103cc:	f20007d3          	fmv.d.x	fa5,zero
   103d0:	a2f527d3          	feq.d	a5,fa0,fa5
   103d4:	0e078263          	beqz	a5,104b8 <__ieee754_log+0x1a8>
   103d8:	22f78553          	fmv.d	fa0,fa5
   103dc:	12058863          	beqz	a1,1050c <__ieee754_log+0x1fc>
   103e0:	d2068553          	fcvt.d.w	fa0,a3
   103e4:	f681b787          	fld	fa5,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   103e8:	f701b707          	fld	fa4,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   103ec:	12f577d3          	fmul.d	fa5,fa0,fa5
   103f0:	7ae57543          	fmadd.d	fa0,fa0,fa4,fa5
   103f4:	00008067          	ret
   103f8:	7ff006b7          	lui	a3,0x7ff00
   103fc:	00000613          	li	a2,0
   10400:	f4d74ae3          	blt	a4,a3,10354 <__ieee754_log+0x44>
   10404:	f20787d3          	fmv.d.x	fa5,a5
   10408:	02f7f553          	fadd.d	fa0,fa5,fa5
   1040c:	00008067          	ret
   10410:	f881b687          	fld	fa3,-120(gp) # 117a8 <__SDATA_BEGIN__+0x40>
   10414:	0006c737          	lui	a4,0x6c
   10418:	fff9f7b7          	lui	a5,0xfff9f
   1041c:	02d576d3          	fadd.d	fa3,fa0,fa3
   10420:	b867879b          	addw	a5,a5,-1146 # fffffffffff9eb86 <__BSS_END__+0xfffffffffff8d346>
   10424:	8517071b          	addw	a4,a4,-1967 # 6b851 <__BSS_END__+0x5a011>
   10428:	4117073b          	subw	a4,a4,a7
   1042c:	011787bb          	addw	a5,a5,a7
   10430:	00e7e7b3          	or	a5,a5,a4
   10434:	1ad576d3          	fdiv.d	fa3,fa0,fa3
   10438:	fa81b707          	fld	fa4,-88(gp) # 117c8 <__SDATA_BEGIN__+0x60>
   1043c:	fb01b787          	fld	fa5,-80(gp) # 117d0 <__SDATA_BEGIN__+0x68>
   10440:	0007879b          	sext.w	a5,a5
   10444:	d20680d3          	fcvt.d.w	ft1,a3
   10448:	12d6f5d3          	fmul.d	fa1,fa3,fa3
   1044c:	12b5f653          	fmul.d	fa2,fa1,fa1
   10450:	7ae67743          	fmadd.d	fa4,fa2,fa4,fa5
   10454:	f901b787          	fld	fa5,-112(gp) # 117b0 <__SDATA_BEGIN__+0x48>
   10458:	f981b007          	fld	ft0,-104(gp) # 117b8 <__SDATA_BEGIN__+0x50>
   1045c:	02f677c3          	fmadd.d	fa5,fa2,fa5,ft0
   10460:	fb81b007          	fld	ft0,-72(gp) # 117d8 <__SDATA_BEGIN__+0x70>
   10464:	02c77743          	fmadd.d	fa4,fa4,fa2,ft0
   10468:	fa01b007          	fld	ft0,-96(gp) # 117c0 <__SDATA_BEGIN__+0x58>
   1046c:	02c7f7c3          	fmadd.d	fa5,fa5,fa2,ft0
   10470:	fc01b007          	fld	ft0,-64(gp) # 117e0 <__SDATA_BEGIN__+0x78>
   10474:	02c77743          	fmadd.d	fa4,fa4,fa2,ft0
   10478:	12b77753          	fmul.d	fa4,fa4,fa1
   1047c:	72c7f7c3          	fmadd.d	fa5,fa5,fa2,fa4
   10480:	06f05663          	blez	a5,104ec <__ieee754_log+0x1dc>
   10484:	f801b707          	fld	fa4,-128(gp) # 117a0 <__SDATA_BEGIN__+0x38>
   10488:	12e57753          	fmul.d	fa4,fa0,fa4
   1048c:	12a77753          	fmul.d	fa4,fa4,fa0
   10490:	02e7f7d3          	fadd.d	fa5,fa5,fa4
   10494:	12d7f7d3          	fmul.d	fa5,fa5,fa3
   10498:	08059863          	bnez	a1,10528 <__ieee754_log+0x218>
   1049c:	0af77753          	fsub.d	fa4,fa4,fa5
   104a0:	0ae57553          	fsub.d	fa0,fa0,fa4
   104a4:	00008067          	ret
   104a8:	f20007d3          	fmv.d.x	fa5,zero
   104ac:	f501b507          	fld	fa0,-176(gp) # 11770 <__SDATA_BEGIN__+0x8>
   104b0:	1af57553          	fdiv.d	fa0,fa0,fa5
   104b4:	00008067          	ret
   104b8:	f781b707          	fld	fa4,-136(gp) # 11798 <__SDATA_BEGIN__+0x30>
   104bc:	f801b687          	fld	fa3,-128(gp) # 117a0 <__SDATA_BEGIN__+0x38>
   104c0:	12a577d3          	fmul.d	fa5,fa0,fa0
   104c4:	6ae5774b          	fnmsub.d	fa4,fa0,fa4,fa3
   104c8:	12e7f7d3          	fmul.d	fa5,fa5,fa4
   104cc:	04058263          	beqz	a1,10510 <__ieee754_log+0x200>
   104d0:	d20686d3          	fcvt.d.w	fa3,a3
   104d4:	f681b707          	fld	fa4,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   104d8:	7ae6f7cb          	fnmsub.d	fa5,fa3,fa4,fa5
   104dc:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
   104e0:	f701b507          	fld	fa0,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   104e4:	7aa6f547          	fmsub.d	fa0,fa3,fa0,fa5
   104e8:	00008067          	ret
   104ec:	0af577d3          	fsub.d	fa5,fa0,fa5
   104f0:	12d7f7d3          	fmul.d	fa5,fa5,fa3
   104f4:	00058e63          	beqz	a1,10510 <__ieee754_log+0x200>
   104f8:	f681b707          	fld	fa4,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   104fc:	7ae0f7cb          	fnmsub.d	fa5,ft1,fa4,fa5
   10500:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
   10504:	f701b507          	fld	fa0,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   10508:	7aa0f547          	fmsub.d	fa0,ft1,fa0,fa5
   1050c:	00008067          	ret
   10510:	0af57553          	fsub.d	fa0,fa0,fa5
   10514:	00008067          	ret
   10518:	0aa57553          	fsub.d	fa0,fa0,fa0
   1051c:	f20007d3          	fmv.d.x	fa5,zero
   10520:	1af57553          	fdiv.d	fa0,fa0,fa5
   10524:	00008067          	ret
   10528:	f681b687          	fld	fa3,-152(gp) # 11788 <__SDATA_BEGIN__+0x20>
   1052c:	7ad0f7c3          	fmadd.d	fa5,ft1,fa3,fa5
   10530:	0af77753          	fsub.d	fa4,fa4,fa5
   10534:	0aa77753          	fsub.d	fa4,fa4,fa0
   10538:	f701b507          	fld	fa0,-144(gp) # 11790 <__SDATA_BEGIN__+0x28>
   1053c:	72a0f547          	fmsub.d	fa0,ft1,fa0,fa4
   10540:	00008067          	ret

0000000000010544 <nan>:
   10544:	fc81b507          	fld	fa0,-56(gp) # 117e8 <__SDATA_BEGIN__+0x80>
   10548:	00008067          	ret

000000000001054c <__errno>:
   1054c:	fe01b503          	ld	a0,-32(gp) # 11800 <_impure_ptr>
   10550:	00008067          	ret

0000000000010554 <__libc_init_array>:
   10554:	fe010113          	add	sp,sp,-32
   10558:	00813823          	sd	s0,16(sp)
   1055c:	000117b7          	lui	a5,0x11
   10560:	00011437          	lui	s0,0x11
   10564:	01213023          	sd	s2,0(sp)
   10568:	00478793          	add	a5,a5,4 # 11004 <__preinit_array_end>
   1056c:	00440713          	add	a4,s0,4 # 11004 <__preinit_array_end>
   10570:	00113c23          	sd	ra,24(sp)
   10574:	00913423          	sd	s1,8(sp)
   10578:	40e78933          	sub	s2,a5,a4
   1057c:	02e78263          	beq	a5,a4,105a0 <__libc_init_array+0x4c>
   10580:	40395913          	sra	s2,s2,0x3
   10584:	00440413          	add	s0,s0,4
   10588:	00000493          	li	s1,0
   1058c:	00043783          	ld	a5,0(s0)
   10590:	00148493          	add	s1,s1,1
   10594:	00840413          	add	s0,s0,8
   10598:	000780e7          	jalr	a5
   1059c:	ff24e8e3          	bltu	s1,s2,1058c <__libc_init_array+0x38>
   105a0:	00011437          	lui	s0,0x11
   105a4:	000117b7          	lui	a5,0x11
   105a8:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   105ac:	00840713          	add	a4,s0,8 # 11008 <__init_array_start>
   105b0:	40e78933          	sub	s2,a5,a4
   105b4:	40395913          	sra	s2,s2,0x3
   105b8:	02e78063          	beq	a5,a4,105d8 <__libc_init_array+0x84>
   105bc:	00840413          	add	s0,s0,8
   105c0:	00000493          	li	s1,0
   105c4:	00043783          	ld	a5,0(s0)
   105c8:	00148493          	add	s1,s1,1
   105cc:	00840413          	add	s0,s0,8
   105d0:	000780e7          	jalr	a5
   105d4:	ff24e8e3          	bltu	s1,s2,105c4 <__libc_init_array+0x70>
   105d8:	01813083          	ld	ra,24(sp)
   105dc:	01013403          	ld	s0,16(sp)
   105e0:	00813483          	ld	s1,8(sp)
   105e4:	00013903          	ld	s2,0(sp)
   105e8:	02010113          	add	sp,sp,32
   105ec:	00008067          	ret

00000000000105f0 <memset>:
   105f0:	00f00313          	li	t1,15
   105f4:	00050713          	mv	a4,a0
   105f8:	02c37a63          	bgeu	t1,a2,1062c <memset+0x3c>
   105fc:	00f77793          	and	a5,a4,15
   10600:	0a079063          	bnez	a5,106a0 <memset+0xb0>
   10604:	06059e63          	bnez	a1,10680 <memset+0x90>
   10608:	ff067693          	and	a3,a2,-16
   1060c:	00f67613          	and	a2,a2,15
   10610:	00e686b3          	add	a3,a3,a4
   10614:	00b73023          	sd	a1,0(a4)
   10618:	00b73423          	sd	a1,8(a4)
   1061c:	01070713          	add	a4,a4,16
   10620:	fed76ae3          	bltu	a4,a3,10614 <memset+0x24>
   10624:	00061463          	bnez	a2,1062c <memset+0x3c>
   10628:	00008067          	ret
   1062c:	40c306b3          	sub	a3,t1,a2
   10630:	00269693          	sll	a3,a3,0x2
   10634:	00000297          	auipc	t0,0x0
   10638:	005686b3          	add	a3,a3,t0
   1063c:	00c68067          	jr	12(a3) # 7ff0000c <__BSS_END__+0x7feee7cc>
   10640:	00b70723          	sb	a1,14(a4)
   10644:	00b706a3          	sb	a1,13(a4)
   10648:	00b70623          	sb	a1,12(a4)
   1064c:	00b705a3          	sb	a1,11(a4)
   10650:	00b70523          	sb	a1,10(a4)
   10654:	00b704a3          	sb	a1,9(a4)
   10658:	00b70423          	sb	a1,8(a4)
   1065c:	00b703a3          	sb	a1,7(a4)
   10660:	00b70323          	sb	a1,6(a4)
   10664:	00b702a3          	sb	a1,5(a4)
   10668:	00b70223          	sb	a1,4(a4)
   1066c:	00b701a3          	sb	a1,3(a4)
   10670:	00b70123          	sb	a1,2(a4)
   10674:	00b700a3          	sb	a1,1(a4)
   10678:	00b70023          	sb	a1,0(a4)
   1067c:	00008067          	ret
   10680:	0ff5f593          	zext.b	a1,a1
   10684:	00859693          	sll	a3,a1,0x8
   10688:	00d5e5b3          	or	a1,a1,a3
   1068c:	01059693          	sll	a3,a1,0x10
   10690:	00d5e5b3          	or	a1,a1,a3
   10694:	02059693          	sll	a3,a1,0x20
   10698:	00d5e5b3          	or	a1,a1,a3
   1069c:	f6dff06f          	j	10608 <memset+0x18>
   106a0:	00279693          	sll	a3,a5,0x2
   106a4:	00000297          	auipc	t0,0x0
   106a8:	005686b3          	add	a3,a3,t0
   106ac:	00008293          	mv	t0,ra
   106b0:	f98680e7          	jalr	-104(a3)
   106b4:	00028093          	mv	ra,t0
   106b8:	ff078793          	add	a5,a5,-16
   106bc:	40f70733          	sub	a4,a4,a5
   106c0:	00f60633          	add	a2,a2,a5
   106c4:	f6c374e3          	bgeu	t1,a2,1062c <memset+0x3c>
   106c8:	f3dff06f          	j	10604 <memset+0x14>

00000000000106cc <__call_exitprocs>:
   106cc:	fb010113          	add	sp,sp,-80
   106d0:	03413023          	sd	s4,32(sp)
   106d4:	fd01ba03          	ld	s4,-48(gp) # 117f0 <_global_impure_ptr>
   106d8:	03213823          	sd	s2,48(sp)
   106dc:	04113423          	sd	ra,72(sp)
   106e0:	1f8a3903          	ld	s2,504(s4)
   106e4:	04813023          	sd	s0,64(sp)
   106e8:	02913c23          	sd	s1,56(sp)
   106ec:	03313423          	sd	s3,40(sp)
   106f0:	01513c23          	sd	s5,24(sp)
   106f4:	01613823          	sd	s6,16(sp)
   106f8:	01713423          	sd	s7,8(sp)
   106fc:	01813023          	sd	s8,0(sp)
   10700:	04090063          	beqz	s2,10740 <__call_exitprocs+0x74>
   10704:	00050b13          	mv	s6,a0
   10708:	00058b93          	mv	s7,a1
   1070c:	00100a93          	li	s5,1
   10710:	fff00993          	li	s3,-1
   10714:	00892483          	lw	s1,8(s2)
   10718:	fff4841b          	addw	s0,s1,-1
   1071c:	02044263          	bltz	s0,10740 <__call_exitprocs+0x74>
   10720:	00349493          	sll	s1,s1,0x3
   10724:	009904b3          	add	s1,s2,s1
   10728:	040b8463          	beqz	s7,10770 <__call_exitprocs+0xa4>
   1072c:	2084b783          	ld	a5,520(s1)
   10730:	05778063          	beq	a5,s7,10770 <__call_exitprocs+0xa4>
   10734:	fff4041b          	addw	s0,s0,-1
   10738:	ff848493          	add	s1,s1,-8
   1073c:	ff3416e3          	bne	s0,s3,10728 <__call_exitprocs+0x5c>
   10740:	04813083          	ld	ra,72(sp)
   10744:	04013403          	ld	s0,64(sp)
   10748:	03813483          	ld	s1,56(sp)
   1074c:	03013903          	ld	s2,48(sp)
   10750:	02813983          	ld	s3,40(sp)
   10754:	02013a03          	ld	s4,32(sp)
   10758:	01813a83          	ld	s5,24(sp)
   1075c:	01013b03          	ld	s6,16(sp)
   10760:	00813b83          	ld	s7,8(sp)
   10764:	00013c03          	ld	s8,0(sp)
   10768:	05010113          	add	sp,sp,80
   1076c:	00008067          	ret
   10770:	00892783          	lw	a5,8(s2)
   10774:	0084b703          	ld	a4,8(s1)
   10778:	fff7879b          	addw	a5,a5,-1
   1077c:	06878263          	beq	a5,s0,107e0 <__call_exitprocs+0x114>
   10780:	0004b423          	sd	zero,8(s1)
   10784:	fa0708e3          	beqz	a4,10734 <__call_exitprocs+0x68>
   10788:	31092783          	lw	a5,784(s2)
   1078c:	008a96bb          	sllw	a3,s5,s0
   10790:	00892c03          	lw	s8,8(s2)
   10794:	00d7f7b3          	and	a5,a5,a3
   10798:	0007879b          	sext.w	a5,a5
   1079c:	02079263          	bnez	a5,107c0 <__call_exitprocs+0xf4>
   107a0:	000700e7          	jalr	a4
   107a4:	00892703          	lw	a4,8(s2)
   107a8:	1f8a3783          	ld	a5,504(s4)
   107ac:	01871463          	bne	a4,s8,107b4 <__call_exitprocs+0xe8>
   107b0:	f92782e3          	beq	a5,s2,10734 <__call_exitprocs+0x68>
   107b4:	f80786e3          	beqz	a5,10740 <__call_exitprocs+0x74>
   107b8:	00078913          	mv	s2,a5
   107bc:	f59ff06f          	j	10714 <__call_exitprocs+0x48>
   107c0:	31492783          	lw	a5,788(s2)
   107c4:	1084b583          	ld	a1,264(s1)
   107c8:	00d7f7b3          	and	a5,a5,a3
   107cc:	0007879b          	sext.w	a5,a5
   107d0:	00079c63          	bnez	a5,107e8 <__call_exitprocs+0x11c>
   107d4:	000b0513          	mv	a0,s6
   107d8:	000700e7          	jalr	a4
   107dc:	fc9ff06f          	j	107a4 <__call_exitprocs+0xd8>
   107e0:	00892423          	sw	s0,8(s2)
   107e4:	fa1ff06f          	j	10784 <__call_exitprocs+0xb8>
   107e8:	00058513          	mv	a0,a1
   107ec:	000700e7          	jalr	a4
   107f0:	fb5ff06f          	j	107a4 <__call_exitprocs+0xd8>

00000000000107f4 <__libc_fini_array>:
   107f4:	fe010113          	add	sp,sp,-32
   107f8:	00813823          	sd	s0,16(sp)
   107fc:	000117b7          	lui	a5,0x11
   10800:	00011437          	lui	s0,0x11
   10804:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   10808:	02040413          	add	s0,s0,32 # 11020 <impure_data>
   1080c:	40f40433          	sub	s0,s0,a5
   10810:	00913423          	sd	s1,8(sp)
   10814:	00113c23          	sd	ra,24(sp)
   10818:	40345493          	sra	s1,s0,0x3
   1081c:	02048063          	beqz	s1,1083c <__libc_fini_array+0x48>
   10820:	ff840413          	add	s0,s0,-8
   10824:	00f40433          	add	s0,s0,a5
   10828:	00043783          	ld	a5,0(s0)
   1082c:	fff48493          	add	s1,s1,-1
   10830:	ff840413          	add	s0,s0,-8
   10834:	000780e7          	jalr	a5
   10838:	fe0498e3          	bnez	s1,10828 <__libc_fini_array+0x34>
   1083c:	01813083          	ld	ra,24(sp)
   10840:	01013403          	ld	s0,16(sp)
   10844:	00813483          	ld	s1,8(sp)
   10848:	02010113          	add	sp,sp,32
   1084c:	00008067          	ret

0000000000010850 <atexit>:
   10850:	00050593          	mv	a1,a0
   10854:	00000693          	li	a3,0
   10858:	00000613          	li	a2,0
   1085c:	00000513          	li	a0,0
   10860:	0040006f          	j	10864 <__register_exitproc>

0000000000010864 <__register_exitproc>:
   10864:	fd01b703          	ld	a4,-48(gp) # 117f0 <_global_impure_ptr>
   10868:	1f873783          	ld	a5,504(a4)
   1086c:	06078063          	beqz	a5,108cc <__register_exitproc+0x68>
   10870:	0087a703          	lw	a4,8(a5)
   10874:	01f00813          	li	a6,31
   10878:	08e84663          	blt	a6,a4,10904 <__register_exitproc+0xa0>
   1087c:	02050863          	beqz	a0,108ac <__register_exitproc+0x48>
   10880:	00371813          	sll	a6,a4,0x3
   10884:	01078833          	add	a6,a5,a6
   10888:	10c83823          	sd	a2,272(a6)
   1088c:	3107a883          	lw	a7,784(a5)
   10890:	00100613          	li	a2,1
   10894:	00e6163b          	sllw	a2,a2,a4
   10898:	00c8e8b3          	or	a7,a7,a2
   1089c:	3117a823          	sw	a7,784(a5)
   108a0:	20d83823          	sd	a3,528(a6)
   108a4:	00200693          	li	a3,2
   108a8:	02d50863          	beq	a0,a3,108d8 <__register_exitproc+0x74>
   108ac:	00270693          	add	a3,a4,2
   108b0:	00369693          	sll	a3,a3,0x3
   108b4:	0017071b          	addw	a4,a4,1
   108b8:	00e7a423          	sw	a4,8(a5)
   108bc:	00d787b3          	add	a5,a5,a3
   108c0:	00b7b023          	sd	a1,0(a5)
   108c4:	00000513          	li	a0,0
   108c8:	00008067          	ret
   108cc:	20070793          	add	a5,a4,512
   108d0:	1ef73c23          	sd	a5,504(a4)
   108d4:	f9dff06f          	j	10870 <__register_exitproc+0xc>
   108d8:	3147a683          	lw	a3,788(a5)
   108dc:	00000513          	li	a0,0
   108e0:	00c6e6b3          	or	a3,a3,a2
   108e4:	30d7aa23          	sw	a3,788(a5)
   108e8:	00270693          	add	a3,a4,2
   108ec:	00369693          	sll	a3,a3,0x3
   108f0:	0017071b          	addw	a4,a4,1
   108f4:	00e7a423          	sw	a4,8(a5)
   108f8:	00d787b3          	add	a5,a5,a3
   108fc:	00b7b023          	sd	a1,0(a5)
   10900:	00008067          	ret
   10904:	fff00513          	li	a0,-1
   10908:	00008067          	ret

000000000001090c <_exit>:
   1090c:	05d00893          	li	a7,93
   10910:	00000073          	ecall
   10914:	00054463          	bltz	a0,1091c <_exit+0x10>
   10918:	0000006f          	j	10918 <_exit+0xc>
   1091c:	ff010113          	add	sp,sp,-16
   10920:	00813023          	sd	s0,0(sp)
   10924:	00050413          	mv	s0,a0
   10928:	00113423          	sd	ra,8(sp)
   1092c:	4080043b          	negw	s0,s0
   10930:	c1dff0ef          	jal	1054c <__errno>
   10934:	00852023          	sw	s0,0(a0)
   10938:	0000006f          	j	10938 <_exit+0x2c>
