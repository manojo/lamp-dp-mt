 /*  file: $MMALPHA/sources/Read_Alpha/nodes.c
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
   Place - Suite 330, Boston, MA  02111-1307, USA.   */
/* node.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "nodetypes.h"
#include <polylib/polylib.h>
#include "node.h"
extern	FILE *yyout;
extern	void yyerror(char *);
extern	void yyerror2(char *, char *);
extern	void yyerror3(char *, char *, char *);
extern	void yywarning(char *);
extern	void yywarning2(char *, char *);
extern	void yywarning3(char *, char *, char *);
extern  int  do_let;

/*------------------------------------------------------------------*/
/* internal memory management system                                */
/*------------------------------------------------------------------*/
static node	*allocated=(node *)0,
		*unallocated=(node *)0,
		*idallocated=(node *)0;

/* add node n to allocation list a */
static	void 	add_to_alist(ap, n)
node **ap, *n;
{   node *a=*ap;
    if (!a) { *ap = n; return; }
    n->nx = a;		/* add n to front of list */
    a->pv->nx = n;	/* end of old list point to new head */
    n->pv = a->pv;	/* new head points to end of list */
    a->pv = n;		/* old head points to new head */
}

/* remove n from allocation list a */
static	void	remove_from_alist(ap, n)
node **ap, *n;
{   node *a=*ap;
    if (a==n)
    {	if (n->nx==n) { *ap=(node *)0; return; }
	*ap = n->nx;
    }
    n->pv->nx = n->nx;
    n->nx->pv = n->pv;
    n->nx = n->pv = n;
}

/* merge allocation lists: a = a cat n, n = null */
static	void	merge_alists(ap, np)
node **ap, **np;
{   node *a=*ap, *n=*np, *t;
    if (!n) return;
    if (!a) {*ap=n; *np=(node *)0; return;}
    a->pv->nx = n;
    n->pv->nx = a;
    t = n->pv;
    n->pv = a->pv;
    a->pv = t;
    *np = (node *)0;
}

void	preallocate_nodes(n)
int	n;
{   node *p;
    int i;

    p = (node *)malloc(n*sizeof(node));
    if (!p)
    {	yyerror("preallocate nodes: out of memory");
	exit(-1);
    }
    for (i=0; i<n; i++)
    {	p->nx = p->pv = p;
	add_to_alist(&unallocated, p);
	p++;
    }
}

/* protect from node n from ever being deallocated/reallocated */
void	keep_node(n)
node	*n;
{   node *x;

    if ((n->type==id) || (n->type==var) || (n->type==iddef)
                      || (n->type==parameter) )
    {   remove_from_alist(&idallocated, n);
    }
    else if (n->type==list)
    {   for (x=n->info.list.first; x; x=x->next) keep_node(x);
	remove_from_alist(&allocated, n);
    }
    else
    {   remove_from_alist(&allocated, n);
    }
    n->nx = n->pv = n;
}

/* protect all the nodes in tree n from ever being deallocated/reallocated */
void    keep_tree(n)
node    *n;
{  
    #if MEMDEBUG
    fprintf(stderr,"T");
    #endif
    if (n)
      {
      switch (n->type)
        {
        case icons:
        case rcons:
        case bcons:
            break;
        case id:
        case iddef:
        case var:
        case parameter:
            keep_tree(n->info.id.domain);
            break;
        case xaddop:
        case xsubop:
        case addop:
        case subop:
        case mulop:
        case divop:
        case idivop:
        case modop:
        case eqop:
        case leop:
        case ltop:
        case gtop:
        case geop:
        case neop:
        case orop:
        case xorop:
        case andop:
        case minop:
        case maxop:
        case restrictop:
        case loopop:
        case affineop:
        case equateop:
        case callop:
            keep_tree(n->info.binop.l);
            keep_tree(n->info.binop.r);
            break;
        case negop:
        case notop:
        case caseop:
        case sqrtop:
	case absop:
            keep_tree(n->info.unop.c);
            break;
        case ifop:
            keep_tree(n->info.triop.l);
            keep_tree(n->info.triop.c);
            keep_tree(n->info.triop.r);
            break;
        case reduce:
            keep_tree(n->info.reduce.proj);
            keep_tree(n->info.reduce.exp);
            break;
        case use:
            keep_tree(n->info.use.param);
            keep_tree(n->info.use.inputs);
            keep_tree(n->info.use.outputs);
            keep_tree(n->info.use.name);
            keep_tree(n->info.use.extdom);
            break;
        case inpsop:
        case outsop:
        case locsop:
        case letop:
        case list:
             {
             node *e;
             for (e=n->info.list.first; e;  e=e->next)
                 keep_tree(e);
             break;
             }
        case sys:
            keep_tree(n->info.sys.name);
            keep_tree(n->info.sys.param);
            keep_tree(n->info.sys.inputs);
            keep_tree(n->info.sys.outputs);
            keep_tree(n->info.sys.locals);
            keep_tree(n->info.sys.equations);
        case pol:
        case mat:
        case vec:
            keep_tree(n->info.pol.index);
            break;
        default:
            fprintf(stderr, "keep_tree() : Unknown node type [%d]\n", n->type);
            break;
        }
        keep_node(n);
      }
}

/*------------------------------------------------------------------*/
/* node allocation/deallocation system                              */
/*------------------------------------------------------------------*/

/* return a new node of type t */
node	*new_node(t)
nodetype t;
{   node *n;
    if (!unallocated)		/* there are no unallocated nodes */
    {	preallocate_nodes(128);	/* so allocate a few */
    }
    n = unallocated;		/* remove one from the list */
    remove_from_alist(&unallocated, n);
    n->type = t;		/* and initialize it */
    n->next = (node *)0;
    n->index = -1;
    add_to_alist(&allocated, n);
    return n;
}

