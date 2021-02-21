
#		-*- Makefile -*-	#

NAME		=	libasm.a
INC			=	libasm.h
CC			=	gcc
NA			=	nasm -f macho64

SRCS		=	./srcs/ft_read.s \
				./srcs/ft_write.s  \
				./srcs/ft_strlen.s \
				./srcs/ft_strcmp.s \
				./srcs/ft_strdup.s \
				./srcs/ft_strcpy.s \
				./srcs/ft_atoi_base_bonus.s \
				./srcs/ft_list_push_front_bonus.s \
				./srcs/ft_list_size_bonus.s \
				./srcs/ft_list_remove_if.s \
				./srcs/ft_list_sort.s

OBJS		=	$(SRCS:.s=.o)


.PHONY:		make clean fclean re test bonus alltest

%.o:%.s
	$(NA) $<

all:	$(NAME)

$(NAME):	$(OBJS)
		ar rcs $(NAME) $(OBJS)

test:
	@echo "\033[0;32m Running tests..."
	@gcc	main.c $(NAME) && ./a.out
	@rm -rf a.out testr.txt testft.txt
	@echo "\033[0m"

alltest:
	@echo "\033[0;32m Running AllTests..."
	@gcc main.c $(NAME) && ./a.out -bonus
	@rm -rf a.out testr.txt testft.txt
	@echo "\033[0m"

clean:
	@echo "\033[0;31mCleaning..."
	rm -rf $(OBJS) $(BOJS)
	@echo "\033[0m"

fclean:		clean
	@echo "\033[0;31mRemoving library"
	rm -rf $(NAME)
	@echo "\033[0m"

re:		fclean all

bonus:	re