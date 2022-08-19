
xbgas_test_0.exe:     file format elf64-littleriscv


Disassembly of section .interp:

0000000000010200 <.interp>:
   10200:	62696c2f          	0x62696c2f
   10204:	2d646c2f          	0x2d646c2f
   10208:	696c                	ld	a1,208(a0)
   1020a:	756e                	ld	a0,248(sp)
   1020c:	2d78                	fld	fa4,216(a0)
   1020e:	6972                	ld	s2,280(sp)
   10210:	36766373          	csrrsi	t1,0x367,12
   10214:	2d34                	fld	fa3,88(a0)
   10216:	706c                	ld	a1,224(s0)
   10218:	3436                	fld	fs0,360(sp)
   1021a:	2e64                	fld	fs1,216(a2)
   1021c:	312e6f73          	csrrsi	t5,0x312,28
	...

Disassembly of section .note.ABI-tag:

0000000000010224 <.note.ABI-tag>:
   10224:	0004                	addi	s1,sp,0
   10226:	0000                	unimp
   10228:	0010                	addi	a2,sp,0
   1022a:	0000                	unimp
   1022c:	0001                	nop
   1022e:	0000                	unimp
   10230:	00554e47          	fmsub.s	ft8,fa0,ft5,ft0,rmm
   10234:	0000                	unimp
   10236:	0000                	unimp
   10238:	00000003          	lb	zero,0(zero) # 0 <_PROCEDURE_LINKAGE_TABLE_-0x10300>
	...

Disassembly of section .hash:

0000000000010248 <.hash>:
   10248:	0001                	nop
   1024a:	0000                	unimp
   1024c:	0002                	0x2
   1024e:	0000                	unimp
   10250:	0001                	nop
	...

Disassembly of section .dynsym:

0000000000010260 <.dynsym>:
	...
   10278:	0000000b          	0xb
   1027c:	0012                	0x12
   1027e:	0000                	unimp
   10280:	0320                	addi	s0,sp,392
   10282:	0001                	nop
	...

Disassembly of section .dynstr:

0000000000010290 <.dynstr>:
   10290:	6c00                	ld	s0,24(s0)
   10292:	6269                	lui	tp,0x1a
   10294:	6f732e63          	0x6f732e63
   10298:	362e                	fld	fa2,232(sp)
   1029a:	5f00                	lw	s0,56(a4)
   1029c:	6c5f 6269 5f63      	0x5f6362696c5f
   102a2:	72617473          	csrrci	s0,0x726,2
   102a6:	5f74                	lw	a3,124(a4)
   102a8:	616d                	addi	sp,sp,240
   102aa:	6e69                	lui	t3,0x1a
   102ac:	4700                	lw	s0,8(a4)
   102ae:	494c                	lw	a1,20(a0)
   102b0:	4342                	lw	t1,16(sp)
   102b2:	325f 322e 0035      	0x35322e325f

Disassembly of section .gnu.version:

00000000000102b8 <.gnu.version>:
   102b8:	0000                	unimp
   102ba:	0002                	0x2

Disassembly of section .gnu.version_r:

00000000000102c0 <.gnu.version_r>:
   102c0:	0001                	nop
   102c2:	0001                	nop
   102c4:	0001                	nop
   102c6:	0000                	unimp
   102c8:	0010                	addi	a2,sp,0
   102ca:	0000                	unimp
   102cc:	0000                	unimp
   102ce:	0000                	unimp
   102d0:	9185                	srli	a1,a1,0x21
   102d2:	0696                	slli	a3,a3,0x5
   102d4:	0000                	unimp
   102d6:	0002                	0x2
   102d8:	001d                	c.addi	zero,7
   102da:	0000                	unimp
   102dc:	0000                	unimp
	...

Disassembly of section .rela.plt:

00000000000102e0 <.rela.plt>:
   102e0:	2010                	fld	fa2,0(s0)
   102e2:	0001                	nop
   102e4:	0000                	unimp
   102e6:	0000                	unimp
   102e8:	0005                	c.addi	zero,1
   102ea:	0000                	unimp
   102ec:	0001                	nop
	...

Disassembly of section .plt:

0000000000010300 <_PROCEDURE_LINKAGE_TABLE_>:
   10300:	00002397          	auipc	t2,0x2
   10304:	41c30333          	sub	t1,t1,t3
   10308:	d003be03          	ld	t3,-768(t2) # 12000 <__TMC_END__>
   1030c:	fd430313          	addi	t1,t1,-44
   10310:	d0038293          	addi	t0,t2,-768
   10314:	00135313          	srli	t1,t1,0x1
   10318:	0082b283          	ld	t0,8(t0)
   1031c:	000e0067          	jr	t3

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
   1034a:	1a468693          	addi	a3,a3,420 # 104ea <__libc_csu_init>
   1034e:	00000717          	auipc	a4,0x0
   10352:	1f470713          	addi	a4,a4,500 # 10542 <__libc_csu_fini>
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
   103c4:	6449                	lui	s0,0x12
   103c6:	03044783          	lbu	a5,48(s0) # 12030 <_edata>
   103ca:	e406                	sd	ra,8(sp)
   103cc:	e791                	bnez	a5,103d8 <__do_global_dtors_aux+0x18>
   103ce:	fa1ff0ef          	jal	ra,1036e <deregister_tm_clones>
   103d2:	4785                	li	a5,1
   103d4:	02f40823          	sb	a5,48(s0)
   103d8:	60a2                	ld	ra,8(sp)
   103da:	6402                	ld	s0,0(sp)
   103dc:	0141                	addi	sp,sp,16
   103de:	8082                	ret

00000000000103e0 <frame_dummy>:
   103e0:	fb3ff06f          	j	10392 <register_tm_clones>

00000000000103e4 <main>:
   103e4:	f7010113          	addi	sp,sp,-144
   103e8:	08813423          	sd	s0,136(sp)
   103ec:	09010413          	addi	s0,sp,144
   103f0:	00050793          	mv	a5,a0
   103f4:	f6b43823          	sd	a1,-144(s0)
   103f8:	f6f42e23          	sw	a5,-132(s0)
   103fc:	04000793          	li	a5,64
   10400:	faf43023          	sd	a5,-96(s0)
   10404:	02000793          	li	a5,32
   10408:	f8f42e23          	sw	a5,-100(s0)
   1040c:	01000793          	li	a5,16
   10410:	f8f41d23          	sh	a5,-102(s0)
   10414:	00800793          	li	a5,8
   10418:	f8f40ca3          	sb	a5,-103(s0)
   1041c:	fa040793          	addi	a5,s0,-96
   10420:	fef43423          	sd	a5,-24(s0)
   10424:	f9c40793          	addi	a5,s0,-100
   10428:	fef43023          	sd	a5,-32(s0)
   1042c:	f9a40793          	addi	a5,s0,-102
   10430:	fcf43c23          	sd	a5,-40(s0)
   10434:	f9940793          	addi	a5,s0,-103
   10438:	fcf43823          	sd	a5,-48(s0)
   1043c:	04000793          	li	a5,64
   10440:	f8f43823          	sd	a5,-112(s0)
   10444:	02000793          	li	a5,32
   10448:	f8f42623          	sw	a5,-116(s0)
   1044c:	01000793          	li	a5,16
   10450:	f8f41523          	sh	a5,-118(s0)
   10454:	00800793          	li	a5,8
   10458:	f8f404a3          	sb	a5,-119(s0)
   1045c:	f9040793          	addi	a5,s0,-112
   10460:	fcf43423          	sd	a5,-56(s0)
   10464:	f8c40793          	addi	a5,s0,-116
   10468:	fcf43023          	sd	a5,-64(s0)
   1046c:	f8a40793          	addi	a5,s0,-118
   10470:	faf43c23          	sd	a5,-72(s0)
   10474:	f8940793          	addi	a5,s0,-119
   10478:	faf43823          	sd	a5,-80(s0)
   1047c:	00200793          	li	a5,2
   10480:	faf43423          	sd	a5,-88(s0)
   10484:	fa843783          	ld	a5,-88(s0)
   10488:	0007f57b          	eaddie	e10,a5,0
   1048c:	fc843783          	ld	a5,-56(s0)
   10490:	aaa7b533          	erld	a0,a5,e10
   10494:	faf43023          	sd	a5,-96(s0)
   10498:	fc043783          	ld	a5,-64(s0)
   1049c:	aaa7a533          	erlw	a0,a5,e10
   104a0:	f8f42e23          	sw	a5,-100(s0)
   104a4:	fb843783          	ld	a5,-72(s0)
   104a8:	aaa79533          	erlh	a0,a5,e10
   104ac:	f8f41d23          	sh	a5,-102(s0)
   104b0:	fb843783          	ld	a5,-72(s0)
   104b4:	aaa7d533          	erlhu	a0,a5,e10
   104b8:	f8f41d23          	sh	a5,-102(s0)
   104bc:	fb043783          	ld	a5,-80(s0)
   104c0:	aaa78533          	erlb	a0,a5,e10
   104c4:	f8f40ca3          	sb	a5,-103(s0)
   104c8:	fb043783          	ld	a5,-80(s0)
   104cc:	aaa7c533          	erlbu	a0,a5,e10
   104d0:	f8f40ca3          	sb	a5,-103(s0)
   104d4:	00000793          	li	a5,0
   104d8:	00078513          	mv	a0,a5
   104dc:	08813403          	ld	s0,136(sp)
   104e0:	09010113          	addi	sp,sp,144
   104e4:	00008067          	ret
	...