/* create a new id node for string s */
node	*new_id(s)
char	*s;
{   node *n;
    n = (node *)malloc(sizeof(node)+strlen(s));	/* more than big enough */
    if (!n)
    {	yyerror("new id: out of memory");
	exit(-1);
    }
    n->type = id;			/* register it */
    n->nx = n->pv = n;
    add_to_alist(&idallocated, n);

    n->index = -1;			/* initialize it */
    n->next = (node *)0;
    n->info.id.type = domtype;
    n->info.id.domain = (node *)0;
    strcpy(n->info.id.name, s);
    return n;
}

/* recycle the old node n */
void	old_node(n)
node *n;
{   if (!n) return;
    if ((n->type==id) || (n->type==var))
    {	remove_from_alist(&idallocated, n);
	free(n);
	return;
    }
    remove_from_alist(&allocated, n);
    add_to_alist(&unallocated, n);
}

/* recycle an old polyhedron node */
void	old_pol_node(n)
node *n;
{   if (n->info.pol.ref_count==0)
    {   Domain_Free(n->info.pol.p);
	old_node(n);
    }
}

/* recycle all allocated nodes */
void	all_old_nodes()
{   node *n;
    merge_alists(&unallocated, &allocated);
    while (idallocated)
    {	n = idallocated;
	remove_from_alist(&idallocated, n);
	free(n);
    }
}

/* create a node list consisting of element e,
   or empty list if e is 0 */
node	*new_list(e)
node	*e;
{   node *n;
    n = new_node(list);
    n->info.list.last = n->info.list.first = e;
    if (e)
    {	n->info.list.count = 1;
	e->index = 0;
    } else n->info.list.count = 0;
    /* n->next = (node *)0; */
    /* n->index = -1; */
    return n;
}

/*------------------------------------------------------------------*/
/* list management system                                           */
/*------------------------------------------------------------------*/

/* add node e to end of list n, return the list */
/* n must be list type */
node	*add_to_list(n, e)
node	*e, *n;
{  
    if (!n) return new_list(e);
    if (n->type != list)
    {	yyerror("add_to_list: node is not a list");
	return n;
    }
    if (!e) return n;
    if (n->info.list.last)
    {	n->info.list.last->next=e;
	n->info.list.last=e;
    }
    else /* list is empty */
    {	n->info.list.last = n->info.list.first = e;
    }
    e->index = n->info.list.count;
    e->next  = (node *) 0;	/* make sure its last in list */
    n->info.list.count++;
    return n;
}

/* add node e to end of id list n if its not already there, return the list */
/* n must be list type */
node	*add_id_to_list(n, e)
node	*e, *n;
{   node *i;

    if (!e) return n;
    if (e->type != id)
    {   yyerror("add_id_to_list: node is not an id");
        return n;
    }
    if (!n) return new_list(e);
    if (n->type != list)
    {	yyerror("add_id_to_list: node is not a list");
	return n;
    }
    for (i=n->info.list.first; i; i=i->next)
    {   if ( (i->type==id) && !strcmp(e->info.id.name, i->info.id.name) ) break;
    }
    if (i) return n;

    if (n->info.list.last)
    {	n->info.list.last->next=e;
	n->info.list.last=e;
    }
    else /* list is empty */
    {	n->info.list.last = n->info.list.first = e;
    }
    e->index = n->info.list.count;
    e->next  = (node *) 0;	/* make sure its last in list */
    n->info.list.count++;
    return n;
}

/* add node e to front of list n, return the list */
/* n must be list type */
node    *add_to_front(e, n)
node    *e, *n;
{   node *t;
    if (n && (n->type != list))
    {   yyerror("add: node is not a list");
        return n;
    }
    if (!e) return n;
    if (!n) return new_list(e);
    if (n->info.list.first)
    {   e->next = n->info.list.first;
        n->info.list.first=e;
    }
    else /* list is empty */
    {   n->info.list.last = n->info.list.first = e;
    }
    e->index = 0;
    for (t=e->next; t; t=t->next) t->index++;
    n->info.list.count++;
    return n;
}

int id_strcmp(a,b)
const char *a;
const char *b;
{
  const char *p1=a,*p2=b;
  while ((*p1)&&(*p2)&&(*p1!=':')&&(*p2!=':')&&(*p1==*p2))
    { p1++;p2++; }
  if (((*p2==':')||(*p2==0))&&((*p1==':')||(*p1==0)))
    return 0;
  else
    return 1;
}

/* search node list a for an id node named s */
/* vars are never kept in a list */
node    *search_list(a, s)
node    *a;
char    *s;
{   node *n;
    if (!a) return (node *)0;
    if (a->type != list)
    {   yyerror("search: node is not a list");
        return (node *)0;
    }
    for (n=a->info.list.first; n; n=n->next)
    {   if ( ((n->type==iddef) || (n->type==id)) &&
		 !id_strcmp(s, n->info.id.name) ) break;
    }
    return n;
}

node	*merge_list(a, b)
node	*a, *b;
{   if (!b || !b->info.list.first)
    {   old_node(b);
        return a;
    }
    if (!a || !a->info.list.first)
    {	old_node(a);
	return b;
    }
    a->info.list.last->next = b->info.list.first;
    a->info.list.last = b->info.list.last;
    a->info.list.count += b->info.list.count;
    old_node(b);
    return a;
}

/* protect node list a */
void	keep_list(a)
node    *a;
{   node *n;
    if (!a) return;
    if (a->type != list)
    {   yyerror("keep_list: node is not a list");
        return;
    }
    for (n=a->info.list.first; n; n=n->next)
    {	keep_node(n);
    }
    keep_node(a);
}

/*------------------------------------------------------------------*/
/* utility system                                                   */
/*------------------------------------------------------------------*/

node	*convert_suite(s)
node *s;
{   node *l, *r, *l1, *r1, *n, *x;
    nodetype t;

    x = new_list(0);
    for (l=s->info.list.first, r=l->next;  r; l=r, r=l->next)
    {   t = r->type;
	r->type = list;
	for (l1 = l->info.list.first; l1; l1=l1->next)
	for (r1 = r->info.list.first; r1; r1=r1->next)
	{   n = new_node(t);
	    n->info.binop.l = l1;
	    n->info.binop.r = r1;
	    x = add_to_list(x, n);
	}
    }
    return x;
}

