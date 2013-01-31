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




/* Copy the first part of user declarations.  */
#line 21 "yacc.y"

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "node.h"
#include "item.h"
#include "nodeprocs.h"
#include "node2item.h"
#include "itemprocs.h"
#include "writeitem.h"

typedef
struct entry_{
         item           *id_item;
	 node           *id_node_list;
	 struct entry_  *next;
       }entry;


int	lineNb;		/* Current input line number */
item	*alpha;		/* The alpha tree */
int	thesystem;	/* The selected system number */
int	latexLayout;
int deb=1;      /* used for temporary debug */

/* globals */
static node *ID_List_Save=(node *)0;  /* ids of the last Domain parsed */
static int  D_Save=0;		/* dimension of the last Domain parsed */
static node *ID_context=(node *)0;	/* ids context */
static node *Param_List_Save=(node *)0;
static int  array_mode=0;	/* when set to 1 to enable array mode */
static int  eflag=0;		/* enable array notation */
static int  annote_flag=0;	/* set to 1 to unhide annotations */
static int  use_flag=0;		/* set to 1 during a use */
static int  G_dim=0;		/* dimension of parameter space */
static int  dpflag=0;		/* set to one during dependency tables */
static int  z_flag=0;		/* set to 1 during zpol */
static entry *Dictionary = (entry *) 0;
static item *DepMatIDS=(item *)0;
static item *Mat_Save=(item *)0;

static void insertIDdecl(iditem, idlistnode)
item  *iditem;
node  *idlistnode;
  { entry       *new;
    /* create entry */
    new = (entry *) malloc(sizeof(entry));
    new->id_item = iditem;
    new->id_node_list = idlistnode;
    /* add entry to Dictionary */
    new->next = Dictionary;
    Dictionary = new;
    /* return new updated dictionary */
    return;
  }

static node  *lookupIDdecl(identity)
item  *identity;
  { entry       *current;
    /* walk down list */
    for ( current=Dictionary; current!=(entry *)0; current=current->next )
    {  /* test item */
       if (strcmp(current->id_item->the.text.string,identity->the.text.string)==0)
       { return current->id_node_list;}
    }
    /*
      fprintf(stderr,"Could not find definition of declared variable\n"); */
  }

static int lengthof(idlist)
node *idlist;
  { node     *current;
    int      count;
    
    for (current=idlist, count=0; current; current=current->next, count++);
    return count;
  }

/*------------------------------------------------------- Tex_itemizeList ---*/
static
item*
Tex_itemizeList(list, sep)
  item* list;  /* list of item */
  int sep;     /* if sep == 1 then ";" are add at the end of each item */
{
  item* ec;
  item* beginResult;
  item* endResult;

  static char itemSymbol[] = "\\item[] $\\!\\!\\!\\!\\!\\!\\!\\!\\!\\!\\!\\!$ ";

  if(list != 0) {
    ec = list;
    beginResult = Hsep2(0, "", Text(itemSymbol), Copy(ec));
    beginResult->next = 0;
    endResult = beginResult;
    for(ec = ec->next; ec != 0; ec = ec->next) {
      endResult->next = Hsep2(0, "", Text(itemSymbol), Copy(ec));
      endResult = endResult->next;
      endResult->next = 0;
    }
  }

  beginResult = Vlis(0, ((sep == 1) ? ";" : ""), beginResult);

  return Venc(0, Text("\\begin{itemize}"), Text("\\end{itemize}"),
              beginResult);
}



/* words used for the tex layout */
#define OW_system ((latexLayout == 1) ? "{\\bf system} " : "system ")
#define OW_returns ((latexLayout == 1) ? "{\\bf returns} " : "returns ")
#define OW_case ((latexLayout == 1) ? "\\\\{\\bf case}" : "case")
#define OW_esac ((latexLayout == 1) ? "{\\bf esac}" : "esac")
#define OW_of ((latexLayout == 1) ? " {\\bf of}" : " of")
#define OW_let ((latexLayout == 1) ? "{\\bf let}" : "let")
#define OW_tel ((latexLayout == 1) ? "{\\bf tel};" : "tel;")
#define OW_rightarrow ((latexLayout == 1) ? " $\\rightarrow$ " : " -> ")
#define OW_Rightarrow ((latexLayout == 1) ? " $\\Rightarrow$ " : " => ")
#define OW_integer ((latexLayout == 1) ? " {\\bf integer}" : " integer")
#define OW_real ((latexLayout == 1) ? " {\\bf real}" : " real")
#define OW_boolean ((latexLayout == 1) ? " {\\bf boolean}" : " boolean")
#define OW_invar  ((latexLayout == 1) ? " {\\bf invar}"  : " invar")
#define OW_outvar ((latexLayout == 1) ? " {\\bf outvar}" : " outvar")
#define OW_locvar ((latexLayout == 1) ? " {\\bf locvar}" : " locvar")
#define OW_usevar ((latexLayout == 1) ? " {\\bf usevar}" : " usevar")
#define OW_use ((latexLayout == 1) ? "{\\bf use}" : "use")
#define OW_var ((latexLayout == 1) ? "{\\bf var}" : "var")

#define OW_if   ((latexLayout == 1) ? "{\\bf if} " : "if ")
#define OW_then ((latexLayout == 1) ? " {\\bf then} " : " then ")
#define OW_else ((latexLayout == 1) ? " {\\bf else} " : " else ")
#define OW_reduce ((latexLayout == 1) ? "{\\bf reduce}" : "reduce")
#define OW_and ((latexLayout == 1) ? " {\\bf and} " : " and ")
#define OW_or ((latexLayout == 1) ? " {\\bf or} " : " or ")
#define OW_xor ((latexLayout == 1) ? " {\\bf xor} " : " xor ")
#define OW_min ((latexLayout == 1) ? "{\\bf min(}" : "min(")
#define OW_max ((latexLayout == 1) ? "{\\bf max(}" : "max(")
#define OW_not ((latexLayout == 1) ? "{\\bf not}" : "not")
#define OW_mod ((latexLayout == 1) ? " {\\bf mod} " : " mod ")
#define OW_div ((latexLayout == 1) ? " {\\bf div} " : " div" )

#define OW_min_p ((latexLayout == 1) ? "{\\bf min}" : "min")
#define OW_max_p ((latexLayout == 1) ? "{\\bf max}" : "max")
#define OW_and_p ((latexLayout == 1) ? "{\\bf and}" : "and")
#define OW_or_p  ((latexLayout == 1) ? "{\\bf or}" : "or")
#define OW_xor_p ((latexLayout == 1) ? "{\\bf xor}" : "xor")

#define OW_sqrt ((latexLayout == 1) ? "{\\bf sqrt}(" : "sqrt(")
#define OW_abs  ((latexLayout == 1) ? "{\\bf abs}("  : "abs(")

#define OW_le ((latexLayout == 1) ? "$\\le$" : "<=")
#define OW_lt ((latexLayout == 1) ? "$<$" : "<")
#define OW_ge ((latexLayout == 1) ? "$\\ge$" : ">=")
#define OW_gt ((latexLayout == 1) ? "$>$" : ">")
#define OW_ne ((latexLayout == 1) ? "$<>$" : "<>")

#define OW_sepSystems     ((latexLayout == 1) ? "\\mbox{ }\\\\" : "\n\n")
#define OW_sepHeadAndBody ((latexLayout == 1) ? "\\\\" : "")
#define OW_sepDecls       ((latexLayout == 1) ? "; \\\\" : "; ")
#define OW_sepDeclAndEqns ((latexLayout == 1) ? "\\\\" : "")

/* functions */
#define itemizeExpressionList(l) ((latexLayout == 1) ? Tex_itemizeList(l,1) : Vlis(0, ";", l))
#define itemizeEquationList(l) ((latexLayout == 1) ? Tex_itemizeList(l,0) : Vlis(0, "", l))

/*--------------------------------------------------------------- package ---*/
item*
package(system)
     item* system;
{
  item* result;
 
  if(latexLayout == 1) {
    result = Venc(2, Text("{"), Text("}"),
                  Vsep3(0, "", Text("\\setlength{\\tabcolsep}{0 cm}"),
                        Text("\\noindent"),
                        system)
                  );
  }
  else {
    result = system;
  }

  return result;
}

/*---------- operator precedence */
#define LeafPrec 100

#define IfPrec 1

/*---- boolean operators */
#define OrPrec (IfPrec + 1)
#define XorPrec OrPrec
#define AndPrec (XorPrec + 1)
#define NotPrec (AndPrec + 1)

/*----- test operators */
#define TestPrec (AndPrec + 2)
#define EqPrec TestPrec
#define LePrec TestPrec
#define LtPrec TestPrec
#define GtPrec TestPrec
#define GePrec TestPrec
#define NePrec TestPrec

/*----- arithmetic operators */
#define AddPrec (TestPrec + 2)
#define SubPrec AddPrec
#define MulPrec (SubPrec + 1)
#define DivPrec MulPrec
#define ModPrec DivPrec
#define NegPrec (ModPrec + 1)

/*----- functions */
#define FctPrec (NegPrec + 1)
#define MinPrec FctPrec
#define MaxPrec FctPrec
#define SqrtPrec FctPrec
#define AbsPrec FctPrec

#define CallPrec FctPrec
#define ReducePrec FctPrec

#define ConstPrec LeafPrec

#define CasePrec FctPrec /* IfPrec for Write_C */
#define RestrictPrec IfPrec

