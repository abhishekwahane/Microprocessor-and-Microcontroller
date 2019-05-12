;203165
;Abhishek Wahane
;B1 Batch
;Copy contents of file

section .data
msg1 db "error",10
msglen1 equ $-msg1
msg2 db " copy successful ",10
msglen2 equ $-msg2

%macro operate 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro%

section .bss
fname1 resb 15
fd1 resq 1
fname2 resb 15
fd2 resq 1
buff resb 512
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
above:  mov al,[r8]
	cmp al,00
	je next
	mov [esi],al
	inc r8
	inc esi
	jmp above
next:   pop r8
	mov esi,fname2
above1: mov al,[r8]
	cmp al,00
	je next1
	mov [esi],al
	inc r8
	inc esi
	jmp above1
next1:  operate 2,fname1,0,0777q
	mov [fd1],rax
	mov rbx,rax
	operate 0,rbx,buff,512
	mov [bufflen],rax
	operate 1,rbx,buff,[bufflen]
	operate 85,fname2,0777q,0
	operate 2,fname2,2,0777q
	mov [fd2],rax
	mov rbx,rax
	operate 1,rbx,buff,[bufflen]
	mov [bufflen],rax
	operate 3,rbx,0,0
	operate 3,[fd1],0,0
	operate 1,1,msg2,msglen2
	jmp end
err:    operate 1,1,msg1,msglen1
end:	operate 60,0,0,0
	
	
;c04l0510@c04l0510:~/Desktop$ ./aab abc.txt cabc.txt
 ;copy successful 

	
	
