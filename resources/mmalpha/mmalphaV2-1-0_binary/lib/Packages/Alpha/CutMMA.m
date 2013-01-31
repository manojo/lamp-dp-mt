(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Z. Chamski 
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

BeginPackage["Alpha`CutMMA`", {"Alpha`Domlib`",  
			    "Alpha`",
			    "Alpha`Matrix`",
			    "Alpha`Tables`",
			    "Alpha`Semantics`",
			    "Alpha`Options`",
			    "Alpha`Normalization`",
			    "Alpha`VertexSchedule`",
			    "Alpha`Substitution`"}]

(* $Id: CutMMA.m,v 1.2 2010/04/10 19:53:35 quinton Exp $
 $Author: quinton $
   $Date: 2010/04/10 19:53:35 $
   $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/CutMMA.m,v $
   $Revision: 1.2 $
   $Log: CutMMA.m,v $
   Revision 1.2  2010/04/10 19:53:35  quinton
   A new function binarizeCase was introduced, in order to modify the pipeline
   function, but it may not be useful. PQ

   Revision 1.1  2008/12/29 17:31:20  quinton
   Replaces package Cut.m, since this one is in conflict with Combinatorica in version 6 of MMA.

   Revision 1.1  2005/03/11 16:40:17  trisset
   added all remaining packages to V2

   Revision 1.19  2004/09/16 13:43:49  quinton
   Updated documentation

   Revision 1.18  2004/08/02 13:15:27  quinton
   Documentation updated for reference manual

   Revision 1.17  2004/06/16 14:57:28  risset
   switched to ZDomlib

   Revision 1.16  2003/07/18 12:52:39  risset
   Undo Abhishek changes because it was failing on Windows

   Revision 1.14  2001/04/21 06:50:09  quinton
   Change file from dos to unix format...

   Revision 1.13  2001/04/21 05:53:34  quinton
   Minor corrections

   Revision 1.12  2001/04/09 16:45:18  quinton
   *** empty log message ***

   Revision 1.11  2000/06/06 15:40:44  risset
   added splitCaseUnion an mergeIdCaseBranches

   Revision 1.10  1999/05/18 16:07:58  risset
   put Merge into Cut, remove Equivalence and Decompose

   Revision 1.9  1999/05/10 15:20:56  risset
   supressed the Decomposition Package, put it in Cut

   changelog:
     11/29/1993, Z. Chamski:	cleaned comments.
*)

CutMMA::note = 
"Documentation revised on August 3, 2004.";
CutMMA::usage =
"Alpha`CutMMA` is the package which contains the cut, decompose
 and merge transformations. Earlier, it was named Alpha`Cut, but
 since Version 6 of Mathematica, there is a conflict with the 
 Combinatorica package.";

cut::usage =
"cut[var_String, dom_String, outvar1_Sting, outvar2_String] returns the
program obtained by cutting the definition of var in program $result
into two definitions outvar1 and outvar2, where outvar1 is restricted
to dom, and outvar2 is restricted to the complemtary space of dom. The
result of cut is put in symbol $result. cut[sys, var, dom, outvar1,
outvar] does the same to program sys. The parameter dom may be
specified either as a string, or as the internal Alpha form of a
domain. \nExample: cut[\"A\",\"{i,j | i<j }\",\"A1\", \"A2\"].";

decompose::usage =  
"decompose[expr,name] returns the program obtained by adding to 
$result a new equation \"name = expr\" and replacing the first 
occurrence of expr by name. The program returned is assigned to
$result.  decompose[sys,expr,name] does the same to program sys, but
does not modify $result. expr and name are either strings or ast's.
expr can also be specified using a Mathematica Position."

binarizeAllCases::usage = 
"binarizeAllCases[] replaces all non binary cases with binary cases...";

binarizeCase::usage =
"binarizeCase[var] replaces the definition of var, if is is a case
expression with more than two branches, by a new expression with 
a binary case, by introducing a new variable"; 

Options[ binarizeCase ] = {debug -> False, verbose -> False};

exprLocalEquivQ::usage =
"Predicate. Checks whether or not two expressions in an ALPHA programs are
equivalent in any point of a given domain. Obsolete function.";

exprLocalEquivQ::params = "wrong parameters";

merge::usage =
"merge[var1, var2, newVar] replaces in $result two local variable 
definitions with a single one. The declaration domain of the new 
variable is the union of the domains of the old ones. The definition 
of the new variable is a case whose branches are definitions of 
the old variables restricted to their respective domains. RHS
occurrences of the old variables are replaced by the proper restrictions of
the new variable.\n
merge[sys, var1, var2, newVar] replaces in system sys two local 
variable definitions with a single one and returns the new system.";

mergeCaseBranches::usage =
"mergeCaseBranches[casePosition_List, branchPosition_List],
merges (in $result) the specified case branches if they contain identical
expressions. mergeCaseBranches[sys, casePosition, branchPosition] 
merges the  specified case branches of system sys if they contain 
identical expressions and returns the new system. The domain of the 
new branch may be non-convex.";

mergeIdCaseBranches::usage=
"mergeIdCaseBranches[sys] tries to merge case branches that have 
identical expressions (i.e. tries to inverse what splitCaseUnion did). 
Warning, this function works only on normalized programs.";

splitCaseUnion::usage=
"splitCaseUnion[sys] splits all the case branches that have a 
non convex domain as restrict (union of convex) by several branches, 
each corresponding to one convex domain. Warning,
this function works only on normalized programs.";

unionMerge::usage =
"unionMerge[sys, firstVar, secondVar, resultingVar] is an
extension of merge that handles overlapping definitions parameters.
Returns the modified program. Warning obsolete function.";

unionMerge::note =
"unionMerge acts much like merge, the difference being that overlapping
domains are accepted if both expressions are equivalent over the overlap. By
equivalent we mean that the structures of the expressions are identical and
that the images of the overlap domain through the dependence functions are
equal for any dependence. To illustrate the latter, consider the expressions
\n
{i,j|i=j; 1<=j<=4\} : A.(i,j->i,j) \nand 
\n{i,j|i=j; 1<=j<=4} : A.(i,j->j,j).\n
Although the dependence functions are not equal, these expressions are
equivalent over the domain {i,j|i=j; 1<=j<=4}."

Begin["`Private`"]
cut::params = "wrong parameters";
cut::readDomErr = "error while reading domain: `1`";
cut::internal = "error while computing cut";
cut::invldrest = "domain and variable dimensions are different";
cut::samevar = "variables outvar1 and outvar2 are the same";
cut::usedvars = "at least one of variables outvar1 and outvar2 is not
new";

decompose::params = "wrong parameters";
decompose::wrgocc = "`1` is a wrong occurrence specification";
decompose::varused = "var `1` already used";
decompose::typemismatch = "type mismatch!";

(* aux functions: building the RHS case expression of the cut *)

Clear[buildCutCase];

buildCutCase[var1_String, var2_String,
	     subDom1_Alpha`domain, subDom2_Alpha`domain] := 
  Alpha`case[{Alpha`restrict[subDom1, Alpha`var[var1]],
	      Alpha`restrict[subDom2, Alpha`var[var2]]}];

