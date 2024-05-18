CC=gcc
CFLAGS=-Wall -Wextra -Werror

s21_grep:
	$(CC) $(CFLAGS) s21_grep.c -o s21_grep

clean:
	rm s21_grep

leaks:
	leaks -atExit -- ./s21_grep -e case -f test_patterns.txt -inh test_1.txt test_2.txt

test:
	bash tests.sh