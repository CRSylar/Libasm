section .data

section .text
	global _ft_strlen

_ft_strlen:
		mov		rax, 0				; i = 0
		cmp		rdi, 0				; if !s
	je	out							; return
		dec		rax					;
loop:	inc		rax					; i++
		cmp		byte [rdi+rax], 0	; if str[i] != \0
	jne		loop					; jump to loop
out:	ret							; chiama il return, il valore di ritorno DEVE essere dentro RAX