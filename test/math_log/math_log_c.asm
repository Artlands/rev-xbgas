
math_log.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <_start>:
   100b0:	00002197          	auipc	gp,0x2
   100b4:	ea818193          	addi	gp,gp,-344 # 11f58 <__global_pointer$>
   100b8:	8b018513          	addi	a0,gp,-1872 # 11808 <_edata>
   100bc:	90018613          	addi	a2,gp,-1792 # 11858 <_end>
   100c0:	8e09                	sub	a2,a2,a0
   100c2:	4581                	li	a1,0
   100c4:	522000ef          	jal	ra,105e6 <memset>
   100c8:	00000517          	auipc	a0,0x0
   100cc:	46850513          	addi	a0,a0,1128 # 10530 <__libc_fini_array>
   100d0:	00000097          	auipc	ra,0x0
   100d4:	426080e7          	jalr	1062(ra) # 104f6 <atexit>
   100d8:	00000097          	auipc	ra,0x0
   100dc:	4a6080e7          	jalr	1190(ra) # 1057e <__libc_init_array>
   100e0:	4502                	lw	a0,0(sp)
   100e2:	002c                	addi	a1,sp,8
   100e4:	4601                	li	a2,0
   100e6:	00000097          	auipc	ra,0x0
   100ea:	0c4080e7          	jalr	196(ra) # 101aa <main>
   100ee:	00000317          	auipc	t1,0x0
   100f2:	41e30067          	jr	1054(t1) # 1050c <exit>

00000000000100f6 <_fini>:
   100f6:	8082                	ret

00000000000100f8 <deregister_tm_clones>:
   100f8:	6545                	lui	a0,0x11
   100fa:	67c5                	lui	a5,0x11
   100fc:	75850713          	addi	a4,a0,1880 # 11758 <__TMC_END__>
   10100:	75878793          	addi	a5,a5,1880 # 11758 <__TMC_END__>
   10104:	00e78b63          	beq	a5,a4,1011a <deregister_tm_clones+0x22>
   10108:	00000337          	lui	t1,0x0
   1010c:	00030313          	mv	t1,t1
   10110:	00030563          	beqz	t1,1011a <deregister_tm_clones+0x22>
   10114:	75850513          	addi	a0,a0,1880
   10118:	8302                	jr	t1
   1011a:	8082                	ret

000000000001011c <register_tm_clones>:
   1011c:	67c5                	lui	a5,0x11
   1011e:	6545                	lui	a0,0x11
   10120:	75878593          	addi	a1,a5,1880 # 11758 <__TMC_END__>
   10124:	75850793          	addi	a5,a0,1880 # 11758 <__TMC_END__>
   10128:	8d9d                	sub	a1,a1,a5
   1012a:	858d                	srai	a1,a1,0x3
   1012c:	4789                	li	a5,2
   1012e:	02f5c5b3          	div	a1,a1,a5
   10132:	c991                	beqz	a1,10146 <register_tm_clones+0x2a>
   10134:	00000337          	lui	t1,0x0
   10138:	00030313          	mv	t1,t1
   1013c:	00030563          	beqz	t1,10146 <register_tm_clones+0x2a>
   10140:	75850513          	addi	a0,a0,1880
   10144:	8302                	jr	t1
   10146:	8082                	ret

0000000000010148 <__do_global_dtors_aux>:
   10148:	8b81c703          	lbu	a4,-1864(gp) # 11810 <completed.5184>
   1014c:	eb15                	bnez	a4,10180 <__do_global_dtors_aux+0x38>
   1014e:	1141                	addi	sp,sp,-16
   10150:	e022                	sd	s0,0(sp)
   10152:	e406                	sd	ra,8(sp)
   10154:	843e                	mv	s0,a5
   10156:	fa3ff0ef          	jal	ra,100f8 <deregister_tm_clones>
   1015a:	000007b7          	lui	a5,0x0
   1015e:	00078793          	mv	a5,a5
   10162:	cb81                	beqz	a5,10172 <__do_global_dtors_aux+0x2a>
   10164:	6545                	lui	a0,0x11
   10166:	bc850513          	addi	a0,a0,-1080 # 10bc8 <__EH_FRAME_BEGIN__>
   1016a:	ffff0097          	auipc	ra,0xffff0
   1016e:	e96080e7          	jalr	-362(ra) # 0 <_start-0x100b0>
   10172:	4785                	li	a5,1
   10174:	8af18c23          	sb	a5,-1864(gp) # 11810 <completed.5184>
   10178:	60a2                	ld	ra,8(sp)
   1017a:	6402                	ld	s0,0(sp)
   1017c:	0141                	addi	sp,sp,16
   1017e:	8082                	ret
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	000007b7          	lui	a5,0x0
   10186:	00078793          	mv	a5,a5
   1018a:	cf91                	beqz	a5,101a6 <frame_dummy+0x24>
   1018c:	6545                	lui	a0,0x11
   1018e:	1141                	addi	sp,sp,-16
   10190:	8c018593          	addi	a1,gp,-1856 # 11818 <object.5189>
   10194:	bc850513          	addi	a0,a0,-1080 # 10bc8 <__EH_FRAME_BEGIN__>
   10198:	e406                	sd	ra,8(sp)
   1019a:	ffff0097          	auipc	ra,0xffff0
   1019e:	e66080e7          	jalr	-410(ra) # 0 <_start-0x100b0>
   101a2:	60a2                	ld	ra,8(sp)
   101a4:	0141                	addi	sp,sp,16
   101a6:	f77ff06f          	j	1011c <register_tm_clones>

00000000000101aa <main>:
   101aa:	7179                	addi	sp,sp,-48
   101ac:	f406                	sd	ra,40(sp)
   101ae:	f022                	sd	s0,32(sp)
   101b0:	1800                	addi	s0,sp,48
   101b2:	87aa                	mv	a5,a0
   101b4:	fcb43823          	sd	a1,-48(s0)
   101b8:	fcf42e23          	sw	a5,-36(s0)
   101bc:	4791                	li	a5,4
   101be:	fef42623          	sw	a5,-20(s0)
   101c2:	fec42783          	lw	a5,-20(s0)
   101c6:	d20787d3          	fcvt.d.w	fa5,a5
   101ca:	22f78553          	fmv.d	fa0,fa5
   101ce:	036000ef          	jal	ra,10204 <log>
   101d2:	22a50753          	fmv.d	fa4,fa0
   101d6:	67c5                	lui	a5,0x11
   101d8:	bb07b787          	fld	fa5,-1104(a5) # 10bb0 <_exit+0x20>
   101dc:	1af777d3          	fdiv.d	fa5,fa4,fa5
   101e0:	c20797d3          	fcvt.w.d	a5,fa5,rtz
   101e4:	fef42423          	sw	a5,-24(s0)
   101e8:	fe842783          	lw	a5,-24(s0)
   101ec:	0007871b          	sext.w	a4,a5
   101f0:	4789                	li	a5,2
   101f2:	fef71be3          	bne	a4,a5,101e8 <main+0x3e>
   101f6:	4781                	li	a5,0
   101f8:	853e                	mv	a0,a5
   101fa:	70a2                	ld	ra,40(sp)
   101fc:	7402                	ld	s0,32(sp)
   101fe:	6145                	addi	sp,sp,48
   10200:	8082                	ret
	...

