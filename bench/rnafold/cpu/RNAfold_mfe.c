/* compiled by the ADP compiler, version 0.9 (rev 42)    Thu Apr  9 11:59:05 CEST 2009 */
/* source file: RNAfold.lhs                                                         */
/* command:                                                                         */
/* adpcompile -c RNAfold.lhs -al mfe enum -cs mfe -alpp pp -O -lcf -ta bt -bt so -gc cc -iuc -cto -tadd 3 -taddc 30 -W -o RNAfold_mfe.adpc */
/* -------------------------------------------------------------------------------- */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "options.h"


#include "adplib.h"
#include "rnalib.h"
int maxloop;


static void *hlp;  /* help pointer */
static void *hlp2; /* help pointer */

static tsequence *seq;
static toptions  *opts;

static char *z;
static int   n;
/* data structures                                                                  */
/* -------------------------------------------------------------------------------- */

struct str1 {
   struct str1 *next;
   struct str1 *last;
   struct str_Signature *item;
};
struct str2 {
   int alg_mfe;
   struct str1 *alg_enum;
};
struct str3 {
   struct str3 *next;
   struct str3 *last;
   struct str2 item;
};

/* supporting functions for objective functions                                     */
/* -------------------------------------------------------------------------------- */

static int sort_TLInt(void *p, void *q)
{
   int result;

   result = (*((int *)p)) > (*((int *)q)) ? 1 : (-1);
   return result;
}

static char nub_TLInt(void *p, void *q)
{
   char result;

   result = (*((int *)p)) == (*((int *)q));
   return result;
}

static int sort_PointerOfStructOfstrSignature(void *p, void *q)
{
   int result;

   result = (*((struct str_Signature **)p)) > (*((struct str_Signature **)q)) ? 1 : (-1);
   return result;
}

static char nub_PointerOfStructOfstrSignature(void *p, void *q)
{
   char result;

   result = (*((struct str_Signature **)p)) == (*((struct str_Signature **)q));
   return result;
}

/* backtrace variables                                                              */
/* -------------------------------------------------------------------------------- */

static struct str1 **pp_next, **pp_initA, **removeAddr;
static struct str1 ***pp_init;
static int pp_initC;
static int copy_depth;
static struct str1 *backtrace_tree;
static char *pp_outp, *result_prettyprint;
static int traceback_diff;
static char rmAllowed;

/* signature                                                                        */
/* -------------------------------------------------------------------------------- */

#define SIGID__NTID 1
#define SIGID_Sadd 2
#define SIGID_Cadd 3
#define SIGID_Is 4
#define SIGID_Sr 5
#define SIGID_Hl 6
#define SIGID_Bl 7
#define SIGID_Br 8
#define SIGID_Il 9
#define SIGID_Ml 10
#define SIGID_Mldl 11
#define SIGID_Mldr 12
#define SIGID_Mldlr 13
#define SIGID_Cons 14
#define SIGID_Ul 15
#define SIGID_Addss 16
#define SIGID_Ssadd 17
#define SIGID_Nil 18
#define SIGID_Combine 19

struct str_Signature {
   int utype;
   void *entry;
   char fcalled;
};

static struct str1 *new_Signature(int u, void *entry)
{
   struct str_Signature *t;
   struct str1 *l;

   t=(struct str_Signature *) myalloc(adp_dynmem, sizeof(struct str_Signature ));
   t->utype = u;
   t->entry = entry;
   t->fcalled = 0;
   l=(struct str1 *) myalloc(adp_dynmem, sizeof(struct str1 ));
   l->item = t;
   l->next = NULL;
   l->last = l;
   return l;
}

/* signature operators                                                              */
/* -------------------------------------------------------------------------------- */
/* operator _NTID                                                                   */
/* -------------------------------------------------------------------------------- */

struct str__NTID {
   int isStructure1;
   struct str1 *structure1;
   struct str1 *a1;
   struct str1 *pp_init_a1;
   struct str1 *(*f1)(int , int , int );
   int i1, j1;
   int diff1;
};

static struct str1 *new__NTID(struct str1 *(*f1)(int , int , int ), int i1, int j1)
{
   struct str__NTID *t;

   t=(struct str__NTID *) myalloc(adp_dynmem, sizeof(struct str__NTID ));
   t->isStructure1 = 0;
   t->f1 = f1;
   t->i1 = i1;
   t->j1 = j1;
   return new_Signature(SIGID__NTID, t);
}

/* operator Sadd                                                                    */
/* -------------------------------------------------------------------------------- */

struct str_Sadd {
   int a1;
   int isStructure2;
   struct str1 *structure2;
   struct str1 *a2;
   struct str1 *pp_init_a2;
   struct str1 *(*f2)(int , int , int );
   int i2, j2;
   int diff2;
};

static struct str1 *new_Sadd_f(int a1, struct str1 *(*f2)(int , int , int ), int i2, int j2)
{
   struct str_Sadd *t;

   t=(struct str_Sadd *) myalloc(adp_dynmem, sizeof(struct str_Sadd ));
   t->a1 = a1;
   t->isStructure2 = 0;
   t->f2 = f2;
   t->i2 = i2;
   t->j2 = j2;
   return new_Signature(SIGID_Sadd, t);
}


/* operator Cadd                                                                    */
/* -------------------------------------------------------------------------------- */

struct str_Cadd {
   int isStructure1;
   struct str1 *structure1;
   struct str1 *a1;
   struct str1 *pp_init_a1;
   struct str1 *(*f1)(int , int , int );
   int i1, j1;
   int diff1;
   int isStructure2;
   struct str1 *structure2;
   struct str1 *a2;
   struct str1 *pp_init_a2;
   struct str1 *(*f2)(int , int , int );
   int i2, j2;
   int diff2;
};

static struct str1 *new_Cadd_ff(struct str1 *(*f1)(int , int , int ), int i1, int j1, struct str1 *(*f2)(int , int , int ), int i2, int j2)
{
   struct str_Cadd *t;

   t=(struct str_Cadd *) myalloc(adp_dynmem, sizeof(struct str_Cadd ));
   t->isStructure1 = 0;
   t->f1 = f1;
   t->i1 = i1;
   t->j1 = j1;
   t->isStructure2 = 0;
   t->f2 = f2;
   t->i2 = i2;
   t->j2 = j2;
   return new_Signature(SIGID_Cadd, t);
}




/* operator Is                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Is {
   int a1;
   int isStructure2;
   struct str1 *structure2;
   struct str1 *a2;
   struct str1 *pp_init_a2;
   struct str1 *(*f2)(int , int , int );
   int i2, j2;
   int diff2;
   int a3;
};

static struct str1 *new_Is_f(int a1, struct str1 *(*f2)(int , int , int ), int i2, int j2, int a3)
{
   struct str_Is *t;

   t=(struct str_Is *) myalloc(adp_dynmem, sizeof(struct str_Is ));
   t->a1 = a1;
   t->isStructure2 = 0;
   t->f2 = f2;
   t->i2 = i2;
   t->j2 = j2;
   t->a3 = a3;
   return new_Signature(SIGID_Is, t);
}


/* operator Sr                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Sr {
   int a1;
   int isStructure2;
   struct str1 *structure2;
   struct str1 *a2;
   struct str1 *pp_init_a2;
   struct str1 *(*f2)(int , int , int );
   int i2, j2;
   int diff2;
   int a3;
};

static struct str1 *new_Sr_f(int a1, struct str1 *(*f2)(int , int , int ), int i2, int j2, int a3)
{
   struct str_Sr *t;

   t=(struct str_Sr *) myalloc(adp_dynmem, sizeof(struct str_Sr ));
   t->a1 = a1;
   t->isStructure2 = 0;
   t->f2 = f2;
   t->i2 = i2;
   t->j2 = j2;
   t->a3 = a3;
   return new_Signature(SIGID_Sr, t);
}


/* operator Hl                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Hl {
   int a1;
   int a2;
   int a3;
   int a4;
   int a5;
   int a6;
   int diff;
};

static struct str1 *new_Hl_(int a1, int a2, int a3, int a4, int a5, int a6)
{
   struct str_Hl *t;

   t=(struct str_Hl *) myalloc(adp_dynmem, sizeof(struct str_Hl ));
   t->a1 = a1;
   t->a2 = a2;
   t->a3 = a3;
   t->a4 = a4;
   t->a5 = a5;
   t->a6 = a6;
   return new_Signature(SIGID_Hl, t);
}

/* operator Bl                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Bl {
   int a1;
   int a2;
   int a3;
   int a4;
   int isStructure5;
   struct str1 *structure5;
   struct str1 *a5;
   struct str1 *pp_init_a5;
   struct str1 *(*f5)(int , int , int );
   int i5, j5;
   int diff5;
   int a6;
   int a7;
};

static struct str1 *new_Bl_f(int a1, int a2, int a3, int a4, struct str1 *(*f5)(int , int , int ), int i5, int j5, int a6, int a7)
{
   struct str_Bl *t;

   t=(struct str_Bl *) myalloc(adp_dynmem, sizeof(struct str_Bl ));
   t->a1 = a1;
   t->a2 = a2;
   t->a3 = a3;
   t->a4 = a4;
   t->isStructure5 = 0;
   t->f5 = f5;
   t->i5 = i5;
   t->j5 = j5;
   t->a6 = a6;
   t->a7 = a7;
   return new_Signature(SIGID_Bl, t);
}


/* operator Br                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Br {
   int a1;
   int a2;
   int isStructure3;
   struct str1 *structure3;
   struct str1 *a3;
   struct str1 *pp_init_a3;
   struct str1 *(*f3)(int , int , int );
   int i3, j3;
   int diff3;
   int a4;
   int a5;
   int a6;
   int a7;
};

static struct str1 *new_Br_f(int a1, int a2, struct str1 *(*f3)(int , int , int ), int i3, int j3, int a4, int a5, int a6, int a7)
{
   struct str_Br *t;

   t=(struct str_Br *) myalloc(adp_dynmem, sizeof(struct str_Br ));
   t->a1 = a1;
   t->a2 = a2;
   t->isStructure3 = 0;
   t->f3 = f3;
   t->i3 = i3;
   t->j3 = j3;
   t->a4 = a4;
   t->a5 = a5;
   t->a6 = a6;
   t->a7 = a7;
   return new_Signature(SIGID_Br, t);
}


/* operator Il                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Il {
   int a1;
   int a2;
   int a3;
   int a4;
   int isStructure5;
   struct str1 *structure5;
   struct str1 *a5;
   struct str1 *pp_init_a5;
   struct str1 *(*f5)(int , int , int );
   int i5, j5;
   int diff5;
   int a6;
   int a7;
   int a8;
   int a9;
};

static struct str1 *new_Il_f(int a1, int a2, int a3, int a4, struct str1 *(*f5)(int , int , int ), int i5, int j5, int a6, int a7, int a8, int a9)
{
   struct str_Il *t;

   t=(struct str_Il *) myalloc(adp_dynmem, sizeof(struct str_Il ));
   t->a1 = a1;
   t->a2 = a2;
   t->a3 = a3;
   t->a4 = a4;
   t->isStructure5 = 0;
   t->f5 = f5;
   t->i5 = i5;
   t->j5 = j5;
   t->a6 = a6;
   t->a7 = a7;
   t->a8 = a8;
   t->a9 = a9;
   return new_Signature(SIGID_Il, t);
}


/* operator Ml                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Ml {
   int a1;
   int a2;
   int isStructure3;
   struct str1 *structure3;
   struct str1 *a3;
   struct str1 *pp_init_a3;
   struct str1 *(*f3)(int , int , int );
   int i3, j3;
   int diff3;
   int a4;
   int a5;
};

static struct str1 *new_Ml_f(int a1, int a2, struct str1 *(*f3)(int , int , int ), int i3, int j3, int a4, int a5)
{
   struct str_Ml *t;

   t=(struct str_Ml *) myalloc(adp_dynmem, sizeof(struct str_Ml ));
   t->a1 = a1;
   t->a2 = a2;
   t->isStructure3 = 0;
   t->f3 = f3;
   t->i3 = i3;
   t->j3 = j3;
   t->a4 = a4;
   t->a5 = a5;
   return new_Signature(SIGID_Ml, t);
}


/* operator Mldl                                                                    */
/* -------------------------------------------------------------------------------- */

struct str_Mldl {
   int a1;
   int a2;
   int a3;
   int isStructure4;
   struct str1 *structure4;
   struct str1 *a4;
   struct str1 *pp_init_a4;
   struct str1 *(*f4)(int , int , int );
   int i4, j4;
   int diff4;
   int a5;
   int a6;
};

static struct str1 *new_Mldl_f(int a1, int a2, int a3, struct str1 *(*f4)(int , int , int ), int i4, int j4, int a5, int a6)
{
   struct str_Mldl *t;

   t=(struct str_Mldl *) myalloc(adp_dynmem, sizeof(struct str_Mldl ));
   t->a1 = a1;
   t->a2 = a2;
   t->a3 = a3;
   t->isStructure4 = 0;
   t->f4 = f4;
   t->i4 = i4;
   t->j4 = j4;
   t->a5 = a5;
   t->a6 = a6;
   return new_Signature(SIGID_Mldl, t);
}


/* operator Mldr                                                                    */
/* -------------------------------------------------------------------------------- */

struct str_Mldr {
   int a1;
   int a2;
   int isStructure3;
   struct str1 *structure3;
   struct str1 *a3;
   struct str1 *pp_init_a3;
   struct str1 *(*f3)(int , int , int );
   int i3, j3;
   int diff3;
   int a4;
   int a5;
   int a6;
};

static struct str1 *new_Mldr_f(int a1, int a2, struct str1 *(*f3)(int , int , int ), int i3, int j3, int a4, int a5, int a6)
{
   struct str_Mldr *t;

   t=(struct str_Mldr *) myalloc(adp_dynmem, sizeof(struct str_Mldr ));
   t->a1 = a1;
   t->a2 = a2;
   t->isStructure3 = 0;
   t->f3 = f3;
   t->i3 = i3;
   t->j3 = j3;
   t->a4 = a4;
   t->a5 = a5;
   t->a6 = a6;
   return new_Signature(SIGID_Mldr, t);
}


/* operator Mldlr                                                                   */
/* -------------------------------------------------------------------------------- */

struct str_Mldlr {
   int a1;
   int a2;
   int a3;
   int isStructure4;
   struct str1 *structure4;
   struct str1 *a4;
   struct str1 *pp_init_a4;
   struct str1 *(*f4)(int , int , int );
   int i4, j4;
   int diff4;
   int a5;
   int a6;
   int a7;
};

static struct str1 *new_Mldlr_f(int a1, int a2, int a3, struct str1 *(*f4)(int , int , int ), int i4, int j4, int a5, int a6, int a7)
{
   struct str_Mldlr *t;

   t=(struct str_Mldlr *) myalloc(adp_dynmem, sizeof(struct str_Mldlr ));
   t->a1 = a1;
   t->a2 = a2;
   t->a3 = a3;
   t->isStructure4 = 0;
   t->f4 = f4;
   t->i4 = i4;
   t->j4 = j4;
   t->a5 = a5;
   t->a6 = a6;
   t->a7 = a7;
   return new_Signature(SIGID_Mldlr, t);
}


/* operator Cons                                                                    */
/* -------------------------------------------------------------------------------- */

struct str_Cons {
   int isStructure1;
   struct str1 *structure1;
   struct str1 *a1;
   struct str1 *pp_init_a1;
   struct str1 *(*f1)(int , int , int );
   int i1, j1;
   int diff1;
   int isStructure2;
   struct str1 *structure2;
   struct str1 *a2;
   struct str1 *pp_init_a2;
   struct str1 *(*f2)(int , int , int );
   int i2, j2;
   int diff2;
};

static struct str1 *new_Cons_ff(struct str1 *(*f1)(int , int , int ), int i1, int j1, struct str1 *(*f2)(int , int , int ), int i2, int j2)
{
   struct str_Cons *t;

   t=(struct str_Cons *) myalloc(adp_dynmem, sizeof(struct str_Cons ));
   t->isStructure1 = 0;
   t->f1 = f1;
   t->i1 = i1;
   t->j1 = j1;
   t->isStructure2 = 0;
   t->f2 = f2;
   t->i2 = i2;
   t->j2 = j2;
   return new_Signature(SIGID_Cons, t);
}




/* operator Ul                                                                      */
/* -------------------------------------------------------------------------------- */

