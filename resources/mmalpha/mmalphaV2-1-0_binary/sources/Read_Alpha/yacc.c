/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



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




/* Copy the first part of user declarations.  */
#line 1 "yacc.y"

 /*  file: $MMALPHA/sources/Read_Alpha/yacc.y
   AUTHOR : Doran Wilde
   CONTACT : http://www.irisa.fr/api/ALPHA
   COPYRIGHT  (C) INRIA
   
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   (see file : $MMALPHA/LICENSING).

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library(see file : $MMALPHA/LICENSING);
   if not, write to the Free Software Foundation, Inc., 59 Temple
   Place - Suite 330, Boston, MA  02111-1307, USA. */
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include "nodetypes.h"	/* includes "../Polylib/types.h" */
#include <polylib/polylib.h>
#include "node.h"
#define	MAXRAYS 200

/* lex interface */
int yylex();
int yyinput();
int yyoutput();
static void yyunput();
int	lineNb;
int	yynerrs;
int	yywarns;

/* global attributes */
node	*alpha;			/* root of parse tree = list of alpha systems*/
node	*curr_sys=0;		/* current alpha system node tree */
node	*id_context=0;		/* list of context indices incl. parameters */
node	*id_param=0;		/* list of indices of parameter space */
node	*context_domain=0;	/* context domain */
node	*lhs=0;			/* lhs */
int	errs=0;			/* num errors as of last curr_sys started */
int	keep_on_error=0;	/* output a system, even if it has errors */


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 93 "yacc.y"
{ node *n; int i;}
/* Line 193 of yacc.c.  */
#line 237 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 250 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  15
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   551

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  68
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  67
/* YYNRULES -- Number of rules.  */
#define YYNRULES  188
/* YYNRULES -- Number of states.  */
#define YYNSTATES  355

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   300

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    49,     2,     2,     2,    59,     2,
      52,    53,    67,    66,    55,    64,    51,    65,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    50,    54,
      46,    48,    63,     2,    47,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    56,     2,    57,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    61,    58,    62,    60,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     6,     9,    14,    19,    24,    26,    29,
      31,    35,    36,    49,    50,    53,    54,    58,    60,    61,
      65,    67,    68,    72,    73,    77,    79,    83,    87,    89,
      91,    98,   102,   111,   113,   115,   117,   119,   121,   122,
     123,   129,   133,   135,   138,   142,   144,   146,   147,   152,
     153,   158,   159,   173,   174,   176,   177,   181,   188,   192,
     194,   199,   203,   205,   206,   208,   212,   214,   218,   220,
     224,   228,   230,   233,   235,   241,   246,   251,   255,   259,
     263,   269,   273,   275,   277,   279,   281,   285,   289,   293,
     297,   301,   305,   309,   313,   317,   321,   325,   329,   333,
     337,   341,   345,   347,   349,   353,   357,   359,   360,   362,
     363,   365,   371,   375,   377,   381,   384,   386,   389,   393,
     397,   399,   401,   403,   405,   408,   411,   418,   420,   424,
     426,   430,   434,   436,   440,   444,   448,   450,   453,   455,
     459,   461,   463,   465,   467,   469,   471,   473,   477,   481,
     483,   487,   491,   495,   499,   501,   504,   506,   510,   515,
     517,   523,   525,   526,   536,   541,   548,   553,   558,   559,
     561,   564,   566,   569,   572,   575,   579,   583,   585,   588,
     590,   592,   594,   596,   598,   600,   602,   604,   606
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int16 yyrhs[] =
{
      69,     0,    -1,    46,    70,    -1,    47,    70,    -1,    48,
      49,   117,    49,    -1,    50,    49,    96,    49,    -1,    51,
      49,   102,    49,    -1,    71,    -1,    70,    71,    -1,    72,
      -1,    72,    77,    84,    -1,    -1,    13,    44,    73,    74,
      52,    75,    53,    12,    52,    76,    53,    54,    -1,    -1,
      50,    96,    -1,    -1,    75,    54,    79,    -1,    79,    -1,
      -1,    76,    54,    79,    -1,    79,    -1,    -1,    11,    78,
      54,    -1,    -1,    78,    54,    79,    -1,    79,    -1,    80,
      50,    81,    -1,    80,    55,    44,    -1,    44,    -1,    82,
      -1,    82,    56,    44,    55,    40,    57,    -1,    96,     3,
      82,    -1,    96,     3,    82,    56,    44,    55,    40,    57,
      -1,    96,    -1,     4,    -1,     5,    -1,     6,    -1,    54,
      -1,    -1,    -1,    14,    85,    86,    15,    83,    -1,     1,
      15,    83,    -1,    88,    -1,    86,    88,    -1,    86,     1,
      54,    -1,    96,    -1,    84,    -1,    -1,    87,    50,    89,
      88,    -1,    -1,    87,    36,    90,    88,    -1,    -1,    16,
      91,    92,    44,    93,    52,    95,    53,    12,    52,    80,
      53,    54,    -1,    -1,    96,    -1,    -1,    56,   111,    57,
      -1,    51,    52,   110,    31,   111,    53,    -1,    94,    48,
     116,    -1,    44,    -1,    44,    56,   111,    57,    -1,    95,
      55,   117,    -1,   117,    -1,    -1,    97,    -1,    97,    58,
      98,    -1,    98,    -1,    98,    59,    99,    -1,    99,    -1,
     100,    51,   102,    -1,   100,    51,    30,    -1,   100,    -1,
      60,   100,    -1,   101,    -1,    61,   112,    58,   103,    62,
      -1,    61,    58,   103,    62,    -1,    61,   112,    58,    62,
      -1,    61,     1,    62,    -1,    61,    97,    62,    -1,    35,
       3,    44,    -1,    52,   111,    31,   111,    53,    -1,   103,
      54,   104,    -1,   104,    -1,   105,    -1,   106,    -1,   107,
      -1,   105,    48,   112,    -1,   112,    48,   112,    -1,   106,
      63,   112,    -1,   106,    33,   112,    -1,   106,    48,   112,
      -1,   106,    46,   112,    -1,   106,    32,   112,    -1,   112,
      63,   112,    -1,   112,    33,   112,    -1,   107,    46,   112,
      -1,   107,    32,   112,    -1,   107,    48,   112,    -1,   107,
      63,   112,    -1,   107,    33,   112,    -1,   112,    46,   112,
      -1,   112,    32,   112,    -1,    44,    -1,    45,    -1,   108,
      50,    44,    -1,   109,    55,   108,    -1,   108,    -1,    -1,
     109,    -1,    -1,   112,    -1,    52,   112,    55,   113,    53,
      -1,   112,    55,   113,    -1,   113,    -1,   113,   115,   114,
      -1,    64,   114,    -1,   114,    -1,    40,   108,    -1,   114,
      65,    40,    -1,    52,   113,    53,    -1,    40,    -1,   108,
      -1,    66,    -1,    64,    -1,   117,    54,    -1,     1,    54,
      -1,    19,   117,    20,   117,    21,   117,    -1,   118,    -1,
      96,    50,   117,    -1,   119,    -1,   119,    22,   120,    -1,
     119,    23,   120,    -1,   120,    -1,   120,    24,   121,    -1,
     120,    39,   121,    -1,   120,    38,   121,    -1,   121,    -1,
      25,   121,    -1,   122,    -1,   124,   123,   124,    -1,   124,
      -1,    48,    -1,    63,    -1,    33,    -1,    46,    -1,    32,
      -1,    34,    -1,   124,    66,   125,    -1,   124,    64,   125,
      -1,   125,    -1,   125,    67,   126,    -1,   125,    65,   126,
      -1,   125,    26,   126,    -1,   125,    27,   126,    -1,   126,
      -1,    64,   127,    -1,   127,    -1,   127,    51,   102,    -1,
     129,    56,   111,    57,    -1,   129,    -1,    52,   110,    31,
     111,    53,    -1,    44,    -1,    -1,    37,    52,   130,   133,
      55,   128,    55,   117,    53,    -1,    44,    52,    95,    53,
      -1,   134,    52,   117,    55,   118,    53,    -1,    28,    52,
     117,    53,    -1,    29,    52,   117,    53,    -1,    -1,    40,
      -1,    40,    45,    -1,    45,    -1,    41,   131,    -1,    42,
     131,    -1,    43,   131,    -1,    52,   117,    53,    -1,    17,
     132,    18,    -1,   116,    -1,   132,   116,    -1,    66,    -1,
      67,    -1,    24,    -1,    22,    -1,    23,    -1,    39,    -1,
      38,    -1,   133,    -1,    26,    -1,    27,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   112,   112,   117,   119,   125,   131,   140,   156,   171,
     178,   189,   188,   210,   222,   229,   230,   236,   243,   244,
     251,   259,   260,   262,   263,   271,   283,   288,   291,   295,
     311,   329,   335,   343,   351,   359,   367,   378,   378,   380,
     380,   385,   390,   393,   396,   401,   407,   410,   410,   417,
     417,   428,   428,   444,   447,   452,   458,   467,   499,   506,
     533,   602,   605,   609,   615,   628,   682,   685,   716,   720,
     730,   739,   742,   756,   759,   810,   837,   877,   887,   889,
     908,   960,   962,   965,   967,   969,   972,   976,   981,   985,
     989,   993,   997,  1002,  1006,  1011,  1015,  1019,  1023,  1027,
    1032,  1036,  1044,  1057,  1061,  1072,  1076,  1092,  1099,  1139,
    1141,  1145,  1148,  1151,  1155,  1160,  1170,  1173,  1178,  1183,
    1185,  1187,  1190,  1191,  1196,  1198,  1203,  1208,  1214,  1218,
    1221,  1226,  1231,  1234,  1239,  1244,  1249,  1252,  1257,  1260,
    1265,  1268,  1269,  1270,  1271,  1272,  1273,  1275,  1289,  1303,
    1306,  1311,  1316,  1321,  1326,  1329,  1345,  1348,  1402,  1479,
    1483,  1498,  1514,  1514,  1522,  1534,  1539,  1543,  1549,  1562,
    1569,  1578,  1585,  1590,  1595,  1600,  1602,  1607,  1609,  1612,
    1613,  1614,  1615,  1616,  1617,  1618,  1620,  1621,  1622
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "KW_of", "KW_integer", "KW_boolean",
  "KW_real", "KW_invar", "KW_outvar", "KW_locvar", "KW_usevar", "KW_var",
  "KW_returns", "KW_system", "KW_let", "KW_tel", "KW_use", "KW_case",
  "KW_esac", "KW_if", "KW_then", "KW_else", "KW_or", "KW_xor", "KW_and",
  "KW_not", "KW_div", "KW_mod", "KW_sqrt", "KW_abs", "KW_convex",
  "KW_arrow", "KW_leq", "KW_geq", "KW_ne", "KW_domain", "KW_loop",
  "KW_reduce", "KW_max", "KW_min", "NUMBER", "INFINITY", "REAL", "BOOLEAN",
  "ID", "XID", "'<'", "'@'", "'='", "'\"'", "':'", "'.'", "'('", "')'",
  "';'", "','", "'['", "']'", "'|'", "'&'", "'~'", "'{'", "'}'", "'>'",
  "'-'", "'/'", "'+'", "'*'", "$accept", "Command", "Program", "System",
  "SystemDecl", "@1", "Param", "Inputs", "Outputs", "LocalBlock", "Locals",
  "Decl", "Ids", "Type", "Tsimple", "Semi", "LetBlock", "@2", "Equations",
  "ContextDomain", "Equation", "@3", "@4", "@5", "UseDomain",
  "ParamAssign", "LHS", "ExpList", "Domain", "Dom1", "Dom2", "Dom3",
  "Dom4", "DomTerm", "Affine_Function", "Constraints", "Constraint",
  "Egalite", "Suite_Decroissante", "Suite_Croissante", "Xid", "Xids",
  "Vids", "Vexpressions", "Expressions", "Expression", "Facteur",
  "LinearOp", "Exp", "Exp1", "Exp2", "Exp3", "Exp4", "Exp5", "Exp6",
  "RelOp", "Exp7", "Exp8", "Exp9", "Exp10", "Projection", "ExpTerm", "@6",
  "Add_Params", "Alts", "CommutativeOp", "BinaryOp", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,    60,    64,    61,    34,
      58,    46,    40,    41,    59,    44,    91,    93,   124,    38,
     126,   123,   125,    62,    45,    47,    43,    42
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    68,    69,    69,    69,    69,    69,    70,    70,    71,
      71,    73,    72,    74,    74,    75,    75,    75,    76,    76,
      76,    77,    77,    78,    78,    78,    79,    80,    80,    81,
      81,    81,    81,    81,    82,    82,    82,    83,    83,    85,
      84,    84,    86,    86,    86,    87,    88,    89,    88,    90,
      88,    91,    88,    92,    92,    93,    93,    93,    88,    94,
      94,    95,    95,    95,    96,    97,    97,    98,    98,    99,
      99,    99,   100,   100,   101,   101,   101,   101,   101,   101,
     102,   103,   103,   104,   104,   104,   105,   105,   106,   106,
     106,   106,   106,   106,   106,   107,   107,   107,   107,   107,
     107,   107,   108,   108,   108,   109,   109,   110,   110,   111,
     111,   112,   112,   112,   113,   113,   113,   114,   114,   114,
     114,   114,   115,   115,   116,   116,   117,   117,   118,   118,
     119,   119,   119,   120,   120,   120,   120,   121,   121,   122,
     122,   123,   123,   123,   123,   123,   123,   124,   124,   124,
     125,   125,   125,   125,   125,   126,   126,   127,   127,   127,
     128,   129,   130,   129,   129,   129,   129,   129,   131,   129,
     129,   129,   129,   129,   129,   129,   129,   132,   132,   133,
     133,   133,   133,   133,   133,   133,   134,   134,   134
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     2,     4,     4,     4,     1,     2,     1,
       3,     0,    12,     0,     2,     0,     3,     1,     0,     3,
       1,     0,     3,     0,     3,     1,     3,     3,     1,     1,
       6,     3,     8,     1,     1,     1,     1,     1,     0,     0,
       5,     3,     1,     2,     3,     1,     1,     0,     4,     0,
       4,     0,    13,     0,     1,     0,     3,     6,     3,     1,
       4,     3,     1,     0,     1,     3,     1,     3,     1,     3,
       3,     1,     2,     1,     5,     4,     4,     3,     3,     3,
       5,     3,     1,     1,     1,     1,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     1,     1,     3,     3,     1,     0,     1,     0,
       1,     5,     3,     1,     3,     2,     1,     2,     3,     3,
       1,     1,     1,     1,     2,     2,     6,     1,     3,     1,
       3,     3,     1,     3,     3,     3,     1,     2,     1,     3,
       1,     1,     1,     1,     1,     1,     1,     3,     3,     1,
       3,     3,     3,     3,     1,     2,     1,     3,     4,     1,
       5,     1,     0,     9,     4,     6,     4,     4,     0,     1,
       2,     1,     2,     2,     2,     3,     3,     1,     2,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     2,     7,
       9,     3,     0,     0,     0,     1,    11,     8,    23,     0,
       0,     0,   182,   183,   181,     0,   187,   188,     0,     0,
       0,     0,   185,   184,   169,   168,   168,   168,   161,   171,
       0,     0,     0,     0,   179,   180,     0,    64,    66,    68,
      71,    73,     0,   127,   129,   132,   136,   138,   140,   149,
     154,   156,   159,   186,     0,     0,   109,     0,    13,    28,
       0,    25,     0,     0,    39,    10,     0,   177,     0,     0,
       0,   137,     0,     0,     0,   162,   170,   172,   173,   174,
      63,     0,    72,     0,   120,   102,   103,     0,     0,     0,
       0,   121,     0,   113,   116,   155,     0,     0,     0,     0,
       4,     0,     0,     0,     0,     0,   145,   143,   146,   144,
     141,   142,     0,     0,     0,     0,     0,     0,     0,     0,
     109,     0,     5,     0,   110,     6,     0,     0,    22,     0,
       0,    38,     0,   125,   124,   176,   178,     0,     0,     0,
      79,     0,     0,    62,   175,    77,   117,     0,   113,     0,
      82,    83,    84,    85,     0,     0,   115,    78,     0,     0,
       0,   123,   122,     0,     0,   128,    65,    67,    70,    69,
     130,   131,   133,   135,   134,   148,   147,   139,   152,   153,
     151,   150,   157,     0,     0,   109,    14,    15,    24,    34,
      35,    36,    26,    29,    33,    27,    37,    41,    51,    59,
      46,     0,     0,    42,     0,    45,     0,   166,   167,     0,
     164,     0,     0,   119,     0,    75,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   104,   112,    76,     0,   114,   118,   158,
       0,     0,     0,    17,     0,     0,    53,   109,     0,    38,
      43,    49,    47,     0,     0,     0,    61,   112,    81,    86,
      92,    89,    91,    90,    88,    96,    99,    95,    97,    98,
     101,    94,   100,    87,    93,    74,     0,    80,     0,     0,
       0,    31,     0,    54,     0,    44,    40,     0,     0,    58,
     126,   107,     0,   111,   165,     0,    16,     0,     0,    55,
      60,    50,    48,   106,   108,     0,     0,    18,     0,     0,
       0,   109,     0,     0,   109,     0,     0,    20,    30,     0,
     107,     0,    63,   105,     0,   163,     0,     0,     0,     0,
      56,     0,   160,    12,    19,    32,   109,     0,     0,     0,
      57,     0,     0,     0,    52
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     6,     8,     9,    10,    68,   137,   252,   326,    19,
      70,    71,    72,   202,   203,   207,   210,   142,   211,   212,
     213,   298,   297,   256,   292,   322,   214,   152,    46,    47,
      48,    49,    50,    51,    67,   159,   160,   161,   162,   163,
     101,   314,   315,   133,   134,   103,   104,   173,    77,    78,
      53,    54,    55,    56,    57,   124,    58,    59,    60,    61,
     302,    62,   151,    87,    79,    63,    64
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -206
static const yytype_int16 yypact[] =
{
     192,     2,     2,   -16,    -6,    50,   127,    93,     2,  -206,
      43,     2,   330,     0,    89,  -206,  -206,  -206,   109,    38,
     284,   330,  -206,  -206,  -206,   422,  -206,  -206,   105,   117,
     176,   139,  -206,  -206,   130,  -206,  -206,  -206,   147,  -206,
     330,     0,    46,   484,  -206,  -206,   145,   148,   152,  -206,
     162,  -206,   169,  -206,    62,     3,  -206,  -206,    -8,   -14,
    -206,   178,   164,  -206,   179,   195,   172,   197,   191,  -206,
     206,  -206,    12,   268,  -206,  -206,   230,  -206,   234,   121,
     269,  -206,   330,   330,   246,  -206,  -206,  -206,  -206,  -206,
     330,   238,  -206,   231,   209,  -206,  -206,   172,   172,   181,
      47,   242,    11,    88,   229,   178,   330,     0,     0,    -7,
    -206,   422,   422,   422,   422,   422,  -206,  -206,  -206,  -206,
    -206,  -206,   453,   453,   453,   453,   453,   453,   453,    89,
     172,   330,  -206,   264,   241,  -206,     0,   247,   109,    13,
     253,   244,   107,  -206,  -206,  -206,  -206,   330,   249,   252,
    -206,    -2,   119,  -206,  -206,  -206,   242,   259,    36,    18,
    -206,   267,    55,   144,   138,   183,   229,  -206,   256,   183,
     170,  -206,  -206,   181,   276,  -206,   152,  -206,  -206,  -206,
       3,     3,  -206,  -206,  -206,   -14,   -14,   114,  -206,  -206,
    -206,  -206,  -206,   260,   263,   172,  -206,   109,  -206,  -206,
    -206,  -206,  -206,   274,   328,  -206,  -206,  -206,  -206,   277,
    -206,    15,    -4,  -206,   286,  -206,   311,  -206,  -206,   280,
    -206,   330,   183,  -206,   172,  -206,   172,   172,   172,   172,
     172,   172,   172,   172,   172,   172,   172,   172,   172,   172,
     172,   172,    36,  -206,    88,  -206,    58,   229,  -206,  -206,
     376,   285,   202,  -206,   293,   111,     0,   172,    -5,   244,
    -206,  -206,  -206,   284,   330,   287,  -206,    60,  -206,   241,
     241,   241,   241,   241,   241,   241,   241,   241,   241,   241,
     241,   241,   241,   241,   241,  -206,   288,  -206,   331,   109,
     291,   304,   296,  -206,   305,  -206,  -206,   107,   107,  -206,
    -206,   209,   306,  -206,  -206,   290,  -206,   323,   320,    78,
    -206,  -206,  -206,   242,   321,   335,   330,   109,   322,   325,
     326,   172,   329,   209,   172,   324,   204,  -206,  -206,   343,
     209,   327,   330,   242,   332,  -206,   333,   109,   338,   355,
    -206,   143,  -206,  -206,  -206,  -206,   172,   377,   339,   336,
    -206,   109,   149,   352,  -206
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -206,  -206,   405,   103,  -206,  -206,  -206,  -206,  -206,  -206,
    -206,  -134,    57,  -206,   154,   151,   393,  -206,  -206,  -206,
    -205,  -206,  -206,  -206,  -206,  -206,  -206,    90,   -11,   381,
     317,   318,   384,  -206,   -95,   257,   205,  -206,  -206,  -206,
     -93,  -206,   100,  -127,    35,   -86,   -91,  -206,   -74,   -12,
     182,  -206,   166,   -18,  -206,  -206,   307,   157,   123,   390,
    -206,  -206,  -206,   245,  -206,   283,  -206
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -22
static const yytype_int16 yytable[] =
{
      52,   156,    65,   193,   198,   146,   260,    81,   166,    80,
     141,   158,   125,   126,   179,     7,   258,   199,   200,   201,
      22,    23,    24,   178,   116,   117,   118,   113,    91,    74,
     259,   208,   261,    12,   192,    30,    32,    33,   119,    73,
     120,   114,   115,    13,   -21,    66,   262,    93,    30,   295,
      30,   127,    74,   128,    18,   121,   122,   -21,   123,   209,
      41,    42,   139,   253,    44,    45,   169,   140,   251,   170,
     148,   149,   224,    41,    42,    41,    42,   102,   153,   242,
     225,    30,   247,   244,   111,   112,    94,   227,   228,   223,
      95,    96,   311,   312,   175,   182,   183,   184,    97,    14,
     171,   229,   172,   230,    98,   107,    41,    42,    73,   167,
      99,    17,   224,   303,    17,   199,   200,   201,   231,   194,
     285,    74,    76,   208,   171,   196,   172,    15,   204,   320,
     294,   215,   157,   164,   321,   216,   267,    16,    20,   145,
      21,    66,    30,    22,    23,    24,    25,    26,    27,    28,
      29,   209,   171,    69,   172,   306,    30,    82,    31,    32,
      33,    34,    35,    36,    37,    38,    39,    41,    42,    83,
     237,   238,   220,    40,   221,    86,   232,   233,   122,    84,
     123,    41,    42,   327,   239,    43,   240,    44,    45,   299,
     234,    85,   235,   169,   331,   106,   347,   334,   221,    90,
     215,   241,   353,   344,   140,   164,   107,   236,   313,   266,
      94,   108,    94,   109,    95,    96,    95,    96,   110,   348,
     130,    94,    97,    94,    97,    95,    96,    95,    96,   129,
     333,   131,   245,   165,    99,   165,    99,   313,     1,     2,
       3,   136,     4,     5,   132,   293,   135,    99,   188,   189,
     190,   191,   300,    95,    96,   288,   289,   336,   337,   164,
     138,   269,   270,   271,   272,   273,   274,   275,   276,   277,
     278,   279,   280,   281,   282,   283,   284,   180,   181,   185,
     186,    88,    89,   141,   143,    76,   215,   215,   144,   147,
     150,   154,   168,   155,   174,   195,   169,   205,   206,   197,
     243,    20,   217,    21,   325,   218,    22,    23,    24,    25,
      26,    27,    28,    29,   222,   226,   248,   249,   250,    30,
     153,    31,    32,    33,    34,    35,    36,    37,    38,    39,
     254,   255,   264,   257,   263,   265,    40,   290,   287,   301,
     309,   304,   317,   305,    41,    42,   307,    20,    43,    21,
      44,    45,    22,    23,    24,    25,    26,    27,    28,    29,
     308,   316,   310,   318,   319,    30,   324,    31,    32,    33,
      34,    35,    36,    37,    38,    39,   323,   335,   330,   328,
     329,   332,    40,   338,   340,   342,   346,   343,   351,   349,
      41,    42,   350,    20,    43,   345,    44,    45,    22,    23,
      24,    25,    26,    27,    28,    29,   354,    11,   352,   291,
     296,    30,    75,    31,    32,    33,    34,    35,    36,    37,
      38,    39,   341,   100,   176,    92,   177,   246,    40,   268,
     339,   187,   286,   105,   219,     0,    41,    42,     0,    20,
      43,     0,    44,    45,    22,    23,    24,    25,    26,    27,
      28,    29,     0,     0,     0,     0,     0,     0,     0,    31,
      32,    33,    34,    35,    36,    37,    38,    39,     0,     0,
      20,     0,     0,     0,    40,    22,    23,    24,     0,    26,
      27,    28,    29,     0,     0,     0,    43,     0,    44,    45,
      31,    32,    33,    34,    35,    36,    37,    38,    39,     0,
       0,    20,     0,     0,     0,    40,    22,    23,    24,     0,
      26,    27,    28,    29,     0,     0,     0,    43,     0,    44,
      45,    31,    32,    33,    34,    35,    36,    37,    38,    39,
       0,     0,     0,     0,     0,     0,    40,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      44,    45
};

static const yytype_int16 yycheck[] =
{
      12,    94,    13,   130,   138,    79,   211,    25,    99,    21,
      15,    97,    26,    27,   109,    13,     1,     4,     5,     6,
      22,    23,    24,    30,    32,    33,    34,    24,    40,    14,
      15,    16,    36,    49,   129,    35,    38,    39,    46,     1,
      48,    38,    39,    49,     1,    52,    50,     1,    35,    54,
      35,    65,    14,    67,    11,    63,    64,    14,    66,    44,
      60,    61,    50,   197,    66,    67,    55,    55,   195,    58,
      82,    83,    54,    60,    61,    60,    61,    42,    90,   165,
      62,    35,   173,   169,    22,    23,    40,    32,    33,    53,
      44,    45,   297,   298,   106,   113,   114,   115,    52,    49,
      64,    46,    66,    48,    58,    58,    60,    61,     1,    62,
      64,     8,    54,    53,    11,     4,     5,     6,    63,   131,
      62,    14,     1,    16,    64,   136,    66,     0,   139,    51,
     257,   142,    97,    98,    56,   147,   222,    44,    17,    18,
      19,    52,    35,    22,    23,    24,    25,    26,    27,    28,
      29,    44,    64,    44,    66,   289,    35,    52,    37,    38,
      39,    40,    41,    42,    43,    44,    45,    60,    61,    52,
      32,    33,    53,    52,    55,    45,    32,    33,    64,     3,
      66,    60,    61,   317,    46,    64,    48,    66,    67,   263,
      46,    52,    48,    55,   321,    50,    53,   324,    55,    52,
     211,    63,    53,   337,    55,   170,    58,    63,   301,   221,
      40,    59,    40,    51,    44,    45,    44,    45,    49,   346,
      56,    40,    52,    40,    52,    44,    45,    44,    45,    51,
     323,    52,    62,    52,    64,    52,    64,   330,    46,    47,
      48,    50,    50,    51,    49,   256,    49,    64,   125,   126,
     127,   128,   264,    44,    45,    53,    54,    53,    54,   224,
      54,   226,   227,   228,   229,   230,   231,   232,   233,   234,
     235,   236,   237,   238,   239,   240,   241,   111,   112,   122,
     123,    36,    37,    15,    54,     1,   297,   298,    54,    20,
      44,    53,    50,    62,    65,    31,    55,    44,    54,    52,
      44,    17,    53,    19,   316,    53,    22,    23,    24,    25,
      26,    27,    28,    29,    55,    48,    40,    57,    55,    35,
     332,    37,    38,    39,    40,    41,    42,    43,    44,    45,
      56,     3,    21,    56,    48,    55,    52,    44,    53,    52,
      44,    53,    52,    12,    60,    61,    55,    17,    64,    19,
      66,    67,    22,    23,    24,    25,    26,    27,    28,    29,
      56,    55,    57,    40,    44,    35,    31,    37,    38,    39,
      40,    41,    42,    43,    44,    45,    55,    53,    52,    57,
      55,    52,    52,    40,    57,    53,    31,    54,    52,    12,
      60,    61,    53,    17,    64,    57,    66,    67,    22,    23,
      24,    25,    26,    27,    28,    29,    54,     2,   351,   255,
     259,    35,    19,    37,    38,    39,    40,    41,    42,    43,
      44,    45,   332,    42,   107,    41,   108,   170,    52,   224,
     330,   124,   250,    43,   151,    -1,    60,    61,    -1,    17,
      64,    -1,    66,    67,    22,    23,    24,    25,    26,    27,
      28,    29,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    37,
      38,    39,    40,    41,    42,    43,    44,    45,    -1,    -1,
      17,    -1,    -1,    -1,    52,    22,    23,    24,    -1,    26,
      27,    28,    29,    -1,    -1,    -1,    64,    -1,    66,    67,
      37,    38,    39,    40,    41,    42,    43,    44,    45,    -1,
      -1,    17,    -1,    -1,    -1,    52,    22,    23,    24,    -1,
      26,    27,    28,    29,    -1,    -1,    -1,    64,    -1,    66,
      67,    37,    38,    39,    40,    41,    42,    43,    44,    45,
      -1,    -1,    -1,    -1,    -1,    -1,    52,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      66,    67
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    46,    47,    48,    50,    51,    69,    13,    70,    71,
      72,    70,    49,    49,    49,     0,    44,    71,    11,    77,
      17,    19,    22,    23,    24,    25,    26,    27,    28,    29,
      35,    37,    38,    39,    40,    41,    42,    43,    44,    45,
      52,    60,    61,    64,    66,    67,    96,    97,    98,    99,
     100,   101,   117,   118,   119,   120,   121,   122,   124,   125,
     126,   127,   129,   133,   134,    96,    52,   102,    73,    44,
      78,    79,    80,     1,    14,    84,     1,   116,   117,   132,
     117,   121,    52,    52,     3,    52,    45,   131,   131,   131,
      52,   117,   100,     1,    40,    44,    45,    52,    58,    64,
      97,   108,   112,   113,   114,   127,    50,    58,    59,    51,
      49,    22,    23,    24,    38,    39,    32,    33,    34,    46,
      48,    63,    64,    66,   123,    26,    27,    65,    67,    51,
      56,    52,    49,   111,   112,    49,    50,    74,    54,    50,
      55,    15,    85,    54,    54,    18,   116,    20,   117,   117,
      44,   130,    95,   117,    53,    62,   108,   112,   113,   103,
     104,   105,   106,   107,   112,    52,   114,    62,    50,    55,
      58,    64,    66,   115,    65,   117,    98,    99,    30,   102,
     120,   120,   121,   121,   121,   125,   125,   124,   126,   126,
     126,   126,   102,   111,   117,    31,    96,    52,    79,     4,
       5,     6,    81,    82,    96,    44,    54,    83,    16,    44,
      84,    86,    87,    88,    94,    96,   117,    53,    53,   133,
      53,    55,    55,    53,    54,    62,    48,    32,    33,    46,
      48,    63,    32,    33,    46,    48,    63,    32,    33,    46,
      48,    63,   113,    44,   113,    62,   103,   114,    40,    57,
      55,   111,    75,    79,    56,     3,    91,    56,     1,    15,
      88,    36,    50,    48,    21,    55,   117,   113,   104,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,    62,   118,    53,    53,    54,
      44,    82,    92,    96,   111,    54,    83,    90,    89,   116,
     117,    52,   128,    53,    53,    12,    79,    55,    56,    44,
      57,    88,    88,   108,   109,   110,    55,    52,    40,    44,
      51,    56,    93,    55,    31,   117,    76,    79,    57,    55,
      52,   111,    52,   108,   111,    53,    53,    54,    40,   110,
      57,    95,    53,    54,    79,    57,    31,    53,   111,    12,
      53,    52,    80,    53,    54
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 113 "yacc.y"
    {	print_alpha(alpha, 0);
	fputc('\n',yyout);
	YYACCEPT;
    }
    break;

  case 3:
#line 118 "yacc.y"
    {	YYACCEPT; }
    break;

  case 4:
#line 120 "yacc.y"
    {   print_alpha((yyvsp[(3) - (4)].n), 0);
	fputc('\n',yyout);
        /* all_old_nodes(); */
        YYACCEPT;
    }
    break;

  case 5:
#line 126 "yacc.y"
    {   print_alpha((yyvsp[(3) - (4)].n), 0);
	fputc('\n',yyout);
        /* all_old_nodes(); */
        YYACCEPT;
    }
    break;

  case 6:
#line 132 "yacc.y"
    {   print_alpha((yyvsp[(3) - (4)].n), 0);
	fputc('\n',yyout);
        /* all_old_nodes(); */
        YYACCEPT;
    }
    break;

  case 7:
#line 141 "yacc.y"
    {	if (yynerrs==errs || keep_on_error)
	{   alpha = new_list((yyvsp[(1) - (1)].n));
	    keep_tree((yyvsp[(1) - (1)].n));
	}
	else
	{   yywarning2(curr_sys->info.sys.name->info.id.name,
		     "had errors and was not output");
	    alpha = new_list(0);
        }
	keep_node(alpha);
	all_old_nodes();
	id_param = 0;
	curr_sys = 0;
    }
    break;

  case 8:
#line 157 "yacc.y"
    {	if (yynerrs==errs || keep_on_error)
	{   add_to_list(alpha, (yyvsp[(2) - (2)].n));
            keep_tree((yyvsp[(2) - (2)].n));
	}
	else yywarning2(curr_sys->info.sys.name->info.id.name,
		      "had errors and was not output");
	all_old_nodes();
	id_param = 0;
	curr_sys = 0;
    }
    break;

  case 9:
#line 172 "yacc.y"
    {   curr_sys->info.sys.inputs->type = inpsop;  /* type the dictionaries */
        curr_sys->info.sys.outputs->type = outsop; /* for print_alpha */
        (yyval.n) = curr_sys;
	id_context=(node *)0;
    }
    break;

  case 10:
#line 179 "yacc.y"
    {	curr_sys->info.sys.equations = (yyvsp[(3) - (3)].n);
	curr_sys->info.sys.inputs->type = inpsop;  /* type the dictionaries */
	curr_sys->info.sys.outputs->type = outsop; /* for print_alpha */
	curr_sys->info.sys.locals->type = locsop;  /* (makes comment labels)*/
	curr_sys->info.sys.equations->type = letop;
        (yyval.n) = curr_sys;
	id_context=(node *)0;
    }
    break;

  case 11:
#line 189 "yacc.y"
    {	/* print a nice intro */
        if (yynerrs>errs) fputc('\n',stderr); /* print \n if there were errs */
        errs=yynerrs;
        fprintf(stderr,"[%s]", (yyvsp[(2) - (2)].n)->info.id.name);

	/* make a new system */
        curr_sys = new_node(sys);
	curr_sys->info.sys.name = (yyvsp[(2) - (2)].n);
	curr_sys->info.sys.param = (node *)0;
	curr_sys->info.sys.equations = (node *)0;

	/* init the dictionaries */
	curr_sys->info.sys.inputs = new_list(0);
	curr_sys->info.sys.outputs = new_list(0);
	curr_sys->info.sys.locals = new_list(0);

	keep_tree(curr_sys);
    }
    break;

  case 13:
#line 210 "yacc.y"
    {   node *n;
	n = new_node(pol);
	n->info.pol.ref_count = 0;
	id_context = id_param = n->info.pol.index = new_list(0);
	n->info.pol.invert = 0;
	n->info.pol.p = Universe_Polyhedron(0);
	n->info.pol.m = (node *)0;
	curr_sys->info.sys.param = n;
        keep_node(id_param);
        keep_node(n);
    }
    break;

  case 14:
#line 223 "yacc.y"
    {	id_context = id_param = (yyvsp[(2) - (2)].n)->info.pol.index;
        curr_sys->info.sys.param = (yyvsp[(2) - (2)].n);
        keep_node(id_param);
        keep_node((yyvsp[(2) - (2)].n));
    }
    break;

  case 16:
#line 231 "yacc.y"
    {	check_no_param((yyvsp[(3) - (3)].n)->info.binop.l, id_param);
	declare_vars((yyvsp[(3) - (3)].n)->info.binop.l, (yyvsp[(3) - (3)].n)->info.binop.r,
                     inputvar, curr_sys->info.sys.inputs);
	all_old_nodes();
    }
    break;

  case 17:
#line 237 "yacc.y"
    {	check_no_param((yyvsp[(1) - (1)].n)->info.binop.l, id_param);
        declare_vars((yyvsp[(1) - (1)].n)->info.binop.l, (yyvsp[(1) - (1)].n)->info.binop.r,
                     inputvar, curr_sys->info.sys.inputs);
	all_old_nodes();
    }
    break;

  case 19:
#line 245 "yacc.y"
    {	check_no_param((yyvsp[(3) - (3)].n)->info.binop.l, id_param);
	check_no_variable((yyvsp[(3) - (3)].n)->info.binop.l, curr_sys->info.sys.inputs);
	declare_vars((yyvsp[(3) - (3)].n)->info.binop.l, (yyvsp[(3) - (3)].n)->info.binop.r,
                     outputvar, curr_sys->info.sys.outputs);
	all_old_nodes();
    }
    break;

  case 20:
#line 252 "yacc.y"
    {	check_no_param((yyvsp[(1) - (1)].n)->info.binop.l, id_param);
	check_no_variable((yyvsp[(1) - (1)].n)->info.binop.l, curr_sys->info.sys.inputs);
	declare_vars((yyvsp[(1) - (1)].n)->info.binop.l, (yyvsp[(1) - (1)].n)->info.binop.r,
                     outputvar, curr_sys->info.sys.outputs);
	all_old_nodes();
    }
    break;

  case 24:
#line 264 "yacc.y"
    {	check_no_param((yyvsp[(3) - (3)].n)->info.binop.l, id_param);
	check_no_variable((yyvsp[(3) - (3)].n)->info.binop.l, curr_sys->info.sys.inputs);
	check_no_variable((yyvsp[(3) - (3)].n)->info.binop.l, curr_sys->info.sys.outputs);
	declare_vars((yyvsp[(3) - (3)].n)->info.binop.l, (yyvsp[(3) - (3)].n)->info.binop.r,
		     localvar, curr_sys->info.sys.locals);
	all_old_nodes();
    }
    break;

  case 25:
#line 272 "yacc.y"
    {	check_no_param((yyvsp[(1) - (1)].n)->info.binop.l, id_param);
	check_no_variable((yyvsp[(1) - (1)].n)->info.binop.l, curr_sys->info.sys.inputs);
	check_no_variable((yyvsp[(1) - (1)].n)->info.binop.l, curr_sys->info.sys.outputs);
	declare_vars((yyvsp[(1) - (1)].n)->info.binop.l, (yyvsp[(1) - (1)].n)->info.binop.r,
		     localvar, curr_sys->info.sys.locals);
	all_old_nodes();
    }
    break;

  case 26:
#line 284 "yacc.y"
    {	(yyval.n) = new_node(defop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);		/* Ids */
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);		/* Type(domain, iotype, type) */
    }
    break;

  case 27:
#line 289 "yacc.y"
    {   (yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
    }
    break;

  case 28:
#line 292 "yacc.y"
    {   (yyval.n) = new_list((yyvsp[(1) - (1)].n));
    }
    break;

  case 29:
#line 296 "yacc.y"
    {	node *x, *i;
        (yyval.n) = (yyvsp[(1) - (1)].n);
	(yyval.n)->info.proto.domain                     = new_node(pol);
	(yyval.n)->info.proto.domain->info.pol.ref_count = 1;
        (yyval.n)->info.proto.domain->info.pol.invert    = 0;
        i = new_list(0);
        if (id_param) for (x=id_param->info.list.first; x; x=x->next)
        {  add_to_list(i, new_id(x->info.id.name));
        }
        (yyval.n)->info.proto.domain->info.pol.index     = i;
        (yyval.n)->info.proto.domain->info.pol.p         =
		Universe_Polyhedron(i->info.list.count);
	(yyval.n)->info.proto.domain->info.pol.m	  = 0;
    }
    break;

  case 30:
#line 312 "yacc.y"
    {	node *x, *i;
        (yyval.n) = (yyvsp[(1) - (6)].n);
	(yyval.n)->info.proto.coding = (yyvsp[(3) - (6)].n);
	(yyval.n)->info.proto.length = (yyvsp[(5) - (6)].n);
	(yyval.n)->info.proto.domain                     = new_node(pol);
	(yyval.n)->info.proto.domain->info.pol.ref_count = 1;
        (yyval.n)->info.proto.domain->info.pol.invert    = 0;
        i = new_list(0);
        if (id_param) for (x=id_param->info.list.first; x; x=x->next)
        {  add_to_list(i, new_id(x->info.id.name));
        }
        (yyval.n)->info.proto.domain->info.pol.index     = i;
        (yyval.n)->info.proto.domain->info.pol.p         =
		Universe_Polyhedron(i->info.list.count);
	(yyval.n)->info.proto.domain->info.pol.m	  = 0;
    }
    break;

  case 31:
#line 330 "yacc.y"
    {	(yyval.n) = (yyvsp[(3) - (3)].n);
	(yyval.n)->info.proto.domain = (yyvsp[(1) - (3)].n);
    }
    break;

  case 32:
#line 336 "yacc.y"
    {	(yyval.n) = (yyvsp[(3) - (8)].n);
	(yyval.n)->info.proto.domain = (yyvsp[(1) - (8)].n);
	(yyval.n)->info.proto.coding = (yyvsp[(5) - (8)].n);
	(yyval.n)->info.proto.length = (yyvsp[(7) - (8)].n);
    }
    break;

  case 33:
#line 344 "yacc.y"
    {	(yyval.n) = new_node(proto);
	(yyval.n)->info.proto.type = domtype;
	(yyval.n)->info.proto.domain = (yyvsp[(1) - (1)].n);
	(yyval.n)->info.proto.coding = (node *)0;
	(yyval.n)->info.proto.length = (node *)0;
    }
    break;

  case 34:
#line 352 "yacc.y"
    {	(yyval.n) = new_node(proto);
	(yyval.n)->info.proto.type = inttype;
	(yyval.n)->info.proto.domain = (node *)0;
	(yyval.n)->info.proto.coding = (node *)0;
	(yyval.n)->info.proto.length = (node *)0;
    }
    break;

  case 35:
#line 360 "yacc.y"
    {   (yyval.n) = new_node(proto);
        (yyval.n)->info.proto.type = booltype;
        (yyval.n)->info.proto.domain = (node *)0;
	(yyval.n)->info.proto.coding = (node *)0;
	(yyval.n)->info.proto.length = (node *)0;
    }
    break;

  case 36:
#line 368 "yacc.y"
    {   (yyval.n) = new_node(proto);
        (yyval.n)->info.proto.type = realtype;
        (yyval.n)->info.proto.domain = (node *)0;
	(yyval.n)->info.proto.coding = (node *)0;
	(yyval.n)->info.proto.length = (node *)0;
    }
    break;

  case 39:
#line 380 "yacc.y"
    {(yyval.n)=id_context;}
    break;

  case 40:
#line 381 "yacc.y"
    {	(yyval.n) = (yyvsp[(3) - (5)].n);
	(yyval.n)->type = letop;
	id_context = (yyvsp[(2) - (5)].n);
    }
    break;

  case 41:
#line 386 "yacc.y"
    {   (yyval.n) = new_list(0);
	(yyval.n)->type = letop;
    }
    break;

  case 42:
#line 391 "yacc.y"
    {	(yyval.n) = new_list((yyvsp[(1) - (1)].n));
    }
    break;

  case 43:
#line 394 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (2)].n), (yyvsp[(2) - (2)].n));
    }
    break;

  case 44:
#line 397 "yacc.y"
    {   (yyval.n) = (yyvsp[(1) - (3)].n);
	yyerrok;
    }
    break;

  case 45:
#line 402 "yacc.y"
    {	(yyval.n) = id_context;	/* save old context */
	context_domain = (yyvsp[(1) - (1)].n);	/* intersected with old context_domain ?? */
	id_context = context_domain->info.pol.index;	/* est. new context */
    }
    break;

  case 46:
#line 408 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n);
    }
    break;

  case 47:
#line 410 "yacc.y"
    { (yyval.n) = context_domain; }
    break;

  case 48:
#line 411 "yacc.y"
    {	(yyval.n) = new_node(restrictop);
        (yyval.n)->info.binop.l = (yyvsp[(3) - (4)].n);
        (yyval.n)->info.binop.r = (yyvsp[(4) - (4)].n);
	id_context = (yyvsp[(1) - (4)].n);		/* restore old context */
	context_domain = (node *) 0;
    }
    break;

  case 49:
#line 417 "yacc.y"
    { (yyval.n) = context_domain; }
    break;

  case 50:
#line 418 "yacc.y"
    {   (yyval.n) = new_node(loopop);
        (yyval.n)->info.binop.l = (yyvsp[(3) - (4)].n);
        (yyval.n)->info.binop.r = (yyvsp[(4) - (4)].n);
	id_context = (yyvsp[(1) - (4)].n);		/* restore old context */
	context_domain = (node *) 0;
    }
    break;

  case 51:
#line 428 "yacc.y"
    {(yyval.n) = id_context;}
    break;

  case 52:
#line 430 "yacc.y"
    {	(yyval.n) = new_node(use);
	(yyval.n)->info.use.extdom =(yyvsp[(3) - (13)].n);
	(yyval.n)->info.use.name =(yyvsp[(4) - (13)].n);
	(yyval.n)->info.use.param =(yyvsp[(5) - (13)].n);
	(yyval.n)->info.use.inputs =(yyvsp[(7) - (13)].n);
	(yyval.n)->info.use.outputs =(yyvsp[(11) - (13)].n);
        /* TODO AT LINK TIME : lookup $4 (ID)
           -- check that it has ($6->info.mat.m->NbRows) PARAMETERS
           -- check number and types of inputs
           -- check number and types of outputs
        */
	id_context = (yyvsp[(2) - (13)].n);	/* restore old context */
    }
    break;

  case 53:
#line 444 "yacc.y"
    {	(yyval.n) = curr_sys->info.sys.param;
	id_context = (yyval.n)->info.pol.index;
    }
    break;

  case 54:
#line 448 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n);
	id_context = (yyval.n)->info.pol.index;
    }
    break;

  case 55:
