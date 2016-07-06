org 0x8200
bits 32    ; use 32bit operations

;  JavaCG for target:x86 convention:standard 
;  JavaCG for target:x86 convention:standard 

section ".text"
align 4
global	boot2
boot2:
	push	dword ebp
	mov	dword ebp, esp
	mov	dword eax, 655360
_L3:
	cmp	dword eax, 720895
	jge	_L5
_L4:
	mov	byte [eax], 10
	lea	dword eax, [eax+1]
	jmp	dword _L3
_L5:
	call	dword halt
_L6:
	leave
	ret


align 4
halt:
	push	dword ebp
	mov	dword ebp, esp
_L8:
	jmp	dword _L8
_L10:
	leave
	ret

