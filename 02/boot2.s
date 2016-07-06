 .ident "Coins Compiler version: coins-1.4.4.2 + BackEnd-1.0"
/* JavaCG for target:x86 convention:standard */

	.section .text
	.align	4
	.global	boot2
boot2:
	pushl	%ebp
	movl	%esp,%ebp
	movl	$655360,%eax
.L3:
	cmpl	$720895,%eax
	jge	.L5
.L4:
	movb	$10,(%eax)
	leal	1(%eax),%eax
	jmp	.L3
.L5:
	call	halt
.L6:
	leave
	ret


	.align	4
halt:
	pushl	%ebp
	movl	%esp,%ebp
.L8:
	jmp	.L8
.L10:
	leave
	ret