#line 452 "yacc.y"
    {	node *exp_list;
	exp_list = new_list( (node*)0 )  ;
	(yyval.n) = convert_constraints(exp_list, id_context->info.list.count, 1);
	(yyval.n)->info.mat.index = id_context;
	keep_node(id_context);
    }
    break;

  case 56:
#line 459 "yacc.y"
    {	if (id_lookup(id_context, (yyvsp[(2) - (3)].n))==-1)
	{   yyerror(
	"Cannot use array notation for instance parameters in this context.");
	}
	(yyval.n) = convert_constraints((yyvsp[(2) - (3)].n), id_context->info.list.count, 1);
	(yyval.n)->info.mat.index = id_context;
	keep_node(id_context);
    }
    break;

  case 57:
#line 468 "yacc.y"
    {	int i;
	node *x, *y;
    	node *exp_list;

	/* check that the last indices of id_context (new)  match $3 (old) */
	for (x = id_context->info.list.first,
	     y =         (yyvsp[(3) - (6)].n)->info.list.first,
	     i = id_context->info.list.count;
	     i>0; x=x->next, i--)
	{   if (i<=(yyvsp[(3) - (6)].n)->info.list.count) /* context incl. param */
	    {   if (strcmp(x->info.id.name, y->info.id.name))
		{   yywarning2(x->info.id.name,
			": index does not match use-context");
		}
		y=y->next;
	    }
	}

	exp_list = (yyvsp[(5) - (6)].n);
	/* don't add params to exp_list */

        id_lookup(id_context, exp_list);
	(yyval.n) = convert_constraints(exp_list, id_context->info.list.count, 1);
	(yyval.n)->info.mat.index = id_context;
	keep_node(id_context);
        /* restore id_context at end of use statement */
    }
    break;

  case 58:
#line 500 "yacc.y"
    {	(yyval.n) = new_node(equateop);
	(yyval.n)->info.binop.l = lhs;
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	id_context = (yyvsp[(1) - (3)].n);
    }
    break;

  case 59:
#line 507 "yacc.y"
    {	(yyval.n)=id_context;
	if (curr_sys)
        {   node *n;
	    /* check ID */
            n        =search_list(curr_sys->info.sys.outputs, (yyvsp[(1) - (1)].n)->info.id.name);
            if (!n) n=search_list(curr_sys->info.sys.locals,  (yyvsp[(1) - (1)].n)->info.id.name);
            if (!n)
            {  yyerror2((yyvsp[(1) - (1)].n)->info.id.name,"not declared as an output or local");
            }
            else
            {  if (n->info.id.type==domtype)
                  yyerror2((yyvsp[(1) - (1)].n)->info.id.name, "has no type in its declaration");
            }

            if (search_list(curr_sys->info.sys.inputs, (yyvsp[(1) - (1)].n)->info.id.name))
            {  yyerror2((yyvsp[(1) - (1)].n)->info.id.name, ": input variable used as LHS");
            }
            else if (search_list(id_param, (yyvsp[(1) - (1)].n)->info.id.name))
            {  yyerror2((yyvsp[(1) - (1)].n)->info.id.name, ": parameter used as LHS");
            }
            else if (search_list(id_context, (yyvsp[(1) - (1)].n)->info.id.name))
            {  yyerror2((yyvsp[(1) - (1)].n)->info.id.name, ": index used as LHS");
            }
        }
        lhs = (yyvsp[(1) - (1)].n);
    }
    break;

  case 60:
#line 534 "yacc.y"
    {	node *exp_list, *x, *n;

	(yyval.n) = id_context;	/* save old context */
	exp_list = (yyvsp[(3) - (4)].n);
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{   add_to_list(exp_list, new_id(x->info.id.name));
	}

	/* check LHS variable */
        if (curr_sys)
        {   n        =search_list(curr_sys->info.sys.outputs, (yyvsp[(1) - (4)].n)->info.id.name);
            if (!n) n=search_list(curr_sys->info.sys.locals,  (yyvsp[(1) - (4)].n)->info.id.name);
            if (!n)
            {  yyerror2((yyvsp[(1) - (4)].n)->info.id.name,"not declared as an output or local");
            }
            else
            {  if (n->info.id.type==domtype)
                  yyerror2((yyvsp[(1) - (4)].n)->info.id.name, "has no type in its declaration");
               if (exp_list->info.list.count !=
                      n->info.id.domain->info.pol.index->info.list.count)
               {  yyerror2((yyvsp[(1) - (4)].n)->info.id.name,
               ": dimension of LHS indices do not agree with declaration");
               }
            }

            if (search_list(curr_sys->info.sys.inputs, (yyvsp[(1) - (4)].n)->info.id.name))
            {   yyerror2((yyvsp[(1) - (4)].n)->info.id.name, ": input variable used as LHS");
            }
            else if (search_list(id_param, (yyvsp[(1) - (4)].n)->info.id.name))
            {   yyerror2((yyvsp[(1) - (4)].n)->info.id.name, ": parameter used as LHS");
            }
            else if (search_list(id_context, (yyvsp[(1) - (4)].n)->info.id.name))
            {  yyerror2((yyvsp[(1) - (4)].n)->info.id.name, ": index used as LHS");
            }
        }

	/* if a context domain exists, does the dimension of id_context
	   and the context domain match ? */

        if (id_context)		/* there is an external context */
        {   if (id_lookup(0,exp_list)!=1)   /* exp_list is not simple list */
	    {	node *m;
		id_lookup(id_context, exp_list);
		m = convert_constraints(exp_list,id_context->info.list.count,1);
		m->info.mat.index = id_context;
		keep_node(id_context);
		lhs = new_node(affineop);
		lhs->info.binop.l = (yyvsp[(1) - (4)].n);
		lhs->info.binop.r = m;
	    }
	    else
	    {	id_context = exp_list;  /* change the context */
		keep_node(id_context);
		/* update the indices of the declaration to be the same */
	        if (n) n->info.id.domain->info.pol.index = id_context;
		lhs = (yyvsp[(1) - (4)].n);
	    }
        }
        else
        {  id_context = exp_list;	/* establish the context */
	   keep_node(id_context);
	   if (n) n->info.id.domain->info.pol.index = id_context;
           if (id_lookup(0,exp_list)!=1)	/* exp_list is not trivial */
              yyerror("LHS has no context to support index expressions");
           lhs = (yyvsp[(1) - (4)].n);
        }
    }
    break;

  case 61:
#line 603 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
    }
    break;

  case 62:
#line 606 "yacc.y"
    {	(yyval.n) = new_list((yyvsp[(1) - (1)].n));
    }
    break;

  case 63:
#line 609 "yacc.y"
    {	(yyval.n) = new_list(0);
    }
    break;

  case 64:
#line 616 "yacc.y"
    {	Polyhedron *p1, *p2;
        (yyval.n) = (yyvsp[(1) - (1)].n);
        if ((yyval.n)->info.pol.invert!=0)
	{  p2 = (yyvsp[(1) - (1)].n)->info.pol.p;
	   p1 = Universe_Polyhedron(p2->Dimension);
	   (yyval.n)->info.pol.p = DomainDifference(p1, p2, MAXRAYS);
	   Domain_Free(p2);
	   Domain_Free(p1);
	   (yyval.n)->info.pol.invert=0; 
        }
    }
    break;

  case 65:
#line 629 "yacc.y"
    {	(yyval.n) = new_node(pol);
	(yyval.n)->info.pol.ref_count=0;
	(yyval.n)->info.pol.index = (yyvsp[(1) - (3)].n)->info.pol.index ? (yyvsp[(1) - (3)].n)->info.pol.index
						: (yyvsp[(3) - (3)].n)->info.pol.index;
        (yyval.n)->info.pol.m=(node *)0; 
        switch (2*(yyvsp[(1) - (3)].n)->info.pol.invert + (yyvsp[(3) - (3)].n)->info.pol.invert)
	{   case 0:  /* A | B */
              if (((yyvsp[(1) - (3)].n)->info.pol.m==0)&&((yyvsp[(3) - (3)].n)->info.pol.m==0)) 
                {/* pol union pol */
                  (yyval.n)->info.pol.invert=0;
                  (yyval.n)->info.pol.p= DomainUnion((yyvsp[(1) - (3)].n)->info.pol.p,
                                              (yyvsp[(3) - (3)].n)->info.pol.p, MAXRAYS);
                old_pol_node((yyvsp[(1) - (3)].n));
                old_pol_node((yyvsp[(3) - (3)].n)); 
                };
               if (((yyvsp[(1) - (3)].n)->info.pol.m!=0) || ((yyvsp[(3) - (3)].n)->info.pol.m!=0))
                {/* z-pol union z-pol */
                  node *n1;
                  /* print_alpha($1,1);
                     print_alpha($3,1);*/

                  (yyval.n) = (yyvsp[(1) - (3)].n);
                  /* $$ ->info.pol.p=Domain_Copy($1->info.pol.p);*/
                  for (n1=(yyval.n);n1->next;n1=n1->next)
                    {/* n1 will be the last zpol */}
                  n1->next=(yyvsp[(3) - (3)].n);
                  keep_node((yyvsp[(1) - (3)].n));
                  keep_node((yyvsp[(3) - (3)].n));
                };
              break;
	    case 1:  /* A | ~B  =  ~(~A & B) */
		(yyval.n)->info.pol.invert=1;
		(yyval.n)->info.pol.p= DomainDifference((yyvsp[(3) - (3)].n)->info.pol.p,
			(yyvsp[(1) - (3)].n)->info.pol.p, MAXRAYS);
                old_pol_node((yyvsp[(1) - (3)].n));
                old_pol_node((yyvsp[(3) - (3)].n)); 
		break;
	    case 2:  /* ~A | B  = ~(A & ~B) */
		(yyval.n)->info.pol.invert=0;
		(yyval.n)->info.pol.p= DomainDifference((yyvsp[(1) - (3)].n)->info.pol.p,
			(yyvsp[(3) - (3)].n)->info.pol.p, MAXRAYS);
                old_pol_node((yyvsp[(1) - (3)].n));
                old_pol_node((yyvsp[(3) - (3)].n)); 
		break;
	    case 3:  /* ~A | ~B  = ~(A&B) */
		(yyval.n)->info.pol.invert=1;
		(yyval.n)->info.pol.p= DomainIntersection((yyvsp[(1) - (3)].n)->info.pol.p,
			(yyvsp[(3) - (3)].n)->info.pol.p, MAXRAYS);
                old_pol_node((yyvsp[(1) - (3)].n));
                old_pol_node((yyvsp[(3) - (3)].n)); 
		break;
	}
    }
    break;

  case 66:
#line 683 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 67:
#line 686 "yacc.y"
    {	(yyval.n) = new_node(pol);
	(yyval.n)->info.pol.ref_count=0;
	(yyval.n)->info.pol.index = (yyvsp[(1) - (3)].n)->info.pol.index ? (yyvsp[(1) - (3)].n)->info.pol.index
						: (yyvsp[(3) - (3)].n)->info.pol.index;
        (yyval.n)->info.pol.m=(node *)0; 
	switch (2*(yyvsp[(1) - (3)].n)->info.pol.invert + (yyvsp[(3) - (3)].n)->info.pol.invert)
	{   case 0:  /* A & B */
		(yyval.n)->info.pol.invert=0;
		(yyval.n)->info.pol.p= DomainIntersection((yyvsp[(1) - (3)].n)->info.pol.p,
			(yyvsp[(3) - (3)].n)->info.pol.p, MAXRAYS);
		break;
	    case 1:  /* A & ~B */
		(yyval.n)->info.pol.invert=0;
		(yyval.n)->info.pol.p= DomainDifference((yyvsp[(1) - (3)].n)->info.pol.p,
			(yyvsp[(3) - (3)].n)->info.pol.p, MAXRAYS);
		break;
	    case 2:  /* ~A & B */
		(yyval.n)->info.pol.invert=0;
		(yyval.n)->info.pol.p= DomainDifference((yyvsp[(3) - (3)].n)->info.pol.p,
			(yyvsp[(1) - (3)].n)->info.pol.p, MAXRAYS);
		break;
	    case 3:  /* ~A & ~B  = ~(A | B) */
		(yyval.n)->info.pol.invert=1;
		(yyval.n)->info.pol.p= DomainUnion((yyvsp[(1) - (3)].n)->info.pol.p,
			(yyvsp[(3) - (3)].n)->info.pol.p, MAXRAYS);
		break;
	}
	old_pol_node((yyvsp[(1) - (3)].n));
	old_pol_node((yyvsp[(3) - (3)].n));
    }
    break;

  case 68:
#line 717 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 69:
#line 721 "yacc.y"
    {   (yyval.n) = new_node(pol);
        (yyval.n)->info.pol.ref_count = 0;
        (yyval.n)->info.pol.index = (yyvsp[(1) - (3)].n)->info.pol.index;
        (yyval.n)->info.pol.invert = (yyvsp[(1) - (3)].n)->info.pol.invert;
        (yyval.n)->info.pol.p =
          DomainPreimage((yyvsp[(1) - (3)].n)->info.pol.p, (yyvsp[(3) - (3)].n)->info.mat.m, MAXRAYS);
	(yyval.n)->info.pol.m = (node *)0;
        old_pol_node((yyvsp[(1) - (3)].n));
    }
    break;

  case 70:
#line 731 "yacc.y"
    {   (yyval.n) = new_node(pol);
        (yyval.n)->info.pol.ref_count = 0;
        (yyval.n)->info.pol.index = (yyvsp[(1) - (3)].n)->info.pol.index;
        (yyval.n)->info.pol.invert = (yyvsp[(1) - (3)].n)->info.pol.invert;
        (yyval.n)->info.pol.p = DomainConvex((yyvsp[(1) - (3)].n)->info.pol.p, MAXRAYS);
	(yyval.n)->info.pol.m = (node *)0;
        old_pol_node((yyvsp[(1) - (3)].n));
    }
    break;

  case 71:
#line 740 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 72:
#line 743 "yacc.y"
    {   if ((yyvsp[(2) - (2)].n)->info.pol.ref_count==0)
	{   (yyval.n) = (yyvsp[(2) - (2)].n);
	    (yyval.n)->info.pol.invert = !(yyval.n)->info.pol.invert;
	}
	else
	{   (yyval.n) = new_node(pol);
	    (yyval.n)->info.pol.ref_count=0;
	    (yyval.n)->info.pol.invert = !(yyvsp[(2) - (2)].n)->info.pol.invert;
	    (yyval.n)->info.pol.index = (yyvsp[(2) - (2)].n)->info.pol.index;
	    (yyval.n)->info.pol.p = Domain_Copy((yyvsp[(2) - (2)].n)->info.pol.p);
	    (yyval.n)->info.pol.m = (node *) 0;
	}
    }
    break;

  case 73:
#line 757 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 74:
#line 760 "yacc.y"
    {	node *n, *m, *x;
	node *indices;
	node *exp_list, *con_list;

	/* build a list of indices by scanning the function and constraints */
	exp_list = (yyvsp[(2) - (5)].n);
	con_list = (yyvsp[(4) - (5)].n);
	indices = new_list(0);
	indices = get_indices(indices, exp_list, id_context);
	indices = get_indices(indices, con_list, id_context);
	if (id_context) for (x=id_context->info.list.first; x; x=x->next)
	{  add_to_list(indices,  new_id(x->info.id.name));
	   add_to_list(exp_list, new_id(x->info.id.name));
	}
	keep_node(indices);

	/* build the function */
        id_lookup(indices, exp_list);
 	/* last arg=1 means function */
	m = convert_constraints(exp_list, indices->info.list.count, 1);

	/* build the polyhedron */
	id_lookup(indices, con_list);
	/* last arg=2 means constraints */
	n = convert_constraints(con_list, indices->info.list.count, 2);

	(yyval.n) = new_node(pol);
	(yyval.n)->info.pol.ref_count = 0;
	(yyval.n)->info.pol.invert = 0;
        (yyval.n)->info.pol.p = Constraints2Polyhedron(n->info.mat.m, MAXRAYS);

	Matrix_Free(n->info.mat.m);
	old_node(n);

	if (Matrix_is_Identity(m->info.mat.m))
	{  /* old fashioned polyhedron */
	   (yyval.n)->info.pol.m = (node *) 0;
	   (yyval.n)->info.pol.index = indices;  /* only if m is Id matrix */
	   Matrix_Free(m->info.mat.m);
	   old_node(m);
	}
	else
	{  /* z-polyhedron */
	   (yyval.n)->info.pol.m = m;
	   (yyval.n)->info.pol.index = new_list(0);	/* empty list */
	   m->info.mat.index = indices;
	   m->info.mat.ref_count=1;
	   keep_node(m);
	}
    }
    break;

  case 75:
#line 811 "yacc.y"
    {	node *n;
	node *indices;
	node *exp_list, *con_list;

	/* build a list of indices by scanning the function and constraints */
	exp_list = id_context;
	con_list = (yyvsp[(3) - (4)].n);
	indices = id_context;

	/* build the polyhedron */
	id_lookup(indices, con_list);
	/* last arg=2 means constraints */
	n = convert_constraints(con_list, indices->info.list.count, 2);

	(yyval.n) = new_node(pol);
	(yyval.n)->info.pol.ref_count = 0;
	(yyval.n)->info.pol.invert = 0;
        (yyval.n)->info.pol.p = Constraints2Polyhedron(n->info.mat.m, MAXRAYS);

	Matrix_Free(n->info.mat.m);
	old_node(n);

	/* old fashioned polyhedron */
	(yyval.n)->info.pol.m = (node *) 0;
	(yyval.n)->info.pol.index = indices;
    }
    break;

  case 76:
#line 838 "yacc.y"
    {	node *m, *x;
	node *indices;
	node *exp_list;

	/* build a list of indices by scanning the function and constraints */
	exp_list = (yyvsp[(2) - (4)].n);
	indices = new_list(0);
	indices = get_indices(indices, exp_list, id_context);
	if (id_context) for (x=id_context->info.list.first; x; x=x->next)
	{  add_to_list(indices,  new_id(x->info.id.name));
	   add_to_list(exp_list, new_id(x->info.id.name));
	}
	keep_node(indices);

	/* build the function */
        id_lookup(indices, exp_list);
 	/* last arg=1 means function */
	m = convert_constraints(exp_list, indices->info.list.count, 1);

	(yyval.n) = new_node(pol);
	(yyval.n)->info.pol.ref_count = 0;
	(yyval.n)->info.pol.invert = 0;
	(yyval.n)->info.pol.p = Universe_Polyhedron(exp_list->info.list.count);

	if (Matrix_is_Identity(m->info.mat.m))
	{  /* old fashioned polyhedron */
	   (yyval.n)->info.pol.m = (node *) 0;
	   (yyval.n)->info.pol.index = indices;  /* only if m is Id matrix */
	   Matrix_Free(m->info.mat.m);
	   old_node(m);
	}
	else
	{  /* z-polyhedron */
	   (yyval.n)->info.pol.m = m;
	   (yyval.n)->info.pol.index = new_list(0);	/* empty list */
	   m->info.mat.index = indices;
	   m->info.mat.ref_count=1;
	}
    }
    break;

  case 77:
#line 878 "yacc.y"
    {   (yyval.n) = new_node(pol);
        (yyval.n)->info.pol.ref_count = 0;
        (yyval.n)->info.pol.index = new_list(0);
        (yyval.n)->info.pol.invert = 0;
        (yyval.n)->info.pol.p = Empty_Polyhedron(0);
	(yyval.n)->info.pol.m = 0;
	yyerrok;
    }
    break;

  case 78:
#line 888 "yacc.y"
    {	(yyval.n) = (yyvsp[(2) - (3)].n); }
    break;

  case 79:
#line 890 "yacc.y"
    {	char *id = (yyvsp[(3) - (3)].n)->info.id.name;
        if (curr_sys)
        {  (yyval.n)          = search_list(curr_sys->info.sys.inputs, id);
	   if (!(yyval.n)) (yyval.n) = search_list(curr_sys->info.sys.outputs, id);
	   if (!(yyval.n)) (yyval.n) = search_list(curr_sys->info.sys.locals, id);
        } else (yyval.n) = (node *)0;
	if (!(yyval.n))
	{   yyerror2(id, "is not defined");
	    YYERROR;
	}
	else (yyval.n) = (yyval.n)->info.id.domain;
	if (!(yyval.n))
	{   yyerror2(id, "has no domain associated  with it");
	    YYERROR;
	}
	old_node((yyvsp[(3) - (3)].n));
    }
    break;

  case 80:
#line 909 "yacc.y"
    {	node *l_exp_list, *r_exp_list, *x, *indices, *ml;
	Matrix *m, *m2;

	/* build a list of indices by scanning the function and constraints */
	l_exp_list = (yyvsp[(2) - (5)].n);
	r_exp_list = (yyvsp[(4) - (5)].n);
	indices = new_list(0);
	indices = get_indices(indices, l_exp_list, id_param);
	indices = get_indices(indices, r_exp_list, id_param);
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{  add_to_list(indices, new_id(x->info.id.name));
	   add_to_list(l_exp_list, new_id(x->info.id.name));
	   add_to_list(r_exp_list, new_id(x->info.id.name));
	}
	keep_node(indices);

	/* build the left side function */
        id_lookup(indices, l_exp_list);
 	/* last arg=1 means function */
	ml = convert_constraints(l_exp_list, indices->info.list.count, 1);

	/* build the right side function */
        id_lookup(indices, r_exp_list);
 	/* last arg=1 means function */
	(yyval.n) = convert_constraints(r_exp_list, indices->info.list.count, 1);

	if (Matrix_is_Identity(ml->info.mat.m))
	{  (yyval.n)->info.mat.index = indices;
	}
	else
	{  m = Matrix_Alloc(ml->info.mat.m->NbRows, ml->info.mat.m->NbColumns);
	   if (!Matrix_Inverse(ml->info.mat.m, m))
	   {  (yyval.n)->info.mat.index = indices;
	      yyerror("Improper affine function. Left side not invertable.");
	   }
	   else
	   {  m2 = Matrix_Alloc((yyval.n)->info.mat.m->NbRows, m->NbColumns);
              Matrix_Product((yyval.n)->info.mat.m, m, m2);
              Matrix_Free((yyval.n)->info.mat.m);
	      (yyval.n)->info.mat.m = m2;
	      (yyval.n)->info.mat.index = new_list(0);	/* empty list */
	   }
	   Matrix_Free(m);
	}
	Matrix_Free(ml->info.mat.m);
	old_node(ml);
    }
    break;

  case 81:
#line 961 "yacc.y"
    {   (yyval.n) = merge_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n)); }
    break;

  case 82:
#line 963 "yacc.y"
    {   (yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 83:
#line 966 "yacc.y"
    {   (yyval.n) = convert_suite((yyvsp[(1) - (1)].n)); }
    break;

  case 84:
#line 968 "yacc.y"
    {   (yyval.n) = convert_suite((yyvsp[(1) - (1)].n)); }
    break;

  case 85:
#line 970 "yacc.y"
    {	(yyval.n) = convert_suite((yyvsp[(1) - (1)].n)); }
    break;

  case 86:
#line 973 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = eqop;
    }
    break;

  case 87:
#line 977 "yacc.y"
    {	(yyval.n) = add_to_list(new_list((yyvsp[(1) - (3)].n)), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = eqop;
    }
    break;

  case 88:
#line 982 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = gtop;
    }
    break;

  case 89:
#line 986 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = geop;
    }
    break;

  case 90:
#line 990 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = eqop;
    }
    break;

  case 91:
#line 994 "yacc.y"
    {   yyerror("cannot have '<' in a decreasing sequence");
	(yyval.n) = (yyvsp[(1) - (3)].n);
    }
    break;

  case 92:
#line 998 "yacc.y"
    {   yyerror("cannot have '<=' in a decreasing sequence");
	(yyval.n) = (yyvsp[(1) - (3)].n);
    }
    break;

  case 93:
#line 1003 "yacc.y"
    {	(yyval.n) = add_to_list(new_list((yyvsp[(1) - (3)].n)), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = gtop;
    }
    break;

  case 94:
#line 1007 "yacc.y"
    {	(yyval.n) = add_to_list(new_list((yyvsp[(1) - (3)].n)), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = geop;
    }
    break;

  case 95:
#line 1012 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = ltop;
    }
    break;

  case 96:
#line 1016 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = leop;
    }
    break;

  case 97:
#line 1020 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = eqop;
    }
    break;

  case 98:
#line 1024 "yacc.y"
    {   yyerror("cannot have '>' in an increasing sequence");
	(yyval.n) = (yyvsp[(1) - (3)].n);
    }
    break;

  case 99:
#line 1028 "yacc.y"
    {   yyerror("cannot have '>=' in an increasing sequence");
	(yyval.n) = (yyvsp[(1) - (3)].n);
    }
    break;

  case 100:
#line 1033 "yacc.y"
    {	(yyval.n) = add_to_list(new_list((yyvsp[(1) - (3)].n)), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = ltop;
    }
    break;

  case 101:
#line 1037 "yacc.y"
    {	(yyval.n) = add_to_list(new_list((yyvsp[(1) - (3)].n)), (yyvsp[(3) - (3)].n));
	(yyvsp[(3) - (3)].n)->type = leop;
    }
    break;

  case 102:
#line 1045 "yacc.y"
    {   char *id;
	if (curr_sys)
	{   id = (yyvsp[(1) - (1)].n)->info.id.name;
	    if (search_list(curr_sys->info.sys.inputs, id))
		yywarning3("Index", id, "is declared as an input.");
	    if (search_list(curr_sys->info.sys.outputs, id))
		yywarning3("Index", id, "is declared as an output.");
	    if (search_list(curr_sys->info.sys.locals, id))
		yywarning3("Index", id, "is declared as a local.");
	}
	(yyval.n)=(yyvsp[(1) - (1)].n);
    }
    break;

  case 103:
#line 1058 "yacc.y"
    {	(yyval.n)=(yyvsp[(1) - (1)].n);
    }
    break;

  case 104:
#line 1062 "yacc.y"
    {   char tmp[64];
        tmp[0] = '\0';
        strcat(tmp, (yyvsp[(1) - (3)].n)->info.id.name);
        strcat(tmp, ":");
        strcat(tmp, (yyvsp[(3) - (3)].n)->info.id.name);
        (yyval.n)=new_id(tmp);
        old_node((yyvsp[(1) - (3)].n));
        old_node((yyvsp[(3) - (3)].n));
    }
    break;

  case 105:
#line 1073 "yacc.y"
    {   /* check_no_param($1, $3); */
	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
    }
    break;

  case 106:
#line 1077 "yacc.y"
    {   (yyval.n) = new_list((yyvsp[(1) - (1)].n));
    }
    break;

  case 107:
#line 1092 "yacc.y"
    {	node *x;
	(yyval.n) = id_context;	/* return old context */
	id_context=new_list(0); /* establish new context */
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{   add_to_list(id_context, new_id(x->info.id.name));
	}
    }
    break;

  case 108:
#line 1100 "yacc.y"
    {	node *x;
        (yyval.n) = id_context;	/* return old context */
	id_context = (yyvsp[(1) - (1)].n);	/* establish new context */
	if (id_param)
	{   check_no_param(id_context, id_param);
	    for (x=id_param->info.list.first; x; x=x->next)
	    {	add_to_list(id_context, new_id(x->info.id.name));
	    }
	}
    }
    break;

  case 109:
#line 1139 "yacc.y"
    {	(yyval.n) = new_list(0);
    }
    break;

  case 110:
#line 1142 "yacc.y"
    {   (yyval.n) = (yyvsp[(1) - (1)].n);
    }
    break;

  case 111:
#line 1146 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(2) - (5)].n), (yyvsp[(4) - (5)].n));
    }
    break;

  case 112:
#line 1149 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n));
    }
    break;

  case 113:
#line 1152 "yacc.y"
    {   (yyval.n) = new_list((yyvsp[(1) - (1)].n));
    }
    break;

  case 114:
#line 1156 "yacc.y"
    {	(yyval.n) = new_node((yyvsp[(2) - (3)].i));
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 115:
#line 1161 "yacc.y"
    {    if ((yyvsp[(2) - (2)].n)->type==icons)
        {   (yyvsp[(2) - (2)].n)->info.icons.value = -((yyvsp[(2) - (2)].n)->info.icons.value);
            (yyval.n) = (yyvsp[(2) - (2)].n);
        }
        else
        {   (yyval.n) = new_node(negop);
            (yyval.n)->info.unop.c = (yyvsp[(2) - (2)].n);
        }
    }
    break;

  case 116:
#line 1171 "yacc.y"
    {   (yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 117:
#line 1174 "yacc.y"
    {   (yyval.n) = new_node(mulop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (2)].n);
        (yyval.n)->info.binop.r = (yyvsp[(2) - (2)].n);
    }
    break;

  case 118:
#line 1179 "yacc.y"
    {	(yyval.n) = new_node(divop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 119:
#line 1184 "yacc.y"
    {	(yyval.n) = (yyvsp[(2) - (3)].n); }
    break;

  case 120:
#line 1186 "yacc.y"
    {   (yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 121:
#line 1188 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 122:
#line 1190 "yacc.y"
    {	(yyval.i) = addop; }
    break;

  case 123:
#line 1191 "yacc.y"
    {	(yyval.i) = subop; }
    break;

  case 124:
#line 1197 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (2)].n); }
    break;

  case 125:
#line 1199 "yacc.y"
    {   (yyval.n) = (node *)0;
        yyerrok;
    }
    break;

  case 126:
#line 1204 "yacc.y"
    {   (yyval.n) = new_node(ifop);
        (yyval.n)->info.triop.l = (yyvsp[(2) - (6)].n);
        (yyval.n)->info.triop.c = (yyvsp[(4) - (6)].n);
        (yyval.n)->info.triop.r = (yyvsp[(6) - (6)].n); }
    break;

  case 127:
#line 1209 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 128:
#line 1215 "yacc.y"
    {	(yyval.n) = new_node(restrictop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n); }
    break;

  case 129:
#line 1219 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 130:
#line 1222 "yacc.y"
    {   (yyval.n) = new_node(orop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
        (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 131:
#line 1227 "yacc.y"
    {   (yyval.n) = new_node(xorop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
        (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 132:
#line 1232 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 133:
#line 1235 "yacc.y"
    {   (yyval.n) = new_node(andop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
        (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 134:
#line 1240 "yacc.y"
    {   (yyval.n) = new_node(minop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
        (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 135:
#line 1245 "yacc.y"
    {   (yyval.n) = new_node(maxop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
        (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 136:
#line 1250 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 137:
#line 1253 "yacc.y"
    {   (yyval.n) = new_node(notop);
	(yyval.n)->info.unop.c = (yyvsp[(2) - (2)].n);
    }
    break;

  case 138:
#line 1258 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 139:
#line 1261 "yacc.y"
    {	(yyval.n) = new_node((yyvsp[(2) - (3)].i));
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 140:
#line 1266 "yacc.y"
    {   (yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 141:
#line 1268 "yacc.y"
    {	(yyval.i) = eqop; }
    break;

  case 142:
#line 1269 "yacc.y"
    {	(yyval.i) = gtop; }
    break;

  case 143:
#line 1270 "yacc.y"
    {	(yyval.i) = geop; }
    break;

  case 144:
#line 1271 "yacc.y"
    {	(yyval.i) = ltop; }
    break;

  case 145:
#line 1272 "yacc.y"
    {	(yyval.i) = leop; }
    break;

  case 146:
#line 1273 "yacc.y"
    {	(yyval.i) = neop; }
    break;

  case 147:
#line 1276 "yacc.y"
    {   if ((((yyvsp[(1) - (3)].n)->type==xaddop)||((yyvsp[(1) - (3)].n)->type==xsubop)) &&
	    (((yyvsp[(3) - (3)].n)->type==xaddop)||((yyvsp[(3) - (3)].n)->type==xsubop)))
	{   (yyval.n) = new_node(xaddop);
            (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
            (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	    (yyval.n)->info.binop.index = (yyvsp[(1) - (3)].n)->info.binop.index;
	}
	else
        {   (yyval.n) = new_node(addop);
	    (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	    (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	}
    }
    break;

  case 148:
#line 1290 "yacc.y"
    {   if ((((yyvsp[(1) - (3)].n)->type==xaddop)||((yyvsp[(1) - (3)].n)->type==xsubop)) &&
	    (((yyvsp[(3) - (3)].n)->type==xaddop)||((yyvsp[(3) - (3)].n)->type==xsubop)))
	{   (yyval.n) = new_node(xsubop);
            (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
            (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	    (yyval.n)->info.binop.index = (yyvsp[(1) - (3)].n)->info.binop.index;
	}
	else
        {   (yyval.n) = new_node(subop);
	    (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	    (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	}
    }
    break;

  case 149:
#line 1304 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 150:
#line 1307 "yacc.y"
    {	(yyval.n) = new_node(mulop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 151:
#line 1312 "yacc.y"
    {	(yyval.n) = new_node(divop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 152:
#line 1317 "yacc.y"
    {	(yyval.n) = new_node(idivop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 153:
#line 1322 "yacc.y"
    {	(yyval.n) = new_node(modop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
    }
    break;

  case 154:
#line 1327 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 155:
#line 1330 "yacc.y"
    {	if (((yyvsp[(2) - (2)].n)->type==xaddop)||((yyvsp[(2) - (2)].n)->type==xsubop))
	{   (yyval.n) = new_node(xsubop);
	    (yyval.n)->info.binop.l=0;
	    (yyval.n)->info.binop.r=(yyvsp[(2) - (2)].n);
	    (yyval.n)->info.binop.index = (yyvsp[(2) - (2)].n)->info.binop.index;
	}
	else if ((yyvsp[(2) - (2)].n)->type==icons)
	{   (yyvsp[(2) - (2)].n)->info.icons.value = -((yyvsp[(2) - (2)].n)->info.icons.value); 
	    (yyval.n) = (yyvsp[(2) - (2)].n);
	}
	else
	{   (yyval.n) = new_node(negop);
	    (yyval.n)->info.unop.c = (yyvsp[(2) - (2)].n);
	}
    }
    break;

  case 156:
#line 1346 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 157:
#line 1349 "yacc.y"
    {	if ((yyvsp[(1) - (3)].n)->type==affineop)
	{   Matrix *m1, *m2, *m3;
	    m1 = (yyvsp[(1) - (3)].n)->info.binop.r->info.mat.m;
	    m2 = (yyvsp[(3) - (3)].n)->info.mat.m;
	    /* check dimensions */
	    if (m1->NbColumns!=m2->NbRows)
	    {   yyerror("dimensions of affine functions do not agree");
		(yyval.n) = new_node(affineop);
		(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
		(yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	    }
	    else
	    {	m3 = Matrix_Alloc(m1->NbRows, m2->NbColumns); 
		Matrix_Product(m1, m2, m3);
		Matrix_Free(m1); (yyvsp[(1) - (3)].n)->info.binop.r->info.mat.m = 0;
		Matrix_Free(m2); (yyvsp[(3) - (3)].n)->info.mat.m = 0;
		(yyvsp[(1) - (3)].n)->info.binop.r->info.mat.m = m3;

		/* fix up the indices */
		(yyvsp[(1) - (3)].n)->info.binop.r->info.mat.index = (yyvsp[(3) - (3)].n)->info.mat.index;
		(yyvsp[(3) - (3)].n)->info.mat.index=(node *)0;
		(yyval.n) = (yyvsp[(1) - (3)].n);
	    }
	}
	else if (((yyvsp[(1) - (3)].n)->type==xaddop)||((yyvsp[(1) - (3)].n)->type==xsubop))
	{   (yyval.n) = new_node(affineop);
	    /* is the xaddop just an integer const ? */
	    if (!(yyvsp[(1) - (3)].n)->info.binop.r && (yyvsp[(1) - (3)].n)->info.binop.l->type==icons)
		(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n)->info.binop.l;
	    else
		(yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	    /* create new matrix */
	    if ((yyvsp[(3) - (3)].n)->info.mat.index->info.list.count>0)
	    {   node *exp_list;
	        exp_list = new_list(0);	/* constants are dim 0 */
                id_lookup((yyvsp[(3) - (3)].n)->info.mat.index, exp_list);
	        (yyval.n)->info.binop.r = convert_constraints(exp_list,
                                   (yyvsp[(3) - (3)].n)->info.mat.index->info.list.count, 1);
	        (yyval.n)->info.binop.r->info.mat.index = (yyvsp[(3) - (3)].n)->info.mat.index;
	        old_node(exp_list);
	        /* deallocate old unused $3 */
	        Matrix_Free((yyvsp[(3) - (3)].n)->info.mat.m);
	        (yyvsp[(3) - (3)].n)->info.mat.index = (node *)0;
	        old_node((yyvsp[(3) - (3)].n));
	    }
	    else (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	}
	else
	{   (yyval.n) = new_node(affineop);
	    (yyval.n)->info.binop.l = (yyvsp[(1) - (3)].n);
	    (yyval.n)->info.binop.r = (yyvsp[(3) - (3)].n);
	}
    }
    break;

  case 158:
#line 1403 "yacc.y"
    {   node *exp_list, *x, *M2;

        /* if (!id_context) yyerror("[...] missing on LHS of this equation"); */

	/* add the parameters to the exp list */
        exp_list = (yyvsp[(3) - (4)].n);
	if (id_param)
        for (x=id_param->info.list.first; x; x=x->next)
        {  add_to_list(exp_list, new_id(x->info.id.name));
        }

	/* create the mat */
	id_lookup(id_context, exp_list);
	M2 = convert_constraints(exp_list, id_context->info.list.count, 1);
	M2->info.mat.index = id_context;
	keep_node(id_context);
	old_node(exp_list);

	if ((yyvsp[(1) - (4)].n)->type==affineop)
        {   Matrix *m1, *m2, *m3;
	    /* combine affines */
	    m1 = (yyvsp[(1) - (4)].n)->info.binop.r->info.mat.m;
 	    m2 = M2->info.mat.m;
	    /* check dimensions */
            if (m1->NbColumns!=m2->NbRows)
            {   yyerror("dimensions of affine functions do not agree");
		(yyval.n) = new_node(affineop);
		(yyval.n)->info.binop.l = (yyvsp[(1) - (4)].n);
		(yyval.n)->info.binop.r = M2;
            }
            else
            {	m3 = Matrix_Alloc(m1->NbRows, m2->NbColumns);
		Matrix_Product(m1, m2, m3);
		Matrix_Free(m1); (yyvsp[(1) - (4)].n)->info.binop.r->info.mat.m = 0;
		Matrix_Free(m2); M2->info.mat.m = 0;
		(yyvsp[(1) - (4)].n)->info.binop.r->info.mat.m = m3;

		/* fix up the indices */
		(yyvsp[(1) - (4)].n)->info.binop.r->info.mat.index = M2->info.mat.index;
		M2->info.mat.index=(node *)0;
		(yyval.n) = (yyvsp[(1) - (4)].n);
            }
        }
	else if (((yyvsp[(1) - (4)].n)->type==xaddop)||((yyvsp[(1) - (4)].n)->type==xsubop))
	{   (yyval.n) = new_node(affineop);
	    /* is the xaddop just an integer const ? */
	    if (!(yyvsp[(1) - (4)].n)->info.binop.r && (yyvsp[(1) - (4)].n)->info.binop.l->type==icons)
		(yyval.n)->info.binop.l = (yyvsp[(1) - (4)].n)->info.binop.l;
	    else
		(yyval.n)->info.binop.l = (yyvsp[(1) - (4)].n);
	    /* create new matrix to force M2 = (id_context -> ) */
	    if (id_context && id_context->info.list.count>0)
	    {   node *exp_list;
	        /* deallocate old M2 */
	        Matrix_Free(M2->info.mat.m);
	        M2->info.mat.index = (node *)0;
	        old_node(M2);
	        /* create new M2 */
	        exp_list = new_list(0); /* constants are dim 0 */
                id_lookup(id_context, exp_list);
                M2=convert_constraints(exp_list,id_context->info.list.count,1);
	        M2->info.mat.index = id_context;
	        keep_node(id_context);
	        old_node(exp_list);
	        /* build result */
	        (yyval.n)->info.binop.r = M2;
	    }
	    else (yyval.n)->info.binop.r = M2;
	}
        else
        {   (yyval.n) = new_node(affineop);
	    (yyval.n)->info.binop.l = (yyvsp[(1) - (4)].n);
	    (yyval.n)->info.binop.r = M2;
	}
    }
    break;

  case 159:
#line 1480 "yacc.y"
    {	(yyval.n) = (yyvsp[(1) - (1)].n); }
    break;

  case 160:
#line 1484 "yacc.y"
    {   node *exp_list, *x;

        exp_list = (yyvsp[(4) - (5)].n);
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{  add_to_list(exp_list, new_id(x->info.id.name));
	}

	id_lookup(id_context, exp_list);
	(yyval.n) = convert_constraints(exp_list,id_context->info.list.count, 1);
	(yyval.n)->info.mat.index = id_context;
	keep_node(id_context);
	/* don't restore context until after reduce */
    }
    break;

  case 161:
#line 1499 "yacc.y"
    {   char *id = (yyvsp[(1) - (1)].n)->info.id.name;
        if (curr_sys)
        {   if (search_list(curr_sys->info.sys.inputs, id))
                (yyval.n)->type = var;
            else if (search_list(curr_sys->info.sys.outputs, id))
                (yyval.n)->type = var;
            else if (search_list(curr_sys->info.sys.locals, id))
                (yyval.n)->type = var;
            else if (search_list(id_param, id))
                (yyval.n)->type = parameter;
            else yyerror2(id, "is not defined");
        }
        else (yyval.n)->type = var;
     	(yyval.n) = (yyvsp[(1) - (1)].n);
    }
    break;

  case 162:
#line 1514 "yacc.y"
    { (yyval.n) = id_context; id_context = (node *) 0; }
    break;

  case 163:
#line 1516 "yacc.y"
    {	(yyval.n) = new_node(reduce);
	(yyval.n)->info.reduce.op = (yyvsp[(4) - (9)].i);
	(yyval.n)->info.reduce.proj = (yyvsp[(6) - (9)].n);
	(yyval.n)->info.reduce.exp = (yyvsp[(8) - (9)].n);
	id_context = (yyvsp[(3) - (9)].n);
    }
    break;

  case 164:
#line 1523 "yacc.y"
    {	(yyval.n) = new_node(callop);
	(yyval.n)->info.binop.l = (yyvsp[(1) - (4)].n);
	(yyval.n)->info.binop.r = (yyvsp[(3) - (4)].n);
        /* TODO
           lookup $1 (ID) check that
	      - no parameters
	      - any number of scalar inputs
	      - a single scalar output
           format as a use ???
        */
    }
    break;

  case 165:
#line 1535 "yacc.y"
    {	(yyval.n) = new_node((yyvsp[(1) - (6)].i));
	(yyval.n)->info.binop.l = (yyvsp[(3) - (6)].n);
	(yyval.n)->info.binop.r = (yyvsp[(5) - (6)].n);
    }
    break;

  case 166:
#line 1540 "yacc.y"
    {	(yyval.n) = new_node(sqrtop);
	(yyval.n)->info.unop.c = (yyvsp[(3) - (4)].n);
    }
    break;

  case 167:
#line 1544 "yacc.y"
    {	(yyval.n) = new_node(absop);
	(yyval.n)->info.unop.c = (yyvsp[(3) - (4)].n);
    }
    break;

  case 168:
#line 1549 "yacc.y"
    {   node *exp_list;

	/* the programmer is reponsible for going (id_context->id_param)
	   this simply goes (id_param->) */
	/* the overall effect is (id_context->) */
        exp_list = new_list(0);
        id_lookup(id_param, exp_list);
        (yyval.n) = convert_constraints(exp_list,id_param->info.list.count, 1);
        (yyval.n)->info.mat.index = id_param;
	old_node(exp_list);
    }
    break;

  case 169:
#line 1563 "yacc.y"
    {	(yyval.n) = new_node(xaddop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (1)].n);
        (yyval.n)->info.binop.r = 0;
	(yyval.n)->info.binop.index = id_context;
	keep_node(id_context);
    }
    break;

  case 170:
#line 1570 "yacc.y"
    {   (yyval.n) = new_node(xaddop);
        (yyval.n)->info.binop.l = new_node(mulop);
	(yyval.n)->info.binop.l->info.binop.l=(yyvsp[(1) - (2)].n);
	(yyval.n)->info.binop.l->info.binop.r=(yyvsp[(2) - (2)].n);
        (yyval.n)->info.binop.r = 0;
	(yyval.n)->info.binop.index = id_context;
	keep_node(id_context);
    }
    break;

  case 171:
#line 1579 "yacc.y"
    {   (yyval.n) = new_node(xaddop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (1)].n);
        (yyval.n)->info.binop.r = 0;
	(yyval.n)->info.binop.index = id_context;
	keep_node(id_context);
    }
    break;

  case 172:
#line 1586 "yacc.y"
    {   (yyval.n) = new_node(affineop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (2)].n);
        (yyval.n)->info.binop.r = (yyvsp[(2) - (2)].n);
    }
    break;

  case 173:
#line 1591 "yacc.y"
    {   (yyval.n) = new_node(affineop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (2)].n);
        (yyval.n)->info.binop.r = (yyvsp[(2) - (2)].n);
    }
    break;

  case 174:
#line 1596 "yacc.y"
    {   (yyval.n) = new_node(affineop);
        (yyval.n)->info.binop.l = (yyvsp[(1) - (2)].n);
        (yyval.n)->info.binop.r = (yyvsp[(2) - (2)].n);
    }
    break;

  case 175:
#line 1601 "yacc.y"
    {	(yyval.n) = (yyvsp[(2) - (3)].n); }
    break;

  case 176:
#line 1603 "yacc.y"
    {	(yyval.n) = new_node(caseop);
	(yyval.n)->info.unop.c = (yyvsp[(2) - (3)].n);
    }
    break;

  case 177:
#line 1608 "yacc.y"
    {   (yyval.n) = new_list((yyvsp[(1) - (1)].n)); }
    break;

  case 178:
#line 1610 "yacc.y"
    {	(yyval.n) = add_to_list((yyvsp[(1) - (2)].n), (yyvsp[(2) - (2)].n)); }
    break;

  case 179:
#line 1612 "yacc.y"
    {	(yyval.i) = addop; }
    break;

  case 180:
#line 1613 "yacc.y"
    {	(yyval.i) = mulop; }
    break;

  case 181:
#line 1614 "yacc.y"
    {	(yyval.i) = andop; }
    break;

  case 182:
#line 1615 "yacc.y"
    {	(yyval.i) = orop; }
    break;

  case 183:
#line 1616 "yacc.y"
    {	(yyval.i) = xorop; }
    break;

  case 184:
#line 1617 "yacc.y"
    {	(yyval.i) = minop; }
    break;

  case 185:
#line 1618 "yacc.y"
    {	(yyval.i) = maxop; }
    break;

  case 186:
#line 1620 "yacc.y"
    {	(yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 187:
#line 1621 "yacc.y"
    {	(yyval.i) = divop; }
    break;

  case 188:
#line 1622 "yacc.y"
    {	(yyval.i) = modop; }
    break;


/* Line 1267 of yacc.c.  */
#line 3735 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 1629 "yacc.y"

#include "lex.c"

void init_parse(c)
int c;
{   yyrestart(yyin);	/* setup yyin as source */
    lineNb = 1;		/* line number 1 */
    BEGIN sentences;	/* begin lexical analyzer in state `sentences'*/
    yyunput(c,yy_c_buf_p);/* put c as first character in buffer */
    yy_init = 0;	/* disable auto init which clears buffer */
    YY_CURRENT_BUFFER->yy_buffer_status = YY_BUFFER_NORMAL;
}

