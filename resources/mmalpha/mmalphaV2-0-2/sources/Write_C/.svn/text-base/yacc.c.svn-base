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
     KW_binop = 270,
     KW_unop = 271,
     KW_if = 272,
     KW_add = 273,
     KW_sub = 274,
     KW_mul = 275,
     KW_div = 276,
     KW_idiv = 277,
     KW_mod = 278,
     KW_eq = 279,
     KW_le = 280,
     KW_lt = 281,
     KW_gt = 282,
     KW_ge = 283,
     KW_ne = 284,
     KW_or = 285,
     KW_and = 286,
     KW_neg = 287,
     KW_sqrt = 288,
     KW_not = 289,
     KW_domain = 290,
     KW_pol = 291,
     KW_matrix = 292,
     KW_notype = 293,
     KW_xor = 294,
     KW_max = 295,
     KW_min = 296,
     KW_reduce = 297,
     KW_depend = 298,
     KW_dtable = 299,
     KW_let = 300,
     KW_loop = 301,
     KW_use = 302,
     KW_call = 303,
     KW_abs = 304,
     KW_true = 305,
     KW_false = 306,
     KW_pos_infinity = 307,
     KW_neg_infinity = 308,
     NUMBER = 309,
     REAL = 310,
     ID = 311
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
#define KW_binop 270
#define KW_unop 271
#define KW_if 272
#define KW_add 273
#define KW_sub 274
#define KW_mul 275
#define KW_div 276
#define KW_idiv 277
#define KW_mod 278
#define KW_eq 279
#define KW_le 280
#define KW_lt 281
#define KW_gt 282
#define KW_ge 283
#define KW_ne 284
#define KW_or 285
#define KW_and 286
#define KW_neg 287
#define KW_sqrt 288
#define KW_not 289
#define KW_domain 290
#define KW_pol 291
#define KW_matrix 292
#define KW_notype 293
#define KW_xor 294
#define KW_max 295
#define KW_min 296
#define KW_reduce 297
#define KW_depend 298
#define KW_dtable 299
#define KW_let 300
#define KW_loop 301
#define KW_use 302
#define KW_call 303
#define KW_abs 304
#define KW_true 305
#define KW_false 306
#define KW_pos_infinity 307
#define KW_neg_infinity 308
#define NUMBER 309
#define REAL 310
#define ID 311




/* Copy the first part of user declarations.  */
#line 1 "yacc.y"

 /*  file: $MMALPHA/sources/Write_C/yacc.y
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

#define GREETING "\
/* C-Code generated by Alpha Code Generator version 1.2 */\n\n"

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
/* Previously, the 3 following includes were in Pretty */
#include "../Write_Alpha/item.h"
#include "../Write_Alpha/itemprocs.h"
#include "../Write_Alpha/writeitem.h"

#include <polylib/polylib.h>
#include "../Code_Gen/node.h"
#include "../Code_Gen/nodeprocs.h"
#include "../Code_Gen/gen.h"

#define FREE  1
#define FIXED 2         /* equation i = 2k + +3j +1 */
#define SUBST 3         /* sub i with 2k - 5 */
#define CONST 4         /* sub i with 2 */
/* note: global parameters are always fixed indices */

int	lineNb;		/* Current input line number */
item	*alpha;		/* The alpha tree */
node	*alpha_node;	/* The (partial) alpha node tree */
int	G_dim = 0;	/* Dimension of parameter space */

/* globals */
static  node *ID_List_Save=(node *)0, *Eqn_Decl=(node *)0, *Var_Decl=(node *)0,
             *Eqn_ID=(node *)0, *Olist=(node *)0, *Ilist=(node *)0;
static int case_flag = 0, olist_flag = 0, ilist_flag = 0,
          *G_val = (int *)0;
static int V_Save = 0;  /* the size of the current vector */
static int I_Save = 0;  /* the position of the next element in the vector */
static context_info *Context = (context_info *) 0;      /* current context */

/* flags for compile switches */
static int flag_quietProgram = 0;
static int flag_forSignal = 0; /* 1->the result must be produced for signal */
static int flag_loopNestForInputVariables = 1;

extern char    begcom[], endcom[];  /* comments */

/* comments around the debug statements in the C program */
static char begdbg[]="/* ",enddbg[]=" */";

/*--------------------------------------------------------------------*/
/* create_body ()                                                     */
/*	creates the function that computes local and output variables */
/*      such as the following example:                                */
/*                                                        ------------*/
/*  double compute_X(i,j,k)                               */
/*  int i,j,k;                                            */
/*  {                                                     */
/*    realvar *tmp;                                       */
/*    printf("Computing: X[%d,%d,%d]\n" ,i,j,k);          */
/*    tmp = &(X(i,j,k));                                  */
/*    if (!tmp->computed) {                               */
/*            tmp->value = <formula to compute X(i,j,k)>; */
/*       tmp->computed = 1;}                              */
/*    return tmp->value;                                  */
/*  }                                                     */
/*--------------------------------------------------------*/
static item *create_body(type, t1,t2,t3,id,idlist,unique,dim,infinite)
item *type,		/* intvar, realvar, or boolvar */
     *t1,		/* %d,%d,...  for indices, empty text for scalar */
     *t2,		/* */
     *t3,		/* int or double -- return type */
     *id,		/* Name of variable */
     *idlist,		/* Indices of variable */
     *unique;		/* Body of function -- code to compute value */
int  dim,		/* dim is 0 for scalars, the dim for arrays */
     infinite;		/* True if domain of variable is infinite */

{ if (dim)			/* array */
  { if (!infinite)			/* finite domain */
    { if (idlist->the.hsep.item_list)		/* finite array */
      {
        return Vsep3(0, "",
                  Hsep5(0, "",
                     Text("static "),
                     Copy(t3),
                     Text("compute_"),
                     Copy(id),
                     Henc(0,
                        Text("("),
                        Text(")"),
                        Copy(idlist)
                     )
                  ),
                  Hsep3(0, "",
                     Text("int "),
                     Copy(idlist),
                     Text(";")
                  ),
                  Venc(0, Text("{"), Text("}"),
                     Vlis5(0,"",
                        Hsep3(0, "",
                           Text("  "),
                           Copy(type),
                           Text("*tmp;")
                        ),
                        Henc(0, Text(begdbg),  Text(enddbg),
                           Hsep4(0, "",
                              Text("printf(\"Computing: "),
                              Copy(id),
                              Copy(t1),
                              Henc(0, Text("\\n\" ,"), Text(");"),
                                 Copy(idlist)
                              )
                           )
                        ),
                        Henc(0, Text("  tmp = &("), Text(");"),
                           Hsep2(0, "",
                              Copy(id),
                              Henc(0, Text("("), Text(")"),
			         Copy(idlist)
                              )
		           )
                        ),
                        Henc(5, Text("  if (!tmp->computed) {"), Text("}"),
                           Vlis2(0, "",
                              unique,
                              Text("tmp->computed = 1;")
                           )
                        ),
                        Text("  return tmp->value;")
                     )
                  )
               );
        }
      else						/* scalar ??? */
        return Vsep2(0, "",
                  Hsep5(0,"",
                     Text("static "),
                     Copy(t3),
                     Text("compute_"),
                     Copy(id),
                     Henc(0, Text("("), Text(")"),
                        Copy(idlist)
                     )
                  ),
                  Venc(0, Text("{"), Text("}"),
                     Vlis5(0, "",
                        Hsep3(0, "",
                           Text("  "),
                           Copy(type),
                           Text("*tmp;")
                        ),
                        Henc(0, Text(begdbg),  Text(enddbg),
                           Hsep4(0, "",
                              Text("printf(\"Computing ??: "),
                              Copy(id),
                              Copy(t1),
                              Henc(0, Text("\\n\""), Text(");"),
                                 Copy(idlist)
                              )
                           )
                        ),
                        Henc(0, Text("  tmp = &("), Text(");"),
                           Copy(id)
		        ),
                        Henc(5, Text("  if (!tmp->computed) {"), Text("}"),
                           Vlis2(0, "",
                              unique,
                              Text("tmp->computed = 1;")
                           )
                        ),
                        Text("  return tmp->value;")
                     )
                  )
               );
    }
    else			/* infinite array */
      return Vsep3(0, "",
                Hsep5(0,"",
                   Text("static "),
                   Copy(t3),
                   Text("compute_"),
                   Copy(id),
                   Henc(0, Text("("), Text(")"),
                      Copy(idlist)
                   )
                ),
                Hsep3(0,"",
                   Text("int "),
                   Copy(idlist),
                   Text(";")
                ),
                Venc(0, Text("{"), Text("}"),
                   Vlis4(0, "",
                      Hsep3(0, "",
                         Text("  "),
                         Copy(t3),
                         Text("tmp;")
                      ),
                      Henc(0, Text(begdbg),  Text(enddbg),
                         Hsep4(0, "",
                            Text("printf(\"Computing: "),
                            Copy(id),
                            Copy(t1),
                            Henc(0, Text("\\n\" ,"), Text(");"),
                               Copy(idlist)
                            )
                         )
                      ),
                      unique,
                      Text("  return tmp;")
                   )
                )
             );

  }
  else							/* scalar */
    return Vsep2(0, "",
              Hsep5(0,"",
                 Text("static "),
                 Copy(t3),
                 Text("compute_"),
                 Copy(id),
                 Henc(0, Text("("), Text(")"),
                    Copy(idlist)
                 )
              ),
              Venc(0, Text("{"), Text("}"),
                 Vlis5(0, "",
                    Hsep3(0,"",
                       Text("  "),
                       Copy(type),
                       Text("*tmp;")
                    ),
                    Henc(0, Text(begdbg),  Text(enddbg),
                       Hsep4(0, "",
                          Text("printf(\"Computing: "),
                          Copy(id),
                          Copy(t1),
                          Henc(0, Text("\\n\""), Text(");"),
                             Copy(idlist)
                          )
                       )
                    ),
                    Henc(0, Text("  tmp = &("), Text(");"),
                       Hsep2(0, "", Copy(id), Text("()"))
                    ),
                    Henc(5, Text("  if (!tmp->computed) {"), Text("}"),
                       Vlis2(0,"",
                          unique,
                          Text("tmp->computed = 1;")
                       )
                    ),
                    Text("  return tmp->value;")
                 )
              )
           );
}

