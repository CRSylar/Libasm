

;	int	ft_atoi_base(char *str, char *base)	;
;	if !base || !base[0] || !base[1]		;


				section .text
				global _ft_atoi_base
				extern _ft_strlen

_ft_atoi_base:
				push rdi					; salvo str
				push rsi					; salvo base
				mov	 rdi, rsi				; sposto base per chiamata a funzione
				call check_base
				pop rsi
				pop rdi
				mov r11, 0					; nbr = 0
				mov r12, 1					; sign = 1
				cmp rax, 0					; if ret<-check_base == 0, salta
				je end
				push rdi					; salvo str
				push rsi					; salvo base
				mov rdi, rsi				; sposto base per chiamare strlen
				call _ft_strlen
				pop rsi						; riprendo i dati originali
				pop rdi
				cmp rax, 2					; se len base < 2 salto a end
				jl end
				mov r10, rax				; salvo len in r10
				dec rdi						; rdi--
skipspace:
				inc rdi						; rdi++
				mov dl, byte [rdi]			; dl = *rdi
				cmp dl, 9					; while (*rdi >= '9' && <= 13 || == 32)
				je skipspace				;
				cmp dl, 10					;
				je skipspace				;
				cmp dl, 11					;
				je skipspace				;
				cmp dl, 12					;
				je skipspace				;
				cmp dl, 13					;
				je skipspace				;
				cmp dl, 32					;
				je skipspace				;
				dec rdi						;
sign:
				inc rdi						;
				mov	dl, byte [rdi]			;while (*rdi == '+' || '-')
				cmp dl, 43					;
				je sign						;if '-' set sign
				cmp dl, 45					;
				je setsign					;
atoi:
				mov dl, byte[rdi]
				push rdi
				push rsi
				mov dil, dl
				call in_str
				pop rsi
				pop rdi
				cmp rax, 0
				jl end
				imul r11, r10
				add r11, rax
				inc rdi
				jmp atoi
setsign:
				imul r12, -1
				jmp sign
end:
				imul r11, r12
				mov rax, r11
				ret
in_str:
				mov rax, -1
	flag		inc rax
				mov dl, byte [rsi + rax]
				cmp dl, 0
				je error
				cmp dl, dil
				je stop
				jmp flag
stop:
				ret
error:
				mov rax, -1
				ret
check_base :
				mov rax, 0					; ret = 0
				mov r11, 0					; i = 0
				mov r12, 0					; j = 0
floop:
				mov sil, byte [rdi + r11]	; ciclo while esterno
				cmp sil, 0					; se base[i] = 0
				je endf						; salta 
				mov r12, r11				; j = i
				inc r12						; j++
				cmp sil, 43					; se base[j] = '-'
				je endb
				cmp sil, 45					; || = '+'
				je endb
				cmp sil, 33					; || < 33
				jl endb
				cmp sil, 126				; || > 126
				jg endb
sloop:
				mov dl, byte [rdi + r12]	; ciclo interno, non deve esserci lo stesso carattere 2 volte
				cmp dl, 0					; se base[j] = 0
				je ends
				cmp sil, dl 				; se base[j] = base[i]
				je endb
				inc r12						; j++
				jmp sloop
ends:
				inc r11
				jmp floop
endf:
				mov rax, 1
endb:
				ret

