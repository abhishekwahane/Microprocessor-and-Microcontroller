;203165
;Abhishek Wahane
;B1 Batch
;Display Contents of GDTR,LDTR,IDTR

section .data							

  msg1 db "Base Address: ",10
  msgl1 equ $-msg1
  msg2 db "Offset Address: ",10
  msgl2 equ $-msg2
  msg3 db "Global Descriptor Table Register: ",10
  msgl3 equ $-msg3 
  msg4 db "Interrupt Descriptor Table Register: ",10
  msgl4 equ $-msg4
  msg5 db "Local Descriptor Table Register: ",10
  msgl5 equ $-msg5
  msg6 db "Task Register: ",10
  msgl6 equ $-msg6
  msg7 db "Machine Status Word: ",10
  msgl7 equ $-msg7
  newl db 10

section .bss		
					
  gdtr resq 1
  idtr resq 1
  gdtlimit resw 1
  idtlimit resw 1
  ldtr resw 1
  tr resw 1
  msw resw 1
  res64 resb 16
  res16 resb 4
  temp resb 1

  %macro rw 4
  mov rax,%1
  mov rdi,%2
  mov rsi,%3
  mov rdx,%4
  syscall
  %endmacro

section .text
  global _start
  _start:


  ;GDTR
  rw 1,1,msg3,msgl3
  rw 1,1,msg1,msgl1
  mov esi,gdtr						
  sgdt [esi]					;store gdt's value in esi
  mov rax,[esi]					
  call display64				;calling function display64
  rw 1,1,newl,1

  ;OFFSET
  rw 1,1,msg2,msgl2                 
  mov esi,gdtlimit                           
  mov ax,[esi]					
  call display16                                ;calling function display16
  rw 1,1,newl,1

  ;IDTR
  rw 1,1,msg4,msgl4
  rw 1,1,msg1,msgl1
  mov esi,idtr						
  sidt [esi]					;store idt's value in esi
  mov rax,[esi]					
  call display64				;calling function display64
  rw 1,1,newl,1

  ;OFFSET
  rw 1,1,msg2,msgl2                 
  mov esi,idtlimit                           
  mov ax,[esi]
  call display16                                ;calling function display16
  rw 1,1,newl,1


  ;LDTR
  rw 1,1,msg5,msgl5
  mov esi,ldtr					;store ldt's value in esi
  sldt [esi]
  mov ax,[esi]
  call display16
  rw 1,1,newl,1


  ;TR
  rw 1,1,msg6,msgl6
  mov esi,tr					
  str [esi]					;store tr's value in esi
  mov ax,[esi]
  call display16
  rw 1,1,newl,1


  ;MSW
  rw 1,1,msg7,msgl7
  mov esi,msw
  smsw [esi]					;store tr's value in esi
  mov ax,[esi]
  call display16
  rw 1,1,newl,1

  rw 60,0,0,0

display64:
  mov bp,16
  rol rax,16
	
again:
  rol rax,4
  mov[res64],rax
  and rax,0fh
  cmp rax,09h
  jbe down
  add rax,07h

down:
  add rax,30h
  mov byte[temp],al
  rw 1,1,temp,1
  mov rax,[res64]
  dec bp
  jnz again
  
ret
  
display16:
  mov bp,4

againx:
  rol ax,4
  mov[res16],ax
  and ax,0fh
  cmp ax,09h
  jbe downx
  add ax,07h

downx:
  add ax,30h
  mov byte[temp],al
  rw 1,1,temp,1
  mov ax,[res16]
  dec bp
  jnz againx

ret  
