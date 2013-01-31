/*  file: $MMALPHA/sources/Write_Alpha/node2item.c
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
#include <stdio.h>
#include <stdlib.h>
#include "item.h"
#include "itemprocs.h"
#include "node.h"
#include "nodeprocs.h"

extern int latexLayout;
#define OW_le ((latexLayout == 1) ? "$\\le$" : "<=")
#define OW_lt ((latexLayout == 1) ? "$<$" : "<")
#define OW_ge ((latexLayout == 1) ? "$\\ge$" : ">=")
#define OW_gt ((latexLayout == 1) ? "$>$" : ">")
#define OW_ne ((latexLayout == 1) ? "$<>$" : "<>")

/*------------------------------------------------------------------*/
/* printing system                                                  */
/*------------------------------------------------------------------*/

/* print an id without quotes */
void print_name(n)
node   *n;
{
   char           *c;
   if (n->type != id) return;
   for (c = n->the.id.name + 1; *c; )
   {  if (*c == '\\')
      {  printf("%c%c", *c, *(c + 1));
	 c += 2;
	 continue;
      }
      if (*c == '"' ) break;
      printf("%c", *c);
      c++;
   }
}

int sprint_name(txt, n)
char   *txt;
node   *n;
{
   char           *c,*c1;
   if (n->type != id) return 0;
   for (c1 = c = n->the.id.name + 1;*c;)
   {  if (*c == '\\')
      {  *txt++ = *c++;
         *txt++ = *c++;
         continue;
      }
      if ((*c=='_') && latexLayout) *txt++ = '\\';
      if (*c == '"') break;
      *txt++ = *c++;
   }
   *txt = '\0';
   return c-c1;
}

/* sprint_con(t,a,Z,d,C) */
/* prints text for an affine expression */
/*	t :	output string pointer             */
/*	a :	node list of coefficients         */
/*	Z :	node list of indices              */
/*	d :	denominator			  */
/*	C :	control flags                     */
/*		1: put '*' in for multiplications */
/*		2: put parentheses around indices */
/* returns the number of characters written       */
static int sprint_con(t,a,Z,d,C)
     node   *a, *Z;
     char   *t;
     int    d;
     int    C;
{ int flag;
  node *p, *q;
  char *t1, *txt;
  char c[128];

  txt = c;
  flag=0;
  for (p = a, q = Z->the.list.first; p; p = p->next, q = q ? q->next : 0) 
  {   if (!q && p->next) continue;
      if ((p->the.number.value == 0) && (q || flag) ) continue;
      if (p->the.number.value == 0) sprintf(txt,"0");
      else if (p->the.number.value > 0) 
      { if (flag != 0) {sprintf(txt,"+"); txt+=1; }
        if ((p->the.number.value != 1) || !q)
        {  sprintf(txt,"%d", p->the.number.value);
           txt += strlen(txt);
	   if ((C&1) && q) {sprintf(txt,"*"); txt+=1;}
	}
        if (q)
        {  if (C&2) {sprintf(txt,"("); txt+=1; }
           txt += sprint_name(txt, q);
           if (C&2) {sprintf(txt,")"); txt+=1; }
        }
      }
      else if (p->the.number.value < 0) 
      { if ((p->the.number.value != -1) || !q )
        { sprintf(txt,"%d", p->the.number.value);
          txt += strlen(txt);
	  if ((C&1) && q) {sprintf(txt,"*"); txt+=1;}
	}
        if ((p->the.number.value == -1) && (q))
        {  sprintf(txt,"-"); txt+=1; }
        if (q)
        {  if (C&2) {sprintf(txt,"("); txt+=1; }
           txt += sprint_name(txt, q);
           if (C&2) {sprintf(txt,")"); txt+=1; }
        }
      }
      flag++;
  }

  if (d!=1)				/* add denominator */
  { if (flag>1) sprintf(t, "(%s)/%d", c, d);
    else sprintf(t, "%s/%d", c, d);
  }
  else if (c==txt) sprintf(t,"0");	/* empty affine */
  else sprintf(t, "%s", c);		/* normal affine */
  return strlen(t);
}

/*-------------------------------------------------------------------*/
/* utility procedures                                                */
/*-------------------------------------------------------------------*/

