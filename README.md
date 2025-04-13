#  Design and Implement Context-Free Grammar using FLEX and Bison for Scheme, a minimalist dialect of Lisp

### Non terminal symbols
- NUMBER: Integer literals (42, 123, etc.). 
- STRING: String literals enclosed in in double quotes (“hello”).. 
- IDENTIFIER: Variable names. 
- BOOLEAN: Boolean literals (#t, #f). 
- OPEN_PAREN: Opening parenthesis ‘(’. 
- CLOSE_PAREN: Closing parenthesis ‘)’. 
- IF: Conditional keyword ‘if’. 
- LAMBDA: Anonymous function keyword ‘lambda’. 
- DEFINE: Definition keyword ‘define’. 
- PLUS: Addition operator ‘+’. 
- MINUS: Subtraction operator ‘-’. 
- MUL: Multiplication operator ‘*’. 
- DIV: Division operator ‘/’.

### Context Free Grammar
```
program → expr_list 
expr_list → expr expr_list | ε 
expr → literal | variable | s_expr 
literal → NUMBER | STRING | BOOLEAN 
variable → IDENTIFIER 
s_expr → 	OPEN_PAREN form CLOSE_PAREN 
form → if_expr | lambda_expr | define_expr | math_expr | application 
if_expr → IF expr expr expr 
lambda_expr → LAMBDA param_list expr 
define_expr → DEFINE variable expr 
math_expr → PLUS expr_list | MINUS expr_list | MUL expr_list | DIV expr_list 
application → expr expr_list 
param_list → OPEN_PAREN var_list CLOSE_PAREN 
var_list → variable var_list | ε
```

### Compiling and Running Code
```
bison -d slist.y
flex slist.l
gcc lex.yy.c slist.tab.c -o output
./output < test.txt
```
