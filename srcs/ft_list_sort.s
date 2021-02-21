
;		void	ft_list_sort(t_list **head, int (*cmp)())	;
;		i = 1												;
;		if !head											;
;		return												;
;		while i = 1											;
;			i = 0											;
;			tmp = *head										;
;			while tmp->next									;
;				if (cmp(tmp->data, tmp->next->data) > 0)	;
;					i = 1									;
;					swap = tmp->data						;
;					tmp->data = tmp->next->data				;
;					tmp->next->data = swap					;
;				tmp = tmp->next								;
;															;


					section .text
					global _ft_list_sort

_ft_list_sort:
					push r13				; salvo r13, registro preservato
					mov r13, [rdi]			; r13 = *head
					mov rdi, [rdi]			; rdi = *head
loop:
					mov r10, [rdi + 8]		; r10 = head->next
					cmp r10, 0				; if (!r10)
				je	end						;
					push rdi
					push rsi
					mov rcx, rsi			; salva (*cmp) per chiamarla dopo
					mov rsi, [rdi + 8]		; 2arg = lst->next
					mov rsi, [rsi]			; 2arg = lst->next->data
					mov rdi, [rdi]			; 1arg = lst->data
				call rcx					; chiama cmp
					pop rsi
					pop rdi
					cmp rax, 0				; if cmp > 0
				jg	sort
				jmp sorted
sort:
					mov r11, [r10]			; swap = list->next->data
					mov r12, [rdi]			; tmp = list->data
					mov [rdi], r11			; list->data = list->next->data
					mov [r10], r12			; list->next->data = list->data
					mov rdi, r13			; metti head di nuovo in rdi
				jmp loop
sorted:
					mov rdi, [rdi + 8]		; lst = lst->next
				jmp	loop
end:
					pop r13
					ret