section .text

global main

main:
	call looping


looping:
	call print ; print hw

	mov eax, [myc] ; get the variable
	inc eax ; increase
	mov [myc], eax ; save the new state

	cmp eax, 11 ; compare if its 11
	jne looping ; if not, again

	call end ; exit


print:
	mov eax, 4 ; sys call number (sys_write)
	mov ebx, 1 ; stdout file descriptor
	mov ecx, mymsg ; message
	mov edx, mylen ; lenght

	int 80h    ; syscall (kernel)

	ret ; return 

end:
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 1
	int 80h    ; invoke kernel again

section .data

	mymsg db "Hello, World!", 0xa
	mylen equ $-mymsg

section .bss
	myc: resb 1 ; reserve 1 byte

