
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     identifier = 258,
     STRING_CONST = 259,
     FLOAT_CONST = 260,
     INT_CONST = 261,
     CHAR_CONST = 262,
     PUTSTRLN = 263,
     IMPORT = 264,
     BREAK = 265,
     STRING_LITERAL = 266,
     DO = 267,
     IF = 268,
     ELSE = 269,
     SEMICOLON = 270,
     COMMA = 271,
     ASSIGN = 272,
     MINUS = 273,
     PLUS = 274,
     MULTIPLY = 275,
     DIVIDE = 276,
     MODULO = 277,
     DOT = 278,
     RIGHTBRACKET = 279,
     LEFTBRACKET = 280,
     IO = 281,
     CASE = 282,
     OF = 283,
     MAIN = 284,
     LEFTBRACE = 285,
     RIGHTBRACE = 286,
     LESS_THAN = 287,
     LESS_EQUAL = 288,
     GREATER_THAN = 289,
     GREATER_EQUAL = 290,
     EQUALS = 291,
     NOT_EQUALS = 292,
     AND = 293,
     OR = 294,
     NOT = 295,
     BOOL = 296,
     CHAR = 297,
     INT = 298,
     FLOAT = 299,
     VOID = 300,
     STRING = 301,
     LET = 302,
     ARROW = 303,
     CLASS = 304,
     WHERE = 305,
     DOUBLE_COLON = 306,
     LEFTPAREN = 307,
     RIGHTPAREN = 308,
     INSTANCE = 309
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 23 "parser.y"

    char* strval;
    float floatval;
    int intval;
    char charval;
    char* expression;



/* Line 1676 of yacc.c  */
#line 116 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