0000000000010204 <log>:
   10204:	715d                	addi	sp,sp,-80
   10206:	bc22                	fsd	fs0,56(sp)
   10208:	e486                	sd	ra,72(sp)
   1020a:	22a50453          	fmv.d	fs0,fa0
   1020e:	0b4000ef          	jal	ra,102c2 <__ieee754_log>
   10212:	8981a703          	lw	a4,-1896(gp) # 117f0 <__fdlib_version>
   10216:	57fd                	li	a5,-1
   10218:	0af70063          	beq	a4,a5,102b8 <log+0xb4>
   1021c:	a28427d3          	feq.d	a5,fs0,fs0
   10220:	cfc1                	beqz	a5,102b8 <log+0xb4>
   10222:	f20007d3          	fmv.d.x	fa5,zero
   10226:	a28797d3          	flt.d	a5,fa5,fs0
   1022a:	e7d9                	bnez	a5,102b8 <log+0xb4>
   1022c:	000116b7          	lui	a3,0x11
   10230:	bb868693          	addi	a3,a3,-1096 # 10bb8 <_exit+0x28>
   10234:	e436                	sd	a3,8(sp)
   10236:	d402                	sw	zero,40(sp)
   10238:	a822                	fsd	fs0,16(sp)
   1023a:	ac22                	fsd	fs0,24(sp)
   1023c:	a2f427d3          	feq.d	a5,fs0,fa5
   10240:	e315                	bnez	a4,10264 <log+0x60>
   10242:	000116b7          	lui	a3,0x11
   10246:	7586b787          	fld	fa5,1880(a3) # 11758 <__TMC_END__>
   1024a:	b03e                	fsd	fa5,32(sp)
   1024c:	eba9                	bnez	a5,1029e <log+0x9a>
   1024e:	4785                	li	a5,1
   10250:	c03e                	sw	a5,0(sp)
   10252:	4789                	li	a5,2
   10254:	02f71963          	bne	a4,a5,10286 <log+0x82>
   10258:	2ac000ef          	jal	ra,10504 <__errno>
   1025c:	02100793          	li	a5,33
   10260:	c11c                	sw	a5,0(a0)
   10262:	a035                	j	1028e <log+0x8a>
   10264:	000116b7          	lui	a3,0x11
   10268:	7606b787          	fld	fa5,1888(a3) # 11760 <__TMC_END__+0x8>
   1026c:	b03e                	fsd	fa5,32(sp)
   1026e:	d3e5                	beqz	a5,1024e <log+0x4a>
   10270:	4789                	li	a5,2
   10272:	c03e                	sw	a5,0(sp)
   10274:	4789                	li	a5,2
   10276:	02f71663          	bne	a4,a5,102a2 <log+0x9e>
   1027a:	28a000ef          	jal	ra,10504 <__errno>
   1027e:	02200793          	li	a5,34
   10282:	c11c                	sw	a5,0(a0)
   10284:	a01d                	j	102aa <log+0xa6>
   10286:	850a                	mv	a0,sp
   10288:	25c000ef          	jal	ra,104e4 <matherr>
   1028c:	d571                	beqz	a0,10258 <log+0x54>
   1028e:	00011537          	lui	a0,0x11
   10292:	bc050513          	addi	a0,a0,-1088 # 10bc0 <_exit+0x30>
   10296:	254000ef          	jal	ra,104ea <nan>
   1029a:	b02a                	fsd	fa0,32(sp)
   1029c:	a039                	j	102aa <log+0xa6>
   1029e:	4789                	li	a5,2
   102a0:	c03e                	sw	a5,0(sp)
   102a2:	850a                	mv	a0,sp
   102a4:	240000ef          	jal	ra,104e4 <matherr>
   102a8:	d969                	beqz	a0,1027a <log+0x76>
   102aa:	57a2                	lw	a5,40(sp)
   102ac:	c789                	beqz	a5,102b6 <log+0xb2>
   102ae:	256000ef          	jal	ra,10504 <__errno>
   102b2:	57a2                	lw	a5,40(sp)
   102b4:	c11c                	sw	a5,0(a0)
   102b6:	3502                	fld	fa0,32(sp)
   102b8:	60a6                	ld	ra,72(sp)
   102ba:	3462                	fld	fs0,56(sp)
   102bc:	6161                	addi	sp,sp,80
   102be:	8082                	ret
	...

