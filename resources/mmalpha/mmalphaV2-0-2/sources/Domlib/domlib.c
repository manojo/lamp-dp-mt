 /*  file: $MMALPHA/sources/Domlib/domlib.c
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
  This version was modified to be adapted to MMA 6.0 by P. Quinton
  on May 6, 2008. The main corrections are the following. 

  - The GetFunction function was removed. 
  - All calls to MLGetFunction were either replaced by MLCheckFunction or
    by MLGetFunction
  - alink was everywhere replaced by stdlink.

  NB: it may be possible that some MLDisown are missing. Check the documentation
  and signal them...
 */

/* 

   On a WINDOWSNT, the switch windowsNT should allow to compile domlib
   with visualC++ (see the readme.windows for more technical details)
 
   The MATHLINK switch should always be set.
	
   There is also a DEBUG switch.
	
   Finally, the TIME switch allows one to have the execution time of
   calls to ML_Constraints to be measured.
	
*/

/*
/*   The UNIX define must be set for Mac OS X, but it is set 
/*   directly in the Makefile using the -dUNIX flag
/*
/* #define WINDOWSNT */
/* #define UNIX */
#define MATHLINK
/* #define DEBUG */
/* #define DOMDEBUG */
/* #define TIME */

/* Install in mathematica by doing:
domlib = Install["domlib"]
   Uninstall by :
Uninstall[domlib]
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Needed for mathlink */
#include <mathlink.h>
#include <time.h>

#ifdef UNIX
#include <unistd.h> 
#endif

#include <polylib/polylib.h>

/* changed for schedule polytopes #define	MAXRAYS 8000 */
#define	MAXRAYS 80000
#define	ILEN	32
#define NBMAXINDEX 500

/* Structure of domains */
typedef struct
{   int dimension;
    long p_count;
    long i_count;
    Polyhedron *p;
    char index[NBMAXINDEX][ILEN];
} Domain;

/* Structure of matrices */
typedef struct
{   long i_count;
    Matrix *m;
    char index[NBMAXINDEX][ILEN];
} Mat;

/* ZDomain */
typedef struct {
  int dimension ;
  long z_count;
  long i_count; 
  char index [NBMAXINDEX][ILEN];
  ZPolyhedron *Zpol;
  } ZDomain ;

extern int MLAbort;
extern int Pol_status;

#ifdef UNIX
int main(argc, argv)
int argc;
char *argv[];
{ 
    /* open the MathLink connection, send/receive data */
    return MLMain(argc, argv);
}

#else
#ifdef WINDOWSNT

#pragma argsused

int PASCAL WinMain( HINSTANCE hinstCurrent, HINSTANCE hinstPrevious, LPSTR lpszCmdLine, int nCmdShow)
{
	char  buff[512];
	char FAR * buff_start = buff;
	char FAR * argv[32];
	char FAR * FAR * argv_end = argv + 32;

	if( !MLInitializeIcon( hinstCurrent, nCmdShow)) return 1;
	MLScanString( argv, &argv_end, &lpszCmdLine, &buff_start);
	return MLMain( argv_end - argv, argv);
}

#endif
#endif


void errormsg(MLINK alink, char *f , char *msgname, char *msg);
/* 	
  This function allows error messages to be sent to Mathematica. 
  To do so, a CompoundExpression is sent to Mathematica, whose first
  subexpression is a message, and the second expression is whatever 
  the calling routine will send in the future. f is the function name, 
  and msg the message symbol. Thus errormsg(alink,f,msg) is equivalent
  to Message[f::msg]
*/
void errormsg(MLINK alink, char *f , char *msgname, char *msg)
{
#ifdef MATHLINK
   MLPutFunction(alink,"CompoundExpression",2); 
   MLPutFunction(stdlink,"Message",1);
   MLPutFunction(stdlink,"MessageName",2);
   MLPutSymbol(stdlink,f);
   MLPutString(stdlink,msgname);
   fprintf(stderr,"%s:%s::%s\n", f, msgname, msg);
#else
   fprintf(stderr,f,msg,"\n");
#endif
   return;
}

void trace(char *msg);
/* 	
  This function allows trace messages to be sent to Mathematica. 
  To do so, a CompoundExpression is sent to Mathematica, whose first
  subexpression is a Print, and the second expression is whatever 
  the calling routine will send in the future. 
*/
void trace(char *msg)
{
#ifdef MATHLINK    
  MLPutFunction(stdlink,"CompoundExpression",2); 
  MLPutFunction(stdlink,"Print",1);
  MLPutString(stdlink,msg);
#else
  fprintf(stderr,msg,"\n");
#endif
  return;
}

void errormsg1(char *f , char *msgname, char *msg);
/* 	
  This function allows either error messages to be sent to Mathematica, 
  or messages to be printed to stderr. 
	
  If MATHLINK is defined, then a command Message[f::msgname] is sent to
  Mathematica. If not, one prints on stderr. The difference with errormsg
  is that the control should be returned immediately to Mathematica after
  the call to errormsg1. Therefore, no Compound statement is sent to 
  Mathematica. 
*/
void errormsg1(char *f , char *msgname, char *msg)
{
#ifdef MATHLINK
  MLPutFunction(stdlink,"Message",1);
  MLPutFunction(stdlink,"MessageName",2);
  MLPutSymbol(stdlink,f);
  MLPutString(stdlink,msgname);
#else
  fprintf(stderr, msg);
#endif
}

void errormsg2(char *f , char *msgname, char *msg);
/* 	
  This function allows either error messages to be sent to Mathematica, 
  or messages to be printed to stderr. errormsg2 is much like errormsg1, 
  except that an argument is also sent to fill the message of Mathematica.
	
  If MATHLINK is defined, then a command Message[f::msgname,arg] is sent to
  Mathematica. If not, one prints on stderr. 
*/
void errormsg2(char *f , char *msgname, char *msg)
{
#ifdef MATHLINK
  MLPutFunction(stdlink,"Message",2);
  MLPutFunction(stdlink,"MessageName",1);
  MLPutSymbol(stdlink,f);
  MLPutString(stdlink,msgname);
  MLPutString(stdlink,msg);
#else
  fprintf(stderr,f,msg,"\n");
#endif
}

void errormsg3(char *f , char *msgname, int numd)
{
#ifdef MATHLINK
  /*   MLPutFunction(stdlink,"Message",2);
  MLPutFunction(stdlink,"MessageName",2);
  MLPutSymbol(stdlink,f);
  MLPutString(stdlink,msgname);
  MLPutInteger(stdlink,numd); */
#else
#ifndef NO_MESSAGES
  fprintf(stderr, "?%s: %d\n", f, numd);
#endif
#endif
}

/*
  This function is OK
  It gets a value from alink. In practice, alink is stdlink...
 */
int MLGetValue(alink,x)
MLINK alink;
Value *x;
{
  int y;
  int status;
 

#ifdef DEBUG
  trace("BEGIN MLGetValue ");
#endif
 
  status = MLGetInteger(alink, &y);
  value_set_si(*x,y);

#ifdef DEBUG  
  fprintf(stderr,"  %d  \n",y);
#endif

 return status;
}

/*
  OK. Sends an integer value to Mathematica
 */
void MLPutValue(alink, x)
MLINK alink;
Value x;
{
#ifdef DEBUG
  trace("BEGIN MLPutValue ");
  fprintf(stderr,"  %d  ", VALUE_TO_INT(x));
  fprintf(stderr,"  %lld  ", VALUE_TO_INT(x));
  value_print(stderr,VALUE_FMT, x);
  fprintf(stderr,"  %d  \n", (int)VALUE_TO_INT(x));
#endif
  MLPutInteger(alink, (int)VALUE_TO_INT(x));
}

/* 
  This function gets a domain from Mathematica
*/
Domain *MLGetDomain(alink)
MLINK alink; 
{   
  int i,j,k;
  int count;
  long n;
  Polyhedron *p, *p1;
  Domain *d;
  int NbConstraints, NbRays, NbEq, NbBid;
  const char *s;

#ifdef DEBUG
  trace("BEGIN MLGet_Domain\n");
#endif

  /* Check that function was read */
  MLCheckFunction(alink, "domain", &n); 

  /* Get memory for domain */
  d = (Domain *) malloc (sizeof(Domain));

  if (!d) {
    errormsg1("Domlib","outmem","? out of memory");
    return 0;
  }

  /* Get dimension of domain */
  if (!MLGetInteger(alink, &d->dimension)) return 0;

  /* Get number of indexes */
  if (!MLCheckFunction(alink, "List", &d->i_count)) return 0;

  /* Read indexes */
  for (i=0; i<d->i_count; i++)
  {   
    if (!MLGetString(alink, &s)) return 0;
      strncpy(d->index[i], s, ILEN);
      d->index[i][ILEN-1] = '\0';
      MLReleaseString(alink, s); /* This was changed in version 6.0 */
  };


  /* Read the number of arguments of the polyhedron */
  if (!MLCheckFunction(alink, "List", &d->p_count)) return 0;

  /* Initialize polyhedron */
  p = (Polyhedron *) 0;

  /* Read the polyhedron */
  for(k=0; k<d->p_count; k++)
  {   
    if (!MLGetFunction(alink, &s, &count)) return 0; 
    if (!MLGetInteger(alink, &NbConstraints)) return 0; /* Number of constraints */
    if (!MLGetInteger(alink, &NbRays)) return 0;        /* Number of rays */
    if (!MLGetInteger(alink, &NbEq)) return 0;          /* Number of equalities */
    if (!MLGetInteger(alink, &NbBid)) return 0;         /* Number of inequalities

    /* Memory allocation for polyhedron */
    p1 = p;
    p = Polyhedron_Alloc(d->dimension, NbConstraints, NbRays);
 
    if (!p) {
      errormsg1("Domlib", "outmem","? Out of memory");
      return 0; 
    };

    p->NbEq = NbEq;
    p->NbBid = NbBid;
    if (p1) p1->next = p; else d->p = p; 


    /* Get list of constraints */
    /*    if (!MLCheckFunction(alink, "List", p->NbConstraints)) return 0; */
    if (!MLGetFunction(alink, &s, &count)) return 0; 

    /* Read constraints */
    for (i=0; i<p->NbConstraints; i++)
    {   
      /*      if (!MLCheckFunction(alink, "List", p->Dimension+2)) return 0; */
      if (!MLGetFunction(alink, &s, &count)) return 0; 
      for (j=0; j<p->Dimension+2; j++)
      {
        if(!MLGetValue(alink, &p->Constraint[i][j])) return 0;
      }
    };

    /* Get rays */
    /*    if (!MLGetFunction(alink, "Link", p->NbRays)) return 0; */
    if (!MLGetFunction(alink, &s, &count)) return 0;

    for (i=0; i<p->NbRays; i++)
    {   
      /*      if (!MLGetFunction(alink, "List", p->Dimension+2)) return 0;*/
      if (!MLGetFunction(alink, &s, &count)) return 0;
      for (j=0; j<p->Dimension+2; j++)
      {
        if (!MLGetValue(alink, &p->Ray[i][j])) return 0;
      }
    }
  }

  /* Return domain */
  return d;
}

/*
  A test function. Could be removed afterwords
 */
extern Domain *gd();
Domain *gd()
{   
  Domain *d;

  d = MLGetDomain(stdlink);

  return d;

}


/*
  Seems to be OK. Puts a domain to Mathematica.
 */
