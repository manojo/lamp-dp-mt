 /*  file: $MMALPHA/sources/Write_Alpha/yacc.y
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
%{
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

%}
%token KW_system
%token KW_decl
%token KW_scalar
%token KW_integer
%token KW_boolean
%token KW_real
%token KW_equation
%token KW_case
%token KW_restrict
%token KW_var
%token KW_affine
%token KW_const
%token KW_index
%token KW_binop
%token KW_unop
%token KW_if
%token KW_add
%token KW_sub
%token KW_mul
%token KW_div
%token KW_idiv
%token KW_mod
%token KW_eq
%token KW_le
%token KW_lt
%token KW_gt
%token KW_ge
%token KW_ne
%token KW_or
%token KW_and
%token KW_neg
%token KW_not
%token KW_xor
%token KW_min
%token KW_max
%token KW_sqrt
%token KW_abs
%token KW_domain
%token KW_pol
%token KW_zpol
%token KW_matrix
%token KW_notype
%token KW_invar
%token KW_outvar
%token KW_locvar
%token KW_usevar
%token KW_reduce
%token KW_depend
%token KW_dependence
%token KW_dtable
%token KW_let
%token KW_loop
%token KW_call
%token KW_use
/*-----------------------------------------------------------------*/
/* I. General Specifications                                       */
/*-----------------------------------------------------------------*/
%token NUMBER
%token REAL
%token BOOLEAN
%token ID

%union	{ node *n; datatype t; item *i; int b; }
%type <i> System System_List
%type <i> System_Head System_Body
%type <i> Parameter IO_Decl Local_Decl Decl_List Decl
%type <i> Let_Equations Equation_List Equation Exp_List Exp Casop Const
%type <i> Dep_List Dep DepVar
%type <i> Domain Dom_Union ZPol_List ZPol Pol_List Pol
%type <i> Matrix
%type <n> Number_List_List Number_List ID_List Dom_ID_List
%type <n> NUMBER REAL BOOLEAN ID
%type <i> Data_Type Type ID_item ID_item_List Number_item Number_item_List
%type <b> Disable_array_notation

%start Top

%%
ID_item : ID
	{ $$ = new_item(text);
          sprint_name($$->the.text.string,$1);
	  $$->prec = 0;
          free_node($1);
        };

ID_item_List : ID_item
        {  $$ = Pos($1,1); }

|       ID_item_List ',' ID_item
        {  int p;
           p = length_ilist($1) + 1;
           $$ = add_to_ilist($1, Pos($3, p) ); }

|       /* empty */
        {  $$ = (item *)0;};

Number_item : NUMBER
	{ $$ = new_item(number);
          $$->the.number.value=$1->the.iconst.value;
	  $$->prec = 0;
          free_node($1);
        };

Number_item_List : Number_item
        {  $$ = $1; }

|       Number_item_List ',' Number_item
        {  $$ = add_to_ilist($1, $3 ); }

|       /* empty */
        {  $$ = (item *)0;};

/*-----------------------------------------------------------------*/
/* II. Function Specifications                                     */
/*-----------------------------------------------------------------*/
 Top:     '{' System_List '}'
	  { alpha = package(Vsep(0, OW_sepSystems, $2)); YYACCEPT; }
	| System
	  { alpha = package($1); YYACCEPT; }
        | Exp
          { alpha = package($1); YYACCEPT; }
        | KW_dtable '[' '{' Dep_List '}' ']'
          { alpha = package(Vsep(0,"",$4)); YYACCEPT; }
        | KW_dtable '[' '{' Decl_List '}' ',' '{' Dep_List '}' ']'
          { alpha = package(Vsep2(0,"\n",
				Venc(2, Text(OW_var), 0,
				    Vlis(0,";",$4)
				),
				Venc(2, Text("Dependences"), 0,
				    Vsep(0,"",$8)
				)
			    ) );
	    YYACCEPT; }
        | Domain
          { alpha = package($1); YYACCEPT; }
        | Matrix
          { alpha = package($1); YYACCEPT; }
        | Equation
          { alpha = package($1); YYACCEPT; }
        | IO_Decl
          { alpha = package($1); YYACCEPT; }
        | Decl  
          { alpha = package($1); YYACCEPT; };

System_List : System
        {  if      (thesystem==0) $$ = Pos($1,1);
	   else if (thesystem==1) $$ = $1;
           else {  thesystem--;  $$ = (item *) 0; }
        }

