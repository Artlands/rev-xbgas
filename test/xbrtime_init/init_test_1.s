
init_test_1.exe:     file format elf64-littleriscv


Disassembly of section .plt:

0000000000010300 <_PROCEDURE_LINKAGE_TABLE_>:
   10300:	97 23 00 00 33 03 c3 41 03 be 03 d0 13 03 43 fd     .#..3..A......C.
   10310:	93 82 03 d0 13 53 13 00 83 b2 82 00 67 00 0e 00     .....S......g...

0000000000010320 <__libc_start_main@plt>:
   10320:	00002e17          	auipc	t3,0x2
   10324:	cf0e3e03          	ld	t3,-784(t3) # 12010 <__libc_start_main@GLIBC_2.25>
   10328:	000e0367          	jalr	t1,t3
   1032c:	00000013          	nop

Disassembly of section .text:

0000000000010330 <_start>:
   10330:	030000ef          	jal	ra,10360 <_start+0x30>
   10334:	87aa                	mv	a5,a0
   10336:	00000517          	auipc	a0,0x0
   1033a:	0ae50513          	addi	a0,a0,174 # 103e4 <main>
   1033e:	6582                	ld	a1,0(sp)
   10340:	0030                	addi	a2,sp,8
   10342:	ff017113          	andi	sp,sp,-16
   10346:	00000697          	auipc	a3,0x0
   1034a:	61668693          	addi	a3,a3,1558 # 1095c <__libc_csu_init>
   1034e:	00000717          	auipc	a4,0x0
   10352:	66670713          	addi	a4,a4,1638 # 109b4 <__libc_csu_fini>
   10356:	880a                	mv	a6,sp
   10358:	00000317          	auipc	t1,0x0
   1035c:	fc830067          	jr	-56(t1) # 10320 <__libc_start_main@plt>
   10360:	00002197          	auipc	gp,0x2
   10364:	4c018193          	addi	gp,gp,1216 # 12820 <__global_pointer$>
   10368:	8082                	ret
   1036a:	0000                	unimp
	...

000000000001036e <deregister_tm_clones>:
   1036e:	6549                	lui	a0,0x12
   10370:	6749                	lui	a4,0x12
   10372:	00050793          	mv	a5,a0
   10376:	00070713          	mv	a4,a4
   1037a:	00f70b63          	beq	a4,a5,10390 <deregister_tm_clones+0x22>
   1037e:	00000337          	lui	t1,0x0
   10382:	00030313          	mv	t1,t1
   10386:	00030563          	beqz	t1,10390 <deregister_tm_clones+0x22>
   1038a:	00050513          	mv	a0,a0
   1038e:	8302                	jr	t1
   10390:	8082                	ret

0000000000010392 <register_tm_clones>:
   10392:	6549                	lui	a0,0x12
   10394:	00050793          	mv	a5,a0
   10398:	6749                	lui	a4,0x12
   1039a:	00070593          	mv	a1,a4
   1039e:	8d9d                	sub	a1,a1,a5
   103a0:	858d                	srai	a1,a1,0x3
   103a2:	03f5d793          	srli	a5,a1,0x3f
   103a6:	95be                	add	a1,a1,a5
   103a8:	8585                	srai	a1,a1,0x1
   103aa:	c991                	beqz	a1,103be <register_tm_clones+0x2c>
   103ac:	00000337          	lui	t1,0x0
   103b0:	00030313          	mv	t1,t1
   103b4:	00030563          	beqz	t1,103be <register_tm_clones+0x2c>
   103b8:	00050513          	mv	a0,a0
   103bc:	8302                	jr	t1
   103be:	8082                	ret

00000000000103c0 <__do_global_dtors_aux>:
   103c0:	1141                	addi	sp,sp,-16
   103c2:	e022                	sd	s0,0(sp)
   103c4:	8201c783          	lbu	a5,-2016(gp) # 12040 <completed.5768>
   103c8:	e406                	sd	ra,8(sp)
   103ca:	e791                	bnez	a5,103d6 <__do_global_dtors_aux+0x16>
   103cc:	fa3ff0ef          	jal	ra,1036e <deregister_tm_clones>
   103d0:	4785                	li	a5,1
   103d2:	82f18023          	sb	a5,-2016(gp) # 12040 <completed.5768>
   103d6:	60a2                	ld	ra,8(sp)
   103d8:	6402                	ld	s0,0(sp)
   103da:	0141                	addi	sp,sp,16
   103dc:	8082                	ret