void MLPutDomain(alink, d)
MLINK	alink;
Domain *d;
{   
  int i,j;
  Polyhedron *p;

#ifdef DEBUG
  trace("BEGIN MLPutDomain\n");
#endif

  if (MLAbort) MLPutSymbol(alink, "$Aborted");
  MLPutFunction(alink, "Alpha`domain", 3);
  {	
    MLPutInteger(alink, d->dimension);
    MLPutFunction(alink, "List", d->i_count);

    for (i=0; i<d->i_count; i++)
    {   
      MLPutString(alink, d->index[i]);
    };

    MLPutFunction(alink, "List", d->p_count);

    for(p = d->p; p; p=p->next)
    {   
      if (p->Dimension!=d->dimension)
      {	
        errormsg1("Domlib","dimpb","? Dimension problem");
      };

      MLPutFunction(alink, "Alpha`pol", 6);

      {	
        MLPutInteger(alink, p->NbConstraints);
	MLPutInteger(alink, p->NbRays);
	MLPutInteger(alink, p->NbEq);
	MLPutInteger(alink, p->NbBid);
	MLPutFunction(alink, "List", p->NbConstraints);

	for (i=0; i<p->NbConstraints; i++)
        {   MLPutFunction(alink, "List", p->Dimension+2);
          for (j=0; j<p->Dimension+2; j++)
          {	MLPutValue(alink, p->Constraint[i][j]);
	  }
	};
	MLPutFunction(alink, "List", p->NbRays);
	for (i=0; i<p->NbRays; i++)
	{   MLPutFunction(alink, "List", p->Dimension+2);
	    for (j=0; j<p->Dimension+2; j++)
	    {	MLPutValue(alink, p->Ray[i][j]);
	    }
	}
      }
    }
  }
}

/*
    Reads a matrix (structure) from Mathematica
 */
Mat *MLGetMatrix(MLINK alink)
{   
  int i,j;
  Matrix *m;
  Mat *d;
  int NbRow, NbCol;
  const char *s;
  int count;
#ifdef DEBUG
  trace("BEGIN MLGetMatrix\n");
#endif
/*    if (!GetFunction(alink, "matrix", 4)) return 0; */
  if (!MLGetFunction(alink, &s, &count)) return 0;
  {	
    d = (Mat *) malloc (sizeof(Mat));
    if (!d) {
      errormsg1("Domlib","outmem","? out of memory");
      return 0;
    }
    if (!MLGetInteger(alink, &NbRow)) return 0;
    if (!MLGetInteger(alink, &NbCol)) return 0;

    m = Matrix_Alloc(NbRow, NbCol);
    d->m = m;
    if (!m) {
      errormsg1("Domlib","outmem","? out of memory");
      return 0;
    }

    if (!MLCheckFunction(alink, "List", &d->i_count)) return 0;
    for (i=0; i<d->i_count; i++)
    {   
      if (!MLGetString(alink, &s)) return 0;
      strncpy(d->index[i], s, ILEN);
      d->index[i][ILEN-1] = '\0';
      MLDisownString(alink, s);
    }

    if (!MLGetFunction(alink, &s, &NbRow)) return 0;
    for(i=0; i<NbRow; i++)
    {   
      if (!MLGetFunction(alink, &s, &NbCol)) return 0;
      for (j=0; j<NbCol; j++)
      {	
        if(!MLGetValue(alink, &m->p[i][j])) return 0;
      }
    }
  }
  return d;
}

/*
  A test function. Could be removed afterwords
 */
extern Mat *gm();
Mat *gm()
{   
  Mat *m;

  m = MLGetMatrix(stdlink);

  return m;

}




void MLPutMatrix(alink, d)
MLINK   alink;
Mat     *d;
{   int i,j;
    Matrix *m;
#ifdef DEBUG
trace("BEGIN MLPutMatrix\n");
Matrix_Print(stderr,P_VALUE_FMT, d->m);
#endif
    m = d->m;
    if (MLAbort) MLPutSymbol(alink, "$Aborted");
    MLPutFunction(alink, "Alpha`matrix", 4);
    {   MLPutInteger(alink, m->NbRows);
        MLPutInteger(alink, m->NbColumns);
        MLPutFunction(alink, "List", d->i_count);
        for (i=0; i<d->i_count; i++)
        {   MLPutString(alink, d->index[i]);
        }
        MLPutFunction(alink, "List", m->NbRows);
        for(i=0; i<m->NbRows; i++)
        {   MLPutFunction(alink, "List", m->NbColumns);
            for (j=0; j<m->NbColumns; j++)
            {   MLPutValue(alink, m->p[i][j]);
            }
        }
    }
#ifdef DEBUG
trace("END MLPutMatrix\n");
#endif

}



/*
  This function is for testing purpose. It reads a domain, and
  sends it back to Mathematica.
 */
extern mirrorDomain (void);
int mirrorDomain()
{
  Domain *d;

  d = gd();

  /*
  MLPutFunction(stdlink, "domain", 2);
  MLPutInteger32(stdlink, 66);
  MLPutInteger32(stdlink, 66);
  */

  MLPutDomain(stdlink, d);
  return;

}

/*
  This function is for testing purpose. It reads a matrix, and
  sends it back to Mathematica.
 */
extern mirrorMatrix (void);
int mirrorMatrix()
{
  Mat *m;
  
  m = gm();

  /*
  MLPutFunction(stdlink, "matrix", 2);
  MLPutInteger32(stdlink, 66);
  MLPutInteger32(stdlink, 66);
  */

  MLPutMatrix(stdlink, m);

  return;

}

/*
ML_Intersection(alink)
MLINK alink;
*/
int ML_Intersection()
{   
  Domain *d1, *d2, *d3;
  Polyhedron *p;
  int i, res;

#ifdef DEBUG
  trace("BEGIN ML_INTERSECTION\n");
#endif

  res = 0; 

  /* Reads the first domain */
  d1 = MLGetDomain(stdlink);

  if (!d1) goto L0;
  if (!d1->p) goto L1;

  /* Reads the second domain */
  d2 = MLGetDomain(stdlink);
  if (!d2) goto L2;
  if (!d2->p) goto L3;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
    errormsg1("DomIntersection","outmem","? Out of Memory");
    goto L4; 
  }

  /* copy over indices for d3 */
  d3->i_count = d1->i_count;
  for (i=0; i<d3->i_count; i++)
  {
    strncpy(d3->index[i], d1->index[i], ILEN);
    d3->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d3->p= DomainIntersection(d1->p, d2->p, MAXRAYS);
  if (!d3->p || Pol_status) goto L5;
  d3->dimension = d3->p->Dimension;

  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;   
    
  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);

L5: free(d3);
L4: Domain_Free(d2->p);
L3: free(d2);
L2: Domain_Free(d1->p);
L1: free(d1);
L0:
  return res;
}

/*
  Union of domains 
 */
int ML_Union ()
{
  Domain *d1, *d2, *d3;
  Polyhedron *p;
  int i, res;
  MLINK alink;

#ifdef DEBUG
  trace("BEGIN ML_Union\n");
#endif
  res = 0;

  d1 = MLGetDomain(stdlink);

#ifdef DEBUG
  trace("1\n");
#endif

  if (!d1) goto L0;
  if (!d1->p) goto L1;

  d2 = MLGetDomain(stdlink);
  if (!d2) goto L2;
  if (!d2->p) goto L3;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
    errormsg1("DomUnion","outmem","? out of memory");
    goto L4; 
  }

  /* copy over indices for d3 */
  d3->i_count = d1->i_count;
  for (i=0; i<d3->i_count; i++)
  {	strncpy(d3->index[i], d1->index[i], ILEN);
	d3->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d3->p= DomainUnion(d1->p, d2->p, MAXRAYS);
  if (!d3->p || Pol_status) goto L5;
  d3->dimension = d3->p->Dimension;

  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;


  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);
L5: free(d3);
L4: Domain_Free(d2->p);
L3: free(d2);
L2: Domain_Free(d1->p);
L1: free(d1);
L0:
  return res;
}

/*
int ML_Difference (alink)
MLINK	alink;
*/
int ML_Difference ()
{   
  Domain *d1, *d2, *d3;
  Polyhedron *p;
  int i, res;
  MLINK	alink;
#ifdef DEBUG
  trace("BEGIN ML_Difference\n");
#endif

  res = 0;

  d1 = MLGetDomain(stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;

  d2 = MLGetDomain(stdlink);
  if (!d2) goto L2;
  if (!d2->p) goto L3;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
    errormsg1("DomDifference","outmem","? out of memory\n");
  goto L4; 
  }

  /* copy over indices for d3 */
  d3->i_count = d1->i_count;
  for (i=0; i<d3->i_count; i++)
  {	strncpy(d3->index[i], d1->index[i], ILEN);
    d3->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d3->p= DomainDifference(d1->p, d2->p, MAXRAYS);
  if (!d3->p || Pol_status) goto L5;
  d3->dimension = d3->p->Dimension;

  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;

  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);
L5: free(d3);
L4: Domain_Free(d2->p);
L3: free(d2);
L2: Domain_Free(d1->p);
L1: free(d1);
L0:
  return res;
}

/*
int ML_Simplify (alink)
MLINK	alink;
*/
int ML_Simplify ()
{   
  Domain *d1, *d2, *d3;
  Polyhedron *p;
  int i, res;
  MLINK	alink;

#ifdef DEBUG
  trace("BEGIN ML_Simplify\n");
#endif
  res = 0;

  d1 = MLGetDomain(stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;

  d2 = MLGetDomain(stdlink);
  if (!d2) goto L2;
  if (!d2->p) goto L3;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
		errormsg1("DomSimplify","outmem","? out of memory");
    	goto L4; 
  }

  /* copy over indices for d3 */
  d3->i_count = d1->i_count;
  for (i=0; i<d3->i_count; i++)
  {	strncpy(d3->index[i], d1->index[i], ILEN);
    d3->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d3->p= DomainSimplify(d1->p, d2->p, MAXRAYS);
  if (!d3->p || Pol_status) goto L5;
  d3->dimension = d3->p->Dimension;

  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;

  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);
L5: free(d3);
L4: Domain_Free(d2->p);
L3: free(d2);
L2: Domain_Free(d1->p);
L1: free(d1);
L0:
  return res;
}

/*
int ML_Convex (alink)
MLINK	alink;
*/
int ML_Convex ()
{   
  Domain *d1, *d3;
  Polyhedron *p;
  int i, res;

#ifdef DEBUG
  trace("BEGIN ML_CONVEX\n");
#endif
  res = 0;

  d1 = MLGetDomain(stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
		errormsg1("DomConvex","outmem","? out of memory");
 	goto L2; 
  }

  /* copy over indices for d3 */
  d3->i_count = d1->i_count;
  for (i=0; i<d3->i_count; i++)
  {   strncpy(d3->index[i], d1->index[i], ILEN);
      d3->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d3->p = DomainConvex(d1->p, MAXRAYS);
  if (!d3->p || Pol_status) goto L3;

  d3->dimension = d3->p->Dimension;
  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;

  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);
L3: free(d3);
L2: Domain_Free(d1->p);
L1: free(d1);
L0:
  return res;
}