00000000000102c2 <__ieee754_log>:
   102c2:	e20507d3          	fmv.x.d	a5,fa0
   102c6:	00100637          	lui	a2,0x100
   102ca:	4207d713          	srai	a4,a5,0x20
   102ce:	0007069b          	sext.w	a3,a4
   102d2:	04c6df63          	ble	a2,a3,10330 <__ieee754_log+0x6e>
   102d6:	80000637          	lui	a2,0x80000
   102da:	fff64613          	not	a2,a2
   102de:	8f71                	and	a4,a4,a2
   102e0:	8f5d                	or	a4,a4,a5
   102e2:	2701                	sext.w	a4,a4
   102e4:	eb11                	bnez	a4,102f8 <__ieee754_log+0x36>
   102e6:	000117b7          	lui	a5,0x11
   102ea:	f20007d3          	fmv.d.x	fa5,zero
   102ee:	7687b507          	fld	fa0,1896(a5) # 11768 <__TMC_END__+0x10>
   102f2:	1af57553          	fdiv.d	fa0,fa0,fa5
   102f6:	8082                	ret
   102f8:	0006d763          	bgez	a3,10306 <__ieee754_log+0x44>
   102fc:	0aa57553          	fsub.d	fa0,fa0,fa0
   10300:	f20007d3          	fmv.d.x	fa5,zero
   10304:	b7fd                	j	102f2 <__ieee754_log+0x30>
   10306:	00011737          	lui	a4,0x11
   1030a:	77073787          	fld	fa5,1904(a4) # 11770 <__TMC_END__+0x18>
   1030e:	fca00513          	li	a0,-54
   10312:	12f577d3          	fmul.d	fa5,fa0,fa5
   10316:	e20787d3          	fmv.x.d	a5,fa5
   1031a:	4207d693          	srai	a3,a5,0x20
   1031e:	7ff00737          	lui	a4,0x7ff00
   10322:	00e6c963          	blt	a3,a4,10334 <__ieee754_log+0x72>
   10326:	f20787d3          	fmv.d.x	fa5,a5
   1032a:	02f7f553          	fadd.d	fa0,fa5,fa5
   1032e:	8082                	ret
   10330:	4501                	li	a0,0
   10332:	b7f5                	j	1031e <__ieee754_log+0x5c>
   10334:	4146d71b          	sraiw	a4,a3,0x14
   10338:	c017071b          	addiw	a4,a4,-1023
   1033c:	00100837          	lui	a6,0x100
   10340:	9d39                	addw	a0,a0,a4
   10342:	187d                	addi	a6,a6,-1
   10344:	00096737          	lui	a4,0x96
   10348:	0106f6b3          	and	a3,a3,a6
   1034c:	f647071b          	addiw	a4,a4,-156
   10350:	00100637          	lui	a2,0x100
   10354:	9f35                	addw	a4,a4,a3
   10356:	8f71                	and	a4,a4,a2
   10358:	3ff005b7          	lui	a1,0x3ff00
   1035c:	8db9                	xor	a1,a1,a4
   1035e:	567d                	li	a2,-1
   10360:	9201                	srli	a2,a2,0x20
   10362:	8dd5                	or	a1,a1,a3
   10364:	1582                	slli	a1,a1,0x20
   10366:	8ff1                	and	a5,a5,a2
   10368:	8fcd                	or	a5,a5,a1
   1036a:	000115b7          	lui	a1,0x11
   1036e:	7785b507          	fld	fa0,1912(a1) # 11778 <__TMC_END__+0x20>
   10372:	f20787d3          	fmv.d.x	fa5,a5
   10376:	0026879b          	addiw	a5,a3,2
   1037a:	0107f7b3          	and	a5,a5,a6
   1037e:	4147571b          	sraiw	a4,a4,0x14
   10382:	2781                	sext.w	a5,a5
   10384:	4589                	li	a1,2
   10386:	00a7063b          	addw	a2,a4,a0
   1038a:	0aa7f553          	fsub.d	fa0,fa5,fa0
   1038e:	06f5cc63          	blt	a1,a5,10406 <__ieee754_log+0x144>
   10392:	f20007d3          	fmv.d.x	fa5,zero
   10396:	a2f527d3          	feq.d	a5,fa0,fa5
   1039a:	c39d                	beqz	a5,103c0 <__ieee754_log+0xfe>
   1039c:	22f78553          	fmv.d	fa0,fa5
   103a0:	c235                	beqz	a2,10404 <__ieee754_log+0x142>
   103a2:	000117b7          	lui	a5,0x11
   103a6:	d20607d3          	fcvt.d.w	fa5,a2
   103aa:	7807b707          	fld	fa4,1920(a5) # 11780 <__TMC_END__+0x28>
   103ae:	000117b7          	lui	a5,0x11
   103b2:	7887b507          	fld	fa0,1928(a5) # 11788 <__TMC_END__+0x30>
   103b6:	12e7f753          	fmul.d	fa4,fa5,fa4
   103ba:	72a7f543          	fmadd.d	fa0,fa5,fa0,fa4
   103be:	8082                	ret
   103c0:	000117b7          	lui	a5,0x11
   103c4:	7907b707          	fld	fa4,1936(a5) # 11790 <__TMC_END__+0x38>
   103c8:	000117b7          	lui	a5,0x11
   103cc:	7987b787          	fld	fa5,1944(a5) # 11798 <__TMC_END__+0x40>
   103d0:	7ae5774b          	fnmsub.d	fa4,fa0,fa4,fa5
   103d4:	12a577d3          	fmul.d	fa5,fa0,fa0
   103d8:	12f77753          	fmul.d	fa4,fa4,fa5
   103dc:	e601                	bnez	a2,103e4 <__ieee754_log+0x122>
   103de:	0ae57553          	fsub.d	fa0,fa0,fa4
   103e2:	8082                	ret
   103e4:	d20607d3          	fcvt.d.w	fa5,a2
   103e8:	000117b7          	lui	a5,0x11
   103ec:	7807b687          	fld	fa3,1920(a5) # 11780 <__TMC_END__+0x28>
   103f0:	000117b7          	lui	a5,0x11
   103f4:	72d7f74b          	fnmsub.d	fa4,fa5,fa3,fa4
   103f8:	0aa77753          	fsub.d	fa4,fa4,fa0
   103fc:	7887b507          	fld	fa0,1928(a5) # 11788 <__TMC_END__+0x30>
   10400:	72a7f547          	fmsub.d	fa0,fa5,fa0,fa4
   10404:	8082                	ret
   10406:	000117b7          	lui	a5,0x11
   1040a:	7a07b707          	fld	fa4,1952(a5) # 117a0 <__TMC_END__+0x48>
   1040e:	00011737          	lui	a4,0x11
   10412:	7a873687          	fld	fa3,1960(a4) # 117a8 <__TMC_END__+0x50>
   10416:	02e57753          	fadd.d	fa4,fa0,fa4
   1041a:	00011737          	lui	a4,0x11
   1041e:	fff9f7b7          	lui	a5,0xfff9f
   10422:	b867879b          	addiw	a5,a5,-1146
   10426:	9fb5                	addw	a5,a5,a3
   10428:	d20607d3          	fcvt.d.w	fa5,a2
   1042c:	1ae57653          	fdiv.d	fa2,fa0,fa4
   10430:	7b073707          	fld	fa4,1968(a4) # 117b0 <__TMC_END__+0x58>
   10434:	00011737          	lui	a4,0x11
   10438:	12c67053          	fmul.d	ft0,fa2,fa2
   1043c:	120075d3          	fmul.d	fa1,ft0,ft0
   10440:	72d5f6c3          	fmadd.d	fa3,fa1,fa3,fa4
   10444:	7b873707          	fld	fa4,1976(a4) # 117b8 <__TMC_END__+0x60>
   10448:	00011737          	lui	a4,0x11
   1044c:	72b6f6c3          	fmadd.d	fa3,fa3,fa1,fa4
   10450:	7c073707          	fld	fa4,1984(a4) # 117c0 <__TMC_END__+0x68>
   10454:	00011737          	lui	a4,0x11
   10458:	7c873087          	fld	ft1,1992(a4) # 117c8 <__TMC_END__+0x70>
   1045c:	00011737          	lui	a4,0x11
   10460:	0ae5f743          	fmadd.d	fa4,fa1,fa4,ft1
   10464:	7d073087          	fld	ft1,2000(a4) # 117d0 <__TMC_END__+0x78>
   10468:	00011737          	lui	a4,0x11
   1046c:	0ab77743          	fmadd.d	fa4,fa4,fa1,ft1
   10470:	7d873087          	fld	ft1,2008(a4) # 117d8 <__TMC_END__+0x80>
   10474:	0006c737          	lui	a4,0x6c
   10478:	8517071b          	addiw	a4,a4,-1967
   1047c:	40d706bb          	subw	a3,a4,a3
   10480:	8edd                	or	a3,a3,a5
   10482:	2681                	sext.w	a3,a3
   10484:	0ab77743          	fmadd.d	fa4,fa4,fa1,ft1
   10488:	12077753          	fmul.d	fa4,fa4,ft0
   1048c:	72b6f743          	fmadd.d	fa4,fa3,fa1,fa4
   10490:	04d05363          	blez	a3,104d6 <__ieee754_log+0x214>
   10494:	000117b7          	lui	a5,0x11
   10498:	7987b687          	fld	fa3,1944(a5) # 11798 <__TMC_END__+0x40>
   1049c:	12d576d3          	fmul.d	fa3,fa0,fa3
   104a0:	12a6f6d3          	fmul.d	fa3,fa3,fa0
   104a4:	02d77753          	fadd.d	fa4,fa4,fa3
   104a8:	12c77753          	fmul.d	fa4,fa4,fa2
   104ac:	e601                	bnez	a2,104b4 <__ieee754_log+0x1f2>
   104ae:	0ae6f753          	fsub.d	fa4,fa3,fa4
   104b2:	b735                	j	103de <__ieee754_log+0x11c>
   104b4:	000117b7          	lui	a5,0x11
   104b8:	7807b607          	fld	fa2,1920(a5) # 11780 <__TMC_END__+0x28>
   104bc:	000117b7          	lui	a5,0x11
   104c0:	72c7f743          	fmadd.d	fa4,fa5,fa2,fa4
   104c4:	0ae6f6d3          	fsub.d	fa3,fa3,fa4
   104c8:	0aa6f6d3          	fsub.d	fa3,fa3,fa0
   104cc:	7887b507          	fld	fa0,1928(a5) # 11788 <__TMC_END__+0x30>
   104d0:	6aa7f547          	fmsub.d	fa0,fa5,fa0,fa3
   104d4:	8082                	ret
   104d6:	0ae57753          	fsub.d	fa4,fa0,fa4
   104da:	12c77753          	fmul.d	fa4,fa4,fa2
   104de:	f609                	bnez	a2,103e8 <__ieee754_log+0x126>
   104e0:	bdfd                	j	103de <__ieee754_log+0x11c>
	...

00000000000104e4 <matherr>:
   104e4:	4501                	li	a0,0
   104e6:	8082                	ret
	...

00000000000104ea <nan>:
   104ea:	000117b7          	lui	a5,0x11
   104ee:	7e07b507          	fld	fa0,2016(a5) # 117e0 <__TMC_END__+0x88>
   104f2:	8082                	ret
	...