/* creates input read functions and output and local predeclarations */
static item *convert_decl2(decls, status)
node *decls;
int status;
{ node *current;
  item *id, *t1, *t2, *t3, *idlist, *type, *unique=(item *)0, *tmp = (item *)0,
  *out = (item *)0;
  int flag = 0, i, dim, infinite;

  for (current=decls->the.list.first; current; current=current->next)
  { /* dim is 0 for scalars, the dim for arrays */
    dim = current->the.decl.domain->the.dom.dim - G_dim;
    /* create items to be used as building blocks */
    id = Text("");
    sprint_name(id->the.text.string,current->the.decl.id);

    t1 = Henc(0, Text("["), Text("]"), dim ? Text("%d") : Text(""));
    for (i=1; i<dim; i++)
      strcat(t1->the.henc.body->the.text.string,",%d");

    if (current->the.decl.type == realtype)
    { type = Text("realvar ");
      t2 = Text("atof");
      t3 = Text("double ");
    }
    else
    { if (current->the.decl.type == booltype) {type = Text("boolvar ");}
      else type = Text("intvar ");
      t2 = Text("atoi");
      t3 = Text("int ");
    }
    idlist = Hsep1(0,",",
                id_list_n(current->the.decl.domain->the.dom.index,G_dim)
             );

    /* test for an infinite domain, requiring different processing */
    if (current->the.decl.w) infinite=0; else infinite=1;

    /* build a declaration item */
    if (status)				/* return input declarations */
    { if (dim==0)                           /* scalar input */
      { if(flag_forSignal)
        { unique = Hsep4(0, "", Text("tmp->value = *"),
                       Copy(id), Text("_IO"), Text(";"));
        }
        else if (flag_quietProgram==1)
        { unique = Vsep2(0, "",
                    Text("gets(__s_);"),
                    Hsep3(0, "",
                       Text("tmp->value = "),
                       Copy(t2),
                       Text("(__s_);")
                    )
                 );
        }
        else
        { unique = Vsep3(0, "",
                    Hsep3(0, "",
                       Text("\n     printf(\"Input "),
                       Copy(id),
                       Henc(0, Text(" =\" "), Text(");"),
                          Text("")
                       )
                    ),
                    Text("gets(__s_);"),
                    Hsep3(0, "",
                       Text("tmp->value = "),
                       Copy(t2),
                       Text("(__s_);")
                    )
                 );
        }
      }
      else                                      /* array input */
      { if (!infinite)                          /* finite array input */
        { if(flag_forSignal)
          { unique = Hsep7(0, "", Text("tmp->value = ("),
                           Copy(t3),
                           Text(")(*"),
                           Copy(id),
                           Text("_IO)"),
                           Text("arrayAcces(current, G_dim)"), /* tmp soln */
                           Text(";"));
          }
          else if (flag_quietProgram==1)
          { unique = Vsep2(0, "",
                      Text("gets(__s_);"),
                      Hsep3(0,"",
                         Text("tmp->value = "),
                         Copy(t2),
                         Text("(__s_);")
                      )
                   );
          }
          else
          { unique = Vsep3(0, "",
                      Hsep4(0, "",
                         Text("\n     printf(\"Input "),
                         Copy(id),
                         Copy(t1),
                         Henc(0, Text(" =\" ,"), Text(");"),
                            Copy(idlist)
                         )
                      ),
                      Text("gets(__s_);"),
                      Hsep3(0,"",
                         Text("tmp->value = "),
                         Copy(t2),
                         Text("(__s_);")
                      )
                   );
          }
        }
        else                                    /* infinite array input */
        { if (flag_quietProgram==1)
          { unique = Vsep2(0, "",
                      Text("  gets(__s_);"),
                      Hsep3(0, "",
                         Text("  tmp = "),
                         Copy(t2),
                         Text("(__s_);")
                      )
                   );
          }
          else
          { unique = Vsep3(0, "",
                      Hsep4(0, "",
                         Text("  printf(\"Input "),
                         Copy(id),
                         Copy(t1),
                         Henc(0, Text(" =\" ,"), Text(");"),
                            Copy(idlist)
                         )
                      ),
                      Text("  gets(__s_);"),
                      Hsep3(0, "",
                         Text("  tmp = "),
                         Copy(t2),
                         Text("(__s_);")
                      )
                   );
          }
        }
      }
      tmp = create_body(type,t1,t2,t3,id,idlist,unique,dim,infinite);
    }
    else if (!status) /* return as predeclarations ie output and local decls */
    { tmp =    Hsep5(0, "",
                  Text("static "),
                  Copy(t3),
                  Text("compute_"),
                  Copy(id),
                  Text("();")
               );
    }
    /* add to out list */
    if (out && !flag) {new_list2(out,tmp); flag = 1;}
    else if (out && flag) add_to_ilist(out,tmp);
    else out = tmp;
  }
  return out;
}



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
#line 502 "yacc.y"
{ node *n; datatype t; item *i; int b; }
/* Line 193 of yacc.c.  */
#line 653 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 666 "y.tab.c"

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
#define YYFINAL  31
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   330

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  62
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  37
/* YYNRULES -- Number of rules.  */
#define YYNRULES  93
/* YYNRULES -- Number of states.  */
#define YYNSTATES  340

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   311

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    60,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    59,     2,    61,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    57,     2,    58,     2,     2,     2,     2,
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
      55,    56
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     9,    11,    13,    15,    17,    20,
      31,    33,    39,    40,    41,    47,    48,    49,    55,    59,
      63,    70,    75,    77,    81,    82,    91,   100,   102,   104,
     106,   108,   112,   113,   114,   122,   124,   128,   129,   130,
     138,   139,   140,   149,   154,   164,   166,   173,   182,   191,
     200,   209,   218,   227,   236,   245,   254,   263,   272,   281,
     290,   299,   308,   317,   326,   333,   340,   347,   356,   365,
     370,   375,   380,   385,   390,   395,   396,   415,   416,   430,
     432,   436,   437,   439,   443,   444,   463,   464,   480,   482,
     486,   487,   491,   497
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      64,     0,    -1,    56,    -1,    57,    65,    58,    -1,    66,
      -1,    81,    -1,    85,    -1,    66,    -1,    65,    66,    -1,
       3,    59,    63,    60,    67,    60,    68,    60,    76,    61,
      -1,    90,    -1,    69,    60,    72,    60,    75,    -1,    -1,
      -1,    57,    70,    77,    71,    58,    -1,    -1,    -1,    57,
      73,    77,    74,    58,    -1,    57,    77,    58,    -1,    57,
      80,    58,    -1,    45,    59,    57,    80,    58,    61,    -1,
      45,    59,    80,    61,    -1,    78,    -1,    77,    60,    78,
      -1,    -1,     4,    59,    56,    60,    79,    60,     5,    61,
      -1,     4,    59,    56,    60,    79,    60,    90,    61,    -1,
       6,    -1,     7,    -1,     8,    -1,    81,    -1,    80,    60,
      81,    -1,    -1,    -1,     9,    59,    56,    82,    60,    85,
      61,    -1,    85,    -1,    83,    60,    85,    -1,    -1,    -1,
      11,    59,    90,    60,    84,    85,    61,    -1,    -1,    -1,
      10,    59,    86,    57,    83,    58,    87,    61,    -1,    12,
      59,    56,    61,    -1,    13,    59,    12,    59,    56,    61,
      60,    95,    61,    -1,    88,    -1,    13,    59,    88,    60,
      95,    61,    -1,    15,    59,    18,    60,    85,    60,    85,
      61,    -1,    15,    59,    19,    60,    85,    60,    85,    61,
      -1,    15,    59,    20,    60,    85,    60,    85,    61,    -1,
      15,    59,    21,    60,    85,    60,    85,    61,    -1,    15,
      59,    22,    60,    85,    60,    85,    61,    -1,    15,    59,
      23,    60,    85,    60,    85,    61,    -1,    15,    59,    24,
      60,    85,    60,    85,    61,    -1,    15,    59,    25,    60,
      85,    60,    85,    61,    -1,    15,    59,    26,    60,    85,
      60,    85,    61,    -1,    15,    59,    27,    60,    85,    60,
      85,    61,    -1,    15,    59,    28,    60,    85,    60,    85,
      61,    -1,    15,    59,    29,    60,    85,    60,    85,    61,
      -1,    15,    59,    30,    60,    85,    60,    85,    61,    -1,
      15,    59,    39,    60,    85,    60,    85,    61,    -1,    15,
      59,    31,    60,    85,    60,    85,    61,    -1,    15,    59,
      41,    60,    85,    60,    85,    61,    -1,    15,    59,    40,
      60,    85,    60,    85,    61,    -1,    16,    59,    32,    60,
      85,    61,    -1,    16,    59,    33,    60,    85,    61,    -1,
      16,    59,    34,    60,    85,    61,    -1,    48,    59,    56,
      60,    57,    83,    58,    61,    -1,    17,    59,    85,    60,
      85,    60,    85,    61,    -1,    14,    59,    54,    61,    -1,
      14,    59,    52,    61,    -1,    14,    59,    53,    61,    -1,
      14,    59,    50,    61,    -1,    14,    59,    51,    61,    -1,
      14,    59,    55,    61,    -1,    -1,    14,    59,    37,    59,
      54,    60,    54,    89,    60,    57,    92,    58,    60,    57,
      98,    58,    61,    61,    -1,    -1,    35,    59,    54,    60,
      57,    92,    58,    91,    60,    57,    93,    58,    61,    -1,
      56,    -1,    92,    60,    56,    -1,    -1,    94,    -1,    93,
      60,    94,    -1,    -1,    36,    59,    54,    60,    54,    60,
      54,    60,    54,    60,    57,    98,    58,    60,    57,    98,
      58,    61,    -1,    -1,    37,    59,    54,    60,    54,    60,
      57,    92,    58,    96,    60,    57,    98,    58,    61,    -1,
      54,    -1,    97,    60,    54,    -1,    -1,    57,    97,    58,
      -1,    98,    60,    57,    97,    58,    -1,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   516,   516,   524,   526,   528,   530,   533,   535,   538,
     809,   815,   818,   818,   818,   830,   830,   830,   841,   852,
     858,   864,   871,   874,   878,   880,   886,   922,   925,   928,
     935,   938,   942,   944,   944,   988,   991,   995,   997,   999,
    1019,  1019,  1019,  1030,  1047,  1062,  1065,  1068,  1072,  1076,
    1080,  1084,  1088,  1092,  1096,  1100,  1104,  1108,  1112,  1116,
    1120,  1124,  1128,  1134,  1140,  1144,  1148,  1152,  1159,  1169,
    1174,  1179,  1184,  1189,  1194,  1200,  1200,  1214,  1213,  1222,
    1225,  1229,  1231,  1234,  1238,  1240,  1257,  1256,  1261,  1271,
    1278,  1282,  1285,  1289
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "KW_system", "KW_decl", "KW_scalar",
  "KW_integer", "KW_boolean", "KW_real", "KW_equation", "KW_case",
  "KW_restrict", "KW_var", "KW_affine", "KW_const", "KW_binop", "KW_unop",
  "KW_if", "KW_add", "KW_sub", "KW_mul", "KW_div", "KW_idiv", "KW_mod",
  "KW_eq", "KW_le", "KW_lt", "KW_gt", "KW_ge", "KW_ne", "KW_or", "KW_and",
  "KW_neg", "KW_sqrt", "KW_not", "KW_domain", "KW_pol", "KW_matrix",
  "KW_notype", "KW_xor", "KW_max", "KW_min", "KW_reduce", "KW_depend",
  "KW_dtable", "KW_let", "KW_loop", "KW_use", "KW_call", "KW_abs",
  "KW_true", "KW_false", "KW_pos_infinity", "KW_neg_infinity", "NUMBER",
  "REAL", "ID", "'{'", "'}'", "'['", "','", "']'", "$accept", "ID_item",
  "Top", "System_List", "System", "Parameter", "System_Head", "Input_Decl",
  "@1", "@2", "Output_Decl", "@3", "@4", "Local_Decl", "Let_Equations",
  "Decl_List", "Decl", "Data_Type", "Equation_List", "Equation", "@5",
  "Exp_List", "Push_Clear_Case", "Exp", "@6", "@7", "Constant", "@8",
  "Domain", "@9", "ID_List", "Pol_List", "Pol", "Matrix", "@10",
  "Number_List", "Number_List_List", 0
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
     305,   306,   307,   308,   309,   310,   311,   123,   125,    91,
      44,    93
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    62,    63,    64,    64,    64,    64,    65,    65,    66,
      67,    68,    70,    71,    69,    73,    74,    72,    75,    76,
      76,    76,    77,    77,    77,    78,    78,    79,    79,    79,
      80,    80,    80,    82,    81,    83,    83,    83,    84,    85,
      86,    87,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    88,
      88,    88,    88,    88,    88,    89,    88,    91,    90,    92,
      92,    92,    93,    93,    93,    94,    96,    95,    97,    97,
      97,    98,    98,    98
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     3,     1,     1,     1,     1,     2,    10,
       1,     5,     0,     0,     5,     0,     0,     5,     3,     3,
       6,     4,     1,     3,     0,     8,     8,     1,     1,     1,
       1,     3,     0,     0,     7,     1,     3,     0,     0,     7,
       0,     0,     8,     4,     9,     1,     6,     8,     8,     8,
       8,     8,     8,     8,     8,     8,     8,     8,     8,     8,
       8,     8,     8,     8,     6,     6,     6,     8,     8,     4,
       4,     4,     4,     4,     4,     0,    18,     0,    13,     1,
       3,     0,     1,     3,     0,    18,     0,    15,     1,     3,
       0,     3,     5,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     4,     5,     6,    45,     0,     0,
      40,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       7,     1,     2,     0,    33,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       3,     8,     0,     0,    37,     0,    38,    43,     0,     0,
       0,    72,    73,    70,    71,    69,    74,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      10,     0,     0,    35,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    37,     0,     0,    41,     0,     0,     0,     0,     0,
      46,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    64,
      65,    66,     0,     0,    12,     0,     0,    34,     0,    36,
      81,    39,     0,     0,    75,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    24,     0,     0,    42,    79,     0,
       0,     0,     0,    47,    48,    49,    50,    51,    52,    53,
      54,    55,    56,    57,    58,    59,    61,    60,    63,    62,
      68,    67,     0,    13,    22,     0,    32,     0,    15,     0,
      77,     0,    44,     0,     0,     0,     0,     0,    32,     0,
      30,     9,    24,     0,     0,    80,     0,    81,     0,    23,
      14,    32,     0,    19,     0,    16,    24,    11,     0,    81,
       0,     0,     0,    21,    31,     0,     0,    84,     0,     0,
      27,    28,    29,     0,     0,    17,    18,     0,     0,    82,
      86,     0,     0,    20,     0,     0,     0,     0,    93,     0,
       0,     0,    78,    83,     0,    90,     0,    25,    26,     0,
      93,    88,     0,     0,     0,     0,     0,    91,     0,     0,
      90,     0,     0,    89,    76,     0,     0,    87,    92,     0,
       0,     0,    93,     0,     0,     0,    93,     0,     0,    85
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    33,    13,    29,    14,   109,   175,   176,   204,   247,
     239,   252,   275,   267,   237,   233,   234,   283,   249,   250,
      73,   112,   115,   113,    35,   178,    17,   212,    37,   254,
     209,   288,   289,   118,   297,   312,   306
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -290
static const yytype_int16 yypact[] =
{
       3,   -56,   -52,   -48,   -17,    -2,    -1,    25,    51,    56,
      57,    86,    71,   111,  -290,  -290,  -290,  -290,    81,    87,
    -290,   113,    90,    52,   -27,   100,    16,    20,    93,     1,
    -290,  -290,  -290,    91,  -290,    95,    94,   112,    89,   114,
     115,   117,   110,   116,   118,   119,   120,   121,   123,   124,
     125,   126,   127,   128,   129,   130,   131,   132,   133,   134,
     135,   136,   137,   138,   139,   140,   141,   142,   143,   144,
    -290,  -290,   113,   145,    20,   152,  -290,  -290,   122,   170,
     154,  -290,  -290,  -290,  -290,  -290,  -290,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,   153,   149,
    -290,    20,     7,  -290,   151,    20,   155,   156,   157,   159,
     160,   162,   163,   164,   165,   166,   167,   168,   169,   171,
     172,   173,   174,   175,   176,   177,   178,   179,   180,   181,
     183,    20,   182,   184,  -290,    20,   187,   185,   188,   158,
    -290,   193,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,  -290,
    -290,  -290,    20,    11,  -290,   189,   190,  -290,   191,  -290,
     161,  -290,   170,   194,  -290,   192,   195,   196,   197,   198,
     199,   200,   201,   202,   204,   205,   206,   207,   208,   209,
     210,   211,   212,   213,   226,    -5,   218,  -290,  -290,    12,
     215,   223,   219,  -290,  -290,  -290,  -290,  -290,  -290,  -290,
    -290,  -290,  -290,  -290,  -290,  -290,  -290,  -290,  -290,  -290,
    -290,  -290,   221,   222,  -290,   224,   242,   217,  -290,   225,
    -290,   228,  -290,   227,   229,   232,   226,   231,    -4,    15,
    -290,  -290,   226,   233,   234,  -290,   235,   161,   236,  -290,
    -290,   242,   -15,  -290,   242,   222,   226,  -290,   238,   161,
      18,    55,    19,  -290,  -290,   239,    22,   245,    23,   240,
    -290,  -290,  -290,   241,   230,  -290,  -290,   243,    27,  -290,
    -290,   246,     4,  -290,   244,   247,   245,   249,   248,   250,
     251,   253,  -290,  -290,   257,   252,    28,  -290,  -290,   256,
     248,  -290,    54,   254,   259,   258,    74,  -290,   263,   260,
     252,   265,   261,  -290,  -290,    75,   264,  -290,  -290,   266,
     267,   268,   248,    78,   269,   271,   248,    84,   262,  -290
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -290,  -290,  -290,  -290,    26,  -290,  -290,  -290,  -290,  -290,
    -290,  -290,  -290,  -290,  -290,  -244,   -33,  -290,  -207,     0,
    -290,    73,  -290,     2,  -290,  -290,   270,  -290,   -71,  -290,
    -213,  -290,   -41,   148,  -290,   -21,  -289
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint16 yytable[] =
{
      15,   110,    16,    18,     1,     2,     1,    19,   265,   299,
      41,    20,     2,     3,     4,     5,     6,     7,     8,     9,
      10,   316,   276,    42,    43,    44,    45,    46,    47,    68,
       3,     4,     5,     6,     7,     8,     9,    10,    30,    36,
     235,   262,    21,   333,   270,   264,   273,   337,    65,    66,
      67,    11,   236,   261,   272,    71,   278,    22,    23,    70,
      12,   280,   281,   282,    39,   144,     7,   145,    11,   203,
     240,   145,   241,   263,     1,   264,   279,   284,   241,   264,
     286,   290,   246,   241,    24,   295,   313,   296,   314,   120,
     121,   122,   123,   124,   125,   126,   127,   128,   129,   130,
     131,   132,   133,   134,   135,   136,   137,   138,   139,   140,
      25,    31,   317,   143,   318,    26,    27,   147,    48,    49,
      50,    51,    52,    53,    54,    55,    56,    57,    58,    59,
      60,    61,   322,   328,   314,   318,   334,    32,   314,    62,
      63,    64,   338,    34,   314,    28,    38,   179,    36,    69,
      77,    72,    74,    75,   185,   186,   187,   188,   189,   190,
     191,   192,   193,   194,   195,   196,   197,   198,   199,   200,
     201,    81,    76,    78,   202,    79,    80,    82,   116,    83,
      84,    85,    86,    87,    88,    89,    90,    91,    92,    93,
      94,    95,    96,    97,    98,    99,   100,   101,   102,   103,
     104,   105,   106,   107,   108,   111,   114,   117,   119,   142,
     141,   146,   183,   259,   173,   149,   148,   208,   150,   151,
     152,   300,   153,   154,   155,   156,   157,   158,   159,   160,
     232,   161,   162,   163,   164,   165,   166,   167,   168,   174,
     169,   170,   171,   172,   180,   177,   181,   184,   182,   205,
     206,     2,   207,   213,   211,   303,   214,   215,   216,   217,
     218,   219,   220,   221,   274,   222,   223,   224,   225,   226,
     227,   228,   229,   230,   231,   238,   242,   243,   251,   244,
     245,   287,   246,   248,   255,   253,   257,   256,   258,   260,
     266,   293,   269,    40,   268,   277,   271,   285,   301,   325,
     291,   292,   294,   298,     0,   305,   311,     0,   302,   304,
     315,   307,   308,   309,   310,   319,   320,   323,   321,   326,
     330,   324,   327,   339,   329,   332,     0,   331,   336,   335,
     210
};

static const yytype_int16 yycheck[] =
{
       0,    72,     0,    59,     3,     9,     3,    59,   252,     5,
      37,    59,     9,    10,    11,    12,    13,    14,    15,    16,
      17,   310,   266,    50,    51,    52,    53,    54,    55,    27,
      10,    11,    12,    13,    14,    15,    16,    17,    12,    35,
      45,   248,    59,   332,   257,    60,    61,   336,    32,    33,
      34,    48,    57,    57,   261,    29,   269,    59,    59,    58,
      57,     6,     7,     8,    12,    58,    14,    60,    48,    58,
      58,    60,    60,    58,     3,    60,    58,    58,    60,    60,
      58,    58,    60,    60,    59,    58,    58,    60,    60,    87,
      88,    89,    90,    91,    92,    93,    94,    95,    96,    97,
      98,    99,   100,   101,   102,   103,   104,   105,   106,   107,
      59,     0,    58,   111,    60,    59,    59,   115,    18,    19,
      20,    21,    22,    23,    24,    25,    26,    27,    28,    29,
      30,    31,    58,    58,    60,    60,    58,    56,    60,    39,
      40,    41,    58,    56,    60,    59,    56,   145,    35,    56,
      61,    60,    57,    59,   152,   153,   154,   155,   156,   157,
     158,   159,   160,   161,   162,   163,   164,   165,   166,   167,
     168,    61,    60,    59,   172,    60,    59,    61,    56,    61,
      61,    61,    61,    60,    60,    60,    60,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    60,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    54,    37,    54,    60,
      57,    60,    54,   246,   141,    59,    61,    56,    61,    60,
      60,   292,    60,    60,    60,    60,    60,    60,    60,    60,
       4,    60,    60,    60,    60,    60,    60,    60,    60,    57,
      61,    61,    61,    60,    57,    61,    61,    54,    60,    60,
      60,     9,    61,    61,    60,   296,    61,    61,    61,    61,
      61,    61,    61,    61,   264,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    57,    61,    54,    61,    60,
      59,    36,    60,    59,    56,    60,    57,    60,    56,    58,
      57,    61,    57,    23,    60,    57,    60,    58,    54,   320,
      60,    60,    59,    57,    -1,    57,    54,    -1,    61,    60,
      54,    61,    61,    60,    57,    61,    57,    54,    60,    54,
      54,    61,    61,    61,    60,    57,    -1,    60,    57,    60,
     182
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     9,    10,    11,    12,    13,    14,    15,    16,
      17,    48,    57,    64,    66,    81,    85,    88,    59,    59,
      59,    59,    59,    59,    59,    59,    59,    59,    59,    65,
      66,     0,    56,    63,    56,    86,    35,    90,    56,    12,
      88,    37,    50,    51,    52,    53,    54,    55,    18,    19,
      20,    21,    22,    23,    24,    25,    26,    27,    28,    29,
      30,    31,    39,    40,    41,    32,    33,    34,    85,    56,
      58,    66,    60,    82,    57,    59,    60,    61,    59,    60,
      59,    61,    61,    61,    61,    61,    61,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    60,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    60,    60,    60,    67,
      90,    60,    83,    85,    54,    84,    56,    37,    95,    54,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    57,    60,    85,    58,    60,    60,    85,    61,    59,
      61,    60,    60,    60,    60,    60,    60,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    60,    60,    60,    61,
      61,    61,    60,    83,    57,    68,    69,    61,    87,    85,
      57,    61,    60,    54,    54,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    85,    58,    70,    60,    60,    61,    56,    92,
      95,    60,    89,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,     4,    77,    78,    45,    57,    76,    57,    72,
      58,    60,    61,    54,    60,    59,    60,    71,    59,    80,
      81,    61,    73,    60,    91,    56,    60,    57,    56,    78,
      58,    57,    80,    58,    60,    77,    57,    75,    60,    57,
      92,    60,    80,    61,    81,    74,    77,    57,    92,    58,
       6,     7,     8,    79,    58,    58,    58,    36,    93,    94,
      58,    60,    60,    61,    59,    58,    60,    96,    57,     5,
      90,    54,    61,    94,    60,    57,    98,    61,    61,    60,
      57,    54,    97,    58,    60,    54,    98,    58,    60,    61,
      57,    60,    58,    54,    61,    97,    54,    61,    58,    60,
      54,    60,    57,    98,    58,    60,    57,    98,    58,    61
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
#line 517 "yacc.y"
    { (yyval.i) = Text("");
	  sprint_name((yyval.i)->the.text.string,(yyvsp[(1) - (1)].n));
          free_node((yyvsp[(1) - (1)].n));
        }
    break;

  case 3:
#line 525 "yacc.y"
    { alpha = (yyvsp[(2) - (3)].i); YYACCEPT; }
    break;

  case 4:
#line 527 "yacc.y"
    { alpha = (yyvsp[(1) - (1)].i); YYACCEPT; }
    break;

  case 5:
#line 529 "yacc.y"
    { alpha = (yyvsp[(1) - (1)].i); YYACCEPT; }
    break;

  case 6:
#line 531 "yacc.y"
    { alpha = (yyvsp[(1) - (1)].i); YYACCEPT; }
    break;

  case 7:
#line 534 "yacc.y"
    { (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 8:
#line 536 "yacc.y"
    { (yyval.i) = (yyvsp[(1) - (2)].i); }
    break;

  case 9:
#line 540 "yacc.y"
    { node *a, *D, *idlists, *current;
          item *d4, *bound, *final, *main, *mainlist = (item *)0, 
               *d3, *d1, *d2, *f1;
          int i, j, k, array_dim;
          context_info *C2; 

	  /* These three must be done before calling control_domain */
          /* which frees the.dec.domain's */
          f1 = convert_decl2( alpha_node->the.sys.in, 1);
          f1 = add_to_ilist(f1, convert_decl2( alpha_node->the.sys.out, 0));
          f1 = add_to_ilist(f1, convert_decl2( alpha_node->the.sys.local, 0));
          f1 = add_to_ilist(f1, (yyvsp[(9) - (10)].i));

          mainlist = final = declare_indices();
	  final->next = Text("/* --inputs */");
          final = final->next;

          if (flag_loopNestForInputVariables)
          for (a = Ilist; a; a = a->next)
          {
	    D = get_decl(a,alpha_node);		/* get decl of input */
            /* dim of array is dim - dim of param */
            array_dim = D->the.decl.domain->the.dom.dim - G_dim;
	    idlists   = D->the.decl.domain->the.dom.index;

            /* compute loop */
            /* do before d3 so substitutions are right */
            C2 = control_domain(D->the.decl.domain, Context);
	    /* FREES D->the.decl.domain */

            /* d1 : a printf format string to print indices: %d,%d,... */
            d1 = Text("");
	    for (i=0; i<array_dim; i++)
	    { if (i==0) strcat(d1->the.text.string,"%d");
	      else      strcat(d1->the.text.string,",%d");
	    }

            /* d2 : a printf format string to print the output: %f or %d */
	    if (D->the.decl.type == realtype) d2 = Text("%f");
	    else                              d2 = Text("%d");

            /* d3 : the list of indices: i,j,... */
	    d3 = Hsep1(0, ",", id_list_n_sub(idlists, G_dim));

            /* d4 : the output name */
            d4 = Text("");
	    sprint_name(d4->the.text.string, a); 

            /* build loop body */
	    if (array_dim>0)
              if (!flag_quietProgram)
	        main = Henc(0, Text("printf(\""), Text(" );"),	/* array */
		         Hsep6(0, "",
                           Copy(d4),
			   Henc(0, Text("["), Text("]= "), d1),
			   d2,
			   Text("\\n\", "),
			   Copy(d3),
	                   Hsep3(0, "",
                              Text(", compute_"),
			      Copy(d4),
			      Henc(0, Text("("), Text(")"),
			         Copy(d3)
			      )
		           )
			 )
		       );
              else /* quiet prog */
                main =Hsep3(0, "",
                            Text(" compute_"),
                            Copy(d4),
                            Henc(0, Text("("), Text(");"),
                                 Copy(d3)
                                 )
                            );
            else /* scalar */
              if (!flag_quietProgram)
	        main = Henc(0, Text("printf(\""), Text(" );"),	/* scalar */
		          Hsep5(0, "",
                             Copy(d4),
			     Text(" = "),
			     d2,
			     Text("\\n\" "),
	                     Hsep3(0, "",
                                Text(", compute_"),
			        Copy(d4),
                                Henc(0, Text("("), Text(")"),
			           Text("")
			        )
		             )
			  )
	               );
              else /* quiet prog */
                main =Hsep3(0, "",
                            Text(" compute_"),
                            Copy(d4),
                            Henc(0, Text("("), Text(");"),
                                  Text("")
                                 )
                            );

            /* insert body into control code */
            *(C2->body) = main;
	    final->next = C2->code;
            final = C2->code;

            /* free context 
            C2->code = (item *) 0;
            free_node(C2->index);
            Domain_Free(C2->dom);
            free(C2); */

            /* restore the old context */
            index_restore(Context->index_stamp);
          }

	  final->next = Text("/* --outputs */");
          final = final->next;

          for (a = Olist; a; a = a->next)
          {
	    D = get_decl(a,alpha_node);		/* get decl of output */
            /* dim of array is dim - dim of param */
            array_dim = D->the.decl.domain->the.dom.dim - G_dim;
	    idlists   = D->the.decl.domain->the.dom.index;

            /* compute loop */
            /* do before d3 so substitutions are right */
            C2 = control_domain(D->the.decl.domain, Context);
	    /* FREES D->the.decl.domain */

            /* d1 : a printf format string to print indices: %d,%d,... */
            d1 = Text("");
	    for (i=0; i<array_dim; i++)
	    { if (i==0) strcat(d1->the.text.string,"%d");
	      else      strcat(d1->the.text.string,",%d");
	    }

            /* d2 : a printf format string to print the output: %f or %d */
	    if (D->the.decl.type == realtype) d2 = Text("%f");
	    else                              d2 = Text("%d");

            /* d3 : the list of indices: i,j,... */
	    d3 = Hsep1(0, ",", id_list_n_sub(idlists, G_dim));

            /* d4 : the output name */
            d4 = Text("");
	    sprint_name(d4->the.text.string, a); 

            /* build loop body */
	    if (array_dim>0)
              if (!flag_quietProgram)
	        main = Henc(0, Text("printf(\""), Text(" );"),	/* array */
	                 Hsep6(0, "",
                           Copy(d4),
			   Henc(0, Text("["), Text("]= "), d1),
			   d2,
			   Text("\\n\", "),
			   Copy(d3),
	                   Hsep3(0, "",
                              Text(", compute_"),
			      Copy(d4),
			      Henc(0, Text("("), Text(")"),
			         Copy(d3)
			      )
		           )
			 )
		       );
              else /* quiet prog */
                main =Henc(0, Text("printf(\""), Text(" );"), /* array */
                           Hsep2(0, "",
                                 Copy(d2),
                                 Hsep3(0, "",
                                       Text("\\n\", compute_"),
                                       Copy(d4),
                                       Henc(0, Text("("), Text(")"),
                                            Copy(d3)
                                            )
                                       )
                                 )
                      );
            else /* scalar */
              if (!flag_quietProgram)
	        main = Henc(0, Text("printf(\""), Text(" );"),	/* scalar */
	                 Hsep5(0, "",
                           Copy(d4),
			   Text(" = "),
			   d2,
			   Text("\\n\" "),
	                   Hsep3(0, "",
                              Text(", compute_"),
			      Copy(d4),
                              Henc(0, Text("("), Text(")"),
			         Text("")
			      )
		           )
			 )
	               );
              else /* quiet prog */
                 main =Henc(0, Text("printf(\""), Text(" );"),
                            Hsep2(0, "",
                                  Copy(d2),
                                  Hsep3(0, "",
                                        Text("\\n\", compute_"),
                                         Copy(d4),
                                        Henc(0, Text("("), Text(")"),
                                             Text("")
                                             )
                                        )
                                  )
                             );

            /* insert body into control code */
            *(C2->body) = main;
	    final->next = C2->code;
            final = C2->code;

            /* free context
            C2->code = (item *) 0;
            free_node(C2->index);
            Domain_Free(C2->dom);
            free(C2); */

            /* restore the old context */
            index_restore(Context->index_stamp);
          }

          (yyval.i) = Vsep7(0, "\n\n",
                  Henc(0, Text("/* system "), Text(" */"), (yyvsp[(3) - (10)].i)),
                  Vsep9(0, "",
     Text(GREETING),
     Text("#include <stdlib.h>\n"),
     Text("#include <stdio.h>\n"),
     Text("#include <math.h>\n"),
     Text("typedef struct { int value;\n\t\t int computed; } intvar;"),
     Text("typedef struct { int value;\n\t\t int computed; } boolvar;"),
     Text("typedef struct { double value;\n\t\t int computed; } realvar;"),
     Text("double atof();"),
     Text("int    atoi();")
		  ),
/*		  Vsep11(0, "", */
		  Vsep10(0, "", 
     Text("#define min(x,y) ((x)<(y)?(x):(y))"),
     Text("#define max(x,y) ((x)>(y)?(x):(y))"),
/*     This is already defined in math.h */
/*     Text("#define INFINITY 0x7fffffff"), */
     Text("#define SHR(x,y) ((x)/(double)(1<<(y)))"),
     Text("#define SHL(x,y) ((x)*(double)(1<<(y)))"),
     Text("#define EXP(x,y) pow((x),(y))"),
     Text("#define TRUNCATE(x) ((int)(x))"),
     Text("#define CEILING(x) ((int)(ceil(x)))"),
     Text("#define FLOOR(x) ((int)(floor(x)))"),
     Text("#define ROUND(x) ((int)(rint(x)))"),
     Text("#define FLOAT(x) ((double)(x))")
                  ),
                  (yyvsp[(5) - (10)].i),			/* Parameter define */
                  (yyvsp[(7) - (10)].i),			/* Variable declarations */
		  Vsep(0, "\n\n",	/* input functions and predeclarations*/
                    f1			/* output and local functions */
                  ),
	          Vlis2(0, "",		/* main function */
                     Text("int main()"),
		     Venc(3, Text("{"), Text("}"),
                        Vsep1(0, "", mainlist)
                     )
		  )
	       );
	}
    break;

  case 10:
#line 810 "yacc.y"
    {   /* initialize the context */
            Context = (context_info *) malloc (sizeof(context_info));
            (yyval.i) = initialize_context((yyvsp[(1) - (1)].n), G_dim, G_val, Context);
        }
    break;

  case 11:
#line 816 "yacc.y"
    { (yyval.i) = Vsep3(0, "\n\n", (yyvsp[(1) - (5)].i), (yyvsp[(3) - (5)].i), (yyvsp[(5) - (5)].i)); }
    break;

  case 12:
#line 818 "yacc.y"
    {ilist_flag=1;}
    break;

  case 13:
#line 818 "yacc.y"
    {ilist_flag=0;}
    break;

  case 14:
#line 819 "yacc.y"
    { if ((yyvsp[(3) - (5)].n)->the.list.first == (node *)0)
            (yyval.i) = Text("/* no input variables */");
          else
            (yyval.i) = Vsep3(0,"",
                    Text("/* input variables */\n"),
                    Text("char __s_[32];\n"),
                    Vsep(0, "", convert_decl((yyvsp[(3) - (5)].n),1))
                 );
          alpha_node->the.sys.in = (yyvsp[(3) - (5)].n);
        }
    break;

  case 15:
#line 830 "yacc.y"
    {olist_flag=1;}
    break;

  case 16:
#line 830 "yacc.y"
    {olist_flag=0;}
    break;

  case 17:
#line 831 "yacc.y"
    { if ((yyvsp[(3) - (5)].n)->the.list.first == (node *)0)
            (yyval.i) = Text("/* no output variables */");
          else
            (yyval.i) = Vsep2(0, "",
		    Text("/* output variables */\n"),
		    Vsep(0, "\n", convert_decl((yyvsp[(3) - (5)].n),1))
                 );
          alpha_node->the.sys.out = (yyvsp[(3) - (5)].n);
        }
    break;

  case 18:
#line 842 "yacc.y"
    { if ((yyvsp[(2) - (3)].n)->the.list.first == (node *)0)
            (yyval.i) = Text("/* no local variables */");
          else
            (yyval.i) = Vsep2(0,"",
                    Text("/* local variables */\n"),
                    Vsep(0, "", convert_decl((yyvsp[(2) - (3)].n),1))
                 );
          alpha_node->the.sys.local = (yyvsp[(2) - (3)].n);
        }
    break;

  case 19:
#line 853 "yacc.y"
    { (yyval.i) = Vsep2(0, "",
		  Text("/* --let equations */\n"),
		  Vsep1(0, "\n\n", (yyvsp[(2) - (3)].i))
               );
	}
    break;

  case 20:
#line 859 "yacc.y"
    { (yyval.i) = Vsep2(0, "",
		  Text("/* --let equations */\n"),
		  Vlis1(0, "\n", (yyvsp[(4) - (6)].i))
	       );
	}
    break;

  case 21:
#line 865 "yacc.y"
    { (yyval.i) = Vsep2(0, "",
		  Text("/* --let equations */\n"),
		  Vlis1(0, "\n", (yyvsp[(3) - (4)].i))
	       );
	}
    break;

  case 22:
#line 872 "yacc.y"
    {  (yyval.n) = new_list((yyvsp[(1) - (1)].n)); }
    break;

  case 23:
#line 875 "yacc.y"
    {  (yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n)); }
    break;

  case 24:
#line 878 "yacc.y"
    {  (yyval.n) = new_list(0);}
    break;

  case 25:
#line 881 "yacc.y"
    {  (yyval.n) = new_node(decl);
           (yyval.n)->the.decl.id = (yyvsp[(3) - (8)].n);
           (yyval.n)->the.decl.type = (yyvsp[(5) - (8)].t);
           (yyval.n)->the.decl.domain = (node *)0; }
    break;

  case 26:
#line 887 "yacc.y"
    {  Polyhedron *P;
           node *tail;
           node *p;
           int i;

           if (ilist_flag)
           { /* creates a list for use in main body loop calculations */
             if (Ilist) {tail->next = (yyvsp[(3) - (8)].n); tail = (yyvsp[(3) - (8)].n);}
             else {Ilist = tail = (yyvsp[(3) - (8)].n);}
	   }

           if (olist_flag)
           { /* creates a list for use in main body loop calculations */
             if (Olist) {tail->next = (yyvsp[(3) - (8)].n); tail = (yyvsp[(3) - (8)].n);}
             else {Olist = tail = (yyvsp[(3) - (8)].n);}
	   }

           (yyval.n) = new_node(decl);
           (yyval.n)->the.decl.id = (yyvsp[(3) - (8)].n);
           (yyval.n)->the.decl.type = (yyvsp[(5) - (8)].t);
           (yyval.n)->the.decl.domain = (yyvsp[(7) - (8)].n);
           P = node2domain((yyvsp[(7) - (8)].n));
           compute_W(P, Context->dom, (yyvsp[(7) - (8)].n)->the.dom.index, Context->index,
                     &((yyval.n)->the.decl.l), &((yyval.n)->the.decl.w) );
           Domain_Free(P);

           /* Declare the indices */
           for (i=0, p=(yyvsp[(7) - (8)].n)->the.dom.index->the.list.first ;
                i<((yyvsp[(7) - (8)].n)->the.dom.dim-G_dim) ;
                i++, p= p->next ) {  
             mark_index(p, FREE);
           }

        }
    break;

  case 27:
#line 923 "yacc.y"
    {  (yyval.t)=inttype; }
    break;

  case 28:
#line 926 "yacc.y"
    {  (yyval.t)=booltype; }
    break;

  case 29:
#line 929 "yacc.y"
    {  (yyval.t)=realtype; }
    break;

  case 30:
#line 936 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 31:
#line 939 "yacc.y"
    {  (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), (yyvsp[(3) - (3)].i)); }
    break;

  case 32:
#line 942 "yacc.y"
    {  (yyval.i) = (item *)0;}
    break;

  case 33:
#line 944 "yacc.y"
    { Eqn_Decl = get_decl((yyvsp[(3) - (3)].n),alpha_node);}
    break;

  case 34:
#line 945 "yacc.y"
    { item *id, *idlist, *t1, *t2, *t3, *type, *contents;
	  int i, infinite, dim;
	  
	  id = Text("");
	  sprint_name(id->the.text.string,Eqn_Decl->the.decl.id);

          dim = Eqn_Decl->the.decl.domain->the.dom.dim - G_dim;

          t1 = Henc(0, Text("["), Text("]"), dim ? Text("%d") : Text(""));
          for (i=1; i<dim; i++)
            strcat(t1->the.henc.body->the.text.string,",%d");

	  if (Eqn_Decl->the.decl.type == realtype)
	    { type = Text("realvar ");
	      t2 = Text("atof");
              t3 = Text("double ");
	    }
	  else
	    { if (Eqn_Decl->the.decl.type == booltype) type = Text("boolvar ");
	      else                                     type = Text("intvar ");
	      t2 = Text("atoi");
	      t3 = Text("int ");
	    }
	  idlist = Hsep1(0, ",",
		      id_list_n(Eqn_Decl->the.decl.domain->the.dom.index,G_dim)
		   );
	  /* test for an infinite domain, requiring different processing */
          if (Eqn_Decl->the.decl.w) infinite=0; else infinite=1;

	  if (!infinite)
               contents = Henc(0, Text("\n     tmp->value = "), Text(""),
		             Hlis2(0, "", (yyvsp[(6) - (7)].i), Text(";"))
                          );
          else contents = Henc(0, Text("  tmp = "), Text(""),
			     Hlis2(0, "", (yyvsp[(6) - (7)].i), Text(";"))
                          );

	  (yyval.i) = create_body(type,t1,t2,t3,id,idlist,contents,
                           dim,infinite);
	  Eqn_ID=(node *)0;
	  (yyval.i)->prec = 0;
	}
    break;

  case 35:
#line 989 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 36:
#line 992 "yacc.y"
    {  (yyval.i) = add_to_ilist((yyvsp[(1) - (3)].i), (yyvsp[(3) - (3)].i)); }
    break;

  case 37:
#line 995 "yacc.y"
    {  (yyval.i) = (item *)0;}
    break;

  case 38:
#line 997 "yacc.y"
    {(yyval.b)=case_flag; case_flag=0;}
    break;

  case 39:
#line 1000 "yacc.y"
    { item *tmp, *item3;
          item3 = Hsep1(0, "",
		     domain2C(Eqn_Decl->the.decl.domain->the.dom.index, (yyvsp[(3) - (7)].n))
		  );
	  tmp = Hsep2(3, " ? ",
                   Henc(2, Text("( "), Text(" ) "), item3),
		   Henc(2, Text("( "), Text(" ) : "), (yyvsp[(6) - (7)].i))
		);
	  /* flag was pushed on symbol stack and cleared for Exp */
	  case_flag = (yyvsp[(5) - (7)].b);	/* restore case flag */
	  if (case_flag) (yyval.i) = tmp;
	  else (yyval.i) = Vlis2(0, "",
		       tmp,
/* GCC does not support this kind of exit instruction */
/*                     Text("  ( printf(\"? restriction error\\n\"), exit(-1))") */
                       Text("  ( printf(\"? restriction error\\n\"))")
		    );
	  (yyval.i)->prec = 0;}
    break;

  case 40:
#line 1019 "yacc.y"
    {case_flag = 1;}
    break;

  case 41:
#line 1019 "yacc.y"
    {case_flag = 0;}
    break;

  case 42:
#line 1020 "yacc.y"
    { /* check the types of all the expressions; if they are not restricts,
	     then dont bother with them */
	  (yyval.i) = Vsep2(2, "",
		  Vsep1(2,"",(yyvsp[(5) - (8)].i)),
/* GCC does not support this kind of exit instruction 
                  Text("  ( printf(\"? case error\\n\"), exit(-1))") */
		  Text("  ( printf(\"? case error\\n\"))")
	       );
	  (yyval.i)->prec = 0;}
    break;

  case 43:
#line 1031 "yacc.y"
    { item *name;
          Var_Decl = get_decl((yyvsp[(3) - (4)].n),alpha_node);
          name = Text("");
	  sprint_name(name->the.text.string,Var_Decl->the.decl.id);
	  (yyval.i) = Hsep3(0, "",
		  Text("compute_"),
                  Copy(name),
		  Henc(0, Text("("), Text(")"),
		     Hsep1(0, ",",
			id_list_n(Eqn_Decl->the.decl.domain->the.dom.index,
				 G_dim)
                     )
                  )
	       );
	  (yyval.i)->prec = 10;}
    break;

  case 44:
#line 1048 "yacc.y"
    { item *name;
          Var_Decl = get_decl((yyvsp[(5) - (9)].n),alpha_node);
          name = Text("");
	  sprint_name(name->the.text.string,Var_Decl->the.decl.id);
	  (yyval.i) = Hsep3(0, "",
                  Text("compute_"),
                  Copy(name),
		  Henc(0, Text("("), Text(")"),
	             affine_list(Eqn_Decl->the.decl.domain->the.dom.index,
                                    (yyvsp[(8) - (9)].n),G_dim,1)
		  )
	       );
	  (yyval.i)->prec = 7;}
    break;

  case 45:
#line 1063 "yacc.y"
    {  (yyval.i) = (yyvsp[(1) - (1)].i); }
    break;

  case 46:
#line 1066 "yacc.y"
    {  (yyval.i) = (yyvsp[(3) - (6)].i); }
    break;

  case 47:
#line 1069 "yacc.y"
    {   (yyval.i) = Hsep2(0, " + ", check_prec((yyvsp[(5) - (8)].i),5), check_prec((yyvsp[(7) - (8)].i),5));
	    (yyval.i)->prec = 5;}
    break;

  case 48:
#line 1073 "yacc.y"
    {   (yyval.i) = Hsep2(0, " - ", check_prec((yyvsp[(5) - (8)].i),5), check_prec((yyvsp[(7) - (8)].i),5));
	    (yyval.i)->prec = 5;}
    break;

  case 49:
#line 1077 "yacc.y"
    {   (yyval.i) = Hsep2(0, " * ", check_prec((yyvsp[(5) - (8)].i),6), check_prec((yyvsp[(7) - (8)].i),6));
	    (yyval.i)->prec = 6;}
    break;

  case 50:
#line 1081 "yacc.y"
    {   (yyval.i) = Hsep2(0, " / ", check_prec((yyvsp[(5) - (8)].i),6), check_prec((yyvsp[(7) - (8)].i),6));
	    (yyval.i)->prec = 6;}
    break;

  case 51:
#line 1085 "yacc.y"
    {   (yyval.i) = Hsep2(0, " / ", check_prec((yyvsp[(5) - (8)].i),6), check_prec((yyvsp[(7) - (8)].i),6));
	    (yyval.i)->prec = 6;}
    break;

  case 52:
#line 1089 "yacc.y"
    {   (yyval.i) = Hsep2(0, " % ", check_prec((yyvsp[(5) - (8)].i),6), check_prec((yyvsp[(7) - (8)].i),6));
	    (yyval.i)->prec = 6;}
    break;

  case 53:
#line 1093 "yacc.y"
    {   (yyval.i) = Hsep2(0, " == ", check_prec((yyvsp[(5) - (8)].i),4), check_prec((yyvsp[(7) - (8)].i),4));
	    (yyval.i)->prec = 4;}
    break;

  case 54:
#line 1097 "yacc.y"
    {   (yyval.i) = Hsep2(0, " <= ", check_prec((yyvsp[(5) - (8)].i),4), check_prec((yyvsp[(7) - (8)].i),4));
	    (yyval.i)->prec = 4;}
    break;

  case 55:
#line 1101 "yacc.y"
    {   (yyval.i) = Hsep2(0, " < ", check_prec((yyvsp[(5) - (8)].i),4), check_prec((yyvsp[(7) - (8)].i),4));
	    (yyval.i)->prec = 4;}
    break;

  case 56:
#line 1105 "yacc.y"
    {   (yyval.i) = Hsep2(0, " > ", check_prec((yyvsp[(5) - (8)].i),4),check_prec((yyvsp[(7) - (8)].i),4));
	    (yyval.i)->prec = 4;}
    break;

  case 57:
#line 1109 "yacc.y"
    {   (yyval.i) = Hsep2(0, " >= ", check_prec((yyvsp[(5) - (8)].i),4), check_prec((yyvsp[(7) - (8)].i),4));
	    (yyval.i)->prec = 4;}
    break;

  case 58:
#line 1113 "yacc.y"
    {   (yyval.i) = Hsep2(0, " <> ", check_prec((yyvsp[(5) - (8)].i),4), check_prec((yyvsp[(7) - (8)].i),4));
	    (yyval.i)->prec = 4;}
    break;

  case 59:
#line 1117 "yacc.y"
    {   (yyval.i) = Hsep2(0, " || ", check_prec((yyvsp[(5) - (8)].i),1), check_prec((yyvsp[(7) - (8)].i),1));
	    (yyval.i)->prec = 1;}
    break;

  case 60:
#line 1121 "yacc.y"
    {   (yyval.i) = Hsep2(0, " != ", check_prec((yyvsp[(5) - (8)].i),2), check_prec((yyvsp[(7) - (8)].i),2));
	    (yyval.i)->prec = 2;}
    break;

  case 61:
#line 1125 "yacc.y"
    {   (yyval.i) = Hsep2(0, " && ", check_prec((yyvsp[(5) - (8)].i),3), check_prec((yyvsp[(7) - (8)].i),3));
	    (yyval.i)->prec = 3;}
    break;

  case 62:
#line 1129 "yacc.y"
    {   (yyval.i) = Henc(0, Text("min("), Text(")"),
                    Hsep2(0, ", ", check_prec((yyvsp[(5) - (8)].i),0), check_prec((yyvsp[(7) - (8)].i),0))
                 );
            (yyval.i)->prec = 8;}
    break;

  case 63:
#line 1135 "yacc.y"
    {   (yyval.i) = Henc(0, Text("max("), Text(")"),
                    Hsep2(0, ", ", check_prec((yyvsp[(5) - (8)].i),0), check_prec((yyvsp[(7) - (8)].i),0))
                 );
            (yyval.i)->prec = 8;}
    break;

  case 64:
#line 1141 "yacc.y"
    {   (yyval.i) = Hsep2(0, "", new_text("-"), check_prec((yyvsp[(5) - (6)].i),7));
	    (yyval.i)->prec = 7;}
    break;

  case 65:
#line 1145 "yacc.y"
    {   (yyval.i) = Henc(0, Text("sqrt("), Text(")"), check_prec((yyvsp[(5) - (6)].i),0));
	    (yyval.i)->prec = 0;}
    break;

  case 66:
#line 1149 "yacc.y"
    {   (yyval.i) = Hsep2(0,"",new_text("!"), check_prec((yyvsp[(5) - (6)].i),7));
	    (yyval.i)->prec = 7;}
    break;

  case 67:
#line 1153 "yacc.y"
    {   item *name;
            name = Text((yyvsp[(3) - (8)].n)->the.id.name);
            (yyval.i) = Hsep2(0, "", Copy(name),
                       Henc(0, Text("("), Text(")"), Hsep1(0,",",(yyvsp[(6) - (8)].i))));
        }
    break;

  case 68:
#line 1160 "yacc.y"
    {   (yyval.i) = Hsep5(4, " ",
		    Henc(0,Text("("),Text(")"), (yyvsp[(3) - (8)].i)),
		    Text("?"),
		    Henc(0,Text("("),Text(")"), (yyvsp[(5) - (8)].i)),
		    Text(":"),
		    Henc(0,Text("("),Text(")"), (yyvsp[(7) - (8)].i))
		 );
	    (yyval.i)->prec = 0;}
    break;

  case 69:
#line 1170 "yacc.y"
    {  (yyval.i) = Number((yyvsp[(3) - (4)].b));
           (yyval.i)->prec = 10;
        }
    break;

  case 70:
#line 1175 "yacc.y"
    {  (yyval.i) = Text("INFINITY");
           (yyval.i)->prec = 10;
        }
    break;

  case 71:
#line 1180 "yacc.y"
    {  (yyval.i) = Text("-INFINITY");
           (yyval.i)->prec = 10;
        }
    break;

  case 72:
#line 1185 "yacc.y"
    {  (yyval.i) = Number(1);
           (yyval.i)->prec = 10;
        }
    break;

  case 73:
#line 1190 "yacc.y"
    {  (yyval.i) = Number(0);
           (yyval.i)->prec = 10;
        }
    break;

  case 74:
#line 1195 "yacc.y"
    {  (yyval.i) = Hsep2(0,".",Number((yyvsp[(3) - (4)].n)->the.rconst.value),
                            Number((yyvsp[(3) - (4)].n)->the.rconst.fraction));
           (yyval.i)->prec = 10;
           free_node((yyvsp[(3) - (4)].n));
	}
    break;

  case 75:
#line 1200 "yacc.y"
    {V_Save=(yyvsp[(7) - (7)].b);}
    break;

  case 76:
#line 1202 "yacc.y"
    {  (yyval.i) = Henc(0, Text("("), Text(")"),
	             affine_list((yyvsp[(11) - (18)].n),(yyvsp[(15) - (18)].n),0,1)
		  );
	   free_node((yyvsp[(11) - (18)].n)); free_node((yyvsp[(15) - (18)].n));
	}
    break;

  case 77:
#line 1214 "yacc.y"
    {  ID_List_Save = (yyvsp[(6) - (7)].n); V_Save = (yyvsp[(3) - (7)].b)+2; }
    break;

  case 78:
#line 1216 "yacc.y"
    { (yyval.n) = new_node(dom);
	    (yyval.n)->the.dom.dim = (yyvsp[(3) - (13)].b);
	    (yyval.n)->the.dom.index = (yyvsp[(6) - (13)].n);
	    (yyval.n)->the.dom.pol = (yyvsp[(11) - (13)].n);
	}
    break;

  case 79:
#line 1223 "yacc.y"
    {  (yyval.n) = new_list((yyvsp[(1) - (1)].n)); }
    break;

  case 80:
#line 1226 "yacc.y"
    {  (yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n)); }
    break;

  case 81:
#line 1229 "yacc.y"
    {  (yyval.n) = new_list(0) ;}
    break;

  case 82:
#line 1232 "yacc.y"
    {  (yyval.n) = new_list((yyvsp[(1) - (1)].n)); }
    break;

  case 83:
#line 1235 "yacc.y"
    {  (yyval.n) = add_to_list((yyvsp[(1) - (3)].n), (yyvsp[(3) - (3)].n)); }
    break;

  case 84:
#line 1238 "yacc.y"
    {  (yyval.n) = new_list(0);}
    break;

  case 85:
#line 1242 "yacc.y"
    {  (yyval.n) = new_node(pol);
           (yyval.n)->the.pol.nb_constraints = (yyvsp[(3) - (18)].b);
           (yyval.n)->the.pol.nb_equations = (yyvsp[(7) - (18)].b);
           (yyval.n)->the.pol.constraints = (yyvsp[(12) - (18)].n);
	   if ((yyvsp[(3) - (18)].b) != (yyvsp[(12) - (18)].n)->the.list.count)
              yyerror("Polyhedron nb_constraints doesn't agree.");
           free_node((yyvsp[(16) - (18)].n));
        }
    break;

  case 86:
#line 1257 "yacc.y"
    { V_Save = (yyvsp[(5) - (9)].b); }
    break;

  case 87:
#line 1259 "yacc.y"
    { (yyval.n) = (yyvsp[(13) - (15)].n); free_node((yyvsp[(8) - (15)].n)); }
    break;

  case 88:
#line 1262 "yacc.y"
    {  I_Save = 0;
           (yyval.n) = new_node(vec);
           (yyval.n)->the.vec.dim = V_Save;
           if (I_Save >= V_Save) yyerror("Vector has too many elements");
           else
           {  (yyval.n)->the.vec.val = (int *)malloc(V_Save * sizeof(int));
              (yyval.n)->the.vec.val[0] = (yyvsp[(1) - (1)].b); I_Save++; }
        }
    break;

  case 89:
#line 1272 "yacc.y"
    {  (yyval.n) = (yyvsp[(1) - (3)].n);
           if (I_Save >= V_Save) yyerror("Vector has too many elements");
           else {  (yyval.n)->the.vec.val[I_Save] = (yyvsp[(3) - (3)].b); I_Save++; }
        }
    break;

  case 90:
#line 1278 "yacc.y"
    {  (yyval.n) = new_node(vec);
           (yyval.n)->the.vec.dim = 0;
           (yyval.n)->the.vec.val = (int *) 0; }
    break;

  case 91:
#line 1283 "yacc.y"
    {  (yyval.n) = new_list((yyvsp[(2) - (3)].n)); }
    break;

  case 92:
#line 1286 "yacc.y"
    {  (yyval.n) = add_to_list((yyvsp[(1) - (5)].n), (yyvsp[(4) - (5)].n)); }
    break;

  case 93:
#line 1289 "yacc.y"
    {  (yyval.n) = new_list(0);}
    break;


/* Line 1267 of yacc.c.  */
#line 3101 "y.tab.c"
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


#line 1291 "yacc.y"

#include "lex.c"

/* DEFINED PREVIOUSLY             */
/* extern  FILE    *yyin, *yyout; */
/* extern  int     lineNb;        */
/* extern  item    *alpha;        */
FILE *ref = 0;		/* cross reference file */

int main(argc, argv)
int argc;
char *argv[];
{ int status, arg, i;

  yydebug = 0;
  yyout = stdout;
  yyin = stdin;
  /* malloc_debug(2); */
  /* malloc_verify(); */

  arg=1;
  while (arg < argc)
  {  if (*argv[arg]=='-')
     switch (argv[arg][1])
     {  case 'i':       /* input */
          arg++;
          yyin = fopen(argv[arg],"r");
          if (!yyin)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg]);
             exit(1);
	  }
          break;
        case 'I':       /* input */
          arg++;
          yyin = fdopen(atoi(argv[arg]),"r");
          if (!yyin)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg]);
             exit(1);
          }
          break;
        case 'o':       /* output */
          arg++;
          yyout = fopen(argv[arg],"w");
          if (!yyin)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg]);
             exit(1);
          }
          break;
        case 'O':       /* output */
          arg++;
          yyout = fdopen(atoi(argv[arg]),"w");
          if (!yyin)
          {  fprintf(stderr, "? Could not open %s.\n", argv[arg]);
             exit(1);
          }
          break;
        case 'd':       /* debug */
          yydebug = 1;
          break;
        case 'g':       /* debug for the resulting program */
          begdbg[0]='\0';
          enddbg[0]='\0';
          break;
        case 'p':
          arg++; i=0;
          G_val = (int *)malloc(12*sizeof(int));
          while (arg<argc && isdigit(*argv[arg]))
          { G_val[i] = atoi(argv[arg]);
            arg++; i++;
          }
          G_dim = i;
          arg--;
          break;
        case 's':      /* program for signal */
          flag_forSignal = 1;
          break;
        case 'q':      /* program with no prompt */
          if(!flag_loopNestForInputVariables) {
            fprintf(stderr,
              "? the -q switch is not available with the -L switch\n");
            exit(1);
          }
          flag_quietProgram = 1;
          break;
        case 'L':
          if(flag_quietProgram) {
            fprintf(stderr,
               "? the -L switch is not available with the -q switch\n");
            exit(1);
          }
          flag_loopNestForInputVariables = 0;
          break;
        default:
          fprintf(stderr, "? unknown switch %s\n", argv[arg]);
     }
     arg++;
  }

  alpha_node = new_node(sys);
  lineNb = 1;
  status = yyparse();
  if (status==1) /* parsing failed */ exit(1);
  print_item(alpha);
  fputc('\n', yyout);
  return 0;
}

yywrap()
{ return(1); }

yyerror(s)
char *s;
{  fprintf(stderr,"? line %d: %s\n", lineNb, s);
}

