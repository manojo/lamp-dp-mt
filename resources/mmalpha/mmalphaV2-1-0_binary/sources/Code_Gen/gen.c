/* gen.c
     COPYRIGHT
          Both this software and its documentation are

              Copyright 1995,1996,1997,1998 by Brigham Young University,
              Provo, Utah; all rights reserved.

          Permission is granted to copy, use, and distribute
          for any commercial or noncommercial purpose under the terms
          of the GNU General Public license, version 2, June 1991
          (see file : LICENSING).
*/

#include <stdio.h>
#include <string.h>
#include "../Write_Alpha/item.h"
#include "../Write_Alpha/itemprocs.h"
#include "../Write_Alpha/writeitem.h"
#include <polylib/polylib.h>
#include "node.h"
#include "nodeprocs.h"
#include "gen.h"

/* #define DEBUG */
#define INDENT	3
extern FILE *yyout;
extern int lineNb;

/*-------------------------------------------------------------------*/
/*                      index tracking system                        */
/*-------------------------------------------------------------------*/

typedef struct inode_
        { char *name;
          int status;		/* FREE, FIXED, SUBST, or CONST */
          int stamp;		/* the order in which index was fixed */
          int constant;
          int coef;		/* name = coef * sub->name + constant */
          node *sub;		/* id of substitution index */
          struct inode_ *next;
        } inode;

#define FREE  1
#define FIXED 2		/* equation i = 2k + +3j +1 */
#define SUBST 3		/* sub i with 2k - 5 */
#define CONST 4		/* sub i with 2 */
/* note: global parameters are always fixed indices */

static inode *idict = (inode *)0;
static int   index_stamp = 0;		/* the current stamp number */


/*-------------------------------------------------------------------*/
/* strcmp_end(a,b,c)                                                 */
/*        a: 0 ended string                                          */
/*        b: c ended string                                          */
/*        c: char ending b string                                    */
/* Compare strings a and b, assuming c is an ending char for b       */
/* returns 0 if strings are equal, else 1                            */
/*-------------------------------------------------------------------*/
int strcmp_end(a,b,c)
const char *a;
const char *b;
const char c;
{
  const char *p1=b,*p2=a;
  while ((*p1)&&(*p2)&&(*p1!=c)&&(*p1==*p2))
    { p1++;p2++; }
  if ((*p2==0)&&((*p1==c)||(*p1==0)))
    return 0;
  else
    return 1;
}

static inode *lookup_index(id)
node *id;
{  inode *i;

   for(i=idict; i; i=i->next)
      if (!strcmp_end(i->name, id->the.id.name,':'))
         return i;
   return (inode *) 0;
}

/*-------------------------------------------------------------------*/
/* index_restore(x)                                                  */
/*        x : stamp number                                           */
/* Any index with a stamp number > x is (re)set to FREE              */
/*-------------------------------------------------------------------*/
void index_restore(x)
int x;
{  inode *i;

   for(i=idict; i; i=i->next)
   {  if (i->stamp > x) { i->status = FREE; i->stamp = 0; } }
   index_stamp = x;
}

/*-------------------------------------------------------------------*/
/* mark_index(id,status)                                             */
/*        id : the id node of an index                               */
/*    status : an index status                                       */
/* Set the index status of index to status.  If index is not in      */
/* dictionary, it is added.  Used to Initialize indicies.            */
/*-------------------------------------------------------------------*/
void mark_index(id, status)
node *id;
int status;
{  inode *i;
   char *p;

   if (!id)
   {  fprintf(stderr, "?mark_index: null id\n");
      return;
   }
   for(i=idict; i; i=i->next) if (!strcmp_end(i->name, id->the.id.name, ':')) break;

   if (!i) /* id is not in dictionary --- make a new entry for it */
   { 
     i = (inode *)malloc(sizeof(inode));
      if (!i) { yyerror("out of memory"); exit(-1); }
      i->name = (char *) malloc(strlen(id->the.id.name)+2);
      if (!i->name) { yyerror("out of memory"); exit(-1); }
      if ((p=strchr(id->the.id.name, ':'))!=0)
      {  strncpy(i->name, id->the.id.name,
           p - id->the.id.name ); /* copy the string */
           i->name[p - id->the.id.name]='\0';
      }
      else
      {  strcpy(i->name, id->the.id.name);
      }
      i->next = idict;
      idict = i;
   }

   i->status = status;
   if (status!=FREE) i->stamp = (++index_stamp);
   else i->stamp = 0;
}

/*-------------------------------------------------------------------*/
/* declare_indices()                                                 */
/* returns an item tree to declare all of the free indices           */
/*-------------------------------------------------------------------*/
item *declare_indices()
{  item *out, *last, *tmp;
   inode *i;

   out = (item *) 0;

   for(i=idict; i; i=i->next)
   {   /* id is in dictionary */
       if (i->status==FREE)
       {  tmp = Text(i->name);
          if (!out)   out = tmp;
          else last->next = tmp;
          last = tmp;
       }
   }
   if (out) return Hsep3(0, " ", Text("int"), Hsep(0,", ",out), Text(";\n") );
   else return Text("/* no indices */");
}

static int index_status(n)
node *n;
{  inode *i;
   if (!n) return(CONST);     /* no index name --> constant term */
   if (n->type!=id)
   {  fprintf(stderr, "index_status: ?n is not an id node\n");
      return(FREE);
   }
   for(i=idict; i; i=i->next) if (!strcmp_end(i->name, n->the.id.name, ':'))
     return(i->status);  /* if in dictionary */
   fprintf(stderr, "index_status: ? index %s is not in index dictionary\n",
           n->the.id.name);
   return(FREE);         /* if not in dictionary */
}

static int index_type(n)
node *n;
{  inode *i;
   char *p;
   if (!n) return(-1);    
   if (n->type!=id)
     {  
       fprintf(stderr, "index_type: ?n is not an id node\n");
       return(-1);
     }
   if ((p=strchr(n->the.id.name, ':'))!=0)
     {    
       p++;
       return(atoi(p));
     }
   else
     return 0;
}
 
/*---------------------------------------------------------------------*/
/* int * indices_types(l)                                              */
/*   l is a list of ID nodes                                           */
/*   allocate and returns an array of integer which contains the       */
/*   type of indices in l (same order)                                 */
/*---------------------------------------------------------------------*/
int * indices_types(node *l)
{
  node *p;
  int count,i;
  int *array;
  if (l->type == list) 
    p = l->the.list.first;
  else
    { fprintf(stderr,"? indices_type : node is not a list\n");
      return ((int *)NULL);
    }
  count = l->the.list.count;
  array = (int *)malloc(count*sizeof(int));
  if (!array)
    { fprintf(stderr,"! indices_type : could not malloc\n");
      exit(1);
    }
  for (i=1; i<=count; i++,p=p->next)
    array[i-1] = index_type(p);
  return (array);
}

/*---------------------------------------------------------------------*/
/* int nth_index_type(nb,l)                                            */
/*   returns the type of the nb-th indice of the list l                */
/*---------------------------------------------------------------------*/
int nth_index_type(int nb,node *l)
{
  node *p;
  int i=1;
  if (l->type==list) 
    p=l->the.list.first;
  else
    { fprintf(stderr,"? indice_type : node is not a list\n");
      return (-1);
    }
  while (i<nb) {
    p=p->next;
    i++;
  }
  return (index_type(p));
}

/*-------------------------------------------------------------------*/
/*                         Global Variables                          */
/*-------------------------------------------------------------------*/

char    begcom[]="/* ",endcom[]=" */";       /* C program comments */
extern int G_dim;	/* Number of global parameters (yacc.y)  */


/*-------------------------------------------------------------------*/
/*                    Code Generation Procedures                     */
/*-------------------------------------------------------------------*/

/*-------------------------------------------------------------------*/
/* sprint_name(txt, n)                                               */
/*	txt :	output string pointer                                */
/*      n   :   node pointer to an id                                */
/* copy the index name in n to txt                                   */
/* returns the number of characters written                          */
/*-------------------------------------------------------------------*/
int sprint_name(txt, n)
char   *txt;
node   *n;
{
   register char *c, *t;
   if (n->type != id)
   {  fprintf(stderr, "sprint_name: ? not an id node\n");
      return 0;
   }
   c = n->the.id.name;
   t = txt;
   while ((*c)&&(*c!=':')) *t++ = *c++;
   *t = '\0';
   return c-n->the.id.name;
}

/*-------------------------------------------------------------------*/
/* sprint_con(txt,a,len,Z,C)                                         */
/*	txt :	output string pointer                                */
/*	a :	vector of coefficients                               */
/*    len :     number of coefficients (including constant)          */
/*	Z :	node list of indices                                 */
/*	C :	control flags                                        */
/*		1: put '*' in for multiplications                    */
/*		2: put parentheses around indices                    */
/*		4: add modulo operator                               */
/* returns the number of characters written                          */
/*-------------------------------------------------------------------*/
int sprint_con(txt,a,len,Z,C)
     char  *txt;
     int   *a;
     int    len;
     node  *Z;
     int    C;
{ int i, flag;
  node *q;
  char *c;
  int p;
  int type;

  c = txt;
  flag=0;	/* something has been printed already */
  for (i=0, q=Z->the.list.first; i<len; i++, q=(q ? q->next : 0) ) 
    { p = a[i];
      if (!q && i<(len-1)) continue;  /* ran out of indices before the end */
      if ((p==0) && (q || (flag!=0)) ) continue;
      /* print the coefficient/constant */
      if (p==0) {sprintf(txt,"0"); txt+=1;} /* only happens for lonely const */
      else if (p > 0) 
      { if (flag != 0) {sprintf(txt,"+"); txt+=1; }
        if ((p!=1) || !q)
        {  sprintf(txt,"%d", p);
           txt += strlen(txt);
	   if ((C&1) && q) {sprintf(txt,"*"); txt+=1;}
	}
        if (q)		/* print index name */
        {  if (C&2) {sprintf(txt,"("); txt+=1; }
	   type = index_type(q);
	   if ((type > 0)&&(C&4)) {sprintf(txt,"("); txt+=1; }
           txt += sprint_name(txt, q);
	   if ((type > 0)&&(C&4))
	       sprintf(txt, ")%%%i", type);while (*txt) txt+=1;
           if (C&2) {sprintf(txt,")"); txt+=1; }
        }
      }
      else if (p < 0) 
      { if ((p!=-1) || !q)
        { sprintf(txt,"%d", p);
          txt += strlen(txt);
	  if ((C&1) && q) {sprintf(txt,"*"); txt+=1;}
	}
        if ((p==-1) && q)
        {  sprintf(txt,"-"); txt+=1; }
        if (q)
        {  if (C&2) {sprintf(txt,"("); txt+=1; }
           txt += sprint_name(txt, q);
           if (C&2) {sprintf(txt,")"); txt+=1; }
        }
      }
      flag = 1;
    }
  if (c==txt) { sprintf(txt,"0"); txt+=1;}	/* an empty equation */
  return txt-c;
}

