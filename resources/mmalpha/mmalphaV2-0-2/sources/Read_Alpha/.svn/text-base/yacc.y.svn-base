%{
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
%}
%token KW_of
%token KW_integer
%token KW_boolean
%token KW_real
%token KW_invar
%token KW_outvar
%token KW_locvar
%token KW_usevar
%token KW_var
%token KW_returns
%token KW_system
%token KW_let
%token KW_tel
%token KW_use
%token KW_case
%token KW_esac
%token KW_if
%token KW_then
%token KW_else
%token KW_or
%token KW_xor
%token KW_and
%token KW_not
%token KW_div
%token KW_mod
%token KW_sqrt
%token KW_abs
%token KW_convex
%token KW_arrow
%token KW_leq
%token KW_geq
%token KW_ne
%token KW_domain
%token KW_loop
%token KW_reduce
%token KW_max
%token KW_min
%token NUMBER
%token INFINITY
%token REAL
%token BOOLEAN
%token ID
%token XID

%union	{ node *n; int i;}
%type <n> Constraints Constraint
%type <n> Egalite Suite_Decroissante Suite_Croissante 
%type <n> Vexpressions Expressions Expression
%type <n> Facteur
%type <n> Exp Exp1 Exp2 Exp3 Exp4 Exp5 Exp6 Exp7
%type <n> Exp8 Exp9 Exp10 Alts ExpTerm
%type <n> Ids Vids /* Wids */ Xid Xids Type Tsimple 
%type <n> Domain Dom1 Dom2 Dom3 Dom4 DomTerm Affine_Function Add_Params
%type <n> System Decl LetBlock Equations Equation LHS Projection
%type <n> XID ID NUMBER INFINITY REAL BOOLEAN
%type <n> ContextDomain UseDomain ParamAssign ExpList
%type <i> CommutativeOp BinaryOp LinearOp RelOp

%start Command
%%
/*-----------------------------------------------------------------*/
/* Chapter: Commands                                               */
/*-----------------------------------------------------------------*/
Command : '<' Program			/* standard compilation */
    {	print_alpha(alpha, 0);
	fputc('\n',yyout);
	YYACCEPT;
    } ;
Command : '@' Program			/* compilation as a subroutine */
    {	YYACCEPT; } ;
Command : '=' '"' Exp1 '"'		/* -E switch compilation */
    {   print_alpha($3, 0);
	fputc('\n',yyout);
        /* all_old_nodes(); */
        YYACCEPT;
    } ;
Command : ':' '"' Domain '"'		/* -D switch compilation */
    {   print_alpha($3, 0);
	fputc('\n',yyout);
        /* all_old_nodes(); */
        YYACCEPT;
    } ;
Command : '.' '"' Affine_Function '"'	/* -M switch compilation */
    {   print_alpha($3, 0);
	fputc('\n',yyout);
        /* all_old_nodes(); */
        YYACCEPT;
    } ;
/*-----------------------------------------------------------------*/
/* Chapter: Program                                                */
/*-----------------------------------------------------------------*/
Program : System
    {	if (yynerrs==errs || keep_on_error)
	{   alpha = new_list($1);
	    keep_tree($1);
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
    } ;

Program : Program System
    {	if (yynerrs==errs || keep_on_error)
	{   add_to_list(alpha, $2);
            keep_tree($2);
	}
	else yywarning2(curr_sys->info.sys.name->info.id.name,
		      "had errors and was not output");
	all_old_nodes();
	id_param = 0;
	curr_sys = 0;
    } ;

/*-----------------------------------------------------------------*/
/* Chapter: System                                                 */
/*-----------------------------------------------------------------*/
System : SystemDecl
    {   curr_sys->info.sys.inputs->type = inpsop;  /* type the dictionaries */
        curr_sys->info.sys.outputs->type = outsop; /* for print_alpha */
        $$ = curr_sys;
	id_context=(node *)0;
    };

System : SystemDecl LocalBlock LetBlock
    {	curr_sys->info.sys.equations = $3;
	curr_sys->info.sys.inputs->type = inpsop;  /* type the dictionaries */
	curr_sys->info.sys.outputs->type = outsop; /* for print_alpha */
	curr_sys->info.sys.locals->type = locsop;  /* (makes comment labels)*/
	curr_sys->info.sys.equations->type = letop;
        $$ = curr_sys;
	id_context=(node *)0;
    } ;

SystemDecl : KW_system ID
    {	/* print a nice intro */
        if (yynerrs>errs) fputc('\n',stderr); /* print \n if there were errs */
        errs=yynerrs;
        fprintf(stderr,"[%s]", $2->info.id.name);

	/* make a new system */
        curr_sys = new_node(sys);
	curr_sys->info.sys.name = $2;
	curr_sys->info.sys.param = (node *)0;
	curr_sys->info.sys.equations = (node *)0;

	/* init the dictionaries */
	curr_sys->info.sys.inputs = new_list(0);
	curr_sys->info.sys.outputs = new_list(0);
	curr_sys->info.sys.locals = new_list(0);

	keep_tree(curr_sys);
    } 
    Param '(' Inputs ')' KW_returns '(' Outputs ')' ';' ;

Param : /* empty */
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
    };

Param : ':' Domain
    {	id_context = id_param = $2->info.pol.index;
        curr_sys->info.sys.param = $2;
        keep_node(id_param);
        keep_node($2);
    };

Inputs : /* empty */ ;
Inputs :  Inputs ';' Decl
    {	check_no_param($3->info.binop.l, id_param);
	declare_vars($3->info.binop.l, $3->info.binop.r,
                     inputvar, curr_sys->info.sys.inputs);
	all_old_nodes();
    } ;
Inputs :  Decl
    {	check_no_param($1->info.binop.l, id_param);
        declare_vars($1->info.binop.l, $1->info.binop.r,
                     inputvar, curr_sys->info.sys.inputs);
	all_old_nodes();
    };

Outputs : /* empty */ ;
Outputs : Outputs ';' Decl
    {	check_no_param($3->info.binop.l, id_param);
	check_no_variable($3->info.binop.l, curr_sys->info.sys.inputs);
	declare_vars($3->info.binop.l, $3->info.binop.r,
                     outputvar, curr_sys->info.sys.outputs);
	all_old_nodes();
    } ;
