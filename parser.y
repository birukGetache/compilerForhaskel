%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;
extern FILE *yyin;
extern int yylex();

int yyerror(char *s);

typedef struct {
    char* strval;
    float floatval;
    int intval;
    char charval;
} YYSTYPE;

extern char encountered_tokens[500][50];

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

%token PUTSTRLN IMPORT BREAK STRING_LITERAL DO IF ELSE SEMICOLON COMMA ASSIGN MINUS PLUS MULTIPLY DIVIDE MODULO DOT RIGHTBRACKET LEFTBRACKET IO CASE OF MAIN LEFTBRACE RIGHTBRACE DOLAR THEN SHOW
%token LESS_THAN LESS_EQUAL GREATER_THAN GREATER_EQUAL EQUALS NOT_EQUALS AND OR NOT BOOL CHAR INT FLOAT VOID STRING LET ARROW CLASS WHERE DOUBLE_COLON LEFTPAREN RIGHTPAREN INSTANCE DATA BAR

%%

program : declaration_list  { printf("Parsing completed !\n"); }
        | function_declaration
        |main_method
declaration_list :class_declaration

function_declaration : identifier DOUBLE_COLON 

mainMethod : MAIN 

typeForProgram: type_specifier ARROW typeForProgram 
              |type_specifier
              |

func_statement :identifiers 

identifiers: identifier identifiers 
           | identifier 
           |

class_declaration : CLASS identifier identifier WHERE func_add

func_add: identifier DOUBLE_COLON identifier ARROW type_specifier constructor

constructor: constractorwithInstance
           |constractorwithInstance constractorwithInstance

constractorwithInstance: DATA identifier ASSIGN identifier types instance_for_class

instance_for_class: INSTANCE identifier identifier WHERE instance_function

instance_function: identifier LEFTPAREN argsforClass RIGHTPAREN ASSIGN expression  main_method
                 
argsforClass: identifier
            |identifier argsforClass
            |

expression : expression MULTIPLY expression statements
           |identifier DIVIDE identifier
           |identifier PLUS identifier
           |identifier PLUS PLUS identifier
           |identifier  MINUS identifier
           |identifier GREATER_THAN INT_CONST
           |MINUS identifier
           |LEFTPAREN  expression RIGHTPAREN
           |NOT expression
           |CHAR_CONST
           |STRING_CONST PLUS PLUS identifier LEFTPAREN args RIGHTPAREN
           |STRING_CONST
           |INT_CONST
           |FLOAT_CONST
           |identifier
           |STRING_LITERAL PLUS PLUS identifier LEFTPAREN args RIGHTPAREN
           |ASSIGN
           |AND
           |identifier ASSIGN consts
           |

args: identifier identifier
    |identifier
    |identifier PLUS PLUS identifier

 main_method : MAIN DOUBLE_COLON IO LEFTPAREN RIGHTPAREN maindo

 maindo: MAIN ASSIGN DO statements 
       |MAIN ASSIGN DO statements  function_declaration

  statements:  type_specifier identifier expression identifier consts  statements
               |type_specifier expression statements
               |output_statement statements
               |type_specifier expression statements
               |if_statement  statements
               |expression
               |elseIF_statement
               |type_specifier identifier ASSIGN STRING_CONST PLUS INT_CONST
               | type_specifier identifier  ASSIGN INT_CONST statements
               |
elseIF_statement:ELSE IF expression THEN statements  
                |ELSE IF expression THEN statements elseIF_statement 
if_statement : IF expression THEN statements 
             |
else_statement:  ELSE statements
consts: INT_CONST consts
      |INT_CONST
      |FLOAT consts
      |FLOAT
      |BOOL consts
      |BOOL
      |STRING consts
      |STRING_CONST

 output_statement:PUTSTRLN DOLAR expression 
                |PUTSTRLN DOLAR STRING_CONST PLUS PLUS show_statement 
                |PUTSTRLN DOLAR STRING_CONST SHOW LEFTPAREN identifiers RIGHTPAREN
show_statement:SHOW identifier PLUS PLUS  SHOW identifier 
              |PUTSTRLN DOLAR STRING_CONST PLUS PLUS SHOW LEFTPAREN identifiers RIGHTPAREN
              |SHOW LEFTPAREN identifiers RIGHTBRACE
              |SHOW LEFTPAREN identifiers RIGHTPAREN

types : type_specifier
      | type_specifier type_specifier
  function_declaration: identifier DOUBLE_COLON type_specifier ARROW type_specifier function_definition_method
   function_definition_method: identifier INT_CONST ASSIGN STRING_CONST function_definition_method
                             |identifier identifier ASSIGN IF identifier identifier THEN STRING_CONST ELSE STRING_CONST main_method
type_specifier : INT
               | CHAR
               | BOOL
               | VOID
               | FLOAT
               | STRING
               |LET

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

    // Display encountered tokens
    printf("Encountered Tokens:\n");
    for (int i = 0; i < 500; i++) {
        if (encountered_tokens[i][0] != '\0') {
            printf("%s\n", encountered_tokens[i]);
        } else {
            break; // Stop when encountering an empty token
        }
    }

    return 0;
}


int yyerror(char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s,yylineno);
    return 0;
}