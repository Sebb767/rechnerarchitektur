section .text

extern printf
global main

main:
	
	mov eax, 0 ; k
	mov ebx, 0 ; ebx = counter
	mov edx, 0 ; index

lp:
	mov eax, [buffer+edx]
	jz enderr
	add edx, eax
	inc ebx
	mov [buffer+edx], 0

	jmp lp


	
end:
	; exit
	mov eax, 1 ; sys_exit
	int 0x80    ; invoke kernel again

enderr:
	; exit
	mov eax, 1 ; sys_exit
	int 0x80    ; invoke kernel again

section .data
	; data section
	buffer db 2, 3, -1, 2, -1

section .bss
	; ram section
	; storage: resb 128 ; reserve 128 byte