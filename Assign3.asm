;name:- Alok Bhawankar
;division:- A
;batch:-A3
;rollno:-203143
;MIT ASSIGNMENT 03
%macro rw 4                 ;MACRO FOR READ AND WRITE AND FOR NEW LINE
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro



section .data                 ;INTIALISED DATA
msg db 'enter the number:- ',10 
msgLen equ $-msg 
msg1 db 'the addition is:- ',10 
msg1Len equ $-msg1
counter db 5
newline db 10

section .bss                   ;UNINTIALSIED DATA
num resb 3
array resb 5
sum resb 2
temp1 resb 1
temp2 resb 2

section .text

global _start

_start:

mov rbp,array
again:
rw 1,1,newline,1


rw 1,1,msg,msgLen 



rw 0,0,num,3    


mov al,0
mov rsi,num

up: mov bl, byte[rsi]
cmp bl,0aH
je exit1 
cmp bl,39H
jbe down
sub bl,07
down:
sub bl,30H
shl al,4
add al,bl
inc rsi
jmp up

exit1:mov byte[rbp],al
inc rbp
dec byte[counter]
jnz again                              ;PACKING OF NUMBER

rw 1,1,msg1,msg1Len 

  mov rcx,0
  mov rax,0
mov rbp,array

up2:add al,byte[rbp]      
    jnc skip
    inc ah
skip:inc rbp
     dec cl
     jnz up2
     mov [sum],ax
     mov ax,[sum]                      ;SUM OF THE NUMBER  
  	mov rbp,4
repeat: rol ax,4
        mov word[temp2],ax
        and ax,0Fh
	cmp ax,09h
	jbe down2
        add ax,7h
down2:add ax,30h
 	mov byte[temp1],al
	rw 1,1,temp1,1
	mov ax,[temp2]
	dec rbp
	jnz repeat                     ;UNPACKING OF NUMBER
rw 1,1,newline,1
rw 60,0,0,0


OUTPUT
c04l1004@c04l1004:~$ nasm -f elf64 Assign3.asm
c04l1004@c04l1004:~$ ld -o Assign3 Assign3.o
c04l1004@c04l1004:~$ ./Assign3

enter the number:- 
1

enter the number:- 
2

enter the number:- 
4

enter the number:- 
3

enter the number:- 
1
the addition is:- 
0011