/*
int ML_Image (stdlink)
MLINK	alink;
*/
int ML_Image ()
{   
  Domain *d1, *d3;
  Mat *m2;
  Polyhedron *p;
  int i, res;
  char s[ILEN];

#ifdef DEBUG
  trace("BEGIN ML_IMAGE\n");
#endif
  res = 0;

  d1 = MLGetDomain(stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;

  m2 = MLGetMatrix(stdlink);
  if (!m2) goto L2;
  if (!m2->m) goto L3;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
    errormsg1("DomImage","outmem","? out of memory");    	
    goto L4; 
  }

  /* copy over indices for d3 */
  /* try to guess what they might be called from the original list
    and m2 ... */
  /* this is a kludge at best in absence of a better affine function
     specifier which gives the names of the indices on the RHS... */
  if (m2->m->NbRows==m2->m->NbColumns) /* square -- use same indices */
  {  d3->i_count =
     m2->m->NbRows-1 <= m2->i_count ? m2->m->NbRows-1 : m2->i_count;
     for (i=0; i<d3->i_count; i++)
     {   strncpy(d3->index[i], m2->index[i], ILEN);
         d3->index[i][ILEN-1] = '\0';
     }
  }
  else /* -> fewer or more indices */
  {  
    d3->i_count = m2->m->NbRows-1;
    for (i=0; i<d3->i_count; i++)
    {  sprintf(s, "i%d", i+1);
       strncpy(d3->index[i], s, ILEN);
       d3->index[i][ILEN-1] = '\0';
    }
  }

  Pol_status = 0;
  d3->p = DomainImage(d1->p, m2->m, MAXRAYS);
  if (!d3->p || Pol_status) goto L5;

  d3->dimension = d3->p->Dimension;
  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;

  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);
L5: free(d3);
L4: Matrix_Free(m2->m);
L3: free(m2);
L2: Domain_Free(d1->p);
L1: free(d1);
L0:
  return res;
}

