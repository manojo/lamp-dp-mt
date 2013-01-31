(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR :  Florent dupont de Dinechin
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

BeginPackage["Alpha`SubSystems`", {"Alpha`Domlib`",
				   "Alpha`",
				   "Alpha`Options`",
				   "Alpha`Matrix`",
				   "Alpha`Tables`",
				   "Alpha`Semantics`",
				   "Alpha`Substitution`",
				   "Alpha`Normalization`",
				   "Alpha`CutMMA`",
				   "Alpha`ChangeOfBasis`",
                                   "Alpha`Visual`"}  ]

(* $Id: SubSystems.m,v 1.4 2009/05/22 10:24:36 quinton Exp $

   changelog:
   02/08/1995, F. de Dinechin: added expandSystem[]
   02/14/1995, F. de Dinechin: expandSystem[] works with m_use
   03/27/1995, F. de Dinechin: m_use removed, file and lib functions moved
			to Alpha.m, assignParameterValue added
   04/28/1995, F. de Dinechin: inlineSubsystem[] added (options). Added
                          proper index renaming.
   05/09/1995, P. Quinton: small usage modifs...
   02/27/1995, F. de Dinechin: replaced Print[] by Message[] in case of
   an error, so that callers (e.g. analyze) may detect the error by Check[];
  NOTE: .
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:36 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/SubSystems.m,v $
	$Revision: 1.4 $
	$Log: SubSystems.m,v $
	Revision 1.4  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.3  2008/12/29 17:42:31  quinton
	Cut replaced by CutMMA.
	
	Revision 1.2  2008/07/30 15:47:20  quinton
	Added a mute option to fixParameter.
	
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.52  2004/09/16 13:41:28  quinton
	Updated documentation
	
	Revision 1.51  2004/08/02 13:19:44  quinton
	Corrected generation of boolean expressions
	
	Revision 1.50  2004/07/12 10:51:09  quinton
	Changed the option mode of inlineAll, and set the default value of undescore as False.
	
	Revision 1.49  2004/06/16 14:57:33  risset
	switched to ZDomlib
	
	Revision 1.48  2004/04/26 08:34:13  risset
	added system File before patrice visit
	
	Revision 1.47  2003/07/18 12:52:42  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.45  2003/06/27 12:55:59  risset
	small change
	
	Revision 1.44  2003/04/18 08:33:07  risset
	added the simplifyUseInputs function
	
	Revision 1.43  2002/07/17 09:13:35  quinton
	Corrected removeIdEqus which was totally wrong... Hope it is better now.
	
	Revision 1.42  2002/07/16 12:28:07  quinton
	The function removeIdEqus was modified, and hopefully, improved. This
	function allows identity equations to be removed. An option inputEquations
	allows one to specify if input equations are concerned. An option norm
	specifies if the system has to be normalized afterwards.
	
	Revision 1.41  2002/05/28 14:35:41  quinton
	Corrections were made to removeIdEqus. If an equation has the form
	Out = X, where Out is an output variable, then variable X is removed. In
	addition, Options norm and inputEquations were added to the options of
	removeIdEqus. By default, removeIdEqus behaves as before. If norm is
	set, a normalization is done. If inputEquations is set, then, equations
	of the form X = in are treated, which was not the case before.
	
	Revision 1.40  2001/09/13 16:44:06  quinton
	fixParameter checks that the values of the parameters
	do not give an empty parameter domain, and issues an
	error message.
	
	Revision 1.38  2001/08/16 14:41:20  quinton
	Minor corrections
	
	Revision 1.37  2001/01/15 09:02:01  risset
	mise a jour
	
	Revision 1.36  2000/02/08 15:27:24  quinton
	*** empty log message ***
	
	Revision 1.35  1999/12/10 16:59:05  risset
	commited struct Sched and ZDomlib
	
	Revision 1.34  1999/07/16 13:29:35  quillere
	added topoSort
	
	Revision 1.33  1999/07/13 08:06:46  quillere
	Corrected systemDep::usage
	
	Revision 1.32  1999/07/13 08:03:06  quillere
	Added systemDep
	
	Revision 1.31  1999/07/13 07:49:38  risset
	added subSystemUsedBy
	
	Revision 1.30  1999/05/27 09:31:45  risset
	commited docs
	
	Revision 1.29  1999/05/10 13:14:15  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.28  1999/04/23 08:35:55  risset
	commited Patrice version without the controlM
	
	Revision 1.27  1999/04/12 10:24:21  quinton
	Added an option underscore to inlineAll and inlineSubsystem
	
	Revision 1.26  1999/03/02 15:49:28  risset
	added GNU software text in each packages
	
	Revision 1.25  1998/12/07 09:52:48  risset
	added function fixParameter
	
	Revision 1.24  1998/06/05 14:57:22  risset
	*** empty log message ***

	Revision 1.23  1998/04/10 08:03:22  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.22  1997/06/10 12:58:09  fdupont
	a few options added

	Revision 1.21  1997/05/19 10:41:43  risset
	corrected exported bug in depedancies

	Revision 1.20  1997/05/13 14:49:04  alpha
	modif of some usages

	Revision 1.19  1997/05/13 13:40:59  risset
	report Patrice modifs on usage

	Revision 1.18  1997/04/10 15:10:58  risset
	added Options.m ScheduleTools.m OldSchedule.m remove NewSchedule.m

	Revision 1.17  1997/04/10 09:19:57  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.16  1997/03/19 15:22:15  fdupont
	buggy contexts

	Revision 1.15  1997/03/18 16:05:49  fdupont
	added removeIdEqus

	Revision 1.14  1997/02/21 10:45:46  fdupont
	minor changes

	Revision 1.13  1997/02/12 09:57:14  fdupont
	Small bug corrected in usage

	Revision 1.12  1996/06/24 13:55:07  risset
	added standard head comments for CVS



*)

(* ===== *)
SubSystems::note = "Documentation revised on August 10, 2004";

SubSystems::note = "Bugs: test[SubSystems] fails. inlineAll should test 
that $result contains a system.";

SubSystems::usage = 
"The Alpha`SubSystems` package contains functions to operate on 
Alpha subsystems. These functions are 
assignParameterValue, assignParameterValueLib, fixParameterValue,
inlineAll, inlineSubSystem, spread, removeIdEqus, simplifyUseInputs,
substDom, subSystemUsedBy, and topoSort.";

addParameterId::usage = "function externalized for debugging purposes.";

affExtHom::usage = "function externalized for debugging purposes.";

assignParameterValue::usage =
"assignParameterValue[param,v,sys] gives the value v to the parameter
param in the Alpha system sys and returns the modified system. param
is a string, and v an integer. Default value of sys is $result.";

assignParameterValueLib::usage = "see fixParameter.";

fixParameter::usage=
"fixParameter[ param, v, systName ] assigns the value v to a parameter param
in an Alpha system of name systName and in the call to systName 
in $library. It returns the new library (list of Alpha systems) and 
modifies $library (except if $library is explicitely specified as the 
4th parameter). If the system name is ommited, the function sets the 
parameter in all the programs of $library and in $result. 
This function assumes that the parameter param has the same value 
in all called subsystems. One has also to make sure that $result is the 
top calling system of the library. When called with option recurse -> False,
fixParameter[ param, v, recurse -> False ] returns the system obtained by
setting param to value v in $result, without modifying $result nor $library.";

Options[ fixParameter ] := { mute -> False, recurse -> True };

inlineAll::usage = 
"inlineAll[options] inlines all the subsystems of system $result.
Options are rename, renameCounter, verbose, caller, library, and current.
(see Options[inLineAll] for default values)."

inliningRenameCounter::usage = 
"Variable. Holds the counter value used to avoid name conflicts 
while renaming the variables."

inlineSubsystem::usage =
"inlineSubsystem[name,options] searches the current system (see
option : caller) for a use statement of the subsystem name, and
replaces this use statement with its definition extracted from 
$library, with proper variable renaming and parameter instanciation.
Returns the modified system if no error, the caller otherwise.  Side
effect: if the \"current\" option is set, it sets $program to the
previous Alpha`$result and sets $result to the returned value.
Options are occurence, rename, renameCounter, verbose, caller, library, 
undescore, and current (default options in Options[inlineSubsystem])."

inlineSubsystem::NoSSInLib = "declaration of `1` not found in library.";
inlineSubsystem::NoSuchOcc = "occurrence `1` of `2` does not exist.";
inlineSubsystem::WrongParamNumber = "subsystem `1` has `2` parameters, `3` are assigned.";
inlineSubsystem::Stx = "Syntax is inlineSubsystem[name_String, options_:List ]"
inlineSubsystem::qv = 
"functions : getSystem
variable : inliningRenameCounter"

library::usage = 
"library is an option of inlineAll and inlineSubsystem.  
library -> list of systems (default $library) specifies the 
list of systems to search for a subsystem. When more than one 
declaration of the same system appear in the library, the first 
one is inlined.";

occurence::usage = "";

underscore::usage = 
"option of inlineSubsystem and inlineAll (Boolean). When True
(default), new identifier separator is _, whereas it is X otherwise.";

Options[ spread ] = {debug -> False};
spread::usage = 
"spread[ var, index ] replaces var in system $result by a set of
variables varI, where I is in the range of index of var. This 
function is not completed and should not be used.";

removeIdEqus::usage =
"removeIdEqus[sys] removes in sys the equations of the form A=B
as introduced for example by the inlineSubsystem and inlineAll 
transformations.\n
Warning, this function does not normalize the resulting
system, unless option norm -> True is used. removeIdEqus has
options norm, allLibrary and inputEquations.";

simplifyUseInputs::usage=
"simplifyUseInputs[sys] adds local buffer variables for each input which 
is not already a simple variable (input to a use may be any expression).
The new variable is defined on the 'real domain' of the expression: its 
context domain intersected with its use domain.";

substDom::usage = 
"substDom[ dom, extDom, paramAssign, nbparams] computes the transformation
of a domain dom in a subsystem inlining. For internal use only.";

subSystemUsedBy::usage = 
"subSystemUsedBy[sys] returns the list of names of subsystems used by 
system sys (default $result).";

topoSort::usage = 
"topoSort[lib] returns the list of system names of library 
lib, sorted in the reverse hierachical order, i.e. if a system A 
uses a system B and a system C, topoSort returns {B, C, A} or {C, B, A}";

Begin["`Private`"]

Clear[ spread ];
spread::wrgvar = "`1` is not a local var of the current system";
spread::errorProj = "error while calling DomProject"; 
spread::wrgindex = "`1` is not an index of variable `2`";
spread::domUnbounded = "projected domain appears unbounded";
spread::errorCut = "error while calling the cut function"; 
spread::errorCob = "error while calling the changeOfBasis function"; 
spread[ var:_String, indexProj:_String, opts:___Rule ]:=
Catch[
Module[{ d, dproj, dbg, indexes, varBefore, minval, maxval,
         varAfter, varRest, cob1, cob2, stIndexes, curval, stcurval,
         remIndexes, bb, c},

  (* Check that var is a local var of $result *)
  If[ !MemberQ[ getLocalVars[], var ], 
      Throw[ Message[ spread::wrgvar, var ] ], Null ]; 

  (* Get declaration domain of var *)
  Check[d = getDeclarationDomain[var], Throw[Null]];
  If[ dbg, 
    Print["Domain of variable ", var, " is ", show[d, silent->True]],Null];

  (* Project *)
  Check[ dproj = DomProject[d,{indexProj}], 
         Throw[ Message[ spread::errorProj ] ] ];

  (* Check domain in bounded *)
  Check[ bb = getBoundingBox[ dproj, {}, 1 ], 
         Throw[ Message[ spread::errorbb ] ] ];
  If[ dbg, Print[ "Enclosing box is: ", bb ], Null ];
  {{ minval, maxval }} = bb;

  If[ minval == -Infinity || maxval == Infinity, 
      Throw[ Message[ spread::domUnbounded ] ], Null ];

  indexes = If[Head[d[[3,1]]]===Alpha`pol,d[[2]],d[[3,1,1,3]]];

  (* Check that index is an index of var *)
  If[ !MemberQ[ indexes, indexProj ], 
      Throw[ Message[ spread::wrgindex , indexProj, var ] ], Null ];

  stIndexes = StringDrop[ToString[indexes],-1]<>"|";
  If[ dbg, 
    Print["Projected domain is ", show[dproj, silent->True]],Null];

  varRest = var; 
  remIndexes = Complement[indexes,{indexProj}];

  If[ dbg, Print[ indexes]; Print[remIndexes ], Null ];

  For[ curval = maxval, curval > minval, curval--,
    stcurval = ToString[curval];
    varBefore = varRest;
    varAfter = var<>stcurval;
    varRest = varAfter<>"rest";

    Check[
      cut[ varBefore,
         stIndexes<>ToString[indexProj]<>"="<>stcurval<>"}",
         varAfter,
         If[ curval == minval+1, var<>ToString[curval-1], varRest ]
       ], 
    Throw[ Message[ spread::errorCut ] ] ];
 
    cob1 = varAfter<>
          ".("<>StringTake[ToString[indexes],{2,-2}]<>
          "->"<>
          StringTake[ToString[remIndexes],{2,-2}]<>")";
    If[ dbg, Print["Calling cob[ "<>cob1<>" ,"<>
                   ToString[remIndexes]<>" ]"], Null ];
    Check[
      changeOfBasis[ cob1, remIndexes ], 
      Throw[ Message[ spread::errorCob ] ] 
    ];
  ]; (* For *)

  cob1 = var<>ToString[curval]<>
        ".("<>StringTake[ToString[indexes],{2,-2}]<>
        "->"<>
        StringTake[ToString[remIndexes],{2,-2}]<>")";
  Check[
    changeOfBasis[ cob1, remIndexes ], 
    Throw[ Message[ spread::errorCob ] ] 
  ];

  normalize[];
];
]; (* Catch *)
spread[___] := Message[ spread::wrgparams ];
spread::wrgparams = "spread called with wrong parameters";

