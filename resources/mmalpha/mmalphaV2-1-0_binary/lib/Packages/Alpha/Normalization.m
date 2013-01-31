(* file: $MMALPHA/lib/Package/Alpha.m
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
   Place - Suite 330, Boston, MA  02111-1307, USA.   
*)
BeginPackage["Alpha`Normalization`", {"Alpha`Domlib`",
				      "Alpha`",
                                      "Alpha`Options`",
				      "Alpha`Matrix`", 
				      "Alpha`Tables`",
				      "Alpha`Semantics`",
				      "Alpha`SubSystems`",
				      "Alpha`Substitution`"}]

(* $Id: Normalization.m,v 1.3 2009/05/22 10:24:37 quinton Exp $ Z. Chamski & M. Le Bouder

   changelog:
   5/14/1993, Z. Chamski: 	updated wrt. names in Substitution`
   6/04/1993, Z. Chamski: 	updated wrt. the new format of documentation
				 strings
   7/02/1993, Z. Chamski: 	added restriction simplification
   7/16/1993, Z. Chamski: 	cleaned internal checking functions, added
                          	 contextual checks.
   10/25/1993, Z. Chamski: 	Added Alpha0 normalization functions.
   11/04/1993, Z. Chamski: 	cleaned bug in DepIdent normalization rule.
   11/17/1993, Z. Chamski: 	cleaned 2 bugs in IfCaseElse & IfRestElse.
				 Added clearing of rule definitions.
   11/29/1993, Z. Chamski:	Restored identity dependence normalization
				 (see fix for ChangeOfBasis at the same date.)
				Removed 'normalSubstit' (unused.)
				Cleaned and completed the documentation strings.

   Sept 1994,  M. Le Bouder:    normalizeA[]; normalize[]; analyze[]; 
                                fshow[]
   March 1995, D. Wilde:        various things...
   March 1995, P. Quinton:      usage statements modified. 
    bug in simplifyInContext corrected ($program replaced by 
    Alpha`$program).
*)

(* "Normalization" needs to access definitions contained in packages
   "Alpha`Matrix`", "Alpha`Tables`" and "Alpha`Substitution`" *)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:37 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Normalization.m,v $
	$Revision: 1.3 $
	$Log: Normalization.m,v $
	Revision 1.3  2009/05/22 10:24:37  quinton
	May 2009
	
	Revision 1.2  2008/07/27 13:29:56  quinton
	Most recent version.
	
	Revision 1.1.1.1  2005/03/07 15:32:14  trisset
	testing mmalpha repository
	
	Revision 1.36  2004/09/16 13:46:50  quinton
	Updated version
	
	Revision 1.35  2004/07/13 08:48:46  quinton
	In simplySystem, added two options remIdDeps and remIdEqus, that allow
	removing identity equations and identity matrices.
	
	Revision 1.34  2004/06/16 14:57:29  risset
	switched to ZDomlib
	
	Revision 1.33  2004/01/09 16:49:40  quinton
	Minor documentation corrections
	
	Revision 1.32  2003/07/18 12:52:40  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.30  2002/09/10 15:10:32  quinton
	Minor corrections
	
	Revision 1.29  2002/07/16 12:19:39  quinton
	Some cosmetic changes.
	
	Revision 1.28  2002/06/07 11:56:50  quinton
	Minor editing correction.
	
	Revision 1.27  2001/09/03 06:27:46  quinton
	The option value Alpha0 is now defined in Options.m and not a global
	variable anymore.
	
	Revision 1.25  2001/08/16 07:27:16  quinton
	Null added in a If
	
	Revision 1.24  2001/04/21 06:56:51  quinton
	Changed file format from dos to unix
	
	Revision 1.23  2001/04/21 05:09:31  quinton
	Minor corrections
	
	Revision 1.22  2000/02/14 08:25:20  risset
	correct a bug in DomEqulities
	
	Revision 1.21  1999/12/21 14:09:27  risset
	corrected DomImage and add Normalization pof reduces
	
	Revision 1.20  1999/12/10 16:59:03  risset
	commited struct Sched and ZDomlib
	
	Revision 1.19  1999/05/18 16:24:26  risset
	change many packages for documentation
	
	Revision 1.18  1999/05/10 13:14:14  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.17  1999/03/02 15:49:23  risset
	added GNU software text in each packages
	
	Revision 1.16  1999/02/01 14:08:32  risset
	Generalized simplifyInContext to declaration and use
	
	Revision 1.15  1998/12/16 13:38:33  risset
	added simplifySchedule
	
	Revision 1.14  1998/11/27 12:20:16  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.12  1998/04/10 08:03:16  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.11  1998/01/09 10:26:12  quillere
	added transformation rules for external calls

	Revision 1.10  1998/01/05 14:15:52  quillere
	added transformation rules for external calls

	Revision 1.9  1997/05/19 10:41:12  risset
	corrected exported bug in depedancies

	Revision 1.8  1997/05/13 13:40:51  risset
	report Patrice modifs on usage

	Revision 1.7  1997/04/22 10:57:21  risset
	removed some cycling dependencies between packages

	Revision 1.6  1997/04/10 09:19:37  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.5  1996/07/05 15:14:00  fdupont
	removed tabs in message files

	Revision 1.4  1996/06/24 13:54:45  risset
	added standard head comments for CVS



*)
Alpha`Normalization::note = 
"Documentation revised on August 1, 2004";

Alpha`Normalization::usage =
"Alpha`Normalization` is the package containing the definitions 
of normalization rules along with basic 
normalizing functions: 
checkRestrictions, minRestrictInCtxt, normalize, normalize0, 
normalizeDef, normalizeDef0, normalizeInCtxt, normalizeInCtxt0, 
normalizeQ, normalize0Q, and simplifyInContext.";

checkRestrictions::usage =
"checkRestrictions[ast] checks for redundant restrictions in a normalized 
system. Default ast is Alpha`$result.";

checkRestrictions::note =
"This function is useful after normalizing a complete system, in order to
remove redundant restrictions. It cannot be included in the set normalization
rules because it needs contextual information wrt. the normalized expression
(it requires the declaration of a variable)."

minRestrictInCtxt::usage =
"minRestrictInCtxt[ast,domain] simplifies all restrictions of a 
program in the context of a specific domain. Returns the simplified 
expression.";

normalize::usage = 
"normalize[option] normalizes program $result with the given
option. normalize[sys,option] normalizes ALPHA expression sys with
the given option. The available option is indexnorm which should
be set to True if normalization of index expressions is desired. The
default option is False.";

normalize::note =
"normalize[exp] computes the fixpoint of a set of normalization rules
when applied to exp. The set of rules is contained in variable
normalizationRules.";

normalize0::usage =
"normalize0[ast] normalizes an ALPHA expression ast wrt. Alpha0 rules 
(allowing nested cases.) Default ast is Alpha`$result.";

normalize0::note =
"normalize[exp] computes the fixpoint of a set of normalization rules
when applied to exp. The set of rules is contained in variable
normalizationRules0.";

normalizeDef::usage = 
"normalizeDef[symbol] normalizes the definition of ALPHA variable symbol in
$result. normalizeDef[sys,symbol] normalizes the definition of ALPHA
variable symbol in program sys. Variable symbol is a
string."

normalizeDef::note =
"normalizeDef[exp, var] computes the fixpoint of a set of normalization
rules when applied to the definition of var in exp. The set of rules is
contained in variable normalizationRules.";

normalizeDef0::usage =
"normalizeDef0[symbol] normalizes the definition of ALPHA variable symbol in
$result wrt. the rules of Alpha0 (allowing nested cases).
normalizeDef0[sys,symbol]normalizes the definition of ALPHA
variable symbol in program sys. Variable symbol is a string."

normalizeDef0::note =
"normalizeDef[exp, var] computes the fixpoint of a set of normalization
rules when applied to the definition of var in exp. The set of rules is
contained in variable normalizationRules0.";

normalizationRules::usage =
"Set (list) of rewrite rules specifying the normalization of an
ALPHA expression towards the CRD (Case-Restriction-Dependence) 
normal form."

normalizationRules::note =
"normalizationRules can be extended by appending/prepending new rules to
the initial list. The rules are named and have the form 
name = exp1 :> exp2.";

normalizationRules0::usage =
"Set (list) of rewrite rules specifying the normalization of an
ALPHA expression towards the Alpha0 (NestedCase-Restriction-Dependence) normal
form.";

normalizationRules0::note =
"normalizationRules0 can be extended by modifying the value of the
rule list. The rules are named and have the form name = exp1 :> exp2.
"