00000000000103de <frame_dummy>:
   103de:	fb5ff06f          	j	10392 <register_tm_clones>
	...

00000000000103e4 <main>:
   103e4:	fd010113          	addi	sp,sp,-48
   103e8:	02113423          	sd	ra,40(sp)
   103ec:	02813023          	sd	s0,32(sp)
   103f0:	03010413          	addi	s0,sp,48
   103f4:	00050793          	mv	a5,a0
   103f8:	fcb43823          	sd	a1,-48(s0)
   103fc:	fcf42e23          	sw	a5,-36(s0)
   10400:	fe042623          	sw	zero,-20(s0)
   10404:	fe043023          	sd	zero,-32(s0)
   10408:	46c000ef          	jal	ra,10874 <xbrtime_init>
   1040c:	00050793          	mv	a5,a0
   10410:	fef42623          	sw	a5,-20(s0)
   10414:	00a00513          	li	a0,10
   10418:	174000ef          	jal	ra,1058c <revmalloc>
   1041c:	fea43023          	sd	a0,-32(s0)
   10420:	fe043503          	ld	a0,-32(s0)
   10424:	00000097          	auipc	ra,0x0
   10428:	270080e7          	jalr	624(ra) # 10694 <revfree>
   1042c:	00000097          	auipc	ra,0x0
   10430:	4ac080e7          	jalr	1196(ra) # 108d8 <xbrtime_close>
   10434:	fec42783          	lw	a5,-20(s0)
   10438:	00078513          	mv	a0,a5
   1043c:	02813083          	ld	ra,40(sp)
   10440:	02013403          	ld	s0,32(sp)
   10444:	03010113          	addi	sp,sp,48
   10448:	00008067          	ret
   1044c:	0000                	unimp
	...

0000000000010450 <find_block>:
   10450:	8181b783          	ld	a5,-2024(gp) # 12038 <_edata>
   10454:	02078063          	beqz	a5,10474 <find_block+0x24>
   10458:	0187b703          	ld	a4,24(a5)
   1045c:	00070663          	beqz	a4,10468 <find_block+0x18>
   10460:	0007b703          	ld	a4,0(a5)
   10464:	00b77a63          	bleu	a1,a4,10478 <find_block+0x28>
   10468:	00f53023          	sd	a5,0(a0) # 12000 <__TMC_END__>
   1046c:	0087b783          	ld	a5,8(a5)
   10470:	fe0794e3          	bnez	a5,10458 <find_block+0x8>
   10474:	00000793          	li	a5,0
   10478:	00078513          	mv	a0,a5
   1047c:	00008067          	ret

0000000000010480 <split_block>:
   10480:	00053703          	ld	a4,0(a0)
   10484:	fd800693          	li	a3,-40
   10488:	00853603          	ld	a2,8(a0)
   1048c:	40b686b3          	sub	a3,a3,a1
   10490:	02850793          	addi	a5,a0,40
   10494:	00b787b3          	add	a5,a5,a1
   10498:	00d70733          	add	a4,a4,a3
   1049c:	00e7b023          	sd	a4,0(a5)
   104a0:	02878693          	addi	a3,a5,40
   104a4:	00100713          	li	a4,1
   104a8:	00c7b423          	sd	a2,8(a5)
   104ac:	00e7bc23          	sd	a4,24(a5)
   104b0:	00a7b823          	sd	a0,16(a5)
   104b4:	02d7b023          	sd	a3,32(a5)
   104b8:	00f53423          	sd	a5,8(a0)
   104bc:	0087b703          	ld	a4,8(a5)
   104c0:	00b53023          	sd	a1,0(a0)
   104c4:	00070463          	beqz	a4,104cc <split_block+0x4c>
   104c8:	00f73823          	sd	a5,16(a4) # 12010 <__libc_start_main@GLIBC_2.25>
   104cc:	00008067          	ret