substDom::usage = "substDom[ dom_Alpha`domain,
extensionDom_Alpha`domain, parameterAssignation_Alpha`matrix, 
numberOfSubSystemParameters_Integer]\n
Function. Computes the transformation of a domain
in a subsystem inlining. For internal use only"

(*  Subsystem expansion  *)


(*--------------------------------*)
(* Functions to avoid name conflicts *)

inliningRenameCounter = 1;

Clear[buildIdList]

buildIdList[Alpha`system[ sysName_String, 
			  paramSpace_Alpha`domain,
			  inVars_List,
			  outVars_List,
			  localVars_List, 
			  equations_List] ] :=
  Join[ {sysName},
	Map [ Function[x, x[[1]] ], inVars ],
	Map [ Function[x, x[[1]] ], outVars ],
	Map [ Function[x, x[[1]] ], localVars ] ]

buildIdList[___] := ( Print["Problem in buildIdList\n"]; 
		   $Failed )


(*--------------------------------*)

Clear[isUse]

isUse[id_String, Alpha`equation[lhs_String, exp_] ] := False

isUse[id_String, Alpha`use[name_String, extDomain_, pAss_, arg_List,
			   retVar_List] ]   := 
                 id == name


isUse[___] := ( Print["Problem in isUse\n"]; 
		   $Failed )




