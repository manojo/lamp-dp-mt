(* file: $MMALPHA/lib/Package/ModularSchedule.m
   AUTHOR : Tanguy Risset
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
BeginPackage["Alpha`ModularSchedule`", {"Alpha`Domlib`",
					  "Alpha`",
					  "Alpha`Options`",
					  "Alpha`Matrix`",
					  "Alpha`Tables`",
					  "Alpha`Semantics`",
					  "Alpha`Substitution`", 
					  "Alpha`Normalization`",
					  "Alpha`Properties`",
					  "Alpha`ChangeOfBasis`",
					  "Alpha`Static`",
					  "Alpha`ScheduleTools`",
					  "Alpha`Pip`"}]

(* Standard head for CVS

	$Author: risset $
	$Date: 2003/01/17 09:47:04 $
	$Source: /udd/alpha/CVS/alpha_beta/Mathematica/lib/Packages/Alpha/ModularSchedule.m,v $
	$Revision: 1.1 $
	$Log: ModularSchedule.m,v $
	Revision 1.1  2003/01/17 09:47:04  risset
	commit after a long silence by Tanguy (before visiting Rennes)
	
	
	 *)

ModularSchedule::usage =
"Package.  Schedule for  alpha program with a new use of the Farkas method, 
 These function should be used through the schedule[] interface
(Package Schedule.m)"

modularSchedule::usage=" debug" 
Alpha`scdc::usage=" debug"
farkasFromList::usage=" farkasFromList[mat_List[List[Integer]],
f_List,funcCoef_List,ID_String]
 takes a matrix m representing a list of constraints 
  in Polylib format, a function f (list of symbolic expressions) and
  the functionCoefs (list of symbols). It return the result 
  applying farkas lemma for the constraint f.x >=0 on the domain represented 
  by the inegalities (i.e. m.x >=0). 
  The result is a list containing the list of constraint
  and the list of variables involved in these constraints.
  The variables involved are the original specified 
  variables (functionCoefs) and the farkas coeffiction in the form: 
  scdc[\"lambdaID0\"], scdc[\"lambdaID1\"] etc 
  ID is used to ensure that these names are only used here."
 farkasFromDomain::usage=" farkasFromList[dom:_domain,
f_List,funcCoef_List,ID_String] same as farkasFromList with the domain expressed as a domain instead of a list of inequalities"
eliminateFarkasEqualities::usage="eliminateFarkasEqualities[constraints, vars] eliminates some 
of the farkas coefficient by using the equalities resulting 
of the Farkas theorem application. the result is a new system 
of inequalties (where no equalities involving Farkas coefs should occurs)
  and a new system of var (where some fakas coef have disappeared"

 projectInequalitySystem::usage=
"projectInequalitySystem[constraint_mat, vars_List, subListVar_List] eliminates some 
of the variable of a linear constraint system by projecting the polyhedron 
 on a sub list of variable (i.e. using Cherhnikova). Warning, this functin 
 will fail for big inequality systems because  of chernikova (static allocating of memory) "
farkasProjectedFromList::usage=
"farkasProjectedFromList[constraint_mat, function_List, subListVar_List]
 Apply farkas on function(x) >= for all x such that  constraint(x) >= 0. 
Then take a list of constraints resulting of a farkas process and remove all 
farkas variables "

 timeFunctionOfVar::usage=" timeFunctionOfVar[var1:_String] returns the 
vector of the symbolic coefficient of the time function of var1 in $result, e.g. {scdc[\"TVar1D1\"],scdc[\"TVar1D2\"],scdc[\"CVar1\"]} ; returns the empty list if fails"
farkasFromPosConstr::usage="debug"
farkasProjectedFromPosConstr::usage="debug"

listToConstraint::usage="listToConstraint[{1 1 2 4} ,{alpha,beta}] returns alpha+2 beta >=4.  returns the empty list if fails "
constraintToList::usage="contraintToList[alpha+2 beta >=4 ,{alpha,beta}] returns {1 1 2 4}; returns the empty list if fails"
 depFunctionCoefFromDep::usage="debug"
 farkasFromDep::usage="debug"
 farkasProjectedFromDep::usage="debug"

farkasProjectedFromDomain::usage=
"farkasProjectedFromDomain[domain1_dom, vars_List, subListVar_List]
Apply farkas on function(x) >= for all x such that  x in domain1. then remove all 
farkas variables "

 farkasFromDep::usage=" farkasFromDep[dep1:_depend,
duration_List] build the farkas constraints from a dependence
"

farkasProjectedFromDep::usage=
"applies  farkasFromDep then remove the farkas coefs"

 reOrderVarsForPip::usage="debug"
els::usage="els[]= elemantarySchedule: used to test the farkas from set of function "

Begin["`Private`"] 

(*******************************************************************
*******************************************************************
   Translation between Polylib constraints and symbolic
 constraints 
*******************************************************************
 *******************************************************************)



Options[modularSchedule] := {debug -> False,
  		         verbose -> True,
		         resolutionSoft->pip,
		         integerSolution->True,
		         addConstraints->{},
		         durations->{},
		         durationByEq->True,
		         scheduleType->affineByVar,
		         objFunction->lexicographic,
			 onlyVar -> all,
			 onlyDep -> all,
			    outputForm->scheduleResult,
			 schedMethod->farkas,
			    optimizationType->time,
			    multiSchedDepth->1,
			    subSystems->False,
			   subSystemSchedule->$scheduleLibrary,
			    multiDimensional->False,
			 }


Clear[constraintToList]

(******************************************************
 Constraint to list generate a Polylib constraint from a 
symbolic constraints. first integer means inequatlity (1) or
 equality (0), Last integer means constant part.
Constraints handled are linear equalities and 
 inequalities. Names of the variables are lost. Warning, do not use 
 any symbol for your constraints: instead of using name a use 
 name scdc["a"] (otherwise their may be conflicts with symbolic names
 returns the empty list is fails
******************************************************)


constraintToList::unknownVar="The constant part could not be extracted: `1`"

constraintToList[GreaterEqual[expr1_, x_Integer], vars : _List,options:___Rule] :=
Catch[
  Module[{constantPart},
	(* constant part LHS-nonConstantPart-x *)
	constantPart=expr1-Apply[Plus, Map[Coefficient[expr1, #]*# &, vars]]-x;
	
	If[!NumberQ[constantPart],
	  Message[constraintToList::unknownVar,constantPart];
	  Throw[{}]
	];
	Append[Prepend[Map[Coefficient[expr1, #] &, vars], 1], constantPart]
  ]
]


 (* Warning, Mathematica does not recognize that this pattern
  is more restrictive than the previous one *)
constraintToList[GreaterEqual[expr1_, expr2_], vars : _List,options:___Rule] :=
    constraintToList[GreaterEqual[expr1-expr2, 0], vars,options] 


constraintToList[Equal[expr1_, x_Integer], vars : _List,options:___Rule] := 
Catch[
     Module[{constantPart},
	(* constant part LHS-nonConstantPart-x *)
	constantPart=expr1-Apply[Plus, Map[Coefficient[expr1, #]*# &, vars]]-x;

	If[!NumberQ[constantPart],
	  Message[constraintToList::unknownVar, constantPart];
	  Throw[{}]];
	Append[Prepend[Map[Coefficient[expr1, #] &, vars], 0], constantPart]
	]
]


 (* Warning, Mathematica does not recognize that this pattern
  is more restrictive than the previous one *)
constraintToList[Equal[expr1_, expr2_], vars : _List,options:___Rule] :=
    constraintToList[Equal[expr1-expr2, 0], vars,options] 

 constraintToList::wrongArg="wrong Argument for function constraintToList : `1` "


 constraintToList[a:___]:=(Message[constraintToList::wrongArg,Map[Head,{a}]];{})

(******************************************************
listToConstraint: opposite to constraints to list
******************************************************)


Clear[listToConstraint]

listToConstraint::missingVars="the indice list `1` does not corresponds to constraint `2`"

listToConstraint[a_List, indices_List,options:___Rule] :=
 Catch[
       Module[{},	
	     If[Length[a] =!= Length[indices] + 2,
	       Message[ listToConstraint::missingVars,a,indices];
	       Throw[{}]];
	     
	     If[a[[1]] === 1, Take[a, {2, -2}].indices + Last[a] >= 0,
	       Take[a, {2, -2}].indices + Last[a] == 0]
       ]
 ]
 
 listToConstraint::wrongArg="wrong Argument for function listToConstraint : `1` "
 
listToConstraint[a:___]:=(Message[listToConstraint::wrongArg,Map[Head,{a}]];{})

 



(*******************************************************************
*******************************************************************
Applying Farkas Lemma  (polylib format for inequalities)
 result is a couple: list of (symbolic) constraints and list of
(symbolic) variable
 Farkas coefficient are called scdc["farkas*"], this * 
can should specified by the "names" parameter 
*******************************************************************
 *******************************************************************)
 
 
 
 
 (******************************************************
  farkasFromList takes a matrix m representing a list of constraints 
  in Polylib format, a function f (list of symbolic expressions) and
  the functionCoefs (list of symbols). It return the result 
  applying farkas lemma for the constraint f.x >=0 on the domain represented 
  by the inegalities (i.e. m.x >=0). Returns {} if fails.
  The result is a list containing the list of constraint
  and the list of variables involved in these constraints.
  The variables involved are the original specified 
  variables (functionCoefs) and the farkas coeffiction in the form: 
  scdc["LambdaID0"], scdc["LambdaID1"] etc 
  ID is used to ensure that these names are only used here.
  ******************************************************)
 
 
 Clear[farkasFromList]
 
 farkasFromList[mat:List[___List],
 function:List[___],
 functionCoefs:List[___],
 options:___Rule]:=
 Module[{},
       Print["Warning, Names are not given for farkas coefs, clash may occur  with previous names "];
       farkasFromList[mat,function,functionCoefs,"",options]
 
]
 
 farkasFromList[mat:List[___List],
 function:List[___],
 functionCoefs:List[___],
 names:_String,
 options:___Rule]:=
 Module[{matIneq,lambdaVect,posConstraints,farkasConstraints,
 allConstraints,allVars},
       
       If [Length[function]=!=Length[mat[[1]]]-1,
		 Message[farkasFromList::argumentsIncompatible,
			mat[[1]],function];Throw[$Failed]];
       
       (* first we decompose the equalities in inequalities *)
       matIneq = Flatten[Map[If[#[[1]] == 1, {Take[#, {2, -1}] },
	 {Take[#, {2, -1}] , - Take[#, {2, -1}]}] &,mat], 1];
       
	  (* we build the vector of farkas coefficients *)
	  lambdaVect = Map [scdc["lambda"<>names<>ToString[#]] &, 
				Table[i, {i, 1, Length[matIneq]}]];

	  (* we build the list of positivity constraints 
	   for the farkas coefficient *)
	  posConstraints = 
	   Prepend[Map[# >= 0 &, lambdaVect],scdc["lambda"<>"0"]>=0];

	  (* we build th farkas constraints recall:
	   f(x)+f0 is positive on D: Ax+b >= 0 iff 
	   exists lam_0,...lam_p such that
	   (f f0)=(lam_1,...,lam_p).(A b)+(0 lam_0)
	   this equation has to be decomposed line by line 
	   (as many lines as constraints in D) *)
	   
          farkasConstraints =   
	  MapThread[#1 + #3- #2 == 0 &, 
	    {lambdaVect.matIneq, 
	     function,
	     Append[Table[0,{i,1,Length[matIneq[[1]]]-1}],scdc["lambda"<>"0"]]}];
	  
        allConstraints = Union[posConstraints,farkasConstraints ];
        allVars = Union[functionCoefs,  Prepend[lambdaVect,scdc["lambda"<>"0"]]];
        {allConstraints,allVars}
         ]

 farkasFromList::wrongArg="wrong Argument for function farkasFromList : `1` "

  farkasFromList[a:___]:=Message[farkasFromList::wrongArg,Map[Head,{a}]]

 (******************************************************
  farkasFromDomain: same as farkas from list but with a 
domain instead of a matrix for the constraints of the domain
******************************************************)
 

 Clear[farkasFromDomain]

 farkasFromDomain[dom:domain[___],
             function:List[___],
             functionCoefs:List[___],
             options___Rule]:=
 Module[{},
       Print["Warning, Names are not given for farkas coefs, clash may occur  with previous names "];
       farkasFromDomain[dom,function,functionCoefs,""]
       
 ]
 
 farkasFromDomain[dom:domain[___],
 function:List[___],
 functionCoefs:List[___],
 names:_String,
 options___Rule]:=
    Module[{domMat},
          domMat=dom[[3,1,5]];
          farkasFromList[domMat,function,functionCoefs,names,options]
         ]

 farkasFromDomain::wrongArg="wrong Argument for function farkasFromDomain
  : `1` "


  farkasFromDomain[a:___]:=Message[farkasFromDomain::wrongArg,Map[Head,{a
  }]]



(*******************************************************************
*******************************************************************
Simplifying LP after applying farkas 
*******************************************************************
 *******************************************************************)
 



 (**********************************************************
  eliminateFarkasEqualities[constraints, vars] eliminates some 
of the farkas coefficient by using the equalities resulting 
of the Farkas theorem application. the result is a new system 
of inequalties (where no equalities involving Farkas coefs should occurs)
  and a new system of var (where some fakas coef have disappeared).
the farkas coefs are recognized because they are of the forme 
scdc["farkas*"]. the equality are taken in the 
order they appear in the system and   farkas coefs are chosen in the 
order they apprear in the list of vars. 
  *******************************************************)

 Clear[eliminateFarkasEqualities]

 Options[eliminateFarkasEqualities]={debug->False}
eliminateFarkasEqualities::notEliminated="could not eliminate `1` in `2`" 
eliminateFarkasEqualities::emptySystem="The system is not feasible: here is it: `1` after the elimination of `2`"

 eliminateFarkasEqualities[ineqSystem:_List,vars:_List,options___Rule]:=
    Module[{dbg,eqSystem,curIneqSystem,curVars,farkasCoefs,eqSystemWithLambdas,
            cpt,curEq,curLambda,curEqSystem},
	  dbg=debug/.{options}/.Options[eliminateFarkasEqualities];
	  If[dbg,Print["entering eliminateFarkasEqualities"]];
	  curIneqSystem=ineqSystem;
	  curVars=vars;
	  eqSystem=Select[curIneqSystem,MatchQ[#,a:_Equal] &];
	  (* farkas Coefs in equalities , liste of scdc[" "] *)
	  farkasCoefs= Union[Cases[eqSystem, 
			    a : _scdc?(StringMatchQ[#[[1]], "lambda*"] &) -> a,
				  Infinity]];
	  If[dbg,Print["farkasCoef: ",farkasCoefs]];
	  (* equalities in the system involving farkas coefficients *)
	  eqSystemWithLambdas = 
	  Select[eqSystem, 
		Function[x1, {} =!= 
			Intersection[farkasCoefs, 
				    Cases[x1, a : _scdc?(StringMatchQ[#[[1]],
				    "lambda*"] &) -> a, 
					 Infinity]]]];
	  If[dbg,Print["eqSystemWithLambdas: ",eqSystemWithLambdas]];
	  cpt=1;
	  While[ eqSystemWithLambdas=!={}&&cpt<100 ,
	        If[dbg,cpt=cpt+1];
	        curEq=First[eqSystemWithLambdas];
		curLambda=
		First[ Union[Cases[curEq, 
				  a : _scdc?(StringMatchQ[#[[1]],
				   "lambda*"] &) -> a,
				  Infinity]]];
		valLambda= Solve[curEq,{curLambda}];
		If[dbg,Print["valLambda: ",valLambda]];
		If [!MatchQ[valLambda,List[List[Rule[_,_]]]],
			   Message[eliminateFarkasEqualities::notEliminated,
				  curEq,curLambda],
			   (* else : report the equality in all 
			    other equations *) 
			   curIneqSystem=curIneqSystem/.(valLambda[[1,1]]);
			   (* If False appear, the system is not feasible *)
			   If [Position[curIneqSystem,False]=!={},
				       Message[eliminateFarkasEqualities::emptySystem,
					      curIneqSystem,curLambda];
				       Return[{}]];
			   (* If True appear, just forget it  *)
			   curIneqSystem=Select[curIneqSystem,#=!=True &];
			   curVars=Select[curVars,#=!=curLambda &];
			   If[dbg,Print["newIneqSystem: ",curIneqSystem]];
			   (* test stopping condition *)
			   curEqSystem=Select[curIneqSystem,MatchQ[#,a:_Equal] &];
			   (* equalities in the system involving 
			    farkas coefficients *)
			   eqSystemWithLambdas = 
			   Select[curEqSystem, 
				 Function[x1, {} =!= 
					 Intersection[farkasCoefs, 
						     Cases[x1, a : _scdc?(StringMatchQ[#[[1]],
						     "lambda*"] &) -> a, 
							  Infinity]]]];
			   ]
	  ] ;
    {curIneqSystem,curVars}
    ]

 eliminateFarkasEqualities::wrongArg="wrong Argument for function eliminateFarkasEqualities
  : `1` "


  eliminateFarkasEqualities[a:___]:=Message[eliminateFarkasEqualities::wrongArg,Map[Head,{a
  }]]






(*********************************************************
projectInequalitySystem[constraint, vars, subListVar] eliminates some 
of the variable of a linear constraint system by projecting the polyhedron 
 on a sub list of variable (i.e. using Cherhnikova). Warning, this functin 
 will fail for big inequality systems because  of chernikova (static allocating of memory) 
 ***********************************************)
projectInequalitySystem::wrongVars="Some projected variables names are wrong "

Clear[projectInequalitySystem]

projectInequalitySystem[allConstraints:_List,
allVars:_List,
varSubList:_List,
options___Rule]:=
Module[{optDebug,rules,constraintMat,domTemp,domTemp2,domTemp3},
      optDebug = debug/.{options}/.Options[modularSchedule];
      (* rename the variable "i_position" for readability *)
      If[Union[allVars,varSubList]=!=allVars,
	Message[projectInequalitySystem::wrongVars];Return[$Failed]];
      rules = MapIndexed[#1 -> "i" <> ToString[First[#2]] &, allVars];
      constraintMat = Map[constraintToList[#, allVars] &, allConstraints];
      (* If [optDebug,Print["constraintMat: ",constraintMat]]; *)
      domTemp = domain[Length[allVars],
		      Map[ToString, allVars /. rules],
	{pol[Length[constraintMat], 0, 0, 0,
	    constraintMat, {}]}];
      (* If[optDebug,Print["domTemp: ",ashow[domTemp,silent->True]]]; *)
      domTemp2 = domCompRays[domTemp];
      domTemp3 = DomProject[domTemp2, varSubList /. rules];
      (* If[optDebug,Print["dom after projection",ashow[domTemp3,silent->True]]]; *)
      Select[Map[listToConstraint[#,varSubList] &,domTemp3[[3,1,5]]]
	    ,#=!=True &]
]

projectInequalitySystem::wrongArg="wrong Argument for function projectInequalitySystem :
  `1` "

projectInequalitySystem[a:___]:=Message[projectInequalitySystem::wrongArg,Map[Head,{a}]]





(*******************************************************************
*******************************************************************
Higher level use of farkas: applying farkas and siumplifying 
*******************************************************************
 *******************************************************************)




(*****************************************************
farkasProjectedFromList[] first perform the "feautrier" gaussian 
simplification with the equalities given by the farkas process 
then supress the remaining farkas coefs with chernikova 
 *****************************************************)



 Clear[farkasProjectedFromList]


 farkasProjectedFromList[mat:List[___List],
             function:List[___],
             options___Rule]:=
Module[{},
      Print["Warning, Names are not given for farkas coefs, clash may occur  with previous names "];
      farkasProjectedFromList[mat,function,"",options]
    ]

 farkasProjectedFromList[mat:List[___List],
 function:List[___],
 names:_String,
 options___Rule]:=
Module[{farkasCoefs,functionCoefs},
      farkasCoefs=Select[functionCoefs,MatchQ[#,scdc[___]] &];
      farkasCoefs=Select[functionCoefs,StringMatchQ[#[[1]],"lambda*"] &];
      functionCoefs= Complement[function,farkasCoefs];
      farkasProjectedFromList[mat,function,functionCoefs,names,options]]

farkasProjectedFromList[mat:List[___List],
 function:List[___],
 functionCoefs:List[___],
 options___Rule]:=
Module[{},
      Print["Warning, Names are not given for farkas coefs, clash may occur  with previous names "];
      farkasProjectedFromList[mat,function,functionCoefs,"",options]
]

 farkasProjectedFromList[mat:List[___List],
 function:List[___],
 functionCoefs:List[___],
 names:_String,
 options___Rule]:=
    Module[{l1,allConstraints,allVars, newSystem,newConstraints},
          l1=farkasFromList[mat,function,functionCoefs,names];
          allConstraints=l1[[1]];
          allVars=l1[[2]];
          newSystem=eliminateFarkasEqualities[allConstraints,
						  allVars,
						  options];

	  newConstraints=projectInequalitySystem[newSystem[[1]],
						newSystem[[2]],
						functionCoefs,
						options];
      {newConstraints,functionCoefs}
         ]

 farkasProjectedFromList::wrongArg="wrong Argument for function farkasProjectedFromList :
  `1` "

  farkasProjectedFromList[a:___]:=Message[farkasProjectedFromList::wrongArg,Map[Head,{a}]]


     



 Clear[farkasProjectedFromDomain]

 farkasProjectedFromDomain[dom:domain[___],
             function:List[___],
             options___Rule]:=
    Module[{domMat},
          domMat=dom[[3,1,5]];
          farkasProjectedFromList[domMat,function,options]
         ]

 farkasProjectedFromDomain[dom:domain[___],
 function:List[___],
 names:_String,
 options___Rule]:=
Module[{domMat},
      domMat=dom[[3,1,5]];
      farkasProjectedFromList[domMat,function,names,options]
]


 farkasProjectedFromDomain[dom:domain[___],
             function:List[___],
             functionCoefs:List[___],
             options___Rule]:=
    Module[{domMat},
          domMat=dom[[3,1,5]];
          farkasProjectedFromList[domMat,function,functionCoefs,options]
         ]


 farkasProjectedFromDomain[dom:domain[___],
 function:List[___],
 functionCoefs:List[___],
 names:_String,
 options___Rule]:=
    Module[{domMat},
          domMat=dom[[3,1,5]];
          farkasProjectedFromList[domMat,function,functionCoefs,names,options]
         ]

 farkasProjectedFromDomain::wrongArg="wrong Argument for function farkasProjectedFromDomain
  : `1` "


  farkasProjectedFromDomain[a:___]:=Message[farkasProjectedFromDomain::wrongArg,Map[Head,{a
  }]]







(******************************************************
 timeFunctionOfVar[var1:_String] returns the 
vector of the symbolic coefficient of the time function of var1
 in $result, e.g. {scdc["TVar1D1"],scdc["TVar1D2"],scdc["CVar1"]}

******************************************************)

 Clear[timeFunctionOfVar]
 
 timeFunctionOfVar[var1:_String]:=
 timeFunctionOfVar[$result,var1]
 
 
 timeFunctionOfVar[sys1:_system,var1:_String,options:___Rule]:=
 Module[{optScheduleType,decl1,indices,localVars},
	 optScheduleType=scheduleType/.{options}/.Options[multiSched];
       decl1=getDeclaration[sys1,var1];
       indices=decl1[[3,2]];
       localVars=getLocalVars[sys1];
       Switch[optScheduleType,
	     affineByVar, res=Join[Map[scdc["T"<>var1<>"D"<>ToString[#]] &, 
				      Table[i, {i, 1, Length[indices]}]], {scdc["C"<>var1]}],
	     sameLinearPart, 	 If[MemberQ[localVars,var1],
				   res=Join[Map[scdc["T"<>"D"<>ToString[#]] &, 
					       Table[i, {i, 1, Length[indices]}]], {scdc["C"<>var1]}],
				   res=Join[Map[scdc["T"<>var1<>"D"<>ToString[#]] &, 
					       Table[i, {i, 1, Length[indices]}]], {scdc["C"<>var1]}]],
	     sameLinearPartExceptParam,
	     If[MemberQ[localVars,var1],
	       res=Join[Map[scdc["T"<>"D"<>ToString[#]] &, 
			   Table[i, {i, 1, Length[indices]-Length[sys1[[2,2]]]}]], 
		       Map[scdc["T"<>var1<>"D"<>ToString[#]] &, 
			   Table[i, {i, Length[indices]-Length[sys1[[2,2]]]+1, Length[indices]}]], {scdc["C"<>var1]}],
	       res=Join[Map[scdc["T"<>var1<>"D"<>ToString[#]] &, 
			   Table[i, {i, 1, Length[indices]}]], {scdc["C"<>var1]}]],
	     _,	       res=Join[Map[scdc["T"<>var1<>"D"<>ToString[#]] &, 
			   Table[i, {i, 1, Length[indices]}]], {scdc["C"<>var1]}]
       ];
       res
 ]
 
 timeFunctionOfVar::wrongArg="wrong Argument for function timeFunctionOfVar : `1` "
 
 timeFunctionOfVar[a:___]:=(Message[timeFunctionOfVar::wrongArg,Map[Head,{a}]];{})
 


 Clear[depFunctionCoefFromDep]

 depFunctionCoefFromDep[dependence:depend[___],
             options:___Rule]:=
       depFunctionCoefFromDep[$result,dependence,options]

 depFunctionCoefFromDep[sys1:_system,dependence:depend[___],
             options:___Rule]:=
       depFunctionCoefFromDep[sys1,dependence,1,options]


 depFunctionCoefFromDep[sys1:_system,
 dependence:depend[___],
 duration1:_Integer,
 options___Rule]:=
Module[{optDebug,depDom,lhsIndices,lhsVar,rhsVar,hsTimeFunction, rhsTimeFunction,
depMat, depFunction, durationTable,depSlack}, 
      optDebug = debug/.{options}/.Options[modularSchedule];
      depDom=dependence[[1]];
      lhsIndices=depDom[[2]];
      lhsVar=dependence[[2]];
      rhsVar=dependence[[3]];
      lhsTimeFunction =    timeFunctionOfVar[sys1,lhsVar,options];
      rhsTimeFunction =   timeFunctionOfVar[sys1,rhsVar,options];
      depMat=dependence[[4]];
      (* If[optDebug,Print["depMat",depMat]]; *)
      depFunction=  rhsTimeFunction.depMat[[4]];
      If[optDebug,Print["depFunction", depFunction]];
      If[Length[depFunction]=!=Length[lhsIndices]+1,
              Message[depFunctionCoefFromDep::incompatibleDimension,depFunction,lhsIndices]];         
      durationTable=Append[Table[0,{i,1,Length[dependence[[1,2]]]}],duration1];
        depSlack=lhsTimeFunction-depFunction-durationTable          
        ]

 depFunctionCoefFromDep::wrongArg="wrong Argument for function depFunctionCoefFromDep : `1` "

  depFunctionCoefFromDep[a:___]:=Message[depFunctionCoefFromDep::wrongArg,Map[Head,{a}]]
		 



 Clear[farkasFromDep]

 
farkasFromDep[dependence:depend[___],
             options:___Rule]:=
      farkasFromDep[dependence,1,options]

farkasFromDep[dependence:depend[___],
identifier:_String,
options:___Rule]:=
      farkasFromDep[dependence,1,identifier,options]



(* temporarily commented out 
farkasFromDep[dependence:depend[___],
             duration1:_Integer,
             options:___Rule]:=
      farkasFromDep[dependence,
                    Append[Table[0,{i,1,Length[dependence[[1,2]]]}],duration1],
		   options] *)

farkasFromDep[dependence:depend[___],
duration1:_Integer,
options___Rule]:=
Module[{},
      Print["Warning, Names are not given for farkas coefs, clash may occur  with previous names "];
      farkasFromDep[dependence,duration1,"",options]
]

farkasFromDep[dependence:depend[___],
duration1:_Integer,
identifier:_String,
options___Rule]:=
farkasFromDep[$result,dependence,duration1,identifier,options]

farkasFromDep[sys1:_system,
             dependence:depend[___],
duration1:_Integer,
identifier:_String,
options___Rule]:=
    Module[{},
           depSlack=depFunctionCoefFromDep[sys1,dependence,duration1,options];
           lhsVar=dependence[[2]];
           rhsVar=dependence[[3]];
           lhsTimeFunction =    timeFunctionOfVar[sys1,lhsVar,options];
           rhsTimeFunction =   timeFunctionOfVar[sys1,rhsVar,options];
           allVars=Union[ lhsTimeFunction,     rhsTimeFunction];
           farkasFromDomain[dependence[[1]],depSlack,allVars,identifier,options]          
]

 farkasFromDep::wrongArg="wrong Argument for function farkasFromDep : `1` "

  farkasFromDep[a:___]:=Message[farkasFromDep::wrongArg,Map[Head,{a}]]


 farkasProjectedFromDep::usage="debug"

 Clear[farkasProjectedFromDep]
farkasProjectedFromDep[dependence:depend[___],
options:___Rule]:=
farkasProjectedFromDep[$result,dependence,options]

farkasProjectedFromDep[sys1:_system,
dependence:depend[___],
options:___Rule]:=
farkasProjectedFromDep[sys1,dependence,1,options]

farkasProjectedFromDep[sys1:_system,dependence:depend[___],
options:___Rule]:=
farkasProjectedFromDep[sys1,dependence,1,options]

farkasProjectedFromDep[sys1:_system,dependence:depend[___], identifier:_String,
options:___Rule]:=
farkasProjectedFromDep[sys1,dependence,1,identifier,options]


 farkasProjectedFromDep[sys1:_system,
 dependence:depend[___],
 duration1:_Integer,
 options___Rule]:=
Module[{},
      Print["Warning, Names are not given for farkas coefs, clash may occur  with previous names "];
      farkasProjectedFromDep[sys1,dependence,duration1,"",options]
      ]

farkasProjectedFromDep[sys1:_system,
dependence:depend[___],
duration1:_Integer,
identifier:_String,
options___Rule]:=
Module[{},
      l1=farkasFromDep[sys1,dependence,duration1,identifier,options];
      allConstraints=l1[[1]];
      allVars=l1[[2]];
      lhsVar=dependence[[2]];
      rhsVar=dependence[[3]];
      lhsTimeFunction =    timeFunctionOfVar[sys1,lhsVar,options];
      rhsTimeFunction =   timeFunctionOfVar[sys1,rhsVar,options];
      projectedVars=Union[ lhsTimeFunction,     rhsTimeFunction];
      
      newConstraints=
      projectInequalitySystem[allConstraints,allVars,
			     projectedVars,options];
{newConstraints,projectedVars}
]

farkasProjectedFromDep::wrongArg="wrong Argument for function farkasProjectedFromDep : `1`
  "

  farkasProjectedFromDep[a:___]:=Message[farkasProjectedFromDep::wrongArg,Map[Head,{a}]]



 Clear[farkasFromPosConstr]

 farkasFromPosConstr[var1:_String , options:___Rule]:=
         farkasFromPosConstr[$result,var1, options]

 farkasFromPosConstr[sys1:_system,var1:_String , options:___Rule]:=
    Module[{},
	  declDom=addParameterDomain[getDeclarationDomain[sys1,var1],
				     sys1[[2]]];
	 farkasFromPosConstr[sys1,declDom,var1, options ]
	 ]


 farkasFromPosConstr[sys1:_system,declDom:_domain,var1:_String, options:___Rule]:=
    Module[{},
	  timeFunction=timeFunctionOfVar[sys1,var1, options];
	  res=farkasFromDomain[declDom,timeFunction,timeFunction,var1, options]
         ]

 farkasFromPosConstr::wrongArg="wrong Argument for function farkasFromPosConstr : `1` "

  farkasFromPosConstr[a:___]:=Message[farkasFromPosConstr::wrongArg,Map[Head,{a}]]



 Clear[farkasProjectedFromPosConstr]

 farkasProjectedFromPosConstr[var1:_String, options:___Rule]:=
         farkasProjectedFromPosConstr[$result,var1, options]

 farkasProjectedFromPosConstr[sys1:_system,var1:_String, options:___Rule]:=
	 Module[{},
	       declDom=addParameterDomain[getDeclarationDomain[sys1,var1],
					 sys1[[2]]];
	       farkasProjectedFromPosConstr[sys1,declDom,var1, options]
	 ]

 farkasProjectedFromPosConstr[sys1:_system,declDom:_domain,var1:_String, options:___Rule]:=
    Module[{},
	  f1=farkasFromPosConstr[sys1,declDom,var1, options];
	  newVars=timeFunctionOfVar[sys1,var1, options];
	  ineq= projectInequalitySystem[f1[[1]],f1[[2]],newVars, options];
    {ineq,newVars}
    ]

 farkasProjectedFromPosConstr::wrongArg="wrong Argument for function
  farkasProjectedFromPosConstr : `1` "


  farkasProjectedFromPosConstr[a:___]:=Message[farkasProjectedFromPosConstr::wrongArg,Map[Head,{a}]]


schedFromRule::usage="debug"

Clear[schedFromRule]

Options[schedFromRule]={debug->False}

schedFromRule[sys_system,ruleList_List,options___Rule]:=
Module[{},
       varList=Join[getInputVars[sys],getOutputVars[sys],getLocalVars[sys]];
       schedFinal={};
       Do[curDecl=getDeclaration[sys,varList[[i]]];
	 timF=timeFunctionOfVar[sys,curDecl[[1]],options];
	 curSched=sched[Drop[timF,-1],Last[timF]];
	 curVarSched={curDecl[[1]],curDecl[[3,2]],curSched/.ruleList};
	 schedFinal=Append[schedFinal,curVarSched];
	 ,{i,1,Length[varList]}];
       scheduleResult[sys[[1]],schedFinal,{1}]
      ]

schedFromRule::wrongArg="wrong Argument for function schedFromRule : `1` "

schedFromRule[a:___]:=(Message[schedFromRule::wrongArg,Map[Head,{a}]];Print[{a}[[2]]])






Clear[reOrderVarsForPip]

Options[reOrderVarsForPip]={debug->False}

reOrderVarsForPip[varList:_List,options___Rule]:=
Module[{},
  objFunction={First[varList]};
reOrderVarsForPip[objFunction,varList,options]
  ]

reOrderVarsForPip[objFunction:_List,varList:_List,options___Rule]:=
Module[{ dbg,tempList,tempRes,constList, curVar,varName,tauCoefListFull,tauCoefList},
  tempList=Complement[varList,objFunction];
      dbg=debug/.{options}/.Options[els];
tempRes=objFunction;
constList={};
While[tempList=!={},
  curVar=First[tempList];
If[MatchQ[curVar,_Symbol[_String]],
  (* I can only reorder variables with respect to their names *)
  If[StringMatchQ[curVar[[1]],"C*"],
    (* constant part *)
     constList=Append[constList,curVar];
     tempList=Complement[tempList,{curVar}],
       (* tau coef *) 
     If[StringMatchQ[curVar[[1]],"T*D*"],
       posD=StringPosition[curVar[[1]],"D"];
     varName=StringTake[curVar[[1]],{2,posD[[-1,1]]-1}];
     tauCoefListFull=Select[tempList,MatchQ[#,scdc[_]] &];
     tauCoefList=Select[tauCoefListFull,StringMatchQ[#[[1]],"T"<>varName<>"D*"] &];
     (* parameterFirst *) 
     tauCoefList=Reverse[Sort[tauCoefList]];
     If[length[tauCoefList]===0,
							(* problem *) 
     Break[]];
     tempRes=Join[tempRes,tauCoefList];
     tempList=Complement[tempList, tauCoefList],
							(* else not a standard tau coef notation *)
     tempRes=Append[tempRes,curVar];
     tempList=Complement[tempList,{curVar}]]],
							(* not a scdc var *)
     tempRes=Append[tempRes,curVar];
     tempList=Complement[tempList,{curVar}]]
];
tempRes=Join[tempRes,constList];
If[dbg,Print["reordering variables:",tempRes]];
If[Sort[tempRes]=!=Sort[varList],
							(* something went wrong *)
     Print["Something Wrong in reOrderVarsForPip"];Print[tempRes];varList,
							(*else OK *) 
     tempRes]
]


reOrderVarsForPip::wrongArg="wrong Argument for function reOrderVarsForPip : `1` "

reOrderVarsForPip[a:___]:=Message[reOrderVarsForPip::wrongArg,Map[Head,{a}]]


checkOptionsModularSchedule::wrongOptionsValue= "Unknown options value for modularSchedule: `1`"
checkOptionsModularSchedule::sameLinPartImpossible = "Using the samelinearPart
  options, all the local variables of the system must have the same
  number of indices"
checkOptionsModularSchedule::NotImplInFarkas= "Sorry, value `1` of option is not
  implemented in Faraks method, try schedMethod->vertex"
checkOptionsModularSchedule::wrongLength=" Wrong length for the list of duration : `1` should be `2` long"

Clear[checkOptionsModularSchedule]

checkOptionsModularSchedule[options___Rule]:=
  checkOptions[$result,options]

checkOptionsModularSchedule[sys_Alpha`system,
	    options___Rule]:=
  Module[{optDebug,optVerbose,optResolutionSoft,
	  optRatOrInt,optAddConstraints,
	  optDurations,optCheckSched,optScheduleType,optObjFunction,
	  optOnlyVar,optGivenSchedVect,
	  optOnlyDep,optOutputForm,optionList,
	  optDurationByEq,optSchedMethod,
	  optMultiSchedDepth,optMultiDimensional,
          listNumIndices,newOptions,numberOfDim,  finalDurations, curDurations,depList,
 curDep,curGoalDep,posGoalInVarList,  curValue, durationList, depNumber},
	 optDebug = debug/.{options}/.Options[modularSchedule];
	 optVerbose= verbose/.{options}/.Options[modularSchedule];
	 optResolutionSoft= resolutionSoft/.{options}/.Options[modularSchedule];
	 optRatOrInt = integerSolution/.{options}/.Options[modularSchedule];
	 optAddConstraints = addConstraints/.{options}/.Options[modularSchedule];
	 optScheduleType=scheduleType/.{options}/.Options[modularSchedule];
	 optOptimizationType=optimizationType/.{options}/.Options[modularSchedule];
	 optOnlyVar=onlyVar/.{options}/.Options[modularSchedule];
	 optOnlyDep=onlyDep/.{options}/.Options[modularSchedule];
	 optOutputForm=outputForm/.{options}/.Options[modularSchedule];
	 optDurations=durations/.{options}/.Options[modularSchedule];
	 optDurationByEq=durationByEq/.{options}/.Options[modularSchedule];
	 optSchedMethod=schedMethod/.{options}/.Options[modularSchedule];
	 optMultiSchedDepth=multiSchedDepth/.{options}/.Options[modularSchedule];
	 optObjFunction=objFunction/.{options}/.Options[modularSchedule];
	 optMultiDimensional=multiDimensional/.{options}/.Options[modularSchedule];
	 
        newOptions={options};
	    If [optVerbose,Print["Checking options..."];];
          (* No Checks actaully... just for confidence *)

          (*** Options schedMethod  ****)
             If [!MemberQ[{vertex,farkas,farkas2},optSchedMethod],
                 Message[checkOptions::wrongOptionsValue,optSchedMethod];
                 Throw[$Failed]];

           (*** Options scheduleType  ****)
             If [!MemberQ[{affineByVar,sameLinearPart, 
                           sameLinearPartExceptParam},optScheduleType],
                 Message[checkOptions::wrongOptionsValue,optScheduleType];
                 Throw[$Failed]];
            If [MemberQ[{sameLinearPart,sameLinearPartExceptParam},
                         optScheduleType],
                listNumIndices=Union[Map[Length[getPart[#,{3,2}]]&,sys[[5]]]];
                If [Length[listNumIndices]>1, 
                   Message[checkOptions::sameLinPartImpossible];
                   Throw[$Failed]]];

           (*** Options optMultiDimensional  ****)
             If [!MemberQ[{True,False},optMultiDimensional],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optMultiDimensional];
                 Throw[$Failed]];
             If [optMultiDimensional,
                 If [MatchQ[optAddConstraints,List[__String]],
                     If[optVerbose, Print["Warning, the addConstraints
  option contain only one list, I will use this list at all  dimension of schedule"]]];
                 If [MatchQ[optDurations,List[__Integer]],
                     If[optDebug, Print["Warning, the durations
  option contain only one list, I will use this list only
  at the first dimension of schedule"]]];
             If [optDebug,
                 Print["Because of multidimensional scheduling,
changing value of options optimizationType to multi,
outputForm to scheduleResult, objFuction to lexicographic,
onlyDep to internal all"]];
             newOptions=Join[{optimizationType->multi,
                              outputForm->scheduleResult,
                              objFuction ->lexicographic,
                              onlyDep->all},newOptions];
            ]; (* end of If optMultiDimensionnal *)
 

	     (*** Options optOptimizationType  ****)
             If [!MemberQ[{time,Null,delay,multi},optOptimizationType],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optOptimizationType];
                 Throw[$Failed]]; 

	     (*** Options optAddConstraints  ****)
             If [!MatchQ[optAddConstraints,List[___String]|List[___List]],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optAddConstraints];
                 Throw[$Failed]]; 

             (*** Options optDurations ****)
             If [!MatchQ[optDurations,List[___Integer]|List[___List]],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optDurations];
                 Throw[$Failed]]; 

             If [MatchQ[optDurations,List[___]],
		       If[MatchQ[optDurations,List[___List]],
			 numberOfDim=Length[optDurations],
			 numberOfDim=1];
		       finalDurations={};
		       Do[
			  curDurations=If[MatchQ[optDurations,List[___List]],
					 optDurations[[i]],
					 optDurations];
			  If[optDurationByEq,
			    If[Length[curDurations]=!=Length[Join[getInputVars[sys],getLocalVars[sys],getOutputVars[sys]]],
			      Message[checkOptionsModularSchedule::wrongLength,curDurations,
				     Length[Join[getInputVars[sys],getOutputVars[sys],getLocalVars[sys]]]];Throw[$Failed]];
			    durationList={};
			    depList=First[dep[sys]];
			    Do[curDep=depList[[j]];
			      curGoalDep=curDep[[2]];
			      posGoalInVarList=Position[Join[getInputVars[sys],getOutputVars[sys],getLocalVars[sys]],curGoalDep];
			      curValue=getPart[curDurations,First[posGoalInVarList]];
			      durationList=Append[durationList,curValue],
			      {j,1,Length[depList]}],
			      (*  else, not duration by eq, i.e. duration by dep *)
			  (* else, duration by dep *) 
			  depNumber=Length[dep[sys][[1]]];
			  If [Length[curDuration]=!=Lenght[Join[getInputVars[sys],getLocalVars[sys],getOutputVars[sys]]],
				    Message[checkOptionsModularSchedule::wrongOptionsValue,optDurations];		       
				    Throw[$Failed],
			    durationList=curDurations]];
			  finalDurations=If[MatchQ[optDurations,List[___List]],
					   Append[finalDuration,durationList],
					   durationList];
			  ,
		       {i,1,numberOfDim}]
	     ];

	     If[optDurations==={},
	       depList=First[dep[sys]];
	       finalDurations=Table[1,{i,1,Length[depList]}]];
	       
             newOptions=Join[{durations->finalDurations,durationByEq->False},newOptions];

	     

             (*** Options optOutputForm ****)
             If [!MemberQ[{scheduleResult,lpSolve,lpMMA,domain},optOutputForm],
			 Message[checkOptionsModularSchedule::wrongOptionsValue,optOutputForm];
			 Throw[$Failed],
			 If[MemberQ[{lpSolve,lpMMA,domain}, optOutputForm],
			   Message[checkOptionsModularSchedule::NotImplInFarkas,optOutputForm];Throw[$Failed]]]; 

             (*** Options optResolutionSoft ****)
             If [!MemberQ[{pip,mma,lpSolve},optResolutionSoft],
			 Message[checkOptionsModularSchedule::wrongOptionsValue,optOutputForm];
			 Throw[$Failed],
			 If[MemberQ[{mma,lpSolve}, optResolutionSoft],
			   Message[checkOptionsModularSchedule::NotImplInFarkas,optResolutionSoft];Throw[$Failed]]]; 


             (*** Options optObjFunction ****)
                (*  No Check Here *)
             If [!MatchQ[optObjFunction,_],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optObjFunction];
                 Throw[$Failed]]; 

            (**** Options optOnlyVar ****) 
            If [!MatchQ[optOnlyVar,List[___String]|List[___List]|all],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optOnlyVar];
                 Throw[$Failed]]; 

            (**** Options optOnlyDep ****) 
            If [!MatchQ[optOnlyDep,List[___Integer]|List[___List]|all],
                 Message[checkOptionsModularSchedule::wrongOptionsValue,optOnlyDep];
                 Throw[$Failed]]; 

            (* special test for Farkas method *)
            If [optSchedMethod===farkas  || optSchedMethod===farkas2,
                If [!MatchQ[optObjFunction,lexicographic],
                     Message[checkOptionsModularSchedule::NotImplInFarkas,optObjFunction];
                     Throw[$Failed]];
                If [optSubSystems,
                     Message[checkOptionsModularSchedule::NotImplInFarkas,SubSystems];
                     Throw[$Failed]]];
	    Print["...OK"];

newOptions
	    ]

checkOptionsModularSchedule[a___]:=(Message[checkOptions::WrongArg,a];
				Throw["ERROR"])





Clear[els]

Options[els]=Options[modularSchedule]

els[options___Rule]:=els[$result,options]

els[sys:_system,options___Rule]:=
Module[{dbg,deps,depList,newOptions, depCons,posCons,varLP,objFunctionCons,optDurations,optDurationByEq,durationList},
      dbg=debug/.{options}/.Options[els];
      optDurations=durations/.{options}/.Options[modularSchedule];
      optDurationByEq=durationByEq/.{options}/.Options[modularSchedule];
      Print["dependence analysis ... "];
      deps=dep[sys];
      depList=First[deps];
      depCons={};
      posCons={};
      varLP={};
      newOptions=checkOptionsModularSchedule[sys,options];
      Print["Building LP ... "];
      (* duration can be modified by checkOptionsModularSchedule *)
      durationList=durations/.newOptions;
      I[dbg, Print["duration by dep : ",  durationList]];
      Do[tempRes=farkasProjectedFromDep[sys,depList[[i]],durationList[[i]],"dep"<>ToString[i],options];
	If[dbg,
	  show[dtable[{depList[[i]]}]];
	  Print["Duration ",durationList[[i]]];
	  Print["depend Constraint",tempRes[[1]]]];
	depCons=Join[depCons,tempRes[[1]]];
	 ,{i,1,Length[depList]}];
      varList=Join[getInputVars[sys],getOutputVars[sys],getLocalVars[sys]];
      Do[tempRes=farkasProjectedFromPosConstr[sys,varList[[i]],options];
	If[dbg,
	  Print["var ",varList[[i]]];
	  Print["domain ",show[getDeclarationDomain[sys,varList[[i]]],silent->True]];
	  Print["Constraints: ",tempRes[[1]]]];
	  posCons=Join[posCons,tempRes[[1]]];
	varLP=Union[varLP,tempRes[[2]]];
	,{i,1,Length[varList]}];
      objFunctionCons=Equal[Apply[Plus,Flatten[Map[Drop[timeFunctionOfVar[sys,#],-1] &,getOutputVars[sys]]]],scdc["objFunc"]];
      If[dbg,Print["ObjFunction ",objFunctionCons]];
      allConstraints=Prepend[Union[depCons,posCons],objFunctionCons];
      varLP=Prepend[varLP,scdc["objFunc"]];
      Print[" LP:  ",Length[varLP]," variables, ",Length[allConstraints]," constraints "];
      Print[" Solving with Pip"];
      varLP=reOrderVarsForPip[varLP];
      rules= solveWithPip[allConstraints,{},varLP,{},options];
      Print[rules];
      If[MatchQ[rules,{pip[bottom]}],
	Message[els::noScheduleFound];Throw[$Failed]];
      res=schedFromRule[sys,rules[[1]],options];
      showSchedResult[res];
      $schedule=res;
      res
]

                    els::wrongArg="wrong Argument for function els : `1` "

                     els[a:___]:=Message[els::wrongArg,Map[Head,{a}]]




End[] 
EndPackage[]



