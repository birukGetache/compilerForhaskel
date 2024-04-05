%{
#include "parser.tab.h"
#include <string.h>
int line_number = 1;

struct symbol_entry {
    char name[50];
    char data_type[20];
    int token_type;
};


struct symbol_entry symbol_table[500];
int symbol_count = 0;

char* token_strings[] = {
    "identifier", "STRING_CONST", "FLOAT_CONST", "INT_CONST", "CHAR_CONST", 
     "IMPORT", "BREAK", "MAP", "DO", "IF", "ELSE", "SEMICOLON", "COMMA",
    "ASSIGN", "MINUS", "PLUS", "MULTIPLY", "DIVIDE", "MODULO", "DOT", "LEFTBRACKET", "RIGHTBRACKET",
    "LEFTPAREN", "RIGHTPAREN", "LEFTBRACE", "RIGHTBRACE", "LESS_THAN", "LESS_EQUAL", "GREATER_THAN", "GREATER_EQUAL",
    "EQUALS", "NOT_EQUALS", "AND", "OR", "NOT", "INT", "FLOAT", "VOID", "STRING","PUTSTRLN","LET","ARROW","CLASS"
    "WHERE", "DOUBLE_COLON","MAIN","NEWLINE","BOOL","INSTANCE","DATA","DOLAR","THEN"
};

int search_symbol_table(char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0)
            return symbol_table[i].token_type; // Return token if found
    }
    return -1; // Return -1 if not found
}

// Function to add an entry to the symbol table
void add_to_symbol_table(char *name, int token) {
    strcpy(symbol_table[symbol_count].name, name);
    symbol_table[symbol_count].token_type = token;

    symbol_count++;
}

void displaySymbolTable() {
    printf("Symbol Table:\n");
    printf("------------------------------------------------\n");
    printf("%-20s | %-15s | %-10s\n", "Name", "Data Type", "Token Type");
    printf("--------------\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("%-20s | %-15s | %-10d\n", symbol_table[i].name, symbol_table[i].data_type, symbol_table[i].token_type);
    }
    printf("------------------------------------------------\n");
}

%}

%option yylineno

%%
"import"                { return IMPORT; }
"$"                      {return DOLAR;}
"data"                  {return DATA;}
 "main"                  {return MAIN;}
 "then"                  {return THEN;}
 "IO"                    {return IO;}
 "class"                 {return CLASS;}
 "where"                 {return WHERE;}
"break"                 { return BREAK; }
"do"                    { return DO; }
"if"                    { return IF; }
"else"                  { return ELSE; }
"putStrLn"               { return PUTSTRLN; }
"instance"               {return INSTANCE;}
","                     { return COMMA; }
"="                     { return ASSIGN; }
"-"                     { return MINUS; }
"+"                     { return PLUS; }
"*"                     { return MULTIPLY; }
"/"                     { return DIVIDE; }
"mod"                     { return MODULO; }
"::"                    {return DOUBLE_COLON;}
"."                     { return DOT; }
"["                     { return LEFTBRACKET; }
"]"                     { return RIGHTBRACKET; }
"("                     { return LEFTPAREN; }
")"                     { return RIGHTPAREN; }
"<"                     { return LESS_THAN; }
"<="                    { return LESS_EQUAL; }
">"                     { return GREATER_THAN; }
">="                    { return GREATER_EQUAL; }
"=="                    { return EQUALS; }
"!="                    { return NOT_EQUALS; }
"&&"                    { return AND; }
"||"                    { return OR; }
"->"                    {return ARROW;}
"!"                     { return NOT; }
"Integer"                   { strcpy(symbol_table[symbol_count].data_type, "int"); return INT; }
"Bool"                  {strcpy(symbol_table[symbol_count].data_type, "bool"); return BOOL; }
"Float"                 { strcpy(symbol_table[symbol_count].data_type, "float"); return FLOAT; }
"void"                  { strcpy(symbol_table[symbol_count].data_type, "void"); return VOID; }
"String"                { strcpy(symbol_table[symbol_count].data_type, "String"); return STRING; }
"let"                   {strcpy(symbol_table[symbol_count].data_type, "let"); return LET;}
[a-zA-Z_][a-zA-Z0-9_]*  {

    int values = search_symbol_table(yytext);
    if (values == -1) {
        add_to_symbol_table(yytext, identifier);
        return identifier; // Return IDENTIFIER token
    } else {
        return identifier; // Return type of the identifier
    }
}

[0-9]+\.[0-9]+          { yylval.floatval = atof(yytext); return FLOAT_CONST; }
[0-9]+                  { yylval.intval = atoi(yytext); return INT_CONST; }
\"[^"]*\"               { yylval.strval = strdup(yytext); return STRING_CONST; }
'.'                     { yylval.charval = yytext[1]; return CHAR_CONST; }
\n              {}
\s          {}
\"[a-zA-Z]?\"(\\.|[^\\"])*\"        {  return STRING_LITERAL; }

%%

int yywrap() {
    displaySymbolTable(); // Call displaySymbolTable at the end of processing
    return 1; // Indicate that there are no more input files to process
}