|	System_List ',' System
        {  int p;
           if (thesystem==0)
           {  p = length_ilist($1) + 1;
              $$ = add_to_ilist($1, Pos($3, p) );
           }
           else if (thesystem==1 && $1==(item *)0 ) $$ = $3;
           else if (thesystem==1 && $1!=(item *)0 ) $$ = $1;
           else {  thesystem--; $$ = (item *) 0; }
        };


System :  KW_system  '[' System_Head ',' System_Body ']'
	{ $$ = Vsep2(0, OW_sepHeadAndBody, $3, $5);
          G_dim=0;
          Dictionary = (entry *) 0;
        };

System_Head : ID_item ',' Parameter ',' IO_Decl ',' IO_Decl
        { int sys_name_len = strlen($1->the.text.string);
          item* tmpResult;

          if (sys_name_len<7) sys_name_len = 7;

          if(latexLayout == 1)
          { if (G_dim != 0)
            { tmpResult = Vsep2(sys_name_len+1, "\\\\",
                        Hsep4(0,"", Pos($1,1), Text("~:&"),
                              Align(0), Henc(0, Text("\\multicolumn{3}{l}{~"),
                                             Text("}"), Pos($3,2))),
                        Pos($5,3)
                        );
            }
            else
            { tmpResult = Hsep4(sys_name_len+1,"",
                        Pos($1,1), Text(" "),
                        Align(0), Pos($5,3));
            }
            $$ = Venc(0, Text("\\begin{tabular}{rrcl}"),
                             Text("\\end{tabular}"),
                             Henc(7, Text(OW_system), Text(";"),
                             Vsep2(0, "",
                                   Hsep2(0, "", tmpResult, Text("\\\\")),
                                   Hsep3(sys_name_len+1,"",
                                   Text(OW_returns),Align(0),Pos($7,4))
                                   )
                          ));
          }
          else {
          if (G_dim != 0)
            $$ = Henc(7, Text("system "), Text(";"),
                   Vsep2(0, "",
                     Vsep2(sys_name_len+1, "",
                       Hsep4(0,"", Pos($1,1), Text(" :"), Align(0), Pos($3,2)),
		       Pos($5,3)
                     ),
                     Hsep3(sys_name_len+1,"",
                       Text("returns"), Align(0), Pos($7,4)
                     )
                   )
                 );
          else
            $$ = Henc(7, Text("system "), Text(";"),
                   Vsep2(0, "",
                     Hsep3(sys_name_len+1,"",
                       Pos($1,1), Align(0), Pos($5,3)),
                     Hsep3(sys_name_len+1,"",
                       Text("returns"), Align(0), Pos($7,4))
                   )
                 );
        }
	};

IO_Decl : '{' Decl_List '}'
	{ $$ = Henc(1, Text("("), Text(")"),
	              Vsep(0, OW_sepDecls, $2)
               );
	}
|	'{' '}'
	{ $$ = Henc(1, Text("("), Text(")"), Text(" "));};

Parameter : Domain 
        { G_dim = D_Save;
	  $$ = $1;
	};

System_Body : Local_Decl ',' Enable_array_notation Let_Equations
	Disable_array_notation
        { $$ = $1 ? Vlis2(0, OW_sepDeclAndEqns,
                             Pos($1, 5), Pos($4, 6)) : Pos($4, 6); };

System_Body : Local_Decl ','
        { $$ = $1 ? Pos($1, 5) : 0; };

Local_Decl : '{' Decl_List '}'
	{ if (latexLayout == 1)
	  { $$ = Venc(2, Text("\\begin{tabular}{lrcl}"), Text("\\end{tabular}"),
                      Vsep2(2, "", Hsep2(0, "", Text(OW_var), Text("&\\\\")),
                                   Vlis(0, ";\\\\", $2)
                           )
                     );
	  }
          else
          { $$ = Venc(2, Text(OW_var), 0,
		         Vlis(0, ";", $2)
		     );
	  }
	}
|	'{' '}'
	{ $$ = (item *)0; };

Let_Equations: '{' Equation_List '}'
        { $$ = Venc(2, Text(OW_let), Text(OW_tel), itemizeEquationList($2)); }
|	KW_let '[' '{' Equation_List '}' ']'
        { $$ = Venc(2, Text(OW_let), Text(OW_tel), itemizeEquationList($4)); }