/*
int ML_Preimage (alink)
MLINK	alink;
*/
int ML_Preimage()
{   
  Domain *d1, *d3;
  Mat *m2;
  Polyhedron *p;
  int i, res;

#ifdef DEBUG
  trace("BEGIN ML_PREIMAGE\n");
#endif

  res = 0;

  /* Read the domain */
  d1 = MLGetDomain(stdlink);
  
  if (!d1) goto L0;
  if (!d1->p) goto L1;

  /* Read the matrix */
  m2 = MLGetMatrix(stdlink);
  if (!m2) goto L2;
  if (!m2->m) goto L3;

  if (!MLNewPacket(stdlink)) goto L2;

  d3 = (Domain *)malloc(sizeof(Domain));
  if (!d3) { 
		errormsg1("DomPreimage","outmem","? out of memory");
    	goto L4; 
  }

  /* copy over indices for d3 */
  d3->i_count = m2->i_count;
  for (i=0; i<d3->i_count; i++)
  {	strncpy(d3->index[i], m2->index[i], ILEN);
    d3->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d3->p = DomainPreimage(d1->p, m2->m, MAXRAYS);
  if (!d3->p || Pol_status) goto L5;

  d3->dimension = d3->p->Dimension;
  for (p=d3->p, i=0; p; p=p->next, i++);
  d3->p_count = (long)i;

  MLPutDomain(stdlink, d3);
  res = 1;
  Domain_Free(d3->p);
L5: free(d3);
L4: Matrix_Free(m2->m);
L3: free(m2);
L2: Domain_Free(d1->p);
L1: free(d1);
L0: 
  return res;
}

/*
int ML_Constraints (alink)
MLINK   alink;
*/
int ML_Constraints ()
{   
  Mat *m1;
  Domain *d2;
  Polyhedron *p;
  int i, res;
#ifdef TIME
  double mytime;
  char msgtrace[50];
#endif

#ifdef DEBUG
  trace("BEGIN ML_CONSTRAINTS");
#endif

#ifdef TIME
  mytime = clock();
#endif

  res = 0;

  m1 = MLGetMatrix(stdlink);
  if (!m1) goto L0;
  if (!m1->m) goto L1;

  if (!MLNewPacket(stdlink)) goto L2;

  d2 = (Domain *)malloc(sizeof(Domain));
  if (!d2) { 
		errormsg1("DomConstraints","outmem","? out of memory");
    	goto L2; 
  }

  /* copy over indices for d2 */
  d2->i_count = m1->i_count;
  for (i=0; i<d2->i_count; i++)
  {   strncpy(d2->index[i], m1->index[i], ILEN);
        d2->index[i][ILEN-1] = '\0';
  }

  Pol_status = 0;
  d2->p = Constraints2Polyhedron(m1->m, MAXRAYS);
  if (!d2->p || Pol_status) goto L3;

  d2->dimension = d2->p->Dimension;
  for (p=d2->p, i=0; p; p=p->next, i++);
  d2->p_count = (long)i;
    
#ifdef TIME
  mytime = (clock()-mytime)/CLOCKS_PER_SEC;
  sprintf(msgtrace,"%f seconds",mytime);
  trace(msgtrace);
#endif

    MLPutDomain(stdlink, d2);
    res = 1;
    Domain_Free(d2->p);
L3: free(d2);
L2: Matrix_Free(m1->m);
L1: free(m1);
L0:
  return res;
}

/*
int ML_Rays (alink)
MLINK   alink;
*/
int ML_Rays()
{   Mat *m1;
    Domain *d2;
    Polyhedron *p;
    int i, res;

#ifdef DEBUG
trace("BEGIN ML_RAYS");
#endif

    res = 0;

    m1 = MLGetMatrix(stdlink);
    if (!m1) goto L0;
    if (!m1->m) goto L1;

    if (!MLNewPacket(stdlink)) goto L2;

    d2 = (Domain *)malloc(sizeof(Domain));
    if (!d2) { 
		errormsg1("DomRays","outmem","? out of memory");
    	goto L2; }

    /* copy over indices for d2 */
    d2->i_count = m1->i_count;
    for (i=0; i<d2->i_count; i++)
    {   strncpy(d2->index[i], m1->index[i], ILEN);
        d2->index[i][ILEN-1] = '\0';
    }

    Pol_status = 0;
    d2->p = Rays2Polyhedron(m1->m, MAXRAYS);
    if (!d2->p || Pol_status) goto L3;

    d2->dimension = d2->p->Dimension;
    for (p=d2->p, i=0; p; p=p->next, i++);
    d2->p_count = (long)i;

    MLPutDomain(stdlink, d2);
    res = 1;
    Domain_Free(d2->p);
L3: free(d2);
L2: Matrix_Free(m1->m);
L1: free(m1);
L0:
    return res;
}

/*
int ML_Cost (alink)
MLINK   alink;
*/
int ML_Cost ()
{  
  Domain *d1;
  /* int *c2; */
  Value *c2;
  Interval *i3;
  int i,j, Dim, res;
  int count; 
  const char *s;
  
#ifdef DEBUG
  trace("BEGIN ML_COST");
#endif
  res = 0;
  
  d1 = MLGetDomain(stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;
  Dim = d1->dimension + 1;
  
  /* c2 = (int *) malloc( Dim * sizeof(int));
     if (!c2) {
     errormsg1("DomCost","outmem","? out of memory");
     goto L2;
     }
  */
  c2 = (Value *) malloc( Dim * sizeof(Value));
  if (!c2) {
    errormsg1("DomCost","outmem","? out of memory");
    UNCATCH(any_exception_error);
    goto L3;
  }
    /* Get Cost Function */
  if (!MLGetFunction(stdlink, &s, &count)) {
    errormsg1("DomCost","wrgdim","? wrong dimension");
    goto L3;
  }
  for (j=0; j<Dim; j++)
    {   if(!MLGetValue(stdlink, &c2[j])) {
      
      errormsg1("DomCost","wrgarg","? wrong argument");
      goto L3;
    }
    }

    if (!MLNewPacket(stdlink)) goto L3;

    i3 = DomainCost(d1->p, c2);
    if (!i3) goto L3;

    MLPutFunction(stdlink, "List", 6);
    MLPutInteger(stdlink, i3->MaxN);
    MLPutInteger(stdlink, i3->MaxD);
    MLPutInteger(stdlink, i3->MaxI);
    MLPutInteger(stdlink, i3->MinN);
    MLPutInteger(stdlink, i3->MinD);
    MLPutInteger(stdlink, i3->MinI);
    res = 1;
    free(i3); 
 L3:  for (j=0; j<Dim; j++)   value_clear(c2[j]);
    free(c2);
 L2: Polyhedron_Free(d1->p);
 L1: free(d1);
 L0:
    return res;
}

/*
int ML_RightHermite (alink)
MLINK   alink;
*/
int ML_RightHermite ()
{   Mat *m1,*q,*h;
    int i, res;

#ifdef DEBUG
trace("BEGIN ML_RightHermite");
#endif

    res = 0;

    m1 = MLGetMatrix(stdlink);
    if (!m1) goto L0;
    if (!m1->m) goto L1;

    if (!MLNewPacket(stdlink)) goto L2;

    q = (Mat *) malloc (sizeof(Mat));
    if (!q) {
		errormsg1("DomRightHermite","outmem","? out of memory");
    	goto L2;
    	}

    h = (Mat *) malloc (sizeof(Mat));
    if (!h) {
		errormsg1("DomRightHermite","outmem","? out of memory");
    	goto L3;
    	}

    right_hermite(m1->m, &(h->m), 0, &(q->m) );
    if (!h->m) {
		errormsg1("DomRightHermite","wrgarg","? wrong argument");
    	goto L4;
    	}
    if (!q->m) {
		errormsg1("DomRightHermite","failed","? RightHermite failed");
    	goto L5;
    	}

    /* copy over indices for d2 */
    h->i_count = m1->i_count;
    q->i_count = m1->i_count;
    for (i=0; i<m1->i_count; i++)
    {   strncpy(h->index[i], m1->index[i], ILEN);
        h->index[i][ILEN-1] = '\0';
        strncpy(q->index[i], m1->index[i], ILEN);
        q->index[i][ILEN-1] = '\0';
    }

    MLPutFunction(stdlink, "List", 2);
    MLPutMatrix(stdlink, q);
    MLPutMatrix(stdlink, h);

    res = 1;

    Matrix_Free(q->m);
L5: Matrix_Free(h->m);
L4: free(h);
L3: free(q);
L2: Matrix_Free(m1->m);
L1: free(m1);
L0:
    return res;
}

/*
int ML_LeftHermite (alink)
MLINK   alink;
*/
int ML_LeftHermite ()
{   Mat *m1,*q,*h;
    int i, res;

#ifdef DEBUG
trace("BEGIN ML_LeftHermite");
#endif

    res = 0;

    m1 = MLGetMatrix(stdlink);
    if (!m1) goto L0;
    if (!m1->m) goto L1;

    if (!MLNewPacket(stdlink)) goto L2;

    q = (Mat *) malloc (sizeof(Mat));
    if (!q) {
    	errormsg1("DomLeftHermite","outmem","? out of memory");
    	goto L2;
    	}

    h = (Mat *) malloc (sizeof(Mat));
    if (!h) {
    	errormsg1("DomLeftHermite","outmem","? out of memory");
    	goto L3;
    	}

    left_hermite(m1->m, &(h->m), 0, &(q->m) );
    if (!q->m) 
    	{
    	errormsg1("DomLeftHermite","wrgarg","? wrong argument");
    	goto L4;
    	}

    if (!h->m) 
    	{
    	errormsg1("DomLeftHermite","failed","? failed");
    	goto L5;
    	}

    /* copy over indices for d2 */
    h->i_count = m1->i_count;
    q->i_count = m1->i_count;
    for (i=0; i<m1->i_count; i++)
    {   strncpy(h->index[i], m1->index[i], ILEN);
        h->index[i][ILEN-1] = '\0';
        strncpy(q->index[i], m1->index[i], ILEN);
        q->index[i][ILEN-1] = '\0';
    }

    MLPutFunction(stdlink, "List", 2);
    MLPutMatrix(stdlink, h);
    MLPutMatrix(stdlink, q);

    res = 1;

    Matrix_Free(h->m);
L5: Matrix_Free(q->m);
L4: free(h);
L3: free(q);
L2: Matrix_Free(m1->m);
L1: free(m1);
L0:
    return res;
}

/*
int ML_MatrixBasis (alink)
MLINK   alink;
*/
int ML_MatrixBasis ()
{   Mat *m1;
    int res;

#ifdef DEBUG
trace("BEGIN ML_MatrixBasis");
#endif

    res = 0;

    m1 = MLGetMatrix(stdlink);
    if (!m1) goto L0;
    if (!m1->m) goto L1;

    if (!MLNewPacket(stdlink)) goto L2;

    m1->m->NbRows = GaussSimplify(m1->m, 0);

    MLPutMatrix(stdlink, m1);

    res = 1;

L2: Matrix_Free(m1->m);
L1: free(m1);
L0:
    return res;
}

/*
int ML_MatrixSimplify (alink)
MLINK   alink;
*/
int ML_MatrixSimplify ()
{   Mat *m1, *m2;
    int res;

#ifdef DEBUG
trace("BEGIN ML_MatrixSimplify");
#endif

    res = 0;

    m1 = MLGetMatrix(stdlink);
    if (!m1) goto L0;
    if (!m1->m) goto L1;

    m2 = MLGetMatrix(stdlink);
    if (!m2) goto L2;
    if (!m2->m) goto L3;

    if (m1->m->NbColumns != m2->m->NbColumns)
    {  
    errormsg1("MatrixSimplify","colnumb","? Matrices must have same number of columns");
       goto L4;
    }

    if (!MLNewPacket(stdlink)) goto L4;

    GaussSimplify(m2->m, m1->m);

    MLPutMatrix(stdlink, m1);

    res = 1;

L4: Matrix_Free(m2->m);
L3: free(m2);
L2: Matrix_Free(m1->m);
L1: free(m1);
L0:
    return res;
}

/*
int ML_DomAddRays (alink)
MLINK   alink;
*/
int ML_DomAddRays ()
{   Domain *d1,*d3;
    Mat *m2;
    Polyhedron *p;
    int i, res;

#ifdef DEBUG
trace("BEGIN ML_DomAddRays");
#endif

    res = 0;

    d1 = MLGetDomain(stdlink);
    if (!d1) goto L0;
    if (!d1->p) goto L1;

    m2 = MLGetMatrix(stdlink);
    if (!m2) goto L2;
    if (!m2->m) goto L3;

    if (d1->dimension != m2->m->NbColumns-2)
    {  
       errormsg1("DomAddRays","raydim","? Rays must match dimension of domain.");
       goto L4;
    }

    if (!MLNewPacket(stdlink)) goto L4;

    d3 = (Domain *)malloc(sizeof(Domain));
    if (!d3) { 
    	errormsg1("DomAddRays","outmem","? Out of Memory");
    	goto L4; }

    /* copy over indices for d3 */
    d3->i_count = d1->i_count;
    for (i=0; i<d3->i_count; i++)
    {   strncpy(d3->index[i], d1->index[i], ILEN);
        d3->index[i][ILEN-1] = '\0';
    }

    Pol_status = 0;
    d3->p = DomainAddRays(d1->p, m2->m, MAXRAYS);
    if (!d3->p || Pol_status) goto L5;

    d3->dimension = d3->p->Dimension;
    for (p=d3->p, i=0; p; p=p->next, i++);
    d3->p_count = (long)i;

    MLPutDomain(stdlink, d3);

    res = 1;
    Domain_Free(d3->p);
L5: free(d3);
L4: Matrix_Free(m2->m);
L3: free(m2);
L2: Polyhedron_Free(d1->p);
L1: free(d1);
L0:
    return res;
}
 
/*
int ML_DomPrint (alink)
MLINK   alink;
*/
int ML_DomPrint ()
{
  int res;
#ifdef DOMVISUAL
  Domain *d1,*d2;
  int pid;
#endif
#ifdef DEBUG
  trace("BEGIN ML_DomVisual");
#endif

  res=1;

#ifdef DOMVISUAL
  d1 = MLGetDomain(stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;

  d2 = MLGetDomain(stdlink);
  if (!d2) goto L2;
  if (!d2->p) goto L3;


  /*  la je ne sais pas */
  if (!MLNewPacket(stdlink)) goto L4;
  
  /*    DomVisual(d1->p,d2->p,&d2->index[0][0]); */
  /*     MLPutDomain(stdlink, d3); */
  pid=fork();
  if (pid==0) {
    DomVisual(d1->p,d2->p);
    exit(0);
  }
  if (pid==((pid_t)-1)) {
    errormsg1("DomPrint","forkfailed","Fork failed ! blocking call to DomVisual");
    DomVisual(d1->p,d2->p);
  }


  MLPutDomain(alink,d1);
  
 L4: Polyhedron_Free(d2->p);
 L3: free(d2);
 L2: Polyhedron_Free(d1->p);
 L1: free(d1);
 L0:
#endif
  return res;
}

/*
int ML_DomLTQ (alink)
MLINK   alink;
*/
int ML_DomLTQ ()
{   Domain *d1,*d2;
    int idx, pdim, x;
    int res;
#ifdef DEBUG
trace("BEGIN ML_DomLTQ");
#endif

    res=0;

    d1 = MLGetDomain(stdlink);
    if (!d1) goto L0;
    if (!d1->p) goto L1;

    d2 = MLGetDomain(stdlink);
    if (!d2) goto L2;
    if (!d2->p) goto L3;

    if (!MLGetInteger(stdlink, &idx)) goto L4;
    if (!MLGetInteger(stdlink, &pdim)) goto L4;

    Pol_status = 0;
    x = PolyhedronLTQ(d1->p, d2->p, idx, pdim, MAXRAYS);
    if (Pol_status) goto L4;

    MLPutInteger(stdlink, x);
    
    res = 1;

L4: Polyhedron_Free(d2->p);
L3: free(d2);
L2: Polyhedron_Free(d1->p);
L1: free(d1);
L0:
    return res;
}

/*
int ML_DomSort (alink)
     MLINK alink;
*/
int ML_DomSort ()
{
  /* parameters */
  Polyhedron ** list;
  int pdim, index;
  int wantsTime;       /* 1 if DomSort should return logical times,
			  0 if it should return a permutation vector
		       */
  /* locals */
  int n;
  Domain *d;
  int *times;
  int *pvector;
  int i;
  int res = 0;         /* will be 1 when all is done ok */
  const char *foo;    /* dummy pointer to read symbols on the link
			*/

  /* read the number of domains */
  if (!MLGetFunction(stdlink, &foo, &n))  goto L0;
  if (strcmp(foo, "List"))              goto L0;
  MLDisownSymbol(stdlink, foo);

  if (n<2)  goto L0;

  list = (Polyhedron **) malloc (n*sizeof(Polyhedron *));
  if (!list)
    goto L0;

  /* first let all pointer be 0 in case some MLGetDomain call fails */
    for (i=0; i<n; i++)
    list[i] = 0;

  /* read the domains */
  for (i=0; i<n; i++) {
    d = MLGetDomain(stdlink);
    if (!d)
      goto L1;
    list[i] = d->p;
    free(d); /* don't need this anymore */
  }

  /* read the parameters index, pdim and time */
  if (!MLGetInteger(stdlink, &index))  goto L1;
  if (!MLGetInteger(stdlink, &pdim))   goto L1;  
  if (!MLGetSymbol(stdlink, &foo))     goto L1;
  if (!strcmp(foo, "True"))
    wantsTime = 1;
  else
    wantsTime = 0;
  MLDisownSymbol(stdlink, foo);

  if (wantsTime) { /* allocate memory for the array of logical times */
    times = (int *) malloc (n*sizeof(int));
    pvector = NULL;
  }
  else { /* allocate for time _and_ permutation vector, PolyhedronTSort needs both
	   (pvector only is optional) */
    /* first half for memory for time array */
    times = (int *) malloc (2*n*sizeof(int));
    /* last half for pvector */
    pvector = times+n;
  }
  if (!times)
    goto L1;

  if (!PolyhedronTSort(list, (int)n, index, pdim, times, pvector, MAXRAYS))
    goto L2;

  /* put the result on the link, time or permutation vector */
  if (!MLPutIntegerList(stdlink, (wantsTime ? times : pvector), n))
    goto L2;

  /* let MathLink know that all was ok */
  res = 1;

 L2:
  free (times);

 L1:  
  /* free the allocated polyhedra */
  for (i=0; i<n; i++)
    if (list[i])
	Domain_Free(list[i]);
  free (list);

 L0:
  return res;
}

/*
int ML_DomIntEmptyQ (alink)
MLINK   alink;
*/
int ML_DomIntEmptyQ ()
{   Domain *d1, *d2;
    int x;
    int res;
#ifdef DEBUG
trace("BEGIN ML_DomIntEmptyQ");
#endif

    res=0;

    d1 = MLGetDomain(stdlink);
    if (!d1) goto L0;
    if (!d1->p) goto L1;

    d2 = MLGetDomain(stdlink);
    if (!d2) goto L2;
    if (!d2->p) goto L3;

    Pol_status = 0;
    x = Polyhedron_Not_Empty(d1->p, d2->p, MAXRAYS);
    if (Pol_status || x<0) goto L4;

    MLPutSymbol(stdlink, (x == 1 ? "False" : "True"));
    
    res = 1;

L4: Polyhedron_Free(d2->p);
L3: free(d2);
L2: Polyhedron_Free(d1->p);
L1: free(d1);
L0:
    return res;
}

/* MMA sends List[rows,columns,mat] */
Matrix * MLGetPPMatrix(alink)
MLINK alink;
{
  long count;
  Matrix *mat;
  /* int *p; */
  Value *p;
  int i,j;
  int rows,columns;
  
  if (!MLCheckFunction(stdlink, "List", &count))
    return (NULL);  
  if (!MLGetInteger(stdlink,&rows))
    return (NULL);  
  if (!MLGetInteger(stdlink,&columns))
    return (NULL);
  
  mat = Matrix_Alloc(rows, columns);
  p = mat->p_Init;

  if (!MLCheckFunction(stdlink, "List", &count)) {
    Matrix_Free(mat); return (NULL); }
  
  for (i=0;i<rows;i++)
    {
      if (!MLCheckFunction(stdlink, "List", &count)) {
	Matrix_Free(mat); return (NULL); }
      for (j=0;j<columns;j++,value_add_int(p,p,1))
	if (!MLGetValue(stdlink,p)) {
	  Matrix_Free(mat); return (NULL); }
    }
  return (mat);
}

/*
void MLPutPPVertex( alink, V )
MLINK alink;
*/
void MLPutPPVertex( V )
Matrix *V;
{
   int l,j;
   MLPutFunction(stdlink,"List",V->NbRows);
   for( l=0 ; l<V->NbRows ; ++l )
   {
      MLPutFunction (stdlink, "List", V->NbColumns);
      for (j = 0; j < V->NbColumns; j++)
          MLPutValue (stdlink, V->p[l][j]);
   }
}

/* ------------- */
/*
void MLPutPPDomain( alink , D )
MLINK alink;
*/
void MLPutPPDomain( D )
Polyhedron *D;
{
   int l,j;
   MLPutFunction(stdlink,"List", D->NbConstraints);
   for( l=0 ; l<D->NbConstraints ; ++l )
   {
      MLPutFunction (stdlink, "List", D->Dimension+2);
      for (j = 0; j < D->Dimension+2; j++)
          MLPutValue (stdlink, D->Constraint[l][j]);
   }
}

/*
int ML_findV(alink)
MLINK alink;
*/
int ML_findV()
{
  Matrix *a, *b;
  Polyhedron *A, *B;
  Param_Polyhedron *PA;
  Param_Domain *P;
  Param_Vertices *V;

  int i, ix, nbPV;
  unsigned bx;
  int domCount;
  
  a = MLGetPPMatrix(stdlink);
  if (!a) return (0);
  A = Constraints2Polyhedron(a, MAXRAYS);
  Matrix_Free(a);
  
  b = MLGetPPMatrix(stdlink);
  if (!a) { Domain_Free(A); return (0); }
  B = Constraints2Polyhedron(b, MAXRAYS);
  Matrix_Free(b);

  PA = Polyhedron2Param_Domain( A, B, MAXRAYS );
  Domain_Free(A);
  Domain_Free(B);

  if (PA) { /* there are solutions */
    nbPV = PA->nbV;
    
    domCount=0;
    for (P=PA->D ; P ; P=P->next) 
      domCount++;

    MLPutFunction(stdlink,"List",domCount);

    for (P=PA->D ; P ; P=P->next )
      {
	int count=0;
	for (i=0, ix=0, bx=MSB, V=PA->V ; V && i<nbPV ;
	     ++i, V=V->next )
	  {
	    if (P->F[ix] & bx)
            {
	      count++;
            }
	    NEXT(ix,bx);
	  }
	
	MLPutFunction(stdlink,"List",2);
	MLPutPPDomain( stdlink, P->Domain );
	MLPutFunction(stdlink,"List",count);
	for (i=0, ix=0, bx=MSB, V=PA->V ; V && i<nbPV ;
	     ++i, V=V->next )
	  {
	    if (P->F[ix] & bx)
		MLPutPPVertex( stdlink, V->Vertex );
	    NEXT(ix,bx);
	  }
      }
    
    Param_Polyhedron_Free( PA );
  }
  else /* no solution (PA is void), return an empty list */
    MLPutFunction(stdlink, "List", 0);

 return (1);
}

/** MLGetZDomain : Does just what the name suggests. 
***               It reads a Domain from the AST.
**/

ZDomain *MLGetZDomain (MLINK alink)
{
  ZDomain *A;
  ZPolyhedron *z=NULL, *z1=NULL;
  int i, j, k, m, pcount;
  int count;
  Bool isLat = True;
  const char *s;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "a");
  fprintf (fp, "\nEntered MLGETZDOMAIN \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace("BEGIN MLGetZDomain");
#endif

  /* Checking for the function name "domain" */
  /* Was changed for version 6.0 */
/*  if ( !(GetFunction (alink, "domain", 3)) ) */
  if (!(MLGetFunction (stdlink, &s, &count)) ) 
    return 0;
  
  /* Allocate memory for Z domain */
  A = (ZDomain *) malloc (sizeof (ZDomain));
  if (!A)
    {
      errormsg1 ("ZDomlib ", "outofmem", "? out of memory");
      return NULL;
    }

  A->Zpol=NULL; 
 
  /* Getting dimension and indexes */
  /* The indexes here are anyway ignored, 
     I follow the convention that the 
     indices are in the matrix (Lattice),
     so I ignore these indices */
  
  if ( !(MLGetInteger(stdlink, &A->dimension)))
    goto L1;
  
  /*  if (!(MLCheckFunction (stdlink, "List", &A->i_count))) */
  if (!(MLCheckFunction(stdlink, "List", &A->i_count)))
    goto L1;
  
  for (i = 0; i < A->i_count; i ++)
    {
      if ( !(MLGetString (stdlink, &s)))
	goto L1;
      strncpy (A->index[i],s, ILEN);
      A->index[i][ILEN-1] = '\0' ;
      MLDisownString (stdlink, s);
    }
  
  
  /* Getting the ZDomain */
  /* Num of Zpols in the Domain */
  /*  if ( !(MLCheckFunction (alink, "List", &A->z_count))) */
  if ( !(MLCheckFunction (stdlink, "List", &A->z_count)))
    goto L1;
  
  z = NULL;
  
  /* Getting each zpol */
  for (i = 0; i < A->z_count; i ++)
    {
      int p_count, NbConstraints, NbRays, NbEq, NbBid ;
      Mat *M;
      Polyhedron *p, *p1;
      
      /*      if (!(GetFunction (alink, "zpol", 2))) */
      if (!(MLGetFunction (stdlink, &s, &count)))
	goto L1;
      
      z1 = z;
      z = (ZPolyhedron *) malloc (sizeof (ZPolyhedron));
      z->next = NULL;
      z->P = NULL;
      z->Lat=NULL;
      
      /* The matrix of the Zpol */
      M = MLGetMatrix (stdlink);
      
      isLat = True;
      if ( ! IsLattice (M->m) )
        isLat = False;
      
      /* Getting the Domain of the Zpol */
      
      p = NULL;
      /*      if (!(MLCheckFunction (alink, "List",(long *) &p_count))) */
      if (!(MLCheckFunction (stdlink, "List", (long *) &p_count)))
	goto L4;
      
	  
      for ( k = 0; k < p_count; k ++)
	{
	  /*	  if (!(GetFunction(alink, "pol", 6))) */
	  if (!(MLGetFunction(stdlink, &s, &count)))
	    goto L4;
	  if (!(MLGetInteger (stdlink, &NbConstraints))) 
	    goto L4;
	  if (!(MLGetInteger (stdlink, &NbRays))) 
	    goto L4;
	  if (!(MLGetInteger (stdlink, &NbEq))) 
	    goto L4;
	  if (!(MLGetInteger (stdlink, &NbBid))) 
	    goto L4;

	  p1 = p;
	  p = Polyhedron_Alloc (A->dimension, NbConstraints, NbRays);
	  if (!p)
	    {
	      errormsg1 ("ZDomlib ", "outofmem", "? out of memory ");
	      goto L4;
	    }
	  if (p1)
	    p1->next = p;
	  else
	    z->P = p;
	  
	  /*	  if ( !(GetFunction (alink, &s, NbConstraints))) */
	  if ( !(MLGetFunction (stdlink, &s, &count)))
	    goto L4;

	  for (j = 0; j < NbConstraints; j ++)
	    {
	      /*	      if ( !(GetFunction(alink, "List", p->Dimension+2))) */
	      if ( !(MLGetFunction(stdlink, &s, &count)))
		goto L4;
	      for (m = 0; m < p->Dimension+2; m ++)
		if ( !(MLGetValue (stdlink, &p->Constraint[j][m])))
		  goto L4;
	    }
	  

	  /*	  if ( !(GetFunction (alink, "List", NbRays))) */
	  if ( !(MLGetFunction (stdlink, &s, &count)))
	    goto L4;
	  for (j = 0; j < NbRays; j ++)
	    {
	      /*	      if ( !(GetFunction (alink, "List", p->Dimension+2))) */
	      if ( !(MLGetFunction (stdlink, &s, &count)))
		goto L4;
	      for (m = 0; m < p->Dimension+2; m ++)
		if ( !(MLGetValue (stdlink, &p->Ray[j][m])))
		  goto L4;
	    }  
	}
      
      
      z->Lat = M->m;
      if (isLat == False)
        {
          ZPolyhedron *temp = NULL;
          temp = IntegraliseLattice (z);
          ZDomain_Free (z);
          z = temp;
        }
      if (z1!=NULL)
	z1->next = z;
      else
        {
          A->Zpol = z;
          A->i_count = M->i_count;
          /* Indices of the Zpol */
          for (j = 0; j < M->i_count; j ++)
            strcpy (A->index[j], M->index[j]);
        }
      free (M);
    }
  
  return A;
  
 L4: ZDomain_Free (z);
  ZDomain_Free (A->Zpol);
 L1: free (A);
  
  return NULL;
}

/*
  A test function. Could be removed afterwords
 */
extern ZDomain *gzd();
ZDomain *gzd()
{   
  ZDomain *zd;

  zd = MLGetZDomain(stdlink);

  return zd;

}




/** MLPutDomain : This function takes as input the 
***               mathlink and the ZDomain, which has to
***               be sent through mathlink to Mathematica
***               and puts the ZDomain in the form of a
***               AST
**/

void MLPutZDomain (MLINK alink , ZDomain* Zd ) 
{
  int i, j;
  ZPolyhedron *z;
  Polyhedron *p;
  Mat *m;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "a");
  fprintf (fp, "\nEntered MLPUTZDOMAIN \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace (" BEGIN MLPutZDomain");
 ZDomainPrint(stderr,P_VALUE_FMT, Zd->Zpol);
#endif 
  
  MLPutFunction (stdlink, "Alpha`domain", 3);
  
  /* Putting the dimension and the indices */
  
  MLPutInteger (stdlink, Zd->dimension);
  
  /* Actually the indices, I put them along with the matrix
     (Lattice). So, I need not put the indices here */
  
  MLPutFunction (stdlink, "List", 0);
  
  /* Putting the ZPolyhedra */
  
  MLPutFunction (stdlink, "List", Zd->z_count);
  
  m = (Mat *) malloc (sizeof (Mat));
  m->i_count = Zd->i_count ;
  m->m = NULL;
  for (i = 0; i < m->i_count; i ++)
    strcpy (m->index[i], Zd->index[i]);
  
  for ( z = Zd->Zpol; z != NULL; z = z->next)
    {
      int p_count = 0;
      /* Putting the Zpolyhedra */
      
      MLPutFunction ( stdlink, "Alpha`zpol", 2 );
      
      /* Putting the lattice */
      m->m = Matrix_Copy ( z->Lat );
#ifdef DEBUG
 Matrix_Print(stderr,P_VALUE_FMT, m->m);
#endif 

      MLPutMatrix (stdlink, m);
      
      /* Putting the Polyhedral Domain */
      for (p = z->P; p != NULL; p = p->next)
	p_count ++ ;
      MLPutFunction (stdlink, "List", p_count);
      for (p = z->P; p != NULL; p = p->next )
	{
	  MLPutFunction (stdlink, "Alpha`pol", 6);
	  MLPutInteger (stdlink, p->NbConstraints);
	  MLPutInteger (stdlink, p->NbRays);
	  MLPutInteger (stdlink, p->NbEq);
	  MLPutInteger (stdlink, p->NbBid);
	  MLPutFunction (stdlink, "List", p->NbConstraints);
	  
	  for ( i = 0; i < p->NbConstraints; i ++)
	    {
	      MLPutFunction (stdlink, "List", p->Dimension+2);
	      for (j = 0; j < p->Dimension+2 ; j  ++)
		MLPutValue (stdlink, p->Constraint[i][j]);
	    }
	  MLPutFunction (stdlink, "List", p->NbRays); 
	  for ( i = 0; i < p->NbRays; i ++)
	    {
	      MLPutFunction (stdlink, "List", p->Dimension+2);
	      for (j = 0; j < p->Dimension+2 ; j  ++)
		MLPutValue (stdlink, p->Ray[i][j]);
	    }
	  
	}
      Matrix_Free (m->m);
    }
#ifdef DEBUG
  trace (" END MLPutZDomain");
#endif 
  free (m);
}

/*
  This function is for testing purpose. It reads a Z-Domain, and
  sends it back to Mathematica.
 */
extern mirrorZDomain (void);
int mirrorZDomain()
{
  ZDomain *zd;
  
  zd = gzd();

  /*
  MLPutFunction(stdlink, "domain", 2);
  MLPutInteger32(stdlink, zd);
  MLPutInteger32(stdlink, zd);
  */

  MLPutZDomain(stdlink, zd);

  return;

}

/* ML_ZZ_Intersection : Intersection of Two ZDomains */

/* int ML_ZZ_Intersection (MLINK alink) */
int ML_ZZ_Intersection ()
{
  ZDomain *z1, *z2, *z3 ;
  ZPolyhedron *z;
  int i, res=0 ;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZZINTERSECTION \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN, ML_ZZ_Intersection");
#endif
  
  
  z1 = MLGetZDomain (stdlink);
  if (!z1)
    goto L0;
  if (!z1->Zpol)
    goto L1;
  
  z2 = MLGetZDomain (stdlink);
  
  if (!z2)
    goto L2;
  if (!z2->Zpol)
    goto L3;
 
  if (!MLNewPacket (stdlink))
    goto L2; 
  
  z3 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z3)
    {
      errormsg1 ("ZZDom Intersection", "outofmem", "? Out of memory");
      goto L4;
    }
  
  z3->i_count = z1->i_count;
  for (i = 0; i < z1->i_count; i ++)
    strcpy (z3->index[i], z1->index[i]);
  
  z3->Zpol = ZDomainIntersection (z1->Zpol, z2->Zpol);
  if ( !z3->Zpol)
    goto L5;
  z3->dimension = z1->dimension;
  
  i = 0;
  for (z = z3->Zpol; z != NULL; z=z->next )
    i ++;
  
  z3->z_count = (long) i;
  MLPutZDomain (stdlink, z3);
  res = 1;
  
  ZDomain_Free (z3->Zpol);
  L5 : free (z3);
  L4 : ZDomain_Free (z2->Zpol);
  L3 : free (z2);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  L0 : return res;
  
}

/* ML_ZP_Intersection : Intersection of A ZDomain and 
                        an Polyhedral Domain the result is
                        an ZDomain. */

int ML_ZP_Intersection ( ) /* MLINK alink) */
{
  int i, res = 0;
  Domain *d ;
  ZDomain *z1, *z2;
  ZPolyhedron *z;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZPINTERSECTION \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_ZP_Intersection");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) goto L0;
  if (!z1->Zpol) goto L1;
  
  d = MLGetDomain (stdlink);
  if (!d) goto L2;
  if (!d->p) goto L3;
  
  if (!MLNewPacket (stdlink)) 
    goto L5;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("Dom(zp)_Intersection", "outofmem", "? out of memory");
      goto L5;
    }
  
  /* copying the indices */
  
  z2->i_count = z1->i_count;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], z1->index[i]);
  
  z = (ZPolyhedron *) malloc ( sizeof (ZPolyhedron));
  if (!z)
    {
      errormsg1 ("Dom(zp)_Intersection", "outofmem", "? out of memory");
      free (z2);
      goto L5;
    }
  
  z->Lat = Identity (z1->Zpol->Lat->NbRows);
  if (! (z->Lat))
    {
      free (z);
      free (z2);
      goto L5;
    }
  z->P = d->p;
  z->next = NULL;
  
  z2->Zpol = ZDomainIntersection (z1->Zpol, z);
  ZDomain_Free (z);
  if (!z2->Zpol)
    goto L4;
  
  z2->dimension = z1->dimension;
  
  i = 0;
  for (z = z2->Zpol; z != NULL ; z = z->next)
    i ++;
  
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L4 : free (z2);
  L3 : free (d);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  L0 : return res ;
  L5 : Domain_Free (d->p);
  goto L3; 
} 

