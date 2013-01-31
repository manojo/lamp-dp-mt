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
BeginPackage["Alpha`Tables`",{"Alpha`Domlib`",
			      "Alpha`"}]

(* $Id: Tables.m,v 1.3 2009/05/22 10:24:36 quinton Exp $

   changelog:
   6/04/1993, Z. Chamski: updated wrt. the new format of documentation strings,
                          added function 'undoModif'.
   6/15/1993, Z. Chamski: added function 'lookUpFor' removed from
                          "Alpha`Pipeline`"
   5/08/1995, P. Quinton: added function 'getVariables' and 'readMat'
   6/08/1995, F. de Dinechin : removed readMat (transfered to Alpha.m
                                 and adapted to parametric Alpha)
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:36 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Tables.m,v $
	$Revision: 1.3 $
	$Log: Tables.m,v $
	Revision 1.3  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.2  2008/04/18 17:14:05  quinton
	Revision of usages done
	
	Revision 1.1.1.1  2005/03/07 15:32:12  trisset
	testing mmalpha repository
	
	Revision 1.30  2004/08/02 13:20:20  quinton
	Documentation updated for reference manual
	
	Revision 1.29  2004/03/10 17:12:17  quinton
	Added a new definition of getSystemParameters when no argument is
	give.
	
	Revision 1.28  2003/07/18 12:19:46  risset
	changes from Abhishek for Zpolyhedra
	
	Revision 1.27  2003/07/02 07:58:53  risset
	added Modifications for Zpolyhedra
	
	Revision 1.25  2002/06/07 11:53:22  quinton
	getSystemParameters and getSystemParameterDomains have been modified
	in order to have a form where $result is not always assumed.
	
	Revision 1.24  2001/09/13 16:45:20  quinton
	getSystemParameterDomain can have another argument than $result.
	
	Revision 1.23  2001/07/06 12:44:39  risset
	small changes
	
	Revision 1.22  2000/02/14 08:25:21  risset
	correct a bug in DomEqulities
	
	Revision 1.21  1999/11/28 19:47:52  quinton
	An error message added.
	
	Revision 1.20  1999/07/15 10:02:43  risset
	corrected a bug in getIndexNames
	
	Revision 1.19  1999/05/27 09:31:45  risset
	commited docs
	
	Revision 1.18  1999/05/18 16:24:30  risset
	change many packages for documentation
	
	Revision 1.17  1999/05/18 15:27:46  risset
	transfert of getSystem* form Matrix to Tables.m
	
	Revision 1.16  1999/05/10 13:14:15  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.15  1999/03/02 15:49:29  risset
	added GNU software text in each packages
	
	Revision 1.14  1998/02/19 15:36:56  risset
	corrected ChangeOfBasis.m

	Revision 1.13  1998/02/16 17:07:04  risset
	Packages pass all tests

	Revision 1.11  1997/06/26 16:02:09  fdupont
	Tables.m

	Revision 1.10  1997/06/26 14:11:54  risset
	commited Alphard.m v1

	Revision 1.9  1997/05/19 10:41:47  risset
	corrected exported bug in depedancies

	Revision 1.8  1997/04/22 10:57:26  risset
	removed some cycling dependencies between packages

	Revision 1.7  1996/06/24 13:55:11  risset
	added standard head comments for CVS



*)
Matrix::note = "Documentation revised on March 11, 2008";

Tables::usage =
"The Alpha`Tables` package contains variable and function definitions
relative to the retrieval of contextual information on nodes and 
programs.  Functions are:  
addAllParameterDomain, addParameterDomain, getDeclaration, 
getDeclarationDomain, getDefinition, getDimension, getEquation,
getUseCalls,
getIndexNames, getInputVars, getLocalVars, getOutputVars,
getVariables, getSystemName, getSystemParameters, getSystemParameterDomain,
symToString, lookUpFor, lookUpForPos, accessByPath, and undoModif.";

addAllParameterDomain::usage=
"addAllParameterDomain[sys] adds the constraints present in the 
parameter domain of system sys to each domain of the system. 
addAllParameterDomain[] does the same to $result.";

addParameterDomain::usage=
"addParameterDomain[ dom, paramdom ] adds to the constraints of dom 
the constraints on the parameters defined in paramdom. For internal use 
mostly."