int	matrix_equal(m1, m2, NbRows, NbCols)
Value	**m1, **m2;
int	NbRows, NbCols;
{   int i,j;
 int c = NbCols;
 char *ck;

    ck = malloc(NbRows);
    memset(ck, 0, NbRows);
    for (i=0; i<NbRows; i++)
    {   for (j=0; j<NbRows; j++)
	{   if (!ck[j] && !Vector_Equal(m1[i], m2[j], c)) break; }
	if (j==NbRows) /* could not find a match */
	{   free(ck);
	    return 0;	/* not equal */
	}
	else
	{   ck[j] = 1; }
    }
    free(ck);
    return 1;	/* equal */
}

/* tests if a matrix is the identity matrix */
/* this could go in the Polyhedral Library */
int	Matrix_is_Identity(m)
Matrix	*m;
{   int i,j;

    for (i=0; i<m->NbRows; i++)
    {  for (j=0; j<m->NbColumns; j++)
       {  if (i==j)
          {  if (value_notone_p(m->p[i][j])) return 0;	/* not id */
          }
          else
          {  if (value_notzero_p(m->p[i][j])) return 0;	/* not id */
          }
       }
    }
    return 1;	/* equal id */
}

int	var_equal(v1, v2, d)
node	*v1, *v2;
node	*d;
{   int status = 1;
    node *n1, *n2;
    Polyhedron *p1, *p2;

    n1 = search_list(d, v1->info.id.name);
    if (!n1) 
    {   yyerror2(v1->info.id.name,"is not defined");
	status = 0;
    }
    n2 = search_list(d, v2->info.id.name);
    if (!n2) 
    {   yyerror2(v2->info.id.name,"is not defined");
	status = 0;
    }
    if (!status) return 0;
    if (n1==n2) return 1;

    if ( (n1->info.id.type != n2->info.id.type) ||
	 ((n1->info.id.domain!=0) && (n2->info.id.domain==0)) ||
	 ((n2->info.id.domain!=0) && (n1->info.id.domain==0)) )
    {   char s[64];
        sprintf(s, "variable %s/%s types are different",
	n1->info.id.name, n2->info.id.name);
	yyerror(s);
	status = 0;
    }
    if (!(n1->info.id.domain) || !(n2->info.id.domain)) return status;
    if ((n1->info.id.domain)==(n2->info.id.domain)) return status;
    p1 = n1->info.id.domain->info.pol.p;
    p2 = n2->info.id.domain->info.pol.p;
    if (p1==p2)
    {   char s[64];
        sprintf(s, "%s/%s pol pointer problem",
        n1->info.id.name, n2->info.id.name);
	yyerror(s);
	return 0;
    }
    if ( (p1->Dimension     != p2->Dimension    ) ||
         (p1->NbConstraints != p2->NbConstraints) ||
	 (p1->NbRays        != p2->NbRays       ) ||
	 !matrix_equal(p1->Constraint, p2->Constraint,
                       p1->NbConstraints, p1->Dimension+2) ||
	 !matrix_equal(p1->Ray, p2->Ray, p1->NbRays, p1->Dimension+2) )
    {	char s[64];
        sprintf(s, "%s/%s domains are different",
        n1->info.id.name, n2->info.id.name);
	yyerror(s);
	return 0;
    }
    return status;
}
        
void     check_no_variable(l, p)
node *l,*p;
{ node *t;
  if (!l || !p) return;
  for (t=l->info.list.first; t; t=t->next)
  { if (t->type!=id)
    { yyerror("check_no_variable() : not an id list\n");
      return;
    }
    else if (search_list(p, t->info.id.name))
    { yyerror2(t->info.id.name, ": variable is already declared.");
      return;
    }
  }
}

void     check_no_param(l, p)
node *l,*p;
{ node *t;
  if (!l || !p) return;
  for (t=l->info.list.first; t; t=t->next)
  { if (t->type!=id)
    { yyerror("check_no_param() : not an id list\n");
      return;
    }
    else if (search_list(p, t->info.id.name))
    { yyerror2(t->info.id.name, ": index is already declared.");
      return;
    }
  }
}

/* check that all ids in exp list n belong to parameter list p */
void    param_lookup(p, n)
node    *p, *n;
{   node *t;
    if (!n || !p)
    { yyerror("Null pointer passed to param_lookup()\n");
      return;
    }
    switch (n->type)
    {   case id:
            t = search_list(p, n->info.id.name);
            if (!t)
            {   char s[64];
                sprintf(s, "Error : %s is not a parameter/extension index\n",
                          n->info.id.name);
                yyerror(s);
            }
            else n->index = t->index;
            return;
        case xaddop:
        case xsubop:
        case addop:
        case subop:
        case mulop:
            param_lookup(p, n->info.binop.l);
            param_lookup(p, n->info.binop.r);
            return;
        case negop:
        case absop:
            param_lookup(p, n->info.unop.c);
            return;
        case list:
            for (t=n->info.list.first; t; t=t->next)
                param_lookup(p, t);
            return;
        case icons:
        case proto:
        case pol:
        case mat:
        case vec:
            return;
        default:
            yyerror("unknown or wrong node type in param_lookup()\n");
    }
    return;
}

