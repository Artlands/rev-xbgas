
addiw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2f0000ef          	jal	103e2 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11ce8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	456000ef          	jal	10558 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4a450513          	add	a0,a0,1188 # 104a4 <__libc_fini_array>
   10112:	a6d9                	j	104d8 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c8a18193          	add	gp,gp,-886 # 11da0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d00 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d38 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	20e000ef          	jal	10338 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3aa50513          	add	a0,a0,938 # 104d8 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36c50513          	add	a0,a0,876 # 104a4 <__libc_fini_array>
   10140:	398000ef          	jal	104d8 <atexit>
   10144:	18a000ef          	jal	102ce <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d00 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d00 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d08 <object.0>
   1018e:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	0000871b          	sext.w	a4,ra
   101b4:	4381                	li	t2,0
   101b6:	10771463          	bne	a4,t2,102be <fail>

00000000000101ba <test_3>:
   101ba:	418d                	li	gp,3
   101bc:	4085                	li	ra,1
   101be:	0010871b          	addw	a4,ra,1 # 1016d <__do_global_dtors_aux+0x19>
   101c2:	4389                	li	t2,2
   101c4:	0e771d63          	bne	a4,t2,102be <fail>

00000000000101c8 <test_4>:
   101c8:	4191                	li	gp,4
   101ca:	408d                	li	ra,3
   101cc:	0070871b          	addw	a4,ra,7
   101d0:	43a9                	li	t2,10
   101d2:	0e771663          	bne	a4,t2,102be <fail>

00000000000101d6 <test_5>:
   101d6:	4195                	li	gp,5
   101d8:	4081                	li	ra,0
   101da:	8000871b          	addw	a4,ra,-2048
   101de:	80000393          	li	t2,-2048
   101e2:	0c771e63          	bne	a4,t2,102be <fail>

00000000000101e6 <test_6>:
   101e6:	4199                	li	gp,6
   101e8:	800000b7          	lui	ra,0x80000
   101ec:	0000871b          	sext.w	a4,ra
   101f0:	800003b7          	lui	t2,0x80000
   101f4:	0c771563          	bne	a4,t2,102be <fail>

00000000000101f8 <test_7>:
   101f8:	419d                	li	gp,7
   101fa:	800000b7          	lui	ra,0x80000
   101fe:	8000871b          	addw	a4,ra,-2048 # 7ffff800 <__global_pointer$+0x7ffeda60>
   10202:	800003b7          	lui	t2,0x80000
   10206:	8003839b          	addw	t2,t2,-2048 # 7ffff800 <__global_pointer$+0x7ffeda60>
   1020a:	0a771a63          	bne	a4,t2,102be <fail>

000000000001020e <test_8>:
   1020e:	41a1                	li	gp,8
   10210:	4081                	li	ra,0
   10212:	7ff0871b          	addw	a4,ra,2047
   10216:	7ff00393          	li	t2,2047
   1021a:	0a771263          	bne	a4,t2,102be <fail>

000000000001021e <test_9>:
   1021e:	41a5                	li	gp,9
   10220:	800000b7          	lui	ra,0x80000
   10224:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   10226:	0000871b          	sext.w	a4,ra
   1022a:	800003b7          	lui	t2,0x80000
   1022e:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   10230:	08771763          	bne	a4,t2,102be <fail>

0000000000010234 <test_10>:
   10234:	41a9                	li	gp,10
   10236:	800000b7          	lui	ra,0x80000
   1023a:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   1023c:	7ff0871b          	addw	a4,ra,2047
   10240:	800003b7          	lui	t2,0x80000
   10244:	7fe3839b          	addw	t2,t2,2046 # ffffffff800007fe <__global_pointer$+0xffffffff7ffeea5e>
   10248:	06771b63          	bne	a4,t2,102be <fail>

000000000001024c <test_11>:
   1024c:	41ad                	li	gp,11
   1024e:	800000b7          	lui	ra,0x80000
   10252:	7ff0871b          	addw	a4,ra,2047 # ffffffff800007ff <__global_pointer$+0xffffffff7ffeea5f>
   10256:	800003b7          	lui	t2,0x80000
   1025a:	7ff3839b          	addw	t2,t2,2047 # ffffffff800007ff <__global_pointer$+0xffffffff7ffeea5f>
   1025e:	06771063          	bne	a4,t2,102be <fail>

0000000000010262 <test_12>:
   10262:	41b1                	li	gp,12
   10264:	800000b7          	lui	ra,0x80000
   10268:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   1026a:	8000871b          	addw	a4,ra,-2048
   1026e:	7ffff3b7          	lui	t2,0x7ffff
   10272:	7ff3839b          	addw	t2,t2,2047 # 7ffff7ff <__global_pointer$+0x7ffeda5f>
   10276:	04771463          	bne	a4,t2,102be <fail>

000000000001027a <test_13>:
   1027a:	41b5                	li	gp,13
   1027c:	4081                	li	ra,0
   1027e:	fff0871b          	addw	a4,ra,-1
   10282:	53fd                	li	t2,-1
   10284:	02771d63          	bne	a4,t2,102be <fail>

0000000000010288 <test_14>:
   10288:	41b9                	li	gp,14
   1028a:	50fd                	li	ra,-1
   1028c:	0010871b          	addw	a4,ra,1
   10290:	4381                	li	t2,0
   10292:	02771663          	bne	a4,t2,102be <fail>

0000000000010296 <test_15>:
   10296:	41bd                	li	gp,15
   10298:	50fd                	li	ra,-1
   1029a:	fff0871b          	addw	a4,ra,-1
   1029e:	53f9                	li	t2,-2
   102a0:	00771f63          	bne	a4,t2,102be <fail>

00000000000102a4 <test_16>:
   102a4:	41c1                	li	gp,16
   102a6:	800000b7          	lui	ra,0x80000
   102aa:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   102ac:	0010871b          	addw	a4,ra,1
   102b0:	800003b7          	lui	t2,0x80000
   102b4:	00771563          	bne	a4,t2,102be <fail>
   102b8:	00301263          	bne	zero,gp,102bc <pass>

00000000000102bc <pass>:
   102bc:	a019                	j	102c2 <continue>

00000000000102be <fail>:
   102be:	00000000          	.word	0x00000000

00000000000102c2 <continue>:
   102c2:	4081                	li	ra,0
   102c4:	4781                	li	a5,0
   102c6:	853e                	mv	a0,a5
   102c8:	6462                	ld	s0,24(sp)
   102ca:	6105                	add	sp,sp,32
   102cc:	8082                	ret

00000000000102ce <__libc_init_array>:
   102ce:	1101                	add	sp,sp,-32
   102d0:	e822                	sd	s0,16(sp)
   102d2:	67c5                	lui	a5,0x11
   102d4:	6445                	lui	s0,0x11
   102d6:	e04a                	sd	s2,0(sp)
   102d8:	58478793          	add	a5,a5,1412 # 11584 <__preinit_array_end>
   102dc:	58440713          	add	a4,s0,1412 # 11584 <__preinit_array_end>
   102e0:	ec06                	sd	ra,24(sp)
   102e2:	e426                	sd	s1,8(sp)
   102e4:	40e78933          	sub	s2,a5,a4
   102e8:	00e78d63          	beq	a5,a4,10302 <__libc_init_array+0x34>
   102ec:	40395913          	sra	s2,s2,0x3
   102f0:	58440413          	add	s0,s0,1412
   102f4:	4481                	li	s1,0
   102f6:	601c                	ld	a5,0(s0)
   102f8:	0485                	add	s1,s1,1
   102fa:	0421                	add	s0,s0,8
   102fc:	9782                	jalr	a5
   102fe:	ff24ece3          	bltu	s1,s2,102f6 <__libc_init_array+0x28>
   10302:	6445                	lui	s0,0x11
   10304:	67c5                	lui	a5,0x11
   10306:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   1030a:	58840713          	add	a4,s0,1416 # 11588 <__init_array_start>
   1030e:	40e78933          	sub	s2,a5,a4
   10312:	40395913          	sra	s2,s2,0x3
   10316:	00e78b63          	beq	a5,a4,1032c <__libc_init_array+0x5e>
   1031a:	58840413          	add	s0,s0,1416
   1031e:	4481                	li	s1,0
   10320:	601c                	ld	a5,0(s0)
   10322:	0485                	add	s1,s1,1
   10324:	0421                	add	s0,s0,8
   10326:	9782                	jalr	a5
   10328:	ff24ece3          	bltu	s1,s2,10320 <__libc_init_array+0x52>
   1032c:	60e2                	ld	ra,24(sp)
   1032e:	6442                	ld	s0,16(sp)
   10330:	64a2                	ld	s1,8(sp)
   10332:	6902                	ld	s2,0(sp)
   10334:	6105                	add	sp,sp,32
   10336:	8082                	ret

0000000000010338 <memset>:
   10338:	433d                	li	t1,15
   1033a:	872a                	mv	a4,a0
   1033c:	02c37163          	bgeu	t1,a2,1035e <memset+0x26>
   10340:	00f77793          	and	a5,a4,15
   10344:	e3c1                	bnez	a5,103c4 <memset+0x8c>
   10346:	e1bd                	bnez	a1,103ac <memset+0x74>
   10348:	ff067693          	and	a3,a2,-16
   1034c:	8a3d                	and	a2,a2,15
   1034e:	96ba                	add	a3,a3,a4
   10350:	e30c                	sd	a1,0(a4)
   10352:	e70c                	sd	a1,8(a4)
   10354:	0741                	add	a4,a4,16
   10356:	fed76de3          	bltu	a4,a3,10350 <memset+0x18>
   1035a:	e211                	bnez	a2,1035e <memset+0x26>
   1035c:	8082                	ret
   1035e:	40c306b3          	sub	a3,t1,a2
   10362:	068a                	sll	a3,a3,0x2
   10364:	00000297          	auipc	t0,0x0
   10368:	9696                	add	a3,a3,t0
   1036a:	00a68067          	jr	10(a3)
   1036e:	00b70723          	sb	a1,14(a4)
   10372:	00b706a3          	sb	a1,13(a4)
   10376:	00b70623          	sb	a1,12(a4)
   1037a:	00b705a3          	sb	a1,11(a4)
   1037e:	00b70523          	sb	a1,10(a4)
   10382:	00b704a3          	sb	a1,9(a4)
   10386:	00b70423          	sb	a1,8(a4)
   1038a:	00b703a3          	sb	a1,7(a4)
   1038e:	00b70323          	sb	a1,6(a4)
   10392:	00b702a3          	sb	a1,5(a4)
   10396:	00b70223          	sb	a1,4(a4)
   1039a:	00b701a3          	sb	a1,3(a4)
   1039e:	00b70123          	sb	a1,2(a4)
   103a2:	00b700a3          	sb	a1,1(a4)
   103a6:	00b70023          	sb	a1,0(a4)
   103aa:	8082                	ret
   103ac:	0ff5f593          	zext.b	a1,a1
   103b0:	00859693          	sll	a3,a1,0x8
   103b4:	8dd5                	or	a1,a1,a3
   103b6:	01059693          	sll	a3,a1,0x10
   103ba:	8dd5                	or	a1,a1,a3
   103bc:	02059693          	sll	a3,a1,0x20
   103c0:	8dd5                	or	a1,a1,a3
   103c2:	b759                	j	10348 <memset+0x10>
   103c4:	00279693          	sll	a3,a5,0x2
   103c8:	00000297          	auipc	t0,0x0
   103cc:	9696                	add	a3,a3,t0
   103ce:	8286                	mv	t0,ra
   103d0:	fa2680e7          	jalr	-94(a3)
   103d4:	8096                	mv	ra,t0
   103d6:	17c1                	add	a5,a5,-16
   103d8:	8f1d                	sub	a4,a4,a5
   103da:	963e                	add	a2,a2,a5
   103dc:	f8c371e3          	bgeu	t1,a2,1035e <memset+0x26>
   103e0:	b79d                	j	10346 <memset+0xe>

00000000000103e2 <__call_exitprocs>:
   103e2:	715d                	add	sp,sp,-80
   103e4:	f052                	sd	s4,32(sp)
   103e6:	f481ba03          	ld	s4,-184(gp) # 11ce8 <_global_impure_ptr>
   103ea:	f84a                	sd	s2,48(sp)
   103ec:	e486                	sd	ra,72(sp)
   103ee:	1f8a3903          	ld	s2,504(s4)
   103f2:	e0a2                	sd	s0,64(sp)
   103f4:	fc26                	sd	s1,56(sp)
   103f6:	f44e                	sd	s3,40(sp)
   103f8:	ec56                	sd	s5,24(sp)
   103fa:	e85a                	sd	s6,16(sp)
   103fc:	e45e                	sd	s7,8(sp)
   103fe:	e062                	sd	s8,0(sp)
   10400:	02090863          	beqz	s2,10430 <__call_exitprocs+0x4e>
   10404:	8b2a                	mv	s6,a0
   10406:	8bae                	mv	s7,a1
   10408:	4a85                	li	s5,1
   1040a:	59fd                	li	s3,-1
   1040c:	00892483          	lw	s1,8(s2)
   10410:	fff4841b          	addw	s0,s1,-1
   10414:	00044e63          	bltz	s0,10430 <__call_exitprocs+0x4e>
   10418:	048e                	sll	s1,s1,0x3
   1041a:	94ca                	add	s1,s1,s2
   1041c:	020b8663          	beqz	s7,10448 <__call_exitprocs+0x66>
   10420:	2084b783          	ld	a5,520(s1)
   10424:	03778263          	beq	a5,s7,10448 <__call_exitprocs+0x66>
   10428:	347d                	addw	s0,s0,-1
   1042a:	14e1                	add	s1,s1,-8
   1042c:	ff3418e3          	bne	s0,s3,1041c <__call_exitprocs+0x3a>
   10430:	60a6                	ld	ra,72(sp)
   10432:	6406                	ld	s0,64(sp)
   10434:	74e2                	ld	s1,56(sp)
   10436:	7942                	ld	s2,48(sp)
   10438:	79a2                	ld	s3,40(sp)
   1043a:	7a02                	ld	s4,32(sp)
   1043c:	6ae2                	ld	s5,24(sp)
   1043e:	6b42                	ld	s6,16(sp)
   10440:	6ba2                	ld	s7,8(sp)
   10442:	6c02                	ld	s8,0(sp)
   10444:	6161                	add	sp,sp,80
   10446:	8082                	ret
   10448:	00892783          	lw	a5,8(s2)
   1044c:	6498                	ld	a4,8(s1)
   1044e:	37fd                	addw	a5,a5,-1
   10450:	04878463          	beq	a5,s0,10498 <__call_exitprocs+0xb6>
   10454:	0004b423          	sd	zero,8(s1)
   10458:	db61                	beqz	a4,10428 <__call_exitprocs+0x46>
   1045a:	31092783          	lw	a5,784(s2)
   1045e:	008a96bb          	sllw	a3,s5,s0
   10462:	00892c03          	lw	s8,8(s2)
   10466:	8ff5                	and	a5,a5,a3
   10468:	2781                	sext.w	a5,a5
   1046a:	ef89                	bnez	a5,10484 <__call_exitprocs+0xa2>
   1046c:	9702                	jalr	a4
   1046e:	00892703          	lw	a4,8(s2)
   10472:	1f8a3783          	ld	a5,504(s4)
   10476:	01871463          	bne	a4,s8,1047e <__call_exitprocs+0x9c>
   1047a:	fb2787e3          	beq	a5,s2,10428 <__call_exitprocs+0x46>
   1047e:	dbcd                	beqz	a5,10430 <__call_exitprocs+0x4e>
   10480:	893e                	mv	s2,a5
   10482:	b769                	j	1040c <__call_exitprocs+0x2a>
   10484:	31492783          	lw	a5,788(s2)
   10488:	1084b583          	ld	a1,264(s1)
   1048c:	8ff5                	and	a5,a5,a3
   1048e:	2781                	sext.w	a5,a5
   10490:	e799                	bnez	a5,1049e <__call_exitprocs+0xbc>
   10492:	855a                	mv	a0,s6
   10494:	9702                	jalr	a4
   10496:	bfe1                	j	1046e <__call_exitprocs+0x8c>
   10498:	00892423          	sw	s0,8(s2)
   1049c:	bf75                	j	10458 <__call_exitprocs+0x76>
   1049e:	852e                	mv	a0,a1
   104a0:	9702                	jalr	a4
   104a2:	b7f1                	j	1046e <__call_exitprocs+0x8c>

00000000000104a4 <__libc_fini_array>:
   104a4:	1101                	add	sp,sp,-32
   104a6:	e822                	sd	s0,16(sp)
   104a8:	67c5                	lui	a5,0x11
   104aa:	6445                	lui	s0,0x11
   104ac:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   104b0:	5a040413          	add	s0,s0,1440 # 115a0 <impure_data>
   104b4:	8c1d                	sub	s0,s0,a5
   104b6:	e426                	sd	s1,8(sp)
   104b8:	ec06                	sd	ra,24(sp)
   104ba:	40345493          	sra	s1,s0,0x3
   104be:	c881                	beqz	s1,104ce <__libc_fini_array+0x2a>
   104c0:	1461                	add	s0,s0,-8
   104c2:	943e                	add	s0,s0,a5
   104c4:	601c                	ld	a5,0(s0)
   104c6:	14fd                	add	s1,s1,-1
   104c8:	1461                	add	s0,s0,-8
   104ca:	9782                	jalr	a5
   104cc:	fce5                	bnez	s1,104c4 <__libc_fini_array+0x20>
   104ce:	60e2                	ld	ra,24(sp)
   104d0:	6442                	ld	s0,16(sp)
   104d2:	64a2                	ld	s1,8(sp)
   104d4:	6105                	add	sp,sp,32
   104d6:	8082                	ret

00000000000104d8 <atexit>:
   104d8:	85aa                	mv	a1,a0
   104da:	4681                	li	a3,0
   104dc:	4601                	li	a2,0
   104de:	4501                	li	a0,0
   104e0:	a009                	j	104e2 <__register_exitproc>

00000000000104e2 <__register_exitproc>:
   104e2:	f481b703          	ld	a4,-184(gp) # 11ce8 <_global_impure_ptr>
   104e6:	1f873783          	ld	a5,504(a4)
   104ea:	c3b1                	beqz	a5,1052e <__register_exitproc+0x4c>
   104ec:	4798                	lw	a4,8(a5)
   104ee:	487d                	li	a6,31
   104f0:	06e84263          	blt	a6,a4,10554 <__register_exitproc+0x72>
   104f4:	c505                	beqz	a0,1051c <__register_exitproc+0x3a>
   104f6:	00371813          	sll	a6,a4,0x3
   104fa:	983e                	add	a6,a6,a5
   104fc:	10c83823          	sd	a2,272(a6)
   10500:	3107a883          	lw	a7,784(a5)
   10504:	4605                	li	a2,1
   10506:	00e6163b          	sllw	a2,a2,a4
   1050a:	00c8e8b3          	or	a7,a7,a2
   1050e:	3117a823          	sw	a7,784(a5)
   10512:	20d83823          	sd	a3,528(a6)
   10516:	4689                	li	a3,2
   10518:	02d50063          	beq	a0,a3,10538 <__register_exitproc+0x56>
   1051c:	00270693          	add	a3,a4,2
   10520:	068e                	sll	a3,a3,0x3
   10522:	2705                	addw	a4,a4,1
   10524:	c798                	sw	a4,8(a5)
   10526:	97b6                	add	a5,a5,a3
   10528:	e38c                	sd	a1,0(a5)
   1052a:	4501                	li	a0,0
   1052c:	8082                	ret
   1052e:	20070793          	add	a5,a4,512
   10532:	1ef73c23          	sd	a5,504(a4)
   10536:	bf5d                	j	104ec <__register_exitproc+0xa>
   10538:	3147a683          	lw	a3,788(a5)
   1053c:	4501                	li	a0,0
   1053e:	8ed1                	or	a3,a3,a2
   10540:	30d7aa23          	sw	a3,788(a5)
   10544:	00270693          	add	a3,a4,2
   10548:	068e                	sll	a3,a3,0x3
   1054a:	2705                	addw	a4,a4,1
   1054c:	c798                	sw	a4,8(a5)
   1054e:	97b6                	add	a5,a5,a3
   10550:	e38c                	sd	a1,0(a5)
   10552:	8082                	ret
   10554:	557d                	li	a0,-1
   10556:	8082                	ret

0000000000010558 <_exit>:
   10558:	05d00893          	li	a7,93
   1055c:	00000073          	ecall
   10560:	00054363          	bltz	a0,10566 <_exit+0xe>
   10564:	a001                	j	10564 <_exit+0xc>
   10566:	1141                	add	sp,sp,-16
   10568:	e022                	sd	s0,0(sp)
   1056a:	842a                	mv	s0,a0
   1056c:	e406                	sd	ra,8(sp)
   1056e:	4080043b          	negw	s0,s0
   10572:	008000ef          	jal	1057a <__errno>
   10576:	c100                	sw	s0,0(a0)
   10578:	a001                	j	10578 <_exit+0x20>

000000000001057a <__errno>:
   1057a:	f581b503          	ld	a0,-168(gp) # 11cf8 <_impure_ptr>
   1057e:	8082                	ret

srli.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	32e000ef          	jal	10420 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d28 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	494000ef          	jal	10596 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4e250513          	add	a0,a0,1250 # 104e2 <__libc_fini_array>
   10112:	a111                	j	10516 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cca18193          	add	gp,gp,-822 # 11de0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d40 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d78 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	24c000ef          	jal	10376 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3e850513          	add	a0,a0,1000 # 10516 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3aa50513          	add	a0,a0,938 # 104e2 <__libc_fini_array>
   10140:	3d6000ef          	jal	10516 <atexit>
   10144:	1c8000ef          	jal	1030c <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d40 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5c050513          	add	a0,a0,1472 # 115c0 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d40 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d48 <object.0>
   1018e:	5c050513          	add	a0,a0,1472 # 115c0 <__EH_FRAME_BEGIN__>
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
   101ae:	800000b7          	lui	ra,0x80000
   101b2:	0000d713          	srl	a4,ra,0x0
   101b6:	800003b7          	lui	t2,0x80000
   101ba:	14771163          	bne	a4,t2,102fc <fail>

00000000000101be <test_3>:
   101be:	418d                	li	gp,3
   101c0:	800000b7          	lui	ra,0x80000
   101c4:	0010d713          	srl	a4,ra,0x1
   101c8:	0010039b          	addw	t2,zero,1
   101cc:	1386                	sll	t2,t2,0x21
   101ce:	13fd                	add	t2,t2,-1 # ffffffff7fffffff <__global_pointer$+0xffffffff7ffee21f>
   101d0:	03fa                	sll	t2,t2,0x1e
   101d2:	12771563          	bne	a4,t2,102fc <fail>

00000000000101d6 <test_4>:
   101d6:	4191                	li	gp,4
   101d8:	800000b7          	lui	ra,0x80000
   101dc:	0070d713          	srl	a4,ra,0x7
   101e0:	0010039b          	addw	t2,zero,1
   101e4:	1386                	sll	t2,t2,0x21
   101e6:	13fd                	add	t2,t2,-1
   101e8:	03e2                	sll	t2,t2,0x18
   101ea:	10771963          	bne	a4,t2,102fc <fail>

00000000000101ee <test_5>:
   101ee:	4195                	li	gp,5
   101f0:	800000b7          	lui	ra,0x80000
   101f4:	00e0d713          	srl	a4,ra,0xe
   101f8:	0010039b          	addw	t2,zero,1
   101fc:	1386                	sll	t2,t2,0x21
   101fe:	13fd                	add	t2,t2,-1
   10200:	03c6                	sll	t2,t2,0x11
   10202:	0e771d63          	bne	a4,t2,102fc <fail>

0000000000010206 <test_6>:
   10206:	4199                	li	gp,6
   10208:	800000b7          	lui	ra,0x80000
   1020c:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee221>
   1020e:	01f0d713          	srl	a4,ra,0x1f
   10212:	0010039b          	addw	t2,zero,1
   10216:	1386                	sll	t2,t2,0x21
   10218:	13fd                	add	t2,t2,-1
   1021a:	0e771163          	bne	a4,t2,102fc <fail>

000000000001021e <test_7>:
   1021e:	419d                	li	gp,7
   10220:	50fd                	li	ra,-1
   10222:	0000d713          	srl	a4,ra,0x0
   10226:	53fd                	li	t2,-1
   10228:	0c771a63          	bne	a4,t2,102fc <fail>

000000000001022c <test_8>:
   1022c:	41a1                	li	gp,8
   1022e:	50fd                	li	ra,-1
   10230:	0010d713          	srl	a4,ra,0x1
   10234:	fff0039b          	addw	t2,zero,-1
   10238:	13fe                	sll	t2,t2,0x3f
   1023a:	13fd                	add	t2,t2,-1
   1023c:	0c771063          	bne	a4,t2,102fc <fail>

0000000000010240 <test_9>:
   10240:	41a5                	li	gp,9
   10242:	50fd                	li	ra,-1
   10244:	0070d713          	srl	a4,ra,0x7
   10248:	0010039b          	addw	t2,zero,1
   1024c:	13e6                	sll	t2,t2,0x39
   1024e:	13fd                	add	t2,t2,-1
   10250:	0a771663          	bne	a4,t2,102fc <fail>

0000000000010254 <test_10>:
   10254:	41a9                	li	gp,10
   10256:	50fd                	li	ra,-1
   10258:	00e0d713          	srl	a4,ra,0xe
   1025c:	0010039b          	addw	t2,zero,1
   10260:	13ca                	sll	t2,t2,0x32
   10262:	13fd                	add	t2,t2,-1
   10264:	08771c63          	bne	a4,t2,102fc <fail>

0000000000010268 <test_11>:
   10268:	41ad                	li	gp,11
   1026a:	50fd                	li	ra,-1
   1026c:	01f0d713          	srl	a4,ra,0x1f
   10270:	0010039b          	addw	t2,zero,1
   10274:	1386                	sll	t2,t2,0x21
   10276:	13fd                	add	t2,t2,-1
   10278:	08771263          	bne	a4,t2,102fc <fail>

000000000001027c <test_12>:
   1027c:	41b1                	li	gp,12
   1027e:	212120b7          	lui	ra,0x21212
   10282:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200341>
   10286:	0000d713          	srl	a4,ra,0x0
   1028a:	212123b7          	lui	t2,0x21212
   1028e:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200341>
   10292:	06771563          	bne	a4,t2,102fc <fail>

0000000000010296 <test_13>:
   10296:	41b5                	li	gp,13
   10298:	212120b7          	lui	ra,0x21212
   1029c:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200341>
   102a0:	0010d713          	srl	a4,ra,0x1
   102a4:	109093b7          	lui	t2,0x10909
   102a8:	0903839b          	addw	t2,t2,144 # 10909090 <__global_pointer$+0x108f72b0>
   102ac:	04771863          	bne	a4,t2,102fc <fail>

00000000000102b0 <test_14>:
   102b0:	41b9                	li	gp,14
   102b2:	212120b7          	lui	ra,0x21212
   102b6:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200341>
   102ba:	0070d713          	srl	a4,ra,0x7
   102be:	004243b7          	lui	t2,0x424
   102c2:	2423839b          	addw	t2,t2,578 # 424242 <__global_pointer$+0x412462>
   102c6:	02771b63          	bne	a4,t2,102fc <fail>

00000000000102ca <test_15>:
   102ca:	41bd                	li	gp,15
   102cc:	212120b7          	lui	ra,0x21212
   102d0:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200341>
   102d4:	00e0d713          	srl	a4,ra,0xe
   102d8:	63a1                	lui	t2,0x8
   102da:	4843839b          	addw	t2,t2,1156 # 8484 <exit-0x7c64>
   102de:	00771f63          	bne	a4,t2,102fc <fail>

00000000000102e2 <test_16>:
   102e2:	41c1                	li	gp,16
   102e4:	212120b7          	lui	ra,0x21212
   102e8:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200341>
   102ec:	01f0d713          	srl	a4,ra,0x1f
   102f0:	4381                	li	t2,0
   102f2:	00771563          	bne	a4,t2,102fc <fail>
   102f6:	00301263          	bne	zero,gp,102fa <pass>

00000000000102fa <pass>:
   102fa:	a019                	j	10300 <continue>

00000000000102fc <fail>:
   102fc:	00000000          	.word	0x00000000

0000000000010300 <continue>:
   10300:	4081                	li	ra,0
   10302:	4781                	li	a5,0
   10304:	853e                	mv	a0,a5
   10306:	6462                	ld	s0,24(sp)
   10308:	6105                	add	sp,sp,32
   1030a:	8082                	ret

000000000001030c <__libc_init_array>:
   1030c:	1101                	add	sp,sp,-32
   1030e:	e822                	sd	s0,16(sp)
   10310:	67c5                	lui	a5,0x11
   10312:	6445                	lui	s0,0x11
   10314:	e04a                	sd	s2,0(sp)
   10316:	5c478793          	add	a5,a5,1476 # 115c4 <__preinit_array_end>
   1031a:	5c440713          	add	a4,s0,1476 # 115c4 <__preinit_array_end>
   1031e:	ec06                	sd	ra,24(sp)
   10320:	e426                	sd	s1,8(sp)
   10322:	40e78933          	sub	s2,a5,a4
   10326:	00e78d63          	beq	a5,a4,10340 <__libc_init_array+0x34>
   1032a:	40395913          	sra	s2,s2,0x3
   1032e:	5c440413          	add	s0,s0,1476
   10332:	4481                	li	s1,0
   10334:	601c                	ld	a5,0(s0)
   10336:	0485                	add	s1,s1,1
   10338:	0421                	add	s0,s0,8
   1033a:	9782                	jalr	a5
   1033c:	ff24ece3          	bltu	s1,s2,10334 <__libc_init_array+0x28>
   10340:	6445                	lui	s0,0x11
   10342:	67c5                	lui	a5,0x11
   10344:	5d878793          	add	a5,a5,1496 # 115d8 <__do_global_dtors_aux_fini_array_entry>
   10348:	5c840713          	add	a4,s0,1480 # 115c8 <__init_array_start>
   1034c:	40e78933          	sub	s2,a5,a4
   10350:	40395913          	sra	s2,s2,0x3
   10354:	00e78b63          	beq	a5,a4,1036a <__libc_init_array+0x5e>
   10358:	5c840413          	add	s0,s0,1480
   1035c:	4481                	li	s1,0
   1035e:	601c                	ld	a5,0(s0)
   10360:	0485                	add	s1,s1,1
   10362:	0421                	add	s0,s0,8
   10364:	9782                	jalr	a5
   10366:	ff24ece3          	bltu	s1,s2,1035e <__libc_init_array+0x52>
   1036a:	60e2                	ld	ra,24(sp)
   1036c:	6442                	ld	s0,16(sp)
   1036e:	64a2                	ld	s1,8(sp)
   10370:	6902                	ld	s2,0(sp)
   10372:	6105                	add	sp,sp,32
   10374:	8082                	ret

0000000000010376 <memset>:
   10376:	433d                	li	t1,15
   10378:	872a                	mv	a4,a0
   1037a:	02c37163          	bgeu	t1,a2,1039c <memset+0x26>
   1037e:	00f77793          	and	a5,a4,15
   10382:	e3c1                	bnez	a5,10402 <memset+0x8c>
   10384:	e1bd                	bnez	a1,103ea <memset+0x74>
   10386:	ff067693          	and	a3,a2,-16
   1038a:	8a3d                	and	a2,a2,15
   1038c:	96ba                	add	a3,a3,a4
   1038e:	e30c                	sd	a1,0(a4)
   10390:	e70c                	sd	a1,8(a4)
   10392:	0741                	add	a4,a4,16
   10394:	fed76de3          	bltu	a4,a3,1038e <memset+0x18>
   10398:	e211                	bnez	a2,1039c <memset+0x26>
   1039a:	8082                	ret
   1039c:	40c306b3          	sub	a3,t1,a2
   103a0:	068a                	sll	a3,a3,0x2
   103a2:	00000297          	auipc	t0,0x0
   103a6:	9696                	add	a3,a3,t0
   103a8:	00a68067          	jr	10(a3)
   103ac:	00b70723          	sb	a1,14(a4)
   103b0:	00b706a3          	sb	a1,13(a4)
   103b4:	00b70623          	sb	a1,12(a4)
   103b8:	00b705a3          	sb	a1,11(a4)
   103bc:	00b70523          	sb	a1,10(a4)
   103c0:	00b704a3          	sb	a1,9(a4)
   103c4:	00b70423          	sb	a1,8(a4)
   103c8:	00b703a3          	sb	a1,7(a4)
   103cc:	00b70323          	sb	a1,6(a4)
   103d0:	00b702a3          	sb	a1,5(a4)
   103d4:	00b70223          	sb	a1,4(a4)
   103d8:	00b701a3          	sb	a1,3(a4)
   103dc:	00b70123          	sb	a1,2(a4)
   103e0:	00b700a3          	sb	a1,1(a4)
   103e4:	00b70023          	sb	a1,0(a4)
   103e8:	8082                	ret
   103ea:	0ff5f593          	zext.b	a1,a1
   103ee:	00859693          	sll	a3,a1,0x8
   103f2:	8dd5                	or	a1,a1,a3
   103f4:	01059693          	sll	a3,a1,0x10
   103f8:	8dd5                	or	a1,a1,a3
   103fa:	02059693          	sll	a3,a1,0x20
   103fe:	8dd5                	or	a1,a1,a3
   10400:	b759                	j	10386 <memset+0x10>
   10402:	00279693          	sll	a3,a5,0x2
   10406:	00000297          	auipc	t0,0x0
   1040a:	9696                	add	a3,a3,t0
   1040c:	8286                	mv	t0,ra
   1040e:	fa2680e7          	jalr	-94(a3)
   10412:	8096                	mv	ra,t0
   10414:	17c1                	add	a5,a5,-16
   10416:	8f1d                	sub	a4,a4,a5
   10418:	963e                	add	a2,a2,a5
   1041a:	f8c371e3          	bgeu	t1,a2,1039c <memset+0x26>
   1041e:	b79d                	j	10384 <memset+0xe>

0000000000010420 <__call_exitprocs>:
   10420:	715d                	add	sp,sp,-80
   10422:	f052                	sd	s4,32(sp)
   10424:	f481ba03          	ld	s4,-184(gp) # 11d28 <_global_impure_ptr>
   10428:	f84a                	sd	s2,48(sp)
   1042a:	e486                	sd	ra,72(sp)
   1042c:	1f8a3903          	ld	s2,504(s4)
   10430:	e0a2                	sd	s0,64(sp)
   10432:	fc26                	sd	s1,56(sp)
   10434:	f44e                	sd	s3,40(sp)
   10436:	ec56                	sd	s5,24(sp)
   10438:	e85a                	sd	s6,16(sp)
   1043a:	e45e                	sd	s7,8(sp)
   1043c:	e062                	sd	s8,0(sp)
   1043e:	02090863          	beqz	s2,1046e <__call_exitprocs+0x4e>
   10442:	8b2a                	mv	s6,a0
   10444:	8bae                	mv	s7,a1
   10446:	4a85                	li	s5,1
   10448:	59fd                	li	s3,-1
   1044a:	00892483          	lw	s1,8(s2)
   1044e:	fff4841b          	addw	s0,s1,-1
   10452:	00044e63          	bltz	s0,1046e <__call_exitprocs+0x4e>
   10456:	048e                	sll	s1,s1,0x3
   10458:	94ca                	add	s1,s1,s2
   1045a:	020b8663          	beqz	s7,10486 <__call_exitprocs+0x66>
   1045e:	2084b783          	ld	a5,520(s1)
   10462:	03778263          	beq	a5,s7,10486 <__call_exitprocs+0x66>
   10466:	347d                	addw	s0,s0,-1
   10468:	14e1                	add	s1,s1,-8
   1046a:	ff3418e3          	bne	s0,s3,1045a <__call_exitprocs+0x3a>
   1046e:	60a6                	ld	ra,72(sp)
   10470:	6406                	ld	s0,64(sp)
   10472:	74e2                	ld	s1,56(sp)
   10474:	7942                	ld	s2,48(sp)
   10476:	79a2                	ld	s3,40(sp)
   10478:	7a02                	ld	s4,32(sp)
   1047a:	6ae2                	ld	s5,24(sp)
   1047c:	6b42                	ld	s6,16(sp)
   1047e:	6ba2                	ld	s7,8(sp)
   10480:	6c02                	ld	s8,0(sp)
   10482:	6161                	add	sp,sp,80
   10484:	8082                	ret
   10486:	00892783          	lw	a5,8(s2)
   1048a:	6498                	ld	a4,8(s1)
   1048c:	37fd                	addw	a5,a5,-1
   1048e:	04878463          	beq	a5,s0,104d6 <__call_exitprocs+0xb6>
   10492:	0004b423          	sd	zero,8(s1)
   10496:	db61                	beqz	a4,10466 <__call_exitprocs+0x46>
   10498:	31092783          	lw	a5,784(s2)
   1049c:	008a96bb          	sllw	a3,s5,s0
   104a0:	00892c03          	lw	s8,8(s2)
   104a4:	8ff5                	and	a5,a5,a3
   104a6:	2781                	sext.w	a5,a5
   104a8:	ef89                	bnez	a5,104c2 <__call_exitprocs+0xa2>
   104aa:	9702                	jalr	a4
   104ac:	00892703          	lw	a4,8(s2)
   104b0:	1f8a3783          	ld	a5,504(s4)
   104b4:	01871463          	bne	a4,s8,104bc <__call_exitprocs+0x9c>
   104b8:	fb2787e3          	beq	a5,s2,10466 <__call_exitprocs+0x46>
   104bc:	dbcd                	beqz	a5,1046e <__call_exitprocs+0x4e>
   104be:	893e                	mv	s2,a5
   104c0:	b769                	j	1044a <__call_exitprocs+0x2a>
   104c2:	31492783          	lw	a5,788(s2)
   104c6:	1084b583          	ld	a1,264(s1)
   104ca:	8ff5                	and	a5,a5,a3
   104cc:	2781                	sext.w	a5,a5
   104ce:	e799                	bnez	a5,104dc <__call_exitprocs+0xbc>
   104d0:	855a                	mv	a0,s6
   104d2:	9702                	jalr	a4
   104d4:	bfe1                	j	104ac <__call_exitprocs+0x8c>
   104d6:	00892423          	sw	s0,8(s2)
   104da:	bf75                	j	10496 <__call_exitprocs+0x76>
   104dc:	852e                	mv	a0,a1
   104de:	9702                	jalr	a4
   104e0:	b7f1                	j	104ac <__call_exitprocs+0x8c>

00000000000104e2 <__libc_fini_array>:
   104e2:	1101                	add	sp,sp,-32
   104e4:	e822                	sd	s0,16(sp)
   104e6:	67c5                	lui	a5,0x11
   104e8:	6445                	lui	s0,0x11
   104ea:	5d878793          	add	a5,a5,1496 # 115d8 <__do_global_dtors_aux_fini_array_entry>
   104ee:	5e040413          	add	s0,s0,1504 # 115e0 <impure_data>
   104f2:	8c1d                	sub	s0,s0,a5
   104f4:	e426                	sd	s1,8(sp)
   104f6:	ec06                	sd	ra,24(sp)
   104f8:	40345493          	sra	s1,s0,0x3
   104fc:	c881                	beqz	s1,1050c <__libc_fini_array+0x2a>
   104fe:	1461                	add	s0,s0,-8
   10500:	943e                	add	s0,s0,a5
   10502:	601c                	ld	a5,0(s0)
   10504:	14fd                	add	s1,s1,-1
   10506:	1461                	add	s0,s0,-8
   10508:	9782                	jalr	a5
   1050a:	fce5                	bnez	s1,10502 <__libc_fini_array+0x20>
   1050c:	60e2                	ld	ra,24(sp)
   1050e:	6442                	ld	s0,16(sp)
   10510:	64a2                	ld	s1,8(sp)
   10512:	6105                	add	sp,sp,32
   10514:	8082                	ret

0000000000010516 <atexit>:
   10516:	85aa                	mv	a1,a0
   10518:	4681                	li	a3,0
   1051a:	4601                	li	a2,0
   1051c:	4501                	li	a0,0
   1051e:	a009                	j	10520 <__register_exitproc>

0000000000010520 <__register_exitproc>:
   10520:	f481b703          	ld	a4,-184(gp) # 11d28 <_global_impure_ptr>
   10524:	1f873783          	ld	a5,504(a4)
   10528:	c3b1                	beqz	a5,1056c <__register_exitproc+0x4c>
   1052a:	4798                	lw	a4,8(a5)
   1052c:	487d                	li	a6,31
   1052e:	06e84263          	blt	a6,a4,10592 <__register_exitproc+0x72>
   10532:	c505                	beqz	a0,1055a <__register_exitproc+0x3a>
   10534:	00371813          	sll	a6,a4,0x3
   10538:	983e                	add	a6,a6,a5
   1053a:	10c83823          	sd	a2,272(a6)
   1053e:	3107a883          	lw	a7,784(a5)
   10542:	4605                	li	a2,1
   10544:	00e6163b          	sllw	a2,a2,a4
   10548:	00c8e8b3          	or	a7,a7,a2
   1054c:	3117a823          	sw	a7,784(a5)
   10550:	20d83823          	sd	a3,528(a6)
   10554:	4689                	li	a3,2
   10556:	02d50063          	beq	a0,a3,10576 <__register_exitproc+0x56>
   1055a:	00270693          	add	a3,a4,2
   1055e:	068e                	sll	a3,a3,0x3
   10560:	2705                	addw	a4,a4,1
   10562:	c798                	sw	a4,8(a5)
   10564:	97b6                	add	a5,a5,a3
   10566:	e38c                	sd	a1,0(a5)
   10568:	4501                	li	a0,0
   1056a:	8082                	ret
   1056c:	20070793          	add	a5,a4,512
   10570:	1ef73c23          	sd	a5,504(a4)
   10574:	bf5d                	j	1052a <__register_exitproc+0xa>
   10576:	3147a683          	lw	a3,788(a5)
   1057a:	4501                	li	a0,0
   1057c:	8ed1                	or	a3,a3,a2
   1057e:	30d7aa23          	sw	a3,788(a5)
   10582:	00270693          	add	a3,a4,2
   10586:	068e                	sll	a3,a3,0x3
   10588:	2705                	addw	a4,a4,1
   1058a:	c798                	sw	a4,8(a5)
   1058c:	97b6                	add	a5,a5,a3
   1058e:	e38c                	sd	a1,0(a5)
   10590:	8082                	ret
   10592:	557d                	li	a0,-1
   10594:	8082                	ret

0000000000010596 <_exit>:
   10596:	05d00893          	li	a7,93
   1059a:	00000073          	ecall
   1059e:	00054363          	bltz	a0,105a4 <_exit+0xe>
   105a2:	a001                	j	105a2 <_exit+0xc>
   105a4:	1141                	add	sp,sp,-16
   105a6:	e022                	sd	s0,0(sp)
   105a8:	842a                	mv	s0,a0
   105aa:	e406                	sd	ra,8(sp)
   105ac:	4080043b          	negw	s0,s0
   105b0:	008000ef          	jal	105b8 <__errno>
   105b4:	c100                	sw	s0,0(a0)
   105b6:	a001                	j	105b6 <_exit+0x20>

00000000000105b8 <__errno>:
   105b8:	f581b503          	ld	a0,-168(gp) # 11d38 <_impure_ptr>
   105bc:	8082                	ret

xori.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	25c000ef          	jal	1034e <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11c50 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	3c2000ef          	jal	104c4 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	41050513          	add	a0,a0,1040 # 10410 <__libc_fini_array>
   10112:	ae0d                	j	10444 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	bf218193          	add	gp,gp,-1038 # 11d08 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11c68 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11ca0 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	17a000ef          	jal	102a4 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	31650513          	add	a0,a0,790 # 10444 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	2d850513          	add	a0,a0,728 # 10410 <__libc_fini_array>
   10140:	304000ef          	jal	10444 <atexit>
   10144:	0f6000ef          	jal	1023a <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11c68 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	4ec50513          	add	a0,a0,1260 # 114ec <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11c68 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11c70 <object.0>
   1018e:	4ec50513          	add	a0,a0,1260 # 114ec <__EH_FRAME_BEGIN__>
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
   101ae:	00ff10b7          	lui	ra,0xff1
   101b2:	f000809b          	addw	ra,ra,-256 # ff0f00 <__global_pointer$+0xfdf1f8>
   101b6:	f0f0c713          	xor	a4,ra,-241
   101ba:	ff00f3b7          	lui	t2,0xff00f
   101be:	23bd                	addw	t2,t2,15 # ffffffffff00f00f <__global_pointer$+0xfffffffffeffd307>
   101c0:	06771563          	bne	a4,t2,1022a <fail>

00000000000101c4 <test_3>:
   101c4:	418d                	li	gp,3
   101c6:	0ff010b7          	lui	ra,0xff01
   101ca:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef2e8>
   101cc:	0f00c713          	xor	a4,ra,240
   101d0:	0ff013b7          	lui	t2,0xff01
   101d4:	f003839b          	addw	t2,t2,-256 # ff00f00 <__global_pointer$+0xfeef1f8>
   101d8:	04771963          	bne	a4,t2,1022a <fail>

00000000000101dc <test_4>:
   101dc:	4191                	li	gp,4
   101de:	00ff10b7          	lui	ra,0xff1
   101e2:	8ff0809b          	addw	ra,ra,-1793 # ff08ff <__global_pointer$+0xfdebf7>
   101e6:	70f0c713          	xor	a4,ra,1807
   101ea:	00ff13b7          	lui	t2,0xff1
   101ee:	33c1                	addw	t2,t2,-16 # ff0ff0 <__global_pointer$+0xfdf2e8>
   101f0:	02771d63          	bne	a4,t2,1022a <fail>

00000000000101f4 <test_5>:
   101f4:	4195                	li	gp,5
   101f6:	f00ff0b7          	lui	ra,0xf00ff
   101fa:	20bd                	addw	ra,ra,15 # fffffffff00ff00f <__global_pointer$+0xfffffffff00ed307>
   101fc:	0f00c713          	xor	a4,ra,240
   10200:	f00ff3b7          	lui	t2,0xf00ff
   10204:	0ff3839b          	addw	t2,t2,255 # fffffffff00ff0ff <__global_pointer$+0xfffffffff00ed3f7>
   10208:	02771163          	bne	a4,t2,1022a <fail>

000000000001020c <test_6>:
   1020c:	4199                	li	gp,6
   1020e:	ff00f0b7          	lui	ra,0xff00f
   10212:	7000809b          	addw	ra,ra,1792 # ffffffffff00f700 <__global_pointer$+0xfffffffffeffd9f8>
   10216:	70f0c093          	xor	ra,ra,1807
   1021a:	ff00f3b7          	lui	t2,0xff00f
   1021e:	23bd                	addw	t2,t2,15 # ffffffffff00f00f <__global_pointer$+0xfffffffffeffd307>
   10220:	00709563          	bne	ra,t2,1022a <fail>
   10224:	00301263          	bne	zero,gp,10228 <pass>

0000000000010228 <pass>:
   10228:	a019                	j	1022e <continue>

000000000001022a <fail>:
   1022a:	00000000          	.word	0x00000000

000000000001022e <continue>:
   1022e:	4081                	li	ra,0
   10230:	4781                	li	a5,0
   10232:	853e                	mv	a0,a5
   10234:	6462                	ld	s0,24(sp)
   10236:	6105                	add	sp,sp,32
   10238:	8082                	ret

000000000001023a <__libc_init_array>:
   1023a:	1101                	add	sp,sp,-32
   1023c:	e822                	sd	s0,16(sp)
   1023e:	67c5                	lui	a5,0x11
   10240:	6445                	lui	s0,0x11
   10242:	e04a                	sd	s2,0(sp)
   10244:	4f078793          	add	a5,a5,1264 # 114f0 <__init_array_start>
   10248:	4f040713          	add	a4,s0,1264 # 114f0 <__init_array_start>
   1024c:	ec06                	sd	ra,24(sp)
   1024e:	e426                	sd	s1,8(sp)
   10250:	40e78933          	sub	s2,a5,a4
   10254:	00e78d63          	beq	a5,a4,1026e <__libc_init_array+0x34>
   10258:	40395913          	sra	s2,s2,0x3
   1025c:	4f040413          	add	s0,s0,1264
   10260:	4481                	li	s1,0
   10262:	601c                	ld	a5,0(s0)
   10264:	0485                	add	s1,s1,1
   10266:	0421                	add	s0,s0,8
   10268:	9782                	jalr	a5
   1026a:	ff24ece3          	bltu	s1,s2,10262 <__libc_init_array+0x28>
   1026e:	6445                	lui	s0,0x11
   10270:	67c5                	lui	a5,0x11
   10272:	50078793          	add	a5,a5,1280 # 11500 <__do_global_dtors_aux_fini_array_entry>
   10276:	4f040713          	add	a4,s0,1264 # 114f0 <__init_array_start>
   1027a:	40e78933          	sub	s2,a5,a4
   1027e:	40395913          	sra	s2,s2,0x3
   10282:	00e78b63          	beq	a5,a4,10298 <__libc_init_array+0x5e>
   10286:	4f040413          	add	s0,s0,1264
   1028a:	4481                	li	s1,0
   1028c:	601c                	ld	a5,0(s0)
   1028e:	0485                	add	s1,s1,1
   10290:	0421                	add	s0,s0,8
   10292:	9782                	jalr	a5
   10294:	ff24ece3          	bltu	s1,s2,1028c <__libc_init_array+0x52>
   10298:	60e2                	ld	ra,24(sp)
   1029a:	6442                	ld	s0,16(sp)
   1029c:	64a2                	ld	s1,8(sp)
   1029e:	6902                	ld	s2,0(sp)
   102a0:	6105                	add	sp,sp,32
   102a2:	8082                	ret

00000000000102a4 <memset>:
   102a4:	433d                	li	t1,15
   102a6:	872a                	mv	a4,a0
   102a8:	02c37163          	bgeu	t1,a2,102ca <memset+0x26>
   102ac:	00f77793          	and	a5,a4,15
   102b0:	e3c1                	bnez	a5,10330 <memset+0x8c>
   102b2:	e1bd                	bnez	a1,10318 <memset+0x74>
   102b4:	ff067693          	and	a3,a2,-16
   102b8:	8a3d                	and	a2,a2,15
   102ba:	96ba                	add	a3,a3,a4
   102bc:	e30c                	sd	a1,0(a4)
   102be:	e70c                	sd	a1,8(a4)
   102c0:	0741                	add	a4,a4,16
   102c2:	fed76de3          	bltu	a4,a3,102bc <memset+0x18>
   102c6:	e211                	bnez	a2,102ca <memset+0x26>
   102c8:	8082                	ret
   102ca:	40c306b3          	sub	a3,t1,a2
   102ce:	068a                	sll	a3,a3,0x2
   102d0:	00000297          	auipc	t0,0x0
   102d4:	9696                	add	a3,a3,t0
   102d6:	00a68067          	jr	10(a3)
   102da:	00b70723          	sb	a1,14(a4)
   102de:	00b706a3          	sb	a1,13(a4)
   102e2:	00b70623          	sb	a1,12(a4)
   102e6:	00b705a3          	sb	a1,11(a4)
   102ea:	00b70523          	sb	a1,10(a4)
   102ee:	00b704a3          	sb	a1,9(a4)
   102f2:	00b70423          	sb	a1,8(a4)
   102f6:	00b703a3          	sb	a1,7(a4)
   102fa:	00b70323          	sb	a1,6(a4)
   102fe:	00b702a3          	sb	a1,5(a4)
   10302:	00b70223          	sb	a1,4(a4)
   10306:	00b701a3          	sb	a1,3(a4)
   1030a:	00b70123          	sb	a1,2(a4)
   1030e:	00b700a3          	sb	a1,1(a4)
   10312:	00b70023          	sb	a1,0(a4)
   10316:	8082                	ret
   10318:	0ff5f593          	zext.b	a1,a1
   1031c:	00859693          	sll	a3,a1,0x8
   10320:	8dd5                	or	a1,a1,a3
   10322:	01059693          	sll	a3,a1,0x10
   10326:	8dd5                	or	a1,a1,a3
   10328:	02059693          	sll	a3,a1,0x20
   1032c:	8dd5                	or	a1,a1,a3
   1032e:	b759                	j	102b4 <memset+0x10>
   10330:	00279693          	sll	a3,a5,0x2
   10334:	00000297          	auipc	t0,0x0
   10338:	9696                	add	a3,a3,t0
   1033a:	8286                	mv	t0,ra
   1033c:	fa2680e7          	jalr	-94(a3)
   10340:	8096                	mv	ra,t0
   10342:	17c1                	add	a5,a5,-16
   10344:	8f1d                	sub	a4,a4,a5
   10346:	963e                	add	a2,a2,a5
   10348:	f8c371e3          	bgeu	t1,a2,102ca <memset+0x26>
   1034c:	b79d                	j	102b2 <memset+0xe>

000000000001034e <__call_exitprocs>:
   1034e:	715d                	add	sp,sp,-80
   10350:	f052                	sd	s4,32(sp)
   10352:	f481ba03          	ld	s4,-184(gp) # 11c50 <_global_impure_ptr>
   10356:	f84a                	sd	s2,48(sp)
   10358:	e486                	sd	ra,72(sp)
   1035a:	1f8a3903          	ld	s2,504(s4)
   1035e:	e0a2                	sd	s0,64(sp)
   10360:	fc26                	sd	s1,56(sp)
   10362:	f44e                	sd	s3,40(sp)
   10364:	ec56                	sd	s5,24(sp)
   10366:	e85a                	sd	s6,16(sp)
   10368:	e45e                	sd	s7,8(sp)
   1036a:	e062                	sd	s8,0(sp)
   1036c:	02090863          	beqz	s2,1039c <__call_exitprocs+0x4e>
   10370:	8b2a                	mv	s6,a0
   10372:	8bae                	mv	s7,a1
   10374:	4a85                	li	s5,1
   10376:	59fd                	li	s3,-1
   10378:	00892483          	lw	s1,8(s2)
   1037c:	fff4841b          	addw	s0,s1,-1
   10380:	00044e63          	bltz	s0,1039c <__call_exitprocs+0x4e>
   10384:	048e                	sll	s1,s1,0x3
   10386:	94ca                	add	s1,s1,s2
   10388:	020b8663          	beqz	s7,103b4 <__call_exitprocs+0x66>
   1038c:	2084b783          	ld	a5,520(s1)
   10390:	03778263          	beq	a5,s7,103b4 <__call_exitprocs+0x66>
   10394:	347d                	addw	s0,s0,-1
   10396:	14e1                	add	s1,s1,-8
   10398:	ff3418e3          	bne	s0,s3,10388 <__call_exitprocs+0x3a>
   1039c:	60a6                	ld	ra,72(sp)
   1039e:	6406                	ld	s0,64(sp)
   103a0:	74e2                	ld	s1,56(sp)
   103a2:	7942                	ld	s2,48(sp)
   103a4:	79a2                	ld	s3,40(sp)
   103a6:	7a02                	ld	s4,32(sp)
   103a8:	6ae2                	ld	s5,24(sp)
   103aa:	6b42                	ld	s6,16(sp)
   103ac:	6ba2                	ld	s7,8(sp)
   103ae:	6c02                	ld	s8,0(sp)
   103b0:	6161                	add	sp,sp,80
   103b2:	8082                	ret
   103b4:	00892783          	lw	a5,8(s2)
   103b8:	6498                	ld	a4,8(s1)
   103ba:	37fd                	addw	a5,a5,-1
   103bc:	04878463          	beq	a5,s0,10404 <__call_exitprocs+0xb6>
   103c0:	0004b423          	sd	zero,8(s1)
   103c4:	db61                	beqz	a4,10394 <__call_exitprocs+0x46>
   103c6:	31092783          	lw	a5,784(s2)
   103ca:	008a96bb          	sllw	a3,s5,s0
   103ce:	00892c03          	lw	s8,8(s2)
   103d2:	8ff5                	and	a5,a5,a3
   103d4:	2781                	sext.w	a5,a5
   103d6:	ef89                	bnez	a5,103f0 <__call_exitprocs+0xa2>
   103d8:	9702                	jalr	a4
   103da:	00892703          	lw	a4,8(s2)
   103de:	1f8a3783          	ld	a5,504(s4)
   103e2:	01871463          	bne	a4,s8,103ea <__call_exitprocs+0x9c>
   103e6:	fb2787e3          	beq	a5,s2,10394 <__call_exitprocs+0x46>
   103ea:	dbcd                	beqz	a5,1039c <__call_exitprocs+0x4e>
   103ec:	893e                	mv	s2,a5
   103ee:	b769                	j	10378 <__call_exitprocs+0x2a>
   103f0:	31492783          	lw	a5,788(s2)
   103f4:	1084b583          	ld	a1,264(s1)
   103f8:	8ff5                	and	a5,a5,a3
   103fa:	2781                	sext.w	a5,a5
   103fc:	e799                	bnez	a5,1040a <__call_exitprocs+0xbc>
   103fe:	855a                	mv	a0,s6
   10400:	9702                	jalr	a4
   10402:	bfe1                	j	103da <__call_exitprocs+0x8c>
   10404:	00892423          	sw	s0,8(s2)
   10408:	bf75                	j	103c4 <__call_exitprocs+0x76>
   1040a:	852e                	mv	a0,a1
   1040c:	9702                	jalr	a4
   1040e:	b7f1                	j	103da <__call_exitprocs+0x8c>

0000000000010410 <__libc_fini_array>:
   10410:	1101                	add	sp,sp,-32
   10412:	e822                	sd	s0,16(sp)
   10414:	67c5                	lui	a5,0x11
   10416:	6445                	lui	s0,0x11
   10418:	50078793          	add	a5,a5,1280 # 11500 <__do_global_dtors_aux_fini_array_entry>
   1041c:	50840413          	add	s0,s0,1288 # 11508 <impure_data>
   10420:	8c1d                	sub	s0,s0,a5
   10422:	e426                	sd	s1,8(sp)
   10424:	ec06                	sd	ra,24(sp)
   10426:	40345493          	sra	s1,s0,0x3
   1042a:	c881                	beqz	s1,1043a <__libc_fini_array+0x2a>
   1042c:	1461                	add	s0,s0,-8
   1042e:	943e                	add	s0,s0,a5
   10430:	601c                	ld	a5,0(s0)
   10432:	14fd                	add	s1,s1,-1
   10434:	1461                	add	s0,s0,-8
   10436:	9782                	jalr	a5
   10438:	fce5                	bnez	s1,10430 <__libc_fini_array+0x20>
   1043a:	60e2                	ld	ra,24(sp)
   1043c:	6442                	ld	s0,16(sp)
   1043e:	64a2                	ld	s1,8(sp)
   10440:	6105                	add	sp,sp,32
   10442:	8082                	ret

0000000000010444 <atexit>:
   10444:	85aa                	mv	a1,a0
   10446:	4681                	li	a3,0
   10448:	4601                	li	a2,0
   1044a:	4501                	li	a0,0
   1044c:	a009                	j	1044e <__register_exitproc>

000000000001044e <__register_exitproc>:
   1044e:	f481b703          	ld	a4,-184(gp) # 11c50 <_global_impure_ptr>
   10452:	1f873783          	ld	a5,504(a4)
   10456:	c3b1                	beqz	a5,1049a <__register_exitproc+0x4c>
   10458:	4798                	lw	a4,8(a5)
   1045a:	487d                	li	a6,31
   1045c:	06e84263          	blt	a6,a4,104c0 <__register_exitproc+0x72>
   10460:	c505                	beqz	a0,10488 <__register_exitproc+0x3a>
   10462:	00371813          	sll	a6,a4,0x3
   10466:	983e                	add	a6,a6,a5
   10468:	10c83823          	sd	a2,272(a6)
   1046c:	3107a883          	lw	a7,784(a5)
   10470:	4605                	li	a2,1
   10472:	00e6163b          	sllw	a2,a2,a4
   10476:	00c8e8b3          	or	a7,a7,a2
   1047a:	3117a823          	sw	a7,784(a5)
   1047e:	20d83823          	sd	a3,528(a6)
   10482:	4689                	li	a3,2
   10484:	02d50063          	beq	a0,a3,104a4 <__register_exitproc+0x56>
   10488:	00270693          	add	a3,a4,2
   1048c:	068e                	sll	a3,a3,0x3
   1048e:	2705                	addw	a4,a4,1
   10490:	c798                	sw	a4,8(a5)
   10492:	97b6                	add	a5,a5,a3
   10494:	e38c                	sd	a1,0(a5)
   10496:	4501                	li	a0,0
   10498:	8082                	ret
   1049a:	20070793          	add	a5,a4,512
   1049e:	1ef73c23          	sd	a5,504(a4)
   104a2:	bf5d                	j	10458 <__register_exitproc+0xa>
   104a4:	3147a683          	lw	a3,788(a5)
   104a8:	4501                	li	a0,0
   104aa:	8ed1                	or	a3,a3,a2
   104ac:	30d7aa23          	sw	a3,788(a5)
   104b0:	00270693          	add	a3,a4,2
   104b4:	068e                	sll	a3,a3,0x3
   104b6:	2705                	addw	a4,a4,1
   104b8:	c798                	sw	a4,8(a5)
   104ba:	97b6                	add	a5,a5,a3
   104bc:	e38c                	sd	a1,0(a5)
   104be:	8082                	ret
   104c0:	557d                	li	a0,-1
   104c2:	8082                	ret

00000000000104c4 <_exit>:
   104c4:	05d00893          	li	a7,93
   104c8:	00000073          	ecall
   104cc:	00054363          	bltz	a0,104d2 <_exit+0xe>
   104d0:	a001                	j	104d0 <_exit+0xc>
   104d2:	1141                	add	sp,sp,-16
   104d4:	e022                	sd	s0,0(sp)
   104d6:	842a                	mv	s0,a0
   104d8:	e406                	sd	ra,8(sp)
   104da:	4080043b          	negw	s0,s0
   104de:	008000ef          	jal	104e6 <__errno>
   104e2:	c100                	sw	s0,0(a0)
   104e4:	a001                	j	104e4 <_exit+0x20>

00000000000104e6 <__errno>:
   104e6:	f581b503          	ld	a0,-168(gp) # 11c60 <_impure_ptr>
   104ea:	8082                	ret

fadd.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	416000ef          	jal	10508 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11e50 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	57c000ef          	jal	1067e <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	5ca50513          	add	a0,a0,1482 # 105ca <__libc_fini_array>
   10112:	a1f5                	j	105fe <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	df218193          	add	gp,gp,-526 # 11f08 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11e68 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11ea0 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	334000ef          	jal	1045e <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	4d050513          	add	a0,a0,1232 # 105fe <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	49250513          	add	a0,a0,1170 # 105ca <__libc_fini_array>
   10140:	4be000ef          	jal	105fe <atexit>
   10144:	2b0000ef          	jal	103f4 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11e68 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	6e850513          	add	a0,a0,1768 # 116e8 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11e68 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11e70 <object.0>
   1018e:	6e850513          	add	a0,a0,1768 # 116e8 <__EH_FRAME_BEGIN__>
   10192:	00000317          	auipc	t1,0x0
   10196:	00000067          	jr	zero # 0 <exit-0x100e8>
   1019a:	8082                	ret

000000000001019c <main>:
   1019c:	7179                	add	sp,sp,-48
   1019e:	f422                	sd	s0,40(sp)
   101a0:	1800                	add	s0,sp,48
   101a2:	87aa                	mv	a5,a0
   101a4:	fcb43823          	sd	a1,-48(s0)
   101a8:	fcf42e23          	sw	a5,-36(s0)
   101ac:	fe042623          	sw	zero,-20(s0)
   101b0:	fe042423          	sw	zero,-24(s0)
   101b4:	fe042223          	sw	zero,-28(s0)
   101b8:	fe042023          	sw	zero,-32(s0)
   101bc:	67c1                	lui	a5,0x10
   101be:	6a87a787          	flw	fa5,1704(a5) # 106a8 <__errno+0x8>
   101c2:	fef42627          	fsw	fa5,-20(s0)
   101c6:	67c1                	lui	a5,0x10
   101c8:	6ac7a787          	flw	fa5,1708(a5) # 106ac <__errno+0xc>
   101cc:	fef42427          	fsw	fa5,-24(s0)
   101d0:	fec42707          	flw	fa4,-20(s0)
   101d4:	fe842787          	flw	fa5,-24(s0)
   101d8:	00f777d3          	fadd.s	fa5,fa4,fa5
   101dc:	fef42227          	fsw	fa5,-28(s0)
   101e0:	67c1                	lui	a5,0x10
   101e2:	6b07a787          	flw	fa5,1712(a5) # 106b0 <__errno+0x10>
   101e6:	fef42027          	fsw	fa5,-32(s0)
   101ea:	fe042707          	flw	fa4,-32(s0)
   101ee:	fe442787          	flw	fa5,-28(s0)
   101f2:	a0f727d3          	feq.s	a5,fa4,fa5
   101f6:	e399                	bnez	a5,101fc <main+0x60>
   101f8:	0000                	unimp
   101fa:	0000                	unimp
   101fc:	67c1                	lui	a5,0x10
   101fe:	6b47a787          	flw	fa5,1716(a5) # 106b4 <__errno+0x14>
   10202:	fef42627          	fsw	fa5,-20(s0)
   10206:	67c1                	lui	a5,0x10
   10208:	6b87a787          	flw	fa5,1720(a5) # 106b8 <__errno+0x18>
   1020c:	fef42627          	fsw	fa5,-20(s0)
   10210:	67c1                	lui	a5,0x10
   10212:	6bc7a787          	flw	fa5,1724(a5) # 106bc <__errno+0x1c>
   10216:	fef42427          	fsw	fa5,-24(s0)
   1021a:	fec42707          	flw	fa4,-20(s0)
   1021e:	fe842787          	flw	fa5,-24(s0)
   10222:	00f777d3          	fadd.s	fa5,fa4,fa5
   10226:	fef42227          	fsw	fa5,-28(s0)
   1022a:	fe442707          	flw	fa4,-28(s0)
   1022e:	67c1                	lui	a5,0x10
   10230:	6c07a787          	flw	fa5,1728(a5) # 106c0 <__errno+0x20>
   10234:	a0f727d3          	feq.s	a5,fa4,fa5
   10238:	e399                	bnez	a5,1023e <main+0xa2>
   1023a:	0000                	unimp
   1023c:	0000                	unimp
   1023e:	67c1                	lui	a5,0x10
   10240:	6b47a787          	flw	fa5,1716(a5) # 106b4 <__errno+0x14>
   10244:	fef42627          	fsw	fa5,-20(s0)
   10248:	67c1                	lui	a5,0x10
   1024a:	6c47a787          	flw	fa5,1732(a5) # 106c4 <__errno+0x24>
   1024e:	fef42427          	fsw	fa5,-24(s0)
   10252:	fec42707          	flw	fa4,-20(s0)
   10256:	fe842787          	flw	fa5,-24(s0)
   1025a:	00f777d3          	fadd.s	fa5,fa4,fa5
   1025e:	fef42227          	fsw	fa5,-28(s0)
   10262:	fe442787          	flw	fa5,-28(s0)
   10266:	42078753          	fcvt.d.s	fa4,fa5
   1026a:	67c1                	lui	a5,0x10
   1026c:	6c87b787          	fld	fa5,1736(a5) # 106c8 <__errno+0x28>
   10270:	a2f727d3          	feq.d	a5,fa4,fa5
   10274:	e399                	bnez	a5,1027a <main+0xde>
   10276:	0000                	unimp
   10278:	0000                	unimp
   1027a:	67c1                	lui	a5,0x10
   1027c:	6a87a787          	flw	fa5,1704(a5) # 106a8 <__errno+0x8>
   10280:	fef42627          	fsw	fa5,-20(s0)
   10284:	67c1                	lui	a5,0x10
   10286:	6ac7a787          	flw	fa5,1708(a5) # 106ac <__errno+0xc>
   1028a:	fef42427          	fsw	fa5,-24(s0)
   1028e:	fec42707          	flw	fa4,-20(s0)
   10292:	fe842787          	flw	fa5,-24(s0)
   10296:	08f777d3          	fsub.s	fa5,fa4,fa5
   1029a:	fef42227          	fsw	fa5,-28(s0)
   1029e:	fe442707          	flw	fa4,-28(s0)
   102a2:	67c1                	lui	a5,0x10
   102a4:	6d07a787          	flw	fa5,1744(a5) # 106d0 <__errno+0x30>
   102a8:	a0f727d3          	feq.s	a5,fa4,fa5
   102ac:	e399                	bnez	a5,102b2 <main+0x116>
   102ae:	0000                	unimp
   102b0:	0000                	unimp
   102b2:	67c1                	lui	a5,0x10
   102b4:	6b47a787          	flw	fa5,1716(a5) # 106b4 <__errno+0x14>
   102b8:	fef42627          	fsw	fa5,-20(s0)
   102bc:	67c1                	lui	a5,0x10
   102be:	6b87a787          	flw	fa5,1720(a5) # 106b8 <__errno+0x18>
   102c2:	fef42627          	fsw	fa5,-20(s0)
   102c6:	67c1                	lui	a5,0x10
   102c8:	6d47a787          	flw	fa5,1748(a5) # 106d4 <__errno+0x34>
   102cc:	fef42427          	fsw	fa5,-24(s0)
   102d0:	fec42707          	flw	fa4,-20(s0)
   102d4:	fe842787          	flw	fa5,-24(s0)
   102d8:	08f777d3          	fsub.s	fa5,fa4,fa5
   102dc:	fef42227          	fsw	fa5,-28(s0)
   102e0:	fe442707          	flw	fa4,-28(s0)
   102e4:	67c1                	lui	a5,0x10
   102e6:	6c07a787          	flw	fa5,1728(a5) # 106c0 <__errno+0x20>
   102ea:	a0f727d3          	feq.s	a5,fa4,fa5
   102ee:	e399                	bnez	a5,102f4 <main+0x158>
   102f0:	0000                	unimp
   102f2:	0000                	unimp
   102f4:	67c1                	lui	a5,0x10
   102f6:	6b47a787          	flw	fa5,1716(a5) # 106b4 <__errno+0x14>
   102fa:	fef42627          	fsw	fa5,-20(s0)
   102fe:	67c1                	lui	a5,0x10
   10300:	6c47a787          	flw	fa5,1732(a5) # 106c4 <__errno+0x24>
   10304:	fef42427          	fsw	fa5,-24(s0)
   10308:	fec42707          	flw	fa4,-20(s0)
   1030c:	fe842787          	flw	fa5,-24(s0)
   10310:	00f777d3          	fadd.s	fa5,fa4,fa5
   10314:	fef42227          	fsw	fa5,-28(s0)
   10318:	fe442787          	flw	fa5,-28(s0)
   1031c:	42078753          	fcvt.d.s	fa4,fa5
   10320:	67c1                	lui	a5,0x10
   10322:	6c87b787          	fld	fa5,1736(a5) # 106c8 <__errno+0x28>
   10326:	a2f727d3          	feq.d	a5,fa4,fa5
   1032a:	e399                	bnez	a5,10330 <main+0x194>
   1032c:	0000                	unimp
   1032e:	0000                	unimp
   10330:	67c1                	lui	a5,0x10
   10332:	6a87a787          	flw	fa5,1704(a5) # 106a8 <__errno+0x8>
   10336:	fef42627          	fsw	fa5,-20(s0)
   1033a:	67c1                	lui	a5,0x10
   1033c:	6ac7a787          	flw	fa5,1708(a5) # 106ac <__errno+0xc>
   10340:	fef42427          	fsw	fa5,-24(s0)
   10344:	fec42707          	flw	fa4,-20(s0)
   10348:	fe842787          	flw	fa5,-24(s0)
   1034c:	10f777d3          	fmul.s	fa5,fa4,fa5
   10350:	fef42227          	fsw	fa5,-28(s0)
   10354:	fe442707          	flw	fa4,-28(s0)
   10358:	67c1                	lui	a5,0x10
   1035a:	6a87a787          	flw	fa5,1704(a5) # 106a8 <__errno+0x8>
   1035e:	a0f727d3          	feq.s	a5,fa4,fa5
   10362:	e399                	bnez	a5,10368 <main+0x1cc>
   10364:	0000                	unimp
   10366:	0000                	unimp
   10368:	67c1                	lui	a5,0x10
   1036a:	6b47a787          	flw	fa5,1716(a5) # 106b4 <__errno+0x14>
   1036e:	fef42627          	fsw	fa5,-20(s0)
   10372:	67c1                	lui	a5,0x10
   10374:	6b87a787          	flw	fa5,1720(a5) # 106b8 <__errno+0x18>
   10378:	fef42627          	fsw	fa5,-20(s0)
   1037c:	67c1                	lui	a5,0x10
   1037e:	6d47a787          	flw	fa5,1748(a5) # 106d4 <__errno+0x34>
   10382:	fef42427          	fsw	fa5,-24(s0)
   10386:	fec42707          	flw	fa4,-20(s0)
   1038a:	fe842787          	flw	fa5,-24(s0)
   1038e:	10f777d3          	fmul.s	fa5,fa4,fa5
   10392:	fef42227          	fsw	fa5,-28(s0)
   10396:	fe442787          	flw	fa5,-28(s0)
   1039a:	42078753          	fcvt.d.s	fa4,fa5
   1039e:	67c1                	lui	a5,0x10
   103a0:	6d87b787          	fld	fa5,1752(a5) # 106d8 <__errno+0x38>
   103a4:	a2f727d3          	feq.d	a5,fa4,fa5
   103a8:	e399                	bnez	a5,103ae <main+0x212>
   103aa:	0000                	unimp
   103ac:	0000                	unimp
   103ae:	67c1                	lui	a5,0x10
   103b0:	6b47a787          	flw	fa5,1716(a5) # 106b4 <__errno+0x14>
   103b4:	fef42627          	fsw	fa5,-20(s0)
   103b8:	67c1                	lui	a5,0x10
   103ba:	6c47a787          	flw	fa5,1732(a5) # 106c4 <__errno+0x24>
   103be:	fef42427          	fsw	fa5,-24(s0)
   103c2:	fec42707          	flw	fa4,-20(s0)
   103c6:	fe842787          	flw	fa5,-24(s0)
   103ca:	10f777d3          	fmul.s	fa5,fa4,fa5
   103ce:	fef42227          	fsw	fa5,-28(s0)
   103d2:	fe442787          	flw	fa5,-28(s0)
   103d6:	42078753          	fcvt.d.s	fa4,fa5
   103da:	67c1                	lui	a5,0x10
   103dc:	6e07b787          	fld	fa5,1760(a5) # 106e0 <__errno+0x40>
   103e0:	a2f727d3          	feq.d	a5,fa4,fa5
   103e4:	e399                	bnez	a5,103ea <main+0x24e>
   103e6:	0000                	unimp
   103e8:	0000                	unimp
   103ea:	4781                	li	a5,0
   103ec:	853e                	mv	a0,a5
   103ee:	7422                	ld	s0,40(sp)
   103f0:	6145                	add	sp,sp,48
   103f2:	8082                	ret

00000000000103f4 <__libc_init_array>:
   103f4:	1101                	add	sp,sp,-32
   103f6:	e822                	sd	s0,16(sp)
   103f8:	67c5                	lui	a5,0x11
   103fa:	6445                	lui	s0,0x11
   103fc:	e04a                	sd	s2,0(sp)
   103fe:	6ec78793          	add	a5,a5,1772 # 116ec <__preinit_array_end>
   10402:	6ec40713          	add	a4,s0,1772 # 116ec <__preinit_array_end>
   10406:	ec06                	sd	ra,24(sp)
   10408:	e426                	sd	s1,8(sp)
   1040a:	40e78933          	sub	s2,a5,a4
   1040e:	00e78d63          	beq	a5,a4,10428 <__libc_init_array+0x34>
   10412:	40395913          	sra	s2,s2,0x3
   10416:	6ec40413          	add	s0,s0,1772
   1041a:	4481                	li	s1,0
   1041c:	601c                	ld	a5,0(s0)
   1041e:	0485                	add	s1,s1,1
   10420:	0421                	add	s0,s0,8
   10422:	9782                	jalr	a5
   10424:	ff24ece3          	bltu	s1,s2,1041c <__libc_init_array+0x28>
   10428:	6445                	lui	s0,0x11
   1042a:	67c5                	lui	a5,0x11
   1042c:	70078793          	add	a5,a5,1792 # 11700 <__do_global_dtors_aux_fini_array_entry>
   10430:	6f040713          	add	a4,s0,1776 # 116f0 <__init_array_start>
   10434:	40e78933          	sub	s2,a5,a4
   10438:	40395913          	sra	s2,s2,0x3
   1043c:	00e78b63          	beq	a5,a4,10452 <__libc_init_array+0x5e>
   10440:	6f040413          	add	s0,s0,1776
   10444:	4481                	li	s1,0
   10446:	601c                	ld	a5,0(s0)
   10448:	0485                	add	s1,s1,1
   1044a:	0421                	add	s0,s0,8
   1044c:	9782                	jalr	a5
   1044e:	ff24ece3          	bltu	s1,s2,10446 <__libc_init_array+0x52>
   10452:	60e2                	ld	ra,24(sp)
   10454:	6442                	ld	s0,16(sp)
   10456:	64a2                	ld	s1,8(sp)
   10458:	6902                	ld	s2,0(sp)
   1045a:	6105                	add	sp,sp,32
   1045c:	8082                	ret

000000000001045e <memset>:
   1045e:	433d                	li	t1,15
   10460:	872a                	mv	a4,a0
   10462:	02c37163          	bgeu	t1,a2,10484 <memset+0x26>
   10466:	00f77793          	and	a5,a4,15
   1046a:	e3c1                	bnez	a5,104ea <memset+0x8c>
   1046c:	e1bd                	bnez	a1,104d2 <memset+0x74>
   1046e:	ff067693          	and	a3,a2,-16
   10472:	8a3d                	and	a2,a2,15
   10474:	96ba                	add	a3,a3,a4
   10476:	e30c                	sd	a1,0(a4)
   10478:	e70c                	sd	a1,8(a4)
   1047a:	0741                	add	a4,a4,16
   1047c:	fed76de3          	bltu	a4,a3,10476 <memset+0x18>
   10480:	e211                	bnez	a2,10484 <memset+0x26>
   10482:	8082                	ret
   10484:	40c306b3          	sub	a3,t1,a2
   10488:	068a                	sll	a3,a3,0x2
   1048a:	00000297          	auipc	t0,0x0
   1048e:	9696                	add	a3,a3,t0
   10490:	00a68067          	jr	10(a3)
   10494:	00b70723          	sb	a1,14(a4)
   10498:	00b706a3          	sb	a1,13(a4)
   1049c:	00b70623          	sb	a1,12(a4)
   104a0:	00b705a3          	sb	a1,11(a4)
   104a4:	00b70523          	sb	a1,10(a4)
   104a8:	00b704a3          	sb	a1,9(a4)
   104ac:	00b70423          	sb	a1,8(a4)
   104b0:	00b703a3          	sb	a1,7(a4)
   104b4:	00b70323          	sb	a1,6(a4)
   104b8:	00b702a3          	sb	a1,5(a4)
   104bc:	00b70223          	sb	a1,4(a4)
   104c0:	00b701a3          	sb	a1,3(a4)
   104c4:	00b70123          	sb	a1,2(a4)
   104c8:	00b700a3          	sb	a1,1(a4)
   104cc:	00b70023          	sb	a1,0(a4)
   104d0:	8082                	ret
   104d2:	0ff5f593          	zext.b	a1,a1
   104d6:	00859693          	sll	a3,a1,0x8
   104da:	8dd5                	or	a1,a1,a3
   104dc:	01059693          	sll	a3,a1,0x10
   104e0:	8dd5                	or	a1,a1,a3
   104e2:	02059693          	sll	a3,a1,0x20
   104e6:	8dd5                	or	a1,a1,a3
   104e8:	b759                	j	1046e <memset+0x10>
   104ea:	00279693          	sll	a3,a5,0x2
   104ee:	00000297          	auipc	t0,0x0
   104f2:	9696                	add	a3,a3,t0
   104f4:	8286                	mv	t0,ra
   104f6:	fa2680e7          	jalr	-94(a3)
   104fa:	8096                	mv	ra,t0
   104fc:	17c1                	add	a5,a5,-16
   104fe:	8f1d                	sub	a4,a4,a5
   10500:	963e                	add	a2,a2,a5
   10502:	f8c371e3          	bgeu	t1,a2,10484 <memset+0x26>
   10506:	b79d                	j	1046c <memset+0xe>

0000000000010508 <__call_exitprocs>:
   10508:	715d                	add	sp,sp,-80
   1050a:	f052                	sd	s4,32(sp)
   1050c:	f481ba03          	ld	s4,-184(gp) # 11e50 <_global_impure_ptr>
   10510:	f84a                	sd	s2,48(sp)
   10512:	e486                	sd	ra,72(sp)
   10514:	1f8a3903          	ld	s2,504(s4)
   10518:	e0a2                	sd	s0,64(sp)
   1051a:	fc26                	sd	s1,56(sp)
   1051c:	f44e                	sd	s3,40(sp)
   1051e:	ec56                	sd	s5,24(sp)
   10520:	e85a                	sd	s6,16(sp)
   10522:	e45e                	sd	s7,8(sp)
   10524:	e062                	sd	s8,0(sp)
   10526:	02090863          	beqz	s2,10556 <__call_exitprocs+0x4e>
   1052a:	8b2a                	mv	s6,a0
   1052c:	8bae                	mv	s7,a1
   1052e:	4a85                	li	s5,1
   10530:	59fd                	li	s3,-1
   10532:	00892483          	lw	s1,8(s2)
   10536:	fff4841b          	addw	s0,s1,-1
   1053a:	00044e63          	bltz	s0,10556 <__call_exitprocs+0x4e>
   1053e:	048e                	sll	s1,s1,0x3
   10540:	94ca                	add	s1,s1,s2
   10542:	020b8663          	beqz	s7,1056e <__call_exitprocs+0x66>
   10546:	2084b783          	ld	a5,520(s1)
   1054a:	03778263          	beq	a5,s7,1056e <__call_exitprocs+0x66>
   1054e:	347d                	addw	s0,s0,-1
   10550:	14e1                	add	s1,s1,-8
   10552:	ff3418e3          	bne	s0,s3,10542 <__call_exitprocs+0x3a>
   10556:	60a6                	ld	ra,72(sp)
   10558:	6406                	ld	s0,64(sp)
   1055a:	74e2                	ld	s1,56(sp)
   1055c:	7942                	ld	s2,48(sp)
   1055e:	79a2                	ld	s3,40(sp)
   10560:	7a02                	ld	s4,32(sp)
   10562:	6ae2                	ld	s5,24(sp)
   10564:	6b42                	ld	s6,16(sp)
   10566:	6ba2                	ld	s7,8(sp)
   10568:	6c02                	ld	s8,0(sp)
   1056a:	6161                	add	sp,sp,80
   1056c:	8082                	ret
   1056e:	00892783          	lw	a5,8(s2)
   10572:	6498                	ld	a4,8(s1)
   10574:	37fd                	addw	a5,a5,-1
   10576:	04878463          	beq	a5,s0,105be <__call_exitprocs+0xb6>
   1057a:	0004b423          	sd	zero,8(s1)
   1057e:	db61                	beqz	a4,1054e <__call_exitprocs+0x46>
   10580:	31092783          	lw	a5,784(s2)
   10584:	008a96bb          	sllw	a3,s5,s0
   10588:	00892c03          	lw	s8,8(s2)
   1058c:	8ff5                	and	a5,a5,a3
   1058e:	2781                	sext.w	a5,a5
   10590:	ef89                	bnez	a5,105aa <__call_exitprocs+0xa2>
   10592:	9702                	jalr	a4
   10594:	00892703          	lw	a4,8(s2)
   10598:	1f8a3783          	ld	a5,504(s4)
   1059c:	01871463          	bne	a4,s8,105a4 <__call_exitprocs+0x9c>
   105a0:	fb2787e3          	beq	a5,s2,1054e <__call_exitprocs+0x46>
   105a4:	dbcd                	beqz	a5,10556 <__call_exitprocs+0x4e>
   105a6:	893e                	mv	s2,a5
   105a8:	b769                	j	10532 <__call_exitprocs+0x2a>
   105aa:	31492783          	lw	a5,788(s2)
   105ae:	1084b583          	ld	a1,264(s1)
   105b2:	8ff5                	and	a5,a5,a3
   105b4:	2781                	sext.w	a5,a5
   105b6:	e799                	bnez	a5,105c4 <__call_exitprocs+0xbc>
   105b8:	855a                	mv	a0,s6
   105ba:	9702                	jalr	a4
   105bc:	bfe1                	j	10594 <__call_exitprocs+0x8c>
   105be:	00892423          	sw	s0,8(s2)
   105c2:	bf75                	j	1057e <__call_exitprocs+0x76>
   105c4:	852e                	mv	a0,a1
   105c6:	9702                	jalr	a4
   105c8:	b7f1                	j	10594 <__call_exitprocs+0x8c>

00000000000105ca <__libc_fini_array>:
   105ca:	1101                	add	sp,sp,-32
   105cc:	e822                	sd	s0,16(sp)
   105ce:	67c5                	lui	a5,0x11
   105d0:	6445                	lui	s0,0x11
   105d2:	70078793          	add	a5,a5,1792 # 11700 <__do_global_dtors_aux_fini_array_entry>
   105d6:	70840413          	add	s0,s0,1800 # 11708 <impure_data>
   105da:	8c1d                	sub	s0,s0,a5
   105dc:	e426                	sd	s1,8(sp)
   105de:	ec06                	sd	ra,24(sp)
   105e0:	40345493          	sra	s1,s0,0x3
   105e4:	c881                	beqz	s1,105f4 <__libc_fini_array+0x2a>
   105e6:	1461                	add	s0,s0,-8
   105e8:	943e                	add	s0,s0,a5
   105ea:	601c                	ld	a5,0(s0)
   105ec:	14fd                	add	s1,s1,-1
   105ee:	1461                	add	s0,s0,-8
   105f0:	9782                	jalr	a5
   105f2:	fce5                	bnez	s1,105ea <__libc_fini_array+0x20>
   105f4:	60e2                	ld	ra,24(sp)
   105f6:	6442                	ld	s0,16(sp)
   105f8:	64a2                	ld	s1,8(sp)
   105fa:	6105                	add	sp,sp,32
   105fc:	8082                	ret

00000000000105fe <atexit>:
   105fe:	85aa                	mv	a1,a0
   10600:	4681                	li	a3,0
   10602:	4601                	li	a2,0
   10604:	4501                	li	a0,0
   10606:	a009                	j	10608 <__register_exitproc>

0000000000010608 <__register_exitproc>:
   10608:	f481b703          	ld	a4,-184(gp) # 11e50 <_global_impure_ptr>
   1060c:	1f873783          	ld	a5,504(a4)
   10610:	c3b1                	beqz	a5,10654 <__register_exitproc+0x4c>
   10612:	4798                	lw	a4,8(a5)
   10614:	487d                	li	a6,31
   10616:	06e84263          	blt	a6,a4,1067a <__register_exitproc+0x72>
   1061a:	c505                	beqz	a0,10642 <__register_exitproc+0x3a>
   1061c:	00371813          	sll	a6,a4,0x3
   10620:	983e                	add	a6,a6,a5
   10622:	10c83823          	sd	a2,272(a6)
   10626:	3107a883          	lw	a7,784(a5)
   1062a:	4605                	li	a2,1
   1062c:	00e6163b          	sllw	a2,a2,a4
   10630:	00c8e8b3          	or	a7,a7,a2
   10634:	3117a823          	sw	a7,784(a5)
   10638:	20d83823          	sd	a3,528(a6)
   1063c:	4689                	li	a3,2
   1063e:	02d50063          	beq	a0,a3,1065e <__register_exitproc+0x56>
   10642:	00270693          	add	a3,a4,2
   10646:	068e                	sll	a3,a3,0x3
   10648:	2705                	addw	a4,a4,1
   1064a:	c798                	sw	a4,8(a5)
   1064c:	97b6                	add	a5,a5,a3
   1064e:	e38c                	sd	a1,0(a5)
   10650:	4501                	li	a0,0
   10652:	8082                	ret
   10654:	20070793          	add	a5,a4,512
   10658:	1ef73c23          	sd	a5,504(a4)
   1065c:	bf5d                	j	10612 <__register_exitproc+0xa>
   1065e:	3147a683          	lw	a3,788(a5)
   10662:	4501                	li	a0,0
   10664:	8ed1                	or	a3,a3,a2
   10666:	30d7aa23          	sw	a3,788(a5)
   1066a:	00270693          	add	a3,a4,2
   1066e:	068e                	sll	a3,a3,0x3
   10670:	2705                	addw	a4,a4,1
   10672:	c798                	sw	a4,8(a5)
   10674:	97b6                	add	a5,a5,a3
   10676:	e38c                	sd	a1,0(a5)
   10678:	8082                	ret
   1067a:	557d                	li	a0,-1
   1067c:	8082                	ret

000000000001067e <_exit>:
   1067e:	05d00893          	li	a7,93
   10682:	00000073          	ecall
   10686:	00054363          	bltz	a0,1068c <_exit+0xe>
   1068a:	a001                	j	1068a <_exit+0xc>
   1068c:	1141                	add	sp,sp,-16
   1068e:	e022                	sd	s0,0(sp)
   10690:	842a                	mv	s0,a0
   10692:	e406                	sd	ra,8(sp)
   10694:	4080043b          	negw	s0,s0
   10698:	008000ef          	jal	106a0 <__errno>
   1069c:	c100                	sw	s0,0(a0)
   1069e:	a001                	j	1069e <_exit+0x20>

00000000000106a0 <__errno>:
   106a0:	f581b503          	ld	a0,-168(gp) # 11e60 <_impure_ptr>
   106a4:	8082                	ret

slli.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	34a000ef          	jal	1043c <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d40 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4b0000ef          	jal	105b2 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4fe50513          	add	a0,a0,1278 # 104fe <__libc_fini_array>
   10112:	a105                	j	10532 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	ce218193          	add	gp,gp,-798 # 11df8 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d58 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d90 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	268000ef          	jal	10392 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	40450513          	add	a0,a0,1028 # 10532 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3c650513          	add	a0,a0,966 # 104fe <__libc_fini_array>
   10140:	3f2000ef          	jal	10532 <atexit>
   10144:	1e4000ef          	jal	10328 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d58 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5dc50513          	add	a0,a0,1500 # 115dc <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d58 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d60 <object.0>
   1018e:	5dc50513          	add	a0,a0,1500 # 115dc <__EH_FRAME_BEGIN__>
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
   101ae:	4085                	li	ra,1
   101b0:	00009713          	sll	a4,ra,0x0
   101b4:	4385                	li	t2,1
   101b6:	16771163          	bne	a4,t2,10318 <fail>

00000000000101ba <test_3>:
   101ba:	418d                	li	gp,3
   101bc:	4085                	li	ra,1
   101be:	00109713          	sll	a4,ra,0x1
   101c2:	4389                	li	t2,2
   101c4:	14771a63          	bne	a4,t2,10318 <fail>

00000000000101c8 <test_4>:
   101c8:	4191                	li	gp,4
   101ca:	4085                	li	ra,1
   101cc:	00709713          	sll	a4,ra,0x7
   101d0:	08000393          	li	t2,128
   101d4:	14771263          	bne	a4,t2,10318 <fail>

00000000000101d8 <test_5>:
   101d8:	4195                	li	gp,5
   101da:	4085                	li	ra,1
   101dc:	00e09713          	sll	a4,ra,0xe
   101e0:	6391                	lui	t2,0x4
   101e2:	12771b63          	bne	a4,t2,10318 <fail>

00000000000101e6 <test_6>:
   101e6:	4199                	li	gp,6
   101e8:	4085                	li	ra,1
   101ea:	01f09713          	sll	a4,ra,0x1f
   101ee:	0010039b          	addw	t2,zero,1
   101f2:	03fe                	sll	t2,t2,0x1f
   101f4:	12771263          	bne	a4,t2,10318 <fail>

00000000000101f8 <test_7>:
   101f8:	419d                	li	gp,7
   101fa:	50fd                	li	ra,-1
   101fc:	00009713          	sll	a4,ra,0x0
   10200:	53fd                	li	t2,-1
   10202:	10771b63          	bne	a4,t2,10318 <fail>

0000000000010206 <test_8>:
   10206:	41a1                	li	gp,8
   10208:	50fd                	li	ra,-1
   1020a:	00109713          	sll	a4,ra,0x1
   1020e:	53f9                	li	t2,-2
   10210:	10771463          	bne	a4,t2,10318 <fail>

0000000000010214 <test_9>:
   10214:	41a5                	li	gp,9
   10216:	50fd                	li	ra,-1
   10218:	00709713          	sll	a4,ra,0x7
   1021c:	f8000393          	li	t2,-128
   10220:	0e771c63          	bne	a4,t2,10318 <fail>

0000000000010224 <test_10>:
   10224:	41a9                	li	gp,10
   10226:	50fd                	li	ra,-1
   10228:	00e09713          	sll	a4,ra,0xe
   1022c:	73f1                	lui	t2,0xffffc
   1022e:	0e771563          	bne	a4,t2,10318 <fail>

0000000000010232 <test_11>:
   10232:	41ad                	li	gp,11
   10234:	50fd                	li	ra,-1
   10236:	01f09713          	sll	a4,ra,0x1f
   1023a:	800003b7          	lui	t2,0x80000
   1023e:	0c771d63          	bne	a4,t2,10318 <fail>

0000000000010242 <test_12>:
   10242:	41b1                	li	gp,12
   10244:	212120b7          	lui	ra,0x21212
   10248:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200329>
   1024c:	00009713          	sll	a4,ra,0x0
   10250:	212123b7          	lui	t2,0x21212
   10254:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200329>
   10258:	0c771063          	bne	a4,t2,10318 <fail>

000000000001025c <test_13>:
   1025c:	41b5                	li	gp,13
   1025e:	212120b7          	lui	ra,0x21212
   10262:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200329>
   10266:	00109713          	sll	a4,ra,0x1
   1026a:	424243b7          	lui	t2,0x42424
   1026e:	2423839b          	addw	t2,t2,578 # 42424242 <__global_pointer$+0x4241244a>
   10272:	0a771363          	bne	a4,t2,10318 <fail>

0000000000010276 <test_14>:
   10276:	41b9                	li	gp,14
   10278:	212120b7          	lui	ra,0x21212
   1027c:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200329>
   10280:	00709713          	sll	a4,ra,0x7
   10284:	010913b7          	lui	t2,0x1091
   10288:	9093839b          	addw	t2,t2,-1783 # 1090909 <__global_pointer$+0x107eb11>
   1028c:	03b2                	sll	t2,t2,0xc
   1028e:	08038393          	add	t2,t2,128
   10292:	08771363          	bne	a4,t2,10318 <fail>

0000000000010296 <test_15>:
   10296:	41bd                	li	gp,15
   10298:	212120b7          	lui	ra,0x21212
   1029c:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200329>
   102a0:	00e09713          	sll	a4,ra,0xe
   102a4:	212123b7          	lui	t2,0x21212
   102a8:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200329>
   102ac:	03ba                	sll	t2,t2,0xe
   102ae:	06771563          	bne	a4,t2,10318 <fail>

00000000000102b2 <test_16>:
   102b2:	41c1                	li	gp,16
   102b4:	212120b7          	lui	ra,0x21212
   102b8:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200329>
   102bc:	01f09713          	sll	a4,ra,0x1f
   102c0:	212123b7          	lui	t2,0x21212
   102c4:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200329>
   102c8:	03fe                	sll	t2,t2,0x1f
   102ca:	04771763          	bne	a4,t2,10318 <fail>

00000000000102ce <test_50>:
   102ce:	03200193          	li	gp,50
   102d2:	4085                	li	ra,1
   102d4:	03f09713          	sll	a4,ra,0x3f
   102d8:	fff0039b          	addw	t2,zero,-1
   102dc:	13fe                	sll	t2,t2,0x3f
   102de:	02771d63          	bne	a4,t2,10318 <fail>

00000000000102e2 <test_51>:
   102e2:	03300193          	li	gp,51
   102e6:	50fd                	li	ra,-1
   102e8:	02709713          	sll	a4,ra,0x27
   102ec:	fff0039b          	addw	t2,zero,-1
   102f0:	139e                	sll	t2,t2,0x27
   102f2:	02771363          	bne	a4,t2,10318 <fail>

00000000000102f6 <test_52>:
   102f6:	03400193          	li	gp,52
   102fa:	212120b7          	lui	ra,0x21212
   102fe:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200329>
   10302:	02b09713          	sll	a4,ra,0x2b
   10306:	63c9                	lui	t2,0x12
   10308:	1213839b          	addw	t2,t2,289 # 12121 <__global_pointer$+0x329>
   1030c:	13ae                	sll	t2,t2,0x2b
   1030e:	00771563          	bne	a4,t2,10318 <fail>
   10312:	00301263          	bne	zero,gp,10316 <pass>

0000000000010316 <pass>:
   10316:	a019                	j	1031c <continue>

0000000000010318 <fail>:
   10318:	00000000          	.word	0x00000000

000000000001031c <continue>:
   1031c:	4081                	li	ra,0
   1031e:	4781                	li	a5,0
   10320:	853e                	mv	a0,a5
   10322:	6462                	ld	s0,24(sp)
   10324:	6105                	add	sp,sp,32
   10326:	8082                	ret

0000000000010328 <__libc_init_array>:
   10328:	1101                	add	sp,sp,-32
   1032a:	e822                	sd	s0,16(sp)
   1032c:	67c5                	lui	a5,0x11
   1032e:	6445                	lui	s0,0x11
   10330:	e04a                	sd	s2,0(sp)
   10332:	5e078793          	add	a5,a5,1504 # 115e0 <__init_array_start>
   10336:	5e040713          	add	a4,s0,1504 # 115e0 <__init_array_start>
   1033a:	ec06                	sd	ra,24(sp)
   1033c:	e426                	sd	s1,8(sp)
   1033e:	40e78933          	sub	s2,a5,a4
   10342:	00e78d63          	beq	a5,a4,1035c <__libc_init_array+0x34>
   10346:	40395913          	sra	s2,s2,0x3
   1034a:	5e040413          	add	s0,s0,1504
   1034e:	4481                	li	s1,0
   10350:	601c                	ld	a5,0(s0)
   10352:	0485                	add	s1,s1,1
   10354:	0421                	add	s0,s0,8
   10356:	9782                	jalr	a5
   10358:	ff24ece3          	bltu	s1,s2,10350 <__libc_init_array+0x28>
   1035c:	6445                	lui	s0,0x11
   1035e:	67c5                	lui	a5,0x11
   10360:	5f078793          	add	a5,a5,1520 # 115f0 <__do_global_dtors_aux_fini_array_entry>
   10364:	5e040713          	add	a4,s0,1504 # 115e0 <__init_array_start>
   10368:	40e78933          	sub	s2,a5,a4
   1036c:	40395913          	sra	s2,s2,0x3
   10370:	00e78b63          	beq	a5,a4,10386 <__libc_init_array+0x5e>
   10374:	5e040413          	add	s0,s0,1504
   10378:	4481                	li	s1,0
   1037a:	601c                	ld	a5,0(s0)
   1037c:	0485                	add	s1,s1,1
   1037e:	0421                	add	s0,s0,8
   10380:	9782                	jalr	a5
   10382:	ff24ece3          	bltu	s1,s2,1037a <__libc_init_array+0x52>
   10386:	60e2                	ld	ra,24(sp)
   10388:	6442                	ld	s0,16(sp)
   1038a:	64a2                	ld	s1,8(sp)
   1038c:	6902                	ld	s2,0(sp)
   1038e:	6105                	add	sp,sp,32
   10390:	8082                	ret

0000000000010392 <memset>:
   10392:	433d                	li	t1,15
   10394:	872a                	mv	a4,a0
   10396:	02c37163          	bgeu	t1,a2,103b8 <memset+0x26>
   1039a:	00f77793          	and	a5,a4,15
   1039e:	e3c1                	bnez	a5,1041e <memset+0x8c>
   103a0:	e1bd                	bnez	a1,10406 <memset+0x74>
   103a2:	ff067693          	and	a3,a2,-16
   103a6:	8a3d                	and	a2,a2,15
   103a8:	96ba                	add	a3,a3,a4
   103aa:	e30c                	sd	a1,0(a4)
   103ac:	e70c                	sd	a1,8(a4)
   103ae:	0741                	add	a4,a4,16
   103b0:	fed76de3          	bltu	a4,a3,103aa <memset+0x18>
   103b4:	e211                	bnez	a2,103b8 <memset+0x26>
   103b6:	8082                	ret
   103b8:	40c306b3          	sub	a3,t1,a2
   103bc:	068a                	sll	a3,a3,0x2
   103be:	00000297          	auipc	t0,0x0
   103c2:	9696                	add	a3,a3,t0
   103c4:	00a68067          	jr	10(a3)
   103c8:	00b70723          	sb	a1,14(a4)
   103cc:	00b706a3          	sb	a1,13(a4)
   103d0:	00b70623          	sb	a1,12(a4)
   103d4:	00b705a3          	sb	a1,11(a4)
   103d8:	00b70523          	sb	a1,10(a4)
   103dc:	00b704a3          	sb	a1,9(a4)
   103e0:	00b70423          	sb	a1,8(a4)
   103e4:	00b703a3          	sb	a1,7(a4)
   103e8:	00b70323          	sb	a1,6(a4)
   103ec:	00b702a3          	sb	a1,5(a4)
   103f0:	00b70223          	sb	a1,4(a4)
   103f4:	00b701a3          	sb	a1,3(a4)
   103f8:	00b70123          	sb	a1,2(a4)
   103fc:	00b700a3          	sb	a1,1(a4)
   10400:	00b70023          	sb	a1,0(a4)
   10404:	8082                	ret
   10406:	0ff5f593          	zext.b	a1,a1
   1040a:	00859693          	sll	a3,a1,0x8
   1040e:	8dd5                	or	a1,a1,a3
   10410:	01059693          	sll	a3,a1,0x10
   10414:	8dd5                	or	a1,a1,a3
   10416:	02059693          	sll	a3,a1,0x20
   1041a:	8dd5                	or	a1,a1,a3
   1041c:	b759                	j	103a2 <memset+0x10>
   1041e:	00279693          	sll	a3,a5,0x2
   10422:	00000297          	auipc	t0,0x0
   10426:	9696                	add	a3,a3,t0
   10428:	8286                	mv	t0,ra
   1042a:	fa2680e7          	jalr	-94(a3)
   1042e:	8096                	mv	ra,t0
   10430:	17c1                	add	a5,a5,-16
   10432:	8f1d                	sub	a4,a4,a5
   10434:	963e                	add	a2,a2,a5
   10436:	f8c371e3          	bgeu	t1,a2,103b8 <memset+0x26>
   1043a:	b79d                	j	103a0 <memset+0xe>

000000000001043c <__call_exitprocs>:
   1043c:	715d                	add	sp,sp,-80
   1043e:	f052                	sd	s4,32(sp)
   10440:	f481ba03          	ld	s4,-184(gp) # 11d40 <_global_impure_ptr>
   10444:	f84a                	sd	s2,48(sp)
   10446:	e486                	sd	ra,72(sp)
   10448:	1f8a3903          	ld	s2,504(s4)
   1044c:	e0a2                	sd	s0,64(sp)
   1044e:	fc26                	sd	s1,56(sp)
   10450:	f44e                	sd	s3,40(sp)
   10452:	ec56                	sd	s5,24(sp)
   10454:	e85a                	sd	s6,16(sp)
   10456:	e45e                	sd	s7,8(sp)
   10458:	e062                	sd	s8,0(sp)
   1045a:	02090863          	beqz	s2,1048a <__call_exitprocs+0x4e>
   1045e:	8b2a                	mv	s6,a0
   10460:	8bae                	mv	s7,a1
   10462:	4a85                	li	s5,1
   10464:	59fd                	li	s3,-1
   10466:	00892483          	lw	s1,8(s2)
   1046a:	fff4841b          	addw	s0,s1,-1
   1046e:	00044e63          	bltz	s0,1048a <__call_exitprocs+0x4e>
   10472:	048e                	sll	s1,s1,0x3
   10474:	94ca                	add	s1,s1,s2
   10476:	020b8663          	beqz	s7,104a2 <__call_exitprocs+0x66>
   1047a:	2084b783          	ld	a5,520(s1)
   1047e:	03778263          	beq	a5,s7,104a2 <__call_exitprocs+0x66>
   10482:	347d                	addw	s0,s0,-1
   10484:	14e1                	add	s1,s1,-8
   10486:	ff3418e3          	bne	s0,s3,10476 <__call_exitprocs+0x3a>
   1048a:	60a6                	ld	ra,72(sp)
   1048c:	6406                	ld	s0,64(sp)
   1048e:	74e2                	ld	s1,56(sp)
   10490:	7942                	ld	s2,48(sp)
   10492:	79a2                	ld	s3,40(sp)
   10494:	7a02                	ld	s4,32(sp)
   10496:	6ae2                	ld	s5,24(sp)
   10498:	6b42                	ld	s6,16(sp)
   1049a:	6ba2                	ld	s7,8(sp)
   1049c:	6c02                	ld	s8,0(sp)
   1049e:	6161                	add	sp,sp,80
   104a0:	8082                	ret
   104a2:	00892783          	lw	a5,8(s2)
   104a6:	6498                	ld	a4,8(s1)
   104a8:	37fd                	addw	a5,a5,-1
   104aa:	04878463          	beq	a5,s0,104f2 <__call_exitprocs+0xb6>
   104ae:	0004b423          	sd	zero,8(s1)
   104b2:	db61                	beqz	a4,10482 <__call_exitprocs+0x46>
   104b4:	31092783          	lw	a5,784(s2)
   104b8:	008a96bb          	sllw	a3,s5,s0
   104bc:	00892c03          	lw	s8,8(s2)
   104c0:	8ff5                	and	a5,a5,a3
   104c2:	2781                	sext.w	a5,a5
   104c4:	ef89                	bnez	a5,104de <__call_exitprocs+0xa2>
   104c6:	9702                	jalr	a4
   104c8:	00892703          	lw	a4,8(s2)
   104cc:	1f8a3783          	ld	a5,504(s4)
   104d0:	01871463          	bne	a4,s8,104d8 <__call_exitprocs+0x9c>
   104d4:	fb2787e3          	beq	a5,s2,10482 <__call_exitprocs+0x46>
   104d8:	dbcd                	beqz	a5,1048a <__call_exitprocs+0x4e>
   104da:	893e                	mv	s2,a5
   104dc:	b769                	j	10466 <__call_exitprocs+0x2a>
   104de:	31492783          	lw	a5,788(s2)
   104e2:	1084b583          	ld	a1,264(s1)
   104e6:	8ff5                	and	a5,a5,a3
   104e8:	2781                	sext.w	a5,a5
   104ea:	e799                	bnez	a5,104f8 <__call_exitprocs+0xbc>
   104ec:	855a                	mv	a0,s6
   104ee:	9702                	jalr	a4
   104f0:	bfe1                	j	104c8 <__call_exitprocs+0x8c>
   104f2:	00892423          	sw	s0,8(s2)
   104f6:	bf75                	j	104b2 <__call_exitprocs+0x76>
   104f8:	852e                	mv	a0,a1
   104fa:	9702                	jalr	a4
   104fc:	b7f1                	j	104c8 <__call_exitprocs+0x8c>

00000000000104fe <__libc_fini_array>:
   104fe:	1101                	add	sp,sp,-32
   10500:	e822                	sd	s0,16(sp)
   10502:	67c5                	lui	a5,0x11
   10504:	6445                	lui	s0,0x11
   10506:	5f078793          	add	a5,a5,1520 # 115f0 <__do_global_dtors_aux_fini_array_entry>
   1050a:	5f840413          	add	s0,s0,1528 # 115f8 <impure_data>
   1050e:	8c1d                	sub	s0,s0,a5
   10510:	e426                	sd	s1,8(sp)
   10512:	ec06                	sd	ra,24(sp)
   10514:	40345493          	sra	s1,s0,0x3
   10518:	c881                	beqz	s1,10528 <__libc_fini_array+0x2a>
   1051a:	1461                	add	s0,s0,-8
   1051c:	943e                	add	s0,s0,a5
   1051e:	601c                	ld	a5,0(s0)
   10520:	14fd                	add	s1,s1,-1
   10522:	1461                	add	s0,s0,-8
   10524:	9782                	jalr	a5
   10526:	fce5                	bnez	s1,1051e <__libc_fini_array+0x20>
   10528:	60e2                	ld	ra,24(sp)
   1052a:	6442                	ld	s0,16(sp)
   1052c:	64a2                	ld	s1,8(sp)
   1052e:	6105                	add	sp,sp,32
   10530:	8082                	ret

0000000000010532 <atexit>:
   10532:	85aa                	mv	a1,a0
   10534:	4681                	li	a3,0
   10536:	4601                	li	a2,0
   10538:	4501                	li	a0,0
   1053a:	a009                	j	1053c <__register_exitproc>

000000000001053c <__register_exitproc>:
   1053c:	f481b703          	ld	a4,-184(gp) # 11d40 <_global_impure_ptr>
   10540:	1f873783          	ld	a5,504(a4)
   10544:	c3b1                	beqz	a5,10588 <__register_exitproc+0x4c>
   10546:	4798                	lw	a4,8(a5)
   10548:	487d                	li	a6,31
   1054a:	06e84263          	blt	a6,a4,105ae <__register_exitproc+0x72>
   1054e:	c505                	beqz	a0,10576 <__register_exitproc+0x3a>
   10550:	00371813          	sll	a6,a4,0x3
   10554:	983e                	add	a6,a6,a5
   10556:	10c83823          	sd	a2,272(a6)
   1055a:	3107a883          	lw	a7,784(a5)
   1055e:	4605                	li	a2,1
   10560:	00e6163b          	sllw	a2,a2,a4
   10564:	00c8e8b3          	or	a7,a7,a2
   10568:	3117a823          	sw	a7,784(a5)
   1056c:	20d83823          	sd	a3,528(a6)
   10570:	4689                	li	a3,2
   10572:	02d50063          	beq	a0,a3,10592 <__register_exitproc+0x56>
   10576:	00270693          	add	a3,a4,2
   1057a:	068e                	sll	a3,a3,0x3
   1057c:	2705                	addw	a4,a4,1
   1057e:	c798                	sw	a4,8(a5)
   10580:	97b6                	add	a5,a5,a3
   10582:	e38c                	sd	a1,0(a5)
   10584:	4501                	li	a0,0
   10586:	8082                	ret
   10588:	20070793          	add	a5,a4,512
   1058c:	1ef73c23          	sd	a5,504(a4)
   10590:	bf5d                	j	10546 <__register_exitproc+0xa>
   10592:	3147a683          	lw	a3,788(a5)
   10596:	4501                	li	a0,0
   10598:	8ed1                	or	a3,a3,a2
   1059a:	30d7aa23          	sw	a3,788(a5)
   1059e:	00270693          	add	a3,a4,2
   105a2:	068e                	sll	a3,a3,0x3
   105a4:	2705                	addw	a4,a4,1
   105a6:	c798                	sw	a4,8(a5)
   105a8:	97b6                	add	a5,a5,a3
   105aa:	e38c                	sd	a1,0(a5)
   105ac:	8082                	ret
   105ae:	557d                	li	a0,-1
   105b0:	8082                	ret

00000000000105b2 <_exit>:
   105b2:	05d00893          	li	a7,93
   105b6:	00000073          	ecall
   105ba:	00054363          	bltz	a0,105c0 <_exit+0xe>
   105be:	a001                	j	105be <_exit+0xc>
   105c0:	1141                	add	sp,sp,-16
   105c2:	e022                	sd	s0,0(sp)
   105c4:	842a                	mv	s0,a0
   105c6:	e406                	sd	ra,8(sp)
   105c8:	4080043b          	negw	s0,s0
   105cc:	008000ef          	jal	105d4 <__errno>
   105d0:	c100                	sw	s0,0(a0)
   105d2:	a001                	j	105d2 <_exit+0x20>

00000000000105d4 <__errno>:
   105d4:	f581b503          	ld	a0,-168(gp) # 11d50 <_impure_ptr>
   105d8:	8082                	ret

f_ldst.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	238000ef          	jal	1032a <__call_exitprocs>
   100f6:	fd81b503          	ld	a0,-40(gp) # 11cc8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	39e000ef          	jal	104a0 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	3ec50513          	add	a0,a0,1004 # 103ec <__libc_fini_array>
   10112:	a639                	j	10420 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	bda18193          	add	gp,gp,-1062 # 11cf0 <__global_pointer$>
   1011e:	ff018513          	add	a0,gp,-16 # 11ce0 <completed.1>
   10122:	02818613          	add	a2,gp,40 # 11d18 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	156000ef          	jal	10280 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	2f250513          	add	a0,a0,754 # 10420 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	2b450513          	add	a0,a0,692 # 103ec <__libc_fini_array>
   10140:	2e0000ef          	jal	10420 <atexit>
   10144:	0d2000ef          	jal	10216 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	ff01c783          	lbu	a5,-16(gp) # 11ce0 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	4c850513          	add	a0,a0,1224 # 114c8 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fef18823          	sb	a5,-16(gp) # 11ce0 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	ff818593          	add	a1,gp,-8 # 11ce8 <object.0>
   1018e:	4c850513          	add	a0,a0,1224 # 114c8 <__EH_FRAME_BEGIN__>
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
   101ae:	00001597          	auipc	a1,0x1
   101b2:	34258593          	add	a1,a1,834 # 114f0 <__DATA_BEGIN__>
   101b6:	0045a087          	flw	ft1,4(a1)
   101ba:	0015aa27          	fsw	ft1,20(a1)
   101be:	6988                	ld	a0,16(a1)
   101c0:	0010039b          	addw	t2,zero,1
   101c4:	1386                	sll	t2,t2,0x21
   101c6:	039d                	add	t2,t2,7
   101c8:	03be                	sll	t2,t2,0xf
   101ca:	ab738393          	add	t2,t2,-1353
   101ce:	03ba                	sll	t2,t2,0xe
   101d0:	eef38393          	add	t2,t2,-273
   101d4:	02751963          	bne	a0,t2,10206 <fail>

00000000000101d8 <test_3>:
   101d8:	418d                	li	gp,3
   101da:	00001597          	auipc	a1,0x1
   101de:	31658593          	add	a1,a1,790 # 114f0 <__DATA_BEGIN__>
   101e2:	0005a087          	flw	ft1,0(a1)
   101e6:	0015ac27          	fsw	ft1,24(a1)
   101ea:	6d88                	ld	a0,24(a1)
   101ec:	013383b7          	lui	t2,0x1338
   101f0:	d013839b          	addw	t2,t2,-767 # 1337d01 <__BSS_END__+0x1325fe9>
   101f4:	03b6                	sll	t2,t2,0xd
   101f6:	b7f38393          	add	t2,t2,-1153
   101fa:	03de                	sll	t2,t2,0x17
   101fc:	00751563          	bne	a0,t2,10206 <fail>
   10200:	00301263          	bne	zero,gp,10204 <pass>

0000000000010204 <pass>:
   10204:	a019                	j	1020a <continue>

0000000000010206 <fail>:
   10206:	0000                	unimp
	...

000000000001020a <continue>:
   1020a:	4081                	li	ra,0
   1020c:	4781                	li	a5,0
   1020e:	853e                	mv	a0,a5
   10210:	6462                	ld	s0,24(sp)
   10212:	6105                	add	sp,sp,32
   10214:	8082                	ret

0000000000010216 <__libc_init_array>:
   10216:	1101                	add	sp,sp,-32
   10218:	e822                	sd	s0,16(sp)
   1021a:	67c5                	lui	a5,0x11
   1021c:	6445                	lui	s0,0x11
   1021e:	e04a                	sd	s2,0(sp)
   10220:	4cc78793          	add	a5,a5,1228 # 114cc <__preinit_array_end>
   10224:	4cc40713          	add	a4,s0,1228 # 114cc <__preinit_array_end>
   10228:	ec06                	sd	ra,24(sp)
   1022a:	e426                	sd	s1,8(sp)
   1022c:	40e78933          	sub	s2,a5,a4
   10230:	00e78d63          	beq	a5,a4,1024a <__libc_init_array+0x34>
   10234:	40395913          	sra	s2,s2,0x3
   10238:	4cc40413          	add	s0,s0,1228
   1023c:	4481                	li	s1,0
   1023e:	601c                	ld	a5,0(s0)
   10240:	0485                	add	s1,s1,1
   10242:	0421                	add	s0,s0,8
   10244:	9782                	jalr	a5
   10246:	ff24ece3          	bltu	s1,s2,1023e <__libc_init_array+0x28>
   1024a:	6445                	lui	s0,0x11
   1024c:	67c5                	lui	a5,0x11
   1024e:	4e078793          	add	a5,a5,1248 # 114e0 <__do_global_dtors_aux_fini_array_entry>
   10252:	4d040713          	add	a4,s0,1232 # 114d0 <__init_array_start>
   10256:	40e78933          	sub	s2,a5,a4
   1025a:	40395913          	sra	s2,s2,0x3
   1025e:	00e78b63          	beq	a5,a4,10274 <__libc_init_array+0x5e>
   10262:	4d040413          	add	s0,s0,1232
   10266:	4481                	li	s1,0
   10268:	601c                	ld	a5,0(s0)
   1026a:	0485                	add	s1,s1,1
   1026c:	0421                	add	s0,s0,8
   1026e:	9782                	jalr	a5
   10270:	ff24ece3          	bltu	s1,s2,10268 <__libc_init_array+0x52>
   10274:	60e2                	ld	ra,24(sp)
   10276:	6442                	ld	s0,16(sp)
   10278:	64a2                	ld	s1,8(sp)
   1027a:	6902                	ld	s2,0(sp)
   1027c:	6105                	add	sp,sp,32
   1027e:	8082                	ret

0000000000010280 <memset>:
   10280:	433d                	li	t1,15
   10282:	872a                	mv	a4,a0
   10284:	02c37163          	bgeu	t1,a2,102a6 <memset+0x26>
   10288:	00f77793          	and	a5,a4,15
   1028c:	e3c1                	bnez	a5,1030c <memset+0x8c>
   1028e:	e1bd                	bnez	a1,102f4 <memset+0x74>
   10290:	ff067693          	and	a3,a2,-16
   10294:	8a3d                	and	a2,a2,15
   10296:	96ba                	add	a3,a3,a4
   10298:	e30c                	sd	a1,0(a4)
   1029a:	e70c                	sd	a1,8(a4)
   1029c:	0741                	add	a4,a4,16
   1029e:	fed76de3          	bltu	a4,a3,10298 <memset+0x18>
   102a2:	e211                	bnez	a2,102a6 <memset+0x26>
   102a4:	8082                	ret
   102a6:	40c306b3          	sub	a3,t1,a2
   102aa:	068a                	sll	a3,a3,0x2
   102ac:	00000297          	auipc	t0,0x0
   102b0:	9696                	add	a3,a3,t0
   102b2:	00a68067          	jr	10(a3)
   102b6:	00b70723          	sb	a1,14(a4)
   102ba:	00b706a3          	sb	a1,13(a4)
   102be:	00b70623          	sb	a1,12(a4)
   102c2:	00b705a3          	sb	a1,11(a4)
   102c6:	00b70523          	sb	a1,10(a4)
   102ca:	00b704a3          	sb	a1,9(a4)
   102ce:	00b70423          	sb	a1,8(a4)
   102d2:	00b703a3          	sb	a1,7(a4)
   102d6:	00b70323          	sb	a1,6(a4)
   102da:	00b702a3          	sb	a1,5(a4)
   102de:	00b70223          	sb	a1,4(a4)
   102e2:	00b701a3          	sb	a1,3(a4)
   102e6:	00b70123          	sb	a1,2(a4)
   102ea:	00b700a3          	sb	a1,1(a4)
   102ee:	00b70023          	sb	a1,0(a4)
   102f2:	8082                	ret
   102f4:	0ff5f593          	zext.b	a1,a1
   102f8:	00859693          	sll	a3,a1,0x8
   102fc:	8dd5                	or	a1,a1,a3
   102fe:	01059693          	sll	a3,a1,0x10
   10302:	8dd5                	or	a1,a1,a3
   10304:	02059693          	sll	a3,a1,0x20
   10308:	8dd5                	or	a1,a1,a3
   1030a:	b759                	j	10290 <memset+0x10>
   1030c:	00279693          	sll	a3,a5,0x2
   10310:	00000297          	auipc	t0,0x0
   10314:	9696                	add	a3,a3,t0
   10316:	8286                	mv	t0,ra
   10318:	fa2680e7          	jalr	-94(a3)
   1031c:	8096                	mv	ra,t0
   1031e:	17c1                	add	a5,a5,-16
   10320:	8f1d                	sub	a4,a4,a5
   10322:	963e                	add	a2,a2,a5
   10324:	f8c371e3          	bgeu	t1,a2,102a6 <memset+0x26>
   10328:	b79d                	j	1028e <memset+0xe>

000000000001032a <__call_exitprocs>:
   1032a:	715d                	add	sp,sp,-80
   1032c:	f052                	sd	s4,32(sp)
   1032e:	fd81ba03          	ld	s4,-40(gp) # 11cc8 <_global_impure_ptr>
   10332:	f84a                	sd	s2,48(sp)
   10334:	e486                	sd	ra,72(sp)
   10336:	1f8a3903          	ld	s2,504(s4)
   1033a:	e0a2                	sd	s0,64(sp)
   1033c:	fc26                	sd	s1,56(sp)
   1033e:	f44e                	sd	s3,40(sp)
   10340:	ec56                	sd	s5,24(sp)
   10342:	e85a                	sd	s6,16(sp)
   10344:	e45e                	sd	s7,8(sp)
   10346:	e062                	sd	s8,0(sp)
   10348:	02090863          	beqz	s2,10378 <__call_exitprocs+0x4e>
   1034c:	8b2a                	mv	s6,a0
   1034e:	8bae                	mv	s7,a1
   10350:	4a85                	li	s5,1
   10352:	59fd                	li	s3,-1
   10354:	00892483          	lw	s1,8(s2)
   10358:	fff4841b          	addw	s0,s1,-1
   1035c:	00044e63          	bltz	s0,10378 <__call_exitprocs+0x4e>
   10360:	048e                	sll	s1,s1,0x3
   10362:	94ca                	add	s1,s1,s2
   10364:	020b8663          	beqz	s7,10390 <__call_exitprocs+0x66>
   10368:	2084b783          	ld	a5,520(s1)
   1036c:	03778263          	beq	a5,s7,10390 <__call_exitprocs+0x66>
   10370:	347d                	addw	s0,s0,-1
   10372:	14e1                	add	s1,s1,-8
   10374:	ff3418e3          	bne	s0,s3,10364 <__call_exitprocs+0x3a>
   10378:	60a6                	ld	ra,72(sp)
   1037a:	6406                	ld	s0,64(sp)
   1037c:	74e2                	ld	s1,56(sp)
   1037e:	7942                	ld	s2,48(sp)
   10380:	79a2                	ld	s3,40(sp)
   10382:	7a02                	ld	s4,32(sp)
   10384:	6ae2                	ld	s5,24(sp)
   10386:	6b42                	ld	s6,16(sp)
   10388:	6ba2                	ld	s7,8(sp)
   1038a:	6c02                	ld	s8,0(sp)
   1038c:	6161                	add	sp,sp,80
   1038e:	8082                	ret
   10390:	00892783          	lw	a5,8(s2)
   10394:	6498                	ld	a4,8(s1)
   10396:	37fd                	addw	a5,a5,-1
   10398:	04878463          	beq	a5,s0,103e0 <__call_exitprocs+0xb6>
   1039c:	0004b423          	sd	zero,8(s1)
   103a0:	db61                	beqz	a4,10370 <__call_exitprocs+0x46>
   103a2:	31092783          	lw	a5,784(s2)
   103a6:	008a96bb          	sllw	a3,s5,s0
   103aa:	00892c03          	lw	s8,8(s2)
   103ae:	8ff5                	and	a5,a5,a3
   103b0:	2781                	sext.w	a5,a5
   103b2:	ef89                	bnez	a5,103cc <__call_exitprocs+0xa2>
   103b4:	9702                	jalr	a4
   103b6:	00892703          	lw	a4,8(s2)
   103ba:	1f8a3783          	ld	a5,504(s4)
   103be:	01871463          	bne	a4,s8,103c6 <__call_exitprocs+0x9c>
   103c2:	fb2787e3          	beq	a5,s2,10370 <__call_exitprocs+0x46>
   103c6:	dbcd                	beqz	a5,10378 <__call_exitprocs+0x4e>
   103c8:	893e                	mv	s2,a5
   103ca:	b769                	j	10354 <__call_exitprocs+0x2a>
   103cc:	31492783          	lw	a5,788(s2)
   103d0:	1084b583          	ld	a1,264(s1)
   103d4:	8ff5                	and	a5,a5,a3
   103d6:	2781                	sext.w	a5,a5
   103d8:	e799                	bnez	a5,103e6 <__call_exitprocs+0xbc>
   103da:	855a                	mv	a0,s6
   103dc:	9702                	jalr	a4
   103de:	bfe1                	j	103b6 <__call_exitprocs+0x8c>
   103e0:	00892423          	sw	s0,8(s2)
   103e4:	bf75                	j	103a0 <__call_exitprocs+0x76>
   103e6:	852e                	mv	a0,a1
   103e8:	9702                	jalr	a4
   103ea:	b7f1                	j	103b6 <__call_exitprocs+0x8c>

00000000000103ec <__libc_fini_array>:
   103ec:	1101                	add	sp,sp,-32
   103ee:	e822                	sd	s0,16(sp)
   103f0:	67c5                	lui	a5,0x11
   103f2:	6445                	lui	s0,0x11
   103f4:	4e078793          	add	a5,a5,1248 # 114e0 <__do_global_dtors_aux_fini_array_entry>
   103f8:	4e840413          	add	s0,s0,1256 # 114e8 <__fini_array_end>
   103fc:	8c1d                	sub	s0,s0,a5
   103fe:	e426                	sd	s1,8(sp)
   10400:	ec06                	sd	ra,24(sp)
   10402:	40345493          	sra	s1,s0,0x3
   10406:	c881                	beqz	s1,10416 <__libc_fini_array+0x2a>
   10408:	1461                	add	s0,s0,-8
   1040a:	943e                	add	s0,s0,a5
   1040c:	601c                	ld	a5,0(s0)
   1040e:	14fd                	add	s1,s1,-1
   10410:	1461                	add	s0,s0,-8
   10412:	9782                	jalr	a5
   10414:	fce5                	bnez	s1,1040c <__libc_fini_array+0x20>
   10416:	60e2                	ld	ra,24(sp)
   10418:	6442                	ld	s0,16(sp)
   1041a:	64a2                	ld	s1,8(sp)
   1041c:	6105                	add	sp,sp,32
   1041e:	8082                	ret

0000000000010420 <atexit>:
   10420:	85aa                	mv	a1,a0
   10422:	4681                	li	a3,0
   10424:	4601                	li	a2,0
   10426:	4501                	li	a0,0
   10428:	a009                	j	1042a <__register_exitproc>

000000000001042a <__register_exitproc>:
   1042a:	fd81b703          	ld	a4,-40(gp) # 11cc8 <_global_impure_ptr>
   1042e:	1f873783          	ld	a5,504(a4)
   10432:	c3b1                	beqz	a5,10476 <__register_exitproc+0x4c>
   10434:	4798                	lw	a4,8(a5)
   10436:	487d                	li	a6,31
   10438:	06e84263          	blt	a6,a4,1049c <__register_exitproc+0x72>
   1043c:	c505                	beqz	a0,10464 <__register_exitproc+0x3a>
   1043e:	00371813          	sll	a6,a4,0x3
   10442:	983e                	add	a6,a6,a5
   10444:	10c83823          	sd	a2,272(a6)
   10448:	3107a883          	lw	a7,784(a5)
   1044c:	4605                	li	a2,1
   1044e:	00e6163b          	sllw	a2,a2,a4
   10452:	00c8e8b3          	or	a7,a7,a2
   10456:	3117a823          	sw	a7,784(a5)
   1045a:	20d83823          	sd	a3,528(a6)
   1045e:	4689                	li	a3,2
   10460:	02d50063          	beq	a0,a3,10480 <__register_exitproc+0x56>
   10464:	00270693          	add	a3,a4,2
   10468:	068e                	sll	a3,a3,0x3
   1046a:	2705                	addw	a4,a4,1
   1046c:	c798                	sw	a4,8(a5)
   1046e:	97b6                	add	a5,a5,a3
   10470:	e38c                	sd	a1,0(a5)
   10472:	4501                	li	a0,0
   10474:	8082                	ret
   10476:	20070793          	add	a5,a4,512
   1047a:	1ef73c23          	sd	a5,504(a4)
   1047e:	bf5d                	j	10434 <__register_exitproc+0xa>
   10480:	3147a683          	lw	a3,788(a5)
   10484:	4501                	li	a0,0
   10486:	8ed1                	or	a3,a3,a2
   10488:	30d7aa23          	sw	a3,788(a5)
   1048c:	00270693          	add	a3,a4,2
   10490:	068e                	sll	a3,a3,0x3
   10492:	2705                	addw	a4,a4,1
   10494:	c798                	sw	a4,8(a5)
   10496:	97b6                	add	a5,a5,a3
   10498:	e38c                	sd	a1,0(a5)
   1049a:	8082                	ret
   1049c:	557d                	li	a0,-1
   1049e:	8082                	ret

00000000000104a0 <_exit>:
   104a0:	05d00893          	li	a7,93
   104a4:	00000073          	ecall
   104a8:	00054363          	bltz	a0,104ae <_exit+0xe>
   104ac:	a001                	j	104ac <_exit+0xc>
   104ae:	1141                	add	sp,sp,-16
   104b0:	e022                	sd	s0,0(sp)
   104b2:	842a                	mv	s0,a0
   104b4:	e406                	sd	ra,8(sp)
   104b6:	4080043b          	negw	s0,s0
   104ba:	008000ef          	jal	104c2 <__errno>
   104be:	c100                	sw	s0,0(a0)
   104c0:	a001                	j	104c0 <_exit+0x20>

00000000000104c2 <__errno>:
   104c2:	fe81b503          	ld	a0,-24(gp) # 11cd8 <_impure_ptr>
   104c6:	8082                	ret

sllw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	454000ef          	jal	10546 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11e48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	5ba000ef          	jal	106bc <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	60850513          	add	a0,a0,1544 # 10608 <__libc_fini_array>
   10112:	a32d                	j	1063c <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	dea18193          	add	gp,gp,-534 # 11f00 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11e60 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11e98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	372000ef          	jal	1049c <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	50e50513          	add	a0,a0,1294 # 1063c <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	4d050513          	add	a0,a0,1232 # 10608 <__libc_fini_array>
   10140:	4fc000ef          	jal	1063c <atexit>
   10144:	2ee000ef          	jal	10432 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11e60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	6e450513          	add	a0,a0,1764 # 116e4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11e60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11e68 <object.0>
   1018e:	6e450513          	add	a0,a0,1764 # 116e4 <__EH_FRAME_BEGIN__>
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
   101ae:	4085                	li	ra,1
   101b0:	4101                	li	sp,0
   101b2:	0020973b          	sllw	a4,ra,sp
   101b6:	4385                	li	t2,1
   101b8:	26771563          	bne	a4,t2,10422 <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	0020973b          	sllw	a4,ra,sp
   101c6:	4389                	li	t2,2
   101c8:	24771d63          	bne	a4,t2,10422 <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	4085                	li	ra,1
   101d0:	411d                	li	sp,7
   101d2:	0020973b          	sllw	a4,ra,sp
   101d6:	08000393          	li	t2,128
   101da:	24771463          	bne	a4,t2,10422 <fail>

00000000000101de <test_5>:
   101de:	4195                	li	gp,5
   101e0:	4085                	li	ra,1
   101e2:	4139                	li	sp,14
   101e4:	0020973b          	sllw	a4,ra,sp
   101e8:	6391                	lui	t2,0x4
   101ea:	22771c63          	bne	a4,t2,10422 <fail>

00000000000101ee <test_6>:
   101ee:	4199                	li	gp,6
   101f0:	4085                	li	ra,1
   101f2:	417d                	li	sp,31
   101f4:	0020973b          	sllw	a4,ra,sp
   101f8:	800003b7          	lui	t2,0x80000
   101fc:	22771363          	bne	a4,t2,10422 <fail>

0000000000010200 <test_7>:
   10200:	419d                	li	gp,7
   10202:	50fd                	li	ra,-1
   10204:	4101                	li	sp,0
   10206:	0020973b          	sllw	a4,ra,sp
   1020a:	53fd                	li	t2,-1
   1020c:	20771b63          	bne	a4,t2,10422 <fail>

0000000000010210 <test_8>:
   10210:	41a1                	li	gp,8
   10212:	50fd                	li	ra,-1
   10214:	4105                	li	sp,1
   10216:	0020973b          	sllw	a4,ra,sp
   1021a:	53f9                	li	t2,-2
   1021c:	20771363          	bne	a4,t2,10422 <fail>

0000000000010220 <test_9>:
   10220:	41a5                	li	gp,9
   10222:	50fd                	li	ra,-1
   10224:	411d                	li	sp,7
   10226:	0020973b          	sllw	a4,ra,sp
   1022a:	f8000393          	li	t2,-128
   1022e:	1e771a63          	bne	a4,t2,10422 <fail>

0000000000010232 <test_10>:
   10232:	41a9                	li	gp,10
   10234:	50fd                	li	ra,-1
   10236:	4139                	li	sp,14
   10238:	0020973b          	sllw	a4,ra,sp
   1023c:	73f1                	lui	t2,0xffffc
   1023e:	1e771263          	bne	a4,t2,10422 <fail>

0000000000010242 <test_11>:
   10242:	41ad                	li	gp,11
   10244:	50fd                	li	ra,-1
   10246:	417d                	li	sp,31
   10248:	0020973b          	sllw	a4,ra,sp
   1024c:	800003b7          	lui	t2,0x80000
   10250:	1c771963          	bne	a4,t2,10422 <fail>

0000000000010254 <test_12>:
   10254:	41b1                	li	gp,12
   10256:	212120b7          	lui	ra,0x21212
   1025a:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   1025e:	4101                	li	sp,0
   10260:	0020973b          	sllw	a4,ra,sp
   10264:	212123b7          	lui	t2,0x21212
   10268:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200221>
   1026c:	1a771b63          	bne	a4,t2,10422 <fail>

0000000000010270 <test_13>:
   10270:	41b5                	li	gp,13
   10272:	212120b7          	lui	ra,0x21212
   10276:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   1027a:	4105                	li	sp,1
   1027c:	0020973b          	sllw	a4,ra,sp
   10280:	424243b7          	lui	t2,0x42424
   10284:	2423839b          	addw	t2,t2,578 # 42424242 <__global_pointer$+0x42412342>
   10288:	18771d63          	bne	a4,t2,10422 <fail>

000000000001028c <test_14>:
   1028c:	41b9                	li	gp,14
   1028e:	212120b7          	lui	ra,0x21212
   10292:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   10296:	411d                	li	sp,7
   10298:	0020973b          	sllw	a4,ra,sp
   1029c:	909093b7          	lui	t2,0x90909
   102a0:	0803839b          	addw	t2,t2,128 # ffffffff90909080 <__global_pointer$+0xffffffff908f7180>
   102a4:	16771f63          	bne	a4,t2,10422 <fail>

00000000000102a8 <test_15>:
   102a8:	41bd                	li	gp,15
   102aa:	212120b7          	lui	ra,0x21212
   102ae:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   102b2:	4139                	li	sp,14
   102b4:	0020973b          	sllw	a4,ra,sp
   102b8:	484843b7          	lui	t2,0x48484
   102bc:	16771363          	bne	a4,t2,10422 <fail>

00000000000102c0 <test_16>:
   102c0:	41c1                	li	gp,16
   102c2:	212120b7          	lui	ra,0x21212
   102c6:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   102ca:	417d                	li	sp,31
   102cc:	0020973b          	sllw	a4,ra,sp
   102d0:	800003b7          	lui	t2,0x80000
   102d4:	14771763          	bne	a4,t2,10422 <fail>

00000000000102d8 <test_17>:
   102d8:	41c5                	li	gp,17
   102da:	212120b7          	lui	ra,0x21212
   102de:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   102e2:	5101                	li	sp,-32
   102e4:	0020973b          	sllw	a4,ra,sp
   102e8:	212123b7          	lui	t2,0x21212
   102ec:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200221>
   102f0:	12771963          	bne	a4,t2,10422 <fail>

00000000000102f4 <test_18>:
   102f4:	41c9                	li	gp,18
   102f6:	212120b7          	lui	ra,0x21212
   102fa:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   102fe:	5105                	li	sp,-31
   10300:	0020973b          	sllw	a4,ra,sp
   10304:	424243b7          	lui	t2,0x42424
   10308:	2423839b          	addw	t2,t2,578 # 42424242 <__global_pointer$+0x42412342>
   1030c:	10771b63          	bne	a4,t2,10422 <fail>

0000000000010310 <test_19>:
   10310:	41cd                	li	gp,19
   10312:	212120b7          	lui	ra,0x21212
   10316:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   1031a:	511d                	li	sp,-25
   1031c:	0020973b          	sllw	a4,ra,sp
   10320:	909093b7          	lui	t2,0x90909
   10324:	0803839b          	addw	t2,t2,128 # ffffffff90909080 <__global_pointer$+0xffffffff908f7180>
   10328:	0e771d63          	bne	a4,t2,10422 <fail>

000000000001032c <test_20>:
   1032c:	41d1                	li	gp,20
   1032e:	212120b7          	lui	ra,0x21212
   10332:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   10336:	5139                	li	sp,-18
   10338:	0020973b          	sllw	a4,ra,sp
   1033c:	484843b7          	lui	t2,0x48484
   10340:	0e771163          	bne	a4,t2,10422 <fail>

0000000000010344 <test_21>:
   10344:	41d5                	li	gp,21
   10346:	212120b7          	lui	ra,0x21212
   1034a:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200221>
   1034e:	517d                	li	sp,-1
   10350:	0020973b          	sllw	a4,ra,sp
   10354:	800003b7          	lui	t2,0x80000
   10358:	0c771563          	bne	a4,t2,10422 <fail>

000000000001035c <test_44>:
   1035c:	02c00193          	li	gp,44
   10360:	fff120b7          	lui	ra,0xfff12
   10364:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00445>
   10368:	00b2                	sll	ra,ra,0xc
   1036a:	67808093          	add	ra,ra,1656
   1036e:	4101                	li	sp,0
   10370:	0020973b          	sllw	a4,ra,sp
   10374:	123453b7          	lui	t2,0x12345
   10378:	6783839b          	addw	t2,t2,1656 # 12345678 <__global_pointer$+0x12333778>
   1037c:	0a771363          	bne	a4,t2,10422 <fail>

0000000000010380 <test_45>:
   10380:	02d00193          	li	gp,45
   10384:	fff120b7          	lui	ra,0xfff12
   10388:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00445>
   1038c:	00b2                	sll	ra,ra,0xc
   1038e:	67808093          	add	ra,ra,1656
   10392:	4111                	li	sp,4
   10394:	0020973b          	sllw	a4,ra,sp
   10398:	234563b7          	lui	t2,0x23456
   1039c:	7803839b          	addw	t2,t2,1920 # 23456780 <__global_pointer$+0x23444880>
   103a0:	08771163          	bne	a4,t2,10422 <fail>

00000000000103a4 <test_46>:
   103a4:	02e00193          	li	gp,46
   103a8:	000920b7          	lui	ra,0x92
   103ac:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80445>
   103b0:	00b2                	sll	ra,ra,0xc
   103b2:	67808093          	add	ra,ra,1656
   103b6:	4101                	li	sp,0
   103b8:	0020973b          	sllw	a4,ra,sp
   103bc:	923453b7          	lui	t2,0x92345
   103c0:	6783839b          	addw	t2,t2,1656 # ffffffff92345678 <__global_pointer$+0xffffffff92333778>
   103c4:	04771f63          	bne	a4,t2,10422 <fail>

00000000000103c8 <test_47>:
   103c8:	02f00193          	li	gp,47
   103cc:	000990b7          	lui	ra,0x99
   103d0:	3450809b          	addw	ra,ra,837 # 99345 <__global_pointer$+0x87445>
   103d4:	00b2                	sll	ra,ra,0xc
   103d6:	67808093          	add	ra,ra,1656
   103da:	4111                	li	sp,4
   103dc:	0020973b          	sllw	a4,ra,sp
   103e0:	934563b7          	lui	t2,0x93456
   103e4:	7803839b          	addw	t2,t2,1920 # ffffffff93456780 <__global_pointer$+0xffffffff93444880>
   103e8:	02771d63          	bne	a4,t2,10422 <fail>

00000000000103ec <test_22>:
   103ec:	41d9                	li	gp,22
   103ee:	4085                	li	ra,1
   103f0:	411d                	li	sp,7
   103f2:	002090bb          	sllw	ra,ra,sp
   103f6:	08000393          	li	t2,128
   103fa:	02709463          	bne	ra,t2,10422 <fail>

00000000000103fe <test_23>:
   103fe:	41dd                	li	gp,23
   10400:	4085                	li	ra,1
   10402:	4139                	li	sp,14
   10404:	0020913b          	sllw	sp,ra,sp
   10408:	6391                	lui	t2,0x4
   1040a:	00711c63          	bne	sp,t2,10422 <fail>

000000000001040e <test_24>:
   1040e:	41e1                	li	gp,24
   10410:	408d                	li	ra,3
   10412:	001090bb          	sllw	ra,ra,ra
   10416:	43e1                	li	t2,24
   10418:	00709563          	bne	ra,t2,10422 <fail>
   1041c:	00301263          	bne	zero,gp,10420 <pass>

0000000000010420 <pass>:
   10420:	a019                	j	10426 <continue>

0000000000010422 <fail>:
   10422:	00000000          	.word	0x00000000

0000000000010426 <continue>:
   10426:	4081                	li	ra,0
   10428:	4781                	li	a5,0
   1042a:	853e                	mv	a0,a5
   1042c:	6462                	ld	s0,24(sp)
   1042e:	6105                	add	sp,sp,32
   10430:	8082                	ret

0000000000010432 <__libc_init_array>:
   10432:	1101                	add	sp,sp,-32
   10434:	e822                	sd	s0,16(sp)
   10436:	67c5                	lui	a5,0x11
   10438:	6445                	lui	s0,0x11
   1043a:	e04a                	sd	s2,0(sp)
   1043c:	6e878793          	add	a5,a5,1768 # 116e8 <__init_array_start>
   10440:	6e840713          	add	a4,s0,1768 # 116e8 <__init_array_start>
   10444:	ec06                	sd	ra,24(sp)
   10446:	e426                	sd	s1,8(sp)
   10448:	40e78933          	sub	s2,a5,a4
   1044c:	00e78d63          	beq	a5,a4,10466 <__libc_init_array+0x34>
   10450:	40395913          	sra	s2,s2,0x3
   10454:	6e840413          	add	s0,s0,1768
   10458:	4481                	li	s1,0
   1045a:	601c                	ld	a5,0(s0)
   1045c:	0485                	add	s1,s1,1
   1045e:	0421                	add	s0,s0,8
   10460:	9782                	jalr	a5
   10462:	ff24ece3          	bltu	s1,s2,1045a <__libc_init_array+0x28>
   10466:	6445                	lui	s0,0x11
   10468:	67c5                	lui	a5,0x11
   1046a:	6f878793          	add	a5,a5,1784 # 116f8 <__do_global_dtors_aux_fini_array_entry>
   1046e:	6e840713          	add	a4,s0,1768 # 116e8 <__init_array_start>
   10472:	40e78933          	sub	s2,a5,a4
   10476:	40395913          	sra	s2,s2,0x3
   1047a:	00e78b63          	beq	a5,a4,10490 <__libc_init_array+0x5e>
   1047e:	6e840413          	add	s0,s0,1768
   10482:	4481                	li	s1,0
   10484:	601c                	ld	a5,0(s0)
   10486:	0485                	add	s1,s1,1
   10488:	0421                	add	s0,s0,8
   1048a:	9782                	jalr	a5
   1048c:	ff24ece3          	bltu	s1,s2,10484 <__libc_init_array+0x52>
   10490:	60e2                	ld	ra,24(sp)
   10492:	6442                	ld	s0,16(sp)
   10494:	64a2                	ld	s1,8(sp)
   10496:	6902                	ld	s2,0(sp)
   10498:	6105                	add	sp,sp,32
   1049a:	8082                	ret

000000000001049c <memset>:
   1049c:	433d                	li	t1,15
   1049e:	872a                	mv	a4,a0
   104a0:	02c37163          	bgeu	t1,a2,104c2 <memset+0x26>
   104a4:	00f77793          	and	a5,a4,15
   104a8:	e3c1                	bnez	a5,10528 <memset+0x8c>
   104aa:	e1bd                	bnez	a1,10510 <memset+0x74>
   104ac:	ff067693          	and	a3,a2,-16
   104b0:	8a3d                	and	a2,a2,15
   104b2:	96ba                	add	a3,a3,a4
   104b4:	e30c                	sd	a1,0(a4)
   104b6:	e70c                	sd	a1,8(a4)
   104b8:	0741                	add	a4,a4,16
   104ba:	fed76de3          	bltu	a4,a3,104b4 <memset+0x18>
   104be:	e211                	bnez	a2,104c2 <memset+0x26>
   104c0:	8082                	ret
   104c2:	40c306b3          	sub	a3,t1,a2
   104c6:	068a                	sll	a3,a3,0x2
   104c8:	00000297          	auipc	t0,0x0
   104cc:	9696                	add	a3,a3,t0
   104ce:	00a68067          	jr	10(a3)
   104d2:	00b70723          	sb	a1,14(a4)
   104d6:	00b706a3          	sb	a1,13(a4)
   104da:	00b70623          	sb	a1,12(a4)
   104de:	00b705a3          	sb	a1,11(a4)
   104e2:	00b70523          	sb	a1,10(a4)
   104e6:	00b704a3          	sb	a1,9(a4)
   104ea:	00b70423          	sb	a1,8(a4)
   104ee:	00b703a3          	sb	a1,7(a4)
   104f2:	00b70323          	sb	a1,6(a4)
   104f6:	00b702a3          	sb	a1,5(a4)
   104fa:	00b70223          	sb	a1,4(a4)
   104fe:	00b701a3          	sb	a1,3(a4)
   10502:	00b70123          	sb	a1,2(a4)
   10506:	00b700a3          	sb	a1,1(a4)
   1050a:	00b70023          	sb	a1,0(a4)
   1050e:	8082                	ret
   10510:	0ff5f593          	zext.b	a1,a1
   10514:	00859693          	sll	a3,a1,0x8
   10518:	8dd5                	or	a1,a1,a3
   1051a:	01059693          	sll	a3,a1,0x10
   1051e:	8dd5                	or	a1,a1,a3
   10520:	02059693          	sll	a3,a1,0x20
   10524:	8dd5                	or	a1,a1,a3
   10526:	b759                	j	104ac <memset+0x10>
   10528:	00279693          	sll	a3,a5,0x2
   1052c:	00000297          	auipc	t0,0x0
   10530:	9696                	add	a3,a3,t0
   10532:	8286                	mv	t0,ra
   10534:	fa2680e7          	jalr	-94(a3)
   10538:	8096                	mv	ra,t0
   1053a:	17c1                	add	a5,a5,-16
   1053c:	8f1d                	sub	a4,a4,a5
   1053e:	963e                	add	a2,a2,a5
   10540:	f8c371e3          	bgeu	t1,a2,104c2 <memset+0x26>
   10544:	b79d                	j	104aa <memset+0xe>

0000000000010546 <__call_exitprocs>:
   10546:	715d                	add	sp,sp,-80
   10548:	f052                	sd	s4,32(sp)
   1054a:	f481ba03          	ld	s4,-184(gp) # 11e48 <_global_impure_ptr>
   1054e:	f84a                	sd	s2,48(sp)
   10550:	e486                	sd	ra,72(sp)
   10552:	1f8a3903          	ld	s2,504(s4)
   10556:	e0a2                	sd	s0,64(sp)
   10558:	fc26                	sd	s1,56(sp)
   1055a:	f44e                	sd	s3,40(sp)
   1055c:	ec56                	sd	s5,24(sp)
   1055e:	e85a                	sd	s6,16(sp)
   10560:	e45e                	sd	s7,8(sp)
   10562:	e062                	sd	s8,0(sp)
   10564:	02090863          	beqz	s2,10594 <__call_exitprocs+0x4e>
   10568:	8b2a                	mv	s6,a0
   1056a:	8bae                	mv	s7,a1
   1056c:	4a85                	li	s5,1
   1056e:	59fd                	li	s3,-1
   10570:	00892483          	lw	s1,8(s2)
   10574:	fff4841b          	addw	s0,s1,-1
   10578:	00044e63          	bltz	s0,10594 <__call_exitprocs+0x4e>
   1057c:	048e                	sll	s1,s1,0x3
   1057e:	94ca                	add	s1,s1,s2
   10580:	020b8663          	beqz	s7,105ac <__call_exitprocs+0x66>
   10584:	2084b783          	ld	a5,520(s1)
   10588:	03778263          	beq	a5,s7,105ac <__call_exitprocs+0x66>
   1058c:	347d                	addw	s0,s0,-1
   1058e:	14e1                	add	s1,s1,-8
   10590:	ff3418e3          	bne	s0,s3,10580 <__call_exitprocs+0x3a>
   10594:	60a6                	ld	ra,72(sp)
   10596:	6406                	ld	s0,64(sp)
   10598:	74e2                	ld	s1,56(sp)
   1059a:	7942                	ld	s2,48(sp)
   1059c:	79a2                	ld	s3,40(sp)
   1059e:	7a02                	ld	s4,32(sp)
   105a0:	6ae2                	ld	s5,24(sp)
   105a2:	6b42                	ld	s6,16(sp)
   105a4:	6ba2                	ld	s7,8(sp)
   105a6:	6c02                	ld	s8,0(sp)
   105a8:	6161                	add	sp,sp,80
   105aa:	8082                	ret
   105ac:	00892783          	lw	a5,8(s2)
   105b0:	6498                	ld	a4,8(s1)
   105b2:	37fd                	addw	a5,a5,-1
   105b4:	04878463          	beq	a5,s0,105fc <__call_exitprocs+0xb6>
   105b8:	0004b423          	sd	zero,8(s1)
   105bc:	db61                	beqz	a4,1058c <__call_exitprocs+0x46>
   105be:	31092783          	lw	a5,784(s2)
   105c2:	008a96bb          	sllw	a3,s5,s0
   105c6:	00892c03          	lw	s8,8(s2)
   105ca:	8ff5                	and	a5,a5,a3
   105cc:	2781                	sext.w	a5,a5
   105ce:	ef89                	bnez	a5,105e8 <__call_exitprocs+0xa2>
   105d0:	9702                	jalr	a4
   105d2:	00892703          	lw	a4,8(s2)
   105d6:	1f8a3783          	ld	a5,504(s4)
   105da:	01871463          	bne	a4,s8,105e2 <__call_exitprocs+0x9c>
   105de:	fb2787e3          	beq	a5,s2,1058c <__call_exitprocs+0x46>
   105e2:	dbcd                	beqz	a5,10594 <__call_exitprocs+0x4e>
   105e4:	893e                	mv	s2,a5
   105e6:	b769                	j	10570 <__call_exitprocs+0x2a>
   105e8:	31492783          	lw	a5,788(s2)
   105ec:	1084b583          	ld	a1,264(s1)
   105f0:	8ff5                	and	a5,a5,a3
   105f2:	2781                	sext.w	a5,a5
   105f4:	e799                	bnez	a5,10602 <__call_exitprocs+0xbc>
   105f6:	855a                	mv	a0,s6
   105f8:	9702                	jalr	a4
   105fa:	bfe1                	j	105d2 <__call_exitprocs+0x8c>
   105fc:	00892423          	sw	s0,8(s2)
   10600:	bf75                	j	105bc <__call_exitprocs+0x76>
   10602:	852e                	mv	a0,a1
   10604:	9702                	jalr	a4
   10606:	b7f1                	j	105d2 <__call_exitprocs+0x8c>

0000000000010608 <__libc_fini_array>:
   10608:	1101                	add	sp,sp,-32
   1060a:	e822                	sd	s0,16(sp)
   1060c:	67c5                	lui	a5,0x11
   1060e:	6445                	lui	s0,0x11
   10610:	6f878793          	add	a5,a5,1784 # 116f8 <__do_global_dtors_aux_fini_array_entry>
   10614:	70040413          	add	s0,s0,1792 # 11700 <impure_data>
   10618:	8c1d                	sub	s0,s0,a5
   1061a:	e426                	sd	s1,8(sp)
   1061c:	ec06                	sd	ra,24(sp)
   1061e:	40345493          	sra	s1,s0,0x3
   10622:	c881                	beqz	s1,10632 <__libc_fini_array+0x2a>
   10624:	1461                	add	s0,s0,-8
   10626:	943e                	add	s0,s0,a5
   10628:	601c                	ld	a5,0(s0)
   1062a:	14fd                	add	s1,s1,-1
   1062c:	1461                	add	s0,s0,-8
   1062e:	9782                	jalr	a5
   10630:	fce5                	bnez	s1,10628 <__libc_fini_array+0x20>
   10632:	60e2                	ld	ra,24(sp)
   10634:	6442                	ld	s0,16(sp)
   10636:	64a2                	ld	s1,8(sp)
   10638:	6105                	add	sp,sp,32
   1063a:	8082                	ret

000000000001063c <atexit>:
   1063c:	85aa                	mv	a1,a0
   1063e:	4681                	li	a3,0
   10640:	4601                	li	a2,0
   10642:	4501                	li	a0,0
   10644:	a009                	j	10646 <__register_exitproc>

0000000000010646 <__register_exitproc>:
   10646:	f481b703          	ld	a4,-184(gp) # 11e48 <_global_impure_ptr>
   1064a:	1f873783          	ld	a5,504(a4)
   1064e:	c3b1                	beqz	a5,10692 <__register_exitproc+0x4c>
   10650:	4798                	lw	a4,8(a5)
   10652:	487d                	li	a6,31
   10654:	06e84263          	blt	a6,a4,106b8 <__register_exitproc+0x72>
   10658:	c505                	beqz	a0,10680 <__register_exitproc+0x3a>
   1065a:	00371813          	sll	a6,a4,0x3
   1065e:	983e                	add	a6,a6,a5
   10660:	10c83823          	sd	a2,272(a6)
   10664:	3107a883          	lw	a7,784(a5)
   10668:	4605                	li	a2,1
   1066a:	00e6163b          	sllw	a2,a2,a4
   1066e:	00c8e8b3          	or	a7,a7,a2
   10672:	3117a823          	sw	a7,784(a5)
   10676:	20d83823          	sd	a3,528(a6)
   1067a:	4689                	li	a3,2
   1067c:	02d50063          	beq	a0,a3,1069c <__register_exitproc+0x56>
   10680:	00270693          	add	a3,a4,2
   10684:	068e                	sll	a3,a3,0x3
   10686:	2705                	addw	a4,a4,1
   10688:	c798                	sw	a4,8(a5)
   1068a:	97b6                	add	a5,a5,a3
   1068c:	e38c                	sd	a1,0(a5)
   1068e:	4501                	li	a0,0
   10690:	8082                	ret
   10692:	20070793          	add	a5,a4,512
   10696:	1ef73c23          	sd	a5,504(a4)
   1069a:	bf5d                	j	10650 <__register_exitproc+0xa>
   1069c:	3147a683          	lw	a3,788(a5)
   106a0:	4501                	li	a0,0
   106a2:	8ed1                	or	a3,a3,a2
   106a4:	30d7aa23          	sw	a3,788(a5)
   106a8:	00270693          	add	a3,a4,2
   106ac:	068e                	sll	a3,a3,0x3
   106ae:	2705                	addw	a4,a4,1
   106b0:	c798                	sw	a4,8(a5)
   106b2:	97b6                	add	a5,a5,a3
   106b4:	e38c                	sd	a1,0(a5)
   106b6:	8082                	ret
   106b8:	557d                	li	a0,-1
   106ba:	8082                	ret

00000000000106bc <_exit>:
   106bc:	05d00893          	li	a7,93
   106c0:	00000073          	ecall
   106c4:	00054363          	bltz	a0,106ca <_exit+0xe>
   106c8:	a001                	j	106c8 <_exit+0xc>
   106ca:	1141                	add	sp,sp,-16
   106cc:	e022                	sd	s0,0(sp)
   106ce:	842a                	mv	s0,a0
   106d0:	e406                	sd	ra,8(sp)
   106d2:	4080043b          	negw	s0,s0
   106d6:	008000ef          	jal	106de <__errno>
   106da:	c100                	sw	s0,0(a0)
   106dc:	a001                	j	106dc <_exit+0x20>

00000000000106de <__errno>:
   106de:	f581b503          	ld	a0,-168(gp) # 11e58 <_impure_ptr>
   106e2:	8082                	ret

lh.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2e4000ef          	jal	103d6 <__call_exitprocs>
   100f6:	fb81b503          	ld	a0,-72(gp) # 11d48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	44a000ef          	jal	1054c <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	49850513          	add	a0,a0,1176 # 10498 <__libc_fini_array>
   10112:	ae6d                	j	104cc <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c7a18193          	add	gp,gp,-902 # 11d90 <__global_pointer$>
   1011e:	fd018513          	add	a0,gp,-48 # 11d60 <completed.1>
   10122:	00818613          	add	a2,gp,8 # 11d98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	202000ef          	jal	1032c <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	39e50513          	add	a0,a0,926 # 104cc <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36050513          	add	a0,a0,864 # 10498 <__libc_fini_array>
   10140:	38c000ef          	jal	104cc <atexit>
   10144:	17e000ef          	jal	102c2 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fd01c783          	lbu	a5,-48(gp) # 11d60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	57450513          	add	a0,a0,1396 # 11574 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fcf18823          	sb	a5,-48(gp) # 11d60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fd818593          	add	a1,gp,-40 # 11d68 <object.0>
   1018e:	57450513          	add	a0,a0,1396 # 11574 <__EH_FRAME_BEGIN__>
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
   101ae:	0ff00793          	li	a5,255
   101b2:	00001097          	auipc	ra,0x1
   101b6:	3de08093          	add	ra,ra,990 # 11590 <__DATA_BEGIN__>
   101ba:	00009703          	lh	a4,0(ra)
   101be:	0ff00393          	li	t2,255
   101c2:	0e771863          	bne	a4,t2,102b2 <fail>

00000000000101c6 <test_3>:
   101c6:	418d                	li	gp,3
   101c8:	f0000793          	li	a5,-256
   101cc:	00001097          	auipc	ra,0x1
   101d0:	3c408093          	add	ra,ra,964 # 11590 <__DATA_BEGIN__>
   101d4:	00209703          	lh	a4,2(ra)
   101d8:	f0000393          	li	t2,-256
   101dc:	0c771b63          	bne	a4,t2,102b2 <fail>

00000000000101e0 <test_4>:
   101e0:	4191                	li	gp,4
   101e2:	6785                	lui	a5,0x1
   101e4:	37c1                	addw	a5,a5,-16 # ff0 <exit-0xf0f8>
   101e6:	00001097          	auipc	ra,0x1
   101ea:	3aa08093          	add	ra,ra,938 # 11590 <__DATA_BEGIN__>
   101ee:	00409703          	lh	a4,4(ra)
   101f2:	6385                	lui	t2,0x1
   101f4:	33c1                	addw	t2,t2,-16 # ff0 <exit-0xf0f8>
   101f6:	0a771e63          	bne	a4,t2,102b2 <fail>

00000000000101fa <test_5>:
   101fa:	4195                	li	gp,5
   101fc:	77fd                	lui	a5,0xfffff
   101fe:	27bd                	addw	a5,a5,15 # fffffffffffff00f <__BSS_END__+0xfffffffffffed277>
   10200:	00001097          	auipc	ra,0x1
   10204:	39008093          	add	ra,ra,912 # 11590 <__DATA_BEGIN__>
   10208:	00609703          	lh	a4,6(ra)
   1020c:	73fd                	lui	t2,0xfffff
   1020e:	23bd                	addw	t2,t2,15 # fffffffffffff00f <__BSS_END__+0xfffffffffffed277>
   10210:	0a771163          	bne	a4,t2,102b2 <fail>

0000000000010214 <test_6>:
   10214:	4199                	li	gp,6
   10216:	0ff00793          	li	a5,255
   1021a:	00001097          	auipc	ra,0x1
   1021e:	37c08093          	add	ra,ra,892 # 11596 <tdat4>
   10222:	ffa09703          	lh	a4,-6(ra)
   10226:	0ff00393          	li	t2,255
   1022a:	08771463          	bne	a4,t2,102b2 <fail>

000000000001022e <test_7>:
   1022e:	419d                	li	gp,7
   10230:	f0000793          	li	a5,-256
   10234:	00001097          	auipc	ra,0x1
   10238:	36208093          	add	ra,ra,866 # 11596 <tdat4>
   1023c:	ffc09703          	lh	a4,-4(ra)
   10240:	f0000393          	li	t2,-256
   10244:	06771763          	bne	a4,t2,102b2 <fail>

0000000000010248 <test_8>:
   10248:	41a1                	li	gp,8
   1024a:	6785                	lui	a5,0x1
   1024c:	37c1                	addw	a5,a5,-16 # ff0 <exit-0xf0f8>
   1024e:	00001097          	auipc	ra,0x1
   10252:	34808093          	add	ra,ra,840 # 11596 <tdat4>
   10256:	ffe09703          	lh	a4,-2(ra)
   1025a:	6385                	lui	t2,0x1
   1025c:	33c1                	addw	t2,t2,-16 # ff0 <exit-0xf0f8>
   1025e:	04771a63          	bne	a4,t2,102b2 <fail>

0000000000010262 <test_9>:
   10262:	41a5                	li	gp,9
   10264:	77fd                	lui	a5,0xfffff
   10266:	27bd                	addw	a5,a5,15 # fffffffffffff00f <__BSS_END__+0xfffffffffffed277>
   10268:	00001097          	auipc	ra,0x1
   1026c:	32e08093          	add	ra,ra,814 # 11596 <tdat4>
   10270:	00009703          	lh	a4,0(ra)
   10274:	73fd                	lui	t2,0xfffff
   10276:	23bd                	addw	t2,t2,15 # fffffffffffff00f <__BSS_END__+0xfffffffffffed277>
   10278:	02771d63          	bne	a4,t2,102b2 <fail>

000000000001027c <test_10>:
   1027c:	41a9                	li	gp,10
   1027e:	00001097          	auipc	ra,0x1
   10282:	31208093          	add	ra,ra,786 # 11590 <__DATA_BEGIN__>
   10286:	1081                	add	ra,ra,-32
   10288:	02009283          	lh	t0,32(ra)
   1028c:	0ff00393          	li	t2,255
   10290:	02729163          	bne	t0,t2,102b2 <fail>

0000000000010294 <test_11>:
   10294:	41ad                	li	gp,11
   10296:	00001097          	auipc	ra,0x1
   1029a:	2fa08093          	add	ra,ra,762 # 11590 <__DATA_BEGIN__>
   1029e:	10ed                	add	ra,ra,-5
   102a0:	00709283          	lh	t0,7(ra)
   102a4:	f0000393          	li	t2,-256
   102a8:	00729563          	bne	t0,t2,102b2 <fail>
   102ac:	00301263          	bne	zero,gp,102b0 <pass>

00000000000102b0 <pass>:
   102b0:	a019                	j	102b6 <continue>

00000000000102b2 <fail>:
   102b2:	0000                	unimp
	...

00000000000102b6 <continue>:
   102b6:	4081                	li	ra,0
   102b8:	4781                	li	a5,0
   102ba:	853e                	mv	a0,a5
   102bc:	6462                	ld	s0,24(sp)
   102be:	6105                	add	sp,sp,32
   102c0:	8082                	ret

00000000000102c2 <__libc_init_array>:
   102c2:	1101                	add	sp,sp,-32
   102c4:	e822                	sd	s0,16(sp)
   102c6:	67c5                	lui	a5,0x11
   102c8:	6445                	lui	s0,0x11
   102ca:	e04a                	sd	s2,0(sp)
   102cc:	57878793          	add	a5,a5,1400 # 11578 <__init_array_start>
   102d0:	57840713          	add	a4,s0,1400 # 11578 <__init_array_start>
   102d4:	ec06                	sd	ra,24(sp)
   102d6:	e426                	sd	s1,8(sp)
   102d8:	40e78933          	sub	s2,a5,a4
   102dc:	00e78d63          	beq	a5,a4,102f6 <__libc_init_array+0x34>
   102e0:	40395913          	sra	s2,s2,0x3
   102e4:	57840413          	add	s0,s0,1400
   102e8:	4481                	li	s1,0
   102ea:	601c                	ld	a5,0(s0)
   102ec:	0485                	add	s1,s1,1
   102ee:	0421                	add	s0,s0,8
   102f0:	9782                	jalr	a5
   102f2:	ff24ece3          	bltu	s1,s2,102ea <__libc_init_array+0x28>
   102f6:	6445                	lui	s0,0x11
   102f8:	67c5                	lui	a5,0x11
   102fa:	58878793          	add	a5,a5,1416 # 11588 <__do_global_dtors_aux_fini_array_entry>
   102fe:	57840713          	add	a4,s0,1400 # 11578 <__init_array_start>
   10302:	40e78933          	sub	s2,a5,a4
   10306:	40395913          	sra	s2,s2,0x3
   1030a:	00e78b63          	beq	a5,a4,10320 <__libc_init_array+0x5e>
   1030e:	57840413          	add	s0,s0,1400
   10312:	4481                	li	s1,0
   10314:	601c                	ld	a5,0(s0)
   10316:	0485                	add	s1,s1,1
   10318:	0421                	add	s0,s0,8
   1031a:	9782                	jalr	a5
   1031c:	ff24ece3          	bltu	s1,s2,10314 <__libc_init_array+0x52>
   10320:	60e2                	ld	ra,24(sp)
   10322:	6442                	ld	s0,16(sp)
   10324:	64a2                	ld	s1,8(sp)
   10326:	6902                	ld	s2,0(sp)
   10328:	6105                	add	sp,sp,32
   1032a:	8082                	ret

000000000001032c <memset>:
   1032c:	433d                	li	t1,15
   1032e:	872a                	mv	a4,a0
   10330:	02c37163          	bgeu	t1,a2,10352 <memset+0x26>
   10334:	00f77793          	and	a5,a4,15
   10338:	e3c1                	bnez	a5,103b8 <memset+0x8c>
   1033a:	e1bd                	bnez	a1,103a0 <memset+0x74>
   1033c:	ff067693          	and	a3,a2,-16
   10340:	8a3d                	and	a2,a2,15
   10342:	96ba                	add	a3,a3,a4
   10344:	e30c                	sd	a1,0(a4)
   10346:	e70c                	sd	a1,8(a4)
   10348:	0741                	add	a4,a4,16
   1034a:	fed76de3          	bltu	a4,a3,10344 <memset+0x18>
   1034e:	e211                	bnez	a2,10352 <memset+0x26>
   10350:	8082                	ret
   10352:	40c306b3          	sub	a3,t1,a2
   10356:	068a                	sll	a3,a3,0x2
   10358:	00000297          	auipc	t0,0x0
   1035c:	9696                	add	a3,a3,t0
   1035e:	00a68067          	jr	10(a3)
   10362:	00b70723          	sb	a1,14(a4)
   10366:	00b706a3          	sb	a1,13(a4)
   1036a:	00b70623          	sb	a1,12(a4)
   1036e:	00b705a3          	sb	a1,11(a4)
   10372:	00b70523          	sb	a1,10(a4)
   10376:	00b704a3          	sb	a1,9(a4)
   1037a:	00b70423          	sb	a1,8(a4)
   1037e:	00b703a3          	sb	a1,7(a4)
   10382:	00b70323          	sb	a1,6(a4)
   10386:	00b702a3          	sb	a1,5(a4)
   1038a:	00b70223          	sb	a1,4(a4)
   1038e:	00b701a3          	sb	a1,3(a4)
   10392:	00b70123          	sb	a1,2(a4)
   10396:	00b700a3          	sb	a1,1(a4)
   1039a:	00b70023          	sb	a1,0(a4)
   1039e:	8082                	ret
   103a0:	0ff5f593          	zext.b	a1,a1
   103a4:	00859693          	sll	a3,a1,0x8
   103a8:	8dd5                	or	a1,a1,a3
   103aa:	01059693          	sll	a3,a1,0x10
   103ae:	8dd5                	or	a1,a1,a3
   103b0:	02059693          	sll	a3,a1,0x20
   103b4:	8dd5                	or	a1,a1,a3
   103b6:	b759                	j	1033c <memset+0x10>
   103b8:	00279693          	sll	a3,a5,0x2
   103bc:	00000297          	auipc	t0,0x0
   103c0:	9696                	add	a3,a3,t0
   103c2:	8286                	mv	t0,ra
   103c4:	fa2680e7          	jalr	-94(a3)
   103c8:	8096                	mv	ra,t0
   103ca:	17c1                	add	a5,a5,-16
   103cc:	8f1d                	sub	a4,a4,a5
   103ce:	963e                	add	a2,a2,a5
   103d0:	f8c371e3          	bgeu	t1,a2,10352 <memset+0x26>
   103d4:	b79d                	j	1033a <memset+0xe>

00000000000103d6 <__call_exitprocs>:
   103d6:	715d                	add	sp,sp,-80
   103d8:	f052                	sd	s4,32(sp)
   103da:	fb81ba03          	ld	s4,-72(gp) # 11d48 <_global_impure_ptr>
   103de:	f84a                	sd	s2,48(sp)
   103e0:	e486                	sd	ra,72(sp)
   103e2:	1f8a3903          	ld	s2,504(s4)
   103e6:	e0a2                	sd	s0,64(sp)
   103e8:	fc26                	sd	s1,56(sp)
   103ea:	f44e                	sd	s3,40(sp)
   103ec:	ec56                	sd	s5,24(sp)
   103ee:	e85a                	sd	s6,16(sp)
   103f0:	e45e                	sd	s7,8(sp)
   103f2:	e062                	sd	s8,0(sp)
   103f4:	02090863          	beqz	s2,10424 <__call_exitprocs+0x4e>
   103f8:	8b2a                	mv	s6,a0
   103fa:	8bae                	mv	s7,a1
   103fc:	4a85                	li	s5,1
   103fe:	59fd                	li	s3,-1
   10400:	00892483          	lw	s1,8(s2)
   10404:	fff4841b          	addw	s0,s1,-1
   10408:	00044e63          	bltz	s0,10424 <__call_exitprocs+0x4e>
   1040c:	048e                	sll	s1,s1,0x3
   1040e:	94ca                	add	s1,s1,s2
   10410:	020b8663          	beqz	s7,1043c <__call_exitprocs+0x66>
   10414:	2084b783          	ld	a5,520(s1)
   10418:	03778263          	beq	a5,s7,1043c <__call_exitprocs+0x66>
   1041c:	347d                	addw	s0,s0,-1
   1041e:	14e1                	add	s1,s1,-8
   10420:	ff3418e3          	bne	s0,s3,10410 <__call_exitprocs+0x3a>
   10424:	60a6                	ld	ra,72(sp)
   10426:	6406                	ld	s0,64(sp)
   10428:	74e2                	ld	s1,56(sp)
   1042a:	7942                	ld	s2,48(sp)
   1042c:	79a2                	ld	s3,40(sp)
   1042e:	7a02                	ld	s4,32(sp)
   10430:	6ae2                	ld	s5,24(sp)
   10432:	6b42                	ld	s6,16(sp)
   10434:	6ba2                	ld	s7,8(sp)
   10436:	6c02                	ld	s8,0(sp)
   10438:	6161                	add	sp,sp,80
   1043a:	8082                	ret
   1043c:	00892783          	lw	a5,8(s2)
   10440:	6498                	ld	a4,8(s1)
   10442:	37fd                	addw	a5,a5,-1
   10444:	04878463          	beq	a5,s0,1048c <__call_exitprocs+0xb6>
   10448:	0004b423          	sd	zero,8(s1)
   1044c:	db61                	beqz	a4,1041c <__call_exitprocs+0x46>
   1044e:	31092783          	lw	a5,784(s2)
   10452:	008a96bb          	sllw	a3,s5,s0
   10456:	00892c03          	lw	s8,8(s2)
   1045a:	8ff5                	and	a5,a5,a3
   1045c:	2781                	sext.w	a5,a5
   1045e:	ef89                	bnez	a5,10478 <__call_exitprocs+0xa2>
   10460:	9702                	jalr	a4
   10462:	00892703          	lw	a4,8(s2)
   10466:	1f8a3783          	ld	a5,504(s4)
   1046a:	01871463          	bne	a4,s8,10472 <__call_exitprocs+0x9c>
   1046e:	fb2787e3          	beq	a5,s2,1041c <__call_exitprocs+0x46>
   10472:	dbcd                	beqz	a5,10424 <__call_exitprocs+0x4e>
   10474:	893e                	mv	s2,a5
   10476:	b769                	j	10400 <__call_exitprocs+0x2a>
   10478:	31492783          	lw	a5,788(s2)
   1047c:	1084b583          	ld	a1,264(s1)
   10480:	8ff5                	and	a5,a5,a3
   10482:	2781                	sext.w	a5,a5
   10484:	e799                	bnez	a5,10492 <__call_exitprocs+0xbc>
   10486:	855a                	mv	a0,s6
   10488:	9702                	jalr	a4
   1048a:	bfe1                	j	10462 <__call_exitprocs+0x8c>
   1048c:	00892423          	sw	s0,8(s2)
   10490:	bf75                	j	1044c <__call_exitprocs+0x76>
   10492:	852e                	mv	a0,a1
   10494:	9702                	jalr	a4
   10496:	b7f1                	j	10462 <__call_exitprocs+0x8c>

0000000000010498 <__libc_fini_array>:
   10498:	1101                	add	sp,sp,-32
   1049a:	e822                	sd	s0,16(sp)
   1049c:	67c5                	lui	a5,0x11
   1049e:	6445                	lui	s0,0x11
   104a0:	58878793          	add	a5,a5,1416 # 11588 <__do_global_dtors_aux_fini_array_entry>
   104a4:	59040413          	add	s0,s0,1424 # 11590 <__DATA_BEGIN__>
   104a8:	8c1d                	sub	s0,s0,a5
   104aa:	e426                	sd	s1,8(sp)
   104ac:	ec06                	sd	ra,24(sp)
   104ae:	40345493          	sra	s1,s0,0x3
   104b2:	c881                	beqz	s1,104c2 <__libc_fini_array+0x2a>
   104b4:	1461                	add	s0,s0,-8
   104b6:	943e                	add	s0,s0,a5
   104b8:	601c                	ld	a5,0(s0)
   104ba:	14fd                	add	s1,s1,-1
   104bc:	1461                	add	s0,s0,-8
   104be:	9782                	jalr	a5
   104c0:	fce5                	bnez	s1,104b8 <__libc_fini_array+0x20>
   104c2:	60e2                	ld	ra,24(sp)
   104c4:	6442                	ld	s0,16(sp)
   104c6:	64a2                	ld	s1,8(sp)
   104c8:	6105                	add	sp,sp,32
   104ca:	8082                	ret

00000000000104cc <atexit>:
   104cc:	85aa                	mv	a1,a0
   104ce:	4681                	li	a3,0
   104d0:	4601                	li	a2,0
   104d2:	4501                	li	a0,0
   104d4:	a009                	j	104d6 <__register_exitproc>

00000000000104d6 <__register_exitproc>:
   104d6:	fb81b703          	ld	a4,-72(gp) # 11d48 <_global_impure_ptr>
   104da:	1f873783          	ld	a5,504(a4)
   104de:	c3b1                	beqz	a5,10522 <__register_exitproc+0x4c>
   104e0:	4798                	lw	a4,8(a5)
   104e2:	487d                	li	a6,31
   104e4:	06e84263          	blt	a6,a4,10548 <__register_exitproc+0x72>
   104e8:	c505                	beqz	a0,10510 <__register_exitproc+0x3a>
   104ea:	00371813          	sll	a6,a4,0x3
   104ee:	983e                	add	a6,a6,a5
   104f0:	10c83823          	sd	a2,272(a6)
   104f4:	3107a883          	lw	a7,784(a5)
   104f8:	4605                	li	a2,1
   104fa:	00e6163b          	sllw	a2,a2,a4
   104fe:	00c8e8b3          	or	a7,a7,a2
   10502:	3117a823          	sw	a7,784(a5)
   10506:	20d83823          	sd	a3,528(a6)
   1050a:	4689                	li	a3,2
   1050c:	02d50063          	beq	a0,a3,1052c <__register_exitproc+0x56>
   10510:	00270693          	add	a3,a4,2
   10514:	068e                	sll	a3,a3,0x3
   10516:	2705                	addw	a4,a4,1
   10518:	c798                	sw	a4,8(a5)
   1051a:	97b6                	add	a5,a5,a3
   1051c:	e38c                	sd	a1,0(a5)
   1051e:	4501                	li	a0,0
   10520:	8082                	ret
   10522:	20070793          	add	a5,a4,512
   10526:	1ef73c23          	sd	a5,504(a4)
   1052a:	bf5d                	j	104e0 <__register_exitproc+0xa>
   1052c:	3147a683          	lw	a3,788(a5)
   10530:	4501                	li	a0,0
   10532:	8ed1                	or	a3,a3,a2
   10534:	30d7aa23          	sw	a3,788(a5)
   10538:	00270693          	add	a3,a4,2
   1053c:	068e                	sll	a3,a3,0x3
   1053e:	2705                	addw	a4,a4,1
   10540:	c798                	sw	a4,8(a5)
   10542:	97b6                	add	a5,a5,a3
   10544:	e38c                	sd	a1,0(a5)
   10546:	8082                	ret
   10548:	557d                	li	a0,-1
   1054a:	8082                	ret

000000000001054c <_exit>:
   1054c:	05d00893          	li	a7,93
   10550:	00000073          	ecall
   10554:	00054363          	bltz	a0,1055a <_exit+0xe>
   10558:	a001                	j	10558 <_exit+0xc>
   1055a:	1141                	add	sp,sp,-16
   1055c:	e022                	sd	s0,0(sp)
   1055e:	842a                	mv	s0,a0
   10560:	e406                	sd	ra,8(sp)
   10562:	4080043b          	negw	s0,s0
   10566:	008000ef          	jal	1056e <__errno>
   1056a:	c100                	sw	s0,0(a0)
   1056c:	a001                	j	1056c <_exit+0x20>

000000000001056e <__errno>:
   1056e:	fc81b503          	ld	a0,-56(gp) # 11d58 <_impure_ptr>
   10572:	8082                	ret

lhu.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2ee000ef          	jal	103e0 <__call_exitprocs>
   100f6:	fa81b503          	ld	a0,-88(gp) # 11d48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	454000ef          	jal	10556 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4a250513          	add	a0,a0,1186 # 104a2 <__libc_fini_array>
   10112:	a6d1                	j	104d6 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c8a18193          	add	gp,gp,-886 # 11da0 <__global_pointer$>
   1011e:	fc018513          	add	a0,gp,-64 # 11d60 <completed.1>
   10122:	ff818613          	add	a2,gp,-8 # 11d98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	20c000ef          	jal	10336 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3a850513          	add	a0,a0,936 # 104d6 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36a50513          	add	a0,a0,874 # 104a2 <__libc_fini_array>
   10140:	396000ef          	jal	104d6 <atexit>
   10144:	188000ef          	jal	102cc <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fc01c783          	lbu	a5,-64(gp) # 11d60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fcf18023          	sb	a5,-64(gp) # 11d60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fc818593          	add	a1,gp,-56 # 11d68 <object.0>
   1018e:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
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
   101ae:	0ff00793          	li	a5,255
   101b2:	00001097          	auipc	ra,0x1
   101b6:	3ee08093          	add	ra,ra,1006 # 115a0 <__DATA_BEGIN__>
   101ba:	0000d703          	lhu	a4,0(ra)
   101be:	0ff00393          	li	t2,255
   101c2:	0e771d63          	bne	a4,t2,102bc <fail>

00000000000101c6 <test_3>:
   101c6:	418d                	li	gp,3
   101c8:	67c1                	lui	a5,0x10
   101ca:	f007879b          	addw	a5,a5,-256 # ff00 <exit-0x1e8>
   101ce:	00001097          	auipc	ra,0x1
   101d2:	3d208093          	add	ra,ra,978 # 115a0 <__DATA_BEGIN__>
   101d6:	0020d703          	lhu	a4,2(ra)
   101da:	63c1                	lui	t2,0x10
   101dc:	f003839b          	addw	t2,t2,-256 # ff00 <exit-0x1e8>
   101e0:	0c771e63          	bne	a4,t2,102bc <fail>

00000000000101e4 <test_4>:
   101e4:	4191                	li	gp,4
   101e6:	6785                	lui	a5,0x1
   101e8:	37c1                	addw	a5,a5,-16 # ff0 <exit-0xf0f8>
   101ea:	00001097          	auipc	ra,0x1
   101ee:	3b608093          	add	ra,ra,950 # 115a0 <__DATA_BEGIN__>
   101f2:	0040d703          	lhu	a4,4(ra)
   101f6:	6385                	lui	t2,0x1
   101f8:	33c1                	addw	t2,t2,-16 # ff0 <exit-0xf0f8>
   101fa:	0c771163          	bne	a4,t2,102bc <fail>

00000000000101fe <test_5>:
   101fe:	4195                	li	gp,5
   10200:	67bd                	lui	a5,0xf
   10202:	27bd                	addw	a5,a5,15 # f00f <exit-0x10d9>
   10204:	00001097          	auipc	ra,0x1
   10208:	39c08093          	add	ra,ra,924 # 115a0 <__DATA_BEGIN__>
   1020c:	0060d703          	lhu	a4,6(ra)
   10210:	63bd                	lui	t2,0xf
   10212:	23bd                	addw	t2,t2,15 # f00f <exit-0x10d9>
   10214:	0a771463          	bne	a4,t2,102bc <fail>

0000000000010218 <test_6>:
   10218:	4199                	li	gp,6
   1021a:	0ff00793          	li	a5,255
   1021e:	00001097          	auipc	ra,0x1
   10222:	38808093          	add	ra,ra,904 # 115a6 <tdat4>
   10226:	ffa0d703          	lhu	a4,-6(ra)
   1022a:	0ff00393          	li	t2,255
   1022e:	08771763          	bne	a4,t2,102bc <fail>

0000000000010232 <test_7>:
   10232:	419d                	li	gp,7
   10234:	67c1                	lui	a5,0x10
   10236:	f007879b          	addw	a5,a5,-256 # ff00 <exit-0x1e8>
   1023a:	00001097          	auipc	ra,0x1
   1023e:	36c08093          	add	ra,ra,876 # 115a6 <tdat4>
   10242:	ffc0d703          	lhu	a4,-4(ra)
   10246:	63c1                	lui	t2,0x10
   10248:	f003839b          	addw	t2,t2,-256 # ff00 <exit-0x1e8>
   1024c:	06771863          	bne	a4,t2,102bc <fail>

0000000000010250 <test_8>:
   10250:	41a1                	li	gp,8
   10252:	6785                	lui	a5,0x1
   10254:	37c1                	addw	a5,a5,-16 # ff0 <exit-0xf0f8>
   10256:	00001097          	auipc	ra,0x1
   1025a:	35008093          	add	ra,ra,848 # 115a6 <tdat4>
   1025e:	ffe0d703          	lhu	a4,-2(ra)
   10262:	6385                	lui	t2,0x1
   10264:	33c1                	addw	t2,t2,-16 # ff0 <exit-0xf0f8>
   10266:	04771b63          	bne	a4,t2,102bc <fail>

000000000001026a <test_9>:
   1026a:	41a5                	li	gp,9
   1026c:	67bd                	lui	a5,0xf
   1026e:	27bd                	addw	a5,a5,15 # f00f <exit-0x10d9>
   10270:	00001097          	auipc	ra,0x1
   10274:	33608093          	add	ra,ra,822 # 115a6 <tdat4>
   10278:	0000d703          	lhu	a4,0(ra)
   1027c:	63bd                	lui	t2,0xf
   1027e:	23bd                	addw	t2,t2,15 # f00f <exit-0x10d9>
   10280:	02771e63          	bne	a4,t2,102bc <fail>

0000000000010284 <test_10>:
   10284:	41a9                	li	gp,10
   10286:	00001097          	auipc	ra,0x1
   1028a:	31a08093          	add	ra,ra,794 # 115a0 <__DATA_BEGIN__>
   1028e:	1081                	add	ra,ra,-32
   10290:	0200d283          	lhu	t0,32(ra)
   10294:	0ff00393          	li	t2,255
   10298:	02729263          	bne	t0,t2,102bc <fail>

000000000001029c <test_11>:
   1029c:	41ad                	li	gp,11
   1029e:	00001097          	auipc	ra,0x1
   102a2:	30208093          	add	ra,ra,770 # 115a0 <__DATA_BEGIN__>
   102a6:	10ed                	add	ra,ra,-5
   102a8:	0070d283          	lhu	t0,7(ra)
   102ac:	63c1                	lui	t2,0x10
   102ae:	f003839b          	addw	t2,t2,-256 # ff00 <exit-0x1e8>
   102b2:	00729563          	bne	t0,t2,102bc <fail>
   102b6:	00301263          	bne	zero,gp,102ba <pass>

00000000000102ba <pass>:
   102ba:	a019                	j	102c0 <continue>

00000000000102bc <fail>:
   102bc:	00000000          	.word	0x00000000

00000000000102c0 <continue>:
   102c0:	4081                	li	ra,0
   102c2:	4781                	li	a5,0
   102c4:	853e                	mv	a0,a5
   102c6:	6462                	ld	s0,24(sp)
   102c8:	6105                	add	sp,sp,32
   102ca:	8082                	ret

00000000000102cc <__libc_init_array>:
   102cc:	1101                	add	sp,sp,-32
   102ce:	e822                	sd	s0,16(sp)
   102d0:	67c5                	lui	a5,0x11
   102d2:	6445                	lui	s0,0x11
   102d4:	e04a                	sd	s2,0(sp)
   102d6:	58478793          	add	a5,a5,1412 # 11584 <__preinit_array_end>
   102da:	58440713          	add	a4,s0,1412 # 11584 <__preinit_array_end>
   102de:	ec06                	sd	ra,24(sp)
   102e0:	e426                	sd	s1,8(sp)
   102e2:	40e78933          	sub	s2,a5,a4
   102e6:	00e78d63          	beq	a5,a4,10300 <__libc_init_array+0x34>
   102ea:	40395913          	sra	s2,s2,0x3
   102ee:	58440413          	add	s0,s0,1412
   102f2:	4481                	li	s1,0
   102f4:	601c                	ld	a5,0(s0)
   102f6:	0485                	add	s1,s1,1
   102f8:	0421                	add	s0,s0,8
   102fa:	9782                	jalr	a5
   102fc:	ff24ece3          	bltu	s1,s2,102f4 <__libc_init_array+0x28>
   10300:	6445                	lui	s0,0x11
   10302:	67c5                	lui	a5,0x11
   10304:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   10308:	58840713          	add	a4,s0,1416 # 11588 <__init_array_start>
   1030c:	40e78933          	sub	s2,a5,a4
   10310:	40395913          	sra	s2,s2,0x3
   10314:	00e78b63          	beq	a5,a4,1032a <__libc_init_array+0x5e>
   10318:	58840413          	add	s0,s0,1416
   1031c:	4481                	li	s1,0
   1031e:	601c                	ld	a5,0(s0)
   10320:	0485                	add	s1,s1,1
   10322:	0421                	add	s0,s0,8
   10324:	9782                	jalr	a5
   10326:	ff24ece3          	bltu	s1,s2,1031e <__libc_init_array+0x52>
   1032a:	60e2                	ld	ra,24(sp)
   1032c:	6442                	ld	s0,16(sp)
   1032e:	64a2                	ld	s1,8(sp)
   10330:	6902                	ld	s2,0(sp)
   10332:	6105                	add	sp,sp,32
   10334:	8082                	ret

0000000000010336 <memset>:
   10336:	433d                	li	t1,15
   10338:	872a                	mv	a4,a0
   1033a:	02c37163          	bgeu	t1,a2,1035c <memset+0x26>
   1033e:	00f77793          	and	a5,a4,15
   10342:	e3c1                	bnez	a5,103c2 <memset+0x8c>
   10344:	e1bd                	bnez	a1,103aa <memset+0x74>
   10346:	ff067693          	and	a3,a2,-16
   1034a:	8a3d                	and	a2,a2,15
   1034c:	96ba                	add	a3,a3,a4
   1034e:	e30c                	sd	a1,0(a4)
   10350:	e70c                	sd	a1,8(a4)
   10352:	0741                	add	a4,a4,16
   10354:	fed76de3          	bltu	a4,a3,1034e <memset+0x18>
   10358:	e211                	bnez	a2,1035c <memset+0x26>
   1035a:	8082                	ret
   1035c:	40c306b3          	sub	a3,t1,a2
   10360:	068a                	sll	a3,a3,0x2
   10362:	00000297          	auipc	t0,0x0
   10366:	9696                	add	a3,a3,t0
   10368:	00a68067          	jr	10(a3)
   1036c:	00b70723          	sb	a1,14(a4)
   10370:	00b706a3          	sb	a1,13(a4)
   10374:	00b70623          	sb	a1,12(a4)
   10378:	00b705a3          	sb	a1,11(a4)
   1037c:	00b70523          	sb	a1,10(a4)
   10380:	00b704a3          	sb	a1,9(a4)
   10384:	00b70423          	sb	a1,8(a4)
   10388:	00b703a3          	sb	a1,7(a4)
   1038c:	00b70323          	sb	a1,6(a4)
   10390:	00b702a3          	sb	a1,5(a4)
   10394:	00b70223          	sb	a1,4(a4)
   10398:	00b701a3          	sb	a1,3(a4)
   1039c:	00b70123          	sb	a1,2(a4)
   103a0:	00b700a3          	sb	a1,1(a4)
   103a4:	00b70023          	sb	a1,0(a4)
   103a8:	8082                	ret
   103aa:	0ff5f593          	zext.b	a1,a1
   103ae:	00859693          	sll	a3,a1,0x8
   103b2:	8dd5                	or	a1,a1,a3
   103b4:	01059693          	sll	a3,a1,0x10
   103b8:	8dd5                	or	a1,a1,a3
   103ba:	02059693          	sll	a3,a1,0x20
   103be:	8dd5                	or	a1,a1,a3
   103c0:	b759                	j	10346 <memset+0x10>
   103c2:	00279693          	sll	a3,a5,0x2
   103c6:	00000297          	auipc	t0,0x0
   103ca:	9696                	add	a3,a3,t0
   103cc:	8286                	mv	t0,ra
   103ce:	fa2680e7          	jalr	-94(a3)
   103d2:	8096                	mv	ra,t0
   103d4:	17c1                	add	a5,a5,-16
   103d6:	8f1d                	sub	a4,a4,a5
   103d8:	963e                	add	a2,a2,a5
   103da:	f8c371e3          	bgeu	t1,a2,1035c <memset+0x26>
   103de:	b79d                	j	10344 <memset+0xe>

00000000000103e0 <__call_exitprocs>:
   103e0:	715d                	add	sp,sp,-80
   103e2:	f052                	sd	s4,32(sp)
   103e4:	fa81ba03          	ld	s4,-88(gp) # 11d48 <_global_impure_ptr>
   103e8:	f84a                	sd	s2,48(sp)
   103ea:	e486                	sd	ra,72(sp)
   103ec:	1f8a3903          	ld	s2,504(s4)
   103f0:	e0a2                	sd	s0,64(sp)
   103f2:	fc26                	sd	s1,56(sp)
   103f4:	f44e                	sd	s3,40(sp)
   103f6:	ec56                	sd	s5,24(sp)
   103f8:	e85a                	sd	s6,16(sp)
   103fa:	e45e                	sd	s7,8(sp)
   103fc:	e062                	sd	s8,0(sp)
   103fe:	02090863          	beqz	s2,1042e <__call_exitprocs+0x4e>
   10402:	8b2a                	mv	s6,a0
   10404:	8bae                	mv	s7,a1
   10406:	4a85                	li	s5,1
   10408:	59fd                	li	s3,-1
   1040a:	00892483          	lw	s1,8(s2)
   1040e:	fff4841b          	addw	s0,s1,-1
   10412:	00044e63          	bltz	s0,1042e <__call_exitprocs+0x4e>
   10416:	048e                	sll	s1,s1,0x3
   10418:	94ca                	add	s1,s1,s2
   1041a:	020b8663          	beqz	s7,10446 <__call_exitprocs+0x66>
   1041e:	2084b783          	ld	a5,520(s1)
   10422:	03778263          	beq	a5,s7,10446 <__call_exitprocs+0x66>
   10426:	347d                	addw	s0,s0,-1
   10428:	14e1                	add	s1,s1,-8
   1042a:	ff3418e3          	bne	s0,s3,1041a <__call_exitprocs+0x3a>
   1042e:	60a6                	ld	ra,72(sp)
   10430:	6406                	ld	s0,64(sp)
   10432:	74e2                	ld	s1,56(sp)
   10434:	7942                	ld	s2,48(sp)
   10436:	79a2                	ld	s3,40(sp)
   10438:	7a02                	ld	s4,32(sp)
   1043a:	6ae2                	ld	s5,24(sp)
   1043c:	6b42                	ld	s6,16(sp)
   1043e:	6ba2                	ld	s7,8(sp)
   10440:	6c02                	ld	s8,0(sp)
   10442:	6161                	add	sp,sp,80
   10444:	8082                	ret
   10446:	00892783          	lw	a5,8(s2)
   1044a:	6498                	ld	a4,8(s1)
   1044c:	37fd                	addw	a5,a5,-1
   1044e:	04878463          	beq	a5,s0,10496 <__call_exitprocs+0xb6>
   10452:	0004b423          	sd	zero,8(s1)
   10456:	db61                	beqz	a4,10426 <__call_exitprocs+0x46>
   10458:	31092783          	lw	a5,784(s2)
   1045c:	008a96bb          	sllw	a3,s5,s0
   10460:	00892c03          	lw	s8,8(s2)
   10464:	8ff5                	and	a5,a5,a3
   10466:	2781                	sext.w	a5,a5
   10468:	ef89                	bnez	a5,10482 <__call_exitprocs+0xa2>
   1046a:	9702                	jalr	a4
   1046c:	00892703          	lw	a4,8(s2)
   10470:	1f8a3783          	ld	a5,504(s4)
   10474:	01871463          	bne	a4,s8,1047c <__call_exitprocs+0x9c>
   10478:	fb2787e3          	beq	a5,s2,10426 <__call_exitprocs+0x46>
   1047c:	dbcd                	beqz	a5,1042e <__call_exitprocs+0x4e>
   1047e:	893e                	mv	s2,a5
   10480:	b769                	j	1040a <__call_exitprocs+0x2a>
   10482:	31492783          	lw	a5,788(s2)
   10486:	1084b583          	ld	a1,264(s1)
   1048a:	8ff5                	and	a5,a5,a3
   1048c:	2781                	sext.w	a5,a5
   1048e:	e799                	bnez	a5,1049c <__call_exitprocs+0xbc>
   10490:	855a                	mv	a0,s6
   10492:	9702                	jalr	a4
   10494:	bfe1                	j	1046c <__call_exitprocs+0x8c>
   10496:	00892423          	sw	s0,8(s2)
   1049a:	bf75                	j	10456 <__call_exitprocs+0x76>
   1049c:	852e                	mv	a0,a1
   1049e:	9702                	jalr	a4
   104a0:	b7f1                	j	1046c <__call_exitprocs+0x8c>

00000000000104a2 <__libc_fini_array>:
   104a2:	1101                	add	sp,sp,-32
   104a4:	e822                	sd	s0,16(sp)
   104a6:	67c5                	lui	a5,0x11
   104a8:	6445                	lui	s0,0x11
   104aa:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   104ae:	5a040413          	add	s0,s0,1440 # 115a0 <__DATA_BEGIN__>
   104b2:	8c1d                	sub	s0,s0,a5
   104b4:	e426                	sd	s1,8(sp)
   104b6:	ec06                	sd	ra,24(sp)
   104b8:	40345493          	sra	s1,s0,0x3
   104bc:	c881                	beqz	s1,104cc <__libc_fini_array+0x2a>
   104be:	1461                	add	s0,s0,-8
   104c0:	943e                	add	s0,s0,a5
   104c2:	601c                	ld	a5,0(s0)
   104c4:	14fd                	add	s1,s1,-1
   104c6:	1461                	add	s0,s0,-8
   104c8:	9782                	jalr	a5
   104ca:	fce5                	bnez	s1,104c2 <__libc_fini_array+0x20>
   104cc:	60e2                	ld	ra,24(sp)
   104ce:	6442                	ld	s0,16(sp)
   104d0:	64a2                	ld	s1,8(sp)
   104d2:	6105                	add	sp,sp,32
   104d4:	8082                	ret

00000000000104d6 <atexit>:
   104d6:	85aa                	mv	a1,a0
   104d8:	4681                	li	a3,0
   104da:	4601                	li	a2,0
   104dc:	4501                	li	a0,0
   104de:	a009                	j	104e0 <__register_exitproc>

00000000000104e0 <__register_exitproc>:
   104e0:	fa81b703          	ld	a4,-88(gp) # 11d48 <_global_impure_ptr>
   104e4:	1f873783          	ld	a5,504(a4)
   104e8:	c3b1                	beqz	a5,1052c <__register_exitproc+0x4c>
   104ea:	4798                	lw	a4,8(a5)
   104ec:	487d                	li	a6,31
   104ee:	06e84263          	blt	a6,a4,10552 <__register_exitproc+0x72>
   104f2:	c505                	beqz	a0,1051a <__register_exitproc+0x3a>
   104f4:	00371813          	sll	a6,a4,0x3
   104f8:	983e                	add	a6,a6,a5
   104fa:	10c83823          	sd	a2,272(a6)
   104fe:	3107a883          	lw	a7,784(a5)
   10502:	4605                	li	a2,1
   10504:	00e6163b          	sllw	a2,a2,a4
   10508:	00c8e8b3          	or	a7,a7,a2
   1050c:	3117a823          	sw	a7,784(a5)
   10510:	20d83823          	sd	a3,528(a6)
   10514:	4689                	li	a3,2
   10516:	02d50063          	beq	a0,a3,10536 <__register_exitproc+0x56>
   1051a:	00270693          	add	a3,a4,2
   1051e:	068e                	sll	a3,a3,0x3
   10520:	2705                	addw	a4,a4,1
   10522:	c798                	sw	a4,8(a5)
   10524:	97b6                	add	a5,a5,a3
   10526:	e38c                	sd	a1,0(a5)
   10528:	4501                	li	a0,0
   1052a:	8082                	ret
   1052c:	20070793          	add	a5,a4,512
   10530:	1ef73c23          	sd	a5,504(a4)
   10534:	bf5d                	j	104ea <__register_exitproc+0xa>
   10536:	3147a683          	lw	a3,788(a5)
   1053a:	4501                	li	a0,0
   1053c:	8ed1                	or	a3,a3,a2
   1053e:	30d7aa23          	sw	a3,788(a5)
   10542:	00270693          	add	a3,a4,2
   10546:	068e                	sll	a3,a3,0x3
   10548:	2705                	addw	a4,a4,1
   1054a:	c798                	sw	a4,8(a5)
   1054c:	97b6                	add	a5,a5,a3
   1054e:	e38c                	sd	a1,0(a5)
   10550:	8082                	ret
   10552:	557d                	li	a0,-1
   10554:	8082                	ret

0000000000010556 <_exit>:
   10556:	05d00893          	li	a7,93
   1055a:	00000073          	ecall
   1055e:	00054363          	bltz	a0,10564 <_exit+0xe>
   10562:	a001                	j	10562 <_exit+0xc>
   10564:	1141                	add	sp,sp,-16
   10566:	e022                	sd	s0,0(sp)
   10568:	842a                	mv	s0,a0
   1056a:	e406                	sd	ra,8(sp)
   1056c:	4080043b          	negw	s0,s0
   10570:	008000ef          	jal	10578 <__errno>
   10574:	c100                	sw	s0,0(a0)
   10576:	a001                	j	10576 <_exit+0x20>

0000000000010578 <__errno>:
   10578:	fb81b503          	ld	a0,-72(gp) # 11d58 <_impure_ptr>
   1057c:	8082                	ret

addi.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2f0000ef          	jal	103e2 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11ce8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	456000ef          	jal	10558 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4a450513          	add	a0,a0,1188 # 104a4 <__libc_fini_array>
   10112:	a6d9                	j	104d8 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c8a18193          	add	gp,gp,-886 # 11da0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d00 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d38 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	20e000ef          	jal	10338 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3aa50513          	add	a0,a0,938 # 104d8 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36c50513          	add	a0,a0,876 # 104a4 <__libc_fini_array>
   10140:	398000ef          	jal	104d8 <atexit>
   10144:	18a000ef          	jal	102ce <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d00 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d00 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d08 <object.0>
   1018e:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	8706                	mv	a4,ra
   101b2:	4381                	li	t2,0
   101b4:	10771563          	bne	a4,t2,102be <fail>

00000000000101b8 <test_3>:
   101b8:	418d                	li	gp,3
   101ba:	4085                	li	ra,1
   101bc:	00108713          	add	a4,ra,1 # 1016d <__do_global_dtors_aux+0x19>
   101c0:	4389                	li	t2,2
   101c2:	0e771e63          	bne	a4,t2,102be <fail>

00000000000101c6 <test_4>:
   101c6:	4191                	li	gp,4
   101c8:	408d                	li	ra,3
   101ca:	00708713          	add	a4,ra,7
   101ce:	43a9                	li	t2,10
   101d0:	0e771763          	bne	a4,t2,102be <fail>

00000000000101d4 <test_5>:
   101d4:	4195                	li	gp,5
   101d6:	4081                	li	ra,0
   101d8:	80008713          	add	a4,ra,-2048
   101dc:	80000393          	li	t2,-2048
   101e0:	0c771f63          	bne	a4,t2,102be <fail>

00000000000101e4 <test_6>:
   101e4:	4199                	li	gp,6
   101e6:	800000b7          	lui	ra,0x80000
   101ea:	8706                	mv	a4,ra
   101ec:	800003b7          	lui	t2,0x80000
   101f0:	0c771763          	bne	a4,t2,102be <fail>

00000000000101f4 <test_7>:
   101f4:	419d                	li	gp,7
   101f6:	800000b7          	lui	ra,0x80000
   101fa:	80008713          	add	a4,ra,-2048 # ffffffff7ffff800 <__global_pointer$+0xffffffff7ffeda60>
   101fe:	fff0039b          	addw	t2,zero,-1
   10202:	03fe                	sll	t2,t2,0x1f
   10204:	80038393          	add	t2,t2,-2048 # ffffffff7ffff800 <__global_pointer$+0xffffffff7ffeda60>
   10208:	0a771b63          	bne	a4,t2,102be <fail>

000000000001020c <test_8>:
   1020c:	41a1                	li	gp,8
   1020e:	4081                	li	ra,0
   10210:	7ff08713          	add	a4,ra,2047
   10214:	7ff00393          	li	t2,2047
   10218:	0a771363          	bne	a4,t2,102be <fail>

000000000001021c <test_9>:
   1021c:	41a5                	li	gp,9
   1021e:	800000b7          	lui	ra,0x80000
   10222:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   10224:	8706                	mv	a4,ra
   10226:	800003b7          	lui	t2,0x80000
   1022a:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   1022c:	08771963          	bne	a4,t2,102be <fail>

0000000000010230 <test_10>:
   10230:	41a9                	li	gp,10
   10232:	800000b7          	lui	ra,0x80000
   10236:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   10238:	7ff08713          	add	a4,ra,2047
   1023c:	0010039b          	addw	t2,zero,1
   10240:	03fe                	sll	t2,t2,0x1f
   10242:	7fe38393          	add	t2,t2,2046
   10246:	06771c63          	bne	a4,t2,102be <fail>

000000000001024a <test_11>:
   1024a:	41ad                	li	gp,11
   1024c:	800000b7          	lui	ra,0x80000
   10250:	7ff08713          	add	a4,ra,2047 # ffffffff800007ff <__global_pointer$+0xffffffff7ffeea5f>
   10254:	800003b7          	lui	t2,0x80000
   10258:	7ff3839b          	addw	t2,t2,2047 # ffffffff800007ff <__global_pointer$+0xffffffff7ffeea5f>
   1025c:	06771163          	bne	a4,t2,102be <fail>

0000000000010260 <test_12>:
   10260:	41b1                	li	gp,12
   10262:	800000b7          	lui	ra,0x80000
   10266:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   10268:	80008713          	add	a4,ra,-2048
   1026c:	7ffff3b7          	lui	t2,0x7ffff
   10270:	7ff3839b          	addw	t2,t2,2047 # 7ffff7ff <__global_pointer$+0x7ffeda5f>
   10274:	04771563          	bne	a4,t2,102be <fail>

0000000000010278 <test_13>:
   10278:	41b5                	li	gp,13
   1027a:	4081                	li	ra,0
   1027c:	fff08713          	add	a4,ra,-1
   10280:	53fd                	li	t2,-1
   10282:	02771e63          	bne	a4,t2,102be <fail>

0000000000010286 <test_14>:
   10286:	41b9                	li	gp,14
   10288:	50fd                	li	ra,-1
   1028a:	00108713          	add	a4,ra,1
   1028e:	4381                	li	t2,0
   10290:	02771763          	bne	a4,t2,102be <fail>

0000000000010294 <test_15>:
   10294:	41bd                	li	gp,15
   10296:	50fd                	li	ra,-1
   10298:	fff08713          	add	a4,ra,-1
   1029c:	53f9                	li	t2,-2
   1029e:	02771063          	bne	a4,t2,102be <fail>

00000000000102a2 <test_16>:
   102a2:	41c1                	li	gp,16
   102a4:	800000b7          	lui	ra,0x80000
   102a8:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee25f>
   102aa:	00108713          	add	a4,ra,1
   102ae:	0010039b          	addw	t2,zero,1
   102b2:	03fe                	sll	t2,t2,0x1f
   102b4:	00771563          	bne	a4,t2,102be <fail>
   102b8:	00301263          	bne	zero,gp,102bc <pass>

00000000000102bc <pass>:
   102bc:	a019                	j	102c2 <continue>

00000000000102be <fail>:
   102be:	0000                	unimp
	...

00000000000102c2 <continue>:
   102c2:	4081                	li	ra,0
   102c4:	4781                	li	a5,0
   102c6:	853e                	mv	a0,a5
   102c8:	6462                	ld	s0,24(sp)
   102ca:	6105                	add	sp,sp,32
   102cc:	8082                	ret

00000000000102ce <__libc_init_array>:
   102ce:	1101                	add	sp,sp,-32
   102d0:	e822                	sd	s0,16(sp)
   102d2:	67c5                	lui	a5,0x11
   102d4:	6445                	lui	s0,0x11
   102d6:	e04a                	sd	s2,0(sp)
   102d8:	58478793          	add	a5,a5,1412 # 11584 <__preinit_array_end>
   102dc:	58440713          	add	a4,s0,1412 # 11584 <__preinit_array_end>
   102e0:	ec06                	sd	ra,24(sp)
   102e2:	e426                	sd	s1,8(sp)
   102e4:	40e78933          	sub	s2,a5,a4
   102e8:	00e78d63          	beq	a5,a4,10302 <__libc_init_array+0x34>
   102ec:	40395913          	sra	s2,s2,0x3
   102f0:	58440413          	add	s0,s0,1412
   102f4:	4481                	li	s1,0
   102f6:	601c                	ld	a5,0(s0)
   102f8:	0485                	add	s1,s1,1
   102fa:	0421                	add	s0,s0,8
   102fc:	9782                	jalr	a5
   102fe:	ff24ece3          	bltu	s1,s2,102f6 <__libc_init_array+0x28>
   10302:	6445                	lui	s0,0x11
   10304:	67c5                	lui	a5,0x11
   10306:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   1030a:	58840713          	add	a4,s0,1416 # 11588 <__init_array_start>
   1030e:	40e78933          	sub	s2,a5,a4
   10312:	40395913          	sra	s2,s2,0x3
   10316:	00e78b63          	beq	a5,a4,1032c <__libc_init_array+0x5e>
   1031a:	58840413          	add	s0,s0,1416
   1031e:	4481                	li	s1,0
   10320:	601c                	ld	a5,0(s0)
   10322:	0485                	add	s1,s1,1
   10324:	0421                	add	s0,s0,8
   10326:	9782                	jalr	a5
   10328:	ff24ece3          	bltu	s1,s2,10320 <__libc_init_array+0x52>
   1032c:	60e2                	ld	ra,24(sp)
   1032e:	6442                	ld	s0,16(sp)
   10330:	64a2                	ld	s1,8(sp)
   10332:	6902                	ld	s2,0(sp)
   10334:	6105                	add	sp,sp,32
   10336:	8082                	ret

0000000000010338 <memset>:
   10338:	433d                	li	t1,15
   1033a:	872a                	mv	a4,a0
   1033c:	02c37163          	bgeu	t1,a2,1035e <memset+0x26>
   10340:	00f77793          	and	a5,a4,15
   10344:	e3c1                	bnez	a5,103c4 <memset+0x8c>
   10346:	e1bd                	bnez	a1,103ac <memset+0x74>
   10348:	ff067693          	and	a3,a2,-16
   1034c:	8a3d                	and	a2,a2,15
   1034e:	96ba                	add	a3,a3,a4
   10350:	e30c                	sd	a1,0(a4)
   10352:	e70c                	sd	a1,8(a4)
   10354:	0741                	add	a4,a4,16
   10356:	fed76de3          	bltu	a4,a3,10350 <memset+0x18>
   1035a:	e211                	bnez	a2,1035e <memset+0x26>
   1035c:	8082                	ret
   1035e:	40c306b3          	sub	a3,t1,a2
   10362:	068a                	sll	a3,a3,0x2
   10364:	00000297          	auipc	t0,0x0
   10368:	9696                	add	a3,a3,t0
   1036a:	00a68067          	jr	10(a3)
   1036e:	00b70723          	sb	a1,14(a4)
   10372:	00b706a3          	sb	a1,13(a4)
   10376:	00b70623          	sb	a1,12(a4)
   1037a:	00b705a3          	sb	a1,11(a4)
   1037e:	00b70523          	sb	a1,10(a4)
   10382:	00b704a3          	sb	a1,9(a4)
   10386:	00b70423          	sb	a1,8(a4)
   1038a:	00b703a3          	sb	a1,7(a4)
   1038e:	00b70323          	sb	a1,6(a4)
   10392:	00b702a3          	sb	a1,5(a4)
   10396:	00b70223          	sb	a1,4(a4)
   1039a:	00b701a3          	sb	a1,3(a4)
   1039e:	00b70123          	sb	a1,2(a4)
   103a2:	00b700a3          	sb	a1,1(a4)
   103a6:	00b70023          	sb	a1,0(a4)
   103aa:	8082                	ret
   103ac:	0ff5f593          	zext.b	a1,a1
   103b0:	00859693          	sll	a3,a1,0x8
   103b4:	8dd5                	or	a1,a1,a3
   103b6:	01059693          	sll	a3,a1,0x10
   103ba:	8dd5                	or	a1,a1,a3
   103bc:	02059693          	sll	a3,a1,0x20
   103c0:	8dd5                	or	a1,a1,a3
   103c2:	b759                	j	10348 <memset+0x10>
   103c4:	00279693          	sll	a3,a5,0x2
   103c8:	00000297          	auipc	t0,0x0
   103cc:	9696                	add	a3,a3,t0
   103ce:	8286                	mv	t0,ra
   103d0:	fa2680e7          	jalr	-94(a3)
   103d4:	8096                	mv	ra,t0
   103d6:	17c1                	add	a5,a5,-16
   103d8:	8f1d                	sub	a4,a4,a5
   103da:	963e                	add	a2,a2,a5
   103dc:	f8c371e3          	bgeu	t1,a2,1035e <memset+0x26>
   103e0:	b79d                	j	10346 <memset+0xe>

00000000000103e2 <__call_exitprocs>:
   103e2:	715d                	add	sp,sp,-80
   103e4:	f052                	sd	s4,32(sp)
   103e6:	f481ba03          	ld	s4,-184(gp) # 11ce8 <_global_impure_ptr>
   103ea:	f84a                	sd	s2,48(sp)
   103ec:	e486                	sd	ra,72(sp)
   103ee:	1f8a3903          	ld	s2,504(s4)
   103f2:	e0a2                	sd	s0,64(sp)
   103f4:	fc26                	sd	s1,56(sp)
   103f6:	f44e                	sd	s3,40(sp)
   103f8:	ec56                	sd	s5,24(sp)
   103fa:	e85a                	sd	s6,16(sp)
   103fc:	e45e                	sd	s7,8(sp)
   103fe:	e062                	sd	s8,0(sp)
   10400:	02090863          	beqz	s2,10430 <__call_exitprocs+0x4e>
   10404:	8b2a                	mv	s6,a0
   10406:	8bae                	mv	s7,a1
   10408:	4a85                	li	s5,1
   1040a:	59fd                	li	s3,-1
   1040c:	00892483          	lw	s1,8(s2)
   10410:	fff4841b          	addw	s0,s1,-1
   10414:	00044e63          	bltz	s0,10430 <__call_exitprocs+0x4e>
   10418:	048e                	sll	s1,s1,0x3
   1041a:	94ca                	add	s1,s1,s2
   1041c:	020b8663          	beqz	s7,10448 <__call_exitprocs+0x66>
   10420:	2084b783          	ld	a5,520(s1)
   10424:	03778263          	beq	a5,s7,10448 <__call_exitprocs+0x66>
   10428:	347d                	addw	s0,s0,-1
   1042a:	14e1                	add	s1,s1,-8
   1042c:	ff3418e3          	bne	s0,s3,1041c <__call_exitprocs+0x3a>
   10430:	60a6                	ld	ra,72(sp)
   10432:	6406                	ld	s0,64(sp)
   10434:	74e2                	ld	s1,56(sp)
   10436:	7942                	ld	s2,48(sp)
   10438:	79a2                	ld	s3,40(sp)
   1043a:	7a02                	ld	s4,32(sp)
   1043c:	6ae2                	ld	s5,24(sp)
   1043e:	6b42                	ld	s6,16(sp)
   10440:	6ba2                	ld	s7,8(sp)
   10442:	6c02                	ld	s8,0(sp)
   10444:	6161                	add	sp,sp,80
   10446:	8082                	ret
   10448:	00892783          	lw	a5,8(s2)
   1044c:	6498                	ld	a4,8(s1)
   1044e:	37fd                	addw	a5,a5,-1
   10450:	04878463          	beq	a5,s0,10498 <__call_exitprocs+0xb6>
   10454:	0004b423          	sd	zero,8(s1)
   10458:	db61                	beqz	a4,10428 <__call_exitprocs+0x46>
   1045a:	31092783          	lw	a5,784(s2)
   1045e:	008a96bb          	sllw	a3,s5,s0
   10462:	00892c03          	lw	s8,8(s2)
   10466:	8ff5                	and	a5,a5,a3
   10468:	2781                	sext.w	a5,a5
   1046a:	ef89                	bnez	a5,10484 <__call_exitprocs+0xa2>
   1046c:	9702                	jalr	a4
   1046e:	00892703          	lw	a4,8(s2)
   10472:	1f8a3783          	ld	a5,504(s4)
   10476:	01871463          	bne	a4,s8,1047e <__call_exitprocs+0x9c>
   1047a:	fb2787e3          	beq	a5,s2,10428 <__call_exitprocs+0x46>
   1047e:	dbcd                	beqz	a5,10430 <__call_exitprocs+0x4e>
   10480:	893e                	mv	s2,a5
   10482:	b769                	j	1040c <__call_exitprocs+0x2a>
   10484:	31492783          	lw	a5,788(s2)
   10488:	1084b583          	ld	a1,264(s1)
   1048c:	8ff5                	and	a5,a5,a3
   1048e:	2781                	sext.w	a5,a5
   10490:	e799                	bnez	a5,1049e <__call_exitprocs+0xbc>
   10492:	855a                	mv	a0,s6
   10494:	9702                	jalr	a4
   10496:	bfe1                	j	1046e <__call_exitprocs+0x8c>
   10498:	00892423          	sw	s0,8(s2)
   1049c:	bf75                	j	10458 <__call_exitprocs+0x76>
   1049e:	852e                	mv	a0,a1
   104a0:	9702                	jalr	a4
   104a2:	b7f1                	j	1046e <__call_exitprocs+0x8c>

00000000000104a4 <__libc_fini_array>:
   104a4:	1101                	add	sp,sp,-32
   104a6:	e822                	sd	s0,16(sp)
   104a8:	67c5                	lui	a5,0x11
   104aa:	6445                	lui	s0,0x11
   104ac:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   104b0:	5a040413          	add	s0,s0,1440 # 115a0 <impure_data>
   104b4:	8c1d                	sub	s0,s0,a5
   104b6:	e426                	sd	s1,8(sp)
   104b8:	ec06                	sd	ra,24(sp)
   104ba:	40345493          	sra	s1,s0,0x3
   104be:	c881                	beqz	s1,104ce <__libc_fini_array+0x2a>
   104c0:	1461                	add	s0,s0,-8
   104c2:	943e                	add	s0,s0,a5
   104c4:	601c                	ld	a5,0(s0)
   104c6:	14fd                	add	s1,s1,-1
   104c8:	1461                	add	s0,s0,-8
   104ca:	9782                	jalr	a5
   104cc:	fce5                	bnez	s1,104c4 <__libc_fini_array+0x20>
   104ce:	60e2                	ld	ra,24(sp)
   104d0:	6442                	ld	s0,16(sp)
   104d2:	64a2                	ld	s1,8(sp)
   104d4:	6105                	add	sp,sp,32
   104d6:	8082                	ret

00000000000104d8 <atexit>:
   104d8:	85aa                	mv	a1,a0
   104da:	4681                	li	a3,0
   104dc:	4601                	li	a2,0
   104de:	4501                	li	a0,0
   104e0:	a009                	j	104e2 <__register_exitproc>

00000000000104e2 <__register_exitproc>:
   104e2:	f481b703          	ld	a4,-184(gp) # 11ce8 <_global_impure_ptr>
   104e6:	1f873783          	ld	a5,504(a4)
   104ea:	c3b1                	beqz	a5,1052e <__register_exitproc+0x4c>
   104ec:	4798                	lw	a4,8(a5)
   104ee:	487d                	li	a6,31
   104f0:	06e84263          	blt	a6,a4,10554 <__register_exitproc+0x72>
   104f4:	c505                	beqz	a0,1051c <__register_exitproc+0x3a>
   104f6:	00371813          	sll	a6,a4,0x3
   104fa:	983e                	add	a6,a6,a5
   104fc:	10c83823          	sd	a2,272(a6)
   10500:	3107a883          	lw	a7,784(a5)
   10504:	4605                	li	a2,1
   10506:	00e6163b          	sllw	a2,a2,a4
   1050a:	00c8e8b3          	or	a7,a7,a2
   1050e:	3117a823          	sw	a7,784(a5)
   10512:	20d83823          	sd	a3,528(a6)
   10516:	4689                	li	a3,2
   10518:	02d50063          	beq	a0,a3,10538 <__register_exitproc+0x56>
   1051c:	00270693          	add	a3,a4,2
   10520:	068e                	sll	a3,a3,0x3
   10522:	2705                	addw	a4,a4,1
   10524:	c798                	sw	a4,8(a5)
   10526:	97b6                	add	a5,a5,a3
   10528:	e38c                	sd	a1,0(a5)
   1052a:	4501                	li	a0,0
   1052c:	8082                	ret
   1052e:	20070793          	add	a5,a4,512
   10532:	1ef73c23          	sd	a5,504(a4)
   10536:	bf5d                	j	104ec <__register_exitproc+0xa>
   10538:	3147a683          	lw	a3,788(a5)
   1053c:	4501                	li	a0,0
   1053e:	8ed1                	or	a3,a3,a2
   10540:	30d7aa23          	sw	a3,788(a5)
   10544:	00270693          	add	a3,a4,2
   10548:	068e                	sll	a3,a3,0x3
   1054a:	2705                	addw	a4,a4,1
   1054c:	c798                	sw	a4,8(a5)
   1054e:	97b6                	add	a5,a5,a3
   10550:	e38c                	sd	a1,0(a5)
   10552:	8082                	ret
   10554:	557d                	li	a0,-1
   10556:	8082                	ret

0000000000010558 <_exit>:
   10558:	05d00893          	li	a7,93
   1055c:	00000073          	ecall
   10560:	00054363          	bltz	a0,10566 <_exit+0xe>
   10564:	a001                	j	10564 <_exit+0xc>
   10566:	1141                	add	sp,sp,-16
   10568:	e022                	sd	s0,0(sp)
   1056a:	842a                	mv	s0,a0
   1056c:	e406                	sd	ra,8(sp)
   1056e:	4080043b          	negw	s0,s0
   10572:	008000ef          	jal	1057a <__errno>
   10576:	c100                	sw	s0,0(a0)
   10578:	a001                	j	10578 <_exit+0x20>

000000000001057a <__errno>:
   1057a:	f581b503          	ld	a0,-168(gp) # 11cf8 <_impure_ptr>
   1057e:	8082                	ret

srliw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	392000ef          	jal	10484 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d88 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4f8000ef          	jal	105fa <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	54650513          	add	a0,a0,1350 # 10546 <__libc_fini_array>
   10112:	a1a5                	j	1057a <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d2a18193          	add	gp,gp,-726 # 11e40 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11da0 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11dd8 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	2b0000ef          	jal	103da <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	44c50513          	add	a0,a0,1100 # 1057a <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	40e50513          	add	a0,a0,1038 # 10546 <__libc_fini_array>
   10140:	43a000ef          	jal	1057a <atexit>
   10144:	22c000ef          	jal	10370 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11da0 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	62450513          	add	a0,a0,1572 # 11624 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11da0 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11da8 <object.0>
   1018e:	62450513          	add	a0,a0,1572 # 11624 <__EH_FRAME_BEGIN__>
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
   101ae:	800000b7          	lui	ra,0x80000
   101b2:	0000d71b          	srlw	a4,ra,0x0
   101b6:	800003b7          	lui	t2,0x80000
   101ba:	1a771363          	bne	a4,t2,10360 <fail>

00000000000101be <test_3>:
   101be:	418d                	li	gp,3
   101c0:	800000b7          	lui	ra,0x80000
   101c4:	0010d71b          	srlw	a4,ra,0x1
   101c8:	400003b7          	lui	t2,0x40000
   101cc:	18771a63          	bne	a4,t2,10360 <fail>

00000000000101d0 <test_4>:
   101d0:	4191                	li	gp,4
   101d2:	800000b7          	lui	ra,0x80000
   101d6:	0070d71b          	srlw	a4,ra,0x7
   101da:	010003b7          	lui	t2,0x1000
   101de:	18771163          	bne	a4,t2,10360 <fail>

00000000000101e2 <test_5>:
   101e2:	4195                	li	gp,5
   101e4:	800000b7          	lui	ra,0x80000
   101e8:	00e0d71b          	srlw	a4,ra,0xe
   101ec:	000203b7          	lui	t2,0x20
   101f0:	16771863          	bne	a4,t2,10360 <fail>

00000000000101f4 <test_6>:
   101f4:	4199                	li	gp,6
   101f6:	800000b7          	lui	ra,0x80000
   101fa:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee1c1>
   101fc:	01f0d71b          	srlw	a4,ra,0x1f
   10200:	4385                	li	t2,1
   10202:	14771f63          	bne	a4,t2,10360 <fail>

0000000000010206 <test_7>:
   10206:	419d                	li	gp,7
   10208:	50fd                	li	ra,-1
   1020a:	0000d71b          	srlw	a4,ra,0x0
   1020e:	53fd                	li	t2,-1
   10210:	14771863          	bne	a4,t2,10360 <fail>

0000000000010214 <test_8>:
   10214:	41a1                	li	gp,8
   10216:	50fd                	li	ra,-1
   10218:	0010d71b          	srlw	a4,ra,0x1
   1021c:	800003b7          	lui	t2,0x80000
   10220:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee1bf>
   10222:	12771f63          	bne	a4,t2,10360 <fail>

0000000000010226 <test_9>:
   10226:	41a5                	li	gp,9
   10228:	50fd                	li	ra,-1
   1022a:	0070d71b          	srlw	a4,ra,0x7
   1022e:	020003b7          	lui	t2,0x2000
   10232:	33fd                	addw	t2,t2,-1 # 1ffffff <__global_pointer$+0x1fee1bf>
   10234:	12771663          	bne	a4,t2,10360 <fail>

0000000000010238 <test_10>:
   10238:	41a9                	li	gp,10
   1023a:	50fd                	li	ra,-1
   1023c:	00e0d71b          	srlw	a4,ra,0xe
   10240:	000403b7          	lui	t2,0x40
   10244:	33fd                	addw	t2,t2,-1 # 3ffff <__global_pointer$+0x2e1bf>
   10246:	10771d63          	bne	a4,t2,10360 <fail>

000000000001024a <test_11>:
   1024a:	41ad                	li	gp,11
   1024c:	50fd                	li	ra,-1
   1024e:	01f0d71b          	srlw	a4,ra,0x1f
   10252:	4385                	li	t2,1
   10254:	10771663          	bne	a4,t2,10360 <fail>

0000000000010258 <test_12>:
   10258:	41b1                	li	gp,12
   1025a:	212120b7          	lui	ra,0x21212
   1025e:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002e1>
   10262:	0000d71b          	srlw	a4,ra,0x0
   10266:	212123b7          	lui	t2,0x21212
   1026a:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x212002e1>
   1026e:	0e771963          	bne	a4,t2,10360 <fail>

0000000000010272 <test_13>:
   10272:	41b5                	li	gp,13
   10274:	212120b7          	lui	ra,0x21212
   10278:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002e1>
   1027c:	0010d71b          	srlw	a4,ra,0x1
   10280:	109093b7          	lui	t2,0x10909
   10284:	0903839b          	addw	t2,t2,144 # 10909090 <__global_pointer$+0x108f7250>
   10288:	0c771c63          	bne	a4,t2,10360 <fail>

000000000001028c <test_14>:
   1028c:	41b9                	li	gp,14
   1028e:	212120b7          	lui	ra,0x21212
   10292:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002e1>
   10296:	0070d71b          	srlw	a4,ra,0x7
   1029a:	004243b7          	lui	t2,0x424
   1029e:	2423839b          	addw	t2,t2,578 # 424242 <__global_pointer$+0x412402>
   102a2:	0a771f63          	bne	a4,t2,10360 <fail>

00000000000102a6 <test_15>:
   102a6:	41bd                	li	gp,15
   102a8:	212120b7          	lui	ra,0x21212
   102ac:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002e1>
   102b0:	00e0d71b          	srlw	a4,ra,0xe
   102b4:	63a1                	lui	t2,0x8
   102b6:	4843839b          	addw	t2,t2,1156 # 8484 <exit-0x7c64>
   102ba:	0a771363          	bne	a4,t2,10360 <fail>

00000000000102be <test_16>:
   102be:	41c1                	li	gp,16
   102c0:	212120b7          	lui	ra,0x21212
   102c4:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002e1>
   102c8:	01f0d71b          	srlw	a4,ra,0x1f
   102cc:	4381                	li	t2,0
   102ce:	08771963          	bne	a4,t2,10360 <fail>

00000000000102d2 <test_44>:
   102d2:	02c00193          	li	gp,44
   102d6:	fff120b7          	lui	ra,0xfff12
   102da:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00505>
   102de:	00b2                	sll	ra,ra,0xc
   102e0:	67808093          	add	ra,ra,1656
   102e4:	0000d71b          	srlw	a4,ra,0x0
   102e8:	123453b7          	lui	t2,0x12345
   102ec:	6783839b          	addw	t2,t2,1656 # 12345678 <__global_pointer$+0x12333838>
   102f0:	06771863          	bne	a4,t2,10360 <fail>

00000000000102f4 <test_45>:
   102f4:	02d00193          	li	gp,45
   102f8:	fff120b7          	lui	ra,0xfff12
   102fc:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00505>
   10300:	00b2                	sll	ra,ra,0xc
   10302:	67808093          	add	ra,ra,1656
   10306:	0040d71b          	srlw	a4,ra,0x4
   1030a:	012343b7          	lui	t2,0x1234
   1030e:	5673839b          	addw	t2,t2,1383 # 1234567 <__global_pointer$+0x1222727>
   10312:	04771763          	bne	a4,t2,10360 <fail>

0000000000010316 <test_46>:
   10316:	02e00193          	li	gp,46
   1031a:	000920b7          	lui	ra,0x92
   1031e:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80505>
   10322:	00b2                	sll	ra,ra,0xc
   10324:	67808093          	add	ra,ra,1656
   10328:	0000d71b          	srlw	a4,ra,0x0
   1032c:	923453b7          	lui	t2,0x92345
   10330:	6783839b          	addw	t2,t2,1656 # ffffffff92345678 <__global_pointer$+0xffffffff92333838>
   10334:	02771663          	bne	a4,t2,10360 <fail>

0000000000010338 <test_47>:
   10338:	02f00193          	li	gp,47
   1033c:	000920b7          	lui	ra,0x92
   10340:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80505>
   10344:	00b2                	sll	ra,ra,0xc
   10346:	67808093          	add	ra,ra,1656
   1034a:	0040d71b          	srlw	a4,ra,0x4
   1034e:	092343b7          	lui	t2,0x9234
   10352:	5673839b          	addw	t2,t2,1383 # 9234567 <__global_pointer$+0x9222727>
   10356:	00771563          	bne	a4,t2,10360 <fail>
   1035a:	00301263          	bne	zero,gp,1035e <pass>

000000000001035e <pass>:
   1035e:	a019                	j	10364 <continue>

0000000000010360 <fail>:
   10360:	0000                	unimp
	...

0000000000010364 <continue>:
   10364:	4081                	li	ra,0
   10366:	4781                	li	a5,0
   10368:	853e                	mv	a0,a5
   1036a:	6462                	ld	s0,24(sp)
   1036c:	6105                	add	sp,sp,32
   1036e:	8082                	ret

0000000000010370 <__libc_init_array>:
   10370:	1101                	add	sp,sp,-32
   10372:	e822                	sd	s0,16(sp)
   10374:	67c5                	lui	a5,0x11
   10376:	6445                	lui	s0,0x11
   10378:	e04a                	sd	s2,0(sp)
   1037a:	62878793          	add	a5,a5,1576 # 11628 <__init_array_start>
   1037e:	62840713          	add	a4,s0,1576 # 11628 <__init_array_start>
   10382:	ec06                	sd	ra,24(sp)
   10384:	e426                	sd	s1,8(sp)
   10386:	40e78933          	sub	s2,a5,a4
   1038a:	00e78d63          	beq	a5,a4,103a4 <__libc_init_array+0x34>
   1038e:	40395913          	sra	s2,s2,0x3
   10392:	62840413          	add	s0,s0,1576
   10396:	4481                	li	s1,0
   10398:	601c                	ld	a5,0(s0)
   1039a:	0485                	add	s1,s1,1
   1039c:	0421                	add	s0,s0,8
   1039e:	9782                	jalr	a5
   103a0:	ff24ece3          	bltu	s1,s2,10398 <__libc_init_array+0x28>
   103a4:	6445                	lui	s0,0x11
   103a6:	67c5                	lui	a5,0x11
   103a8:	63878793          	add	a5,a5,1592 # 11638 <__do_global_dtors_aux_fini_array_entry>
   103ac:	62840713          	add	a4,s0,1576 # 11628 <__init_array_start>
   103b0:	40e78933          	sub	s2,a5,a4
   103b4:	40395913          	sra	s2,s2,0x3
   103b8:	00e78b63          	beq	a5,a4,103ce <__libc_init_array+0x5e>
   103bc:	62840413          	add	s0,s0,1576
   103c0:	4481                	li	s1,0
   103c2:	601c                	ld	a5,0(s0)
   103c4:	0485                	add	s1,s1,1
   103c6:	0421                	add	s0,s0,8
   103c8:	9782                	jalr	a5
   103ca:	ff24ece3          	bltu	s1,s2,103c2 <__libc_init_array+0x52>
   103ce:	60e2                	ld	ra,24(sp)
   103d0:	6442                	ld	s0,16(sp)
   103d2:	64a2                	ld	s1,8(sp)
   103d4:	6902                	ld	s2,0(sp)
   103d6:	6105                	add	sp,sp,32
   103d8:	8082                	ret

00000000000103da <memset>:
   103da:	433d                	li	t1,15
   103dc:	872a                	mv	a4,a0
   103de:	02c37163          	bgeu	t1,a2,10400 <memset+0x26>
   103e2:	00f77793          	and	a5,a4,15
   103e6:	e3c1                	bnez	a5,10466 <memset+0x8c>
   103e8:	e1bd                	bnez	a1,1044e <memset+0x74>
   103ea:	ff067693          	and	a3,a2,-16
   103ee:	8a3d                	and	a2,a2,15
   103f0:	96ba                	add	a3,a3,a4
   103f2:	e30c                	sd	a1,0(a4)
   103f4:	e70c                	sd	a1,8(a4)
   103f6:	0741                	add	a4,a4,16
   103f8:	fed76de3          	bltu	a4,a3,103f2 <memset+0x18>
   103fc:	e211                	bnez	a2,10400 <memset+0x26>
   103fe:	8082                	ret
   10400:	40c306b3          	sub	a3,t1,a2
   10404:	068a                	sll	a3,a3,0x2
   10406:	00000297          	auipc	t0,0x0
   1040a:	9696                	add	a3,a3,t0
   1040c:	00a68067          	jr	10(a3)
   10410:	00b70723          	sb	a1,14(a4)
   10414:	00b706a3          	sb	a1,13(a4)
   10418:	00b70623          	sb	a1,12(a4)
   1041c:	00b705a3          	sb	a1,11(a4)
   10420:	00b70523          	sb	a1,10(a4)
   10424:	00b704a3          	sb	a1,9(a4)
   10428:	00b70423          	sb	a1,8(a4)
   1042c:	00b703a3          	sb	a1,7(a4)
   10430:	00b70323          	sb	a1,6(a4)
   10434:	00b702a3          	sb	a1,5(a4)
   10438:	00b70223          	sb	a1,4(a4)
   1043c:	00b701a3          	sb	a1,3(a4)
   10440:	00b70123          	sb	a1,2(a4)
   10444:	00b700a3          	sb	a1,1(a4)
   10448:	00b70023          	sb	a1,0(a4)
   1044c:	8082                	ret
   1044e:	0ff5f593          	zext.b	a1,a1
   10452:	00859693          	sll	a3,a1,0x8
   10456:	8dd5                	or	a1,a1,a3
   10458:	01059693          	sll	a3,a1,0x10
   1045c:	8dd5                	or	a1,a1,a3
   1045e:	02059693          	sll	a3,a1,0x20
   10462:	8dd5                	or	a1,a1,a3
   10464:	b759                	j	103ea <memset+0x10>
   10466:	00279693          	sll	a3,a5,0x2
   1046a:	00000297          	auipc	t0,0x0
   1046e:	9696                	add	a3,a3,t0
   10470:	8286                	mv	t0,ra
   10472:	fa2680e7          	jalr	-94(a3)
   10476:	8096                	mv	ra,t0
   10478:	17c1                	add	a5,a5,-16
   1047a:	8f1d                	sub	a4,a4,a5
   1047c:	963e                	add	a2,a2,a5
   1047e:	f8c371e3          	bgeu	t1,a2,10400 <memset+0x26>
   10482:	b79d                	j	103e8 <memset+0xe>

0000000000010484 <__call_exitprocs>:
   10484:	715d                	add	sp,sp,-80
   10486:	f052                	sd	s4,32(sp)
   10488:	f481ba03          	ld	s4,-184(gp) # 11d88 <_global_impure_ptr>
   1048c:	f84a                	sd	s2,48(sp)
   1048e:	e486                	sd	ra,72(sp)
   10490:	1f8a3903          	ld	s2,504(s4)
   10494:	e0a2                	sd	s0,64(sp)
   10496:	fc26                	sd	s1,56(sp)
   10498:	f44e                	sd	s3,40(sp)
   1049a:	ec56                	sd	s5,24(sp)
   1049c:	e85a                	sd	s6,16(sp)
   1049e:	e45e                	sd	s7,8(sp)
   104a0:	e062                	sd	s8,0(sp)
   104a2:	02090863          	beqz	s2,104d2 <__call_exitprocs+0x4e>
   104a6:	8b2a                	mv	s6,a0
   104a8:	8bae                	mv	s7,a1
   104aa:	4a85                	li	s5,1
   104ac:	59fd                	li	s3,-1
   104ae:	00892483          	lw	s1,8(s2)
   104b2:	fff4841b          	addw	s0,s1,-1
   104b6:	00044e63          	bltz	s0,104d2 <__call_exitprocs+0x4e>
   104ba:	048e                	sll	s1,s1,0x3
   104bc:	94ca                	add	s1,s1,s2
   104be:	020b8663          	beqz	s7,104ea <__call_exitprocs+0x66>
   104c2:	2084b783          	ld	a5,520(s1)
   104c6:	03778263          	beq	a5,s7,104ea <__call_exitprocs+0x66>
   104ca:	347d                	addw	s0,s0,-1
   104cc:	14e1                	add	s1,s1,-8
   104ce:	ff3418e3          	bne	s0,s3,104be <__call_exitprocs+0x3a>
   104d2:	60a6                	ld	ra,72(sp)
   104d4:	6406                	ld	s0,64(sp)
   104d6:	74e2                	ld	s1,56(sp)
   104d8:	7942                	ld	s2,48(sp)
   104da:	79a2                	ld	s3,40(sp)
   104dc:	7a02                	ld	s4,32(sp)
   104de:	6ae2                	ld	s5,24(sp)
   104e0:	6b42                	ld	s6,16(sp)
   104e2:	6ba2                	ld	s7,8(sp)
   104e4:	6c02                	ld	s8,0(sp)
   104e6:	6161                	add	sp,sp,80
   104e8:	8082                	ret
   104ea:	00892783          	lw	a5,8(s2)
   104ee:	6498                	ld	a4,8(s1)
   104f0:	37fd                	addw	a5,a5,-1
   104f2:	04878463          	beq	a5,s0,1053a <__call_exitprocs+0xb6>
   104f6:	0004b423          	sd	zero,8(s1)
   104fa:	db61                	beqz	a4,104ca <__call_exitprocs+0x46>
   104fc:	31092783          	lw	a5,784(s2)
   10500:	008a96bb          	sllw	a3,s5,s0
   10504:	00892c03          	lw	s8,8(s2)
   10508:	8ff5                	and	a5,a5,a3
   1050a:	2781                	sext.w	a5,a5
   1050c:	ef89                	bnez	a5,10526 <__call_exitprocs+0xa2>
   1050e:	9702                	jalr	a4
   10510:	00892703          	lw	a4,8(s2)
   10514:	1f8a3783          	ld	a5,504(s4)
   10518:	01871463          	bne	a4,s8,10520 <__call_exitprocs+0x9c>
   1051c:	fb2787e3          	beq	a5,s2,104ca <__call_exitprocs+0x46>
   10520:	dbcd                	beqz	a5,104d2 <__call_exitprocs+0x4e>
   10522:	893e                	mv	s2,a5
   10524:	b769                	j	104ae <__call_exitprocs+0x2a>
   10526:	31492783          	lw	a5,788(s2)
   1052a:	1084b583          	ld	a1,264(s1)
   1052e:	8ff5                	and	a5,a5,a3
   10530:	2781                	sext.w	a5,a5
   10532:	e799                	bnez	a5,10540 <__call_exitprocs+0xbc>
   10534:	855a                	mv	a0,s6
   10536:	9702                	jalr	a4
   10538:	bfe1                	j	10510 <__call_exitprocs+0x8c>
   1053a:	00892423          	sw	s0,8(s2)
   1053e:	bf75                	j	104fa <__call_exitprocs+0x76>
   10540:	852e                	mv	a0,a1
   10542:	9702                	jalr	a4
   10544:	b7f1                	j	10510 <__call_exitprocs+0x8c>

0000000000010546 <__libc_fini_array>:
   10546:	1101                	add	sp,sp,-32
   10548:	e822                	sd	s0,16(sp)
   1054a:	67c5                	lui	a5,0x11
   1054c:	6445                	lui	s0,0x11
   1054e:	63878793          	add	a5,a5,1592 # 11638 <__do_global_dtors_aux_fini_array_entry>
   10552:	64040413          	add	s0,s0,1600 # 11640 <impure_data>
   10556:	8c1d                	sub	s0,s0,a5
   10558:	e426                	sd	s1,8(sp)
   1055a:	ec06                	sd	ra,24(sp)
   1055c:	40345493          	sra	s1,s0,0x3
   10560:	c881                	beqz	s1,10570 <__libc_fini_array+0x2a>
   10562:	1461                	add	s0,s0,-8
   10564:	943e                	add	s0,s0,a5
   10566:	601c                	ld	a5,0(s0)
   10568:	14fd                	add	s1,s1,-1
   1056a:	1461                	add	s0,s0,-8
   1056c:	9782                	jalr	a5
   1056e:	fce5                	bnez	s1,10566 <__libc_fini_array+0x20>
   10570:	60e2                	ld	ra,24(sp)
   10572:	6442                	ld	s0,16(sp)
   10574:	64a2                	ld	s1,8(sp)
   10576:	6105                	add	sp,sp,32
   10578:	8082                	ret

000000000001057a <atexit>:
   1057a:	85aa                	mv	a1,a0
   1057c:	4681                	li	a3,0
   1057e:	4601                	li	a2,0
   10580:	4501                	li	a0,0
   10582:	a009                	j	10584 <__register_exitproc>

0000000000010584 <__register_exitproc>:
   10584:	f481b703          	ld	a4,-184(gp) # 11d88 <_global_impure_ptr>
   10588:	1f873783          	ld	a5,504(a4)
   1058c:	c3b1                	beqz	a5,105d0 <__register_exitproc+0x4c>
   1058e:	4798                	lw	a4,8(a5)
   10590:	487d                	li	a6,31
   10592:	06e84263          	blt	a6,a4,105f6 <__register_exitproc+0x72>
   10596:	c505                	beqz	a0,105be <__register_exitproc+0x3a>
   10598:	00371813          	sll	a6,a4,0x3
   1059c:	983e                	add	a6,a6,a5
   1059e:	10c83823          	sd	a2,272(a6)
   105a2:	3107a883          	lw	a7,784(a5)
   105a6:	4605                	li	a2,1
   105a8:	00e6163b          	sllw	a2,a2,a4
   105ac:	00c8e8b3          	or	a7,a7,a2
   105b0:	3117a823          	sw	a7,784(a5)
   105b4:	20d83823          	sd	a3,528(a6)
   105b8:	4689                	li	a3,2
   105ba:	02d50063          	beq	a0,a3,105da <__register_exitproc+0x56>
   105be:	00270693          	add	a3,a4,2
   105c2:	068e                	sll	a3,a3,0x3
   105c4:	2705                	addw	a4,a4,1
   105c6:	c798                	sw	a4,8(a5)
   105c8:	97b6                	add	a5,a5,a3
   105ca:	e38c                	sd	a1,0(a5)
   105cc:	4501                	li	a0,0
   105ce:	8082                	ret
   105d0:	20070793          	add	a5,a4,512
   105d4:	1ef73c23          	sd	a5,504(a4)
   105d8:	bf5d                	j	1058e <__register_exitproc+0xa>
   105da:	3147a683          	lw	a3,788(a5)
   105de:	4501                	li	a0,0
   105e0:	8ed1                	or	a3,a3,a2
   105e2:	30d7aa23          	sw	a3,788(a5)
   105e6:	00270693          	add	a3,a4,2
   105ea:	068e                	sll	a3,a3,0x3
   105ec:	2705                	addw	a4,a4,1
   105ee:	c798                	sw	a4,8(a5)
   105f0:	97b6                	add	a5,a5,a3
   105f2:	e38c                	sd	a1,0(a5)
   105f4:	8082                	ret
   105f6:	557d                	li	a0,-1
   105f8:	8082                	ret

00000000000105fa <_exit>:
   105fa:	05d00893          	li	a7,93
   105fe:	00000073          	ecall
   10602:	00054363          	bltz	a0,10608 <_exit+0xe>
   10606:	a001                	j	10606 <_exit+0xc>
   10608:	1141                	add	sp,sp,-16
   1060a:	e022                	sd	s0,0(sp)
   1060c:	842a                	mv	s0,a0
   1060e:	e406                	sd	ra,8(sp)
   10610:	4080043b          	negw	s0,s0
   10614:	008000ef          	jal	1061c <__errno>
   10618:	c100                	sw	s0,0(a0)
   1061a:	a001                	j	1061a <_exit+0x20>

000000000001061c <__errno>:
   1061c:	f581b503          	ld	a0,-168(gp) # 11d98 <_impure_ptr>
   10620:	8082                	ret

sraw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	452000ef          	jal	10544 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11e48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	5b8000ef          	jal	106ba <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	60650513          	add	a0,a0,1542 # 10606 <__libc_fini_array>
   10112:	a325                	j	1063a <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	dea18193          	add	gp,gp,-534 # 11f00 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11e60 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11e98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	370000ef          	jal	1049a <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	50c50513          	add	a0,a0,1292 # 1063a <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	4ce50513          	add	a0,a0,1230 # 10606 <__libc_fini_array>
   10140:	4fa000ef          	jal	1063a <atexit>
   10144:	2ec000ef          	jal	10430 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11e60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	6e450513          	add	a0,a0,1764 # 116e4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11e60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11e68 <object.0>
   1018e:	6e450513          	add	a0,a0,1764 # 116e4 <__EH_FRAME_BEGIN__>
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
   101ae:	800000b7          	lui	ra,0x80000
   101b2:	4101                	li	sp,0
   101b4:	4020d73b          	sraw	a4,ra,sp
   101b8:	800003b7          	lui	t2,0x80000
   101bc:	26771263          	bne	a4,t2,10420 <fail>

00000000000101c0 <test_3>:
   101c0:	418d                	li	gp,3
   101c2:	800000b7          	lui	ra,0x80000
   101c6:	4105                	li	sp,1
   101c8:	4020d73b          	sraw	a4,ra,sp
   101cc:	c00003b7          	lui	t2,0xc0000
   101d0:	24771863          	bne	a4,t2,10420 <fail>

00000000000101d4 <test_4>:
   101d4:	4191                	li	gp,4
   101d6:	800000b7          	lui	ra,0x80000
   101da:	411d                	li	sp,7
   101dc:	4020d73b          	sraw	a4,ra,sp
   101e0:	ff0003b7          	lui	t2,0xff000
   101e4:	22771e63          	bne	a4,t2,10420 <fail>

00000000000101e8 <test_5>:
   101e8:	4195                	li	gp,5
   101ea:	800000b7          	lui	ra,0x80000
   101ee:	4139                	li	sp,14
   101f0:	4020d73b          	sraw	a4,ra,sp
   101f4:	7381                	lui	t2,0xfffe0
   101f6:	22771563          	bne	a4,t2,10420 <fail>

00000000000101fa <test_6>:
   101fa:	4199                	li	gp,6
   101fc:	800000b7          	lui	ra,0x80000
   10200:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee101>
   10202:	417d                	li	sp,31
   10204:	4020d73b          	sraw	a4,ra,sp
   10208:	53fd                	li	t2,-1
   1020a:	20771b63          	bne	a4,t2,10420 <fail>

000000000001020e <test_7>:
   1020e:	419d                	li	gp,7
   10210:	800000b7          	lui	ra,0x80000
   10214:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee0ff>
   10216:	4101                	li	sp,0
   10218:	4020d73b          	sraw	a4,ra,sp
   1021c:	800003b7          	lui	t2,0x80000
   10220:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee0ff>
   10222:	1e771f63          	bne	a4,t2,10420 <fail>

0000000000010226 <test_8>:
   10226:	41a1                	li	gp,8
   10228:	800000b7          	lui	ra,0x80000
   1022c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee0ff>
   1022e:	4105                	li	sp,1
   10230:	4020d73b          	sraw	a4,ra,sp
   10234:	400003b7          	lui	t2,0x40000
   10238:	33fd                	addw	t2,t2,-1 # 3fffffff <__global_pointer$+0x3ffee0ff>
   1023a:	1e771363          	bne	a4,t2,10420 <fail>

000000000001023e <test_9>:
   1023e:	41a5                	li	gp,9
   10240:	800000b7          	lui	ra,0x80000
   10244:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee0ff>
   10246:	411d                	li	sp,7
   10248:	4020d73b          	sraw	a4,ra,sp
   1024c:	010003b7          	lui	t2,0x1000
   10250:	33fd                	addw	t2,t2,-1 # ffffff <__global_pointer$+0xfee0ff>
   10252:	1c771763          	bne	a4,t2,10420 <fail>

0000000000010256 <test_10>:
   10256:	41a9                	li	gp,10
   10258:	800000b7          	lui	ra,0x80000
   1025c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee0ff>
   1025e:	4139                	li	sp,14
   10260:	4020d73b          	sraw	a4,ra,sp
   10264:	000203b7          	lui	t2,0x20
   10268:	33fd                	addw	t2,t2,-1 # 1ffff <__global_pointer$+0xe0ff>
   1026a:	1a771b63          	bne	a4,t2,10420 <fail>

000000000001026e <test_11>:
   1026e:	41ad                	li	gp,11
   10270:	800000b7          	lui	ra,0x80000
   10274:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee0ff>
   10276:	417d                	li	sp,31
   10278:	4020d73b          	sraw	a4,ra,sp
   1027c:	4381                	li	t2,0
   1027e:	1a771163          	bne	a4,t2,10420 <fail>

0000000000010282 <test_12>:
   10282:	41b1                	li	gp,12
   10284:	818180b7          	lui	ra,0x81818
   10288:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   1028c:	4101                	li	sp,0
   1028e:	4020d73b          	sraw	a4,ra,sp
   10292:	818183b7          	lui	t2,0x81818
   10296:	1813839b          	addw	t2,t2,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   1029a:	18771363          	bne	a4,t2,10420 <fail>

000000000001029e <test_13>:
   1029e:	41b5                	li	gp,13
   102a0:	818180b7          	lui	ra,0x81818
   102a4:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   102a8:	4105                	li	sp,1
   102aa:	4020d73b          	sraw	a4,ra,sp
   102ae:	c0c0c3b7          	lui	t2,0xc0c0c
   102b2:	0c03839b          	addw	t2,t2,192 # ffffffffc0c0c0c0 <__global_pointer$+0xffffffffc0bfa1c0>
   102b6:	16771563          	bne	a4,t2,10420 <fail>

00000000000102ba <test_14>:
   102ba:	41b9                	li	gp,14
   102bc:	818180b7          	lui	ra,0x81818
   102c0:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   102c4:	411d                	li	sp,7
   102c6:	4020d73b          	sraw	a4,ra,sp
   102ca:	ff0303b7          	lui	t2,0xff030
   102ce:	3033839b          	addw	t2,t2,771 # ffffffffff030303 <__global_pointer$+0xffffffffff01e403>
   102d2:	14771763          	bne	a4,t2,10420 <fail>

00000000000102d6 <test_15>:
   102d6:	41bd                	li	gp,15
   102d8:	818180b7          	lui	ra,0x81818
   102dc:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   102e0:	4139                	li	sp,14
   102e2:	4020d73b          	sraw	a4,ra,sp
   102e6:	7381                	lui	t2,0xfffe0
   102e8:	6063839b          	addw	t2,t2,1542 # fffffffffffe0606 <__global_pointer$+0xfffffffffffce706>
   102ec:	12771a63          	bne	a4,t2,10420 <fail>

00000000000102f0 <test_16>:
   102f0:	41c1                	li	gp,16
   102f2:	818180b7          	lui	ra,0x81818
   102f6:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   102fa:	417d                	li	sp,31
   102fc:	4020d73b          	sraw	a4,ra,sp
   10300:	53fd                	li	t2,-1
   10302:	10771f63          	bne	a4,t2,10420 <fail>

0000000000010306 <test_17>:
   10306:	41c5                	li	gp,17
   10308:	818180b7          	lui	ra,0x81818
   1030c:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   10310:	5101                	li	sp,-32
   10312:	4020d73b          	sraw	a4,ra,sp
   10316:	818183b7          	lui	t2,0x81818
   1031a:	1813839b          	addw	t2,t2,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   1031e:	10771163          	bne	a4,t2,10420 <fail>

0000000000010322 <test_18>:
   10322:	41c9                	li	gp,18
   10324:	818180b7          	lui	ra,0x81818
   10328:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   1032c:	5105                	li	sp,-31
   1032e:	4020d73b          	sraw	a4,ra,sp
   10332:	c0c0c3b7          	lui	t2,0xc0c0c
   10336:	0c03839b          	addw	t2,t2,192 # ffffffffc0c0c0c0 <__global_pointer$+0xffffffffc0bfa1c0>
   1033a:	0e771363          	bne	a4,t2,10420 <fail>

000000000001033e <test_19>:
   1033e:	41cd                	li	gp,19
   10340:	818180b7          	lui	ra,0x81818
   10344:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   10348:	511d                	li	sp,-25
   1034a:	4020d73b          	sraw	a4,ra,sp
   1034e:	ff0303b7          	lui	t2,0xff030
   10352:	3033839b          	addw	t2,t2,771 # ffffffffff030303 <__global_pointer$+0xffffffffff01e403>
   10356:	0c771563          	bne	a4,t2,10420 <fail>

000000000001035a <test_20>:
   1035a:	41d1                	li	gp,20
   1035c:	818180b7          	lui	ra,0x81818
   10360:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   10364:	5139                	li	sp,-18
   10366:	4020d73b          	sraw	a4,ra,sp
   1036a:	7381                	lui	t2,0xfffe0
   1036c:	6063839b          	addw	t2,t2,1542 # fffffffffffe0606 <__global_pointer$+0xfffffffffffce706>
   10370:	0a771863          	bne	a4,t2,10420 <fail>

0000000000010374 <test_21>:
   10374:	41d5                	li	gp,21
   10376:	818180b7          	lui	ra,0x81818
   1037a:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806281>
   1037e:	517d                	li	sp,-1
   10380:	4020d73b          	sraw	a4,ra,sp
   10384:	53fd                	li	t2,-1
   10386:	08771d63          	bne	a4,t2,10420 <fail>

000000000001038a <test_44>:
   1038a:	02c00193          	li	gp,44
   1038e:	fff120b7          	lui	ra,0xfff12
   10392:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00445>
   10396:	00b2                	sll	ra,ra,0xc
   10398:	67808093          	add	ra,ra,1656
   1039c:	4101                	li	sp,0
   1039e:	4020d73b          	sraw	a4,ra,sp
   103a2:	123453b7          	lui	t2,0x12345
   103a6:	6783839b          	addw	t2,t2,1656 # 12345678 <__global_pointer$+0x12333778>
   103aa:	06771b63          	bne	a4,t2,10420 <fail>

00000000000103ae <test_45>:
   103ae:	02d00193          	li	gp,45
   103b2:	fff120b7          	lui	ra,0xfff12
   103b6:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00445>
   103ba:	00b2                	sll	ra,ra,0xc
   103bc:	67808093          	add	ra,ra,1656
   103c0:	4111                	li	sp,4
   103c2:	4020d73b          	sraw	a4,ra,sp
   103c6:	012343b7          	lui	t2,0x1234
   103ca:	5673839b          	addw	t2,t2,1383 # 1234567 <__global_pointer$+0x1222667>
   103ce:	04771963          	bne	a4,t2,10420 <fail>

00000000000103d2 <test_46>:
   103d2:	02e00193          	li	gp,46
   103d6:	000920b7          	lui	ra,0x92
   103da:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80445>
   103de:	00b2                	sll	ra,ra,0xc
   103e0:	67808093          	add	ra,ra,1656
   103e4:	4101                	li	sp,0
   103e6:	4020d73b          	sraw	a4,ra,sp
   103ea:	923453b7          	lui	t2,0x92345
   103ee:	6783839b          	addw	t2,t2,1656 # ffffffff92345678 <__global_pointer$+0xffffffff92333778>
   103f2:	02771763          	bne	a4,t2,10420 <fail>

00000000000103f6 <test_47>:
   103f6:	02f00193          	li	gp,47
   103fa:	000920b7          	lui	ra,0x92
   103fe:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80445>
   10402:	00b2                	sll	ra,ra,0xc
   10404:	67808093          	add	ra,ra,1656
   10408:	4111                	li	sp,4
   1040a:	4020d73b          	sraw	a4,ra,sp
   1040e:	f92343b7          	lui	t2,0xf9234
   10412:	5673839b          	addw	t2,t2,1383 # fffffffff9234567 <__global_pointer$+0xfffffffff9222667>
   10416:	00771563          	bne	a4,t2,10420 <fail>
   1041a:	00301263          	bne	zero,gp,1041e <pass>

000000000001041e <pass>:
   1041e:	a019                	j	10424 <continue>

0000000000010420 <fail>:
   10420:	00000000          	.word	0x00000000

0000000000010424 <continue>:
   10424:	4081                	li	ra,0
   10426:	4781                	li	a5,0
   10428:	853e                	mv	a0,a5
   1042a:	6462                	ld	s0,24(sp)
   1042c:	6105                	add	sp,sp,32
   1042e:	8082                	ret

0000000000010430 <__libc_init_array>:
   10430:	1101                	add	sp,sp,-32
   10432:	e822                	sd	s0,16(sp)
   10434:	67c5                	lui	a5,0x11
   10436:	6445                	lui	s0,0x11
   10438:	e04a                	sd	s2,0(sp)
   1043a:	6e878793          	add	a5,a5,1768 # 116e8 <__init_array_start>
   1043e:	6e840713          	add	a4,s0,1768 # 116e8 <__init_array_start>
   10442:	ec06                	sd	ra,24(sp)
   10444:	e426                	sd	s1,8(sp)
   10446:	40e78933          	sub	s2,a5,a4
   1044a:	00e78d63          	beq	a5,a4,10464 <__libc_init_array+0x34>
   1044e:	40395913          	sra	s2,s2,0x3
   10452:	6e840413          	add	s0,s0,1768
   10456:	4481                	li	s1,0
   10458:	601c                	ld	a5,0(s0)
   1045a:	0485                	add	s1,s1,1
   1045c:	0421                	add	s0,s0,8
   1045e:	9782                	jalr	a5
   10460:	ff24ece3          	bltu	s1,s2,10458 <__libc_init_array+0x28>
   10464:	6445                	lui	s0,0x11
   10466:	67c5                	lui	a5,0x11
   10468:	6f878793          	add	a5,a5,1784 # 116f8 <__do_global_dtors_aux_fini_array_entry>
   1046c:	6e840713          	add	a4,s0,1768 # 116e8 <__init_array_start>
   10470:	40e78933          	sub	s2,a5,a4
   10474:	40395913          	sra	s2,s2,0x3
   10478:	00e78b63          	beq	a5,a4,1048e <__libc_init_array+0x5e>
   1047c:	6e840413          	add	s0,s0,1768
   10480:	4481                	li	s1,0
   10482:	601c                	ld	a5,0(s0)
   10484:	0485                	add	s1,s1,1
   10486:	0421                	add	s0,s0,8
   10488:	9782                	jalr	a5
   1048a:	ff24ece3          	bltu	s1,s2,10482 <__libc_init_array+0x52>
   1048e:	60e2                	ld	ra,24(sp)
   10490:	6442                	ld	s0,16(sp)
   10492:	64a2                	ld	s1,8(sp)
   10494:	6902                	ld	s2,0(sp)
   10496:	6105                	add	sp,sp,32
   10498:	8082                	ret

000000000001049a <memset>:
   1049a:	433d                	li	t1,15
   1049c:	872a                	mv	a4,a0
   1049e:	02c37163          	bgeu	t1,a2,104c0 <memset+0x26>
   104a2:	00f77793          	and	a5,a4,15
   104a6:	e3c1                	bnez	a5,10526 <memset+0x8c>
   104a8:	e1bd                	bnez	a1,1050e <memset+0x74>
   104aa:	ff067693          	and	a3,a2,-16
   104ae:	8a3d                	and	a2,a2,15
   104b0:	96ba                	add	a3,a3,a4
   104b2:	e30c                	sd	a1,0(a4)
   104b4:	e70c                	sd	a1,8(a4)
   104b6:	0741                	add	a4,a4,16
   104b8:	fed76de3          	bltu	a4,a3,104b2 <memset+0x18>
   104bc:	e211                	bnez	a2,104c0 <memset+0x26>
   104be:	8082                	ret
   104c0:	40c306b3          	sub	a3,t1,a2
   104c4:	068a                	sll	a3,a3,0x2
   104c6:	00000297          	auipc	t0,0x0
   104ca:	9696                	add	a3,a3,t0
   104cc:	00a68067          	jr	10(a3)
   104d0:	00b70723          	sb	a1,14(a4)
   104d4:	00b706a3          	sb	a1,13(a4)
   104d8:	00b70623          	sb	a1,12(a4)
   104dc:	00b705a3          	sb	a1,11(a4)
   104e0:	00b70523          	sb	a1,10(a4)
   104e4:	00b704a3          	sb	a1,9(a4)
   104e8:	00b70423          	sb	a1,8(a4)
   104ec:	00b703a3          	sb	a1,7(a4)
   104f0:	00b70323          	sb	a1,6(a4)
   104f4:	00b702a3          	sb	a1,5(a4)
   104f8:	00b70223          	sb	a1,4(a4)
   104fc:	00b701a3          	sb	a1,3(a4)
   10500:	00b70123          	sb	a1,2(a4)
   10504:	00b700a3          	sb	a1,1(a4)
   10508:	00b70023          	sb	a1,0(a4)
   1050c:	8082                	ret
   1050e:	0ff5f593          	zext.b	a1,a1
   10512:	00859693          	sll	a3,a1,0x8
   10516:	8dd5                	or	a1,a1,a3
   10518:	01059693          	sll	a3,a1,0x10
   1051c:	8dd5                	or	a1,a1,a3
   1051e:	02059693          	sll	a3,a1,0x20
   10522:	8dd5                	or	a1,a1,a3
   10524:	b759                	j	104aa <memset+0x10>
   10526:	00279693          	sll	a3,a5,0x2
   1052a:	00000297          	auipc	t0,0x0
   1052e:	9696                	add	a3,a3,t0
   10530:	8286                	mv	t0,ra
   10532:	fa2680e7          	jalr	-94(a3)
   10536:	8096                	mv	ra,t0
   10538:	17c1                	add	a5,a5,-16
   1053a:	8f1d                	sub	a4,a4,a5
   1053c:	963e                	add	a2,a2,a5
   1053e:	f8c371e3          	bgeu	t1,a2,104c0 <memset+0x26>
   10542:	b79d                	j	104a8 <memset+0xe>

0000000000010544 <__call_exitprocs>:
   10544:	715d                	add	sp,sp,-80
   10546:	f052                	sd	s4,32(sp)
   10548:	f481ba03          	ld	s4,-184(gp) # 11e48 <_global_impure_ptr>
   1054c:	f84a                	sd	s2,48(sp)
   1054e:	e486                	sd	ra,72(sp)
   10550:	1f8a3903          	ld	s2,504(s4)
   10554:	e0a2                	sd	s0,64(sp)
   10556:	fc26                	sd	s1,56(sp)
   10558:	f44e                	sd	s3,40(sp)
   1055a:	ec56                	sd	s5,24(sp)
   1055c:	e85a                	sd	s6,16(sp)
   1055e:	e45e                	sd	s7,8(sp)
   10560:	e062                	sd	s8,0(sp)
   10562:	02090863          	beqz	s2,10592 <__call_exitprocs+0x4e>
   10566:	8b2a                	mv	s6,a0
   10568:	8bae                	mv	s7,a1
   1056a:	4a85                	li	s5,1
   1056c:	59fd                	li	s3,-1
   1056e:	00892483          	lw	s1,8(s2)
   10572:	fff4841b          	addw	s0,s1,-1
   10576:	00044e63          	bltz	s0,10592 <__call_exitprocs+0x4e>
   1057a:	048e                	sll	s1,s1,0x3
   1057c:	94ca                	add	s1,s1,s2
   1057e:	020b8663          	beqz	s7,105aa <__call_exitprocs+0x66>
   10582:	2084b783          	ld	a5,520(s1)
   10586:	03778263          	beq	a5,s7,105aa <__call_exitprocs+0x66>
   1058a:	347d                	addw	s0,s0,-1
   1058c:	14e1                	add	s1,s1,-8
   1058e:	ff3418e3          	bne	s0,s3,1057e <__call_exitprocs+0x3a>
   10592:	60a6                	ld	ra,72(sp)
   10594:	6406                	ld	s0,64(sp)
   10596:	74e2                	ld	s1,56(sp)
   10598:	7942                	ld	s2,48(sp)
   1059a:	79a2                	ld	s3,40(sp)
   1059c:	7a02                	ld	s4,32(sp)
   1059e:	6ae2                	ld	s5,24(sp)
   105a0:	6b42                	ld	s6,16(sp)
   105a2:	6ba2                	ld	s7,8(sp)
   105a4:	6c02                	ld	s8,0(sp)
   105a6:	6161                	add	sp,sp,80
   105a8:	8082                	ret
   105aa:	00892783          	lw	a5,8(s2)
   105ae:	6498                	ld	a4,8(s1)
   105b0:	37fd                	addw	a5,a5,-1
   105b2:	04878463          	beq	a5,s0,105fa <__call_exitprocs+0xb6>
   105b6:	0004b423          	sd	zero,8(s1)
   105ba:	db61                	beqz	a4,1058a <__call_exitprocs+0x46>
   105bc:	31092783          	lw	a5,784(s2)
   105c0:	008a96bb          	sllw	a3,s5,s0
   105c4:	00892c03          	lw	s8,8(s2)
   105c8:	8ff5                	and	a5,a5,a3
   105ca:	2781                	sext.w	a5,a5
   105cc:	ef89                	bnez	a5,105e6 <__call_exitprocs+0xa2>
   105ce:	9702                	jalr	a4
   105d0:	00892703          	lw	a4,8(s2)
   105d4:	1f8a3783          	ld	a5,504(s4)
   105d8:	01871463          	bne	a4,s8,105e0 <__call_exitprocs+0x9c>
   105dc:	fb2787e3          	beq	a5,s2,1058a <__call_exitprocs+0x46>
   105e0:	dbcd                	beqz	a5,10592 <__call_exitprocs+0x4e>
   105e2:	893e                	mv	s2,a5
   105e4:	b769                	j	1056e <__call_exitprocs+0x2a>
   105e6:	31492783          	lw	a5,788(s2)
   105ea:	1084b583          	ld	a1,264(s1)
   105ee:	8ff5                	and	a5,a5,a3
   105f0:	2781                	sext.w	a5,a5
   105f2:	e799                	bnez	a5,10600 <__call_exitprocs+0xbc>
   105f4:	855a                	mv	a0,s6
   105f6:	9702                	jalr	a4
   105f8:	bfe1                	j	105d0 <__call_exitprocs+0x8c>
   105fa:	00892423          	sw	s0,8(s2)
   105fe:	bf75                	j	105ba <__call_exitprocs+0x76>
   10600:	852e                	mv	a0,a1
   10602:	9702                	jalr	a4
   10604:	b7f1                	j	105d0 <__call_exitprocs+0x8c>

0000000000010606 <__libc_fini_array>:
   10606:	1101                	add	sp,sp,-32
   10608:	e822                	sd	s0,16(sp)
   1060a:	67c5                	lui	a5,0x11
   1060c:	6445                	lui	s0,0x11
   1060e:	6f878793          	add	a5,a5,1784 # 116f8 <__do_global_dtors_aux_fini_array_entry>
   10612:	70040413          	add	s0,s0,1792 # 11700 <impure_data>
   10616:	8c1d                	sub	s0,s0,a5
   10618:	e426                	sd	s1,8(sp)
   1061a:	ec06                	sd	ra,24(sp)
   1061c:	40345493          	sra	s1,s0,0x3
   10620:	c881                	beqz	s1,10630 <__libc_fini_array+0x2a>
   10622:	1461                	add	s0,s0,-8
   10624:	943e                	add	s0,s0,a5
   10626:	601c                	ld	a5,0(s0)
   10628:	14fd                	add	s1,s1,-1
   1062a:	1461                	add	s0,s0,-8
   1062c:	9782                	jalr	a5
   1062e:	fce5                	bnez	s1,10626 <__libc_fini_array+0x20>
   10630:	60e2                	ld	ra,24(sp)
   10632:	6442                	ld	s0,16(sp)
   10634:	64a2                	ld	s1,8(sp)
   10636:	6105                	add	sp,sp,32
   10638:	8082                	ret

000000000001063a <atexit>:
   1063a:	85aa                	mv	a1,a0
   1063c:	4681                	li	a3,0
   1063e:	4601                	li	a2,0
   10640:	4501                	li	a0,0
   10642:	a009                	j	10644 <__register_exitproc>

0000000000010644 <__register_exitproc>:
   10644:	f481b703          	ld	a4,-184(gp) # 11e48 <_global_impure_ptr>
   10648:	1f873783          	ld	a5,504(a4)
   1064c:	c3b1                	beqz	a5,10690 <__register_exitproc+0x4c>
   1064e:	4798                	lw	a4,8(a5)
   10650:	487d                	li	a6,31
   10652:	06e84263          	blt	a6,a4,106b6 <__register_exitproc+0x72>
   10656:	c505                	beqz	a0,1067e <__register_exitproc+0x3a>
   10658:	00371813          	sll	a6,a4,0x3
   1065c:	983e                	add	a6,a6,a5
   1065e:	10c83823          	sd	a2,272(a6)
   10662:	3107a883          	lw	a7,784(a5)
   10666:	4605                	li	a2,1
   10668:	00e6163b          	sllw	a2,a2,a4
   1066c:	00c8e8b3          	or	a7,a7,a2
   10670:	3117a823          	sw	a7,784(a5)
   10674:	20d83823          	sd	a3,528(a6)
   10678:	4689                	li	a3,2
   1067a:	02d50063          	beq	a0,a3,1069a <__register_exitproc+0x56>
   1067e:	00270693          	add	a3,a4,2
   10682:	068e                	sll	a3,a3,0x3
   10684:	2705                	addw	a4,a4,1
   10686:	c798                	sw	a4,8(a5)
   10688:	97b6                	add	a5,a5,a3
   1068a:	e38c                	sd	a1,0(a5)
   1068c:	4501                	li	a0,0
   1068e:	8082                	ret
   10690:	20070793          	add	a5,a4,512
   10694:	1ef73c23          	sd	a5,504(a4)
   10698:	bf5d                	j	1064e <__register_exitproc+0xa>
   1069a:	3147a683          	lw	a3,788(a5)
   1069e:	4501                	li	a0,0
   106a0:	8ed1                	or	a3,a3,a2
   106a2:	30d7aa23          	sw	a3,788(a5)
   106a6:	00270693          	add	a3,a4,2
   106aa:	068e                	sll	a3,a3,0x3
   106ac:	2705                	addw	a4,a4,1
   106ae:	c798                	sw	a4,8(a5)
   106b0:	97b6                	add	a5,a5,a3
   106b2:	e38c                	sd	a1,0(a5)
   106b4:	8082                	ret
   106b6:	557d                	li	a0,-1
   106b8:	8082                	ret

00000000000106ba <_exit>:
   106ba:	05d00893          	li	a7,93
   106be:	00000073          	ecall
   106c2:	00054363          	bltz	a0,106c8 <_exit+0xe>
   106c6:	a001                	j	106c6 <_exit+0xc>
   106c8:	1141                	add	sp,sp,-16
   106ca:	e022                	sd	s0,0(sp)
   106cc:	842a                	mv	s0,a0
   106ce:	e406                	sd	ra,8(sp)
   106d0:	4080043b          	negw	s0,s0
   106d4:	008000ef          	jal	106dc <__errno>
   106d8:	c100                	sw	s0,0(a0)
   106da:	a001                	j	106da <_exit+0x20>

00000000000106dc <__errno>:
   106dc:	f581b503          	ld	a0,-168(gp) # 11e58 <_impure_ptr>
   106e0:	8082                	ret

sltiu.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2c8000ef          	jal	103ba <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11cc0 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	42e000ef          	jal	10530 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	47c50513          	add	a0,a0,1148 # 1047c <__libc_fini_array>
   10112:	ae79                	j	104b0 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c6218193          	add	gp,gp,-926 # 11d78 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11cd8 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d10 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	1e6000ef          	jal	10310 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	38250513          	add	a0,a0,898 # 104b0 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	34450513          	add	a0,a0,836 # 1047c <__libc_fini_array>
   10140:	370000ef          	jal	104b0 <atexit>
   10144:	162000ef          	jal	102a6 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11cd8 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	55850513          	add	a0,a0,1368 # 11558 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11cd8 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11ce0 <object.0>
   1018e:	55850513          	add	a0,a0,1368 # 11558 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	0000b713          	sltiu	a4,ra,0
   101b4:	4381                	li	t2,0
   101b6:	0e771063          	bne	a4,t2,10296 <fail>

00000000000101ba <test_3>:
   101ba:	418d                	li	gp,3
   101bc:	4085                	li	ra,1
   101be:	0010b713          	seqz	a4,ra
   101c2:	4381                	li	t2,0
   101c4:	0c771963          	bne	a4,t2,10296 <fail>

00000000000101c8 <test_4>:
   101c8:	4191                	li	gp,4
   101ca:	408d                	li	ra,3
   101cc:	0070b713          	sltiu	a4,ra,7
   101d0:	4385                	li	t2,1
   101d2:	0c771263          	bne	a4,t2,10296 <fail>

00000000000101d6 <test_5>:
   101d6:	4195                	li	gp,5
   101d8:	409d                	li	ra,7
   101da:	0030b713          	sltiu	a4,ra,3
   101de:	4381                	li	t2,0
   101e0:	0a771b63          	bne	a4,t2,10296 <fail>

00000000000101e4 <test_6>:
   101e4:	4199                	li	gp,6
   101e6:	4081                	li	ra,0
   101e8:	8000b713          	sltiu	a4,ra,-2048
   101ec:	4385                	li	t2,1
   101ee:	0a771463          	bne	a4,t2,10296 <fail>

00000000000101f2 <test_7>:
   101f2:	419d                	li	gp,7
   101f4:	800000b7          	lui	ra,0x80000
   101f8:	0000b713          	sltiu	a4,ra,0
   101fc:	4381                	li	t2,0
   101fe:	08771c63          	bne	a4,t2,10296 <fail>

0000000000010202 <test_8>:
   10202:	41a1                	li	gp,8
   10204:	800000b7          	lui	ra,0x80000
   10208:	8000b713          	sltiu	a4,ra,-2048
   1020c:	4385                	li	t2,1
   1020e:	08771463          	bne	a4,t2,10296 <fail>

0000000000010212 <test_9>:
   10212:	41a5                	li	gp,9
   10214:	4081                	li	ra,0
   10216:	7ff0b713          	sltiu	a4,ra,2047
   1021a:	4385                	li	t2,1
   1021c:	06771d63          	bne	a4,t2,10296 <fail>

0000000000010220 <test_10>:
   10220:	41a9                	li	gp,10
   10222:	800000b7          	lui	ra,0x80000
   10226:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee287>
   10228:	0000b713          	sltiu	a4,ra,0
   1022c:	4381                	li	t2,0
   1022e:	06771463          	bne	a4,t2,10296 <fail>

0000000000010232 <test_11>:
   10232:	41ad                	li	gp,11
   10234:	800000b7          	lui	ra,0x80000
   10238:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee287>
   1023a:	7ff0b713          	sltiu	a4,ra,2047
   1023e:	4381                	li	t2,0
   10240:	04771b63          	bne	a4,t2,10296 <fail>

0000000000010244 <test_12>:
   10244:	41b1                	li	gp,12
   10246:	800000b7          	lui	ra,0x80000
   1024a:	7ff0b713          	sltiu	a4,ra,2047
   1024e:	4381                	li	t2,0
   10250:	04771363          	bne	a4,t2,10296 <fail>

0000000000010254 <test_13>:
   10254:	41b5                	li	gp,13
   10256:	800000b7          	lui	ra,0x80000
   1025a:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee287>
   1025c:	8000b713          	sltiu	a4,ra,-2048
   10260:	4385                	li	t2,1
   10262:	02771a63          	bne	a4,t2,10296 <fail>

0000000000010266 <test_14>:
   10266:	41b9                	li	gp,14
   10268:	4081                	li	ra,0
   1026a:	fff0b713          	sltiu	a4,ra,-1
   1026e:	4385                	li	t2,1
   10270:	02771363          	bne	a4,t2,10296 <fail>

0000000000010274 <test_15>:
   10274:	41bd                	li	gp,15
   10276:	50fd                	li	ra,-1
   10278:	0010b713          	seqz	a4,ra
   1027c:	4381                	li	t2,0
   1027e:	00771c63          	bne	a4,t2,10296 <fail>

0000000000010282 <test_16>:
   10282:	41c1                	li	gp,16
   10284:	50fd                	li	ra,-1
   10286:	fff0b713          	sltiu	a4,ra,-1
   1028a:	4381                	li	t2,0
   1028c:	00771563          	bne	a4,t2,10296 <fail>
   10290:	00301263          	bne	zero,gp,10294 <pass>

0000000000010294 <pass>:
   10294:	a019                	j	1029a <continue>

0000000000010296 <fail>:
   10296:	00000000          	.word	0x00000000

000000000001029a <continue>:
   1029a:	4081                	li	ra,0
   1029c:	4781                	li	a5,0
   1029e:	853e                	mv	a0,a5
   102a0:	6462                	ld	s0,24(sp)
   102a2:	6105                	add	sp,sp,32
   102a4:	8082                	ret

00000000000102a6 <__libc_init_array>:
   102a6:	1101                	add	sp,sp,-32
   102a8:	e822                	sd	s0,16(sp)
   102aa:	67c5                	lui	a5,0x11
   102ac:	6445                	lui	s0,0x11
   102ae:	e04a                	sd	s2,0(sp)
   102b0:	55c78793          	add	a5,a5,1372 # 1155c <__preinit_array_end>
   102b4:	55c40713          	add	a4,s0,1372 # 1155c <__preinit_array_end>
   102b8:	ec06                	sd	ra,24(sp)
   102ba:	e426                	sd	s1,8(sp)
   102bc:	40e78933          	sub	s2,a5,a4
   102c0:	00e78d63          	beq	a5,a4,102da <__libc_init_array+0x34>
   102c4:	40395913          	sra	s2,s2,0x3
   102c8:	55c40413          	add	s0,s0,1372
   102cc:	4481                	li	s1,0
   102ce:	601c                	ld	a5,0(s0)
   102d0:	0485                	add	s1,s1,1
   102d2:	0421                	add	s0,s0,8
   102d4:	9782                	jalr	a5
   102d6:	ff24ece3          	bltu	s1,s2,102ce <__libc_init_array+0x28>
   102da:	6445                	lui	s0,0x11
   102dc:	67c5                	lui	a5,0x11
   102de:	57078793          	add	a5,a5,1392 # 11570 <__do_global_dtors_aux_fini_array_entry>
   102e2:	56040713          	add	a4,s0,1376 # 11560 <__init_array_start>
   102e6:	40e78933          	sub	s2,a5,a4
   102ea:	40395913          	sra	s2,s2,0x3
   102ee:	00e78b63          	beq	a5,a4,10304 <__libc_init_array+0x5e>
   102f2:	56040413          	add	s0,s0,1376
   102f6:	4481                	li	s1,0
   102f8:	601c                	ld	a5,0(s0)
   102fa:	0485                	add	s1,s1,1
   102fc:	0421                	add	s0,s0,8
   102fe:	9782                	jalr	a5
   10300:	ff24ece3          	bltu	s1,s2,102f8 <__libc_init_array+0x52>
   10304:	60e2                	ld	ra,24(sp)
   10306:	6442                	ld	s0,16(sp)
   10308:	64a2                	ld	s1,8(sp)
   1030a:	6902                	ld	s2,0(sp)
   1030c:	6105                	add	sp,sp,32
   1030e:	8082                	ret

0000000000010310 <memset>:
   10310:	433d                	li	t1,15
   10312:	872a                	mv	a4,a0
   10314:	02c37163          	bgeu	t1,a2,10336 <memset+0x26>
   10318:	00f77793          	and	a5,a4,15
   1031c:	e3c1                	bnez	a5,1039c <memset+0x8c>
   1031e:	e1bd                	bnez	a1,10384 <memset+0x74>
   10320:	ff067693          	and	a3,a2,-16
   10324:	8a3d                	and	a2,a2,15
   10326:	96ba                	add	a3,a3,a4
   10328:	e30c                	sd	a1,0(a4)
   1032a:	e70c                	sd	a1,8(a4)
   1032c:	0741                	add	a4,a4,16
   1032e:	fed76de3          	bltu	a4,a3,10328 <memset+0x18>
   10332:	e211                	bnez	a2,10336 <memset+0x26>
   10334:	8082                	ret
   10336:	40c306b3          	sub	a3,t1,a2
   1033a:	068a                	sll	a3,a3,0x2
   1033c:	00000297          	auipc	t0,0x0
   10340:	9696                	add	a3,a3,t0
   10342:	00a68067          	jr	10(a3)
   10346:	00b70723          	sb	a1,14(a4)
   1034a:	00b706a3          	sb	a1,13(a4)
   1034e:	00b70623          	sb	a1,12(a4)
   10352:	00b705a3          	sb	a1,11(a4)
   10356:	00b70523          	sb	a1,10(a4)
   1035a:	00b704a3          	sb	a1,9(a4)
   1035e:	00b70423          	sb	a1,8(a4)
   10362:	00b703a3          	sb	a1,7(a4)
   10366:	00b70323          	sb	a1,6(a4)
   1036a:	00b702a3          	sb	a1,5(a4)
   1036e:	00b70223          	sb	a1,4(a4)
   10372:	00b701a3          	sb	a1,3(a4)
   10376:	00b70123          	sb	a1,2(a4)
   1037a:	00b700a3          	sb	a1,1(a4)
   1037e:	00b70023          	sb	a1,0(a4)
   10382:	8082                	ret
   10384:	0ff5f593          	zext.b	a1,a1
   10388:	00859693          	sll	a3,a1,0x8
   1038c:	8dd5                	or	a1,a1,a3
   1038e:	01059693          	sll	a3,a1,0x10
   10392:	8dd5                	or	a1,a1,a3
   10394:	02059693          	sll	a3,a1,0x20
   10398:	8dd5                	or	a1,a1,a3
   1039a:	b759                	j	10320 <memset+0x10>
   1039c:	00279693          	sll	a3,a5,0x2
   103a0:	00000297          	auipc	t0,0x0
   103a4:	9696                	add	a3,a3,t0
   103a6:	8286                	mv	t0,ra
   103a8:	fa2680e7          	jalr	-94(a3)
   103ac:	8096                	mv	ra,t0
   103ae:	17c1                	add	a5,a5,-16
   103b0:	8f1d                	sub	a4,a4,a5
   103b2:	963e                	add	a2,a2,a5
   103b4:	f8c371e3          	bgeu	t1,a2,10336 <memset+0x26>
   103b8:	b79d                	j	1031e <memset+0xe>

00000000000103ba <__call_exitprocs>:
   103ba:	715d                	add	sp,sp,-80
   103bc:	f052                	sd	s4,32(sp)
   103be:	f481ba03          	ld	s4,-184(gp) # 11cc0 <_global_impure_ptr>
   103c2:	f84a                	sd	s2,48(sp)
   103c4:	e486                	sd	ra,72(sp)
   103c6:	1f8a3903          	ld	s2,504(s4)
   103ca:	e0a2                	sd	s0,64(sp)
   103cc:	fc26                	sd	s1,56(sp)
   103ce:	f44e                	sd	s3,40(sp)
   103d0:	ec56                	sd	s5,24(sp)
   103d2:	e85a                	sd	s6,16(sp)
   103d4:	e45e                	sd	s7,8(sp)
   103d6:	e062                	sd	s8,0(sp)
   103d8:	02090863          	beqz	s2,10408 <__call_exitprocs+0x4e>
   103dc:	8b2a                	mv	s6,a0
   103de:	8bae                	mv	s7,a1
   103e0:	4a85                	li	s5,1
   103e2:	59fd                	li	s3,-1
   103e4:	00892483          	lw	s1,8(s2)
   103e8:	fff4841b          	addw	s0,s1,-1
   103ec:	00044e63          	bltz	s0,10408 <__call_exitprocs+0x4e>
   103f0:	048e                	sll	s1,s1,0x3
   103f2:	94ca                	add	s1,s1,s2
   103f4:	020b8663          	beqz	s7,10420 <__call_exitprocs+0x66>
   103f8:	2084b783          	ld	a5,520(s1)
   103fc:	03778263          	beq	a5,s7,10420 <__call_exitprocs+0x66>
   10400:	347d                	addw	s0,s0,-1
   10402:	14e1                	add	s1,s1,-8
   10404:	ff3418e3          	bne	s0,s3,103f4 <__call_exitprocs+0x3a>
   10408:	60a6                	ld	ra,72(sp)
   1040a:	6406                	ld	s0,64(sp)
   1040c:	74e2                	ld	s1,56(sp)
   1040e:	7942                	ld	s2,48(sp)
   10410:	79a2                	ld	s3,40(sp)
   10412:	7a02                	ld	s4,32(sp)
   10414:	6ae2                	ld	s5,24(sp)
   10416:	6b42                	ld	s6,16(sp)
   10418:	6ba2                	ld	s7,8(sp)
   1041a:	6c02                	ld	s8,0(sp)
   1041c:	6161                	add	sp,sp,80
   1041e:	8082                	ret
   10420:	00892783          	lw	a5,8(s2)
   10424:	6498                	ld	a4,8(s1)
   10426:	37fd                	addw	a5,a5,-1
   10428:	04878463          	beq	a5,s0,10470 <__call_exitprocs+0xb6>
   1042c:	0004b423          	sd	zero,8(s1)
   10430:	db61                	beqz	a4,10400 <__call_exitprocs+0x46>
   10432:	31092783          	lw	a5,784(s2)
   10436:	008a96bb          	sllw	a3,s5,s0
   1043a:	00892c03          	lw	s8,8(s2)
   1043e:	8ff5                	and	a5,a5,a3
   10440:	2781                	sext.w	a5,a5
   10442:	ef89                	bnez	a5,1045c <__call_exitprocs+0xa2>
   10444:	9702                	jalr	a4
   10446:	00892703          	lw	a4,8(s2)
   1044a:	1f8a3783          	ld	a5,504(s4)
   1044e:	01871463          	bne	a4,s8,10456 <__call_exitprocs+0x9c>
   10452:	fb2787e3          	beq	a5,s2,10400 <__call_exitprocs+0x46>
   10456:	dbcd                	beqz	a5,10408 <__call_exitprocs+0x4e>
   10458:	893e                	mv	s2,a5
   1045a:	b769                	j	103e4 <__call_exitprocs+0x2a>
   1045c:	31492783          	lw	a5,788(s2)
   10460:	1084b583          	ld	a1,264(s1)
   10464:	8ff5                	and	a5,a5,a3
   10466:	2781                	sext.w	a5,a5
   10468:	e799                	bnez	a5,10476 <__call_exitprocs+0xbc>
   1046a:	855a                	mv	a0,s6
   1046c:	9702                	jalr	a4
   1046e:	bfe1                	j	10446 <__call_exitprocs+0x8c>
   10470:	00892423          	sw	s0,8(s2)
   10474:	bf75                	j	10430 <__call_exitprocs+0x76>
   10476:	852e                	mv	a0,a1
   10478:	9702                	jalr	a4
   1047a:	b7f1                	j	10446 <__call_exitprocs+0x8c>

000000000001047c <__libc_fini_array>:
   1047c:	1101                	add	sp,sp,-32
   1047e:	e822                	sd	s0,16(sp)
   10480:	67c5                	lui	a5,0x11
   10482:	6445                	lui	s0,0x11
   10484:	57078793          	add	a5,a5,1392 # 11570 <__do_global_dtors_aux_fini_array_entry>
   10488:	57840413          	add	s0,s0,1400 # 11578 <impure_data>
   1048c:	8c1d                	sub	s0,s0,a5
   1048e:	e426                	sd	s1,8(sp)
   10490:	ec06                	sd	ra,24(sp)
   10492:	40345493          	sra	s1,s0,0x3
   10496:	c881                	beqz	s1,104a6 <__libc_fini_array+0x2a>
   10498:	1461                	add	s0,s0,-8
   1049a:	943e                	add	s0,s0,a5
   1049c:	601c                	ld	a5,0(s0)
   1049e:	14fd                	add	s1,s1,-1
   104a0:	1461                	add	s0,s0,-8
   104a2:	9782                	jalr	a5
   104a4:	fce5                	bnez	s1,1049c <__libc_fini_array+0x20>
   104a6:	60e2                	ld	ra,24(sp)
   104a8:	6442                	ld	s0,16(sp)
   104aa:	64a2                	ld	s1,8(sp)
   104ac:	6105                	add	sp,sp,32
   104ae:	8082                	ret

00000000000104b0 <atexit>:
   104b0:	85aa                	mv	a1,a0
   104b2:	4681                	li	a3,0
   104b4:	4601                	li	a2,0
   104b6:	4501                	li	a0,0
   104b8:	a009                	j	104ba <__register_exitproc>

00000000000104ba <__register_exitproc>:
   104ba:	f481b703          	ld	a4,-184(gp) # 11cc0 <_global_impure_ptr>
   104be:	1f873783          	ld	a5,504(a4)
   104c2:	c3b1                	beqz	a5,10506 <__register_exitproc+0x4c>
   104c4:	4798                	lw	a4,8(a5)
   104c6:	487d                	li	a6,31
   104c8:	06e84263          	blt	a6,a4,1052c <__register_exitproc+0x72>
   104cc:	c505                	beqz	a0,104f4 <__register_exitproc+0x3a>
   104ce:	00371813          	sll	a6,a4,0x3
   104d2:	983e                	add	a6,a6,a5
   104d4:	10c83823          	sd	a2,272(a6)
   104d8:	3107a883          	lw	a7,784(a5)
   104dc:	4605                	li	a2,1
   104de:	00e6163b          	sllw	a2,a2,a4
   104e2:	00c8e8b3          	or	a7,a7,a2
   104e6:	3117a823          	sw	a7,784(a5)
   104ea:	20d83823          	sd	a3,528(a6)
   104ee:	4689                	li	a3,2
   104f0:	02d50063          	beq	a0,a3,10510 <__register_exitproc+0x56>
   104f4:	00270693          	add	a3,a4,2
   104f8:	068e                	sll	a3,a3,0x3
   104fa:	2705                	addw	a4,a4,1
   104fc:	c798                	sw	a4,8(a5)
   104fe:	97b6                	add	a5,a5,a3
   10500:	e38c                	sd	a1,0(a5)
   10502:	4501                	li	a0,0
   10504:	8082                	ret
   10506:	20070793          	add	a5,a4,512
   1050a:	1ef73c23          	sd	a5,504(a4)
   1050e:	bf5d                	j	104c4 <__register_exitproc+0xa>
   10510:	3147a683          	lw	a3,788(a5)
   10514:	4501                	li	a0,0
   10516:	8ed1                	or	a3,a3,a2
   10518:	30d7aa23          	sw	a3,788(a5)
   1051c:	00270693          	add	a3,a4,2
   10520:	068e                	sll	a3,a3,0x3
   10522:	2705                	addw	a4,a4,1
   10524:	c798                	sw	a4,8(a5)
   10526:	97b6                	add	a5,a5,a3
   10528:	e38c                	sd	a1,0(a5)
   1052a:	8082                	ret
   1052c:	557d                	li	a0,-1
   1052e:	8082                	ret

0000000000010530 <_exit>:
   10530:	05d00893          	li	a7,93
   10534:	00000073          	ecall
   10538:	00054363          	bltz	a0,1053e <_exit+0xe>
   1053c:	a001                	j	1053c <_exit+0xc>
   1053e:	1141                	add	sp,sp,-16
   10540:	e022                	sd	s0,0(sp)
   10542:	842a                	mv	s0,a0
   10544:	e406                	sd	ra,8(sp)
   10546:	4080043b          	negw	s0,s0
   1054a:	008000ef          	jal	10552 <__errno>
   1054e:	c100                	sw	s0,0(a0)
   10550:	a001                	j	10550 <_exit+0x20>

0000000000010552 <__errno>:
   10552:	f581b503          	ld	a0,-168(gp) # 11cd0 <_impure_ptr>
   10556:	8082                	ret

sra.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	3fe000ef          	jal	104f0 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11df8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	564000ef          	jal	10666 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	5b250513          	add	a0,a0,1458 # 105b2 <__libc_fini_array>
   10112:	a9d1                	j	105e6 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d9a18193          	add	gp,gp,-614 # 11eb0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11e10 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11e48 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	31c000ef          	jal	10446 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	4b850513          	add	a0,a0,1208 # 105e6 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	47a50513          	add	a0,a0,1146 # 105b2 <__libc_fini_array>
   10140:	4a6000ef          	jal	105e6 <atexit>
   10144:	298000ef          	jal	103dc <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11e10 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	69050513          	add	a0,a0,1680 # 11690 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11e10 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11e18 <object.0>
   1018e:	69050513          	add	a0,a0,1680 # 11690 <__EH_FRAME_BEGIN__>
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
   101ae:	800000b7          	lui	ra,0x80000
   101b2:	4101                	li	sp,0
   101b4:	4020d733          	sra	a4,ra,sp
   101b8:	800003b7          	lui	t2,0x80000
   101bc:	20771863          	bne	a4,t2,103cc <fail>

00000000000101c0 <test_3>:
   101c0:	418d                	li	gp,3
   101c2:	800000b7          	lui	ra,0x80000
   101c6:	4105                	li	sp,1
   101c8:	4020d733          	sra	a4,ra,sp
   101cc:	c00003b7          	lui	t2,0xc0000
   101d0:	1e771e63          	bne	a4,t2,103cc <fail>

00000000000101d4 <test_4>:
   101d4:	4191                	li	gp,4
   101d6:	800000b7          	lui	ra,0x80000
   101da:	411d                	li	sp,7
   101dc:	4020d733          	sra	a4,ra,sp
   101e0:	ff0003b7          	lui	t2,0xff000
   101e4:	1e771463          	bne	a4,t2,103cc <fail>

00000000000101e8 <test_5>:
   101e8:	4195                	li	gp,5
   101ea:	800000b7          	lui	ra,0x80000
   101ee:	4139                	li	sp,14
   101f0:	4020d733          	sra	a4,ra,sp
   101f4:	7381                	lui	t2,0xfffe0
   101f6:	1c771b63          	bne	a4,t2,103cc <fail>

00000000000101fa <test_6>:
   101fa:	4199                	li	gp,6
   101fc:	800000b7          	lui	ra,0x80000
   10200:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee151>
   10202:	417d                	li	sp,31
   10204:	4020d733          	sra	a4,ra,sp
   10208:	53fd                	li	t2,-1
   1020a:	1c771163          	bne	a4,t2,103cc <fail>

000000000001020e <test_7>:
   1020e:	419d                	li	gp,7
   10210:	800000b7          	lui	ra,0x80000
   10214:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee14f>
   10216:	4101                	li	sp,0
   10218:	4020d733          	sra	a4,ra,sp
   1021c:	800003b7          	lui	t2,0x80000
   10220:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee14f>
   10222:	1a771563          	bne	a4,t2,103cc <fail>

0000000000010226 <test_8>:
   10226:	41a1                	li	gp,8
   10228:	800000b7          	lui	ra,0x80000
   1022c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee14f>
   1022e:	4105                	li	sp,1
   10230:	4020d733          	sra	a4,ra,sp
   10234:	400003b7          	lui	t2,0x40000
   10238:	33fd                	addw	t2,t2,-1 # 3fffffff <__global_pointer$+0x3ffee14f>
   1023a:	18771963          	bne	a4,t2,103cc <fail>

000000000001023e <test_9>:
   1023e:	41a5                	li	gp,9
   10240:	800000b7          	lui	ra,0x80000
   10244:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee14f>
   10246:	411d                	li	sp,7
   10248:	4020d733          	sra	a4,ra,sp
   1024c:	010003b7          	lui	t2,0x1000
   10250:	33fd                	addw	t2,t2,-1 # ffffff <__global_pointer$+0xfee14f>
   10252:	16771d63          	bne	a4,t2,103cc <fail>

0000000000010256 <test_10>:
   10256:	41a9                	li	gp,10
   10258:	800000b7          	lui	ra,0x80000
   1025c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee14f>
   1025e:	4139                	li	sp,14
   10260:	4020d733          	sra	a4,ra,sp
   10264:	000203b7          	lui	t2,0x20
   10268:	33fd                	addw	t2,t2,-1 # 1ffff <__global_pointer$+0xe14f>
   1026a:	16771163          	bne	a4,t2,103cc <fail>

000000000001026e <test_11>:
   1026e:	41ad                	li	gp,11
   10270:	800000b7          	lui	ra,0x80000
   10274:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee14f>
   10276:	417d                	li	sp,31
   10278:	4020d733          	sra	a4,ra,sp
   1027c:	4381                	li	t2,0
   1027e:	14771763          	bne	a4,t2,103cc <fail>

0000000000010282 <test_12>:
   10282:	41b1                	li	gp,12
   10284:	818180b7          	lui	ra,0x81818
   10288:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   1028c:	4101                	li	sp,0
   1028e:	4020d733          	sra	a4,ra,sp
   10292:	818183b7          	lui	t2,0x81818
   10296:	1813839b          	addw	t2,t2,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   1029a:	12771963          	bne	a4,t2,103cc <fail>

000000000001029e <test_13>:
   1029e:	41b5                	li	gp,13
   102a0:	818180b7          	lui	ra,0x81818
   102a4:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   102a8:	4105                	li	sp,1
   102aa:	4020d733          	sra	a4,ra,sp
   102ae:	c0c0c3b7          	lui	t2,0xc0c0c
   102b2:	0c03839b          	addw	t2,t2,192 # ffffffffc0c0c0c0 <__global_pointer$+0xffffffffc0bfa210>
   102b6:	10771b63          	bne	a4,t2,103cc <fail>

00000000000102ba <test_14>:
   102ba:	41b9                	li	gp,14
   102bc:	818180b7          	lui	ra,0x81818
   102c0:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   102c4:	411d                	li	sp,7
   102c6:	4020d733          	sra	a4,ra,sp
   102ca:	ff0303b7          	lui	t2,0xff030
   102ce:	3033839b          	addw	t2,t2,771 # ffffffffff030303 <__global_pointer$+0xffffffffff01e453>
   102d2:	0e771d63          	bne	a4,t2,103cc <fail>

00000000000102d6 <test_15>:
   102d6:	41bd                	li	gp,15
   102d8:	818180b7          	lui	ra,0x81818
   102dc:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   102e0:	4139                	li	sp,14
   102e2:	4020d733          	sra	a4,ra,sp
   102e6:	7381                	lui	t2,0xfffe0
   102e8:	6063839b          	addw	t2,t2,1542 # fffffffffffe0606 <__global_pointer$+0xfffffffffffce756>
   102ec:	0e771063          	bne	a4,t2,103cc <fail>

00000000000102f0 <test_16>:
   102f0:	41c1                	li	gp,16
   102f2:	818180b7          	lui	ra,0x81818
   102f6:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   102fa:	417d                	li	sp,31
   102fc:	4020d733          	sra	a4,ra,sp
   10300:	53fd                	li	t2,-1
   10302:	0c771563          	bne	a4,t2,103cc <fail>

0000000000010306 <test_17>:
   10306:	41c5                	li	gp,17
   10308:	818180b7          	lui	ra,0x81818
   1030c:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   10310:	fc000113          	li	sp,-64
   10314:	4020d733          	sra	a4,ra,sp
   10318:	818183b7          	lui	t2,0x81818
   1031c:	1813839b          	addw	t2,t2,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   10320:	0a771663          	bne	a4,t2,103cc <fail>

0000000000010324 <test_18>:
   10324:	41c9                	li	gp,18
   10326:	818180b7          	lui	ra,0x81818
   1032a:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   1032e:	fc100113          	li	sp,-63
   10332:	4020d733          	sra	a4,ra,sp
   10336:	c0c0c3b7          	lui	t2,0xc0c0c
   1033a:	0c03839b          	addw	t2,t2,192 # ffffffffc0c0c0c0 <__global_pointer$+0xffffffffc0bfa210>
   1033e:	08771763          	bne	a4,t2,103cc <fail>

0000000000010342 <test_19>:
   10342:	41cd                	li	gp,19
   10344:	818180b7          	lui	ra,0x81818
   10348:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   1034c:	fc700113          	li	sp,-57
   10350:	4020d733          	sra	a4,ra,sp
   10354:	ff0303b7          	lui	t2,0xff030
   10358:	3033839b          	addw	t2,t2,771 # ffffffffff030303 <__global_pointer$+0xffffffffff01e453>
   1035c:	06771863          	bne	a4,t2,103cc <fail>

0000000000010360 <test_20>:
   10360:	41d1                	li	gp,20
   10362:	818180b7          	lui	ra,0x81818
   10366:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   1036a:	fce00113          	li	sp,-50
   1036e:	4020d733          	sra	a4,ra,sp
   10372:	7381                	lui	t2,0xfffe0
   10374:	6063839b          	addw	t2,t2,1542 # fffffffffffe0606 <__global_pointer$+0xfffffffffffce756>
   10378:	04771a63          	bne	a4,t2,103cc <fail>

000000000001037c <test_21>:
   1037c:	41d5                	li	gp,21
   1037e:	818180b7          	lui	ra,0x81818
   10382:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818062d1>
   10386:	517d                	li	sp,-1
   10388:	4020d733          	sra	a4,ra,sp
   1038c:	53fd                	li	t2,-1
   1038e:	02771f63          	bne	a4,t2,103cc <fail>

0000000000010392 <test_22>:
   10392:	41d9                	li	gp,22
   10394:	800000b7          	lui	ra,0x80000
   10398:	411d                	li	sp,7
   1039a:	4020d0b3          	sra	ra,ra,sp
   1039e:	ff0003b7          	lui	t2,0xff000
   103a2:	02709563          	bne	ra,t2,103cc <fail>

00000000000103a6 <test_23>:
   103a6:	41dd                	li	gp,23
   103a8:	800000b7          	lui	ra,0x80000
   103ac:	4139                	li	sp,14
   103ae:	4020d133          	sra	sp,ra,sp
   103b2:	7381                	lui	t2,0xfffe0
   103b4:	00711c63          	bne	sp,t2,103cc <fail>

00000000000103b8 <test_24>:
   103b8:	41e1                	li	gp,24
   103ba:	409d                	li	ra,7
   103bc:	4010d0b3          	sra	ra,ra,ra
   103c0:	4381                	li	t2,0
   103c2:	00709563          	bne	ra,t2,103cc <fail>
   103c6:	00301263          	bne	zero,gp,103ca <pass>

00000000000103ca <pass>:
   103ca:	a019                	j	103d0 <continue>

00000000000103cc <fail>:
   103cc:	0000                	unimp
	...

00000000000103d0 <continue>:
   103d0:	4081                	li	ra,0
   103d2:	4781                	li	a5,0
   103d4:	853e                	mv	a0,a5
   103d6:	6462                	ld	s0,24(sp)
   103d8:	6105                	add	sp,sp,32
   103da:	8082                	ret

00000000000103dc <__libc_init_array>:
   103dc:	1101                	add	sp,sp,-32
   103de:	e822                	sd	s0,16(sp)
   103e0:	67c5                	lui	a5,0x11
   103e2:	6445                	lui	s0,0x11
   103e4:	e04a                	sd	s2,0(sp)
   103e6:	69478793          	add	a5,a5,1684 # 11694 <__preinit_array_end>
   103ea:	69440713          	add	a4,s0,1684 # 11694 <__preinit_array_end>
   103ee:	ec06                	sd	ra,24(sp)
   103f0:	e426                	sd	s1,8(sp)
   103f2:	40e78933          	sub	s2,a5,a4
   103f6:	00e78d63          	beq	a5,a4,10410 <__libc_init_array+0x34>
   103fa:	40395913          	sra	s2,s2,0x3
   103fe:	69440413          	add	s0,s0,1684
   10402:	4481                	li	s1,0
   10404:	601c                	ld	a5,0(s0)
   10406:	0485                	add	s1,s1,1
   10408:	0421                	add	s0,s0,8
   1040a:	9782                	jalr	a5
   1040c:	ff24ece3          	bltu	s1,s2,10404 <__libc_init_array+0x28>
   10410:	6445                	lui	s0,0x11
   10412:	67c5                	lui	a5,0x11
   10414:	6a878793          	add	a5,a5,1704 # 116a8 <__do_global_dtors_aux_fini_array_entry>
   10418:	69840713          	add	a4,s0,1688 # 11698 <__init_array_start>
   1041c:	40e78933          	sub	s2,a5,a4
   10420:	40395913          	sra	s2,s2,0x3
   10424:	00e78b63          	beq	a5,a4,1043a <__libc_init_array+0x5e>
   10428:	69840413          	add	s0,s0,1688
   1042c:	4481                	li	s1,0
   1042e:	601c                	ld	a5,0(s0)
   10430:	0485                	add	s1,s1,1
   10432:	0421                	add	s0,s0,8
   10434:	9782                	jalr	a5
   10436:	ff24ece3          	bltu	s1,s2,1042e <__libc_init_array+0x52>
   1043a:	60e2                	ld	ra,24(sp)
   1043c:	6442                	ld	s0,16(sp)
   1043e:	64a2                	ld	s1,8(sp)
   10440:	6902                	ld	s2,0(sp)
   10442:	6105                	add	sp,sp,32
   10444:	8082                	ret

0000000000010446 <memset>:
   10446:	433d                	li	t1,15
   10448:	872a                	mv	a4,a0
   1044a:	02c37163          	bgeu	t1,a2,1046c <memset+0x26>
   1044e:	00f77793          	and	a5,a4,15
   10452:	e3c1                	bnez	a5,104d2 <memset+0x8c>
   10454:	e1bd                	bnez	a1,104ba <memset+0x74>
   10456:	ff067693          	and	a3,a2,-16
   1045a:	8a3d                	and	a2,a2,15
   1045c:	96ba                	add	a3,a3,a4
   1045e:	e30c                	sd	a1,0(a4)
   10460:	e70c                	sd	a1,8(a4)
   10462:	0741                	add	a4,a4,16
   10464:	fed76de3          	bltu	a4,a3,1045e <memset+0x18>
   10468:	e211                	bnez	a2,1046c <memset+0x26>
   1046a:	8082                	ret
   1046c:	40c306b3          	sub	a3,t1,a2
   10470:	068a                	sll	a3,a3,0x2
   10472:	00000297          	auipc	t0,0x0
   10476:	9696                	add	a3,a3,t0
   10478:	00a68067          	jr	10(a3)
   1047c:	00b70723          	sb	a1,14(a4)
   10480:	00b706a3          	sb	a1,13(a4)
   10484:	00b70623          	sb	a1,12(a4)
   10488:	00b705a3          	sb	a1,11(a4)
   1048c:	00b70523          	sb	a1,10(a4)
   10490:	00b704a3          	sb	a1,9(a4)
   10494:	00b70423          	sb	a1,8(a4)
   10498:	00b703a3          	sb	a1,7(a4)
   1049c:	00b70323          	sb	a1,6(a4)
   104a0:	00b702a3          	sb	a1,5(a4)
   104a4:	00b70223          	sb	a1,4(a4)
   104a8:	00b701a3          	sb	a1,3(a4)
   104ac:	00b70123          	sb	a1,2(a4)
   104b0:	00b700a3          	sb	a1,1(a4)
   104b4:	00b70023          	sb	a1,0(a4)
   104b8:	8082                	ret
   104ba:	0ff5f593          	zext.b	a1,a1
   104be:	00859693          	sll	a3,a1,0x8
   104c2:	8dd5                	or	a1,a1,a3
   104c4:	01059693          	sll	a3,a1,0x10
   104c8:	8dd5                	or	a1,a1,a3
   104ca:	02059693          	sll	a3,a1,0x20
   104ce:	8dd5                	or	a1,a1,a3
   104d0:	b759                	j	10456 <memset+0x10>
   104d2:	00279693          	sll	a3,a5,0x2
   104d6:	00000297          	auipc	t0,0x0
   104da:	9696                	add	a3,a3,t0
   104dc:	8286                	mv	t0,ra
   104de:	fa2680e7          	jalr	-94(a3)
   104e2:	8096                	mv	ra,t0
   104e4:	17c1                	add	a5,a5,-16
   104e6:	8f1d                	sub	a4,a4,a5
   104e8:	963e                	add	a2,a2,a5
   104ea:	f8c371e3          	bgeu	t1,a2,1046c <memset+0x26>
   104ee:	b79d                	j	10454 <memset+0xe>

00000000000104f0 <__call_exitprocs>:
   104f0:	715d                	add	sp,sp,-80
   104f2:	f052                	sd	s4,32(sp)
   104f4:	f481ba03          	ld	s4,-184(gp) # 11df8 <_global_impure_ptr>
   104f8:	f84a                	sd	s2,48(sp)
   104fa:	e486                	sd	ra,72(sp)
   104fc:	1f8a3903          	ld	s2,504(s4)
   10500:	e0a2                	sd	s0,64(sp)
   10502:	fc26                	sd	s1,56(sp)
   10504:	f44e                	sd	s3,40(sp)
   10506:	ec56                	sd	s5,24(sp)
   10508:	e85a                	sd	s6,16(sp)
   1050a:	e45e                	sd	s7,8(sp)
   1050c:	e062                	sd	s8,0(sp)
   1050e:	02090863          	beqz	s2,1053e <__call_exitprocs+0x4e>
   10512:	8b2a                	mv	s6,a0
   10514:	8bae                	mv	s7,a1
   10516:	4a85                	li	s5,1
   10518:	59fd                	li	s3,-1
   1051a:	00892483          	lw	s1,8(s2)
   1051e:	fff4841b          	addw	s0,s1,-1
   10522:	00044e63          	bltz	s0,1053e <__call_exitprocs+0x4e>
   10526:	048e                	sll	s1,s1,0x3
   10528:	94ca                	add	s1,s1,s2
   1052a:	020b8663          	beqz	s7,10556 <__call_exitprocs+0x66>
   1052e:	2084b783          	ld	a5,520(s1)
   10532:	03778263          	beq	a5,s7,10556 <__call_exitprocs+0x66>
   10536:	347d                	addw	s0,s0,-1
   10538:	14e1                	add	s1,s1,-8
   1053a:	ff3418e3          	bne	s0,s3,1052a <__call_exitprocs+0x3a>
   1053e:	60a6                	ld	ra,72(sp)
   10540:	6406                	ld	s0,64(sp)
   10542:	74e2                	ld	s1,56(sp)
   10544:	7942                	ld	s2,48(sp)
   10546:	79a2                	ld	s3,40(sp)
   10548:	7a02                	ld	s4,32(sp)
   1054a:	6ae2                	ld	s5,24(sp)
   1054c:	6b42                	ld	s6,16(sp)
   1054e:	6ba2                	ld	s7,8(sp)
   10550:	6c02                	ld	s8,0(sp)
   10552:	6161                	add	sp,sp,80
   10554:	8082                	ret
   10556:	00892783          	lw	a5,8(s2)
   1055a:	6498                	ld	a4,8(s1)
   1055c:	37fd                	addw	a5,a5,-1
   1055e:	04878463          	beq	a5,s0,105a6 <__call_exitprocs+0xb6>
   10562:	0004b423          	sd	zero,8(s1)
   10566:	db61                	beqz	a4,10536 <__call_exitprocs+0x46>
   10568:	31092783          	lw	a5,784(s2)
   1056c:	008a96bb          	sllw	a3,s5,s0
   10570:	00892c03          	lw	s8,8(s2)
   10574:	8ff5                	and	a5,a5,a3
   10576:	2781                	sext.w	a5,a5
   10578:	ef89                	bnez	a5,10592 <__call_exitprocs+0xa2>
   1057a:	9702                	jalr	a4
   1057c:	00892703          	lw	a4,8(s2)
   10580:	1f8a3783          	ld	a5,504(s4)
   10584:	01871463          	bne	a4,s8,1058c <__call_exitprocs+0x9c>
   10588:	fb2787e3          	beq	a5,s2,10536 <__call_exitprocs+0x46>
   1058c:	dbcd                	beqz	a5,1053e <__call_exitprocs+0x4e>
   1058e:	893e                	mv	s2,a5
   10590:	b769                	j	1051a <__call_exitprocs+0x2a>
   10592:	31492783          	lw	a5,788(s2)
   10596:	1084b583          	ld	a1,264(s1)
   1059a:	8ff5                	and	a5,a5,a3
   1059c:	2781                	sext.w	a5,a5
   1059e:	e799                	bnez	a5,105ac <__call_exitprocs+0xbc>
   105a0:	855a                	mv	a0,s6
   105a2:	9702                	jalr	a4
   105a4:	bfe1                	j	1057c <__call_exitprocs+0x8c>
   105a6:	00892423          	sw	s0,8(s2)
   105aa:	bf75                	j	10566 <__call_exitprocs+0x76>
   105ac:	852e                	mv	a0,a1
   105ae:	9702                	jalr	a4
   105b0:	b7f1                	j	1057c <__call_exitprocs+0x8c>

00000000000105b2 <__libc_fini_array>:
   105b2:	1101                	add	sp,sp,-32
   105b4:	e822                	sd	s0,16(sp)
   105b6:	67c5                	lui	a5,0x11
   105b8:	6445                	lui	s0,0x11
   105ba:	6a878793          	add	a5,a5,1704 # 116a8 <__do_global_dtors_aux_fini_array_entry>
   105be:	6b040413          	add	s0,s0,1712 # 116b0 <impure_data>
   105c2:	8c1d                	sub	s0,s0,a5
   105c4:	e426                	sd	s1,8(sp)
   105c6:	ec06                	sd	ra,24(sp)
   105c8:	40345493          	sra	s1,s0,0x3
   105cc:	c881                	beqz	s1,105dc <__libc_fini_array+0x2a>
   105ce:	1461                	add	s0,s0,-8
   105d0:	943e                	add	s0,s0,a5
   105d2:	601c                	ld	a5,0(s0)
   105d4:	14fd                	add	s1,s1,-1
   105d6:	1461                	add	s0,s0,-8
   105d8:	9782                	jalr	a5
   105da:	fce5                	bnez	s1,105d2 <__libc_fini_array+0x20>
   105dc:	60e2                	ld	ra,24(sp)
   105de:	6442                	ld	s0,16(sp)
   105e0:	64a2                	ld	s1,8(sp)
   105e2:	6105                	add	sp,sp,32
   105e4:	8082                	ret

00000000000105e6 <atexit>:
   105e6:	85aa                	mv	a1,a0
   105e8:	4681                	li	a3,0
   105ea:	4601                	li	a2,0
   105ec:	4501                	li	a0,0
   105ee:	a009                	j	105f0 <__register_exitproc>

00000000000105f0 <__register_exitproc>:
   105f0:	f481b703          	ld	a4,-184(gp) # 11df8 <_global_impure_ptr>
   105f4:	1f873783          	ld	a5,504(a4)
   105f8:	c3b1                	beqz	a5,1063c <__register_exitproc+0x4c>
   105fa:	4798                	lw	a4,8(a5)
   105fc:	487d                	li	a6,31
   105fe:	06e84263          	blt	a6,a4,10662 <__register_exitproc+0x72>
   10602:	c505                	beqz	a0,1062a <__register_exitproc+0x3a>
   10604:	00371813          	sll	a6,a4,0x3
   10608:	983e                	add	a6,a6,a5
   1060a:	10c83823          	sd	a2,272(a6)
   1060e:	3107a883          	lw	a7,784(a5)
   10612:	4605                	li	a2,1
   10614:	00e6163b          	sllw	a2,a2,a4
   10618:	00c8e8b3          	or	a7,a7,a2
   1061c:	3117a823          	sw	a7,784(a5)
   10620:	20d83823          	sd	a3,528(a6)
   10624:	4689                	li	a3,2
   10626:	02d50063          	beq	a0,a3,10646 <__register_exitproc+0x56>
   1062a:	00270693          	add	a3,a4,2
   1062e:	068e                	sll	a3,a3,0x3
   10630:	2705                	addw	a4,a4,1
   10632:	c798                	sw	a4,8(a5)
   10634:	97b6                	add	a5,a5,a3
   10636:	e38c                	sd	a1,0(a5)
   10638:	4501                	li	a0,0
   1063a:	8082                	ret
   1063c:	20070793          	add	a5,a4,512
   10640:	1ef73c23          	sd	a5,504(a4)
   10644:	bf5d                	j	105fa <__register_exitproc+0xa>
   10646:	3147a683          	lw	a3,788(a5)
   1064a:	4501                	li	a0,0
   1064c:	8ed1                	or	a3,a3,a2
   1064e:	30d7aa23          	sw	a3,788(a5)
   10652:	00270693          	add	a3,a4,2
   10656:	068e                	sll	a3,a3,0x3
   10658:	2705                	addw	a4,a4,1
   1065a:	c798                	sw	a4,8(a5)
   1065c:	97b6                	add	a5,a5,a3
   1065e:	e38c                	sd	a1,0(a5)
   10660:	8082                	ret
   10662:	557d                	li	a0,-1
   10664:	8082                	ret

0000000000010666 <_exit>:
   10666:	05d00893          	li	a7,93
   1066a:	00000073          	ecall
   1066e:	00054363          	bltz	a0,10674 <_exit+0xe>
   10672:	a001                	j	10672 <_exit+0xc>
   10674:	1141                	add	sp,sp,-16
   10676:	e022                	sd	s0,0(sp)
   10678:	842a                	mv	s0,a0
   1067a:	e406                	sd	ra,8(sp)
   1067c:	4080043b          	negw	s0,s0
   10680:	008000ef          	jal	10688 <__errno>
   10684:	c100                	sw	s0,0(a0)
   10686:	a001                	j	10686 <_exit+0x20>

0000000000010688 <__errno>:
   10688:	f581b503          	ld	a0,-168(gp) # 11e08 <_impure_ptr>
   1068c:	8082                	ret

lbu.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2d2000ef          	jal	103c4 <__call_exitprocs>
   100f6:	fc81b503          	ld	a0,-56(gp) # 11d48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	438000ef          	jal	1053a <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	48650513          	add	a0,a0,1158 # 10486 <__libc_fini_array>
   10112:	a665                	j	104ba <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c6a18193          	add	gp,gp,-918 # 11d80 <__global_pointer$>
   1011e:	fe018513          	add	a0,gp,-32 # 11d60 <completed.1>
   10122:	01818613          	add	a2,gp,24 # 11d98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	1f0000ef          	jal	1031a <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	38c50513          	add	a0,a0,908 # 104ba <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	34e50513          	add	a0,a0,846 # 10486 <__libc_fini_array>
   10140:	37a000ef          	jal	104ba <atexit>
   10144:	16c000ef          	jal	102b0 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fe01c783          	lbu	a5,-32(gp) # 11d60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	56450513          	add	a0,a0,1380 # 11564 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fef18023          	sb	a5,-32(gp) # 11d60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fe818593          	add	a1,gp,-24 # 11d68 <object.0>
   1018e:	56450513          	add	a0,a0,1380 # 11564 <__EH_FRAME_BEGIN__>
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
   101ae:	0ff00793          	li	a5,255
   101b2:	00001097          	auipc	ra,0x1
   101b6:	3ce08093          	add	ra,ra,974 # 11580 <__DATA_BEGIN__>
   101ba:	0000c703          	lbu	a4,0(ra)
   101be:	0ff00393          	li	t2,255
   101c2:	0c771f63          	bne	a4,t2,102a0 <fail>

00000000000101c6 <test_3>:
   101c6:	418d                	li	gp,3
   101c8:	4781                	li	a5,0
   101ca:	00001097          	auipc	ra,0x1
   101ce:	3b608093          	add	ra,ra,950 # 11580 <__DATA_BEGIN__>
   101d2:	0010c703          	lbu	a4,1(ra)
   101d6:	4381                	li	t2,0
   101d8:	0c771463          	bne	a4,t2,102a0 <fail>

00000000000101dc <test_4>:
   101dc:	4191                	li	gp,4
   101de:	0f000793          	li	a5,240
   101e2:	00001097          	auipc	ra,0x1
   101e6:	39e08093          	add	ra,ra,926 # 11580 <__DATA_BEGIN__>
   101ea:	0020c703          	lbu	a4,2(ra)
   101ee:	0f000393          	li	t2,240
   101f2:	0a771763          	bne	a4,t2,102a0 <fail>

00000000000101f6 <test_5>:
   101f6:	4195                	li	gp,5
   101f8:	47bd                	li	a5,15
   101fa:	00001097          	auipc	ra,0x1
   101fe:	38608093          	add	ra,ra,902 # 11580 <__DATA_BEGIN__>
   10202:	0030c703          	lbu	a4,3(ra)
   10206:	43bd                	li	t2,15
   10208:	08771c63          	bne	a4,t2,102a0 <fail>

000000000001020c <test_6>:
   1020c:	4199                	li	gp,6
   1020e:	0ff00793          	li	a5,255
   10212:	00001097          	auipc	ra,0x1
   10216:	37108093          	add	ra,ra,881 # 11583 <tdat4>
   1021a:	ffd0c703          	lbu	a4,-3(ra)
   1021e:	0ff00393          	li	t2,255
   10222:	06771f63          	bne	a4,t2,102a0 <fail>

0000000000010226 <test_7>:
   10226:	419d                	li	gp,7
   10228:	4781                	li	a5,0
   1022a:	00001097          	auipc	ra,0x1
   1022e:	35908093          	add	ra,ra,857 # 11583 <tdat4>
   10232:	ffe0c703          	lbu	a4,-2(ra)
   10236:	4381                	li	t2,0
   10238:	06771463          	bne	a4,t2,102a0 <fail>

000000000001023c <test_8>:
   1023c:	41a1                	li	gp,8
   1023e:	0f000793          	li	a5,240
   10242:	00001097          	auipc	ra,0x1
   10246:	34108093          	add	ra,ra,833 # 11583 <tdat4>
   1024a:	fff0c703          	lbu	a4,-1(ra)
   1024e:	0f000393          	li	t2,240
   10252:	04771763          	bne	a4,t2,102a0 <fail>

0000000000010256 <test_9>:
   10256:	41a5                	li	gp,9
   10258:	47bd                	li	a5,15
   1025a:	00001097          	auipc	ra,0x1
   1025e:	32908093          	add	ra,ra,809 # 11583 <tdat4>
   10262:	0000c703          	lbu	a4,0(ra)
   10266:	43bd                	li	t2,15
   10268:	02771c63          	bne	a4,t2,102a0 <fail>

000000000001026c <test_10>:
   1026c:	41a9                	li	gp,10
   1026e:	00001097          	auipc	ra,0x1
   10272:	31208093          	add	ra,ra,786 # 11580 <__DATA_BEGIN__>
   10276:	1081                	add	ra,ra,-32
   10278:	0200c283          	lbu	t0,32(ra)
   1027c:	0ff00393          	li	t2,255
   10280:	02729063          	bne	t0,t2,102a0 <fail>

0000000000010284 <test_11>:
   10284:	41ad                	li	gp,11
   10286:	00001097          	auipc	ra,0x1
   1028a:	2fa08093          	add	ra,ra,762 # 11580 <__DATA_BEGIN__>
   1028e:	10e9                	add	ra,ra,-6
   10290:	0070c283          	lbu	t0,7(ra)
   10294:	4381                	li	t2,0
   10296:	00729563          	bne	t0,t2,102a0 <fail>
   1029a:	00301263          	bne	zero,gp,1029e <pass>

000000000001029e <pass>:
   1029e:	a019                	j	102a4 <continue>

00000000000102a0 <fail>:
   102a0:	0000                	unimp
	...

00000000000102a4 <continue>:
   102a4:	4081                	li	ra,0
   102a6:	4781                	li	a5,0
   102a8:	853e                	mv	a0,a5
   102aa:	6462                	ld	s0,24(sp)
   102ac:	6105                	add	sp,sp,32
   102ae:	8082                	ret

00000000000102b0 <__libc_init_array>:
   102b0:	1101                	add	sp,sp,-32
   102b2:	e822                	sd	s0,16(sp)
   102b4:	67c5                	lui	a5,0x11
   102b6:	6445                	lui	s0,0x11
   102b8:	e04a                	sd	s2,0(sp)
   102ba:	56878793          	add	a5,a5,1384 # 11568 <__init_array_start>
   102be:	56840713          	add	a4,s0,1384 # 11568 <__init_array_start>
   102c2:	ec06                	sd	ra,24(sp)
   102c4:	e426                	sd	s1,8(sp)
   102c6:	40e78933          	sub	s2,a5,a4
   102ca:	00e78d63          	beq	a5,a4,102e4 <__libc_init_array+0x34>
   102ce:	40395913          	sra	s2,s2,0x3
   102d2:	56840413          	add	s0,s0,1384
   102d6:	4481                	li	s1,0
   102d8:	601c                	ld	a5,0(s0)
   102da:	0485                	add	s1,s1,1
   102dc:	0421                	add	s0,s0,8
   102de:	9782                	jalr	a5
   102e0:	ff24ece3          	bltu	s1,s2,102d8 <__libc_init_array+0x28>
   102e4:	6445                	lui	s0,0x11
   102e6:	67c5                	lui	a5,0x11
   102e8:	57878793          	add	a5,a5,1400 # 11578 <__do_global_dtors_aux_fini_array_entry>
   102ec:	56840713          	add	a4,s0,1384 # 11568 <__init_array_start>
   102f0:	40e78933          	sub	s2,a5,a4
   102f4:	40395913          	sra	s2,s2,0x3
   102f8:	00e78b63          	beq	a5,a4,1030e <__libc_init_array+0x5e>
   102fc:	56840413          	add	s0,s0,1384
   10300:	4481                	li	s1,0
   10302:	601c                	ld	a5,0(s0)
   10304:	0485                	add	s1,s1,1
   10306:	0421                	add	s0,s0,8
   10308:	9782                	jalr	a5
   1030a:	ff24ece3          	bltu	s1,s2,10302 <__libc_init_array+0x52>
   1030e:	60e2                	ld	ra,24(sp)
   10310:	6442                	ld	s0,16(sp)
   10312:	64a2                	ld	s1,8(sp)
   10314:	6902                	ld	s2,0(sp)
   10316:	6105                	add	sp,sp,32
   10318:	8082                	ret

000000000001031a <memset>:
   1031a:	433d                	li	t1,15
   1031c:	872a                	mv	a4,a0
   1031e:	02c37163          	bgeu	t1,a2,10340 <memset+0x26>
   10322:	00f77793          	and	a5,a4,15
   10326:	e3c1                	bnez	a5,103a6 <memset+0x8c>
   10328:	e1bd                	bnez	a1,1038e <memset+0x74>
   1032a:	ff067693          	and	a3,a2,-16
   1032e:	8a3d                	and	a2,a2,15
   10330:	96ba                	add	a3,a3,a4
   10332:	e30c                	sd	a1,0(a4)
   10334:	e70c                	sd	a1,8(a4)
   10336:	0741                	add	a4,a4,16
   10338:	fed76de3          	bltu	a4,a3,10332 <memset+0x18>
   1033c:	e211                	bnez	a2,10340 <memset+0x26>
   1033e:	8082                	ret
   10340:	40c306b3          	sub	a3,t1,a2
   10344:	068a                	sll	a3,a3,0x2
   10346:	00000297          	auipc	t0,0x0
   1034a:	9696                	add	a3,a3,t0
   1034c:	00a68067          	jr	10(a3)
   10350:	00b70723          	sb	a1,14(a4)
   10354:	00b706a3          	sb	a1,13(a4)
   10358:	00b70623          	sb	a1,12(a4)
   1035c:	00b705a3          	sb	a1,11(a4)
   10360:	00b70523          	sb	a1,10(a4)
   10364:	00b704a3          	sb	a1,9(a4)
   10368:	00b70423          	sb	a1,8(a4)
   1036c:	00b703a3          	sb	a1,7(a4)
   10370:	00b70323          	sb	a1,6(a4)
   10374:	00b702a3          	sb	a1,5(a4)
   10378:	00b70223          	sb	a1,4(a4)
   1037c:	00b701a3          	sb	a1,3(a4)
   10380:	00b70123          	sb	a1,2(a4)
   10384:	00b700a3          	sb	a1,1(a4)
   10388:	00b70023          	sb	a1,0(a4)
   1038c:	8082                	ret
   1038e:	0ff5f593          	zext.b	a1,a1
   10392:	00859693          	sll	a3,a1,0x8
   10396:	8dd5                	or	a1,a1,a3
   10398:	01059693          	sll	a3,a1,0x10
   1039c:	8dd5                	or	a1,a1,a3
   1039e:	02059693          	sll	a3,a1,0x20
   103a2:	8dd5                	or	a1,a1,a3
   103a4:	b759                	j	1032a <memset+0x10>
   103a6:	00279693          	sll	a3,a5,0x2
   103aa:	00000297          	auipc	t0,0x0
   103ae:	9696                	add	a3,a3,t0
   103b0:	8286                	mv	t0,ra
   103b2:	fa2680e7          	jalr	-94(a3)
   103b6:	8096                	mv	ra,t0
   103b8:	17c1                	add	a5,a5,-16
   103ba:	8f1d                	sub	a4,a4,a5
   103bc:	963e                	add	a2,a2,a5
   103be:	f8c371e3          	bgeu	t1,a2,10340 <memset+0x26>
   103c2:	b79d                	j	10328 <memset+0xe>

00000000000103c4 <__call_exitprocs>:
   103c4:	715d                	add	sp,sp,-80
   103c6:	f052                	sd	s4,32(sp)
   103c8:	fc81ba03          	ld	s4,-56(gp) # 11d48 <_global_impure_ptr>
   103cc:	f84a                	sd	s2,48(sp)
   103ce:	e486                	sd	ra,72(sp)
   103d0:	1f8a3903          	ld	s2,504(s4)
   103d4:	e0a2                	sd	s0,64(sp)
   103d6:	fc26                	sd	s1,56(sp)
   103d8:	f44e                	sd	s3,40(sp)
   103da:	ec56                	sd	s5,24(sp)
   103dc:	e85a                	sd	s6,16(sp)
   103de:	e45e                	sd	s7,8(sp)
   103e0:	e062                	sd	s8,0(sp)
   103e2:	02090863          	beqz	s2,10412 <__call_exitprocs+0x4e>
   103e6:	8b2a                	mv	s6,a0
   103e8:	8bae                	mv	s7,a1
   103ea:	4a85                	li	s5,1
   103ec:	59fd                	li	s3,-1
   103ee:	00892483          	lw	s1,8(s2)
   103f2:	fff4841b          	addw	s0,s1,-1
   103f6:	00044e63          	bltz	s0,10412 <__call_exitprocs+0x4e>
   103fa:	048e                	sll	s1,s1,0x3
   103fc:	94ca                	add	s1,s1,s2
   103fe:	020b8663          	beqz	s7,1042a <__call_exitprocs+0x66>
   10402:	2084b783          	ld	a5,520(s1)
   10406:	03778263          	beq	a5,s7,1042a <__call_exitprocs+0x66>
   1040a:	347d                	addw	s0,s0,-1
   1040c:	14e1                	add	s1,s1,-8
   1040e:	ff3418e3          	bne	s0,s3,103fe <__call_exitprocs+0x3a>
   10412:	60a6                	ld	ra,72(sp)
   10414:	6406                	ld	s0,64(sp)
   10416:	74e2                	ld	s1,56(sp)
   10418:	7942                	ld	s2,48(sp)
   1041a:	79a2                	ld	s3,40(sp)
   1041c:	7a02                	ld	s4,32(sp)
   1041e:	6ae2                	ld	s5,24(sp)
   10420:	6b42                	ld	s6,16(sp)
   10422:	6ba2                	ld	s7,8(sp)
   10424:	6c02                	ld	s8,0(sp)
   10426:	6161                	add	sp,sp,80
   10428:	8082                	ret
   1042a:	00892783          	lw	a5,8(s2)
   1042e:	6498                	ld	a4,8(s1)
   10430:	37fd                	addw	a5,a5,-1
   10432:	04878463          	beq	a5,s0,1047a <__call_exitprocs+0xb6>
   10436:	0004b423          	sd	zero,8(s1)
   1043a:	db61                	beqz	a4,1040a <__call_exitprocs+0x46>
   1043c:	31092783          	lw	a5,784(s2)
   10440:	008a96bb          	sllw	a3,s5,s0
   10444:	00892c03          	lw	s8,8(s2)
   10448:	8ff5                	and	a5,a5,a3
   1044a:	2781                	sext.w	a5,a5
   1044c:	ef89                	bnez	a5,10466 <__call_exitprocs+0xa2>
   1044e:	9702                	jalr	a4
   10450:	00892703          	lw	a4,8(s2)
   10454:	1f8a3783          	ld	a5,504(s4)
   10458:	01871463          	bne	a4,s8,10460 <__call_exitprocs+0x9c>
   1045c:	fb2787e3          	beq	a5,s2,1040a <__call_exitprocs+0x46>
   10460:	dbcd                	beqz	a5,10412 <__call_exitprocs+0x4e>
   10462:	893e                	mv	s2,a5
   10464:	b769                	j	103ee <__call_exitprocs+0x2a>
   10466:	31492783          	lw	a5,788(s2)
   1046a:	1084b583          	ld	a1,264(s1)
   1046e:	8ff5                	and	a5,a5,a3
   10470:	2781                	sext.w	a5,a5
   10472:	e799                	bnez	a5,10480 <__call_exitprocs+0xbc>
   10474:	855a                	mv	a0,s6
   10476:	9702                	jalr	a4
   10478:	bfe1                	j	10450 <__call_exitprocs+0x8c>
   1047a:	00892423          	sw	s0,8(s2)
   1047e:	bf75                	j	1043a <__call_exitprocs+0x76>
   10480:	852e                	mv	a0,a1
   10482:	9702                	jalr	a4
   10484:	b7f1                	j	10450 <__call_exitprocs+0x8c>

0000000000010486 <__libc_fini_array>:
   10486:	1101                	add	sp,sp,-32
   10488:	e822                	sd	s0,16(sp)
   1048a:	67c5                	lui	a5,0x11
   1048c:	6445                	lui	s0,0x11
   1048e:	57878793          	add	a5,a5,1400 # 11578 <__do_global_dtors_aux_fini_array_entry>
   10492:	58040413          	add	s0,s0,1408 # 11580 <__DATA_BEGIN__>
   10496:	8c1d                	sub	s0,s0,a5
   10498:	e426                	sd	s1,8(sp)
   1049a:	ec06                	sd	ra,24(sp)
   1049c:	40345493          	sra	s1,s0,0x3
   104a0:	c881                	beqz	s1,104b0 <__libc_fini_array+0x2a>
   104a2:	1461                	add	s0,s0,-8
   104a4:	943e                	add	s0,s0,a5
   104a6:	601c                	ld	a5,0(s0)
   104a8:	14fd                	add	s1,s1,-1
   104aa:	1461                	add	s0,s0,-8
   104ac:	9782                	jalr	a5
   104ae:	fce5                	bnez	s1,104a6 <__libc_fini_array+0x20>
   104b0:	60e2                	ld	ra,24(sp)
   104b2:	6442                	ld	s0,16(sp)
   104b4:	64a2                	ld	s1,8(sp)
   104b6:	6105                	add	sp,sp,32
   104b8:	8082                	ret

00000000000104ba <atexit>:
   104ba:	85aa                	mv	a1,a0
   104bc:	4681                	li	a3,0
   104be:	4601                	li	a2,0
   104c0:	4501                	li	a0,0
   104c2:	a009                	j	104c4 <__register_exitproc>

00000000000104c4 <__register_exitproc>:
   104c4:	fc81b703          	ld	a4,-56(gp) # 11d48 <_global_impure_ptr>
   104c8:	1f873783          	ld	a5,504(a4)
   104cc:	c3b1                	beqz	a5,10510 <__register_exitproc+0x4c>
   104ce:	4798                	lw	a4,8(a5)
   104d0:	487d                	li	a6,31
   104d2:	06e84263          	blt	a6,a4,10536 <__register_exitproc+0x72>
   104d6:	c505                	beqz	a0,104fe <__register_exitproc+0x3a>
   104d8:	00371813          	sll	a6,a4,0x3
   104dc:	983e                	add	a6,a6,a5
   104de:	10c83823          	sd	a2,272(a6)
   104e2:	3107a883          	lw	a7,784(a5)
   104e6:	4605                	li	a2,1
   104e8:	00e6163b          	sllw	a2,a2,a4
   104ec:	00c8e8b3          	or	a7,a7,a2
   104f0:	3117a823          	sw	a7,784(a5)
   104f4:	20d83823          	sd	a3,528(a6)
   104f8:	4689                	li	a3,2
   104fa:	02d50063          	beq	a0,a3,1051a <__register_exitproc+0x56>
   104fe:	00270693          	add	a3,a4,2
   10502:	068e                	sll	a3,a3,0x3
   10504:	2705                	addw	a4,a4,1
   10506:	c798                	sw	a4,8(a5)
   10508:	97b6                	add	a5,a5,a3
   1050a:	e38c                	sd	a1,0(a5)
   1050c:	4501                	li	a0,0
   1050e:	8082                	ret
   10510:	20070793          	add	a5,a4,512
   10514:	1ef73c23          	sd	a5,504(a4)
   10518:	bf5d                	j	104ce <__register_exitproc+0xa>
   1051a:	3147a683          	lw	a3,788(a5)
   1051e:	4501                	li	a0,0
   10520:	8ed1                	or	a3,a3,a2
   10522:	30d7aa23          	sw	a3,788(a5)
   10526:	00270693          	add	a3,a4,2
   1052a:	068e                	sll	a3,a3,0x3
   1052c:	2705                	addw	a4,a4,1
   1052e:	c798                	sw	a4,8(a5)
   10530:	97b6                	add	a5,a5,a3
   10532:	e38c                	sd	a1,0(a5)
   10534:	8082                	ret
   10536:	557d                	li	a0,-1
   10538:	8082                	ret

000000000001053a <_exit>:
   1053a:	05d00893          	li	a7,93
   1053e:	00000073          	ecall
   10542:	00054363          	bltz	a0,10548 <_exit+0xe>
   10546:	a001                	j	10546 <_exit+0xc>
   10548:	1141                	add	sp,sp,-16
   1054a:	e022                	sd	s0,0(sp)
   1054c:	842a                	mv	s0,a0
   1054e:	e406                	sd	ra,8(sp)
   10550:	4080043b          	negw	s0,s0
   10554:	008000ef          	jal	1055c <__errno>
   10558:	c100                	sw	s0,0(a0)
   1055a:	a001                	j	1055a <_exit+0x20>

000000000001055c <__errno>:
   1055c:	fd81b503          	ld	a0,-40(gp) # 11d58 <_impure_ptr>
   10560:	8082                	ret

ori.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	262000ef          	jal	10354 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11c58 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	3c8000ef          	jal	104ca <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	41650513          	add	a0,a0,1046 # 10416 <__libc_fini_array>
   10112:	ae25                	j	1044a <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	bfa18193          	add	gp,gp,-1030 # 11d10 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11c70 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11ca8 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	180000ef          	jal	102aa <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	31c50513          	add	a0,a0,796 # 1044a <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	2de50513          	add	a0,a0,734 # 10416 <__libc_fini_array>
   10140:	30a000ef          	jal	1044a <atexit>
   10144:	0fc000ef          	jal	10240 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11c70 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	4f450513          	add	a0,a0,1268 # 114f4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11c70 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11c78 <object.0>
   1018e:	4f450513          	add	a0,a0,1268 # 114f4 <__EH_FRAME_BEGIN__>
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
   101ae:	ff0100b7          	lui	ra,0xff010
   101b2:	f000809b          	addw	ra,ra,-256 # ffffffffff00ff00 <__global_pointer$+0xfffffffffeffe1f0>
   101b6:	f0f0e713          	or	a4,ra,-241
   101ba:	f0f00393          	li	t2,-241
   101be:	06771963          	bne	a4,t2,10230 <fail>

00000000000101c2 <test_3>:
   101c2:	418d                	li	gp,3
   101c4:	0ff010b7          	lui	ra,0xff01
   101c8:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef2e0>
   101ca:	0f00e713          	or	a4,ra,240
   101ce:	0ff013b7          	lui	t2,0xff01
   101d2:	33c1                	addw	t2,t2,-16 # ff00ff0 <__global_pointer$+0xfeef2e0>
   101d4:	04771e63          	bne	a4,t2,10230 <fail>

00000000000101d8 <test_4>:
   101d8:	4191                	li	gp,4
   101da:	00ff00b7          	lui	ra,0xff0
   101de:	0ff0809b          	addw	ra,ra,255 # ff00ff <__global_pointer$+0xfde3ef>
   101e2:	70f0e713          	or	a4,ra,1807
   101e6:	00ff03b7          	lui	t2,0xff0
   101ea:	7ff3839b          	addw	t2,t2,2047 # ff07ff <__global_pointer$+0xfdeaef>
   101ee:	04771163          	bne	a4,t2,10230 <fail>

00000000000101f2 <test_5>:
   101f2:	4195                	li	gp,5
   101f4:	f00ff0b7          	lui	ra,0xf00ff
   101f8:	20bd                	addw	ra,ra,15 # fffffffff00ff00f <__global_pointer$+0xfffffffff00ed2ff>
   101fa:	0f00e713          	or	a4,ra,240
   101fe:	f00ff3b7          	lui	t2,0xf00ff
   10202:	0ff3839b          	addw	t2,t2,255 # fffffffff00ff0ff <__global_pointer$+0xfffffffff00ed3ef>
   10206:	02771563          	bne	a4,t2,10230 <fail>

000000000001020a <test_6>:
   1020a:	4199                	li	gp,6
   1020c:	60c1                	lui	ra,0x10
   1020e:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   10212:	00c2                	sll	ra,ra,0x10
   10214:	f0008093          	add	ra,ra,-256
   10218:	0f00e093          	or	ra,ra,240
   1021c:	63c1                	lui	t2,0x10
   1021e:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   10222:	03c2                	sll	t2,t2,0x10
   10224:	13c1                	add	t2,t2,-16
   10226:	00709563          	bne	ra,t2,10230 <fail>
   1022a:	00301263          	bne	zero,gp,1022e <pass>

000000000001022e <pass>:
   1022e:	a019                	j	10234 <continue>

0000000000010230 <fail>:
   10230:	0000                	unimp
	...

0000000000010234 <continue>:
   10234:	4081                	li	ra,0
   10236:	4781                	li	a5,0
   10238:	853e                	mv	a0,a5
   1023a:	6462                	ld	s0,24(sp)
   1023c:	6105                	add	sp,sp,32
   1023e:	8082                	ret

0000000000010240 <__libc_init_array>:
   10240:	1101                	add	sp,sp,-32
   10242:	e822                	sd	s0,16(sp)
   10244:	67c5                	lui	a5,0x11
   10246:	6445                	lui	s0,0x11
   10248:	e04a                	sd	s2,0(sp)
   1024a:	4f878793          	add	a5,a5,1272 # 114f8 <__init_array_start>
   1024e:	4f840713          	add	a4,s0,1272 # 114f8 <__init_array_start>
   10252:	ec06                	sd	ra,24(sp)
   10254:	e426                	sd	s1,8(sp)
   10256:	40e78933          	sub	s2,a5,a4
   1025a:	00e78d63          	beq	a5,a4,10274 <__libc_init_array+0x34>
   1025e:	40395913          	sra	s2,s2,0x3
   10262:	4f840413          	add	s0,s0,1272
   10266:	4481                	li	s1,0
   10268:	601c                	ld	a5,0(s0)
   1026a:	0485                	add	s1,s1,1
   1026c:	0421                	add	s0,s0,8
   1026e:	9782                	jalr	a5
   10270:	ff24ece3          	bltu	s1,s2,10268 <__libc_init_array+0x28>
   10274:	6445                	lui	s0,0x11
   10276:	67c5                	lui	a5,0x11
   10278:	50878793          	add	a5,a5,1288 # 11508 <__do_global_dtors_aux_fini_array_entry>
   1027c:	4f840713          	add	a4,s0,1272 # 114f8 <__init_array_start>
   10280:	40e78933          	sub	s2,a5,a4
   10284:	40395913          	sra	s2,s2,0x3
   10288:	00e78b63          	beq	a5,a4,1029e <__libc_init_array+0x5e>
   1028c:	4f840413          	add	s0,s0,1272
   10290:	4481                	li	s1,0
   10292:	601c                	ld	a5,0(s0)
   10294:	0485                	add	s1,s1,1
   10296:	0421                	add	s0,s0,8
   10298:	9782                	jalr	a5
   1029a:	ff24ece3          	bltu	s1,s2,10292 <__libc_init_array+0x52>
   1029e:	60e2                	ld	ra,24(sp)
   102a0:	6442                	ld	s0,16(sp)
   102a2:	64a2                	ld	s1,8(sp)
   102a4:	6902                	ld	s2,0(sp)
   102a6:	6105                	add	sp,sp,32
   102a8:	8082                	ret

00000000000102aa <memset>:
   102aa:	433d                	li	t1,15
   102ac:	872a                	mv	a4,a0
   102ae:	02c37163          	bgeu	t1,a2,102d0 <memset+0x26>
   102b2:	00f77793          	and	a5,a4,15
   102b6:	e3c1                	bnez	a5,10336 <memset+0x8c>
   102b8:	e1bd                	bnez	a1,1031e <memset+0x74>
   102ba:	ff067693          	and	a3,a2,-16
   102be:	8a3d                	and	a2,a2,15
   102c0:	96ba                	add	a3,a3,a4
   102c2:	e30c                	sd	a1,0(a4)
   102c4:	e70c                	sd	a1,8(a4)
   102c6:	0741                	add	a4,a4,16
   102c8:	fed76de3          	bltu	a4,a3,102c2 <memset+0x18>
   102cc:	e211                	bnez	a2,102d0 <memset+0x26>
   102ce:	8082                	ret
   102d0:	40c306b3          	sub	a3,t1,a2
   102d4:	068a                	sll	a3,a3,0x2
   102d6:	00000297          	auipc	t0,0x0
   102da:	9696                	add	a3,a3,t0
   102dc:	00a68067          	jr	10(a3)
   102e0:	00b70723          	sb	a1,14(a4)
   102e4:	00b706a3          	sb	a1,13(a4)
   102e8:	00b70623          	sb	a1,12(a4)
   102ec:	00b705a3          	sb	a1,11(a4)
   102f0:	00b70523          	sb	a1,10(a4)
   102f4:	00b704a3          	sb	a1,9(a4)
   102f8:	00b70423          	sb	a1,8(a4)
   102fc:	00b703a3          	sb	a1,7(a4)
   10300:	00b70323          	sb	a1,6(a4)
   10304:	00b702a3          	sb	a1,5(a4)
   10308:	00b70223          	sb	a1,4(a4)
   1030c:	00b701a3          	sb	a1,3(a4)
   10310:	00b70123          	sb	a1,2(a4)
   10314:	00b700a3          	sb	a1,1(a4)
   10318:	00b70023          	sb	a1,0(a4)
   1031c:	8082                	ret
   1031e:	0ff5f593          	zext.b	a1,a1
   10322:	00859693          	sll	a3,a1,0x8
   10326:	8dd5                	or	a1,a1,a3
   10328:	01059693          	sll	a3,a1,0x10
   1032c:	8dd5                	or	a1,a1,a3
   1032e:	02059693          	sll	a3,a1,0x20
   10332:	8dd5                	or	a1,a1,a3
   10334:	b759                	j	102ba <memset+0x10>
   10336:	00279693          	sll	a3,a5,0x2
   1033a:	00000297          	auipc	t0,0x0
   1033e:	9696                	add	a3,a3,t0
   10340:	8286                	mv	t0,ra
   10342:	fa2680e7          	jalr	-94(a3)
   10346:	8096                	mv	ra,t0
   10348:	17c1                	add	a5,a5,-16
   1034a:	8f1d                	sub	a4,a4,a5
   1034c:	963e                	add	a2,a2,a5
   1034e:	f8c371e3          	bgeu	t1,a2,102d0 <memset+0x26>
   10352:	b79d                	j	102b8 <memset+0xe>

0000000000010354 <__call_exitprocs>:
   10354:	715d                	add	sp,sp,-80
   10356:	f052                	sd	s4,32(sp)
   10358:	f481ba03          	ld	s4,-184(gp) # 11c58 <_global_impure_ptr>
   1035c:	f84a                	sd	s2,48(sp)
   1035e:	e486                	sd	ra,72(sp)
   10360:	1f8a3903          	ld	s2,504(s4)
   10364:	e0a2                	sd	s0,64(sp)
   10366:	fc26                	sd	s1,56(sp)
   10368:	f44e                	sd	s3,40(sp)
   1036a:	ec56                	sd	s5,24(sp)
   1036c:	e85a                	sd	s6,16(sp)
   1036e:	e45e                	sd	s7,8(sp)
   10370:	e062                	sd	s8,0(sp)
   10372:	02090863          	beqz	s2,103a2 <__call_exitprocs+0x4e>
   10376:	8b2a                	mv	s6,a0
   10378:	8bae                	mv	s7,a1
   1037a:	4a85                	li	s5,1
   1037c:	59fd                	li	s3,-1
   1037e:	00892483          	lw	s1,8(s2)
   10382:	fff4841b          	addw	s0,s1,-1
   10386:	00044e63          	bltz	s0,103a2 <__call_exitprocs+0x4e>
   1038a:	048e                	sll	s1,s1,0x3
   1038c:	94ca                	add	s1,s1,s2
   1038e:	020b8663          	beqz	s7,103ba <__call_exitprocs+0x66>
   10392:	2084b783          	ld	a5,520(s1)
   10396:	03778263          	beq	a5,s7,103ba <__call_exitprocs+0x66>
   1039a:	347d                	addw	s0,s0,-1
   1039c:	14e1                	add	s1,s1,-8
   1039e:	ff3418e3          	bne	s0,s3,1038e <__call_exitprocs+0x3a>
   103a2:	60a6                	ld	ra,72(sp)
   103a4:	6406                	ld	s0,64(sp)
   103a6:	74e2                	ld	s1,56(sp)
   103a8:	7942                	ld	s2,48(sp)
   103aa:	79a2                	ld	s3,40(sp)
   103ac:	7a02                	ld	s4,32(sp)
   103ae:	6ae2                	ld	s5,24(sp)
   103b0:	6b42                	ld	s6,16(sp)
   103b2:	6ba2                	ld	s7,8(sp)
   103b4:	6c02                	ld	s8,0(sp)
   103b6:	6161                	add	sp,sp,80
   103b8:	8082                	ret
   103ba:	00892783          	lw	a5,8(s2)
   103be:	6498                	ld	a4,8(s1)
   103c0:	37fd                	addw	a5,a5,-1
   103c2:	04878463          	beq	a5,s0,1040a <__call_exitprocs+0xb6>
   103c6:	0004b423          	sd	zero,8(s1)
   103ca:	db61                	beqz	a4,1039a <__call_exitprocs+0x46>
   103cc:	31092783          	lw	a5,784(s2)
   103d0:	008a96bb          	sllw	a3,s5,s0
   103d4:	00892c03          	lw	s8,8(s2)
   103d8:	8ff5                	and	a5,a5,a3
   103da:	2781                	sext.w	a5,a5
   103dc:	ef89                	bnez	a5,103f6 <__call_exitprocs+0xa2>
   103de:	9702                	jalr	a4
   103e0:	00892703          	lw	a4,8(s2)
   103e4:	1f8a3783          	ld	a5,504(s4)
   103e8:	01871463          	bne	a4,s8,103f0 <__call_exitprocs+0x9c>
   103ec:	fb2787e3          	beq	a5,s2,1039a <__call_exitprocs+0x46>
   103f0:	dbcd                	beqz	a5,103a2 <__call_exitprocs+0x4e>
   103f2:	893e                	mv	s2,a5
   103f4:	b769                	j	1037e <__call_exitprocs+0x2a>
   103f6:	31492783          	lw	a5,788(s2)
   103fa:	1084b583          	ld	a1,264(s1)
   103fe:	8ff5                	and	a5,a5,a3
   10400:	2781                	sext.w	a5,a5
   10402:	e799                	bnez	a5,10410 <__call_exitprocs+0xbc>
   10404:	855a                	mv	a0,s6
   10406:	9702                	jalr	a4
   10408:	bfe1                	j	103e0 <__call_exitprocs+0x8c>
   1040a:	00892423          	sw	s0,8(s2)
   1040e:	bf75                	j	103ca <__call_exitprocs+0x76>
   10410:	852e                	mv	a0,a1
   10412:	9702                	jalr	a4
   10414:	b7f1                	j	103e0 <__call_exitprocs+0x8c>

0000000000010416 <__libc_fini_array>:
   10416:	1101                	add	sp,sp,-32
   10418:	e822                	sd	s0,16(sp)
   1041a:	67c5                	lui	a5,0x11
   1041c:	6445                	lui	s0,0x11
   1041e:	50878793          	add	a5,a5,1288 # 11508 <__do_global_dtors_aux_fini_array_entry>
   10422:	51040413          	add	s0,s0,1296 # 11510 <impure_data>
   10426:	8c1d                	sub	s0,s0,a5
   10428:	e426                	sd	s1,8(sp)
   1042a:	ec06                	sd	ra,24(sp)
   1042c:	40345493          	sra	s1,s0,0x3
   10430:	c881                	beqz	s1,10440 <__libc_fini_array+0x2a>
   10432:	1461                	add	s0,s0,-8
   10434:	943e                	add	s0,s0,a5
   10436:	601c                	ld	a5,0(s0)
   10438:	14fd                	add	s1,s1,-1
   1043a:	1461                	add	s0,s0,-8
   1043c:	9782                	jalr	a5
   1043e:	fce5                	bnez	s1,10436 <__libc_fini_array+0x20>
   10440:	60e2                	ld	ra,24(sp)
   10442:	6442                	ld	s0,16(sp)
   10444:	64a2                	ld	s1,8(sp)
   10446:	6105                	add	sp,sp,32
   10448:	8082                	ret

000000000001044a <atexit>:
   1044a:	85aa                	mv	a1,a0
   1044c:	4681                	li	a3,0
   1044e:	4601                	li	a2,0
   10450:	4501                	li	a0,0
   10452:	a009                	j	10454 <__register_exitproc>

0000000000010454 <__register_exitproc>:
   10454:	f481b703          	ld	a4,-184(gp) # 11c58 <_global_impure_ptr>
   10458:	1f873783          	ld	a5,504(a4)
   1045c:	c3b1                	beqz	a5,104a0 <__register_exitproc+0x4c>
   1045e:	4798                	lw	a4,8(a5)
   10460:	487d                	li	a6,31
   10462:	06e84263          	blt	a6,a4,104c6 <__register_exitproc+0x72>
   10466:	c505                	beqz	a0,1048e <__register_exitproc+0x3a>
   10468:	00371813          	sll	a6,a4,0x3
   1046c:	983e                	add	a6,a6,a5
   1046e:	10c83823          	sd	a2,272(a6)
   10472:	3107a883          	lw	a7,784(a5)
   10476:	4605                	li	a2,1
   10478:	00e6163b          	sllw	a2,a2,a4
   1047c:	00c8e8b3          	or	a7,a7,a2
   10480:	3117a823          	sw	a7,784(a5)
   10484:	20d83823          	sd	a3,528(a6)
   10488:	4689                	li	a3,2
   1048a:	02d50063          	beq	a0,a3,104aa <__register_exitproc+0x56>
   1048e:	00270693          	add	a3,a4,2
   10492:	068e                	sll	a3,a3,0x3
   10494:	2705                	addw	a4,a4,1
   10496:	c798                	sw	a4,8(a5)
   10498:	97b6                	add	a5,a5,a3
   1049a:	e38c                	sd	a1,0(a5)
   1049c:	4501                	li	a0,0
   1049e:	8082                	ret
   104a0:	20070793          	add	a5,a4,512
   104a4:	1ef73c23          	sd	a5,504(a4)
   104a8:	bf5d                	j	1045e <__register_exitproc+0xa>
   104aa:	3147a683          	lw	a3,788(a5)
   104ae:	4501                	li	a0,0
   104b0:	8ed1                	or	a3,a3,a2
   104b2:	30d7aa23          	sw	a3,788(a5)
   104b6:	00270693          	add	a3,a4,2
   104ba:	068e                	sll	a3,a3,0x3
   104bc:	2705                	addw	a4,a4,1
   104be:	c798                	sw	a4,8(a5)
   104c0:	97b6                	add	a5,a5,a3
   104c2:	e38c                	sd	a1,0(a5)
   104c4:	8082                	ret
   104c6:	557d                	li	a0,-1
   104c8:	8082                	ret

00000000000104ca <_exit>:
   104ca:	05d00893          	li	a7,93
   104ce:	00000073          	ecall
   104d2:	00054363          	bltz	a0,104d8 <_exit+0xe>
   104d6:	a001                	j	104d6 <_exit+0xc>
   104d8:	1141                	add	sp,sp,-16
   104da:	e022                	sd	s0,0(sp)
   104dc:	842a                	mv	s0,a0
   104de:	e406                	sd	ra,8(sp)
   104e0:	4080043b          	negw	s0,s0
   104e4:	008000ef          	jal	104ec <__errno>
   104e8:	c100                	sw	s0,0(a0)
   104ea:	a001                	j	104ea <_exit+0x20>

00000000000104ec <__errno>:
   104ec:	f581b503          	ld	a0,-168(gp) # 11c68 <_impure_ptr>
   104f0:	8082                	ret

slliw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	37a000ef          	jal	1046c <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d70 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4e0000ef          	jal	105e2 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	52e50513          	add	a0,a0,1326 # 1052e <__libc_fini_array>
   10112:	a981                	j	10562 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d1218193          	add	gp,gp,-750 # 11e28 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d88 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11dc0 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	298000ef          	jal	103c2 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	43450513          	add	a0,a0,1076 # 10562 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3f650513          	add	a0,a0,1014 # 1052e <__libc_fini_array>
   10140:	422000ef          	jal	10562 <atexit>
   10144:	214000ef          	jal	10358 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d88 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	60c50513          	add	a0,a0,1548 # 1160c <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d88 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d90 <object.0>
   1018e:	60c50513          	add	a0,a0,1548 # 1160c <__EH_FRAME_BEGIN__>
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
   101ae:	4085                	li	ra,1
   101b0:	0000971b          	sllw	a4,ra,0x0
   101b4:	4385                	li	t2,1
   101b6:	18771963          	bne	a4,t2,10348 <fail>

00000000000101ba <test_3>:
   101ba:	418d                	li	gp,3
   101bc:	4085                	li	ra,1
   101be:	0010971b          	sllw	a4,ra,0x1
   101c2:	4389                	li	t2,2
   101c4:	18771263          	bne	a4,t2,10348 <fail>

00000000000101c8 <test_4>:
   101c8:	4191                	li	gp,4
   101ca:	4085                	li	ra,1
   101cc:	0070971b          	sllw	a4,ra,0x7
   101d0:	08000393          	li	t2,128
   101d4:	16771a63          	bne	a4,t2,10348 <fail>

00000000000101d8 <test_5>:
   101d8:	4195                	li	gp,5
   101da:	4085                	li	ra,1
   101dc:	00e0971b          	sllw	a4,ra,0xe
   101e0:	6391                	lui	t2,0x4
   101e2:	16771363          	bne	a4,t2,10348 <fail>

00000000000101e6 <test_6>:
   101e6:	4199                	li	gp,6
   101e8:	4085                	li	ra,1
   101ea:	01f0971b          	sllw	a4,ra,0x1f
   101ee:	800003b7          	lui	t2,0x80000
   101f2:	14771b63          	bne	a4,t2,10348 <fail>

00000000000101f6 <test_7>:
   101f6:	419d                	li	gp,7
   101f8:	50fd                	li	ra,-1
   101fa:	0000971b          	sllw	a4,ra,0x0
   101fe:	53fd                	li	t2,-1
   10200:	14771463          	bne	a4,t2,10348 <fail>

0000000000010204 <test_8>:
   10204:	41a1                	li	gp,8
   10206:	50fd                	li	ra,-1
   10208:	0010971b          	sllw	a4,ra,0x1
   1020c:	53f9                	li	t2,-2
   1020e:	12771d63          	bne	a4,t2,10348 <fail>

0000000000010212 <test_9>:
   10212:	41a5                	li	gp,9
   10214:	50fd                	li	ra,-1
   10216:	0070971b          	sllw	a4,ra,0x7
   1021a:	f8000393          	li	t2,-128
   1021e:	12771563          	bne	a4,t2,10348 <fail>

0000000000010222 <test_10>:
   10222:	41a9                	li	gp,10
   10224:	50fd                	li	ra,-1
   10226:	00e0971b          	sllw	a4,ra,0xe
   1022a:	73f1                	lui	t2,0xffffc
   1022c:	10771e63          	bne	a4,t2,10348 <fail>

0000000000010230 <test_11>:
   10230:	41ad                	li	gp,11
   10232:	50fd                	li	ra,-1
   10234:	01f0971b          	sllw	a4,ra,0x1f
   10238:	800003b7          	lui	t2,0x80000
   1023c:	10771663          	bne	a4,t2,10348 <fail>

0000000000010240 <test_12>:
   10240:	41b1                	li	gp,12
   10242:	212120b7          	lui	ra,0x21212
   10246:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002f9>
   1024a:	0000971b          	sllw	a4,ra,0x0
   1024e:	212123b7          	lui	t2,0x21212
   10252:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x212002f9>
   10256:	0e771963          	bne	a4,t2,10348 <fail>

000000000001025a <test_13>:
   1025a:	41b5                	li	gp,13
   1025c:	212120b7          	lui	ra,0x21212
   10260:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002f9>
   10264:	0010971b          	sllw	a4,ra,0x1
   10268:	424243b7          	lui	t2,0x42424
   1026c:	2423839b          	addw	t2,t2,578 # 42424242 <__global_pointer$+0x4241241a>
   10270:	0c771c63          	bne	a4,t2,10348 <fail>

0000000000010274 <test_14>:
   10274:	41b9                	li	gp,14
   10276:	212120b7          	lui	ra,0x21212
   1027a:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002f9>
   1027e:	0070971b          	sllw	a4,ra,0x7
   10282:	909093b7          	lui	t2,0x90909
   10286:	0803839b          	addw	t2,t2,128 # ffffffff90909080 <__global_pointer$+0xffffffff908f7258>
   1028a:	0a771f63          	bne	a4,t2,10348 <fail>

000000000001028e <test_15>:
   1028e:	41bd                	li	gp,15
   10290:	212120b7          	lui	ra,0x21212
   10294:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002f9>
   10298:	00e0971b          	sllw	a4,ra,0xe
   1029c:	484843b7          	lui	t2,0x48484
   102a0:	0a771463          	bne	a4,t2,10348 <fail>

00000000000102a4 <test_16>:
   102a4:	41c1                	li	gp,16
   102a6:	212120b7          	lui	ra,0x21212
   102aa:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x212002f9>
   102ae:	01f0971b          	sllw	a4,ra,0x1f
   102b2:	800003b7          	lui	t2,0x80000
   102b6:	08771963          	bne	a4,t2,10348 <fail>

00000000000102ba <test_44>:
   102ba:	02c00193          	li	gp,44
   102be:	fff120b7          	lui	ra,0xfff12
   102c2:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff0051d>
   102c6:	00b2                	sll	ra,ra,0xc
   102c8:	67808093          	add	ra,ra,1656
   102cc:	0000971b          	sllw	a4,ra,0x0
   102d0:	123453b7          	lui	t2,0x12345
   102d4:	6783839b          	addw	t2,t2,1656 # 12345678 <__global_pointer$+0x12333850>
   102d8:	06771863          	bne	a4,t2,10348 <fail>

00000000000102dc <test_45>:
   102dc:	02d00193          	li	gp,45
   102e0:	fff120b7          	lui	ra,0xfff12
   102e4:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff0051d>
   102e8:	00b2                	sll	ra,ra,0xc
   102ea:	67808093          	add	ra,ra,1656
   102ee:	0040971b          	sllw	a4,ra,0x4
   102f2:	234563b7          	lui	t2,0x23456
   102f6:	7803839b          	addw	t2,t2,1920 # 23456780 <__global_pointer$+0x23444958>
   102fa:	04771763          	bne	a4,t2,10348 <fail>

00000000000102fe <test_46>:
   102fe:	02e00193          	li	gp,46
   10302:	000920b7          	lui	ra,0x92
   10306:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x8051d>
   1030a:	00b2                	sll	ra,ra,0xc
   1030c:	67808093          	add	ra,ra,1656
   10310:	0000971b          	sllw	a4,ra,0x0
   10314:	923453b7          	lui	t2,0x92345
   10318:	6783839b          	addw	t2,t2,1656 # ffffffff92345678 <__global_pointer$+0xffffffff92333850>
   1031c:	02771663          	bne	a4,t2,10348 <fail>

0000000000010320 <test_47>:
   10320:	02f00193          	li	gp,47
   10324:	000990b7          	lui	ra,0x99
   10328:	3450809b          	addw	ra,ra,837 # 99345 <__global_pointer$+0x8751d>
   1032c:	00b2                	sll	ra,ra,0xc
   1032e:	67808093          	add	ra,ra,1656
   10332:	0040971b          	sllw	a4,ra,0x4
   10336:	934563b7          	lui	t2,0x93456
   1033a:	7803839b          	addw	t2,t2,1920 # ffffffff93456780 <__global_pointer$+0xffffffff93444958>
   1033e:	00771563          	bne	a4,t2,10348 <fail>
   10342:	00301263          	bne	zero,gp,10346 <pass>

0000000000010346 <pass>:
   10346:	a019                	j	1034c <continue>

0000000000010348 <fail>:
   10348:	0000                	unimp
	...

000000000001034c <continue>:
   1034c:	4081                	li	ra,0
   1034e:	4781                	li	a5,0
   10350:	853e                	mv	a0,a5
   10352:	6462                	ld	s0,24(sp)
   10354:	6105                	add	sp,sp,32
   10356:	8082                	ret

0000000000010358 <__libc_init_array>:
   10358:	1101                	add	sp,sp,-32
   1035a:	e822                	sd	s0,16(sp)
   1035c:	67c5                	lui	a5,0x11
   1035e:	6445                	lui	s0,0x11
   10360:	e04a                	sd	s2,0(sp)
   10362:	61078793          	add	a5,a5,1552 # 11610 <__init_array_start>
   10366:	61040713          	add	a4,s0,1552 # 11610 <__init_array_start>
   1036a:	ec06                	sd	ra,24(sp)
   1036c:	e426                	sd	s1,8(sp)
   1036e:	40e78933          	sub	s2,a5,a4
   10372:	00e78d63          	beq	a5,a4,1038c <__libc_init_array+0x34>
   10376:	40395913          	sra	s2,s2,0x3
   1037a:	61040413          	add	s0,s0,1552
   1037e:	4481                	li	s1,0
   10380:	601c                	ld	a5,0(s0)
   10382:	0485                	add	s1,s1,1
   10384:	0421                	add	s0,s0,8
   10386:	9782                	jalr	a5
   10388:	ff24ece3          	bltu	s1,s2,10380 <__libc_init_array+0x28>
   1038c:	6445                	lui	s0,0x11
   1038e:	67c5                	lui	a5,0x11
   10390:	62078793          	add	a5,a5,1568 # 11620 <__do_global_dtors_aux_fini_array_entry>
   10394:	61040713          	add	a4,s0,1552 # 11610 <__init_array_start>
   10398:	40e78933          	sub	s2,a5,a4
   1039c:	40395913          	sra	s2,s2,0x3
   103a0:	00e78b63          	beq	a5,a4,103b6 <__libc_init_array+0x5e>
   103a4:	61040413          	add	s0,s0,1552
   103a8:	4481                	li	s1,0
   103aa:	601c                	ld	a5,0(s0)
   103ac:	0485                	add	s1,s1,1
   103ae:	0421                	add	s0,s0,8
   103b0:	9782                	jalr	a5
   103b2:	ff24ece3          	bltu	s1,s2,103aa <__libc_init_array+0x52>
   103b6:	60e2                	ld	ra,24(sp)
   103b8:	6442                	ld	s0,16(sp)
   103ba:	64a2                	ld	s1,8(sp)
   103bc:	6902                	ld	s2,0(sp)
   103be:	6105                	add	sp,sp,32
   103c0:	8082                	ret

00000000000103c2 <memset>:
   103c2:	433d                	li	t1,15
   103c4:	872a                	mv	a4,a0
   103c6:	02c37163          	bgeu	t1,a2,103e8 <memset+0x26>
   103ca:	00f77793          	and	a5,a4,15
   103ce:	e3c1                	bnez	a5,1044e <memset+0x8c>
   103d0:	e1bd                	bnez	a1,10436 <memset+0x74>
   103d2:	ff067693          	and	a3,a2,-16
   103d6:	8a3d                	and	a2,a2,15
   103d8:	96ba                	add	a3,a3,a4
   103da:	e30c                	sd	a1,0(a4)
   103dc:	e70c                	sd	a1,8(a4)
   103de:	0741                	add	a4,a4,16
   103e0:	fed76de3          	bltu	a4,a3,103da <memset+0x18>
   103e4:	e211                	bnez	a2,103e8 <memset+0x26>
   103e6:	8082                	ret
   103e8:	40c306b3          	sub	a3,t1,a2
   103ec:	068a                	sll	a3,a3,0x2
   103ee:	00000297          	auipc	t0,0x0
   103f2:	9696                	add	a3,a3,t0
   103f4:	00a68067          	jr	10(a3)
   103f8:	00b70723          	sb	a1,14(a4)
   103fc:	00b706a3          	sb	a1,13(a4)
   10400:	00b70623          	sb	a1,12(a4)
   10404:	00b705a3          	sb	a1,11(a4)
   10408:	00b70523          	sb	a1,10(a4)
   1040c:	00b704a3          	sb	a1,9(a4)
   10410:	00b70423          	sb	a1,8(a4)
   10414:	00b703a3          	sb	a1,7(a4)
   10418:	00b70323          	sb	a1,6(a4)
   1041c:	00b702a3          	sb	a1,5(a4)
   10420:	00b70223          	sb	a1,4(a4)
   10424:	00b701a3          	sb	a1,3(a4)
   10428:	00b70123          	sb	a1,2(a4)
   1042c:	00b700a3          	sb	a1,1(a4)
   10430:	00b70023          	sb	a1,0(a4)
   10434:	8082                	ret
   10436:	0ff5f593          	zext.b	a1,a1
   1043a:	00859693          	sll	a3,a1,0x8
   1043e:	8dd5                	or	a1,a1,a3
   10440:	01059693          	sll	a3,a1,0x10
   10444:	8dd5                	or	a1,a1,a3
   10446:	02059693          	sll	a3,a1,0x20
   1044a:	8dd5                	or	a1,a1,a3
   1044c:	b759                	j	103d2 <memset+0x10>
   1044e:	00279693          	sll	a3,a5,0x2
   10452:	00000297          	auipc	t0,0x0
   10456:	9696                	add	a3,a3,t0
   10458:	8286                	mv	t0,ra
   1045a:	fa2680e7          	jalr	-94(a3)
   1045e:	8096                	mv	ra,t0
   10460:	17c1                	add	a5,a5,-16
   10462:	8f1d                	sub	a4,a4,a5
   10464:	963e                	add	a2,a2,a5
   10466:	f8c371e3          	bgeu	t1,a2,103e8 <memset+0x26>
   1046a:	b79d                	j	103d0 <memset+0xe>

000000000001046c <__call_exitprocs>:
   1046c:	715d                	add	sp,sp,-80
   1046e:	f052                	sd	s4,32(sp)
   10470:	f481ba03          	ld	s4,-184(gp) # 11d70 <_global_impure_ptr>
   10474:	f84a                	sd	s2,48(sp)
   10476:	e486                	sd	ra,72(sp)
   10478:	1f8a3903          	ld	s2,504(s4)
   1047c:	e0a2                	sd	s0,64(sp)
   1047e:	fc26                	sd	s1,56(sp)
   10480:	f44e                	sd	s3,40(sp)
   10482:	ec56                	sd	s5,24(sp)
   10484:	e85a                	sd	s6,16(sp)
   10486:	e45e                	sd	s7,8(sp)
   10488:	e062                	sd	s8,0(sp)
   1048a:	02090863          	beqz	s2,104ba <__call_exitprocs+0x4e>
   1048e:	8b2a                	mv	s6,a0
   10490:	8bae                	mv	s7,a1
   10492:	4a85                	li	s5,1
   10494:	59fd                	li	s3,-1
   10496:	00892483          	lw	s1,8(s2)
   1049a:	fff4841b          	addw	s0,s1,-1
   1049e:	00044e63          	bltz	s0,104ba <__call_exitprocs+0x4e>
   104a2:	048e                	sll	s1,s1,0x3
   104a4:	94ca                	add	s1,s1,s2
   104a6:	020b8663          	beqz	s7,104d2 <__call_exitprocs+0x66>
   104aa:	2084b783          	ld	a5,520(s1)
   104ae:	03778263          	beq	a5,s7,104d2 <__call_exitprocs+0x66>
   104b2:	347d                	addw	s0,s0,-1
   104b4:	14e1                	add	s1,s1,-8
   104b6:	ff3418e3          	bne	s0,s3,104a6 <__call_exitprocs+0x3a>
   104ba:	60a6                	ld	ra,72(sp)
   104bc:	6406                	ld	s0,64(sp)
   104be:	74e2                	ld	s1,56(sp)
   104c0:	7942                	ld	s2,48(sp)
   104c2:	79a2                	ld	s3,40(sp)
   104c4:	7a02                	ld	s4,32(sp)
   104c6:	6ae2                	ld	s5,24(sp)
   104c8:	6b42                	ld	s6,16(sp)
   104ca:	6ba2                	ld	s7,8(sp)
   104cc:	6c02                	ld	s8,0(sp)
   104ce:	6161                	add	sp,sp,80
   104d0:	8082                	ret
   104d2:	00892783          	lw	a5,8(s2)
   104d6:	6498                	ld	a4,8(s1)
   104d8:	37fd                	addw	a5,a5,-1
   104da:	04878463          	beq	a5,s0,10522 <__call_exitprocs+0xb6>
   104de:	0004b423          	sd	zero,8(s1)
   104e2:	db61                	beqz	a4,104b2 <__call_exitprocs+0x46>
   104e4:	31092783          	lw	a5,784(s2)
   104e8:	008a96bb          	sllw	a3,s5,s0
   104ec:	00892c03          	lw	s8,8(s2)
   104f0:	8ff5                	and	a5,a5,a3
   104f2:	2781                	sext.w	a5,a5
   104f4:	ef89                	bnez	a5,1050e <__call_exitprocs+0xa2>
   104f6:	9702                	jalr	a4
   104f8:	00892703          	lw	a4,8(s2)
   104fc:	1f8a3783          	ld	a5,504(s4)
   10500:	01871463          	bne	a4,s8,10508 <__call_exitprocs+0x9c>
   10504:	fb2787e3          	beq	a5,s2,104b2 <__call_exitprocs+0x46>
   10508:	dbcd                	beqz	a5,104ba <__call_exitprocs+0x4e>
   1050a:	893e                	mv	s2,a5
   1050c:	b769                	j	10496 <__call_exitprocs+0x2a>
   1050e:	31492783          	lw	a5,788(s2)
   10512:	1084b583          	ld	a1,264(s1)
   10516:	8ff5                	and	a5,a5,a3
   10518:	2781                	sext.w	a5,a5
   1051a:	e799                	bnez	a5,10528 <__call_exitprocs+0xbc>
   1051c:	855a                	mv	a0,s6
   1051e:	9702                	jalr	a4
   10520:	bfe1                	j	104f8 <__call_exitprocs+0x8c>
   10522:	00892423          	sw	s0,8(s2)
   10526:	bf75                	j	104e2 <__call_exitprocs+0x76>
   10528:	852e                	mv	a0,a1
   1052a:	9702                	jalr	a4
   1052c:	b7f1                	j	104f8 <__call_exitprocs+0x8c>

000000000001052e <__libc_fini_array>:
   1052e:	1101                	add	sp,sp,-32
   10530:	e822                	sd	s0,16(sp)
   10532:	67c5                	lui	a5,0x11
   10534:	6445                	lui	s0,0x11
   10536:	62078793          	add	a5,a5,1568 # 11620 <__do_global_dtors_aux_fini_array_entry>
   1053a:	62840413          	add	s0,s0,1576 # 11628 <impure_data>
   1053e:	8c1d                	sub	s0,s0,a5
   10540:	e426                	sd	s1,8(sp)
   10542:	ec06                	sd	ra,24(sp)
   10544:	40345493          	sra	s1,s0,0x3
   10548:	c881                	beqz	s1,10558 <__libc_fini_array+0x2a>
   1054a:	1461                	add	s0,s0,-8
   1054c:	943e                	add	s0,s0,a5
   1054e:	601c                	ld	a5,0(s0)
   10550:	14fd                	add	s1,s1,-1
   10552:	1461                	add	s0,s0,-8
   10554:	9782                	jalr	a5
   10556:	fce5                	bnez	s1,1054e <__libc_fini_array+0x20>
   10558:	60e2                	ld	ra,24(sp)
   1055a:	6442                	ld	s0,16(sp)
   1055c:	64a2                	ld	s1,8(sp)
   1055e:	6105                	add	sp,sp,32
   10560:	8082                	ret

0000000000010562 <atexit>:
   10562:	85aa                	mv	a1,a0
   10564:	4681                	li	a3,0
   10566:	4601                	li	a2,0
   10568:	4501                	li	a0,0
   1056a:	a009                	j	1056c <__register_exitproc>

000000000001056c <__register_exitproc>:
   1056c:	f481b703          	ld	a4,-184(gp) # 11d70 <_global_impure_ptr>
   10570:	1f873783          	ld	a5,504(a4)
   10574:	c3b1                	beqz	a5,105b8 <__register_exitproc+0x4c>
   10576:	4798                	lw	a4,8(a5)
   10578:	487d                	li	a6,31
   1057a:	06e84263          	blt	a6,a4,105de <__register_exitproc+0x72>
   1057e:	c505                	beqz	a0,105a6 <__register_exitproc+0x3a>
   10580:	00371813          	sll	a6,a4,0x3
   10584:	983e                	add	a6,a6,a5
   10586:	10c83823          	sd	a2,272(a6)
   1058a:	3107a883          	lw	a7,784(a5)
   1058e:	4605                	li	a2,1
   10590:	00e6163b          	sllw	a2,a2,a4
   10594:	00c8e8b3          	or	a7,a7,a2
   10598:	3117a823          	sw	a7,784(a5)
   1059c:	20d83823          	sd	a3,528(a6)
   105a0:	4689                	li	a3,2
   105a2:	02d50063          	beq	a0,a3,105c2 <__register_exitproc+0x56>
   105a6:	00270693          	add	a3,a4,2
   105aa:	068e                	sll	a3,a3,0x3
   105ac:	2705                	addw	a4,a4,1
   105ae:	c798                	sw	a4,8(a5)
   105b0:	97b6                	add	a5,a5,a3
   105b2:	e38c                	sd	a1,0(a5)
   105b4:	4501                	li	a0,0
   105b6:	8082                	ret
   105b8:	20070793          	add	a5,a4,512
   105bc:	1ef73c23          	sd	a5,504(a4)
   105c0:	bf5d                	j	10576 <__register_exitproc+0xa>
   105c2:	3147a683          	lw	a3,788(a5)
   105c6:	4501                	li	a0,0
   105c8:	8ed1                	or	a3,a3,a2
   105ca:	30d7aa23          	sw	a3,788(a5)
   105ce:	00270693          	add	a3,a4,2
   105d2:	068e                	sll	a3,a3,0x3
   105d4:	2705                	addw	a4,a4,1
   105d6:	c798                	sw	a4,8(a5)
   105d8:	97b6                	add	a5,a5,a3
   105da:	e38c                	sd	a1,0(a5)
   105dc:	8082                	ret
   105de:	557d                	li	a0,-1
   105e0:	8082                	ret

00000000000105e2 <_exit>:
   105e2:	05d00893          	li	a7,93
   105e6:	00000073          	ecall
   105ea:	00054363          	bltz	a0,105f0 <_exit+0xe>
   105ee:	a001                	j	105ee <_exit+0xc>
   105f0:	1141                	add	sp,sp,-16
   105f2:	e022                	sd	s0,0(sp)
   105f4:	842a                	mv	s0,a0
   105f6:	e406                	sd	ra,8(sp)
   105f8:	4080043b          	negw	s0,s0
   105fc:	008000ef          	jal	10604 <__errno>
   10600:	c100                	sw	s0,0(a0)
   10602:	a001                	j	10602 <_exit+0x20>

0000000000010604 <__errno>:
   10604:	f581b503          	ld	a0,-168(gp) # 11d80 <_impure_ptr>
   10608:	8082                	ret

sb.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	37c000ef          	jal	1046e <__call_exitprocs>
   100f6:	fd81b503          	ld	a0,-40(gp) # 11e08 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4e2000ef          	jal	105e4 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	53050513          	add	a0,a0,1328 # 10530 <__libc_fini_array>
   10112:	a989                	j	10564 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d1a18193          	add	gp,gp,-742 # 11e30 <__global_pointer$>
   1011e:	ff018513          	add	a0,gp,-16 # 11e20 <completed.1>
   10122:	02818613          	add	a2,gp,40 # 11e58 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	29a000ef          	jal	103c4 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	43650513          	add	a0,a0,1078 # 10564 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3f850513          	add	a0,a0,1016 # 10530 <__libc_fini_array>
   10140:	424000ef          	jal	10564 <atexit>
   10144:	216000ef          	jal	1035a <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	ff01c783          	lbu	a5,-16(gp) # 11e20 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	60c50513          	add	a0,a0,1548 # 1160c <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fef18823          	sb	a5,-16(gp) # 11e20 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	ff818593          	add	a1,gp,-8 # 11e28 <object.0>
   1018e:	60c50513          	add	a0,a0,1548 # 1160c <__EH_FRAME_BEGIN__>
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
   101ae:	00001097          	auipc	ra,0x1
   101b2:	48208093          	add	ra,ra,1154 # 11630 <__DATA_BEGIN__>
   101b6:	faa00113          	li	sp,-86
   101ba:	00000797          	auipc	a5,0x0
   101be:	01278793          	add	a5,a5,18 # 101cc <test_2+0x20>
   101c2:	00208023          	sb	sp,0(ra)
   101c6:	00008703          	lb	a4,0(ra)
   101ca:	a011                	j	101ce <test_2+0x22>
   101cc:	870a                	mv	a4,sp
   101ce:	faa00393          	li	t2,-86
   101d2:	16771c63          	bne	a4,t2,1034a <fail>

00000000000101d6 <test_3>:
   101d6:	418d                	li	gp,3
   101d8:	00001097          	auipc	ra,0x1
   101dc:	45808093          	add	ra,ra,1112 # 11630 <__DATA_BEGIN__>
   101e0:	4101                	li	sp,0
   101e2:	00000797          	auipc	a5,0x0
   101e6:	01278793          	add	a5,a5,18 # 101f4 <test_3+0x1e>
   101ea:	002080a3          	sb	sp,1(ra)
   101ee:	00108703          	lb	a4,1(ra)
   101f2:	a011                	j	101f6 <test_3+0x20>
   101f4:	870a                	mv	a4,sp
   101f6:	4381                	li	t2,0
   101f8:	14771963          	bne	a4,t2,1034a <fail>

00000000000101fc <test_4>:
   101fc:	4191                	li	gp,4
   101fe:	00001097          	auipc	ra,0x1
   10202:	43208093          	add	ra,ra,1074 # 11630 <__DATA_BEGIN__>
   10206:	fffff137          	lui	sp,0xfffff
   1020a:	fa01011b          	addw	sp,sp,-96 # ffffffffffffefa0 <__BSS_END__+0xfffffffffffed148>
   1020e:	00000797          	auipc	a5,0x0
   10212:	01278793          	add	a5,a5,18 # 10220 <test_4+0x24>
   10216:	00208123          	sb	sp,2(ra)
   1021a:	00209703          	lh	a4,2(ra)
   1021e:	a011                	j	10222 <test_4+0x26>
   10220:	870a                	mv	a4,sp
   10222:	73fd                	lui	t2,0xfffff
   10224:	fa03839b          	addw	t2,t2,-96 # ffffffffffffefa0 <__BSS_END__+0xfffffffffffed148>
   10228:	12771163          	bne	a4,t2,1034a <fail>

000000000001022c <test_5>:
   1022c:	4195                	li	gp,5
   1022e:	00001097          	auipc	ra,0x1
   10232:	40208093          	add	ra,ra,1026 # 11630 <__DATA_BEGIN__>
   10236:	4129                	li	sp,10
   10238:	00000797          	auipc	a5,0x0
   1023c:	01278793          	add	a5,a5,18 # 1024a <test_5+0x1e>
   10240:	002081a3          	sb	sp,3(ra)
   10244:	00308703          	lb	a4,3(ra)
   10248:	a011                	j	1024c <test_5+0x20>
   1024a:	870a                	mv	a4,sp
   1024c:	43a9                	li	t2,10
   1024e:	0e771e63          	bne	a4,t2,1034a <fail>

0000000000010252 <test_6>:
   10252:	4199                	li	gp,6
   10254:	00001097          	auipc	ra,0x1
   10258:	3e308093          	add	ra,ra,995 # 11637 <tdat8>
   1025c:	faa00113          	li	sp,-86
   10260:	00000797          	auipc	a5,0x0
   10264:	01278793          	add	a5,a5,18 # 10272 <test_6+0x20>
   10268:	fe208ea3          	sb	sp,-3(ra)
   1026c:	ffd08703          	lb	a4,-3(ra)
   10270:	a011                	j	10274 <test_6+0x22>
   10272:	870a                	mv	a4,sp
   10274:	faa00393          	li	t2,-86
   10278:	0c771963          	bne	a4,t2,1034a <fail>

000000000001027c <test_7>:
   1027c:	419d                	li	gp,7
   1027e:	00001097          	auipc	ra,0x1
   10282:	3b908093          	add	ra,ra,953 # 11637 <tdat8>
   10286:	4101                	li	sp,0
   10288:	00000797          	auipc	a5,0x0
   1028c:	01278793          	add	a5,a5,18 # 1029a <test_7+0x1e>
   10290:	fe208f23          	sb	sp,-2(ra)
   10294:	ffe08703          	lb	a4,-2(ra)
   10298:	a011                	j	1029c <test_7+0x20>
   1029a:	870a                	mv	a4,sp
   1029c:	4381                	li	t2,0
   1029e:	0a771663          	bne	a4,t2,1034a <fail>

00000000000102a2 <test_8>:
   102a2:	41a1                	li	gp,8
   102a4:	00001097          	auipc	ra,0x1
   102a8:	39308093          	add	ra,ra,915 # 11637 <tdat8>
   102ac:	fa000113          	li	sp,-96
   102b0:	00000797          	auipc	a5,0x0
   102b4:	01278793          	add	a5,a5,18 # 102c2 <test_8+0x20>
   102b8:	fe208fa3          	sb	sp,-1(ra)
   102bc:	fff08703          	lb	a4,-1(ra)
   102c0:	a011                	j	102c4 <test_8+0x22>
   102c2:	870a                	mv	a4,sp
   102c4:	fa000393          	li	t2,-96
   102c8:	08771163          	bne	a4,t2,1034a <fail>

00000000000102cc <test_9>:
   102cc:	41a5                	li	gp,9
   102ce:	00001097          	auipc	ra,0x1
   102d2:	36908093          	add	ra,ra,873 # 11637 <tdat8>
   102d6:	4129                	li	sp,10
   102d8:	00000797          	auipc	a5,0x0
   102dc:	01278793          	add	a5,a5,18 # 102ea <test_9+0x1e>
   102e0:	00208023          	sb	sp,0(ra)
   102e4:	00008703          	lb	a4,0(ra)
   102e8:	a011                	j	102ec <test_9+0x20>
   102ea:	870a                	mv	a4,sp
   102ec:	43a9                	li	t2,10
   102ee:	04771e63          	bne	a4,t2,1034a <fail>

00000000000102f2 <test_10>:
   102f2:	41a9                	li	gp,10
   102f4:	00001097          	auipc	ra,0x1
   102f8:	34408093          	add	ra,ra,836 # 11638 <tdat9>
   102fc:	12345137          	lui	sp,0x12345
   10300:	6781011b          	addw	sp,sp,1656 # 12345678 <__BSS_END__+0x12333820>
   10304:	fe008213          	add	tp,ra,-32
   10308:	02220023          	sb	sp,32(tp) # 20 <exit-0x100c8>
   1030c:	00008283          	lb	t0,0(ra)
   10310:	07800393          	li	t2,120
   10314:	02729b63          	bne	t0,t2,1034a <fail>

0000000000010318 <test_11>:
   10318:	41ad                	li	gp,11
   1031a:	00001097          	auipc	ra,0x1
   1031e:	31e08093          	add	ra,ra,798 # 11638 <tdat9>
   10322:	00003137          	lui	sp,0x3
   10326:	0981011b          	addw	sp,sp,152 # 3098 <exit-0xd050>
   1032a:	10e9                	add	ra,ra,-6
   1032c:	002083a3          	sb	sp,7(ra)
   10330:	00001217          	auipc	tp,0x1
   10334:	30920213          	add	tp,tp,777 # 11639 <tdat10>
   10338:	00020283          	lb	t0,0(tp) # 0 <exit-0x100e8>
   1033c:	f9800393          	li	t2,-104
   10340:	00729563          	bne	t0,t2,1034a <fail>
   10344:	00301263          	bne	zero,gp,10348 <pass>

0000000000010348 <pass>:
   10348:	a019                	j	1034e <continue>

000000000001034a <fail>:
   1034a:	0000                	unimp
	...

000000000001034e <continue>:
   1034e:	4081                	li	ra,0
   10350:	4781                	li	a5,0
   10352:	853e                	mv	a0,a5
   10354:	6462                	ld	s0,24(sp)
   10356:	6105                	add	sp,sp,32
   10358:	8082                	ret

000000000001035a <__libc_init_array>:
   1035a:	1101                	add	sp,sp,-32
   1035c:	e822                	sd	s0,16(sp)
   1035e:	67c5                	lui	a5,0x11
   10360:	6445                	lui	s0,0x11
   10362:	e04a                	sd	s2,0(sp)
   10364:	61078793          	add	a5,a5,1552 # 11610 <__init_array_start>
   10368:	61040713          	add	a4,s0,1552 # 11610 <__init_array_start>
   1036c:	ec06                	sd	ra,24(sp)
   1036e:	e426                	sd	s1,8(sp)
   10370:	40e78933          	sub	s2,a5,a4
   10374:	00e78d63          	beq	a5,a4,1038e <__libc_init_array+0x34>
   10378:	40395913          	sra	s2,s2,0x3
   1037c:	61040413          	add	s0,s0,1552
   10380:	4481                	li	s1,0
   10382:	601c                	ld	a5,0(s0)
   10384:	0485                	add	s1,s1,1
   10386:	0421                	add	s0,s0,8
   10388:	9782                	jalr	a5
   1038a:	ff24ece3          	bltu	s1,s2,10382 <__libc_init_array+0x28>
   1038e:	6445                	lui	s0,0x11
   10390:	67c5                	lui	a5,0x11
   10392:	62078793          	add	a5,a5,1568 # 11620 <__do_global_dtors_aux_fini_array_entry>
   10396:	61040713          	add	a4,s0,1552 # 11610 <__init_array_start>
   1039a:	40e78933          	sub	s2,a5,a4
   1039e:	40395913          	sra	s2,s2,0x3
   103a2:	00e78b63          	beq	a5,a4,103b8 <__libc_init_array+0x5e>
   103a6:	61040413          	add	s0,s0,1552
   103aa:	4481                	li	s1,0
   103ac:	601c                	ld	a5,0(s0)
   103ae:	0485                	add	s1,s1,1
   103b0:	0421                	add	s0,s0,8
   103b2:	9782                	jalr	a5
   103b4:	ff24ece3          	bltu	s1,s2,103ac <__libc_init_array+0x52>
   103b8:	60e2                	ld	ra,24(sp)
   103ba:	6442                	ld	s0,16(sp)
   103bc:	64a2                	ld	s1,8(sp)
   103be:	6902                	ld	s2,0(sp)
   103c0:	6105                	add	sp,sp,32
   103c2:	8082                	ret

00000000000103c4 <memset>:
   103c4:	433d                	li	t1,15
   103c6:	872a                	mv	a4,a0
   103c8:	02c37163          	bgeu	t1,a2,103ea <memset+0x26>
   103cc:	00f77793          	and	a5,a4,15
   103d0:	e3c1                	bnez	a5,10450 <memset+0x8c>
   103d2:	e1bd                	bnez	a1,10438 <memset+0x74>
   103d4:	ff067693          	and	a3,a2,-16
   103d8:	8a3d                	and	a2,a2,15
   103da:	96ba                	add	a3,a3,a4
   103dc:	e30c                	sd	a1,0(a4)
   103de:	e70c                	sd	a1,8(a4)
   103e0:	0741                	add	a4,a4,16
   103e2:	fed76de3          	bltu	a4,a3,103dc <memset+0x18>
   103e6:	e211                	bnez	a2,103ea <memset+0x26>
   103e8:	8082                	ret
   103ea:	40c306b3          	sub	a3,t1,a2
   103ee:	068a                	sll	a3,a3,0x2
   103f0:	00000297          	auipc	t0,0x0
   103f4:	9696                	add	a3,a3,t0
   103f6:	00a68067          	jr	10(a3)
   103fa:	00b70723          	sb	a1,14(a4)
   103fe:	00b706a3          	sb	a1,13(a4)
   10402:	00b70623          	sb	a1,12(a4)
   10406:	00b705a3          	sb	a1,11(a4)
   1040a:	00b70523          	sb	a1,10(a4)
   1040e:	00b704a3          	sb	a1,9(a4)
   10412:	00b70423          	sb	a1,8(a4)
   10416:	00b703a3          	sb	a1,7(a4)
   1041a:	00b70323          	sb	a1,6(a4)
   1041e:	00b702a3          	sb	a1,5(a4)
   10422:	00b70223          	sb	a1,4(a4)
   10426:	00b701a3          	sb	a1,3(a4)
   1042a:	00b70123          	sb	a1,2(a4)
   1042e:	00b700a3          	sb	a1,1(a4)
   10432:	00b70023          	sb	a1,0(a4)
   10436:	8082                	ret
   10438:	0ff5f593          	zext.b	a1,a1
   1043c:	00859693          	sll	a3,a1,0x8
   10440:	8dd5                	or	a1,a1,a3
   10442:	01059693          	sll	a3,a1,0x10
   10446:	8dd5                	or	a1,a1,a3
   10448:	02059693          	sll	a3,a1,0x20
   1044c:	8dd5                	or	a1,a1,a3
   1044e:	b759                	j	103d4 <memset+0x10>
   10450:	00279693          	sll	a3,a5,0x2
   10454:	00000297          	auipc	t0,0x0
   10458:	9696                	add	a3,a3,t0
   1045a:	8286                	mv	t0,ra
   1045c:	fa2680e7          	jalr	-94(a3)
   10460:	8096                	mv	ra,t0
   10462:	17c1                	add	a5,a5,-16
   10464:	8f1d                	sub	a4,a4,a5
   10466:	963e                	add	a2,a2,a5
   10468:	f8c371e3          	bgeu	t1,a2,103ea <memset+0x26>
   1046c:	b79d                	j	103d2 <memset+0xe>

000000000001046e <__call_exitprocs>:
   1046e:	715d                	add	sp,sp,-80
   10470:	f052                	sd	s4,32(sp)
   10472:	fd81ba03          	ld	s4,-40(gp) # 11e08 <_global_impure_ptr>
   10476:	f84a                	sd	s2,48(sp)
   10478:	e486                	sd	ra,72(sp)
   1047a:	1f8a3903          	ld	s2,504(s4)
   1047e:	e0a2                	sd	s0,64(sp)
   10480:	fc26                	sd	s1,56(sp)
   10482:	f44e                	sd	s3,40(sp)
   10484:	ec56                	sd	s5,24(sp)
   10486:	e85a                	sd	s6,16(sp)
   10488:	e45e                	sd	s7,8(sp)
   1048a:	e062                	sd	s8,0(sp)
   1048c:	02090863          	beqz	s2,104bc <__call_exitprocs+0x4e>
   10490:	8b2a                	mv	s6,a0
   10492:	8bae                	mv	s7,a1
   10494:	4a85                	li	s5,1
   10496:	59fd                	li	s3,-1
   10498:	00892483          	lw	s1,8(s2)
   1049c:	fff4841b          	addw	s0,s1,-1
   104a0:	00044e63          	bltz	s0,104bc <__call_exitprocs+0x4e>
   104a4:	048e                	sll	s1,s1,0x3
   104a6:	94ca                	add	s1,s1,s2
   104a8:	020b8663          	beqz	s7,104d4 <__call_exitprocs+0x66>
   104ac:	2084b783          	ld	a5,520(s1)
   104b0:	03778263          	beq	a5,s7,104d4 <__call_exitprocs+0x66>
   104b4:	347d                	addw	s0,s0,-1
   104b6:	14e1                	add	s1,s1,-8
   104b8:	ff3418e3          	bne	s0,s3,104a8 <__call_exitprocs+0x3a>
   104bc:	60a6                	ld	ra,72(sp)
   104be:	6406                	ld	s0,64(sp)
   104c0:	74e2                	ld	s1,56(sp)
   104c2:	7942                	ld	s2,48(sp)
   104c4:	79a2                	ld	s3,40(sp)
   104c6:	7a02                	ld	s4,32(sp)
   104c8:	6ae2                	ld	s5,24(sp)
   104ca:	6b42                	ld	s6,16(sp)
   104cc:	6ba2                	ld	s7,8(sp)
   104ce:	6c02                	ld	s8,0(sp)
   104d0:	6161                	add	sp,sp,80
   104d2:	8082                	ret
   104d4:	00892783          	lw	a5,8(s2)
   104d8:	6498                	ld	a4,8(s1)
   104da:	37fd                	addw	a5,a5,-1
   104dc:	04878463          	beq	a5,s0,10524 <__call_exitprocs+0xb6>
   104e0:	0004b423          	sd	zero,8(s1)
   104e4:	db61                	beqz	a4,104b4 <__call_exitprocs+0x46>
   104e6:	31092783          	lw	a5,784(s2)
   104ea:	008a96bb          	sllw	a3,s5,s0
   104ee:	00892c03          	lw	s8,8(s2)
   104f2:	8ff5                	and	a5,a5,a3
   104f4:	2781                	sext.w	a5,a5
   104f6:	ef89                	bnez	a5,10510 <__call_exitprocs+0xa2>
   104f8:	9702                	jalr	a4
   104fa:	00892703          	lw	a4,8(s2)
   104fe:	1f8a3783          	ld	a5,504(s4)
   10502:	01871463          	bne	a4,s8,1050a <__call_exitprocs+0x9c>
   10506:	fb2787e3          	beq	a5,s2,104b4 <__call_exitprocs+0x46>
   1050a:	dbcd                	beqz	a5,104bc <__call_exitprocs+0x4e>
   1050c:	893e                	mv	s2,a5
   1050e:	b769                	j	10498 <__call_exitprocs+0x2a>
   10510:	31492783          	lw	a5,788(s2)
   10514:	1084b583          	ld	a1,264(s1)
   10518:	8ff5                	and	a5,a5,a3
   1051a:	2781                	sext.w	a5,a5
   1051c:	e799                	bnez	a5,1052a <__call_exitprocs+0xbc>
   1051e:	855a                	mv	a0,s6
   10520:	9702                	jalr	a4
   10522:	bfe1                	j	104fa <__call_exitprocs+0x8c>
   10524:	00892423          	sw	s0,8(s2)
   10528:	bf75                	j	104e4 <__call_exitprocs+0x76>
   1052a:	852e                	mv	a0,a1
   1052c:	9702                	jalr	a4
   1052e:	b7f1                	j	104fa <__call_exitprocs+0x8c>

0000000000010530 <__libc_fini_array>:
   10530:	1101                	add	sp,sp,-32
   10532:	e822                	sd	s0,16(sp)
   10534:	67c5                	lui	a5,0x11
   10536:	6445                	lui	s0,0x11
   10538:	62078793          	add	a5,a5,1568 # 11620 <__do_global_dtors_aux_fini_array_entry>
   1053c:	62840413          	add	s0,s0,1576 # 11628 <__fini_array_end>
   10540:	8c1d                	sub	s0,s0,a5
   10542:	e426                	sd	s1,8(sp)
   10544:	ec06                	sd	ra,24(sp)
   10546:	40345493          	sra	s1,s0,0x3
   1054a:	c881                	beqz	s1,1055a <__libc_fini_array+0x2a>
   1054c:	1461                	add	s0,s0,-8
   1054e:	943e                	add	s0,s0,a5
   10550:	601c                	ld	a5,0(s0)
   10552:	14fd                	add	s1,s1,-1
   10554:	1461                	add	s0,s0,-8
   10556:	9782                	jalr	a5
   10558:	fce5                	bnez	s1,10550 <__libc_fini_array+0x20>
   1055a:	60e2                	ld	ra,24(sp)
   1055c:	6442                	ld	s0,16(sp)
   1055e:	64a2                	ld	s1,8(sp)
   10560:	6105                	add	sp,sp,32
   10562:	8082                	ret

0000000000010564 <atexit>:
   10564:	85aa                	mv	a1,a0
   10566:	4681                	li	a3,0
   10568:	4601                	li	a2,0
   1056a:	4501                	li	a0,0
   1056c:	a009                	j	1056e <__register_exitproc>

000000000001056e <__register_exitproc>:
   1056e:	fd81b703          	ld	a4,-40(gp) # 11e08 <_global_impure_ptr>
   10572:	1f873783          	ld	a5,504(a4)
   10576:	c3b1                	beqz	a5,105ba <__register_exitproc+0x4c>
   10578:	4798                	lw	a4,8(a5)
   1057a:	487d                	li	a6,31
   1057c:	06e84263          	blt	a6,a4,105e0 <__register_exitproc+0x72>
   10580:	c505                	beqz	a0,105a8 <__register_exitproc+0x3a>
   10582:	00371813          	sll	a6,a4,0x3
   10586:	983e                	add	a6,a6,a5
   10588:	10c83823          	sd	a2,272(a6)
   1058c:	3107a883          	lw	a7,784(a5)
   10590:	4605                	li	a2,1
   10592:	00e6163b          	sllw	a2,a2,a4
   10596:	00c8e8b3          	or	a7,a7,a2
   1059a:	3117a823          	sw	a7,784(a5)
   1059e:	20d83823          	sd	a3,528(a6)
   105a2:	4689                	li	a3,2
   105a4:	02d50063          	beq	a0,a3,105c4 <__register_exitproc+0x56>
   105a8:	00270693          	add	a3,a4,2
   105ac:	068e                	sll	a3,a3,0x3
   105ae:	2705                	addw	a4,a4,1
   105b0:	c798                	sw	a4,8(a5)
   105b2:	97b6                	add	a5,a5,a3
   105b4:	e38c                	sd	a1,0(a5)
   105b6:	4501                	li	a0,0
   105b8:	8082                	ret
   105ba:	20070793          	add	a5,a4,512
   105be:	1ef73c23          	sd	a5,504(a4)
   105c2:	bf5d                	j	10578 <__register_exitproc+0xa>
   105c4:	3147a683          	lw	a3,788(a5)
   105c8:	4501                	li	a0,0
   105ca:	8ed1                	or	a3,a3,a2
   105cc:	30d7aa23          	sw	a3,788(a5)
   105d0:	00270693          	add	a3,a4,2
   105d4:	068e                	sll	a3,a3,0x3
   105d6:	2705                	addw	a4,a4,1
   105d8:	c798                	sw	a4,8(a5)
   105da:	97b6                	add	a5,a5,a3
   105dc:	e38c                	sd	a1,0(a5)
   105de:	8082                	ret
   105e0:	557d                	li	a0,-1
   105e2:	8082                	ret

00000000000105e4 <_exit>:
   105e4:	05d00893          	li	a7,93
   105e8:	00000073          	ecall
   105ec:	00054363          	bltz	a0,105f2 <_exit+0xe>
   105f0:	a001                	j	105f0 <_exit+0xc>
   105f2:	1141                	add	sp,sp,-16
   105f4:	e022                	sd	s0,0(sp)
   105f6:	842a                	mv	s0,a0
   105f8:	e406                	sd	ra,8(sp)
   105fa:	4080043b          	negw	s0,s0
   105fe:	008000ef          	jal	10606 <__errno>
   10602:	c100                	sw	s0,0(a0)
   10604:	a001                	j	10604 <_exit+0x20>

0000000000010606 <__errno>:
   10606:	fe81b503          	ld	a0,-24(gp) # 11e18 <_impure_ptr>
   1060a:	8082                	ret

and.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2e4000ef          	jal	103d6 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11cd8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	44a000ef          	jal	1054c <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	49850513          	add	a0,a0,1176 # 10498 <__libc_fini_array>
   10112:	ae6d                	j	104cc <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c7a18193          	add	gp,gp,-902 # 11d90 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11cf0 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d28 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	202000ef          	jal	1032c <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	39e50513          	add	a0,a0,926 # 104cc <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36050513          	add	a0,a0,864 # 10498 <__libc_fini_array>
   10140:	38c000ef          	jal	104cc <atexit>
   10144:	17e000ef          	jal	102c2 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11cf0 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	57450513          	add	a0,a0,1396 # 11574 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11cf0 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11cf8 <object.0>
   1018e:	57450513          	add	a0,a0,1396 # 11574 <__EH_FRAME_BEGIN__>
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
   101ae:	60c1                	lui	ra,0x10
   101b0:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   101b4:	00c2                	sll	ra,ra,0x10
   101b6:	f0008093          	add	ra,ra,-256
   101ba:	0f0f1137          	lui	sp,0xf0f1
   101be:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df17f>
   101c2:	0020f733          	and	a4,ra,sp
   101c6:	0f0013b7          	lui	t2,0xf001
   101ca:	f003839b          	addw	t2,t2,-256 # f000f00 <__global_pointer$+0xefef170>
   101ce:	0e771263          	bne	a4,t2,102b2 <fail>

00000000000101d2 <test_3>:
   101d2:	418d                	li	gp,3
   101d4:	0ff010b7          	lui	ra,0xff01
   101d8:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef260>
   101da:	000f1137          	lui	sp,0xf1
   101de:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf17f>
   101e2:	0132                	sll	sp,sp,0xc
   101e4:	616d                	add	sp,sp,240
   101e6:	0020f733          	and	a4,ra,sp
   101ea:	00f003b7          	lui	t2,0xf00
   101ee:	0f03839b          	addw	t2,t2,240 # f000f0 <__global_pointer$+0xeee360>
   101f2:	0c771063          	bne	a4,t2,102b2 <fail>

00000000000101f6 <test_4>:
   101f6:	4191                	li	gp,4
   101f8:	00ff00b7          	lui	ra,0xff0
   101fc:	0ff0809b          	addw	ra,ra,255 # ff00ff <__global_pointer$+0xfde36f>
   10200:	0f0f1137          	lui	sp,0xf0f1
   10204:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df17f>
   10208:	0020f733          	and	a4,ra,sp
   1020c:	000f03b7          	lui	t2,0xf0
   10210:	23bd                	addw	t2,t2,15 # f000f <__global_pointer$+0xde27f>
   10212:	0a771063          	bne	a4,t2,102b2 <fail>

0000000000010216 <test_5>:
   10216:	4195                	li	gp,5
   10218:	000f00b7          	lui	ra,0xf0
   1021c:	0ff0809b          	addw	ra,ra,255 # f00ff <__global_pointer$+0xde36f>
   10220:	00b2                	sll	ra,ra,0xc
   10222:	00bd                	add	ra,ra,15
   10224:	000f1137          	lui	sp,0xf1
   10228:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf17f>
   1022c:	0132                	sll	sp,sp,0xc
   1022e:	616d                	add	sp,sp,240
   10230:	0020f733          	and	a4,ra,sp
   10234:	000f03b7          	lui	t2,0xf0
   10238:	23bd                	addw	t2,t2,15 # f000f <__global_pointer$+0xde27f>
   1023a:	03b2                	sll	t2,t2,0xc
   1023c:	06771b63          	bne	a4,t2,102b2 <fail>

0000000000010240 <test_6>:
   10240:	4199                	li	gp,6
   10242:	60c1                	lui	ra,0x10
   10244:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   10248:	00c2                	sll	ra,ra,0x10
   1024a:	f0008093          	add	ra,ra,-256
   1024e:	0f0f1137          	lui	sp,0xf0f1
   10252:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df17f>
   10256:	0020f0b3          	and	ra,ra,sp
   1025a:	0f0013b7          	lui	t2,0xf001
   1025e:	f003839b          	addw	t2,t2,-256 # f000f00 <__global_pointer$+0xefef170>
   10262:	04709863          	bne	ra,t2,102b2 <fail>

0000000000010266 <test_7>:
   10266:	419d                	li	gp,7
   10268:	0ff010b7          	lui	ra,0xff01
   1026c:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef260>
   1026e:	000f1137          	lui	sp,0xf1
   10272:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf17f>
   10276:	0132                	sll	sp,sp,0xc
   10278:	616d                	add	sp,sp,240
   1027a:	0020f133          	and	sp,ra,sp
   1027e:	00f003b7          	lui	t2,0xf00
   10282:	0f03839b          	addw	t2,t2,240 # f000f0 <__global_pointer$+0xeee360>
   10286:	02711663          	bne	sp,t2,102b2 <fail>

000000000001028a <test_8>:
   1028a:	41a1                	li	gp,8
   1028c:	60c1                	lui	ra,0x10
   1028e:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   10292:	00c2                	sll	ra,ra,0x10
   10294:	f0008093          	add	ra,ra,-256
   10298:	0010f0b3          	and	ra,ra,ra
   1029c:	63c1                	lui	t2,0x10
   1029e:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   102a2:	03c2                	sll	t2,t2,0x10
   102a4:	f0038393          	add	t2,t2,-256
   102a8:	00709563          	bne	ra,t2,102b2 <fail>
   102ac:	00301263          	bne	zero,gp,102b0 <pass>

00000000000102b0 <pass>:
   102b0:	a019                	j	102b6 <continue>

00000000000102b2 <fail>:
   102b2:	0000                	unimp
	...

00000000000102b6 <continue>:
   102b6:	4081                	li	ra,0
   102b8:	4781                	li	a5,0
   102ba:	853e                	mv	a0,a5
   102bc:	6462                	ld	s0,24(sp)
   102be:	6105                	add	sp,sp,32
   102c0:	8082                	ret

00000000000102c2 <__libc_init_array>:
   102c2:	1101                	add	sp,sp,-32
   102c4:	e822                	sd	s0,16(sp)
   102c6:	67c5                	lui	a5,0x11
   102c8:	6445                	lui	s0,0x11
   102ca:	e04a                	sd	s2,0(sp)
   102cc:	57878793          	add	a5,a5,1400 # 11578 <__init_array_start>
   102d0:	57840713          	add	a4,s0,1400 # 11578 <__init_array_start>
   102d4:	ec06                	sd	ra,24(sp)
   102d6:	e426                	sd	s1,8(sp)
   102d8:	40e78933          	sub	s2,a5,a4
   102dc:	00e78d63          	beq	a5,a4,102f6 <__libc_init_array+0x34>
   102e0:	40395913          	sra	s2,s2,0x3
   102e4:	57840413          	add	s0,s0,1400
   102e8:	4481                	li	s1,0
   102ea:	601c                	ld	a5,0(s0)
   102ec:	0485                	add	s1,s1,1
   102ee:	0421                	add	s0,s0,8
   102f0:	9782                	jalr	a5
   102f2:	ff24ece3          	bltu	s1,s2,102ea <__libc_init_array+0x28>
   102f6:	6445                	lui	s0,0x11
   102f8:	67c5                	lui	a5,0x11
   102fa:	58878793          	add	a5,a5,1416 # 11588 <__do_global_dtors_aux_fini_array_entry>
   102fe:	57840713          	add	a4,s0,1400 # 11578 <__init_array_start>
   10302:	40e78933          	sub	s2,a5,a4
   10306:	40395913          	sra	s2,s2,0x3
   1030a:	00e78b63          	beq	a5,a4,10320 <__libc_init_array+0x5e>
   1030e:	57840413          	add	s0,s0,1400
   10312:	4481                	li	s1,0
   10314:	601c                	ld	a5,0(s0)
   10316:	0485                	add	s1,s1,1
   10318:	0421                	add	s0,s0,8
   1031a:	9782                	jalr	a5
   1031c:	ff24ece3          	bltu	s1,s2,10314 <__libc_init_array+0x52>
   10320:	60e2                	ld	ra,24(sp)
   10322:	6442                	ld	s0,16(sp)
   10324:	64a2                	ld	s1,8(sp)
   10326:	6902                	ld	s2,0(sp)
   10328:	6105                	add	sp,sp,32
   1032a:	8082                	ret

000000000001032c <memset>:
   1032c:	433d                	li	t1,15
   1032e:	872a                	mv	a4,a0
   10330:	02c37163          	bgeu	t1,a2,10352 <memset+0x26>
   10334:	00f77793          	and	a5,a4,15
   10338:	e3c1                	bnez	a5,103b8 <memset+0x8c>
   1033a:	e1bd                	bnez	a1,103a0 <memset+0x74>
   1033c:	ff067693          	and	a3,a2,-16
   10340:	8a3d                	and	a2,a2,15
   10342:	96ba                	add	a3,a3,a4
   10344:	e30c                	sd	a1,0(a4)
   10346:	e70c                	sd	a1,8(a4)
   10348:	0741                	add	a4,a4,16
   1034a:	fed76de3          	bltu	a4,a3,10344 <memset+0x18>
   1034e:	e211                	bnez	a2,10352 <memset+0x26>
   10350:	8082                	ret
   10352:	40c306b3          	sub	a3,t1,a2
   10356:	068a                	sll	a3,a3,0x2
   10358:	00000297          	auipc	t0,0x0
   1035c:	9696                	add	a3,a3,t0
   1035e:	00a68067          	jr	10(a3)
   10362:	00b70723          	sb	a1,14(a4)
   10366:	00b706a3          	sb	a1,13(a4)
   1036a:	00b70623          	sb	a1,12(a4)
   1036e:	00b705a3          	sb	a1,11(a4)
   10372:	00b70523          	sb	a1,10(a4)
   10376:	00b704a3          	sb	a1,9(a4)
   1037a:	00b70423          	sb	a1,8(a4)
   1037e:	00b703a3          	sb	a1,7(a4)
   10382:	00b70323          	sb	a1,6(a4)
   10386:	00b702a3          	sb	a1,5(a4)
   1038a:	00b70223          	sb	a1,4(a4)
   1038e:	00b701a3          	sb	a1,3(a4)
   10392:	00b70123          	sb	a1,2(a4)
   10396:	00b700a3          	sb	a1,1(a4)
   1039a:	00b70023          	sb	a1,0(a4)
   1039e:	8082                	ret
   103a0:	0ff5f593          	zext.b	a1,a1
   103a4:	00859693          	sll	a3,a1,0x8
   103a8:	8dd5                	or	a1,a1,a3
   103aa:	01059693          	sll	a3,a1,0x10
   103ae:	8dd5                	or	a1,a1,a3
   103b0:	02059693          	sll	a3,a1,0x20
   103b4:	8dd5                	or	a1,a1,a3
   103b6:	b759                	j	1033c <memset+0x10>
   103b8:	00279693          	sll	a3,a5,0x2
   103bc:	00000297          	auipc	t0,0x0
   103c0:	9696                	add	a3,a3,t0
   103c2:	8286                	mv	t0,ra
   103c4:	fa2680e7          	jalr	-94(a3)
   103c8:	8096                	mv	ra,t0
   103ca:	17c1                	add	a5,a5,-16
   103cc:	8f1d                	sub	a4,a4,a5
   103ce:	963e                	add	a2,a2,a5
   103d0:	f8c371e3          	bgeu	t1,a2,10352 <memset+0x26>
   103d4:	b79d                	j	1033a <memset+0xe>

00000000000103d6 <__call_exitprocs>:
   103d6:	715d                	add	sp,sp,-80
   103d8:	f052                	sd	s4,32(sp)
   103da:	f481ba03          	ld	s4,-184(gp) # 11cd8 <_global_impure_ptr>
   103de:	f84a                	sd	s2,48(sp)
   103e0:	e486                	sd	ra,72(sp)
   103e2:	1f8a3903          	ld	s2,504(s4)
   103e6:	e0a2                	sd	s0,64(sp)
   103e8:	fc26                	sd	s1,56(sp)
   103ea:	f44e                	sd	s3,40(sp)
   103ec:	ec56                	sd	s5,24(sp)
   103ee:	e85a                	sd	s6,16(sp)
   103f0:	e45e                	sd	s7,8(sp)
   103f2:	e062                	sd	s8,0(sp)
   103f4:	02090863          	beqz	s2,10424 <__call_exitprocs+0x4e>
   103f8:	8b2a                	mv	s6,a0
   103fa:	8bae                	mv	s7,a1
   103fc:	4a85                	li	s5,1
   103fe:	59fd                	li	s3,-1
   10400:	00892483          	lw	s1,8(s2)
   10404:	fff4841b          	addw	s0,s1,-1
   10408:	00044e63          	bltz	s0,10424 <__call_exitprocs+0x4e>
   1040c:	048e                	sll	s1,s1,0x3
   1040e:	94ca                	add	s1,s1,s2
   10410:	020b8663          	beqz	s7,1043c <__call_exitprocs+0x66>
   10414:	2084b783          	ld	a5,520(s1)
   10418:	03778263          	beq	a5,s7,1043c <__call_exitprocs+0x66>
   1041c:	347d                	addw	s0,s0,-1
   1041e:	14e1                	add	s1,s1,-8
   10420:	ff3418e3          	bne	s0,s3,10410 <__call_exitprocs+0x3a>
   10424:	60a6                	ld	ra,72(sp)
   10426:	6406                	ld	s0,64(sp)
   10428:	74e2                	ld	s1,56(sp)
   1042a:	7942                	ld	s2,48(sp)
   1042c:	79a2                	ld	s3,40(sp)
   1042e:	7a02                	ld	s4,32(sp)
   10430:	6ae2                	ld	s5,24(sp)
   10432:	6b42                	ld	s6,16(sp)
   10434:	6ba2                	ld	s7,8(sp)
   10436:	6c02                	ld	s8,0(sp)
   10438:	6161                	add	sp,sp,80
   1043a:	8082                	ret
   1043c:	00892783          	lw	a5,8(s2)
   10440:	6498                	ld	a4,8(s1)
   10442:	37fd                	addw	a5,a5,-1
   10444:	04878463          	beq	a5,s0,1048c <__call_exitprocs+0xb6>
   10448:	0004b423          	sd	zero,8(s1)
   1044c:	db61                	beqz	a4,1041c <__call_exitprocs+0x46>
   1044e:	31092783          	lw	a5,784(s2)
   10452:	008a96bb          	sllw	a3,s5,s0
   10456:	00892c03          	lw	s8,8(s2)
   1045a:	8ff5                	and	a5,a5,a3
   1045c:	2781                	sext.w	a5,a5
   1045e:	ef89                	bnez	a5,10478 <__call_exitprocs+0xa2>
   10460:	9702                	jalr	a4
   10462:	00892703          	lw	a4,8(s2)
   10466:	1f8a3783          	ld	a5,504(s4)
   1046a:	01871463          	bne	a4,s8,10472 <__call_exitprocs+0x9c>
   1046e:	fb2787e3          	beq	a5,s2,1041c <__call_exitprocs+0x46>
   10472:	dbcd                	beqz	a5,10424 <__call_exitprocs+0x4e>
   10474:	893e                	mv	s2,a5
   10476:	b769                	j	10400 <__call_exitprocs+0x2a>
   10478:	31492783          	lw	a5,788(s2)
   1047c:	1084b583          	ld	a1,264(s1)
   10480:	8ff5                	and	a5,a5,a3
   10482:	2781                	sext.w	a5,a5
   10484:	e799                	bnez	a5,10492 <__call_exitprocs+0xbc>
   10486:	855a                	mv	a0,s6
   10488:	9702                	jalr	a4
   1048a:	bfe1                	j	10462 <__call_exitprocs+0x8c>
   1048c:	00892423          	sw	s0,8(s2)
   10490:	bf75                	j	1044c <__call_exitprocs+0x76>
   10492:	852e                	mv	a0,a1
   10494:	9702                	jalr	a4
   10496:	b7f1                	j	10462 <__call_exitprocs+0x8c>

0000000000010498 <__libc_fini_array>:
   10498:	1101                	add	sp,sp,-32
   1049a:	e822                	sd	s0,16(sp)
   1049c:	67c5                	lui	a5,0x11
   1049e:	6445                	lui	s0,0x11
   104a0:	58878793          	add	a5,a5,1416 # 11588 <__do_global_dtors_aux_fini_array_entry>
   104a4:	59040413          	add	s0,s0,1424 # 11590 <impure_data>
   104a8:	8c1d                	sub	s0,s0,a5
   104aa:	e426                	sd	s1,8(sp)
   104ac:	ec06                	sd	ra,24(sp)
   104ae:	40345493          	sra	s1,s0,0x3
   104b2:	c881                	beqz	s1,104c2 <__libc_fini_array+0x2a>
   104b4:	1461                	add	s0,s0,-8
   104b6:	943e                	add	s0,s0,a5
   104b8:	601c                	ld	a5,0(s0)
   104ba:	14fd                	add	s1,s1,-1
   104bc:	1461                	add	s0,s0,-8
   104be:	9782                	jalr	a5
   104c0:	fce5                	bnez	s1,104b8 <__libc_fini_array+0x20>
   104c2:	60e2                	ld	ra,24(sp)
   104c4:	6442                	ld	s0,16(sp)
   104c6:	64a2                	ld	s1,8(sp)
   104c8:	6105                	add	sp,sp,32
   104ca:	8082                	ret

00000000000104cc <atexit>:
   104cc:	85aa                	mv	a1,a0
   104ce:	4681                	li	a3,0
   104d0:	4601                	li	a2,0
   104d2:	4501                	li	a0,0
   104d4:	a009                	j	104d6 <__register_exitproc>

00000000000104d6 <__register_exitproc>:
   104d6:	f481b703          	ld	a4,-184(gp) # 11cd8 <_global_impure_ptr>
   104da:	1f873783          	ld	a5,504(a4)
   104de:	c3b1                	beqz	a5,10522 <__register_exitproc+0x4c>
   104e0:	4798                	lw	a4,8(a5)
   104e2:	487d                	li	a6,31
   104e4:	06e84263          	blt	a6,a4,10548 <__register_exitproc+0x72>
   104e8:	c505                	beqz	a0,10510 <__register_exitproc+0x3a>
   104ea:	00371813          	sll	a6,a4,0x3
   104ee:	983e                	add	a6,a6,a5
   104f0:	10c83823          	sd	a2,272(a6)
   104f4:	3107a883          	lw	a7,784(a5)
   104f8:	4605                	li	a2,1
   104fa:	00e6163b          	sllw	a2,a2,a4
   104fe:	00c8e8b3          	or	a7,a7,a2
   10502:	3117a823          	sw	a7,784(a5)
   10506:	20d83823          	sd	a3,528(a6)
   1050a:	4689                	li	a3,2
   1050c:	02d50063          	beq	a0,a3,1052c <__register_exitproc+0x56>
   10510:	00270693          	add	a3,a4,2
   10514:	068e                	sll	a3,a3,0x3
   10516:	2705                	addw	a4,a4,1
   10518:	c798                	sw	a4,8(a5)
   1051a:	97b6                	add	a5,a5,a3
   1051c:	e38c                	sd	a1,0(a5)
   1051e:	4501                	li	a0,0
   10520:	8082                	ret
   10522:	20070793          	add	a5,a4,512
   10526:	1ef73c23          	sd	a5,504(a4)
   1052a:	bf5d                	j	104e0 <__register_exitproc+0xa>
   1052c:	3147a683          	lw	a3,788(a5)
   10530:	4501                	li	a0,0
   10532:	8ed1                	or	a3,a3,a2
   10534:	30d7aa23          	sw	a3,788(a5)
   10538:	00270693          	add	a3,a4,2
   1053c:	068e                	sll	a3,a3,0x3
   1053e:	2705                	addw	a4,a4,1
   10540:	c798                	sw	a4,8(a5)
   10542:	97b6                	add	a5,a5,a3
   10544:	e38c                	sd	a1,0(a5)
   10546:	8082                	ret
   10548:	557d                	li	a0,-1
   1054a:	8082                	ret

000000000001054c <_exit>:
   1054c:	05d00893          	li	a7,93
   10550:	00000073          	ecall
   10554:	00054363          	bltz	a0,1055a <_exit+0xe>
   10558:	a001                	j	10558 <_exit+0xc>
   1055a:	1141                	add	sp,sp,-16
   1055c:	e022                	sd	s0,0(sp)
   1055e:	842a                	mv	s0,a0
   10560:	e406                	sd	ra,8(sp)
   10562:	4080043b          	negw	s0,s0
   10566:	008000ef          	jal	1056e <__errno>
   1056a:	c100                	sw	s0,0(a0)
   1056c:	a001                	j	1056c <_exit+0x20>

000000000001056e <__errno>:
   1056e:	f581b503          	ld	a0,-168(gp) # 11ce8 <_impure_ptr>
   10572:	8082                	ret

sw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	3c6000ef          	jal	104b8 <__call_exitprocs>
   100f6:	fc81b503          	ld	a0,-56(gp) # 11e48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	52c000ef          	jal	1062e <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	57a50513          	add	a0,a0,1402 # 1057a <__libc_fini_array>
   10112:	a971                	j	105ae <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d6a18193          	add	gp,gp,-662 # 11e80 <__global_pointer$>
   1011e:	fe018513          	add	a0,gp,-32 # 11e60 <completed.1>
   10122:	01818613          	add	a2,gp,24 # 11e98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	2e4000ef          	jal	1040e <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	48050513          	add	a0,a0,1152 # 105ae <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	44250513          	add	a0,a0,1090 # 1057a <__libc_fini_array>
   10140:	46e000ef          	jal	105ae <atexit>
   10144:	260000ef          	jal	103a4 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fe01c783          	lbu	a5,-32(gp) # 11e60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	65850513          	add	a0,a0,1624 # 11658 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fef18023          	sb	a5,-32(gp) # 11e60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fe818593          	add	a1,gp,-24 # 11e68 <object.0>
   1018e:	65850513          	add	a0,a0,1624 # 11658 <__EH_FRAME_BEGIN__>
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
   101ae:	00001097          	auipc	ra,0x1
   101b2:	4d208093          	add	ra,ra,1234 # 11680 <__DATA_BEGIN__>
   101b6:	00aa0137          	lui	sp,0xaa0
   101ba:	0aa1011b          	addw	sp,sp,170 # aa00aa <__BSS_END__+0xa8e212>
   101be:	00000797          	auipc	a5,0x0
   101c2:	01278793          	add	a5,a5,18 # 101d0 <test_2+0x24>
   101c6:	0020a023          	sw	sp,0(ra)
   101ca:	0000a703          	lw	a4,0(ra)
   101ce:	a011                	j	101d2 <test_2+0x26>
   101d0:	870a                	mv	a4,sp
   101d2:	00aa03b7          	lui	t2,0xaa0
   101d6:	0aa3839b          	addw	t2,t2,170 # aa00aa <__BSS_END__+0xa8e212>
   101da:	1a771d63          	bne	a4,t2,10394 <fail>

00000000000101de <test_3>:
   101de:	418d                	li	gp,3
   101e0:	00001097          	auipc	ra,0x1
   101e4:	4a008093          	add	ra,ra,1184 # 11680 <__DATA_BEGIN__>
   101e8:	aa00b137          	lui	sp,0xaa00b
   101ec:	a001011b          	addw	sp,sp,-1536 # ffffffffaa00aa00 <__BSS_END__+0xffffffffa9ff8b68>
   101f0:	00000797          	auipc	a5,0x0
   101f4:	01278793          	add	a5,a5,18 # 10202 <test_3+0x24>
   101f8:	0020a223          	sw	sp,4(ra)
   101fc:	0040a703          	lw	a4,4(ra)
   10200:	a011                	j	10204 <test_3+0x26>
   10202:	870a                	mv	a4,sp
   10204:	aa00b3b7          	lui	t2,0xaa00b
   10208:	a003839b          	addw	t2,t2,-1536 # ffffffffaa00aa00 <__BSS_END__+0xffffffffa9ff8b68>
   1020c:	18771463          	bne	a4,t2,10394 <fail>

0000000000010210 <test_4>:
   10210:	4191                	li	gp,4
   10212:	00001097          	auipc	ra,0x1
   10216:	46e08093          	add	ra,ra,1134 # 11680 <__DATA_BEGIN__>
   1021a:	0aa01137          	lui	sp,0xaa01
   1021e:	aa01011b          	addw	sp,sp,-1376 # aa00aa0 <__BSS_END__+0xa9eec08>
   10222:	00000797          	auipc	a5,0x0
   10226:	01278793          	add	a5,a5,18 # 10234 <test_4+0x24>
   1022a:	0020a423          	sw	sp,8(ra)
   1022e:	0080a703          	lw	a4,8(ra)
   10232:	a011                	j	10236 <test_4+0x26>
   10234:	870a                	mv	a4,sp
   10236:	0aa013b7          	lui	t2,0xaa01
   1023a:	aa03839b          	addw	t2,t2,-1376 # aa00aa0 <__BSS_END__+0xa9eec08>
   1023e:	14771b63          	bne	a4,t2,10394 <fail>

0000000000010242 <test_5>:
   10242:	4195                	li	gp,5
   10244:	00001097          	auipc	ra,0x1
   10248:	43c08093          	add	ra,ra,1084 # 11680 <__DATA_BEGIN__>
   1024c:	a00aa137          	lui	sp,0xa00aa
   10250:	2129                	addw	sp,sp,10 # ffffffffa00aa00a <__BSS_END__+0xffffffffa0098172>
   10252:	00000797          	auipc	a5,0x0
   10256:	01278793          	add	a5,a5,18 # 10264 <test_5+0x22>
   1025a:	0020a623          	sw	sp,12(ra)
   1025e:	00c0a703          	lw	a4,12(ra)
   10262:	a011                	j	10266 <test_5+0x24>
   10264:	870a                	mv	a4,sp
   10266:	a00aa3b7          	lui	t2,0xa00aa
   1026a:	23a9                	addw	t2,t2,10 # ffffffffa00aa00a <__BSS_END__+0xffffffffa0098172>
   1026c:	12771463          	bne	a4,t2,10394 <fail>

0000000000010270 <test_6>:
   10270:	4199                	li	gp,6
   10272:	00001097          	auipc	ra,0x1
   10276:	42a08093          	add	ra,ra,1066 # 1169c <tdat8>
   1027a:	00aa0137          	lui	sp,0xaa0
   1027e:	0aa1011b          	addw	sp,sp,170 # aa00aa <__BSS_END__+0xa8e212>
   10282:	00000797          	auipc	a5,0x0
   10286:	01278793          	add	a5,a5,18 # 10294 <test_6+0x24>
   1028a:	fe20aa23          	sw	sp,-12(ra)
   1028e:	ff40a703          	lw	a4,-12(ra)
   10292:	a011                	j	10296 <test_6+0x26>
   10294:	870a                	mv	a4,sp
   10296:	00aa03b7          	lui	t2,0xaa0
   1029a:	0aa3839b          	addw	t2,t2,170 # aa00aa <__BSS_END__+0xa8e212>
   1029e:	0e771b63          	bne	a4,t2,10394 <fail>

00000000000102a2 <test_7>:
   102a2:	419d                	li	gp,7
   102a4:	00001097          	auipc	ra,0x1
   102a8:	3f808093          	add	ra,ra,1016 # 1169c <tdat8>
   102ac:	aa00b137          	lui	sp,0xaa00b
   102b0:	a001011b          	addw	sp,sp,-1536 # ffffffffaa00aa00 <__BSS_END__+0xffffffffa9ff8b68>
   102b4:	00000797          	auipc	a5,0x0
   102b8:	01278793          	add	a5,a5,18 # 102c6 <test_7+0x24>
   102bc:	fe20ac23          	sw	sp,-8(ra)
   102c0:	ff80a703          	lw	a4,-8(ra)
   102c4:	a011                	j	102c8 <test_7+0x26>
   102c6:	870a                	mv	a4,sp
   102c8:	aa00b3b7          	lui	t2,0xaa00b
   102cc:	a003839b          	addw	t2,t2,-1536 # ffffffffaa00aa00 <__BSS_END__+0xffffffffa9ff8b68>
   102d0:	0c771263          	bne	a4,t2,10394 <fail>

00000000000102d4 <test_8>:
   102d4:	41a1                	li	gp,8
   102d6:	00001097          	auipc	ra,0x1
   102da:	3c608093          	add	ra,ra,966 # 1169c <tdat8>
   102de:	0aa01137          	lui	sp,0xaa01
   102e2:	aa01011b          	addw	sp,sp,-1376 # aa00aa0 <__BSS_END__+0xa9eec08>
   102e6:	00000797          	auipc	a5,0x0
   102ea:	01278793          	add	a5,a5,18 # 102f8 <test_8+0x24>
   102ee:	fe20ae23          	sw	sp,-4(ra)
   102f2:	ffc0a703          	lw	a4,-4(ra)
   102f6:	a011                	j	102fa <test_8+0x26>
   102f8:	870a                	mv	a4,sp
   102fa:	0aa013b7          	lui	t2,0xaa01
   102fe:	aa03839b          	addw	t2,t2,-1376 # aa00aa0 <__BSS_END__+0xa9eec08>
   10302:	08771963          	bne	a4,t2,10394 <fail>

0000000000010306 <test_9>:
   10306:	41a5                	li	gp,9
   10308:	00001097          	auipc	ra,0x1
   1030c:	39408093          	add	ra,ra,916 # 1169c <tdat8>
   10310:	a00aa137          	lui	sp,0xa00aa
   10314:	2129                	addw	sp,sp,10 # ffffffffa00aa00a <__BSS_END__+0xffffffffa0098172>
   10316:	00000797          	auipc	a5,0x0
   1031a:	01278793          	add	a5,a5,18 # 10328 <test_9+0x22>
   1031e:	0020a023          	sw	sp,0(ra)
   10322:	0000a703          	lw	a4,0(ra)
   10326:	a011                	j	1032a <test_9+0x24>
   10328:	870a                	mv	a4,sp
   1032a:	a00aa3b7          	lui	t2,0xa00aa
   1032e:	23a9                	addw	t2,t2,10 # ffffffffa00aa00a <__BSS_END__+0xffffffffa0098172>
   10330:	06771263          	bne	a4,t2,10394 <fail>

0000000000010334 <test_10>:
   10334:	41a9                	li	gp,10
   10336:	00001097          	auipc	ra,0x1
   1033a:	36a08093          	add	ra,ra,874 # 116a0 <tdat9>
   1033e:	12345137          	lui	sp,0x12345
   10342:	6781011b          	addw	sp,sp,1656 # 12345678 <__BSS_END__+0x123337e0>
   10346:	fe008213          	add	tp,ra,-32
   1034a:	02222023          	sw	sp,32(tp) # 20 <exit-0x100c8>
   1034e:	0000a283          	lw	t0,0(ra)
   10352:	123453b7          	lui	t2,0x12345
   10356:	6783839b          	addw	t2,t2,1656 # 12345678 <__BSS_END__+0x123337e0>
   1035a:	02729d63          	bne	t0,t2,10394 <fail>

000000000001035e <test_11>:
   1035e:	41ad                	li	gp,11
   10360:	00001097          	auipc	ra,0x1
   10364:	34008093          	add	ra,ra,832 # 116a0 <tdat9>
   10368:	58213137          	lui	sp,0x58213
   1036c:	0981011b          	addw	sp,sp,152 # 58213098 <__BSS_END__+0x58201200>
   10370:	10f5                	add	ra,ra,-3
   10372:	0020a3a3          	sw	sp,7(ra)
   10376:	00001217          	auipc	tp,0x1
   1037a:	32e20213          	add	tp,tp,814 # 116a4 <tdat10>
   1037e:	00022283          	lw	t0,0(tp) # 0 <exit-0x100e8>
   10382:	582133b7          	lui	t2,0x58213
   10386:	0983839b          	addw	t2,t2,152 # 58213098 <__BSS_END__+0x58201200>
   1038a:	00729563          	bne	t0,t2,10394 <fail>
   1038e:	00301263          	bne	zero,gp,10392 <pass>

0000000000010392 <pass>:
   10392:	a019                	j	10398 <continue>

0000000000010394 <fail>:
   10394:	0000                	unimp
	...

0000000000010398 <continue>:
   10398:	4081                	li	ra,0
   1039a:	4781                	li	a5,0
   1039c:	853e                	mv	a0,a5
   1039e:	6462                	ld	s0,24(sp)
   103a0:	6105                	add	sp,sp,32
   103a2:	8082                	ret

00000000000103a4 <__libc_init_array>:
   103a4:	1101                	add	sp,sp,-32
   103a6:	e822                	sd	s0,16(sp)
   103a8:	67c5                	lui	a5,0x11
   103aa:	6445                	lui	s0,0x11
   103ac:	e04a                	sd	s2,0(sp)
   103ae:	65c78793          	add	a5,a5,1628 # 1165c <__preinit_array_end>
   103b2:	65c40713          	add	a4,s0,1628 # 1165c <__preinit_array_end>
   103b6:	ec06                	sd	ra,24(sp)
   103b8:	e426                	sd	s1,8(sp)
   103ba:	40e78933          	sub	s2,a5,a4
   103be:	00e78d63          	beq	a5,a4,103d8 <__libc_init_array+0x34>
   103c2:	40395913          	sra	s2,s2,0x3
   103c6:	65c40413          	add	s0,s0,1628
   103ca:	4481                	li	s1,0
   103cc:	601c                	ld	a5,0(s0)
   103ce:	0485                	add	s1,s1,1
   103d0:	0421                	add	s0,s0,8
   103d2:	9782                	jalr	a5
   103d4:	ff24ece3          	bltu	s1,s2,103cc <__libc_init_array+0x28>
   103d8:	6445                	lui	s0,0x11
   103da:	67c5                	lui	a5,0x11
   103dc:	67078793          	add	a5,a5,1648 # 11670 <__do_global_dtors_aux_fini_array_entry>
   103e0:	66040713          	add	a4,s0,1632 # 11660 <__init_array_start>
   103e4:	40e78933          	sub	s2,a5,a4
   103e8:	40395913          	sra	s2,s2,0x3
   103ec:	00e78b63          	beq	a5,a4,10402 <__libc_init_array+0x5e>
   103f0:	66040413          	add	s0,s0,1632
   103f4:	4481                	li	s1,0
   103f6:	601c                	ld	a5,0(s0)
   103f8:	0485                	add	s1,s1,1
   103fa:	0421                	add	s0,s0,8
   103fc:	9782                	jalr	a5
   103fe:	ff24ece3          	bltu	s1,s2,103f6 <__libc_init_array+0x52>
   10402:	60e2                	ld	ra,24(sp)
   10404:	6442                	ld	s0,16(sp)
   10406:	64a2                	ld	s1,8(sp)
   10408:	6902                	ld	s2,0(sp)
   1040a:	6105                	add	sp,sp,32
   1040c:	8082                	ret

000000000001040e <memset>:
   1040e:	433d                	li	t1,15
   10410:	872a                	mv	a4,a0
   10412:	02c37163          	bgeu	t1,a2,10434 <memset+0x26>
   10416:	00f77793          	and	a5,a4,15
   1041a:	e3c1                	bnez	a5,1049a <memset+0x8c>
   1041c:	e1bd                	bnez	a1,10482 <memset+0x74>
   1041e:	ff067693          	and	a3,a2,-16
   10422:	8a3d                	and	a2,a2,15
   10424:	96ba                	add	a3,a3,a4
   10426:	e30c                	sd	a1,0(a4)
   10428:	e70c                	sd	a1,8(a4)
   1042a:	0741                	add	a4,a4,16
   1042c:	fed76de3          	bltu	a4,a3,10426 <memset+0x18>
   10430:	e211                	bnez	a2,10434 <memset+0x26>
   10432:	8082                	ret
   10434:	40c306b3          	sub	a3,t1,a2
   10438:	068a                	sll	a3,a3,0x2
   1043a:	00000297          	auipc	t0,0x0
   1043e:	9696                	add	a3,a3,t0
   10440:	00a68067          	jr	10(a3)
   10444:	00b70723          	sb	a1,14(a4)
   10448:	00b706a3          	sb	a1,13(a4)
   1044c:	00b70623          	sb	a1,12(a4)
   10450:	00b705a3          	sb	a1,11(a4)
   10454:	00b70523          	sb	a1,10(a4)
   10458:	00b704a3          	sb	a1,9(a4)
   1045c:	00b70423          	sb	a1,8(a4)
   10460:	00b703a3          	sb	a1,7(a4)
   10464:	00b70323          	sb	a1,6(a4)
   10468:	00b702a3          	sb	a1,5(a4)
   1046c:	00b70223          	sb	a1,4(a4)
   10470:	00b701a3          	sb	a1,3(a4)
   10474:	00b70123          	sb	a1,2(a4)
   10478:	00b700a3          	sb	a1,1(a4)
   1047c:	00b70023          	sb	a1,0(a4)
   10480:	8082                	ret
   10482:	0ff5f593          	zext.b	a1,a1
   10486:	00859693          	sll	a3,a1,0x8
   1048a:	8dd5                	or	a1,a1,a3
   1048c:	01059693          	sll	a3,a1,0x10
   10490:	8dd5                	or	a1,a1,a3
   10492:	02059693          	sll	a3,a1,0x20
   10496:	8dd5                	or	a1,a1,a3
   10498:	b759                	j	1041e <memset+0x10>
   1049a:	00279693          	sll	a3,a5,0x2
   1049e:	00000297          	auipc	t0,0x0
   104a2:	9696                	add	a3,a3,t0
   104a4:	8286                	mv	t0,ra
   104a6:	fa2680e7          	jalr	-94(a3)
   104aa:	8096                	mv	ra,t0
   104ac:	17c1                	add	a5,a5,-16
   104ae:	8f1d                	sub	a4,a4,a5
   104b0:	963e                	add	a2,a2,a5
   104b2:	f8c371e3          	bgeu	t1,a2,10434 <memset+0x26>
   104b6:	b79d                	j	1041c <memset+0xe>

00000000000104b8 <__call_exitprocs>:
   104b8:	715d                	add	sp,sp,-80
   104ba:	f052                	sd	s4,32(sp)
   104bc:	fc81ba03          	ld	s4,-56(gp) # 11e48 <_global_impure_ptr>
   104c0:	f84a                	sd	s2,48(sp)
   104c2:	e486                	sd	ra,72(sp)
   104c4:	1f8a3903          	ld	s2,504(s4)
   104c8:	e0a2                	sd	s0,64(sp)
   104ca:	fc26                	sd	s1,56(sp)
   104cc:	f44e                	sd	s3,40(sp)
   104ce:	ec56                	sd	s5,24(sp)
   104d0:	e85a                	sd	s6,16(sp)
   104d2:	e45e                	sd	s7,8(sp)
   104d4:	e062                	sd	s8,0(sp)
   104d6:	02090863          	beqz	s2,10506 <__call_exitprocs+0x4e>
   104da:	8b2a                	mv	s6,a0
   104dc:	8bae                	mv	s7,a1
   104de:	4a85                	li	s5,1
   104e0:	59fd                	li	s3,-1
   104e2:	00892483          	lw	s1,8(s2)
   104e6:	fff4841b          	addw	s0,s1,-1
   104ea:	00044e63          	bltz	s0,10506 <__call_exitprocs+0x4e>
   104ee:	048e                	sll	s1,s1,0x3
   104f0:	94ca                	add	s1,s1,s2
   104f2:	020b8663          	beqz	s7,1051e <__call_exitprocs+0x66>
   104f6:	2084b783          	ld	a5,520(s1)
   104fa:	03778263          	beq	a5,s7,1051e <__call_exitprocs+0x66>
   104fe:	347d                	addw	s0,s0,-1
   10500:	14e1                	add	s1,s1,-8
   10502:	ff3418e3          	bne	s0,s3,104f2 <__call_exitprocs+0x3a>
   10506:	60a6                	ld	ra,72(sp)
   10508:	6406                	ld	s0,64(sp)
   1050a:	74e2                	ld	s1,56(sp)
   1050c:	7942                	ld	s2,48(sp)
   1050e:	79a2                	ld	s3,40(sp)
   10510:	7a02                	ld	s4,32(sp)
   10512:	6ae2                	ld	s5,24(sp)
   10514:	6b42                	ld	s6,16(sp)
   10516:	6ba2                	ld	s7,8(sp)
   10518:	6c02                	ld	s8,0(sp)
   1051a:	6161                	add	sp,sp,80
   1051c:	8082                	ret
   1051e:	00892783          	lw	a5,8(s2)
   10522:	6498                	ld	a4,8(s1)
   10524:	37fd                	addw	a5,a5,-1
   10526:	04878463          	beq	a5,s0,1056e <__call_exitprocs+0xb6>
   1052a:	0004b423          	sd	zero,8(s1)
   1052e:	db61                	beqz	a4,104fe <__call_exitprocs+0x46>
   10530:	31092783          	lw	a5,784(s2)
   10534:	008a96bb          	sllw	a3,s5,s0
   10538:	00892c03          	lw	s8,8(s2)
   1053c:	8ff5                	and	a5,a5,a3
   1053e:	2781                	sext.w	a5,a5
   10540:	ef89                	bnez	a5,1055a <__call_exitprocs+0xa2>
   10542:	9702                	jalr	a4
   10544:	00892703          	lw	a4,8(s2)
   10548:	1f8a3783          	ld	a5,504(s4)
   1054c:	01871463          	bne	a4,s8,10554 <__call_exitprocs+0x9c>
   10550:	fb2787e3          	beq	a5,s2,104fe <__call_exitprocs+0x46>
   10554:	dbcd                	beqz	a5,10506 <__call_exitprocs+0x4e>
   10556:	893e                	mv	s2,a5
   10558:	b769                	j	104e2 <__call_exitprocs+0x2a>
   1055a:	31492783          	lw	a5,788(s2)
   1055e:	1084b583          	ld	a1,264(s1)
   10562:	8ff5                	and	a5,a5,a3
   10564:	2781                	sext.w	a5,a5
   10566:	e799                	bnez	a5,10574 <__call_exitprocs+0xbc>
   10568:	855a                	mv	a0,s6
   1056a:	9702                	jalr	a4
   1056c:	bfe1                	j	10544 <__call_exitprocs+0x8c>
   1056e:	00892423          	sw	s0,8(s2)
   10572:	bf75                	j	1052e <__call_exitprocs+0x76>
   10574:	852e                	mv	a0,a1
   10576:	9702                	jalr	a4
   10578:	b7f1                	j	10544 <__call_exitprocs+0x8c>

000000000001057a <__libc_fini_array>:
   1057a:	1101                	add	sp,sp,-32
   1057c:	e822                	sd	s0,16(sp)
   1057e:	67c5                	lui	a5,0x11
   10580:	6445                	lui	s0,0x11
   10582:	67078793          	add	a5,a5,1648 # 11670 <__do_global_dtors_aux_fini_array_entry>
   10586:	67840413          	add	s0,s0,1656 # 11678 <__fini_array_end>
   1058a:	8c1d                	sub	s0,s0,a5
   1058c:	e426                	sd	s1,8(sp)
   1058e:	ec06                	sd	ra,24(sp)
   10590:	40345493          	sra	s1,s0,0x3
   10594:	c881                	beqz	s1,105a4 <__libc_fini_array+0x2a>
   10596:	1461                	add	s0,s0,-8
   10598:	943e                	add	s0,s0,a5
   1059a:	601c                	ld	a5,0(s0)
   1059c:	14fd                	add	s1,s1,-1
   1059e:	1461                	add	s0,s0,-8
   105a0:	9782                	jalr	a5
   105a2:	fce5                	bnez	s1,1059a <__libc_fini_array+0x20>
   105a4:	60e2                	ld	ra,24(sp)
   105a6:	6442                	ld	s0,16(sp)
   105a8:	64a2                	ld	s1,8(sp)
   105aa:	6105                	add	sp,sp,32
   105ac:	8082                	ret

00000000000105ae <atexit>:
   105ae:	85aa                	mv	a1,a0
   105b0:	4681                	li	a3,0
   105b2:	4601                	li	a2,0
   105b4:	4501                	li	a0,0
   105b6:	a009                	j	105b8 <__register_exitproc>

00000000000105b8 <__register_exitproc>:
   105b8:	fc81b703          	ld	a4,-56(gp) # 11e48 <_global_impure_ptr>
   105bc:	1f873783          	ld	a5,504(a4)
   105c0:	c3b1                	beqz	a5,10604 <__register_exitproc+0x4c>
   105c2:	4798                	lw	a4,8(a5)
   105c4:	487d                	li	a6,31
   105c6:	06e84263          	blt	a6,a4,1062a <__register_exitproc+0x72>
   105ca:	c505                	beqz	a0,105f2 <__register_exitproc+0x3a>
   105cc:	00371813          	sll	a6,a4,0x3
   105d0:	983e                	add	a6,a6,a5
   105d2:	10c83823          	sd	a2,272(a6)
   105d6:	3107a883          	lw	a7,784(a5)
   105da:	4605                	li	a2,1
   105dc:	00e6163b          	sllw	a2,a2,a4
   105e0:	00c8e8b3          	or	a7,a7,a2
   105e4:	3117a823          	sw	a7,784(a5)
   105e8:	20d83823          	sd	a3,528(a6)
   105ec:	4689                	li	a3,2
   105ee:	02d50063          	beq	a0,a3,1060e <__register_exitproc+0x56>
   105f2:	00270693          	add	a3,a4,2
   105f6:	068e                	sll	a3,a3,0x3
   105f8:	2705                	addw	a4,a4,1
   105fa:	c798                	sw	a4,8(a5)
   105fc:	97b6                	add	a5,a5,a3
   105fe:	e38c                	sd	a1,0(a5)
   10600:	4501                	li	a0,0
   10602:	8082                	ret
   10604:	20070793          	add	a5,a4,512
   10608:	1ef73c23          	sd	a5,504(a4)
   1060c:	bf5d                	j	105c2 <__register_exitproc+0xa>
   1060e:	3147a683          	lw	a3,788(a5)
   10612:	4501                	li	a0,0
   10614:	8ed1                	or	a3,a3,a2
   10616:	30d7aa23          	sw	a3,788(a5)
   1061a:	00270693          	add	a3,a4,2
   1061e:	068e                	sll	a3,a3,0x3
   10620:	2705                	addw	a4,a4,1
   10622:	c798                	sw	a4,8(a5)
   10624:	97b6                	add	a5,a5,a3
   10626:	e38c                	sd	a1,0(a5)
   10628:	8082                	ret
   1062a:	557d                	li	a0,-1
   1062c:	8082                	ret

000000000001062e <_exit>:
   1062e:	05d00893          	li	a7,93
   10632:	00000073          	ecall
   10636:	00054363          	bltz	a0,1063c <_exit+0xe>
   1063a:	a001                	j	1063a <_exit+0xc>
   1063c:	1141                	add	sp,sp,-16
   1063e:	e022                	sd	s0,0(sp)
   10640:	842a                	mv	s0,a0
   10642:	e406                	sd	ra,8(sp)
   10644:	4080043b          	negw	s0,s0
   10648:	008000ef          	jal	10650 <__errno>
   1064c:	c100                	sw	s0,0(a0)
   1064e:	a001                	j	1064e <_exit+0x20>

0000000000010650 <__errno>:
   10650:	fd81b503          	ld	a0,-40(gp) # 11e58 <_impure_ptr>
   10654:	8082                	ret

xor.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2ec000ef          	jal	103de <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11ce0 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	452000ef          	jal	10554 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4a050513          	add	a0,a0,1184 # 104a0 <__libc_fini_array>
   10112:	a6c9                	j	104d4 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c8218193          	add	gp,gp,-894 # 11d98 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11cf8 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d30 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	20a000ef          	jal	10334 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3a650513          	add	a0,a0,934 # 104d4 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36850513          	add	a0,a0,872 # 104a0 <__libc_fini_array>
   10140:	394000ef          	jal	104d4 <atexit>
   10144:	186000ef          	jal	102ca <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11cf8 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	57c50513          	add	a0,a0,1404 # 1157c <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11cf8 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d00 <object.0>
   1018e:	57c50513          	add	a0,a0,1404 # 1157c <__EH_FRAME_BEGIN__>
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
   101ae:	60c1                	lui	ra,0x10
   101b0:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   101b4:	00c2                	sll	ra,ra,0x10
   101b6:	f0008093          	add	ra,ra,-256
   101ba:	0f0f1137          	lui	sp,0xf0f1
   101be:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df177>
   101c2:	0020c733          	xor	a4,ra,sp
   101c6:	000f03b7          	lui	t2,0xf0
   101ca:	0ff3839b          	addw	t2,t2,255 # f00ff <__global_pointer$+0xde367>
   101ce:	03b2                	sll	t2,t2,0xc
   101d0:	03bd                	add	t2,t2,15
   101d2:	0e771463          	bne	a4,t2,102ba <fail>

00000000000101d6 <test_3>:
   101d6:	418d                	li	gp,3
   101d8:	0ff010b7          	lui	ra,0xff01
   101dc:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef258>
   101de:	000f1137          	lui	sp,0xf1
   101e2:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf177>
   101e6:	0132                	sll	sp,sp,0xc
   101e8:	616d                	add	sp,sp,240
   101ea:	0020c733          	xor	a4,ra,sp
   101ee:	63c1                	lui	t2,0x10
   101f0:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   101f4:	03c2                	sll	t2,t2,0x10
   101f6:	f0038393          	add	t2,t2,-256
   101fa:	0c771063          	bne	a4,t2,102ba <fail>

00000000000101fe <test_4>:
   101fe:	4191                	li	gp,4
   10200:	00ff00b7          	lui	ra,0xff0
   10204:	0ff0809b          	addw	ra,ra,255 # ff00ff <__global_pointer$+0xfde367>
   10208:	0f0f1137          	lui	sp,0xf0f1
   1020c:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df177>
   10210:	0020c733          	xor	a4,ra,sp
   10214:	0ff013b7          	lui	t2,0xff01
   10218:	33c1                	addw	t2,t2,-16 # ff00ff0 <__global_pointer$+0xfeef258>
   1021a:	0a771063          	bne	a4,t2,102ba <fail>

000000000001021e <test_5>:
   1021e:	4195                	li	gp,5
   10220:	000f00b7          	lui	ra,0xf0
   10224:	0ff0809b          	addw	ra,ra,255 # f00ff <__global_pointer$+0xde367>
   10228:	00b2                	sll	ra,ra,0xc
   1022a:	00bd                	add	ra,ra,15
   1022c:	000f1137          	lui	sp,0xf1
   10230:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf177>
   10234:	0132                	sll	sp,sp,0xc
   10236:	616d                	add	sp,sp,240
   10238:	0020c733          	xor	a4,ra,sp
   1023c:	00ff03b7          	lui	t2,0xff0
   10240:	0ff3839b          	addw	t2,t2,255 # ff00ff <__global_pointer$+0xfde367>
   10244:	06771b63          	bne	a4,t2,102ba <fail>

0000000000010248 <test_6>:
   10248:	4199                	li	gp,6
   1024a:	60c1                	lui	ra,0x10
   1024c:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   10250:	00c2                	sll	ra,ra,0x10
   10252:	f0008093          	add	ra,ra,-256
   10256:	0f0f1137          	lui	sp,0xf0f1
   1025a:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df177>
   1025e:	0020c0b3          	xor	ra,ra,sp
   10262:	000f03b7          	lui	t2,0xf0
   10266:	0ff3839b          	addw	t2,t2,255 # f00ff <__global_pointer$+0xde367>
   1026a:	03b2                	sll	t2,t2,0xc
   1026c:	03bd                	add	t2,t2,15
   1026e:	04709663          	bne	ra,t2,102ba <fail>

0000000000010272 <test_7>:
   10272:	419d                	li	gp,7
   10274:	60c1                	lui	ra,0x10
   10276:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   1027a:	00c2                	sll	ra,ra,0x10
   1027c:	f0008093          	add	ra,ra,-256
   10280:	0f0f1137          	lui	sp,0xf0f1
   10284:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df177>
   10288:	0020c133          	xor	sp,ra,sp
   1028c:	000f03b7          	lui	t2,0xf0
   10290:	0ff3839b          	addw	t2,t2,255 # f00ff <__global_pointer$+0xde367>
   10294:	03b2                	sll	t2,t2,0xc
   10296:	03bd                	add	t2,t2,15
   10298:	02711163          	bne	sp,t2,102ba <fail>

000000000001029c <test_8>:
   1029c:	41a1                	li	gp,8
   1029e:	60c1                	lui	ra,0x10
   102a0:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   102a4:	00c2                	sll	ra,ra,0x10
   102a6:	f0008093          	add	ra,ra,-256
   102aa:	0010c0b3          	xor	ra,ra,ra
   102ae:	4381                	li	t2,0
   102b0:	00709563          	bne	ra,t2,102ba <fail>
   102b4:	00301263          	bne	zero,gp,102b8 <pass>

00000000000102b8 <pass>:
   102b8:	a019                	j	102be <continue>

00000000000102ba <fail>:
   102ba:	0000                	unimp
	...

00000000000102be <continue>:
   102be:	4081                	li	ra,0
   102c0:	4781                	li	a5,0
   102c2:	853e                	mv	a0,a5
   102c4:	6462                	ld	s0,24(sp)
   102c6:	6105                	add	sp,sp,32
   102c8:	8082                	ret

00000000000102ca <__libc_init_array>:
   102ca:	1101                	add	sp,sp,-32
   102cc:	e822                	sd	s0,16(sp)
   102ce:	67c5                	lui	a5,0x11
   102d0:	6445                	lui	s0,0x11
   102d2:	e04a                	sd	s2,0(sp)
   102d4:	58078793          	add	a5,a5,1408 # 11580 <__init_array_start>
   102d8:	58040713          	add	a4,s0,1408 # 11580 <__init_array_start>
   102dc:	ec06                	sd	ra,24(sp)
   102de:	e426                	sd	s1,8(sp)
   102e0:	40e78933          	sub	s2,a5,a4
   102e4:	00e78d63          	beq	a5,a4,102fe <__libc_init_array+0x34>
   102e8:	40395913          	sra	s2,s2,0x3
   102ec:	58040413          	add	s0,s0,1408
   102f0:	4481                	li	s1,0
   102f2:	601c                	ld	a5,0(s0)
   102f4:	0485                	add	s1,s1,1
   102f6:	0421                	add	s0,s0,8
   102f8:	9782                	jalr	a5
   102fa:	ff24ece3          	bltu	s1,s2,102f2 <__libc_init_array+0x28>
   102fe:	6445                	lui	s0,0x11
   10300:	67c5                	lui	a5,0x11
   10302:	59078793          	add	a5,a5,1424 # 11590 <__do_global_dtors_aux_fini_array_entry>
   10306:	58040713          	add	a4,s0,1408 # 11580 <__init_array_start>
   1030a:	40e78933          	sub	s2,a5,a4
   1030e:	40395913          	sra	s2,s2,0x3
   10312:	00e78b63          	beq	a5,a4,10328 <__libc_init_array+0x5e>
   10316:	58040413          	add	s0,s0,1408
   1031a:	4481                	li	s1,0
   1031c:	601c                	ld	a5,0(s0)
   1031e:	0485                	add	s1,s1,1
   10320:	0421                	add	s0,s0,8
   10322:	9782                	jalr	a5
   10324:	ff24ece3          	bltu	s1,s2,1031c <__libc_init_array+0x52>
   10328:	60e2                	ld	ra,24(sp)
   1032a:	6442                	ld	s0,16(sp)
   1032c:	64a2                	ld	s1,8(sp)
   1032e:	6902                	ld	s2,0(sp)
   10330:	6105                	add	sp,sp,32
   10332:	8082                	ret

0000000000010334 <memset>:
   10334:	433d                	li	t1,15
   10336:	872a                	mv	a4,a0
   10338:	02c37163          	bgeu	t1,a2,1035a <memset+0x26>
   1033c:	00f77793          	and	a5,a4,15
   10340:	e3c1                	bnez	a5,103c0 <memset+0x8c>
   10342:	e1bd                	bnez	a1,103a8 <memset+0x74>
   10344:	ff067693          	and	a3,a2,-16
   10348:	8a3d                	and	a2,a2,15
   1034a:	96ba                	add	a3,a3,a4
   1034c:	e30c                	sd	a1,0(a4)
   1034e:	e70c                	sd	a1,8(a4)
   10350:	0741                	add	a4,a4,16
   10352:	fed76de3          	bltu	a4,a3,1034c <memset+0x18>
   10356:	e211                	bnez	a2,1035a <memset+0x26>
   10358:	8082                	ret
   1035a:	40c306b3          	sub	a3,t1,a2
   1035e:	068a                	sll	a3,a3,0x2
   10360:	00000297          	auipc	t0,0x0
   10364:	9696                	add	a3,a3,t0
   10366:	00a68067          	jr	10(a3)
   1036a:	00b70723          	sb	a1,14(a4)
   1036e:	00b706a3          	sb	a1,13(a4)
   10372:	00b70623          	sb	a1,12(a4)
   10376:	00b705a3          	sb	a1,11(a4)
   1037a:	00b70523          	sb	a1,10(a4)
   1037e:	00b704a3          	sb	a1,9(a4)
   10382:	00b70423          	sb	a1,8(a4)
   10386:	00b703a3          	sb	a1,7(a4)
   1038a:	00b70323          	sb	a1,6(a4)
   1038e:	00b702a3          	sb	a1,5(a4)
   10392:	00b70223          	sb	a1,4(a4)
   10396:	00b701a3          	sb	a1,3(a4)
   1039a:	00b70123          	sb	a1,2(a4)
   1039e:	00b700a3          	sb	a1,1(a4)
   103a2:	00b70023          	sb	a1,0(a4)
   103a6:	8082                	ret
   103a8:	0ff5f593          	zext.b	a1,a1
   103ac:	00859693          	sll	a3,a1,0x8
   103b0:	8dd5                	or	a1,a1,a3
   103b2:	01059693          	sll	a3,a1,0x10
   103b6:	8dd5                	or	a1,a1,a3
   103b8:	02059693          	sll	a3,a1,0x20
   103bc:	8dd5                	or	a1,a1,a3
   103be:	b759                	j	10344 <memset+0x10>
   103c0:	00279693          	sll	a3,a5,0x2
   103c4:	00000297          	auipc	t0,0x0
   103c8:	9696                	add	a3,a3,t0
   103ca:	8286                	mv	t0,ra
   103cc:	fa2680e7          	jalr	-94(a3)
   103d0:	8096                	mv	ra,t0
   103d2:	17c1                	add	a5,a5,-16
   103d4:	8f1d                	sub	a4,a4,a5
   103d6:	963e                	add	a2,a2,a5
   103d8:	f8c371e3          	bgeu	t1,a2,1035a <memset+0x26>
   103dc:	b79d                	j	10342 <memset+0xe>

00000000000103de <__call_exitprocs>:
   103de:	715d                	add	sp,sp,-80
   103e0:	f052                	sd	s4,32(sp)
   103e2:	f481ba03          	ld	s4,-184(gp) # 11ce0 <_global_impure_ptr>
   103e6:	f84a                	sd	s2,48(sp)
   103e8:	e486                	sd	ra,72(sp)
   103ea:	1f8a3903          	ld	s2,504(s4)
   103ee:	e0a2                	sd	s0,64(sp)
   103f0:	fc26                	sd	s1,56(sp)
   103f2:	f44e                	sd	s3,40(sp)
   103f4:	ec56                	sd	s5,24(sp)
   103f6:	e85a                	sd	s6,16(sp)
   103f8:	e45e                	sd	s7,8(sp)
   103fa:	e062                	sd	s8,0(sp)
   103fc:	02090863          	beqz	s2,1042c <__call_exitprocs+0x4e>
   10400:	8b2a                	mv	s6,a0
   10402:	8bae                	mv	s7,a1
   10404:	4a85                	li	s5,1
   10406:	59fd                	li	s3,-1
   10408:	00892483          	lw	s1,8(s2)
   1040c:	fff4841b          	addw	s0,s1,-1
   10410:	00044e63          	bltz	s0,1042c <__call_exitprocs+0x4e>
   10414:	048e                	sll	s1,s1,0x3
   10416:	94ca                	add	s1,s1,s2
   10418:	020b8663          	beqz	s7,10444 <__call_exitprocs+0x66>
   1041c:	2084b783          	ld	a5,520(s1)
   10420:	03778263          	beq	a5,s7,10444 <__call_exitprocs+0x66>
   10424:	347d                	addw	s0,s0,-1
   10426:	14e1                	add	s1,s1,-8
   10428:	ff3418e3          	bne	s0,s3,10418 <__call_exitprocs+0x3a>
   1042c:	60a6                	ld	ra,72(sp)
   1042e:	6406                	ld	s0,64(sp)
   10430:	74e2                	ld	s1,56(sp)
   10432:	7942                	ld	s2,48(sp)
   10434:	79a2                	ld	s3,40(sp)
   10436:	7a02                	ld	s4,32(sp)
   10438:	6ae2                	ld	s5,24(sp)
   1043a:	6b42                	ld	s6,16(sp)
   1043c:	6ba2                	ld	s7,8(sp)
   1043e:	6c02                	ld	s8,0(sp)
   10440:	6161                	add	sp,sp,80
   10442:	8082                	ret
   10444:	00892783          	lw	a5,8(s2)
   10448:	6498                	ld	a4,8(s1)
   1044a:	37fd                	addw	a5,a5,-1
   1044c:	04878463          	beq	a5,s0,10494 <__call_exitprocs+0xb6>
   10450:	0004b423          	sd	zero,8(s1)
   10454:	db61                	beqz	a4,10424 <__call_exitprocs+0x46>
   10456:	31092783          	lw	a5,784(s2)
   1045a:	008a96bb          	sllw	a3,s5,s0
   1045e:	00892c03          	lw	s8,8(s2)
   10462:	8ff5                	and	a5,a5,a3
   10464:	2781                	sext.w	a5,a5
   10466:	ef89                	bnez	a5,10480 <__call_exitprocs+0xa2>
   10468:	9702                	jalr	a4
   1046a:	00892703          	lw	a4,8(s2)
   1046e:	1f8a3783          	ld	a5,504(s4)
   10472:	01871463          	bne	a4,s8,1047a <__call_exitprocs+0x9c>
   10476:	fb2787e3          	beq	a5,s2,10424 <__call_exitprocs+0x46>
   1047a:	dbcd                	beqz	a5,1042c <__call_exitprocs+0x4e>
   1047c:	893e                	mv	s2,a5
   1047e:	b769                	j	10408 <__call_exitprocs+0x2a>
   10480:	31492783          	lw	a5,788(s2)
   10484:	1084b583          	ld	a1,264(s1)
   10488:	8ff5                	and	a5,a5,a3
   1048a:	2781                	sext.w	a5,a5
   1048c:	e799                	bnez	a5,1049a <__call_exitprocs+0xbc>
   1048e:	855a                	mv	a0,s6
   10490:	9702                	jalr	a4
   10492:	bfe1                	j	1046a <__call_exitprocs+0x8c>
   10494:	00892423          	sw	s0,8(s2)
   10498:	bf75                	j	10454 <__call_exitprocs+0x76>
   1049a:	852e                	mv	a0,a1
   1049c:	9702                	jalr	a4
   1049e:	b7f1                	j	1046a <__call_exitprocs+0x8c>

00000000000104a0 <__libc_fini_array>:
   104a0:	1101                	add	sp,sp,-32
   104a2:	e822                	sd	s0,16(sp)
   104a4:	67c5                	lui	a5,0x11
   104a6:	6445                	lui	s0,0x11
   104a8:	59078793          	add	a5,a5,1424 # 11590 <__do_global_dtors_aux_fini_array_entry>
   104ac:	59840413          	add	s0,s0,1432 # 11598 <impure_data>
   104b0:	8c1d                	sub	s0,s0,a5
   104b2:	e426                	sd	s1,8(sp)
   104b4:	ec06                	sd	ra,24(sp)
   104b6:	40345493          	sra	s1,s0,0x3
   104ba:	c881                	beqz	s1,104ca <__libc_fini_array+0x2a>
   104bc:	1461                	add	s0,s0,-8
   104be:	943e                	add	s0,s0,a5
   104c0:	601c                	ld	a5,0(s0)
   104c2:	14fd                	add	s1,s1,-1
   104c4:	1461                	add	s0,s0,-8
   104c6:	9782                	jalr	a5
   104c8:	fce5                	bnez	s1,104c0 <__libc_fini_array+0x20>
   104ca:	60e2                	ld	ra,24(sp)
   104cc:	6442                	ld	s0,16(sp)
   104ce:	64a2                	ld	s1,8(sp)
   104d0:	6105                	add	sp,sp,32
   104d2:	8082                	ret

00000000000104d4 <atexit>:
   104d4:	85aa                	mv	a1,a0
   104d6:	4681                	li	a3,0
   104d8:	4601                	li	a2,0
   104da:	4501                	li	a0,0
   104dc:	a009                	j	104de <__register_exitproc>

00000000000104de <__register_exitproc>:
   104de:	f481b703          	ld	a4,-184(gp) # 11ce0 <_global_impure_ptr>
   104e2:	1f873783          	ld	a5,504(a4)
   104e6:	c3b1                	beqz	a5,1052a <__register_exitproc+0x4c>
   104e8:	4798                	lw	a4,8(a5)
   104ea:	487d                	li	a6,31
   104ec:	06e84263          	blt	a6,a4,10550 <__register_exitproc+0x72>
   104f0:	c505                	beqz	a0,10518 <__register_exitproc+0x3a>
   104f2:	00371813          	sll	a6,a4,0x3
   104f6:	983e                	add	a6,a6,a5
   104f8:	10c83823          	sd	a2,272(a6)
   104fc:	3107a883          	lw	a7,784(a5)
   10500:	4605                	li	a2,1
   10502:	00e6163b          	sllw	a2,a2,a4
   10506:	00c8e8b3          	or	a7,a7,a2
   1050a:	3117a823          	sw	a7,784(a5)
   1050e:	20d83823          	sd	a3,528(a6)
   10512:	4689                	li	a3,2
   10514:	02d50063          	beq	a0,a3,10534 <__register_exitproc+0x56>
   10518:	00270693          	add	a3,a4,2
   1051c:	068e                	sll	a3,a3,0x3
   1051e:	2705                	addw	a4,a4,1
   10520:	c798                	sw	a4,8(a5)
   10522:	97b6                	add	a5,a5,a3
   10524:	e38c                	sd	a1,0(a5)
   10526:	4501                	li	a0,0
   10528:	8082                	ret
   1052a:	20070793          	add	a5,a4,512
   1052e:	1ef73c23          	sd	a5,504(a4)
   10532:	bf5d                	j	104e8 <__register_exitproc+0xa>
   10534:	3147a683          	lw	a3,788(a5)
   10538:	4501                	li	a0,0
   1053a:	8ed1                	or	a3,a3,a2
   1053c:	30d7aa23          	sw	a3,788(a5)
   10540:	00270693          	add	a3,a4,2
   10544:	068e                	sll	a3,a3,0x3
   10546:	2705                	addw	a4,a4,1
   10548:	c798                	sw	a4,8(a5)
   1054a:	97b6                	add	a5,a5,a3
   1054c:	e38c                	sd	a1,0(a5)
   1054e:	8082                	ret
   10550:	557d                	li	a0,-1
   10552:	8082                	ret

0000000000010554 <_exit>:
   10554:	05d00893          	li	a7,93
   10558:	00000073          	ecall
   1055c:	00054363          	bltz	a0,10562 <_exit+0xe>
   10560:	a001                	j	10560 <_exit+0xc>
   10562:	1141                	add	sp,sp,-16
   10564:	e022                	sd	s0,0(sp)
   10566:	842a                	mv	s0,a0
   10568:	e406                	sd	ra,8(sp)
   1056a:	4080043b          	negw	s0,s0
   1056e:	008000ef          	jal	10576 <__errno>
   10572:	c100                	sw	s0,0(a0)
   10574:	a001                	j	10574 <_exit+0x20>

0000000000010576 <__errno>:
   10576:	f581b503          	ld	a0,-168(gp) # 11cf0 <_impure_ptr>
   1057a:	8082                	ret

andi.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	25e000ef          	jal	10350 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11c58 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	3c4000ef          	jal	104c6 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	41250513          	add	a0,a0,1042 # 10412 <__libc_fini_array>
   10112:	ae15                	j	10446 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	bfa18193          	add	gp,gp,-1030 # 11d10 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11c70 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11ca8 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	17c000ef          	jal	102a6 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	31850513          	add	a0,a0,792 # 10446 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	2da50513          	add	a0,a0,730 # 10412 <__libc_fini_array>
   10140:	306000ef          	jal	10446 <atexit>
   10144:	0f8000ef          	jal	1023c <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11c70 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	4f050513          	add	a0,a0,1264 # 114f0 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11c70 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11c78 <object.0>
   1018e:	4f050513          	add	a0,a0,1264 # 114f0 <__EH_FRAME_BEGIN__>
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
   101ae:	60c1                	lui	ra,0x10
   101b0:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   101b4:	00c2                	sll	ra,ra,0x10
   101b6:	f0008093          	add	ra,ra,-256
   101ba:	f0f0f713          	and	a4,ra,-241
   101be:	63c1                	lui	t2,0x10
   101c0:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   101c4:	03c2                	sll	t2,t2,0x10
   101c6:	f0038393          	add	t2,t2,-256
   101ca:	06771163          	bne	a4,t2,1022c <fail>

00000000000101ce <test_3>:
   101ce:	418d                	li	gp,3
   101d0:	0ff010b7          	lui	ra,0xff01
   101d4:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef2e0>
   101d6:	0f00f713          	and	a4,ra,240
   101da:	0f000393          	li	t2,240
   101de:	04771763          	bne	a4,t2,1022c <fail>

00000000000101e2 <test_4>:
   101e2:	4191                	li	gp,4
   101e4:	00ff00b7          	lui	ra,0xff0
   101e8:	0ff0809b          	addw	ra,ra,255 # ff00ff <__global_pointer$+0xfde3ef>
   101ec:	70f0f713          	and	a4,ra,1807
   101f0:	43bd                	li	t2,15
   101f2:	02771d63          	bne	a4,t2,1022c <fail>

00000000000101f6 <test_5>:
   101f6:	4195                	li	gp,5
   101f8:	000f00b7          	lui	ra,0xf0
   101fc:	0ff0809b          	addw	ra,ra,255 # f00ff <__global_pointer$+0xde3ef>
   10200:	00b2                	sll	ra,ra,0xc
   10202:	00bd                	add	ra,ra,15
   10204:	0f00f713          	and	a4,ra,240
   10208:	4381                	li	t2,0
   1020a:	02771163          	bne	a4,t2,1022c <fail>

000000000001020e <test_6>:
   1020e:	4199                	li	gp,6
   10210:	60c1                	lui	ra,0x10
   10212:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   10216:	00c2                	sll	ra,ra,0x10
   10218:	f0008093          	add	ra,ra,-256
   1021c:	0f00f093          	and	ra,ra,240
   10220:	4381                	li	t2,0
   10222:	00709563          	bne	ra,t2,1022c <fail>
   10226:	00301263          	bne	zero,gp,1022a <pass>

000000000001022a <pass>:
   1022a:	a019                	j	10230 <continue>

000000000001022c <fail>:
   1022c:	0000                	unimp
	...

0000000000010230 <continue>:
   10230:	4081                	li	ra,0
   10232:	4781                	li	a5,0
   10234:	853e                	mv	a0,a5
   10236:	6462                	ld	s0,24(sp)
   10238:	6105                	add	sp,sp,32
   1023a:	8082                	ret

000000000001023c <__libc_init_array>:
   1023c:	1101                	add	sp,sp,-32
   1023e:	e822                	sd	s0,16(sp)
   10240:	67c5                	lui	a5,0x11
   10242:	6445                	lui	s0,0x11
   10244:	e04a                	sd	s2,0(sp)
   10246:	4f478793          	add	a5,a5,1268 # 114f4 <__preinit_array_end>
   1024a:	4f440713          	add	a4,s0,1268 # 114f4 <__preinit_array_end>
   1024e:	ec06                	sd	ra,24(sp)
   10250:	e426                	sd	s1,8(sp)
   10252:	40e78933          	sub	s2,a5,a4
   10256:	00e78d63          	beq	a5,a4,10270 <__libc_init_array+0x34>
   1025a:	40395913          	sra	s2,s2,0x3
   1025e:	4f440413          	add	s0,s0,1268
   10262:	4481                	li	s1,0
   10264:	601c                	ld	a5,0(s0)
   10266:	0485                	add	s1,s1,1
   10268:	0421                	add	s0,s0,8
   1026a:	9782                	jalr	a5
   1026c:	ff24ece3          	bltu	s1,s2,10264 <__libc_init_array+0x28>
   10270:	6445                	lui	s0,0x11
   10272:	67c5                	lui	a5,0x11
   10274:	50878793          	add	a5,a5,1288 # 11508 <__do_global_dtors_aux_fini_array_entry>
   10278:	4f840713          	add	a4,s0,1272 # 114f8 <__init_array_start>
   1027c:	40e78933          	sub	s2,a5,a4
   10280:	40395913          	sra	s2,s2,0x3
   10284:	00e78b63          	beq	a5,a4,1029a <__libc_init_array+0x5e>
   10288:	4f840413          	add	s0,s0,1272
   1028c:	4481                	li	s1,0
   1028e:	601c                	ld	a5,0(s0)
   10290:	0485                	add	s1,s1,1
   10292:	0421                	add	s0,s0,8
   10294:	9782                	jalr	a5
   10296:	ff24ece3          	bltu	s1,s2,1028e <__libc_init_array+0x52>
   1029a:	60e2                	ld	ra,24(sp)
   1029c:	6442                	ld	s0,16(sp)
   1029e:	64a2                	ld	s1,8(sp)
   102a0:	6902                	ld	s2,0(sp)
   102a2:	6105                	add	sp,sp,32
   102a4:	8082                	ret

00000000000102a6 <memset>:
   102a6:	433d                	li	t1,15
   102a8:	872a                	mv	a4,a0
   102aa:	02c37163          	bgeu	t1,a2,102cc <memset+0x26>
   102ae:	00f77793          	and	a5,a4,15
   102b2:	e3c1                	bnez	a5,10332 <memset+0x8c>
   102b4:	e1bd                	bnez	a1,1031a <memset+0x74>
   102b6:	ff067693          	and	a3,a2,-16
   102ba:	8a3d                	and	a2,a2,15
   102bc:	96ba                	add	a3,a3,a4
   102be:	e30c                	sd	a1,0(a4)
   102c0:	e70c                	sd	a1,8(a4)
   102c2:	0741                	add	a4,a4,16
   102c4:	fed76de3          	bltu	a4,a3,102be <memset+0x18>
   102c8:	e211                	bnez	a2,102cc <memset+0x26>
   102ca:	8082                	ret
   102cc:	40c306b3          	sub	a3,t1,a2
   102d0:	068a                	sll	a3,a3,0x2
   102d2:	00000297          	auipc	t0,0x0
   102d6:	9696                	add	a3,a3,t0
   102d8:	00a68067          	jr	10(a3)
   102dc:	00b70723          	sb	a1,14(a4)
   102e0:	00b706a3          	sb	a1,13(a4)
   102e4:	00b70623          	sb	a1,12(a4)
   102e8:	00b705a3          	sb	a1,11(a4)
   102ec:	00b70523          	sb	a1,10(a4)
   102f0:	00b704a3          	sb	a1,9(a4)
   102f4:	00b70423          	sb	a1,8(a4)
   102f8:	00b703a3          	sb	a1,7(a4)
   102fc:	00b70323          	sb	a1,6(a4)
   10300:	00b702a3          	sb	a1,5(a4)
   10304:	00b70223          	sb	a1,4(a4)
   10308:	00b701a3          	sb	a1,3(a4)
   1030c:	00b70123          	sb	a1,2(a4)
   10310:	00b700a3          	sb	a1,1(a4)
   10314:	00b70023          	sb	a1,0(a4)
   10318:	8082                	ret
   1031a:	0ff5f593          	zext.b	a1,a1
   1031e:	00859693          	sll	a3,a1,0x8
   10322:	8dd5                	or	a1,a1,a3
   10324:	01059693          	sll	a3,a1,0x10
   10328:	8dd5                	or	a1,a1,a3
   1032a:	02059693          	sll	a3,a1,0x20
   1032e:	8dd5                	or	a1,a1,a3
   10330:	b759                	j	102b6 <memset+0x10>
   10332:	00279693          	sll	a3,a5,0x2
   10336:	00000297          	auipc	t0,0x0
   1033a:	9696                	add	a3,a3,t0
   1033c:	8286                	mv	t0,ra
   1033e:	fa2680e7          	jalr	-94(a3)
   10342:	8096                	mv	ra,t0
   10344:	17c1                	add	a5,a5,-16
   10346:	8f1d                	sub	a4,a4,a5
   10348:	963e                	add	a2,a2,a5
   1034a:	f8c371e3          	bgeu	t1,a2,102cc <memset+0x26>
   1034e:	b79d                	j	102b4 <memset+0xe>

0000000000010350 <__call_exitprocs>:
   10350:	715d                	add	sp,sp,-80
   10352:	f052                	sd	s4,32(sp)
   10354:	f481ba03          	ld	s4,-184(gp) # 11c58 <_global_impure_ptr>
   10358:	f84a                	sd	s2,48(sp)
   1035a:	e486                	sd	ra,72(sp)
   1035c:	1f8a3903          	ld	s2,504(s4)
   10360:	e0a2                	sd	s0,64(sp)
   10362:	fc26                	sd	s1,56(sp)
   10364:	f44e                	sd	s3,40(sp)
   10366:	ec56                	sd	s5,24(sp)
   10368:	e85a                	sd	s6,16(sp)
   1036a:	e45e                	sd	s7,8(sp)
   1036c:	e062                	sd	s8,0(sp)
   1036e:	02090863          	beqz	s2,1039e <__call_exitprocs+0x4e>
   10372:	8b2a                	mv	s6,a0
   10374:	8bae                	mv	s7,a1
   10376:	4a85                	li	s5,1
   10378:	59fd                	li	s3,-1
   1037a:	00892483          	lw	s1,8(s2)
   1037e:	fff4841b          	addw	s0,s1,-1
   10382:	00044e63          	bltz	s0,1039e <__call_exitprocs+0x4e>
   10386:	048e                	sll	s1,s1,0x3
   10388:	94ca                	add	s1,s1,s2
   1038a:	020b8663          	beqz	s7,103b6 <__call_exitprocs+0x66>
   1038e:	2084b783          	ld	a5,520(s1)
   10392:	03778263          	beq	a5,s7,103b6 <__call_exitprocs+0x66>
   10396:	347d                	addw	s0,s0,-1
   10398:	14e1                	add	s1,s1,-8
   1039a:	ff3418e3          	bne	s0,s3,1038a <__call_exitprocs+0x3a>
   1039e:	60a6                	ld	ra,72(sp)
   103a0:	6406                	ld	s0,64(sp)
   103a2:	74e2                	ld	s1,56(sp)
   103a4:	7942                	ld	s2,48(sp)
   103a6:	79a2                	ld	s3,40(sp)
   103a8:	7a02                	ld	s4,32(sp)
   103aa:	6ae2                	ld	s5,24(sp)
   103ac:	6b42                	ld	s6,16(sp)
   103ae:	6ba2                	ld	s7,8(sp)
   103b0:	6c02                	ld	s8,0(sp)
   103b2:	6161                	add	sp,sp,80
   103b4:	8082                	ret
   103b6:	00892783          	lw	a5,8(s2)
   103ba:	6498                	ld	a4,8(s1)
   103bc:	37fd                	addw	a5,a5,-1
   103be:	04878463          	beq	a5,s0,10406 <__call_exitprocs+0xb6>
   103c2:	0004b423          	sd	zero,8(s1)
   103c6:	db61                	beqz	a4,10396 <__call_exitprocs+0x46>
   103c8:	31092783          	lw	a5,784(s2)
   103cc:	008a96bb          	sllw	a3,s5,s0
   103d0:	00892c03          	lw	s8,8(s2)
   103d4:	8ff5                	and	a5,a5,a3
   103d6:	2781                	sext.w	a5,a5
   103d8:	ef89                	bnez	a5,103f2 <__call_exitprocs+0xa2>
   103da:	9702                	jalr	a4
   103dc:	00892703          	lw	a4,8(s2)
   103e0:	1f8a3783          	ld	a5,504(s4)
   103e4:	01871463          	bne	a4,s8,103ec <__call_exitprocs+0x9c>
   103e8:	fb2787e3          	beq	a5,s2,10396 <__call_exitprocs+0x46>
   103ec:	dbcd                	beqz	a5,1039e <__call_exitprocs+0x4e>
   103ee:	893e                	mv	s2,a5
   103f0:	b769                	j	1037a <__call_exitprocs+0x2a>
   103f2:	31492783          	lw	a5,788(s2)
   103f6:	1084b583          	ld	a1,264(s1)
   103fa:	8ff5                	and	a5,a5,a3
   103fc:	2781                	sext.w	a5,a5
   103fe:	e799                	bnez	a5,1040c <__call_exitprocs+0xbc>
   10400:	855a                	mv	a0,s6
   10402:	9702                	jalr	a4
   10404:	bfe1                	j	103dc <__call_exitprocs+0x8c>
   10406:	00892423          	sw	s0,8(s2)
   1040a:	bf75                	j	103c6 <__call_exitprocs+0x76>
   1040c:	852e                	mv	a0,a1
   1040e:	9702                	jalr	a4
   10410:	b7f1                	j	103dc <__call_exitprocs+0x8c>

0000000000010412 <__libc_fini_array>:
   10412:	1101                	add	sp,sp,-32
   10414:	e822                	sd	s0,16(sp)
   10416:	67c5                	lui	a5,0x11
   10418:	6445                	lui	s0,0x11
   1041a:	50878793          	add	a5,a5,1288 # 11508 <__do_global_dtors_aux_fini_array_entry>
   1041e:	51040413          	add	s0,s0,1296 # 11510 <impure_data>
   10422:	8c1d                	sub	s0,s0,a5
   10424:	e426                	sd	s1,8(sp)
   10426:	ec06                	sd	ra,24(sp)
   10428:	40345493          	sra	s1,s0,0x3
   1042c:	c881                	beqz	s1,1043c <__libc_fini_array+0x2a>
   1042e:	1461                	add	s0,s0,-8
   10430:	943e                	add	s0,s0,a5
   10432:	601c                	ld	a5,0(s0)
   10434:	14fd                	add	s1,s1,-1
   10436:	1461                	add	s0,s0,-8
   10438:	9782                	jalr	a5
   1043a:	fce5                	bnez	s1,10432 <__libc_fini_array+0x20>
   1043c:	60e2                	ld	ra,24(sp)
   1043e:	6442                	ld	s0,16(sp)
   10440:	64a2                	ld	s1,8(sp)
   10442:	6105                	add	sp,sp,32
   10444:	8082                	ret

0000000000010446 <atexit>:
   10446:	85aa                	mv	a1,a0
   10448:	4681                	li	a3,0
   1044a:	4601                	li	a2,0
   1044c:	4501                	li	a0,0
   1044e:	a009                	j	10450 <__register_exitproc>

0000000000010450 <__register_exitproc>:
   10450:	f481b703          	ld	a4,-184(gp) # 11c58 <_global_impure_ptr>
   10454:	1f873783          	ld	a5,504(a4)
   10458:	c3b1                	beqz	a5,1049c <__register_exitproc+0x4c>
   1045a:	4798                	lw	a4,8(a5)
   1045c:	487d                	li	a6,31
   1045e:	06e84263          	blt	a6,a4,104c2 <__register_exitproc+0x72>
   10462:	c505                	beqz	a0,1048a <__register_exitproc+0x3a>
   10464:	00371813          	sll	a6,a4,0x3
   10468:	983e                	add	a6,a6,a5
   1046a:	10c83823          	sd	a2,272(a6)
   1046e:	3107a883          	lw	a7,784(a5)
   10472:	4605                	li	a2,1
   10474:	00e6163b          	sllw	a2,a2,a4
   10478:	00c8e8b3          	or	a7,a7,a2
   1047c:	3117a823          	sw	a7,784(a5)
   10480:	20d83823          	sd	a3,528(a6)
   10484:	4689                	li	a3,2
   10486:	02d50063          	beq	a0,a3,104a6 <__register_exitproc+0x56>
   1048a:	00270693          	add	a3,a4,2
   1048e:	068e                	sll	a3,a3,0x3
   10490:	2705                	addw	a4,a4,1
   10492:	c798                	sw	a4,8(a5)
   10494:	97b6                	add	a5,a5,a3
   10496:	e38c                	sd	a1,0(a5)
   10498:	4501                	li	a0,0
   1049a:	8082                	ret
   1049c:	20070793          	add	a5,a4,512
   104a0:	1ef73c23          	sd	a5,504(a4)
   104a4:	bf5d                	j	1045a <__register_exitproc+0xa>
   104a6:	3147a683          	lw	a3,788(a5)
   104aa:	4501                	li	a0,0
   104ac:	8ed1                	or	a3,a3,a2
   104ae:	30d7aa23          	sw	a3,788(a5)
   104b2:	00270693          	add	a3,a4,2
   104b6:	068e                	sll	a3,a3,0x3
   104b8:	2705                	addw	a4,a4,1
   104ba:	c798                	sw	a4,8(a5)
   104bc:	97b6                	add	a5,a5,a3
   104be:	e38c                	sd	a1,0(a5)
   104c0:	8082                	ret
   104c2:	557d                	li	a0,-1
   104c4:	8082                	ret

00000000000104c6 <_exit>:
   104c6:	05d00893          	li	a7,93
   104ca:	00000073          	ecall
   104ce:	00054363          	bltz	a0,104d4 <_exit+0xe>
   104d2:	a001                	j	104d2 <_exit+0xc>
   104d4:	1141                	add	sp,sp,-16
   104d6:	e022                	sd	s0,0(sp)
   104d8:	842a                	mv	s0,a0
   104da:	e406                	sd	ra,8(sp)
   104dc:	4080043b          	negw	s0,s0
   104e0:	008000ef          	jal	104e8 <__errno>
   104e4:	c100                	sw	s0,0(a0)
   104e6:	a001                	j	104e6 <_exit+0x20>

00000000000104e8 <__errno>:
   104e8:	f581b503          	ld	a0,-168(gp) # 11c68 <_impure_ptr>
   104ec:	8082                	ret

lwu.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	348000ef          	jal	1043a <__call_exitprocs>
   100f6:	fc81b503          	ld	a0,-56(gp) # 11dc8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4ae000ef          	jal	105b0 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4fc50513          	add	a0,a0,1276 # 104fc <__libc_fini_array>
   10112:	a939                	j	10530 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cea18193          	add	gp,gp,-790 # 11e00 <__global_pointer$>
   1011e:	fe018513          	add	a0,gp,-32 # 11de0 <completed.1>
   10122:	01818613          	add	a2,gp,24 # 11e18 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	266000ef          	jal	10390 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	40250513          	add	a0,a0,1026 # 10530 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3c450513          	add	a0,a0,964 # 104fc <__libc_fini_array>
   10140:	3f0000ef          	jal	10530 <atexit>
   10144:	1e2000ef          	jal	10326 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fe01c783          	lbu	a5,-32(gp) # 11de0 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5d850513          	add	a0,a0,1496 # 115d8 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fef18023          	sb	a5,-32(gp) # 11de0 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fe818593          	add	a1,gp,-24 # 11de8 <object.0>
   1018e:	5d850513          	add	a0,a0,1496 # 115d8 <__EH_FRAME_BEGIN__>
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
   101b2:	0ff7879b          	addw	a5,a5,255 # ff00ff <__BSS_END__+0xfde2e7>
   101b6:	00001097          	auipc	ra,0x1
   101ba:	44a08093          	add	ra,ra,1098 # 11600 <__DATA_BEGIN__>
   101be:	0000e703          	lwu	a4,0(ra)
   101c2:	00ff03b7          	lui	t2,0xff0
   101c6:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde2e7>
   101ca:	14771663          	bne	a4,t2,10316 <fail>

00000000000101ce <test_3>:
   101ce:	418d                	li	gp,3
   101d0:	67c1                	lui	a5,0x10
   101d2:	f017879b          	addw	a5,a5,-255 # ff01 <exit-0x1e7>
   101d6:	07c2                	sll	a5,a5,0x10
   101d8:	f0078793          	add	a5,a5,-256
   101dc:	00001097          	auipc	ra,0x1
   101e0:	42408093          	add	ra,ra,1060 # 11600 <__DATA_BEGIN__>
   101e4:	0040e703          	lwu	a4,4(ra)
   101e8:	63c1                	lui	t2,0x10
   101ea:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   101ee:	03c2                	sll	t2,t2,0x10
   101f0:	f0038393          	add	t2,t2,-256
   101f4:	12771163          	bne	a4,t2,10316 <fail>

00000000000101f8 <test_4>:
   101f8:	4191                	li	gp,4
   101fa:	0ff017b7          	lui	a5,0xff01
   101fe:	37c1                	addw	a5,a5,-16 # ff00ff0 <__BSS_END__+0xfeef1d8>
   10200:	00001097          	auipc	ra,0x1
   10204:	40008093          	add	ra,ra,1024 # 11600 <__DATA_BEGIN__>
   10208:	0080e703          	lwu	a4,8(ra)
   1020c:	0ff013b7          	lui	t2,0xff01
   10210:	33c1                	addw	t2,t2,-16 # ff00ff0 <__BSS_END__+0xfeef1d8>
   10212:	10771263          	bne	a4,t2,10316 <fail>

0000000000010216 <test_5>:
   10216:	4195                	li	gp,5
   10218:	000f07b7          	lui	a5,0xf0
   1021c:	0ff7879b          	addw	a5,a5,255 # f00ff <__BSS_END__+0xde2e7>
   10220:	07b2                	sll	a5,a5,0xc
   10222:	07bd                	add	a5,a5,15
   10224:	00001097          	auipc	ra,0x1
   10228:	3dc08093          	add	ra,ra,988 # 11600 <__DATA_BEGIN__>
   1022c:	00c0e703          	lwu	a4,12(ra)
   10230:	000f03b7          	lui	t2,0xf0
   10234:	0ff3839b          	addw	t2,t2,255 # f00ff <__BSS_END__+0xde2e7>
   10238:	03b2                	sll	t2,t2,0xc
   1023a:	03bd                	add	t2,t2,15
   1023c:	0c771d63          	bne	a4,t2,10316 <fail>

0000000000010240 <test_6>:
   10240:	4199                	li	gp,6
   10242:	00ff07b7          	lui	a5,0xff0
   10246:	0ff7879b          	addw	a5,a5,255 # ff00ff <__BSS_END__+0xfde2e7>
   1024a:	00001097          	auipc	ra,0x1
   1024e:	3c208093          	add	ra,ra,962 # 1160c <tdat4>
   10252:	ff40e703          	lwu	a4,-12(ra)
   10256:	00ff03b7          	lui	t2,0xff0
   1025a:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde2e7>
   1025e:	0a771c63          	bne	a4,t2,10316 <fail>

0000000000010262 <test_7>:
   10262:	419d                	li	gp,7
   10264:	67c1                	lui	a5,0x10
   10266:	f017879b          	addw	a5,a5,-255 # ff01 <exit-0x1e7>
   1026a:	07c2                	sll	a5,a5,0x10
   1026c:	f0078793          	add	a5,a5,-256
   10270:	00001097          	auipc	ra,0x1
   10274:	39c08093          	add	ra,ra,924 # 1160c <tdat4>
   10278:	ff80e703          	lwu	a4,-8(ra)
   1027c:	63c1                	lui	t2,0x10
   1027e:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   10282:	03c2                	sll	t2,t2,0x10
   10284:	f0038393          	add	t2,t2,-256
   10288:	08771763          	bne	a4,t2,10316 <fail>

000000000001028c <test_8>:
   1028c:	41a1                	li	gp,8
   1028e:	0ff017b7          	lui	a5,0xff01
   10292:	37c1                	addw	a5,a5,-16 # ff00ff0 <__BSS_END__+0xfeef1d8>
   10294:	00001097          	auipc	ra,0x1
   10298:	37808093          	add	ra,ra,888 # 1160c <tdat4>
   1029c:	ffc0e703          	lwu	a4,-4(ra)
   102a0:	0ff013b7          	lui	t2,0xff01
   102a4:	33c1                	addw	t2,t2,-16 # ff00ff0 <__BSS_END__+0xfeef1d8>
   102a6:	06771863          	bne	a4,t2,10316 <fail>

00000000000102aa <test_9>:
   102aa:	41a5                	li	gp,9
   102ac:	000f07b7          	lui	a5,0xf0
   102b0:	0ff7879b          	addw	a5,a5,255 # f00ff <__BSS_END__+0xde2e7>
   102b4:	07b2                	sll	a5,a5,0xc
   102b6:	07bd                	add	a5,a5,15
   102b8:	00001097          	auipc	ra,0x1
   102bc:	35408093          	add	ra,ra,852 # 1160c <tdat4>
   102c0:	0000e703          	lwu	a4,0(ra)
   102c4:	000f03b7          	lui	t2,0xf0
   102c8:	0ff3839b          	addw	t2,t2,255 # f00ff <__BSS_END__+0xde2e7>
   102cc:	03b2                	sll	t2,t2,0xc
   102ce:	03bd                	add	t2,t2,15
   102d0:	04771363          	bne	a4,t2,10316 <fail>

00000000000102d4 <test_10>:
   102d4:	41a9                	li	gp,10
   102d6:	00001097          	auipc	ra,0x1
   102da:	32a08093          	add	ra,ra,810 # 11600 <__DATA_BEGIN__>
   102de:	1081                	add	ra,ra,-32
   102e0:	0200e283          	lwu	t0,32(ra)
   102e4:	00ff03b7          	lui	t2,0xff0
   102e8:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde2e7>
   102ec:	02729563          	bne	t0,t2,10316 <fail>

00000000000102f0 <test_11>:
   102f0:	41ad                	li	gp,11
   102f2:	00001097          	auipc	ra,0x1
   102f6:	30e08093          	add	ra,ra,782 # 11600 <__DATA_BEGIN__>
   102fa:	10f5                	add	ra,ra,-3
   102fc:	0070e283          	lwu	t0,7(ra)
   10300:	63c1                	lui	t2,0x10
   10302:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   10306:	03c2                	sll	t2,t2,0x10
   10308:	f0038393          	add	t2,t2,-256
   1030c:	00729563          	bne	t0,t2,10316 <fail>
   10310:	00301263          	bne	zero,gp,10314 <pass>

0000000000010314 <pass>:
   10314:	a019                	j	1031a <continue>

0000000000010316 <fail>:
   10316:	0000                	unimp
	...

000000000001031a <continue>:
   1031a:	4081                	li	ra,0
   1031c:	4781                	li	a5,0
   1031e:	853e                	mv	a0,a5
   10320:	6462                	ld	s0,24(sp)
   10322:	6105                	add	sp,sp,32
   10324:	8082                	ret

0000000000010326 <__libc_init_array>:
   10326:	1101                	add	sp,sp,-32
   10328:	e822                	sd	s0,16(sp)
   1032a:	67c5                	lui	a5,0x11
   1032c:	6445                	lui	s0,0x11
   1032e:	e04a                	sd	s2,0(sp)
   10330:	5dc78793          	add	a5,a5,1500 # 115dc <__preinit_array_end>
   10334:	5dc40713          	add	a4,s0,1500 # 115dc <__preinit_array_end>
   10338:	ec06                	sd	ra,24(sp)
   1033a:	e426                	sd	s1,8(sp)
   1033c:	40e78933          	sub	s2,a5,a4
   10340:	00e78d63          	beq	a5,a4,1035a <__libc_init_array+0x34>
   10344:	40395913          	sra	s2,s2,0x3
   10348:	5dc40413          	add	s0,s0,1500
   1034c:	4481                	li	s1,0
   1034e:	601c                	ld	a5,0(s0)
   10350:	0485                	add	s1,s1,1
   10352:	0421                	add	s0,s0,8
   10354:	9782                	jalr	a5
   10356:	ff24ece3          	bltu	s1,s2,1034e <__libc_init_array+0x28>
   1035a:	6445                	lui	s0,0x11
   1035c:	67c5                	lui	a5,0x11
   1035e:	5f078793          	add	a5,a5,1520 # 115f0 <__do_global_dtors_aux_fini_array_entry>
   10362:	5e040713          	add	a4,s0,1504 # 115e0 <__init_array_start>
   10366:	40e78933          	sub	s2,a5,a4
   1036a:	40395913          	sra	s2,s2,0x3
   1036e:	00e78b63          	beq	a5,a4,10384 <__libc_init_array+0x5e>
   10372:	5e040413          	add	s0,s0,1504
   10376:	4481                	li	s1,0
   10378:	601c                	ld	a5,0(s0)
   1037a:	0485                	add	s1,s1,1
   1037c:	0421                	add	s0,s0,8
   1037e:	9782                	jalr	a5
   10380:	ff24ece3          	bltu	s1,s2,10378 <__libc_init_array+0x52>
   10384:	60e2                	ld	ra,24(sp)
   10386:	6442                	ld	s0,16(sp)
   10388:	64a2                	ld	s1,8(sp)
   1038a:	6902                	ld	s2,0(sp)
   1038c:	6105                	add	sp,sp,32
   1038e:	8082                	ret

0000000000010390 <memset>:
   10390:	433d                	li	t1,15
   10392:	872a                	mv	a4,a0
   10394:	02c37163          	bgeu	t1,a2,103b6 <memset+0x26>
   10398:	00f77793          	and	a5,a4,15
   1039c:	e3c1                	bnez	a5,1041c <memset+0x8c>
   1039e:	e1bd                	bnez	a1,10404 <memset+0x74>
   103a0:	ff067693          	and	a3,a2,-16
   103a4:	8a3d                	and	a2,a2,15
   103a6:	96ba                	add	a3,a3,a4
   103a8:	e30c                	sd	a1,0(a4)
   103aa:	e70c                	sd	a1,8(a4)
   103ac:	0741                	add	a4,a4,16
   103ae:	fed76de3          	bltu	a4,a3,103a8 <memset+0x18>
   103b2:	e211                	bnez	a2,103b6 <memset+0x26>
   103b4:	8082                	ret
   103b6:	40c306b3          	sub	a3,t1,a2
   103ba:	068a                	sll	a3,a3,0x2
   103bc:	00000297          	auipc	t0,0x0
   103c0:	9696                	add	a3,a3,t0
   103c2:	00a68067          	jr	10(a3)
   103c6:	00b70723          	sb	a1,14(a4)
   103ca:	00b706a3          	sb	a1,13(a4)
   103ce:	00b70623          	sb	a1,12(a4)
   103d2:	00b705a3          	sb	a1,11(a4)
   103d6:	00b70523          	sb	a1,10(a4)
   103da:	00b704a3          	sb	a1,9(a4)
   103de:	00b70423          	sb	a1,8(a4)
   103e2:	00b703a3          	sb	a1,7(a4)
   103e6:	00b70323          	sb	a1,6(a4)
   103ea:	00b702a3          	sb	a1,5(a4)
   103ee:	00b70223          	sb	a1,4(a4)
   103f2:	00b701a3          	sb	a1,3(a4)
   103f6:	00b70123          	sb	a1,2(a4)
   103fa:	00b700a3          	sb	a1,1(a4)
   103fe:	00b70023          	sb	a1,0(a4)
   10402:	8082                	ret
   10404:	0ff5f593          	zext.b	a1,a1
   10408:	00859693          	sll	a3,a1,0x8
   1040c:	8dd5                	or	a1,a1,a3
   1040e:	01059693          	sll	a3,a1,0x10
   10412:	8dd5                	or	a1,a1,a3
   10414:	02059693          	sll	a3,a1,0x20
   10418:	8dd5                	or	a1,a1,a3
   1041a:	b759                	j	103a0 <memset+0x10>
   1041c:	00279693          	sll	a3,a5,0x2
   10420:	00000297          	auipc	t0,0x0
   10424:	9696                	add	a3,a3,t0
   10426:	8286                	mv	t0,ra
   10428:	fa2680e7          	jalr	-94(a3)
   1042c:	8096                	mv	ra,t0
   1042e:	17c1                	add	a5,a5,-16
   10430:	8f1d                	sub	a4,a4,a5
   10432:	963e                	add	a2,a2,a5
   10434:	f8c371e3          	bgeu	t1,a2,103b6 <memset+0x26>
   10438:	b79d                	j	1039e <memset+0xe>

000000000001043a <__call_exitprocs>:
   1043a:	715d                	add	sp,sp,-80
   1043c:	f052                	sd	s4,32(sp)
   1043e:	fc81ba03          	ld	s4,-56(gp) # 11dc8 <_global_impure_ptr>
   10442:	f84a                	sd	s2,48(sp)
   10444:	e486                	sd	ra,72(sp)
   10446:	1f8a3903          	ld	s2,504(s4)
   1044a:	e0a2                	sd	s0,64(sp)
   1044c:	fc26                	sd	s1,56(sp)
   1044e:	f44e                	sd	s3,40(sp)
   10450:	ec56                	sd	s5,24(sp)
   10452:	e85a                	sd	s6,16(sp)
   10454:	e45e                	sd	s7,8(sp)
   10456:	e062                	sd	s8,0(sp)
   10458:	02090863          	beqz	s2,10488 <__call_exitprocs+0x4e>
   1045c:	8b2a                	mv	s6,a0
   1045e:	8bae                	mv	s7,a1
   10460:	4a85                	li	s5,1
   10462:	59fd                	li	s3,-1
   10464:	00892483          	lw	s1,8(s2)
   10468:	fff4841b          	addw	s0,s1,-1
   1046c:	00044e63          	bltz	s0,10488 <__call_exitprocs+0x4e>
   10470:	048e                	sll	s1,s1,0x3
   10472:	94ca                	add	s1,s1,s2
   10474:	020b8663          	beqz	s7,104a0 <__call_exitprocs+0x66>
   10478:	2084b783          	ld	a5,520(s1)
   1047c:	03778263          	beq	a5,s7,104a0 <__call_exitprocs+0x66>
   10480:	347d                	addw	s0,s0,-1
   10482:	14e1                	add	s1,s1,-8
   10484:	ff3418e3          	bne	s0,s3,10474 <__call_exitprocs+0x3a>
   10488:	60a6                	ld	ra,72(sp)
   1048a:	6406                	ld	s0,64(sp)
   1048c:	74e2                	ld	s1,56(sp)
   1048e:	7942                	ld	s2,48(sp)
   10490:	79a2                	ld	s3,40(sp)
   10492:	7a02                	ld	s4,32(sp)
   10494:	6ae2                	ld	s5,24(sp)
   10496:	6b42                	ld	s6,16(sp)
   10498:	6ba2                	ld	s7,8(sp)
   1049a:	6c02                	ld	s8,0(sp)
   1049c:	6161                	add	sp,sp,80
   1049e:	8082                	ret
   104a0:	00892783          	lw	a5,8(s2)
   104a4:	6498                	ld	a4,8(s1)
   104a6:	37fd                	addw	a5,a5,-1
   104a8:	04878463          	beq	a5,s0,104f0 <__call_exitprocs+0xb6>
   104ac:	0004b423          	sd	zero,8(s1)
   104b0:	db61                	beqz	a4,10480 <__call_exitprocs+0x46>
   104b2:	31092783          	lw	a5,784(s2)
   104b6:	008a96bb          	sllw	a3,s5,s0
   104ba:	00892c03          	lw	s8,8(s2)
   104be:	8ff5                	and	a5,a5,a3
   104c0:	2781                	sext.w	a5,a5
   104c2:	ef89                	bnez	a5,104dc <__call_exitprocs+0xa2>
   104c4:	9702                	jalr	a4
   104c6:	00892703          	lw	a4,8(s2)
   104ca:	1f8a3783          	ld	a5,504(s4)
   104ce:	01871463          	bne	a4,s8,104d6 <__call_exitprocs+0x9c>
   104d2:	fb2787e3          	beq	a5,s2,10480 <__call_exitprocs+0x46>
   104d6:	dbcd                	beqz	a5,10488 <__call_exitprocs+0x4e>
   104d8:	893e                	mv	s2,a5
   104da:	b769                	j	10464 <__call_exitprocs+0x2a>
   104dc:	31492783          	lw	a5,788(s2)
   104e0:	1084b583          	ld	a1,264(s1)
   104e4:	8ff5                	and	a5,a5,a3
   104e6:	2781                	sext.w	a5,a5
   104e8:	e799                	bnez	a5,104f6 <__call_exitprocs+0xbc>
   104ea:	855a                	mv	a0,s6
   104ec:	9702                	jalr	a4
   104ee:	bfe1                	j	104c6 <__call_exitprocs+0x8c>
   104f0:	00892423          	sw	s0,8(s2)
   104f4:	bf75                	j	104b0 <__call_exitprocs+0x76>
   104f6:	852e                	mv	a0,a1
   104f8:	9702                	jalr	a4
   104fa:	b7f1                	j	104c6 <__call_exitprocs+0x8c>

00000000000104fc <__libc_fini_array>:
   104fc:	1101                	add	sp,sp,-32
   104fe:	e822                	sd	s0,16(sp)
   10500:	67c5                	lui	a5,0x11
   10502:	6445                	lui	s0,0x11
   10504:	5f078793          	add	a5,a5,1520 # 115f0 <__do_global_dtors_aux_fini_array_entry>
   10508:	5f840413          	add	s0,s0,1528 # 115f8 <__fini_array_end>
   1050c:	8c1d                	sub	s0,s0,a5
   1050e:	e426                	sd	s1,8(sp)
   10510:	ec06                	sd	ra,24(sp)
   10512:	40345493          	sra	s1,s0,0x3
   10516:	c881                	beqz	s1,10526 <__libc_fini_array+0x2a>
   10518:	1461                	add	s0,s0,-8
   1051a:	943e                	add	s0,s0,a5
   1051c:	601c                	ld	a5,0(s0)
   1051e:	14fd                	add	s1,s1,-1
   10520:	1461                	add	s0,s0,-8
   10522:	9782                	jalr	a5
   10524:	fce5                	bnez	s1,1051c <__libc_fini_array+0x20>
   10526:	60e2                	ld	ra,24(sp)
   10528:	6442                	ld	s0,16(sp)
   1052a:	64a2                	ld	s1,8(sp)
   1052c:	6105                	add	sp,sp,32
   1052e:	8082                	ret

0000000000010530 <atexit>:
   10530:	85aa                	mv	a1,a0
   10532:	4681                	li	a3,0
   10534:	4601                	li	a2,0
   10536:	4501                	li	a0,0
   10538:	a009                	j	1053a <__register_exitproc>

000000000001053a <__register_exitproc>:
   1053a:	fc81b703          	ld	a4,-56(gp) # 11dc8 <_global_impure_ptr>
   1053e:	1f873783          	ld	a5,504(a4)
   10542:	c3b1                	beqz	a5,10586 <__register_exitproc+0x4c>
   10544:	4798                	lw	a4,8(a5)
   10546:	487d                	li	a6,31
   10548:	06e84263          	blt	a6,a4,105ac <__register_exitproc+0x72>
   1054c:	c505                	beqz	a0,10574 <__register_exitproc+0x3a>
   1054e:	00371813          	sll	a6,a4,0x3
   10552:	983e                	add	a6,a6,a5
   10554:	10c83823          	sd	a2,272(a6)
   10558:	3107a883          	lw	a7,784(a5)
   1055c:	4605                	li	a2,1
   1055e:	00e6163b          	sllw	a2,a2,a4
   10562:	00c8e8b3          	or	a7,a7,a2
   10566:	3117a823          	sw	a7,784(a5)
   1056a:	20d83823          	sd	a3,528(a6)
   1056e:	4689                	li	a3,2
   10570:	02d50063          	beq	a0,a3,10590 <__register_exitproc+0x56>
   10574:	00270693          	add	a3,a4,2
   10578:	068e                	sll	a3,a3,0x3
   1057a:	2705                	addw	a4,a4,1
   1057c:	c798                	sw	a4,8(a5)
   1057e:	97b6                	add	a5,a5,a3
   10580:	e38c                	sd	a1,0(a5)
   10582:	4501                	li	a0,0
   10584:	8082                	ret
   10586:	20070793          	add	a5,a4,512
   1058a:	1ef73c23          	sd	a5,504(a4)
   1058e:	bf5d                	j	10544 <__register_exitproc+0xa>
   10590:	3147a683          	lw	a3,788(a5)
   10594:	4501                	li	a0,0
   10596:	8ed1                	or	a3,a3,a2
   10598:	30d7aa23          	sw	a3,788(a5)
   1059c:	00270693          	add	a3,a4,2
   105a0:	068e                	sll	a3,a3,0x3
   105a2:	2705                	addw	a4,a4,1
   105a4:	c798                	sw	a4,8(a5)
   105a6:	97b6                	add	a5,a5,a3
   105a8:	e38c                	sd	a1,0(a5)
   105aa:	8082                	ret
   105ac:	557d                	li	a0,-1
   105ae:	8082                	ret

00000000000105b0 <_exit>:
   105b0:	05d00893          	li	a7,93
   105b4:	00000073          	ecall
   105b8:	00054363          	bltz	a0,105be <_exit+0xe>
   105bc:	a001                	j	105bc <_exit+0xc>
   105be:	1141                	add	sp,sp,-16
   105c0:	e022                	sd	s0,0(sp)
   105c2:	842a                	mv	s0,a0
   105c4:	e406                	sd	ra,8(sp)
   105c6:	4080043b          	negw	s0,s0
   105ca:	008000ef          	jal	105d2 <__errno>
   105ce:	c100                	sw	s0,0(a0)
   105d0:	a001                	j	105d0 <_exit+0x20>

00000000000105d2 <__errno>:
   105d2:	fd81b503          	ld	a0,-40(gp) # 11dd8 <_impure_ptr>
   105d6:	8082                	ret

add.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	342000ef          	jal	10434 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d38 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4a8000ef          	jal	105aa <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4f650513          	add	a0,a0,1270 # 104f6 <__libc_fini_array>
   10112:	a921                	j	1052a <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cda18193          	add	gp,gp,-806 # 11df0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d50 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d88 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	260000ef          	jal	1038a <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3fc50513          	add	a0,a0,1020 # 1052a <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3be50513          	add	a0,a0,958 # 104f6 <__libc_fini_array>
   10140:	3ea000ef          	jal	1052a <atexit>
   10144:	1dc000ef          	jal	10320 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d50 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5d450513          	add	a0,a0,1492 # 115d4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d50 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d58 <object.0>
   1018e:	5d450513          	add	a0,a0,1492 # 115d4 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	4101                	li	sp,0
   101b2:	00208733          	add	a4,ra,sp
   101b6:	4381                	li	t2,0
   101b8:	14771c63          	bne	a4,t2,10310 <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	00208733          	add	a4,ra,sp
   101c6:	4389                	li	t2,2
   101c8:	14771463          	bne	a4,t2,10310 <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	408d                	li	ra,3
   101d0:	411d                	li	sp,7
   101d2:	00208733          	add	a4,ra,sp
   101d6:	43a9                	li	t2,10
   101d8:	12771c63          	bne	a4,t2,10310 <fail>

00000000000101dc <test_5>:
   101dc:	4195                	li	gp,5
   101de:	4081                	li	ra,0
   101e0:	ffff8137          	lui	sp,0xffff8
   101e4:	00208733          	add	a4,ra,sp
   101e8:	73e1                	lui	t2,0xffff8
   101ea:	12771363          	bne	a4,t2,10310 <fail>

00000000000101ee <test_6>:
   101ee:	4199                	li	gp,6
   101f0:	800000b7          	lui	ra,0x80000
   101f4:	4101                	li	sp,0
   101f6:	00208733          	add	a4,ra,sp
   101fa:	800003b7          	lui	t2,0x80000
   101fe:	10771963          	bne	a4,t2,10310 <fail>

0000000000010202 <test_7>:
   10202:	419d                	li	gp,7
   10204:	800000b7          	lui	ra,0x80000
   10208:	ffff8137          	lui	sp,0xffff8
   1020c:	00208733          	add	a4,ra,sp
   10210:	73c1                	lui	t2,0xffff0
   10212:	33fd                	addw	t2,t2,-1 # fffffffffffeffff <__global_pointer$+0xfffffffffffde20f>
   10214:	03be                	sll	t2,t2,0xf
   10216:	0e771d63          	bne	a4,t2,10310 <fail>

000000000001021a <test_8>:
   1021a:	41a1                	li	gp,8
   1021c:	4081                	li	ra,0
   1021e:	00008137          	lui	sp,0x8
   10222:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10224:	00208733          	add	a4,ra,sp
   10228:	63a1                	lui	t2,0x8
   1022a:	33fd                	addw	t2,t2,-1 # 7fff <exit-0x80e9>
   1022c:	0e771263          	bne	a4,t2,10310 <fail>

0000000000010230 <test_9>:
   10230:	41a5                	li	gp,9
   10232:	800000b7          	lui	ra,0x80000
   10236:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10238:	4101                	li	sp,0
   1023a:	00208733          	add	a4,ra,sp
   1023e:	800003b7          	lui	t2,0x80000
   10242:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10244:	0c771663          	bne	a4,t2,10310 <fail>

0000000000010248 <test_10>:
   10248:	41a9                	li	gp,10
   1024a:	800000b7          	lui	ra,0x80000
   1024e:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10250:	00008137          	lui	sp,0x8
   10254:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10256:	00208733          	add	a4,ra,sp
   1025a:	63c1                	lui	t2,0x10
   1025c:	2385                	addw	t2,t2,1 # 10001 <exit-0xe7>
   1025e:	03be                	sll	t2,t2,0xf
   10260:	13f9                	add	t2,t2,-2
   10262:	0a771763          	bne	a4,t2,10310 <fail>

0000000000010266 <test_11>:
   10266:	41ad                	li	gp,11
   10268:	800000b7          	lui	ra,0x80000
   1026c:	00008137          	lui	sp,0x8
   10270:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10272:	00208733          	add	a4,ra,sp
   10276:	800083b7          	lui	t2,0x80008
   1027a:	33fd                	addw	t2,t2,-1 # ffffffff80007fff <__global_pointer$+0xffffffff7fff620f>
   1027c:	08771a63          	bne	a4,t2,10310 <fail>

0000000000010280 <test_12>:
   10280:	41b1                	li	gp,12
   10282:	800000b7          	lui	ra,0x80000
   10286:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10288:	ffff8137          	lui	sp,0xffff8
   1028c:	00208733          	add	a4,ra,sp
   10290:	7fff83b7          	lui	t2,0x7fff8
   10294:	33fd                	addw	t2,t2,-1 # 7fff7fff <__global_pointer$+0x7ffe620f>
   10296:	06771d63          	bne	a4,t2,10310 <fail>

000000000001029a <test_13>:
   1029a:	41b5                	li	gp,13
   1029c:	4081                	li	ra,0
   1029e:	517d                	li	sp,-1
   102a0:	00208733          	add	a4,ra,sp
   102a4:	53fd                	li	t2,-1
   102a6:	06771563          	bne	a4,t2,10310 <fail>

00000000000102aa <test_14>:
   102aa:	41b9                	li	gp,14
   102ac:	50fd                	li	ra,-1
   102ae:	4105                	li	sp,1
   102b0:	00208733          	add	a4,ra,sp
   102b4:	4381                	li	t2,0
   102b6:	04771d63          	bne	a4,t2,10310 <fail>

00000000000102ba <test_15>:
   102ba:	41bd                	li	gp,15
   102bc:	50fd                	li	ra,-1
   102be:	517d                	li	sp,-1
   102c0:	00208733          	add	a4,ra,sp
   102c4:	53f9                	li	t2,-2
   102c6:	04771563          	bne	a4,t2,10310 <fail>

00000000000102ca <test_16>:
   102ca:	41c1                	li	gp,16
   102cc:	4085                	li	ra,1
   102ce:	80000137          	lui	sp,0x80000
   102d2:	317d                	addw	sp,sp,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   102d4:	00208733          	add	a4,ra,sp
   102d8:	0010039b          	addw	t2,zero,1
   102dc:	03fe                	sll	t2,t2,0x1f
   102de:	02771963          	bne	a4,t2,10310 <fail>

00000000000102e2 <test_17>:
   102e2:	41c5                	li	gp,17
   102e4:	40b5                	li	ra,13
   102e6:	412d                	li	sp,11
   102e8:	908a                	add	ra,ra,sp
   102ea:	43e1                	li	t2,24
   102ec:	02709263          	bne	ra,t2,10310 <fail>

00000000000102f0 <test_18>:
   102f0:	41c9                	li	gp,18
   102f2:	40b9                	li	ra,14
   102f4:	412d                	li	sp,11
   102f6:	9106                	add	sp,sp,ra
   102f8:	43e5                	li	t2,25
   102fa:	00711b63          	bne	sp,t2,10310 <fail>

00000000000102fe <test_19>:
   102fe:	41cd                	li	gp,19
   10300:	40b5                	li	ra,13
   10302:	9086                	add	ra,ra,ra
   10304:	43e9                	li	t2,26
   10306:	00709563          	bne	ra,t2,10310 <fail>
   1030a:	00301263          	bne	zero,gp,1030e <pass>

000000000001030e <pass>:
   1030e:	a019                	j	10314 <continue>

0000000000010310 <fail>:
   10310:	0000                	unimp
	...

0000000000010314 <continue>:
   10314:	4081                	li	ra,0
   10316:	4781                	li	a5,0
   10318:	853e                	mv	a0,a5
   1031a:	6462                	ld	s0,24(sp)
   1031c:	6105                	add	sp,sp,32
   1031e:	8082                	ret

0000000000010320 <__libc_init_array>:
   10320:	1101                	add	sp,sp,-32
   10322:	e822                	sd	s0,16(sp)
   10324:	67c5                	lui	a5,0x11
   10326:	6445                	lui	s0,0x11
   10328:	e04a                	sd	s2,0(sp)
   1032a:	5d878793          	add	a5,a5,1496 # 115d8 <__init_array_start>
   1032e:	5d840713          	add	a4,s0,1496 # 115d8 <__init_array_start>
   10332:	ec06                	sd	ra,24(sp)
   10334:	e426                	sd	s1,8(sp)
   10336:	40e78933          	sub	s2,a5,a4
   1033a:	00e78d63          	beq	a5,a4,10354 <__libc_init_array+0x34>
   1033e:	40395913          	sra	s2,s2,0x3
   10342:	5d840413          	add	s0,s0,1496
   10346:	4481                	li	s1,0
   10348:	601c                	ld	a5,0(s0)
   1034a:	0485                	add	s1,s1,1
   1034c:	0421                	add	s0,s0,8
   1034e:	9782                	jalr	a5
   10350:	ff24ece3          	bltu	s1,s2,10348 <__libc_init_array+0x28>
   10354:	6445                	lui	s0,0x11
   10356:	67c5                	lui	a5,0x11
   10358:	5e878793          	add	a5,a5,1512 # 115e8 <__do_global_dtors_aux_fini_array_entry>
   1035c:	5d840713          	add	a4,s0,1496 # 115d8 <__init_array_start>
   10360:	40e78933          	sub	s2,a5,a4
   10364:	40395913          	sra	s2,s2,0x3
   10368:	00e78b63          	beq	a5,a4,1037e <__libc_init_array+0x5e>
   1036c:	5d840413          	add	s0,s0,1496
   10370:	4481                	li	s1,0
   10372:	601c                	ld	a5,0(s0)
   10374:	0485                	add	s1,s1,1
   10376:	0421                	add	s0,s0,8
   10378:	9782                	jalr	a5
   1037a:	ff24ece3          	bltu	s1,s2,10372 <__libc_init_array+0x52>
   1037e:	60e2                	ld	ra,24(sp)
   10380:	6442                	ld	s0,16(sp)
   10382:	64a2                	ld	s1,8(sp)
   10384:	6902                	ld	s2,0(sp)
   10386:	6105                	add	sp,sp,32
   10388:	8082                	ret

000000000001038a <memset>:
   1038a:	433d                	li	t1,15
   1038c:	872a                	mv	a4,a0
   1038e:	02c37163          	bgeu	t1,a2,103b0 <memset+0x26>
   10392:	00f77793          	and	a5,a4,15
   10396:	e3c1                	bnez	a5,10416 <memset+0x8c>
   10398:	e1bd                	bnez	a1,103fe <memset+0x74>
   1039a:	ff067693          	and	a3,a2,-16
   1039e:	8a3d                	and	a2,a2,15
   103a0:	96ba                	add	a3,a3,a4
   103a2:	e30c                	sd	a1,0(a4)
   103a4:	e70c                	sd	a1,8(a4)
   103a6:	0741                	add	a4,a4,16
   103a8:	fed76de3          	bltu	a4,a3,103a2 <memset+0x18>
   103ac:	e211                	bnez	a2,103b0 <memset+0x26>
   103ae:	8082                	ret
   103b0:	40c306b3          	sub	a3,t1,a2
   103b4:	068a                	sll	a3,a3,0x2
   103b6:	00000297          	auipc	t0,0x0
   103ba:	9696                	add	a3,a3,t0
   103bc:	00a68067          	jr	10(a3)
   103c0:	00b70723          	sb	a1,14(a4)
   103c4:	00b706a3          	sb	a1,13(a4)
   103c8:	00b70623          	sb	a1,12(a4)
   103cc:	00b705a3          	sb	a1,11(a4)
   103d0:	00b70523          	sb	a1,10(a4)
   103d4:	00b704a3          	sb	a1,9(a4)
   103d8:	00b70423          	sb	a1,8(a4)
   103dc:	00b703a3          	sb	a1,7(a4)
   103e0:	00b70323          	sb	a1,6(a4)
   103e4:	00b702a3          	sb	a1,5(a4)
   103e8:	00b70223          	sb	a1,4(a4)
   103ec:	00b701a3          	sb	a1,3(a4)
   103f0:	00b70123          	sb	a1,2(a4)
   103f4:	00b700a3          	sb	a1,1(a4)
   103f8:	00b70023          	sb	a1,0(a4)
   103fc:	8082                	ret
   103fe:	0ff5f593          	zext.b	a1,a1
   10402:	00859693          	sll	a3,a1,0x8
   10406:	8dd5                	or	a1,a1,a3
   10408:	01059693          	sll	a3,a1,0x10
   1040c:	8dd5                	or	a1,a1,a3
   1040e:	02059693          	sll	a3,a1,0x20
   10412:	8dd5                	or	a1,a1,a3
   10414:	b759                	j	1039a <memset+0x10>
   10416:	00279693          	sll	a3,a5,0x2
   1041a:	00000297          	auipc	t0,0x0
   1041e:	9696                	add	a3,a3,t0
   10420:	8286                	mv	t0,ra
   10422:	fa2680e7          	jalr	-94(a3)
   10426:	8096                	mv	ra,t0
   10428:	17c1                	add	a5,a5,-16
   1042a:	8f1d                	sub	a4,a4,a5
   1042c:	963e                	add	a2,a2,a5
   1042e:	f8c371e3          	bgeu	t1,a2,103b0 <memset+0x26>
   10432:	b79d                	j	10398 <memset+0xe>

0000000000010434 <__call_exitprocs>:
   10434:	715d                	add	sp,sp,-80
   10436:	f052                	sd	s4,32(sp)
   10438:	f481ba03          	ld	s4,-184(gp) # 11d38 <_global_impure_ptr>
   1043c:	f84a                	sd	s2,48(sp)
   1043e:	e486                	sd	ra,72(sp)
   10440:	1f8a3903          	ld	s2,504(s4)
   10444:	e0a2                	sd	s0,64(sp)
   10446:	fc26                	sd	s1,56(sp)
   10448:	f44e                	sd	s3,40(sp)
   1044a:	ec56                	sd	s5,24(sp)
   1044c:	e85a                	sd	s6,16(sp)
   1044e:	e45e                	sd	s7,8(sp)
   10450:	e062                	sd	s8,0(sp)
   10452:	02090863          	beqz	s2,10482 <__call_exitprocs+0x4e>
   10456:	8b2a                	mv	s6,a0
   10458:	8bae                	mv	s7,a1
   1045a:	4a85                	li	s5,1
   1045c:	59fd                	li	s3,-1
   1045e:	00892483          	lw	s1,8(s2)
   10462:	fff4841b          	addw	s0,s1,-1
   10466:	00044e63          	bltz	s0,10482 <__call_exitprocs+0x4e>
   1046a:	048e                	sll	s1,s1,0x3
   1046c:	94ca                	add	s1,s1,s2
   1046e:	020b8663          	beqz	s7,1049a <__call_exitprocs+0x66>
   10472:	2084b783          	ld	a5,520(s1)
   10476:	03778263          	beq	a5,s7,1049a <__call_exitprocs+0x66>
   1047a:	347d                	addw	s0,s0,-1
   1047c:	14e1                	add	s1,s1,-8
   1047e:	ff3418e3          	bne	s0,s3,1046e <__call_exitprocs+0x3a>
   10482:	60a6                	ld	ra,72(sp)
   10484:	6406                	ld	s0,64(sp)
   10486:	74e2                	ld	s1,56(sp)
   10488:	7942                	ld	s2,48(sp)
   1048a:	79a2                	ld	s3,40(sp)
   1048c:	7a02                	ld	s4,32(sp)
   1048e:	6ae2                	ld	s5,24(sp)
   10490:	6b42                	ld	s6,16(sp)
   10492:	6ba2                	ld	s7,8(sp)
   10494:	6c02                	ld	s8,0(sp)
   10496:	6161                	add	sp,sp,80
   10498:	8082                	ret
   1049a:	00892783          	lw	a5,8(s2)
   1049e:	6498                	ld	a4,8(s1)
   104a0:	37fd                	addw	a5,a5,-1
   104a2:	04878463          	beq	a5,s0,104ea <__call_exitprocs+0xb6>
   104a6:	0004b423          	sd	zero,8(s1)
   104aa:	db61                	beqz	a4,1047a <__call_exitprocs+0x46>
   104ac:	31092783          	lw	a5,784(s2)
   104b0:	008a96bb          	sllw	a3,s5,s0
   104b4:	00892c03          	lw	s8,8(s2)
   104b8:	8ff5                	and	a5,a5,a3
   104ba:	2781                	sext.w	a5,a5
   104bc:	ef89                	bnez	a5,104d6 <__call_exitprocs+0xa2>
   104be:	9702                	jalr	a4
   104c0:	00892703          	lw	a4,8(s2)
   104c4:	1f8a3783          	ld	a5,504(s4)
   104c8:	01871463          	bne	a4,s8,104d0 <__call_exitprocs+0x9c>
   104cc:	fb2787e3          	beq	a5,s2,1047a <__call_exitprocs+0x46>
   104d0:	dbcd                	beqz	a5,10482 <__call_exitprocs+0x4e>
   104d2:	893e                	mv	s2,a5
   104d4:	b769                	j	1045e <__call_exitprocs+0x2a>
   104d6:	31492783          	lw	a5,788(s2)
   104da:	1084b583          	ld	a1,264(s1)
   104de:	8ff5                	and	a5,a5,a3
   104e0:	2781                	sext.w	a5,a5
   104e2:	e799                	bnez	a5,104f0 <__call_exitprocs+0xbc>
   104e4:	855a                	mv	a0,s6
   104e6:	9702                	jalr	a4
   104e8:	bfe1                	j	104c0 <__call_exitprocs+0x8c>
   104ea:	00892423          	sw	s0,8(s2)
   104ee:	bf75                	j	104aa <__call_exitprocs+0x76>
   104f0:	852e                	mv	a0,a1
   104f2:	9702                	jalr	a4
   104f4:	b7f1                	j	104c0 <__call_exitprocs+0x8c>

00000000000104f6 <__libc_fini_array>:
   104f6:	1101                	add	sp,sp,-32
   104f8:	e822                	sd	s0,16(sp)
   104fa:	67c5                	lui	a5,0x11
   104fc:	6445                	lui	s0,0x11
   104fe:	5e878793          	add	a5,a5,1512 # 115e8 <__do_global_dtors_aux_fini_array_entry>
   10502:	5f040413          	add	s0,s0,1520 # 115f0 <impure_data>
   10506:	8c1d                	sub	s0,s0,a5
   10508:	e426                	sd	s1,8(sp)
   1050a:	ec06                	sd	ra,24(sp)
   1050c:	40345493          	sra	s1,s0,0x3
   10510:	c881                	beqz	s1,10520 <__libc_fini_array+0x2a>
   10512:	1461                	add	s0,s0,-8
   10514:	943e                	add	s0,s0,a5
   10516:	601c                	ld	a5,0(s0)
   10518:	14fd                	add	s1,s1,-1
   1051a:	1461                	add	s0,s0,-8
   1051c:	9782                	jalr	a5
   1051e:	fce5                	bnez	s1,10516 <__libc_fini_array+0x20>
   10520:	60e2                	ld	ra,24(sp)
   10522:	6442                	ld	s0,16(sp)
   10524:	64a2                	ld	s1,8(sp)
   10526:	6105                	add	sp,sp,32
   10528:	8082                	ret

000000000001052a <atexit>:
   1052a:	85aa                	mv	a1,a0
   1052c:	4681                	li	a3,0
   1052e:	4601                	li	a2,0
   10530:	4501                	li	a0,0
   10532:	a009                	j	10534 <__register_exitproc>

0000000000010534 <__register_exitproc>:
   10534:	f481b703          	ld	a4,-184(gp) # 11d38 <_global_impure_ptr>
   10538:	1f873783          	ld	a5,504(a4)
   1053c:	c3b1                	beqz	a5,10580 <__register_exitproc+0x4c>
   1053e:	4798                	lw	a4,8(a5)
   10540:	487d                	li	a6,31
   10542:	06e84263          	blt	a6,a4,105a6 <__register_exitproc+0x72>
   10546:	c505                	beqz	a0,1056e <__register_exitproc+0x3a>
   10548:	00371813          	sll	a6,a4,0x3
   1054c:	983e                	add	a6,a6,a5
   1054e:	10c83823          	sd	a2,272(a6)
   10552:	3107a883          	lw	a7,784(a5)
   10556:	4605                	li	a2,1
   10558:	00e6163b          	sllw	a2,a2,a4
   1055c:	00c8e8b3          	or	a7,a7,a2
   10560:	3117a823          	sw	a7,784(a5)
   10564:	20d83823          	sd	a3,528(a6)
   10568:	4689                	li	a3,2
   1056a:	02d50063          	beq	a0,a3,1058a <__register_exitproc+0x56>
   1056e:	00270693          	add	a3,a4,2
   10572:	068e                	sll	a3,a3,0x3
   10574:	2705                	addw	a4,a4,1
   10576:	c798                	sw	a4,8(a5)
   10578:	97b6                	add	a5,a5,a3
   1057a:	e38c                	sd	a1,0(a5)
   1057c:	4501                	li	a0,0
   1057e:	8082                	ret
   10580:	20070793          	add	a5,a4,512
   10584:	1ef73c23          	sd	a5,504(a4)
   10588:	bf5d                	j	1053e <__register_exitproc+0xa>
   1058a:	3147a683          	lw	a3,788(a5)
   1058e:	4501                	li	a0,0
   10590:	8ed1                	or	a3,a3,a2
   10592:	30d7aa23          	sw	a3,788(a5)
   10596:	00270693          	add	a3,a4,2
   1059a:	068e                	sll	a3,a3,0x3
   1059c:	2705                	addw	a4,a4,1
   1059e:	c798                	sw	a4,8(a5)
   105a0:	97b6                	add	a5,a5,a3
   105a2:	e38c                	sd	a1,0(a5)
   105a4:	8082                	ret
   105a6:	557d                	li	a0,-1
   105a8:	8082                	ret

00000000000105aa <_exit>:
   105aa:	05d00893          	li	a7,93
   105ae:	00000073          	ecall
   105b2:	00054363          	bltz	a0,105b8 <_exit+0xe>
   105b6:	a001                	j	105b6 <_exit+0xc>
   105b8:	1141                	add	sp,sp,-16
   105ba:	e022                	sd	s0,0(sp)
   105bc:	842a                	mv	s0,a0
   105be:	e406                	sd	ra,8(sp)
   105c0:	4080043b          	negw	s0,s0
   105c4:	008000ef          	jal	105cc <__errno>
   105c8:	c100                	sw	s0,0(a0)
   105ca:	a001                	j	105ca <_exit+0x20>

00000000000105cc <__errno>:
   105cc:	f581b503          	ld	a0,-168(gp) # 11d48 <_impure_ptr>
   105d0:	8082                	ret

srlw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	472000ef          	jal	10564 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11e68 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	5d8000ef          	jal	106da <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	62650513          	add	a0,a0,1574 # 10626 <__libc_fini_array>
   10112:	a3a1                	j	1065a <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	e0a18193          	add	gp,gp,-502 # 11f20 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11e80 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11eb8 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	390000ef          	jal	104ba <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	52c50513          	add	a0,a0,1324 # 1065a <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	4ee50513          	add	a0,a0,1262 # 10626 <__libc_fini_array>
   10140:	51a000ef          	jal	1065a <atexit>
   10144:	30c000ef          	jal	10450 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11e80 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	70450513          	add	a0,a0,1796 # 11704 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11e80 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11e88 <object.0>
   1018e:	70450513          	add	a0,a0,1796 # 11704 <__EH_FRAME_BEGIN__>
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
   101ae:	800000b7          	lui	ra,0x80000
   101b2:	4101                	li	sp,0
   101b4:	0020d73b          	srlw	a4,ra,sp
   101b8:	800003b7          	lui	t2,0x80000
   101bc:	28771263          	bne	a4,t2,10440 <fail>

00000000000101c0 <test_3>:
   101c0:	418d                	li	gp,3
   101c2:	800000b7          	lui	ra,0x80000
   101c6:	4105                	li	sp,1
   101c8:	0020d73b          	srlw	a4,ra,sp
   101cc:	400003b7          	lui	t2,0x40000
   101d0:	26771863          	bne	a4,t2,10440 <fail>

00000000000101d4 <test_4>:
   101d4:	4191                	li	gp,4
   101d6:	800000b7          	lui	ra,0x80000
   101da:	411d                	li	sp,7
   101dc:	0020d73b          	srlw	a4,ra,sp
   101e0:	010003b7          	lui	t2,0x1000
   101e4:	24771e63          	bne	a4,t2,10440 <fail>

00000000000101e8 <test_5>:
   101e8:	4195                	li	gp,5
   101ea:	800000b7          	lui	ra,0x80000
   101ee:	4139                	li	sp,14
   101f0:	0020d73b          	srlw	a4,ra,sp
   101f4:	000203b7          	lui	t2,0x20
   101f8:	24771463          	bne	a4,t2,10440 <fail>

00000000000101fc <test_6>:
   101fc:	4199                	li	gp,6
   101fe:	800000b7          	lui	ra,0x80000
   10202:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee0e1>
   10204:	417d                	li	sp,31
   10206:	0020d73b          	srlw	a4,ra,sp
   1020a:	4385                	li	t2,1
   1020c:	22771a63          	bne	a4,t2,10440 <fail>

0000000000010210 <test_7>:
   10210:	419d                	li	gp,7
   10212:	50fd                	li	ra,-1
   10214:	4101                	li	sp,0
   10216:	0020d73b          	srlw	a4,ra,sp
   1021a:	53fd                	li	t2,-1
   1021c:	22771263          	bne	a4,t2,10440 <fail>

0000000000010220 <test_8>:
   10220:	41a1                	li	gp,8
   10222:	50fd                	li	ra,-1
   10224:	4105                	li	sp,1
   10226:	0020d73b          	srlw	a4,ra,sp
   1022a:	800003b7          	lui	t2,0x80000
   1022e:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee0df>
   10230:	20771863          	bne	a4,t2,10440 <fail>

0000000000010234 <test_9>:
   10234:	41a5                	li	gp,9
   10236:	50fd                	li	ra,-1
   10238:	411d                	li	sp,7
   1023a:	0020d73b          	srlw	a4,ra,sp
   1023e:	020003b7          	lui	t2,0x2000
   10242:	33fd                	addw	t2,t2,-1 # 1ffffff <__global_pointer$+0x1fee0df>
   10244:	1e771e63          	bne	a4,t2,10440 <fail>

0000000000010248 <test_10>:
   10248:	41a9                	li	gp,10
   1024a:	50fd                	li	ra,-1
   1024c:	4139                	li	sp,14
   1024e:	0020d73b          	srlw	a4,ra,sp
   10252:	000403b7          	lui	t2,0x40
   10256:	33fd                	addw	t2,t2,-1 # 3ffff <__global_pointer$+0x2e0df>
   10258:	1e771463          	bne	a4,t2,10440 <fail>

000000000001025c <test_11>:
   1025c:	41ad                	li	gp,11
   1025e:	50fd                	li	ra,-1
   10260:	417d                	li	sp,31
   10262:	0020d73b          	srlw	a4,ra,sp
   10266:	4385                	li	t2,1
   10268:	1c771c63          	bne	a4,t2,10440 <fail>

000000000001026c <test_12>:
   1026c:	41b1                	li	gp,12
   1026e:	212120b7          	lui	ra,0x21212
   10272:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   10276:	4101                	li	sp,0
   10278:	0020d73b          	srlw	a4,ra,sp
   1027c:	212123b7          	lui	t2,0x21212
   10280:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200201>
   10284:	1a771e63          	bne	a4,t2,10440 <fail>

0000000000010288 <test_13>:
   10288:	41b5                	li	gp,13
   1028a:	212120b7          	lui	ra,0x21212
   1028e:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   10292:	4105                	li	sp,1
   10294:	0020d73b          	srlw	a4,ra,sp
   10298:	109093b7          	lui	t2,0x10909
   1029c:	0903839b          	addw	t2,t2,144 # 10909090 <__global_pointer$+0x108f7170>
   102a0:	1a771063          	bne	a4,t2,10440 <fail>

00000000000102a4 <test_14>:
   102a4:	41b9                	li	gp,14
   102a6:	212120b7          	lui	ra,0x21212
   102aa:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   102ae:	411d                	li	sp,7
   102b0:	0020d73b          	srlw	a4,ra,sp
   102b4:	004243b7          	lui	t2,0x424
   102b8:	2423839b          	addw	t2,t2,578 # 424242 <__global_pointer$+0x412322>
   102bc:	18771263          	bne	a4,t2,10440 <fail>

00000000000102c0 <test_15>:
   102c0:	41bd                	li	gp,15
   102c2:	212120b7          	lui	ra,0x21212
   102c6:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   102ca:	4139                	li	sp,14
   102cc:	0020d73b          	srlw	a4,ra,sp
   102d0:	63a1                	lui	t2,0x8
   102d2:	4843839b          	addw	t2,t2,1156 # 8484 <exit-0x7c64>
   102d6:	16771563          	bne	a4,t2,10440 <fail>

00000000000102da <test_16>:
   102da:	41c1                	li	gp,16
   102dc:	212120b7          	lui	ra,0x21212
   102e0:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   102e4:	417d                	li	sp,31
   102e6:	0020d73b          	srlw	a4,ra,sp
   102ea:	4381                	li	t2,0
   102ec:	14771a63          	bne	a4,t2,10440 <fail>

00000000000102f0 <test_17>:
   102f0:	41c5                	li	gp,17
   102f2:	212120b7          	lui	ra,0x21212
   102f6:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   102fa:	5101                	li	sp,-32
   102fc:	0020d73b          	srlw	a4,ra,sp
   10300:	212123b7          	lui	t2,0x21212
   10304:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200201>
   10308:	12771c63          	bne	a4,t2,10440 <fail>

000000000001030c <test_18>:
   1030c:	41c9                	li	gp,18
   1030e:	212120b7          	lui	ra,0x21212
   10312:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   10316:	5105                	li	sp,-31
   10318:	0020d73b          	srlw	a4,ra,sp
   1031c:	109093b7          	lui	t2,0x10909
   10320:	0903839b          	addw	t2,t2,144 # 10909090 <__global_pointer$+0x108f7170>
   10324:	10771e63          	bne	a4,t2,10440 <fail>

0000000000010328 <test_19>:
   10328:	41cd                	li	gp,19
   1032a:	212120b7          	lui	ra,0x21212
   1032e:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   10332:	511d                	li	sp,-25
   10334:	0020d73b          	srlw	a4,ra,sp
   10338:	004243b7          	lui	t2,0x424
   1033c:	2423839b          	addw	t2,t2,578 # 424242 <__global_pointer$+0x412322>
   10340:	10771063          	bne	a4,t2,10440 <fail>

0000000000010344 <test_20>:
   10344:	41d1                	li	gp,20
   10346:	212120b7          	lui	ra,0x21212
   1034a:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   1034e:	5139                	li	sp,-18
   10350:	0020d73b          	srlw	a4,ra,sp
   10354:	63a1                	lui	t2,0x8
   10356:	4843839b          	addw	t2,t2,1156 # 8484 <exit-0x7c64>
   1035a:	0e771363          	bne	a4,t2,10440 <fail>

000000000001035e <test_21>:
   1035e:	41d5                	li	gp,21
   10360:	212120b7          	lui	ra,0x21212
   10364:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200201>
   10368:	517d                	li	sp,-1
   1036a:	0020d73b          	srlw	a4,ra,sp
   1036e:	4381                	li	t2,0
   10370:	0c771863          	bne	a4,t2,10440 <fail>

0000000000010374 <test_44>:
   10374:	02c00193          	li	gp,44
   10378:	fff120b7          	lui	ra,0xfff12
   1037c:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00425>
   10380:	00b2                	sll	ra,ra,0xc
   10382:	67808093          	add	ra,ra,1656
   10386:	4101                	li	sp,0
   10388:	0020d73b          	srlw	a4,ra,sp
   1038c:	123453b7          	lui	t2,0x12345
   10390:	6783839b          	addw	t2,t2,1656 # 12345678 <__global_pointer$+0x12333758>
   10394:	0a771663          	bne	a4,t2,10440 <fail>

0000000000010398 <test_45>:
   10398:	02d00193          	li	gp,45
   1039c:	fff120b7          	lui	ra,0xfff12
   103a0:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff00425>
   103a4:	00b2                	sll	ra,ra,0xc
   103a6:	67808093          	add	ra,ra,1656
   103aa:	4111                	li	sp,4
   103ac:	0020d73b          	srlw	a4,ra,sp
   103b0:	012343b7          	lui	t2,0x1234
   103b4:	5673839b          	addw	t2,t2,1383 # 1234567 <__global_pointer$+0x1222647>
   103b8:	08771463          	bne	a4,t2,10440 <fail>

00000000000103bc <test_46>:
   103bc:	02e00193          	li	gp,46
   103c0:	000920b7          	lui	ra,0x92
   103c4:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80425>
   103c8:	00b2                	sll	ra,ra,0xc
   103ca:	67808093          	add	ra,ra,1656
   103ce:	4101                	li	sp,0
   103d0:	0020d73b          	srlw	a4,ra,sp
   103d4:	923453b7          	lui	t2,0x92345
   103d8:	6783839b          	addw	t2,t2,1656 # ffffffff92345678 <__global_pointer$+0xffffffff92333758>
   103dc:	06771263          	bne	a4,t2,10440 <fail>

00000000000103e0 <test_47>:
   103e0:	02f00193          	li	gp,47
   103e4:	000920b7          	lui	ra,0x92
   103e8:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x80425>
   103ec:	00b2                	sll	ra,ra,0xc
   103ee:	67808093          	add	ra,ra,1656
   103f2:	4111                	li	sp,4
   103f4:	0020d73b          	srlw	a4,ra,sp
   103f8:	092343b7          	lui	t2,0x9234
   103fc:	5673839b          	addw	t2,t2,1383 # 9234567 <__global_pointer$+0x9222647>
   10400:	04771063          	bne	a4,t2,10440 <fail>

0000000000010404 <test_22>:
   10404:	41d9                	li	gp,22
   10406:	800000b7          	lui	ra,0x80000
   1040a:	411d                	li	sp,7
   1040c:	0020d0bb          	srlw	ra,ra,sp
   10410:	010003b7          	lui	t2,0x1000
   10414:	02709663          	bne	ra,t2,10440 <fail>

0000000000010418 <test_23>:
   10418:	41dd                	li	gp,23
   1041a:	800000b7          	lui	ra,0x80000
   1041e:	4139                	li	sp,14
   10420:	0020d13b          	srlw	sp,ra,sp
   10424:	000203b7          	lui	t2,0x20
   10428:	00711c63          	bne	sp,t2,10440 <fail>

000000000001042c <test_24>:
   1042c:	41e1                	li	gp,24
   1042e:	409d                	li	ra,7
   10430:	0010d0bb          	srlw	ra,ra,ra
   10434:	4381                	li	t2,0
   10436:	00709563          	bne	ra,t2,10440 <fail>
   1043a:	00301263          	bne	zero,gp,1043e <pass>

000000000001043e <pass>:
   1043e:	a019                	j	10444 <continue>

0000000000010440 <fail>:
   10440:	0000                	unimp
	...

0000000000010444 <continue>:
   10444:	4081                	li	ra,0
   10446:	4781                	li	a5,0
   10448:	853e                	mv	a0,a5
   1044a:	6462                	ld	s0,24(sp)
   1044c:	6105                	add	sp,sp,32
   1044e:	8082                	ret

0000000000010450 <__libc_init_array>:
   10450:	1101                	add	sp,sp,-32
   10452:	e822                	sd	s0,16(sp)
   10454:	67c5                	lui	a5,0x11
   10456:	6445                	lui	s0,0x11
   10458:	e04a                	sd	s2,0(sp)
   1045a:	70878793          	add	a5,a5,1800 # 11708 <__init_array_start>
   1045e:	70840713          	add	a4,s0,1800 # 11708 <__init_array_start>
   10462:	ec06                	sd	ra,24(sp)
   10464:	e426                	sd	s1,8(sp)
   10466:	40e78933          	sub	s2,a5,a4
   1046a:	00e78d63          	beq	a5,a4,10484 <__libc_init_array+0x34>
   1046e:	40395913          	sra	s2,s2,0x3
   10472:	70840413          	add	s0,s0,1800
   10476:	4481                	li	s1,0
   10478:	601c                	ld	a5,0(s0)
   1047a:	0485                	add	s1,s1,1
   1047c:	0421                	add	s0,s0,8
   1047e:	9782                	jalr	a5
   10480:	ff24ece3          	bltu	s1,s2,10478 <__libc_init_array+0x28>
   10484:	6445                	lui	s0,0x11
   10486:	67c5                	lui	a5,0x11
   10488:	71878793          	add	a5,a5,1816 # 11718 <__do_global_dtors_aux_fini_array_entry>
   1048c:	70840713          	add	a4,s0,1800 # 11708 <__init_array_start>
   10490:	40e78933          	sub	s2,a5,a4
   10494:	40395913          	sra	s2,s2,0x3
   10498:	00e78b63          	beq	a5,a4,104ae <__libc_init_array+0x5e>
   1049c:	70840413          	add	s0,s0,1800
   104a0:	4481                	li	s1,0
   104a2:	601c                	ld	a5,0(s0)
   104a4:	0485                	add	s1,s1,1
   104a6:	0421                	add	s0,s0,8
   104a8:	9782                	jalr	a5
   104aa:	ff24ece3          	bltu	s1,s2,104a2 <__libc_init_array+0x52>
   104ae:	60e2                	ld	ra,24(sp)
   104b0:	6442                	ld	s0,16(sp)
   104b2:	64a2                	ld	s1,8(sp)
   104b4:	6902                	ld	s2,0(sp)
   104b6:	6105                	add	sp,sp,32
   104b8:	8082                	ret

00000000000104ba <memset>:
   104ba:	433d                	li	t1,15
   104bc:	872a                	mv	a4,a0
   104be:	02c37163          	bgeu	t1,a2,104e0 <memset+0x26>
   104c2:	00f77793          	and	a5,a4,15
   104c6:	e3c1                	bnez	a5,10546 <memset+0x8c>
   104c8:	e1bd                	bnez	a1,1052e <memset+0x74>
   104ca:	ff067693          	and	a3,a2,-16
   104ce:	8a3d                	and	a2,a2,15
   104d0:	96ba                	add	a3,a3,a4
   104d2:	e30c                	sd	a1,0(a4)
   104d4:	e70c                	sd	a1,8(a4)
   104d6:	0741                	add	a4,a4,16
   104d8:	fed76de3          	bltu	a4,a3,104d2 <memset+0x18>
   104dc:	e211                	bnez	a2,104e0 <memset+0x26>
   104de:	8082                	ret
   104e0:	40c306b3          	sub	a3,t1,a2
   104e4:	068a                	sll	a3,a3,0x2
   104e6:	00000297          	auipc	t0,0x0
   104ea:	9696                	add	a3,a3,t0
   104ec:	00a68067          	jr	10(a3)
   104f0:	00b70723          	sb	a1,14(a4)
   104f4:	00b706a3          	sb	a1,13(a4)
   104f8:	00b70623          	sb	a1,12(a4)
   104fc:	00b705a3          	sb	a1,11(a4)
   10500:	00b70523          	sb	a1,10(a4)
   10504:	00b704a3          	sb	a1,9(a4)
   10508:	00b70423          	sb	a1,8(a4)
   1050c:	00b703a3          	sb	a1,7(a4)
   10510:	00b70323          	sb	a1,6(a4)
   10514:	00b702a3          	sb	a1,5(a4)
   10518:	00b70223          	sb	a1,4(a4)
   1051c:	00b701a3          	sb	a1,3(a4)
   10520:	00b70123          	sb	a1,2(a4)
   10524:	00b700a3          	sb	a1,1(a4)
   10528:	00b70023          	sb	a1,0(a4)
   1052c:	8082                	ret
   1052e:	0ff5f593          	zext.b	a1,a1
   10532:	00859693          	sll	a3,a1,0x8
   10536:	8dd5                	or	a1,a1,a3
   10538:	01059693          	sll	a3,a1,0x10
   1053c:	8dd5                	or	a1,a1,a3
   1053e:	02059693          	sll	a3,a1,0x20
   10542:	8dd5                	or	a1,a1,a3
   10544:	b759                	j	104ca <memset+0x10>
   10546:	00279693          	sll	a3,a5,0x2
   1054a:	00000297          	auipc	t0,0x0
   1054e:	9696                	add	a3,a3,t0
   10550:	8286                	mv	t0,ra
   10552:	fa2680e7          	jalr	-94(a3)
   10556:	8096                	mv	ra,t0
   10558:	17c1                	add	a5,a5,-16
   1055a:	8f1d                	sub	a4,a4,a5
   1055c:	963e                	add	a2,a2,a5
   1055e:	f8c371e3          	bgeu	t1,a2,104e0 <memset+0x26>
   10562:	b79d                	j	104c8 <memset+0xe>

0000000000010564 <__call_exitprocs>:
   10564:	715d                	add	sp,sp,-80
   10566:	f052                	sd	s4,32(sp)
   10568:	f481ba03          	ld	s4,-184(gp) # 11e68 <_global_impure_ptr>
   1056c:	f84a                	sd	s2,48(sp)
   1056e:	e486                	sd	ra,72(sp)
   10570:	1f8a3903          	ld	s2,504(s4)
   10574:	e0a2                	sd	s0,64(sp)
   10576:	fc26                	sd	s1,56(sp)
   10578:	f44e                	sd	s3,40(sp)
   1057a:	ec56                	sd	s5,24(sp)
   1057c:	e85a                	sd	s6,16(sp)
   1057e:	e45e                	sd	s7,8(sp)
   10580:	e062                	sd	s8,0(sp)
   10582:	02090863          	beqz	s2,105b2 <__call_exitprocs+0x4e>
   10586:	8b2a                	mv	s6,a0
   10588:	8bae                	mv	s7,a1
   1058a:	4a85                	li	s5,1
   1058c:	59fd                	li	s3,-1
   1058e:	00892483          	lw	s1,8(s2)
   10592:	fff4841b          	addw	s0,s1,-1
   10596:	00044e63          	bltz	s0,105b2 <__call_exitprocs+0x4e>
   1059a:	048e                	sll	s1,s1,0x3
   1059c:	94ca                	add	s1,s1,s2
   1059e:	020b8663          	beqz	s7,105ca <__call_exitprocs+0x66>
   105a2:	2084b783          	ld	a5,520(s1)
   105a6:	03778263          	beq	a5,s7,105ca <__call_exitprocs+0x66>
   105aa:	347d                	addw	s0,s0,-1
   105ac:	14e1                	add	s1,s1,-8
   105ae:	ff3418e3          	bne	s0,s3,1059e <__call_exitprocs+0x3a>
   105b2:	60a6                	ld	ra,72(sp)
   105b4:	6406                	ld	s0,64(sp)
   105b6:	74e2                	ld	s1,56(sp)
   105b8:	7942                	ld	s2,48(sp)
   105ba:	79a2                	ld	s3,40(sp)
   105bc:	7a02                	ld	s4,32(sp)
   105be:	6ae2                	ld	s5,24(sp)
   105c0:	6b42                	ld	s6,16(sp)
   105c2:	6ba2                	ld	s7,8(sp)
   105c4:	6c02                	ld	s8,0(sp)
   105c6:	6161                	add	sp,sp,80
   105c8:	8082                	ret
   105ca:	00892783          	lw	a5,8(s2)
   105ce:	6498                	ld	a4,8(s1)
   105d0:	37fd                	addw	a5,a5,-1
   105d2:	04878463          	beq	a5,s0,1061a <__call_exitprocs+0xb6>
   105d6:	0004b423          	sd	zero,8(s1)
   105da:	db61                	beqz	a4,105aa <__call_exitprocs+0x46>
   105dc:	31092783          	lw	a5,784(s2)
   105e0:	008a96bb          	sllw	a3,s5,s0
   105e4:	00892c03          	lw	s8,8(s2)
   105e8:	8ff5                	and	a5,a5,a3
   105ea:	2781                	sext.w	a5,a5
   105ec:	ef89                	bnez	a5,10606 <__call_exitprocs+0xa2>
   105ee:	9702                	jalr	a4
   105f0:	00892703          	lw	a4,8(s2)
   105f4:	1f8a3783          	ld	a5,504(s4)
   105f8:	01871463          	bne	a4,s8,10600 <__call_exitprocs+0x9c>
   105fc:	fb2787e3          	beq	a5,s2,105aa <__call_exitprocs+0x46>
   10600:	dbcd                	beqz	a5,105b2 <__call_exitprocs+0x4e>
   10602:	893e                	mv	s2,a5
   10604:	b769                	j	1058e <__call_exitprocs+0x2a>
   10606:	31492783          	lw	a5,788(s2)
   1060a:	1084b583          	ld	a1,264(s1)
   1060e:	8ff5                	and	a5,a5,a3
   10610:	2781                	sext.w	a5,a5
   10612:	e799                	bnez	a5,10620 <__call_exitprocs+0xbc>
   10614:	855a                	mv	a0,s6
   10616:	9702                	jalr	a4
   10618:	bfe1                	j	105f0 <__call_exitprocs+0x8c>
   1061a:	00892423          	sw	s0,8(s2)
   1061e:	bf75                	j	105da <__call_exitprocs+0x76>
   10620:	852e                	mv	a0,a1
   10622:	9702                	jalr	a4
   10624:	b7f1                	j	105f0 <__call_exitprocs+0x8c>

0000000000010626 <__libc_fini_array>:
   10626:	1101                	add	sp,sp,-32
   10628:	e822                	sd	s0,16(sp)
   1062a:	67c5                	lui	a5,0x11
   1062c:	6445                	lui	s0,0x11
   1062e:	71878793          	add	a5,a5,1816 # 11718 <__do_global_dtors_aux_fini_array_entry>
   10632:	72040413          	add	s0,s0,1824 # 11720 <impure_data>
   10636:	8c1d                	sub	s0,s0,a5
   10638:	e426                	sd	s1,8(sp)
   1063a:	ec06                	sd	ra,24(sp)
   1063c:	40345493          	sra	s1,s0,0x3
   10640:	c881                	beqz	s1,10650 <__libc_fini_array+0x2a>
   10642:	1461                	add	s0,s0,-8
   10644:	943e                	add	s0,s0,a5
   10646:	601c                	ld	a5,0(s0)
   10648:	14fd                	add	s1,s1,-1
   1064a:	1461                	add	s0,s0,-8
   1064c:	9782                	jalr	a5
   1064e:	fce5                	bnez	s1,10646 <__libc_fini_array+0x20>
   10650:	60e2                	ld	ra,24(sp)
   10652:	6442                	ld	s0,16(sp)
   10654:	64a2                	ld	s1,8(sp)
   10656:	6105                	add	sp,sp,32
   10658:	8082                	ret

000000000001065a <atexit>:
   1065a:	85aa                	mv	a1,a0
   1065c:	4681                	li	a3,0
   1065e:	4601                	li	a2,0
   10660:	4501                	li	a0,0
   10662:	a009                	j	10664 <__register_exitproc>

0000000000010664 <__register_exitproc>:
   10664:	f481b703          	ld	a4,-184(gp) # 11e68 <_global_impure_ptr>
   10668:	1f873783          	ld	a5,504(a4)
   1066c:	c3b1                	beqz	a5,106b0 <__register_exitproc+0x4c>
   1066e:	4798                	lw	a4,8(a5)
   10670:	487d                	li	a6,31
   10672:	06e84263          	blt	a6,a4,106d6 <__register_exitproc+0x72>
   10676:	c505                	beqz	a0,1069e <__register_exitproc+0x3a>
   10678:	00371813          	sll	a6,a4,0x3
   1067c:	983e                	add	a6,a6,a5
   1067e:	10c83823          	sd	a2,272(a6)
   10682:	3107a883          	lw	a7,784(a5)
   10686:	4605                	li	a2,1
   10688:	00e6163b          	sllw	a2,a2,a4
   1068c:	00c8e8b3          	or	a7,a7,a2
   10690:	3117a823          	sw	a7,784(a5)
   10694:	20d83823          	sd	a3,528(a6)
   10698:	4689                	li	a3,2
   1069a:	02d50063          	beq	a0,a3,106ba <__register_exitproc+0x56>
   1069e:	00270693          	add	a3,a4,2
   106a2:	068e                	sll	a3,a3,0x3
   106a4:	2705                	addw	a4,a4,1
   106a6:	c798                	sw	a4,8(a5)
   106a8:	97b6                	add	a5,a5,a3
   106aa:	e38c                	sd	a1,0(a5)
   106ac:	4501                	li	a0,0
   106ae:	8082                	ret
   106b0:	20070793          	add	a5,a4,512
   106b4:	1ef73c23          	sd	a5,504(a4)
   106b8:	bf5d                	j	1066e <__register_exitproc+0xa>
   106ba:	3147a683          	lw	a3,788(a5)
   106be:	4501                	li	a0,0
   106c0:	8ed1                	or	a3,a3,a2
   106c2:	30d7aa23          	sw	a3,788(a5)
   106c6:	00270693          	add	a3,a4,2
   106ca:	068e                	sll	a3,a3,0x3
   106cc:	2705                	addw	a4,a4,1
   106ce:	c798                	sw	a4,8(a5)
   106d0:	97b6                	add	a5,a5,a3
   106d2:	e38c                	sd	a1,0(a5)
   106d4:	8082                	ret
   106d6:	557d                	li	a0,-1
   106d8:	8082                	ret

00000000000106da <_exit>:
   106da:	05d00893          	li	a7,93
   106de:	00000073          	ecall
   106e2:	00054363          	bltz	a0,106e8 <_exit+0xe>
   106e6:	a001                	j	106e6 <_exit+0xc>
   106e8:	1141                	add	sp,sp,-16
   106ea:	e022                	sd	s0,0(sp)
   106ec:	842a                	mv	s0,a0
   106ee:	e406                	sd	ra,8(sp)
   106f0:	4080043b          	negw	s0,s0
   106f4:	008000ef          	jal	106fc <__errno>
   106f8:	c100                	sw	s0,0(a0)
   106fa:	a001                	j	106fa <_exit+0x20>

00000000000106fc <__errno>:
   106fc:	f581b503          	ld	a0,-168(gp) # 11e78 <_impure_ptr>
   10700:	8082                	ret

sltu.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	350000ef          	jal	10442 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4b6000ef          	jal	105b8 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	50450513          	add	a0,a0,1284 # 10504 <__libc_fini_array>
   10112:	a11d                	j	10538 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cea18193          	add	gp,gp,-790 # 11e00 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d60 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	26e000ef          	jal	10398 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	40a50513          	add	a0,a0,1034 # 10538 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3cc50513          	add	a0,a0,972 # 10504 <__libc_fini_array>
   10140:	3f8000ef          	jal	10538 <atexit>
   10144:	1ea000ef          	jal	1032e <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5e050513          	add	a0,a0,1504 # 115e0 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d68 <object.0>
   1018e:	5e050513          	add	a0,a0,1504 # 115e0 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	4101                	li	sp,0
   101b2:	0020b733          	sltu	a4,ra,sp
   101b6:	4381                	li	t2,0
   101b8:	16771363          	bne	a4,t2,1031e <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	0020b733          	sltu	a4,ra,sp
   101c6:	4381                	li	t2,0
   101c8:	14771b63          	bne	a4,t2,1031e <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	408d                	li	ra,3
   101d0:	411d                	li	sp,7
   101d2:	0020b733          	sltu	a4,ra,sp
   101d6:	4385                	li	t2,1
   101d8:	14771363          	bne	a4,t2,1031e <fail>

00000000000101dc <test_5>:
   101dc:	4195                	li	gp,5
   101de:	409d                	li	ra,7
   101e0:	410d                	li	sp,3
   101e2:	0020b733          	sltu	a4,ra,sp
   101e6:	4381                	li	t2,0
   101e8:	12771b63          	bne	a4,t2,1031e <fail>

00000000000101ec <test_6>:
   101ec:	4199                	li	gp,6
   101ee:	4081                	li	ra,0
   101f0:	00020137          	lui	sp,0x20
   101f4:	317d                	addw	sp,sp,-1 # 1ffff <__global_pointer$+0xe1ff>
   101f6:	013e                	sll	sp,sp,0xf
   101f8:	0020b733          	sltu	a4,ra,sp
   101fc:	4385                	li	t2,1
   101fe:	12771063          	bne	a4,t2,1031e <fail>

0000000000010202 <test_7>:
   10202:	419d                	li	gp,7
   10204:	0010009b          	addw	ra,zero,1
   10208:	00fe                	sll	ra,ra,0x1f
   1020a:	4101                	li	sp,0
   1020c:	0020b733          	sltu	a4,ra,sp
   10210:	4381                	li	t2,0
   10212:	10771663          	bne	a4,t2,1031e <fail>

0000000000010216 <test_8>:
   10216:	41a1                	li	gp,8
   10218:	0010009b          	addw	ra,zero,1
   1021c:	00fe                	sll	ra,ra,0x1f
   1021e:	00020137          	lui	sp,0x20
   10222:	317d                	addw	sp,sp,-1 # 1ffff <__global_pointer$+0xe1ff>
   10224:	013e                	sll	sp,sp,0xf
   10226:	0020b733          	sltu	a4,ra,sp
   1022a:	4385                	li	t2,1
   1022c:	0e771963          	bne	a4,t2,1031e <fail>

0000000000010230 <test_9>:
   10230:	41a5                	li	gp,9
   10232:	4081                	li	ra,0
   10234:	00008137          	lui	sp,0x8
   10238:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1023a:	0020b733          	sltu	a4,ra,sp
   1023e:	4385                	li	t2,1
   10240:	0c771f63          	bne	a4,t2,1031e <fail>

0000000000010244 <test_10>:
   10244:	41a9                	li	gp,10
   10246:	800000b7          	lui	ra,0x80000
   1024a:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1ff>
   1024c:	4101                	li	sp,0
   1024e:	0020b733          	sltu	a4,ra,sp
   10252:	4381                	li	t2,0
   10254:	0c771563          	bne	a4,t2,1031e <fail>

0000000000010258 <test_11>:
   10258:	41ad                	li	gp,11
   1025a:	800000b7          	lui	ra,0x80000
   1025e:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1ff>
   10260:	00008137          	lui	sp,0x8
   10264:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10266:	0020b733          	sltu	a4,ra,sp
   1026a:	4381                	li	t2,0
   1026c:	0a771963          	bne	a4,t2,1031e <fail>

0000000000010270 <test_12>:
   10270:	41b1                	li	gp,12
   10272:	0010009b          	addw	ra,zero,1
   10276:	00fe                	sll	ra,ra,0x1f
   10278:	00008137          	lui	sp,0x8
   1027c:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1027e:	0020b733          	sltu	a4,ra,sp
   10282:	4381                	li	t2,0
   10284:	08771d63          	bne	a4,t2,1031e <fail>

0000000000010288 <test_13>:
   10288:	41b5                	li	gp,13
   1028a:	800000b7          	lui	ra,0x80000
   1028e:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1ff>
   10290:	00020137          	lui	sp,0x20
   10294:	317d                	addw	sp,sp,-1 # 1ffff <__global_pointer$+0xe1ff>
   10296:	013e                	sll	sp,sp,0xf
   10298:	0020b733          	sltu	a4,ra,sp
   1029c:	4385                	li	t2,1
   1029e:	08771063          	bne	a4,t2,1031e <fail>

00000000000102a2 <test_14>:
   102a2:	41b9                	li	gp,14
   102a4:	4081                	li	ra,0
   102a6:	0010011b          	addw	sp,zero,1
   102aa:	1102                	sll	sp,sp,0x20
   102ac:	117d                	add	sp,sp,-1
   102ae:	0020b733          	sltu	a4,ra,sp
   102b2:	4385                	li	t2,1
   102b4:	06771563          	bne	a4,t2,1031e <fail>

00000000000102b8 <test_15>:
   102b8:	41bd                	li	gp,15
   102ba:	0010009b          	addw	ra,zero,1
   102be:	1082                	sll	ra,ra,0x20
   102c0:	10fd                	add	ra,ra,-1
   102c2:	4105                	li	sp,1
   102c4:	0020b733          	sltu	a4,ra,sp
   102c8:	4381                	li	t2,0
   102ca:	04771a63          	bne	a4,t2,1031e <fail>

00000000000102ce <test_16>:
   102ce:	41c1                	li	gp,16
   102d0:	0010009b          	addw	ra,zero,1
   102d4:	1082                	sll	ra,ra,0x20
   102d6:	10fd                	add	ra,ra,-1
   102d8:	0010011b          	addw	sp,zero,1
   102dc:	1102                	sll	sp,sp,0x20
   102de:	117d                	add	sp,sp,-1
   102e0:	0020b733          	sltu	a4,ra,sp
   102e4:	4381                	li	t2,0
   102e6:	02771c63          	bne	a4,t2,1031e <fail>

00000000000102ea <test_17>:
   102ea:	41c5                	li	gp,17
   102ec:	40b9                	li	ra,14
   102ee:	4135                	li	sp,13
   102f0:	0020b0b3          	sltu	ra,ra,sp
   102f4:	4381                	li	t2,0
   102f6:	02709463          	bne	ra,t2,1031e <fail>

00000000000102fa <test_18>:
   102fa:	41c9                	li	gp,18
   102fc:	40ad                	li	ra,11
   102fe:	4135                	li	sp,13
   10300:	0020b133          	sltu	sp,ra,sp
   10304:	4385                	li	t2,1
   10306:	00711c63          	bne	sp,t2,1031e <fail>

000000000001030a <test_19>:
   1030a:	41cd                	li	gp,19
   1030c:	40b5                	li	ra,13
   1030e:	0010b0b3          	sltu	ra,ra,ra
   10312:	4381                	li	t2,0
   10314:	00709563          	bne	ra,t2,1031e <fail>
   10318:	00301263          	bne	zero,gp,1031c <pass>

000000000001031c <pass>:
   1031c:	a019                	j	10322 <continue>

000000000001031e <fail>:
   1031e:	0000                	unimp
	...

0000000000010322 <continue>:
   10322:	4081                	li	ra,0
   10324:	4781                	li	a5,0
   10326:	853e                	mv	a0,a5
   10328:	6462                	ld	s0,24(sp)
   1032a:	6105                	add	sp,sp,32
   1032c:	8082                	ret

000000000001032e <__libc_init_array>:
   1032e:	1101                	add	sp,sp,-32
   10330:	e822                	sd	s0,16(sp)
   10332:	67c5                	lui	a5,0x11
   10334:	6445                	lui	s0,0x11
   10336:	e04a                	sd	s2,0(sp)
   10338:	5e478793          	add	a5,a5,1508 # 115e4 <__preinit_array_end>
   1033c:	5e440713          	add	a4,s0,1508 # 115e4 <__preinit_array_end>
   10340:	ec06                	sd	ra,24(sp)
   10342:	e426                	sd	s1,8(sp)
   10344:	40e78933          	sub	s2,a5,a4
   10348:	00e78d63          	beq	a5,a4,10362 <__libc_init_array+0x34>
   1034c:	40395913          	sra	s2,s2,0x3
   10350:	5e440413          	add	s0,s0,1508
   10354:	4481                	li	s1,0
   10356:	601c                	ld	a5,0(s0)
   10358:	0485                	add	s1,s1,1
   1035a:	0421                	add	s0,s0,8
   1035c:	9782                	jalr	a5
   1035e:	ff24ece3          	bltu	s1,s2,10356 <__libc_init_array+0x28>
   10362:	6445                	lui	s0,0x11
   10364:	67c5                	lui	a5,0x11
   10366:	5f878793          	add	a5,a5,1528 # 115f8 <__do_global_dtors_aux_fini_array_entry>
   1036a:	5e840713          	add	a4,s0,1512 # 115e8 <__init_array_start>
   1036e:	40e78933          	sub	s2,a5,a4
   10372:	40395913          	sra	s2,s2,0x3
   10376:	00e78b63          	beq	a5,a4,1038c <__libc_init_array+0x5e>
   1037a:	5e840413          	add	s0,s0,1512
   1037e:	4481                	li	s1,0
   10380:	601c                	ld	a5,0(s0)
   10382:	0485                	add	s1,s1,1
   10384:	0421                	add	s0,s0,8
   10386:	9782                	jalr	a5
   10388:	ff24ece3          	bltu	s1,s2,10380 <__libc_init_array+0x52>
   1038c:	60e2                	ld	ra,24(sp)
   1038e:	6442                	ld	s0,16(sp)
   10390:	64a2                	ld	s1,8(sp)
   10392:	6902                	ld	s2,0(sp)
   10394:	6105                	add	sp,sp,32
   10396:	8082                	ret

0000000000010398 <memset>:
   10398:	433d                	li	t1,15
   1039a:	872a                	mv	a4,a0
   1039c:	02c37163          	bgeu	t1,a2,103be <memset+0x26>
   103a0:	00f77793          	and	a5,a4,15
   103a4:	e3c1                	bnez	a5,10424 <memset+0x8c>
   103a6:	e1bd                	bnez	a1,1040c <memset+0x74>
   103a8:	ff067693          	and	a3,a2,-16
   103ac:	8a3d                	and	a2,a2,15
   103ae:	96ba                	add	a3,a3,a4
   103b0:	e30c                	sd	a1,0(a4)
   103b2:	e70c                	sd	a1,8(a4)
   103b4:	0741                	add	a4,a4,16
   103b6:	fed76de3          	bltu	a4,a3,103b0 <memset+0x18>
   103ba:	e211                	bnez	a2,103be <memset+0x26>
   103bc:	8082                	ret
   103be:	40c306b3          	sub	a3,t1,a2
   103c2:	068a                	sll	a3,a3,0x2
   103c4:	00000297          	auipc	t0,0x0
   103c8:	9696                	add	a3,a3,t0
   103ca:	00a68067          	jr	10(a3)
   103ce:	00b70723          	sb	a1,14(a4)
   103d2:	00b706a3          	sb	a1,13(a4)
   103d6:	00b70623          	sb	a1,12(a4)
   103da:	00b705a3          	sb	a1,11(a4)
   103de:	00b70523          	sb	a1,10(a4)
   103e2:	00b704a3          	sb	a1,9(a4)
   103e6:	00b70423          	sb	a1,8(a4)
   103ea:	00b703a3          	sb	a1,7(a4)
   103ee:	00b70323          	sb	a1,6(a4)
   103f2:	00b702a3          	sb	a1,5(a4)
   103f6:	00b70223          	sb	a1,4(a4)
   103fa:	00b701a3          	sb	a1,3(a4)
   103fe:	00b70123          	sb	a1,2(a4)
   10402:	00b700a3          	sb	a1,1(a4)
   10406:	00b70023          	sb	a1,0(a4)
   1040a:	8082                	ret
   1040c:	0ff5f593          	zext.b	a1,a1
   10410:	00859693          	sll	a3,a1,0x8
   10414:	8dd5                	or	a1,a1,a3
   10416:	01059693          	sll	a3,a1,0x10
   1041a:	8dd5                	or	a1,a1,a3
   1041c:	02059693          	sll	a3,a1,0x20
   10420:	8dd5                	or	a1,a1,a3
   10422:	b759                	j	103a8 <memset+0x10>
   10424:	00279693          	sll	a3,a5,0x2
   10428:	00000297          	auipc	t0,0x0
   1042c:	9696                	add	a3,a3,t0
   1042e:	8286                	mv	t0,ra
   10430:	fa2680e7          	jalr	-94(a3)
   10434:	8096                	mv	ra,t0
   10436:	17c1                	add	a5,a5,-16
   10438:	8f1d                	sub	a4,a4,a5
   1043a:	963e                	add	a2,a2,a5
   1043c:	f8c371e3          	bgeu	t1,a2,103be <memset+0x26>
   10440:	b79d                	j	103a6 <memset+0xe>

0000000000010442 <__call_exitprocs>:
   10442:	715d                	add	sp,sp,-80
   10444:	f052                	sd	s4,32(sp)
   10446:	f481ba03          	ld	s4,-184(gp) # 11d48 <_global_impure_ptr>
   1044a:	f84a                	sd	s2,48(sp)
   1044c:	e486                	sd	ra,72(sp)
   1044e:	1f8a3903          	ld	s2,504(s4)
   10452:	e0a2                	sd	s0,64(sp)
   10454:	fc26                	sd	s1,56(sp)
   10456:	f44e                	sd	s3,40(sp)
   10458:	ec56                	sd	s5,24(sp)
   1045a:	e85a                	sd	s6,16(sp)
   1045c:	e45e                	sd	s7,8(sp)
   1045e:	e062                	sd	s8,0(sp)
   10460:	02090863          	beqz	s2,10490 <__call_exitprocs+0x4e>
   10464:	8b2a                	mv	s6,a0
   10466:	8bae                	mv	s7,a1
   10468:	4a85                	li	s5,1
   1046a:	59fd                	li	s3,-1
   1046c:	00892483          	lw	s1,8(s2)
   10470:	fff4841b          	addw	s0,s1,-1
   10474:	00044e63          	bltz	s0,10490 <__call_exitprocs+0x4e>
   10478:	048e                	sll	s1,s1,0x3
   1047a:	94ca                	add	s1,s1,s2
   1047c:	020b8663          	beqz	s7,104a8 <__call_exitprocs+0x66>
   10480:	2084b783          	ld	a5,520(s1)
   10484:	03778263          	beq	a5,s7,104a8 <__call_exitprocs+0x66>
   10488:	347d                	addw	s0,s0,-1
   1048a:	14e1                	add	s1,s1,-8
   1048c:	ff3418e3          	bne	s0,s3,1047c <__call_exitprocs+0x3a>
   10490:	60a6                	ld	ra,72(sp)
   10492:	6406                	ld	s0,64(sp)
   10494:	74e2                	ld	s1,56(sp)
   10496:	7942                	ld	s2,48(sp)
   10498:	79a2                	ld	s3,40(sp)
   1049a:	7a02                	ld	s4,32(sp)
   1049c:	6ae2                	ld	s5,24(sp)
   1049e:	6b42                	ld	s6,16(sp)
   104a0:	6ba2                	ld	s7,8(sp)
   104a2:	6c02                	ld	s8,0(sp)
   104a4:	6161                	add	sp,sp,80
   104a6:	8082                	ret
   104a8:	00892783          	lw	a5,8(s2)
   104ac:	6498                	ld	a4,8(s1)
   104ae:	37fd                	addw	a5,a5,-1
   104b0:	04878463          	beq	a5,s0,104f8 <__call_exitprocs+0xb6>
   104b4:	0004b423          	sd	zero,8(s1)
   104b8:	db61                	beqz	a4,10488 <__call_exitprocs+0x46>
   104ba:	31092783          	lw	a5,784(s2)
   104be:	008a96bb          	sllw	a3,s5,s0
   104c2:	00892c03          	lw	s8,8(s2)
   104c6:	8ff5                	and	a5,a5,a3
   104c8:	2781                	sext.w	a5,a5
   104ca:	ef89                	bnez	a5,104e4 <__call_exitprocs+0xa2>
   104cc:	9702                	jalr	a4
   104ce:	00892703          	lw	a4,8(s2)
   104d2:	1f8a3783          	ld	a5,504(s4)
   104d6:	01871463          	bne	a4,s8,104de <__call_exitprocs+0x9c>
   104da:	fb2787e3          	beq	a5,s2,10488 <__call_exitprocs+0x46>
   104de:	dbcd                	beqz	a5,10490 <__call_exitprocs+0x4e>
   104e0:	893e                	mv	s2,a5
   104e2:	b769                	j	1046c <__call_exitprocs+0x2a>
   104e4:	31492783          	lw	a5,788(s2)
   104e8:	1084b583          	ld	a1,264(s1)
   104ec:	8ff5                	and	a5,a5,a3
   104ee:	2781                	sext.w	a5,a5
   104f0:	e799                	bnez	a5,104fe <__call_exitprocs+0xbc>
   104f2:	855a                	mv	a0,s6
   104f4:	9702                	jalr	a4
   104f6:	bfe1                	j	104ce <__call_exitprocs+0x8c>
   104f8:	00892423          	sw	s0,8(s2)
   104fc:	bf75                	j	104b8 <__call_exitprocs+0x76>
   104fe:	852e                	mv	a0,a1
   10500:	9702                	jalr	a4
   10502:	b7f1                	j	104ce <__call_exitprocs+0x8c>

0000000000010504 <__libc_fini_array>:
   10504:	1101                	add	sp,sp,-32
   10506:	e822                	sd	s0,16(sp)
   10508:	67c5                	lui	a5,0x11
   1050a:	6445                	lui	s0,0x11
   1050c:	5f878793          	add	a5,a5,1528 # 115f8 <__do_global_dtors_aux_fini_array_entry>
   10510:	60040413          	add	s0,s0,1536 # 11600 <impure_data>
   10514:	8c1d                	sub	s0,s0,a5
   10516:	e426                	sd	s1,8(sp)
   10518:	ec06                	sd	ra,24(sp)
   1051a:	40345493          	sra	s1,s0,0x3
   1051e:	c881                	beqz	s1,1052e <__libc_fini_array+0x2a>
   10520:	1461                	add	s0,s0,-8
   10522:	943e                	add	s0,s0,a5
   10524:	601c                	ld	a5,0(s0)
   10526:	14fd                	add	s1,s1,-1
   10528:	1461                	add	s0,s0,-8
   1052a:	9782                	jalr	a5
   1052c:	fce5                	bnez	s1,10524 <__libc_fini_array+0x20>
   1052e:	60e2                	ld	ra,24(sp)
   10530:	6442                	ld	s0,16(sp)
   10532:	64a2                	ld	s1,8(sp)
   10534:	6105                	add	sp,sp,32
   10536:	8082                	ret

0000000000010538 <atexit>:
   10538:	85aa                	mv	a1,a0
   1053a:	4681                	li	a3,0
   1053c:	4601                	li	a2,0
   1053e:	4501                	li	a0,0
   10540:	a009                	j	10542 <__register_exitproc>

0000000000010542 <__register_exitproc>:
   10542:	f481b703          	ld	a4,-184(gp) # 11d48 <_global_impure_ptr>
   10546:	1f873783          	ld	a5,504(a4)
   1054a:	c3b1                	beqz	a5,1058e <__register_exitproc+0x4c>
   1054c:	4798                	lw	a4,8(a5)
   1054e:	487d                	li	a6,31
   10550:	06e84263          	blt	a6,a4,105b4 <__register_exitproc+0x72>
   10554:	c505                	beqz	a0,1057c <__register_exitproc+0x3a>
   10556:	00371813          	sll	a6,a4,0x3
   1055a:	983e                	add	a6,a6,a5
   1055c:	10c83823          	sd	a2,272(a6)
   10560:	3107a883          	lw	a7,784(a5)
   10564:	4605                	li	a2,1
   10566:	00e6163b          	sllw	a2,a2,a4
   1056a:	00c8e8b3          	or	a7,a7,a2
   1056e:	3117a823          	sw	a7,784(a5)
   10572:	20d83823          	sd	a3,528(a6)
   10576:	4689                	li	a3,2
   10578:	02d50063          	beq	a0,a3,10598 <__register_exitproc+0x56>
   1057c:	00270693          	add	a3,a4,2
   10580:	068e                	sll	a3,a3,0x3
   10582:	2705                	addw	a4,a4,1
   10584:	c798                	sw	a4,8(a5)
   10586:	97b6                	add	a5,a5,a3
   10588:	e38c                	sd	a1,0(a5)
   1058a:	4501                	li	a0,0
   1058c:	8082                	ret
   1058e:	20070793          	add	a5,a4,512
   10592:	1ef73c23          	sd	a5,504(a4)
   10596:	bf5d                	j	1054c <__register_exitproc+0xa>
   10598:	3147a683          	lw	a3,788(a5)
   1059c:	4501                	li	a0,0
   1059e:	8ed1                	or	a3,a3,a2
   105a0:	30d7aa23          	sw	a3,788(a5)
   105a4:	00270693          	add	a3,a4,2
   105a8:	068e                	sll	a3,a3,0x3
   105aa:	2705                	addw	a4,a4,1
   105ac:	c798                	sw	a4,8(a5)
   105ae:	97b6                	add	a5,a5,a3
   105b0:	e38c                	sd	a1,0(a5)
   105b2:	8082                	ret
   105b4:	557d                	li	a0,-1
   105b6:	8082                	ret

00000000000105b8 <_exit>:
   105b8:	05d00893          	li	a7,93
   105bc:	00000073          	ecall
   105c0:	00054363          	bltz	a0,105c6 <_exit+0xe>
   105c4:	a001                	j	105c4 <_exit+0xc>
   105c6:	1141                	add	sp,sp,-16
   105c8:	e022                	sd	s0,0(sp)
   105ca:	842a                	mv	s0,a0
   105cc:	e406                	sd	ra,8(sp)
   105ce:	4080043b          	negw	s0,s0
   105d2:	008000ef          	jal	105da <__errno>
   105d6:	c100                	sw	s0,0(a0)
   105d8:	a001                	j	105d8 <_exit+0x20>

00000000000105da <__errno>:
   105da:	f581b503          	ld	a0,-168(gp) # 11d58 <_impure_ptr>
   105de:	8082                	ret

sh.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	3a8000ef          	jal	1049a <__call_exitprocs>
   100f6:	fe81b503          	ld	a0,-24(gp) # 11e48 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	50e000ef          	jal	10610 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	55c50513          	add	a0,a0,1372 # 1055c <__libc_fini_array>
   10112:	a9bd                	j	10590 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d4a18193          	add	gp,gp,-694 # 11e60 <completed.1>
   1011e:	00018513          	mv	a0,gp
   10122:	03818613          	add	a2,gp,56 # 11e98 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	2c6000ef          	jal	103f0 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	46250513          	add	a0,a0,1122 # 10590 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	42450513          	add	a0,a0,1060 # 1055c <__libc_fini_array>
   10140:	450000ef          	jal	10590 <atexit>
   10144:	242000ef          	jal	10386 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	0001c783          	lbu	a5,0(gp) # 11e60 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	63850513          	add	a0,a0,1592 # 11638 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	00f18023          	sb	a5,0(gp) # 11e60 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	00818593          	add	a1,gp,8 # 11e68 <object.0>
   1018e:	63850513          	add	a0,a0,1592 # 11638 <__EH_FRAME_BEGIN__>
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
   101ae:	00001097          	auipc	ra,0x1
   101b2:	4b208093          	add	ra,ra,1202 # 11660 <__DATA_BEGIN__>
   101b6:	0aa00113          	li	sp,170
   101ba:	00000797          	auipc	a5,0x0
   101be:	01278793          	add	a5,a5,18 # 101cc <test_2+0x20>
   101c2:	00209023          	sh	sp,0(ra)
   101c6:	00009703          	lh	a4,0(ra)
   101ca:	a011                	j	101ce <test_2+0x22>
   101cc:	870a                	mv	a4,sp
   101ce:	0aa00393          	li	t2,170
   101d2:	1a771263          	bne	a4,t2,10376 <fail>

00000000000101d6 <test_3>:
   101d6:	418d                	li	gp,3
   101d8:	00001097          	auipc	ra,0x1
   101dc:	48808093          	add	ra,ra,1160 # 11660 <__DATA_BEGIN__>
   101e0:	ffffb137          	lui	sp,0xffffb
   101e4:	a001011b          	addw	sp,sp,-1536 # ffffffffffffaa00 <__BSS_END__+0xfffffffffffe8b68>
   101e8:	00000797          	auipc	a5,0x0
   101ec:	01278793          	add	a5,a5,18 # 101fa <test_3+0x24>
   101f0:	00209123          	sh	sp,2(ra)
   101f4:	00209703          	lh	a4,2(ra)
   101f8:	a011                	j	101fc <test_3+0x26>
   101fa:	870a                	mv	a4,sp
   101fc:	73ed                	lui	t2,0xffffb
   101fe:	a003839b          	addw	t2,t2,-1536 # ffffffffffffaa00 <__BSS_END__+0xfffffffffffe8b68>
   10202:	16771a63          	bne	a4,t2,10376 <fail>

0000000000010206 <test_4>:
   10206:	4191                	li	gp,4
   10208:	00001097          	auipc	ra,0x1
   1020c:	45808093          	add	ra,ra,1112 # 11660 <__DATA_BEGIN__>
   10210:	beef1137          	lui	sp,0xbeef1
   10214:	aa01011b          	addw	sp,sp,-1376 # ffffffffbeef0aa0 <__BSS_END__+0xffffffffbeedec08>
   10218:	00000797          	auipc	a5,0x0
   1021c:	01278793          	add	a5,a5,18 # 1022a <test_4+0x24>
   10220:	00209223          	sh	sp,4(ra)
   10224:	0040a703          	lw	a4,4(ra)
   10228:	a011                	j	1022c <test_4+0x26>
   1022a:	870a                	mv	a4,sp
   1022c:	beef13b7          	lui	t2,0xbeef1
   10230:	aa03839b          	addw	t2,t2,-1376 # ffffffffbeef0aa0 <__BSS_END__+0xffffffffbeedec08>
   10234:	14771163          	bne	a4,t2,10376 <fail>

0000000000010238 <test_5>:
   10238:	4195                	li	gp,5
   1023a:	00001097          	auipc	ra,0x1
   1023e:	42608093          	add	ra,ra,1062 # 11660 <__DATA_BEGIN__>
   10242:	ffffa137          	lui	sp,0xffffa
   10246:	2129                	addw	sp,sp,10 # ffffffffffffa00a <__BSS_END__+0xfffffffffffe8172>
   10248:	00000797          	auipc	a5,0x0
   1024c:	01278793          	add	a5,a5,18 # 1025a <test_5+0x22>
   10250:	00209323          	sh	sp,6(ra)
   10254:	00609703          	lh	a4,6(ra)
   10258:	a011                	j	1025c <test_5+0x24>
   1025a:	870a                	mv	a4,sp
   1025c:	73e9                	lui	t2,0xffffa
   1025e:	23a9                	addw	t2,t2,10 # ffffffffffffa00a <__BSS_END__+0xfffffffffffe8172>
   10260:	10771b63          	bne	a4,t2,10376 <fail>

0000000000010264 <test_6>:
   10264:	4199                	li	gp,6
   10266:	00001097          	auipc	ra,0x1
   1026a:	40808093          	add	ra,ra,1032 # 1166e <tdat8>
   1026e:	0aa00113          	li	sp,170
   10272:	00000797          	auipc	a5,0x0
   10276:	01278793          	add	a5,a5,18 # 10284 <test_6+0x20>
   1027a:	fe209d23          	sh	sp,-6(ra)
   1027e:	ffa09703          	lh	a4,-6(ra)
   10282:	a011                	j	10286 <test_6+0x22>
   10284:	870a                	mv	a4,sp
   10286:	0aa00393          	li	t2,170
   1028a:	0e771663          	bne	a4,t2,10376 <fail>

000000000001028e <test_7>:
   1028e:	419d                	li	gp,7
   10290:	00001097          	auipc	ra,0x1
   10294:	3de08093          	add	ra,ra,990 # 1166e <tdat8>
   10298:	ffffb137          	lui	sp,0xffffb
   1029c:	a001011b          	addw	sp,sp,-1536 # ffffffffffffaa00 <__BSS_END__+0xfffffffffffe8b68>
   102a0:	00000797          	auipc	a5,0x0
   102a4:	01278793          	add	a5,a5,18 # 102b2 <test_7+0x24>
   102a8:	fe209e23          	sh	sp,-4(ra)
   102ac:	ffc09703          	lh	a4,-4(ra)
   102b0:	a011                	j	102b4 <test_7+0x26>
   102b2:	870a                	mv	a4,sp
   102b4:	73ed                	lui	t2,0xffffb
   102b6:	a003839b          	addw	t2,t2,-1536 # ffffffffffffaa00 <__BSS_END__+0xfffffffffffe8b68>
   102ba:	0a771e63          	bne	a4,t2,10376 <fail>

00000000000102be <test_8>:
   102be:	41a1                	li	gp,8
   102c0:	00001097          	auipc	ra,0x1
   102c4:	3ae08093          	add	ra,ra,942 # 1166e <tdat8>
   102c8:	00001137          	lui	sp,0x1
   102cc:	aa01011b          	addw	sp,sp,-1376 # aa0 <exit-0xf648>
   102d0:	00000797          	auipc	a5,0x0
   102d4:	01278793          	add	a5,a5,18 # 102e2 <test_8+0x24>
   102d8:	fe209f23          	sh	sp,-2(ra)
   102dc:	ffe09703          	lh	a4,-2(ra)
   102e0:	a011                	j	102e4 <test_8+0x26>
   102e2:	870a                	mv	a4,sp
   102e4:	6385                	lui	t2,0x1
   102e6:	aa03839b          	addw	t2,t2,-1376 # aa0 <exit-0xf648>
   102ea:	08771663          	bne	a4,t2,10376 <fail>

00000000000102ee <test_9>:
   102ee:	41a5                	li	gp,9
   102f0:	00001097          	auipc	ra,0x1
   102f4:	37e08093          	add	ra,ra,894 # 1166e <tdat8>
   102f8:	ffffa137          	lui	sp,0xffffa
   102fc:	2129                	addw	sp,sp,10 # ffffffffffffa00a <__BSS_END__+0xfffffffffffe8172>
   102fe:	00000797          	auipc	a5,0x0
   10302:	01278793          	add	a5,a5,18 # 10310 <test_9+0x22>
   10306:	00209023          	sh	sp,0(ra)
   1030a:	00009703          	lh	a4,0(ra)
   1030e:	a011                	j	10312 <test_9+0x24>
   10310:	870a                	mv	a4,sp
   10312:	73e9                	lui	t2,0xffffa
   10314:	23a9                	addw	t2,t2,10 # ffffffffffffa00a <__BSS_END__+0xfffffffffffe8172>
   10316:	06771063          	bne	a4,t2,10376 <fail>

000000000001031a <test_10>:
   1031a:	41a9                	li	gp,10
   1031c:	00001097          	auipc	ra,0x1
   10320:	35408093          	add	ra,ra,852 # 11670 <tdat9>
   10324:	12345137          	lui	sp,0x12345
   10328:	6781011b          	addw	sp,sp,1656 # 12345678 <__BSS_END__+0x123337e0>
   1032c:	fe008213          	add	tp,ra,-32
   10330:	02221023          	sh	sp,32(tp) # 20 <exit-0x100c8>
   10334:	00009283          	lh	t0,0(ra)
   10338:	6395                	lui	t2,0x5
   1033a:	6783839b          	addw	t2,t2,1656 # 5678 <exit-0xaa70>
   1033e:	02729c63          	bne	t0,t2,10376 <fail>

0000000000010342 <test_11>:
   10342:	41ad                	li	gp,11
   10344:	00001097          	auipc	ra,0x1
   10348:	32c08093          	add	ra,ra,812 # 11670 <tdat9>
   1034c:	00003137          	lui	sp,0x3
   10350:	0981011b          	addw	sp,sp,152 # 3098 <exit-0xd050>
   10354:	10ed                	add	ra,ra,-5
   10356:	002093a3          	sh	sp,7(ra)
   1035a:	00001217          	auipc	tp,0x1
   1035e:	31820213          	add	tp,tp,792 # 11672 <tdat10>
   10362:	00021283          	lh	t0,0(tp) # 0 <exit-0x100e8>
   10366:	638d                	lui	t2,0x3
   10368:	0983839b          	addw	t2,t2,152 # 3098 <exit-0xd050>
   1036c:	00729563          	bne	t0,t2,10376 <fail>
   10370:	00301263          	bne	zero,gp,10374 <pass>

0000000000010374 <pass>:
   10374:	a019                	j	1037a <continue>

0000000000010376 <fail>:
   10376:	0000                	unimp
	...

000000000001037a <continue>:
   1037a:	4081                	li	ra,0
   1037c:	4781                	li	a5,0
   1037e:	853e                	mv	a0,a5
   10380:	6462                	ld	s0,24(sp)
   10382:	6105                	add	sp,sp,32
   10384:	8082                	ret

0000000000010386 <__libc_init_array>:
   10386:	1101                	add	sp,sp,-32
   10388:	e822                	sd	s0,16(sp)
   1038a:	67c5                	lui	a5,0x11
   1038c:	6445                	lui	s0,0x11
   1038e:	e04a                	sd	s2,0(sp)
   10390:	63c78793          	add	a5,a5,1596 # 1163c <__preinit_array_end>
   10394:	63c40713          	add	a4,s0,1596 # 1163c <__preinit_array_end>
   10398:	ec06                	sd	ra,24(sp)
   1039a:	e426                	sd	s1,8(sp)
   1039c:	40e78933          	sub	s2,a5,a4
   103a0:	00e78d63          	beq	a5,a4,103ba <__libc_init_array+0x34>
   103a4:	40395913          	sra	s2,s2,0x3
   103a8:	63c40413          	add	s0,s0,1596
   103ac:	4481                	li	s1,0
   103ae:	601c                	ld	a5,0(s0)
   103b0:	0485                	add	s1,s1,1
   103b2:	0421                	add	s0,s0,8
   103b4:	9782                	jalr	a5
   103b6:	ff24ece3          	bltu	s1,s2,103ae <__libc_init_array+0x28>
   103ba:	6445                	lui	s0,0x11
   103bc:	67c5                	lui	a5,0x11
   103be:	65078793          	add	a5,a5,1616 # 11650 <__do_global_dtors_aux_fini_array_entry>
   103c2:	64040713          	add	a4,s0,1600 # 11640 <__init_array_start>
   103c6:	40e78933          	sub	s2,a5,a4
   103ca:	40395913          	sra	s2,s2,0x3
   103ce:	00e78b63          	beq	a5,a4,103e4 <__libc_init_array+0x5e>
   103d2:	64040413          	add	s0,s0,1600
   103d6:	4481                	li	s1,0
   103d8:	601c                	ld	a5,0(s0)
   103da:	0485                	add	s1,s1,1
   103dc:	0421                	add	s0,s0,8
   103de:	9782                	jalr	a5
   103e0:	ff24ece3          	bltu	s1,s2,103d8 <__libc_init_array+0x52>
   103e4:	60e2                	ld	ra,24(sp)
   103e6:	6442                	ld	s0,16(sp)
   103e8:	64a2                	ld	s1,8(sp)
   103ea:	6902                	ld	s2,0(sp)
   103ec:	6105                	add	sp,sp,32
   103ee:	8082                	ret

00000000000103f0 <memset>:
   103f0:	433d                	li	t1,15
   103f2:	872a                	mv	a4,a0
   103f4:	02c37163          	bgeu	t1,a2,10416 <memset+0x26>
   103f8:	00f77793          	and	a5,a4,15
   103fc:	e3c1                	bnez	a5,1047c <memset+0x8c>
   103fe:	e1bd                	bnez	a1,10464 <memset+0x74>
   10400:	ff067693          	and	a3,a2,-16
   10404:	8a3d                	and	a2,a2,15
   10406:	96ba                	add	a3,a3,a4
   10408:	e30c                	sd	a1,0(a4)
   1040a:	e70c                	sd	a1,8(a4)
   1040c:	0741                	add	a4,a4,16
   1040e:	fed76de3          	bltu	a4,a3,10408 <memset+0x18>
   10412:	e211                	bnez	a2,10416 <memset+0x26>
   10414:	8082                	ret
   10416:	40c306b3          	sub	a3,t1,a2
   1041a:	068a                	sll	a3,a3,0x2
   1041c:	00000297          	auipc	t0,0x0
   10420:	9696                	add	a3,a3,t0
   10422:	00a68067          	jr	10(a3)
   10426:	00b70723          	sb	a1,14(a4)
   1042a:	00b706a3          	sb	a1,13(a4)
   1042e:	00b70623          	sb	a1,12(a4)
   10432:	00b705a3          	sb	a1,11(a4)
   10436:	00b70523          	sb	a1,10(a4)
   1043a:	00b704a3          	sb	a1,9(a4)
   1043e:	00b70423          	sb	a1,8(a4)
   10442:	00b703a3          	sb	a1,7(a4)
   10446:	00b70323          	sb	a1,6(a4)
   1044a:	00b702a3          	sb	a1,5(a4)
   1044e:	00b70223          	sb	a1,4(a4)
   10452:	00b701a3          	sb	a1,3(a4)
   10456:	00b70123          	sb	a1,2(a4)
   1045a:	00b700a3          	sb	a1,1(a4)
   1045e:	00b70023          	sb	a1,0(a4)
   10462:	8082                	ret
   10464:	0ff5f593          	zext.b	a1,a1
   10468:	00859693          	sll	a3,a1,0x8
   1046c:	8dd5                	or	a1,a1,a3
   1046e:	01059693          	sll	a3,a1,0x10
   10472:	8dd5                	or	a1,a1,a3
   10474:	02059693          	sll	a3,a1,0x20
   10478:	8dd5                	or	a1,a1,a3
   1047a:	b759                	j	10400 <memset+0x10>
   1047c:	00279693          	sll	a3,a5,0x2
   10480:	00000297          	auipc	t0,0x0
   10484:	9696                	add	a3,a3,t0
   10486:	8286                	mv	t0,ra
   10488:	fa2680e7          	jalr	-94(a3)
   1048c:	8096                	mv	ra,t0
   1048e:	17c1                	add	a5,a5,-16
   10490:	8f1d                	sub	a4,a4,a5
   10492:	963e                	add	a2,a2,a5
   10494:	f8c371e3          	bgeu	t1,a2,10416 <memset+0x26>
   10498:	b79d                	j	103fe <memset+0xe>

000000000001049a <__call_exitprocs>:
   1049a:	715d                	add	sp,sp,-80
   1049c:	f052                	sd	s4,32(sp)
   1049e:	fe81ba03          	ld	s4,-24(gp) # 11e48 <_global_impure_ptr>
   104a2:	f84a                	sd	s2,48(sp)
   104a4:	e486                	sd	ra,72(sp)
   104a6:	1f8a3903          	ld	s2,504(s4)
   104aa:	e0a2                	sd	s0,64(sp)
   104ac:	fc26                	sd	s1,56(sp)
   104ae:	f44e                	sd	s3,40(sp)
   104b0:	ec56                	sd	s5,24(sp)
   104b2:	e85a                	sd	s6,16(sp)
   104b4:	e45e                	sd	s7,8(sp)
   104b6:	e062                	sd	s8,0(sp)
   104b8:	02090863          	beqz	s2,104e8 <__call_exitprocs+0x4e>
   104bc:	8b2a                	mv	s6,a0
   104be:	8bae                	mv	s7,a1
   104c0:	4a85                	li	s5,1
   104c2:	59fd                	li	s3,-1
   104c4:	00892483          	lw	s1,8(s2)
   104c8:	fff4841b          	addw	s0,s1,-1
   104cc:	00044e63          	bltz	s0,104e8 <__call_exitprocs+0x4e>
   104d0:	048e                	sll	s1,s1,0x3
   104d2:	94ca                	add	s1,s1,s2
   104d4:	020b8663          	beqz	s7,10500 <__call_exitprocs+0x66>
   104d8:	2084b783          	ld	a5,520(s1)
   104dc:	03778263          	beq	a5,s7,10500 <__call_exitprocs+0x66>
   104e0:	347d                	addw	s0,s0,-1
   104e2:	14e1                	add	s1,s1,-8
   104e4:	ff3418e3          	bne	s0,s3,104d4 <__call_exitprocs+0x3a>
   104e8:	60a6                	ld	ra,72(sp)
   104ea:	6406                	ld	s0,64(sp)
   104ec:	74e2                	ld	s1,56(sp)
   104ee:	7942                	ld	s2,48(sp)
   104f0:	79a2                	ld	s3,40(sp)
   104f2:	7a02                	ld	s4,32(sp)
   104f4:	6ae2                	ld	s5,24(sp)
   104f6:	6b42                	ld	s6,16(sp)
   104f8:	6ba2                	ld	s7,8(sp)
   104fa:	6c02                	ld	s8,0(sp)
   104fc:	6161                	add	sp,sp,80
   104fe:	8082                	ret
   10500:	00892783          	lw	a5,8(s2)
   10504:	6498                	ld	a4,8(s1)
   10506:	37fd                	addw	a5,a5,-1
   10508:	04878463          	beq	a5,s0,10550 <__call_exitprocs+0xb6>
   1050c:	0004b423          	sd	zero,8(s1)
   10510:	db61                	beqz	a4,104e0 <__call_exitprocs+0x46>
   10512:	31092783          	lw	a5,784(s2)
   10516:	008a96bb          	sllw	a3,s5,s0
   1051a:	00892c03          	lw	s8,8(s2)
   1051e:	8ff5                	and	a5,a5,a3
   10520:	2781                	sext.w	a5,a5
   10522:	ef89                	bnez	a5,1053c <__call_exitprocs+0xa2>
   10524:	9702                	jalr	a4
   10526:	00892703          	lw	a4,8(s2)
   1052a:	1f8a3783          	ld	a5,504(s4)
   1052e:	01871463          	bne	a4,s8,10536 <__call_exitprocs+0x9c>
   10532:	fb2787e3          	beq	a5,s2,104e0 <__call_exitprocs+0x46>
   10536:	dbcd                	beqz	a5,104e8 <__call_exitprocs+0x4e>
   10538:	893e                	mv	s2,a5
   1053a:	b769                	j	104c4 <__call_exitprocs+0x2a>
   1053c:	31492783          	lw	a5,788(s2)
   10540:	1084b583          	ld	a1,264(s1)
   10544:	8ff5                	and	a5,a5,a3
   10546:	2781                	sext.w	a5,a5
   10548:	e799                	bnez	a5,10556 <__call_exitprocs+0xbc>
   1054a:	855a                	mv	a0,s6
   1054c:	9702                	jalr	a4
   1054e:	bfe1                	j	10526 <__call_exitprocs+0x8c>
   10550:	00892423          	sw	s0,8(s2)
   10554:	bf75                	j	10510 <__call_exitprocs+0x76>
   10556:	852e                	mv	a0,a1
   10558:	9702                	jalr	a4
   1055a:	b7f1                	j	10526 <__call_exitprocs+0x8c>

000000000001055c <__libc_fini_array>:
   1055c:	1101                	add	sp,sp,-32
   1055e:	e822                	sd	s0,16(sp)
   10560:	67c5                	lui	a5,0x11
   10562:	6445                	lui	s0,0x11
   10564:	65078793          	add	a5,a5,1616 # 11650 <__do_global_dtors_aux_fini_array_entry>
   10568:	65840413          	add	s0,s0,1624 # 11658 <__fini_array_end>
   1056c:	8c1d                	sub	s0,s0,a5
   1056e:	e426                	sd	s1,8(sp)
   10570:	ec06                	sd	ra,24(sp)
   10572:	40345493          	sra	s1,s0,0x3
   10576:	c881                	beqz	s1,10586 <__libc_fini_array+0x2a>
   10578:	1461                	add	s0,s0,-8
   1057a:	943e                	add	s0,s0,a5
   1057c:	601c                	ld	a5,0(s0)
   1057e:	14fd                	add	s1,s1,-1
   10580:	1461                	add	s0,s0,-8
   10582:	9782                	jalr	a5
   10584:	fce5                	bnez	s1,1057c <__libc_fini_array+0x20>
   10586:	60e2                	ld	ra,24(sp)
   10588:	6442                	ld	s0,16(sp)
   1058a:	64a2                	ld	s1,8(sp)
   1058c:	6105                	add	sp,sp,32
   1058e:	8082                	ret

0000000000010590 <atexit>:
   10590:	85aa                	mv	a1,a0
   10592:	4681                	li	a3,0
   10594:	4601                	li	a2,0
   10596:	4501                	li	a0,0
   10598:	a009                	j	1059a <__register_exitproc>

000000000001059a <__register_exitproc>:
   1059a:	fe81b703          	ld	a4,-24(gp) # 11e48 <_global_impure_ptr>
   1059e:	1f873783          	ld	a5,504(a4)
   105a2:	c3b1                	beqz	a5,105e6 <__register_exitproc+0x4c>
   105a4:	4798                	lw	a4,8(a5)
   105a6:	487d                	li	a6,31
   105a8:	06e84263          	blt	a6,a4,1060c <__register_exitproc+0x72>
   105ac:	c505                	beqz	a0,105d4 <__register_exitproc+0x3a>
   105ae:	00371813          	sll	a6,a4,0x3
   105b2:	983e                	add	a6,a6,a5
   105b4:	10c83823          	sd	a2,272(a6)
   105b8:	3107a883          	lw	a7,784(a5)
   105bc:	4605                	li	a2,1
   105be:	00e6163b          	sllw	a2,a2,a4
   105c2:	00c8e8b3          	or	a7,a7,a2
   105c6:	3117a823          	sw	a7,784(a5)
   105ca:	20d83823          	sd	a3,528(a6)
   105ce:	4689                	li	a3,2
   105d0:	02d50063          	beq	a0,a3,105f0 <__register_exitproc+0x56>
   105d4:	00270693          	add	a3,a4,2
   105d8:	068e                	sll	a3,a3,0x3
   105da:	2705                	addw	a4,a4,1
   105dc:	c798                	sw	a4,8(a5)
   105de:	97b6                	add	a5,a5,a3
   105e0:	e38c                	sd	a1,0(a5)
   105e2:	4501                	li	a0,0
   105e4:	8082                	ret
   105e6:	20070793          	add	a5,a4,512
   105ea:	1ef73c23          	sd	a5,504(a4)
   105ee:	bf5d                	j	105a4 <__register_exitproc+0xa>
   105f0:	3147a683          	lw	a3,788(a5)
   105f4:	4501                	li	a0,0
   105f6:	8ed1                	or	a3,a3,a2
   105f8:	30d7aa23          	sw	a3,788(a5)
   105fc:	00270693          	add	a3,a4,2
   10600:	068e                	sll	a3,a3,0x3
   10602:	2705                	addw	a4,a4,1
   10604:	c798                	sw	a4,8(a5)
   10606:	97b6                	add	a5,a5,a3
   10608:	e38c                	sd	a1,0(a5)
   1060a:	8082                	ret
   1060c:	557d                	li	a0,-1
   1060e:	8082                	ret

0000000000010610 <_exit>:
   10610:	05d00893          	li	a7,93
   10614:	00000073          	ecall
   10618:	00054363          	bltz	a0,1061e <_exit+0xe>
   1061c:	a001                	j	1061c <_exit+0xc>
   1061e:	1141                	add	sp,sp,-16
   10620:	e022                	sd	s0,0(sp)
   10622:	842a                	mv	s0,a0
   10624:	e406                	sd	ra,8(sp)
   10626:	4080043b          	negw	s0,s0
   1062a:	008000ef          	jal	10632 <__errno>
   1062e:	c100                	sw	s0,0(a0)
   10630:	a001                	j	10630 <_exit+0x20>

0000000000010632 <__errno>:
   10632:	ff81b503          	ld	a0,-8(gp) # 11e58 <_impure_ptr>
   10636:	8082                	ret

slt.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	326000ef          	jal	10418 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d20 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	48c000ef          	jal	1058e <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4da50513          	add	a0,a0,1242 # 104da <__libc_fini_array>
   10112:	aef5                	j	1050e <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cc218193          	add	gp,gp,-830 # 11dd8 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d38 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d70 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	244000ef          	jal	1036e <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3e050513          	add	a0,a0,992 # 1050e <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3a250513          	add	a0,a0,930 # 104da <__libc_fini_array>
   10140:	3ce000ef          	jal	1050e <atexit>
   10144:	1c0000ef          	jal	10304 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d38 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5b850513          	add	a0,a0,1464 # 115b8 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d38 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d40 <object.0>
   1018e:	5b850513          	add	a0,a0,1464 # 115b8 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	4101                	li	sp,0
   101b2:	0020a733          	slt	a4,ra,sp
   101b6:	4381                	li	t2,0
   101b8:	12771e63          	bne	a4,t2,102f4 <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	0020a733          	slt	a4,ra,sp
   101c6:	4381                	li	t2,0
   101c8:	12771663          	bne	a4,t2,102f4 <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	408d                	li	ra,3
   101d0:	411d                	li	sp,7
   101d2:	0020a733          	slt	a4,ra,sp
   101d6:	4385                	li	t2,1
   101d8:	10771e63          	bne	a4,t2,102f4 <fail>

00000000000101dc <test_5>:
   101dc:	4195                	li	gp,5
   101de:	409d                	li	ra,7
   101e0:	410d                	li	sp,3
   101e2:	0020a733          	slt	a4,ra,sp
   101e6:	4381                	li	t2,0
   101e8:	10771663          	bne	a4,t2,102f4 <fail>

00000000000101ec <test_6>:
   101ec:	4199                	li	gp,6
   101ee:	4081                	li	ra,0
   101f0:	ffff8137          	lui	sp,0xffff8
   101f4:	0020a733          	slt	a4,ra,sp
   101f8:	4381                	li	t2,0
   101fa:	0e771d63          	bne	a4,t2,102f4 <fail>

00000000000101fe <test_7>:
   101fe:	419d                	li	gp,7
   10200:	800000b7          	lui	ra,0x80000
   10204:	4101                	li	sp,0
   10206:	0020a733          	slt	a4,ra,sp
   1020a:	4385                	li	t2,1
   1020c:	0e771463          	bne	a4,t2,102f4 <fail>

0000000000010210 <test_8>:
   10210:	41a1                	li	gp,8
   10212:	800000b7          	lui	ra,0x80000
   10216:	ffff8137          	lui	sp,0xffff8
   1021a:	0020a733          	slt	a4,ra,sp
   1021e:	4385                	li	t2,1
   10220:	0c771a63          	bne	a4,t2,102f4 <fail>

0000000000010224 <test_9>:
   10224:	41a5                	li	gp,9
   10226:	4081                	li	ra,0
   10228:	00008137          	lui	sp,0x8
   1022c:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1022e:	0020a733          	slt	a4,ra,sp
   10232:	4385                	li	t2,1
   10234:	0c771063          	bne	a4,t2,102f4 <fail>

0000000000010238 <test_10>:
   10238:	41a9                	li	gp,10
   1023a:	800000b7          	lui	ra,0x80000
   1023e:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   10240:	4101                	li	sp,0
   10242:	0020a733          	slt	a4,ra,sp
   10246:	4381                	li	t2,0
   10248:	0a771663          	bne	a4,t2,102f4 <fail>

000000000001024c <test_11>:
   1024c:	41ad                	li	gp,11
   1024e:	800000b7          	lui	ra,0x80000
   10252:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   10254:	00008137          	lui	sp,0x8
   10258:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1025a:	0020a733          	slt	a4,ra,sp
   1025e:	4381                	li	t2,0
   10260:	08771a63          	bne	a4,t2,102f4 <fail>

0000000000010264 <test_12>:
   10264:	41b1                	li	gp,12
   10266:	800000b7          	lui	ra,0x80000
   1026a:	00008137          	lui	sp,0x8
   1026e:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10270:	0020a733          	slt	a4,ra,sp
   10274:	4385                	li	t2,1
   10276:	06771f63          	bne	a4,t2,102f4 <fail>

000000000001027a <test_13>:
   1027a:	41b5                	li	gp,13
   1027c:	800000b7          	lui	ra,0x80000
   10280:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   10282:	ffff8137          	lui	sp,0xffff8
   10286:	0020a733          	slt	a4,ra,sp
   1028a:	4381                	li	t2,0
   1028c:	06771463          	bne	a4,t2,102f4 <fail>

0000000000010290 <test_14>:
   10290:	41b9                	li	gp,14
   10292:	4081                	li	ra,0
   10294:	517d                	li	sp,-1
   10296:	0020a733          	slt	a4,ra,sp
   1029a:	4381                	li	t2,0
   1029c:	04771c63          	bne	a4,t2,102f4 <fail>

00000000000102a0 <test_15>:
   102a0:	41bd                	li	gp,15
   102a2:	50fd                	li	ra,-1
   102a4:	4105                	li	sp,1
   102a6:	0020a733          	slt	a4,ra,sp
   102aa:	4385                	li	t2,1
   102ac:	04771463          	bne	a4,t2,102f4 <fail>

00000000000102b0 <test_16>:
   102b0:	41c1                	li	gp,16
   102b2:	50fd                	li	ra,-1
   102b4:	517d                	li	sp,-1
   102b6:	0020a733          	slt	a4,ra,sp
   102ba:	4381                	li	t2,0
   102bc:	02771c63          	bne	a4,t2,102f4 <fail>

00000000000102c0 <test_17>:
   102c0:	41c5                	li	gp,17
   102c2:	40b9                	li	ra,14
   102c4:	4135                	li	sp,13
   102c6:	0020a0b3          	slt	ra,ra,sp
   102ca:	4381                	li	t2,0
   102cc:	02709463          	bne	ra,t2,102f4 <fail>

00000000000102d0 <test_18>:
   102d0:	41c9                	li	gp,18
   102d2:	40ad                	li	ra,11
   102d4:	4135                	li	sp,13
   102d6:	0020a133          	slt	sp,ra,sp
   102da:	4385                	li	t2,1
   102dc:	00711c63          	bne	sp,t2,102f4 <fail>

00000000000102e0 <test_19>:
   102e0:	41cd                	li	gp,19
   102e2:	40b5                	li	ra,13
   102e4:	0010a0b3          	slt	ra,ra,ra
   102e8:	4381                	li	t2,0
   102ea:	00709563          	bne	ra,t2,102f4 <fail>
   102ee:	00301263          	bne	zero,gp,102f2 <pass>

00000000000102f2 <pass>:
   102f2:	a019                	j	102f8 <continue>

00000000000102f4 <fail>:
   102f4:	0000                	unimp
	...

00000000000102f8 <continue>:
   102f8:	4081                	li	ra,0
   102fa:	4781                	li	a5,0
   102fc:	853e                	mv	a0,a5
   102fe:	6462                	ld	s0,24(sp)
   10300:	6105                	add	sp,sp,32
   10302:	8082                	ret

0000000000010304 <__libc_init_array>:
   10304:	1101                	add	sp,sp,-32 # ffffffffffff7fe0 <__global_pointer$+0xfffffffffffe6208>
   10306:	e822                	sd	s0,16(sp)
   10308:	67c5                	lui	a5,0x11
   1030a:	6445                	lui	s0,0x11
   1030c:	e04a                	sd	s2,0(sp)
   1030e:	5bc78793          	add	a5,a5,1468 # 115bc <__preinit_array_end>
   10312:	5bc40713          	add	a4,s0,1468 # 115bc <__preinit_array_end>
   10316:	ec06                	sd	ra,24(sp)
   10318:	e426                	sd	s1,8(sp)
   1031a:	40e78933          	sub	s2,a5,a4
   1031e:	00e78d63          	beq	a5,a4,10338 <__libc_init_array+0x34>
   10322:	40395913          	sra	s2,s2,0x3
   10326:	5bc40413          	add	s0,s0,1468
   1032a:	4481                	li	s1,0
   1032c:	601c                	ld	a5,0(s0)
   1032e:	0485                	add	s1,s1,1
   10330:	0421                	add	s0,s0,8
   10332:	9782                	jalr	a5
   10334:	ff24ece3          	bltu	s1,s2,1032c <__libc_init_array+0x28>
   10338:	6445                	lui	s0,0x11
   1033a:	67c5                	lui	a5,0x11
   1033c:	5d078793          	add	a5,a5,1488 # 115d0 <__do_global_dtors_aux_fini_array_entry>
   10340:	5c040713          	add	a4,s0,1472 # 115c0 <__init_array_start>
   10344:	40e78933          	sub	s2,a5,a4
   10348:	40395913          	sra	s2,s2,0x3
   1034c:	00e78b63          	beq	a5,a4,10362 <__libc_init_array+0x5e>
   10350:	5c040413          	add	s0,s0,1472
   10354:	4481                	li	s1,0
   10356:	601c                	ld	a5,0(s0)
   10358:	0485                	add	s1,s1,1
   1035a:	0421                	add	s0,s0,8
   1035c:	9782                	jalr	a5
   1035e:	ff24ece3          	bltu	s1,s2,10356 <__libc_init_array+0x52>
   10362:	60e2                	ld	ra,24(sp)
   10364:	6442                	ld	s0,16(sp)
   10366:	64a2                	ld	s1,8(sp)
   10368:	6902                	ld	s2,0(sp)
   1036a:	6105                	add	sp,sp,32
   1036c:	8082                	ret

000000000001036e <memset>:
   1036e:	433d                	li	t1,15
   10370:	872a                	mv	a4,a0
   10372:	02c37163          	bgeu	t1,a2,10394 <memset+0x26>
   10376:	00f77793          	and	a5,a4,15
   1037a:	e3c1                	bnez	a5,103fa <memset+0x8c>
   1037c:	e1bd                	bnez	a1,103e2 <memset+0x74>
   1037e:	ff067693          	and	a3,a2,-16
   10382:	8a3d                	and	a2,a2,15
   10384:	96ba                	add	a3,a3,a4
   10386:	e30c                	sd	a1,0(a4)
   10388:	e70c                	sd	a1,8(a4)
   1038a:	0741                	add	a4,a4,16
   1038c:	fed76de3          	bltu	a4,a3,10386 <memset+0x18>
   10390:	e211                	bnez	a2,10394 <memset+0x26>
   10392:	8082                	ret
   10394:	40c306b3          	sub	a3,t1,a2
   10398:	068a                	sll	a3,a3,0x2
   1039a:	00000297          	auipc	t0,0x0
   1039e:	9696                	add	a3,a3,t0
   103a0:	00a68067          	jr	10(a3)
   103a4:	00b70723          	sb	a1,14(a4)
   103a8:	00b706a3          	sb	a1,13(a4)
   103ac:	00b70623          	sb	a1,12(a4)
   103b0:	00b705a3          	sb	a1,11(a4)
   103b4:	00b70523          	sb	a1,10(a4)
   103b8:	00b704a3          	sb	a1,9(a4)
   103bc:	00b70423          	sb	a1,8(a4)
   103c0:	00b703a3          	sb	a1,7(a4)
   103c4:	00b70323          	sb	a1,6(a4)
   103c8:	00b702a3          	sb	a1,5(a4)
   103cc:	00b70223          	sb	a1,4(a4)
   103d0:	00b701a3          	sb	a1,3(a4)
   103d4:	00b70123          	sb	a1,2(a4)
   103d8:	00b700a3          	sb	a1,1(a4)
   103dc:	00b70023          	sb	a1,0(a4)
   103e0:	8082                	ret
   103e2:	0ff5f593          	zext.b	a1,a1
   103e6:	00859693          	sll	a3,a1,0x8
   103ea:	8dd5                	or	a1,a1,a3
   103ec:	01059693          	sll	a3,a1,0x10
   103f0:	8dd5                	or	a1,a1,a3
   103f2:	02059693          	sll	a3,a1,0x20
   103f6:	8dd5                	or	a1,a1,a3
   103f8:	b759                	j	1037e <memset+0x10>
   103fa:	00279693          	sll	a3,a5,0x2
   103fe:	00000297          	auipc	t0,0x0
   10402:	9696                	add	a3,a3,t0
   10404:	8286                	mv	t0,ra
   10406:	fa2680e7          	jalr	-94(a3)
   1040a:	8096                	mv	ra,t0
   1040c:	17c1                	add	a5,a5,-16
   1040e:	8f1d                	sub	a4,a4,a5
   10410:	963e                	add	a2,a2,a5
   10412:	f8c371e3          	bgeu	t1,a2,10394 <memset+0x26>
   10416:	b79d                	j	1037c <memset+0xe>

0000000000010418 <__call_exitprocs>:
   10418:	715d                	add	sp,sp,-80
   1041a:	f052                	sd	s4,32(sp)
   1041c:	f481ba03          	ld	s4,-184(gp) # 11d20 <_global_impure_ptr>
   10420:	f84a                	sd	s2,48(sp)
   10422:	e486                	sd	ra,72(sp)
   10424:	1f8a3903          	ld	s2,504(s4)
   10428:	e0a2                	sd	s0,64(sp)
   1042a:	fc26                	sd	s1,56(sp)
   1042c:	f44e                	sd	s3,40(sp)
   1042e:	ec56                	sd	s5,24(sp)
   10430:	e85a                	sd	s6,16(sp)
   10432:	e45e                	sd	s7,8(sp)
   10434:	e062                	sd	s8,0(sp)
   10436:	02090863          	beqz	s2,10466 <__call_exitprocs+0x4e>
   1043a:	8b2a                	mv	s6,a0
   1043c:	8bae                	mv	s7,a1
   1043e:	4a85                	li	s5,1
   10440:	59fd                	li	s3,-1
   10442:	00892483          	lw	s1,8(s2)
   10446:	fff4841b          	addw	s0,s1,-1
   1044a:	00044e63          	bltz	s0,10466 <__call_exitprocs+0x4e>
   1044e:	048e                	sll	s1,s1,0x3
   10450:	94ca                	add	s1,s1,s2
   10452:	020b8663          	beqz	s7,1047e <__call_exitprocs+0x66>
   10456:	2084b783          	ld	a5,520(s1)
   1045a:	03778263          	beq	a5,s7,1047e <__call_exitprocs+0x66>
   1045e:	347d                	addw	s0,s0,-1
   10460:	14e1                	add	s1,s1,-8
   10462:	ff3418e3          	bne	s0,s3,10452 <__call_exitprocs+0x3a>
   10466:	60a6                	ld	ra,72(sp)
   10468:	6406                	ld	s0,64(sp)
   1046a:	74e2                	ld	s1,56(sp)
   1046c:	7942                	ld	s2,48(sp)
   1046e:	79a2                	ld	s3,40(sp)
   10470:	7a02                	ld	s4,32(sp)
   10472:	6ae2                	ld	s5,24(sp)
   10474:	6b42                	ld	s6,16(sp)
   10476:	6ba2                	ld	s7,8(sp)
   10478:	6c02                	ld	s8,0(sp)
   1047a:	6161                	add	sp,sp,80
   1047c:	8082                	ret
   1047e:	00892783          	lw	a5,8(s2)
   10482:	6498                	ld	a4,8(s1)
   10484:	37fd                	addw	a5,a5,-1
   10486:	04878463          	beq	a5,s0,104ce <__call_exitprocs+0xb6>
   1048a:	0004b423          	sd	zero,8(s1)
   1048e:	db61                	beqz	a4,1045e <__call_exitprocs+0x46>
   10490:	31092783          	lw	a5,784(s2)
   10494:	008a96bb          	sllw	a3,s5,s0
   10498:	00892c03          	lw	s8,8(s2)
   1049c:	8ff5                	and	a5,a5,a3
   1049e:	2781                	sext.w	a5,a5
   104a0:	ef89                	bnez	a5,104ba <__call_exitprocs+0xa2>
   104a2:	9702                	jalr	a4
   104a4:	00892703          	lw	a4,8(s2)
   104a8:	1f8a3783          	ld	a5,504(s4)
   104ac:	01871463          	bne	a4,s8,104b4 <__call_exitprocs+0x9c>
   104b0:	fb2787e3          	beq	a5,s2,1045e <__call_exitprocs+0x46>
   104b4:	dbcd                	beqz	a5,10466 <__call_exitprocs+0x4e>
   104b6:	893e                	mv	s2,a5
   104b8:	b769                	j	10442 <__call_exitprocs+0x2a>
   104ba:	31492783          	lw	a5,788(s2)
   104be:	1084b583          	ld	a1,264(s1)
   104c2:	8ff5                	and	a5,a5,a3
   104c4:	2781                	sext.w	a5,a5
   104c6:	e799                	bnez	a5,104d4 <__call_exitprocs+0xbc>
   104c8:	855a                	mv	a0,s6
   104ca:	9702                	jalr	a4
   104cc:	bfe1                	j	104a4 <__call_exitprocs+0x8c>
   104ce:	00892423          	sw	s0,8(s2)
   104d2:	bf75                	j	1048e <__call_exitprocs+0x76>
   104d4:	852e                	mv	a0,a1
   104d6:	9702                	jalr	a4
   104d8:	b7f1                	j	104a4 <__call_exitprocs+0x8c>

00000000000104da <__libc_fini_array>:
   104da:	1101                	add	sp,sp,-32
   104dc:	e822                	sd	s0,16(sp)
   104de:	67c5                	lui	a5,0x11
   104e0:	6445                	lui	s0,0x11
   104e2:	5d078793          	add	a5,a5,1488 # 115d0 <__do_global_dtors_aux_fini_array_entry>
   104e6:	5d840413          	add	s0,s0,1496 # 115d8 <impure_data>
   104ea:	8c1d                	sub	s0,s0,a5
   104ec:	e426                	sd	s1,8(sp)
   104ee:	ec06                	sd	ra,24(sp)
   104f0:	40345493          	sra	s1,s0,0x3
   104f4:	c881                	beqz	s1,10504 <__libc_fini_array+0x2a>
   104f6:	1461                	add	s0,s0,-8
   104f8:	943e                	add	s0,s0,a5
   104fa:	601c                	ld	a5,0(s0)
   104fc:	14fd                	add	s1,s1,-1
   104fe:	1461                	add	s0,s0,-8
   10500:	9782                	jalr	a5
   10502:	fce5                	bnez	s1,104fa <__libc_fini_array+0x20>
   10504:	60e2                	ld	ra,24(sp)
   10506:	6442                	ld	s0,16(sp)
   10508:	64a2                	ld	s1,8(sp)
   1050a:	6105                	add	sp,sp,32
   1050c:	8082                	ret

000000000001050e <atexit>:
   1050e:	85aa                	mv	a1,a0
   10510:	4681                	li	a3,0
   10512:	4601                	li	a2,0
   10514:	4501                	li	a0,0
   10516:	a009                	j	10518 <__register_exitproc>

0000000000010518 <__register_exitproc>:
   10518:	f481b703          	ld	a4,-184(gp) # 11d20 <_global_impure_ptr>
   1051c:	1f873783          	ld	a5,504(a4)
   10520:	c3b1                	beqz	a5,10564 <__register_exitproc+0x4c>
   10522:	4798                	lw	a4,8(a5)
   10524:	487d                	li	a6,31
   10526:	06e84263          	blt	a6,a4,1058a <__register_exitproc+0x72>
   1052a:	c505                	beqz	a0,10552 <__register_exitproc+0x3a>
   1052c:	00371813          	sll	a6,a4,0x3
   10530:	983e                	add	a6,a6,a5
   10532:	10c83823          	sd	a2,272(a6)
   10536:	3107a883          	lw	a7,784(a5)
   1053a:	4605                	li	a2,1
   1053c:	00e6163b          	sllw	a2,a2,a4
   10540:	00c8e8b3          	or	a7,a7,a2
   10544:	3117a823          	sw	a7,784(a5)
   10548:	20d83823          	sd	a3,528(a6)
   1054c:	4689                	li	a3,2
   1054e:	02d50063          	beq	a0,a3,1056e <__register_exitproc+0x56>
   10552:	00270693          	add	a3,a4,2
   10556:	068e                	sll	a3,a3,0x3
   10558:	2705                	addw	a4,a4,1
   1055a:	c798                	sw	a4,8(a5)
   1055c:	97b6                	add	a5,a5,a3
   1055e:	e38c                	sd	a1,0(a5)
   10560:	4501                	li	a0,0
   10562:	8082                	ret
   10564:	20070793          	add	a5,a4,512
   10568:	1ef73c23          	sd	a5,504(a4)
   1056c:	bf5d                	j	10522 <__register_exitproc+0xa>
   1056e:	3147a683          	lw	a3,788(a5)
   10572:	4501                	li	a0,0
   10574:	8ed1                	or	a3,a3,a2
   10576:	30d7aa23          	sw	a3,788(a5)
   1057a:	00270693          	add	a3,a4,2
   1057e:	068e                	sll	a3,a3,0x3
   10580:	2705                	addw	a4,a4,1
   10582:	c798                	sw	a4,8(a5)
   10584:	97b6                	add	a5,a5,a3
   10586:	e38c                	sd	a1,0(a5)
   10588:	8082                	ret
   1058a:	557d                	li	a0,-1
   1058c:	8082                	ret

000000000001058e <_exit>:
   1058e:	05d00893          	li	a7,93
   10592:	00000073          	ecall
   10596:	00054363          	bltz	a0,1059c <_exit+0xe>
   1059a:	a001                	j	1059a <_exit+0xc>
   1059c:	1141                	add	sp,sp,-16
   1059e:	e022                	sd	s0,0(sp)
   105a0:	842a                	mv	s0,a0
   105a2:	e406                	sd	ra,8(sp)
   105a4:	4080043b          	negw	s0,s0
   105a8:	008000ef          	jal	105b0 <__errno>
   105ac:	c100                	sw	s0,0(a0)
   105ae:	a001                	j	105ae <_exit+0x20>

00000000000105b0 <__errno>:
   105b0:	f581b503          	ld	a0,-168(gp) # 11d30 <_impure_ptr>
   105b4:	8082                	ret

sll.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	43e000ef          	jal	10530 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11e38 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	5a4000ef          	jal	106a6 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	5f250513          	add	a0,a0,1522 # 105f2 <__libc_fini_array>
   10112:	ab11                	j	10626 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	dda18193          	add	gp,gp,-550 # 11ef0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11e50 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11e88 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	35c000ef          	jal	10486 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	4f850513          	add	a0,a0,1272 # 10626 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	4ba50513          	add	a0,a0,1210 # 105f2 <__libc_fini_array>
   10140:	4e6000ef          	jal	10626 <atexit>
   10144:	2d8000ef          	jal	1041c <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11e50 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	6d050513          	add	a0,a0,1744 # 116d0 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11e50 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11e58 <object.0>
   1018e:	6d050513          	add	a0,a0,1744 # 116d0 <__EH_FRAME_BEGIN__>
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
   101ae:	4085                	li	ra,1
   101b0:	4101                	li	sp,0
   101b2:	00209733          	sll	a4,ra,sp
   101b6:	4385                	li	t2,1
   101b8:	24771a63          	bne	a4,t2,1040c <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	00209733          	sll	a4,ra,sp
   101c6:	4389                	li	t2,2
   101c8:	24771263          	bne	a4,t2,1040c <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	4085                	li	ra,1
   101d0:	411d                	li	sp,7
   101d2:	00209733          	sll	a4,ra,sp
   101d6:	08000393          	li	t2,128
   101da:	22771963          	bne	a4,t2,1040c <fail>

00000000000101de <test_5>:
   101de:	4195                	li	gp,5
   101e0:	4085                	li	ra,1
   101e2:	4139                	li	sp,14
   101e4:	00209733          	sll	a4,ra,sp
   101e8:	6391                	lui	t2,0x4
   101ea:	22771163          	bne	a4,t2,1040c <fail>

00000000000101ee <test_6>:
   101ee:	4199                	li	gp,6
   101f0:	4085                	li	ra,1
   101f2:	417d                	li	sp,31
   101f4:	00209733          	sll	a4,ra,sp
   101f8:	0010039b          	addw	t2,zero,1
   101fc:	03fe                	sll	t2,t2,0x1f
   101fe:	20771763          	bne	a4,t2,1040c <fail>

0000000000010202 <test_7>:
   10202:	419d                	li	gp,7
   10204:	50fd                	li	ra,-1
   10206:	4101                	li	sp,0
   10208:	00209733          	sll	a4,ra,sp
   1020c:	53fd                	li	t2,-1
   1020e:	1e771f63          	bne	a4,t2,1040c <fail>

0000000000010212 <test_8>:
   10212:	41a1                	li	gp,8
   10214:	50fd                	li	ra,-1
   10216:	4105                	li	sp,1
   10218:	00209733          	sll	a4,ra,sp
   1021c:	53f9                	li	t2,-2
   1021e:	1e771763          	bne	a4,t2,1040c <fail>

0000000000010222 <test_9>:
   10222:	41a5                	li	gp,9
   10224:	50fd                	li	ra,-1
   10226:	411d                	li	sp,7
   10228:	00209733          	sll	a4,ra,sp
   1022c:	f8000393          	li	t2,-128
   10230:	1c771e63          	bne	a4,t2,1040c <fail>

0000000000010234 <test_10>:
   10234:	41a9                	li	gp,10
   10236:	50fd                	li	ra,-1
   10238:	4139                	li	sp,14
   1023a:	00209733          	sll	a4,ra,sp
   1023e:	73f1                	lui	t2,0xffffc
   10240:	1c771663          	bne	a4,t2,1040c <fail>

0000000000010244 <test_11>:
   10244:	41ad                	li	gp,11
   10246:	50fd                	li	ra,-1
   10248:	417d                	li	sp,31
   1024a:	00209733          	sll	a4,ra,sp
   1024e:	800003b7          	lui	t2,0x80000
   10252:	1a771d63          	bne	a4,t2,1040c <fail>

0000000000010256 <test_12>:
   10256:	41b1                	li	gp,12
   10258:	212120b7          	lui	ra,0x21212
   1025c:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   10260:	4101                	li	sp,0
   10262:	00209733          	sll	a4,ra,sp
   10266:	212123b7          	lui	t2,0x21212
   1026a:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200231>
   1026e:	18771f63          	bne	a4,t2,1040c <fail>

0000000000010272 <test_13>:
   10272:	41b5                	li	gp,13
   10274:	212120b7          	lui	ra,0x21212
   10278:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   1027c:	4105                	li	sp,1
   1027e:	00209733          	sll	a4,ra,sp
   10282:	424243b7          	lui	t2,0x42424
   10286:	2423839b          	addw	t2,t2,578 # 42424242 <__global_pointer$+0x42412352>
   1028a:	18771163          	bne	a4,t2,1040c <fail>

000000000001028e <test_14>:
   1028e:	41b9                	li	gp,14
   10290:	212120b7          	lui	ra,0x21212
   10294:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   10298:	411d                	li	sp,7
   1029a:	00209733          	sll	a4,ra,sp
   1029e:	010913b7          	lui	t2,0x1091
   102a2:	9093839b          	addw	t2,t2,-1783 # 1090909 <__global_pointer$+0x107ea19>
   102a6:	03b2                	sll	t2,t2,0xc
   102a8:	08038393          	add	t2,t2,128
   102ac:	16771063          	bne	a4,t2,1040c <fail>

00000000000102b0 <test_15>:
   102b0:	41bd                	li	gp,15
   102b2:	212120b7          	lui	ra,0x21212
   102b6:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   102ba:	4139                	li	sp,14
   102bc:	00209733          	sll	a4,ra,sp
   102c0:	212123b7          	lui	t2,0x21212
   102c4:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200231>
   102c8:	03ba                	sll	t2,t2,0xe
   102ca:	14771163          	bne	a4,t2,1040c <fail>

00000000000102ce <test_16>:
   102ce:	41c1                	li	gp,16
   102d0:	212120b7          	lui	ra,0x21212
   102d4:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   102d8:	417d                	li	sp,31
   102da:	00209733          	sll	a4,ra,sp
   102de:	212123b7          	lui	t2,0x21212
   102e2:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200231>
   102e6:	03fe                	sll	t2,t2,0x1f
   102e8:	12771263          	bne	a4,t2,1040c <fail>

00000000000102ec <test_17>:
   102ec:	41c5                	li	gp,17
   102ee:	212120b7          	lui	ra,0x21212
   102f2:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   102f6:	fc000113          	li	sp,-64
   102fa:	00209733          	sll	a4,ra,sp
   102fe:	212123b7          	lui	t2,0x21212
   10302:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200231>
   10306:	10771363          	bne	a4,t2,1040c <fail>

000000000001030a <test_18>:
   1030a:	41c9                	li	gp,18
   1030c:	212120b7          	lui	ra,0x21212
   10310:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   10314:	fc100113          	li	sp,-63
   10318:	00209733          	sll	a4,ra,sp
   1031c:	424243b7          	lui	t2,0x42424
   10320:	2423839b          	addw	t2,t2,578 # 42424242 <__global_pointer$+0x42412352>
   10324:	0e771463          	bne	a4,t2,1040c <fail>

0000000000010328 <test_19>:
   10328:	41cd                	li	gp,19
   1032a:	212120b7          	lui	ra,0x21212
   1032e:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   10332:	fc700113          	li	sp,-57
   10336:	00209733          	sll	a4,ra,sp
   1033a:	010913b7          	lui	t2,0x1091
   1033e:	9093839b          	addw	t2,t2,-1783 # 1090909 <__global_pointer$+0x107ea19>
   10342:	03b2                	sll	t2,t2,0xc
   10344:	08038393          	add	t2,t2,128
   10348:	0c771263          	bne	a4,t2,1040c <fail>

000000000001034c <test_20>:
   1034c:	41d1                	li	gp,20
   1034e:	212120b7          	lui	ra,0x21212
   10352:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   10356:	fce00113          	li	sp,-50
   1035a:	00209733          	sll	a4,ra,sp
   1035e:	212123b7          	lui	t2,0x21212
   10362:	1213839b          	addw	t2,t2,289 # 21212121 <__global_pointer$+0x21200231>
   10366:	03ba                	sll	t2,t2,0xe
   10368:	0a771263          	bne	a4,t2,1040c <fail>

000000000001036c <test_21>:
   1036c:	41d5                	li	gp,21
   1036e:	212120b7          	lui	ra,0x21212
   10372:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   10376:	517d                	li	sp,-1
   10378:	00209733          	sll	a4,ra,sp
   1037c:	fff0039b          	addw	t2,zero,-1
   10380:	13fe                	sll	t2,t2,0x3f
   10382:	08771563          	bne	a4,t2,1040c <fail>

0000000000010386 <test_50>:
   10386:	03200193          	li	gp,50
   1038a:	4085                	li	ra,1
   1038c:	03f00113          	li	sp,63
   10390:	00209733          	sll	a4,ra,sp
   10394:	fff0039b          	addw	t2,zero,-1
   10398:	13fe                	sll	t2,t2,0x3f
   1039a:	06771963          	bne	a4,t2,1040c <fail>

000000000001039e <test_51>:
   1039e:	03300193          	li	gp,51
   103a2:	50fd                	li	ra,-1
   103a4:	02700113          	li	sp,39
   103a8:	00209733          	sll	a4,ra,sp
   103ac:	fff0039b          	addw	t2,zero,-1
   103b0:	139e                	sll	t2,t2,0x27
   103b2:	04771d63          	bne	a4,t2,1040c <fail>

00000000000103b6 <test_52>:
   103b6:	03400193          	li	gp,52
   103ba:	212120b7          	lui	ra,0x21212
   103be:	1210809b          	addw	ra,ra,289 # 21212121 <__global_pointer$+0x21200231>
   103c2:	02b00113          	li	sp,43
   103c6:	00209733          	sll	a4,ra,sp
   103ca:	63c9                	lui	t2,0x12
   103cc:	1213839b          	addw	t2,t2,289 # 12121 <__global_pointer$+0x231>
   103d0:	13ae                	sll	t2,t2,0x2b
   103d2:	02771d63          	bne	a4,t2,1040c <fail>

00000000000103d6 <test_22>:
   103d6:	41d9                	li	gp,22
   103d8:	4085                	li	ra,1
   103da:	411d                	li	sp,7
   103dc:	002090b3          	sll	ra,ra,sp
   103e0:	08000393          	li	t2,128
   103e4:	02709463          	bne	ra,t2,1040c <fail>

00000000000103e8 <test_23>:
   103e8:	41dd                	li	gp,23
   103ea:	4085                	li	ra,1
   103ec:	4139                	li	sp,14
   103ee:	00209133          	sll	sp,ra,sp
   103f2:	6391                	lui	t2,0x4
   103f4:	00711c63          	bne	sp,t2,1040c <fail>

00000000000103f8 <test_24>:
   103f8:	41e1                	li	gp,24
   103fa:	408d                	li	ra,3
   103fc:	001090b3          	sll	ra,ra,ra
   10400:	43e1                	li	t2,24
   10402:	00709563          	bne	ra,t2,1040c <fail>
   10406:	00301263          	bne	zero,gp,1040a <pass>

000000000001040a <pass>:
   1040a:	a019                	j	10410 <continue>

000000000001040c <fail>:
   1040c:	0000                	unimp
	...

0000000000010410 <continue>:
   10410:	4081                	li	ra,0
   10412:	4781                	li	a5,0
   10414:	853e                	mv	a0,a5
   10416:	6462                	ld	s0,24(sp)
   10418:	6105                	add	sp,sp,32
   1041a:	8082                	ret

000000000001041c <__libc_init_array>:
   1041c:	1101                	add	sp,sp,-32
   1041e:	e822                	sd	s0,16(sp)
   10420:	67c5                	lui	a5,0x11
   10422:	6445                	lui	s0,0x11
   10424:	e04a                	sd	s2,0(sp)
   10426:	6d478793          	add	a5,a5,1748 # 116d4 <__preinit_array_end>
   1042a:	6d440713          	add	a4,s0,1748 # 116d4 <__preinit_array_end>
   1042e:	ec06                	sd	ra,24(sp)
   10430:	e426                	sd	s1,8(sp)
   10432:	40e78933          	sub	s2,a5,a4
   10436:	00e78d63          	beq	a5,a4,10450 <__libc_init_array+0x34>
   1043a:	40395913          	sra	s2,s2,0x3
   1043e:	6d440413          	add	s0,s0,1748
   10442:	4481                	li	s1,0
   10444:	601c                	ld	a5,0(s0)
   10446:	0485                	add	s1,s1,1
   10448:	0421                	add	s0,s0,8
   1044a:	9782                	jalr	a5
   1044c:	ff24ece3          	bltu	s1,s2,10444 <__libc_init_array+0x28>
   10450:	6445                	lui	s0,0x11
   10452:	67c5                	lui	a5,0x11
   10454:	6e878793          	add	a5,a5,1768 # 116e8 <__do_global_dtors_aux_fini_array_entry>
   10458:	6d840713          	add	a4,s0,1752 # 116d8 <__init_array_start>
   1045c:	40e78933          	sub	s2,a5,a4
   10460:	40395913          	sra	s2,s2,0x3
   10464:	00e78b63          	beq	a5,a4,1047a <__libc_init_array+0x5e>
   10468:	6d840413          	add	s0,s0,1752
   1046c:	4481                	li	s1,0
   1046e:	601c                	ld	a5,0(s0)
   10470:	0485                	add	s1,s1,1
   10472:	0421                	add	s0,s0,8
   10474:	9782                	jalr	a5
   10476:	ff24ece3          	bltu	s1,s2,1046e <__libc_init_array+0x52>
   1047a:	60e2                	ld	ra,24(sp)
   1047c:	6442                	ld	s0,16(sp)
   1047e:	64a2                	ld	s1,8(sp)
   10480:	6902                	ld	s2,0(sp)
   10482:	6105                	add	sp,sp,32
   10484:	8082                	ret

0000000000010486 <memset>:
   10486:	433d                	li	t1,15
   10488:	872a                	mv	a4,a0
   1048a:	02c37163          	bgeu	t1,a2,104ac <memset+0x26>
   1048e:	00f77793          	and	a5,a4,15
   10492:	e3c1                	bnez	a5,10512 <memset+0x8c>
   10494:	e1bd                	bnez	a1,104fa <memset+0x74>
   10496:	ff067693          	and	a3,a2,-16
   1049a:	8a3d                	and	a2,a2,15
   1049c:	96ba                	add	a3,a3,a4
   1049e:	e30c                	sd	a1,0(a4)
   104a0:	e70c                	sd	a1,8(a4)
   104a2:	0741                	add	a4,a4,16
   104a4:	fed76de3          	bltu	a4,a3,1049e <memset+0x18>
   104a8:	e211                	bnez	a2,104ac <memset+0x26>
   104aa:	8082                	ret
   104ac:	40c306b3          	sub	a3,t1,a2
   104b0:	068a                	sll	a3,a3,0x2
   104b2:	00000297          	auipc	t0,0x0
   104b6:	9696                	add	a3,a3,t0
   104b8:	00a68067          	jr	10(a3)
   104bc:	00b70723          	sb	a1,14(a4)
   104c0:	00b706a3          	sb	a1,13(a4)
   104c4:	00b70623          	sb	a1,12(a4)
   104c8:	00b705a3          	sb	a1,11(a4)
   104cc:	00b70523          	sb	a1,10(a4)
   104d0:	00b704a3          	sb	a1,9(a4)
   104d4:	00b70423          	sb	a1,8(a4)
   104d8:	00b703a3          	sb	a1,7(a4)
   104dc:	00b70323          	sb	a1,6(a4)
   104e0:	00b702a3          	sb	a1,5(a4)
   104e4:	00b70223          	sb	a1,4(a4)
   104e8:	00b701a3          	sb	a1,3(a4)
   104ec:	00b70123          	sb	a1,2(a4)
   104f0:	00b700a3          	sb	a1,1(a4)
   104f4:	00b70023          	sb	a1,0(a4)
   104f8:	8082                	ret
   104fa:	0ff5f593          	zext.b	a1,a1
   104fe:	00859693          	sll	a3,a1,0x8
   10502:	8dd5                	or	a1,a1,a3
   10504:	01059693          	sll	a3,a1,0x10
   10508:	8dd5                	or	a1,a1,a3
   1050a:	02059693          	sll	a3,a1,0x20
   1050e:	8dd5                	or	a1,a1,a3
   10510:	b759                	j	10496 <memset+0x10>
   10512:	00279693          	sll	a3,a5,0x2
   10516:	00000297          	auipc	t0,0x0
   1051a:	9696                	add	a3,a3,t0
   1051c:	8286                	mv	t0,ra
   1051e:	fa2680e7          	jalr	-94(a3)
   10522:	8096                	mv	ra,t0
   10524:	17c1                	add	a5,a5,-16
   10526:	8f1d                	sub	a4,a4,a5
   10528:	963e                	add	a2,a2,a5
   1052a:	f8c371e3          	bgeu	t1,a2,104ac <memset+0x26>
   1052e:	b79d                	j	10494 <memset+0xe>

0000000000010530 <__call_exitprocs>:
   10530:	715d                	add	sp,sp,-80
   10532:	f052                	sd	s4,32(sp)
   10534:	f481ba03          	ld	s4,-184(gp) # 11e38 <_global_impure_ptr>
   10538:	f84a                	sd	s2,48(sp)
   1053a:	e486                	sd	ra,72(sp)
   1053c:	1f8a3903          	ld	s2,504(s4)
   10540:	e0a2                	sd	s0,64(sp)
   10542:	fc26                	sd	s1,56(sp)
   10544:	f44e                	sd	s3,40(sp)
   10546:	ec56                	sd	s5,24(sp)
   10548:	e85a                	sd	s6,16(sp)
   1054a:	e45e                	sd	s7,8(sp)
   1054c:	e062                	sd	s8,0(sp)
   1054e:	02090863          	beqz	s2,1057e <__call_exitprocs+0x4e>
   10552:	8b2a                	mv	s6,a0
   10554:	8bae                	mv	s7,a1
   10556:	4a85                	li	s5,1
   10558:	59fd                	li	s3,-1
   1055a:	00892483          	lw	s1,8(s2)
   1055e:	fff4841b          	addw	s0,s1,-1
   10562:	00044e63          	bltz	s0,1057e <__call_exitprocs+0x4e>
   10566:	048e                	sll	s1,s1,0x3
   10568:	94ca                	add	s1,s1,s2
   1056a:	020b8663          	beqz	s7,10596 <__call_exitprocs+0x66>
   1056e:	2084b783          	ld	a5,520(s1)
   10572:	03778263          	beq	a5,s7,10596 <__call_exitprocs+0x66>
   10576:	347d                	addw	s0,s0,-1
   10578:	14e1                	add	s1,s1,-8
   1057a:	ff3418e3          	bne	s0,s3,1056a <__call_exitprocs+0x3a>
   1057e:	60a6                	ld	ra,72(sp)
   10580:	6406                	ld	s0,64(sp)
   10582:	74e2                	ld	s1,56(sp)
   10584:	7942                	ld	s2,48(sp)
   10586:	79a2                	ld	s3,40(sp)
   10588:	7a02                	ld	s4,32(sp)
   1058a:	6ae2                	ld	s5,24(sp)
   1058c:	6b42                	ld	s6,16(sp)
   1058e:	6ba2                	ld	s7,8(sp)
   10590:	6c02                	ld	s8,0(sp)
   10592:	6161                	add	sp,sp,80
   10594:	8082                	ret
   10596:	00892783          	lw	a5,8(s2)
   1059a:	6498                	ld	a4,8(s1)
   1059c:	37fd                	addw	a5,a5,-1
   1059e:	04878463          	beq	a5,s0,105e6 <__call_exitprocs+0xb6>
   105a2:	0004b423          	sd	zero,8(s1)
   105a6:	db61                	beqz	a4,10576 <__call_exitprocs+0x46>
   105a8:	31092783          	lw	a5,784(s2)
   105ac:	008a96bb          	sllw	a3,s5,s0
   105b0:	00892c03          	lw	s8,8(s2)
   105b4:	8ff5                	and	a5,a5,a3
   105b6:	2781                	sext.w	a5,a5
   105b8:	ef89                	bnez	a5,105d2 <__call_exitprocs+0xa2>
   105ba:	9702                	jalr	a4
   105bc:	00892703          	lw	a4,8(s2)
   105c0:	1f8a3783          	ld	a5,504(s4)
   105c4:	01871463          	bne	a4,s8,105cc <__call_exitprocs+0x9c>
   105c8:	fb2787e3          	beq	a5,s2,10576 <__call_exitprocs+0x46>
   105cc:	dbcd                	beqz	a5,1057e <__call_exitprocs+0x4e>
   105ce:	893e                	mv	s2,a5
   105d0:	b769                	j	1055a <__call_exitprocs+0x2a>
   105d2:	31492783          	lw	a5,788(s2)
   105d6:	1084b583          	ld	a1,264(s1)
   105da:	8ff5                	and	a5,a5,a3
   105dc:	2781                	sext.w	a5,a5
   105de:	e799                	bnez	a5,105ec <__call_exitprocs+0xbc>
   105e0:	855a                	mv	a0,s6
   105e2:	9702                	jalr	a4
   105e4:	bfe1                	j	105bc <__call_exitprocs+0x8c>
   105e6:	00892423          	sw	s0,8(s2)
   105ea:	bf75                	j	105a6 <__call_exitprocs+0x76>
   105ec:	852e                	mv	a0,a1
   105ee:	9702                	jalr	a4
   105f0:	b7f1                	j	105bc <__call_exitprocs+0x8c>

00000000000105f2 <__libc_fini_array>:
   105f2:	1101                	add	sp,sp,-32
   105f4:	e822                	sd	s0,16(sp)
   105f6:	67c5                	lui	a5,0x11
   105f8:	6445                	lui	s0,0x11
   105fa:	6e878793          	add	a5,a5,1768 # 116e8 <__do_global_dtors_aux_fini_array_entry>
   105fe:	6f040413          	add	s0,s0,1776 # 116f0 <impure_data>
   10602:	8c1d                	sub	s0,s0,a5
   10604:	e426                	sd	s1,8(sp)
   10606:	ec06                	sd	ra,24(sp)
   10608:	40345493          	sra	s1,s0,0x3
   1060c:	c881                	beqz	s1,1061c <__libc_fini_array+0x2a>
   1060e:	1461                	add	s0,s0,-8
   10610:	943e                	add	s0,s0,a5
   10612:	601c                	ld	a5,0(s0)
   10614:	14fd                	add	s1,s1,-1
   10616:	1461                	add	s0,s0,-8
   10618:	9782                	jalr	a5
   1061a:	fce5                	bnez	s1,10612 <__libc_fini_array+0x20>
   1061c:	60e2                	ld	ra,24(sp)
   1061e:	6442                	ld	s0,16(sp)
   10620:	64a2                	ld	s1,8(sp)
   10622:	6105                	add	sp,sp,32
   10624:	8082                	ret

0000000000010626 <atexit>:
   10626:	85aa                	mv	a1,a0
   10628:	4681                	li	a3,0
   1062a:	4601                	li	a2,0
   1062c:	4501                	li	a0,0
   1062e:	a009                	j	10630 <__register_exitproc>

0000000000010630 <__register_exitproc>:
   10630:	f481b703          	ld	a4,-184(gp) # 11e38 <_global_impure_ptr>
   10634:	1f873783          	ld	a5,504(a4)
   10638:	c3b1                	beqz	a5,1067c <__register_exitproc+0x4c>
   1063a:	4798                	lw	a4,8(a5)
   1063c:	487d                	li	a6,31
   1063e:	06e84263          	blt	a6,a4,106a2 <__register_exitproc+0x72>
   10642:	c505                	beqz	a0,1066a <__register_exitproc+0x3a>
   10644:	00371813          	sll	a6,a4,0x3
   10648:	983e                	add	a6,a6,a5
   1064a:	10c83823          	sd	a2,272(a6)
   1064e:	3107a883          	lw	a7,784(a5)
   10652:	4605                	li	a2,1
   10654:	00e6163b          	sllw	a2,a2,a4
   10658:	00c8e8b3          	or	a7,a7,a2
   1065c:	3117a823          	sw	a7,784(a5)
   10660:	20d83823          	sd	a3,528(a6)
   10664:	4689                	li	a3,2
   10666:	02d50063          	beq	a0,a3,10686 <__register_exitproc+0x56>
   1066a:	00270693          	add	a3,a4,2
   1066e:	068e                	sll	a3,a3,0x3
   10670:	2705                	addw	a4,a4,1
   10672:	c798                	sw	a4,8(a5)
   10674:	97b6                	add	a5,a5,a3
   10676:	e38c                	sd	a1,0(a5)
   10678:	4501                	li	a0,0
   1067a:	8082                	ret
   1067c:	20070793          	add	a5,a4,512
   10680:	1ef73c23          	sd	a5,504(a4)
   10684:	bf5d                	j	1063a <__register_exitproc+0xa>
   10686:	3147a683          	lw	a3,788(a5)
   1068a:	4501                	li	a0,0
   1068c:	8ed1                	or	a3,a3,a2
   1068e:	30d7aa23          	sw	a3,788(a5)
   10692:	00270693          	add	a3,a4,2
   10696:	068e                	sll	a3,a3,0x3
   10698:	2705                	addw	a4,a4,1
   1069a:	c798                	sw	a4,8(a5)
   1069c:	97b6                	add	a5,a5,a3
   1069e:	e38c                	sd	a1,0(a5)
   106a0:	8082                	ret
   106a2:	557d                	li	a0,-1
   106a4:	8082                	ret

00000000000106a6 <_exit>:
   106a6:	05d00893          	li	a7,93
   106aa:	00000073          	ecall
   106ae:	00054363          	bltz	a0,106b4 <_exit+0xe>
   106b2:	a001                	j	106b2 <_exit+0xc>
   106b4:	1141                	add	sp,sp,-16
   106b6:	e022                	sd	s0,0(sp)
   106b8:	842a                	mv	s0,a0
   106ba:	e406                	sd	ra,8(sp)
   106bc:	4080043b          	negw	s0,s0
   106c0:	008000ef          	jal	106c8 <__errno>
   106c4:	c100                	sw	s0,0(a0)
   106c6:	a001                	j	106c6 <_exit+0x20>

00000000000106c8 <__errno>:
   106c8:	f581b503          	ld	a0,-168(gp) # 11e48 <_impure_ptr>
   106cc:	8082                	ret

subw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	32a000ef          	jal	1041c <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d20 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	490000ef          	jal	10592 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4de50513          	add	a0,a0,1246 # 104de <__libc_fini_array>
   10112:	a101                	j	10512 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cc218193          	add	gp,gp,-830 # 11dd8 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d38 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d70 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	248000ef          	jal	10372 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3e450513          	add	a0,a0,996 # 10512 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3a650513          	add	a0,a0,934 # 104de <__libc_fini_array>
   10140:	3d2000ef          	jal	10512 <atexit>
   10144:	1c4000ef          	jal	10308 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d38 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5bc50513          	add	a0,a0,1468 # 115bc <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d38 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d40 <object.0>
   1018e:	5bc50513          	add	a0,a0,1468 # 115bc <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	4101                	li	sp,0
   101b2:	4020873b          	subw	a4,ra,sp
   101b6:	4381                	li	t2,0
   101b8:	14771063          	bne	a4,t2,102f8 <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	4020873b          	subw	a4,ra,sp
   101c6:	4381                	li	t2,0
   101c8:	12771863          	bne	a4,t2,102f8 <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	408d                	li	ra,3
   101d0:	411d                	li	sp,7
   101d2:	4020873b          	subw	a4,ra,sp
   101d6:	53f1                	li	t2,-4
   101d8:	12771063          	bne	a4,t2,102f8 <fail>

00000000000101dc <test_5>:
   101dc:	4195                	li	gp,5
   101de:	4081                	li	ra,0
   101e0:	ffff8137          	lui	sp,0xffff8
   101e4:	4020873b          	subw	a4,ra,sp
   101e8:	63a1                	lui	t2,0x8
   101ea:	10771763          	bne	a4,t2,102f8 <fail>

00000000000101ee <test_6>:
   101ee:	4199                	li	gp,6
   101f0:	800000b7          	lui	ra,0x80000
   101f4:	4101                	li	sp,0
   101f6:	4020873b          	subw	a4,ra,sp
   101fa:	800003b7          	lui	t2,0x80000
   101fe:	0e771d63          	bne	a4,t2,102f8 <fail>

0000000000010202 <test_7>:
   10202:	419d                	li	gp,7
   10204:	800000b7          	lui	ra,0x80000
   10208:	ffff8137          	lui	sp,0xffff8
   1020c:	4020873b          	subw	a4,ra,sp
   10210:	800083b7          	lui	t2,0x80008
   10214:	0e771263          	bne	a4,t2,102f8 <fail>

0000000000010218 <test_8>:
   10218:	41a1                	li	gp,8
   1021a:	4081                	li	ra,0
   1021c:	00008137          	lui	sp,0x8
   10220:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10222:	4020873b          	subw	a4,ra,sp
   10226:	73e1                	lui	t2,0xffff8
   10228:	2385                	addw	t2,t2,1 # ffffffffffff8001 <__global_pointer$+0xfffffffffffe6229>
   1022a:	0c771763          	bne	a4,t2,102f8 <fail>

000000000001022e <test_9>:
   1022e:	41a5                	li	gp,9
   10230:	800000b7          	lui	ra,0x80000
   10234:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   10236:	4101                	li	sp,0
   10238:	4020873b          	subw	a4,ra,sp
   1023c:	800003b7          	lui	t2,0x80000
   10240:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   10242:	0a771b63          	bne	a4,t2,102f8 <fail>

0000000000010246 <test_10>:
   10246:	41a9                	li	gp,10
   10248:	800000b7          	lui	ra,0x80000
   1024c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   1024e:	00008137          	lui	sp,0x8
   10252:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10254:	4020873b          	subw	a4,ra,sp
   10258:	7fff83b7          	lui	t2,0x7fff8
   1025c:	08771e63          	bne	a4,t2,102f8 <fail>

0000000000010260 <test_11>:
   10260:	41ad                	li	gp,11
   10262:	800000b7          	lui	ra,0x80000
   10266:	00008137          	lui	sp,0x8
   1026a:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1026c:	4020873b          	subw	a4,ra,sp
   10270:	7fff83b7          	lui	t2,0x7fff8
   10274:	2385                	addw	t2,t2,1 # 7fff8001 <__global_pointer$+0x7ffe6229>
   10276:	08771163          	bne	a4,t2,102f8 <fail>

000000000001027a <test_12>:
   1027a:	41b1                	li	gp,12
   1027c:	800000b7          	lui	ra,0x80000
   10280:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee227>
   10282:	ffff8137          	lui	sp,0xffff8
   10286:	4020873b          	subw	a4,ra,sp
   1028a:	800083b7          	lui	t2,0x80008
   1028e:	33fd                	addw	t2,t2,-1 # ffffffff80007fff <__global_pointer$+0xffffffff7fff6227>
   10290:	06771463          	bne	a4,t2,102f8 <fail>

0000000000010294 <test_13>:
   10294:	41b5                	li	gp,13
   10296:	4081                	li	ra,0
   10298:	517d                	li	sp,-1
   1029a:	4020873b          	subw	a4,ra,sp
   1029e:	4385                	li	t2,1
   102a0:	04771c63          	bne	a4,t2,102f8 <fail>

00000000000102a4 <test_14>:
   102a4:	41b9                	li	gp,14
   102a6:	50fd                	li	ra,-1
   102a8:	4105                	li	sp,1
   102aa:	4020873b          	subw	a4,ra,sp
   102ae:	53f9                	li	t2,-2
   102b0:	04771463          	bne	a4,t2,102f8 <fail>

00000000000102b4 <test_15>:
   102b4:	41bd                	li	gp,15
   102b6:	50fd                	li	ra,-1
   102b8:	517d                	li	sp,-1
   102ba:	4020873b          	subw	a4,ra,sp
   102be:	4381                	li	t2,0
   102c0:	02771c63          	bne	a4,t2,102f8 <fail>

00000000000102c4 <test_16>:
   102c4:	41c1                	li	gp,16
   102c6:	40b5                	li	ra,13
   102c8:	412d                	li	sp,11
   102ca:	402080bb          	subw	ra,ra,sp
   102ce:	4389                	li	t2,2
   102d0:	02709463          	bne	ra,t2,102f8 <fail>

00000000000102d4 <test_17>:
   102d4:	41c5                	li	gp,17
   102d6:	40b9                	li	ra,14
   102d8:	412d                	li	sp,11
   102da:	4020813b          	subw	sp,ra,sp
   102de:	438d                	li	t2,3
   102e0:	00711c63          	bne	sp,t2,102f8 <fail>

00000000000102e4 <test_18>:
   102e4:	41c9                	li	gp,18
   102e6:	40b5                	li	ra,13
   102e8:	401080bb          	subw	ra,ra,ra
   102ec:	4381                	li	t2,0
   102ee:	00709563          	bne	ra,t2,102f8 <fail>
   102f2:	00301263          	bne	zero,gp,102f6 <pass>

00000000000102f6 <pass>:
   102f6:	a019                	j	102fc <continue>

00000000000102f8 <fail>:
   102f8:	0000                	unimp
	...

00000000000102fc <continue>:
   102fc:	4081                	li	ra,0
   102fe:	4781                	li	a5,0
   10300:	853e                	mv	a0,a5
   10302:	6462                	ld	s0,24(sp)
   10304:	6105                	add	sp,sp,32
   10306:	8082                	ret

0000000000010308 <__libc_init_array>:
   10308:	1101                	add	sp,sp,-32 # ffffffffffff7fe0 <__global_pointer$+0xfffffffffffe6208>
   1030a:	e822                	sd	s0,16(sp)
   1030c:	67c5                	lui	a5,0x11
   1030e:	6445                	lui	s0,0x11
   10310:	e04a                	sd	s2,0(sp)
   10312:	5c078793          	add	a5,a5,1472 # 115c0 <__init_array_start>
   10316:	5c040713          	add	a4,s0,1472 # 115c0 <__init_array_start>
   1031a:	ec06                	sd	ra,24(sp)
   1031c:	e426                	sd	s1,8(sp)
   1031e:	40e78933          	sub	s2,a5,a4
   10322:	00e78d63          	beq	a5,a4,1033c <__libc_init_array+0x34>
   10326:	40395913          	sra	s2,s2,0x3
   1032a:	5c040413          	add	s0,s0,1472
   1032e:	4481                	li	s1,0
   10330:	601c                	ld	a5,0(s0)
   10332:	0485                	add	s1,s1,1
   10334:	0421                	add	s0,s0,8
   10336:	9782                	jalr	a5
   10338:	ff24ece3          	bltu	s1,s2,10330 <__libc_init_array+0x28>
   1033c:	6445                	lui	s0,0x11
   1033e:	67c5                	lui	a5,0x11
   10340:	5d078793          	add	a5,a5,1488 # 115d0 <__do_global_dtors_aux_fini_array_entry>
   10344:	5c040713          	add	a4,s0,1472 # 115c0 <__init_array_start>
   10348:	40e78933          	sub	s2,a5,a4
   1034c:	40395913          	sra	s2,s2,0x3
   10350:	00e78b63          	beq	a5,a4,10366 <__libc_init_array+0x5e>
   10354:	5c040413          	add	s0,s0,1472
   10358:	4481                	li	s1,0
   1035a:	601c                	ld	a5,0(s0)
   1035c:	0485                	add	s1,s1,1
   1035e:	0421                	add	s0,s0,8
   10360:	9782                	jalr	a5
   10362:	ff24ece3          	bltu	s1,s2,1035a <__libc_init_array+0x52>
   10366:	60e2                	ld	ra,24(sp)
   10368:	6442                	ld	s0,16(sp)
   1036a:	64a2                	ld	s1,8(sp)
   1036c:	6902                	ld	s2,0(sp)
   1036e:	6105                	add	sp,sp,32
   10370:	8082                	ret

0000000000010372 <memset>:
   10372:	433d                	li	t1,15
   10374:	872a                	mv	a4,a0
   10376:	02c37163          	bgeu	t1,a2,10398 <memset+0x26>
   1037a:	00f77793          	and	a5,a4,15
   1037e:	e3c1                	bnez	a5,103fe <memset+0x8c>
   10380:	e1bd                	bnez	a1,103e6 <memset+0x74>
   10382:	ff067693          	and	a3,a2,-16
   10386:	8a3d                	and	a2,a2,15
   10388:	96ba                	add	a3,a3,a4
   1038a:	e30c                	sd	a1,0(a4)
   1038c:	e70c                	sd	a1,8(a4)
   1038e:	0741                	add	a4,a4,16
   10390:	fed76de3          	bltu	a4,a3,1038a <memset+0x18>
   10394:	e211                	bnez	a2,10398 <memset+0x26>
   10396:	8082                	ret
   10398:	40c306b3          	sub	a3,t1,a2
   1039c:	068a                	sll	a3,a3,0x2
   1039e:	00000297          	auipc	t0,0x0
   103a2:	9696                	add	a3,a3,t0
   103a4:	00a68067          	jr	10(a3)
   103a8:	00b70723          	sb	a1,14(a4)
   103ac:	00b706a3          	sb	a1,13(a4)
   103b0:	00b70623          	sb	a1,12(a4)
   103b4:	00b705a3          	sb	a1,11(a4)
   103b8:	00b70523          	sb	a1,10(a4)
   103bc:	00b704a3          	sb	a1,9(a4)
   103c0:	00b70423          	sb	a1,8(a4)
   103c4:	00b703a3          	sb	a1,7(a4)
   103c8:	00b70323          	sb	a1,6(a4)
   103cc:	00b702a3          	sb	a1,5(a4)
   103d0:	00b70223          	sb	a1,4(a4)
   103d4:	00b701a3          	sb	a1,3(a4)
   103d8:	00b70123          	sb	a1,2(a4)
   103dc:	00b700a3          	sb	a1,1(a4)
   103e0:	00b70023          	sb	a1,0(a4)
   103e4:	8082                	ret
   103e6:	0ff5f593          	zext.b	a1,a1
   103ea:	00859693          	sll	a3,a1,0x8
   103ee:	8dd5                	or	a1,a1,a3
   103f0:	01059693          	sll	a3,a1,0x10
   103f4:	8dd5                	or	a1,a1,a3
   103f6:	02059693          	sll	a3,a1,0x20
   103fa:	8dd5                	or	a1,a1,a3
   103fc:	b759                	j	10382 <memset+0x10>
   103fe:	00279693          	sll	a3,a5,0x2
   10402:	00000297          	auipc	t0,0x0
   10406:	9696                	add	a3,a3,t0
   10408:	8286                	mv	t0,ra
   1040a:	fa2680e7          	jalr	-94(a3)
   1040e:	8096                	mv	ra,t0
   10410:	17c1                	add	a5,a5,-16
   10412:	8f1d                	sub	a4,a4,a5
   10414:	963e                	add	a2,a2,a5
   10416:	f8c371e3          	bgeu	t1,a2,10398 <memset+0x26>
   1041a:	b79d                	j	10380 <memset+0xe>

000000000001041c <__call_exitprocs>:
   1041c:	715d                	add	sp,sp,-80
   1041e:	f052                	sd	s4,32(sp)
   10420:	f481ba03          	ld	s4,-184(gp) # 11d20 <_global_impure_ptr>
   10424:	f84a                	sd	s2,48(sp)
   10426:	e486                	sd	ra,72(sp)
   10428:	1f8a3903          	ld	s2,504(s4)
   1042c:	e0a2                	sd	s0,64(sp)
   1042e:	fc26                	sd	s1,56(sp)
   10430:	f44e                	sd	s3,40(sp)
   10432:	ec56                	sd	s5,24(sp)
   10434:	e85a                	sd	s6,16(sp)
   10436:	e45e                	sd	s7,8(sp)
   10438:	e062                	sd	s8,0(sp)
   1043a:	02090863          	beqz	s2,1046a <__call_exitprocs+0x4e>
   1043e:	8b2a                	mv	s6,a0
   10440:	8bae                	mv	s7,a1
   10442:	4a85                	li	s5,1
   10444:	59fd                	li	s3,-1
   10446:	00892483          	lw	s1,8(s2)
   1044a:	fff4841b          	addw	s0,s1,-1
   1044e:	00044e63          	bltz	s0,1046a <__call_exitprocs+0x4e>
   10452:	048e                	sll	s1,s1,0x3
   10454:	94ca                	add	s1,s1,s2
   10456:	020b8663          	beqz	s7,10482 <__call_exitprocs+0x66>
   1045a:	2084b783          	ld	a5,520(s1)
   1045e:	03778263          	beq	a5,s7,10482 <__call_exitprocs+0x66>
   10462:	347d                	addw	s0,s0,-1
   10464:	14e1                	add	s1,s1,-8
   10466:	ff3418e3          	bne	s0,s3,10456 <__call_exitprocs+0x3a>
   1046a:	60a6                	ld	ra,72(sp)
   1046c:	6406                	ld	s0,64(sp)
   1046e:	74e2                	ld	s1,56(sp)
   10470:	7942                	ld	s2,48(sp)
   10472:	79a2                	ld	s3,40(sp)
   10474:	7a02                	ld	s4,32(sp)
   10476:	6ae2                	ld	s5,24(sp)
   10478:	6b42                	ld	s6,16(sp)
   1047a:	6ba2                	ld	s7,8(sp)
   1047c:	6c02                	ld	s8,0(sp)
   1047e:	6161                	add	sp,sp,80
   10480:	8082                	ret
   10482:	00892783          	lw	a5,8(s2)
   10486:	6498                	ld	a4,8(s1)
   10488:	37fd                	addw	a5,a5,-1
   1048a:	04878463          	beq	a5,s0,104d2 <__call_exitprocs+0xb6>
   1048e:	0004b423          	sd	zero,8(s1)
   10492:	db61                	beqz	a4,10462 <__call_exitprocs+0x46>
   10494:	31092783          	lw	a5,784(s2)
   10498:	008a96bb          	sllw	a3,s5,s0
   1049c:	00892c03          	lw	s8,8(s2)
   104a0:	8ff5                	and	a5,a5,a3
   104a2:	2781                	sext.w	a5,a5
   104a4:	ef89                	bnez	a5,104be <__call_exitprocs+0xa2>
   104a6:	9702                	jalr	a4
   104a8:	00892703          	lw	a4,8(s2)
   104ac:	1f8a3783          	ld	a5,504(s4)
   104b0:	01871463          	bne	a4,s8,104b8 <__call_exitprocs+0x9c>
   104b4:	fb2787e3          	beq	a5,s2,10462 <__call_exitprocs+0x46>
   104b8:	dbcd                	beqz	a5,1046a <__call_exitprocs+0x4e>
   104ba:	893e                	mv	s2,a5
   104bc:	b769                	j	10446 <__call_exitprocs+0x2a>
   104be:	31492783          	lw	a5,788(s2)
   104c2:	1084b583          	ld	a1,264(s1)
   104c6:	8ff5                	and	a5,a5,a3
   104c8:	2781                	sext.w	a5,a5
   104ca:	e799                	bnez	a5,104d8 <__call_exitprocs+0xbc>
   104cc:	855a                	mv	a0,s6
   104ce:	9702                	jalr	a4
   104d0:	bfe1                	j	104a8 <__call_exitprocs+0x8c>
   104d2:	00892423          	sw	s0,8(s2)
   104d6:	bf75                	j	10492 <__call_exitprocs+0x76>
   104d8:	852e                	mv	a0,a1
   104da:	9702                	jalr	a4
   104dc:	b7f1                	j	104a8 <__call_exitprocs+0x8c>

00000000000104de <__libc_fini_array>:
   104de:	1101                	add	sp,sp,-32
   104e0:	e822                	sd	s0,16(sp)
   104e2:	67c5                	lui	a5,0x11
   104e4:	6445                	lui	s0,0x11
   104e6:	5d078793          	add	a5,a5,1488 # 115d0 <__do_global_dtors_aux_fini_array_entry>
   104ea:	5d840413          	add	s0,s0,1496 # 115d8 <impure_data>
   104ee:	8c1d                	sub	s0,s0,a5
   104f0:	e426                	sd	s1,8(sp)
   104f2:	ec06                	sd	ra,24(sp)
   104f4:	40345493          	sra	s1,s0,0x3
   104f8:	c881                	beqz	s1,10508 <__libc_fini_array+0x2a>
   104fa:	1461                	add	s0,s0,-8
   104fc:	943e                	add	s0,s0,a5
   104fe:	601c                	ld	a5,0(s0)
   10500:	14fd                	add	s1,s1,-1
   10502:	1461                	add	s0,s0,-8
   10504:	9782                	jalr	a5
   10506:	fce5                	bnez	s1,104fe <__libc_fini_array+0x20>
   10508:	60e2                	ld	ra,24(sp)
   1050a:	6442                	ld	s0,16(sp)
   1050c:	64a2                	ld	s1,8(sp)
   1050e:	6105                	add	sp,sp,32
   10510:	8082                	ret

0000000000010512 <atexit>:
   10512:	85aa                	mv	a1,a0
   10514:	4681                	li	a3,0
   10516:	4601                	li	a2,0
   10518:	4501                	li	a0,0
   1051a:	a009                	j	1051c <__register_exitproc>

000000000001051c <__register_exitproc>:
   1051c:	f481b703          	ld	a4,-184(gp) # 11d20 <_global_impure_ptr>
   10520:	1f873783          	ld	a5,504(a4)
   10524:	c3b1                	beqz	a5,10568 <__register_exitproc+0x4c>
   10526:	4798                	lw	a4,8(a5)
   10528:	487d                	li	a6,31
   1052a:	06e84263          	blt	a6,a4,1058e <__register_exitproc+0x72>
   1052e:	c505                	beqz	a0,10556 <__register_exitproc+0x3a>
   10530:	00371813          	sll	a6,a4,0x3
   10534:	983e                	add	a6,a6,a5
   10536:	10c83823          	sd	a2,272(a6)
   1053a:	3107a883          	lw	a7,784(a5)
   1053e:	4605                	li	a2,1
   10540:	00e6163b          	sllw	a2,a2,a4
   10544:	00c8e8b3          	or	a7,a7,a2
   10548:	3117a823          	sw	a7,784(a5)
   1054c:	20d83823          	sd	a3,528(a6)
   10550:	4689                	li	a3,2
   10552:	02d50063          	beq	a0,a3,10572 <__register_exitproc+0x56>
   10556:	00270693          	add	a3,a4,2
   1055a:	068e                	sll	a3,a3,0x3
   1055c:	2705                	addw	a4,a4,1
   1055e:	c798                	sw	a4,8(a5)
   10560:	97b6                	add	a5,a5,a3
   10562:	e38c                	sd	a1,0(a5)
   10564:	4501                	li	a0,0
   10566:	8082                	ret
   10568:	20070793          	add	a5,a4,512
   1056c:	1ef73c23          	sd	a5,504(a4)
   10570:	bf5d                	j	10526 <__register_exitproc+0xa>
   10572:	3147a683          	lw	a3,788(a5)
   10576:	4501                	li	a0,0
   10578:	8ed1                	or	a3,a3,a2
   1057a:	30d7aa23          	sw	a3,788(a5)
   1057e:	00270693          	add	a3,a4,2
   10582:	068e                	sll	a3,a3,0x3
   10584:	2705                	addw	a4,a4,1
   10586:	c798                	sw	a4,8(a5)
   10588:	97b6                	add	a5,a5,a3
   1058a:	e38c                	sd	a1,0(a5)
   1058c:	8082                	ret
   1058e:	557d                	li	a0,-1
   10590:	8082                	ret

0000000000010592 <_exit>:
   10592:	05d00893          	li	a7,93
   10596:	00000073          	ecall
   1059a:	00054363          	bltz	a0,105a0 <_exit+0xe>
   1059e:	a001                	j	1059e <_exit+0xc>
   105a0:	1141                	add	sp,sp,-16
   105a2:	e022                	sd	s0,0(sp)
   105a4:	842a                	mv	s0,a0
   105a6:	e406                	sd	ra,8(sp)
   105a8:	4080043b          	negw	s0,s0
   105ac:	008000ef          	jal	105b4 <__errno>
   105b0:	c100                	sw	s0,0(a0)
   105b2:	a001                	j	105b2 <_exit+0x20>

00000000000105b4 <__errno>:
   105b4:	f581b503          	ld	a0,-168(gp) # 11d30 <_impure_ptr>
   105b8:	8082                	ret

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

or.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	2f0000ef          	jal	103e2 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11ce8 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	456000ef          	jal	10558 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4a450513          	add	a0,a0,1188 # 104a4 <__libc_fini_array>
   10112:	a6d9                	j	104d8 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	c8a18193          	add	gp,gp,-886 # 11da0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d00 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d38 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	20e000ef          	jal	10338 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3aa50513          	add	a0,a0,938 # 104d8 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	36c50513          	add	a0,a0,876 # 104a4 <__libc_fini_array>
   10140:	398000ef          	jal	104d8 <atexit>
   10144:	18a000ef          	jal	102ce <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d00 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d00 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d08 <object.0>
   1018e:	58050513          	add	a0,a0,1408 # 11580 <__EH_FRAME_BEGIN__>
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
   101ae:	60c1                	lui	ra,0x10
   101b0:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   101b4:	00c2                	sll	ra,ra,0x10
   101b6:	f0008093          	add	ra,ra,-256
   101ba:	0f0f1137          	lui	sp,0xf0f1
   101be:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df16f>
   101c2:	0020e733          	or	a4,ra,sp
   101c6:	6385                	lui	t2,0x1
   101c8:	33c5                	addw	t2,t2,-15 # ff1 <exit-0xf0f7>
   101ca:	03d2                	sll	t2,t2,0x14
   101cc:	f0f38393          	add	t2,t2,-241
   101d0:	0e771763          	bne	a4,t2,102be <fail>

00000000000101d4 <test_3>:
   101d4:	418d                	li	gp,3
   101d6:	0ff010b7          	lui	ra,0xff01
   101da:	30c1                	addw	ra,ra,-16 # ff00ff0 <__global_pointer$+0xfeef250>
   101dc:	000f1137          	lui	sp,0xf1
   101e0:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf16f>
   101e4:	0132                	sll	sp,sp,0xc
   101e6:	616d                	add	sp,sp,240
   101e8:	0020e733          	or	a4,ra,sp
   101ec:	63c1                	lui	t2,0x10
   101ee:	33c5                	addw	t2,t2,-15 # fff1 <exit-0xf7>
   101f0:	03c2                	sll	t2,t2,0x10
   101f2:	13c1                	add	t2,t2,-16
   101f4:	0c771563          	bne	a4,t2,102be <fail>

00000000000101f8 <test_4>:
   101f8:	4191                	li	gp,4
   101fa:	00ff00b7          	lui	ra,0xff0
   101fe:	0ff0809b          	addw	ra,ra,255 # ff00ff <__global_pointer$+0xfde35f>
   10202:	0f0f1137          	lui	sp,0xf0f1
   10206:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df16f>
   1020a:	0020e733          	or	a4,ra,sp
   1020e:	0fff13b7          	lui	t2,0xfff1
   10212:	33fd                	addw	t2,t2,-1 # fff0fff <__global_pointer$+0xffdf25f>
   10214:	0a771563          	bne	a4,t2,102be <fail>

0000000000010218 <test_5>:
   10218:	4195                	li	gp,5
   1021a:	000f00b7          	lui	ra,0xf0
   1021e:	0ff0809b          	addw	ra,ra,255 # f00ff <__global_pointer$+0xde35f>
   10222:	00b2                	sll	ra,ra,0xc
   10224:	00bd                	add	ra,ra,15
   10226:	000f1137          	lui	sp,0xf1
   1022a:	f0f1011b          	addw	sp,sp,-241 # f0f0f <__global_pointer$+0xdf16f>
   1022e:	0132                	sll	sp,sp,0xc
   10230:	616d                	add	sp,sp,240
   10232:	0020e733          	or	a4,ra,sp
   10236:	000f13b7          	lui	t2,0xf1
   1023a:	33fd                	addw	t2,t2,-1 # f0fff <__global_pointer$+0xdf25f>
   1023c:	03b2                	sll	t2,t2,0xc
   1023e:	0ff38393          	add	t2,t2,255
   10242:	06771e63          	bne	a4,t2,102be <fail>

0000000000010246 <test_6>:
   10246:	4199                	li	gp,6
   10248:	60c1                	lui	ra,0x10
   1024a:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   1024e:	00c2                	sll	ra,ra,0x10
   10250:	f0008093          	add	ra,ra,-256
   10254:	0f0f1137          	lui	sp,0xf0f1
   10258:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df16f>
   1025c:	0020e0b3          	or	ra,ra,sp
   10260:	6385                	lui	t2,0x1
   10262:	33c5                	addw	t2,t2,-15 # ff1 <exit-0xf0f7>
   10264:	03d2                	sll	t2,t2,0x14
   10266:	f0f38393          	add	t2,t2,-241
   1026a:	04709a63          	bne	ra,t2,102be <fail>

000000000001026e <test_7>:
   1026e:	419d                	li	gp,7
   10270:	60c1                	lui	ra,0x10
   10272:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   10276:	00c2                	sll	ra,ra,0x10
   10278:	f0008093          	add	ra,ra,-256
   1027c:	0f0f1137          	lui	sp,0xf0f1
   10280:	f0f1011b          	addw	sp,sp,-241 # f0f0f0f <__global_pointer$+0xf0df16f>
   10284:	0020e133          	or	sp,ra,sp
   10288:	6385                	lui	t2,0x1
   1028a:	33c5                	addw	t2,t2,-15 # ff1 <exit-0xf0f7>
   1028c:	03d2                	sll	t2,t2,0x14
   1028e:	f0f38393          	add	t2,t2,-241
   10292:	02711663          	bne	sp,t2,102be <fail>

0000000000010296 <test_8>:
   10296:	41a1                	li	gp,8
   10298:	60c1                	lui	ra,0x10
   1029a:	f010809b          	addw	ra,ra,-255 # ff01 <exit-0x1e7>
   1029e:	00c2                	sll	ra,ra,0x10
   102a0:	f0008093          	add	ra,ra,-256
   102a4:	0010e0b3          	or	ra,ra,ra
   102a8:	63c1                	lui	t2,0x10
   102aa:	f013839b          	addw	t2,t2,-255 # ff01 <exit-0x1e7>
   102ae:	03c2                	sll	t2,t2,0x10
   102b0:	f0038393          	add	t2,t2,-256
   102b4:	00709563          	bne	ra,t2,102be <fail>
   102b8:	00301263          	bne	zero,gp,102bc <pass>

00000000000102bc <pass>:
   102bc:	a019                	j	102c2 <continue>

00000000000102be <fail>:
   102be:	0000                	unimp
	...

00000000000102c2 <continue>:
   102c2:	4081                	li	ra,0
   102c4:	4781                	li	a5,0
   102c6:	853e                	mv	a0,a5
   102c8:	6462                	ld	s0,24(sp)
   102ca:	6105                	add	sp,sp,32
   102cc:	8082                	ret

00000000000102ce <__libc_init_array>:
   102ce:	1101                	add	sp,sp,-32
   102d0:	e822                	sd	s0,16(sp)
   102d2:	67c5                	lui	a5,0x11
   102d4:	6445                	lui	s0,0x11
   102d6:	e04a                	sd	s2,0(sp)
   102d8:	58478793          	add	a5,a5,1412 # 11584 <__preinit_array_end>
   102dc:	58440713          	add	a4,s0,1412 # 11584 <__preinit_array_end>
   102e0:	ec06                	sd	ra,24(sp)
   102e2:	e426                	sd	s1,8(sp)
   102e4:	40e78933          	sub	s2,a5,a4
   102e8:	00e78d63          	beq	a5,a4,10302 <__libc_init_array+0x34>
   102ec:	40395913          	sra	s2,s2,0x3
   102f0:	58440413          	add	s0,s0,1412
   102f4:	4481                	li	s1,0
   102f6:	601c                	ld	a5,0(s0)
   102f8:	0485                	add	s1,s1,1
   102fa:	0421                	add	s0,s0,8
   102fc:	9782                	jalr	a5
   102fe:	ff24ece3          	bltu	s1,s2,102f6 <__libc_init_array+0x28>
   10302:	6445                	lui	s0,0x11
   10304:	67c5                	lui	a5,0x11
   10306:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   1030a:	58840713          	add	a4,s0,1416 # 11588 <__init_array_start>
   1030e:	40e78933          	sub	s2,a5,a4
   10312:	40395913          	sra	s2,s2,0x3
   10316:	00e78b63          	beq	a5,a4,1032c <__libc_init_array+0x5e>
   1031a:	58840413          	add	s0,s0,1416
   1031e:	4481                	li	s1,0
   10320:	601c                	ld	a5,0(s0)
   10322:	0485                	add	s1,s1,1
   10324:	0421                	add	s0,s0,8
   10326:	9782                	jalr	a5
   10328:	ff24ece3          	bltu	s1,s2,10320 <__libc_init_array+0x52>
   1032c:	60e2                	ld	ra,24(sp)
   1032e:	6442                	ld	s0,16(sp)
   10330:	64a2                	ld	s1,8(sp)
   10332:	6902                	ld	s2,0(sp)
   10334:	6105                	add	sp,sp,32
   10336:	8082                	ret

0000000000010338 <memset>:
   10338:	433d                	li	t1,15
   1033a:	872a                	mv	a4,a0
   1033c:	02c37163          	bgeu	t1,a2,1035e <memset+0x26>
   10340:	00f77793          	and	a5,a4,15
   10344:	e3c1                	bnez	a5,103c4 <memset+0x8c>
   10346:	e1bd                	bnez	a1,103ac <memset+0x74>
   10348:	ff067693          	and	a3,a2,-16
   1034c:	8a3d                	and	a2,a2,15
   1034e:	96ba                	add	a3,a3,a4
   10350:	e30c                	sd	a1,0(a4)
   10352:	e70c                	sd	a1,8(a4)
   10354:	0741                	add	a4,a4,16
   10356:	fed76de3          	bltu	a4,a3,10350 <memset+0x18>
   1035a:	e211                	bnez	a2,1035e <memset+0x26>
   1035c:	8082                	ret
   1035e:	40c306b3          	sub	a3,t1,a2
   10362:	068a                	sll	a3,a3,0x2
   10364:	00000297          	auipc	t0,0x0
   10368:	9696                	add	a3,a3,t0
   1036a:	00a68067          	jr	10(a3)
   1036e:	00b70723          	sb	a1,14(a4)
   10372:	00b706a3          	sb	a1,13(a4)
   10376:	00b70623          	sb	a1,12(a4)
   1037a:	00b705a3          	sb	a1,11(a4)
   1037e:	00b70523          	sb	a1,10(a4)
   10382:	00b704a3          	sb	a1,9(a4)
   10386:	00b70423          	sb	a1,8(a4)
   1038a:	00b703a3          	sb	a1,7(a4)
   1038e:	00b70323          	sb	a1,6(a4)
   10392:	00b702a3          	sb	a1,5(a4)
   10396:	00b70223          	sb	a1,4(a4)
   1039a:	00b701a3          	sb	a1,3(a4)
   1039e:	00b70123          	sb	a1,2(a4)
   103a2:	00b700a3          	sb	a1,1(a4)
   103a6:	00b70023          	sb	a1,0(a4)
   103aa:	8082                	ret
   103ac:	0ff5f593          	zext.b	a1,a1
   103b0:	00859693          	sll	a3,a1,0x8
   103b4:	8dd5                	or	a1,a1,a3
   103b6:	01059693          	sll	a3,a1,0x10
   103ba:	8dd5                	or	a1,a1,a3
   103bc:	02059693          	sll	a3,a1,0x20
   103c0:	8dd5                	or	a1,a1,a3
   103c2:	b759                	j	10348 <memset+0x10>
   103c4:	00279693          	sll	a3,a5,0x2
   103c8:	00000297          	auipc	t0,0x0
   103cc:	9696                	add	a3,a3,t0
   103ce:	8286                	mv	t0,ra
   103d0:	fa2680e7          	jalr	-94(a3)
   103d4:	8096                	mv	ra,t0
   103d6:	17c1                	add	a5,a5,-16
   103d8:	8f1d                	sub	a4,a4,a5
   103da:	963e                	add	a2,a2,a5
   103dc:	f8c371e3          	bgeu	t1,a2,1035e <memset+0x26>
   103e0:	b79d                	j	10346 <memset+0xe>

00000000000103e2 <__call_exitprocs>:
   103e2:	715d                	add	sp,sp,-80
   103e4:	f052                	sd	s4,32(sp)
   103e6:	f481ba03          	ld	s4,-184(gp) # 11ce8 <_global_impure_ptr>
   103ea:	f84a                	sd	s2,48(sp)
   103ec:	e486                	sd	ra,72(sp)
   103ee:	1f8a3903          	ld	s2,504(s4)
   103f2:	e0a2                	sd	s0,64(sp)
   103f4:	fc26                	sd	s1,56(sp)
   103f6:	f44e                	sd	s3,40(sp)
   103f8:	ec56                	sd	s5,24(sp)
   103fa:	e85a                	sd	s6,16(sp)
   103fc:	e45e                	sd	s7,8(sp)
   103fe:	e062                	sd	s8,0(sp)
   10400:	02090863          	beqz	s2,10430 <__call_exitprocs+0x4e>
   10404:	8b2a                	mv	s6,a0
   10406:	8bae                	mv	s7,a1
   10408:	4a85                	li	s5,1
   1040a:	59fd                	li	s3,-1
   1040c:	00892483          	lw	s1,8(s2)
   10410:	fff4841b          	addw	s0,s1,-1
   10414:	00044e63          	bltz	s0,10430 <__call_exitprocs+0x4e>
   10418:	048e                	sll	s1,s1,0x3
   1041a:	94ca                	add	s1,s1,s2
   1041c:	020b8663          	beqz	s7,10448 <__call_exitprocs+0x66>
   10420:	2084b783          	ld	a5,520(s1)
   10424:	03778263          	beq	a5,s7,10448 <__call_exitprocs+0x66>
   10428:	347d                	addw	s0,s0,-1
   1042a:	14e1                	add	s1,s1,-8
   1042c:	ff3418e3          	bne	s0,s3,1041c <__call_exitprocs+0x3a>
   10430:	60a6                	ld	ra,72(sp)
   10432:	6406                	ld	s0,64(sp)
   10434:	74e2                	ld	s1,56(sp)
   10436:	7942                	ld	s2,48(sp)
   10438:	79a2                	ld	s3,40(sp)
   1043a:	7a02                	ld	s4,32(sp)
   1043c:	6ae2                	ld	s5,24(sp)
   1043e:	6b42                	ld	s6,16(sp)
   10440:	6ba2                	ld	s7,8(sp)
   10442:	6c02                	ld	s8,0(sp)
   10444:	6161                	add	sp,sp,80
   10446:	8082                	ret
   10448:	00892783          	lw	a5,8(s2)
   1044c:	6498                	ld	a4,8(s1)
   1044e:	37fd                	addw	a5,a5,-1
   10450:	04878463          	beq	a5,s0,10498 <__call_exitprocs+0xb6>
   10454:	0004b423          	sd	zero,8(s1)
   10458:	db61                	beqz	a4,10428 <__call_exitprocs+0x46>
   1045a:	31092783          	lw	a5,784(s2)
   1045e:	008a96bb          	sllw	a3,s5,s0
   10462:	00892c03          	lw	s8,8(s2)
   10466:	8ff5                	and	a5,a5,a3
   10468:	2781                	sext.w	a5,a5
   1046a:	ef89                	bnez	a5,10484 <__call_exitprocs+0xa2>
   1046c:	9702                	jalr	a4
   1046e:	00892703          	lw	a4,8(s2)
   10472:	1f8a3783          	ld	a5,504(s4)
   10476:	01871463          	bne	a4,s8,1047e <__call_exitprocs+0x9c>
   1047a:	fb2787e3          	beq	a5,s2,10428 <__call_exitprocs+0x46>
   1047e:	dbcd                	beqz	a5,10430 <__call_exitprocs+0x4e>
   10480:	893e                	mv	s2,a5
   10482:	b769                	j	1040c <__call_exitprocs+0x2a>
   10484:	31492783          	lw	a5,788(s2)
   10488:	1084b583          	ld	a1,264(s1)
   1048c:	8ff5                	and	a5,a5,a3
   1048e:	2781                	sext.w	a5,a5
   10490:	e799                	bnez	a5,1049e <__call_exitprocs+0xbc>
   10492:	855a                	mv	a0,s6
   10494:	9702                	jalr	a4
   10496:	bfe1                	j	1046e <__call_exitprocs+0x8c>
   10498:	00892423          	sw	s0,8(s2)
   1049c:	bf75                	j	10458 <__call_exitprocs+0x76>
   1049e:	852e                	mv	a0,a1
   104a0:	9702                	jalr	a4
   104a2:	b7f1                	j	1046e <__call_exitprocs+0x8c>

00000000000104a4 <__libc_fini_array>:
   104a4:	1101                	add	sp,sp,-32
   104a6:	e822                	sd	s0,16(sp)
   104a8:	67c5                	lui	a5,0x11
   104aa:	6445                	lui	s0,0x11
   104ac:	59878793          	add	a5,a5,1432 # 11598 <__do_global_dtors_aux_fini_array_entry>
   104b0:	5a040413          	add	s0,s0,1440 # 115a0 <impure_data>
   104b4:	8c1d                	sub	s0,s0,a5
   104b6:	e426                	sd	s1,8(sp)
   104b8:	ec06                	sd	ra,24(sp)
   104ba:	40345493          	sra	s1,s0,0x3
   104be:	c881                	beqz	s1,104ce <__libc_fini_array+0x2a>
   104c0:	1461                	add	s0,s0,-8
   104c2:	943e                	add	s0,s0,a5
   104c4:	601c                	ld	a5,0(s0)
   104c6:	14fd                	add	s1,s1,-1
   104c8:	1461                	add	s0,s0,-8
   104ca:	9782                	jalr	a5
   104cc:	fce5                	bnez	s1,104c4 <__libc_fini_array+0x20>
   104ce:	60e2                	ld	ra,24(sp)
   104d0:	6442                	ld	s0,16(sp)
   104d2:	64a2                	ld	s1,8(sp)
   104d4:	6105                	add	sp,sp,32
   104d6:	8082                	ret

00000000000104d8 <atexit>:
   104d8:	85aa                	mv	a1,a0
   104da:	4681                	li	a3,0
   104dc:	4601                	li	a2,0
   104de:	4501                	li	a0,0
   104e0:	a009                	j	104e2 <__register_exitproc>

00000000000104e2 <__register_exitproc>:
   104e2:	f481b703          	ld	a4,-184(gp) # 11ce8 <_global_impure_ptr>
   104e6:	1f873783          	ld	a5,504(a4)
   104ea:	c3b1                	beqz	a5,1052e <__register_exitproc+0x4c>
   104ec:	4798                	lw	a4,8(a5)
   104ee:	487d                	li	a6,31
   104f0:	06e84263          	blt	a6,a4,10554 <__register_exitproc+0x72>
   104f4:	c505                	beqz	a0,1051c <__register_exitproc+0x3a>
   104f6:	00371813          	sll	a6,a4,0x3
   104fa:	983e                	add	a6,a6,a5
   104fc:	10c83823          	sd	a2,272(a6)
   10500:	3107a883          	lw	a7,784(a5)
   10504:	4605                	li	a2,1
   10506:	00e6163b          	sllw	a2,a2,a4
   1050a:	00c8e8b3          	or	a7,a7,a2
   1050e:	3117a823          	sw	a7,784(a5)
   10512:	20d83823          	sd	a3,528(a6)
   10516:	4689                	li	a3,2
   10518:	02d50063          	beq	a0,a3,10538 <__register_exitproc+0x56>
   1051c:	00270693          	add	a3,a4,2
   10520:	068e                	sll	a3,a3,0x3
   10522:	2705                	addw	a4,a4,1
   10524:	c798                	sw	a4,8(a5)
   10526:	97b6                	add	a5,a5,a3
   10528:	e38c                	sd	a1,0(a5)
   1052a:	4501                	li	a0,0
   1052c:	8082                	ret
   1052e:	20070793          	add	a5,a4,512
   10532:	1ef73c23          	sd	a5,504(a4)
   10536:	bf5d                	j	104ec <__register_exitproc+0xa>
   10538:	3147a683          	lw	a3,788(a5)
   1053c:	4501                	li	a0,0
   1053e:	8ed1                	or	a3,a3,a2
   10540:	30d7aa23          	sw	a3,788(a5)
   10544:	00270693          	add	a3,a4,2
   10548:	068e                	sll	a3,a3,0x3
   1054a:	2705                	addw	a4,a4,1
   1054c:	c798                	sw	a4,8(a5)
   1054e:	97b6                	add	a5,a5,a3
   10550:	e38c                	sd	a1,0(a5)
   10552:	8082                	ret
   10554:	557d                	li	a0,-1
   10556:	8082                	ret

0000000000010558 <_exit>:
   10558:	05d00893          	li	a7,93
   1055c:	00000073          	ecall
   10560:	00054363          	bltz	a0,10566 <_exit+0xe>
   10564:	a001                	j	10564 <_exit+0xc>
   10566:	1141                	add	sp,sp,-16
   10568:	e022                	sd	s0,0(sp)
   1056a:	842a                	mv	s0,a0
   1056c:	e406                	sd	ra,8(sp)
   1056e:	4080043b          	negw	s0,s0
   10572:	008000ef          	jal	1057a <__errno>
   10576:	c100                	sw	s0,0(a0)
   10578:	a001                	j	10578 <_exit+0x20>

000000000001057a <__errno>:
   1057a:	f581b503          	ld	a0,-168(gp) # 11cf8 <_impure_ptr>
   1057e:	8082                	ret

sraiw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	3a8000ef          	jal	1049a <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11da0 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	50e000ef          	jal	10610 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	55c50513          	add	a0,a0,1372 # 1055c <__libc_fini_array>
   10112:	a9bd                	j	10590 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	d4218193          	add	gp,gp,-702 # 11e58 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11db8 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11df0 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	2c6000ef          	jal	103f0 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	46250513          	add	a0,a0,1122 # 10590 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	42450513          	add	a0,a0,1060 # 1055c <__libc_fini_array>
   10140:	450000ef          	jal	10590 <atexit>
   10144:	242000ef          	jal	10386 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11db8 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	63850513          	add	a0,a0,1592 # 11638 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11db8 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11dc0 <object.0>
   1018e:	63850513          	add	a0,a0,1592 # 11638 <__EH_FRAME_BEGIN__>
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
   101ae:	800000b7          	lui	ra,0x80000
   101b2:	4000d71b          	sraw	a4,ra,0x0
   101b6:	800003b7          	lui	t2,0x80000
   101ba:	1a771e63          	bne	a4,t2,10376 <fail>

00000000000101be <test_3>:
   101be:	418d                	li	gp,3
   101c0:	800000b7          	lui	ra,0x80000
   101c4:	4010d71b          	sraw	a4,ra,0x1
   101c8:	c00003b7          	lui	t2,0xc0000
   101cc:	1a771563          	bne	a4,t2,10376 <fail>

00000000000101d0 <test_4>:
   101d0:	4191                	li	gp,4
   101d2:	800000b7          	lui	ra,0x80000
   101d6:	4070d71b          	sraw	a4,ra,0x7
   101da:	ff0003b7          	lui	t2,0xff000
   101de:	18771c63          	bne	a4,t2,10376 <fail>

00000000000101e2 <test_5>:
   101e2:	4195                	li	gp,5
   101e4:	800000b7          	lui	ra,0x80000
   101e8:	40e0d71b          	sraw	a4,ra,0xe
   101ec:	7381                	lui	t2,0xfffe0
   101ee:	18771463          	bne	a4,t2,10376 <fail>

00000000000101f2 <test_6>:
   101f2:	4199                	li	gp,6
   101f4:	800000b7          	lui	ra,0x80000
   101f8:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee1a9>
   101fa:	41f0d71b          	sraw	a4,ra,0x1f
   101fe:	53fd                	li	t2,-1
   10200:	16771b63          	bne	a4,t2,10376 <fail>

0000000000010204 <test_7>:
   10204:	419d                	li	gp,7
   10206:	800000b7          	lui	ra,0x80000
   1020a:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1a7>
   1020c:	4000d71b          	sraw	a4,ra,0x0
   10210:	800003b7          	lui	t2,0x80000
   10214:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee1a7>
   10216:	16771063          	bne	a4,t2,10376 <fail>

000000000001021a <test_8>:
   1021a:	41a1                	li	gp,8
   1021c:	800000b7          	lui	ra,0x80000
   10220:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1a7>
   10222:	4010d71b          	sraw	a4,ra,0x1
   10226:	400003b7          	lui	t2,0x40000
   1022a:	33fd                	addw	t2,t2,-1 # 3fffffff <__global_pointer$+0x3ffee1a7>
   1022c:	14771563          	bne	a4,t2,10376 <fail>

0000000000010230 <test_9>:
   10230:	41a5                	li	gp,9
   10232:	800000b7          	lui	ra,0x80000
   10236:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1a7>
   10238:	4070d71b          	sraw	a4,ra,0x7
   1023c:	010003b7          	lui	t2,0x1000
   10240:	33fd                	addw	t2,t2,-1 # ffffff <__global_pointer$+0xfee1a7>
   10242:	12771a63          	bne	a4,t2,10376 <fail>

0000000000010246 <test_10>:
   10246:	41a9                	li	gp,10
   10248:	800000b7          	lui	ra,0x80000
   1024c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1a7>
   1024e:	40e0d71b          	sraw	a4,ra,0xe
   10252:	000203b7          	lui	t2,0x20
   10256:	33fd                	addw	t2,t2,-1 # 1ffff <__global_pointer$+0xe1a7>
   10258:	10771f63          	bne	a4,t2,10376 <fail>

000000000001025c <test_11>:
   1025c:	41ad                	li	gp,11
   1025e:	800000b7          	lui	ra,0x80000
   10262:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee1a7>
   10264:	41f0d71b          	sraw	a4,ra,0x1f
   10268:	4381                	li	t2,0
   1026a:	10771663          	bne	a4,t2,10376 <fail>

000000000001026e <test_12>:
   1026e:	41b1                	li	gp,12
   10270:	818180b7          	lui	ra,0x81818
   10274:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806329>
   10278:	4000d71b          	sraw	a4,ra,0x0
   1027c:	818183b7          	lui	t2,0x81818
   10280:	1813839b          	addw	t2,t2,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806329>
   10284:	0e771963          	bne	a4,t2,10376 <fail>

0000000000010288 <test_13>:
   10288:	41b5                	li	gp,13
   1028a:	818180b7          	lui	ra,0x81818
   1028e:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806329>
   10292:	4010d71b          	sraw	a4,ra,0x1
   10296:	c0c0c3b7          	lui	t2,0xc0c0c
   1029a:	0c03839b          	addw	t2,t2,192 # ffffffffc0c0c0c0 <__global_pointer$+0xffffffffc0bfa268>
   1029e:	0c771c63          	bne	a4,t2,10376 <fail>

00000000000102a2 <test_14>:
   102a2:	41b9                	li	gp,14
   102a4:	818180b7          	lui	ra,0x81818
   102a8:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806329>
   102ac:	4070d71b          	sraw	a4,ra,0x7
   102b0:	ff0303b7          	lui	t2,0xff030
   102b4:	3033839b          	addw	t2,t2,771 # ffffffffff030303 <__global_pointer$+0xffffffffff01e4ab>
   102b8:	0a771f63          	bne	a4,t2,10376 <fail>

00000000000102bc <test_15>:
   102bc:	41bd                	li	gp,15
   102be:	818180b7          	lui	ra,0x81818
   102c2:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806329>
   102c6:	40e0d71b          	sraw	a4,ra,0xe
   102ca:	7381                	lui	t2,0xfffe0
   102cc:	6063839b          	addw	t2,t2,1542 # fffffffffffe0606 <__global_pointer$+0xfffffffffffce7ae>
   102d0:	0a771363          	bne	a4,t2,10376 <fail>

00000000000102d4 <test_16>:
   102d4:	41c1                	li	gp,16
   102d6:	818180b7          	lui	ra,0x81818
   102da:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff81806329>
   102de:	41f0d71b          	sraw	a4,ra,0x1f
   102e2:	53fd                	li	t2,-1
   102e4:	08771963          	bne	a4,t2,10376 <fail>

00000000000102e8 <test_44>:
   102e8:	02c00193          	li	gp,44
   102ec:	fff120b7          	lui	ra,0xfff12
   102f0:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff004ed>
   102f4:	00b2                	sll	ra,ra,0xc
   102f6:	67808093          	add	ra,ra,1656
   102fa:	4000d71b          	sraw	a4,ra,0x0
   102fe:	123453b7          	lui	t2,0x12345
   10302:	6783839b          	addw	t2,t2,1656 # 12345678 <__global_pointer$+0x12333820>
   10306:	06771863          	bne	a4,t2,10376 <fail>

000000000001030a <test_45>:
   1030a:	02d00193          	li	gp,45
   1030e:	fff120b7          	lui	ra,0xfff12
   10312:	3450809b          	addw	ra,ra,837 # fffffffffff12345 <__global_pointer$+0xfffffffffff004ed>
   10316:	00b2                	sll	ra,ra,0xc
   10318:	67808093          	add	ra,ra,1656
   1031c:	4040d71b          	sraw	a4,ra,0x4
   10320:	012343b7          	lui	t2,0x1234
   10324:	5673839b          	addw	t2,t2,1383 # 1234567 <__global_pointer$+0x122270f>
   10328:	04771763          	bne	a4,t2,10376 <fail>

000000000001032c <test_46>:
   1032c:	02e00193          	li	gp,46
   10330:	000920b7          	lui	ra,0x92
   10334:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x804ed>
   10338:	00b2                	sll	ra,ra,0xc
   1033a:	67808093          	add	ra,ra,1656
   1033e:	4000d71b          	sraw	a4,ra,0x0
   10342:	923453b7          	lui	t2,0x92345
   10346:	6783839b          	addw	t2,t2,1656 # ffffffff92345678 <__global_pointer$+0xffffffff92333820>
   1034a:	02771663          	bne	a4,t2,10376 <fail>

000000000001034e <test_47>:
   1034e:	02f00193          	li	gp,47
   10352:	000920b7          	lui	ra,0x92
   10356:	3450809b          	addw	ra,ra,837 # 92345 <__global_pointer$+0x804ed>
   1035a:	00b2                	sll	ra,ra,0xc
   1035c:	67808093          	add	ra,ra,1656
   10360:	4040d71b          	sraw	a4,ra,0x4
   10364:	f92343b7          	lui	t2,0xf9234
   10368:	5673839b          	addw	t2,t2,1383 # fffffffff9234567 <__global_pointer$+0xfffffffff922270f>
   1036c:	00771563          	bne	a4,t2,10376 <fail>
   10370:	00301263          	bne	zero,gp,10374 <pass>

0000000000010374 <pass>:
   10374:	a019                	j	1037a <continue>

0000000000010376 <fail>:
   10376:	0000                	unimp
	...

000000000001037a <continue>:
   1037a:	4081                	li	ra,0
   1037c:	4781                	li	a5,0
   1037e:	853e                	mv	a0,a5
   10380:	6462                	ld	s0,24(sp)
   10382:	6105                	add	sp,sp,32
   10384:	8082                	ret

0000000000010386 <__libc_init_array>:
   10386:	1101                	add	sp,sp,-32
   10388:	e822                	sd	s0,16(sp)
   1038a:	67c5                	lui	a5,0x11
   1038c:	6445                	lui	s0,0x11
   1038e:	e04a                	sd	s2,0(sp)
   10390:	63c78793          	add	a5,a5,1596 # 1163c <__preinit_array_end>
   10394:	63c40713          	add	a4,s0,1596 # 1163c <__preinit_array_end>
   10398:	ec06                	sd	ra,24(sp)
   1039a:	e426                	sd	s1,8(sp)
   1039c:	40e78933          	sub	s2,a5,a4
   103a0:	00e78d63          	beq	a5,a4,103ba <__libc_init_array+0x34>
   103a4:	40395913          	sra	s2,s2,0x3
   103a8:	63c40413          	add	s0,s0,1596
   103ac:	4481                	li	s1,0
   103ae:	601c                	ld	a5,0(s0)
   103b0:	0485                	add	s1,s1,1
   103b2:	0421                	add	s0,s0,8
   103b4:	9782                	jalr	a5
   103b6:	ff24ece3          	bltu	s1,s2,103ae <__libc_init_array+0x28>
   103ba:	6445                	lui	s0,0x11
   103bc:	67c5                	lui	a5,0x11
   103be:	65078793          	add	a5,a5,1616 # 11650 <__do_global_dtors_aux_fini_array_entry>
   103c2:	64040713          	add	a4,s0,1600 # 11640 <__init_array_start>
   103c6:	40e78933          	sub	s2,a5,a4
   103ca:	40395913          	sra	s2,s2,0x3
   103ce:	00e78b63          	beq	a5,a4,103e4 <__libc_init_array+0x5e>
   103d2:	64040413          	add	s0,s0,1600
   103d6:	4481                	li	s1,0
   103d8:	601c                	ld	a5,0(s0)
   103da:	0485                	add	s1,s1,1
   103dc:	0421                	add	s0,s0,8
   103de:	9782                	jalr	a5
   103e0:	ff24ece3          	bltu	s1,s2,103d8 <__libc_init_array+0x52>
   103e4:	60e2                	ld	ra,24(sp)
   103e6:	6442                	ld	s0,16(sp)
   103e8:	64a2                	ld	s1,8(sp)
   103ea:	6902                	ld	s2,0(sp)
   103ec:	6105                	add	sp,sp,32
   103ee:	8082                	ret

00000000000103f0 <memset>:
   103f0:	433d                	li	t1,15
   103f2:	872a                	mv	a4,a0
   103f4:	02c37163          	bgeu	t1,a2,10416 <memset+0x26>
   103f8:	00f77793          	and	a5,a4,15
   103fc:	e3c1                	bnez	a5,1047c <memset+0x8c>
   103fe:	e1bd                	bnez	a1,10464 <memset+0x74>
   10400:	ff067693          	and	a3,a2,-16
   10404:	8a3d                	and	a2,a2,15
   10406:	96ba                	add	a3,a3,a4
   10408:	e30c                	sd	a1,0(a4)
   1040a:	e70c                	sd	a1,8(a4)
   1040c:	0741                	add	a4,a4,16
   1040e:	fed76de3          	bltu	a4,a3,10408 <memset+0x18>
   10412:	e211                	bnez	a2,10416 <memset+0x26>
   10414:	8082                	ret
   10416:	40c306b3          	sub	a3,t1,a2
   1041a:	068a                	sll	a3,a3,0x2
   1041c:	00000297          	auipc	t0,0x0
   10420:	9696                	add	a3,a3,t0
   10422:	00a68067          	jr	10(a3)
   10426:	00b70723          	sb	a1,14(a4)
   1042a:	00b706a3          	sb	a1,13(a4)
   1042e:	00b70623          	sb	a1,12(a4)
   10432:	00b705a3          	sb	a1,11(a4)
   10436:	00b70523          	sb	a1,10(a4)
   1043a:	00b704a3          	sb	a1,9(a4)
   1043e:	00b70423          	sb	a1,8(a4)
   10442:	00b703a3          	sb	a1,7(a4)
   10446:	00b70323          	sb	a1,6(a4)
   1044a:	00b702a3          	sb	a1,5(a4)
   1044e:	00b70223          	sb	a1,4(a4)
   10452:	00b701a3          	sb	a1,3(a4)
   10456:	00b70123          	sb	a1,2(a4)
   1045a:	00b700a3          	sb	a1,1(a4)
   1045e:	00b70023          	sb	a1,0(a4)
   10462:	8082                	ret
   10464:	0ff5f593          	zext.b	a1,a1
   10468:	00859693          	sll	a3,a1,0x8
   1046c:	8dd5                	or	a1,a1,a3
   1046e:	01059693          	sll	a3,a1,0x10
   10472:	8dd5                	or	a1,a1,a3
   10474:	02059693          	sll	a3,a1,0x20
   10478:	8dd5                	or	a1,a1,a3
   1047a:	b759                	j	10400 <memset+0x10>
   1047c:	00279693          	sll	a3,a5,0x2
   10480:	00000297          	auipc	t0,0x0
   10484:	9696                	add	a3,a3,t0
   10486:	8286                	mv	t0,ra
   10488:	fa2680e7          	jalr	-94(a3)
   1048c:	8096                	mv	ra,t0
   1048e:	17c1                	add	a5,a5,-16
   10490:	8f1d                	sub	a4,a4,a5
   10492:	963e                	add	a2,a2,a5
   10494:	f8c371e3          	bgeu	t1,a2,10416 <memset+0x26>
   10498:	b79d                	j	103fe <memset+0xe>

000000000001049a <__call_exitprocs>:
   1049a:	715d                	add	sp,sp,-80
   1049c:	f052                	sd	s4,32(sp)
   1049e:	f481ba03          	ld	s4,-184(gp) # 11da0 <_global_impure_ptr>
   104a2:	f84a                	sd	s2,48(sp)
   104a4:	e486                	sd	ra,72(sp)
   104a6:	1f8a3903          	ld	s2,504(s4)
   104aa:	e0a2                	sd	s0,64(sp)
   104ac:	fc26                	sd	s1,56(sp)
   104ae:	f44e                	sd	s3,40(sp)
   104b0:	ec56                	sd	s5,24(sp)
   104b2:	e85a                	sd	s6,16(sp)
   104b4:	e45e                	sd	s7,8(sp)
   104b6:	e062                	sd	s8,0(sp)
   104b8:	02090863          	beqz	s2,104e8 <__call_exitprocs+0x4e>
   104bc:	8b2a                	mv	s6,a0
   104be:	8bae                	mv	s7,a1
   104c0:	4a85                	li	s5,1
   104c2:	59fd                	li	s3,-1
   104c4:	00892483          	lw	s1,8(s2)
   104c8:	fff4841b          	addw	s0,s1,-1
   104cc:	00044e63          	bltz	s0,104e8 <__call_exitprocs+0x4e>
   104d0:	048e                	sll	s1,s1,0x3
   104d2:	94ca                	add	s1,s1,s2
   104d4:	020b8663          	beqz	s7,10500 <__call_exitprocs+0x66>
   104d8:	2084b783          	ld	a5,520(s1)
   104dc:	03778263          	beq	a5,s7,10500 <__call_exitprocs+0x66>
   104e0:	347d                	addw	s0,s0,-1
   104e2:	14e1                	add	s1,s1,-8
   104e4:	ff3418e3          	bne	s0,s3,104d4 <__call_exitprocs+0x3a>
   104e8:	60a6                	ld	ra,72(sp)
   104ea:	6406                	ld	s0,64(sp)
   104ec:	74e2                	ld	s1,56(sp)
   104ee:	7942                	ld	s2,48(sp)
   104f0:	79a2                	ld	s3,40(sp)
   104f2:	7a02                	ld	s4,32(sp)
   104f4:	6ae2                	ld	s5,24(sp)
   104f6:	6b42                	ld	s6,16(sp)
   104f8:	6ba2                	ld	s7,8(sp)
   104fa:	6c02                	ld	s8,0(sp)
   104fc:	6161                	add	sp,sp,80
   104fe:	8082                	ret
   10500:	00892783          	lw	a5,8(s2)
   10504:	6498                	ld	a4,8(s1)
   10506:	37fd                	addw	a5,a5,-1
   10508:	04878463          	beq	a5,s0,10550 <__call_exitprocs+0xb6>
   1050c:	0004b423          	sd	zero,8(s1)
   10510:	db61                	beqz	a4,104e0 <__call_exitprocs+0x46>
   10512:	31092783          	lw	a5,784(s2)
   10516:	008a96bb          	sllw	a3,s5,s0
   1051a:	00892c03          	lw	s8,8(s2)
   1051e:	8ff5                	and	a5,a5,a3
   10520:	2781                	sext.w	a5,a5
   10522:	ef89                	bnez	a5,1053c <__call_exitprocs+0xa2>
   10524:	9702                	jalr	a4
   10526:	00892703          	lw	a4,8(s2)
   1052a:	1f8a3783          	ld	a5,504(s4)
   1052e:	01871463          	bne	a4,s8,10536 <__call_exitprocs+0x9c>
   10532:	fb2787e3          	beq	a5,s2,104e0 <__call_exitprocs+0x46>
   10536:	dbcd                	beqz	a5,104e8 <__call_exitprocs+0x4e>
   10538:	893e                	mv	s2,a5
   1053a:	b769                	j	104c4 <__call_exitprocs+0x2a>
   1053c:	31492783          	lw	a5,788(s2)
   10540:	1084b583          	ld	a1,264(s1)
   10544:	8ff5                	and	a5,a5,a3
   10546:	2781                	sext.w	a5,a5
   10548:	e799                	bnez	a5,10556 <__call_exitprocs+0xbc>
   1054a:	855a                	mv	a0,s6
   1054c:	9702                	jalr	a4
   1054e:	bfe1                	j	10526 <__call_exitprocs+0x8c>
   10550:	00892423          	sw	s0,8(s2)
   10554:	bf75                	j	10510 <__call_exitprocs+0x76>
   10556:	852e                	mv	a0,a1
   10558:	9702                	jalr	a4
   1055a:	b7f1                	j	10526 <__call_exitprocs+0x8c>

000000000001055c <__libc_fini_array>:
   1055c:	1101                	add	sp,sp,-32
   1055e:	e822                	sd	s0,16(sp)
   10560:	67c5                	lui	a5,0x11
   10562:	6445                	lui	s0,0x11
   10564:	65078793          	add	a5,a5,1616 # 11650 <__do_global_dtors_aux_fini_array_entry>
   10568:	65840413          	add	s0,s0,1624 # 11658 <impure_data>
   1056c:	8c1d                	sub	s0,s0,a5
   1056e:	e426                	sd	s1,8(sp)
   10570:	ec06                	sd	ra,24(sp)
   10572:	40345493          	sra	s1,s0,0x3
   10576:	c881                	beqz	s1,10586 <__libc_fini_array+0x2a>
   10578:	1461                	add	s0,s0,-8
   1057a:	943e                	add	s0,s0,a5
   1057c:	601c                	ld	a5,0(s0)
   1057e:	14fd                	add	s1,s1,-1
   10580:	1461                	add	s0,s0,-8
   10582:	9782                	jalr	a5
   10584:	fce5                	bnez	s1,1057c <__libc_fini_array+0x20>
   10586:	60e2                	ld	ra,24(sp)
   10588:	6442                	ld	s0,16(sp)
   1058a:	64a2                	ld	s1,8(sp)
   1058c:	6105                	add	sp,sp,32
   1058e:	8082                	ret

0000000000010590 <atexit>:
   10590:	85aa                	mv	a1,a0
   10592:	4681                	li	a3,0
   10594:	4601                	li	a2,0
   10596:	4501                	li	a0,0
   10598:	a009                	j	1059a <__register_exitproc>

000000000001059a <__register_exitproc>:
   1059a:	f481b703          	ld	a4,-184(gp) # 11da0 <_global_impure_ptr>
   1059e:	1f873783          	ld	a5,504(a4)
   105a2:	c3b1                	beqz	a5,105e6 <__register_exitproc+0x4c>
   105a4:	4798                	lw	a4,8(a5)
   105a6:	487d                	li	a6,31
   105a8:	06e84263          	blt	a6,a4,1060c <__register_exitproc+0x72>
   105ac:	c505                	beqz	a0,105d4 <__register_exitproc+0x3a>
   105ae:	00371813          	sll	a6,a4,0x3
   105b2:	983e                	add	a6,a6,a5
   105b4:	10c83823          	sd	a2,272(a6)
   105b8:	3107a883          	lw	a7,784(a5)
   105bc:	4605                	li	a2,1
   105be:	00e6163b          	sllw	a2,a2,a4
   105c2:	00c8e8b3          	or	a7,a7,a2
   105c6:	3117a823          	sw	a7,784(a5)
   105ca:	20d83823          	sd	a3,528(a6)
   105ce:	4689                	li	a3,2
   105d0:	02d50063          	beq	a0,a3,105f0 <__register_exitproc+0x56>
   105d4:	00270693          	add	a3,a4,2
   105d8:	068e                	sll	a3,a3,0x3
   105da:	2705                	addw	a4,a4,1
   105dc:	c798                	sw	a4,8(a5)
   105de:	97b6                	add	a5,a5,a3
   105e0:	e38c                	sd	a1,0(a5)
   105e2:	4501                	li	a0,0
   105e4:	8082                	ret
   105e6:	20070793          	add	a5,a4,512
   105ea:	1ef73c23          	sd	a5,504(a4)
   105ee:	bf5d                	j	105a4 <__register_exitproc+0xa>
   105f0:	3147a683          	lw	a3,788(a5)
   105f4:	4501                	li	a0,0
   105f6:	8ed1                	or	a3,a3,a2
   105f8:	30d7aa23          	sw	a3,788(a5)
   105fc:	00270693          	add	a3,a4,2
   10600:	068e                	sll	a3,a3,0x3
   10602:	2705                	addw	a4,a4,1
   10604:	c798                	sw	a4,8(a5)
   10606:	97b6                	add	a5,a5,a3
   10608:	e38c                	sd	a1,0(a5)
   1060a:	8082                	ret
   1060c:	557d                	li	a0,-1
   1060e:	8082                	ret

0000000000010610 <_exit>:
   10610:	05d00893          	li	a7,93
   10614:	00000073          	ecall
   10618:	00054363          	bltz	a0,1061e <_exit+0xe>
   1061c:	a001                	j	1061c <_exit+0xc>
   1061e:	1141                	add	sp,sp,-16
   10620:	e022                	sd	s0,0(sp)
   10622:	842a                	mv	s0,a0
   10624:	e406                	sd	ra,8(sp)
   10626:	4080043b          	negw	s0,s0
   1062a:	008000ef          	jal	10632 <__errno>
   1062e:	c100                	sw	s0,0(a0)
   10630:	a001                	j	10630 <_exit+0x20>

0000000000010632 <__errno>:
   10632:	f581b503          	ld	a0,-168(gp) # 11db0 <_impure_ptr>
   10636:	8082                	ret

lw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	31c000ef          	jal	1040e <__call_exitprocs>
   100f6:	fb81b503          	ld	a0,-72(gp) # 11d88 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	482000ef          	jal	10584 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4d050513          	add	a0,a0,1232 # 104d0 <__libc_fini_array>
   10112:	aecd                	j	10504 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cba18193          	add	gp,gp,-838 # 11dd0 <__global_pointer$>
   1011e:	fd018513          	add	a0,gp,-48 # 11da0 <completed.1>
   10122:	00818613          	add	a2,gp,8 # 11dd8 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	23a000ef          	jal	10364 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3d650513          	add	a0,a0,982 # 10504 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	39850513          	add	a0,a0,920 # 104d0 <__libc_fini_array>
   10140:	3c4000ef          	jal	10504 <atexit>
   10144:	1b6000ef          	jal	102fa <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	fd01c783          	lbu	a5,-48(gp) # 11da0 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5ac50513          	add	a0,a0,1452 # 115ac <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	fcf18823          	sb	a5,-48(gp) # 11da0 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	fd818593          	add	a1,gp,-40 # 11da8 <object.0>
   1018e:	5ac50513          	add	a0,a0,1452 # 115ac <__EH_FRAME_BEGIN__>
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
   101b2:	0ff7879b          	addw	a5,a5,255 # ff00ff <__BSS_END__+0xfde327>
   101b6:	00001097          	auipc	ra,0x1
   101ba:	41a08093          	add	ra,ra,1050 # 115d0 <__DATA_BEGIN__>
   101be:	0000a703          	lw	a4,0(ra)
   101c2:	00ff03b7          	lui	t2,0xff0
   101c6:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde327>
   101ca:	12771063          	bne	a4,t2,102ea <fail>

00000000000101ce <test_3>:
   101ce:	418d                	li	gp,3
   101d0:	ff0107b7          	lui	a5,0xff010
   101d4:	f007879b          	addw	a5,a5,-256 # ffffffffff00ff00 <__BSS_END__+0xfffffffffeffe128>
   101d8:	00001097          	auipc	ra,0x1
   101dc:	3f808093          	add	ra,ra,1016 # 115d0 <__DATA_BEGIN__>
   101e0:	0040a703          	lw	a4,4(ra)
   101e4:	ff0103b7          	lui	t2,0xff010
   101e8:	f003839b          	addw	t2,t2,-256 # ffffffffff00ff00 <__BSS_END__+0xfffffffffeffe128>
   101ec:	0e771f63          	bne	a4,t2,102ea <fail>

00000000000101f0 <test_4>:
   101f0:	4191                	li	gp,4
   101f2:	0ff017b7          	lui	a5,0xff01
   101f6:	37c1                	addw	a5,a5,-16 # ff00ff0 <__BSS_END__+0xfeef218>
   101f8:	00001097          	auipc	ra,0x1
   101fc:	3d808093          	add	ra,ra,984 # 115d0 <__DATA_BEGIN__>
   10200:	0080a703          	lw	a4,8(ra)
   10204:	0ff013b7          	lui	t2,0xff01
   10208:	33c1                	addw	t2,t2,-16 # ff00ff0 <__BSS_END__+0xfeef218>
   1020a:	0e771063          	bne	a4,t2,102ea <fail>

000000000001020e <test_5>:
   1020e:	4195                	li	gp,5
   10210:	f00ff7b7          	lui	a5,0xf00ff
   10214:	27bd                	addw	a5,a5,15 # fffffffff00ff00f <__BSS_END__+0xfffffffff00ed237>
   10216:	00001097          	auipc	ra,0x1
   1021a:	3ba08093          	add	ra,ra,954 # 115d0 <__DATA_BEGIN__>
   1021e:	00c0a703          	lw	a4,12(ra)
   10222:	f00ff3b7          	lui	t2,0xf00ff
   10226:	23bd                	addw	t2,t2,15 # fffffffff00ff00f <__BSS_END__+0xfffffffff00ed237>
   10228:	0c771163          	bne	a4,t2,102ea <fail>

000000000001022c <test_6>:
   1022c:	4199                	li	gp,6
   1022e:	00ff07b7          	lui	a5,0xff0
   10232:	0ff7879b          	addw	a5,a5,255 # ff00ff <__BSS_END__+0xfde327>
   10236:	00001097          	auipc	ra,0x1
   1023a:	3a608093          	add	ra,ra,934 # 115dc <tdat4>
   1023e:	ff40a703          	lw	a4,-12(ra)
   10242:	00ff03b7          	lui	t2,0xff0
   10246:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde327>
   1024a:	0a771063          	bne	a4,t2,102ea <fail>

000000000001024e <test_7>:
   1024e:	419d                	li	gp,7
   10250:	ff0107b7          	lui	a5,0xff010
   10254:	f007879b          	addw	a5,a5,-256 # ffffffffff00ff00 <__BSS_END__+0xfffffffffeffe128>
   10258:	00001097          	auipc	ra,0x1
   1025c:	38408093          	add	ra,ra,900 # 115dc <tdat4>
   10260:	ff80a703          	lw	a4,-8(ra)
   10264:	ff0103b7          	lui	t2,0xff010
   10268:	f003839b          	addw	t2,t2,-256 # ffffffffff00ff00 <__BSS_END__+0xfffffffffeffe128>
   1026c:	06771f63          	bne	a4,t2,102ea <fail>

0000000000010270 <test_8>:
   10270:	41a1                	li	gp,8
   10272:	0ff017b7          	lui	a5,0xff01
   10276:	37c1                	addw	a5,a5,-16 # ff00ff0 <__BSS_END__+0xfeef218>
   10278:	00001097          	auipc	ra,0x1
   1027c:	36408093          	add	ra,ra,868 # 115dc <tdat4>
   10280:	ffc0a703          	lw	a4,-4(ra)
   10284:	0ff013b7          	lui	t2,0xff01
   10288:	33c1                	addw	t2,t2,-16 # ff00ff0 <__BSS_END__+0xfeef218>
   1028a:	06771063          	bne	a4,t2,102ea <fail>

000000000001028e <test_9>:
   1028e:	41a5                	li	gp,9
   10290:	f00ff7b7          	lui	a5,0xf00ff
   10294:	27bd                	addw	a5,a5,15 # fffffffff00ff00f <__BSS_END__+0xfffffffff00ed237>
   10296:	00001097          	auipc	ra,0x1
   1029a:	34608093          	add	ra,ra,838 # 115dc <tdat4>
   1029e:	0000a703          	lw	a4,0(ra)
   102a2:	f00ff3b7          	lui	t2,0xf00ff
   102a6:	23bd                	addw	t2,t2,15 # fffffffff00ff00f <__BSS_END__+0xfffffffff00ed237>
   102a8:	04771163          	bne	a4,t2,102ea <fail>

00000000000102ac <test_10>:
   102ac:	41a9                	li	gp,10
   102ae:	00001097          	auipc	ra,0x1
   102b2:	32208093          	add	ra,ra,802 # 115d0 <__DATA_BEGIN__>
   102b6:	1081                	add	ra,ra,-32
   102b8:	0200a283          	lw	t0,32(ra)
   102bc:	00ff03b7          	lui	t2,0xff0
   102c0:	0ff3839b          	addw	t2,t2,255 # ff00ff <__BSS_END__+0xfde327>
   102c4:	02729363          	bne	t0,t2,102ea <fail>

00000000000102c8 <test_11>:
   102c8:	41ad                	li	gp,11
   102ca:	00001097          	auipc	ra,0x1
   102ce:	30608093          	add	ra,ra,774 # 115d0 <__DATA_BEGIN__>
   102d2:	10f5                	add	ra,ra,-3
   102d4:	0070a283          	lw	t0,7(ra)
   102d8:	ff0103b7          	lui	t2,0xff010
   102dc:	f003839b          	addw	t2,t2,-256 # ffffffffff00ff00 <__BSS_END__+0xfffffffffeffe128>
   102e0:	00729563          	bne	t0,t2,102ea <fail>
   102e4:	00301263          	bne	zero,gp,102e8 <pass>

00000000000102e8 <pass>:
   102e8:	a019                	j	102ee <continue>

00000000000102ea <fail>:
   102ea:	0000                	unimp
	...

00000000000102ee <continue>:
   102ee:	4081                	li	ra,0
   102f0:	4781                	li	a5,0
   102f2:	853e                	mv	a0,a5
   102f4:	6462                	ld	s0,24(sp)
   102f6:	6105                	add	sp,sp,32
   102f8:	8082                	ret

00000000000102fa <__libc_init_array>:
   102fa:	1101                	add	sp,sp,-32
   102fc:	e822                	sd	s0,16(sp)
   102fe:	67c5                	lui	a5,0x11
   10300:	6445                	lui	s0,0x11
   10302:	e04a                	sd	s2,0(sp)
   10304:	5b078793          	add	a5,a5,1456 # 115b0 <__init_array_start>
   10308:	5b040713          	add	a4,s0,1456 # 115b0 <__init_array_start>
   1030c:	ec06                	sd	ra,24(sp)
   1030e:	e426                	sd	s1,8(sp)
   10310:	40e78933          	sub	s2,a5,a4
   10314:	00e78d63          	beq	a5,a4,1032e <__libc_init_array+0x34>
   10318:	40395913          	sra	s2,s2,0x3
   1031c:	5b040413          	add	s0,s0,1456
   10320:	4481                	li	s1,0
   10322:	601c                	ld	a5,0(s0)
   10324:	0485                	add	s1,s1,1
   10326:	0421                	add	s0,s0,8
   10328:	9782                	jalr	a5
   1032a:	ff24ece3          	bltu	s1,s2,10322 <__libc_init_array+0x28>
   1032e:	6445                	lui	s0,0x11
   10330:	67c5                	lui	a5,0x11
   10332:	5c078793          	add	a5,a5,1472 # 115c0 <__do_global_dtors_aux_fini_array_entry>
   10336:	5b040713          	add	a4,s0,1456 # 115b0 <__init_array_start>
   1033a:	40e78933          	sub	s2,a5,a4
   1033e:	40395913          	sra	s2,s2,0x3
   10342:	00e78b63          	beq	a5,a4,10358 <__libc_init_array+0x5e>
   10346:	5b040413          	add	s0,s0,1456
   1034a:	4481                	li	s1,0
   1034c:	601c                	ld	a5,0(s0)
   1034e:	0485                	add	s1,s1,1
   10350:	0421                	add	s0,s0,8
   10352:	9782                	jalr	a5
   10354:	ff24ece3          	bltu	s1,s2,1034c <__libc_init_array+0x52>
   10358:	60e2                	ld	ra,24(sp)
   1035a:	6442                	ld	s0,16(sp)
   1035c:	64a2                	ld	s1,8(sp)
   1035e:	6902                	ld	s2,0(sp)
   10360:	6105                	add	sp,sp,32
   10362:	8082                	ret

0000000000010364 <memset>:
   10364:	433d                	li	t1,15
   10366:	872a                	mv	a4,a0
   10368:	02c37163          	bgeu	t1,a2,1038a <memset+0x26>
   1036c:	00f77793          	and	a5,a4,15
   10370:	e3c1                	bnez	a5,103f0 <memset+0x8c>
   10372:	e1bd                	bnez	a1,103d8 <memset+0x74>
   10374:	ff067693          	and	a3,a2,-16
   10378:	8a3d                	and	a2,a2,15
   1037a:	96ba                	add	a3,a3,a4
   1037c:	e30c                	sd	a1,0(a4)
   1037e:	e70c                	sd	a1,8(a4)
   10380:	0741                	add	a4,a4,16
   10382:	fed76de3          	bltu	a4,a3,1037c <memset+0x18>
   10386:	e211                	bnez	a2,1038a <memset+0x26>
   10388:	8082                	ret
   1038a:	40c306b3          	sub	a3,t1,a2
   1038e:	068a                	sll	a3,a3,0x2
   10390:	00000297          	auipc	t0,0x0
   10394:	9696                	add	a3,a3,t0
   10396:	00a68067          	jr	10(a3)
   1039a:	00b70723          	sb	a1,14(a4)
   1039e:	00b706a3          	sb	a1,13(a4)
   103a2:	00b70623          	sb	a1,12(a4)
   103a6:	00b705a3          	sb	a1,11(a4)
   103aa:	00b70523          	sb	a1,10(a4)
   103ae:	00b704a3          	sb	a1,9(a4)
   103b2:	00b70423          	sb	a1,8(a4)
   103b6:	00b703a3          	sb	a1,7(a4)
   103ba:	00b70323          	sb	a1,6(a4)
   103be:	00b702a3          	sb	a1,5(a4)
   103c2:	00b70223          	sb	a1,4(a4)
   103c6:	00b701a3          	sb	a1,3(a4)
   103ca:	00b70123          	sb	a1,2(a4)
   103ce:	00b700a3          	sb	a1,1(a4)
   103d2:	00b70023          	sb	a1,0(a4)
   103d6:	8082                	ret
   103d8:	0ff5f593          	zext.b	a1,a1
   103dc:	00859693          	sll	a3,a1,0x8
   103e0:	8dd5                	or	a1,a1,a3
   103e2:	01059693          	sll	a3,a1,0x10
   103e6:	8dd5                	or	a1,a1,a3
   103e8:	02059693          	sll	a3,a1,0x20
   103ec:	8dd5                	or	a1,a1,a3
   103ee:	b759                	j	10374 <memset+0x10>
   103f0:	00279693          	sll	a3,a5,0x2
   103f4:	00000297          	auipc	t0,0x0
   103f8:	9696                	add	a3,a3,t0
   103fa:	8286                	mv	t0,ra
   103fc:	fa2680e7          	jalr	-94(a3)
   10400:	8096                	mv	ra,t0
   10402:	17c1                	add	a5,a5,-16
   10404:	8f1d                	sub	a4,a4,a5
   10406:	963e                	add	a2,a2,a5
   10408:	f8c371e3          	bgeu	t1,a2,1038a <memset+0x26>
   1040c:	b79d                	j	10372 <memset+0xe>

000000000001040e <__call_exitprocs>:
   1040e:	715d                	add	sp,sp,-80
   10410:	f052                	sd	s4,32(sp)
   10412:	fb81ba03          	ld	s4,-72(gp) # 11d88 <_global_impure_ptr>
   10416:	f84a                	sd	s2,48(sp)
   10418:	e486                	sd	ra,72(sp)
   1041a:	1f8a3903          	ld	s2,504(s4)
   1041e:	e0a2                	sd	s0,64(sp)
   10420:	fc26                	sd	s1,56(sp)
   10422:	f44e                	sd	s3,40(sp)
   10424:	ec56                	sd	s5,24(sp)
   10426:	e85a                	sd	s6,16(sp)
   10428:	e45e                	sd	s7,8(sp)
   1042a:	e062                	sd	s8,0(sp)
   1042c:	02090863          	beqz	s2,1045c <__call_exitprocs+0x4e>
   10430:	8b2a                	mv	s6,a0
   10432:	8bae                	mv	s7,a1
   10434:	4a85                	li	s5,1
   10436:	59fd                	li	s3,-1
   10438:	00892483          	lw	s1,8(s2)
   1043c:	fff4841b          	addw	s0,s1,-1
   10440:	00044e63          	bltz	s0,1045c <__call_exitprocs+0x4e>
   10444:	048e                	sll	s1,s1,0x3
   10446:	94ca                	add	s1,s1,s2
   10448:	020b8663          	beqz	s7,10474 <__call_exitprocs+0x66>
   1044c:	2084b783          	ld	a5,520(s1)
   10450:	03778263          	beq	a5,s7,10474 <__call_exitprocs+0x66>
   10454:	347d                	addw	s0,s0,-1
   10456:	14e1                	add	s1,s1,-8
   10458:	ff3418e3          	bne	s0,s3,10448 <__call_exitprocs+0x3a>
   1045c:	60a6                	ld	ra,72(sp)
   1045e:	6406                	ld	s0,64(sp)
   10460:	74e2                	ld	s1,56(sp)
   10462:	7942                	ld	s2,48(sp)
   10464:	79a2                	ld	s3,40(sp)
   10466:	7a02                	ld	s4,32(sp)
   10468:	6ae2                	ld	s5,24(sp)
   1046a:	6b42                	ld	s6,16(sp)
   1046c:	6ba2                	ld	s7,8(sp)
   1046e:	6c02                	ld	s8,0(sp)
   10470:	6161                	add	sp,sp,80
   10472:	8082                	ret
   10474:	00892783          	lw	a5,8(s2)
   10478:	6498                	ld	a4,8(s1)
   1047a:	37fd                	addw	a5,a5,-1
   1047c:	04878463          	beq	a5,s0,104c4 <__call_exitprocs+0xb6>
   10480:	0004b423          	sd	zero,8(s1)
   10484:	db61                	beqz	a4,10454 <__call_exitprocs+0x46>
   10486:	31092783          	lw	a5,784(s2)
   1048a:	008a96bb          	sllw	a3,s5,s0
   1048e:	00892c03          	lw	s8,8(s2)
   10492:	8ff5                	and	a5,a5,a3
   10494:	2781                	sext.w	a5,a5
   10496:	ef89                	bnez	a5,104b0 <__call_exitprocs+0xa2>
   10498:	9702                	jalr	a4
   1049a:	00892703          	lw	a4,8(s2)
   1049e:	1f8a3783          	ld	a5,504(s4)
   104a2:	01871463          	bne	a4,s8,104aa <__call_exitprocs+0x9c>
   104a6:	fb2787e3          	beq	a5,s2,10454 <__call_exitprocs+0x46>
   104aa:	dbcd                	beqz	a5,1045c <__call_exitprocs+0x4e>
   104ac:	893e                	mv	s2,a5
   104ae:	b769                	j	10438 <__call_exitprocs+0x2a>
   104b0:	31492783          	lw	a5,788(s2)
   104b4:	1084b583          	ld	a1,264(s1)
   104b8:	8ff5                	and	a5,a5,a3
   104ba:	2781                	sext.w	a5,a5
   104bc:	e799                	bnez	a5,104ca <__call_exitprocs+0xbc>
   104be:	855a                	mv	a0,s6
   104c0:	9702                	jalr	a4
   104c2:	bfe1                	j	1049a <__call_exitprocs+0x8c>
   104c4:	00892423          	sw	s0,8(s2)
   104c8:	bf75                	j	10484 <__call_exitprocs+0x76>
   104ca:	852e                	mv	a0,a1
   104cc:	9702                	jalr	a4
   104ce:	b7f1                	j	1049a <__call_exitprocs+0x8c>

00000000000104d0 <__libc_fini_array>:
   104d0:	1101                	add	sp,sp,-32
   104d2:	e822                	sd	s0,16(sp)
   104d4:	67c5                	lui	a5,0x11
   104d6:	6445                	lui	s0,0x11
   104d8:	5c078793          	add	a5,a5,1472 # 115c0 <__do_global_dtors_aux_fini_array_entry>
   104dc:	5c840413          	add	s0,s0,1480 # 115c8 <__fini_array_end>
   104e0:	8c1d                	sub	s0,s0,a5
   104e2:	e426                	sd	s1,8(sp)
   104e4:	ec06                	sd	ra,24(sp)
   104e6:	40345493          	sra	s1,s0,0x3
   104ea:	c881                	beqz	s1,104fa <__libc_fini_array+0x2a>
   104ec:	1461                	add	s0,s0,-8
   104ee:	943e                	add	s0,s0,a5
   104f0:	601c                	ld	a5,0(s0)
   104f2:	14fd                	add	s1,s1,-1
   104f4:	1461                	add	s0,s0,-8
   104f6:	9782                	jalr	a5
   104f8:	fce5                	bnez	s1,104f0 <__libc_fini_array+0x20>
   104fa:	60e2                	ld	ra,24(sp)
   104fc:	6442                	ld	s0,16(sp)
   104fe:	64a2                	ld	s1,8(sp)
   10500:	6105                	add	sp,sp,32
   10502:	8082                	ret

0000000000010504 <atexit>:
   10504:	85aa                	mv	a1,a0
   10506:	4681                	li	a3,0
   10508:	4601                	li	a2,0
   1050a:	4501                	li	a0,0
   1050c:	a009                	j	1050e <__register_exitproc>

000000000001050e <__register_exitproc>:
   1050e:	fb81b703          	ld	a4,-72(gp) # 11d88 <_global_impure_ptr>
   10512:	1f873783          	ld	a5,504(a4)
   10516:	c3b1                	beqz	a5,1055a <__register_exitproc+0x4c>
   10518:	4798                	lw	a4,8(a5)
   1051a:	487d                	li	a6,31
   1051c:	06e84263          	blt	a6,a4,10580 <__register_exitproc+0x72>
   10520:	c505                	beqz	a0,10548 <__register_exitproc+0x3a>
   10522:	00371813          	sll	a6,a4,0x3
   10526:	983e                	add	a6,a6,a5
   10528:	10c83823          	sd	a2,272(a6)
   1052c:	3107a883          	lw	a7,784(a5)
   10530:	4605                	li	a2,1
   10532:	00e6163b          	sllw	a2,a2,a4
   10536:	00c8e8b3          	or	a7,a7,a2
   1053a:	3117a823          	sw	a7,784(a5)
   1053e:	20d83823          	sd	a3,528(a6)
   10542:	4689                	li	a3,2
   10544:	02d50063          	beq	a0,a3,10564 <__register_exitproc+0x56>
   10548:	00270693          	add	a3,a4,2
   1054c:	068e                	sll	a3,a3,0x3
   1054e:	2705                	addw	a4,a4,1
   10550:	c798                	sw	a4,8(a5)
   10552:	97b6                	add	a5,a5,a3
   10554:	e38c                	sd	a1,0(a5)
   10556:	4501                	li	a0,0
   10558:	8082                	ret
   1055a:	20070793          	add	a5,a4,512
   1055e:	1ef73c23          	sd	a5,504(a4)
   10562:	bf5d                	j	10518 <__register_exitproc+0xa>
   10564:	3147a683          	lw	a3,788(a5)
   10568:	4501                	li	a0,0
   1056a:	8ed1                	or	a3,a3,a2
   1056c:	30d7aa23          	sw	a3,788(a5)
   10570:	00270693          	add	a3,a4,2
   10574:	068e                	sll	a3,a3,0x3
   10576:	2705                	addw	a4,a4,1
   10578:	c798                	sw	a4,8(a5)
   1057a:	97b6                	add	a5,a5,a3
   1057c:	e38c                	sd	a1,0(a5)
   1057e:	8082                	ret
   10580:	557d                	li	a0,-1
   10582:	8082                	ret

0000000000010584 <_exit>:
   10584:	05d00893          	li	a7,93
   10588:	00000073          	ecall
   1058c:	00054363          	bltz	a0,10592 <_exit+0xe>
   10590:	a001                	j	10590 <_exit+0xc>
   10592:	1141                	add	sp,sp,-16
   10594:	e022                	sd	s0,0(sp)
   10596:	842a                	mv	s0,a0
   10598:	e406                	sd	ra,8(sp)
   1059a:	4080043b          	negw	s0,s0
   1059e:	008000ef          	jal	105a6 <__errno>
   105a2:	c100                	sw	s0,0(a0)
   105a4:	a001                	j	105a4 <_exit+0x20>

00000000000105a6 <__errno>:
   105a6:	fc81b503          	ld	a0,-56(gp) # 11d98 <_impure_ptr>
   105aa:	8082                	ret

sd.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	4fa000ef          	jal	105ec <__call_exitprocs>
   100f6:	fe81b503          	ld	a0,-24(gp) # 11808 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	660000ef          	jal	10762 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	6ae50513          	add	a0,a0,1710 # 106ae <__libc_fini_array>
   10112:	abc1                	j	106e2 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00001197          	auipc	gp,0x1
   1011a:	70a18193          	add	gp,gp,1802 # 11820 <completed.1>
   1011e:	00018513          	mv	a0,gp
   10122:	03818613          	add	a2,gp,56 # 11858 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	418000ef          	jal	10542 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	5b450513          	add	a0,a0,1460 # 106e2 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	57650513          	add	a0,a0,1398 # 106ae <__libc_fini_array>
   10140:	5a2000ef          	jal	106e2 <atexit>
   10144:	394000ef          	jal	104d8 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	0001c783          	lbu	a5,0(gp) # 11820 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	00050513          	mv	a0,a0
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	00f18023          	sb	a5,0(gp) # 11820 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	00818593          	add	a1,gp,8 # 11828 <object.0>
   1018e:	00050513          	mv	a0,a0
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
   101ae:	00001097          	auipc	ra,0x1
   101b2:	e7208093          	add	ra,ra,-398 # 11020 <__DATA_BEGIN__>
   101b6:	00550137          	lui	sp,0x550
   101ba:	0551011b          	addw	sp,sp,85 # 550055 <__BSS_END__+0x53e7fd>
   101be:	0142                	sll	sp,sp,0x10
   101c0:	05510113          	add	sp,sp,85
   101c4:	0146                	sll	sp,sp,0x11
   101c6:	0aa10113          	add	sp,sp,170
   101ca:	00000797          	auipc	a5,0x0
   101ce:	01278793          	add	a5,a5,18 # 101dc <test_2+0x30>
   101d2:	0020b023          	sd	sp,0(ra)
   101d6:	0000b703          	ld	a4,0(ra)
   101da:	a011                	j	101de <test_2+0x32>
   101dc:	870a                	mv	a4,sp
   101de:	005503b7          	lui	t2,0x550
   101e2:	0553839b          	addw	t2,t2,85 # 550055 <__BSS_END__+0x53e7fd>
   101e6:	03c2                	sll	t2,t2,0x10
   101e8:	05538393          	add	t2,t2,85
   101ec:	03c6                	sll	t2,t2,0x11
   101ee:	0aa38393          	add	t2,t2,170
   101f2:	2c771b63          	bne	a4,t2,104c8 <fail>

00000000000101f6 <test_3>:
   101f6:	418d                	li	gp,3
   101f8:	00001097          	auipc	ra,0x1
   101fc:	e2808093          	add	ra,ra,-472 # 11020 <__DATA_BEGIN__>
   10200:	ffd50137          	lui	sp,0xffd50
   10204:	0551011b          	addw	sp,sp,85 # ffffffffffd50055 <__BSS_END__+0xffffffffffd3e7fd>
   10208:	0142                	sll	sp,sp,0x10
   1020a:	05510113          	add	sp,sp,85
   1020e:	0136                	sll	sp,sp,0xd
   10210:	012d                	add	sp,sp,11
   10212:	0132                	sll	sp,sp,0xc
   10214:	a0010113          	add	sp,sp,-1536
   10218:	00000797          	auipc	a5,0x0
   1021c:	01278793          	add	a5,a5,18 # 1022a <test_3+0x34>
   10220:	0020b423          	sd	sp,8(ra)
   10224:	0080b703          	ld	a4,8(ra)
   10228:	a011                	j	1022c <test_3+0x36>
   1022a:	870a                	mv	a4,sp
   1022c:	ffd503b7          	lui	t2,0xffd50
   10230:	0553839b          	addw	t2,t2,85 # ffffffffffd50055 <__BSS_END__+0xffffffffffd3e7fd>
   10234:	03c2                	sll	t2,t2,0x10
   10236:	05538393          	add	t2,t2,85
   1023a:	03b6                	sll	t2,t2,0xd
   1023c:	03ad                	add	t2,t2,11
   1023e:	03b2                	sll	t2,t2,0xc
   10240:	a0038393          	add	t2,t2,-1536
   10244:	28771263          	bne	a4,t2,104c8 <fail>

0000000000010248 <test_4>:
   10248:	4191                	li	gp,4
   1024a:	00001097          	auipc	ra,0x1
   1024e:	dd608093          	add	ra,ra,-554 # 11020 <__DATA_BEGIN__>
   10252:	00550137          	lui	sp,0x550
   10256:	0551011b          	addw	sp,sp,85 # 550055 <__BSS_END__+0x53e7fd>
   1025a:	0136                	sll	sp,sp,0xd
   1025c:	012d                	add	sp,sp,11
   1025e:	0132                	sll	sp,sp,0xc
   10260:	a0110113          	add	sp,sp,-1535
   10264:	0132                	sll	sp,sp,0xc
   10266:	aa010113          	add	sp,sp,-1376
   1026a:	00000797          	auipc	a5,0x0
   1026e:	01278793          	add	a5,a5,18 # 1027c <test_4+0x34>
   10272:	0020b823          	sd	sp,16(ra)
   10276:	0100b703          	ld	a4,16(ra)
   1027a:	a011                	j	1027e <test_4+0x36>
   1027c:	870a                	mv	a4,sp
   1027e:	005503b7          	lui	t2,0x550
   10282:	0553839b          	addw	t2,t2,85 # 550055 <__BSS_END__+0x53e7fd>
   10286:	03b6                	sll	t2,t2,0xd
   10288:	03ad                	add	t2,t2,11
   1028a:	03b2                	sll	t2,t2,0xc
   1028c:	a0138393          	add	t2,t2,-1535
   10290:	03b2                	sll	t2,t2,0xc
   10292:	aa038393          	add	t2,t2,-1376
   10296:	22771963          	bne	a4,t2,104c8 <fail>

000000000001029a <test_5>:
   1029a:	4195                	li	gp,5
   1029c:	00001097          	auipc	ra,0x1
   102a0:	d8408093          	add	ra,ra,-636 # 11020 <__DATA_BEGIN__>
   102a4:	fffd0137          	lui	sp,0xfffd0
   102a8:	0551011b          	addw	sp,sp,85 # fffffffffffd0055 <__BSS_END__+0xfffffffffffbe7fd>
   102ac:	0142                	sll	sp,sp,0x10
   102ae:	05510113          	add	sp,sp,85
   102b2:	0142                	sll	sp,sp,0x10
   102b4:	05510113          	add	sp,sp,85
   102b8:	0136                	sll	sp,sp,0xd
   102ba:	0129                	add	sp,sp,10
   102bc:	00000797          	auipc	a5,0x0
   102c0:	01278793          	add	a5,a5,18 # 102ce <test_5+0x34>
   102c4:	0020bc23          	sd	sp,24(ra)
   102c8:	0180b703          	ld	a4,24(ra)
   102cc:	a011                	j	102d0 <test_5+0x36>
   102ce:	870a                	mv	a4,sp
   102d0:	fffd03b7          	lui	t2,0xfffd0
   102d4:	0553839b          	addw	t2,t2,85 # fffffffffffd0055 <__BSS_END__+0xfffffffffffbe7fd>
   102d8:	03c2                	sll	t2,t2,0x10
   102da:	05538393          	add	t2,t2,85
   102de:	03c2                	sll	t2,t2,0x10
   102e0:	05538393          	add	t2,t2,85
   102e4:	03b6                	sll	t2,t2,0xd
   102e6:	03a9                	add	t2,t2,10
   102e8:	1e771063          	bne	a4,t2,104c8 <fail>

00000000000102ec <test_6>:
   102ec:	4199                	li	gp,6
   102ee:	00001097          	auipc	ra,0x1
   102f2:	d6a08093          	add	ra,ra,-662 # 11058 <tdat8>
   102f6:	00550137          	lui	sp,0x550
   102fa:	0551011b          	addw	sp,sp,85 # 550055 <__BSS_END__+0x53e7fd>
   102fe:	0142                	sll	sp,sp,0x10
   10300:	05510113          	add	sp,sp,85
   10304:	0146                	sll	sp,sp,0x11
   10306:	0aa10113          	add	sp,sp,170
   1030a:	00000797          	auipc	a5,0x0
   1030e:	01278793          	add	a5,a5,18 # 1031c <test_6+0x30>
   10312:	fe20b423          	sd	sp,-24(ra)
   10316:	fe80b703          	ld	a4,-24(ra)
   1031a:	a011                	j	1031e <test_6+0x32>
   1031c:	870a                	mv	a4,sp
   1031e:	005503b7          	lui	t2,0x550
   10322:	0553839b          	addw	t2,t2,85 # 550055 <__BSS_END__+0x53e7fd>
   10326:	03c2                	sll	t2,t2,0x10
   10328:	05538393          	add	t2,t2,85
   1032c:	03c6                	sll	t2,t2,0x11
   1032e:	0aa38393          	add	t2,t2,170
   10332:	18771b63          	bne	a4,t2,104c8 <fail>

0000000000010336 <test_7>:
   10336:	419d                	li	gp,7
   10338:	00001097          	auipc	ra,0x1
   1033c:	d2008093          	add	ra,ra,-736 # 11058 <tdat8>
   10340:	ffd50137          	lui	sp,0xffd50
   10344:	0551011b          	addw	sp,sp,85 # ffffffffffd50055 <__BSS_END__+0xffffffffffd3e7fd>
   10348:	0142                	sll	sp,sp,0x10
   1034a:	05510113          	add	sp,sp,85
   1034e:	0136                	sll	sp,sp,0xd
   10350:	012d                	add	sp,sp,11
   10352:	0132                	sll	sp,sp,0xc
   10354:	a0010113          	add	sp,sp,-1536
   10358:	00000797          	auipc	a5,0x0
   1035c:	01278793          	add	a5,a5,18 # 1036a <test_7+0x34>
   10360:	fe20b823          	sd	sp,-16(ra)
   10364:	ff00b703          	ld	a4,-16(ra)
   10368:	a011                	j	1036c <test_7+0x36>
   1036a:	870a                	mv	a4,sp
   1036c:	ffd503b7          	lui	t2,0xffd50
   10370:	0553839b          	addw	t2,t2,85 # ffffffffffd50055 <__BSS_END__+0xffffffffffd3e7fd>
   10374:	03c2                	sll	t2,t2,0x10
   10376:	05538393          	add	t2,t2,85
   1037a:	03b6                	sll	t2,t2,0xd
   1037c:	03ad                	add	t2,t2,11
   1037e:	03b2                	sll	t2,t2,0xc
   10380:	a0038393          	add	t2,t2,-1536
   10384:	14771263          	bne	a4,t2,104c8 <fail>

0000000000010388 <test_8>:
   10388:	41a1                	li	gp,8
   1038a:	00001097          	auipc	ra,0x1
   1038e:	cce08093          	add	ra,ra,-818 # 11058 <tdat8>
   10392:	00550137          	lui	sp,0x550
   10396:	0551011b          	addw	sp,sp,85 # 550055 <__BSS_END__+0x53e7fd>
   1039a:	0136                	sll	sp,sp,0xd
   1039c:	012d                	add	sp,sp,11
   1039e:	0132                	sll	sp,sp,0xc
   103a0:	a0110113          	add	sp,sp,-1535
   103a4:	0132                	sll	sp,sp,0xc
   103a6:	aa010113          	add	sp,sp,-1376
   103aa:	00000797          	auipc	a5,0x0
   103ae:	01278793          	add	a5,a5,18 # 103bc <test_8+0x34>
   103b2:	fe20bc23          	sd	sp,-8(ra)
   103b6:	ff80b703          	ld	a4,-8(ra)
   103ba:	a011                	j	103be <test_8+0x36>
   103bc:	870a                	mv	a4,sp
   103be:	005503b7          	lui	t2,0x550
   103c2:	0553839b          	addw	t2,t2,85 # 550055 <__BSS_END__+0x53e7fd>
   103c6:	03b6                	sll	t2,t2,0xd
   103c8:	03ad                	add	t2,t2,11
   103ca:	03b2                	sll	t2,t2,0xc
   103cc:	a0138393          	add	t2,t2,-1535
   103d0:	03b2                	sll	t2,t2,0xc
   103d2:	aa038393          	add	t2,t2,-1376
   103d6:	0e771963          	bne	a4,t2,104c8 <fail>

00000000000103da <test_9>:
   103da:	41a5                	li	gp,9
   103dc:	00001097          	auipc	ra,0x1
   103e0:	c7c08093          	add	ra,ra,-900 # 11058 <tdat8>
   103e4:	fffd0137          	lui	sp,0xfffd0
   103e8:	0551011b          	addw	sp,sp,85 # fffffffffffd0055 <__BSS_END__+0xfffffffffffbe7fd>
   103ec:	0142                	sll	sp,sp,0x10
   103ee:	05510113          	add	sp,sp,85
   103f2:	0142                	sll	sp,sp,0x10
   103f4:	05510113          	add	sp,sp,85
   103f8:	0136                	sll	sp,sp,0xd
   103fa:	0129                	add	sp,sp,10
   103fc:	00000797          	auipc	a5,0x0
   10400:	01278793          	add	a5,a5,18 # 1040e <test_9+0x34>
   10404:	0020b023          	sd	sp,0(ra)
   10408:	0000b703          	ld	a4,0(ra)
   1040c:	a011                	j	10410 <test_9+0x36>
   1040e:	870a                	mv	a4,sp
   10410:	fffd03b7          	lui	t2,0xfffd0
   10414:	0553839b          	addw	t2,t2,85 # fffffffffffd0055 <__BSS_END__+0xfffffffffffbe7fd>
   10418:	03c2                	sll	t2,t2,0x10
   1041a:	05538393          	add	t2,t2,85
   1041e:	03c2                	sll	t2,t2,0x10
   10420:	05538393          	add	t2,t2,85
   10424:	03b6                	sll	t2,t2,0xd
   10426:	03a9                	add	t2,t2,10
   10428:	0a771063          	bne	a4,t2,104c8 <fail>

000000000001042c <test_10>:
   1042c:	41a9                	li	gp,10
   1042e:	84018093          	add	ra,gp,-1984 # 11060 <tdat9>
   10432:	00247137          	lui	sp,0x247
   10436:	8ad1011b          	addw	sp,sp,-1875 # 2468ad <__BSS_END__+0x235055>
   1043a:	013a                	sll	sp,sp,0xe
   1043c:	c0910113          	add	sp,sp,-1015
   10440:	0136                	sll	sp,sp,0xd
   10442:	34510113          	add	sp,sp,837
   10446:	0132                	sll	sp,sp,0xc
   10448:	67810113          	add	sp,sp,1656
   1044c:	fe008213          	add	tp,ra,-32
   10450:	02223023          	sd	sp,32(tp) # 20 <exit-0x100c8>
   10454:	0000b283          	ld	t0,0(ra)
   10458:	002473b7          	lui	t2,0x247
   1045c:	8ad3839b          	addw	t2,t2,-1875 # 2468ad <__BSS_END__+0x235055>
   10460:	03ba                	sll	t2,t2,0xe
   10462:	c0938393          	add	t2,t2,-1015
   10466:	03b6                	sll	t2,t2,0xd
   10468:	34538393          	add	t2,t2,837
   1046c:	03b2                	sll	t2,t2,0xc
   1046e:	67838393          	add	t2,t2,1656
   10472:	04729b63          	bne	t0,t2,104c8 <fail>

0000000000010476 <test_11>:
   10476:	41ad                	li	gp,11
   10478:	84018093          	add	ra,gp,-1984 # 11060 <tdat9>
   1047c:	00b04137          	lui	sp,0xb04
   10480:	2611011b          	addw	sp,sp,609 # b04261 <__BSS_END__+0xaf2a09>
   10484:	0132                	sll	sp,sp,0xc
   10486:	30b10113          	add	sp,sp,779
   1048a:	013e                	sll	sp,sp,0xf
   1048c:	21310113          	add	sp,sp,531
   10490:	0132                	sll	sp,sp,0xc
   10492:	09810113          	add	sp,sp,152
   10496:	10f5                	add	ra,ra,-3
   10498:	0020b5a3          	sd	sp,11(ra)
   1049c:	84818213          	add	tp,gp,-1976 # 11068 <tdat10>
   104a0:	00023283          	ld	t0,0(tp) # 0 <exit-0x100e8>
   104a4:	00b043b7          	lui	t2,0xb04
   104a8:	2613839b          	addw	t2,t2,609 # b04261 <__BSS_END__+0xaf2a09>
   104ac:	03b2                	sll	t2,t2,0xc
   104ae:	30b38393          	add	t2,t2,779
   104b2:	03be                	sll	t2,t2,0xf
   104b4:	21338393          	add	t2,t2,531
   104b8:	03b2                	sll	t2,t2,0xc
   104ba:	09838393          	add	t2,t2,152
   104be:	00729563          	bne	t0,t2,104c8 <fail>
   104c2:	00301263          	bne	zero,gp,104c6 <pass>

00000000000104c6 <pass>:
   104c6:	a019                	j	104cc <continue>

00000000000104c8 <fail>:
   104c8:	0000                	unimp
	...

00000000000104cc <continue>:
   104cc:	4081                	li	ra,0
   104ce:	4781                	li	a5,0
   104d0:	853e                	mv	a0,a5
   104d2:	6462                	ld	s0,24(sp)
   104d4:	6105                	add	sp,sp,32
   104d6:	8082                	ret

00000000000104d8 <__libc_init_array>:
   104d8:	1101                	add	sp,sp,-32
   104da:	e822                	sd	s0,16(sp)
   104dc:	67c5                	lui	a5,0x11
   104de:	6445                	lui	s0,0x11
   104e0:	e04a                	sd	s2,0(sp)
   104e2:	00478793          	add	a5,a5,4 # 11004 <__preinit_array_end>
   104e6:	00440713          	add	a4,s0,4 # 11004 <__preinit_array_end>
   104ea:	ec06                	sd	ra,24(sp)
   104ec:	e426                	sd	s1,8(sp)
   104ee:	40e78933          	sub	s2,a5,a4
   104f2:	00e78d63          	beq	a5,a4,1050c <__libc_init_array+0x34>
   104f6:	40395913          	sra	s2,s2,0x3
   104fa:	00440413          	add	s0,s0,4
   104fe:	4481                	li	s1,0
   10500:	601c                	ld	a5,0(s0)
   10502:	0485                	add	s1,s1,1
   10504:	0421                	add	s0,s0,8
   10506:	9782                	jalr	a5
   10508:	ff24ece3          	bltu	s1,s2,10500 <__libc_init_array+0x28>
   1050c:	6445                	lui	s0,0x11
   1050e:	67c5                	lui	a5,0x11
   10510:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   10514:	00840713          	add	a4,s0,8 # 11008 <__init_array_start>
   10518:	40e78933          	sub	s2,a5,a4
   1051c:	40395913          	sra	s2,s2,0x3
   10520:	00e78b63          	beq	a5,a4,10536 <__libc_init_array+0x5e>
   10524:	00840413          	add	s0,s0,8
   10528:	4481                	li	s1,0
   1052a:	601c                	ld	a5,0(s0)
   1052c:	0485                	add	s1,s1,1
   1052e:	0421                	add	s0,s0,8
   10530:	9782                	jalr	a5
   10532:	ff24ece3          	bltu	s1,s2,1052a <__libc_init_array+0x52>
   10536:	60e2                	ld	ra,24(sp)
   10538:	6442                	ld	s0,16(sp)
   1053a:	64a2                	ld	s1,8(sp)
   1053c:	6902                	ld	s2,0(sp)
   1053e:	6105                	add	sp,sp,32
   10540:	8082                	ret

0000000000010542 <memset>:
   10542:	433d                	li	t1,15
   10544:	872a                	mv	a4,a0
   10546:	02c37163          	bgeu	t1,a2,10568 <memset+0x26>
   1054a:	00f77793          	and	a5,a4,15
   1054e:	e3c1                	bnez	a5,105ce <memset+0x8c>
   10550:	e1bd                	bnez	a1,105b6 <memset+0x74>
   10552:	ff067693          	and	a3,a2,-16
   10556:	8a3d                	and	a2,a2,15
   10558:	96ba                	add	a3,a3,a4
   1055a:	e30c                	sd	a1,0(a4)
   1055c:	e70c                	sd	a1,8(a4)
   1055e:	0741                	add	a4,a4,16
   10560:	fed76de3          	bltu	a4,a3,1055a <memset+0x18>
   10564:	e211                	bnez	a2,10568 <memset+0x26>
   10566:	8082                	ret
   10568:	40c306b3          	sub	a3,t1,a2
   1056c:	068a                	sll	a3,a3,0x2
   1056e:	00000297          	auipc	t0,0x0
   10572:	9696                	add	a3,a3,t0
   10574:	00a68067          	jr	10(a3)
   10578:	00b70723          	sb	a1,14(a4)
   1057c:	00b706a3          	sb	a1,13(a4)
   10580:	00b70623          	sb	a1,12(a4)
   10584:	00b705a3          	sb	a1,11(a4)
   10588:	00b70523          	sb	a1,10(a4)
   1058c:	00b704a3          	sb	a1,9(a4)
   10590:	00b70423          	sb	a1,8(a4)
   10594:	00b703a3          	sb	a1,7(a4)
   10598:	00b70323          	sb	a1,6(a4)
   1059c:	00b702a3          	sb	a1,5(a4)
   105a0:	00b70223          	sb	a1,4(a4)
   105a4:	00b701a3          	sb	a1,3(a4)
   105a8:	00b70123          	sb	a1,2(a4)
   105ac:	00b700a3          	sb	a1,1(a4)
   105b0:	00b70023          	sb	a1,0(a4)
   105b4:	8082                	ret
   105b6:	0ff5f593          	zext.b	a1,a1
   105ba:	00859693          	sll	a3,a1,0x8
   105be:	8dd5                	or	a1,a1,a3
   105c0:	01059693          	sll	a3,a1,0x10
   105c4:	8dd5                	or	a1,a1,a3
   105c6:	02059693          	sll	a3,a1,0x20
   105ca:	8dd5                	or	a1,a1,a3
   105cc:	b759                	j	10552 <memset+0x10>
   105ce:	00279693          	sll	a3,a5,0x2
   105d2:	00000297          	auipc	t0,0x0
   105d6:	9696                	add	a3,a3,t0
   105d8:	8286                	mv	t0,ra
   105da:	fa2680e7          	jalr	-94(a3)
   105de:	8096                	mv	ra,t0
   105e0:	17c1                	add	a5,a5,-16
   105e2:	8f1d                	sub	a4,a4,a5
   105e4:	963e                	add	a2,a2,a5
   105e6:	f8c371e3          	bgeu	t1,a2,10568 <memset+0x26>
   105ea:	b79d                	j	10550 <memset+0xe>

00000000000105ec <__call_exitprocs>:
   105ec:	715d                	add	sp,sp,-80
   105ee:	f052                	sd	s4,32(sp)
   105f0:	fe81ba03          	ld	s4,-24(gp) # 11808 <_global_impure_ptr>
   105f4:	f84a                	sd	s2,48(sp)
   105f6:	e486                	sd	ra,72(sp)
   105f8:	1f8a3903          	ld	s2,504(s4)
   105fc:	e0a2                	sd	s0,64(sp)
   105fe:	fc26                	sd	s1,56(sp)
   10600:	f44e                	sd	s3,40(sp)
   10602:	ec56                	sd	s5,24(sp)
   10604:	e85a                	sd	s6,16(sp)
   10606:	e45e                	sd	s7,8(sp)
   10608:	e062                	sd	s8,0(sp)
   1060a:	02090863          	beqz	s2,1063a <__call_exitprocs+0x4e>
   1060e:	8b2a                	mv	s6,a0
   10610:	8bae                	mv	s7,a1
   10612:	4a85                	li	s5,1
   10614:	59fd                	li	s3,-1
   10616:	00892483          	lw	s1,8(s2)
   1061a:	fff4841b          	addw	s0,s1,-1
   1061e:	00044e63          	bltz	s0,1063a <__call_exitprocs+0x4e>
   10622:	048e                	sll	s1,s1,0x3
   10624:	94ca                	add	s1,s1,s2
   10626:	020b8663          	beqz	s7,10652 <__call_exitprocs+0x66>
   1062a:	2084b783          	ld	a5,520(s1)
   1062e:	03778263          	beq	a5,s7,10652 <__call_exitprocs+0x66>
   10632:	347d                	addw	s0,s0,-1
   10634:	14e1                	add	s1,s1,-8
   10636:	ff3418e3          	bne	s0,s3,10626 <__call_exitprocs+0x3a>
   1063a:	60a6                	ld	ra,72(sp)
   1063c:	6406                	ld	s0,64(sp)
   1063e:	74e2                	ld	s1,56(sp)
   10640:	7942                	ld	s2,48(sp)
   10642:	79a2                	ld	s3,40(sp)
   10644:	7a02                	ld	s4,32(sp)
   10646:	6ae2                	ld	s5,24(sp)
   10648:	6b42                	ld	s6,16(sp)
   1064a:	6ba2                	ld	s7,8(sp)
   1064c:	6c02                	ld	s8,0(sp)
   1064e:	6161                	add	sp,sp,80
   10650:	8082                	ret
   10652:	00892783          	lw	a5,8(s2)
   10656:	6498                	ld	a4,8(s1)
   10658:	37fd                	addw	a5,a5,-1
   1065a:	04878463          	beq	a5,s0,106a2 <__call_exitprocs+0xb6>
   1065e:	0004b423          	sd	zero,8(s1)
   10662:	db61                	beqz	a4,10632 <__call_exitprocs+0x46>
   10664:	31092783          	lw	a5,784(s2)
   10668:	008a96bb          	sllw	a3,s5,s0
   1066c:	00892c03          	lw	s8,8(s2)
   10670:	8ff5                	and	a5,a5,a3
   10672:	2781                	sext.w	a5,a5
   10674:	ef89                	bnez	a5,1068e <__call_exitprocs+0xa2>
   10676:	9702                	jalr	a4
   10678:	00892703          	lw	a4,8(s2)
   1067c:	1f8a3783          	ld	a5,504(s4)
   10680:	01871463          	bne	a4,s8,10688 <__call_exitprocs+0x9c>
   10684:	fb2787e3          	beq	a5,s2,10632 <__call_exitprocs+0x46>
   10688:	dbcd                	beqz	a5,1063a <__call_exitprocs+0x4e>
   1068a:	893e                	mv	s2,a5
   1068c:	b769                	j	10616 <__call_exitprocs+0x2a>
   1068e:	31492783          	lw	a5,788(s2)
   10692:	1084b583          	ld	a1,264(s1)
   10696:	8ff5                	and	a5,a5,a3
   10698:	2781                	sext.w	a5,a5
   1069a:	e799                	bnez	a5,106a8 <__call_exitprocs+0xbc>
   1069c:	855a                	mv	a0,s6
   1069e:	9702                	jalr	a4
   106a0:	bfe1                	j	10678 <__call_exitprocs+0x8c>
   106a2:	00892423          	sw	s0,8(s2)
   106a6:	bf75                	j	10662 <__call_exitprocs+0x76>
   106a8:	852e                	mv	a0,a1
   106aa:	9702                	jalr	a4
   106ac:	b7f1                	j	10678 <__call_exitprocs+0x8c>

00000000000106ae <__libc_fini_array>:
   106ae:	1101                	add	sp,sp,-32
   106b0:	e822                	sd	s0,16(sp)
   106b2:	67c5                	lui	a5,0x11
   106b4:	6445                	lui	s0,0x11
   106b6:	01878793          	add	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   106ba:	02040413          	add	s0,s0,32 # 11020 <__DATA_BEGIN__>
   106be:	8c1d                	sub	s0,s0,a5
   106c0:	e426                	sd	s1,8(sp)
   106c2:	ec06                	sd	ra,24(sp)
   106c4:	40345493          	sra	s1,s0,0x3
   106c8:	c881                	beqz	s1,106d8 <__libc_fini_array+0x2a>
   106ca:	1461                	add	s0,s0,-8
   106cc:	943e                	add	s0,s0,a5
   106ce:	601c                	ld	a5,0(s0)
   106d0:	14fd                	add	s1,s1,-1
   106d2:	1461                	add	s0,s0,-8
   106d4:	9782                	jalr	a5
   106d6:	fce5                	bnez	s1,106ce <__libc_fini_array+0x20>
   106d8:	60e2                	ld	ra,24(sp)
   106da:	6442                	ld	s0,16(sp)
   106dc:	64a2                	ld	s1,8(sp)
   106de:	6105                	add	sp,sp,32
   106e0:	8082                	ret

00000000000106e2 <atexit>:
   106e2:	85aa                	mv	a1,a0
   106e4:	4681                	li	a3,0
   106e6:	4601                	li	a2,0
   106e8:	4501                	li	a0,0
   106ea:	a009                	j	106ec <__register_exitproc>

00000000000106ec <__register_exitproc>:
   106ec:	fe81b703          	ld	a4,-24(gp) # 11808 <_global_impure_ptr>
   106f0:	1f873783          	ld	a5,504(a4)
   106f4:	c3b1                	beqz	a5,10738 <__register_exitproc+0x4c>
   106f6:	4798                	lw	a4,8(a5)
   106f8:	487d                	li	a6,31
   106fa:	06e84263          	blt	a6,a4,1075e <__register_exitproc+0x72>
   106fe:	c505                	beqz	a0,10726 <__register_exitproc+0x3a>
   10700:	00371813          	sll	a6,a4,0x3
   10704:	983e                	add	a6,a6,a5
   10706:	10c83823          	sd	a2,272(a6)
   1070a:	3107a883          	lw	a7,784(a5)
   1070e:	4605                	li	a2,1
   10710:	00e6163b          	sllw	a2,a2,a4
   10714:	00c8e8b3          	or	a7,a7,a2
   10718:	3117a823          	sw	a7,784(a5)
   1071c:	20d83823          	sd	a3,528(a6)
   10720:	4689                	li	a3,2
   10722:	02d50063          	beq	a0,a3,10742 <__register_exitproc+0x56>
   10726:	00270693          	add	a3,a4,2
   1072a:	068e                	sll	a3,a3,0x3
   1072c:	2705                	addw	a4,a4,1
   1072e:	c798                	sw	a4,8(a5)
   10730:	97b6                	add	a5,a5,a3
   10732:	e38c                	sd	a1,0(a5)
   10734:	4501                	li	a0,0
   10736:	8082                	ret
   10738:	20070793          	add	a5,a4,512
   1073c:	1ef73c23          	sd	a5,504(a4)
   10740:	bf5d                	j	106f6 <__register_exitproc+0xa>
   10742:	3147a683          	lw	a3,788(a5)
   10746:	4501                	li	a0,0
   10748:	8ed1                	or	a3,a3,a2
   1074a:	30d7aa23          	sw	a3,788(a5)
   1074e:	00270693          	add	a3,a4,2
   10752:	068e                	sll	a3,a3,0x3
   10754:	2705                	addw	a4,a4,1
   10756:	c798                	sw	a4,8(a5)
   10758:	97b6                	add	a5,a5,a3
   1075a:	e38c                	sd	a1,0(a5)
   1075c:	8082                	ret
   1075e:	557d                	li	a0,-1
   10760:	8082                	ret

0000000000010762 <_exit>:
   10762:	05d00893          	li	a7,93
   10766:	00000073          	ecall
   1076a:	00054363          	bltz	a0,10770 <_exit+0xe>
   1076e:	a001                	j	1076e <_exit+0xc>
   10770:	1141                	add	sp,sp,-16
   10772:	e022                	sd	s0,0(sp)
   10774:	842a                	mv	s0,a0
   10776:	e406                	sd	ra,8(sp)
   10778:	4080043b          	negw	s0,s0
   1077c:	008000ef          	jal	10784 <__errno>
   10780:	c100                	sw	s0,0(a0)
   10782:	a001                	j	10782 <_exit+0x20>

0000000000010784 <__errno>:
   10784:	ff81b503          	ld	a0,-8(gp) # 11818 <_impure_ptr>
   10788:	8082                	ret

srai.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	324000ef          	jal	10416 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d18 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	48a000ef          	jal	1058c <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4d850513          	add	a0,a0,1240 # 104d8 <__libc_fini_array>
   10112:	aeed                	j	1050c <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cba18193          	add	gp,gp,-838 # 11dd0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d30 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d68 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	242000ef          	jal	1036c <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3de50513          	add	a0,a0,990 # 1050c <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3a050513          	add	a0,a0,928 # 104d8 <__libc_fini_array>
   10140:	3cc000ef          	jal	1050c <atexit>
   10144:	1be000ef          	jal	10302 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d30 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5b450513          	add	a0,a0,1460 # 115b4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d30 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d38 <object.0>
   1018e:	5b450513          	add	a0,a0,1460 # 115b4 <__EH_FRAME_BEGIN__>
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
   101ae:	fff0009b          	addw	ra,zero,-1
   101b2:	109e                	sll	ra,ra,0x27
   101b4:	4000d713          	sra	a4,ra,0x0
   101b8:	fff0039b          	addw	t2,zero,-1
   101bc:	139e                	sll	t2,t2,0x27
   101be:	12771a63          	bne	a4,t2,102f2 <fail>

00000000000101c2 <test_3>:
   101c2:	418d                	li	gp,3
   101c4:	800000b7          	lui	ra,0x80000
   101c8:	4010d713          	sra	a4,ra,0x1
   101cc:	c00003b7          	lui	t2,0xc0000
   101d0:	12771163          	bne	a4,t2,102f2 <fail>

00000000000101d4 <test_4>:
   101d4:	4191                	li	gp,4
   101d6:	800000b7          	lui	ra,0x80000
   101da:	4070d713          	sra	a4,ra,0x7
   101de:	ff0003b7          	lui	t2,0xff000
   101e2:	10771863          	bne	a4,t2,102f2 <fail>

00000000000101e6 <test_5>:
   101e6:	4195                	li	gp,5
   101e8:	800000b7          	lui	ra,0x80000
   101ec:	40e0d713          	sra	a4,ra,0xe
   101f0:	7381                	lui	t2,0xfffe0
   101f2:	10771063          	bne	a4,t2,102f2 <fail>

00000000000101f6 <test_6>:
   101f6:	4199                	li	gp,6
   101f8:	800000b7          	lui	ra,0x80000
   101fc:	2085                	addw	ra,ra,1 # ffffffff80000001 <__global_pointer$+0xffffffff7ffee231>
   101fe:	41f0d713          	sra	a4,ra,0x1f
   10202:	53fd                	li	t2,-1
   10204:	0e771763          	bne	a4,t2,102f2 <fail>

0000000000010208 <test_7>:
   10208:	419d                	li	gp,7
   1020a:	800000b7          	lui	ra,0x80000
   1020e:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee22f>
   10210:	4000d713          	sra	a4,ra,0x0
   10214:	800003b7          	lui	t2,0x80000
   10218:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee22f>
   1021a:	0c771c63          	bne	a4,t2,102f2 <fail>

000000000001021e <test_8>:
   1021e:	41a1                	li	gp,8
   10220:	800000b7          	lui	ra,0x80000
   10224:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee22f>
   10226:	4010d713          	sra	a4,ra,0x1
   1022a:	400003b7          	lui	t2,0x40000
   1022e:	33fd                	addw	t2,t2,-1 # 3fffffff <__global_pointer$+0x3ffee22f>
   10230:	0c771163          	bne	a4,t2,102f2 <fail>

0000000000010234 <test_9>:
   10234:	41a5                	li	gp,9
   10236:	800000b7          	lui	ra,0x80000
   1023a:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee22f>
   1023c:	4070d713          	sra	a4,ra,0x7
   10240:	010003b7          	lui	t2,0x1000
   10244:	33fd                	addw	t2,t2,-1 # ffffff <__global_pointer$+0xfee22f>
   10246:	0a771663          	bne	a4,t2,102f2 <fail>

000000000001024a <test_10>:
   1024a:	41a9                	li	gp,10
   1024c:	800000b7          	lui	ra,0x80000
   10250:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee22f>
   10252:	40e0d713          	sra	a4,ra,0xe
   10256:	000203b7          	lui	t2,0x20
   1025a:	33fd                	addw	t2,t2,-1 # 1ffff <__global_pointer$+0xe22f>
   1025c:	08771b63          	bne	a4,t2,102f2 <fail>

0000000000010260 <test_11>:
   10260:	41ad                	li	gp,11
   10262:	800000b7          	lui	ra,0x80000
   10266:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee22f>
   10268:	41f0d713          	sra	a4,ra,0x1f
   1026c:	4381                	li	t2,0
   1026e:	08771263          	bne	a4,t2,102f2 <fail>

0000000000010272 <test_12>:
   10272:	41b1                	li	gp,12
   10274:	818180b7          	lui	ra,0x81818
   10278:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818063b1>
   1027c:	4000d713          	sra	a4,ra,0x0
   10280:	818183b7          	lui	t2,0x81818
   10284:	1813839b          	addw	t2,t2,385 # ffffffff81818181 <__global_pointer$+0xffffffff818063b1>
   10288:	06771563          	bne	a4,t2,102f2 <fail>

000000000001028c <test_13>:
   1028c:	41b5                	li	gp,13
   1028e:	818180b7          	lui	ra,0x81818
   10292:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818063b1>
   10296:	4010d713          	sra	a4,ra,0x1
   1029a:	c0c0c3b7          	lui	t2,0xc0c0c
   1029e:	0c03839b          	addw	t2,t2,192 # ffffffffc0c0c0c0 <__global_pointer$+0xffffffffc0bfa2f0>
   102a2:	04771863          	bne	a4,t2,102f2 <fail>

00000000000102a6 <test_14>:
   102a6:	41b9                	li	gp,14
   102a8:	818180b7          	lui	ra,0x81818
   102ac:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818063b1>
   102b0:	4070d713          	sra	a4,ra,0x7
   102b4:	ff0303b7          	lui	t2,0xff030
   102b8:	3033839b          	addw	t2,t2,771 # ffffffffff030303 <__global_pointer$+0xffffffffff01e533>
   102bc:	02771b63          	bne	a4,t2,102f2 <fail>

00000000000102c0 <test_15>:
   102c0:	41bd                	li	gp,15
   102c2:	818180b7          	lui	ra,0x81818
   102c6:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818063b1>
   102ca:	40e0d713          	sra	a4,ra,0xe
   102ce:	7381                	lui	t2,0xfffe0
   102d0:	6063839b          	addw	t2,t2,1542 # fffffffffffe0606 <__global_pointer$+0xfffffffffffce836>
   102d4:	00771f63          	bne	a4,t2,102f2 <fail>

00000000000102d8 <test_16>:
   102d8:	41c1                	li	gp,16
   102da:	818180b7          	lui	ra,0x81818
   102de:	1810809b          	addw	ra,ra,385 # ffffffff81818181 <__global_pointer$+0xffffffff818063b1>
   102e2:	41f0d713          	sra	a4,ra,0x1f
   102e6:	53fd                	li	t2,-1
   102e8:	00771563          	bne	a4,t2,102f2 <fail>
   102ec:	00301263          	bne	zero,gp,102f0 <pass>

00000000000102f0 <pass>:
   102f0:	a019                	j	102f6 <continue>

00000000000102f2 <fail>:
   102f2:	0000                	unimp
	...

00000000000102f6 <continue>:
   102f6:	4081                	li	ra,0
   102f8:	4781                	li	a5,0
   102fa:	853e                	mv	a0,a5
   102fc:	6462                	ld	s0,24(sp)
   102fe:	6105                	add	sp,sp,32
   10300:	8082                	ret

0000000000010302 <__libc_init_array>:
   10302:	1101                	add	sp,sp,-32
   10304:	e822                	sd	s0,16(sp)
   10306:	67c5                	lui	a5,0x11
   10308:	6445                	lui	s0,0x11
   1030a:	e04a                	sd	s2,0(sp)
   1030c:	5b878793          	add	a5,a5,1464 # 115b8 <__init_array_start>
   10310:	5b840713          	add	a4,s0,1464 # 115b8 <__init_array_start>
   10314:	ec06                	sd	ra,24(sp)
   10316:	e426                	sd	s1,8(sp)
   10318:	40e78933          	sub	s2,a5,a4
   1031c:	00e78d63          	beq	a5,a4,10336 <__libc_init_array+0x34>
   10320:	40395913          	sra	s2,s2,0x3
   10324:	5b840413          	add	s0,s0,1464
   10328:	4481                	li	s1,0
   1032a:	601c                	ld	a5,0(s0)
   1032c:	0485                	add	s1,s1,1
   1032e:	0421                	add	s0,s0,8
   10330:	9782                	jalr	a5
   10332:	ff24ece3          	bltu	s1,s2,1032a <__libc_init_array+0x28>
   10336:	6445                	lui	s0,0x11
   10338:	67c5                	lui	a5,0x11
   1033a:	5c878793          	add	a5,a5,1480 # 115c8 <__do_global_dtors_aux_fini_array_entry>
   1033e:	5b840713          	add	a4,s0,1464 # 115b8 <__init_array_start>
   10342:	40e78933          	sub	s2,a5,a4
   10346:	40395913          	sra	s2,s2,0x3
   1034a:	00e78b63          	beq	a5,a4,10360 <__libc_init_array+0x5e>
   1034e:	5b840413          	add	s0,s0,1464
   10352:	4481                	li	s1,0
   10354:	601c                	ld	a5,0(s0)
   10356:	0485                	add	s1,s1,1
   10358:	0421                	add	s0,s0,8
   1035a:	9782                	jalr	a5
   1035c:	ff24ece3          	bltu	s1,s2,10354 <__libc_init_array+0x52>
   10360:	60e2                	ld	ra,24(sp)
   10362:	6442                	ld	s0,16(sp)
   10364:	64a2                	ld	s1,8(sp)
   10366:	6902                	ld	s2,0(sp)
   10368:	6105                	add	sp,sp,32
   1036a:	8082                	ret

000000000001036c <memset>:
   1036c:	433d                	li	t1,15
   1036e:	872a                	mv	a4,a0
   10370:	02c37163          	bgeu	t1,a2,10392 <memset+0x26>
   10374:	00f77793          	and	a5,a4,15
   10378:	e3c1                	bnez	a5,103f8 <memset+0x8c>
   1037a:	e1bd                	bnez	a1,103e0 <memset+0x74>
   1037c:	ff067693          	and	a3,a2,-16
   10380:	8a3d                	and	a2,a2,15
   10382:	96ba                	add	a3,a3,a4
   10384:	e30c                	sd	a1,0(a4)
   10386:	e70c                	sd	a1,8(a4)
   10388:	0741                	add	a4,a4,16
   1038a:	fed76de3          	bltu	a4,a3,10384 <memset+0x18>
   1038e:	e211                	bnez	a2,10392 <memset+0x26>
   10390:	8082                	ret
   10392:	40c306b3          	sub	a3,t1,a2
   10396:	068a                	sll	a3,a3,0x2
   10398:	00000297          	auipc	t0,0x0
   1039c:	9696                	add	a3,a3,t0
   1039e:	00a68067          	jr	10(a3)
   103a2:	00b70723          	sb	a1,14(a4)
   103a6:	00b706a3          	sb	a1,13(a4)
   103aa:	00b70623          	sb	a1,12(a4)
   103ae:	00b705a3          	sb	a1,11(a4)
   103b2:	00b70523          	sb	a1,10(a4)
   103b6:	00b704a3          	sb	a1,9(a4)
   103ba:	00b70423          	sb	a1,8(a4)
   103be:	00b703a3          	sb	a1,7(a4)
   103c2:	00b70323          	sb	a1,6(a4)
   103c6:	00b702a3          	sb	a1,5(a4)
   103ca:	00b70223          	sb	a1,4(a4)
   103ce:	00b701a3          	sb	a1,3(a4)
   103d2:	00b70123          	sb	a1,2(a4)
   103d6:	00b700a3          	sb	a1,1(a4)
   103da:	00b70023          	sb	a1,0(a4)
   103de:	8082                	ret
   103e0:	0ff5f593          	zext.b	a1,a1
   103e4:	00859693          	sll	a3,a1,0x8
   103e8:	8dd5                	or	a1,a1,a3
   103ea:	01059693          	sll	a3,a1,0x10
   103ee:	8dd5                	or	a1,a1,a3
   103f0:	02059693          	sll	a3,a1,0x20
   103f4:	8dd5                	or	a1,a1,a3
   103f6:	b759                	j	1037c <memset+0x10>
   103f8:	00279693          	sll	a3,a5,0x2
   103fc:	00000297          	auipc	t0,0x0
   10400:	9696                	add	a3,a3,t0
   10402:	8286                	mv	t0,ra
   10404:	fa2680e7          	jalr	-94(a3)
   10408:	8096                	mv	ra,t0
   1040a:	17c1                	add	a5,a5,-16
   1040c:	8f1d                	sub	a4,a4,a5
   1040e:	963e                	add	a2,a2,a5
   10410:	f8c371e3          	bgeu	t1,a2,10392 <memset+0x26>
   10414:	b79d                	j	1037a <memset+0xe>

0000000000010416 <__call_exitprocs>:
   10416:	715d                	add	sp,sp,-80
   10418:	f052                	sd	s4,32(sp)
   1041a:	f481ba03          	ld	s4,-184(gp) # 11d18 <_global_impure_ptr>
   1041e:	f84a                	sd	s2,48(sp)
   10420:	e486                	sd	ra,72(sp)
   10422:	1f8a3903          	ld	s2,504(s4)
   10426:	e0a2                	sd	s0,64(sp)
   10428:	fc26                	sd	s1,56(sp)
   1042a:	f44e                	sd	s3,40(sp)
   1042c:	ec56                	sd	s5,24(sp)
   1042e:	e85a                	sd	s6,16(sp)
   10430:	e45e                	sd	s7,8(sp)
   10432:	e062                	sd	s8,0(sp)
   10434:	02090863          	beqz	s2,10464 <__call_exitprocs+0x4e>
   10438:	8b2a                	mv	s6,a0
   1043a:	8bae                	mv	s7,a1
   1043c:	4a85                	li	s5,1
   1043e:	59fd                	li	s3,-1
   10440:	00892483          	lw	s1,8(s2)
   10444:	fff4841b          	addw	s0,s1,-1
   10448:	00044e63          	bltz	s0,10464 <__call_exitprocs+0x4e>
   1044c:	048e                	sll	s1,s1,0x3
   1044e:	94ca                	add	s1,s1,s2
   10450:	020b8663          	beqz	s7,1047c <__call_exitprocs+0x66>
   10454:	2084b783          	ld	a5,520(s1)
   10458:	03778263          	beq	a5,s7,1047c <__call_exitprocs+0x66>
   1045c:	347d                	addw	s0,s0,-1
   1045e:	14e1                	add	s1,s1,-8
   10460:	ff3418e3          	bne	s0,s3,10450 <__call_exitprocs+0x3a>
   10464:	60a6                	ld	ra,72(sp)
   10466:	6406                	ld	s0,64(sp)
   10468:	74e2                	ld	s1,56(sp)
   1046a:	7942                	ld	s2,48(sp)
   1046c:	79a2                	ld	s3,40(sp)
   1046e:	7a02                	ld	s4,32(sp)
   10470:	6ae2                	ld	s5,24(sp)
   10472:	6b42                	ld	s6,16(sp)
   10474:	6ba2                	ld	s7,8(sp)
   10476:	6c02                	ld	s8,0(sp)
   10478:	6161                	add	sp,sp,80
   1047a:	8082                	ret
   1047c:	00892783          	lw	a5,8(s2)
   10480:	6498                	ld	a4,8(s1)
   10482:	37fd                	addw	a5,a5,-1
   10484:	04878463          	beq	a5,s0,104cc <__call_exitprocs+0xb6>
   10488:	0004b423          	sd	zero,8(s1)
   1048c:	db61                	beqz	a4,1045c <__call_exitprocs+0x46>
   1048e:	31092783          	lw	a5,784(s2)
   10492:	008a96bb          	sllw	a3,s5,s0
   10496:	00892c03          	lw	s8,8(s2)
   1049a:	8ff5                	and	a5,a5,a3
   1049c:	2781                	sext.w	a5,a5
   1049e:	ef89                	bnez	a5,104b8 <__call_exitprocs+0xa2>
   104a0:	9702                	jalr	a4
   104a2:	00892703          	lw	a4,8(s2)
   104a6:	1f8a3783          	ld	a5,504(s4)
   104aa:	01871463          	bne	a4,s8,104b2 <__call_exitprocs+0x9c>
   104ae:	fb2787e3          	beq	a5,s2,1045c <__call_exitprocs+0x46>
   104b2:	dbcd                	beqz	a5,10464 <__call_exitprocs+0x4e>
   104b4:	893e                	mv	s2,a5
   104b6:	b769                	j	10440 <__call_exitprocs+0x2a>
   104b8:	31492783          	lw	a5,788(s2)
   104bc:	1084b583          	ld	a1,264(s1)
   104c0:	8ff5                	and	a5,a5,a3
   104c2:	2781                	sext.w	a5,a5
   104c4:	e799                	bnez	a5,104d2 <__call_exitprocs+0xbc>
   104c6:	855a                	mv	a0,s6
   104c8:	9702                	jalr	a4
   104ca:	bfe1                	j	104a2 <__call_exitprocs+0x8c>
   104cc:	00892423          	sw	s0,8(s2)
   104d0:	bf75                	j	1048c <__call_exitprocs+0x76>
   104d2:	852e                	mv	a0,a1
   104d4:	9702                	jalr	a4
   104d6:	b7f1                	j	104a2 <__call_exitprocs+0x8c>

00000000000104d8 <__libc_fini_array>:
   104d8:	1101                	add	sp,sp,-32
   104da:	e822                	sd	s0,16(sp)
   104dc:	67c5                	lui	a5,0x11
   104de:	6445                	lui	s0,0x11
   104e0:	5c878793          	add	a5,a5,1480 # 115c8 <__do_global_dtors_aux_fini_array_entry>
   104e4:	5d040413          	add	s0,s0,1488 # 115d0 <impure_data>
   104e8:	8c1d                	sub	s0,s0,a5
   104ea:	e426                	sd	s1,8(sp)
   104ec:	ec06                	sd	ra,24(sp)
   104ee:	40345493          	sra	s1,s0,0x3
   104f2:	c881                	beqz	s1,10502 <__libc_fini_array+0x2a>
   104f4:	1461                	add	s0,s0,-8
   104f6:	943e                	add	s0,s0,a5
   104f8:	601c                	ld	a5,0(s0)
   104fa:	14fd                	add	s1,s1,-1
   104fc:	1461                	add	s0,s0,-8
   104fe:	9782                	jalr	a5
   10500:	fce5                	bnez	s1,104f8 <__libc_fini_array+0x20>
   10502:	60e2                	ld	ra,24(sp)
   10504:	6442                	ld	s0,16(sp)
   10506:	64a2                	ld	s1,8(sp)
   10508:	6105                	add	sp,sp,32
   1050a:	8082                	ret

000000000001050c <atexit>:
   1050c:	85aa                	mv	a1,a0
   1050e:	4681                	li	a3,0
   10510:	4601                	li	a2,0
   10512:	4501                	li	a0,0
   10514:	a009                	j	10516 <__register_exitproc>

0000000000010516 <__register_exitproc>:
   10516:	f481b703          	ld	a4,-184(gp) # 11d18 <_global_impure_ptr>
   1051a:	1f873783          	ld	a5,504(a4)
   1051e:	c3b1                	beqz	a5,10562 <__register_exitproc+0x4c>
   10520:	4798                	lw	a4,8(a5)
   10522:	487d                	li	a6,31
   10524:	06e84263          	blt	a6,a4,10588 <__register_exitproc+0x72>
   10528:	c505                	beqz	a0,10550 <__register_exitproc+0x3a>
   1052a:	00371813          	sll	a6,a4,0x3
   1052e:	983e                	add	a6,a6,a5
   10530:	10c83823          	sd	a2,272(a6)
   10534:	3107a883          	lw	a7,784(a5)
   10538:	4605                	li	a2,1
   1053a:	00e6163b          	sllw	a2,a2,a4
   1053e:	00c8e8b3          	or	a7,a7,a2
   10542:	3117a823          	sw	a7,784(a5)
   10546:	20d83823          	sd	a3,528(a6)
   1054a:	4689                	li	a3,2
   1054c:	02d50063          	beq	a0,a3,1056c <__register_exitproc+0x56>
   10550:	00270693          	add	a3,a4,2
   10554:	068e                	sll	a3,a3,0x3
   10556:	2705                	addw	a4,a4,1
   10558:	c798                	sw	a4,8(a5)
   1055a:	97b6                	add	a5,a5,a3
   1055c:	e38c                	sd	a1,0(a5)
   1055e:	4501                	li	a0,0
   10560:	8082                	ret
   10562:	20070793          	add	a5,a4,512
   10566:	1ef73c23          	sd	a5,504(a4)
   1056a:	bf5d                	j	10520 <__register_exitproc+0xa>
   1056c:	3147a683          	lw	a3,788(a5)
   10570:	4501                	li	a0,0
   10572:	8ed1                	or	a3,a3,a2
   10574:	30d7aa23          	sw	a3,788(a5)
   10578:	00270693          	add	a3,a4,2
   1057c:	068e                	sll	a3,a3,0x3
   1057e:	2705                	addw	a4,a4,1
   10580:	c798                	sw	a4,8(a5)
   10582:	97b6                	add	a5,a5,a3
   10584:	e38c                	sd	a1,0(a5)
   10586:	8082                	ret
   10588:	557d                	li	a0,-1
   1058a:	8082                	ret

000000000001058c <_exit>:
   1058c:	05d00893          	li	a7,93
   10590:	00000073          	ecall
   10594:	00054363          	bltz	a0,1059a <_exit+0xe>
   10598:	a001                	j	10598 <_exit+0xc>
   1059a:	1141                	add	sp,sp,-16
   1059c:	e022                	sd	s0,0(sp)
   1059e:	842a                	mv	s0,a0
   105a0:	e406                	sd	ra,8(sp)
   105a2:	4080043b          	negw	s0,s0
   105a6:	008000ef          	jal	105ae <__errno>
   105aa:	c100                	sw	s0,0(a0)
   105ac:	a001                	j	105ac <_exit+0x20>

00000000000105ae <__errno>:
   105ae:	f581b503          	ld	a0,-168(gp) # 11d28 <_impure_ptr>
   105b2:	8082                	ret

sub.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	32e000ef          	jal	10420 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d28 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	494000ef          	jal	10596 <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4e250513          	add	a0,a0,1250 # 104e2 <__libc_fini_array>
   10112:	a111                	j	10516 <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cca18193          	add	gp,gp,-822 # 11de0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d40 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d78 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	24c000ef          	jal	10376 <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3e850513          	add	a0,a0,1000 # 10516 <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3aa50513          	add	a0,a0,938 # 104e2 <__libc_fini_array>
   10140:	3d6000ef          	jal	10516 <atexit>
   10144:	1c8000ef          	jal	1030c <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d40 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5c050513          	add	a0,a0,1472 # 115c0 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d40 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d48 <object.0>
   1018e:	5c050513          	add	a0,a0,1472 # 115c0 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	4101                	li	sp,0
   101b2:	40208733          	sub	a4,ra,sp
   101b6:	4381                	li	t2,0
   101b8:	14771263          	bne	a4,t2,102fc <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	40208733          	sub	a4,ra,sp
   101c6:	4381                	li	t2,0
   101c8:	12771a63          	bne	a4,t2,102fc <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	408d                	li	ra,3
   101d0:	411d                	li	sp,7
   101d2:	40208733          	sub	a4,ra,sp
   101d6:	53f1                	li	t2,-4
   101d8:	12771263          	bne	a4,t2,102fc <fail>

00000000000101dc <test_5>:
   101dc:	4195                	li	gp,5
   101de:	4081                	li	ra,0
   101e0:	ffff8137          	lui	sp,0xffff8
   101e4:	40208733          	sub	a4,ra,sp
   101e8:	63a1                	lui	t2,0x8
   101ea:	10771963          	bne	a4,t2,102fc <fail>

00000000000101ee <test_6>:
   101ee:	4199                	li	gp,6
   101f0:	800000b7          	lui	ra,0x80000
   101f4:	4101                	li	sp,0
   101f6:	40208733          	sub	a4,ra,sp
   101fa:	800003b7          	lui	t2,0x80000
   101fe:	0e771f63          	bne	a4,t2,102fc <fail>

0000000000010202 <test_7>:
   10202:	419d                	li	gp,7
   10204:	800000b7          	lui	ra,0x80000
   10208:	ffff8137          	lui	sp,0xffff8
   1020c:	40208733          	sub	a4,ra,sp
   10210:	800083b7          	lui	t2,0x80008
   10214:	0e771463          	bne	a4,t2,102fc <fail>

0000000000010218 <test_8>:
   10218:	41a1                	li	gp,8
   1021a:	4081                	li	ra,0
   1021c:	00008137          	lui	sp,0x8
   10220:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10222:	40208733          	sub	a4,ra,sp
   10226:	73e1                	lui	t2,0xffff8
   10228:	2385                	addw	t2,t2,1 # ffffffffffff8001 <__global_pointer$+0xfffffffffffe6221>
   1022a:	0c771963          	bne	a4,t2,102fc <fail>

000000000001022e <test_9>:
   1022e:	41a5                	li	gp,9
   10230:	800000b7          	lui	ra,0x80000
   10234:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee21f>
   10236:	4101                	li	sp,0
   10238:	40208733          	sub	a4,ra,sp
   1023c:	800003b7          	lui	t2,0x80000
   10240:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee21f>
   10242:	0a771d63          	bne	a4,t2,102fc <fail>

0000000000010246 <test_10>:
   10246:	41a9                	li	gp,10
   10248:	800000b7          	lui	ra,0x80000
   1024c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee21f>
   1024e:	00008137          	lui	sp,0x8
   10252:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10254:	40208733          	sub	a4,ra,sp
   10258:	7fff83b7          	lui	t2,0x7fff8
   1025c:	0a771063          	bne	a4,t2,102fc <fail>

0000000000010260 <test_11>:
   10260:	41ad                	li	gp,11
   10262:	800000b7          	lui	ra,0x80000
   10266:	00008137          	lui	sp,0x8
   1026a:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1026c:	40208733          	sub	a4,ra,sp
   10270:	73c1                	lui	t2,0xffff0
   10272:	33fd                	addw	t2,t2,-1 # fffffffffffeffff <__global_pointer$+0xfffffffffffde21f>
   10274:	03be                	sll	t2,t2,0xf
   10276:	0385                	add	t2,t2,1
   10278:	08771263          	bne	a4,t2,102fc <fail>

000000000001027c <test_12>:
   1027c:	41b1                	li	gp,12
   1027e:	800000b7          	lui	ra,0x80000
   10282:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee21f>
   10284:	ffff8137          	lui	sp,0xffff8
   10288:	40208733          	sub	a4,ra,sp
   1028c:	63c1                	lui	t2,0x10
   1028e:	2385                	addw	t2,t2,1 # 10001 <exit-0xe7>
   10290:	03be                	sll	t2,t2,0xf
   10292:	13fd                	add	t2,t2,-1
   10294:	06771463          	bne	a4,t2,102fc <fail>

0000000000010298 <test_13>:
   10298:	41b5                	li	gp,13
   1029a:	4081                	li	ra,0
   1029c:	517d                	li	sp,-1
   1029e:	40208733          	sub	a4,ra,sp
   102a2:	4385                	li	t2,1
   102a4:	04771c63          	bne	a4,t2,102fc <fail>

00000000000102a8 <test_14>:
   102a8:	41b9                	li	gp,14
   102aa:	50fd                	li	ra,-1
   102ac:	4105                	li	sp,1
   102ae:	40208733          	sub	a4,ra,sp
   102b2:	53f9                	li	t2,-2
   102b4:	04771463          	bne	a4,t2,102fc <fail>

00000000000102b8 <test_15>:
   102b8:	41bd                	li	gp,15
   102ba:	50fd                	li	ra,-1
   102bc:	517d                	li	sp,-1
   102be:	40208733          	sub	a4,ra,sp
   102c2:	4381                	li	t2,0
   102c4:	02771c63          	bne	a4,t2,102fc <fail>

00000000000102c8 <test_16>:
   102c8:	41c1                	li	gp,16
   102ca:	40b5                	li	ra,13
   102cc:	412d                	li	sp,11
   102ce:	402080b3          	sub	ra,ra,sp
   102d2:	4389                	li	t2,2
   102d4:	02709463          	bne	ra,t2,102fc <fail>

00000000000102d8 <test_17>:
   102d8:	41c5                	li	gp,17
   102da:	40b9                	li	ra,14
   102dc:	412d                	li	sp,11
   102de:	40208133          	sub	sp,ra,sp
   102e2:	438d                	li	t2,3
   102e4:	00711c63          	bne	sp,t2,102fc <fail>

00000000000102e8 <test_18>:
   102e8:	41c9                	li	gp,18
   102ea:	40b5                	li	ra,13
   102ec:	401080b3          	sub	ra,ra,ra
   102f0:	4381                	li	t2,0
   102f2:	00709563          	bne	ra,t2,102fc <fail>
   102f6:	00301263          	bne	zero,gp,102fa <pass>

00000000000102fa <pass>:
   102fa:	a019                	j	10300 <continue>

00000000000102fc <fail>:
   102fc:	0000                	unimp
	...

0000000000010300 <continue>:
   10300:	4081                	li	ra,0
   10302:	4781                	li	a5,0
   10304:	853e                	mv	a0,a5
   10306:	6462                	ld	s0,24(sp)
   10308:	6105                	add	sp,sp,32
   1030a:	8082                	ret

000000000001030c <__libc_init_array>:
   1030c:	1101                	add	sp,sp,-32 # ffffffffffff7fe0 <__global_pointer$+0xfffffffffffe6200>
   1030e:	e822                	sd	s0,16(sp)
   10310:	67c5                	lui	a5,0x11
   10312:	6445                	lui	s0,0x11
   10314:	e04a                	sd	s2,0(sp)
   10316:	5c478793          	add	a5,a5,1476 # 115c4 <__preinit_array_end>
   1031a:	5c440713          	add	a4,s0,1476 # 115c4 <__preinit_array_end>
   1031e:	ec06                	sd	ra,24(sp)
   10320:	e426                	sd	s1,8(sp)
   10322:	40e78933          	sub	s2,a5,a4
   10326:	00e78d63          	beq	a5,a4,10340 <__libc_init_array+0x34>
   1032a:	40395913          	sra	s2,s2,0x3
   1032e:	5c440413          	add	s0,s0,1476
   10332:	4481                	li	s1,0
   10334:	601c                	ld	a5,0(s0)
   10336:	0485                	add	s1,s1,1
   10338:	0421                	add	s0,s0,8
   1033a:	9782                	jalr	a5
   1033c:	ff24ece3          	bltu	s1,s2,10334 <__libc_init_array+0x28>
   10340:	6445                	lui	s0,0x11
   10342:	67c5                	lui	a5,0x11
   10344:	5d878793          	add	a5,a5,1496 # 115d8 <__do_global_dtors_aux_fini_array_entry>
   10348:	5c840713          	add	a4,s0,1480 # 115c8 <__init_array_start>
   1034c:	40e78933          	sub	s2,a5,a4
   10350:	40395913          	sra	s2,s2,0x3
   10354:	00e78b63          	beq	a5,a4,1036a <__libc_init_array+0x5e>
   10358:	5c840413          	add	s0,s0,1480
   1035c:	4481                	li	s1,0
   1035e:	601c                	ld	a5,0(s0)
   10360:	0485                	add	s1,s1,1
   10362:	0421                	add	s0,s0,8
   10364:	9782                	jalr	a5
   10366:	ff24ece3          	bltu	s1,s2,1035e <__libc_init_array+0x52>
   1036a:	60e2                	ld	ra,24(sp)
   1036c:	6442                	ld	s0,16(sp)
   1036e:	64a2                	ld	s1,8(sp)
   10370:	6902                	ld	s2,0(sp)
   10372:	6105                	add	sp,sp,32
   10374:	8082                	ret

0000000000010376 <memset>:
   10376:	433d                	li	t1,15
   10378:	872a                	mv	a4,a0
   1037a:	02c37163          	bgeu	t1,a2,1039c <memset+0x26>
   1037e:	00f77793          	and	a5,a4,15
   10382:	e3c1                	bnez	a5,10402 <memset+0x8c>
   10384:	e1bd                	bnez	a1,103ea <memset+0x74>
   10386:	ff067693          	and	a3,a2,-16
   1038a:	8a3d                	and	a2,a2,15
   1038c:	96ba                	add	a3,a3,a4
   1038e:	e30c                	sd	a1,0(a4)
   10390:	e70c                	sd	a1,8(a4)
   10392:	0741                	add	a4,a4,16
   10394:	fed76de3          	bltu	a4,a3,1038e <memset+0x18>
   10398:	e211                	bnez	a2,1039c <memset+0x26>
   1039a:	8082                	ret
   1039c:	40c306b3          	sub	a3,t1,a2
   103a0:	068a                	sll	a3,a3,0x2
   103a2:	00000297          	auipc	t0,0x0
   103a6:	9696                	add	a3,a3,t0
   103a8:	00a68067          	jr	10(a3)
   103ac:	00b70723          	sb	a1,14(a4)
   103b0:	00b706a3          	sb	a1,13(a4)
   103b4:	00b70623          	sb	a1,12(a4)
   103b8:	00b705a3          	sb	a1,11(a4)
   103bc:	00b70523          	sb	a1,10(a4)
   103c0:	00b704a3          	sb	a1,9(a4)
   103c4:	00b70423          	sb	a1,8(a4)
   103c8:	00b703a3          	sb	a1,7(a4)
   103cc:	00b70323          	sb	a1,6(a4)
   103d0:	00b702a3          	sb	a1,5(a4)
   103d4:	00b70223          	sb	a1,4(a4)
   103d8:	00b701a3          	sb	a1,3(a4)
   103dc:	00b70123          	sb	a1,2(a4)
   103e0:	00b700a3          	sb	a1,1(a4)
   103e4:	00b70023          	sb	a1,0(a4)
   103e8:	8082                	ret
   103ea:	0ff5f593          	zext.b	a1,a1
   103ee:	00859693          	sll	a3,a1,0x8
   103f2:	8dd5                	or	a1,a1,a3
   103f4:	01059693          	sll	a3,a1,0x10
   103f8:	8dd5                	or	a1,a1,a3
   103fa:	02059693          	sll	a3,a1,0x20
   103fe:	8dd5                	or	a1,a1,a3
   10400:	b759                	j	10386 <memset+0x10>
   10402:	00279693          	sll	a3,a5,0x2
   10406:	00000297          	auipc	t0,0x0
   1040a:	9696                	add	a3,a3,t0
   1040c:	8286                	mv	t0,ra
   1040e:	fa2680e7          	jalr	-94(a3)
   10412:	8096                	mv	ra,t0
   10414:	17c1                	add	a5,a5,-16
   10416:	8f1d                	sub	a4,a4,a5
   10418:	963e                	add	a2,a2,a5
   1041a:	f8c371e3          	bgeu	t1,a2,1039c <memset+0x26>
   1041e:	b79d                	j	10384 <memset+0xe>

0000000000010420 <__call_exitprocs>:
   10420:	715d                	add	sp,sp,-80
   10422:	f052                	sd	s4,32(sp)
   10424:	f481ba03          	ld	s4,-184(gp) # 11d28 <_global_impure_ptr>
   10428:	f84a                	sd	s2,48(sp)
   1042a:	e486                	sd	ra,72(sp)
   1042c:	1f8a3903          	ld	s2,504(s4)
   10430:	e0a2                	sd	s0,64(sp)
   10432:	fc26                	sd	s1,56(sp)
   10434:	f44e                	sd	s3,40(sp)
   10436:	ec56                	sd	s5,24(sp)
   10438:	e85a                	sd	s6,16(sp)
   1043a:	e45e                	sd	s7,8(sp)
   1043c:	e062                	sd	s8,0(sp)
   1043e:	02090863          	beqz	s2,1046e <__call_exitprocs+0x4e>
   10442:	8b2a                	mv	s6,a0
   10444:	8bae                	mv	s7,a1
   10446:	4a85                	li	s5,1
   10448:	59fd                	li	s3,-1
   1044a:	00892483          	lw	s1,8(s2)
   1044e:	fff4841b          	addw	s0,s1,-1
   10452:	00044e63          	bltz	s0,1046e <__call_exitprocs+0x4e>
   10456:	048e                	sll	s1,s1,0x3
   10458:	94ca                	add	s1,s1,s2
   1045a:	020b8663          	beqz	s7,10486 <__call_exitprocs+0x66>
   1045e:	2084b783          	ld	a5,520(s1)
   10462:	03778263          	beq	a5,s7,10486 <__call_exitprocs+0x66>
   10466:	347d                	addw	s0,s0,-1
   10468:	14e1                	add	s1,s1,-8
   1046a:	ff3418e3          	bne	s0,s3,1045a <__call_exitprocs+0x3a>
   1046e:	60a6                	ld	ra,72(sp)
   10470:	6406                	ld	s0,64(sp)
   10472:	74e2                	ld	s1,56(sp)
   10474:	7942                	ld	s2,48(sp)
   10476:	79a2                	ld	s3,40(sp)
   10478:	7a02                	ld	s4,32(sp)
   1047a:	6ae2                	ld	s5,24(sp)
   1047c:	6b42                	ld	s6,16(sp)
   1047e:	6ba2                	ld	s7,8(sp)
   10480:	6c02                	ld	s8,0(sp)
   10482:	6161                	add	sp,sp,80
   10484:	8082                	ret
   10486:	00892783          	lw	a5,8(s2)
   1048a:	6498                	ld	a4,8(s1)
   1048c:	37fd                	addw	a5,a5,-1
   1048e:	04878463          	beq	a5,s0,104d6 <__call_exitprocs+0xb6>
   10492:	0004b423          	sd	zero,8(s1)
   10496:	db61                	beqz	a4,10466 <__call_exitprocs+0x46>
   10498:	31092783          	lw	a5,784(s2)
   1049c:	008a96bb          	sllw	a3,s5,s0
   104a0:	00892c03          	lw	s8,8(s2)
   104a4:	8ff5                	and	a5,a5,a3
   104a6:	2781                	sext.w	a5,a5
   104a8:	ef89                	bnez	a5,104c2 <__call_exitprocs+0xa2>
   104aa:	9702                	jalr	a4
   104ac:	00892703          	lw	a4,8(s2)
   104b0:	1f8a3783          	ld	a5,504(s4)
   104b4:	01871463          	bne	a4,s8,104bc <__call_exitprocs+0x9c>
   104b8:	fb2787e3          	beq	a5,s2,10466 <__call_exitprocs+0x46>
   104bc:	dbcd                	beqz	a5,1046e <__call_exitprocs+0x4e>
   104be:	893e                	mv	s2,a5
   104c0:	b769                	j	1044a <__call_exitprocs+0x2a>
   104c2:	31492783          	lw	a5,788(s2)
   104c6:	1084b583          	ld	a1,264(s1)
   104ca:	8ff5                	and	a5,a5,a3
   104cc:	2781                	sext.w	a5,a5
   104ce:	e799                	bnez	a5,104dc <__call_exitprocs+0xbc>
   104d0:	855a                	mv	a0,s6
   104d2:	9702                	jalr	a4
   104d4:	bfe1                	j	104ac <__call_exitprocs+0x8c>
   104d6:	00892423          	sw	s0,8(s2)
   104da:	bf75                	j	10496 <__call_exitprocs+0x76>
   104dc:	852e                	mv	a0,a1
   104de:	9702                	jalr	a4
   104e0:	b7f1                	j	104ac <__call_exitprocs+0x8c>

00000000000104e2 <__libc_fini_array>:
   104e2:	1101                	add	sp,sp,-32
   104e4:	e822                	sd	s0,16(sp)
   104e6:	67c5                	lui	a5,0x11
   104e8:	6445                	lui	s0,0x11
   104ea:	5d878793          	add	a5,a5,1496 # 115d8 <__do_global_dtors_aux_fini_array_entry>
   104ee:	5e040413          	add	s0,s0,1504 # 115e0 <impure_data>
   104f2:	8c1d                	sub	s0,s0,a5
   104f4:	e426                	sd	s1,8(sp)
   104f6:	ec06                	sd	ra,24(sp)
   104f8:	40345493          	sra	s1,s0,0x3
   104fc:	c881                	beqz	s1,1050c <__libc_fini_array+0x2a>
   104fe:	1461                	add	s0,s0,-8
   10500:	943e                	add	s0,s0,a5
   10502:	601c                	ld	a5,0(s0)
   10504:	14fd                	add	s1,s1,-1
   10506:	1461                	add	s0,s0,-8
   10508:	9782                	jalr	a5
   1050a:	fce5                	bnez	s1,10502 <__libc_fini_array+0x20>
   1050c:	60e2                	ld	ra,24(sp)
   1050e:	6442                	ld	s0,16(sp)
   10510:	64a2                	ld	s1,8(sp)
   10512:	6105                	add	sp,sp,32
   10514:	8082                	ret

0000000000010516 <atexit>:
   10516:	85aa                	mv	a1,a0
   10518:	4681                	li	a3,0
   1051a:	4601                	li	a2,0
   1051c:	4501                	li	a0,0
   1051e:	a009                	j	10520 <__register_exitproc>

0000000000010520 <__register_exitproc>:
   10520:	f481b703          	ld	a4,-184(gp) # 11d28 <_global_impure_ptr>
   10524:	1f873783          	ld	a5,504(a4)
   10528:	c3b1                	beqz	a5,1056c <__register_exitproc+0x4c>
   1052a:	4798                	lw	a4,8(a5)
   1052c:	487d                	li	a6,31
   1052e:	06e84263          	blt	a6,a4,10592 <__register_exitproc+0x72>
   10532:	c505                	beqz	a0,1055a <__register_exitproc+0x3a>
   10534:	00371813          	sll	a6,a4,0x3
   10538:	983e                	add	a6,a6,a5
   1053a:	10c83823          	sd	a2,272(a6)
   1053e:	3107a883          	lw	a7,784(a5)
   10542:	4605                	li	a2,1
   10544:	00e6163b          	sllw	a2,a2,a4
   10548:	00c8e8b3          	or	a7,a7,a2
   1054c:	3117a823          	sw	a7,784(a5)
   10550:	20d83823          	sd	a3,528(a6)
   10554:	4689                	li	a3,2
   10556:	02d50063          	beq	a0,a3,10576 <__register_exitproc+0x56>
   1055a:	00270693          	add	a3,a4,2
   1055e:	068e                	sll	a3,a3,0x3
   10560:	2705                	addw	a4,a4,1
   10562:	c798                	sw	a4,8(a5)
   10564:	97b6                	add	a5,a5,a3
   10566:	e38c                	sd	a1,0(a5)
   10568:	4501                	li	a0,0
   1056a:	8082                	ret
   1056c:	20070793          	add	a5,a4,512
   10570:	1ef73c23          	sd	a5,504(a4)
   10574:	bf5d                	j	1052a <__register_exitproc+0xa>
   10576:	3147a683          	lw	a3,788(a5)
   1057a:	4501                	li	a0,0
   1057c:	8ed1                	or	a3,a3,a2
   1057e:	30d7aa23          	sw	a3,788(a5)
   10582:	00270693          	add	a3,a4,2
   10586:	068e                	sll	a3,a3,0x3
   10588:	2705                	addw	a4,a4,1
   1058a:	c798                	sw	a4,8(a5)
   1058c:	97b6                	add	a5,a5,a3
   1058e:	e38c                	sd	a1,0(a5)
   10590:	8082                	ret
   10592:	557d                	li	a0,-1
   10594:	8082                	ret

0000000000010596 <_exit>:
   10596:	05d00893          	li	a7,93
   1059a:	00000073          	ecall
   1059e:	00054363          	bltz	a0,105a4 <_exit+0xe>
   105a2:	a001                	j	105a2 <_exit+0xc>
   105a4:	1141                	add	sp,sp,-16
   105a6:	e022                	sd	s0,0(sp)
   105a8:	842a                	mv	s0,a0
   105aa:	e406                	sd	ra,8(sp)
   105ac:	4080043b          	negw	s0,s0
   105b0:	008000ef          	jal	105b8 <__errno>
   105b4:	c100                	sw	s0,0(a0)
   105b6:	a001                	j	105b6 <_exit+0x20>

00000000000105b8 <__errno>:
   105b8:	f581b503          	ld	a0,-168(gp) # 11d38 <_impure_ptr>
   105bc:	8082                	ret

addw.exe:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	1141                	add	sp,sp,-16
   100ea:	4581                	li	a1,0
   100ec:	e022                	sd	s0,0(sp)
   100ee:	e406                	sd	ra,8(sp)
   100f0:	842a                	mv	s0,a0
   100f2:	342000ef          	jal	10434 <__call_exitprocs>
   100f6:	f481b503          	ld	a0,-184(gp) # 11d38 <_global_impure_ptr>
   100fa:	6d3c                	ld	a5,88(a0)
   100fc:	c391                	beqz	a5,10100 <exit+0x18>
   100fe:	9782                	jalr	a5
   10100:	8522                	mv	a0,s0
   10102:	4a8000ef          	jal	105aa <_exit>

0000000000010106 <register_fini>:
   10106:	00000793          	li	a5,0
   1010a:	c789                	beqz	a5,10114 <register_fini+0xe>
   1010c:	6541                	lui	a0,0x10
   1010e:	4f650513          	add	a0,a0,1270 # 104f6 <__libc_fini_array>
   10112:	a921                	j	1052a <atexit>
   10114:	8082                	ret

0000000000010116 <_start>:
   10116:	00002197          	auipc	gp,0x2
   1011a:	cda18193          	add	gp,gp,-806 # 11df0 <__global_pointer$>
   1011e:	f6018513          	add	a0,gp,-160 # 11d50 <completed.1>
   10122:	f9818613          	add	a2,gp,-104 # 11d88 <__BSS_END__>
   10126:	8e09                	sub	a2,a2,a0
   10128:	4581                	li	a1,0
   1012a:	260000ef          	jal	1038a <memset>
   1012e:	00000517          	auipc	a0,0x0
   10132:	3fc50513          	add	a0,a0,1020 # 1052a <atexit>
   10136:	c519                	beqz	a0,10144 <_start+0x2e>
   10138:	00000517          	auipc	a0,0x0
   1013c:	3be50513          	add	a0,a0,958 # 104f6 <__libc_fini_array>
   10140:	3ea000ef          	jal	1052a <atexit>
   10144:	1dc000ef          	jal	10320 <__libc_init_array>
   10148:	4502                	lw	a0,0(sp)
   1014a:	002c                	add	a1,sp,8
   1014c:	4601                	li	a2,0
   1014e:	04e000ef          	jal	1019c <main>
   10152:	bf59                	j	100e8 <exit>

0000000000010154 <__do_global_dtors_aux>:
   10154:	1141                	add	sp,sp,-16
   10156:	e022                	sd	s0,0(sp)
   10158:	f601c783          	lbu	a5,-160(gp) # 11d50 <completed.1>
   1015c:	e406                	sd	ra,8(sp)
   1015e:	ef91                	bnez	a5,1017a <__do_global_dtors_aux+0x26>
   10160:	00000793          	li	a5,0
   10164:	cb81                	beqz	a5,10174 <__do_global_dtors_aux+0x20>
   10166:	6545                	lui	a0,0x11
   10168:	5d450513          	add	a0,a0,1492 # 115d4 <__EH_FRAME_BEGIN__>
   1016c:	00000097          	auipc	ra,0x0
   10170:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   10174:	4785                	li	a5,1
   10176:	f6f18023          	sb	a5,-160(gp) # 11d50 <completed.1>
   1017a:	60a2                	ld	ra,8(sp)
   1017c:	6402                	ld	s0,0(sp)
   1017e:	0141                	add	sp,sp,16
   10180:	8082                	ret

0000000000010182 <frame_dummy>:
   10182:	00000793          	li	a5,0
   10186:	cb91                	beqz	a5,1019a <frame_dummy+0x18>
   10188:	6545                	lui	a0,0x11
   1018a:	f6818593          	add	a1,gp,-152 # 11d58 <object.0>
   1018e:	5d450513          	add	a0,a0,1492 # 115d4 <__EH_FRAME_BEGIN__>
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
   101ae:	4081                	li	ra,0
   101b0:	4101                	li	sp,0
   101b2:	0020873b          	addw	a4,ra,sp
   101b6:	4381                	li	t2,0
   101b8:	14771c63          	bne	a4,t2,10310 <fail>

00000000000101bc <test_3>:
   101bc:	418d                	li	gp,3
   101be:	4085                	li	ra,1
   101c0:	4105                	li	sp,1
   101c2:	0020873b          	addw	a4,ra,sp
   101c6:	4389                	li	t2,2
   101c8:	14771463          	bne	a4,t2,10310 <fail>

00000000000101cc <test_4>:
   101cc:	4191                	li	gp,4
   101ce:	408d                	li	ra,3
   101d0:	411d                	li	sp,7
   101d2:	0020873b          	addw	a4,ra,sp
   101d6:	43a9                	li	t2,10
   101d8:	12771c63          	bne	a4,t2,10310 <fail>

00000000000101dc <test_5>:
   101dc:	4195                	li	gp,5
   101de:	4081                	li	ra,0
   101e0:	ffff8137          	lui	sp,0xffff8
   101e4:	0020873b          	addw	a4,ra,sp
   101e8:	73e1                	lui	t2,0xffff8
   101ea:	12771363          	bne	a4,t2,10310 <fail>

00000000000101ee <test_6>:
   101ee:	4199                	li	gp,6
   101f0:	800000b7          	lui	ra,0x80000
   101f4:	4101                	li	sp,0
   101f6:	0020873b          	addw	a4,ra,sp
   101fa:	800003b7          	lui	t2,0x80000
   101fe:	10771963          	bne	a4,t2,10310 <fail>

0000000000010202 <test_7>:
   10202:	419d                	li	gp,7
   10204:	800000b7          	lui	ra,0x80000
   10208:	ffff8137          	lui	sp,0xffff8
   1020c:	0020873b          	addw	a4,ra,sp
   10210:	7fff83b7          	lui	t2,0x7fff8
   10214:	0e771e63          	bne	a4,t2,10310 <fail>

0000000000010218 <test_8>:
   10218:	41a1                	li	gp,8
   1021a:	4081                	li	ra,0
   1021c:	00008137          	lui	sp,0x8
   10220:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10222:	0020873b          	addw	a4,ra,sp
   10226:	63a1                	lui	t2,0x8
   10228:	33fd                	addw	t2,t2,-1 # 7fff <exit-0x80e9>
   1022a:	0e771363          	bne	a4,t2,10310 <fail>

000000000001022e <test_9>:
   1022e:	41a5                	li	gp,9
   10230:	800000b7          	lui	ra,0x80000
   10234:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10236:	4101                	li	sp,0
   10238:	0020873b          	addw	a4,ra,sp
   1023c:	800003b7          	lui	t2,0x80000
   10240:	33fd                	addw	t2,t2,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10242:	0c771763          	bne	a4,t2,10310 <fail>

0000000000010246 <test_10>:
   10246:	41a9                	li	gp,10
   10248:	800000b7          	lui	ra,0x80000
   1024c:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   1024e:	00008137          	lui	sp,0x8
   10252:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   10254:	0020873b          	addw	a4,ra,sp
   10258:	800083b7          	lui	t2,0x80008
   1025c:	33f9                	addw	t2,t2,-2 # ffffffff80007ffe <__global_pointer$+0xffffffff7fff620e>
   1025e:	0a771963          	bne	a4,t2,10310 <fail>

0000000000010262 <test_11>:
   10262:	41ad                	li	gp,11
   10264:	800000b7          	lui	ra,0x80000
   10268:	00008137          	lui	sp,0x8
   1026c:	317d                	addw	sp,sp,-1 # 7fff <exit-0x80e9>
   1026e:	0020873b          	addw	a4,ra,sp
   10272:	800083b7          	lui	t2,0x80008
   10276:	33fd                	addw	t2,t2,-1 # ffffffff80007fff <__global_pointer$+0xffffffff7fff620f>
   10278:	08771c63          	bne	a4,t2,10310 <fail>

000000000001027c <test_12>:
   1027c:	41b1                	li	gp,12
   1027e:	800000b7          	lui	ra,0x80000
   10282:	30fd                	addw	ra,ra,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   10284:	ffff8137          	lui	sp,0xffff8
   10288:	0020873b          	addw	a4,ra,sp
   1028c:	7fff83b7          	lui	t2,0x7fff8
   10290:	33fd                	addw	t2,t2,-1 # 7fff7fff <__global_pointer$+0x7ffe620f>
   10292:	06771f63          	bne	a4,t2,10310 <fail>

0000000000010296 <test_13>:
   10296:	41b5                	li	gp,13
   10298:	4081                	li	ra,0
   1029a:	517d                	li	sp,-1
   1029c:	0020873b          	addw	a4,ra,sp
   102a0:	53fd                	li	t2,-1
   102a2:	06771763          	bne	a4,t2,10310 <fail>

00000000000102a6 <test_14>:
   102a6:	41b9                	li	gp,14
   102a8:	50fd                	li	ra,-1
   102aa:	4105                	li	sp,1
   102ac:	0020873b          	addw	a4,ra,sp
   102b0:	4381                	li	t2,0
   102b2:	04771f63          	bne	a4,t2,10310 <fail>

00000000000102b6 <test_15>:
   102b6:	41bd                	li	gp,15
   102b8:	50fd                	li	ra,-1
   102ba:	517d                	li	sp,-1
   102bc:	0020873b          	addw	a4,ra,sp
   102c0:	53f9                	li	t2,-2
   102c2:	04771763          	bne	a4,t2,10310 <fail>

00000000000102c6 <test_16>:
   102c6:	41c1                	li	gp,16
   102c8:	4085                	li	ra,1
   102ca:	80000137          	lui	sp,0x80000
   102ce:	317d                	addw	sp,sp,-1 # 7fffffff <__global_pointer$+0x7ffee20f>
   102d0:	0020873b          	addw	a4,ra,sp
   102d4:	800003b7          	lui	t2,0x80000
   102d8:	02771c63          	bne	a4,t2,10310 <fail>

00000000000102dc <test_17>:
   102dc:	41c5                	li	gp,17
   102de:	40b5                	li	ra,13
   102e0:	412d                	li	sp,11
   102e2:	002080bb          	addw	ra,ra,sp
   102e6:	43e1                	li	t2,24
   102e8:	02709463          	bne	ra,t2,10310 <fail>

00000000000102ec <test_18>:
   102ec:	41c9                	li	gp,18
   102ee:	40b9                	li	ra,14
   102f0:	412d                	li	sp,11
   102f2:	0020813b          	addw	sp,ra,sp
   102f6:	43e5                	li	t2,25
   102f8:	00711c63          	bne	sp,t2,10310 <fail>

00000000000102fc <test_19>:
   102fc:	41cd                	li	gp,19
   102fe:	40b5                	li	ra,13
   10300:	001080bb          	addw	ra,ra,ra
   10304:	43e9                	li	t2,26
   10306:	00709563          	bne	ra,t2,10310 <fail>
   1030a:	00301263          	bne	zero,gp,1030e <pass>

000000000001030e <pass>:
   1030e:	a019                	j	10314 <continue>

0000000000010310 <fail>:
   10310:	0000                	unimp
	...

0000000000010314 <continue>:
   10314:	4081                	li	ra,0
   10316:	4781                	li	a5,0
   10318:	853e                	mv	a0,a5
   1031a:	6462                	ld	s0,24(sp)
   1031c:	6105                	add	sp,sp,32
   1031e:	8082                	ret

0000000000010320 <__libc_init_array>:
   10320:	1101                	add	sp,sp,-32
   10322:	e822                	sd	s0,16(sp)
   10324:	67c5                	lui	a5,0x11
   10326:	6445                	lui	s0,0x11
   10328:	e04a                	sd	s2,0(sp)
   1032a:	5d878793          	add	a5,a5,1496 # 115d8 <__init_array_start>
   1032e:	5d840713          	add	a4,s0,1496 # 115d8 <__init_array_start>
   10332:	ec06                	sd	ra,24(sp)
   10334:	e426                	sd	s1,8(sp)
   10336:	40e78933          	sub	s2,a5,a4
   1033a:	00e78d63          	beq	a5,a4,10354 <__libc_init_array+0x34>
   1033e:	40395913          	sra	s2,s2,0x3
   10342:	5d840413          	add	s0,s0,1496
   10346:	4481                	li	s1,0
   10348:	601c                	ld	a5,0(s0)
   1034a:	0485                	add	s1,s1,1
   1034c:	0421                	add	s0,s0,8
   1034e:	9782                	jalr	a5
   10350:	ff24ece3          	bltu	s1,s2,10348 <__libc_init_array+0x28>
   10354:	6445                	lui	s0,0x11
   10356:	67c5                	lui	a5,0x11
   10358:	5e878793          	add	a5,a5,1512 # 115e8 <__do_global_dtors_aux_fini_array_entry>
   1035c:	5d840713          	add	a4,s0,1496 # 115d8 <__init_array_start>
   10360:	40e78933          	sub	s2,a5,a4
   10364:	40395913          	sra	s2,s2,0x3
   10368:	00e78b63          	beq	a5,a4,1037e <__libc_init_array+0x5e>
   1036c:	5d840413          	add	s0,s0,1496
   10370:	4481                	li	s1,0
   10372:	601c                	ld	a5,0(s0)
   10374:	0485                	add	s1,s1,1
   10376:	0421                	add	s0,s0,8
   10378:	9782                	jalr	a5
   1037a:	ff24ece3          	bltu	s1,s2,10372 <__libc_init_array+0x52>
   1037e:	60e2                	ld	ra,24(sp)
   10380:	6442                	ld	s0,16(sp)
   10382:	64a2                	ld	s1,8(sp)
   10384:	6902                	ld	s2,0(sp)
   10386:	6105                	add	sp,sp,32
   10388:	8082                	ret

000000000001038a <memset>:
   1038a:	433d                	li	t1,15
   1038c:	872a                	mv	a4,a0
   1038e:	02c37163          	bgeu	t1,a2,103b0 <memset+0x26>
   10392:	00f77793          	and	a5,a4,15
   10396:	e3c1                	bnez	a5,10416 <memset+0x8c>
   10398:	e1bd                	bnez	a1,103fe <memset+0x74>
   1039a:	ff067693          	and	a3,a2,-16
   1039e:	8a3d                	and	a2,a2,15
   103a0:	96ba                	add	a3,a3,a4
   103a2:	e30c                	sd	a1,0(a4)
   103a4:	e70c                	sd	a1,8(a4)
   103a6:	0741                	add	a4,a4,16
   103a8:	fed76de3          	bltu	a4,a3,103a2 <memset+0x18>
   103ac:	e211                	bnez	a2,103b0 <memset+0x26>
   103ae:	8082                	ret
   103b0:	40c306b3          	sub	a3,t1,a2
   103b4:	068a                	sll	a3,a3,0x2
   103b6:	00000297          	auipc	t0,0x0
   103ba:	9696                	add	a3,a3,t0
   103bc:	00a68067          	jr	10(a3)
   103c0:	00b70723          	sb	a1,14(a4)
   103c4:	00b706a3          	sb	a1,13(a4)
   103c8:	00b70623          	sb	a1,12(a4)
   103cc:	00b705a3          	sb	a1,11(a4)
   103d0:	00b70523          	sb	a1,10(a4)
   103d4:	00b704a3          	sb	a1,9(a4)
   103d8:	00b70423          	sb	a1,8(a4)
   103dc:	00b703a3          	sb	a1,7(a4)
   103e0:	00b70323          	sb	a1,6(a4)
   103e4:	00b702a3          	sb	a1,5(a4)
   103e8:	00b70223          	sb	a1,4(a4)
   103ec:	00b701a3          	sb	a1,3(a4)
   103f0:	00b70123          	sb	a1,2(a4)
   103f4:	00b700a3          	sb	a1,1(a4)
   103f8:	00b70023          	sb	a1,0(a4)
   103fc:	8082                	ret
   103fe:	0ff5f593          	zext.b	a1,a1
   10402:	00859693          	sll	a3,a1,0x8
   10406:	8dd5                	or	a1,a1,a3
   10408:	01059693          	sll	a3,a1,0x10
   1040c:	8dd5                	or	a1,a1,a3
   1040e:	02059693          	sll	a3,a1,0x20
   10412:	8dd5                	or	a1,a1,a3
   10414:	b759                	j	1039a <memset+0x10>
   10416:	00279693          	sll	a3,a5,0x2
   1041a:	00000297          	auipc	t0,0x0
   1041e:	9696                	add	a3,a3,t0
   10420:	8286                	mv	t0,ra
   10422:	fa2680e7          	jalr	-94(a3)
   10426:	8096                	mv	ra,t0
   10428:	17c1                	add	a5,a5,-16
   1042a:	8f1d                	sub	a4,a4,a5
   1042c:	963e                	add	a2,a2,a5
   1042e:	f8c371e3          	bgeu	t1,a2,103b0 <memset+0x26>
   10432:	b79d                	j	10398 <memset+0xe>

0000000000010434 <__call_exitprocs>:
   10434:	715d                	add	sp,sp,-80
   10436:	f052                	sd	s4,32(sp)
   10438:	f481ba03          	ld	s4,-184(gp) # 11d38 <_global_impure_ptr>
   1043c:	f84a                	sd	s2,48(sp)
   1043e:	e486                	sd	ra,72(sp)
   10440:	1f8a3903          	ld	s2,504(s4)
   10444:	e0a2                	sd	s0,64(sp)
   10446:	fc26                	sd	s1,56(sp)
   10448:	f44e                	sd	s3,40(sp)
   1044a:	ec56                	sd	s5,24(sp)
   1044c:	e85a                	sd	s6,16(sp)
   1044e:	e45e                	sd	s7,8(sp)
   10450:	e062                	sd	s8,0(sp)
   10452:	02090863          	beqz	s2,10482 <__call_exitprocs+0x4e>
   10456:	8b2a                	mv	s6,a0
   10458:	8bae                	mv	s7,a1
   1045a:	4a85                	li	s5,1
   1045c:	59fd                	li	s3,-1
   1045e:	00892483          	lw	s1,8(s2)
   10462:	fff4841b          	addw	s0,s1,-1
   10466:	00044e63          	bltz	s0,10482 <__call_exitprocs+0x4e>
   1046a:	048e                	sll	s1,s1,0x3
   1046c:	94ca                	add	s1,s1,s2
   1046e:	020b8663          	beqz	s7,1049a <__call_exitprocs+0x66>
   10472:	2084b783          	ld	a5,520(s1)
   10476:	03778263          	beq	a5,s7,1049a <__call_exitprocs+0x66>
   1047a:	347d                	addw	s0,s0,-1
   1047c:	14e1                	add	s1,s1,-8
   1047e:	ff3418e3          	bne	s0,s3,1046e <__call_exitprocs+0x3a>
   10482:	60a6                	ld	ra,72(sp)
   10484:	6406                	ld	s0,64(sp)
   10486:	74e2                	ld	s1,56(sp)
   10488:	7942                	ld	s2,48(sp)
   1048a:	79a2                	ld	s3,40(sp)
   1048c:	7a02                	ld	s4,32(sp)
   1048e:	6ae2                	ld	s5,24(sp)
   10490:	6b42                	ld	s6,16(sp)
   10492:	6ba2                	ld	s7,8(sp)
   10494:	6c02                	ld	s8,0(sp)
   10496:	6161                	add	sp,sp,80
   10498:	8082                	ret
   1049a:	00892783          	lw	a5,8(s2)
   1049e:	6498                	ld	a4,8(s1)
   104a0:	37fd                	addw	a5,a5,-1
   104a2:	04878463          	beq	a5,s0,104ea <__call_exitprocs+0xb6>
   104a6:	0004b423          	sd	zero,8(s1)
   104aa:	db61                	beqz	a4,1047a <__call_exitprocs+0x46>
   104ac:	31092783          	lw	a5,784(s2)
   104b0:	008a96bb          	sllw	a3,s5,s0
   104b4:	00892c03          	lw	s8,8(s2)
   104b8:	8ff5                	and	a5,a5,a3
   104ba:	2781                	sext.w	a5,a5
   104bc:	ef89                	bnez	a5,104d6 <__call_exitprocs+0xa2>
   104be:	9702                	jalr	a4
   104c0:	00892703          	lw	a4,8(s2)
   104c4:	1f8a3783          	ld	a5,504(s4)
   104c8:	01871463          	bne	a4,s8,104d0 <__call_exitprocs+0x9c>
   104cc:	fb2787e3          	beq	a5,s2,1047a <__call_exitprocs+0x46>
   104d0:	dbcd                	beqz	a5,10482 <__call_exitprocs+0x4e>
   104d2:	893e                	mv	s2,a5
   104d4:	b769                	j	1045e <__call_exitprocs+0x2a>
   104d6:	31492783          	lw	a5,788(s2)
   104da:	1084b583          	ld	a1,264(s1)
   104de:	8ff5                	and	a5,a5,a3
   104e0:	2781                	sext.w	a5,a5
   104e2:	e799                	bnez	a5,104f0 <__call_exitprocs+0xbc>
   104e4:	855a                	mv	a0,s6
   104e6:	9702                	jalr	a4
   104e8:	bfe1                	j	104c0 <__call_exitprocs+0x8c>
   104ea:	00892423          	sw	s0,8(s2)
   104ee:	bf75                	j	104aa <__call_exitprocs+0x76>
   104f0:	852e                	mv	a0,a1
   104f2:	9702                	jalr	a4
   104f4:	b7f1                	j	104c0 <__call_exitprocs+0x8c>

00000000000104f6 <__libc_fini_array>:
   104f6:	1101                	add	sp,sp,-32
   104f8:	e822                	sd	s0,16(sp)
   104fa:	67c5                	lui	a5,0x11
   104fc:	6445                	lui	s0,0x11
   104fe:	5e878793          	add	a5,a5,1512 # 115e8 <__do_global_dtors_aux_fini_array_entry>
   10502:	5f040413          	add	s0,s0,1520 # 115f0 <impure_data>
   10506:	8c1d                	sub	s0,s0,a5
   10508:	e426                	sd	s1,8(sp)
   1050a:	ec06                	sd	ra,24(sp)
   1050c:	40345493          	sra	s1,s0,0x3
   10510:	c881                	beqz	s1,10520 <__libc_fini_array+0x2a>
   10512:	1461                	add	s0,s0,-8
   10514:	943e                	add	s0,s0,a5
   10516:	601c                	ld	a5,0(s0)
   10518:	14fd                	add	s1,s1,-1
   1051a:	1461                	add	s0,s0,-8
   1051c:	9782                	jalr	a5
   1051e:	fce5                	bnez	s1,10516 <__libc_fini_array+0x20>
   10520:	60e2                	ld	ra,24(sp)
   10522:	6442                	ld	s0,16(sp)
   10524:	64a2                	ld	s1,8(sp)
   10526:	6105                	add	sp,sp,32
   10528:	8082                	ret

000000000001052a <atexit>:
   1052a:	85aa                	mv	a1,a0
   1052c:	4681                	li	a3,0
   1052e:	4601                	li	a2,0
   10530:	4501                	li	a0,0
   10532:	a009                	j	10534 <__register_exitproc>

0000000000010534 <__register_exitproc>:
   10534:	f481b703          	ld	a4,-184(gp) # 11d38 <_global_impure_ptr>
   10538:	1f873783          	ld	a5,504(a4)
   1053c:	c3b1                	beqz	a5,10580 <__register_exitproc+0x4c>
   1053e:	4798                	lw	a4,8(a5)
   10540:	487d                	li	a6,31
   10542:	06e84263          	blt	a6,a4,105a6 <__register_exitproc+0x72>
   10546:	c505                	beqz	a0,1056e <__register_exitproc+0x3a>
   10548:	00371813          	sll	a6,a4,0x3
   1054c:	983e                	add	a6,a6,a5
   1054e:	10c83823          	sd	a2,272(a6)
   10552:	3107a883          	lw	a7,784(a5)
   10556:	4605                	li	a2,1
   10558:	00e6163b          	sllw	a2,a2,a4
   1055c:	00c8e8b3          	or	a7,a7,a2
   10560:	3117a823          	sw	a7,784(a5)
   10564:	20d83823          	sd	a3,528(a6)
   10568:	4689                	li	a3,2
   1056a:	02d50063          	beq	a0,a3,1058a <__register_exitproc+0x56>
   1056e:	00270693          	add	a3,a4,2
   10572:	068e                	sll	a3,a3,0x3
   10574:	2705                	addw	a4,a4,1
   10576:	c798                	sw	a4,8(a5)
   10578:	97b6                	add	a5,a5,a3
   1057a:	e38c                	sd	a1,0(a5)
   1057c:	4501                	li	a0,0
   1057e:	8082                	ret
   10580:	20070793          	add	a5,a4,512
   10584:	1ef73c23          	sd	a5,504(a4)
   10588:	bf5d                	j	1053e <__register_exitproc+0xa>
   1058a:	3147a683          	lw	a3,788(a5)
   1058e:	4501                	li	a0,0
   10590:	8ed1                	or	a3,a3,a2
   10592:	30d7aa23          	sw	a3,788(a5)
   10596:	00270693          	add	a3,a4,2
   1059a:	068e                	sll	a3,a3,0x3
   1059c:	2705                	addw	a4,a4,1
   1059e:	c798                	sw	a4,8(a5)
   105a0:	97b6                	add	a5,a5,a3
   105a2:	e38c                	sd	a1,0(a5)
   105a4:	8082                	ret
   105a6:	557d                	li	a0,-1
   105a8:	8082                	ret

00000000000105aa <_exit>:
   105aa:	05d00893          	li	a7,93
   105ae:	00000073          	ecall
   105b2:	00054363          	bltz	a0,105b8 <_exit+0xe>
   105b6:	a001                	j	105b6 <_exit+0xc>
   105b8:	1141                	add	sp,sp,-16
   105ba:	e022                	sd	s0,0(sp)
   105bc:	842a                	mv	s0,a0
   105be:	e406                	sd	ra,8(sp)
   105c0:	4080043b          	negw	s0,s0
   105c4:	008000ef          	jal	105cc <__errno>
   105c8:	c100                	sw	s0,0(a0)
   105ca:	a001                	j	105ca <_exit+0x20>

00000000000105cc <__errno>:
   105cc:	f581b503          	ld	a0,-168(gp) # 11d48 <_impure_ptr>
   105d0:	8082                	ret