addParameterDomain::DimIncomp = "dimension incompatibility.";

getDeclaration::usage =
"getDeclaration[var] returns the complete declaration of
variable var in system $result or an empty list if the declaration does
not exist. getDeclaration[sys, var] returns the
declaration of var in system sys.";

getDeclarationDomain::usage = 
"getDeclarationDomain[v] returns the declaration domain of variable v 
in system $result. getDeclarationDomain[sys,v] returns the declaration domain 
of variable v in system sys";
getDeclarationDomain::params = "called with wrong parameters";

getDeclaration::NotFound = "Variable `1` not found in system.";  
getDeclaration::params = "called with wrong parameters.";

getDefinition::usage =
"getDefinition[var] returns the RHS of the equation defining variable
var or an empty list if the definition does not exist. If the variable
is defined as output of a subsystem, returns an empty list and prints 
an error message."

getDefinition::DefIsUse = "Variable `1` defined as output of system `2`"
getDefinition::NotDefined = "Variable `1` is defined nowhere"

getDimension::usage = 
"getDimension[dom] returns the dimension of the Alpha domain dom.";
getDimension::params = "wrong params";

getEquation::usage =
"getEquation[var] returns the equation defining a variable var or an 
empty list if the definition does not exist. If the variable is the
output of a subsystem, getEquation issues a warning and returns the
use statement of this subsystem."

getUseCalls::usage =
"getUseCalls[] returns the list of subsystem names that are called in system
$result.";

getEquation::EquIsUse = "Warning, variable `1` defined as output of system `2`"
getEquation::NotDefined = "Variable `1` is defined nowhere"

getIndexNames::usage =
"getIndexNames[sys, var] returns the list of index names from 
a variable's declaration. getIndexNames[var] does the same to 
$result.";

getInputVars::usage = 
"getInputVars[sys] returns the list of input variables used in system sys.
getInputVars[] does the same to $result.";

getLocalVars::usage = 
"getLocalVars[sys] returns the list of local variables used in system sys.
getLocalVars[] does the same to $result.";

getOutputVars::usage = 
"getOutputVars[sys] returns the list of Output variables used in system sys.
getOutputVars[] does the same to $result.";

getVariables::usage = 
"getVariables[sys] returns the list of variables used in system sys.
getVariables[] does the same to $result.";

getSystemName::usage = 
"getSystemName[sys] return the name of system sys. getSystemName[]
gives the name of $result."; 

getSystemParameters::usage = 
"getSystemParameters[sys] return the parameters of the system sys
(default $result)"; 

getSystemParameterDomain::usage = 
"getSystemParameterDomain[sys] return the parameters domain  of the
system sys (default $result)"; 

symToString::usage =
"symToString[symb_] Converts a symbol to string. Leaves any other object simply
evaluated. Returns the string containing its
name according in current output format."

lookUpFor::usage =
"lookUpFor[sys, position:{_Integer...}, operator_Symbol] returns the 
 smallest tree whose root is the specified by operator and which 
 contains the specified position, or an empty list if operator not found."

lookUpForPos::usage =
"lookUpForPos[sys, position:{_Integer...}, operator_Symbol] returns 
the position of the nearest occurrence of a specific operator surrounding
a specified position, or an empty list if operator not found.";

accessByPath::usage =
"accessByPath[path:{_Integer..}] extracts the part of  $result
specified by subtree position path.  accessByPath[tree_,
path:{_Integer..}] extracts the part of a tree specified by its
subtree position  specifier path";

accessByPath::note =
"Only one position can be supplied at a time, so a single tree is returned
if the position is valid (no check is done.)"

undoModif::usage =
"undoModif[] called after a program transformation undoes its effects.
Returns the program as before the last transformation."

undoModif::note =
"'undoModif' copies the contents of 'Alpha`$program' into 'Alpha`$result' so
the result of the last transformation (see description of 'Alpha`$result' and
'Alpha`$program') is reset to the result of the previous one."

Begin["`Private`"]
(* a helpful conversion: adds some conviviality *)

Clear[symToString];
symToString[s_Symbol] := ToString[s];
symToString[s_String] := s;
symToString[s_] := {};


