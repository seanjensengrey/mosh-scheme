/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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
     IDENTIFIER = 258,
     BOOLEAN = 259,
     STRING = 260,
     CHARACTER = 261,
     CHARACTER_NAME = 262,
     REGEXP = 263,
     NUMBER = 264,
     LEFT_PAREN = 265,
     RIGHT_PAREN = 266,
     END_OF_FILE = 267,
     VECTOR_START = 268,
     BYTE_VECTOR_START = 269,
     DOT = 270,
     ABBV_QUASIQUOTE = 271,
     ABBV_QUOTE = 272,
     ABBV_UNQUOTESPLICING = 273,
     ABBV_UNQUOTE = 274,
     ABBV_SYNTAX = 275,
     ABBV_QUASISYNTAX = 276,
     ABBV_UNSYNTAXSPLICING = 277,
     ABBV_UNSYNTAX = 278
   };
#endif
/* Tokens.  */
#define IDENTIFIER 258
#define BOOLEAN 259
#define STRING 260
#define CHARACTER 261
#define CHARACTER_NAME 262
#define REGEXP 263
#define NUMBER 264
#define LEFT_PAREN 265
#define RIGHT_PAREN 266
#define END_OF_FILE 267
#define VECTOR_START 268
#define BYTE_VECTOR_START 269
#define DOT 270
#define ABBV_QUASIQUOTE 271
#define ABBV_QUOTE 272
#define ABBV_UNQUOTESPLICING 273
#define ABBV_UNQUOTE 274
#define ABBV_SYNTAX 275
#define ABBV_QUASISYNTAX 276
#define ABBV_UNSYNTAXSPLICING 277
#define ABBV_UNSYNTAX 278




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE numberlval;