00000000000104f6 <atexit>:
   104f6:	85aa                	mv	a1,a0
   104f8:	4681                	li	a3,0
   104fa:	4601                	li	a2,0
   104fc:	4501                	li	a0,0
   104fe:	1920006f          	j	10690 <__register_exitproc>
	...

0000000000010504 <__errno>:
   10504:	8a81b503          	ld	a0,-1880(gp) # 11800 <_impure_ptr>
   10508:	8082                	ret
	...

000000000001050c <exit>:
   1050c:	1141                	addi	sp,sp,-16
   1050e:	4581                	li	a1,0
   10510:	e022                	sd	s0,0(sp)
   10512:	e406                	sd	ra,8(sp)
   10514:	842a                	mv	s0,a0
   10516:	1e0000ef          	jal	ra,106f6 <__call_exitprocs>
   1051a:	8a01b503          	ld	a0,-1888(gp) # 117f8 <_global_impure_ptr>
   1051e:	6d3c                	ld	a5,88(a0)
   10520:	c391                	beqz	a5,10524 <exit+0x18>
   10522:	9782                	jalr	a5
   10524:	8522                	mv	a0,s0
   10526:	00000097          	auipc	ra,0x0
   1052a:	66a080e7          	jalr	1642(ra) # 10b90 <_exit>
	...

0000000000010530 <__libc_fini_array>:
   10530:	7179                	addi	sp,sp,-48
   10532:	67c5                	lui	a5,0x11
   10534:	6745                	lui	a4,0x11
   10536:	f022                	sd	s0,32(sp)
   10538:	00870713          	addi	a4,a4,8 # 11008 <__init_array_end>
   1053c:	01078413          	addi	s0,a5,16 # 11010 <__fini_array_end>
   10540:	8c19                	sub	s0,s0,a4
   10542:	ec26                	sd	s1,24(sp)
   10544:	e84a                	sd	s2,16(sp)
   10546:	e44e                	sd	s3,8(sp)
   10548:	f406                	sd	ra,40(sp)
   1054a:	840d                	srai	s0,s0,0x3
   1054c:	4481                	li	s1,0
   1054e:	01078913          	addi	s2,a5,16
   10552:	59e1                	li	s3,-8
   10554:	00941c63          	bne	s0,s1,1056c <__libc_fini_array+0x3c>
   10558:	7402                	ld	s0,32(sp)
   1055a:	70a2                	ld	ra,40(sp)
   1055c:	64e2                	ld	s1,24(sp)
   1055e:	6942                	ld	s2,16(sp)
   10560:	69a2                	ld	s3,8(sp)
   10562:	6145                	addi	sp,sp,48
   10564:	00000317          	auipc	t1,0x0
   10568:	b9230067          	jr	-1134(t1) # 100f6 <_fini>
   1056c:	033487b3          	mul	a5,s1,s3
   10570:	0485                	addi	s1,s1,1
   10572:	97ca                	add	a5,a5,s2
   10574:	ff87b783          	ld	a5,-8(a5)
   10578:	9782                	jalr	a5
   1057a:	bfe9                	j	10554 <__libc_fini_array+0x24>
	...

000000000001057e <__libc_init_array>:
   1057e:	1101                	addi	sp,sp,-32
   10580:	e822                	sd	s0,16(sp)
   10582:	e426                	sd	s1,8(sp)
   10584:	6445                	lui	s0,0x11
   10586:	64c5                	lui	s1,0x11
   10588:	00048793          	mv	a5,s1
   1058c:	00040413          	mv	s0,s0
   10590:	8c1d                	sub	s0,s0,a5
   10592:	e04a                	sd	s2,0(sp)
   10594:	ec06                	sd	ra,24(sp)
   10596:	840d                	srai	s0,s0,0x3
   10598:	00048493          	mv	s1,s1
   1059c:	4901                	li	s2,0
   1059e:	02891963          	bne	s2,s0,105d0 <__libc_init_array+0x52>
   105a2:	64c5                	lui	s1,0x11
   105a4:	00000097          	auipc	ra,0x0
   105a8:	b52080e7          	jalr	-1198(ra) # 100f6 <_fini>
   105ac:	6445                	lui	s0,0x11
   105ae:	00048793          	mv	a5,s1
   105b2:	00840413          	addi	s0,s0,8 # 11008 <__init_array_end>
   105b6:	8c1d                	sub	s0,s0,a5
   105b8:	840d                	srai	s0,s0,0x3
   105ba:	00048493          	mv	s1,s1
   105be:	4901                	li	s2,0
   105c0:	00891d63          	bne	s2,s0,105da <__libc_init_array+0x5c>
   105c4:	60e2                	ld	ra,24(sp)
   105c6:	6442                	ld	s0,16(sp)
   105c8:	64a2                	ld	s1,8(sp)
   105ca:	6902                	ld	s2,0(sp)
   105cc:	6105                	addi	sp,sp,32
   105ce:	8082                	ret
   105d0:	609c                	ld	a5,0(s1)
   105d2:	0905                	addi	s2,s2,1
   105d4:	04a1                	addi	s1,s1,8
   105d6:	9782                	jalr	a5
   105d8:	b7d9                	j	1059e <__libc_init_array+0x20>
   105da:	609c                	ld	a5,0(s1)
   105dc:	0905                	addi	s2,s2,1
   105de:	04a1                	addi	s1,s1,8
   105e0:	9782                	jalr	a5
   105e2:	bff9                	j	105c0 <__libc_init_array+0x42>
	...

00000000000105e6 <memset>:
   105e6:	483d                	li	a6,15
   105e8:	872a                	mv	a4,a0
   105ea:	02c87163          	bleu	a2,a6,1060c <memset+0x26>
   105ee:	00f77793          	andi	a5,a4,15
   105f2:	e3c1                	bnez	a5,10672 <memset+0x8c>
   105f4:	e1bd                	bnez	a1,1065a <memset+0x74>
   105f6:	ff067693          	andi	a3,a2,-16
   105fa:	8a3d                	andi	a2,a2,15
   105fc:	96ba                	add	a3,a3,a4
   105fe:	e30c                	sd	a1,0(a4)
   10600:	e70c                	sd	a1,8(a4)
   10602:	0741                	addi	a4,a4,16
   10604:	fed76de3          	bltu	a4,a3,105fe <memset+0x18>
   10608:	e211                	bnez	a2,1060c <memset+0x26>
   1060a:	8082                	ret
   1060c:	40c806b3          	sub	a3,a6,a2
   10610:	068a                	slli	a3,a3,0x2
   10612:	00000297          	auipc	t0,0x0
   10616:	9696                	add	a3,a3,t0
   10618:	00a68067          	jr	10(a3)
   1061c:	00b70723          	sb	a1,14(a4)
   10620:	00b706a3          	sb	a1,13(a4)
   10624:	00b70623          	sb	a1,12(a4)
   10628:	00b705a3          	sb	a1,11(a4)
   1062c:	00b70523          	sb	a1,10(a4)
   10630:	00b704a3          	sb	a1,9(a4)
   10634:	00b70423          	sb	a1,8(a4)
   10638:	00b703a3          	sb	a1,7(a4)
   1063c:	00b70323          	sb	a1,6(a4)
   10640:	00b702a3          	sb	a1,5(a4)
   10644:	00b70223          	sb	a1,4(a4)
   10648:	00b701a3          	sb	a1,3(a4)
   1064c:	00b70123          	sb	a1,2(a4)
   10650:	00b700a3          	sb	a1,1(a4)
   10654:	00b70023          	sb	a1,0(a4)
   10658:	8082                	ret
   1065a:	0ff5f593          	andi	a1,a1,255
   1065e:	00859693          	slli	a3,a1,0x8
   10662:	8dd5                	or	a1,a1,a3
   10664:	01059693          	slli	a3,a1,0x10
   10668:	8dd5                	or	a1,a1,a3
   1066a:	02059693          	slli	a3,a1,0x20
   1066e:	8dd5                	or	a1,a1,a3
   10670:	b759                	j	105f6 <memset+0x10>
   10672:	00279693          	slli	a3,a5,0x2
   10676:	00000297          	auipc	t0,0x0
   1067a:	9696                	add	a3,a3,t0
   1067c:	8286                	mv	t0,ra
   1067e:	fa2680e7          	jalr	-94(a3)
   10682:	8096                	mv	ra,t0
   10684:	17c1                	addi	a5,a5,-16
   10686:	8f1d                	sub	a4,a4,a5
   10688:	963e                	add	a2,a2,a5
   1068a:	f8c871e3          	bleu	a2,a6,1060c <memset+0x26>
   1068e:	b79d                	j	105f4 <memset+0xe>

