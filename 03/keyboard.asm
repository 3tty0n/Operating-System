org 0x8200
bits 32    ; use 32bit operations
section "__TEXT"
global	_boot2
align 4

_boot2:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 24
	mov	dword [ebp+-4], 0
LBB1_1:
	mov	dword eax, esp
	mov	dword [eax], 100
	call	dword _in8
	and	dword eax, 1
	cmp	dword eax, 0
	je	LBB1_1
	mov	dword eax, esp
	mov	dword [eax], 96
	call	dword _in8
	mov	dword [ebp+-8], eax
	mov	dword eax, [ebp+-8]
	and	dword eax, 127
	mov	dword [ebp+-12], eax
	call	dword _register_kbd_handler
LBB1_3:
	call	dword _halt
	jmp	dword LBB1_3

global	_kbd_handler
align 4

_kbd_handler:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 24
	mov	dword eax, esp
	mov	dword [eax+4], 97
	mov	dword [eax], 32
	call	dword _out8
	mov	dword eax, esp
	mov	dword [eax], 96
	call	dword _in8
	mov	dword [ebp+-8], eax
	mov	dword eax, [ebp+-8]
	and	dword eax, 127
	mov	dword [ebp+-12], eax
	mov	dword eax, [ebp+-8]
	and	dword eax, 128
	cmp	dword eax, 0
	jne	LBB2_2
	mov	dword eax, [_xpos]
	sub	dword eax, 100
	mov	dword ecx, [ebp+-12]
	mov	dword edx, esp
	mov	dword [edx+4], eax
	mov	dword [edx], ecx
	call	dword _printv2
	mov	dword eax, [_xpos]
	add	dword eax, 1
	mov	dword [_xpos], eax
LBB2_2:
	mov	dword eax, [ebp+-4]
	add	dword esp, 24
	pop	dword ebp
	ret

global	_register_kbd_handler
align 4

_register_kbd_handler:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 24
	mov	dword [ebp+-8], 32256
	mov	dword [32256], _kbd_handler
	call	dword _sti
	mov	dword eax, esp
	mov	dword [eax+4], 249
	mov	dword [eax], 33
	call	dword _out8
	mov	dword eax, esp
	mov	dword [eax+4], 255
	mov	dword [eax], 161
	call	dword _out8
	mov	dword eax, [ebp+-4]
	add	dword esp, 24
	pop	dword ebp
	ret

global	_print
align 4

_print:
	push	dword ebp
	mov	dword ebp, esp
	push	dword esi
	sub	dword esp, 44
	mov	dword eax, [ebp+20]
	mov	dword ecx, [ebp+16]
	mov	dword edx, [ebp+12]
	mov	dword esi, [ebp+8]
	mov	dword [ebp+-8], esi
	mov	dword [ebp+-12], edx
	mov	dword [ebp+-16], ecx
	mov	dword [ebp+-20], eax
	mov	dword [ebp+-40], 655360
	mov	dword eax, [ebp+-8]
	shl	dword eax, 4
	lea	dword eax, [eax+_bitmaps.1474]
	mov	dword [ebp+-44], eax
	mov	dword eax, [ebp+-16]
	imul	dword eax, eax, 320
	mov	dword ecx, [ebp+-12]
	lea	dword eax, [eax+ecx]
	mov	dword ecx, [ebp+-40]
	lea	dword eax, [ecx+eax]
	mov	dword [ebp+-40], eax
	mov	dword [ebp+-32], 0
	jmp	dword LBB4_7
LBB4_1:
	mov	dword [ebp+-36], 0
	jmp	dword LBB4_5
LBB4_2:
	mov	dword eax, [ebp+-44]
	mov	dword ecx, [ebp+-36]
	mov	dword eax, [eax+ecx*4]
	mov	dword [ebp+-48], eax
	mov	dword eax, [ebp+-32]
	mov	dword ecx, eax
	mov	dword eax, 128
	sar	dword eax, cl
	mov	dword edx, [ebp+-48]
	and	dword eax, edx
	cmp	dword eax, 0
	je	LBB4_4
	mov	dword eax, [ebp+-20]
	mov	dword ecx, [ebp+-40]
	mov	dword edx, [ebp+-36]
	mov	byte [ecx+edx], al
LBB4_4:
	mov	dword eax, [ebp+-36]
	add	dword eax, 1
	mov	dword [ebp+-36], eax
LBB4_5:
	mov	dword eax, [ebp+-36]
	cmp	dword eax, 3
	jle	LBB4_2
	mov	dword eax, [ebp+-40]
	add	dword eax, 320
	mov	dword [ebp+-40], eax
	mov	dword eax, [ebp+-32]
	add	dword eax, 1
	mov	dword [ebp+-32], eax