00000000000104ea <__libc_csu_init>:
   104ea:	7139                	addi	sp,sp,-64
   104ec:	f822                	sd	s0,48(sp)
   104ee:	f04a                	sd	s2,32(sp)
   104f0:	00002417          	auipc	s0,0x2
   104f4:	93040413          	addi	s0,s0,-1744 # 11e20 <__frame_dummy_init_array_entry>
   104f8:	00002917          	auipc	s2,0x2
   104fc:	93090913          	addi	s2,s2,-1744 # 11e28 <__init_array_end>
   10500:	40890933          	sub	s2,s2,s0
   10504:	fc06                	sd	ra,56(sp)
   10506:	f426                	sd	s1,40(sp)
   10508:	ec4e                	sd	s3,24(sp)
   1050a:	e852                	sd	s4,16(sp)
   1050c:	e456                	sd	s5,8(sp)
   1050e:	40395913          	srai	s2,s2,0x3
   10512:	00090f63          	beqz	s2,10530 <__libc_csu_init+0x46>
   10516:	8ab2                	mv	s5,a2
   10518:	8a2e                	mv	s4,a1
   1051a:	89aa                	mv	s3,a0
   1051c:	4481                	li	s1,0
   1051e:	601c                	ld	a5,0(s0)
   10520:	8656                	mv	a2,s5
   10522:	85d2                	mv	a1,s4
   10524:	854e                	mv	a0,s3
   10526:	0485                	addi	s1,s1,1
   10528:	9782                	jalr	a5
   1052a:	0421                	addi	s0,s0,8
   1052c:	fe9919e3          	bne	s2,s1,1051e <__libc_csu_init+0x34>
   10530:	70e2                	ld	ra,56(sp)
   10532:	7442                	ld	s0,48(sp)
   10534:	74a2                	ld	s1,40(sp)
   10536:	7902                	ld	s2,32(sp)
   10538:	69e2                	ld	s3,24(sp)
   1053a:	6a42                	ld	s4,16(sp)
   1053c:	6aa2                	ld	s5,8(sp)
   1053e:	6121                	addi	sp,sp,64
   10540:	8082                	ret

0000000000010542 <__libc_csu_fini>:
   10542:	8082                	ret

Disassembly of section .eh_frame_hdr:

0000000000010544 <__GNU_EH_FRAME_HDR>:
   10544:	1b01                	addi	s6,s6,-32
   10546:	00103b03          	ld	s6,1(zero) # 1 <_PROCEDURE_LINKAGE_TABLE_-0x102ff>
   1054a:	0000                	unimp
   1054c:	0001                	nop
   1054e:	0000                	unimp
   10550:	fdec                	sd	a1,248(a1)
   10552:	ffff                	0xffff
   10554:	0028                	addi	a0,sp,8
	...

Disassembly of section .eh_frame:

0000000000010558 <__FRAME_END__-0x28>:
   10558:	0010                	addi	a2,sp,0
   1055a:	0000                	unimp
   1055c:	0000                	unimp
   1055e:	0000                	unimp
   10560:	7a01                	lui	s4,0xfffe0
   10562:	0052                	0x52
   10564:	7c01                	lui	s8,0xfffe0
   10566:	0101                	addi	sp,sp,0
   10568:	00020d1b          	sext.w	s10,tp
   1056c:	0010                	addi	a2,sp,0
   1056e:	0000                	unimp
   10570:	0018                	addi	a4,sp,0
   10572:	0000                	unimp
   10574:	fdbc                	sd	a5,120(a1)
   10576:	ffff                	0xffff
   10578:	0030                	addi	a2,sp,8
   1057a:	0000                	unimp
   1057c:	0000                	unimp
	...

0000000000010580 <__FRAME_END__>:
   10580:	0000                	unimp
	...

Disassembly of section .preinit_array:

0000000000011e18 <.preinit_array>:
   11e18:	0360                	addi	s0,sp,396
   11e1a:	0001                	nop
   11e1c:	0000                	unimp
	...

Disassembly of section .init_array:

0000000000011e20 <__frame_dummy_init_array_entry>:
   11e20:	03e0                	addi	s0,sp,460
   11e22:	0001                	nop
   11e24:	0000                	unimp
	...

Disassembly of section .fini_array:

0000000000011e28 <__do_global_dtors_aux_fini_array_entry>:
   11e28:	03c0                	addi	s0,sp,452
   11e2a:	0001                	nop
   11e2c:	0000                	unimp
	...

Disassembly of section .dynamic:

0000000000011e30 <_DYNAMIC>:
   11e30:	0001                	nop
   11e32:	0000                	unimp
   11e34:	0000                	unimp
   11e36:	0000                	unimp
   11e38:	0001                	nop
   11e3a:	0000                	unimp
   11e3c:	0000                	unimp
   11e3e:	0000                	unimp
   11e40:	0020                	addi	s0,sp,8
   11e42:	0000                	unimp
   11e44:	0000                	unimp
   11e46:	0000                	unimp
   11e48:	1e18                	addi	a4,sp,816
   11e4a:	0001                	nop
   11e4c:	0000                	unimp
   11e4e:	0000                	unimp
   11e50:	0021                	c.addi	zero,8
   11e52:	0000                	unimp
   11e54:	0000                	unimp
   11e56:	0000                	unimp
   11e58:	0008                	addi	a0,sp,0
   11e5a:	0000                	unimp
   11e5c:	0000                	unimp
   11e5e:	0000                	unimp
   11e60:	0019                	c.addi	zero,6
   11e62:	0000                	unimp
   11e64:	0000                	unimp
   11e66:	0000                	unimp
   11e68:	1e20                	addi	s0,sp,824
   11e6a:	0001                	nop
   11e6c:	0000                	unimp
   11e6e:	0000                	unimp
   11e70:	0000001b          	sext.w	zero,zero
   11e74:	0000                	unimp
   11e76:	0000                	unimp
   11e78:	0008                	addi	a0,sp,0
   11e7a:	0000                	unimp
   11e7c:	0000                	unimp
   11e7e:	0000                	unimp
   11e80:	001a                	0x1a
   11e82:	0000                	unimp
   11e84:	0000                	unimp
   11e86:	0000                	unimp
   11e88:	1e28                	addi	a0,sp,824
   11e8a:	0001                	nop
   11e8c:	0000                	unimp
   11e8e:	0000                	unimp
   11e90:	001c                	addi	a5,sp,0
   11e92:	0000                	unimp
   11e94:	0000                	unimp
   11e96:	0000                	unimp
   11e98:	0008                	addi	a0,sp,0
   11e9a:	0000                	unimp
   11e9c:	0000                	unimp
   11e9e:	0000                	unimp
   11ea0:	0004                	addi	s1,sp,0
   11ea2:	0000                	unimp
   11ea4:	0000                	unimp
   11ea6:	0000                	unimp
   11ea8:	0248                	addi	a0,sp,260
   11eaa:	0001                	nop
   11eac:	0000                	unimp
   11eae:	0000                	unimp
   11eb0:	0005                	c.addi	zero,1
   11eb2:	0000                	unimp
   11eb4:	0000                	unimp
   11eb6:	0000                	unimp
   11eb8:	0290                	addi	a2,sp,320
   11eba:	0001                	nop
   11ebc:	0000                	unimp
   11ebe:	0000                	unimp
   11ec0:	0006                	0x6
   11ec2:	0000                	unimp
   11ec4:	0000                	unimp
   11ec6:	0000                	unimp
   11ec8:	0260                	addi	s0,sp,268
   11eca:	0001                	nop
   11ecc:	0000                	unimp
   11ece:	0000                	unimp
   11ed0:	000a                	0xa
   11ed2:	0000                	unimp
   11ed4:	0000                	unimp
   11ed6:	0000                	unimp
   11ed8:	0028                	addi	a0,sp,8
   11eda:	0000                	unimp
   11edc:	0000                	unimp
   11ede:	0000                	unimp
   11ee0:	0000000b          	0xb
   11ee4:	0000                	unimp
   11ee6:	0000                	unimp
   11ee8:	0018                	addi	a4,sp,0
   11eea:	0000                	unimp
   11eec:	0000                	unimp
   11eee:	0000                	unimp
   11ef0:	0015                	c.addi	zero,5
	...
   11efe:	0000                	unimp
   11f00:	00000003          	lb	zero,0(zero) # 0 <_PROCEDURE_LINKAGE_TABLE_-0x10300>
   11f04:	0000                	unimp
   11f06:	0000                	unimp
   11f08:	2000                	fld	fs0,0(s0)
   11f0a:	0001                	nop
   11f0c:	0000                	unimp
   11f0e:	0000                	unimp
   11f10:	0002                	0x2
   11f12:	0000                	unimp
   11f14:	0000                	unimp
   11f16:	0000                	unimp
   11f18:	0018                	addi	a4,sp,0
   11f1a:	0000                	unimp
   11f1c:	0000                	unimp
   11f1e:	0000                	unimp
   11f20:	0014                	addi	a3,sp,0
   11f22:	0000                	unimp
   11f24:	0000                	unimp
   11f26:	0000                	unimp
   11f28:	00000007          	0x7
   11f2c:	0000                	unimp
   11f2e:	0000                	unimp
   11f30:	00000017          	auipc	zero,0x0
   11f34:	0000                	unimp
   11f36:	0000                	unimp
   11f38:	02e0                	addi	s0,sp,332
   11f3a:	0001                	nop
   11f3c:	0000                	unimp
   11f3e:	0000                	unimp
   11f40:	00000007          	0x7
   11f44:	0000                	unimp
   11f46:	0000                	unimp
   11f48:	02e0                	addi	s0,sp,332
   11f4a:	0001                	nop
   11f4c:	0000                	unimp
   11f4e:	0000                	unimp
   11f50:	0008                	addi	a0,sp,0
   11f52:	0000                	unimp
   11f54:	0000                	unimp
   11f56:	0000                	unimp
   11f58:	0018                	addi	a4,sp,0
   11f5a:	0000                	unimp
   11f5c:	0000                	unimp
   11f5e:	0000                	unimp
   11f60:	0009                	c.addi	zero,2
   11f62:	0000                	unimp
   11f64:	0000                	unimp
   11f66:	0000                	unimp
   11f68:	0018                	addi	a4,sp,0
   11f6a:	0000                	unimp
   11f6c:	0000                	unimp
   11f6e:	0000                	unimp
   11f70:	fffe                	sd	t6,504(sp)
   11f72:	6fff                	0x6fff
   11f74:	0000                	unimp
   11f76:	0000                	unimp
   11f78:	02c0                	addi	s0,sp,324
   11f7a:	0001                	nop
   11f7c:	0000                	unimp
   11f7e:	0000                	unimp
   11f80:	ffff                	0xffff
   11f82:	6fff                	0x6fff
   11f84:	0000                	unimp
   11f86:	0000                	unimp
   11f88:	0001                	nop
   11f8a:	0000                	unimp
   11f8c:	0000                	unimp
   11f8e:	0000                	unimp
   11f90:	fff0                	sd	a2,248(a5)
   11f92:	6fff                	0x6fff
   11f94:	0000                	unimp
   11f96:	0000                	unimp
   11f98:	02b8                	addi	a4,sp,328
   11f9a:	0001                	nop
	...

