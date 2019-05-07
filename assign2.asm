%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro
section .data
	msg db 'Enter the Number:',10
	msgLen equ $-msg
	counter db 5
	
	
section .bss
	num resb 3
	array resb 5
	
section .text
	global _start
	
_start:
	mov rbp,array
	
again:	rw 1,1,msg,msgLen
	
	rw 0,0,num,3
	
	mov al,0
	mov rsi,num
up:
	mov bl,byte[rsi]
	cmp bl,0aH
	je  next
	cmp bl,39H
	jbe down
	sub bl,07
down:
	sub bl,30H
	shl al,4
	add al,bl
	inc rsi
	jmp up
	
next:	mov byte[rbp],al
	inc rbp
	dec byte[counter]
	jnz again
 
	rw 60,0,0,0
	
	
	
