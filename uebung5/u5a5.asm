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
	cmp ebx, 10 ; if it is not 11 ...
	jne adder ; jump back if lower than 11

	;
	; Split the number via modulo
	;
	; eax = number
	; ebx = 10 (divisor)
	; ecx = counter
	; edx = modulo

	;push 0 ; // push zero to the stack as upper bound
	mov ebx, 10 ; move constant for dividing
	xor ecx,ecx ; clear ecx

	; now split up the number
mod:

	xor edx, edx ; clear mod register(edx)
	div ebx ; div eax by 10

	add edx, 0x30 ; add ascii num offset (48)
	;mov [ecx], edx ; move it to the variable register
	push edx ; push the number to the stack
	inc ecx ; and increase our counter

	cmp eax, ebx
	jg mod ; if eax > 0, jump back

createStr:
	;
	; create output string in [storage]
	;
	; eax = offset
	; ebx = num storage
	; ecx = size
	; edx = counter
	mov eax, storage ; mov storage pointer to eax
	mov edx, ecx

nextChar:
	pop ebx ; take num from storage
	mov [eax], ebx ; push number to [storage]
	inc eax ; increase storage pointer
	dec edx ; decrease the negative counter
	jg nextChar ; if edx > 0, repeat

	; push a linefeed (\n) on the output buffer
	mov ebx, 0x0A
	mov [eax], ebx
	inc ecx ; increase length


	;
	; print it
	;
	mov eax, 4 ; sys call number (sys_write)
	mov ebx, 1 ; stdout file descriptor
	mov edx, ecx ; ecx contains our length, but we need in edx
	mov ecx, storage ; the storage contains our values

	int 0x80 ; syscall (kernel)

	; and exit



	; debug
	;mov ebx, edx ; error-code = 0
	;mov eax, 1 ; sys_exit
	;int 0x80    ; invoke kernel again
	; /debug

end:
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 0x80    ; invoke kernel again


section .bss
	storage: resb 128 ; reserve 128 byte (just to be sure)