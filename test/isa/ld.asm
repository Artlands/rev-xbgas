
ld.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	414000ef          	jal	10506 <__call_exitprocs>
   100f6:	fc81b503          	ld	a0,-56(gp) # 11e88 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	57a000ef          	jal	1067c <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	5c850513          	add	a0,a0,1480 # 105c8 <__libc_fini_array>
   10112:	a1ed                	j	105fc <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	daa18193          	add	gp,gp,-598 # 11ec0 <__global_pointer$>
   1011e:	fe018513          	add	a0,gp,-32 # 11ea0 <completed.1>
   10122:	01818613          	add	a2,gp,24 # 11ed8 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	332000ef          	jal	1045c <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	4ce50513          	add	a0,a0,1230 # 105fc <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	49050513          	add	a0,a0,1168 # 105c8 <__libc_fini_array>
   10140:	4bc000ef          	jal	105fc <atexit>
   10144:	2ae000ef          	jal	103f2 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fe01c783          	lbu	a5,-32(gp) # 11ea0 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	6a450513          	add	a0,a0,1700 # 116a4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fef18023          	sb	a5,-32(gp) # 11ea0 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fe818593          	add	a1,gp,-24 # 11ea8 <object.0>
   1018e:	6a450513          	add	a0,a0,1700 # 116a4 <__EH_FRAME_BEGIN__>
   10192:	00000317          	auipc	t1,0x0
   10196:	00000067          	jr	zero # 0 <exit-0x100e8>
   1019a:	8082                	ret

000000000001019c <main>:
   1019c:	1101                	add	sp,sp,-32
   1019e:	ec22                	sd	s0,24(sp)
   101a0:	1000                	add	s0,sp,32
   101a2:	87aa                	mv	a5,a0
   101a4:	feb43023          	sd	a1,-32(s0)
   101a8:	fef42623          	sw	a5,-20(s0)

00000000000101ac <test_2>:
   101ac:	4189                	li	gp,2
   101ae:	00ff07b7          	lui	a5,0xff0
   101b2:	0ff7879b          	addw	a5,a5,255 # ff00ff <__BSS_END__+0xfde227>
   101b6:	07c2                	sll	a5,a5,0x10
   101b8:	0ff78793          	add	a5,a5,255
   101bc:	07c2                	sll	a5,a5,0x10
   101be:	0ff78793          	add	a5,a5,255
   101c2:	00001097          	auipc	ra,0x1
   101c6:	4fe08093          	add	ra,ra,1278 # 116c0 <__DATA_BEGIN__>
   101ca:	0000b703          	ld	a4,0(ra)
   101ce:	00ff03b7          	lui	t2,0xff0
   101d2:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde227>
   101d6:	03c2                	sll	t2,t2,0x10
   101d8:	0ff38393          	add	t2,t2,255
   101dc:	03c2                	sll	t2,t2,0x10
   101de:	0ff38393          	add	t2,t2,255
   101e2:	20771063          	bne	a4,t2,103e2 <fail>

00000000000101e6 <test_3>:
   101e6:	418d                	li	gp,3
   101e8:	ff0107b7          	lui	a5,0xff010
   101ec:	f017879b          	addw	a5,a5,-255 # ffffffffff00ff01 <__BSS_END__+0xfffffffffeffe029>
   101f0:	07c2                	sll	a5,a5,0x10
   101f2:	f0178793          	add	a5,a5,-255
   101f6:	07c2                	sll	a5,a5,0x10
   101f8:	f0078793          	add	a5,a5,-256
   101fc:	00001097          	auipc	ra,0x1
   10200:	4c408093          	add	ra,ra,1220 # 116c0 <__DATA_BEGIN__>
   10204:	0080b703          	ld	a4,8(ra)
   10208:	ff0103b7          	lui	t2,0xff010
   1020c:	f013839b          	addw	t2,t2,-255 # ffffffffff00ff01 <__BSS_END__+0xfffffffffeffe029>
   10210:	03c2                	sll	t2,t2,0x10
   10212:	f0138393          	add	t2,t2,-255
   10216:	03c2                	sll	t2,t2,0x10
   10218:	f0038393          	add	t2,t2,-256
   1021c:	1c771363          	bne	a4,t2,103e2 <fail>

