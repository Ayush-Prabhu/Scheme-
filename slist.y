%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char* str;
}

%token <str> ID NUM STR
%token MUL ADD SUB DIV
%type <str> sexpr list members atom

%%

slist:
    sexpr slist_tail  {printf("VALID!");}
  ;

slist_tail:
    /* empty */ { printf("empty slist_tail\n"); }
  | sexpr slist_tail { printf("recursively matched slist_tail\n"); }
  ;

sexpr:
      atom                   { printf("matched atom\n"); }
    | list                   { printf("matched list sexpr\n"); }
    ;

list:
      '(' members ')'        { printf("matched list\n"); }
    | '(' ')'                { printf("matched empty list\n"); }
    ;

members:
      sexpr                  { printf("members 1\n"); }
    | sexpr members          { printf("members 2\n"); }
    ;

atom:
      ID                     { printf("ID\n"); }
    | NUM                    { printf("NUM\n"); }
    | STR                    { printf("STR\n"); }
    | MUL                    { printf("MUL\n"); }
    | ADD                    { printf("ADD\n"); }
    | SUB                    { printf("SUB\n"); }
    | DIV                    { printf("DIV\n"); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter Scheme code:\n");
    yyparse();
    return 0;
}