#define VarPrec LeafPrec
#define AffinePrec FctPrec



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
#line 319 "yacc.y"
{ node *n; datatype t; item *i; int b; }
/* Line 193 of yacc.c.  */
#line 455 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 468 "y.tab.c"

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
#define YYFINAL  60
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   579

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  66
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  57
/* YYNRULES -- Number of rules.  */
#define YYNRULES  153
/* YYNRULES -- Number of states.  */
#define YYNSTATES  537

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   315

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    61,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    64,     2,    65,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    62,     2,    63,     2,     2,     2,     2,
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
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     7,    11,    12,    14,    16,    20,
      21,    25,    27,    29,    36,    47,    49,    51,    53,    55,
      57,    59,    63,    70,    78,    82,    85,    87,    93,    96,
     100,   103,   107,   114,   119,   122,   128,   132,   139,   148,
     159,   161,   165,   169,   173,   180,   187,   194,   196,   198,
     200,   202,   204,   206,   208,   210,   214,   215,   223,   235,
     236,   244,   245,   253,   255,   256,   257,   258,   259,   281,
     283,   287,   288,   298,   299,   300,   315,   316,   328,   329,
     341,   342,   354,   356,   360,   361,   368,   375,   380,   381,
     390,   391,   403,   408,   426,   435,   444,   453,   462,   471,
     480,   489,   498,   507,   516,   525,   534,   543,   552,   561,
     570,   579,   588,   595,   602,   609,   616,   625,   626,   638,
     640,   642,   644,   646,   648,   650,   652,   653,   654,   656,
     658,   660,   667,   673,   678,   682,   686,   688,   692,   694,
     698,   699,   700,   711,   713,   717,   736,   751,   765,   767,
     771,   772,   776,   782
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      71,     0,    -1,    60,    -1,    67,    -1,    68,    61,    67,
      -1,    -1,    57,    -1,    69,    -1,    70,    61,    69,    -1,
      -1,    62,    72,    63,    -1,    73,    -1,   102,    -1,    52,
      64,    62,    93,    63,    65,    -1,    52,    64,    62,    81,
      63,    61,    62,    93,    63,    65,    -1,   110,    -1,   120,
      -1,    85,    -1,    75,    -1,    80,    -1,    73,    -1,    72,
      61,    73,    -1,     3,    64,    74,    61,    77,    65,    -1,
      67,    61,    76,    61,    75,    61,    75,    -1,    62,    81,
      63,    -1,    62,    63,    -1,   110,    -1,    78,    61,   108,
      79,   107,    -1,    78,    61,    -1,    62,    81,    63,    -1,
      62,    63,    -1,    62,    84,    63,    -1,    53,    64,    62,
      84,    63,    65,    -1,    53,    64,    84,    65,    -1,    62,
      63,    -1,    53,    64,    62,    63,    65,    -1,    53,    64,
      65,    -1,     4,    64,    67,    61,    82,    65,    -1,     4,
      64,    67,    61,    44,    61,   110,    65,    -1,     4,    64,
      67,    61,    67,    61,    83,    61,   110,    65,    -1,    80,
      -1,    81,    61,    80,    -1,    83,    61,     5,    -1,    83,
      61,   110,    -1,     6,    64,    67,    61,    57,    65,    -1,
       7,    64,    67,    61,    57,    65,    -1,     8,    64,    67,
      61,    57,    65,    -1,     6,    -1,     7,    -1,     8,    -1,
      45,    -1,    46,    -1,    47,    -1,    48,    -1,    85,    -1,
      84,    61,    85,    -1,    -1,     9,    64,    67,    86,    61,
     102,    65,    -1,     9,    64,    13,    64,    67,    61,   120,
      65,    61,   102,    65,    -1,    -1,    11,    64,   110,    87,
      61,    85,    65,    -1,    -1,    54,    64,   110,    88,    61,
      85,    65,    -1,    79,    -1,    -1,    -1,    -1,    -1,    56,
      64,    67,    61,   110,    89,    61,    90,   120,    91,    61,
     107,    62,   101,    63,    92,    61,    62,    68,    63,    65,
      -1,    95,    -1,    93,    61,    95,    -1,    -1,    67,    61,
      67,    61,    62,    70,    63,    61,   120,    -1,    -1,    -1,
      50,    64,   110,    61,    67,    61,    67,    61,    96,   120,
      97,    61,   110,    65,    -1,    -1,    51,    64,    28,    61,
     110,    61,    98,    94,    61,    94,    65,    -1,    -1,    51,
      64,    29,    61,   110,    61,    99,    94,    61,    94,    65,
      -1,    -1,    51,    64,    25,    61,   110,    61,   100,    94,
      61,    94,    65,    -1,   102,    -1,   101,    61,   102,    -1,
      -1,    11,    64,   110,    61,   102,    65,    -1,    10,    64,
      62,   101,    63,    65,    -1,    12,    64,    67,    65,    -1,
      -1,    13,    64,   107,   102,   103,    61,   120,    65,    -1,
      -1,    13,    64,   107,    14,    64,   109,    65,   104,    61,
     120,    65,    -1,    14,    64,   109,    65,    -1,    15,    64,
      43,    64,    57,    61,    57,    61,    62,   113,    63,    61,
      62,   122,    63,    65,    65,    -1,    55,    64,    67,    61,
      62,   101,    63,    65,    -1,    16,    64,    19,    61,   102,
      61,   102,    65,    -1,    16,    64,    21,    61,   102,    61,
     102,    65,    -1,    16,    64,    32,    61,   102,    61,   102,
      65,    -1,    16,    64,    36,    61,   102,    61,   102,    65,
      -1,    16,    64,    37,    61,   102,    61,   102,    65,    -1,
      16,    64,    35,    61,   102,    61,   102,    65,    -1,    16,
      64,    31,    61,   102,    61,   102,    65,    -1,    16,    64,
      20,    61,   102,    61,   102,    65,    -1,    16,    64,    22,
      61,   102,    61,   102,    65,    -1,    16,    64,    23,    61,
     102,    61,   102,    65,    -1,    16,    64,    24,    61,   102,
      61,   102,    65,    -1,    16,    64,    25,    61,   102,    61,
     102,    65,    -1,    16,    64,    26,    61,   102,    61,   102,
      65,    -1,    16,    64,    27,    61,   102,    61,   102,    65,
      -1,    16,    64,    28,    61,   102,    61,   102,    65,    -1,
      16,    64,    29,    61,   102,    61,   102,    65,    -1,    16,
      64,    30,    61,   102,    61,   102,    65,    -1,    17,    64,
      33,    61,   102,    65,    -1,    17,    64,    34,    61,   102,
      65,    -1,    17,    64,    38,    61,   102,    65,    -1,    17,
      64,    39,    61,   102,    65,    -1,    18,    64,   102,    61,
     102,    61,   102,    65,    -1,    -1,    49,    64,   106,    61,
     107,   120,    61,   108,   105,   102,    65,    -1,    19,    -1,
      21,    -1,    32,    -1,    31,    -1,    35,    -1,    36,    -1,
      37,    -1,    -1,    -1,    57,    -1,    59,    -1,    58,    -1,
      40,    64,   111,    61,   112,    65,    -1,    57,    61,    62,
     113,    63,    -1,    57,    61,    62,    63,    -1,    62,   118,
      63,    -1,    62,   114,    63,    -1,    60,    -1,   113,    61,
      60,    -1,   115,    -1,   114,    61,   115,    -1,    -1,    -1,
      42,    64,   116,   120,   117,    61,    62,   118,    63,    65,
      -1,   119,    -1,   118,    61,   119,    -1,    41,    64,    57,
      61,    57,    61,    57,    61,    57,    61,    62,   122,    63,
      61,    62,   122,    63,    65,    -1,    43,    64,    57,    61,
      57,    61,    62,   113,    63,    61,    62,   122,    63,    65,
      -1,    43,    64,    57,    61,    57,    61,    62,    63,    61,
      62,   122,    63,    65,    -1,    57,    -1,   121,    61,    57,
      -1,    -1,    62,   121,    63,    -1,   122,    61,    62,   121,
      63,    -1,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   335,   335,   342,   345,   351,   353,   360,   363,   367,
     372,   374,   376,   378,   380,   390,   392,   394,   396,   398,
     401,   407,   419,   425,   480,   485,   488,   493,   498,   501,
     515,   518,   520,   522,   524,   527,   530,   535,   543,   550,
     559,   562,   569,   572,   575,   584,   592,   602,   604,   606,
     608,   610,   612,   614,   621,   624,   630,   629,   659,   671,
     670,   682,   680,   691,   695,   698,   698,   699,   694,   718,
     721,   727,   729,   739,   740,   739,   750,   750,   757,   757,
     764,   764,   772,   775,   781,   783,   788,   794,   798,   798,
     809,   808,   827,   832,   841,   850,   855,   860,   865,   872,
     879,   884,   889,   894,   899,   904,   909,   914,   919,   924,
     929,   934,   939,   943,   947,   951,   955,   981,   976,   995,
     998,  1001,  1004,  1007,  1010,  1013,  1017,  1020,  1023,  1035,
    1044,  1057,  1062,  1069,  1076,  1080,  1089,  1092,  1095,  1098,
    1102,  1110,  1101,  1121,  1124,  1131,  1154,  1184,  1212,  1215,
    1219,  1221,  1225,  1230
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "KW_system", "KW_decl", "KW_scalar",
  "KW_integer", "KW_boolean", "KW_real", "KW_equation", "KW_case",
  "KW_restrict", "KW_var", "KW_affine", "KW_const", "KW_index", "KW_binop",
  "KW_unop", "KW_if", "KW_add", "KW_sub", "KW_mul", "KW_div", "KW_idiv",
  "KW_mod", "KW_eq", "KW_le", "KW_lt", "KW_gt", "KW_ge", "KW_ne", "KW_or",
  "KW_and", "KW_neg", "KW_not", "KW_xor", "KW_min", "KW_max", "KW_sqrt",
  "KW_abs", "KW_domain", "KW_pol", "KW_zpol", "KW_matrix", "KW_notype",
  "KW_invar", "KW_outvar", "KW_locvar", "KW_usevar", "KW_reduce",
  "KW_depend", "KW_dependence", "KW_dtable", "KW_let", "KW_loop",
  "KW_call", "KW_use", "NUMBER", "REAL", "BOOLEAN", "ID", "','", "'{'",
  "'}'", "'['", "']'", "$accept", "ID_item", "ID_item_List", "Number_item",
  "Number_item_List", "Top", "System_List", "System", "System_Head",
  "IO_Decl", "Parameter", "System_Body", "Local_Decl", "Let_Equations",
  "Decl", "Decl_List", "Type", "Data_Type", "Equation_List", "Equation",
  "@1", "@2", "@3", "@4", "@5", "@6", "@7", "Dep_List", "DepVar", "Dep",
  "@8", "@9", "@10", "@11", "@12", "Exp_List", "Exp", "@13", "@14", "@15",
  "Casop", "Disable_array_notation", "Enable_array_notation", "Const",
  "Domain", "Dom_ID_List", "Dom_Union", "ID_List", "ZPol_List", "ZPol",
  "@16", "@17", "Pol_List", "Pol", "Matrix", "Number_List",
  "Number_List_List", 0
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
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,    44,   123,   125,    91,    93
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    66,    67,    68,    68,    68,    69,    70,    70,    70,
      71,    71,    71,    71,    71,    71,    71,    71,    71,    71,
      72,    72,    73,    74,    75,    75,    76,    77,    77,    78,
      78,    79,    79,    79,    79,    79,    79,    80,    80,    80,
      81,    81,    82,    82,    83,    83,    83,    83,    83,    83,
      83,    83,    83,    83,    84,    84,    86,    85,    85,    87,
      85,    88,    85,    85,    89,    90,    91,    92,    85,    93,
      93,    93,    94,    96,    97,    95,    98,    95,    99,    95,
     100,    95,   101,   101,   101,   102,   102,   102,   103,   102,
     104,   102,   102,   102,   102,   102,   102,   102,   102,   102,
     102,   102,   102,   102,   102,   102,   102,   102,   102,   102,
     102,   102,   102,   102,   102,   102,   102,   105,   102,   106,
     106,   106,   106,   106,   106,   106,   107,   108,   109,   109,
     109,   110,   111,   111,   112,   112,   113,   113,   114,   114,
     116,   117,   115,   118,   118,   119,   120,   120,   121,   121,
     121,   122,   122,   122
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     3,     0,     1,     1,     3,     0,
       3,     1,     1,     6,    10,     1,     1,     1,     1,     1,
       1,     3,     6,     7,     3,     2,     1,     5,     2,     3,
       2,     3,     6,     4,     2,     5,     3,     6,     8,    10,
       1,     3,     3,     3,     6,     6,     6,     1,     1,     1,
       1,     1,     1,     1,     1,     3,     0,     7,    11,     0,
       7,     0,     7,     1,     0,     0,     0,     0,    21,     1,
       3,     0,     9,     0,     0,    14,     0,    11,     0,    11,
       0,    11,     1,     3,     0,     6,     6,     4,     0,     8,
       0,    11,     4,    17,     8,     8,     8,     8,     8,     8,
       8,     8,     8,     8,     8,     8,     8,     8,     8,     8,
       8,     8,     6,     6,     6,     6,     8,     0,    11,     1,
       1,     1,     1,     1,     1,     1,     0,     0,     1,     1,
       1,     6,     5,     4,     3,     3,     1,     3,     1,     3,
       0,     0,    10,     1,     3,    18,    14,    13,     1,     3,
       0,     3,     5,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    11,    18,    63,    19,    17,    12,    15,
      16,     0,     0,     0,     0,     0,     0,   126,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    25,     0,    20,    40,     0,     0,    54,
       1,     2,     0,     0,     0,     0,    56,    84,     0,     0,
       0,   128,   130,   129,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   119,   120,   122,   121,   123,   124,   125,     0,
      71,     0,    36,     0,    61,     0,     0,     0,    34,     0,
      10,     0,    24,     0,    31,     0,     0,     0,     0,     0,
       0,    82,     0,     0,    87,     0,    88,    92,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   126,     0,     0,     0,     0,
      69,    34,     0,    33,     0,     0,     0,    59,    21,    41,
      55,     0,    26,     0,     0,     0,    47,    48,    49,     0,
      50,    51,    52,    53,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    35,
      31,     0,    84,    64,     0,    30,     0,    22,   127,     0,
       0,     0,     0,     0,    37,     0,     0,     0,    83,    86,
      85,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   112,   113,   114,   115,     0,   136,   133,     0,
       0,     0,     0,   138,     0,   143,   131,     0,     0,     0,
       0,     0,     0,     0,    70,    13,    32,     0,     0,     0,
       0,     0,    29,     0,     0,     0,     0,     0,     0,    42,
      43,     0,    57,    60,    90,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,   132,     0,   140,     0,
     135,     0,   134,     0,   127,     0,     0,     0,     0,    71,
      62,     0,    65,    25,     0,   126,     0,     0,     0,    38,
       0,     0,     0,    89,     0,    95,   102,    96,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   101,    97,   100,
      98,    99,   116,   137,     0,     0,   139,   144,     0,     0,
     117,     0,     0,     0,     0,     0,    94,     0,    23,    27,
       0,     0,     0,     0,     0,     0,     0,     0,   141,     0,
       0,     0,     0,    80,    76,    78,     0,    66,    44,    45,
      46,    39,     0,     0,     0,     0,     0,   153,     0,     0,
       0,     0,     0,     0,    14,     0,    58,    91,     0,     0,
       0,   150,     0,   153,   118,    73,     0,     0,     0,     0,
     126,     0,     0,     0,   148,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   153,     0,     0,     0,   151,
     150,   147,     0,    74,     0,     0,     0,     0,    84,     0,
       0,     0,   149,     0,   146,     0,     0,    81,    77,    79,
       0,     0,     0,   142,   152,     0,     9,    67,     0,   153,
       0,     6,     7,     0,     0,    93,     0,    75,     0,     0,
       0,     0,     8,     0,     5,     0,    72,     3,     0,   153,
       0,     0,     0,     4,    68,     0,   145
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,   456,   528,   512,   513,    22,    54,    23,    63,    24,
     181,   184,   185,    25,    56,    57,   195,   196,    58,    59,
     129,   133,   174,   309,   407,   445,   514,   169,   457,   170,
     469,   495,   442,   443,   441,   130,   131,   204,   372,   421,
     109,    70,   313,    74,    29,   100,   231,   289,   292,   293,
     395,   436,   294,   295,    30,   465,   452
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -441
static const yytype_int16 yypact[] =
{
     184,   -44,   -28,   -14,   -10,    35,    48,    49,    67,    71,
      72,   122,   125,   141,   147,   152,   153,   157,   162,   170,
     171,    20,    85,  -441,  -441,  -441,  -441,  -441,  -441,  -441,
    -441,    59,    59,    17,     9,   105,    59,  -441,     1,   138,
     291,    18,   245,    91,   191,    90,    16,    38,   105,    59,
      59,   185,    61,  -441,   -17,  -441,  -441,     0,    25,  -441,
    -441,  -441,   193,   213,   235,   237,  -441,   245,   247,   260,
     254,  -441,  -441,  -441,   286,   242,   280,   288,   292,   293,
     294,   295,   296,   297,   298,   299,   300,   301,   302,   303,
     304,   305,   306,   307,   308,   309,   310,   311,   312,   313,
     315,   316,  -441,  -441,  -441,  -441,  -441,  -441,  -441,   317,
      51,    84,  -441,   -39,  -441,   318,   319,   105,  -441,   349,
    -441,   368,  -441,   123,  -441,   105,   320,    60,    59,   322,
      55,  -441,   245,   323,  -441,   321,  -441,  -441,   324,   245,
     245,   245,   245,   245,   245,   245,   245,   245,   245,   245,
     245,   245,   245,   245,   245,   245,   245,   245,   245,   245,
     105,   245,   325,   326,   329,  -441,   328,   330,    78,    81,
    -441,   331,   117,  -441,   332,   327,   105,  -441,  -441,  -441,
    -441,   334,  -441,    12,   333,   336,   335,   337,   338,   339,
    -441,  -441,  -441,  -441,   342,   340,   343,   345,   245,   245,
     344,   346,   123,     1,   347,   351,   352,   353,   354,   355,
     356,   357,   358,   359,   360,   361,   362,   363,   365,   366,
     367,   369,   370,   364,   371,   372,   373,   247,   374,   -20,
      -8,   375,   380,   390,   105,    13,   381,    14,   378,  -441,
     379,   123,   245,  -441,   348,  -441,   121,  -441,   382,    59,
      59,    59,   105,   167,  -441,    22,   390,   383,  -441,  -441,
    -441,   384,   385,   390,   350,   245,   245,   245,   245,   245,
     245,   245,   245,   245,   245,   245,   245,   245,   245,   245,
     245,   245,  -441,  -441,  -441,  -441,   245,  -441,  -441,   129,
     387,   388,   143,  -441,   168,  -441,  -441,   391,   393,   394,
     395,   396,   397,   398,  -441,  -441,  -441,   399,   169,   400,
      21,   401,  -441,   -25,   402,   404,   405,   403,   406,  -441,
    -441,   407,  -441,  -441,  -441,   408,   409,   410,   411,   412,
     414,   415,   416,   417,   418,   419,   420,   421,   422,   423,
     424,   425,   426,   427,   429,   386,  -441,   377,  -441,   432,
    -441,   428,  -441,   -15,  -441,    59,   105,   105,   105,    14,
    -441,   430,  -441,  -441,   348,  -441,   439,   440,   441,  -441,
     105,   442,   443,  -441,   438,  -441,  -441,  -441,  -441,  -441,
    -441,  -441,  -441,  -441,  -441,  -441,  -441,  -441,  -441,  -441,
    -441,  -441,  -441,  -441,   444,   390,  -441,  -441,   445,   180,
    -441,   446,   447,   448,   449,   181,  -441,   390,  -441,  -441,
     436,   437,   450,   451,   245,   390,   452,   454,  -441,   455,
     453,   245,    59,  -441,  -441,  -441,   456,  -441,  -441,  -441,
    -441,  -441,   457,   458,   212,   459,   463,   464,   465,   460,
     467,    59,    59,    59,  -441,   468,  -441,  -441,   469,   461,
     470,   462,   232,   464,  -441,  -441,   472,   473,   474,   475,
    -441,   476,   478,   428,  -441,   241,   479,   466,   244,   390,
      59,    59,    59,    59,   480,   464,   483,   271,   486,  -441,
     462,  -441,   481,  -441,   484,   482,   485,   487,   245,   272,
     488,   489,  -441,   275,  -441,   490,   491,  -441,  -441,  -441,
     276,   492,   493,  -441,  -441,   105,   499,  -441,   494,   464,
     495,  -441,  -441,   279,   497,  -441,   283,  -441,   499,   500,
     501,   503,  -441,   390,    59,   504,  -441,  -441,   284,   464,
      59,   502,   287,  -441,  -441,   505,  -441
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -441,   -31,  -441,  -128,  -441,  -441,  -441,    -9,  -441,  -234,
    -441,  -441,  -441,   132,     7,   -96,  -441,   206,   -32,     6,
    -441,  -441,  -441,  -441,  -441,  -441,  -441,   112,  -220,   341,
    -441,  -441,  -441,  -441,  -441,  -238,    11,  -441,  -441,  -441,
    -441,  -162,   159,   376,   -27,  -441,  -441,  -336,  -441,   188,
    -441,  -441,    99,   197,  -224,    64,  -440
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -29
static const yytype_int16 yytable[] =
{
      62,    64,    66,   233,   308,    69,    27,    26,    68,   298,
     311,    28,    55,   468,   168,   113,     2,   399,   115,   116,
      31,   114,   123,     1,     2,     2,   173,   319,    17,     3,
      65,    51,   321,   290,   291,   489,    32,    52,   300,   325,
     287,   301,   302,   288,   119,   287,   120,     3,   398,    51,
      33,    93,    94,    98,    34,     2,    95,    96,    71,    72,
      73,   121,    13,   122,   166,   167,   186,   187,   188,   516,
       3,    67,    51,    17,    18,   245,    20,    61,   110,   172,
     434,   136,    52,    53,   363,    60,   123,   246,   124,   532,
     177,    17,    18,     3,    20,    51,   194,   197,   182,    35,
     111,   166,   167,   112,   189,   190,   191,   192,   193,   102,
     178,   103,    36,    37,    17,    18,   199,    20,   200,    61,
      61,   104,   105,    52,   118,   106,   107,   108,   179,   180,
     408,    38,     3,   227,    51,    39,    40,    17,    18,   121,
      20,   236,   237,   201,   238,    13,    52,   171,    99,   243,
     206,   207,   208,   209,   210,   211,   212,   213,   214,   215,
     216,   217,   218,   219,   220,   221,   222,   223,   224,   225,
     226,   418,   228,   186,   187,   188,    17,    18,   123,    20,
     240,    75,   121,   427,   312,    52,    41,     1,     2,    42,
     345,   433,   346,     3,     4,     5,     6,     7,     8,     9,
      10,    11,    12,   409,   349,    43,   350,   299,   261,   257,
     258,    44,   190,   191,   192,   193,    45,    46,   314,   315,
     316,    47,   458,   459,    13,   317,    48,    14,   320,   351,
     199,   352,   361,    15,    49,    50,    16,    17,    18,    19,
      20,   345,   237,   420,   426,   483,    21,   307,   101,   117,
     500,   485,   486,   487,   125,     4,    97,     6,     7,     8,
       9,    10,    11,    12,     4,    97,     6,     7,   135,     9,
      10,    11,    12,   345,   126,   448,   327,   328,   329,   330,
     331,   332,   333,   334,   335,   336,   337,   338,   339,   340,
     341,   342,   343,   466,    15,   467,   127,   344,   474,   526,
      19,   128,   478,    15,   479,   466,   138,   482,   132,    19,
      76,    77,    78,    79,    80,    81,    82,    83,    84,    85,
      86,    87,    88,    89,   401,   134,    90,    91,    92,   402,
     403,   404,   351,   466,   491,   501,   478,   199,   504,   507,
     518,   139,   519,   413,   466,   530,   521,   531,   466,   140,
     535,   137,     1,   141,   142,   143,   144,   145,   146,   147,
     148,   149,   150,   151,   152,   153,   154,   155,   156,   157,
     158,   159,     2,   161,   162,   160,   163,   164,   165,   175,
     176,   205,   183,   198,   202,   203,   232,   229,   230,   242,
     522,   440,   234,   241,   235,   244,   239,   248,   247,   249,
     252,   250,   251,   253,   255,   254,   256,   326,   263,   259,
     310,   260,   264,   265,   266,   267,   268,   269,   270,   271,
     272,   273,   274,   275,   276,   432,   277,   278,   279,   282,
     280,   281,   439,    14,   394,   286,   283,   284,   285,   484,
     296,   297,   303,   305,   306,   365,   393,   -28,   322,   323,
     324,   347,   348,   353,   354,   355,   356,   357,   358,   318,
     359,   362,   364,   366,   360,   367,   368,   370,   369,   290,
     374,   405,   371,   373,   291,   375,   376,   377,   510,   378,
     379,   380,   381,   382,   383,   384,   385,   386,   387,   388,
     389,   390,   391,   527,   392,   406,   410,   411,   412,   533,
     416,   428,   429,   414,   415,   417,   419,   422,   423,   424,
     425,   435,   287,   400,   438,   430,   431,   437,   462,   464,
     449,   444,   446,   447,   450,   454,   451,   453,   455,   460,
     461,   481,   463,   470,   471,   472,   473,   396,   475,   476,
     490,   480,   488,   492,   493,   496,   494,   497,   397,   502,
     498,   505,   499,   506,   503,   509,   511,   508,   520,   515,
     517,   523,   477,   524,   525,     0,   529,   534,     0,     0,
     536,     0,     0,     0,     0,     0,     0,     0,   304,   262
};

static const yytype_int16 yycheck[] =
{
      31,    32,    33,   165,   242,    36,     0,     0,    35,   233,
     244,     0,    21,   453,   110,    47,     4,   353,    49,    50,
      64,    48,    61,     3,     4,     4,    65,     5,    53,     9,
      13,    11,   256,    41,    42,   475,    64,    62,    25,   263,
      60,    28,    29,    63,    61,    60,    63,     9,    63,    11,
      64,    33,    34,    42,    64,     4,    38,    39,    57,    58,
      59,    61,    40,    63,    50,    51,     6,     7,     8,   509,
       9,    62,    11,    53,    54,    63,    56,    60,    62,   111,
     416,    70,    62,    63,    63,     0,    61,   183,    63,   529,
     117,    53,    54,     9,    56,    11,   127,   128,   125,    64,
      62,    50,    51,    65,    44,    45,    46,    47,    48,    19,
     119,    21,    64,    64,    53,    54,    61,    56,    63,    60,
      60,    31,    32,    62,    63,    35,    36,    37,   121,   123,
     364,    64,     9,   160,    11,    64,    64,    53,    54,    61,
      56,    63,    61,   132,    63,    40,    62,    63,    57,   176,
     139,   140,   141,   142,   143,   144,   145,   146,   147,   148,
     149,   150,   151,   152,   153,   154,   155,   156,   157,   158,
     159,   395,   161,     6,     7,     8,    53,    54,    61,    56,
      63,    43,    61,   407,    63,    62,    64,     3,     4,    64,
      61,   415,    63,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    18,   365,    61,    64,    63,   234,   202,   198,
     199,    64,    45,    46,    47,    48,    64,    64,   249,   250,
     251,    64,   442,   443,    40,   252,    64,    43,   255,    61,
      61,    63,    63,    49,    64,    64,    52,    53,    54,    55,
      56,    61,    61,    63,    63,   469,    62,   241,    57,    64,
     488,   471,   472,   473,    61,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    61,    61,    63,   265,   266,   267,   268,
     269,   270,   271,   272,   273,   274,   275,   276,   277,   278,
     279,   280,   281,    61,    49,    63,    61,   286,   460,   523,
      55,    64,    61,    49,    63,    61,    64,    63,    61,    55,
      19,    20,    21,    22,    23,    24,    25,    26,    27,    28,
      29,    30,    31,    32,   355,    65,    35,    36,    37,   356,
     357,   358,    61,    61,    63,    63,    61,    61,    63,    63,
      61,    61,    63,   370,    61,    61,    63,    63,    61,    61,
      63,    65,     3,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,     4,    61,    61,    64,    61,    61,    61,    61,
      61,    57,    62,    61,    61,    64,    57,    62,    62,    62,
     518,   422,    64,    61,    64,    61,    65,    61,    65,    64,
      61,    64,    64,    61,    61,    65,    61,    57,    61,    65,
      62,    65,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,   414,    61,    61,    61,    65,
      61,    61,   421,    43,    57,    61,    65,    65,    65,   470,
      65,    61,    61,    65,    65,   313,    60,    65,    65,    65,
      65,    64,    64,    62,    61,    61,    61,    61,    61,   253,
      62,    61,    61,    61,    65,    61,    61,    61,    65,    41,
      61,   359,    65,    65,    42,    65,    65,    65,   505,    65,
      65,    65,    65,    65,    65,    65,    65,    65,    65,    65,
      65,    65,    65,   524,    65,    65,    57,    57,    57,   530,
      62,    65,    65,    61,    61,    61,    61,    61,    61,    61,
      61,    57,    60,   354,    61,    65,    65,    62,    57,    57,
      61,    65,    65,    65,    61,    65,    62,    62,    61,    61,
      61,    65,    62,    61,    61,    61,    61,   349,    62,    61,
      57,    62,    62,    57,   480,    61,    65,    65,   351,    61,
      65,    61,    65,    62,    65,    62,    57,    65,    61,    65,
      65,    61,   463,    62,    61,    -1,    62,    65,    -1,    -1,
      65,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   237,   203
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    40,    43,    49,    52,    53,    54,    55,
      56,    62,    71,    73,    75,    79,    80,    85,   102,   110,
     120,    64,    64,    64,    64,    64,    64,    64,    64,    64,
      64,    64,    64,    64,    64,    64,    64,    64,    64,    64,
      64,    11,    62,    63,    72,    73,    80,    81,    84,    85,
       0,    60,    67,    74,    67,    13,    67,    62,   110,    67,
     107,    57,    58,    59,   109,    43,    19,    20,    21,    22,
      23,    24,    25,    26,    27,    28,    29,    30,    31,    32,
      35,    36,    37,    33,    34,    38,    39,    11,   102,    57,
     111,    57,    19,    21,    31,    32,    35,    36,    37,   106,
      62,    62,    65,    84,   110,    67,    67,    64,    63,    61,
      63,    61,    63,    61,    63,    61,    61,    61,    64,    86,
     101,   102,    61,    87,    65,    14,   102,    65,    64,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      64,    61,    61,    61,    61,    61,    50,    51,    81,    93,
      95,    63,    84,    65,    88,    61,    61,   110,    73,    80,
      85,    76,   110,    62,    77,    78,     6,     7,     8,    44,
      45,    46,    47,    48,    67,    82,    83,    67,    61,    61,
      63,   102,    61,    64,   103,    57,   102,   102,   102,   102,
     102,   102,   102,   102,   102,   102,   102,   102,   102,   102,
     102,   102,   102,   102,   102,   102,   102,   110,   102,    62,
      62,   112,    57,   107,    64,    64,    63,    61,    63,    65,
      63,    61,    62,   110,    61,    63,    81,    65,    61,    64,
      64,    64,    61,    61,    65,    61,    61,   102,   102,    65,
      65,    85,   109,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    65,    65,    65,    65,    61,    60,    63,   113,
      41,    42,   114,   115,   118,   119,    65,    61,   120,   110,
      25,    28,    29,    61,    95,    65,    65,    85,   101,    89,
      62,    75,    63,   108,    67,    67,    67,   110,    83,     5,
     110,   120,    65,    65,    65,   120,    57,   102,   102,   102,
     102,   102,   102,   102,   102,   102,   102,   102,   102,   102,
     102,   102,   102,   102,   102,    61,    63,    64,    64,    61,
      63,    61,    63,    62,    61,    61,    61,    61,    61,    62,
      65,    63,    61,    63,    61,    79,    61,    61,    61,    65,
      61,    65,   104,    65,    61,    65,    65,    65,    65,    65,
      65,    65,    65,    65,    65,    65,    65,    65,    65,    65,
      65,    65,    65,    60,    57,   116,   115,   119,    63,   113,
     108,    67,   110,   110,   110,    93,    65,    90,    75,   107,
      57,    57,    57,   110,    61,    61,    62,    61,   120,    61,
      63,   105,    61,    61,    61,    61,    63,   120,    65,    65,
      65,    65,   102,   120,   113,    57,   117,    62,    61,   102,
      67,   100,    98,    99,    65,    91,    65,    65,    63,    61,
      61,    62,   122,    62,    65,    61,    67,    94,    94,    94,
      61,    61,    57,    62,    57,   121,    61,    63,   122,    96,
      61,    61,    61,    61,   107,    62,    61,   118,    61,    63,
      62,    65,    63,   120,    67,    94,    94,    94,    62,   122,
      57,    63,    57,   121,    65,    97,    61,    65,    65,    65,
     101,    63,    61,    65,    63,    61,    62,    63,    65,    62,
     110,    57,    69,    70,    92,    65,   122,    65,    61,    63,
      61,    63,    69,    61,    62,    61,   120,    67,    68,    62,
      61,    63,   122,    67,    65,    63,    65
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
#line 336 "yacc.y"
    { (yyval.i) = new_item(text);
          sprint_name((yyval.i)->the.text.string,(yyvsp[(1) - (1)].n));
	  (yyval.i)->prec = 0;
          free_node((yyvsp[(1) - (1)].n));
        }
    break;

  case 3:
#line 343 "yacc.y"
    {  (yyval.i) = Pos((yyvsp[(1) - (1)].i),1); }
    break;

  case 4:
#line 346 "yacc.y"
    {  int p;
           p = length_ilist((yyvsp[(1) - (3)].i)) + 1;
           (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), Pos((yyvsp[(3) - (3)].i), p) ); }
    break;

  case 5:
#line 351 "yacc.y"
    {  (yyval.i) = (item *)0;}
    break;

  case 6:
#line 354 "yacc.y"
    { (yyval.i) = new_item(number);
          (yyval.i)->the.number.value=(yyvsp[(1) - (1)].n)->the.iconst.value;
	  (yyval.i)->prec = 0;
          free_node((yyvsp[(1) - (1)].n));
        }
    break;

  case 7:
#line 361 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 8:
#line 364 "yacc.y"
    {  (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), (yyvsp[(3) - (3)].i) ); }
    break;

  case 9:
#line 367 "yacc.y"
    {  (yyval.i) = (item *)0;}
    break;

  case 10:
#line 373 "yacc.y"
    { alpha = package(Vsep(0, OW_sepSystems, (yyvsp[(2) - (3)].i))); YYACCEPT; }
    break;

  case 11:
#line 375 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 12:
#line 377 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 13:
#line 379 "yacc.y"
    { alpha = package(Vsep(0,"",(yyvsp[(4) - (6)].i))); YYACCEPT; }
    break;

  case 14:
#line 381 "yacc.y"
    { alpha = package(Vsep2(0,"\n",
				Venc(2, Text(OW_var), 0,
				    Vlis(0,";",(yyvsp[(4) - (10)].i))
				),
				Venc(2, Text("Dependences"), 0,
				    Vsep(0,"",(yyvsp[(8) - (10)].i))
				)
			    ) );
	    YYACCEPT; }
    break;

  case 15:
#line 391 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 16:
#line 393 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 17:
#line 395 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 18:
#line 397 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 19:
#line 399 "yacc.y"
    { alpha = package((yyvsp[(1) - (1)].i)); YYACCEPT; }
    break;

  case 20:
#line 402 "yacc.y"
    {  if      (thesystem==0) (yyval.i) = Pos((yyvsp[(1) - (1)].i),1);
	   else if (thesystem==1) (yyval.i) = (yyvsp[(1) - (1)].i);
           else {  thesystem--;  (yyval.i) = (item *) 0; }
        }
    break;

  case 21:
#line 408 "yacc.y"
    {  int p;
           if (thesystem==0)
           {  p = length_ilist((yyvsp[(1) - (3)].i)) + 1;
              (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), Pos((yyvsp[(3) - (3)].i), p) );
           }
           else if (thesystem==1 && (yyvsp[(1) - (3)].i)==(item *)0 ) (yyval.i) = (yyvsp[(3) - (3)].i);
           else if (thesystem==1 && (yyvsp[(1) - (3)].i)!=(item *)0 ) (yyval.i) = (yyvsp[(1) - (3)].i);
           else {  thesystem--; (yyval.i) = (item *) 0; }
        }
    break;

  case 22:
#line 420 "yacc.y"
    { (yyval.i) = Vsep2(0, OW_sepHeadAndBody, (yyvsp[(3) - (6)].i), (yyvsp[(5) - (6)].i));
          G_dim=0;
          Dictionary = (entry *) 0;
        }
    break;

  case 23:
#line 426 "yacc.y"
    { int sys_name_len = strlen((yyvsp[(1) - (7)].i)->the.text.string);
          item* tmpResult;

          if (sys_name_len<7) sys_name_len = 7;

          if(latexLayout == 1)
          { if (G_dim != 0)
            { tmpResult = Vsep2(sys_name_len+1, "\\\\",
                        Hsep4(0,"", Pos((yyvsp[(1) - (7)].i),1), Text("~:&"),
                              Align(0), Henc(0, Text("\\multicolumn{3}{l}{~"),
                                             Text("}"), Pos((yyvsp[(3) - (7)].i),2))),
                        Pos((yyvsp[(5) - (7)].i),3)
                        );
            }
            else
            { tmpResult = Hsep4(sys_name_len+1,"",
                        Pos((yyvsp[(1) - (7)].i),1), Text(" "),
                        Align(0), Pos((yyvsp[(5) - (7)].i),3));
            }
            (yyval.i) = Venc(0, Text("\\begin{tabular}{rrcl}"),
                             Text("\\end{tabular}"),
                             Henc(7, Text(OW_system), Text(";"),
                             Vsep2(0, "",
                                   Hsep2(0, "", tmpResult, Text("\\\\")),
                                   Hsep3(sys_name_len+1,"",
                                   Text(OW_returns),Align(0),Pos((yyvsp[(7) - (7)].i),4))
                                   )
                          ));
          }
          else {
          if (G_dim != 0)
            (yyval.i) = Henc(7, Text("system "), Text(";"),
                   Vsep2(0, "",
                     Vsep2(sys_name_len+1, "",
                       Hsep4(0,"", Pos((yyvsp[(1) - (7)].i),1), Text(" :"), Align(0), Pos((yyvsp[(3) - (7)].i),2)),
		       Pos((yyvsp[(5) - (7)].i),3)
                     ),
                     Hsep3(sys_name_len+1,"",
                       Text("returns"), Align(0), Pos((yyvsp[(7) - (7)].i),4)
                     )
                   )
                 );
          else
            (yyval.i) = Henc(7, Text("system "), Text(";"),
                   Vsep2(0, "",
                     Hsep3(sys_name_len+1,"",
                       Pos((yyvsp[(1) - (7)].i),1), Align(0), Pos((yyvsp[(5) - (7)].i),3)),
                     Hsep3(sys_name_len+1,"",
                       Text("returns"), Align(0), Pos((yyvsp[(7) - (7)].i),4))
                   )
                 );
        }
	}
    break;

  case 24:
