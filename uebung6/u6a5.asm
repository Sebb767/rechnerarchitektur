section .text

extern printf
global main

main:
	mov eax, 3
	mov ebx, 0
	mov ecx, storage
	mov edx, 128
	int 0x80

	push storage
	push format
	call printf

end:
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 0x80   ; invoke kernel again


section .data
	format db '%s'

section .bss
	storage: resb 128 ; reserve 128 byte (just to be sure)