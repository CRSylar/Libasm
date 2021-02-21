
	;	char *strdup(const char *s)			;
	;	char *s2 							;
	;	int i = strlen(s)					;
	;	if i == 0 return ("")				;
	;	s2 = malloc(i + 1)					;
	;	strcpy(s2, s)						;
	;	return (s2)							;


			section .text
			global _ft_strdup
			extern _malloc
			extern ___error


_ft_strdup:
					jmp _ft_strlen

_ft_strlen:
					mov	r10, 0				; i = 0
					cmp	rdi, 0				; if !s
				je	out						; return
					dec	r10					;
			loop:	inc	r10					; i++
					cmp	byte [rdi+r10], 0	; if str[i] != \0
				jne	loop					; jump to loop

allocation :
					inc r10					; i++ (per mallod i +1)
					push rdi				; salvo rdi che contiene s
					mov rdi, r10			; metto i dentro rdi per malloc
					call _malloc			; chiamata a funzione - rax = malloc
					cmp rax, 0
					je	error				; se malloc torna puntatore a NULL chiamo errore
					pop rdi					; rimetto s dentro rdi per fare copia

_ft_strcpy:
					mov r10, 0					; i = 0
	copy:			mov dl, byte [rdi + r10]	; dl = s[i]
					mov byte [rax + r10], dl	; d[i] = dl<-(registo a 8 bit)
					inc r10						; i++
					cmp byte [rdi + r10], 0		; if s[i] = 0
					jne copy					; jump copy
					mov	byte [rax + r10], 0		; d[i] = 0
					ret

out :
					mov rax, 0
					ret
error :
					mov r10, 12
					call ___error
					mov [rax], r10
					mov rax, 0
					ret