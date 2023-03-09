	.file	"print.c"
	.option nopic
	.section	.rodata
	.align	3
.LC0:
	.string	"Integer value is %d\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	add	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	add	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	li	a5,150
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	add	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.1.1 20170509"