(*******************************************************************)
(* access to a part of a tree given by a "path" (list of integers) *)
(*******************************************************************)
Clear[accessByPath];
accessByPath::params = "wrong parameters";
accessByPath::error = "error";
accessByPath[___]:=Message[accessByPath::params];
accessByPath[path:{_Integer..}] := accessByPath[Alpha`$result, path];
accessByPath[tree_, path:{_Integer..}] := 
     Check[Apply[Part, Join[{tree}, path]],Message[accessByPath::error]]


(* ************************************************************************ *)
(* some navigation required: we need to find out the expression containing a
   specific object, subject to an operator name constraint. I.e., we have to
   find the smallest subtree whose root is <operator> and which contains
   our term. The lack of backward chaining is inherent to functional
   constructs ... so the term is designed by a tree position (list of
   integers.)

   *)
(* ************************************************************************ *)

(* lookUpFor returns a tree *)

Clear[lookUpFor]

lookUpFor[root_Alpha`system,
	  path:{_Integer...},
	  operator_Symbol] :=
  If[path == {},
     {},
     With[{top = accessByPath[root, path]},
	  If[MatchQ[top, _operator],
	     top,
	     lookUpFor[root, Drop[path, -1], operator]]]]

lookUpFor[_, {}, _] := {}


(* lookUpForPos returns a _position_, i.e., a list of integers *)

Clear[lookUpForPos]

lookUpForPos[root_Alpha`system,
	     path:{_Integer...},
	     operator_Symbol] :=
  If[path == {},
     {},
     If[MatchQ[accessByPath[root, path], _operator],
	path,
	lookUpForPos[root, Drop[path, -1], operator]]]

lookUpForPos[_, {}, _] := {}
	 

(* undo the effects of the last program transformation *)
Clear[undoModif]
undoModif[] := (Alpha`$result = Alpha`$program);
undoModif[___] := Message[ undoModif::params ];


(* extract the declaration of a variable *)
Clear[getDeclaration];
(* default program *)
getDeclaration[var_String] := getDeclaration[Alpha`$result, var];
getDeclaration[{}] := {};
(* explicit program *)
getDeclaration[Alpha`system[_, _, in_, out_, loc_, _], var_String] :=
  Module[{res},
	 res=First[Cases[Union[in, out, loc], x:Alpha`decl[var, _, _]
			 -> x]];
	 If[res==={},
	     Message[getDeclaration::NotFound,var];$Failed];
	 res];
getDeclaration[{}, _] := {};
getDeclaration[_, {}] := {};
getDeclaration[___] := Message[getDeclaration::params];


(* returns the list of variables *)
Clear[getVariables];
getVariables[]:=getVariables[Alpha`$result]; (* default *)
getVariables[sys_Alpha`system]:=
  Module[{in,out,loc},
	 in = Cases[sys[[3]],Alpha`decl[name_,___]:>name]; (* get input var
							 names *)
	 out = Cases[sys[[4]],Alpha`decl[name_,___]:>name]; (* get output var
							 names *)
	 loc = Cases[sys[[5]],Alpha`decl[name_,___]:>name]; (* get local var
							 names *)
	   Union[in,out,loc]
  ] (* Module *)

(* returns the list of local variables *)
Clear[getLocalVars];
getLocalVars[]:=getLocalVars[Alpha`$result]; (* default *)
getLocalVars[sys_Alpha`system]:=
  Cases[sys[[5]],Alpha`decl[name_,___]:>name]

(* returns the list of input variables *)
Clear[getInputVars];
getInputVars[]:=getInputVars[Alpha`$result]; (* default *)
getInputVars[sys_Alpha`system]:=
  Cases[sys[[3]],Alpha`decl[name_,___]:>name]

(* returns the list of local variables *)
Clear[getOutputVars];
getOutputVars[]:=getOutputVars[Alpha`$result]; (* default *)
getOutputVars[sys_Alpha`system]:=
  Cases[sys[[4]],Alpha`decl[name_,___]:>name]


(* extract name of indices *)
Clear[getIndexNames]

(* default program *)

getIndexNames[var_String] := getIndexNames[Alpha`$result, var]
getIndexNames[{}] := {}

(* explicit program *)

getIndexNames[sys_Alpha`system , var_String] :=
  With[{decl1 = getDeclaration[sys, var]},
       If[MatchQ[decl1, Alpha`decl[_, _, Alpha`domain[_, indices_, _]]],
	  First[First[decl1[[{3},{2}]]]],
	  Print[False];
	  {}]]
