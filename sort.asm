;203165
;Abhishek Wahane
;B1 Batch
;Sorting Numbers in Ascending Order

section .data
	arr db 3Ah, 10h, 32h, 5bh, 21h   	;hard coded input data


section .bss
	arr2 resb 15                     	;array for displaying sorted output

%macro wr 4                     		;macro for read and write
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro                       		;end macro


section .text
	global _start
	_start:
	
		mov cl, 5                       ;counter for the outer for loop
		outer: mov ch, 4                ;counter for the inner for loop
		mov esi, arr                    ;copy the array in esi
		inner: mov al, [esi]            ;1st element of array
		cmp al, [esi+1]                 ;compare 1st and second element
		jbe down                        ;jump down if they are in proper sequence
		xchg al, [esi+1]                ;else exchange data(swap)
		mov [esi], al                   ;elements are swapped
		down: inc esi                   ;go to the next element of the array
		dec ch                          ;decrement counter
		jnz inner                       ;jump to the inner for loop if counter is not zero
		dec cl                          ;decrement counter
		jnz outer                       ;jump to the outer for loop if counter is not zero



		mov cl, 5                       ;set counter to 5
		mov edi, arr2                   ;copy the second array in edi
		mov esi, arr                    ;copy the first array in esi
		next_num: mov dl, 2             ;set dl counter to 2 (2 digits)
		mov al, [esi]                   ;unpacking
		next_digit: rol al, 4
		mov bl, al
		and al, 0Fh
		cmp al, 09h
		jbe down1
		add al, 07h
		down1: add al, 30h
		mov [edi], al
		mov al, bl
		inc edi                         ;next element in the array
		dec dl                          ;decrement counter
		jnz next_digit                  ;repeat it again    
		mov byte[edi], 20h
		inc edi
		inc esi
		dec cl
		jnz next_num                   ;repeat 5 times for 5 numbers
		wr 1, 1, arr2, 15

		mov rax,60                     ;sys call for exit
		mov rdi,0
		syscall