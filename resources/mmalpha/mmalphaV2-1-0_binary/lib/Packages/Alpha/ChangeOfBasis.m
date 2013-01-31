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
BeginPackage["Alpha`ChangeOfBasis`", 
{"Alpha`Domlib`",
 "Alpha`",
 "Alpha`Options`",
 "Alpha`Tables`",
 "Alpha`Matrix`",
 "Alpha`Substitution`",
 "Alpha`Normalization`",
 "Alpha`Semantics`",
 "Alpha`Zpol`"	
}]

(* $Id: ChangeOfBasis.m,v 1.6 2010/04/14 17:57:21 quinton Exp $

   changelog:

   07/15/1993, D. Wilde:	full text specification of COBs for batch use.
   11/29/1993, Z. Chamski:	fixed normalization problem preventing
				 identity changes of basis from changing index
				 names.
   -----/1995, D. Wilde         extended change of basis
   05/05/1995, P. Quinton:      warning messages for addDimension
                                   added
   06/07/1995, F. de Dinechin   adapted changeOfBasis to handle
                                  parameters and subsystems
                                  The generalized CoB is still to do.
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2010/04/14 17:57:21 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/ChangeOfBasis.m,v $
	$Revision: 1.6 $
	$Log: ChangeOfBasis.m,v $
	Revision 1.6  2010/04/14 17:57:21  quinton
	Minor modifications.
	
	Revision 1.5  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.4  2008/12/29 17:30:26  quinton
	Minor modifications
	
	Revision 1.3  2008/04/18 16:44:40  quinton
	Minor edition changes
	
	Revision 1.2  2007/04/09 17:31:19  quinton
	New function changeIndexes was added
	
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.36  2004/09/16 13:46:50  quinton
	Updated version
	
	Revision 1.35  2004/07/12 12:05:04  quinton
	Replaced underscore by X
	
	Revision 1.34  2004/07/08 14:06:47  risset
	commit Zpol changes
	
	Revision 1.33  2004/06/16 14:57:27  risset
	switched to ZDomlib
	
	Revision 1.32  2003/04/29 09:49:35  risset
	 added the extDomainCOB fuction and tests
	
	Revision 1.31  2003/04/18 08:35:14  risset
	added the simplifyUseInputs function
	
	Revision 1.30  2003/04/15 15:04:02  risset
	commit after Axiocom week (recursive COB)
	
	Revision 1.29  2002/09/10 15:09:12  quinton
	Minor corrections
	
	Revision 1.28  2000/02/14 08:25:18  risset
	correct a bug in DomEqulities
	
	Revision 1.27  1999/12/10 16:59:02  risset
	commited struct Sched and ZDomlib
	
	Revision 1.26  1999/05/18 16:24:24  risset
	change many packages for documentation
	
	Revision 1.25  1999/05/10 15:20:56  risset
	supressed the Decomposition Package, put it in Cut
	
	Revision 1.24  1999/05/10 13:14:13  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.23  1999/03/02 15:49:17  risset
	added GNU software text in each packages
	
	Revision 1.22  1998/02/16 17:06:45  risset
	Packages pass all tests

	Revision 1.20  1997/05/19 10:40:45  risset
	corrected exported bug in depedancies

	Revision 1.19  1997/05/13 13:40:43  risset
	report Patrice modifs on usage

	Revision 1.18  1997/04/22 10:57:19  risset
	removed some cycling dependencies between packages

	Revision 1.17  1997/04/10 09:19:15  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.16  1996/11/20 09:27:40  risset
	corrected changeOfBasis function

	Revision 1.11  1996/06/24 13:54:31  risset
	added standard head comments for CVS



*)
ChangeOfBasis::note =
"Documentation revised on August 3, 2004";

ChangeOfBasis::usage =
"The Alpha`Package` package contains the definition of the \"change of basis\"
transformation (see changeOfBasis)."

ChangeOfBasis::bugs = "In extended changeOfBasis, the 
number of new indexes does not seem to be checked against
the change of basis function";

changeIndexes::usage =
"changeIndexes[ sys, var, rules ] replaces all indexes in the definition of var
according to replacement rules. changeIndexes[ var, rules ] does the same on
$result. Remember that var names are strings. The declaration of var is 
modified according to the rules. If var is the output of a use statement, all
outputs of the use and the use itself are changed."; 

