
;	void	ft_list_push_front(t_list **head, void *data)	;
;	t_list *tmp = malloc...									;
;	tmp->data = data										;
;	tmp->next = 0											;
;	swap = head												;
;	head = tmp												;
;	head->next = swap										;


						section .text
						global _ft_list_push_front
						extern _malloc
						extern ___error

_ft_list_push_front:
						cmp rdi, 0			; if !head
						jz end				;
						push rdi			; rdi = head
						push rsi			; rsi = data
						mov	rdi, 16			; 16 perche la struttura contiene 2 puntatori (8byte uno)
						mov	rax, 0			; azzera rax
						call _malloc		; malloc(16)
						pop rsi				; riprendo head
						pop rdi				; riprendo data
						cmp rax, 0			; if ritorno malloc = NULL
						je error			; salta a errore
						mov [rax], rsi		; tmp->data = data
						mov r11, [rdi]		; swap = head
						mov [rax + 8], r11	; tmp->next = head
						mov [rdi], rax		; head = tmp
						ret
error:
						mov r10, 12
						call ___error
						mov [rax], r10
						mov rax, 0
						ret
end:
						ret