/* look up a node name in an alpha system                            */
/* returns the node list of the indices from the declaration domain  */
node *get_dom(in, alpha)
node *in;
node *alpha;
{ node *l, *current;
  char *comparison;
  int i;
  for(i=0;i<3;i++)
  {  if      (i==0)    l = alpha->the.sys.in;
     else if (i==1)    l = alpha->the.sys.out;
     else /* (i==2) */ l = alpha->the.sys.local;
     for(current=l->the.list.first; current; current=current->next)
     {  comparison = current->the.decl.id->the.id.name;
        if (strcmp(comparison, in->the.id.name)==0) 
	   return current->the.decl.domain->the.dom.index;
     }
   }
}

/* convert a node list of id's into a list of items   */
item *id_list(in)
node *in;
{  item *out=(item *)0, *last=(item *)0, *tmp=(item *)0;
   node *p;
   if (in)
   { for(p=in->the.list.first; p; p=p->next)
     {  tmp = new_item(text);
        sprint_name(tmp->the.text.string, p);
        if (!out) out = last = tmp;
        else { last->next = tmp; last = tmp; }
     }
   }
   else 
   { tmp = Text("");
     out = tmp;
   }
   return out;
}

/* convert a node list of id's into a list of items   */
/* omit the last n context items                      */ 
item *id_list2(in,n)
node *in;
int n;
{  item *out=(item *)0, *last=(item *)0, *tmp=(item *)0;
   node *p;
   int count, i;
   if (in && n==0) return id_list(in);
   else if (in) 
   {  count = in->the.list.count - n;
      for(p=in->the.list.first, i=0; p && i<count; p=p->next, i++)
      {  tmp = new_item(text);
         sprint_name(tmp->the.text.string, p);
         if (!out) out = last = tmp;
         else { last->next = tmp; last = tmp; }
      }
   }
   else return Text("");
   return out;
}

/*------------------------------------------------------------------*/
/* matrix formatting system                                         */
/*------------------------------------------------------------------*/

/* convert_affine: converts a node tree to a comma separated */
/*                 item list of affine expessions            */
/* Z : node list of indices                                  */
/* X : node list of equations                                */
/* n : number of context indices and equations to omit       */
/* C :	control flags                                    */
/*		1: put '*' in for multiplications                */
/*		2: put parentheses around indices                */
item *convert_affine(Z,X,n,C)
node *Z, *X;
int n, C; 
{ item *tmp2, *head2, *tail2;
  node *Y, *p;
  int count,i,d;

  /* get the denominator d */
  for (Y = X->the.list.first; Y && Y->next; Y = Y->next) /* do nothing */;
  for (p = Y->the.list.first; p && p->next; p = p->next) /* do nothing */;
  if (p && (p->the.number.value != 1)) d = p->the.number.value;
  else d = 1;
  
  head2 = tail2 = (item *) 0;
  /* take the last n off the end by not processing them */
  count = X->the.list.count - n;
  for (Y = X->the.list.first, i=1; Y && Y->next && i<count; Y = Y->next, i++) 
  { tmp2 = new_item(text);
    sprint_con(tmp2->the.text.string,Y->the.list.first,Z,d,C);
    if (head2) { tail2->next = tmp2; tail2 = tmp2; }
    else { head2 = tail2 = tmp2; };
  }
  return Hsep(0,",",head2);
}

/* convert_mat : convert the node tree for a matrix to an item tree */
/*               for a matrix of the form (i,j,...->i+j, ...) */
/* Z : node list of indices                                   */
/* X : node list of equations                                 */
/* n : number of context indices to omit                      */
/* m : number of context equations to omit                    */
item *convert_mat(Z,X,n,m)
node *Z, *X;
int n,m;
{ item *first;
  first = convert_affine(Z,X,m,0);
  if (latexLayout==1)
    return Henc(4, Text("("), Text(")"),
             Hsep2(0, " $\\rightarrow$ ", Hsep(0, "," , id_list2(Z,n)), first));
  else
    return Henc(4, Text("("), Text(")"),
             Hsep2(0, "->", Hsep(0, "," , id_list2(Z,n)), first));
}

/* spec_mat : convert the node tree for a matrix to an item tree */
/*               for a matrix of the form [i+j, ...]          */
/* Z : node list of indices                                   */
/* X : node list of equations                                 */
/* n : number of context indices and equations to omit        */
item *spec_mat(Z,X,n)
node *Z, *X;
int n;
{ 
  return Henc(4, Text("["), Text("]"), convert_affine(Z,X,n,0));
}