0000000000010220 <test_4>:
   10220:	4191                	li	gp,4
   10222:	67c1                	lui	a5,0x10
   10224:	f017879b          	addw	a5,a5,-255 # ff01 <exit-0x1e7>
   10228:	07c2                	sll	a5,a5,0x10
   1022a:	f0178793          	add	a5,a5,-255
   1022e:	07c2                	sll	a5,a5,0x10
   10230:	f0178793          	add	a5,a5,-255
   10234:	07b2                	sll	a5,a5,0xc
   10236:	17c1                	add	a5,a5,-16
   10238:	00001097          	auipc	ra,0x1
   1023c:	48808093          	add	ra,ra,1160 # 116c0 <__DATA_BEGIN__>
   10240:	0100b703          	ld	a4,16(ra)
   10244:	63c1                	lui	t2,0x10
   10246:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   1024a:	03c2                	sll	t2,t2,0x10
   1024c:	f0138393          	add	t2,t2,-255
   10250:	03c2                	sll	t2,t2,0x10
   10252:	f0138393          	add	t2,t2,-255
   10256:	03b2                	sll	t2,t2,0xc
   10258:	13c1                	add	t2,t2,-16
   1025a:	18771463          	bne	a4,t2,103e2 <fail>

000000000001025e <test_5>:
   1025e:	4195                	li	gp,5
   10260:	77c1                	lui	a5,0xffff0
   10262:	0ff7879b          	addw	a5,a5,255 # ffffffffffff00ff <__BSS_END__+0xfffffffffffde227>
   10266:	07c2                	sll	a5,a5,0x10
   10268:	0ff78793          	add	a5,a5,255
   1026c:	07c2                	sll	a5,a5,0x10
   1026e:	0ff78793          	add	a5,a5,255
   10272:	07b2                	sll	a5,a5,0xc
   10274:	07bd                	add	a5,a5,15
   10276:	00001097          	auipc	ra,0x1
   1027a:	44a08093          	add	ra,ra,1098 # 116c0 <__DATA_BEGIN__>
   1027e:	0180b703          	ld	a4,24(ra)
   10282:	73c1                	lui	t2,0xffff0
   10284:	0ff3839b          	addw	t2,t2,255 # ffffffffffff00ff <__BSS_END__+0xfffffffffffde227>
   10288:	03c2                	sll	t2,t2,0x10
   1028a:	0ff38393          	add	t2,t2,255
   1028e:	03c2                	sll	t2,t2,0x10
   10290:	0ff38393          	add	t2,t2,255
   10294:	03b2                	sll	t2,t2,0xc
   10296:	03bd                	add	t2,t2,15
   10298:	14771563          	bne	a4,t2,103e2 <fail>

000000000001029c <test_6>:
   1029c:	4199                	li	gp,6
   1029e:	00ff07b7          	lui	a5,0xff0
   102a2:	0ff7879b          	addw	a5,a5,255 # ff00ff <__BSS_END__+0xfde227>
   102a6:	07c2                	sll	a5,a5,0x10
   102a8:	0ff78793          	add	a5,a5,255
   102ac:	07c2                	sll	a5,a5,0x10
   102ae:	0ff78793          	add	a5,a5,255
   102b2:	00001097          	auipc	ra,0x1
   102b6:	42608093          	add	ra,ra,1062 # 116d8 <tdat4>
   102ba:	fe80b703          	ld	a4,-24(ra)
   102be:	00ff03b7          	lui	t2,0xff0
   102c2:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde227>
   102c6:	03c2                	sll	t2,t2,0x10
   102c8:	0ff38393          	add	t2,t2,255
   102cc:	03c2                	sll	t2,t2,0x10
   102ce:	0ff38393          	add	t2,t2,255
   102d2:	10771863          	bne	a4,t2,103e2 <fail>