(* aux functions: building the equation of a new variable *)

Clear[buildCutNewEqua];

buildCutNewEqua[varName_String, subDom_Alpha`domain, exp_] :=
  Alpha`equation[varName, Alpha`restrict[subDom, exp]];

(* The parameters of the transformations are:
   =========================================
   1: a program to transform (default $result),
   2: a variable to cut (called LHS variable thereafter)
   3: a cutting restriction (subdomain D' of the domain of LHS variable)
   4: a variable name to substitute for LHS var occurrences on D'
   5: a variable name to substitute for LHS var occurrences outside D'
*)

(*'*)

(* change *)
Clear[cut];

(* fisrt way: 4 parameter, $result implicit, all strings *)
cut[y_String, dom_String, y1_String, y2_String] :=
Catch[
  Module[{sys1,dom1,sys2,sys1param},
    sys1=$result;

	 (*
    sys1param = If[Head[sys1[[2,3,1]]]===Alpha`pol,sys1[[2,2]],
      sys1[[2,3,1,1,3]]
    ];
	  *)

    sys1param = getSystemParameterDomain[];

    Check[ 
      dom1 = readDom[dom,sys1param], 
      Throw[Null]
    ];

    If[ !MatchQ[ dom1, _domain ], 
      cut::errorDom = "could not parse cutting domain";
      Throw[Message[cut::errorDom]]
    ];

    Check[
      sys2=cut[sys1,y,dom1,y1,y2], 
      Throw[Message[cut::internal]]
    ];
    $result=sys2
  ]
];