/* search node tree n for new indices and add them to dictionary d */
/* don't include parameters in p */
node *get_indices(d,n,p)
node *d,*n,*p;
{   node *t;
    if (!n) return d;
    switch (n->type)
    {   case id:
	    t = search_list(p, n->info.id.name);  /* is it a parameter ? */
            if (t) return d;			  /* yes, then forget it */
            if (!d) d=new_list(0);
	    t = search_list(d, n->info.id.name);
	    if (!t)
	    {   /* add it to an error dictionary */
                t = new_id(n->info.id.name);
                add_to_list(d,t); 
	    }
	    return d; 
        case xaddop:
        case xsubop:
        case addop:
        case subop:
        case mulop:
        case eqop:
	    d = get_indices(d, n->info.binop.l, p);
	    d = get_indices(d, n->info.binop.r, p);
	    return d;
	case divop:
	    d = get_indices(d, n->info.binop.l, p);
	    return d;
        case gtop:
        case geop:
        case leop:
        case ltop:
	    return d;	/* only search equalities for addl indices */
        case negop:
        case absop:
	    d = get_indices(d, n->info.unop.c, p);
	    return d;
        case list:
	    for (t=n->info.list.first; t; t=t->next)
		d = get_indices(d, t, p);
	    return d;
        case icons:
	case proto: 
        case pol:
        case mat:
        case vec:
	    return d;
        default:    yyerror("unknown node type");
    }
    return d;
}


/* lookup node n in dictionary d */
/* side effect: marks the index of all id's */
/* returns 1 if n is a simple id list, 0 if it includes any function */
/* returns -1 if an id lookup error occured */
int	id_lookup(d, n)
node	*d, *n;
{   node *t;
    int s, simple=1;
    if (!n) return simple;
    switch (n->type)
    {   case id:
            if (d)
	    {  t = search_list(d, n->info.id.name);
	       if (!t)
	       {   yyerror2(n->info.id.name, "is an undefined index");
		   simple = -1;
	           /* add it to an error dictionary */
	       }
	       else n->index = t->index;
            }
	    return simple; 
        case xaddop:
        case xsubop:
        case addop:
        case subop:
        case mulop:
        case gtop:
        case geop:
        case eqop:
        case leop:
        case ltop:
	    if ( id_lookup(d, n->info.binop.l)<0 ||
	         id_lookup(d, n->info.binop.r)<0 ) return -1;
	    else return 0;
	case divop:
	    if ( id_lookup(d, n->info.binop.l)<0) return -1;
	    else return 0;
        case negop:
        case absop:
	    if ( id_lookup(d, n->info.unop.c)<0 ) return -1;
	    else return 0;
        case list:
	    for (t=n->info.list.first; t; t=t->next)
	    {	s = id_lookup(d, t);
		if ( s==-1 || simple==-1 ) simple = -1;
		else if ( s==0  || simple==0 ) simple = 0;
	    }
	    return simple;
        case icons:
	case proto: 
        case pol:
        case mat:
        case vec:
	    return 0;
        default:    yyerror("unknown node type");
    }
    return simple;
}

/*---------------------------------------------------------------------*/
/* declare a list of ids and put them in a dictionary
   ids - list of id's
   t - prototype of type
   iot - {input, output, local}
   d - dictionary */
/*---------------------------------------------------------------------*/
node	*declare_vars(ids, t, iot, d)
node	*ids, *t;
varclass iot;
node	*d;
{   node *n, *n1, *v;

    if (!ids || !t) return d;
    if (t->info.proto.domain)
    {   keep_node(t->info.id.domain);		/* protect the domain */
	keep_list(t->info.id.domain->info.pol.index);
    }
    if (t->info.proto.coding)
      {keep_node(t->info.proto.coding);
      keep_node(t->info.proto.length);
      }
    for (n=ids->info.list.first; n; n=n1)
    {	n1 = n->next;	/* remember it now, cause it might get clobbered */
	v = search_list(d, n->info.id.name);
	if (v)	/* its already in the dictionary d */
	{   /* redefining the variable */
            yyerror2(v->info.id.name, "is already declared");
	    v->info.id.domain->info.pol.ref_count--;
	    old_pol_node(v->info.id.domain);
	}
	else
	{   v = n;
	    keep_node(v);	/* protect it */
	    add_to_list(d, v);	/* add it to dictionary d (clobbers n->next) */
	}
	v->type = iddef;
	v->info.id.type = t->info.proto.type;
	v->info.id.domain = t->info.proto.domain;
	if (v->info.id.domain)
	    v->info.id.domain->info.pol.ref_count++;
	v->info.id.iotype = iot;
	v->info.id.coding = t->info.proto.coding;
	v->info.id.length = t->info.proto.length;
    }
    return d;
}

/*---------------------------------------------------------------------*/
/*---------------------------------------------------------------------*/
void	print_var(n, d)
node	*n, *d;
{   node *v;
    v = search_list(d, n->info.id.name);
    if (v) print_alpha(v, 0);
    else yyerror2(n->info.id.name,"is not defined");
}

/*---------------------------------------------------------------------*/
/*---------------------------------------------------------------------*/
void	print_var_alpha(n, d)
node	*n, *d;
{   node *v;
    v = search_list(d, n->info.id.name);
    if (v) print_alpha(v, 0);
    else yyerror2(n->info.id.name,"is not defined");
}

/*---------------------------------------------------------------------*/
/* convert parse tree of a matrix to matrix */
/*---------------------------------------------------------------------*/
node	*convert_matrix(n)
node	*n;
{   node *e, *f, *m;
 int r, c; 
 Value *p; /* int *p */
    /* create a matrix structure, then traverse the parse tree
       to extract the matrix info from it.
       Abandon the matrix parse tree.  It will be cleaned up
       at the end of the command */
    m = new_node(mat);
    r = n->info.list.count;
    c = n->info.list.first->info.list.count;
    m->info.mat.m = Matrix_Alloc(10*r,c);
    m->info.mat.maxrows = 10*r;    /* alloc more rows for chernikova */
    p =  m->info.mat.m->p_Init;
    for (e=n->info.list.first; e; e=e->next)
    {   if (e->info.list.count!=c)
        {   yyerror("matrix rows are not all the same length");
            break;
        }
        for (f=e->info.list.first; f; f=f->next)
            {
              /* *p++ = f->info.icons.value; */
              value_set_si(*p,f->info.icons.value);
              p++;
            }
 
   }
   m->info.mat.m->NbRows = r;
   return m;
}