00000000000102d6 <test_7>:
   102d6:	419d                	li	gp,7
   102d8:	ff0107b7          	lui	a5,0xff010
   102dc:	f017879b          	addw	a5,a5,-255 # ffffffffff00ff01 <__BSS_END__+0xfffffffffeffe029>
   102e0:	07c2                	sll	a5,a5,0x10
   102e2:	f0178793          	add	a5,a5,-255
   102e6:	07c2                	sll	a5,a5,0x10
   102e8:	f0078793          	add	a5,a5,-256
   102ec:	00001097          	auipc	ra,0x1
   102f0:	3ec08093          	add	ra,ra,1004 # 116d8 <tdat4>
   102f4:	ff00b703          	ld	a4,-16(ra)
   102f8:	ff0103b7          	lui	t2,0xff010
   102fc:	f013839b          	addw	t2,t2,-255 # ffffffffff00ff01 <__BSS_END__+0xfffffffffeffe029>
   10300:	03c2                	sll	t2,t2,0x10
   10302:	f0138393          	add	t2,t2,-255
   10306:	03c2                	sll	t2,t2,0x10
   10308:	f0038393          	add	t2,t2,-256
   1030c:	0c771b63          	bne	a4,t2,103e2 <fail>

0000000000010310 <test_8>:
   10310:	41a1                	li	gp,8
   10312:	67c1                	lui	a5,0x10
   10314:	f017879b          	addw	a5,a5,-255 # ff01 <exit-0x1e7>
   10318:	07c2                	sll	a5,a5,0x10
   1031a:	f0178793          	add	a5,a5,-255
   1031e:	07c2                	sll	a5,a5,0x10
   10320:	f0178793          	add	a5,a5,-255
   10324:	07b2                	sll	a5,a5,0xc
   10326:	17c1                	add	a5,a5,-16
   10328:	00001097          	auipc	ra,0x1
   1032c:	3b008093          	add	ra,ra,944 # 116d8 <tdat4>
   10330:	ff80b703          	ld	a4,-8(ra)
   10334:	63c1                	lui	t2,0x10
   10336:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   1033a:	03c2                	sll	t2,t2,0x10
   1033c:	f0138393          	add	t2,t2,-255
   10340:	03c2                	sll	t2,t2,0x10
   10342:	f0138393          	add	t2,t2,-255
   10346:	03b2                	sll	t2,t2,0xc
   10348:	13c1                	add	t2,t2,-16
   1034a:	08771c63          	bne	a4,t2,103e2 <fail>

000000000001034e <test_9>:
   1034e:	41a5                	li	gp,9
   10350:	77c1                	lui	a5,0xffff0
   10352:	0ff7879b          	addw	a5,a5,255 # ffffffffffff00ff <__BSS_END__+0xfffffffffffde227>
   10356:	07c2                	sll	a5,a5,0x10
   10358:	0ff78793          	add	a5,a5,255
   1035c:	07c2                	sll	a5,a5,0x10
   1035e:	0ff78793          	add	a5,a5,255
   10362:	07b2                	sll	a5,a5,0xc
   10364:	07bd                	add	a5,a5,15
   10366:	00001097          	auipc	ra,0x1
   1036a:	37208093          	add	ra,ra,882 # 116d8 <tdat4>
   1036e:	0000b703          	ld	a4,0(ra)
   10372:	73c1                	lui	t2,0xffff0
   10374:	0ff3839b          	addw	t2,t2,255 # ffffffffffff00ff <__BSS_END__+0xfffffffffffde227>
   10378:	03c2                	sll	t2,t2,0x10
   1037a:	0ff38393          	add	t2,t2,255
   1037e:	03c2                	sll	t2,t2,0x10
   10380:	0ff38393          	add	t2,t2,255
   10384:	03b2                	sll	t2,t2,0xc
   10386:	03bd                	add	t2,t2,15
   10388:	04771d63          	bne	a4,t2,103e2 <fail>

000000000001038c <test_10>:
   1038c:	41a9                	li	gp,10
   1038e:	00001097          	auipc	ra,0x1
   10392:	33208093          	add	ra,ra,818 # 116c0 <__DATA_BEGIN__>
   10396:	1081                	add	ra,ra,-32
   10398:	0200b283          	ld	t0,32(ra)
   1039c:	00ff03b7          	lui	t2,0xff0
   103a0:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde227>
   103a4:	03c2                	sll	t2,t2,0x10
   103a6:	0ff38393          	add	t2,t2,255
   103aa:	03c2                	sll	t2,t2,0x10
   103ac:	0ff38393          	add	t2,t2,255
   103b0:	02729963          	bne	t0,t2,103e2 <fail>