Disassembly of section .got:

0000000000012000 <__TMC_END__>:
   12000:	ffff                	0xffff
   12002:	ffff                	0xffff
   12004:	ffff                	0xffff
   12006:	ffff                	0xffff
	...
   12010:	0300                	addi	s0,sp,384
   12012:	0001                	nop
   12014:	0000                	unimp
	...

0000000000012018 <_GLOBAL_OFFSET_TABLE_>:
   12018:	1e30                	addi	a2,sp,824
   1201a:	0001                	nop
   1201c:	0000                	unimp
	...

Disassembly of section .sdata:

0000000000012020 <_IO_stdin_used>:
   12020:	0001                	nop
   12022:	0002                	0x2
   12024:	0000                	unimp
	...

0000000000012028 <__dso_handle>:
	...

Disassembly of section .bss:

0000000000012030 <__bss_start>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3720                	fld	fs0,104(a4)
   c:	312e                	fld	ft2,232(sp)
   e:	312e                	fld	ft2,232(sp)
  10:	3220                	fld	fs0,96(a2)
  12:	3130                	fld	fa2,96(a0)
  14:	30353037          	lui	zero,0x30353
  18:	0039                	c.addi	zero,14

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	002c                	addi	a1,sp,8
   2:	0000                	unimp
   4:	0002                	0x2
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0008                	addi	a0,sp,0
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0330                	addi	a2,sp,392
  12:	0001                	nop
  14:	0000                	unimp
  16:	0000                	unimp
  18:	003a                	0x3a
	...
  2e:	0000                	unimp
  30:	001c                	addi	a5,sp,0
  32:	0000                	unimp
  34:	0002                	0x2
  36:	002e                	0x2e
  38:	0000                	unimp
  3a:	0008                	addi	a0,sp,0
	...
  50:	002c                	addi	a1,sp,8
  52:	0000                	unimp
  54:	0002                	0x2
  56:	00a5                	addi	ra,ra,9
  58:	0000                	unimp
  5a:	0008                	addi	a0,sp,0
  5c:	0000                	unimp
  5e:	0000                	unimp
  60:	04ea                	slli	s1,s1,0x1a
  62:	0001                	nop
  64:	0000                	unimp
  66:	0000                	unimp
  68:	005a                	0x5a
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	002a                	0x2a
   2:	0000                	unimp
   4:	0002                	0x2
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0108                	addi	a0,sp,128
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0330                	addi	a2,sp,392
  12:	0001                	nop
  14:	0000                	unimp
  16:	0000                	unimp
  18:	036a                	slli	t1,t1,0x1a
  1a:	0001                	nop
	...
  24:	0019                	c.addi	zero,6
  26:	0000                	unimp
  28:	00000063          	beqz	zero,28 <_PROCEDURE_LINKAGE_TABLE_-0x102d8>
  2c:	8001                	srli	s0,s0,0x0
  2e:	00000073          	ecall
  32:	0004                	addi	s1,sp,0
  34:	0014                	addi	a3,sp,0
  36:	0000                	unimp
  38:	0108                	addi	a0,sp,128
  3a:	00000083          	lb	ra,0(zero) # 30353000 <__global_pointer$+0x303407e0>
  3e:	e20c                	sd	a1,0(a2)
  40:	0001                	nop
  42:	1900                	addi	s0,sp,176
  44:	0000                	unimp
  46:	8f00                	0x8f00
  48:	0000                	unimp
  4a:	0200                	addi	s0,sp,256
  4c:	0801                	addi	a6,a6,0
  4e:	0154                	addi	a3,sp,132
  50:	0000                	unimp
  52:	0202                	slli	tp,tp,0x0
  54:	00012807          	flw	fa6,0(sp)
  58:	0200                	addi	s0,sp,256
  5a:	0704                	addi	s1,sp,896
  5c:	0076                	0x76
  5e:	0000                	unimp
  60:	0802                	slli	a6,a6,0x0
  62:	00007107          	0x7107
  66:	0200                	addi	s0,sp,256
  68:	0601                	addi	a2,a2,0
  6a:	0156                	slli	sp,sp,0x15
  6c:	0000                	unimp
  6e:	0202                	slli	tp,tp,0x0
  70:	3b05                	addiw	s6,s6,-31
  72:	0001                	nop
  74:	0300                	addi	s0,sp,384
  76:	0504                	addi	s1,sp,640
  78:	6e69                	lui	t3,0x1a
  7a:	0074                	addi	a3,sp,12
  7c:	4704                	lw	s1,8(a4)
  7e:	0000                	unimp
  80:	0200                	addi	s0,sp,256
  82:	0508                	addi	a0,sp,640
  84:	00000167          	jalr	sp,zero
  88:	0102                	slli	sp,sp,0x0
  8a:	5d08                	lw	a0,56(a0)
  8c:	0001                	nop
  8e:	0500                	addi	s0,sp,640
  90:	0145                	addi	sp,sp,17
  92:	0000                	unimp
  94:	1801                	addi	a6,a6,-32
  96:	004e                	0x4e
  98:	0000                	unimp
  9a:	0309                	addi	t1,t1,2
  9c:	2020                	fld	fs0,64(s0)
  9e:	0001                	nop
  a0:	0000                	unimp
  a2:	0000                	unimp
  a4:	9400                	0x9400
  a6:	0001                	nop
  a8:	0400                	addi	s0,sp,512
  aa:	5200                	lw	s0,32(a2)
  ac:	0000                	unimp
  ae:	0800                	addi	s0,sp,16
  b0:	fa01                	bnez	a2,ffffffffffffffc0 <__global_pointer$+0xfffffffffffed7a0>
  b2:	0001                	nop
  b4:	0c00                	addi	s0,sp,528
  b6:	01c8                	addi	a0,sp,196
  b8:	0000                	unimp
  ba:	0019                	c.addi	zero,6
  bc:	0000                	unimp
  be:	04ea                	slli	s1,s1,0x1a
  c0:	0001                	nop
  c2:	0000                	unimp
  c4:	0000                	unimp
  c6:	005a                	0x5a
  c8:	0000                	unimp
  ca:	0000                	unimp
  cc:	0000                	unimp
  ce:	00b6                	slli	ra,ra,0xd
  d0:	0000                	unimp
  d2:	0802                	slli	a6,a6,0x0
  d4:	6705                	lui	a4,0x1
  d6:	0001                	nop
  d8:	0300                	addi	s0,sp,384
  da:	00000183          	lb	gp,0(zero) # 0 <_PROCEDURE_LINKAGE_TABLE_-0x10300>
  de:	d802                	sw	zero,48(sp)
  e0:	0044                	addi	s1,sp,4
  e2:	0000                	unimp
  e4:	3404                	fld	fs1,40(s0)
  e6:	0000                	unimp
  e8:	0200                	addi	s0,sp,256
  ea:	0708                	addi	a0,sp,896
  ec:	0071                	c.addi	zero,28
  ee:	0000                	unimp
  f0:	0405                	addi	s0,s0,1
  f2:	6905                	lui	s2,0x1
  f4:	746e                	ld	s0,248(sp)
  f6:	0200                	addi	s0,sp,256
  f8:	0508                	addi	a0,sp,640
  fa:	0162                	slli	sp,sp,0x18
  fc:	0000                	unimp
  fe:	1002                	0x1002
 100:	c404                	sw	s1,8(s0)
 102:	0002                	0x2
 104:	0600                	addi	s0,sp,768
 106:	0000006b          	0x6b
 10a:	0000006b          	0x6b
 10e:	08080007          	0x8080007
 112:	0071                	c.addi	zero,28
 114:	0000                	unimp
 116:	8609                	srai	a2,a2,0x2
 118:	0000                	unimp
 11a:	0a00                	addi	s0,sp,272
 11c:	0000004b          	fnmsub.s	ft0,ft0,ft0,ft0,rne
 120:	860a                	mv	a2,sp
 122:	0000                	unimp
 124:	0a00                	addi	s0,sp,272
 126:	0086                	slli	ra,ra,0x1
 128:	0000                	unimp
 12a:	0800                	addi	s0,sp,16
 12c:	8c08                	0x8c08
 12e:	0000                	unimp
 130:	0800                	addi	s0,sp,16
 132:	9208                	0x9208
 134:	0000                	unimp
 136:	0200                	addi	s0,sp,256
 138:	0801                	addi	a6,a6,0
 13a:	015d                	addi	sp,sp,23
 13c:	0000                	unimp
 13e:	0001b20b          	0x1b20b
 142:	0100                	addi	s0,sp,128
 144:	6028                	ld	a0,64(s0)
 146:	0000                	unimp
 148:	0b00                	addi	s0,sp,400
 14a:	02d0                	addi	a2,sp,324
 14c:	0000                	unimp
 14e:	2a01                	sext.w	s4,s4
 150:	0060                	addi	s0,sp,12
 152:	0000                	unimp
 154:	0001700b          	0x1700b
 158:	0100                	addi	s0,sp,128
 15a:	602c                	ld	a1,64(s0)
 15c:	0000                	unimp
 15e:	0b00                	addi	s0,sp,400
 160:	02e4                	addi	s1,sp,332
 162:	0000                	unimp
 164:	2e01                	sext.w	t3,t3
 166:	0060                	addi	s0,sp,12
 168:	0000                	unimp
 16a:	d006                	sw	ra,32(sp)
 16c:	0000                	unimp
 16e:	d000                	sw	s0,32(s0)
 170:	0000                	unimp
 172:	0700                	addi	s0,sp,896
 174:	0800                	addi	s0,sp,16
 176:	d608                	sw	a0,40(a2)
 178:	0000                	unimp
 17a:	0c00                	addi	s0,sp,528
 17c:	00019f0b          	0x19f0b
 180:	0100                	addi	s0,sp,128
 182:	c530                	sw	a2,72(a0)
 184:	0000                	unimp
 186:	0b00                	addi	s0,sp,400
 188:	01e9                	addi	gp,gp,26
 18a:	0000                	unimp
 18c:	3101                	addiw	sp,sp,-32
 18e:	00c5                	addi	ra,ra,17
 190:	0000                	unimp
 192:	8a0d                	andi	a2,a2,3
 194:	0001                	nop
 196:	0100                	addi	s0,sp,128
 198:	425f 0105 0000      	0x105425f
 19e:	0000                	unimp
 1a0:	0200                	addi	s0,sp,256
 1a2:	0000                	unimp
 1a4:	0000                	unimp
 1a6:	0000                	unimp
 1a8:	0100                	addi	s0,sp,128
 1aa:	0e9c                	addi	a5,sp,848
 1ac:	000002af          	0x2af
 1b0:	4301                	li	t1,0
 1b2:	04ea                	slli	s1,s1,0x1a
 1b4:	0001                	nop
 1b6:	0000                	unimp
 1b8:	0000                	unimp
 1ba:	0058                	addi	a4,sp,4
 1bc:	0000                	unimp
 1be:	0000                	unimp
 1c0:	0000                	unimp
 1c2:	9c01                	subw	s0,s0,s0
 1c4:	0002a50f          	0x2a50f
 1c8:	0100                	addi	s0,sp,128
 1ca:	00004b43          	fmadd.s	fs6,ft0,ft0,ft0,rmm
 1ce:	0000                	unimp
 1d0:	0000                	unimp
 1d2:	0f00                	addi	s0,sp,912
 1d4:	000002bf 00864301 	0x864301000002bf
 1dc:	0000                	unimp
 1de:	0039                	c.addi	zero,14
 1e0:	0000                	unimp
 1e2:	00019a0f          	0x19a0f
 1e6:	0100                	addi	s0,sp,128
 1e8:	00008643          	fmadd.s	fa2,ft1,ft0,ft0,rne
 1ec:	8500                	0x8500
 1ee:	0000                	unimp
 1f0:	1000                	addi	s0,sp,32
 1f2:	02aa                	slli	t0,t0,0xa
 1f4:	0000                	unimp
 1f6:	5601                	li	a2,-32
 1f8:	0000003f 000000d1 	0xd10000003f
 200:	1211                	addi	tp,tp,-28
 202:	0105                	addi	sp,sp,1
 204:	0000                	unimp
 206:	0000                	unimp
 208:	1e00                	addi	s0,sp,816
 20a:	0000                	unimp
 20c:	0000                	unimp
 20e:	0000                	unimp
 210:	1200                	addi	s0,sp,288
 212:	0069                	c.addi	zero,26
 214:	5701                	li	a4,-32
 216:	0034                	addi	a3,sp,8
 218:	0000                	unimp
 21a:	00f4                	addi	a3,sp,76
 21c:	0000                	unimp
 21e:	01052a13          	slti	s4,a0,16
 222:	0000                	unimp
 224:	0000                	unimp
 226:	1400                	addi	s0,sp,544
 228:	5a01                	li	s4,-32
 22a:	8302                	jr	t1
 22c:	1400                	addi	s0,sp,544
 22e:	5b01                	li	s6,-32
 230:	8402                	jr	s0
 232:	1400                	addi	s0,sp,544
 234:	5c01                	li	s8,-32
 236:	8502                	jr	a0
 238:	0000                	unimp
 23a:	0000                	unimp
	...

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	1101                	addi	sp,sp,-32
   2:	1000                	addi	s0,sp,32
   4:	1106                	slli	sp,sp,0x21
   6:	1201                	addi	tp,tp,-32
   8:	0301                	addi	t1,t1,0
   a:	1b0e                	slli	s6,s6,0x23
   c:	250e                	fld	fa0,192(sp)
   e:	130e                	slli	t1,t1,0x23
  10:	0005                	c.addi	zero,1
  12:	0000                	unimp
  14:	1101                	addi	sp,sp,-32
  16:	2501                	sext.w	a0,a0
  18:	130e                	slli	t1,t1,0x23
  1a:	1b0e030b          	0x1b0e030b
  1e:	100e                	0x100e
  20:	02000017          	auipc	zero,0x2000
  24:	0024                	addi	s1,sp,8
  26:	0b3e0b0b          	0xb3e0b0b
  2a:	00000e03          	lb	t3,0(zero) # 2000020 <__global_pointer$+0x1fed800>
  2e:	0b002403          	lw	s0,176(zero) # b0 <_PROCEDURE_LINKAGE_TABLE_-0x10250>
  32:	030b3e0b          	0x30b3e0b
  36:	0008                	addi	a0,sp,0
  38:	0400                	addi	s0,sp,512
  3a:	0026                	0x26
  3c:	1349                	addi	t1,t1,-14
  3e:	0000                	unimp
  40:	3405                	addiw	s0,s0,-31
  42:	0300                	addi	s0,sp,384
  44:	3a0e                	fld	fs4,224(sp)
  46:	490b3b0b          	0x490b3b0b
  4a:	02193f13          	sltiu	t5,s2,33
  4e:	0018                	addi	a4,sp,0
  50:	0000                	unimp
  52:	1101                	addi	sp,sp,-32
  54:	2501                	sext.w	a0,a0
  56:	130e                	slli	t1,t1,0x23
  58:	1b0e030b          	0x1b0e030b
  5c:	110e                	slli	sp,sp,0x23
  5e:	1201                	addi	tp,tp,-32
  60:	00171007          	0x171007
  64:	0200                	addi	s0,sp,256
  66:	0024                	addi	s1,sp,8
  68:	0b3e0b0b          	0xb3e0b0b
  6c:	00000e03          	lb	t3,0(zero) # 0 <_PROCEDURE_LINKAGE_TABLE_-0x10300>
  70:	03001603          	lh	a2,48(zero) # 30 <_PROCEDURE_LINKAGE_TABLE_-0x102d0>
  74:	3a0e                	fld	fs4,224(sp)
  76:	490b3b0b          	0x490b3b0b
  7a:	04000013          	li	zero,64
  7e:	0026                	0x26
  80:	1349                	addi	t1,t1,-14
  82:	0000                	unimp
  84:	2405                	addiw	s0,s0,1
  86:	0b00                	addi	s0,sp,400
  88:	030b3e0b          	0x30b3e0b
  8c:	0008                	addi	a0,sp,0
  8e:	0600                	addi	s0,sp,768
  90:	0101                	addi	sp,sp,0
  92:	1349                	addi	t1,t1,-14
  94:	1301                	addi	t1,t1,-32
  96:	0000                	unimp
  98:	00002107          	flw	ft2,0(zero) # 0 <_PROCEDURE_LINKAGE_TABLE_-0x10300>
  9c:	0800                	addi	s0,sp,16
  9e:	0b0b000f          	0xb0b000f
  a2:	1349                	addi	t1,t1,-14
  a4:	0000                	unimp
  a6:	1509                	addi	a0,a0,-30
  a8:	2701                	sext.w	a4,a4
  aa:	0119                	addi	sp,sp,6
  ac:	0a000013          	li	zero,160
  b0:	0005                	c.addi	zero,1
  b2:	1349                	addi	t1,t1,-14
  b4:	0000                	unimp
  b6:	0300340b          	0x300340b
  ba:	3a0e                	fld	fs4,224(sp)
  bc:	490b3b0b          	0x490b3b0b
  c0:	3c193f13          	sltiu	t5,s2,961
  c4:	0019                	c.addi	zero,6
  c6:	0c00                	addi	s0,sp,528
  c8:	0015                	c.addi	zero,5
  ca:	00001927          	0x1927
  ce:	2e0d                	addiw	t3,t3,3
  d0:	3f00                	fld	fs0,56(a4)
  d2:	0319                	addi	t1,t1,6
  d4:	3a0e                	fld	fs4,224(sp)
  d6:	270b3b0b          	0x270b3b0b
  da:	1119                	addi	sp,sp,-26
  dc:	1201                	addi	tp,tp,-32
  de:	97184007          	flq	ft0,-1679(a6)
  e2:	1942                	slli	s2,s2,0x30
  e4:	0000                	unimp
  e6:	2e0e                	fld	ft8,192(sp)
  e8:	3f01                	addiw	t5,t5,-32
  ea:	0319                	addi	t1,t1,6
  ec:	3a0e                	fld	fs4,224(sp)
  ee:	270b3b0b          	0x270b3b0b
  f2:	1119                	addi	sp,sp,-26
  f4:	1201                	addi	tp,tp,-32
  f6:	97184007          	flq	ft0,-1679(a6)
  fa:	1942                	slli	s2,s2,0x30
  fc:	0000                	unimp
  fe:	0300050f          	0x300050f
 102:	3a0e                	fld	fs4,224(sp)
 104:	490b3b0b          	0x490b3b0b
 108:	00170213          	addi	tp,a4,1 # 1001 <_PROCEDURE_LINKAGE_TABLE_-0xf2ff>
 10c:	1000                	addi	s0,sp,32
 10e:	0034                	addi	a3,sp,8
 110:	0b3a0e03          	lb	t3,179(s4) # fffffffffffe00b3 <__global_pointer$+0xfffffffffffcd893>
 114:	13490b3b          	0x13490b3b
 118:	1702                	slli	a4,a4,0x20
 11a:	0000                	unimp
 11c:	0b11                	addi	s6,s6,4
 11e:	1101                	addi	sp,sp,-32
 120:	1201                	addi	tp,tp,-32
 122:	12000007          	0x12000007
 126:	0034                	addi	a3,sp,8
 128:	0b3a0803          	lb	a6,179(s4)
 12c:	13490b3b          	0x13490b3b
 130:	1702                	slli	a4,a4,0x20
 132:	0000                	unimp
 134:	01828913          	addi	s2,t0,24
 138:	1101                	addi	sp,sp,-32
 13a:	0001                	nop
 13c:	1400                	addi	s0,sp,544
 13e:	828a                	mv	t0,sp
 140:	0001                	nop
 142:	1802                	slli	a6,a6,0x20
 144:	4291                	li	t0,4
 146:	0018                	addi	a4,sp,0
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	0000008b          	0x8b
   4:	0002                	0x2
   6:	0000002f          	0x2f
   a:	0101                	addi	sp,sp,0
   c:	000d0efb          	esb	zero,29(s10)
  10:	0101                	addi	sp,sp,0
  12:	0101                	addi	sp,sp,0
  14:	0000                	unimp
  16:	0100                	addi	s0,sp,128
  18:	0000                	unimp
  1a:	2e01                	sext.w	t3,t3
  1c:	2f2e                	fld	ft10,200(sp)
  1e:	64737973          	csrrci	s2,0x647,6
  22:	7065                	0x7065
  24:	69722f73          	csrrs	t5,0x697,tp
  28:	00766373          	csrrsi	t1,0x7,12
  2c:	7300                	ld	s0,32(a4)
  2e:	6174                	ld	a3,192(a0)
  30:	7472                	ld	s0,312(sp)
  32:	532e                	lw	t1,232(sp)
  34:	0100                	addi	s0,sp,128
  36:	0000                	unimp
  38:	0000                	unimp
  3a:	0209                	addi	tp,tp,2
  3c:	0330                	addi	a2,sp,392
  3e:	0001                	nop
  40:	0000                	unimp
  42:	0000                	unimp
  44:	03012f03          	lw	t5,48(sp)
  48:	0901                	addi	s2,s2,0
  4a:	0004                	addi	s1,sp,0
  4c:	0301                	addi	t1,t1,0
  4e:	0901                	addi	s2,s2,0
  50:	0002                	0x2
  52:	0301                	addi	t1,t1,0
  54:	0901                	addi	s2,s2,0
  56:	0008                	addi	a0,sp,0
  58:	0301                	addi	t1,t1,0
  5a:	0901                	addi	s2,s2,0
  5c:	0002                	0x2
  5e:	0301                	addi	t1,t1,0
  60:	0901                	addi	s2,s2,0
  62:	0002                	0x2
  64:	0301                	addi	t1,t1,0
  66:	0901                	addi	s2,s2,0
  68:	0004                	addi	s1,sp,0
  6a:	0301                	addi	t1,t1,0
  6c:	0901                	addi	s2,s2,0
  6e:	0008                	addi	a0,sp,0
  70:	0301                	addi	t1,t1,0
  72:	0901                	addi	s2,s2,0
  74:	0008                	addi	a0,sp,0
  76:	0301                	addi	t1,t1,0
  78:	0902                	slli	s2,s2,0x0
  7a:	0002                	0x2
  7c:	0301                	addi	t1,t1,0
  7e:	090c                	addi	a1,sp,144
  80:	0008                	addi	a0,sp,0
  82:	0301                	addi	t1,t1,0
  84:	0902                	slli	s2,s2,0x0
  86:	0008                	addi	a0,sp,0
  88:	0901                	addi	s2,s2,0
  8a:	0002                	0x2
  8c:	0100                	addi	s0,sp,128
  8e:	2301                	sext.w	t1,t1
  90:	0000                	unimp
  92:	0200                	addi	s0,sp,256
  94:	1d00                	addi	s0,sp,688
  96:	0000                	unimp
  98:	0100                	addi	s0,sp,128
  9a:	fb01                	bnez	a4,ffffffffffffffaa <__global_pointer$+0xfffffffffffed78a>
  9c:	0d0e                	slli	s10,s10,0x3
  9e:	0100                	addi	s0,sp,128
  a0:	0101                	addi	sp,sp,0
  a2:	0001                	nop
  a4:	0000                	unimp
  a6:	0001                	nop
  a8:	0100                	addi	s0,sp,128
  aa:	6900                	ld	s0,16(a0)
  ac:	696e                	ld	s2,216(sp)
  ae:	2e74                	fld	fa3,216(a2)
  b0:	00000063          	beqz	zero,b0 <_PROCEDURE_LINKAGE_TABLE_-0x10250>
  b4:	0000                	unimp
  b6:	000000f7          	elb	ra,0(zero) # 0 <_PROCEDURE_LINKAGE_TABLE_-0x10300>
  ba:	0002                	0x2
  bc:	008a                	slli	ra,ra,0x2
  be:	0000                	unimp
  c0:	0101                	addi	sp,sp,0
  c2:	000d0efb          	esb	zero,29(s10)
  c6:	0101                	addi	sp,sp,0
  c8:	0101                	addi	sp,sp,0
  ca:	0000                	unimp
  cc:	0100                	addi	s0,sp,128
  ce:	0000                	unimp
  d0:	2e01                	sext.w	t3,t3
  d2:	2f2e                	fld	ft10,200(sp)
  d4:	00757363          	bleu	t2,a0,da <_PROCEDURE_LINKAGE_TABLE_-0x10226>
  d8:	6d6f682f          	0x6d6f682f
  dc:	2f65                	addiw	t5,t5,25
  de:	696c                	ld	a1,208(a0)
  e0:	3932                	fld	fs2,296(sp)
  e2:	2f393237          	lui	tp,0x2f393
  e6:	6f6c                	ld	a1,216(a4)
  e8:	2f6c6163          	bltu	s8,s6,3ca <_PROCEDURE_LINKAGE_TABLE_-0xff36>
  ec:	6278                	ld	a4,192(a2)
  ee:	2d736167          	0x2d736167
  f2:	6972                	ld	s2,280(sp)
  f4:	2d766373          	csrrsi	t1,0x2d7,12
  f8:	696c                	ld	a1,208(a0)
  fa:	756e                	ld	a0,248(sp)
  fc:	2f78                	fld	fa4,216(a4)
  fe:	696c                	ld	a1,208(a0)
 100:	2f62                	fld	ft10,24(sp)
 102:	2f636367          	0x2f636367
 106:	6972                	ld	s2,280(sp)
 108:	36766373          	csrrsi	t1,0x367,12
 10c:	2d34                	fld	fa3,88(a0)
 10e:	6e75                	lui	t3,0x1d
 110:	776f6e6b          	0x776f6e6b
 114:	2d6e                	fld	fs10,216(sp)
 116:	696c                	ld	a1,208(a0)
 118:	756e                	ld	a0,248(sp)
 11a:	2d78                	fld	fa4,216(a0)
 11c:	2f756e67          	0x2f756e67
 120:	2e312e37          	lui	t3,0x2e312
 124:	2f31                	addiw	t5,t5,12
 126:	6e69                	lui	t3,0x1a
 128:	64756c63          	bltu	a0,t2,780 <_PROCEDURE_LINKAGE_TABLE_-0xfb80>
 12c:	0065                	c.addi	zero,25
 12e:	6500                	ld	s0,8(a0)
 130:	666c                	ld	a1,200(a2)
 132:	692d                	lui	s2,0xb
 134:	696e                	ld	s2,216(sp)
 136:	2e74                	fld	fa3,216(a2)
 138:	00010063          	beqz	sp,138 <_PROCEDURE_LINKAGE_TABLE_-0x101c8>
 13c:	7300                	ld	s0,32(a4)
 13e:	6474                	ld	a3,200(s0)
 140:	6564                	ld	s1,200(a0)
 142:	2e66                	fld	ft8,88(sp)
 144:	0068                	addi	a0,sp,12
 146:	0002                	0x2
 148:	0000                	unimp
 14a:	0900                	addi	s0,sp,144
 14c:	ea02                	sd	zero,272(sp)
 14e:	0104                	addi	s1,sp,128
 150:	0000                	unimp
 152:	0000                	unimp
 154:	0300                	addi	s0,sp,384
 156:	030100c3          	fmadd.d	ft1,ft2,fa6,ft0,rne
 15a:	0912                	slli	s2,s2,0x4
 15c:	0006                	0x6
 15e:	0301                	addi	t1,t1,0
 160:	096e                	slli	s2,s2,0x1b
 162:	0014                	addi	a3,sp,0
 164:	0301                	addi	t1,t1,0
 166:	0912                	slli	s2,s2,0x4
 168:	000a                	0xa
 16a:	0301                	addi	t1,t1,0
 16c:	0901                	addi	s2,s2,0
 16e:	0004                	addi	s1,sp,0
 170:	0001                	nop
 172:	0402                	slli	s0,s0,0x0
 174:	09010303          	lb	t1,144(sp)
 178:	000c                	addi	a1,sp,0
 17a:	0001                	nop
 17c:	0402                	slli	s0,s0,0x0
 17e:	097f0303          	lb	t1,151(t5)
 182:	0008                	addi	a0,sp,0
 184:	0001                	nop
 186:	0402                	slli	s0,s0,0x0
 188:	09010303          	lb	t1,144(sp)
 18c:	0002                	0x2
 18e:	0001                	nop
 190:	0402                	slli	s0,s0,0x0
 192:	097f0303          	lb	t1,151(t5)
 196:	0004                	addi	s1,sp,0
 198:	0301                	addi	t1,t1,0
 19a:	0902                	slli	s2,s2,0x0
 19c:	0004                	addi	s1,sp,0
 19e:	0301                	addi	t1,t1,0
 1a0:	00120907          	0x120907
 1a4:	0301                	addi	t1,t1,0
 1a6:	090a                	slli	s2,s2,0x2
 1a8:	0000                	unimp
 1aa:	0901                	addi	s2,s2,0
 1ac:	0002                	0x2
 1ae:	0100                	addi	s0,sp,128
 1b0:	01              	Address 0x00000000000001b0 is out of bounds.


