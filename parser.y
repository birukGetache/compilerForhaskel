%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;
extern void displaySymbolTable();
extern FILE *yyin;
extern int yylex();

int yyerror(char *s);

typedef struct {
    char* strval;
    float floatval;
    int intval;
    char charval;
} YYSTYPE;

#define YYSTYPE_IS_DECLARED
%}

%union {
    char* strval;
    float floatval;
    int intval;
    char charval;
    char* expression;
}

%token <strval> identifier STRING_CONST
%token <floatval> FLOAT_CONST
%token <intval> INT_CONST
%token <charval> CHAR_CONST

%token PUTSTRLN IMPORT BREAK STRING_LITERAL DO IF ELSE SEMICOLON COMMA ASSIGN MINUS PLUS MULTIPLY DIVIDE MODULO DOT RIGHTBRACKET LEFTBRACKET IO CASE OF MAIN LEFTBRACE RIGHTBRACE 
%token LESS_THAN LESS_EQUAL GREATER_THAN GREATER_EQUAL EQUALS NOT_EQUALS AND OR NOT BOOL CHAR INT FLOAT VOID STRING LET ARROW CLASS WHERE DOUBLE_COLON LEFTPAREN RIGHTPAREN INSTANCE

%%

program : declaration_list  { printf("Parsing completed !\n"); }
        |
declaration_list : declaration
                 | declaration_list declaration
                 |class_declaration


declaration : class_declaration

class_declaration : CLASS identifier identifier WHERE 



type_specifier : INT
               | CHAR
               | BOOL
               | VOID
               | FLOAT
               | STRING
expression : EQUALS 

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        fprintf(stderr, "Error: could not open file %s\n", argv[1]);
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s,yylineno);
    return 0;
}