/*-------------------------------------------------------------------*/
/* id_list(in)                                                       */
/*     in : point to a node list of id's                             */
/* returns an item list of id text                                   */
/*-------------------------------------------------------------------*/
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
   else out = Text("");
   return out;
}

/*-------------------------------------------------------------------*/
/* id_list_n(in, n)                                                  */
/*     in : point to a node list of id's                             */
/*     n  : the number of id's not to print (parameters)             */
/* returns an item list of the first n id texts                      */
/*-------------------------------------------------------------------*/
item *id_list_n(in,n)
node *in;
int n;
{  item *out=(item *)0, *last=(item *)0, *tmp=(item *)0;
   node *p;
   int count, i;
   if (in && n==0) return id_list(in);
   else if (in) 
     { count = in->the.list.count - n;
       for(p=in->the.list.first, i=0; p && i<count; p=p->next, i++)
       { tmp = new_item(text);
         sprint_name(tmp->the.text.string, p);
         if (!out) out = last = tmp;
         else { last->next = tmp; last = tmp; }
       }
     }
   else return Text("");
   return out;
}

/*-------------------------------------------------------------------*/
/* id_list_n_sub(in, n)                                              */
/*     in : point to a node list of id's                             */
/*     n  : the number of id's not to print (parameters)             */
/* returns an item list of the first n id texts, with substitution   */
/*-------------------------------------------------------------------*/
item *id_list_n_sub(in,n)
node *in;
int n;
{  item *out=(item *)0, *last=(item *)0, *tmp=(item *)0;
   node *p, *j;
   int count, i, cf, cn;
   char  *txt;
   inode *index;

   if (!in) return Text("");

   count = in->the.list.count - n;
   for(p=in->the.list.first, i=0; p && i<count; p=p->next, i++)
   {
      j = p;				/* j = current index */
      cf = 1;				/* current coef */
      cn = 0;				/* current const */
do_sub_switch:
      switch ( index_status(j) )
      {   case FREE:
		break;
          case FIXED:
                break;
          case CONST:
                index = lookup_index(j);
		cn += (cf * index->constant);
		cf = 0;
		break;
          case SUBST:
                index = lookup_index(j);
                cn += (cf * index->constant);
                cf = cf * index->coef;
		j = index->sub;
		goto do_sub_switch;/*re-execute switch, continue substituting*/
      }
      tmp = new_item(text);
      txt = tmp->the.text.string;
      if (cf==0)
      {  if (cn==0) sprintf(txt,"0");
         else       sprintf(txt,"%d", cn);
      }
      else if (cf==1)
      {  txt += sprint_name(txt, j);
        /*if (cn!=0) sprintf(txt,"%d", cn);*/
         if (cn>0) sprintf(txt,"+%d", cn);
         else if (cn<0) sprintf(txt,"%d", cn);
      }
      else if (cf==-1)
      {  sprintf(txt,"-"); txt = txt+1;
         txt += sprint_name(txt, j);
         /*if (cn!=0) sprintf(txt,"%d", cn);*/
         if (cn>0) sprintf(txt,"+%d", cn);
          else if (cn<0) sprintf(txt,"%d", cn);      }
      else
      {  sprintf(txt,"%d", cf); while (*txt) txt+=1;
         sprint_name(txt, j);
         txt = txt + strlen(txt);
         /*if (cn!=0) sprintf(txt,"%d", cn);*/
         if (cn>0) sprintf(txt,"+%d", cn);
           else if (cn<0) sprintf(txt,"%d", cn);
      }
      if (!out) out = last = tmp;
      else { last->next = tmp; last = tmp; }
   }   
   return out;
}

/*------------------------------------------------------------------*/
/* affine_list(Z,X,n,C)                                             */
/*        Z : list of indices                                       */
/*        X : matrix (list of vectors)                              */
/*        n : number of parameters                                  */
/*        C : print control code                                    */
/* returns an item list of comma separated affine equations         */
/*------------------------------------------------------------------*/
item *affine_list(Z,X,n,C)
node *Z, *X;
int n, C;
{ item *tmp2, *head2, *tail2;
  node *Y;
  int count,i;

  head2 = tail2 = (item *) 0;
  /* take the last n off the end by not processing them */
  count = X->the.list.count - n - 1;
  for (Y = X->the.list.first, i=0; Y && i<count; Y = Y->next, i++) 
  { tmp2 = new_item(text);
    sprint_con(tmp2->the.text.string, Y->the.vec.val, Y->the.vec.dim, Z, C);
    if (head2) { tail2->next = tmp2; tail2 = tmp2; }
    else { head2 = tail2 = tmp2; };
  }
  return Hsep(0,",",head2);
}

/*-------------------------------------------------------------------*/
/* identity_list(vdim)                                               */
/*       vdim : dimension of indices + parameters + 1                */
/* returns an identity matrix of vdim X vdim                         */
/*-------------------------------------------------------------------*/
node *identity_list(vdim)
int vdim;
{  node *out = (node *) 0, *p;
   int *q, i;

   out = new_list(0);
   for(i=0; i<vdim; i++)
   {  q = (int *) malloc ( vdim*sizeof(int) );
      memset( q, 0, vdim*sizeof(int) );
      q[i] = 1;
      p = new_node(vec);
      p->the.vec.val = q;
      p->the.vec.dim = vdim;
      add_to_list(out, p);
   }
   return out;
}
      
