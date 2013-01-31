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
     KW_of = 258,
     KW_integer = 259,
     KW_boolean = 260,
     KW_real = 261,
     KW_invar = 262,
     KW_outvar = 263,
     KW_locvar = 264,
     KW_usevar = 265,
     KW_var = 266,
     KW_returns = 267,
     KW_system = 268,
     KW_let = 269,
     KW_tel = 270,
     KW_use = 271,
     KW_case = 272,
     KW_esac = 273,
     KW_if = 274,
     KW_then = 275,
     KW_else = 276,
     KW_or = 277,
     KW_xor = 278,
     KW_and = 279,
     KW_not = 280,
     KW_div = 281,
     KW_mod = 282,
     KW_sqrt = 283,
     KW_abs = 284,
     KW_convex = 285,
     KW_arrow = 286,
     KW_leq = 287,
     KW_geq = 288,
     KW_ne = 289,
     KW_domain = 290,
     KW_loop = 291,
     KW_reduce = 292,
     KW_max = 293,
     KW_min = 294,
     NUMBER = 295,
     INFINITY = 296,
     REAL = 297,
     BOOLEAN = 298,
     ID = 299,
     XID = 300
   };
#endif
/* Tokens.  */
#define KW_of 258
#define KW_integer 259
#define KW_boolean 260
#define KW_real 261
#define KW_invar 262
#define KW_outvar 263
#define KW_locvar 264
#define KW_usevar 265
#define KW_var 266
#define KW_returns 267
#define KW_system 268
#define KW_let 269
#define KW_tel 270
#define KW_use 271
#define KW_case 272
#define KW_esac 273
#define KW_if 274
#define KW_then 275
#define KW_else 276
#define KW_or 277
#define KW_xor 278
#define KW_and 279
#define KW_not 280
#define KW_div 281
#define KW_mod 282
#define KW_sqrt 283
#define KW_abs 284
#define KW_convex 285
#define KW_arrow 286
#define KW_leq 287
#define KW_geq 288
#define KW_ne 289
#define KW_domain 290
#define KW_loop 291
#define KW_reduce 292
#define KW_max 293
#define KW_min 294
#define NUMBER 295
#define INFINITY 296
#define REAL 297
#define BOOLEAN 298
#define ID 299
#define XID 300




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 93 "yacc.y"
{ node *n; int i;}
/* Line 1529 of yacc.c.  */
#line 141 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