|	KW_let '[' Equation_List ']'
        { $$ = Venc(2, Text(OW_let), Text(OW_tel), itemizeEquationList($3)); }
|	'{' '}'
	{ $$ = Venc(2, Text(OW_let), Text(OW_tel),
		itemizeEquationList(Text("--empty"))); }
|	KW_let '[' '{' '}' ']'
	{ $$ = Venc(2, Text(OW_let), Text(OW_tel),
		itemizeEquationList(Text("--empty"))); }
|	KW_let '[' ']'
	{ $$ = Venc(2, Text(OW_let), Text(OW_tel),
		itemizeEquationList(Text("--empty"))); }
;

Decl :  KW_decl '[' ID_item ',' Type ']'
	{  insertIDdecl($3, ID_List_Save);
           ID_List_Save = (node *)0;
	   $$ = (latexLayout == 1) ?
	     Hsep2(0, "", Text("&"), Hsep2(0, "&~:&~", Pos($3,1), $5))
	     : Hsep2(0, " : ", Pos($3, 1), $5);
	}

|	KW_decl '[' ID_item ',' KW_notype ',' Domain ']'
	{  if (annote_flag)
	     $$ = (latexLayout == 1) ?
             Hsep2(0, "", Text("&"), Hsep2(0, "&~:&~", Pos($3,1), Pos($7,3)))
             : Hsep2(0, " : ", Pos($3, 1), Pos($7, 3));
	   else $$ = (item *)0;
	}
|       KW_decl '[' ID_item ',' ID_item ',' Data_Type ',' Domain ']'
        {  /* new decl */
           $$ = Hsep2(0, " : ",
              Hsep2(0, ".", $3, $5),
              Hsep2(0," of ",$9, $7)
           );
        }
;
 
Decl_List : Decl
	{  $$ = Pos($1,1); }

|	Decl_List ',' Decl
	{  int p;
           p = length_ilist($1) + 1;
           $$ = add_to_ilist($1, Pos($3, p) );
	}
;

Type :  Data_Type ',' KW_scalar /* version 2 ONLY */
	{  $$ = $1; }

|	Data_Type ',' Domain 
	{  $$ = D_Save==G_dim ? $1 : Hsep2(0, OW_of, Pos($3,3), Pos($1,2)); };

Data_Type : KW_integer '[' ID_item ',' NUMBER ']' 
        {  $$ =  Hsep2(0, "",
                       Text(OW_integer),
                       Henc(0, Text("["), Text("]"),
                            Hsep2(0, ",", $3,
                                  Number($5->the.iconst.value))
                            )
                       );
         }
|	KW_boolean  '[' ID_item ',' NUMBER ']' 
	{  $$ =  Hsep2(0, "",
                       Text(OW_boolean),
                       Henc(0, Text("["), Text("]"),
                            Hsep2(0, ",", $3,
                                  Number($5->the.iconst.value))
                            )
                       ); }
|	KW_real  '[' ID_item ',' NUMBER ']' 
	{  $$ =$$ =  Hsep2(0, "",
                       Text(OW_real),
                       Henc(0, Text("["), Text("]"),
                            Hsep2(0, ",", $3,
                                  Number($5->the.iconst.value))
                            )
                           ); };


Data_Type : KW_integer
	{  $$ = Text(OW_integer); }
|	KW_boolean
	{  $$ = Text(OW_boolean); }
|	KW_real
	{  $$ = Text(OW_real); }
|	KW_invar
	{  $$ = Text(OW_invar); }
|	KW_outvar
	{  $$ = Text(OW_outvar); }
|	KW_locvar
	{  $$ = Text(OW_locvar); }
|	KW_usevar
	{  $$ = Text(OW_usevar); };

/*-----------------------------------------------------------------*/
/* I. Equation and Expression Specifications                     */
/*-----------------------------------------------------------------*/

Equation_List : Equation
	{  $$ = Pos($1,1); }

|	Equation_List ',' Equation
	{  int p;
           p  = length_ilist($1)+1;
           $$ = add_to_ilist($1, Pos($3, p) ); };

 Equation : KW_equation '[' ID_item
	{   $<n>$=ID_context;
	    ID_context = lookupIDdecl($3);
	}
	',' Exp ']'
	{   item *header;
	    if (array_mode && eflag && ID_context)
	    { if (lengthof(ID_context) == 0)
		header = Hsep2(0,"", Pos($3,1), Text(" = "));
	      else 
		header = Hsep3(0,"",
			    Pos($3,1),
			    Henc(0, Text("["), Text("]"),
			       Hsep(0, ",", id_list2(ID_context,G_dim))
                            ),
			    Text(" = ")
                         ); 
	      $$ = Henc(4, header, Text(";"), Pos($6,2));
	    }
	    else 
	    {  $$ = Henc(4,
                    Hsep2(0," ", Pos($3,1), Text("= ")),
                    Text(";"),
                    Pos($6,2)
                );
	    }
	    ID_context=$<n>4;
	    ID_List_Save = (node *)0;
	    $$->prec = 0;
	}