/*---------------------------------------------------------------------*/
/* data structure and procedures to do rational arithmetic             */
/*---------------------------------------------------------------------*/
typedef struct {int n,d;} rational;	/* d is always >0 */

static int rgcd(int a, int b)
{  int tmp;
   if (a<0) a=-a;
   if (b<0) b=-b;
   while(a)
   {  tmp = b%a;
      b=a;
      a=tmp;
   }
   return b;
}

static void gcd_reduce(rational *c)
{  int b;
   b = rgcd(c->n, c->d);
   if (b>1)
   {  c->n /= b;
      c->d /= b;
   }
}

/* returns the numerator for a given denominator d */
static int rnum(rational *c, int d)
{  int n=(d/(c->d))*(c->n);
   free(c);
   return n;
}

static rational *rconst (int n, int d)
{  rational *c = (rational *)malloc(sizeof(rational));
   c->n = n;
   c->d = d;
   if (c->d > 1) gcd_reduce(c);
   return c;
}

static rational *rneg(rational *c)
{  c->n = -c->n;
   return c;
}

static rational *radd (rational *a, rational *b)
{  rational *c = (rational *)malloc(sizeof(rational));
   c->n = a->n * b->d  +  a->d * b->n;
   c->d = a->d * b->d;
   if (c->d > 1) gcd_reduce(c);
   free(a);
   free(b);
   return c;
}

static rational *rsub (rational *a, rational *b)
{  rational *c = (rational *)malloc(sizeof(rational));
   c->n = a->n * b->d  -  a->d * b->n;
   c->d = a->d * b->d;
   if (c->d > 1) gcd_reduce(c);
   free(a);
   free(b);
   return c;
}

static rational *rsub2 (rational *a, rational *b)
{  rational *c = (rational *)malloc(sizeof(rational));
   c->n = a->n * b->d  -  a->d * b->n;
   c->d = a->d * b->d;
   if (c->d > 1) gcd_reduce(c);
   free(a);
   /* do not free b */
   return c;
}

static rational *rmul (rational *a, rational *b)
{  rational *c = (rational *)malloc(sizeof(rational));
   c->n = a->n * b->n;
   c->d = a->d * b->d;
   if (c->d > 1) gcd_reduce(c);
   free(a);
   free(b);
   return c;
}

static rational *rdiv (rational *a, rational *b)
{  rational *c = (rational *)malloc(sizeof(rational));
   c->n = a->n * b->d;
   c->d = a->d * b->n;
   if (c->d > 1) gcd_reduce(c);
   free(a);
   free(b);
   return c;
}

/*---------------------------------------------------------------------*/
/* evaluate the coefficient for index i in an expression with node tree n */
/* uses rational arithmetic for rational coefficients */
/* n	node tree for expression to be evaluated */
/* i	index number of index being evaluated */
/* returns the rational coefficient */
/*---------------------------------------------------------------------*/
static rational	*eval(n, i)
node *n;
int  i;
{   if (!n) return 0;
    switch (n->type)
    {	case icons: return rconst(n->info.icons.value,1);
	case id:    return n->index==i ? rconst(1,1) : rconst(0,1);
	case xaddop:
	case addop:
	   if (!n->info.binop.r) return eval(n->info.binop.l,i);
	   return radd(eval(n->info.binop.l,i), eval(n->info.binop.r,i));
	case gtop:
	case geop:
	case eqop:
	case xsubop:
        case subop:
	   if (!n->info.binop.r) return eval(n->info.binop.l,i);
	   return rsub(eval(n->info.binop.l,i), eval(n->info.binop.r,i));
	case mulop:
	   return rmul(eval(n->info.binop.l,i), eval(n->info.binop.r,i));
	case divop:
	   return rdiv(eval(n->info.binop.l,i), eval(n->info.binop.r,i));
	case negop:
	   return rneg(eval(n->info.unop.c,i));
	case leop:
	case ltop:
	   return rsub(eval(n->info.binop.r,i), eval(n->info.binop.l,i));
	case absop:
	case proto:
	case list:
	case pol:
	case mat:
	case vec:
	case var:
	default:    yyerror("unknown node type");
    }
    return 0;
}

/*---------------------------------------------------------------------*/
/* computes the smallest denominator of an equation */
/* n	node tree of constraint or function */
/* den	smalled denominator of other equations */
/* size	number of indices */
/* returns the new lcd */
/*---------------------------------------------------------------------*/
static int lcd_eqn(n, den, size)
node    *n;
int     size;
{   int i;
    rational *c, *e;

    if (!n) return 1;
    c = eval(n, size);			/* evaluate the constant */
    den = (den*(c->d))/rgcd(den, c->d);
    for ( i=0; i<size; i++ )
    {   e = rsub2(eval(n,i), c);
        den = (den*(e->d))/rgcd(den, e->d);
	free(e);
    }
    free(c);
    return den;
}

/*---------------------------------------------------------------------*/
/* computes the coefficients of an equation and writes it to p  */
/* n	node tree of constraint or function */
/* p	write pointer where to write the result */
/* size	number of indices */
/* den	denominator to use */
/* returns the new write pointer */
/* if p is 0, do not write the array */
/*---------------------------------------------------------------------*/
/* static int *convert_eqn(n, p, size, den) */
static Value     *convert_eqn(n, p, size, den)
node    *n;
Value     *p;
int     size;
int	den;	/* denominator */
{   int i;
    rational *c, *d;

    if (!n || !p) return p;
    switch (n->type)
      {   
      case gtop: 
      case geop:
      case leop:
      case ltop:        /* *p++ = 1; */	
        value_set_si(*p,1);
        p++;
        break;/* an inequality */
      case eqop:	/* *p++ = 0; */	
        value_set_si(*p,0);
        p++;
        break;/* an equality */
      default:	/* its a transfer function */;
    }

    c = eval(n, size);			/* evaluate the constant */
    for ( i = 0; i < size; i++ )	/* for each index */
      {	d = rsub2(eval(n, i), c);	/* evaluate the index coefficent */
      /* *p++ = rnum(d, den); */
      value_set_si(*p,rnum(d, den));
      p++;
      }

    if ((n->type==ltop) || (n->type==gtop)) 
      { /* *p++ = rnum(c,den)-den; */
        value_set_si(*p,rnum(c,den)-den);
        p++;
      }
    else
      {/* *p++ = rnum(c,den); */
        value_set_si(*p,rnum(c, den));
        p++;
      }

    return p;
}