00000000000103b4 <test_11>:
   103b4:	41ad                	li	gp,11
   103b6:	00001097          	auipc	ra,0x1
   103ba:	30a08093          	add	ra,ra,778 # 116c0 <__DATA_BEGIN__>
   103be:	10f5                	add	ra,ra,-3
   103c0:	00b0b283          	ld	t0,11(ra)
   103c4:	ff0103b7          	lui	t2,0xff010
   103c8:	f013839b          	addw	t2,t2,-255 # ffffffffff00ff01 <__BSS_END__+0xfffffffffeffe029>
   103cc:	03c2                	sll	t2,t2,0x10
   103ce:	f0138393          	add	t2,t2,-255
   103d2:	03c2                	sll	t2,t2,0x10
   103d4:	f0038393          	add	t2,t2,-256
   103d8:	00729563          	bne	t0,t2,103e2 <fail>
   103dc:	00301263          	bne	zero,gp,103e0 <pass>

00000000000103e0 <pass>:
   103e0:	a019                	j	103e6 <continue>

00000000000103e2 <fail>:
   103e2:	00000000          	.word	0x00000000

00000000000103e6 <continue>:
   103e6:	4081                	li	ra,0
   103e8:	4781                	li	a5,0
   103ea:	853e                	mv	a0,a5
   103ec:	6462                	ld	s0,24(sp)
   103ee:	6105                	add	sp,sp,32
   103f0:	8082                	ret

00000000000103f2 <__libc_init_array>:
   103f2:	1101                	add	sp,sp,-32
   103f4:	e822                	sd	s0,16(sp)
   103f6:	67c5                	lui	a5,0x11
   103f8:	6445                	lui	s0,0x11
   103fa:	e04a                	sd	s2,0(sp)
   103fc:	6a878793          	add	a5,a5,1704 # 116a8 <__init_array_start>
   10400:	6a840713          	add	a4,s0,1704 # 116a8 <__init_array_start>
   10404:	ec06                	sd	ra,24(sp)
   10406:	e426                	sd	s1,8(sp)
   10408:	40e78933          	sub	s2,a5,a4
   1040c:	00e78d63          	beq	a5,a4,10426 <__libc_init_array+0x34>
   10410:	40395913          	sra	s2,s2,0x3
   10414:	6a840413          	add	s0,s0,1704
   10418:	4481                	li	s1,0
   1041a:	601c                	ld	a5,0(s0)
   1041c:	0485                	add	s1,s1,1
   1041e:	0421                	add	s0,s0,8
   10420:	9782                	jalr	a5
   10422:	ff24ece3          	bltu	s1,s2,1041a <__libc_init_array+0x28>
   10426:	6445                	lui	s0,0x11
   10428:	67c5                	lui	a5,0x11
   1042a:	6b878793          	add	a5,a5,1720 # 116b8 <__do_global_dtors_aux_fini_array_entry>
   1042e:	6a840713          	add	a4,s0,1704 # 116a8 <__init_array_start>
   10432:	40e78933          	sub	s2,a5,a4
   10436:	40395913          	sra	s2,s2,0x3
   1043a:	00e78b63          	beq	a5,a4,10450 <__libc_init_array+0x5e>
   1043e:	6a840413          	add	s0,s0,1704
   10442:	4481                	li	s1,0
   10444:	601c                	ld	a5,0(s0)
   10446:	0485                	add	s1,s1,1
   10448:	0421                	add	s0,s0,8
   1044a:	9782                	jalr	a5
   1044c:	ff24ece3          	bltu	s1,s2,10444 <__libc_init_array+0x52>
   10450:	60e2                	ld	ra,24(sp)
   10452:	6442                	ld	s0,16(sp)
   10454:	64a2                	ld	s1,8(sp)
   10456:	6902                	ld	s2,0(sp)
   10458:	6105                	add	sp,sp,32
   1045a:	8082                	ret