00000000000104d0 <extend_heap>:
   104d0:	8101b783          	ld	a5,-2032(gp) # 12030 <rev_heap_top>
   104d4:	400006b7          	lui	a3,0x40000
   104d8:	00b78633          	add	a2,a5,a1
   104dc:	02c6ec63          	bltu	a3,a2,10514 <extend_heap+0x44>
   104e0:	02878693          	addi	a3,a5,40
   104e4:	00b7b023          	sd	a1,0(a5)
   104e8:	0007b423          	sd	zero,8(a5)
   104ec:	00a7b823          	sd	a0,16(a5)
   104f0:	02d7b023          	sd	a3,32(a5)
   104f4:	00050463          	beqz	a0,104fc <extend_heap+0x2c>
   104f8:	00f53423          	sd	a5,8(a0)
   104fc:	02858593          	addi	a1,a1,40
   10500:	00b785b3          	add	a1,a5,a1
   10504:	0007bc23          	sd	zero,24(a5)
   10508:	80b1b823          	sd	a1,-2032(gp) # 12030 <rev_heap_top>
   1050c:	00078513          	mv	a0,a5
   10510:	00008067          	ret
   10514:	00000793          	li	a5,0
   10518:	ff5ff06f          	j	1050c <extend_heap+0x3c>

000000000001051c <fusion>:
   1051c:	00853783          	ld	a5,8(a0)
   10520:	02078863          	beqz	a5,10550 <fusion+0x34>
   10524:	0187b703          	ld	a4,24(a5)
   10528:	02070463          	beqz	a4,10550 <fusion+0x34>
   1052c:	00053703          	ld	a4,0(a0)
   10530:	0007b603          	ld	a2,0(a5)
   10534:	0087b683          	ld	a3,8(a5)
   10538:	02870793          	addi	a5,a4,40
   1053c:	00c787b3          	add	a5,a5,a2
   10540:	00f53023          	sd	a5,0(a0)
   10544:	00d53423          	sd	a3,8(a0)
   10548:	00068463          	beqz	a3,10550 <fusion+0x34>
   1054c:	00a6b823          	sd	a0,16(a3) # 40000010 <__global_pointer$+0x3ffed7f0>
   10550:	00008067          	ret

0000000000010554 <get_block>:
   10554:	fd850513          	addi	a0,a0,-40
   10558:	00008067          	ret

000000000001055c <valid_addr>:
   1055c:	8181b783          	ld	a5,-2024(gp) # 12038 <_edata>
   10560:	00050713          	mv	a4,a0
   10564:	00000513          	li	a0,0
   10568:	02078063          	beqz	a5,10588 <valid_addr+0x2c>
   1056c:	00e7fe63          	bleu	a4,a5,10588 <valid_addr+0x2c>
   10570:	8101b783          	ld	a5,-2032(gp) # 12030 <rev_heap_top>
   10574:	00f77a63          	bleu	a5,a4,10588 <valid_addr+0x2c>
   10578:	ff873783          	ld	a5,-8(a4)
   1057c:	40e78533          	sub	a0,a5,a4
   10580:	00153513          	seqz	a0,a0
   10584:	00008067          	ret
   10588:	00008067          	ret