0000000000010690 <__register_exitproc>:
   10690:	8a01b703          	ld	a4,-1888(gp) # 117f8 <_global_impure_ptr>
   10694:	832a                	mv	t1,a0
   10696:	1f873783          	ld	a5,504(a4)
   1069a:	e789                	bnez	a5,106a4 <__register_exitproc+0x14>
   1069c:	20070793          	addi	a5,a4,512
   106a0:	1ef73c23          	sd	a5,504(a4)
   106a4:	4798                	lw	a4,8(a5)
   106a6:	487d                	li	a6,31
   106a8:	557d                	li	a0,-1
   106aa:	04e84463          	blt	a6,a4,106f2 <__register_exitproc+0x62>
   106ae:	02030a63          	beqz	t1,106e2 <__register_exitproc+0x52>
   106b2:	00371813          	slli	a6,a4,0x3
   106b6:	983e                	add	a6,a6,a5
   106b8:	10c83823          	sd	a2,272(a6) # 100110 <__global_pointer$+0xee1b8>
   106bc:	3107a883          	lw	a7,784(a5)
   106c0:	4605                	li	a2,1
   106c2:	00e6163b          	sllw	a2,a2,a4
   106c6:	00c8e8b3          	or	a7,a7,a2
   106ca:	3117a823          	sw	a7,784(a5)
   106ce:	20d83823          	sd	a3,528(a6)
   106d2:	4689                	li	a3,2
   106d4:	00d31763          	bne	t1,a3,106e2 <__register_exitproc+0x52>
   106d8:	3147a683          	lw	a3,788(a5)
   106dc:	8e55                	or	a2,a2,a3
   106de:	30c7aa23          	sw	a2,788(a5)
   106e2:	0017069b          	addiw	a3,a4,1
   106e6:	0709                	addi	a4,a4,2
   106e8:	070e                	slli	a4,a4,0x3
   106ea:	c794                	sw	a3,8(a5)
   106ec:	97ba                	add	a5,a5,a4
   106ee:	e38c                	sd	a1,0(a5)
   106f0:	4501                	li	a0,0
   106f2:	8082                	ret
	...

00000000000106f6 <__call_exitprocs>:
   106f6:	715d                	addi	sp,sp,-80
   106f8:	f44e                	sd	s3,40(sp)
   106fa:	8a01b983          	ld	s3,-1888(gp) # 117f8 <_global_impure_ptr>
   106fe:	f052                	sd	s4,32(sp)
   10700:	ec56                	sd	s5,24(sp)
   10702:	e85a                	sd	s6,16(sp)
   10704:	e486                	sd	ra,72(sp)
   10706:	e0a2                	sd	s0,64(sp)
   10708:	fc26                	sd	s1,56(sp)
   1070a:	f84a                	sd	s2,48(sp)
   1070c:	e45e                	sd	s7,8(sp)
   1070e:	8aaa                	mv	s5,a0
   10710:	8a2e                	mv	s4,a1
   10712:	4b05                	li	s6,1
   10714:	1f89b403          	ld	s0,504(s3)
   10718:	c801                	beqz	s0,10728 <__call_exitprocs+0x32>
   1071a:	4404                	lw	s1,8(s0)
   1071c:	34fd                	addiw	s1,s1,-1
   1071e:	00349913          	slli	s2,s1,0x3
   10722:	9922                	add	s2,s2,s0
   10724:	0004dd63          	bgez	s1,1073e <__call_exitprocs+0x48>
   10728:	60a6                	ld	ra,72(sp)
   1072a:	6406                	ld	s0,64(sp)
   1072c:	74e2                	ld	s1,56(sp)
   1072e:	7942                	ld	s2,48(sp)
   10730:	79a2                	ld	s3,40(sp)
   10732:	7a02                	ld	s4,32(sp)
   10734:	6ae2                	ld	s5,24(sp)
   10736:	6b42                	ld	s6,16(sp)
   10738:	6ba2                	ld	s7,8(sp)
   1073a:	6161                	addi	sp,sp,80
   1073c:	8082                	ret
   1073e:	000a0963          	beqz	s4,10750 <__call_exitprocs+0x5a>
   10742:	21093783          	ld	a5,528(s2)
   10746:	01478563          	beq	a5,s4,10750 <__call_exitprocs+0x5a>
   1074a:	34fd                	addiw	s1,s1,-1
   1074c:	1961                	addi	s2,s2,-8
   1074e:	bfd9                	j	10724 <__call_exitprocs+0x2e>
   10750:	441c                	lw	a5,8(s0)
   10752:	01093683          	ld	a3,16(s2)
   10756:	37fd                	addiw	a5,a5,-1
   10758:	02979663          	bne	a5,s1,10784 <__call_exitprocs+0x8e>
   1075c:	c404                	sw	s1,8(s0)
   1075e:	d6f5                	beqz	a3,1074a <__call_exitprocs+0x54>
   10760:	31042703          	lw	a4,784(s0)
   10764:	009b163b          	sllw	a2,s6,s1
   10768:	00842b83          	lw	s7,8(s0)
   1076c:	8f71                	and	a4,a4,a2
   1076e:	2701                	sext.w	a4,a4
   10770:	ef09                	bnez	a4,1078a <__call_exitprocs+0x94>
   10772:	9682                	jalr	a3
   10774:	4418                	lw	a4,8(s0)
   10776:	1f89b783          	ld	a5,504(s3)
   1077a:	f9771de3          	bne	a4,s7,10714 <__call_exitprocs+0x1e>
   1077e:	fcf406e3          	beq	s0,a5,1074a <__call_exitprocs+0x54>
   10782:	bf49                	j	10714 <__call_exitprocs+0x1e>
   10784:	00093823          	sd	zero,16(s2)
   10788:	bfd9                	j	1075e <__call_exitprocs+0x68>
   1078a:	31442783          	lw	a5,788(s0)
   1078e:	11093583          	ld	a1,272(s2)
   10792:	8ff1                	and	a5,a5,a2
   10794:	2781                	sext.w	a5,a5
   10796:	e781                	bnez	a5,1079e <__call_exitprocs+0xa8>
   10798:	8556                	mv	a0,s5
   1079a:	9682                	jalr	a3
   1079c:	bfe1                	j	10774 <__call_exitprocs+0x7e>
   1079e:	852e                	mv	a0,a1
   107a0:	9682                	jalr	a3
   107a2:	bfc9                	j	10774 <__call_exitprocs+0x7e>
	...

