/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_LENGUAJEP_TAB_H_INCLUDED
# define YY_YY_LENGUAJEP_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TEXT = 258,
    NUM = 259,
    LIST = 260,
    PLUS = 261,
    MINUS = 262,
    TIMES = 263,
    DIVIDED_BY = 264,
    MOD = 265,
    INT = 266,
    FLOAT = 267,
    VARNAME = 268,
    STRING = 269,
    IS = 270,
    IF = 271,
    THEN = 272,
    FROM = 273,
    TO = 274,
    DO = 275,
    DONE = 276,
    ENDFUNC = 277,
    SHOW = 278,
    TAB = 279,
    NOT = 280,
    GREATER = 281,
    LOWER = 282,
    GEQUALS = 283,
    LEQUALS = 284,
    EQUALS = 285,
    NOT_EQUALS = 286,
    AND = 287,
    OR = 288,
    FOREACH = 289,
    IN = 290,
    FUNC = 291,
    RETURN = 292,
    OPEN_BRACKET = 293,
    CLOSE_BRACKET = 294,
    OPEN_PAREN = 295,
    CLOSE_PAREN = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 110 "lenguajeP.y" /* yacc.c:1909  */
int entero; float real; char* string;

#line 99 "lenguajeP.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_LENGUAJEP_TAB_H_INCLUDED  */