000000000001045c <memset>:
   1045c:	433d                	li	t1,15
   1045e:	872a                	mv	a4,a0
   10460:	02c37163          	bgeu	t1,a2,10482 <memset+0x26>
   10464:	00f77793          	and	a5,a4,15
   10468:	e3c1                	bnez	a5,104e8 <memset+0x8c>
   1046a:	e1bd                	bnez	a1,104d0 <memset+0x74>
   1046c:	ff067693          	and	a3,a2,-16
   10470:	8a3d                	and	a2,a2,15
   10472:	96ba                	add	a3,a3,a4
   10474:	e30c                	sd	a1,0(a4)
   10476:	e70c                	sd	a1,8(a4)
   10478:	0741                	add	a4,a4,16
   1047a:	fed76de3          	bltu	a4,a3,10474 <memset+0x18>
   1047e:	e211                	bnez	a2,10482 <memset+0x26>
   10480:	8082                	ret
   10482:	40c306b3          	sub	a3,t1,a2
   10486:	068a                	sll	a3,a3,0x2
   10488:	00000297          	auipc	t0,0x0
   1048c:	9696                	add	a3,a3,t0
   1048e:	00a68067          	jr	10(a3)
   10492:	00b70723          	sb	a1,14(a4)
   10496:	00b706a3          	sb	a1,13(a4)
   1049a:	00b70623          	sb	a1,12(a4)
   1049e:	00b705a3          	sb	a1,11(a4)
   104a2:	00b70523          	sb	a1,10(a4)
   104a6:	00b704a3          	sb	a1,9(a4)
   104aa:	00b70423          	sb	a1,8(a4)
   104ae:	00b703a3          	sb	a1,7(a4)
   104b2:	00b70323          	sb	a1,6(a4)
   104b6:	00b702a3          	sb	a1,5(a4)
   104ba:	00b70223          	sb	a1,4(a4)
   104be:	00b701a3          	sb	a1,3(a4)
   104c2:	00b70123          	sb	a1,2(a4)
   104c6:	00b700a3          	sb	a1,1(a4)
   104ca:	00b70023          	sb	a1,0(a4)
   104ce:	8082                	ret
   104d0:	0ff5f593          	zext.b	a1,a1
   104d4:	00859693          	sll	a3,a1,0x8
   104d8:	8dd5                	or	a1,a1,a3
   104da:	01059693          	sll	a3,a1,0x10
   104de:	8dd5                	or	a1,a1,a3
   104e0:	02059693          	sll	a3,a1,0x20
   104e4:	8dd5                	or	a1,a1,a3
   104e6:	b759                	j	1046c <memset+0x10>
   104e8:	00279693          	sll	a3,a5,0x2
   104ec:	00000297          	auipc	t0,0x0
   104f0:	9696                	add	a3,a3,t0
   104f2:	8286                	mv	t0,ra
   104f4:	fa2680e7          	jalr	-94(a3)
   104f8:	8096                	mv	ra,t0
   104fa:	17c1                	add	a5,a5,-16
   104fc:	8f1d                	sub	a4,a4,a5
   104fe:	963e                	add	a2,a2,a5
   10500:	f8c371e3          	bgeu	t1,a2,10482 <memset+0x26>
   10504:	b79d                	j	1046a <memset+0xe>