(* second way: 4 parameters, $result implicit, all strings exept domain *)
cut[y_String, dom_Alpha`domain, y1_String, y2_String] :=
Catch[
  Module[{sys1,sys2},
    sys1=$result;
    Check[sys2=cut[sys1,y,dom,y1,y2],Throw[Message[cut::internal]]];
    $program=sys1;
    $result=sys2
  ]
];


(* Third way : system given and domain in string *)
cut[sys1_Alpha`system,y_String, dom_String, y1_String, y2_String] :=
Catch[
  Module[{error,dom1,sys2,sys1param},
  (*
    sys1param = If[Head[sys1[[2,3,1]]]===Alpha`pol,
      sys1[[2,2]],sys1[[2,3,1,1,3]]
    ];
  *)

    sys1param = getSystemParameterDomain[];

    Check[ dom1 = readDom[dom,sys1param], Throw[Null]];

    If[ !MatchQ[ dom1, _domain ], 
      cut::errorDom = "could not parse cutting domain";
      Throw[Message[cut::errorDom]]
    ];


    Check[sys2=cut[sys1,y,dom1,y1,y2], Throw[Message[cut::internal]]];
     sys2
  ]
];

(* This part done by Zbi, not corrected yet (16/10/96) *)
(* all parameters explicit *)

cut[sys:Alpha`system[n_, p_, i_, o_, locals_, equas_],
    LHSvar_String,
    restrictDom1_Alpha`domain,
    varName1_String,
    varName2_String] :=
Catch[
  Module[{LHSdecl,LHSequa,vars},
    Check[LHSdecl = getDeclaration[sys, LHSvar],Throw[Null]];
    Check[LHSequa = getEquation[sys, LHSvar],Throw[Null]];
    If[varName1 === varName2,Throw[Message[cut::samevar]]];

    If[Intersection[getVariables[],{varName1,varName2}]=!= {},
      Throw[Message[cut::usedvars]]
    ];

    If[restrictDom1[[1]] =!= Part[LHSdecl, 3, 1],
       Throw[Message[cut::invldrest]],
    Null] ;

    With[{subDom1 = DomIntersection[Part[LHSdecl, 3], restrictDom1],
          subDom2 = DomDifference[Part[LHSdecl, 3], restrictDom1],
          LHStype = Part[LHSdecl, 2],
          LHSdeclPosition = First[Position[locals, LHSdecl]],
          LHSequaPosition = First[Position[equas, LHSequa]]},

    (* build the ALPHA system: first, replace the definition of the
	       initial var by the definitionS (plural!) of the new vars; this
	       is done by inserting the definitions in reverse order (var2
	       then var1) at the location of the old declaration; the same
	       trick is used to add the equations of the new variables.
	       *)

	    Alpha`system[n, p, i, o,
			 Insert[Insert[Drop[locals, LHSdeclPosition],
				       Alpha`decl[varName2,
						  LHStype,
						  subDom2],
				       LHSdeclPosition],
				Alpha`decl[varName1,
					   LHStype,
					   subDom1],
				LHSdeclPosition],
			 Drop[
			   Insert[Insert[equas, (* insert var #2 first *)
					 buildCutNewEqua[varName2,
							 subDom2,
							 Part[LHSequa, 2]],
					 LHSequaPosition],
				  buildCutNewEqua[varName1, (* then var #1 *)
						  subDom1,
						  Part[LHSequa, 2]],
				  LHSequaPosition] /.
				    Alpha`var[LHSvar] ->
				      buildCutCase[varName1, varName2,
						   subDom1, subDom2],
			   2 + LHSequaPosition]]]]
]; (* Catch *)

cut[___]:=Message[cut::params];

(* build the new equation ... varName = RHSexpression *)


(************** functions for decompose **********************)

Clear[buildDecompEquation];
buildDecompEquation::params = "wrong parameters";
buildDecompEquation[sys_Alpha`system, occur:{_Integer..}, varName_String] :=
  Alpha`equation[varName,
		 accessByPath[sys, occur]];
buildDecompEquation[___]:=Message[buildDecompEquation::params];

Clear[binarizeAllCases];
 binarizeAllCases[ opts:___Rule ] :=
Catch[
  Module[ {varToBinarize, dbg, vrb},

    (* Get options *)
    dbg = debug/.{opts}/.Options[ binarizeCase ];
    vrb = debug/.{opts}/.Options[ binarizeCase ];

    (* Get list of variables to binarize *)
    varToBinarize = Cases[ $result[[6]], equation[v:_, case[{_,_,__}]]->v ];
    If[ dbg, Print[ "Cases to binarize : ", varToBinarize ] ];

    While[ varToBinarize =!= {},
       If[ dbg, Print[ " ---- binarizing : ", varToBinarize[[1]] ] ];
       binarizeCase[ varToBinarize[[1]] ];
       varToBinarize = Cases[ $result[[6]], equation[v:_, case[{_,_,__}]]->v ];
    ];
  ]
];
binarizeAllCases[___]:=Message[binarizeAllCases::params];

(*
  When a variable is defined by a case expression, replaces
  this definition with a binary case, and the definition of new variables...
*)
Clear[binarizeCase];
binarizeCase[ varName:_String, opts:___Rule ]:=
Catch[
  Module[ {eq, newName, exp, rest, dbg, vrb, complement, domFirstCase, d1, d2 },

    (* Get options *)
    dbg = debug/.{opts}/.Options[ binarizeCase ];
    vrb = debug/.{opts}/.Options[ binarizeCase ];

    (* Get the equation that defines varName, and checks that it exists *)
    Check[
      eq = getEquation[ varName ],
      binarizeCase::noEquation = "no definition for variable `1` in this program. Failing"; 
      Throw[ Message[ binarizeCase::noEquation, varName ] ]
    ];

    (* Checks that this definition is a case with more thant 2 branches *)
    If[ !MatchQ[ eq[[2]], case[{_,_,__}] ],
      binarizeCase::nocaseExpr = "variable `1` is not a case. Program unchanged."; 
      Throw[ binarizeCase::nocaseExpr, varName ]
    ];
 
    If[ dbg, Print[ "Equation: \n", ashow[ eq, silent -> True ] ]];
 
    (* Create a new name for the additional variable *)
    newName = getNewName[ varName ];

    (* Get the declaration domain of varName *)
    rest = getDeclarationDomain[ varName ];

    (* Get in exp the RHS of the equation *)
    exp = eq[[2]];
    If[ dbg, Print["RHS: \n", ashow[ exp, silent->True ] ] ];

    (*
    domFirstCase = exp[[1,1,1]];
     *)
    domFirstCase = expDomain[exp[[1,1]]];
    If[ dbg, Print["Domain first case: \n", ashow[ domFirstCase, silent->True ] ] ];

    d1 = DomUniverse[DomDimension[domFirstCase], domFirstCase[[2]] ];
    d2 = DomDifference[ d1, domFirstCase ];

    complement = 
      DomIntersection[
        d2, rest
      ];
    If[ dbg, Print["Complement: \n", ashow[ complement, silent->True ] ] ];

    (* Add the restriction before the expression, and drop the first part of the case *)
    exp = restrict[ complement, case[ Drop[exp[[1]],1] ] ];
    exp = restrict[ expDomain[ exp ], exp ];
    If[ dbg, Print["Newexp: \n", ashow[ exp, silent->True ] ] ];

    (* Add locally the expression *)
    addlocal[ newName, exp, debug -> False ];

    exp = case[{eq[[2,1,1]], restrict[ getDeclarationDomain[newName], var[ newName ] ]}];    
    If[ dbg, Print["Newdefinition of variable: \n", ashow[ exp, silent->True ] ] ];

    $result = $result/.{ equation[ varName, _ ] -> equation[ varName, exp ] };
    $result = normalize[ $result ];
  ]
];
binarizeCase[___] := Message[ binarizeCase::params ];

(* Parameters:
   1: the program to use (Alpha`system)
   2: the occurrence to transform (a Mma 'position', that is, a list of
      integers)
   3: the name of the new variable (String)
   *)

Clear[decompose];
decompose[occur:{_Integer..}, varName_String] :=
Catch[
   $program = $result;
   With[{r = Check[decompose[$result, occur, varName],Throw[Null]]},
   $result = r]
];

(* one may give a symbol instead of a string --> convert the symbol *)
decompose[occur:{_Integer..}, varName_Symbol] :=
Catch[
   $program = $result;
   With[{r = Check[decompose[$result, occur, ToString[varName]],Throw[Null]]},
   $result = r]
]

(* single string parameter: use as occurrence to search for. Takes the first
   occurrence ONLY to avoid type and domain inference problems. *)
decompose[pattern_String] :=
Catch[
   $program = $result;
   With[{r = Check[decompose[$result,pattern],Throw[Null]]},
   $result = r]
];

decompose[sys_Alpha`system, pattern_String] :=
Catch[
  With[{go = Check[getOccurs[sys, pattern],Throw[Message[decompose::wrgocc,pattern]]]},
       decompose[sys, go[[1]]]
      ]
];

(* two string parameters: use as specifications of occurrence and new variable
   name *)
decompose[stringPattern_String, newVarName_String] :=
Catch[
    If[MemberQ[getVariables[$result],newVarName],
       Throw[Message[decompose::varused,newVarName]]];
    $program = $result;
    With[{r = Check[decompose[$result, stringPattern, newVarName],Throw[Null]]},
         $result = r]
];

decompose[sys_Alpha`system, stringPattern_String, newVarName_String] :=
Catch[
    If[MemberQ[getVariables[sys],newVarName],
       Throw[Message[decompose::varused,newVarName]]];
    With[{go = Check[getOccurs[sys, stringPattern],
	 Throw[Message[decompose::wrgocc,stringPattern]]]},
         decompose[sys, go[[1]],newVarName]]
];

(* the main function *)
(* the replacement of the old occurrence uses contextual tricks (relative
   position in tree with the _suffix_ of a path) in ReplacePart
 *)
decompose[sys:Alpha`system[n_,p_,i_,o_,locals_,equas_],
	  occur:{_Integer..},
	  varName_String] :=
Catch[
  Module[{type,abp,dom,equaposition},
    Check[abp = accessByPath[sys,occur],
          Throw[Message[decompose::wrgocc,occur]]];
    type = Check[expType[sys,abp],Throw[Message[decompose::wrgocc,occur]]];
    dom = Check[getContextDomain[sys, occur],Throw[Null]];
    equaposition = Position[equas, lookUpFor[sys, occur, Alpha`equation]];
    If[type === Alpha`bottom,
      Message[decompose::typemismatch],
      Alpha`system[n,p,i,o,
        Prepend[locals, Alpha`decl[varName, type, dom]],
        Insert[ReplacePart[equas, Alpha`var[varName], Drop[occur, 1]],
          buildDecompEquation[sys, occur, varName],
          equaposition]]
    ]
  ]
];
decompose[___] := Message[decompose::params];

 unionMergeCaseBranches::usage =
  "Function. Merges specified case branches if they contain equivalent
expressions (see 'unionMerge'.) \n\nParameters: \n\t1) an ALPHA program
(defaults to 'Alpha`$result',) \n\t2) position of the case expression (list of
integers,) \n\t3) positions of branches to collapse (list of integers.)
\n\nReturns the modified program. \n\nThe domain of the new branch may be
non-convex." 