Outputs : Decl
    {	check_no_param($1->info.binop.l, id_param);
	check_no_variable($1->info.binop.l, curr_sys->info.sys.inputs);
	declare_vars($1->info.binop.l, $1->info.binop.r,
                     outputvar, curr_sys->info.sys.outputs);
	all_old_nodes();
    } ;

LocalBlock : /* empty */ ;
LocalBlock : KW_var Locals ';' ;

Locals : /* empty */ ;
Locals : Locals ';' Decl
    {	check_no_param($3->info.binop.l, id_param);
	check_no_variable($3->info.binop.l, curr_sys->info.sys.inputs);
	check_no_variable($3->info.binop.l, curr_sys->info.sys.outputs);
	declare_vars($3->info.binop.l, $3->info.binop.r,
		     localvar, curr_sys->info.sys.locals);
	all_old_nodes();
    } ;
Locals : Decl
    {	check_no_param($1->info.binop.l, id_param);
	check_no_variable($1->info.binop.l, curr_sys->info.sys.inputs);
	check_no_variable($1->info.binop.l, curr_sys->info.sys.outputs);
	declare_vars($1->info.binop.l, $1->info.binop.r,
		     localvar, curr_sys->info.sys.locals);
	all_old_nodes();
    } ;

/*-----------------------------------------------------------------*/
/* Chapter: Declarations                                           */
/*-----------------------------------------------------------------*/
Decl : Ids ':' Type
    {	$$ = new_node(defop);
	$$->info.binop.l = $1;		/* Ids */
	$$->info.binop.r = $3;		/* Type(domain, iotype, type) */
    } ;
Ids : Ids ',' ID
    {   $$ = add_to_list($1, $3);
    } ;
Ids : ID
    {   $$ = new_list($1);
    } ;

Type : Tsimple			/* scalar */
    {	node *x, *i;
        $$ = $1;
	$$->info.proto.domain                     = new_node(pol);
	$$->info.proto.domain->info.pol.ref_count = 1;
        $$->info.proto.domain->info.pol.invert    = 0;
        i = new_list(0);
        if (id_param) for (x=id_param->info.list.first; x; x=x->next)
        {  add_to_list(i, new_id(x->info.id.name));
        }
        $$->info.proto.domain->info.pol.index     = i;
        $$->info.proto.domain->info.pol.p         =
		Universe_Polyhedron(i->info.list.count);
	$$->info.proto.domain->info.pol.m	  = 0;
    } ;

Type : Tsimple  '[' ID ',' NUMBER ']' 	/* scalar of fixed precision */
    {	node *x, *i;
        $$ = $1;
	$$->info.proto.coding = $3;
	$$->info.proto.length = $5;
	$$->info.proto.domain                     = new_node(pol);
	$$->info.proto.domain->info.pol.ref_count = 1;
        $$->info.proto.domain->info.pol.invert    = 0;
        i = new_list(0);
        if (id_param) for (x=id_param->info.list.first; x; x=x->next)
        {  add_to_list(i, new_id(x->info.id.name));
        }
        $$->info.proto.domain->info.pol.index     = i;
        $$->info.proto.domain->info.pol.p         =
		Universe_Polyhedron(i->info.list.count);
	$$->info.proto.domain->info.pol.m	  = 0;
    } ;

Type : Domain  KW_of  Tsimple
    {	$$ = $3;
	$$->info.proto.domain = $1;
    } ;

/* fixed precision */
Type : Domain  KW_of  Tsimple  '[' ID ',' NUMBER ']'
    {	$$ = $3;
	$$->info.proto.domain = $1;
	$$->info.proto.coding = $5;
	$$->info.proto.length = $7;
    } ;


Type : Domain
    {	$$ = new_node(proto);
	$$->info.proto.type = domtype;
	$$->info.proto.domain = $1;
	$$->info.proto.coding = (node *)0;
	$$->info.proto.length = (node *)0;
    } ;

Tsimple : KW_integer  
    {	$$ = new_node(proto);
	$$->info.proto.type = inttype;
	$$->info.proto.domain = (node *)0;
	$$->info.proto.coding = (node *)0;
	$$->info.proto.length = (node *)0;
    } ;

Tsimple : KW_boolean  
    {   $$ = new_node(proto);
        $$->info.proto.type = booltype;
        $$->info.proto.domain = (node *)0;
	$$->info.proto.coding = (node *)0;
	$$->info.proto.length = (node *)0;
    } ;

Tsimple : KW_real  
    {   $$ = new_node(proto);
        $$->info.proto.type = realtype;
        $$->info.proto.domain = (node *)0;
	$$->info.proto.coding = (node *)0;
	$$->info.proto.length = (node *)0;
    } ;

/*-----------------------------------------------------------------*/
/* Chapter: Equations                                              */
/*-----------------------------------------------------------------*/
Semi :	';' | /*empty*/ ;

LetBlock : KW_let {$<n>$=id_context;} Equations KW_tel Semi
    {	$$ = $3;
	$$->type = letop;
	id_context = $<n>2;
    };
LetBlock : error KW_tel Semi
    {   $$ = new_list(0);
	$$->type = letop;
    };

Equations : Equation
    {	$$ = new_list($1);
    };
Equations : Equations Equation
    {	$$ = add_to_list($1, $2);
    };
Equations : Equations error ';'
    {   $$ = $1;
	yyerrok;
    };

ContextDomain : Domain
    {	$$ = id_context;	/* save old context */
	context_domain = $1;	/* intersected with old context_domain ?? */
	id_context = context_domain->info.pol.index;	/* est. new context */
    };

Equation : LetBlock
    {	$$ = $1;
    };
Equation : ContextDomain ':' { $<n>$ = context_domain; } Equation
    {	$$ = new_node(restrictop);
        $$->info.binop.l = $<n>3;
        $$->info.binop.r = $4;
	id_context = $1;		/* restore old context */
	context_domain = (node *) 0;
    };
Equation : ContextDomain KW_loop { $<n>$ = context_domain; } Equation
    {   $$ = new_node(loopop);
        $$->info.binop.l = $<n>3;
        $$->info.binop.r = $4;
	id_context = $1;		/* restore old context */
	context_domain = (node *) 0;
    };

