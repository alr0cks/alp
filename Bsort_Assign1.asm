;NAme:Alok Bhawankar
;Panel: 5
;Roll no. 203143

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
msg1 db  "The Array Elements are:", 10
msg1Len equ $-msg1
array1 db 22h,25h,0Ah,0Dh,15h
newline db 10
msg2 db ";"


section .bss
count resb 1
dispbuff resb 4

section .text
global _start
_start:

	mov bl,05h
l1:
	mov rsi,array1
        mov rdi,array1
        inc rdi  
                
        mov cl,04h
up:
                mov al,[rsi]      
                cmp al,[rdi]
                jbe next
                xchg al,[rdi]
                mov [rsi],al
next:
                inc rsi
                inc rdi
                dec cl
                jnz up
                dec bl
                jnz l1
                
        rw 1,1,msg1,msg1Len
        mov rsi,array1
        mov byte[count],5
        
        display:
                
                mov bh,[rsi]
                push rsi
                call proc
                rw 1,1,dispbuff,2
                rw 1,1,msg2,1
                pop rsi
                inc rsi
                dec byte[count]
                jnz display
                rw 1,1,newline,1
                
	mov rax,60
	mov rdi,0
	syscall
                
                
proc:
        mov rsi,dispbuff
        mov rcx,4 
        
        l2:
                rol bx,4
                mov al,bl
                and al,0Fh
                cmp al,09h
                jbe down
                add al,07h
                
        down:
                add al,30h
                mov [rsi],al
                inc rsi
                dec rcx
                jnz l2
                
        ret
               
        



