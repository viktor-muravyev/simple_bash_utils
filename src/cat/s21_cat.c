#include <errno.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct cat_options_flags {
  int number;
  int number_nonblank;
  int end_line;
  int squeeze_blank;
  int show_tabs;
  int show_nonprinting;
} cat_options_flags;

cat_options_flags get_cat_flags(int argc, char **argv);
void print_files(int argc, char **argv, int optind,
                 cat_options_flags options_flags);
void print_symbol(int ch, cat_options_flags options_flags, int *previous,
                  int *index, int *eline_printed);
int main(int argc, char **argv) {
  cat_options_flags options_flags = get_cat_flags(argc, argv);
  print_files(argc, argv, optind, options_flags);
  return 0;
}

cat_options_flags get_cat_flags(int argc, char **argv) {
  cat_options_flags options_flags = {0};
  const char *short_options = "beEvnstT";
  const struct option long_options[] = {
      {"number-nonblank", no_argument, NULL,
       'b'},  // Number non-empty output lines. This option overrides -n.
      {"show-ends", no_argument, NULL, 'E'},  // Display "$" at end of each line
      {"number", no_argument, NULL, 'n'},     // Number all output lines
      {"squeeze-blank", no_argument, NULL,
       's'},  // Suppress repeated empty output lines
      {"show-tabs", no_argument, NULL, 'T'},  // Display TAB characters as ^I.
      {"show-nonprinting", no_argument, NULL,
       'v'},  // Display non-printing characters so they are visible
      {NULL, 0, NULL, 0}};
  int opt;
  while ((opt = getopt_long(argc, argv, short_options, long_options, NULL)) !=
         -1) {
    switch (opt) {
      case 'n':
        options_flags.number = 1;
        break;
      case 'b':
        options_flags.number_nonblank = 1;
        break;
      case 's':
        options_flags.squeeze_blank = 1;
        break;
      case 'e':  // Equivalent to -vE
        options_flags.end_line = 1;
        options_flags.show_nonprinting = 1;
        break;
      case 't':  // Equivalent to -vT
        options_flags.show_tabs = 1;
        options_flags.show_nonprinting = 1;
        break;
      case 'v':
        options_flags.show_nonprinting = 1;
        break;
      case 'E':
        options_flags.end_line = 1;
        break;
      case 'T':
        options_flags.show_tabs = 1;
        break;
      default:
        printf("usage: 21_cat [-bevnstET] [file ...]\n");
        exit(EXIT_FAILURE);
        break;
    }
  }
  return options_flags;
}

void print_files(int argc, char **argv, int optind,
                 cat_options_flags options_flags) {
  for (int i = optind; i < argc; i++) {
    FILE *file = fopen(argv[i], "r");
    if (file != NULL) {
      int index = 0;
      int eline_printed = 0;
      int ch = fgetc(file);
      int previous = '\n';
      while (ch != EOF) {
        print_symbol(ch, options_flags, &previous, &index, &eline_printed);
        ch = fgetc(file);
      }
      fclose(file);
    } else {
      perror(argv[i]);
    }
  }
}

void print_symbol(int ch, cat_options_flags options_flags, int *previous,
                  int *index, int *eline_printed) {
  if (!(options_flags.squeeze_blank == 1 && *previous == '\n' && ch == '\n' &&
        *eline_printed)) {
    if (*previous == '\n' && ch == '\n') {
      *eline_printed = 1;
    } else
      *eline_printed = 0;
    if (((options_flags.number == 1 && options_flags.number_nonblank == 0) ||
         (options_flags.number_nonblank == 1 && ch != '\n')) &&
        *previous == '\n') {
      *index += 1;
      printf("%6d\t", *index);
    }
    if (options_flags.end_line == 1 && ch == '\n') {
      if (*previous == '\n' && options_flags.number_nonblank == 1)
        printf("      \t$");
      else
        printf("$");
    }
    if (options_flags.show_tabs == 1 && ch == '\t') {
      printf("^");
      ch = '\t' + 64;
    }
    if (options_flags.show_nonprinting == 1) {
      if (ch > 127 && ch < 160) printf("M-^");
      if ((ch < 32 && ch != '\n' && ch != '\t') || ch == 127) printf("^");
      if ((ch < 32 || (ch > 126 && ch < 160)) && ch != '\n' && ch != '\t')
        ch = ch > 126 ? ch - 128 + 64 : ch + 64;
    }
    fputc(ch, stdout);
  }
  *previous = ch;
}