|	KW_equation '[' KW_affine '[' ID_item ',' Matrix ']' ',' Exp ']'
	{   item *header;
	    header = Hsep3(0,"",
			    Pos($5,1),
			    $7,
			    Text(" = ")
                         ); 
	    $$ = Henc(4, header, Text(";"), Pos($10,2));
	    ID_List_Save = (node *)0;
	    $$->prec = 0;
	}
|       KW_restrict '[' Domain
	{   $<n>$=ID_context;
        ID_context=ID_List_Save;
	}
	',' Equation ']'
        {   $$ = Hsep2(2," : ", Pos(check_prec($3,2),1), Pos($6,2));
	    ID_context=$<n>4;
	    ID_List_Save = (node *)0;
	    $$->prec = 2;
	}
|       KW_loop '['
	Domain
	{   $<n>$=ID_context;
	    ID_context=ID_List_Save;
	}
	',' Equation ']'
        {   $$ = Hsep2(2," :: ", Pos(check_prec($3,2),1), Pos($6,2));
	    ID_context=$<n>4;
	    ID_List_Save = (node *)0;
	    $$->prec = 2;
	}
|	Let_Equations
        {   $$ = $1;
	}
|	KW_use '[' ID_item ',' Domain
	{   $<n>$ = ID_context;
	    ID_context = ID_List_Save;
	}
	',' {use_flag=1;} Matrix {use_flag=0;}
	',' Disable_array_notation '{' Exp_List '}' {eflag = $<b>12;} ','
        '{' ID_item_List '}' ']'
	{   $$ =  Hsep2(4, " ",
		  Hsep4(2, " ",
		    Text(OW_use),
		    ID_context->the.list.count>G_dim ? Pos($5, 2) : Text(""),
		    Hsep2(0, (!array_mode ? "." : ""),Pos($3, 1), Pos($9, 3)),
		    Pos(Henc(2, Text("("), Text(")"), Hsep(0, ", ", $14)),4)
		  ),
		  Hsep3(2, " ",
                    Text(OW_returns),
		    Pos(Henc(2, Text("("), Text(")"), Hsep(0, ", ", $19)),5),
		    Text(";")
		  )
		);
	    $$->prec = 2;
	    ID_context = $<n>6;
	};

Dep_List : Dep 
	{  $$ = Pos($1,1); }

|	Dep_List ',' Dep 
	{  int p;
           p  = length_ilist($1) + 1;
           $$ = add_to_ilist($1, Pos($3,p)); }

|	/* empty*/
	{  $$ = (item *)0;};

DepVar	: ID_item ',' ID_item ',' '{' Number_item_List '}' ',' Matrix
	{  $$ = Hsep3(0,"",
                  (*($1->the.text.string)? Hsep3(0,"",$1,Text("."),$3) : $3),
                  Henc(0,Text("{"),Text("}"),
                      Hsep(0,",",$6)
                  ),
                  $9
                );
	};

Dep :	 KW_depend '[' Domain ',' ID_item ',' ID_item ',' {dpflag=1;} Matrix 
                   {dpflag=0;} ',' Domain ']'
        { $$ = Hsep2(0," : ",
                  $3,
                  Hsep2(0, OW_rightarrow,
                     Hsep2(0,"",$5,DepMatIDS),
		     Hsep2(0,"",$7,$10)
		  )
	       );
	}
/*      1              2  3      4  5       6   7          8       9  10    11*/
|	KW_dependence '[' KW_gt ',' Domain ',' {dpflag=1;} DepVar ',' DepVar ']'
        { dpflag=0;
	  $$ = Hsep2(0," : ",
                  $5,
                  Hsep2(0, OW_rightarrow, $8, $10)
               );
        }
|	KW_dependence '[' KW_ge ',' Domain ',' {dpflag=1;} DepVar ',' DepVar ']'
        { dpflag=0;
	  $$ = Hsep2(0," : ",
                  $5,
                  Hsep2(0, " >= ", $8, $10)
               );
        }
