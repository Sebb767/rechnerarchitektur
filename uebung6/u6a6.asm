section .text

extern printf
global main

main:
	; invoke sys_read
	mov eax, 3 
	mov ebx, 0
	mov ecx, storage
	mov edx, 128
	int 0x80

	;
	; check char by char and count brackets
	;
	; eax/al = current char
	; ebx = char counter
	; ecx = bracket counter

	xor ebx, ebx
	xor ecx, ecx

lp:
	mov al, [storage+ebx]

	cmp eax, 0 ; 0x00 terminates a string
	je loopEnd

	cmp eax, 0x28 ; (
	jne skipOpen

	; if ecx/bracket counter value is >0, there was a closing
	; bracket too much, so this must stay in error mode
	cmp ecx, 0 
	jl skipOpen

	inc ecx ; found opening

skipOpen:

	cmp eax, 0x29 ; )
	jne skipClose
	dec ecx ; found closing

skipClose:

	inc ebx
	jmp lp;

loopEnd:

	; if ecx is 0, all brackets match
	cmp ecx, 0
	je end
	mov ecx, 1 ; if not return non-zero exit code

end:
	; exit
	mov eax, 1 ; sys_exit
	mov ebx, ecx ; error-code = ecx
	int 0x80    ; invoke kernel again


section .data
	; data section
	; format db '%s' ; save string

section .bss
	storage: resb 128 ; reserve 128 byte