getIndexNames[{}, _] := {}
getIndexNames[_, {}] := {}

(* extract the definition (RHS of equation) of a variable *)
Clear[getDefinition]

(* default program *)

getDefinition[lhs_String] := getDefinition[Alpha`$result, lhs]
getDefinition[{}] := {}

(* explicit program *)
getDefinition[alpha_, lhs_String] :=
  Block[ {matches},
	 matches = Cases[alpha, Alpha`equation[ lhs, _] , Infinity];
	 If[ matches =!= {},
	     matches[[1]][[2]],
	     (matches = Flatten [Cases[ alpha, 
					Alpha`use[id_,a_,b_,c_,outputs_] :>
					  If[ MemberQ[outputs, lhs],
					      Alpha`use[id,a,b,c,outputs], {}],
					Infinity] ];
	      If [ matches=!= {},
		   ((*Message[getDefinition::DefIsUse, lhs, matches[[1]]];*)
		    matches[[1]] ),
		   (Message[getDefinition::NotDefined, lhs]; {}) ]
	    ) ]
       ]

(* A little note by Florent : Maybe it would be better to have
   getDefinition return the definition of the variable even when it is
   output of a subsystem. We would need to inline the subsystem,
   then use getDefinition :
     ( tmp = inlineSubSystem[id, {verbose->False, 
                                  current->False, caller:>$result}];
       getDefinition[tmp, lhs] )
  I leave this modification to the ones who shall use it.
  Note that it is not as obvious as the code above, for the caller
  will probably need the information (declarations, etc) of the
  inlined system
*)

getDefinition[{}, _] := {}
getDefinition[_, {}] := {}

(* extract the complete equation of a variable *)

Clear[getEquation];

(* default program *)