struct str_Ul {
   int isStructure1;
   struct str1 *structure1;
   struct str1 *a1;
   struct str1 *pp_init_a1;
   struct str1 *(*f1)(int , int , int );
   int i1, j1;
   int diff1;
};

static struct str1 *new_Ul_f(struct str1 *(*f1)(int , int , int ), int i1, int j1)
{
   struct str_Ul *t;

   t=(struct str_Ul *) myalloc(adp_dynmem, sizeof(struct str_Ul ));
   t->isStructure1 = 0;
   t->f1 = f1;
   t->i1 = i1;
   t->j1 = j1;
   return new_Signature(SIGID_Ul, t);
}


/* operator Addss                                                                   */
/* -------------------------------------------------------------------------------- */

struct str_Addss {
   int isStructure1;
   struct str1 *structure1;
   struct str1 *a1;
   struct str1 *pp_init_a1;
   struct str1 *(*f1)(int , int , int );
   int i1, j1;
   int diff1;
   int a2;
   int a3;
};

static struct str1 *new_Addss_f(struct str1 *(*f1)(int , int , int ), int i1, int j1, int a2, int a3)
{
   struct str_Addss *t;

   t=(struct str_Addss *) myalloc(adp_dynmem, sizeof(struct str_Addss ));
   t->isStructure1 = 0;
   t->f1 = f1;
   t->i1 = i1;
   t->j1 = j1;
   t->a2 = a2;
   t->a3 = a3;
   return new_Signature(SIGID_Addss, t);
}


/* operator Ssadd                                                                   */
/* -------------------------------------------------------------------------------- */

struct str_Ssadd {
   int a1;
   int a2;
   int isStructure3;
   struct str1 *structure3;
   struct str1 *a3;
   struct str1 *pp_init_a3;
   struct str1 *(*f3)(int , int , int );
   int i3, j3;
   int diff3;
};

static struct str1 *new_Ssadd_f(int a1, int a2, struct str1 *(*f3)(int , int , int ), int i3, int j3)
{
   struct str_Ssadd *t;

   t=(struct str_Ssadd *) myalloc(adp_dynmem, sizeof(struct str_Ssadd ));
   t->a1 = a1;
   t->a2 = a2;
   t->isStructure3 = 0;
   t->f3 = f3;
   t->i3 = i3;
   t->j3 = j3;
   return new_Signature(SIGID_Ssadd, t);
}


/* operator Nil                                                                     */
/* -------------------------------------------------------------------------------- */

struct str_Nil {
   int a1;
   int diff;
};

static struct str1 *new_Nil_(int a1)
{
   struct str_Nil *t;

   t=(struct str_Nil *) myalloc(adp_dynmem, sizeof(struct str_Nil ));
   t->a1 = a1;
   return new_Signature(SIGID_Nil, t);
}

/* operator Combine                                                                 */
/* -------------------------------------------------------------------------------- */

struct str_Combine {
   int isStructure1;
   struct str1 *structure1;
   struct str1 *a1;
   struct str1 *pp_init_a1;
   struct str1 *(*f1)(int , int , int );
   int i1, j1;
   int diff1;
   int isStructure2;
   struct str1 *structure2;
   struct str1 *a2;
   struct str1 *pp_init_a2;
   struct str1 *(*f2)(int , int , int );
   int i2, j2;
   int diff2;
};

static struct str1 *new_Combine_ff(struct str1 *(*f1)(int , int , int ), int i1, int j1, struct str1 *(*f2)(int , int , int ), int i2, int j2)
{
   struct str_Combine *t;

   t=(struct str_Combine *) myalloc(adp_dynmem, sizeof(struct str_Combine ));
   t->isStructure1 = 0;
   t->f1 = f1;
   t->i1 = i1;
   t->j1 = j1;
   t->isStructure2 = 0;
   t->f2 = f2;
   t->i2 = i2;
   t->j2 = j2;
   return new_Signature(SIGID_Combine, t);
}




/* signature pretty printer                                                         */
/* -------------------------------------------------------------------------------- */
static int pp_str_Signature(struct str1 *l)
{
   struct str_Signature *c;
   int score, score1, score2, score3, score4;
   int score5, score6, score7, score8, score9;

   if (l != NULL) {
      c = l->item;
      switch (c->utype) {
         case SIGID__NTID:
            if (((struct str__NTID *)(c->entry))->a1 != NULL) {
               if (((struct str__NTID *)(c->entry))->a1->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str__NTID *)(c->entry))->a1);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str__NTID *)(c->entry))->a1);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str__NTID *)(c->entry))->a1);
                     pp_initA[pp_initC] = ((struct str__NTID *)(c->entry))->pp_init_a1;
                  }
               }
               score1 = pp_str_Signature(((struct str__NTID *)(c->entry))->a1);
               score = score1;
            }
            break;
         case SIGID_Sadd:
            if (((struct str_Sadd *)(c->entry))->a2 != NULL) {
               sprintf(pp_outp, ".");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Sadd *)(c->entry))->a2->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Sadd *)(c->entry))->a2);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Sadd *)(c->entry))->a2);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Sadd *)(c->entry))->a2);
                     pp_initA[pp_initC] = ((struct str_Sadd *)(c->entry))->pp_init_a2;
                  }
               }
               score2 = pp_str_Signature(((struct str_Sadd *)(c->entry))->a2);
               score = score2;
            }
            break;
         case SIGID_Cadd:
            rmAllowed = 0;
            if ((((struct str_Cadd *)(c->entry))->a1 != NULL) && (((struct str_Cadd *)(c->entry))->a2 != NULL)) {
               if (((struct str_Cadd *)(c->entry))->a1->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Cadd *)(c->entry))->a1);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Cadd *)(c->entry))->a1);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Cadd *)(c->entry))->a1);
                     pp_initA[pp_initC] = ((struct str_Cadd *)(c->entry))->pp_init_a1;
                  }
               }
               score1 = pp_str_Signature(((struct str_Cadd *)(c->entry))->a1);
               if (((struct str_Cadd *)(c->entry))->a2->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Cadd *)(c->entry))->a2);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Cadd *)(c->entry))->a2);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Cadd *)(c->entry))->a2);
                     pp_initA[pp_initC] = ((struct str_Cadd *)(c->entry))->pp_init_a2;
                  }
               }
               score2 = pp_str_Signature(((struct str_Cadd *)(c->entry))->a2);
               score = score1 + score2;
            }
            break;
         case SIGID_Is:
            if (((struct str_Is *)(c->entry))->a2 != NULL) {
               if (((struct str_Is *)(c->entry))->a2->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Is *)(c->entry))->a2);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Is *)(c->entry))->a2);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Is *)(c->entry))->a2);
                     pp_initA[pp_initC] = ((struct str_Is *)(c->entry))->pp_init_a2;
                  }
               }
               score2 = pp_str_Signature(((struct str_Is *)(c->entry))->a2);
               score = score2 + termaupenalty(((struct str_Is *)(c->entry))->a1 + 1, ((struct str_Is *)(c->entry))->a3);
            }
            break;
         case SIGID_Sr:
            if (((struct str_Sr *)(c->entry))->a2 != NULL) {
               sprintf(pp_outp, "(");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Sr *)(c->entry))->a2->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Sr *)(c->entry))->a2);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Sr *)(c->entry))->a2);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Sr *)(c->entry))->a2);
                     pp_initA[pp_initC] = ((struct str_Sr *)(c->entry))->pp_init_a2;
                  }
               }
               score2 = pp_str_Signature(((struct str_Sr *)(c->entry))->a2);
               sprintf(pp_outp, ")");
               pp_outp = pp_outp + strlen(pp_outp);
               score = score2 + sr_energy(((struct str_Sr *)(c->entry))->a1, ((struct str_Sr *)(c->entry))->a3);
            }
            break;
         case SIGID_Hl:
            sprintf(pp_outp, "((");
            pp_outp = pp_outp + strlen(pp_outp);
            sprintf(pp_outp, "%s", dots(((struct str_Hl *)(c->entry))->a3, ((struct str_Hl *)(c->entry))->a4));
            pp_outp = pp_outp + strlen(pp_outp);
            sprintf(pp_outp, "))");
            pp_outp = pp_outp + strlen(pp_outp);
            score = hl_energy(((struct str_Hl *)(c->entry))->a2, ((struct str_Hl *)(c->entry))->a5) + sr_energy(((struct str_Hl *)(c->entry))->a1, ((struct str_Hl *)(c->entry))->a6);
            break;
         case SIGID_Bl:
            if (((struct str_Bl *)(c->entry))->a5 != NULL) {
               sprintf(pp_outp, "((");
               pp_outp = pp_outp + strlen(pp_outp);
               sprintf(pp_outp, "%s", dots(((struct str_Bl *)(c->entry))->a3, ((struct str_Bl *)(c->entry))->a4));
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Bl *)(c->entry))->a5->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Bl *)(c->entry))->a5);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Bl *)(c->entry))->a5);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Bl *)(c->entry))->a5);
                     pp_initA[pp_initC] = ((struct str_Bl *)(c->entry))->pp_init_a5;
                  }
               }
               score5 = pp_str_Signature(((struct str_Bl *)(c->entry))->a5);
               sprintf(pp_outp, "))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = (score5 + bl_energy(((struct str_Bl *)(c->entry))->a2, ((struct str_Bl *)(c->entry))->a3, ((struct str_Bl *)(c->entry))->a4, ((struct str_Bl *)(c->entry))->a6)) + sr_energy(((struct str_Bl *)(c->entry))->a1, ((struct str_Bl *)(c->entry))->a7);
            }
            break;
         case SIGID_Br:
            if (((struct str_Br *)(c->entry))->a3 != NULL) {
               sprintf(pp_outp, "((");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Br *)(c->entry))->a3->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Br *)(c->entry))->a3);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Br *)(c->entry))->a3);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Br *)(c->entry))->a3);
                     pp_initA[pp_initC] = ((struct str_Br *)(c->entry))->pp_init_a3;
                  }
               }
               score3 = pp_str_Signature(((struct str_Br *)(c->entry))->a3);
               sprintf(pp_outp, "%s", dots(((struct str_Br *)(c->entry))->a4, ((struct str_Br *)(c->entry))->a5));
               pp_outp = pp_outp + strlen(pp_outp);
               sprintf(pp_outp, "))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = (score3 + br_energy(((struct str_Br *)(c->entry))->a2, ((struct str_Br *)(c->entry))->a4, ((struct str_Br *)(c->entry))->a5, ((struct str_Br *)(c->entry))->a6)) + sr_energy(((struct str_Br *)(c->entry))->a1, ((struct str_Br *)(c->entry))->a7);
            }
            break;
         case SIGID_Il:
            if (((struct str_Il *)(c->entry))->a5 != NULL) {
               sprintf(pp_outp, "((");
               pp_outp = pp_outp + strlen(pp_outp);
               sprintf(pp_outp, "%s", dots(((struct str_Il *)(c->entry))->a3, ((struct str_Il *)(c->entry))->a4));
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Il *)(c->entry))->a5->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Il *)(c->entry))->a5);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Il *)(c->entry))->a5);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Il *)(c->entry))->a5);
                     pp_initA[pp_initC] = ((struct str_Il *)(c->entry))->pp_init_a5;
                  }
               }
               score5 = pp_str_Signature(((struct str_Il *)(c->entry))->a5);
               sprintf(pp_outp, "%s", dots(((struct str_Il *)(c->entry))->a6, ((struct str_Il *)(c->entry))->a7));
               pp_outp = pp_outp + strlen(pp_outp);
               sprintf(pp_outp, "))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = (score5 + sr_energy(((struct str_Il *)(c->entry))->a1, ((struct str_Il *)(c->entry))->a9)) + il_energy(((struct str_Il *)(c->entry))->a3, ((struct str_Il *)(c->entry))->a4, ((struct str_Il *)(c->entry))->a6, ((struct str_Il *)(c->entry))->a7);
            }
            break;
         case SIGID_Ml:
            if (((struct str_Ml *)(c->entry))->a3 != NULL) {
               sprintf(pp_outp, "((");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Ml *)(c->entry))->a3->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Ml *)(c->entry))->a3);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Ml *)(c->entry))->a3);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Ml *)(c->entry))->a3);
                     pp_initA[pp_initC] = ((struct str_Ml *)(c->entry))->pp_init_a3;
                  }
               }
               score3 = pp_str_Signature(((struct str_Ml *)(c->entry))->a3);
               sprintf(pp_outp, "))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = ((380 + score3) + sr_energy(((struct str_Ml *)(c->entry))->a1, ((struct str_Ml *)(c->entry))->a5)) + termaupenalty(((struct str_Ml *)(c->entry))->a2, ((struct str_Ml *)(c->entry))->a4);
            }
            break;
         case SIGID_Mldl:
            if (((struct str_Mldl *)(c->entry))->a4 != NULL) {
               sprintf(pp_outp, "((.");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Mldl *)(c->entry))->a4->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Mldl *)(c->entry))->a4);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Mldl *)(c->entry))->a4);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Mldl *)(c->entry))->a4);
                     pp_initA[pp_initC] = ((struct str_Mldl *)(c->entry))->pp_init_a4;
                  }
               }
               score4 = pp_str_Signature(((struct str_Mldl *)(c->entry))->a4);
               sprintf(pp_outp, "))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = (((380 + score4) + dli_energy(((struct str_Mldl *)(c->entry))->a2, ((struct str_Mldl *)(c->entry))->a5)) + sr_energy(((struct str_Mldl *)(c->entry))->a1, ((struct str_Mldl *)(c->entry))->a6)) + termaupenalty(((struct str_Mldl *)(c->entry))->a2, ((struct str_Mldl *)(c->entry))->a5);
            }
            break;
         case SIGID_Mldr:
            if (((struct str_Mldr *)(c->entry))->a3 != NULL) {
               sprintf(pp_outp, "((");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Mldr *)(c->entry))->a3->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Mldr *)(c->entry))->a3);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Mldr *)(c->entry))->a3);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Mldr *)(c->entry))->a3);
                     pp_initA[pp_initC] = ((struct str_Mldr *)(c->entry))->pp_init_a3;
                  }
               }
               score3 = pp_str_Signature(((struct str_Mldr *)(c->entry))->a3);
               sprintf(pp_outp, ".))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = (((380 + score3) + dri_energy(((struct str_Mldr *)(c->entry))->a2, ((struct str_Mldr *)(c->entry))->a5)) + sr_energy(((struct str_Mldr *)(c->entry))->a1, ((struct str_Mldr *)(c->entry))->a6)) + termaupenalty(((struct str_Mldr *)(c->entry))->a2, ((struct str_Mldr *)(c->entry))->a5);
            }
            break;
         case SIGID_Mldlr:
            if (((struct str_Mldlr *)(c->entry))->a4 != NULL) {
               sprintf(pp_outp, "((.");
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Mldlr *)(c->entry))->a4->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Mldlr *)(c->entry))->a4);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Mldlr *)(c->entry))->a4);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Mldlr *)(c->entry))->a4);
                     pp_initA[pp_initC] = ((struct str_Mldlr *)(c->entry))->pp_init_a4;
                  }
               }
               score4 = pp_str_Signature(((struct str_Mldlr *)(c->entry))->a4);
               sprintf(pp_outp, ".))");
               pp_outp = pp_outp + strlen(pp_outp);
               score = ((((380 + score4) + dli_energy(((struct str_Mldlr *)(c->entry))->a2, ((struct str_Mldlr *)(c->entry))->a6)) + dri_energy(((struct str_Mldlr *)(c->entry))->a2, ((struct str_Mldlr *)(c->entry))->a6)) + sr_energy(((struct str_Mldlr *)(c->entry))->a1, ((struct str_Mldlr *)(c->entry))->a7)) + termaupenalty(((struct str_Mldlr *)(c->entry))->a2, ((struct str_Mldlr *)(c->entry))->a6);
            }
            break;
         case SIGID_Cons:
            rmAllowed = 0;
            if ((((struct str_Cons *)(c->entry))->a1 != NULL) && (((struct str_Cons *)(c->entry))->a2 != NULL)) {
               if (((struct str_Cons *)(c->entry))->a1->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Cons *)(c->entry))->a1);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Cons *)(c->entry))->a1);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Cons *)(c->entry))->a1);
                     pp_initA[pp_initC] = ((struct str_Cons *)(c->entry))->pp_init_a1;
                  }
               }
               score1 = pp_str_Signature(((struct str_Cons *)(c->entry))->a1);
               if (((struct str_Cons *)(c->entry))->a2->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Cons *)(c->entry))->a2);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Cons *)(c->entry))->a2);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Cons *)(c->entry))->a2);
                     pp_initA[pp_initC] = ((struct str_Cons *)(c->entry))->pp_init_a2;
                  }
               }
               score2 = pp_str_Signature(((struct str_Cons *)(c->entry))->a2);
               score = score1 + score2;
            }
            break;
         case SIGID_Ul:
            if (((struct str_Ul *)(c->entry))->a1 != NULL) {
               if (((struct str_Ul *)(c->entry))->a1->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Ul *)(c->entry))->a1);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Ul *)(c->entry))->a1);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Ul *)(c->entry))->a1);
                     pp_initA[pp_initC] = ((struct str_Ul *)(c->entry))->pp_init_a1;
                  }
               }
               score1 = pp_str_Signature(((struct str_Ul *)(c->entry))->a1);
               score = 40 + score1;
            }
            break;
         case SIGID_Addss:
            if (((struct str_Addss *)(c->entry))->a1 != NULL) {
               if (((struct str_Addss *)(c->entry))->a1->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Addss *)(c->entry))->a1);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Addss *)(c->entry))->a1);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Addss *)(c->entry))->a1);
                     pp_initA[pp_initC] = ((struct str_Addss *)(c->entry))->pp_init_a1;
                  }
               }
               score1 = pp_str_Signature(((struct str_Addss *)(c->entry))->a1);
               sprintf(pp_outp, "%s", dots(((struct str_Addss *)(c->entry))->a2, ((struct str_Addss *)(c->entry))->a3));
               pp_outp = pp_outp + strlen(pp_outp);
               score = score1 + ss_energy(((struct str_Addss *)(c->entry))->a2, ((struct str_Addss *)(c->entry))->a3);
            }
            break;
         case SIGID_Ssadd:
            if (((struct str_Ssadd *)(c->entry))->a3 != NULL) {
               sprintf(pp_outp, "%s", dots(((struct str_Ssadd *)(c->entry))->a1, ((struct str_Ssadd *)(c->entry))->a2));
               pp_outp = pp_outp + strlen(pp_outp);
               if (((struct str_Ssadd *)(c->entry))->a3->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Ssadd *)(c->entry))->a3);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Ssadd *)(c->entry))->a3);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Ssadd *)(c->entry))->a3);
                     pp_initA[pp_initC] = ((struct str_Ssadd *)(c->entry))->pp_init_a3;
                  }
               }
               score3 = pp_str_Signature(((struct str_Ssadd *)(c->entry))->a3);
               score = (40 + score3) + ss_energy(((struct str_Ssadd *)(c->entry))->a1, ((struct str_Ssadd *)(c->entry))->a2);
            }
            break;
         case SIGID_Nil:
            sprintf(pp_outp, "");
            pp_outp = pp_outp + strlen(pp_outp);
            score = 0;
            break;
         case SIGID_Combine:
            rmAllowed = 0;
            if ((((struct str_Combine *)(c->entry))->a1 != NULL) && (((struct str_Combine *)(c->entry))->a2 != NULL)) {
               if (((struct str_Combine *)(c->entry))->a1->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Combine *)(c->entry))->a1);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Combine *)(c->entry))->a1);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Combine *)(c->entry))->a1);
                     pp_initA[pp_initC] = ((struct str_Combine *)(c->entry))->pp_init_a1;
                  }
               }
               score1 = pp_str_Signature(((struct str_Combine *)(c->entry))->a1);
               if (((struct str_Combine *)(c->entry))->a2->next != NULL) {
                  if (rmAllowed) {
                     removeAddr = &(((struct str_Combine *)(c->entry))->a2);
                  }
                  else {
                     removeAddr = NULL;
                  }
                  pp_next = &(((struct str_Combine *)(c->entry))->a2);
                  pp_initC = (-1);
               }
               else {
                  if (removeAddr == NULL) {
                     pp_initC = pp_initC + 1;
                     pp_init[pp_initC] = &(((struct str_Combine *)(c->entry))->a2);
                     pp_initA[pp_initC] = ((struct str_Combine *)(c->entry))->pp_init_a2;
                  }
               }
               score2 = pp_str_Signature(((struct str_Combine *)(c->entry))->a2);
               score = score1 + score2;
            }
            break;
      }
   }
   return score;
}

