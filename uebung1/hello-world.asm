section .text

global main

main:
	
	mov eax, 4 ; sys call number (sys_write)
	mov ebx, 1 ; stdout file descriptor
	mov ecx, mymsg ; message
	mov edx, mylen ; lenght
	int 80h    ; syscall (kernel)
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 1
	int 80h    ; invoke kernel again

section .data

	mymsg db "Hello, World!", 0xa
	mylen equ $-mymsg