/*---------------------------------------------------------------------*/
/* convert parse tree of a list of constraints to matrix */
/* the same code is used for transfer functions */
/* now handels rational functions */
/* n	is the node tree of the constraints or transfer function */
/* dim	is the number of indices including parameters */
/* dim2 is 2 for constraints, 1 for transfer functions */
/* returns a node tree of a matrix */
/*---------------------------------------------------------------------*/
node    *convert_constraints(n, dim, dim2)
node    *n;
int     dim, dim2;
{   node *m, *r;
    int	rows, i, d;
    Value *p;

    /* error checking */
    if (!n) return (node *)0;
    if (n->type!=list)
    {  yyerror("convert_constraints: n is not a list");
       return (node *)0;
    }

    /* first pass (functions only), find the smallest common denominator */
    /* dim2 is 2 for constraints, 1 for transfer functions */
    if (dim2==1)
    {  d = 1;
       for (r=n->info.list.first; r; r=r->next) d = lcd_eqn(r, d, dim);
    }

    /* second pass, build the matrix */
    rows = n->info.list.count+2-dim2;
    m = new_node(mat);
    m->info.mat.m = Matrix_Alloc(rows,dim+dim2);
    m->info.mat.maxrows = rows;
    m->info.mat.ref_count = 0;
    m->info.mat.index = (node *)0;
    p =  m->info.mat.m->p_Init;
    for (r=n->info.list.first; r; r=r->next)
    {   if (dim2!=1) d = lcd_eqn(r, 1, dim); /* constraints: find lcd */
        p = convert_eqn(r, p, dim, d);
    }
    if (dim2==1) /* add row (0 0...0 d) for functions */
      {   
        for (i=0; i<dim; i++) 
          {  /* *p++ = 0; */
            value_set_si(*p,0);
            p++;
          }
        /* *p++ = d; */
        value_set_si(*p,d);
        p++;
    }
    m->info.mat.m->NbRows = rows;
    return m;
}

/* print t spaces */
static	void	tab(t)
int	t;
{   int i;
    for (i=0; i<t; i++) fputc(' ', yyout);
}