getEquation[lhs_String] := getEquation[Alpha`$result, lhs]
getEquation[{}] := {}

(* explicit program *)

getEquation[alpha_, lhs_String] :=
  Block[ {matches},
	 matches = Cases[alpha, Alpha`equation[ lhs, _] , Infinity];
	 If[ matches =!= {},
	     matches[[1]],
	     (matches = Flatten [Cases[ alpha, 
					x:Alpha`use[_,_,_,_,outputs_] :>
					  If[ MemberQ[outputs, lhs],
					      x, {}],
					Infinity] ];
	      If [ matches=!= {},
		   (Message[ getEquation::EquIsUse, 
		             lhs, matches[[1]][[1]]];
		    matches[[1]]  ),
		   (Message[getEquation::NotDefined, lhs]; {}) ]
	    ) ]
       ]

getEquation[{}, _] := {}
getEquation[_, {}] := {}


Clear[getUseCalls];
getUseCalls[] := 
Catch[
  Module[ {res, x},
    getUseCalls::nosystem = "$result does not contain an Alpha system";
    If[ !MatchQ[ $result, _system], Throw[ Message[ getUseCalls::nosystem ] ] ];

    res = Cases[ $result[[6]], use[__], 2 ];
    res = Union[ Map[ #[[1]]&, res ] ];
    res

  ]
];
getUseCalls[ ___ ] := Message[ getUseCalls::params ];

Clear[getDeclarationDomain];
getDeclarationDomain::err = 
  "error while calling addParameterDomain";
getDeclarationDomain[v:_String]:=getDeclarationDomain[$result,v];
getDeclarationDomain[sys:_Alpha`system,v:_String]:=
Catch[
  Module[{d,p},
    d=getDeclaration[sys,v][[3]];
    p=sys[[2]]; (* parameter domain *)
    Check[d1=addParameterDomain[d,p],Throw[Message[getDeclarationDomain::err]]]
    ]
];
getDeclarationDomain[___]:=Message[getDeclarationDomain::params];


(*------------------------------------------------------------------*)
(*        addParameterDomain et addAllParameterDomain               *)

(* This function adds to the constraints of a domain the
   constraints on the parameters defined in the parameter domain of
   the system. The implementation is somehow intricated  : we perform
   the intersection of the domain and its parameter domain,
   therefore we have to extend the dimension of the parameter domain
   to match the dimension of the other domain. This is done thanks to
   an affine function, mostly because it is easier to build an Alpha
   affine function in Mathematica than add rays and constraints in a
   domain.
   This function is made public because it is used in Static.m 
   and SubSystems.m (among others?) . However it should be
   mostly used internally.

  addAllParameterDomain was written by Tanguy. It applies
  addParameterDomain to all the domains of a system.
*)

Clear[ addParameterDomain]

(****** change *******)
addParameterDomain[ dom_Alpha`domain, paramdom_Alpha`domain ] :=
  Block[ {dim, extfun, extpdom},
	 dim = dom[[1]] - paramdom[[1]];
	 If[ dim < 0 ,
	     (Message[ addParameterDomain::DimIncomp ];
	      $Failed ),
	     If[paramdom[[1]]===0,
		res=dom,
		(extfun = Alpha`matrix[ paramdom[[1]]+1,
				     dom[[1]]+1,
				     If[Head[dom[[3,1]]]===Alpha`pol,dom[[2]],dom[[3,1,1,3]]],
				     Array[ If[ #1+dim == #2, 1, 0]& ,
					    { paramdom[[1]]+1, dom[[1]]+1 }
					    ]
				      ];
		 extpdom = DomZPreimage[ paramdom, extfun];
		 res=DomIntersection[ extpdom, dom ]
		 )
		];
	     res
	   ]
       ]


Clear[addAllParameterDomain]

addAllParameterDomain[]:=
  Module[{temp},
	 temp=$result;
	 res=addAllParameterDomain[$result];
	 If [MatchQ[res,Alpha`system[___]],
	     $program=temp;
	     $result=res,
	     $result=temp]
       ]

addAllParameterDomain[sys1:Alpha`system[name_,paramD_Alpha`domain,___]]:=
  Module[{domPos,domPosBis},
	 domPos=Position[sys1,Alpha`domain];
	 (* remove the last '0' coeff *)
	 domPosBis=Map[Delete[#,-1] &,domPos];
	 res=Fold[ReplacePart[#1,addParameterDomain[getPart[#1,#2], paramD],#2] &,
		  sys1,
		  domPosBis];
	 res
	 ]

addAllParameterDomain::wrongP=" Wrong parameter for addAllParamaterDomain: `1`"

addAllParameterDomain[a___]:=
  Module[{},
	 Message[addAllParameterDomain::wrongP,a]
       ]


Clear[ getSystemName ]; 
getSystemName::usage = 
"getSystemName[] gives the name of $result."; 
getSystemName[] := 
If[ 
  MatchQ[ $result, system[ _String, __ ] ], 
  $result[[1]], 
  Message[ getSystemName::result ] ];
getSystemName[ ___ ] := Message[ getSystemName ::params ]; 
getSystemName::result = "Are you sure that an Alpha program was loaded?";

Clear[ getSystemParameters ]; 
getSystemParameters::usage = 
"getSystemParameters[] gives the parameters of $result."; 
getSystemParameters[ ] := getSystemParameters[ $result ];
getSystemParameters[ sys:_system ] := 
If[ 
  MatchQ[ sys, system[ _String, __ ] ], 
  sys[[2]][[2]], 
  Message[ getSystemName::result ] ];
getSystemParameters[ ___ ] := Message[ getSystemParameters::params ]; 

Clear[ getSystemParameterDomain ]; 
getSystemParameterDomain::usage = 
"getSystemParameterDomain[] gives the domain of the parameters of system $result.";
getSystemParameterDomain[ ] := getSystemParameterDomain[ $result ];
getSystemParameterDomain[ sys:_system ] := 
If[ MatchQ[ sys, _system ], getSystemParameterDomain[ sys ],
   Message[ getSystemName::result ] ];
getSystemParameterDomain[sys:_system] := 
If[ 
  MatchQ[ sys, system[ _String, __ ] ], 
  sys[[2]], 
  Message[ getSystemParameterDomain::sys ] 
];
getSystemParameterDomain[ ___ ] := Message[ getSystemParameterDomain::params ]; 
getSystemParameterDomain::sys = "parameter is not an Alpha AST";

Clear[getDimension];
getDimension[Alpha`domain[inds_,_,_]] := inds
getDimension[___] := (Message[getDimension::params];$Failed)


End[]
EndPackage[]