/* copy structures                                                                  */
/* -------------------------------------------------------------------------------- */
static struct str1 *copy_str_Signature(struct str1 *l)
{
   struct str1 *itr, *nstr, *last, *first, *setnext;
   void *entr;
   int id;

   copy_depth = copy_depth + 1;
   itr = l;
   first = NULL;
   setnext = NULL;
   while (itr != NULL) {
      nstr=(struct str1 *) malloc(sizeof(struct str1 ));
      nstr->next = NULL;
      nstr->last = nstr;
      if (setnext) {
         setnext->next = nstr;
      }
      setnext = nstr;
      if (first == NULL) {
         first = nstr;
      }
      nstr->item=(struct str_Signature *) malloc(sizeof(struct str_Signature ));
      (*nstr->item) = (*itr->item);
      id = itr->item->utype;
      entr = itr->item->entry;
      switch (id) {
         case SIGID__NTID:
            nstr->item->entry=(struct str__NTID *) malloc(sizeof(struct str__NTID ));
            (*((struct str__NTID *)(nstr->item->entry))) = (*((struct str__NTID *)entr));
            if (((struct str__NTID *)(nstr->item->entry))->isStructure1) {
               ((struct str__NTID *)(nstr->item->entry))->structure1 = copy_str_Signature(((struct str__NTID *)entr)->structure1);
            }
            break;
         case SIGID_Sadd:
            nstr->item->entry=(struct str_Sadd *) malloc(sizeof(struct str_Sadd ));
            (*((struct str_Sadd *)(nstr->item->entry))) = (*((struct str_Sadd *)entr));
            if (((struct str_Sadd *)(nstr->item->entry))->isStructure2) {
               ((struct str_Sadd *)(nstr->item->entry))->structure2 = copy_str_Signature(((struct str_Sadd *)entr)->structure2);
            }
            break;
         case SIGID_Cadd:
            nstr->item->entry=(struct str_Cadd *) malloc(sizeof(struct str_Cadd ));
            (*((struct str_Cadd *)(nstr->item->entry))) = (*((struct str_Cadd *)entr));
            if (((struct str_Cadd *)(nstr->item->entry))->isStructure1) {
               ((struct str_Cadd *)(nstr->item->entry))->structure1 = copy_str_Signature(((struct str_Cadd *)entr)->structure1);
            }
            if (((struct str_Cadd *)(nstr->item->entry))->isStructure2) {
               ((struct str_Cadd *)(nstr->item->entry))->structure2 = copy_str_Signature(((struct str_Cadd *)entr)->structure2);
            }
            break;
         case SIGID_Is:
            nstr->item->entry=(struct str_Is *) malloc(sizeof(struct str_Is ));
            (*((struct str_Is *)(nstr->item->entry))) = (*((struct str_Is *)entr));
            if (((struct str_Is *)(nstr->item->entry))->isStructure2) {
               ((struct str_Is *)(nstr->item->entry))->structure2 = copy_str_Signature(((struct str_Is *)entr)->structure2);
            }
            break;
         case SIGID_Sr:
            nstr->item->entry=(struct str_Sr *) malloc(sizeof(struct str_Sr ));
            (*((struct str_Sr *)(nstr->item->entry))) = (*((struct str_Sr *)entr));
            if (((struct str_Sr *)(nstr->item->entry))->isStructure2) {
               ((struct str_Sr *)(nstr->item->entry))->structure2 = copy_str_Signature(((struct str_Sr *)entr)->structure2);
            }
            break;
         case SIGID_Hl:
            nstr->item->entry=(struct str_Hl *) malloc(sizeof(struct str_Hl ));
            (*((struct str_Hl *)(nstr->item->entry))) = (*((struct str_Hl *)entr));
            break;
         case SIGID_Bl:
            nstr->item->entry=(struct str_Bl *) malloc(sizeof(struct str_Bl ));
            (*((struct str_Bl *)(nstr->item->entry))) = (*((struct str_Bl *)entr));
            if (((struct str_Bl *)(nstr->item->entry))->isStructure5) {
               ((struct str_Bl *)(nstr->item->entry))->structure5 = copy_str_Signature(((struct str_Bl *)entr)->structure5);
            }
            break;
         case SIGID_Br:
            nstr->item->entry=(struct str_Br *) malloc(sizeof(struct str_Br ));
            (*((struct str_Br *)(nstr->item->entry))) = (*((struct str_Br *)entr));
            if (((struct str_Br *)(nstr->item->entry))->isStructure3) {
               ((struct str_Br *)(nstr->item->entry))->structure3 = copy_str_Signature(((struct str_Br *)entr)->structure3);
            }
            break;
         case SIGID_Il:
            nstr->item->entry=(struct str_Il *) malloc(sizeof(struct str_Il ));
            (*((struct str_Il *)(nstr->item->entry))) = (*((struct str_Il *)entr));
            if (((struct str_Il *)(nstr->item->entry))->isStructure5) {
               ((struct str_Il *)(nstr->item->entry))->structure5 = copy_str_Signature(((struct str_Il *)entr)->structure5);
            }
            break;
         case SIGID_Ml:
            nstr->item->entry=(struct str_Ml *) malloc(sizeof(struct str_Ml ));
            (*((struct str_Ml *)(nstr->item->entry))) = (*((struct str_Ml *)entr));
            if (((struct str_Ml *)(nstr->item->entry))->isStructure3) {
               ((struct str_Ml *)(nstr->item->entry))->structure3 = copy_str_Signature(((struct str_Ml *)entr)->structure3);
            }
            break;
         case SIGID_Mldl:
            nstr->item->entry=(struct str_Mldl *) malloc(sizeof(struct str_Mldl ));
            (*((struct str_Mldl *)(nstr->item->entry))) = (*((struct str_Mldl *)entr));
            if (((struct str_Mldl *)(nstr->item->entry))->isStructure4) {
               ((struct str_Mldl *)(nstr->item->entry))->structure4 = copy_str_Signature(((struct str_Mldl *)entr)->structure4);
            }
            break;
         case SIGID_Mldr:
            nstr->item->entry=(struct str_Mldr *) malloc(sizeof(struct str_Mldr ));
            (*((struct str_Mldr *)(nstr->item->entry))) = (*((struct str_Mldr *)entr));
            if (((struct str_Mldr *)(nstr->item->entry))->isStructure3) {
               ((struct str_Mldr *)(nstr->item->entry))->structure3 = copy_str_Signature(((struct str_Mldr *)entr)->structure3);
            }
            break;
         case SIGID_Mldlr:
            nstr->item->entry=(struct str_Mldlr *) malloc(sizeof(struct str_Mldlr ));
            (*((struct str_Mldlr *)(nstr->item->entry))) = (*((struct str_Mldlr *)entr));
            if (((struct str_Mldlr *)(nstr->item->entry))->isStructure4) {
               ((struct str_Mldlr *)(nstr->item->entry))->structure4 = copy_str_Signature(((struct str_Mldlr *)entr)->structure4);
            }
            break;
         case SIGID_Cons:
            nstr->item->entry=(struct str_Cons *) malloc(sizeof(struct str_Cons ));
            (*((struct str_Cons *)(nstr->item->entry))) = (*((struct str_Cons *)entr));
            if (((struct str_Cons *)(nstr->item->entry))->isStructure1) {
               ((struct str_Cons *)(nstr->item->entry))->structure1 = copy_str_Signature(((struct str_Cons *)entr)->structure1);
            }
            if (((struct str_Cons *)(nstr->item->entry))->isStructure2) {
               ((struct str_Cons *)(nstr->item->entry))->structure2 = copy_str_Signature(((struct str_Cons *)entr)->structure2);
            }
            break;
         case SIGID_Ul:
            nstr->item->entry=(struct str_Ul *) malloc(sizeof(struct str_Ul ));
            (*((struct str_Ul *)(nstr->item->entry))) = (*((struct str_Ul *)entr));
            if (((struct str_Ul *)(nstr->item->entry))->isStructure1) {
               ((struct str_Ul *)(nstr->item->entry))->structure1 = copy_str_Signature(((struct str_Ul *)entr)->structure1);
            }
            break;
         case SIGID_Addss:
            nstr->item->entry=(struct str_Addss *) malloc(sizeof(struct str_Addss ));
            (*((struct str_Addss *)(nstr->item->entry))) = (*((struct str_Addss *)entr));
            if (((struct str_Addss *)(nstr->item->entry))->isStructure1) {
               ((struct str_Addss *)(nstr->item->entry))->structure1 = copy_str_Signature(((struct str_Addss *)entr)->structure1);
            }
            break;
         case SIGID_Ssadd:
            nstr->item->entry=(struct str_Ssadd *) malloc(sizeof(struct str_Ssadd ));
            (*((struct str_Ssadd *)(nstr->item->entry))) = (*((struct str_Ssadd *)entr));
            if (((struct str_Ssadd *)(nstr->item->entry))->isStructure3) {
               ((struct str_Ssadd *)(nstr->item->entry))->structure3 = copy_str_Signature(((struct str_Ssadd *)entr)->structure3);
            }
            break;
         case SIGID_Nil:
            nstr->item->entry=(struct str_Nil *) malloc(sizeof(struct str_Nil ));
            (*((struct str_Nil *)(nstr->item->entry))) = (*((struct str_Nil *)entr));
            break;
         case SIGID_Combine:
            nstr->item->entry=(struct str_Combine *) malloc(sizeof(struct str_Combine ));
            (*((struct str_Combine *)(nstr->item->entry))) = (*((struct str_Combine *)entr));
            if (((struct str_Combine *)(nstr->item->entry))->isStructure1) {
               ((struct str_Combine *)(nstr->item->entry))->structure1 = copy_str_Signature(((struct str_Combine *)entr)->structure1);
            }
            if (((struct str_Combine *)(nstr->item->entry))->isStructure2) {
               ((struct str_Combine *)(nstr->item->entry))->structure2 = copy_str_Signature(((struct str_Combine *)entr)->structure2);
            }
            break;
      }
      itr = itr->next;
   }
   if (first) {
      last = nstr;
      itr = first;
      while (itr != NULL) {
         itr->last = last;
         itr = itr->next;
      }
   }
   copy_depth = copy_depth - 1;
   return first;
}

/* free structures                                                                  */
/* -------------------------------------------------------------------------------- */
static void free_str_Signature(char rmAll, struct str1 *l)
{
   struct str1 *itr, *nitr;
   struct str_Signature *c;

   itr = l;
   while (itr != NULL) {
      c = itr->item;
      if (c != NULL) {
         switch (c->utype) {
            case SIGID__NTID:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str__NTID *)(c->entry))->pp_init_a1);
               }
               else {
                  free_str_Signature(rmAll, ((struct str__NTID *)(c->entry))->a1);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Sadd:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Sadd *)(c->entry))->pp_init_a2);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Sadd *)(c->entry))->a2);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Cadd:
               free_str_Signature(1, ((struct str_Cadd *)(c->entry))->pp_init_a1);
               free_str_Signature(1, ((struct str_Cadd *)(c->entry))->pp_init_a2);
               free(c->entry);
               free(c);
               break;
            case SIGID_Is:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Is *)(c->entry))->pp_init_a2);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Is *)(c->entry))->a2);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Sr:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Sr *)(c->entry))->pp_init_a2);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Sr *)(c->entry))->a2);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Hl:
               free(c->entry);
               free(c);
               break;
            case SIGID_Bl:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Bl *)(c->entry))->pp_init_a5);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Bl *)(c->entry))->a5);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Br:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Br *)(c->entry))->pp_init_a3);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Br *)(c->entry))->a3);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Il:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Il *)(c->entry))->pp_init_a5);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Il *)(c->entry))->a5);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Ml:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Ml *)(c->entry))->pp_init_a3);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Ml *)(c->entry))->a3);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Mldl:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Mldl *)(c->entry))->pp_init_a4);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Mldl *)(c->entry))->a4);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Mldr:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Mldr *)(c->entry))->pp_init_a3);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Mldr *)(c->entry))->a3);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Mldlr:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Mldlr *)(c->entry))->pp_init_a4);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Mldlr *)(c->entry))->a4);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Cons:
               free_str_Signature(1, ((struct str_Cons *)(c->entry))->pp_init_a1);
               free_str_Signature(1, ((struct str_Cons *)(c->entry))->pp_init_a2);
               free(c->entry);
               free(c);
               break;
            case SIGID_Ul:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Ul *)(c->entry))->pp_init_a1);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Ul *)(c->entry))->a1);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Addss:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Addss *)(c->entry))->pp_init_a1);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Addss *)(c->entry))->a1);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Ssadd:
               if (rmAll) {
                  free_str_Signature(rmAll, ((struct str_Ssadd *)(c->entry))->pp_init_a3);
               }
               else {
                  free_str_Signature(rmAll, ((struct str_Ssadd *)(c->entry))->a3);
               }
               free(c->entry);
               free(c);
               break;
            case SIGID_Nil:
               free(c->entry);
               free(c);
               break;
            case SIGID_Combine:
               free_str_Signature(1, ((struct str_Combine *)(c->entry))->pp_init_a1);
               free_str_Signature(1, ((struct str_Combine *)(c->entry))->pp_init_a2);
               free(c->entry);
               free(c);
               break;
         }
      }
      nitr = itr->next;
      free(itr);
      if (rmAll) {
         itr = nitr;
      }
      else {
         itr = NULL;
      }
   }
}

