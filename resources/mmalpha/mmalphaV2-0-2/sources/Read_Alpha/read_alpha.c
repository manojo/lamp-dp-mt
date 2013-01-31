 /*  file: $MMALPHA/sources/Read_Alpha/read_alpha.c
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
   Place - Suite 330, Boston, MA  02111-1307, USA.*/
#define	GREETING "(* ALPHA Tree produced by read_alpha ver 4.0 (Doran) *)"

/*-----------------------------------------------------------------------*/
/* CHANGE LOG:                                                           */
/* v.3.3.4 -- Corrected problems with 'use' statement.                   */
/*            Added context processing to 'reduce' statement.            */
/* v.4.0   -- Added index[] and z-polyhedra                              */
/*-----------------------------------------------------------------------*/

/* #define _filbuf _flushfilbuf */
#include <stdio.h>

extern	FILE	*yyin, *yyout;
extern	int	lineNb;
extern  int     yynerrs, yywarns;
extern  int	keep_on_error;
	int     do_let;
static	int	no_greeting;
extern	int	isatty(int);
extern	char	*strcat(char *, const char *);

void yyerror(char *);
void yyerror2(char *, char *);
void yyerror3(char *, char *, char *);
void yywarning(char *);
void yywarning2(char *, char *);
void yywarning3(char *, char *, char *);

/* for lex debug -- */
#include <ctype.h>
#define allprint(x)	if (isprint(x)) putchar(x); else printf("%d",x)
#define sprint(x)	puts(x)

#include "yacc.c"

int main(argc, argv)
int argc;
char *argv[];
{ int status, arg;

  /* defaults */
  yyout = stdout;
  yyin  = stdin;
  yydebug = 0;
  status = '<';
  yynerrs = 0;
  yywarns = 0;
  keep_on_error = 0;
  do_let = 0;
  no_greeting = 0;

  /* read switches */
  for(arg=1; arg<argc; )
  {  if (*argv[arg]=='-')
     switch (argv[arg][1])
     {  case 'i':	/* input */
          yyin = fopen(argv[arg+1],"r");
          if (!yyin) 
          {  fprintf(stderr, "? Could not open \"%s\"\n", argv[arg+1]);
             exit(1);
          }
	  arg++;
          break;
        case 'I':       /* input */
          yyin = fdopen(atoi(argv[arg+1]),"r");
          if (!yyin)
          {  fprintf(stderr, "? Could not open \"%s\"\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
        case 'o':	/* output */
          yyout = fopen(argv[arg+1],"w");
          if (!yyout) 
          {  fprintf(stderr, "? Could not open \"%s\"\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
        case 'O':       /* output */
          yyout = fdopen(atoi(argv[arg+1]),"w");
          if (!yyout)
          {  fprintf(stderr, "? Could not open \"%s\"\n", argv[arg+1]);
             exit(1);
          }
          arg++;
          break;
        case 'd':	/* debug */
          yydebug = 1;
          break;
        case 'E':	/* parse expressions */
          status = '=';
          break;
        case 'D':	/* parse domains */
          status = ':';
          break;
        case 'M':	/* parse affine functions */
          status = '.';
          break;
	case 'k':	/* keep systems that have errors */
	  keep_on_error = 1;
	  break;
	case 'L':	/* use a let-block for sys[6] */
	  do_let = 1;
	  break;
	case 'g':	/* omit the greeting at the beginning of AST */
	  no_greeting = 1;
	  break;
	case 'p':	/* give context parameters: -p {N, M, P} */
	  id_context = id_param = new_list(0);
          for (arg++; arg<argc && *argv[arg]!='-'; arg++)
	  {  char *c=argv[arg];
             if (*c=='{') { argv[arg]++; c++; }
	     while (*c && *c!='}' && *c!=',') c++;
	     *c = '\0';
             add_to_list(id_param,new_id(argv[arg]));
          }
          arg--;
	  break;
        default:
          fprintf(stderr, "? unknown switch %s\n", argv[arg]);
     }
     arg++;
  }

  /* print header in output */
  if (!no_greeting) fprintf(yyout, GREETING);

  /* parse */
  init_parse(status);
  status = yyparse();

  /* close */
  if (yynerrs || yywarns || (status == '<')) fputc('\n',stderr);
  if (yyout!=stdout) fclose(yyout);
  if (yyin!=stdin) fclose(yyin);
  if (yynerrs) return 1; else return 0;
}

int yywrap()
{ return(1); }

void yyerror(s)
char *s;
{  fprintf(stderr,"\n? line %d: %s", lineNb, s);
   yynerrs++;
}

void yyerror2(s1,s2)
char *s1, *s2;
{  fprintf(stderr,"\n? line %d: %s %s", lineNb, s1, s2);
   yynerrs++;
}

void yyerror3(s1,s2,s3)
char *s1, *s2, *s3;
{  fprintf(stderr,"\n? line %d: %s %s %s", lineNb, s1, s2, s3);
   yynerrs++;
}

void yywarning(s)
char *s;
{  fprintf(stderr,"\nWarning: line %d: %s", lineNb, s);
   yywarns++;
}

void yywarning2(s1,s2)
char *s1, *s2;
{  fprintf(stderr,"\nWarning: line %d: %s %s", lineNb, s1, s2);
   yywarns++;
}

void yywarning3(s1,s2,s3)
char *s1, *s2, *s3;
{  fprintf(stderr,"\nWarning: line %d: %s %s %s", lineNb, s1, s2, s3);
   yywarns++;
}

void errormsg1(char *f , char *msgname, char *msg)
{
   fprintf(stderr, "\n? line %d: Polylib error: %s: %s\n", lineNb, f, msg);
   yynerrs++;
}
