

;	int	ft_strcmp(char *s1, char *s2)	;
;	i = 0											;
;	if (!s1)										;
;	return -1										;
;	if (!s2)										;
;	return 1										;
;	while (s1[i] = s2[i])							;
;	if (s1[i] - s2[i] != 0)							;
;	return (s1[i] - s2[i])							;
;													;
;	return 0										;


			section .text
			global _ft_strcmp

_ft_strcmp :
				mov rax, -1							; i = -1
				cmp rdi, 0							; if !s1
				je	negative						; jump a ret = 1
				cmp	rsi, 0							; if !s2
				je	positive						; jump a ret = -1

loop:			
				inc rax								; i = 0
				mov dl, byte [rdi + rax]			; dl = s1[i]
				mov	bl, byte [rsi + rax]			; bl = s2[i]
				cmp	dl, 0							; if s1[i] = \0
				je last								; jump to last
				cmp bl, 0							; if s2[i] = \0
				je last								; jump to last
				cmp dl, bl							; if s1[i] == s2[i]
				je loop								; jump to loop
				movzx rdx, dl						;
				movzx rbx, bl						;
				sub rdx, rbx						; s1 -= s2 <-(vanno usati i registri int)
				mov rax, rdx						;(o il risultato è sempre sbagliato)
				ret									;(es. invece di -32 viene 224)

last :
				movzx rdx, dl
				movzx rbx, bl
				sub rdx, rbx						; s1 -= s2 <-(vedi sopra)
				mov rax, rdx						
				ret

positive :		mov rax, 1							; ret 1
				ret
negative :		mov rax, -1							; ret -1
				ret
