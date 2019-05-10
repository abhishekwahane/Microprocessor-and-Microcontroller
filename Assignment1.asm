;203165
;AbhisheK Wahane
;B1 Batch
;Assignment 1


section .data
 msg1 db 'Enter a 8 bit number:',10
 msg1Len equ $-msg1
 msg2 db 'Your number is:',10
 msg2Len equ $-msg2

section .bss
 num resb 2

section .text
global _start
 _start:
 mov rax,1
 mov rdi,1
 mov rsi,msg1
 mov rdx,msg1Len
 syscall

 mov rax,0
 mov rdi,0
 mov rsi,num
 mov rdx,2
 syscall

 mov rax,1
 mov rdi,1
 mov rsi,msg2
 mov rdx,msg2Len
 syscall

 mov rax,1
 mov rdi,1
 mov rsi,num
 mov rdx,2
 syscall

 mov rax,60
 mov rdi,0
 syscall