000000000001058c <revmalloc>:
   1058c:	8181b783          	ld	a5,-2024(gp) # 12038 <_edata>
   10590:	fff50693          	addi	a3,a0,-1
   10594:	0036d693          	srli	a3,a3,0x3
   10598:	00b69693          	slli	a3,a3,0xb
   1059c:	00079663          	bnez	a5,105a8 <revmalloc+0x1c>
   105a0:	0b00006f          	j	10650 <revmalloc+0xc4>
   105a4:	00070793          	mv	a5,a4
   105a8:	0187b703          	ld	a4,24(a5)
   105ac:	00070663          	beqz	a4,105b8 <revmalloc+0x2c>
   105b0:	0007b703          	ld	a4,0(a5)
   105b4:	04d77463          	bleu	a3,a4,105fc <revmalloc+0x70>
   105b8:	0087b703          	ld	a4,8(a5)
   105bc:	fe0714e3          	bnez	a4,105a4 <revmalloc+0x18>
   105c0:	8101b703          	ld	a4,-2032(gp) # 12030 <rev_heap_top>
   105c4:	400005b7          	lui	a1,0x40000
   105c8:	00d70533          	add	a0,a4,a3
   105cc:	0ca5e063          	bltu	a1,a0,1068c <revmalloc+0x100>
   105d0:	02870513          	addi	a0,a4,40
   105d4:	00d73023          	sd	a3,0(a4)
   105d8:	00073423          	sd	zero,8(a4)
   105dc:	00f73823          	sd	a5,16(a4)
   105e0:	02a73023          	sd	a0,32(a4)
   105e4:	02868693          	addi	a3,a3,40
   105e8:	00e7b423          	sd	a4,8(a5)
   105ec:	00d706b3          	add	a3,a4,a3
   105f0:	00073c23          	sd	zero,24(a4)
   105f4:	80d1b823          	sd	a3,-2032(gp) # 12030 <rev_heap_top>
   105f8:	00008067          	ret
   105fc:	40d70733          	sub	a4,a4,a3
   10600:	02f00613          	li	a2,47
   10604:	02878513          	addi	a0,a5,40
   10608:	04e67063          	bleu	a4,a2,10648 <revmalloc+0xbc>
   1060c:	0087b803          	ld	a6,8(a5)
   10610:	00d50633          	add	a2,a0,a3
   10614:	fd870713          	addi	a4,a4,-40
   10618:	00e63023          	sd	a4,0(a2)
   1061c:	02860593          	addi	a1,a2,40
   10620:	00100713          	li	a4,1
   10624:	01063423          	sd	a6,8(a2)
   10628:	00e63c23          	sd	a4,24(a2)
   1062c:	00f63823          	sd	a5,16(a2)
   10630:	02b63023          	sd	a1,32(a2)
   10634:	00c7b423          	sd	a2,8(a5)
   10638:	00863703          	ld	a4,8(a2)
   1063c:	00d7b023          	sd	a3,0(a5)
   10640:	00070463          	beqz	a4,10648 <revmalloc+0xbc>
   10644:	00c73823          	sd	a2,16(a4)
   10648:	0007bc23          	sd	zero,24(a5)
   1064c:	00008067          	ret
   10650:	8101b783          	ld	a5,-2032(gp) # 12030 <rev_heap_top>
   10654:	40000637          	lui	a2,0x40000
   10658:	00d78533          	add	a0,a5,a3
   1065c:	02a66863          	bltu	a2,a0,1068c <revmalloc+0x100>
   10660:	02868613          	addi	a2,a3,40
   10664:	00d7b023          	sd	a3,0(a5)
   10668:	02878513          	addi	a0,a5,40
   1066c:	00c786b3          	add	a3,a5,a2
   10670:	0007b423          	sd	zero,8(a5)
   10674:	0007b823          	sd	zero,16(a5)
   10678:	02a7b023          	sd	a0,32(a5)
   1067c:	0007bc23          	sd	zero,24(a5)
   10680:	80d1b823          	sd	a3,-2032(gp) # 12030 <rev_heap_top>
   10684:	80f1bc23          	sd	a5,-2024(gp) # 12038 <_edata>
   10688:	00008067          	ret
   1068c:	00000513          	li	a0,0
   10690:	00008067          	ret

