 /*  file: $MMALPHA/sources/Pretty/writeitem.c
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
/*
 * This program outputs a typeset piece of text
 */

#include <stdio.h>
#include <stdlib.h>
#include "item.h"

extern FILE *yyout, *ref;
extern FILE *erreurs;

/* current position of last character written */
int     currentpos = 0, currentline=1;

/* margins */
int	leftmargin = 0, rightmargin = TEXTLENGTH;

/* globals for position cross referencing */
static	int pos_index=0, save_position=0;
static  struct{int n, col, line;} position[TEXTLENGTH];

static int
len_item(i)
   item           *i;
{
   int             len, count;
   char            s[16], *c;
   item           *current, *j;

   if (!i) return 0;
   switch (i->type) {

   case vspa:
      return 0;
   case text:
      for (c=i->the.text.string; *c!=0 && *c!='\n'; c++) /* null */ ;
      return (c - i->the.text.string);
      break;
   case number:
      sprintf(s, "%d", i->the.number.value);
      return (strlen(s));
      break;
   case hspa:
      return(i->the.hspa.n);
   case hsep:
      len = 0;
      count = 0;
      for (current = i->the.hsep.item_list; current; current = current->next) {
	 len = len + len_item(current);
	 count++;
      }
      if (count) count--;
      len = len + (count * strlen(i->the.hsep.sep));
      return (len);
      break;
   case hlis:
      len = 0;
      count = 0;
      for (current = i->the.hlis.item_list; current; current = current->next) {
         len = len + len_item(current);
         count++;
      }
      len = len + (count * strlen(i->the.hlis.sep));
      return (len);
      break;
   case vsep:
   case vlis:
      return (len_item(i->the.vsep.item_list) + strlen(i->the.vsep.sep));
   case henc:
      return (len_item(i->the.henc.open) + len_item(i->the.henc.body) +
	      len_item(i->the.henc.close));
      break;
   case venc:
      return (len_item(i->the.venc.open));
      break;
   case pos:
      return (len_item(i->the.pos.body));
      break;
   case align:
      return 0;
      break;
   default:
      fprintf(stderr,"? len_item : Unknown type\n");
      exit(1);
   }
}

static void newline()
{
   if (currentpos != 0) {
      fputc('\n', yyout);
      currentpos = 0;
      currentline++;
   }
   while (currentpos < leftmargin) {
      fputc(' ',yyout);
      currentpos++;
   }
   currentpos = leftmargin;
}

static void test(space)
   int             space;

{
   if (space + currentpos > rightmargin)
      newline();
}

static void align_to_margin(margin)
int margin;
{  if (currentpos>margin)
   {    fputc('\n', yyout);
        currentpos = 0;
        currentline++;
   }

   while (currentpos < margin) {
      fputc(' ', yyout);
      currentpos++;
   }
}

static void print_text(x)
char *x;
{  char *c;

  for (c=x; *c!=0 && *c!='\n'; c++) /* null */ ;
  test(c - x);
  for (c=x; *c; c++)
  {   currentpos++;		/* forces the newline for '/n' */
      if (*c=='\n') newline();
      else fputc(*c, yyout);
  }
}


/* print_item_list: shortcut for debug only */
void print_item_list(x)  
   item           *x;
{
   int             i, temp, length = 0, size;
   char            s[16], *c;
   item           *current;
   
   current=x;

   print_item(current);
   while (current->next)  
     {  
       current = current->next;
       print_item(current);
     };
            
}