/*-----------------------------------------------------------------*/
/* Section: Use Statements                                         */
/*-----------------------------------------------------------------*/
Equation : KW_use {$<n>$ = id_context;} UseDomain ID ParamAssign '(' ExpList ')'
           KW_returns '(' Ids ')' ';'
    {	$$ = new_node(use);
	$$->info.use.extdom =$3;
	$$->info.use.name =$4;
	$$->info.use.param =$5;
	$$->info.use.inputs =$7;
	$$->info.use.outputs =$11;
        /* TODO AT LINK TIME : lookup $4 (ID)
           -- check that it has ($6->info.mat.m->NbRows) PARAMETERS
           -- check number and types of inputs
           -- check number and types of outputs
        */
	id_context = $<n>2;	/* restore old context */
    };
UseDomain : /* Empty */
    {	$$ = curr_sys->info.sys.param;
	id_context = $$->info.pol.index;
    };
UseDomain : Domain
    {	$$ = $1;
	id_context = $$->info.pol.index;
    };
ParamAssign : /* Empty */
    {	node *exp_list;
	exp_list = new_list( (node*)0 )  ;
	$$ = convert_constraints(exp_list, id_context->info.list.count, 1);
	$$->info.mat.index = id_context;
	keep_node(id_context);
    } ;
ParamAssign : '[' Vexpressions ']'
    {	if (id_lookup(id_context, $2)==-1)
	{   yyerror(
	"Cannot use array notation for instance parameters in this context.");
	}
	$$ = convert_constraints($2, id_context->info.list.count, 1);
	$$->info.mat.index = id_context;
	keep_node(id_context);
    };
ParamAssign : '.' '(' Vids KW_arrow Vexpressions  ')'
    {	int i;
	node *x, *y;
    	node *exp_list;

	/* check that the last indices of id_context (new)  match $3 (old) */
	for (x = id_context->info.list.first,
	     y =         $3->info.list.first,
	     i = id_context->info.list.count;
	     i>0; x=x->next, i--)
	{   if (i<=$3->info.list.count) /* context incl. param */
	    {   if (strcmp(x->info.id.name, y->info.id.name))
		{   yywarning2(x->info.id.name,
			": index does not match use-context");
		}
		y=y->next;
	    }
	}

	exp_list = $5;
	/* don't add params to exp_list */

        id_lookup(id_context, exp_list);
	$$ = convert_constraints(exp_list, id_context->info.list.count, 1);
	$$->info.mat.index = id_context;
	keep_node(id_context);
        /* restore id_context at end of use statement */
    };

/*-----------------------------------------------------------------*/
/* Section: Equations                                              */
/*-----------------------------------------------------------------*/
Equation : LHS '=' Exp /* ';' */
    {	$$ = new_node(equateop);
	$$->info.binop.l = lhs;
	$$->info.binop.r = $3;
	id_context = $1;
    };

LHS : ID
    {	$$=id_context;
	if (curr_sys)
        {   node *n;
	    /* check ID */
            n        =search_list(curr_sys->info.sys.outputs, $1->info.id.name);
            if (!n) n=search_list(curr_sys->info.sys.locals,  $1->info.id.name);
            if (!n)
            {  yyerror2($1->info.id.name,"not declared as an output or local");
            }
            else
            {  if (n->info.id.type==domtype)
                  yyerror2($1->info.id.name, "has no type in its declaration");
            }

            if (search_list(curr_sys->info.sys.inputs, $1->info.id.name))
            {  yyerror2($1->info.id.name, ": input variable used as LHS");
            }
            else if (search_list(id_param, $1->info.id.name))
            {  yyerror2($1->info.id.name, ": parameter used as LHS");
            }
            else if (search_list(id_context, $1->info.id.name))
            {  yyerror2($1->info.id.name, ": index used as LHS");
            }
        }
        lhs = $1;
    } ;
LHS : ID '[' Vexpressions ']'
    {	node *exp_list, *x, *n;

	$$ = id_context;	/* save old context */
	exp_list = $3;
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{   add_to_list(exp_list, new_id(x->info.id.name));
	}

	/* check LHS variable */
        if (curr_sys)
        {   n        =search_list(curr_sys->info.sys.outputs, $1->info.id.name);
            if (!n) n=search_list(curr_sys->info.sys.locals,  $1->info.id.name);
            if (!n)
            {  yyerror2($1->info.id.name,"not declared as an output or local");
            }
            else
            {  if (n->info.id.type==domtype)
                  yyerror2($1->info.id.name, "has no type in its declaration");
               if (exp_list->info.list.count !=
                      n->info.id.domain->info.pol.index->info.list.count)
               {  yyerror2($1->info.id.name,
               ": dimension of LHS indices do not agree with declaration");
               }
            }

            if (search_list(curr_sys->info.sys.inputs, $1->info.id.name))
            {   yyerror2($1->info.id.name, ": input variable used as LHS");
            }
            else if (search_list(id_param, $1->info.id.name))
            {   yyerror2($1->info.id.name, ": parameter used as LHS");
            }
            else if (search_list(id_context, $1->info.id.name))
            {  yyerror2($1->info.id.name, ": index used as LHS");
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
		lhs->info.binop.l = $1;
		lhs->info.binop.r = m;
	    }
	    else
	    {	id_context = exp_list;  /* change the context */
		keep_node(id_context);
		/* update the indices of the declaration to be the same */
	        if (n) n->info.id.domain->info.pol.index = id_context;
		lhs = $1;
	    }
        }
        else
        {  id_context = exp_list;	/* establish the context */
	   keep_node(id_context);
	   if (n) n->info.id.domain->info.pol.index = id_context;
           if (id_lookup(0,exp_list)!=1)	/* exp_list is not trivial */
              yyerror("LHS has no context to support index expressions");
           lhs = $1;
        }
    };

ExpList : ExpList ',' Exp1
    {	$$ = add_to_list($1, $3);
    };
ExpList : Exp1
    {	$$ = new_list($1);
    };
ExpList : /*Empty*/
    {	$$ = new_list(0);
    };

/*-----------------------------------------------------------------*/
/* Chapter: Domain                                                 */
/*-----------------------------------------------------------------*/
Domain : Dom1  
    {	Polyhedron *p1, *p2;
        $$ = $1;
        if ($$->info.pol.invert!=0)
	{  p2 = $1->info.pol.p;
	   p1 = Universe_Polyhedron(p2->Dimension);
	   $$->info.pol.p = DomainDifference(p1, p2, MAXRAYS);
	   Domain_Free(p2);
	   Domain_Free(p1);
	   $$->info.pol.invert=0; 
        }
    } ;