/* print a representation of node n as an ALPHA program */
void    print_alpha(n, t)
node *n;
int  t;
{   if (!n) return;
    if ((n->type!=icons) && (n->type!=id) && (n->type!=var) &&
	(n->type!=bcons) && (n->type!=rcons) && (n->type!=list) &&
	(n->type!=xaddop) && (n->type!=xsubop)) 
    {	fputc('\n', yyout);
	tab(t);
    }
    switch (n->type)
    {	case icons:
	    if (n->info.icons.infinity==0)
	      fprintf(yyout,"Alpha`const[%d]", n->info.icons.value);
	    else if (n->info.icons.value<0)
	      fprintf(yyout,"Alpha`const[-Infinity]");
	    else
	      fprintf(yyout,"Alpha`const[Infinity]");
	    break;
	case rcons:
	    fprintf(yyout,"Alpha`const[%d.%d]", n->info.icons.value,
					 n->info.icons.fraction);
	    break;
        case bcons:
            if (n->info.icons.value) fprintf(yyout,"Alpha`const[True]");
            else fprintf(yyout, "Alpha`const[False]");
            break;
	case id:
            fprintf(yyout, "\"%s\"", n->info.id.name);
            break;
        case var:
            fprintf(yyout, "Alpha`var[\"%s\"]", n->info.id.name);
            break;
	case parameter:
	    fprintf(yyout, "Alpha`parameter[\"%s\"]", n->info.id.name);
	    break;
	case iddef:
            fprintf(yyout, "Alpha`decl[\"%s\", ", n->info.id.name);
	    switch (n->info.id.type)
	    {	case inttype:	fprintf(yyout, "Alpha`integer"); break;
		case booltype:	fprintf(yyout, "Alpha`boolean"); break;
		case realtype:	fprintf(yyout, "Alpha`real"); break;
		case domtype:	fprintf(yyout, "Alpha`notype"); break;
		default:	fprintf(yyout, "Alpha`unknown"); break;
	    }
            if (n->info.id.coding)
              { fprintf(yyout, "[\"%s\",%d], " ,
                        n->info.id.coding->info.id.name,
                        n->info.id.length->info.icons.value);
                  }
            else
              { fprintf(yyout, ", "); };
	    if (n->info.id.domain)
	    {	print_alpha(n->info.id.domain, t+4); }
	    else fprintf(yyout, "Alpha`scalar");
            fputc(']', yyout);
            break;
	case xaddop:
	case xsubop: {
	    node *m;
	    int i, dim, *p;
	    fprintf(yyout, "Alpha`index[");
	    id_lookup(n->info.binop.index, n);
	    dim=n->info.binop.index->info.list.count;
	    p = (int *)malloc((dim+1)*sizeof(int));
	    convert_eqn(n,p,dim,1);	/* denominator = 1 */
	    m = (node *)0;
	    for (i=0; i<dim; i++)
	    {   if (p[i])
	    	{   m = convert_constraints(new_list(n),dim,1);
		    m->info.mat.index = n->info.binop.index;
	    	    if (m) print_alpha(m, t+4);
		    break;
		}
	    }
	    if (!m) fprintf(yyout, "%d", p[dim]);
	    free(p);
	    fputc(']', yyout);
	    break; }
	case addop:
	    fprintf(yyout, "Alpha`binop[Alpha`add, ");
bin1:	    print_alpha(n->info.binop.l,t+4);
	    fprintf(yyout, ", ");
	    print_alpha(n->info.binop.r,t+4);
	    fputc(']', yyout);
	    break;
        case subop:
            fprintf(yyout, "Alpha`binop[Alpha`sub, ");
	    goto bin1;
	case mulop:
            fprintf(yyout, "Alpha`binop[Alpha`mul, ");
            goto bin1;
	case divop:
            fprintf(yyout, "Alpha`binop[Alpha`div, ");
            goto bin1;
	case idivop:
            fprintf(yyout, "Alpha`binop[Alpha`idiv, ");
            goto bin1;
	case modop:
            fprintf(yyout, "Alpha`binop[Alpha`mod, ");
            goto bin1;
	case negop:
            fprintf(yyout, "Alpha`unop[Alpha`neg, ");
un1:        print_alpha(n->info.unop.c, t+4);
            fputc(']', yyout);
            break;
	case sqrtop:
	    fprintf(yyout, "Alpha`unop[Alpha`sqrt, ");
	    goto un1;
	case absop:
            fprintf(yyout, "Alpha`unop[Alpha`abs, ");
	    goto un1;
	case eqop:
            fprintf(yyout, "Alpha`binop[Alpha`eq, ");
            goto bin1;
	case leop:
            fprintf(yyout, "Alpha`binop[Alpha`le, ");
            goto bin1;
	case ltop:
            fprintf(yyout, "Alpha`binop[Alpha`lt, ");
            goto bin1;
	case gtop:
            fprintf(yyout, "Alpha`binop[Alpha`gt, ");
            goto bin1;
	case geop:
            fprintf(yyout, "Alpha`binop[Alpha`ge, ");
            goto bin1;
	case neop:
            fprintf(yyout, "Alpha`binop[Alpha`ne, ");
            goto bin1;
	case orop:
            fprintf(yyout, "Alpha`binop[Alpha`or, ");
            goto bin1;
	case xorop:
            fprintf(yyout, "Alpha`binop[Alpha`xor, ");
            goto bin1;
	case andop:
            fprintf(yyout, "Alpha`binop[Alpha`and, ");
            goto bin1;
	case minop:
            fprintf(yyout, "Alpha`binop[Alpha`min, ");
            goto bin1;
	case maxop:
            fprintf(yyout, "Alpha`binop[Alpha`max, ");
            goto bin1;
	case notop:
            fprintf(yyout, "Alpha`unop[Alpha`not, ");
            goto un1;
	case restrictop:
	    fprintf(yyout, "Alpha`restrict[");
	    goto bin1;
	case loopop:
	    fprintf(yyout, "Alpha`loop[");
	    goto bin1;
	case affineop:
	    fprintf(yyout, "Alpha`affine[");
	    goto bin1;
	case ifop:
	    fprintf(yyout, "Alpha`if[");
	    print_alpha(n->info.triop.l,t+4);
	    fprintf(yyout, ", ");
	    print_alpha(n->info.triop.c,t+4);
	    fprintf(yyout, ", ");
	    print_alpha(n->info.binop.r,t+4);
	    fputc(']', yyout);
	    break;
	case reduce:
	    fprintf(yyout, "Alpha`reduce[");
	    switch (n->info.reduce.op)
	    {	case addop: fprintf(yyout, "Alpha`add, "); break;
		case mulop: fprintf(yyout, "Alpha`mul, "); break;
		case andop: fprintf(yyout, "Alpha`and, "); break;
		case orop:  fprintf(yyout, "Alpha`or, ");  break;
		case xorop: fprintf(yyout, "Alpha`xor, "); break;
		case maxop: fprintf(yyout, "Alpha`max, "); break;
		case minop: fprintf(yyout, "Alpha`min, "); break;
		default: fprintf(yyout, "Alpha`unknown, "); break;
	    };
	    print_alpha(n->info.reduce.proj, t+4);
	    fprintf(yyout, ", ");
	    print_alpha(n->info.reduce.exp, t+4);
	    fputc(']', yyout);
	    break;
	case equateop:
	    fprintf(yyout, "Alpha`equation[");
	    goto bin1;
	case callop:
	    fprintf(yyout, "Alpha`call[");
	    goto bin1;
	case use:
	    fprintf(yyout, "Alpha`use[");
	    print_alpha(n->info.use.name, t+4);
	    fprintf(yyout, ", \n"); tab(t+4);
	    fprintf(yyout, "(* extension domain *)  ");
	    print_alpha(n->info.use.extdom, t+4);
	    fprintf(yyout, ", \n"); tab(t+4);
	    fprintf(yyout, "(* parameter assignments *)  ");
	    print_alpha(n->info.use.param, t+4);
	    fprintf(yyout, ", \n"); tab(t+4);
	    fprintf(yyout, "(* input arguments *)\n");tab(t+4);
	    print_alpha(n->info.use.inputs, t+4);
	    fprintf(yyout, ", \n"); tab(t+4);
	    fprintf(yyout, "(* return variables *)  ");
	    print_alpha(n->info.use.outputs, t+4);
	    fputc(']', yyout);
	    break;
	case caseop:
	    fprintf(yyout, "Alpha`case[");
	    goto un1;
	case inpsop:
	    fprintf(yyout, "{ (* input variables *)");
	    goto lis2;
	case outsop:
	    fprintf(yyout, "{ (* output variables *)");
	    goto lis2;
	case locsop:
	    fprintf(yyout, "{ (* local variables *)");
	    goto lis2;
	case letop:
	{   node *e;
	    if (do_let) fprintf(yyout, "Alpha`let[");
            else fprintf(yyout, "{ (* let *)");
	    e=n->info.list.first;
	    if (e)
	    {	print_alpha(e, t);
		for (e=e->next; e; e=e->next)
		{   fprintf(yyout, ", ");
		    print_alpha(e, t);
		}
	    }
	    if (do_let) fputc(']', yyout); else fputc('}', yyout);
	    break;
        }
	case list:
        {   node *e;
	    fputc('{', yyout);
lis2:	    e=n->info.list.first;
	    if (e)
	    {	print_alpha(e, t);
		for (e=e->next; e; e=e->next)
		{   fprintf(yyout, ", ");
		    print_alpha(e, t);
		}
	    }
	    fputc('}', yyout);
	    break;
	}
	case sys:
	{   fprintf(yyout,
                    "Alpha`system[\"%s\",\n", n->info.sys.name->info.id.name);
	    tab(t+4);
            fprintf(yyout, "(* parameter space *)");
	    print_alpha(n->info.sys.param, t+4);
	    fputc(',', yyout);
	    print_alpha(n->info.sys.inputs, t+4);
	    fputc(',', yyout);
	    print_alpha(n->info.sys.outputs, t+4);
	    fputc(',', yyout);
	    print_alpha(n->info.sys.locals, t+4);
	    fputc(',', yyout);
            print_alpha(n->info.sys.equations, t+4);
	    fputc(']', yyout);
	    fputc('\n', yyout);
	    break;
	}
	case pol:
	{   Polyhedron *p;
        node *zp;
	    int i, j;
	    if (!n->info.pol.p) {  fprintf(yyout, "Alpha`domain[]"); break; }
	    fprintf(yyout, "Alpha`domain[%d, ", n->info.pol.p->Dimension);
	    print_alpha(n->info.pol.index, t+8);
            fprintf(yyout, ",");
            if (n->info.pol.m)	fputc('{', yyout);   /* in a zpol, there
                                                          is an additionnal
                                                          level of curly
                                                          brackets */
	    for (zp = n; zp; zp = zp->next)
              {	
              if (zp->info.pol.m)	/* z-polyhedron this is the only case where
                                           the zp->next is may not be null*/
                {
                  tab(t+4);
                  fprintf(yyout, "Alpha`zpol[");
                  print_alpha(zp->info.pol.m, t+8);
                  fprintf(yyout, ", {\n");  /* begin the pol list for in the zpol */
                }
              else
                {
                  fprintf(yyout, " {\n");  /* begin the pol list for in the pol */
                };
              for (p = zp->info.pol.p; p; p = p->next)
                {			
                  tab(t+8);
                  fprintf(yyout, "Alpha`pol[");
                  if (!p) { fputc(']', yyout); break; }
                  fprintf(yyout, "%d, %d, %d, %d, {",
                          p->NbConstraints, p->NbRays, p->NbEq, p->NbBid );
                  for (i=0; i<p->NbConstraints;i++)
                    {   fputc('\n', yyout);
                    tab(t+12);
                    fprintf(yyout,"{");
                    value_print(yyout,VALUE_FMT,p->Constraint[i][0]);
                    for (j=1; j<=p->Dimension+1; j++) {
                      fprintf(yyout,", ");
                      value_print(yyout,VALUE_FMT,p->Constraint[i][j]);
                    }
                    if ( i< (p->NbConstraints-1) ) fprintf(yyout, "},");
                    else fprintf(yyout, "}");
                    }
                  fprintf(yyout, "},{");
                  for (i=0; i<p->NbRays; i++)
                    {   fputc('\n', yyout);
                    tab(t+12);
                    fprintf(yyout,"{");
                    value_print(yyout,VALUE_FMT,p->Ray[i][0]);
                    for (j=1; j<=p->Dimension+1; j++) {
                      fprintf(yyout,", ");
                      value_print(yyout,VALUE_FMT,p->Ray[i][j]);
                    }  
                    if ( i< (p->NbRays-1) ) fprintf(yyout, "},");
                    else fputc('}', yyout);
                    }
                  fprintf(yyout, "}]");
                  if (p->next) fputc(',', yyout); /* next pol in one zpol */
                }
              fprintf(yyout, "}"); /* end of pol list in one zpol */	
              if (zp->info.pol.m)
                {	
                  fprintf(yyout, "\n");
                  tab(t+4);
                  fprintf(yyout, "]");  /* zpol and zpol_list */
                  if (zp->next) fputc(',', yyout);
                  else    fprintf(yyout, "}");		/* end zpol list */   
                }
              }
	    fprintf(yyout, "\n");
	    tab(t);
            fprintf(yyout, "]");		/* end domain */
	    break;
	}
	case mat:
	{   int i, j;
	    Matrix *m;
	    fprintf(yyout, "Alpha`matrix[");
	    m = n->info.mat.m;
	    if (!m) { fputc(']', yyout); break; }
	    fprintf(yyout, "%d, %d, ", m->NbRows, m->NbColumns);
	    print_alpha(n->info.mat.index, t+8);
	    fprintf(yyout, ", {");

	    if (m->NbRows>0)
	    {   i=0;
	        fputc('\n', yyout);
	        tab(t+4);
		fprintf(yyout,"{");
	        value_print(yyout,VALUE_FMT,m->p[i][0]);
	        for (j=1; j<m->NbColumns; j++) {
		  fprintf(yyout,", ");
		  value_print(yyout,VALUE_FMT,m->p[i][j]);
		}
	        fputc('}', yyout);
	    }
	    for (i=1; i< m->NbRows; i++)
	    {	fprintf(yyout, ",\n");
	        tab(t+4);
		fprintf(yyout,"{");
		value_print(yyout,VALUE_FMT,m->p[i][0]);		
		for (j=1; j<m->NbColumns; j++) {
		  fprintf(yyout,", ");
		  value_print(yyout,VALUE_FMT,m->p[i][j]);
		}  
		fputc('}', yyout);}
		  
            fprintf(yyout, "}]");
	    break;
	}
	default:
            fprintf(yyout, "Alpha`unknown[%d]", n->type);
            break;
    }
}


