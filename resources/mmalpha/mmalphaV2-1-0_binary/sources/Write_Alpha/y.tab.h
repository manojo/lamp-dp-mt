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
     KW_system = 258,
     KW_decl = 259,
     KW_scalar = 260,
     KW_integer = 261,
     KW_boolean = 262,
     KW_real = 263,
     KW_equation = 264,
     KW_case = 265,
     KW_restrict = 266,
     KW_var = 267,
     KW_affine = 268,
     KW_const = 269,
     KW_index = 270,
     KW_binop = 271,
     KW_unop = 272,
     KW_if = 273,
     KW_add = 274,
     KW_sub = 275,
     KW_mul = 276,
     KW_div = 277,
     KW_idiv = 278,
     KW_mod = 279,
     KW_eq = 280,
     KW_le = 281,
     KW_lt = 282,
     KW_gt = 283,
     KW_ge = 284,
     KW_ne = 285,
     KW_or = 286,
     KW_and = 287,
     KW_neg = 288,
     KW_not = 289,
     KW_xor = 290,
     KW_min = 291,
     KW_max = 292,
     KW_sqrt = 293,
     KW_abs = 294,
     KW_domain = 295,
     KW_pol = 296,
     KW_zpol = 297,
     KW_matrix = 298,
     KW_notype = 299,
     KW_invar = 300,
     KW_outvar = 301,
     KW_locvar = 302,
     KW_usevar = 303,
     KW_reduce = 304,
     KW_depend = 305,
     KW_dependence = 306,
     KW_dtable = 307,
     KW_let = 308,
     KW_loop = 309,
     KW_call = 310,
     KW_use = 311,
     NUMBER = 312,
     REAL = 313,
     BOOLEAN = 314,
     ID = 315
   };
#endif
/* Tokens.  */
#define KW_system 258
#define KW_decl 259
#define KW_scalar 260
#define KW_integer 261
#define KW_boolean 262
#define KW_real 263
#define KW_equation 264
#define KW_case 265
#define KW_restrict 266
#define KW_var 267
#define KW_affine 268
#define KW_const 269
#define KW_index 270
#define KW_binop 271
#define KW_unop 272
#define KW_if 273
#define KW_add 274
#define KW_sub 275
#define KW_mul 276
#define KW_div 277
#define KW_idiv 278
#define KW_mod 279
#define KW_eq 280
#define KW_le 281
#define KW_lt 282
#define KW_gt 283
#define KW_ge 284
#define KW_ne 285
#define KW_or 286
#define KW_and 287
#define KW_neg 288
#define KW_not 289
#define KW_xor 290
#define KW_min 291
#define KW_max 292
#define KW_sqrt 293
#define KW_abs 294
#define KW_domain 295
#define KW_pol 296
#define KW_zpol 297
#define KW_matrix 298
#define KW_notype 299
#define KW_invar 300
#define KW_outvar 301
#define KW_locvar 302
#define KW_usevar 303
#define KW_reduce 304
#define KW_depend 305
#define KW_dependence 306
#define KW_dtable 307
#define KW_let 308
#define KW_loop 309
#define KW_call 310
#define KW_use 311
#define NUMBER 312
#define REAL 313
#define BOOLEAN 314
#define ID 315




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 319 "yacc.y"
{ node *n; datatype t; item *i; int b; }
/* Line 1529 of yacc.c.  */
#line 171 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