|	KW_dependence '[' KW_eq ',' Domain ',' {dpflag=1;} DepVar ',' DepVar ']'
        { dpflag=0;
	  $$ = Hsep2(0," : ",
                  $5,
                  Hsep2(0, " == ", $8, $10)
               );
        };

Exp_List : Exp
	{  $$ = Pos($1,1); }

|	Exp_List ',' Exp
	{  int p;
           p  = length_ilist($1) + 1;
           $$ = add_to_ilist($1, Pos($3,p)); }

|	/* empty*/
	{  $$ = (item *)0;};

Exp :   KW_restrict '[' Domain ',' Exp ']'
	{ $$ = Hsep2(3," : ", Pos(check_prec($3,RestrictPrec),1),
	                      Pos(check_prec($5,RestrictPrec),2)); 
	  $$->prec = RestrictPrec;}

|       KW_case '[' '{' Exp_List '}' ']'
	{ $$ = Venc(2,Text(OW_case),Text(OW_esac),
                  Pos(itemizeExpressionList($4),1)
               ); 
	  $$->prec = CasePrec;}

|       KW_var '[' ID_item ']'
	{  $$ = $3;
	   $$->prec = VarPrec;}

|	KW_affine '[' Disable_array_notation Exp {eflag = $<b>3;}
	',' Matrix ']'
	{ if (!array_mode || !eflag || !ID_context ) 
	    $$ = Hsep2(0,".", Pos(check_prec($4,AffinePrec),1),
                              Pos(check_prec($7,AffinePrec),2));
	  else
	    $$ = Hsep2(0,"", Pos(check_prec($4,AffinePrec),1),
                             Pos(check_prec($7,AffinePrec),2));
	  $$->prec = AffinePrec;}

|       KW_affine '[' Disable_array_notation KW_const '[' Const ']'
	{eflag = $<b>3;} ',' Matrix ']'
        {
/*          if(noArgForAffineFunction == 1)
            { $$ = Pos(check_prec($6,AffinePrec),1);
              $$->prec = ConstPrec;
            }
          else
*/
          { if (!array_mode || !eflag || !ID_context )
              $$ = Hsep2(0,".", Pos(check_prec($6,AffinePrec),1),
                         Pos(check_prec($10,AffinePrec),2));
            else
              $$ = Hsep2(0,"", Pos(check_prec($6,AffinePrec),1),
                         Pos(check_prec($10,AffinePrec),2));
            $$->prec = AffinePrec;
          }
        }

|	KW_const '[' Const ']'
	{  $$ = $3;
	   $$->prec = ConstPrec;
        }

|	KW_index '[' 
	KW_matrix '[' NUMBER ',' NUMBER ',' '{' ID_List '}' ','
         '{' Number_List_List '}' ']' ']'
        {
          $$ = convert_affine($10,$14,0,0);
          $$->prec = AddPrec;
          free_node($5);  free_node($7); free_node($10); free_node($14); }


|	KW_call '[' ID_item ',' '{' Exp_List '}' ']'
        {   $$ = Hsep2(2,"",
		   $3,
		   Henc(0, Text("("), Text(")"),
                     Pos(Hsep(0,", ", $6),2)
		   )
                 );
        $$->prec = CallPrec;}

|	KW_binop '[' KW_add ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0," + ", Pos(check_prec($5,AddPrec),2),
                                Pos(check_prec($7,AddPrec+1),3));
        $$->prec = AddPrec;}

|	KW_binop '[' KW_mul ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0," * ", Pos(check_prec($5,MulPrec),2),
                                Pos(check_prec($7,MulPrec+1),3));
	    $$->prec = MulPrec;}

|	KW_binop '[' KW_and ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_and, Pos(check_prec($5,AndPrec),2),
                                  Pos(check_prec($7,AndPrec+1),3));
	    $$->prec = AndPrec;}

|	KW_binop '[' KW_min ',' Exp ',' Exp ']'
	{   $$ = Henc(0, Text(OW_min), Text(")"),
                    Hsep2(0,", ", Pos(check_prec($5,MinPrec),2),
                                  Pos(check_prec($7,MinPrec),3))
                 );
	    $$->prec = MinPrec;}

