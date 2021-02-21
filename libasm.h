
#ifndef LIBASM_H
# define LIBASM_H

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>

#define GREEN	"\x1b[32m"
#define YELL	"\x1b[33m"
#define RED		"\x1b[31m"
#define RESET	"\x1b[0m"
#define OK		printf(GREEN" ok "RESET)
#define KO		printf(RED" ko "RESET)

typedef	struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

int		ft_strlen(char *s);
int		ft_strcmp(char *s1, char *s2);
int		ft_atoi_base(char *str, char *base);
int		ft_list_size(t_list *head);
char	*ft_strcpy(char *d, char *s);
char 	*ft_strdup(const char *s);
ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t	ft_read(int fildes, void *buf, size_t nbyte);
void	ft_list_push_front(t_list **head, void *data);
void	ft_list_remove_if(t_list **head, void *data, int (*cmp)(), void (*free_fct)(void *));
void	ft_list_sort(t_list **head, int (*cmp)());

#endif