0000000000010694 <revfree>:
   10694:	8181b783          	ld	a5,-2024(gp) # 12038 <_edata>
   10698:	0a078263          	beqz	a5,1073c <revfree+0xa8>
   1069c:	0aa7f063          	bleu	a0,a5,1073c <revfree+0xa8>
   106a0:	8101b783          	ld	a5,-2032(gp) # 12030 <rev_heap_top>
   106a4:	08f57c63          	bleu	a5,a0,1073c <revfree+0xa8>
   106a8:	ff853783          	ld	a5,-8(a0)
   106ac:	08f51863          	bne	a0,a5,1073c <revfree+0xa8>
   106b0:	fe853783          	ld	a5,-24(a0)
   106b4:	00100613          	li	a2,1
   106b8:	fec53823          	sd	a2,-16(a0)
   106bc:	08078263          	beqz	a5,10740 <revfree+0xac>
   106c0:	0187b603          	ld	a2,24(a5)
   106c4:	06060e63          	beqz	a2,10740 <revfree+0xac>
   106c8:	0087b603          	ld	a2,8(a5)
   106cc:	06060063          	beqz	a2,1072c <revfree+0x98>
   106d0:	01863583          	ld	a1,24(a2) # 40000018 <__global_pointer$+0x3ffed7f8>
   106d4:	06058463          	beqz	a1,1073c <revfree+0xa8>
   106d8:	0007b583          	ld	a1,0(a5)
   106dc:	00063503          	ld	a0,0(a2)
   106e0:	00863603          	ld	a2,8(a2)
   106e4:	02858593          	addi	a1,a1,40 # 40000028 <__global_pointer$+0x3ffed808>
   106e8:	00a585b3          	add	a1,a1,a0
   106ec:	00b7b023          	sd	a1,0(a5)
   106f0:	00c7b423          	sd	a2,8(a5)
   106f4:	02060c63          	beqz	a2,1072c <revfree+0x98>
   106f8:	01863703          	ld	a4,24(a2)
   106fc:	00f63823          	sd	a5,16(a2)
   10700:	02070e63          	beqz	a4,1073c <revfree+0xa8>
   10704:	00063583          	ld	a1,0(a2)
   10708:	0007b703          	ld	a4,0(a5)
   1070c:	00863683          	ld	a3,8(a2)
   10710:	00b70733          	add	a4,a4,a1
   10714:	02870713          	addi	a4,a4,40
   10718:	00e7b023          	sd	a4,0(a5)
   1071c:	00d7b423          	sd	a3,8(a5)
   10720:	00068e63          	beqz	a3,1073c <revfree+0xa8>
   10724:	00f6b823          	sd	a5,16(a3)
   10728:	00008067          	ret
   1072c:	0107b603          	ld	a2,16(a5)
   10730:	02060263          	beqz	a2,10754 <revfree+0xc0>
   10734:	00063423          	sd	zero,8(a2)
   10738:	80f1b823          	sd	a5,-2032(gp) # 12030 <rev_heap_top>
   1073c:	00008067          	ret
   10740:	fe053603          	ld	a2,-32(a0)
   10744:	fd850793          	addi	a5,a0,-40
   10748:	fe0602e3          	beqz	a2,1072c <revfree+0x98>
   1074c:	01863703          	ld	a4,24(a2)
   10750:	fb1ff06f          	j	10700 <revfree+0x6c>
   10754:	8001bc23          	sd	zero,-2024(gp) # 12038 <_edata>
   10758:	fe1ff06f          	j	10738 <revfree+0xa4>

000000000001075c <__xbrtime_shared_malloc>:
   1075c:	fe010113          	addi	sp,sp,-32
   10760:	00813823          	sd	s0,16(sp)
   10764:	3000c737          	lui	a4,0x3000c
   10768:	30004437          	lui	s0,0x30004
   1076c:	00113c23          	sd	ra,24(sp)
   10770:	00913423          	sd	s1,8(sp)
   10774:	01213023          	sd	s2,0(sp)
   10778:	02840413          	addi	s0,s0,40 # 30004028 <__global_pointer$+0x2fff1808>
   1077c:	02870713          	addi	a4,a4,40 # 3000c028 <__global_pointer$+0x2fff9808>
   10780:	00043783          	ld	a5,0(s0)
   10784:	ff840493          	addi	s1,s0,-8
   10788:	02079663          	bnez	a5,107b4 <__xbrtime_shared_malloc+0x58>
   1078c:	00050913          	mv	s2,a0
   10790:	dfdff0ef          	jal	ra,1058c <revmalloc>
   10794:	00a4b023          	sd	a0,0(s1)
   10798:	01243023          	sd	s2,0(s0)
   1079c:	01813083          	ld	ra,24(sp)
   107a0:	01013403          	ld	s0,16(sp)
   107a4:	00813483          	ld	s1,8(sp)
   107a8:	00013903          	ld	s2,0(sp)
   107ac:	02010113          	addi	sp,sp,32
   107b0:	00008067          	ret
   107b4:	01040413          	addi	s0,s0,16
   107b8:	fce414e3          	bne	s0,a4,10780 <__xbrtime_shared_malloc+0x24>
   107bc:	01813083          	ld	ra,24(sp)
   107c0:	01013403          	ld	s0,16(sp)
   107c4:	00813483          	ld	s1,8(sp)
   107c8:	00013903          	ld	s2,0(sp)
   107cc:	00000513          	li	a0,0
   107d0:	02010113          	addi	sp,sp,32
   107d4:	00008067          	ret