/* ML_PZ_Intersection : Intersection of A Polyhedral Domain
   and an ZDomain the result is
   an ZDomain. */

int ML_PZ_Intersection ( ) /* MLINK alink) */
{
  int i, res = 0;
  Domain *d ;
  ZDomain *z1, *z2;
  ZPolyhedron *z;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLPZINTERSECTION \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_PZ_Intersection");
#endif
  
  
  d = MLGetDomain (stdlink);
  if (!d) goto L0 ;
  if (!d->p) goto L1;
  
  z1 = MLGetZDomain (stdlink);
  if (!z1)  { Domain_Free (d->p); goto L1; }
  if (!z1->Zpol) { Domain_Free (d->p); goto L2; }
  
  if (!MLNewPacket (stdlink)) goto L5 ;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("Dom(zp)_Intersection", "outofmem", "? out of memory");
      goto L5;
    }
  
  /* copying the indices */
  
  z2->i_count = d->i_count;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], d->index[i]);
  
  z = (ZPolyhedron *) malloc ( sizeof (ZPolyhedron));
  if (!z)
    {
      errormsg1 ("Dom(zp)_Intersection", "outofmem", "? out of memory");
      free (z2);
      goto L5;
    }
  
  z->Lat = Identity (z1->Zpol->Lat->NbRows);
  if (! (z->Lat))
    {
      free (z);
      free (z2);
      goto L5;
    }
  z->P=d->p;
  z->next = NULL;
  
  z2->Zpol = ZDomainIntersection (z1->Zpol, z);
  
  if (!z2->Zpol)
    goto L4;
  
  z2->dimension = d->dimension;
  
  i = 0;
  for (z=z2->Zpol; z!=NULL ; z=z->next)
    i ++;
  
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z);
  ZDomain_Free (z2->Zpol);
  L4 : free (z2);
  L3 : ZDomain_Free (z1->Zpol);
  L2 : free (z1);
  L5 : Domain_Free (d->p);
  L1 : free (d);
  L0 : return res ;
} 
/* Union of two ZDomains */

