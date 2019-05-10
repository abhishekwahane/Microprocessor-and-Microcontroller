;203165
;AbhisheK Wahane
;B1 Batch
;Assignment 2


section .data

     arr dd 12.3,14.2,23.4,16.3,11.5
     point db "."
     plen equ $-point
     msg db 'Mean is:',10
     msglen equ $-msg
     divisor dd 5.0
     tent dd 10000.0
     newl db 10

%macro rw 4
     mov rax,%1
     mov rdi,%2
     mov rsi,%3
     mov rdx,%4
     syscall
%endmacro

section .bss
     mean resb 4					
     mean1 resb 4
     count resb 1
     count1 resb 1
     temp resb 1

section .text

global _start
_start:

     mov esi,arr
     mov cx,5
     fldz						
up:fadd dword[esi]				
     add esi,4					
     dec cx
     jnz up
     fdiv dword[divisor]	
     fst dword[mean]
     fmul dword[tent]
     fbstp tword[mean1]			

     mov ebp,mean1					
     rw 1,1,msg,msglen
					
display:add ebp,9				
     mov byte[count],10

above:cmp byte[ebp],00
     je skip						
     cmp byte[count],02
     jne print
     rw 1,1,point,plen

print:mov bl,byte[ebp]
     mov byte[count1],2

again:rol bl,4
     mov byte[ebp],bl
     and bl,0fh
     cmp bl,09h
     jbe down
     add bl,07h

down:add bl,30h
     mov byte[temp],bl
     rw 1,1,temp,1
     mov bl,byte[ebp]
     dec byte[count1]
     jnz again

skip:dec ebp
     dec byte[count]
     jnz above
     mov rax,60
     mov rdi,0
syscall	    