Clear[merge]

(* Calling sequences
   1: no parameters ===> get all variable names interactively, use $result,
   2: varName1 & varName2 explicit ===> get mergedName interactively, use
      $result,
   3: var names explicit ===> use $result,
   4: explicit program ===> get variable names interactively,
   5: explicit program & varName1 and 2 ===> get mergedName interactively,
   6: all explicit *)

(* no parameters ===> get all variable names interactively, use $result *)

merge[] :=
  With[{varName1 =
	InputString["Enter the name of the 1st variable to merge ==> "],
	varName2 =
	InputString["Enter the name of the 2nd variable to merge ==> "]},
       merge[varName1, varName2]]

(* varName1 & varName2 explicit ===> get mergedName interactively, use
   $result *)

merge[varName1_String, varName2_String] :=
 With[{mergedName =
	  InputString["Enter the name of the merged variable ==> "]},
       merge[varName1, varName2, mergedName]]

merge[varName1_ /; !MatchQ[varName1, {}],
      varName2_ /; !MatchQ[varName2, {}]] :=
  merge[symToString[varName1], symToString[varName2]]

merge[varName1_, varName2_ /; Or[MatchQ[varName1, {}],
				 MatchQ[varName2, {}]]] :=
       (Print["? Invalid parameter type(s) : ",
	      InputForm[varName1], ", ",
	      InputForm[varName2], "."] ;
	{} )

(* implicit program ===> use $result and update the tables on success *)

merge[varName1_String, varName2_String, mergedName_String] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = merge[Alpha`$program, varName1, varName2, mergedName] ;
   If[Alpha`$result==={},
      Clear[Alpha`$result];Alpha`$result=Alpha`$program;{},
      Alpha`$result]
  )

merge[varName1_ /; !MatchQ[varName1, {}],
      varName2_ /; !MatchQ[varName2, {}],
      mergedName_ /; !MatchQ[mergedName, {}]] :=
  merge[symToString[varName1], symToString[varName2], symToString[mergedName]]

merge[varName1_, varName2_, mergedName_ /; Or[MatchQ[varName1, {}],
					      MatchQ[varName2, {}],
					      MatchQ[mergedName, {}]]] :=
       (Print["? Invalid parameter type(s) : ",
	      InputForm[varName1], ", ",
	      InputForm[varName2], ", ",
	      InputForm[mergedName], "."] ;
	{} )

(* explicit program, no variable names ===> read var names interactively *)

merge[sys_Alpha`system] :=
  With[{varName1 =
	InputString["Enter the name of the 1st variable to merge ==> "],
	varName2 =
	InputString["Enter the name of the 2nd variable to merge ==> "]},
       merge[varName1, varName2]]

(* explicit program and initial var names ===> read merged var name *)

merge[sys_Alpha`system, varName1_String, varName2_String] :=
  With[{mergedName =
	  InputString["Enter the name of the merged variable ==> "]},
       merge[sys, varName1, varName2, mergedName]]

