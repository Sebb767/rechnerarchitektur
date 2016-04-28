section .text

global main

main:
	mov eax, 0 ; sum
	mov ebx, 1 ; counter


adder:

	add eax, ebx ; add counting (ebx) to eax (sum)
	
	inc ebx	; increase the counter
	cmp ebx, 11 ; if it is not 11 ...
	jne adder ; jump back if lower than 11

	push 0 ; // push zero to the stack as upper bound
	mov ebx, 10 ; move constant for dividing

	; now split up the number
mod:

	mov edx, 0 ; clear mod
	div ebx ; div eax by 10
	push edx ; push mod to stack
	cmp eax, ebx
	jl mod ; if eax <= 0, jump back

printloop:
	; printing this ...
	pop ecx ; save num to ecx
	jle end ; if we popped zero (our delimiter), jump to end
	call printn ; and print it
	jmp printloop ; do it again

	call end


printn: ; printnum
	mov eax, 4 ; sys call number (sys_write)
	mov ebx, 1 ; stdout file descriptor
	; ecx contains msg
	mov ecx, 2
	add ecx, 48 ; add ascii num offset
	mov edx, 2 ; lenght

	int 80h    ; syscall (kernel)

	ret ; return 

end:
	mov eax, 1 ; sys_exit
	mov ebx, 0 ; error-code = 0
	int 80h    ; invoke kernel again


.bss
	res: resb 2 ; reserve 2 byte