(* simplifyRestrictions::usage =
"simplifyRestructions[ast,var] simplifies all the restrictions 
in an ALPHA program or expression wrt. the declaration domain of 
the corresponding LHS variable. Defaults ast is Alpha`$result. 
var is a LHS variable name (OPTIONAL, symbol or string.)
REMARK: the LHS variable name forces the declaration domain to 
be that of the variable given. This form should always be used 
in conjunction with an ALPHA program.";

simplifyRestrictions::note =
"OBSOLETE. Replace with simplifyInContext[].
Computes the fixpoint of 'minRestrictInCtxt' applied
to the construct given as parameter. It does NOT remove empty/universal
restrictions (this should probably be corrected.)" *)

normalizeInCtxt::usage =
"normalizeInCtxt[ast,domain] returns a normalized and reduced form of
the restriction of ast to domain.";

normalizeInCtxt::note =
"'normalizeInCtxt' should perhaps operate in a more intelligent way."

normalizeInCtxt0::usage =
"Function. Normalizes an expression in the context of a specific domain."

normalizeInCtxt0::note =
"normalizeInCtxt0 should perhaps operate in a more intelligent way."

normalizeQ::usage =
"normalizeQ[ast] returns True if ast is normalized, False otherwise.
Default value for ast is Alpha`$result.";

normalize0Q::usage =
"normalize0Q[ast] returns True if ast is normalized, False otherwise.
Default value for ast is Alpha`$result.";

correctMat::usage = " in test "

correctAffineFunctions::usage= "in test 2"
 
simplifyInContext::usage =
"simplifyInContext[] simplifies and reduces the Alpha system 
$result in the following ways: simplifies restriction domains 
in context of declaration, simplifies transformations in context 
of declaration. It operates on normalized or unnormalized programs.
simplifyInContext[sys] simplifies and reduces the Alpha system 
sys and returns the simplified system. Does not change $result.
simplifyInContext[sys, exp] simplifies expression exp in the 
context of sys and returns the simplified expression."

simplifySystem::usage=
"simplifySystem[] is just a shorthand for simplifyInContext[];
convexizeAll[];normalize[] (or normalize0 depending on the option). 
simplifySystem[sys] return system sys modified without 
modifying $result";

simplificationRules::usage = "";

normalizationRules2::usage =
"Set (list) of rewrite rules specifying the simplification
of a Quast.";

Begin["`Private`"]

normalizationRules1::usage =
"Set (list) of rewrite rules specifying the normalization of an
ALPHA expression towards the Alpha0 for the simulator ." 

Alpha`Normalizationtodo::usage = "Doran has said that simplifyRestrictions
is obsolete. The corresponding code should be removed. Functions
FusionneVars and FusionneCase should start with lower case letters...
In the long term, Normalization should be rewritten, without using 
rewrite rules, in order to become more efficient.";

minRestrictInCtxt::note =
"'minRestrictInCtxt' operates by iteratively replacing the restrictions
appearing in the expression until a fixpoint is found. It does NOT perform
normalization of expressions, nor does it remove empty/universal
restrictions (the latter should probably be corrected.)"

checkRestrictionsInCtxt::usage =
"Function. Removes redundant restrictions (wrt. a domain) from an
expression."

normalize1::usage =
"normalize1[ast] returns the alpha program  with
a domain by block. Default value for ast is 'Alpha`$result'."

normalizeA::usage =
"normalizeA[ast] returns the alpha0 program normalized. It returns
the Alpha program. Default value for ast is 'Alpha`$result'."

FusionneCase::usage =
"Returns the Alpha program with distincts expressions in all
the branches of the case. It take in input a list of equations,
and the result is the same list of equations but with the
case changed."

FusionneVars::usage =
"Returns the Alpha program with all its expressions distincts.
 It takes as input a list of equations,
and the result is the same list of equations but with one definition
per variable."
mulIndexExprByConst::usage = 
"A function to multiply index expressions by constants.
 e.g. (i,j -> 2i-3j)*(-1) becomes (i,j -> -2i+3j).
 Used in normalization of index expressions"

addIndex::usage = 
"A function to add two index expressions.
 e.g   (i,j -> 2i+3j+4)+(i,j -> 3i-4j-8) = (i,j -> 5i-j-4)
 Used in normalization of index expressions"

subIndex::usage = 
"A function to subtract two index expressions.
 e.g   (i,j -> 2i+3j+4)-(i,j -> 3i-4j-8) = (i,j -> -i+7j+12) 
 Used in normalization of index expressions"

constToIndex::usage = 
"A function used to convert constants into index expressions.
 e.g   5.(i,j,N-> ) becomes (i,j,N->5) "

indexToConst::usage =
"A function used to convert constant index expressions to constants.
 e.g. (i,j->5) becomes 5.(i,j ->).Used in normalization of index expressions."

Alpha`Normalizationbugs = "Not known";

Alpha`Normalizationlastmodif = "March 1995. Merging the 3 different
Normalization packages. PQ";

(* the first part of this code contains the definitions of normalization
   rules, grouped by the type of the outermost operator. The second one
   contains the definitions of normalization functions and those of basic
   "normalizing" sequences of low-level transformations. *)

(*
   This was added by Patrice, as a tentative to apply obvious simplification
   rules 

 *)
Clear[ caseInCase ];
caseInCase = 
RuleDelayed[
 case[{case[a:{__}],case[b:{__}]}],
 case[Join[a,b]]
];

Clear[ caseSameExp ];
caseSameExp =
RuleDelayed[
 case[{___,restrict[r1:_,x:_],___,restrict[r2:_,x:_],___}],
 restrict[ DomConvex[ DomUnion[r1,r2] ], x ]
];

Clear[ gtTrue ];
gtTrue = 
RuleDelayed[
  binop[ gt, x:_, x:_],
  "true"
];

Clear[ ifTrueCond ];
ifTrueCond = 
RuleDelayed[
  if[ "true", x:_, y:_ ],
  x
];

Clear[ ifFalseCond ];
ifFalseCond = 
RuleDelayed[
  if[ "false", x:_, y:_ ],
  y
];

Clear[ ifEqualBranches ];
ifEqualBranches = 
RuleDelayed[
  if[ _, x:_, x:_ ],
  x
];

Clear[ caseEqualBranches ];
caseEqualBranches = 

(*************************************************************)
(* OPERATORS/something: distribution of "immobile" operators *)
(*************************************************************)

(* distributivity of Call over Case *)
callCase = RuleDelayed[
  call[f:_,{h:___, case[lc_:List], t:___}],
  case[Map[call[f,{h,#,t}]&, lc]]
];

(* distributivity of Call over Restriction *)
callRestrict = RuleDelayed[
  call[f:_, {h:___, restrict[dom:_, exp:_], t:___}],
  restrict[dom, call[f, {h, exp, t}]]
];

Clear[test]
test[]:= Print["Just checking"]

callAffine = RuleDelayed[
  affine[call[f:_, args:{___}],m:_matrix],
  call[f,affine[#,m]&/@args]
];

(* distributivity of Binop over Case: LHS operand *)
Clear[BinopCaseLeft]
BinopCaseLeft =
  Alpha`binop[op_,
	      Alpha`case[l_List],
	      y_] :> Alpha`case[Map[(Alpha`binop[op, #, y])&, l]]

(* distributivity of Binop over Case: RHS operand *)
Clear[BinopCaseRight]
BinopCaseRight =
  Alpha`binop[op_,
	      x_,
	      Alpha`case[l_List]
	    ] :> Alpha`case[Map[(Alpha`binop[op, x, #])&, l]]

(* absorption of Binop by an EmptyTerm *)
Clear[BinopEmptyTerm]
BinopEmptyTerm =
  Alpha`binop[_, x_, y_] :> {} /; MemberQ[{x, y}, {}]

(* distributivity of Binop over Restriction: LHS operand *)
Clear[BinopRestLeft]
BinopRestLeft =
  Alpha`binop[op_,
	      Alpha`restrict[dom_, exp_],
	      y_] :> Alpha`restrict[dom, Alpha`binop[op, exp, y]]

(* distributivity of Binop over Restriction: RHS operand *)
Clear[BinopRestRight]
BinopRestRight =
  Alpha`binop[op_,
	      x_,
	      Alpha`restrict[dom_, exp_]
	    ] :> Alpha`restrict[dom, Alpha`binop[op, x, exp]]

(* distributivity of Unop over Case *)
Clear[UnopCase]
UnopCase =
  Alpha`unop[op_,
	     Alpha`case[l_List]] :> Alpha`case[Map[(Alpha`unop[op, #])&, l]]

(* absorption of Unop by an EmptyTerm *)
Clear[UnopEmptyTerm]
UnopEmptyTerm =
  Alpha`unop[_, {}] :> {}

(* distributivity of Unop over Restriction *)
Clear[UnopRest]
UnopRest =
  Alpha`unop[op_,
	     Alpha`restrict[dom_, exp_]
	   ] :> Alpha`restrict[dom, Alpha`unop[op, exp]]

(*****************************************************************)
(* DEPENDENCE/something: distribution of the dependence operator *)
(*****************************************************************)

(* distributivity of Dep over operands of a Binop *)
Clear[DepBinop]
DepBinop =
  Alpha`affine[Alpha`binop[op_, x_, y_],
	       mx_] :> Alpha`binop[op,
				   Alpha`affine[x, mx],
				   Alpha`affine[y, mx]]

(* Distributivity of Dep over Case *)
Clear[DepCase]
DepCase =
  Alpha`affine[Alpha`case[l_List],
	       mx_] :> Alpha`case[Map[(Alpha`affine[#, mx])&, l]]

(* composition of dependences *)
Clear[DepDep]
DepDep =
  Alpha`affine[Alpha`affine[x_, mx1_],
	       mx2_] :> 
  Alpha`restrict[
		 DomZPreimage[DomUniverse[mx2[[1]]-1],mx2],
		 Alpha`affine[x, composeAffines[mx1, mx2]]
  ]
  

(* absorption of dependancy by index expression *)
Clear[DepIndex]
DepIndex =
  Alpha`affine[Alpha`index[mx1_],mx2_] :> 
	       		Alpha`restrict[
	       			DomZPreimage[DomUniverse[mx2[[1]]-1],mx2],
                                Alpha`index[composeAffines[mx1, mx2]]
 ] 

(* absorption of Dep by an EmptyTerm *)
Clear[DepEmptyTerm]
DepEmptyTerm =
  Alpha`affine[_, {}] :> {}

(* identity dependence *)
Clear[DepIdent]
DepIdent =
  Alpha`affine[exp_, m_] /; (Head[exp]=!=Alpha`var) && identityQ[m] :> exp

(* distributivity of Dep over If *)
Clear[DepIf]
DepIf =
  Alpha`affine[Alpha`if[c_, t_, e_],
	       mx_] :> Alpha`if[Alpha`affine[c, mx],
				Alpha`affine[t, mx],
				Alpha`affine[e, mx]]

(* change *)
(* distributivity of Dep over Restriction. Must be COMPLETED *)
Clear[DepRest]
DepRest =
  Alpha`affine[Alpha`restrict[dom_, exp_],
	       mx_] :> Alpha`restrict[DomZPreimage[dom, mx],
					 Alpha`affine[exp, mx]]

(* distributivity of Dep over operand of a Unop *)
Clear[DepUnop]
DepUnop =
  Alpha`affine[Alpha`unop[op_, x_],
	       mx_] :> Alpha`unop[op, Alpha`affine[x, mx]]

(* distributivity of Restriction over Case *)

(***********************************************************************)
(* reduce operator:  distributivity of the reduce in the case braches  *) 
(* added quickly by Tanguy, needs a more serious study            
 Warning, There is a reference to $result, because I want to have the 
 name of the parameters for DomImage *)

(***********************
removed quickly by Tanguy because this was false 

Clear[ReduceCase]
ReduceCase =
  Alpha`reduce[oper_,mat1_,Alpha`case[l_List]]:>
  Alpha`case[Map[(Alpha`reduce[oper,mat1, #])&, l]]

(* change *)
Clear[ReduceRestrict]
ReduceRestrict =
  Alpha`reduce[oper_,mat1_,Alpha`restrict[dom_,expr_]]:>
  Alpha`restrict[DomImage[dom,mat1,$result[[2]]],Alpha`reduce[oper,mat1,expr]]
  (*******??????????*********)

************************************************)

(***********************************************************************)
(* CASE operator: absorption of nested cases and removal of empty ones *)
(***********************************************************************)

(* absorption of Case inside another Case *)
Clear[CaseCase]
CaseCase =
  Alpha`case[{x___,Alpha`case[{y___}],z___}] :> Alpha`case[{x,y,z}]

(* Removal of empty cases *)
Clear[CaseEmptyRemove]
CaseEmptyRemove =
  Alpha`case[l_List /; MemberQ[l, {}]] :> Alpha`case[DeleteCases[l, {}]]

(* Replacement of a single case w/its alternative *)
Clear[CaseSingleReplace]
CaseSingleReplace =
  Alpha`case[{exp_}] :> exp 

(*************************************************)
(* IF/something: distribution of the IF operator *)
(*************************************************)

(* distributibity of If over Case appearing in the condition *)
Clear[IfCaseCond]
IfCaseCond =
  Alpha`if[Alpha`case[l_],
	   t_,
	   e_] :> Alpha`case[Map[(Alpha`if[#, t, e])&, l]]

(* distributivity of If over Case appearing in the "then" part *)
Clear[IfCaseThen]
IfCaseThen =
  Alpha`if[c_,
	   Alpha`case[l_],
	   e_] :> Alpha`case[Map[(Alpha`if[c, #, e])&, l]]

(* distributivity of If over Case appearing in the "else" part *)
Clear[IfCaseElse]
IfCaseElse =
  Alpha`if[c_,
	   t_,
	   Alpha`case[l_]] :> Alpha`case[Map[(Alpha`if[c, t, #])&, l]]

(* absorption of If by an EmptyTerm *)
Clear[IfEmptyTerm]
IfEmptyTerm =
  Alpha`if[c_, t_, e_] :> {} /; MemberQ[{c,t,e}, {}]

(* distributibity of If over Restriction appearing in the condition *)
Clear[IfRestCond]
IfRestCond =
  Alpha`if[Alpha`restrict[dom_, exp_],
	   t_,
	   e_] :> Alpha`restrict[dom, Alpha`if[exp, t, e]]

(* distributivity of If over Restriction appearing in the "then" part *)
Clear[IfRestThen]
IfRestThen =
  Alpha`if[c_,
	   Alpha`restrict[dom_, exp_],
	   e_] :> Alpha`restrict[dom, Alpha`if[c, exp, e]]

(* distributivity of If over Restriction appearing in the "else" part *)
Clear[IfRestElse]
IfRestElse =
  Alpha`if[c_,
	   t_,
	   Alpha`restrict[dom_, exp_]] :> Alpha`restrict[dom,
							 Alpha`if[c, t, exp]]


(****************************************************************)
(* RESTRICT/something: distribution of the Restriction operator *)
(****************************************************************)

(* distributivity of Restriction over Case *)
Clear[RestCase]
RestCase =
  Alpha`restrict[dom_,
		 Alpha`case[l_List]] :> Alpha`case[
		   Map[(Alpha`restrict[dom, #])&, 
		       l]]

(* Check for empty Domain in Restriction *)
Clear[RestEmptyDomain]
RestEmptyDomain =
  Alpha`restrict[dom_ /; DomEmptyQ[dom],
		 _] :> {}

(* Absorption of Restriction by EmptyTerm *)
Clear[RestEmptyTerm]
RestEmptyTerm =
  Alpha`restrict[_, {}] :> {}

(* Removal of "universal" restrictions (domain == universe) *)
Clear[RestUniverseReplace]
RestUniverseReplace =
 Alpha`restrict[d:Alpha`domain[_,
			       _,
			       {Alpha`pol[1,_,0,_,_,_]}] /; DomUniverseQ[d],
		exp_] :> exp

(* absorption of Restriction in another Restriction *)
Clear[RestRest];
RestRest =
  Alpha`restrict[dom1_,
		 Alpha`restrict[dom2_, exp_]] :>
  Alpha`restrict[DomIntersection[dom1, dom2], exp];


(* The Normalization rules for simplifying index expressions    *)

Clear[ConstTimesIndex]
ConstTimesIndex = 
 Alpha`binop[mul,Alpha`affine[Alpha`const[c_],m1_],Alpha`index[m2_]] /; (IntegerQ[c] || Head[c]==Rational) :> mulIndexExprByConst[Alpha`index[m2],c]

Clear[IndexTimesConst]
IndexTimesConst = 
 Alpha`binop[mul,Alpha`index[m1_],Alpha`affine[Alpha`const[c_],m2_]] /; (IntegerQ[c] || Head[c]==Rational) :> mulIndexExprByConst[Alpha`index[m1],c]

Clear[IndexToConst]
IndexToConst = 
 Alpha`index[m_] /; (Table[0,{i,1,m[[2]]-1}] === Drop[m[[4,1]],-1]) :> indexToConst[Alpha`index[m]]

Clear[ConstToIndex]
ConstToIndex = 
 Alpha`affine[Alpha`const[c_],m_] /; (IntegerQ[c] || Head[c]==Rational) :>
  constToIndex[Alpha`affine[Alpha`const[c],m]]

Clear[IndexPlusIndex]
IndexPlusIndex = 
 Alpha`binop[add,Alpha`index[m1_],Alpha`index[m2_]] :>
  addIndex[Alpha`index[m1],Alpha`index[m2]] 


Clear[IndexMinusIndex]
IndexMinusIndex = 
 Alpha`binop[sub,Alpha`index[m1_],Alpha`index[m2_]] :>
  subIndex[Alpha`index[m1],Alpha`index[m2]]


Clear[ExprPlusIndex]
ExprPlusIndex = 
 Alpha`binop[add,E_,Alpha`index[m_]]  :>
  Alpha`binop[add,Alpha`index[m],E]


Clear[ExprMinusIndex]
ExprMinusIndex = 
 Alpha`binop[sub,E_,Alpha`index[m_]] :>
  Alpha`binop[add,mulIndexExprByConst[Alpha`index[m],-1],E]


Clear[Index1PlusIndex2PlusExpr]
Index1PlusIndex2PlusExpr = 
 Alpha`binop[add,Alpha`index[m1_],Alpha`binop[add,Alpha`index[m2_],E_]] :> Alpha`binop[add,addIndex[Alpha`index[m1],Alpha`index[m2]],E]

Clear[Index1PlusIndex2MinusExpr]
Index1PlusIndex2MinusExpr = 
 Alpha`binop[add,Alpha`index[m1_],Alpha`binop[sub,Alpha`index[m2_],E_]] :> Alpha`binop[sub,addIndex[Alpha`index[m1],Alpha`index[m2]],E]

Clear[Index1MinusIndex2PlusExpr]
Index1MinusIndex2PlusExpr = 
 Alpha`binop[sub,Alpha`index[m1_],Alpha`binop[add,Alpha`index[m2_],E_]] :> Alpha`binop[sub,subIndex[Alpha`index[m1],Alpha`index[m2]],E]

Clear[Index1MinusIndex2MinusExpr]
Index1MinusIndex2MinusExpr = 
 Alpha`binop[sub,Alpha`index[m1_],Alpha`binop[sub,Alpha`index[m2_],E_]] :> Alpha`binop[add,subIndex[Alpha`index[m1],Alpha`index[m2]],E]


Clear[Expr1PlusIndexPlusExpr2]
Expr1PlusIndexPlusExpr2 = 
 Alpha`binop[add,E1_,Alpha`binop[add,Alpha`index[m_],E2_]] :>
  Alpha`binop[add,Alpha`index[m],Alpha`binop[add,E1,E2]]


Clear[Expr1PlusIndexMinusExpr2]
Expr1PlusIndexMinusExpr2 = 
 Alpha`binop[add,E1_,Alpha`binop[sub,Alpha`index[m_],E2_]] :>
  Alpha`binop[add,Alpha`index[m],Alpha`binop[sub,E1,E2]]


Clear[Expr1MinusIndexPlusExpr2]
Expr1MinusIndexPlusExpr2 = 
 Alpha`binop[sub,E1_,Alpha`binop[add,Alpha`index[m_],E2_]] :>
  Alpha`binop[add,mulIndexExprByConst[Alpha`index[m],-1],Alpha`binop[sub,E1,E2]]


Clear[Expr1MinusIndexMinusExpr2]
Expr1MinusIndexMinusExpr2 = 
 Alpha`binop[sub,E1_,Alpha`binop[sub,Alpha`index[m_],E2_]] :>
  Alpha`binop[add,mulIndexExprByConst[Alpha`index[m],-1],Alpha`binop[add,E1,E2]]


Clear[IndexPlusExpr1PlusExpr2]
IndexPlusExpr1PlusExpr2 = 
 Alpha`binop[add,Alpha`binop[add,Alpha`index[m_],E1_],E2_] :>
  Alpha`binop[add,Alpha`index[m],Alpha`binop[add,E1,E2]]


Clear[IndexPlusExpr1MinusExpr2]
IndexPlusExpr1MinusExpr2 = 
 Alpha`binop[sub,Alpha`binop[sub,Alpha`index[m_],E1_],E2_] :>
  Alpha`binop[add,Alpha`index[m],Alpha`binop[sub,E1,E2]]


Clear[IndexMinusExpr1PlusExpr2]
IndexMinusExpr1PlusExpr2 = 
 Alpha`binop[add,Alpha`binop[sub,Alpha`index[m_],E1_],E2_] :>
  Alpha`binop[add,Alpha`index[m],Alpha`binop[sub,E2,E1]]


Clear[IndexMinusExpr1MinusExpr2]
IndexMinusExpr1MinusExpr2 = 
 Alpha`binop[sub,Alpha`binop[sub,Alpha`index[m_],E1_],E2_] :>
  Alpha`binop[sub,Alpha`index[m],Alpha`binop[add,E1,E2]]

Clear[MinIndex1Index2]
MinIndex1Index2 =  
Alpha`binop[min,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {Prepend[S1[[1,4,1]],1]}
	 ]
     ],Alpha`index[m2]
     ],
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S2[[1,2]]+1,S2[[1,3]],
	 {Append[Drop[Prepend[S2[[1,4,1]],1],-1],Last[S2[[1,4,1]]]-1]}
	 ]
     ],Alpha`index[m1]
     ]
   }
   ]
	]
Clear[MaxIndex1Index2]
MaxIndex1Index2 =  
Alpha`binop[max,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {Prepend[S1[[1,4,1]],1]}
	 ]
     ],Alpha`index[m1]
     ],
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S2[[1,2]]+1,S2[[1,3]],
	 {Append[Drop[Prepend[S2[[1,4,1]],1],-1],Last[S2[[1,4,1]]]-1]}
	 ]
     ],Alpha`index[m2]
     ]
   }
   ]
	]

Clear[EqualIndex1Index2]
EqualIndex1Index2 =  
Alpha`binop[eq,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {Prepend[S2[[1,4,1]],0]}
	 ]
     ],Alpha`affine[Alpha`const[True],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ],
   Alpha`restrict[
     DomUnion[
       DomConstraints[
	 Alpha`matrix[
	   1,S2[[1,2]]+1,S2[[1,3]],
	   {
	    Append[Drop[Prepend[S1[[1,4,1]],1],-1],Last[S1[[1,4,1]]]-1]
	    }
	    ]
       ],
       DomConstraints[
	 Alpha`matrix[
	   1,S2[[1,2]]+1,S2[[1,3]],
	   {
	    Append[Drop[Prepend[S2[[1,4,1]],1],-1],Last[S2[[1,4,1]]]-1]
	    }
	    ]
       ]
     ],Alpha`affine[Alpha`const[False],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ]
   }
   ]
	]


Clear[NotEqualIndex1Index2]
NotEqualIndex1Index2 =  
Alpha`binop[ne,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {Prepend[S1[[1,4,1]],0]}
	 ]
     ],Alpha`affine[Alpha`const[False],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ],
   Alpha`restrict[
     DomUnion[
       DomConstraints[
	 Alpha`matrix[
	   1,S2[[1,2]]+1,S2[[1,3]],
	   {
	    Append[Drop[Prepend[S1[[1,4,1]],1],-1],Last[S1[[1,4,1]]]-1]
	    }
	    ]
       ],
       DomConstraints[
	 Alpha`matrix[
	   1,S2[[1,2]]+1,S2[[1,3]],
	   {
	    Append[Drop[Prepend[S2[[1,4,1]],1],-1],Last[S2[[1,4,1]]]-1]
	    }
	    ]
       ]
     ],Alpha`affine[Alpha`const[True],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ]
   }
   ]
	]

Clear[Index1GreaterEqualIndex2]
Index1GreaterEqualIndex2 =  
Alpha`binop[ge,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {Prepend[S1[[1,4,1]],1]}
	 ]
     ],Alpha`affine[Alpha`const[True],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ],
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S2[[1,2]]+1,S2[[1,3]],
	 {
	  Append[Drop[Prepend[S2[[1,4,1]],1],-1],Last[S2[[1,4,1]]]-1]
	  }
	 ]
     ],Alpha`affine[Alpha`const[False],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ]
   }
   ]
	]