merge[sys_Alpha`system,
      varName1_ /; !MatchQ[varName1, {}],
      varName2_ /; !MatchQ[varName2, {}]] :=
  merge[sys, symToString[varName1], symToString[varName2]]

merge[sys_Alpha`system, varName1_, varName2_
	/; Or[MatchQ[varName1, {}],
	      MatchQ[varName2, {}]]] :=
  (Print["? Invalid parameter type(s) : ",
	 InputForm[varName1], ", ",
	 InputForm[varName2], "."] ;
   {} )

	
(* all parameters explicit -> some documentation needed *)

merge[sys:Alpha`system[n_, p_, i_, o_, locals_, equas_],
      varName1_String,
      varName2_String,
      mergedName_String] :=
  With[{declVar1 = getDeclaration[sys, varName1],
	declVar2 = getDeclaration[sys, varName2],
	defVar1 = getDefinition[sys, varName1],
	defVar2 = getDefinition[sys, varName2]},
       (* 
	first check if all informations are present ... 
	*)
       If[MemberQ[{declVar1, declVar2, defVar1, defVar2}, {}],
	  (Print["?", varName1, " or ", VarName2, " is undefined."];
           Return[{}]),
	  With[{domDecl1 = Part[declVar1, 3],
		domDecl2 = Part[declVar2, 3],
		type1 = Part[declVar1, 2],
		type2 = Part[declVar2, 2]},
	       (*
		fail if either the intersection of domains is not empty ...
		*)
	       If[!DomEmptyQ[DomIntersection[domDecl1,
							   domDecl2]],
		  (Print["? Non-empty initial domain intersection:"] ;
		   Print["\tDomain of variable ", varName1, ":"] ;
		   show[domDecl1] ;
		   Print["\tDomain of variable ", varName2, ":"] ;
		   show[domDecl2] ;
		   Return[{}]),
		  (*
		   ... or the types of the variables don't match
		   *)
		  If[matchTypes[type1, type2] === Alpha`bottom,
		     (Print["? Type of ", varName1, " and ", varName2,
                            " don't match"];
                      Return[{}]),
		     Alpha`system[n, p, i, o,
				  DeleteCases[locals,
					      Alpha`decl[varName2, _,_]]
				  /. (Alpha`decl[varName1, _, _]
				      -> Alpha`decl[mergedName,
						    matchTypes[type1, type2],
						    convexize[
						      DomUnion[
							domDecl1,
							domDecl2]]]),
				  (DeleteCases[equas,
					       Alpha`equation[varName2, _]]
				   /. Alpha`equation[varName1, _]
				   -> buildMergeEquation[mergedName,
							 domDecl1,
							 domDecl2,
							 defVar1,
							 defVar2])
				    /. {Alpha`var[varName1]
					-> Alpha`restrict[domDecl1,
							  Alpha`var[mergedName]],
					Alpha`var[varName2] ->
					Alpha`restrict[domDecl2,
						       Alpha`var[mergedName]]}]]]]]]


(* building the equation of the new variable *)

Clear[buildMergeEquation]
buildMergeEquation[mergedName_String,
		   domDecl1_Alpha`domain,
		   domDecl2_Alpha`domain,
		   defVar1_,
		   defVar2_] :=
  Alpha`equation[
    mergedName,
    Alpha`case[{Alpha`restrict[domDecl1, defVar1],
		Alpha`restrict[domDecl2, defVar2]}]]


(* merging of case alternatives: useful after normalization of a case *)
(* first step: extract selected restrictions, then compare their expressions;
   if the expressions are identical, merge the branches into a single one and
   insert the new branch at the position of the first (leftmost) removed
   branch *)


Clear[mergeCaseBranches]



