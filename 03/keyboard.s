	.section	__TEXT,__text,regular,pure_instructions
	.globl	_boot2
	.align	4, 0x90
_boot2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, -4(%ebp)
LBB1_1:
	movl	%esp, %eax
	movl	$100, (%eax)
	call	_in8
	andl	$1, %eax
	cmpl	$0, %eax
	je	LBB1_1
	movl	%esp, %eax
	movl	$96, (%eax)
	call	_in8
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	andl	$127, %eax
	movl	%eax, -12(%ebp)
	call	_register_kbd_handler
LBB1_3:
	call	_halt
	jmp	LBB1_3

	.globl	_kbd_handler
	.align	4, 0x90
_kbd_handler:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	%esp, %eax
	movl	$97, 4(%eax)
	movl	$32, (%eax)
	call	_out8
	movl	%esp, %eax
	movl	$96, (%eax)
	call	_in8
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	andl	$127, %eax
	movl	%eax, -12(%ebp)
	movl	-8(%ebp), %eax
	andl	$128, %eax
	cmpl	$0, %eax
	jne	LBB2_2
	movl	_xpos, %eax
	subl	$100, %eax
	movl	-12(%ebp), %ecx
	movl	%esp, %edx
	movl	%eax, 4(%edx)
	movl	%ecx, (%edx)
	call	_printv2
	movl	_xpos, %eax
	addl	$1, %eax
	movl	%eax, _xpos
LBB2_2:
	movl	-4(%ebp), %eax
	addl	$24, %esp
	popl	%ebp
	ret

	.globl	_register_kbd_handler
	.align	4, 0x90
_register_kbd_handler:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$32256, -8(%ebp)
	movl	$_kbd_handler, 32256
	call	_sti
	movl	%esp, %eax
	movl	$249, 4(%eax)
	movl	$33, (%eax)
	call	_out8
	movl	%esp, %eax
	movl	$255, 4(%eax)
	movl	$161, (%eax)
	call	_out8
	movl	-4(%ebp), %eax
	addl	$24, %esp
	popl	%ebp
	ret

	.globl	_print
	.align	4, 0x90