/* convert_param_assign : convert the node tree for a matrix  */
/*               to an item tree for a matrix of the form */
/*               <i,j,... i+j, ...>  use_flag=1 */
/*               <i,j,...->i+j, ...> use_flag=0 */
/* Z : node list of indices                                   */
/* X : node list of equations                                 */
/* n : number of context indices and equations to omit        */
item *convert_param_assign(Z,X,n,use_flag)
node *Z, *X;
int n, use_flag;
{ item *first;
  first = convert_affine(Z,X,0,0);
  if (use_flag)
    return Henc(4, Text("<"), Text(">"),
                Hsep2(0, "", Hsep(0, "," , id_list2(Z,n)), first));
  else
    return Henc(4, Text("<"), Text(">"),
                Hsep2(0, "->", Hsep(0, "," , id_list2(Z,n)), first));
}

/*-------------------------------------------------------------------*/
/* polyhedron formatting system                                      */
/*-------------------------------------------------------------------*/

/* swap a two item list */
static item *swap(head2)
item *head2;
{ int count;
  item *temp, *p;

 /* count number of items in list, if greater than two report error */
  for (count=1, p = head2; p ; p = p->next, count++);
  if (count != 2) fprintf(stderr, "SWAP : More than two items on list.");
  else 
  { temp = head2;
    head2 = temp->next;
    head2->next = temp;
    temp->next = (item *)0;
  }
  return head2;
}