Dom1 : Dom1  '|'  Dom2  
    {	$$ = new_node(pol);
	$$->info.pol.ref_count=0;
	$$->info.pol.index = $1->info.pol.index ? $1->info.pol.index
						: $3->info.pol.index;
        $$->info.pol.m=(node *)0; 
        switch (2*$1->info.pol.invert + $3->info.pol.invert)
	{   case 0:  /* A | B */
              if (($1->info.pol.m==0)&&($3->info.pol.m==0)) 
                {/* pol union pol */
                  $$->info.pol.invert=0;
                  $$->info.pol.p= DomainUnion($1->info.pol.p,
                                              $3->info.pol.p, MAXRAYS);
                old_pol_node($1);
                old_pol_node($3); 
                };
               if (($1->info.pol.m!=0) || ($3->info.pol.m!=0))
                {/* z-pol union z-pol */
                  node *n1;
                  /* print_alpha($1,1);
                     print_alpha($3,1);*/

                  $$ = $1;
                  /* $$ ->info.pol.p=Domain_Copy($1->info.pol.p);*/
                  for (n1=$$;n1->next;n1=n1->next)
                    {/* n1 will be the last zpol */}
                  n1->next=$3;
                  keep_node($1);
                  keep_node($3);
                };
              break;
	    case 1:  /* A | ~B  =  ~(~A & B) */
		$$->info.pol.invert=1;
		$$->info.pol.p= DomainDifference($3->info.pol.p,
			$1->info.pol.p, MAXRAYS);
                old_pol_node($1);
                old_pol_node($3); 
		break;
	    case 2:  /* ~A | B  = ~(A & ~B) */
		$$->info.pol.invert=0;
		$$->info.pol.p= DomainDifference($1->info.pol.p,
			$3->info.pol.p, MAXRAYS);
                old_pol_node($1);
                old_pol_node($3); 
		break;
	    case 3:  /* ~A | ~B  = ~(A&B) */
		$$->info.pol.invert=1;
		$$->info.pol.p= DomainIntersection($1->info.pol.p,
			$3->info.pol.p, MAXRAYS);
                old_pol_node($1);
                old_pol_node($3); 
		break;
	}
    } ;
Dom1 : Dom2  
    {	$$ = $1; } ;

Dom2 : Dom2  '&'  Dom3  
    {	$$ = new_node(pol);
	$$->info.pol.ref_count=0;
	$$->info.pol.index = $1->info.pol.index ? $1->info.pol.index
						: $3->info.pol.index;
        $$->info.pol.m=(node *)0; 
	switch (2*$1->info.pol.invert + $3->info.pol.invert)
	{   case 0:  /* A & B */
		$$->info.pol.invert=0;
		$$->info.pol.p= DomainIntersection($1->info.pol.p,
			$3->info.pol.p, MAXRAYS);
		break;
	    case 1:  /* A & ~B */
		$$->info.pol.invert=0;
		$$->info.pol.p= DomainDifference($1->info.pol.p,
			$3->info.pol.p, MAXRAYS);
		break;
	    case 2:  /* ~A & B */
		$$->info.pol.invert=0;
		$$->info.pol.p= DomainDifference($3->info.pol.p,
			$1->info.pol.p, MAXRAYS);
		break;
	    case 3:  /* ~A & ~B  = ~(A | B) */
		$$->info.pol.invert=1;
		$$->info.pol.p= DomainUnion($1->info.pol.p,
			$3->info.pol.p, MAXRAYS);
		break;
	}
	old_pol_node($1);
	old_pol_node($3);
    } ;
Dom2 : Dom3  
    {	$$ = $1; } ;

/* This rule is not compatable with rule exp1 without the kludge */
Dom3 : Dom4 '.' Affine_Function
    {   $$ = new_node(pol);
        $$->info.pol.ref_count = 0;
        $$->info.pol.index = $1->info.pol.index;
        $$->info.pol.invert = $1->info.pol.invert;
        $$->info.pol.p =
          DomainPreimage($1->info.pol.p, $3->info.mat.m, MAXRAYS);
	$$->info.pol.m = (node *)0;
        old_pol_node($1);
    } ;
Dom3 : Dom4 '.' KW_convex
    {   $$ = new_node(pol);
        $$->info.pol.ref_count = 0;
        $$->info.pol.index = $1->info.pol.index;
        $$->info.pol.invert = $1->info.pol.invert;
        $$->info.pol.p = DomainConvex($1->info.pol.p, MAXRAYS);
	$$->info.pol.m = (node *)0;
        old_pol_node($1);
    } ;
Dom3 : Dom4
    {	$$ = $1; } ;

Dom4 :  '~' Dom4
    {   if ($2->info.pol.ref_count==0)
	{   $$ = $2;
	    $$->info.pol.invert = !$$->info.pol.invert;
	}
	else
	{   $$ = new_node(pol);
	    $$->info.pol.ref_count=0;
	    $$->info.pol.invert = !$2->info.pol.invert;
	    $$->info.pol.index = $2->info.pol.index;
	    $$->info.pol.p = Domain_Copy($2->info.pol.p);
	    $$->info.pol.m = (node *) 0;
	}
    } ;
Dom4 : DomTerm
    {	$$ = $1; } ;

DomTerm : '{'  Expressions  '|'  Constraints  '}' 
    {	node *n, *m, *x;
	node *indices;
	node *exp_list, *con_list;

	/* build a list of indices by scanning the function and constraints */
	exp_list = $2;
	con_list = $4;
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

	$$ = new_node(pol);
	$$->info.pol.ref_count = 0;
	$$->info.pol.invert = 0;
        $$->info.pol.p = Constraints2Polyhedron(n->info.mat.m, MAXRAYS);

	Matrix_Free(n->info.mat.m);
	old_node(n);

	if (Matrix_is_Identity(m->info.mat.m))
	{  /* old fashioned polyhedron */
	   $$->info.pol.m = (node *) 0;
	   $$->info.pol.index = indices;  /* only if m is Id matrix */
	   Matrix_Free(m->info.mat.m);
	   old_node(m);
	}
	else
	{  /* z-polyhedron */
	   $$->info.pol.m = m;
	   $$->info.pol.index = new_list(0);	/* empty list */
	   m->info.mat.index = indices;
	   m->info.mat.ref_count=1;
	   keep_node(m);
	}
    } ;
