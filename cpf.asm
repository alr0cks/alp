

section .data
msg1 db "error message",10
msglen1 equ $-msg1

msg2 db"The file is copied",10
msglen2 equ $-msg2

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .bss
fname1 resb 15
fname2 resb 15
fd1 resq 1
fd2 resq 1
buff resb 256
bufflen resb 1

section .text
global _start
_start:

pop r8
cmp r8,3
jne err
pop r8
pop r8

mov esi,fname1
above:  mov al,[r8]
	cmp al,00
	je next1
	mov [esi],al
	inc r8
	inc esi
	jmp above
	
next1: 	pop r8
	mov esi,fname2
	
above1: mov al,[r8]
	cmp al,00
	je next2
	mov [esi],al
	inc r8
	inc esi
	jmp above1
	
next2:	rw 2,fname1,000000q,0777q
		mov [fd1],rax
		mov rbx,rax
		rw 0,rbx,buff,256
		mov[bufflen],rax
		rw 1,rbx,buff,[bufflen]
		rw 85,fname2,0777q,0
		rw 2,fname2,2,0777q
		mov [fd2],rax
		mov rbx,rax
		rw 1,rbx,buff,[bufflen]
		rw 3,[fd2],0,0
		rw 3,[fd1],0,0
	
rw 1,1,msg2,msglen2
jmp end
err: rw 1,1,msg1,msglen1

end:rw 60,0,0,0


