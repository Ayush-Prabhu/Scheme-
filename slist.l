%{
#include <stdio.h>
#include "slist.tab.h"
%}

ID      [a-zA-Z_][a-zA-Z_0-9]*
NUM     [0-9]+
STR     \"([^\"]|\\\")*\"
OPERATOR [\+\-\*\/]  // Define operator token

%%

{ID}    { yylval.str = strdup(yytext); return ID; }
{NUM}   { yylval.str = strdup(yytext); return NUM; }
{STR}   { yylval.str = strdup(yytext); return STR; }

"+"     { return ADD; }   // Return ADD token for "+"
"-"     { return SUB; }   // Return SUB token for "-"
"*"     { return MUL; }   // Return MUL token for "*"
"/"     { return DIV; }   // Return DIV token for "/"

"("     { return '('; }
")"     { return ')'; }

[ \t\n]+ ;  // Skip whitespace
.       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
