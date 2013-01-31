(* ;-*-C-*- *)
(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : The Alpha Contributors 
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
   Place - Suite 330, Boston, MA  02111-1307, USA.   
*)
BeginPackage["Alpha`Semantics`", {"Alpha`Domlib`",
				  "Alpha`",
				  "Alpha`Matrix`",
				  "Alpha`Options`",
				  "Alpha`Tables`"
				  }]
(* 
   changelog: 03/27/1995, F. de Dinechin: added expDimension
                                          added parameter-aware error messages
   
  NOTE: .
*)
(* Standard head for CVS

	$Author: risset $
	$Date: 2004/06/16 15:14:06 $
	$Source: /udd/alpha/CVS/alpha_beta/Mathematica/lib/Packages/Alpha/newPackages/Semantics.m,v $
	$Revision: 1.1 $
	$Log: Semantics.m,v $
	Revision 1.1  2004/06/16 15:14:06  risset
	added new and old Packages
	
	Revision 1.60  2003/12/12 13:17:00  risset
	 minor modif
	
	Revision 1.59  2003/07/18 12:52:41  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.57  2003/07/02 07:58:51  risset
	added Modifications for Zpolyhedra
	
	Revision 1.56  2002/10/21 08:25:38  quinton
	Edition corrections.
	
	Revision 1.55  2002/10/16 12:21:56  risset
	small changes after the big post-samos debugging phase
	
	Revision 1.54  2002/07/16 12:33:57  quinton
	The function getContextDomain was modified, in order to incorporate a
	test on the fly for case expressions, if the option checkCase is True. This
	test was earlier done in expDomain, but sometimes, it was to strong.
	
	Revision 1.52  2001/08/23 14:03:39  risset
	merged with Patrice version
	
	Revision 1.51  2001/04/21 07:10:02  quinton
	Changed file format from Windows to unix
	
	Revision 1.50  2001/04/21 05:34:02  quinton
	A debug option was added to function getContextDomain
	
	Revision 1.49  2001/02/02 08:59:34  risset
	corrected Vhdl2.m which was broken, remove showVhdl form Vhdl.m
	
	Revision 1.48  2001/01/15 09:02:01  risset
	mise a jour
	
	Revision 1.47  2000/05/26 13:27:43  risset
	add options to analyze
	
	Revision 1.46  1999/12/10 16:59:05  risset
	commited struct Sched and ZDomlib
	
	Revision 1.45  1999/12/07 16:56:39  quillere
	Added expType for abs unop
	
	Revision 1.44  1999/07/21 15:32:55  risset
	commited for GNU release 1.0
	
	Revision 1.43  1999/05/19 08:17:14  risset
	added expDomain for index exprssion
	
	Revision 1.42  1999/04/22 09:26:21  risset
	erase patrice's last commit because it crushed old results
	
	Revision 1.40  1999/03/02 15:49:27  risset
	added GNU software text in each packages
	
	Revision 1.39  1998/11/27 12:20:19  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.38  1998/10/12 12:10:46  risset
	corrected replaceByEquivalent expr
	
	Revision 1.37  1998/10/05 09:15:04  quillere
	Added support for external pointwise operators calls
	
	Revision 1.36  1998/07/01 09:44:22  alpha
	 corrected a bug in getContextDomain
	
	Revision 1.35  1998/05/29 14:54:51  risset
	added function replaceByEquivExpr

	Revision 1.34  1998/05/04 11:46:37  risset
	commited tag v0-9-1

	Revision 1.33  1998/03/13 16:22:15  quinton
	Few corrections

	Revision 1.32  1998/02/19 15:38:02  risset
	corrected ChangeOfBasis.m

	Revision 1.31  1997/11/19 18:38:07  quillere
	added semantics for external pointwise operators

	Revision 1.30  1997/06/26 14:19:45  risset
	added alphard.m

	Revision 1.29  1997/05/20 08:56:36  quillere
	Correction de quelques erreurs (';' oubli‰s)

	Revision 1.28  1997/05/19 10:41:37  risset
	corrected exported bug in dependancies

	Revision 1.27  1997/05/13 14:49:01  alpha
	modif of some usages

	Revision 1.26  1997/05/13 13:40:56  risset
	report Patrice modifs on usage

	Revision 1.25  1997/04/22 10:57:23  risset
	removed some cycling dependencies between packages

	Revision 1.24  1997/04/10 09:19:51  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.23  1997/03/19 13:10:02  fdupont
	corrected Need[] bug

	Revision 1.22  1997/02/21 10:44:48  fdupont
	upgraded getContextDomain to work with use statements

	Revision 1.21  1997/02/06 14:51:24  fdupont
	First bug reports : corrected expType

	Revision 1.20  1997/02/06 09:21:39  fdupont
	Added scalar type checking and corrected a few bugs

	Revision 1.19  1996/07/24 10:12:15  fdupont
	Ajout de la reduction dans getContextDomain

	Revision 1.18  1996/07/01 09:12:54  fdupont
	added the function addAllParameterDomain

	Revision 1.17  1996/06/24 13:55:02  risset
	added standard head comments for CVS



*)

(*  *)
Semantics::usage = 
"Alpha`Semantics`Semantics` is the package which contains the 
functions to compute the type of Alpha expressions.";

