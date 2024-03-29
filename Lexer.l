%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
extern int yyparse();
extern int yylex(); // Declare the lexer function
extern FILE* yyin; // Declare the input file pointer
%}

%%


[ \t\n]+                        /* Ignore whitespace */

"if"                            { yylval = IF; return IDENTIFIER; }
"then"                          { yylval = THEN; return IDENTIFIER; }
"else"                          { yylval = ELSE; return IDENTIFIER; }
"let"                           { yylval = LET; return IDENTIFIER; }
"in"                            { yylval = IN; return IDENTIFIER; }
"case"                          { yylval = CASE; return IDENTIFIER; }
"of"                            { yylval = OF; return IDENTIFIER; }
"where"                         { yylval = WHERE; return IDENTIFIER; }
"do"                            { yylval = DO; return IDENTIFIER; }

[0-9]+                          { yylval = atoi(yytext); return INTEGER; }
[a-zA-Z_][a-zA-Z0-9_']*         { yylval = strdup(yytext); return IDENTIFIER; }
"+"                             { return PLUS; }
"-"                             { return MINUS; }
"*"                             { return MULTIPLY; }
"/"                             { return DIVIDE; }
"=="                            { return EQUALS; }
"!="                            { return NOT_EQUALS; }
"<"                             { return LESS_THAN; }
"<="                            { return LESS_THAN_OR_EQUAL; }
">"                             { return GREATER_THAN; }
">="                            { return GREATER_THAN_OR_EQUAL; }
"&&"                            { return AND; }
"||"                            { return OR; }
"not"                           { return NOT; }

"("                             { return LPAREN; }
")"                             { return RPAREN; }
"{"                             { return LBRACE; }
"}"                             { return RBRACE; }
"["                             { return LBRACKET; }
"]"                             { return RBRACKET; }
";"                             { return SEMICOLON; }
","                             { return COMMA; }
":"                             { return COLON; }
"::"                            { return TYPE_SEPARATOR; }
"="                             { return ASSIGN; }
"->"                            { return ARROW; }
"|"                             { return PIPE; }
"_"                             { return WILDCARD; }

.                               { return UNKNOWN; }

%%

int yywrap() {
    return 1;
}


int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    // Open the input file
    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Error: Unable to open input file %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }

    // Call the lexer
    yylex();

    // Close the input file
    fclose(yyin);

    // Reopen the input file for the parser
    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Error: Unable to open input file %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }

    // Call the parser
    yyparse();

    // Close the input file
    fclose(yyin);

    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}