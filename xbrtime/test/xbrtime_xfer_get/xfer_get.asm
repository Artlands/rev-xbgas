
xfer_get.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <_start>:
   100b0:	00009197          	auipc	gp,0x9
   100b4:	ea818193          	addi	gp,gp,-344 # 18f58 <__global_pointer$>
   100b8:	8b018513          	addi	a0,gp,-1872 # 18808 <_edata>
   100bc:	90818613          	addi	a2,gp,-1784 # 18860 <_end>
   100c0:	8e09                	sub	a2,a2,a0
   100c2:	4581                	li	a1,0
   100c4:	28e070ef          	jal	ra,17352 <memset>
   100c8:	00007517          	auipc	a0,0x7
   100cc:	1d450513          	addi	a0,a0,468 # 1729c <__libc_fini_array>
   100d0:	00007097          	auipc	ra,0x7
   100d4:	192080e7          	jalr	402(ra) # 17262 <atexit>
   100d8:	00007097          	auipc	ra,0x7
   100dc:	212080e7          	jalr	530(ra) # 172ea <__libc_init_array>
   100e0:	4502                	lw	a0,0(sp)
   100e2:	002c                	addi	a1,sp,8
   100e4:	4601                	li	a2,0
   100e6:	00000097          	auipc	ra,0x0
   100ea:	0c6080e7          	jalr	198(ra) # 101ac <main>
   100ee:	00007317          	auipc	t1,0x7
   100f2:	18a30067          	jr	394(t1) # 17278 <exit>

00000000000100f6 <_fini>:
   100f6:	8082                	ret

00000000000100f8 <deregister_tm_clones>:
   100f8:	6561                	lui	a0,0x18
   100fa:	67e1                	lui	a5,0x18
   100fc:	75850713          	addi	a4,a0,1880 # 18758 <__TMC_END__>
   10100:	75878793          	addi	a5,a5,1880 # 18758 <__TMC_END__>
   10104:	00e78b63          	beq	a5,a4,1011a <deregister_tm_clones+0x22>
   10108:	00000337          	lui	t1,0x0
   1010c:	00030313          	mv	t1,t1
   10110:	00030563          	beqz	t1,1011a <deregister_tm_clones+0x22>
   10114:	75850513          	addi	a0,a0,1880
   10118:	8302                	jr	t1
   1011a:	8082                	ret

000000000001011c <register_tm_clones>:
   1011c:	67e1                	lui	a5,0x18
   1011e:	6561                	lui	a0,0x18
   10120:	75878593          	addi	a1,a5,1880 # 18758 <__TMC_END__>
   10124:	75850793          	addi	a5,a0,1880 # 18758 <__TMC_END__>
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
   10148:	8c01c703          	lbu	a4,-1856(gp) # 18818 <completed.5184>
   1014c:	eb15                	bnez	a4,10180 <__do_global_dtors_aux+0x38>
   1014e:	1141                	addi	sp,sp,-16
   10150:	e022                	sd	s0,0(sp)
   10152:	e406                	sd	ra,8(sp)
   10154:	843e                	mv	s0,a5
   10156:	fa3ff0ef          	jal	ra,100f8 <deregister_tm_clones>
   1015a:	000007b7          	lui	a5,0x0
   1015e:	00078793          	mv	a5,a5
   10162:	cb81                	beqz	a5,10172 <__do_global_dtors_aux+0x2a>
   10164:	6561                	lui	a0,0x18
   10166:	a3050513          	addi	a0,a0,-1488 # 17a30 <__EH_FRAME_BEGIN__>
   1016a:	ffff0097          	auipc	ra,0xffff0
   1016e:	e96080e7          	jalr	-362(ra) # 0 <_start-0x100b0>
   10172:	4785                	li	a5,1
   10174:	8cf18023          	sb	a5,-1856(gp) # 18818 <completed.5184>
   10178:	60a2                	ld	ra,8(sp)
   1017a:	6402                	ld	s0,0(sp)
   1017c:	0141                	addi	sp,sp,16
   1017e:	8082                	ret
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	000007b7          	lui	a5,0x0
   10186:	00078793          	mv	a5,a5
   1018a:	cf91                	beqz	a5,101a6 <frame_dummy+0x24>
   1018c:	6561                	lui	a0,0x18
   1018e:	1141                	addi	sp,sp,-16
   10190:	8c818593          	addi	a1,gp,-1848 # 18820 <object.5189>
   10194:	a3050513          	addi	a0,a0,-1488 # 17a30 <__EH_FRAME_BEGIN__>
   10198:	e406                	sd	ra,8(sp)
   1019a:	ffff0097          	auipc	ra,0xffff0
   1019e:	e66080e7          	jalr	-410(ra) # 0 <_start-0x100b0>
   101a2:	60a2                	ld	ra,8(sp)
   101a4:	0141                	addi	sp,sp,16
   101a6:	f77ff06f          	j	1011c <register_tm_clones>
	...

00000000000101ac <main>:
   101ac:	fc010113          	addi	sp,sp,-64
   101b0:	02113c23          	sd	ra,56(sp)
   101b4:	02813823          	sd	s0,48(sp)
   101b8:	04010413          	addi	s0,sp,64
   101bc:	00050793          	mv	a5,a0
   101c0:	fcb43023          	sd	a1,-64(s0)
   101c4:	fcf42623          	sw	a5,-52(s0)
   101c8:	fe043423          	sd	zero,-24(s0)
   101cc:	00800793          	li	a5,8
   101d0:	fef43023          	sd	a5,-32(s0)
   101d4:	000187b7          	lui	a5,0x18
   101d8:	91878513          	addi	a0,a5,-1768 # 17918 <_exit+0x1c>
   101dc:	00007097          	auipc	ra,0x7
   101e0:	a54080e7          	jalr	-1452(ra) # 16c30 <revprintf>
   101e4:	765050ef          	jal	ra,16148 <xbrtime_init>
   101e8:	17c060ef          	jal	ra,16364 <xbrtime_mype>
   101ec:	00050793          	mv	a5,a0
   101f0:	fcf42e23          	sw	a5,-36(s0)
   101f4:	00006097          	auipc	ra,0x6
   101f8:	186080e7          	jalr	390(ra) # 1637a <xbrtime_num_pes>
   101fc:	00050793          	mv	a5,a0
   10200:	fcf42c23          	sw	a5,-40(s0)
   10204:	00100793          	li	a5,1
   10208:	fcf42a23          	sw	a5,-44(s0)
   1020c:	fe043503          	ld	a0,-32(s0)
   10210:	5a4000ef          	jal	ra,107b4 <xbrtime_malloc>
   10214:	fea43423          	sd	a0,-24(s0)
   10218:	fdc42783          	lw	a5,-36(s0)
   1021c:	00a7879b          	addiw	a5,a5,10
   10220:	0007871b          	sext.w	a4,a5
   10224:	fe843783          	ld	a5,-24(s0)
   10228:	00e7a023          	sw	a4,0(a5)
   1022c:	fe843783          	ld	a5,-24(s0)
   10230:	0007a703          	lw	a4,0(a5)
   10234:	fdc42783          	lw	a5,-36(s0)
   10238:	00070613          	mv	a2,a4
   1023c:	00078593          	mv	a1,a5
   10240:	000187b7          	lui	a5,0x18
   10244:	93878513          	addi	a0,a5,-1736 # 17938 <_exit+0x3c>
   10248:	00007097          	auipc	ra,0x7
   1024c:	9e8080e7          	jalr	-1560(ra) # 16c30 <revprintf>
   10250:	539050ef          	jal	ra,15f88 <xbrtime_barrier>
   10254:	110060ef          	jal	ra,16364 <xbrtime_mype>
   10258:	00050793          	mv	a5,a0
   1025c:	04079463          	bnez	a5,102a4 <main+0xf8>
   10260:	104060ef          	jal	ra,16364 <xbrtime_mype>
   10264:	00050793          	mv	a5,a0
   10268:	00078713          	mv	a4,a5
   1026c:	fd442783          	lw	a5,-44(s0)
   10270:	00078613          	mv	a2,a5
   10274:	00070593          	mv	a1,a4
   10278:	000187b7          	lui	a5,0x18
   1027c:	95878513          	addi	a0,a5,-1704 # 17958 <_exit+0x5c>
   10280:	00007097          	auipc	ra,0x7
   10284:	9b0080e7          	jalr	-1616(ra) # 16c30 <revprintf>
   10288:	fd442783          	lw	a5,-44(s0)
   1028c:	00078713          	mv	a4,a5
   10290:	00100693          	li	a3,1
   10294:	00100613          	li	a2,1
   10298:	fe843583          	ld	a1,-24(s0)
   1029c:	fe843503          	ld	a0,-24(s0)
   102a0:	10d040ef          	jal	ra,14bac <xbrtime_ulonglong_get>
   102a4:	4e5050ef          	jal	ra,15f88 <xbrtime_barrier>
   102a8:	fe843783          	ld	a5,-24(s0)
   102ac:	0007a703          	lw	a4,0(a5)
   102b0:	fdc42783          	lw	a5,-36(s0)
   102b4:	00070613          	mv	a2,a4
   102b8:	00078593          	mv	a1,a5
   102bc:	000187b7          	lui	a5,0x18
   102c0:	97878513          	addi	a0,a5,-1672 # 17978 <_exit+0x7c>
   102c4:	00007097          	auipc	ra,0x7
   102c8:	96c080e7          	jalr	-1684(ra) # 16c30 <revprintf>
   102cc:	fe843503          	ld	a0,-24(s0)
   102d0:	00000097          	auipc	ra,0x0
   102d4:	51c080e7          	jalr	1308(ra) # 107ec <xbrtime_free>
   102d8:	00006097          	auipc	ra,0x6
   102dc:	004080e7          	jalr	4(ra) # 162dc <xbrtime_close>
   102e0:	00000793          	li	a5,0
   102e4:	00078513          	mv	a0,a5
   102e8:	03813083          	ld	ra,56(sp)
   102ec:	03013403          	ld	s0,48(sp)
   102f0:	04010113          	addi	sp,sp,64
   102f4:	00008067          	ret
	...

00000000000102fa <revmalloc>:
   102fa:	7139                	addi	sp,sp,-64
   102fc:	fc06                	sd	ra,56(sp)
   102fe:	f822                	sd	s0,48(sp)
   10300:	0080                	addi	s0,sp,64
   10302:	fca43423          	sd	a0,-56(s0)
   10306:	200007b7          	lui	a5,0x20000
   1030a:	fef42223          	sw	a5,-28(s0)
   1030e:	8b01b783          	ld	a5,-1872(gp) # 18808 <_edata>
   10312:	c7f1                	beqz	a5,103de <revmalloc+0xe4>
   10314:	8b01b783          	ld	a5,-1872(gp) # 18808 <_edata>
   10318:	fef43423          	sd	a5,-24(s0)
   1031c:	a055                	j	103c0 <revmalloc+0xc6>
   1031e:	fe843783          	ld	a5,-24(s0)
   10322:	4f9c                	lw	a5,24(a5)
   10324:	cbc9                	beqz	a5,103b6 <revmalloc+0xbc>
   10326:	fe843783          	ld	a5,-24(s0)
   1032a:	6b9c                	ld	a5,16(a5)
   1032c:	fc843703          	ld	a4,-56(s0)
   10330:	08e7e363          	bltu	a5,a4,103b6 <revmalloc+0xbc>
   10334:	fe843783          	ld	a5,-24(s0)
   10338:	6b98                	ld	a4,16(a5)
   1033a:	fc843783          	ld	a5,-56(s0)
   1033e:	02078793          	addi	a5,a5,32 # 20000020 <__global_pointer$+0x1ffe70c8>
   10342:	06e7f163          	bleu	a4,a5,103a4 <revmalloc+0xaa>
   10346:	fc843783          	ld	a5,-56(s0)
   1034a:	02078793          	addi	a5,a5,32
   1034e:	0796                	slli	a5,a5,0x5
   10350:	fe843703          	ld	a4,-24(s0)
   10354:	97ba                	add	a5,a5,a4
   10356:	fcf43c23          	sd	a5,-40(s0)
   1035a:	fe843783          	ld	a5,-24(s0)
   1035e:	6b98                	ld	a4,16(a5)
   10360:	fc843783          	ld	a5,-56(s0)
   10364:	40f707b3          	sub	a5,a4,a5
   10368:	fe078713          	addi	a4,a5,-32
   1036c:	fd843783          	ld	a5,-40(s0)
   10370:	eb98                	sd	a4,16(a5)
   10372:	fd843783          	ld	a5,-40(s0)
   10376:	4705                	li	a4,1
   10378:	cf98                	sw	a4,24(a5)
   1037a:	fd843783          	ld	a5,-40(s0)
   1037e:	fe843703          	ld	a4,-24(s0)
   10382:	e798                	sd	a4,8(a5)
   10384:	fe843783          	ld	a5,-24(s0)
   10388:	6398                	ld	a4,0(a5)
   1038a:	fd843783          	ld	a5,-40(s0)
   1038e:	e398                	sd	a4,0(a5)
   10390:	fe843783          	ld	a5,-24(s0)
   10394:	fc843703          	ld	a4,-56(s0)
   10398:	eb98                	sd	a4,16(a5)
   1039a:	fe843783          	ld	a5,-24(s0)
   1039e:	fd843703          	ld	a4,-40(s0)
   103a2:	e398                	sd	a4,0(a5)
   103a4:	fe843783          	ld	a5,-24(s0)
   103a8:	0007ac23          	sw	zero,24(a5)
   103ac:	fe843783          	ld	a5,-24(s0)
   103b0:	02078793          	addi	a5,a5,32
   103b4:	a865                	j	1046c <revmalloc+0x172>
   103b6:	fe843783          	ld	a5,-24(s0)
   103ba:	639c                	ld	a5,0(a5)
   103bc:	fef43423          	sd	a5,-24(s0)
   103c0:	fe843783          	ld	a5,-24(s0)
   103c4:	ffa9                	bnez	a5,1031e <revmalloc+0x24>
   103c6:	fe843783          	ld	a5,-24(s0)
   103ca:	e3cd                	bnez	a5,1046c <revmalloc+0x172>
   103cc:	67e1                	lui	a5,0x18
   103ce:	99878513          	addi	a0,a5,-1640 # 17998 <_exit+0x9c>
   103d2:	00007097          	auipc	ra,0x7
   103d6:	85e080e7          	jalr	-1954(ra) # 16c30 <revprintf>
   103da:	4781                	li	a5,0
   103dc:	a841                	j	1046c <revmalloc+0x172>
   103de:	3fffd7b7          	lui	a5,0x3fffd
   103e2:	0d878793          	addi	a5,a5,216 # 3fffd0d8 <__global_pointer$+0x3ffe4180>
   103e6:	639c                	ld	a5,0(a5)
   103e8:	fef43423          	sd	a5,-24(s0)
   103ec:	fe843783          	ld	a5,-24(s0)
   103f0:	fc843703          	ld	a4,-56(s0)
   103f4:	eb98                	sd	a4,16(a5)
   103f6:	fe843783          	ld	a5,-24(s0)
   103fa:	0007ac23          	sw	zero,24(a5)
   103fe:	fe843783          	ld	a5,-24(s0)
   10402:	0007b423          	sd	zero,8(a5)
   10406:	fc843783          	ld	a5,-56(s0)
   1040a:	02078793          	addi	a5,a5,32
   1040e:	fe843703          	ld	a4,-24(s0)
   10412:	97ba                	add	a5,a5,a4
   10414:	fcf43c23          	sd	a5,-40(s0)
   10418:	fe442703          	lw	a4,-28(s0)
   1041c:	fc843783          	ld	a5,-56(s0)
   10420:	2781                	sext.w	a5,a5
   10422:	40f707bb          	subw	a5,a4,a5
   10426:	2781                	sext.w	a5,a5
   10428:	3781                	addiw	a5,a5,-32
   1042a:	2781                	sext.w	a5,a5
   1042c:	2781                	sext.w	a5,a5
   1042e:	873e                	mv	a4,a5
   10430:	fd843783          	ld	a5,-40(s0)
   10434:	eb98                	sd	a4,16(a5)
   10436:	fd843783          	ld	a5,-40(s0)
   1043a:	4705                	li	a4,1
   1043c:	cf98                	sw	a4,24(a5)
   1043e:	fd843783          	ld	a5,-40(s0)
   10442:	fe843703          	ld	a4,-24(s0)
   10446:	e798                	sd	a4,8(a5)
   10448:	fd843783          	ld	a5,-40(s0)
   1044c:	0007b023          	sd	zero,0(a5)
   10450:	fe843783          	ld	a5,-24(s0)
   10454:	fd843703          	ld	a4,-40(s0)
   10458:	e398                	sd	a4,0(a5)
   1045a:	fe843703          	ld	a4,-24(s0)
   1045e:	8ae1b823          	sd	a4,-1872(gp) # 18808 <_edata>
   10462:	fe843783          	ld	a5,-24(s0)
   10466:	02078793          	addi	a5,a5,32
   1046a:	a009                	j	1046c <revmalloc+0x172>
   1046c:	853e                	mv	a0,a5
   1046e:	70e2                	ld	ra,56(sp)
   10470:	7442                	ld	s0,48(sp)
   10472:	6121                	addi	sp,sp,64
   10474:	8082                	ret

0000000000010476 <revfree>:
   10476:	7139                	addi	sp,sp,-64
   10478:	fc22                	sd	s0,56(sp)
   1047a:	0080                	addi	s0,sp,64
   1047c:	fca43423          	sd	a0,-56(s0)
   10480:	fc843783          	ld	a5,-56(s0)
   10484:	fef43023          	sd	a5,-32(s0)
   10488:	fc843783          	ld	a5,-56(s0)
   1048c:	c3f1                	beqz	a5,10550 <revfree+0xda>
   1048e:	8b01b783          	ld	a5,-1872(gp) # 18808 <_edata>
   10492:	c3e9                	beqz	a5,10554 <revfree+0xde>
   10494:	fe043783          	ld	a5,-32(s0)
   10498:	1781                	addi	a5,a5,-32
   1049a:	fcf43c23          	sd	a5,-40(s0)
   1049e:	fd843783          	ld	a5,-40(s0)
   104a2:	679c                	ld	a5,8(a5)
   104a4:	fcf43823          	sd	a5,-48(s0)
   104a8:	fd843783          	ld	a5,-40(s0)
   104ac:	4705                	li	a4,1
   104ae:	cf98                	sw	a4,24(a5)
   104b0:	fe043423          	sd	zero,-24(s0)
   104b4:	a829                	j	104ce <revfree+0x58>
   104b6:	fe043703          	ld	a4,-32(s0)
   104ba:	fe843783          	ld	a5,-24(s0)
   104be:	97ba                	add	a5,a5,a4
   104c0:	00078023          	sb	zero,0(a5)
   104c4:	fe843783          	ld	a5,-24(s0)
   104c8:	0785                	addi	a5,a5,1
   104ca:	fef43423          	sd	a5,-24(s0)
   104ce:	fd843783          	ld	a5,-40(s0)
   104d2:	6b9c                	ld	a5,16(a5)
   104d4:	2781                	sext.w	a5,a5
   104d6:	873e                	mv	a4,a5
   104d8:	fe843783          	ld	a5,-24(s0)
   104dc:	fce7ede3          	bltu	a5,a4,104b6 <revfree+0x40>
   104e0:	a02d                	j	1050a <revfree+0x94>
   104e2:	fd843783          	ld	a5,-40(s0)
   104e6:	6b98                	ld	a4,16(a5)
   104e8:	fd843783          	ld	a5,-40(s0)
   104ec:	639c                	ld	a5,0(a5)
   104ee:	6b9c                	ld	a5,16(a5)
   104f0:	97ba                	add	a5,a5,a4
   104f2:	02078713          	addi	a4,a5,32
   104f6:	fd843783          	ld	a5,-40(s0)
   104fa:	eb98                	sd	a4,16(a5)
   104fc:	fd843783          	ld	a5,-40(s0)
   10500:	639c                	ld	a5,0(a5)
   10502:	6398                	ld	a4,0(a5)
   10504:	fd843783          	ld	a5,-40(s0)
   10508:	e398                	sd	a4,0(a5)
   1050a:	fd843783          	ld	a5,-40(s0)
   1050e:	639c                	ld	a5,0(a5)
   10510:	c791                	beqz	a5,1051c <revfree+0xa6>
   10512:	fd843783          	ld	a5,-40(s0)
   10516:	639c                	ld	a5,0(a5)
   10518:	4f9c                	lw	a5,24(a5)
   1051a:	f7e1                	bnez	a5,104e2 <revfree+0x6c>
   1051c:	fd043783          	ld	a5,-48(s0)
   10520:	cb9d                	beqz	a5,10556 <revfree+0xe0>
   10522:	fd043783          	ld	a5,-48(s0)
   10526:	4f9c                	lw	a5,24(a5)
   10528:	c79d                	beqz	a5,10556 <revfree+0xe0>
   1052a:	fd043783          	ld	a5,-48(s0)
   1052e:	6b98                	ld	a4,16(a5)
   10530:	fd843783          	ld	a5,-40(s0)
   10534:	6b9c                	ld	a5,16(a5)
   10536:	97ba                	add	a5,a5,a4
   10538:	02078713          	addi	a4,a5,32
   1053c:	fd043783          	ld	a5,-48(s0)
   10540:	eb98                	sd	a4,16(a5)
   10542:	fd843783          	ld	a5,-40(s0)
   10546:	6398                	ld	a4,0(a5)
   10548:	fd043783          	ld	a5,-48(s0)
   1054c:	e398                	sd	a4,0(a5)
   1054e:	a021                	j	10556 <revfree+0xe0>
   10550:	0001                	nop
   10552:	a011                	j	10556 <revfree+0xe0>
   10554:	0001                	nop
   10556:	7462                	ld	s0,56(sp)
   10558:	6121                	addi	sp,sp,64
   1055a:	8082                	ret

000000000001055c <__xbrtime_shared_malloc>:
   1055c:	7139                	addi	sp,sp,-64
   1055e:	fc06                	sd	ra,56(sp)
   10560:	f822                	sd	s0,48(sp)
   10562:	0080                	addi	s0,sp,64
   10564:	fca43423          	sd	a0,-56(s0)
   10568:	fc043c23          	sd	zero,-40(s0)
   1056c:	57fd                	li	a5,-1
   1056e:	fef42623          	sw	a5,-20(s0)
   10572:	fe042423          	sw	zero,-24(s0)
   10576:	fe042223          	sw	zero,-28(s0)
   1057a:	fc843783          	ld	a5,-56(s0)
   1057e:	079d                	addi	a5,a5,7
   10580:	9be1                	andi	a5,a5,-8
   10582:	fcf43423          	sd	a5,-56(s0)
   10586:	a0a9                	j	105d0 <__xbrtime_shared_malloc+0x74>
   10588:	fe842783          	lw	a5,-24(s0)
   1058c:	0047979b          	slliw	a5,a5,0x4
   10590:	2781                	sext.w	a5,a5
   10592:	27a1                	addiw	a5,a5,8
   10594:	2781                	sext.w	a5,a5
   10596:	873e                	mv	a4,a5
   10598:	3fff07b7          	lui	a5,0x3fff0
   1059c:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   105a0:	97ba                	add	a5,a5,a4
   105a2:	639c                	ld	a5,0(a5)
   105a4:	eb81                	bnez	a5,105b4 <__xbrtime_shared_malloc+0x58>
   105a6:	fe842783          	lw	a5,-24(s0)
   105aa:	fef42623          	sw	a5,-20(s0)
   105ae:	4785                	li	a5,1
   105b0:	fef42223          	sw	a5,-28(s0)
   105b4:	fe842783          	lw	a5,-24(s0)
   105b8:	2785                	addiw	a5,a5,1
   105ba:	fef42423          	sw	a5,-24(s0)
   105be:	fe842783          	lw	a5,-24(s0)
   105c2:	8007879b          	addiw	a5,a5,-2048
   105c6:	2781                	sext.w	a5,a5
   105c8:	e781                	bnez	a5,105d0 <__xbrtime_shared_malloc+0x74>
   105ca:	4785                	li	a5,1
   105cc:	fef42223          	sw	a5,-28(s0)
   105d0:	fec42783          	lw	a5,-20(s0)
   105d4:	0007871b          	sext.w	a4,a5
   105d8:	57fd                	li	a5,-1
   105da:	00f71963          	bne	a4,a5,105ec <__xbrtime_shared_malloc+0x90>
   105de:	fe442783          	lw	a5,-28(s0)
   105e2:	0007871b          	sext.w	a4,a5
   105e6:	4785                	li	a5,1
   105e8:	faf710e3          	bne	a4,a5,10588 <__xbrtime_shared_malloc+0x2c>
   105ec:	fec42783          	lw	a5,-20(s0)
   105f0:	0007871b          	sext.w	a4,a5
   105f4:	57fd                	li	a5,-1
   105f6:	00f71463          	bne	a4,a5,105fe <__xbrtime_shared_malloc+0xa2>
   105fa:	4781                	li	a5,0
   105fc:	a059                	j	10682 <__xbrtime_shared_malloc+0x126>
   105fe:	fc843503          	ld	a0,-56(s0)
   10602:	cf9ff0ef          	jal	ra,102fa <revmalloc>
   10606:	fca43c23          	sd	a0,-40(s0)
   1060a:	fd843783          	ld	a5,-40(s0)
   1060e:	e399                	bnez	a5,10614 <__xbrtime_shared_malloc+0xb8>
   10610:	4781                	li	a5,0
   10612:	a885                	j	10682 <__xbrtime_shared_malloc+0x126>
   10614:	fec42783          	lw	a5,-20(s0)
   10618:	0047979b          	slliw	a5,a5,0x4
   1061c:	2781                	sext.w	a5,a5
   1061e:	27a1                	addiw	a5,a5,8
   10620:	2781                	sext.w	a5,a5
   10622:	873e                	mv	a4,a5
   10624:	3fff07b7          	lui	a5,0x3fff0
   10628:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1062c:	97ba                	add	a5,a5,a4
   1062e:	873e                	mv	a4,a5
   10630:	fc843783          	ld	a5,-56(s0)
   10634:	e31c                	sd	a5,0(a4)
   10636:	fec42783          	lw	a5,-20(s0)
   1063a:	0047979b          	slliw	a5,a5,0x4
   1063e:	2781                	sext.w	a5,a5
   10640:	873e                	mv	a4,a5
   10642:	3fff07b7          	lui	a5,0x3fff0
   10646:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1064a:	97ba                	add	a5,a5,a4
   1064c:	873e                	mv	a4,a5
   1064e:	fd843783          	ld	a5,-40(s0)
   10652:	e31c                	sd	a5,0(a4)
   10654:	3fff07b7          	lui	a5,0x3fff0
   10658:	07c1                	addi	a5,a5,16
   1065a:	639c                	ld	a5,0(a5)
   1065c:	fcf43823          	sd	a5,-48(s0)
   10660:	fc843703          	ld	a4,-56(s0)
   10664:	fd043783          	ld	a5,-48(s0)
   10668:	973e                	add	a4,a4,a5
   1066a:	3fff07b7          	lui	a5,0x3fff0
   1066e:	07c1                	addi	a5,a5,16
   10670:	e398                	sd	a4,0(a5)
   10672:	3fff07b7          	lui	a5,0x3fff0
   10676:	07e1                	addi	a5,a5,24
   10678:	fd843703          	ld	a4,-40(s0)
   1067c:	e398                	sd	a4,0(a5)
   1067e:	fd843783          	ld	a5,-40(s0)
   10682:	853e                	mv	a0,a5
   10684:	70e2                	ld	ra,56(sp)
   10686:	7442                	ld	s0,48(sp)
   10688:	6121                	addi	sp,sp,64
   1068a:	8082                	ret

000000000001068c <__xbrtime_shared_free>:
   1068c:	7139                	addi	sp,sp,-64
   1068e:	fc06                	sd	ra,56(sp)
   10690:	f822                	sd	s0,48(sp)
   10692:	0080                	addi	s0,sp,64
   10694:	fca43423          	sd	a0,-56(s0)
   10698:	fc843783          	ld	a5,-56(s0)
   1069c:	fef43023          	sd	a5,-32(s0)
   106a0:	fe042623          	sw	zero,-20(s0)
   106a4:	fe042623          	sw	zero,-20(s0)
   106a8:	a8d5                	j	1079c <__xbrtime_shared_free+0x110>
   106aa:	fec42783          	lw	a5,-20(s0)
   106ae:	0047979b          	slliw	a5,a5,0x4
   106b2:	2781                	sext.w	a5,a5
   106b4:	873e                	mv	a4,a5
   106b6:	3fff07b7          	lui	a5,0x3fff0
   106ba:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   106be:	97ba                	add	a5,a5,a4
   106c0:	639c                	ld	a5,0(a5)
   106c2:	fe043703          	ld	a4,-32(s0)
   106c6:	0cf76663          	bltu	a4,a5,10792 <__xbrtime_shared_free+0x106>
   106ca:	fec42783          	lw	a5,-20(s0)
   106ce:	0047979b          	slliw	a5,a5,0x4
   106d2:	2781                	sext.w	a5,a5
   106d4:	873e                	mv	a4,a5
   106d6:	3fff07b7          	lui	a5,0x3fff0
   106da:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   106de:	97ba                	add	a5,a5,a4
   106e0:	6398                	ld	a4,0(a5)
   106e2:	fec42783          	lw	a5,-20(s0)
   106e6:	0047979b          	slliw	a5,a5,0x4
   106ea:	2781                	sext.w	a5,a5
   106ec:	27a1                	addiw	a5,a5,8
   106ee:	2781                	sext.w	a5,a5
   106f0:	86be                	mv	a3,a5
   106f2:	3fff07b7          	lui	a5,0x3fff0
   106f6:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   106fa:	97b6                	add	a5,a5,a3
   106fc:	639c                	ld	a5,0(a5)
   106fe:	97ba                	add	a5,a5,a4
   10700:	fe043703          	ld	a4,-32(s0)
   10704:	08f77763          	bleu	a5,a4,10792 <__xbrtime_shared_free+0x106>
   10708:	fc843503          	ld	a0,-56(s0)
   1070c:	d6bff0ef          	jal	ra,10476 <revfree>
   10710:	3fff07b7          	lui	a5,0x3fff0
   10714:	07c1                	addi	a5,a5,16
   10716:	639c                	ld	a5,0(a5)
   10718:	fcf43c23          	sd	a5,-40(s0)
   1071c:	fec42783          	lw	a5,-20(s0)
   10720:	0047979b          	slliw	a5,a5,0x4
   10724:	2781                	sext.w	a5,a5
   10726:	27a1                	addiw	a5,a5,8
   10728:	2781                	sext.w	a5,a5
   1072a:	873e                	mv	a4,a5
   1072c:	3fff07b7          	lui	a5,0x3fff0
   10730:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   10734:	97ba                	add	a5,a5,a4
   10736:	639c                	ld	a5,0(a5)
   10738:	fcf43823          	sd	a5,-48(s0)
   1073c:	fd843703          	ld	a4,-40(s0)
   10740:	fd043783          	ld	a5,-48(s0)
   10744:	8f1d                	sub	a4,a4,a5
   10746:	3fff07b7          	lui	a5,0x3fff0
   1074a:	07c1                	addi	a5,a5,16
   1074c:	e398                	sd	a4,0(a5)
   1074e:	3fff07b7          	lui	a5,0x3fff0
   10752:	07e1                	addi	a5,a5,24
   10754:	0007b023          	sd	zero,0(a5) # 3fff0000 <__global_pointer$+0x3ffd70a8>
   10758:	fec42783          	lw	a5,-20(s0)
   1075c:	0047979b          	slliw	a5,a5,0x4
   10760:	2781                	sext.w	a5,a5
   10762:	873e                	mv	a4,a5
   10764:	3fff07b7          	lui	a5,0x3fff0
   10768:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1076c:	97ba                	add	a5,a5,a4
   1076e:	0007b023          	sd	zero,0(a5)
   10772:	fec42783          	lw	a5,-20(s0)
   10776:	0047979b          	slliw	a5,a5,0x4
   1077a:	2781                	sext.w	a5,a5
   1077c:	27a1                	addiw	a5,a5,8
   1077e:	2781                	sext.w	a5,a5
   10780:	873e                	mv	a4,a5
   10782:	3fff07b7          	lui	a5,0x3fff0
   10786:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1078a:	97ba                	add	a5,a5,a4
   1078c:	0007b023          	sd	zero,0(a5)
   10790:	a831                	j	107ac <__xbrtime_shared_free+0x120>
   10792:	fec42783          	lw	a5,-20(s0)
   10796:	2785                	addiw	a5,a5,1
   10798:	fef42623          	sw	a5,-20(s0)
   1079c:	fec42783          	lw	a5,-20(s0)
   107a0:	0007871b          	sext.w	a4,a5
   107a4:	7ff00793          	li	a5,2047
   107a8:	f0e7d1e3          	ble	a4,a5,106aa <__xbrtime_shared_free+0x1e>
   107ac:	70e2                	ld	ra,56(sp)
   107ae:	7442                	ld	s0,48(sp)
   107b0:	6121                	addi	sp,sp,64
   107b2:	8082                	ret

00000000000107b4 <xbrtime_malloc>:
   107b4:	7179                	addi	sp,sp,-48
   107b6:	f406                	sd	ra,40(sp)
   107b8:	f022                	sd	s0,32(sp)
   107ba:	1800                	addi	s0,sp,48
   107bc:	fca43c23          	sd	a0,-40(s0)
   107c0:	fe043423          	sd	zero,-24(s0)
   107c4:	fd843783          	ld	a5,-40(s0)
   107c8:	e399                	bnez	a5,107ce <xbrtime_malloc+0x1a>
   107ca:	4781                	li	a5,0
   107cc:	a819                	j	107e2 <xbrtime_malloc+0x2e>
   107ce:	fd843503          	ld	a0,-40(s0)
   107d2:	d8bff0ef          	jal	ra,1055c <__xbrtime_shared_malloc>
   107d6:	fea43423          	sd	a0,-24(s0)
   107da:	77a060ef          	jal	ra,16f54 <__xbrtime_asm_quiet_fence>
   107de:	fe843783          	ld	a5,-24(s0)
   107e2:	853e                	mv	a0,a5
   107e4:	70a2                	ld	ra,40(sp)
   107e6:	7402                	ld	s0,32(sp)
   107e8:	6145                	addi	sp,sp,48
   107ea:	8082                	ret

00000000000107ec <xbrtime_free>:
   107ec:	1101                	addi	sp,sp,-32
   107ee:	ec06                	sd	ra,24(sp)
   107f0:	e822                	sd	s0,16(sp)
   107f2:	1000                	addi	s0,sp,32
   107f4:	fea43423          	sd	a0,-24(s0)
   107f8:	fe843783          	ld	a5,-24(s0)
   107fc:	cb91                	beqz	a5,10810 <xbrtime_free+0x24>
   107fe:	fe843503          	ld	a0,-24(s0)
   10802:	e8bff0ef          	jal	ra,1068c <__xbrtime_shared_free>
   10806:	00006097          	auipc	ra,0x6
   1080a:	74e080e7          	jalr	1870(ra) # 16f54 <__xbrtime_asm_quiet_fence>
   1080e:	a011                	j	10812 <xbrtime_free+0x26>
   10810:	0001                	nop
   10812:	60e2                	ld	ra,24(sp)
   10814:	6442                	ld	s0,16(sp)
   10816:	6105                	addi	sp,sp,32
   10818:	8082                	ret

000000000001081a <__xbrtime_ltor>:
   1081a:	7139                	addi	sp,sp,-64
   1081c:	fc06                	sd	ra,56(sp)
   1081e:	f822                	sd	s0,48(sp)
   10820:	0080                	addi	s0,sp,64
   10822:	fca43423          	sd	a0,-56(s0)
   10826:	87ae                	mv	a5,a1
   10828:	fcf42223          	sw	a5,-60(s0)
   1082c:	fe042623          	sw	zero,-20(s0)
   10830:	fe043023          	sd	zero,-32(s0)
   10834:	fc043c23          	sd	zero,-40(s0)
   10838:	fc043823          	sd	zero,-48(s0)
   1083c:	329050ef          	jal	ra,16364 <xbrtime_mype>
   10840:	87aa                	mv	a5,a0
   10842:	873e                	mv	a4,a5
   10844:	fc442783          	lw	a5,-60(s0)
   10848:	2781                	sext.w	a5,a5
   1084a:	00e79563          	bne	a5,a4,10854 <__xbrtime_ltor+0x3a>
   1084e:	fc843783          	ld	a5,-56(s0)
   10852:	a0e5                	j	1093a <__xbrtime_ltor+0x120>
   10854:	fe042623          	sw	zero,-20(s0)
   10858:	a8c1                	j	10928 <__xbrtime_ltor+0x10e>
   1085a:	fec42783          	lw	a5,-20(s0)
   1085e:	0047979b          	slliw	a5,a5,0x4
   10862:	2781                	sext.w	a5,a5
   10864:	873e                	mv	a4,a5
   10866:	3fff07b7          	lui	a5,0x3fff0
   1086a:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1086e:	97ba                	add	a5,a5,a4
   10870:	639c                	ld	a5,0(a5)
   10872:	fc843703          	ld	a4,-56(s0)
   10876:	0af76463          	bltu	a4,a5,1091e <__xbrtime_ltor+0x104>
   1087a:	fec42783          	lw	a5,-20(s0)
   1087e:	0047979b          	slliw	a5,a5,0x4
   10882:	2781                	sext.w	a5,a5
   10884:	873e                	mv	a4,a5
   10886:	3fff07b7          	lui	a5,0x3fff0
   1088a:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1088e:	97ba                	add	a5,a5,a4
   10890:	6398                	ld	a4,0(a5)
   10892:	fec42783          	lw	a5,-20(s0)
   10896:	0047979b          	slliw	a5,a5,0x4
   1089a:	2781                	sext.w	a5,a5
   1089c:	27a1                	addiw	a5,a5,8
   1089e:	2781                	sext.w	a5,a5
   108a0:	86be                	mv	a3,a5
   108a2:	3fff07b7          	lui	a5,0x3fff0
   108a6:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   108aa:	97b6                	add	a5,a5,a3
   108ac:	639c                	ld	a5,0(a5)
   108ae:	97ba                	add	a5,a5,a4
   108b0:	fc843703          	ld	a4,-56(s0)
   108b4:	06f77563          	bleu	a5,a4,1091e <__xbrtime_ltor+0x104>
   108b8:	fec42783          	lw	a5,-20(s0)
   108bc:	0047979b          	slliw	a5,a5,0x4
   108c0:	2781                	sext.w	a5,a5
   108c2:	873e                	mv	a4,a5
   108c4:	3fff07b7          	lui	a5,0x3fff0
   108c8:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   108cc:	97ba                	add	a5,a5,a4
   108ce:	fef43023          	sd	a5,-32(s0)
   108d2:	fec42783          	lw	a5,-20(s0)
   108d6:	0047979b          	slliw	a5,a5,0x4
   108da:	2781                	sext.w	a5,a5
   108dc:	873e                	mv	a4,a5
   108de:	3fff07b7          	lui	a5,0x3fff0
   108e2:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   108e6:	97ba                	add	a5,a5,a4
   108e8:	639c                	ld	a5,0(a5)
   108ea:	fc843703          	ld	a4,-56(s0)
   108ee:	40f707b3          	sub	a5,a4,a5
   108f2:	fcf43c23          	sd	a5,-40(s0)
   108f6:	fc442783          	lw	a5,-60(s0)
   108fa:	853e                	mv	a0,a5
   108fc:	297050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10900:	87aa                	mv	a5,a0
   10902:	85be                	mv	a1,a5
   10904:	fe043503          	ld	a0,-32(s0)
   10908:	652060ef          	jal	ra,16f5a <__xbrtime_get_remote_alloc>
   1090c:	872a                	mv	a4,a0
   1090e:	fd843783          	ld	a5,-40(s0)
   10912:	97ba                	add	a5,a5,a4
   10914:	fcf43823          	sd	a5,-48(s0)
   10918:	fd043783          	ld	a5,-48(s0)
   1091c:	a839                	j	1093a <__xbrtime_ltor+0x120>
   1091e:	fec42783          	lw	a5,-20(s0)
   10922:	2785                	addiw	a5,a5,1
   10924:	fef42623          	sw	a5,-20(s0)
   10928:	fec42783          	lw	a5,-20(s0)
   1092c:	0007871b          	sext.w	a4,a5
   10930:	7ff00793          	li	a5,2047
   10934:	f2e7d3e3          	ble	a4,a5,1085a <__xbrtime_ltor+0x40>
   10938:	4781                	li	a5,0
   1093a:	853e                	mv	a0,a5
   1093c:	70e2                	ld	ra,56(sp)
   1093e:	7442                	ld	s0,48(sp)
   10940:	6121                	addi	sp,sp,64
   10942:	8082                	ret
	...

0000000000010946 <xbrtime_float_put>:
   10946:	7139                	addi	sp,sp,-64
   10948:	fc06                	sd	ra,56(sp)
   1094a:	f822                	sd	s0,48(sp)
   1094c:	f426                	sd	s1,40(sp)
   1094e:	f04a                	sd	s2,32(sp)
   10950:	0080                	addi	s0,sp,64
   10952:	fca43c23          	sd	a0,-40(s0)
   10956:	fcb43823          	sd	a1,-48(s0)
   1095a:	fcc43423          	sd	a2,-56(s0)
   1095e:	87b6                	mv	a5,a3
   10960:	fcf42223          	sw	a5,-60(s0)
   10964:	87ba                	mv	a5,a4
   10966:	fcf42023          	sw	a5,-64(s0)
   1096a:	fc843783          	ld	a5,-56(s0)
   1096e:	c7cd                	beqz	a5,10a18 <xbrtime_float_put+0xd2>
   10970:	fc442783          	lw	a5,-60(s0)
   10974:	0007871b          	sext.w	a4,a5
   10978:	4785                	li	a5,1
   1097a:	00f71763          	bne	a4,a5,10988 <xbrtime_float_put+0x42>
   1097e:	fc843703          	ld	a4,-56(s0)
   10982:	4785                	li	a5,1
   10984:	04f71563          	bne	a4,a5,109ce <xbrtime_float_put+0x88>
   10988:	fd043483          	ld	s1,-48(s0)
   1098c:	fd843783          	ld	a5,-40(s0)
   10990:	fc042703          	lw	a4,-64(s0)
   10994:	85ba                	mv	a1,a4
   10996:	853e                	mv	a0,a5
   10998:	e83ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   1099c:	892a                	mv	s2,a0
   1099e:	fc042783          	lw	a5,-64(s0)
   109a2:	853e                	mv	a0,a5
   109a4:	1ef050ef          	jal	ra,16392 <xbrtime_decode_pe>
   109a8:	87aa                	mv	a5,a0
   109aa:	0007861b          	sext.w	a2,a5
   109ae:	fc843783          	ld	a5,-56(s0)
   109b2:	0007869b          	sext.w	a3,a5
   109b6:	fc442783          	lw	a5,-60(s0)
   109ba:	2781                	sext.w	a5,a5
   109bc:	0027979b          	slliw	a5,a5,0x2
   109c0:	2781                	sext.w	a5,a5
   109c2:	873e                	mv	a4,a5
   109c4:	85ca                	mv	a1,s2
   109c6:	8526                	mv	a0,s1
   109c8:	470060ef          	jal	ra,16e38 <__xbrtime_put_u4_seq>
   109cc:	a099                	j	10a12 <xbrtime_float_put+0xcc>
   109ce:	fd043483          	ld	s1,-48(s0)
   109d2:	fd843783          	ld	a5,-40(s0)
   109d6:	fc042703          	lw	a4,-64(s0)
   109da:	85ba                	mv	a1,a4
   109dc:	853e                	mv	a0,a5
   109de:	e3dff0ef          	jal	ra,1081a <__xbrtime_ltor>
   109e2:	892a                	mv	s2,a0
   109e4:	fc042783          	lw	a5,-64(s0)
   109e8:	853e                	mv	a0,a5
   109ea:	1a9050ef          	jal	ra,16392 <xbrtime_decode_pe>
   109ee:	87aa                	mv	a5,a0
   109f0:	0007861b          	sext.w	a2,a5
   109f4:	fc843783          	ld	a5,-56(s0)
   109f8:	0007869b          	sext.w	a3,a5
   109fc:	fc442783          	lw	a5,-60(s0)
   10a00:	2781                	sext.w	a5,a5
   10a02:	0027979b          	slliw	a5,a5,0x2
   10a06:	2781                	sext.w	a5,a5
   10a08:	873e                	mv	a4,a5
   10a0a:	85ca                	mv	a1,s2
   10a0c:	8526                	mv	a0,s1
   10a0e:	446060ef          	jal	ra,16e54 <__xbrtime_put_u4_agg>
   10a12:	53c060ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   10a16:	a011                	j	10a1a <xbrtime_float_put+0xd4>
   10a18:	0001                	nop
   10a1a:	70e2                	ld	ra,56(sp)
   10a1c:	7442                	ld	s0,48(sp)
   10a1e:	74a2                	ld	s1,40(sp)
   10a20:	7902                	ld	s2,32(sp)
   10a22:	6121                	addi	sp,sp,64
   10a24:	8082                	ret

0000000000010a26 <xbrtime_float_put_nb>:
   10a26:	7139                	addi	sp,sp,-64
   10a28:	fc06                	sd	ra,56(sp)
   10a2a:	f822                	sd	s0,48(sp)
   10a2c:	f426                	sd	s1,40(sp)
   10a2e:	f04a                	sd	s2,32(sp)
   10a30:	0080                	addi	s0,sp,64
   10a32:	fca43c23          	sd	a0,-40(s0)
   10a36:	fcb43823          	sd	a1,-48(s0)
   10a3a:	fcc43423          	sd	a2,-56(s0)
   10a3e:	87b6                	mv	a5,a3
   10a40:	fcf42223          	sw	a5,-60(s0)
   10a44:	87ba                	mv	a5,a4
   10a46:	fcf42023          	sw	a5,-64(s0)
   10a4a:	fc843783          	ld	a5,-56(s0)
   10a4e:	cfdd                	beqz	a5,10b0c <xbrtime_float_put_nb+0xe6>
   10a50:	fc442783          	lw	a5,-60(s0)
   10a54:	0007871b          	sext.w	a4,a5
   10a58:	4785                	li	a5,1
   10a5a:	00f71763          	bne	a4,a5,10a68 <xbrtime_float_put_nb+0x42>
   10a5e:	fc843703          	ld	a4,-56(s0)
   10a62:	4785                	li	a5,1
   10a64:	04f71b63          	bne	a4,a5,10aba <xbrtime_float_put_nb+0x94>
   10a68:	fd043483          	ld	s1,-48(s0)
   10a6c:	fd843783          	ld	a5,-40(s0)
   10a70:	fc042703          	lw	a4,-64(s0)
   10a74:	85ba                	mv	a1,a4
   10a76:	853e                	mv	a0,a5
   10a78:	00000097          	auipc	ra,0x0
   10a7c:	da2080e7          	jalr	-606(ra) # 1081a <__xbrtime_ltor>
   10a80:	892a                	mv	s2,a0
   10a82:	fc042783          	lw	a5,-64(s0)
   10a86:	853e                	mv	a0,a5
   10a88:	00006097          	auipc	ra,0x6
   10a8c:	90a080e7          	jalr	-1782(ra) # 16392 <xbrtime_decode_pe>
   10a90:	87aa                	mv	a5,a0
   10a92:	0007861b          	sext.w	a2,a5
   10a96:	fc843783          	ld	a5,-56(s0)
   10a9a:	0007869b          	sext.w	a3,a5
   10a9e:	fc442783          	lw	a5,-60(s0)
   10aa2:	2781                	sext.w	a5,a5
   10aa4:	0027979b          	slliw	a5,a5,0x2
   10aa8:	2781                	sext.w	a5,a5
   10aaa:	873e                	mv	a4,a5
   10aac:	85ca                	mv	a1,s2
   10aae:	8526                	mv	a0,s1
   10ab0:	00006097          	auipc	ra,0x6
   10ab4:	388080e7          	jalr	904(ra) # 16e38 <__xbrtime_put_u4_seq>
   10ab8:	a899                	j	10b0e <xbrtime_float_put_nb+0xe8>
   10aba:	fd043483          	ld	s1,-48(s0)
   10abe:	fd843783          	ld	a5,-40(s0)
   10ac2:	fc042703          	lw	a4,-64(s0)
   10ac6:	85ba                	mv	a1,a4
   10ac8:	853e                	mv	a0,a5
   10aca:	00000097          	auipc	ra,0x0
   10ace:	d50080e7          	jalr	-688(ra) # 1081a <__xbrtime_ltor>
   10ad2:	892a                	mv	s2,a0
   10ad4:	fc042783          	lw	a5,-64(s0)
   10ad8:	853e                	mv	a0,a5
   10ada:	00006097          	auipc	ra,0x6
   10ade:	8b8080e7          	jalr	-1864(ra) # 16392 <xbrtime_decode_pe>
   10ae2:	87aa                	mv	a5,a0
   10ae4:	0007861b          	sext.w	a2,a5
   10ae8:	fc843783          	ld	a5,-56(s0)
   10aec:	0007869b          	sext.w	a3,a5
   10af0:	fc442783          	lw	a5,-60(s0)
   10af4:	2781                	sext.w	a5,a5
   10af6:	0027979b          	slliw	a5,a5,0x2
   10afa:	2781                	sext.w	a5,a5
   10afc:	873e                	mv	a4,a5
   10afe:	85ca                	mv	a1,s2
   10b00:	8526                	mv	a0,s1
   10b02:	00006097          	auipc	ra,0x6
   10b06:	352080e7          	jalr	850(ra) # 16e54 <__xbrtime_put_u4_agg>
   10b0a:	a011                	j	10b0e <xbrtime_float_put_nb+0xe8>
   10b0c:	0001                	nop
   10b0e:	70e2                	ld	ra,56(sp)
   10b10:	7442                	ld	s0,48(sp)
   10b12:	74a2                	ld	s1,40(sp)
   10b14:	7902                	ld	s2,32(sp)
   10b16:	6121                	addi	sp,sp,64
   10b18:	8082                	ret

0000000000010b1a <xbrtime_double_put>:
   10b1a:	7139                	addi	sp,sp,-64
   10b1c:	fc06                	sd	ra,56(sp)
   10b1e:	f822                	sd	s0,48(sp)
   10b20:	f426                	sd	s1,40(sp)
   10b22:	f04a                	sd	s2,32(sp)
   10b24:	0080                	addi	s0,sp,64
   10b26:	fca43c23          	sd	a0,-40(s0)
   10b2a:	fcb43823          	sd	a1,-48(s0)
   10b2e:	fcc43423          	sd	a2,-56(s0)
   10b32:	87b6                	mv	a5,a3
   10b34:	fcf42223          	sw	a5,-60(s0)
   10b38:	87ba                	mv	a5,a4
   10b3a:	fcf42023          	sw	a5,-64(s0)
   10b3e:	fc843783          	ld	a5,-56(s0)
   10b42:	c7cd                	beqz	a5,10bec <xbrtime_double_put+0xd2>
   10b44:	fc442783          	lw	a5,-60(s0)
   10b48:	0007871b          	sext.w	a4,a5
   10b4c:	4785                	li	a5,1
   10b4e:	00f71763          	bne	a4,a5,10b5c <xbrtime_double_put+0x42>
   10b52:	fc843703          	ld	a4,-56(s0)
   10b56:	4785                	li	a5,1
   10b58:	04f71563          	bne	a4,a5,10ba2 <xbrtime_double_put+0x88>
   10b5c:	fd043483          	ld	s1,-48(s0)
   10b60:	fd843783          	ld	a5,-40(s0)
   10b64:	fc042703          	lw	a4,-64(s0)
   10b68:	85ba                	mv	a1,a4
   10b6a:	853e                	mv	a0,a5
   10b6c:	cafff0ef          	jal	ra,1081a <__xbrtime_ltor>
   10b70:	892a                	mv	s2,a0
   10b72:	fc042783          	lw	a5,-64(s0)
   10b76:	853e                	mv	a0,a5
   10b78:	01b050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10b7c:	87aa                	mv	a5,a0
   10b7e:	0007861b          	sext.w	a2,a5
   10b82:	fc843783          	ld	a5,-56(s0)
   10b86:	0007869b          	sext.w	a3,a5
   10b8a:	fc442783          	lw	a5,-60(s0)
   10b8e:	2781                	sext.w	a5,a5
   10b90:	0037979b          	slliw	a5,a5,0x3
   10b94:	2781                	sext.w	a5,a5
   10b96:	873e                	mv	a4,a5
   10b98:	85ca                	mv	a1,s2
   10b9a:	8526                	mv	a0,s1
   10b9c:	2c6060ef          	jal	ra,16e62 <__xbrtime_put_u8_seq>
   10ba0:	a099                	j	10be6 <xbrtime_double_put+0xcc>
   10ba2:	fd043483          	ld	s1,-48(s0)
   10ba6:	fd843783          	ld	a5,-40(s0)
   10baa:	fc042703          	lw	a4,-64(s0)
   10bae:	85ba                	mv	a1,a4
   10bb0:	853e                	mv	a0,a5
   10bb2:	c69ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   10bb6:	892a                	mv	s2,a0
   10bb8:	fc042783          	lw	a5,-64(s0)
   10bbc:	853e                	mv	a0,a5
   10bbe:	7d4050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10bc2:	87aa                	mv	a5,a0
   10bc4:	0007861b          	sext.w	a2,a5
   10bc8:	fc843783          	ld	a5,-56(s0)
   10bcc:	0007869b          	sext.w	a3,a5
   10bd0:	fc442783          	lw	a5,-60(s0)
   10bd4:	2781                	sext.w	a5,a5
   10bd6:	0037979b          	slliw	a5,a5,0x3
   10bda:	2781                	sext.w	a5,a5
   10bdc:	873e                	mv	a4,a5
   10bde:	85ca                	mv	a1,s2
   10be0:	8526                	mv	a0,s1
   10be2:	29c060ef          	jal	ra,16e7e <__xbrtime_put_u8_agg>
   10be6:	368060ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   10bea:	a011                	j	10bee <xbrtime_double_put+0xd4>
   10bec:	0001                	nop
   10bee:	70e2                	ld	ra,56(sp)
   10bf0:	7442                	ld	s0,48(sp)
   10bf2:	74a2                	ld	s1,40(sp)
   10bf4:	7902                	ld	s2,32(sp)
   10bf6:	6121                	addi	sp,sp,64
   10bf8:	8082                	ret

0000000000010bfa <xbrtime_double_put_nb>:
   10bfa:	7139                	addi	sp,sp,-64
   10bfc:	fc06                	sd	ra,56(sp)
   10bfe:	f822                	sd	s0,48(sp)
   10c00:	f426                	sd	s1,40(sp)
   10c02:	f04a                	sd	s2,32(sp)
   10c04:	0080                	addi	s0,sp,64
   10c06:	fca43c23          	sd	a0,-40(s0)
   10c0a:	fcb43823          	sd	a1,-48(s0)
   10c0e:	fcc43423          	sd	a2,-56(s0)
   10c12:	87b6                	mv	a5,a3
   10c14:	fcf42223          	sw	a5,-60(s0)
   10c18:	87ba                	mv	a5,a4
   10c1a:	fcf42023          	sw	a5,-64(s0)
   10c1e:	fc843783          	ld	a5,-56(s0)
   10c22:	cfdd                	beqz	a5,10ce0 <xbrtime_double_put_nb+0xe6>
   10c24:	fc442783          	lw	a5,-60(s0)
   10c28:	0007871b          	sext.w	a4,a5
   10c2c:	4785                	li	a5,1
   10c2e:	00f71763          	bne	a4,a5,10c3c <xbrtime_double_put_nb+0x42>
   10c32:	fc843703          	ld	a4,-56(s0)
   10c36:	4785                	li	a5,1
   10c38:	04f71b63          	bne	a4,a5,10c8e <xbrtime_double_put_nb+0x94>
   10c3c:	fd043483          	ld	s1,-48(s0)
   10c40:	fd843783          	ld	a5,-40(s0)
   10c44:	fc042703          	lw	a4,-64(s0)
   10c48:	85ba                	mv	a1,a4
   10c4a:	853e                	mv	a0,a5
   10c4c:	00000097          	auipc	ra,0x0
   10c50:	bce080e7          	jalr	-1074(ra) # 1081a <__xbrtime_ltor>
   10c54:	892a                	mv	s2,a0
   10c56:	fc042783          	lw	a5,-64(s0)
   10c5a:	853e                	mv	a0,a5
   10c5c:	00005097          	auipc	ra,0x5
   10c60:	736080e7          	jalr	1846(ra) # 16392 <xbrtime_decode_pe>
   10c64:	87aa                	mv	a5,a0
   10c66:	0007861b          	sext.w	a2,a5
   10c6a:	fc843783          	ld	a5,-56(s0)
   10c6e:	0007869b          	sext.w	a3,a5
   10c72:	fc442783          	lw	a5,-60(s0)
   10c76:	2781                	sext.w	a5,a5
   10c78:	0037979b          	slliw	a5,a5,0x3
   10c7c:	2781                	sext.w	a5,a5
   10c7e:	873e                	mv	a4,a5
   10c80:	85ca                	mv	a1,s2
   10c82:	8526                	mv	a0,s1
   10c84:	00006097          	auipc	ra,0x6
   10c88:	1de080e7          	jalr	478(ra) # 16e62 <__xbrtime_put_u8_seq>
   10c8c:	a899                	j	10ce2 <xbrtime_double_put_nb+0xe8>
   10c8e:	fd043483          	ld	s1,-48(s0)
   10c92:	fd843783          	ld	a5,-40(s0)
   10c96:	fc042703          	lw	a4,-64(s0)
   10c9a:	85ba                	mv	a1,a4
   10c9c:	853e                	mv	a0,a5
   10c9e:	00000097          	auipc	ra,0x0
   10ca2:	b7c080e7          	jalr	-1156(ra) # 1081a <__xbrtime_ltor>
   10ca6:	892a                	mv	s2,a0
   10ca8:	fc042783          	lw	a5,-64(s0)
   10cac:	853e                	mv	a0,a5
   10cae:	00005097          	auipc	ra,0x5
   10cb2:	6e4080e7          	jalr	1764(ra) # 16392 <xbrtime_decode_pe>
   10cb6:	87aa                	mv	a5,a0
   10cb8:	0007861b          	sext.w	a2,a5
   10cbc:	fc843783          	ld	a5,-56(s0)
   10cc0:	0007869b          	sext.w	a3,a5
   10cc4:	fc442783          	lw	a5,-60(s0)
   10cc8:	2781                	sext.w	a5,a5
   10cca:	0037979b          	slliw	a5,a5,0x3
   10cce:	2781                	sext.w	a5,a5
   10cd0:	873e                	mv	a4,a5
   10cd2:	85ca                	mv	a1,s2
   10cd4:	8526                	mv	a0,s1
   10cd6:	00006097          	auipc	ra,0x6
   10cda:	1a8080e7          	jalr	424(ra) # 16e7e <__xbrtime_put_u8_agg>
   10cde:	a011                	j	10ce2 <xbrtime_double_put_nb+0xe8>
   10ce0:	0001                	nop
   10ce2:	70e2                	ld	ra,56(sp)
   10ce4:	7442                	ld	s0,48(sp)
   10ce6:	74a2                	ld	s1,40(sp)
   10ce8:	7902                	ld	s2,32(sp)
   10cea:	6121                	addi	sp,sp,64
   10cec:	8082                	ret

0000000000010cee <xbrtime_longdouble_put>:
   10cee:	7139                	addi	sp,sp,-64
   10cf0:	fc06                	sd	ra,56(sp)
   10cf2:	f822                	sd	s0,48(sp)
   10cf4:	f426                	sd	s1,40(sp)
   10cf6:	f04a                	sd	s2,32(sp)
   10cf8:	0080                	addi	s0,sp,64
   10cfa:	fca43c23          	sd	a0,-40(s0)
   10cfe:	fcb43823          	sd	a1,-48(s0)
   10d02:	fcc43423          	sd	a2,-56(s0)
   10d06:	87b6                	mv	a5,a3
   10d08:	fcf42223          	sw	a5,-60(s0)
   10d0c:	87ba                	mv	a5,a4
   10d0e:	fcf42023          	sw	a5,-64(s0)
   10d12:	fc843783          	ld	a5,-56(s0)
   10d16:	c7cd                	beqz	a5,10dc0 <xbrtime_longdouble_put+0xd2>
   10d18:	fc442783          	lw	a5,-60(s0)
   10d1c:	0007871b          	sext.w	a4,a5
   10d20:	4785                	li	a5,1
   10d22:	00f71763          	bne	a4,a5,10d30 <xbrtime_longdouble_put+0x42>
   10d26:	fc843703          	ld	a4,-56(s0)
   10d2a:	4785                	li	a5,1
   10d2c:	04f71563          	bne	a4,a5,10d76 <xbrtime_longdouble_put+0x88>
   10d30:	fd043483          	ld	s1,-48(s0)
   10d34:	fd843783          	ld	a5,-40(s0)
   10d38:	fc042703          	lw	a4,-64(s0)
   10d3c:	85ba                	mv	a1,a4
   10d3e:	853e                	mv	a0,a5
   10d40:	adbff0ef          	jal	ra,1081a <__xbrtime_ltor>
   10d44:	892a                	mv	s2,a0
   10d46:	fc042783          	lw	a5,-64(s0)
   10d4a:	853e                	mv	a0,a5
   10d4c:	646050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10d50:	87aa                	mv	a5,a0
   10d52:	0007861b          	sext.w	a2,a5
   10d56:	fc843783          	ld	a5,-56(s0)
   10d5a:	0007869b          	sext.w	a3,a5
   10d5e:	fc442783          	lw	a5,-60(s0)
   10d62:	2781                	sext.w	a5,a5
   10d64:	0047979b          	slliw	a5,a5,0x4
   10d68:	2781                	sext.w	a5,a5
   10d6a:	873e                	mv	a4,a5
   10d6c:	85ca                	mv	a1,s2
   10d6e:	8526                	mv	a0,s1
   10d70:	0f2060ef          	jal	ra,16e62 <__xbrtime_put_u8_seq>
   10d74:	a099                	j	10dba <xbrtime_longdouble_put+0xcc>
   10d76:	fd043483          	ld	s1,-48(s0)
   10d7a:	fd843783          	ld	a5,-40(s0)
   10d7e:	fc042703          	lw	a4,-64(s0)
   10d82:	85ba                	mv	a1,a4
   10d84:	853e                	mv	a0,a5
   10d86:	a95ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   10d8a:	892a                	mv	s2,a0
   10d8c:	fc042783          	lw	a5,-64(s0)
   10d90:	853e                	mv	a0,a5
   10d92:	600050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10d96:	87aa                	mv	a5,a0
   10d98:	0007861b          	sext.w	a2,a5
   10d9c:	fc843783          	ld	a5,-56(s0)
   10da0:	0007869b          	sext.w	a3,a5
   10da4:	fc442783          	lw	a5,-60(s0)
   10da8:	2781                	sext.w	a5,a5
   10daa:	0047979b          	slliw	a5,a5,0x4
   10dae:	2781                	sext.w	a5,a5
   10db0:	873e                	mv	a4,a5
   10db2:	85ca                	mv	a1,s2
   10db4:	8526                	mv	a0,s1
   10db6:	0c8060ef          	jal	ra,16e7e <__xbrtime_put_u8_agg>
   10dba:	194060ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   10dbe:	a011                	j	10dc2 <xbrtime_longdouble_put+0xd4>
   10dc0:	0001                	nop
   10dc2:	70e2                	ld	ra,56(sp)
   10dc4:	7442                	ld	s0,48(sp)
   10dc6:	74a2                	ld	s1,40(sp)
   10dc8:	7902                	ld	s2,32(sp)
   10dca:	6121                	addi	sp,sp,64
   10dcc:	8082                	ret

0000000000010dce <xbrtime_longdouble_put_nb>:
   10dce:	7139                	addi	sp,sp,-64
   10dd0:	fc06                	sd	ra,56(sp)
   10dd2:	f822                	sd	s0,48(sp)
   10dd4:	f426                	sd	s1,40(sp)
   10dd6:	f04a                	sd	s2,32(sp)
   10dd8:	0080                	addi	s0,sp,64
   10dda:	fca43c23          	sd	a0,-40(s0)
   10dde:	fcb43823          	sd	a1,-48(s0)
   10de2:	fcc43423          	sd	a2,-56(s0)
   10de6:	87b6                	mv	a5,a3
   10de8:	fcf42223          	sw	a5,-60(s0)
   10dec:	87ba                	mv	a5,a4
   10dee:	fcf42023          	sw	a5,-64(s0)
   10df2:	fc843783          	ld	a5,-56(s0)
   10df6:	cfdd                	beqz	a5,10eb4 <xbrtime_longdouble_put_nb+0xe6>
   10df8:	fc442783          	lw	a5,-60(s0)
   10dfc:	0007871b          	sext.w	a4,a5
   10e00:	4785                	li	a5,1
   10e02:	00f71763          	bne	a4,a5,10e10 <xbrtime_longdouble_put_nb+0x42>
   10e06:	fc843703          	ld	a4,-56(s0)
   10e0a:	4785                	li	a5,1
   10e0c:	04f71b63          	bne	a4,a5,10e62 <xbrtime_longdouble_put_nb+0x94>
   10e10:	fd043483          	ld	s1,-48(s0)
   10e14:	fd843783          	ld	a5,-40(s0)
   10e18:	fc042703          	lw	a4,-64(s0)
   10e1c:	85ba                	mv	a1,a4
   10e1e:	853e                	mv	a0,a5
   10e20:	00000097          	auipc	ra,0x0
   10e24:	9fa080e7          	jalr	-1542(ra) # 1081a <__xbrtime_ltor>
   10e28:	892a                	mv	s2,a0
   10e2a:	fc042783          	lw	a5,-64(s0)
   10e2e:	853e                	mv	a0,a5
   10e30:	00005097          	auipc	ra,0x5
   10e34:	562080e7          	jalr	1378(ra) # 16392 <xbrtime_decode_pe>
   10e38:	87aa                	mv	a5,a0
   10e3a:	0007861b          	sext.w	a2,a5
   10e3e:	fc843783          	ld	a5,-56(s0)
   10e42:	0007869b          	sext.w	a3,a5
   10e46:	fc442783          	lw	a5,-60(s0)
   10e4a:	2781                	sext.w	a5,a5
   10e4c:	0047979b          	slliw	a5,a5,0x4
   10e50:	2781                	sext.w	a5,a5
   10e52:	873e                	mv	a4,a5
   10e54:	85ca                	mv	a1,s2
   10e56:	8526                	mv	a0,s1
   10e58:	00006097          	auipc	ra,0x6
   10e5c:	00a080e7          	jalr	10(ra) # 16e62 <__xbrtime_put_u8_seq>
   10e60:	a899                	j	10eb6 <xbrtime_longdouble_put_nb+0xe8>
   10e62:	fd043483          	ld	s1,-48(s0)
   10e66:	fd843783          	ld	a5,-40(s0)
   10e6a:	fc042703          	lw	a4,-64(s0)
   10e6e:	85ba                	mv	a1,a4
   10e70:	853e                	mv	a0,a5
   10e72:	00000097          	auipc	ra,0x0
   10e76:	9a8080e7          	jalr	-1624(ra) # 1081a <__xbrtime_ltor>
   10e7a:	892a                	mv	s2,a0
   10e7c:	fc042783          	lw	a5,-64(s0)
   10e80:	853e                	mv	a0,a5
   10e82:	00005097          	auipc	ra,0x5
   10e86:	510080e7          	jalr	1296(ra) # 16392 <xbrtime_decode_pe>
   10e8a:	87aa                	mv	a5,a0
   10e8c:	0007861b          	sext.w	a2,a5
   10e90:	fc843783          	ld	a5,-56(s0)
   10e94:	0007869b          	sext.w	a3,a5
   10e98:	fc442783          	lw	a5,-60(s0)
   10e9c:	2781                	sext.w	a5,a5
   10e9e:	0047979b          	slliw	a5,a5,0x4
   10ea2:	2781                	sext.w	a5,a5
   10ea4:	873e                	mv	a4,a5
   10ea6:	85ca                	mv	a1,s2
   10ea8:	8526                	mv	a0,s1
   10eaa:	00006097          	auipc	ra,0x6
   10eae:	fd4080e7          	jalr	-44(ra) # 16e7e <__xbrtime_put_u8_agg>
   10eb2:	a011                	j	10eb6 <xbrtime_longdouble_put_nb+0xe8>
   10eb4:	0001                	nop
   10eb6:	70e2                	ld	ra,56(sp)
   10eb8:	7442                	ld	s0,48(sp)
   10eba:	74a2                	ld	s1,40(sp)
   10ebc:	7902                	ld	s2,32(sp)
   10ebe:	6121                	addi	sp,sp,64
   10ec0:	8082                	ret

0000000000010ec2 <xbrtime_schar_put>:
   10ec2:	7139                	addi	sp,sp,-64
   10ec4:	fc06                	sd	ra,56(sp)
   10ec6:	f822                	sd	s0,48(sp)
   10ec8:	f426                	sd	s1,40(sp)
   10eca:	f04a                	sd	s2,32(sp)
   10ecc:	0080                	addi	s0,sp,64
   10ece:	fca43c23          	sd	a0,-40(s0)
   10ed2:	fcb43823          	sd	a1,-48(s0)
   10ed6:	fcc43423          	sd	a2,-56(s0)
   10eda:	87b6                	mv	a5,a3
   10edc:	fcf42223          	sw	a5,-60(s0)
   10ee0:	87ba                	mv	a5,a4
   10ee2:	fcf42023          	sw	a5,-64(s0)
   10ee6:	fc843783          	ld	a5,-56(s0)
   10eea:	cfc9                	beqz	a5,10f84 <xbrtime_schar_put+0xc2>
   10eec:	fc442783          	lw	a5,-60(s0)
   10ef0:	0007871b          	sext.w	a4,a5
   10ef4:	4785                	li	a5,1
   10ef6:	00f71763          	bne	a4,a5,10f04 <xbrtime_schar_put+0x42>
   10efa:	fc843703          	ld	a4,-56(s0)
   10efe:	4785                	li	a5,1
   10f00:	04f71163          	bne	a4,a5,10f42 <xbrtime_schar_put+0x80>
   10f04:	fd043483          	ld	s1,-48(s0)
   10f08:	fd843783          	ld	a5,-40(s0)
   10f0c:	fc042703          	lw	a4,-64(s0)
   10f10:	85ba                	mv	a1,a4
   10f12:	853e                	mv	a0,a5
   10f14:	907ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   10f18:	892a                	mv	s2,a0
   10f1a:	fc042783          	lw	a5,-64(s0)
   10f1e:	853e                	mv	a0,a5
   10f20:	472050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10f24:	87aa                	mv	a5,a0
   10f26:	2781                	sext.w	a5,a5
   10f28:	fc843703          	ld	a4,-56(s0)
   10f2c:	0007069b          	sext.w	a3,a4
   10f30:	fc442703          	lw	a4,-60(s0)
   10f34:	2701                	sext.w	a4,a4
   10f36:	863e                	mv	a2,a5
   10f38:	85ca                	mv	a1,s2
   10f3a:	8526                	mv	a0,s1
   10f3c:	751050ef          	jal	ra,16e8c <__xbrtime_put_s1_seq>
   10f40:	a83d                	j	10f7e <xbrtime_schar_put+0xbc>
   10f42:	fd043483          	ld	s1,-48(s0)
   10f46:	fd843783          	ld	a5,-40(s0)
   10f4a:	fc042703          	lw	a4,-64(s0)
   10f4e:	85ba                	mv	a1,a4
   10f50:	853e                	mv	a0,a5
   10f52:	8c9ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   10f56:	892a                	mv	s2,a0
   10f58:	fc042783          	lw	a5,-64(s0)
   10f5c:	853e                	mv	a0,a5
   10f5e:	434050ef          	jal	ra,16392 <xbrtime_decode_pe>
   10f62:	87aa                	mv	a5,a0
   10f64:	2781                	sext.w	a5,a5
   10f66:	fc843703          	ld	a4,-56(s0)
   10f6a:	0007069b          	sext.w	a3,a4
   10f6e:	fc442703          	lw	a4,-60(s0)
   10f72:	2701                	sext.w	a4,a4
   10f74:	863e                	mv	a2,a5
   10f76:	85ca                	mv	a1,s2
   10f78:	8526                	mv	a0,s1
   10f7a:	72f050ef          	jal	ra,16ea8 <__xbrtime_put_s1_agg>
   10f7e:	7d1050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   10f82:	a011                	j	10f86 <xbrtime_schar_put+0xc4>
   10f84:	0001                	nop
   10f86:	70e2                	ld	ra,56(sp)
   10f88:	7442                	ld	s0,48(sp)
   10f8a:	74a2                	ld	s1,40(sp)
   10f8c:	7902                	ld	s2,32(sp)
   10f8e:	6121                	addi	sp,sp,64
   10f90:	8082                	ret

0000000000010f92 <xbrtime_schar_put_nb>:
   10f92:	7139                	addi	sp,sp,-64
   10f94:	fc06                	sd	ra,56(sp)
   10f96:	f822                	sd	s0,48(sp)
   10f98:	f426                	sd	s1,40(sp)
   10f9a:	f04a                	sd	s2,32(sp)
   10f9c:	0080                	addi	s0,sp,64
   10f9e:	fca43c23          	sd	a0,-40(s0)
   10fa2:	fcb43823          	sd	a1,-48(s0)
   10fa6:	fcc43423          	sd	a2,-56(s0)
   10faa:	87b6                	mv	a5,a3
   10fac:	fcf42223          	sw	a5,-60(s0)
   10fb0:	87ba                	mv	a5,a4
   10fb2:	fcf42023          	sw	a5,-64(s0)
   10fb6:	fc843783          	ld	a5,-56(s0)
   10fba:	c7dd                	beqz	a5,11068 <xbrtime_schar_put_nb+0xd6>
   10fbc:	fc442783          	lw	a5,-60(s0)
   10fc0:	0007871b          	sext.w	a4,a5
   10fc4:	4785                	li	a5,1
   10fc6:	00f71763          	bne	a4,a5,10fd4 <xbrtime_schar_put_nb+0x42>
   10fca:	fc843703          	ld	a4,-56(s0)
   10fce:	4785                	li	a5,1
   10fd0:	04f71763          	bne	a4,a5,1101e <xbrtime_schar_put_nb+0x8c>
   10fd4:	fd043483          	ld	s1,-48(s0)
   10fd8:	fd843783          	ld	a5,-40(s0)
   10fdc:	fc042703          	lw	a4,-64(s0)
   10fe0:	85ba                	mv	a1,a4
   10fe2:	853e                	mv	a0,a5
   10fe4:	00000097          	auipc	ra,0x0
   10fe8:	836080e7          	jalr	-1994(ra) # 1081a <__xbrtime_ltor>
   10fec:	892a                	mv	s2,a0
   10fee:	fc042783          	lw	a5,-64(s0)
   10ff2:	853e                	mv	a0,a5
   10ff4:	00005097          	auipc	ra,0x5
   10ff8:	39e080e7          	jalr	926(ra) # 16392 <xbrtime_decode_pe>
   10ffc:	87aa                	mv	a5,a0
   10ffe:	2781                	sext.w	a5,a5
   11000:	fc843703          	ld	a4,-56(s0)
   11004:	0007069b          	sext.w	a3,a4
   11008:	fc442703          	lw	a4,-60(s0)
   1100c:	2701                	sext.w	a4,a4
   1100e:	863e                	mv	a2,a5
   11010:	85ca                	mv	a1,s2
   11012:	8526                	mv	a0,s1
   11014:	00006097          	auipc	ra,0x6
   11018:	e78080e7          	jalr	-392(ra) # 16e8c <__xbrtime_put_s1_seq>
   1101c:	a0b9                	j	1106a <xbrtime_schar_put_nb+0xd8>
   1101e:	fd043483          	ld	s1,-48(s0)
   11022:	fd843783          	ld	a5,-40(s0)
   11026:	fc042703          	lw	a4,-64(s0)
   1102a:	85ba                	mv	a1,a4
   1102c:	853e                	mv	a0,a5
   1102e:	fffff097          	auipc	ra,0xfffff
   11032:	7ec080e7          	jalr	2028(ra) # 1081a <__xbrtime_ltor>
   11036:	892a                	mv	s2,a0
   11038:	fc042783          	lw	a5,-64(s0)
   1103c:	853e                	mv	a0,a5
   1103e:	00005097          	auipc	ra,0x5
   11042:	354080e7          	jalr	852(ra) # 16392 <xbrtime_decode_pe>
   11046:	87aa                	mv	a5,a0
   11048:	2781                	sext.w	a5,a5
   1104a:	fc843703          	ld	a4,-56(s0)
   1104e:	0007069b          	sext.w	a3,a4
   11052:	fc442703          	lw	a4,-60(s0)
   11056:	2701                	sext.w	a4,a4
   11058:	863e                	mv	a2,a5
   1105a:	85ca                	mv	a1,s2
   1105c:	8526                	mv	a0,s1
   1105e:	00006097          	auipc	ra,0x6
   11062:	e4a080e7          	jalr	-438(ra) # 16ea8 <__xbrtime_put_s1_agg>
   11066:	a011                	j	1106a <xbrtime_schar_put_nb+0xd8>
   11068:	0001                	nop
   1106a:	70e2                	ld	ra,56(sp)
   1106c:	7442                	ld	s0,48(sp)
   1106e:	74a2                	ld	s1,40(sp)
   11070:	7902                	ld	s2,32(sp)
   11072:	6121                	addi	sp,sp,64
   11074:	8082                	ret

0000000000011076 <xbrtime_char_put>:
   11076:	7139                	addi	sp,sp,-64
   11078:	fc06                	sd	ra,56(sp)
   1107a:	f822                	sd	s0,48(sp)
   1107c:	f426                	sd	s1,40(sp)
   1107e:	f04a                	sd	s2,32(sp)
   11080:	0080                	addi	s0,sp,64
   11082:	fca43c23          	sd	a0,-40(s0)
   11086:	fcb43823          	sd	a1,-48(s0)
   1108a:	fcc43423          	sd	a2,-56(s0)
   1108e:	87b6                	mv	a5,a3
   11090:	fcf42223          	sw	a5,-60(s0)
   11094:	87ba                	mv	a5,a4
   11096:	fcf42023          	sw	a5,-64(s0)
   1109a:	fc843783          	ld	a5,-56(s0)
   1109e:	cfc9                	beqz	a5,11138 <xbrtime_char_put+0xc2>
   110a0:	fc442783          	lw	a5,-60(s0)
   110a4:	0007871b          	sext.w	a4,a5
   110a8:	4785                	li	a5,1
   110aa:	00f71763          	bne	a4,a5,110b8 <xbrtime_char_put+0x42>
   110ae:	fc843703          	ld	a4,-56(s0)
   110b2:	4785                	li	a5,1
   110b4:	04f71163          	bne	a4,a5,110f6 <xbrtime_char_put+0x80>
   110b8:	fd043483          	ld	s1,-48(s0)
   110bc:	fd843783          	ld	a5,-40(s0)
   110c0:	fc042703          	lw	a4,-64(s0)
   110c4:	85ba                	mv	a1,a4
   110c6:	853e                	mv	a0,a5
   110c8:	f52ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   110cc:	892a                	mv	s2,a0
   110ce:	fc042783          	lw	a5,-64(s0)
   110d2:	853e                	mv	a0,a5
   110d4:	2be050ef          	jal	ra,16392 <xbrtime_decode_pe>
   110d8:	87aa                	mv	a5,a0
   110da:	2781                	sext.w	a5,a5
   110dc:	fc843703          	ld	a4,-56(s0)
   110e0:	0007069b          	sext.w	a3,a4
   110e4:	fc442703          	lw	a4,-60(s0)
   110e8:	2701                	sext.w	a4,a4
   110ea:	863e                	mv	a2,a5
   110ec:	85ca                	mv	a1,s2
   110ee:	8526                	mv	a0,s1
   110f0:	4f5050ef          	jal	ra,16de4 <__xbrtime_put_u1_seq>
   110f4:	a83d                	j	11132 <xbrtime_char_put+0xbc>
   110f6:	fd043483          	ld	s1,-48(s0)
   110fa:	fd843783          	ld	a5,-40(s0)
   110fe:	fc042703          	lw	a4,-64(s0)
   11102:	85ba                	mv	a1,a4
   11104:	853e                	mv	a0,a5
   11106:	f14ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   1110a:	892a                	mv	s2,a0
   1110c:	fc042783          	lw	a5,-64(s0)
   11110:	853e                	mv	a0,a5
   11112:	280050ef          	jal	ra,16392 <xbrtime_decode_pe>
   11116:	87aa                	mv	a5,a0
   11118:	2781                	sext.w	a5,a5
   1111a:	fc843703          	ld	a4,-56(s0)
   1111e:	0007069b          	sext.w	a3,a4
   11122:	fc442703          	lw	a4,-60(s0)
   11126:	2701                	sext.w	a4,a4
   11128:	863e                	mv	a2,a5
   1112a:	85ca                	mv	a1,s2
   1112c:	8526                	mv	a0,s1
   1112e:	4d3050ef          	jal	ra,16e00 <__xbrtime_put_u1_agg>
   11132:	61d050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   11136:	a011                	j	1113a <xbrtime_char_put+0xc4>
   11138:	0001                	nop
   1113a:	70e2                	ld	ra,56(sp)
   1113c:	7442                	ld	s0,48(sp)
   1113e:	74a2                	ld	s1,40(sp)
   11140:	7902                	ld	s2,32(sp)
   11142:	6121                	addi	sp,sp,64
   11144:	8082                	ret

0000000000011146 <xbrtime_char_put_nb>:
   11146:	7139                	addi	sp,sp,-64
   11148:	fc06                	sd	ra,56(sp)
   1114a:	f822                	sd	s0,48(sp)
   1114c:	f426                	sd	s1,40(sp)
   1114e:	f04a                	sd	s2,32(sp)
   11150:	0080                	addi	s0,sp,64
   11152:	fca43c23          	sd	a0,-40(s0)
   11156:	fcb43823          	sd	a1,-48(s0)
   1115a:	fcc43423          	sd	a2,-56(s0)
   1115e:	87b6                	mv	a5,a3
   11160:	fcf42223          	sw	a5,-60(s0)
   11164:	87ba                	mv	a5,a4
   11166:	fcf42023          	sw	a5,-64(s0)
   1116a:	fc843783          	ld	a5,-56(s0)
   1116e:	c7dd                	beqz	a5,1121c <xbrtime_char_put_nb+0xd6>
   11170:	fc442783          	lw	a5,-60(s0)
   11174:	0007871b          	sext.w	a4,a5
   11178:	4785                	li	a5,1
   1117a:	00f71763          	bne	a4,a5,11188 <xbrtime_char_put_nb+0x42>
   1117e:	fc843703          	ld	a4,-56(s0)
   11182:	4785                	li	a5,1
   11184:	04f71763          	bne	a4,a5,111d2 <xbrtime_char_put_nb+0x8c>
   11188:	fd043483          	ld	s1,-48(s0)
   1118c:	fd843783          	ld	a5,-40(s0)
   11190:	fc042703          	lw	a4,-64(s0)
   11194:	85ba                	mv	a1,a4
   11196:	853e                	mv	a0,a5
   11198:	fffff097          	auipc	ra,0xfffff
   1119c:	682080e7          	jalr	1666(ra) # 1081a <__xbrtime_ltor>
   111a0:	892a                	mv	s2,a0
   111a2:	fc042783          	lw	a5,-64(s0)
   111a6:	853e                	mv	a0,a5
   111a8:	00005097          	auipc	ra,0x5
   111ac:	1ea080e7          	jalr	490(ra) # 16392 <xbrtime_decode_pe>
   111b0:	87aa                	mv	a5,a0
   111b2:	2781                	sext.w	a5,a5
   111b4:	fc843703          	ld	a4,-56(s0)
   111b8:	0007069b          	sext.w	a3,a4
   111bc:	fc442703          	lw	a4,-60(s0)
   111c0:	2701                	sext.w	a4,a4
   111c2:	863e                	mv	a2,a5
   111c4:	85ca                	mv	a1,s2
   111c6:	8526                	mv	a0,s1
   111c8:	00006097          	auipc	ra,0x6
   111cc:	c1c080e7          	jalr	-996(ra) # 16de4 <__xbrtime_put_u1_seq>
   111d0:	a0b9                	j	1121e <xbrtime_char_put_nb+0xd8>
   111d2:	fd043483          	ld	s1,-48(s0)
   111d6:	fd843783          	ld	a5,-40(s0)
   111da:	fc042703          	lw	a4,-64(s0)
   111de:	85ba                	mv	a1,a4
   111e0:	853e                	mv	a0,a5
   111e2:	fffff097          	auipc	ra,0xfffff
   111e6:	638080e7          	jalr	1592(ra) # 1081a <__xbrtime_ltor>
   111ea:	892a                	mv	s2,a0
   111ec:	fc042783          	lw	a5,-64(s0)
   111f0:	853e                	mv	a0,a5
   111f2:	00005097          	auipc	ra,0x5
   111f6:	1a0080e7          	jalr	416(ra) # 16392 <xbrtime_decode_pe>
   111fa:	87aa                	mv	a5,a0
   111fc:	2781                	sext.w	a5,a5
   111fe:	fc843703          	ld	a4,-56(s0)
   11202:	0007069b          	sext.w	a3,a4
   11206:	fc442703          	lw	a4,-60(s0)
   1120a:	2701                	sext.w	a4,a4
   1120c:	863e                	mv	a2,a5
   1120e:	85ca                	mv	a1,s2
   11210:	8526                	mv	a0,s1
   11212:	00006097          	auipc	ra,0x6
   11216:	bee080e7          	jalr	-1042(ra) # 16e00 <__xbrtime_put_u1_agg>
   1121a:	a011                	j	1121e <xbrtime_char_put_nb+0xd8>
   1121c:	0001                	nop
   1121e:	70e2                	ld	ra,56(sp)
   11220:	7442                	ld	s0,48(sp)
   11222:	74a2                	ld	s1,40(sp)
   11224:	7902                	ld	s2,32(sp)
   11226:	6121                	addi	sp,sp,64
   11228:	8082                	ret

000000000001122a <xbrtime_short_put>:
   1122a:	7139                	addi	sp,sp,-64
   1122c:	fc06                	sd	ra,56(sp)
   1122e:	f822                	sd	s0,48(sp)
   11230:	f426                	sd	s1,40(sp)
   11232:	f04a                	sd	s2,32(sp)
   11234:	0080                	addi	s0,sp,64
   11236:	fca43c23          	sd	a0,-40(s0)
   1123a:	fcb43823          	sd	a1,-48(s0)
   1123e:	fcc43423          	sd	a2,-56(s0)
   11242:	87b6                	mv	a5,a3
   11244:	fcf42223          	sw	a5,-60(s0)
   11248:	87ba                	mv	a5,a4
   1124a:	fcf42023          	sw	a5,-64(s0)
   1124e:	fc843783          	ld	a5,-56(s0)
   11252:	c7cd                	beqz	a5,112fc <xbrtime_short_put+0xd2>
   11254:	fc442783          	lw	a5,-60(s0)
   11258:	0007871b          	sext.w	a4,a5
   1125c:	4785                	li	a5,1
   1125e:	00f71763          	bne	a4,a5,1126c <xbrtime_short_put+0x42>
   11262:	fc843703          	ld	a4,-56(s0)
   11266:	4785                	li	a5,1
   11268:	04f71563          	bne	a4,a5,112b2 <xbrtime_short_put+0x88>
   1126c:	fd043483          	ld	s1,-48(s0)
   11270:	fd843783          	ld	a5,-40(s0)
   11274:	fc042703          	lw	a4,-64(s0)
   11278:	85ba                	mv	a1,a4
   1127a:	853e                	mv	a0,a5
   1127c:	d9eff0ef          	jal	ra,1081a <__xbrtime_ltor>
   11280:	892a                	mv	s2,a0
   11282:	fc042783          	lw	a5,-64(s0)
   11286:	853e                	mv	a0,a5
   11288:	10a050ef          	jal	ra,16392 <xbrtime_decode_pe>
   1128c:	87aa                	mv	a5,a0
   1128e:	0007861b          	sext.w	a2,a5
   11292:	fc843783          	ld	a5,-56(s0)
   11296:	0007869b          	sext.w	a3,a5
   1129a:	fc442783          	lw	a5,-60(s0)
   1129e:	2781                	sext.w	a5,a5
   112a0:	0017979b          	slliw	a5,a5,0x1
   112a4:	2781                	sext.w	a5,a5
   112a6:	873e                	mv	a4,a5
   112a8:	85ca                	mv	a1,s2
   112aa:	8526                	mv	a0,s1
   112ac:	40b050ef          	jal	ra,16eb6 <__xbrtime_put_s2_seq>
   112b0:	a099                	j	112f6 <xbrtime_short_put+0xcc>
   112b2:	fd043483          	ld	s1,-48(s0)
   112b6:	fd843783          	ld	a5,-40(s0)
   112ba:	fc042703          	lw	a4,-64(s0)
   112be:	85ba                	mv	a1,a4
   112c0:	853e                	mv	a0,a5
   112c2:	d58ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   112c6:	892a                	mv	s2,a0
   112c8:	fc042783          	lw	a5,-64(s0)
   112cc:	853e                	mv	a0,a5
   112ce:	0c4050ef          	jal	ra,16392 <xbrtime_decode_pe>
   112d2:	87aa                	mv	a5,a0
   112d4:	0007861b          	sext.w	a2,a5
   112d8:	fc843783          	ld	a5,-56(s0)
   112dc:	0007869b          	sext.w	a3,a5
   112e0:	fc442783          	lw	a5,-60(s0)
   112e4:	2781                	sext.w	a5,a5
   112e6:	0017979b          	slliw	a5,a5,0x1
   112ea:	2781                	sext.w	a5,a5
   112ec:	873e                	mv	a4,a5
   112ee:	85ca                	mv	a1,s2
   112f0:	8526                	mv	a0,s1
   112f2:	3e1050ef          	jal	ra,16ed2 <__xbrtime_put_s2_agg>
   112f6:	459050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   112fa:	a011                	j	112fe <xbrtime_short_put+0xd4>
   112fc:	0001                	nop
   112fe:	70e2                	ld	ra,56(sp)
   11300:	7442                	ld	s0,48(sp)
   11302:	74a2                	ld	s1,40(sp)
   11304:	7902                	ld	s2,32(sp)
   11306:	6121                	addi	sp,sp,64
   11308:	8082                	ret

000000000001130a <xbrtime_short_put_nb>:
   1130a:	7139                	addi	sp,sp,-64
   1130c:	fc06                	sd	ra,56(sp)
   1130e:	f822                	sd	s0,48(sp)
   11310:	f426                	sd	s1,40(sp)
   11312:	f04a                	sd	s2,32(sp)
   11314:	0080                	addi	s0,sp,64
   11316:	fca43c23          	sd	a0,-40(s0)
   1131a:	fcb43823          	sd	a1,-48(s0)
   1131e:	fcc43423          	sd	a2,-56(s0)
   11322:	87b6                	mv	a5,a3
   11324:	fcf42223          	sw	a5,-60(s0)
   11328:	87ba                	mv	a5,a4
   1132a:	fcf42023          	sw	a5,-64(s0)
   1132e:	fc843783          	ld	a5,-56(s0)
   11332:	cfdd                	beqz	a5,113f0 <xbrtime_short_put_nb+0xe6>
   11334:	fc442783          	lw	a5,-60(s0)
   11338:	0007871b          	sext.w	a4,a5
   1133c:	4785                	li	a5,1
   1133e:	00f71763          	bne	a4,a5,1134c <xbrtime_short_put_nb+0x42>
   11342:	fc843703          	ld	a4,-56(s0)
   11346:	4785                	li	a5,1
   11348:	04f71b63          	bne	a4,a5,1139e <xbrtime_short_put_nb+0x94>
   1134c:	fd043483          	ld	s1,-48(s0)
   11350:	fd843783          	ld	a5,-40(s0)
   11354:	fc042703          	lw	a4,-64(s0)
   11358:	85ba                	mv	a1,a4
   1135a:	853e                	mv	a0,a5
   1135c:	fffff097          	auipc	ra,0xfffff
   11360:	4be080e7          	jalr	1214(ra) # 1081a <__xbrtime_ltor>
   11364:	892a                	mv	s2,a0
   11366:	fc042783          	lw	a5,-64(s0)
   1136a:	853e                	mv	a0,a5
   1136c:	00005097          	auipc	ra,0x5
   11370:	026080e7          	jalr	38(ra) # 16392 <xbrtime_decode_pe>
   11374:	87aa                	mv	a5,a0
   11376:	0007861b          	sext.w	a2,a5
   1137a:	fc843783          	ld	a5,-56(s0)
   1137e:	0007869b          	sext.w	a3,a5
   11382:	fc442783          	lw	a5,-60(s0)
   11386:	2781                	sext.w	a5,a5
   11388:	0017979b          	slliw	a5,a5,0x1
   1138c:	2781                	sext.w	a5,a5
   1138e:	873e                	mv	a4,a5
   11390:	85ca                	mv	a1,s2
   11392:	8526                	mv	a0,s1
   11394:	00006097          	auipc	ra,0x6
   11398:	b22080e7          	jalr	-1246(ra) # 16eb6 <__xbrtime_put_s2_seq>
   1139c:	a899                	j	113f2 <xbrtime_short_put_nb+0xe8>
   1139e:	fd043483          	ld	s1,-48(s0)
   113a2:	fd843783          	ld	a5,-40(s0)
   113a6:	fc042703          	lw	a4,-64(s0)
   113aa:	85ba                	mv	a1,a4
   113ac:	853e                	mv	a0,a5
   113ae:	fffff097          	auipc	ra,0xfffff
   113b2:	46c080e7          	jalr	1132(ra) # 1081a <__xbrtime_ltor>
   113b6:	892a                	mv	s2,a0
   113b8:	fc042783          	lw	a5,-64(s0)
   113bc:	853e                	mv	a0,a5
   113be:	00005097          	auipc	ra,0x5
   113c2:	fd4080e7          	jalr	-44(ra) # 16392 <xbrtime_decode_pe>
   113c6:	87aa                	mv	a5,a0
   113c8:	0007861b          	sext.w	a2,a5
   113cc:	fc843783          	ld	a5,-56(s0)
   113d0:	0007869b          	sext.w	a3,a5
   113d4:	fc442783          	lw	a5,-60(s0)
   113d8:	2781                	sext.w	a5,a5
   113da:	0017979b          	slliw	a5,a5,0x1
   113de:	2781                	sext.w	a5,a5
   113e0:	873e                	mv	a4,a5
   113e2:	85ca                	mv	a1,s2
   113e4:	8526                	mv	a0,s1
   113e6:	00006097          	auipc	ra,0x6
   113ea:	aec080e7          	jalr	-1300(ra) # 16ed2 <__xbrtime_put_s2_agg>
   113ee:	a011                	j	113f2 <xbrtime_short_put_nb+0xe8>
   113f0:	0001                	nop
   113f2:	70e2                	ld	ra,56(sp)
   113f4:	7442                	ld	s0,48(sp)
   113f6:	74a2                	ld	s1,40(sp)
   113f8:	7902                	ld	s2,32(sp)
   113fa:	6121                	addi	sp,sp,64
   113fc:	8082                	ret

00000000000113fe <xbrtime_int_put>:
   113fe:	7139                	addi	sp,sp,-64
   11400:	fc06                	sd	ra,56(sp)
   11402:	f822                	sd	s0,48(sp)
   11404:	f426                	sd	s1,40(sp)
   11406:	f04a                	sd	s2,32(sp)
   11408:	0080                	addi	s0,sp,64
   1140a:	fca43c23          	sd	a0,-40(s0)
   1140e:	fcb43823          	sd	a1,-48(s0)
   11412:	fcc43423          	sd	a2,-56(s0)
   11416:	87b6                	mv	a5,a3
   11418:	fcf42223          	sw	a5,-60(s0)
   1141c:	87ba                	mv	a5,a4
   1141e:	fcf42023          	sw	a5,-64(s0)
   11422:	fc843783          	ld	a5,-56(s0)
   11426:	c7cd                	beqz	a5,114d0 <xbrtime_int_put+0xd2>
   11428:	fc442783          	lw	a5,-60(s0)
   1142c:	0007871b          	sext.w	a4,a5
   11430:	4785                	li	a5,1
   11432:	00f71763          	bne	a4,a5,11440 <xbrtime_int_put+0x42>
   11436:	fc843703          	ld	a4,-56(s0)
   1143a:	4785                	li	a5,1
   1143c:	04f71563          	bne	a4,a5,11486 <xbrtime_int_put+0x88>
   11440:	fd043483          	ld	s1,-48(s0)
   11444:	fd843783          	ld	a5,-40(s0)
   11448:	fc042703          	lw	a4,-64(s0)
   1144c:	85ba                	mv	a1,a4
   1144e:	853e                	mv	a0,a5
   11450:	bcaff0ef          	jal	ra,1081a <__xbrtime_ltor>
   11454:	892a                	mv	s2,a0
   11456:	fc042783          	lw	a5,-64(s0)
   1145a:	853e                	mv	a0,a5
   1145c:	737040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11460:	87aa                	mv	a5,a0
   11462:	0007861b          	sext.w	a2,a5
   11466:	fc843783          	ld	a5,-56(s0)
   1146a:	0007869b          	sext.w	a3,a5
   1146e:	fc442783          	lw	a5,-60(s0)
   11472:	2781                	sext.w	a5,a5
   11474:	0027979b          	slliw	a5,a5,0x2
   11478:	2781                	sext.w	a5,a5
   1147a:	873e                	mv	a4,a5
   1147c:	85ca                	mv	a1,s2
   1147e:	8526                	mv	a0,s1
   11480:	261050ef          	jal	ra,16ee0 <__xbrtime_put_s4_seq>
   11484:	a099                	j	114ca <xbrtime_int_put+0xcc>
   11486:	fd043483          	ld	s1,-48(s0)
   1148a:	fd843783          	ld	a5,-40(s0)
   1148e:	fc042703          	lw	a4,-64(s0)
   11492:	85ba                	mv	a1,a4
   11494:	853e                	mv	a0,a5
   11496:	b84ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   1149a:	892a                	mv	s2,a0
   1149c:	fc042783          	lw	a5,-64(s0)
   114a0:	853e                	mv	a0,a5
   114a2:	6f1040ef          	jal	ra,16392 <xbrtime_decode_pe>
   114a6:	87aa                	mv	a5,a0
   114a8:	0007861b          	sext.w	a2,a5
   114ac:	fc843783          	ld	a5,-56(s0)
   114b0:	0007869b          	sext.w	a3,a5
   114b4:	fc442783          	lw	a5,-60(s0)
   114b8:	2781                	sext.w	a5,a5
   114ba:	0027979b          	slliw	a5,a5,0x2
   114be:	2781                	sext.w	a5,a5
   114c0:	873e                	mv	a4,a5
   114c2:	85ca                	mv	a1,s2
   114c4:	8526                	mv	a0,s1
   114c6:	237050ef          	jal	ra,16efc <__xbrtime_put_s4_agg>
   114ca:	285050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   114ce:	a011                	j	114d2 <xbrtime_int_put+0xd4>
   114d0:	0001                	nop
   114d2:	70e2                	ld	ra,56(sp)
   114d4:	7442                	ld	s0,48(sp)
   114d6:	74a2                	ld	s1,40(sp)
   114d8:	7902                	ld	s2,32(sp)
   114da:	6121                	addi	sp,sp,64
   114dc:	8082                	ret

00000000000114de <xbrtime_int_put_nb>:
   114de:	7139                	addi	sp,sp,-64
   114e0:	fc06                	sd	ra,56(sp)
   114e2:	f822                	sd	s0,48(sp)
   114e4:	f426                	sd	s1,40(sp)
   114e6:	f04a                	sd	s2,32(sp)
   114e8:	0080                	addi	s0,sp,64
   114ea:	fca43c23          	sd	a0,-40(s0)
   114ee:	fcb43823          	sd	a1,-48(s0)
   114f2:	fcc43423          	sd	a2,-56(s0)
   114f6:	87b6                	mv	a5,a3
   114f8:	fcf42223          	sw	a5,-60(s0)
   114fc:	87ba                	mv	a5,a4
   114fe:	fcf42023          	sw	a5,-64(s0)
   11502:	fc843783          	ld	a5,-56(s0)
   11506:	cfdd                	beqz	a5,115c4 <xbrtime_int_put_nb+0xe6>
   11508:	fc442783          	lw	a5,-60(s0)
   1150c:	0007871b          	sext.w	a4,a5
   11510:	4785                	li	a5,1
   11512:	00f71763          	bne	a4,a5,11520 <xbrtime_int_put_nb+0x42>
   11516:	fc843703          	ld	a4,-56(s0)
   1151a:	4785                	li	a5,1
   1151c:	04f71b63          	bne	a4,a5,11572 <xbrtime_int_put_nb+0x94>
   11520:	fd043483          	ld	s1,-48(s0)
   11524:	fd843783          	ld	a5,-40(s0)
   11528:	fc042703          	lw	a4,-64(s0)
   1152c:	85ba                	mv	a1,a4
   1152e:	853e                	mv	a0,a5
   11530:	fffff097          	auipc	ra,0xfffff
   11534:	2ea080e7          	jalr	746(ra) # 1081a <__xbrtime_ltor>
   11538:	892a                	mv	s2,a0
   1153a:	fc042783          	lw	a5,-64(s0)
   1153e:	853e                	mv	a0,a5
   11540:	00005097          	auipc	ra,0x5
   11544:	e52080e7          	jalr	-430(ra) # 16392 <xbrtime_decode_pe>
   11548:	87aa                	mv	a5,a0
   1154a:	0007861b          	sext.w	a2,a5
   1154e:	fc843783          	ld	a5,-56(s0)
   11552:	0007869b          	sext.w	a3,a5
   11556:	fc442783          	lw	a5,-60(s0)
   1155a:	2781                	sext.w	a5,a5
   1155c:	0017979b          	slliw	a5,a5,0x1
   11560:	2781                	sext.w	a5,a5
   11562:	873e                	mv	a4,a5
   11564:	85ca                	mv	a1,s2
   11566:	8526                	mv	a0,s1
   11568:	00006097          	auipc	ra,0x6
   1156c:	978080e7          	jalr	-1672(ra) # 16ee0 <__xbrtime_put_s4_seq>
   11570:	a899                	j	115c6 <xbrtime_int_put_nb+0xe8>
   11572:	fd043483          	ld	s1,-48(s0)
   11576:	fd843783          	ld	a5,-40(s0)
   1157a:	fc042703          	lw	a4,-64(s0)
   1157e:	85ba                	mv	a1,a4
   11580:	853e                	mv	a0,a5
   11582:	fffff097          	auipc	ra,0xfffff
   11586:	298080e7          	jalr	664(ra) # 1081a <__xbrtime_ltor>
   1158a:	892a                	mv	s2,a0
   1158c:	fc042783          	lw	a5,-64(s0)
   11590:	853e                	mv	a0,a5
   11592:	00005097          	auipc	ra,0x5
   11596:	e00080e7          	jalr	-512(ra) # 16392 <xbrtime_decode_pe>
   1159a:	87aa                	mv	a5,a0
   1159c:	0007861b          	sext.w	a2,a5
   115a0:	fc843783          	ld	a5,-56(s0)
   115a4:	0007869b          	sext.w	a3,a5
   115a8:	fc442783          	lw	a5,-60(s0)
   115ac:	2781                	sext.w	a5,a5
   115ae:	0017979b          	slliw	a5,a5,0x1
   115b2:	2781                	sext.w	a5,a5
   115b4:	873e                	mv	a4,a5
   115b6:	85ca                	mv	a1,s2
   115b8:	8526                	mv	a0,s1
   115ba:	00006097          	auipc	ra,0x6
   115be:	942080e7          	jalr	-1726(ra) # 16efc <__xbrtime_put_s4_agg>
   115c2:	a011                	j	115c6 <xbrtime_int_put_nb+0xe8>
   115c4:	0001                	nop
   115c6:	70e2                	ld	ra,56(sp)
   115c8:	7442                	ld	s0,48(sp)
   115ca:	74a2                	ld	s1,40(sp)
   115cc:	7902                	ld	s2,32(sp)
   115ce:	6121                	addi	sp,sp,64
   115d0:	8082                	ret

00000000000115d2 <xbrtime_long_put>:
   115d2:	7139                	addi	sp,sp,-64
   115d4:	fc06                	sd	ra,56(sp)
   115d6:	f822                	sd	s0,48(sp)
   115d8:	f426                	sd	s1,40(sp)
   115da:	f04a                	sd	s2,32(sp)
   115dc:	0080                	addi	s0,sp,64
   115de:	fca43c23          	sd	a0,-40(s0)
   115e2:	fcb43823          	sd	a1,-48(s0)
   115e6:	fcc43423          	sd	a2,-56(s0)
   115ea:	87b6                	mv	a5,a3
   115ec:	fcf42223          	sw	a5,-60(s0)
   115f0:	87ba                	mv	a5,a4
   115f2:	fcf42023          	sw	a5,-64(s0)
   115f6:	fc843783          	ld	a5,-56(s0)
   115fa:	c7cd                	beqz	a5,116a4 <xbrtime_long_put+0xd2>
   115fc:	fc442783          	lw	a5,-60(s0)
   11600:	0007871b          	sext.w	a4,a5
   11604:	4785                	li	a5,1
   11606:	00f71763          	bne	a4,a5,11614 <xbrtime_long_put+0x42>
   1160a:	fc843703          	ld	a4,-56(s0)
   1160e:	4785                	li	a5,1
   11610:	04f71563          	bne	a4,a5,1165a <xbrtime_long_put+0x88>
   11614:	fd043483          	ld	s1,-48(s0)
   11618:	fd843783          	ld	a5,-40(s0)
   1161c:	fc042703          	lw	a4,-64(s0)
   11620:	85ba                	mv	a1,a4
   11622:	853e                	mv	a0,a5
   11624:	9f6ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   11628:	892a                	mv	s2,a0
   1162a:	fc042783          	lw	a5,-64(s0)
   1162e:	853e                	mv	a0,a5
   11630:	563040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11634:	87aa                	mv	a5,a0
   11636:	0007861b          	sext.w	a2,a5
   1163a:	fc843783          	ld	a5,-56(s0)
   1163e:	0007869b          	sext.w	a3,a5
   11642:	fc442783          	lw	a5,-60(s0)
   11646:	2781                	sext.w	a5,a5
   11648:	0037979b          	slliw	a5,a5,0x3
   1164c:	2781                	sext.w	a5,a5
   1164e:	873e                	mv	a4,a5
   11650:	85ca                	mv	a1,s2
   11652:	8526                	mv	a0,s1
   11654:	08d050ef          	jal	ra,16ee0 <__xbrtime_put_s4_seq>
   11658:	a099                	j	1169e <xbrtime_long_put+0xcc>
   1165a:	fd043483          	ld	s1,-48(s0)
   1165e:	fd843783          	ld	a5,-40(s0)
   11662:	fc042703          	lw	a4,-64(s0)
   11666:	85ba                	mv	a1,a4
   11668:	853e                	mv	a0,a5
   1166a:	9b0ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   1166e:	892a                	mv	s2,a0
   11670:	fc042783          	lw	a5,-64(s0)
   11674:	853e                	mv	a0,a5
   11676:	51d040ef          	jal	ra,16392 <xbrtime_decode_pe>
   1167a:	87aa                	mv	a5,a0
   1167c:	0007861b          	sext.w	a2,a5
   11680:	fc843783          	ld	a5,-56(s0)
   11684:	0007869b          	sext.w	a3,a5
   11688:	fc442783          	lw	a5,-60(s0)
   1168c:	2781                	sext.w	a5,a5
   1168e:	0037979b          	slliw	a5,a5,0x3
   11692:	2781                	sext.w	a5,a5
   11694:	873e                	mv	a4,a5
   11696:	85ca                	mv	a1,s2
   11698:	8526                	mv	a0,s1
   1169a:	063050ef          	jal	ra,16efc <__xbrtime_put_s4_agg>
   1169e:	0b1050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   116a2:	a011                	j	116a6 <xbrtime_long_put+0xd4>
   116a4:	0001                	nop
   116a6:	70e2                	ld	ra,56(sp)
   116a8:	7442                	ld	s0,48(sp)
   116aa:	74a2                	ld	s1,40(sp)
   116ac:	7902                	ld	s2,32(sp)
   116ae:	6121                	addi	sp,sp,64
   116b0:	8082                	ret

00000000000116b2 <xbrtime_long_put_nb>:
   116b2:	7139                	addi	sp,sp,-64
   116b4:	fc06                	sd	ra,56(sp)
   116b6:	f822                	sd	s0,48(sp)
   116b8:	f426                	sd	s1,40(sp)
   116ba:	f04a                	sd	s2,32(sp)
   116bc:	0080                	addi	s0,sp,64
   116be:	fca43c23          	sd	a0,-40(s0)
   116c2:	fcb43823          	sd	a1,-48(s0)
   116c6:	fcc43423          	sd	a2,-56(s0)
   116ca:	87b6                	mv	a5,a3
   116cc:	fcf42223          	sw	a5,-60(s0)
   116d0:	87ba                	mv	a5,a4
   116d2:	fcf42023          	sw	a5,-64(s0)
   116d6:	fc843783          	ld	a5,-56(s0)
   116da:	cfdd                	beqz	a5,11798 <xbrtime_long_put_nb+0xe6>
   116dc:	fc442783          	lw	a5,-60(s0)
   116e0:	0007871b          	sext.w	a4,a5
   116e4:	4785                	li	a5,1
   116e6:	00f71763          	bne	a4,a5,116f4 <xbrtime_long_put_nb+0x42>
   116ea:	fc843703          	ld	a4,-56(s0)
   116ee:	4785                	li	a5,1
   116f0:	04f71b63          	bne	a4,a5,11746 <xbrtime_long_put_nb+0x94>
   116f4:	fd043483          	ld	s1,-48(s0)
   116f8:	fd843783          	ld	a5,-40(s0)
   116fc:	fc042703          	lw	a4,-64(s0)
   11700:	85ba                	mv	a1,a4
   11702:	853e                	mv	a0,a5
   11704:	fffff097          	auipc	ra,0xfffff
   11708:	116080e7          	jalr	278(ra) # 1081a <__xbrtime_ltor>
   1170c:	892a                	mv	s2,a0
   1170e:	fc042783          	lw	a5,-64(s0)
   11712:	853e                	mv	a0,a5
   11714:	00005097          	auipc	ra,0x5
   11718:	c7e080e7          	jalr	-898(ra) # 16392 <xbrtime_decode_pe>
   1171c:	87aa                	mv	a5,a0
   1171e:	0007861b          	sext.w	a2,a5
   11722:	fc843783          	ld	a5,-56(s0)
   11726:	0007869b          	sext.w	a3,a5
   1172a:	fc442783          	lw	a5,-60(s0)
   1172e:	2781                	sext.w	a5,a5
   11730:	0037979b          	slliw	a5,a5,0x3
   11734:	2781                	sext.w	a5,a5
   11736:	873e                	mv	a4,a5
   11738:	85ca                	mv	a1,s2
   1173a:	8526                	mv	a0,s1
   1173c:	00005097          	auipc	ra,0x5
   11740:	7a4080e7          	jalr	1956(ra) # 16ee0 <__xbrtime_put_s4_seq>
   11744:	a899                	j	1179a <xbrtime_long_put_nb+0xe8>
   11746:	fd043483          	ld	s1,-48(s0)
   1174a:	fd843783          	ld	a5,-40(s0)
   1174e:	fc042703          	lw	a4,-64(s0)
   11752:	85ba                	mv	a1,a4
   11754:	853e                	mv	a0,a5
   11756:	fffff097          	auipc	ra,0xfffff
   1175a:	0c4080e7          	jalr	196(ra) # 1081a <__xbrtime_ltor>
   1175e:	892a                	mv	s2,a0
   11760:	fc042783          	lw	a5,-64(s0)
   11764:	853e                	mv	a0,a5
   11766:	00005097          	auipc	ra,0x5
   1176a:	c2c080e7          	jalr	-980(ra) # 16392 <xbrtime_decode_pe>
   1176e:	87aa                	mv	a5,a0
   11770:	0007861b          	sext.w	a2,a5
   11774:	fc843783          	ld	a5,-56(s0)
   11778:	0007869b          	sext.w	a3,a5
   1177c:	fc442783          	lw	a5,-60(s0)
   11780:	2781                	sext.w	a5,a5
   11782:	0037979b          	slliw	a5,a5,0x3
   11786:	2781                	sext.w	a5,a5
   11788:	873e                	mv	a4,a5
   1178a:	85ca                	mv	a1,s2
   1178c:	8526                	mv	a0,s1
   1178e:	00005097          	auipc	ra,0x5
   11792:	76e080e7          	jalr	1902(ra) # 16efc <__xbrtime_put_s4_agg>
   11796:	a011                	j	1179a <xbrtime_long_put_nb+0xe8>
   11798:	0001                	nop
   1179a:	70e2                	ld	ra,56(sp)
   1179c:	7442                	ld	s0,48(sp)
   1179e:	74a2                	ld	s1,40(sp)
   117a0:	7902                	ld	s2,32(sp)
   117a2:	6121                	addi	sp,sp,64
   117a4:	8082                	ret

00000000000117a6 <xbrtime_longlong_put>:
   117a6:	7139                	addi	sp,sp,-64
   117a8:	fc06                	sd	ra,56(sp)
   117aa:	f822                	sd	s0,48(sp)
   117ac:	f426                	sd	s1,40(sp)
   117ae:	f04a                	sd	s2,32(sp)
   117b0:	0080                	addi	s0,sp,64
   117b2:	fca43c23          	sd	a0,-40(s0)
   117b6:	fcb43823          	sd	a1,-48(s0)
   117ba:	fcc43423          	sd	a2,-56(s0)
   117be:	87b6                	mv	a5,a3
   117c0:	fcf42223          	sw	a5,-60(s0)
   117c4:	87ba                	mv	a5,a4
   117c6:	fcf42023          	sw	a5,-64(s0)
   117ca:	fc843783          	ld	a5,-56(s0)
   117ce:	c7cd                	beqz	a5,11878 <xbrtime_longlong_put+0xd2>
   117d0:	fc442783          	lw	a5,-60(s0)
   117d4:	0007871b          	sext.w	a4,a5
   117d8:	4785                	li	a5,1
   117da:	00f71763          	bne	a4,a5,117e8 <xbrtime_longlong_put+0x42>
   117de:	fc843703          	ld	a4,-56(s0)
   117e2:	4785                	li	a5,1
   117e4:	04f71563          	bne	a4,a5,1182e <xbrtime_longlong_put+0x88>
   117e8:	fd043483          	ld	s1,-48(s0)
   117ec:	fd843783          	ld	a5,-40(s0)
   117f0:	fc042703          	lw	a4,-64(s0)
   117f4:	85ba                	mv	a1,a4
   117f6:	853e                	mv	a0,a5
   117f8:	822ff0ef          	jal	ra,1081a <__xbrtime_ltor>
   117fc:	892a                	mv	s2,a0
   117fe:	fc042783          	lw	a5,-64(s0)
   11802:	853e                	mv	a0,a5
   11804:	38f040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11808:	87aa                	mv	a5,a0
   1180a:	0007861b          	sext.w	a2,a5
   1180e:	fc843783          	ld	a5,-56(s0)
   11812:	0007869b          	sext.w	a3,a5
   11816:	fc442783          	lw	a5,-60(s0)
   1181a:	2781                	sext.w	a5,a5
   1181c:	0037979b          	slliw	a5,a5,0x3
   11820:	2781                	sext.w	a5,a5
   11822:	873e                	mv	a4,a5
   11824:	85ca                	mv	a1,s2
   11826:	8526                	mv	a0,s1
   11828:	6e2050ef          	jal	ra,16f0a <__xbrtime_put_s8_seq>
   1182c:	a099                	j	11872 <xbrtime_longlong_put+0xcc>
   1182e:	fd043483          	ld	s1,-48(s0)
   11832:	fd843783          	ld	a5,-40(s0)
   11836:	fc042703          	lw	a4,-64(s0)
   1183a:	85ba                	mv	a1,a4
   1183c:	853e                	mv	a0,a5
   1183e:	fddfe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11842:	892a                	mv	s2,a0
   11844:	fc042783          	lw	a5,-64(s0)
   11848:	853e                	mv	a0,a5
   1184a:	349040ef          	jal	ra,16392 <xbrtime_decode_pe>
   1184e:	87aa                	mv	a5,a0
   11850:	0007861b          	sext.w	a2,a5
   11854:	fc843783          	ld	a5,-56(s0)
   11858:	0007869b          	sext.w	a3,a5
   1185c:	fc442783          	lw	a5,-60(s0)
   11860:	2781                	sext.w	a5,a5
   11862:	0037979b          	slliw	a5,a5,0x3
   11866:	2781                	sext.w	a5,a5
   11868:	873e                	mv	a4,a5
   1186a:	85ca                	mv	a1,s2
   1186c:	8526                	mv	a0,s1
   1186e:	6b8050ef          	jal	ra,16f26 <__xbrtime_put_s8_agg>
   11872:	6dc050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   11876:	a011                	j	1187a <xbrtime_longlong_put+0xd4>
   11878:	0001                	nop
   1187a:	70e2                	ld	ra,56(sp)
   1187c:	7442                	ld	s0,48(sp)
   1187e:	74a2                	ld	s1,40(sp)
   11880:	7902                	ld	s2,32(sp)
   11882:	6121                	addi	sp,sp,64
   11884:	8082                	ret

0000000000011886 <xbrtime_longlong_put_nb>:
   11886:	7139                	addi	sp,sp,-64
   11888:	fc06                	sd	ra,56(sp)
   1188a:	f822                	sd	s0,48(sp)
   1188c:	f426                	sd	s1,40(sp)
   1188e:	f04a                	sd	s2,32(sp)
   11890:	0080                	addi	s0,sp,64
   11892:	fca43c23          	sd	a0,-40(s0)
   11896:	fcb43823          	sd	a1,-48(s0)
   1189a:	fcc43423          	sd	a2,-56(s0)
   1189e:	87b6                	mv	a5,a3
   118a0:	fcf42223          	sw	a5,-60(s0)
   118a4:	87ba                	mv	a5,a4
   118a6:	fcf42023          	sw	a5,-64(s0)
   118aa:	fc843783          	ld	a5,-56(s0)
   118ae:	cfdd                	beqz	a5,1196c <xbrtime_longlong_put_nb+0xe6>
   118b0:	fc442783          	lw	a5,-60(s0)
   118b4:	0007871b          	sext.w	a4,a5
   118b8:	4785                	li	a5,1
   118ba:	00f71763          	bne	a4,a5,118c8 <xbrtime_longlong_put_nb+0x42>
   118be:	fc843703          	ld	a4,-56(s0)
   118c2:	4785                	li	a5,1
   118c4:	04f71b63          	bne	a4,a5,1191a <xbrtime_longlong_put_nb+0x94>
   118c8:	fd043483          	ld	s1,-48(s0)
   118cc:	fd843783          	ld	a5,-40(s0)
   118d0:	fc042703          	lw	a4,-64(s0)
   118d4:	85ba                	mv	a1,a4
   118d6:	853e                	mv	a0,a5
   118d8:	fffff097          	auipc	ra,0xfffff
   118dc:	f42080e7          	jalr	-190(ra) # 1081a <__xbrtime_ltor>
   118e0:	892a                	mv	s2,a0
   118e2:	fc042783          	lw	a5,-64(s0)
   118e6:	853e                	mv	a0,a5
   118e8:	00005097          	auipc	ra,0x5
   118ec:	aaa080e7          	jalr	-1366(ra) # 16392 <xbrtime_decode_pe>
   118f0:	87aa                	mv	a5,a0
   118f2:	0007861b          	sext.w	a2,a5
   118f6:	fc843783          	ld	a5,-56(s0)
   118fa:	0007869b          	sext.w	a3,a5
   118fe:	fc442783          	lw	a5,-60(s0)
   11902:	2781                	sext.w	a5,a5
   11904:	0037979b          	slliw	a5,a5,0x3
   11908:	2781                	sext.w	a5,a5
   1190a:	873e                	mv	a4,a5
   1190c:	85ca                	mv	a1,s2
   1190e:	8526                	mv	a0,s1
   11910:	00005097          	auipc	ra,0x5
   11914:	5fa080e7          	jalr	1530(ra) # 16f0a <__xbrtime_put_s8_seq>
   11918:	a899                	j	1196e <xbrtime_longlong_put_nb+0xe8>
   1191a:	fd043483          	ld	s1,-48(s0)
   1191e:	fd843783          	ld	a5,-40(s0)
   11922:	fc042703          	lw	a4,-64(s0)
   11926:	85ba                	mv	a1,a4
   11928:	853e                	mv	a0,a5
   1192a:	fffff097          	auipc	ra,0xfffff
   1192e:	ef0080e7          	jalr	-272(ra) # 1081a <__xbrtime_ltor>
   11932:	892a                	mv	s2,a0
   11934:	fc042783          	lw	a5,-64(s0)
   11938:	853e                	mv	a0,a5
   1193a:	00005097          	auipc	ra,0x5
   1193e:	a58080e7          	jalr	-1448(ra) # 16392 <xbrtime_decode_pe>
   11942:	87aa                	mv	a5,a0
   11944:	0007861b          	sext.w	a2,a5
   11948:	fc843783          	ld	a5,-56(s0)
   1194c:	0007869b          	sext.w	a3,a5
   11950:	fc442783          	lw	a5,-60(s0)
   11954:	2781                	sext.w	a5,a5
   11956:	0037979b          	slliw	a5,a5,0x3
   1195a:	2781                	sext.w	a5,a5
   1195c:	873e                	mv	a4,a5
   1195e:	85ca                	mv	a1,s2
   11960:	8526                	mv	a0,s1
   11962:	00005097          	auipc	ra,0x5
   11966:	5c4080e7          	jalr	1476(ra) # 16f26 <__xbrtime_put_s8_agg>
   1196a:	a011                	j	1196e <xbrtime_longlong_put_nb+0xe8>
   1196c:	0001                	nop
   1196e:	70e2                	ld	ra,56(sp)
   11970:	7442                	ld	s0,48(sp)
   11972:	74a2                	ld	s1,40(sp)
   11974:	7902                	ld	s2,32(sp)
   11976:	6121                	addi	sp,sp,64
   11978:	8082                	ret

000000000001197a <xbrtime_uchar_put>:
   1197a:	7139                	addi	sp,sp,-64
   1197c:	fc06                	sd	ra,56(sp)
   1197e:	f822                	sd	s0,48(sp)
   11980:	f426                	sd	s1,40(sp)
   11982:	f04a                	sd	s2,32(sp)
   11984:	0080                	addi	s0,sp,64
   11986:	fca43c23          	sd	a0,-40(s0)
   1198a:	fcb43823          	sd	a1,-48(s0)
   1198e:	fcc43423          	sd	a2,-56(s0)
   11992:	87b6                	mv	a5,a3
   11994:	fcf42223          	sw	a5,-60(s0)
   11998:	87ba                	mv	a5,a4
   1199a:	fcf42023          	sw	a5,-64(s0)
   1199e:	fc843783          	ld	a5,-56(s0)
   119a2:	cfc9                	beqz	a5,11a3c <xbrtime_uchar_put+0xc2>
   119a4:	fc442783          	lw	a5,-60(s0)
   119a8:	0007871b          	sext.w	a4,a5
   119ac:	4785                	li	a5,1
   119ae:	00f71763          	bne	a4,a5,119bc <xbrtime_uchar_put+0x42>
   119b2:	fc843703          	ld	a4,-56(s0)
   119b6:	4785                	li	a5,1
   119b8:	04f71163          	bne	a4,a5,119fa <xbrtime_uchar_put+0x80>
   119bc:	fd043483          	ld	s1,-48(s0)
   119c0:	fd843783          	ld	a5,-40(s0)
   119c4:	fc042703          	lw	a4,-64(s0)
   119c8:	85ba                	mv	a1,a4
   119ca:	853e                	mv	a0,a5
   119cc:	e4ffe0ef          	jal	ra,1081a <__xbrtime_ltor>
   119d0:	892a                	mv	s2,a0
   119d2:	fc042783          	lw	a5,-64(s0)
   119d6:	853e                	mv	a0,a5
   119d8:	1bb040ef          	jal	ra,16392 <xbrtime_decode_pe>
   119dc:	87aa                	mv	a5,a0
   119de:	2781                	sext.w	a5,a5
   119e0:	fc843703          	ld	a4,-56(s0)
   119e4:	0007069b          	sext.w	a3,a4
   119e8:	fc442703          	lw	a4,-60(s0)
   119ec:	2701                	sext.w	a4,a4
   119ee:	863e                	mv	a2,a5
   119f0:	85ca                	mv	a1,s2
   119f2:	8526                	mv	a0,s1
   119f4:	3f0050ef          	jal	ra,16de4 <__xbrtime_put_u1_seq>
   119f8:	a83d                	j	11a36 <xbrtime_uchar_put+0xbc>
   119fa:	fd043483          	ld	s1,-48(s0)
   119fe:	fd843783          	ld	a5,-40(s0)
   11a02:	fc042703          	lw	a4,-64(s0)
   11a06:	85ba                	mv	a1,a4
   11a08:	853e                	mv	a0,a5
   11a0a:	e11fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11a0e:	892a                	mv	s2,a0
   11a10:	fc042783          	lw	a5,-64(s0)
   11a14:	853e                	mv	a0,a5
   11a16:	17d040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11a1a:	87aa                	mv	a5,a0
   11a1c:	2781                	sext.w	a5,a5
   11a1e:	fc843703          	ld	a4,-56(s0)
   11a22:	0007069b          	sext.w	a3,a4
   11a26:	fc442703          	lw	a4,-60(s0)
   11a2a:	2701                	sext.w	a4,a4
   11a2c:	863e                	mv	a2,a5
   11a2e:	85ca                	mv	a1,s2
   11a30:	8526                	mv	a0,s1
   11a32:	3ce050ef          	jal	ra,16e00 <__xbrtime_put_u1_agg>
   11a36:	518050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   11a3a:	a011                	j	11a3e <xbrtime_uchar_put+0xc4>
   11a3c:	0001                	nop
   11a3e:	70e2                	ld	ra,56(sp)
   11a40:	7442                	ld	s0,48(sp)
   11a42:	74a2                	ld	s1,40(sp)
   11a44:	7902                	ld	s2,32(sp)
   11a46:	6121                	addi	sp,sp,64
   11a48:	8082                	ret

0000000000011a4a <xbrtime_uchar_put_nb>:
   11a4a:	7139                	addi	sp,sp,-64
   11a4c:	fc06                	sd	ra,56(sp)
   11a4e:	f822                	sd	s0,48(sp)
   11a50:	f426                	sd	s1,40(sp)
   11a52:	f04a                	sd	s2,32(sp)
   11a54:	0080                	addi	s0,sp,64
   11a56:	fca43c23          	sd	a0,-40(s0)
   11a5a:	fcb43823          	sd	a1,-48(s0)
   11a5e:	fcc43423          	sd	a2,-56(s0)
   11a62:	87b6                	mv	a5,a3
   11a64:	fcf42223          	sw	a5,-60(s0)
   11a68:	87ba                	mv	a5,a4
   11a6a:	fcf42023          	sw	a5,-64(s0)
   11a6e:	fc843783          	ld	a5,-56(s0)
   11a72:	c7dd                	beqz	a5,11b20 <xbrtime_uchar_put_nb+0xd6>
   11a74:	fc442783          	lw	a5,-60(s0)
   11a78:	0007871b          	sext.w	a4,a5
   11a7c:	4785                	li	a5,1
   11a7e:	00f71763          	bne	a4,a5,11a8c <xbrtime_uchar_put_nb+0x42>
   11a82:	fc843703          	ld	a4,-56(s0)
   11a86:	4785                	li	a5,1
   11a88:	04f71763          	bne	a4,a5,11ad6 <xbrtime_uchar_put_nb+0x8c>
   11a8c:	fd043483          	ld	s1,-48(s0)
   11a90:	fd843783          	ld	a5,-40(s0)
   11a94:	fc042703          	lw	a4,-64(s0)
   11a98:	85ba                	mv	a1,a4
   11a9a:	853e                	mv	a0,a5
   11a9c:	fffff097          	auipc	ra,0xfffff
   11aa0:	d7e080e7          	jalr	-642(ra) # 1081a <__xbrtime_ltor>
   11aa4:	892a                	mv	s2,a0
   11aa6:	fc042783          	lw	a5,-64(s0)
   11aaa:	853e                	mv	a0,a5
   11aac:	00005097          	auipc	ra,0x5
   11ab0:	8e6080e7          	jalr	-1818(ra) # 16392 <xbrtime_decode_pe>
   11ab4:	87aa                	mv	a5,a0
   11ab6:	2781                	sext.w	a5,a5
   11ab8:	fc843703          	ld	a4,-56(s0)
   11abc:	0007069b          	sext.w	a3,a4
   11ac0:	fc442703          	lw	a4,-60(s0)
   11ac4:	2701                	sext.w	a4,a4
   11ac6:	863e                	mv	a2,a5
   11ac8:	85ca                	mv	a1,s2
   11aca:	8526                	mv	a0,s1
   11acc:	00005097          	auipc	ra,0x5
   11ad0:	318080e7          	jalr	792(ra) # 16de4 <__xbrtime_put_u1_seq>
   11ad4:	a0b9                	j	11b22 <xbrtime_uchar_put_nb+0xd8>
   11ad6:	fd043483          	ld	s1,-48(s0)
   11ada:	fd843783          	ld	a5,-40(s0)
   11ade:	fc042703          	lw	a4,-64(s0)
   11ae2:	85ba                	mv	a1,a4
   11ae4:	853e                	mv	a0,a5
   11ae6:	fffff097          	auipc	ra,0xfffff
   11aea:	d34080e7          	jalr	-716(ra) # 1081a <__xbrtime_ltor>
   11aee:	892a                	mv	s2,a0
   11af0:	fc042783          	lw	a5,-64(s0)
   11af4:	853e                	mv	a0,a5
   11af6:	00005097          	auipc	ra,0x5
   11afa:	89c080e7          	jalr	-1892(ra) # 16392 <xbrtime_decode_pe>
   11afe:	87aa                	mv	a5,a0
   11b00:	2781                	sext.w	a5,a5
   11b02:	fc843703          	ld	a4,-56(s0)
   11b06:	0007069b          	sext.w	a3,a4
   11b0a:	fc442703          	lw	a4,-60(s0)
   11b0e:	2701                	sext.w	a4,a4
   11b10:	863e                	mv	a2,a5
   11b12:	85ca                	mv	a1,s2
   11b14:	8526                	mv	a0,s1
   11b16:	00005097          	auipc	ra,0x5
   11b1a:	2ea080e7          	jalr	746(ra) # 16e00 <__xbrtime_put_u1_agg>
   11b1e:	a011                	j	11b22 <xbrtime_uchar_put_nb+0xd8>
   11b20:	0001                	nop
   11b22:	70e2                	ld	ra,56(sp)
   11b24:	7442                	ld	s0,48(sp)
   11b26:	74a2                	ld	s1,40(sp)
   11b28:	7902                	ld	s2,32(sp)
   11b2a:	6121                	addi	sp,sp,64
   11b2c:	8082                	ret

0000000000011b2e <xbrtime_ushort_put>:
   11b2e:	7139                	addi	sp,sp,-64
   11b30:	fc06                	sd	ra,56(sp)
   11b32:	f822                	sd	s0,48(sp)
   11b34:	f426                	sd	s1,40(sp)
   11b36:	f04a                	sd	s2,32(sp)
   11b38:	0080                	addi	s0,sp,64
   11b3a:	fca43c23          	sd	a0,-40(s0)
   11b3e:	fcb43823          	sd	a1,-48(s0)
   11b42:	fcc43423          	sd	a2,-56(s0)
   11b46:	87b6                	mv	a5,a3
   11b48:	fcf42223          	sw	a5,-60(s0)
   11b4c:	87ba                	mv	a5,a4
   11b4e:	fcf42023          	sw	a5,-64(s0)
   11b52:	fc843783          	ld	a5,-56(s0)
   11b56:	c7cd                	beqz	a5,11c00 <xbrtime_ushort_put+0xd2>
   11b58:	fc442783          	lw	a5,-60(s0)
   11b5c:	0007871b          	sext.w	a4,a5
   11b60:	4785                	li	a5,1
   11b62:	00f71763          	bne	a4,a5,11b70 <xbrtime_ushort_put+0x42>
   11b66:	fc843703          	ld	a4,-56(s0)
   11b6a:	4785                	li	a5,1
   11b6c:	04f71563          	bne	a4,a5,11bb6 <xbrtime_ushort_put+0x88>
   11b70:	fd043483          	ld	s1,-48(s0)
   11b74:	fd843783          	ld	a5,-40(s0)
   11b78:	fc042703          	lw	a4,-64(s0)
   11b7c:	85ba                	mv	a1,a4
   11b7e:	853e                	mv	a0,a5
   11b80:	c9bfe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11b84:	892a                	mv	s2,a0
   11b86:	fc042783          	lw	a5,-64(s0)
   11b8a:	853e                	mv	a0,a5
   11b8c:	007040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11b90:	87aa                	mv	a5,a0
   11b92:	0007861b          	sext.w	a2,a5
   11b96:	fc843783          	ld	a5,-56(s0)
   11b9a:	0007869b          	sext.w	a3,a5
   11b9e:	fc442783          	lw	a5,-60(s0)
   11ba2:	2781                	sext.w	a5,a5
   11ba4:	0017979b          	slliw	a5,a5,0x1
   11ba8:	2781                	sext.w	a5,a5
   11baa:	873e                	mv	a4,a5
   11bac:	85ca                	mv	a1,s2
   11bae:	8526                	mv	a0,s1
   11bb0:	25e050ef          	jal	ra,16e0e <__xbrtime_put_u2_seq>
   11bb4:	a099                	j	11bfa <xbrtime_ushort_put+0xcc>
   11bb6:	fd043483          	ld	s1,-48(s0)
   11bba:	fd843783          	ld	a5,-40(s0)
   11bbe:	fc042703          	lw	a4,-64(s0)
   11bc2:	85ba                	mv	a1,a4
   11bc4:	853e                	mv	a0,a5
   11bc6:	c55fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11bca:	892a                	mv	s2,a0
   11bcc:	fc042783          	lw	a5,-64(s0)
   11bd0:	853e                	mv	a0,a5
   11bd2:	7c0040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11bd6:	87aa                	mv	a5,a0
   11bd8:	0007861b          	sext.w	a2,a5
   11bdc:	fc843783          	ld	a5,-56(s0)
   11be0:	0007869b          	sext.w	a3,a5
   11be4:	fc442783          	lw	a5,-60(s0)
   11be8:	2781                	sext.w	a5,a5
   11bea:	0017979b          	slliw	a5,a5,0x1
   11bee:	2781                	sext.w	a5,a5
   11bf0:	873e                	mv	a4,a5
   11bf2:	85ca                	mv	a1,s2
   11bf4:	8526                	mv	a0,s1
   11bf6:	234050ef          	jal	ra,16e2a <__xbrtime_put_u2_agg>
   11bfa:	354050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   11bfe:	a011                	j	11c02 <xbrtime_ushort_put+0xd4>
   11c00:	0001                	nop
   11c02:	70e2                	ld	ra,56(sp)
   11c04:	7442                	ld	s0,48(sp)
   11c06:	74a2                	ld	s1,40(sp)
   11c08:	7902                	ld	s2,32(sp)
   11c0a:	6121                	addi	sp,sp,64
   11c0c:	8082                	ret

0000000000011c0e <xbrtime_ushort_put_nb>:
   11c0e:	7139                	addi	sp,sp,-64
   11c10:	fc06                	sd	ra,56(sp)
   11c12:	f822                	sd	s0,48(sp)
   11c14:	f426                	sd	s1,40(sp)
   11c16:	f04a                	sd	s2,32(sp)
   11c18:	0080                	addi	s0,sp,64
   11c1a:	fca43c23          	sd	a0,-40(s0)
   11c1e:	fcb43823          	sd	a1,-48(s0)
   11c22:	fcc43423          	sd	a2,-56(s0)
   11c26:	87b6                	mv	a5,a3
   11c28:	fcf42223          	sw	a5,-60(s0)
   11c2c:	87ba                	mv	a5,a4
   11c2e:	fcf42023          	sw	a5,-64(s0)
   11c32:	fc843783          	ld	a5,-56(s0)
   11c36:	cfdd                	beqz	a5,11cf4 <xbrtime_ushort_put_nb+0xe6>
   11c38:	fc442783          	lw	a5,-60(s0)
   11c3c:	0007871b          	sext.w	a4,a5
   11c40:	4785                	li	a5,1
   11c42:	00f71763          	bne	a4,a5,11c50 <xbrtime_ushort_put_nb+0x42>
   11c46:	fc843703          	ld	a4,-56(s0)
   11c4a:	4785                	li	a5,1
   11c4c:	04f71b63          	bne	a4,a5,11ca2 <xbrtime_ushort_put_nb+0x94>
   11c50:	fd043483          	ld	s1,-48(s0)
   11c54:	fd843783          	ld	a5,-40(s0)
   11c58:	fc042703          	lw	a4,-64(s0)
   11c5c:	85ba                	mv	a1,a4
   11c5e:	853e                	mv	a0,a5
   11c60:	fffff097          	auipc	ra,0xfffff
   11c64:	bba080e7          	jalr	-1094(ra) # 1081a <__xbrtime_ltor>
   11c68:	892a                	mv	s2,a0
   11c6a:	fc042783          	lw	a5,-64(s0)
   11c6e:	853e                	mv	a0,a5
   11c70:	00004097          	auipc	ra,0x4
   11c74:	722080e7          	jalr	1826(ra) # 16392 <xbrtime_decode_pe>
   11c78:	87aa                	mv	a5,a0
   11c7a:	0007861b          	sext.w	a2,a5
   11c7e:	fc843783          	ld	a5,-56(s0)
   11c82:	0007869b          	sext.w	a3,a5
   11c86:	fc442783          	lw	a5,-60(s0)
   11c8a:	2781                	sext.w	a5,a5
   11c8c:	0017979b          	slliw	a5,a5,0x1
   11c90:	2781                	sext.w	a5,a5
   11c92:	873e                	mv	a4,a5
   11c94:	85ca                	mv	a1,s2
   11c96:	8526                	mv	a0,s1
   11c98:	00005097          	auipc	ra,0x5
   11c9c:	176080e7          	jalr	374(ra) # 16e0e <__xbrtime_put_u2_seq>
   11ca0:	a899                	j	11cf6 <xbrtime_ushort_put_nb+0xe8>
   11ca2:	fd043483          	ld	s1,-48(s0)
   11ca6:	fd843783          	ld	a5,-40(s0)
   11caa:	fc042703          	lw	a4,-64(s0)
   11cae:	85ba                	mv	a1,a4
   11cb0:	853e                	mv	a0,a5
   11cb2:	fffff097          	auipc	ra,0xfffff
   11cb6:	b68080e7          	jalr	-1176(ra) # 1081a <__xbrtime_ltor>
   11cba:	892a                	mv	s2,a0
   11cbc:	fc042783          	lw	a5,-64(s0)
   11cc0:	853e                	mv	a0,a5
   11cc2:	00004097          	auipc	ra,0x4
   11cc6:	6d0080e7          	jalr	1744(ra) # 16392 <xbrtime_decode_pe>
   11cca:	87aa                	mv	a5,a0
   11ccc:	0007861b          	sext.w	a2,a5
   11cd0:	fc843783          	ld	a5,-56(s0)
   11cd4:	0007869b          	sext.w	a3,a5
   11cd8:	fc442783          	lw	a5,-60(s0)
   11cdc:	2781                	sext.w	a5,a5
   11cde:	0017979b          	slliw	a5,a5,0x1
   11ce2:	2781                	sext.w	a5,a5
   11ce4:	873e                	mv	a4,a5
   11ce6:	85ca                	mv	a1,s2
   11ce8:	8526                	mv	a0,s1
   11cea:	00005097          	auipc	ra,0x5
   11cee:	140080e7          	jalr	320(ra) # 16e2a <__xbrtime_put_u2_agg>
   11cf2:	a011                	j	11cf6 <xbrtime_ushort_put_nb+0xe8>
   11cf4:	0001                	nop
   11cf6:	70e2                	ld	ra,56(sp)
   11cf8:	7442                	ld	s0,48(sp)
   11cfa:	74a2                	ld	s1,40(sp)
   11cfc:	7902                	ld	s2,32(sp)
   11cfe:	6121                	addi	sp,sp,64
   11d00:	8082                	ret

0000000000011d02 <xbrtime_uint_put>:
   11d02:	7139                	addi	sp,sp,-64
   11d04:	fc06                	sd	ra,56(sp)
   11d06:	f822                	sd	s0,48(sp)
   11d08:	f426                	sd	s1,40(sp)
   11d0a:	f04a                	sd	s2,32(sp)
   11d0c:	0080                	addi	s0,sp,64
   11d0e:	fca43c23          	sd	a0,-40(s0)
   11d12:	fcb43823          	sd	a1,-48(s0)
   11d16:	fcc43423          	sd	a2,-56(s0)
   11d1a:	87b6                	mv	a5,a3
   11d1c:	fcf42223          	sw	a5,-60(s0)
   11d20:	87ba                	mv	a5,a4
   11d22:	fcf42023          	sw	a5,-64(s0)
   11d26:	fc843783          	ld	a5,-56(s0)
   11d2a:	c7cd                	beqz	a5,11dd4 <xbrtime_uint_put+0xd2>
   11d2c:	fc442783          	lw	a5,-60(s0)
   11d30:	0007871b          	sext.w	a4,a5
   11d34:	4785                	li	a5,1
   11d36:	00f71763          	bne	a4,a5,11d44 <xbrtime_uint_put+0x42>
   11d3a:	fc843703          	ld	a4,-56(s0)
   11d3e:	4785                	li	a5,1
   11d40:	04f71563          	bne	a4,a5,11d8a <xbrtime_uint_put+0x88>
   11d44:	fd043483          	ld	s1,-48(s0)
   11d48:	fd843783          	ld	a5,-40(s0)
   11d4c:	fc042703          	lw	a4,-64(s0)
   11d50:	85ba                	mv	a1,a4
   11d52:	853e                	mv	a0,a5
   11d54:	ac7fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11d58:	892a                	mv	s2,a0
   11d5a:	fc042783          	lw	a5,-64(s0)
   11d5e:	853e                	mv	a0,a5
   11d60:	632040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11d64:	87aa                	mv	a5,a0
   11d66:	0007861b          	sext.w	a2,a5
   11d6a:	fc843783          	ld	a5,-56(s0)
   11d6e:	0007869b          	sext.w	a3,a5
   11d72:	fc442783          	lw	a5,-60(s0)
   11d76:	2781                	sext.w	a5,a5
   11d78:	0027979b          	slliw	a5,a5,0x2
   11d7c:	2781                	sext.w	a5,a5
   11d7e:	873e                	mv	a4,a5
   11d80:	85ca                	mv	a1,s2
   11d82:	8526                	mv	a0,s1
   11d84:	0b4050ef          	jal	ra,16e38 <__xbrtime_put_u4_seq>
   11d88:	a099                	j	11dce <xbrtime_uint_put+0xcc>
   11d8a:	fd043483          	ld	s1,-48(s0)
   11d8e:	fd843783          	ld	a5,-40(s0)
   11d92:	fc042703          	lw	a4,-64(s0)
   11d96:	85ba                	mv	a1,a4
   11d98:	853e                	mv	a0,a5
   11d9a:	a81fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11d9e:	892a                	mv	s2,a0
   11da0:	fc042783          	lw	a5,-64(s0)
   11da4:	853e                	mv	a0,a5
   11da6:	5ec040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11daa:	87aa                	mv	a5,a0
   11dac:	0007861b          	sext.w	a2,a5
   11db0:	fc843783          	ld	a5,-56(s0)
   11db4:	0007869b          	sext.w	a3,a5
   11db8:	fc442783          	lw	a5,-60(s0)
   11dbc:	2781                	sext.w	a5,a5
   11dbe:	0027979b          	slliw	a5,a5,0x2
   11dc2:	2781                	sext.w	a5,a5
   11dc4:	873e                	mv	a4,a5
   11dc6:	85ca                	mv	a1,s2
   11dc8:	8526                	mv	a0,s1
   11dca:	08a050ef          	jal	ra,16e54 <__xbrtime_put_u4_agg>
   11dce:	180050ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   11dd2:	a011                	j	11dd6 <xbrtime_uint_put+0xd4>
   11dd4:	0001                	nop
   11dd6:	70e2                	ld	ra,56(sp)
   11dd8:	7442                	ld	s0,48(sp)
   11dda:	74a2                	ld	s1,40(sp)
   11ddc:	7902                	ld	s2,32(sp)
   11dde:	6121                	addi	sp,sp,64
   11de0:	8082                	ret

0000000000011de2 <xbrtime_uint_put_nb>:
   11de2:	7139                	addi	sp,sp,-64
   11de4:	fc06                	sd	ra,56(sp)
   11de6:	f822                	sd	s0,48(sp)
   11de8:	f426                	sd	s1,40(sp)
   11dea:	f04a                	sd	s2,32(sp)
   11dec:	0080                	addi	s0,sp,64
   11dee:	fca43c23          	sd	a0,-40(s0)
   11df2:	fcb43823          	sd	a1,-48(s0)
   11df6:	fcc43423          	sd	a2,-56(s0)
   11dfa:	87b6                	mv	a5,a3
   11dfc:	fcf42223          	sw	a5,-60(s0)
   11e00:	87ba                	mv	a5,a4
   11e02:	fcf42023          	sw	a5,-64(s0)
   11e06:	fc843783          	ld	a5,-56(s0)
   11e0a:	cfdd                	beqz	a5,11ec8 <xbrtime_uint_put_nb+0xe6>
   11e0c:	fc442783          	lw	a5,-60(s0)
   11e10:	0007871b          	sext.w	a4,a5
   11e14:	4785                	li	a5,1
   11e16:	00f71763          	bne	a4,a5,11e24 <xbrtime_uint_put_nb+0x42>
   11e1a:	fc843703          	ld	a4,-56(s0)
   11e1e:	4785                	li	a5,1
   11e20:	04f71b63          	bne	a4,a5,11e76 <xbrtime_uint_put_nb+0x94>
   11e24:	fd043483          	ld	s1,-48(s0)
   11e28:	fd843783          	ld	a5,-40(s0)
   11e2c:	fc042703          	lw	a4,-64(s0)
   11e30:	85ba                	mv	a1,a4
   11e32:	853e                	mv	a0,a5
   11e34:	fffff097          	auipc	ra,0xfffff
   11e38:	9e6080e7          	jalr	-1562(ra) # 1081a <__xbrtime_ltor>
   11e3c:	892a                	mv	s2,a0
   11e3e:	fc042783          	lw	a5,-64(s0)
   11e42:	853e                	mv	a0,a5
   11e44:	00004097          	auipc	ra,0x4
   11e48:	54e080e7          	jalr	1358(ra) # 16392 <xbrtime_decode_pe>
   11e4c:	87aa                	mv	a5,a0
   11e4e:	0007861b          	sext.w	a2,a5
   11e52:	fc843783          	ld	a5,-56(s0)
   11e56:	0007869b          	sext.w	a3,a5
   11e5a:	fc442783          	lw	a5,-60(s0)
   11e5e:	2781                	sext.w	a5,a5
   11e60:	0027979b          	slliw	a5,a5,0x2
   11e64:	2781                	sext.w	a5,a5
   11e66:	873e                	mv	a4,a5
   11e68:	85ca                	mv	a1,s2
   11e6a:	8526                	mv	a0,s1
   11e6c:	00005097          	auipc	ra,0x5
   11e70:	fcc080e7          	jalr	-52(ra) # 16e38 <__xbrtime_put_u4_seq>
   11e74:	a899                	j	11eca <xbrtime_uint_put_nb+0xe8>
   11e76:	fd043483          	ld	s1,-48(s0)
   11e7a:	fd843783          	ld	a5,-40(s0)
   11e7e:	fc042703          	lw	a4,-64(s0)
   11e82:	85ba                	mv	a1,a4
   11e84:	853e                	mv	a0,a5
   11e86:	fffff097          	auipc	ra,0xfffff
   11e8a:	994080e7          	jalr	-1644(ra) # 1081a <__xbrtime_ltor>
   11e8e:	892a                	mv	s2,a0
   11e90:	fc042783          	lw	a5,-64(s0)
   11e94:	853e                	mv	a0,a5
   11e96:	00004097          	auipc	ra,0x4
   11e9a:	4fc080e7          	jalr	1276(ra) # 16392 <xbrtime_decode_pe>
   11e9e:	87aa                	mv	a5,a0
   11ea0:	0007861b          	sext.w	a2,a5
   11ea4:	fc843783          	ld	a5,-56(s0)
   11ea8:	0007869b          	sext.w	a3,a5
   11eac:	fc442783          	lw	a5,-60(s0)
   11eb0:	2781                	sext.w	a5,a5
   11eb2:	0027979b          	slliw	a5,a5,0x2
   11eb6:	2781                	sext.w	a5,a5
   11eb8:	873e                	mv	a4,a5
   11eba:	85ca                	mv	a1,s2
   11ebc:	8526                	mv	a0,s1
   11ebe:	00005097          	auipc	ra,0x5
   11ec2:	f96080e7          	jalr	-106(ra) # 16e54 <__xbrtime_put_u4_agg>
   11ec6:	a011                	j	11eca <xbrtime_uint_put_nb+0xe8>
   11ec8:	0001                	nop
   11eca:	70e2                	ld	ra,56(sp)
   11ecc:	7442                	ld	s0,48(sp)
   11ece:	74a2                	ld	s1,40(sp)
   11ed0:	7902                	ld	s2,32(sp)
   11ed2:	6121                	addi	sp,sp,64
   11ed4:	8082                	ret

0000000000011ed6 <xbrtime_ulong_put>:
   11ed6:	7139                	addi	sp,sp,-64
   11ed8:	fc06                	sd	ra,56(sp)
   11eda:	f822                	sd	s0,48(sp)
   11edc:	f426                	sd	s1,40(sp)
   11ede:	f04a                	sd	s2,32(sp)
   11ee0:	0080                	addi	s0,sp,64
   11ee2:	fca43c23          	sd	a0,-40(s0)
   11ee6:	fcb43823          	sd	a1,-48(s0)
   11eea:	fcc43423          	sd	a2,-56(s0)
   11eee:	87b6                	mv	a5,a3
   11ef0:	fcf42223          	sw	a5,-60(s0)
   11ef4:	87ba                	mv	a5,a4
   11ef6:	fcf42023          	sw	a5,-64(s0)
   11efa:	fc843783          	ld	a5,-56(s0)
   11efe:	c7cd                	beqz	a5,11fa8 <xbrtime_ulong_put+0xd2>
   11f00:	fc442783          	lw	a5,-60(s0)
   11f04:	0007871b          	sext.w	a4,a5
   11f08:	4785                	li	a5,1
   11f0a:	00f71763          	bne	a4,a5,11f18 <xbrtime_ulong_put+0x42>
   11f0e:	fc843703          	ld	a4,-56(s0)
   11f12:	4785                	li	a5,1
   11f14:	04f71563          	bne	a4,a5,11f5e <xbrtime_ulong_put+0x88>
   11f18:	fd043483          	ld	s1,-48(s0)
   11f1c:	fd843783          	ld	a5,-40(s0)
   11f20:	fc042703          	lw	a4,-64(s0)
   11f24:	85ba                	mv	a1,a4
   11f26:	853e                	mv	a0,a5
   11f28:	8f3fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11f2c:	892a                	mv	s2,a0
   11f2e:	fc042783          	lw	a5,-64(s0)
   11f32:	853e                	mv	a0,a5
   11f34:	45e040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11f38:	87aa                	mv	a5,a0
   11f3a:	0007861b          	sext.w	a2,a5
   11f3e:	fc843783          	ld	a5,-56(s0)
   11f42:	0007869b          	sext.w	a3,a5
   11f46:	fc442783          	lw	a5,-60(s0)
   11f4a:	2781                	sext.w	a5,a5
   11f4c:	0037979b          	slliw	a5,a5,0x3
   11f50:	2781                	sext.w	a5,a5
   11f52:	873e                	mv	a4,a5
   11f54:	85ca                	mv	a1,s2
   11f56:	8526                	mv	a0,s1
   11f58:	6e1040ef          	jal	ra,16e38 <__xbrtime_put_u4_seq>
   11f5c:	a099                	j	11fa2 <xbrtime_ulong_put+0xcc>
   11f5e:	fd043483          	ld	s1,-48(s0)
   11f62:	fd843783          	ld	a5,-40(s0)
   11f66:	fc042703          	lw	a4,-64(s0)
   11f6a:	85ba                	mv	a1,a4
   11f6c:	853e                	mv	a0,a5
   11f6e:	8adfe0ef          	jal	ra,1081a <__xbrtime_ltor>
   11f72:	892a                	mv	s2,a0
   11f74:	fc042783          	lw	a5,-64(s0)
   11f78:	853e                	mv	a0,a5
   11f7a:	418040ef          	jal	ra,16392 <xbrtime_decode_pe>
   11f7e:	87aa                	mv	a5,a0
   11f80:	0007861b          	sext.w	a2,a5
   11f84:	fc843783          	ld	a5,-56(s0)
   11f88:	0007869b          	sext.w	a3,a5
   11f8c:	fc442783          	lw	a5,-60(s0)
   11f90:	2781                	sext.w	a5,a5
   11f92:	0037979b          	slliw	a5,a5,0x3
   11f96:	2781                	sext.w	a5,a5
   11f98:	873e                	mv	a4,a5
   11f9a:	85ca                	mv	a1,s2
   11f9c:	8526                	mv	a0,s1
   11f9e:	6b7040ef          	jal	ra,16e54 <__xbrtime_put_u4_agg>
   11fa2:	7ad040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   11fa6:	a011                	j	11faa <xbrtime_ulong_put+0xd4>
   11fa8:	0001                	nop
   11faa:	70e2                	ld	ra,56(sp)
   11fac:	7442                	ld	s0,48(sp)
   11fae:	74a2                	ld	s1,40(sp)
   11fb0:	7902                	ld	s2,32(sp)
   11fb2:	6121                	addi	sp,sp,64
   11fb4:	8082                	ret

0000000000011fb6 <xbrtime_ulong_put_nb>:
   11fb6:	7139                	addi	sp,sp,-64
   11fb8:	fc06                	sd	ra,56(sp)
   11fba:	f822                	sd	s0,48(sp)
   11fbc:	f426                	sd	s1,40(sp)
   11fbe:	f04a                	sd	s2,32(sp)
   11fc0:	0080                	addi	s0,sp,64
   11fc2:	fca43c23          	sd	a0,-40(s0)
   11fc6:	fcb43823          	sd	a1,-48(s0)
   11fca:	fcc43423          	sd	a2,-56(s0)
   11fce:	87b6                	mv	a5,a3
   11fd0:	fcf42223          	sw	a5,-60(s0)
   11fd4:	87ba                	mv	a5,a4
   11fd6:	fcf42023          	sw	a5,-64(s0)
   11fda:	fc843783          	ld	a5,-56(s0)
   11fde:	cfdd                	beqz	a5,1209c <xbrtime_ulong_put_nb+0xe6>
   11fe0:	fc442783          	lw	a5,-60(s0)
   11fe4:	0007871b          	sext.w	a4,a5
   11fe8:	4785                	li	a5,1
   11fea:	00f71763          	bne	a4,a5,11ff8 <xbrtime_ulong_put_nb+0x42>
   11fee:	fc843703          	ld	a4,-56(s0)
   11ff2:	4785                	li	a5,1
   11ff4:	04f71b63          	bne	a4,a5,1204a <xbrtime_ulong_put_nb+0x94>
   11ff8:	fd043483          	ld	s1,-48(s0)
   11ffc:	fd843783          	ld	a5,-40(s0)
   12000:	fc042703          	lw	a4,-64(s0)
   12004:	85ba                	mv	a1,a4
   12006:	853e                	mv	a0,a5
   12008:	fffff097          	auipc	ra,0xfffff
   1200c:	812080e7          	jalr	-2030(ra) # 1081a <__xbrtime_ltor>
   12010:	892a                	mv	s2,a0
   12012:	fc042783          	lw	a5,-64(s0)
   12016:	853e                	mv	a0,a5
   12018:	00004097          	auipc	ra,0x4
   1201c:	37a080e7          	jalr	890(ra) # 16392 <xbrtime_decode_pe>
   12020:	87aa                	mv	a5,a0
   12022:	0007861b          	sext.w	a2,a5
   12026:	fc843783          	ld	a5,-56(s0)
   1202a:	0007869b          	sext.w	a3,a5
   1202e:	fc442783          	lw	a5,-60(s0)
   12032:	2781                	sext.w	a5,a5
   12034:	0037979b          	slliw	a5,a5,0x3
   12038:	2781                	sext.w	a5,a5
   1203a:	873e                	mv	a4,a5
   1203c:	85ca                	mv	a1,s2
   1203e:	8526                	mv	a0,s1
   12040:	00005097          	auipc	ra,0x5
   12044:	df8080e7          	jalr	-520(ra) # 16e38 <__xbrtime_put_u4_seq>
   12048:	a899                	j	1209e <xbrtime_ulong_put_nb+0xe8>
   1204a:	fd043483          	ld	s1,-48(s0)
   1204e:	fd843783          	ld	a5,-40(s0)
   12052:	fc042703          	lw	a4,-64(s0)
   12056:	85ba                	mv	a1,a4
   12058:	853e                	mv	a0,a5
   1205a:	ffffe097          	auipc	ra,0xffffe
   1205e:	7c0080e7          	jalr	1984(ra) # 1081a <__xbrtime_ltor>
   12062:	892a                	mv	s2,a0
   12064:	fc042783          	lw	a5,-64(s0)
   12068:	853e                	mv	a0,a5
   1206a:	00004097          	auipc	ra,0x4
   1206e:	328080e7          	jalr	808(ra) # 16392 <xbrtime_decode_pe>
   12072:	87aa                	mv	a5,a0
   12074:	0007861b          	sext.w	a2,a5
   12078:	fc843783          	ld	a5,-56(s0)
   1207c:	0007869b          	sext.w	a3,a5
   12080:	fc442783          	lw	a5,-60(s0)
   12084:	2781                	sext.w	a5,a5
   12086:	0037979b          	slliw	a5,a5,0x3
   1208a:	2781                	sext.w	a5,a5
   1208c:	873e                	mv	a4,a5
   1208e:	85ca                	mv	a1,s2
   12090:	8526                	mv	a0,s1
   12092:	00005097          	auipc	ra,0x5
   12096:	dc2080e7          	jalr	-574(ra) # 16e54 <__xbrtime_put_u4_agg>
   1209a:	a011                	j	1209e <xbrtime_ulong_put_nb+0xe8>
   1209c:	0001                	nop
   1209e:	70e2                	ld	ra,56(sp)
   120a0:	7442                	ld	s0,48(sp)
   120a2:	74a2                	ld	s1,40(sp)
   120a4:	7902                	ld	s2,32(sp)
   120a6:	6121                	addi	sp,sp,64
   120a8:	8082                	ret

00000000000120aa <xbrtime_ulonglong_put>:
   120aa:	7139                	addi	sp,sp,-64
   120ac:	fc06                	sd	ra,56(sp)
   120ae:	f822                	sd	s0,48(sp)
   120b0:	f426                	sd	s1,40(sp)
   120b2:	f04a                	sd	s2,32(sp)
   120b4:	0080                	addi	s0,sp,64
   120b6:	fca43c23          	sd	a0,-40(s0)
   120ba:	fcb43823          	sd	a1,-48(s0)
   120be:	fcc43423          	sd	a2,-56(s0)
   120c2:	87b6                	mv	a5,a3
   120c4:	fcf42223          	sw	a5,-60(s0)
   120c8:	87ba                	mv	a5,a4
   120ca:	fcf42023          	sw	a5,-64(s0)
   120ce:	fc843783          	ld	a5,-56(s0)
   120d2:	c7cd                	beqz	a5,1217c <xbrtime_ulonglong_put+0xd2>
   120d4:	fc442783          	lw	a5,-60(s0)
   120d8:	0007871b          	sext.w	a4,a5
   120dc:	4785                	li	a5,1
   120de:	00f71763          	bne	a4,a5,120ec <xbrtime_ulonglong_put+0x42>
   120e2:	fc843703          	ld	a4,-56(s0)
   120e6:	4785                	li	a5,1
   120e8:	04f71563          	bne	a4,a5,12132 <xbrtime_ulonglong_put+0x88>
   120ec:	fd043483          	ld	s1,-48(s0)
   120f0:	fd843783          	ld	a5,-40(s0)
   120f4:	fc042703          	lw	a4,-64(s0)
   120f8:	85ba                	mv	a1,a4
   120fa:	853e                	mv	a0,a5
   120fc:	f1efe0ef          	jal	ra,1081a <__xbrtime_ltor>
   12100:	892a                	mv	s2,a0
   12102:	fc042783          	lw	a5,-64(s0)
   12106:	853e                	mv	a0,a5
   12108:	28a040ef          	jal	ra,16392 <xbrtime_decode_pe>
   1210c:	87aa                	mv	a5,a0
   1210e:	0007861b          	sext.w	a2,a5
   12112:	fc843783          	ld	a5,-56(s0)
   12116:	0007869b          	sext.w	a3,a5
   1211a:	fc442783          	lw	a5,-60(s0)
   1211e:	2781                	sext.w	a5,a5
   12120:	0037979b          	slliw	a5,a5,0x3
   12124:	2781                	sext.w	a5,a5
   12126:	873e                	mv	a4,a5
   12128:	85ca                	mv	a1,s2
   1212a:	8526                	mv	a0,s1
   1212c:	537040ef          	jal	ra,16e62 <__xbrtime_put_u8_seq>
   12130:	a099                	j	12176 <xbrtime_ulonglong_put+0xcc>
   12132:	fd043483          	ld	s1,-48(s0)
   12136:	fd843783          	ld	a5,-40(s0)
   1213a:	fc042703          	lw	a4,-64(s0)
   1213e:	85ba                	mv	a1,a4
   12140:	853e                	mv	a0,a5
   12142:	ed8fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   12146:	892a                	mv	s2,a0
   12148:	fc042783          	lw	a5,-64(s0)
   1214c:	853e                	mv	a0,a5
   1214e:	244040ef          	jal	ra,16392 <xbrtime_decode_pe>
   12152:	87aa                	mv	a5,a0
   12154:	0007861b          	sext.w	a2,a5
   12158:	fc843783          	ld	a5,-56(s0)
   1215c:	0007869b          	sext.w	a3,a5
   12160:	fc442783          	lw	a5,-60(s0)
   12164:	2781                	sext.w	a5,a5
   12166:	0037979b          	slliw	a5,a5,0x3
   1216a:	2781                	sext.w	a5,a5
   1216c:	873e                	mv	a4,a5
   1216e:	85ca                	mv	a1,s2
   12170:	8526                	mv	a0,s1
   12172:	50d040ef          	jal	ra,16e7e <__xbrtime_put_u8_agg>
   12176:	5d9040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   1217a:	a011                	j	1217e <xbrtime_ulonglong_put+0xd4>
   1217c:	0001                	nop
   1217e:	70e2                	ld	ra,56(sp)
   12180:	7442                	ld	s0,48(sp)
   12182:	74a2                	ld	s1,40(sp)
   12184:	7902                	ld	s2,32(sp)
   12186:	6121                	addi	sp,sp,64
   12188:	8082                	ret

000000000001218a <xbrtime_ulonglong_put_nb>:
   1218a:	7139                	addi	sp,sp,-64
   1218c:	fc06                	sd	ra,56(sp)
   1218e:	f822                	sd	s0,48(sp)
   12190:	f426                	sd	s1,40(sp)
   12192:	f04a                	sd	s2,32(sp)
   12194:	0080                	addi	s0,sp,64
   12196:	fca43c23          	sd	a0,-40(s0)
   1219a:	fcb43823          	sd	a1,-48(s0)
   1219e:	fcc43423          	sd	a2,-56(s0)
   121a2:	87b6                	mv	a5,a3
   121a4:	fcf42223          	sw	a5,-60(s0)
   121a8:	87ba                	mv	a5,a4
   121aa:	fcf42023          	sw	a5,-64(s0)
   121ae:	fc843783          	ld	a5,-56(s0)
   121b2:	cfdd                	beqz	a5,12270 <xbrtime_ulonglong_put_nb+0xe6>
   121b4:	fc442783          	lw	a5,-60(s0)
   121b8:	0007871b          	sext.w	a4,a5
   121bc:	4785                	li	a5,1
   121be:	00f71763          	bne	a4,a5,121cc <xbrtime_ulonglong_put_nb+0x42>
   121c2:	fc843703          	ld	a4,-56(s0)
   121c6:	4785                	li	a5,1
   121c8:	04f71b63          	bne	a4,a5,1221e <xbrtime_ulonglong_put_nb+0x94>
   121cc:	fd043483          	ld	s1,-48(s0)
   121d0:	fd843783          	ld	a5,-40(s0)
   121d4:	fc042703          	lw	a4,-64(s0)
   121d8:	85ba                	mv	a1,a4
   121da:	853e                	mv	a0,a5
   121dc:	ffffe097          	auipc	ra,0xffffe
   121e0:	63e080e7          	jalr	1598(ra) # 1081a <__xbrtime_ltor>
   121e4:	892a                	mv	s2,a0
   121e6:	fc042783          	lw	a5,-64(s0)
   121ea:	853e                	mv	a0,a5
   121ec:	00004097          	auipc	ra,0x4
   121f0:	1a6080e7          	jalr	422(ra) # 16392 <xbrtime_decode_pe>
   121f4:	87aa                	mv	a5,a0
   121f6:	0007861b          	sext.w	a2,a5
   121fa:	fc843783          	ld	a5,-56(s0)
   121fe:	0007869b          	sext.w	a3,a5
   12202:	fc442783          	lw	a5,-60(s0)
   12206:	2781                	sext.w	a5,a5
   12208:	0037979b          	slliw	a5,a5,0x3
   1220c:	2781                	sext.w	a5,a5
   1220e:	873e                	mv	a4,a5
   12210:	85ca                	mv	a1,s2
   12212:	8526                	mv	a0,s1
   12214:	00005097          	auipc	ra,0x5
   12218:	c4e080e7          	jalr	-946(ra) # 16e62 <__xbrtime_put_u8_seq>
   1221c:	a899                	j	12272 <xbrtime_ulonglong_put_nb+0xe8>
   1221e:	fd043483          	ld	s1,-48(s0)
   12222:	fd843783          	ld	a5,-40(s0)
   12226:	fc042703          	lw	a4,-64(s0)
   1222a:	85ba                	mv	a1,a4
   1222c:	853e                	mv	a0,a5
   1222e:	ffffe097          	auipc	ra,0xffffe
   12232:	5ec080e7          	jalr	1516(ra) # 1081a <__xbrtime_ltor>
   12236:	892a                	mv	s2,a0
   12238:	fc042783          	lw	a5,-64(s0)
   1223c:	853e                	mv	a0,a5
   1223e:	00004097          	auipc	ra,0x4
   12242:	154080e7          	jalr	340(ra) # 16392 <xbrtime_decode_pe>
   12246:	87aa                	mv	a5,a0
   12248:	0007861b          	sext.w	a2,a5
   1224c:	fc843783          	ld	a5,-56(s0)
   12250:	0007869b          	sext.w	a3,a5
   12254:	fc442783          	lw	a5,-60(s0)
   12258:	2781                	sext.w	a5,a5
   1225a:	0037979b          	slliw	a5,a5,0x3
   1225e:	2781                	sext.w	a5,a5
   12260:	873e                	mv	a4,a5
   12262:	85ca                	mv	a1,s2
   12264:	8526                	mv	a0,s1
   12266:	00005097          	auipc	ra,0x5
   1226a:	c18080e7          	jalr	-1000(ra) # 16e7e <__xbrtime_put_u8_agg>
   1226e:	a011                	j	12272 <xbrtime_ulonglong_put_nb+0xe8>
   12270:	0001                	nop
   12272:	70e2                	ld	ra,56(sp)
   12274:	7442                	ld	s0,48(sp)
   12276:	74a2                	ld	s1,40(sp)
   12278:	7902                	ld	s2,32(sp)
   1227a:	6121                	addi	sp,sp,64
   1227c:	8082                	ret

000000000001227e <xbrtime_int8_put>:
   1227e:	7139                	addi	sp,sp,-64
   12280:	fc06                	sd	ra,56(sp)
   12282:	f822                	sd	s0,48(sp)
   12284:	f426                	sd	s1,40(sp)
   12286:	f04a                	sd	s2,32(sp)
   12288:	0080                	addi	s0,sp,64
   1228a:	fca43c23          	sd	a0,-40(s0)
   1228e:	fcb43823          	sd	a1,-48(s0)
   12292:	fcc43423          	sd	a2,-56(s0)
   12296:	87b6                	mv	a5,a3
   12298:	fcf42223          	sw	a5,-60(s0)
   1229c:	87ba                	mv	a5,a4
   1229e:	fcf42023          	sw	a5,-64(s0)
   122a2:	fc843783          	ld	a5,-56(s0)
   122a6:	cfc9                	beqz	a5,12340 <xbrtime_int8_put+0xc2>
   122a8:	fc442783          	lw	a5,-60(s0)
   122ac:	0007871b          	sext.w	a4,a5
   122b0:	4785                	li	a5,1
   122b2:	00f71763          	bne	a4,a5,122c0 <xbrtime_int8_put+0x42>
   122b6:	fc843703          	ld	a4,-56(s0)
   122ba:	4785                	li	a5,1
   122bc:	04f71163          	bne	a4,a5,122fe <xbrtime_int8_put+0x80>
   122c0:	fd043483          	ld	s1,-48(s0)
   122c4:	fd843783          	ld	a5,-40(s0)
   122c8:	fc042703          	lw	a4,-64(s0)
   122cc:	85ba                	mv	a1,a4
   122ce:	853e                	mv	a0,a5
   122d0:	d4afe0ef          	jal	ra,1081a <__xbrtime_ltor>
   122d4:	892a                	mv	s2,a0
   122d6:	fc042783          	lw	a5,-64(s0)
   122da:	853e                	mv	a0,a5
   122dc:	0b6040ef          	jal	ra,16392 <xbrtime_decode_pe>
   122e0:	87aa                	mv	a5,a0
   122e2:	2781                	sext.w	a5,a5
   122e4:	fc843703          	ld	a4,-56(s0)
   122e8:	0007069b          	sext.w	a3,a4
   122ec:	fc442703          	lw	a4,-60(s0)
   122f0:	2701                	sext.w	a4,a4
   122f2:	863e                	mv	a2,a5
   122f4:	85ca                	mv	a1,s2
   122f6:	8526                	mv	a0,s1
   122f8:	395040ef          	jal	ra,16e8c <__xbrtime_put_s1_seq>
   122fc:	a83d                	j	1233a <xbrtime_int8_put+0xbc>
   122fe:	fd043483          	ld	s1,-48(s0)
   12302:	fd843783          	ld	a5,-40(s0)
   12306:	fc042703          	lw	a4,-64(s0)
   1230a:	85ba                	mv	a1,a4
   1230c:	853e                	mv	a0,a5
   1230e:	d0cfe0ef          	jal	ra,1081a <__xbrtime_ltor>
   12312:	892a                	mv	s2,a0
   12314:	fc042783          	lw	a5,-64(s0)
   12318:	853e                	mv	a0,a5
   1231a:	078040ef          	jal	ra,16392 <xbrtime_decode_pe>
   1231e:	87aa                	mv	a5,a0
   12320:	2781                	sext.w	a5,a5
   12322:	fc843703          	ld	a4,-56(s0)
   12326:	0007069b          	sext.w	a3,a4
   1232a:	fc442703          	lw	a4,-60(s0)
   1232e:	2701                	sext.w	a4,a4
   12330:	863e                	mv	a2,a5
   12332:	85ca                	mv	a1,s2
   12334:	8526                	mv	a0,s1
   12336:	373040ef          	jal	ra,16ea8 <__xbrtime_put_s1_agg>
   1233a:	415040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   1233e:	a011                	j	12342 <xbrtime_int8_put+0xc4>
   12340:	0001                	nop
   12342:	70e2                	ld	ra,56(sp)
   12344:	7442                	ld	s0,48(sp)
   12346:	74a2                	ld	s1,40(sp)
   12348:	7902                	ld	s2,32(sp)
   1234a:	6121                	addi	sp,sp,64
   1234c:	8082                	ret

000000000001234e <xbrtime_int8_put_nb>:
   1234e:	7139                	addi	sp,sp,-64
   12350:	fc06                	sd	ra,56(sp)
   12352:	f822                	sd	s0,48(sp)
   12354:	f426                	sd	s1,40(sp)
   12356:	f04a                	sd	s2,32(sp)
   12358:	0080                	addi	s0,sp,64
   1235a:	fca43c23          	sd	a0,-40(s0)
   1235e:	fcb43823          	sd	a1,-48(s0)
   12362:	fcc43423          	sd	a2,-56(s0)
   12366:	87b6                	mv	a5,a3
   12368:	fcf42223          	sw	a5,-60(s0)
   1236c:	87ba                	mv	a5,a4
   1236e:	fcf42023          	sw	a5,-64(s0)
   12372:	fc843783          	ld	a5,-56(s0)
   12376:	c7dd                	beqz	a5,12424 <xbrtime_int8_put_nb+0xd6>
   12378:	fc442783          	lw	a5,-60(s0)
   1237c:	0007871b          	sext.w	a4,a5
   12380:	4785                	li	a5,1
   12382:	00f71763          	bne	a4,a5,12390 <xbrtime_int8_put_nb+0x42>
   12386:	fc843703          	ld	a4,-56(s0)
   1238a:	4785                	li	a5,1
   1238c:	04f71763          	bne	a4,a5,123da <xbrtime_int8_put_nb+0x8c>
   12390:	fd043483          	ld	s1,-48(s0)
   12394:	fd843783          	ld	a5,-40(s0)
   12398:	fc042703          	lw	a4,-64(s0)
   1239c:	85ba                	mv	a1,a4
   1239e:	853e                	mv	a0,a5
   123a0:	ffffe097          	auipc	ra,0xffffe
   123a4:	47a080e7          	jalr	1146(ra) # 1081a <__xbrtime_ltor>
   123a8:	892a                	mv	s2,a0
   123aa:	fc042783          	lw	a5,-64(s0)
   123ae:	853e                	mv	a0,a5
   123b0:	00004097          	auipc	ra,0x4
   123b4:	fe2080e7          	jalr	-30(ra) # 16392 <xbrtime_decode_pe>
   123b8:	87aa                	mv	a5,a0
   123ba:	2781                	sext.w	a5,a5
   123bc:	fc843703          	ld	a4,-56(s0)
   123c0:	0007069b          	sext.w	a3,a4
   123c4:	fc442703          	lw	a4,-60(s0)
   123c8:	2701                	sext.w	a4,a4
   123ca:	863e                	mv	a2,a5
   123cc:	85ca                	mv	a1,s2
   123ce:	8526                	mv	a0,s1
   123d0:	00005097          	auipc	ra,0x5
   123d4:	abc080e7          	jalr	-1348(ra) # 16e8c <__xbrtime_put_s1_seq>
   123d8:	a0b9                	j	12426 <xbrtime_int8_put_nb+0xd8>
   123da:	fd043483          	ld	s1,-48(s0)
   123de:	fd843783          	ld	a5,-40(s0)
   123e2:	fc042703          	lw	a4,-64(s0)
   123e6:	85ba                	mv	a1,a4
   123e8:	853e                	mv	a0,a5
   123ea:	ffffe097          	auipc	ra,0xffffe
   123ee:	430080e7          	jalr	1072(ra) # 1081a <__xbrtime_ltor>
   123f2:	892a                	mv	s2,a0
   123f4:	fc042783          	lw	a5,-64(s0)
   123f8:	853e                	mv	a0,a5
   123fa:	00004097          	auipc	ra,0x4
   123fe:	f98080e7          	jalr	-104(ra) # 16392 <xbrtime_decode_pe>
   12402:	87aa                	mv	a5,a0
   12404:	2781                	sext.w	a5,a5
   12406:	fc843703          	ld	a4,-56(s0)
   1240a:	0007069b          	sext.w	a3,a4
   1240e:	fc442703          	lw	a4,-60(s0)
   12412:	2701                	sext.w	a4,a4
   12414:	863e                	mv	a2,a5
   12416:	85ca                	mv	a1,s2
   12418:	8526                	mv	a0,s1
   1241a:	00005097          	auipc	ra,0x5
   1241e:	a8e080e7          	jalr	-1394(ra) # 16ea8 <__xbrtime_put_s1_agg>
   12422:	a011                	j	12426 <xbrtime_int8_put_nb+0xd8>
   12424:	0001                	nop
   12426:	70e2                	ld	ra,56(sp)
   12428:	7442                	ld	s0,48(sp)
   1242a:	74a2                	ld	s1,40(sp)
   1242c:	7902                	ld	s2,32(sp)
   1242e:	6121                	addi	sp,sp,64
   12430:	8082                	ret

0000000000012432 <xbrtime_int16_put>:
   12432:	7139                	addi	sp,sp,-64
   12434:	fc06                	sd	ra,56(sp)
   12436:	f822                	sd	s0,48(sp)
   12438:	f426                	sd	s1,40(sp)
   1243a:	f04a                	sd	s2,32(sp)
   1243c:	0080                	addi	s0,sp,64
   1243e:	fca43c23          	sd	a0,-40(s0)
   12442:	fcb43823          	sd	a1,-48(s0)
   12446:	fcc43423          	sd	a2,-56(s0)
   1244a:	87b6                	mv	a5,a3
   1244c:	fcf42223          	sw	a5,-60(s0)
   12450:	87ba                	mv	a5,a4
   12452:	fcf42023          	sw	a5,-64(s0)
   12456:	fc843783          	ld	a5,-56(s0)
   1245a:	c7cd                	beqz	a5,12504 <xbrtime_int16_put+0xd2>
   1245c:	fc442783          	lw	a5,-60(s0)
   12460:	0007871b          	sext.w	a4,a5
   12464:	4785                	li	a5,1
   12466:	00f71763          	bne	a4,a5,12474 <xbrtime_int16_put+0x42>
   1246a:	fc843703          	ld	a4,-56(s0)
   1246e:	4785                	li	a5,1
   12470:	04f71563          	bne	a4,a5,124ba <xbrtime_int16_put+0x88>
   12474:	fd043483          	ld	s1,-48(s0)
   12478:	fd843783          	ld	a5,-40(s0)
   1247c:	fc042703          	lw	a4,-64(s0)
   12480:	85ba                	mv	a1,a4
   12482:	853e                	mv	a0,a5
   12484:	b96fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   12488:	892a                	mv	s2,a0
   1248a:	fc042783          	lw	a5,-64(s0)
   1248e:	853e                	mv	a0,a5
   12490:	703030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12494:	87aa                	mv	a5,a0
   12496:	0007861b          	sext.w	a2,a5
   1249a:	fc843783          	ld	a5,-56(s0)
   1249e:	0007869b          	sext.w	a3,a5
   124a2:	fc442783          	lw	a5,-60(s0)
   124a6:	2781                	sext.w	a5,a5
   124a8:	0017979b          	slliw	a5,a5,0x1
   124ac:	2781                	sext.w	a5,a5
   124ae:	873e                	mv	a4,a5
   124b0:	85ca                	mv	a1,s2
   124b2:	8526                	mv	a0,s1
   124b4:	203040ef          	jal	ra,16eb6 <__xbrtime_put_s2_seq>
   124b8:	a099                	j	124fe <xbrtime_int16_put+0xcc>
   124ba:	fd043483          	ld	s1,-48(s0)
   124be:	fd843783          	ld	a5,-40(s0)
   124c2:	fc042703          	lw	a4,-64(s0)
   124c6:	85ba                	mv	a1,a4
   124c8:	853e                	mv	a0,a5
   124ca:	b50fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   124ce:	892a                	mv	s2,a0
   124d0:	fc042783          	lw	a5,-64(s0)
   124d4:	853e                	mv	a0,a5
   124d6:	6bd030ef          	jal	ra,16392 <xbrtime_decode_pe>
   124da:	87aa                	mv	a5,a0
   124dc:	0007861b          	sext.w	a2,a5
   124e0:	fc843783          	ld	a5,-56(s0)
   124e4:	0007869b          	sext.w	a3,a5
   124e8:	fc442783          	lw	a5,-60(s0)
   124ec:	2781                	sext.w	a5,a5
   124ee:	0017979b          	slliw	a5,a5,0x1
   124f2:	2781                	sext.w	a5,a5
   124f4:	873e                	mv	a4,a5
   124f6:	85ca                	mv	a1,s2
   124f8:	8526                	mv	a0,s1
   124fa:	1d9040ef          	jal	ra,16ed2 <__xbrtime_put_s2_agg>
   124fe:	251040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   12502:	a011                	j	12506 <xbrtime_int16_put+0xd4>
   12504:	0001                	nop
   12506:	70e2                	ld	ra,56(sp)
   12508:	7442                	ld	s0,48(sp)
   1250a:	74a2                	ld	s1,40(sp)
   1250c:	7902                	ld	s2,32(sp)
   1250e:	6121                	addi	sp,sp,64
   12510:	8082                	ret

0000000000012512 <xbrtime_int16_put_nb>:
   12512:	7139                	addi	sp,sp,-64
   12514:	fc06                	sd	ra,56(sp)
   12516:	f822                	sd	s0,48(sp)
   12518:	f426                	sd	s1,40(sp)
   1251a:	f04a                	sd	s2,32(sp)
   1251c:	0080                	addi	s0,sp,64
   1251e:	fca43c23          	sd	a0,-40(s0)
   12522:	fcb43823          	sd	a1,-48(s0)
   12526:	fcc43423          	sd	a2,-56(s0)
   1252a:	87b6                	mv	a5,a3
   1252c:	fcf42223          	sw	a5,-60(s0)
   12530:	87ba                	mv	a5,a4
   12532:	fcf42023          	sw	a5,-64(s0)
   12536:	fc843783          	ld	a5,-56(s0)
   1253a:	cfdd                	beqz	a5,125f8 <xbrtime_int16_put_nb+0xe6>
   1253c:	fc442783          	lw	a5,-60(s0)
   12540:	0007871b          	sext.w	a4,a5
   12544:	4785                	li	a5,1
   12546:	00f71763          	bne	a4,a5,12554 <xbrtime_int16_put_nb+0x42>
   1254a:	fc843703          	ld	a4,-56(s0)
   1254e:	4785                	li	a5,1
   12550:	04f71b63          	bne	a4,a5,125a6 <xbrtime_int16_put_nb+0x94>
   12554:	fd043483          	ld	s1,-48(s0)
   12558:	fd843783          	ld	a5,-40(s0)
   1255c:	fc042703          	lw	a4,-64(s0)
   12560:	85ba                	mv	a1,a4
   12562:	853e                	mv	a0,a5
   12564:	ffffe097          	auipc	ra,0xffffe
   12568:	2b6080e7          	jalr	694(ra) # 1081a <__xbrtime_ltor>
   1256c:	892a                	mv	s2,a0
   1256e:	fc042783          	lw	a5,-64(s0)
   12572:	853e                	mv	a0,a5
   12574:	00004097          	auipc	ra,0x4
   12578:	e1e080e7          	jalr	-482(ra) # 16392 <xbrtime_decode_pe>
   1257c:	87aa                	mv	a5,a0
   1257e:	0007861b          	sext.w	a2,a5
   12582:	fc843783          	ld	a5,-56(s0)
   12586:	0007869b          	sext.w	a3,a5
   1258a:	fc442783          	lw	a5,-60(s0)
   1258e:	2781                	sext.w	a5,a5
   12590:	0017979b          	slliw	a5,a5,0x1
   12594:	2781                	sext.w	a5,a5
   12596:	873e                	mv	a4,a5
   12598:	85ca                	mv	a1,s2
   1259a:	8526                	mv	a0,s1
   1259c:	00005097          	auipc	ra,0x5
   125a0:	91a080e7          	jalr	-1766(ra) # 16eb6 <__xbrtime_put_s2_seq>
   125a4:	a899                	j	125fa <xbrtime_int16_put_nb+0xe8>
   125a6:	fd043483          	ld	s1,-48(s0)
   125aa:	fd843783          	ld	a5,-40(s0)
   125ae:	fc042703          	lw	a4,-64(s0)
   125b2:	85ba                	mv	a1,a4
   125b4:	853e                	mv	a0,a5
   125b6:	ffffe097          	auipc	ra,0xffffe
   125ba:	264080e7          	jalr	612(ra) # 1081a <__xbrtime_ltor>
   125be:	892a                	mv	s2,a0
   125c0:	fc042783          	lw	a5,-64(s0)
   125c4:	853e                	mv	a0,a5
   125c6:	00004097          	auipc	ra,0x4
   125ca:	dcc080e7          	jalr	-564(ra) # 16392 <xbrtime_decode_pe>
   125ce:	87aa                	mv	a5,a0
   125d0:	0007861b          	sext.w	a2,a5
   125d4:	fc843783          	ld	a5,-56(s0)
   125d8:	0007869b          	sext.w	a3,a5
   125dc:	fc442783          	lw	a5,-60(s0)
   125e0:	2781                	sext.w	a5,a5
   125e2:	0017979b          	slliw	a5,a5,0x1
   125e6:	2781                	sext.w	a5,a5
   125e8:	873e                	mv	a4,a5
   125ea:	85ca                	mv	a1,s2
   125ec:	8526                	mv	a0,s1
   125ee:	00005097          	auipc	ra,0x5
   125f2:	8e4080e7          	jalr	-1820(ra) # 16ed2 <__xbrtime_put_s2_agg>
   125f6:	a011                	j	125fa <xbrtime_int16_put_nb+0xe8>
   125f8:	0001                	nop
   125fa:	70e2                	ld	ra,56(sp)
   125fc:	7442                	ld	s0,48(sp)
   125fe:	74a2                	ld	s1,40(sp)
   12600:	7902                	ld	s2,32(sp)
   12602:	6121                	addi	sp,sp,64
   12604:	8082                	ret

0000000000012606 <xbrtime_int32_put>:
   12606:	7139                	addi	sp,sp,-64
   12608:	fc06                	sd	ra,56(sp)
   1260a:	f822                	sd	s0,48(sp)
   1260c:	f426                	sd	s1,40(sp)
   1260e:	f04a                	sd	s2,32(sp)
   12610:	0080                	addi	s0,sp,64
   12612:	fca43c23          	sd	a0,-40(s0)
   12616:	fcb43823          	sd	a1,-48(s0)
   1261a:	fcc43423          	sd	a2,-56(s0)
   1261e:	87b6                	mv	a5,a3
   12620:	fcf42223          	sw	a5,-60(s0)
   12624:	87ba                	mv	a5,a4
   12626:	fcf42023          	sw	a5,-64(s0)
   1262a:	fc843783          	ld	a5,-56(s0)
   1262e:	c7cd                	beqz	a5,126d8 <xbrtime_int32_put+0xd2>
   12630:	fc442783          	lw	a5,-60(s0)
   12634:	0007871b          	sext.w	a4,a5
   12638:	4785                	li	a5,1
   1263a:	00f71763          	bne	a4,a5,12648 <xbrtime_int32_put+0x42>
   1263e:	fc843703          	ld	a4,-56(s0)
   12642:	4785                	li	a5,1
   12644:	04f71563          	bne	a4,a5,1268e <xbrtime_int32_put+0x88>
   12648:	fd043483          	ld	s1,-48(s0)
   1264c:	fd843783          	ld	a5,-40(s0)
   12650:	fc042703          	lw	a4,-64(s0)
   12654:	85ba                	mv	a1,a4
   12656:	853e                	mv	a0,a5
   12658:	9c2fe0ef          	jal	ra,1081a <__xbrtime_ltor>
   1265c:	892a                	mv	s2,a0
   1265e:	fc042783          	lw	a5,-64(s0)
   12662:	853e                	mv	a0,a5
   12664:	52f030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12668:	87aa                	mv	a5,a0
   1266a:	0007861b          	sext.w	a2,a5
   1266e:	fc843783          	ld	a5,-56(s0)
   12672:	0007869b          	sext.w	a3,a5
   12676:	fc442783          	lw	a5,-60(s0)
   1267a:	2781                	sext.w	a5,a5
   1267c:	0027979b          	slliw	a5,a5,0x2
   12680:	2781                	sext.w	a5,a5
   12682:	873e                	mv	a4,a5
   12684:	85ca                	mv	a1,s2
   12686:	8526                	mv	a0,s1
   12688:	059040ef          	jal	ra,16ee0 <__xbrtime_put_s4_seq>
   1268c:	a099                	j	126d2 <xbrtime_int32_put+0xcc>
   1268e:	fd043483          	ld	s1,-48(s0)
   12692:	fd843783          	ld	a5,-40(s0)
   12696:	fc042703          	lw	a4,-64(s0)
   1269a:	85ba                	mv	a1,a4
   1269c:	853e                	mv	a0,a5
   1269e:	97cfe0ef          	jal	ra,1081a <__xbrtime_ltor>
   126a2:	892a                	mv	s2,a0
   126a4:	fc042783          	lw	a5,-64(s0)
   126a8:	853e                	mv	a0,a5
   126aa:	4e9030ef          	jal	ra,16392 <xbrtime_decode_pe>
   126ae:	87aa                	mv	a5,a0
   126b0:	0007861b          	sext.w	a2,a5
   126b4:	fc843783          	ld	a5,-56(s0)
   126b8:	0007869b          	sext.w	a3,a5
   126bc:	fc442783          	lw	a5,-60(s0)
   126c0:	2781                	sext.w	a5,a5
   126c2:	0027979b          	slliw	a5,a5,0x2
   126c6:	2781                	sext.w	a5,a5
   126c8:	873e                	mv	a4,a5
   126ca:	85ca                	mv	a1,s2
   126cc:	8526                	mv	a0,s1
   126ce:	02f040ef          	jal	ra,16efc <__xbrtime_put_s4_agg>
   126d2:	07d040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   126d6:	a011                	j	126da <xbrtime_int32_put+0xd4>
   126d8:	0001                	nop
   126da:	70e2                	ld	ra,56(sp)
   126dc:	7442                	ld	s0,48(sp)
   126de:	74a2                	ld	s1,40(sp)
   126e0:	7902                	ld	s2,32(sp)
   126e2:	6121                	addi	sp,sp,64
   126e4:	8082                	ret

00000000000126e6 <xbrtime_int32_put_nb>:
   126e6:	7139                	addi	sp,sp,-64
   126e8:	fc06                	sd	ra,56(sp)
   126ea:	f822                	sd	s0,48(sp)
   126ec:	f426                	sd	s1,40(sp)
   126ee:	f04a                	sd	s2,32(sp)
   126f0:	0080                	addi	s0,sp,64
   126f2:	fca43c23          	sd	a0,-40(s0)
   126f6:	fcb43823          	sd	a1,-48(s0)
   126fa:	fcc43423          	sd	a2,-56(s0)
   126fe:	87b6                	mv	a5,a3
   12700:	fcf42223          	sw	a5,-60(s0)
   12704:	87ba                	mv	a5,a4
   12706:	fcf42023          	sw	a5,-64(s0)
   1270a:	fc843783          	ld	a5,-56(s0)
   1270e:	cfdd                	beqz	a5,127cc <xbrtime_int32_put_nb+0xe6>
   12710:	fc442783          	lw	a5,-60(s0)
   12714:	0007871b          	sext.w	a4,a5
   12718:	4785                	li	a5,1
   1271a:	00f71763          	bne	a4,a5,12728 <xbrtime_int32_put_nb+0x42>
   1271e:	fc843703          	ld	a4,-56(s0)
   12722:	4785                	li	a5,1
   12724:	04f71b63          	bne	a4,a5,1277a <xbrtime_int32_put_nb+0x94>
   12728:	fd043483          	ld	s1,-48(s0)
   1272c:	fd843783          	ld	a5,-40(s0)
   12730:	fc042703          	lw	a4,-64(s0)
   12734:	85ba                	mv	a1,a4
   12736:	853e                	mv	a0,a5
   12738:	ffffe097          	auipc	ra,0xffffe
   1273c:	0e2080e7          	jalr	226(ra) # 1081a <__xbrtime_ltor>
   12740:	892a                	mv	s2,a0
   12742:	fc042783          	lw	a5,-64(s0)
   12746:	853e                	mv	a0,a5
   12748:	00004097          	auipc	ra,0x4
   1274c:	c4a080e7          	jalr	-950(ra) # 16392 <xbrtime_decode_pe>
   12750:	87aa                	mv	a5,a0
   12752:	0007861b          	sext.w	a2,a5
   12756:	fc843783          	ld	a5,-56(s0)
   1275a:	0007869b          	sext.w	a3,a5
   1275e:	fc442783          	lw	a5,-60(s0)
   12762:	2781                	sext.w	a5,a5
   12764:	0027979b          	slliw	a5,a5,0x2
   12768:	2781                	sext.w	a5,a5
   1276a:	873e                	mv	a4,a5
   1276c:	85ca                	mv	a1,s2
   1276e:	8526                	mv	a0,s1
   12770:	00004097          	auipc	ra,0x4
   12774:	770080e7          	jalr	1904(ra) # 16ee0 <__xbrtime_put_s4_seq>
   12778:	a899                	j	127ce <xbrtime_int32_put_nb+0xe8>
   1277a:	fd043483          	ld	s1,-48(s0)
   1277e:	fd843783          	ld	a5,-40(s0)
   12782:	fc042703          	lw	a4,-64(s0)
   12786:	85ba                	mv	a1,a4
   12788:	853e                	mv	a0,a5
   1278a:	ffffe097          	auipc	ra,0xffffe
   1278e:	090080e7          	jalr	144(ra) # 1081a <__xbrtime_ltor>
   12792:	892a                	mv	s2,a0
   12794:	fc042783          	lw	a5,-64(s0)
   12798:	853e                	mv	a0,a5
   1279a:	00004097          	auipc	ra,0x4
   1279e:	bf8080e7          	jalr	-1032(ra) # 16392 <xbrtime_decode_pe>
   127a2:	87aa                	mv	a5,a0
   127a4:	0007861b          	sext.w	a2,a5
   127a8:	fc843783          	ld	a5,-56(s0)
   127ac:	0007869b          	sext.w	a3,a5
   127b0:	fc442783          	lw	a5,-60(s0)
   127b4:	2781                	sext.w	a5,a5
   127b6:	0027979b          	slliw	a5,a5,0x2
   127ba:	2781                	sext.w	a5,a5
   127bc:	873e                	mv	a4,a5
   127be:	85ca                	mv	a1,s2
   127c0:	8526                	mv	a0,s1
   127c2:	00004097          	auipc	ra,0x4
   127c6:	73a080e7          	jalr	1850(ra) # 16efc <__xbrtime_put_s4_agg>
   127ca:	a011                	j	127ce <xbrtime_int32_put_nb+0xe8>
   127cc:	0001                	nop
   127ce:	70e2                	ld	ra,56(sp)
   127d0:	7442                	ld	s0,48(sp)
   127d2:	74a2                	ld	s1,40(sp)
   127d4:	7902                	ld	s2,32(sp)
   127d6:	6121                	addi	sp,sp,64
   127d8:	8082                	ret

00000000000127da <xbrtime_int64_put>:
   127da:	7139                	addi	sp,sp,-64
   127dc:	fc06                	sd	ra,56(sp)
   127de:	f822                	sd	s0,48(sp)
   127e0:	f426                	sd	s1,40(sp)
   127e2:	f04a                	sd	s2,32(sp)
   127e4:	0080                	addi	s0,sp,64
   127e6:	fca43c23          	sd	a0,-40(s0)
   127ea:	fcb43823          	sd	a1,-48(s0)
   127ee:	fcc43423          	sd	a2,-56(s0)
   127f2:	87b6                	mv	a5,a3
   127f4:	fcf42223          	sw	a5,-60(s0)
   127f8:	87ba                	mv	a5,a4
   127fa:	fcf42023          	sw	a5,-64(s0)
   127fe:	fc843783          	ld	a5,-56(s0)
   12802:	c7cd                	beqz	a5,128ac <xbrtime_int64_put+0xd2>
   12804:	fc442783          	lw	a5,-60(s0)
   12808:	0007871b          	sext.w	a4,a5
   1280c:	4785                	li	a5,1
   1280e:	00f71763          	bne	a4,a5,1281c <xbrtime_int64_put+0x42>
   12812:	fc843703          	ld	a4,-56(s0)
   12816:	4785                	li	a5,1
   12818:	04f71563          	bne	a4,a5,12862 <xbrtime_int64_put+0x88>
   1281c:	fd043483          	ld	s1,-48(s0)
   12820:	fd843783          	ld	a5,-40(s0)
   12824:	fc042703          	lw	a4,-64(s0)
   12828:	85ba                	mv	a1,a4
   1282a:	853e                	mv	a0,a5
   1282c:	feffd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12830:	892a                	mv	s2,a0
   12832:	fc042783          	lw	a5,-64(s0)
   12836:	853e                	mv	a0,a5
   12838:	35b030ef          	jal	ra,16392 <xbrtime_decode_pe>
   1283c:	87aa                	mv	a5,a0
   1283e:	0007861b          	sext.w	a2,a5
   12842:	fc843783          	ld	a5,-56(s0)
   12846:	0007869b          	sext.w	a3,a5
   1284a:	fc442783          	lw	a5,-60(s0)
   1284e:	2781                	sext.w	a5,a5
   12850:	0037979b          	slliw	a5,a5,0x3
   12854:	2781                	sext.w	a5,a5
   12856:	873e                	mv	a4,a5
   12858:	85ca                	mv	a1,s2
   1285a:	8526                	mv	a0,s1
   1285c:	6ae040ef          	jal	ra,16f0a <__xbrtime_put_s8_seq>
   12860:	a099                	j	128a6 <xbrtime_int64_put+0xcc>
   12862:	fd043483          	ld	s1,-48(s0)
   12866:	fd843783          	ld	a5,-40(s0)
   1286a:	fc042703          	lw	a4,-64(s0)
   1286e:	85ba                	mv	a1,a4
   12870:	853e                	mv	a0,a5
   12872:	fa9fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12876:	892a                	mv	s2,a0
   12878:	fc042783          	lw	a5,-64(s0)
   1287c:	853e                	mv	a0,a5
   1287e:	315030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12882:	87aa                	mv	a5,a0
   12884:	0007861b          	sext.w	a2,a5
   12888:	fc843783          	ld	a5,-56(s0)
   1288c:	0007869b          	sext.w	a3,a5
   12890:	fc442783          	lw	a5,-60(s0)
   12894:	2781                	sext.w	a5,a5
   12896:	0037979b          	slliw	a5,a5,0x3
   1289a:	2781                	sext.w	a5,a5
   1289c:	873e                	mv	a4,a5
   1289e:	85ca                	mv	a1,s2
   128a0:	8526                	mv	a0,s1
   128a2:	684040ef          	jal	ra,16f26 <__xbrtime_put_s8_agg>
   128a6:	6a8040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   128aa:	a011                	j	128ae <xbrtime_int64_put+0xd4>
   128ac:	0001                	nop
   128ae:	70e2                	ld	ra,56(sp)
   128b0:	7442                	ld	s0,48(sp)
   128b2:	74a2                	ld	s1,40(sp)
   128b4:	7902                	ld	s2,32(sp)
   128b6:	6121                	addi	sp,sp,64
   128b8:	8082                	ret

00000000000128ba <xbrtime_int64_put_nb>:
   128ba:	7139                	addi	sp,sp,-64
   128bc:	fc06                	sd	ra,56(sp)
   128be:	f822                	sd	s0,48(sp)
   128c0:	f426                	sd	s1,40(sp)
   128c2:	f04a                	sd	s2,32(sp)
   128c4:	0080                	addi	s0,sp,64
   128c6:	fca43c23          	sd	a0,-40(s0)
   128ca:	fcb43823          	sd	a1,-48(s0)
   128ce:	fcc43423          	sd	a2,-56(s0)
   128d2:	87b6                	mv	a5,a3
   128d4:	fcf42223          	sw	a5,-60(s0)
   128d8:	87ba                	mv	a5,a4
   128da:	fcf42023          	sw	a5,-64(s0)
   128de:	fc843783          	ld	a5,-56(s0)
   128e2:	cfdd                	beqz	a5,129a0 <xbrtime_int64_put_nb+0xe6>
   128e4:	fc442783          	lw	a5,-60(s0)
   128e8:	0007871b          	sext.w	a4,a5
   128ec:	4785                	li	a5,1
   128ee:	00f71763          	bne	a4,a5,128fc <xbrtime_int64_put_nb+0x42>
   128f2:	fc843703          	ld	a4,-56(s0)
   128f6:	4785                	li	a5,1
   128f8:	04f71b63          	bne	a4,a5,1294e <xbrtime_int64_put_nb+0x94>
   128fc:	fd043483          	ld	s1,-48(s0)
   12900:	fd843783          	ld	a5,-40(s0)
   12904:	fc042703          	lw	a4,-64(s0)
   12908:	85ba                	mv	a1,a4
   1290a:	853e                	mv	a0,a5
   1290c:	ffffe097          	auipc	ra,0xffffe
   12910:	f0e080e7          	jalr	-242(ra) # 1081a <__xbrtime_ltor>
   12914:	892a                	mv	s2,a0
   12916:	fc042783          	lw	a5,-64(s0)
   1291a:	853e                	mv	a0,a5
   1291c:	00004097          	auipc	ra,0x4
   12920:	a76080e7          	jalr	-1418(ra) # 16392 <xbrtime_decode_pe>
   12924:	87aa                	mv	a5,a0
   12926:	0007861b          	sext.w	a2,a5
   1292a:	fc843783          	ld	a5,-56(s0)
   1292e:	0007869b          	sext.w	a3,a5
   12932:	fc442783          	lw	a5,-60(s0)
   12936:	2781                	sext.w	a5,a5
   12938:	0037979b          	slliw	a5,a5,0x3
   1293c:	2781                	sext.w	a5,a5
   1293e:	873e                	mv	a4,a5
   12940:	85ca                	mv	a1,s2
   12942:	8526                	mv	a0,s1
   12944:	00004097          	auipc	ra,0x4
   12948:	5c6080e7          	jalr	1478(ra) # 16f0a <__xbrtime_put_s8_seq>
   1294c:	a899                	j	129a2 <xbrtime_int64_put_nb+0xe8>
   1294e:	fd043483          	ld	s1,-48(s0)
   12952:	fd843783          	ld	a5,-40(s0)
   12956:	fc042703          	lw	a4,-64(s0)
   1295a:	85ba                	mv	a1,a4
   1295c:	853e                	mv	a0,a5
   1295e:	ffffe097          	auipc	ra,0xffffe
   12962:	ebc080e7          	jalr	-324(ra) # 1081a <__xbrtime_ltor>
   12966:	892a                	mv	s2,a0
   12968:	fc042783          	lw	a5,-64(s0)
   1296c:	853e                	mv	a0,a5
   1296e:	00004097          	auipc	ra,0x4
   12972:	a24080e7          	jalr	-1500(ra) # 16392 <xbrtime_decode_pe>
   12976:	87aa                	mv	a5,a0
   12978:	0007861b          	sext.w	a2,a5
   1297c:	fc843783          	ld	a5,-56(s0)
   12980:	0007869b          	sext.w	a3,a5
   12984:	fc442783          	lw	a5,-60(s0)
   12988:	2781                	sext.w	a5,a5
   1298a:	0037979b          	slliw	a5,a5,0x3
   1298e:	2781                	sext.w	a5,a5
   12990:	873e                	mv	a4,a5
   12992:	85ca                	mv	a1,s2
   12994:	8526                	mv	a0,s1
   12996:	00004097          	auipc	ra,0x4
   1299a:	590080e7          	jalr	1424(ra) # 16f26 <__xbrtime_put_s8_agg>
   1299e:	a011                	j	129a2 <xbrtime_int64_put_nb+0xe8>
   129a0:	0001                	nop
   129a2:	70e2                	ld	ra,56(sp)
   129a4:	7442                	ld	s0,48(sp)
   129a6:	74a2                	ld	s1,40(sp)
   129a8:	7902                	ld	s2,32(sp)
   129aa:	6121                	addi	sp,sp,64
   129ac:	8082                	ret

00000000000129ae <xbrtime_uint8_put>:
   129ae:	7139                	addi	sp,sp,-64
   129b0:	fc06                	sd	ra,56(sp)
   129b2:	f822                	sd	s0,48(sp)
   129b4:	f426                	sd	s1,40(sp)
   129b6:	f04a                	sd	s2,32(sp)
   129b8:	0080                	addi	s0,sp,64
   129ba:	fca43c23          	sd	a0,-40(s0)
   129be:	fcb43823          	sd	a1,-48(s0)
   129c2:	fcc43423          	sd	a2,-56(s0)
   129c6:	87b6                	mv	a5,a3
   129c8:	fcf42223          	sw	a5,-60(s0)
   129cc:	87ba                	mv	a5,a4
   129ce:	fcf42023          	sw	a5,-64(s0)
   129d2:	fc843783          	ld	a5,-56(s0)
   129d6:	cfc9                	beqz	a5,12a70 <xbrtime_uint8_put+0xc2>
   129d8:	fc442783          	lw	a5,-60(s0)
   129dc:	0007871b          	sext.w	a4,a5
   129e0:	4785                	li	a5,1
   129e2:	00f71763          	bne	a4,a5,129f0 <xbrtime_uint8_put+0x42>
   129e6:	fc843703          	ld	a4,-56(s0)
   129ea:	4785                	li	a5,1
   129ec:	04f71163          	bne	a4,a5,12a2e <xbrtime_uint8_put+0x80>
   129f0:	fd043483          	ld	s1,-48(s0)
   129f4:	fd843783          	ld	a5,-40(s0)
   129f8:	fc042703          	lw	a4,-64(s0)
   129fc:	85ba                	mv	a1,a4
   129fe:	853e                	mv	a0,a5
   12a00:	e1bfd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12a04:	892a                	mv	s2,a0
   12a06:	fc042783          	lw	a5,-64(s0)
   12a0a:	853e                	mv	a0,a5
   12a0c:	187030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12a10:	87aa                	mv	a5,a0
   12a12:	2781                	sext.w	a5,a5
   12a14:	fc843703          	ld	a4,-56(s0)
   12a18:	0007069b          	sext.w	a3,a4
   12a1c:	fc442703          	lw	a4,-60(s0)
   12a20:	2701                	sext.w	a4,a4
   12a22:	863e                	mv	a2,a5
   12a24:	85ca                	mv	a1,s2
   12a26:	8526                	mv	a0,s1
   12a28:	3bc040ef          	jal	ra,16de4 <__xbrtime_put_u1_seq>
   12a2c:	a83d                	j	12a6a <xbrtime_uint8_put+0xbc>
   12a2e:	fd043483          	ld	s1,-48(s0)
   12a32:	fd843783          	ld	a5,-40(s0)
   12a36:	fc042703          	lw	a4,-64(s0)
   12a3a:	85ba                	mv	a1,a4
   12a3c:	853e                	mv	a0,a5
   12a3e:	dddfd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12a42:	892a                	mv	s2,a0
   12a44:	fc042783          	lw	a5,-64(s0)
   12a48:	853e                	mv	a0,a5
   12a4a:	149030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12a4e:	87aa                	mv	a5,a0
   12a50:	2781                	sext.w	a5,a5
   12a52:	fc843703          	ld	a4,-56(s0)
   12a56:	0007069b          	sext.w	a3,a4
   12a5a:	fc442703          	lw	a4,-60(s0)
   12a5e:	2701                	sext.w	a4,a4
   12a60:	863e                	mv	a2,a5
   12a62:	85ca                	mv	a1,s2
   12a64:	8526                	mv	a0,s1
   12a66:	39a040ef          	jal	ra,16e00 <__xbrtime_put_u1_agg>
   12a6a:	4e4040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   12a6e:	a011                	j	12a72 <xbrtime_uint8_put+0xc4>
   12a70:	0001                	nop
   12a72:	70e2                	ld	ra,56(sp)
   12a74:	7442                	ld	s0,48(sp)
   12a76:	74a2                	ld	s1,40(sp)
   12a78:	7902                	ld	s2,32(sp)
   12a7a:	6121                	addi	sp,sp,64
   12a7c:	8082                	ret

0000000000012a7e <xbrtime_uint8_put_nb>:
   12a7e:	7139                	addi	sp,sp,-64
   12a80:	fc06                	sd	ra,56(sp)
   12a82:	f822                	sd	s0,48(sp)
   12a84:	f426                	sd	s1,40(sp)
   12a86:	f04a                	sd	s2,32(sp)
   12a88:	0080                	addi	s0,sp,64
   12a8a:	fca43c23          	sd	a0,-40(s0)
   12a8e:	fcb43823          	sd	a1,-48(s0)
   12a92:	fcc43423          	sd	a2,-56(s0)
   12a96:	87b6                	mv	a5,a3
   12a98:	fcf42223          	sw	a5,-60(s0)
   12a9c:	87ba                	mv	a5,a4
   12a9e:	fcf42023          	sw	a5,-64(s0)
   12aa2:	fc843783          	ld	a5,-56(s0)
   12aa6:	c7dd                	beqz	a5,12b54 <xbrtime_uint8_put_nb+0xd6>
   12aa8:	fc442783          	lw	a5,-60(s0)
   12aac:	0007871b          	sext.w	a4,a5
   12ab0:	4785                	li	a5,1
   12ab2:	00f71763          	bne	a4,a5,12ac0 <xbrtime_uint8_put_nb+0x42>
   12ab6:	fc843703          	ld	a4,-56(s0)
   12aba:	4785                	li	a5,1
   12abc:	04f71763          	bne	a4,a5,12b0a <xbrtime_uint8_put_nb+0x8c>
   12ac0:	fd043483          	ld	s1,-48(s0)
   12ac4:	fd843783          	ld	a5,-40(s0)
   12ac8:	fc042703          	lw	a4,-64(s0)
   12acc:	85ba                	mv	a1,a4
   12ace:	853e                	mv	a0,a5
   12ad0:	ffffe097          	auipc	ra,0xffffe
   12ad4:	d4a080e7          	jalr	-694(ra) # 1081a <__xbrtime_ltor>
   12ad8:	892a                	mv	s2,a0
   12ada:	fc042783          	lw	a5,-64(s0)
   12ade:	853e                	mv	a0,a5
   12ae0:	00004097          	auipc	ra,0x4
   12ae4:	8b2080e7          	jalr	-1870(ra) # 16392 <xbrtime_decode_pe>
   12ae8:	87aa                	mv	a5,a0
   12aea:	2781                	sext.w	a5,a5
   12aec:	fc843703          	ld	a4,-56(s0)
   12af0:	0007069b          	sext.w	a3,a4
   12af4:	fc442703          	lw	a4,-60(s0)
   12af8:	2701                	sext.w	a4,a4
   12afa:	863e                	mv	a2,a5
   12afc:	85ca                	mv	a1,s2
   12afe:	8526                	mv	a0,s1
   12b00:	00004097          	auipc	ra,0x4
   12b04:	2e4080e7          	jalr	740(ra) # 16de4 <__xbrtime_put_u1_seq>
   12b08:	a0b9                	j	12b56 <xbrtime_uint8_put_nb+0xd8>
   12b0a:	fd043483          	ld	s1,-48(s0)
   12b0e:	fd843783          	ld	a5,-40(s0)
   12b12:	fc042703          	lw	a4,-64(s0)
   12b16:	85ba                	mv	a1,a4
   12b18:	853e                	mv	a0,a5
   12b1a:	ffffe097          	auipc	ra,0xffffe
   12b1e:	d00080e7          	jalr	-768(ra) # 1081a <__xbrtime_ltor>
   12b22:	892a                	mv	s2,a0
   12b24:	fc042783          	lw	a5,-64(s0)
   12b28:	853e                	mv	a0,a5
   12b2a:	00004097          	auipc	ra,0x4
   12b2e:	868080e7          	jalr	-1944(ra) # 16392 <xbrtime_decode_pe>
   12b32:	87aa                	mv	a5,a0
   12b34:	2781                	sext.w	a5,a5
   12b36:	fc843703          	ld	a4,-56(s0)
   12b3a:	0007069b          	sext.w	a3,a4
   12b3e:	fc442703          	lw	a4,-60(s0)
   12b42:	2701                	sext.w	a4,a4
   12b44:	863e                	mv	a2,a5
   12b46:	85ca                	mv	a1,s2
   12b48:	8526                	mv	a0,s1
   12b4a:	00004097          	auipc	ra,0x4
   12b4e:	2b6080e7          	jalr	694(ra) # 16e00 <__xbrtime_put_u1_agg>
   12b52:	a011                	j	12b56 <xbrtime_uint8_put_nb+0xd8>
   12b54:	0001                	nop
   12b56:	70e2                	ld	ra,56(sp)
   12b58:	7442                	ld	s0,48(sp)
   12b5a:	74a2                	ld	s1,40(sp)
   12b5c:	7902                	ld	s2,32(sp)
   12b5e:	6121                	addi	sp,sp,64
   12b60:	8082                	ret

0000000000012b62 <xbrtime_uint16_put>:
   12b62:	7139                	addi	sp,sp,-64
   12b64:	fc06                	sd	ra,56(sp)
   12b66:	f822                	sd	s0,48(sp)
   12b68:	f426                	sd	s1,40(sp)
   12b6a:	f04a                	sd	s2,32(sp)
   12b6c:	0080                	addi	s0,sp,64
   12b6e:	fca43c23          	sd	a0,-40(s0)
   12b72:	fcb43823          	sd	a1,-48(s0)
   12b76:	fcc43423          	sd	a2,-56(s0)
   12b7a:	87b6                	mv	a5,a3
   12b7c:	fcf42223          	sw	a5,-60(s0)
   12b80:	87ba                	mv	a5,a4
   12b82:	fcf42023          	sw	a5,-64(s0)
   12b86:	fc843783          	ld	a5,-56(s0)
   12b8a:	c7cd                	beqz	a5,12c34 <xbrtime_uint16_put+0xd2>
   12b8c:	fc442783          	lw	a5,-60(s0)
   12b90:	0007871b          	sext.w	a4,a5
   12b94:	4785                	li	a5,1
   12b96:	00f71763          	bne	a4,a5,12ba4 <xbrtime_uint16_put+0x42>
   12b9a:	fc843703          	ld	a4,-56(s0)
   12b9e:	4785                	li	a5,1
   12ba0:	04f71563          	bne	a4,a5,12bea <xbrtime_uint16_put+0x88>
   12ba4:	fd043483          	ld	s1,-48(s0)
   12ba8:	fd843783          	ld	a5,-40(s0)
   12bac:	fc042703          	lw	a4,-64(s0)
   12bb0:	85ba                	mv	a1,a4
   12bb2:	853e                	mv	a0,a5
   12bb4:	c67fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12bb8:	892a                	mv	s2,a0
   12bba:	fc042783          	lw	a5,-64(s0)
   12bbe:	853e                	mv	a0,a5
   12bc0:	7d2030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12bc4:	87aa                	mv	a5,a0
   12bc6:	0007861b          	sext.w	a2,a5
   12bca:	fc843783          	ld	a5,-56(s0)
   12bce:	0007869b          	sext.w	a3,a5
   12bd2:	fc442783          	lw	a5,-60(s0)
   12bd6:	2781                	sext.w	a5,a5
   12bd8:	0017979b          	slliw	a5,a5,0x1
   12bdc:	2781                	sext.w	a5,a5
   12bde:	873e                	mv	a4,a5
   12be0:	85ca                	mv	a1,s2
   12be2:	8526                	mv	a0,s1
   12be4:	22a040ef          	jal	ra,16e0e <__xbrtime_put_u2_seq>
   12be8:	a099                	j	12c2e <xbrtime_uint16_put+0xcc>
   12bea:	fd043483          	ld	s1,-48(s0)
   12bee:	fd843783          	ld	a5,-40(s0)
   12bf2:	fc042703          	lw	a4,-64(s0)
   12bf6:	85ba                	mv	a1,a4
   12bf8:	853e                	mv	a0,a5
   12bfa:	c21fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12bfe:	892a                	mv	s2,a0
   12c00:	fc042783          	lw	a5,-64(s0)
   12c04:	853e                	mv	a0,a5
   12c06:	78c030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12c0a:	87aa                	mv	a5,a0
   12c0c:	0007861b          	sext.w	a2,a5
   12c10:	fc843783          	ld	a5,-56(s0)
   12c14:	0007869b          	sext.w	a3,a5
   12c18:	fc442783          	lw	a5,-60(s0)
   12c1c:	2781                	sext.w	a5,a5
   12c1e:	0017979b          	slliw	a5,a5,0x1
   12c22:	2781                	sext.w	a5,a5
   12c24:	873e                	mv	a4,a5
   12c26:	85ca                	mv	a1,s2
   12c28:	8526                	mv	a0,s1
   12c2a:	200040ef          	jal	ra,16e2a <__xbrtime_put_u2_agg>
   12c2e:	320040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   12c32:	a011                	j	12c36 <xbrtime_uint16_put+0xd4>
   12c34:	0001                	nop
   12c36:	70e2                	ld	ra,56(sp)
   12c38:	7442                	ld	s0,48(sp)
   12c3a:	74a2                	ld	s1,40(sp)
   12c3c:	7902                	ld	s2,32(sp)
   12c3e:	6121                	addi	sp,sp,64
   12c40:	8082                	ret

0000000000012c42 <xbrtime_uint16_put_nb>:
   12c42:	7139                	addi	sp,sp,-64
   12c44:	fc06                	sd	ra,56(sp)
   12c46:	f822                	sd	s0,48(sp)
   12c48:	f426                	sd	s1,40(sp)
   12c4a:	f04a                	sd	s2,32(sp)
   12c4c:	0080                	addi	s0,sp,64
   12c4e:	fca43c23          	sd	a0,-40(s0)
   12c52:	fcb43823          	sd	a1,-48(s0)
   12c56:	fcc43423          	sd	a2,-56(s0)
   12c5a:	87b6                	mv	a5,a3
   12c5c:	fcf42223          	sw	a5,-60(s0)
   12c60:	87ba                	mv	a5,a4
   12c62:	fcf42023          	sw	a5,-64(s0)
   12c66:	fc843783          	ld	a5,-56(s0)
   12c6a:	cfdd                	beqz	a5,12d28 <xbrtime_uint16_put_nb+0xe6>
   12c6c:	fc442783          	lw	a5,-60(s0)
   12c70:	0007871b          	sext.w	a4,a5
   12c74:	4785                	li	a5,1
   12c76:	00f71763          	bne	a4,a5,12c84 <xbrtime_uint16_put_nb+0x42>
   12c7a:	fc843703          	ld	a4,-56(s0)
   12c7e:	4785                	li	a5,1
   12c80:	04f71b63          	bne	a4,a5,12cd6 <xbrtime_uint16_put_nb+0x94>
   12c84:	fd043483          	ld	s1,-48(s0)
   12c88:	fd843783          	ld	a5,-40(s0)
   12c8c:	fc042703          	lw	a4,-64(s0)
   12c90:	85ba                	mv	a1,a4
   12c92:	853e                	mv	a0,a5
   12c94:	ffffe097          	auipc	ra,0xffffe
   12c98:	b86080e7          	jalr	-1146(ra) # 1081a <__xbrtime_ltor>
   12c9c:	892a                	mv	s2,a0
   12c9e:	fc042783          	lw	a5,-64(s0)
   12ca2:	853e                	mv	a0,a5
   12ca4:	00003097          	auipc	ra,0x3
   12ca8:	6ee080e7          	jalr	1774(ra) # 16392 <xbrtime_decode_pe>
   12cac:	87aa                	mv	a5,a0
   12cae:	0007861b          	sext.w	a2,a5
   12cb2:	fc843783          	ld	a5,-56(s0)
   12cb6:	0007869b          	sext.w	a3,a5
   12cba:	fc442783          	lw	a5,-60(s0)
   12cbe:	2781                	sext.w	a5,a5
   12cc0:	0017979b          	slliw	a5,a5,0x1
   12cc4:	2781                	sext.w	a5,a5
   12cc6:	873e                	mv	a4,a5
   12cc8:	85ca                	mv	a1,s2
   12cca:	8526                	mv	a0,s1
   12ccc:	00004097          	auipc	ra,0x4
   12cd0:	142080e7          	jalr	322(ra) # 16e0e <__xbrtime_put_u2_seq>
   12cd4:	a899                	j	12d2a <xbrtime_uint16_put_nb+0xe8>
   12cd6:	fd043483          	ld	s1,-48(s0)
   12cda:	fd843783          	ld	a5,-40(s0)
   12cde:	fc042703          	lw	a4,-64(s0)
   12ce2:	85ba                	mv	a1,a4
   12ce4:	853e                	mv	a0,a5
   12ce6:	ffffe097          	auipc	ra,0xffffe
   12cea:	b34080e7          	jalr	-1228(ra) # 1081a <__xbrtime_ltor>
   12cee:	892a                	mv	s2,a0
   12cf0:	fc042783          	lw	a5,-64(s0)
   12cf4:	853e                	mv	a0,a5
   12cf6:	00003097          	auipc	ra,0x3
   12cfa:	69c080e7          	jalr	1692(ra) # 16392 <xbrtime_decode_pe>
   12cfe:	87aa                	mv	a5,a0
   12d00:	0007861b          	sext.w	a2,a5
   12d04:	fc843783          	ld	a5,-56(s0)
   12d08:	0007869b          	sext.w	a3,a5
   12d0c:	fc442783          	lw	a5,-60(s0)
   12d10:	2781                	sext.w	a5,a5
   12d12:	0017979b          	slliw	a5,a5,0x1
   12d16:	2781                	sext.w	a5,a5
   12d18:	873e                	mv	a4,a5
   12d1a:	85ca                	mv	a1,s2
   12d1c:	8526                	mv	a0,s1
   12d1e:	00004097          	auipc	ra,0x4
   12d22:	10c080e7          	jalr	268(ra) # 16e2a <__xbrtime_put_u2_agg>
   12d26:	a011                	j	12d2a <xbrtime_uint16_put_nb+0xe8>
   12d28:	0001                	nop
   12d2a:	70e2                	ld	ra,56(sp)
   12d2c:	7442                	ld	s0,48(sp)
   12d2e:	74a2                	ld	s1,40(sp)
   12d30:	7902                	ld	s2,32(sp)
   12d32:	6121                	addi	sp,sp,64
   12d34:	8082                	ret

0000000000012d36 <xbrtime_uint32_put>:
   12d36:	7139                	addi	sp,sp,-64
   12d38:	fc06                	sd	ra,56(sp)
   12d3a:	f822                	sd	s0,48(sp)
   12d3c:	f426                	sd	s1,40(sp)
   12d3e:	f04a                	sd	s2,32(sp)
   12d40:	0080                	addi	s0,sp,64
   12d42:	fca43c23          	sd	a0,-40(s0)
   12d46:	fcb43823          	sd	a1,-48(s0)
   12d4a:	fcc43423          	sd	a2,-56(s0)
   12d4e:	87b6                	mv	a5,a3
   12d50:	fcf42223          	sw	a5,-60(s0)
   12d54:	87ba                	mv	a5,a4
   12d56:	fcf42023          	sw	a5,-64(s0)
   12d5a:	fc843783          	ld	a5,-56(s0)
   12d5e:	c7cd                	beqz	a5,12e08 <xbrtime_uint32_put+0xd2>
   12d60:	fc442783          	lw	a5,-60(s0)
   12d64:	0007871b          	sext.w	a4,a5
   12d68:	4785                	li	a5,1
   12d6a:	00f71763          	bne	a4,a5,12d78 <xbrtime_uint32_put+0x42>
   12d6e:	fc843703          	ld	a4,-56(s0)
   12d72:	4785                	li	a5,1
   12d74:	04f71563          	bne	a4,a5,12dbe <xbrtime_uint32_put+0x88>
   12d78:	fd043483          	ld	s1,-48(s0)
   12d7c:	fd843783          	ld	a5,-40(s0)
   12d80:	fc042703          	lw	a4,-64(s0)
   12d84:	85ba                	mv	a1,a4
   12d86:	853e                	mv	a0,a5
   12d88:	a93fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12d8c:	892a                	mv	s2,a0
   12d8e:	fc042783          	lw	a5,-64(s0)
   12d92:	853e                	mv	a0,a5
   12d94:	5fe030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12d98:	87aa                	mv	a5,a0
   12d9a:	0007861b          	sext.w	a2,a5
   12d9e:	fc843783          	ld	a5,-56(s0)
   12da2:	0007869b          	sext.w	a3,a5
   12da6:	fc442783          	lw	a5,-60(s0)
   12daa:	2781                	sext.w	a5,a5
   12dac:	0027979b          	slliw	a5,a5,0x2
   12db0:	2781                	sext.w	a5,a5
   12db2:	873e                	mv	a4,a5
   12db4:	85ca                	mv	a1,s2
   12db6:	8526                	mv	a0,s1
   12db8:	080040ef          	jal	ra,16e38 <__xbrtime_put_u4_seq>
   12dbc:	a099                	j	12e02 <xbrtime_uint32_put+0xcc>
   12dbe:	fd043483          	ld	s1,-48(s0)
   12dc2:	fd843783          	ld	a5,-40(s0)
   12dc6:	fc042703          	lw	a4,-64(s0)
   12dca:	85ba                	mv	a1,a4
   12dcc:	853e                	mv	a0,a5
   12dce:	a4dfd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12dd2:	892a                	mv	s2,a0
   12dd4:	fc042783          	lw	a5,-64(s0)
   12dd8:	853e                	mv	a0,a5
   12dda:	5b8030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12dde:	87aa                	mv	a5,a0
   12de0:	0007861b          	sext.w	a2,a5
   12de4:	fc843783          	ld	a5,-56(s0)
   12de8:	0007869b          	sext.w	a3,a5
   12dec:	fc442783          	lw	a5,-60(s0)
   12df0:	2781                	sext.w	a5,a5
   12df2:	0027979b          	slliw	a5,a5,0x2
   12df6:	2781                	sext.w	a5,a5
   12df8:	873e                	mv	a4,a5
   12dfa:	85ca                	mv	a1,s2
   12dfc:	8526                	mv	a0,s1
   12dfe:	056040ef          	jal	ra,16e54 <__xbrtime_put_u4_agg>
   12e02:	14c040ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   12e06:	a011                	j	12e0a <xbrtime_uint32_put+0xd4>
   12e08:	0001                	nop
   12e0a:	70e2                	ld	ra,56(sp)
   12e0c:	7442                	ld	s0,48(sp)
   12e0e:	74a2                	ld	s1,40(sp)
   12e10:	7902                	ld	s2,32(sp)
   12e12:	6121                	addi	sp,sp,64
   12e14:	8082                	ret

0000000000012e16 <xbrtime_uint32_put_nb>:
   12e16:	7139                	addi	sp,sp,-64
   12e18:	fc06                	sd	ra,56(sp)
   12e1a:	f822                	sd	s0,48(sp)
   12e1c:	f426                	sd	s1,40(sp)
   12e1e:	f04a                	sd	s2,32(sp)
   12e20:	0080                	addi	s0,sp,64
   12e22:	fca43c23          	sd	a0,-40(s0)
   12e26:	fcb43823          	sd	a1,-48(s0)
   12e2a:	fcc43423          	sd	a2,-56(s0)
   12e2e:	87b6                	mv	a5,a3
   12e30:	fcf42223          	sw	a5,-60(s0)
   12e34:	87ba                	mv	a5,a4
   12e36:	fcf42023          	sw	a5,-64(s0)
   12e3a:	fc843783          	ld	a5,-56(s0)
   12e3e:	cfdd                	beqz	a5,12efc <xbrtime_uint32_put_nb+0xe6>
   12e40:	fc442783          	lw	a5,-60(s0)
   12e44:	0007871b          	sext.w	a4,a5
   12e48:	4785                	li	a5,1
   12e4a:	00f71763          	bne	a4,a5,12e58 <xbrtime_uint32_put_nb+0x42>
   12e4e:	fc843703          	ld	a4,-56(s0)
   12e52:	4785                	li	a5,1
   12e54:	04f71b63          	bne	a4,a5,12eaa <xbrtime_uint32_put_nb+0x94>
   12e58:	fd043483          	ld	s1,-48(s0)
   12e5c:	fd843783          	ld	a5,-40(s0)
   12e60:	fc042703          	lw	a4,-64(s0)
   12e64:	85ba                	mv	a1,a4
   12e66:	853e                	mv	a0,a5
   12e68:	ffffe097          	auipc	ra,0xffffe
   12e6c:	9b2080e7          	jalr	-1614(ra) # 1081a <__xbrtime_ltor>
   12e70:	892a                	mv	s2,a0
   12e72:	fc042783          	lw	a5,-64(s0)
   12e76:	853e                	mv	a0,a5
   12e78:	00003097          	auipc	ra,0x3
   12e7c:	51a080e7          	jalr	1306(ra) # 16392 <xbrtime_decode_pe>
   12e80:	87aa                	mv	a5,a0
   12e82:	0007861b          	sext.w	a2,a5
   12e86:	fc843783          	ld	a5,-56(s0)
   12e8a:	0007869b          	sext.w	a3,a5
   12e8e:	fc442783          	lw	a5,-60(s0)
   12e92:	2781                	sext.w	a5,a5
   12e94:	0027979b          	slliw	a5,a5,0x2
   12e98:	2781                	sext.w	a5,a5
   12e9a:	873e                	mv	a4,a5
   12e9c:	85ca                	mv	a1,s2
   12e9e:	8526                	mv	a0,s1
   12ea0:	00004097          	auipc	ra,0x4
   12ea4:	f98080e7          	jalr	-104(ra) # 16e38 <__xbrtime_put_u4_seq>
   12ea8:	a899                	j	12efe <xbrtime_uint32_put_nb+0xe8>
   12eaa:	fd043483          	ld	s1,-48(s0)
   12eae:	fd843783          	ld	a5,-40(s0)
   12eb2:	fc042703          	lw	a4,-64(s0)
   12eb6:	85ba                	mv	a1,a4
   12eb8:	853e                	mv	a0,a5
   12eba:	ffffe097          	auipc	ra,0xffffe
   12ebe:	960080e7          	jalr	-1696(ra) # 1081a <__xbrtime_ltor>
   12ec2:	892a                	mv	s2,a0
   12ec4:	fc042783          	lw	a5,-64(s0)
   12ec8:	853e                	mv	a0,a5
   12eca:	00003097          	auipc	ra,0x3
   12ece:	4c8080e7          	jalr	1224(ra) # 16392 <xbrtime_decode_pe>
   12ed2:	87aa                	mv	a5,a0
   12ed4:	0007861b          	sext.w	a2,a5
   12ed8:	fc843783          	ld	a5,-56(s0)
   12edc:	0007869b          	sext.w	a3,a5
   12ee0:	fc442783          	lw	a5,-60(s0)
   12ee4:	2781                	sext.w	a5,a5
   12ee6:	0027979b          	slliw	a5,a5,0x2
   12eea:	2781                	sext.w	a5,a5
   12eec:	873e                	mv	a4,a5
   12eee:	85ca                	mv	a1,s2
   12ef0:	8526                	mv	a0,s1
   12ef2:	00004097          	auipc	ra,0x4
   12ef6:	f62080e7          	jalr	-158(ra) # 16e54 <__xbrtime_put_u4_agg>
   12efa:	a011                	j	12efe <xbrtime_uint32_put_nb+0xe8>
   12efc:	0001                	nop
   12efe:	70e2                	ld	ra,56(sp)
   12f00:	7442                	ld	s0,48(sp)
   12f02:	74a2                	ld	s1,40(sp)
   12f04:	7902                	ld	s2,32(sp)
   12f06:	6121                	addi	sp,sp,64
   12f08:	8082                	ret

0000000000012f0a <xbrtime_uint64_put>:
   12f0a:	7139                	addi	sp,sp,-64
   12f0c:	fc06                	sd	ra,56(sp)
   12f0e:	f822                	sd	s0,48(sp)
   12f10:	f426                	sd	s1,40(sp)
   12f12:	f04a                	sd	s2,32(sp)
   12f14:	0080                	addi	s0,sp,64
   12f16:	fca43c23          	sd	a0,-40(s0)
   12f1a:	fcb43823          	sd	a1,-48(s0)
   12f1e:	fcc43423          	sd	a2,-56(s0)
   12f22:	87b6                	mv	a5,a3
   12f24:	fcf42223          	sw	a5,-60(s0)
   12f28:	87ba                	mv	a5,a4
   12f2a:	fcf42023          	sw	a5,-64(s0)
   12f2e:	fc843783          	ld	a5,-56(s0)
   12f32:	c7cd                	beqz	a5,12fdc <xbrtime_uint64_put+0xd2>
   12f34:	fc442783          	lw	a5,-60(s0)
   12f38:	0007871b          	sext.w	a4,a5
   12f3c:	4785                	li	a5,1
   12f3e:	00f71763          	bne	a4,a5,12f4c <xbrtime_uint64_put+0x42>
   12f42:	fc843703          	ld	a4,-56(s0)
   12f46:	4785                	li	a5,1
   12f48:	04f71563          	bne	a4,a5,12f92 <xbrtime_uint64_put+0x88>
   12f4c:	fd043483          	ld	s1,-48(s0)
   12f50:	fd843783          	ld	a5,-40(s0)
   12f54:	fc042703          	lw	a4,-64(s0)
   12f58:	85ba                	mv	a1,a4
   12f5a:	853e                	mv	a0,a5
   12f5c:	8bffd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12f60:	892a                	mv	s2,a0
   12f62:	fc042783          	lw	a5,-64(s0)
   12f66:	853e                	mv	a0,a5
   12f68:	42a030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12f6c:	87aa                	mv	a5,a0
   12f6e:	0007861b          	sext.w	a2,a5
   12f72:	fc843783          	ld	a5,-56(s0)
   12f76:	0007869b          	sext.w	a3,a5
   12f7a:	fc442783          	lw	a5,-60(s0)
   12f7e:	2781                	sext.w	a5,a5
   12f80:	0037979b          	slliw	a5,a5,0x3
   12f84:	2781                	sext.w	a5,a5
   12f86:	873e                	mv	a4,a5
   12f88:	85ca                	mv	a1,s2
   12f8a:	8526                	mv	a0,s1
   12f8c:	6d7030ef          	jal	ra,16e62 <__xbrtime_put_u8_seq>
   12f90:	a099                	j	12fd6 <xbrtime_uint64_put+0xcc>
   12f92:	fd043483          	ld	s1,-48(s0)
   12f96:	fd843783          	ld	a5,-40(s0)
   12f9a:	fc042703          	lw	a4,-64(s0)
   12f9e:	85ba                	mv	a1,a4
   12fa0:	853e                	mv	a0,a5
   12fa2:	879fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   12fa6:	892a                	mv	s2,a0
   12fa8:	fc042783          	lw	a5,-64(s0)
   12fac:	853e                	mv	a0,a5
   12fae:	3e4030ef          	jal	ra,16392 <xbrtime_decode_pe>
   12fb2:	87aa                	mv	a5,a0
   12fb4:	0007861b          	sext.w	a2,a5
   12fb8:	fc843783          	ld	a5,-56(s0)
   12fbc:	0007869b          	sext.w	a3,a5
   12fc0:	fc442783          	lw	a5,-60(s0)
   12fc4:	2781                	sext.w	a5,a5
   12fc6:	0037979b          	slliw	a5,a5,0x3
   12fca:	2781                	sext.w	a5,a5
   12fcc:	873e                	mv	a4,a5
   12fce:	85ca                	mv	a1,s2
   12fd0:	8526                	mv	a0,s1
   12fd2:	6ad030ef          	jal	ra,16e7e <__xbrtime_put_u8_agg>
   12fd6:	779030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   12fda:	a011                	j	12fde <xbrtime_uint64_put+0xd4>
   12fdc:	0001                	nop
   12fde:	70e2                	ld	ra,56(sp)
   12fe0:	7442                	ld	s0,48(sp)
   12fe2:	74a2                	ld	s1,40(sp)
   12fe4:	7902                	ld	s2,32(sp)
   12fe6:	6121                	addi	sp,sp,64
   12fe8:	8082                	ret

0000000000012fea <xbrtime_uint64_put_nb>:
   12fea:	7139                	addi	sp,sp,-64
   12fec:	fc06                	sd	ra,56(sp)
   12fee:	f822                	sd	s0,48(sp)
   12ff0:	f426                	sd	s1,40(sp)
   12ff2:	f04a                	sd	s2,32(sp)
   12ff4:	0080                	addi	s0,sp,64
   12ff6:	fca43c23          	sd	a0,-40(s0)
   12ffa:	fcb43823          	sd	a1,-48(s0)
   12ffe:	fcc43423          	sd	a2,-56(s0)
   13002:	87b6                	mv	a5,a3
   13004:	fcf42223          	sw	a5,-60(s0)
   13008:	87ba                	mv	a5,a4
   1300a:	fcf42023          	sw	a5,-64(s0)
   1300e:	fc843783          	ld	a5,-56(s0)
   13012:	cfdd                	beqz	a5,130d0 <xbrtime_uint64_put_nb+0xe6>
   13014:	fc442783          	lw	a5,-60(s0)
   13018:	0007871b          	sext.w	a4,a5
   1301c:	4785                	li	a5,1
   1301e:	00f71763          	bne	a4,a5,1302c <xbrtime_uint64_put_nb+0x42>
   13022:	fc843703          	ld	a4,-56(s0)
   13026:	4785                	li	a5,1
   13028:	04f71b63          	bne	a4,a5,1307e <xbrtime_uint64_put_nb+0x94>
   1302c:	fd043483          	ld	s1,-48(s0)
   13030:	fd843783          	ld	a5,-40(s0)
   13034:	fc042703          	lw	a4,-64(s0)
   13038:	85ba                	mv	a1,a4
   1303a:	853e                	mv	a0,a5
   1303c:	ffffd097          	auipc	ra,0xffffd
   13040:	7de080e7          	jalr	2014(ra) # 1081a <__xbrtime_ltor>
   13044:	892a                	mv	s2,a0
   13046:	fc042783          	lw	a5,-64(s0)
   1304a:	853e                	mv	a0,a5
   1304c:	00003097          	auipc	ra,0x3
   13050:	346080e7          	jalr	838(ra) # 16392 <xbrtime_decode_pe>
   13054:	87aa                	mv	a5,a0
   13056:	0007861b          	sext.w	a2,a5
   1305a:	fc843783          	ld	a5,-56(s0)
   1305e:	0007869b          	sext.w	a3,a5
   13062:	fc442783          	lw	a5,-60(s0)
   13066:	2781                	sext.w	a5,a5
   13068:	0037979b          	slliw	a5,a5,0x3
   1306c:	2781                	sext.w	a5,a5
   1306e:	873e                	mv	a4,a5
   13070:	85ca                	mv	a1,s2
   13072:	8526                	mv	a0,s1
   13074:	00004097          	auipc	ra,0x4
   13078:	dee080e7          	jalr	-530(ra) # 16e62 <__xbrtime_put_u8_seq>
   1307c:	a899                	j	130d2 <xbrtime_uint64_put_nb+0xe8>
   1307e:	fd043483          	ld	s1,-48(s0)
   13082:	fd843783          	ld	a5,-40(s0)
   13086:	fc042703          	lw	a4,-64(s0)
   1308a:	85ba                	mv	a1,a4
   1308c:	853e                	mv	a0,a5
   1308e:	ffffd097          	auipc	ra,0xffffd
   13092:	78c080e7          	jalr	1932(ra) # 1081a <__xbrtime_ltor>
   13096:	892a                	mv	s2,a0
   13098:	fc042783          	lw	a5,-64(s0)
   1309c:	853e                	mv	a0,a5
   1309e:	00003097          	auipc	ra,0x3
   130a2:	2f4080e7          	jalr	756(ra) # 16392 <xbrtime_decode_pe>
   130a6:	87aa                	mv	a5,a0
   130a8:	0007861b          	sext.w	a2,a5
   130ac:	fc843783          	ld	a5,-56(s0)
   130b0:	0007869b          	sext.w	a3,a5
   130b4:	fc442783          	lw	a5,-60(s0)
   130b8:	2781                	sext.w	a5,a5
   130ba:	0037979b          	slliw	a5,a5,0x3
   130be:	2781                	sext.w	a5,a5
   130c0:	873e                	mv	a4,a5
   130c2:	85ca                	mv	a1,s2
   130c4:	8526                	mv	a0,s1
   130c6:	00004097          	auipc	ra,0x4
   130ca:	db8080e7          	jalr	-584(ra) # 16e7e <__xbrtime_put_u8_agg>
   130ce:	a011                	j	130d2 <xbrtime_uint64_put_nb+0xe8>
   130d0:	0001                	nop
   130d2:	70e2                	ld	ra,56(sp)
   130d4:	7442                	ld	s0,48(sp)
   130d6:	74a2                	ld	s1,40(sp)
   130d8:	7902                	ld	s2,32(sp)
   130da:	6121                	addi	sp,sp,64
   130dc:	8082                	ret

00000000000130de <xbrtime_size_put>:
   130de:	7139                	addi	sp,sp,-64
   130e0:	fc06                	sd	ra,56(sp)
   130e2:	f822                	sd	s0,48(sp)
   130e4:	f426                	sd	s1,40(sp)
   130e6:	f04a                	sd	s2,32(sp)
   130e8:	0080                	addi	s0,sp,64
   130ea:	fca43c23          	sd	a0,-40(s0)
   130ee:	fcb43823          	sd	a1,-48(s0)
   130f2:	fcc43423          	sd	a2,-56(s0)
   130f6:	87b6                	mv	a5,a3
   130f8:	fcf42223          	sw	a5,-60(s0)
   130fc:	87ba                	mv	a5,a4
   130fe:	fcf42023          	sw	a5,-64(s0)
   13102:	fc843783          	ld	a5,-56(s0)
   13106:	c7cd                	beqz	a5,131b0 <xbrtime_size_put+0xd2>
   13108:	fc442783          	lw	a5,-60(s0)
   1310c:	0007871b          	sext.w	a4,a5
   13110:	4785                	li	a5,1
   13112:	00f71763          	bne	a4,a5,13120 <xbrtime_size_put+0x42>
   13116:	fc843703          	ld	a4,-56(s0)
   1311a:	4785                	li	a5,1
   1311c:	04f71563          	bne	a4,a5,13166 <xbrtime_size_put+0x88>
   13120:	fd043483          	ld	s1,-48(s0)
   13124:	fd843783          	ld	a5,-40(s0)
   13128:	fc042703          	lw	a4,-64(s0)
   1312c:	85ba                	mv	a1,a4
   1312e:	853e                	mv	a0,a5
   13130:	eeafd0ef          	jal	ra,1081a <__xbrtime_ltor>
   13134:	892a                	mv	s2,a0
   13136:	fc042783          	lw	a5,-64(s0)
   1313a:	853e                	mv	a0,a5
   1313c:	256030ef          	jal	ra,16392 <xbrtime_decode_pe>
   13140:	87aa                	mv	a5,a0
   13142:	0007861b          	sext.w	a2,a5
   13146:	fc843783          	ld	a5,-56(s0)
   1314a:	0007869b          	sext.w	a3,a5
   1314e:	fc442783          	lw	a5,-60(s0)
   13152:	2781                	sext.w	a5,a5
   13154:	0037979b          	slliw	a5,a5,0x3
   13158:	2781                	sext.w	a5,a5
   1315a:	873e                	mv	a4,a5
   1315c:	85ca                	mv	a1,s2
   1315e:	8526                	mv	a0,s1
   13160:	4d9030ef          	jal	ra,16e38 <__xbrtime_put_u4_seq>
   13164:	a099                	j	131aa <xbrtime_size_put+0xcc>
   13166:	fd043483          	ld	s1,-48(s0)
   1316a:	fd843783          	ld	a5,-40(s0)
   1316e:	fc042703          	lw	a4,-64(s0)
   13172:	85ba                	mv	a1,a4
   13174:	853e                	mv	a0,a5
   13176:	ea4fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   1317a:	892a                	mv	s2,a0
   1317c:	fc042783          	lw	a5,-64(s0)
   13180:	853e                	mv	a0,a5
   13182:	210030ef          	jal	ra,16392 <xbrtime_decode_pe>
   13186:	87aa                	mv	a5,a0
   13188:	0007861b          	sext.w	a2,a5
   1318c:	fc843783          	ld	a5,-56(s0)
   13190:	0007869b          	sext.w	a3,a5
   13194:	fc442783          	lw	a5,-60(s0)
   13198:	2781                	sext.w	a5,a5
   1319a:	0037979b          	slliw	a5,a5,0x3
   1319e:	2781                	sext.w	a5,a5
   131a0:	873e                	mv	a4,a5
   131a2:	85ca                	mv	a1,s2
   131a4:	8526                	mv	a0,s1
   131a6:	4af030ef          	jal	ra,16e54 <__xbrtime_put_u4_agg>
   131aa:	5a5030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   131ae:	a011                	j	131b2 <xbrtime_size_put+0xd4>
   131b0:	0001                	nop
   131b2:	70e2                	ld	ra,56(sp)
   131b4:	7442                	ld	s0,48(sp)
   131b6:	74a2                	ld	s1,40(sp)
   131b8:	7902                	ld	s2,32(sp)
   131ba:	6121                	addi	sp,sp,64
   131bc:	8082                	ret

00000000000131be <xbrtime_size_put_nb>:
   131be:	7139                	addi	sp,sp,-64
   131c0:	fc06                	sd	ra,56(sp)
   131c2:	f822                	sd	s0,48(sp)
   131c4:	f426                	sd	s1,40(sp)
   131c6:	f04a                	sd	s2,32(sp)
   131c8:	0080                	addi	s0,sp,64
   131ca:	fca43c23          	sd	a0,-40(s0)
   131ce:	fcb43823          	sd	a1,-48(s0)
   131d2:	fcc43423          	sd	a2,-56(s0)
   131d6:	87b6                	mv	a5,a3
   131d8:	fcf42223          	sw	a5,-60(s0)
   131dc:	87ba                	mv	a5,a4
   131de:	fcf42023          	sw	a5,-64(s0)
   131e2:	fc843783          	ld	a5,-56(s0)
   131e6:	cfdd                	beqz	a5,132a4 <xbrtime_size_put_nb+0xe6>
   131e8:	fc442783          	lw	a5,-60(s0)
   131ec:	0007871b          	sext.w	a4,a5
   131f0:	4785                	li	a5,1
   131f2:	00f71763          	bne	a4,a5,13200 <xbrtime_size_put_nb+0x42>
   131f6:	fc843703          	ld	a4,-56(s0)
   131fa:	4785                	li	a5,1
   131fc:	04f71b63          	bne	a4,a5,13252 <xbrtime_size_put_nb+0x94>
   13200:	fd043483          	ld	s1,-48(s0)
   13204:	fd843783          	ld	a5,-40(s0)
   13208:	fc042703          	lw	a4,-64(s0)
   1320c:	85ba                	mv	a1,a4
   1320e:	853e                	mv	a0,a5
   13210:	ffffd097          	auipc	ra,0xffffd
   13214:	60a080e7          	jalr	1546(ra) # 1081a <__xbrtime_ltor>
   13218:	892a                	mv	s2,a0
   1321a:	fc042783          	lw	a5,-64(s0)
   1321e:	853e                	mv	a0,a5
   13220:	00003097          	auipc	ra,0x3
   13224:	172080e7          	jalr	370(ra) # 16392 <xbrtime_decode_pe>
   13228:	87aa                	mv	a5,a0
   1322a:	0007861b          	sext.w	a2,a5
   1322e:	fc843783          	ld	a5,-56(s0)
   13232:	0007869b          	sext.w	a3,a5
   13236:	fc442783          	lw	a5,-60(s0)
   1323a:	2781                	sext.w	a5,a5
   1323c:	0037979b          	slliw	a5,a5,0x3
   13240:	2781                	sext.w	a5,a5
   13242:	873e                	mv	a4,a5
   13244:	85ca                	mv	a1,s2
   13246:	8526                	mv	a0,s1
   13248:	00004097          	auipc	ra,0x4
   1324c:	bf0080e7          	jalr	-1040(ra) # 16e38 <__xbrtime_put_u4_seq>
   13250:	a899                	j	132a6 <xbrtime_size_put_nb+0xe8>
   13252:	fd043483          	ld	s1,-48(s0)
   13256:	fd843783          	ld	a5,-40(s0)
   1325a:	fc042703          	lw	a4,-64(s0)
   1325e:	85ba                	mv	a1,a4
   13260:	853e                	mv	a0,a5
   13262:	ffffd097          	auipc	ra,0xffffd
   13266:	5b8080e7          	jalr	1464(ra) # 1081a <__xbrtime_ltor>
   1326a:	892a                	mv	s2,a0
   1326c:	fc042783          	lw	a5,-64(s0)
   13270:	853e                	mv	a0,a5
   13272:	00003097          	auipc	ra,0x3
   13276:	120080e7          	jalr	288(ra) # 16392 <xbrtime_decode_pe>
   1327a:	87aa                	mv	a5,a0
   1327c:	0007861b          	sext.w	a2,a5
   13280:	fc843783          	ld	a5,-56(s0)
   13284:	0007869b          	sext.w	a3,a5
   13288:	fc442783          	lw	a5,-60(s0)
   1328c:	2781                	sext.w	a5,a5
   1328e:	0037979b          	slliw	a5,a5,0x3
   13292:	2781                	sext.w	a5,a5
   13294:	873e                	mv	a4,a5
   13296:	85ca                	mv	a1,s2
   13298:	8526                	mv	a0,s1
   1329a:	00004097          	auipc	ra,0x4
   1329e:	bba080e7          	jalr	-1094(ra) # 16e54 <__xbrtime_put_u4_agg>
   132a2:	a011                	j	132a6 <xbrtime_size_put_nb+0xe8>
   132a4:	0001                	nop
   132a6:	70e2                	ld	ra,56(sp)
   132a8:	7442                	ld	s0,48(sp)
   132aa:	74a2                	ld	s1,40(sp)
   132ac:	7902                	ld	s2,32(sp)
   132ae:	6121                	addi	sp,sp,64
   132b0:	8082                	ret

00000000000132b2 <xbrtime_ptrdiff_put>:
   132b2:	7139                	addi	sp,sp,-64
   132b4:	fc06                	sd	ra,56(sp)
   132b6:	f822                	sd	s0,48(sp)
   132b8:	f426                	sd	s1,40(sp)
   132ba:	f04a                	sd	s2,32(sp)
   132bc:	0080                	addi	s0,sp,64
   132be:	fca43c23          	sd	a0,-40(s0)
   132c2:	fcb43823          	sd	a1,-48(s0)
   132c6:	fcc43423          	sd	a2,-56(s0)
   132ca:	87b6                	mv	a5,a3
   132cc:	fcf42223          	sw	a5,-60(s0)
   132d0:	87ba                	mv	a5,a4
   132d2:	fcf42023          	sw	a5,-64(s0)
   132d6:	fc843783          	ld	a5,-56(s0)
   132da:	c7cd                	beqz	a5,13384 <xbrtime_ptrdiff_put+0xd2>
   132dc:	fc442783          	lw	a5,-60(s0)
   132e0:	0007871b          	sext.w	a4,a5
   132e4:	4785                	li	a5,1
   132e6:	00f71763          	bne	a4,a5,132f4 <xbrtime_ptrdiff_put+0x42>
   132ea:	fc843703          	ld	a4,-56(s0)
   132ee:	4785                	li	a5,1
   132f0:	04f71563          	bne	a4,a5,1333a <xbrtime_ptrdiff_put+0x88>
   132f4:	fd043483          	ld	s1,-48(s0)
   132f8:	fd843783          	ld	a5,-40(s0)
   132fc:	fc042703          	lw	a4,-64(s0)
   13300:	85ba                	mv	a1,a4
   13302:	853e                	mv	a0,a5
   13304:	d16fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   13308:	892a                	mv	s2,a0
   1330a:	fc042783          	lw	a5,-64(s0)
   1330e:	853e                	mv	a0,a5
   13310:	082030ef          	jal	ra,16392 <xbrtime_decode_pe>
   13314:	87aa                	mv	a5,a0
   13316:	0007861b          	sext.w	a2,a5
   1331a:	fc843783          	ld	a5,-56(s0)
   1331e:	0007869b          	sext.w	a3,a5
   13322:	fc442783          	lw	a5,-60(s0)
   13326:	2781                	sext.w	a5,a5
   13328:	0037979b          	slliw	a5,a5,0x3
   1332c:	2781                	sext.w	a5,a5
   1332e:	873e                	mv	a4,a5
   13330:	85ca                	mv	a1,s2
   13332:	8526                	mv	a0,s1
   13334:	3ad030ef          	jal	ra,16ee0 <__xbrtime_put_s4_seq>
   13338:	a099                	j	1337e <xbrtime_ptrdiff_put+0xcc>
   1333a:	fd043483          	ld	s1,-48(s0)
   1333e:	fd843783          	ld	a5,-40(s0)
   13342:	fc042703          	lw	a4,-64(s0)
   13346:	85ba                	mv	a1,a4
   13348:	853e                	mv	a0,a5
   1334a:	cd0fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   1334e:	892a                	mv	s2,a0
   13350:	fc042783          	lw	a5,-64(s0)
   13354:	853e                	mv	a0,a5
   13356:	03c030ef          	jal	ra,16392 <xbrtime_decode_pe>
   1335a:	87aa                	mv	a5,a0
   1335c:	0007861b          	sext.w	a2,a5
   13360:	fc843783          	ld	a5,-56(s0)
   13364:	0007869b          	sext.w	a3,a5
   13368:	fc442783          	lw	a5,-60(s0)
   1336c:	2781                	sext.w	a5,a5
   1336e:	0037979b          	slliw	a5,a5,0x3
   13372:	2781                	sext.w	a5,a5
   13374:	873e                	mv	a4,a5
   13376:	85ca                	mv	a1,s2
   13378:	8526                	mv	a0,s1
   1337a:	383030ef          	jal	ra,16efc <__xbrtime_put_s4_agg>
   1337e:	3d1030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   13382:	a011                	j	13386 <xbrtime_ptrdiff_put+0xd4>
   13384:	0001                	nop
   13386:	70e2                	ld	ra,56(sp)
   13388:	7442                	ld	s0,48(sp)
   1338a:	74a2                	ld	s1,40(sp)
   1338c:	7902                	ld	s2,32(sp)
   1338e:	6121                	addi	sp,sp,64
   13390:	8082                	ret

0000000000013392 <xbrtime_ptrdiff_put_nb>:
   13392:	7139                	addi	sp,sp,-64
   13394:	fc06                	sd	ra,56(sp)
   13396:	f822                	sd	s0,48(sp)
   13398:	f426                	sd	s1,40(sp)
   1339a:	f04a                	sd	s2,32(sp)
   1339c:	0080                	addi	s0,sp,64
   1339e:	fca43c23          	sd	a0,-40(s0)
   133a2:	fcb43823          	sd	a1,-48(s0)
   133a6:	fcc43423          	sd	a2,-56(s0)
   133aa:	87b6                	mv	a5,a3
   133ac:	fcf42223          	sw	a5,-60(s0)
   133b0:	87ba                	mv	a5,a4
   133b2:	fcf42023          	sw	a5,-64(s0)
   133b6:	fc843783          	ld	a5,-56(s0)
   133ba:	cfdd                	beqz	a5,13478 <xbrtime_ptrdiff_put_nb+0xe6>
   133bc:	fc442783          	lw	a5,-60(s0)
   133c0:	0007871b          	sext.w	a4,a5
   133c4:	4785                	li	a5,1
   133c6:	00f71763          	bne	a4,a5,133d4 <xbrtime_ptrdiff_put_nb+0x42>
   133ca:	fc843703          	ld	a4,-56(s0)
   133ce:	4785                	li	a5,1
   133d0:	04f71b63          	bne	a4,a5,13426 <xbrtime_ptrdiff_put_nb+0x94>
   133d4:	fd043483          	ld	s1,-48(s0)
   133d8:	fd843783          	ld	a5,-40(s0)
   133dc:	fc042703          	lw	a4,-64(s0)
   133e0:	85ba                	mv	a1,a4
   133e2:	853e                	mv	a0,a5
   133e4:	ffffd097          	auipc	ra,0xffffd
   133e8:	436080e7          	jalr	1078(ra) # 1081a <__xbrtime_ltor>
   133ec:	892a                	mv	s2,a0
   133ee:	fc042783          	lw	a5,-64(s0)
   133f2:	853e                	mv	a0,a5
   133f4:	00003097          	auipc	ra,0x3
   133f8:	f9e080e7          	jalr	-98(ra) # 16392 <xbrtime_decode_pe>
   133fc:	87aa                	mv	a5,a0
   133fe:	0007861b          	sext.w	a2,a5
   13402:	fc843783          	ld	a5,-56(s0)
   13406:	0007869b          	sext.w	a3,a5
   1340a:	fc442783          	lw	a5,-60(s0)
   1340e:	2781                	sext.w	a5,a5
   13410:	0037979b          	slliw	a5,a5,0x3
   13414:	2781                	sext.w	a5,a5
   13416:	873e                	mv	a4,a5
   13418:	85ca                	mv	a1,s2
   1341a:	8526                	mv	a0,s1
   1341c:	00004097          	auipc	ra,0x4
   13420:	ac4080e7          	jalr	-1340(ra) # 16ee0 <__xbrtime_put_s4_seq>
   13424:	a899                	j	1347a <xbrtime_ptrdiff_put_nb+0xe8>
   13426:	fd043483          	ld	s1,-48(s0)
   1342a:	fd843783          	ld	a5,-40(s0)
   1342e:	fc042703          	lw	a4,-64(s0)
   13432:	85ba                	mv	a1,a4
   13434:	853e                	mv	a0,a5
   13436:	ffffd097          	auipc	ra,0xffffd
   1343a:	3e4080e7          	jalr	996(ra) # 1081a <__xbrtime_ltor>
   1343e:	892a                	mv	s2,a0
   13440:	fc042783          	lw	a5,-64(s0)
   13444:	853e                	mv	a0,a5
   13446:	00003097          	auipc	ra,0x3
   1344a:	f4c080e7          	jalr	-180(ra) # 16392 <xbrtime_decode_pe>
   1344e:	87aa                	mv	a5,a0
   13450:	0007861b          	sext.w	a2,a5
   13454:	fc843783          	ld	a5,-56(s0)
   13458:	0007869b          	sext.w	a3,a5
   1345c:	fc442783          	lw	a5,-60(s0)
   13460:	2781                	sext.w	a5,a5
   13462:	0037979b          	slliw	a5,a5,0x3
   13466:	2781                	sext.w	a5,a5
   13468:	873e                	mv	a4,a5
   1346a:	85ca                	mv	a1,s2
   1346c:	8526                	mv	a0,s1
   1346e:	00004097          	auipc	ra,0x4
   13472:	a8e080e7          	jalr	-1394(ra) # 16efc <__xbrtime_put_s4_agg>
   13476:	a011                	j	1347a <xbrtime_ptrdiff_put_nb+0xe8>
   13478:	0001                	nop
   1347a:	70e2                	ld	ra,56(sp)
   1347c:	7442                	ld	s0,48(sp)
   1347e:	74a2                	ld	s1,40(sp)
   13480:	7902                	ld	s2,32(sp)
   13482:	6121                	addi	sp,sp,64
   13484:	8082                	ret

0000000000013486 <xbrtime_float_get>:
   13486:	7139                	addi	sp,sp,-64
   13488:	fc06                	sd	ra,56(sp)
   1348a:	f822                	sd	s0,48(sp)
   1348c:	f426                	sd	s1,40(sp)
   1348e:	f04a                	sd	s2,32(sp)
   13490:	0080                	addi	s0,sp,64
   13492:	fca43c23          	sd	a0,-40(s0)
   13496:	fcb43823          	sd	a1,-48(s0)
   1349a:	fcc43423          	sd	a2,-56(s0)
   1349e:	87b6                	mv	a5,a3
   134a0:	fcf42223          	sw	a5,-60(s0)
   134a4:	87ba                	mv	a5,a4
   134a6:	fcf42023          	sw	a5,-64(s0)
   134aa:	fc843783          	ld	a5,-56(s0)
   134ae:	c7cd                	beqz	a5,13558 <xbrtime_float_get+0xd2>
   134b0:	fc442783          	lw	a5,-60(s0)
   134b4:	0007871b          	sext.w	a4,a5
   134b8:	4785                	li	a5,1
   134ba:	00f71763          	bne	a4,a5,134c8 <xbrtime_float_get+0x42>
   134be:	fc843703          	ld	a4,-56(s0)
   134c2:	4785                	li	a5,1
   134c4:	04f71563          	bne	a4,a5,1350e <xbrtime_float_get+0x88>
   134c8:	fd043783          	ld	a5,-48(s0)
   134cc:	fc042703          	lw	a4,-64(s0)
   134d0:	85ba                	mv	a1,a4
   134d2:	853e                	mv	a0,a5
   134d4:	b46fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   134d8:	892a                	mv	s2,a0
   134da:	fd843483          	ld	s1,-40(s0)
   134de:	fc042783          	lw	a5,-64(s0)
   134e2:	853e                	mv	a0,a5
   134e4:	6af020ef          	jal	ra,16392 <xbrtime_decode_pe>
   134e8:	87aa                	mv	a5,a0
   134ea:	0007861b          	sext.w	a2,a5
   134ee:	fc843783          	ld	a5,-56(s0)
   134f2:	0007869b          	sext.w	a3,a5
   134f6:	fc442783          	lw	a5,-60(s0)
   134fa:	2781                	sext.w	a5,a5
   134fc:	0027979b          	slliw	a5,a5,0x2
   13500:	2781                	sext.w	a5,a5
   13502:	873e                	mv	a4,a5
   13504:	85a6                	mv	a1,s1
   13506:	854a                	mv	a0,s2
   13508:	7e0030ef          	jal	ra,16ce8 <__xbrtime_get_u4_seq>
   1350c:	a099                	j	13552 <xbrtime_float_get+0xcc>
   1350e:	fd043783          	ld	a5,-48(s0)
   13512:	fc042703          	lw	a4,-64(s0)
   13516:	85ba                	mv	a1,a4
   13518:	853e                	mv	a0,a5
   1351a:	b00fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   1351e:	892a                	mv	s2,a0
   13520:	fd843483          	ld	s1,-40(s0)
   13524:	fc042783          	lw	a5,-64(s0)
   13528:	853e                	mv	a0,a5
   1352a:	669020ef          	jal	ra,16392 <xbrtime_decode_pe>
   1352e:	87aa                	mv	a5,a0
   13530:	0007861b          	sext.w	a2,a5
   13534:	fc843783          	ld	a5,-56(s0)
   13538:	0007869b          	sext.w	a3,a5
   1353c:	fc442783          	lw	a5,-60(s0)
   13540:	2781                	sext.w	a5,a5
   13542:	0027979b          	slliw	a5,a5,0x2
   13546:	2781                	sext.w	a5,a5
   13548:	873e                	mv	a4,a5
   1354a:	85a6                	mv	a1,s1
   1354c:	854a                	mv	a0,s2
   1354e:	7b6030ef          	jal	ra,16d04 <__xbrtime_get_u4_agg>
   13552:	1fd030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   13556:	a011                	j	1355a <xbrtime_float_get+0xd4>
   13558:	0001                	nop
   1355a:	70e2                	ld	ra,56(sp)
   1355c:	7442                	ld	s0,48(sp)
   1355e:	74a2                	ld	s1,40(sp)
   13560:	7902                	ld	s2,32(sp)
   13562:	6121                	addi	sp,sp,64
   13564:	8082                	ret

0000000000013566 <xbrtime_float_get_nb>:
   13566:	7139                	addi	sp,sp,-64
   13568:	fc06                	sd	ra,56(sp)
   1356a:	f822                	sd	s0,48(sp)
   1356c:	f426                	sd	s1,40(sp)
   1356e:	f04a                	sd	s2,32(sp)
   13570:	0080                	addi	s0,sp,64
   13572:	fca43c23          	sd	a0,-40(s0)
   13576:	fcb43823          	sd	a1,-48(s0)
   1357a:	fcc43423          	sd	a2,-56(s0)
   1357e:	87b6                	mv	a5,a3
   13580:	fcf42223          	sw	a5,-60(s0)
   13584:	87ba                	mv	a5,a4
   13586:	fcf42023          	sw	a5,-64(s0)
   1358a:	fc843783          	ld	a5,-56(s0)
   1358e:	cfdd                	beqz	a5,1364c <xbrtime_float_get_nb+0xe6>
   13590:	fc442783          	lw	a5,-60(s0)
   13594:	0007871b          	sext.w	a4,a5
   13598:	4785                	li	a5,1
   1359a:	00f71763          	bne	a4,a5,135a8 <xbrtime_float_get_nb+0x42>
   1359e:	fc843703          	ld	a4,-56(s0)
   135a2:	4785                	li	a5,1
   135a4:	04f71b63          	bne	a4,a5,135fa <xbrtime_float_get_nb+0x94>
   135a8:	fd043783          	ld	a5,-48(s0)
   135ac:	fc042703          	lw	a4,-64(s0)
   135b0:	85ba                	mv	a1,a4
   135b2:	853e                	mv	a0,a5
   135b4:	ffffd097          	auipc	ra,0xffffd
   135b8:	266080e7          	jalr	614(ra) # 1081a <__xbrtime_ltor>
   135bc:	892a                	mv	s2,a0
   135be:	fd843483          	ld	s1,-40(s0)
   135c2:	fc042783          	lw	a5,-64(s0)
   135c6:	853e                	mv	a0,a5
   135c8:	00003097          	auipc	ra,0x3
   135cc:	dca080e7          	jalr	-566(ra) # 16392 <xbrtime_decode_pe>
   135d0:	87aa                	mv	a5,a0
   135d2:	0007861b          	sext.w	a2,a5
   135d6:	fc843783          	ld	a5,-56(s0)
   135da:	0007869b          	sext.w	a3,a5
   135de:	fc442783          	lw	a5,-60(s0)
   135e2:	2781                	sext.w	a5,a5
   135e4:	0027979b          	slliw	a5,a5,0x2
   135e8:	2781                	sext.w	a5,a5
   135ea:	873e                	mv	a4,a5
   135ec:	85a6                	mv	a1,s1
   135ee:	854a                	mv	a0,s2
   135f0:	00003097          	auipc	ra,0x3
   135f4:	6f8080e7          	jalr	1784(ra) # 16ce8 <__xbrtime_get_u4_seq>
   135f8:	a899                	j	1364e <xbrtime_float_get_nb+0xe8>
   135fa:	fd043783          	ld	a5,-48(s0)
   135fe:	fc042703          	lw	a4,-64(s0)
   13602:	85ba                	mv	a1,a4
   13604:	853e                	mv	a0,a5
   13606:	ffffd097          	auipc	ra,0xffffd
   1360a:	214080e7          	jalr	532(ra) # 1081a <__xbrtime_ltor>
   1360e:	892a                	mv	s2,a0
   13610:	fd843483          	ld	s1,-40(s0)
   13614:	fc042783          	lw	a5,-64(s0)
   13618:	853e                	mv	a0,a5
   1361a:	00003097          	auipc	ra,0x3
   1361e:	d78080e7          	jalr	-648(ra) # 16392 <xbrtime_decode_pe>
   13622:	87aa                	mv	a5,a0
   13624:	0007861b          	sext.w	a2,a5
   13628:	fc843783          	ld	a5,-56(s0)
   1362c:	0007869b          	sext.w	a3,a5
   13630:	fc442783          	lw	a5,-60(s0)
   13634:	2781                	sext.w	a5,a5
   13636:	0027979b          	slliw	a5,a5,0x2
   1363a:	2781                	sext.w	a5,a5
   1363c:	873e                	mv	a4,a5
   1363e:	85a6                	mv	a1,s1
   13640:	854a                	mv	a0,s2
   13642:	00003097          	auipc	ra,0x3
   13646:	6c2080e7          	jalr	1730(ra) # 16d04 <__xbrtime_get_u4_agg>
   1364a:	a011                	j	1364e <xbrtime_float_get_nb+0xe8>
   1364c:	0001                	nop
   1364e:	70e2                	ld	ra,56(sp)
   13650:	7442                	ld	s0,48(sp)
   13652:	74a2                	ld	s1,40(sp)
   13654:	7902                	ld	s2,32(sp)
   13656:	6121                	addi	sp,sp,64
   13658:	8082                	ret

000000000001365a <xbrtime_double_get>:
   1365a:	7139                	addi	sp,sp,-64
   1365c:	fc06                	sd	ra,56(sp)
   1365e:	f822                	sd	s0,48(sp)
   13660:	f426                	sd	s1,40(sp)
   13662:	f04a                	sd	s2,32(sp)
   13664:	0080                	addi	s0,sp,64
   13666:	fca43c23          	sd	a0,-40(s0)
   1366a:	fcb43823          	sd	a1,-48(s0)
   1366e:	fcc43423          	sd	a2,-56(s0)
   13672:	87b6                	mv	a5,a3
   13674:	fcf42223          	sw	a5,-60(s0)
   13678:	87ba                	mv	a5,a4
   1367a:	fcf42023          	sw	a5,-64(s0)
   1367e:	fc843783          	ld	a5,-56(s0)
   13682:	c7cd                	beqz	a5,1372c <xbrtime_double_get+0xd2>
   13684:	fc442783          	lw	a5,-60(s0)
   13688:	0007871b          	sext.w	a4,a5
   1368c:	4785                	li	a5,1
   1368e:	00f71763          	bne	a4,a5,1369c <xbrtime_double_get+0x42>
   13692:	fc843703          	ld	a4,-56(s0)
   13696:	4785                	li	a5,1
   13698:	04f71563          	bne	a4,a5,136e2 <xbrtime_double_get+0x88>
   1369c:	fd043783          	ld	a5,-48(s0)
   136a0:	fc042703          	lw	a4,-64(s0)
   136a4:	85ba                	mv	a1,a4
   136a6:	853e                	mv	a0,a5
   136a8:	972fd0ef          	jal	ra,1081a <__xbrtime_ltor>
   136ac:	892a                	mv	s2,a0
   136ae:	fd843483          	ld	s1,-40(s0)
   136b2:	fc042783          	lw	a5,-64(s0)
   136b6:	853e                	mv	a0,a5
   136b8:	4db020ef          	jal	ra,16392 <xbrtime_decode_pe>
   136bc:	87aa                	mv	a5,a0
   136be:	0007861b          	sext.w	a2,a5
   136c2:	fc843783          	ld	a5,-56(s0)
   136c6:	0007869b          	sext.w	a3,a5
   136ca:	fc442783          	lw	a5,-60(s0)
   136ce:	2781                	sext.w	a5,a5
   136d0:	0037979b          	slliw	a5,a5,0x3
   136d4:	2781                	sext.w	a5,a5
   136d6:	873e                	mv	a4,a5
   136d8:	85a6                	mv	a1,s1
   136da:	854a                	mv	a0,s2
   136dc:	636030ef          	jal	ra,16d12 <__xbrtime_get_u8_seq>
   136e0:	a099                	j	13726 <xbrtime_double_get+0xcc>
   136e2:	fd043783          	ld	a5,-48(s0)
   136e6:	fc042703          	lw	a4,-64(s0)
   136ea:	85ba                	mv	a1,a4
   136ec:	853e                	mv	a0,a5
   136ee:	92cfd0ef          	jal	ra,1081a <__xbrtime_ltor>
   136f2:	892a                	mv	s2,a0
   136f4:	fd843483          	ld	s1,-40(s0)
   136f8:	fc042783          	lw	a5,-64(s0)
   136fc:	853e                	mv	a0,a5
   136fe:	495020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13702:	87aa                	mv	a5,a0
   13704:	0007861b          	sext.w	a2,a5
   13708:	fc843783          	ld	a5,-56(s0)
   1370c:	0007869b          	sext.w	a3,a5
   13710:	fc442783          	lw	a5,-60(s0)
   13714:	2781                	sext.w	a5,a5
   13716:	0037979b          	slliw	a5,a5,0x3
   1371a:	2781                	sext.w	a5,a5
   1371c:	873e                	mv	a4,a5
   1371e:	85a6                	mv	a1,s1
   13720:	854a                	mv	a0,s2
   13722:	60c030ef          	jal	ra,16d2e <__xbrtime_get_u8_agg>
   13726:	029030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   1372a:	a011                	j	1372e <xbrtime_double_get+0xd4>
   1372c:	0001                	nop
   1372e:	70e2                	ld	ra,56(sp)
   13730:	7442                	ld	s0,48(sp)
   13732:	74a2                	ld	s1,40(sp)
   13734:	7902                	ld	s2,32(sp)
   13736:	6121                	addi	sp,sp,64
   13738:	8082                	ret

000000000001373a <xbrtime_double_get_nb>:
   1373a:	7139                	addi	sp,sp,-64
   1373c:	fc06                	sd	ra,56(sp)
   1373e:	f822                	sd	s0,48(sp)
   13740:	f426                	sd	s1,40(sp)
   13742:	f04a                	sd	s2,32(sp)
   13744:	0080                	addi	s0,sp,64
   13746:	fca43c23          	sd	a0,-40(s0)
   1374a:	fcb43823          	sd	a1,-48(s0)
   1374e:	fcc43423          	sd	a2,-56(s0)
   13752:	87b6                	mv	a5,a3
   13754:	fcf42223          	sw	a5,-60(s0)
   13758:	87ba                	mv	a5,a4
   1375a:	fcf42023          	sw	a5,-64(s0)
   1375e:	fc843783          	ld	a5,-56(s0)
   13762:	cfdd                	beqz	a5,13820 <xbrtime_double_get_nb+0xe6>
   13764:	fc442783          	lw	a5,-60(s0)
   13768:	0007871b          	sext.w	a4,a5
   1376c:	4785                	li	a5,1
   1376e:	00f71763          	bne	a4,a5,1377c <xbrtime_double_get_nb+0x42>
   13772:	fc843703          	ld	a4,-56(s0)
   13776:	4785                	li	a5,1
   13778:	04f71b63          	bne	a4,a5,137ce <xbrtime_double_get_nb+0x94>
   1377c:	fd043783          	ld	a5,-48(s0)
   13780:	fc042703          	lw	a4,-64(s0)
   13784:	85ba                	mv	a1,a4
   13786:	853e                	mv	a0,a5
   13788:	ffffd097          	auipc	ra,0xffffd
   1378c:	092080e7          	jalr	146(ra) # 1081a <__xbrtime_ltor>
   13790:	892a                	mv	s2,a0
   13792:	fd843483          	ld	s1,-40(s0)
   13796:	fc042783          	lw	a5,-64(s0)
   1379a:	853e                	mv	a0,a5
   1379c:	00003097          	auipc	ra,0x3
   137a0:	bf6080e7          	jalr	-1034(ra) # 16392 <xbrtime_decode_pe>
   137a4:	87aa                	mv	a5,a0
   137a6:	0007861b          	sext.w	a2,a5
   137aa:	fc843783          	ld	a5,-56(s0)
   137ae:	0007869b          	sext.w	a3,a5
   137b2:	fc442783          	lw	a5,-60(s0)
   137b6:	2781                	sext.w	a5,a5
   137b8:	0037979b          	slliw	a5,a5,0x3
   137bc:	2781                	sext.w	a5,a5
   137be:	873e                	mv	a4,a5
   137c0:	85a6                	mv	a1,s1
   137c2:	854a                	mv	a0,s2
   137c4:	00003097          	auipc	ra,0x3
   137c8:	54e080e7          	jalr	1358(ra) # 16d12 <__xbrtime_get_u8_seq>
   137cc:	a899                	j	13822 <xbrtime_double_get_nb+0xe8>
   137ce:	fd043783          	ld	a5,-48(s0)
   137d2:	fc042703          	lw	a4,-64(s0)
   137d6:	85ba                	mv	a1,a4
   137d8:	853e                	mv	a0,a5
   137da:	ffffd097          	auipc	ra,0xffffd
   137de:	040080e7          	jalr	64(ra) # 1081a <__xbrtime_ltor>
   137e2:	892a                	mv	s2,a0
   137e4:	fd843483          	ld	s1,-40(s0)
   137e8:	fc042783          	lw	a5,-64(s0)
   137ec:	853e                	mv	a0,a5
   137ee:	00003097          	auipc	ra,0x3
   137f2:	ba4080e7          	jalr	-1116(ra) # 16392 <xbrtime_decode_pe>
   137f6:	87aa                	mv	a5,a0
   137f8:	0007861b          	sext.w	a2,a5
   137fc:	fc843783          	ld	a5,-56(s0)
   13800:	0007869b          	sext.w	a3,a5
   13804:	fc442783          	lw	a5,-60(s0)
   13808:	2781                	sext.w	a5,a5
   1380a:	0037979b          	slliw	a5,a5,0x3
   1380e:	2781                	sext.w	a5,a5
   13810:	873e                	mv	a4,a5
   13812:	85a6                	mv	a1,s1
   13814:	854a                	mv	a0,s2
   13816:	00003097          	auipc	ra,0x3
   1381a:	518080e7          	jalr	1304(ra) # 16d2e <__xbrtime_get_u8_agg>
   1381e:	a011                	j	13822 <xbrtime_double_get_nb+0xe8>
   13820:	0001                	nop
   13822:	70e2                	ld	ra,56(sp)
   13824:	7442                	ld	s0,48(sp)
   13826:	74a2                	ld	s1,40(sp)
   13828:	7902                	ld	s2,32(sp)
   1382a:	6121                	addi	sp,sp,64
   1382c:	8082                	ret

000000000001382e <xbrtime_longdouble_get>:
   1382e:	7139                	addi	sp,sp,-64
   13830:	fc06                	sd	ra,56(sp)
   13832:	f822                	sd	s0,48(sp)
   13834:	f426                	sd	s1,40(sp)
   13836:	f04a                	sd	s2,32(sp)
   13838:	0080                	addi	s0,sp,64
   1383a:	fca43c23          	sd	a0,-40(s0)
   1383e:	fcb43823          	sd	a1,-48(s0)
   13842:	fcc43423          	sd	a2,-56(s0)
   13846:	87b6                	mv	a5,a3
   13848:	fcf42223          	sw	a5,-60(s0)
   1384c:	87ba                	mv	a5,a4
   1384e:	fcf42023          	sw	a5,-64(s0)
   13852:	fc843783          	ld	a5,-56(s0)
   13856:	c7cd                	beqz	a5,13900 <xbrtime_longdouble_get+0xd2>
   13858:	fc442783          	lw	a5,-60(s0)
   1385c:	0007871b          	sext.w	a4,a5
   13860:	4785                	li	a5,1
   13862:	00f71763          	bne	a4,a5,13870 <xbrtime_longdouble_get+0x42>
   13866:	fc843703          	ld	a4,-56(s0)
   1386a:	4785                	li	a5,1
   1386c:	04f71563          	bne	a4,a5,138b6 <xbrtime_longdouble_get+0x88>
   13870:	fd043783          	ld	a5,-48(s0)
   13874:	fc042703          	lw	a4,-64(s0)
   13878:	85ba                	mv	a1,a4
   1387a:	853e                	mv	a0,a5
   1387c:	f9ffc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13880:	892a                	mv	s2,a0
   13882:	fd843483          	ld	s1,-40(s0)
   13886:	fc042783          	lw	a5,-64(s0)
   1388a:	853e                	mv	a0,a5
   1388c:	307020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13890:	87aa                	mv	a5,a0
   13892:	0007861b          	sext.w	a2,a5
   13896:	fc843783          	ld	a5,-56(s0)
   1389a:	0007869b          	sext.w	a3,a5
   1389e:	fc442783          	lw	a5,-60(s0)
   138a2:	2781                	sext.w	a5,a5
   138a4:	0047979b          	slliw	a5,a5,0x4
   138a8:	2781                	sext.w	a5,a5
   138aa:	873e                	mv	a4,a5
   138ac:	85a6                	mv	a1,s1
   138ae:	854a                	mv	a0,s2
   138b0:	462030ef          	jal	ra,16d12 <__xbrtime_get_u8_seq>
   138b4:	a099                	j	138fa <xbrtime_longdouble_get+0xcc>
   138b6:	fd043783          	ld	a5,-48(s0)
   138ba:	fc042703          	lw	a4,-64(s0)
   138be:	85ba                	mv	a1,a4
   138c0:	853e                	mv	a0,a5
   138c2:	f59fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   138c6:	892a                	mv	s2,a0
   138c8:	fd843483          	ld	s1,-40(s0)
   138cc:	fc042783          	lw	a5,-64(s0)
   138d0:	853e                	mv	a0,a5
   138d2:	2c1020ef          	jal	ra,16392 <xbrtime_decode_pe>
   138d6:	87aa                	mv	a5,a0
   138d8:	0007861b          	sext.w	a2,a5
   138dc:	fc843783          	ld	a5,-56(s0)
   138e0:	0007869b          	sext.w	a3,a5
   138e4:	fc442783          	lw	a5,-60(s0)
   138e8:	2781                	sext.w	a5,a5
   138ea:	0047979b          	slliw	a5,a5,0x4
   138ee:	2781                	sext.w	a5,a5
   138f0:	873e                	mv	a4,a5
   138f2:	85a6                	mv	a1,s1
   138f4:	854a                	mv	a0,s2
   138f6:	438030ef          	jal	ra,16d2e <__xbrtime_get_u8_agg>
   138fa:	654030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   138fe:	a011                	j	13902 <xbrtime_longdouble_get+0xd4>
   13900:	0001                	nop
   13902:	70e2                	ld	ra,56(sp)
   13904:	7442                	ld	s0,48(sp)
   13906:	74a2                	ld	s1,40(sp)
   13908:	7902                	ld	s2,32(sp)
   1390a:	6121                	addi	sp,sp,64
   1390c:	8082                	ret

000000000001390e <xbrtime_longdouble_get_nb>:
   1390e:	7139                	addi	sp,sp,-64
   13910:	fc06                	sd	ra,56(sp)
   13912:	f822                	sd	s0,48(sp)
   13914:	f426                	sd	s1,40(sp)
   13916:	f04a                	sd	s2,32(sp)
   13918:	0080                	addi	s0,sp,64
   1391a:	fca43c23          	sd	a0,-40(s0)
   1391e:	fcb43823          	sd	a1,-48(s0)
   13922:	fcc43423          	sd	a2,-56(s0)
   13926:	87b6                	mv	a5,a3
   13928:	fcf42223          	sw	a5,-60(s0)
   1392c:	87ba                	mv	a5,a4
   1392e:	fcf42023          	sw	a5,-64(s0)
   13932:	fc843783          	ld	a5,-56(s0)
   13936:	cfdd                	beqz	a5,139f4 <xbrtime_longdouble_get_nb+0xe6>
   13938:	fc442783          	lw	a5,-60(s0)
   1393c:	0007871b          	sext.w	a4,a5
   13940:	4785                	li	a5,1
   13942:	00f71763          	bne	a4,a5,13950 <xbrtime_longdouble_get_nb+0x42>
   13946:	fc843703          	ld	a4,-56(s0)
   1394a:	4785                	li	a5,1
   1394c:	04f71b63          	bne	a4,a5,139a2 <xbrtime_longdouble_get_nb+0x94>
   13950:	fd043783          	ld	a5,-48(s0)
   13954:	fc042703          	lw	a4,-64(s0)
   13958:	85ba                	mv	a1,a4
   1395a:	853e                	mv	a0,a5
   1395c:	ffffd097          	auipc	ra,0xffffd
   13960:	ebe080e7          	jalr	-322(ra) # 1081a <__xbrtime_ltor>
   13964:	892a                	mv	s2,a0
   13966:	fd843483          	ld	s1,-40(s0)
   1396a:	fc042783          	lw	a5,-64(s0)
   1396e:	853e                	mv	a0,a5
   13970:	00003097          	auipc	ra,0x3
   13974:	a22080e7          	jalr	-1502(ra) # 16392 <xbrtime_decode_pe>
   13978:	87aa                	mv	a5,a0
   1397a:	0007861b          	sext.w	a2,a5
   1397e:	fc843783          	ld	a5,-56(s0)
   13982:	0007869b          	sext.w	a3,a5
   13986:	fc442783          	lw	a5,-60(s0)
   1398a:	2781                	sext.w	a5,a5
   1398c:	0047979b          	slliw	a5,a5,0x4
   13990:	2781                	sext.w	a5,a5
   13992:	873e                	mv	a4,a5
   13994:	85a6                	mv	a1,s1
   13996:	854a                	mv	a0,s2
   13998:	00003097          	auipc	ra,0x3
   1399c:	37a080e7          	jalr	890(ra) # 16d12 <__xbrtime_get_u8_seq>
   139a0:	a899                	j	139f6 <xbrtime_longdouble_get_nb+0xe8>
   139a2:	fd043783          	ld	a5,-48(s0)
   139a6:	fc042703          	lw	a4,-64(s0)
   139aa:	85ba                	mv	a1,a4
   139ac:	853e                	mv	a0,a5
   139ae:	ffffd097          	auipc	ra,0xffffd
   139b2:	e6c080e7          	jalr	-404(ra) # 1081a <__xbrtime_ltor>
   139b6:	892a                	mv	s2,a0
   139b8:	fd843483          	ld	s1,-40(s0)
   139bc:	fc042783          	lw	a5,-64(s0)
   139c0:	853e                	mv	a0,a5
   139c2:	00003097          	auipc	ra,0x3
   139c6:	9d0080e7          	jalr	-1584(ra) # 16392 <xbrtime_decode_pe>
   139ca:	87aa                	mv	a5,a0
   139cc:	0007861b          	sext.w	a2,a5
   139d0:	fc843783          	ld	a5,-56(s0)
   139d4:	0007869b          	sext.w	a3,a5
   139d8:	fc442783          	lw	a5,-60(s0)
   139dc:	2781                	sext.w	a5,a5
   139de:	0047979b          	slliw	a5,a5,0x4
   139e2:	2781                	sext.w	a5,a5
   139e4:	873e                	mv	a4,a5
   139e6:	85a6                	mv	a1,s1
   139e8:	854a                	mv	a0,s2
   139ea:	00003097          	auipc	ra,0x3
   139ee:	344080e7          	jalr	836(ra) # 16d2e <__xbrtime_get_u8_agg>
   139f2:	a011                	j	139f6 <xbrtime_longdouble_get_nb+0xe8>
   139f4:	0001                	nop
   139f6:	70e2                	ld	ra,56(sp)
   139f8:	7442                	ld	s0,48(sp)
   139fa:	74a2                	ld	s1,40(sp)
   139fc:	7902                	ld	s2,32(sp)
   139fe:	6121                	addi	sp,sp,64
   13a00:	8082                	ret

0000000000013a02 <xbrtime_schar_get>:
   13a02:	7139                	addi	sp,sp,-64
   13a04:	fc06                	sd	ra,56(sp)
   13a06:	f822                	sd	s0,48(sp)
   13a08:	f426                	sd	s1,40(sp)
   13a0a:	f04a                	sd	s2,32(sp)
   13a0c:	0080                	addi	s0,sp,64
   13a0e:	fca43c23          	sd	a0,-40(s0)
   13a12:	fcb43823          	sd	a1,-48(s0)
   13a16:	fcc43423          	sd	a2,-56(s0)
   13a1a:	87b6                	mv	a5,a3
   13a1c:	fcf42223          	sw	a5,-60(s0)
   13a20:	87ba                	mv	a5,a4
   13a22:	fcf42023          	sw	a5,-64(s0)
   13a26:	fc843783          	ld	a5,-56(s0)
   13a2a:	cfc9                	beqz	a5,13ac4 <xbrtime_schar_get+0xc2>
   13a2c:	fc442783          	lw	a5,-60(s0)
   13a30:	0007871b          	sext.w	a4,a5
   13a34:	4785                	li	a5,1
   13a36:	00f71763          	bne	a4,a5,13a44 <xbrtime_schar_get+0x42>
   13a3a:	fc843703          	ld	a4,-56(s0)
   13a3e:	4785                	li	a5,1
   13a40:	04f71163          	bne	a4,a5,13a82 <xbrtime_schar_get+0x80>
   13a44:	fd043783          	ld	a5,-48(s0)
   13a48:	fc042703          	lw	a4,-64(s0)
   13a4c:	85ba                	mv	a1,a4
   13a4e:	853e                	mv	a0,a5
   13a50:	dcbfc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13a54:	892a                	mv	s2,a0
   13a56:	fd843483          	ld	s1,-40(s0)
   13a5a:	fc042783          	lw	a5,-64(s0)
   13a5e:	853e                	mv	a0,a5
   13a60:	133020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13a64:	87aa                	mv	a5,a0
   13a66:	2781                	sext.w	a5,a5
   13a68:	fc843703          	ld	a4,-56(s0)
   13a6c:	0007069b          	sext.w	a3,a4
   13a70:	fc442703          	lw	a4,-60(s0)
   13a74:	2701                	sext.w	a4,a4
   13a76:	863e                	mv	a2,a5
   13a78:	85a6                	mv	a1,s1
   13a7a:	854a                	mv	a0,s2
   13a7c:	2c0030ef          	jal	ra,16d3c <__xbrtime_get_s1_seq>
   13a80:	a83d                	j	13abe <xbrtime_schar_get+0xbc>
   13a82:	fd043783          	ld	a5,-48(s0)
   13a86:	fc042703          	lw	a4,-64(s0)
   13a8a:	85ba                	mv	a1,a4
   13a8c:	853e                	mv	a0,a5
   13a8e:	d8dfc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13a92:	892a                	mv	s2,a0
   13a94:	fd843483          	ld	s1,-40(s0)
   13a98:	fc042783          	lw	a5,-64(s0)
   13a9c:	853e                	mv	a0,a5
   13a9e:	0f5020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13aa2:	87aa                	mv	a5,a0
   13aa4:	2781                	sext.w	a5,a5
   13aa6:	fc843703          	ld	a4,-56(s0)
   13aaa:	0007069b          	sext.w	a3,a4
   13aae:	fc442703          	lw	a4,-60(s0)
   13ab2:	2701                	sext.w	a4,a4
   13ab4:	863e                	mv	a2,a5
   13ab6:	85a6                	mv	a1,s1
   13ab8:	854a                	mv	a0,s2
   13aba:	29e030ef          	jal	ra,16d58 <__xbrtime_get_s1_agg>
   13abe:	490030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   13ac2:	a011                	j	13ac6 <xbrtime_schar_get+0xc4>
   13ac4:	0001                	nop
   13ac6:	70e2                	ld	ra,56(sp)
   13ac8:	7442                	ld	s0,48(sp)
   13aca:	74a2                	ld	s1,40(sp)
   13acc:	7902                	ld	s2,32(sp)
   13ace:	6121                	addi	sp,sp,64
   13ad0:	8082                	ret

0000000000013ad2 <xbrtime_schar_get_nb>:
   13ad2:	7139                	addi	sp,sp,-64
   13ad4:	fc06                	sd	ra,56(sp)
   13ad6:	f822                	sd	s0,48(sp)
   13ad8:	f426                	sd	s1,40(sp)
   13ada:	f04a                	sd	s2,32(sp)
   13adc:	0080                	addi	s0,sp,64
   13ade:	fca43c23          	sd	a0,-40(s0)
   13ae2:	fcb43823          	sd	a1,-48(s0)
   13ae6:	fcc43423          	sd	a2,-56(s0)
   13aea:	87b6                	mv	a5,a3
   13aec:	fcf42223          	sw	a5,-60(s0)
   13af0:	87ba                	mv	a5,a4
   13af2:	fcf42023          	sw	a5,-64(s0)
   13af6:	fc843783          	ld	a5,-56(s0)
   13afa:	c7dd                	beqz	a5,13ba8 <xbrtime_schar_get_nb+0xd6>
   13afc:	fc442783          	lw	a5,-60(s0)
   13b00:	0007871b          	sext.w	a4,a5
   13b04:	4785                	li	a5,1
   13b06:	00f71763          	bne	a4,a5,13b14 <xbrtime_schar_get_nb+0x42>
   13b0a:	fc843703          	ld	a4,-56(s0)
   13b0e:	4785                	li	a5,1
   13b10:	04f71763          	bne	a4,a5,13b5e <xbrtime_schar_get_nb+0x8c>
   13b14:	fd043783          	ld	a5,-48(s0)
   13b18:	fc042703          	lw	a4,-64(s0)
   13b1c:	85ba                	mv	a1,a4
   13b1e:	853e                	mv	a0,a5
   13b20:	ffffd097          	auipc	ra,0xffffd
   13b24:	cfa080e7          	jalr	-774(ra) # 1081a <__xbrtime_ltor>
   13b28:	892a                	mv	s2,a0
   13b2a:	fd843483          	ld	s1,-40(s0)
   13b2e:	fc042783          	lw	a5,-64(s0)
   13b32:	853e                	mv	a0,a5
   13b34:	00003097          	auipc	ra,0x3
   13b38:	85e080e7          	jalr	-1954(ra) # 16392 <xbrtime_decode_pe>
   13b3c:	87aa                	mv	a5,a0
   13b3e:	2781                	sext.w	a5,a5
   13b40:	fc843703          	ld	a4,-56(s0)
   13b44:	0007069b          	sext.w	a3,a4
   13b48:	fc442703          	lw	a4,-60(s0)
   13b4c:	2701                	sext.w	a4,a4
   13b4e:	863e                	mv	a2,a5
   13b50:	85a6                	mv	a1,s1
   13b52:	854a                	mv	a0,s2
   13b54:	00003097          	auipc	ra,0x3
   13b58:	1e8080e7          	jalr	488(ra) # 16d3c <__xbrtime_get_s1_seq>
   13b5c:	a0b9                	j	13baa <xbrtime_schar_get_nb+0xd8>
   13b5e:	fd043783          	ld	a5,-48(s0)
   13b62:	fc042703          	lw	a4,-64(s0)
   13b66:	85ba                	mv	a1,a4
   13b68:	853e                	mv	a0,a5
   13b6a:	ffffd097          	auipc	ra,0xffffd
   13b6e:	cb0080e7          	jalr	-848(ra) # 1081a <__xbrtime_ltor>
   13b72:	892a                	mv	s2,a0
   13b74:	fd843483          	ld	s1,-40(s0)
   13b78:	fc042783          	lw	a5,-64(s0)
   13b7c:	853e                	mv	a0,a5
   13b7e:	00003097          	auipc	ra,0x3
   13b82:	814080e7          	jalr	-2028(ra) # 16392 <xbrtime_decode_pe>
   13b86:	87aa                	mv	a5,a0
   13b88:	2781                	sext.w	a5,a5
   13b8a:	fc843703          	ld	a4,-56(s0)
   13b8e:	0007069b          	sext.w	a3,a4
   13b92:	fc442703          	lw	a4,-60(s0)
   13b96:	2701                	sext.w	a4,a4
   13b98:	863e                	mv	a2,a5
   13b9a:	85a6                	mv	a1,s1
   13b9c:	854a                	mv	a0,s2
   13b9e:	00003097          	auipc	ra,0x3
   13ba2:	1ba080e7          	jalr	442(ra) # 16d58 <__xbrtime_get_s1_agg>
   13ba6:	a011                	j	13baa <xbrtime_schar_get_nb+0xd8>
   13ba8:	0001                	nop
   13baa:	70e2                	ld	ra,56(sp)
   13bac:	7442                	ld	s0,48(sp)
   13bae:	74a2                	ld	s1,40(sp)
   13bb0:	7902                	ld	s2,32(sp)
   13bb2:	6121                	addi	sp,sp,64
   13bb4:	8082                	ret

0000000000013bb6 <xbrtime_char_get>:
   13bb6:	7139                	addi	sp,sp,-64
   13bb8:	fc06                	sd	ra,56(sp)
   13bba:	f822                	sd	s0,48(sp)
   13bbc:	f426                	sd	s1,40(sp)
   13bbe:	f04a                	sd	s2,32(sp)
   13bc0:	0080                	addi	s0,sp,64
   13bc2:	fca43c23          	sd	a0,-40(s0)
   13bc6:	fcb43823          	sd	a1,-48(s0)
   13bca:	fcc43423          	sd	a2,-56(s0)
   13bce:	87b6                	mv	a5,a3
   13bd0:	fcf42223          	sw	a5,-60(s0)
   13bd4:	87ba                	mv	a5,a4
   13bd6:	fcf42023          	sw	a5,-64(s0)
   13bda:	fc843783          	ld	a5,-56(s0)
   13bde:	cfb1                	beqz	a5,13c3a <xbrtime_char_get+0x84>
   13be0:	fc442783          	lw	a5,-60(s0)
   13be4:	0007871b          	sext.w	a4,a5
   13be8:	4785                	li	a5,1
   13bea:	00f71763          	bne	a4,a5,13bf8 <xbrtime_char_get+0x42>
   13bee:	fc843703          	ld	a4,-56(s0)
   13bf2:	4785                	li	a5,1
   13bf4:	04f71063          	bne	a4,a5,13c34 <xbrtime_char_get+0x7e>
   13bf8:	fd043783          	ld	a5,-48(s0)
   13bfc:	fc042703          	lw	a4,-64(s0)
   13c00:	85ba                	mv	a1,a4
   13c02:	853e                	mv	a0,a5
   13c04:	c17fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13c08:	892a                	mv	s2,a0
   13c0a:	fd843483          	ld	s1,-40(s0)
   13c0e:	fc042783          	lw	a5,-64(s0)
   13c12:	853e                	mv	a0,a5
   13c14:	77e020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13c18:	87aa                	mv	a5,a0
   13c1a:	2781                	sext.w	a5,a5
   13c1c:	fc843703          	ld	a4,-56(s0)
   13c20:	0007069b          	sext.w	a3,a4
   13c24:	fc442703          	lw	a4,-60(s0)
   13c28:	2701                	sext.w	a4,a4
   13c2a:	863e                	mv	a2,a5
   13c2c:	85a6                	mv	a1,s1
   13c2e:	854a                	mv	a0,s2
   13c30:	080030ef          	jal	ra,16cb0 <__xbrtime_get_u1_agg>
   13c34:	31a030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   13c38:	a011                	j	13c3c <xbrtime_char_get+0x86>
   13c3a:	0001                	nop
   13c3c:	70e2                	ld	ra,56(sp)
   13c3e:	7442                	ld	s0,48(sp)
   13c40:	74a2                	ld	s1,40(sp)
   13c42:	7902                	ld	s2,32(sp)
   13c44:	6121                	addi	sp,sp,64
   13c46:	8082                	ret

0000000000013c48 <xbrtime_char_get_nb>:
   13c48:	7139                	addi	sp,sp,-64
   13c4a:	fc06                	sd	ra,56(sp)
   13c4c:	f822                	sd	s0,48(sp)
   13c4e:	f426                	sd	s1,40(sp)
   13c50:	f04a                	sd	s2,32(sp)
   13c52:	0080                	addi	s0,sp,64
   13c54:	fca43c23          	sd	a0,-40(s0)
   13c58:	fcb43823          	sd	a1,-48(s0)
   13c5c:	fcc43423          	sd	a2,-56(s0)
   13c60:	87b6                	mv	a5,a3
   13c62:	fcf42223          	sw	a5,-60(s0)
   13c66:	87ba                	mv	a5,a4
   13c68:	fcf42023          	sw	a5,-64(s0)
   13c6c:	fc843783          	ld	a5,-56(s0)
   13c70:	c7dd                	beqz	a5,13d1e <xbrtime_char_get_nb+0xd6>
   13c72:	fc442783          	lw	a5,-60(s0)
   13c76:	0007871b          	sext.w	a4,a5
   13c7a:	4785                	li	a5,1
   13c7c:	00f71763          	bne	a4,a5,13c8a <xbrtime_char_get_nb+0x42>
   13c80:	fc843703          	ld	a4,-56(s0)
   13c84:	4785                	li	a5,1
   13c86:	04f71763          	bne	a4,a5,13cd4 <xbrtime_char_get_nb+0x8c>
   13c8a:	fd043783          	ld	a5,-48(s0)
   13c8e:	fc042703          	lw	a4,-64(s0)
   13c92:	85ba                	mv	a1,a4
   13c94:	853e                	mv	a0,a5
   13c96:	ffffd097          	auipc	ra,0xffffd
   13c9a:	b84080e7          	jalr	-1148(ra) # 1081a <__xbrtime_ltor>
   13c9e:	892a                	mv	s2,a0
   13ca0:	fd843483          	ld	s1,-40(s0)
   13ca4:	fc042783          	lw	a5,-64(s0)
   13ca8:	853e                	mv	a0,a5
   13caa:	00002097          	auipc	ra,0x2
   13cae:	6e8080e7          	jalr	1768(ra) # 16392 <xbrtime_decode_pe>
   13cb2:	87aa                	mv	a5,a0
   13cb4:	2781                	sext.w	a5,a5
   13cb6:	fc843703          	ld	a4,-56(s0)
   13cba:	0007069b          	sext.w	a3,a4
   13cbe:	fc442703          	lw	a4,-60(s0)
   13cc2:	2701                	sext.w	a4,a4
   13cc4:	863e                	mv	a2,a5
   13cc6:	85a6                	mv	a1,s1
   13cc8:	854a                	mv	a0,s2
   13cca:	00003097          	auipc	ra,0x3
   13cce:	fca080e7          	jalr	-54(ra) # 16c94 <__xbrtime_get_u1_seq>
   13cd2:	a0b9                	j	13d20 <xbrtime_char_get_nb+0xd8>
   13cd4:	fd043783          	ld	a5,-48(s0)
   13cd8:	fc042703          	lw	a4,-64(s0)
   13cdc:	85ba                	mv	a1,a4
   13cde:	853e                	mv	a0,a5
   13ce0:	ffffd097          	auipc	ra,0xffffd
   13ce4:	b3a080e7          	jalr	-1222(ra) # 1081a <__xbrtime_ltor>
   13ce8:	892a                	mv	s2,a0
   13cea:	fd843483          	ld	s1,-40(s0)
   13cee:	fc042783          	lw	a5,-64(s0)
   13cf2:	853e                	mv	a0,a5
   13cf4:	00002097          	auipc	ra,0x2
   13cf8:	69e080e7          	jalr	1694(ra) # 16392 <xbrtime_decode_pe>
   13cfc:	87aa                	mv	a5,a0
   13cfe:	2781                	sext.w	a5,a5
   13d00:	fc843703          	ld	a4,-56(s0)
   13d04:	0007069b          	sext.w	a3,a4
   13d08:	fc442703          	lw	a4,-60(s0)
   13d0c:	2701                	sext.w	a4,a4
   13d0e:	863e                	mv	a2,a5
   13d10:	85a6                	mv	a1,s1
   13d12:	854a                	mv	a0,s2
   13d14:	00003097          	auipc	ra,0x3
   13d18:	f9c080e7          	jalr	-100(ra) # 16cb0 <__xbrtime_get_u1_agg>
   13d1c:	a011                	j	13d20 <xbrtime_char_get_nb+0xd8>
   13d1e:	0001                	nop
   13d20:	70e2                	ld	ra,56(sp)
   13d22:	7442                	ld	s0,48(sp)
   13d24:	74a2                	ld	s1,40(sp)
   13d26:	7902                	ld	s2,32(sp)
   13d28:	6121                	addi	sp,sp,64
   13d2a:	8082                	ret

0000000000013d2c <xbrtime_short_get>:
   13d2c:	7139                	addi	sp,sp,-64
   13d2e:	fc06                	sd	ra,56(sp)
   13d30:	f822                	sd	s0,48(sp)
   13d32:	f426                	sd	s1,40(sp)
   13d34:	f04a                	sd	s2,32(sp)
   13d36:	0080                	addi	s0,sp,64
   13d38:	fca43c23          	sd	a0,-40(s0)
   13d3c:	fcb43823          	sd	a1,-48(s0)
   13d40:	fcc43423          	sd	a2,-56(s0)
   13d44:	87b6                	mv	a5,a3
   13d46:	fcf42223          	sw	a5,-60(s0)
   13d4a:	87ba                	mv	a5,a4
   13d4c:	fcf42023          	sw	a5,-64(s0)
   13d50:	fc843783          	ld	a5,-56(s0)
   13d54:	c7cd                	beqz	a5,13dfe <xbrtime_short_get+0xd2>
   13d56:	fc442783          	lw	a5,-60(s0)
   13d5a:	0007871b          	sext.w	a4,a5
   13d5e:	4785                	li	a5,1
   13d60:	00f71763          	bne	a4,a5,13d6e <xbrtime_short_get+0x42>
   13d64:	fc843703          	ld	a4,-56(s0)
   13d68:	4785                	li	a5,1
   13d6a:	04f71563          	bne	a4,a5,13db4 <xbrtime_short_get+0x88>
   13d6e:	fd043783          	ld	a5,-48(s0)
   13d72:	fc042703          	lw	a4,-64(s0)
   13d76:	85ba                	mv	a1,a4
   13d78:	853e                	mv	a0,a5
   13d7a:	aa1fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13d7e:	892a                	mv	s2,a0
   13d80:	fd843483          	ld	s1,-40(s0)
   13d84:	fc042783          	lw	a5,-64(s0)
   13d88:	853e                	mv	a0,a5
   13d8a:	608020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13d8e:	87aa                	mv	a5,a0
   13d90:	0007861b          	sext.w	a2,a5
   13d94:	fc843783          	ld	a5,-56(s0)
   13d98:	0007869b          	sext.w	a3,a5
   13d9c:	fc442783          	lw	a5,-60(s0)
   13da0:	2781                	sext.w	a5,a5
   13da2:	0017979b          	slliw	a5,a5,0x1
   13da6:	2781                	sext.w	a5,a5
   13da8:	873e                	mv	a4,a5
   13daa:	85a6                	mv	a1,s1
   13dac:	854a                	mv	a0,s2
   13dae:	7b9020ef          	jal	ra,16d66 <__xbrtime_get_s2_seq>
   13db2:	a099                	j	13df8 <xbrtime_short_get+0xcc>
   13db4:	fd043783          	ld	a5,-48(s0)
   13db8:	fc042703          	lw	a4,-64(s0)
   13dbc:	85ba                	mv	a1,a4
   13dbe:	853e                	mv	a0,a5
   13dc0:	a5bfc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13dc4:	892a                	mv	s2,a0
   13dc6:	fd843483          	ld	s1,-40(s0)
   13dca:	fc042783          	lw	a5,-64(s0)
   13dce:	853e                	mv	a0,a5
   13dd0:	5c2020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13dd4:	87aa                	mv	a5,a0
   13dd6:	0007861b          	sext.w	a2,a5
   13dda:	fc843783          	ld	a5,-56(s0)
   13dde:	0007869b          	sext.w	a3,a5
   13de2:	fc442783          	lw	a5,-60(s0)
   13de6:	2781                	sext.w	a5,a5
   13de8:	0017979b          	slliw	a5,a5,0x1
   13dec:	2781                	sext.w	a5,a5
   13dee:	873e                	mv	a4,a5
   13df0:	85a6                	mv	a1,s1
   13df2:	854a                	mv	a0,s2
   13df4:	78f020ef          	jal	ra,16d82 <__xbrtime_get_s2_agg>
   13df8:	156030ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   13dfc:	a011                	j	13e00 <xbrtime_short_get+0xd4>
   13dfe:	0001                	nop
   13e00:	70e2                	ld	ra,56(sp)
   13e02:	7442                	ld	s0,48(sp)
   13e04:	74a2                	ld	s1,40(sp)
   13e06:	7902                	ld	s2,32(sp)
   13e08:	6121                	addi	sp,sp,64
   13e0a:	8082                	ret

0000000000013e0c <xbrtime_short_get_nb>:
   13e0c:	7139                	addi	sp,sp,-64
   13e0e:	fc06                	sd	ra,56(sp)
   13e10:	f822                	sd	s0,48(sp)
   13e12:	f426                	sd	s1,40(sp)
   13e14:	f04a                	sd	s2,32(sp)
   13e16:	0080                	addi	s0,sp,64
   13e18:	fca43c23          	sd	a0,-40(s0)
   13e1c:	fcb43823          	sd	a1,-48(s0)
   13e20:	fcc43423          	sd	a2,-56(s0)
   13e24:	87b6                	mv	a5,a3
   13e26:	fcf42223          	sw	a5,-60(s0)
   13e2a:	87ba                	mv	a5,a4
   13e2c:	fcf42023          	sw	a5,-64(s0)
   13e30:	fc843783          	ld	a5,-56(s0)
   13e34:	cfdd                	beqz	a5,13ef2 <xbrtime_short_get_nb+0xe6>
   13e36:	fc442783          	lw	a5,-60(s0)
   13e3a:	0007871b          	sext.w	a4,a5
   13e3e:	4785                	li	a5,1
   13e40:	00f71763          	bne	a4,a5,13e4e <xbrtime_short_get_nb+0x42>
   13e44:	fc843703          	ld	a4,-56(s0)
   13e48:	4785                	li	a5,1
   13e4a:	04f71b63          	bne	a4,a5,13ea0 <xbrtime_short_get_nb+0x94>
   13e4e:	fd043783          	ld	a5,-48(s0)
   13e52:	fc042703          	lw	a4,-64(s0)
   13e56:	85ba                	mv	a1,a4
   13e58:	853e                	mv	a0,a5
   13e5a:	ffffd097          	auipc	ra,0xffffd
   13e5e:	9c0080e7          	jalr	-1600(ra) # 1081a <__xbrtime_ltor>
   13e62:	892a                	mv	s2,a0
   13e64:	fd843483          	ld	s1,-40(s0)
   13e68:	fc042783          	lw	a5,-64(s0)
   13e6c:	853e                	mv	a0,a5
   13e6e:	00002097          	auipc	ra,0x2
   13e72:	524080e7          	jalr	1316(ra) # 16392 <xbrtime_decode_pe>
   13e76:	87aa                	mv	a5,a0
   13e78:	0007861b          	sext.w	a2,a5
   13e7c:	fc843783          	ld	a5,-56(s0)
   13e80:	0007869b          	sext.w	a3,a5
   13e84:	fc442783          	lw	a5,-60(s0)
   13e88:	2781                	sext.w	a5,a5
   13e8a:	0017979b          	slliw	a5,a5,0x1
   13e8e:	2781                	sext.w	a5,a5
   13e90:	873e                	mv	a4,a5
   13e92:	85a6                	mv	a1,s1
   13e94:	854a                	mv	a0,s2
   13e96:	00003097          	auipc	ra,0x3
   13e9a:	ed0080e7          	jalr	-304(ra) # 16d66 <__xbrtime_get_s2_seq>
   13e9e:	a899                	j	13ef4 <xbrtime_short_get_nb+0xe8>
   13ea0:	fd043783          	ld	a5,-48(s0)
   13ea4:	fc042703          	lw	a4,-64(s0)
   13ea8:	85ba                	mv	a1,a4
   13eaa:	853e                	mv	a0,a5
   13eac:	ffffd097          	auipc	ra,0xffffd
   13eb0:	96e080e7          	jalr	-1682(ra) # 1081a <__xbrtime_ltor>
   13eb4:	892a                	mv	s2,a0
   13eb6:	fd843483          	ld	s1,-40(s0)
   13eba:	fc042783          	lw	a5,-64(s0)
   13ebe:	853e                	mv	a0,a5
   13ec0:	00002097          	auipc	ra,0x2
   13ec4:	4d2080e7          	jalr	1234(ra) # 16392 <xbrtime_decode_pe>
   13ec8:	87aa                	mv	a5,a0
   13eca:	0007861b          	sext.w	a2,a5
   13ece:	fc843783          	ld	a5,-56(s0)
   13ed2:	0007869b          	sext.w	a3,a5
   13ed6:	fc442783          	lw	a5,-60(s0)
   13eda:	2781                	sext.w	a5,a5
   13edc:	0017979b          	slliw	a5,a5,0x1
   13ee0:	2781                	sext.w	a5,a5
   13ee2:	873e                	mv	a4,a5
   13ee4:	85a6                	mv	a1,s1
   13ee6:	854a                	mv	a0,s2
   13ee8:	00003097          	auipc	ra,0x3
   13eec:	e9a080e7          	jalr	-358(ra) # 16d82 <__xbrtime_get_s2_agg>
   13ef0:	a011                	j	13ef4 <xbrtime_short_get_nb+0xe8>
   13ef2:	0001                	nop
   13ef4:	70e2                	ld	ra,56(sp)
   13ef6:	7442                	ld	s0,48(sp)
   13ef8:	74a2                	ld	s1,40(sp)
   13efa:	7902                	ld	s2,32(sp)
   13efc:	6121                	addi	sp,sp,64
   13efe:	8082                	ret

0000000000013f00 <xbrtime_int_get>:
   13f00:	7139                	addi	sp,sp,-64
   13f02:	fc06                	sd	ra,56(sp)
   13f04:	f822                	sd	s0,48(sp)
   13f06:	f426                	sd	s1,40(sp)
   13f08:	f04a                	sd	s2,32(sp)
   13f0a:	0080                	addi	s0,sp,64
   13f0c:	fca43c23          	sd	a0,-40(s0)
   13f10:	fcb43823          	sd	a1,-48(s0)
   13f14:	fcc43423          	sd	a2,-56(s0)
   13f18:	87b6                	mv	a5,a3
   13f1a:	fcf42223          	sw	a5,-60(s0)
   13f1e:	87ba                	mv	a5,a4
   13f20:	fcf42023          	sw	a5,-64(s0)
   13f24:	fc843783          	ld	a5,-56(s0)
   13f28:	c7cd                	beqz	a5,13fd2 <xbrtime_int_get+0xd2>
   13f2a:	fc442783          	lw	a5,-60(s0)
   13f2e:	0007871b          	sext.w	a4,a5
   13f32:	4785                	li	a5,1
   13f34:	00f71763          	bne	a4,a5,13f42 <xbrtime_int_get+0x42>
   13f38:	fc843703          	ld	a4,-56(s0)
   13f3c:	4785                	li	a5,1
   13f3e:	04f71563          	bne	a4,a5,13f88 <xbrtime_int_get+0x88>
   13f42:	fd043783          	ld	a5,-48(s0)
   13f46:	fc042703          	lw	a4,-64(s0)
   13f4a:	85ba                	mv	a1,a4
   13f4c:	853e                	mv	a0,a5
   13f4e:	8cdfc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13f52:	892a                	mv	s2,a0
   13f54:	fd843483          	ld	s1,-40(s0)
   13f58:	fc042783          	lw	a5,-64(s0)
   13f5c:	853e                	mv	a0,a5
   13f5e:	434020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13f62:	87aa                	mv	a5,a0
   13f64:	0007861b          	sext.w	a2,a5
   13f68:	fc843783          	ld	a5,-56(s0)
   13f6c:	0007869b          	sext.w	a3,a5
   13f70:	fc442783          	lw	a5,-60(s0)
   13f74:	2781                	sext.w	a5,a5
   13f76:	0027979b          	slliw	a5,a5,0x2
   13f7a:	2781                	sext.w	a5,a5
   13f7c:	873e                	mv	a4,a5
   13f7e:	85a6                	mv	a1,s1
   13f80:	854a                	mv	a0,s2
   13f82:	60f020ef          	jal	ra,16d90 <__xbrtime_get_s4_seq>
   13f86:	a099                	j	13fcc <xbrtime_int_get+0xcc>
   13f88:	fd043783          	ld	a5,-48(s0)
   13f8c:	fc042703          	lw	a4,-64(s0)
   13f90:	85ba                	mv	a1,a4
   13f92:	853e                	mv	a0,a5
   13f94:	887fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   13f98:	892a                	mv	s2,a0
   13f9a:	fd843483          	ld	s1,-40(s0)
   13f9e:	fc042783          	lw	a5,-64(s0)
   13fa2:	853e                	mv	a0,a5
   13fa4:	3ee020ef          	jal	ra,16392 <xbrtime_decode_pe>
   13fa8:	87aa                	mv	a5,a0
   13faa:	0007861b          	sext.w	a2,a5
   13fae:	fc843783          	ld	a5,-56(s0)
   13fb2:	0007869b          	sext.w	a3,a5
   13fb6:	fc442783          	lw	a5,-60(s0)
   13fba:	2781                	sext.w	a5,a5
   13fbc:	0027979b          	slliw	a5,a5,0x2
   13fc0:	2781                	sext.w	a5,a5
   13fc2:	873e                	mv	a4,a5
   13fc4:	85a6                	mv	a1,s1
   13fc6:	854a                	mv	a0,s2
   13fc8:	5e5020ef          	jal	ra,16dac <__xbrtime_get_s4_agg>
   13fcc:	783020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   13fd0:	a011                	j	13fd4 <xbrtime_int_get+0xd4>
   13fd2:	0001                	nop
   13fd4:	70e2                	ld	ra,56(sp)
   13fd6:	7442                	ld	s0,48(sp)
   13fd8:	74a2                	ld	s1,40(sp)
   13fda:	7902                	ld	s2,32(sp)
   13fdc:	6121                	addi	sp,sp,64
   13fde:	8082                	ret

0000000000013fe0 <xbrtime_int_get_nb>:
   13fe0:	7139                	addi	sp,sp,-64
   13fe2:	fc06                	sd	ra,56(sp)
   13fe4:	f822                	sd	s0,48(sp)
   13fe6:	f426                	sd	s1,40(sp)
   13fe8:	f04a                	sd	s2,32(sp)
   13fea:	0080                	addi	s0,sp,64
   13fec:	fca43c23          	sd	a0,-40(s0)
   13ff0:	fcb43823          	sd	a1,-48(s0)
   13ff4:	fcc43423          	sd	a2,-56(s0)
   13ff8:	87b6                	mv	a5,a3
   13ffa:	fcf42223          	sw	a5,-60(s0)
   13ffe:	87ba                	mv	a5,a4
   14000:	fcf42023          	sw	a5,-64(s0)
   14004:	fc843783          	ld	a5,-56(s0)
   14008:	cfdd                	beqz	a5,140c6 <xbrtime_int_get_nb+0xe6>
   1400a:	fc442783          	lw	a5,-60(s0)
   1400e:	0007871b          	sext.w	a4,a5
   14012:	4785                	li	a5,1
   14014:	00f71763          	bne	a4,a5,14022 <xbrtime_int_get_nb+0x42>
   14018:	fc843703          	ld	a4,-56(s0)
   1401c:	4785                	li	a5,1
   1401e:	04f71b63          	bne	a4,a5,14074 <xbrtime_int_get_nb+0x94>
   14022:	fd043783          	ld	a5,-48(s0)
   14026:	fc042703          	lw	a4,-64(s0)
   1402a:	85ba                	mv	a1,a4
   1402c:	853e                	mv	a0,a5
   1402e:	ffffc097          	auipc	ra,0xffffc
   14032:	7ec080e7          	jalr	2028(ra) # 1081a <__xbrtime_ltor>
   14036:	892a                	mv	s2,a0
   14038:	fd843483          	ld	s1,-40(s0)
   1403c:	fc042783          	lw	a5,-64(s0)
   14040:	853e                	mv	a0,a5
   14042:	00002097          	auipc	ra,0x2
   14046:	350080e7          	jalr	848(ra) # 16392 <xbrtime_decode_pe>
   1404a:	87aa                	mv	a5,a0
   1404c:	0007861b          	sext.w	a2,a5
   14050:	fc843783          	ld	a5,-56(s0)
   14054:	0007869b          	sext.w	a3,a5
   14058:	fc442783          	lw	a5,-60(s0)
   1405c:	2781                	sext.w	a5,a5
   1405e:	0017979b          	slliw	a5,a5,0x1
   14062:	2781                	sext.w	a5,a5
   14064:	873e                	mv	a4,a5
   14066:	85a6                	mv	a1,s1
   14068:	854a                	mv	a0,s2
   1406a:	00003097          	auipc	ra,0x3
   1406e:	d26080e7          	jalr	-730(ra) # 16d90 <__xbrtime_get_s4_seq>
   14072:	a899                	j	140c8 <xbrtime_int_get_nb+0xe8>
   14074:	fd043783          	ld	a5,-48(s0)
   14078:	fc042703          	lw	a4,-64(s0)
   1407c:	85ba                	mv	a1,a4
   1407e:	853e                	mv	a0,a5
   14080:	ffffc097          	auipc	ra,0xffffc
   14084:	79a080e7          	jalr	1946(ra) # 1081a <__xbrtime_ltor>
   14088:	892a                	mv	s2,a0
   1408a:	fd843483          	ld	s1,-40(s0)
   1408e:	fc042783          	lw	a5,-64(s0)
   14092:	853e                	mv	a0,a5
   14094:	00002097          	auipc	ra,0x2
   14098:	2fe080e7          	jalr	766(ra) # 16392 <xbrtime_decode_pe>
   1409c:	87aa                	mv	a5,a0
   1409e:	0007861b          	sext.w	a2,a5
   140a2:	fc843783          	ld	a5,-56(s0)
   140a6:	0007869b          	sext.w	a3,a5
   140aa:	fc442783          	lw	a5,-60(s0)
   140ae:	2781                	sext.w	a5,a5
   140b0:	0017979b          	slliw	a5,a5,0x1
   140b4:	2781                	sext.w	a5,a5
   140b6:	873e                	mv	a4,a5
   140b8:	85a6                	mv	a1,s1
   140ba:	854a                	mv	a0,s2
   140bc:	00003097          	auipc	ra,0x3
   140c0:	cf0080e7          	jalr	-784(ra) # 16dac <__xbrtime_get_s4_agg>
   140c4:	a011                	j	140c8 <xbrtime_int_get_nb+0xe8>
   140c6:	0001                	nop
   140c8:	70e2                	ld	ra,56(sp)
   140ca:	7442                	ld	s0,48(sp)
   140cc:	74a2                	ld	s1,40(sp)
   140ce:	7902                	ld	s2,32(sp)
   140d0:	6121                	addi	sp,sp,64
   140d2:	8082                	ret

00000000000140d4 <xbrtime_long_get>:
   140d4:	7139                	addi	sp,sp,-64
   140d6:	fc06                	sd	ra,56(sp)
   140d8:	f822                	sd	s0,48(sp)
   140da:	f426                	sd	s1,40(sp)
   140dc:	f04a                	sd	s2,32(sp)
   140de:	0080                	addi	s0,sp,64
   140e0:	fca43c23          	sd	a0,-40(s0)
   140e4:	fcb43823          	sd	a1,-48(s0)
   140e8:	fcc43423          	sd	a2,-56(s0)
   140ec:	87b6                	mv	a5,a3
   140ee:	fcf42223          	sw	a5,-60(s0)
   140f2:	87ba                	mv	a5,a4
   140f4:	fcf42023          	sw	a5,-64(s0)
   140f8:	fc843783          	ld	a5,-56(s0)
   140fc:	c7cd                	beqz	a5,141a6 <xbrtime_long_get+0xd2>
   140fe:	fc442783          	lw	a5,-60(s0)
   14102:	0007871b          	sext.w	a4,a5
   14106:	4785                	li	a5,1
   14108:	00f71763          	bne	a4,a5,14116 <xbrtime_long_get+0x42>
   1410c:	fc843703          	ld	a4,-56(s0)
   14110:	4785                	li	a5,1
   14112:	04f71563          	bne	a4,a5,1415c <xbrtime_long_get+0x88>
   14116:	fd043783          	ld	a5,-48(s0)
   1411a:	fc042703          	lw	a4,-64(s0)
   1411e:	85ba                	mv	a1,a4
   14120:	853e                	mv	a0,a5
   14122:	ef8fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   14126:	892a                	mv	s2,a0
   14128:	fd843483          	ld	s1,-40(s0)
   1412c:	fc042783          	lw	a5,-64(s0)
   14130:	853e                	mv	a0,a5
   14132:	260020ef          	jal	ra,16392 <xbrtime_decode_pe>
   14136:	87aa                	mv	a5,a0
   14138:	0007861b          	sext.w	a2,a5
   1413c:	fc843783          	ld	a5,-56(s0)
   14140:	0007869b          	sext.w	a3,a5
   14144:	fc442783          	lw	a5,-60(s0)
   14148:	2781                	sext.w	a5,a5
   1414a:	0037979b          	slliw	a5,a5,0x3
   1414e:	2781                	sext.w	a5,a5
   14150:	873e                	mv	a4,a5
   14152:	85a6                	mv	a1,s1
   14154:	854a                	mv	a0,s2
   14156:	43b020ef          	jal	ra,16d90 <__xbrtime_get_s4_seq>
   1415a:	a099                	j	141a0 <xbrtime_long_get+0xcc>
   1415c:	fd043783          	ld	a5,-48(s0)
   14160:	fc042703          	lw	a4,-64(s0)
   14164:	85ba                	mv	a1,a4
   14166:	853e                	mv	a0,a5
   14168:	eb2fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   1416c:	892a                	mv	s2,a0
   1416e:	fd843483          	ld	s1,-40(s0)
   14172:	fc042783          	lw	a5,-64(s0)
   14176:	853e                	mv	a0,a5
   14178:	21a020ef          	jal	ra,16392 <xbrtime_decode_pe>
   1417c:	87aa                	mv	a5,a0
   1417e:	0007861b          	sext.w	a2,a5
   14182:	fc843783          	ld	a5,-56(s0)
   14186:	0007869b          	sext.w	a3,a5
   1418a:	fc442783          	lw	a5,-60(s0)
   1418e:	2781                	sext.w	a5,a5
   14190:	0037979b          	slliw	a5,a5,0x3
   14194:	2781                	sext.w	a5,a5
   14196:	873e                	mv	a4,a5
   14198:	85a6                	mv	a1,s1
   1419a:	854a                	mv	a0,s2
   1419c:	411020ef          	jal	ra,16dac <__xbrtime_get_s4_agg>
   141a0:	5af020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   141a4:	a011                	j	141a8 <xbrtime_long_get+0xd4>
   141a6:	0001                	nop
   141a8:	70e2                	ld	ra,56(sp)
   141aa:	7442                	ld	s0,48(sp)
   141ac:	74a2                	ld	s1,40(sp)
   141ae:	7902                	ld	s2,32(sp)
   141b0:	6121                	addi	sp,sp,64
   141b2:	8082                	ret

00000000000141b4 <xbrtime_long_get_nb>:
   141b4:	7139                	addi	sp,sp,-64
   141b6:	fc06                	sd	ra,56(sp)
   141b8:	f822                	sd	s0,48(sp)
   141ba:	f426                	sd	s1,40(sp)
   141bc:	f04a                	sd	s2,32(sp)
   141be:	0080                	addi	s0,sp,64
   141c0:	fca43c23          	sd	a0,-40(s0)
   141c4:	fcb43823          	sd	a1,-48(s0)
   141c8:	fcc43423          	sd	a2,-56(s0)
   141cc:	87b6                	mv	a5,a3
   141ce:	fcf42223          	sw	a5,-60(s0)
   141d2:	87ba                	mv	a5,a4
   141d4:	fcf42023          	sw	a5,-64(s0)
   141d8:	fc843783          	ld	a5,-56(s0)
   141dc:	cfdd                	beqz	a5,1429a <xbrtime_long_get_nb+0xe6>
   141de:	fc442783          	lw	a5,-60(s0)
   141e2:	0007871b          	sext.w	a4,a5
   141e6:	4785                	li	a5,1
   141e8:	00f71763          	bne	a4,a5,141f6 <xbrtime_long_get_nb+0x42>
   141ec:	fc843703          	ld	a4,-56(s0)
   141f0:	4785                	li	a5,1
   141f2:	04f71b63          	bne	a4,a5,14248 <xbrtime_long_get_nb+0x94>
   141f6:	fd043783          	ld	a5,-48(s0)
   141fa:	fc042703          	lw	a4,-64(s0)
   141fe:	85ba                	mv	a1,a4
   14200:	853e                	mv	a0,a5
   14202:	ffffc097          	auipc	ra,0xffffc
   14206:	618080e7          	jalr	1560(ra) # 1081a <__xbrtime_ltor>
   1420a:	892a                	mv	s2,a0
   1420c:	fd843483          	ld	s1,-40(s0)
   14210:	fc042783          	lw	a5,-64(s0)
   14214:	853e                	mv	a0,a5
   14216:	00002097          	auipc	ra,0x2
   1421a:	17c080e7          	jalr	380(ra) # 16392 <xbrtime_decode_pe>
   1421e:	87aa                	mv	a5,a0
   14220:	0007861b          	sext.w	a2,a5
   14224:	fc843783          	ld	a5,-56(s0)
   14228:	0007869b          	sext.w	a3,a5
   1422c:	fc442783          	lw	a5,-60(s0)
   14230:	2781                	sext.w	a5,a5
   14232:	0037979b          	slliw	a5,a5,0x3
   14236:	2781                	sext.w	a5,a5
   14238:	873e                	mv	a4,a5
   1423a:	85a6                	mv	a1,s1
   1423c:	854a                	mv	a0,s2
   1423e:	00003097          	auipc	ra,0x3
   14242:	b52080e7          	jalr	-1198(ra) # 16d90 <__xbrtime_get_s4_seq>
   14246:	a899                	j	1429c <xbrtime_long_get_nb+0xe8>
   14248:	fd043783          	ld	a5,-48(s0)
   1424c:	fc042703          	lw	a4,-64(s0)
   14250:	85ba                	mv	a1,a4
   14252:	853e                	mv	a0,a5
   14254:	ffffc097          	auipc	ra,0xffffc
   14258:	5c6080e7          	jalr	1478(ra) # 1081a <__xbrtime_ltor>
   1425c:	892a                	mv	s2,a0
   1425e:	fd843483          	ld	s1,-40(s0)
   14262:	fc042783          	lw	a5,-64(s0)
   14266:	853e                	mv	a0,a5
   14268:	00002097          	auipc	ra,0x2
   1426c:	12a080e7          	jalr	298(ra) # 16392 <xbrtime_decode_pe>
   14270:	87aa                	mv	a5,a0
   14272:	0007861b          	sext.w	a2,a5
   14276:	fc843783          	ld	a5,-56(s0)
   1427a:	0007869b          	sext.w	a3,a5
   1427e:	fc442783          	lw	a5,-60(s0)
   14282:	2781                	sext.w	a5,a5
   14284:	0037979b          	slliw	a5,a5,0x3
   14288:	2781                	sext.w	a5,a5
   1428a:	873e                	mv	a4,a5
   1428c:	85a6                	mv	a1,s1
   1428e:	854a                	mv	a0,s2
   14290:	00003097          	auipc	ra,0x3
   14294:	b1c080e7          	jalr	-1252(ra) # 16dac <__xbrtime_get_s4_agg>
   14298:	a011                	j	1429c <xbrtime_long_get_nb+0xe8>
   1429a:	0001                	nop
   1429c:	70e2                	ld	ra,56(sp)
   1429e:	7442                	ld	s0,48(sp)
   142a0:	74a2                	ld	s1,40(sp)
   142a2:	7902                	ld	s2,32(sp)
   142a4:	6121                	addi	sp,sp,64
   142a6:	8082                	ret

00000000000142a8 <xbrtime_longlong_get>:
   142a8:	7139                	addi	sp,sp,-64
   142aa:	fc06                	sd	ra,56(sp)
   142ac:	f822                	sd	s0,48(sp)
   142ae:	f426                	sd	s1,40(sp)
   142b0:	f04a                	sd	s2,32(sp)
   142b2:	0080                	addi	s0,sp,64
   142b4:	fca43c23          	sd	a0,-40(s0)
   142b8:	fcb43823          	sd	a1,-48(s0)
   142bc:	fcc43423          	sd	a2,-56(s0)
   142c0:	87b6                	mv	a5,a3
   142c2:	fcf42223          	sw	a5,-60(s0)
   142c6:	87ba                	mv	a5,a4
   142c8:	fcf42023          	sw	a5,-64(s0)
   142cc:	fc843783          	ld	a5,-56(s0)
   142d0:	c7cd                	beqz	a5,1437a <xbrtime_longlong_get+0xd2>
   142d2:	fc442783          	lw	a5,-60(s0)
   142d6:	0007871b          	sext.w	a4,a5
   142da:	4785                	li	a5,1
   142dc:	00f71763          	bne	a4,a5,142ea <xbrtime_longlong_get+0x42>
   142e0:	fc843703          	ld	a4,-56(s0)
   142e4:	4785                	li	a5,1
   142e6:	04f71563          	bne	a4,a5,14330 <xbrtime_longlong_get+0x88>
   142ea:	fd043783          	ld	a5,-48(s0)
   142ee:	fc042703          	lw	a4,-64(s0)
   142f2:	85ba                	mv	a1,a4
   142f4:	853e                	mv	a0,a5
   142f6:	d24fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   142fa:	892a                	mv	s2,a0
   142fc:	fd843483          	ld	s1,-40(s0)
   14300:	fc042783          	lw	a5,-64(s0)
   14304:	853e                	mv	a0,a5
   14306:	08c020ef          	jal	ra,16392 <xbrtime_decode_pe>
   1430a:	87aa                	mv	a5,a0
   1430c:	0007861b          	sext.w	a2,a5
   14310:	fc843783          	ld	a5,-56(s0)
   14314:	0007869b          	sext.w	a3,a5
   14318:	fc442783          	lw	a5,-60(s0)
   1431c:	2781                	sext.w	a5,a5
   1431e:	0037979b          	slliw	a5,a5,0x3
   14322:	2781                	sext.w	a5,a5
   14324:	873e                	mv	a4,a5
   14326:	85a6                	mv	a1,s1
   14328:	854a                	mv	a0,s2
   1432a:	291020ef          	jal	ra,16dba <__xbrtime_get_s8_seq>
   1432e:	a099                	j	14374 <xbrtime_longlong_get+0xcc>
   14330:	fd043783          	ld	a5,-48(s0)
   14334:	fc042703          	lw	a4,-64(s0)
   14338:	85ba                	mv	a1,a4
   1433a:	853e                	mv	a0,a5
   1433c:	cdefc0ef          	jal	ra,1081a <__xbrtime_ltor>
   14340:	892a                	mv	s2,a0
   14342:	fd843483          	ld	s1,-40(s0)
   14346:	fc042783          	lw	a5,-64(s0)
   1434a:	853e                	mv	a0,a5
   1434c:	046020ef          	jal	ra,16392 <xbrtime_decode_pe>
   14350:	87aa                	mv	a5,a0
   14352:	0007861b          	sext.w	a2,a5
   14356:	fc843783          	ld	a5,-56(s0)
   1435a:	0007869b          	sext.w	a3,a5
   1435e:	fc442783          	lw	a5,-60(s0)
   14362:	2781                	sext.w	a5,a5
   14364:	0037979b          	slliw	a5,a5,0x3
   14368:	2781                	sext.w	a5,a5
   1436a:	873e                	mv	a4,a5
   1436c:	85a6                	mv	a1,s1
   1436e:	854a                	mv	a0,s2
   14370:	267020ef          	jal	ra,16dd6 <__xbrtime_get_s8_agg>
   14374:	3db020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   14378:	a011                	j	1437c <xbrtime_longlong_get+0xd4>
   1437a:	0001                	nop
   1437c:	70e2                	ld	ra,56(sp)
   1437e:	7442                	ld	s0,48(sp)
   14380:	74a2                	ld	s1,40(sp)
   14382:	7902                	ld	s2,32(sp)
   14384:	6121                	addi	sp,sp,64
   14386:	8082                	ret

0000000000014388 <xbrtime_longlong_get_nb>:
   14388:	7139                	addi	sp,sp,-64
   1438a:	fc06                	sd	ra,56(sp)
   1438c:	f822                	sd	s0,48(sp)
   1438e:	f426                	sd	s1,40(sp)
   14390:	f04a                	sd	s2,32(sp)
   14392:	0080                	addi	s0,sp,64
   14394:	fca43c23          	sd	a0,-40(s0)
   14398:	fcb43823          	sd	a1,-48(s0)
   1439c:	fcc43423          	sd	a2,-56(s0)
   143a0:	87b6                	mv	a5,a3
   143a2:	fcf42223          	sw	a5,-60(s0)
   143a6:	87ba                	mv	a5,a4
   143a8:	fcf42023          	sw	a5,-64(s0)
   143ac:	fc843783          	ld	a5,-56(s0)
   143b0:	cfdd                	beqz	a5,1446e <xbrtime_longlong_get_nb+0xe6>
   143b2:	fc442783          	lw	a5,-60(s0)
   143b6:	0007871b          	sext.w	a4,a5
   143ba:	4785                	li	a5,1
   143bc:	00f71763          	bne	a4,a5,143ca <xbrtime_longlong_get_nb+0x42>
   143c0:	fc843703          	ld	a4,-56(s0)
   143c4:	4785                	li	a5,1
   143c6:	04f71b63          	bne	a4,a5,1441c <xbrtime_longlong_get_nb+0x94>
   143ca:	fd043783          	ld	a5,-48(s0)
   143ce:	fc042703          	lw	a4,-64(s0)
   143d2:	85ba                	mv	a1,a4
   143d4:	853e                	mv	a0,a5
   143d6:	ffffc097          	auipc	ra,0xffffc
   143da:	444080e7          	jalr	1092(ra) # 1081a <__xbrtime_ltor>
   143de:	892a                	mv	s2,a0
   143e0:	fd843483          	ld	s1,-40(s0)
   143e4:	fc042783          	lw	a5,-64(s0)
   143e8:	853e                	mv	a0,a5
   143ea:	00002097          	auipc	ra,0x2
   143ee:	fa8080e7          	jalr	-88(ra) # 16392 <xbrtime_decode_pe>
   143f2:	87aa                	mv	a5,a0
   143f4:	0007861b          	sext.w	a2,a5
   143f8:	fc843783          	ld	a5,-56(s0)
   143fc:	0007869b          	sext.w	a3,a5
   14400:	fc442783          	lw	a5,-60(s0)
   14404:	2781                	sext.w	a5,a5
   14406:	0037979b          	slliw	a5,a5,0x3
   1440a:	2781                	sext.w	a5,a5
   1440c:	873e                	mv	a4,a5
   1440e:	85a6                	mv	a1,s1
   14410:	854a                	mv	a0,s2
   14412:	00003097          	auipc	ra,0x3
   14416:	9a8080e7          	jalr	-1624(ra) # 16dba <__xbrtime_get_s8_seq>
   1441a:	a899                	j	14470 <xbrtime_longlong_get_nb+0xe8>
   1441c:	fd043783          	ld	a5,-48(s0)
   14420:	fc042703          	lw	a4,-64(s0)
   14424:	85ba                	mv	a1,a4
   14426:	853e                	mv	a0,a5
   14428:	ffffc097          	auipc	ra,0xffffc
   1442c:	3f2080e7          	jalr	1010(ra) # 1081a <__xbrtime_ltor>
   14430:	892a                	mv	s2,a0
   14432:	fd843483          	ld	s1,-40(s0)
   14436:	fc042783          	lw	a5,-64(s0)
   1443a:	853e                	mv	a0,a5
   1443c:	00002097          	auipc	ra,0x2
   14440:	f56080e7          	jalr	-170(ra) # 16392 <xbrtime_decode_pe>
   14444:	87aa                	mv	a5,a0
   14446:	0007861b          	sext.w	a2,a5
   1444a:	fc843783          	ld	a5,-56(s0)
   1444e:	0007869b          	sext.w	a3,a5
   14452:	fc442783          	lw	a5,-60(s0)
   14456:	2781                	sext.w	a5,a5
   14458:	0037979b          	slliw	a5,a5,0x3
   1445c:	2781                	sext.w	a5,a5
   1445e:	873e                	mv	a4,a5
   14460:	85a6                	mv	a1,s1
   14462:	854a                	mv	a0,s2
   14464:	00003097          	auipc	ra,0x3
   14468:	972080e7          	jalr	-1678(ra) # 16dd6 <__xbrtime_get_s8_agg>
   1446c:	a011                	j	14470 <xbrtime_longlong_get_nb+0xe8>
   1446e:	0001                	nop
   14470:	70e2                	ld	ra,56(sp)
   14472:	7442                	ld	s0,48(sp)
   14474:	74a2                	ld	s1,40(sp)
   14476:	7902                	ld	s2,32(sp)
   14478:	6121                	addi	sp,sp,64
   1447a:	8082                	ret

000000000001447c <xbrtime_uchar_get>:
   1447c:	7139                	addi	sp,sp,-64
   1447e:	fc06                	sd	ra,56(sp)
   14480:	f822                	sd	s0,48(sp)
   14482:	f426                	sd	s1,40(sp)
   14484:	f04a                	sd	s2,32(sp)
   14486:	0080                	addi	s0,sp,64
   14488:	fca43c23          	sd	a0,-40(s0)
   1448c:	fcb43823          	sd	a1,-48(s0)
   14490:	fcc43423          	sd	a2,-56(s0)
   14494:	87b6                	mv	a5,a3
   14496:	fcf42223          	sw	a5,-60(s0)
   1449a:	87ba                	mv	a5,a4
   1449c:	fcf42023          	sw	a5,-64(s0)
   144a0:	fc843783          	ld	a5,-56(s0)
   144a4:	cfc9                	beqz	a5,1453e <xbrtime_uchar_get+0xc2>
   144a6:	fc442783          	lw	a5,-60(s0)
   144aa:	0007871b          	sext.w	a4,a5
   144ae:	4785                	li	a5,1
   144b0:	00f71763          	bne	a4,a5,144be <xbrtime_uchar_get+0x42>
   144b4:	fc843703          	ld	a4,-56(s0)
   144b8:	4785                	li	a5,1
   144ba:	04f71163          	bne	a4,a5,144fc <xbrtime_uchar_get+0x80>
   144be:	fd043783          	ld	a5,-48(s0)
   144c2:	fc042703          	lw	a4,-64(s0)
   144c6:	85ba                	mv	a1,a4
   144c8:	853e                	mv	a0,a5
   144ca:	b50fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   144ce:	892a                	mv	s2,a0
   144d0:	fd843483          	ld	s1,-40(s0)
   144d4:	fc042783          	lw	a5,-64(s0)
   144d8:	853e                	mv	a0,a5
   144da:	6b9010ef          	jal	ra,16392 <xbrtime_decode_pe>
   144de:	87aa                	mv	a5,a0
   144e0:	2781                	sext.w	a5,a5
   144e2:	fc843703          	ld	a4,-56(s0)
   144e6:	0007069b          	sext.w	a3,a4
   144ea:	fc442703          	lw	a4,-60(s0)
   144ee:	2701                	sext.w	a4,a4
   144f0:	863e                	mv	a2,a5
   144f2:	85a6                	mv	a1,s1
   144f4:	854a                	mv	a0,s2
   144f6:	79e020ef          	jal	ra,16c94 <__xbrtime_get_u1_seq>
   144fa:	a83d                	j	14538 <xbrtime_uchar_get+0xbc>
   144fc:	fd043783          	ld	a5,-48(s0)
   14500:	fc042703          	lw	a4,-64(s0)
   14504:	85ba                	mv	a1,a4
   14506:	853e                	mv	a0,a5
   14508:	b12fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   1450c:	892a                	mv	s2,a0
   1450e:	fd843483          	ld	s1,-40(s0)
   14512:	fc042783          	lw	a5,-64(s0)
   14516:	853e                	mv	a0,a5
   14518:	67b010ef          	jal	ra,16392 <xbrtime_decode_pe>
   1451c:	87aa                	mv	a5,a0
   1451e:	2781                	sext.w	a5,a5
   14520:	fc843703          	ld	a4,-56(s0)
   14524:	0007069b          	sext.w	a3,a4
   14528:	fc442703          	lw	a4,-60(s0)
   1452c:	2701                	sext.w	a4,a4
   1452e:	863e                	mv	a2,a5
   14530:	85a6                	mv	a1,s1
   14532:	854a                	mv	a0,s2
   14534:	77c020ef          	jal	ra,16cb0 <__xbrtime_get_u1_agg>
   14538:	217020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   1453c:	a011                	j	14540 <xbrtime_uchar_get+0xc4>
   1453e:	0001                	nop
   14540:	70e2                	ld	ra,56(sp)
   14542:	7442                	ld	s0,48(sp)
   14544:	74a2                	ld	s1,40(sp)
   14546:	7902                	ld	s2,32(sp)
   14548:	6121                	addi	sp,sp,64
   1454a:	8082                	ret

000000000001454c <xbrtime_uchar_get_nb>:
   1454c:	7139                	addi	sp,sp,-64
   1454e:	fc06                	sd	ra,56(sp)
   14550:	f822                	sd	s0,48(sp)
   14552:	f426                	sd	s1,40(sp)
   14554:	f04a                	sd	s2,32(sp)
   14556:	0080                	addi	s0,sp,64
   14558:	fca43c23          	sd	a0,-40(s0)
   1455c:	fcb43823          	sd	a1,-48(s0)
   14560:	fcc43423          	sd	a2,-56(s0)
   14564:	87b6                	mv	a5,a3
   14566:	fcf42223          	sw	a5,-60(s0)
   1456a:	87ba                	mv	a5,a4
   1456c:	fcf42023          	sw	a5,-64(s0)
   14570:	fc843783          	ld	a5,-56(s0)
   14574:	c7dd                	beqz	a5,14622 <xbrtime_uchar_get_nb+0xd6>
   14576:	fc442783          	lw	a5,-60(s0)
   1457a:	0007871b          	sext.w	a4,a5
   1457e:	4785                	li	a5,1
   14580:	00f71763          	bne	a4,a5,1458e <xbrtime_uchar_get_nb+0x42>
   14584:	fc843703          	ld	a4,-56(s0)
   14588:	4785                	li	a5,1
   1458a:	04f71763          	bne	a4,a5,145d8 <xbrtime_uchar_get_nb+0x8c>
   1458e:	fd043783          	ld	a5,-48(s0)
   14592:	fc042703          	lw	a4,-64(s0)
   14596:	85ba                	mv	a1,a4
   14598:	853e                	mv	a0,a5
   1459a:	ffffc097          	auipc	ra,0xffffc
   1459e:	280080e7          	jalr	640(ra) # 1081a <__xbrtime_ltor>
   145a2:	892a                	mv	s2,a0
   145a4:	fd843483          	ld	s1,-40(s0)
   145a8:	fc042783          	lw	a5,-64(s0)
   145ac:	853e                	mv	a0,a5
   145ae:	00002097          	auipc	ra,0x2
   145b2:	de4080e7          	jalr	-540(ra) # 16392 <xbrtime_decode_pe>
   145b6:	87aa                	mv	a5,a0
   145b8:	2781                	sext.w	a5,a5
   145ba:	fc843703          	ld	a4,-56(s0)
   145be:	0007069b          	sext.w	a3,a4
   145c2:	fc442703          	lw	a4,-60(s0)
   145c6:	2701                	sext.w	a4,a4
   145c8:	863e                	mv	a2,a5
   145ca:	85a6                	mv	a1,s1
   145cc:	854a                	mv	a0,s2
   145ce:	00002097          	auipc	ra,0x2
   145d2:	6c6080e7          	jalr	1734(ra) # 16c94 <__xbrtime_get_u1_seq>
   145d6:	a0b9                	j	14624 <xbrtime_uchar_get_nb+0xd8>
   145d8:	fd043783          	ld	a5,-48(s0)
   145dc:	fc042703          	lw	a4,-64(s0)
   145e0:	85ba                	mv	a1,a4
   145e2:	853e                	mv	a0,a5
   145e4:	ffffc097          	auipc	ra,0xffffc
   145e8:	236080e7          	jalr	566(ra) # 1081a <__xbrtime_ltor>
   145ec:	892a                	mv	s2,a0
   145ee:	fd843483          	ld	s1,-40(s0)
   145f2:	fc042783          	lw	a5,-64(s0)
   145f6:	853e                	mv	a0,a5
   145f8:	00002097          	auipc	ra,0x2
   145fc:	d9a080e7          	jalr	-614(ra) # 16392 <xbrtime_decode_pe>
   14600:	87aa                	mv	a5,a0
   14602:	2781                	sext.w	a5,a5
   14604:	fc843703          	ld	a4,-56(s0)
   14608:	0007069b          	sext.w	a3,a4
   1460c:	fc442703          	lw	a4,-60(s0)
   14610:	2701                	sext.w	a4,a4
   14612:	863e                	mv	a2,a5
   14614:	85a6                	mv	a1,s1
   14616:	854a                	mv	a0,s2
   14618:	00002097          	auipc	ra,0x2
   1461c:	698080e7          	jalr	1688(ra) # 16cb0 <__xbrtime_get_u1_agg>
   14620:	a011                	j	14624 <xbrtime_uchar_get_nb+0xd8>
   14622:	0001                	nop
   14624:	70e2                	ld	ra,56(sp)
   14626:	7442                	ld	s0,48(sp)
   14628:	74a2                	ld	s1,40(sp)
   1462a:	7902                	ld	s2,32(sp)
   1462c:	6121                	addi	sp,sp,64
   1462e:	8082                	ret

0000000000014630 <xbrtime_ushort_get>:
   14630:	7139                	addi	sp,sp,-64
   14632:	fc06                	sd	ra,56(sp)
   14634:	f822                	sd	s0,48(sp)
   14636:	f426                	sd	s1,40(sp)
   14638:	f04a                	sd	s2,32(sp)
   1463a:	0080                	addi	s0,sp,64
   1463c:	fca43c23          	sd	a0,-40(s0)
   14640:	fcb43823          	sd	a1,-48(s0)
   14644:	fcc43423          	sd	a2,-56(s0)
   14648:	87b6                	mv	a5,a3
   1464a:	fcf42223          	sw	a5,-60(s0)
   1464e:	87ba                	mv	a5,a4
   14650:	fcf42023          	sw	a5,-64(s0)
   14654:	fc843783          	ld	a5,-56(s0)
   14658:	c7cd                	beqz	a5,14702 <xbrtime_ushort_get+0xd2>
   1465a:	fc442783          	lw	a5,-60(s0)
   1465e:	0007871b          	sext.w	a4,a5
   14662:	4785                	li	a5,1
   14664:	00f71763          	bne	a4,a5,14672 <xbrtime_ushort_get+0x42>
   14668:	fc843703          	ld	a4,-56(s0)
   1466c:	4785                	li	a5,1
   1466e:	04f71563          	bne	a4,a5,146b8 <xbrtime_ushort_get+0x88>
   14672:	fd043783          	ld	a5,-48(s0)
   14676:	fc042703          	lw	a4,-64(s0)
   1467a:	85ba                	mv	a1,a4
   1467c:	853e                	mv	a0,a5
   1467e:	99cfc0ef          	jal	ra,1081a <__xbrtime_ltor>
   14682:	892a                	mv	s2,a0
   14684:	fd843483          	ld	s1,-40(s0)
   14688:	fc042783          	lw	a5,-64(s0)
   1468c:	853e                	mv	a0,a5
   1468e:	505010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14692:	87aa                	mv	a5,a0
   14694:	0007861b          	sext.w	a2,a5
   14698:	fc843783          	ld	a5,-56(s0)
   1469c:	0007869b          	sext.w	a3,a5
   146a0:	fc442783          	lw	a5,-60(s0)
   146a4:	2781                	sext.w	a5,a5
   146a6:	0017979b          	slliw	a5,a5,0x1
   146aa:	2781                	sext.w	a5,a5
   146ac:	873e                	mv	a4,a5
   146ae:	85a6                	mv	a1,s1
   146b0:	854a                	mv	a0,s2
   146b2:	60c020ef          	jal	ra,16cbe <__xbrtime_get_u2_seq>
   146b6:	a099                	j	146fc <xbrtime_ushort_get+0xcc>
   146b8:	fd043783          	ld	a5,-48(s0)
   146bc:	fc042703          	lw	a4,-64(s0)
   146c0:	85ba                	mv	a1,a4
   146c2:	853e                	mv	a0,a5
   146c4:	956fc0ef          	jal	ra,1081a <__xbrtime_ltor>
   146c8:	892a                	mv	s2,a0
   146ca:	fd843483          	ld	s1,-40(s0)
   146ce:	fc042783          	lw	a5,-64(s0)
   146d2:	853e                	mv	a0,a5
   146d4:	4bf010ef          	jal	ra,16392 <xbrtime_decode_pe>
   146d8:	87aa                	mv	a5,a0
   146da:	0007861b          	sext.w	a2,a5
   146de:	fc843783          	ld	a5,-56(s0)
   146e2:	0007869b          	sext.w	a3,a5
   146e6:	fc442783          	lw	a5,-60(s0)
   146ea:	2781                	sext.w	a5,a5
   146ec:	0017979b          	slliw	a5,a5,0x1
   146f0:	2781                	sext.w	a5,a5
   146f2:	873e                	mv	a4,a5
   146f4:	85a6                	mv	a1,s1
   146f6:	854a                	mv	a0,s2
   146f8:	5e2020ef          	jal	ra,16cda <__xbrtime_get_u2_agg>
   146fc:	053020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   14700:	a011                	j	14704 <xbrtime_ushort_get+0xd4>
   14702:	0001                	nop
   14704:	70e2                	ld	ra,56(sp)
   14706:	7442                	ld	s0,48(sp)
   14708:	74a2                	ld	s1,40(sp)
   1470a:	7902                	ld	s2,32(sp)
   1470c:	6121                	addi	sp,sp,64
   1470e:	8082                	ret

0000000000014710 <xbrtime_ushort_get_nb>:
   14710:	7139                	addi	sp,sp,-64
   14712:	fc06                	sd	ra,56(sp)
   14714:	f822                	sd	s0,48(sp)
   14716:	f426                	sd	s1,40(sp)
   14718:	f04a                	sd	s2,32(sp)
   1471a:	0080                	addi	s0,sp,64
   1471c:	fca43c23          	sd	a0,-40(s0)
   14720:	fcb43823          	sd	a1,-48(s0)
   14724:	fcc43423          	sd	a2,-56(s0)
   14728:	87b6                	mv	a5,a3
   1472a:	fcf42223          	sw	a5,-60(s0)
   1472e:	87ba                	mv	a5,a4
   14730:	fcf42023          	sw	a5,-64(s0)
   14734:	fc843783          	ld	a5,-56(s0)
   14738:	cfdd                	beqz	a5,147f6 <xbrtime_ushort_get_nb+0xe6>
   1473a:	fc442783          	lw	a5,-60(s0)
   1473e:	0007871b          	sext.w	a4,a5
   14742:	4785                	li	a5,1
   14744:	00f71763          	bne	a4,a5,14752 <xbrtime_ushort_get_nb+0x42>
   14748:	fc843703          	ld	a4,-56(s0)
   1474c:	4785                	li	a5,1
   1474e:	04f71b63          	bne	a4,a5,147a4 <xbrtime_ushort_get_nb+0x94>
   14752:	fd043783          	ld	a5,-48(s0)
   14756:	fc042703          	lw	a4,-64(s0)
   1475a:	85ba                	mv	a1,a4
   1475c:	853e                	mv	a0,a5
   1475e:	ffffc097          	auipc	ra,0xffffc
   14762:	0bc080e7          	jalr	188(ra) # 1081a <__xbrtime_ltor>
   14766:	892a                	mv	s2,a0
   14768:	fd843483          	ld	s1,-40(s0)
   1476c:	fc042783          	lw	a5,-64(s0)
   14770:	853e                	mv	a0,a5
   14772:	00002097          	auipc	ra,0x2
   14776:	c20080e7          	jalr	-992(ra) # 16392 <xbrtime_decode_pe>
   1477a:	87aa                	mv	a5,a0
   1477c:	0007861b          	sext.w	a2,a5
   14780:	fc843783          	ld	a5,-56(s0)
   14784:	0007869b          	sext.w	a3,a5
   14788:	fc442783          	lw	a5,-60(s0)
   1478c:	2781                	sext.w	a5,a5
   1478e:	0017979b          	slliw	a5,a5,0x1
   14792:	2781                	sext.w	a5,a5
   14794:	873e                	mv	a4,a5
   14796:	85a6                	mv	a1,s1
   14798:	854a                	mv	a0,s2
   1479a:	00002097          	auipc	ra,0x2
   1479e:	524080e7          	jalr	1316(ra) # 16cbe <__xbrtime_get_u2_seq>
   147a2:	a899                	j	147f8 <xbrtime_ushort_get_nb+0xe8>
   147a4:	fd043783          	ld	a5,-48(s0)
   147a8:	fc042703          	lw	a4,-64(s0)
   147ac:	85ba                	mv	a1,a4
   147ae:	853e                	mv	a0,a5
   147b0:	ffffc097          	auipc	ra,0xffffc
   147b4:	06a080e7          	jalr	106(ra) # 1081a <__xbrtime_ltor>
   147b8:	892a                	mv	s2,a0
   147ba:	fd843483          	ld	s1,-40(s0)
   147be:	fc042783          	lw	a5,-64(s0)
   147c2:	853e                	mv	a0,a5
   147c4:	00002097          	auipc	ra,0x2
   147c8:	bce080e7          	jalr	-1074(ra) # 16392 <xbrtime_decode_pe>
   147cc:	87aa                	mv	a5,a0
   147ce:	0007861b          	sext.w	a2,a5
   147d2:	fc843783          	ld	a5,-56(s0)
   147d6:	0007869b          	sext.w	a3,a5
   147da:	fc442783          	lw	a5,-60(s0)
   147de:	2781                	sext.w	a5,a5
   147e0:	0017979b          	slliw	a5,a5,0x1
   147e4:	2781                	sext.w	a5,a5
   147e6:	873e                	mv	a4,a5
   147e8:	85a6                	mv	a1,s1
   147ea:	854a                	mv	a0,s2
   147ec:	00002097          	auipc	ra,0x2
   147f0:	4ee080e7          	jalr	1262(ra) # 16cda <__xbrtime_get_u2_agg>
   147f4:	a011                	j	147f8 <xbrtime_ushort_get_nb+0xe8>
   147f6:	0001                	nop
   147f8:	70e2                	ld	ra,56(sp)
   147fa:	7442                	ld	s0,48(sp)
   147fc:	74a2                	ld	s1,40(sp)
   147fe:	7902                	ld	s2,32(sp)
   14800:	6121                	addi	sp,sp,64
   14802:	8082                	ret

0000000000014804 <xbrtime_uint_get>:
   14804:	7139                	addi	sp,sp,-64
   14806:	fc06                	sd	ra,56(sp)
   14808:	f822                	sd	s0,48(sp)
   1480a:	f426                	sd	s1,40(sp)
   1480c:	f04a                	sd	s2,32(sp)
   1480e:	0080                	addi	s0,sp,64
   14810:	fca43c23          	sd	a0,-40(s0)
   14814:	fcb43823          	sd	a1,-48(s0)
   14818:	fcc43423          	sd	a2,-56(s0)
   1481c:	87b6                	mv	a5,a3
   1481e:	fcf42223          	sw	a5,-60(s0)
   14822:	87ba                	mv	a5,a4
   14824:	fcf42023          	sw	a5,-64(s0)
   14828:	fc843783          	ld	a5,-56(s0)
   1482c:	c7cd                	beqz	a5,148d6 <xbrtime_uint_get+0xd2>
   1482e:	fc442783          	lw	a5,-60(s0)
   14832:	0007871b          	sext.w	a4,a5
   14836:	4785                	li	a5,1
   14838:	00f71763          	bne	a4,a5,14846 <xbrtime_uint_get+0x42>
   1483c:	fc843703          	ld	a4,-56(s0)
   14840:	4785                	li	a5,1
   14842:	04f71563          	bne	a4,a5,1488c <xbrtime_uint_get+0x88>
   14846:	fd043783          	ld	a5,-48(s0)
   1484a:	fc042703          	lw	a4,-64(s0)
   1484e:	85ba                	mv	a1,a4
   14850:	853e                	mv	a0,a5
   14852:	fc9fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14856:	892a                	mv	s2,a0
   14858:	fd843483          	ld	s1,-40(s0)
   1485c:	fc042783          	lw	a5,-64(s0)
   14860:	853e                	mv	a0,a5
   14862:	331010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14866:	87aa                	mv	a5,a0
   14868:	0007861b          	sext.w	a2,a5
   1486c:	fc843783          	ld	a5,-56(s0)
   14870:	0007869b          	sext.w	a3,a5
   14874:	fc442783          	lw	a5,-60(s0)
   14878:	2781                	sext.w	a5,a5
   1487a:	0027979b          	slliw	a5,a5,0x2
   1487e:	2781                	sext.w	a5,a5
   14880:	873e                	mv	a4,a5
   14882:	85a6                	mv	a1,s1
   14884:	854a                	mv	a0,s2
   14886:	462020ef          	jal	ra,16ce8 <__xbrtime_get_u4_seq>
   1488a:	a099                	j	148d0 <xbrtime_uint_get+0xcc>
   1488c:	fd043783          	ld	a5,-48(s0)
   14890:	fc042703          	lw	a4,-64(s0)
   14894:	85ba                	mv	a1,a4
   14896:	853e                	mv	a0,a5
   14898:	f83fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   1489c:	892a                	mv	s2,a0
   1489e:	fd843483          	ld	s1,-40(s0)
   148a2:	fc042783          	lw	a5,-64(s0)
   148a6:	853e                	mv	a0,a5
   148a8:	2eb010ef          	jal	ra,16392 <xbrtime_decode_pe>
   148ac:	87aa                	mv	a5,a0
   148ae:	0007861b          	sext.w	a2,a5
   148b2:	fc843783          	ld	a5,-56(s0)
   148b6:	0007869b          	sext.w	a3,a5
   148ba:	fc442783          	lw	a5,-60(s0)
   148be:	2781                	sext.w	a5,a5
   148c0:	0027979b          	slliw	a5,a5,0x2
   148c4:	2781                	sext.w	a5,a5
   148c6:	873e                	mv	a4,a5
   148c8:	85a6                	mv	a1,s1
   148ca:	854a                	mv	a0,s2
   148cc:	438020ef          	jal	ra,16d04 <__xbrtime_get_u4_agg>
   148d0:	67e020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   148d4:	a011                	j	148d8 <xbrtime_uint_get+0xd4>
   148d6:	0001                	nop
   148d8:	70e2                	ld	ra,56(sp)
   148da:	7442                	ld	s0,48(sp)
   148dc:	74a2                	ld	s1,40(sp)
   148de:	7902                	ld	s2,32(sp)
   148e0:	6121                	addi	sp,sp,64
   148e2:	8082                	ret

00000000000148e4 <xbrtime_uint_get_nb>:
   148e4:	7139                	addi	sp,sp,-64
   148e6:	fc06                	sd	ra,56(sp)
   148e8:	f822                	sd	s0,48(sp)
   148ea:	f426                	sd	s1,40(sp)
   148ec:	f04a                	sd	s2,32(sp)
   148ee:	0080                	addi	s0,sp,64
   148f0:	fca43c23          	sd	a0,-40(s0)
   148f4:	fcb43823          	sd	a1,-48(s0)
   148f8:	fcc43423          	sd	a2,-56(s0)
   148fc:	87b6                	mv	a5,a3
   148fe:	fcf42223          	sw	a5,-60(s0)
   14902:	87ba                	mv	a5,a4
   14904:	fcf42023          	sw	a5,-64(s0)
   14908:	fc843783          	ld	a5,-56(s0)
   1490c:	cfdd                	beqz	a5,149ca <xbrtime_uint_get_nb+0xe6>
   1490e:	fc442783          	lw	a5,-60(s0)
   14912:	0007871b          	sext.w	a4,a5
   14916:	4785                	li	a5,1
   14918:	00f71763          	bne	a4,a5,14926 <xbrtime_uint_get_nb+0x42>
   1491c:	fc843703          	ld	a4,-56(s0)
   14920:	4785                	li	a5,1
   14922:	04f71b63          	bne	a4,a5,14978 <xbrtime_uint_get_nb+0x94>
   14926:	fd043783          	ld	a5,-48(s0)
   1492a:	fc042703          	lw	a4,-64(s0)
   1492e:	85ba                	mv	a1,a4
   14930:	853e                	mv	a0,a5
   14932:	ffffc097          	auipc	ra,0xffffc
   14936:	ee8080e7          	jalr	-280(ra) # 1081a <__xbrtime_ltor>
   1493a:	892a                	mv	s2,a0
   1493c:	fd843483          	ld	s1,-40(s0)
   14940:	fc042783          	lw	a5,-64(s0)
   14944:	853e                	mv	a0,a5
   14946:	00002097          	auipc	ra,0x2
   1494a:	a4c080e7          	jalr	-1460(ra) # 16392 <xbrtime_decode_pe>
   1494e:	87aa                	mv	a5,a0
   14950:	0007861b          	sext.w	a2,a5
   14954:	fc843783          	ld	a5,-56(s0)
   14958:	0007869b          	sext.w	a3,a5
   1495c:	fc442783          	lw	a5,-60(s0)
   14960:	2781                	sext.w	a5,a5
   14962:	0027979b          	slliw	a5,a5,0x2
   14966:	2781                	sext.w	a5,a5
   14968:	873e                	mv	a4,a5
   1496a:	85a6                	mv	a1,s1
   1496c:	854a                	mv	a0,s2
   1496e:	00002097          	auipc	ra,0x2
   14972:	37a080e7          	jalr	890(ra) # 16ce8 <__xbrtime_get_u4_seq>
   14976:	a899                	j	149cc <xbrtime_uint_get_nb+0xe8>
   14978:	fd043783          	ld	a5,-48(s0)
   1497c:	fc042703          	lw	a4,-64(s0)
   14980:	85ba                	mv	a1,a4
   14982:	853e                	mv	a0,a5
   14984:	ffffc097          	auipc	ra,0xffffc
   14988:	e96080e7          	jalr	-362(ra) # 1081a <__xbrtime_ltor>
   1498c:	892a                	mv	s2,a0
   1498e:	fd843483          	ld	s1,-40(s0)
   14992:	fc042783          	lw	a5,-64(s0)
   14996:	853e                	mv	a0,a5
   14998:	00002097          	auipc	ra,0x2
   1499c:	9fa080e7          	jalr	-1542(ra) # 16392 <xbrtime_decode_pe>
   149a0:	87aa                	mv	a5,a0
   149a2:	0007861b          	sext.w	a2,a5
   149a6:	fc843783          	ld	a5,-56(s0)
   149aa:	0007869b          	sext.w	a3,a5
   149ae:	fc442783          	lw	a5,-60(s0)
   149b2:	2781                	sext.w	a5,a5
   149b4:	0027979b          	slliw	a5,a5,0x2
   149b8:	2781                	sext.w	a5,a5
   149ba:	873e                	mv	a4,a5
   149bc:	85a6                	mv	a1,s1
   149be:	854a                	mv	a0,s2
   149c0:	00002097          	auipc	ra,0x2
   149c4:	344080e7          	jalr	836(ra) # 16d04 <__xbrtime_get_u4_agg>
   149c8:	a011                	j	149cc <xbrtime_uint_get_nb+0xe8>
   149ca:	0001                	nop
   149cc:	70e2                	ld	ra,56(sp)
   149ce:	7442                	ld	s0,48(sp)
   149d0:	74a2                	ld	s1,40(sp)
   149d2:	7902                	ld	s2,32(sp)
   149d4:	6121                	addi	sp,sp,64
   149d6:	8082                	ret

00000000000149d8 <xbrtime_ulong_get>:
   149d8:	7139                	addi	sp,sp,-64
   149da:	fc06                	sd	ra,56(sp)
   149dc:	f822                	sd	s0,48(sp)
   149de:	f426                	sd	s1,40(sp)
   149e0:	f04a                	sd	s2,32(sp)
   149e2:	0080                	addi	s0,sp,64
   149e4:	fca43c23          	sd	a0,-40(s0)
   149e8:	fcb43823          	sd	a1,-48(s0)
   149ec:	fcc43423          	sd	a2,-56(s0)
   149f0:	87b6                	mv	a5,a3
   149f2:	fcf42223          	sw	a5,-60(s0)
   149f6:	87ba                	mv	a5,a4
   149f8:	fcf42023          	sw	a5,-64(s0)
   149fc:	fc843783          	ld	a5,-56(s0)
   14a00:	c7cd                	beqz	a5,14aaa <xbrtime_ulong_get+0xd2>
   14a02:	fc442783          	lw	a5,-60(s0)
   14a06:	0007871b          	sext.w	a4,a5
   14a0a:	4785                	li	a5,1
   14a0c:	00f71763          	bne	a4,a5,14a1a <xbrtime_ulong_get+0x42>
   14a10:	fc843703          	ld	a4,-56(s0)
   14a14:	4785                	li	a5,1
   14a16:	04f71563          	bne	a4,a5,14a60 <xbrtime_ulong_get+0x88>
   14a1a:	fd043783          	ld	a5,-48(s0)
   14a1e:	fc042703          	lw	a4,-64(s0)
   14a22:	85ba                	mv	a1,a4
   14a24:	853e                	mv	a0,a5
   14a26:	df5fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14a2a:	892a                	mv	s2,a0
   14a2c:	fd843483          	ld	s1,-40(s0)
   14a30:	fc042783          	lw	a5,-64(s0)
   14a34:	853e                	mv	a0,a5
   14a36:	15d010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14a3a:	87aa                	mv	a5,a0
   14a3c:	0007861b          	sext.w	a2,a5
   14a40:	fc843783          	ld	a5,-56(s0)
   14a44:	0007869b          	sext.w	a3,a5
   14a48:	fc442783          	lw	a5,-60(s0)
   14a4c:	2781                	sext.w	a5,a5
   14a4e:	0037979b          	slliw	a5,a5,0x3
   14a52:	2781                	sext.w	a5,a5
   14a54:	873e                	mv	a4,a5
   14a56:	85a6                	mv	a1,s1
   14a58:	854a                	mv	a0,s2
   14a5a:	28e020ef          	jal	ra,16ce8 <__xbrtime_get_u4_seq>
   14a5e:	a099                	j	14aa4 <xbrtime_ulong_get+0xcc>
   14a60:	fd043783          	ld	a5,-48(s0)
   14a64:	fc042703          	lw	a4,-64(s0)
   14a68:	85ba                	mv	a1,a4
   14a6a:	853e                	mv	a0,a5
   14a6c:	daffb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14a70:	892a                	mv	s2,a0
   14a72:	fd843483          	ld	s1,-40(s0)
   14a76:	fc042783          	lw	a5,-64(s0)
   14a7a:	853e                	mv	a0,a5
   14a7c:	117010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14a80:	87aa                	mv	a5,a0
   14a82:	0007861b          	sext.w	a2,a5
   14a86:	fc843783          	ld	a5,-56(s0)
   14a8a:	0007869b          	sext.w	a3,a5
   14a8e:	fc442783          	lw	a5,-60(s0)
   14a92:	2781                	sext.w	a5,a5
   14a94:	0037979b          	slliw	a5,a5,0x3
   14a98:	2781                	sext.w	a5,a5
   14a9a:	873e                	mv	a4,a5
   14a9c:	85a6                	mv	a1,s1
   14a9e:	854a                	mv	a0,s2
   14aa0:	264020ef          	jal	ra,16d04 <__xbrtime_get_u4_agg>
   14aa4:	4aa020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   14aa8:	a011                	j	14aac <xbrtime_ulong_get+0xd4>
   14aaa:	0001                	nop
   14aac:	70e2                	ld	ra,56(sp)
   14aae:	7442                	ld	s0,48(sp)
   14ab0:	74a2                	ld	s1,40(sp)
   14ab2:	7902                	ld	s2,32(sp)
   14ab4:	6121                	addi	sp,sp,64
   14ab6:	8082                	ret

0000000000014ab8 <xbrtime_ulong_get_nb>:
   14ab8:	7139                	addi	sp,sp,-64
   14aba:	fc06                	sd	ra,56(sp)
   14abc:	f822                	sd	s0,48(sp)
   14abe:	f426                	sd	s1,40(sp)
   14ac0:	f04a                	sd	s2,32(sp)
   14ac2:	0080                	addi	s0,sp,64
   14ac4:	fca43c23          	sd	a0,-40(s0)
   14ac8:	fcb43823          	sd	a1,-48(s0)
   14acc:	fcc43423          	sd	a2,-56(s0)
   14ad0:	87b6                	mv	a5,a3
   14ad2:	fcf42223          	sw	a5,-60(s0)
   14ad6:	87ba                	mv	a5,a4
   14ad8:	fcf42023          	sw	a5,-64(s0)
   14adc:	fc843783          	ld	a5,-56(s0)
   14ae0:	cfdd                	beqz	a5,14b9e <xbrtime_ulong_get_nb+0xe6>
   14ae2:	fc442783          	lw	a5,-60(s0)
   14ae6:	0007871b          	sext.w	a4,a5
   14aea:	4785                	li	a5,1
   14aec:	00f71763          	bne	a4,a5,14afa <xbrtime_ulong_get_nb+0x42>
   14af0:	fc843703          	ld	a4,-56(s0)
   14af4:	4785                	li	a5,1
   14af6:	04f71b63          	bne	a4,a5,14b4c <xbrtime_ulong_get_nb+0x94>
   14afa:	fd043783          	ld	a5,-48(s0)
   14afe:	fc042703          	lw	a4,-64(s0)
   14b02:	85ba                	mv	a1,a4
   14b04:	853e                	mv	a0,a5
   14b06:	ffffc097          	auipc	ra,0xffffc
   14b0a:	d14080e7          	jalr	-748(ra) # 1081a <__xbrtime_ltor>
   14b0e:	892a                	mv	s2,a0
   14b10:	fd843483          	ld	s1,-40(s0)
   14b14:	fc042783          	lw	a5,-64(s0)
   14b18:	853e                	mv	a0,a5
   14b1a:	00002097          	auipc	ra,0x2
   14b1e:	878080e7          	jalr	-1928(ra) # 16392 <xbrtime_decode_pe>
   14b22:	87aa                	mv	a5,a0
   14b24:	0007861b          	sext.w	a2,a5
   14b28:	fc843783          	ld	a5,-56(s0)
   14b2c:	0007869b          	sext.w	a3,a5
   14b30:	fc442783          	lw	a5,-60(s0)
   14b34:	2781                	sext.w	a5,a5
   14b36:	0037979b          	slliw	a5,a5,0x3
   14b3a:	2781                	sext.w	a5,a5
   14b3c:	873e                	mv	a4,a5
   14b3e:	85a6                	mv	a1,s1
   14b40:	854a                	mv	a0,s2
   14b42:	00002097          	auipc	ra,0x2
   14b46:	1a6080e7          	jalr	422(ra) # 16ce8 <__xbrtime_get_u4_seq>
   14b4a:	a899                	j	14ba0 <xbrtime_ulong_get_nb+0xe8>
   14b4c:	fd043783          	ld	a5,-48(s0)
   14b50:	fc042703          	lw	a4,-64(s0)
   14b54:	85ba                	mv	a1,a4
   14b56:	853e                	mv	a0,a5
   14b58:	ffffc097          	auipc	ra,0xffffc
   14b5c:	cc2080e7          	jalr	-830(ra) # 1081a <__xbrtime_ltor>
   14b60:	892a                	mv	s2,a0
   14b62:	fd843483          	ld	s1,-40(s0)
   14b66:	fc042783          	lw	a5,-64(s0)
   14b6a:	853e                	mv	a0,a5
   14b6c:	00002097          	auipc	ra,0x2
   14b70:	826080e7          	jalr	-2010(ra) # 16392 <xbrtime_decode_pe>
   14b74:	87aa                	mv	a5,a0
   14b76:	0007861b          	sext.w	a2,a5
   14b7a:	fc843783          	ld	a5,-56(s0)
   14b7e:	0007869b          	sext.w	a3,a5
   14b82:	fc442783          	lw	a5,-60(s0)
   14b86:	2781                	sext.w	a5,a5
   14b88:	0037979b          	slliw	a5,a5,0x3
   14b8c:	2781                	sext.w	a5,a5
   14b8e:	873e                	mv	a4,a5
   14b90:	85a6                	mv	a1,s1
   14b92:	854a                	mv	a0,s2
   14b94:	00002097          	auipc	ra,0x2
   14b98:	170080e7          	jalr	368(ra) # 16d04 <__xbrtime_get_u4_agg>
   14b9c:	a011                	j	14ba0 <xbrtime_ulong_get_nb+0xe8>
   14b9e:	0001                	nop
   14ba0:	70e2                	ld	ra,56(sp)
   14ba2:	7442                	ld	s0,48(sp)
   14ba4:	74a2                	ld	s1,40(sp)
   14ba6:	7902                	ld	s2,32(sp)
   14ba8:	6121                	addi	sp,sp,64
   14baa:	8082                	ret

0000000000014bac <xbrtime_ulonglong_get>:
   14bac:	7139                	addi	sp,sp,-64
   14bae:	fc06                	sd	ra,56(sp)
   14bb0:	f822                	sd	s0,48(sp)
   14bb2:	f426                	sd	s1,40(sp)
   14bb4:	f04a                	sd	s2,32(sp)
   14bb6:	0080                	addi	s0,sp,64
   14bb8:	fca43c23          	sd	a0,-40(s0)
   14bbc:	fcb43823          	sd	a1,-48(s0)
   14bc0:	fcc43423          	sd	a2,-56(s0)
   14bc4:	87b6                	mv	a5,a3
   14bc6:	fcf42223          	sw	a5,-60(s0)
   14bca:	87ba                	mv	a5,a4
   14bcc:	fcf42023          	sw	a5,-64(s0)
   14bd0:	fc843783          	ld	a5,-56(s0)
   14bd4:	c7cd                	beqz	a5,14c7e <xbrtime_ulonglong_get+0xd2>
   14bd6:	fc442783          	lw	a5,-60(s0)
   14bda:	0007871b          	sext.w	a4,a5
   14bde:	4785                	li	a5,1
   14be0:	00f71763          	bne	a4,a5,14bee <xbrtime_ulonglong_get+0x42>
   14be4:	fc843703          	ld	a4,-56(s0)
   14be8:	4785                	li	a5,1
   14bea:	04f71563          	bne	a4,a5,14c34 <xbrtime_ulonglong_get+0x88>
   14bee:	fd043783          	ld	a5,-48(s0)
   14bf2:	fc042703          	lw	a4,-64(s0)
   14bf6:	85ba                	mv	a1,a4
   14bf8:	853e                	mv	a0,a5
   14bfa:	c21fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14bfe:	892a                	mv	s2,a0
   14c00:	fd843483          	ld	s1,-40(s0)
   14c04:	fc042783          	lw	a5,-64(s0)
   14c08:	853e                	mv	a0,a5
   14c0a:	788010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14c0e:	87aa                	mv	a5,a0
   14c10:	0007861b          	sext.w	a2,a5
   14c14:	fc843783          	ld	a5,-56(s0)
   14c18:	0007869b          	sext.w	a3,a5
   14c1c:	fc442783          	lw	a5,-60(s0)
   14c20:	2781                	sext.w	a5,a5
   14c22:	0037979b          	slliw	a5,a5,0x3
   14c26:	2781                	sext.w	a5,a5
   14c28:	873e                	mv	a4,a5
   14c2a:	85a6                	mv	a1,s1
   14c2c:	854a                	mv	a0,s2
   14c2e:	0e4020ef          	jal	ra,16d12 <__xbrtime_get_u8_seq>
   14c32:	a099                	j	14c78 <xbrtime_ulonglong_get+0xcc>
   14c34:	fd043783          	ld	a5,-48(s0)
   14c38:	fc042703          	lw	a4,-64(s0)
   14c3c:	85ba                	mv	a1,a4
   14c3e:	853e                	mv	a0,a5
   14c40:	bdbfb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14c44:	892a                	mv	s2,a0
   14c46:	fd843483          	ld	s1,-40(s0)
   14c4a:	fc042783          	lw	a5,-64(s0)
   14c4e:	853e                	mv	a0,a5
   14c50:	742010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14c54:	87aa                	mv	a5,a0
   14c56:	0007861b          	sext.w	a2,a5
   14c5a:	fc843783          	ld	a5,-56(s0)
   14c5e:	0007869b          	sext.w	a3,a5
   14c62:	fc442783          	lw	a5,-60(s0)
   14c66:	2781                	sext.w	a5,a5
   14c68:	0037979b          	slliw	a5,a5,0x3
   14c6c:	2781                	sext.w	a5,a5
   14c6e:	873e                	mv	a4,a5
   14c70:	85a6                	mv	a1,s1
   14c72:	854a                	mv	a0,s2
   14c74:	0ba020ef          	jal	ra,16d2e <__xbrtime_get_u8_agg>
   14c78:	2d6020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   14c7c:	a011                	j	14c80 <xbrtime_ulonglong_get+0xd4>
   14c7e:	0001                	nop
   14c80:	70e2                	ld	ra,56(sp)
   14c82:	7442                	ld	s0,48(sp)
   14c84:	74a2                	ld	s1,40(sp)
   14c86:	7902                	ld	s2,32(sp)
   14c88:	6121                	addi	sp,sp,64
   14c8a:	8082                	ret

0000000000014c8c <xbrtime_ulonglong_get_nb>:
   14c8c:	7139                	addi	sp,sp,-64
   14c8e:	fc06                	sd	ra,56(sp)
   14c90:	f822                	sd	s0,48(sp)
   14c92:	f426                	sd	s1,40(sp)
   14c94:	f04a                	sd	s2,32(sp)
   14c96:	0080                	addi	s0,sp,64
   14c98:	fca43c23          	sd	a0,-40(s0)
   14c9c:	fcb43823          	sd	a1,-48(s0)
   14ca0:	fcc43423          	sd	a2,-56(s0)
   14ca4:	87b6                	mv	a5,a3
   14ca6:	fcf42223          	sw	a5,-60(s0)
   14caa:	87ba                	mv	a5,a4
   14cac:	fcf42023          	sw	a5,-64(s0)
   14cb0:	fc843783          	ld	a5,-56(s0)
   14cb4:	cfdd                	beqz	a5,14d72 <xbrtime_ulonglong_get_nb+0xe6>
   14cb6:	fc442783          	lw	a5,-60(s0)
   14cba:	0007871b          	sext.w	a4,a5
   14cbe:	4785                	li	a5,1
   14cc0:	00f71763          	bne	a4,a5,14cce <xbrtime_ulonglong_get_nb+0x42>
   14cc4:	fc843703          	ld	a4,-56(s0)
   14cc8:	4785                	li	a5,1
   14cca:	04f71b63          	bne	a4,a5,14d20 <xbrtime_ulonglong_get_nb+0x94>
   14cce:	fd043783          	ld	a5,-48(s0)
   14cd2:	fc042703          	lw	a4,-64(s0)
   14cd6:	85ba                	mv	a1,a4
   14cd8:	853e                	mv	a0,a5
   14cda:	ffffc097          	auipc	ra,0xffffc
   14cde:	b40080e7          	jalr	-1216(ra) # 1081a <__xbrtime_ltor>
   14ce2:	892a                	mv	s2,a0
   14ce4:	fd843483          	ld	s1,-40(s0)
   14ce8:	fc042783          	lw	a5,-64(s0)
   14cec:	853e                	mv	a0,a5
   14cee:	00001097          	auipc	ra,0x1
   14cf2:	6a4080e7          	jalr	1700(ra) # 16392 <xbrtime_decode_pe>
   14cf6:	87aa                	mv	a5,a0
   14cf8:	0007861b          	sext.w	a2,a5
   14cfc:	fc843783          	ld	a5,-56(s0)
   14d00:	0007869b          	sext.w	a3,a5
   14d04:	fc442783          	lw	a5,-60(s0)
   14d08:	2781                	sext.w	a5,a5
   14d0a:	0037979b          	slliw	a5,a5,0x3
   14d0e:	2781                	sext.w	a5,a5
   14d10:	873e                	mv	a4,a5
   14d12:	85a6                	mv	a1,s1
   14d14:	854a                	mv	a0,s2
   14d16:	00002097          	auipc	ra,0x2
   14d1a:	ffc080e7          	jalr	-4(ra) # 16d12 <__xbrtime_get_u8_seq>
   14d1e:	a899                	j	14d74 <xbrtime_ulonglong_get_nb+0xe8>
   14d20:	fd043783          	ld	a5,-48(s0)
   14d24:	fc042703          	lw	a4,-64(s0)
   14d28:	85ba                	mv	a1,a4
   14d2a:	853e                	mv	a0,a5
   14d2c:	ffffc097          	auipc	ra,0xffffc
   14d30:	aee080e7          	jalr	-1298(ra) # 1081a <__xbrtime_ltor>
   14d34:	892a                	mv	s2,a0
   14d36:	fd843483          	ld	s1,-40(s0)
   14d3a:	fc042783          	lw	a5,-64(s0)
   14d3e:	853e                	mv	a0,a5
   14d40:	00001097          	auipc	ra,0x1
   14d44:	652080e7          	jalr	1618(ra) # 16392 <xbrtime_decode_pe>
   14d48:	87aa                	mv	a5,a0
   14d4a:	0007861b          	sext.w	a2,a5
   14d4e:	fc843783          	ld	a5,-56(s0)
   14d52:	0007869b          	sext.w	a3,a5
   14d56:	fc442783          	lw	a5,-60(s0)
   14d5a:	2781                	sext.w	a5,a5
   14d5c:	0037979b          	slliw	a5,a5,0x3
   14d60:	2781                	sext.w	a5,a5
   14d62:	873e                	mv	a4,a5
   14d64:	85a6                	mv	a1,s1
   14d66:	854a                	mv	a0,s2
   14d68:	00002097          	auipc	ra,0x2
   14d6c:	fc6080e7          	jalr	-58(ra) # 16d2e <__xbrtime_get_u8_agg>
   14d70:	a011                	j	14d74 <xbrtime_ulonglong_get_nb+0xe8>
   14d72:	0001                	nop
   14d74:	70e2                	ld	ra,56(sp)
   14d76:	7442                	ld	s0,48(sp)
   14d78:	74a2                	ld	s1,40(sp)
   14d7a:	7902                	ld	s2,32(sp)
   14d7c:	6121                	addi	sp,sp,64
   14d7e:	8082                	ret

0000000000014d80 <xbrtime_int8_get>:
   14d80:	7139                	addi	sp,sp,-64
   14d82:	fc06                	sd	ra,56(sp)
   14d84:	f822                	sd	s0,48(sp)
   14d86:	f426                	sd	s1,40(sp)
   14d88:	f04a                	sd	s2,32(sp)
   14d8a:	0080                	addi	s0,sp,64
   14d8c:	fca43c23          	sd	a0,-40(s0)
   14d90:	fcb43823          	sd	a1,-48(s0)
   14d94:	fcc43423          	sd	a2,-56(s0)
   14d98:	87b6                	mv	a5,a3
   14d9a:	fcf42223          	sw	a5,-60(s0)
   14d9e:	87ba                	mv	a5,a4
   14da0:	fcf42023          	sw	a5,-64(s0)
   14da4:	fc843783          	ld	a5,-56(s0)
   14da8:	cfc9                	beqz	a5,14e42 <xbrtime_int8_get+0xc2>
   14daa:	fc442783          	lw	a5,-60(s0)
   14dae:	0007871b          	sext.w	a4,a5
   14db2:	4785                	li	a5,1
   14db4:	00f71763          	bne	a4,a5,14dc2 <xbrtime_int8_get+0x42>
   14db8:	fc843703          	ld	a4,-56(s0)
   14dbc:	4785                	li	a5,1
   14dbe:	04f71163          	bne	a4,a5,14e00 <xbrtime_int8_get+0x80>
   14dc2:	fd043783          	ld	a5,-48(s0)
   14dc6:	fc042703          	lw	a4,-64(s0)
   14dca:	85ba                	mv	a1,a4
   14dcc:	853e                	mv	a0,a5
   14dce:	a4dfb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14dd2:	892a                	mv	s2,a0
   14dd4:	fd843483          	ld	s1,-40(s0)
   14dd8:	fc042783          	lw	a5,-64(s0)
   14ddc:	853e                	mv	a0,a5
   14dde:	5b4010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14de2:	87aa                	mv	a5,a0
   14de4:	2781                	sext.w	a5,a5
   14de6:	fc843703          	ld	a4,-56(s0)
   14dea:	0007069b          	sext.w	a3,a4
   14dee:	fc442703          	lw	a4,-60(s0)
   14df2:	2701                	sext.w	a4,a4
   14df4:	863e                	mv	a2,a5
   14df6:	85a6                	mv	a1,s1
   14df8:	854a                	mv	a0,s2
   14dfa:	743010ef          	jal	ra,16d3c <__xbrtime_get_s1_seq>
   14dfe:	a83d                	j	14e3c <xbrtime_int8_get+0xbc>
   14e00:	fd043783          	ld	a5,-48(s0)
   14e04:	fc042703          	lw	a4,-64(s0)
   14e08:	85ba                	mv	a1,a4
   14e0a:	853e                	mv	a0,a5
   14e0c:	a0ffb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14e10:	892a                	mv	s2,a0
   14e12:	fd843483          	ld	s1,-40(s0)
   14e16:	fc042783          	lw	a5,-64(s0)
   14e1a:	853e                	mv	a0,a5
   14e1c:	576010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14e20:	87aa                	mv	a5,a0
   14e22:	2781                	sext.w	a5,a5
   14e24:	fc843703          	ld	a4,-56(s0)
   14e28:	0007069b          	sext.w	a3,a4
   14e2c:	fc442703          	lw	a4,-60(s0)
   14e30:	2701                	sext.w	a4,a4
   14e32:	863e                	mv	a2,a5
   14e34:	85a6                	mv	a1,s1
   14e36:	854a                	mv	a0,s2
   14e38:	721010ef          	jal	ra,16d58 <__xbrtime_get_s1_agg>
   14e3c:	112020ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   14e40:	a011                	j	14e44 <xbrtime_int8_get+0xc4>
   14e42:	0001                	nop
   14e44:	70e2                	ld	ra,56(sp)
   14e46:	7442                	ld	s0,48(sp)
   14e48:	74a2                	ld	s1,40(sp)
   14e4a:	7902                	ld	s2,32(sp)
   14e4c:	6121                	addi	sp,sp,64
   14e4e:	8082                	ret

0000000000014e50 <xbrtime_int8_get_nb>:
   14e50:	7139                	addi	sp,sp,-64
   14e52:	fc06                	sd	ra,56(sp)
   14e54:	f822                	sd	s0,48(sp)
   14e56:	f426                	sd	s1,40(sp)
   14e58:	f04a                	sd	s2,32(sp)
   14e5a:	0080                	addi	s0,sp,64
   14e5c:	fca43c23          	sd	a0,-40(s0)
   14e60:	fcb43823          	sd	a1,-48(s0)
   14e64:	fcc43423          	sd	a2,-56(s0)
   14e68:	87b6                	mv	a5,a3
   14e6a:	fcf42223          	sw	a5,-60(s0)
   14e6e:	87ba                	mv	a5,a4
   14e70:	fcf42023          	sw	a5,-64(s0)
   14e74:	fc843783          	ld	a5,-56(s0)
   14e78:	c7dd                	beqz	a5,14f26 <xbrtime_int8_get_nb+0xd6>
   14e7a:	fc442783          	lw	a5,-60(s0)
   14e7e:	0007871b          	sext.w	a4,a5
   14e82:	4785                	li	a5,1
   14e84:	00f71763          	bne	a4,a5,14e92 <xbrtime_int8_get_nb+0x42>
   14e88:	fc843703          	ld	a4,-56(s0)
   14e8c:	4785                	li	a5,1
   14e8e:	04f71763          	bne	a4,a5,14edc <xbrtime_int8_get_nb+0x8c>
   14e92:	fd043783          	ld	a5,-48(s0)
   14e96:	fc042703          	lw	a4,-64(s0)
   14e9a:	85ba                	mv	a1,a4
   14e9c:	853e                	mv	a0,a5
   14e9e:	ffffc097          	auipc	ra,0xffffc
   14ea2:	97c080e7          	jalr	-1668(ra) # 1081a <__xbrtime_ltor>
   14ea6:	892a                	mv	s2,a0
   14ea8:	fd843483          	ld	s1,-40(s0)
   14eac:	fc042783          	lw	a5,-64(s0)
   14eb0:	853e                	mv	a0,a5
   14eb2:	00001097          	auipc	ra,0x1
   14eb6:	4e0080e7          	jalr	1248(ra) # 16392 <xbrtime_decode_pe>
   14eba:	87aa                	mv	a5,a0
   14ebc:	2781                	sext.w	a5,a5
   14ebe:	fc843703          	ld	a4,-56(s0)
   14ec2:	0007069b          	sext.w	a3,a4
   14ec6:	fc442703          	lw	a4,-60(s0)
   14eca:	2701                	sext.w	a4,a4
   14ecc:	863e                	mv	a2,a5
   14ece:	85a6                	mv	a1,s1
   14ed0:	854a                	mv	a0,s2
   14ed2:	00002097          	auipc	ra,0x2
   14ed6:	e6a080e7          	jalr	-406(ra) # 16d3c <__xbrtime_get_s1_seq>
   14eda:	a0b9                	j	14f28 <xbrtime_int8_get_nb+0xd8>
   14edc:	fd043783          	ld	a5,-48(s0)
   14ee0:	fc042703          	lw	a4,-64(s0)
   14ee4:	85ba                	mv	a1,a4
   14ee6:	853e                	mv	a0,a5
   14ee8:	ffffc097          	auipc	ra,0xffffc
   14eec:	932080e7          	jalr	-1742(ra) # 1081a <__xbrtime_ltor>
   14ef0:	892a                	mv	s2,a0
   14ef2:	fd843483          	ld	s1,-40(s0)
   14ef6:	fc042783          	lw	a5,-64(s0)
   14efa:	853e                	mv	a0,a5
   14efc:	00001097          	auipc	ra,0x1
   14f00:	496080e7          	jalr	1174(ra) # 16392 <xbrtime_decode_pe>
   14f04:	87aa                	mv	a5,a0
   14f06:	2781                	sext.w	a5,a5
   14f08:	fc843703          	ld	a4,-56(s0)
   14f0c:	0007069b          	sext.w	a3,a4
   14f10:	fc442703          	lw	a4,-60(s0)
   14f14:	2701                	sext.w	a4,a4
   14f16:	863e                	mv	a2,a5
   14f18:	85a6                	mv	a1,s1
   14f1a:	854a                	mv	a0,s2
   14f1c:	00002097          	auipc	ra,0x2
   14f20:	e3c080e7          	jalr	-452(ra) # 16d58 <__xbrtime_get_s1_agg>
   14f24:	a011                	j	14f28 <xbrtime_int8_get_nb+0xd8>
   14f26:	0001                	nop
   14f28:	70e2                	ld	ra,56(sp)
   14f2a:	7442                	ld	s0,48(sp)
   14f2c:	74a2                	ld	s1,40(sp)
   14f2e:	7902                	ld	s2,32(sp)
   14f30:	6121                	addi	sp,sp,64
   14f32:	8082                	ret

0000000000014f34 <xbrtime_int16_get>:
   14f34:	7139                	addi	sp,sp,-64
   14f36:	fc06                	sd	ra,56(sp)
   14f38:	f822                	sd	s0,48(sp)
   14f3a:	f426                	sd	s1,40(sp)
   14f3c:	f04a                	sd	s2,32(sp)
   14f3e:	0080                	addi	s0,sp,64
   14f40:	fca43c23          	sd	a0,-40(s0)
   14f44:	fcb43823          	sd	a1,-48(s0)
   14f48:	fcc43423          	sd	a2,-56(s0)
   14f4c:	87b6                	mv	a5,a3
   14f4e:	fcf42223          	sw	a5,-60(s0)
   14f52:	87ba                	mv	a5,a4
   14f54:	fcf42023          	sw	a5,-64(s0)
   14f58:	fc843783          	ld	a5,-56(s0)
   14f5c:	c7cd                	beqz	a5,15006 <xbrtime_int16_get+0xd2>
   14f5e:	fc442783          	lw	a5,-60(s0)
   14f62:	0007871b          	sext.w	a4,a5
   14f66:	4785                	li	a5,1
   14f68:	00f71763          	bne	a4,a5,14f76 <xbrtime_int16_get+0x42>
   14f6c:	fc843703          	ld	a4,-56(s0)
   14f70:	4785                	li	a5,1
   14f72:	04f71563          	bne	a4,a5,14fbc <xbrtime_int16_get+0x88>
   14f76:	fd043783          	ld	a5,-48(s0)
   14f7a:	fc042703          	lw	a4,-64(s0)
   14f7e:	85ba                	mv	a1,a4
   14f80:	853e                	mv	a0,a5
   14f82:	899fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14f86:	892a                	mv	s2,a0
   14f88:	fd843483          	ld	s1,-40(s0)
   14f8c:	fc042783          	lw	a5,-64(s0)
   14f90:	853e                	mv	a0,a5
   14f92:	400010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14f96:	87aa                	mv	a5,a0
   14f98:	0007861b          	sext.w	a2,a5
   14f9c:	fc843783          	ld	a5,-56(s0)
   14fa0:	0007869b          	sext.w	a3,a5
   14fa4:	fc442783          	lw	a5,-60(s0)
   14fa8:	2781                	sext.w	a5,a5
   14faa:	0017979b          	slliw	a5,a5,0x1
   14fae:	2781                	sext.w	a5,a5
   14fb0:	873e                	mv	a4,a5
   14fb2:	85a6                	mv	a1,s1
   14fb4:	854a                	mv	a0,s2
   14fb6:	5b1010ef          	jal	ra,16d66 <__xbrtime_get_s2_seq>
   14fba:	a099                	j	15000 <xbrtime_int16_get+0xcc>
   14fbc:	fd043783          	ld	a5,-48(s0)
   14fc0:	fc042703          	lw	a4,-64(s0)
   14fc4:	85ba                	mv	a1,a4
   14fc6:	853e                	mv	a0,a5
   14fc8:	853fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   14fcc:	892a                	mv	s2,a0
   14fce:	fd843483          	ld	s1,-40(s0)
   14fd2:	fc042783          	lw	a5,-64(s0)
   14fd6:	853e                	mv	a0,a5
   14fd8:	3ba010ef          	jal	ra,16392 <xbrtime_decode_pe>
   14fdc:	87aa                	mv	a5,a0
   14fde:	0007861b          	sext.w	a2,a5
   14fe2:	fc843783          	ld	a5,-56(s0)
   14fe6:	0007869b          	sext.w	a3,a5
   14fea:	fc442783          	lw	a5,-60(s0)
   14fee:	2781                	sext.w	a5,a5
   14ff0:	0017979b          	slliw	a5,a5,0x1
   14ff4:	2781                	sext.w	a5,a5
   14ff6:	873e                	mv	a4,a5
   14ff8:	85a6                	mv	a1,s1
   14ffa:	854a                	mv	a0,s2
   14ffc:	587010ef          	jal	ra,16d82 <__xbrtime_get_s2_agg>
   15000:	74f010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15004:	a011                	j	15008 <xbrtime_int16_get+0xd4>
   15006:	0001                	nop
   15008:	70e2                	ld	ra,56(sp)
   1500a:	7442                	ld	s0,48(sp)
   1500c:	74a2                	ld	s1,40(sp)
   1500e:	7902                	ld	s2,32(sp)
   15010:	6121                	addi	sp,sp,64
   15012:	8082                	ret

0000000000015014 <xbrtime_int16_get_nb>:
   15014:	7139                	addi	sp,sp,-64
   15016:	fc06                	sd	ra,56(sp)
   15018:	f822                	sd	s0,48(sp)
   1501a:	f426                	sd	s1,40(sp)
   1501c:	f04a                	sd	s2,32(sp)
   1501e:	0080                	addi	s0,sp,64
   15020:	fca43c23          	sd	a0,-40(s0)
   15024:	fcb43823          	sd	a1,-48(s0)
   15028:	fcc43423          	sd	a2,-56(s0)
   1502c:	87b6                	mv	a5,a3
   1502e:	fcf42223          	sw	a5,-60(s0)
   15032:	87ba                	mv	a5,a4
   15034:	fcf42023          	sw	a5,-64(s0)
   15038:	fc843783          	ld	a5,-56(s0)
   1503c:	cfdd                	beqz	a5,150fa <xbrtime_int16_get_nb+0xe6>
   1503e:	fc442783          	lw	a5,-60(s0)
   15042:	0007871b          	sext.w	a4,a5
   15046:	4785                	li	a5,1
   15048:	00f71763          	bne	a4,a5,15056 <xbrtime_int16_get_nb+0x42>
   1504c:	fc843703          	ld	a4,-56(s0)
   15050:	4785                	li	a5,1
   15052:	04f71b63          	bne	a4,a5,150a8 <xbrtime_int16_get_nb+0x94>
   15056:	fd043783          	ld	a5,-48(s0)
   1505a:	fc042703          	lw	a4,-64(s0)
   1505e:	85ba                	mv	a1,a4
   15060:	853e                	mv	a0,a5
   15062:	ffffb097          	auipc	ra,0xffffb
   15066:	7b8080e7          	jalr	1976(ra) # 1081a <__xbrtime_ltor>
   1506a:	892a                	mv	s2,a0
   1506c:	fd843483          	ld	s1,-40(s0)
   15070:	fc042783          	lw	a5,-64(s0)
   15074:	853e                	mv	a0,a5
   15076:	00001097          	auipc	ra,0x1
   1507a:	31c080e7          	jalr	796(ra) # 16392 <xbrtime_decode_pe>
   1507e:	87aa                	mv	a5,a0
   15080:	0007861b          	sext.w	a2,a5
   15084:	fc843783          	ld	a5,-56(s0)
   15088:	0007869b          	sext.w	a3,a5
   1508c:	fc442783          	lw	a5,-60(s0)
   15090:	2781                	sext.w	a5,a5
   15092:	0017979b          	slliw	a5,a5,0x1
   15096:	2781                	sext.w	a5,a5
   15098:	873e                	mv	a4,a5
   1509a:	85a6                	mv	a1,s1
   1509c:	854a                	mv	a0,s2
   1509e:	00002097          	auipc	ra,0x2
   150a2:	cc8080e7          	jalr	-824(ra) # 16d66 <__xbrtime_get_s2_seq>
   150a6:	a899                	j	150fc <xbrtime_int16_get_nb+0xe8>
   150a8:	fd043783          	ld	a5,-48(s0)
   150ac:	fc042703          	lw	a4,-64(s0)
   150b0:	85ba                	mv	a1,a4
   150b2:	853e                	mv	a0,a5
   150b4:	ffffb097          	auipc	ra,0xffffb
   150b8:	766080e7          	jalr	1894(ra) # 1081a <__xbrtime_ltor>
   150bc:	892a                	mv	s2,a0
   150be:	fd843483          	ld	s1,-40(s0)
   150c2:	fc042783          	lw	a5,-64(s0)
   150c6:	853e                	mv	a0,a5
   150c8:	00001097          	auipc	ra,0x1
   150cc:	2ca080e7          	jalr	714(ra) # 16392 <xbrtime_decode_pe>
   150d0:	87aa                	mv	a5,a0
   150d2:	0007861b          	sext.w	a2,a5
   150d6:	fc843783          	ld	a5,-56(s0)
   150da:	0007869b          	sext.w	a3,a5
   150de:	fc442783          	lw	a5,-60(s0)
   150e2:	2781                	sext.w	a5,a5
   150e4:	0017979b          	slliw	a5,a5,0x1
   150e8:	2781                	sext.w	a5,a5
   150ea:	873e                	mv	a4,a5
   150ec:	85a6                	mv	a1,s1
   150ee:	854a                	mv	a0,s2
   150f0:	00002097          	auipc	ra,0x2
   150f4:	c92080e7          	jalr	-878(ra) # 16d82 <__xbrtime_get_s2_agg>
   150f8:	a011                	j	150fc <xbrtime_int16_get_nb+0xe8>
   150fa:	0001                	nop
   150fc:	70e2                	ld	ra,56(sp)
   150fe:	7442                	ld	s0,48(sp)
   15100:	74a2                	ld	s1,40(sp)
   15102:	7902                	ld	s2,32(sp)
   15104:	6121                	addi	sp,sp,64
   15106:	8082                	ret

0000000000015108 <xbrtime_int32_get>:
   15108:	7139                	addi	sp,sp,-64
   1510a:	fc06                	sd	ra,56(sp)
   1510c:	f822                	sd	s0,48(sp)
   1510e:	f426                	sd	s1,40(sp)
   15110:	f04a                	sd	s2,32(sp)
   15112:	0080                	addi	s0,sp,64
   15114:	fca43c23          	sd	a0,-40(s0)
   15118:	fcb43823          	sd	a1,-48(s0)
   1511c:	fcc43423          	sd	a2,-56(s0)
   15120:	87b6                	mv	a5,a3
   15122:	fcf42223          	sw	a5,-60(s0)
   15126:	87ba                	mv	a5,a4
   15128:	fcf42023          	sw	a5,-64(s0)
   1512c:	fc843783          	ld	a5,-56(s0)
   15130:	c7cd                	beqz	a5,151da <xbrtime_int32_get+0xd2>
   15132:	fc442783          	lw	a5,-60(s0)
   15136:	0007871b          	sext.w	a4,a5
   1513a:	4785                	li	a5,1
   1513c:	00f71763          	bne	a4,a5,1514a <xbrtime_int32_get+0x42>
   15140:	fc843703          	ld	a4,-56(s0)
   15144:	4785                	li	a5,1
   15146:	04f71563          	bne	a4,a5,15190 <xbrtime_int32_get+0x88>
   1514a:	fd043783          	ld	a5,-48(s0)
   1514e:	fc042703          	lw	a4,-64(s0)
   15152:	85ba                	mv	a1,a4
   15154:	853e                	mv	a0,a5
   15156:	ec4fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   1515a:	892a                	mv	s2,a0
   1515c:	fd843483          	ld	s1,-40(s0)
   15160:	fc042783          	lw	a5,-64(s0)
   15164:	853e                	mv	a0,a5
   15166:	22c010ef          	jal	ra,16392 <xbrtime_decode_pe>
   1516a:	87aa                	mv	a5,a0
   1516c:	0007861b          	sext.w	a2,a5
   15170:	fc843783          	ld	a5,-56(s0)
   15174:	0007869b          	sext.w	a3,a5
   15178:	fc442783          	lw	a5,-60(s0)
   1517c:	2781                	sext.w	a5,a5
   1517e:	0027979b          	slliw	a5,a5,0x2
   15182:	2781                	sext.w	a5,a5
   15184:	873e                	mv	a4,a5
   15186:	85a6                	mv	a1,s1
   15188:	854a                	mv	a0,s2
   1518a:	407010ef          	jal	ra,16d90 <__xbrtime_get_s4_seq>
   1518e:	a099                	j	151d4 <xbrtime_int32_get+0xcc>
   15190:	fd043783          	ld	a5,-48(s0)
   15194:	fc042703          	lw	a4,-64(s0)
   15198:	85ba                	mv	a1,a4
   1519a:	853e                	mv	a0,a5
   1519c:	e7efb0ef          	jal	ra,1081a <__xbrtime_ltor>
   151a0:	892a                	mv	s2,a0
   151a2:	fd843483          	ld	s1,-40(s0)
   151a6:	fc042783          	lw	a5,-64(s0)
   151aa:	853e                	mv	a0,a5
   151ac:	1e6010ef          	jal	ra,16392 <xbrtime_decode_pe>
   151b0:	87aa                	mv	a5,a0
   151b2:	0007861b          	sext.w	a2,a5
   151b6:	fc843783          	ld	a5,-56(s0)
   151ba:	0007869b          	sext.w	a3,a5
   151be:	fc442783          	lw	a5,-60(s0)
   151c2:	2781                	sext.w	a5,a5
   151c4:	0027979b          	slliw	a5,a5,0x2
   151c8:	2781                	sext.w	a5,a5
   151ca:	873e                	mv	a4,a5
   151cc:	85a6                	mv	a1,s1
   151ce:	854a                	mv	a0,s2
   151d0:	3dd010ef          	jal	ra,16dac <__xbrtime_get_s4_agg>
   151d4:	57b010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   151d8:	a011                	j	151dc <xbrtime_int32_get+0xd4>
   151da:	0001                	nop
   151dc:	70e2                	ld	ra,56(sp)
   151de:	7442                	ld	s0,48(sp)
   151e0:	74a2                	ld	s1,40(sp)
   151e2:	7902                	ld	s2,32(sp)
   151e4:	6121                	addi	sp,sp,64
   151e6:	8082                	ret

00000000000151e8 <xbrtime_int32_get_nb>:
   151e8:	7139                	addi	sp,sp,-64
   151ea:	fc06                	sd	ra,56(sp)
   151ec:	f822                	sd	s0,48(sp)
   151ee:	f426                	sd	s1,40(sp)
   151f0:	f04a                	sd	s2,32(sp)
   151f2:	0080                	addi	s0,sp,64
   151f4:	fca43c23          	sd	a0,-40(s0)
   151f8:	fcb43823          	sd	a1,-48(s0)
   151fc:	fcc43423          	sd	a2,-56(s0)
   15200:	87b6                	mv	a5,a3
   15202:	fcf42223          	sw	a5,-60(s0)
   15206:	87ba                	mv	a5,a4
   15208:	fcf42023          	sw	a5,-64(s0)
   1520c:	fc843783          	ld	a5,-56(s0)
   15210:	cfdd                	beqz	a5,152ce <xbrtime_int32_get_nb+0xe6>
   15212:	fc442783          	lw	a5,-60(s0)
   15216:	0007871b          	sext.w	a4,a5
   1521a:	4785                	li	a5,1
   1521c:	00f71763          	bne	a4,a5,1522a <xbrtime_int32_get_nb+0x42>
   15220:	fc843703          	ld	a4,-56(s0)
   15224:	4785                	li	a5,1
   15226:	04f71b63          	bne	a4,a5,1527c <xbrtime_int32_get_nb+0x94>
   1522a:	fd043783          	ld	a5,-48(s0)
   1522e:	fc042703          	lw	a4,-64(s0)
   15232:	85ba                	mv	a1,a4
   15234:	853e                	mv	a0,a5
   15236:	ffffb097          	auipc	ra,0xffffb
   1523a:	5e4080e7          	jalr	1508(ra) # 1081a <__xbrtime_ltor>
   1523e:	892a                	mv	s2,a0
   15240:	fd843483          	ld	s1,-40(s0)
   15244:	fc042783          	lw	a5,-64(s0)
   15248:	853e                	mv	a0,a5
   1524a:	00001097          	auipc	ra,0x1
   1524e:	148080e7          	jalr	328(ra) # 16392 <xbrtime_decode_pe>
   15252:	87aa                	mv	a5,a0
   15254:	0007861b          	sext.w	a2,a5
   15258:	fc843783          	ld	a5,-56(s0)
   1525c:	0007869b          	sext.w	a3,a5
   15260:	fc442783          	lw	a5,-60(s0)
   15264:	2781                	sext.w	a5,a5
   15266:	0027979b          	slliw	a5,a5,0x2
   1526a:	2781                	sext.w	a5,a5
   1526c:	873e                	mv	a4,a5
   1526e:	85a6                	mv	a1,s1
   15270:	854a                	mv	a0,s2
   15272:	00002097          	auipc	ra,0x2
   15276:	b1e080e7          	jalr	-1250(ra) # 16d90 <__xbrtime_get_s4_seq>
   1527a:	a899                	j	152d0 <xbrtime_int32_get_nb+0xe8>
   1527c:	fd043783          	ld	a5,-48(s0)
   15280:	fc042703          	lw	a4,-64(s0)
   15284:	85ba                	mv	a1,a4
   15286:	853e                	mv	a0,a5
   15288:	ffffb097          	auipc	ra,0xffffb
   1528c:	592080e7          	jalr	1426(ra) # 1081a <__xbrtime_ltor>
   15290:	892a                	mv	s2,a0
   15292:	fd843483          	ld	s1,-40(s0)
   15296:	fc042783          	lw	a5,-64(s0)
   1529a:	853e                	mv	a0,a5
   1529c:	00001097          	auipc	ra,0x1
   152a0:	0f6080e7          	jalr	246(ra) # 16392 <xbrtime_decode_pe>
   152a4:	87aa                	mv	a5,a0
   152a6:	0007861b          	sext.w	a2,a5
   152aa:	fc843783          	ld	a5,-56(s0)
   152ae:	0007869b          	sext.w	a3,a5
   152b2:	fc442783          	lw	a5,-60(s0)
   152b6:	2781                	sext.w	a5,a5
   152b8:	0027979b          	slliw	a5,a5,0x2
   152bc:	2781                	sext.w	a5,a5
   152be:	873e                	mv	a4,a5
   152c0:	85a6                	mv	a1,s1
   152c2:	854a                	mv	a0,s2
   152c4:	00002097          	auipc	ra,0x2
   152c8:	ae8080e7          	jalr	-1304(ra) # 16dac <__xbrtime_get_s4_agg>
   152cc:	a011                	j	152d0 <xbrtime_int32_get_nb+0xe8>
   152ce:	0001                	nop
   152d0:	70e2                	ld	ra,56(sp)
   152d2:	7442                	ld	s0,48(sp)
   152d4:	74a2                	ld	s1,40(sp)
   152d6:	7902                	ld	s2,32(sp)
   152d8:	6121                	addi	sp,sp,64
   152da:	8082                	ret

00000000000152dc <xbrtime_int64_get>:
   152dc:	7139                	addi	sp,sp,-64
   152de:	fc06                	sd	ra,56(sp)
   152e0:	f822                	sd	s0,48(sp)
   152e2:	f426                	sd	s1,40(sp)
   152e4:	f04a                	sd	s2,32(sp)
   152e6:	0080                	addi	s0,sp,64
   152e8:	fca43c23          	sd	a0,-40(s0)
   152ec:	fcb43823          	sd	a1,-48(s0)
   152f0:	fcc43423          	sd	a2,-56(s0)
   152f4:	87b6                	mv	a5,a3
   152f6:	fcf42223          	sw	a5,-60(s0)
   152fa:	87ba                	mv	a5,a4
   152fc:	fcf42023          	sw	a5,-64(s0)
   15300:	fc843783          	ld	a5,-56(s0)
   15304:	c7cd                	beqz	a5,153ae <xbrtime_int64_get+0xd2>
   15306:	fc442783          	lw	a5,-60(s0)
   1530a:	0007871b          	sext.w	a4,a5
   1530e:	4785                	li	a5,1
   15310:	00f71763          	bne	a4,a5,1531e <xbrtime_int64_get+0x42>
   15314:	fc843703          	ld	a4,-56(s0)
   15318:	4785                	li	a5,1
   1531a:	04f71563          	bne	a4,a5,15364 <xbrtime_int64_get+0x88>
   1531e:	fd043783          	ld	a5,-48(s0)
   15322:	fc042703          	lw	a4,-64(s0)
   15326:	85ba                	mv	a1,a4
   15328:	853e                	mv	a0,a5
   1532a:	cf0fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   1532e:	892a                	mv	s2,a0
   15330:	fd843483          	ld	s1,-40(s0)
   15334:	fc042783          	lw	a5,-64(s0)
   15338:	853e                	mv	a0,a5
   1533a:	058010ef          	jal	ra,16392 <xbrtime_decode_pe>
   1533e:	87aa                	mv	a5,a0
   15340:	0007861b          	sext.w	a2,a5
   15344:	fc843783          	ld	a5,-56(s0)
   15348:	0007869b          	sext.w	a3,a5
   1534c:	fc442783          	lw	a5,-60(s0)
   15350:	2781                	sext.w	a5,a5
   15352:	0037979b          	slliw	a5,a5,0x3
   15356:	2781                	sext.w	a5,a5
   15358:	873e                	mv	a4,a5
   1535a:	85a6                	mv	a1,s1
   1535c:	854a                	mv	a0,s2
   1535e:	25d010ef          	jal	ra,16dba <__xbrtime_get_s8_seq>
   15362:	a099                	j	153a8 <xbrtime_int64_get+0xcc>
   15364:	fd043783          	ld	a5,-48(s0)
   15368:	fc042703          	lw	a4,-64(s0)
   1536c:	85ba                	mv	a1,a4
   1536e:	853e                	mv	a0,a5
   15370:	caafb0ef          	jal	ra,1081a <__xbrtime_ltor>
   15374:	892a                	mv	s2,a0
   15376:	fd843483          	ld	s1,-40(s0)
   1537a:	fc042783          	lw	a5,-64(s0)
   1537e:	853e                	mv	a0,a5
   15380:	012010ef          	jal	ra,16392 <xbrtime_decode_pe>
   15384:	87aa                	mv	a5,a0
   15386:	0007861b          	sext.w	a2,a5
   1538a:	fc843783          	ld	a5,-56(s0)
   1538e:	0007869b          	sext.w	a3,a5
   15392:	fc442783          	lw	a5,-60(s0)
   15396:	2781                	sext.w	a5,a5
   15398:	0037979b          	slliw	a5,a5,0x3
   1539c:	2781                	sext.w	a5,a5
   1539e:	873e                	mv	a4,a5
   153a0:	85a6                	mv	a1,s1
   153a2:	854a                	mv	a0,s2
   153a4:	233010ef          	jal	ra,16dd6 <__xbrtime_get_s8_agg>
   153a8:	3a7010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   153ac:	a011                	j	153b0 <xbrtime_int64_get+0xd4>
   153ae:	0001                	nop
   153b0:	70e2                	ld	ra,56(sp)
   153b2:	7442                	ld	s0,48(sp)
   153b4:	74a2                	ld	s1,40(sp)
   153b6:	7902                	ld	s2,32(sp)
   153b8:	6121                	addi	sp,sp,64
   153ba:	8082                	ret

00000000000153bc <xbrtime_int64_get_nb>:
   153bc:	7139                	addi	sp,sp,-64
   153be:	fc06                	sd	ra,56(sp)
   153c0:	f822                	sd	s0,48(sp)
   153c2:	f426                	sd	s1,40(sp)
   153c4:	f04a                	sd	s2,32(sp)
   153c6:	0080                	addi	s0,sp,64
   153c8:	fca43c23          	sd	a0,-40(s0)
   153cc:	fcb43823          	sd	a1,-48(s0)
   153d0:	fcc43423          	sd	a2,-56(s0)
   153d4:	87b6                	mv	a5,a3
   153d6:	fcf42223          	sw	a5,-60(s0)
   153da:	87ba                	mv	a5,a4
   153dc:	fcf42023          	sw	a5,-64(s0)
   153e0:	fc843783          	ld	a5,-56(s0)
   153e4:	cfdd                	beqz	a5,154a2 <xbrtime_int64_get_nb+0xe6>
   153e6:	fc442783          	lw	a5,-60(s0)
   153ea:	0007871b          	sext.w	a4,a5
   153ee:	4785                	li	a5,1
   153f0:	00f71763          	bne	a4,a5,153fe <xbrtime_int64_get_nb+0x42>
   153f4:	fc843703          	ld	a4,-56(s0)
   153f8:	4785                	li	a5,1
   153fa:	04f71b63          	bne	a4,a5,15450 <xbrtime_int64_get_nb+0x94>
   153fe:	fd043783          	ld	a5,-48(s0)
   15402:	fc042703          	lw	a4,-64(s0)
   15406:	85ba                	mv	a1,a4
   15408:	853e                	mv	a0,a5
   1540a:	ffffb097          	auipc	ra,0xffffb
   1540e:	410080e7          	jalr	1040(ra) # 1081a <__xbrtime_ltor>
   15412:	892a                	mv	s2,a0
   15414:	fd843483          	ld	s1,-40(s0)
   15418:	fc042783          	lw	a5,-64(s0)
   1541c:	853e                	mv	a0,a5
   1541e:	00001097          	auipc	ra,0x1
   15422:	f74080e7          	jalr	-140(ra) # 16392 <xbrtime_decode_pe>
   15426:	87aa                	mv	a5,a0
   15428:	0007861b          	sext.w	a2,a5
   1542c:	fc843783          	ld	a5,-56(s0)
   15430:	0007869b          	sext.w	a3,a5
   15434:	fc442783          	lw	a5,-60(s0)
   15438:	2781                	sext.w	a5,a5
   1543a:	0037979b          	slliw	a5,a5,0x3
   1543e:	2781                	sext.w	a5,a5
   15440:	873e                	mv	a4,a5
   15442:	85a6                	mv	a1,s1
   15444:	854a                	mv	a0,s2
   15446:	00002097          	auipc	ra,0x2
   1544a:	974080e7          	jalr	-1676(ra) # 16dba <__xbrtime_get_s8_seq>
   1544e:	a899                	j	154a4 <xbrtime_int64_get_nb+0xe8>
   15450:	fd043783          	ld	a5,-48(s0)
   15454:	fc042703          	lw	a4,-64(s0)
   15458:	85ba                	mv	a1,a4
   1545a:	853e                	mv	a0,a5
   1545c:	ffffb097          	auipc	ra,0xffffb
   15460:	3be080e7          	jalr	958(ra) # 1081a <__xbrtime_ltor>
   15464:	892a                	mv	s2,a0
   15466:	fd843483          	ld	s1,-40(s0)
   1546a:	fc042783          	lw	a5,-64(s0)
   1546e:	853e                	mv	a0,a5
   15470:	00001097          	auipc	ra,0x1
   15474:	f22080e7          	jalr	-222(ra) # 16392 <xbrtime_decode_pe>
   15478:	87aa                	mv	a5,a0
   1547a:	0007861b          	sext.w	a2,a5
   1547e:	fc843783          	ld	a5,-56(s0)
   15482:	0007869b          	sext.w	a3,a5
   15486:	fc442783          	lw	a5,-60(s0)
   1548a:	2781                	sext.w	a5,a5
   1548c:	0037979b          	slliw	a5,a5,0x3
   15490:	2781                	sext.w	a5,a5
   15492:	873e                	mv	a4,a5
   15494:	85a6                	mv	a1,s1
   15496:	854a                	mv	a0,s2
   15498:	00002097          	auipc	ra,0x2
   1549c:	93e080e7          	jalr	-1730(ra) # 16dd6 <__xbrtime_get_s8_agg>
   154a0:	a011                	j	154a4 <xbrtime_int64_get_nb+0xe8>
   154a2:	0001                	nop
   154a4:	70e2                	ld	ra,56(sp)
   154a6:	7442                	ld	s0,48(sp)
   154a8:	74a2                	ld	s1,40(sp)
   154aa:	7902                	ld	s2,32(sp)
   154ac:	6121                	addi	sp,sp,64
   154ae:	8082                	ret

00000000000154b0 <xbrtime_uint8_get>:
   154b0:	7139                	addi	sp,sp,-64
   154b2:	fc06                	sd	ra,56(sp)
   154b4:	f822                	sd	s0,48(sp)
   154b6:	f426                	sd	s1,40(sp)
   154b8:	f04a                	sd	s2,32(sp)
   154ba:	0080                	addi	s0,sp,64
   154bc:	fca43c23          	sd	a0,-40(s0)
   154c0:	fcb43823          	sd	a1,-48(s0)
   154c4:	fcc43423          	sd	a2,-56(s0)
   154c8:	87b6                	mv	a5,a3
   154ca:	fcf42223          	sw	a5,-60(s0)
   154ce:	87ba                	mv	a5,a4
   154d0:	fcf42023          	sw	a5,-64(s0)
   154d4:	fc843783          	ld	a5,-56(s0)
   154d8:	cfc9                	beqz	a5,15572 <xbrtime_uint8_get+0xc2>
   154da:	fc442783          	lw	a5,-60(s0)
   154de:	0007871b          	sext.w	a4,a5
   154e2:	4785                	li	a5,1
   154e4:	00f71763          	bne	a4,a5,154f2 <xbrtime_uint8_get+0x42>
   154e8:	fc843703          	ld	a4,-56(s0)
   154ec:	4785                	li	a5,1
   154ee:	04f71163          	bne	a4,a5,15530 <xbrtime_uint8_get+0x80>
   154f2:	fd043783          	ld	a5,-48(s0)
   154f6:	fc042703          	lw	a4,-64(s0)
   154fa:	85ba                	mv	a1,a4
   154fc:	853e                	mv	a0,a5
   154fe:	b1cfb0ef          	jal	ra,1081a <__xbrtime_ltor>
   15502:	892a                	mv	s2,a0
   15504:	fd843483          	ld	s1,-40(s0)
   15508:	fc042783          	lw	a5,-64(s0)
   1550c:	853e                	mv	a0,a5
   1550e:	685000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15512:	87aa                	mv	a5,a0
   15514:	2781                	sext.w	a5,a5
   15516:	fc843703          	ld	a4,-56(s0)
   1551a:	0007069b          	sext.w	a3,a4
   1551e:	fc442703          	lw	a4,-60(s0)
   15522:	2701                	sext.w	a4,a4
   15524:	863e                	mv	a2,a5
   15526:	85a6                	mv	a1,s1
   15528:	854a                	mv	a0,s2
   1552a:	76a010ef          	jal	ra,16c94 <__xbrtime_get_u1_seq>
   1552e:	a83d                	j	1556c <xbrtime_uint8_get+0xbc>
   15530:	fd043783          	ld	a5,-48(s0)
   15534:	fc042703          	lw	a4,-64(s0)
   15538:	85ba                	mv	a1,a4
   1553a:	853e                	mv	a0,a5
   1553c:	adefb0ef          	jal	ra,1081a <__xbrtime_ltor>
   15540:	892a                	mv	s2,a0
   15542:	fd843483          	ld	s1,-40(s0)
   15546:	fc042783          	lw	a5,-64(s0)
   1554a:	853e                	mv	a0,a5
   1554c:	647000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15550:	87aa                	mv	a5,a0
   15552:	2781                	sext.w	a5,a5
   15554:	fc843703          	ld	a4,-56(s0)
   15558:	0007069b          	sext.w	a3,a4
   1555c:	fc442703          	lw	a4,-60(s0)
   15560:	2701                	sext.w	a4,a4
   15562:	863e                	mv	a2,a5
   15564:	85a6                	mv	a1,s1
   15566:	854a                	mv	a0,s2
   15568:	748010ef          	jal	ra,16cb0 <__xbrtime_get_u1_agg>
   1556c:	1e3010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15570:	a011                	j	15574 <xbrtime_uint8_get+0xc4>
   15572:	0001                	nop
   15574:	70e2                	ld	ra,56(sp)
   15576:	7442                	ld	s0,48(sp)
   15578:	74a2                	ld	s1,40(sp)
   1557a:	7902                	ld	s2,32(sp)
   1557c:	6121                	addi	sp,sp,64
   1557e:	8082                	ret

0000000000015580 <xbrtime_uint8_get_nb>:
   15580:	7139                	addi	sp,sp,-64
   15582:	fc06                	sd	ra,56(sp)
   15584:	f822                	sd	s0,48(sp)
   15586:	f426                	sd	s1,40(sp)
   15588:	f04a                	sd	s2,32(sp)
   1558a:	0080                	addi	s0,sp,64
   1558c:	fca43c23          	sd	a0,-40(s0)
   15590:	fcb43823          	sd	a1,-48(s0)
   15594:	fcc43423          	sd	a2,-56(s0)
   15598:	87b6                	mv	a5,a3
   1559a:	fcf42223          	sw	a5,-60(s0)
   1559e:	87ba                	mv	a5,a4
   155a0:	fcf42023          	sw	a5,-64(s0)
   155a4:	fc843783          	ld	a5,-56(s0)
   155a8:	c7dd                	beqz	a5,15656 <xbrtime_uint8_get_nb+0xd6>
   155aa:	fc442783          	lw	a5,-60(s0)
   155ae:	0007871b          	sext.w	a4,a5
   155b2:	4785                	li	a5,1
   155b4:	00f71763          	bne	a4,a5,155c2 <xbrtime_uint8_get_nb+0x42>
   155b8:	fc843703          	ld	a4,-56(s0)
   155bc:	4785                	li	a5,1
   155be:	04f71763          	bne	a4,a5,1560c <xbrtime_uint8_get_nb+0x8c>
   155c2:	fd043783          	ld	a5,-48(s0)
   155c6:	fc042703          	lw	a4,-64(s0)
   155ca:	85ba                	mv	a1,a4
   155cc:	853e                	mv	a0,a5
   155ce:	ffffb097          	auipc	ra,0xffffb
   155d2:	24c080e7          	jalr	588(ra) # 1081a <__xbrtime_ltor>
   155d6:	892a                	mv	s2,a0
   155d8:	fd843483          	ld	s1,-40(s0)
   155dc:	fc042783          	lw	a5,-64(s0)
   155e0:	853e                	mv	a0,a5
   155e2:	00001097          	auipc	ra,0x1
   155e6:	db0080e7          	jalr	-592(ra) # 16392 <xbrtime_decode_pe>
   155ea:	87aa                	mv	a5,a0
   155ec:	2781                	sext.w	a5,a5
   155ee:	fc843703          	ld	a4,-56(s0)
   155f2:	0007069b          	sext.w	a3,a4
   155f6:	fc442703          	lw	a4,-60(s0)
   155fa:	2701                	sext.w	a4,a4
   155fc:	863e                	mv	a2,a5
   155fe:	85a6                	mv	a1,s1
   15600:	854a                	mv	a0,s2
   15602:	00001097          	auipc	ra,0x1
   15606:	692080e7          	jalr	1682(ra) # 16c94 <__xbrtime_get_u1_seq>
   1560a:	a0b9                	j	15658 <xbrtime_uint8_get_nb+0xd8>
   1560c:	fd043783          	ld	a5,-48(s0)
   15610:	fc042703          	lw	a4,-64(s0)
   15614:	85ba                	mv	a1,a4
   15616:	853e                	mv	a0,a5
   15618:	ffffb097          	auipc	ra,0xffffb
   1561c:	202080e7          	jalr	514(ra) # 1081a <__xbrtime_ltor>
   15620:	892a                	mv	s2,a0
   15622:	fd843483          	ld	s1,-40(s0)
   15626:	fc042783          	lw	a5,-64(s0)
   1562a:	853e                	mv	a0,a5
   1562c:	00001097          	auipc	ra,0x1
   15630:	d66080e7          	jalr	-666(ra) # 16392 <xbrtime_decode_pe>
   15634:	87aa                	mv	a5,a0
   15636:	2781                	sext.w	a5,a5
   15638:	fc843703          	ld	a4,-56(s0)
   1563c:	0007069b          	sext.w	a3,a4
   15640:	fc442703          	lw	a4,-60(s0)
   15644:	2701                	sext.w	a4,a4
   15646:	863e                	mv	a2,a5
   15648:	85a6                	mv	a1,s1
   1564a:	854a                	mv	a0,s2
   1564c:	00001097          	auipc	ra,0x1
   15650:	664080e7          	jalr	1636(ra) # 16cb0 <__xbrtime_get_u1_agg>
   15654:	a011                	j	15658 <xbrtime_uint8_get_nb+0xd8>
   15656:	0001                	nop
   15658:	70e2                	ld	ra,56(sp)
   1565a:	7442                	ld	s0,48(sp)
   1565c:	74a2                	ld	s1,40(sp)
   1565e:	7902                	ld	s2,32(sp)
   15660:	6121                	addi	sp,sp,64
   15662:	8082                	ret

0000000000015664 <xbrtime_uint16_get>:
   15664:	7139                	addi	sp,sp,-64
   15666:	fc06                	sd	ra,56(sp)
   15668:	f822                	sd	s0,48(sp)
   1566a:	f426                	sd	s1,40(sp)
   1566c:	f04a                	sd	s2,32(sp)
   1566e:	0080                	addi	s0,sp,64
   15670:	fca43c23          	sd	a0,-40(s0)
   15674:	fcb43823          	sd	a1,-48(s0)
   15678:	fcc43423          	sd	a2,-56(s0)
   1567c:	87b6                	mv	a5,a3
   1567e:	fcf42223          	sw	a5,-60(s0)
   15682:	87ba                	mv	a5,a4
   15684:	fcf42023          	sw	a5,-64(s0)
   15688:	fc843783          	ld	a5,-56(s0)
   1568c:	c7cd                	beqz	a5,15736 <xbrtime_uint16_get+0xd2>
   1568e:	fc442783          	lw	a5,-60(s0)
   15692:	0007871b          	sext.w	a4,a5
   15696:	4785                	li	a5,1
   15698:	00f71763          	bne	a4,a5,156a6 <xbrtime_uint16_get+0x42>
   1569c:	fc843703          	ld	a4,-56(s0)
   156a0:	4785                	li	a5,1
   156a2:	04f71563          	bne	a4,a5,156ec <xbrtime_uint16_get+0x88>
   156a6:	fd043783          	ld	a5,-48(s0)
   156aa:	fc042703          	lw	a4,-64(s0)
   156ae:	85ba                	mv	a1,a4
   156b0:	853e                	mv	a0,a5
   156b2:	968fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   156b6:	892a                	mv	s2,a0
   156b8:	fd843483          	ld	s1,-40(s0)
   156bc:	fc042783          	lw	a5,-64(s0)
   156c0:	853e                	mv	a0,a5
   156c2:	4d1000ef          	jal	ra,16392 <xbrtime_decode_pe>
   156c6:	87aa                	mv	a5,a0
   156c8:	0007861b          	sext.w	a2,a5
   156cc:	fc843783          	ld	a5,-56(s0)
   156d0:	0007869b          	sext.w	a3,a5
   156d4:	fc442783          	lw	a5,-60(s0)
   156d8:	2781                	sext.w	a5,a5
   156da:	0017979b          	slliw	a5,a5,0x1
   156de:	2781                	sext.w	a5,a5
   156e0:	873e                	mv	a4,a5
   156e2:	85a6                	mv	a1,s1
   156e4:	854a                	mv	a0,s2
   156e6:	5d8010ef          	jal	ra,16cbe <__xbrtime_get_u2_seq>
   156ea:	a099                	j	15730 <xbrtime_uint16_get+0xcc>
   156ec:	fd043783          	ld	a5,-48(s0)
   156f0:	fc042703          	lw	a4,-64(s0)
   156f4:	85ba                	mv	a1,a4
   156f6:	853e                	mv	a0,a5
   156f8:	922fb0ef          	jal	ra,1081a <__xbrtime_ltor>
   156fc:	892a                	mv	s2,a0
   156fe:	fd843483          	ld	s1,-40(s0)
   15702:	fc042783          	lw	a5,-64(s0)
   15706:	853e                	mv	a0,a5
   15708:	48b000ef          	jal	ra,16392 <xbrtime_decode_pe>
   1570c:	87aa                	mv	a5,a0
   1570e:	0007861b          	sext.w	a2,a5
   15712:	fc843783          	ld	a5,-56(s0)
   15716:	0007869b          	sext.w	a3,a5
   1571a:	fc442783          	lw	a5,-60(s0)
   1571e:	2781                	sext.w	a5,a5
   15720:	0017979b          	slliw	a5,a5,0x1
   15724:	2781                	sext.w	a5,a5
   15726:	873e                	mv	a4,a5
   15728:	85a6                	mv	a1,s1
   1572a:	854a                	mv	a0,s2
   1572c:	5ae010ef          	jal	ra,16cda <__xbrtime_get_u2_agg>
   15730:	01f010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15734:	a011                	j	15738 <xbrtime_uint16_get+0xd4>
   15736:	0001                	nop
   15738:	70e2                	ld	ra,56(sp)
   1573a:	7442                	ld	s0,48(sp)
   1573c:	74a2                	ld	s1,40(sp)
   1573e:	7902                	ld	s2,32(sp)
   15740:	6121                	addi	sp,sp,64
   15742:	8082                	ret

0000000000015744 <xbrtime_uint16_get_nb>:
   15744:	7139                	addi	sp,sp,-64
   15746:	fc06                	sd	ra,56(sp)
   15748:	f822                	sd	s0,48(sp)
   1574a:	f426                	sd	s1,40(sp)
   1574c:	f04a                	sd	s2,32(sp)
   1574e:	0080                	addi	s0,sp,64
   15750:	fca43c23          	sd	a0,-40(s0)
   15754:	fcb43823          	sd	a1,-48(s0)
   15758:	fcc43423          	sd	a2,-56(s0)
   1575c:	87b6                	mv	a5,a3
   1575e:	fcf42223          	sw	a5,-60(s0)
   15762:	87ba                	mv	a5,a4
   15764:	fcf42023          	sw	a5,-64(s0)
   15768:	fc843783          	ld	a5,-56(s0)
   1576c:	cfdd                	beqz	a5,1582a <xbrtime_uint16_get_nb+0xe6>
   1576e:	fc442783          	lw	a5,-60(s0)
   15772:	0007871b          	sext.w	a4,a5
   15776:	4785                	li	a5,1
   15778:	00f71763          	bne	a4,a5,15786 <xbrtime_uint16_get_nb+0x42>
   1577c:	fc843703          	ld	a4,-56(s0)
   15780:	4785                	li	a5,1
   15782:	04f71b63          	bne	a4,a5,157d8 <xbrtime_uint16_get_nb+0x94>
   15786:	fd043783          	ld	a5,-48(s0)
   1578a:	fc042703          	lw	a4,-64(s0)
   1578e:	85ba                	mv	a1,a4
   15790:	853e                	mv	a0,a5
   15792:	ffffb097          	auipc	ra,0xffffb
   15796:	088080e7          	jalr	136(ra) # 1081a <__xbrtime_ltor>
   1579a:	892a                	mv	s2,a0
   1579c:	fd843483          	ld	s1,-40(s0)
   157a0:	fc042783          	lw	a5,-64(s0)
   157a4:	853e                	mv	a0,a5
   157a6:	00001097          	auipc	ra,0x1
   157aa:	bec080e7          	jalr	-1044(ra) # 16392 <xbrtime_decode_pe>
   157ae:	87aa                	mv	a5,a0
   157b0:	0007861b          	sext.w	a2,a5
   157b4:	fc843783          	ld	a5,-56(s0)
   157b8:	0007869b          	sext.w	a3,a5
   157bc:	fc442783          	lw	a5,-60(s0)
   157c0:	2781                	sext.w	a5,a5
   157c2:	0017979b          	slliw	a5,a5,0x1
   157c6:	2781                	sext.w	a5,a5
   157c8:	873e                	mv	a4,a5
   157ca:	85a6                	mv	a1,s1
   157cc:	854a                	mv	a0,s2
   157ce:	00001097          	auipc	ra,0x1
   157d2:	4f0080e7          	jalr	1264(ra) # 16cbe <__xbrtime_get_u2_seq>
   157d6:	a899                	j	1582c <xbrtime_uint16_get_nb+0xe8>
   157d8:	fd043783          	ld	a5,-48(s0)
   157dc:	fc042703          	lw	a4,-64(s0)
   157e0:	85ba                	mv	a1,a4
   157e2:	853e                	mv	a0,a5
   157e4:	ffffb097          	auipc	ra,0xffffb
   157e8:	036080e7          	jalr	54(ra) # 1081a <__xbrtime_ltor>
   157ec:	892a                	mv	s2,a0
   157ee:	fd843483          	ld	s1,-40(s0)
   157f2:	fc042783          	lw	a5,-64(s0)
   157f6:	853e                	mv	a0,a5
   157f8:	00001097          	auipc	ra,0x1
   157fc:	b9a080e7          	jalr	-1126(ra) # 16392 <xbrtime_decode_pe>
   15800:	87aa                	mv	a5,a0
   15802:	0007861b          	sext.w	a2,a5
   15806:	fc843783          	ld	a5,-56(s0)
   1580a:	0007869b          	sext.w	a3,a5
   1580e:	fc442783          	lw	a5,-60(s0)
   15812:	2781                	sext.w	a5,a5
   15814:	0017979b          	slliw	a5,a5,0x1
   15818:	2781                	sext.w	a5,a5
   1581a:	873e                	mv	a4,a5
   1581c:	85a6                	mv	a1,s1
   1581e:	854a                	mv	a0,s2
   15820:	00001097          	auipc	ra,0x1
   15824:	4ba080e7          	jalr	1210(ra) # 16cda <__xbrtime_get_u2_agg>
   15828:	a011                	j	1582c <xbrtime_uint16_get_nb+0xe8>
   1582a:	0001                	nop
   1582c:	70e2                	ld	ra,56(sp)
   1582e:	7442                	ld	s0,48(sp)
   15830:	74a2                	ld	s1,40(sp)
   15832:	7902                	ld	s2,32(sp)
   15834:	6121                	addi	sp,sp,64
   15836:	8082                	ret

0000000000015838 <xbrtime_uint32_get>:
   15838:	7139                	addi	sp,sp,-64
   1583a:	fc06                	sd	ra,56(sp)
   1583c:	f822                	sd	s0,48(sp)
   1583e:	f426                	sd	s1,40(sp)
   15840:	f04a                	sd	s2,32(sp)
   15842:	0080                	addi	s0,sp,64
   15844:	fca43c23          	sd	a0,-40(s0)
   15848:	fcb43823          	sd	a1,-48(s0)
   1584c:	fcc43423          	sd	a2,-56(s0)
   15850:	87b6                	mv	a5,a3
   15852:	fcf42223          	sw	a5,-60(s0)
   15856:	87ba                	mv	a5,a4
   15858:	fcf42023          	sw	a5,-64(s0)
   1585c:	fc843783          	ld	a5,-56(s0)
   15860:	c7cd                	beqz	a5,1590a <xbrtime_uint32_get+0xd2>
   15862:	fc442783          	lw	a5,-60(s0)
   15866:	0007871b          	sext.w	a4,a5
   1586a:	4785                	li	a5,1
   1586c:	00f71763          	bne	a4,a5,1587a <xbrtime_uint32_get+0x42>
   15870:	fc843703          	ld	a4,-56(s0)
   15874:	4785                	li	a5,1
   15876:	04f71563          	bne	a4,a5,158c0 <xbrtime_uint32_get+0x88>
   1587a:	fd043783          	ld	a5,-48(s0)
   1587e:	fc042703          	lw	a4,-64(s0)
   15882:	85ba                	mv	a1,a4
   15884:	853e                	mv	a0,a5
   15886:	f95fa0ef          	jal	ra,1081a <__xbrtime_ltor>
   1588a:	892a                	mv	s2,a0
   1588c:	fd843483          	ld	s1,-40(s0)
   15890:	fc042783          	lw	a5,-64(s0)
   15894:	853e                	mv	a0,a5
   15896:	2fd000ef          	jal	ra,16392 <xbrtime_decode_pe>
   1589a:	87aa                	mv	a5,a0
   1589c:	0007861b          	sext.w	a2,a5
   158a0:	fc843783          	ld	a5,-56(s0)
   158a4:	0007869b          	sext.w	a3,a5
   158a8:	fc442783          	lw	a5,-60(s0)
   158ac:	2781                	sext.w	a5,a5
   158ae:	0027979b          	slliw	a5,a5,0x2
   158b2:	2781                	sext.w	a5,a5
   158b4:	873e                	mv	a4,a5
   158b6:	85a6                	mv	a1,s1
   158b8:	854a                	mv	a0,s2
   158ba:	42e010ef          	jal	ra,16ce8 <__xbrtime_get_u4_seq>
   158be:	a099                	j	15904 <xbrtime_uint32_get+0xcc>
   158c0:	fd043783          	ld	a5,-48(s0)
   158c4:	fc042703          	lw	a4,-64(s0)
   158c8:	85ba                	mv	a1,a4
   158ca:	853e                	mv	a0,a5
   158cc:	f4ffa0ef          	jal	ra,1081a <__xbrtime_ltor>
   158d0:	892a                	mv	s2,a0
   158d2:	fd843483          	ld	s1,-40(s0)
   158d6:	fc042783          	lw	a5,-64(s0)
   158da:	853e                	mv	a0,a5
   158dc:	2b7000ef          	jal	ra,16392 <xbrtime_decode_pe>
   158e0:	87aa                	mv	a5,a0
   158e2:	0007861b          	sext.w	a2,a5
   158e6:	fc843783          	ld	a5,-56(s0)
   158ea:	0007869b          	sext.w	a3,a5
   158ee:	fc442783          	lw	a5,-60(s0)
   158f2:	2781                	sext.w	a5,a5
   158f4:	0027979b          	slliw	a5,a5,0x2
   158f8:	2781                	sext.w	a5,a5
   158fa:	873e                	mv	a4,a5
   158fc:	85a6                	mv	a1,s1
   158fe:	854a                	mv	a0,s2
   15900:	404010ef          	jal	ra,16d04 <__xbrtime_get_u4_agg>
   15904:	64a010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15908:	a011                	j	1590c <xbrtime_uint32_get+0xd4>
   1590a:	0001                	nop
   1590c:	70e2                	ld	ra,56(sp)
   1590e:	7442                	ld	s0,48(sp)
   15910:	74a2                	ld	s1,40(sp)
   15912:	7902                	ld	s2,32(sp)
   15914:	6121                	addi	sp,sp,64
   15916:	8082                	ret

0000000000015918 <xbrtime_uint32_get_nb>:
   15918:	7139                	addi	sp,sp,-64
   1591a:	fc06                	sd	ra,56(sp)
   1591c:	f822                	sd	s0,48(sp)
   1591e:	f426                	sd	s1,40(sp)
   15920:	f04a                	sd	s2,32(sp)
   15922:	0080                	addi	s0,sp,64
   15924:	fca43c23          	sd	a0,-40(s0)
   15928:	fcb43823          	sd	a1,-48(s0)
   1592c:	fcc43423          	sd	a2,-56(s0)
   15930:	87b6                	mv	a5,a3
   15932:	fcf42223          	sw	a5,-60(s0)
   15936:	87ba                	mv	a5,a4
   15938:	fcf42023          	sw	a5,-64(s0)
   1593c:	fc843783          	ld	a5,-56(s0)
   15940:	cfdd                	beqz	a5,159fe <xbrtime_uint32_get_nb+0xe6>
   15942:	fc442783          	lw	a5,-60(s0)
   15946:	0007871b          	sext.w	a4,a5
   1594a:	4785                	li	a5,1
   1594c:	00f71763          	bne	a4,a5,1595a <xbrtime_uint32_get_nb+0x42>
   15950:	fc843703          	ld	a4,-56(s0)
   15954:	4785                	li	a5,1
   15956:	04f71b63          	bne	a4,a5,159ac <xbrtime_uint32_get_nb+0x94>
   1595a:	fd043783          	ld	a5,-48(s0)
   1595e:	fc042703          	lw	a4,-64(s0)
   15962:	85ba                	mv	a1,a4
   15964:	853e                	mv	a0,a5
   15966:	ffffb097          	auipc	ra,0xffffb
   1596a:	eb4080e7          	jalr	-332(ra) # 1081a <__xbrtime_ltor>
   1596e:	892a                	mv	s2,a0
   15970:	fd843483          	ld	s1,-40(s0)
   15974:	fc042783          	lw	a5,-64(s0)
   15978:	853e                	mv	a0,a5
   1597a:	00001097          	auipc	ra,0x1
   1597e:	a18080e7          	jalr	-1512(ra) # 16392 <xbrtime_decode_pe>
   15982:	87aa                	mv	a5,a0
   15984:	0007861b          	sext.w	a2,a5
   15988:	fc843783          	ld	a5,-56(s0)
   1598c:	0007869b          	sext.w	a3,a5
   15990:	fc442783          	lw	a5,-60(s0)
   15994:	2781                	sext.w	a5,a5
   15996:	0027979b          	slliw	a5,a5,0x2
   1599a:	2781                	sext.w	a5,a5
   1599c:	873e                	mv	a4,a5
   1599e:	85a6                	mv	a1,s1
   159a0:	854a                	mv	a0,s2
   159a2:	00001097          	auipc	ra,0x1
   159a6:	346080e7          	jalr	838(ra) # 16ce8 <__xbrtime_get_u4_seq>
   159aa:	a899                	j	15a00 <xbrtime_uint32_get_nb+0xe8>
   159ac:	fd043783          	ld	a5,-48(s0)
   159b0:	fc042703          	lw	a4,-64(s0)
   159b4:	85ba                	mv	a1,a4
   159b6:	853e                	mv	a0,a5
   159b8:	ffffb097          	auipc	ra,0xffffb
   159bc:	e62080e7          	jalr	-414(ra) # 1081a <__xbrtime_ltor>
   159c0:	892a                	mv	s2,a0
   159c2:	fd843483          	ld	s1,-40(s0)
   159c6:	fc042783          	lw	a5,-64(s0)
   159ca:	853e                	mv	a0,a5
   159cc:	00001097          	auipc	ra,0x1
   159d0:	9c6080e7          	jalr	-1594(ra) # 16392 <xbrtime_decode_pe>
   159d4:	87aa                	mv	a5,a0
   159d6:	0007861b          	sext.w	a2,a5
   159da:	fc843783          	ld	a5,-56(s0)
   159de:	0007869b          	sext.w	a3,a5
   159e2:	fc442783          	lw	a5,-60(s0)
   159e6:	2781                	sext.w	a5,a5
   159e8:	0027979b          	slliw	a5,a5,0x2
   159ec:	2781                	sext.w	a5,a5
   159ee:	873e                	mv	a4,a5
   159f0:	85a6                	mv	a1,s1
   159f2:	854a                	mv	a0,s2
   159f4:	00001097          	auipc	ra,0x1
   159f8:	310080e7          	jalr	784(ra) # 16d04 <__xbrtime_get_u4_agg>
   159fc:	a011                	j	15a00 <xbrtime_uint32_get_nb+0xe8>
   159fe:	0001                	nop
   15a00:	70e2                	ld	ra,56(sp)
   15a02:	7442                	ld	s0,48(sp)
   15a04:	74a2                	ld	s1,40(sp)
   15a06:	7902                	ld	s2,32(sp)
   15a08:	6121                	addi	sp,sp,64
   15a0a:	8082                	ret

0000000000015a0c <xbrtime_uint64_get>:
   15a0c:	7139                	addi	sp,sp,-64
   15a0e:	fc06                	sd	ra,56(sp)
   15a10:	f822                	sd	s0,48(sp)
   15a12:	f426                	sd	s1,40(sp)
   15a14:	f04a                	sd	s2,32(sp)
   15a16:	0080                	addi	s0,sp,64
   15a18:	fca43c23          	sd	a0,-40(s0)
   15a1c:	fcb43823          	sd	a1,-48(s0)
   15a20:	fcc43423          	sd	a2,-56(s0)
   15a24:	87b6                	mv	a5,a3
   15a26:	fcf42223          	sw	a5,-60(s0)
   15a2a:	87ba                	mv	a5,a4
   15a2c:	fcf42023          	sw	a5,-64(s0)
   15a30:	fc843783          	ld	a5,-56(s0)
   15a34:	c7cd                	beqz	a5,15ade <xbrtime_uint64_get+0xd2>
   15a36:	fc442783          	lw	a5,-60(s0)
   15a3a:	0007871b          	sext.w	a4,a5
   15a3e:	4785                	li	a5,1
   15a40:	00f71763          	bne	a4,a5,15a4e <xbrtime_uint64_get+0x42>
   15a44:	fc843703          	ld	a4,-56(s0)
   15a48:	4785                	li	a5,1
   15a4a:	04f71563          	bne	a4,a5,15a94 <xbrtime_uint64_get+0x88>
   15a4e:	fd043783          	ld	a5,-48(s0)
   15a52:	fc042703          	lw	a4,-64(s0)
   15a56:	85ba                	mv	a1,a4
   15a58:	853e                	mv	a0,a5
   15a5a:	dc1fa0ef          	jal	ra,1081a <__xbrtime_ltor>
   15a5e:	892a                	mv	s2,a0
   15a60:	fd843483          	ld	s1,-40(s0)
   15a64:	fc042783          	lw	a5,-64(s0)
   15a68:	853e                	mv	a0,a5
   15a6a:	129000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15a6e:	87aa                	mv	a5,a0
   15a70:	0007861b          	sext.w	a2,a5
   15a74:	fc843783          	ld	a5,-56(s0)
   15a78:	0007869b          	sext.w	a3,a5
   15a7c:	fc442783          	lw	a5,-60(s0)
   15a80:	2781                	sext.w	a5,a5
   15a82:	0037979b          	slliw	a5,a5,0x3
   15a86:	2781                	sext.w	a5,a5
   15a88:	873e                	mv	a4,a5
   15a8a:	85a6                	mv	a1,s1
   15a8c:	854a                	mv	a0,s2
   15a8e:	284010ef          	jal	ra,16d12 <__xbrtime_get_u8_seq>
   15a92:	a099                	j	15ad8 <xbrtime_uint64_get+0xcc>
   15a94:	fd043783          	ld	a5,-48(s0)
   15a98:	fc042703          	lw	a4,-64(s0)
   15a9c:	85ba                	mv	a1,a4
   15a9e:	853e                	mv	a0,a5
   15aa0:	d7bfa0ef          	jal	ra,1081a <__xbrtime_ltor>
   15aa4:	892a                	mv	s2,a0
   15aa6:	fd843483          	ld	s1,-40(s0)
   15aaa:	fc042783          	lw	a5,-64(s0)
   15aae:	853e                	mv	a0,a5
   15ab0:	0e3000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15ab4:	87aa                	mv	a5,a0
   15ab6:	0007861b          	sext.w	a2,a5
   15aba:	fc843783          	ld	a5,-56(s0)
   15abe:	0007869b          	sext.w	a3,a5
   15ac2:	fc442783          	lw	a5,-60(s0)
   15ac6:	2781                	sext.w	a5,a5
   15ac8:	0037979b          	slliw	a5,a5,0x3
   15acc:	2781                	sext.w	a5,a5
   15ace:	873e                	mv	a4,a5
   15ad0:	85a6                	mv	a1,s1
   15ad2:	854a                	mv	a0,s2
   15ad4:	25a010ef          	jal	ra,16d2e <__xbrtime_get_u8_agg>
   15ad8:	476010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15adc:	a011                	j	15ae0 <xbrtime_uint64_get+0xd4>
   15ade:	0001                	nop
   15ae0:	70e2                	ld	ra,56(sp)
   15ae2:	7442                	ld	s0,48(sp)
   15ae4:	74a2                	ld	s1,40(sp)
   15ae6:	7902                	ld	s2,32(sp)
   15ae8:	6121                	addi	sp,sp,64
   15aea:	8082                	ret

0000000000015aec <xbrtime_uint64_get_nb>:
   15aec:	7139                	addi	sp,sp,-64
   15aee:	fc06                	sd	ra,56(sp)
   15af0:	f822                	sd	s0,48(sp)
   15af2:	f426                	sd	s1,40(sp)
   15af4:	f04a                	sd	s2,32(sp)
   15af6:	0080                	addi	s0,sp,64
   15af8:	fca43c23          	sd	a0,-40(s0)
   15afc:	fcb43823          	sd	a1,-48(s0)
   15b00:	fcc43423          	sd	a2,-56(s0)
   15b04:	87b6                	mv	a5,a3
   15b06:	fcf42223          	sw	a5,-60(s0)
   15b0a:	87ba                	mv	a5,a4
   15b0c:	fcf42023          	sw	a5,-64(s0)
   15b10:	fc843783          	ld	a5,-56(s0)
   15b14:	cfdd                	beqz	a5,15bd2 <xbrtime_uint64_get_nb+0xe6>
   15b16:	fc442783          	lw	a5,-60(s0)
   15b1a:	0007871b          	sext.w	a4,a5
   15b1e:	4785                	li	a5,1
   15b20:	00f71763          	bne	a4,a5,15b2e <xbrtime_uint64_get_nb+0x42>
   15b24:	fc843703          	ld	a4,-56(s0)
   15b28:	4785                	li	a5,1
   15b2a:	04f71b63          	bne	a4,a5,15b80 <xbrtime_uint64_get_nb+0x94>
   15b2e:	fd043783          	ld	a5,-48(s0)
   15b32:	fc042703          	lw	a4,-64(s0)
   15b36:	85ba                	mv	a1,a4
   15b38:	853e                	mv	a0,a5
   15b3a:	ffffb097          	auipc	ra,0xffffb
   15b3e:	ce0080e7          	jalr	-800(ra) # 1081a <__xbrtime_ltor>
   15b42:	892a                	mv	s2,a0
   15b44:	fd843483          	ld	s1,-40(s0)
   15b48:	fc042783          	lw	a5,-64(s0)
   15b4c:	853e                	mv	a0,a5
   15b4e:	00001097          	auipc	ra,0x1
   15b52:	844080e7          	jalr	-1980(ra) # 16392 <xbrtime_decode_pe>
   15b56:	87aa                	mv	a5,a0
   15b58:	0007861b          	sext.w	a2,a5
   15b5c:	fc843783          	ld	a5,-56(s0)
   15b60:	0007869b          	sext.w	a3,a5
   15b64:	fc442783          	lw	a5,-60(s0)
   15b68:	2781                	sext.w	a5,a5
   15b6a:	0037979b          	slliw	a5,a5,0x3
   15b6e:	2781                	sext.w	a5,a5
   15b70:	873e                	mv	a4,a5
   15b72:	85a6                	mv	a1,s1
   15b74:	854a                	mv	a0,s2
   15b76:	00001097          	auipc	ra,0x1
   15b7a:	19c080e7          	jalr	412(ra) # 16d12 <__xbrtime_get_u8_seq>
   15b7e:	a899                	j	15bd4 <xbrtime_uint64_get_nb+0xe8>
   15b80:	fd043783          	ld	a5,-48(s0)
   15b84:	fc042703          	lw	a4,-64(s0)
   15b88:	85ba                	mv	a1,a4
   15b8a:	853e                	mv	a0,a5
   15b8c:	ffffb097          	auipc	ra,0xffffb
   15b90:	c8e080e7          	jalr	-882(ra) # 1081a <__xbrtime_ltor>
   15b94:	892a                	mv	s2,a0
   15b96:	fd843483          	ld	s1,-40(s0)
   15b9a:	fc042783          	lw	a5,-64(s0)
   15b9e:	853e                	mv	a0,a5
   15ba0:	00000097          	auipc	ra,0x0
   15ba4:	7f2080e7          	jalr	2034(ra) # 16392 <xbrtime_decode_pe>
   15ba8:	87aa                	mv	a5,a0
   15baa:	0007861b          	sext.w	a2,a5
   15bae:	fc843783          	ld	a5,-56(s0)
   15bb2:	0007869b          	sext.w	a3,a5
   15bb6:	fc442783          	lw	a5,-60(s0)
   15bba:	2781                	sext.w	a5,a5
   15bbc:	0037979b          	slliw	a5,a5,0x3
   15bc0:	2781                	sext.w	a5,a5
   15bc2:	873e                	mv	a4,a5
   15bc4:	85a6                	mv	a1,s1
   15bc6:	854a                	mv	a0,s2
   15bc8:	00001097          	auipc	ra,0x1
   15bcc:	166080e7          	jalr	358(ra) # 16d2e <__xbrtime_get_u8_agg>
   15bd0:	a011                	j	15bd4 <xbrtime_uint64_get_nb+0xe8>
   15bd2:	0001                	nop
   15bd4:	70e2                	ld	ra,56(sp)
   15bd6:	7442                	ld	s0,48(sp)
   15bd8:	74a2                	ld	s1,40(sp)
   15bda:	7902                	ld	s2,32(sp)
   15bdc:	6121                	addi	sp,sp,64
   15bde:	8082                	ret

0000000000015be0 <xbrtime_size_get>:
   15be0:	7139                	addi	sp,sp,-64
   15be2:	fc06                	sd	ra,56(sp)
   15be4:	f822                	sd	s0,48(sp)
   15be6:	f426                	sd	s1,40(sp)
   15be8:	f04a                	sd	s2,32(sp)
   15bea:	0080                	addi	s0,sp,64
   15bec:	fca43c23          	sd	a0,-40(s0)
   15bf0:	fcb43823          	sd	a1,-48(s0)
   15bf4:	fcc43423          	sd	a2,-56(s0)
   15bf8:	87b6                	mv	a5,a3
   15bfa:	fcf42223          	sw	a5,-60(s0)
   15bfe:	87ba                	mv	a5,a4
   15c00:	fcf42023          	sw	a5,-64(s0)
   15c04:	fc843783          	ld	a5,-56(s0)
   15c08:	c7cd                	beqz	a5,15cb2 <xbrtime_size_get+0xd2>
   15c0a:	fc442783          	lw	a5,-60(s0)
   15c0e:	0007871b          	sext.w	a4,a5
   15c12:	4785                	li	a5,1
   15c14:	00f71763          	bne	a4,a5,15c22 <xbrtime_size_get+0x42>
   15c18:	fc843703          	ld	a4,-56(s0)
   15c1c:	4785                	li	a5,1
   15c1e:	04f71563          	bne	a4,a5,15c68 <xbrtime_size_get+0x88>
   15c22:	fd043783          	ld	a5,-48(s0)
   15c26:	fc042703          	lw	a4,-64(s0)
   15c2a:	85ba                	mv	a1,a4
   15c2c:	853e                	mv	a0,a5
   15c2e:	bedfa0ef          	jal	ra,1081a <__xbrtime_ltor>
   15c32:	892a                	mv	s2,a0
   15c34:	fd843483          	ld	s1,-40(s0)
   15c38:	fc042783          	lw	a5,-64(s0)
   15c3c:	853e                	mv	a0,a5
   15c3e:	754000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15c42:	87aa                	mv	a5,a0
   15c44:	0007861b          	sext.w	a2,a5
   15c48:	fc843783          	ld	a5,-56(s0)
   15c4c:	0007869b          	sext.w	a3,a5
   15c50:	fc442783          	lw	a5,-60(s0)
   15c54:	2781                	sext.w	a5,a5
   15c56:	0037979b          	slliw	a5,a5,0x3
   15c5a:	2781                	sext.w	a5,a5
   15c5c:	873e                	mv	a4,a5
   15c5e:	85a6                	mv	a1,s1
   15c60:	854a                	mv	a0,s2
   15c62:	086010ef          	jal	ra,16ce8 <__xbrtime_get_u4_seq>
   15c66:	a099                	j	15cac <xbrtime_size_get+0xcc>
   15c68:	fd043783          	ld	a5,-48(s0)
   15c6c:	fc042703          	lw	a4,-64(s0)
   15c70:	85ba                	mv	a1,a4
   15c72:	853e                	mv	a0,a5
   15c74:	ba7fa0ef          	jal	ra,1081a <__xbrtime_ltor>
   15c78:	892a                	mv	s2,a0
   15c7a:	fd843483          	ld	s1,-40(s0)
   15c7e:	fc042783          	lw	a5,-64(s0)
   15c82:	853e                	mv	a0,a5
   15c84:	70e000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15c88:	87aa                	mv	a5,a0
   15c8a:	0007861b          	sext.w	a2,a5
   15c8e:	fc843783          	ld	a5,-56(s0)
   15c92:	0007869b          	sext.w	a3,a5
   15c96:	fc442783          	lw	a5,-60(s0)
   15c9a:	2781                	sext.w	a5,a5
   15c9c:	0037979b          	slliw	a5,a5,0x3
   15ca0:	2781                	sext.w	a5,a5
   15ca2:	873e                	mv	a4,a5
   15ca4:	85a6                	mv	a1,s1
   15ca6:	854a                	mv	a0,s2
   15ca8:	05c010ef          	jal	ra,16d04 <__xbrtime_get_u4_agg>
   15cac:	2a2010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15cb0:	a011                	j	15cb4 <xbrtime_size_get+0xd4>
   15cb2:	0001                	nop
   15cb4:	70e2                	ld	ra,56(sp)
   15cb6:	7442                	ld	s0,48(sp)
   15cb8:	74a2                	ld	s1,40(sp)
   15cba:	7902                	ld	s2,32(sp)
   15cbc:	6121                	addi	sp,sp,64
   15cbe:	8082                	ret

0000000000015cc0 <xbrtime_size_get_nb>:
   15cc0:	7139                	addi	sp,sp,-64
   15cc2:	fc06                	sd	ra,56(sp)
   15cc4:	f822                	sd	s0,48(sp)
   15cc6:	f426                	sd	s1,40(sp)
   15cc8:	f04a                	sd	s2,32(sp)
   15cca:	0080                	addi	s0,sp,64
   15ccc:	fca43c23          	sd	a0,-40(s0)
   15cd0:	fcb43823          	sd	a1,-48(s0)
   15cd4:	fcc43423          	sd	a2,-56(s0)
   15cd8:	87b6                	mv	a5,a3
   15cda:	fcf42223          	sw	a5,-60(s0)
   15cde:	87ba                	mv	a5,a4
   15ce0:	fcf42023          	sw	a5,-64(s0)
   15ce4:	fc843783          	ld	a5,-56(s0)
   15ce8:	cfdd                	beqz	a5,15da6 <xbrtime_size_get_nb+0xe6>
   15cea:	fc442783          	lw	a5,-60(s0)
   15cee:	0007871b          	sext.w	a4,a5
   15cf2:	4785                	li	a5,1
   15cf4:	00f71763          	bne	a4,a5,15d02 <xbrtime_size_get_nb+0x42>
   15cf8:	fc843703          	ld	a4,-56(s0)
   15cfc:	4785                	li	a5,1
   15cfe:	04f71b63          	bne	a4,a5,15d54 <xbrtime_size_get_nb+0x94>
   15d02:	fd043783          	ld	a5,-48(s0)
   15d06:	fc042703          	lw	a4,-64(s0)
   15d0a:	85ba                	mv	a1,a4
   15d0c:	853e                	mv	a0,a5
   15d0e:	ffffb097          	auipc	ra,0xffffb
   15d12:	b0c080e7          	jalr	-1268(ra) # 1081a <__xbrtime_ltor>
   15d16:	892a                	mv	s2,a0
   15d18:	fd843483          	ld	s1,-40(s0)
   15d1c:	fc042783          	lw	a5,-64(s0)
   15d20:	853e                	mv	a0,a5
   15d22:	00000097          	auipc	ra,0x0
   15d26:	670080e7          	jalr	1648(ra) # 16392 <xbrtime_decode_pe>
   15d2a:	87aa                	mv	a5,a0
   15d2c:	0007861b          	sext.w	a2,a5
   15d30:	fc843783          	ld	a5,-56(s0)
   15d34:	0007869b          	sext.w	a3,a5
   15d38:	fc442783          	lw	a5,-60(s0)
   15d3c:	2781                	sext.w	a5,a5
   15d3e:	0037979b          	slliw	a5,a5,0x3
   15d42:	2781                	sext.w	a5,a5
   15d44:	873e                	mv	a4,a5
   15d46:	85a6                	mv	a1,s1
   15d48:	854a                	mv	a0,s2
   15d4a:	00001097          	auipc	ra,0x1
   15d4e:	f9e080e7          	jalr	-98(ra) # 16ce8 <__xbrtime_get_u4_seq>
   15d52:	a899                	j	15da8 <xbrtime_size_get_nb+0xe8>
   15d54:	fd043783          	ld	a5,-48(s0)
   15d58:	fc042703          	lw	a4,-64(s0)
   15d5c:	85ba                	mv	a1,a4
   15d5e:	853e                	mv	a0,a5
   15d60:	ffffb097          	auipc	ra,0xffffb
   15d64:	aba080e7          	jalr	-1350(ra) # 1081a <__xbrtime_ltor>
   15d68:	892a                	mv	s2,a0
   15d6a:	fd843483          	ld	s1,-40(s0)
   15d6e:	fc042783          	lw	a5,-64(s0)
   15d72:	853e                	mv	a0,a5
   15d74:	00000097          	auipc	ra,0x0
   15d78:	61e080e7          	jalr	1566(ra) # 16392 <xbrtime_decode_pe>
   15d7c:	87aa                	mv	a5,a0
   15d7e:	0007861b          	sext.w	a2,a5
   15d82:	fc843783          	ld	a5,-56(s0)
   15d86:	0007869b          	sext.w	a3,a5
   15d8a:	fc442783          	lw	a5,-60(s0)
   15d8e:	2781                	sext.w	a5,a5
   15d90:	0037979b          	slliw	a5,a5,0x3
   15d94:	2781                	sext.w	a5,a5
   15d96:	873e                	mv	a4,a5
   15d98:	85a6                	mv	a1,s1
   15d9a:	854a                	mv	a0,s2
   15d9c:	00001097          	auipc	ra,0x1
   15da0:	f68080e7          	jalr	-152(ra) # 16d04 <__xbrtime_get_u4_agg>
   15da4:	a011                	j	15da8 <xbrtime_size_get_nb+0xe8>
   15da6:	0001                	nop
   15da8:	70e2                	ld	ra,56(sp)
   15daa:	7442                	ld	s0,48(sp)
   15dac:	74a2                	ld	s1,40(sp)
   15dae:	7902                	ld	s2,32(sp)
   15db0:	6121                	addi	sp,sp,64
   15db2:	8082                	ret

0000000000015db4 <xbrtime_ptrdiff_get>:
   15db4:	7139                	addi	sp,sp,-64
   15db6:	fc06                	sd	ra,56(sp)
   15db8:	f822                	sd	s0,48(sp)
   15dba:	f426                	sd	s1,40(sp)
   15dbc:	f04a                	sd	s2,32(sp)
   15dbe:	0080                	addi	s0,sp,64
   15dc0:	fca43c23          	sd	a0,-40(s0)
   15dc4:	fcb43823          	sd	a1,-48(s0)
   15dc8:	fcc43423          	sd	a2,-56(s0)
   15dcc:	87b6                	mv	a5,a3
   15dce:	fcf42223          	sw	a5,-60(s0)
   15dd2:	87ba                	mv	a5,a4
   15dd4:	fcf42023          	sw	a5,-64(s0)
   15dd8:	fc843783          	ld	a5,-56(s0)
   15ddc:	c7cd                	beqz	a5,15e86 <xbrtime_ptrdiff_get+0xd2>
   15dde:	fc442783          	lw	a5,-60(s0)
   15de2:	0007871b          	sext.w	a4,a5
   15de6:	4785                	li	a5,1
   15de8:	00f71763          	bne	a4,a5,15df6 <xbrtime_ptrdiff_get+0x42>
   15dec:	fc843703          	ld	a4,-56(s0)
   15df0:	4785                	li	a5,1
   15df2:	04f71563          	bne	a4,a5,15e3c <xbrtime_ptrdiff_get+0x88>
   15df6:	fd043783          	ld	a5,-48(s0)
   15dfa:	fc042703          	lw	a4,-64(s0)
   15dfe:	85ba                	mv	a1,a4
   15e00:	853e                	mv	a0,a5
   15e02:	a19fa0ef          	jal	ra,1081a <__xbrtime_ltor>
   15e06:	892a                	mv	s2,a0
   15e08:	fd843483          	ld	s1,-40(s0)
   15e0c:	fc042783          	lw	a5,-64(s0)
   15e10:	853e                	mv	a0,a5
   15e12:	580000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15e16:	87aa                	mv	a5,a0
   15e18:	0007861b          	sext.w	a2,a5
   15e1c:	fc843783          	ld	a5,-56(s0)
   15e20:	0007869b          	sext.w	a3,a5
   15e24:	fc442783          	lw	a5,-60(s0)
   15e28:	2781                	sext.w	a5,a5
   15e2a:	0037979b          	slliw	a5,a5,0x3
   15e2e:	2781                	sext.w	a5,a5
   15e30:	873e                	mv	a4,a5
   15e32:	85a6                	mv	a1,s1
   15e34:	854a                	mv	a0,s2
   15e36:	75b000ef          	jal	ra,16d90 <__xbrtime_get_s4_seq>
   15e3a:	a099                	j	15e80 <xbrtime_ptrdiff_get+0xcc>
   15e3c:	fd043783          	ld	a5,-48(s0)
   15e40:	fc042703          	lw	a4,-64(s0)
   15e44:	85ba                	mv	a1,a4
   15e46:	853e                	mv	a0,a5
   15e48:	9d3fa0ef          	jal	ra,1081a <__xbrtime_ltor>
   15e4c:	892a                	mv	s2,a0
   15e4e:	fd843483          	ld	s1,-40(s0)
   15e52:	fc042783          	lw	a5,-64(s0)
   15e56:	853e                	mv	a0,a5
   15e58:	53a000ef          	jal	ra,16392 <xbrtime_decode_pe>
   15e5c:	87aa                	mv	a5,a0
   15e5e:	0007861b          	sext.w	a2,a5
   15e62:	fc843783          	ld	a5,-56(s0)
   15e66:	0007869b          	sext.w	a3,a5
   15e6a:	fc442783          	lw	a5,-60(s0)
   15e6e:	2781                	sext.w	a5,a5
   15e70:	0037979b          	slliw	a5,a5,0x3
   15e74:	2781                	sext.w	a5,a5
   15e76:	873e                	mv	a4,a5
   15e78:	85a6                	mv	a1,s1
   15e7a:	854a                	mv	a0,s2
   15e7c:	731000ef          	jal	ra,16dac <__xbrtime_get_s4_agg>
   15e80:	0ce010ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   15e84:	a011                	j	15e88 <xbrtime_ptrdiff_get+0xd4>
   15e86:	0001                	nop
   15e88:	70e2                	ld	ra,56(sp)
   15e8a:	7442                	ld	s0,48(sp)
   15e8c:	74a2                	ld	s1,40(sp)
   15e8e:	7902                	ld	s2,32(sp)
   15e90:	6121                	addi	sp,sp,64
   15e92:	8082                	ret

0000000000015e94 <xbrtime_ptrdiff_get_nb>:
   15e94:	7139                	addi	sp,sp,-64
   15e96:	fc06                	sd	ra,56(sp)
   15e98:	f822                	sd	s0,48(sp)
   15e9a:	f426                	sd	s1,40(sp)
   15e9c:	f04a                	sd	s2,32(sp)
   15e9e:	0080                	addi	s0,sp,64
   15ea0:	fca43c23          	sd	a0,-40(s0)
   15ea4:	fcb43823          	sd	a1,-48(s0)
   15ea8:	fcc43423          	sd	a2,-56(s0)
   15eac:	87b6                	mv	a5,a3
   15eae:	fcf42223          	sw	a5,-60(s0)
   15eb2:	87ba                	mv	a5,a4
   15eb4:	fcf42023          	sw	a5,-64(s0)
   15eb8:	fc843783          	ld	a5,-56(s0)
   15ebc:	cfdd                	beqz	a5,15f7a <xbrtime_ptrdiff_get_nb+0xe6>
   15ebe:	fc442783          	lw	a5,-60(s0)
   15ec2:	0007871b          	sext.w	a4,a5
   15ec6:	4785                	li	a5,1
   15ec8:	00f71763          	bne	a4,a5,15ed6 <xbrtime_ptrdiff_get_nb+0x42>
   15ecc:	fc843703          	ld	a4,-56(s0)
   15ed0:	4785                	li	a5,1
   15ed2:	04f71b63          	bne	a4,a5,15f28 <xbrtime_ptrdiff_get_nb+0x94>
   15ed6:	fd043783          	ld	a5,-48(s0)
   15eda:	fc042703          	lw	a4,-64(s0)
   15ede:	85ba                	mv	a1,a4
   15ee0:	853e                	mv	a0,a5
   15ee2:	ffffb097          	auipc	ra,0xffffb
   15ee6:	938080e7          	jalr	-1736(ra) # 1081a <__xbrtime_ltor>
   15eea:	892a                	mv	s2,a0
   15eec:	fd843483          	ld	s1,-40(s0)
   15ef0:	fc042783          	lw	a5,-64(s0)
   15ef4:	853e                	mv	a0,a5
   15ef6:	00000097          	auipc	ra,0x0
   15efa:	49c080e7          	jalr	1180(ra) # 16392 <xbrtime_decode_pe>
   15efe:	87aa                	mv	a5,a0
   15f00:	0007861b          	sext.w	a2,a5
   15f04:	fc843783          	ld	a5,-56(s0)
   15f08:	0007869b          	sext.w	a3,a5
   15f0c:	fc442783          	lw	a5,-60(s0)
   15f10:	2781                	sext.w	a5,a5
   15f12:	0037979b          	slliw	a5,a5,0x3
   15f16:	2781                	sext.w	a5,a5
   15f18:	873e                	mv	a4,a5
   15f1a:	85a6                	mv	a1,s1
   15f1c:	854a                	mv	a0,s2
   15f1e:	00001097          	auipc	ra,0x1
   15f22:	e72080e7          	jalr	-398(ra) # 16d90 <__xbrtime_get_s4_seq>
   15f26:	a899                	j	15f7c <xbrtime_ptrdiff_get_nb+0xe8>
   15f28:	fd043783          	ld	a5,-48(s0)
   15f2c:	fc042703          	lw	a4,-64(s0)
   15f30:	85ba                	mv	a1,a4
   15f32:	853e                	mv	a0,a5
   15f34:	ffffb097          	auipc	ra,0xffffb
   15f38:	8e6080e7          	jalr	-1818(ra) # 1081a <__xbrtime_ltor>
   15f3c:	892a                	mv	s2,a0
   15f3e:	fd843483          	ld	s1,-40(s0)
   15f42:	fc042783          	lw	a5,-64(s0)
   15f46:	853e                	mv	a0,a5
   15f48:	00000097          	auipc	ra,0x0
   15f4c:	44a080e7          	jalr	1098(ra) # 16392 <xbrtime_decode_pe>
   15f50:	87aa                	mv	a5,a0
   15f52:	0007861b          	sext.w	a2,a5
   15f56:	fc843783          	ld	a5,-56(s0)
   15f5a:	0007869b          	sext.w	a3,a5
   15f5e:	fc442783          	lw	a5,-60(s0)
   15f62:	2781                	sext.w	a5,a5
   15f64:	0037979b          	slliw	a5,a5,0x3
   15f68:	2781                	sext.w	a5,a5
   15f6a:	873e                	mv	a4,a5
   15f6c:	85a6                	mv	a1,s1
   15f6e:	854a                	mv	a0,s2
   15f70:	00001097          	auipc	ra,0x1
   15f74:	e3c080e7          	jalr	-452(ra) # 16dac <__xbrtime_get_s4_agg>
   15f78:	a011                	j	15f7c <xbrtime_ptrdiff_get_nb+0xe8>
   15f7a:	0001                	nop
   15f7c:	70e2                	ld	ra,56(sp)
   15f7e:	7442                	ld	s0,48(sp)
   15f80:	74a2                	ld	s1,40(sp)
   15f82:	7902                	ld	s2,32(sp)
   15f84:	6121                	addi	sp,sp,64
   15f86:	8082                	ret

0000000000015f88 <xbrtime_barrier>:
   15f88:	711d                	addi	sp,sp,-96
   15f8a:	ec86                	sd	ra,88(sp)
   15f8c:	e8a2                	sd	s0,80(sp)
   15f8e:	a4a2                	fsd	fs0,72(sp)
   15f90:	1080                	addi	s0,sp,96
   15f92:	fc043c23          	sd	zero,-40(s0)
   15f96:	4785                	li	a5,1
   15f98:	fcf43823          	sd	a5,-48(s0)
   15f9c:	fc043023          	sd	zero,-64(s0)
   15fa0:	fa043c23          	sd	zero,-72(s0)
   15fa4:	3fff07b7          	lui	a5,0x3fff0
   15fa8:	02078793          	addi	a5,a5,32 # 3fff0020 <__global_pointer$+0x3ffd70c8>
   15fac:	639c                	ld	a5,0(a5)
   15fae:	faf43023          	sd	a5,-96(s0)
   15fb2:	00000097          	auipc	ra,0x0
   15fb6:	3c8080e7          	jalr	968(ra) # 1637a <xbrtime_num_pes>
   15fba:	87aa                	mv	a5,a0
   15fbc:	faf43823          	sd	a5,-80(s0)
   15fc0:	fb043703          	ld	a4,-80(s0)
   15fc4:	4785                	li	a5,1
   15fc6:	16f70a63          	beq	a4,a5,1613a <xbrtime_barrier+0x1b2>
   15fca:	39a000ef          	jal	ra,16364 <xbrtime_mype>
   15fce:	87aa                	mv	a5,a0
   15fd0:	faf42623          	sw	a5,-84(s0)
   15fd4:	fb043783          	ld	a5,-80(s0)
   15fd8:	d227f7d3          	fcvt.d.l	fa5,a5
   15fdc:	22f78553          	fmv.d	fa0,fa5
   15fe0:	791000ef          	jal	ra,16f70 <log>
   15fe4:	22a50753          	fmv.d	fa4,fa0
   15fe8:	67e1                	lui	a5,0x18
   15fea:	9b07b787          	fld	fa5,-1616(a5) # 179b0 <_exit+0xb4>
   15fee:	1af777d3          	fdiv.d	fa5,fa4,fa5
   15ff2:	c22797d3          	fcvt.l.d	a5,fa5,rtz
   15ff6:	fcf43423          	sd	a5,-56(s0)
   15ffa:	fc843783          	ld	a5,-56(s0)
   15ffe:	d227f453          	fcvt.d.l	fs0,a5
   16002:	fb043783          	ld	a5,-80(s0)
   16006:	d227f7d3          	fcvt.d.l	fa5,a5
   1600a:	22f78553          	fmv.d	fa0,fa5
   1600e:	763000ef          	jal	ra,16f70 <log>
   16012:	22a50753          	fmv.d	fa4,fa0
   16016:	67e1                	lui	a5,0x18
   16018:	9b07b787          	fld	fa5,-1616(a5) # 179b0 <_exit+0xb4>
   1601c:	1af777d3          	fdiv.d	fa5,fa4,fa5
   16020:	a2f417d3          	flt.d	a5,fs0,fa5
   16024:	c791                	beqz	a5,16030 <xbrtime_barrier+0xa8>
   16026:	fc843783          	ld	a5,-56(s0)
   1602a:	0785                	addi	a5,a5,1
   1602c:	fcf43423          	sd	a5,-56(s0)
   16030:	71f000ef          	jal	ra,16f4e <__xbrtime_asm_fence>
   16034:	a871                	j	160d0 <xbrtime_barrier+0x148>
   16036:	fac42703          	lw	a4,-84(s0)
   1603a:	fd043783          	ld	a5,-48(s0)
   1603e:	973e                	add	a4,a4,a5
   16040:	fb043783          	ld	a5,-80(s0)
   16044:	02f767b3          	rem	a5,a4,a5
   16048:	fcf43023          	sd	a5,-64(s0)
   1604c:	fc043783          	ld	a5,-64(s0)
   16050:	2781                	sext.w	a5,a5
   16052:	853e                	mv	a0,a5
   16054:	33e000ef          	jal	ra,16392 <xbrtime_decode_pe>
   16058:	87aa                	mv	a5,a0
   1605a:	fcf43023          	sd	a5,-64(s0)
   1605e:	fa043703          	ld	a4,-96(s0)
   16062:	87ba                	mv	a5,a4
   16064:	078a                	slli	a5,a5,0x2
   16066:	97ba                	add	a5,a5,a4
   16068:	0786                	slli	a5,a5,0x1
   1606a:	873e                	mv	a4,a5
   1606c:	fd843783          	ld	a5,-40(s0)
   16070:	973e                	add	a4,a4,a5
   16072:	07ffe7b7          	lui	a5,0x7ffe
   16076:	0795                	addi	a5,a5,5
   16078:	97ba                	add	a5,a5,a4
   1607a:	078e                	slli	a5,a5,0x3
   1607c:	faf43c23          	sd	a5,-72(s0)
   16080:	fd043783          	ld	a5,-48(s0)
   16084:	863e                	mv	a2,a5
   16086:	fc043583          	ld	a1,-64(s0)
   1608a:	fb843503          	ld	a0,-72(s0)
   1608e:	6d7000ef          	jal	ra,16f64 <__xbrtime_remote_touch>
   16092:	0001                	nop
   16094:	fa043703          	ld	a4,-96(s0)
   16098:	87ba                	mv	a5,a4
   1609a:	078a                	slli	a5,a5,0x2
   1609c:	97ba                	add	a5,a5,a4
   1609e:	0786                	slli	a5,a5,0x1
   160a0:	873e                	mv	a4,a5
   160a2:	fd843783          	ld	a5,-40(s0)
   160a6:	973e                	add	a4,a4,a5
   160a8:	07ffe7b7          	lui	a5,0x7ffe
   160ac:	0795                	addi	a5,a5,5
   160ae:	97ba                	add	a5,a5,a4
   160b0:	078e                	slli	a5,a5,0x3
   160b2:	6398                	ld	a4,0(a5)
   160b4:	fd043783          	ld	a5,-48(s0)
   160b8:	fcf71ee3          	bne	a4,a5,16094 <xbrtime_barrier+0x10c>
   160bc:	fd043783          	ld	a5,-48(s0)
   160c0:	0786                	slli	a5,a5,0x1
   160c2:	fcf43823          	sd	a5,-48(s0)
   160c6:	fd843783          	ld	a5,-40(s0)
   160ca:	0785                	addi	a5,a5,1
   160cc:	fcf43c23          	sd	a5,-40(s0)
   160d0:	fd843703          	ld	a4,-40(s0)
   160d4:	fc843783          	ld	a5,-56(s0)
   160d8:	f4f74fe3          	blt	a4,a5,16036 <xbrtime_barrier+0xae>
   160dc:	fc043c23          	sd	zero,-40(s0)
   160e0:	a825                	j	16118 <xbrtime_barrier+0x190>
   160e2:	fa043703          	ld	a4,-96(s0)
   160e6:	87ba                	mv	a5,a4
   160e8:	078a                	slli	a5,a5,0x2
   160ea:	97ba                	add	a5,a5,a4
   160ec:	0786                	slli	a5,a5,0x1
   160ee:	873e                	mv	a4,a5
   160f0:	fd843783          	ld	a5,-40(s0)
   160f4:	973e                	add	a4,a4,a5
   160f6:	07ffe7b7          	lui	a5,0x7ffe
   160fa:	0795                	addi	a5,a5,5
   160fc:	97ba                	add	a5,a5,a4
   160fe:	078e                	slli	a5,a5,0x3
   16100:	873e                	mv	a4,a5
   16102:	37ab77b7          	lui	a5,0x37ab7
   16106:	078a                	slli	a5,a5,0x2
   16108:	eef78793          	addi	a5,a5,-273 # 37ab6eef <__global_pointer$+0x37a9df97>
   1610c:	e31c                	sd	a5,0(a4)
   1610e:	fd843783          	ld	a5,-40(s0)
   16112:	0785                	addi	a5,a5,1
   16114:	fcf43c23          	sd	a5,-40(s0)
   16118:	fd843703          	ld	a4,-40(s0)
   1611c:	fc843783          	ld	a5,-56(s0)
   16120:	fcf741e3          	blt	a4,a5,160e2 <xbrtime_barrier+0x15a>
   16124:	fa043703          	ld	a4,-96(s0)
   16128:	3fff07b7          	lui	a5,0x3fff0
   1612c:	02078793          	addi	a5,a5,32 # 3fff0020 <__global_pointer$+0x3ffd70c8>
   16130:	4685                	li	a3,1
   16132:	40e68733          	sub	a4,a3,a4
   16136:	e398                	sd	a4,0(a5)
   16138:	a011                	j	1613c <xbrtime_barrier+0x1b4>
   1613a:	0001                	nop
   1613c:	60e6                	ld	ra,88(sp)
   1613e:	6446                	ld	s0,80(sp)
   16140:	2426                	fld	fs0,72(sp)
   16142:	6125                	addi	sp,sp,96
   16144:	8082                	ret
	...

0000000000016148 <xbrtime_init>:
   16148:	1101                	addi	sp,sp,-32
   1614a:	ec06                	sd	ra,24(sp)
   1614c:	e822                	sd	s0,16(sp)
   1614e:	1000                	addi	s0,sp,32
   16150:	fe042623          	sw	zero,-20(s0)
   16154:	5e3000ef          	jal	ra,16f36 <__xbrtime_asm_get_id>
   16158:	87aa                	mv	a5,a0
   1615a:	fef42423          	sw	a5,-24(s0)
   1615e:	5df000ef          	jal	ra,16f3c <__xbrtime_asm_get_npes>
   16162:	87aa                	mv	a5,a0
   16164:	fef42223          	sw	a5,-28(s0)
   16168:	3fff07b7          	lui	a5,0x3fff0
   1616c:	fe842703          	lw	a4,-24(s0)
   16170:	e398                	sd	a4,0(a5)
   16172:	3fff07b7          	lui	a5,0x3fff0
   16176:	07a1                	addi	a5,a5,8
   16178:	fe442703          	lw	a4,-28(s0)
   1617c:	e398                	sd	a4,0(a5)
   1617e:	3fff07b7          	lui	a5,0x3fff0
   16182:	07c1                	addi	a5,a5,16
   16184:	0007b023          	sd	zero,0(a5) # 3fff0000 <__global_pointer$+0x3ffd70a8>
   16188:	3fff07b7          	lui	a5,0x3fff0
   1618c:	07e1                	addi	a5,a5,24
   1618e:	0007b023          	sd	zero,0(a5) # 3fff0000 <__global_pointer$+0x3ffd70a8>
   16192:	3fff07b7          	lui	a5,0x3fff0
   16196:	02078793          	addi	a5,a5,32 # 3fff0020 <__global_pointer$+0x3ffd70c8>
   1619a:	4705                	li	a4,1
   1619c:	e398                	sd	a4,0(a5)
   1619e:	3fff07b7          	lui	a5,0x3fff0
   161a2:	07a1                	addi	a5,a5,8
   161a4:	639c                	ld	a5,0(a5)
   161a6:	873e                	mv	a4,a5
   161a8:	40000793          	li	a5,1024
   161ac:	00e7d463          	ble	a4,a5,161b4 <xbrtime_init+0x6c>
   161b0:	57fd                	li	a5,-1
   161b2:	a205                	j	162d2 <xbrtime_init+0x18a>
   161b4:	fe042623          	sw	zero,-20(s0)
   161b8:	a0b9                	j	16206 <xbrtime_init+0xbe>
   161ba:	fec42783          	lw	a5,-20(s0)
   161be:	0037979b          	slliw	a5,a5,0x3
   161c2:	2781                	sext.w	a5,a5
   161c4:	873e                	mv	a4,a5
   161c6:	3fff07b7          	lui	a5,0x3fff0
   161ca:	02878793          	addi	a5,a5,40 # 3fff0028 <__global_pointer$+0x3ffd70d0>
   161ce:	97ba                	add	a5,a5,a4
   161d0:	873e                	mv	a4,a5
   161d2:	57fd                	li	a5,-1
   161d4:	83f1                	srli	a5,a5,0x1c
   161d6:	e31c                	sd	a5,0(a4)
   161d8:	fec42783          	lw	a5,-20(s0)
   161dc:	27a9                	addiw	a5,a5,10
   161de:	2781                	sext.w	a5,a5
   161e0:	0037979b          	slliw	a5,a5,0x3
   161e4:	2781                	sext.w	a5,a5
   161e6:	873e                	mv	a4,a5
   161e8:	3fff07b7          	lui	a5,0x3fff0
   161ec:	02878793          	addi	a5,a5,40 # 3fff0028 <__global_pointer$+0x3ffd70d0>
   161f0:	97ba                	add	a5,a5,a4
   161f2:	873e                	mv	a4,a5
   161f4:	67e1                	lui	a5,0x18
   161f6:	9b87b783          	ld	a5,-1608(a5) # 179b8 <_exit+0xbc>
   161fa:	e31c                	sd	a5,0(a4)
   161fc:	fec42783          	lw	a5,-20(s0)
   16200:	2785                	addiw	a5,a5,1
   16202:	fef42623          	sw	a5,-20(s0)
   16206:	fec42783          	lw	a5,-20(s0)
   1620a:	0007871b          	sext.w	a4,a5
   1620e:	47a5                	li	a5,9
   16210:	fae7d5e3          	ble	a4,a5,161ba <xbrtime_init+0x72>
   16214:	fe042623          	sw	zero,-20(s0)
   16218:	a091                	j	1625c <xbrtime_init+0x114>
   1621a:	fec42783          	lw	a5,-20(s0)
   1621e:	0047979b          	slliw	a5,a5,0x4
   16222:	2781                	sext.w	a5,a5
   16224:	873e                	mv	a4,a5
   16226:	3fff07b7          	lui	a5,0x3fff0
   1622a:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1622e:	97ba                	add	a5,a5,a4
   16230:	0007b023          	sd	zero,0(a5)
   16234:	fec42783          	lw	a5,-20(s0)
   16238:	0047979b          	slliw	a5,a5,0x4
   1623c:	2781                	sext.w	a5,a5
   1623e:	27a1                	addiw	a5,a5,8
   16240:	2781                	sext.w	a5,a5
   16242:	873e                	mv	a4,a5
   16244:	3fff07b7          	lui	a5,0x3fff0
   16248:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1624c:	97ba                	add	a5,a5,a4
   1624e:	0007b023          	sd	zero,0(a5)
   16252:	fec42783          	lw	a5,-20(s0)
   16256:	2785                	addiw	a5,a5,1
   16258:	fef42623          	sw	a5,-20(s0)
   1625c:	fec42783          	lw	a5,-20(s0)
   16260:	0007871b          	sext.w	a4,a5
   16264:	7ff00793          	li	a5,2047
   16268:	fae7d9e3          	ble	a4,a5,1621a <xbrtime_init+0xd2>
   1626c:	fe042623          	sw	zero,-20(s0)
   16270:	a881                	j	162c0 <xbrtime_init+0x178>
   16272:	fec42783          	lw	a5,-20(s0)
   16276:	0047979b          	slliw	a5,a5,0x4
   1627a:	2781                	sext.w	a5,a5
   1627c:	873e                	mv	a4,a5
   1627e:	3fff87b7          	lui	a5,0x3fff8
   16282:	0c878793          	addi	a5,a5,200 # 3fff80c8 <__global_pointer$+0x3ffdf170>
   16286:	97ba                	add	a5,a5,a4
   16288:	873e                	mv	a4,a5
   1628a:	fec42783          	lw	a5,-20(s0)
   1628e:	e31c                	sd	a5,0(a4)
   16290:	fec42783          	lw	a5,-20(s0)
   16294:	2785                	addiw	a5,a5,1
   16296:	0007871b          	sext.w	a4,a5
   1629a:	fec42783          	lw	a5,-20(s0)
   1629e:	0047979b          	slliw	a5,a5,0x4
   162a2:	2781                	sext.w	a5,a5
   162a4:	27a1                	addiw	a5,a5,8
   162a6:	2781                	sext.w	a5,a5
   162a8:	86be                	mv	a3,a5
   162aa:	3fff87b7          	lui	a5,0x3fff8
   162ae:	0c878793          	addi	a5,a5,200 # 3fff80c8 <__global_pointer$+0x3ffdf170>
   162b2:	97b6                	add	a5,a5,a3
   162b4:	e398                	sd	a4,0(a5)
   162b6:	fec42783          	lw	a5,-20(s0)
   162ba:	2785                	addiw	a5,a5,1
   162bc:	fef42623          	sw	a5,-20(s0)
   162c0:	fec42703          	lw	a4,-20(s0)
   162c4:	fe442783          	lw	a5,-28(s0)
   162c8:	2701                	sext.w	a4,a4
   162ca:	2781                	sext.w	a5,a5
   162cc:	faf743e3          	blt	a4,a5,16272 <xbrtime_init+0x12a>
   162d0:	4781                	li	a5,0
   162d2:	853e                	mv	a0,a5
   162d4:	60e2                	ld	ra,24(sp)
   162d6:	6442                	ld	s0,16(sp)
   162d8:	6105                	addi	sp,sp,32
   162da:	8082                	ret

00000000000162dc <xbrtime_close>:
   162dc:	1101                	addi	sp,sp,-32
   162de:	ec06                	sd	ra,24(sp)
   162e0:	e822                	sd	s0,16(sp)
   162e2:	1000                	addi	s0,sp,32
   162e4:	fe042623          	sw	zero,-20(s0)
   162e8:	00000097          	auipc	ra,0x0
   162ec:	07c080e7          	jalr	124(ra) # 16364 <xbrtime_mype>
   162f0:	87aa                	mv	a5,a0
   162f2:	fef42423          	sw	a5,-24(s0)
   162f6:	00001097          	auipc	ra,0x1
   162fa:	c58080e7          	jalr	-936(ra) # 16f4e <__xbrtime_asm_fence>
   162fe:	fe042623          	sw	zero,-20(s0)
   16302:	a0a1                	j	1634a <xbrtime_close+0x6e>
   16304:	fec42783          	lw	a5,-20(s0)
   16308:	0047979b          	slliw	a5,a5,0x4
   1630c:	2781                	sext.w	a5,a5
   1630e:	27a1                	addiw	a5,a5,8
   16310:	2781                	sext.w	a5,a5
   16312:	873e                	mv	a4,a5
   16314:	3fff07b7          	lui	a5,0x3fff0
   16318:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   1631c:	97ba                	add	a5,a5,a4
   1631e:	639c                	ld	a5,0(a5)
   16320:	c385                	beqz	a5,16340 <xbrtime_close+0x64>
   16322:	fec42783          	lw	a5,-20(s0)
   16326:	0047979b          	slliw	a5,a5,0x4
   1632a:	2781                	sext.w	a5,a5
   1632c:	873e                	mv	a4,a5
   1632e:	3fff07b7          	lui	a5,0x3fff0
   16332:	0c878793          	addi	a5,a5,200 # 3fff00c8 <__global_pointer$+0x3ffd7170>
   16336:	97ba                	add	a5,a5,a4
   16338:	639c                	ld	a5,0(a5)
   1633a:	853e                	mv	a0,a5
   1633c:	cb0fa0ef          	jal	ra,107ec <xbrtime_free>
   16340:	fec42783          	lw	a5,-20(s0)
   16344:	2785                	addiw	a5,a5,1
   16346:	fef42623          	sw	a5,-20(s0)
   1634a:	fec42783          	lw	a5,-20(s0)
   1634e:	0007871b          	sext.w	a4,a5
   16352:	7ff00793          	li	a5,2047
   16356:	fae7d7e3          	ble	a4,a5,16304 <xbrtime_close+0x28>
   1635a:	0001                	nop
   1635c:	60e2                	ld	ra,24(sp)
   1635e:	6442                	ld	s0,16(sp)
   16360:	6105                	addi	sp,sp,32
   16362:	8082                	ret

0000000000016364 <xbrtime_mype>:
   16364:	1141                	addi	sp,sp,-16
   16366:	e422                	sd	s0,8(sp)
   16368:	0800                	addi	s0,sp,16
   1636a:	3fff07b7          	lui	a5,0x3fff0
   1636e:	639c                	ld	a5,0(a5)
   16370:	2781                	sext.w	a5,a5
   16372:	853e                	mv	a0,a5
   16374:	6422                	ld	s0,8(sp)
   16376:	0141                	addi	sp,sp,16
   16378:	8082                	ret

000000000001637a <xbrtime_num_pes>:
   1637a:	1141                	addi	sp,sp,-16
   1637c:	e422                	sd	s0,8(sp)
   1637e:	0800                	addi	s0,sp,16
   16380:	3fff07b7          	lui	a5,0x3fff0
   16384:	07a1                	addi	a5,a5,8
   16386:	639c                	ld	a5,0(a5)
   16388:	2781                	sext.w	a5,a5
   1638a:	853e                	mv	a0,a5
   1638c:	6422                	ld	s0,8(sp)
   1638e:	0141                	addi	sp,sp,16
   16390:	8082                	ret

0000000000016392 <xbrtime_decode_pe>:
   16392:	7179                	addi	sp,sp,-48
   16394:	f422                	sd	s0,40(sp)
   16396:	1800                	addi	s0,sp,48
   16398:	87aa                	mv	a5,a0
   1639a:	fcf42e23          	sw	a5,-36(s0)
   1639e:	fe042423          	sw	zero,-24(s0)
   163a2:	fe042623          	sw	zero,-20(s0)
   163a6:	3fff07b7          	lui	a5,0x3fff0
   163aa:	07a1                	addi	a5,a5,8
   163ac:	639c                	ld	a5,0(a5)
   163ae:	fef42223          	sw	a5,-28(s0)
   163b2:	fe042623          	sw	zero,-20(s0)
   163b6:	a889                	j	16408 <xbrtime_decode_pe+0x76>
   163b8:	fec42783          	lw	a5,-20(s0)
   163bc:	0047979b          	slliw	a5,a5,0x4
   163c0:	2781                	sext.w	a5,a5
   163c2:	873e                	mv	a4,a5
   163c4:	3fff87b7          	lui	a5,0x3fff8
   163c8:	0c878793          	addi	a5,a5,200 # 3fff80c8 <__global_pointer$+0x3ffdf170>
   163cc:	97ba                	add	a5,a5,a4
   163ce:	639c                	ld	a5,0(a5)
   163d0:	0007871b          	sext.w	a4,a5
   163d4:	fdc42783          	lw	a5,-36(s0)
   163d8:	2781                	sext.w	a5,a5
   163da:	02e79263          	bne	a5,a4,163fe <xbrtime_decode_pe+0x6c>
   163de:	fec42783          	lw	a5,-20(s0)
   163e2:	0047979b          	slliw	a5,a5,0x4
   163e6:	2781                	sext.w	a5,a5
   163e8:	27a1                	addiw	a5,a5,8
   163ea:	2781                	sext.w	a5,a5
   163ec:	873e                	mv	a4,a5
   163ee:	3fff87b7          	lui	a5,0x3fff8
   163f2:	0c878793          	addi	a5,a5,200 # 3fff80c8 <__global_pointer$+0x3ffdf170>
   163f6:	97ba                	add	a5,a5,a4
   163f8:	639c                	ld	a5,0(a5)
   163fa:	2781                	sext.w	a5,a5
   163fc:	a005                	j	1641c <xbrtime_decode_pe+0x8a>
   163fe:	fec42783          	lw	a5,-20(s0)
   16402:	2785                	addiw	a5,a5,1
   16404:	fef42623          	sw	a5,-20(s0)
   16408:	fec42703          	lw	a4,-20(s0)
   1640c:	fe442783          	lw	a5,-28(s0)
   16410:	2701                	sext.w	a4,a4
   16412:	2781                	sext.w	a5,a5
   16414:	faf742e3          	blt	a4,a5,163b8 <xbrtime_decode_pe+0x26>
   16418:	fe842783          	lw	a5,-24(s0)
   1641c:	853e                	mv	a0,a5
   1641e:	7422                	ld	s0,40(sp)
   16420:	6145                	addi	sp,sp,48
   16422:	8082                	ret

0000000000016424 <xbrtime_addr_accessible>:
   16424:	1101                	addi	sp,sp,-32
   16426:	ec22                	sd	s0,24(sp)
   16428:	1000                	addi	s0,sp,32
   1642a:	fea43423          	sd	a0,-24(s0)
   1642e:	87ae                	mv	a5,a1
   16430:	fef42223          	sw	a5,-28(s0)
   16434:	4785                	li	a5,1
   16436:	853e                	mv	a0,a5
   16438:	6462                	ld	s0,24(sp)
   1643a:	6105                	addi	sp,sp,32
   1643c:	8082                	ret

000000000001643e <reverse_str>:
   1643e:	7179                	addi	sp,sp,-48
   16440:	f422                	sd	s0,40(sp)
   16442:	1800                	addi	s0,sp,48
   16444:	fca43c23          	sd	a0,-40(s0)
   16448:	87ae                	mv	a5,a1
   1644a:	fcf42a23          	sw	a5,-44(s0)
   1644e:	fe042623          	sw	zero,-20(s0)
   16452:	fd442783          	lw	a5,-44(s0)
   16456:	37fd                	addiw	a5,a5,-1
   16458:	fef42423          	sw	a5,-24(s0)
   1645c:	a899                	j	164b2 <reverse_str+0x74>
   1645e:	fec42783          	lw	a5,-20(s0)
   16462:	fd843703          	ld	a4,-40(s0)
   16466:	97ba                	add	a5,a5,a4
   16468:	0007c783          	lbu	a5,0(a5)
   1646c:	fef403a3          	sb	a5,-25(s0)
   16470:	fe842783          	lw	a5,-24(s0)
   16474:	fd843703          	ld	a4,-40(s0)
   16478:	973e                	add	a4,a4,a5
   1647a:	fec42783          	lw	a5,-20(s0)
   1647e:	fd843683          	ld	a3,-40(s0)
   16482:	97b6                	add	a5,a5,a3
   16484:	00074703          	lbu	a4,0(a4)
   16488:	00e78023          	sb	a4,0(a5)
   1648c:	fe842783          	lw	a5,-24(s0)
   16490:	fd843703          	ld	a4,-40(s0)
   16494:	97ba                	add	a5,a5,a4
   16496:	fe744703          	lbu	a4,-25(s0)
   1649a:	00e78023          	sb	a4,0(a5)
   1649e:	fec42783          	lw	a5,-20(s0)
   164a2:	2785                	addiw	a5,a5,1
   164a4:	fef42623          	sw	a5,-20(s0)
   164a8:	fe842783          	lw	a5,-24(s0)
   164ac:	37fd                	addiw	a5,a5,-1
   164ae:	fef42423          	sw	a5,-24(s0)
   164b2:	fec42703          	lw	a4,-20(s0)
   164b6:	fe842783          	lw	a5,-24(s0)
   164ba:	2701                	sext.w	a4,a4
   164bc:	2781                	sext.w	a5,a5
   164be:	faf740e3          	blt	a4,a5,1645e <reverse_str+0x20>
   164c2:	0001                	nop
   164c4:	7422                	ld	s0,40(sp)
   164c6:	6145                	addi	sp,sp,48
   164c8:	8082                	ret

00000000000164ca <int_to_str>:
   164ca:	7179                	addi	sp,sp,-48
   164cc:	f406                	sd	ra,40(sp)
   164ce:	f022                	sd	s0,32(sp)
   164d0:	1800                	addi	s0,sp,48
   164d2:	87aa                	mv	a5,a0
   164d4:	fcb43823          	sd	a1,-48(s0)
   164d8:	fcf42e23          	sw	a5,-36(s0)
   164dc:	fdc42783          	lw	a5,-36(s0)
   164e0:	fef42623          	sw	a5,-20(s0)
   164e4:	fe042423          	sw	zero,-24(s0)
   164e8:	fec42783          	lw	a5,-20(s0)
   164ec:	2781                	sext.w	a5,a5
   164ee:	0207d663          	bgez	a5,1651a <int_to_str+0x50>
   164f2:	fe842783          	lw	a5,-24(s0)
   164f6:	0017871b          	addiw	a4,a5,1
   164fa:	fee42423          	sw	a4,-24(s0)
   164fe:	873e                	mv	a4,a5
   16500:	fd043783          	ld	a5,-48(s0)
   16504:	97ba                	add	a5,a5,a4
   16506:	02d00713          	li	a4,45
   1650a:	00e78023          	sb	a4,0(a5)
   1650e:	fec42783          	lw	a5,-20(s0)
   16512:	40f007bb          	negw	a5,a5
   16516:	fef42623          	sw	a5,-20(s0)
   1651a:	fec42703          	lw	a4,-20(s0)
   1651e:	47a9                	li	a5,10
   16520:	02f767bb          	remw	a5,a4,a5
   16524:	2781                	sext.w	a5,a5
   16526:	0ff7f713          	andi	a4,a5,255
   1652a:	fe842783          	lw	a5,-24(s0)
   1652e:	0017869b          	addiw	a3,a5,1
   16532:	fed42423          	sw	a3,-24(s0)
   16536:	86be                	mv	a3,a5
   16538:	fd043783          	ld	a5,-48(s0)
   1653c:	97b6                	add	a5,a5,a3
   1653e:	0307071b          	addiw	a4,a4,48
   16542:	0ff77713          	andi	a4,a4,255
   16546:	00e78023          	sb	a4,0(a5)
   1654a:	fec42703          	lw	a4,-20(s0)
   1654e:	47a9                	li	a5,10
   16550:	02f747bb          	divw	a5,a4,a5
   16554:	fef42623          	sw	a5,-20(s0)
   16558:	fec42783          	lw	a5,-20(s0)
   1655c:	2781                	sext.w	a5,a5
   1655e:	faf04ee3          	bgtz	a5,1651a <int_to_str+0x50>
   16562:	fd043783          	ld	a5,-48(s0)
   16566:	0007c783          	lbu	a5,0(a5)
   1656a:	873e                	mv	a4,a5
   1656c:	02d00793          	li	a5,45
   16570:	02f71163          	bne	a4,a5,16592 <int_to_str+0xc8>
   16574:	fd043783          	ld	a5,-48(s0)
   16578:	00178713          	addi	a4,a5,1
   1657c:	fe842783          	lw	a5,-24(s0)
   16580:	37fd                	addiw	a5,a5,-1
   16582:	2781                	sext.w	a5,a5
   16584:	85be                	mv	a1,a5
   16586:	853a                	mv	a0,a4
   16588:	00000097          	auipc	ra,0x0
   1658c:	eb6080e7          	jalr	-330(ra) # 1643e <reverse_str>
   16590:	a811                	j	165a4 <int_to_str+0xda>
   16592:	fe842783          	lw	a5,-24(s0)
   16596:	85be                	mv	a1,a5
   16598:	fd043503          	ld	a0,-48(s0)
   1659c:	00000097          	auipc	ra,0x0
   165a0:	ea2080e7          	jalr	-350(ra) # 1643e <reverse_str>
   165a4:	fe842783          	lw	a5,-24(s0)
   165a8:	853e                	mv	a0,a5
   165aa:	70a2                	ld	ra,40(sp)
   165ac:	7402                	ld	s0,32(sp)
   165ae:	6145                	addi	sp,sp,48
   165b0:	8082                	ret

00000000000165b2 <hex_to_str>:
   165b2:	7179                	addi	sp,sp,-48
   165b4:	f406                	sd	ra,40(sp)
   165b6:	f022                	sd	s0,32(sp)
   165b8:	1800                	addi	s0,sp,48
   165ba:	87aa                	mv	a5,a0
   165bc:	fcb43823          	sd	a1,-48(s0)
   165c0:	fcf42e23          	sw	a5,-36(s0)
   165c4:	fe042623          	sw	zero,-20(s0)
   165c8:	a059                	j	1664e <hex_to_str+0x9c>
   165ca:	fdc42703          	lw	a4,-36(s0)
   165ce:	41f7579b          	sraiw	a5,a4,0x1f
   165d2:	01c7d79b          	srliw	a5,a5,0x1c
   165d6:	9f3d                	addw	a4,a4,a5
   165d8:	8b3d                	andi	a4,a4,15
   165da:	40f707bb          	subw	a5,a4,a5
   165de:	fef42423          	sw	a5,-24(s0)
   165e2:	fe842783          	lw	a5,-24(s0)
   165e6:	0007871b          	sext.w	a4,a5
   165ea:	47a5                	li	a5,9
   165ec:	02e7c263          	blt	a5,a4,16610 <hex_to_str+0x5e>
   165f0:	fe842783          	lw	a5,-24(s0)
   165f4:	0ff7f713          	andi	a4,a5,255
   165f8:	fec42783          	lw	a5,-20(s0)
   165fc:	fd043683          	ld	a3,-48(s0)
   16600:	97b6                	add	a5,a5,a3
   16602:	0307071b          	addiw	a4,a4,48
   16606:	0ff77713          	andi	a4,a4,255
   1660a:	00e78023          	sb	a4,0(a5)
   1660e:	a005                	j	1662e <hex_to_str+0x7c>
   16610:	fe842783          	lw	a5,-24(s0)
   16614:	0ff7f713          	andi	a4,a5,255
   16618:	fec42783          	lw	a5,-20(s0)
   1661c:	fd043683          	ld	a3,-48(s0)
   16620:	97b6                	add	a5,a5,a3
   16622:	0377071b          	addiw	a4,a4,55
   16626:	0ff77713          	andi	a4,a4,255
   1662a:	00e78023          	sb	a4,0(a5)
   1662e:	fec42783          	lw	a5,-20(s0)
   16632:	2785                	addiw	a5,a5,1
   16634:	fef42623          	sw	a5,-20(s0)
   16638:	fdc42783          	lw	a5,-36(s0)
   1663c:	41f7d71b          	sraiw	a4,a5,0x1f
   16640:	01c7571b          	srliw	a4,a4,0x1c
   16644:	9fb9                	addw	a5,a5,a4
   16646:	4047d79b          	sraiw	a5,a5,0x4
   1664a:	fcf42e23          	sw	a5,-36(s0)
   1664e:	fdc42783          	lw	a5,-36(s0)
   16652:	2781                	sext.w	a5,a5
   16654:	fbbd                	bnez	a5,165ca <hex_to_str+0x18>
   16656:	fec42783          	lw	a5,-20(s0)
   1665a:	85be                	mv	a1,a5
   1665c:	fd043503          	ld	a0,-48(s0)
   16660:	ddfff0ef          	jal	ra,1643e <reverse_str>
   16664:	fec42783          	lw	a5,-20(s0)
   16668:	853e                	mv	a0,a5
   1666a:	70a2                	ld	ra,40(sp)
   1666c:	7402                	ld	s0,32(sp)
   1666e:	6145                	addi	sp,sp,48
   16670:	8082                	ret

0000000000016672 <float_to_str>:
   16672:	715d                	addi	sp,sp,-80
   16674:	e486                	sd	ra,72(sp)
   16676:	e0a2                	sd	s0,64(sp)
   16678:	0880                	addi	s0,sp,80
   1667a:	fca43427          	fsd	fa0,-56(s0)
   1667e:	87aa                	mv	a5,a0
   16680:	fab43c23          	sd	a1,-72(s0)
   16684:	fcf42223          	sw	a5,-60(s0)
   16688:	fc843787          	fld	fa5,-56(s0)
   1668c:	c20797d3          	fcvt.w.d	a5,fa5,rtz
   16690:	fef42623          	sw	a5,-20(s0)
   16694:	fe042423          	sw	zero,-24(s0)
   16698:	fec42783          	lw	a5,-20(s0)
   1669c:	d20787d3          	fcvt.d.w	fa5,a5
   166a0:	fc843707          	fld	fa4,-56(s0)
   166a4:	0af777d3          	fsub.d	fa5,fa4,fa5
   166a8:	fef43027          	fsd	fa5,-32(s0)
   166ac:	fc042e23          	sw	zero,-36(s0)
   166b0:	fec42783          	lw	a5,-20(s0)
   166b4:	2781                	sext.w	a5,a5
   166b6:	e385                	bnez	a5,166d6 <float_to_str+0x64>
   166b8:	fdc42783          	lw	a5,-36(s0)
   166bc:	0017871b          	addiw	a4,a5,1
   166c0:	fce42e23          	sw	a4,-36(s0)
   166c4:	873e                	mv	a4,a5
   166c6:	fb843783          	ld	a5,-72(s0)
   166ca:	97ba                	add	a5,a5,a4
   166cc:	03000713          	li	a4,48
   166d0:	00e78023          	sb	a4,0(a5)
   166d4:	a87d                	j	16792 <float_to_str+0x120>
   166d6:	fec42783          	lw	a5,-20(s0)
   166da:	2781                	sext.w	a5,a5
   166dc:	0207d663          	bgez	a5,16708 <float_to_str+0x96>
   166e0:	fdc42783          	lw	a5,-36(s0)
   166e4:	0017871b          	addiw	a4,a5,1
   166e8:	fce42e23          	sw	a4,-36(s0)
   166ec:	873e                	mv	a4,a5
   166ee:	fb843783          	ld	a5,-72(s0)
   166f2:	97ba                	add	a5,a5,a4
   166f4:	02d00713          	li	a4,45
   166f8:	00e78023          	sb	a4,0(a5)
   166fc:	fec42783          	lw	a5,-20(s0)
   16700:	40f007bb          	negw	a5,a5
   16704:	fef42623          	sw	a5,-20(s0)
   16708:	fec42703          	lw	a4,-20(s0)
   1670c:	47a9                	li	a5,10
   1670e:	02f767bb          	remw	a5,a4,a5
   16712:	2781                	sext.w	a5,a5
   16714:	0ff7f713          	andi	a4,a5,255
   16718:	fdc42783          	lw	a5,-36(s0)
   1671c:	0017869b          	addiw	a3,a5,1
   16720:	fcd42e23          	sw	a3,-36(s0)
   16724:	86be                	mv	a3,a5
   16726:	fb843783          	ld	a5,-72(s0)
   1672a:	97b6                	add	a5,a5,a3
   1672c:	0307071b          	addiw	a4,a4,48
   16730:	0ff77713          	andi	a4,a4,255
   16734:	00e78023          	sb	a4,0(a5)
   16738:	fec42703          	lw	a4,-20(s0)
   1673c:	47a9                	li	a5,10
   1673e:	02f747bb          	divw	a5,a4,a5
   16742:	fef42623          	sw	a5,-20(s0)
   16746:	fec42783          	lw	a5,-20(s0)
   1674a:	2781                	sext.w	a5,a5
   1674c:	faf04ee3          	bgtz	a5,16708 <float_to_str+0x96>
   16750:	fb843783          	ld	a5,-72(s0)
   16754:	0007c783          	lbu	a5,0(a5)
   16758:	873e                	mv	a4,a5
   1675a:	02d00793          	li	a5,45
   1675e:	02f71163          	bne	a4,a5,16780 <float_to_str+0x10e>
   16762:	fb843783          	ld	a5,-72(s0)
   16766:	00178713          	addi	a4,a5,1
   1676a:	fdc42783          	lw	a5,-36(s0)
   1676e:	37fd                	addiw	a5,a5,-1
   16770:	2781                	sext.w	a5,a5
   16772:	85be                	mv	a1,a5
   16774:	853a                	mv	a0,a4
   16776:	00000097          	auipc	ra,0x0
   1677a:	cc8080e7          	jalr	-824(ra) # 1643e <reverse_str>
   1677e:	a811                	j	16792 <float_to_str+0x120>
   16780:	fdc42783          	lw	a5,-36(s0)
   16784:	85be                	mv	a1,a5
   16786:	fb843503          	ld	a0,-72(s0)
   1678a:	00000097          	auipc	ra,0x0
   1678e:	cb4080e7          	jalr	-844(ra) # 1643e <reverse_str>
   16792:	fe043787          	fld	fa5,-32(s0)
   16796:	f2000753          	fmv.d.x	fa4,zero
   1679a:	a2e7a7d3          	feq.d	a5,fa5,fa4
   1679e:	e7dd                	bnez	a5,1684c <float_to_str+0x1da>
   167a0:	fdc42783          	lw	a5,-36(s0)
   167a4:	0017871b          	addiw	a4,a5,1
   167a8:	fce42e23          	sw	a4,-36(s0)
   167ac:	873e                	mv	a4,a5
   167ae:	fb843783          	ld	a5,-72(s0)
   167b2:	97ba                	add	a5,a5,a4
   167b4:	02e00713          	li	a4,46
   167b8:	00e78023          	sb	a4,0(a5)
   167bc:	fe043707          	fld	fa4,-32(s0)
   167c0:	67e1                	lui	a5,0x18
   167c2:	a187b787          	fld	fa5,-1512(a5) # 17a18 <_exit+0x11c>
   167c6:	12f777d3          	fmul.d	fa5,fa4,fa5
   167ca:	fef43027          	fsd	fa5,-32(s0)
   167ce:	fe043787          	fld	fa5,-32(s0)
   167d2:	c20797d3          	fcvt.w.d	a5,fa5,rtz
   167d6:	fcf42c23          	sw	a5,-40(s0)
   167da:	fd842783          	lw	a5,-40(s0)
   167de:	0ff7f713          	andi	a4,a5,255
   167e2:	fdc42783          	lw	a5,-36(s0)
   167e6:	0017869b          	addiw	a3,a5,1
   167ea:	fcd42e23          	sw	a3,-36(s0)
   167ee:	86be                	mv	a3,a5
   167f0:	fb843783          	ld	a5,-72(s0)
   167f4:	97b6                	add	a5,a5,a3
   167f6:	0307071b          	addiw	a4,a4,48
   167fa:	0ff77713          	andi	a4,a4,255
   167fe:	00e78023          	sb	a4,0(a5)
   16802:	fd842783          	lw	a5,-40(s0)
   16806:	d20787d3          	fcvt.d.w	fa5,a5
   1680a:	fe043707          	fld	fa4,-32(s0)
   1680e:	0af777d3          	fsub.d	fa5,fa4,fa5
   16812:	fef43027          	fsd	fa5,-32(s0)
   16816:	fe842783          	lw	a5,-24(s0)
   1681a:	2785                	addiw	a5,a5,1
   1681c:	fef42423          	sw	a5,-24(s0)
   16820:	fe043787          	fld	fa5,-32(s0)
   16824:	f2000753          	fmv.d.x	fa4,zero
   16828:	a2e7a7d3          	feq.d	a5,fa5,fa4
   1682c:	e385                	bnez	a5,1684c <float_to_str+0x1da>
   1682e:	fe842703          	lw	a4,-24(s0)
   16832:	fc442783          	lw	a5,-60(s0)
   16836:	2701                	sext.w	a4,a4
   16838:	2781                	sext.w	a5,a5
   1683a:	00f75963          	ble	a5,a4,1684c <float_to_str+0x1da>
   1683e:	fdc42783          	lw	a5,-36(s0)
   16842:	0007871b          	sext.w	a4,a5
   16846:	47cd                	li	a5,19
   16848:	f6e7dae3          	ble	a4,a5,167bc <float_to_str+0x14a>
   1684c:	fdc42783          	lw	a5,-36(s0)
   16850:	853e                	mv	a0,a5
   16852:	60a6                	ld	ra,72(sp)
   16854:	6406                	ld	s0,64(sp)
   16856:	6161                	addi	sp,sp,80
   16858:	8082                	ret

000000000001685a <revvsnprintf>:
   1685a:	7155                	addi	sp,sp,-208
   1685c:	e586                	sd	ra,200(sp)
   1685e:	e1a2                	sd	s0,192(sp)
   16860:	0980                	addi	s0,sp,208
   16862:	f4a43423          	sd	a0,-184(s0)
   16866:	f4b43023          	sd	a1,-192(s0)
   1686a:	f2c43c23          	sd	a2,-200(s0)
   1686e:	f2d43823          	sd	a3,-208(s0)
   16872:	fe042423          	sw	zero,-24(s0)
   16876:	4789                	li	a5,2
   16878:	fef42223          	sw	a5,-28(s0)
   1687c:	f4843783          	ld	a5,-184(s0)
   16880:	fcf43c23          	sd	a5,-40(s0)
   16884:	fe042623          	sw	zero,-20(s0)
   16888:	ae95                	j	16bfc <revvsnprintf+0x3a2>
   1688a:	fec42783          	lw	a5,-20(s0)
   1688e:	f3843703          	ld	a4,-200(s0)
   16892:	97ba                	add	a5,a5,a4
   16894:	0007c783          	lbu	a5,0(a5)
   16898:	873e                	mv	a4,a5
   1689a:	02500793          	li	a5,37
   1689e:	02f70763          	beq	a4,a5,168cc <revvsnprintf+0x72>
   168a2:	fec42783          	lw	a5,-20(s0)
   168a6:	f3843703          	ld	a4,-200(s0)
   168aa:	973e                	add	a4,a4,a5
   168ac:	fd843783          	ld	a5,-40(s0)
   168b0:	00178693          	addi	a3,a5,1
   168b4:	fcd43c23          	sd	a3,-40(s0)
   168b8:	00074703          	lbu	a4,0(a4)
   168bc:	00e78023          	sb	a4,0(a5)
   168c0:	fe842783          	lw	a5,-24(s0)
   168c4:	2785                	addiw	a5,a5,1
   168c6:	fef42423          	sw	a5,-24(s0)
   168ca:	a625                	j	16bf2 <revvsnprintf+0x398>
   168cc:	fec42783          	lw	a5,-20(s0)
   168d0:	2785                	addiw	a5,a5,1
   168d2:	fef42623          	sw	a5,-20(s0)
   168d6:	fec42783          	lw	a5,-20(s0)
   168da:	f3843703          	ld	a4,-200(s0)
   168de:	97ba                	add	a5,a5,a4
   168e0:	0007c783          	lbu	a5,0(a5)
   168e4:	873e                	mv	a4,a5
   168e6:	02e00793          	li	a5,46
   168ea:	06f71f63          	bne	a4,a5,16968 <revvsnprintf+0x10e>
   168ee:	fe042223          	sw	zero,-28(s0)
   168f2:	fec42783          	lw	a5,-20(s0)
   168f6:	2785                	addiw	a5,a5,1
   168f8:	fef42623          	sw	a5,-20(s0)
   168fc:	a835                	j	16938 <revvsnprintf+0xde>
   168fe:	fe442703          	lw	a4,-28(s0)
   16902:	87ba                	mv	a5,a4
   16904:	0027979b          	slliw	a5,a5,0x2
   16908:	9fb9                	addw	a5,a5,a4
   1690a:	0017979b          	slliw	a5,a5,0x1
   1690e:	0007871b          	sext.w	a4,a5
   16912:	fec42783          	lw	a5,-20(s0)
   16916:	f3843683          	ld	a3,-200(s0)
   1691a:	97b6                	add	a5,a5,a3
   1691c:	0007c783          	lbu	a5,0(a5)
   16920:	2781                	sext.w	a5,a5
   16922:	9fb9                	addw	a5,a5,a4
   16924:	2781                	sext.w	a5,a5
   16926:	fd07879b          	addiw	a5,a5,-48
   1692a:	fef42223          	sw	a5,-28(s0)
   1692e:	fec42783          	lw	a5,-20(s0)
   16932:	2785                	addiw	a5,a5,1
   16934:	fef42623          	sw	a5,-20(s0)
   16938:	fec42783          	lw	a5,-20(s0)
   1693c:	f3843703          	ld	a4,-200(s0)
   16940:	97ba                	add	a5,a5,a4
   16942:	0007c783          	lbu	a5,0(a5)
   16946:	873e                	mv	a4,a5
   16948:	02f00793          	li	a5,47
   1694c:	00e7fe63          	bleu	a4,a5,16968 <revvsnprintf+0x10e>
   16950:	fec42783          	lw	a5,-20(s0)
   16954:	f3843703          	ld	a4,-200(s0)
   16958:	97ba                	add	a5,a5,a4
   1695a:	0007c783          	lbu	a5,0(a5)
   1695e:	873e                	mv	a4,a5
   16960:	03900793          	li	a5,57
   16964:	f8e7fde3          	bleu	a4,a5,168fe <revvsnprintf+0xa4>
   16968:	fec42783          	lw	a5,-20(s0)
   1696c:	f3843703          	ld	a4,-200(s0)
   16970:	97ba                	add	a5,a5,a4
   16972:	0007c783          	lbu	a5,0(a5)
   16976:	2781                	sext.w	a5,a5
   16978:	f9d7869b          	addiw	a3,a5,-99
   1697c:	0006871b          	sext.w	a4,a3
   16980:	47d5                	li	a5,21
   16982:	22e7ec63          	bltu	a5,a4,16bba <revvsnprintf+0x360>
   16986:	02069793          	slli	a5,a3,0x20
   1698a:	9381                	srli	a5,a5,0x20
   1698c:	00279713          	slli	a4,a5,0x2
   16990:	67e1                	lui	a5,0x18
   16992:	9c078793          	addi	a5,a5,-1600 # 179c0 <_exit+0xc4>
   16996:	97ba                	add	a5,a5,a4
   16998:	439c                	lw	a5,0(a5)
   1699a:	8782                	jr	a5
   1699c:	f3043783          	ld	a5,-208(s0)
   169a0:	00878713          	addi	a4,a5,8
   169a4:	f2e43823          	sd	a4,-208(s0)
   169a8:	639c                	ld	a5,0(a5)
   169aa:	fcf43823          	sd	a5,-48(s0)
   169ae:	a035                	j	169da <revvsnprintf+0x180>
   169b0:	fd043703          	ld	a4,-48(s0)
   169b4:	00170793          	addi	a5,a4,1
   169b8:	fcf43823          	sd	a5,-48(s0)
   169bc:	fd843783          	ld	a5,-40(s0)
   169c0:	00178693          	addi	a3,a5,1
   169c4:	fcd43c23          	sd	a3,-40(s0)
   169c8:	00074703          	lbu	a4,0(a4)
   169cc:	00e78023          	sb	a4,0(a5)
   169d0:	fe842783          	lw	a5,-24(s0)
   169d4:	2785                	addiw	a5,a5,1
   169d6:	fef42423          	sw	a5,-24(s0)
   169da:	fd043783          	ld	a5,-48(s0)
   169de:	0007c783          	lbu	a5,0(a5)
   169e2:	20078163          	beqz	a5,16be4 <revvsnprintf+0x38a>
   169e6:	fe842703          	lw	a4,-24(s0)
   169ea:	f4043783          	ld	a5,-192(s0)
   169ee:	17fd                	addi	a5,a5,-1
   169f0:	fcf760e3          	bltu	a4,a5,169b0 <revvsnprintf+0x156>
   169f4:	aac5                	j	16be4 <revvsnprintf+0x38a>
   169f6:	f3043783          	ld	a5,-208(s0)
   169fa:	00878713          	addi	a4,a5,8
   169fe:	f2e43823          	sd	a4,-208(s0)
   16a02:	439c                	lw	a5,0(a5)
   16a04:	faf42423          	sw	a5,-88(s0)
   16a08:	f8840713          	addi	a4,s0,-120
   16a0c:	fa842783          	lw	a5,-88(s0)
   16a10:	85ba                	mv	a1,a4
   16a12:	853e                	mv	a0,a5
   16a14:	00000097          	auipc	ra,0x0
   16a18:	ab6080e7          	jalr	-1354(ra) # 164ca <int_to_str>
   16a1c:	87aa                	mv	a5,a0
   16a1e:	faf42223          	sw	a5,-92(s0)
   16a22:	fc042623          	sw	zero,-52(s0)
   16a26:	a815                	j	16a5a <revvsnprintf+0x200>
   16a28:	fd843783          	ld	a5,-40(s0)
   16a2c:	00178713          	addi	a4,a5,1
   16a30:	fce43c23          	sd	a4,-40(s0)
   16a34:	fcc42703          	lw	a4,-52(s0)
   16a38:	ff040693          	addi	a3,s0,-16
   16a3c:	9736                	add	a4,a4,a3
   16a3e:	f9874703          	lbu	a4,-104(a4)
   16a42:	00e78023          	sb	a4,0(a5)
   16a46:	fe842783          	lw	a5,-24(s0)
   16a4a:	2785                	addiw	a5,a5,1
   16a4c:	fef42423          	sw	a5,-24(s0)
   16a50:	fcc42783          	lw	a5,-52(s0)
   16a54:	2785                	addiw	a5,a5,1
   16a56:	fcf42623          	sw	a5,-52(s0)
   16a5a:	fcc42703          	lw	a4,-52(s0)
   16a5e:	fa442783          	lw	a5,-92(s0)
   16a62:	2701                	sext.w	a4,a4
   16a64:	2781                	sext.w	a5,a5
   16a66:	18f75163          	ble	a5,a4,16be8 <revvsnprintf+0x38e>
   16a6a:	fe842703          	lw	a4,-24(s0)
   16a6e:	f4043783          	ld	a5,-192(s0)
   16a72:	17fd                	addi	a5,a5,-1
   16a74:	faf76ae3          	bltu	a4,a5,16a28 <revvsnprintf+0x1ce>
   16a78:	0001                	nop
   16a7a:	a2bd                	j	16be8 <revvsnprintf+0x38e>
   16a7c:	f3043783          	ld	a5,-208(s0)
   16a80:	00878713          	addi	a4,a5,8
   16a84:	f2e43823          	sd	a4,-208(s0)
   16a88:	439c                	lw	a5,0(a5)
   16a8a:	fcf42023          	sw	a5,-64(s0)
   16a8e:	f7040713          	addi	a4,s0,-144
   16a92:	fc042783          	lw	a5,-64(s0)
   16a96:	85ba                	mv	a1,a4
   16a98:	853e                	mv	a0,a5
   16a9a:	b19ff0ef          	jal	ra,165b2 <hex_to_str>
   16a9e:	87aa                	mv	a5,a0
   16aa0:	faf42e23          	sw	a5,-68(s0)
   16aa4:	fc042423          	sw	zero,-56(s0)
   16aa8:	a815                	j	16adc <revvsnprintf+0x282>
   16aaa:	fd843783          	ld	a5,-40(s0)
   16aae:	00178713          	addi	a4,a5,1
   16ab2:	fce43c23          	sd	a4,-40(s0)
   16ab6:	fc842703          	lw	a4,-56(s0)
   16aba:	ff040693          	addi	a3,s0,-16
   16abe:	9736                	add	a4,a4,a3
   16ac0:	f8074703          	lbu	a4,-128(a4)
   16ac4:	00e78023          	sb	a4,0(a5)
   16ac8:	fe842783          	lw	a5,-24(s0)
   16acc:	2785                	addiw	a5,a5,1
   16ace:	fef42423          	sw	a5,-24(s0)
   16ad2:	fc842783          	lw	a5,-56(s0)
   16ad6:	2785                	addiw	a5,a5,1
   16ad8:	fcf42423          	sw	a5,-56(s0)
   16adc:	fc842703          	lw	a4,-56(s0)
   16ae0:	fbc42783          	lw	a5,-68(s0)
   16ae4:	2701                	sext.w	a4,a4
   16ae6:	2781                	sext.w	a5,a5
   16ae8:	10f75263          	ble	a5,a4,16bec <revvsnprintf+0x392>
   16aec:	fe842703          	lw	a4,-24(s0)
   16af0:	f4043783          	ld	a5,-192(s0)
   16af4:	17fd                	addi	a5,a5,-1
   16af6:	faf76ae3          	bltu	a4,a5,16aaa <revvsnprintf+0x250>
   16afa:	0001                	nop
   16afc:	a8c5                	j	16bec <revvsnprintf+0x392>
   16afe:	f3043783          	ld	a5,-208(s0)
   16b02:	00878713          	addi	a4,a5,8
   16b06:	f2e43823          	sd	a4,-208(s0)
   16b0a:	239c                	fld	fa5,0(a5)
   16b0c:	faf43827          	fsd	fa5,-80(s0)
   16b10:	f5840713          	addi	a4,s0,-168
   16b14:	fe442783          	lw	a5,-28(s0)
   16b18:	85ba                	mv	a1,a4
   16b1a:	853e                	mv	a0,a5
   16b1c:	fb043507          	fld	fa0,-80(s0)
   16b20:	00000097          	auipc	ra,0x0
   16b24:	b52080e7          	jalr	-1198(ra) # 16672 <float_to_str>
   16b28:	87aa                	mv	a5,a0
   16b2a:	faf42623          	sw	a5,-84(s0)
   16b2e:	fc042223          	sw	zero,-60(s0)
   16b32:	a815                	j	16b66 <revvsnprintf+0x30c>
   16b34:	fd843783          	ld	a5,-40(s0)
   16b38:	00178713          	addi	a4,a5,1
   16b3c:	fce43c23          	sd	a4,-40(s0)
   16b40:	fc442703          	lw	a4,-60(s0)
   16b44:	ff040693          	addi	a3,s0,-16
   16b48:	9736                	add	a4,a4,a3
   16b4a:	f6874703          	lbu	a4,-152(a4)
   16b4e:	00e78023          	sb	a4,0(a5)
   16b52:	fe842783          	lw	a5,-24(s0)
   16b56:	2785                	addiw	a5,a5,1
   16b58:	fef42423          	sw	a5,-24(s0)
   16b5c:	fc442783          	lw	a5,-60(s0)
   16b60:	2785                	addiw	a5,a5,1
   16b62:	fcf42223          	sw	a5,-60(s0)
   16b66:	fc442703          	lw	a4,-60(s0)
   16b6a:	fac42783          	lw	a5,-84(s0)
   16b6e:	2701                	sext.w	a4,a4
   16b70:	2781                	sext.w	a5,a5
   16b72:	06f75f63          	ble	a5,a4,16bf0 <revvsnprintf+0x396>
   16b76:	fe842703          	lw	a4,-24(s0)
   16b7a:	f4043783          	ld	a5,-192(s0)
   16b7e:	17fd                	addi	a5,a5,-1
   16b80:	faf76ae3          	bltu	a4,a5,16b34 <revvsnprintf+0x2da>
   16b84:	0001                	nop
   16b86:	a0ad                	j	16bf0 <revvsnprintf+0x396>
   16b88:	f3043783          	ld	a5,-208(s0)
   16b8c:	00878713          	addi	a4,a5,8
   16b90:	f2e43823          	sd	a4,-208(s0)
   16b94:	439c                	lw	a5,0(a5)
   16b96:	faf401a3          	sb	a5,-93(s0)
   16b9a:	fd843783          	ld	a5,-40(s0)
   16b9e:	00178713          	addi	a4,a5,1
   16ba2:	fce43c23          	sd	a4,-40(s0)
   16ba6:	fa344703          	lbu	a4,-93(s0)
   16baa:	00e78023          	sb	a4,0(a5)
   16bae:	fe842783          	lw	a5,-24(s0)
   16bb2:	2785                	addiw	a5,a5,1
   16bb4:	fef42423          	sw	a5,-24(s0)
   16bb8:	a82d                	j	16bf2 <revvsnprintf+0x398>
   16bba:	fec42783          	lw	a5,-20(s0)
   16bbe:	f3843703          	ld	a4,-200(s0)
   16bc2:	973e                	add	a4,a4,a5
   16bc4:	fd843783          	ld	a5,-40(s0)
   16bc8:	00178693          	addi	a3,a5,1
   16bcc:	fcd43c23          	sd	a3,-40(s0)
   16bd0:	00074703          	lbu	a4,0(a4)
   16bd4:	00e78023          	sb	a4,0(a5)
   16bd8:	fe842783          	lw	a5,-24(s0)
   16bdc:	2785                	addiw	a5,a5,1
   16bde:	fef42423          	sw	a5,-24(s0)
   16be2:	a801                	j	16bf2 <revvsnprintf+0x398>
   16be4:	0001                	nop
   16be6:	a031                	j	16bf2 <revvsnprintf+0x398>
   16be8:	0001                	nop
   16bea:	a021                	j	16bf2 <revvsnprintf+0x398>
   16bec:	0001                	nop
   16bee:	a011                	j	16bf2 <revvsnprintf+0x398>
   16bf0:	0001                	nop
   16bf2:	fec42783          	lw	a5,-20(s0)
   16bf6:	2785                	addiw	a5,a5,1
   16bf8:	fef42623          	sw	a5,-20(s0)
   16bfc:	fec42783          	lw	a5,-20(s0)
   16c00:	f3843703          	ld	a4,-200(s0)
   16c04:	97ba                	add	a5,a5,a4
   16c06:	0007c783          	lbu	a5,0(a5)
   16c0a:	cb81                	beqz	a5,16c1a <revvsnprintf+0x3c0>
   16c0c:	fe842703          	lw	a4,-24(s0)
   16c10:	f4043783          	ld	a5,-192(s0)
   16c14:	17fd                	addi	a5,a5,-1
   16c16:	c6f76ae3          	bltu	a4,a5,1688a <revvsnprintf+0x30>
   16c1a:	fd843783          	ld	a5,-40(s0)
   16c1e:	00078023          	sb	zero,0(a5)
   16c22:	fe842783          	lw	a5,-24(s0)
   16c26:	853e                	mv	a0,a5
   16c28:	60ae                	ld	ra,200(sp)
   16c2a:	640e                	ld	s0,192(sp)
   16c2c:	6169                	addi	sp,sp,208
   16c2e:	8082                	ret

0000000000016c30 <revprintf>:
   16c30:	7159                	addi	sp,sp,-112
   16c32:	f406                	sd	ra,40(sp)
   16c34:	f022                	sd	s0,32(sp)
   16c36:	1800                	addi	s0,sp,48
   16c38:	fca43c23          	sd	a0,-40(s0)
   16c3c:	e40c                	sd	a1,8(s0)
   16c3e:	e810                	sd	a2,16(s0)
   16c40:	ec14                	sd	a3,24(s0)
   16c42:	f018                	sd	a4,32(s0)
   16c44:	f41c                	sd	a5,40(s0)
   16c46:	03043823          	sd	a6,48(s0)
   16c4a:	03143c23          	sd	a7,56(s0)
   16c4e:	04040793          	addi	a5,s0,64
   16c52:	fc878793          	addi	a5,a5,-56
   16c56:	fef43023          	sd	a5,-32(s0)
   16c5a:	fe043783          	ld	a5,-32(s0)
   16c5e:	86be                	mv	a3,a5
   16c60:	fd843603          	ld	a2,-40(s0)
   16c64:	6585                	lui	a1,0x1
   16c66:	3fffc7b7          	lui	a5,0x3fffc
   16c6a:	0c878513          	addi	a0,a5,200 # 3fffc0c8 <__global_pointer$+0x3ffe3170>
   16c6e:	00000097          	auipc	ra,0x0
   16c72:	bec080e7          	jalr	-1044(ra) # 1685a <revvsnprintf>
   16c76:	87aa                	mv	a5,a0
   16c78:	fef42623          	sw	a5,-20(s0)
   16c7c:	3fffd7b7          	lui	a5,0x3fffd
   16c80:	0d078793          	addi	a5,a5,208 # 3fffd0d0 <__global_pointer$+0x3ffe4178>
   16c84:	fec42703          	lw	a4,-20(s0)
   16c88:	e398                	sd	a4,0(a5)
   16c8a:	0001                	nop
   16c8c:	70a2                	ld	ra,40(sp)
   16c8e:	7402                	ld	s0,32(sp)
   16c90:	6165                	addi	sp,sp,112
   16c92:	8082                	ret

0000000000016c94 <__xbrtime_get_u1_seq>:
   16c94:	0006757b          	eaddie	e10,a2,0
   16c98:	00000f93          	li	t6,0

0000000000016c9c <.get_u1_seq>:
   16c9c:	00054f77          	elbu	t5,0(a0)
   16ca0:	953a                	add	a0,a0,a4
   16ca2:	0f85                	addi	t6,t6,1
   16ca4:	01e58023          	sb	t5,0(a1) # 1000 <_start-0xf0b0>
   16ca8:	95ba                	add	a1,a1,a4
   16caa:	fedf99e3          	bne	t6,a3,16c9c <.get_u1_seq>
   16cae:	8082                	ret

0000000000016cb0 <__xbrtime_get_u1_agg>:
   16cb0:	0006757b          	eaddie	e10,a2,0
   16cb4:	46e695b3          	eag	a1,a3,a4
   16cb8:	000545f7          	elbu	a1,0(a0)
   16cbc:	8082                	ret

0000000000016cbe <__xbrtime_get_u2_seq>:
   16cbe:	0006757b          	eaddie	e10,a2,0
   16cc2:	00000f93          	li	t6,0

0000000000016cc6 <.get_u2_seq>:
   16cc6:	00055f77          	elhu	t5,0(a0)
   16cca:	953a                	add	a0,a0,a4
   16ccc:	0f85                	addi	t6,t6,1
   16cce:	01e59023          	sh	t5,0(a1)
   16cd2:	95ba                	add	a1,a1,a4
   16cd4:	fedf99e3          	bne	t6,a3,16cc6 <.get_u2_seq>
   16cd8:	8082                	ret

0000000000016cda <__xbrtime_get_u2_agg>:
   16cda:	0006757b          	eaddie	e10,a2,0
   16cde:	46e695b3          	eag	a1,a3,a4
   16ce2:	000555f7          	elhu	a1,0(a0)
   16ce6:	8082                	ret

0000000000016ce8 <__xbrtime_get_u4_seq>:
   16ce8:	0006757b          	eaddie	e10,a2,0
   16cec:	00000f93          	li	t6,0

0000000000016cf0 <.get_u4_seq>:
   16cf0:	00052f77          	elw	t5,0(a0)
   16cf4:	953a                	add	a0,a0,a4
   16cf6:	0f85                	addi	t6,t6,1
   16cf8:	01e5a023          	sw	t5,0(a1)
   16cfc:	95ba                	add	a1,a1,a4
   16cfe:	fedf99e3          	bne	t6,a3,16cf0 <.get_u4_seq>
   16d02:	8082                	ret

0000000000016d04 <__xbrtime_get_u4_agg>:
   16d04:	0006757b          	eaddie	e10,a2,0
   16d08:	46e695b3          	eag	a1,a3,a4
   16d0c:	000525f7          	elw	a1,0(a0)
   16d10:	8082                	ret

0000000000016d12 <__xbrtime_get_u8_seq>:
   16d12:	0006757b          	eaddie	e10,a2,0
   16d16:	00000f93          	li	t6,0

0000000000016d1a <.get_u8_seq>:
   16d1a:	00053f77          	eld	t5,0(a0)
   16d1e:	953a                	add	a0,a0,a4
   16d20:	0f85                	addi	t6,t6,1
   16d22:	01e5b023          	sd	t5,0(a1)
   16d26:	95ba                	add	a1,a1,a4
   16d28:	fedf99e3          	bne	t6,a3,16d1a <.get_u8_seq>
   16d2c:	8082                	ret

0000000000016d2e <__xbrtime_get_u8_agg>:
   16d2e:	0006757b          	eaddie	e10,a2,0
   16d32:	46e695b3          	eag	a1,a3,a4
   16d36:	000535f7          	eld	a1,0(a0)
   16d3a:	8082                	ret

0000000000016d3c <__xbrtime_get_s1_seq>:
   16d3c:	0006757b          	eaddie	e10,a2,0
   16d40:	00000f93          	li	t6,0

0000000000016d44 <.get_s1_seq>:
   16d44:	00050f77          	elb	t5,0(a0)
   16d48:	953a                	add	a0,a0,a4
   16d4a:	0f85                	addi	t6,t6,1
   16d4c:	01e58023          	sb	t5,0(a1)
   16d50:	95ba                	add	a1,a1,a4
   16d52:	fedf99e3          	bne	t6,a3,16d44 <.get_s1_seq>
   16d56:	8082                	ret

0000000000016d58 <__xbrtime_get_s1_agg>:
   16d58:	0006757b          	eaddie	e10,a2,0
   16d5c:	46e695b3          	eag	a1,a3,a4
   16d60:	000505f7          	elb	a1,0(a0)
   16d64:	8082                	ret

0000000000016d66 <__xbrtime_get_s2_seq>:
   16d66:	0006757b          	eaddie	e10,a2,0
   16d6a:	00000f93          	li	t6,0

0000000000016d6e <.get_s2_seq>:
   16d6e:	00051f77          	elh	t5,0(a0)
   16d72:	953a                	add	a0,a0,a4
   16d74:	0f85                	addi	t6,t6,1
   16d76:	01e59023          	sh	t5,0(a1)
   16d7a:	95ba                	add	a1,a1,a4
   16d7c:	fedf99e3          	bne	t6,a3,16d6e <.get_s2_seq>
   16d80:	8082                	ret

0000000000016d82 <__xbrtime_get_s2_agg>:
   16d82:	0006757b          	eaddie	e10,a2,0
   16d86:	46e695b3          	eag	a1,a3,a4
   16d8a:	000515f7          	elh	a1,0(a0)
   16d8e:	8082                	ret

0000000000016d90 <__xbrtime_get_s4_seq>:
   16d90:	0006757b          	eaddie	e10,a2,0
   16d94:	00000f93          	li	t6,0

0000000000016d98 <.get_s4_seq>:
   16d98:	00052f77          	elw	t5,0(a0)
   16d9c:	953a                	add	a0,a0,a4
   16d9e:	0f85                	addi	t6,t6,1
   16da0:	01e5a023          	sw	t5,0(a1)
   16da4:	95ba                	add	a1,a1,a4
   16da6:	fedf99e3          	bne	t6,a3,16d98 <.get_s4_seq>
   16daa:	8082                	ret

0000000000016dac <__xbrtime_get_s4_agg>:
   16dac:	0006757b          	eaddie	e10,a2,0
   16db0:	46e695b3          	eag	a1,a3,a4
   16db4:	000525f7          	elw	a1,0(a0)
   16db8:	8082                	ret

0000000000016dba <__xbrtime_get_s8_seq>:
   16dba:	0006757b          	eaddie	e10,a2,0
   16dbe:	00000f93          	li	t6,0

0000000000016dc2 <.get_s8_seq>:
   16dc2:	00053f77          	eld	t5,0(a0)
   16dc6:	953a                	add	a0,a0,a4
   16dc8:	0f85                	addi	t6,t6,1
   16dca:	01e5b023          	sd	t5,0(a1)
   16dce:	95ba                	add	a1,a1,a4
   16dd0:	fedf99e3          	bne	t6,a3,16dc2 <.get_s8_seq>
   16dd4:	8082                	ret

0000000000016dd6 <__xbrtime_get_s8_agg>:
   16dd6:	0006757b          	eaddie	e10,a2,0
   16dda:	46e695b3          	eag	a1,a3,a4
   16dde:	000535f7          	eld	a1,0(a0)
   16de2:	8082                	ret

0000000000016de4 <__xbrtime_put_u1_seq>:
   16de4:	000675fb          	eaddie	e11,a2,0
   16de8:	00000f93          	li	t6,0

0000000000016dec <.put_u1_seq>:
   16dec:	00054f03          	lbu	t5,0(a0)
   16df0:	953a                	add	a0,a0,a4
   16df2:	0f85                	addi	t6,t6,1
   16df4:	01e5807b          	esb	t5,0(a1)
   16df8:	95ba                	add	a1,a1,a4
   16dfa:	fedf99e3          	bne	t6,a3,16dec <.put_u1_seq>
   16dfe:	8082                	ret

0000000000016e00 <__xbrtime_put_u1_agg>:
   16e00:	000675fb          	eaddie	e11,a2,0
   16e04:	46e69533          	eag	a0,a3,a4
   16e08:	00a5807b          	esb	a0,0(a1)
   16e0c:	8082                	ret

0000000000016e0e <__xbrtime_put_u2_seq>:
   16e0e:	000675fb          	eaddie	e11,a2,0
   16e12:	00000f93          	li	t6,0

0000000000016e16 <.put_u2_seq>:
   16e16:	00055f03          	lhu	t5,0(a0)
   16e1a:	953a                	add	a0,a0,a4
   16e1c:	0f85                	addi	t6,t6,1
   16e1e:	01e5907b          	esh	t5,0(a1)
   16e22:	95ba                	add	a1,a1,a4
   16e24:	fedf99e3          	bne	t6,a3,16e16 <.put_u2_seq>
   16e28:	8082                	ret

0000000000016e2a <__xbrtime_put_u2_agg>:
   16e2a:	000675fb          	eaddie	e11,a2,0
   16e2e:	46e69533          	eag	a0,a3,a4
   16e32:	00a5907b          	esh	a0,0(a1)
   16e36:	8082                	ret

0000000000016e38 <__xbrtime_put_u4_seq>:
   16e38:	000675fb          	eaddie	e11,a2,0
   16e3c:	00000f93          	li	t6,0

0000000000016e40 <.put_u4_seq>:
   16e40:	00056f03          	lwu	t5,0(a0)
   16e44:	953a                	add	a0,a0,a4
   16e46:	0f85                	addi	t6,t6,1
   16e48:	01e5a07b          	esw	t5,0(a1)
   16e4c:	95ba                	add	a1,a1,a4
   16e4e:	fedf99e3          	bne	t6,a3,16e40 <.put_u4_seq>
   16e52:	8082                	ret

0000000000016e54 <__xbrtime_put_u4_agg>:
   16e54:	000675fb          	eaddie	e11,a2,0
   16e58:	46e69533          	eag	a0,a3,a4
   16e5c:	00a5a07b          	esw	a0,0(a1)
   16e60:	8082                	ret

0000000000016e62 <__xbrtime_put_u8_seq>:
   16e62:	000675fb          	eaddie	e11,a2,0
   16e66:	00000f93          	li	t6,0

0000000000016e6a <.put_u8_seq>:
   16e6a:	00053f03          	ld	t5,0(a0)
   16e6e:	953a                	add	a0,a0,a4
   16e70:	0f85                	addi	t6,t6,1
   16e72:	01e5b07b          	esd	t5,0(a1)
   16e76:	95ba                	add	a1,a1,a4
   16e78:	fedf99e3          	bne	t6,a3,16e6a <.put_u8_seq>
   16e7c:	8082                	ret

0000000000016e7e <__xbrtime_put_u8_agg>:
   16e7e:	000675fb          	eaddie	e11,a2,0
   16e82:	46e69533          	eag	a0,a3,a4
   16e86:	00a5b07b          	esd	a0,0(a1)
   16e8a:	8082                	ret

0000000000016e8c <__xbrtime_put_s1_seq>:
   16e8c:	000675fb          	eaddie	e11,a2,0
   16e90:	00000f93          	li	t6,0

0000000000016e94 <.put_s1_seq>:
   16e94:	00050f03          	lb	t5,0(a0)
   16e98:	953a                	add	a0,a0,a4
   16e9a:	0f85                	addi	t6,t6,1
   16e9c:	01e5807b          	esb	t5,0(a1)
   16ea0:	95ba                	add	a1,a1,a4
   16ea2:	fedf99e3          	bne	t6,a3,16e94 <.put_s1_seq>
   16ea6:	8082                	ret

0000000000016ea8 <__xbrtime_put_s1_agg>:
   16ea8:	000675fb          	eaddie	e11,a2,0
   16eac:	46e69533          	eag	a0,a3,a4
   16eb0:	00a5807b          	esb	a0,0(a1)
   16eb4:	8082                	ret

0000000000016eb6 <__xbrtime_put_s2_seq>:
   16eb6:	000675fb          	eaddie	e11,a2,0
   16eba:	00000f93          	li	t6,0

0000000000016ebe <.put_s2_seq>:
   16ebe:	00051f03          	lh	t5,0(a0)
   16ec2:	953a                	add	a0,a0,a4
   16ec4:	0f85                	addi	t6,t6,1
   16ec6:	01e5907b          	esh	t5,0(a1)
   16eca:	95ba                	add	a1,a1,a4
   16ecc:	fedf99e3          	bne	t6,a3,16ebe <.put_s2_seq>
   16ed0:	8082                	ret

0000000000016ed2 <__xbrtime_put_s2_agg>:
   16ed2:	000675fb          	eaddie	e11,a2,0
   16ed6:	46e69533          	eag	a0,a3,a4
   16eda:	00a5907b          	esh	a0,0(a1)
   16ede:	8082                	ret

0000000000016ee0 <__xbrtime_put_s4_seq>:
   16ee0:	000675fb          	eaddie	e11,a2,0
   16ee4:	00000f93          	li	t6,0

0000000000016ee8 <.put_s4_seq>:
   16ee8:	00052f03          	lw	t5,0(a0)
   16eec:	953a                	add	a0,a0,a4
   16eee:	0f85                	addi	t6,t6,1
   16ef0:	01e5a07b          	esw	t5,0(a1)
   16ef4:	95ba                	add	a1,a1,a4
   16ef6:	fedf99e3          	bne	t6,a3,16ee8 <.put_s4_seq>
   16efa:	8082                	ret

0000000000016efc <__xbrtime_put_s4_agg>:
   16efc:	000675fb          	eaddie	e11,a2,0
   16f00:	46e69533          	eag	a0,a3,a4
   16f04:	00a5a07b          	esw	a0,0(a1)
   16f08:	8082                	ret

0000000000016f0a <__xbrtime_put_s8_seq>:
   16f0a:	000675fb          	eaddie	e11,a2,0
   16f0e:	00000f93          	li	t6,0

0000000000016f12 <.put_s8_seq>:
   16f12:	00053f03          	ld	t5,0(a0)
   16f16:	953a                	add	a0,a0,a4
   16f18:	0f85                	addi	t6,t6,1
   16f1a:	01e5b07b          	esd	t5,0(a1)
   16f1e:	95ba                	add	a1,a1,a4
   16f20:	fedf99e3          	bne	t6,a3,16f12 <.put_s8_seq>
   16f24:	8082                	ret

0000000000016f26 <__xbrtime_put_s8_agg>:
   16f26:	000675fb          	eaddie	e11,a2,0
   16f2a:	46e69533          	eag	a0,a3,a4
   16f2e:	00a5b07b          	esd	a0,0(a1)
   16f32:	8082                	ret
	...

0000000000016f36 <__xbrtime_asm_get_id>:
   16f36:	0005657b          	eaddi	a0,e10,0
   16f3a:	8082                	ret

0000000000016f3c <__xbrtime_asm_get_npes>:
   16f3c:	0005e57b          	eaddi	a0,e11,0
   16f40:	8082                	ret

0000000000016f42 <__xbrtime_asm_get_memsize>:
   16f42:	0006657b          	eaddi	a0,e12,0
   16f46:	8082                	ret

0000000000016f48 <__xbrtime_asm_get_startaddr>:
   16f48:	0006e57b          	eaddi	a0,e13,0
   16f4c:	8082                	ret

0000000000016f4e <__xbrtime_asm_fence>:
   16f4e:	0000100f          	fence.i
   16f52:	8082                	ret

0000000000016f54 <__xbrtime_asm_quiet_fence>:
   16f54:	0ff0000f          	fence
   16f58:	8082                	ret

0000000000016f5a <__xbrtime_get_remote_alloc>:
   16f5a:	0005f57b          	eaddie	e10,a1,0
   16f5e:	00053577          	eld	a0,0(a0)
   16f62:	8082                	ret

0000000000016f64 <__xbrtime_remote_touch>:
   16f64:	0005f57b          	eaddie	e10,a1,0
   16f68:	00c5307b          	esd	a2,0(a0)
   16f6c:	8082                	ret
	...

0000000000016f70 <log>:
   16f70:	715d                	addi	sp,sp,-80
   16f72:	bc22                	fsd	fs0,56(sp)
   16f74:	e486                	sd	ra,72(sp)
   16f76:	22a50453          	fmv.d	fs0,fa0
   16f7a:	0b4000ef          	jal	ra,1702e <__ieee754_log>
   16f7e:	8981a703          	lw	a4,-1896(gp) # 187f0 <__fdlib_version>
   16f82:	57fd                	li	a5,-1
   16f84:	0af70063          	beq	a4,a5,17024 <log+0xb4>
   16f88:	a28427d3          	feq.d	a5,fs0,fs0
   16f8c:	cfc1                	beqz	a5,17024 <log+0xb4>
   16f8e:	f20007d3          	fmv.d.x	fa5,zero
   16f92:	a28797d3          	flt.d	a5,fa5,fs0
   16f96:	e7d9                	bnez	a5,17024 <log+0xb4>
   16f98:	000186b7          	lui	a3,0x18
   16f9c:	a2068693          	addi	a3,a3,-1504 # 17a20 <_exit+0x124>
   16fa0:	e436                	sd	a3,8(sp)
   16fa2:	d402                	sw	zero,40(sp)
   16fa4:	a822                	fsd	fs0,16(sp)
   16fa6:	ac22                	fsd	fs0,24(sp)
   16fa8:	a2f427d3          	feq.d	a5,fs0,fa5
   16fac:	e315                	bnez	a4,16fd0 <log+0x60>
   16fae:	000186b7          	lui	a3,0x18
   16fb2:	7586b787          	fld	fa5,1880(a3) # 18758 <__TMC_END__>
   16fb6:	b03e                	fsd	fa5,32(sp)
   16fb8:	eba9                	bnez	a5,1700a <log+0x9a>
   16fba:	4785                	li	a5,1
   16fbc:	c03e                	sw	a5,0(sp)
   16fbe:	4789                	li	a5,2
   16fc0:	02f71963          	bne	a4,a5,16ff2 <log+0x82>
   16fc4:	2ac000ef          	jal	ra,17270 <__errno>
   16fc8:	02100793          	li	a5,33
   16fcc:	c11c                	sw	a5,0(a0)
   16fce:	a035                	j	16ffa <log+0x8a>
   16fd0:	000186b7          	lui	a3,0x18
   16fd4:	7606b787          	fld	fa5,1888(a3) # 18760 <__TMC_END__+0x8>
   16fd8:	b03e                	fsd	fa5,32(sp)
   16fda:	d3e5                	beqz	a5,16fba <log+0x4a>
   16fdc:	4789                	li	a5,2
   16fde:	c03e                	sw	a5,0(sp)
   16fe0:	4789                	li	a5,2
   16fe2:	02f71663          	bne	a4,a5,1700e <log+0x9e>
   16fe6:	28a000ef          	jal	ra,17270 <__errno>
   16fea:	02200793          	li	a5,34
   16fee:	c11c                	sw	a5,0(a0)
   16ff0:	a01d                	j	17016 <log+0xa6>
   16ff2:	850a                	mv	a0,sp
   16ff4:	25c000ef          	jal	ra,17250 <matherr>
   16ff8:	d571                	beqz	a0,16fc4 <log+0x54>
   16ffa:	00018537          	lui	a0,0x18
   16ffe:	a2850513          	addi	a0,a0,-1496 # 17a28 <_exit+0x12c>
   17002:	254000ef          	jal	ra,17256 <nan>
   17006:	b02a                	fsd	fa0,32(sp)
   17008:	a039                	j	17016 <log+0xa6>
   1700a:	4789                	li	a5,2
   1700c:	c03e                	sw	a5,0(sp)
   1700e:	850a                	mv	a0,sp
   17010:	240000ef          	jal	ra,17250 <matherr>
   17014:	d969                	beqz	a0,16fe6 <log+0x76>
   17016:	57a2                	lw	a5,40(sp)
   17018:	c789                	beqz	a5,17022 <log+0xb2>
   1701a:	256000ef          	jal	ra,17270 <__errno>
   1701e:	57a2                	lw	a5,40(sp)
   17020:	c11c                	sw	a5,0(a0)
   17022:	3502                	fld	fa0,32(sp)
   17024:	60a6                	ld	ra,72(sp)
   17026:	3462                	fld	fs0,56(sp)
   17028:	6161                	addi	sp,sp,80
   1702a:	8082                	ret
	...

000000000001702e <__ieee754_log>:
   1702e:	e20507d3          	fmv.x.d	a5,fa0
   17032:	00100637          	lui	a2,0x100
   17036:	4207d713          	srai	a4,a5,0x20
   1703a:	0007069b          	sext.w	a3,a4
   1703e:	04c6df63          	ble	a2,a3,1709c <__ieee754_log+0x6e>
   17042:	80000637          	lui	a2,0x80000
   17046:	fff64613          	not	a2,a2
   1704a:	8f71                	and	a4,a4,a2
   1704c:	8f5d                	or	a4,a4,a5
   1704e:	2701                	sext.w	a4,a4
   17050:	eb11                	bnez	a4,17064 <__ieee754_log+0x36>
   17052:	000187b7          	lui	a5,0x18
   17056:	f20007d3          	fmv.d.x	fa5,zero
   1705a:	7687b507          	fld	fa0,1896(a5) # 18768 <__TMC_END__+0x10>
   1705e:	1af57553          	fdiv.d	fa0,fa0,fa5
   17062:	8082                	ret
   17064:	0006d763          	bgez	a3,17072 <__ieee754_log+0x44>
   17068:	0aa57553          	fsub.d	fa0,fa0,fa0
   1706c:	f20007d3          	fmv.d.x	fa5,zero
   17070:	b7fd                	j	1705e <__ieee754_log+0x30>
   17072:	00018737          	lui	a4,0x18
   17076:	77073787          	fld	fa5,1904(a4) # 18770 <__TMC_END__+0x18>
   1707a:	fca00513          	li	a0,-54
   1707e:	12f577d3          	fmul.d	fa5,fa0,fa5
   17082:	e20787d3          	fmv.x.d	a5,fa5
   17086:	4207d693          	srai	a3,a5,0x20
   1708a:	7ff00737          	lui	a4,0x7ff00
   1708e:	00e6c963          	blt	a3,a4,170a0 <__ieee754_log+0x72>
   17092:	f20787d3          	fmv.d.x	fa5,a5
   17096:	02f7f553          	fadd.d	fa0,fa5,fa5
   1709a:	8082                	ret
   1709c:	4501                	li	a0,0
   1709e:	b7f5                	j	1708a <__ieee754_log+0x5c>
   170a0:	4146d71b          	sraiw	a4,a3,0x14
   170a4:	c017071b          	addiw	a4,a4,-1023
   170a8:	00100837          	lui	a6,0x100
   170ac:	9d39                	addw	a0,a0,a4
   170ae:	187d                	addi	a6,a6,-1
   170b0:	00096737          	lui	a4,0x96
   170b4:	0106f6b3          	and	a3,a3,a6
   170b8:	f647071b          	addiw	a4,a4,-156
   170bc:	00100637          	lui	a2,0x100
   170c0:	9f35                	addw	a4,a4,a3
   170c2:	8f71                	and	a4,a4,a2
   170c4:	3ff005b7          	lui	a1,0x3ff00
   170c8:	8db9                	xor	a1,a1,a4
   170ca:	567d                	li	a2,-1
   170cc:	9201                	srli	a2,a2,0x20
   170ce:	8dd5                	or	a1,a1,a3
   170d0:	1582                	slli	a1,a1,0x20
   170d2:	8ff1                	and	a5,a5,a2
   170d4:	8fcd                	or	a5,a5,a1
   170d6:	000185b7          	lui	a1,0x18
   170da:	7785b507          	fld	fa0,1912(a1) # 18778 <__TMC_END__+0x20>
   170de:	f20787d3          	fmv.d.x	fa5,a5
   170e2:	0026879b          	addiw	a5,a3,2
   170e6:	0107f7b3          	and	a5,a5,a6
   170ea:	4147571b          	sraiw	a4,a4,0x14
   170ee:	2781                	sext.w	a5,a5
   170f0:	4589                	li	a1,2
   170f2:	00a7063b          	addw	a2,a4,a0
   170f6:	0aa7f553          	fsub.d	fa0,fa5,fa0
   170fa:	06f5cc63          	blt	a1,a5,17172 <__ieee754_log+0x144>
   170fe:	f20007d3          	fmv.d.x	fa5,zero
   17102:	a2f527d3          	feq.d	a5,fa0,fa5
   17106:	c39d                	beqz	a5,1712c <__ieee754_log+0xfe>
   17108:	22f78553          	fmv.d	fa0,fa5
   1710c:	c235                	beqz	a2,17170 <__ieee754_log+0x142>
   1710e:	000187b7          	lui	a5,0x18
   17112:	d20607d3          	fcvt.d.w	fa5,a2
   17116:	7807b707          	fld	fa4,1920(a5) # 18780 <__TMC_END__+0x28>
   1711a:	000187b7          	lui	a5,0x18
   1711e:	7887b507          	fld	fa0,1928(a5) # 18788 <__TMC_END__+0x30>
   17122:	12e7f753          	fmul.d	fa4,fa5,fa4
   17126:	72a7f543          	fmadd.d	fa0,fa5,fa0,fa4
   1712a:	8082                	ret
   1712c:	000187b7          	lui	a5,0x18
   17130:	7907b707          	fld	fa4,1936(a5) # 18790 <__TMC_END__+0x38>
   17134:	000187b7          	lui	a5,0x18
   17138:	7987b787          	fld	fa5,1944(a5) # 18798 <__TMC_END__+0x40>
   1713c:	7ae5774b          	fnmsub.d	fa4,fa0,fa4,fa5
   17140:	12a577d3          	fmul.d	fa5,fa0,fa0
   17144:	12f77753          	fmul.d	fa4,fa4,fa5
   17148:	e601                	bnez	a2,17150 <__ieee754_log+0x122>
   1714a:	0ae57553          	fsub.d	fa0,fa0,fa4
   1714e:	8082                	ret
   17150:	d20607d3          	fcvt.d.w	fa5,a2
   17154:	000187b7          	lui	a5,0x18
   17158:	7807b687          	fld	fa3,1920(a5) # 18780 <__TMC_END__+0x28>
   1715c:	000187b7          	lui	a5,0x18
   17160:	72d7f74b          	fnmsub.d	fa4,fa5,fa3,fa4
   17164:	0aa77753          	fsub.d	fa4,fa4,fa0
   17168:	7887b507          	fld	fa0,1928(a5) # 18788 <__TMC_END__+0x30>
   1716c:	72a7f547          	fmsub.d	fa0,fa5,fa0,fa4
   17170:	8082                	ret
   17172:	000187b7          	lui	a5,0x18
   17176:	7a07b707          	fld	fa4,1952(a5) # 187a0 <__TMC_END__+0x48>
   1717a:	00018737          	lui	a4,0x18
   1717e:	7a873687          	fld	fa3,1960(a4) # 187a8 <__TMC_END__+0x50>
   17182:	02e57753          	fadd.d	fa4,fa0,fa4
   17186:	00018737          	lui	a4,0x18
   1718a:	fff9f7b7          	lui	a5,0xfff9f
   1718e:	b867879b          	addiw	a5,a5,-1146
   17192:	9fb5                	addw	a5,a5,a3
   17194:	d20607d3          	fcvt.d.w	fa5,a2
   17198:	1ae57653          	fdiv.d	fa2,fa0,fa4
   1719c:	7b073707          	fld	fa4,1968(a4) # 187b0 <__TMC_END__+0x58>
   171a0:	00018737          	lui	a4,0x18
   171a4:	12c67053          	fmul.d	ft0,fa2,fa2
   171a8:	120075d3          	fmul.d	fa1,ft0,ft0
   171ac:	72d5f6c3          	fmadd.d	fa3,fa1,fa3,fa4
   171b0:	7b873707          	fld	fa4,1976(a4) # 187b8 <__TMC_END__+0x60>
   171b4:	00018737          	lui	a4,0x18
   171b8:	72b6f6c3          	fmadd.d	fa3,fa3,fa1,fa4
   171bc:	7c073707          	fld	fa4,1984(a4) # 187c0 <__TMC_END__+0x68>
   171c0:	00018737          	lui	a4,0x18
   171c4:	7c873087          	fld	ft1,1992(a4) # 187c8 <__TMC_END__+0x70>
   171c8:	00018737          	lui	a4,0x18
   171cc:	0ae5f743          	fmadd.d	fa4,fa1,fa4,ft1
   171d0:	7d073087          	fld	ft1,2000(a4) # 187d0 <__TMC_END__+0x78>
   171d4:	00018737          	lui	a4,0x18
   171d8:	0ab77743          	fmadd.d	fa4,fa4,fa1,ft1
   171dc:	7d873087          	fld	ft1,2008(a4) # 187d8 <__TMC_END__+0x80>
   171e0:	0006c737          	lui	a4,0x6c
   171e4:	8517071b          	addiw	a4,a4,-1967
   171e8:	40d706bb          	subw	a3,a4,a3
   171ec:	8edd                	or	a3,a3,a5
   171ee:	2681                	sext.w	a3,a3
   171f0:	0ab77743          	fmadd.d	fa4,fa4,fa1,ft1
   171f4:	12077753          	fmul.d	fa4,fa4,ft0
   171f8:	72b6f743          	fmadd.d	fa4,fa3,fa1,fa4
   171fc:	04d05363          	blez	a3,17242 <__ieee754_log+0x214>
   17200:	000187b7          	lui	a5,0x18
   17204:	7987b687          	fld	fa3,1944(a5) # 18798 <__TMC_END__+0x40>
   17208:	12d576d3          	fmul.d	fa3,fa0,fa3
   1720c:	12a6f6d3          	fmul.d	fa3,fa3,fa0
   17210:	02d77753          	fadd.d	fa4,fa4,fa3
   17214:	12c77753          	fmul.d	fa4,fa4,fa2
   17218:	e601                	bnez	a2,17220 <__ieee754_log+0x1f2>
   1721a:	0ae6f753          	fsub.d	fa4,fa3,fa4
   1721e:	b735                	j	1714a <__ieee754_log+0x11c>
   17220:	000187b7          	lui	a5,0x18
   17224:	7807b607          	fld	fa2,1920(a5) # 18780 <__TMC_END__+0x28>
   17228:	000187b7          	lui	a5,0x18
   1722c:	72c7f743          	fmadd.d	fa4,fa5,fa2,fa4
   17230:	0ae6f6d3          	fsub.d	fa3,fa3,fa4
   17234:	0aa6f6d3          	fsub.d	fa3,fa3,fa0
   17238:	7887b507          	fld	fa0,1928(a5) # 18788 <__TMC_END__+0x30>
   1723c:	6aa7f547          	fmsub.d	fa0,fa5,fa0,fa3
   17240:	8082                	ret
   17242:	0ae57753          	fsub.d	fa4,fa0,fa4
   17246:	12c77753          	fmul.d	fa4,fa4,fa2
   1724a:	f609                	bnez	a2,17154 <__ieee754_log+0x126>
   1724c:	bdfd                	j	1714a <__ieee754_log+0x11c>
	...

0000000000017250 <matherr>:
   17250:	4501                	li	a0,0
   17252:	8082                	ret
	...

0000000000017256 <nan>:
   17256:	000187b7          	lui	a5,0x18
   1725a:	7e07b507          	fld	fa0,2016(a5) # 187e0 <__TMC_END__+0x88>
   1725e:	8082                	ret
	...

0000000000017262 <atexit>:
   17262:	85aa                	mv	a1,a0
   17264:	4681                	li	a3,0
   17266:	4601                	li	a2,0
   17268:	4501                	li	a0,0
   1726a:	1920006f          	j	173fc <__register_exitproc>
	...

0000000000017270 <__errno>:
   17270:	8a81b503          	ld	a0,-1880(gp) # 18800 <_impure_ptr>
   17274:	8082                	ret
	...

0000000000017278 <exit>:
   17278:	1141                	addi	sp,sp,-16
   1727a:	4581                	li	a1,0
   1727c:	e022                	sd	s0,0(sp)
   1727e:	e406                	sd	ra,8(sp)
   17280:	842a                	mv	s0,a0
   17282:	1e0000ef          	jal	ra,17462 <__call_exitprocs>
   17286:	8a01b503          	ld	a0,-1888(gp) # 187f8 <_global_impure_ptr>
   1728a:	6d3c                	ld	a5,88(a0)
   1728c:	c391                	beqz	a5,17290 <exit+0x18>
   1728e:	9782                	jalr	a5
   17290:	8522                	mv	a0,s0
   17292:	00000097          	auipc	ra,0x0
   17296:	66a080e7          	jalr	1642(ra) # 178fc <_exit>
	...

000000000001729c <__libc_fini_array>:
   1729c:	7179                	addi	sp,sp,-48
   1729e:	67e1                	lui	a5,0x18
   172a0:	6761                	lui	a4,0x18
   172a2:	f022                	sd	s0,32(sp)
   172a4:	00870713          	addi	a4,a4,8 # 18008 <__init_array_end>
   172a8:	01078413          	addi	s0,a5,16 # 18010 <__fini_array_end>
   172ac:	8c19                	sub	s0,s0,a4
   172ae:	ec26                	sd	s1,24(sp)
   172b0:	e84a                	sd	s2,16(sp)
   172b2:	e44e                	sd	s3,8(sp)
   172b4:	f406                	sd	ra,40(sp)
   172b6:	840d                	srai	s0,s0,0x3
   172b8:	4481                	li	s1,0
   172ba:	01078913          	addi	s2,a5,16
   172be:	59e1                	li	s3,-8
   172c0:	00941c63          	bne	s0,s1,172d8 <__libc_fini_array+0x3c>
   172c4:	7402                	ld	s0,32(sp)
   172c6:	70a2                	ld	ra,40(sp)
   172c8:	64e2                	ld	s1,24(sp)
   172ca:	6942                	ld	s2,16(sp)
   172cc:	69a2                	ld	s3,8(sp)
   172ce:	6145                	addi	sp,sp,48
   172d0:	ffff9317          	auipc	t1,0xffff9
   172d4:	e2630067          	jr	-474(t1) # 100f6 <_fini>
   172d8:	033487b3          	mul	a5,s1,s3
   172dc:	0485                	addi	s1,s1,1
   172de:	97ca                	add	a5,a5,s2
   172e0:	ff87b783          	ld	a5,-8(a5)
   172e4:	9782                	jalr	a5
   172e6:	bfe9                	j	172c0 <__libc_fini_array+0x24>
	...

00000000000172ea <__libc_init_array>:
   172ea:	1101                	addi	sp,sp,-32
   172ec:	e822                	sd	s0,16(sp)
   172ee:	e426                	sd	s1,8(sp)
   172f0:	6461                	lui	s0,0x18
   172f2:	64e1                	lui	s1,0x18
   172f4:	00048793          	mv	a5,s1
   172f8:	00040413          	mv	s0,s0
   172fc:	8c1d                	sub	s0,s0,a5
   172fe:	e04a                	sd	s2,0(sp)
   17300:	ec06                	sd	ra,24(sp)
   17302:	840d                	srai	s0,s0,0x3
   17304:	00048493          	mv	s1,s1
   17308:	4901                	li	s2,0
   1730a:	02891963          	bne	s2,s0,1733c <__libc_init_array+0x52>
   1730e:	64e1                	lui	s1,0x18
   17310:	ffff9097          	auipc	ra,0xffff9
   17314:	de6080e7          	jalr	-538(ra) # 100f6 <_fini>
   17318:	6461                	lui	s0,0x18
   1731a:	00048793          	mv	a5,s1
   1731e:	00840413          	addi	s0,s0,8 # 18008 <__init_array_end>
   17322:	8c1d                	sub	s0,s0,a5
   17324:	840d                	srai	s0,s0,0x3
   17326:	00048493          	mv	s1,s1
   1732a:	4901                	li	s2,0
   1732c:	00891d63          	bne	s2,s0,17346 <__libc_init_array+0x5c>
   17330:	60e2                	ld	ra,24(sp)
   17332:	6442                	ld	s0,16(sp)
   17334:	64a2                	ld	s1,8(sp)
   17336:	6902                	ld	s2,0(sp)
   17338:	6105                	addi	sp,sp,32
   1733a:	8082                	ret
   1733c:	609c                	ld	a5,0(s1)
   1733e:	0905                	addi	s2,s2,1
   17340:	04a1                	addi	s1,s1,8
   17342:	9782                	jalr	a5
   17344:	b7d9                	j	1730a <__libc_init_array+0x20>
   17346:	609c                	ld	a5,0(s1)
   17348:	0905                	addi	s2,s2,1
   1734a:	04a1                	addi	s1,s1,8
   1734c:	9782                	jalr	a5
   1734e:	bff9                	j	1732c <__libc_init_array+0x42>
	...

0000000000017352 <memset>:
   17352:	483d                	li	a6,15
   17354:	872a                	mv	a4,a0
   17356:	02c87163          	bleu	a2,a6,17378 <memset+0x26>
   1735a:	00f77793          	andi	a5,a4,15
   1735e:	e3c1                	bnez	a5,173de <memset+0x8c>
   17360:	e1bd                	bnez	a1,173c6 <memset+0x74>
   17362:	ff067693          	andi	a3,a2,-16
   17366:	8a3d                	andi	a2,a2,15
   17368:	96ba                	add	a3,a3,a4
   1736a:	e30c                	sd	a1,0(a4)
   1736c:	e70c                	sd	a1,8(a4)
   1736e:	0741                	addi	a4,a4,16
   17370:	fed76de3          	bltu	a4,a3,1736a <memset+0x18>
   17374:	e211                	bnez	a2,17378 <memset+0x26>
   17376:	8082                	ret
   17378:	40c806b3          	sub	a3,a6,a2
   1737c:	068a                	slli	a3,a3,0x2
   1737e:	00000297          	auipc	t0,0x0
   17382:	9696                	add	a3,a3,t0
   17384:	00a68067          	jr	10(a3)
   17388:	00b70723          	sb	a1,14(a4)
   1738c:	00b706a3          	sb	a1,13(a4)
   17390:	00b70623          	sb	a1,12(a4)
   17394:	00b705a3          	sb	a1,11(a4)
   17398:	00b70523          	sb	a1,10(a4)
   1739c:	00b704a3          	sb	a1,9(a4)
   173a0:	00b70423          	sb	a1,8(a4)
   173a4:	00b703a3          	sb	a1,7(a4)
   173a8:	00b70323          	sb	a1,6(a4)
   173ac:	00b702a3          	sb	a1,5(a4)
   173b0:	00b70223          	sb	a1,4(a4)
   173b4:	00b701a3          	sb	a1,3(a4)
   173b8:	00b70123          	sb	a1,2(a4)
   173bc:	00b700a3          	sb	a1,1(a4)
   173c0:	00b70023          	sb	a1,0(a4)
   173c4:	8082                	ret
   173c6:	0ff5f593          	andi	a1,a1,255
   173ca:	00859693          	slli	a3,a1,0x8
   173ce:	8dd5                	or	a1,a1,a3
   173d0:	01059693          	slli	a3,a1,0x10
   173d4:	8dd5                	or	a1,a1,a3
   173d6:	02059693          	slli	a3,a1,0x20
   173da:	8dd5                	or	a1,a1,a3
   173dc:	b759                	j	17362 <memset+0x10>
   173de:	00279693          	slli	a3,a5,0x2
   173e2:	00000297          	auipc	t0,0x0
   173e6:	9696                	add	a3,a3,t0
   173e8:	8286                	mv	t0,ra
   173ea:	fa2680e7          	jalr	-94(a3)
   173ee:	8096                	mv	ra,t0
   173f0:	17c1                	addi	a5,a5,-16
   173f2:	8f1d                	sub	a4,a4,a5
   173f4:	963e                	add	a2,a2,a5
   173f6:	f8c871e3          	bleu	a2,a6,17378 <memset+0x26>
   173fa:	b79d                	j	17360 <memset+0xe>

00000000000173fc <__register_exitproc>:
   173fc:	8a01b703          	ld	a4,-1888(gp) # 187f8 <_global_impure_ptr>
   17400:	832a                	mv	t1,a0
   17402:	1f873783          	ld	a5,504(a4)
   17406:	e789                	bnez	a5,17410 <__register_exitproc+0x14>
   17408:	20070793          	addi	a5,a4,512
   1740c:	1ef73c23          	sd	a5,504(a4)
   17410:	4798                	lw	a4,8(a5)
   17412:	487d                	li	a6,31
   17414:	557d                	li	a0,-1
   17416:	04e84463          	blt	a6,a4,1745e <__register_exitproc+0x62>
   1741a:	02030a63          	beqz	t1,1744e <__register_exitproc+0x52>
   1741e:	00371813          	slli	a6,a4,0x3
   17422:	983e                	add	a6,a6,a5
   17424:	10c83823          	sd	a2,272(a6) # 100110 <__global_pointer$+0xe71b8>
   17428:	3107a883          	lw	a7,784(a5)
   1742c:	4605                	li	a2,1
   1742e:	00e6163b          	sllw	a2,a2,a4
   17432:	00c8e8b3          	or	a7,a7,a2
   17436:	3117a823          	sw	a7,784(a5)
   1743a:	20d83823          	sd	a3,528(a6)
   1743e:	4689                	li	a3,2
   17440:	00d31763          	bne	t1,a3,1744e <__register_exitproc+0x52>
   17444:	3147a683          	lw	a3,788(a5)
   17448:	8e55                	or	a2,a2,a3
   1744a:	30c7aa23          	sw	a2,788(a5)
   1744e:	0017069b          	addiw	a3,a4,1
   17452:	0709                	addi	a4,a4,2
   17454:	070e                	slli	a4,a4,0x3
   17456:	c794                	sw	a3,8(a5)
   17458:	97ba                	add	a5,a5,a4
   1745a:	e38c                	sd	a1,0(a5)
   1745c:	4501                	li	a0,0
   1745e:	8082                	ret
	...

0000000000017462 <__call_exitprocs>:
   17462:	715d                	addi	sp,sp,-80
   17464:	f44e                	sd	s3,40(sp)
   17466:	8a01b983          	ld	s3,-1888(gp) # 187f8 <_global_impure_ptr>
   1746a:	f052                	sd	s4,32(sp)
   1746c:	ec56                	sd	s5,24(sp)
   1746e:	e85a                	sd	s6,16(sp)
   17470:	e486                	sd	ra,72(sp)
   17472:	e0a2                	sd	s0,64(sp)
   17474:	fc26                	sd	s1,56(sp)
   17476:	f84a                	sd	s2,48(sp)
   17478:	e45e                	sd	s7,8(sp)
   1747a:	8aaa                	mv	s5,a0
   1747c:	8a2e                	mv	s4,a1
   1747e:	4b05                	li	s6,1
   17480:	1f89b403          	ld	s0,504(s3)
   17484:	c801                	beqz	s0,17494 <__call_exitprocs+0x32>
   17486:	4404                	lw	s1,8(s0)
   17488:	34fd                	addiw	s1,s1,-1
   1748a:	00349913          	slli	s2,s1,0x3
   1748e:	9922                	add	s2,s2,s0
   17490:	0004dd63          	bgez	s1,174aa <__call_exitprocs+0x48>
   17494:	60a6                	ld	ra,72(sp)
   17496:	6406                	ld	s0,64(sp)
   17498:	74e2                	ld	s1,56(sp)
   1749a:	7942                	ld	s2,48(sp)
   1749c:	79a2                	ld	s3,40(sp)
   1749e:	7a02                	ld	s4,32(sp)
   174a0:	6ae2                	ld	s5,24(sp)
   174a2:	6b42                	ld	s6,16(sp)
   174a4:	6ba2                	ld	s7,8(sp)
   174a6:	6161                	addi	sp,sp,80
   174a8:	8082                	ret
   174aa:	000a0963          	beqz	s4,174bc <__call_exitprocs+0x5a>
   174ae:	21093783          	ld	a5,528(s2)
   174b2:	01478563          	beq	a5,s4,174bc <__call_exitprocs+0x5a>
   174b6:	34fd                	addiw	s1,s1,-1
   174b8:	1961                	addi	s2,s2,-8
   174ba:	bfd9                	j	17490 <__call_exitprocs+0x2e>
   174bc:	441c                	lw	a5,8(s0)
   174be:	01093683          	ld	a3,16(s2)
   174c2:	37fd                	addiw	a5,a5,-1
   174c4:	02979663          	bne	a5,s1,174f0 <__call_exitprocs+0x8e>
   174c8:	c404                	sw	s1,8(s0)
   174ca:	d6f5                	beqz	a3,174b6 <__call_exitprocs+0x54>
   174cc:	31042703          	lw	a4,784(s0)
   174d0:	009b163b          	sllw	a2,s6,s1
   174d4:	00842b83          	lw	s7,8(s0)
   174d8:	8f71                	and	a4,a4,a2
   174da:	2701                	sext.w	a4,a4
   174dc:	ef09                	bnez	a4,174f6 <__call_exitprocs+0x94>
   174de:	9682                	jalr	a3
   174e0:	4418                	lw	a4,8(s0)
   174e2:	1f89b783          	ld	a5,504(s3)
   174e6:	f9771de3          	bne	a4,s7,17480 <__call_exitprocs+0x1e>
   174ea:	fcf406e3          	beq	s0,a5,174b6 <__call_exitprocs+0x54>
   174ee:	bf49                	j	17480 <__call_exitprocs+0x1e>
   174f0:	00093823          	sd	zero,16(s2)
   174f4:	bfd9                	j	174ca <__call_exitprocs+0x68>
   174f6:	31442783          	lw	a5,788(s0)
   174fa:	11093583          	ld	a1,272(s2)
   174fe:	8ff1                	and	a5,a5,a2
   17500:	2781                	sext.w	a5,a5
   17502:	e781                	bnez	a5,1750a <__call_exitprocs+0xa8>
   17504:	8556                	mv	a0,s5
   17506:	9682                	jalr	a3
   17508:	bfe1                	j	174e0 <__call_exitprocs+0x7e>
   1750a:	852e                	mv	a0,a1
   1750c:	9682                	jalr	a3
   1750e:	bfc9                	j	174e0 <__call_exitprocs+0x7e>
	...

0000000000017512 <conv_stat>:
   17512:	619c                	ld	a5,0(a1)
   17514:	00f51023          	sh	a5,0(a0)
   17518:	659c                	ld	a5,8(a1)
   1751a:	00f51123          	sh	a5,2(a0)
   1751e:	499c                	lw	a5,16(a1)
   17520:	c15c                	sw	a5,4(a0)
   17522:	49dc                	lw	a5,20(a1)
   17524:	00f51423          	sh	a5,8(a0)
   17528:	4d9c                	lw	a5,24(a1)
   1752a:	00f51523          	sh	a5,10(a0)
   1752e:	4ddc                	lw	a5,28(a1)
   17530:	00f51623          	sh	a5,12(a0)
   17534:	719c                	ld	a5,32(a1)
   17536:	00f51723          	sh	a5,14(a0)
   1753a:	799c                	ld	a5,48(a1)
   1753c:	e91c                	sd	a5,16(a0)
   1753e:	61bc                	ld	a5,64(a1)
   17540:	e93c                	sd	a5,80(a0)
   17542:	5d9c                	lw	a5,56(a1)
   17544:	e53c                	sd	a5,72(a0)
   17546:	65bc                	ld	a5,72(a1)
   17548:	ed1c                	sd	a5,24(a0)
   1754a:	6dbc                	ld	a5,88(a1)
   1754c:	f51c                	sd	a5,40(a0)
   1754e:	75bc                	ld	a5,104(a1)
   17550:	fd1c                	sd	a5,56(a0)
   17552:	8082                	ret

0000000000017554 <__syscall_error>:
   17554:	1141                	addi	sp,sp,-16
   17556:	e022                	sd	s0,0(sp)
   17558:	e406                	sd	ra,8(sp)
   1755a:	842a                	mv	s0,a0
   1755c:	00000097          	auipc	ra,0x0
   17560:	d14080e7          	jalr	-748(ra) # 17270 <__errno>
   17564:	408007bb          	negw	a5,s0
   17568:	60a2                	ld	ra,8(sp)
   1756a:	6402                	ld	s0,0(sp)
   1756c:	c11c                	sw	a5,0(a0)
   1756e:	557d                	li	a0,-1
   17570:	0141                	addi	sp,sp,16
   17572:	8082                	ret

0000000000017574 <__internal_syscall>:
   17574:	88aa                	mv	a7,a0
   17576:	852e                	mv	a0,a1
   17578:	85b2                	mv	a1,a2
   1757a:	8636                	mv	a2,a3
   1757c:	86ba                	mv	a3,a4
   1757e:	00000073          	ecall
   17582:	00055663          	bgez	a0,1758e <__internal_syscall+0x1a>
   17586:	00000317          	auipc	t1,0x0
   1758a:	fce30067          	jr	-50(t1) # 17554 <__syscall_error>
   1758e:	8082                	ret

0000000000017590 <open>:
   17590:	1141                	addi	sp,sp,-16
   17592:	86b2                	mv	a3,a2
   17594:	4701                	li	a4,0
   17596:	862e                	mv	a2,a1
   17598:	85aa                	mv	a1,a0
   1759a:	40000513          	li	a0,1024
   1759e:	e406                	sd	ra,8(sp)
   175a0:	00000097          	auipc	ra,0x0
   175a4:	fd4080e7          	jalr	-44(ra) # 17574 <__internal_syscall>
   175a8:	60a2                	ld	ra,8(sp)
   175aa:	2501                	sext.w	a0,a0
   175ac:	0141                	addi	sp,sp,16
   175ae:	8082                	ret

00000000000175b0 <openat>:
   175b0:	1141                	addi	sp,sp,-16
   175b2:	8736                	mv	a4,a3
   175b4:	86b2                	mv	a3,a2
   175b6:	862e                	mv	a2,a1
   175b8:	85aa                	mv	a1,a0
   175ba:	03800513          	li	a0,56
   175be:	e406                	sd	ra,8(sp)
   175c0:	fb5ff0ef          	jal	ra,17574 <__internal_syscall>
   175c4:	60a2                	ld	ra,8(sp)
   175c6:	2501                	sext.w	a0,a0
   175c8:	0141                	addi	sp,sp,16
   175ca:	8082                	ret

00000000000175cc <lseek>:
   175cc:	86b2                	mv	a3,a2
   175ce:	4701                	li	a4,0
   175d0:	862e                	mv	a2,a1
   175d2:	85aa                	mv	a1,a0
   175d4:	03e00513          	li	a0,62
   175d8:	00000317          	auipc	t1,0x0
   175dc:	f9c30067          	jr	-100(t1) # 17574 <__internal_syscall>

00000000000175e0 <read>:
   175e0:	86b2                	mv	a3,a2
   175e2:	4701                	li	a4,0
   175e4:	862e                	mv	a2,a1
   175e6:	85aa                	mv	a1,a0
   175e8:	03f00513          	li	a0,63
   175ec:	f89ff06f          	j	17574 <__internal_syscall>

00000000000175f0 <write>:
   175f0:	86b2                	mv	a3,a2
   175f2:	4701                	li	a4,0
   175f4:	862e                	mv	a2,a1
   175f6:	85aa                	mv	a1,a0
   175f8:	04000513          	li	a0,64
   175fc:	00000317          	auipc	t1,0x0
   17600:	f7830067          	jr	-136(t1) # 17574 <__internal_syscall>

0000000000017604 <fstat>:
   17604:	7135                	addi	sp,sp,-160
   17606:	e526                	sd	s1,136(sp)
   17608:	860a                	mv	a2,sp
   1760a:	84ae                	mv	s1,a1
   1760c:	4701                	li	a4,0
   1760e:	85aa                	mv	a1,a0
   17610:	4681                	li	a3,0
   17612:	05000513          	li	a0,80
   17616:	ed06                	sd	ra,152(sp)
   17618:	e922                	sd	s0,144(sp)
   1761a:	f5bff0ef          	jal	ra,17574 <__internal_syscall>
   1761e:	842a                	mv	s0,a0
   17620:	858a                	mv	a1,sp
   17622:	8526                	mv	a0,s1
   17624:	eefff0ef          	jal	ra,17512 <conv_stat>
   17628:	0004051b          	sext.w	a0,s0
   1762c:	60ea                	ld	ra,152(sp)
   1762e:	644a                	ld	s0,144(sp)
   17630:	64aa                	ld	s1,136(sp)
   17632:	610d                	addi	sp,sp,160
   17634:	8082                	ret

0000000000017636 <stat>:
   17636:	7135                	addi	sp,sp,-160
   17638:	e526                	sd	s1,136(sp)
   1763a:	860a                	mv	a2,sp
   1763c:	84ae                	mv	s1,a1
   1763e:	4701                	li	a4,0
   17640:	85aa                	mv	a1,a0
   17642:	4681                	li	a3,0
   17644:	40e00513          	li	a0,1038
   17648:	ed06                	sd	ra,152(sp)
   1764a:	e922                	sd	s0,144(sp)
   1764c:	00000097          	auipc	ra,0x0
   17650:	f28080e7          	jalr	-216(ra) # 17574 <__internal_syscall>
   17654:	842a                	mv	s0,a0
   17656:	858a                	mv	a1,sp
   17658:	8526                	mv	a0,s1
   1765a:	00000097          	auipc	ra,0x0
   1765e:	eb8080e7          	jalr	-328(ra) # 17512 <conv_stat>
   17662:	0004051b          	sext.w	a0,s0
   17666:	60ea                	ld	ra,152(sp)
   17668:	644a                	ld	s0,144(sp)
   1766a:	64aa                	ld	s1,136(sp)
   1766c:	610d                	addi	sp,sp,160
   1766e:	8082                	ret

0000000000017670 <lstat>:
   17670:	7135                	addi	sp,sp,-160
   17672:	e526                	sd	s1,136(sp)
   17674:	860a                	mv	a2,sp
   17676:	84ae                	mv	s1,a1
   17678:	4701                	li	a4,0
   1767a:	85aa                	mv	a1,a0
   1767c:	4681                	li	a3,0
   1767e:	40f00513          	li	a0,1039
   17682:	ed06                	sd	ra,152(sp)
   17684:	e922                	sd	s0,144(sp)
   17686:	eefff0ef          	jal	ra,17574 <__internal_syscall>
   1768a:	842a                	mv	s0,a0
   1768c:	858a                	mv	a1,sp
   1768e:	8526                	mv	a0,s1
   17690:	e83ff0ef          	jal	ra,17512 <conv_stat>
   17694:	0004051b          	sext.w	a0,s0
   17698:	60ea                	ld	ra,152(sp)
   1769a:	644a                	ld	s0,144(sp)
   1769c:	64aa                	ld	s1,136(sp)
   1769e:	610d                	addi	sp,sp,160
   176a0:	8082                	ret

00000000000176a2 <fstatat>:
   176a2:	7135                	addi	sp,sp,-160
   176a4:	e526                	sd	s1,136(sp)
   176a6:	8736                	mv	a4,a3
   176a8:	84b2                	mv	s1,a2
   176aa:	868a                	mv	a3,sp
   176ac:	862e                	mv	a2,a1
   176ae:	85aa                	mv	a1,a0
   176b0:	04f00513          	li	a0,79
   176b4:	ed06                	sd	ra,152(sp)
   176b6:	e922                	sd	s0,144(sp)
   176b8:	00000097          	auipc	ra,0x0
   176bc:	ebc080e7          	jalr	-324(ra) # 17574 <__internal_syscall>
   176c0:	842a                	mv	s0,a0
   176c2:	858a                	mv	a1,sp
   176c4:	8526                	mv	a0,s1
   176c6:	00000097          	auipc	ra,0x0
   176ca:	e4c080e7          	jalr	-436(ra) # 17512 <conv_stat>
   176ce:	0004051b          	sext.w	a0,s0
   176d2:	60ea                	ld	ra,152(sp)
   176d4:	644a                	ld	s0,144(sp)
   176d6:	64aa                	ld	s1,136(sp)
   176d8:	610d                	addi	sp,sp,160
   176da:	8082                	ret

00000000000176dc <access>:
   176dc:	1141                	addi	sp,sp,-16
   176de:	862e                	mv	a2,a1
   176e0:	4701                	li	a4,0
   176e2:	85aa                	mv	a1,a0
   176e4:	4681                	li	a3,0
   176e6:	40900513          	li	a0,1033
   176ea:	e406                	sd	ra,8(sp)
   176ec:	e89ff0ef          	jal	ra,17574 <__internal_syscall>
   176f0:	60a2                	ld	ra,8(sp)
   176f2:	2501                	sext.w	a0,a0
   176f4:	0141                	addi	sp,sp,16
   176f6:	8082                	ret

00000000000176f8 <faccessat>:
   176f8:	1141                	addi	sp,sp,-16
   176fa:	8736                	mv	a4,a3
   176fc:	86b2                	mv	a3,a2
   176fe:	862e                	mv	a2,a1
   17700:	85aa                	mv	a1,a0
   17702:	03000513          	li	a0,48
   17706:	e406                	sd	ra,8(sp)
   17708:	00000097          	auipc	ra,0x0
   1770c:	e6c080e7          	jalr	-404(ra) # 17574 <__internal_syscall>
   17710:	60a2                	ld	ra,8(sp)
   17712:	2501                	sext.w	a0,a0
   17714:	0141                	addi	sp,sp,16
   17716:	8082                	ret

0000000000017718 <close>:
   17718:	1141                	addi	sp,sp,-16
   1771a:	85aa                	mv	a1,a0
   1771c:	4701                	li	a4,0
   1771e:	4681                	li	a3,0
   17720:	4601                	li	a2,0
   17722:	03900513          	li	a0,57
   17726:	e406                	sd	ra,8(sp)
   17728:	e4dff0ef          	jal	ra,17574 <__internal_syscall>
   1772c:	60a2                	ld	ra,8(sp)
   1772e:	2501                	sext.w	a0,a0
   17730:	0141                	addi	sp,sp,16
   17732:	8082                	ret

0000000000017734 <link>:
   17734:	1141                	addi	sp,sp,-16
   17736:	862e                	mv	a2,a1
   17738:	4701                	li	a4,0
   1773a:	85aa                	mv	a1,a0
   1773c:	4681                	li	a3,0
   1773e:	40100513          	li	a0,1025
   17742:	e406                	sd	ra,8(sp)
   17744:	00000097          	auipc	ra,0x0
   17748:	e30080e7          	jalr	-464(ra) # 17574 <__internal_syscall>
   1774c:	60a2                	ld	ra,8(sp)
   1774e:	2501                	sext.w	a0,a0
   17750:	0141                	addi	sp,sp,16
   17752:	8082                	ret

0000000000017754 <unlink>:
   17754:	1141                	addi	sp,sp,-16
   17756:	85aa                	mv	a1,a0
   17758:	4701                	li	a4,0
   1775a:	4681                	li	a3,0
   1775c:	4601                	li	a2,0
   1775e:	40200513          	li	a0,1026
   17762:	e406                	sd	ra,8(sp)
   17764:	e11ff0ef          	jal	ra,17574 <__internal_syscall>
   17768:	60a2                	ld	ra,8(sp)
   1776a:	2501                	sext.w	a0,a0
   1776c:	0141                	addi	sp,sp,16
   1776e:	8082                	ret

0000000000017770 <execve>:
   17770:	1141                	addi	sp,sp,-16
   17772:	e406                	sd	ra,8(sp)
   17774:	00000097          	auipc	ra,0x0
   17778:	afc080e7          	jalr	-1284(ra) # 17270 <__errno>
   1777c:	60a2                	ld	ra,8(sp)
   1777e:	47b1                	li	a5,12
   17780:	c11c                	sw	a5,0(a0)
   17782:	557d                	li	a0,-1
   17784:	0141                	addi	sp,sp,16
   17786:	8082                	ret

0000000000017788 <fork>:
   17788:	1141                	addi	sp,sp,-16
   1778a:	e406                	sd	ra,8(sp)
   1778c:	ae5ff0ef          	jal	ra,17270 <__errno>
   17790:	60a2                	ld	ra,8(sp)
   17792:	47ad                	li	a5,11
   17794:	c11c                	sw	a5,0(a0)
   17796:	557d                	li	a0,-1
   17798:	0141                	addi	sp,sp,16
   1779a:	8082                	ret

000000000001779c <getpid>:
   1779c:	4505                	li	a0,1
   1779e:	8082                	ret

00000000000177a0 <kill>:
   177a0:	1141                	addi	sp,sp,-16
   177a2:	e406                	sd	ra,8(sp)
   177a4:	acdff0ef          	jal	ra,17270 <__errno>
   177a8:	60a2                	ld	ra,8(sp)
   177aa:	47d9                	li	a5,22
   177ac:	c11c                	sw	a5,0(a0)
   177ae:	557d                	li	a0,-1
   177b0:	0141                	addi	sp,sp,16
   177b2:	8082                	ret

00000000000177b4 <wait>:
   177b4:	1141                	addi	sp,sp,-16
   177b6:	e406                	sd	ra,8(sp)
   177b8:	00000097          	auipc	ra,0x0
   177bc:	ab8080e7          	jalr	-1352(ra) # 17270 <__errno>
   177c0:	60a2                	ld	ra,8(sp)
   177c2:	47a9                	li	a5,10
   177c4:	c11c                	sw	a5,0(a0)
   177c6:	557d                	li	a0,-1
   177c8:	0141                	addi	sp,sp,16
   177ca:	8082                	ret

00000000000177cc <isatty>:
   177cc:	7119                	addi	sp,sp,-128
   177ce:	002c                	addi	a1,sp,8
   177d0:	fc86                	sd	ra,120(sp)
   177d2:	e33ff0ef          	jal	ra,17604 <fstat>
   177d6:	57fd                	li	a5,-1
   177d8:	00f50663          	beq	a0,a5,177e4 <isatty+0x18>
   177dc:	4532                	lw	a0,12(sp)
   177de:	40d5551b          	sraiw	a0,a0,0xd
   177e2:	8905                	andi	a0,a0,1
   177e4:	70e6                	ld	ra,120(sp)
   177e6:	6109                	addi	sp,sp,128
   177e8:	8082                	ret

00000000000177ea <gettimeofday>:
   177ea:	1141                	addi	sp,sp,-16
   177ec:	85aa                	mv	a1,a0
   177ee:	4701                	li	a4,0
   177f0:	4681                	li	a3,0
   177f2:	4601                	li	a2,0
   177f4:	0a900513          	li	a0,169
   177f8:	e406                	sd	ra,8(sp)
   177fa:	00000097          	auipc	ra,0x0
   177fe:	d7a080e7          	jalr	-646(ra) # 17574 <__internal_syscall>
   17802:	60a2                	ld	ra,8(sp)
   17804:	2501                	sext.w	a0,a0
   17806:	0141                	addi	sp,sp,16
   17808:	8082                	ret

000000000001780a <times>:
   1780a:	7179                	addi	sp,sp,-48
   1780c:	f022                	sd	s0,32(sp)
   1780e:	842a                	mv	s0,a0
   17810:	8f81b783          	ld	a5,-1800(gp) # 18850 <t0.2574>
   17814:	ec26                	sd	s1,24(sp)
   17816:	f406                	sd	ra,40(sp)
   17818:	8f818493          	addi	s1,gp,-1800 # 18850 <t0.2574>
   1781c:	eb81                	bnez	a5,1782c <times+0x22>
   1781e:	4581                	li	a1,0
   17820:	8f818513          	addi	a0,gp,-1800 # 18850 <t0.2574>
   17824:	00000097          	auipc	ra,0x0
   17828:	fc6080e7          	jalr	-58(ra) # 177ea <gettimeofday>
   1782c:	850a                	mv	a0,sp
   1782e:	4581                	li	a1,0
   17830:	00000097          	auipc	ra,0x0
   17834:	fba080e7          	jalr	-70(ra) # 177ea <gettimeofday>
   17838:	6098                	ld	a4,0(s1)
   1783a:	6782                	ld	a5,0(sp)
   1783c:	6494                	ld	a3,8(s1)
   1783e:	00043823          	sd	zero,16(s0)
   17842:	8f99                	sub	a5,a5,a4
   17844:	000f4737          	lui	a4,0xf4
   17848:	24070713          	addi	a4,a4,576 # f4240 <__global_pointer$+0xdb2e8>
   1784c:	02e787b3          	mul	a5,a5,a4
   17850:	6722                	ld	a4,8(sp)
   17852:	00043c23          	sd	zero,24(s0)
   17856:	00043423          	sd	zero,8(s0)
   1785a:	8f15                	sub	a4,a4,a3
   1785c:	70a2                	ld	ra,40(sp)
   1785e:	64e2                	ld	s1,24(sp)
   17860:	557d                	li	a0,-1
   17862:	97ba                	add	a5,a5,a4
   17864:	e01c                	sd	a5,0(s0)
   17866:	7402                	ld	s0,32(sp)
   17868:	6145                	addi	sp,sp,48
   1786a:	8082                	ret

000000000001786c <ftime>:
   1786c:	00051423          	sh	zero,8(a0)
   17870:	00053023          	sd	zero,0(a0)
   17874:	4501                	li	a0,0
   17876:	8082                	ret

0000000000017878 <utime>:
   17878:	557d                	li	a0,-1
   1787a:	8082                	ret

000000000001787c <chown>:
   1787c:	557d                	li	a0,-1
   1787e:	8082                	ret

0000000000017880 <chmod>:
   17880:	557d                	li	a0,-1
   17882:	8082                	ret

0000000000017884 <chdir>:
   17884:	557d                	li	a0,-1
   17886:	8082                	ret

0000000000017888 <getcwd>:
   17888:	4501                	li	a0,0
   1788a:	8082                	ret

000000000001788c <sysconf>:
   1788c:	4789                	li	a5,2
   1788e:	00f50463          	beq	a0,a5,17896 <sysconf+0xa>
   17892:	557d                	li	a0,-1
   17894:	8082                	ret
   17896:	000f4537          	lui	a0,0xf4
   1789a:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xdb2e8>
   1789e:	8082                	ret

00000000000178a0 <sbrk>:
   178a0:	1101                	addi	sp,sp,-32
   178a2:	e822                	sd	s0,16(sp)
   178a4:	8b81b783          	ld	a5,-1864(gp) # 18810 <heap_end.2611>
   178a8:	e426                	sd	s1,8(sp)
   178aa:	ec06                	sd	ra,24(sp)
   178ac:	84aa                	mv	s1,a0
   178ae:	e785                	bnez	a5,178d6 <sbrk+0x36>
   178b0:	4701                	li	a4,0
   178b2:	4681                	li	a3,0
   178b4:	4601                	li	a2,0
   178b6:	4581                	li	a1,0
   178b8:	0d600513          	li	a0,214
   178bc:	cb9ff0ef          	jal	ra,17574 <__internal_syscall>
   178c0:	57fd                	li	a5,-1
   178c2:	00f51863          	bne	a0,a5,178d2 <sbrk+0x32>
   178c6:	557d                	li	a0,-1
   178c8:	60e2                	ld	ra,24(sp)
   178ca:	6442                	ld	s0,16(sp)
   178cc:	64a2                	ld	s1,8(sp)
   178ce:	6105                	addi	sp,sp,32
   178d0:	8082                	ret
   178d2:	8aa1bc23          	sd	a0,-1864(gp) # 18810 <heap_end.2611>
   178d6:	8b81b583          	ld	a1,-1864(gp) # 18810 <heap_end.2611>
   178da:	4701                	li	a4,0
   178dc:	4681                	li	a3,0
   178de:	95a6                	add	a1,a1,s1
   178e0:	4601                	li	a2,0
   178e2:	0d600513          	li	a0,214
   178e6:	c8fff0ef          	jal	ra,17574 <__internal_syscall>
   178ea:	8b81b783          	ld	a5,-1864(gp) # 18810 <heap_end.2611>
   178ee:	94be                	add	s1,s1,a5
   178f0:	fc951be3          	bne	a0,s1,178c6 <sbrk+0x26>
   178f4:	8aa1bc23          	sd	a0,-1864(gp) # 18810 <heap_end.2611>
   178f8:	853e                	mv	a0,a5
   178fa:	b7f9                	j	178c8 <sbrk+0x28>

00000000000178fc <_exit>:
   178fc:	1141                	addi	sp,sp,-16
   178fe:	85aa                	mv	a1,a0
   17900:	4701                	li	a4,0
   17902:	4681                	li	a3,0
   17904:	4601                	li	a2,0
   17906:	05d00513          	li	a0,93
   1790a:	e406                	sd	ra,8(sp)
   1790c:	00000097          	auipc	ra,0x0
   17910:	c68080e7          	jalr	-920(ra) # 17574 <__internal_syscall>
   17914:	a001                	j	17914 <_exit+0x18>