expType::usage =
"expType[exp] computes the type (Alpha`integer, Alpha`boolean,
Alpha`real, Alpha`bottom) of an expression and checks its correctness
using type--matching rules. expType[sys,exp] does the same to program
in symbol sys.  The expression may be given as a String, a position
vector (following the convention of the Mathematica function Position)
in the system, or as an AST. expType returns Alpha`bottom if the
expression is not correctly typed.  In such a case, the offending tree
and the colliding types are printed on the screen.";

expType::arg = "Wrong arguments";

expDimension::usage = 
"expDimension[exp] computes the dimension of expression exp in
system $result. expDimension[sys,exp] computes the dimension of
expression exp in system contained in symbol sys. The expression
may be given as a String, a position vector (following the convention
of the Mathematica function Position) in the system, or as an AST.
expDimension outputs error messages if dimensions are not compatible,
and returns dimension -1 in this case.  Remark: parameters are counted
as additional dimensions.";

expDomain::usage = 
"expDomain[exp] computes and returns the domain of exp in program
$returns, or $Failed if the expression is badly formed.
expDomain[sys,exp] computes and returns the domain of exp in program
sys.  expDomain generates error and warning messages accordingly. The
expression may be given as a String, a position vector (following the
convention of the Mathematica function Position) in the system, or as
an AST."

getContextDomain::usage = 
"getContextDomain[pos] computes the context domain in which an
expression at position pos in $result is used.  getContextDomain[sys,
pos] computes the context domain in which an expression at position
pos in sys.  The context is the domain inherited by an expression from
the constructs which surrounds it.  The position is counted from the
root of the system (Mathematica notion of position).";

matchTypes::usage =
"matchTypes[type1,type2] computes the type corresponding to the union
of those of the parameters (integer, boolean, real). Returns the 
resulting type or bottom if the types are uncompatible.";

expDomain::ERROR = " ";

replaceByEquivExpr::usage= 
"replaceByEquivExpr[position1,expr2] replace in $result the expression
present at position positin1 by expr2.
replaceByEquivExpr[expr1,expr2] replace in $result all occurences of
expr1 by expr2. expr1 and expr2 can be given in AST form of Alpha form
(String). WARNING The equivalence of the resulting program is NOT
guaranteed. A test is made to check if the two expressions are
equivalent, but if this test fails, the replacement is done anyway.
This function should be used for replacing expression by equivalent
one when this cannot be done automatically (for instance, in presence
of degenerated domains). Can also be called as
replaceByEquivExpr[sys,expr1,expr2], or
replaceByEquivExpr[sys,position1,,expr2]";

changeType::usage = 
"changeType[sys,var,newType] changes the type of variable var
to newType in syst. No typing compatibility check are done: no
semantic preserving property. Mainly used for changing integers to
fixed bit width integers. changeType[var,newType] applies on and
modifies $result.";

Begin["`Private`"]

(*  *)
(*---------------------------------------------------------------------*)
(* expType                                                             *)
(*                                                                     *)
(* computes the type of an expression.  Generates warnings if types    *)
(* don't match                                                         *)
(*---------------------------------------------------------------------*)

(*---------------------------------------------------------------------*)
Clear[booleanType];
booleanType[boolean] := boolean;
booleanType[unkown] := boolean;
booleanType[_] := bottom;

(*---------------------------------------------------------------------*)
Clear[integerType];
integerType[integer] := integer;
integerType[unkown] := integer;
integerType[integer[a_,b_]] := integer;
integerType[_] := bottom;

(*---------------------------------------------------------------------*)
Clear[numberType];
numberType[integer] := integer;
numberType[real] := real;
numberType[unkown] := unkown;
numberType[integer[a_,b_]] := integer;
numberType[_] := bottom;

(*---------------------------------------------------------------------*)
Clear[matchTypes];
matchTypes[integer, integer] := integer;
matchTypes[real,    real]    := real;
(* Type coercion : integer -> real *)
matchTypes[integer, real] := real;
matchTypes[real, integer] := real;
matchTypes[boolean, boolean] := boolean;

matchTypes[boolean, unkown] := boolean;
matchTypes[integer, unkown] := integer;
matchTypes[real, unkown] := real;
matchTypes[a:integer,b:integer[_,_]] := integer;
matchTypes[a:integer[_,_],b:integer] := integer;

matchTypes[a:integer[_,_],b:integer[_,_]] := 
Module[{widthA,widthB,codeA,codeB,widthFinal,codeFinal},
  If [MatchQ[a,integer_] && MatchQ[b,integer_],
    (* set the bit size of the op *) 
    widthA=a[[2]];
    widthB=b[[2]];
    widthFinal=Max[widthA,widthB];
    codeFinal=If[(a[[1]]==="S")||(b[[1]]==="S"),"S","U"];
      integer[codeFinal,widthFinal]
    (* else bottom *)
    , 
    bottom
  ]
];
matchTypes[_, _] := bottom

(*  *)
(*---------------------------------------------------------------------*)
Clear[typeName]
typeName[numberType] = "integer/real"
typeName[integerType] = "integer"
typeName[booleanType] = "boolean"
(*---------------------------------------------------------------------*)
Clear[unaryTypeCheck]
unaryTypeCheck[ sys_system,   expr_, 
	        crntType_,    typeFunction_Symbol] :=
If[crntType =!= bottom,
  If[typeFunction[crntType] =!= bottom,
    crntType,
    (Print["ERROR: Type mismatch in :"];
     ashow[expr, sys[[2]]];
     Print["Expression is "<>ToString[crntType]<>" instead of "
	<>typeName[typeFunction]<>".\n"];
     bottom)
  ],
  bottom
];

(*---------------------------------------------------------------------*)
Clear[binaryTypeCheck]
binaryTypeCheck[ sys_system, expr_, crntType1_, 
                 crntType2_, typeFunction_Symbol] :=
With[{res = matchTypes[crntType1, crntType2]},
  If[ (crntType1 =!= bottom) && (crntType2 =!= bottom),
    If[typeFunction[res] =!= bottom,
      res,
      (Print["ERROR: Type mismatch in :"];
       ashow[expr, sys[[2]]];
       Print["Expression is ("<>
           ToString[crntType1]<>","<>ToString[crntType2]<>
           ") instead of ("<>
           typeName[typeFunction]<>","<>typeName[typeFunction]<>
                   ").\n" ];
       bottom)
    ],
    bottom
  ]
];

(*---------------------------------------------------------------------*)
Clear[externalTypeCheck];
externalTypeCheck[ 
 sys:_system,
 name:_String,
 dcltypes:_List,
 args:_List] :=
With[
  {matchQ=
    Function[{dcl, arg},
    If[matchTypes[dcl, expType[sys, arg]] =!= bottom,
       True,
       Print["ERROR: ",
     "type mismatch for parameter ",
     sprint[arg],
     " in external operator ", name,
     " call (expected ", dcl, ")"];
      False]
    ],

    dcllen = Length[dcltypes[[1]]],
    argslen = Length[args]
  },

  If[dcllen == argslen,
    If[And@@MapThread[matchQ, {dcltypes[[1]], args}],
      dcltypes[[2]],
      bottom
    ],
    Print["ERROR: ",
      "external operator ", name,
      " called with ", argslen,
      " arguments instead of ", dcllen];
    bottom
  ]
];

(*---------------------------------------------------------------------*)
Clear[expType];

expType[exp_String] := expType[$result, readExp[exp, $result[[2]]]];
expType[pos_List]   := expType[$result, getPart[$result, pos]];
expType[exp_]       := expType[$result, exp];
expType[sys_system, exp_String] := expType[sys, readExp[exp,sys[[2]]]];
expType[sys_system, pos_List]   := expType[sys, getPart[sys, pos]];

expType[sys_system, var[id_String]] := (*........ variable *)
Module[ {type},
  type = Part[getDeclaration[sys, id], 2];
  If[ MatchQ[type, notype],
    Print["ERROR: variable ",id," declared with notype."]
  ];
  type 
];
	     
expType[sys_system, const[c_ /; NumberQ[c]]] := (* constants *)
  If[IntegerQ[c], integer, real];

expType[sys_system, const[Infinity]] := integer;
expType[sys_system, const[-Infinity]] := integer;
expType[sys_system, const[True]] := boolean;
expType[sys_system, const[False]] := boolean;
expType[sys_system, const[_]] := bottom;

(* index expressions *)
expType[sys_system, index[_]] := integer;

(* unop *)
expType[sys_system, tree:unop[not, exp_]] := 
  unaryTypeCheck[sys, tree, 
		 expType[sys, exp], 
                 booleanType];

expType[sys_system, tree:unop[sqrt|neg|abs, exp_]] :=
  unaryTypeCheck[sys, tree, 
		 expType[sys, exp], 
                 numberType];

(* arithmetic operations *)
expType[sys_system,                       (* ............. binop *)
	   tree:binop[op_, exp1_, exp2_] /;
	   MemberQ[{add, sub, mul, div,
		    min, max}, op]] :=
  binaryTypeCheck[sys, tree, 
		  expType[sys, exp1], 
		  expType[sys, exp2], 
                  numberType];

(* relational operators *)
expType[sys_system,
	   tree:binop[op_, exp1_, exp2_]
	   /; MemberQ[{eq, le, lt,
		       gt, ge, ne}, op]] :=
With[ {res = binaryTypeCheck[sys,tree, 
			       expType[sys, exp1], 
			       expType[sys, exp2],
			       numberType]},
	If[ res =!= bottom, 
	    boolean, 
	    bottom
	]
];

(* integer operators *)
expType[ sys_system,
       tree:binop[op_, exp1_, exp2_]
	 /; MemberQ[{idiv, mod}, op]] :=
With[{res = binaryTypeCheck[sys,tree, 
			      expType[sys, exp1], 
			      expType[sys, exp2],
			      integerType]},
  If[ res =!= bottom, 
	   integer, 
	   bottom
  ]
];

(* boolean operators *)
expType[sys_system,
	   tree:binop[op_, exp1_, exp2_]
	   /; MemberQ[{and, or, xor}, op]] :=
With[{res = binaryTypeCheck[sys,tree, 
			      expType[sys, exp1], 
			      expType[sys, exp2],
			      booleanType]},
       If[ res =!= bottom, 
	   boolean, 
	   bottom
       ] 
];

prototype["Max"]={{integer,integer},
	       integer};
prototype["Max3"]={{integer,integer,integer},
	       integer};
prototype["Max4"]={{integer,integer,integer,integer},
	       integer};
prototype["Max"]={{integer,integer},
	       integer};
prototype["tan_h"]={{real},
	       real};
prototype["trunc"]={{real},
	       integer};
prototype["round"]={{real},
	       integer};
                                                    (*......... call *)
expType[
 sys:_system, 
 exp:call[name:_String, args:_List]] :=           
  With[{declared = prototype[name]},
       Which[MatchQ[declared, {_List, _}],
	     externalTypeCheck[sys, name, declared, exp[[2]]],
	     MatchQ[declared, {_, _}],
	     externalTypeCheck[sys, name, {{declared[[1]]}, declared[[2]]} , exp[[2]]],
	     True,
	     Print["Warning: ",
		   "can't find prototype for external operator ",
		   name, " , assuming type of first argument"];
	     expType[sys,args[[1]]]]
       ];

expType[sys_system, affine[exp_, _]] := (*......... affine *)
     expType[sys, exp];

expType[sys_system, restrict[_, exp_]] := (*..... restrict *)
     expType[sys, exp];

expType[sys_system, reduce[_,_,exp_]] := (*........ reduce *)
     expType[sys, exp];

(* Cleaning stopped here *)
expType[sys_system, case[l__]] :=  (*.................case *)
  With[{ elemtypes = Union[ Map[Function[ expType[sys, #] ], 
				l] 
			  ]},
       If[ elemtypes === {integer},
	   integer,
	   If[ Or[ elemtypes === {integer,real},
		   elemtypes === {real} ],
	       real,
	       If[ elemtypes === {boolean},
		   boolean,
		   (Print["ERROR: Type mismatch in 'case': "
			    <>ToString[elemtypes]<>"."];
		    bottom)
		   ]
	     ]
	 ]
     ]

expType[sys_system, if[cond_, exp1_, exp2_]] :=  (*.... if *)
  With[{typecond = expType[sys, cond],
	t1 = expType[sys, exp1],
	t2 = expType[sys, exp2]},
       If[typecond === boolean,
	  With[{res = matchTypes[t1, t2]},
	       If[res =!= bottom,
		  res,
		  (Print["ERROR: Type mismatch in 'if': ("
			   <>ToString[t1]<>", "<>ToString[t2]<>"). "];
		   bottom)]],
	  (Print["ERROR: condition type in 'if' is ",
		   typecond," and must be boolean."];
	   bottom)]]

expType[___]:=Message[expType::arg]

(*---------------------------------------------------------------------*)
(* getContextDomain                                                    *)
(*                                                                     *)
(* computes the context domain for a given expression                  *)
(*                                                                     *)
(*---------------------------------------------------------------------*)
Clear[getContextDomain];
Options[ getContextDomain ] = {debug -> False, checkCase -> False};

(* Option with $library and $result assumed *)
getContextDomain[pos:{__Integer}, opts:___Rule ] := 
  getContextDomain[ $library, $result, pos, opts];

(* Calling with a list of positions (occurs) *)
getContextDomain[{occur:{_Integer..}}, opts:___Rule ] := 
  getContextDomain[$library,$result, occur, opts];

(* $library assumed *)
getContextDomain[sys:_system, pos:{__Integer}, opts:___Rule] := 
  getContextDomain[ $library, sys, pos, opts];

(* same with occur *)
getContextDomain[sys:_system, occurs:{{_Integer..}..}, opts:___Rule] := 
  getContextDomain[ $library, sys, occurs, opts ];

(* Full form, with a list of positions, recursive call *)
getContextDomain[ lib_List, 
		  sys:_system, 
		  {occur:{_Integer..}, occurs__}, opts:___Rule] :=
  DomUnion[ getContextDomain[lib,sys,occur,opts], 
            getContextDomain[lib,sys,{occurs}, opts ]];

(* Terminal case of the recursion *)
getContextDomain[ lib_List, sys:_system, {occur:{_Integer..}}, 
  opts:___Rule] :=
  getContextDomain[ lib, sys, occur, opts ];

(* Full call *)
getContextDomain[lib_List, sys:_system, occur:{__Integer}, 
    opts:___Rule ] :=
Catch[
  Module[
    {equ,dbg,res},
    dbg = debug/.{opts}/.Options[ getContextDomain ];
    (* An occurrence should be longer than 2... *) 
    If[ Length[occur]>=2,
	equ = sys[[6]][[occur[[2]] ]],
	equ = $Failed];

    If[ MatchQ[equ, equation[___]], 

      res = getContextDomainEqu[sys,occur,equ,opts];
      If[ dbg, ashow[res]]
      ,

      If[ MatchQ[ equ, use[___] ],
        res = getContextDomainUse[lib,sys,occur,equ,opts]
        (* For standard Alpha the previous is enough. 
          The following lines are needed  in case of nested let...tel. 
          I don't know what the semantics should be in this case,
          so I leave it as I found it
          (Florent)   *),   

        equ = lookUpFor[sys, occur, equation];
        Print["Warning from getContextDomain: nested let..tel, semantics not guaranteed."];
        If[ MatchQ[equ,{}],
          $Failed,
          res = getContextDomainEqu[sys,occur,equ,opts]
	      ]
	  ]
     ]; res
  ]
];

getContextDomain[___] := Message[ getContextDomain::params ];

(*  *)
Clear[getContextDomainUse];
getContextDomainUse[lib_List, sys:_system, 
		   occur:{_Integer..}, equ:_use, opts:___Rule ] :=
  Module[ {matches, ss, i, decldom, extdom, passgn, lhsdom, paramdom, 
           dom, dbg },
     Catch[
       dbg = debug/.{opts}/.Options[getContextDomain];
       matches = Cases[lib, system[equ[[1]], _,_,_,_,_]];
       If[ matches == {}, 
         (Print["ERROR: Declaration of system : ", equ[[1]]];
          Print["       not found in library.\n"];
          Throw[$Failed] )];
       If[ Length[matches] >1,
         Print["WARNING: more than one declarations of ",
                 name, " in library. Using the first.\n"] ];
         ss = matches[[1]];
         i = occur[[4]] (* the index of the actual input *) ;
         decldom = ss[[3]][[i]][[3]];
         If[ dbg, Print["Declaration domain : ", 
                          ashow[decldom, silent->True]] ];
         extdom = equ[[2]];
         If[ dbg, Print["Extension domain : ", extdom ] ];
         passgn = equ[[3]];
         If[ dbg, Print["passgn ", passgn ] ];
	   (* Temporary! there is a cyclic dependence between 
	      Package Semantics and Subsystems, this temporary
	      solution  should be replaced by the one of Fabien:
	      No dependence in the declaration of the package, 
	      the Needs are evaluated at the begin Private *)
	     lhsdom = Alpha`SubSystems`substDom[ decldom, 
			      extdom,
			      passgn,
			      ss[[2]][[1]] 
			    ]; 
         If[ dbg, Print[" lhsdom : ", lhsdom ]];
	 dom = DomIntersection[lhsdom,			(* change *)
                 DomExtend[ sys[[2]],If[Head[lhsdom[[3,1]]]===Alpha`pol, lhsdom[[2]],lhsdom[[3,1,1,3]]] ] ];
         If[ dbg, Print[" dom : ", dom ]];
        (* dom = domain of virtual LHS restricted with parameter domain *);
         getContextDomain1[ sys,
                            lhsdom,
                            equ[[4]][[i]],
                            Drop[occur,4] ]
     ]
  ];

