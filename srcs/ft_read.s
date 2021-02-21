

;	ssize_t	ft_read(int fildes, void *buf, size_t nbyte);


			section	.text
			global _ft_read
			extern ___error

_ft_read:
			mov	rax, 0x02000003			; call to read
			syscall						;
			jc error					; se carry flag settata salta
			ret							;

error :
			push rax					; salva rax<-(valore di ritorno di read)in r10
			call ___error				; chiamata a funzione
			pop r10						;
			mov	[rax], r10				; assegna il numero di errore a errno
			mov	rax, -1					; ritorna -1
			ret