0000000000010506 <__call_exitprocs>:
   10506:	715d                	add	sp,sp,-80
   10508:	f052                	sd	s4,32(sp)
   1050a:	fc81ba03          	ld	s4,-56(gp) # 11e88 <_global_impure_ptr>
   1050e:	f84a                	sd	s2,48(sp)
   10510:	e486                	sd	ra,72(sp)
   10512:	1f8a3903          	ld	s2,504(s4)
   10516:	e0a2                	sd	s0,64(sp)
   10518:	fc26                	sd	s1,56(sp)
   1051a:	f44e                	sd	s3,40(sp)
   1051c:	ec56                	sd	s5,24(sp)
   1051e:	e85a                	sd	s6,16(sp)
   10520:	e45e                	sd	s7,8(sp)
   10522:	e062                	sd	s8,0(sp)
   10524:	02090863          	beqz	s2,10554 <__call_exitprocs+0x4e>
   10528:	8b2a                	mv	s6,a0
   1052a:	8bae                	mv	s7,a1
   1052c:	4a85                	li	s5,1
   1052e:	59fd                	li	s3,-1
   10530:	00892483          	lw	s1,8(s2)
   10534:	fff4841b          	addw	s0,s1,-1
   10538:	00044e63          	bltz	s0,10554 <__call_exitprocs+0x4e>
   1053c:	048e                	sll	s1,s1,0x3
   1053e:	94ca                	add	s1,s1,s2
   10540:	020b8663          	beqz	s7,1056c <__call_exitprocs+0x66>
   10544:	2084b783          	ld	a5,520(s1)
   10548:	03778263          	beq	a5,s7,1056c <__call_exitprocs+0x66>
   1054c:	347d                	addw	s0,s0,-1
   1054e:	14e1                	add	s1,s1,-8
   10550:	ff3418e3          	bne	s0,s3,10540 <__call_exitprocs+0x3a>
   10554:	60a6                	ld	ra,72(sp)
   10556:	6406                	ld	s0,64(sp)
   10558:	74e2                	ld	s1,56(sp)
   1055a:	7942                	ld	s2,48(sp)
   1055c:	79a2                	ld	s3,40(sp)
   1055e:	7a02                	ld	s4,32(sp)
   10560:	6ae2                	ld	s5,24(sp)
   10562:	6b42                	ld	s6,16(sp)
   10564:	6ba2                	ld	s7,8(sp)
   10566:	6c02                	ld	s8,0(sp)
   10568:	6161                	add	sp,sp,80
   1056a:	8082                	ret
   1056c:	00892783          	lw	a5,8(s2)
   10570:	6498                	ld	a4,8(s1)
   10572:	37fd                	addw	a5,a5,-1
   10574:	04878463          	beq	a5,s0,105bc <__call_exitprocs+0xb6>
   10578:	0004b423          	sd	zero,8(s1)
   1057c:	db61                	beqz	a4,1054c <__call_exitprocs+0x46>
   1057e:	31092783          	lw	a5,784(s2)
   10582:	008a96bb          	sllw	a3,s5,s0
   10586:	00892c03          	lw	s8,8(s2)
   1058a:	8ff5                	and	a5,a5,a3
   1058c:	2781                	sext.w	a5,a5
   1058e:	ef89                	bnez	a5,105a8 <__call_exitprocs+0xa2>
   10590:	9702                	jalr	a4
   10592:	00892703          	lw	a4,8(s2)
   10596:	1f8a3783          	ld	a5,504(s4)
   1059a:	01871463          	bne	a4,s8,105a2 <__call_exitprocs+0x9c>
   1059e:	fb2787e3          	beq	a5,s2,1054c <__call_exitprocs+0x46>
   105a2:	dbcd                	beqz	a5,10554 <__call_exitprocs+0x4e>
   105a4:	893e                	mv	s2,a5
   105a6:	b769                	j	10530 <__call_exitprocs+0x2a>
   105a8:	31492783          	lw	a5,788(s2)
   105ac:	1084b583          	ld	a1,264(s1)
   105b0:	8ff5                	and	a5,a5,a3
   105b2:	2781                	sext.w	a5,a5
   105b4:	e799                	bnez	a5,105c2 <__call_exitprocs+0xbc>
   105b6:	855a                	mv	a0,s6
   105b8:	9702                	jalr	a4
   105ba:	bfe1                	j	10592 <__call_exitprocs+0x8c>
   105bc:	00892423          	sw	s0,8(s2)
   105c0:	bf75                	j	1057c <__call_exitprocs+0x76>
   105c2:	852e                	mv	a0,a1
   105c4:	9702                	jalr	a4
   105c6:	b7f1                	j	10592 <__call_exitprocs+0x8c>

00000000000105c8 <__libc_fini_array>:
   105c8:	1101                	add	sp,sp,-32
   105ca:	e822                	sd	s0,16(sp)
   105cc:	67c5                	lui	a5,0x11
   105ce:	6445                	lui	s0,0x11
   105d0:	6b878793          	add	a5,a5,1720 # 116b8 <__do_global_dtors_aux_fini_array_entry>
   105d4:	6c040413          	add	s0,s0,1728 # 116c0 <__DATA_BEGIN__>
   105d8:	8c1d                	sub	s0,s0,a5
   105da:	e426                	sd	s1,8(sp)
   105dc:	ec06                	sd	ra,24(sp)
   105de:	40345493          	sra	s1,s0,0x3
   105e2:	c881                	beqz	s1,105f2 <__libc_fini_array+0x2a>
   105e4:	1461                	add	s0,s0,-8
   105e6:	943e                	add	s0,s0,a5
   105e8:	601c                	ld	a5,0(s0)
   105ea:	14fd                	add	s1,s1,-1
   105ec:	1461                	add	s0,s0,-8
   105ee:	9782                	jalr	a5
   105f0:	fce5                	bnez	s1,105e8 <__libc_fini_array+0x20>
   105f2:	60e2                	ld	ra,24(sp)
   105f4:	6442                	ld	s0,16(sp)
   105f6:	64a2                	ld	s1,8(sp)
   105f8:	6105                	add	sp,sp,32
   105fa:	8082                	ret

