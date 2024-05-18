#include <errno.h>
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct grep_options_flags {
  int e;  // pattern
  int i;  // Ignore uppercase vs. lowercase
  int v;  // Invert match
  int c;  // Output count of matching lines only
  int l;  // Output matching files only
  int n;  // Precede each matching line with a line number
  int h;  // Output matching lines without preceding them by file names
  int s;  // Suppress error messages about nonexistent or unreadable files
  int f;  // -f file Take regexes from a file
  int o;  // Output the matched parts of a matching line
} grep_options_flags;

void process_grep_flags(grep_options_flags *options_flags, int argc,
                        char **argv, regex_t *regex);
void add_new_patterns(char *grep_patterns, char *new_pattern);
void add_patterns_from_file(char *grep_patterns, char *file_name);
void print_line(char *path_file, char *line, regex_t *regex,
                grep_options_flags *options_flags, int *line_number,
                int *line_count);
void print_matched(char *path_file, char *line, regex_t *regex,
                   grep_options_flags *options_flags, int *line_number);
void print_files(int argc, char **argv, grep_options_flags *get_grep_flags,
                 regex_t *regex);

int main(int argc, char **argv) {
  if (argc > 2) {
    grep_options_flags options_flags = {0};
    regex_t regex;
    process_grep_flags(&options_flags, argc, argv, &regex);
    print_files(argc, argv, &options_flags, &regex);
    regfree(&regex);
  } else {
    printf("usage: 21_grep [-chilnosv] [-e pattern] [-f file] [file ...]\n");
  }
  return 0;
}

void process_grep_flags(grep_options_flags *options_flags, int argc,
                        char **argv, regex_t *regex) {
  char grep_patterns[4096] = "\0";
  const char *short_options = "e:civlnhsf:o";
  int opt;
  const struct option long_options[] = {{NULL, 0, NULL, 0}};
  while ((opt = getopt_long(argc, argv, short_options, long_options, NULL)) !=
         -1) {
    switch (opt) {
      case 'e':
        options_flags->e = 1;
        add_new_patterns(grep_patterns, optarg);
        break;
      case 'i':
        options_flags->i = REG_ICASE;
        break;
      case 'v':
        options_flags->v = 1;
        break;
      case 'c':
        options_flags->c = 1;
        break;
      case 'l':
        options_flags->l = 1;
        break;
      case 'n':
        options_flags->n = 1;
        break;
      case 'h':
        options_flags->h = 1;
        break;
      case 's':
        options_flags->s = 1;
        break;
      case 'f':
        options_flags->f = 1;
        options_flags->e = 1;
        add_patterns_from_file(grep_patterns, optarg);
        break;
      case 'o':
        options_flags->o = 1;
        break;
      default:
        printf(
            "usage: 21_grep [-chilnosv] [-e pattern] [-f file] [file ...]\n");
        exit(EXIT_FAILURE);
        break;
    }
  }
  if (options_flags->e == 0) {
    strcat(grep_patterns, argv[optind]);
    optind++;
  }
  if ((argc - optind) == 1) options_flags->h = 1;
  regcomp(regex, grep_patterns, options_flags->i | REG_EXTENDED);
}

void add_new_patterns(char *grep_patterns, char *new_pattern) {
  char buffer[4096];
  if (strlen(grep_patterns) == 0) {
    sprintf(buffer, "(%s)", new_pattern);
    strcat(grep_patterns, buffer);
  } else {
    strcat(grep_patterns, "|");
    sprintf(buffer, "(%s)", new_pattern);
    strcat(grep_patterns, buffer);
  }
}

void add_patterns_from_file(char *grep_patterns, char *file_name) {
  char buffer[4096];
  FILE *file;
  file = fopen(file_name, "r");
  if (file != NULL) {
    while (fgets(buffer, 4096, file) != NULL) {
      size_t n = strlen(buffer);
      if (buffer[n - 1] == '\n') buffer[n - 1] = '\0';
      add_new_patterns(grep_patterns, buffer);
    }
  } else
    perror(file_name);
}

void print_matched(char *path_file, char *line, regex_t *regex,
                   grep_options_flags *options_flags, int *line_number) {
  regmatch_t match;
  int shift = 0;
  while (1) {
    int rez_regexec = regexec(regex, line + shift, 1, &match, 0);
    if (rez_regexec != 0)
      break;
    else {
      if (options_flags->h == 0) printf("%s:", path_file);
      if (options_flags->n == 1) printf("%d:", *line_number);
      for (int i = match.rm_so; i < match.rm_eo; i++) {
        printf("%c", line[i + shift]);
      }
    }
    printf("\n");
    shift = shift + match.rm_eo;
  }
}

void print_line(char *path_file, char *line, regex_t *regex,
                grep_options_flags *options_flags, int *line_number,
                int *line_count) {
  int rez_regexec = regexec(regex, line, 0, NULL, 0);
  int last = strlen(line);
  if ((rez_regexec == 0 && options_flags->v == 0) ||
      (rez_regexec != 0 && options_flags->v == 1)) {
    (*line_count)++;
    if (options_flags->c == 0 && options_flags->l == 0) {
      if (options_flags->h == 0) printf("%s:", path_file);
      if (options_flags->n == 1) printf("%d:", *line_number);
      printf("%s", line);
      if (line[last - 1] != '\n') printf("\n");
    }
  }
}

void print_files(int argc, char **argv, grep_options_flags *options_flags,
                 regex_t *regex) {
  char buffer[4096];
  for (int i = optind; i < argc; i++) {
    FILE *file = fopen(argv[i], "r");
    if (file != NULL) {
      int line_number = 0;
      int line_count = 0;
      while (fgets(buffer, 4096, file) != NULL) {
        line_number++;
        if (options_flags->o == 1 && options_flags->v == 0 &&
            options_flags->c == 0 && options_flags->l == 0) {
          print_matched(argv[i], buffer, regex, options_flags, &line_number);
        } else {
          print_line(argv[i], buffer, regex, options_flags, &line_number,
                     &line_count);
        }
      }
      if (options_flags->c == 1 && options_flags->l == 0) {
        if (options_flags->h == 0) printf("%s:", argv[i]);
        printf("%d\n", line_count);
      }
      if (options_flags->l == 1) {
        if (options_flags->c == 1) {
          if (options_flags->h == 0) printf("%s:", argv[i]);
          printf("%d\n", (line_count) ? 1 : 0);
        }
        if (line_count) printf("%s\n", argv[i]);
      }
      fclose(file);
    } else {
      if (!options_flags->s) perror(argv[i]);
    }
  }
}
