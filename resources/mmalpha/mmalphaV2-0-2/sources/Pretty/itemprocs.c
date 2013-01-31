 /*  file: $MMALPHA/sources/Pretty/itemprocs.c
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

/*-------------------------------------------------------------------*/
/* item utility procedures                                           */
/*-------------------------------------------------------------------*/

item *new_item(spec_type)
item_type     spec_type;
{
   item           *new;
   new = (item *) malloc(sizeof(item));
   new->type = spec_type;
   new->next = (item *) 0;
   return (new);
}

item *new_text(txt)    /* used for constants only */
char *txt;
{  item *out;
   out = new_item(text);
   strcpy(out->the.text.string, txt);
   return out;
}
	
item *new_number(x)    /* used for constants only */
int x;
{  item *out;
   out = new_item(number);
   out->the.number.value = x;
   return out;
}
	
item *new_henc(indent, open, close, body)
int indent;
item *body, *open, *close;
{  item *out;
   out = new_item(henc);
   out->the.henc.indent = indent;
   out->the.henc.open = open;
   out->the.henc.close = close;
   out->the.henc.body = body;
   return out;
}

item *new_hsep(indent, sep, body)
int indent;
char sep[SEPLENGTH];
item *body;
{  item *out;
   out = new_item(hsep);
   out->the.hsep.indent = indent;
   strncpy(out->the.hsep.sep, sep, SEPLENGTH);
   out->the.hsep.sep[SEPLENGTH - 1] = '\0'; 
   out->the.hsep.item_list = body;
   return out;
}

item *new_hlis(indent, sep, body)
int indent;
char sep[SEPLENGTH];
item *body;
{  item *out;
   out = new_item(hlis);
   out->the.hlis.indent = indent;
   strncpy(out->the.hlis.sep, sep, SEPLENGTH);
   out->the.hlis.sep[SEPLENGTH - 1] = '\0';
   out->the.hlis.item_list = body;
   return out;
}

item *new_venc(indent, open, close, body)
int indent;
item *body, *open, *close;
{  item *out;
   out = new_item(venc);
   out->the.venc.indent = indent;
   out->the.venc.open = open;
   out->the.venc.close = close;
   out->the.venc.body = body;
   return out;
}

item *new_vsep(indent, sep, body)
int indent;
char sep[SEPLENGTH];
item *body;
{  item *out;
   out = new_item(vsep);
   out->the.vsep.indent = indent;
   strncpy(out->the.vsep.sep, sep, SEPLENGTH);
   out->the.vsep.sep[SEPLENGTH - 1] = '\0'; 
   out->the.vsep.item_list = body;
   return out;
}

item *new_vlis(indent, sep, body)
int indent;
char sep[SEPLENGTH];
item *body;
{  item *out;
   out = new_item(vlis);
   out->the.vlis.indent = indent;
   strncpy(out->the.vlis.sep, sep, SEPLENGTH);
   out->the.vlis.sep[SEPLENGTH - 1] = '\0';
   out->the.vlis.item_list = body;
   return out;
}

item *new_vspa(val)
int  val;
{  item *out;
   out = new_item(vspa);
   out->the.vspa.n = val;
   return out;
}

item *new_hspa(val)
int  val;
{  item *out;
   out = new_item(hspa);
   out->the.hspa.n = val;
   return out;
}

item *new_pos(i, n)
item *i;
int n;
{  item *out;
   out = new_item(pos);
   out->the.pos.body = i;
   out->the.pos.n = n;
   return out;
}

item *new_align(n)
{  item *out;
   out = new_item(align);
   out->the.align.n = n;
   return out;
}

item *new_list1(i1)
item *i1;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list2(i1, i2)
item *i1, *i2;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list3(i1, i2, i3)
item *i1, *i2, *i3;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list4(i1, i2, i3, i4)
item *i1, *i2, *i3, *i4;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list5(i1, i2, i3, i4, i5)
item *i1, *i2, *i3, *i4, *i5;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list6(i1, i2, i3, i4, i5, i6)
item *i1, *i2, *i3, *i4, *i5, *i6;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list7(i1, i2, i3, i4, i5, i6, i7)
item *i1, *i2, *i3, *i4, *i5, *i6, *i7;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (i7) tail = head ? (tail->next = i7) : (head = i7);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list8(i1, i2, i3, i4, i5, i6, i7, i8)
item *i1, *i2, *i3, *i4, *i5, *i6, *i7, *i8;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (i7) tail = head ? (tail->next = i7) : (head = i7);
   if (i8) tail = head ? (tail->next = i8) : (head = i8);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list9(i1, i2, i3, i4, i5, i6, i7, i8, i9)
item *i1, *i2, *i3, *i4, *i5, *i6, *i7, *i8, *i9;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (i7) tail = head ? (tail->next = i7) : (head = i7);
   if (i8) tail = head ? (tail->next = i8) : (head = i8);
   if (i9) tail = head ? (tail->next = i9) : (head = i9);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list10(i1, i2, i3, i4, i5, i6, i7, i8, i9, i10)