void print_item(x)
   item           *x;
{
   int             i, temp, length = 0, size;
   char            s[16], *c;
   item           *current;

   if (!x) return;

   /* change the margin first */
   switch (x->type)
   { case hsep:
       leftmargin = (leftmargin + x->the.hsep.indent);
       break;
     case vsep:
       leftmargin = (leftmargin + x->the.vsep.indent);
       break;
   }

   size = len_item(x);

   if (((currentpos + size) > rightmargin)
     && ((leftmargin + size) < rightmargin)) newline();

   if (save_position)
   {  position[pos_index].col = currentpos+1;
      position[pos_index].line = currentline;
      pos_index++;
      save_position = 0;
   }

   switch (x->type) {
   case vspa:
      for (i = 0; i < (x->the.vspa.n); i++)
      {	 fputc('\n',yyout);
	 currentline++;
      }
      for (i = 0; i < leftmargin; i++)
	 fputc(' ',yyout);
      currentpos = leftmargin;
      break;

   case number:
      sprintf(s, "%d", x->the.number.value);
      test(strlen(s));
      fprintf(yyout,"%s", s);
      currentpos = currentpos + strlen(s);
      break;

   case text:
      print_text(x->the.text.string);
      break;

   case hspa:
      test(x->the.hspa.n);
      if (currentpos > leftmargin) {
	 for (i = 0; i < (x->the.hspa.n); i++) {
	    fputc(' ',yyout);
	    currentpos++;
	 }
      }
      break;

   case hsep:
      for (current = x->the.hsep.item_list; current;
	   current = current->next)
      {  print_item(current);
         while (current->next)  /* drop empty terms */
         {  if (current->next->type==pos && !current->next->the.pos.body)
            {  current->next = current->next->next;
               continue;
            }
            else break;
         }
	 if (current->next) print_text(x->the.hsep.sep);
      }
      leftmargin = (leftmargin - x->the.hsep.indent);
      break;

   case hlis:
      for (current = x->the.hlis.item_list; current;
           current = current->next)
      {  print_item(current);
         while (current->next)  /* drop empty terms */
         {  if (current->next->type==pos && !current->next->the.pos.body)
            {  current->next = current->next->next;
               continue;
            }
            else break;
         }
         print_text(x->the.hlis.sep);
      }
      leftmargin = (leftmargin - x->the.hlis.indent);
      break;

   case vsep:
      for (current = x->the.vsep.item_list; current;
	   current = current->next)
      {  print_item(current);
         while (current->next)  /* drop empty terms */
         {  if (current->next->type==pos && !current->next->the.pos.body)
            {  current->next = current->next->next;
               continue;
            }
            else break;
         }
	 if (current->next)
         { print_text(x->the.vsep.sep);
	   newline();
	 }
      }
      leftmargin = (leftmargin - x->the.vsep.indent);
      break;

   case vlis:
      for (current = x->the.vlis.item_list; current;
           current = current->next)
      {  print_item(current);
         while (current->next)  /* drop empty terms */
         {  if (current->next->type==pos && !current->next->the.pos.body)
            {  current->next = current->next->next;
               continue;
            }
            else break;
         }
         print_text(x->the.vlis.sep);
         if (current->next) newline();
      }
      leftmargin = (leftmargin - x->the.vlis.indent);
      break;

   case henc:
      print_item(x->the.henc.open);
      leftmargin = (leftmargin + x->the.henc.indent);
      print_item(x->the.henc.body);
      leftmargin = (leftmargin - x->the.henc.indent);
      print_item(x->the.henc.close);
      break;

   case venc:
      align_to_margin(leftmargin);
      print_item(x->the.venc.open);
      leftmargin = (leftmargin + x->the.venc.indent);
      newline();
      print_item(x->the.venc.body);
      leftmargin = (leftmargin - x->the.venc.indent);
      newline();
      print_item(x->the.venc.close);
      break;

   case pos:
      if (!x->the.pos.body) break;	/* no xref for empty trees */
      position[pos_index].n = x->the.pos.n;
      /* save col, line and increment pos_index after aligning to margin */
      save_position = 1;	/* command to save after alignment */
      print_item(x->the.pos.body);
      if (x->the.pos.body->next)
	 fprintf(stderr, "? write_item : Illegal command Pos[list]\n");
      pos_index--;
      if (ref)
      {  fprintf(ref, "{{%d,%d},\t{%d,%d},\t{",position[pos_index].line,
            position[pos_index].col, currentline, currentpos);
         for (i=0; i<=pos_index; i++)
         {   fprintf(ref, "%d",position[i].n);
             if (i<pos_index) fputc(',',ref);
         }
         fprintf(ref,"}},\n");
      }
      break;

   case align:
      while (currentpos < (leftmargin + x->the.align.n) )
      { fputc(' ', yyout);
        currentpos++;
      }
      break;

   default:
      fprintf(stderr,"? print_item : Unknown type\n");
      exit(1);
   }
}
