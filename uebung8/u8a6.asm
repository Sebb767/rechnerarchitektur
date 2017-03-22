section .text

extern printf
global main

main:
	;TODO: Code

end:
	; exit
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 0x80    ; invoke kernel again


section .data
	; data section
	; format db '%s' ; save string

section .bss
	; ram section
	; storage: resb 128 ; reserve 128 byte