Clear[Index1GreaterThanIndex2]
Index1GreaterThanIndex2 =  
Alpha`binop[gt,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {
	  Append[Drop[Prepend[S1[[1,4,1]],1],-1],Last[S1[[1,4,1]]]-1]
	  }	 
	  ]
     ],Alpha`affine[Alpha`const[True],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ],
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S2[[1,2]]+1,S2[[1,3]],
	 {Prepend[S2[[1,4,1]],1]}
	 ]
     ],Alpha`affine[Alpha`const[False],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ]
   }
   ]
	]

Clear[Index1LessEqualIndex2]
Index1LessEqualIndex2 =  
Alpha`binop[le,Alpha`index[m1_],Alpha`index[m2_]] :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {Prepend[S2[[1,4,1]],1]}
	 ]
     ],Alpha`affine[Alpha`const[True],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ],
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S2[[1,2]]+1,S2[[1,3]],
	 {
	  Append[Drop[Prepend[S1[[1,4,1]],1],-1],Last[S1[[1,4,1]]]-1]
	  }
	 ]
     ],Alpha`affine[Alpha`const[False],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ]
   }
   ]

	]

Clear[Index1LessThanIndex2]
Index1LessThanIndex2 =  
Alpha`binop[lt,Alpha`index[m1_],Alpha`index[m2_]]  :> Module[{S1,S2},S1 = subIndex[Alpha`index[m1],Alpha`index[m2]];S2 = subIndex[Alpha`index[m2],Alpha`index[m1]];
Alpha`case[
  {  
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S1[[1,2]]+1,S1[[1,3]],
	 {
	  Append[Drop[Prepend[S2[[1,4,1]],1],-1],Last[S2[[1,4,1]]]-1]
	  }	 
	  ]
     ],Alpha`affine[Alpha`const[True],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ],
   Alpha`restrict[
     DomConstraints[
       Alpha`matrix[
	 1,S2[[1,2]]+1,S2[[1,3]],
	 {Prepend[S1[[1,4,1]],1]}
	 ]
     ],Alpha`affine[Alpha`const[False],Alpha`matrix[1,S1[[1,2]],S1[[1,3]],
				    {Append[Table[0,{i,1,S1[[1,2]]-1}],1]}
				    ]
		  ]
     ]
   }
   ]
	]

Clear[IfTrue]
IfTrue = 
Alpha`if[Alpha`affine[Alpha`const[True],m_],E1_,E2_] :>
  Alpha`restrict[DomIntersection[expDomain[E1],expDomain[E2]],E1]

Clear[IfFalse]
IfFalse = 
Alpha`if[Alpha`affine[Alpha`const[False],m_],E1_,E2_] :>
  Alpha`restrict[DomIntersection[expDomain[E1],expDomain[E2]],E2]


(******************************************)
(* The default set of normalization rules *)
(******************************************)

Clear[normalizationRules]
normalizationRules =
  {
(* The columns correspond to the different subexp types addressed by rules
   defined for each exp type.

			Identity/
   Binop		/Universe/
   | 	Case	Dep    	/Empty	If	Rest	Unop  Index
   |	|	|	|	|	|	|       |
   v	v	v	v	v	v	v	v     *)

   	BinopCaseLeft,                                 DepIndex,  
   	BinopCaseRight,	BinopEmptyTerm,	BinopRestLeft,
   					BinopRestRight,
   	CaseCase,	CaseEmptyRemove,
		      	CaseSingleReplace,
   DepBinop,
   	DepCase,
		DepDep, DepEmptyTerm,
		      		DepIf,
			(* DepIdent, *)
					DepRest,DepUnop,
	IfCaseCond,
	IfCaseThen,
	IfCaseElse,
		      	IfEmptyTerm,	IfRestCond,
					IfRestThen,
					IfRestElse,
	RestCase,	RestEmptyDomain,
			RestEmptyTerm,
			RestUniverseReplace , 					RestRest,
						UnopCase,
						UnopEmptyTerm,
						UnopRest,
	callCase, callRestrict, callAffine }

(* for normalization of affine index expressions *)
Clear[indexNormalizationRules]

indexNormalizationRules = {
ConstTimesIndex,
IndexTimesConst,
ConstToIndex,
IndexPlusIndex, IndexMinusIndex, 
ExprPlusIndex,  ExprMinusIndex, 

Index1PlusIndex2PlusExpr,Index1PlusIndex2MinusExpr,Index1MinusIndex2PlusExpr,
Index1MinusIndex2MinusExpr,   

Expr1PlusIndexPlusExpr2, Expr1PlusIndexMinusExpr2, Expr1MinusIndexPlusExpr2, 
Expr1MinusIndexMinusExpr2,
 
IndexPlusExpr1PlusExpr2, IndexPlusExpr1MinusExpr2, IndexMinusExpr1PlusExpr2, 
IndexMinusExpr1PlusExpr2,
MinIndex1Index2,MaxIndex1Index2,
EqualIndex1Index2,NotEqualIndex1Index2,
Index1GreaterThanIndex2,Index1GreaterEqualIndex2,
Index1LessThanIndex2,Index1LessEqualIndex2 ,
IfTrue , IfFalse
  }

(* Special simplification rules *)
simplificationRules =
  {
    gtTrue, ifTrueCond, ifFalseCond, ifEqualBranches, caseSameExp, caseInCase, RestRest,
    IfCaseCond, IfRestCond
  }

(* Special for simplification *)
normalizationRules2 = 
  {
  	BinopCaseLeft, BinopCaseRight,	
        BinopEmptyTerm,	
        BinopRestLeft, BinopRestRight,

   	CaseEmptyRemove, CaseSingleReplace, 

        DepBinop, DepCase, DepDep, DepEmptyTerm,DepIndex,
	DepIf, (* DepIdent,*) DepRest, DepUnop,

	IfCaseCond,
	IfCaseThen,
	IfCaseElse,
		      	IfEmptyTerm,	IfRestCond,
					IfRestThen,
					IfRestElse,
	RestEmptyDomain,
			RestEmptyTerm,
			RestUniverseReplace,
					RestRest,
						UnopCase,
						UnopEmptyTerm,
						UnopRest
};

normalizationRules0 = 
  DeleteCases[normalizationRules, (CaseCase|CaseSingleReplace|IfCaseCond|IfCaseThen|IfCaseElse|
    RestCase)]

normalizationRules1 =   {
  	BinopCaseLeft, BinopCaseRight,	
        BinopEmptyTerm,	
        BinopRestLeft, BinopRestRight,

   	CaseEmptyRemove, CaseSingleReplace,

        DepBinop, DepCase, DepDep, DepEmptyTerm,DepIndex,
	DepIf, (* DepIdent,*) DepRest, DepUnop,

	IfCaseCond,
	IfCaseThen,
	IfCaseElse,
		      	IfEmptyTerm,	IfRestCond,
					IfRestThen,
					IfRestElse,
	RestEmptyDomain,
			RestEmptyTerm,
			RestUniverseReplace,
					RestRest,
						UnopCase,
						UnopEmptyTerm,
						UnopRest
};


(*************************************************************)
(* Normalization operators ... 				     *)
(*************************************************************)

Options[normalize] := {indexnorm -> False};

Clear[normalize];
Clear[normalize0];
Clear[normalize1];

(* system-wide normalization *)

(* implicit param ==> use $result *)

normalize[options___Rule] := (Alpha`$program = Alpha`$result ;
                              Alpha`$result = normalize[Alpha`$program,options]);

normalize0[] := (Alpha`$program = Alpha`$result ;
		 Alpha`$result = normalize0[Alpha`$program]);

normalize1[] := (Alpha`$program = Alpha`$result ;
		 Alpha`$result = normalize1[Alpha`$program]);

(* a complete program: use contextual information to remove redundant
   restrictions and simplify restriction domains *)

normalize[sys_Alpha`system,options___Rule] :=
  Module[{sys1,sys2,optIndexNormalize,NormRules},
	 optIndexNormalize = (indexnorm/.{options})/.Options[normalize];
	 If[optIndexNormalize,
	    (NormRules = Join[normalizationRules,indexNormalizationRules];
	    sys1 = sys //. IndexToConst;
	    sys2 = sys1 //. NormRules;
	    checkRestrictions[sys2 //. IndexToConst]),
	    (checkRestrictions[sys //. normalizationRules])
	  ]
     ]

normalize0[sys_Alpha`system] :=
  Module[{sys1,sys2},
	 sys1 = checkRestrictions[sys //. IndexToConst];
	 sys2 = checkRestrictions[sys1 //. normalizationRules0];
	 checkRestrictions[sys2 //. IndexToConst]
     ]

normalize1[sys_Alpha`system] :=
  Module[{sys1,sys2},
	 sys1 = checkRestrictions[sys //. IndexToConst];
	 sys2 = checkRestrictions[sys1 //. normalizationRules1];
	 checkRestrictions[sys2 //. IndexToConst]
     ]

(* explicit param ==> do not affect default variables *)
normalize[exp_] :=
  Module[{exp1,exp2},
	 exp1 = exp //. IndexToConst;
	 exp2 = exp1 //. normalizationRules;
	 exp2 //. IndexToConst
     ]

normalize0[exp_] :=
  Module[{exp1,exp2},
	 exp1 = exp //. IndexToConst;
	 exp2 = exp1 //. normalizationRules0;
	 exp2 //. IndexToConst
     ]

normalize1[exp_] :=
  Module[{exp1,exp2},
	 exp1 = exp //. IndexToConst;
	 exp2 = exp1 //. normalizationRules;
	 exp2 //. IndexToConst
     ]

(* xxxxxxxxxxx *)
(* normalizeQ. Just check if normalized program equals program after one
step of normalization. Surely not the most efficient way *)
normalizeQ[] := normalizeQ[Alpha`$result];

normalizeQ[ast_] := ast === (((ast/.IndexToConst)/. normalizationRules)/.IndexToConst)

(* xxxxxxxxxxx *) 
(* normalize0Q. Same as normalizeQ *)
normalize0Q[] := normalize0Q[Alpha`$result];

normalize0Q[ast_] := ast === (((ast/.IndexToConst) /. normalizationRules0)/.IndexToConst)

(* FONCTIONS POUR LA NORMALISATION D UN PROGRAMME ALPHA0 *)
Clear[TakeRestrictions];
TakeRestrictions[{Alpha`restrict[dom1_,Alpha`restrict[dom2_,exp_]]}]:=
   DomIntersection[dom1,TakeRestrictions[{Alpha`restrict[dom2,exp]}]];
TakeRestrictions[{Alpha`restrict[dom_,_]}]:= dom;

Clear[DistribRestrict];
DistribRestrict[{}]:={};
DistribRestrict[{Alpha`equation[id_,sousexp_],suite___}]:=Join[{Alpha`equation[id,sousexp]},DistribRestrict[{suite}]]
DistribRestrict[{Alpha`restrict[dom1_,{exp___}],suite___}]:=Join[(List[exp] /.
{Alpha`equation[id_,Alpha`restrict[dom2_,sousexp_]] :> Alpha`equation[id,Alpha`restrict[DomIntersection[dom1,dom2],sousexp]],
Alpha`equation[id_,Alpha`case[{Alpha`restrict[dom2_,sousexp1_],Alpha`restrict[dom3_,sousexp2_]}]] :> Alpha`equation[id,Alpha`case[{Alpha`restrict[DomIntersection[dom1,dom2],sousexp1],Alpha`restrict[DomIntersection[dom1,dom3],sousexp2]}]],
Alpha`equation[id_,sousexp_] :> Alpha`equation[id,Alpha`restrict[dom1,sousexp]] }), DistribRestrict[{suite}]]

(*********)
(* Fusion des branches d'un case d'une meme expression *)
(*********)
Clear[ResteEquations]
ResteEquations[{Alpha`equation[var_,exp_],suite___},var_]:= ResteEquations[{suite},var]
ResteEquations[{Alpha`equation[var1_,exp_],suite___},var_]:= Join[{Alpha`equation[var1,exp]},ResteEquations[{suite},var]]
ResteEquations[_,_]:= {}

Clear[DomUnionListe]
DomUnionListe[{dom1_,dom2___}] := DomUnion[dom1,DomUnionListe[{dom2}]]
DomUnionListe[{dom1_}] := dom1

Clear[TraiteCase]
TraiteCase[{Alpha`restrict[dom1_,exp1_],suite___}]:= 
  If[Cases[{suite},Alpha`restrict[dom2_,exp1],Infinity]==={},
     Join[{Alpha`restrict[dom1,exp1]},TraiteCase[{suite}]],
     Join[{Alpha`restrict[
       convexize[
         DomUnionListe[Cases[{Alpha`restrict[dom1,exp1],suite},
           Alpha`restrict[dom_,exp1] -> dom, Infinity]]], exp1]},
           ({Alpha`restrict[dom1,exp1],suite} /. {
             Alpha`restrict[_,exp1] :> {},
             Alpha`restrict[dom_,exp2_] :> Alpha`restrict[dom,exp2] })]
    ];
TraiteCase[{}] := {};

Clear[FusionneCase]
FusionneCase[{Alpha`equation[var_,Alpha`case[x_]],suite___}]:= Join[{Alpha`equation[var,Alpha`case[TraiteCase[x]]]},FusionneCase[{suite}]]
FusionneCase[{Exp_,suite___}]:= Join[{Exp},FusionneCase[{suite}]]
FusionneCase[{}]:= {}

(*********)
(* Fusion des definitions d une meme variable *)
(*********)
Clear[FusionneVar]
FusionneVar[{Alpha`equation[var_,Alpha`case[x_]],suite___}]:= Join[x,FusionneVar[{suite}]]
FusionneVar[{Alpha`equation[var_,Alpha`restrict[dom_,x_]],suite___}]:= Join[{Alpha`restrict[dom,x]},FusionneVar[{suite}]]
FusionneVar[_]:={}

Clear[FusionneVars]
FusionneVars[{Alpha`equation[var_,exp1_],suite___}]:=
If[Cases[{suite},Alpha`equation[var,_],Infinity]==={},
Join[{Alpha`equation[var,exp1]},FusionneVars[{suite}]],
Join[{Alpha`equation[var,Alpha`case[FusionneVar[Cases[{Alpha`equation[var,exp1],suite},Alpha`equation[var,x_] -> Alpha`equation[var,x],Infinity]]]]}, FusionneVars[ResteEquations[{suite},var]]]]
FusionneVars[_]:={}

Clear[normalizeA]
normalizeA[]:= (Alpha`$program = Alpha`$result ;
		Alpha`$result = normalizeA[Alpha`$program])

normalizeA[Alpha`system[id_,par_,{in___},{out___},{loc___},{eqs___}]]:=
( exp = normalize1[{eqs}];
nexp = DistribRestrict[exp];
$result = Alpha`system[id,par,{in},{out},{loc},normalize[FusionneCase[FusionneVars[nexp]]]])

normalizeA[exp_] := Print["Parameter of normalizeA is bad"]

(* restricted normalization: normalize only the definition of a variable *)
Clear[normalizeDef]

Clear[normalizeDef0]

(* implicit param ==> use $result *)
normalizeDef[lhs_String] := (Alpha`$program = Alpha`$result ;
			     Alpha`$result = normalizeDef[Alpha`$program,
							  lhs])

normalizeDef0[lhs_String] := (Alpha`$program = Alpha`$result ;
			      Alpha`$result = normalizeDef0[Alpha`$program,
							    lhs])

normalizeDef[{}] := {}			(* universal kitchen sink *)

normalizeDef0[{}] := {}			(* universal kitchen sink *)

normalizeDef[lhs_] :=			(* filter symbols *)
  normalizeDef[symToString[lhs]]

normalizeDef0[lhs_] :=			(* filter symbols *)
  normalizeDef0[symToString[lhs]]

(* explicit param ==> don t affect default variables *)
normalizeDef[sys_Alpha`system, lhs_String] :=
  checkRestrictions[
    replaceDefinition[sys,
		      lhs,
		      normalize[getDefinition[sys, lhs]]]];

normalizeDef0[sys_Alpha`system, lhs_String] :=
  Module[{},
	 checkRestrictions[replaceDefinition[sys,
			     lhs,
			     normalize0[getDefinition[sys, lhs]]]]]	 ;

normalizeDef[{}, _] := {};		(* universal kitchen sink *)
normalizeDef[_, {}] := {};

normalizeDef0[{}, _] := {};		(* universal kitchen sink *)
normalizeDef0[_, {}] := {};

normalizeDef[exp_, lhs_] :=		(* filter symbols (make em strings) *)
  normalizeDef[exp, symToString[lhs]];

normalizeDef0[exp_, lhs_] :=
  normalizeDef0[exp, symToString[lhs]];

(* normalize an expression in the _context_ of a program (and not _inside_ the
   program); intended for internal use, so there s almost no type checks *)

Clear[normalizeInCtxt]
normalizeInCtxt[exp_, dom_Alpha`domain] :=
  minRestrictInCtxt[
    checkRestrictionsInCtxt[normalize[Alpha`restrict[dom, exp]],
			    dom],
    dom]


Clear[normalizeInCtxt0]
normalizeInCtxt0[exp_, dom_Alpha`domain] :=
  minRestrictInCtxt[
    checkRestrictionsInCtxt[normalize0[Alpha`restrict[dom, exp]],
			    dom],
    dom]

(**********************************************************************)
(* removal of redundant restrictions: must be called with a system as *)
(* parameter							      *)
(**********************************************************************)

(* first, a predicate to check f/redundancy of a restriction domain *)

Clear[redundantRestrictQ]

redundantRestrictQ[rst_Alpha`domain, dom_Alpha`domain] :=
  DomEmptyQ[DomDifference[dom, rst]]

redundantRestrictQ[rst_Alpha`domain, dom_Alpha`scalar] :=
  (Print["*** redundantRestrictQ: error: restriction of a scalar domain."];
   False)

(* the check itself *)
Clear[checkRestrictions];

(* implicit param ==> use $result *)
checkRestrictions[] := (Alpha`$program = Alpha`$result ;
			Alpha`$result = checkRestrictions[Alpha`$program])

(* explicit param ==> don t affect default variables *)
checkRestrictions[sys_Alpha`system] :=
  sys //. (Alpha`equation[var_,
			  Alpha`restrict[d_Alpha`domain,
					 exp_]]
	   :> Alpha`equation[var, exp] /;
           redundantRestrictQ[d, Part[getDeclaration[sys, var], 3]]);

Clear[checkRestrictionsInCtxt];
checkRestrictionsInCtxt[exp_, dom_Alpha`domain] :=
  exp //. (Alpha`restrict[d_Alpha`domain, expPrime_]
	 :> expPrime /; redundantRestrictQ[d, dom]);