00000000000107a6 <conv_stat>:
   107a6:	619c                	ld	a5,0(a1)
   107a8:	00f51023          	sh	a5,0(a0)
   107ac:	659c                	ld	a5,8(a1)
   107ae:	00f51123          	sh	a5,2(a0)
   107b2:	499c                	lw	a5,16(a1)
   107b4:	c15c                	sw	a5,4(a0)
   107b6:	49dc                	lw	a5,20(a1)
   107b8:	00f51423          	sh	a5,8(a0)
   107bc:	4d9c                	lw	a5,24(a1)
   107be:	00f51523          	sh	a5,10(a0)
   107c2:	4ddc                	lw	a5,28(a1)
   107c4:	00f51623          	sh	a5,12(a0)
   107c8:	719c                	ld	a5,32(a1)
   107ca:	00f51723          	sh	a5,14(a0)
   107ce:	799c                	ld	a5,48(a1)
   107d0:	e91c                	sd	a5,16(a0)
   107d2:	61bc                	ld	a5,64(a1)
   107d4:	e93c                	sd	a5,80(a0)
   107d6:	5d9c                	lw	a5,56(a1)
   107d8:	e53c                	sd	a5,72(a0)
   107da:	65bc                	ld	a5,72(a1)
   107dc:	ed1c                	sd	a5,24(a0)
   107de:	6dbc                	ld	a5,88(a1)
   107e0:	f51c                	sd	a5,40(a0)
   107e2:	75bc                	ld	a5,104(a1)
   107e4:	fd1c                	sd	a5,56(a0)
   107e6:	8082                	ret

00000000000107e8 <__syscall_error>:
   107e8:	1141                	addi	sp,sp,-16
   107ea:	e022                	sd	s0,0(sp)
   107ec:	e406                	sd	ra,8(sp)
   107ee:	842a                	mv	s0,a0
   107f0:	00000097          	auipc	ra,0x0
   107f4:	d14080e7          	jalr	-748(ra) # 10504 <__errno>
   107f8:	408007bb          	negw	a5,s0
   107fc:	60a2                	ld	ra,8(sp)
   107fe:	6402                	ld	s0,0(sp)
   10800:	c11c                	sw	a5,0(a0)
   10802:	557d                	li	a0,-1
   10804:	0141                	addi	sp,sp,16
   10806:	8082                	ret

0000000000010808 <__internal_syscall>:
   10808:	88aa                	mv	a7,a0
   1080a:	852e                	mv	a0,a1
   1080c:	85b2                	mv	a1,a2
   1080e:	8636                	mv	a2,a3
   10810:	86ba                	mv	a3,a4
   10812:	00000073          	ecall
   10816:	00055663          	bgez	a0,10822 <__internal_syscall+0x1a>
   1081a:	00000317          	auipc	t1,0x0
   1081e:	fce30067          	jr	-50(t1) # 107e8 <__syscall_error>
   10822:	8082                	ret

0000000000010824 <open>:
   10824:	1141                	addi	sp,sp,-16
   10826:	86b2                	mv	a3,a2
   10828:	4701                	li	a4,0
   1082a:	862e                	mv	a2,a1
   1082c:	85aa                	mv	a1,a0
   1082e:	40000513          	li	a0,1024
   10832:	e406                	sd	ra,8(sp)
   10834:	00000097          	auipc	ra,0x0
   10838:	fd4080e7          	jalr	-44(ra) # 10808 <__internal_syscall>
   1083c:	60a2                	ld	ra,8(sp)
   1083e:	2501                	sext.w	a0,a0
   10840:	0141                	addi	sp,sp,16
   10842:	8082                	ret

0000000000010844 <openat>:
   10844:	1141                	addi	sp,sp,-16
   10846:	8736                	mv	a4,a3
   10848:	86b2                	mv	a3,a2
   1084a:	862e                	mv	a2,a1
   1084c:	85aa                	mv	a1,a0
   1084e:	03800513          	li	a0,56
   10852:	e406                	sd	ra,8(sp)
   10854:	fb5ff0ef          	jal	ra,10808 <__internal_syscall>
   10858:	60a2                	ld	ra,8(sp)
   1085a:	2501                	sext.w	a0,a0
   1085c:	0141                	addi	sp,sp,16
   1085e:	8082                	ret

0000000000010860 <lseek>:
   10860:	86b2                	mv	a3,a2
   10862:	4701                	li	a4,0
   10864:	862e                	mv	a2,a1
   10866:	85aa                	mv	a1,a0
   10868:	03e00513          	li	a0,62
   1086c:	00000317          	auipc	t1,0x0
   10870:	f9c30067          	jr	-100(t1) # 10808 <__internal_syscall>

0000000000010874 <read>:
   10874:	86b2                	mv	a3,a2
   10876:	4701                	li	a4,0
   10878:	862e                	mv	a2,a1
   1087a:	85aa                	mv	a1,a0
   1087c:	03f00513          	li	a0,63
   10880:	f89ff06f          	j	10808 <__internal_syscall>

0000000000010884 <write>:
   10884:	86b2                	mv	a3,a2
   10886:	4701                	li	a4,0
   10888:	862e                	mv	a2,a1
   1088a:	85aa                	mv	a1,a0
   1088c:	04000513          	li	a0,64
   10890:	00000317          	auipc	t1,0x0
   10894:	f7830067          	jr	-136(t1) # 10808 <__internal_syscall>

0000000000010898 <fstat>:
   10898:	7135                	addi	sp,sp,-160
   1089a:	e526                	sd	s1,136(sp)
   1089c:	860a                	mv	a2,sp
   1089e:	84ae                	mv	s1,a1
   108a0:	4701                	li	a4,0
   108a2:	85aa                	mv	a1,a0
   108a4:	4681                	li	a3,0
   108a6:	05000513          	li	a0,80
   108aa:	ed06                	sd	ra,152(sp)
   108ac:	e922                	sd	s0,144(sp)
   108ae:	f5bff0ef          	jal	ra,10808 <__internal_syscall>
   108b2:	842a                	mv	s0,a0
   108b4:	858a                	mv	a1,sp
   108b6:	8526                	mv	a0,s1
   108b8:	eefff0ef          	jal	ra,107a6 <conv_stat>
   108bc:	0004051b          	sext.w	a0,s0
   108c0:	60ea                	ld	ra,152(sp)
   108c2:	644a                	ld	s0,144(sp)
   108c4:	64aa                	ld	s1,136(sp)
   108c6:	610d                	addi	sp,sp,160
   108c8:	8082                	ret

00000000000108ca <stat>:
   108ca:	7135                	addi	sp,sp,-160
   108cc:	e526                	sd	s1,136(sp)
   108ce:	860a                	mv	a2,sp
   108d0:	84ae                	mv	s1,a1
   108d2:	4701                	li	a4,0
   108d4:	85aa                	mv	a1,a0
   108d6:	4681                	li	a3,0
   108d8:	40e00513          	li	a0,1038
   108dc:	ed06                	sd	ra,152(sp)
   108de:	e922                	sd	s0,144(sp)
   108e0:	00000097          	auipc	ra,0x0
   108e4:	f28080e7          	jalr	-216(ra) # 10808 <__internal_syscall>
   108e8:	842a                	mv	s0,a0
   108ea:	858a                	mv	a1,sp
   108ec:	8526                	mv	a0,s1
   108ee:	00000097          	auipc	ra,0x0
   108f2:	eb8080e7          	jalr	-328(ra) # 107a6 <conv_stat>
   108f6:	0004051b          	sext.w	a0,s0
   108fa:	60ea                	ld	ra,152(sp)
   108fc:	644a                	ld	s0,144(sp)
   108fe:	64aa                	ld	s1,136(sp)
   10900:	610d                	addi	sp,sp,160
   10902:	8082                	ret

