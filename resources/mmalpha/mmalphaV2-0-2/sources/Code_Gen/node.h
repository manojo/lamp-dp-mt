/*  file: $MMALPHA/sources/Code_Gen/node.h
   AUTHOR : Doran Wilde
   CONTACT : http://www.irisa.fr/api/ALPHA
    COPYRIGHT 1995,1996,1997,1998 by Brigham Young University,
              Provo, Utah; all rights reserved.
     
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
 
typedef	enum {	none,
		/* Number and Id */
		    num, id,
		/* Lists */
		    list, 
		/* System */
		    sys, decl,
                /* Equation */
		    equation, cases, restrict, var, affine,
		    iconst, bconst, rconst,
		    /* binop subtypes */
			addop, subop, mulop, divop, idivop, modop,
			eqop, leop, ltop, gtop, geop, neop,
			orop, andop,
		    /* unop subtypes */
			negop, notop,
		    ifop,
		/* Domains and Matrices */
		    dom, pol, mat, vec
	    } nodetype;

typedef enum { inttype, booltype, realtype, notype } datatype;	/* <data_type> */

typedef struct node_
	{   nodetype type;			/* node type */
		/* all nodes are listable, and have the following fields */
	    struct node_ *next;			/* next node in list */
            int index;
	    union
	    {
/* I.  General Specifications */
		struct
		{   int value;
		} number;			/* <number> */
                struct
                {   char name[2];                 
                } id;                           /* <id> */
                struct
                {   struct node_ *first, *last;
                    int count;
                } list;				/* <list> */
/* II. System specifications */
		struct
		{   struct node_ *id;		/* <sys.id> */
		    struct node_ *in;		/* <sys.in_var> */
		    struct node_ *out;		/* <sys.out_var> */
		    struct node_ *local;	/* <sys.local_var> */
		    struct node_ *equations;	/* <sys.equation_list> */
		} sys;				/* <sys> */
                struct
                {   struct node_ *id;		/* <decl.id> */
		    datatype type;		/* <decl.data_type> */
                    struct node_ *domain;	/* <decl.domain> */
						/* <decl.domain> = NULL -> scalar */
		    int          *l, *w;        /* <decl.l> <decl.w> */
		                                /* above used in C simulator only */
                } decl;
/* III. Equation and Expression specifications */
		struct
		{   struct node_ *id;		/* <equation.id> */
		    struct node_ *cases;	/* <equation.case> */
		} equation;			/* <equation> */
		struct
		{   struct node_ *list;		/* <case.list> */
		} cases;			/* <case> */
		struct
		{   struct node_ *domain;	/* <restrict.domain> */
		    struct node_ *exp;		/* <restrict.exp> */
		} restrict;			/* <restrict> */
		struct
		{   struct node_ *id;		/* <var.id> */
                } var;				/* <var> */
		struct
		{   struct node_ *var;		/* <affine.var> */
		    struct node_ *matrix;	/* <affine.matrix> */
		} affine;			/* <affine> */
                struct
                {   int value, infinity;	/* <const.number> */
                } iconst;			/* <const> */
                struct
                {   int value;			/* <const.number> */
                } bconst;			/* <const> */
                struct
                {   int value;			/* <const.number> */
		    int fraction;		/* <const.fraction> */
                } rconst;			/* <const> */
                struct
                {   struct node_ *lexp;		/* <binop.left_exp> */
                    struct node_ *rexp;		/* <binop.left_exp> */
                } binop;			/* <binop> */
                struct
                {   struct node_ *exp;		/* <unop.exp> */
                } unop;				/* <unop> */
		struct
		{   struct node_ *exp1;		/* <if.exp1> */
		    struct node_ *exp2;		/* <if.exp2> */
		    struct node_ *exp3;		/* <if.exp3> */
		} ifop;
/* IV. Domain specifications */
		struct
		{   int dim;			/* <domain.dimension> */
		    struct node_ *index;	/* <domain.id_list> */
		    struct node_ *pol;		/* <domain.pol_list> */
		} dom;				/* <domain> */
		struct
		{   int nb_constraints;		/* <pol.constraints_num> */
		    int nb_equations;           /* <pol.eqn_num> */
		    struct node_ *constraints;
			/* constraints,rays = list of vectors */
		} pol;				/* <pol> */
/* V. Matrix specifications */
		struct
		{   int nb_rows;		/* <matrix.rows> */
		    int nb_cols;		/* <matrix.cols> */
		    struct node_ *id;		/* <matrix.id_list> */
		    struct node_ *matrix;	/* <matrix.matrix> */
			/* matrix = list of vectors */
		} mat;				/* <matrix> */
		struct
		{   int dim;                    /* <vector.dim> */
                    int *val;                   /* <vector.val> */
		} vec;
	    } the;
	} node;

typedef struct context_
{       Polyhedron *dom;        /* polylib domain of context domain */
        node *index;            /* node list of context indices */
        int index_stamp;        /* index stamp */
        item *code;             /* top of code item struction */
        item **body;            /* pointer of where to insert body */
} context_info;