(*****************************************************************************)
(* simplify restriction expressions: remove redundant constraints in         *)
(* restrictions of a complete program; transforms only equations (requires a *)
(* variable context,) but may be applied to any expression		     *)
(* Without parameters, treats all the variables of the default program       *)
(* "Alpha`$result". If a variable name is supplied (either string or symbol,)*)
(* assumes "Alpha`$result" as default program.				     *)
(*****************************************************************************)

Clear[simplifyRestrictions]

simplifyRestrictions[] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = simplifyRestrictions[Alpha`$program])

simplifyRestrictions[var_String] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = simplifyRestrictions[Alpha`$program, var])

simplifyRestrictions[var_Symbol] :=
  simplifyRestrictions[symToString[var]]

simplifyRestrictions[sys_Alpha`system] :=
  sys //. (Alpha`equation[var_, exp_] :>
	  Alpha`equation[var,
			 minRestrictInCtxt[exp,
					   Part[getDeclaration[sys,
							       var], 3]]])

simplifyRestrictions[sys_Alpha`system, var_String] :=
  sys //. (Alpha`equation[var, exp_] :>
	  Alpha`equation[var,
			 minRestrictInCtxt[exp,
					   Part[getDeclaration[sys,
							       var], 3]]])

simplifyRestrictions[e_] := e

simplifyRestrictions[sys_Alpha`system, {}] :=
  (Print["simplifyRestrictions: invalid variable name."] ;
   sys)

