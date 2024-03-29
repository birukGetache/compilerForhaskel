%{
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
void yyerror(const char *s);
extern FILE *yyin;
int yyparse(void);

#define YY_DECL int yylex(void)

#define YY_FATAL_ERROR(msg) fprintf(stderr, "%s\n", msg)

#define YY_INPUT(buf, result, max_size) \
    result = fread(buf, 1, max_size, yyin)

#define YY_NULL 0

#define YY_FATAL_ERROR(msg) fprintf(stderr, "%s\n", msg)

#define YY_USER_ACTION

#define YY_BREAK return 0

#define YY_USER_INIT

#define YY_USER_ACTION

#define YY_REJECT

#define YY_MORE_ADJ 0

#define YY_RESTORE_LEX

#define YY_RESTORE_YY_MORE_OFFSET

#define YY_USER_INIT

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION

#define YY_USER_ACTION
%}

%token IF THEN ELSE LET IN CASE OF WHERE DO
%token INTEGER IDENTIFIER
%token PLUS MINUS MULTIPLY DIVIDE
%token EQUALS NOT_EQUALS LESS_THAN LESS_THAN_OR_EQUAL GREATER_THAN GREATER_THAN_OR_EQUAL
%token AND OR NOT
%token LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET SEMICOLON COMMA COLON TYPE_SEPARATOR
%token ASSIGN ARROW PIPE WILDCARD
%token COMMENT
%token UNKNOWN

%%

program:
    statements
    ;

statements:
    statement
    | statements statement
    ;

statement:
    IF
    | THEN
    | ELSE
    | LET
    | IN
    | CASE
    | OF
    | WHERE
    | DO
    | INTEGER
    | IDENTIFIER
    | PLUS
    | MINUS
    | MULTIPLY
    | DIVIDE
    | EQUALS
    | NOT_EQUALS
    | LESS_THAN
    | LESS_THAN_OR_EQUAL
    | GREATER_THAN
    | GREATER_THAN_OR_EQUAL
    | AND
    | OR
    | NOT
    | LPAREN
    | RPAREN
    | LBRACE
    | RBRACE
    | LBRACKET
    | RBRACKET
    | SEMICOLON
    | COMMA
    | COLON
    | TYPE_SEPARATOR
    | ASSIGN
    | ARROW
    | PIPE
    | WILDCARD
    | COMMENT
    | UNKNOWN
    ;

%%
void yyerror(const char *s);