int ML_ZZ_Union ( ) /* MLINK alink) */
{
  ZDomain *z1, *z2, *z3 ;
  ZPolyhedron *z;
  int i, res=0 ;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZZUNION \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN, ML_ZZ_Union");
#endif
  
  /* Get first ZDomain */
  z1 = MLGetZDomain (stdlink);
  if (!z1)
    goto L0;
  if (!z1->Zpol)
    goto L1;
  
  /* Get second ZDomain */
  z2 = MLGetZDomain (stdlink);
  if (!z2)
    goto L2;
  if (!z2->Zpol)
    goto L3;
  
  if (!MLNewPacket (stdlink))
    goto L2; 
  
  /* Allocate memory */
  z3 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z3)
    {
      errormsg1 ("ZZDom Union", "outofmem", "? Out of memory");
      goto L4;
    }
  
  z3->i_count = z1->i_count;
  for (i = 0; i < z1->i_count; i ++)
    strcpy (z3->index[i], z1->index[i]);
  
  z3->Zpol = ZDomainUnion (z1->Zpol, z2->Zpol);
  if ( !z3->Zpol)
    goto L5;
  z3->dimension = z1->dimension;
  
  i = 0;
  for (z = z3->Zpol; z != NULL; z=z->next )
    i ++;
  
  z3->z_count = (long) i;
  MLPutZDomain(stdlink, z3);
  res = 1;
  
  ZDomain_Free (z3->Zpol);
  L5 : free (z3);
  L4 : ZDomain_Free (z2->Zpol);
  L3 : free (z2);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  
  L0 : return res;
}

/* Union of an ZDom and an Polyhedra */

int ML_ZP_Union ( ) /* MLINK alink) */
{
  int i, res = 0;
  Domain *d ;
  ZDomain *z1, *z2;
  ZPolyhedron *z;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZPUNION \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_ZP_Union");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) goto L0;
  if (!z1->Zpol) goto L1;
  
  d = MLGetDomain (stdlink);
  if (!d) goto L2;
  if (!d->p) goto L3;
  
  if (!MLNewPacket (stdlink)) goto L5 ;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("Dom(zp)_Union", "outofmem", "? out of memory");
      goto L5;
    }
  
  /* copying the indices */
  
  z2->i_count = z1->i_count;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], z1->index[i]);
  
  z = (ZPolyhedron *) malloc ( sizeof (ZPolyhedron));
  if (!z)
    {
      errormsg1 ("Dom(zp)_Union", "outofmem", "? out of memory");
      free (z2);
      goto L5;
    }
  
  z->Lat = Identity (z1->Zpol->Lat->NbRows);
  if (! (z->Lat))
    {
      free (z); free (z2);
      goto L5;
    }
  
  z->P=d->p;
  z->next = NULL;
  
  z2->Zpol = ZDomainUnion (z1->Zpol, z);
  ZDomain_Free (z);
  z2->dimension = z1->dimension;
  
  if (!z2->Zpol)
    goto L4;
  
  i = 0;
  for (z = z2->Zpol; z != NULL ; z = z->next)
    i ++;
  
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L4 : free (z2);
  L3 : free (d);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  L0 : return res ;
  L5 : Domain_Free (d->p);
  goto L3;
  
} 

/* Union of a Polyhedral Dom and an ZDom */
int ML_PZ_Union ( ) /* MLINK alink) */
{
  int i, res = 0;
  Domain *d ;
  ZDomain *z1, *z2;
  ZPolyhedron *z;
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLPZUNION \n");
  fclose (fp);
#endif

  
#ifdef DEBUG
  trace ("BEGIN ML_PZ_Union");
#endif
  
  d = MLGetDomain (stdlink);
  if (!d) goto L0;
  if (!d->p) goto L1;
  
  z1 = MLGetZDomain (stdlink);
  if (!z1)
    {
      Domain_Free (d->p);
      goto L1;
    } 
  if (!z1->Zpol) 
    {
      Domain_Free (d->p);
      goto L2;
    } 
  if (!MLNewPacket (stdlink)) goto L5 ;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("Dom(pz)_Union", "outofmem", "? out of memory");
      goto L5;
    }
  
  /* copying the indices */
  
  z2->i_count = d->i_count;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], d->index[i]);
  
  z = (ZPolyhedron *) malloc ( sizeof (ZPolyhedron));
  if (!z)
    {
      errormsg1 ("Dom(pz)_Union", "outofmem", "? out of memory");
      free (z2);
      goto L5;
    }
  
  z->Lat = Identity (z1->Zpol->Lat->NbRows);
  if (! (z->Lat))
    {
      free (z); free (z2); 
      goto L5;
    }
  z->P = d->p;
  z->next = NULL;
  
  z2->Zpol = ZDomainUnion (z1->Zpol, z);
  ZDomain_Free (z);
  if (!z2->Zpol)
    goto L4;
  
  z2->dimension = d->dimension;
  
  i = 0;
  for (z = z2->Zpol; z != NULL ; z = z->next)
    i ++;
  
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L4 : free (z2);
  L3 : ZDomain_Free (z1->Zpol);
  L2 : free (z1);
  L1 : free (d);
  L0 : return res ;
  L5 : Domain_Free (d->p);
  goto L3;
  
} 