/*-------------------------------------------------------------------*/
/* constraints_list(Z,X)                                             */
/*        Z : list of indices                                        */
/*        X : matrix (list of vectors)                               */
/* returns a semicolon separated list of equalities and inequalities */
/*     in Alpha format: ex: 1<=i<=(JB,j+1); j<=JB; p<=(NB,k)         */
/*-------------------------------------------------------------------*/
static item *constraints_list(Z,X)
node  *Z, *X;
{ node **T;
  int  idnum, updated, i, j, cflag, curval, flag, s;
  node *p, *p1, *q, *n;
  item *head1,*tail1,*head2,*tail2,*head3,*tail3,*tmp1,*tmp2,*tmp3;
  char *txt;

  idnum = Z->the.list.count; /* count the number of ids in the list Z */

  /* Initialise arrays to be empty */
  T = (node **)malloc((idnum+1)*sizeof(node *));
  for (i=0; i<=idnum; i++)
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
  for (p=X->the.list.first; p; p=p1)  /* walk down constraint list */
  { p1 = p->next;
    s  = p->the.vec.val[0];
    for (i=1,cflag=0; !cflag && i<=idnum; i++)
    { curval = p->the.vec.val[i];
      if (curval == 1 || curval == -1)
      { /* negate all values in list if value is +ve */
        if (curval == 1)
          for (j=1; j<p->the.vec.dim; j++) p->the.vec.val[j] *=(-1);
        /* zorch the id value */
        p->the.vec.val[i] = 0;
        /* place constraints in appropriate bins */
        if (s == 0)        add_to_list(&T[i][0],p);
        else /* if (s == 1) */
        { if (curval == 1) add_to_list(&T[i][1],p);
          else             add_to_list(&T[i][2],p);
        }
        cflag=1;
      }
    }
    if (!cflag) /* place in sink at equals position */ add_to_list(&T[0][0],p);
  }

  /* walk down list and create strings and items, to accomodate new output */
  head1 = tail1 = (item *)0;
  for (i=1,q=Z->the.list.first; i<=idnum; q=q->next,i++)
  { if (T[i][0].the.list.count>0)
    { head2 = tail2 = new_item(text);
      sprint_name(head2->the.text.string,q);
      for (n=T[i][0].the.list.first; n; n=n->next)
      { tmp3 = new_item(text);
        sprint_con(tmp3->the.text.string,
                   &n->the.vec.val[1], n->the.vec.dim-1, Z, 0);
        tail2->next = tmp3; tail2 = tmp3;
      }
      tmp2 = Hsep(0,"=",head2);
      if (head1) { tail1->next = tmp2; tail1 = tmp2;}
      else {head1 = tail1 = tmp2;}
    }
    /* lower bounds */
    head2 = tail2 = (item *)0;
    if (T[i][1].the.list.count>0)
    { head3 = tail3 = (item *)0;
      for (n=T[i][1].the.list.first; n; n=n->next)
      { tmp3 = new_item(text);
        sprint_con(tmp3->the.text.string,
                   &n->the.vec.val[1], n->the.vec.dim-1, Z, 0);
        if (head3) { tail3->next = tmp3; tail3 = tmp3;}
        else {head3 = tail3 = tmp3;}
      }
      if (T[i][1].the.list.count>1)
      { tmp3 = Henc(0, Text("("), Text(")"),
                  Hsep(0,",",head3));
      } else tmp3 = head3;
      if (head2) { tail2->next = tmp3; tail2 = tmp3;}
      else {head2 = tail2 = tmp3;}
    }

    /* var */
    if (T[i][1].the.list.count>0 || T[i][2].the.list.count>0)
    { tmp3 = new_item(text);
      sprint_name(tmp3->the.text.string,q);
      if (head2) { tail2->next = tmp3; tail2 = tmp3;}
      else {head2 = tail2 = tmp3;}
    }
    /* upper bounds */
    if (T[i][2].the.list.count>0)
         { head3 = tail3 = (item *)0;
           for (n=T[i][2].the.list.first; n; n=n->next)
          { tmp3 = new_item(text);
            sprint_con(tmp3->the.text.string,
                       &n->the.vec.val[1], n->the.vec.dim-1, Z, 0);
            if (head3) { tail3->next = tmp3; tail3 = tmp3;}
            else {head3 = tail3 = tmp3;}
          }
          if (T[i][2].the.list.count>1)
          { tmp3 = Henc(0, Text("("), Text(")"),
                      Hsep(0,",",head3));
          } else tmp3 = head3;
          if (head2) { tail2->next = tmp3; tail2 = tmp3;}
          else {head2 = tail2 = tmp3;}
    }
    if (head2)
    { tmp2 = Hsep(0,"<=",head2);
      if (head1) { tail1->next = tmp2; tail1 = tmp2;}
      else {head1 = tail1 = tmp2;}
    }
  }
  /* other constraints from sink */
  if (T[0][0].the.list.count>0)
  { for (n = T[0][0].the.list.first; n; n = n->next)
    {  head3 = new_item(text);
       sprint_con(head3->the.text.string,
                  &n->the.vec.val[1], n->the.vec.dim-1, Z, 0);

         /* make the expression into an equation */
         tmp3 = new_item(text);
         txt = tmp3->the.text.string;
         if (n->the.vec.val[0] == 0) sprintf(txt,"=0");
         else  sprintf(txt,">=0");

         /* put tmp3 on the list */
         head3->next = tmp3;
         /* end compute body of tmp2 */

         /* detect and eliminate positivity constraint */
         /* ASSUME: positivity constraint is last eqn in list */
         if (head3->the.text.string[0]=='1' &&
             tmp3->the.text.string[0]=='>' && head1 )
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

/*-------------------------------------------------------------------*/
/* convert_pol2(Z,X,n)                                               */
/*        Z : list of indices                                        */
/*        X : matrix (list of vectors)                               */
/*        n : number of parameters                                   */
/* returns an item tree for an Alpha-style domain with indices       */
/*-------------------------------------------------------------------*/
item *convert_pol2(Z,X,n)
node   *Z, *X;
int n;
{
  return  Henc(4, Text("{ "), Text(" }"),
	     Hsep2(4," | ", 
	        Hsep(0,",",id_list_n(Z,n)),
	        constraints_list(Z,X)
	     )
	  );
}

/*-------------------------------------------------------------------*/
/* spec_pol2(Z,X,n)                                                  */
/*        Z : list of indices                                        */
/*        X : matrix (list of vectors)                               */
/*        n : number of parameters                                   */
/* returns an item tree for an Alpha-style domain without indices    */
/*-------------------------------------------------------------------*/
item *spec_pol2(Z,X,n)
node   *Z, *X;
int n;
{ 
  return  Henc(4, Text("{| "), Text(" }"), constraints_list(Z,X)); 
}

/*-------------------------------------------------------------------*/
/* domain2C(Z,X)                                                     */
/*	Z :	is the node list of indices                          */
/*	X :	is the node representation (parse tree) of a domain  */
/* returns a item pointer to the C-code to test for membership in    */
/* the domain X (possibly more than one polyhedron).                 */
/*-------------------------------------------------------------------*/
item *domain2C(Z,X)
node  *Z, *X;
{ item *txt1, *head, *tail, *head2, *tail2;
  node *p, *a;

  head2 = tail2 = (item *)0;
  for (p=X->the.dom.pol->the.list.first; p; p=p->next)
  { head = tail  = (item *)0;
    for (a=p->the.pol.constraints->the.list.first; a ; a=a->next)
    { txt1 = Text("");
      /* to print out a single constraint and add to ongoing list*/
      sprint_con(txt1->the.text.string,&a->the.vec.val[1],a->the.vec.dim-1,Z,1);
      if (a->the.vec.val[0] == 0) 
           strcat(txt1->the.text.string,"==0");
      else strcat(txt1->the.text.string,">=0");
      if (strcmp(txt1->the.text.string,"1>=0")) /*removes positivity constr.*/
      { if (head) {tail->next = txt1; tail = txt1;}
        else head = tail = txt1;
      }
    }
    if (head)
    { txt1 = Hsep1(0," && ",head);
      if (head2) {tail2->next = txt1; tail2 = txt1; }
      else head2 = tail2 = txt1;
    }
    else 
    { fprintf(stderr, "? domain2C : empty list of constraints encountered.\n");
      return Text("1");
    }
  }
  return Hsep1(0," || ",head2);
}

/*--------------------------------------------------------------------------*/
/* dot_prod(l,w,Z,length,plength)                                           */
/*	l :		is the the lower bound vector                       */
/* 	w :		is the weight vector                                */
/*	Z :		is a node list of the indices                       */
/*	length :	is the dimension of the domain                      */
/*	plength :	is the number of parameters                         */
/*	C:		print control: OR combination of:                   */
/*			1=use '*' for mult,                                 */
/*      		2=put '()' around index                             */
/*			3=add modulo operator according to index information*/
/* returns an item pointer to the C-code to compute: w.Z - x, where x = w.l */
/*--------------------------------------------------------------------------*/
item *dot_prod(l,w,Z,length,plength,C)
int *l, *w,
    length,	/* dimension of domain (with params, without constant) */
    plength,	/* dimension of fixed params */
    C;		/* print control flags */
node *Z;		/* list of index names */
{ int x, i;
  int *temp;
  item *out;
  int type;

  temp = (int *) malloc ((length+1) * sizeof(int));

  /* walk down w and l, calculate and store integer result */
  for (i=0, x=0; i<(length-plength); i++)
  { /* create a node item containing a simple number */
    if (nth_index_type(i+1,Z)!=1)
      temp[i] = w[i];
    else
      temp[i] = 0;
    x += (l[i] * temp[i]);
  }

  for ( ; i<length; i++) temp[i] = 0; /* pad for params */

  /* the constant */
  temp[i] = -x;

  out = Text("");
  sprint_con(out->the.text.string, temp, length+1, Z, C);
  free(temp);
  return out;
}

/*---------------------------------------------------------------------*/
/* get_decl(in, alpha)                                                 */
/*       in : an id node of the variable to look up                    */
/*    alpha : the alpha tree of the system in which to do the look-up  */
/* Searchs the inputs, outputs, and locals for in->the.id.name         */
/* If it finds it, it returns the node pointer to the declaration      */
/* If it doesn't find it, it prints out an error message               */
/* Only one error per variable is ever printed out                     */
/*---------------------------------------------------------------------*/
static node *undeclared = 0;  /* to store undeclared variables */

node *get_decl(in, alpha)
node *in;
node *alpha;
{ node *l, *current;
  char *comparison;
  int i;
  for(i=0;i<4;i++)
  {  if      (i==0)    l = alpha->the.sys.in;
     else if (i==1)    l = alpha->the.sys.out;
     else if (i==2)    l = alpha->the.sys.local;
     else /* (i==3) */ l = undeclared;
     if (l) for(current=l->the.list.first; current; current=current->next)
     {  comparison = current->the.decl.id->the.id.name;
        if (strcmp(comparison, in->the.id.name)==0)
           return current; /*->the.decl.domain->the.dom.index;*/
                           /*->the.decl.type */
                           /*->the.decl.domain */
     }
   }
   /* its undeclared -- so print out a message and declare it */
   fprintf(stderr, "? %s is not declared\n", in->the.id.name);
   current = new_node(decl);
   current->the.decl.id = new_id(in->the.id.name);
   current->the.decl.type = inttype;
   current->the.decl.domain = new_node(dom);
   current->the.decl.domain->the.dom.dim = 0;
   current->the.decl.domain->the.dom.index = new_list(0);
   current->the.decl.domain->the.dom.pol = new_list(0);
   current->the.decl.l = (int *)0;
   current->the.decl.w = (int *)0;
   undeclared = add_to_list(undeclared,current);
   return current;
}

/*---------------------------------------------------------------------*/
/* list_decls(idecls,odecls)                                           */
/*      idecls : a node pointer to a list of input declarations        */
/*      odecls : a node pointer to a list of output declarations       */
/* creates the C-code for a i/o variable list                          */
/*---------------------------------------------------------------------*/
#define VAR_PREFIX "__"
item *list_decls(idecls,odecls)
node *idecls, *odecls;
{  node *current;
   item *n, *out = (item *)0, *last;
   int dim;

   for (current=idecls->the.list.first; current; current=current->next)
   {
      /* create text item for each input id */
      dim = current->the.decl.domain->the.dom.dim - G_dim;
      if (dim==0)  /* scalar */
      {  n = Text("");
         sprint_name(n->the.text.string, current->the.decl.id);
      }
      {  n = Text(VAR_PREFIX);
         sprint_name(&n->the.text.string[strlen(VAR_PREFIX)], current->the.decl.id);
      }
      if (!out) out = last = n;
      else { last->next = n; last = n; }
   }
   for (current=odecls->the.list.first; current; current=current->next)
   {
      /* create text item for each output id */
      dim = current->the.decl.domain->the.dom.dim - G_dim;
      if (dim==0)  /* scalar */
      {  n = Text("");
         sprint_name(n->the.text.string, current->the.decl.id);
      }
      {  n = Text(VAR_PREFIX);
         sprint_name(&n->the.text.string[strlen(VAR_PREFIX)], current->the.decl.id);
      }
      if (!out) out = last = n;
      else { last->next = n; last = n; }
   }
   if (!out) out = Text("");
   return out;
}

/*---------------------------------------------------------------------*/
/* convert_decl(decls,status)                                          */
/*      decls : a node pointer to a list of declarations               */
/*      status : 0 = scheduled c-code, 1 = demand-driven c-code        */
/* creates the C-code for a variable declaration                       */
/*---------------------------------------------------------------------*/
item *convert_decl(decls, status)
node *decls;
int status;
{ node *current;
  item *id, *idlist, *type, *tmp = (item *)0,
  *out = (item *)0, *sized, *offset;
  int flag = 0, i, position, dim, infinite;

  for (current=decls->the.list.first; current; current=current->next)
  { /* dim is 0 for scalars, the dim for arrays */
    dim = current->the.decl.domain->the.dom.dim - G_dim;
    /* create items to be used as building blocks */
    id = Text("");
    sprint_name(id->the.text.string,current->the.decl.id);

    switch (current->the.decl.type)
    {  case realtype: type = Text(status ? "realvar " : "double "); break;
       case booltype: type = Text(status ? "boolvar " : "boolean "); break;
       case inttype:  type = Text(status ? "intvar " : "int "); break;
    }
    idlist = Hsep1(0,",",
                id_list_n(current->the.decl.domain->the.dom.index,G_dim)
             );

    /* test for an infinite domain, requiring different processing */
    if (current->the.decl.w) infinite=0; else infinite=1;

    /* create an item which is a number,containing the array declaration size */
    sized = new_item(number);
    position = current->the.decl.domain->the.dom.dim - G_dim;
    if (!infinite) sized->the.number.value = current->the.decl.w[position];
    else sized->the.number.value = 0;

    /* to produce the item to display the offset address */
    if (!infinite)
       offset = dot_prod(current->the.decl.l, current->the.decl.w, 
                         current->the.decl.domain->the.dom.index,
                         current->the.decl.domain->the.dom.dim,
                         G_dim, 7);
    else offset = Text("");

    /* build a declaration item */
    if (!dim)			                /* scalar */
      {
	tmp = Vsep2(0, ";",
		    Hsep3(0, "",
			  Copy(type),
			  Text(VAR_PREFIX),
			  Copy(id)
			  ),
		    Hsep2(0, "\t",
			  Hsep3(0, "",
				Text("#define "),
				Copy(id),
				Text("()")
				),
			  Hsep2(0, "",
				Text(VAR_PREFIX),
				Copy(id)
				)
			  )
		    );
      }
    else
    { if (!infinite)				/* finite array */
      { tmp = Vsep2(0, ";",
                 Hsep6(0, "",
                    Copy(type),
                    Text(VAR_PREFIX),
                    Copy(id),
                    Text("["),
		    Copy(sized),
		    Text("]")
                   ),
                 Hsep2(0, "\t",
                    Hsep5(0, "",
                       Text("#define "),
                       Copy(id),
                       Text("("),
                       idlist,
                       Text(")")
                    ),
                    Hsep5(0, "",
                       Text(VAR_PREFIX),
                       Copy(id),
                       Text("["),
                       offset,
                       Text("]")
                    )
                 )
              );
      }
      else					/*  infinite array */
      { tmp = Hsep6(0, "",
                    Copy(type),
                    Text(VAR_PREFIX),
                    Copy(id),
                    Text("["),
                    Text("INFINITY"),
                    Text("];")
                   );
      }
    }
    /* add to out list */
    if (out && !flag) {new_list2(out,tmp); flag = 1;}
    else if (out && flag) add_to_ilist(out,tmp);
    else out = tmp;
  }
  return out;
}


/*--------------------------------------------------------------------------*/
/* create_loop(Z,X,pos)                                                     */
/* create the pos-th for loop to scan domain X                              */
/*	Z :  a node list of the indices of the domain                       */
/*	X :  the node-parse tree of the constraint matrix from the domain   */
/*    pos :  the position (integer 1..dimension) of the loop index          */
/* note: X is destroyed                                                     */
/* returns an item pointer to the C-code of the for loop to scan that index */
/* for( index  = max(lb1, lb2, ...);                                        */
/*      index <= min(ub1, ub2, ...);                                        */
/*      index++ )                                                           */
/* frees the memory allocated to X                                          */
/*--------------------------------------------------------------------------*/
static item *create_loop(Z,X,pos)
node *Z; /* list of indices */
node *X; /* domain */
int pos; /* position of the loop index */
{ node *T;
  int posi, idnum, i, j, curval, index;
  int *q, *f, s, n, *tmp;
  Value *qVal,*qValTemp;
  node *p, *p1, *vari;
  item *head1, *tail1, *tmp1, *head2, *tail2, *tmp2, *tmpid, *tmpa;
  char *txt;

  idnum = Z->the.list.count; /* count the number of ids in the list Z */
  if ( (pos > idnum) || (pos < 1))
  {  fprintf(stderr, "create_loop: ? invalid position %d\n", pos);
     return(Text("??"));
  }

  /* Initialise array for bins to be empty */
  /* T[0] == equalities */
  /* T[1] == lower bounds */
  /* T[2] == upper bounds */
  T = (node *)malloc(3*sizeof(node));
  for (j=0; j<3; j++)
  {  T[j].type = list;
     T[j].the.list.count = 0;
     T[j].the.list.first = (node *)0;
     T[j].the.list.last = (node *)0;
  }

  for (p=X->the.list.first; p; p=p1)
  { /* walk down constraint list, p points to a constraint, p1 to the next */
    p1 = p->next;
    q  = p->the.vec.val;

    /* original call 
        tmp = (int *) malloc( (idnum+1) * sizeof(int) );
        Vector_Normalize(&q[1], tmp, idnum+1);
        free(tmp)
    replaced by : */

    qVal = (Value *)malloc((idnum+1)*sizeof(Value));
    qValTemp=qVal;
    for (i=0; i<=idnum ; i++)
      {        
        value_init(*qValTemp);
        value_set_si(*qValTemp,q[i]);
        qValTemp++;
      } ;
    qValTemp=qVal;
    Vector_Normalize(&qVal[1], idnum);	/* reduce to lowest form */
    qValTemp=qVal;
    for (i=0; i<=idnum ; i++)
      {
        q[i]= VALUE_TO_INT(qVal[i]);
        value_clear(qVal[i]);
     } ;

    free(qVal);

    s = q[0];
    /* s == status value */
    /* pos == current index position */
    /* q[pos] == coefficient value */
    curval = q[pos];
    if (curval!=0)
    { /* negate all values in list if value is +ve */
      if (curval > 0)
      { for ( n=1; n<p->the.vec.dim; n++ ) q[n] = (-1)*q[n];
      }

      /* place constraints in appropriate bins */
      if (s == 0)        add_to_list(&T[0],p);	/* equality */
      if (s == 1)
      { if (curval > 0)  add_to_list(&T[1],p);	/* lower bound */
        else             add_to_list(&T[2],p);	/* upper bound */
      }
    }
  }

  /* here the array contains upper and lower bounds for a single id, all
     other id's and constraints having been discarded for this case */

  /* walk down list and create strings and items, to accomodate output */

  /* var */
  for (vari = Z->the.list.first, index=1;
       vari && (index<pos); index++, vari = vari->next) /* no-op */;
  tmpid = Text("");
  sprint_name(tmpid->the.text.string,vari);    /* tmpid == the index id */

  /* lower bounds */
  /* tmp1 = "max(" lb1, lb2, ... ")" */
  if (T[1].the.list.count>0)
  { head1 = tail1 = (item *)0;
    for (p=T[1].the.list.first; p; p=p1)
    { q  = p->the.vec.val;
      p1 = p->next;
      curval = q[pos];
      q[pos] = 0;
      tmpa = Text("");
      sprint_con(tmpa->the.text.string,&p->the.vec.val[1],p->the.vec.dim-1,Z,1);
      free_node(p);
      if (curval==-1)
        tmp1 = tmpa;
      else
	tmp1 =  Hsep7(0, " ",
			Text("("),
			Hsep2(0,">",
			   Hsep2(0,"%",
				Henc(0,Text("("),Text(")"),tmpa),
				Number(-curval)
			   ),
			   Text("0")),
			Text("?"),
			Hsep2(0,"+",
				Hsep2(0,"/",
					Henc(0,Text("("),Text(")"),tmpa),
					Number(-curval)
				),
				Text("1")
			),
			Text(":"),
			Hsep2(0,"/",
				Henc(0,Text("("),Text(")"),tmpa),
				Number(-curval)),
			Text(")")
		);
      if (head1) { tail1->next = tmp1; tail1 = tmp1;}
      else {head1 = tail1 = tmp1;}
    }
    if (T[1].the.list.count>1)
    { tmp1 = Henc(0, Text("max("), Text(")"),
               Hsep1(0, ",", head1)
            );
    } else tmp1 = head1;
  }
  else 
  { tmp1 = Text("-INFINITY");
    fprintf(stderr,"create_loop : no lower loop bound exists\n");
  }

  /* upper bounds */
  /* tmp2 = "min(" ub1, ub2, ... ")" */
  if (T[2].the.list.count>0)
  { head2 = tail2 = (item *)0;
    for (p=T[2].the.list.first; p; p=p1)
    { q  = p->the.vec.val;
      p1 = p->next;
      curval = q[pos];
      q[pos] = 0;
      tmpa = Text("");
      sprint_con(tmpa->the.text.string,&p->the.vec.val[1],p->the.vec.dim-1,Z,1);
      free_node(p);
      if (curval==-1)
        tmp2 = tmpa;
      else
	tmp2 =  Hsep7(0, " ",
			Text("("),
			Hsep2(0,"<",
			   Hsep2(0,"%",
				Henc(0,Text("("),Text(")"),tmpa),
				Number(-curval)
			   ),
			   Text("0")),
			Text("?"),
			Hsep2(0,"-",
				Hsep2(0,"/",
					Henc(0,Text("("),Text(")"),tmpa),
					Number(-curval)
				),
				Text("1")
			),
			Text(":"),
			Hsep2(0,"/",
				Henc(0,Text("("),Text(")"),tmpa),
				Number(-curval)),
			Text(")")
		);
      if (head2) { tail2->next = tmp2; tail2 = tmp2;}
      else {head2 = tail2 = tmp2;}
    }
    if (T[2].the.list.count>1)
    { tmp2 = Henc(0, Text("min("), Text(")"),
                Hsep1(0, ",", head2)
             );
    } else tmp2 = head2;
  }
  else
  { tmp2 = Text("INFINITY");
    fprintf(stderr,"create_loop : no upper loop bound exists\n");
  }

  if (T[0].the.list.count>0)
  {  for (p=T[0].the.list.first; p; p=p1)
     {  p1 = p->next;
        free_node(p);
     }
  }
  free(T);

  return Henc(0, Text("for ("), Text(")"),
            Hsep3(0, "; ",
               Hsep3(0, "",
                  Copy(tmpid),
                  Text("="),
                  tmp1
               ),
               Hsep3(0, "",
                  Copy(tmpid),
                  Text("<="),
                  tmp2
               ),
               Hsep2(0, "",
                  Copy(tmpid),
                  Text("++")
               )
            )
         );
}

/*------------------------------------------------------------------------*/
/* do_substitution(Z,X,C)                                                 */
/*       Z : node list of indices                                         */
/*       X : node list of constraints                                     */
/*       C : control flag== C=0 :: affine expressions, C=1 :: constraints */
/*------------------------------------------------------------------------*/
void do_substitution(Z,X,C)
node *Z, *X;
int C;	/* C is actually the offset of the first coefficient */
{  node *i, *i2, *j, *p;
   int ix, ix2, cx, *q;
   inode *index;

   cx = Z->the.list.count + C;

   /* for each index column : perform substitutions */
   for (i=Z->the.list.first, ix=C; i; i=i->next, ix++)
   {
      j = i;				/* j = current index */
do_sub_switch:
      switch ( index_status(j) )
      {   case FREE:
          case FIXED:
                break;
          case CONST:
                index = lookup_index(j);
		for (p=X->the.list.first; p; p=p->next)  /* sub all rows */
                {  q=p->the.vec.val;
                   if (q[ix]==0) continue;
                   q[cx] += (q[ix] * index->constant);
                   q[ix] = 0;
		}
                break;
          case SUBST:
                index = lookup_index(j);
		for (p=X->the.list.first; p; p=p->next)  /* sub all rows */
                {  q=p->the.vec.val;
                   if (q[ix]==0) continue;
                   q[cx] += (q[ix] * index->constant);
                   q[ix] *= index->coef;
                }
		j = index->sub;
		goto do_sub_switch;/*re-execute switch, continue substituting*/
      }

      if (j!=i) /* a substitution (or chain of subs) has taken place */
      {  index = lookup_index(j);
         /* see if index->name appears somewhere else in list (not at i) */
         for (i2=Z->the.list.first, ix2=C; i2; i2=i2->next, ix2++)
         {  if (i2==i) continue;
            if ( !strcmp_end(index->name, i2->the.id.name, ':') ) break;
         }
         if (i2)
         {  /* replace index in index list with sub */
            for (p=X->the.list.first; p; p=p->next)  /* sub all rows */
            {  q  = p->the.vec.val;
               q[ix2] += q[ix];
               q[ix] = 0;
            }
         }
         else /* subst-index not found in list */
         {  /* change current index to subst-index */
             fprintf(stderr,"i2: %x\n",i2);
             fprintf(stderr,
              "do_substitution: ?substitution index %s is not in list\n",
              i2->the.id.name);
         }
      }
   }
}

extern int currentpos;

/* for debugging */
static void print_dom ( Z, d, n )
Polyhedron *d;
node *Z;
int n;
{  node *D, *P;
   item *i,*i_list=0;

   D = domain2node(d);
   for (P = D->the.dom.pol->the.list.first; P; P=P->next)
     i_list = add_to_ilist(i_list, convert_pol2(Z, P->the.pol.constraints, n));
   i = Hsep(0," | ", i_list);
   currentpos=0;
   print_item(i);
   printf("\n");
   free_node(D);
   /* free_item(i); */
}

/*---------------------------------------------------------------------*/
/* Interface with polyhedral Library                                   */
/*---------------------------------------------------------------------*/
#define MAXRAYS 400
#define Vector_Init(p1, length) \
  memset((char *)(p1), 0, (int)(length)*sizeof(int))

/*------------------------------------------------------------------------*/
/* control_domain(X,Context)                                              */
/*         X :  is the node representation (parse tree) of a polyhedron   */
/*   Context :  the context information                                   */
/* returns a pointer to the new context                                   */
/* recursively "fixes" all of the indices which are used.                 */
/* destructive to X                                                       */
/*------------------------------------------------------------------------*/
context_info *control_domain(X,C)
node *X;
context_info *C;
{  node *Z, *n, *p, *a, *anext, *s, *i, *i2;
   node *if_pol, *if_domain, *free_index, *fixed_index;
   inode *index;
   int j,num_free, num_fixed, c, d, f, ix, *q, *q2, *tmp, dimension;
   Value *qVal,*qValTemp;
   Polyhedron *D, *D1, *D2, *new_context;
   Matrix *M;
   context_info *C2, *C3;
   item *out;
   struct eqn
   {  node	*a;		/* equality constraint */
      node	*index;		/* index id node of free var */
      int	num_fixed;	/* number of fixed vars */
      int	dx;		/* index of free var */
      int	fx;		/* index of fixed var */
      node	*sub;		/* id node of fixed var index */
   } e;

   /* Exit on null Context Domain */
   if (!C)
   {   fprintf(stderr, "control_domain: ? Null Context\n");
       return 0;
   }

   /* Exit on null Control Domain */
   if (!X)
   {  fprintf(stderr, "control_domain: ? Null Control Domain\n");
      return 0;
   }

   /* Create working context */
   C2 = (context_info *) malloc (sizeof(context_info));
   C2->index = X->the.dom.index;
   Z = X->the.dom.index;	/* a short cut (=C2->index) */
   C2->dom = domain2aligned_domain(C->dom, C->index, Z); /* Align with X */
   C2->index_stamp = index_stamp;
   C2->code = Henc(0,0,0,0);
   C2->body = &(C2->code->the.henc.body);

   /* Exit on missing or universe Control Domain */
   if (X->the.dom.pol->the.list.count==0) return C2;  /* missing domain */
   if (X->the.dom.pol->the.list.first->the.pol.nb_constraints==0) return C2;
   p=X->the.dom.pol->the.list.first->the.pol.constraints;
   if (!p || p->the.list.count==0) return C2;	/* X==universe */

#ifdef DEBUG
printf("---------------------------------------------------------------\n");
printf("Calling control_domain");
for (i=Z->the.list.first ; i ; i=i->next)
{  index = lookup_index(i);
   printf(" %s=(Stamp=%d)Status=%d",
   i->the.id.name, index->stamp, index->status);
}
printf("\n");
printf("Initial Context = ");
print_dom( C2->index, C2->dom, 0 );
#endif

   /* convert X from node-tree to polylib format */
   D = node2domain(X);
   X->the.dom.index = (node *) 0;	/* don't want to free this part */
   free_node(X);
#ifdef DEBUG
printf("X = ");
print_dom( Z,D,0 );
#endif

   /* Handle non-convex polyhedra */
   /* Non-convex polyhedra are handled by making a control loop to
      scan the convex closure of the control domain, and then using
      if-statements to guard statements in the loop. */
   if (D->next)     /* more than one polyhedron */
   {  /* you must include the context in the domain BEFORE taking */
      /* the convex closure, or else bounds may be lost */
      /* Exa: Convex[{i,N | i=1}       | {i,N | 1<=i<=N}] = {i,N | 1<=i} */
      /* But: Convex[{i,N | i=1; 1<=N} | {i,N | 1<=i<=N}] = {i,N | 1<=i<=N} */
      D1 = DomainIntersection(D, C2->dom, MAXRAYS);
#ifdef DEBUG
printf("Context included X = ");
print_dom( Z,D1,0 );
#endif
      D2 = DomainConvex(D1, MAXRAYS);
      Domain_Free(D1);  /* D is still needed and will be freed later on */
#ifdef DEBUG
printf("Convex X = ");
print_dom( Z,D2,0 );
#endif
      X = domain2node(D2);
      X->the.dom.index = Z;
      Domain_Free(D2);
      /* call control_domain to fix all indices */
      C3 = control_domain(X,C2);
      Domain_Free(C2->dom);
      free(C2);
      C2=C3;
      C3=0;
      /* then proceed with convex hull in context, and  */
      /* make sure -if- can do multiple polyhedra */
   }

   /* Simplify X (=D) in context of context-domain C2->Dom */
   D1 = DomainSimplify(D, C2->dom, MAXRAYS);
   if (emptyQ(D1))
   {  C3 = C2;
      C3->code = Text("/* dead code eliminated */");
      C3->body = (item **) 0;
      Domain_Free(D1);
      Domain_Free(D);
      return C3;
   }
   X = domain2node(D1);
   X->the.dom.index = Z;
#ifdef DEBUG
printf("Simplified X = ");
print_dom( Z,D1,0 );
#endif
   Domain_Free(D1);
   Domain_Free(D);


   /* Check if there are any substitutions that can be made from the context.*/
   /* Promote FIXED indices to SUBST or CONST. */
   /* [ NOT DONE ] */

   /* perform all substitutions on control-domain X */
   dimension = X->the.dom.dim+1;		/* homogeneous dimension */
   for (n=X->the.dom.pol->the.list.first; n; n=n->next)   
   {  p=n->the.pol.constraints;
      /* under this system, q[0]=status, q[1..dimension-1]=coefficient */
      /* and q[dimension] = constant */
      do_substitution(Z,p,1);
   }

   /* resimplify the equations after substitution */
   D = node2domain(X);
   X->the.dom.index = (node *) 0;	/* don't want to free this part */
   free_node(X);
#ifdef DEBUG
printf("After substitution X = ");
print_dom( Z,D,0 );
#endif
   X = domain2node(D);
   X->the.dom.index = Z;
   Domain_Free(D);

   /* prepare for analysis */
   dimension = X->the.dom.dim+1;		/* homogeneous dimension */
   if_domain = new_node(dom);
   if_domain->the.dom.dim   = X->the.dom.dim;
   if_domain->the.dom.index = X->the.dom.index;
   if_domain->the.dom.pol   = new_list(0);

   /* analyze control-domain X */
   /* for each polyhedron in the domain... */
   for (n=X->the.dom.pol->the.list.first; n; n=n->next)   
   {  p=n->the.pol.constraints;
      /* after substitution, only fixed and free (non-zero) indices are left */

      /* I.a.  Find fixed constraints */
      /* II.a. Find equalities which can fix "free" indices */
      if_pol = new_node(pol);
      if_pol->the.pol.constraints = new_list(0);
      if_pol->the.pol.nb_constraints = 0;
      if_pol->the.pol.nb_equations  = 0 ;

      e.a = (node *) 0;
      d = -1;
      f = -1;
      /* for each constraint in the polyhedron */
      for (a=p->the.list.first; a; a=anext)
      {  anext=a->next;		/* remember it here, it may be gone later */
         num_free  = 0;
         num_fixed = 0;
         q = a->the.vec.val;

         /* analyze a constraint, count indicies by type */
         /* for each coefficient and index in the constraint */
         for (ix=1, i=Z->the.list.first; i; ix++, i=i->next)
         { 
            /* q[ix]            == coefficient */
            /* i->the.id.name   == index name */
            if (q[ix]==0) continue;	/* non-zero coefficient */

            switch ( index_status(i) )
            {   case FREE:
                   free_index=i;
                   d=ix;
                   num_free++;
                   break;
                case FIXED:
		   fixed_index=i;
                   f=ix;
                   num_fixed++;
                   break;
                case CONST:
                case SUBST: /* shouldn't happen after substitution */
                   fprintf(yyout,
                   "line %i control_domain: ?unexpected CONST or SUBST for index %s\n",
                   lineNb, i->the.id.name);
                   break;
            }
         } /* done analyzing a constraint */

         if (num_free==0)
         {   /* test for positivity, contradiction, and other dumb constraints*/
             if (num_fixed==0) /* && (num_free==0) */
             {  if (q[0]==1 && q[dimension]!=0) /* its pos. constraint (1>=0) */
                {  if ( (n->the.pol.nb_constraints==1) &&
                   (if_pol->the.pol.nb_constraints==0) )
                   {  /* the universe domain */
                      return C2;
                   }
                   n->the.pol.nb_constraints--;
                   remove_from_list(p, a);
                   free_node(a);
                }
                else if (q[0]==0 && q[dimension]!=0)
                /*its a contradition (1==0)*/
                {  C2->code = Text("/* Dead code removed */");
                   C2->body = (item **) 0;
                   return C2;
                }
                else /* its (0==0) or (0>=0) */
                {  if (n->the.pol.nb_constraints==1)
                   {  /* the universe domain */
                      return C2;
                   }
                   n->the.pol.nb_constraints--;
                   remove_from_list(p, a);
                   free_node(a);
                }
             }
             else  /* (num_fixed>0) && (num_free==0) */
             {  /* move constraint 'a' to a list for an if statement */
                remove_from_list(p, a);
                add_to_list(if_pol->the.pol.constraints, a);
                /* adjust the polyhedra */
                n->the.pol.nb_constraints--;
                if_pol->the.pol.nb_constraints++;
                if (q[0]==0)
                {  n->the.pol.nb_equations--;
                   if_pol->the.pol.nb_equations++;
                }
             }
         }
         else if (num_free==1 && q[0]==0 && !e.a)
         {   /* record constraint 'a' for an eqn statement */
             if (n->next) fprintf(stderr,
                  "control_domain: ?expecting all indices to be fixed\n");
             e.a = a;
             e.dx = d;
             e.fx = f;
             e.num_fixed = num_fixed;
             e.index = free_index;
             e.sub   = fixed_index;
         }
      } /* done analyzing a polyhedron */

      /* build the if-domain from if-polyhedra */
      if (if_pol->the.pol.nb_constraints>0)
         add_to_list(if_domain->the.dom.pol, if_pol);
      else
         free_node(if_pol);

   } /* done analyzing a domain */

   /* Now generate code */

   /* I.b. Generate an if-statement for fixed constraints */
   /* Positivity constraint and Contraditions should be gone */
   if (if_domain->the.dom.pol->the.list.count>0)
   {  D2 = node2domain(if_domain);
#ifdef DEBUG
printf("\t--> Generate If for domain =");
print_dom( Z,D2,0 );
#endif
      D1 = DomainIntersection(C2->dom, D2, MAXRAYS);
      Domain_Free(C2->dom);
      Domain_Free(D2);
      C2->dom = D1;

      /* generate an if statement */
      C3 = control_domain(X,C2);
      Domain_Free(C2->dom);
      free(C2);
      out = Vsep2(0,"",
                Henc(INDENT,Text("if ( "),Text(" )"),
                   domain2C(Z,if_domain)
                ),
                Henc(INDENT,Text("{  "),Text("\n}"),
                   C3->code
                )
             );
      C3->code = out;
      return C3;
   }

   /* II.b. Generate equation or substitution for an equality with a */
   /*       single free index.                                         */
   /* ???? System of N equations and N free indices can be solved.     */
   if (e.a)
   {  /* eqn e.a is an equality */
      index     = lookup_index(e.index);
      num_fixed = e.num_fixed;
      q =   e.a->the.vec.val;
 
      /* adjust the polyhedron */
      remove_from_list(p, e.a);
      X->the.dom.pol->the.list.first->the.pol.nb_constraints--;
      if (q[0]==0) 
         X->the.dom.pol->the.list.first->the.pol.nb_equations--;

      /* reduce equation to its lowest form */
      /* original call 
         tmp = (int *) malloc( dimension * sizeof(int) );
         Vector_Normalize(&q[1], tmp, dimension);
         free(tmp);
         replaced by : */

      qVal = (Value *)malloc((dimension+1)*sizeof(Value));
      qValTemp=qVal;
      for (j=0; j<=dimension ; j++)
        {        
          value_init(*qValTemp);
          value_set_si(*qValTemp,q[j]);
          qValTemp++;
        } ;
      qValTemp=qVal;
      
      Vector_Normalize(&qVal[1], dimension);	/* reduce to lowest form */
      
       qValTemp=qVal;

      for (j=1; j<=dimension ; j++)
        {
          q[j]= VALUE_TO_INT(qVal[j]);
          value_clear(qVal[j]);
        } ;
      
      free(qVal);
      

      /* put it in the context */
      /* put e.a into a matrix format */
      M = Matrix_Alloc(1, dimension+1);
      for (ix=0; ix<=dimension; ix++) value_set_si(M->p[0][ix],q[ix]);
      new_context = DomainAddConstraints(C2->dom, M, MAXRAYS);
      Domain_Free(C2->dom);
      C2->dom = new_context;
      Matrix_Free(M);

      /* get the reduced coefficients */
      c = q[e.a->the.vec.dim-1];
      d = e.dx==-1 ? 0 : q[e.dx];
      f = e.fx==-1 ? 0 : q[e.fx];

      if (num_fixed==0) /* free=1, fixed=0 => generate constant substitution */
      {  /* d*i + c = 0 */
         /* if d is +/- 1, then ok, else empty domain */
         if ((d==1) || (d==-1))  /* OK */
         {
#ifdef DEBUG
printf("\t-->Generate a constant sub for index %s\n", index->name);
#endif
            index->status   = CONST;
            index->constant = d>0 ? -c : c;
            index->coef     = 0;
            index->sub      = (node *) 0;
            index->stamp    = (++index_stamp);
            C2->index_stamp = index_stamp;

            C3 = control_domain(X,C2);
            Domain_Free(C2->dom);
            free(C2);
            out = Vsep2(0,"",
                     Henc(0,Text(begcom),Text(endcom),
                        Hsep3(0,"",
                           Text(index->name),
                           Text(":="),
                           Number(index->constant)
                        )
                     ),
                     C3->code
                  );
         }
         else
         {  /* output empty domain, dead code : free index is not integer */
#ifdef DEBUG
printf("Eliminate dead code for non-int constant index %s\n", index->name);
#endif
            /* empty domain */
            C3 = C2;
            out = Text("/* dead code eliminated */");
	    C3->body = (item **) 0;
         }
      }                                               /* free=1, fixed=1 => */
      else if ((num_fixed==1) && ((d==1) || (d==-1))) /* gen. a substitution */
      { 
#ifdef DEBUG
printf("\t-->Generate a substition for index %s\n", index->name);
#endif
         /* d*i (free) + f*j (fixed) + c = 0  -->  i = (-f/d)*j + (-c/d) */
         index->status   = SUBST;
         index->constant = -c/d;
         index->coef     = -f/d;
         index->sub      = e.sub;
         index->stamp    = (++index_stamp);
         C2->index_stamp = index_stamp;

         C3 = control_domain(X,C2);
         Domain_Free(C2->dom);
         free(C2);
         out = Vsep2(0,"",
                  Henc(0,Text(begcom),Text(endcom),
                     Hsep6(0,"",
                        Text(index->name),
                        Text(" := "),
                        Number(index->coef),
                        Text(e.sub->the.id.name),
                        Text(" + "),
                        Number(index->constant)
                     )
                  ),
                  C3->code
               );
      }
      else  /* generate a fixed equation */
      {  item *tmp;

         index->status   = FIXED;
         index->stamp    = (++index_stamp);
         C2->index_stamp = index_stamp;

         if (d>0)
            for (ix=1; ix<e.a->the.vec.dim; ix++) q[ix] *= (-1);
         else d = -d;
         q[e.dx] = 0;

         tmp = new_item(text);
         sprint_con(tmp->the.text.string, &q[1], e.a->the.vec.dim-1, Z, 1);

         if ((d==1) || (d==-1))
         {  /* Generate an equation */
#ifdef DEBUG
printf("\t-->Generate an equation for index %s\n", index->name);
#endif
            C3 = control_domain(X,C2);
            Domain_Free(C2->dom);
            free(C2);
            out = Vsep2(0,"",
                     Hsep4(0,"",
                        Text(index->name),
                        Text(" = "),
                        tmp,
                        Text(";")
                     ),
                     C3->code
                  );
         }
         else
         {  /* Generate an equation gaurded by if ( % ) */
#ifdef DEBUG
printf("\t-->Generate a gaurded equation for index %s\n", index->name);
#endif
            C3 = control_domain(X,C2);
            Domain_Free(C2->dom);
            free(C2);
            out = Vsep2(0,"",
                     Henc(0, Text("if ( "), Text(" )"),
                        Hsep4(0,"",
                           Henc(0, Text("("), Text(")"), tmp),
                           Text(" % "),
                           Number(d),
                           Text(" ==0")
                        )
                     ),
                     Henc(INDENT, Text("{  "), Text("\n}"),
                        Vsep2(0,"",
                           Hsep6(0,"",
                              Text(index->name),
                              Text(" = "),
                              Henc(0, Text("("), Text(")"), tmp),
                              Text(" / "),
                              Number(d),
                              Text(";")
                           ),
                           C3->code
                        )
                     )
                  );
         }
      }

      /* move the equations to context */
      free_node(e.a);
      C3->code = out;
      return C3;
   }

   /* since its better to generate an equation to fix an index, */
   /* rather than a loop and test, choose a loop index that will */
   /* take an equality from two free indices to one free index */
   /* The program gaurantees that all equations at this point have */
   /* at least two free indices... */

   /* time indices must be scanned in order */
   /* therefore, choose the left-most free index to scan */

   /* III. Generate for loops for inequalities with at least one */
   /*      free index and equalities with at least two free indices */
   {  item *for_loop;
      int j, k;
      node *X2;
        
      /* set ix to position of of the first FREE index */
      for (i=Z->the.list.first, ix=1; ix<dimension; i=i->next, ix++)
      {  index     = lookup_index(i);
         if (index->status==FREE) break;
      }
      index->status = FIXED;
      index->stamp = (++index_stamp);

#ifdef DEBUG
printf("\t-->Generate a for-loop for index %s\n", index->name);
#endif

      D = node2domain(X);
#ifdef DEBUG
printf("Loop Domain = ");
print_dom( Z,D,0 );
#endif

      /* create a line matrix in direction of free indices (except at ix) */
      M   = Matrix_Alloc(dimension-1, dimension+1);
      Vector_Init(M->p_Init, (dimension-1)*(dimension+1));
      k=0;
      for (i=Z->the.list.first, j=1; j<dimension; i=i->next, j++)
      {  if (j!=ix && index_status(i)==FREE)
         { value_set_si(M->p[k][j],1);
            k++;
         }
      }
      M->NbRows = k;
  
      /* add lines */
      if (M->NbRows!=0)
      {   D1 = DomainAddRays(D, M, MAXRAYS);
          Domain_Free(D);
      }
      else D1 = D;
#ifdef DEBUG
printf("After lines added = ");
print_dom( Z,D1,0 );
printf("Context = ");
print_dom( Z,C2->dom,0 );
#endif

      /* simplify in context */
      D2 = DomainSimplify(D1, C2->dom, MAXRAYS);
#ifdef DEBUG
printf("simplified loop domain = ");
print_dom( Z,D2,0 );
#endif

      /* compute new context */
      new_context = DomainIntersection(C2->dom, D1, MAXRAYS);
      Domain_Free(C2->dom);
      C2->dom = new_context;
#ifdef DEBUG
printf("new context = ");
print_dom( Z,C2->dom,0 );
#endif

      /* X (continuing) is DomainSimplify(D, new_context); */

      /* cleanup */
      Domain_Free(D1);
      Matrix_Free(M);
      X2 = domain2node(D2);

      /* fabien: added 2 lines 28/10/97. */
      /* should avoid nasty messages (create_loop: no [lower|upper] bound) */
      if (X2->the.dom.pol->the.list.first->the.pol.nb_constraints == 1)
	return control_domain(X,C2);

      Domain_Free(D2);
      for_loop = create_loop(Z,
                    X2->the.dom.pol->the.list.first->the.pol.constraints,ix);

      C3 = control_domain(X,C2);
      Domain_Free(C2->dom);
      free(C2);
      out = Vsep2(0,"",
               for_loop,
               Henc(INDENT, Text("{  "), Text("\n}"),
                  C3->code
               )
            );
      C3->code = out;
      return C3;
   }
}

/*----------------------------------------------------------------------*/
/* initialize_context(n1,G_dim,G_val,Context)                           */
/*	n1 : (node *) node tree of parameter domain                     */
/*	G_dim : (int) number of parameters                              */
/*	G_val : (int *) vector of parameter values                      */
/* initializes Context                                                  */
/* initializes index tracking system                                    */
/* returns an item tree of [ #define N 2 ] kind of definitions          */
/*----------------------------------------------------------------------*/
item *initialize_context(n1,G_dim,G_val,Context)
node *n1;	/* node tree of parameter domain */
int G_dim;	/* number of parameters */
int *G_val;	/* vector of parameter values */
context_info *Context; /* pointer to context information */
{  node *p;
   int i;
   item *tmp, *tmp2, *out=(item *)0, *last;
   Matrix *P;
   Polyhedron *D, *D0;

   D = node2domain(n1);
   if (G_dim!= D->Dimension)
   {   fprintf(stderr, "? Wrong number of parameters in -p switch.\n");
       exit(-1);
   }

   if (G_val)
   {   P = Matrix_Alloc(G_dim, G_dim+2);
       Vector_Init(P->p_Init, G_dim*(G_dim+2));
       for (i=0; i<G_dim; i++)
       {  value_set_si(P->p[i][i+1],-1);
          value_set_si(P->p[i][G_dim+1],G_val[i]);
       }

       D0    = DomainAddConstraints(D, P, MAXRAYS);
       Domain_Free(D);
       Matrix_Free(P);

       if (emptyQ(D0))
       {  fprintf(stderr,
          "? Parameters in -p switch do not verify parameter constraints.\n");
          exit(-1);
       }
       D = D0;
   }

   /* initialize the context */
   Context->dom = D;
   Context->index = n1->the.dom.index;
   Context->code = (item *) 0;
   Context->body = (item **) 0;
   Context->index_stamp = D->Dimension;

   for (p = n1->the.dom.index->the.list.first, i=0; p; p=p->next, i++)
       mark_index(p, FIXED);

   if (G_val)
   {   out = last = Text("/* parameters */");
       if (G_dim != 0)
       {  for (p = n1->the.dom.index->the.list.first, i=0; p; p=p->next, i++)
          {  tmp = Text("");
             sprint_name(tmp->the.text.string,p);
             tmp2 = Hsep3(0, " ",
                       Text("#define"),
                       tmp,
                       Number(G_val[i])
                    );
                    last->next = tmp2;
                    last = tmp2;
          }
       }
   }
   else
   {   out = Text("/* parameters not fixed at compile time */");
   }
   return Vsep1(0, "", out);
};


/*----------------------------------------------------------------------*/
/* compute_W(D, numP, valP, l1, w1)                                     */
/*        D : the domain                                                */
/*        C : the context domain (must have parameters fixed)           */
/*       DZ : indices of D, node list of ids                            */
/*       CZ : indices of C, node list of ids                            */
/*       l1 : the lower bound vector (output)                           */
/*       w1 : the weighting vector (output)                             */
/* Finds the bounding box of D and computes the associated l and w vecs */
/*----------------------------------------------------------------------*/

void compute_W(D, C, DZ, CZ, l1, w1)
Polyhedron *D,*C;		/* domain to be allocated */
node *DZ, *CZ;			/* indices */
int **l1, **w1;			/* output vectors */
{  /* Matrix *P; */
   Polyhedron *D1, *D0, *D2;
   int i, j, d, x, *u, *l, *w, status, NbRay, Dim, Dim2;
   Value  **Ray,*p;

   int *types_array, type;
   /*
   P = Matrix_Alloc(numP, D->Dimension+2);
   Vector_Init(P->p_Init, numP*(D->Dimension+2));
   for (i=0; i<numP; i++)
   {  value_set_si(P->p[i][D->Dimension+1-numP+i],-1);
      value_set_si(P->p[i][D->Dimension+1],valP[i]);
   } 
   D0    = DomainAddConstraints(D, P, MAXRAYS);
   Matrix_Free(P);
   */

   D2    = domain2aligned_domain(C, CZ, DZ);
   D0    = DomainIntersection(D, D2, MAXRAYS);
   D1    = DomainConvex(D0, MAXRAYS);
   Domain_Free(D0);
   Domain_Free(D2);
   if ( emptyQ(D1) )
   {   printf("? compute_W: empty domain\n"); 
       Domain_Free(D1);
       *l1 = (int *)0;
       *w1 = (int *)0;
   }
   Ray   = D1->Ray;
   NbRay = D1->NbRays;
   Dim   = D1->Dimension;
   Dim2  = Dim - CZ->the.list.count;
   w = (int *) malloc((Dim2+1)*sizeof(int));
   l = (int *) malloc((Dim2)*sizeof(int));
   u = (int *) malloc((Dim2)*sizeof(int));
   for (i=0; i<NbRay; i++)
   {  p = Ray[i];
   /* status = *p++; */
   status = VALUE_TO_INT(*p);
   p++;
   d = VALUE_TO_INT(p[Dim]);
   if (d==0)		/* a ray or line ... */
      {  /* printf("? compute_W: infinite domain\n"); */
         Domain_Free(D1);
         free(u);
         free(l);
         free(w);
         *l1 = 0;
         *w1 = 0;
         return;
      }
      if (i==0) for (j=0; j<Dim2; j++)
      {  x = VALUE_TO_INT(p[j]);
         l[j] = x>=0 ? x/d       : -(-x+d-1/d);
         u[j] = x>=0 ? (x+d-1)/d : -(-x/d);
      }
      else for (j=0; j<Dim2; j++)
      {  x = VALUE_TO_INT(p[j]); x = x>=0 ? x/d       : -(-x+d-1/d);
         if (x<l[j]) l[j] = x;
         x = VALUE_TO_INT(p[j]); x = x>=0 ? (x+d-1)/d : -(-x/d);
         if (x>u[j]) u[j] = x;
      }
   }
   Domain_Free(D1);
   types_array=indices_types(DZ);  
   w[0] = 1;
   for (i=1; i<=Dim2; i++)  {  
     switch (type = types_array[i-1])
       {
       case 1:
	 u[i-1]=l[i-1]=0;
	 break;
       case 0:
	 break;
       default:
	 l[i-1] = 0; 
	 u[i-1] = l[i-1] + type -1;
       }
     w[i] = w[i-1]*(u[i-1]-l[i-1]+1);
   }
   free(types_array);
   free(u);
   *l1 = l;
   *w1 = w;
}


/*----------------------------------------------------------------------*/
/* node2domain(D)                                                       */
/*       D : input domain (node tree)                                   */
/* returns a Polyhedron * of the same domain                            */
/*----------------------------------------------------------------------*/
Polyhedron *node2domain(D)
     node *D;
{  Polyhedron *p, *p1, *result;
   node *P, *C;
   int *K, *tmp;
   Value *KVal,*KValTemp;
   int  dimension, i, j;
   Matrix *M;

   if (D->type != dom)
   {  fprintf(stderr, "node2domain: ? node tree is not a domain\n");
      exit(-1);
   }
   dimension = D->the.dom.dim+1;
   result    = p = (Polyhedron *) 0;
   for (P=D->the.dom.pol->the.list.first; P; P=P->next)
   {  p1 = p;
      if (P->the.pol.nb_constraints != P->the.pol.constraints->the.list.count)
      {  fprintf(stderr, "node2domain: ?node nb_constraints doesn't agree\n");
      }
      M = Matrix_Alloc(P->the.pol.constraints->the.list.count, dimension+1);
      if (!M) {printf("? Out of memory\n"); return 0; }

      for (i=0, C = P->the.pol.constraints->the.list.first; C; C=C->next, i++)
      {  K=C->the.vec.val;
      
       /* original call 
          tmp = (int *) malloc(dimension*sizeof(int));
          Vector_Normalize(&K[1], tmp, dimension);
          free(tmp);
          replaced by : */
      
      KVal = (Value *)malloc((dimension+1)*sizeof(Value));
      KValTemp=KVal;
      for (j=0; j<=dimension ; j++)
        {        
          value_init(*KValTemp);
          value_set_si(*KValTemp,K[j]);
          KValTemp++;
        } ;

      
      Vector_Normalize(&KVal[1], dimension);	/* reduce to lowest form */
      KValTemp=KVal;
      for (j=0; j<=dimension ; j++)
        {
          value_assign(M->p[i][j], KVal[j]);
          value_clear(KVal[j]);
        } ;
      
      free(KVal);
      }
      p = Constraints2Polyhedron(M, MAXRAYS);
      if (p1) p1->next = p; else result = p;
      Matrix_Free(M);
   }
   return(result);
}

/*----------------------------------------------------------------------*/
/* domain2node                                                          */
/*     p : domain input (Polyhedron *)                                  */
/* Converts a domain from a Polhedron * to a node tree                  */
/* Clears the result->the.dom.index                                     */
/*----------------------------------------------------------------------*/
node *domain2node(p)
Polyhedron *p;
{  node *res, *n0, *n1, *n2, *n3;
   int *n4;
   Polyhedron *p1;
   int i, j;

   res = new_node(dom);
   res->the.dom.dim = p->Dimension;
   res->the.dom.index = (node *)0;
   n0 = res->the.dom.pol = new_list(0);
   for (p1 = p; p1; p1=p1->next)
   {  n1 = new_node(pol);
      n1->the.pol.nb_constraints = p1->NbConstraints;			   
      n1->the.pol.nb_equations = p1->NbEq;			   
      n2 = n1->the.pol.constraints = new_list(0);
      for (i=0; i<p1->NbConstraints; i++)
      {  n3 = new_node(vec);
         n3->the.vec.dim = p->Dimension+2;
         n3->the.vec.val = n4 = (int *) malloc(n3->the.vec.dim * sizeof(int));
         for (j=0; j<n3->the.vec.dim; j++) n4[j] = (VALUE_TO_INT(p1->Constraint[i][j]));
         add_to_list(n2,n3);
      }
      if (n1->the.pol.nb_constraints != n1->the.pol.constraints->the.list.count)
         fprintf(stderr, "domain2node: ?node nb_constraints doesn't agree\n");

      add_to_list(n0,n1);
   }
   return res;
}

/*----------------------------------------------------------------------*/
/* node2aligned_domain(D,I1,I2)                                         */
/*       D : input domain (node tree)                                   */
/*      I1 : index list of D (input)                                    */
/*      I2 : index list of output                                       */
/* converts D to a Polyhedron * with indices aligned to I2              */
/*----------------------------------------------------------------------*/
Polyhedron *node2aligned_domain(D,I1,I2)
     node *D, *I1, *I2;
{  Polyhedron *p, *p1, *result;
   node *P, *C, *i1, *i2;
   int *K, *x;
   int  dimension, i, j, ix1, ix2;
   Matrix *M;

   /* Make a correspondance table between D and the output */
   x = (int *) malloc ( (I1->the.list.count+2)*sizeof(int) );

   /* all indices in I1 must appear in I2 */
   for ( ix1=1, i1=I1->the.list.first; i1; ix1++, i1=i1->next )
   {  for ( ix2=1, i2=I2->the.list.first; i2; ix2++, i2=i2->next )
      {  if (!strcmp(i1->the.id.name, i2->the.id.name))
         {  x[ix1]=ix2;
            break;
         }
      }
      if (!i2) /* correspondance not found */
      {  fprintf(stderr,
         "node2aligned_domain: ? index %s not found in context\n",
         i1->the.id.name);
         x[ix1] = 0;	/* put it temporarily in the status bit... */
      }
   }
   x[I1->the.list.count+1] = I2->the.list.count+1; /* map the constant */
   x[0] = 0;                                       /* map the status bit */

   dimension = I2->the.list.count;
   result    = p = (Polyhedron *) 0;
   for (P=D->the.dom.pol->the.list.first; P; P=P->next)
   {  p1 = p;
      M = Matrix_Alloc(P->the.pol.nb_constraints, dimension+2);
      if (!M) {printf("? Out of memory\n"); return 0; }
      Vector_Init( M->p_Init, (P->the.pol.nb_constraints) * (dimension+2) );

      for (i=0, C = P->the.pol.constraints->the.list.first; C; C=C->next, i++)
      {  for (j=1, K=C->the.vec.val; j<I1->the.list.count+2; j++)
            value_set_si(M->p[i][x[j]],K[j]);
         value_set_si(M->p[i][0], K[0]); 
         /* the status bit (last to overwrite bad maps) */
      }
      p = Constraints2Polyhedron(M, MAXRAYS);
      if (p1) p1->next = p; else result = p;
      Matrix_Free(M);
   }
   free(x);
   return(result);
}

/*----------------------------------------------------------------------*/
/* domain2aligned_domain(D,I1,I2)                                       */
/*       D : input domain (Polyhedron *)                                */
/*      I1 : index list of D (input)                                    */
/*      I2 : index list of output                                       */
/* converts D to a Polyhedron * with indices aligned to I2              */
/*----------------------------------------------------------------------*/
Polyhedron *domain2aligned_domain(D,I1,I2)
     Polyhedron *D;
     node *I1, *I2;
{  Polyhedron *p, *p1, *P, *result;
   node *i1, *i2;
   int *x;
   int  dimension, i, j, ix1, ix2;
   Matrix *M;

   if (!D) return D;

   dimension = I2->the.list.count;	/* output dimension */
   if (D->Dimension!=I1->the.list.count) /* input dimension check */
   {  fprintf(stderr, "domain2aligned_domain: ?dimensions don't agree.\n");
   }

   /* Make a correspondance table between D and the output */
   x = (int *) malloc ( (I1->the.list.count+2)*sizeof(int) );

   /* all indices in I1 must appear in I2 */
   for ( ix1=1, i1=I1->the.list.first; i1; ix1++, i1=i1->next )
   {  for ( ix2=1, i2=I2->the.list.first; i2; ix2++, i2=i2->next )
      {  if (!strcmp(i1->the.id.name, i2->the.id.name))
         {  x[ix1]=ix2;
            break;
         }
      }
      if (!i2) /* correspondance not found */
      {  fprintf(stderr,
         "domain2aligned_domain: ? index %s not found in context\n",
         i1->the.id.name);
         x[ix1] = 0;	/* put it temporarily in the status bit... */
      }
   }
   x[I1->the.list.count+1] = I2->the.list.count+1; /* map the constant */
   x[0] = 0;                                       /* map the status bit */

   result = p = (Polyhedron *) 0;
   for (P=D; P; P=P->next)
   {  p1 = p;
      M = Matrix_Alloc(P->NbConstraints, dimension+2);
      if (!M) {printf("? Out of memory\n"); return 0; }
      Vector_Init( M->p_Init, (P->NbConstraints) * (dimension+2) );

      for (i=0; i<P->NbConstraints; i++)
      {  for (j=1; j<(I1->the.list.count+2); j++)
        value_assign(M->p[i][x[j]], P->Constraint[i][j]);
         /* bad maps were written to status bit */
         value_assign(M->p[i][0],P->Constraint[i][0]);
         /* the status bit (must do last) */
      }
      p = Constraints2Polyhedron(M, MAXRAYS);
      if (p1) p1->next = p; else result = p;
      Matrix_Free(M);
   }
   free(x);
   return(result);
}