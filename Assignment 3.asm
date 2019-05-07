;Name:Alok Bhawankar
;Roll no.: 203143
;Div: A(A3)
%macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .data
	
	
	arr db 10h,20h,30h,40h,50h
	arr1 db "10,20,30,40,50",10
	arr1len equ $-arr1
	msg2 db "The  elements of array: ",10
	msg2len equ $-msg2
	msg1 db "Sum of array: ",10
	msg1len equ $-msg1

	cnt db 5
	
	temp1 db 0

section .bss
	sum resb 2
	num resb 3
	temp resb 2

section .text
	global _start
_start:

	mov rbp, arr  ;added nw	
	
nextnum:rw 1,1, msg2,msg2len
	rw 0,0, num,3
	Mov rcx,0
	Mov rax,0
	Mov rsi,num
up:Mov cl,byte[rsi]
	Cmp cl,0aH
	Je packed
	Cmp cl,39h
	Jbe down
	Sub cl,07h
down: sub cl,30H
	Rol al,4
	Add al,cl
	Inc rsi
	Jmp up

packed:	mov byte[rbp],al
	inc rbp
	dec byte[cnt]
	jnz nextnum


	mov rsi,arr
	mov ax,00h
	mov bx,0h
	mov cx,5		
up2:	mov bl,byte[rsi]
  	add ax,bx
	jnc skip
	inc ah
skip:	 
	inc rsi
	dec cx
	jnz up2
	
	mov word[sum],ax
	rw 1,1, msg1,msg1len
	call disp
	

exit:	mov rax,60
	mov rdi,0
	syscall

disp:
	
	mov bp,4
	mov ax,word[sum] 
up1:	rol ax,4
	mov [temp],ax
	and ax,0fh
	cmp al,09
	jbe down1
	add al,07
down1:	add al,30h
	mov [temp1],al
	rw 1,1,temp1,1

	mov ax,word[temp]
	dec bp
	jnz up1
	ret
OUTPUT:
c04l1004@c04l1004:~$ nasm -f elf64 as3.asm
c04l1004@c04l1004:~$ ld -o as3 as3.o
c04l1004@c04l1004:~$ ./as3
The  elements of array: 
12
The  elements of array: 
35
The  elements of array: 
57
The  elements of array: 
69
The  elements of array: 
70
Sum of array: 
0177c04l1004@c04l1004:~$ 