0000000000010904 <lstat>:
   10904:	7135                	addi	sp,sp,-160
   10906:	e526                	sd	s1,136(sp)
   10908:	860a                	mv	a2,sp
   1090a:	84ae                	mv	s1,a1
   1090c:	4701                	li	a4,0
   1090e:	85aa                	mv	a1,a0
   10910:	4681                	li	a3,0
   10912:	40f00513          	li	a0,1039
   10916:	ed06                	sd	ra,152(sp)
   10918:	e922                	sd	s0,144(sp)
   1091a:	eefff0ef          	jal	ra,10808 <__internal_syscall>
   1091e:	842a                	mv	s0,a0
   10920:	858a                	mv	a1,sp
   10922:	8526                	mv	a0,s1
   10924:	e83ff0ef          	jal	ra,107a6 <conv_stat>
   10928:	0004051b          	sext.w	a0,s0
   1092c:	60ea                	ld	ra,152(sp)
   1092e:	644a                	ld	s0,144(sp)
   10930:	64aa                	ld	s1,136(sp)
   10932:	610d                	addi	sp,sp,160
   10934:	8082                	ret

0000000000010936 <fstatat>:
   10936:	7135                	addi	sp,sp,-160
   10938:	e526                	sd	s1,136(sp)
   1093a:	8736                	mv	a4,a3
   1093c:	84b2                	mv	s1,a2
   1093e:	868a                	mv	a3,sp
   10940:	862e                	mv	a2,a1
   10942:	85aa                	mv	a1,a0
   10944:	04f00513          	li	a0,79
   10948:	ed06                	sd	ra,152(sp)
   1094a:	e922                	sd	s0,144(sp)
   1094c:	00000097          	auipc	ra,0x0
   10950:	ebc080e7          	jalr	-324(ra) # 10808 <__internal_syscall>
   10954:	842a                	mv	s0,a0
   10956:	858a                	mv	a1,sp
   10958:	8526                	mv	a0,s1
   1095a:	00000097          	auipc	ra,0x0
   1095e:	e4c080e7          	jalr	-436(ra) # 107a6 <conv_stat>
   10962:	0004051b          	sext.w	a0,s0
   10966:	60ea                	ld	ra,152(sp)
   10968:	644a                	ld	s0,144(sp)
   1096a:	64aa                	ld	s1,136(sp)
   1096c:	610d                	addi	sp,sp,160
   1096e:	8082                	ret

0000000000010970 <access>:
   10970:	1141                	addi	sp,sp,-16
   10972:	862e                	mv	a2,a1
   10974:	4701                	li	a4,0
   10976:	85aa                	mv	a1,a0
   10978:	4681                	li	a3,0
   1097a:	40900513          	li	a0,1033
   1097e:	e406                	sd	ra,8(sp)
   10980:	e89ff0ef          	jal	ra,10808 <__internal_syscall>
   10984:	60a2                	ld	ra,8(sp)
   10986:	2501                	sext.w	a0,a0
   10988:	0141                	addi	sp,sp,16
   1098a:	8082                	ret

000000000001098c <faccessat>:
   1098c:	1141                	addi	sp,sp,-16
   1098e:	8736                	mv	a4,a3
   10990:	86b2                	mv	a3,a2
   10992:	862e                	mv	a2,a1
   10994:	85aa                	mv	a1,a0
   10996:	03000513          	li	a0,48
   1099a:	e406                	sd	ra,8(sp)
   1099c:	00000097          	auipc	ra,0x0
   109a0:	e6c080e7          	jalr	-404(ra) # 10808 <__internal_syscall>
   109a4:	60a2                	ld	ra,8(sp)
   109a6:	2501                	sext.w	a0,a0
   109a8:	0141                	addi	sp,sp,16
   109aa:	8082                	ret

00000000000109ac <close>:
   109ac:	1141                	addi	sp,sp,-16
   109ae:	85aa                	mv	a1,a0
   109b0:	4701                	li	a4,0
   109b2:	4681                	li	a3,0
   109b4:	4601                	li	a2,0
   109b6:	03900513          	li	a0,57
   109ba:	e406                	sd	ra,8(sp)
   109bc:	e4dff0ef          	jal	ra,10808 <__internal_syscall>
   109c0:	60a2                	ld	ra,8(sp)
   109c2:	2501                	sext.w	a0,a0
   109c4:	0141                	addi	sp,sp,16
   109c6:	8082                	ret

00000000000109c8 <link>:
   109c8:	1141                	addi	sp,sp,-16
   109ca:	862e                	mv	a2,a1
   109cc:	4701                	li	a4,0
   109ce:	85aa                	mv	a1,a0
   109d0:	4681                	li	a3,0
   109d2:	40100513          	li	a0,1025
   109d6:	e406                	sd	ra,8(sp)
   109d8:	00000097          	auipc	ra,0x0
   109dc:	e30080e7          	jalr	-464(ra) # 10808 <__internal_syscall>
   109e0:	60a2                	ld	ra,8(sp)
   109e2:	2501                	sext.w	a0,a0
   109e4:	0141                	addi	sp,sp,16
   109e6:	8082                	ret

00000000000109e8 <unlink>:
   109e8:	1141                	addi	sp,sp,-16
   109ea:	85aa                	mv	a1,a0
   109ec:	4701                	li	a4,0
   109ee:	4681                	li	a3,0
   109f0:	4601                	li	a2,0
   109f2:	40200513          	li	a0,1026
   109f6:	e406                	sd	ra,8(sp)
   109f8:	e11ff0ef          	jal	ra,10808 <__internal_syscall>
   109fc:	60a2                	ld	ra,8(sp)
   109fe:	2501                	sext.w	a0,a0
   10a00:	0141                	addi	sp,sp,16
   10a02:	8082                	ret

0000000000010a04 <execve>:
   10a04:	1141                	addi	sp,sp,-16
   10a06:	e406                	sd	ra,8(sp)
   10a08:	00000097          	auipc	ra,0x0
   10a0c:	afc080e7          	jalr	-1284(ra) # 10504 <__errno>
   10a10:	60a2                	ld	ra,8(sp)
   10a12:	47b1                	li	a5,12
   10a14:	c11c                	sw	a5,0(a0)
   10a16:	557d                	li	a0,-1
   10a18:	0141                	addi	sp,sp,16
   10a1a:	8082                	ret

0000000000010a1c <fork>:
   10a1c:	1141                	addi	sp,sp,-16
   10a1e:	e406                	sd	ra,8(sp)
   10a20:	ae5ff0ef          	jal	ra,10504 <__errno>
   10a24:	60a2                	ld	ra,8(sp)
   10a26:	47ad                	li	a5,11
   10a28:	c11c                	sw	a5,0(a0)
   10a2a:	557d                	li	a0,-1
   10a2c:	0141                	addi	sp,sp,16
   10a2e:	8082                	ret

0000000000010a30 <getpid>:
   10a30:	4505                	li	a0,1
   10a32:	8082                	ret

0000000000010a34 <kill>:
   10a34:	1141                	addi	sp,sp,-16
   10a36:	e406                	sd	ra,8(sp)
   10a38:	acdff0ef          	jal	ra,10504 <__errno>
   10a3c:	60a2                	ld	ra,8(sp)
   10a3e:	47d9                	li	a5,22
   10a40:	c11c                	sw	a5,0(a0)
   10a42:	557d                	li	a0,-1
   10a44:	0141                	addi	sp,sp,16
   10a46:	8082                	ret

0000000000010a48 <wait>:
   10a48:	1141                	addi	sp,sp,-16
   10a4a:	e406                	sd	ra,8(sp)
   10a4c:	00000097          	auipc	ra,0x0
   10a50:	ab8080e7          	jalr	-1352(ra) # 10504 <__errno>
   10a54:	60a2                	ld	ra,8(sp)
   10a56:	47a9                	li	a5,10
   10a58:	c11c                	sw	a5,0(a0)
   10a5a:	557d                	li	a0,-1
   10a5c:	0141                	addi	sp,sp,16
   10a5e:	8082                	ret

