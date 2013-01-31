/*  file: $MMALPHA/sources/Code_Gen/nodeprocs.c
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
#include <stdio.h>
#include <stdlib.h>
#include <polylib/polylib.h>
#include "../Write_Alpha/item.h"
#include "node.h"
#include "nodeprocs.h"

void            yyerror();

/*------------------------------------------------------------------*/
/* node allocation/deallocation system                              */
/*------------------------------------------------------------------*/

/* return a new node of type t */
node *new_node(t)
   nodetype        t;
{
   node           *n;

   n = (node *) malloc(sizeof(node));
   if (!n) {
      yyerror("new_node: out of memory");
      exit(-1);
   }
   n->type = t;			/* and initialize it */
   n->next = (node *) 0;
   n->index = -1;
   return n;
}

/* create a new id node for string s */
node *new_id(s)
   char           *s;
{
   node *n;
   char	*txt, *c;
   n = (node *) malloc(sizeof(node) + strlen(s));  /* more than big enough */
   if (!n) {
      yyerror("new_id: out of memory");
      exit(-1);
   }
   n->type = id;		/* type is id node */
   n->index = -1;		/* initialize index */
   n->next = (node *) 0;
   txt = n->the.id.name;
   for (c = s+1; *c;)
   {  if (*c == '\\')
      {  *txt++ = *c++;  /* copy the backslash */
         *txt++ = *c++;  /* and take the next character literally */
         continue;
      }
      if (*c == '"') break;
      *txt++ = *c++;
   }
   *txt = '\0';
   /* strcpy(n->the.id.name, s); */	/* copy the string */
   return n;
}

/* free an old node n */
void free_node(n)
   node           *n;
{  node *q, *nx;

   if (!n) return;
   if (n->type==list)
     for (q=n->the.list.first; q; q=nx) { nx = q->next; free_node(q); }
   free(n);
}

/*
 * create a node list consisting of element e, or empty list if e is 0
 */
node *new_list(e)
   node           *e;
{
   node           *n;
   n = new_node(list);
   n->the.list.last = n->the.list.first = e;
   if (e) {
      n->the.list.count = 1;
      e->index = 0;
   } else
      n->the.list.count = 0;
   return n;
}

/*------------------------------------------------------------------*/
/* list management system                                           */
/*------------------------------------------------------------------*/

/* add node e to end of list n, return the list */
/* n must be list type */
node *add_to_list(n, e)
   node *e, *n;
{
   if (n && (n->type != list)) {
      yyerror("add: node is not a list");
      return n;
   }
   if (!e)
      return n;
   if (!n)
      return new_list(e);
   if (n->the.list.last) {
      n->the.list.last->next = e;
      n->the.list.last = e;
   } else {			/* list is empty */
      n->the.list.last = n->the.list.first = e;
   }
   e->index = n->the.list.count;
   e->next = (node *) 0;	/* make sure its last in list */
   n->the.list.count++;
   return n;
}

void remove_from_list(n, e)
   node *e, *n;
{  node *p, *p1;
   if (!n || !e || (n && (n->type != list)))
   {  yyerror("remove: ? node is not a list");
      return;
   }
   for (p1=(node *)0,p=n->the.list.first; p; p1=p,p=p->next)
   {  if (p==e)
      {  if (p1) p1->next=p->next;
         else n->the.list.first=p->next;
         n->the.list.count--;
         return;
      }
   }
}
