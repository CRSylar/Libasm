
;	int	ft_list_size(t_list *head)		;
;	t_list tmp = head					;
;	while (tmp)							;
;		i++								;
;		tmp = tmp->next					;
;	return i							;


				section .text
				global _ft_list_size

_ft_list_size:
				mov rax, -1				; i = 0
				mov r11, rdi			; tmp = head
				cmp r11, 0				; if !tmp
				je error
	loop:		inc rax					; i++
				cmp r11, 0				; if !tmp->next
				je end
				mov r11, [r11 + 8]		; tmp = tmp->next
				jmp loop
end:
				ret
error:
				mov rax, 0
				ret