mergeCaseBranches[pos:{_Integer..}, branches:{_Integer..}] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = mergeCaseBranches[Alpha`$program, pos, branches])

mergeCaseBranches[sys_Alpha`system,
		  pos:{_Integer..},
		  branches:{_Integer..}] :=
  With[{selected = Part[Part[accessByPath[sys, pos], 1], branches],
	caseExp = accessByPath[sys, pos]},
       If[Head[caseExp] =!= Alpha`case,
	  (Print["? mergeCaseBranches: cannot handle non-case expressions!"] ;
	   show[caseExp]),
	  Null] ;
       If[Apply[And, MapThread[SameQ[Part[#1, 2], Part[#2, 2]]&,
			       {Drop[selected, 1],
				Drop[selected, -1]}]],
	  ReplacePart[sys,
		      Insert[Delete[caseExp, Map[List[1, #]&, branches]],
			     Alpha`restrict[
			       convexize[
				 Fold[DomUnion,
				      Part[selected, 1, 1],
				      Map[Part[#, 1]&, Drop[selected, 1]]]],
			       Part[selected, 1, 2]],
			     {1, Min[branches]}],
		      pos],
	  (Print["? Cannot merge case branches: distinct expressions!"] ;
	   Return[sys])]]
		      

(* MergeIdCase branches *)



Clear[mergeIdCaseBranches]

mergeIdCaseBranches[]:=
  Module[{res},
	 res=mergeIdCaseBranches[$result];
	 If [MatchQ[res, Alpha`system[___]],
	     $result=res,
	     $result]
       ]

mergeIdCaseBranches[sys1:_Alpha`system]:=
  Module[{res},
	 res=   ReplacePart[sys1,
			    Map[mergeIdCaseBranches,sys1[[6]]],
			    6];
	 If [MatchQ[res, Alpha`system[___]],
	     res,
	     sys1]
       ]

mergeIdCaseBranches[eq1:_Alpha`equation]:=
  Module[{res,allBranches,newBranches,curRHS,curDoms,newDom},
	  If [Position[eq1,Alpha`case,Infinity]==={},
	      res=eq1,
	      If [Length[Position[eq1,Alpha`case,Infinity]]=!=1,
		  Print["Warning, (var ",eq1[[1]],
			" mergeIdCaseBranches should be used on  normalized programs"];
		  res=eq1,
		  allBranches=eq1[[2,1]];
		  If [Union[Map[Part[#,0]  &,allBranches]]
		      =!={Alpha`restrict},
		      Print["Warning 2, (var ",eq1[[1]],
		       " splitCaseUnion should be used on  normalized programs"];
		      res=eq1,
		      (* here we try to merge case branches *)
			listOfRHS=Union[Map[Part[#,2] &,allBranches]];
		      newBranches={};
		      Do [curRHS=listOfRHS[[i]];
			  curBranches=Select[allBranches,Part[#,2]===curRHS &];
			  curDoms=Map[First,curBranches];
			  newDom=First[curDoms];
			  Do[newDom=DomUnion[newDom,curDoms[[j]]];
			     ,{j,2,Length[curDoms]}];
			  newBranches=Append[newBranches,
					     Alpha`restrict[newDom,
							    curRHS]]
			  ,{i,1,Length[listOfRHS]}];
		    res=ReplacePart[eq1,newBranches,{2,1}];
		    ];
		];
	    ];
	 res]

mergeIdCaseBranches[___]:=Message[mergeIdCaseBranches::WrongArg]

mergeIdCaseBranches::WrongArg="Wrong Argument for mergeIdCaseBranches"



(* ******************** unionMerge *********************** *)
Clear[unionMerge]

(* Calling sequences
   1: no parameters ===> get all variable names interactively, use $result,
   2: varName1 & varName2 explicit ===> get mergedName interactively, use
      $result,
   3: var names explicit ===> use $result,
   4: explicit program ===> get variable names interactively,
   5: explicit program & varName1 and 2 ===> get mergedName interactively,
   6: all explicit *)

(* no parameters ===> get all variable names interactively, use $result *)

unionMerge[] :=
  With[{varName1 =
	InputString["Enter the name of the 1st variable to merge ==> "],
	varName2 =
	InputString["Enter the name of the 2nd variable to merge ==> "]},
       unionMerge[varName1, varName2]]

(* varName1 & varName2 explicit ===> get mergedName interactively, use
   $result *)

unionMerge[varName1_String, varName2_String] :=
  With[{mergedName =
	  InputString["Enter the name of the merged variable ==> "]},
       unionMerge[varName1, varName2, mergedName]]

unionMerge[varName1_ /; !MatchQ[varName1, {}],
      varName2_ /; !MatchQ[varName2, {}]] :=
  unionMerge[symToString[varName1], symToString[varName2]]

unionMerge[varName1_, varName2_ /; Or[MatchQ[varName1, {}],
				 MatchQ[varName2, {}]]] :=
       (Print["? Invalid parameter type(s) : ",
	      InputForm[varName1], ", ",
	      InputForm[varName2], "."] ;
	{})

(* implicit program ===> use $result and update the tables on success *)

unionMerge[varName1_String, varName2_String, mergedName_String] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = unionMerge[Alpha`$program, varName1, varName2, mergedName] ;
   If[Alpha`$result==={},
      Clear[Alpha`$result];Alpha`$result=Alpha`$program;{},
      Alpha`$result]
  )

unionMerge[varName1_ /; !MatchQ[varName1, {}],
      varName2_ /; !MatchQ[varName2, {}],
      mergedName_ /; !MatchQ[mergedName, {}]] :=
  unionMerge[symToString[varName1], symToString[varName2], symToString[mergedName]]

unionMerge[varName1_, varName2_, mergedName_ /; Or[MatchQ[varName1, {}],
					      MatchQ[varName2, {}],
					      MatchQ[mergedName, {}]]] :=
       (Print["? Invalid parameter type(s) : ",
	      InputForm[varName1], ", ",
	      InputForm[varName2], ", ",
	      InputForm[mergedName], "."] ;
	{} )

(* explicit program, no variable names ===> read var names interactively *)

unionMerge[sys_Alpha`system] :=
  With[{varName1 =
	InputString["Enter the name of the 1st variable to merge ==> "],
	varName2 =
	InputString["Enter the name of the 2nd variable to merge ==> "]},
       unionMerge[varName1, varName2]]

(* explicit program and initial var names ===> read merged var name *)

unionMerge[sys_Alpha`system, varName1_String, varName2_String] :=
  With[{mergedName =
	  InputString["Enter the name of the merged variable ==> "]},
       unionMerge[sys, varName1, varName2, mergedName]]

unionMerge[sys_Alpha`system,
      varName1_ /; !MatchQ[varName1, {}],
      varName2_ /; !MatchQ[varName2, {}]] :=
  unionMerge[sys, symToString[varName1], symToString[varName2]]

unionMerge[sys_Alpha`system, varName1_, varName2_
	/; Or[MatchQ[varName1, {}],
	      MatchQ[varName2, {}]]] :=
  (Print["? Invalid parameter type(s) : ",
	 InputForm[varName1], ", ",
	 InputForm[varName2], "."] ;
   {} )

	
(* all parameters explicit -> some documentation needed *)

unionMerge[sys:Alpha`system[n_, p_, i_, o_, locals_, equas_],
      varName1_String,
      varName2_String,
      mergedName_String] :=
  With[{declVar1 = getDeclaration[sys, varName1],
	declVar2 = getDeclaration[sys, varName2],
	defVar1 = getDefinition[sys, varName1],
	defVar2 = getDefinition[sys, varName2]},
       (* 
	first check if all informations are present ... 
	*)
       If[MemberQ[{declVar1, declVar2, defVar1, defVar2}, {}],
	  Return[{}],
	  With[{domDecl1 = Part[declVar1, 3],
		domDecl2 = Part[declVar2, 3],
		domOverlap = DomIntersection[Part[declVar1, 3],
						    Part[declVar2, 3]],
		domVar2ButVar1 = DomDifference[Part[declVar2, 3],
						      Part[declVar1, 3]],
		domVar1ButVar2 = DomDifference[Part[declVar1, 3],
						      Part[declVar2, 3]],
		type1 = Part[declVar1, 2],
		type2 = Part[declVar2, 2]},
	       (*
		fail if either the expressions aren't equivalent over domain
		intersection ...
		*)
	       If[!exprLocalEquivQ[normalizeInCtxt[defVar1, domOverlap],
				   normalizeInCtxt[defVar2, domOverlap],
				   domOverlap],
		  (Print["? Non-mergeable expressions:"] ;
		   Print["Domain:"] ;
		   show[domOverlap] ;
		   Print["\nExpression #1:"] ;
		   show[defVar1] ;
		   Print["\nExpression #2:"] ;
		   show[defVar2] ;
		   Return[{}]),
		  (*
		   ... or the types of the variables don't match
		   *)
		  If[matchTypes[type1, type2] === Alpha`bottom,
		     Return[{}],
		     Alpha`system[n, p, i, o,
				  DeleteCases[locals,
					      Alpha`decl[varName2, _,_]]
				  /. (Alpha`decl[varName1, _, _]
				      -> Alpha`decl[mergedName,
						    matchTypes[type1, type2],
						    convexize[
						      DomUnion[
							domDecl1,
							domDecl2]]]),
				  (DeleteCases[equas,
					       Alpha`equation[varName2, _]]
				   /. Alpha`equation[varName1, _]
				   ->
				   buildUnionMergeEquation[
				     mergedName,
				     domDecl1,
				     domVar2ButVar1,
				     defVar1,
				     defVar2])
				    /. {Alpha`var[varName1]
					-> Alpha`restrict[domDecl1,
							  Alpha`var[mergedName]],
					Alpha`var[varName2] ->
					Alpha`restrict[domDecl2,
						       Alpha`var[mergedName]]}]]]]]]


(* building the equation of the new variable *)

Clear[buildUnionMergeEquation]
buildUnionMergeEquation[mergedName_String,
			domDecl1_Alpha`domain,
			domVar2ButVar1_Alpha`domain,
			defVar1_,
			defVar2_] :=
  Alpha`equation[
    mergedName,
    Alpha`case[{Alpha`restrict[domDecl1, defVar1],
		Alpha`restrict[domVar2ButVar1, defVar2]}]]