DomTerm : '{' '|'  Constraints  '}' 
    {	node *n;
	node *indices;
	node *exp_list, *con_list;

	/* build a list of indices by scanning the function and constraints */
	exp_list = id_context;
	con_list = $3;
	indices = id_context;

	/* build the polyhedron */
	id_lookup(indices, con_list);
	/* last arg=2 means constraints */
	n = convert_constraints(con_list, indices->info.list.count, 2);

	$$ = new_node(pol);
	$$->info.pol.ref_count = 0;
	$$->info.pol.invert = 0;
        $$->info.pol.p = Constraints2Polyhedron(n->info.mat.m, MAXRAYS);

	Matrix_Free(n->info.mat.m);
	old_node(n);

	/* old fashioned polyhedron */
	$$->info.pol.m = (node *) 0;
	$$->info.pol.index = indices;
    } ;
DomTerm : '{'  Expressions  '|'  '}'
    {	node *m, *x;
	node *indices;
	node *exp_list;

	/* build a list of indices by scanning the function and constraints */
	exp_list = $2;
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

	$$ = new_node(pol);
	$$->info.pol.ref_count = 0;
	$$->info.pol.invert = 0;
	$$->info.pol.p = Universe_Polyhedron(exp_list->info.list.count);

	if (Matrix_is_Identity(m->info.mat.m))
	{  /* old fashioned polyhedron */
	   $$->info.pol.m = (node *) 0;
	   $$->info.pol.index = indices;  /* only if m is Id matrix */
	   Matrix_Free(m->info.mat.m);
	   old_node(m);
	}
	else
	{  /* z-polyhedron */
	   $$->info.pol.m = m;
	   $$->info.pol.index = new_list(0);	/* empty list */
	   m->info.mat.index = indices;
	   m->info.mat.ref_count=1;
	}
    } ;
DomTerm : '{' error '}'
    {   $$ = new_node(pol);
        $$->info.pol.ref_count = 0;
        $$->info.pol.index = new_list(0);
        $$->info.pol.invert = 0;
        $$->info.pol.p = Empty_Polyhedron(0);
	$$->info.pol.m = 0;
	yyerrok;
    } ;

DomTerm : '{'  Dom1  '}' 
    {	$$ = $2; } ;
DomTerm : KW_domain KW_of ID 			/* the domain of ID */
    {	char *id = $3->info.id.name;
        if (curr_sys)
        {  $$          = search_list(curr_sys->info.sys.inputs, id);
	   if (!$$) $$ = search_list(curr_sys->info.sys.outputs, id);
	   if (!$$) $$ = search_list(curr_sys->info.sys.locals, id);
        } else $$ = (node *)0;
	if (!$$)
	{   yyerror2(id, "is not defined");
	    YYERROR;
	}
	else $$ = $$->info.id.domain;
	if (!$$)
	{   yyerror2(id, "has no domain associated  with it");
	    YYERROR;
	}
	old_node($3);
    } ;

Affine_Function : '(' Vexpressions KW_arrow Vexpressions  ')'
    {	node *l_exp_list, *r_exp_list, *x, *indices, *ml;
	Matrix *m, *m2;

	/* build a list of indices by scanning the function and constraints */
	l_exp_list = $2;
	r_exp_list = $4;
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
	$$ = convert_constraints(r_exp_list, indices->info.list.count, 1);

	if (Matrix_is_Identity(ml->info.mat.m))
	{  $$->info.mat.index = indices;
	}
	else
	{  m = Matrix_Alloc(ml->info.mat.m->NbRows, ml->info.mat.m->NbColumns);
	   if (!Matrix_Inverse(ml->info.mat.m, m))
	   {  $$->info.mat.index = indices;
	      yyerror("Improper affine function. Left side not invertable.");
	   }
	   else
	   {  m2 = Matrix_Alloc($$->info.mat.m->NbRows, m->NbColumns);
              Matrix_Product($$->info.mat.m, m, m2);
              Matrix_Free($$->info.mat.m);
	      $$->info.mat.m = m2;
	      $$->info.mat.index = new_list(0);	/* empty list */
	   }
	   Matrix_Free(m);
	}
	Matrix_Free(ml->info.mat.m);
	old_node(ml);
    } ;

/*-----------------------------------------------------------------*/
/* Chapter: Constraints                                            */
/*-----------------------------------------------------------------*/
Constraints : Constraints  ';'  Constraint 
    {   $$ = merge_list($1, $3); } ;
Constraints : Constraint
    {   $$ = $1; } ;

Constraint : Egalite  
    {   $$ = convert_suite($1); } ;
Constraint : Suite_Decroissante  
    {   $$ = convert_suite($1); } ;
Constraint : Suite_Croissante
    {	$$ = convert_suite($1); } ;

Egalite : Egalite  '='  Expressions
    {	$$ = add_to_list($1, $3);
	$3->type = eqop;
    } ;
Egalite : Expressions '=' Expressions 
    {	$$ = add_to_list(new_list($1), $3);
	$3->type = eqop;
    } ;

Suite_Decroissante : Suite_Decroissante '>'  Expressions 
    {	$$ = add_to_list($1, $3);
	$3->type = gtop;
    } ;
Suite_Decroissante : Suite_Decroissante  KW_geq  Expressions
    {	$$ = add_to_list($1, $3);
	$3->type = geop;
    } ;
Suite_Decroissante : Suite_Decroissante '=' Expressions
    {	$$ = add_to_list($1, $3);
	$3->type = eqop;
    } ;
Suite_Decroissante : Suite_Decroissante '<' Expressions
    {   yyerror("cannot have '<' in a decreasing sequence");
	$$ = $1;
    } ;
Suite_Decroissante : Suite_Decroissante KW_leq Expressions
    {   yyerror("cannot have '<=' in a decreasing sequence");
	$$ = $1;
    } ;

Suite_Decroissante : Expressions '>' Expressions 
    {	$$ = add_to_list(new_list($1), $3);
	$3->type = gtop;
    } ;
Suite_Decroissante : Expressions KW_geq Expressions
    {	$$ = add_to_list(new_list($1), $3);
	$3->type = geop;
    } ;

Suite_Croissante : Suite_Croissante '<'  Expressions
    {	$$ = add_to_list($1, $3);
	$3->type = ltop;
    } ;