/* structure builder                                                                */
/* -------------------------------------------------------------------------------- */
static struct str1 *build_str_Signature(struct str1 *l)
{
   struct str_Signature *c;
   struct str1 *cl;

   if (l != NULL) {
      cl = l;
      c = cl->item;
      if (c->fcalled == 0) {
         c->fcalled = 1;
         switch (c->utype) {
            case SIGID__NTID:
               if (((struct str__NTID *)(c->entry))->isStructure1) {
                  ((struct str__NTID *)(c->entry))->a1 = build_str_Signature(((struct str__NTID *)(c->entry))->structure1);
                  ((struct str__NTID *)(c->entry))->pp_init_a1 = ((struct str__NTID *)(c->entry))->a1;
               }
               else {
                  ((struct str__NTID *)(c->entry))->a1 = (*((struct str__NTID *)(c->entry))->f1)(((struct str__NTID *)(c->entry))->i1, ((struct str__NTID *)(c->entry))->j1, ((struct str__NTID *)(c->entry))->diff1);
                  ((struct str__NTID *)(c->entry))->pp_init_a1 = ((struct str__NTID *)(c->entry))->a1;
               }
               break;
            case SIGID_Sadd:
               if (((struct str_Sadd *)(c->entry))->isStructure2) {
                  ((struct str_Sadd *)(c->entry))->a2 = build_str_Signature(((struct str_Sadd *)(c->entry))->structure2);
                  ((struct str_Sadd *)(c->entry))->pp_init_a2 = ((struct str_Sadd *)(c->entry))->a2;
               }
               else {
                  ((struct str_Sadd *)(c->entry))->a2 = (*((struct str_Sadd *)(c->entry))->f2)(((struct str_Sadd *)(c->entry))->i2, ((struct str_Sadd *)(c->entry))->j2, ((struct str_Sadd *)(c->entry))->diff2);
                  ((struct str_Sadd *)(c->entry))->pp_init_a2 = ((struct str_Sadd *)(c->entry))->a2;
               }
               break;
            case SIGID_Cadd:
               if (((struct str_Cadd *)(c->entry))->isStructure1) {
                  ((struct str_Cadd *)(c->entry))->a1 = build_str_Signature(((struct str_Cadd *)(c->entry))->structure1);
                  ((struct str_Cadd *)(c->entry))->pp_init_a1 = ((struct str_Cadd *)(c->entry))->a1;
               }
               else {
                  ((struct str_Cadd *)(c->entry))->a1 = (*((struct str_Cadd *)(c->entry))->f1)(((struct str_Cadd *)(c->entry))->i1, ((struct str_Cadd *)(c->entry))->j1, ((struct str_Cadd *)(c->entry))->diff1);
                  ((struct str_Cadd *)(c->entry))->pp_init_a1 = ((struct str_Cadd *)(c->entry))->a1;
               }
               if (((struct str_Cadd *)(c->entry))->isStructure2) {
                  ((struct str_Cadd *)(c->entry))->a2 = build_str_Signature(((struct str_Cadd *)(c->entry))->structure2);
                  ((struct str_Cadd *)(c->entry))->pp_init_a2 = ((struct str_Cadd *)(c->entry))->a2;
               }
               else {
                  ((struct str_Cadd *)(c->entry))->a2 = (*((struct str_Cadd *)(c->entry))->f2)(((struct str_Cadd *)(c->entry))->i2, ((struct str_Cadd *)(c->entry))->j2, ((struct str_Cadd *)(c->entry))->diff2);
                  ((struct str_Cadd *)(c->entry))->pp_init_a2 = ((struct str_Cadd *)(c->entry))->a2;
               }
               break;
            case SIGID_Is:
               if (((struct str_Is *)(c->entry))->isStructure2) {
                  ((struct str_Is *)(c->entry))->a2 = build_str_Signature(((struct str_Is *)(c->entry))->structure2);
                  ((struct str_Is *)(c->entry))->pp_init_a2 = ((struct str_Is *)(c->entry))->a2;
               }
               else {
                  ((struct str_Is *)(c->entry))->a2 = (*((struct str_Is *)(c->entry))->f2)(((struct str_Is *)(c->entry))->i2, ((struct str_Is *)(c->entry))->j2, ((struct str_Is *)(c->entry))->diff2);
                  ((struct str_Is *)(c->entry))->pp_init_a2 = ((struct str_Is *)(c->entry))->a2;
               }
               break;
            case SIGID_Sr:
               if (((struct str_Sr *)(c->entry))->isStructure2) {
                  ((struct str_Sr *)(c->entry))->a2 = build_str_Signature(((struct str_Sr *)(c->entry))->structure2);
                  ((struct str_Sr *)(c->entry))->pp_init_a2 = ((struct str_Sr *)(c->entry))->a2;
               }
               else {
                  ((struct str_Sr *)(c->entry))->a2 = (*((struct str_Sr *)(c->entry))->f2)(((struct str_Sr *)(c->entry))->i2, ((struct str_Sr *)(c->entry))->j2, ((struct str_Sr *)(c->entry))->diff2);
                  ((struct str_Sr *)(c->entry))->pp_init_a2 = ((struct str_Sr *)(c->entry))->a2;
               }
               break;
            case SIGID_Hl:
               break;
            case SIGID_Bl:
               if (((struct str_Bl *)(c->entry))->isStructure5) {
                  ((struct str_Bl *)(c->entry))->a5 = build_str_Signature(((struct str_Bl *)(c->entry))->structure5);
                  ((struct str_Bl *)(c->entry))->pp_init_a5 = ((struct str_Bl *)(c->entry))->a5;
               }
               else {
                  ((struct str_Bl *)(c->entry))->a5 = (*((struct str_Bl *)(c->entry))->f5)(((struct str_Bl *)(c->entry))->i5, ((struct str_Bl *)(c->entry))->j5, ((struct str_Bl *)(c->entry))->diff5);
                  ((struct str_Bl *)(c->entry))->pp_init_a5 = ((struct str_Bl *)(c->entry))->a5;
               }
               break;
            case SIGID_Br:
               if (((struct str_Br *)(c->entry))->isStructure3) {
                  ((struct str_Br *)(c->entry))->a3 = build_str_Signature(((struct str_Br *)(c->entry))->structure3);
                  ((struct str_Br *)(c->entry))->pp_init_a3 = ((struct str_Br *)(c->entry))->a3;
               }
               else {
                  ((struct str_Br *)(c->entry))->a3 = (*((struct str_Br *)(c->entry))->f3)(((struct str_Br *)(c->entry))->i3, ((struct str_Br *)(c->entry))->j3, ((struct str_Br *)(c->entry))->diff3);
                  ((struct str_Br *)(c->entry))->pp_init_a3 = ((struct str_Br *)(c->entry))->a3;
               }
               break;
            case SIGID_Il:
               if (((struct str_Il *)(c->entry))->isStructure5) {
                  ((struct str_Il *)(c->entry))->a5 = build_str_Signature(((struct str_Il *)(c->entry))->structure5);
                  ((struct str_Il *)(c->entry))->pp_init_a5 = ((struct str_Il *)(c->entry))->a5;
               }
               else {
                  ((struct str_Il *)(c->entry))->a5 = (*((struct str_Il *)(c->entry))->f5)(((struct str_Il *)(c->entry))->i5, ((struct str_Il *)(c->entry))->j5, ((struct str_Il *)(c->entry))->diff5);
                  ((struct str_Il *)(c->entry))->pp_init_a5 = ((struct str_Il *)(c->entry))->a5;
               }
               break;
            case SIGID_Ml:
               if (((struct str_Ml *)(c->entry))->isStructure3) {
                  ((struct str_Ml *)(c->entry))->a3 = build_str_Signature(((struct str_Ml *)(c->entry))->structure3);
                  ((struct str_Ml *)(c->entry))->pp_init_a3 = ((struct str_Ml *)(c->entry))->a3;
               }
               else {
                  ((struct str_Ml *)(c->entry))->a3 = (*((struct str_Ml *)(c->entry))->f3)(((struct str_Ml *)(c->entry))->i3, ((struct str_Ml *)(c->entry))->j3, ((struct str_Ml *)(c->entry))->diff3);
                  ((struct str_Ml *)(c->entry))->pp_init_a3 = ((struct str_Ml *)(c->entry))->a3;
               }
               break;
            case SIGID_Mldl:
               if (((struct str_Mldl *)(c->entry))->isStructure4) {
                  ((struct str_Mldl *)(c->entry))->a4 = build_str_Signature(((struct str_Mldl *)(c->entry))->structure4);
                  ((struct str_Mldl *)(c->entry))->pp_init_a4 = ((struct str_Mldl *)(c->entry))->a4;
               }
               else {
                  ((struct str_Mldl *)(c->entry))->a4 = (*((struct str_Mldl *)(c->entry))->f4)(((struct str_Mldl *)(c->entry))->i4, ((struct str_Mldl *)(c->entry))->j4, ((struct str_Mldl *)(c->entry))->diff4);
                  ((struct str_Mldl *)(c->entry))->pp_init_a4 = ((struct str_Mldl *)(c->entry))->a4;
               }
               break;
            case SIGID_Mldr:
               if (((struct str_Mldr *)(c->entry))->isStructure3) {
                  ((struct str_Mldr *)(c->entry))->a3 = build_str_Signature(((struct str_Mldr *)(c->entry))->structure3);
                  ((struct str_Mldr *)(c->entry))->pp_init_a3 = ((struct str_Mldr *)(c->entry))->a3;
               }
               else {
                  ((struct str_Mldr *)(c->entry))->a3 = (*((struct str_Mldr *)(c->entry))->f3)(((struct str_Mldr *)(c->entry))->i3, ((struct str_Mldr *)(c->entry))->j3, ((struct str_Mldr *)(c->entry))->diff3);
                  ((struct str_Mldr *)(c->entry))->pp_init_a3 = ((struct str_Mldr *)(c->entry))->a3;
               }
               break;
            case SIGID_Mldlr:
               if (((struct str_Mldlr *)(c->entry))->isStructure4) {
                  ((struct str_Mldlr *)(c->entry))->a4 = build_str_Signature(((struct str_Mldlr *)(c->entry))->structure4);
                  ((struct str_Mldlr *)(c->entry))->pp_init_a4 = ((struct str_Mldlr *)(c->entry))->a4;
               }
               else {
                  ((struct str_Mldlr *)(c->entry))->a4 = (*((struct str_Mldlr *)(c->entry))->f4)(((struct str_Mldlr *)(c->entry))->i4, ((struct str_Mldlr *)(c->entry))->j4, ((struct str_Mldlr *)(c->entry))->diff4);
                  ((struct str_Mldlr *)(c->entry))->pp_init_a4 = ((struct str_Mldlr *)(c->entry))->a4;
               }
               break;
            case SIGID_Cons:
               if (((struct str_Cons *)(c->entry))->isStructure1) {
                  ((struct str_Cons *)(c->entry))->a1 = build_str_Signature(((struct str_Cons *)(c->entry))->structure1);
                  ((struct str_Cons *)(c->entry))->pp_init_a1 = ((struct str_Cons *)(c->entry))->a1;
               }
               else {
                  ((struct str_Cons *)(c->entry))->a1 = (*((struct str_Cons *)(c->entry))->f1)(((struct str_Cons *)(c->entry))->i1, ((struct str_Cons *)(c->entry))->j1, ((struct str_Cons *)(c->entry))->diff1);
                  ((struct str_Cons *)(c->entry))->pp_init_a1 = ((struct str_Cons *)(c->entry))->a1;
               }
               if (((struct str_Cons *)(c->entry))->isStructure2) {
                  ((struct str_Cons *)(c->entry))->a2 = build_str_Signature(((struct str_Cons *)(c->entry))->structure2);
                  ((struct str_Cons *)(c->entry))->pp_init_a2 = ((struct str_Cons *)(c->entry))->a2;
               }
               else {
                  ((struct str_Cons *)(c->entry))->a2 = (*((struct str_Cons *)(c->entry))->f2)(((struct str_Cons *)(c->entry))->i2, ((struct str_Cons *)(c->entry))->j2, ((struct str_Cons *)(c->entry))->diff2);
                  ((struct str_Cons *)(c->entry))->pp_init_a2 = ((struct str_Cons *)(c->entry))->a2;
               }
               break;
            case SIGID_Ul:
               if (((struct str_Ul *)(c->entry))->isStructure1) {
                  ((struct str_Ul *)(c->entry))->a1 = build_str_Signature(((struct str_Ul *)(c->entry))->structure1);
                  ((struct str_Ul *)(c->entry))->pp_init_a1 = ((struct str_Ul *)(c->entry))->a1;
               }
               else {
                  ((struct str_Ul *)(c->entry))->a1 = (*((struct str_Ul *)(c->entry))->f1)(((struct str_Ul *)(c->entry))->i1, ((struct str_Ul *)(c->entry))->j1, ((struct str_Ul *)(c->entry))->diff1);
                  ((struct str_Ul *)(c->entry))->pp_init_a1 = ((struct str_Ul *)(c->entry))->a1;
               }
               break;
            case SIGID_Addss:
               if (((struct str_Addss *)(c->entry))->isStructure1) {
                  ((struct str_Addss *)(c->entry))->a1 = build_str_Signature(((struct str_Addss *)(c->entry))->structure1);
                  ((struct str_Addss *)(c->entry))->pp_init_a1 = ((struct str_Addss *)(c->entry))->a1;
               }
               else {
                  ((struct str_Addss *)(c->entry))->a1 = (*((struct str_Addss *)(c->entry))->f1)(((struct str_Addss *)(c->entry))->i1, ((struct str_Addss *)(c->entry))->j1, ((struct str_Addss *)(c->entry))->diff1);
                  ((struct str_Addss *)(c->entry))->pp_init_a1 = ((struct str_Addss *)(c->entry))->a1;
               }
               break;
            case SIGID_Ssadd:
               if (((struct str_Ssadd *)(c->entry))->isStructure3) {
                  ((struct str_Ssadd *)(c->entry))->a3 = build_str_Signature(((struct str_Ssadd *)(c->entry))->structure3);
                  ((struct str_Ssadd *)(c->entry))->pp_init_a3 = ((struct str_Ssadd *)(c->entry))->a3;
               }
               else {
                  ((struct str_Ssadd *)(c->entry))->a3 = (*((struct str_Ssadd *)(c->entry))->f3)(((struct str_Ssadd *)(c->entry))->i3, ((struct str_Ssadd *)(c->entry))->j3, ((struct str_Ssadd *)(c->entry))->diff3);
                  ((struct str_Ssadd *)(c->entry))->pp_init_a3 = ((struct str_Ssadd *)(c->entry))->a3;
               }
               break;
            case SIGID_Nil:
               break;
            case SIGID_Combine:
               if (((struct str_Combine *)(c->entry))->isStructure1) {
                  ((struct str_Combine *)(c->entry))->a1 = build_str_Signature(((struct str_Combine *)(c->entry))->structure1);
                  ((struct str_Combine *)(c->entry))->pp_init_a1 = ((struct str_Combine *)(c->entry))->a1;
               }
               else {
                  ((struct str_Combine *)(c->entry))->a1 = (*((struct str_Combine *)(c->entry))->f1)(((struct str_Combine *)(c->entry))->i1, ((struct str_Combine *)(c->entry))->j1, ((struct str_Combine *)(c->entry))->diff1);
                  ((struct str_Combine *)(c->entry))->pp_init_a1 = ((struct str_Combine *)(c->entry))->a1;
               }
               if (((struct str_Combine *)(c->entry))->isStructure2) {
                  ((struct str_Combine *)(c->entry))->a2 = build_str_Signature(((struct str_Combine *)(c->entry))->structure2);
                  ((struct str_Combine *)(c->entry))->pp_init_a2 = ((struct str_Combine *)(c->entry))->a2;
               }
               else {
                  ((struct str_Combine *)(c->entry))->a2 = (*((struct str_Combine *)(c->entry))->f2)(((struct str_Combine *)(c->entry))->i2, ((struct str_Combine *)(c->entry))->j2, ((struct str_Combine *)(c->entry))->diff2);
                  ((struct str_Combine *)(c->entry))->pp_init_a2 = ((struct str_Combine *)(c->entry))->a2;
               }
               break;
         }
      }
   }
   return l;
}