00000000000105fc <atexit>:
   105fc:	85aa                	mv	a1,a0
   105fe:	4681                	li	a3,0
   10600:	4601                	li	a2,0
   10602:	4501                	li	a0,0
   10604:	a009                	j	10606 <__register_exitproc>

0000000000010606 <__register_exitproc>:
   10606:	fc81b703          	ld	a4,-56(gp) # 11e88 <_global_impure_ptr>
   1060a:	1f873783          	ld	a5,504(a4)
   1060e:	c3b1                	beqz	a5,10652 <__register_exitproc+0x4c>
   10610:	4798                	lw	a4,8(a5)
   10612:	487d                	li	a6,31
   10614:	06e84263          	blt	a6,a4,10678 <__register_exitproc+0x72>
   10618:	c505                	beqz	a0,10640 <__register_exitproc+0x3a>
   1061a:	00371813          	sll	a6,a4,0x3
   1061e:	983e                	add	a6,a6,a5
   10620:	10c83823          	sd	a2,272(a6)
   10624:	3107a883          	lw	a7,784(a5)
   10628:	4605                	li	a2,1
   1062a:	00e6163b          	sllw	a2,a2,a4
   1062e:	00c8e8b3          	or	a7,a7,a2
   10632:	3117a823          	sw	a7,784(a5)
   10636:	20d83823          	sd	a3,528(a6)
   1063a:	4689                	li	a3,2
   1063c:	02d50063          	beq	a0,a3,1065c <__register_exitproc+0x56>
   10640:	00270693          	add	a3,a4,2
   10644:	068e                	sll	a3,a3,0x3
   10646:	2705                	addw	a4,a4,1
   10648:	c798                	sw	a4,8(a5)
   1064a:	97b6                	add	a5,a5,a3
   1064c:	e38c                	sd	a1,0(a5)
   1064e:	4501                	li	a0,0
   10650:	8082                	ret
   10652:	20070793          	add	a5,a4,512
   10656:	1ef73c23          	sd	a5,504(a4)
   1065a:	bf5d                	j	10610 <__register_exitproc+0xa>
   1065c:	3147a683          	lw	a3,788(a5)
   10660:	4501                	li	a0,0
   10662:	8ed1                	or	a3,a3,a2
   10664:	30d7aa23          	sw	a3,788(a5)
   10668:	00270693          	add	a3,a4,2
   1066c:	068e                	sll	a3,a3,0x3
   1066e:	2705                	addw	a4,a4,1
   10670:	c798                	sw	a4,8(a5)
   10672:	97b6                	add	a5,a5,a3
   10674:	e38c                	sd	a1,0(a5)
   10676:	8082                	ret
   10678:	557d                	li	a0,-1
   1067a:	8082                	ret

000000000001067c <_exit>:
   1067c:	05d00893          	li	a7,93
   10680:	00000073          	ecall
   10684:	00054363          	bltz	a0,1068a <_exit+0xe>
   10688:	a001                	j	10688 <_exit+0xc>
   1068a:	1141                	add	sp,sp,-16
   1068c:	e022                	sd	s0,0(sp)
   1068e:	842a                	mv	s0,a0
   10690:	e406                	sd	ra,8(sp)
   10692:	4080043b          	negw	s0,s0
   10696:	008000ef          	jal	1069e <__errno>
   1069a:	c100                	sw	s0,0(a0)
   1069c:	a001                	j	1069c <_exit+0x20>

000000000001069e <__errno>:
   1069e:	fd81b503          	ld	a0,-40(gp) # 11e98 <_impure_ptr>
   106a2:	8082                	ret