Suite_Croissante : Suite_Croissante  KW_leq  Expressions
    {	$$ = add_to_list($1, $3);
	$3->type = leop;
    } ;
Suite_Croissante : Suite_Croissante '=' Expressions
    {	$$ = add_to_list($1, $3);
	$3->type = eqop;
    } ;
Suite_Croissante : Suite_Croissante '>' Expressions
    {   yyerror("cannot have '>' in an increasing sequence");
	$$ = $1;
    } ;
Suite_Croissante : Suite_Croissante KW_geq Expressions
    {   yyerror("cannot have '>=' in an increasing sequence");
	$$ = $1;
    } ;

Suite_Croissante : Expressions '<' Expressions
    {	$$ = add_to_list(new_list($1), $3);
	$3->type = ltop;
    } ;
Suite_Croissante : Expressions KW_leq Expressions
    {	$$ = add_to_list(new_list($1), $3);
	$3->type = leop;
    } ;

/*-----------------------------------------------------------------*/
/* Chapter: Index Lists and Expressions                            */
/*-----------------------------------------------------------------*/
Xid : ID
    {   char *id;
	if (curr_sys)
	{   id = $1->info.id.name;
	    if (search_list(curr_sys->info.sys.inputs, id))
		yywarning3("Index", id, "is declared as an input.");
	    if (search_list(curr_sys->info.sys.outputs, id))
		yywarning3("Index", id, "is declared as an output.");
	    if (search_list(curr_sys->info.sys.locals, id))
		yywarning3("Index", id, "is declared as a local.");
	}
	$$=$1;
    };
Xid : XID
    {	$$=$1;
    };
/* This is a typed index variable */
Xid : Xid ':' ID
    {   char tmp[64];
        tmp[0] = '\0';
        strcat(tmp, $1->info.id.name);
        strcat(tmp, ":");
        strcat(tmp, $3->info.id.name);
        $$=new_id(tmp);
        old_node($1);
        old_node($3);
    };

Xids : Xids ',' Xid
    {   /* check_no_param($1, $3); */
	$$ = add_to_list($1, $3);
    } ;
Xids : Xid
    {   $$ = new_list($1);
    } ;

/* Uids create new context with no additions */
/* creates id_context (global) */
/* returns old context */
/* Uids : Xids  
    {   $$ = id_context;	/* return old context *
	id_context = $1;	/* establish new context *
    } ; */

/* Vids creates new context by adding system parameters */
/* creates id_context (global) */
/* returns old context */
Vids : /* empty */
    {	node *x;
	$$ = id_context;	/* return old context */
	id_context=new_list(0); /* establish new context */
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{   add_to_list(id_context, new_id(x->info.id.name));
	}
    } ;
Vids : Xids  
    {	node *x;
        $$ = id_context;	/* return old context */
	id_context = $1;	/* establish new context */
	if (id_param)
	{   check_no_param(id_context, id_param);
	    for (x=id_param->info.list.first; x; x=x->next)
	    {	add_to_list(id_context, new_id(x->info.id.name));
	    }
	}
    } ;

/* Wids creates a context by extending previous context */
/* creates id_context (global) */
/* returns old context */
/* Wids : */ /* empty */
/*  {	node *x; */
/*	$$ = id_context; */	/* return old context */
/*	id_context=new_list(0); */ /* establish new context */
/*	if ($$) */
/*        {   check_no_param(id_context, $$); */
/*	    for (x=$$->info.list.first; x; x=x->next) */
/*	    {   add_to_list(id_context, new_id(x->info.id.name)); */
/*	    } */
/*	} */
/*    } ; */
/* Wids : Xids  */
/*    {	node *x; */
/*        $$ = id_context; */	/* return old context */
/*	id_context = $1; */	/* establish new context */
/*	if ($$) */
/*	{ */  /* check_no_param(id_context, $$); */
/*	    for (x=$$->info.list.first; x; x=x->next) */
/*	    {	if (!search_list(id_context, x->info.id.name)) */
/*		    add_to_list(id_context, new_id(x->info.id.name)); */
/*	    } */
/*	} */
/*    } ; */

Vexpressions : /* empty */
    {	$$ = new_list(0);
    } ;
Vexpressions : Expressions  
    {   $$ = $1;
    } ;

Expressions : '(' Expressions ',' Expression ')'
    {	$$ = add_to_list($2, $4);
    } ;
Expressions : Expressions  ','  Expression
    {	$$ = add_to_list($1, $3);
    } ;
Expressions : Expression  
    {   $$ = new_list($1);
    } ;

Expression : Expression  LinearOp  Facteur  
    {	$$ = new_node($2);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    } ;
Expression : '-'  Facteur  
   {    if ($2->type==icons)
        {   $2->info.icons.value = -($2->info.icons.value);
            $$ = $2;
        }
        else
        {   $$ = new_node(negop);
            $$->info.unop.c = $2;
        }
    } ;
Expression : Facteur  
    {   $$ = $1; } ;

