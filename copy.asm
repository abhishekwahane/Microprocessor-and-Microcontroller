;203165
;Abhishek Wahane
;B1 Batch
;Assignment 3
;File Copy


section .data
%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

msg2 db "File copied Successfully",10	
msg2len equ $-msg2
msg1 db "Error",10
msg1len equ $-msg1


section .bss
fname1 resb 20			;Source File
fd1 resq 1			;file descriptor 1
fname2 resb 20			;Destination File
fd2 resq 1			;file descripor 2
buff resb 512			;buffer to store name
bufflen resq 1


section .text
global _start
_start:

pop r8
cmp r8,3
jne err
pop r8
pop r8

mov esi,fname1

above1:mov al,[r8]		
       cmp al,00		
       je next1			
       mov [esi],al 		 
       inc r8		
       inc esi			
       jmp above1		

next1: pop r8
	      
above2:mov al,[r8]		
       cmp al,00		
       je next2			
       mov [esi],al 		
       inc r8			
       inc esi			
       jmp above2		

next2: rw 2,fname1,000000q,00777q
       mov [fd1],rax
       mov rbx,rax
       rw 0,rbx,buff,512
       mov [bufflen],rax
       rw 1,rbx,buff,[bufflen]
       
rw 85,fname2,000001q,00777q	
       
rw 2,fname2,000001q,00777q
mov [fd2],rax
mov rbx,rax
rw 0,rbx,buff,512
mov [bufflen],rax
rw 1,rbx,buff,[bufflen]
       
mov [bufflen],rax
       
rw 3,rbx,0,0
rw 3,[fd2],0,0
rw 1,1,msg2,msg2len
jmp end

err: rw 1,1,msg1,msg1len

end: rw 60,0,0,0
