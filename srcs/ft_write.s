

;	ssize_t ft_write(int fildes, const *void, size_t byte)	;
;															;
;	va fatta una chiamata a sistema per aprire lo stream	;

		section	.text
		global _ft_write
		extern ___error

_ft_write :
			mov rax, 0x02000004		; syscall for write
			syscall					;
			jc	error				; se la carry flag é settata dal sistema salta
			ret		
error :
			push rax				; salva rax<-(valore di ritorno di write)in r10
			call ___error			; chiama _error
			pop r10					;
			mov	[rax], r10 			; inserisci il vecchio valore di rax dentro errno
			mov	rax, -1				; di cui _error mi manda il puntatore
			ret						; ritorna -1