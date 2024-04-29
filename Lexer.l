%{
#include "parser.tab.h"
#include <string.h>
#include <stdbool.h> // Include the standard library for boolean types

int line_number = 1;
char func_main[10] = "";
struct symbol_entry {
    char name[50];
    char data_type[20];
    int token_type;
    int scope;
    union {
        char char_value[45];
        int int_value;
    } values;
    int line_of_reference;
    int line_of_usage; 
    int address; 
};


// Array to store encountered tokens
char encountered_tokens[500][50]; // Assuming max 500 tokens with a maximum length of 50 characters
int encountered_token_count = 0;
struct symbol_entry symbol_table[500];
int symbol_count = 0;

char* token_strings[] = {
    "identifier", "STRING_CONST", "FLOAT_CONST", "INT_CONST", "CHAR_CONST", 
    "IMPORT", "BREAK", "MAP", "DO", "IF", "ELSE", "SEMICOLON", "COMMA",
    "ASSIGN", "MINUS", "PLUS", "MULTIPLY", "DIVIDE", "MODULO", "DOT", "LEFTBRACKET", "RIGHTBRACKET",
    "LEFTPAREN", "RIGHTPAREN", "LEFTBRACE", "RIGHTBRACE", "LESS_THAN", "LESS_EQUAL", "GREATER_THAN", "GREATER_EQUAL",
    "EQUALS", "NOT_EQUALS", "AND", "OR", "NOT", "INT", "FLOAT", "VOID", "STRING", "PUTSTRLN", "LET", "ARROW", "CLASS",
    "WHERE", "DOUBLE_COLON", "MAIN", "NEWLINE", "BOOL", "INSTANCE", "DATA", "DOLAR", "THEN", "BAR", "SHOW"
};

int search_symbol_table(char *name) {
    int matching_scopes[100]; // Assuming a maximum of 100 matches
int count = 0; // Counter for the number of matches
int checks = 0;
for (int i = 0; i < symbol_count; i++) {
    bool scope_exists = false;
    if (strcmp(symbol_table[i].name, name) == 0) {
        matching_scopes[count] = symbol_table[i].scope;
        count++;
    }
    checks = 0; // Reset checks for each symbol table entry
    for (int j = 0; j < count; j++) {
        if (symbol_table[i].scope == matching_scopes[j]) {
            checks++;
        }
    }
}

return checks;
}


// Function to check if a token has been encountered
bool has_encountered_token(char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(encountered_tokens[i], name) == 0)
            return true; // Token has been encountered
    }
    return false; // Token not encountered
}
void add_to_encountered_tokens(char *name) {
    strcpy(encountered_tokens[encountered_token_count], name);
    encountered_token_count++;
}
 int scope = 0;
int start=0;
// Function to display the encountered tokens array
void displayEncounteredTokens() {
    printf("Encountered Tokens:\n");
    printf("------------------------------------------\n");
    for (int index = 0; index < symbol_count; index++) {
        char *LexemeBegin = encountered_tokens[index];
        char *scopeCounter = 1;
        if((strcmp(LexemeBegin, "LET") == 0)||(strcmp(LexemeBegin, "STRING")==0)||(strcmp(LexemeBegin, "Integer")==0)||(strcmp(LexemeBegin, "Float")==0) ){
            // Check subsequent tokens declared with "LET" for redeclaration
            char *forward = encountered_tokens[index+1];
            char *data = encountered_tokens[index + 1];
            char *secondata = encountered_tokens[index + 3];
            
            for (int checker = 0; checker < index; checker++) {
                if (strcmp(forward, encountered_tokens[checker]) == 0 ) {
                    int isrepeated = search_symbol_table(forward);
                    if(isrepeated>=2){
printf("Semantic Error: '%s' is declared more than once.\n", encountered_tokens[index + 1]);
  printf("%d",yylineno);
                    }

    

                }
            }
        } 
    }
    printf("------------------------------------------\n");
}
void display() {
    
}
    int valuesetter = 0;
    int path = 0;//do not set variable declaration in function
    int ok = 0;
     int cap = 0;
    int checks = 0; // Static variable to retain its value between function calls
     char* nameactual = NULL; 