Disassembly of section .debug_frame:

0000000000000000 <.debug_frame>:
   0:	000c                	addi	a1,sp,0
   2:	0000                	unimp
   4:	ffff                	0xffff
   6:	ffff                	0xffff
   8:	0001                	nop
   a:	7c01                	lui	s8,0xfffe0
   c:	0d01                	addi	s10,s10,0
   e:	0002                	0x2
  10:	003c                	addi	a5,sp,8
  12:	0000                	unimp
  14:	0000                	unimp
  16:	0000                	unimp
  18:	04ea                	slli	s1,s1,0x1a
  1a:	0001                	nop
  1c:	0000                	unimp
  1e:	0000                	unimp
  20:	0058                	addi	a4,sp,4
  22:	0000                	unimp
  24:	0000                	unimp
  26:	0000                	unimp
  28:	0e42                	slli	t3,t3,0x10
  2a:	4440                	lw	s0,12(s0)
  2c:	0488                	addi	a0,sp,576
  2e:	0892                	slli	a7,a7,0x4
  30:	815e                	mv	sp,s7
  32:	8902                	jr	s2
  34:	9306                	add	t1,t1,ra
  36:	940a                	add	s0,s0,sp
  38:	950c                	0x950c
  3a:	640e                	ld	s0,192(sp)
  3c:	42c1                	li	t0,16
  3e:	42c8                	lw	a0,4(a3)
  40:	42c9                	li	t0,18
  42:	42d2                	lw	t0,20(sp)
  44:	42d442d3          	0x42d442d3
  48:	42d5                	li	t0,21
  4a:	000e                	0xe
  4c:	0000                	unimp
  4e:	0000                	unimp
  50:	0014                	addi	a3,sp,0
  52:	0000                	unimp
  54:	0000                	unimp
  56:	0000                	unimp
  58:	0542                	slli	a0,a0,0x10
  5a:	0001                	nop
  5c:	0000                	unimp
  5e:	0000                	unimp
  60:	0002                	0x2
  62:	0000                	unimp
  64:	0000                	unimp
	...

Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	2e2e                	fld	ft8,200(sp)
   2:	7379732f          	0x7379732f
   6:	6564                	ld	s1,200(a0)
   8:	7370                	ld	a2,224(a4)
   a:	7369722f          	0x7369722f
   e:	732f7663          	bleu	s2,t5,73a <_PROCEDURE_LINKAGE_TABLE_-0xfbc6>
  12:	6174                	ld	a3,192(a0)
  14:	7472                	ld	s0,312(sp)
  16:	532e                	lw	t1,232(sp)
  18:	2f00                	fld	fs0,24(a4)
  1a:	6f68                	ld	a0,216(a4)
  1c:	656d                	lui	a0,0x1b
  1e:	32696c2f          	0x32696c2f
  22:	3739                	addiw	a4,a4,-18
  24:	3932                	fld	fs2,296(sp)
  26:	7263732f          	0x7263732f
  2a:	7461                	lui	s0,0xffff8
  2c:	732f6863          	bltu	t5,s2,75c <_PROCEDURE_LINKAGE_TABLE_-0xfba4>
  30:	6372                	ld	t1,280(sp)
  32:	6762782f          	0x6762782f
  36:	7361                	lui	t1,0xffff8
  38:	742d                	lui	s0,0xfffeb
  3a:	736c6f6f          	jal	t5,c6770 <__global_pointer$+0xb3f50>
  3e:	7369722f          	0x7369722f
  42:	672d7663          	bleu	s2,s10,6ae <_PROCEDURE_LINKAGE_TABLE_-0xfc52>
  46:	756e                	ld	a0,248(sp)
  48:	742d                	lui	s0,0xfffeb
  4a:	636c6f6f          	jal	t5,c6680 <__global_pointer$+0xb3e60>
  4e:	6168                	ld	a0,192(a0)
  50:	6e69                	lui	t3,0x1a
  52:	7369722f          	0x7369722f
  56:	672d7663          	bleu	s2,s10,6c2 <_PROCEDURE_LINKAGE_TABLE_-0xfc3e>
  5a:	696c                	ld	a1,208(a0)
  5c:	6362                	ld	t1,24(sp)
  5e:	7573632f          	0x7573632f
  62:	4700                	lw	s0,8(a4)
  64:	554e                	lw	a0,240(sp)
  66:	4120                	lw	s0,64(a0)
  68:	2e322053          	0x2e322053
  6c:	3932                	fld	fs2,296(sp)
  6e:	302e                	fld	ft0,232(sp)
  70:	6c00                	ld	s0,24(s0)
  72:	20676e6f          	jal	t3,76278 <__global_pointer$+0x63a58>
  76:	6e75                	lui	t3,0x1d
  78:	6e676973          	csrrsi	s2,0x6e6,14
  7c:	6465                	lui	s0,0x19
  7e:	6920                	ld	s0,80(a0)
  80:	746e                	ld	s0,248(sp)
  82:	4700                	lw	s0,8(a4)
  84:	554e                	lw	a0,240(sp)
  86:	4320                	lw	s0,64(a4)
  88:	3131                	addiw	sp,sp,-20
  8a:	3720                	fld	fs0,104(a4)
  8c:	312e                	fld	ft2,232(sp)
  8e:	312e                	fld	ft2,232(sp)
  90:	3220                	fld	fs0,96(a2)
  92:	3130                	fld	fa2,96(a0)
  94:	30353037          	lui	zero,0x30353
  98:	2039                	0x2039
  9a:	6d2d                	lui	s10,0xb
  9c:	646f6d63          	bltu	t5,t1,6f6 <_PROCEDURE_LINKAGE_TABLE_-0xfc0a>
  a0:	6c65                	lui	s8,0x19
  a2:	6d3d                	lui	s10,0xf
  a4:	6465                	lui	s0,0x19
  a6:	6f6c                	ld	a1,216(a4)
  a8:	6d2d2077          	elw	zero,1746(s10) # f6d2 <_PROCEDURE_LINKAGE_TABLE_-0xc2e>
  ac:	7261                	lui	tp,0xffff8
  ae:	723d6863          	bltu	s10,gp,7de <_PROCEDURE_LINKAGE_TABLE_-0xfb22>
  b2:	3676                	fld	fa2,376(sp)
  b4:	6934                	ld	a3,80(a0)
  b6:	616d                	addi	sp,sp,240
  b8:	6466                	ld	s0,88(sp)
  ba:	6d2d2063          	0x6d2d2063
  be:	6261                	lui	tp,0x18
  c0:	3d69                	addiw	s10,s10,-6
  c2:	706c                	ld	a1,224(s0)
  c4:	3436                	fld	fs0,360(sp)
  c6:	2064                	fld	fs1,192(s0)
  c8:	672d                	lui	a4,0xb
  ca:	2d20                	fld	fs0,88(a0)
  cc:	2d20324f          	0x2d20324f
  d0:	3d647473          	csrrci	s0,0x3d6,8
  d4:	31756e67          	0x31756e67
  d8:	2031                	0x2031
  da:	662d                	lui	a2,0xb
  dc:	38756e67          	0x38756e67
  e0:	2d39                	addiw	s10,s10,14
  e2:	6e69                	lui	t3,0x1a
  e4:	696c                	ld	a1,208(a0)
  e6:	656e                	ld	a0,216(sp)
  e8:	2d20                	fld	fs0,88(a0)
  ea:	6d66                	ld	s10,88(sp)
  ec:	7265                	lui	tp,0xffff9
  ee:	612d6567          	0x612d6567
  f2:	6c6c                	ld	a1,216(s0)
  f4:	632d                	lui	t1,0xb
  f6:	74736e6f          	jal	t3,3703c <__global_pointer$+0x2481c>
  fa:	6e61                	lui	t3,0x18
  fc:	7374                	ld	a3,224(a4)
  fe:	2d20                	fld	fs0,88(a0)
 100:	7266                	ld	tp,120(sp)
 102:	646e756f          	jal	a0,e7748 <__global_pointer$+0xd4f28>
 106:	6e69                	lui	t3,0x1a
 108:	616d2d67          	0x616d2d67
 10c:	6874                	ld	a3,208(s0)
 10e:	2d20                	fld	fs0,88(a0)
 110:	7466                	ld	s0,120(sp)
 112:	736c                	ld	a1,224(a4)
 114:	6d2d                	lui	s10,0xb
 116:	6c65646f          	jal	s0,567dc <__global_pointer$+0x43fbc>
 11a:	693d                	lui	s2,0xf
 11c:	696e                	ld	s2,216(sp)
 11e:	6974                	ld	a3,208(a0)
 120:	6c61                	lui	s8,0x18
 122:	652d                	lui	a0,0xb
 124:	6578                	ld	a4,200(a0)
 126:	68730063          	beq	t1,t2,7a6 <_PROCEDURE_LINKAGE_TABLE_-0xfb5a>
 12a:	2074726f          	jal	tp,47b30 <__global_pointer$+0x35310>
 12e:	6e75                	lui	t3,0x1d
 130:	6e676973          	csrrsi	s2,0x6e6,14
 134:	6465                	lui	s0,0x19
 136:	6920                	ld	s0,80(a0)
 138:	746e                	ld	s0,248(sp)
 13a:	7300                	ld	s0,32(a4)
 13c:	6f68                	ld	a0,216(a4)
 13e:	7472                	ld	s0,312(sp)
 140:	6920                	ld	s0,80(a0)
 142:	746e                	ld	s0,248(sp)
 144:	5f00                	lw	s0,56(a4)
 146:	4f49                	li	t5,18
 148:	735f 6474 6e69      	0x6e696474735f
 14e:	755f 6573 0064      	0x646573755f
 154:	6e75                	lui	t3,0x1d
 156:	6e676973          	csrrsi	s2,0x6e6,14
 15a:	6465                	lui	s0,0x19
 15c:	6320                	ld	s0,64(a4)
 15e:	6168                	ld	a0,192(a0)
 160:	0072                	0x72
 162:	6f6c                	ld	a1,216(a4)
 164:	676e                	ld	a4,216(sp)
 166:	6c20                	ld	s0,88(s0)
 168:	20676e6f          	jal	t3,7636e <__global_pointer$+0x63b4e>
 16c:	6e69                	lui	t3,0x1a
 16e:	0074                	addi	a3,sp,12
 170:	5f5f 6e69 7469      	0x74696e695f5f
 176:	615f 7272 7961      	0x79617272615f
 17c:	735f 6174 7472      	0x74726174735f
 182:	7300                	ld	s0,32(a4)
 184:	7a69                	lui	s4,0xffffa
 186:	5f65                	li	t5,-7
 188:	0074                	addi	a3,sp,12
 18a:	5f5f 696c 6362      	0x6362696c5f5f
 190:	635f 7573 665f      	0x665f7573635f
 196:	6e69                	lui	t3,0x1a
 198:	0069                	c.addi	zero,26
 19a:	6e65                	lui	t3,0x19
 19c:	7076                	0x7076
 19e:	5f00                	lw	s0,56(a4)
 1a0:	665f 6e69 5f69      	0x5f696e69665f
 1a6:	7261                	lui	tp,0xffff8
 1a8:	6172                	ld	sp,280(sp)
 1aa:	5f79                	li	t5,-2
 1ac:	72617473          	csrrci	s0,0x726,2
 1b0:	0074                	addi	a3,sp,12
 1b2:	5f5f 7270 6965      	0x696572705f5f
 1b8:	696e                	ld	s2,216(sp)
 1ba:	5f74                	lw	a3,124(a4)
 1bc:	7261                	lui	tp,0xffff8
 1be:	6172                	ld	sp,280(sp)
 1c0:	5f79                	li	t5,-2
 1c2:	72617473          	csrrci	s0,0x726,2
 1c6:	0074                	addi	a3,sp,12
 1c8:	2e2e                	fld	ft8,200(sp)
 1ca:	7379732f          	0x7379732f
 1ce:	6564                	ld	s1,200(a0)
 1d0:	7370                	ld	a2,224(a4)
 1d2:	696e692f          	0x696e692f
 1d6:	5f74                	lw	a3,124(a4)
 1d8:	7261                	lui	tp,0xffff8
 1da:	6172                	ld	sp,280(sp)
 1dc:	2f79                	addiw	t5,t5,30
 1de:	6c65                	lui	s8,0x19
 1e0:	2d66                	fld	fs10,88(sp)
 1e2:	6e69                	lui	t3,0x1a
 1e4:	7469                	lui	s0,0xffffa
 1e6:	632e                	ld	t1,200(sp)
 1e8:	5f00                	lw	s0,56(a4)
 1ea:	665f 6e69 5f69      	0x5f696e69665f
 1f0:	7261                	lui	tp,0xffff8
 1f2:	6172                	ld	sp,280(sp)
 1f4:	5f79                	li	t5,-2
 1f6:	6e65                	lui	t3,0x19
 1f8:	0064                	addi	s1,sp,12
 1fa:	20554e47          	fmsub.s	ft8,fa0,ft5,ft4,rmm
 1fe:	20313143          	fmadd.s	ft2,ft2,ft3,ft4,rup
 202:	2e312e37          	lui	t3,0x2e312
 206:	2031                	0x2031
 208:	3032                	fld	ft0,296(sp)
 20a:	3731                	addiw	a4,a4,-20
 20c:	3530                	fld	fa2,104(a0)
 20e:	3930                	fld	fa2,112(a0)
 210:	2d20                	fld	fs0,88(a0)
 212:	636d                	lui	t1,0x1b
 214:	6f6d                	lui	t5,0x1b
 216:	6564                	ld	s1,200(a0)
 218:	3d6c                	fld	fa1,248(a0)
 21a:	656d                	lui	a0,0x1b
 21c:	6c64                	ld	s1,216(s0)
 21e:	2d20776f          	jal	a4,74f0 <_PROCEDURE_LINKAGE_TABLE_-0x8e10>
 222:	616d                	addi	sp,sp,240
 224:	6372                	ld	t1,280(sp)
 226:	3d68                	fld	fa0,248(a0)
 228:	7672                	ld	a2,312(sp)
 22a:	3436                	fld	fs0,360(sp)
 22c:	6d69                	lui	s10,0x1a
 22e:	6661                	lui	a2,0x18
 230:	6364                	ld	s1,192(a4)
 232:	2d20                	fld	fs0,88(a0)
 234:	616d                	addi	sp,sp,240
 236:	6962                	ld	s2,24(sp)
 238:	6c3d                	lui	s8,0xf
 23a:	3670                	fld	fa2,232(a2)
 23c:	6434                	ld	a3,72(s0)
 23e:	2d20                	fld	fs0,88(a0)
 240:	4f2d2067          	0x4f2d2067
 244:	2032                	fld	ft0,264(sp)
 246:	732d                	lui	t1,0xfffeb
 248:	6474                	ld	a3,200(s0)
 24a:	673d                	lui	a4,0xf
 24c:	756e                	ld	a0,248(sp)
 24e:	3131                	addiw	sp,sp,-20
 250:	2d20                	fld	fs0,88(a0)
 252:	6766                	ld	a4,88(sp)
 254:	756e                	ld	a0,248(sp)
 256:	3938                	fld	fa4,112(a0)
 258:	692d                	lui	s2,0xb
 25a:	6c6e                	ld	s8,216(sp)
 25c:	6e69                	lui	t3,0x1a
 25e:	2065                	0x2065
 260:	662d                	lui	a2,0xb
 262:	656d                	lui	a0,0x1b
 264:	6772                	ld	a4,280(sp)
 266:	2d65                	addiw	s10,s10,25
 268:	6c61                	lui	s8,0x18
 26a:	2d6c                	fld	fa1,216(a0)
 26c:	736e6f63          	bltu	t3,s6,9aa <_PROCEDURE_LINKAGE_TABLE_-0xf956>
 270:	6174                	ld	a3,192(a0)
 272:	746e                	ld	s0,248(sp)
 274:	662d2073          	csrs	0x662,s10
 278:	6f72                	ld	t5,280(sp)
 27a:	6e75                	lui	t3,0x1d
 27c:	6964                	ld	s1,208(a0)
 27e:	676e                	ld	a4,216(sp)
 280:	6d2d                	lui	s10,0xb
 282:	7461                	lui	s0,0xffff8
 284:	2068                	fld	fa0,192(s0)
 286:	662d                	lui	a2,0xb
 288:	4950                	lw	a2,20(a0)
 28a:	662d2043          	fmadd.q	ft0,fs10,ft2,fa2,rdn
 28e:	6c74                	ld	a3,216(s0)
 290:	6f6d2d73          	csrrs	s10,0x6f6,s10
 294:	6564                	ld	s1,200(a0)
 296:	3d6c                	fld	fa1,248(a0)
 298:	6e69                	lui	t3,0x1a
 29a:	7469                	lui	s0,0xffffa
 29c:	6169                	addi	sp,sp,208
 29e:	2d6c                	fld	fa1,216(a0)
 2a0:	7865                	lui	a6,0xffff9
 2a2:	6365                	lui	t1,0x19
 2a4:	6100                	ld	s0,0(a0)
 2a6:	6772                	ld	a4,280(sp)
 2a8:	69730063          	beq	t1,s7,928 <_PROCEDURE_LINKAGE_TABLE_-0xf9d8>
 2ac:	657a                	ld	a0,408(sp)
 2ae:	5f00                	lw	s0,56(a4)
 2b0:	6c5f 6269 5f63      	0x5f6362696c5f
 2b6:	5f757363          	bleu	s7,a0,89c <_PROCEDURE_LINKAGE_TABLE_-0xfa64>
 2ba:	6e69                	lui	t3,0x1a
 2bc:	7469                	lui	s0,0xffffa
 2be:	6100                	ld	s0,0(a0)
 2c0:	6772                	ld	a4,280(sp)
 2c2:	0076                	0x76
 2c4:	6f6c                	ld	a1,216(a4)
 2c6:	676e                	ld	a4,216(sp)
 2c8:	6420                	ld	s0,72(s0)
 2ca:	6c62756f          	jal	a0,27990 <__global_pointer$+0x15170>
 2ce:	0065                	c.addi	zero,25
 2d0:	5f5f 7270 6965      	0x696572705f5f
 2d6:	696e                	ld	s2,216(sp)
 2d8:	5f74                	lw	a3,124(a4)
 2da:	7261                	lui	tp,0xffff8
 2dc:	6172                	ld	sp,280(sp)
 2de:	5f79                	li	t5,-2
 2e0:	6e65                	lui	t3,0x19
 2e2:	0064                	addi	s1,sp,12
 2e4:	5f5f 6e69 7469      	0x74696e695f5f
 2ea:	615f 7272 7961      	0x79617272615f
 2f0:	655f 646e       	0x646e655f