0000000000010a60 <isatty>:
   10a60:	7119                	addi	sp,sp,-128
   10a62:	002c                	addi	a1,sp,8
   10a64:	fc86                	sd	ra,120(sp)
   10a66:	e33ff0ef          	jal	ra,10898 <fstat>
   10a6a:	57fd                	li	a5,-1
   10a6c:	00f50663          	beq	a0,a5,10a78 <isatty+0x18>
   10a70:	4532                	lw	a0,12(sp)
   10a72:	40d5551b          	sraiw	a0,a0,0xd
   10a76:	8905                	andi	a0,a0,1
   10a78:	70e6                	ld	ra,120(sp)
   10a7a:	6109                	addi	sp,sp,128
   10a7c:	8082                	ret

0000000000010a7e <gettimeofday>:
   10a7e:	1141                	addi	sp,sp,-16
   10a80:	85aa                	mv	a1,a0
   10a82:	4701                	li	a4,0
   10a84:	4681                	li	a3,0
   10a86:	4601                	li	a2,0
   10a88:	0a900513          	li	a0,169
   10a8c:	e406                	sd	ra,8(sp)
   10a8e:	00000097          	auipc	ra,0x0
   10a92:	d7a080e7          	jalr	-646(ra) # 10808 <__internal_syscall>
   10a96:	60a2                	ld	ra,8(sp)
   10a98:	2501                	sext.w	a0,a0
   10a9a:	0141                	addi	sp,sp,16
   10a9c:	8082                	ret

0000000000010a9e <times>:
   10a9e:	7179                	addi	sp,sp,-48
   10aa0:	f022                	sd	s0,32(sp)
   10aa2:	842a                	mv	s0,a0
   10aa4:	8f01b783          	ld	a5,-1808(gp) # 11848 <t0.2574>
   10aa8:	ec26                	sd	s1,24(sp)
   10aaa:	f406                	sd	ra,40(sp)
   10aac:	8f018493          	addi	s1,gp,-1808 # 11848 <t0.2574>
   10ab0:	eb81                	bnez	a5,10ac0 <times+0x22>
   10ab2:	4581                	li	a1,0
   10ab4:	8f018513          	addi	a0,gp,-1808 # 11848 <t0.2574>
   10ab8:	00000097          	auipc	ra,0x0
   10abc:	fc6080e7          	jalr	-58(ra) # 10a7e <gettimeofday>
   10ac0:	850a                	mv	a0,sp
   10ac2:	4581                	li	a1,0
   10ac4:	00000097          	auipc	ra,0x0
   10ac8:	fba080e7          	jalr	-70(ra) # 10a7e <gettimeofday>
   10acc:	6098                	ld	a4,0(s1)
   10ace:	6782                	ld	a5,0(sp)
   10ad0:	6494                	ld	a3,8(s1)
   10ad2:	00043823          	sd	zero,16(s0)
   10ad6:	8f99                	sub	a5,a5,a4
   10ad8:	000f4737          	lui	a4,0xf4
   10adc:	24070713          	addi	a4,a4,576 # f4240 <__global_pointer$+0xe22e8>
   10ae0:	02e787b3          	mul	a5,a5,a4
   10ae4:	6722                	ld	a4,8(sp)
   10ae6:	00043c23          	sd	zero,24(s0)
   10aea:	00043423          	sd	zero,8(s0)
   10aee:	8f15                	sub	a4,a4,a3
   10af0:	70a2                	ld	ra,40(sp)
   10af2:	64e2                	ld	s1,24(sp)
   10af4:	557d                	li	a0,-1
   10af6:	97ba                	add	a5,a5,a4
   10af8:	e01c                	sd	a5,0(s0)
   10afa:	7402                	ld	s0,32(sp)
   10afc:	6145                	addi	sp,sp,48
   10afe:	8082                	ret

0000000000010b00 <ftime>:
   10b00:	00051423          	sh	zero,8(a0)
   10b04:	00053023          	sd	zero,0(a0)
   10b08:	4501                	li	a0,0
   10b0a:	8082                	ret

0000000000010b0c <utime>:
   10b0c:	557d                	li	a0,-1
   10b0e:	8082                	ret

0000000000010b10 <chown>:
   10b10:	557d                	li	a0,-1
   10b12:	8082                	ret

0000000000010b14 <chmod>:
   10b14:	557d                	li	a0,-1
   10b16:	8082                	ret

0000000000010b18 <chdir>:
   10b18:	557d                	li	a0,-1
   10b1a:	8082                	ret

0000000000010b1c <getcwd>:
   10b1c:	4501                	li	a0,0
   10b1e:	8082                	ret

0000000000010b20 <sysconf>:
   10b20:	4789                	li	a5,2
   10b22:	00f50463          	beq	a0,a5,10b2a <sysconf+0xa>
   10b26:	557d                	li	a0,-1
   10b28:	8082                	ret
   10b2a:	000f4537          	lui	a0,0xf4
   10b2e:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xe22e8>
   10b32:	8082                	ret

0000000000010b34 <sbrk>:
   10b34:	1101                	addi	sp,sp,-32
   10b36:	e822                	sd	s0,16(sp)
   10b38:	8b01b783          	ld	a5,-1872(gp) # 11808 <_edata>
   10b3c:	e426                	sd	s1,8(sp)
   10b3e:	ec06                	sd	ra,24(sp)
   10b40:	84aa                	mv	s1,a0
   10b42:	e785                	bnez	a5,10b6a <sbrk+0x36>
   10b44:	4701                	li	a4,0
   10b46:	4681                	li	a3,0
   10b48:	4601                	li	a2,0
   10b4a:	4581                	li	a1,0
   10b4c:	0d600513          	li	a0,214
   10b50:	cb9ff0ef          	jal	ra,10808 <__internal_syscall>
   10b54:	57fd                	li	a5,-1
   10b56:	00f51863          	bne	a0,a5,10b66 <sbrk+0x32>
   10b5a:	557d                	li	a0,-1
   10b5c:	60e2                	ld	ra,24(sp)
   10b5e:	6442                	ld	s0,16(sp)
   10b60:	64a2                	ld	s1,8(sp)
   10b62:	6105                	addi	sp,sp,32
   10b64:	8082                	ret
   10b66:	8aa1b823          	sd	a0,-1872(gp) # 11808 <_edata>
   10b6a:	8b01b583          	ld	a1,-1872(gp) # 11808 <_edata>
   10b6e:	4701                	li	a4,0
   10b70:	4681                	li	a3,0
   10b72:	95a6                	add	a1,a1,s1
   10b74:	4601                	li	a2,0
   10b76:	0d600513          	li	a0,214
   10b7a:	c8fff0ef          	jal	ra,10808 <__internal_syscall>
   10b7e:	8b01b783          	ld	a5,-1872(gp) # 11808 <_edata>
   10b82:	94be                	add	s1,s1,a5
   10b84:	fc951be3          	bne	a0,s1,10b5a <sbrk+0x26>
   10b88:	8aa1b823          	sd	a0,-1872(gp) # 11808 <_edata>
   10b8c:	853e                	mv	a0,a5
   10b8e:	b7f9                	j	10b5c <sbrk+0x28>

0000000000010b90 <_exit>:
   10b90:	1141                	addi	sp,sp,-16
   10b92:	85aa                	mv	a1,a0
   10b94:	4701                	li	a4,0
   10b96:	4681                	li	a3,0
   10b98:	4601                	li	a2,0
   10b9a:	05d00513          	li	a0,93
   10b9e:	e406                	sd	ra,8(sp)
   10ba0:	00000097          	auipc	ra,0x0
   10ba4:	c68080e7          	jalr	-920(ra) # 10808 <__internal_syscall>
   10ba8:	a001                	j	10ba8 <_exit+0x18>