// Function to add an entry to the symbol table
void add_to_symbol_table(char *name, int token) {
      char* mainc = symbol_table[symbol_count - 1].name;
  if ((strcmp(name, "=") == 0) && (strcmp(mainc, "main") != 0)) {
        char *stringtocheck = symbol_table[symbol_count - 2].name;
        if (strcmp(stringtocheck, "LET") != 0) {
            nameactual = symbol_table[symbol_count - 1].name;
                 checks = symbol_table[symbol_count-1].scope; 
    for (int i = 0; i < symbol_count; i++) {

        if(symbol_table[i].scope == checks) {
              if (strcmp(symbol_table[i].name, nameactual) == 0) {
                ok=1;
              }
          }
      
        }
           if((ok==1)){
            printf("Error: ");
            printf("undeclared variable in line ");
                printf("%d",yylineno);
            
         }
        }
        // Set checks to 1 after encountering "="
    }
  
    if((name == "+")||(name=="-")||(name=="*")||(name=="/")) {
        cap = symbol_count-1;
        path = symbol_count + 1;
    }
    if((cap != 0)&&(path !=0)) {
        char character1= symbol_table[cap].token_type;
        char character2 = symbol_table[path].token_type;
        if(character1!=character2){
      printf("you are operated invalids at line");
      printf("%d",yylineno);
    

        }
    
    }

    strcpy(symbol_table[symbol_count].name, name);
    symbol_table[symbol_count].token_type = token;

    if (strcmp(name, "::") == 0) {
        scope++;

    }

    symbol_table[symbol_count].scope = scope;

    symbol_count++;
}


void displaySymbolTable() {
    printf("Symbol Table:\n");
    printf("-------------------------------------------------------------------------------------------------------------\n");
    printf("%-20s | %-15s | %-10s | %-5s \n",  "Name", "Data Type", "Token Type","Scope");
    printf("------------------------------------------------------------------------------------------------------------\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("%-20s | %-15s | %-10d | %-5d\n", symbol_table[i].name, symbol_table[i].data_type, symbol_table[i].token_type,symbol_table[i].scope );
    }
    printf("-------------------------------------------------------------------------------------------------------------\n");
}

%}

%option yylineno

%%
"import"                {add_to_symbol_table("import",3); add_to_encountered_tokens("import"); return IMPORT; }
"$"                      {add_to_symbol_table("$",3); add_to_encountered_tokens("$");return DOLAR;}
"data"                  {add_to_symbol_table("data",3); add_to_encountered_tokens("data");return DATA;}
"main"                  {add_to_symbol_table("main",3); add_to_encountered_tokens("main");return MAIN;}
"then"                  {add_to_symbol_table("then",3);add_to_encountered_tokens("then");return THEN;}
"IO"                    {add_to_symbol_table("IO",3); add_to_encountered_tokens("IO");return IO;}
"class"                 {add_to_symbol_table("class",3);add_to_encountered_tokens("class");return CLASS;}
"where"                 {add_to_symbol_table("where",3);add_to_encountered_tokens("where");return WHERE;}
"break"                 { add_to_symbol_table("break",3);add_to_encountered_tokens("break");return BREAK; }
"|"                     {add_to_symbol_table("BAR","bar");add_to_encountered_tokens("|");return BAR;}
"show"                  {add_to_symbol_table("show","show");add_to_encountered_tokens("show");return  SHOW;}
"do"                    {add_to_symbol_table("do",3); add_to_encountered_tokens("do");return DO; }
"if"                    {add_to_symbol_table("if",3); add_to_encountered_tokens("if");return IF; }
"else"                  { add_to_symbol_table("else",3);add_to_encountered_tokens("else");return ELSE; }
"putStrLn"              { add_to_symbol_table("putStrLn",3);add_to_encountered_tokens("putStrLn");return PUTSTRLN; }
"instance"              {add_to_symbol_table("instance",3);add_to_encountered_tokens("instance");return INSTANCE;}
","                     {add_to_symbol_table(",",3); add_to_encountered_tokens(",");return COMMA; }
"="                     {add_to_symbol_table("=",3); add_to_encountered_tokens("=");return ASSIGN; }
"-"                     {add_to_symbol_table("-",3);add_to_encountered_tokens("-"); return MINUS; }
"+"                     {add_to_symbol_table("+",3); add_to_encountered_tokens("+");return PLUS; }
"*"                     {add_to_symbol_table("*",3); add_to_encountered_tokens("*");return MULTIPLY; }
"/"                     {add_to_symbol_table("/",3); add_to_encountered_tokens("/");return DIVIDE; }
"mod"                   {add_to_symbol_table("mod",3);add_to_encountered_tokens("mod"); return MODULO; }
"::"                    {add_to_symbol_table("::", DOUBLE_COLON);  add_to_encountered_tokens("::");
                        return DOUBLE_COLON;}