LBB4_7:
	mov	dword eax, [ebp+-32]
	cmp	dword eax, 7
	jle	LBB4_1
	mov	dword [ebp+-28], 0
	mov	dword eax, [ebp+-28]
	mov	dword [ebp+-24], eax
	mov	dword eax, [ebp+-24]
	add	dword esp, 44
	pop	dword esi
	pop	dword ebp
	ret

global	_printv2
align 4

_printv2:
	push	dword ebp
	mov	dword ebp, esp
	push	dword esi
	sub	dword esp, 100
	mov	dword eax, [ebp+12]
	mov	dword ecx, [ebp+8]
	mov	dword [ebp+-8], ecx
	mov	dword [ebp+-12], eax
	mov	dword eax, [ebp+-12]
	imul	dword eax, eax, 10
	add	dword eax, 50
	mov	dword ecx, [ebp+-8]
	mov	dword edx, esp
	mov	dword [edx+8], eax
	mov	dword eax, 1717986919
	mov	dword [ebp+-24], eax
	mov	dword eax, ecx
	mov	dword esi, [ebp+-24]
	mov	dword [ebp+-28], edx
	imul	dword esi
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 2
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 10
	sub	dword ecx, eax
	mov	dword eax, [ebp+-28]
	mov	dword [eax], ecx
	mov	dword [eax+12], 15
	mov	dword [eax+4], 130
	call	dword _print
	mov	dword eax, [ebp+-8]
	mov	dword ecx, 1374389535
	mov	dword [ebp+-32], eax
	imul	dword ecx
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 5
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 100
	neg	dword eax
	mov	dword ecx, [ebp+-32]
	lea	dword eax, [ecx+eax+9]
	cmp	dword eax, 19
	jb	LBB5_2
	mov	dword eax, [ebp+-12]
	imul	dword eax, eax, 10
	add	dword eax, 50
	mov	dword ecx, [ebp+-8]
	mov	dword edx, esp
	mov	dword [edx+8], eax
	mov	dword eax, 1374389535
	mov	dword [ebp+-36], eax
	mov	dword eax, ecx
	mov	dword esi, [ebp+-36]
	mov	dword [ebp+-40], edx
	imul	dword esi
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 5
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 100
	sub	dword ecx, eax
	mov	dword eax, 1717986919
	mov	dword [ebp+-44], eax
	mov	dword eax, ecx
	mov	dword ecx, [ebp+-44]
	imul	dword ecx
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 2
	lea	dword eax, [edx+eax]
	mov	dword ecx, [ebp+-40]
	mov	dword [ecx], eax
	mov	dword [ecx+12], 15
	mov	dword [ecx+4], 120
	call	dword _print
LBB5_2:
	mov	dword eax, [ebp+-8]
	mov	dword ecx, 274877907
	mov	dword [ebp+-48], eax
	imul	dword ecx
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 6
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 1000
	neg	dword eax
	mov	dword ecx, [ebp+-48]
	lea	dword eax, [ecx+eax+99]
	cmp	dword eax, 199
	jb	LBB5_4
	mov	dword eax, [ebp+-12]
	imul	dword eax, eax, 10
	add	dword eax, 50
	mov	dword ecx, [ebp+-8]
	mov	dword edx, esp
	mov	dword [edx+8], eax
	mov	dword eax, 1374389535
	mov	dword [ebp+-52], eax
	mov	dword eax, ecx
	mov	dword esi, [ebp+-52]
	mov	dword [ebp+-56], edx
	imul	dword esi
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 5
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 100
	sub	dword ecx, eax
	mov	dword eax, 1717986919
	mov	dword [ebp+-60], eax
	mov	dword eax, ecx
	mov	dword ecx, [ebp+-60]
	imul	dword ecx
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 2
	lea	dword eax, [edx+eax]
	mov	dword ecx, [ebp+-56]
	mov	dword [ecx], eax
	mov	dword [ecx+12], 15
	mov	dword [ecx+4], 120
	call	dword _print
