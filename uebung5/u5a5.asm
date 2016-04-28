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
	mov ecx, 0

	; now split up the number
mod:

	xor edx, edx ; clear mod register (edx)
	div ebx ; div eax by 10

	add edx, 48 ; add ascii num offset
	mov [storage+ecx], edx ; move it to the variable register
	inc ecx ; and increase our pointer

	cmp ebx, eax
	jl mod ; if eax < 10, jump back

	;
	; print it
	;
	mov eax, 4 ; sys call number (sys_write)
	mov ebx, 1 ; stdout file descriptor
	mov edx, ecx ; ecx contains our length, but we need in edx
	mov ecx, storage ; the storage contains our values

	int 80h    ; syscall (kernel)

	; and exit

end:
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 80h    ; invoke kernel again


section .bss
	storage: resb 128 ; reserve 32 byte (just to be sure)