section .text

extern printf
global main

main:
	mov eax, 1024 ; some number

	; eax = number
	; ebx = exit code
	; ecx = number - 1
	mov ebx, 1 ; initialize exit code with 1 (is power of 2)
	mov ecx, eax
	sub ecx, 1 ; initialize ecx with eax-1

	; A little bit of magic is done here ;)
	; If eax == 0, eax & [bitwise and] (eax-1) is zero, the result will be zero. So far, so 
	; easy. If eax > 0 but has more than one bit set, -1 will only affect the last bit. Therefore
	; eax & ecx will result in a non-zero value (higher bits are unaffected) and the jz will
	; not fire, so the exit code stays one. If only one bit is set however, -1 will affect all 
	; bits making the bitwise and result falsy and therefore skips settings ebx to 0 (not power of). 
	;

	test eax,ecx
	jz end

	mov ebx, 0

end:
	; exit
	mov eax, 1 ; sys_exit
	int 0x80    ; invoke kernel again


section .data
	; data section
	; format db '%s' ; save string

section .bss
	; ram section
	; storage: resb 128 ; reserve 128 byte