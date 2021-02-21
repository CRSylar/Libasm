
#include "libasm.h"

static t_list	*lstnew(void *data)
{
	t_list *lst;

	lst = malloc(sizeof(t_list));

	lst->data = data;
	lst->next = 0;
	return (lst);
}

static void	ft_lstadd_front(t_list **lst, t_list *new)
{
	new->next = *lst;
	*lst = new;
}

static void		ft_lstclear(t_list **lst, void (*del)(void*))
{
	t_list *tmp;

	if (lst)
	{
		while (*lst)
		{
			tmp = (*lst)->next;
			//del((*lst)->data);
			free(*lst);
			*lst = tmp;
		}
	}
	*lst = 0;
}

int main(int ac, char **av)
{
	printf("%s",YELL);
puts("                                                                            ");
puts(" __    _____ _____ _____ _____ _____    _____ _____ _____ _____ _____ _____ ");
puts("|  |  |     | __  |  _  |   __|     |  |_   _|   __|   __|_   _|   __| __  |");
puts("|  |__|-   -| __ -|     |__   | | | |    | | |   __|__   | | | |   __|    -|");
puts("|_____|_____|_____|__|__|_____|_|_|_|    |_| |_____|_____| |_| |_____|__|__|");
puts("                                                                            ");
	printf("%s",RESET);

puts(YELL" TESTING FT_STRELEN "RESET);

char *n = 0;

if ((ft_strlen("ciao")) == 4)
	OK;
else
	KO;
if ((ft_strlen("Stringaunpolunga con diversi Caratteri 41")) == 41)
	OK;
else
	KO;
if ((ft_strlen("")) == 0)
	OK;
else
	KO;
if (ft_strlen(n) == 0)
	OK;
else
	KO;

puts(YELL"\n TESTING FT_STRCPY "RESET);

char *src = "testo da copiare";
char dst[25];

ft_strcpy(dst, src);
if (strcmp(dst, src) == 0)
	OK;
else
	KO;
src = "";
ft_strcpy(dst, src);
if (strcmp(dst, src) == 0)
	OK;
else
	KO;
src = 0;
ft_strcpy(dst, src);
if (!*dst)
	OK;
else
	KO;
src = "\n\f\v";
ft_strcpy(dst, src);
if (strcmp(dst, src) == 0)
	OK;
else
	KO;

puts(YELL"\n TESTING FT_STRCMP "RESET);

char *s1 = "Stringa 1 uguale a stringa 2 e diversa da 3";
char *s2 = "Stringa 1 uguale a stringa 2 e diversa da 3";
char *s3 = "stringa 3";
char *s4 = "";
char *s5 = 0;

if (ft_strcmp(s1, s2) == 0)
	OK;
else
	KO;

if (ft_strcmp(s2, s1) == 0)
	OK;
else
	KO;

if (ft_strcmp(dst, src) == 0)
	OK;
else
	KO;

if (ft_strcmp(s1, s3) < 0)
	OK;
else
	KO;

if (ft_strcmp(s3, s1) > 0)
	OK;
else
	KO;

if (ft_strcmp(s1, s4) > 0)
	OK;
else
	KO;

if (ft_strcmp(s1, s5) > 0)
	OK;
else
	KO;

if (ft_strcmp(s5, s1) < 0)
	OK;
else
	KO;

if (ft_strcmp(s4, s5) > 0)
	OK;
else
	KO;

puts(YELL"\n TESTING FT_WRITE "RESET);

int fd = open("./testr.txt", O_CREAT | O_TRUNC | O_RDWR, 0777);
int fdd = open("./testft.txt", O_CREAT | O_TRUNC | O_RDWR, 0777);
char *err;
int i = 0;

write(fd, "stringa piena\n", 14);
ft_write(fdd, "stringa piena\n", 14);

write(fd, "!nbyte\n", 0);
ft_write(fdd, "!nbyte\n", 0);

write(fd, "", 1);
ft_write(fdd, "", 1);


int a = write(FOPEN_MAX + 1, "abcdefghijklmnopqrstuvwxyz\n", 27);
	err = strerror(errno);
	while (err[i])
		write(fd, &err[i++], 1); 
	errno = 100;
	i = 0;

int b = ft_write(FOPEN_MAX + 1, "abcdefghijklmnopqrstuvwxyz\n", 27);
	err = strerror(errno);
	while (err[i])
		write(fdd, &err[i++], 1); 
if (a - b == 0)
	OK;
else
	KO;

if (!(system("diff -y --suppress-common-line testr.txt testft.txt")))
	OK;
else
	KO;

puts(YELL"\n TESTING FT_READ "RESET);

char buf[128] = {0};
char ftbuf[128] = {0};
i = 0;

	a = read(fd, buf, 1);
	b = ft_read(fdd, ftbuf, 1);

if ((!strcmp(buf, ftbuf)) && !(a - b))
	OK;
else
	KO;

	a = read(fd, buf, 128);
	b = ft_read(fdd, ftbuf, 128);

if ((!strcmp(buf, ftbuf)) && !(a - b))
	OK;
else
	KO;

	a = read(FOPEN_MAX + 1, buf, 27);
	err = strerror(errno);
	while (err[i])
		write(fd, &err[i++], 1); 
	errno = 100;
	i = 0;

	b = ft_read(FOPEN_MAX + 1, ftbuf, 27);
	err = strerror(errno);
	while (err[i])
		write(fdd, &err[i++], 1);
if (a - b == 0)
	OK;
else
	KO;
if (!(system("diff -y --suppress-common-line testr.txt testft.txt")))
	OK;
else
	KO;

close(fd);
close(fdd);

puts(YELL"\n TESTING FT_STRDUP "RESET);

char *s = "stringa da duplicare""doppia";

if (!strcmp(s, ft_strdup(s)))
	OK;
else
	KO;

s = "stringamoltolungacon molti caratteri anche speciali \n\t\v\b di tutto un po, daje, daje";
if (!strcmp(s, ft_strdup(s)))
	OK;
else
	KO;

s = "";
if (!strcmp(s, ft_strdup(s)))
	OK;
else
	KO;

s = 0;
if (!ft_strdup(s))
	OK;
else
	KO;

if (ac > 1 && !(strcmp(av[1], "-bonus")))
{
	puts(YELL"\n TESTING FT_ATOI_BASE "RESET);

	char *dec = "0123456789";
	char *hex = "0123456789abcdef";

	char *num = "42";
	a = ft_atoi_base(num, dec);
	if ((a - 42) == 0)
		OK;
	else
		KO;
	a = ft_atoi_base(num, hex);
	if ((a - 66) == 0)
		OK;
	else
		KO;
	num = "2147483647";
	a = ft_atoi_base(num, dec);
	if ((a - 2147483647) == 0)
		OK;
	else
		KO;
	num = "-2147483648";
	a = ft_atoi_base(num, dec);
	if ((a  + 2147483648) == 0)
		OK;
	else
		KO;
	num = "0";
	a = ft_atoi_base(num, dec);
	if (!a)
		OK;
	else
		KO;
	a = ft_atoi_base(num, hex);
	if (!a)
		OK;
	else
		KO;
	num = "-21";
	a = ft_atoi_base(num, dec);
	if (a == -21)
		OK;
	else
		KO;
	a = ft_atoi_base(num, hex);
	if (a == -33)
		OK;
	else
		KO;
	num = "7fffffff";
	a = ft_atoi_base(num, hex);
	if ((a - 2147483647) == 0)
		OK;
	else
		KO;
	num = "-80000000";
	a = ft_atoi_base(num, hex);
	if ((a + 2147483648) == 0)
		OK;
	else
		KO;
	a = ft_atoi_base("  \t\n\r\v\f  42", dec);
	if ((a - 42) == 0)
		OK;
	else
		KO;
	a = ft_atoi_base("-+-+-+-42", dec);
	if ((a - 42) == 0)
		OK;
	else
		KO;

	puts(YELL"\n TESTING FT_LIST_SIZE "RESET);

	t_list *tmp = 0;
	t_list *ptr = 0;

	if (!ft_list_size(tmp))
		OK;
	else
		KO;
	tmp = lstnew(dec);
	if ((ft_list_size(tmp)) == 1)
		OK;
	else
		KO;
	ft_lstadd_front(&tmp, lstnew(dec));
	ft_lstadd_front(&tmp, lstnew(dec));

	if ((ft_list_size(tmp)) == 3)
		OK;
	else
		KO;
	ft_lstadd_front(&tmp, lstnew(dec));
	ft_lstadd_front(&tmp, lstnew(dec));
	ft_lstadd_front(&tmp, lstnew(dec));
	ft_lstadd_front(&tmp, lstnew(dec));
	ft_lstadd_front(&tmp, lstnew(dec));
	ft_lstadd_front(&tmp, lstnew(dec));
	if ((ft_list_size(tmp)) == 9)
		OK;
	else
		KO;
	ft_lstclear(&tmp, &free);


	puts(YELL"\n TESTING FT_LIST_PUSH_FRONT"RESET);

	ft_list_push_front(&tmp, dec);
	if (!(strcmp(dec, (char *)tmp->data)))
		OK;
	else
		KO;
	ft_list_push_front(&tmp, hex);
	if (!(strcmp(hex, (char *)tmp->data)))
		OK;
	else
		KO;
	if (!(strcmp(dec, (char *)tmp->next->data)))
		OK;
	else
		KO;
	ptr = 0;
	ft_list_push_front(&ptr, dec);
	if (!(strcmp(ptr->data, dec)))
		OK;
	else
		KO;
	ft_list_push_front(&tmp, num);
	if (!(strcmp(dec, (char *)tmp->next->next->data)))
		OK;
	else
		KO;
	ft_lstclear(&ptr, &free);
	
	puts(YELL"\n TESTING FT_LIST_REMOVE_IF"RESET);
	char c = 0;
	ptr = tmp;
	ft_list_remove_if(&ptr, dec, &strcmp, &free);
	while (1)
	{	
		while (ptr)
		{
			if (!(strcmp(ptr->data, dec)))
			{
				KO;
				c = 1;
				break ;
			}
			ptr = ptr->next;
		}
		if (!c)
			OK;
		break ;
	}
	ptr = tmp;
	ft_list_remove_if(&ptr, hex, &strcmp, &free);
	while (1)
	{	
		while (ptr)
		{
			if (!(strcmp(ptr->data, hex)))
			{
				KO;
				c = 1;
				break ;
			}
			ptr = ptr->next;
		}
		if (!c)
			OK;
		break ;
	}
	ft_lstclear(&ptr, &free);
	ft_lstclear(&tmp, &free);

	puts(YELL"\n TESTING FT_LIST_SORT"RESET);
	tmp = 0;
	ft_lstadd_front(&tmp, lstnew("1"));
	ft_lstadd_front(&tmp, lstnew("4"));
	ft_lstadd_front(&tmp, lstnew("7"));
	ft_lstadd_front(&tmp, lstnew("6"));
	ft_lstadd_front(&tmp, lstnew("5"));
	ft_lstadd_front(&tmp, lstnew("3"));
	ft_lstadd_front(&tmp, lstnew("2"));

	ft_list_sort(&tmp, &strcmp);
	while (tmp->next)
	{
		if (strcmp(tmp->data, tmp->next->data) > 0)
		{
			KO;
			break ;
		}
		tmp = tmp->next;
	}
	if (!tmp->next)
		OK;
	}
}