/* update subopt difference values                                                  */
/* -------------------------------------------------------------------------------- */
static void update_str_Signature(struct str_Signature *c, int diff)
{
   if (c != NULL) {
      switch (c->utype) {
         case SIGID__NTID:
            if (((struct str__NTID *)(c->entry))->isStructure1) {
               update_str_Signature(((struct str__NTID *)(c->entry))->structure1->item, diff);
            }
            else {
               ((struct str__NTID *)(c->entry))->diff1 = diff;
            }
            break;
         case SIGID_Sadd:
            if (((struct str_Sadd *)(c->entry))->isStructure2) {
               update_str_Signature(((struct str_Sadd *)(c->entry))->structure2->item, diff);
            }
            else {
               ((struct str_Sadd *)(c->entry))->diff2 = diff;
            }
            break;
         case SIGID_Cadd:
            if (((struct str_Cadd *)(c->entry))->isStructure1) {
               update_str_Signature(((struct str_Cadd *)(c->entry))->structure1->item, diff);
            }
            else {
               ((struct str_Cadd *)(c->entry))->diff1 = diff;
            }
            if (((struct str_Cadd *)(c->entry))->isStructure2) {
               update_str_Signature(((struct str_Cadd *)(c->entry))->structure2->item, diff);
            }
            else {
               ((struct str_Cadd *)(c->entry))->diff2 = diff;
            }
            break;
         case SIGID_Is:
            if (((struct str_Is *)(c->entry))->isStructure2) {
               update_str_Signature(((struct str_Is *)(c->entry))->structure2->item, diff);
            }
            else {
               ((struct str_Is *)(c->entry))->diff2 = diff;
            }
            break;
         case SIGID_Sr:
            if (((struct str_Sr *)(c->entry))->isStructure2) {
               update_str_Signature(((struct str_Sr *)(c->entry))->structure2->item, diff);
            }
            else {
               ((struct str_Sr *)(c->entry))->diff2 = diff;
            }
            break;
         case SIGID_Hl:
            ((struct str_Hl *)(c->entry))->diff = diff;
            break;
         case SIGID_Bl:
            if (((struct str_Bl *)(c->entry))->isStructure5) {
               update_str_Signature(((struct str_Bl *)(c->entry))->structure5->item, diff);
            }
            else {
               ((struct str_Bl *)(c->entry))->diff5 = diff;
            }
            break;
         case SIGID_Br:
            if (((struct str_Br *)(c->entry))->isStructure3) {
               update_str_Signature(((struct str_Br *)(c->entry))->structure3->item, diff);
            }
            else {
               ((struct str_Br *)(c->entry))->diff3 = diff;
            }
            break;
         case SIGID_Il:
            if (((struct str_Il *)(c->entry))->isStructure5) {
               update_str_Signature(((struct str_Il *)(c->entry))->structure5->item, diff);
            }
            else {
               ((struct str_Il *)(c->entry))->diff5 = diff;
            }
            break;
         case SIGID_Ml:
            if (((struct str_Ml *)(c->entry))->isStructure3) {
               update_str_Signature(((struct str_Ml *)(c->entry))->structure3->item, diff);
            }
            else {
               ((struct str_Ml *)(c->entry))->diff3 = diff;
            }
            break;
         case SIGID_Mldl:
            if (((struct str_Mldl *)(c->entry))->isStructure4) {
               update_str_Signature(((struct str_Mldl *)(c->entry))->structure4->item, diff);
            }
            else {
               ((struct str_Mldl *)(c->entry))->diff4 = diff;
            }
            break;
         case SIGID_Mldr:
            if (((struct str_Mldr *)(c->entry))->isStructure3) {
               update_str_Signature(((struct str_Mldr *)(c->entry))->structure3->item, diff);
            }
            else {
               ((struct str_Mldr *)(c->entry))->diff3 = diff;
            }
            break;
         case SIGID_Mldlr:
            if (((struct str_Mldlr *)(c->entry))->isStructure4) {
               update_str_Signature(((struct str_Mldlr *)(c->entry))->structure4->item, diff);
            }
            else {
               ((struct str_Mldlr *)(c->entry))->diff4 = diff;
            }
            break;
         case SIGID_Cons:
            if (((struct str_Cons *)(c->entry))->isStructure1) {
               update_str_Signature(((struct str_Cons *)(c->entry))->structure1->item, diff);
            }
            else {
               ((struct str_Cons *)(c->entry))->diff1 = diff;
            }
            if (((struct str_Cons *)(c->entry))->isStructure2) {
               update_str_Signature(((struct str_Cons *)(c->entry))->structure2->item, diff);
            }
            else {
               ((struct str_Cons *)(c->entry))->diff2 = diff;
            }
            break;
         case SIGID_Ul:
            if (((struct str_Ul *)(c->entry))->isStructure1) {
               update_str_Signature(((struct str_Ul *)(c->entry))->structure1->item, diff);
            }
            else {
               ((struct str_Ul *)(c->entry))->diff1 = diff;
            }
            break;
         case SIGID_Addss:
            if (((struct str_Addss *)(c->entry))->isStructure1) {
               update_str_Signature(((struct str_Addss *)(c->entry))->structure1->item, diff);
            }
            else {
               ((struct str_Addss *)(c->entry))->diff1 = diff;
            }
            break;
         case SIGID_Ssadd:
            if (((struct str_Ssadd *)(c->entry))->isStructure3) {
               update_str_Signature(((struct str_Ssadd *)(c->entry))->structure3->item, diff);
            }
            else {
               ((struct str_Ssadd *)(c->entry))->diff3 = diff;
            }
            break;
         case SIGID_Nil:
            ((struct str_Nil *)(c->entry))->diff = diff;
            break;
         case SIGID_Combine:
            if (((struct str_Combine *)(c->entry))->isStructure1) {
               update_str_Signature(((struct str_Combine *)(c->entry))->structure1->item, diff);
            }
            else {
               ((struct str_Combine *)(c->entry))->diff1 = diff;
            }
            if (((struct str_Combine *)(c->entry))->isStructure2) {
               update_str_Signature(((struct str_Combine *)(c->entry))->structure2->item, diff);
            }
            else {
               ((struct str_Combine *)(c->entry))->diff2 = diff;
            }
            break;
      }
   }
}

/* table access                                                                     */
/* -------------------------------------------------------------------------------- */

#define tbl_struct(I, J) arr_struct[(I)]
#define tbl_initstem(I, J) arr_initstem[((J)*((J)+1))/2+(I)]
#define tbl_closed(I, J) arr_closed[((J)*((J)+1))/2+(I)]
#define tbl_ml_components(I, J) arr_ml_components[((J)*((J)+1))/2+(I)]
#define tbl_comps(I, J) arr_comps[((J)*((J)+1))/2+(I)]
#define tbl_block(I, J) arr_block[((J)*((J)+1))/2+(I)]

/* table declarations                                                               */
/* -------------------------------------------------------------------------------- */

static int *arr_struct;
static int *arr_initstem;
static int *arr_closed;
static int *arr_ml_components;
static int *arr_comps;
static int *arr_block;

/* table calculations                                                               */
/* -------------------------------------------------------------------------------- */

/* table calculation for production struct                                          */
/* -------------------------------------------------------------------------------- */
static void calc_struct(int i, int j)
{
   int v1, v2, v3, v4, v5, v6;
   int k;

   if ((j-i) >= 0) {
      /* -------------------------------- start of -------------------------------- */
      /* -------------------- v1 = sadd <<< lbase ~~~ p struct -------------------- */
      if ((j-i) >= 1) {
         v1 = tbl_struct(i+1, j);
      }
      else {
         v1 = 1.0e7;
      }
      /* -------------------- v1 = sadd <<< lbase ~~~ p struct -------------------- */
      /* -------------------------------- finished -------------------------------- */

      /* -------------------------------- start of -------------------------------- */
      /* ----------------- v3 = cadd <<< p initstem ~~~ p struct ------------------ */
      if ((j-i) >= 7) {
         v3 = 1.0e7;
         for (k=i+7; k<=j; k++) {
            v2 = tbl_initstem(i, k) + tbl_struct(k, j);
            v3 = v2 < v3 ? v2 : v3;
         }
      }
      else {
         v3 = 1.0e7;
      }
      /* ----------------- v3 = cadd <<< p initstem ~~~ p struct ------------------ */
      /* -------------------------------- finished -------------------------------- */

      /* -------------------------------- start of -------------------------------- */
      /* --------------------------- v4 = nil <<< empty --------------------------- */
      if ((j-i) == 0) {
         v4 = 0;
      }
      else {
         v4 = 1.0e7;
      }
      /* --------------------------- v4 = nil <<< empty --------------------------- */
      /* -------------------------------- finished -------------------------------- */

      v5 = v3 < v4 ? v3 : v4;
      v6 = v1 < v5 ? v1 : v5;
      /* ----------------------- assign table entry result ------------------------ */
      tbl_struct(i, j) = v6;
   }
}

/* table calculation for production initstem                                        */
/* -------------------------------------------------------------------------------- */
static void calc_initstem(int i, int j)
{
   int v1;

   if ((j-i) >= 7) {
      /* -------------------------------- start of -------------------------------- */
      /* ------------------ v1 = is <<< loc ~~~ p closed ~~~ loc ------------------ */
      v1 = tbl_closed(i, j) + termaupenalty((i) + 1, j);
      /* ------------------ v1 = is <<< loc ~~~ p closed ~~~ loc ------------------ */
      /* -------------------------------- finished -------------------------------- */

      /* ----------------------- assign table entry result ------------------------ */
      tbl_initstem(i, j) = v1;
   }
}

