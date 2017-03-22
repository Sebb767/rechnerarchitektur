section .text

extern printf
global main

main:
	mov eax, 1 ; info descriptor descriptor
	cpuid
	push eax

	mov eax, 0 ; cpu name
	cpuid
	mov [storage], ebx
	mov [storage+4], edx
	mov [storage+8], ecx
	push storage

	push format

	call printf

end:
	; exit
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 0x80    ; invoke kernel again


section .data
	; data section
	format db 'Vendor ID: %s', 0x0A, 'Processorinfo: %d', 0x0A

section .bss
	; ram section
	storage: resb 12 ; cpuid