simplifyRestrictions[sys_Alpha`system, x_] :=
  simplifyRestrictions[sys, symToString[x]]

simplifyRestrictions[e_, x_] := x


(* simplify the restrictions in the context of an enclosing domain *)

Clear[minRestrictInCtxt]
minRestrictInCtxt[exp_, domDecl_Alpha`domain] :=
  exp //. (Alpha`restrict[domRestrict_Alpha`domain, expPrime_] :>
	   Alpha`restrict[DomSimplify[domRestrict, domDecl], expPrime])


(* =============================== *)

(*--------------------------------------------------------------------*)
(* simplifyInContext -- simplify and reduces an Alpha program       *)
(*    - simplifies restriction domains in context of declaration    *)
(*    - simplifies transformations in context of declaration        *)
(*    - operates on normalized or unnormalized programs             *)

Clear[simplifyInContext];
simplifyInContext[ opts:___Rule ]:=
( $program = $result; 
  $result = simplifyInContext[ $program, opts ]; 
  If[ $result==={}, $result = $program;{}, $result ]
);

simplifyInContext[ sys:system[p1_,p2_,p3_,p4_,p5_,p6_], opts:___Rule ] :=
  system[ p1, p2,
    simplifyInContext[ sys, p3, opts ],
    simplifyInContext[ sys, p4, opts ],
    simplifyInContext[ sys, p5, opts ],
    simplifyInContext[ sys, p6, opts ]
  ];

(* Une liste d'équations *)
simplifyInContext[ sys:_system, eqns:_List, opts:___Rule ] :=
  Map[ Function[ x, simplifyInContext[ sys, x, opts ] ], eqns ];

(* Simplifying a declaration consists of simplifying its domain,
   after adding the parameters *)
simplifyInContext[sys:_system,
  decl[id_,type1_,domDecl:_domain], opts:___Rule ]:=
decl[ id, type1, 
  DomSimplify[ domDecl, DomExtend[sys[[2]], If[Head[domDecl[[3,1]]]===Alpha`pol,domDecl[[2]],domDecl[[3,1,1,3]]]]]
];