item *i1, *i2, *i3, *i4, *i5, *i6, *i7, *i8, *i9, *i10;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (i7) tail = head ? (tail->next = i7) : (head = i7);
   if (i8) tail = head ? (tail->next = i8) : (head = i8);
   if (i9) tail = head ? (tail->next = i9) : (head = i9);
   if (i10) tail = head ? (tail->next = i10) : (head = i10);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list11(i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11)
item *i1, *i2, *i3, *i4, *i5, *i6, *i7, *i8, *i9, *i10, *i11;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (i7) tail = head ? (tail->next = i7) : (head = i7);
   if (i8) tail = head ? (tail->next = i8) : (head = i8);
   if (i9) tail = head ? (tail->next = i9) : (head = i9);
   if (i10) tail = head ? (tail->next = i10) : (head = i10);
   if (i11) tail = head ? (tail->next = i11) : (head = i11);
   if (tail) tail->next = (item *)0;
   return head;
}

item *new_list12(i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12)
item *i1, *i2, *i3, *i4, *i5, *i6, *i7, *i8, *i9, *i10, *i11, *i12;
{  item *head=0, *tail=0;
   if (i1) tail = head = i1;
   if (i2) tail = head ? (tail->next = i2) : (head = i2);
   if (i3) tail = head ? (tail->next = i3) : (head = i3);
   if (i4) tail = head ? (tail->next = i4) : (head = i4);
   if (i5) tail = head ? (tail->next = i5) : (head = i5);
   if (i6) tail = head ? (tail->next = i6) : (head = i6);
   if (i7) tail = head ? (tail->next = i7) : (head = i7);
   if (i8) tail = head ? (tail->next = i8) : (head = i8);
   if (i9) tail = head ? (tail->next = i9) : (head = i9);
   if (i10) tail = head ? (tail->next = i10) : (head = i10);
   if (i11) tail = head ? (tail->next = i11) : (head = i11);
   if (i12) tail = head ? (tail->next = i12) : (head = i12);
   if (tail) tail->next = (item *)0;
   return head;
}

item *add_to_ilist(i1,i2)
item *i1,*i2;
{ item* tmp;
  if (!i2) return i1;
  if (!i1) return i2;
  tmp = i1;
  while (tmp->next) tmp = tmp->next;
  tmp->next = i2;
  return i1;
}

int length_ilist(i1)
item *i1;
{ item* tmp = i1;
  int   len = 0;
  while (tmp) { tmp = tmp->next; len++; }
  return len;
}

item *copy_item(anitem)
item *anitem;
{
  item      *new;
  if (!anitem) return (item *)0;
  new = (item *) malloc(sizeof(item));
  new->type = anitem->type;
  new->prec = anitem->prec;
  switch (anitem->type) {
   case vspa:
    new->the.vspa.n = anitem->the.vspa.n;
      break;

   case number:
    new->the.number.value = anitem->the.number.value;
      break;

   case text:
    strcpy(new->the.text.string, anitem->the.text.string);
      break;

   case hspa:
    new->the.hspa.n = anitem->the.hspa.n;
      break;

   case hsep:
    new->the.hsep.indent = anitem->the.hsep.indent;
    new->the.hsep.item_list = copy_item(anitem->the.hsep.item_list);
    strncpy(new->the.hsep.sep,anitem->the.hsep.sep,SEPLENGTH);
      break;

   case hlis:
    new->the.hlis.indent = anitem->the.hlis.indent;
    new->the.hlis.item_list = copy_item(anitem->the.hlis.item_list);
    strncpy(new->the.hlis.sep,anitem->the.hlis.sep,SEPLENGTH);
      break;

   case vsep:
    new->the.vsep.indent = anitem->the.vsep.indent;
    new->the.vsep.item_list = copy_item(anitem->the.vsep.item_list);
    strncpy(new->the.vsep.sep,anitem->the.vsep.sep,SEPLENGTH);
      break;

   case vlis:
    new->the.vlis.indent = anitem->the.vlis.indent;
    new->the.vlis.item_list = copy_item(anitem->the.vlis.item_list);
    strncpy(new->the.vlis.sep,anitem->the.vlis.sep,SEPLENGTH);
      break;

   case henc:
    new->the.henc.indent = anitem->the.henc.indent;
    new->the.henc.open = copy_item(anitem->the.henc.open);
    new->the.henc.close = copy_item(anitem->the.henc.close);
    new->the.henc.body = copy_item(anitem->the.henc.body);
      break;

   case venc:
    new->the.venc.indent = anitem->the.venc.indent;
    new->the.venc.open = copy_item(anitem->the.venc.open);
    new->the.venc.close = copy_item(anitem->the.venc.close);
    new->the.venc.body = copy_item(anitem->the.venc.body);
      break;

   case pos:
    new->the.pos.body = copy_item(anitem->the.pos.body);
    new->the.pos.n    = anitem->the.pos.n;
      break;

   default:
      fprintf(stderr,"? copy_item : Unknown type\n");
      exit(1);
   }
  if (!anitem->next) new->next = (item *)0;
  else new->next = copy_item(anitem->next);
  return new;
}

item  *check_prec(a,b)
item     *a;
int      b;
{ return (a->prec < b) ? Henc(0, Text("("), Text(")"), a) : a;
}