(* merging of case alternatives: useful after normalization of a case *)
(* first step: extract selected restrictions, then compare their expressions;
   if the expressions are identical, merge the branches into a single one and
   insert the new branch at the position of the first (leftmost) removed
   branch *)

(* the cases are supposed to be in non-degenerate form: alternatives _must_ be
   restrictions ...
 *)

Clear[unionMergeCaseBranches]
unionMergeCaseBranches[pos:{_Integer..}, branch1_Integer, branch2_Integer] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = unionMergeCaseBranches[Alpha`$program, pos, branch1, branch2])

unionMergeCaseBranches[sys_Alpha`system,
		       pos:{_Integer..},
		       branch1_Integer,
		       branch2_Integer] :=
  With[{caseExp = accessByPath[sys, pos]},
       If[Head[caseExp] =!= Alpha`case,
	  (Print["? mergeCaseBranches: cannot handle non-case expressions!"] ;
	   show[caseExp]),
	  With[{useDomain = getContextDomain[sys, pos],
		b1 = Part[Part[caseExp, 1], branch1],
		b2 = Part[Part[caseExp, 1], branch2]},
	       With[
		 {dom1 = Part[b1, 1],
		  expr1 = Part[b1, 2],
		  dom2 = Part[b2, 1],
		  expr2 = Part[b2, 2]},
		 Block[
		   {finalDom = {}, finalExpr = {}},
		   If[exprLocalEquivQ[expr1, expr2, dom1], (* extend expr2 *)
		      (finalDom = convexize[DomUnion[dom1, dom2]] ;
		       finalExpr = expr2),
		      If[exprLocalEquivQ[expr1, expr2, dom2],(* extend expr1 *)
			 (finalDom = convexize[DomUnion[dom1, dom2]] ;
			  finalExpr = expr1),
			 (Print["? Cannot merge branches: expressions cannot be extended"] ;
			  Return[sys])]] ;
		   ReplacePart[sys,
			       Insert[Delete[caseExp,
					     Map[List[1, #]&, {branch1,  branch2}]],
				      Alpha`restrict[finalDom, finalExpr],
				      {1, Min[branch1, branch2]}],
			       pos]]]]]]

		      

(* previously in the Equivalence Package *) 

Clear[exprLocalEquivQ]