_print:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	subl	$44, %esp
	movl	20(%ebp), %eax
	movl	16(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	8(%ebp), %esi
	movl	%esi, -8(%ebp)
	movl	%edx, -12(%ebp)
	movl	%ecx, -16(%ebp)
	movl	%eax, -20(%ebp)
	movl	$655360, -40(%ebp)
	movl	-8(%ebp), %eax
	shll	$4, %eax
	leal	_bitmaps.1474(%eax), %eax
	movl	%eax, -44(%ebp)
	movl	-16(%ebp), %eax
	imull	$320, %eax, %eax
	movl	-12(%ebp), %ecx
	leal	(%eax,%ecx), %eax
	movl	-40(%ebp), %ecx
	leal	(%ecx,%eax), %eax
	movl	%eax, -40(%ebp)
	movl	$0, -32(%ebp)
	jmp	LBB4_7
LBB4_1:
	movl	$0, -36(%ebp)
	jmp	LBB4_5
LBB4_2:
	movl	-44(%ebp), %eax
	movl	-36(%ebp), %ecx
	movl	(%eax,%ecx,4), %eax
	movl	%eax, -48(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, %ecx
	movl	$128, %eax
	sarl	%cl, %eax
	movl	-48(%ebp), %edx
	andl	%edx, %eax
	cmpl	$0, %eax
	je	LBB4_4
	movl	-20(%ebp), %eax
	movl	-40(%ebp), %ecx
	movl	-36(%ebp), %edx
	movb	%al, (%ecx,%edx)
LBB4_4:
	movl	-36(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -36(%ebp)
LBB4_5:
	movl	-36(%ebp), %eax
	cmpl	$3, %eax
	jle	LBB4_2
	movl	-40(%ebp), %eax
	addl	$320, %eax
	movl	%eax, -40(%ebp)
	movl	-32(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -32(%ebp)
LBB4_7:
	movl	-32(%ebp), %eax
	cmpl	$7, %eax
	jle	LBB4_1
	movl	$0, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	addl	$44, %esp
	popl	%esi
	popl	%ebp
	ret

	.globl	_printv2
	.align	4, 0x90
_printv2:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	subl	$100, %esp
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -8(%ebp)
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	imull	$10, %eax, %eax
	addl	$50, %eax
	movl	-8(%ebp), %ecx
	movl	%esp, %edx
	movl	%eax, 8(%edx)
	movl	$1717986919, %eax
	movl	%eax, -24(%ebp)
	movl	%ecx, %eax
	movl	-24(%ebp), %esi
	movl	%edx, -28(%ebp)
	imull	%esi
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$2, %edx
	leal	(%edx,%eax), %eax
	imull	$10, %eax, %eax
	subl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	%ecx, (%eax)
	movl	$15, 12(%eax)
	movl	$130, 4(%eax)
	call	_print
	movl	-8(%ebp), %eax
	movl	$1374389535, %ecx
	movl	%eax, -32(%ebp)
	imull	%ecx
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$5, %edx
	leal	(%edx,%eax), %eax
	imull	$100, %eax, %eax
	negl	%eax
	movl	-32(%ebp), %ecx
	leal	9(%ecx,%eax), %eax
	cmpl	$19, %eax
	jb	LBB5_2
	movl	-12(%ebp), %eax
	imull	$10, %eax, %eax
	addl	$50, %eax
	movl	-8(%ebp), %ecx
	movl	%esp, %edx
	movl	%eax, 8(%edx)
	movl	$1374389535, %eax
	movl	%eax, -36(%ebp)
	movl	%ecx, %eax
	movl	-36(%ebp), %esi
	movl	%edx, -40(%ebp)
	imull	%esi
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$5, %edx
	leal	(%edx,%eax), %eax
	imull	$100, %eax, %eax
	subl	%eax, %ecx
	movl	$1717986919, %eax
	movl	%eax, -44(%ebp)
	movl	%ecx, %eax
	movl	-44(%ebp), %ecx
	imull	%ecx
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$2, %edx
	leal	(%edx,%eax), %eax
	movl	-40(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	$15, 12(%ecx)
	movl	$120, 4(%ecx)
	call	_print
LBB5_2:
	movl	-8(%ebp), %eax
	movl	$274877907, %ecx
	movl	%eax, -48(%ebp)
	imull	%ecx
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$6, %edx
	leal	(%edx,%eax), %eax
	imull	$1000, %eax, %eax
	negl	%eax
	movl	-48(%ebp), %ecx
	leal	99(%ecx,%eax), %eax
	cmpl	$199, %eax
	jb	LBB5_4
	movl	-12(%ebp), %eax
	imull	$10, %eax, %eax
	addl	$50, %eax
	movl	-8(%ebp), %ecx
	movl	%esp, %edx
	movl	%eax, 8(%edx)
	movl	$1374389535, %eax
	movl	%eax, -52(%ebp)
	movl	%ecx, %eax
	movl	-52(%ebp), %esi
	movl	%edx, -56(%ebp)
	imull	%esi
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$5, %edx
	leal	(%edx,%eax), %eax
	imull	$100, %eax, %eax
	subl	%eax, %ecx
	movl	$1717986919, %eax
	movl	%eax, -60(%ebp)
	movl	%ecx, %eax
	movl	-60(%ebp), %ecx
	imull	%ecx
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$2, %edx
	leal	(%edx,%eax), %eax
	movl	-56(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	$15, 12(%ecx)
	movl	$120, 4(%ecx)
	call	_print
LBB5_4:
	movl	-8(%ebp), %eax
	movl	$274877907, %ecx
	movl	%eax, -64(%ebp)
	imull	%ecx
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$6, %edx
	leal	(%edx,%eax), %eax
	imull	$1000, %eax, %eax
	negl	%eax
	movl	-64(%ebp), %ecx
	leal	99(%ecx,%eax), %eax
	cmpl	$199, %eax
	jb	LBB5_6
	movl	-12(%ebp), %eax
	imull	$10, %eax, %eax
	addl	$50, %eax
	movl	-8(%ebp), %ecx
	movl	%esp, %edx
	movl	%eax, 8(%edx)
	movl	$274877907, %eax
	movl	%eax, -68(%ebp)
	movl	%ecx, %eax
	movl	-68(%ebp), %esi
	movl	%edx, -72(%ebp)
	imull	%esi
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$6, %edx
	leal	(%edx,%eax), %eax
	imull	$1000, %eax, %eax
	subl	%eax, %ecx
	movl	$1374389535, %eax
	movl	%eax, -76(%ebp)
	movl	%ecx, %eax
	movl	-76(%ebp), %ecx
	imull	%ecx
	movl	%edx, %eax
	shrl	$31, %eax
	sarl	$5, %edx
	leal	(%edx,%eax), %eax
	movl	-72(%ebp), %ecx
	movl	%eax, (%ecx)
	movl	$15, 12(%ecx)
	movl	$110, 4(%ecx)
	call	_print
LBB5_6:
	movl	$0, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	$100, %esp
	popl	%esi
	popl	%ebp
	ret

	.globl	_in8
	.align	4, 0x90
_in8:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, %edx
	## InlineAsm Start
	mov $0, %eax
	in %dx,%al
	## InlineAsm End
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	addl	$16, %esp
	popl	%ebp
	ret

	.globl	_out8
	.align	4, 0x90
_out8:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -4(%ebp)
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	movl	-8(%ebp), %ecx
	movl	%eax, %edx
	movl	%ecx, %eax
	## InlineAsm Start
	out %al,%dx
	## InlineAsm End
	movl	$0, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$16, %esp
	popl	%ebp
	ret

	.globl	_sti
	.align	4, 0x90
_sti:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	## InlineAsm Start
	sti
	## InlineAsm End
	movl	$0, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	ret

	.globl	_cli
	.align	4, 0x90
_cli:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	## InlineAsm Start
	cli
	## InlineAsm End
	movl	$0, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	ret

	.globl	_halt
	.align	4, 0x90
_halt:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	## InlineAsm Start
	hlt
	## InlineAsm End
	movl	$0, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	ret

	.globl	_sti_and_halt
	.align	4, 0x90
_sti_and_halt:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	## InlineAsm Start
	sti
	hlt
	## InlineAsm End
	movl	$0, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	ret

	.section	__DATA,__data
	.globl	_xpos
	.align	2
_xpos:
	.long	100

	.align	4
_bitmaps.1474:
	.long	126
	.long	129
	.long	129
	.long	126
	.long	0
	.long	65
	.long	255
	.long	1
	.long	71
	.long	141
	.long	153
	.long	113
	.long	153
	.long	153
	.long	153
	.long	255
	.long	240
	.long	16
	.long	16
	.long	255
	.long	241
	.long	145
	.long	145
	.long	159
	.long	255
	.long	137
	.long	137
	.long	143
	.long	128
	.long	128
	.long	128
	.long	255
	.long	255
	.long	145
	.long	145
	.long	255
	.long	241
	.long	145
	.long	145
	.long	255


.subsections_via_symbols
