/*  file: $MMALPHA/sources/Pretty/readitem.c
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
/*
 * This program outputs a typeset piece of text
 */

#include <stdio.h>
#include <stdlib.h>
#include "item.h"
#include "itemprocs.h"
#include "writeitem.h"

typedef
struct token_type_ {
        union {
                struct {
                        int             value;
                }               number;
                struct {
                        char            string[128];
                }               text;
        }               the;
}               token_type;

static token_type      token;
static item            *head;

#include "lex.c"
FILE *ref=0;

static void
open_paren_test(identifier)
   char            identifier[];
{
   if (yylex() != '(') {
      printf("An open parenthesis was expected by %s .", identifier);
      exit(1);
   }
}

static void
close_paren_test(identifier)
   char            identifier[];
{
   if (yylex() != ')') {
      printf("A close parenthesis was expected by %s .", identifier);
      exit(1);
   }
}

static void
comma_test(identifier)
   char            identifier[];
{
   if (yylex() != ',') {
      printf("A comma was expected by %s .", identifier);
      exit(1);
   }
}

static item           *
read_item()
{
   item           *i, *new, **p;
   int             t, type;

   switch (type=yylex()) {
   case number:
      i = new_item(number);
      i->the.number.value = token.the.number.value;
      return (i);
   case text:
      new = (item *) malloc(sizeof(item));
      t = strlen(token.the.text.string) - strlen(new->the.text.string);
      i = (item *) malloc(sizeof(item) + t);
      i->type = text;
      i->next = (item *) 0;
      strcpy(i->the.text.string, token.the.text.string);
      return (i);
   case ')':
      return (0);
   case ',':
      printf("Misplaced comma detected.\n");
      exit(1);
   case hlis:
   case hsep:
      open_paren_test("hsep or hlis");
      i = (type==hsep) ?  new_item(hsep) : new_item(hlis);
      t = yylex();
      if (t == number) {
	 i->the.hsep.indent = token.the.number.value;
	 comma_test("hsep or hlis");
	 t = yylex();
      } else
	 i->the.hsep.indent = 0;
      if (t != text) {
	 printf("A textual separator was expected for the hsep.\n");
	 exit(1);
      }
      strcpy(i->the.hsep.sep, token.the.text.string);
      comma_test("hsep or hlis");
      p = &(i->the.hsep.item_list);
      for (;;) {
	 *p = read_item();
	 if (!*p)
	    break;
	 p = &((*p)->next);
	 t = yylex();
	 if (t == ',')
	    continue;
	 else if (t == ')')
	    break;
	 else {
	    printf("Neither a \",\" nor a \")\" found for hsep or hlis.\n");
	    exit(1);
	 }
      }
      return (i);
   case vsep:
   case vlis:
      open_paren_test("vsep or vlis");
      i = (type==vsep) ? new_item(vsep) : new_item(vlis);
      t = yylex();
      if (t == number) {
	 i->the.vsep.indent = token.the.number.value;
	 comma_test("vsep or vlis");
	 t = yylex();
      } else
	 i->the.vsep.indent = 0;

      if (t != text) {
	 printf("A textual separator was expected for the vsep or vlis.\n");
	 exit(1);
      }
      strcpy(i->the.vsep.sep, token.the.text.string);
      comma_test("vsep2 or vlis2");
      p = &(i->the.vsep.item_list);
      for (;;) {
	 *p = read_item();
	 if (!*p)
	    break;
	 p = &((*p)->next);
	 t = yylex();
	 if (t == ',')
	    continue;
	 else if (t == ')')
	    break;
	 else {
	    printf("Neither a \",\" nor a \")\" found for the vsep or vlis.\n");
	    exit(1);
	 }
      }
      return (i);
   case hspa:
      open_paren_test("hspa");
      i = new_item(hspa);
      if (yylex() != number) {
	 printf("An integer value was expected for hspa.\n");
	 exit(1);
      } else
	 i->the.hspa.n = token.the.number.value;
      close_paren_test("hspa");
      return (i);
   case vspa:
      open_paren_test("vspa");
      i = new_item(vspa);
      if (yylex() != number) {
	 printf("An integer value was expected for the vspa.\n");
	 exit(1);
      } else
	 i->the.vspa.n = token.the.number.value;
      close_paren_test("vspa");
      return (i);

   case henc:
      open_paren_test("henc");
      i = new_item(henc);
      if (yylex() != number) {
	 printf("An integer was expected for henc.\n");
	 exit(1);
      }
      i->the.henc.indent = token.the.number.value;
      comma_test("henc");
      i->the.henc.open = read_item();
      if (i->the.henc.open == 0) {
	 printf("Missing opener for henc.\n");
	 exit(1);
      }
      comma_test("henc");
      i->the.henc.close = read_item();
      if (i->the.henc.close == 0) {
	 printf("Missing close for henc.\n");
	 exit(1);
      }
      comma_test("henc");
      i->the.henc.body = read_item();
      if (i->the.henc.body == 0) {
	 printf("Missing body for henc.\n");
	 exit(1);
      }
      close_paren_test("henc");
      return (i);

   case venc:
      open_paren_test("venc");
      i = new_item(venc);
      if (yylex() != number) {
	 printf("An integer was expected for venc.\n");
	 exit(1);
      }
      i->the.venc.indent = token.the.number.value;
      comma_test("venc");
      i->the.venc.open = read_item();
      if (i->the.venc.open == 0) {
	 printf("Missing opener for venc.\n");
	 exit(1);
      }
      comma_test("venc");
      i->the.venc.close = read_item();
      if (i->the.venc.close == 0) {
	 printf("Missing close for venc.\n");
	 exit(1);
      }
      comma_test("venc");
      i->the.venc.body = read_item();
      if (i->the.venc.body == 0) {
	 printf("Missing body for venc.\n");
	 exit(1);
      }
      close_paren_test("venc");
      return (i);
   default:
      printf("? read_item : Unknown type\n");
      exit(1);
   }
}

main()
{
   head = read_item();
   print_item(head);
   printf("\n");
}
