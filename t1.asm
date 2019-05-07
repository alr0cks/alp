%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3                     
mov rdx,%4
syscall
%endmacro

section .data
msg1 db "Enter the number:"
msg1Len equ $-msg1
msg2 db "The greay code number is:"
msg2Len equ $-msg2

section .bss
	grey resb 2
	num resb 2

section .text
global _start
_start:
	rw 1,1,msg1,msg1Len
	rw 0,0,grey,3
	
	mov al,grey
	mov bl,al
	shr al,01
	xor bl,al

	mov [num],bl

	rw 1,1,msg2,msg2Len
	rw 1,1,num,1

	rw 60,0,0,0