00000000000107d8 <__xbrtime_shared_free>:
   107d8:	fe010113          	addi	sp,sp,-32
   107dc:	00813823          	sd	s0,16(sp)
   107e0:	01213023          	sd	s2,0(sp)
   107e4:	30004437          	lui	s0,0x30004
   107e8:	3000c937          	lui	s2,0x3000c
   107ec:	00913423          	sd	s1,8(sp)
   107f0:	00113c23          	sd	ra,24(sp)
   107f4:	00050493          	mv	s1,a0
   107f8:	02040413          	addi	s0,s0,32 # 30004020 <__global_pointer$+0x2fff1800>
   107fc:	02090913          	addi	s2,s2,32 # 3000c020 <__global_pointer$+0x2fff9800>
   10800:	00c0006f          	j	1080c <__xbrtime_shared_free+0x34>
   10804:	01040413          	addi	s0,s0,16
   10808:	03240463          	beq	s0,s2,10830 <__xbrtime_shared_free+0x58>
   1080c:	00043783          	ld	a5,0(s0)
   10810:	fef4eae3          	bltu	s1,a5,10804 <__xbrtime_shared_free+0x2c>
   10814:	00843703          	ld	a4,8(s0)
   10818:	00e787b3          	add	a5,a5,a4
   1081c:	fef4f4e3          	bleu	a5,s1,10804 <__xbrtime_shared_free+0x2c>
   10820:	00048513          	mv	a0,s1
   10824:	01040413          	addi	s0,s0,16
   10828:	e6dff0ef          	jal	ra,10694 <revfree>
   1082c:	ff2410e3          	bne	s0,s2,1080c <__xbrtime_shared_free+0x34>
   10830:	01813083          	ld	ra,24(sp)
   10834:	01013403          	ld	s0,16(sp)
   10838:	00813483          	ld	s1,8(sp)
   1083c:	00013903          	ld	s2,0(sp)
   10840:	02010113          	addi	sp,sp,32
   10844:	00008067          	ret

0000000000010848 <xbrtime_alloc>:
   10848:	00050463          	beqz	a0,10850 <xbrtime_alloc+0x8>
   1084c:	f11ff06f          	j	1075c <__xbrtime_shared_malloc>
   10850:	00008067          	ret

0000000000010854 <xbrtime_free>:
   10854:	00050e63          	beqz	a0,10870 <xbrtime_free+0x1c>
   10858:	ff010113          	addi	sp,sp,-16
   1085c:	00113423          	sd	ra,8(sp)
   10860:	f79ff0ef          	jal	ra,107d8 <__xbrtime_shared_free>
   10864:	00813083          	ld	ra,8(sp)
   10868:	01010113          	addi	sp,sp,16
   1086c:	0e80006f          	j	10954 <__xbrtime_asm_quiet_fence>
   10870:	00008067          	ret

0000000000010874 <xbrtime_init>:
   10874:	30000737          	lui	a4,0x30000
   10878:	00872603          	lw	a2,8(a4) # 30000008 <__global_pointer$+0x2ffed7e8>
   1087c:	40000793          	li	a5,1024
   10880:	04c7c863          	blt	a5,a2,108d0 <xbrtime_init+0x5c>
   10884:	02c05263          	blez	a2,108a8 <xbrtime_init+0x34>
   10888:	01070713          	addi	a4,a4,16
   1088c:	00000793          	li	a5,0
   10890:	00f73023          	sd	a5,0(a4)
   10894:	00178793          	addi	a5,a5,1
   10898:	00f73223          	sd	a5,4(a4)
   1089c:	0007869b          	sext.w	a3,a5
   108a0:	01070713          	addi	a4,a4,16
   108a4:	fec6c6e3          	blt	a3,a2,10890 <xbrtime_init+0x1c>
   108a8:	300047b7          	lui	a5,0x30004
   108ac:	3000c737          	lui	a4,0x3000c
   108b0:	02078793          	addi	a5,a5,32 # 30004020 <__global_pointer$+0x2fff1800>
   108b4:	02070713          	addi	a4,a4,32 # 3000c020 <__global_pointer$+0x2fff9800>
   108b8:	0007b023          	sd	zero,0(a5)
   108bc:	0007b423          	sd	zero,8(a5)
   108c0:	01078793          	addi	a5,a5,16
   108c4:	fee79ae3          	bne	a5,a4,108b8 <xbrtime_init+0x44>
   108c8:	00000513          	li	a0,0
   108cc:	00008067          	ret
   108d0:	fff00513          	li	a0,-1
   108d4:	00008067          	ret

