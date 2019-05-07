;Name: ALok Bhawankar
;Roll No.:203143
;BAtch: E2

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
    msg db "The MEAN of the numbers =  "
    msgLen equ $-msg

    point db "."
    pLen equ $-point   

    arr dd 12.32,56.12,87.34,13.78,56.65
    tnt dd 10000.0
    divisor dd 5.0
    
    newln db 10


section .bss
    mean resd 1        ; Actual mean
    mean1 rest 1        ; To store BCD no. from TOS
    
    cnt resb 1
    cnt1 resb 1
    
    temp resb 1


section .text
	global _start
	_start:

		mov cl,05
		mov esi,arr

		finit
		fldz

	addloop:
		fadd dword[esi]
		add esi,04
		dec cl
		jnz addloop
		
		fdiv dword[divisor]
		fst dword[mean]
		fmul dword[tnt]
		fbstp tword[mean1]
		mov ebp,mean1
		
		rw 1,1,msg,msgLen
		
	display:  
	        add ebp,9
		mov byte[cnt],10        		; for 80bits of BCD
		   
	above:
		cmp byte[ebp],00
		je skip
		cmp byte[cnt],02
		jne print
		        
		rw 1,1,point,pLen
		    
	print:
	        mov al,byte[ebp]
	        mov byte[cnt1],2
		    
	again:
	        rol al,04
	        mov byte[ebp],al
	        and al,0Fh
	        cmp al,09h
	        jbe down
	        add al,07h

	down:
	        add al,30h     
	        mov byte[temp],al
	        rw 1,1,temp,1
	        mov al,byte[ebp]
	        dec byte[cnt1]
	        jnz again
		        
	skip:    
	        dec ebp
	        dec byte[cnt]
	        jnz above
		
rw 1,1,newln,1
rw 60,0,0,0