|	KW_binop '[' KW_max ',' Exp ',' Exp ']'
	{   $$ = Henc(0, Text(OW_max), Text(")"),
                    Hsep2(0,", ", Pos(check_prec($5,MaxPrec),2),
                                  Pos(check_prec($7,MaxPrec),3))
                 );
	    $$->prec = MaxPrec;}

|	KW_binop '[' KW_xor ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_xor, Pos(check_prec($5,XorPrec),2),
                                 Pos(check_prec($7,XorPrec+1),3));
	    $$->prec = XorPrec;}

|	KW_binop '[' KW_or ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_or, Pos(check_prec($5,OrPrec),2),
                                Pos(check_prec($7,OrPrec+1),3));
	    $$->prec = OrPrec;}

|	KW_binop '[' KW_sub ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0," - ", Pos(check_prec($5,SubPrec),2),
                                Pos(check_prec($7,SubPrec+1),3));
	    $$->prec = SubPrec;}

|	KW_binop '[' KW_div ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0," / ", Pos(check_prec($5,DivPrec),2),
                                Pos(check_prec($7,DivPrec+1),3));
	    $$->prec = DivPrec; }

|	KW_binop '[' KW_idiv ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_div, Pos(check_prec($5,DivPrec),2),
                                 Pos(check_prec($7,DivPrec+1),3));
	    $$->prec = DivPrec; }

|	KW_binop '[' KW_mod ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_mod, Pos(check_prec($5,ModPrec),2),
                                 Pos(check_prec($7,ModPrec+1),3));
	    $$->prec = ModPrec; }

|	KW_binop '[' KW_eq ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0," = ", Pos(check_prec($5,EqPrec),2),
                                Pos(check_prec($7,EqPrec),3));
	    $$->prec = EqPrec; }

|	KW_binop '[' KW_le ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_le, Pos(check_prec($5,LePrec),2),
                                Pos(check_prec($7,LePrec),3));
	    $$->prec = LePrec; }

|	KW_binop '[' KW_lt ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_lt, Pos(check_prec($5,LtPrec),2),
                                Pos(check_prec($7,LtPrec),3));
	    $$->prec = LtPrec; }

|	KW_binop '[' KW_gt ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_gt, Pos(check_prec($5,GtPrec),2),
                                Pos(check_prec($7,GtPrec),3));
	    $$->prec = GtPrec; }

|	KW_binop '[' KW_ge ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_ge, Pos(check_prec($5,GePrec),2),
                                Pos(check_prec($7,GePrec),3));
	    $$->prec = GePrec; }

|	KW_binop '[' KW_ne ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,OW_ne, Pos(check_prec($5,NePrec),2),
                                Pos(check_prec($7,NePrec),3));
	    $$->prec = NePrec; }

|	KW_unop '[' KW_neg ',' Exp ']'
	{   $$ = Hsep2(0,"", Text("-"), Pos(check_prec($5,NegPrec),2));
	    $$->prec = NegPrec;}

|	KW_unop '[' KW_not ',' Exp ']'
	{   $$ = Hsep2(0," ", Text(OW_not), Pos(check_prec($5,NotPrec),2));
	    $$->prec = NotPrec;}

|	KW_unop '[' KW_sqrt ',' Exp ']'
	{   $$ = Henc(0,Text(OW_sqrt), Text(")"), Pos($5,2) );
	    $$->prec = SqrtPrec;}

|	KW_unop '[' KW_abs ',' Exp ']'
	{   $$ = Henc(0,Text(OW_abs), Text(")"), Pos($5,2) );
	    $$->prec = AbsPrec;}

|	KW_if '[' Exp ',' Exp ',' Exp ']'
	{   $$ = Hsep2(0,"",
	            Hsep2(0,"",
	               Hsep2(4,"",
                          Text(OW_if),
                          Henc(4,Text("("),Text(")"),
	                    Pos(check_prec($3,IfPrec),1)
                          )
                       ),
	               Hsep2(4,"",
		          Text(OW_then),
	                  Pos(check_prec($5,IfPrec),2)
	               )
                    ),
	            Hsep2(0,"",
	               Text(OW_else),
	               Pos(check_prec($7,IfPrec),3)
	            )
                 );
	    $$->prec = IfPrec;}