(*--------------------------------*)
(* splitEquList returns two lists :
     the equation before the occ-th use, and
     the equations after it.  *)

Clear[splitEquList]

splitEquList[id_String, {equs1_List,{}}, occ_Integer] := (
   Print["Error : Bug in finUse2"]; 
   {equs1, {}}
   )

splitEquList[id_String, {equs1_List, equs2_List}, occ_Integer] :=
  If[ isUse[id, First[equs2]] ,
      If [ occ==1, 
	   {equs1, Rest[equs2]},
	   splitEquList[id, {Append[equs1, First[equs2]], Rest[equs2]}, occ-1]
	 ],
      splitEquList[id, {Append[equs1, First[equs2]], Rest[equs2]}, occ]
    ]

splitEquList[____] := (Print["Problem in SubSystems`splitEquList"]; 
		   $Failed )









(*---------------left homomorphic extension of affine function-----------*)
(* Example : 
     fun = (k,N->f1,f2) 
     ind = {i,j}
     affExtHom returns (i,j,k,N -> i,j,f1,f2)
*)


Clear[addColumns]

addColumns[mat_List, size_Integer] :=
 Transpose[ Join[ Array[If[#1==#2, 0, 0] &, {size, Length[mat]}],
		  Transpose[mat]] ]
  
addColumns[___] := ( Print["Problem in addColumns\n"]; 
		   $Failed )

Clear[matExtHom]
(* change for rational matrices: If[#1==#2 then Last[Last[mat]] not 1 *)

matExtHom[mat_List, size_Integer] := 
  Join[ Array[ If[#1==#2, Last[Last[mat]], 0]& , 
	       {size, size+Length[mat[[1]]]} ], 
        addColumns[mat, size]
      ]
 

matExtHom[___] := ( Print["Problem in matExtHom\n"]; 
		   $Failed )

Clear[affExtHom]
(* no change required *)

affExtHom[fun_Alpha`matrix, ind_List] := 
  Block[ {indices, counter},
	 indices = ind;
	 counter = 1;
	 While[ Length[ Union[indices, fun[[3]] ] ] 
		   < Length[ Join[indices, fun[[3]]] ],
		(indices = Map[ Function[ x, x<>"_"<>ToString[counter] ],
				indices];
		 counter = counter+1
		 )
	      ];
	 Alpha`matrix[ fun[[1]] + Length[indices],
		       fun[[2]] + Length[indices],
		       Join[indices, fun[[3]]],
		       matExtHom[ fun[[4]], Length[indices] ]
		     ]
       ]


affExtHom[___] := ( Print["Problem in affExtHom\n"]; 
		   $Failed )






(*---------------Left homomorphic extension of domain-----------*)
(* Example : 
     dom = {N|...}
     indices = {i,j}
     returns {i,j,N |...}
*)

Clear[domExtHom]

domExtHom[dom_Alpha`domain, ind_List] := 
  Block[ {indices, counter,domidlst,mat},
	 indices = ind;
	 counter = 1;
	 domidlst = If[Head[dom[[3,1]]]===Alpha`pol,dom[[2]],dom[[3,1,1,3]]];
	 While[ Length[ Union[indices, domidlst ] ] 
                   < Length[ Join[indices, domidlst] ],
		(indices = Map[ Function[ x, x<>"_"<>ToString[counter] ],
				indices];
		 counter = counter+1
		 )
	      ];
	 mat = Alpha`matrix[ dom[[1]]+1,dom[[1]] + Length[indices]+1,Join[ indices, dom[[2]] ],
	 			Array[ If[ #2==#1+Length[indices], 1, 0]&,{ dom[[1]]+1,dom[[1]] + Length[indices]+1}]
			];
	 DomZPreimage[dom,mat]
       ]

domExtHom[___] := ( Print["Problem in domExtHom\n"]; 
		   $Failed )
	  
	




(*----------------Parameter substitution in a domain----------------*)
(* in the following, Drop[dom[[2]], -pDimSub] gives the list of 
   "intrinsic" indices of the domain dom, that is the indices which
   are not parameters. For a domain dom of the subsystem 
   of "intrinsic" dimension n,
   the domain dom' appearing in the caller after inlining is :

   dom' = Preimage(dom, Ext(pAssgn, n)) inter Ext(extDomain, n)
   
   where Ext(f,n) (resp Ext(D,n) ) is the leftmost homomorphic
   extension of the affine function f (resp domain D). 

   Notice that we perform a right homomorphic extension of D, but that
   we therefore need a left homomorphic extension of f...
   See the paper about Alpha structuration for more details  *)

Clear[substDom]

substDom[dom_, extDomain_, pAssgn_, pDimSub_Integer] :=
Block[{tmp,mat,idlst},
	idlst = If[Head[dom[[3,1]]]===Alpha`pol,Drop[dom[[2]],-pDimSub],Drop[dom[[3,1,1,3]],-pDimSub]];
	mat = affExtHom[pAssgn,idlst];
	tmp = DomZPreimage[dom,mat];
	DomIntersection[tmp,domExtHom[ extDomain,idlst]]
]

substDom[___] := ( Print["Problem in substDom\n"]; 
		   $Failed )






(*-----------Parameter substitution in an affine function-----------*)

(* there are two functions, one for the dependancies appearing
   in expressions (substDep), 
   the other one for the parameter assignations appearing in a 
   use statement within the subsystems (substPAssign).
   (They don't have exactly the same pattern in the AST 
   with respect to the parameters) 

   See their respective comments for an explanation of their 
   behaviour*)


(* Some small useful functions *)

Clear[removeParameterId]

removeParameterId[mat_Alpha`matrix, nbParams_Integer] :=
  Alpha`matrix[ mat[[1]]-nbParams, mat[[2]], mat[[3]], 
	        Append[Drop[mat[[4]], -nbParams-1], Last[mat[[4]]]]
	      ]

removeParameterId[___] := ( Print["Problem in removeParameterId\n"]; 
		   $Failed )

Clear[addParameterId]

addParameterId[mat_Alpha`matrix, nbParams_Integer] :=
  Alpha`matrix[ mat[[1]]+nbParams, mat[[2]], mat[[3]], 
	        Join[ Drop[mat[[4]], -1] ,
		      Array[ If[#1+Length[mat[[3]]]-nbParams ==#2, Last[Last[mat[[4]]]], 0]& , 
			     {nbParams+1, Length[mat[[4]][[1]]]} ]
		    ]
	      ]

addParameterId[___] := ( Print["Problem in addParameterId\n"]; 
		   $Failed )


(* substDep transforms a dependancy function appearing in a subsystem
   into the corresponding dependancy in the inlined equations.
   In the following code, Drop[ dep[[3]], -pDimSub ] is the list
   of "intrinsic" indexes of the dependancy, that is indexes that are
   not parameters.
   Two cases : 
       either dep is a void function (i1,i2... in, P1,..Pp -> ) of "intrinsic"
       dimension n ( as usually used along with constants : 0.(i,j->) )
       In this case, the function dep' to be inlined is  
         dep' = dep o Ext(pAssgn,n)

       or dep is a non-void function, in which case it carries a parameter
       identity : (i1,i2... in, P1,..Pp -> f1,f2,...fm, P1,..Pp ) 
       In this case we first remove the parameter identity to get
          (i1,i2... in, P1,..Pp -> f1,f2,...fm), 
       which we compose with Ext(pAssgn, n), the _left_ homomorphic
       extension of pAssgn (pAssgn was (e1,..er, S1,..Ss->P1,..Pp)
       so Ext(pAssgn, n) is (... ->i1,..in,P1,..Pp) which is of the
       right dimension), 
       then we add the parameter identity for the indices of the
       extension domain and for the parameters of the caller.
*)

Clear[substDep];
  
substDep[dep_Alpha`matrix, pAssgn_Alpha`matrix, pDimSub_Integer] :=
Module[{r,s,t},
  If[ dep[[1]]==1, (* functions like (i,j->) : no parameter identity *)
(* === 
Print["No parameter identiy..."];
Print["dep"];
Print[dep];
Print["pAssign"];
Print[pAssgn];
Print["pDimSub"];
Print[pDimSub];
r = affExtHom[ pAssgn, Drop[ dep[[3]], -pDimSub ] ];
Print["affExtHom"];
ashow[r];
*)
    composeAffines[ dep,
      affExtHom[ pAssgn, Drop[ dep[[3]], -pDimSub ] ]
    ],
(* *********************
Print["There is a parameter identiy..."];
Print["dep"];
Print[dep];
Print["pAssign"];
Print[pAssgn];
Print["pDimSub"];
Print[pDimSub];
r = affExtHom[ pAssgn, Drop[ dep[[3]], -pDimSub ] ];
Print["affExtHom"];
ashow[r];
s=removeParameterId[ dep, pDimSub];
Print["removed: ", s];
t=composeAffines[ s, r ];
Print["composed: ", t];     
r=
*)
    addParameterId[ 
      composeAffines[ removeParameterId[ dep, pDimSub],
        affExtHom[ pAssgn, Drop[ dep[[3]], -pDimSub ] ] 
      ],
      Length[ pAssgn[[3]] ]  
    ]
(*
Print["result: ",r]; r
*)
  ]
];
substDep[_,_,_] := ( Print["Problem in substDep\n"]; 
		   $Failed )




(*  Parameter assignations are affine function, too, but they 
    don't carry the parameter identity like dependance functions,
    and thus aren't expanded the same way*)  

Clear[substPAssgn];
  
substPAssgn[dep_Alpha`matrix, pAssgn_Alpha`matrix, pDimSub_Integer] :=
   composeAffines[ dep,
		   affExtHom[pAssgn, 
			     Drop[ dep[[3]], -pDimSub ]
			   ] 
		 ];

substPAssgn[_,_,_] := ( Print["Problem in substPAssign\n"]; 
		   $Failed )
			  





(*-----------Parameter substitution in declarations-----------*)

(*     (Simply call substDom on the declaration domain)       *)


Clear[substDecl];

substDecl[decla_, ext_String, callerDecls_List, 
	  extDomain_, pAssgn_, pDimSub_Integer, verbose_] :=
  Alpha`decl[ If [ MemberQ[ callerDecls, decla[[1]] ],
		   (If[verbose,
		       Print[ "    Renaming variable ",decla[[1]],
			      " to ", decla[[1]]<>ext ],
		       Null];
		    decla[[1]]<>ext),
		   decla[[1]] ], (*name*)
		decla[[2]] ,       (* type *)
	      substDom[ decla[[3]], extDomain, pAssgn, pDimSub]  (* domain *)
	    ]

substDecl[___] := ( Print["Problem in substDecl\n"]; 
		   $Failed )
	         

Clear[substDecls]

substDecls[{}, ext_String, callerDecls_List, 
	   extDomain_Alpha`domain, pAssgn_Alpha`matrix,
	   pDimSub_Integer, verbose_] := {}

substDecls[decls_List, ext_String, callerDecls_List, 
	   extDomain_Alpha`domain, pAssgn_Alpha`matrix, 
	   pDimSub_Integer, verbose_] := 
  Prepend[ substDecls[ Rest[decls], ext, callerDecls, 
		       extDomain, pAssgn, pDimSub, verbose],
	   substDecl[ First[decls], ext, callerDecls, 
		      extDomain, pAssgn, pDimSub, verbose]
      ]

substDecls[___] := ( Print["Problem in substDecls\n"]; 
		   $Failed )






(*-----------Parameter substitution in expressions-----------*)

Clear[substExpr];

substExpr[v_Alpha`var, 
	  ext_String, callerIds_List, extDomain_Alpha`domain, 
	  pAssgn_Alpha`matrix, pDimSub_Integer] := 
(
(* =========
  Print["v: ", v];
*)
  If [ MemberQ[ callerIds, v[[1]] ],
       Alpha`var[ v[[1]]<>ext ],
       v  ]
);
substExpr[d_Alpha`domain, 
	  ext_String, callerIds_List, extDomain_Alpha`domain, 
	  pAssgn_Alpha`matrix, pDimSub_Integer] := 
  substDom[ d, extDomain, pAssgn, pDimSub];

substExpr[d_Alpha`matrix, 
	  ext_String, callerIds_List, extDomain_Alpha`domain, 
	  pAssgn_Alpha`matrix, pDimSub_Integer] := 
(
(* ==== *)
(*
ashow[d];Print[ext];ashow[extDomain];ashow[pAssgn];
*)
Module[{r},
  r = substDep[ d, pAssgn, pDimSub]; 
(*
  Print["Substituted matrix: ", r]; ashow[r];
*)
  r
]
)
substExpr[d_, ext_String, callerIds_List, extDomain_Alpha`domain, 
	  pAssgn_Alpha`matrix, pDimSub_Integer] := 
(
(* =======
Switch[d,
 affine[_,_],Print["Expression is: ", d]
    ];
*)
d);

substExpr[___] := ( Print["Problem in substExpr\n"]; 
		   $Failed )





(*-----------Parameter substitution in equations-----------*)
Clear[substEqus];

substEqus[ 
  equs_List, ext_String, callerIds_List, extDomain_Alpha`domain, 
  pAssgn_Alpha`matrix, pDimSub_Integer] :=
  equs   /.   
   {
    (* Rule for standard equations *)
    Alpha`equation[varname_String, exp_] :>
(
(* ==== *)
(*
Print["varname: ", varname, exp];
*)
      (* If the lhs belongs to the caller *)
      If[ MemberQ[callerIds, varname],
          Alpha`equation[varname<>ext, 
            MapAll[ 
              substExpr[ #, ext, callerIds, extDomain, pAssgn, pDimSub]&,
            exp]
          ],
          Alpha`equation[varname, 
            MapAll[ substExpr[#, ext, callerIds, extDomain, pAssgn, pDimSub]&,
            exp]
          ]
      ])
      ,
    (* Rule for use statements *)
    Alpha`use[name_String, subExtDom_Alpha`domain, 
      subpAssgn_Alpha`matrix, inputs_List, outputs_List] :>
      Alpha`use[name, 
        substDom[ subExtDom, extDomain, pAssgn, pDimSub],
        substPAssgn[ subpAssgn, pAssgn, pDimSub],
        MapAll[ substExpr[ #, ext, callerIds, extDomain, pAssgn, pDimSub]&,
          inputs
        ],
        Map[ 
          If[ MemberQ[callerIds, #], #<>ext, # ]&,
          outputs 
        ]
      ]
};

substEqus[___] := ( Print["Problem in substEqus\n"]; 
		   $Failed )




(*----------Processing the inputs of the subsystem--------------*)

Clear[inputEqus]

inputEqus[{}, {}, ext_String, callerIds_List] := {}

inputEqus[{}, exps_List, ext_String, callerIds_List] := 
  ( Print["expandSubSystem : not the same number of declared and actual inputs"];
    $Failed )

inputEqus[decls_List, {}, ext_String, callerIds_List] := 
  ( Print["expandSubSystem : not the same number of declared and actual inputs"];
    $Failed )

inputEqus[decls_List, exps_List, ext_String, callerIds_List] :=
  Prepend[ inputEqus[ Rest[decls], Rest[exps] , ext, callerIds],
           If [ MemberQ[ callerIds, First[decls][[1]] ],
		Alpha`equation[ (First[decls][[1]])<>ext ,
				First[exps] ] ,
		Alpha`equation[ First[decls][[1]], First[exps] ]
	      ]
	 ]

inputEqus[___] := 
  ( Print["Problem in inputEqus"];
    $Failed )







(*----------Processing the outputs of the subsystem--------------*)

Clear[outputEqus]

outputEqus[{}, {}, ext_String, callerIds_List] := {}

outputEqus[{}, retvars_List, ext_String, callerIds_List] :=
 ( Print["expandSubSystem : not the same number of declared and actual outputs"];
   $Failed )

outputEqus[decls_List, {}, ext_String, callerIds_List] :=
 ( Print["expandSubSystem : not the same number of declared and actual outputs"];
   $Failed )


outputEqus[decls_List, retvars_List, ext_String, callerIds_List] :=
  Prepend[ outputEqus[ Rest[decls], Rest[retvars] , ext, callerIds] ,
           If [ MemberQ[ callerIds, First[decls][[1]] ],
		Alpha`equation[ First[retvars], 
			   Alpha`var[ (First[decls][[1]])<>ext ] ],
		Alpha`equation[ First[retvars], 
			   Alpha`var[ First[decls][[1]] ] ]
	      ] 
	 ]

outputEqus[___] := 
   ( Print["Problem in outputEqus"];
     $Failed )
 





(*------------------Main inlining function--------------*)

(* Oh I regret I didn't know Catch and Throw for error handling 
   when I wrote it! *)
       
Clear[doInlineSS];

doInlineSS[ name_String, opts:(_Rule|_RuleDelayed)... ] :=
Catch[
  Module[ 
    {matches, ss, error, useNode, equsBeforeUse,equsAfterUse,
     expString,subParams,callerParams,extDomain,paramAssign,newLoc,
     callerIdList,subIdList,newEqus,vrb, occ, cal, lib, 
     ren, und, counterv},
    (* Get options *)
    occ = occurence/.{opts}/.Options[inlineSubsystem];
    cal = caller/.{opts}/.Options[inlineSubsystem];
    lib = library/.{opts}/.Options[inlineSubsystem];
    ren = rename/.{opts}/.Options[inlineSubsystem];
    und = underscore/.{opts}/.Options[inlineSubsystem];
    vrb = verbose/.{opts}/.Options[inlineSubsystem];
    counterv = renameCounter/.{opts}/.Options[inlineSubsystem];

    (* First, verify that the subsystem is there, that it is
      there only once (otherwise issue a warning) *)
    If[ dbg, Print["underscore option is: ", und] ];
    error = False;
    matches = Cases[lib, Alpha`system[name, _,_,_,_,_]];
    If[ Length[matches]!=1, 
      If [ Length[matches] >1,
        Print["Warning : more than one declarations of ",
			name, " in library."],
        (Message[ inlineSubsystem::NoSSInLib, name];
        error = True) 
      ]
    ];

    If[ error, (Print["Aborting inlining."];$Failed ),
      (
       ss = matches[[1]];
       (* now ss holds the subsystem extracted from the library*)
       matches = Cases[ cal[[6]], (* the equations *)
			       Alpha`use[name,_,_,_,_] ];
       If[ Length[matches]<occ ,
	  (Message[ inlineSubsystem::NoSuchOcc, occ, name];
	   Print["Aborting inlining."];
	   $Failed),
	  (
	   (* now we're sure that this occurence exists. *)
	   useNode = matches[[occ]];
	   {equsBeforeUse, equsAfterUse} =
	   splitEquList[name, 
			{{},cal[[6]]},
			occ];
          (* Get the subsystem's parameters *)
	   subParams = ss[[2]]; 
          (* Get the caller's parameters *)
	   callerParams = cal[[2]];
          (* Extension domain *)
	   extDomain = useNode[[2]];
          (* Parameters' assignment *)
          paramAssign = useNode[[3]];
          If[ subParams[[1]] != paramAssign[[1]]-1,
            (* check parameter assignation dimensions *)
            (Message[ inlineSubsystem::WrongParamNumber,
             name, subParams[[1]], paramAssign[[1]]-1];
             Print["Aborting inlining."];
            $Failed),
            (* else we can try to inline *)
            (If[ vrb,
               Print["  Expanding occurence #", occ, 
               " of subsystem ", name, 
               " in system ", cal[[1]] ]];
            (* The following handles conflictless renaming *)
            callerIdList = buildIdList[cal];
            subIdList = buildIdList[ss];
            If[ Length[ Union[ subIdList, callerIdList] ]
              < Length[ Join[ subIdList, callerIdList ]],
            inliningRenameCounter = 
            Max[ inliningRenameCounter, counterv +1]
	    (* else there won't be any renaming *)
            ];
            If[ ren, callerIdList = Union[ subIdList, callerIdList ] 
            ];  (* This forces variable renaming *)		
            (* If underscore option is not set (default) 
	       intermediate character is X, otherwise it is 
	       an underscore *)
            If[ und, 
              expString = "_"<>name<>ToString[counterv],
              expString = "X"<>name<>ToString[counterv]
            ];
            If[ vrb, Print[ expString ] ];
            newLoc = 
	      Join[
                cal[[5]], 
                substDecls[ ss[[3]], expString, callerIdList, extDomain, 
                  paramAssign, subParams[[1]], vrb]
              ,   
                substDecls[ ss[[4]], expString, callerIdList, extDomain, 
                  paramAssign, subParams[[1]], vrb
                ]
              ,   
                substDecls[ ss[[5]], expString, callerIdList, extDomain, 
                  paramAssign, subParams[[1]], vrb
                ] 
            ];
(* ========= *)
(*
Global`$xxx = 
  substEqus[ss[[6]], expString, callerIdList, extDomain, 
          paramAssign, subParams[[1]]];
*)
            newEqus = 
              Join[
                equsBeforeUse, 
                inputEqus[ss[[3]], useNode[[4]], expString, callerIdList
                ]
              ,
                substEqus[ss[[6]], expString, callerIdList, extDomain, 
                  paramAssign, subParams[[1]] 
                 ]
              ,
                outputEqus[ ss[[4]], useNode[[5]], expString, callerIdList ]
              ,
              equsAfterUse
            ];
(* ========= *)
(*
Print["New equations: ", ashow[newEqus, silent->True] ];
*)
			Alpha`system[ cal[[1]], cal[[2]], cal[[3]],
				      cal[[4]], newLoc, newEqus ]
        ) ]
      ) ]
    ) ]
  ]
];


doInlineSS[____] :=
   ( Print["Problem in SubSystems`doInlineSS"];
     $Failed )
 


(*-----------------------------------------------------------------*)


Clear[swapProgramResult]

swapProgramResult[sys_Alpha`system] :=
  (
   Alpha`$program = Alpha`$result;
   Alpha`$result = sys;
   sys
   )
swapProgramResult[$Failed] := $Failed

swapProgramResult[___] := 
  ( Print["Problem in SubSystems`swapProgramResult"];
   $Failed )



Clear[inlineSubsystem];

Options[inlineSubsystem] = {occurence -> 1,
                            underscore -> False,
			    rename -> False, 
			    verbose -> False,
			    renameCounter :>inliningRenameCounter,
			    caller :> Alpha`$result,
			    library :> Alpha`$library,
			    current ->True};

inlineSubsystem[ name_String, options:(_Rule|_RuleDelayed)... ] := 
Module[ {inlined},
  inlined = 
    doInlineSS[ name, options ];
    If[ current/.{options}/.Options[inlineSubsystem],
      swapProgramResult[inlined] ];
 inlined
]; 

inlineSubsystem[x:___] := 
 (Message[ inlineSubsystem::Stx ];Print["\n",FullForm[{x}]];
  $Failed )

(*-----------------------------------------------------------------*)
(*   expandSubSystem, for compatibility  *)

Clear[expandSubSystem]

expandSubSystem[systemId_String, occ_Integer, "norename"] :=  
  Block[ {inlined},
	 inlined = inlineSubsystem[systemId, rename->False, occurence->occ];
	 swapProgramResult[inlined]
       ]

expandSubSystem[systemId_String, occ_Integer] :=  
  Block[ {inlined},
	 inlined = inlineSubsystem[systemId, 
				   rename->True, occurence->occ];
	 swapProgramResult[inlined]
       ]

expandSubSystem[___] := 
   ( Print
   ["ERROR : Syntax is expandSubSystem[name_String, occ_Integer]"];
    Print
   ["               or expandSubSystem[name_String, occ_Integer, \"norename\"]"];
                    $Failed )







(*--------------------------------------------------------------*)
(*   inlineAll recursively inlines all the subsystems appearing 
     in the system.*)

Clear[inlineAll];

Options[inlineAll] = {rename -> False, 
                      underscore -> False,
		      verbose -> False,
		      renameCounter ->1,
		      caller :> Alpha`$result,
		      library :> Alpha`$library,
                      exceptions -> {},
		      current ->True};

inlineAll[options:___Rule] := 
Module[
  {expanded, counter, ren, verb, lib, underS, ex, caseLoc},

  expanded = caller/.{options}/.Options[inlineAll];
  lib = library/.{options}/.Options[inlineAll];
  ren = rename/.{options}/.Options[inlineAll];
  underS = underscore/.{options}/.Options[inlineAll];
  verb = verbose/.{options}/.Options[inlineAll];
  counter = renameCounter/.{options}/.Options[inlineAll];
  ex = exceptions/.{options}/.Options[inlineAll];

  (* Recursion, while there are use occurences in the 
     caller. We expand all systems but those whose name belongs
     to the exception list *)
  While[ 
    caseLoc = 
      Select[ expanded[[6]], 
        Function[{x}, 
	  MatchQ[x, use[ (n:_String)/;!MemberQ[ex,n], _,_,_,_ ] ] ]
      ];
    caseLoc!={},
    expanded = inlineSubsystem[
      caseLoc [[1,1]],
      caller :> expanded,
      library -> lib, 
      underscore -> underS, 
      rename -> ren, 
      verbose -> verb,
      renameCounter->counter++,
      exceptions->ex,
      current -> False 
    ]
  ];
  If[ current/.{options}/.Options[inlineAll],
      swapProgramResult[expanded] ];
  expanded
];
inline[___] := Message[ inline::params ];


(*--------------------------------------------------------*)
(*Parameter instantiation*)
Clear[addCstLine]

addCstLine[ mat_List, ident_String, value_Integer, idList_List] :=
  If [ First[idList] == ident,
       Prepend[ mat,
		value * Last[mat] ] ,
       Prepend[ addCstLine[ Rest[mat], ident, value, Rest[idList] ],
		First[mat] ]
     ]

addCstLine[___] :=  ( Print["Problem in addCstLine"]; 
			       $Failed)

    

Clear[removeFromIdList]

removeFromIdList[ident_String, {}] :=  
    ( Print["ERROR : Subsystems`removeFromIdList : ", 
	    ident, " not found."]; 
     {})

removeFromIdList[ident_String, idList_List] :=
  If[ ident == First[idList],
      Rest[idList],
      Prepend[ removeFromIdList[ident, Rest[idList]], 
	       First[idList]]
    ]

removeFromIdList[___] :=  ( Print["Problem in Subsystems`removeFromIdList"]; 
			       $Failed)

Clear[buildPAssign]

buildPAssign[ident_String, value_Integer, idList_List] :=
  Alpha`matrix[ Length[idList]+1, 
		Length[ idList],
		removeFromIdList[ident, idList],
		addCstLine[ IdentityMatrix[Length[idList]], 
			    ident,
			    value,
			    idList ]
	      ]

buildPAssign[___] :=  ( Print["Problem in buildPAssign"]; 
			       $Failed)


Clear[assParValExpr]

assParValExpr[ expr_,  parAssgn_Alpha`matrix, parDomDim_Integer] :=
	  expr /. { Alpha`domain[dim_Integer, ids_List, pols_List]  :>  
		      DomZPreimage[ 
			Alpha`domain[dim, ids, pols],
			affExtHom[ parAssgn, 
				   Drop[If[Head[pols[[1]]]===Alpha`pol ,ids,zpols[[1,1,3]]], -parDomDim ]
				 ]
		      ]
		   ,
		    Alpha`matrix[ rows_Integer, cols_Integer,
				  ids_List, mat_List ] :>
		      substDep[ Alpha`matrix[ rows, cols, ids, mat ],
				parAssgn, 
				parDomDim
			      ]
		   }

Clear[assignParameterValue];

assignParameterValue[ident_String, value_Integer, syst_Alpha`system]:=
  assignParameterValue[syst,ident,value];

assignParameterValue[syst_Alpha`system,ident_String,value_Integer] :=
  Module[{parAssgn,parRank,params,paramlist},
    paramlist = If[Head[syst[[2,3,1]]]===Alpha`pol, syst[[2,2]], syst[[2,3,1,1,3]]];
    If[ MemberQ[ paramlist, ident ] ,
      parAssgn = buildPAssign[ident, value, paramlist ];
      res= syst /. {Alpha`domain[ dim_Integer, ids_List, pols_List]  :>  
		    assParValExpr[ Alpha`domain[ dim, ids, pols], 
				   parAssgn, 
				   syst[[2]][[1]]  ]
                   ,
                   Alpha`domain[dim_Integer, {}, zpols_List]  :>
                     assParValExpr[Alpha`domain[dim, {}, zpols],
				   parAssgn,
				   syst[[2]][[1]]  ]
                   ,
		    Alpha`equation[ id_String, expr_] :>
		    Alpha`equation[ id, 
				    assParValExpr[ expr, 
						   parAssgn, 
						   syst[[2]][[1]]  ]
				  ]
                   ,
		    Alpha`use[ id_String, extDom_Alpha`domain, 
			       params_Alpha`matrix, inputs_List,
			       outputs_List] :>
		    Alpha`use[ id, 
			       DomZPreimage[
				 extDom, 
				 affExtHom[ parAssgn, 
					    Drop[ If[Head[extDom[[3,1]]]===Alpha`pol,extDom[[2]],extDom[[3,1,1,3]]], 
						  -syst[[2]][[1]] ]
					  ]
			       ], 
                    substPAssgn[ 
                      params, 
                      parAssgn, 
                      syst[[2]][[1]] 
                               ], 
                    assParValExpr[ inputs, 
                                   parAssgn, 
                                   syst[[2]][[1]]  
                                 ], 
                    outputs
		       ]
		    }
	      ,
	      Message[assignParameterValue::notParameter,ident];
	    ];

    (* Issue a message if the parameter domain is empty *)
     params = getSystemParameterDomain[res];
     If[ DomEmptyQ[ params ], Message[ fixParameter::wrongparamvalue ] ];
  res];

assignParameterValue[ident_String, value_Integer] :=
  Module[{res},
	 res = assignParameterValue[ident,value,$result];
	 If[MatchQ[res,Alpha`system[___]],
	    $result=res;
	    putSystem[$result],
	    $result];
	 res]

assignParameterValue[___] := ( Print["Problem in assignParameterValue"]; 
			       $Failed)

(* Added by tanguy 26/09/95 *)
Clear[assignParameterValueLib]
 assignParameterValueLib[a___]:=
  (Print["Warning: Obsolete function, use fixParameter[] instead"];
   fixParameter[a])

Clear[fixParameter];
 
fixParameter[ ident_String, value_Integer, opts:___Rule ]:=
Catch[
  Module[{lib,prog,i,muteOpt,recOpt},
    muteOpt = mute/.{opts}/.Options[ fixParameter ];
    recOpt = recurse/.{opts}/.Options[ fixParameter ];

    If[ !muteOpt,
      Print["Warning, currently this function supposes that  ",
	    ident,
      " has the same value everywhere and that $result contrains the top calling system of the library"];
    ];

    If[ recOpt,
      lib = Alpha`$library;

      Do[prog=lib[[i,1]];
        lib = 
        Check[
          temp = fixParameter[ident, value,  prog , lib, opts ],
          Print[ident," not set in ",prog];temp,
          fixParameter::notParameter
         ],
         {i,1,Length[$library]}
      ];

      Alpha`$result = getSystem[$result[[1]],lib];
      Alpha`$library = lib;
      Return[lib]
    ,
      lib = $library; prog = $result;
      Check[ 
        temp = fixParameter[ ident, value, $result[[1]], $library, opts ],
        fixParameter::err = "did not succeed";
        $library = lib; $result = prog;
        Throw[ Message[ fixParameter::err ] ]
      ];
      temp = getSystem[ $result[[1]], temp ];
      $library = lib; $result = prog;
      Return[ temp ]
    ]
  ]
];

fixParameter[ident_String, value_Integer, systName_String, opts:___Rule]:=
Module[{},
  Alpha`$library = fixParameter[ident,value,systName,Alpha`$library,opts];
  Alpha`$result = getSystem[$result[[1]],$library];
  $library
];
	
fixParameter::notParameter= "`1` is not a parameter";
fixParameter::wrongparamvalue = 
"the value of the parameter is outside the parameter domain. 
The resulting system is meaningless."; 
	
fixParameter[ident_String, 
	     value_Integer,
	     systName_String,
	     lib_List,
             opts:___Rule] :=
Catch[
  Module[ {tmp,prog,parRank,lib1,newLib,muteOpt},
    muteOpt := mute/.{opts}/.Options[fixParameter];

    prog = getSystem[systName,lib];
    lib1 = lib;

    (* Find out the rank of the parameter to fix *)
    parRank = Position[If[Head[prog[[2,3,1]]]===Alpha`pol,prog[[2,2]],prog[[2,3,1,1,3]]],ident][[1,1]];

    (* Check the result *)
    If[ !MatchQ[parRank,_Integer],
      Message[fixParameter::notParameter,ident];
	       Throw[lib1]
    ];

    (* Assign a parameter value *)
    tmp = assignParameterValue[ident, value, prog];

    (* Put system back *)
    lib1 = putSystem[tmp,lib1];

    (* Adjust all the use of tmp *)
    lib1=
      Check[
        newLib = lib1 /. {Alpha`use[tmp[[1]],
                          extDom_,params_,
                          inputs_,outputs_]:>
                          Alpha`use[tmp[[1]],extDom,
                          suppressRowNum[params,parRank],inputs,outputs]};
      (* everywhere tmp is used, we suppress the parameter in 
         rhs of param assign func *)

    If[ MatchQ[newLib,List[___Alpha`system]],
      If[ !muteOpt, Print[ident," suppressed in use of ",tmp[[1]],
	     " in library "] ] 
    ];
    newLib,
    lib1
  ];
  lib1
  ] (* Module *)
];
fixParameter[___] := Message[ fixParameter::params ];

Clear[removeIdEqus];
Options[ removeIdEqus ] = {debug->False , verbose->False, 
  norm->False, inputEquations -> True, allLibrary->False};

removeIdEqus[opts:___Rule] := 
Catch[
  Module[ {allLib, res, prog, lib, dbg, vrb},
    res = $result; 
    prog = $program;
    lib = $library;

    (* Checks the allLibrary option *)
    dbg = debug/.{opts}/.Options[removeIdEqus];
    vrb = verbose/.{opts}/.Options[removeIdEqus];
    allLib = allLibrary/.{opts}/.Options[removeIdEqus];

    If[ !allLib, 
      Check[
        $result = removeIdEqus[ $result, opts ],
        $result = res; $program = prog;
        Throw[ Null ]
      ],

      Check[
        For[i=1, i<= Length[$library], i++,
          $result = $library[[i]];
          If[ vrb, Print["---- Removing useless equations of system ",
	      getSystemName[]] ];
          $result = removeIdEqus[ $result, opts ];
          putSystem[];
        ],
        $result = res; $program = prog; $library = lib;
        Throw[]
      ]
    ]
  ]
];

removeIdEqus[ sys:_system, opts:___Rule ] := 
Catch[
  Module[{s, toRemove, varsToRemove, eqs, cureq,
          i, v, p, lhsVars, j, dbg, vrb, nrm, inputvars, outputvars},

    (* Get options *)
    dbg = debug/.{opts}/.Options[removeIdEqus];
    vrb = verbose/.{opts}/.Options[removeIdEqus];
    nrm = norm/.{opts}/.Options[removeIdEqus];
    inputE = inputEquations/.{opts}/.Options[removeIdEqus];
    
    (* First, remove all unused vars *)
    s = removeAllUnusedVars[sys];

    (* Get list of input vars *)
    inputvars = getInputVars[sys];
    outputvars = getOutputVars[sys];

    If[ dbg, Print["Input vars: ", inputvars]];
    If[ dbg, Print["Output vars: ", outputvars]];

    (* Now, we select one variable to be removed, and we 
       remove it *)

    (* Get the list of equations *)
    eqs = s[[6]];

    For[ i = 1, i <= Length[ eqs ], i++,

    (* This Catch allows one iteration of the for loop to
       be skipped by Throws *)
    Catch[
      If[ dbg, Print["Considering equation ", i ] ]; 

      (* Get equations of the form A = B, or A = B.identity *)
      cureq = {eqs[[i]]};
      toRemove = 
        Join[ 
          Cases[cureq, equation[lhs_,var[_]]],
          Cases[cureq, equation[u:_,affine[var[v:_],mm:_?identityQ]]->
                   equation[u, var[v]]]
        ];

      (* If option inputEquations is false, remove A = in of equations *)
      If[ !inputE, 
        toRemove = Cases[ toRemove, 
			    equation[_, var[v:_/;!MemberQ[inputvars,v]]]]
      ];

      If[ dbg, Print["toRemove : ", toRemove] ];

      If[ toRemove === {}, Throw[ Null ] ];

      (* Get list of variables to be removed. These variables 
       are the right hand-side variables, except for output equations *)
      varsToRemove = 
        Cases[ toRemove, 
	      (equation[lhs:_,var[rhs:_]]/;!MemberQ[outputvars,lhs])
          -> lhs];

      If[ dbg, Print[ "Variables to be removed : ", varsToRemove ] ];
      If[ varsToRemove === {}, Throw[ Null ] ];

      If[ Length[varsToRemove] >1, Print["Error" ]; Throw[ Null ] ];

      (* Once we have selected the list of variables candidates to be
         removed, one takes the first one, and call removeOneIdEqu. 
         Then, the process is repeated, including the selection of 
         variables, since the system may have changed... *)

      v = varsToRemove[[1]];

      (* Remove this variable *)
      s = removeOneIdEqu[ s, v, opts ];

    ]  (* End Catch *)
    ]; (* End For *)

    If[ nrm, s = normalize[ s ] ];
    s
  ]
];

removeIdEqus[___] := Message[ removeOneIdEqus::params ];

Clear[ removeOneIdEqu ];
removeOneIdEqu[ sys:_system, v:_, opts:___Rule ] :=
Catch[
  Module[ {vrb, dbg, newsys},

    (* Get options *)
    dbg = debug/.{opts}/.Options[removeIdEqus];
    vrb = verbose/.{opts}/.Options[removeIdEqus];

    If[ vrb||dbg, Print["Removing var ",v] ];

    (* Getting positions of var *)
    p = Position[ sys[[6]], var[v]];

    (* Why do we eliminate uses? *)
    p = Select[p, getPart[sys[[6]],{First[#],0}]=!= use &];

    newsys = sys; 
    If[ Length[p]=!=0,
      lhsVars = Map[ Part[ newsys[[6]], First[#]][[1]] &, p ];
      For[ j=1, j<=Length[lhsVars], j=j+1,
        newsys = substituteInDef[ newsys, lhsVars[[j]], v ] 
      ];
      newsys = removeAllUnusedVars[ newsys ] 
    ];
    newsys
  ]
];

removeOneIdEqu[___] := Message[ removeOneIdEqu::params ];

Clear[subSystemUsedBy];
subSystemUsedBy::WrongArg="Wrong Argument for subSystemUsedBy"
subSystemUsedBy[]:=subSystemUsedBy[$result]
subSystemUsedBy[sys:_system]:=
  Module[{listName},
	 listName=Cases[sys,Alpha`use[nom_String,___]->nom,-1];
	 listName]

subSystemUsedBy[___]:= Message[subSystemUsedBy::WrongArg]

Clear[systemDep];
systemDep::WrongArg = "`1`";
systemDep[
 lib:{__system}] :=
  With[{names = (* list of system names in lib *)
	Map[First,lib]},
       Apply[Join,
	     Map[Function[{s},
			  Cases[s, u:_use:>{First[s],First[u]},-1]
			],
		 lib]
	   ]
     ];
systemDep[a___] :=
  Module[{}, Message[systemDep::WrongArg];
	 $Failed];

Clear[topoSort];
topoSort::WrongArg = "`1`";

topoSort[
  l:List[__system]] :=
  Module[{roots = {},
	  names = Map[First, l],
	  dep = systemDep[l]},
	 While[Length[names] > 0,
	       roots =
		 Append[roots,
			With[{nonroots = Map[First, dep]},
			     Complement[names, nonroots]]];
	       names = Complement[names, Last[roots]];
	       dep = Select[dep, Function[{d},
					  MemberQ[names, Last[d]]
					]
			  ];
	     ];
	 Flatten[roots]
       ];
	       
topoSort[a___] :=
  Module[{}, Message[topoSort::WrongArg];
	 $Failed];



(************* addBufferVars add buffers variable for input and output
  of a use, **********************************************************)

Clear[simplifyUseInputs]
simplifyUseInputs[]:=
  Module[{tempSys},
	 tempSys=simplifyUseInputs[$result];
	 If [MatchQ[tempSys,_system],
	     $result=tempSys,
	     $result]]

simplifyUseInputs[sys:_Alpha`system]:=
  Module[{eqs,useEqs,curSys},
	 eqs=sys[[6]];
	 useEqs=Select[eqs,Length[Position[#,use]]=!=0 &];
	 curSys=sys;
	 Do[curUse=useEqs[[i]];
	    curSys=simplifyUseInputsForUse[curSys,curUse],
	    {i,1,Length[useEqs]}];
	 curSys]


simplifyUseInputs[___]:=simplifyUseInputs::WrongArg

Clear[simplifyUseInputsForUse]
simplifyUseInputsForUse::usage="in test"

simplifyUseInputsForUse[curUse:_use]:=
  Module[{tempSys},
	 tempSys=  simplifyUseInputsForUse[$result,curUse];
	 If [MatchQ[tempSys,_system],
	     $result=tempSys,
	     $result]]

simplifyUseInputsForUse[sys:_system,curUse:_use]:=
  Module[{listInVars, curSys,curVar,curVarName,newVar,posUses,posUse,
	  localUse},
	 posUses=Position[sys,curUse];
	 If[posUses==={},Message[simplifyUseInputsForUse::UseNotFound];
	    Return[sys],
	    posUse=First[posUses]];
	 (* posUse is the position of the use equation in the AST *)
	 curSys=sys;
	 localUse=curUse;
	 listInVars=curUse[[4]];
	 Do[curExpr= listInVars[[i]];
	    curExprPos=Join[posUse,{4,i}];
	    If [MatchQ[curExpr,var[_String]],
	(* nothing to do *), 
	(* else add a local var *)
     (* choose the name of the variable *)
     If[MatchQ[curExpr,affine[var[_String],matrix[___]]],
	curVarName=curExpr[[1,1]]<>"IN", 
	curVarName=curUse[[1]]<>"IN"<>ToString[i]];
     newVar=getNewName[curVarName];
     (* The addLocal MUST use the position here *)
     curSys=addLocal[ curSys,newVar,curExprPos];
     (* update the position of the use  in sys *)
     localUse=localUse/.(curExpr->var[newVar]);
     posUses=Position[curSys,localUse];
     If[posUses==={},Message[simplifyUseInputsForUse::UseNotFound];
     Return[curSys],
       posUse=First[posUses]]]
     ,{i,1,Length[ listInVars]}];
curSys]

simplifyUseInputsForUse[___]:=simplifyUseInputsForUse::WrongArg


End[]

EndPackage[]