changeOfBasis ::usage = 
"changeOfBasis[var.fn] returns a copy of $result in which the
variable var is reindexed by an unimodular affine function fn. The
change of basis is specified as \"B.(i,j,k -> i+1,j,k)\" where B is
the variable to be reindexed, and the change of basis matrix has the
format of an Alpha dependence, with one difference: the index mapping
function is understood as a mapping from initial to new position (and
not the opposite). If it is square, this matrix should be
unimodular. Non-square change of basis (also called generalized 
change of basis) are allowed, in that case, the
function should be called this way: changeOfBasis[var.fn,
{index, ...}] applies a change of basis fn on variable var,
except that the new indices of var are named according to the second
argument.\nExample: \nchangeOfBasis[\"B.(i,j ->
1,i,j)\",{\"i1\",\"j1\",\"k1\"}]).
\nchangeOfBasis[sys,var.fn, {index, ...}]  applies a change of basis to
system sys instead of $result. 
\nchangeOfBasis[\"B.(i,j -> 1,i,j)\", recurse->True] 
recursively executes the change of basis on subsystem `subsys' called 
with B as input or output. The recursive change of basis has 
many restriction: as the semantics of the subsystem is modified, 
we impose that there is only one occurence of subsys appearing 
in the system. Moreover, the recursive change of basis can 
modify only local indices (indices which are not extension 
indices in the use of subsys) and must involve only local 
indices and  parameter transmitted to the subsystem. 
The  change of basis on the extension indices can be performed 
with the function extDomainCOB[] (see ?extDomainCOB).";


extDomainCOB::usage=
"extDomainCOB[\"subSysName.(j->g(j,N))\"] applies the change of basis 
to all the variables implied in the use of the subsystem subSysName 
and change the extension domain accordingly. This change of basis 
should be applied to a system where the following use appear: 
\nuse {j| ....} subSysName[...] (...) returns (...)
\nj are the extension indices, N are the parameter of the caller. 
The change of basis must only depend on the extention indices
and on the parameters as indicated here. The parameter assignement 
function must be simple (i.e. each parameter of the subsystem is 
assigned to a parameter of the caller, e.g. (N,M,P->P,N).
This transformation should have no impact on the subsystems. "

Begin["`Private`"]
Options[changeOfBasis]= { allVariablesAllowed -> False, recurse->False,
  debug->False, extDomUseCOB->False };

changeOfBasis::wrgmat = "your matrix is not unimodular!";
changeOfBasis::nonlocal = "change of basis on non-local variable.";
changeOfBasis::params = "wrong parameters."; 
changeOfBasis::wrgarg = "cannot parse the change of basis specification.";
changeOfBasis::nlocv = "`1` is not a local variable.";
changeOfBasis::wrgvar = "`1` is not a variable of this program.";
changeOfBasis::wrgdim = "the change of basis does not match dimension of variable.";
changeOfBasis::wrgdim2 = 
"the dimension of the change of basis is inconsistent with  the number
of new indices";

addDimension::usage = "This function is obsolete and has been replaced
by changeOfBasis. For example, `addDimension[\"X.(i->i,j)\",\{\"Z\"\}]' 
should be replaced by `changeOfBasis[\"X.(i->i,j)\",\{\"i\",\"Z\"\}]'. 
Notice that in the changeOfBasis, ALL the new indexes should be given";

addDimension::warning = "This function is obsolete and has been replaced
by changeOfBasis. For example, \`addDimension[\"X.(i->i,j)\",{\"Z\"}]\' 
should be replaced by \`changeOfBasis[\"X.(i->i,j)\",{\"i\",\"Z\"}]\'. 
Notice that in the changeOfBasis, ALL the new index name should be given";

(* addDimension warning message *)
Clead[addDimension];
addDimension[___]:=Message[addDimension::warning];


(* the change of basis operates by applying a series of rewriting
   transformations to the input program. It is tightly based on the initial
   COB tranformation written in TYPOL for Alpha du Centaur. *)


(* Rule #1: replace the definition domain of the CoB-ed variable. This rule is
   applied to the list of local variables. *)

Clear[defRule];
defRule[LHSvar_String, fn_Alpha`matrix, fnInverse_Alpha`matrix] :=
  Alpha`decl[LHSvar, type_, dom_Alpha`domain] :>
  Alpha`decl[LHSvar, type, DomZPreimage[dom, fnInverse]];	(* change *)


(* Rule #2, applied to the equations : if the LHS variable is the one
   concerned by the change of basis (CoB,) apply the CoB transformation to
   everything but this variable *)

(* Operation: first, compute the normal form of the RHS, then replace index
   names in the normalized term by the index names supplied in the COB
   function. This removes an interaction between normalization and change of
   basis, which caused Identity COB''s to fail. *)

Clear[matchingLhsRule];
matchingLhsRule[LHSvar_String, fn_Alpha`matrix, fnInverse_Alpha`matrix] :=
Module[{res},
  res = Alpha`equation[LHSvar, exp_] :>
  Alpha`equation[LHSvar,
    With[{LHSindices = Part[fn, 3]},
          normalize[ 
            Alpha`affine[
              exp /. 
              Alpha`var[LHSvar] -> Alpha`affine[ Alpha`var[LHSvar], fn], fnInverse
            ] 
          ] 
          /. 
          {Alpha`matrix[l_, c_, i_, m_]
             -> Alpha`matrix[l, c, LHSindices, m], Alpha`domain[d_, i_, p_]
			-> Alpha`domain[d, LHSindices, p]}
        ] (* With *)
      ];
    res
]; (* Module *)
matchingLhsRule[___] := Message[matchingLhsRule::params];

(* Rule #3 (equations:) if the LHS variable is not the affected one, apply the
   CoB to the occurrences of CoB-ed variable only *)

Clear[otherLhsRule];
otherLhsRule[LHSvar_String, fn_Alpha`matrix, fnInverse_Alpha`matrix] :=
  Module[{res}, 
res= Alpha`equation[name_String /; name =!= LHSvar, exp_] :>
  normalize[Alpha`equation[name,
			   exp /. 
			     Alpha`var[LHSvar] ->
			       Alpha`affine[Alpha`var[LHSvar], fn]]];
res]


(* Rule #4 (use:) if the CoB variable appears in the input
   arguments of a use, apply the CoB to it (it is equivalent to a RHS)
   If it appears in the output list, then replace 
     use ... (...) returns(V) ;
   with
     use ... (...) returns(V');
     V = V'.fnInverse;
   Remark : This last case implies adding one equation and one
   declaration and hence cannot be treated using replacement rules :
   it is in treated thanks to the function useOutputCheck called
   from changeOfBasis.
   *)

Clear[useInputsRule];
useInputsRule[ LHSvar_String, fn_Alpha`matrix, fnInverse_Alpha`matrix ] :=
Module[ { u },
  Alpha`use[ id_, extDom_, paramAssgn_, inputs_, outputs_ ] :>
    Alpha`use[ id, extDom, paramAssgn, 
      Map[ normalize,
        inputs /. 
	   (u:Alpha`affine[Alpha`var[LHSvar],f1_]|
	    Alpha`var[LHSvar]) :>
        Alpha`affine[u,fn]],
    outputs ]
];
useInputsRule[___]:= Message[ useInputsRule::params ];


(* The rule to apply to replace a use... with LHSvar in its output
   list with a use and an equation . Note that this rule replaces an
   equation with a list, so the result must be flattened. *)

Clear[useOutputRule];

useOutputRule[  LHSvar_String, fnInverse_Alpha`matrix, newName_String ] :=
  Alpha`use[ id_, ext_, pass_, i_, o_ /; MemberQ[ o, LHSvar] ] :>
  { Alpha`use[ id, ext, pass, i, 
	       o /. LHSvar :> newName
	       ],
   Alpha`equation[ LHSvar, 
		   Alpha`affine[ Alpha`var[ newName],
				 fnInverse ]
		 ]
   };





(**************** useCOB ********************************)
(* useCOB is used for the recursive change of basis 
  the change of basis has been applied to the main system, we try to 
  transmit it recursively to all subsystem called. 
	      tanguy Dec 1999 *)

useCOB::buildNewCOB=" Error during the recursive COB, COB aborted\n "
useCOB::failed="Sorry, change of Basis failed for
   variable `1` on subsystem `2`"	 
useCOB::varUsedSeveralTimes="Variable `1` in involved into  I/O of several subsystem, cannot perform an extension domain change of basis, please add a local copy of `1`"

Clear[useCOB];
   
useCOB[ sys:Alpha`system[n_, p_, in_, o_, locals_, equas_],
  LHSvar_String,
  fn_Alpha`matrix,
  fnInverse_Alpha`matrix,
  oldDecl_Alpha`decl,
  opts:___Rule] :=
  Catch[
    Module[{allVariables, optRecurse,optDebug,res,libres,eqnUse,
	    eqnUseLHSvar,subSystemNames,curSys,subSystemName,
	    subSys1,useSubSys1,COBmat,nbIndiceVar,nbExtension,
	    posLHSvarInUse,subName,curUse,realFunc,subSysVarDecl,
	    newIndices,curSubSys1 },
 (* options setting *)
	   allVariables =  allVariablesAllowed/.{opts}/.Options[changeOfBasis];
	   optRecurse = recurse/.{opts}/.Options[changeOfBasis];
	   optDebug = debug/.{opts}/.Options[changeOfBasis];
          If[optDebug,Print["****Entering useCOB "]];
	   optExtDomUseCOB = extDomUseCOB/.{opts}/.Options[changeOfBasis];
	   res=sys;
	   libres=$library;
           (* set of use in the system *) 
	   eqnUse=Select[ equas, Head[#]==Alpha`use & ];
           (* equation defining LHSvar *)
	   eqnUseLHSvar=Select[ eqnUse,
	      Position[#,LHSvar,Infinity]=!={} &];
           (* if the extDomUseCOB is set, the variable should not be used 
              in any other subsystems, otherwise the new domain of the 
              variable will not be compatible *)
           If[optExtDomUseCOB,
              If[Length[eqnUseLHSvar]>1,
                 Message[useCOB::varUsedSeveralTimes,LHSvar];
		Throw[$Failed]]];
	   If [eqnUseLHSvar==={},
                 (* Nothing to do *) 
                 Return[sys],
                 (* else lots of thing to do *)
	       subSystemNames=Map[First,eqnUseLHSvar];
	       If[Length[Union[subSystemNames]]=!=Length[subSystemNames],
		  Print["Variable ",LHSvar," in involved into  I/O of
   several times the same subsystem, not implemented "];
		Throw[$Failed]];
		  (* for each subsystems involved *)
		 curSys=sys;
	       If [optDebug,Print["subSystem to examine: ",subSystemNames]];
		 Do [subSystemName=subSystemNames[[counter]];
	       If [optDebug,Print[" examining: ",subSystemName]];
		     subSys1=getSystem[subSystemName,$library];
		     If [subSys1===$Failed,
			 Message[useCOB::failed,LHSvar,subSystemName];
			 Throw[$Failed]];
		     useSubSys1=
		       First[Select[eqnUseLHSvar,First[#]===subSystemName &]];
		     (* consider the square change
			of basis (i,j,N->f(i,j,N),g(i,j,N),N)
			where N is a parameter and j is an extension
			indice of a use involving the LHSvar
			variable . This COB can be recursively done
			iff:  f(i,j,n) depends only on i 
			       and g(i,j,n) does not depend on i,
                        The g function can be non-identity only if the COB
                        comes from a call to extDomainCOB, in that case, 
                        the options extDomUseCOB is set to True
			 (Tanguy 2003) we also may 
                        allow f(i,j,N) to depend on N. But we do allow that
	                only if the parameter assignment function is 
                        simple, i.e. : M <- N *)
		     COBmat=fn[[4]];
		     (* nb columns   of param assign mat *) 
		       (* check that f(i,j,N) depond only on i *)
		       If [!checkSubIndexIndependence[curSys,
						      oldDecl,
						      useSubSys1,
						      LHSvar,
						      fn,
                                                      opts],
			   Throw[$Failed]];
		     (* check that g(i,j,N) does not depend  on i *)
		       If [!checkExtIndexIndependence[curSys,
                                                      subSys1,
						      oldDecl,
						      useSubSys1,
						      LHSvar,
						      fn,
                                                      opts],	
			   Throw[$Failed]];
		     (* check that g(i,j,N) does not depend  on i *)
		       If [!checkParamUseValidity[curSys,
                        			      subSys1,
                                                      oldDecl,
						      useSubSys1,
						      LHSvar,
						      fn,
                                                      opts],	
			   Throw[$Failed]];
		     posLHSvarInUse=Position[useSubSys1,LHSvar];

		     If [Length[posLHSvarInUse]=!=1,
			 Print["More than one use of ",LHSvar,
			       " in use ",subSystemName," not implemented"];
			 Throw[$Failed],
                         (* else performing the recursive COB *)
			 If [posLHSvarInUse[[1,1]]===4,
			     (* input to sub *)
			       subName=
				 getPart[subSys1[[3]],
					 {posLHSvarInUse[[1,2]],1}];
			     If [optDebug,
				 show[useSubSys1]];
                             (* apply the classical changes to input vars *)
			     curUse=useSubSys1/.
			       useInputsRule[LHSvar,fnInverse,fn];
			     If [optDebug,
				 show[curUse]];
			     res=sys/.(useSubSys1->curUse),
			     (* Output to sub, nothing to do *)
			       subName=
				 getPart[subSys1[[4]],
					 {posLHSvarInUse[[1,2]],1}]];
			 (***** recursive modif of the subsystems  ******)
			   (* build the new COB matrix to be applied tO
			      the subsystem  *)
		       realFunc= buildNewCOB[curSys,
						 subSys1,
						 oldDecl,
						 useSubSys1,
						 LHSvar,
						 subName,
						 fn,
                                                 fnInverse,
                                                 opts];
			If [optDebug,Print["recursive COB:"];show[realFunc]];
                        If[!MatchQ[realFunc,_matrix],
			    Message[useCOB::buildNewCOB];
			    Throw[$Failed]];			 
			 subSysVarDecl=getDeclaration[subSys1,subName];

                          (* remove the extension indices and the parameters, if the extDomUse options is set, 
                               the new indices are extention indices otherwise they are local indices *)
		         nbIndiceVar=oldDecl[[3,1]]-sys[[2,1]] ;
                          nbExtension=useSubSys1[[3,2]]-sys[[2,1]]-1;
			  If[optExtDomUseCOB,
                             newIndices=Drop[fnInverse[[3]],
					      {nbIndiceVar-nbExtension+1,fnInverse[[2]]-1}],
                             newIndices=Drop[fnInverse[[3]],
					      {fnInverse[[2]]-nbExtension-sys[[2,1]],fnInverse[[2]]-1}]]; 

			 If [optDebug,
			     Print[" for use of system",subSystemName,
				   " the recursive COB applied will be: ",
				   show[realFunc,silent->True]];
			     Print["The names of the new indices will be:",
				   newIndices]];
			 If[realFunc[[1]]=!=1 || realFunc[[1]]=!=1,
			   curSubSys1=
			      changeOfBasis[subSys1,subName,
					 realFunc,
					 newIndices,
					 allVariablesAllowed->True,
                                         opts],
                          (* else nothing to do:  the change of basis 
                             is the identity function of dimension 0 *)
                            curSubSys1=subSys1];

			 If [optDebug,
			     Print["the new subSystem is :",
				   show[curSubSys1,silent->True]]];
			 libres=putSystem[curSubSys1,$library];
		       ],
			 {counter,1,Length[Union[subSystemNames]]}]
	     ];
	   $library=libres;
	   Return[res]
	 ]
  ]
    

(* checkParamUseValidity checks that: 
    1) the paramater assignement function is a primitive function: i.e. the parameter 
of the subsystem are a subset of the parameters of the caller (possibly in a different order). 
    2) the parameter involved in the COB of the subsystem indices (local indices) are coherent with this assignement 
   function: e.g. if the COB is (i,j,k->i+M,j,k) with j,k extention indice and the parameter assignement function is (M,N->N), the
COB is impossible  *) 
 
Clear[checkParamUseValidity]
checkParamUseValidity[curSys:_system,
 subSys1:___system,
 oldDecl:_decl,
 useSubSys1:_use,
 LHSvar:_String,
 fn:_matrix,
  opts:___Rule]:=
Catch[
  Module[{COBmat,nbParam,nbRows,nbColumns,nbExtension,firstRowCOB, someColumns},
          
	 optExtDomUseCOB=extDomUseCOB/.{opts}/.Options[changeOfBasis]; 
         (* If the COB comes from extDomainCOB, it seems to me that 
            there is nothing to check here, hence we do not check *)
         If[optExtDomUseCOB,Return[True]];
         COBmat=fn[[4]];
	 nbRows=fn[[1]];
         nbParam=curSys[[2,1]];
	 nbColumns=fn[[2]];
	 nbExtension=useSubSys1[[3,2]]-nbParam-1;
	 nbIndiceSub=nbColumns-nbExtension-nbParam-1;
          (* Print["nbExtension ", nbExtension,"\n nbIndiceSub ",nbIndiceSub, "\n nbIndiceSubAfterCOB ",nbIndiceSubAfterCOB]; *)
         If[!optExtDomUseCOB,
             (* regular recursive COB *)
             nbIndiceSubAfterCOB=nbRows-nbExtension-nbParam-1,
             (*  COB on extension indices*)
             nbIndiceSubAfterCOB=nbIndiceSub];

       (************ step 1: check that the  parameter assignment si a primitive matrix (i.e. 
                      subsystem indices are a subset of caller indices) ************)
        
         paramAssign=useSubSys1[[3]];
           assignParameterSubMat={};
          Do[curParamRow=paramAssign[[4,i]]; (* *)
            (* Check that the parameter does not depend on the extension indices *)
             Do[If[curParamRow[[j]]=!=0,
                    Message[buildNewCOB::err2,LHSvar,subSys1[[2,2,i]],useSubSys1[[1]]];
                     Throw[False]]
                 ,{j,1,nbExtension}];
            curParamRow=Drop[curParamRow,{1,nbExtension}];
            (* check that there is one and only one 1 in the row *)
            If[Length[Position[curParamRow,1]]=!=1  || 
                  Length[Position[curParamRow,0]]=!=Length[curParamRow]-1,
                    Message[buildNewCOB::err3,LHSvar,subSys1[[2,2,i]],useSubSys1[[1]]];
                     Throw[False]];
              assignParameterSubMat=Append[assignParameterSubMat,
                      Drop[curParamRow,-1] (* cst part=0 *)];
           ,{i,1,nbParamSub}];

           If[optDebug,Print["assignParameterSubMat= ",assignParameterSubMat]];

          (************ step 2 checking compatibility with the parameter assignement matrix ****)


          (* STILLTOBE DONE Print["Warning, compatibilite between parameter assinement function and COB not checked, to be done soon..."]; *)
	  True
   ]
]

checkParamUseValidity[a___]:=
  Message[checkParamUseValidity::WrongArg,Print[Map[Head,{a}]]]

checkParamUseValidity::WrongArg="Wrong Argument for checkParamUseValidity "


(* checkExtIndexIndependence check that in the recursive change of
   basis function, the part on the extension indices is identity
   *)

Clear[checkExtIndexIndependence]
checkExtIndexIndependence[curSys:_system,
  subSys1:_system,
  oldDecl:_decl,
 useSubSys1:_use,
 LHSvar:_String,
 fn:_matrix,
 opts:___Rule]:=
  Module[{COBmat,nbRows,nbColumns,nbExtension,middleRowCOB,
	  someColumns,res1,res2},
	 optExtDomUseCOB=extDomUseCOB/.{opts}/.Options[changeOfBasis]; 
         COBmat=fn[[4]];
         (* dimension of the variable after COB *)
	 nbRows=fn[[1]];
         (* dimension of the variable before COB *)
	 nbColumns=fn[[2]];
         nbParamCaller=curSys[[2,1]];
         nbParamSub=subSys1[[2,1]];
         (* number of extension indices (excluding parameter) *)
	 nbExtension=useSubSys1[[2,1]]-nbParamCaller;
         (* nu,ber of indices which are not extension indices, before COB *)
         nbRealIndices=nbColumns-nbExtension-nbParamCaller-1;
          middleRowCOB=Take[COBmat,{nbRows-nbExtension-nbParamCaller,nbRows-nbParamCaller-1}];
         (* allow a constant addition to extention indices *)
         someColumns=Map[Drop[#,-1] &,middleRowCOB];
          tab1= Table[Flatten[Table[If[i1+nbRealIndices===j1,1,0],
                      {j1,1,Length[someColumns[[1]]]}]],
		 {i1,1,Length[someColumns]}];
	  res2=If [(!optExtDomUseCOB) && (someColumns=!=tab1),
		  Print["Sorry the change of basis function is not
identity on extension indices ", useSubSys1[[3,3]], " : ", someColumns,
               " cannot perform the change of basison the subsystem",useSubSys1[[1]],"\n please use function extDomainCOB[]\n"];False,
            True];
	 ]

checkExtIndexIndependence[___]:=True

(*  Message[checkExtIndexIndependence::WrongArg] *)

checkExtIndexIndependence::WrongArg = "Wrong Argument for checkExtIndexIndependence"



(* checkSubIndexIndependence check that in the recursive change of
   basis funciton, the callee indinces do not depend on the extension 
   indices *)

Clear[checkSubIndexIndependence]
checkSubIndexIndependence[curSys:_system,
  oldDecl:_decl,
 useSubSys1:_use,
 LHSvar:_String,
 fn:_matrix,
  opts___Rule]:=
  Module[{COBmat,nbParam,nbRows,nbColumns,nbExtension,firstRowCOB, someColumns},
          
	 optExtDomUseCOB=extDomUseCOB/.{opts}/.Options[changeOfBasis]; 
         (* If the COB comes from extDomainCOB, it seems to me that 
            there is no way to check that here, hence we do not check *)
         If[optExtDomUseCOB,Return[True]];
         COBmat=fn[[4]];
	 nbRows=fn[[1]];
         nbParam=curSys[[2,1]];
	 nbColumns=fn[[2]];
	 nbExtension=useSubSys1[[3,2]]-nbParam-1;
	 nbIndiceSub=nbColumns-nbExtension-nbParam-1;
         (* Print["nbExtension ", nbExtension,"\n nbIndiceSub ",nbIndiceSub, "\n nbIndiceSubAfterCOB ",nbIndiceSubAfterCOB]; *)
         If[!optExtDomUseCOB,
             (* regular recursive COB *)
             nbIndiceSubAfterCOB=nbRows-nbExtension-nbParam-1,
             (*  COB on extension indices*)
             nbIndiceSubAfterCOB=nbIndiceSub];
           firstRowCOB=Take[COBmat,{1,nbIndiceSubAfterCOB}];
        someColumns=Map[
	   Take[#,{nbIndiceSub+1,nbIndiceSub+nbExtension}] &,
	   firstRowCOB];
         temp1=Union[Flatten[someColumns,Infinity]];
	 If [temp1==={0}||temp1==={},
	     True,
             Print[temp1];
	     Print["in the change of basis of variable ",LHSvar,", Callee 
  indices   are not independent from extension indices ",
	useSubSys1[[3,3]]," Cannot perform the change of basis
on the subsystem ",useSubSys1[[1]],"\n"];False
	     ]
         ]

checkSubIndexIndependence[a___]:=
  Message[checkSubIndexIndependence::WrongArg]

checkSubIndexIndependence::WrongArg="Wrong Argument for checkSubIndexIndependence"

(*** checkSimpleUseInput checks that the input to subsystems 
  are of the form: var[A] or affine[var[A],matrix[m]] with m identity *)

Clear[checkSimpleUseInput]
checkSimpleUseInput[curSys:_system,
 LHSvar:_String]:=
  Module[{uses,usesLHS,useSubSys1,posAffineVar,mat1,res},
	 uses=Map[getPart[curSys,#] &,Position[curSys,use[___],Infinity]];
	 usesLHS=Select[uses,Position[#,var[LHSvar],Infinity]=!={} &];
	 res=True;
	 If [usesLHS=!={},
	     Do [useSubSys1=usesLHS[[i]];
		 posAffineVar=Position[useSubSys1,affine[var[LHSvar],m:_matrix]];
		 res1=If [posAffineVar==={},
			 True,
			 If [Length[posAffineVar]>1,
			     Print["More than one use of ",LHSvar,
				   " in use ",useSubSys1[[1]],
				   " not implemented"];
			     False,
			     mat1=getPart[useSubSys1,
					  Append[posAffineVar[[1]],2]];
			     If [!identityQ[mat1],
				 Print["Sorry, the input to subsystem ",
				       useSubSys1[[1]],
				       " is not in correct form:  ",
				       show[getPart[useSubSys1,
						    posAffineVar[[1]]],
					    silent->True],
				       " please add local variable for it, recursive COB not done for this variable "];
				 False,
				 True]
			   ]
			 ];
		 res=res&&res1,
		 {i,1,Length[usesLHS]}]
	   ];
	 res
	 ]

checkSimpleUseInput[a___]:=
  Message[checkSimpleUseInput::WrongArg,a]

checkSimpleUseInput::WrongArg="Wrong argument for checkSimpleUseInput"

buildNewCOB::err2="In the change of basis of variable `1`, Parameter `2` depends on 
Extension indices in use of  `3`. Cannot perform the change of basis"
buildNewCOB::err3="In the change of basis of variable `1`, Parameter `2` does not depend on a single parameter in use of  `3`. Cannot perform the change of basis"

(* this function build the recursive change of basis function 
   to be applied to the subsystem from the original COB function,
   basically, it drops the extension indices and replace the parameter of the 
   caller by the parameter of the subsystem (respecting the parameter 
   assignement function 
   of the use which must be "simple".
 Moreover, we have to take into account the fact that
   the COB is not necessarily squarte (generalized change of basis). 
   In the case of a generalized change of basis, it is assumed that the 
   additionnal indices must be local indices (not extension indices), except 
   if the extDomUseCOB is set to True. In that case, the COB comes from a call 
to extDomainCOB and the additionnal indices are extension indices*)

Clear[buildNewCOB]
buildNewCOB[curSys:_system,
 subSys1:_system,
 oldDecl:_decl,
 useSubSys1:_use,
 LHSvar:_String,
 subName:_String,
 fn:_matrix,
 fnInverse:_matrix,
 opts___Rule]:=
Catch[
   Module[{COBmat,newCOBmat,nbParamSub, nbParamCaller,nbExtension,middleRowCOB, someColumns},

	   optDebug = debug/.{opts}/.Options[changeOfBasis];
	 optExtDomUseCOB=extDomUseCOB/.{opts}/.Options[changeOfBasis]; 

         If[optDebug,Print["******** entering buildNewCOB"]];
         If[optDebug,Print["extDomUseCOB options: ", optExtDomUseCOB]];
         If[optDebug,Print["fn: ", show[fn,silent->True]]];
         COBmat=fn[[4]];
         nbRows=fn[[1]];
	 nbColumns=fn[[2]];
         (* number of parameter of the subsystem *)
         nbParamSub=subSys1[[2,1]];
         (* number of parameter of the caller *)
         nbParamCaller=curSys[[2,1]];
	 (* extension indices of the use without parameters*)
         nbExtension=useSubSys1[[3,2]]-nbParamCaller-1; 
         (* number of indices which are not extension indices. *)
	 nbIndiceSub=nbColumns-nbExtension-nbParamCaller-1;
         (* number indices of the  subsystem variable 
              after the COB (which may not be the same because of
             generalized COB), if the extDomUseCOB options is fales, 
             the new indices are for the subsystem, if it is set to 
             True, the new indices are for the caller (see fonction 
             extDomainCOB ) *)
         If[!optExtDomUseCOB,
             (* regular recursive COB *)
             nbIndiceSubAfterCOB=nbRows-nbExtension-nbParamCaller-1,
             (*  COB on extension indices*)
             nbIndiceSubAfterCOB=nbIndiceSub];
          If[optDebug,Print["nbExtension ", nbExtension,"\n nbIndiceSub ",nbIndiceSub, "\n nbIndiceSubAfterCOB ",nbIndiceSubAfterCOB]];
         paramAssign=useSubSys1[[3]];

       (************ step 1: build the assign parameter sub mat  ****) 
          assignParameterSubMat={};
          Do[curParamRow=paramAssign[[4,i]];
            (* dropping columns concerning extention indices (these are 0s) *)
            curParamRow=Drop[curParamRow,{1,nbExtension}];
             (* dropping constant part columns *) 
              assignParameterSubMat=Append[assignParameterSubMat,
                      Drop[curParamRow,-1] (* cst part=0 *)];
           ,{i,1,nbParamSub}];

           If[optDebug,Print["assignParameterSubMat= ",assignParameterSubMat]];

          (**** second step: build the parameter part of the new COB *)
          (* In the caller, the COB might involve parameters (i.e. i->i+N)
             In the subsystem, the parameter involved depend on the parameter assignement 
             function. Here, we define the parameter of the subsystem COB for each local indice:
             for local indice , we define the parameter part of the subsystem
             COB by composing the part on the parameter of the COB with the 
             assignParameterSubMat (constant part not concerned, because the parameter assignment 
             function is supposed to be simple). example: if COB is COB1=(i,j,N,M,P->i+M,j,N,M,P) and parameter assignement
              fucntion is PA=(N,M,P->M,P) (no extention indices), then the subsystem COB is COB2=(i,j,M,P->i+M,j,M,P), if COBiN is the part 
              of the COB concerned with parameter here: COB1N=(N,M,P->M,0) and COB2N=(M,P->M,0), As we know that 
             the parameter assignement is simple (i.e. it is extracted from a permutation), it is full row rank, hence 
            we can define a rigth inverse which is exactly its transposition : PATrans=(M,P->0,M,P). 
             we have then the relation: COB2N=COB1N*PATRans (matrix product). 29/04/03 this proof is probably false because the 
             parameter assignement function is not always primitive: M->M,M but it seems to work also ......*)

           tempMat=COBmat;
           (* drop the constant row *) 
           tempMatRow=Drop[COBmat,-1];
           (* drop the parameter rows *) 
           tempMatRow=Drop[tempMatRow,-nbParamCaller];
           (* drop the extension indices rows *) 
           tempMatRow=Drop[tempMatRow,-nbExtension];
           (* keep only the columns corresponding to parameters: *)
          tempMatColumn=Map[Drop[Drop[#,nbIndiceSub+nbExtension],-1] &,
                tempMatRow];
           COBParamSubMat=tempMatColumn;
           If[optDebug,Print["COBParamSubMat",COBParamSubMat]];
            newCOBParamPart=If[(assignParameterSubMat==={})||(COBParamSubMat==={}) ,{},
                              transposeAPSM=Transpose[assignParameterSubMat];
                            COBParamSubMat.transposeAPSM];
           If[optDebug,Print["newCOBParamPart: ",newCOBParamPart]];


          (* for each subsystem parameter: add the column and row for that 
              parameter *)
          finalMat={};
          (*************** Building the final COB (row by row) *********************)
          (* first loop: for each subsystem indice *)
          Do[finalMat=Append[finalMat,
                      Join[Take[COBmat[[i]],nbIndiceSub] (* subsystem indice part *),
                          newCOBParamPart[[i]] (* subsystem Param Part *),
                         Take[COBmat[[i]],-1] (*constant part *)]]
            ,{i,1,nbIndiceSubAfterCOB}];

         (* second loop: for each subsystem parameter *)
          Do[finalMat=Append[finalMat,
             Join[Table[0,{j,1,nbIndiceSub}],Table[If[i===j,1,0],{j,1,nbParamSub}],{0}]],
           {i,1,nbParamSub}];

         (* Constant part row *)
          finalMat=Append[finalMat,
             Join[Table[0,{j,1,nbIndiceSub+nbParamSub}],{1}]];
           If[optDebug,Print["subsystem new COB mat",finalMat];Print["**** leaving buildNewCOB"]];
          
       Alpha`matrix[Length[finalMat],Length[finalMat[[1]]],
             Join[Take[fn[[3]],nbIndiceSub],subSys1[[2,2]]],finalMat]
  ]
]

buildNewCOB[___]:=
  Message[buildNewCOB::WrongArg]


buildNewCOB[___]:=
  Message[buildNewCOB::WrongArg]


(*****************************************************************)
(***        ORIGINAL COB CODE  (inherited from alpha du centaur! *) 
(*****************************************************************)

Clear[changeOfBasis];

(* Called with no system *)	 
changeOfBasis[ COBspec:_String, opts:___Rule ] := 
Catch[
  Module[{r},
  $program = $result;
  Check[r = changeOfBasis[$result, COBspec, opts],
	$result = $program;Throw[Null]];
	$result = r
  ]
];

changeOfBasis[ sys:_system, COBspec:_String, opts:___Rule ] :=
Catch[
  Module[{COBterm,LHSvar,fn},
    (* Parse COBterm *)
    Check[
      COBterm = readExp[COBspec, sys[[2]]],
      changeOfBasis::wrgcob = "could not parse change of basis spec";
      Throw[Message[changeOfBasis::wrgcob]]
    ];

    LHSvar = Part[COBterm, 1, 1];
    fn = Part[COBterm, 2];
    changeOfBasis[sys, LHSvar, fn, opts]
  ]
];

changeOfBasis[ LHSvar:_String, fn:_Alpha`matrix, opts:___Rule ] := 
Catch[
  Module[{r},
  $program = $result;
  Check[r = changeOfBasis[$result, LHSvar, fn, opts],
	$result = $program; Throw[Null]];
  $result = r
  ]
];

changeOfBasis::noRecurse= " Please turn option recurse to False";

changeOfBasis[ sys:system[n_, p_, i_, o_, locals_, equas_],
	      LHSvar:_String,
	      fn:_matrix, opts:___Rule] :=
Catch[
  Module[{allvariables,oldDecl,optRecurse,optDebug,n1,decl,lat,matProd,rules1,
    rules2, rules3, locvar},

  (* Get options *)
  allVariables = allVariablesAllowed/.{opts}/.Options[changeOfBasis];
  optRecurse = recurse/.{opts}/.Options[changeOfBasis];
  optDebug = debug/.{opts}/.Options[changeOfBasis];

  If[ optDebug,Print["**** Entering traditionnal COB for system :",sys[[1]]]];
  If[ optDebug,Print["**** optRecurse is ", optRecurse]];

  (*  To be able to performe a recursive COB on LHSvar where
      LHSvar is an input to a use, the argument passed to the use must be
      the LHSvar itself (not an expression containing the LHS var *)
  If[ optRecurse,
    If[ !checkSimpleUseInput[ sys, LHSvar ],
      Throw[Message[changeOfBasis::noRecurse]]
    ]
  ];

  (* Testing for pseudo unimodularity previously the test was:  
     !unimodularQ[fn]
     Now we allow any square integral change of basis and square rationnal 
     change of basis if they are pseudo unimodular i.e. if the are 
     invertible on the domain of the variable on which they apply
  *)
  If[ fn[[1]]=!=fn[[2]], Throw[Message[changeOfBasis::notSquareMat]]];
      
  lastCoef=fn[[4,-1,-1]];
  If[ lastCoef=!=1, 
    (* not integral Matrice *) 
    decl = getDeclarationDomain[sys,LHSvar];
    lat=getMatOfZpol[decl];
    matProd=composeAffines[lat,fn];
    If[matProd[[4,-1,-1]]=!=1,
      Throw[Message[changeOfBasis::notPseudoUnimodular]]]
  ];

  If[ optDebug, Print["*** Unimodular test passed..."] ];

  (* Not a variable *)
  If[ !MemberQ[getVariables[sys],LHSvar],
    Throw[Message[changeOfBasis::wrgvar,LHSvar]] ];

  (* Not a local variable *)
  If[!MemberQ[getLocalVars[sys],LHSvar]&&!allVariables,
		  Throw[Message[changeOfBasis::nlocv,LHSvar]]
  ];

  If[ !MemberQ[getLocalVars[sys],LHSvar]&&allVariables,
	    Print["Warning1, performing COB on I/O of system ",n,
		  ": changing its semantics"]
  ];

  n1 = fn[[2]];   (* Number of old indices *)

  decl = getDeclarationDomain[sys,LHSvar];
  oldDecl = getDeclaration[sys,LHSvar];

  If[ n1-1=!=decl[[1]],Throw[Message[changeOfBasis::wrgdim]]];

  If[ optDebug, Print["*** Dimension test was passed",LHSvar]];

  (* Everything is OK *)
  With[ {fnInverse = inverseMatrix[fn] },

    Global`$$rules1 = matchingLhsRule[LHSvar, fn, fnInverse ];
    Global`$$rules2 = otherLhsRule[LHSvar, fn, fnInverse ];
    Global`$$rules3 = useInputsRule[LHSvar, fn, fnInverse ];

    res = 
      useOutputCheck4GenCOB[
        Alpha`system[n, p,
          i/. defRule[LHSvar, fn, fnInverse],
          o/. defRule[LHSvar, fn, fnInverse],
          locals /. defRule[LHSvar, fn, fnInverse],
          equas /. {   matchingLhsRule[LHSvar, fn, fnInverse], 
                       otherLhsRule[LHSvar, fn, fnInverse] ,
                       useInputsRule[LHSvar, fn, fnInverse]  } 
        ],
        LHSvar, oldDecl, fn, fnInverse,
		   opts
      ]
  ];

  If[optDebug,Print["*** Leaving useOutputChek4GenCOB "] ];

   (*
  Check[
    !DomEqualQ[ getDeclarationDomain[ res, LHSvar ],
      expDomain[ res, getDefinition[ res, LHSvar ] ] ],
    Print[ getDefinition[ res, LHSvar ] ];
    Print[ getDeclarationDomain[ res, LHSvar ] ];
    Print[ expDomain[ res, getDefinition[ res, LHSvar ] ] ];
  ];

  If[
    !DomEqualQ[ getDeclarationDomain[ res, LHSvar ],
                  expDomain[ res, getDefinition[ res, LHSvar ] ] ], 
    Print["Warning: declaration domain and definition domain do not match anymore"]
      ];
    *)

  res
 ]  (* Module *)
]; (* Catch *)

(* Wrong parameters: send error message *)
changeOfBasis[a___] := Message[changeOfBasis::params,Print[Drop[{a},1]]];


(****************************************************************************)
(* A generalized change of basis of an ALPHA variable.                      *)
(* Can do expansions, projections, and unimoduar COB s                      *)
(*                                                                          *)
(* Specification is : V.(i,j, ... -> f(i,j,..), g(i,j,..), ... )            *)
(*                    |  \______/    \_______________________/              *)
(* Variable to be changed    old    new indices=fn[old indices]             *)
(*  (must be a local var)  indices                                          *)
(*                                                                          *)
(* newid = {"A", "B", ...} -- names for new indices, must agree in number   *)
(*                            with index functions in specification         *)
(*--------------------------------------------------------------------------*)
(* A program sketch :                                                       *)
(*                                                                          *)
(* A : { i,j | ... } of integer ;                                           *)
(* let                                                                      *)
(*   A   = ... ;                                                            *)
(*   ... = ... A ... ;                                                      *)
(* tel                                                                      *)
(*                                                                          *)
(* Transformed by command:                                                  *)
(*    changeOfBasis["A.(i,j -> f(i,j), i,j)", {"Z","i","j"}]                *)
(* Becomes:                                                                 *)
(*                                                                          *)
(* A : { Z,i,j | Z=f(i,j); ... } of integer ;                               *)
(* let                                                                      *)
(*   A   = ( ... ).(Z,i,j -> i,j) ;                                         *)
(*   ... = ... A.(i,j -> f(i,j), i, j) ... ;                                *)
(* tel                                                                      *)
(****************************************************************************)

Clear[PartPos];
PartPos[expr_,{pos__}]:=Part[expr,pos];

(** this function checks whether the variable to which is applied the
  change of basis is used as input or output to a subsystem. 
  If the options recurse is set, it calls useCOB, if not, if the
  variable is used as output, we have to add a local variable 
  to enable the COB *) 
 
Clear[useOutputCheck4GenCOB];

useOutputCheck4GenCOB[ 
   sys:Alpha`system[n_, p_, i_, o_, locals_,equas_],
   LHSvar_String, 
   oldDecl_,
   fn_Alpha`matrix,
   fnInverse_Alpha`matrix,
   opts:___Rule] :=
Module[{allVariables,optRecurse,optDebug,res, eqnUse},

  (* Get options *)
  allVariables =  allVariablesAllowed/.{opts}/.Options[changeOfBasis];
  optRecurse = recurse/.{opts}/.Options[changeOfBasis];
  optDebug = debug/.{opts}/.Options[changeOfBasis];
  eqnUse=Select[ equas, Head[#]==Alpha`use & ];

  If[ optDebug, Print["*** Entering useOutputCheck4GenCOB  "] ];

  If[ optRecurse,
    If [optDebug,
      Print["trying recursive COB on var  ",LHSvar];
      Print["fn:",show[fn,silent->True]];
      Print["fnInverse:",show[fnInverse,silent->True]]
    ];

    res = useCOB[ sys, LHSvar,fn,fnInverse,oldDecl,opts];
    If[ 
      MatchQ[res,_Alpha`system]
    ,
      Return[res]
    ,	
      Return[sys];

      If[ optDebug, Print[" recursive COB failed on var ",LHSvar] ];

      (* The COB has not been done, the rest of 
        the code below is executed *)
    ]
  ];

  If[ 
    MemberQ[ Flatten[ Map[ #[[5]]& ,eqnUse]], LHSvar ]
  ,
    With[ {newName = "oldX"<>LHSvar},
      Print["Warning2 : ", LHSvar, 
        " appears in the output list of a use :"];
      Print["  Adding the auxilliary variable ", newName];
      res = Alpha`system[ n, p, i, o, 
        Append[ locals,
         oldDecl /. LHSvar :> newName ],
         Flatten[ equas /. 
          useOutputRule[ LHSvar, fnInverse, newName],  1 ]
      ];
    ]
  ,
    (* no output to nop use, nothing to do *)   		
    res = sys
  ];

  (* This was added on sept. 30 2009 *)
  (* It may happen that a change of basis creates holes in the 
    declaration domain... *)
  Module[ {dec, def, declar},
    dec = getDeclarationDomain[ res, LHSvar ];
    def = expDomain[ res, getDefinition[ res, LHSvar ] ];

    declar = getDeclaration[ res, LHSvar ];

  (*
    I added, then removed this test on April 2010. PQ
    If[ !DomEqualQ[ dec, def ],
      Print["*** Warning. For variable: ", LHSvar, 
        " declaration domain and definition domain do not match anymore"];
      Print["Nothing changed..."];

        res = res/.{declar -> decl[ LHSvar, declar[[2]], def ]};
    ]
  *)
  ];

  res
];

useOutputCheck4GenCOB[____] := Print["Error in useOutputCheck4GenCOB"];



(*****************************************************************)
(***        GENERALIZED COB CODE                                 *) 
(*****************************************************************)
       
(* form == call by hand, default system *)
changeOfBasis[spec:_String, newid:{___String}, opts:___Rule]:=
Catch[
  Module[{r},
   $program = $result;
   Check[r = changeOfBasis[$result, spec, newid, opts],
	$result = $program; Throw[Null]];
    $result = r
  ]
];

(* form == call by another function, default system *)
changeOfBasis[v:_String, m:_matrix, newid:{___String}, opts:___Rule]:=
Catch[
  Module[{r},
   $program = $result;
   Check[r = changeOfBasis[$result, v, m, newid, opts],
	$result = $program; Throw[Null]];
    $result = r
  ]
];

(* form == call by hand, explicit system *)
changeOfBasis[ sys:_system, spec_String, newid:{___String}, opts:___Rule ]:=
Catch[
  Module[ {t,m,v},
    (* var. ( i,j->f(i,j),i,j )  *)
    Check[t = readExp[spec,
      sys[[2]]],Throw[Message[changeOfBasis::wrgarg]]];
    v = Part[t,1,1];		(* var name string *)
    m = Part[t,2];  		(* matrix of transformation *)

    changeOfBasis[ sys, v, m, newid, opts ]
  ]
]

(* form == call by function, explicit system *)
changeOfBasis[sys:_system, v_String, m1:_matrix, 
   newid:{___String}, opts:___Rule ]:=
Catch[
  Module[{allVariables,optRecurse,optDebug,n1,n2,m2,i,j,pos,d,
    x,s1,s2,newidparam,oldDecl},

  (* Get options *)
  allVariables = allVariablesAllowed/.{opts}/.Options[changeOfBasis];
  optRecurse = recurse/.{opts}/.Options[changeOfBasis];
  optDebug = debug/.{opts}/.Options[changeOfBasis];

  If [optDebug,Print["**** Entering generalized COB for variable :",v," on system system :",sys[[1]]]];
  If [optDebug,Print["optRecurse is ", optRecurse]];

  (*  To be able to performe a recursive COB on LHSvar where
      LHSvar is an input to a use, the argument passed to the use must be
      the LHSvar itself (not an expression containing the LHS var) *)
  If[ optRecurse,
    If [!checkSimpleUseInput[sys,v],
    Throw[Message[changeOfBasis::noRecurse]]]
  ];

  (* add parameters, if any (Florent) *)
  newidparam = Join[ newid, sys[[2]][[2]] ]; 

  n1 = m1[[2]];   (* number of old indices + 1 *)
  n2 = m1[[1]];   (* number of new indices + 1 *)

  (* Check that change of basis function is consistent 
    with dimension of newids *)

  If[ Length[newidparam]=!=n2-1, Throw[Message[changeOfBasis::wrgdim2]] ]; 

  (* Check existence of variable *)
  If[!MemberQ[getVariables[sys],v],
    Throw[Message[changeOfBasis::wrgvar,v]]
  ];

  (* Check local variable  *)
  If[!MemberQ[getLocalVars[sys],v]&&!allVariables,
		      Throw[Message[changeOfBasis::nlocv,v]]
  ];

  If[!MemberQ[getLocalVars[sys],LHSvar]&&allVariables,
    Print["Warning, performing COB on I/O of system ",
    sys[[1]],": changing its semantic"]
  ];


  (* Declaration ---------------------------------------------------- *)
  pos = Position[sys,Alpha`decl[v, _, _],Infinity];

  oldDecl = getPart[sys,pos[[1]]]; (* save it in case of use return*)
  pos = Append[pos[[1]],3];	(* position of domain of v *)
  d = getPart[sys,pos];	(* declared domain of v *)
  If[d[[1]]=!=n1-1,Throw[Message[changeOfBasis::wrgdim]]];

  (* Compute left inverse function *)
  Check[ m2 = inverseInContext[m1,d],Throw[Null] ];
  m2 = ReplacePart[m2, newidparam, 3];
  (* s1 is the temporary system *)
  Check[
  (* I need to put a DomImage here for compatibility with 
  generalized change of Basis: DomZImage is not implemented for non square 
  matrices, we should have a DomZImage here *) 
    If [Position[d,zpol,Infinity]=!={} && m1[[1]]=!=m1[[2]],
		Print["Warning, generalized change of basis with Zpols: please check the result"]];
    If [ m1[[1]]=!=m1[[2]],
                (* not square matrix *)
     s1 = ReplacePart[sys, ReplacePart[ DomImage[d,m1], newidparam, 2 ], pos],
                (* square matrix *)
     s1 = ReplacePart[sys, ReplacePart[ DomZImage[d,m1], newidparam, 2 ], pos]],
    changeOfBasis::errorDoM = "error while calling DomZImage ";
    Throw[ Message[ changeOfBasis::errorDoM ] ]
  ];   

  (* Definition ----------------------------------------------------- *)
  pos = Position[ s1[[6]], equation[v,_]];
  (* s2 is the temporary system *)
  s2 = 
    If[pos=!={},                    (* defined with an equation  *)
      (pos = {6,pos[[1,1]],2};      (* position of definition *)
       d = PartPos[s1,pos];
       ReplacePart[s1,affine[d,m2],pos] ),
      (* else defined in a use statement *)
      s1 
    ];

  (* Uses ----------------------------------------------------------- *)
  (* also works for subsystems arguments*)
  pos = Position[ s2[[6]], Alpha`var[v] ]; 
  
  If[pos==={},
		s3=s2,
		pos = Map[Function[x,Prepend[x,6]],pos];
  s3=ReplacePart[s2, Alpha`affine[Alpha`var[v], m1], pos]
		];
(* performs (eventually) the recursive change of basis, 
		if it does, it also updates the extension domain of the uses*)
     
     res=useOutputCheck4GenCOB[ s3, v, oldDecl, m1, m2, opts]
  ] (* Module *)
     
     ] (* Catch *)
     

(*****************************************************************)
(***        EXT DOMAIN  COB CODE                                 *) 
(*****************************************************************)
(* If one wants to perform a change of basis in which the extension 
domain of a use is modified, this must be done apart, because the change of basis  is common to all the variables of the use  *)

Clear[extDomainCOB]

(*****************************************************************)
     (* classical COB *)
(*****************************************************************)

extDomainCOB[ COBspec:_String, opts:___Rule ] := 
Catch[
  Module[{r},
  $program = $result;
  Check[r = extDomainCOB[$result, COBspec, opts],
	$result = $program;Throw[$Failed]];
	$result = r
  ]
];

extDomainCOB[ sys:_system, COBspec:_String, opts:___Rule ] :=
Catch[
  Module[{COBterm,LHSvar,fn},
    (* Parse COBterm *)
    Check[
      COBterm = readExp[COBspec, sys[[2]]],
      changeOfBasis::wrgcob = "could not parse change of basis spec";
      Throw[Message[changeOfBasis::wrgcob]]
    ];

    LHSvar = Part[COBterm, 1, 1];
    fn = Part[COBterm, 2];
    extDomainCOB[sys, LHSvar, fn, opts]
  ]
];

extDomainCOB[ LHSvar:_String, fn:_Alpha`matrix, opts:___Rule ] := 
Catch[
  Module[{r},
  $program = $result;
  Check[r = extDomainCOB[$result, LHSvar, fn, opts],
	$result = $program; Throw[$Failed]];
  $result = r
  ]
];

extDomainCOB[ sys:system[n_, p_, i_, o_, locals_, equas_],
	      LHSvar:_String,
	      fn:_matrix, opts:___Rule] :=
Catch[
  Module[{newIndices},
    If[ !unimodularQ[fn], Throw[Message[changeOfBasis::wrgmat]] ];
      newIndices=Drop[fn[[3]],-p[[1]]];
      extDomainCOB[sys, LHSvar, fn, newIndices, opts]
]
]

(*****************************************************************)
     (* generalized  COB *)
(*****************************************************************)
(* form == call by hand, explicit system *)

extDomainCOB[spec:_String, newid:{___String}, opts:___Rule]:=
Catch[
  Module[{r},
   $program = $result;
   Check[r = extDomainCOB[$result, spec, newid, opts],
	$result = $program; Throw[$Failed]];
    $result = r
  ]
];

extDomainCOB[ sys:_system, spec_String, newid:{___String}, opts:___Rule ]:=
Catch[
  Module[ {t,m,v},
    (* var. ( i,j->f(i,j),i,j )  *)
    Check[t = readExp[spec,
      sys[[2]]],Throw[Message[changeOfBasis::wrgarg]]];
    v = Part[t,1,1];		(* var name string *)
    m = Part[t,2];  		(* matrix of transformation *)

    extDomainCOB[ sys, v, m, newid, opts ]
  ]
]


extDomainCOB[v:_String, m:_matrix, newid:{___String}, opts:___Rule]:=
Catch[
  Module[{r},
   $program = $result;
   Check[r = extDomainCOB[$result, v, m, newid, opts],
	$result = $program; Throw[$Failed]];
    $result = r
  ]
];

extDomainCOB::useNotFound="use of subsystem `1` not found in `2`"
extDomainCOB::toManyUse="To many use of subsystem `1`  in `2`"
extDomainCOB::dimExt="incompatible dimension"
extDomainCOB::simplifyUseInput="please simplify input in use of system `1`"
(***************************************************************)
     (* kernel form *)
     (*********************************************************)
extDomainCOB[sys:_system, v_String, m1:_matrix, 
   newid:{___String}, opts:___Rule ]:=
Catch[
  Module[{realNewId,eqnUse,eqnUseLHSvar,check1,extDomainDim,nbRowCOB,
	nbColumnCOB,newUseDomain, curSys,curVarDecl,curVarId,nbAdditionalId,
		 curNewId,curVarCOBmat,curRow,optDebug},
		
		optDebug = debug/.{opts}/.Options[changeOfBasis];
If [optDebug,Print["******* Entering extDomainCOB"]];    
(* Append the parameters to the list of new indices given by user *)
     realNewId= Join[newid,sys[[2,2]]];     
     If[optDebug,
		Print["COB mat: ",show[m1,silent->True]];
     Print["readNewId: ",realNewId]];
     
     (************* First part: various validity check ******************)
     (* Check that the subsystem is called only once  *) 
     eqnUse=Select[sys[[6]], Head[#]==Alpha`use & ];
     eqnUseLHSvar=Select[ eqnUse,First[#]===v &];
     If [eqnUseLHSvar==={},
		Message[extDomainCOB::useNotFound,v,sys[[2]]];
     Throw[$Failed]];
     If [Length[eqnUseLHSvar]>1,
		Message[extDomainCOB::toManyUse,v,sys[[2]]];
     Throw[$Failed]];

     eqnUse=eqnUseLHSvar[[1]];
     If[optDebug,Print["eqnUse :",eqnUse]];
     (* check that the input and output are simple *)
     check1=True;
     If[MatchQ[eqnUse[[4,1]],var[___]],
		(* The argument of checkSimpleUseInput should be simplified
     currently, we have to indicate q variable name, this if brqnch 
		correspond to the case where the first input to the use 
		is a variable *)
     check1=checkSimpleUseInput[sys,eqnUse[[4,1,1]]],
		(* here, it is the case where the first input to the use 
		is var.affine *) 
     If[MatchQ[eqnUse[[4,1]],affine[var[___],___]],
		check1=checkSimpleUseInput[sys,eqnUse[[4,1,1,1]]],
		(* in all other cases, we cannot perform the COB *)
		Message[extDomainCOB::simplifyUseInput,v];
                check1=False]];
     If [!check1,
		Message[changeOfBasis::noRecurse];Throw[$Failed]];
     
     (* check that the dimension of the COB mat and extension domain are 
     compatible *)
     extDomainDim=eqnUse[[2,1]]; (* including parameters, without constant *)
     If[optDebug,Print["extDomainDim ",extDomainDim]];
     nbRowCOB=m1[[1]]-1;
     If[optDebug,Print["nbRowCOB ",nbRowCOB]];
     nbColumnCOB=m1[[2]]-1;
     If[optDebug,Print["nbColumnCOB ",nbColumnCOB]];
     If [nbColumnCOB=!=extDomainDim,
		Message[extDomainCOB::dimExt];
     Throw[$Failed]];
     If [nbRowCOB=!=Length[realNewId],
		Message[extDomainCOB::dimExt];
     Throw[$Failed]];
     
     (*************** part two:  performing the COB ***********) 
     (* compute the new use domain *)
     (* I need to put a DomImage here for compatibility with 
     generalized change of Basis: DomZImage is not implemented for non square 
     matrices, we should have a DomZImage here *) 
     If [Position[eqnUse[[2]],zpol,Infinity]=!={} && m1[[1]]=!=m1[[2]],
		Print["Warning, generalized change of basis with Zpols: please check the result"]];
     If [m1[[1]]=!=m1[[2]],
                (* non square matrix *) 
     newUseDomain=DomImage[eqnUse[[2]],m1],
                (* square matrix *) 
     newUseDomain=DomZImage[eqnUse[[2]],m1]];
     
     newUseDomain=ReplacePart[newUseDomain,realNewId,2];
     If[optDebug,Print["new use Domain is: ",
		show[ newUseDomain,silent->True]]];
     
     (* compute the parameter assignement (only if it is a generalized 
         change of basis) add a zero column for each new indices *)
     nbNewIndices=m1[[1]]-m1[[2]];
     If[ nbNewIndices===0,
		newParamAssignMat=eqnUse[[3]],
		firstNewIndicepos=extDomainDim-sys[[2,1]];
     (* else, for each new indice *)
     curParamAssignMat=eqnUse[[3,4]];
     Do[ curParamAssignMat=Map[Insert[#,0,firstNewIndicepos+i] &,
		curParamAssignMat],
       {i,1,nbNewIndices}];
     newParamAssignMat=ReplacePart[eqnUse[[3]],curParamAssignMat,4];
     newParamAssignMat=ReplacePart[newParamAssignMat,realNewId,3];
     newParamAssignMat=ReplacePart[newParamAssignMat,
		newParamAssignMat[[2]]+nbNewIndices,2];
     ];
     If[optDebug,Print["newParamAssignMat",newParamAssignMat]];
     curSys=sys;

          
     (* do COB for all input and output, the construction of the COB mat
		is the same for input and outputs, only the name
		of the variable is at a different place.
		output *) 
     inputAndOutput=Join[eqnUse[[4]],eqnUse[[5]]];
     Do[ 
     If[i<=Length[eqnUse[[4]]],
	  (* curVar is input *)
     curVar=If[MatchQ[inputAndOutput[[i]],var[___]],
       inputAndOutput[[i,1]],inputAndOutput[[i,1,1]]],
	  (* else, curVar is output *)
     curVar=inputAndOutput[[i]]];
     
     If[optDebug,Print["****** trying variable : ",curVar]];
     curVarDecl=getDeclaration[sys,curVar];
     curVarId=curVarDecl[[3,2]];
     (* nbAdditionnalID is the local indices of variables curVar 
     (indices which are not extension indices) *)
     nbAdditionalId=Length[curVarId]-extDomainDim;
     If[optDebug,Print["nbAdditionalId ",nbAdditionalId]];
     (* curNewId is the list of local indices of curVar, but with the 
       mames taken from the newid list *)
     curNewId=Join[Take[curVarId,nbAdditionalId],realNewId];
     (* build the COB matrix for curVar *) 
     (* build the COB mat *)
     curVarCOBmat={};
     (* row of indices which are not extension indice *)
     Do[curRow=Table[If[row===col,1,0],{col,1,Length[curVarId]+1}];
     curVarCOBmat=Append[curVarCOBmat,curRow],
       {row,1, nbAdditionalId}];
     (* row of indices which are  extension indice (including parameters) *)
     (* these rows are set to identity. Whatever, these rows are, it does 
       not affect the change of basis on the subsystem, but currently,
       the recursive COB forbids a COB which is not identity on
       extention indices (which is fair), hence we introduce the 
       extDomUseCOB->True option of change of basis *)
     Do[curRow=Join[Table[0, {col,1, nbAdditionalId}],m1[[4,row]]];
     curVarCOBmat=Append[curVarCOBmat,curRow],
       {row,1,Length[realNewId]}];
     If[optDebug,Print["curVarCOBmat temp:",curVarCOBmat]];
     (* constant part row *)      
     curVarCOBmat=Append[curVarCOBmat,
		Join[Table[0, {col,1,Length[curVarId]}],{1}]];
     COBmat=matrix[Length[curNewId]+1,Length[curVarId]+1,
		curVarId,curVarCOBmat];
     If[optDebug,
       Print["We will perform COB on ",curVar, ", the COB mat is: ", COBmat,
       " the new indices : ",Drop[curNewId,-sys[[2,1]]]]];
     curSys=Check[
     changeOfBasis[curSys,curVar,COBmat,Drop[curNewId,-sys[[2,1]]] 
		(* forget parameters *),extDomUseCOB->True,recurse->True,
       allVariablesAllowed->True,opts],
     Throw[sys] (* if something goes wrong we stop the process *)]
,{i,1,Length[inputAndOutput]}];

(***** third part, 
       If the recursive COB did not fail, we change the extension domain *)
eqnUseTemp=First[Select[curSys[[6]], MatchQ[#,Alpha`use[v,___]] & ]];
eqnUseTemp2=ReplacePart[eqnUseTemp,newUseDomain,2];
finalEqnUse=ReplacePart[eqnUseTemp2,newParamAssignMat,3];
If[optDebug,Print["finalEqnUseTemp ",show[finalEqnUse,silent->True]]];
curSys=curSys/.(eqnUseTemp->finalEqnUse);
getSystem[curSys[[1]]];
curSys
]
]

extDomainCOB::wrongArg="Wrong Argument doe extDomain: `1`"
extDomainCOB[a___]:=Message[extDomainCOB::wrongArg,Map[Head,{a}]];

Clear[ changeIndexes ];
changeIndexes[ 
  var:_String, changeRules:{___Rule}, opts:___Rule
  ]:=
Catch[
  Module[ {r},
    $program = $result;
    Check[ r = changeIndexes[ $result, var, changeRules, opts ],
      $result = $program; 
      changeIndexes::err = "could not do the change of indexes";
      Throw[ Null ] 
    ];
    $result = r
  ]
];
changeIndexes[
  sys:_system, var:_String, changeRules:{___Rule}, opts:___Rule
  ]:=
Catch[
  Module[ {dbg, vrb, eqs, eq, res, dcl, useform, decls},
    eqs = sys[[6]]; (* Get equations *)

    eq = Cases[ eqs, equation[ var, _ ] ] ;
    useform = Cases[ eqs, use[_,_,_,_,{___,var,___}] ];

    (* One equation found *)
    Which[ 
      eq =!= {}
    , 
      eq = Firs[ eq ];
      neweq = eq/.changeRules ;
      If[ dbg, show[neweq] ];
      res = Replace[ sys, eq -> neweq, 3 ];
      dcl = getDeclaration[ var ];
      res = Replace[ res, dcl -> (dcl/.changeRules), 3 ]
    ,
      useform =!= {}
    ,
      useform = First[ useform ];
      res = Replace[ sys, useform -> (useform/.changeRules), 3 ];
      (* Get all lhs variables of use *)
      decls = useform[[5]];
      (* Get all declarations *)
      decls = Map[ getDeclaration, decls ];
      show[ decls ];
      res = Replace[ res, Map[ Rule[#,#/.changeRules]&, decls], 2 ];
      res
    ]
  ]
];
changeIndexes[___] := Message[ changeIndexes::params ];

End[]
EndPackage[]


