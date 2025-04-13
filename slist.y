%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern int yylex();
  void yyerror(const char *s);
%}

%union {
    int ival;
    char* sval;
}


%token <ival> NUMBER
%token <sval> STRING
%token <sval> IDENTIFIER
%token BOOLEAN
%token OPEN_PAREN CLOSE_PAREN
%token IF LAMBDA DEFINE
%token PLUS MINUS MUL DIV

%%

/* Start symbol now does not explicitly expect the END token */
program:
      expr_list
          { 
            printf("Matched production: program -> expr_list\n"); 
            printf("Input accepted.\n"); 
          }
    ;

/* expr_list can be empty or a sequence of expressions */
expr_list:
      /* empty */
          { printf("Matched production: expr_list -> empty\n"); }
    | expr expr_list 
          { printf("Matched production: expr_list -> expr expr_list\n"); }
    ;

/* An expression can be a literal, variable, or an S-expression */
expr:
      literal 
          { printf("Matched production: expr -> literal\n"); }
    | variable 
          { printf("Matched production: expr -> variable\n"); }
    | s_expr 
          { printf("Matched production: expr -> s_expr\n"); }
    ;

/* Literals: numbers, strings, or booleans */
literal:
      NUMBER 
          { printf("Matched production: literal -> NUMBER\n"); }
    | STRING 
          { printf("Matched production: literal -> STRING\n"); }
    | BOOLEAN 
          { printf("Matched production: literal -> BOOLEAN\n"); }
    ;

/* A variable is an identifier */
variable:
      IDENTIFIER 
          { printf("Matched production: variable -> IDENTIFIER\n"); }
    ;

/* An S-expression wraps a form between parentheses */
s_expr:
      OPEN_PAREN form CLOSE_PAREN 
          { printf("Matched production: s_expr -> OPEN_PAREN form CLOSE_PAREN\n"); }
    ;

/* A form can be one of several constructs */
form:
      if_expr 
          { printf("Matched production: form -> if_expr\n"); }
    | lambda_expr 
          { printf("Matched production: form -> lambda_expr\n"); }
    | define_expr 
          { printf("Matched production: form -> define_expr\n"); }
    | math_expr 
          { printf("Matched production: form -> math_expr\n"); }
    | application 
          { printf("Matched production: form -> application\n"); }
    ;

/* if-expression: (if test consequent alternative) */
if_expr:
      IF expr expr expr 
          { printf("Matched production: if_expr -> IF expr expr expr\n"); }
    ;

/* Lambda expression: (lambda (parameters) body) */
lambda_expr:
      LAMBDA param_list expr 
          { printf("Matched production: lambda_expr -> LAMBDA param_list expr\n"); }
    ;

/* Definition: (define identifier value) */
define_expr:
      DEFINE variable expr 
          { printf("Matched production: define_expr -> DEFINE variable expr\n"); }
    ;

/* Math expression: an operator with a list of operands */
math_expr:
      PLUS expr_list 
          { printf("Matched production: math_expr -> PLUS expr_list\n"); }
    | MINUS expr_list 
          { printf("Matched production: math_expr -> MINUS expr_list\n"); }
    | MUL expr_list 
          { printf("Matched production: math_expr -> MUL expr_list\n"); }
    | DIV expr_list 
          { printf("Matched production: math_expr -> DIV expr_list\n"); }
    ;

/* Application: a function applied to a list of arguments */
application:
      expr expr_list 
          { printf("Matched production: application -> expr expr_list\n"); }
    ;

/* Parameter list for lambda expressions */
param_list:
      OPEN_PAREN var_list CLOSE_PAREN 
          { printf("Matched production: param_list -> OPEN_PAREN var_list CLOSE_PAREN\n"); }
    ;

/* List of variables (parameters) may be empty or one or more */
var_list:
      /* empty */
          { printf("Matched production: var_list -> empty\n"); }
    | variable var_list 
          { printf("Matched production: var_list -> variable var_list\n"); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