int ML_ZZ_Difference ( ) /* MLINK alink) */
{
  ZDomain *z1, *z2, *z3 ;
  ZPolyhedron *z;
  int i, res=0 ;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZZDIFFERENCE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN, ML_ZZ_Difference");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1)
    goto L0;
  if (!z1->Zpol)
    goto L1;
  
  z2 = MLGetZDomain (stdlink);
  if (!z2)
    goto L2;
  if (!z2->Zpol)
    goto L3;
  
  if (!MLNewPacket (stdlink))
    goto L2; 
  
  z3 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z3)
    {
      errormsg1 ("ZZDom Difference", "outofmem", "? Out of memory");
      goto L4;
    }
  
  z3->i_count = z1->i_count;
  for (i = 0; i < z1->i_count; i ++)
    strcpy (z3->index[i], z1->index[i]);
  
  z3->Zpol = ZDomainDifference (z1->Zpol, z2->Zpol);
  if ( !z3->Zpol)
    goto L5;
  z3->dimension = z1->dimension;
  
  i = 0;
  for (z = z3->Zpol; z != NULL; z = z->next )
    i ++;
  
  z3->z_count = (long) i;
  MLPutZDomain ( stdlink, z3);
  res = 1;
  
  ZDomain_Free (z3->Zpol);
  L5 : free (z3);
  L4 : ZDomain_Free (z2->Zpol);
  L3 : free (z2);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  
  L0 : return res;
}


/*Diff of A Zpol and an Polyhedral domain */

int ML_ZP_Difference ( ) /* MLINK alink) */
{
  int i, res = 0;
  Domain *d ;
  ZDomain *z1, *z2;
  ZPolyhedron *z;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZPDIFFERENCE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_ZP_Difference");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) goto L0;
  if (!z1->Zpol) goto L1;
  
  d = MLGetDomain (stdlink);
  if (!d) goto L2;
  if (!d->p) goto L3;
  
  if (!MLNewPacket (stdlink)) goto L5 ;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("Dom(zp)_Difference", "outofmem", "? out of memory");
      goto L5;
    }
  
  /* copying the indices */
  
  z2->i_count = z1->i_count;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], z1->index[i]);
  
  z = (ZPolyhedron *) malloc ( sizeof (ZPolyhedron));
  if (!z)
    {
      errormsg1 ("Dom(zp)_Difference", "outofmem", "? out of memory");
      free (z2);
      goto L5;
    }
  
  z->Lat = Identity (z1->Zpol->Lat->NbRows);
  if ( ! (z->Lat) )
    {
      free (z); free (z2);
      goto L5;
    }
  
  z->P=d->p;
  z->next = NULL;
  
  z2->Zpol = ZDomainDifference (z1->Zpol, z);
  ZDomain_Free (z);
  if (!z2->Zpol)
    goto L4;
  
  z2->dimension = z1->dimension;
  
  i = 0;
  for (z = z2->Zpol; z != NULL ; z = z->next)
    i ++;
  
  z2->z_count = (long) i;
  
  MLPutZDomain (stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L4 : free (z2);
  L3 : free (d);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  L0 : return res ;
  L5 : Domain_Free (d->p);
  goto L3;
  
} 

/*Diff of an Polyhedral domain and Zpol */

int ML_PZ_Difference ( ) /* MLINK alink) */
{
  int i, res = 0;
  Domain *d ;
  ZDomain *z1, *z2;
  ZPolyhedron *z;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLPZDIFFERENCE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_ZP_Difference");
#endif
  
  d = MLGetDomain (stdlink);
  if (!d) goto L0;
  if (!d->p) goto L1;
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) 
    {
      Domain_Free (d->p);
      goto L1;
    }
  if (!z1->Zpol) 
    {
      Domain_Free (d->p);
      goto L2;
    } 
  
  if (!MLNewPacket (stdlink))
    goto L5 ;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("Dom(zp)_Difference", "outofmem", "? out of memory");
      goto L5;
    }
  
  /* copying the indices */
  
  z2->i_count = d->i_count;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], d->index[i]);
  
  z = (ZPolyhedron *) malloc ( sizeof (ZPolyhedron));
  if (!z)
    {
      errormsg1 ("Dom(zp)_Difference", "outofmem", "? out of memory");
      free (z2);
      goto L5;
    }
  
  z->Lat = Identity (z1->Zpol->Lat->NbRows);
  if (! (z->Lat))
    {
      free (z); free (z2);
      goto L5;
    }
  
  z->P = d->p;
  z->next = NULL;
  
  z2->Zpol = ZDomainDifference (z , z1->Zpol);
  ZDomain_Free (z);
  
  if (! (z2->Zpol))
    goto L4;
  
  z2->dimension = d->dimension;
  
  i = 0;
  for (z = z2->Zpol; z != NULL ; z = z->next)
    i ++;
  
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L4 : free (z2);
  L3 : ZDomain_Free (z1->Zpol);
  L2 : free (z1);
  L1 : free (d);
  L0 : return res ;
  L5 : Domain_Free (d->p);
  goto L3; 
  
} 

/** ML_ZImage : Image of an ZPol by
***             an rational invertible function
**/

int ML_ZImage ( ) /* MLINK alink) */
{
  int i,res = 0;
  ZDomain *z1, *z2 ;
  ZPolyhedron *z;
  Mat *m;
  char s[ILEN];
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZIMAGE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_IMAGE");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) goto L0;
  if (!z1->Zpol) goto L1;
  
  m = MLGetMatrix (stdlink);
  if (!m) goto L2;
  if (!m->m) goto L3;
  
  /* if the dim of the matrix != dim of the Zpol -> good bye */
  if ( m->m->NbRows-1 != z1->dimension)
    goto L4;

  if (!MLNewPacket (stdlink)) goto L4;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("DomImage", "outofmemory", "? out of Memory");
      goto L4;
    }
  
  z2->i_count = z1->i_count ;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], z1->index[i]);
  
  /* should I check if the matrix is full dimensional or not here ? */
  /*
    if (! isfulldim (m->m))
    goto L4 ;
  */
  
  
  z2->Zpol = ZDomainImage (z1->Zpol, m->m); 
  if (!z2->Zpol) goto L5 ;
  z2->dimension = z1->dimension ;
  i = 0;
  for (z = z2->Zpol ; z != NULL; z =z->next)
    i ++;
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L5 : free (z2);
  L4 : Matrix_Free (m->m);
  L3 : free (m);
  L2 : ZDomain_Free (z1->Zpol);
  L1 : free (z1);
  L0 : return res;
  
}

/** ML_ZPImage : Image of an ZPol by
***             an rational invertible function
***             For a Zpol it is same as DomImage
**/

int ML_ZPImage ( ) /* MLINK alink) */
{
  int i,res = 0;
  Domain *d1;
  ZDomain *z2 ;
  Matrix *id ;
  ZPolyhedron *z, *zpol= NULL;
  Mat *m;
  char s[ILEN];
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZPIMAGE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_IMAGE");
#endif
  
  d1 = MLGetDomain (stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;
  
  m = MLGetMatrix (stdlink);
  if (!m) {Domain_Free (d1->p);goto L1;}
  if (!m->m) {Domain_Free (d1->p);goto L3;}
  
  id = Identity (d1->dimension+1); 
  zpol = (ZPolyhedron *) malloc (sizeof (ZPolyhedron));
  if (!zpol)
    {
      Matrix_Free (id);
      Domain_Free (d1->p);
      goto L3;
    }
  zpol->next = NULL;
  zpol->Lat = (Lattice *) id;
  zpol->P = d1->p ; 
  
  if (!MLNewPacket (stdlink)) goto L2;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("DomZImage", "outofmemory", "? out of Memory");
      goto L4;
    }
  
  /* if the dim of the matrix != dim of the Zpol -> good bye */
  
  if ( m->m->NbRows-1 != d1->dimension)
    goto L4;
  z2->i_count = d1->i_count ;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], d1->index[i]);
  
  /* should I check if the matrix is full dimensional or not here ? */
  /*
    if (! isfulldim (m->m))
    goto L4 ;
  */
  z2->Zpol = ZDomainImage (zpol, m->m); 
  if (!z2->Zpol) goto L5 ;
  z2->dimension = d1->dimension ;
  i = 0;
  for (z = z2->Zpol ; z != NULL; z =z->next)
    i ++;
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L5 : free (z2);
  L4 : Matrix_Free (m->m);
  L3 : free (m);
  L2 : ZDomain_Free (zpol);
  L1 : free (d1);
  L0 : return res;
  
}

/**
*** ML_ZPPreimage:
***                This function read a Polyhedral Domain from Mathematica
***                and its output is the ZPreimage of that Polyhedral Domain.
**/

int ML_ZPPreimage ( ) /* MLINK alink) */
{
  int i,res = 0;
  Domain *d1;
  ZDomain *z2 ;
  Matrix *id ;
  ZPolyhedron *z, *zpol= NULL;
  Mat *m;
  char s[ILEN];
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZPPREIMAGE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_IMAGE");
#endif
  
  d1 = MLGetDomain (stdlink);
  if (!d1) goto L0;
  if (!d1->p) goto L1;
  
  m = MLGetMatrix (stdlink);
  if (!m) {Domain_Free (d1->p);goto L1;}
  if (!m->m) {Domain_Free (d1->p);goto L3;}
  
  id = Identity (d1->dimension+1); 
  zpol = (ZPolyhedron *) malloc (sizeof (ZPolyhedron));
  if (!zpol)
    {
      Matrix_Free (id);
      Domain_Free (d1->p);
      goto L3;
    }
  zpol->next = NULL;
  zpol->Lat = (Lattice *) id;
  zpol->P = d1->p ; 
  
  if (!MLNewPacket (stdlink)) goto L2;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("DomZPreimage", "outofmemory", "? out of Memory");
      goto L4;
    }
  
  /* if the dim of the matrix != dim of the Zpol -> good bye */
  
  if ( m->m->NbRows-1 != d1->dimension)
    goto L4;

  z2->i_count = m->i_count ;
  for (i = 0; i < z2->i_count; i ++)
    strcpy (z2->index[i], m->index[i]);
  
  /* should I check if the matrix is full dimensional or not here ? */
  /*
    if (! isfulldim (m->m))
    goto L4 ;
  */
  
  z2->Zpol = ZDomainPreimage (zpol, m->m); 
  if (!z2->Zpol) goto L5 ;
  z2->dimension = z2->Zpol->P->Dimension;
  i = 0;
  for (z = z2->Zpol ; z != NULL; z =z->next)
    i ++;
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  
  ZDomain_Free (z2->Zpol);
  L5 : free (z2);
  L4 : Matrix_Free (m->m);
  L3 : free (m);
  L2 : ZDomain_Free (zpol);
  L1 : free (d1);
  L0 : return res;
  
}



/* ML_ZPreimage : Image of a Zpol by a rational function */

