/* nodetypes.h */
#include <polylib/polylib.h>

typedef	enum {	/* icons */
                icons, bcons, rcons,
		/* unop */
		negop, caseop, notop, sqrtop, absop,
		/* binop */
		addop, subop, mulop, divop, idivop, modop,
		xaddop, xsubop,
		eqop, leop, ltop, gtop, geop, neop,
		orop, andop, xorop, minop, maxop,
		restrictop, loopop, affineop, defop, equateop, callop,
		/* triop */
		ifop,
		/* list */
		list, inpsop, outsop, locsop, letop,
		/* others */
		reduce, id, proto, var, parameter, iddef,
                prog, sys, use,
		pol, mat, vec, none } nodetype;

typedef enum { inttype, booltype, realtype, domtype } vartype;

typedef enum {floatingcoding, longintcoding, 
              signedcoding , unsignedcoding, othercoding  } codingtype;

typedef	enum { inputvar, outputvar, localvar } varclass;

typedef struct node_
	{   nodetype type;
	    struct node_ *pv, *nx;	/* for the memory mgmt system */
	    struct node_ *next;		/* all nodes are listable */
	    int  index;
	    union
	    {	struct
		{   int value, fraction, infinity;
		} icons;
		struct
		{   struct node_ *r, *c, *l;
		} triop;
		struct
		{   struct node_ *r, *l;
		    struct node_ *index;
		} binop;
		struct
		{   struct node_ *c;
		} unop;
		struct
		{   struct node_ *first, *last;
		    int count;
		} list;
		struct
		{   vartype type;
		    struct node_ *domain;
		    varclass iotype;
		    struct node_ *coding;
		    struct node_ *length;
		    char name[1];
		} id;
		struct
		{   vartype type;
		    struct node_ *domain;
		    struct node_ *coding;
		    struct node_ *length;
		} proto;
		struct
		{   nodetype op;
		    struct node_ *proj;
		    struct node_ *exp;
		} reduce;
		struct
		{   struct node_ *name;
                    struct node_ *param;
		    struct node_ *inputs;
		    struct node_ *outputs;
		    struct node_ *locals;
		    struct node_ *equations;
		} sys;
		struct
		{   struct node_ *name;
		    struct node_ *param;
		    struct node_ *extdom;
		    struct node_ *inputs;
		    struct node_ *outputs;
		} use;
		struct
		{   int ref_count;
		    int invert;
		    struct node_ *index;
		    struct node_ *m;		/* for z-pol */ 
		    Polyhedron *p;
		} pol;
		struct
		{   int ref_count;
		    int maxrows;
		    struct node_ *index;
		    Matrix *m;
		} mat;
		struct
		{   int ref_count;
		    struct node_ *index;
		    Vector *v;
		} vec;
	    } info;
	} node;