LBB5_4:
	mov	dword eax, [ebp+-8]
	mov	dword ecx, 274877907
	mov	dword [ebp+-64], eax
	imul	dword ecx
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 6
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 1000
	neg	dword eax
	mov	dword ecx, [ebp+-64]
	lea	dword eax, [ecx+eax+99]
	cmp	dword eax, 199
	jb	LBB5_6
	mov	dword eax, [ebp+-12]
	imul	dword eax, eax, 10
	add	dword eax, 50
	mov	dword ecx, [ebp+-8]
	mov	dword edx, esp
	mov	dword [edx+8], eax
	mov	dword eax, 274877907
	mov	dword [ebp+-68], eax
	mov	dword eax, ecx
	mov	dword esi, [ebp+-68]
	mov	dword [ebp+-72], edx
	imul	dword esi
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 6
	lea	dword eax, [edx+eax]
	imul	dword eax, eax, 1000
	sub	dword ecx, eax
	mov	dword eax, 1374389535
	mov	dword [ebp+-76], eax
	mov	dword eax, ecx
	mov	dword ecx, [ebp+-76]
	imul	dword ecx
	mov	dword eax, edx
	shr	dword eax, 31
	sar	dword edx, 5
	lea	dword eax, [edx+eax]
	mov	dword ecx, [ebp+-72]
	mov	dword [ecx], eax
	mov	dword [ecx+12], 15
	mov	dword [ecx+4], 110
	call	dword _print
LBB5_6:
	mov	dword [ebp+-20], 0
	mov	dword eax, [ebp+-20]
	mov	dword [ebp+-16], eax
	mov	dword eax, [ebp+-16]
	add	dword esp, 100
	pop	dword esi
	pop	dword ebp
	ret

global	_in8
align 4

_in8:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 16
	mov	dword eax, [ebp+8]
	mov	dword [ebp+-4], eax
	mov	dword eax, [ebp+-4]
	mov	dword edx, eax
	 ; # InlineAsm Start
	mov	eax, 0
	in	al, dx
	 ; # InlineAsm End
	mov	dword [ebp+-16], eax
	mov	dword eax, [ebp+-16]
	mov	dword [ebp+-12], eax
	mov	dword eax, [ebp+-12]
	mov	dword [ebp+-8], eax
	mov	dword eax, [ebp+-8]
	add	dword esp, 16
	pop	dword ebp
	ret

global	_out8
align 4

_out8:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 16
	mov	dword eax, [ebp+12]
	mov	dword ecx, [ebp+8]
	mov	dword [ebp+-4], ecx
	mov	dword [ebp+-8], eax
	mov	dword eax, [ebp+-4]
	mov	dword ecx, [ebp+-8]
	mov	dword edx, eax
	mov	dword eax, ecx
	 ; # InlineAsm Start
	out	dx, al
	 ; # InlineAsm End
	mov	dword [ebp+-16], 0
	mov	dword eax, [ebp+-16]
	mov	dword [ebp+-12], eax
	mov	dword eax, [ebp+-12]
	add	dword esp, 16
	pop	dword ebp
	ret

global	_sti
align 4

_sti:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 8
	 ; # InlineAsm Start
	sti
	 ; # InlineAsm End
	mov	dword [ebp+-8], 0
	mov	dword eax, [ebp+-8]
	mov	dword [ebp+-4], eax
	mov	dword eax, [ebp+-4]
	add	dword esp, 8
	pop	dword ebp
	ret

global	_cli
align 4

_cli:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 8
	 ; # InlineAsm Start
	cli
	 ; # InlineAsm End
	mov	dword [ebp+-8], 0
	mov	dword eax, [ebp+-8]
	mov	dword [ebp+-4], eax
	mov	dword eax, [ebp+-4]
	add	dword esp, 8
	pop	dword ebp
	ret

global	_halt
align 4

_halt:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 8
	 ; # InlineAsm Start
	hlt
	 ; # InlineAsm End
	mov	dword [ebp+-8], 0
	mov	dword eax, [ebp+-8]
	mov	dword [ebp+-4], eax
	mov	dword eax, [ebp+-4]
	add	dword esp, 8
	pop	dword ebp
	ret

global	_sti_and_halt
align 4

_sti_and_halt:
	push	dword ebp
	mov	dword ebp, esp
	sub	dword esp, 8
	 ; # InlineAsm Start
	sti
	hlt
	 ; # InlineAsm End
	mov	dword [ebp+-8], 0
	mov	dword eax, [ebp+-8]
	mov	dword [ebp+-4], eax
	mov	dword eax, [ebp+-4]
	add	dword esp, 8
	pop	dword ebp
	ret

section "__DATA"
global	_xpos
align 2
_xpos:
 dd 100

align 4
_bitmaps.1474:
 dd 126
 dd 129
 dd 129
 dd 126
 dd 0
 dd 65
 dd 255
 dd 1
 dd 71
 dd 141
 dd 153
 dd 113
 dd 153
 dd 153
 dd 153
 dd 255
 dd 240
 dd 16
 dd 16
 dd 255
 dd 241
 dd 145
 dd 145
 dd 159
 dd 255
 dd 137
 dd 137
 dd 143
 dd 128
 dd 128
 dd 128
 dd 255
 dd 255
 dd 145
 dd 145
 dd 255
 dd 241
 dd 145
 dd 145
 dd 255


.subsections_via_symbols
