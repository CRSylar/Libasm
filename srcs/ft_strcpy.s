

; char *strcpy(char *d, char *s)	;
;									;
;	int i = 0						;
;	if (!s)	return(0)				;
;	while (s[i])					;
;	d[i] = s[i]						;
;	i++								;
;	d[i] = 0						;
;	return (d)						;

	section	.text
	global _ft_strcpy

_ft_strcpy:	
				mov	rax, 0								; i = 0
				cmp	rsi, 0								; if !s
			je	return									; return

loop :			
				mov dl, byte [rsi + rax]				; dl = s[i]
				mov byte [rdi + rax], dl				; d[i] = dl<-(registo a 8 bit)
				inc rax									; i++
				cmp byte [rsi + rax], 0					; if s[i] = 0
				jne loop								; jump loop
				mov	byte [rdi + rax], 0					; d[i] = 0
				mov rax, rdi

return :		ret					