int ML_ZPreimage ( ) /* MLINK alink) */
{
  int i, res=0;
  ZDomain *z1, *z2 ;
  Mat *m;
  ZPolyhedron *z;
  char s[ILEN];
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZPREIMAGE \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_PREIMAGE");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) goto L0;
  if (!z1->Zpol) goto L1;
  
  m = MLGetMatrix (stdlink);
  if (!m) goto L2;
  if (!m->m) goto L3;
  
  if (!MLNewPacket (stdlink)) goto L2;
  
  z2 = (ZDomain *) malloc (sizeof (ZDomain));
  if (!z2)
    {
      errormsg1 ("DomPreImage", "outofmemory", "? out of memory");
      goto L4;
    }


  /***** change made: chk for a sqaure matrix not required *****/
    z2->i_count = m->i_count;
    for (i = 0; i < z2->i_count; i ++)
        strcpy (z2->index[i], m->index[i]);


  z2->Zpol = ZDomainPreimage (z1->Zpol, m->m );
  if (!z2->Zpol) goto L5;
  
  z2->dimension = z2->Zpol->P->Dimension;
  i = 0;
  for (z = z2->Zpol; z != NULL; z = z->next)
    i ++;
  z2->z_count = (long) i;
  
  MLPutZDomain ( stdlink, z2);
  res = 1;
  ZDomain_Free (z2->Zpol);
  
 L5: free (z2); 
 L4: Matrix_Free (m->m);
 L3: free (m);
 L2: ZDomain_Free (z1->Zpol);
 L1: free (z1);
 L0: return res ;
  
}

int ML_ZEmptyQ ( ) /* MLINK alink) */
{
  int i,j, res=0;
  ZDomain *z1 ;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLZEMPTYQ \n");
  fclose (fp);
#endif

#ifdef DEBUG
  trace ("BEGIN ML_PREIMAGE");
#endif
  
  z1 = MLGetZDomain (stdlink);
  if (!z1) goto L0;
  if (!z1->Zpol) goto L1;
  if (!MLNewPacket (stdlink)) goto L2;
  
  if (isEmptyZPolyhedron (z1->Zpol)) 
    MLPutSymbol (stdlink, "True");
  else
    MLPutSymbol (stdlink, "False");
  
  res = 1;
 L2: ZDomain_Free (z1->Zpol);
 L1: free (z1);
 L0: return res ;
  
}

/** 
*** ML_LatticeHnf : Takes the Lattice from Mathlink and returns its Hnf
***
**/

int ML_LatticeHnf ( ) /* MLINK alink) */
{
  int i, res = 0;
  Mat *in, *out;
  Matrix *temp, *u;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLLATTICEHERMITE \n");
  fclose (fp);
#endif

  in = MLGetMatrix (stdlink);
  if (!in) goto L0;
  if (!in->m) goto L1;
  if (!MLNewPacket (stdlink)) goto L2;
  
  if ( in->m->NbRows != in->m->NbColumns)
    goto L2;
  
  if ( !(IsLattice (in->m)) ) 
    {
      Matrix *id;
      id = Identity (in->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L2;
        }
      temp = LatticeImage (id, in->m);
      Matrix_Free (id);
      
    }
  else
    temp = Matrix_Copy (in->m);
  
  if (!temp)
    {
      errormsg1 ("ZDomlib", "Outof memory", "Out of Memory");
      goto L2;
    }
  
  out = (Mat *) malloc (sizeof (Mat));
  if (!out)
    {
      errormsg1 ("ZDomlib", "Outof memory", "Out of Memory");
      goto L3;
    }
  
  for (i = 0; i < in->i_count; i ++)
    strcpy (out->index[i], in->index[i]);
  out->i_count = in->i_count;
  AffineHermite (temp, &out->m, &u);
  if (!out->m)
    {
      errormsg1("ZDomlib", "Outof memory", "out of memory");
      goto L4; 
    }
  Matrix_Free (u);
  MLPutMatrix (stdlink, out);
  res = 1;
  Matrix_Free (out->m);
 L4: free (out);
 L3: Matrix_Free (temp);
 L2: Matrix_Free (in->m); 
 L1: free (in);
 L0: return res;
}

/**
*** ML_LatticeIntersection:
*** 	Returns the intersection of the two lattices it reads form Mathlink
***
**/

int ML_LatticeIntersection ( ) /* MLINK alink) */
{
  Mat *l1, *l2, *inter;
  Matrix *temp1, *temp2;
  int i, res = 0;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLLATTICEINTERSECTION \n");
  fclose (fp);
#endif

  l1 = MLGetMatrix (stdlink);
  if (!l1) goto L0;
  if (!(l1->m)) goto L1;
  
  if (!IsLattice (l1->m) )
    {
      Matrix *id;
      id = Identity (l1->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L2;
        }
      temp1 = LatticeImage (id, l1->m);
      Matrix_Free (id);
    }
  else
    temp1 = Matrix_Copy (l1->m);
  
  if (!temp1)
    {
      errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
      goto L2;
    }
  
  l2 = MLGetMatrix (stdlink);
  
  if (!l2) goto L3;
  if (!l2->m) goto L4;
  
  if (! IsLattice (l2->m))
    {
      Matrix *id;
      id = Identity (l2->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L5;
        }
      temp2 = LatticeImage (id, l2->m);
      Matrix_Free (id);
    }
  else
    temp2 = Matrix_Copy (l2->m);
  
  
  if (!temp2)
    {
      errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
      goto L5;
    }
  
  if (!MLNewPacket (stdlink)) goto L6;
  inter = (Mat *) malloc (sizeof (Mat));
  if (!inter) goto L6;
  
  for (i = 0; i < l1->i_count; i ++)
    strcpy (inter->index[i], l1->index[i]);
  
  inter->i_count = l1->i_count;
  
  inter->m = LatticeIntersection (temp1, temp2);
  if (!inter->m)
    goto L7;
  
  res = 1;
  MLPutMatrix (stdlink, inter);
  
  Matrix_Free (inter->m);
 L7: free (inter);
 L6: Matrix_Free (temp2);
 L5: Matrix_Free (l2->m);
 L4: free (l2);
 L3: Matrix_Free (temp1);
 L2: Matrix_Free (l1->m);
 L1: free (l1);
 L0: return res;
  
}

/**
*** ML_LatticeDifference:
*** 	Returns the intersection of the two lattices it reads form Mathlink
***
**/

int ML_LatticeDifference ( ) /* MLINK alink) */
{
  Mat *l1, *l2, *diff;
  Matrix *temp1, *temp2;
  LatticeUnion *Head, *tmp;
  int i, res = 0;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLLATTICEDIFFERENCE \n");
  fclose (fp);
#endif

  l1 = MLGetMatrix (stdlink);
  if (!l1) goto L0;
  if (!(l1->m)) goto L1;
  
  if (!IsLattice (l1->m) )
    {
      Matrix *id;
      id = Identity (l1->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L2;
        }
      temp1 = LatticeImage (id, l1->m);
      Matrix_Free (id);
    }
  else
    temp1 = Matrix_Copy (l1->m);
  
  if (!temp1)
    {
      errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
      goto L2;
    }
  
  l2 = MLGetMatrix (stdlink);
  
  if (!l2) goto L3;
  if (!l2->m) goto L4;
  
  if (! IsLattice (l2->m))
    {
      Matrix *id;
      id = Identity (l2->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L5;
        }
      temp2 = LatticeImage (id, l2->m);
      Matrix_Free (id);
    }
  else
    temp2 = Matrix_Copy (l2->m);
  
  
  if (!temp2)
    {
      errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
      goto L5;
    }
  
  if (!MLNewPacket (stdlink)) goto L6;
  diff = (Mat *) malloc (sizeof (Mat));
  if (!diff) goto L6;
  
  for (i = 0; i < l1->i_count; i ++)
    strcpy (diff->index[i], l1->index[i]);
  
  diff->i_count = l1->i_count;
  
  Head = LatticeDifference (temp1, temp2);
  if (!Head)
    goto L7;
  i = 0;
  for (tmp = Head; tmp != NULL; tmp = tmp->next)
   i ++;

  MLPutFunction (stdlink, "List", i); 
  for (tmp = Head; tmp != NULL; tmp = tmp->next)
   {
     diff->m = (Matrix *) tmp->M;  
     MLPutMatrix (stdlink, diff);
   }
  
  res = 1;
 LatticeUnion_Free (Head);
 L7: free (diff);
 L6: Matrix_Free (temp2);
 L5: Matrix_Free (l2->m);
 L4: free (l2);
 L3: Matrix_Free (temp1);
 L2: Matrix_Free (l1->m);
 L1: free (l1);
 L0: return res;
  
}

int ML_LatticeImage ( ) /* MLINK alink) */
{
  Mat *l1, *l2, *image;
  Matrix *temp1 ;
  int i, res = 0;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLLATTICEIMAGE \n");
  fclose (fp);
#endif

  l1 = MLGetMatrix (stdlink);
  if (!l1) goto L0;
  if (!(l1->m)) goto L1;
  
  if (!IsLattice (l1->m) )
    {
      Matrix *id;
      id = Identity (l1->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L2;
        }
      temp1 = LatticeImage ((Lattice *)id, l1->m);
      Matrix_Free (id);
    }
  else
    temp1 = Matrix_Copy (l1->m);
  
  if (!temp1)
    {
      errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
      goto L2;
    }
  
  l2 = MLGetMatrix (stdlink);
  
  if (!l2) goto L3;
  if (!l2->m) goto L4;
  
  if (!MLNewPacket (stdlink)) goto L5;
  image = (Mat *) malloc (sizeof (Mat));
  if (!image) goto L5;
  
  for (i = 0; i < l1->i_count; i ++)
    strcpy (image->index[i], l1->index[i]);
  
  image->i_count = l1->i_count;
  
  image->m = (Matrix *) LatticeImage ((Lattice *)temp1, l2->m);
  if (!image->m)
    goto L7;
  
  res = 1;
  MLPutMatrix (stdlink, image);
  
  Matrix_Free (image->m);
 L7: free (image);
 L5: Matrix_Free (l2->m);
 L4: free (l2);
 L3: Matrix_Free (temp1);
 L2: Matrix_Free (l1->m);
 L1: free (l1);
 L0: return res;
  
}

int ML_LatticePreimage () /*MLINK alink) */
{
  Mat *l1, *l2, *preim;
  Matrix *temp1 ;
  int i, res = 0;
  
#ifdef DOMDEBUG
  FILE *fp;
  fp = fopen ("_debug", "w");
  fprintf (fp, "\nEntered MLLATTICEPREIMAGE \n");
  fclose (fp);
#endif

  l1 = MLGetMatrix (stdlink);
  if (!l1) goto L0;
  if (!(l1->m)) goto L1;
  
  if (!IsLattice (l1->m) )
    {
      Matrix *id;
      id = Identity (l1->m->NbRows);
      if (!id)
        {
          errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
          goto L2;
        }
      temp1 = LatticeImage ((Lattice *)id, l1->m);
      Matrix_Free (id);
    }
  else
    temp1 = Matrix_Copy (l1->m);
  
  if (!temp1)
    {
      errormsg1 ("ZDomlib", "Out of memory", "Out of Memory");
      goto L2;
    }
  
  l2 = MLGetMatrix (stdlink);
  
  if (!l2) goto L3;
  if (!l2->m) goto L4;
  
  if (!MLNewPacket (stdlink)) goto L5;
  preim = (Mat *) malloc (sizeof (Mat));
  if (!preim) goto L5;
  
  for (i = 0; i < l1->i_count; i ++)
    strcpy (preim->index[i], l1->index[i]);
  
  preim->i_count = l1->i_count;
  
  preim->m = (Matrix *) LatticePreimage ((Lattice *)temp1, l2->m);
  if (!preim->m)
    goto L7;
  
  res = 1;
  MLPutMatrix (stdlink, preim);
  
  Matrix_Free (preim->m);
 L7: free (preim);
 L5: Matrix_Free (l2->m);
 L4: free (l2);
 L3: Matrix_Free (temp1);
 L2: Matrix_Free (l1->m);
 L1: free (l1);
 L0: return res;
  
}