|	KW_reduce '[' Casop ','
		Disable_array_notation	/* save array notation */
		/* never array notation for projection matrices */
		Matrix ','
		Enable_array_notation
		{ $<n>$ = ID_context;	/* save context */
                  ID_context = ID_List_Save;
                }
		Exp ']'
	{ eflag = $5;			/* restore array notation */
	  ID_context = $<n>9;		/* restore context */
          $$ = Hsep2(0,"",
	          Text(OW_reduce),
		  Henc(0, Text("("), Text(")"),
		     Hsep3(0,", ",Pos($3,1),Pos($6,2),Pos($10,3))
	          )
	       );
	  $$->prec = ReducePrec; };

Casop : KW_add
{ $$ = Text("+"); }

| KW_mul
{ $$ = Text("*"); }

| KW_and
{ $$ = Text(OW_and_p); }

| KW_or
{ $$ = Text(OW_or_p); }

| KW_xor
{ $$ = Text(OW_xor_p); }

| KW_min
{ $$ = Text(OW_min_p); }

| KW_max
{ $$ = Text(OW_max_p); };

Disable_array_notation :	/* empty */
        { $$ = eflag; eflag = 0;};

Enable_array_notation :	/* empty */
        { eflag = 1;};

Const :
	NUMBER
	{  if ($1->the.iconst.infinity==1)
	   {  $$ = new_item(text);
	      if ($1->the.iconst.value<0)
		 strcpy($$->the.text.string,"-Infinity");
	      else
		 strcpy($$->the.text.string,"Infinity");
	   }
	   else $$ = Number($1->the.iconst.value);
	   $$->prec = ConstPrec;
	   free_node($1); }

|       BOOLEAN
	{  $$ = new_item(text);
	   if ($1->the.bconst.value)
	      strcpy($$->the.text.string,"True");
	   else
	      strcpy($$->the.text.string,"False");
	   $$->prec = ConstPrec;
	   free_node($1); }

|       REAL
	{  $$ = Hsep2(0,".",
		   Number($1->the.rconst.value),
		   Number($1->the.rconst.fraction)
		);
	   $$->prec = ConstPrec;
	   free_node($1);}
;

/*-----------------------------------------------------------------*/
/* IV. Domain Specifications                                       */
/*-----------------------------------------------------------------*/

Domain : KW_domain '[' Dom_ID_List ',' Dom_Union ']'
	{  $$ = $5;
	   $$->prec = 10;
	};

Dom_ID_List: NUMBER ',' '{' ID_List '}' 	/* includes dimension */
	{  $$ = ID_List_Save = $4;

	   D_Save = $1->the.number.value;
	   free_node($1);
	   /* keep $4 */
	}
|	NUMBER ',' '{' '}' 	/* includes dimension */
	{  $$ = ID_List_Save = new_list(0);
        D_Save = $1->the.number.value;
        free_node($1);
	};


Dom_Union : '{' Pol_List '}'
	{  $$ = Hsep(0," | ",$2);
	   $$->prec = 10;
	}
|	 '{' ZPol_List '}'
	{  $$ = Hsep(0," | ",$2);
	   $$->prec = 10;
	};
/* |	 '{' '}'	*/
/*	{  $$ = ????;	*/
/*	   $$->prec = 10;*/
/*	};		*/

ID_List : ID
	{  $$ = new_list($1); }

|	ID_List ',' ID
	{  $$ = add_to_list($1, $3); };

ZPol_List : ZPol
	{  $$ = $1; }

|	ZPol_List ',' ZPol
{  $$ = add_to_ilist($1, $3); };

ZPol :	KW_zpol '['
        { z_flag=1;
          if (array_mode) {
            /* no array notation with Zpols */
                fprintf(stderr,"Array notation is incompatible with Zpols, disabling array notation \n"); 
                array_mode=0;
          }
        }
        Matrix		/* Mat_Save is set */
	{   $<n>$ = ID_context;
	    ID_context = ID_List_Save;
	}
	',' '{' Pol_List '}' ']'
	{   z_flag=0;
	    $$ = Hsep(0," | ",$8);
	    $$->prec = 10;
	    ID_context = $<n>5; /* restore context ID_context =  $<n>5 */
	    Mat_Save = (item *) 0;
	};

Pol_List : Pol
	{  $$ = $1; }

|	Pol_List ',' Pol
{  $$ = add_to_ilist($1, $3); };
/* empty
|	
	{  $$ = (item *)0 ;};
*/