Disassembly of section .debug_loc:

0000000000000000 <.debug_loc>:
	...
   8:	0034                	addi	a3,sp,8
   a:	0000                	unimp
   c:	0000                	unimp
   e:	0000                	unimp
  10:	0001                	nop
  12:	345a                	fld	fs0,432(sp)
  14:	0000                	unimp
  16:	0000                	unimp
  18:	0000                	unimp
  1a:	5800                	lw	s0,48(s0)
  1c:	0000                	unimp
  1e:	0000                	unimp
  20:	0000                	unimp
  22:	0400                	addi	s0,sp,512
  24:	f300                	sd	s0,32(a4)
  26:	5a01                	li	s4,-32
  28:	009f 0000 0000      	0x9f
	...
  3e:	0000                	unimp
  40:	3400                	fld	fs0,40(s0)
  42:	0000                	unimp
  44:	0000                	unimp
  46:	0000                	unimp
  48:	0100                	addi	s0,sp,128
  4a:	5b00                	lw	s0,48(a4)
  4c:	0034                	addi	a3,sp,8
  4e:	0000                	unimp
  50:	0000                	unimp
  52:	0000                	unimp
  54:	0046                	0x46
  56:	0000                	unimp
  58:	0000                	unimp
  5a:	0000                	unimp
  5c:	0001                	nop
  5e:	4664                	lw	s1,76(a2)
  60:	0000                	unimp
  62:	0000                	unimp
  64:	0000                	unimp
  66:	5800                	lw	s0,48(s0)
  68:	0000                	unimp
  6a:	0000                	unimp
  6c:	0000                	unimp
  6e:	0400                	addi	s0,sp,512
  70:	f300                	sd	s0,32(a4)
  72:	5b01                	li	s6,-32
  74:	009f 0000 0000      	0x9f
	...
  8a:	0000                	unimp
  8c:	3400                	fld	fs0,40(s0)
  8e:	0000                	unimp
  90:	0000                	unimp
  92:	0000                	unimp
  94:	0100                	addi	s0,sp,128
  96:	5c00                	lw	s0,56(s0)
  98:	0034                	addi	a3,sp,8
  9a:	0000                	unimp
  9c:	0000                	unimp
  9e:	0000                	unimp
  a0:	0046                	0x46
  a2:	0000                	unimp
  a4:	0000                	unimp
  a6:	0000                	unimp
  a8:	0001                	nop
  aa:	4665                	li	a2,25
  ac:	0000                	unimp
  ae:	0000                	unimp
  b0:	0000                	unimp
  b2:	5800                	lw	s0,48(s0)
  b4:	0000                	unimp
  b6:	0000                	unimp
  b8:	0000                	unimp
  ba:	0400                	addi	s0,sp,512
  bc:	f300                	sd	s0,32(a4)
  be:	5c01                	li	s8,-32
  c0:	009f 0000 0000      	0x9f
	...
  ce:	0000                	unimp
  d0:	2800                	fld	fs0,16(s0)
  d2:	0000                	unimp
  d4:	0000                	unimp
  d6:	0000                	unimp
  d8:	4e00                	lw	s0,24(a2)
  da:	0000                	unimp
  dc:	0000                	unimp
  de:	0000                	unimp
  e0:	0100                	addi	s0,sp,128
  e2:	6200                	ld	s0,0(a2)
	...
  f4:	0028                	addi	a0,sp,8
  f6:	0000                	unimp
  f8:	0000                	unimp
  fa:	0000                	unimp
  fc:	0034                	addi	a3,sp,8
  fe:	0000                	unimp
 100:	0000                	unimp
 102:	0000                	unimp
 104:	0002                	0x2
 106:	9f30                	0x9f30
 108:	0034                	addi	a3,sp,8
 10a:	0000                	unimp
 10c:	0000                	unimp
 10e:	0000                	unimp
 110:	003e                	0x3e
 112:	0000                	unimp
 114:	0000                	unimp
 116:	0000                	unimp
 118:	0001                	nop
 11a:	3e59                	addiw	t3,t3,-10
 11c:	0000                	unimp
 11e:	0000                	unimp
 120:	0000                	unimp
 122:	4000                	lw	s0,0(s0)
 124:	0000                	unimp
 126:	0000                	unimp
 128:	0000                	unimp
 12a:	0300                	addi	s0,sp,384
 12c:	7900                	ld	s0,48(a0)
 12e:	9f7f                	0x9f7f
 130:	0040                	addi	s0,sp,4
 132:	0000                	unimp
 134:	0000                	unimp
 136:	0000                	unimp
 138:	0046                	0x46
 13a:	0000                	unimp
 13c:	0000                	unimp
 13e:	0000                	unimp
 140:	0001                	nop
 142:	0059                	c.addi	zero,22
	...