"."                     {add_to_symbol_table(".",3); add_to_encountered_tokens(".");return DOT; }
"["                     {add_to_symbol_table("[",3); add_to_encountered_tokens("[");return LEFTBRACKET; }
"]"                     {add_to_symbol_table("]",3);add_to_encountered_tokens("]"); return RIGHTBRACKET; }
"("                     {add_to_symbol_table("(",3); add_to_encountered_tokens("(");return LEFTPAREN; }
")"                     {add_to_symbol_table(")",3); add_to_encountered_tokens(")");return RIGHTPAREN; }
"<"                     {add_to_symbol_table("<",3);add_to_encountered_tokens("<"); return LESS_THAN; }
"<="                    {add_to_symbol_table("<=",3); add_to_encountered_tokens("<=");return LESS_EQUAL; }
">"                     {add_to_symbol_table(">",3); add_to_encountered_tokens(">");return GREATER_THAN; }
">="                    {add_to_symbol_table(">=",3);add_to_encountered_tokens(">="); return GREATER_EQUAL; }
"=="                    {add_to_symbol_table("==",3);add_to_encountered_tokens("=="); return EQUALS; }
"!="                    {add_to_symbol_table("!=",3);add_to_encountered_tokens("!="); return NOT_EQUALS; }
"&&"                    {add_to_symbol_table("&&",3);add_to_encountered_tokens("&&"); return AND; }
"||"                    {add_to_symbol_table("or",3);add_to_encountered_tokens("||"); return OR; }
"->"                    {add_to_symbol_table("->",3); add_to_encountered_tokens("->");return ARROW;}
"!"                     {add_to_symbol_table("!",3);add_to_encountered_tokens("!"); return NOT; }
"Integer"               {add_to_symbol_table("INTEGER",3); add_to_encountered_tokens("INTEGER");strcpy(symbol_table[symbol_count].data_type, "int"); return INT; }
"Bool"                  {add_to_symbol_table("BOOL",3); add_to_encountered_tokens("BOOL");strcpy(symbol_table[symbol_count].data_type, "bool"); return BOOL; }
"Float"                 {add_to_symbol_table("FLOAT",3);add_to_encountered_tokens("FLOAT"); strcpy(symbol_table[symbol_count].data_type, "float"); return FLOAT; }
"void"                  {add_to_symbol_table("void",3); add_to_encountered_tokens("void");strcpy(symbol_table[symbol_count].data_type, "void"); return VOID; }
"String"                { add_to_symbol_table("STRING",3);add_to_encountered_tokens("STRING"); strcpy(symbol_table[symbol_count].data_type, "String"); return STRING; }
"let"                   {add_to_symbol_table("LET",3);add_to_encountered_tokens("LET"); strcpy(symbol_table[symbol_count].data_type, "let"); return LET; }
[a-zA-Z_][a-zA-Z0-9_]*  {
    int values = -1;
    if (values == -1 && !has_encountered_token(yytext)) {
        add_to_symbol_table(yytext, identifier);
        add_to_encountered_tokens(yytext);
        return identifier; // Return IDENTIFIER token
    } else {
        add_to_symbol_table(yytext, identifier);
        add_to_encountered_tokens(yytext);
        return identifier; // Return type of the identifier
    }
}

[0-9]+\.[0-9]+          {add_to_symbol_table(yytext,6); add_to_encountered_tokens(yytext); yylval.floatval = atof(yytext); return FLOAT_CONST; }
[0-9]+                  {add_to_symbol_table(yytext,6); add_to_encountered_tokens(yytext); yylval.intval = atoi(yytext); return INT_CONST; }
\"[^"]*\"               {add_to_symbol_table(yytext,5); add_to_encountered_tokens(yytext); yylval.strval = strdup(yytext); return STRING_CONST; }
'.'                     {add_to_symbol_table(yytext,5); add_to_encountered_tokens(yytext); yylval.charval = yytext[1]; return CHAR_CONST; }
\n                      {}
\s                      {}
\"[a-zA-Z]?\"(\\.|[^\\"])*\"        { return STRING_LITERAL; }

%%

int yywrap() {
    displaySymbolTable(); // Call displaySymbolTable at the end of processing
    displayEncounteredTokens(); // Call displayEncounteredTokens at the end of processin
    return 1; // Indicate that there are no more input files to process
}