getContextDomain::extend = "error while computing extension of domain";
getContextDomain::inters = "error while computing intersection of domains";

(*  *)
Clear[getContextDomainEqu];
getContextDomainEqu[sys:_system, occur:{_Integer..}, 
		    equ:_equation, opts:___Rule] := 
Module[
  {dvar, dom, posEq, res, dbg},
  dbg = debug/.{opts}/.Options[getContextDomain];

  (* dvar = domain of lhs var *)
  dvar= Part[ getDeclaration[sys, 
			     Part[equ,1]], 
	      3]; 
  If[ dbg, Print["Domain of lhs var : ", ashow[dvar,silent->True] ] ];
  dom = Check[ DomExtend[ sys[[2]],If[Head[dvar[[3,1]]]===Alpha`pol, dvar[[2]],dvar[[3,1,1,3]]] ], (* change *)
               Throw[ Message[ getContextDomain::extend ]; $Failed ] ];
  If[ dbg, Print["Extended domain : ", ashow[dom,silent->True] ] ];

  dom = Check[ DomIntersection[dvar, dom ], 
               Throw[ Message[ getContextDomain::inters ]; $Failed ] ];
  If[ dbg, Print["Intersection : ", ashow[dom,silent->True] ] ];

  (* dom = domain of lhs var restricted with parameter domain *);
  posEq= Part[ Position[sys,equ,Infinity],
	       1 ];
  (* Call the function getContextDomain1, with context domain 
     dom, on the rhs of the equation, with the occurrence obtained
     by dropping the first indexes of occur *)
  (* The last Drop was corrected by tanguy 10/05/95 
     It was written Drop[occur,3] which was false 
       in case of Alpha0 ...*)
  res = getContextDomain1[ sys, 
		     dom, 
		     Part[equ,2], 
		     Drop[occur,Count[posEq,_]+1], opts ]; 
  (* The result is the domain which was looked for *)
  If[ dbg, Print["Result : ", ashow[res,silent->True] ] ];
  res
  ];

(*  *)
Clear[getContextDomain1];

(* This function is the one that does the job... 
   It is called with a system, a domain dom, an expression 
   and the position of an occurrence. It computes the 
   domain of the expression 
 *)

(* Restriction *)
getContextDomain1[
  sys:_system, dom:_domain, e:restrict[dom1_,exp_], 
  occur:{__Integer}, opts:___Rule ]:=
Module[ {dbg}, 
  dbg = debug/.{opts}/.Options[ getContextDomain ];
  If[ dbg, Print["-------- Restriction : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", occur ] 
  ];
(* Call recursively on exp, after computing the intersection 
   with the domain of the restriction. Drop first index of 
   occur *)
  getContextDomain1[ sys,
    DomIntersection[dom, dom1], 
    exp, 
    Drop[occur,1], opts
  ]
];

(* Case expression *)
(* Added by Patrice on 11/07/2002 *)
getContextDomain1[sys:_system,
		  dom:_domain,
                  e: case[{exp__}], 
                  occur:{pos_, poss___},
                  opts:___Rule ]:=
Module[ {branch1, rest, dbg, listOfDomains, lg, overlap, chck}, 
  dbg = debug/.{opts}/.Options[getContextDomain];
  chck = checkCase/.{opts}/.Options[getContextDomain];

  If[dbg, 
    Print["-------- Case expression : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", occur ] 
  ];

  If[ chck, 
    (* 
      The idea here is to check on the fly that any case expression
      has non overlapping branches. To do so, we run getContextDomain1
      on all branches, and we detect that their intersection is OK. 
    *)
    lg = Length[ {exp} ]; 
    If[ dbg, Print[ "Number of branches : ", lg ] ];

    If[ lg > 1, 
      listOfDomains = 
        Map[ 
          Function[ { exx }, getContextDomain1[ sys, dom, exx, {1} , opts ] ]
          , {exp} 
        ];

      If[ dbg, Print[ "Domains : " ] ];
      If[ dbg, Map[ ashow, listOfDomains ] ];

      Check[
        overlap = Fold[ DomIntersection, 
              listOfDomains[[1]], 
              Drop[ listOfDomains, 1] 
            ], 
        getContextDomain::errDomInt = "error while calling DomIntersection";
        Throw[ Message[ getContextDomain::errDomInt ] ]
      ];

      If[ !DomEmptyQ[ overlap ], 
        getContextDomain::caseoverlap = 
          "case overlap ";
        Print["ERROR. In case expression "];
        ashow[ case[{exp}] ];
        Print["the domains of the branches overlap on :"];
        ashow[ overlap ];
        Message[ getContextDomain::caseoverlap ];
      ];
      If[ dbg, Print["Overlapping: " ]; ashow[ overlap ] ];
    ]; (* End If *)
  ]; (* End if chck *)

  If[ dbg, Print["Recursive call.... "] ];
  getContextDomain1[ sys, dom, e[[pos]], {poss}, opts]

];

(* Affine expression *)
getContextDomain1[sys_, dom_, e:affine[exp_,mat_], occur:{_Integer..},
                  opts:___Rule ] :=
Module[ {dbg}, 
  dbg = debug/.{opts}/.Options[ getContextDomain ];
  If[ dbg, Print["-------- Affine expression : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", occur ] 
  ];
(* Recursive call, with context being the image of dom by mat*)
    getContextDomain1[ sys,	(* change *)
		       DomImage[dom,mat],
		       exp, 
		       Drop[occur,1],opts]
];

(* Index *)
(* If position is 1, return the image of dom by mat *)
getContextDomain1[sys_,
		  dom_,
                  index[mat_], {1}, opts:___Rule ] :=
    DomImage[dom,mat];	(* change *)

(* Binary operator *)
(* If the position has the form 2, poss, call on exp1, after 
   calling expDomain on expression 2, and doing intersection. 
   Seems to me that this is not totally correct... 
   FIXIT *)
getContextDomain1[
  sys_, dom_, e:binop[op_,exp1_,exp2_], {2, poss___}, opts:___Rule ] :=
Module[ {dbg}, 
  dbg = debug/.{opts}/.Options[ getContextDomain ];
  If[ dbg, Print["-------- Binary operator 1 : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", {2, poss} ] 
  ];
  getContextDomain1[ sys,
    DomIntersection[ dom, expDomain[sys, exp2]], exp1, 
    {poss},opts]
];

(* Same, with second expression of binop *)
getContextDomain1[
  sys_, dom_, e:binop[op_,exp1_,exp2_], {3, poss___}, opts:___Rule ] :=
Module[ {dbg}, 
  dbg = debug/.{opts}/.Options[ getContextDomain ];
  If[ dbg, Print["-------- Binary operator 2 : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", {3, poss} ] 
  ];
  getContextDomain1[ sys,
    DomIntersection[ dom, expDomain[sys, exp1]], exp2, {poss},opts]
];

(* Reduction *)
(* Call on reduction expression, after preimaging the context domain *)
getContextDomain1[
  sys_, dom_, e:reduce[binop_, mat_, exp_], {3, poss___}, opts:___Rule ] :=
Module[ {dbg}, 
  dbg = debug/.{opts}/.Options[ getContextDomain ];
  If[ dbg, Print["-------- Reduction : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", {3, poss} ] 
  ];
  getContextDomain1[ sys,		(* change *)
    DomZPreimage[dom,mat], exp, {poss}, opts]
];

(* Otherwise (unop)  *)
(* This covers all other cases. In this case, one call the 
   expression recursively *)
getContextDomain1[sys_, dom_, exp_, {pos_, poss___},opts:___Rule] :=
Module[ {dbg}, 
  dbg = debug/.{opts}/.Options[ getContextDomain ];
  If[ dbg, Print["-------- Other case : "];
    Print["Context domain : "];
    ashow[dom]; 
    Print["Expression : "];
    ashow[e]; 
    Print[ "Occurrence : ", {pos, poss} ] 
  ];
  getContextDomain1[sys, dom, Part[exp,pos], {poss}, opts]
];

(* If occur is empty, return the domain *)
getContextDomain1[sys_, dom_, _, {}, opts:___Rule ] := 
(If[ debug/.{opts}/.Options[getContextDomain],
    Print["-------- Empty"]];dom);

getContextDomain1[___] := Print[ "Wrong arguments "];

(*---------------------------------------------------------------------*)
(* getUseDomain                                                        *)
(*                                                                     *)
(* OUT OF DATE FUNCTION -- USE getContextDomain instead                *)
(* Function taken from the alpha version because it is used in the     *)
(*   MadMacs packages. It remains to clarify what it does really       *)
(*---------------------------------------------------------------------*)


getUseDomain[sys_system, occur:{_Integer..}] :=
getContextDomain[sys, occur];

(*---------------------------------------------------------------------*)
(* expDomain                                                           *)
(*                                                                     *)
(* function to compute the domain of an Alpha expression               *)
(* generates messages on badly formed expressions                      *)
(*---------------------------------------------------------------------*)

(*---------------------------------------------------------------------*)

Clear[caseflg];
(* This flag is used to disable redundant error messages*)

(*---------------------------------------------------------------------*)
(* expEmp -- local function to check if a domain is empty and
             if so, print a warning message.  Return the domain.
	     Since all the parent expressions of an empty expression
	     are also empty (until the first surrounding case),
	     expEmpflg is set to avoid multiple warnings *)

Clear[expEmpflg];

Clear[expEmp];

(** change **)
expEmp[ sys_system, dom_domain, exp_] :=
Module[ {tmp, paramdom, paramlist},
  If[ !expEmpflg,
    If[ DomEmptyQ[dom],
      Print["expDomain::WARNING: This expression has an empty domain :"]; 
      ashow[exp, sys[[2]]]; Print[" "];
      expEmpflg = True;
    , (* Else look if the domain is empty for some values
		     of the parameters *)
      paramdom = sys[[2]];		(* change *)
      paramlist = If[Head[paramdom[[3,1]]]===Alpha`pol,paramdom[[2]],paramdom[[3,1,1,3]]];
      tmp = 
        DomDifference[
          paramdom,
          DomProject[dom, paramlist] 
        ];
      If[ !DomEmptyQ[tmp],
        Print["expDomain::WARNING: for parameters in :"];
        ashow[tmp]; 
        Print["      this expression has an empty domain :"];
        ashow[exp, paramdom]; Print[" "]; 
        expEmpflg = True;
      ]
    ]; (* If *)
	      
    ];
  dom
  ];  (* Module *)