(* end point: equal expressions ... domain doesn't matter *)
exprLocalEquivQ[expr1_, expr1_, dom_Alpha`domain] :=  True

exprLocalEquivQ[expr1_, expr2_, dom_Alpha`domain] :=
  (
(* same heads: explore the internals *)
  If[SameQ[Head[expr1], Head[expr2]],
  (If[Length[expr1] =!= Length[expr2],
      Return[False],				(* fail if different arities *)
      If[Head[expr1]  === Alpha`var,
	 If[expr1 === expr2,Return[True],Return[False]],
      If[Head[expr1]  === Integer,
 	 If[expr1 === expr2,Return[True],Return[False]],     
      If[Head[expr1]  === Real,
 	 If[expr1 === expr2,Return[True],Return[False]],       
      If[Head[expr1]  === Symbol,
 	 If[expr1 === expr2,Return[True],Return[False]],       
    If[Head[expr1] === Alpha`affine,	(* if affines, then check USE sets *)
	 With[{fn1 = Part[expr1, 2],	(* if the affines are distinct, *)
	       fn2 = Part[expr2, 2]},	(* then check the image of dom *)
		If[fn1 =!= fn2,		
		 With[{d1 = DomImage[dom, fn1],
		       d2 = DomImage[dom, fn2]},
		      If[Or[!DomEmptyQ[DomDifference[d1, d2]],
			    !DomEmptyQ[DomDifference[d2, d1]]],
			 Return[False],	(* fail if images differ *)
			 Null]],
		 Null]],
       If[Head[expr1] === Alpha`index,	(* if index exprs,check USE sets *)
	 With[{fn1 = Part[expr1, 1],	(* if the affines are distinct, *)
	       fn2 = Part[expr2, 1]},	(* then check the image of dom *)
	      If[fn1 =!= fn2,		
		 With[{d1 = DomImage[dom, fn1],
		       d2 = DomImage[dom, fn2]},
		      If[Or[!DomEmptyQ[DomDifference[d1, d2]],
			    !DomEmptyQ[DomDifference[d2, d1]]],
			 Return[False],	(* fail if images differ *)
			 Null]],
		 Null]],	
	 Null]]]]]]];			(* otherwise check subterms ... *)
   Apply[And, MapThread[exprLocalEquivQ[#1, #2, dom]&,
			{Map[Part[expr1, #]&, Table[i, {i, 1, Length[expr1]}]],
			 Map[Part[expr2, #]&, Table[i, {i, 1,
							Length[expr2]}]]}]]),

(* Not the same head - check for identity dependence functions *)
     If[Xor[Head[expr1] === Alpha`affine,
		    Head[expr2] === Alpha`affine],
	If[Head[expr1] === Alpha`affine,(* should expr1 be Alpha`affine *)
	     If[identityQ[Part[expr1, 2]],(* check if it's the identity *)
		  exprLocalEquivQ[Part[expr1, 1], expr2], (* if so, replace by its expr *)
	     Return[False]],
	     If[identityQ[Part[expr2, 2]],(* check if expr2 contains identity*)
		  exprLocalEquivQ[Part[expr1, 1], expr2], (* if so, replace by its expr *)
             Return[False]]
        ],				(* fail otherwise *)	  
     Return[False]] 
])

(* kitchen sink: failing *)
exprLocalEquivQ[___] := Message[exprLocalEquivQ::params];


Clear[splitCaseUnion]

splitCaseUnion[]:=
  Module[{res},
	 res=splitCaseUnion[$result];
	 If [MatchQ[res, Alpha`system[___]],
	     $result=res,
	     $result]
       ]

splitCaseUnion[sys1:_Alpha`system]:=
  Module[{res},
	 res=ReplacePart[sys1,
		       Map[splitCaseUnion,sys1[[6]]],
		       6];
	 If [MatchQ[res, Alpha`system[___]],
	     res,
	     sys1]
       ]

splitCaseUnion[eq1:_Alpha`equation]:=
  Module[{res,newBranches,curBranch,curDom,splittedDom,newSplittedDom,
	  curNewBranch},
	 If [Position[eq1,Alpha`case,Infinity]==={},
	     res=eq1,
	     If [Length[Position[eq1,Alpha`case,Infinity]]=!=1,
		 Print["Warning, (var ",eq1[[1]],
		       " splitCaseUnion should be used on  normalized programs"];
		 res=eq1,
		 newBranches={};
		 Do [curBranch=eq1[[2,1,i]];
		     If [!MatchQ[curBranch[[0]],Alpha`restrict],
			 newBranches=Append[newBranches,curBranch],
			 (* this is the case where we try to spit case
			    branch. If the branch is 
			    Alpha`restrict[Dom1 U Dom2, branch],
			    We replace it by two branches  
			    Alpha`restrict[Dom1\Dom2, branch],
			    Alpha`restrict[Dom2, branch],
			    *)
			   curDom=curBranch[[1]];
			 splittedDom=Map[Alpha`domain[curDom[[1]],
						      curDom[[2]],
						      {#}]
					 &,curDom[[3]]];
			 If [Length[splittedDom]>1,
			     newSplittedDom={};
			     Do[curCurDom=splittedDom[[k]];
				Do[curOtherDom=splittedDom[[kk]];
				   curCurDom=
				     DomDifference[curCurDom,curOtherDom],
				   {kk,k+1,Length[splittedDom]}];
				If [!DomEmptyQ[curCurDom],
				    newSplittedDom=Append[newSplittedDom,
							  curCurDom]],
				{k,1,Length[splittedDom]}],
			     newSplittedDom=splittedDom];
			 Do[curNewBranch=
			      Alpha`restrict[newSplittedDom[[j]],
					     curBranch[[2]]];
			   newBranches=Append[newBranches,curNewBranch],
			    {j,1,Length[newSplittedDom]}]; (* enddo *)
		       ];     
		     ,{i,1,Length[eq1[[2,1]]]}];
		 res=ReplacePart[eq1,newBranches,{2,1}];
	       ]; (* if several cases *)
	   ]; (* if no cases *)
	 res]
		 
splitCaseUnion[___]:=Message[splitCaseUnion::WrongArg]

splitCaseUnion::WrongArg="Wrong Argument for splitCaseUnion"


End[]
EndPackage[]