#line 481 "yacc.y"
    { (yyval.i) = Henc(1, Text("("), Text(")"),
	              Vsep(0, OW_sepDecls, (yyvsp[(2) - (3)].i))
               );
	}
    break;

  case 25:
#line 486 "yacc.y"
    { (yyval.i) = Henc(1, Text("("), Text(")"), Text(" "));}
    break;

  case 26:
#line 489 "yacc.y"
    { G_dim = D_Save;
	  (yyval.i) = (yyvsp[(1) - (1)].i);
	}
    break;

  case 27:
#line 495 "yacc.y"
    { (yyval.i) = (yyvsp[(1) - (5)].i) ? Vlis2(0, OW_sepDeclAndEqns,
                             Pos((yyvsp[(1) - (5)].i), 5), Pos((yyvsp[(4) - (5)].i), 6)) : Pos((yyvsp[(4) - (5)].i), 6); }
    break;

  case 28:
#line 499 "yacc.y"
    { (yyval.i) = (yyvsp[(1) - (2)].i) ? Pos((yyvsp[(1) - (2)].i), 5) : 0; }
    break;

  case 29:
#line 502 "yacc.y"
    { if (latexLayout == 1)
	  { (yyval.i) = Venc(2, Text("\\begin{tabular}{lrcl}"), Text("\\end{tabular}"),
                      Vsep2(2, "", Hsep2(0, "", Text(OW_var), Text("&\\\\")),
                                   Vlis(0, ";\\\\", (yyvsp[(2) - (3)].i))
                           )
                     );
	  }
          else
          { (yyval.i) = Venc(2, Text(OW_var), 0,
		         Vlis(0, ";", (yyvsp[(2) - (3)].i))
		     );
	  }
	}
    break;

  case 30:
#line 516 "yacc.y"
    { (yyval.i) = (item *)0; }
    break;

  case 31:
#line 519 "yacc.y"
    { (yyval.i) = Venc(2, Text(OW_let), Text(OW_tel), itemizeEquationList((yyvsp[(2) - (3)].i))); }
    break;

  case 32:
#line 521 "yacc.y"
    { (yyval.i) = Venc(2, Text(OW_let), Text(OW_tel), itemizeEquationList((yyvsp[(4) - (6)].i))); }
    break;

  case 33:
#line 523 "yacc.y"
    { (yyval.i) = Venc(2, Text(OW_let), Text(OW_tel), itemizeEquationList((yyvsp[(3) - (4)].i))); }
    break;

  case 34:
#line 525 "yacc.y"
    { (yyval.i) = Venc(2, Text(OW_let), Text(OW_tel),
		itemizeEquationList(Text("--empty"))); }
    break;

  case 35:
#line 528 "yacc.y"
    { (yyval.i) = Venc(2, Text(OW_let), Text(OW_tel),
		itemizeEquationList(Text("--empty"))); }
    break;

  case 36:
#line 531 "yacc.y"
    { (yyval.i) = Venc(2, Text(OW_let), Text(OW_tel),
		itemizeEquationList(Text("--empty"))); }
    break;

  case 37:
#line 536 "yacc.y"
    {  insertIDdecl((yyvsp[(3) - (6)].i), ID_List_Save);
           ID_List_Save = (node *)0;
	   (yyval.i) = (latexLayout == 1) ?
	     Hsep2(0, "", Text("&"), Hsep2(0, "&~:&~", Pos((yyvsp[(3) - (6)].i),1), (yyvsp[(5) - (6)].i)))
	     : Hsep2(0, " : ", Pos((yyvsp[(3) - (6)].i), 1), (yyvsp[(5) - (6)].i));
	}
    break;

  case 38:
#line 544 "yacc.y"
    {  if (annote_flag)
	     (yyval.i) = (latexLayout == 1) ?
             Hsep2(0, "", Text("&"), Hsep2(0, "&~:&~", Pos((yyvsp[(3) - (8)].i),1), Pos((yyvsp[(7) - (8)].i),3)))
             : Hsep2(0, " : ", Pos((yyvsp[(3) - (8)].i), 1), Pos((yyvsp[(7) - (8)].i), 3));
	   else (yyval.i) = (item *)0;
	}
    break;

  case 39:
#line 551 "yacc.y"
    {  /* new decl */
           (yyval.i) = Hsep2(0, " : ",
              Hsep2(0, ".", (yyvsp[(3) - (10)].i), (yyvsp[(5) - (10)].i)),
              Hsep2(0," of ",(yyvsp[(9) - (10)].i), (yyvsp[(7) - (10)].i))
           );
        }
    break;

  case 40:
#line 560 "yacc.y"
    {  (yyval.i) = Pos((yyvsp[(1) - (1)].i),1); }
    break;

  case 41:
#line 563 "yacc.y"
    {  int p;
           p = length_ilist((yyvsp[(1) - (3)].i)) + 1;
           (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), Pos((yyvsp[(3) - (3)].i), p) );
	}
    break;

  case 42:
#line 570 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (3)].i); }
    break;

  case 43:
#line 573 "yacc.y"
    {  (yyval.i) = D_Save==G_dim ? (yyvsp[(1) - (3)].i) : Hsep2(0, OW_of, Pos((yyvsp[(3) - (3)].i),3), Pos((yyvsp[(1) - (3)].i),2)); }
    break;

  case 44:
#line 576 "yacc.y"
    {  (yyval.i) =  Hsep2(0, "",
                       Text(OW_integer),
                       Henc(0, Text("["), Text("]"),
                            Hsep2(0, ",", (yyvsp[(3) - (6)].i),
                                  Number((yyvsp[(5) - (6)].n)->the.iconst.value))
                            )
                       );
         }
    break;

  case 45:
#line 585 "yacc.y"
    {  (yyval.i) =  Hsep2(0, "",
                       Text(OW_boolean),
                       Henc(0, Text("["), Text("]"),
                            Hsep2(0, ",", (yyvsp[(3) - (6)].i),
                                  Number((yyvsp[(5) - (6)].n)->the.iconst.value))
                            )
                       ); }
    break;

  case 46:
#line 593 "yacc.y"
    {  (yyval.i) =(yyval.i) =  Hsep2(0, "",
                       Text(OW_real),
                       Henc(0, Text("["), Text("]"),
                            Hsep2(0, ",", (yyvsp[(3) - (6)].i),
                                  Number((yyvsp[(5) - (6)].n)->the.iconst.value))
                            )
                           ); }
    break;

  case 47:
#line 603 "yacc.y"
    {  (yyval.i) = Text(OW_integer); }
    break;

  case 48:
#line 605 "yacc.y"
    {  (yyval.i) = Text(OW_boolean); }
    break;

  case 49:
#line 607 "yacc.y"
    {  (yyval.i) = Text(OW_real); }
    break;

  case 50:
#line 609 "yacc.y"
    {  (yyval.i) = Text(OW_invar); }
    break;

  case 51:
#line 611 "yacc.y"
    {  (yyval.i) = Text(OW_outvar); }
    break;

  case 52:
#line 613 "yacc.y"
    {  (yyval.i) = Text(OW_locvar); }
    break;

  case 53:
#line 615 "yacc.y"
    {  (yyval.i) = Text(OW_usevar); }
    break;

  case 54:
#line 622 "yacc.y"
    {  (yyval.i) = Pos((yyvsp[(1) - (1)].i),1); }
    break;

  case 55:
#line 625 "yacc.y"
    {  int p;
           p  = length_ilist((yyvsp[(1) - (3)].i))+1;
           (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), Pos((yyvsp[(3) - (3)].i), p) ); }
    break;

  case 56:
#line 630 "yacc.y"
    {   (yyval.n)=ID_context;
	    ID_context = lookupIDdecl((yyvsp[(3) - (3)].i));
	}
    break;

  case 57:
#line 634 "yacc.y"
    {   item *header;
	    if (array_mode && eflag && ID_context)
	    { if (lengthof(ID_context) == 0)
		header = Hsep2(0,"", Pos((yyvsp[(3) - (7)].i),1), Text(" = "));
	      else 
		header = Hsep3(0,"",
			    Pos((yyvsp[(3) - (7)].i),1),
			    Henc(0, Text("["), Text("]"),
			       Hsep(0, ",", id_list2(ID_context,G_dim))
                            ),
			    Text(" = ")
                         ); 
	      (yyval.i) = Henc(4, header, Text(";"), Pos((yyvsp[(6) - (7)].i),2));
	    }
	    else 
	    {  (yyval.i) = Henc(4,
                    Hsep2(0," ", Pos((yyvsp[(3) - (7)].i),1), Text("= ")),
                    Text(";"),
                    Pos((yyvsp[(6) - (7)].i),2)
                );
	    }
	    ID_context=(yyvsp[(4) - (7)].n);
	    ID_List_Save = (node *)0;
	    (yyval.i)->prec = 0;
	}
    break;

  case 58:
#line 660 "yacc.y"
    {   item *header;
	    header = Hsep3(0,"",
			    Pos((yyvsp[(5) - (11)].i),1),
			    (yyvsp[(7) - (11)].i),
			    Text(" = ")
                         ); 
	    (yyval.i) = Henc(4, header, Text(";"), Pos((yyvsp[(10) - (11)].i),2));
	    ID_List_Save = (node *)0;
	    (yyval.i)->prec = 0;
	}
    break;

  case 59:
#line 671 "yacc.y"
    {   (yyval.n)=ID_context;
        ID_context=ID_List_Save;
	}
    break;

  case 60:
#line 675 "yacc.y"
    {   (yyval.i) = Hsep2(2," : ", Pos(check_prec((yyvsp[(3) - (7)].i),2),1), Pos((yyvsp[(6) - (7)].i),2));
	    ID_context=(yyvsp[(4) - (7)].n);
	    ID_List_Save = (node *)0;
	    (yyval.i)->prec = 2;
	}
    break;

  case 61:
#line 682 "yacc.y"
    {   (yyval.n)=ID_context;
	    ID_context=ID_List_Save;
	}
    break;

  case 62:
#line 686 "yacc.y"
    {   (yyval.i) = Hsep2(2," :: ", Pos(check_prec((yyvsp[(3) - (7)].i),2),1), Pos((yyvsp[(6) - (7)].i),2));
	    ID_context=(yyvsp[(4) - (7)].n);
	    ID_List_Save = (node *)0;
	    (yyval.i)->prec = 2;
	}
    break;

  case 63:
#line 692 "yacc.y"
    {   (yyval.i) = (yyvsp[(1) - (1)].i);
	}
    break;

  case 64:
#line 695 "yacc.y"
    {   (yyval.n) = ID_context;
	    ID_context = ID_List_Save;
	}
    break;

  case 65:
#line 698 "yacc.y"
    {use_flag=1;}
    break;

  case 66:
#line 698 "yacc.y"
    {use_flag=0;}
    break;

  case 67:
#line 699 "yacc.y"
    {eflag = (yyvsp[(12) - (15)].b);}
    break;

  case 68:
#line 701 "yacc.y"
    {   (yyval.i) =  Hsep2(4, " ",
		  Hsep4(2, " ",
		    Text(OW_use),
		    ID_context->the.list.count>G_dim ? Pos((yyvsp[(5) - (21)].i), 2) : Text(""),
		    Hsep2(0, (!array_mode ? "." : ""),Pos((yyvsp[(3) - (21)].i), 1), Pos((yyvsp[(9) - (21)].i), 3)),
		    Pos(Henc(2, Text("("), Text(")"), Hsep(0, ", ", (yyvsp[(14) - (21)].i))),4)
		  ),
		  Hsep3(2, " ",
                    Text(OW_returns),
		    Pos(Henc(2, Text("("), Text(")"), Hsep(0, ", ", (yyvsp[(19) - (21)].i))),5),
		    Text(";")
		  )
		);
	    (yyval.i)->prec = 2;
	    ID_context = (yyvsp[(6) - (21)].n);
	}
    break;

  case 69:
#line 719 "yacc.y"
    {  (yyval.i) = Pos((yyvsp[(1) - (1)].i),1); }
    break;

  case 70:
#line 722 "yacc.y"
    {  int p;
           p  = length_ilist((yyvsp[(1) - (3)].i)) + 1;
           (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), Pos((yyvsp[(3) - (3)].i),p)); }
    break;

  case 71:
#line 727 "yacc.y"
    {  (yyval.i) = (item *)0;}
    break;

  case 72:
#line 730 "yacc.y"
    {  (yyval.i) = Hsep3(0,"",
                  (*((yyvsp[(1) - (9)].i)->the.text.string)? Hsep3(0,"",(yyvsp[(1) - (9)].i),Text("."),(yyvsp[(3) - (9)].i)) : (yyvsp[(3) - (9)].i)),
                  Henc(0,Text("{"),Text("}"),
                      Hsep(0,",",(yyvsp[(6) - (9)].i))
                  ),
                  (yyvsp[(9) - (9)].i)
                );
	}
    break;

  case 73:
#line 739 "yacc.y"
    {dpflag=1;}
    break;

  case 74:
#line 740 "yacc.y"
    {dpflag=0;}
    break;

  case 75:
#line 741 "yacc.y"
    { (yyval.i) = Hsep2(0," : ",
                  (yyvsp[(3) - (14)].i),
                  Hsep2(0, OW_rightarrow,
                     Hsep2(0,"",(yyvsp[(5) - (14)].i),DepMatIDS),
		     Hsep2(0,"",(yyvsp[(7) - (14)].i),(yyvsp[(10) - (14)].i))
		  )
	       );
	}
    break;

  case 76:
#line 750 "yacc.y"
    {dpflag=1;}
    break;

  case 77:
#line 751 "yacc.y"
    { dpflag=0;
	  (yyval.i) = Hsep2(0," : ",
                  (yyvsp[(5) - (11)].i),
                  Hsep2(0, OW_rightarrow, (yyvsp[(8) - (11)].i), (yyvsp[(10) - (11)].i))
               );
        }
    break;

  case 78:
#line 757 "yacc.y"
    {dpflag=1;}
    break;

  case 79:
#line 758 "yacc.y"
    { dpflag=0;
	  (yyval.i) = Hsep2(0," : ",
                  (yyvsp[(5) - (11)].i),
                  Hsep2(0, " >= ", (yyvsp[(8) - (11)].i), (yyvsp[(10) - (11)].i))
               );
        }
    break;

  case 80:
#line 764 "yacc.y"
    {dpflag=1;}
    break;

  case 81:
#line 765 "yacc.y"
    { dpflag=0;
	  (yyval.i) = Hsep2(0," : ",
                  (yyvsp[(5) - (11)].i),
                  Hsep2(0, " == ", (yyvsp[(8) - (11)].i), (yyvsp[(10) - (11)].i))
               );
        }
    break;

  case 82:
#line 773 "yacc.y"
    {  (yyval.i) = Pos((yyvsp[(1) - (1)].i),1); }
    break;

  case 83:
#line 776 "yacc.y"
    {  int p;
           p  = length_ilist((yyvsp[(1) - (3)].i)) + 1;
           (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), Pos((yyvsp[(3) - (3)].i),p)); }
    break;

  case 84:
#line 781 "yacc.y"
    {  (yyval.i) = (item *)0;}
    break;

  case 85:
#line 784 "yacc.y"
    { (yyval.i) = Hsep2(3," : ", Pos(check_prec((yyvsp[(3) - (6)].i),RestrictPrec),1),
	                      Pos(check_prec((yyvsp[(5) - (6)].i),RestrictPrec),2)); 
	  (yyval.i)->prec = RestrictPrec;}
    break;

  case 86:
#line 789 "yacc.y"
    { (yyval.i) = Venc(2,Text(OW_case),Text(OW_esac),
                  Pos(itemizeExpressionList((yyvsp[(4) - (6)].i)),1)
               ); 
	  (yyval.i)->prec = CasePrec;}
    break;

  case 87:
#line 795 "yacc.y"
    {  (yyval.i) = (yyvsp[(3) - (4)].i);
	   (yyval.i)->prec = VarPrec;}
    break;

  case 88:
#line 798 "yacc.y"
    {eflag = (yyvsp[(3) - (4)].b);}
    break;

  case 89:
#line 800 "yacc.y"
    { if (!array_mode || !eflag || !ID_context ) 
	    (yyval.i) = Hsep2(0,".", Pos(check_prec((yyvsp[(4) - (8)].i),AffinePrec),1),
                              Pos(check_prec((yyvsp[(7) - (8)].i),AffinePrec),2));
	  else
	    (yyval.i) = Hsep2(0,"", Pos(check_prec((yyvsp[(4) - (8)].i),AffinePrec),1),
                             Pos(check_prec((yyvsp[(7) - (8)].i),AffinePrec),2));
	  (yyval.i)->prec = AffinePrec;}
    break;

  case 90:
#line 809 "yacc.y"
    {eflag = (yyvsp[(3) - (7)].b);}
    break;

  case 91:
#line 810 "yacc.y"
    {
/*          if(noArgForAffineFunction == 1)
            { $$ = Pos(check_prec($6,AffinePrec),1);
              $$->prec = ConstPrec;
            }
          else
*/
          { if (!array_mode || !eflag || !ID_context )
              (yyval.i) = Hsep2(0,".", Pos(check_prec((yyvsp[(6) - (11)].i),AffinePrec),1),
                         Pos(check_prec((yyvsp[(10) - (11)].i),AffinePrec),2));
            else
              (yyval.i) = Hsep2(0,"", Pos(check_prec((yyvsp[(6) - (11)].i),AffinePrec),1),
                         Pos(check_prec((yyvsp[(10) - (11)].i),AffinePrec),2));
            (yyval.i)->prec = AffinePrec;
          }
        }
    break;

  case 92:
#line 828 "yacc.y"
    {  (yyval.i) = (yyvsp[(3) - (4)].i);
	   (yyval.i)->prec = ConstPrec;
        }
    break;

  case 93:
#line 835 "yacc.y"
    {
          (yyval.i) = convert_affine((yyvsp[(10) - (17)].n),(yyvsp[(14) - (17)].n),0,0);
          (yyval.i)->prec = AddPrec;
          free_node((yyvsp[(5) - (17)].n));  free_node((yyvsp[(7) - (17)].n)); free_node((yyvsp[(10) - (17)].n)); free_node((yyvsp[(14) - (17)].n)); }
    break;

  case 94:
#line 842 "yacc.y"
    {   (yyval.i) = Hsep2(2,"",
		   (yyvsp[(3) - (8)].i),
		   Henc(0, Text("("), Text(")"),
                     Pos(Hsep(0,", ", (yyvsp[(6) - (8)].i)),2)
		   )
                 );
        (yyval.i)->prec = CallPrec;}
    break;

  case 95:
#line 851 "yacc.y"
    {   (yyval.i) = Hsep2(0," + ", Pos(check_prec((yyvsp[(5) - (8)].i),AddPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),AddPrec+1),3));
        (yyval.i)->prec = AddPrec;}
    break;

  case 96:
#line 856 "yacc.y"
    {   (yyval.i) = Hsep2(0," * ", Pos(check_prec((yyvsp[(5) - (8)].i),MulPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),MulPrec+1),3));
	    (yyval.i)->prec = MulPrec;}
    break;

  case 97:
#line 861 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_and, Pos(check_prec((yyvsp[(5) - (8)].i),AndPrec),2),
                                  Pos(check_prec((yyvsp[(7) - (8)].i),AndPrec+1),3));
	    (yyval.i)->prec = AndPrec;}
    break;

  case 98:
#line 866 "yacc.y"
    {   (yyval.i) = Henc(0, Text(OW_min), Text(")"),
                    Hsep2(0,", ", Pos(check_prec((yyvsp[(5) - (8)].i),MinPrec),2),
                                  Pos(check_prec((yyvsp[(7) - (8)].i),MinPrec),3))
                 );
	    (yyval.i)->prec = MinPrec;}
    break;

  case 99:
#line 873 "yacc.y"
    {   (yyval.i) = Henc(0, Text(OW_max), Text(")"),
                    Hsep2(0,", ", Pos(check_prec((yyvsp[(5) - (8)].i),MaxPrec),2),
                                  Pos(check_prec((yyvsp[(7) - (8)].i),MaxPrec),3))
                 );
	    (yyval.i)->prec = MaxPrec;}
    break;

  case 100:
#line 880 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_xor, Pos(check_prec((yyvsp[(5) - (8)].i),XorPrec),2),
                                 Pos(check_prec((yyvsp[(7) - (8)].i),XorPrec+1),3));
	    (yyval.i)->prec = XorPrec;}
    break;

  case 101:
#line 885 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_or, Pos(check_prec((yyvsp[(5) - (8)].i),OrPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),OrPrec+1),3));
	    (yyval.i)->prec = OrPrec;}
    break;

  case 102:
#line 890 "yacc.y"
    {   (yyval.i) = Hsep2(0," - ", Pos(check_prec((yyvsp[(5) - (8)].i),SubPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),SubPrec+1),3));
	    (yyval.i)->prec = SubPrec;}
    break;

  case 103:
#line 895 "yacc.y"
    {   (yyval.i) = Hsep2(0," / ", Pos(check_prec((yyvsp[(5) - (8)].i),DivPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),DivPrec+1),3));
	    (yyval.i)->prec = DivPrec; }
    break;

  case 104:
#line 900 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_div, Pos(check_prec((yyvsp[(5) - (8)].i),DivPrec),2),
                                 Pos(check_prec((yyvsp[(7) - (8)].i),DivPrec+1),3));
	    (yyval.i)->prec = DivPrec; }
    break;

  case 105:
#line 905 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_mod, Pos(check_prec((yyvsp[(5) - (8)].i),ModPrec),2),
                                 Pos(check_prec((yyvsp[(7) - (8)].i),ModPrec+1),3));
	    (yyval.i)->prec = ModPrec; }
    break;

  case 106:
#line 910 "yacc.y"
    {   (yyval.i) = Hsep2(0," = ", Pos(check_prec((yyvsp[(5) - (8)].i),EqPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),EqPrec),3));
	    (yyval.i)->prec = EqPrec; }
    break;

  case 107:
#line 915 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_le, Pos(check_prec((yyvsp[(5) - (8)].i),LePrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),LePrec),3));
	    (yyval.i)->prec = LePrec; }
    break;

  case 108:
#line 920 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_lt, Pos(check_prec((yyvsp[(5) - (8)].i),LtPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),LtPrec),3));
	    (yyval.i)->prec = LtPrec; }
    break;

  case 109:
#line 925 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_gt, Pos(check_prec((yyvsp[(5) - (8)].i),GtPrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),GtPrec),3));
	    (yyval.i)->prec = GtPrec; }
    break;

  case 110:
#line 930 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_ge, Pos(check_prec((yyvsp[(5) - (8)].i),GePrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),GePrec),3));
	    (yyval.i)->prec = GePrec; }
    break;

  case 111:
#line 935 "yacc.y"
    {   (yyval.i) = Hsep2(0,OW_ne, Pos(check_prec((yyvsp[(5) - (8)].i),NePrec),2),
                                Pos(check_prec((yyvsp[(7) - (8)].i),NePrec),3));
	    (yyval.i)->prec = NePrec; }
    break;

  case 112:
#line 940 "yacc.y"
    {   (yyval.i) = Hsep2(0,"", Text("-"), Pos(check_prec((yyvsp[(5) - (6)].i),NegPrec),2));
	    (yyval.i)->prec = NegPrec;}
    break;

  case 113:
#line 944 "yacc.y"
    {   (yyval.i) = Hsep2(0," ", Text(OW_not), Pos(check_prec((yyvsp[(5) - (6)].i),NotPrec),2));
	    (yyval.i)->prec = NotPrec;}
    break;

  case 114:
#line 948 "yacc.y"
    {   (yyval.i) = Henc(0,Text(OW_sqrt), Text(")"), Pos((yyvsp[(5) - (6)].i),2) );
	    (yyval.i)->prec = SqrtPrec;}
    break;

  case 115:
#line 952 "yacc.y"
    {   (yyval.i) = Henc(0,Text(OW_abs), Text(")"), Pos((yyvsp[(5) - (6)].i),2) );
	    (yyval.i)->prec = AbsPrec;}
    break;

  case 116:
#line 956 "yacc.y"
    {   (yyval.i) = Hsep2(0,"",
	            Hsep2(0,"",
	               Hsep2(4,"",
                          Text(OW_if),
                          Henc(4,Text("("),Text(")"),
	                    Pos(check_prec((yyvsp[(3) - (8)].i),IfPrec),1)
                          )
                       ),
	               Hsep2(4,"",
		          Text(OW_then),
	                  Pos(check_prec((yyvsp[(5) - (8)].i),IfPrec),2)
	               )
                    ),
	            Hsep2(0,"",
	               Text(OW_else),
	               Pos(check_prec((yyvsp[(7) - (8)].i),IfPrec),3)
	            )
                 );
	    (yyval.i)->prec = IfPrec;}
    break;

  case 117:
#line 981 "yacc.y"
    { (yyval.n) = ID_context;	/* save context */
                  ID_context = ID_List_Save;
                }
    break;

  case 118:
#line 985 "yacc.y"
    { eflag = (yyvsp[(5) - (11)].b);			/* restore array notation */
	  ID_context = (yyvsp[(9) - (11)].n);		/* restore context */
          (yyval.i) = Hsep2(0,"",
	          Text(OW_reduce),
		  Henc(0, Text("("), Text(")"),
		     Hsep3(0,", ",Pos((yyvsp[(3) - (11)].i),1),Pos((yyvsp[(6) - (11)].i),2),Pos((yyvsp[(10) - (11)].i),3))
	          )
	       );
	  (yyval.i)->prec = ReducePrec; }
    break;

  case 119:
#line 996 "yacc.y"
    { (yyval.i) = Text("+"); }
    break;

  case 120:
#line 999 "yacc.y"
    { (yyval.i) = Text("*"); }
    break;

  case 121:
#line 1002 "yacc.y"
    { (yyval.i) = Text(OW_and_p); }
    break;

  case 122:
#line 1005 "yacc.y"
    { (yyval.i) = Text(OW_or_p); }
    break;

  case 123:
#line 1008 "yacc.y"
    { (yyval.i) = Text(OW_xor_p); }
    break;

  case 124:
#line 1011 "yacc.y"
    { (yyval.i) = Text(OW_min_p); }
    break;

  case 125:
#line 1014 "yacc.y"
    { (yyval.i) = Text(OW_max_p); }
    break;

  case 126:
#line 1017 "yacc.y"
    { (yyval.b) = eflag; eflag = 0;}
    break;

  case 127:
#line 1020 "yacc.y"
    { eflag = 1;}
    break;

  case 128:
#line 1024 "yacc.y"
    {  if ((yyvsp[(1) - (1)].n)->the.iconst.infinity==1)
	   {  (yyval.i) = new_item(text);
	      if ((yyvsp[(1) - (1)].n)->the.iconst.value<0)
		 strcpy((yyval.i)->the.text.string,"-Infinity");
	      else
		 strcpy((yyval.i)->the.text.string,"Infinity");
	   }
	   else (yyval.i) = Number((yyvsp[(1) - (1)].n)->the.iconst.value);
	   (yyval.i)->prec = ConstPrec;
	   free_node((yyvsp[(1) - (1)].n)); }
    break;

  case 129:
#line 1036 "yacc.y"
    {  (yyval.i) = new_item(text);
	   if ((yyvsp[(1) - (1)].n)->the.bconst.value)
	      strcpy((yyval.i)->the.text.string,"True");
	   else
	      strcpy((yyval.i)->the.text.string,"False");
	   (yyval.i)->prec = ConstPrec;
	   free_node((yyvsp[(1) - (1)].n)); }
    break;

  case 130:
#line 1045 "yacc.y"
    {  (yyval.i) = Hsep2(0,".",
		   Number((yyvsp[(1) - (1)].n)->the.rconst.value),
		   Number((yyvsp[(1) - (1)].n)->the.rconst.fraction)
		);
	   (yyval.i)->prec = ConstPrec;
	   free_node((yyvsp[(1) - (1)].n));}
    break;

  case 131:
#line 1058 "yacc.y"
    {  (yyval.i) = (yyvsp[(5) - (6)].i);
	   (yyval.i)->prec = 10;
	}
    break;

  case 132:
#line 1063 "yacc.y"
    {  (yyval.n) = ID_List_Save = (yyvsp[(4) - (5)].n);

	   D_Save = (yyvsp[(1) - (5)].n)->the.number.value;
	   free_node((yyvsp[(1) - (5)].n));
	   /* keep $4 */
	}
    break;

  case 133:
#line 1070 "yacc.y"
    {  (yyval.n) = ID_List_Save = new_list(0);
        D_Save = (yyvsp[(1) - (4)].n)->the.number.value;
        free_node((yyvsp[(1) - (4)].n));
	}
    break;

  case 134:
#line 1077 "yacc.y"
    {  (yyval.i) = Hsep(0," | ",(yyvsp[(2) - (3)].i));
	   (yyval.i)->prec = 10;
	}
    break;

  case 135:
#line 1081 "yacc.y"
    {  (yyval.i) = Hsep(0," | ",(yyvsp[(2) - (3)].i));
	   (yyval.i)->prec = 10;
	}
    break;

  case 136:
#line 1090 "yacc.y"
    {  (yyval.n) = new_list((yyvsp[(1) - (1)].n)); }
    break;

  case 137:
#line 1093 "yacc.y"
    {  (yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n)); }
    break;

  case 138:
#line 1096 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 139:
#line 1099 "yacc.y"
    {  (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), (yyvsp[(3) - (3)].i)); }
    break;

  case 140:
#line 1102 "yacc.y"
    { z_flag=1;
          if (array_mode) {
            /* no array notation with Zpols */
                fprintf(stderr,"Array notation is incompatible with Zpols, disabling array notation \n"); 
                array_mode=0;
          }
        }
    break;

  case 141:
#line 1110 "yacc.y"
    {   (yyval.n) = ID_context;
	    ID_context = ID_List_Save;
	}
    break;

  case 142:
#line 1114 "yacc.y"
    {   z_flag=0;
	    (yyval.i) = Hsep(0," | ",(yyvsp[(8) - (10)].i));
	    (yyval.i)->prec = 10;
	    ID_context = (yyvsp[(5) - (10)].n); /* restore context ID_context =  $<n>5 */
	    Mat_Save = (item *) 0;
	}
    break;

  case 143:
#line 1122 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 144:
#line 1125 "yacc.y"
    {  (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), (yyvsp[(3) - (3)].i)); }
    break;

  case 145:
#line 1133 "yacc.y"
    {  if (z_flag)					/* z-polyhedron */
	   	(yyval.i) = convert_zpol(ID_context, Mat_Save, (yyvsp[(12) - (18)].n));
	   else if (!array_mode || !eflag || !ID_context ) /* standard notat */
                (yyval.i) = convert_pol2(ID_List_Save, (yyvsp[(12) - (18)].n), G_dim);
	   else						/* array notation */
	   {	/* Does dim ID_List_Save==dim ID_context? */
		if (ID_context->the.list.count!=ID_List_Save->the.list.count)
		{   (yyval.i) =convert_pol2(ID_List_Save, (yyvsp[(12) - (18)].n),
			             ID_context->the.list.count);
		}
		/* else $$ = spec_pol2(ID_context, $12, G_dim); */
		else (yyval.i) =convert_pol2(ID_context, (yyvsp[(12) - (18)].n),
				      ID_context->the.list.count);
	   }
	   free_node((yyvsp[(3) - (18)].n)); free_node((yyvsp[(5) - (18)].n)); free_node((yyvsp[(7) - (18)].n)); free_node((yyvsp[(9) - (18)].n));
           free_node((yyvsp[(16) - (18)].n)); }
    break;

  case 146:
#line 1156 "yacc.y"
    {
/*        noArgForAffineFunction = (($5->the.iconst.value - G_dim) <= 1); */

          if (dpflag)		/* dependences */
	  {	DepMatIDS = Henc(0, Text("["), Text("]"),
		Hsep(0, ",", id_list2(ID_List_Save,G_dim)));
		(yyval.i) = Henc(0, Text("["), Text("]"),
		    convert_affine(ID_List_Save,(yyvsp[(12) - (14)].n),G_dim,0)
		);
	  }
	  else if ( z_flag )	/* z-polyhedron */
            {  if (ID_context && 0) /* should never happen ? (Tanguy 2003) */
	       (yyval.i) = Mat_Save =
		     convert_affine((yyvsp[(8) - (14)].n),(yyvsp[(12) - (14)].n),ID_context->the.list.count,0);
	     else
	       (yyval.i) = Mat_Save = convert_affine((yyvsp[(8) - (14)].n),(yyvsp[(12) - (14)].n),G_dim,0);
	  }
	  else if ( use_flag )	/* use statements */
	  {  if ( !array_mode ) (yyval.i) = convert_mat(ID_context,(yyvsp[(12) - (14)].n), G_dim, 0);
	     else               (yyval.i) = spec_mat(ID_context, (yyvsp[(12) - (14)].n), 0);
	  }
	  else if ( !array_mode || !eflag || !ID_context ) /* standard notat */
	       (yyval.i) = convert_mat((yyvsp[(8) - (14)].n),(yyvsp[(12) - (14)].n),G_dim,G_dim);
	  else (yyval.i) = spec_mat(ID_context, (yyvsp[(12) - (14)].n), G_dim);      /* array notation */
	  (yyval.i)->prec = 10;
	  ID_List_Save = (yyvsp[(8) - (14)].n);
	  free_node((yyvsp[(3) - (14)].n));  free_node((yyvsp[(5) - (14)].n)); free_node((yyvsp[(12) - (14)].n)); }
    break;

  case 147:
#line 1186 "yacc.y"
    { node *ids = new_list(0);
          if (dpflag)		/* dependences */
	  {	DepMatIDS = Henc(0, Text("["), Text("]"),
		   Hsep(0, ",", id_list2(ID_List_Save,G_dim)));
		(yyval.i) = Henc(0, Text("["), Text("]"),
		    convert_affine(ID_List_Save,(yyvsp[(11) - (13)].n),G_dim,0)
		);
	  }
	  else if ( z_flag )	/* z-polyhedron */
	  {  if (ID_context)
	       (yyval.i) = Mat_Save =
		     convert_affine(ids, (yyvsp[(11) - (13)].n), ID_context->the.list.count, 0);
	     else
	       (yyval.i) = Mat_Save = convert_affine(ids, (yyvsp[(11) - (13)].n), G_dim, 0);
	  }
	  else if ( use_flag )	/* use statements */
	  {  if ( !array_mode ) (yyval.i) = convert_mat(ID_context, (yyvsp[(11) - (13)].n), G_dim, 0);
	     else               (yyval.i) = spec_mat(ID_context, (yyvsp[(11) - (13)].n), 0);
	  }
	  else if ( !array_mode || !eflag || !ID_context ) /* standard notat */
	       (yyval.i) = convert_mat(ids, (yyvsp[(11) - (13)].n), G_dim, G_dim);
	  else (yyval.i) = spec_mat(ID_context, (yyvsp[(11) - (13)].n), G_dim);      /* array notation */
	  (yyval.i)->prec = 10;
	  ID_List_Save = ids;
	  free_node((yyvsp[(3) - (13)].n));  free_node((yyvsp[(5) - (13)].n)); free_node((yyvsp[(11) - (13)].n)); }
    break;

  case 148:
#line 1213 "yacc.y"
    {  (yyval.n) = new_list((yyvsp[(1) - (1)].n)); }
    break;

  case 149:
#line 1216 "yacc.y"
    {  (yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n)); }
    break;

  case 150:
#line 1219 "yacc.y"
    {  (yyval.n) = new_list(0) ;}
    break;

  case 151:
#line 1222 "yacc.y"
    {  (yyvsp[(2) - (3)].n)->type = list;
	   (yyval.n) = new_list((yyvsp[(2) - (3)].n)); }
    break;

  case 152:
#line 1226 "yacc.y"
    {  (yyvsp[(4) - (5)].n)->type = list;
	   (yyval.n) = add_to_list((yyvsp[(1) - (5)].n), (yyvsp[(4) - (5)].n)); }
    break;

  case 153:
#line 1230 "yacc.y"
    {  (yyval.n) = new_list(0);}
    break;


/* Line 1267 of yacc.c.  */
#line 3322 "y.tab.c"
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


#line 1232 "yacc.y"

#include "lex.c"

/* DEFINED PREVIOUSLY             */
/* extern  FILE    *yyin, *yyout; */
/* extern  int     lineNb;        */
/* extern  item    *alpha;        */
FILE *ref=0;	/* the cross reference file */

main(argc, argv)
int argc;
char *argv[];
{ int status, arg;

  yyin  = stdin;
  yyout = stdout;
  latexLayout = 0;
  yydebug = 0;
  arg=1;
  array_mode = 0;   /* default to standard notation */
  annote_flag = 0;  /* default to hide annotations */
  thesystem = 0;    /* default all systems selected */
  eflag=0;
  while (arg < argc)
  {  if (*argv[arg]=='-')
     switch (argv[arg][1])
     {  case 'i':       /* input */
          yyin = fopen(argv[arg+1],"r");
          if (!yyin)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg+1]);
             exit(1);
	  }
          arg++;
          break;
        case 'I':       /* input */
          yyin = fdopen(atoi(argv[arg+1]),"r");
          if (!yyin)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
        case 'o':       /* output */
          yyout = fopen(argv[arg+1],"w");
          if (!yyout)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
        case 'O':       /* output */
          yyout = fdopen(atoi(argv[arg+1]),"w");
          if (!yyout)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
        case 'd':       /* debug */
          yydebug = 1;
          break;
        case 'a':	/* array notation */
	  array_mode = 1;
          break;
	case 'b':	/* show annotation domains */
	  annote_flag = 1;
	  break;
        case 'x':       /* cross ref file */
          ref = fopen(argv[arg+1],"w");
          if (!ref)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
	case 'X':
	  ref = fdopen(atoi(argv[arg+1]),"w");
          if (!ref)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
	case 'p':
	  arg++;
	  if (arg<argc && *argv[arg]!='-')
		G_dim = atoi(argv[arg]);
	  else arg--;
	  break;
        case 's':
          thesystem = atoi(argv[arg+1]);
          arg++;
          break;
	case 't': /* latex script */
          latexLayout = 1;
	  break;
        default:
          fprintf(stderr, "? unknown switch %s\n", argv[arg]);
     }
     arg++;
  }

  lineNb = 1;
  status = yyparse();
  if (status==1) /* parsing failed */ exit(1);
  if (ref) fprintf(ref, "{\n");
  print_item(alpha);
  fputc('\n', yyout);
  if (ref) fprintf(ref, "}");
  return 0;
}

yywrap()
{ return(1); }

yyerror(s)
char *s;
{  fprintf(stderr,"? line %d: %s\n", lineNb, s);
}

