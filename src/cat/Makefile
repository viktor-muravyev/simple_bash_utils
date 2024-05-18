CC=gcc
CFLAGS=-Wall -Wextra -Werror

s21_cat:
	$(CC) $(CFLAGS) s21_cat.c -o s21_cat

clean:
	rm s21_cat

leaks:
	leaks -atExit -- ./s21_cat -e -s -b test_1.txt

test:
	bash tests.sh