00000000000108d8 <xbrtime_close>:
   108d8:	fe010113          	addi	sp,sp,-32
   108dc:	00813823          	sd	s0,16(sp)
   108e0:	00913423          	sd	s1,8(sp)
   108e4:	30004437          	lui	s0,0x30004
   108e8:	3000c4b7          	lui	s1,0x3000c
   108ec:	00113c23          	sd	ra,24(sp)
   108f0:	02840413          	addi	s0,s0,40 # 30004028 <__global_pointer$+0x2fff1808>
   108f4:	058000ef          	jal	ra,1094c <__xbrtime_asm_fence>
   108f8:	02848493          	addi	s1,s1,40 # 3000c028 <__global_pointer$+0x2fff9808>
   108fc:	00c0006f          	j	10908 <xbrtime_close+0x30>
   10900:	01040413          	addi	s0,s0,16
   10904:	00940e63          	beq	s0,s1,10920 <xbrtime_close+0x48>
   10908:	00043783          	ld	a5,0(s0)
   1090c:	fe078ae3          	beqz	a5,10900 <xbrtime_close+0x28>
   10910:	ff843503          	ld	a0,-8(s0)
   10914:	01040413          	addi	s0,s0,16
   10918:	f3dff0ef          	jal	ra,10854 <xbrtime_free>
   1091c:	fe9416e3          	bne	s0,s1,10908 <xbrtime_close+0x30>
   10920:	01813083          	ld	ra,24(sp)
   10924:	01013403          	ld	s0,16(sp)
   10928:	00813483          	ld	s1,8(sp)
   1092c:	02010113          	addi	sp,sp,32
   10930:	00008067          	ret

0000000000010934 <xbrtime_mype>:
   10934:	300007b7          	lui	a5,0x30000
   10938:	0007a503          	lw	a0,0(a5) # 30000000 <__global_pointer$+0x2ffed7e0>
   1093c:	00008067          	ret

0000000000010940 <xbrtime_num_pes>:
   10940:	300007b7          	lui	a5,0x30000
   10944:	0087a503          	lw	a0,8(a5) # 30000008 <__global_pointer$+0x2ffed7e8>
   10948:	00008067          	ret

000000000001094c <__xbrtime_asm_fence>:
   1094c:	0000100f          	fence.i
   10950:	00008067          	ret

0000000000010954 <__xbrtime_asm_quiet_fence>:
   10954:	0ff0000f          	fence
   10958:	00008067          	ret

000000000001095c <__libc_csu_init>:
   1095c:	7139                	addi	sp,sp,-64
   1095e:	f822                	sd	s0,48(sp)
   10960:	f04a                	sd	s2,32(sp)
   10962:	00001417          	auipc	s0,0x1
   10966:	4be40413          	addi	s0,s0,1214 # 11e20 <__frame_dummy_init_array_entry>
   1096a:	00001917          	auipc	s2,0x1
   1096e:	4be90913          	addi	s2,s2,1214 # 11e28 <__init_array_end>
   10972:	40890933          	sub	s2,s2,s0
   10976:	fc06                	sd	ra,56(sp)
   10978:	f426                	sd	s1,40(sp)
   1097a:	ec4e                	sd	s3,24(sp)
   1097c:	e852                	sd	s4,16(sp)
   1097e:	e456                	sd	s5,8(sp)
   10980:	40395913          	srai	s2,s2,0x3
   10984:	00090f63          	beqz	s2,109a2 <__libc_csu_init+0x46>
   10988:	8ab2                	mv	s5,a2
   1098a:	8a2e                	mv	s4,a1
   1098c:	89aa                	mv	s3,a0
   1098e:	4481                	li	s1,0
   10990:	601c                	ld	a5,0(s0)
   10992:	8656                	mv	a2,s5
   10994:	85d2                	mv	a1,s4
   10996:	854e                	mv	a0,s3
   10998:	0485                	addi	s1,s1,1
   1099a:	9782                	jalr	a5
   1099c:	0421                	addi	s0,s0,8
   1099e:	fe9919e3          	bne	s2,s1,10990 <__libc_csu_init+0x34>
   109a2:	70e2                	ld	ra,56(sp)
   109a4:	7442                	ld	s0,48(sp)
   109a6:	74a2                	ld	s1,40(sp)
   109a8:	7902                	ld	s2,32(sp)
   109aa:	69e2                	ld	s3,24(sp)
   109ac:	6a42                	ld	s4,16(sp)
   109ae:	6aa2                	ld	s5,8(sp)
   109b0:	6121                	addi	sp,sp,64
   109b2:	8082                	ret

00000000000109b4 <__libc_csu_fini>:
   109b4:	8082                	ret