/* convert node list for indices Z and node tree for domain X into */
/* semicolon separated item trees of constraints */
static item *minimise(Z,X)
node  *Z, *X;
{ node **T;
  int count, idnum, updated, i, j, cflag, curval, flag;
  node *p, *p1, *q, *s, *n;
  item *head1,*tail1,*head2,*tail2,*head3,*tail3,*tmp1,*tmp2,*tmp3;
  char *txt;

  idnum = Z->the.list.count; /* count the number of ids in the list Z */

  /* Initialise arrays to be empty */
  T = (node **)malloc((idnum+1)*sizeof(node *));
  for (i=0; i<(idnum+1); i++)
  { T[i] = (node *)malloc(3*sizeof(node));
    for (j=0; j<3; j++)
    { T[i][j].type = list;
      T[i][j].the.list.count = 0;
      T[i][j].the.list.first = (node *)0;
      T[i][j].the.list.last = (node *)0;
    }
  }

  if (Z->the.list.count<1)
  { add_to_list(&T[0][0],X->the.list.first);
    X->the.list.first=X->the.list.first->next;
  }
  for (p=X->the.list.first; p; p=p1)
  { /* walk down p list, ie a single constraint */
    p1 = p->next;
    for (count=1,s=p->the.list.first, q=p->the.list.first->next, cflag=0;
         (q && !cflag && count<=idnum); q=q->next, count++)
    { curval = q->the.number.value;
      if (curval == 1 || curval == -1)
      { /* negate all values in list if value is +ve */
        if (curval == 1)
        { for (n=p->the.list.first->next; n; n=n->next)
            n->the.number.value = (-1)*n->the.number.value;
        }
        /* zorch the id value */
        q->the.number.value = 0;
        /* place constraints in appropriate bins */
        if (s->the.number.value == 0) add_to_list(&T[count][0],p);
        if (s->the.number.value == 1)
        { if (curval == 1) add_to_list(&T[count][1],p);
          else add_to_list(&T[count][2],p);
        }
        cflag=1;
      }
    }
    if (!cflag) /* place in sink at equals position */ add_to_list(&T[0][0],p);
  }

  /* walk down list and create strings and items, to accomodate new output */
  head1 = tail1 = (item *)0;
  for (count=1,q=Z->the.list.first;count<=idnum;q=q->next,count++)
  { if (T[count][0].the.list.count>0)
    { head2 = tail2 = new_item(text);
      sprint_name(head2->the.text.string,q);
      for (n=T[count][0].the.list.first; n; n=n->next)
      { tmp3 = new_item(text);
        sprint_con(tmp3->the.text.string,n->the.list.first->next,Z,1,0);
        tail2->next = tmp3; tail2 = tmp3;
      }
      tmp2 = Hsep(0,"=",head2);
      if (head1) { tail1->next = tmp2; tail1 = tmp2;}
      else {head1 = tail1 = tmp2;}
    }
    /* lower bounds */
    head2 = tail2 = (item *)0;
    if (T[count][1].the.list.count>0)
    { head3 = tail3 = (item *)0;
      for (n=T[count][1].the.list.first; n; n=n->next)
      { tmp3 = new_item(text);
        sprint_con(tmp3->the.text.string,n->the.list.first->next,Z,1,0);
        if (head3) { tail3->next = tmp3; tail3 = tmp3;}
        else {head3 = tail3 = tmp3;}
      }
      if (T[count][1].the.list.count>1)
      { tmp3 = Henc(0, Text("("), Text(")"),
                  Hsep(0,",",head3));
      } else tmp3 = head3;
      if (head2) { tail2->next = tmp3; tail2 = tmp3;}
      else {head2 = tail2 = tmp3;}
    }

    /* var */
    if (T[count][1].the.list.count>0 || T[count][2].the.list.count>0)
    { tmp3 = new_item(text);
      sprint_name(tmp3->the.text.string,q);
      if (head2) { tail2->next = tmp3; tail2 = tmp3;}
      else {head2 = tail2 = tmp3;}
    }
    /* upper bounds */
    if (T[count][2].the.list.count>0)
         { head3 = tail3 = (item *)0;
           for (n=T[count][2].the.list.first; n; n=n->next)
          { tmp3 = new_item(text);
            sprint_con(tmp3->the.text.string,n->the.list.first->next,Z,1,0);
            if (head3) { tail3->next = tmp3; tail3 = tmp3;}
            else {head3 = tail3 = tmp3;}
          }
          if (T[count][2].the.list.count>1)
          { tmp3 = Henc(0, Text("("), Text(")"),
                      Hsep(0,",",head3));
          } else tmp3 = head3;
          if (head2) { tail2->next = tmp3; tail2 = tmp3;}
          else {head2 = tail2 = tmp3;}
    }
    if (head2)
    { tmp2 = Hsep(0,OW_le,head2);
      if (head1) { tail1->next = tmp2; tail1 = tmp2;}
      else {head1 = tail1 = tmp2;}
    }
  }
  /* other constraints from sink */
  if (T[0][0].the.list.count>0)
  { for (n = T[0][0].the.list.first; n; n = n->next)
    {  int geflag;

       head3 = new_item(text);
       sprint_con(head3->the.text.string,n->the.list.first->next,Z,1,0);

         /* make the expression into an equation */
         tmp3 = new_item(text);
         txt = tmp3->the.text.string;
         geflag=0;
         if (n->the.list.first->the.number.value == 0) sprintf(txt,"=0");
         else  { geflag=1; sprintf(txt,"%s0", OW_ge); }

         /* put tmp3 on the list */
         head3->next = tmp3;
         /* end compute body of tmp2 */

         /* detect and eliminate positivity constraint */
         /* ASSUME: positivity constraint is last eqn in list */
         if (head3->the.text.string[0]=='1' && geflag && head1 )
         {  free(head3); free(tmp3);
            continue;
         }

         tmp2 = Hsep(0,"",head3);
         if (head1) { tail1->next = tmp2; tail1 = tmp2; }
         else { head1 = tail1 = tmp2; };
      }
  }
  return Hsep(0,"; ", head1);
}

/* convert domain X with indices Z into item tree for domain */
/* Z :	indices node list */
/* n :	number of indices in context */
/* X :	node tree of polyhedron */
item *convert_pol2(Z,X,n)
node   *Z, *X;
int n;
{
  if (latexLayout)
    return  Henc(4, Text("\\{"), Text("\\}"),
	       Hsep2(4,"~$|$~", 
	          Hsep(0,",",id_list2(Z,n)),
	          minimise(Z,X)
	       )
	    );
  else
    return  Henc(4, Text("{"), Text("}"),
	       Hsep2(4," | ", 
	          Hsep(0,",",id_list2(Z,n)),
	          minimise(Z,X)
	       )
	    );
}

/* convert Z domain X with matrix M and indices Z into item tree for */
/* z-domain */
item *convert_zpol(Z,M,X)
node	*Z,*X;
item	*M;
{  
  if (latexLayout)
    return  Henc(4, Text("\\{"), Text("\\}"),
	       Hsep2(4,"~$|$~", M, minimise(Z,X) )
	    );
  else
    return  Henc(4, Text("{"), Text("}"),
	       Hsep2(4," | ", M, minimise(Z,X) )
	    );
}
