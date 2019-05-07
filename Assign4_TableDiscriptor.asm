section .data 
msg1 db "Base Address",10
msg11 equ $-msg1
msg2 db "Offset Address",10
msg22 equ $-msg2
msg3 db "Gdtr :",10
msg33 equ $-msg3
msg4 db "Idtr :",10
msg44 equ $-msg4
msg5 db "Ldtr :",10
msg55 equ $-msg5
msg6 db "Tr :",10
msg66 equ $-msg6
msg7 db "Msw :",10
msg77 equ $-msg7
newl db 10

%macro operate 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .bss
gdtr resq 1
gdtlimit resw 1
idtr resq 1
idtlimit resw 1
ldtr resw 1
tr resw 1
msw resw 1
res64 resb 16
res16 resb 4
temp resb 1

section .text
global _start
_start:
operate 1,1,msg3,msg33
operate 1,1,msg1,msg11
mov esi,gdtr
sgdt [esi]
mov rax,[esi]
call display64
operate 1,1,newl,1
operate 1,1,msg2,msg22
mov esi,gdtlimit
mov ax,[esi]
call display16

operate 1,1,msg4,msg44
operate 1,1,msg1,msg11
mov esi,idtr
sidt [esi]
mov rax,[esi]
call display64
operate 1,1,newl,1
operate 1,1,msg2,msg22
mov esi,idtlimit
mov ax,[esi]
call display16

operate 1,1,msg5,msg55
mov esi,ldtr
sldt [esi]
mov ax,[esi]
call display16

operate 1,1,msg6,msg66
mov esi,tr
str [esi]
mov ax,[esi]
call display16

operate 1,1,msg7,msg77
mov esi,msw
smsw [esi]
mov ax,[esi]
call display16
operate 60,0,0,0

display64:
	mov bp,16
	
again:	
	
	rol rax,4
	mov [res64],rax
	and rax,0FH
	cmp rax,09H
	jbe down
	add rax,07H
down:
	add rax,30H
	mov byte[temp],al
	operate 1,1,temp,1
	mov rax,[res64]
again2:
	dec bp
	jnz again
	operate 1,1,newl,1
	ret

display16:

	mov bp,4
again1:
	rol ax,4
	mov [res16],rax
	and ax,0FH
	cmp ax,09H
	jbe down1
	add ax,07H
down1:
	add ax,30H
	mov byte[temp],al
	operate 1,1,temp,1
	mov ax,[res16]
	dec bp
	jnz again1
	operate 1,1,newl,1
	ret




	
