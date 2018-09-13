;
; file: asm_main.asm

%include "asm_io.inc"
%define input_int [ebp-4]
%define input_char [ebp-8]
;
; initialized data is put in the .data segment
;
segment .data

prompt  db "First enter an integer and then a character.", 10,\
"Please enter an integer.", 10, 0

prompt2 db "Please enter a character.", 10, 0

prompt3 db "Your two inputs were ", 0
prompt4 db " and ", 0
prompt5 db ".", 0

; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
; 	   VAR TABLE
; ============================
; local 1 | [ebp-4] | input_int
; local 2 | [ebp-8] | input_char

        enter   2,0               ; setup routine
        pusha
; Code
	mov	eax, prompt	; Print prompt
	call	print_string	
	
	call	read_int	; input_int =  scanf("d%" );
	mov	input_int, eax
	
	mov	eax, prompt2	; print prompt2
	call	print_string

	call	read_char	; input_char = scanf("%s");
	mov	input_char, eax
	
times 3 call	print_nl	; 4 newline characters.

	mov	eax, prompt3	; print prompt3 + input_int + prompt4
	call	print_string    ; + input_char + prompt5 + '\n'

	mov	eax, input_int
	call	print_int

	mov	eax, prompt4
	call	print_string

	mov	eax, input_char
	call	print_char

	mov	eax, prompt5
	call	print_string
	
	call	print_nl
; next print out result message as series of steps

        popa
        mov     eax, 0            ; return back to C
        leave
        ret