(* Use expression. Simplify the domain of extension, after adding
   the parameters *)
simplifyInContext[
  sys:_system, 
  use[id_,dom:_domain,mat1_,input1_,output1_], opts:___Rule 
]:=
 use[ id, DomSimplify[ dom, DomExtend[sys[[2]],If[Head[dom[[3,1]]]===Alpha`pol,dom[[2]],dom[[3,1,1,3]]]]], mat1, 
      input1, output1 ]; 

(* Equation *)
simplifyInContext[ sys:_system, equation[id_, exp_], opts:___Rule ]:=
Module[ { dom, ctx, ctx2, domlst, paramlst },

  (* Get declaration of variable id *)
  dom = getDeclaration[sys,id][[3]];

  (* Get parameter context of system *)
  ctx = sys[[2]];
  domlst = If[Head[dom[[3,1]]]===Alpha`pol,dom[[2]],dom[[3,1,1,3]]];
  paramlst = If[Head[ctx[[3,1]]]===Alpha`pol,ctx[[2]],ctx[[3,1,1,3]]];
  If[ctx[[1]]>0,
     (* If there exists parameters, simplifyInContext 
        the rhs expression, with context being the 
        intersection of dom and of the 
        ctx2 expression below. This expression, quite
        cryptic, simply is the "extension" of the parameter
        domain ctx to the indices of the dom domain *)
     ctx2 = DomZPreimage[ctx,
              idMatrix[domlst,paramlst]
            ];
     equation[ id, simplifyInContext[
                            DomIntersection[dom,ctx2] , exp, opts ] ],
     (* SimplifyInContext the rhs *)
     equation[ id, simplifyInContext[ dom, exp, opts ] ]
  ]
];

(* Case expression: appel sur les branches *)
simplifyInContext[context:_domain, case[exp_], opts:___Rule ] :=
  case[ Map[ Function[x, simplifyInContext[context, x, opts ] ], exp] ];

(* Restriction: 
   - le domaine de la restriction devient le domaine simplifie dans le contexte fourni.
   - on appelle la fonction sur l''expression qui suit la  restriction, 
     en effectuant une intersection entre le contexte et le domaine.
 *)
simplifyInContext[context:_domain, restrict[dom_,exp_], opts:___Rule ]:=
Module[ { dbg, d1, d2 },
  dbg = debug/.{opts}/.Options[normalization];

(*  Global`$$dom = dom; Global`$$context = context; *)

  If[ dbg, Print[ "******\nDomain : ", ashow[ dom, silent->True ] ] ];
  If[ dbg, Print[ "Contexte : ", ashow[ context, silent->True ] ] ];
  If[ dbg,
    Print[ "Difference between domain and context: ", 
      ashow[ DomDifference[ dom, context ], silent->True ] ]
  ];
  d1 = DomSimplify[ dom, context ];
  If[ dbg, Print[ "New domain : ", ashow[ d1, silent->True ] ] ];
  d2 = DomIntersection[ dom, context ];
  If[ dbg, Print[ "New context : ", ashow[ d2, silent->True ] ] ];
  restrict[ d1, simplifyInContext[d2, exp, opts ] ]
];

simplifyInContext[context:_domain, affine[exp_,mat_],opts:___Rule]:=
  affine[simplifyInContext[DomImage[context, mat], exp],
    DomMatrixSimplify[mat, DomEqualities[context]] ];
(*********?????????*********)

simplifyInContext[context:_domain, if[exp1_,exp2_,exp3_], opts:___Rule]:=
  if[ simplifyInContext[context, exp1, opts], 
      simplifyInContext[context, exp2, opts],
      simplifyInContext[context, exp3, opts]
  ];

simplifyInContext[context:_domain, binop[op_,exp1_,exp2_], opts:___Rule]:=
  binop[ op, simplifyInContext[context, exp1, opts],
    simplifyInContext[context, exp2, opts]
  ];

simplifyInContext[context:_domain, unop[op_,exp1_], opts:___Rule ]:=
  unop[ op, simplifyInContext[ context, exp1, opts ] ];

(* general rule *)
simplifyInContext[context:_domain, exp_, opts:___Rule ] := exp;

simplifyInContext[___] := Message[ simplifyInContext::params ];

(* I add a function for cleanning up the result of DomMatrixSimplify
   this function scans the parameter part of the affine function and
   checks that they are correct (no other indices are involved) if
   they are not correct, it checks the context and replaces it. *)

Clear[correctAffineFunctions];
correctAffineFunctions[sys:_system]:=
  Module[{nbParam,listMatPos, listMat,curSys,modified,curMat,
    curCorrect,res},
	 nbParam=sys[[2,1]];
	 listMatPos=Position[sys,Alpha`matrix[___],Infinity];
	 listMat=Map[getPart[sys,#] &,listMatPos];
	 curSys=sys;
	 modified=0;
	 Do[ curMat=listMat[[i]];
	     If [!(Last[listMatPos[[i]]]===3 &&
		   getPart[sys,
			   Append[Drop[listMatPos[[i]],-1],0]]===use),
		 (* we cannot correct the parameter assignement
		    function *)
		 curCorrect=correctMat[curMat,nbParam];
		 If[curCorrect=!=curMat,
		    curSys=ReplacePart[curSys,curCorrect,listMatPos[[i]]];
		    modified=1]],
	     {i,1,Length[listMat]}];

	 If[ modified===1, Null
            (* Print["Please check result with:	 analyze[]"] *)];
	 res=curSys];

correctAffineFunctions[a___]:=
  Message[correctAffineFunctions::WrongArg,a]

Clear[correctMat]
(* change *)
correctMat[m:_Alpha`matrix,nbParam:_Integer]:=
  Module[{paramMat,matShouldBe,newMat,statusRes,mat},
  	mat = Inttorat[m];
	 If [mat[[1]]===1,
	     (* constant case *) newMat=mat,
	     paramMat=Take[mat[[4]],-(nbParam+1)];
	     matShouldBe=
	       Table[
		 Join[Table[0,{j,1,mat[[2]]-(nbParam+1)}],
		      Table[If[i===j,1,0],{j,1,(nbParam+1)}]],
		 {i,1,(nbParam+1)}];
	     If [paramMat=!=matShouldBe,
		 statusRes=1;
		 newMat=Alpha`matrix[mat[[1]],
				     mat[[2]],
				     mat[[3]],
				     Join[Take[mat[[4]],mat[[1]]-(nbParam+1)],
				      matShouldBe]];
		 statusRes=0,
		 newMat=mat];
	     
	   ];
	  Rattoint[newMat]
	 ]
	 
  
	   
	 
correctMat[a:___]:=Message[correctMat::WrongArg,a]

(***************************************************************************)

(* A function to multiply index expressions by constants.
   e.g (i,j -> 2i-3j)*(-1) becomes (i,j -> -2i+3j)
   Used in normalization of index expressions *)

Clear[Rattoint];
Rattoint[inp1:Alpha`matrix[num1_Integer,num2_Integer,idx_List,l_List]] :=
Module[{temp,mu},
	mu[a_,b_] := Map[#*a&,b];
	temp[li_] := Apply[LCM,Map[Denominator[#]&,li]];
	Alpha`matrix[num1,num2,idx,Map[mu[temp[Flatten[l]],#]&,l]]
];

Clear[Inttorat];
Inttorat[inp1:Alpha`matrix[nm1_Integer,nm2_Integer,ix_List,lt_List]] :=
Module[{temp,div},
       div[a_,b_] := Map[#/a&,b];
       Alpha`matrix[nm1,nm2,ix,Map[div[Last[Last[lt]],#]&,lt]]
];

Clear[mulIndexExprByConst];
mulIndexExprByConst[Alpha`index[m_],c_] := Alpha`index[Rattoint[ReplacePart[m,Map[Times[c,#]&,m[[4,1]]],{4,1}]]]

(* A function to add two index expressions. 
   e.g   (2i+3j+4)+(3i-4j-8)=(5i-j-4) 
   Used in normalization of index expressions  *)

Clear[addIndex]
addIndex[Alpha`index[m1_],Alpha`index[m2_]] :=
Alpha`index[Rattoint[ReplacePart[Inttorat[m1],MapThread[Plus[#1,#2]&,{Inttorat[m1][[4,1]],Inttorat[m2][[4,1]]}],{4,1}]]]

(* A function to subtract two index expressions.
   e.g (2i+3j+4)-(3i-4j-8)=(-i+7j+12)
   Used in normalization of index expressions *)

Clear[subIndex]
subIndex[Alpha`index[m1_],Alpha`index[m2_]] :=
Alpha`index[Rattoint[ReplacePart[Inttorat[m1],MapThread[Subtract[#1,#2]&,{Inttorat[m1][[4,1]],Inttorat[m2][[4,1]]}],{4,1}]]]

(* A function used to convert constants into index expressions *)
(* e.g 5.(i,j,N-> ) becomes (i,j,N->5,N) *)
Clear[constToIndex]
constToIndex[Alpha`affine[Alpha`const[c_],m_]] :=
Module[{sysparams},
       sysparams = $result[[2,1]];
       mulIndexExprByConst[
	  Alpha`index[
	     Alpha`matrix[
	        sysparams+2,m[[2]],m[[3]],Join[{m[[4,1]]},Take[
		                                     IdentityMatrix[m[[2]]],                                                         -(sysparams+1)                                                              ]                                                               ]                                                       ]                                                                           ],c                                                                         ]
     ]

(* A function used to convert constant index expressions (i,j -> 5) to
   constants 5.(i,j ->). Used in normalization of index expressions.*)
Clear[indexToConst]
indexToConst[Alpha`index[m_]] :=
Module[{len,val,newlist},
       val = Last[m[[4,1]]]/Last[Last[m[[4]]]]; 
       newlist = Append[Drop[m[[4,1]],-1],1];
       Alpha`affine[Alpha`const[val],Alpha`matrix[1,m[[2]],m[[3]],{newlist}]]
     ]

Options[simplifySystem] = {alphaFormat->Alpha, debug->False, 
  remIdDeps->False, remIdEqus->False}

Clear[simplifySystem];

simplifySystem[options___Rule]:=
Module[{res},
  res=Catch[simplifySystem[$result,options]];
  If[MatchQ[res,system[___]],
    $result=res];
  $result
];

simplifySystem[sys:_system,options___Rule]:=
Catch[
  Module[{ formatOpt, res, dbg, simpl1, simpl2, simpl3, rem1,
	 rem2},
    formatOpt=(alphaFormat/.{options})/.Options[simplifySystem];
    dbg = debug/.{options}/.Options[simplifySystem];
    rem1 = remIdDeps/.{options}/.Options[simplifySystem];
    rem2 = remIdEqus/.{options}/.Options[simplifySystem];

    If[ (formatOpt === Alpha0)&&rem2, 
      Print["Warning: remIdEqus option is incompatible with the",
	    " alpha0 option, and was forced to False."];
      rem2 = False
    ];

    res = sys;
    Check[
      If[ rem2, res = removeIdEqus[ res ] ],
      simplifySystem::removeIdEqus = "failed while calling removeIdEqus";
      Throw[ Message[ simplifySystem::removeIdEqus ]; sys ]
    ];

    Which[
      formatOpt===Alpha,
(* **** Was changed on July 19, 2007
      res = 
	Check[
          correctAffineFunctions[
            normalize[
              convexizeAll[ simplifyInContext[res] ]
            ]
          ],
        sys],
*)

      simpl1 = 
        Check[ simplifyInContext[res], 
          simplifySystem::simpl1 = "error while calling simplifyInContext";
          Message[ simplifySystem::simpl1 ]; Throw[ sys ]
        ];

(*
      Print["After simplifyInContext"];
      Throw[ simpl1 ]; 
*)

      simpl2 = 
        Check[ convexizeAll[simpl1], 
          simplifySystem::simpl2 = "error while calling convexizeAll";
          Message[ simplifySystem::simpl2 ]; Throw[ simpl1 ]
        ];

(*
      Print["After convexizeAll"];
      Throw[ simpl2 ]; 
*)

      simpl3 = 
        Check[ normalize[simpl2], 
          simplifySystem::simpl3 = "error while calling normalize";
          Message[ simplifySystem::simpl3 ]; Throw[ simpl2 ]
        ];

(*
      Print["After normalize"];
      Throw[ simpl3 ]; 
*)
      res = 
        Check[correctAffineFunctions[simpl3],
          simplifySystem::simpl4 = 
            "error while calling correctAffineFunctions";
          Message[ simplifySystem::simpl4 ]; Throw[ simpl3 ]
        ]
,

      (* ***** Alpha0 is now defined in the Options package *)
      formatOpt===Alpha0,  

      simpl1 = 
        Check[ simplifyInContext[res], 
          simplifySystem::simpl1 = "error while calling simplifyInContext";
          Message[ simplifySystem::simpl1 ]; Throw[ sys ]
        ];

      simpl2 = 
        Check[ convexizeAll[simpl1], 
          simplifySystem::simpl2 = "error while calling convexizeAll";
          Message[ simplifySystem::simpl2 ]; Throw[ simpl1 ]
        ];

      simpl3 = 
        Check[ normalize0[simpl2], 
          simplifySystem::simpl3 = "error while calling normalize0";
          Message[ simplifySystem::simpl3 ]; Throw[ simpl2 ]
        ];

      res = 
        Check[correctAffineFunctions[simpl3],
          simplifySystem::simpl4 = 
            "error while calling correctAffineFunctions";
          Message[ simplifySystem::simpl4 ]; Throw[ simpl3 ]
        ]
,

(*
      res = Check[correctAffineFunctions[
	 normalize0[
           convexizeAll[
             simplifyInContext[sys]
           ]
         ]
         ]
*)

      (* This case is identical to first one, and should not 
         exist... *)
      True,
      res = Check[correctAffineFunctions[
	 normalize[convexizeAll[simplifyInContext[sys]]]],sys];
    ];

    (* Remove identity dependences*)
    If[ rem1, 
	res = res//.{affine[e:_,m:_matrix?identityQ] -> e}
    ];

    res
  ]
];

simplifySystem::WrongArg="Wrong argument for simpfySystem"

simplifySystem[a___]:=
  Message[simplifySystem::WrongArg];


End[]
EndPackage[]