expEmp[ sys_system, {}, id_] :=
  ( Print[ToString[id]<>" isn't defined."];
    DomEmpty[0] )

expEmp[___] := Message[ expEmp::params ];

(*---------------------------------------------------------------------*)
(* expDimension : boolean function called before any other
 computation by expDomain, getContextDomain, etc 
 Checks the dimensionality of an expression, outputs error messages
 accordingly, returns the dimension of the expression, -1 if error 
 The parameters are counted in the dimension *)

Clear[expDimension]
expDimension[exp_String] := 
  expDimension[$result, readExp[exp, $result[[2]]]]
expDimension[pos_List]   := 
  expDimension[$result, getPart[$result, pos]]
expDimension[exp_]       := 
  expDimension[$result, exp]
expDimension[sys_system, exp_String] := 
  expDimension[sys, readExp[exp,sys[[2]]]]
expDimension[sys_system, pos_List]   := 
  expDimension[sys, getPart[sys, pos]]

(* ...........variable *)
expDimension[ sys_system, var[id_] ] :=
  Block[{d},
	d = getDeclaration[sys, id];
	If[ d==={}, 
	    Print["? Variable "<>ToString[id]<>" is not defined"]; -1,
	    d[[3]][[1]]
	 ]
      ]

(*.....constant *)
expDimension[ sys_system, const[_] ] := 0

