

;	void ft_list_remove_if(t_list **head, void *data, int (*cmp)(), void (*free_fct)(void *))	;
;	tmp = *head																					;
;	while ((tmp && cmp(tmp->data, data) == 0))													;
;	*head = tmp->next																			;
;	free_fct(tmp->data)																			;
;	free(tmp)																					;
;	tmp = *head																					;
;	jmp while																					;
;	if !tmp || !tmp->next																		;
;		return																					;
;	prev = tmp																					;
;	tmp = tmp->next																				;
;	while (tmp)																					;
;	if (cmp(tmp->data, data, ref) == 0)															;
;	tmp2 = tmp->next																			;
;	free_fct(tmp->data)																			;
;	free(tmp)																					;
;	prev->next = tmp2																			;
;	tmp = tmp2																					;
;	endif	else																				;
;			prev = tmp																			;
;			tmp = tmp->next																		;
;	jmp while																					;


					section .text
					global _ft_list_remove_if		; r10 = tmp 
					extern _free

_ft_list_remove_if:
	first:
					mov	r10, [rdi]					; rdi = head - r10 = *head
					cmp	r10, 0						; if !head
				je	stopf							; salta a return
					push rdi						; salva head
					push rsi						; salva data
					push rdx						; salva (*cmp)
					mov	rdi, [r10]					; rdi = *head (per chiamare cmp)
					call rdx						; chiama cmp
					pop	rdx							;
					pop	rsi							;
					pop	rdi							;
					cmp rax, 0						; if cmp != 0
				jne	stopf							;
					mov r10, [rdi]					; r10 = *head 
					mov	r11, [r10 + 8]				; r11 = head->next
					mov	[rdi], r11					; *head = head->next
					push rdi						;
					push rsi						;
					push rdx						;
					push r10						;
					push r11						;
					mov rdi, r10					;
					call _free						; chiama free per liberare il nodo
					pop r11
					pop r10
					pop rdx
					pop rsi
					pop rdi
					jmp first						; salta a first

	stopf:
					mov r10, [rdi]
	second:
					mov r11, [r10 + 8]				; r11 = tmp->next
					cmp r10, 0						; if !tmp
				je	end								;
					cmp r11, 0						; if !tmp->next
				je	end								;
					push rdi
					push rsi
					push rdx
					push r10
					push r11
					mov rdi, [r11]					; rdi = *tmp per chiamare cmp
					call rdx						; chiama cmp
					pop r11
					pop r10
					pop rdx
					pop rsi
					pop rdi
					cmp rax, 0						; if rax != 0
				jne	slide
					push rdi
					push rsi
					push rdx
					push r10
					push r11
					mov rdi, r11					; rdi = tmp
					mov r11, [r11 + 8]				; r11 = ->next
					mov [r10 + 8], r11				; ->next = ->next
					call _free						; chiama free
					pop r11
					pop r10
					pop rdx
					pop rsi
					pop rdi
					jmp second
	slide:
					mov r10, r11
					jmp second
	end:
					ret