/* table calculation for production closed                                          */
/* -------------------------------------------------------------------------------- */
static void calc_closed(int i, int j)
{
   int v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11;
   int v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22;
   int k, k2, k3, k4;

   if ((j-i) >= 7) {
      if (basepairing(i, j)) {
         /* ------------------------------- start of ------------------------------ */
         /* --------------- v1 = sr <<< lbase ~~~ p closed ~~~ lbase -------------- */
         if ((j-i) >= 9) {
            v1 = tbl_closed(i+1, j-1) + sr_energy(i+1, j);
         }
         else {
            v1 = 1.0e7;
         }
         /* --------------- v1 = sr <<< lbase ~~~ p closed ~~~ lbase -------------- */
         /* ------------------------------- finished ------------------------------ */

         v2 = v1;
      }
      else {
         v2 = 1.0e7;
      }
      if (stackpairing(i, j)) {
         /* ------------------------------- start of ------------------------------ */
         /*  v3 = hl <<< lbase ~~~ lbase ~~~ (region `with` (minsize 3.0)) ~~~ lbase ~~~ lbase  */
         v3 = hl_energy(i+2, j-1) + sr_energy(i+1, j);
         /*  v3 = hl <<< lbase ~~~ lbase ~~~ (region `with` (minsize 3.0)) ~~~ lbase ~~~ lbase  */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /* 5 = bl <<< lbase ~~~ lbase ~~~ region ~~~ p initstem ~~~ lbase ~~~ lbas */
         if ((j-i) >= 12) {
            v5 = 1.0e7;
            for (k=i+3; k<=j-9; k++) {
               v4 = (tbl_initstem(k, j-2) + bl_energy(i+2, i+2, k, j-1)) + sr_energy(i+1, j);
               v5 = v4 < v5 ? v4 : v5;
            }
         }
         else {
            v5 = 1.0e7;
         }
         /* 5 = bl <<< lbase ~~~ lbase ~~~ region ~~~ p initstem ~~~ lbase ~~~ lbas */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /* 7 = br <<< lbase ~~~ lbase ~~~ p initstem ~~~ region ~~~ lbase ~~~ lbas */
         if ((j-i) >= 12) {
            v7 = 1.0e7;
            for (k2=i+9; k2<=j-3; k2++) {
               v6 = (tbl_initstem(i+2, k2) + br_energy(i+2, k2, j-2, j-1)) + sr_energy(i+1, j);
               v7 = v6 < v7 ? v6 : v7;
            }
         }
         else {
            v7 = 1.0e7;
         }
         /* 7 = br <<< lbase ~~~ lbase ~~~ p initstem ~~~ region ~~~ lbase ~~~ lbas */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /*  v9 = il <<< lbase ~~~ lbase ~~~ (region `with` (maxsize 30.0)) ~~~ p closed ~~~ (region `with` (maxsize 30.0)) ~~~ lbase ~~~ lbase  */
         if ((j-i) >= 13) {
            v9 = 1.0e7;
            for (k4=max(i+10, j-2-30); k4<=j-3; k4++) {
               for (k3=i+3; k3<=min(i+32, k4-7); k3++) {
                  v8 = (tbl_closed(k3, k4) + sr_energy(i+1, j)) + il_energy(i+2, k3, k4, j-2);
                  v9 = v8 < v9 ? v8 : v9;
               }
            }
         }
         else {
            v9 = 1.0e7;
         }
         /*  v9 = il <<< lbase ~~~ lbase ~~~ (region `with` (maxsize 30.0)) ~~~ p closed ~~~ (region `with` (maxsize 30.0)) ~~~ lbase ~~~ lbase  */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /*  v10 = mldl <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase  */
         if ((j-i) >= 19) {
            v10 = (((380 + tbl_ml_components(i+3, j-2)) + dli_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
         }
         else {
            v10 = 1.0e7;
         }
         /*  v10 = mldl <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase  */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /*  v11 = mldr <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
         if ((j-i) >= 19) {
            v11 = (((380 + tbl_ml_components(i+2, j-3)) + dri_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
         }
         else {
            v11 = 1.0e7;
         }
         /*  v11 = mldr <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /*  v12 = mldlr <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
         if ((j-i) >= 20) {
            v12 = ((((380 + tbl_ml_components(i+3, j-3)) + dli_energy(i+2, j-1)) + dri_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
         }
         else {
            v12 = 1.0e7;
         }
         /*  v12 = mldlr <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
         /* ------------------------------- finished ------------------------------ */

         /* ------------------------------- start of ------------------------------ */
         /* - v13 = ml <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase  */
         if ((j-i) >= 18) {
            v13 = ((380 + tbl_ml_components(i+2, j-2)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
         }
         else {
            v13 = 1.0e7;
         }
         /* - v13 = ml <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase  */
         /* ------------------------------- finished ------------------------------ */

         v14 = v12 < v13 ? v12 : v13;
         v15 = v11 < v14 ? v11 : v14;
         v16 = v10 < v15 ? v10 : v15;
         v17 = v9 < v16 ? v9 : v16;
         v18 = v7 < v17 ? v7 : v17;
         v19 = v5 < v18 ? v5 : v18;
         v20 = v3 < v19 ? v3 : v19;
         v21 = v20;
      }
      else {
         v21 = 1.0e7;
      }
      v22 = v2 < v21 ? v2 : v21;
      /* ----------------------- assign table entry result ------------------------ */
      tbl_closed(i, j) = v22;
   }
}

/* table calculation for production ml_components                                   */
/* -------------------------------------------------------------------------------- */
static void calc_ml_components(int i, int j)
{
   int v1, v2;
   int k;

   if ((j-i) >= 14) {
      /* -------------------------------- start of -------------------------------- */
      /* ------------------ v2 = combine <<< p block ~~~ p comps ------------------ */
      v2 = 1.0e7;
      for (k=i+7; k<=j-7; k++) {
         v1 = tbl_block(i, k) + tbl_comps(k, j);
         v2 = v1 < v2 ? v1 : v2;
      }
      /* ------------------ v2 = combine <<< p block ~~~ p comps ------------------ */
      /* -------------------------------- finished -------------------------------- */

      /* ----------------------- assign table entry result ------------------------ */
      tbl_ml_components(i, j) = v2;
   }
}

/* table calculation for production comps                                           */
/* -------------------------------------------------------------------------------- */
static void calc_comps(int i, int j)
{
   int v1, v2, v3, v4, v5, v6, v7;
   int k, k2;

   if ((j-i) >= 7) {
      /* -------------------------------- start of -------------------------------- */
      /* ------------------- v2 = cons <<< p block ~~~ p comps -------------------- */
      if ((j-i) >= 14) {
         v2 = 1.0e7;
         for (k=i+7; k<=j-7; k++) {
            v1 = tbl_block(i, k) + tbl_comps(k, j);
            v2 = v1 < v2 ? v1 : v2;
         }
      }
      else {
         v2 = 1.0e7;
      }
      /* ------------------- v2 = cons <<< p block ~~~ p comps -------------------- */
      /* -------------------------------- finished -------------------------------- */

      /* ------------------------------ v3 = p block ------------------------------ */
      v3 = tbl_block(i, j);
      /* -------------------------------- start of -------------------------------- */
      /* ------------------- v5 = addss <<< p block ~~~ region -------------------- */
      if ((j-i) >= 8) {
         v5 = 1.0e7;
         for (k2=i+7; k2<=j-1; k2++) {
            v4 = tbl_block(i, k2) + ss_energy(k2, j);
            v5 = v4 < v5 ? v4 : v5;
         }
      }
      else {
         v5 = 1.0e7;
      }
      /* ------------------- v5 = addss <<< p block ~~~ region -------------------- */
      /* -------------------------------- finished -------------------------------- */

      v6 = v3 < v5 ? v3 : v5;
      v7 = v2 < v6 ? v2 : v6;
      /* ----------------------- assign table entry result ------------------------ */
      tbl_comps(i, j) = v7;
   }
}

/* table calculation for production block                                           */
/* -------------------------------------------------------------------------------- */
static void calc_block(int i, int j)
{
   int v1, v2, v3, v4;
   int k;

   if ((j-i) >= 7) {
      /* -------------------------------- start of -------------------------------- */
      /* ------------------------- v1 = ul <<< p initstem ------------------------- */
      v1 = 40 + tbl_initstem(i, j);
      /* ------------------------- v1 = ul <<< p initstem ------------------------- */
      /* -------------------------------- finished -------------------------------- */

      /* -------------------------------- start of -------------------------------- */
      /* ------------------ v3 = ssadd <<< region ~~~ p initstem ------------------ */
      if ((j-i) >= 8) {
         v3 = 1.0e7;
         for (k=i+1; k<=j-7; k++) {
            v2 = (40 + tbl_initstem(k, j)) + ss_energy(i, k);
            v3 = v2 < v3 ? v2 : v3;
         }
      }
      else {
         v3 = 1.0e7;
      }
      /* ------------------ v3 = ssadd <<< region ~~~ p initstem ------------------ */
      /* -------------------------------- finished -------------------------------- */

      v4 = v1 < v3 ? v1 : v3;
      /* ----------------------- assign table entry result ------------------------ */
      tbl_block(i, j) = v4;
   }
}

/* forward declarations for backtracing functions                                   */
/* -------------------------------------------------------------------------------- */

static struct str1 *back_closed(int i, int j, int diff);

static struct str1 *back_ml_components(int i, int j, int diff);

static struct str1 *back_initstem(int i, int j, int diff);

static struct str1 *back_struct(int i, int j, int diff);

static struct str1 *back_block(int i, int j, int diff);

static struct str1 *back_comps(int i, int j, int diff);

/* backtracing code                                                                 */
/* -------------------------------------------------------------------------------- */

/* backtracing code for production struct                                           */
/* -------------------------------------------------------------------------------- */
static struct str1 *back_struct(int i, int j, int diff)
{
   struct str1 *v12;
   int v8;
   struct str3 *v1, *v2, *v3, *v4, *v5, *v6, *v7, *v9, *v10, *v11;
   int k;

   /* ---------------------------------- start of --------------------------------- */
   /* ---------------------- v1 = sadd <<< lbase ~~~ p struct --------------------- */
   if ((j-i) >= 1) {
      if (abs(tbl_struct(i, j) - tbl_struct(i+1, j)) <= diff) {
         v1=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v1->next = NULL;
         v1->last = v1;
         v1->item.alg_mfe = tbl_struct(i+1, j);
         v1->item.alg_enum = new_Sadd_f(i+1, back_struct, i+1, j);
      }
      else {
         v1 = NULL;
      }
   }
   else {
      v1 = NULL;
   }
   /* ---------------------- v1 = sadd <<< lbase ~~~ p struct --------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ---------------------------------- start of --------------------------------- */
   /* ------------------- v3 = cadd <<< p initstem ~~~ p struct ------------------- */
   if ((j-i) >= 7) {
      v3 = NULL;
      for (k=i+7; k<=j; k++) {
         if (abs(tbl_struct(i, j) - (tbl_initstem(i, k) + tbl_struct(k, j))) <= diff) {
            v2=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v2->next = NULL;
            v2->last = v2;
            v2->item.alg_mfe = tbl_initstem(i, k) + tbl_struct(k, j);
            v2->item.alg_enum = new_Cadd_ff(back_initstem, i, k, back_struct, k, j);
         }
         else {
            v2 = NULL;
         }
         /* ---------------------------- v3 = v2 ++ v3 ---------------------------- */
         if (v2 == NULL) {
         } else
         if (v3 == NULL) {
            v3 = v2;
         }
         else {
            v2->last->next = v3;
            v2->last = v3->last;
            v3 = v2;
         }
      }
   }
   else {
      v3 = NULL;
   }
   /* ------------------- v3 = cadd <<< p initstem ~~~ p struct ------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ---------------------------------- start of --------------------------------- */
   /* ----------------------------- v4 = nil <<< empty ---------------------------- */
   if ((j-i) == 0) {
      if (abs(tbl_struct(i, j) - 0) <= diff) {
         v4=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v4->next = NULL;
         v4->last = v4;
         v4->item.alg_mfe = 0;
         v4->item.alg_enum = new_Nil_(i);
      }
      else {
         v4 = NULL;
      }
   }
   else {
      v4 = NULL;
   }
   /* ----------------------------- v4 = nil <<< empty ---------------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ------------------------------- v5 = v3 ++ v4 ------------------------------- */
   if (v3 == NULL) {
      v5 = v4;
   } else
   if (v4 == NULL) {
      v5 = v3;
   }
   else {
      v3->last->next = v4;
      v3->last = v4->last;
      v5 = v3;
   }
   /* ------------------------------- v6 = v1 ++ v5 ------------------------------- */
   if (v1 == NULL) {
      v6 = v5;
   } else
   if (v5 == NULL) {
      v6 = v1;
   }
   else {
      v1->last->next = v5;
      v1->last = v5->last;
      v6 = v1;
   }
   /* ------------------------------ v8 = minimum(v6) ----------------------------- */
   v8 = 1.0e7;
   v7 = v6;
   while (v7 != NULL) {
      v8 = v8 < v7->item.alg_mfe ? v8 : v7->item.alg_mfe;
      v7 = v7->next;
   }
   v7 = v6;
   v10 = NULL;
   while (v7 != NULL) {
      if (abs(v8 - v7->item.alg_mfe) <= diff) {
         update_str_Signature(v7->item.alg_enum->item, diff - abs(v8 - v7->item.alg_mfe));
         v9=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v9->item = v7->item;
         v9->next = NULL;
         v9->last = v9;
         /* --------------------------- v10 = v9 ++ v10 --------------------------- */
         if (v9 == NULL) {
         } else
         if (v10 == NULL) {
            v10 = v9;
         }
         else {
            v9->last->next = v10;
            v9->last = v10->last;
            v10 = v9;
         }
      }
      v7 = v7->next;
   }
   /* ------------------------- build candidate structures ------------------------ */
   v11 = v10;
   v12 = NULL;
   while (v11 != NULL) {
      /* -------------------- v12 = v11->item.alg_enum ++ v12 --------------------- */
      if (v11->item.alg_enum == NULL) {
      } else
      if (v12 == NULL) {
         v12 = v11->item.alg_enum;
      }
      else {
         v11->item.alg_enum->last->next = v12;
         v11->item.alg_enum->last = v12->last;
         v12 = v11->item.alg_enum;
      }
      v11 = v11->next;
   }
   memory_clear(adp_dynmem);
   return build_str_Signature(copy_str_Signature(v12));
}

/* backtracing code for production initstem                                         */
/* -------------------------------------------------------------------------------- */
static struct str1 *back_initstem(int i, int j, int diff)
{
   struct str1 *v7;
   int v3;
   struct str3 *v1, *v2, *v4, *v5, *v6;

   /* ---------------------------------- start of --------------------------------- */
   /* -------------------- v1 = is <<< loc ~~~ p closed ~~~ loc ------------------- */
   if ((j-i) >= 7) {
      if (abs(tbl_initstem(i, j) - (tbl_closed(i, j) + termaupenalty((i) + 1, j))) <= diff) {
         v1=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v1->next = NULL;
         v1->last = v1;
         v1->item.alg_mfe = tbl_closed(i, j) + termaupenalty((i) + 1, j);
         v1->item.alg_enum = new_Is_f(i, back_closed, i, j, j);
      }
      else {
         v1 = NULL;
      }
   }
   else {
      v1 = NULL;
   }
   /* -------------------- v1 = is <<< loc ~~~ p closed ~~~ loc ------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ------------------------------ v3 = minimum(v1) ----------------------------- */
   v3 = 1.0e7;
   v2 = v1;
   while (v2 != NULL) {
      v3 = v3 < v2->item.alg_mfe ? v3 : v2->item.alg_mfe;
      v2 = v2->next;
   }
   v2 = v1;
   v5 = NULL;
   while (v2 != NULL) {
      if (abs(v3 - v2->item.alg_mfe) <= diff) {
         update_str_Signature(v2->item.alg_enum->item, diff - abs(v3 - v2->item.alg_mfe));
         v4=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v4->item = v2->item;
         v4->next = NULL;
         v4->last = v4;
         /* ---------------------------- v5 = v4 ++ v5 ---------------------------- */
         if (v4 == NULL) {
         } else
         if (v5 == NULL) {
            v5 = v4;
         }
         else {
            v4->last->next = v5;
            v4->last = v5->last;
            v5 = v4;
         }
      }
      v2 = v2->next;
   }
   /* ------------------------- build candidate structures ------------------------ */
   v6 = v5;
   v7 = NULL;
   while (v6 != NULL) {
      /* ---------------------- v7 = v6->item.alg_enum ++ v7 ---------------------- */
      if (v6->item.alg_enum == NULL) {
      } else
      if (v7 == NULL) {
         v7 = v6->item.alg_enum;
      }
      else {
         v6->item.alg_enum->last->next = v7;
         v6->item.alg_enum->last = v7->last;
         v7 = v6->item.alg_enum;
      }
      v6 = v6->next;
   }
   memory_clear(adp_dynmem);
   return build_str_Signature(copy_str_Signature(v7));
}

/* backtracing code for production closed                                           */
/* -------------------------------------------------------------------------------- */
static struct str1 *back_closed(int i, int j, int diff)
{
   struct str1 *v52;
   int v4, v9, v15, v21, v27, v38, v48;
   struct str3 *v1, *v2, *v3, *v5, *v6, *v7, *v8, *v10, *v11, *v12, *v13;
   struct str3 *v14, *v16, *v17, *v18, *v19, *v20, *v22, *v23, *v24, *v25, *v26;
   struct str3 *v28, *v29, *v30, *v31, *v32, *v33, *v34, *v35, *v36, *v37, *v39;
   struct str3 *v40, *v41, *v42, *v43, *v44, *v45, *v46, *v47, *v49, *v50, *v51;
   int k, k2, k3, k4;

   if (basepairing(i, j)) {
      /* -------------------------------- start of -------------------------------- */
      /* ---------------- v1 = sr <<< lbase ~~~ p closed ~~~ lbase ---------------- */
      if ((j-i) >= 9) {
         if (abs(tbl_closed(i, j) - (tbl_closed(i+1, j-1) + sr_energy(i+1, j))) <= diff) {
            v1=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v1->next = NULL;
            v1->last = v1;
            v1->item.alg_mfe = tbl_closed(i+1, j-1) + sr_energy(i+1, j);
            v1->item.alg_enum = new_Sr_f(i+1, back_closed, i+1, j-1, j);
         }
         else {
            v1 = NULL;
         }
      }
      else {
         v1 = NULL;
      }
      /* ---------------- v1 = sr <<< lbase ~~~ p closed ~~~ lbase ---------------- */
      /* -------------------------------- finished -------------------------------- */

      v2 = v1;
   }
   else {
      v2 = NULL;
   }
   /* ------------------------------ v4 = minimum(v2) ----------------------------- */
   v4 = 1.0e7;
   v3 = v2;
   while (v3 != NULL) {
      v4 = v4 < v3->item.alg_mfe ? v4 : v3->item.alg_mfe;
      v3 = v3->next;
   }
   v3 = v2;
   v6 = NULL;
   while (v3 != NULL) {
      if (abs(v4 - v3->item.alg_mfe) <= diff) {
         update_str_Signature(v3->item.alg_enum->item, diff - abs(v4 - v3->item.alg_mfe));
         v5=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v5->item = v3->item;
         v5->next = NULL;
         v5->last = v5;
         /* ---------------------------- v6 = v5 ++ v6 ---------------------------- */
         if (v5 == NULL) {
         } else
         if (v6 == NULL) {
            v6 = v5;
         }
         else {
            v5->last->next = v6;
            v5->last = v6->last;
            v6 = v5;
         }
      }
      v3 = v3->next;
   }
   if (stackpairing(i, j)) {
      /* -------------------------------- start of -------------------------------- */
      /*  v7 = hl <<< lbase ~~~ lbase ~~~ (region `with` (minsize 3.0)) ~~~ lbase ~~~ lbase  */
      if ((j-i) >= 7) {
         if (abs(tbl_closed(i, j) - (hl_energy(i+2, j-1) + sr_energy(i+1, j))) <= diff) {
            v7=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v7->next = NULL;
            v7->last = v7;
            v7->item.alg_mfe = hl_energy(i+2, j-1) + sr_energy(i+1, j);
            v7->item.alg_enum = new_Hl_(i+1, i+2, i+2, j-2, j-1, j);
         }
         else {
            v7 = NULL;
         }
      }
      else {
         v7 = NULL;
      }
      /*  v7 = hl <<< lbase ~~~ lbase ~~~ (region `with` (minsize 3.0)) ~~~ lbase ~~~ lbase  */
      /* -------------------------------- finished -------------------------------- */

      /* ---------------------------- v9 = minimum(v7) ---------------------------- */
      v9 = 1.0e7;
      v8 = v7;
      while (v8 != NULL) {
         v9 = v9 < v8->item.alg_mfe ? v9 : v8->item.alg_mfe;
         v8 = v8->next;
      }
      v8 = v7;
      v11 = NULL;
      while (v8 != NULL) {
         if (abs(v9 - v8->item.alg_mfe) <= diff) {
            update_str_Signature(v8->item.alg_enum->item, diff - abs(v9 - v8->item.alg_mfe));
            v10=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v10->item = v8->item;
            v10->next = NULL;
            v10->last = v10;
            /* ------------------------- v11 = v10 ++ v11 ------------------------- */
            if (v10 == NULL) {
            } else
            if (v11 == NULL) {
               v11 = v10;
            }
            else {
               v10->last->next = v11;
               v10->last = v11->last;
               v11 = v10;
            }
         }
         v8 = v8->next;
      }
      /* -------------------------------- start of -------------------------------- */
      /* v13 = bl <<< lbase ~~~ lbase ~~~ region ~~~ p initstem ~~~ lbase ~~~ lbase */
      if ((j-i) >= 12) {
         v13 = NULL;
         for (k=i+3; k<=j-9; k++) {
            if (abs(tbl_closed(i, j) - ((tbl_initstem(k, j-2) + bl_energy(i+2, i+2, k, j-1)) + sr_energy(i+1, j))) <= diff) {
               v12=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
               v12->next = NULL;
               v12->last = v12;
               v12->item.alg_mfe = (tbl_initstem(k, j-2) + bl_energy(i+2, i+2, k, j-1)) + sr_energy(i+1, j);
               v12->item.alg_enum = new_Bl_f(i+1, i+2, i+2, k, back_initstem, k, j-2, j-1, j);
            }
            else {
               v12 = NULL;
            }
            /* ------------------------- v13 = v12 ++ v13 ------------------------- */
            if (v12 == NULL) {
            } else
            if (v13 == NULL) {
               v13 = v12;
            }
            else {
               v12->last->next = v13;
               v12->last = v13->last;
               v13 = v12;
            }
         }
      }
      else {
         v13 = NULL;
      }
      /* v13 = bl <<< lbase ~~~ lbase ~~~ region ~~~ p initstem ~~~ lbase ~~~ lbase */
      /* -------------------------------- finished -------------------------------- */

      /* --------------------------- v15 = minimum(v13) --------------------------- */
      v15 = 1.0e7;
      v14 = v13;
      while (v14 != NULL) {
         v15 = v15 < v14->item.alg_mfe ? v15 : v14->item.alg_mfe;
         v14 = v14->next;
      }
      v14 = v13;
      v17 = NULL;
      while (v14 != NULL) {
         if (abs(v15 - v14->item.alg_mfe) <= diff) {
            update_str_Signature(v14->item.alg_enum->item, diff - abs(v15 - v14->item.alg_mfe));
            v16=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v16->item = v14->item;
            v16->next = NULL;
            v16->last = v16;
            /* ------------------------- v17 = v16 ++ v17 ------------------------- */
            if (v16 == NULL) {
            } else
            if (v17 == NULL) {
               v17 = v16;
            }
            else {
               v16->last->next = v17;
               v16->last = v17->last;
               v17 = v16;
            }
         }
         v14 = v14->next;
      }
      /* -------------------------------- start of -------------------------------- */
      /* v19 = br <<< lbase ~~~ lbase ~~~ p initstem ~~~ region ~~~ lbase ~~~ lbase */
      if ((j-i) >= 12) {
         v19 = NULL;
         for (k2=i+9; k2<=j-3; k2++) {
            if (abs(tbl_closed(i, j) - ((tbl_initstem(i+2, k2) + br_energy(i+2, k2, j-2, j-1)) + sr_energy(i+1, j))) <= diff) {
               v18=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
               v18->next = NULL;
               v18->last = v18;
               v18->item.alg_mfe = (tbl_initstem(i+2, k2) + br_energy(i+2, k2, j-2, j-1)) + sr_energy(i+1, j);
               v18->item.alg_enum = new_Br_f(i+1, i+2, back_initstem, i+2, k2, k2, j-2, j-1, j);
            }
            else {
               v18 = NULL;
            }
            /* ------------------------- v19 = v18 ++ v19 ------------------------- */
            if (v18 == NULL) {
            } else
            if (v19 == NULL) {
               v19 = v18;
            }
            else {
               v18->last->next = v19;
               v18->last = v19->last;
               v19 = v18;
            }
         }
      }
      else {
         v19 = NULL;
      }
      /* v19 = br <<< lbase ~~~ lbase ~~~ p initstem ~~~ region ~~~ lbase ~~~ lbase */
      /* -------------------------------- finished -------------------------------- */

      /* --------------------------- v21 = minimum(v19) --------------------------- */
      v21 = 1.0e7;
      v20 = v19;
      while (v20 != NULL) {
         v21 = v21 < v20->item.alg_mfe ? v21 : v20->item.alg_mfe;
         v20 = v20->next;
      }
      v20 = v19;
      v23 = NULL;
      while (v20 != NULL) {
         if (abs(v21 - v20->item.alg_mfe) <= diff) {
            update_str_Signature(v20->item.alg_enum->item, diff - abs(v21 - v20->item.alg_mfe));
            v22=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v22->item = v20->item;
            v22->next = NULL;
            v22->last = v22;
            /* ------------------------- v23 = v22 ++ v23 ------------------------- */
            if (v22 == NULL) {
            } else
            if (v23 == NULL) {
               v23 = v22;
            }
            else {
               v22->last->next = v23;
               v22->last = v23->last;
               v23 = v22;
            }
         }
         v20 = v20->next;
      }
      /* -------------------------------- start of -------------------------------- */
      /*  v25 = il <<< lbase ~~~ lbase ~~~ (region `with` (maxsize 30.0)) ~~~ p closed ~~~ (region `with` (maxsize 30.0)) ~~~ lbase ~~~ lbase  */
      if ((j-i) >= 13) {
         v25 = NULL;
         for (k4=max(i+10, j-2-30); k4<=j-3; k4++) {
            for (k3=i+3; k3<=min(i+32, k4-7); k3++) {
               if (abs(tbl_closed(i, j) - ((tbl_closed(k3, k4) + sr_energy(i+1, j)) + il_energy(i+2, k3, k4, j-2))) <= diff) {
                  v24=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
                  v24->next = NULL;
                  v24->last = v24;
                  v24->item.alg_mfe = (tbl_closed(k3, k4) + sr_energy(i+1, j)) + il_energy(i+2, k3, k4, j-2);
                  v24->item.alg_enum = new_Il_f(i+1, i+2, i+2, k3, back_closed, k3, k4, k4, j-2, j-1, j);
               }
               else {
                  v24 = NULL;
               }
               /* ------------------------ v25 = v24 ++ v25 ----------------------- */
               if (v24 == NULL) {
               } else
               if (v25 == NULL) {
                  v25 = v24;
               }
               else {
                  v24->last->next = v25;
                  v24->last = v25->last;
                  v25 = v24;
               }
            }
         }
      }
      else {
         v25 = NULL;
      }
      /*  v25 = il <<< lbase ~~~ lbase ~~~ (region `with` (maxsize 30.0)) ~~~ p closed ~~~ (region `with` (maxsize 30.0)) ~~~ lbase ~~~ lbase  */
      /* -------------------------------- finished -------------------------------- */

      /* --------------------------- v27 = minimum(v25) --------------------------- */
      v27 = 1.0e7;
      v26 = v25;
      while (v26 != NULL) {
         v27 = v27 < v26->item.alg_mfe ? v27 : v26->item.alg_mfe;
         v26 = v26->next;
      }
      v26 = v25;
      v29 = NULL;
      while (v26 != NULL) {
         if (abs(v27 - v26->item.alg_mfe) <= diff) {
            update_str_Signature(v26->item.alg_enum->item, diff - abs(v27 - v26->item.alg_mfe));
            v28=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v28->item = v26->item;
            v28->next = NULL;
            v28->last = v28;
            /* ------------------------- v29 = v28 ++ v29 ------------------------- */
            if (v28 == NULL) {
            } else
            if (v29 == NULL) {
               v29 = v28;
            }
            else {
               v28->last->next = v29;
               v28->last = v29->last;
               v29 = v28;
            }
         }
         v26 = v26->next;
      }
      /* -------------------------------- start of -------------------------------- */
      /*  v30 = mldl <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase  */
      if ((j-i) >= 19) {
         if (abs(tbl_closed(i, j) - ((((380 + tbl_ml_components(i+3, j-2)) + dli_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1))) <= diff) {
            v30=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v30->next = NULL;
            v30->last = v30;
            v30->item.alg_mfe = (((380 + tbl_ml_components(i+3, j-2)) + dli_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
            v30->item.alg_enum = new_Mldl_f(i+1, i+2, i+3, back_ml_components, i+3, j-2, j-1, j);
         }
         else {
            v30 = NULL;
         }
      }
      else {
         v30 = NULL;
      }
      /*  v30 = mldl <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase  */
      /* -------------------------------- finished -------------------------------- */

      /* -------------------------------- start of -------------------------------- */
      /*  v31 = mldr <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
      if ((j-i) >= 19) {
         if (abs(tbl_closed(i, j) - ((((380 + tbl_ml_components(i+2, j-3)) + dri_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1))) <= diff) {
            v31=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v31->next = NULL;
            v31->last = v31;
            v31->item.alg_mfe = (((380 + tbl_ml_components(i+2, j-3)) + dri_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
            v31->item.alg_enum = new_Mldr_f(i+1, i+2, back_ml_components, i+2, j-3, j-2, j-1, j);
         }
         else {
            v31 = NULL;
         }
      }
      else {
         v31 = NULL;
      }
      /*  v31 = mldr <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
      /* -------------------------------- finished -------------------------------- */

      /* -------------------------------- start of -------------------------------- */
      /*  v32 = mldlr <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
      if ((j-i) >= 20) {
         if (abs(tbl_closed(i, j) - (((((380 + tbl_ml_components(i+3, j-3)) + dli_energy(i+2, j-1)) + dri_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1))) <= diff) {
            v32=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v32->next = NULL;
            v32->last = v32;
            v32->item.alg_mfe = ((((380 + tbl_ml_components(i+3, j-3)) + dli_energy(i+2, j-1)) + dri_energy(i+2, j-1)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
            v32->item.alg_enum = new_Mldlr_f(i+1, i+2, i+3, back_ml_components, i+3, j-3, j-2, j-1, j);
         }
         else {
            v32 = NULL;
         }
      }
      else {
         v32 = NULL;
      }
      /*  v32 = mldlr <<< lbase ~~~ lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase ~~~ lbase  */
      /* -------------------------------- finished -------------------------------- */

      /* -------------------------------- start of -------------------------------- */
      /* -- v33 = ml <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase -- */
      if ((j-i) >= 18) {
         if (abs(tbl_closed(i, j) - (((380 + tbl_ml_components(i+2, j-2)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1))) <= diff) {
            v33=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v33->next = NULL;
            v33->last = v33;
            v33->item.alg_mfe = ((380 + tbl_ml_components(i+2, j-2)) + sr_energy(i+1, j)) + termaupenalty(i+2, j-1);
            v33->item.alg_enum = new_Ml_f(i+1, i+2, back_ml_components, i+2, j-2, j-1, j);
         }
         else {
            v33 = NULL;
         }
      }
      else {
         v33 = NULL;
      }
      /* -- v33 = ml <<< lbase ~~~ lbase ~~~ p ml_components ~~~ lbase ~~~ lbase -- */
      /* -------------------------------- finished -------------------------------- */

      /* ---------------------------- v34 = v32 ++ v33 ---------------------------- */
      if (v32 == NULL) {
         v34 = v33;
      } else
      if (v33 == NULL) {
         v34 = v32;
      }
      else {
         v32->last->next = v33;
         v32->last = v33->last;
         v34 = v32;
      }
      /* ---------------------------- v35 = v31 ++ v34 ---------------------------- */
      if (v31 == NULL) {
         v35 = v34;
      } else
      if (v34 == NULL) {
         v35 = v31;
      }
      else {
         v31->last->next = v34;
         v31->last = v34->last;
         v35 = v31;
      }
      /* ---------------------------- v36 = v30 ++ v35 ---------------------------- */
      if (v30 == NULL) {
         v36 = v35;
      } else
      if (v35 == NULL) {
         v36 = v30;
      }
      else {
         v30->last->next = v35;
         v30->last = v35->last;
         v36 = v30;
      }
      /* --------------------------- v38 = minimum(v36) --------------------------- */
      v38 = 1.0e7;
      v37 = v36;
      while (v37 != NULL) {
         v38 = v38 < v37->item.alg_mfe ? v38 : v37->item.alg_mfe;
         v37 = v37->next;
      }
      v37 = v36;
      v40 = NULL;
      while (v37 != NULL) {
         if (abs(v38 - v37->item.alg_mfe) <= diff) {
            update_str_Signature(v37->item.alg_enum->item, diff - abs(v38 - v37->item.alg_mfe));
            v39=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v39->item = v37->item;
            v39->next = NULL;
            v39->last = v39;
            /* ------------------------- v40 = v39 ++ v40 ------------------------- */
            if (v39 == NULL) {
            } else
            if (v40 == NULL) {
               v40 = v39;
            }
            else {
               v39->last->next = v40;
               v39->last = v40->last;
               v40 = v39;
            }
         }
         v37 = v37->next;
      }
      /* ---------------------------- v41 = v29 ++ v40 ---------------------------- */
      if (v29 == NULL) {
         v41 = v40;
      } else
      if (v40 == NULL) {
         v41 = v29;
      }
      else {
         v29->last->next = v40;
         v29->last = v40->last;
         v41 = v29;
      }
      /* ---------------------------- v42 = v23 ++ v41 ---------------------------- */
      if (v23 == NULL) {
         v42 = v41;
      } else
      if (v41 == NULL) {
         v42 = v23;
      }
      else {
         v23->last->next = v41;
         v23->last = v41->last;
         v42 = v23;
      }
      /* ---------------------------- v43 = v17 ++ v42 ---------------------------- */
      if (v17 == NULL) {
         v43 = v42;
      } else
      if (v42 == NULL) {
         v43 = v17;
      }
      else {
         v17->last->next = v42;
         v17->last = v42->last;
         v43 = v17;
      }
      /* ---------------------------- v44 = v11 ++ v43 ---------------------------- */
      if (v11 == NULL) {
         v44 = v43;
      } else
      if (v43 == NULL) {
         v44 = v11;
      }
      else {
         v11->last->next = v43;
         v11->last = v43->last;
         v44 = v11;
      }
      v45 = v44;
   }
   else {
      v45 = NULL;
   }
   /* ------------------------------ v46 = v6 ++ v45 ------------------------------ */
   if (v6 == NULL) {
      v46 = v45;
   } else
   if (v45 == NULL) {
      v46 = v6;
   }
   else {
      v6->last->next = v45;
      v6->last = v45->last;
      v46 = v6;
   }
   /* ----------------------------- v48 = minimum(v46) ---------------------------- */
   v48 = 1.0e7;
   v47 = v46;
   while (v47 != NULL) {
      v48 = v48 < v47->item.alg_mfe ? v48 : v47->item.alg_mfe;
      v47 = v47->next;
   }
   v47 = v46;
   v50 = NULL;
   while (v47 != NULL) {
      if (abs(v48 - v47->item.alg_mfe) <= diff) {
         update_str_Signature(v47->item.alg_enum->item, diff - abs(v48 - v47->item.alg_mfe));
         v49=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v49->item = v47->item;
         v49->next = NULL;
         v49->last = v49;
         /* --------------------------- v50 = v49 ++ v50 -------------------------- */
         if (v49 == NULL) {
         } else
         if (v50 == NULL) {
            v50 = v49;
         }
         else {
            v49->last->next = v50;
            v49->last = v50->last;
            v50 = v49;
         }
      }
      v47 = v47->next;
   }
   /* ------------------------- build candidate structures ------------------------ */
   v51 = v50;
   v52 = NULL;
   while (v51 != NULL) {
      /* -------------------- v52 = v51->item.alg_enum ++ v52 --------------------- */
      if (v51->item.alg_enum == NULL) {
      } else
      if (v52 == NULL) {
         v52 = v51->item.alg_enum;
      }
      else {
         v51->item.alg_enum->last->next = v52;
         v51->item.alg_enum->last = v52->last;
         v52 = v51->item.alg_enum;
      }
      v51 = v51->next;
   }
   memory_clear(adp_dynmem);
   return build_str_Signature(copy_str_Signature(v52));
}

/* backtracing code for production ml_components                                    */
/* -------------------------------------------------------------------------------- */
static struct str1 *back_ml_components(int i, int j, int diff)
{
   struct str1 *v8;
   int v4;
   struct str3 *v1, *v2, *v3, *v5, *v6, *v7;
   int k;

   /* ---------------------------------- start of --------------------------------- */
   /* -------------------- v2 = combine <<< p block ~~~ p comps ------------------- */
   if ((j-i) >= 14) {
      v2 = NULL;
      for (k=i+7; k<=j-7; k++) {
         if (abs(tbl_ml_components(i, j) - (tbl_block(i, k) + tbl_comps(k, j))) <= diff) {
            v1=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v1->next = NULL;
            v1->last = v1;
            v1->item.alg_mfe = tbl_block(i, k) + tbl_comps(k, j);
            v1->item.alg_enum = new_Combine_ff(back_block, i, k, back_comps, k, j);
         }
         else {
            v1 = NULL;
         }
         /* ---------------------------- v2 = v1 ++ v2 ---------------------------- */
         if (v1 == NULL) {
         } else
         if (v2 == NULL) {
            v2 = v1;
         }
         else {
            v1->last->next = v2;
            v1->last = v2->last;
            v2 = v1;
         }
      }
   }
   else {
      v2 = NULL;
   }
   /* -------------------- v2 = combine <<< p block ~~~ p comps ------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ------------------------------ v4 = minimum(v2) ----------------------------- */
   v4 = 1.0e7;
   v3 = v2;
   while (v3 != NULL) {
      v4 = v4 < v3->item.alg_mfe ? v4 : v3->item.alg_mfe;
      v3 = v3->next;
   }
   v3 = v2;
   v6 = NULL;
   while (v3 != NULL) {
      if (abs(v4 - v3->item.alg_mfe) <= diff) {
         update_str_Signature(v3->item.alg_enum->item, diff - abs(v4 - v3->item.alg_mfe));
         v5=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v5->item = v3->item;
         v5->next = NULL;
         v5->last = v5;
         /* ---------------------------- v6 = v5 ++ v6 ---------------------------- */
         if (v5 == NULL) {
         } else
         if (v6 == NULL) {
            v6 = v5;
         }
         else {
            v5->last->next = v6;
            v5->last = v6->last;
            v6 = v5;
         }
      }
      v3 = v3->next;
   }
   /* ------------------------- build candidate structures ------------------------ */
   v7 = v6;
   v8 = NULL;
   while (v7 != NULL) {
      /* ---------------------- v8 = v7->item.alg_enum ++ v8 ---------------------- */
      if (v7->item.alg_enum == NULL) {
      } else
      if (v8 == NULL) {
         v8 = v7->item.alg_enum;
      }
      else {
         v7->item.alg_enum->last->next = v8;
         v7->item.alg_enum->last = v8->last;
         v8 = v7->item.alg_enum;
      }
      v7 = v7->next;
   }
   memory_clear(adp_dynmem);
   return build_str_Signature(copy_str_Signature(v8));
}

/* backtracing code for production comps                                            */
/* -------------------------------------------------------------------------------- */
static struct str1 *back_comps(int i, int j, int diff)
{
   struct str1 *v13;
   int v9;
   struct str3 *v1, *v2, *v3, *v4, *v5, *v6, *v7, *v8, *v10, *v11, *v12;
   int k, k2;

   /* ---------------------------------- start of --------------------------------- */
   /* --------------------- v2 = cons <<< p block ~~~ p comps --------------------- */
   if ((j-i) >= 14) {
      v2 = NULL;
      for (k=i+7; k<=j-7; k++) {
         if (abs(tbl_comps(i, j) - (tbl_block(i, k) + tbl_comps(k, j))) <= diff) {
            v1=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v1->next = NULL;
            v1->last = v1;
            v1->item.alg_mfe = tbl_block(i, k) + tbl_comps(k, j);
            v1->item.alg_enum = new_Cons_ff(back_block, i, k, back_comps, k, j);
         }
         else {
            v1 = NULL;
         }
         /* ---------------------------- v2 = v1 ++ v2 ---------------------------- */
         if (v1 == NULL) {
         } else
         if (v2 == NULL) {
            v2 = v1;
         }
         else {
            v1->last->next = v2;
            v1->last = v2->last;
            v2 = v1;
         }
      }
   }
   else {
      v2 = NULL;
   }
   /* --------------------- v2 = cons <<< p block ~~~ p comps --------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* -------------------------------- v3 = p block ------------------------------- */
   /* +---------------------------------------------------------------------------- */
   /* Nonterminal block is implemented as a tabulated                               */
   /* function which yields atomar results. Since we are in list context,           */
   /* we need to wrap the result of block into a single list element.               */
   /* +---------------------------------------------------------------------------- */
   if ((j-i) >= 7) {
      v3=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
      v3->item.alg_mfe = tbl_block(i, j);
      v3->item.alg_enum = new__NTID(back_block, i, j);
      v3->next = NULL;
      v3->last = v3;
   }
   else {
      v3 = NULL;
   }
   /* ---------------------------------- start of --------------------------------- */
   /* --------------------- v5 = addss <<< p block ~~~ region --------------------- */
   if ((j-i) >= 8) {
      v5 = NULL;
      for (k2=i+7; k2<=j-1; k2++) {
         if (abs(tbl_comps(i, j) - (tbl_block(i, k2) + ss_energy(k2, j))) <= diff) {
            v4=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v4->next = NULL;
            v4->last = v4;
            v4->item.alg_mfe = tbl_block(i, k2) + ss_energy(k2, j);
            v4->item.alg_enum = new_Addss_f(back_block, i, k2, k2, j);
         }
         else {
            v4 = NULL;
         }
         /* ---------------------------- v5 = v4 ++ v5 ---------------------------- */
         if (v4 == NULL) {
         } else
         if (v5 == NULL) {
            v5 = v4;
         }
         else {
            v4->last->next = v5;
            v4->last = v5->last;
            v5 = v4;
         }
      }
   }
   else {
      v5 = NULL;
   }
   /* --------------------- v5 = addss <<< p block ~~~ region --------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ------------------------------- v6 = v3 ++ v5 ------------------------------- */
   if (v3 == NULL) {
      v6 = v5;
   } else
   if (v5 == NULL) {
      v6 = v3;
   }
   else {
      v3->last->next = v5;
      v3->last = v5->last;
      v6 = v3;
   }
   /* ------------------------------- v7 = v2 ++ v6 ------------------------------- */
   if (v2 == NULL) {
      v7 = v6;
   } else
   if (v6 == NULL) {
      v7 = v2;
   }
   else {
      v2->last->next = v6;
      v2->last = v6->last;
      v7 = v2;
   }
   /* ------------------------------ v9 = minimum(v7) ----------------------------- */
   v9 = 1.0e7;
   v8 = v7;
   while (v8 != NULL) {
      v9 = v9 < v8->item.alg_mfe ? v9 : v8->item.alg_mfe;
      v8 = v8->next;
   }
   v8 = v7;
   v11 = NULL;
   while (v8 != NULL) {
      if (abs(v9 - v8->item.alg_mfe) <= diff) {
         update_str_Signature(v8->item.alg_enum->item, diff - abs(v9 - v8->item.alg_mfe));
         v10=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v10->item = v8->item;
         v10->next = NULL;
         v10->last = v10;
         /* --------------------------- v11 = v10 ++ v11 -------------------------- */
         if (v10 == NULL) {
         } else
         if (v11 == NULL) {
            v11 = v10;
         }
         else {
            v10->last->next = v11;
            v10->last = v11->last;
            v11 = v10;
         }
      }
      v8 = v8->next;
   }
   /* ------------------------- build candidate structures ------------------------ */
   v12 = v11;
   v13 = NULL;
   while (v12 != NULL) {
      /* -------------------- v13 = v12->item.alg_enum ++ v13 --------------------- */
      if (v12->item.alg_enum == NULL) {
      } else
      if (v13 == NULL) {
         v13 = v12->item.alg_enum;
      }
      else {
         v12->item.alg_enum->last->next = v13;
         v12->item.alg_enum->last = v13->last;
         v13 = v12->item.alg_enum;
      }
      v12 = v12->next;
   }
   memory_clear(adp_dynmem);
   return build_str_Signature(copy_str_Signature(v13));
}

/* backtracing code for production block                                            */
/* -------------------------------------------------------------------------------- */
static struct str1 *back_block(int i, int j, int diff)
{
   struct str1 *v10;
   int v6;
   struct str3 *v1, *v2, *v3, *v4, *v5, *v7, *v8, *v9;
   int k;

   /* ---------------------------------- start of --------------------------------- */
   /* --------------------------- v1 = ul <<< p initstem -------------------------- */
   if ((j-i) >= 7) {
      if (abs(tbl_block(i, j) - (40 + tbl_initstem(i, j))) <= diff) {
         v1=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v1->next = NULL;
         v1->last = v1;
         v1->item.alg_mfe = 40 + tbl_initstem(i, j);
         v1->item.alg_enum = new_Ul_f(back_initstem, i, j);
      }
      else {
         v1 = NULL;
      }
   }
   else {
      v1 = NULL;
   }
   /* --------------------------- v1 = ul <<< p initstem -------------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ---------------------------------- start of --------------------------------- */
   /* -------------------- v3 = ssadd <<< region ~~~ p initstem ------------------- */
   if ((j-i) >= 8) {
      v3 = NULL;
      for (k=i+1; k<=j-7; k++) {
         if (abs(tbl_block(i, j) - ((40 + tbl_initstem(k, j)) + ss_energy(i, k))) <= diff) {
            v2=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
            v2->next = NULL;
            v2->last = v2;
            v2->item.alg_mfe = (40 + tbl_initstem(k, j)) + ss_energy(i, k);
            v2->item.alg_enum = new_Ssadd_f(i, k, back_initstem, k, j);
         }
         else {
            v2 = NULL;
         }
         /* ---------------------------- v3 = v2 ++ v3 ---------------------------- */
         if (v2 == NULL) {
         } else
         if (v3 == NULL) {
            v3 = v2;
         }
         else {
            v2->last->next = v3;
            v2->last = v3->last;
            v3 = v2;
         }
      }
   }
   else {
      v3 = NULL;
   }
   /* -------------------- v3 = ssadd <<< region ~~~ p initstem ------------------- */
   /* ---------------------------------- finished --------------------------------- */

   /* ------------------------------- v4 = v1 ++ v3 ------------------------------- */
   if (v1 == NULL) {
      v4 = v3;
   } else
   if (v3 == NULL) {
      v4 = v1;
   }
   else {
      v1->last->next = v3;
      v1->last = v3->last;
      v4 = v1;
   }
   /* ------------------------------ v6 = minimum(v4) ----------------------------- */
   v6 = 1.0e7;
   v5 = v4;
   while (v5 != NULL) {
      v6 = v6 < v5->item.alg_mfe ? v6 : v5->item.alg_mfe;
      v5 = v5->next;
   }
   v5 = v4;
   v8 = NULL;
   while (v5 != NULL) {
      if (abs(v6 - v5->item.alg_mfe) <= diff) {
         update_str_Signature(v5->item.alg_enum->item, diff - abs(v6 - v5->item.alg_mfe));
         v7=(struct str3 *) myalloc(adp_dynmem, sizeof(struct str3 ));
         v7->item = v5->item;
         v7->next = NULL;
         v7->last = v7;
         /* ---------------------------- v8 = v7 ++ v8 ---------------------------- */
         if (v7 == NULL) {
         } else
         if (v8 == NULL) {
            v8 = v7;
         }
         else {
            v7->last->next = v8;
            v7->last = v8->last;
            v8 = v7;
         }
      }
      v5 = v5->next;
   }
   /* ------------------------- build candidate structures ------------------------ */
   v9 = v8;
   v10 = NULL;
   while (v9 != NULL) {
      /* --------------------- v10 = v9->item.alg_enum ++ v10 --------------------- */
      if (v9->item.alg_enum == NULL) {
      } else
      if (v10 == NULL) {
         v10 = v9->item.alg_enum;
      }
      else {
         v9->item.alg_enum->last->next = v10;
         v9->item.alg_enum->last = v10->last;
         v10 = v9->item.alg_enum;
      }
      v9 = v9->next;
   }
   memory_clear(adp_dynmem);
   return build_str_Signature(copy_str_Signature(v10));
}

/* table memory allocation                                                          */
/* -------------------------------------------------------------------------------- */

static void tableAlloc()
{
   int i, dim1, dim2;

   arr_closed=(int *) malloc(((n*(n+1))/2+n+1) * sizeof(int ));
   arr_ml_components=(int *) malloc(((n*(n+1))/2+n+1) * sizeof(int ));
   arr_initstem=(int *) malloc(((n*(n+1))/2+n+1) * sizeof(int ));
   arr_struct=(int *) malloc((n+1) * sizeof(int ));
   arr_block=(int *) malloc(((n*(n+1))/2+n+1) * sizeof(int ));
   arr_comps=(int *) malloc(((n*(n+1))/2+n+1) * sizeof(int ));
}

/* free memory                                                                      */
/* -------------------------------------------------------------------------------- */

static void freeall()
{
   adplib_free(opts, seq);
rnalib_free();
   free(arr_closed);
   free(arr_ml_components);
   free(arr_initstem);
   free(arr_struct);
   free(arr_block);
   free(arr_comps);
}

/* table move for window mode                                                       */
/* -------------------------------------------------------------------------------- */

static void movetables(int p)
{
   int i, j;

   for (j=p; j<=n; j++) {
      for (i=p; i<=j; i++) {
         tbl_closed(i-p, j-p) = tbl_closed(i, j);
         tbl_ml_components(i-p, j-p) = tbl_ml_components(i, j);
         tbl_initstem(i-p, j-p) = tbl_initstem(i, j);
         tbl_block(i-p, j-p) = tbl_block(i, j);
         tbl_comps(i-p, j-p) = tbl_comps(i, j);
      }
   }
}

/* main dynamic programming loop                                                    */
/* -------------------------------------------------------------------------------- */

static void mainloop()
{
   int i, j;
   int v2, result_score;
   struct str1 *l;
   struct str1 *next;
   int score;
   int pos, startj, best_result;

   tableAlloc();
   pp_init=(struct str1 ***) myalloc(adp_statmem, (n*2) * sizeof(struct str1 **));
   pp_initA=(struct str1 **) myalloc(adp_statmem, (n*2) * sizeof(struct str1 *));
   best_result = 100000;
   for (pos=0; pos<=seq->original_length-(opts->window_size); pos += opts->window_step) {
      opts->window_pos = pos;
      if (pos == 0) {
         startj = 0;
      }
      else {
         startj = n-(opts->window_step)+1;
      }
      if (pos > 0) {
         movetables(opts->window_step);
         shift_input(opts, seq, 0);
      }
      for (j=startj; j<=n; j++) {
         for (i=j; i>=0; i--) {
            calc_closed(i, j);
            calc_ml_components(i, j);
            calc_initstem(i, j);
            if ((j) == (n)) {
               calc_struct(i, j);
            }
            calc_block(i, j);
            calc_comps(i, j);
         }
      }
      /* --------------------------- show axiom: struct --------------------------- */
      result_score = tbl_struct(0, n);
      if (opts->traceback_percent) traceback_diff = abs(result_score * opts->traceback_percent / 100);
      rna_output_optimal(opts, seq, "mfe", result_score, result_score, result_score + traceback_diff);      rna_output_subopt_start(opts, seq, "mfe", result_score, result_score, result_score + traceback_diff);

      if (opts->energy_only){
        // print energy
        printf("... (%.2f)\n", (float)result_score/100);
        continue;
      }

      if (((opts->window_best) == 0) || (best_result > result_score)) {
         best_result = result_score;
         if (pos > 0) {
            print_sequence(opts, seq, opts->window_pos, opts->window_size);
         }
         copy_depth = 0;
         l = back_struct(0, n, traceback_diff);
         backtrace_tree = l;
         while ((l != NULL) || (pp_next != NULL)) {
            pp_next = NULL;
            pp_initC = (-1);
            result_prettyprint[0] = 0;
            pp_outp = result_prettyprint;
            rmAllowed = 1;
            removeAddr = NULL;
            score = pp_str_Signature(l);
            if (is_suboptimal(result_score, score, traceback_diff)) {
            rna_output_subopt(opts, seq, "mfe", score, result_prettyprint);            }
            if (pp_next != NULL) {
               build_str_Signature((*pp_next)->next);
               next = (*pp_next)->next;
               if (removeAddr != NULL) {
                  free_str_Signature(0, (*removeAddr));
               }
               (*pp_next) = next;
               if (pp_initC != (-1)) {
                  for (i=0; i<=pp_initC; i++) {
                     (*pp_init[i]) = pp_initA[i];
                  }
               }
            }
            else {
               next = l->next;
               if (l->next) {
                  build_str_Signature(l->next);
               }
               free_str_Signature(0, l);
               l = next;
            }
         }
      rna_output_subopt_end(opts, seq, "mfe", result_score, result_score, result_score + traceback_diff);      }
   }
}

int main_rnafold_mfe(toptions *_opts, tsequence *_seq)
{
   opts = _opts;
   seq  = _seq;
   z    = _seq->seq - 1;
   n    = _seq->length;

   adplib_init(opts,seq,&z,&n);
   result_prettyprint = (char *) myalloc(adp_statmem, 30*n*sizeof(char));

traceback_diff = opts->traceback_diff * 100;
   maxloop = opts->maxloop;
   rnalib_init(opts,seq);
   mainloop();
  freeall();
}
