%{
#include "slist.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"("                      { return OPEN_PAREN; }
")"                      { return CLOSE_PAREN; }
"if"                     { return IF; }
"lambda"                 { return LAMBDA; }
"define"                 { return DEFINE; }

"+"                      { return PLUS; }
"-"                      { return MINUS; }
"*"                      { return STAR; }
"/"                      { return SLASH; }

[0-9]+                   { 
                             yylval.ival = atoi(yytext);
                             return NUMBER; 
                         }

\"([^\\"]|\\.)*\"        {
                             yylval.sval = strdup(yytext);
                             return STRING; 
                         }

"#t"                    { return BOOLEAN; }
"#f"                    { return BOOLEAN; }

[a-zA-Z_][a-zA-Z0-9_]*   { 
                             yylval.sval = strdup(yytext);
                             return IDENTIFIER; 
                         }

[ \t\n\r]+              { /* skip whitespace */ }

<<EOF>>                 { return 0; }

.                       { printf("Unknown character: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}
