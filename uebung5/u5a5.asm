section .text

global main

main:
	mov eax, 0 ; sum
	mov ebx, 1 ; counter


	;
	; Sum up 1 ... n
	;

adder:

	add eax, ebx ; add counting (ebx) to eax (sum)
	
	inc ebx	; increase the counter
	cmp ebx, 11 ; if it is not 11 ...
	jne adder ; jump back if lower than 11

	;
	; Split the number via modulo
	;
	; eax = number
	; ebx = 10 (divisor)
	; ecx = offset
	; edx = modulo

	push 0 ; // push zero to the stack as upper bound
	mov ebx, 10 ; move constant for dividing
	mov ecx, storage ; zero out ecx

	; now split up the number
mod:

	xor edx, edx ; clear mod register (edx)
	div ebx ; div eax by 10

	add edx, 0x30 ; add ascii num offset
	mov [ecx], edx ; move it to the variable register
	inc ecx ; and increase our pointer

	cmp eax, ebx
	jg mod ; if eax < 10, jump back


	; push a linefeed on the output buffer
	mov eax, 0x0A
	mov [ecx], eax
	inc ecx

	; push \0 (string termination)
	xor eax,eax
	mov [ecx], eax
	inc ecx


	;
	; print it
	;
	mov eax, 4 ; sys call number (sys_write)
	mov ebx, 1 ; stdout file descriptor
	mov edx, ecx ; ecx contains our length, but we need in edx
	sub edx, [storage]
	mov ecx, storage ; the storage contains our values

	int 0x80 ; syscall (kernel)

	; and exit

end:
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 0x80    ; invoke kernel again


section .bss
	storage: resb 128 ; reserve 128 byte (just to be sure)