section .text

global main

main:
	mov eax, 1 ; counter
	mov ebx, 0 ; exit code

adder:

	add ebx, eax
	
	inc eax
	cmp eax, 11
	jne adder

	call end

end:
	mov eax, 1 ; sys_exit
	;mov ebx, 0 ; error-code = 1
	int 80h    ; invoke kernel again


