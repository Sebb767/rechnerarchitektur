section .text

extern printf
global main

main:
	; eax = tmp
	; ebx = fib1
	; ecx = fib2
	; edx = counter

	mov ebx, 1
	mov ecx, 1
	mov edx, 100

lp:

	mov eax, ecx
	add eax, ebx
	mov ecx, ebx
	mov ebx, eax

	dec edx
	cmp edx, 0
	jle end
	jmp lp


end:
	
	mov [storage], eax
	push storage
	push format
	call printf

	mov ebx, 0


	; exit
	mov eax, 1 ; sys_exit
	int 0x80    ; invoke kernel again


section .data
	; data section
	format db '%d' ; save string

section .bss
	; ram section
	storage: resb 4 ; reserve 128 byte