Pol : KW_pol '[' NUMBER ',' NUMBER ',' NUMBER ',' NUMBER ','
     '{' Number_List_List '}' ',' '{' Number_List_List '}' ']'
	{  if (z_flag)					/* z-polyhedron */
	   	$$ = convert_zpol(ID_context, Mat_Save, $12);
	   else if (!array_mode || !eflag || !ID_context ) /* standard notat */
                $$ = convert_pol2(ID_List_Save, $12, G_dim);
	   else						/* array notation */
	   {	/* Does dim ID_List_Save==dim ID_context? */
		if (ID_context->the.list.count!=ID_List_Save->the.list.count)
		{   $$ =convert_pol2(ID_List_Save, $12,
			             ID_context->the.list.count);
		}
		/* else $$ = spec_pol2(ID_context, $12, G_dim); */
		else $$ =convert_pol2(ID_context, $12,
				      ID_context->the.list.count);
	   }
	   free_node($3); free_node($5); free_node($7); free_node($9);
           free_node($16); };

/*-----------------------------------------------------------------*/
/* V.  Matrix Specifications                                       */
/*-----------------------------------------------------------------*/

Matrix : KW_matrix '[' NUMBER ',' NUMBER ',' '{' ID_List '}' ','
	 '{' Number_List_List '}' ']'
	{
/*        noArgForAffineFunction = (($5->the.iconst.value - G_dim) <= 1); */

          if (dpflag)		/* dependences */
	  {	DepMatIDS = Henc(0, Text("["), Text("]"),
		Hsep(0, ",", id_list2(ID_List_Save,G_dim)));
		$$ = Henc(0, Text("["), Text("]"),
		    convert_affine(ID_List_Save,$12,G_dim,0)
		);
	  }
	  else if ( z_flag )	/* z-polyhedron */
            {  if (ID_context && 0) /* should never happen ? (Tanguy 2003) */
	       $$ = Mat_Save =
		     convert_affine($8,$12,ID_context->the.list.count,0);
	     else
	       $$ = Mat_Save = convert_affine($8,$12,G_dim,0);
	  }
	  else if ( use_flag )	/* use statements */
	  {  if ( !array_mode ) $$ = convert_mat(ID_context,$12, G_dim, 0);
	     else               $$ = spec_mat(ID_context, $12, 0);
	  }
	  else if ( !array_mode || !eflag || !ID_context ) /* standard notat */
	       $$ = convert_mat($8,$12,G_dim,G_dim);
	  else $$ = spec_mat(ID_context, $12, G_dim);      /* array notation */
	  $$->prec = 10;
	  ID_List_Save = $8;
	  free_node($3);  free_node($5); free_node($12); };

Matrix : KW_matrix '[' NUMBER ',' NUMBER ',' '{' /*empty*/ '}' ','
	 '{' Number_List_List '}' ']'
	{ node *ids = new_list(0);
          if (dpflag)		/* dependences */
	  {	DepMatIDS = Henc(0, Text("["), Text("]"),
		   Hsep(0, ",", id_list2(ID_List_Save,G_dim)));
		$$ = Henc(0, Text("["), Text("]"),
		    convert_affine(ID_List_Save,$11,G_dim,0)
		);
	  }
	  else if ( z_flag )	/* z-polyhedron */
	  {  if (ID_context)
	       $$ = Mat_Save =
		     convert_affine(ids, $11, ID_context->the.list.count, 0);
	     else
	       $$ = Mat_Save = convert_affine(ids, $11, G_dim, 0);
	  }
	  else if ( use_flag )	/* use statements */
	  {  if ( !array_mode ) $$ = convert_mat(ID_context, $11, G_dim, 0);
	     else               $$ = spec_mat(ID_context, $11, 0);
	  }
	  else if ( !array_mode || !eflag || !ID_context ) /* standard notat */
	       $$ = convert_mat(ids, $11, G_dim, G_dim);
	  else $$ = spec_mat(ID_context, $11, G_dim);      /* array notation */
	  $$->prec = 10;
	  ID_List_Save = ids;
	  free_node($3);  free_node($5); free_node($11); };

Number_List : NUMBER
	{  $$ = new_list($1); }

|	Number_List ',' NUMBER
	{  $$ = add_to_list($1, $3); }

|	/* empty */
	{  $$ = new_list(0) ;};

Number_List_List : '{' Number_List '}'
	{  $2->type = list;
	   $$ = new_list($2); }

|	Number_List_List ',' '{' Number_List '}'
	{  $4->type = list;
	   $$ = add_to_list($1, $4); }

|	/* empty */
	{  $$ = new_list(0);};

%%
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