(*... unop *)
expDimension[ sys_system, unop[op_, exp_] ] :=
  expDimension[ sys, exp ]

(* .......... binop *)
expDimension[ sys_system, binop[op_, exp1_, exp2_] ] :=
    Block[{d1,d2},
	  d1 = expDimension[ sys, exp1];
	  d2 = expDimension[ sys, exp2];
	  If[ d1==-1 || d2==-1,
	      -1,
	      If[ d1 == d2,
		  d1,
		  (Print["ERROR: in binary operator ", op, ", expression :"];
		   ashow[exp1,sys[[2]]];
		   Print["  has not the same dimension as expression :"];
		   ashow[exp2,sys[[2]]]; Print[" "];
		   -1 ) ]
	    ]
	]

(* ........... call *)
expDimension[ sys_system, tree:call[funcname_String, args_List] ] :=
    Block[{dims},
	  dims = expDimension[ sys, #]& /@ args;
	  If[ Or@@Map[Equal[#,-1]&,dims],
	      -1,
	      If[ Equal@@dims,
		  First[dims],
		  d1,
		  Print["ERROR: dimensions are not compatible in call",
			funcname, ", statment :"];
		  ashow[tree,sys[[2]]];
		  -1 ]
	    ]
]

(* .............. if *)
expDimension[ sys_system, tree:if[exp1_, exp2_, exp3_] ] :=
    Block[{d1,d2,d3},
	  d1 = expDimension[ sys, exp1];
	  d2 = expDimension[ sys, exp2];
	  d3 = expDimension[ sys, exp3];
	  If[ d1==-1 || d2==-1 || d3==-1,
	      -1,
	      If[ d1 == d2 == d3,
		  d1,
		  (Print[
		    "ERROR: Dimensions not compatible in IF statement :"];
		   ashow[tree,sys[[2]]]; Print[" "];
		   -1 ) ]
	    ]
	]  

(*........... affine dependence*) 
expDimension[ sys_system, tree:affine[exp_, mat_] ] :=
  Block[{d},
	d = expDimension[ sys, exp];
	If[ d ==-1,
	    -1,
	    If[ d == mat[[1]]-1,
		mat[[2]]-1, 
		(Print[
		  "ERROR: Dimensions not compatible in dependence :"];
		  ashow[tree,sys[[2]]]; Print[" "];
		  -1 ) ]
	  ]
      ]

(*........... index expression*) 
expDimension[ sys_system, tree:index[mat_] ] :=
  If[(1+Length[sys[[2]][[2]]]) == (mat[[1]]-1),
		mat[[2]]-1, 
		(Print[
		  "ERROR: Dimensions not compatible in index expression :"];
		(*  ashow[tree,sys[[2]]]; Print[" "]; *)
		  -1 ) ]

(* ...... restriction *)
expDimension[ sys_system, 
	      tree:restrict[dom_domain, exp_] ] :=
  Block[{d},
	d = expDimension[ sys, exp];
	If[ d ==-1,
	    -1,
	    If[ d == dom[[1]],
		d, 
		(Print[
		  "ERROR: Dimensions not compatible in restriction :"];
		  ashow[tree,sys[[2]]]; Print[" "];
		  -1 ) ]
	  ]
      ]

(* ...... reduction *)
expDimension[ sys_system, tree:reduce[_,mat_,exp_] ] :=
  Block[{d},
	d = expDimension[ sys, exp];
	If[ d ==-1,
	    -1,
	    If[ d == mat[[2]]-1,
		mat[[1]]-1, 
		(Print[
		  "ERROR: Dimensions not compatible in reduction :"];
		  ashow[tree,sys[[2]]]; Print[" "];
		  -1 ) ]
	  ]
      ]


(* ...... case *)
expDimension[ sys_system, tree:case[exps_] ] :=
Block[{l},

      l = Map[ Function[ subexp, expDimension[ sys, subexp] ],
	       exps ];

      If[ MemberQ[ l, -1],
	  -1,
	  If[ Length[ Union[l]] == 1,
	      First[l],
	      (Print[
		"ERROR: Dimensions not compatible in CASE statement :"];
	       ashow[ tree, sys[[2]] ];
	       Print["        Respective dimensions are ",l]; Print[" "];
	       -1 )
	      ]
	]
    ]


(*---------------------------------------------------------------------*)
(* expCase -- local function to find the domain of case statements  *)

expCase[ sys:_system, 
	 case[{exp_, exps__}], 
	 full:_case] :=
Module[ {tmp1, tmp2, tmp3},
  expEmpflg = False;  (* reset the "empty expression" flag *)
  (* Compute expression domain of first branch *)
  tmp1 = expDomain1[sys,exp];

  (* Compute expression of remaining branches *)
  tmp2 = expCase[sys, case[{exps}], full];

  (* Compute intersection of branches *)
  tmp3 = DomIntersection[tmp1, tmp2];

  (* Compute intersection of branches *)

  (* 
     I made a correction here. Indeed, it may happen that 
     the branches of the case expression overlap, although 
     there is no error... FIXIT. PQ, 11/7/2002.
     The problem is the following. In context of a full 
     equation, the case expression is implicitely restricted
     by the domain of the declaration of its lhs (in fact, it
     is even much more complicated, as it is a transformation
     of the domain of the declaration by all the surrounding
     affine expressions, restrictions, a.s.o). 

     The solution is to avoid that  the function expDomain 
     check the intersection of branches in cases. Actually, 
     this check is now done in the function getContextDomain, 
     using the option checkCase -> True. 
  *)

  (*
  If[ DomEmptyQ [ tmp3 ], (*then*) Null ,
    If[ !caseflg, 
      Print["WARNING: In case statement :"]; 
      ashow[ full, sys[[2]] 
    ];
    caseflg = True ];
    Print["domains of subexpressions overlap on  "];
    ashow[ tmp3, sys[[2]]]; Print[" "];
    (* Here, instead of throwing an error, I keep computing
       the domain of the expression *)
    (* Throw[$Failed] *)
  ];
  *)
  DomUnion[ tmp1, tmp2 ]
];

expCase[ sys_system, case[{exp_}], 
	 full_case] := 
 ( expEmpflg = False; (* reset the "empty expression" flag *)
   expDomain1[sys,exp]
 )
      

expCase[_, case[{}], full_case] := DomEmpty[0] 





(*---------------------------------------------------------------------*)
(* expDomain -- function to compute the domain of an expression
 *)

Clear[expDomain];

expDomain[exp:_String] := 
   expDomain[$result, readExp[exp, $result[[2]]]];

expDomain[pos:_List]   :=  
   expDomain[$result, getPart[$result, pos]];

expDomain[exp_]       :=   
   expDomain[$result, exp];

expDomain[sys:_system, exp_String] := 
   expDomain[sys, readExp[ exp,sys[[2]] ]];

expDomain[sys:_system, pos_List]   :=
   expDomain[sys, getPart[sys, pos]];

expDomain[sys:_system, exp_]   :=
  (expEmpflg = False;
   If[ expDimension[ sys, exp ] == -1,
       $Failed,
       Catch[ expDomain1[sys, exp ] ]
   ] );

expDomain[___] := Message[ expDomain::params];

(* expDomain1 is the function actually doing the job for expDomain. 
   The dimensions have been checked by expDimension first,
   so no need to verify them here : all the DomImage etc (should)
   work.


  Also note that the parameter domain has to be taken into account. 
  This is done by intersecting it to the domains of the leaves : 
  - either the leave is a variable, no problem
  - or the leave is a constant, of actual dimension 0 
       In this case the parameter domain has to be introduced
       when transforming this domain of dim 0 by the first 
       surrounding dependance function. The simplest way to do
       this was to perform this each time a dependance is encountered.
*)

Clear[expDomain1];

(* ...........variable *)
expDomain1[sys:_system, var[id_]] :=  
Module[{dec, dom, domp, res},
  dec = getDeclaration[sys, id];
  dom = dec[[3]];
  domp = addParameterDomain[ dom, sys[[2]]];
  expEmp[ sys, domp, var[id] ]
];

(*.....constant *)
expDomain1[_, const[_] ] := 
  DomUniverse[0];

(*.....index expression *)
expDomain1[ sys:_system, 
	    tree:index[mat_]] := 
addParameterDomain[ 
  ReplacePart[DomUniverse[Length[mat[[3]]]],mat[[3]],2],
  sys[[2]] ];


(* .......... binop *)
expDomain1[sys_system, 
	   tree:binop[op_, exp1_, exp2_] ] := 
	Block[{},
  expEmp[ sys, 
	   DomIntersection[ expDomain1[sys,exp1],
				   expDomain1[sys,exp2]  ],
	   tree]]
   

(* ........... call *)
expDomain1[sys_system, 
	   tree:call[funcname_String, args_List] ] := 
  Block[{domList, intersect},
	domList = expDomain1[sys,#]& /@ args;
	intersect = First[domList //. RuleDelayed[{d1_domain, d2_domain,
					   others:___},
					    {DomIntersection[d1, d2],
					     others}]];
	expEmp[ sys, 
		intersect,
		tree]
      ]
   


(*... unop *)
expDomain1[ sys_system, 
	    unop[_, exp_]] := 
  expDomain1[sys, exp] 


(* .............. if *)
expDomain1[ sys_system, 
	    tree:if[exp1_, exp2_, exp3_]] := 
  Block[{d1, d2, d3},
	d1 = expDomain1[sys, exp1];
	d2 = expDomain1[sys, exp2];
	d3 = expDomain1[sys, exp3];
	expEmp[ sys,
		DomIntersection[d1, DomIntersection[d2, d3]],
		tree ]
      ]


(* change *)
(*........... affine *) 
expDomain1[ sys_system, 
	    tree:affine[exp_, mat_]] := 
Block[{tmp},
	tmp = expDomain1[sys, exp];
	addParameterDomain[
		DomZPreimage[tmp,mat],
		sys[[2]] 
	]
]
     


(* ...... restrict *)
expDomain1[ sys_system, 
	    restrict[dom_domain, exp_] ] := 
  Block[ {tmp},
	 tmp = expDomain1[ sys, exp];
	 expEmp[ sys,
		 DomIntersection[dom, tmp], 
		 restrict[dom, exp] ]
       ]



(* change *)
(*.. reduce *)
(*  There might be checks to do here *)
expDomain1[ sys_system, tree:reduce[_,mat_,exp_] ] := 
  Block[{tmpdom, plist, ilist,tmp},
  	tmp = expDomain1[sys, exp];
        tmpdom = DomImage[tmp, mat];
	(* DomImage renames indices as soon as dimensions change. 
	 Here it also renames parameters, which will cause problems in \
	 other functions which use the parameter names. Therefore we \
	 have to name the parameters back to their usual value *)
	plist = If[Head[sys[[2,3,1]]]===Alpha`pol,sys[[2,2]],sys[[2,3,1,1,3]]];
	ilist = If[Head[tmpdom[[3,1]]]===Alpha`pol,tmpdom[[2]],tmpdom[[3,1,1,3]]];
	ilistok = Join[Take[ilist, Length[ilist]-Length[plist]],
		       plist];
	If[
		Head[tmpdom[[3,1]]]===Alpha`pol,
		domain[tmpdom[[1]], ilistok, tmpdom[[3]] ],
		ReplacePart[tmpdom,ilistok,{3,1,1,3}]
	]
]

(* ........ case *)
expDomain1[sys_system, exp_case] := 
  (caseflg = False;
   expEmpflg = False;
   expEmp[ sys,
	   expCase[sys, exp, exp],
	   exp ]
   )
	 
expDomain1[_, case[{}]] := DomEmpty[0] 



(* replaceByEquivExpr is a function that I (Tanguy) added to deal 
with degenerated expression , i.e. expression which have several 
normal form. For instance {i,j| i = N } A.(i,j->i-N+1,j) 
is equivalent to {i,j| i=N } A.(i,j->1,j)
Sometimes, the first expression is better, sometimes, the second one
is better. replaceByEquivExpr allows to replace one by the other. This
function is not a semantic-preserving trnsformation, the user has to
check that the semantic of the program is the same after
transformation. *)


Clear[replaceByEquivExpr]

replaceByEquivExpr::Failed="A problem occured during replacement"


replaceByEquivExpr[expr1_,expr2_]:=
  Module[{res},
	 res=replaceByEquivExpr[$result,expr1,expr2];
	 If [!MatchQ[res,system[___]],
	     Message[replaceByEquivExpr::Failed],
	     $result=res]]

replaceByEquivExpr[position1_List,expr2_]:=
  Module[{res},
	 res=replaceByEquivExpr[$result,position1,expr2];
	 If [!MatchQ[res,system[___]],
	     Message[replaceByEquivExpr::Failed],
	     $result=res]]

replaceByEquivExpr[position1_List,expr2_String]:=
  Module[{res},
	 res=replaceByEquivExpr[$result,position1,expr2];
	 If [!MatchQ[res,system[___]],
	     Message[replaceByEquivExpr::Failed],
	     $result=res]]

replaceByEquivExpr[expr1_String,expr2_String]:= 
  Module[{res},
	 res=replaceByEquivExpr[$result,expr1,expr2];
	 If [!MatchQ[res,system[___]],
	     Message[replaceByEquivExpr::Failed],
	     $result=res]]

replaceByEquivExpr[sys1_system,position1_List,expr2_String]:=
  Module[{param,e1,e2},
	 param=sys1[[2]];
	 e2=readExp[expr2,param];
	 replaceByEquivExpr[sys1,position1,e2]]

replaceByEquivExpr[sys1_system,expr1_String,expr2_String]:=
  Module[{param,e1,e2},
	 param=sys1[[2]];
	 e1=readExp[expr1,param];
	 e2=readExp[expr2,param];
	 replaceByEquivExpr[sys1,e1,e2]]

replaceByEquivExpr::exprNotFound="expression `1` not found"
replaceByEquivExpr::problemOccured = "A problem occured during replacement"

replaceByEquivExpr[sys_system,curPos_List,expr2_]:= 
  Module[{expr1,expr1Dom,contextExpr1,normExpr1,normExpr2,sysRes},
	 expr1=getPart[sys,curPos];
	 expr1Dom = expDomain[expr1];
	 contextExpr1 = 
	   DomIntersection[getContextDomain[sys,curPos],
			   expr1Dom];
	 If [False,
	     Print["Warning, the two expression seem not equivalent to me: "];
	     ashow[normExpr1];
	     Print[" and "];
	     ashow[normExpr2];
	     Print["Replacing anayway"]];
	 sysRes=ReplacePart[sys,expr2,curPos]
       ]
	 

replaceByEquivExpr[sys1_system,expr1_,expr2_]:=
  Catch[
    Module[{posExpr,sysRes,curPos},
	   posExpr=Position[sys1,expr1];
	   sysRes=sys1;
	   If [Length[posExpr]<1,
	       Message[replaceByEquivExpr::exprNotFound,expr1],
	       Do [ curPos = posExpr[[i]];
		    sysRes=replaceByEquivExpr[sysRes,curPos,expr2];
		    If [!MatchQ[sysRes,system[___]],
			Throw[$Failed]],
		    {i,1,Length[posExpr]}];
	     ];
	   sysRes]]
	 
(*---------------------------------------------------------------------*)
(* changeType                                            
changeType[syst1,\"var1\",newType] changes
the type of variable `var1' to `newType' in  `syst1', no 
typing compatibility check are done: no semantic preserving property
 (mainly used for changing integers to fixed bit widtyh integers), 
changeType[\"var1\",newType] apply on and modify $result"   *)
(*---------------------------------------------------------------------*)
changeType::varNotFound = " var `1` not found in `2` "
changeType::failed = "changeType failed: internal problem "

changeType[sys1:_system,var1:_String,type1:_]:=
  Module[{varDecl,newDecl,newSys},
	 varDecl=getDeclaration[sys1,var1];
	 If [!MatchQ[varDecl,decl[___]],
	     Message[changeType::varNotFound,var1,sys1[[1]]];
	     Return[sys1],
	     newDecl=ReplacePart[varDecl,type1,2];
	     newSys=sys1/.(varDecl->newDecl);
	     If [sys1==newSys,  
		 Message[changeType::failed]];
	     If [!MatchQ[newSys,system[___]],
		 Message[changeType::failed];
		 Return[sys1]];
	     newSys]
       ]

changeType[var1:_String,type1:_]:=
  Module[{res},
	 res=changeType[$result,var1,type1];
	 If [MatchQ[res,system[___]],
	     $result=res;
	     res,
	     $result]
       ]

changeType::wrongArg = "wrong argument for changeType: `1` "

changeType[a___]:=Message[changeType::wrongArg,Map[Head,{a}]]

(*---------------------------------------------------------------------*)
(* end of Semantics package                                            *)
(*---------------------------------------------------------------------*)

End[]

EndPackage[]