Facteur : NUMBER Xid
    {   $$ = new_node(mulop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $2;
    } ;
Facteur : Facteur '/' NUMBER
    {	$$ = new_node(divop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    };
Facteur : '('  Expression  ')'
    {	$$ = $2; } ;
Facteur : NUMBER
    {   $$ = $1; } ;
Facteur : Xid
    {	$$ = $1; } ;

LinearOp : '+'	{	$$ = addop; } ;
LinearOp : '-'	{	$$ = subop; } ;

/*-----------------------------------------------------------------*/
/* Chapter: Expressions                                            */
/*-----------------------------------------------------------------*/
Exp : Exp1 ';'
    {	$$ = $1; } ;
Exp : error ';'
    {   $$ = (node *)0;
        yyerrok;
    };

Exp1 : KW_if Exp1 KW_then Exp1 KW_else Exp1
    {   $$ = new_node(ifop);
        $$->info.triop.l = $2;
        $$->info.triop.c = $4;
        $$->info.triop.r = $6; } ;
Exp1 : Exp2
    {	$$ = $1; };

/* This rule makes domain ID's and exp ID's difficult to tell apart */
/* Commit on '{' */
/* Exp2 : '{' {yyunput('{');} Domain ':' Exp1 */
Exp2 : Domain ':' Exp1
    {	$$ = new_node(restrictop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3; } ;
Exp2 : Exp3
    {	$$ = $1; } ;

Exp3 : Exp3 KW_or Exp4
    {   $$ = new_node(orop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $3;
    } ;
Exp3 : Exp3 KW_xor Exp4
    {   $$ = new_node(xorop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $3;
    } ;
Exp3 : Exp4
    {	$$ = $1; };

Exp4 : Exp4 KW_and Exp5
    {   $$ = new_node(andop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $3;
    } ;
Exp4 : Exp4 KW_min Exp5
    {   $$ = new_node(minop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $3;
    } ;
Exp4 : Exp4 KW_max Exp5
    {   $$ = new_node(maxop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $3;
    } ;
Exp4 : Exp5
    {	$$ = $1; };

Exp5 : KW_not Exp5
    {   $$ = new_node(notop);
	$$->info.unop.c = $2;
    };

Exp5 : Exp6
    {	$$ = $1; };

Exp6 : Exp7 RelOp Exp7
    {	$$ = new_node($2);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    };
Exp6 : Exp7
    {   $$ = $1; };

RelOp : '='	{	$$ = eqop; };
RelOp : '>'	{	$$ = gtop; };
RelOp : KW_geq	{	$$ = geop; };
RelOp : '<'	{	$$ = ltop; };
RelOp : KW_leq	{	$$ = leop; };
RelOp : KW_ne	{	$$ = neop; };

Exp7 : Exp7  '+'  Exp8  
    {   if ((($1->type==xaddop)||($1->type==xsubop)) &&
	    (($3->type==xaddop)||($3->type==xsubop)))
	{   $$ = new_node(xaddop);
            $$->info.binop.l = $1;
            $$->info.binop.r = $3;
	    $$->info.binop.index = $1->info.binop.index;
	}
	else
        {   $$ = new_node(addop);
	    $$->info.binop.l = $1;
	    $$->info.binop.r = $3;
	}
    } ;
Exp7 : Exp7  '-'  Exp8
    {   if ((($1->type==xaddop)||($1->type==xsubop)) &&
	    (($3->type==xaddop)||($3->type==xsubop)))
	{   $$ = new_node(xsubop);
            $$->info.binop.l = $1;
            $$->info.binop.r = $3;
	    $$->info.binop.index = $1->info.binop.index;
	}
	else
        {   $$ = new_node(subop);
	    $$->info.binop.l = $1;
	    $$->info.binop.r = $3;
	}
    } ;
Exp7 : Exp8  
    {	$$ = $1; } ;

Exp8 : Exp8  '*'  Exp9  
    {	$$ = new_node(mulop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    } ;
Exp8 : Exp8  '/'  Exp9  
    {	$$ = new_node(divop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    } ;
Exp8 : Exp8  KW_div  Exp9  
    {	$$ = new_node(idivop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    } ;
Exp8 : Exp8  KW_mod  Exp9  
    {	$$ = new_node(modop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
    } ;
Exp8 : Exp9  
    {	$$ = $1; } ;

Exp9 : '-'  Exp10
   {	if (($2->type==xaddop)||($2->type==xsubop))
	{   $$ = new_node(xsubop);
	    $$->info.binop.l=0;
	    $$->info.binop.r=$2;
	    $$->info.binop.index = $2->info.binop.index;
	}
	else if ($2->type==icons)
	{   $2->info.icons.value = -($2->info.icons.value); 
	    $$ = $2;
	}
	else
	{   $$ = new_node(negop);
	    $$->info.unop.c = $2;
	}
    } ;
Exp9 : Exp10
    {	$$ = $1; };

Exp10 : Exp10 '.' Affine_Function     /* context and param already in affine */
    {	if ($1->type==affineop)
	{   Matrix *m1, *m2, *m3;
	    m1 = $1->info.binop.r->info.mat.m;
	    m2 = $3->info.mat.m;
	    /* check dimensions */
	    if (m1->NbColumns!=m2->NbRows)
	    {   yyerror("dimensions of affine functions do not agree");
		$$ = new_node(affineop);
		$$->info.binop.l = $1;
		$$->info.binop.r = $3;
	    }
	    else
	    {	m3 = Matrix_Alloc(m1->NbRows, m2->NbColumns); 
		Matrix_Product(m1, m2, m3);
		Matrix_Free(m1); $1->info.binop.r->info.mat.m = 0;
		Matrix_Free(m2); $3->info.mat.m = 0;
		$1->info.binop.r->info.mat.m = m3;

		/* fix up the indices */
		$1->info.binop.r->info.mat.index = $3->info.mat.index;
		$3->info.mat.index=(node *)0;
		$$ = $1;
	    }
	}
	else if (($1->type==xaddop)||($1->type==xsubop))
	{   $$ = new_node(affineop);
	    /* is the xaddop just an integer const ? */
	    if (!$1->info.binop.r && $1->info.binop.l->type==icons)
		$$->info.binop.l = $1->info.binop.l;
	    else
		$$->info.binop.l = $1;
	    /* create new matrix */
	    if ($3->info.mat.index->info.list.count>0)
	    {   node *exp_list;
	        exp_list = new_list(0);	/* constants are dim 0 */
                id_lookup($3->info.mat.index, exp_list);
	        $$->info.binop.r = convert_constraints(exp_list,
                                   $3->info.mat.index->info.list.count, 1);
	        $$->info.binop.r->info.mat.index = $3->info.mat.index;
	        old_node(exp_list);
	        /* deallocate old unused $3 */
	        Matrix_Free($3->info.mat.m);
	        $3->info.mat.index = (node *)0;
	        old_node($3);
	    }
	    else $$->info.binop.r = $3;
	}
	else
	{   $$ = new_node(affineop);
	    $$->info.binop.l = $1;
	    $$->info.binop.r = $3;
	}
    };
Exp10 : ExpTerm '[' Vexpressions ']'
    {   node *exp_list, *x, *M2;

        /* if (!id_context) yyerror("[...] missing on LHS of this equation"); */

	/* add the parameters to the exp list */
        exp_list = $3;
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

	if ($1->type==affineop)
        {   Matrix *m1, *m2, *m3;
	    /* combine affines */
	    m1 = $1->info.binop.r->info.mat.m;
 	    m2 = M2->info.mat.m;
	    /* check dimensions */
            if (m1->NbColumns!=m2->NbRows)
            {   yyerror("dimensions of affine functions do not agree");
		$$ = new_node(affineop);
		$$->info.binop.l = $1;
		$$->info.binop.r = M2;
            }
            else
            {	m3 = Matrix_Alloc(m1->NbRows, m2->NbColumns);
		Matrix_Product(m1, m2, m3);
		Matrix_Free(m1); $1->info.binop.r->info.mat.m = 0;
		Matrix_Free(m2); M2->info.mat.m = 0;
		$1->info.binop.r->info.mat.m = m3;

		/* fix up the indices */
		$1->info.binop.r->info.mat.index = M2->info.mat.index;
		M2->info.mat.index=(node *)0;
		$$ = $1;
            }
        }
	else if (($1->type==xaddop)||($1->type==xsubop))
	{   $$ = new_node(affineop);
	    /* is the xaddop just an integer const ? */
	    if (!$1->info.binop.r && $1->info.binop.l->type==icons)
		$$->info.binop.l = $1->info.binop.l;
	    else
		$$->info.binop.l = $1;
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
	        $$->info.binop.r = M2;
	    }
	    else $$->info.binop.r = M2;
	}
        else
        {   $$ = new_node(affineop);
	    $$->info.binop.l = $1;
	    $$->info.binop.r = M2;
	}
    };

Exp10 : ExpTerm
    {	$$ = $1; };

/* similar to Affine_function, except it establishes context */
Projection : '(' Vids KW_arrow Vexpressions  ')'
    {   node *exp_list, *x;

        exp_list = $4;
	if (id_param) for (x=id_param->info.list.first; x; x=x->next)
	{  add_to_list(exp_list, new_id(x->info.id.name));
	}

	id_lookup(id_context, exp_list);
	$$ = convert_constraints(exp_list,id_context->info.list.count, 1);
	$$->info.mat.index = id_context;
	keep_node(id_context);
	/* don't restore context until after reduce */
    } ;

ExpTerm : ID
    {   char *id = $1->info.id.name;
        if (curr_sys)
        {   if (search_list(curr_sys->info.sys.inputs, id))
                $$->type = var;
            else if (search_list(curr_sys->info.sys.outputs, id))
                $$->type = var;
            else if (search_list(curr_sys->info.sys.locals, id))
                $$->type = var;
            else if (search_list(id_param, id))
                $$->type = parameter;
            else yyerror2(id, "is not defined");
        }
        else $$->type = var;
     	$$ = $1;
    } ;
ExpTerm : KW_reduce '(' { $<n>$ = id_context; id_context = (node *) 0; }
                        CommutativeOp ',' Projection ',' Exp1 ')'
    {	$$ = new_node(reduce);
	$$->info.reduce.op = $4;
	$$->info.reduce.proj = $6;
	$$->info.reduce.exp = $8;
	id_context = $<n>3;
    } ;
ExpTerm : ID '(' ExpList  ')'
    {	$$ = new_node(callop);
	$$->info.binop.l = $1;
	$$->info.binop.r = $3;
        /* TODO
           lookup $1 (ID) check that
	      - no parameters
	      - any number of scalar inputs
	      - a single scalar output
           format as a use ???
        */
    } ;
ExpTerm : BinaryOp '(' Exp1 ',' Exp2 ')'
    {	$$ = new_node($1);
	$$->info.binop.l = $3;
	$$->info.binop.r = $5;
    } ;
ExpTerm : KW_sqrt '(' Exp1 ')'
    {	$$ = new_node(sqrtop);
	$$->info.unop.c = $3;
    } ;
ExpTerm : KW_abs '(' Exp1 ')'
    {	$$ = new_node(absop);
	$$->info.unop.c = $3;
    } ;

Add_Params : /* empty */
    {   node *exp_list;

	/* the programmer is reponsible for going (id_context->id_param)
	   this simply goes (id_param->) */
	/* the overall effect is (id_context->) */
        exp_list = new_list(0);
        id_lookup(id_param, exp_list);
        $$ = convert_constraints(exp_list,id_param->info.list.count, 1);
        $$->info.mat.index = id_param;
	old_node(exp_list);
    } ;

/* make these three index operations, then combine later */
ExpTerm : NUMBER
    {	$$ = new_node(xaddop);
        $$->info.binop.l = $1;
        $$->info.binop.r = 0;
	$$->info.binop.index = id_context;
	keep_node(id_context);
    } ;
ExpTerm : NUMBER XID
    {   $$ = new_node(xaddop);
        $$->info.binop.l = new_node(mulop);
	$$->info.binop.l->info.binop.l=$1;
	$$->info.binop.l->info.binop.r=$2;
        $$->info.binop.r = 0;
	$$->info.binop.index = id_context;
	keep_node(id_context);
    } ;
ExpTerm : XID
    {   $$ = new_node(xaddop);
        $$->info.binop.l = $1;
        $$->info.binop.r = 0;
	$$->info.binop.index = id_context;
	keep_node(id_context);
    } ;
ExpTerm : INFINITY Add_Params
    {   $$ = new_node(affineop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $2;
    } ;
ExpTerm : REAL Add_Params
    {   $$ = new_node(affineop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $2;
    } ;
ExpTerm : BOOLEAN Add_Params
    {   $$ = new_node(affineop);
        $$->info.binop.l = $1;
        $$->info.binop.r = $2;
    } ;
ExpTerm : '('  Exp1  ')'
    {	$$ = $2; } ;
ExpTerm : KW_case Alts KW_esac
    {	$$ = new_node(caseop);
	$$->info.unop.c = $2;
    } ;

Alts : Exp
    {   $$ = new_list($1); };
Alts : Alts Exp
    {	$$ = add_to_list($1, $2); };

CommutativeOp : '+'	{	$$ = addop; } ;
CommutativeOp : '*'	{	$$ = mulop; } ;
CommutativeOp : KW_and	{	$$ = andop; } ;
CommutativeOp : KW_or	{	$$ = orop; } ;
CommutativeOp : KW_xor	{	$$ = xorop; } ;
CommutativeOp : KW_min	{	$$ = minop; } ;
CommutativeOp : KW_max	{	$$ = maxop; } ;

BinaryOp : CommutativeOp {	$$ = $1; } ;
BinaryOp : KW_div	{	$$ = divop; } ;
BinaryOp : KW_mod	{	$$ = modop; } ;
/* causes a shift-reduce error:
   -.(Exp1)  shift
   BinaryOp.(  reduce
BinaryOp : '-'          {       $$ = subop; } ;
*/

%%
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
