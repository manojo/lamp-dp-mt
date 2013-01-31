(* file: $MMALPHA/lib/Package/Alpha.m
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

	$Author: quinton $
	$Date: 2010/04/10 07:09:32 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Alphard.m,v $
	$Revision: 1.9 $
	$Log: Alphard.m,v $
	Revision 1.9  2010/04/10 07:09:32  quinton
	Minor edition.
	
	Revision 1.8  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.7  2008/12/29 17:29:18  quinton
	Tests were reorganized. Cut package replaced by CutMMA.
	
	Revision 1.6  2008/12/21 13:23:27  quinton
	Added a simplify option to alpha0ToAlphard. Default value is True, and if True, resulting system is simplified and normalized.
	
	Revision 1.5  2008/07/27 13:29:56  quinton
	Most recent version.
	
	Revision 1.4  2008/04/18 16:42:37  quinton
	Minor edition changes
	
	Revision 1.3  2007/04/09 17:23:57  quinton
	Just edition modifications
	
	Revision 1.2  2005/07/19 09:46:29  ebecheto
	fixed PB of control variable sorting in USE
	
	Revision 1.1  2005/03/11 16:38:29  trisset
	added vhdl and Alphard
	
	Revision 1.49  2004/07/12 12:12:09  quinton
	Deep modification to allow an exception list of equations and/or
	use statements while generating AlpHard code. The exceptions are
	put in the interface part.
	
	Revision 1.48  2004/06/09 15:31:49  quinton
	Minor corrections.
	
	Revision 1.47  2004/01/09 17:25:34  quinton
	Trying to commit my version, after removing conflicts... Not sure it will work.
	
	Revision 1.46  2003/04/15 15:03:34  risset
	commit after Axiocom week
	
	Revision 1.45  2003/01/07 17:33:12  quinton
	isSpaceDepQ was corrected.
	
	Revision 1.44  2002/10/16 12:21:56  risset
	small changes after the big post-samos debugging phase
	


*)

BeginPackage["Alpha`Alphard`", {"Alpha`Domlib`",
				"Alpha`",
				"Alpha`Options`",
				"Alpha`Matrix`",
				"Alpha`Tables`",
				"Alpha`Semantics`",
				"Alpha`Substitution`",
				"Alpha`Normalization`", 
				"Alpha`CutMMA`",
				"Alpha`SubSystems`",
				"Alpha`Visual`",
				"Alpha`Control`"}]



alpha0ToAlphard::usage = "alpha0ToAlphard[sys,controlSigList]
 translate the Alpha0  system `sys' into an Alphard library,
`controlSigList' is the list of names of the control signals. 
  alpha0ToAlphard[controlSigList] happens on
  $result and modify $result and $library"

alpha0ToAlphardModule::usage ="alpha0ToAlphardModule[sys,listRegion,controlSigList] translate the Alpha0
  Module `sys' into an Alphard library. `listRegion' is the structural
  information resulting from the function getArrayDomains[sys], 
`controlSigList' is the list of names of the control signals. "

alphardFirstStep::usage=
"alphardFirstStep[] returns an integer which is the first logical steps of the 
alphard architecture. The reset signal should be sent at this step."

alphardTimeLife::usage="alphardTimeLife[sys:_Alpha`system] returns the
time domain spanned by the hardware. This function should be called on
the module of an Alphard program after the parameter have been
assigned (your can call it before the assignement, but the result will
be more difficult to interpret), alphardTimeLife[] applies on $library (except the last program) 
and take the union"

getArrayDomains::usage=
"getArrayDomains[sys] computes all the spatial region with a 
different behaviour determined by the system sys (on each 
spatial region, cells are idential). The system sys must be
in Alpha0 form. getArrayDomains[] applies to $result.";

buildControler::usage = 
"buildControler[sys,signalList] builds the
subsystem which initializes all the control signals of `sys' indicated
  by `signalList'. The system `sys' must be
in Alpha0 form. buildControler[signalList] takes $result as default
  value for `sys'"

showSpaceDom=
"showSpaceDom[listRegion] pretty prints the result of getArrayDomains[]";

isSpaceDepQ::usage = "isSpaceDepQ[dep] checks whether the Alpha
dependance `dep' is a space dependance  (in Alpha0). `dep' is an AST"

isConnexionEqQ::usage =  "isConnexionEqQ[eq] checks whether the Alpha
equation `eq' is a connexion equation (in Alpha0). `eq' is an AST"

buildOneCell::usage =  "buildOneCell[sys,dom1,posList] return the
Alphard cell (extracted form system `sys'), occuring on the 
spatial region indicated by `dom1' and which 
computes expressions indicated by the list of poisiton `posList'
in AST `sys'. `dom' and `posList' can be obtained by the function 
getArrayDomains[sys]. buildOneCell[sys,dom1,posList,controlSignals]
do the same with the additionnal information of the list of control
signals in `controlSignals'.
"
isMirrorEqQ::usage = "isMirrorEqQ[eq] checks whether the Alpha
equation `eq' is a Mirror equation (in Alpha0). `eq' is an AST"
 
buildInterface::usage =
"buildInterface[sys] returns two Alphard systems: the interface 
and the module which correspond to system sys. The interface has 
the same inputs and outputs as sys and simply calls the module 
with scheduled input and output (Mirror variables for i/o). 
buildInterface[] applies on $result and modifies $result and
$library."
 
isModuleQ::usage = "isModuleQ[sys] checks whether the Alpha system
`sys' is a module or not"

removeSystem::usage =
"removeSystem[id_String]
 Remove the system named `id' from the library $library
 (changes $program and $result if system `id' is also $result). "


simplifyConnexions::usage = "simplifyConnexions[sys] translate
connexion syntax of connexion from Alpha0 mode to Alphard mode in
system `sys', return the modified system. simplifyConnexions[]
simplify connexion of $result"

normalizeIdDep::usage = "normalizeIdDep[sys], normalize identity
dependencies: replace in system `sys' all occurences of
Alpha`var[a___] which is not surrounded by an Alpha`affine by
Alpha`affine[Alpha`var,identity] and return the modified
system. normalizeIdDep[] apply the function to $result and assigns the
result to $result. e.g A[t,p]=B is replaced by A[t,p]=B[t,p]. Warning,
the transformation is not applied to the input arguments of Alpha`use
"

normalizeIdDepInEq::usage = "normalizeIdDep[sys,eq] normalize identity
dependencies: replace in equation `eq' of system `sys' all occurences
of Alpha`var[a___] which is not surrounded by an Alpha`affine by
Alpha`affine[Alpha`var,identity] and return the modified equation"

normalizeIdDepLib::usage = "normalizeIdDepLib[] applies
normalizeIdDep[]
to all subsystems of the library, assigns it to $library and 
return the resulting Library (change also $result)"


isolateOutputList::usage = "isolates outputs of a system in the
library, so that an output is never used inside its generating system 
(necessary for VHDL)"
isolateOutput::usage = "isolates outputs of a system in the
library, so that an output is never used inside its generating system 
(necessary for VHDL)"

structureFrom::usage =
  "structureFrom[indices_List[__String],listAllVars_List[__String]]
build a subsystem from $result which defines all the variables in
`listAllVars', and for which the indices in `indices' will be the
extension indices of the use set in $result. All variables must give
  the same domain when projecting then on the indices `indices'. 
Can also be called in the
forllowing form : structureFrom[indices], structureFrom[sys,indices],
structureFrom[sys,indices,listStructVar],
  structureFrom[sys,indices,listStructVar,newName]. Warning, not tested" 

simplify::usage = 
"simplify is an option of alpha0ToAlphard. If true, the final system is somehow
simplified by removing identity equations, normalizing and simplifying."

 setOutputVar::usage="setOutputVar[sys1_systel,var1_String] returns sys1 in which var1 in moved from local vars to output vars (added as last output var). setOutputVar[var1] operates on $result. WARNING this function changes the semantics of the program (the use calling this program are not valid anymore)"

insertFunction::usage="inserFunction[var1_String, func1_String] insert the function func1 in the definition of var var1: if the definition of var1 was var1=expr1, the new definition is var1=func1(var1). This is mainly used for the introduction of functions like truncateLSB for bit level description of the operations."

Begin["`Private`"];

getArrayDomains::NoLocalVar = "No local var to system `1`, something's
wrong, aborting computation"
getArrayDomains::WrongDim = "Wrong dimension for space dimensions: `1`
(should be {2} or {2,3} or {2,3,4})"
getArrayDomains::WrongArg = "Wrong Arguments for
  getArrayDomains: `1`"

getArrayDomainsExpr::Error1 = "Expression encountered at position `1`
  in system `2` is not in the right form, the system `2` must not be
  in correct Alpha0 format"
getArrayDomainsExpr::WrongArg = "Wrong Arguments for
  getArrayDomainsExpr: `1`"

mixSpaceDom::WrongArg =  "Wrong Arguments for
 mixSpaceDom: `1`"

simplifySpaceDom::internalWarning = "something strange appeared
  internaly when simplifying space domains, please check the result"
simplifySpaceDom::WrongArg="Wrong Arguments for
 simplifySpaceDom: `1`"

normalizeIdDepInEq::error= "Apparently a used variable was not declared"
normalizeIdDepInEq::WrongArg="Wrong Arguments for
normalizeIdDepInEq : `1`"
normalizeIdDep::WrongArg="Wrong Arguments for
normalizeIdDep : `1`"

buildControler::NoControler = "No controler to build for system `1`"
buildControler::WrongForm = 
"control signal `1` has a non permitted definition form, check that program `2` is in Alpha0 form."
buildControler::Problem1="control signal `1` has a non
  permited  definition form (no case branches),
check that program `2` is in Alpha0 form"
buildControler::Problem2="conflict between the region given to build
controler of system `2` and the actual region of control signal `1`"
buildControler::WrongArg="Wrong Arguments for
buildControler: `1`"

getSpaceDom::WrongArg="Wrong Arguments for
getSpaceDom: `1`"

isConnexionEqQ::NoLocalVar"No local var to system `1`, something's
wrong"

buildOneCell::InputNotSet= "Warning, It seems that cell `1` needs to input
signal `2` but it is not specified in the call, please check the result"
buildOneCell::WrongArg="Wrong Arguments for
buildOneCell: `1`"



isMirrorEqIntQ::WrongArg =  "Wrong Arguments for
isMirrorEqIntQ: `1`"

buildInterface::PbOccured = "Problem occured during the building of 
the interface, fatal error" 
buildInterface::InputEquations = "Warning : the number of actual inputs of the 
interface (`1`) is not equal to the number of input  (`2`) of the module"
buildInterface::OutputEquations = "Warning: the number of actual outputs of the 
interface (`1`) is not equal to the number of output  (`2`) of the module"
buildInterface::WrongArg = "Wrong Arguments for buildInterface: `1`"


removeSystem::NotFound= "System `1` not found in library "

alpha0ToAlphard::PbOccured="Problem occured during the translation,
 fatal error" 
alpha0ToAlphard::pb2 = "internal Problem, the connexion variable `1`
 is not found in the connexion structure " 
alpha0ToAlphard::pb3=  "internal Problem, the connexion variable `1`
 is not found in the connexion structure " 
alpha0ToAlphard::dimpb=  
"internal Problem, the dimension rhs of equation is not the same of
the region";
alpha0ToAlphard::intersectionpb=  
"internal Problem while calling DomIntersection"; 
removeDoubleDecl::WrongArg= " Wrong Argument for ,removeDoubleDecl:`1`. Do
nothing"

getRhsOfMirror::usage="in test"
removeDoubleDecl::usage = "in test"
removeDoubleVar::usage = "in test"

(* takes an Alpha0 program with 1 time dimension, 1 or two space
   dimension, returns a list of couples:
   {spaceDomain,positionList} where all the expressions present at position 
   have spaceDomain as space domain. spaceDomain corrsponding to area
   where processors are identical *)


Clear[showSpaceDom];
showSpaceDom[listRes_List]:=
  Module[{},
	Map[Print[ ashow[#[[1]], silent->True], 
             " on ",#[[2]]]&, listRes ]
       ];

Clear[getArrayDomains];

Options[getArrayDomains] = {debug->False,verbose->True};

getArrayDomains[opts:___Rule]:=
	 getArrayDomains[{},opts];

getArrayDomains[controlSignals_List,opts:___Rule]:=
  Module[{res},
	 res=getArrayDomains[$result,controlSignals,opts]
       ];

getArrayDomains[sys: system[___], controlSignals_List, opts:___Rule]:=
Module[{nbParam,nbIndice,nbSpace,dbg},

  dbg = debug/.{opts}/.Options[getArrayDomains];

  nbParam = sys[[2,1]];

  If[ Length[sys[[5]]]>1,
    nbIndice = sys[[5,1,3,1]],
    Message[getArrayDomains::NoLocalVar,sys[[1]]];
      Throw["ERROR"]
  ];

  If[ dbg, Print[ "Nb indices: ", nbIndice ]];
  If[ dbg, Print[ "Nb params: ", nbParam ]];

  Switch[nbIndice-nbParam, 
    2,(nbSpace={2}), 
    3,(nbSpace={2,3}),
    4,(nbSpace={2,3,4}),
    _,Message[getArrayDomains::WrongDim,nbIndice-nbParam]];
    getArrayDomains[ sys, controlSignals, {1}, nbSpace, opts]
];

getArrayDomains[ sys: system[___], controlSignals_List,
  timeDim_List, spaceDim_List, opts___Rule]:=
Catch[
      Module[{verb,res,eqs,eqsLocal,dbg,muteOpt},
    dbg = debug/.{opts}/.Options[getArrayDomains];
    verb = verbose/.{opts}/.Options[getArrayDomains];
    struct = structured/.{opts}/.Options[alpha0ToAlphard];
    muteOpt = mute/.{opts}/.Options[alpha0ToAlphard];

    If[ muteOpt, verb = False ];

    If[ verb,Print["   Please wait..."] ];

    (* Get the list of positions of equations *)
    eqs = Table[{6,i}, {i,1,Length[sys[[6]]]}];

    (* Get the positions of the use equations *)
    eqsUse = Select[ eqs, getPart[ sys, Append[#,0]]===use &];
    (* If there are use equations, then we should only define local
       variables *)
    (* If there are use equation, their extension domain must be 
       exactly that of the processor space *)
    getArrayDomain::extDomain=
     "Sorry use are allowed only if their extension domain matches the processor space : `1`";

    (* The check is done only for a non structured program *)
    If[!struct,
      (* Check all use, and abort in case of error *)
      Do[
        If[ getPart[sys,Join[eqsUse[[i]],{2,1}]] (* dimen of ext dom *)
          =!= Length[spaceDim]+sys[[2,1]] (* dim of proc space  *),
          Throw[ Message[getArrayDomain::extDomain,
          getPart[sys,Join[eqsUse[[i]],{1}]]] ]
        ],
        {i,1,Length[eqsUse]}
      ];
    ];

    (* Get the equations which satisfy one of the 
       following conditions: the lhs of the equation is
       local, and it is not a control signal *)
     
    eqsLocal = 
      Select[eqs, 
        (MemberQ[getLocalVars[sys],getPart[sys,Append[#,1]]])&&
        (!MemberQ[controlSignals,getPart[sys,Append[#,1]]]) &];
        If[ dbg, Print["Reference of local equations: ", eqsLocal] ]; 
        If[ dbg, Print["Local variables: ", getLocalVars[sys]] ];
        If[ dbg, Print["ControlSignals: ", controlSignals] ];

    (* Use must apply on local variable *)
    (* Only if not structured *)
    If[ !struct, eqsLocal = Join[ eqsLocal, eqsUse ] ];

    listPosExpr={};

(* =================== *)
(*
    Throw[ Null ];
*)

    (* For each local equation *)
    Do[ curEq = eqsLocal[[i]];
      Which[ getPart[sys,Join[curEq,{0}]]===equation,
        listPosExpr=Append[listPosExpr,Append[curEq,2]],
        getPart[sys,Join[curEq,{0}]]===use,
        Do[ listPosExpr=Append[listPosExpr,Join[curEq,{5,j}]],
          {j,1,Length[getPart[sys,Join[curEq,{5}]]]}],
      True,
      Message[getArrayDomain::pb1]],
      {i,1,Length[eqsLocal]}
    ];

    Check[
      res = mixSpaceDom[(* Here I gather all the equations *)
        MapThread[getArrayDomainsExpr,
        {Table[sys,{i,1,Length[eqsLocal]}],
         listPosExpr,
         Table[timeDim,{i,1,Length[eqsLocal]}],
         Table[spaceDim,{i,1,Length[eqsLocal]}]}]
      ],
      ToAlphard::mixSpaceDom = "error while calling mixSpaceDom";
      Throw[ Message[ToAlphard::mixSpaceDom] ]
    ];

    If[ verb||dbg, 
      Print["   ",Length[res]," region(s) found before simplification..."]];

    If[ dbg, showSpaceDom[res] ];

    (* Simplifying identical region *)
    Check[
      res = simplifySpaceDom[ res, 10, {opts} ], 
      getArrayDomain::errsimpl = "error while simplifying spatial domains";
      Throw[ Message[ getArrayDomain::errsimpl ] ]
    ];

    If[ verb,
      Print["   ",Length[res]," type(s) of cell have been identified, their domains are: "];
      Map[Print["        ",ashow[First[#],silent->True]]&,res]
    ];
	 
    If[ dbg, showSpaceDom[res] ];
    res
  ]
];

getArrayDomains[a___]:= (Message[getArrayDomains::WrongArg,a];
				      Throw["ERROR"]);


Clear[getArrayDomainsExpr];

(* the type of the result is  List[List[domain,List[positions]]] *)
getArrayDomainsExpr[sys_Alpha`system,
		    positionCur_List,
		    timeDim_List,
		    spaceDim_List]:=
  Module[{exp1,expDom,contextDom,realDom,spaceIndices,spaceDom,res,
	  caseLength,listRes,useCase},
	 (*	
	   three cases here, 
	   -there is no case +> return result
	   -there is a space case 
	   only a space case -> recursive call on the branches
	   -there is only a time space -> return result
	   determining if the case is spatial or 
	   temporal is done by its depth in $resut*)
	   
	   exp1=getPart[sys,positionCur];
	 If [MatchQ[exp1,_String],
	     (* the expression is the output of a use *)
	     useCase=1;
	     exp1=Alpha`var[exp1],
	     useCase=0];
	 (* I think that these test is the cause the 
	    the slow treaetement *)
	   If [(Cases[{exp1},Alpha`case[___],Infinity]==={})||
		 (Length[positionCur]>=5),
	       (* we can return a couple {domain,position} 
		  the domain is the intersection of the expDomain and th
		  contextDomain (i.e real domain ) *)
		   expDom=expDomain[sys,exp1]; 
	       If[useCase===1,
		  contextDom=expDom,
		  contextDom=getContextDomain[sys,positionCur]];
	     realDom=DomIntersection[expDom,contextDom]; 
	     spaceIndices=Drop[realDom[[2]],1];
	     spaceDom=DomProject[realDom,spaceIndices];
	     res={{spaceDom,{positionCur}}},
	     (* else, we continue the search in the AST *) 
	       If [!MatchQ[exp1,Alpha`case[___]],
		   Message[getArrayDomainsExpr::Error1,positionCur,sys[[1]]];
		   Throw["ERROR"],
		    (* Two case :
			   - time  case (depth 5 or 5 in $result) 
			   - other cases 
			   *) 
		    (*  recursive call *)
		    caseLength=Length[exp1[[1]]];
		    listRes=
		    MapThread[getArrayDomainsExpr,
			      {Table[sys,{i,1,caseLength}],
			       Table[Append[Append[positionCur,1],i],
				     {i,1,caseLength}],
			       Table[timeDim,{i,1,caseLength}],
			       Table[spaceDim,{i,1,caseLength}]}];
		    res=mixSpaceDom[listRes]];
		  ];
	 (* showSpaceDom[res]; *)
	 res
	 ];

getArrayDomainsExpr[a___]:= (Message[getArrayDomainsExpr::WrongArg,a];
				      Throw["ERROR"]);
	   
	   
(* 
   mixSpaceDom take several results of getArrayDomainsExpr,
   corresponding  to several branches in the AST and mix them in order
   to obtain one result of getArrayDomainsExpr.
   For each pair of domains, the domains are compared. 
   If they are equal, we put the two position in the same spaceDom,
   If they are disjoint, we put the two positions in different
   spaceDom. If their intersection is not empty, we end up with 
   three domains.
*)
   
Clear[mixSpaceDom];				   

mixSpaceDom[listRes_List]:=
  Module[{res},
	 res = Apply[ Join, listRes ];
	 res];

mixSpaceDom[a___]:= (Message[mixSpaceDom::WrongArg,a];
			     Throw["ERROR"])

(* SimplifySpaceDom is used to collect identical region
   and eventually create new ones by intersection 
   from the region comming from the getArrayDomains[] *)

Clear[simplifySpaceDom];

Options[simplifySpaceDom] := {verbose->True, debug -> False, 
   mergeDomain -> False};

simplifySpaceDom[listRes_List,depth_Integer,options_List:{}]:=
Catch[
    Module[ { verb,i,listResTemp,dbg, listDomains, listPositions, mutOpt},
    verb = verbose/.options/.Options[simplifySpaceDom];
    dbg = debug/.options/.Options[simplifySpaceDom];
    md = mergeDomains/.options/.Options[simplifySpaceDom];
    muteOpt = mute/.options/.Options[toAlpha0v2];

    If[ muteOpt, verb = False ];

    listResTemp = listRes;

    If[ verb, Print["-- Simplifying identical regions ..."] ];

    If[ md, 
      (* Before anything, we do the union of all domains, and
         merge the corresponding positions *)
      listDomains = Union[ Map[ First, listResTemp ] ];
      listPositions = 
      Map[ 
        Function[ x,
          Cases[ listResTemp, {x,y_} -> y, Infinity ] 
        ],
        listDomains
      ];
      listPositions = Map[ Apply[ Union, # ]&, listPositions ];
      listDomains = Table[ {listDomains[[i]], listPositions[[i]]}, 
        {i, 1, Length[ listDomains ]} ];
      listResTemp = listDomains; 
      If[ vrb, 
        Print["-- Number of regions after merge is ", Length[ listResTemp ]]];
      If[ dbg, showSpaceDom[listResTemp] ]; 
    ];

    (* We call depth times the simplify function... *)
    If[ dbg, Print["Depth: ", depth] ]; 

    Module[ {newlist},
      Do[
        Check[ newlist = simplifySpaceDom[listResTemp,{},1,options],
              Throw["Error in simplifySpaceDom"]];
      
        If[ dbg, Print["Iteration: ", i ]; showSpaceDom[ newlist] ];
        If[ newlist === listResTemp, Break[], listResTemp = newlist ],
        {i,1,depth}
      ];
    ];
    listResTemp
  ]
];

simplifySpaceDom[
  oldList_List,
  newList_List,
  index_Integer,
  options_List:{}]:=
Catch[
  Module[{verb,res,brandNewList,curDomain,curPositions,i,
    curNewDomTreated,curNewDom,curNewPos, cpt,
    domInter,dom2,dom1,dom3,newPos, dbg},

  verb = verbose/.options/.Options[simplifySpaceDom];
  dbg  = debug /.options/.Options[simplifySpaceDom];

  (* This algorithm is really a mess... *)
  If[ index > Length[oldList],
    res = newList,
    (* else *)
    brandNewList = newList;
    (*
    If[ dbg, Print[ "Index : ",  index ] ];
    If[ dbg, Print[ "brandNewList : ", brandNewList ] ];
    *)
    curDomain = oldList[[index,1]];
    curPositions = oldList[[index,2]];
    (*
    If[ dbg, Print["curDomain : "]; ashow[ curDomain ] ];
     *)

    (* show[curDomain];*)
    If[ DomEmptyQ[curDomain],
      curNewDomTreated = True
    , (* else *)

      (* for each newSpaceDomain *)
      curNewDomTreated = False;

      i=1;
      (* this loop is dangerous, it increases the counter i 
         and the stopping condition i<Length... together
         be careful when modifying *)
      While[ (i<=Length[brandNewList])&& (!curNewDomTreated),
        (* For each new Domain, we compare it to the
            current domain *)
        If[ dbg, Print["Iteration : ", i ] ];
        curNewDom = brandNewList[[i,1]];
        curNewPos = brandNewList[[i,2]];
        If[ curNewDom[[1]] != curNewDom[[2]], 
           ashow[ curNewDom ]; ashow[ curNewDom ]; Print["pb"] 
        ];

        (* Before calling DomEqualQ, it would be better to 
           call the MMA equality... *)
        If[ 
          Check[
            DomEqualQ[curDomain,curNewDom], 
            Throw[Print["Error4..."] ]
          ],

          (***** Two regions are equal ****)
          (* We add the curPosition of to the one of
             curNewDom *)
           brandNewList = 
             ReplacePart[brandNewList,
               Union[curNewPos,curPositions], {i,2}];
           curNewDomTreated=True;
	   (* Print["equality"]; *)
	   i=i+1
        , (* else *)
          Check[
            If[ Length[ curDomain[[2]] ] === Length[ curNewDom[[2]] ],
              domInter =
                DomIntersection[curDomain,curNewDom], 
              Print["curDomain: ", ashow[curDomain, silent->True]];	  
              Print["curNewDom: ", ashow[curNewDom, silent->True]];	  
              domInter = DomEmpty[0];
              Print["AlpHard::warning:: trying to compare domains with different dimensions"]],
              Throw[Print["Error1..."]]
          ];
          If[ !DomEmptyQ[domInter],
            (***** two regions intersect ****)
            dom2 = domInter;
            Check[
              dom1 = DomDifference[curNewDom,domInter], 
              Throw[Print["Error2..."]]
            ];
Check[
             dom3 = DomDifference[curDomain,domInter], 
             Throw[Print["Error3..."]]
];
             newPos=Union[curPositions,curNewPos];
             (* cpt counts the number of added dom in brandNewList *)
             cpt=0;
             If [!DomEmptyQ[dom1],
               brandNewList = 
                 ReplacePart[brandNewList, {dom1,curNewPos}, {i+cpt}];
               cpt=cpt+1,
               brandNewList = Delete[brandNewList,i+cpt]];

             If [!DomEmptyQ[dom2],
               brandNewList = Insert[brandNewList, {dom2,newPos}, i+cpt];
               cpt=cpt+1;
             ]; 
             If[!DomEmptyQ[dom3],
               brandNewList = 
                 Insert[brandNewList, {dom3,curPositions}, i+cpt];
               cpt=cpt+1;
             ];
             If[ cpt===0,
               Message[simplifySpaceDom::internalWarning];
               cpt=1];
             curNewDomTreated=True;
             i=i+cpt,
             (* else domain not encountered yet *)
             i=i+1
            ]; (* end if ! DomEmptyQ[domInter] *)]
	   ; (* end else DomEqualQ *)
          (* InputString["-->"]; *)
        ]; (* end While *)
        If [!curNewDomTreated,
          (* Print["new Domain"]; *)
          brandNewList = Append[brandNewList,
          {curDomain,curPositions}]];
      ]; (* end if index > oldlist *)
      res =
        simplifySpaceDom[oldList,brandNewList,index+1,options];
    ];
  res
  ]
];
simplifySpaceDom[a___]:=
  (Message[simplifySpaceDom::WrongArg,a];Print["Lenght",Length[{a}]];Print[a];Throw["ERROR"])
			   
				      

Clear[buildControler];

buildControler[nameSignal_String]:=
  buildControler[{nameSignal}];

buildControler[NameSignals_List]:=
Module[{},
       buildControler[$result,NameSignals]  
     ];

buildControler[sys_Alpha`system,NameSignals_List]:=
  Module[{},
	 buildControler[sys,NameSignals,"Control"<>sys[[1]]]];

(* A control signal should have the following structure:
   a spatial case in which one branch contains True or False.
   We extract this branch and check that the spatial domains are all
   the sames *)
buildControler[sys_Alpha`system,NameSignals_List,NameControler_String]:=
Module[{listDecl,listEquation,curName,curDecl,curDef,restrictList,
	newExp,expDom,res,commonIndices},

  If[ Length[NameSignals]===0,
    Message[buildControler::NoControler,sys[[1]]]
  ];

  listDecl= {};
  listEquation = {};

  Do[	 
    curName = NameSignals[[i]];
    curDecl = getDeclaration[sys,curName];
    curDef = getDefinition[sys,curName];

    If[ !MatchQ[curDef,Alpha`case[___]],
      Message[buildControler::WrongForm,curName,sys[[1]]
    ];

    Throw["ERROR"]];

    restrictList={};

    Do[ If[ (Cases[curDef[[1,j]],Alpha`const[True],Infinity]=!={})||
		   (Cases[curDef[[1,j]],Alpha`const[False],Infinity]=!={}),
		 restrictList= Append[restrictList,curDef[[1,j]]]]
    ,
      {j,1,Length[curDef[[1]]]}
    ];

    If[ Length[restrictList]===0,
      Message[buildControler::Problem1,curName,sys[[1]]
    ];
    Throw["ERROR"]];

    newExp = Alpha`case[restrictList];
    expDom = expDomain[sys,newExp];
    expDom = DomIntersection[expDom,curDecl[[3]]];

    listEquation = Append[listEquation,
			       Alpha`equation[curName,
					      newExp]];
    listDecl = Append[listDecl,
			   Alpha`decl[curName,
				      curDecl[[2]],
				      expDom]]
  ,
    {i,1,Length[NameSignals]}
  ];
 
  res = Alpha`system[NameControler,
			 sys[[2]],
			 {},
			 listDecl,
			 {},
			 listEquation];

  res = normalize[addAllParameterDomain[res]]
];
       
buildControler[a___]:=
  (Message[buildControler::WrongArg,a];Throw["ERROR"]);
			    
Clear[getSpaceDom];

getSpaceDom[expDom_Alpha`domain]:=   
  getSpaceDom[expDom,$result[[2]]];

getSpaceDom[sys_Alpha`system,expDom_Alpha`domain]:=
  getSpaceDom[expDom,sys[[2]]];

getSpaceDom[expDom_Alpha`domain,paramDom_Alpha`domain]:=
  Module[{},
	 indiceSpace=Drop[expDom[[2]],1];
	 DomProject[expDom,indiceSpace]];

getSpaceDom[a___]:=
  (Message[getSpaceDom::WrongArg,a];Throw["ERROR"]);

Clear[isSpaceDepQ];

isSpaceDepQ[d1:_affine, opts:___Rule]:= 
Module[
  {locVar1,nbParam,nbSpaceDim,dbg},
  dbg = debug/.{opts}/.{debug->False};

  If[ dbg, Print["Calling isSpaceDepQ form 1" ] ];
  locVar1=$result[[5,1,3]]; (* Get first local variable *)
  If[ dbg, Print[ "locVar1: ", locVar1 ] ];
  nbParam = Length[$result[[2,2]]]; (* Get number of parameters *)
  If[ dbg, Print[ "nbParam: ", nbParam ] ];
  nbSpaceDim = Length[locVar1[[2]]]-1-nbParam;
  If[ dbg, Print[ "nbSpaceDim: ", nbSpaceDim ] ];
  (* Bug corrected here 2/1/03 *)
  isSpaceDepQ[ d1, Table[i,{i,2,2+nbSpaceDim-1}], opts]
];

(*  Originnally: translation on the processor space,
    Improvement a parameterized translation is also OK *) 
     
isSpaceDepQ[d1:_affine,spaceDim_List,opts:___Rule]:=
Module[{nbSpaceDim,m1,lastCol,spaceDepConst,dbg,temp},
       (* set debug option *)
       dbg = debug/.{opts}/.{debug->False};
         nbSpaceDim=Length[spaceDim];
       If[ (d1[[2,1]]<=nbSpaceDim)
	   ||(d1[[2,2]]<=nbSpaceDim),
	   If[dbg, Print["False 1"] ]; False,
	   nbParam=d1[[2,1]]-nbSpaceDim-2;
	   (* else m1 is the affine MMA matrix*)
	   m1=d1[[2,4]];
	   (* id linear part *)
	   If[ dbg, Print["spaceDim: ", spaceDim] ];
	   If[ dbg, Print["d1: ", d1] ];
	   If[ dbg, Print["m1: ", m1 ] ];
	   If[ dbg, Print["nbParam: ", nbParam ] ];
	   temp = Map[Drop[#,-1-nbParam]  &,Drop[m1,-1-nbParam]];
	   If[ dbg, Print[ "Params dropped: ", temp ] ];
	   temp = IdentityMatrix[d1[[2,1]]-1-nbParam];
	   If[ dbg, Print[ "IdentityMatrix: ", temp ] ];
	   If[ Map[Drop[#,-1-nbParam]  &,Drop[m1,-1-nbParam]]
	       =!=IdentityMatrix[d1[[2,1]]-1-nbParam],
	       If[dbg, Print["False 2"] ]; False,
	       (* take the "space " rows of the matrix *)
	       m2 = Take[m1, {2, 1 + nbSpaceDim}];
	       (* take the "param" and "const" columns of these rows *) 
	       m3 = Map[Take[#, {2 + nbSpaceDim, d1[[2, 2]]}] &, m2];
	       (* if m3 is not null, there is a space connexion *) 
	       temp = Union[Flatten[m3]];
	       If[ dbg, Print[ temp ] ];
	       temp=!={0},
	       (* symbolic If part *)
	       If[ dbg, Print["False 3"] ]; False
	   ],
	   (* symbolic If part *)
	   If[ dbg, Print["False 4" ] ]; False
       ]
];

(*******  ********)
isSpaceDepQ[a___]:=False;

(* check if the current equation is a connection equation between cell
    Originnally: translation on the processor space,
    Improvement a parameterized translation is also OK *) 
Clear[isConnexionEqQ];
isConnexionEqQ[eq_Alpha`equation,opts:___Rule]:=
  isConnexionEqQ[$result,eq,opts];

isConnexionEqQ[sys_Alpha`system,eq_Alpha`equation,opts:___Rule]:=
Module[{locVar1,nbParam,nbSpaceDim},
  If[ Length[sys[[5]]]===0,
    Message[isConnexionEqQ::NoLocalVar,sys[[1]]]];
    locVar1=sys[[5,1,3]];
    nbParam=sys[[2,1]];
    nbSpaceDim = Length[locVar1[[2]]]-1-nbParam;
    isConnexionEqQ[eq,Table[i,{i,2,2+nbSpaceDim-1}],opts]
];

isConnexionEqQ[ eq:Alpha`equation[name1_String, d1_Alpha`affine], 
  spaceDim_List, opts:___Rule]:=
  Module[{},
	 isSpaceDepQ[d1,spaceDim,opts]];
  
isConnexionEqQ[a___]:=False;
	

Clear[makeNewCellName]

makeNewCellName[]:=
  makeNewCellName[$result]

makeNewCellName[sys_Alpha`system]:=
  Module[{namesInLib,nameCellInLib,i,newName},
	 namesInLib=Map[Part[#,1] &,$library];
	 nameCellInLib = Select[namesInLib,
				StringMatchQ[#,"Cell"<>sys[[1]]<>"*"] &];
	 i=1;
	 newName="Cell"<>sys[[1]]<>ToString[i];
	 While[(i<20)&&(MemberQ[nameCellInLib,newName]),
	       i=i+1;
	       newName="Cell"<>sys[[1]]<>ToString[i]];
	 If [i>=20,
	     Message[makeNewCellName::ToMuchCell];
	     Throw["ERROR"]];
	 newName]

makeNewCellName[a___]:=
  (Message[makeNewCellName::WrongArg,a];Throw["ERROR"])


Clear[buildOneCell];

buildOneCell[dom1_Alpha`domain,
	    positionList_List,
            opts___Rule]:=
  buildOneCell[$result,dom1,positionList,{},opts]

buildOneCell[dom1_Alpha`domain,
	    positionList_List,
	    controlSignals_List,
            opts___Rule]:=
  buildOneCell[$result,dom1,positionList,controlSignals,opts];

buildOneCell[dom1_Alpha`domain,
	    positionList_List,
            opts___Rule]:=
Module[{},
  Print["Warning: No control signal  indicated, please check 
  that the result contains the correct code"];	 
  buildOneCell[dom1,positionList,{},opts]];

buildOneCell[dom1_Alpha`domain,
  positionList_List,
  controlSignals_List,
  opts___Rule]:=
buildOneCell[$result,dom1,positionList,controlSignals,opts];

buildOneCell[sys_Alpha`system,
  dom1_Alpha`domain,
  positionList_List,
  controlSignals_List,
  opts___Rule]:=
Module[{nameCell},
  nameCell = getNewName[sys,"Cell"<>sys[[1]]];
  Print["Warning: No I/O variable indicated, please check 
         that the result contains the correct outputs"];
  buildOneCell[sys,nameCell,dom1,positionList,controlSignals,{},{},opts]
];

buildOneCell[dom1_Alpha`domain,
  positionList_List,
  controlSignals_List,
  inputForced_List,
  outputForced_List,
  opts___Rule]:=
buildOneCell[$result,
  dom1,
  positionList,
  controlSignals,
  inputForced,
  outputForced,
  opts];

buildOneCell[sys_Alpha`system,
  dom1_Alpha`domain,
  positionList_List,
  controlSignals_List,
  inputForced_List,
  outputForced_List,
  opts___Rule]:=
Module[{nameCell},
  nameCell=getNewName[sys,"Cell"<>sys[[1]]];
  buildOneCell[sys,
    nameCell,
    dom1,
    positionList,
    controlSignals,
    inputForced,
    outputForced,
   opts]
];
	
buildOneCell[sys_Alpha`system,
  nameCell_String,
  dom1_Alpha`domain,
  positionList_List,
  controlSignals_List,
  inputForced_List,
 outputForced_List,
 opts___Rule
]:=
Module[{paramDom,cellParamDom,listTreatedEq,cellVarList,cellInVar,
  cellOutVar,cellLocVar ,curEq,lhsVar,rhsVar,rhsVarIn,cellInDecl,
  cellOutDecl,cellLocDecl,listCellEq,declRhsVar,
  listBranches,cellEq,commonIndices,nbSpaceDim,
  curVar,res,dbg},
 
  dbg = debug/.{opts}/.{debug->False};

  (******* Building parameter domain *****)
  paramDom = sys[[2]];
  cellParamDom = addParameterDomain[dom1,paramDom];

  (****** Building Declarations ******
    classify declaration: input, output, local.
    This classification is made with the indication 
    given as input to the function : forcedInput, 
    forcedOutput. However, the connexion are analyzed 
    and if an incoherence is detected, a warning is printed out
  *)
  listTreatedEq = Union[Map[Take[#,2] &,positionList]];

  (* cellVarList is used to indicates the variables 
     that have not yet been set as input, output or local *)
  cellVarList = Flatten[
    Map[If[getPart[sys,Append[#,0]]===equation,
          getPart[sys,Append[#,1]],
          getPart[sys,Append[#,5]]] &,
          listTreatedEq]];

  listCellEq={};
  cellOutVar = outputForced;
  cellInVar = inputForced;
  cellVarList = Complement[cellVarList, cellOutVar];
  cellVarList = Complement[cellVarList, cellInVar];
  If[ dbg ,
    Print["cell  vars:\n input",cellInVar,"\noutput:",cellOutVar,
      "\n local ",cellVarList]
  ];

  cellLocVar={};
  cellOutDecl = Map[getDeclaration[sys,#] &,cellOutVar];
  cellInDecl = Map[getDeclaration[sys,#] &,cellInVar];
  cellLocDecl = {};

  Do[ 
    curEq = getPart[sys,listTreatedEq[[i]]];
    If[ dbg, ashow[ curEq ] ];

    (*  for each equation of the cell 
       **** building  declaration *****)
    If[ isConnexionEqQ[sys,curEq,opts],

      (* lhs var is set as local *)
      rhsVar=curEq[[2,1,1]];
      lhsVar=curEq[[1]];

      (* lhs is set as input, rhs as output *) 
      If[ !MemberQ[outputForced,rhsVar],
        Print[
          "buildOneCell::OutputNotSet Warning, it seems that cell ", 
          nameCell, " needs to output signal ", lhsVar, 
          " but it is not specified in the call, please check the result"
        ]
      ];
      If[ !MemberQ[inputForced,lhsVar],
        Message[buildOneCell::InputNotSet,nameCell,lhsVar] ];
    ];

   (******  Building Equations ******
     We take the rhs indicated by the position List.
     ASSUMPTION: if, for a given  equation,
     there are  several branches, we gather them 
     together (assuming they correspond to the two branches 
     of a case) *)

    cellEq={};
    If[(!isConnexionEqQ[sys,curEq]&&
        !isMirrorEqQ[sysc,curEq,controlSignals]),

      (*  if it is the def of a control signal *)
      If[ (MemberQ[controlSignals,curEq[[1]]])||
          (MemberQ[cellInVar,curEq[[1]]]),
        (* control signal initialisation,
           or input to the system,  do
           nothing  set as input *)

        cellVarList =
          Complement[cellVarList, {curEq[[1]]}];
        cellEq={},

        (* else *)
        listBranches =
          Select[positionList,
            Take[#,2] === listTreatedEq[[i]] &];

        If[ Length[listBranches]>1,

          (* several case branches: 
            take all the equation *)
          cellEq = {curEq},
 
          (* other cases, take the branch indicated 
             by the position *)
          If[ curEq[[0]]===equation,
            cellEq =
              {equation[ curEq[[1]],
                 getPart[sys,
                         listBranches[[1]]]]},
              (* use case *)
            cellEq = {curEq}
          ]
        ]
       (* end if MQ[controlSig], else ...]; *)
      ] (* end Else connexionQ *)
    ];				 
    listCellEq = Join[listCellEq,cellEq],
    {i,1,Length[listTreatedEq]}];
	 
	 
  (*** adding eventually inicontrolSignals as input to the 
    new system ***)
  Do[ 
    curVar=controlSignals[[i]];
    cellVarList = Complement[cellVarList, {curVar}];
    If[ Cases[listCellEq,Alpha`var[curVar],Infinity]=!={},
        cellInVar=Append[cellInVar,curVar];
        cellInDecl=Append[cellInDecl,getDeclaration[sys,curVar]]],
        {i,1,Length[controlSignals]}
  ];
	


  (* All the remaining variables are local vars 
     the local variables are all remaining vars (not input
     neither output) *)
  cellLocVar = Join[cellLocVar,cellVarList];

  cellLocDecl=Join[cellLocDecl,
    Map[getDeclaration[sys,#] &,cellVarList]];

  (**** building final subsystem ***
    I must rename the space Indices in all domains *)

  res = system[nameCell,
    cellParamDom,
    cellInDecl,
    cellOutDecl,
    cellLocDecl,
    listCellEq];

  (* renaming :  t is time, indices are indices of the 
    parameter space *)
  nbSpaceDim=cellParamDom[[1]]-paramDom[[1]];
  commonIndices = Prepend[cellParamDom[[2]],"t"];
  res=res/.(Alpha`domain[a_,b_,c_]/;(Length[b]===Length[commonIndices])
	   ->Alpha`domain[a,commonIndices,c]);
  res = normalize[addAllParameterDomain[res]]
];

buildOneCell[a___]:=
  (Message[buildOneCell::WrongArg,a];Throw["ERROR"]);

Clear[nameExistsQ];

(* temporary *)
nameExistsQ[a___]:= False;


(* Mirror equations are equations used for the interface between the 
   module system and the interface system *)
Clear[isMirrorEqQ];

isMirrorEqQ[eq:_equation,opts:___Rule]:=
  isMirrorEqQ[$result,eq,{},opts];

isMirrorEqQ[sys1:_system,eq:_equation,opts:___Rule]:=
  isMirrorEqQ[sys1,eq,{},opts];

isMirrorEqQ[eq:_equation,controlSignals_List,opts:___Rule]:=
  isMirrorEqQ[$result,eq,controlSignals,opts];

isMirrorEqQ[
  sys:_system,
  eq:equation[name1_String,
  affine[var[name2_String], funct:_matrix]],
  controlSignals_List,opts:___Rule]:=
isMirrorEqIntQ[sys,name1,name2,controlSignals,opts];

isMirrorEqQ[
  sys:_system,
  eq:equation[name1_String,var[name2_String]],
  controlSignals_List,opts:___Rule]:=
isMirrorEqIntQ[sys,name1,name2,controlSignals,opts];
  
isMirrorEqQ[a___]:=False;

Clear[isMirrorEqIntQ];
isMirrorEqIntQ[
  sys:_system,
  name1:_String,
  name2:_String,
  controlSignals:_List,
  opts:___Rule]:=
  Module[{inOutEq,ctlEq,dbg},

    dbg = debug/.{opts}/.{debug->False};
    If[ dbg, Print["lhs: ", name1, "\nrhs: ", name2 ] ];
    If[ dbg, Print["controlSignals: ", controlSignals ] ];

    (* A mirror equation meets one of the following conditions : 
       - its rhs is an input or an output var
       - its lhs is a local var
       - or its rhs is a local var, and its rhs is an output var
       - or its rhs is a control signal
    *)
    inOutEq=
      (* Check that name2 is an input or output var *)
      (MemberQ[Join[getInputVars[sys],getOutputVars[sys]],
		  name2]&&
      (* name1 is a local var *)
      MemberQ[getLocalVars[sys],name1]) 
     || 
      (* Or name2 is a local var, and name2 an output *)
      (MemberQ[getLocalVars[sys],name2]&&
       MemberQ[getOutputVars[sys],name1]);

    (* Is may be an equation whose second member is a control signal *)
    ctlEq = (MemberQ[controlSignals,name2]);

    (* Return union of conditions *)
    (inOutEq || ctlEq)];
	 
isMirrorEqIntQ[a___]:=  
  (Message[isMirrorEqIntQ::WrongArg,a];Throw["ERROR"]);


(* get the rhs var of a Mirror eq *)
Clear[getRhsOfMirror];
getRhsOfMirror[ eq:equation[name1_String,
                     affine[var[name2_String], funct_matrix]]]:=name2;
	
getRhsOfMirror[ eq:equation[name1_String,
                     var[name2_String]]]:=name2;
  
getRhsOfMirror[a___]:= 
  (Message[getRhsOfMirror::WrongArg,a];Throw["ERROR"]);

Clear[buildModule];

Clear[buildInterface];
(* returns a list of two systems: the interface and the module 
 (if the mirror equations are correctly set) *)

Options[buildInterface]:={verbose->True,debug->False,exceptions->{}}

buildInterface[options:___Rule]:= 
Catch[
  Module[{l1},
    (* Call buildInterface on $result *)
    l1 = buildInterface[ $result, options ];	
    
    If[ MatchQ[l1[[1]], system[___]],
      removeSystem[$result[[1]]];
      putSystem[l1[[2]]];
      putSystem[l1[[1]]];
      $program=$result;
      $result=l1[[2]],
      Throw[ Message[buildInterface::PbOccured] ]
    ]
  ]
];
 
buildInterface[ sys:_system, options:___Rule ]:= 
Catch[

Module[{verb,dbg,
  ism, istEq,listLocalVar,listInterfaceEq,listInterfaceLoc,listModuleEq,
  listModuleInput,listModuleOutput,listCallModuleInput,
  listCallModuleOutput,listModuleLocal,	listDeclModuleOutput,
  listDeclModuleInput,curEq,newName,useAst,
  sysInterface,sysModule,outVars,eqOutput,posEqOutput,
  curPosEqOutput,curEqOutput,newEq, newsys, uses, outuses,
  cond1, cond2, cond3, cond4, ex, workvar, rhsvarex, listSubSystems,
  muteOpt},
	 
  (* Get options *)
  verb = verbose/.{options}/.Options[buildInterface];
  dbg = debug/.{options}/.Options[buildInterface];
  ex = exceptions/.{options}/.Options[buildInterface];
  muteOpt = mute/.{options}/.Options[alpha0ToAlphard];

  If[ muteOpt, verb = False ];

  (* Initialize newsys for future use *)
  newsys = sys; 

  (* Check if we already have a module *)
  ism = isModuleQ[sys];
  (* Actually, we do not assume that we hava a module *)
  If[ False (* ism *),
     buildInterface::isModule= 
     "Warning, system `1` is perhaps already in module form.";
     Message[buildInterface::isModule, sys[[1]]]
  ];

  If[ dbg, Print["-- Checking form of output equation"];];
	 
  (* Get the output variables *)
  outVars = Map[ First, sys[[4]] ];
  (* Do not consider the outputs of use statements *)
  uses = Cases[ sys[[6]], use[___] ];
  outuses = Apply[ Union, Map[ Part[ #1,5 ]&, uses ] ];
  outVars = Complement[ outVars, outuses ];

  If[ dbg, Print[ "Output vars: ", outVars ] ];
  eqOutput = Map[ getEquation[sys,#] &, outVars ];
  If[ dbg, Print[ "Output equations : ", 
    Map[ ashow[#,silent->True]&, eqOutput ] ] ];

  (* Get positions of outputs of equations *)
  posEqOutput = Map[ Part[Position[sys,#],1]&, eqOutput];

  (* First, we check that all output equations are of
     the form x = v or x = v[affine]; *)
  Do[ 
    (* Get position of equation *)
    curPosEqOutput = posEqOutput[[i]];
    (* Get output equation*)
    curEqOutput = eqOutput[[i]];

    (* If the rhs has the forme affine[_] or var[ ], it is OK *)
    (* Do not consider the case of the output of a use statement *)
    If[ 
      ((!MatchQ[curEqOutput[[2]],affine[___]])&&
       (!MatchQ[curEqOutput[[2]],var[___]])),

        (* If the rhs has the form restrict[_,affine] or 
           restrict[_,var], one tries to modify it *)
        If[MatchQ[ curEqOutput[[2]], restrict[_,affine[___]]] ||
            MatchQ[ curEqOutput[[2]], restrict[_,var[___]]],
          If[verb, Print["Warning, modifying Output equation for variable ",
             outVars[[i]]];
          ];
          newEq = ReplacePart[curEqOutput, curEqOutput[[2,2]], {2}];
          If[ dbg, Print["New equation: "]; ashow[newEq] ];
          newsys = ReplacePart[ sys, newEq, curPosEqOutput ],
        (* else *) 
          buildInterface::wrgoutput = "error in buildInterface";
          Print["Warning, Output ", outVars[[i]],
            " is not in correct form and I cannot change it"];
          Throw[ Message[ buildInterface::wrgoutput ] ]
        ];
    ];
    ,{i,1,Length[eqOutput]}
  ];

  (* Get the list of equations *)
  listEq = newsys[[6]];
  (* Get the list of local variables *)
  listLocalVar = Map[First,newsys[[5]]];
  (* Get the list of subsystems *)
  listSubSystems = Map[ First, Cases[ newsys[[6]], use[___], Infinity ] ];
  If[ dbg, Print["List of subsystems: ", listSubSystems] ];
  (* List of equations for the interface *)
  listInterfaceEq={};
  (* List of locals for the interface *)
  listInterfaceLoc = {};
  (* List of equations of the module *)
  listModuleEq={};
  (* List of the inputs to the module *)
  listModuleInput={};
  (* List of the outputs of the module *)
  listModuleOutput={};
  (* Input Declarations of the module *)
  listDeclModuleInput = {};
  (* Output declarations of the module *)
  listDeclModuleOutput = {};
  (* Inputs of the module *)
  listCallModuleInput={};
  (* Outputs of the module *)
  listCallModuleOutput={};
  listModuleLocal={};

  (* Get the local variables which are not in the exception 
    list *)
  workvar = Complement[ listLocalVar, ex ];
  If[ dbg, Print[" Equations without exceptions: ", workvar ] ];
  (* Get the definitions of thes local variables *)
  rhsvarex = Select[ listEq, MemberQ[ workvar, First[#] ]& ];
  If[ dbg, Map[ ashow, rhsvarex ] ];
  (* Get all variables which are referred in the rhs of these
    equations *)
  rhsvarex = Cases[ rhsvarex, var[u:_]->u, Infinity ];
  (* Print["Rhs: ", rhsvarex]; *)
  (* Get also the use statements which are not listed in the exceptions *)
  workvar = Complement[ listSubSystems, ex ]; 
  (* Print["use : ", workvar ]; *)
  (* Get these use statements *)
  workvar = Select[ Cases[ listEq, use[___] ], 
		    MemberQ[ workvar, First[#] ]& ];
  (* Print[ workvar ]; *)
  (* Get the rhs *)
  workvar = Cases[ workvar, var[u:_]->u, Infinity ];
  (* Print["RHS: ",  workvar ]; *)
  rhsvarex = Union[ rhsvarex, workvar ];
  (* Print[ rhsvarex ]; *)

  (* For all equations of the system *)
  Do[ 
    curEq = listEq[[i]];
    (* An equation is an interface equation if it is
       a mirror equation, and if its lhs is an output var
       or the rhs symbol of the mirror equation is an 
       input or an output variable *)

    (* An equation is also an interface equation if it is
       listed in the option exceptions *)
    
    cond1 = 
      isMirrorEqQ[ newsys, curEq, {} ] && 
      MemberQ[getOutputVars[newsys],curEq[[1]]];

    cond2 = 
      isMirrorEqQ[ newsys, curEq, {} ] && 
      MemberQ[ getInputVars[newsys], getRhsOfMirror[curEq] ];

    cond3 = 
      isMirrorEqQ[ newsys, curEq, {} ] && 
      MemberQ[ getOutputVars[newsys], getRhsOfMirror[curEq] ];

    cond4 = MemberQ[ ex, curEq[[1]] ];
      
    If[ cond1 || cond2 || cond3 || cond4, 
      listInterfaceEq = Append[listInterfaceEq,curEq];
      If[ dbg, 
        Print["Equation ", ashow[ curEq, silent->True ], 
        "\n is an interface equation since ",
          Which[
            cond1, "it is a mirror equation and its LHS is an output var.",
            cond2, "it is a mirror equation and its RHS is an input var.",
            cond3, "it is a mirror equation and its RHS is an output var.",
	    cond4, "LHS is listed in exceptions."
	]
        ];
      ];

      (* Two cases to consider: normal equation, or use statement *)
      Which[
        MatchQ[ curEq, equation[___] ],
        (* We have a normal equation *)
        (* If the lhs is a local var, it is an input to
           module, otherwise the rhs is an output to the module.
           For each output and input a Mirror variable is added.
        *)
        If[ MemberQ[ listLocalVar, curEq[[1]] ],
          (* input mirror curVarIn added as input to module*) 
          newName = getNewName[Join[{newsys},$library], curEq[[1]]<>"In"];
          idMat1= idMatrix[ getIndexNames[newsys,curEq[[1]]],
                          getIndexNames[newsys,curEq[[1]]]
          ];

          listModuleEq = 
            Append[listModuleEq,
              equation[curEq[[1]], affine[ var[newName], idMat1]]];	
          If[ dbg,
            Print["Equation ", ashow[ Last[listModuleEq], silent->True ], 
            "\n is a module equation"] ];

          (* Add to the local variables of the module the lhs *)
          listModuleLocal = Append[listModuleLocal,curEq[[1]]];
 
          (* Add the lhs to the list of the caller*)
          listCallModuleInput = Append[listCallModuleInput,curEq[[1]]];

          (* Add the new name to the inputs of the module *)
          listModuleInput = Append[listModuleInput,newName];

          (* Replace the declaration in the input declarations of the
	    module by the new name *)
          listDeclModuleInput = 
            Append[listDeclModuleInput,
                ReplacePart[getDeclaration[newsys,curEq[[1]]],
                            newName,
            1]];

	  (* For an exception equation, we must also find out their 
	    declarations *)
          If[ cond4, 
            Module[ {rhsv1, rhsv2},
              If[ dbg, Print["Exception equation..."] ];
              rhsv1 = Cases[ curEq, var[u:_]->u, Infinity ];
	      If[ dbg, Print["List of rhs vars: ", rhsv1] ];
              rhsv2 = Complement[ rhsv1, ex ];
	      If[ dbg, Print["List of rhs vars not an exception: ", 
			     rhsv2 ] ];
              rhsv1 = Complement[ rhsv1, rhsv2 ];
	      If[ dbg, Print["List of rhs vars which are an exception: ",     
			     rhsv1 ] ];
              (* Add these variables to the list of interface local vars *)
              listInterfaceLoc = 
		    Union[ listInterfaceLoc, rhsv2 ];
	    ]
	  ]
        ,
          (* else output mirror curVarOut added as output
            to module *)
          newName = getNewName[Join[{newsys},$library],curEq[[2,1,1]]<>"Out"];
          idMat1 = idMatrix[getIndexNames[newsys,curEq[[2,1,1]]],
                         getIndexNames[newsys,curEq[[2,1,1]]]];
          listModuleEq=
            Append[listModuleEq,
              equation[newName, affine[ var[curEq[[2,1,1]]],idMat1]]];
          If[ dbg,
            Print["Equation ", ashow[ Last[listModuleEq], silent->True ], 
            "\n is a module equation"] 
          ];

          listModuleLocal = Union[listModuleLocal,{curEq[[2,1,1]]}];

          listCallModuleOutput=Append[listCallModuleOutput,curEq[[2,1,1]]];
 
          listModuleOutput=Append[listModuleOutput,newName];

          listDeclModuleOutput = 
            Append[listDeclModuleOutput,
              ReplacePart[getDeclaration[newsys,curEq[[2,1,1]]],
                       newName,
            1]]
        ],

        (* We have a use statement *)
        MatchQ[ curEq, use[___] ],
        (* We make the following assumptions: 
	  - the outputs of the use are local to the system. 
	  - the inputs of the use are simple variables, and are local
	  to the system
	*)
        Module[ {lhsvars, rhsvars, tempvar, ltemp},
          lhsvars = curEq[[5]]; (* lhs vars *)
          (* Check that outputs are local *)
          ltemp = Select[ lhsvars, !MemberQ[getLocalVars[sys],#]& ];
          If[ ltemp =!= {}, 
	    alphard::notLocUse = 
	      "output of use statement must be a local variable";
	    Print["In: ", ltemp];
            Throw[Message[alphard::notLocUse] ]
	  ];
          rhsvars = curEq[[4]];
          (* Check simple inputs *)
          ltemp = 
	    Select[ rhsvars, !MatchQ[#,var[_]]&];
          If[ ltemp =!= {}, 
	    alphard::notSimplInput = 
	      "inputs of use statement must be simple variables.";
	    Print["In: ", ltemp];
            Throw[Message[alphard::notSimplInput] ]
	  ];
          (* Check local inputs *)
          rhsvars = Map[ First, rhsvars ]; (* Get the true lhs vars *)
          ltemp = 
	    Select[ rhsvars, !MemberQ[getLocalVars[sys],#]&];
          If[ ltemp =!= {}, 
	    alphard::notLocInput = 
	      "inputs of use statement must be local variables.";
	    Print["In: ", ltemp];
            Throw[Message[alphard::notLocInput] ]
	  ];

          Do[
            tempvar = lhsvars[[k]];

            (* We know that the lhs is a local variable *)
            (* We must add an input to the module for the output 
	     variable tempvar only if it appears as a rhs vars in 
             an equation which is not an exception. This list 
	     was computed in rhsvarex *)
            If[ !MemberQ[ rhsvarex, tempvar ], 
              Continue[] ];

            newName = getNewName[Join[{newsys},$library], tempvar<>"In"];
            idMat1= idMatrix[ getIndexNames[newsys,tempvar],
                          getIndexNames[newsys,tempvar]
            ];
            listModuleEq = 
              Append[listModuleEq,
                  equation[tempvar, affine[ var[newName], idMat1]]];	
            If[ dbg, 
              Print["Equation ", ashow[ Last[listModuleEq], silent->True ], 
                "\n is a module equation"] 
            ];

            listModuleLocal = Append[listModuleLocal,tempvar];
 
            listCallModuleInput = Append[listCallModuleInput,tempvar];

            listModuleInput = Append[listModuleInput,newName];

            listDeclModuleInput = 
              Append[listDeclModuleInput,
                ReplacePart[getDeclaration[newsys,tempvar],
                          newName,
              1]],

            {k,1,Length[lhsvars]}
	  ];

          (* Now, we consider the inputs of the use, and 
	     for each one of these, we remove the declaration of
	     the local variables of the module, and we add a new
	     input to the module *)
          Do[
            tempvar = rhsvars[[k]];

            (* We know that the rhs is a local variable *)
            newName = getNewName[Join[{newsys},$library], tempvar<>"Out"];
            idMat1= idMatrix[ getIndexNames[newsys,tempvar],
                          getIndexNames[newsys,tempvar]
            ];
            listModuleEq = 
              Append[listModuleEq,
                  equation[newName, affine[ var[tempvar], idMat1]]];	

            If[ dbg, 
              Print["Equation ", ashow[ Last[listModuleEq], silent->True ], 
                "\n is a module equation"] 
            ];

            listModuleLocal = Union[listModuleLocal,{tempvar}];
 
            listCallModuleOutput = Append[listCallModuleOutput,tempvar];

            listModuleOutput = Append[listModuleOutput,newName];

            listDeclModuleOutput = 
              Append[listDeclModuleOutput,
                ReplacePart[getDeclaration[newsys,tempvar],
                          newName,
              1]],

            {k,1,Length[rhsvars]}
	  ];

        ]
        ,
	True, Print["Error..."] (* Just in case... *)
      ]
    ,
 
      (* else, the curEq is not a mirror eq *)
      listModuleEq = Append[listModuleEq,curEq];
      If[ dbg, 
        Print["Equation ", ashow[ Last[listModuleEq], silent->True ], 
        "\n is a module equation"] ];
      lhsVars = If[ MatchQ[curEq[[0]],use], Last[curEq], {First[curEq]}];
      listModuleLocal = Union[listModuleLocal,lhsVars];
    ];
    ,{i,1,Length[listEq]}
  ]; (* End Do *)

  (* To avoid double declarations *)
  listModuleInput = Union[ listModuleInput ];
  listModuleOutput = Union[ listModuleOutput ];

  If[ dbg, Print["Local variables of module: ", listModuleLocal] ];
  If[ dbg, Print["Inputs of the module: ", listModuleInput] ];
  If[ dbg, Print["Outputs of the module: ", listModuleOutput] ];

  If[ 
    Length[listModuleInput]=!=Length[newsys[[3]] ],
    Print[ 
      "Warning : the number of inputs of the module (",
      Length[listModuleInput],
      ") is different from the number of inputs (",
      Length[newsys[[3]]],
      ") of the initial system."];
  ];

  If[ verb||dbg, Print["Inputs of the module: ",  listModuleInput ] ];
  If[ verb||dbg, Print["Inputs of the system: ",  Map[First,newsys[[3]]]] ];

  If[ Length[listModuleOutput]=!=Length[newsys[[4]]],
   Print[
     "Warning: the number of outputs of the module (",
     Length[listModuleOutput],
     ") is different of the number of outputs (",
     Length[newsys[[4]]],
     ") of the initial system."];
  ];
  If[ dbg, Print["Outputs of the interface: ",  listModuleOutput ] ];
  If[ dbg, Print["Outputs of the system: ",  
    Map[ First, newsys[[4]]] ] ];
	 
  (* To avoid double declarations *)
  listDeclModuleInput = Union[ listDeclModuleInput ];
  listDeclModuleOutput = Union[ listDeclModuleOutput ];
  listCallModuleInput = Union[ listCallModuleInput ];
  listCallModuleOutput = Union[ listCallModuleOutput ];

  If[ dbg, Print["List of Inputs of the call: ", listCallModuleInput] ];
  If[ dbg, Print["List of Outputs of the call: ", listCallModuleOutput] ];

  (* building the use *)
  newName = getNewName[newsys,newsys[[1]]<>"Module"];
  useAst = use[newName,
                   newsys[[2]],
                   idMatrix[newsys[[2,2]],newsys[[2,2]]],
                   Map[Alpha`var[#] &,listCallModuleInput],
                   listCallModuleOutput];
	 
  (* Building the interface *)
  sysInterface = 
  system[newsys[[1]],
     newsys[[2]],
     newsys[[3]],
     newsys[[4]],
     Map[getDeclaration[newsys,#] &,
       Join[listCallModuleInput,
            listCallModuleOutput,
	    listInterfaceLoc]
     ],
     Append[listInterfaceEq, useAst]
  ];
  (*
  Global`$$Interface = sysInterface;
   *)

  (* Building the module *)
  sysModule = system[newName,
     newsys[[2]],
     listDeclModuleInput,
     listDeclModuleOutput,
     Map[getDeclaration[newsys,#] &,
         listModuleLocal],
         listModuleEq];
  (*
  Global`$$Module = sysModule;
   *)

  {sysModule,sysInterface}
  ]
];   
buildInterface[a___]:= (Message[buildInterface::WrongArg,a];Throw["ERROR"]);

(* function for removing a system of the $library *)
removeSystem::NotFound =   " `1` not found in the library.";

Clear[removeSystem];
removeSystem[id_String] :=
  Module[ {systemFound},
    systemFound = Position[$library, Alpha`system[id,__], 1];
    If[ systemFound=!={},
      ($library=Delete[$library,First[systemFound]];
      If[ dbg, Print[id, " removed from $library"] ];
      If[ MatchQ[$result,Alpha`system[id,___]],
        Alpha`$program = Alpha`$result;
        If[ dbg, Print[id, " removed from $result"]];
        If[ Length[$library]>=1,
          $result=$library[[1]],
          $result=Null]]),
      (Message[removeSystem::NotFound,id];$Failed)
    ]
  ];

removeSystem[___] := 
( Print["Error : Syntax is removeSystem[systemname_String]"];
                    $Failed )

Clear[ isModuleQ ];
isModuleQ[sys:_system]:=
  Module[{test1,test2,test3,dims},
    (* Same dimension for all input, output vars *)
    dims = Union[Map[getPart[#,{3,1}] &,
			  Join[sys[[3]],sys[[4]]]]];

    test1 = (Length[dims]===1);
    test2 = (dims[[1]]-sys[[2,1]]>1);
    (* test3 : the first indice is called t .... *)

    test3 = (Union[Map[getPart[#,{3,2,1}] &,
			  Join[sys[[3]],sys[[4]]]]])==={"t"};
    test1 && test2 && test3];
isModuleQ::arg = "wrong arguments"; 
isModuleQ[___]:= Message[ isModuleQ::arg ];

Clear[removeDoubleDecl];

removeDoubleDecl[decl1:List[___Alpha`decl]]:=
  Module[{curDecl,listNames,posToRemove,curName,curPos},
	 curDecl=decl1;
	 listNames=Map[First,decl1];
	 posToRemove = {};
	 Do[curName = decl1[[i,1]];
	    curPos = Position[listNames,curName];
	    If [Length[curPos]>1,
		posToRemove = Join[posToRemove,Drop[curPos,1]]]
	   ,{i,1,Length[decl1]}];
	 curDecl = Delete[curDecl,posToRemove]];

removeDoubleDecl[a___]:=
  (Message[removeDoubleDecl::WrongArg,a];a)

Clear[removeDoubleVar]

removeDoubleVar[varList:List[___String]]:=
  Module[{newList},
	 newList={};
	 Do [curVar=varList[[i]];
	     If [!MemberQ[newList,curVar],
		 newList=Append[newList,curVar]];
	   ,{i,1,Length[varList]}];
	 newList
       ]

removeDoubleVar[a___]:=
  (Message[removeDoubleVar::WrongArg,a];a)


Clear[alpha0ToAlphard];

Options[alpha0ToAlphard]:={verbose->True,debug->False,
  mergeDomains-> False, structured->False, mute -> False, 
  simplify -> True}

alpha0ToAlphard[opts:___Rule]:=
  alpha0ToAlphard[controlVars[],opts]

alpha0ToAlphard[controlSignals_List,options:___Rule]:=
Catch[
  Module[{l1, muteOpt, sns, simplOpt, vrb},
    vrb = verbose/.{options}/.Options[alpha0ToAlphard];
    muteOpt = mute/.{options}/.Options[alpha0ToAlphard];
    simplOpt = simplify/.{options}/.Options[alpha0ToAlphard];

    If[ !muteOpt&&vrb, 
      Print["\n**********  Generating Alphard Program **********"] ];

    Check[
      l1 = alpha0ToAlphard[$result,controlSignals,options],
      alpha0ToAlphard::error = 
        "something wrong happened during transformation to Alphard";
      Print[ Message[ alpha0ToAlphard::error ] ]
    ];

    If[ MatchQ[l1,{___Alpha`system}],
      removeSystem[$result[[1]]];
      Map[putSystem,l1];
      $program=$result;

      (* If simplify is set, simplify system *)
      sns = systemNames[ ];  (* Get list of system names in library *)
      If[ !muteOpt, Print[ sns ] ]; 

      (* Clean each one of the systems and save it back in lbrary *)
      Map[
        (
         getSystem[#];
         If[ !muteOpt, Print["# local vars before:", Length[ getLocalVars[ ] ] ]
         ];

        Check[
          removeIdEqus[],
          alpha0ToAlphard::error2 = 
            "could not remove identity equations in system `1`";
          Throw[ Message[ alpha0ToAlphard::error2, # ] ]
        ];

        Check[
          normalize[ alphaFormat -> Alpha0 ],
          alpha0ToAlphard::error3 = 
            "could not normalize system `1`";
          Throw[ Message[ alpha0ToAlphard::error3, # ] ]
        ];

        Check[
          simplifySystem[ alphaFormat -> Alpha0 ],
          alpha0ToAlphard::error3 = 
            "could not simplify system `1`";
          Throw[ Message[ alpha0ToAlphard::error3, # ] ]
        ];

        If[ !muteOpt, 
           Print["# local vars after:", Length[ getLocalVars[ ] ] ]
        ];  
        putSystem[]
        )&,
        sns
      ];

      If[ !muteOpt,
        Print["**********  End of Alphard Generation **********"] ];
      $result=Last[l1]
    ,
      Throw[Message[alpha0ToAlphard::PbOccured]]
    ]
  ]

];

alpha0ToAlphard[sys:_system,options:___Rule]:=
  alpha0ToAlphard[sys, {},options];

alpha0ToAlphard[sys:_system, controlSignals_List, options:___Rule]:=
Catch[
  Module[{ l1, interf, mod, res2, res, listRegion, dbg, verb, ism, muteOpt},
    verb = verbose/.{options}/.Options[alpha0ToAlphard];
    dbg = debug/.{options}/.Options[alpha0ToAlphard];
    muteOpt = mute/.{options}/.Options[alpha0ToAlphard];

    If[ muteOpt, verb = False ];

    (* Look if system is a module or not *)
    ism = isModuleQ[sys];
    ism = False; (* it should never be a module ! *)


    If[ !ism && verb, Print["Assuming that sys is not a module"] ];

    If[ !ism,
      If[ verb,
        Print["-- Building Interface of system: ", sys[[1]] ] 
      ];
      If[dbg, Print[ashow[sys,silent->True]] ];

      Check[
        (* buildInterface returns two systems: a module and an
           interface *)
        l1 = buildInterface[sys, options, verbose->True ],
        alpha0ToAlphard::errInterface = "could not build the interface.";
        Throw[ Message[ alpha0ToAlphard::errInterface ] ]
      ];

      {mod, interf} = l1;
      If[ dbg, 
        Print["Interface:"];
        Print[ ashow[interf,silent->True] ];
        Print["Module:"];
        Print[ ashow[mod,silent->True] ]
      ];
	      
      (* ***************************** *)
      (* We call again alpha0ToAlphard on the module
         (now  alpha0ToAlphardBis )  *)
      Check[ 
        res2 = alpha0ToAlphardBis[mod, controlSignals, options ],
        alpha0ToAlphard::errModule = "could not structure module.";
        Throw[ Message[ alpha0ToAlphard::errModule ] ]
      ];


      (* and we append the result to the interface *)
	res = Append[ res2, interf ]

    ];

    normalizeIdDepLib[res]
  ]
];

alpha0ToAlphard[___]:=Message[alpha0ToAlphard::params];	

Clear[alpha0ToAlphardBis];
(* alpha0ToAlphardBis is called by alphaOtoAlphard after having built the 
interface *)

alpha0ToAlphardBis[sys:_system, controlSignals_List, options:___Rule]:=
Catch[
  Module[{ l1,  res2, res, listRegion, dbg, verb, ism, muteOpt},
    verb = verbose/.{options}/.Options[alpha0ToAlphard];
    dbg = debug/.{options}/.Options[alpha0ToAlphard];
    muteOpt = mute/.{options}/.Options[alpha0ToAlphard];

    If[ muteOpt, verb = False];

    If[ verb, Print["-- Structuring Module ",sys[[1]]];
    Print["-- Determining the different cell types... "]];

    Check[
      listRegion = getArrayDomains[sys,controlSignals,options],
      alpha0ToAlphard::errDomains = "error while building regions";
      Throw[ Message[ alpha0ToAlphard::errDomains ] ]
    ];

    Check[
      res = alpha0ToAlphardModule[sys, listRegion, 
        controlSignals, {options}],
      alpha0ToAlphard::errAlphardModule = "error while building modules";
      Throw[ Message[ alpha0ToAlphard::errAlphardModule ] ]
    ];

    res

  ]

];

alpha0ToAlpharBis[___]:=Message[alpha0ToAlphard::params];	
 
Clear[alpha0ToAlphardModule];

Options[alpha0ToAlphardModule]:={verbose->True, mute -> False};

alpha0ToAlphardModule[sys_Alpha`system, 
  listRegion_List, controlSignals_List,
  options_List:{}]:=
Module[
  {verb,controler,localModuleVar,localModuleDecl,controlUse,useList,
  listCell,connexionStructure,curRegion,localOutputList,
  localInputList,cellOutputList,cellInputList, connexEq,
  domRegion,curEq,rhsExpDom,rhsContextDom,rhsDom,domInter,
  localIn,newIn,localDecl,newDom, posInConnexion,rhsMirror,
  lhsMirror,curSig,curName,curCell,realInput,controlSignalsInput,
  curUse,curDecl,domCurVar,curListRestrict,curCurName,curCurRegion,
  newModule,res,localOut,localOutDecl,dbg,optMute},
	 
  verb=verbose/.options/.Options[alpha0ToAlphardModule];

  dbg = debug/.options/.Options[alpha0ToAlphardModule];
  optMute = mute/.options/.Options[alpha0ToAlphardModule];

  If[ optMute, verb = False ];

  (* A controller is needed only if the controlSignals list is
     not empty *)
  If[ Length[controlSignals]>=1,
    If [verb,Print["--- Generating Controler ..."]];
      
      controler = {buildControler[sys,controlSignals]};

      localModuleVar = controlSignals;

      localModuleDecl = Map[getDeclaration[sys,#]&,controlSignals];

      controlUse = use[controler[[1,1]],
        sys[[2]], (* N-> N *)
        idMatrix[sys[[2,2]],sys[[2,2]]],
        {},
        controlSignals];
      useList= {controlUse};
	     
      If[ dbg, show[controler] ],

      (* else *)
      controler ={};
      useList= {};
      localModuleVar = {};
      localModuleDecl = {};
	     
  ];

  listCell = controler;
	 
  (* connexionStructure is a structure that indicates 
    for each variable used as output of at least one cell,
    what is the name of the variable set as output of the use,
    for each cells: 
    list of : {nameVar,{{newNameVar,numCell},
                        {newNameVar,numCell},...}}
    Initially, no output vars		   *)	      

  connexionStructure = Map[{First[#],{}} &,sys[[5]]];
  connexEq = {};
	       
  (* For each region *) 
  Do[ curRegion = listRegion[[i]];
    If[ verb, 
      Print["--- Building cell ",i," present on domain: ",
            ashow[curRegion[[1]],silent->True] ]
    ];
	       
    localOutputList={};
    localInputList={};
    cellOutputList={};
    cellInputList={};

    (*** 

      To get the outputs of the current cell we get all the output signals
      by scanning all the connexion equations and the Mirror Eq.  If the RHS
      of it happens on the current domain, then it is an output.

    *)

    domRegion = 
      DomExtend[curRegion[[1]], Prepend[curRegion[[1,2]],"t"]];

(* ===== *)
(*
dbg = True;
*)
    If[ dbg, Print["domRegion is :", ashow[domRegion, silent->True ] ] ];
 
    (* for each equation *)
    Do[ curEq = sys[[6,j]]; (* do1 --- *)

      Which[ 
        isConnexionEqQ[sys,curEq], (* if1 ---- *)

        (* We have a connection equation *)
        If[ dbg, Print["Examining connection equation: ", 
            ashow[ curEq, silent->True ] ] ];

         (* Building ouput from connexion  
           connexion equation in module is :
           Out = In.affine 
           in module, where In is produced in the
           current region thus In is output 
           from a cell, it will be named newIn as
           direct output :
           use {} ,... () return (newIn);
           Out = In.affine;
           In = case 
           {...} newInt 
           ...
           ,
           we add NewIn in the cellOutput and localvars,
           we set out and In as local vars, we set 
           the connexion equation as local eq 
         *) 

        (*       --> here, rhs is In  *)
        
        (* Compute the domain of the rhs expression *)
        rhsExpDom = expDomain[sys,curEq[[2,1]]];

        (* And its context domain *)
        rhsContextDom = getContextDomain[sys,{6,j,2,1,1}];

        (* And finally, their intersection *)
        Check[rhsDom = DomIntersection[rhsExpDom,rhsContextDom],
          Throw["Error1"]
        ];	      

        (* Check the dimensions *)
(*
        If[ rhsDom[[1]]!=domRegion[[1]],
          ashow[ rhsDom ]; ashow[ domRegion ];
          alpha0TOalphard::dimPb1 = 
	  "The dimension of the rhs domain is different from that of region";
          Throw[ Message[alpha0ToAlphard::dimPb1] ]
        ];
*)
      
        (* Compute the intersection *)
        If[ rhsDom[[1]] === domRegion[[1]], 
          domInter = DomIntersection[rhsDom,domRegion],
          domInter = DomEmpty[1]  (* Force empty domain *)
        ];	    

        If[ dbg , Print[ "Domain of rhs: ", 
                          ashow[rhsDom, silent->True ] ] 
        ];

        If[ dbg , Print[ "Domain of the region: ", 
                          ashow[domRegion, silent->True ] ] 
        ];

        If[ dbg, Print[ "Domain intersection: ", 
                          ashow[domInter, silent->True ] ] 
        ];

        If[ dbg&&DomEmptyQ[domInter], Print["Empty intersection..."]];

        If[ !DomEmptyQ[domInter], (* if2 *)
          (* If the intersection is not empty, add the
             rhs to the in *)
          localIn = getPart[sys,{6,j,2,1,1}];
          If[ dbg, Print[ "New local input: ",localIn ] ];
          localOut = getPart[sys,{6,j,1}];
          If[ dbg, Print[ "New local output: ",localOut ] ];

          (* Add connexion eq as local equation *)
          connexEq = Append[ connexEq, curEq];

          (* set In as local Var of module*)
          localModuleVar = Append[localModuleVar,localIn];

          (* Add in as a local declaration of module and 
             cell *)
          localDecl = getDeclaration[sys,localIn];

          localModuleDecl = Append[localModuleDecl,localDecl];

          (* set new In as local var *)
          newIn = getNewName[Join[{sys},$library], localIn<>ToString[i]];
          localModuleVar= Append[localModuleVar,newIn];

          (* the domain of the newIn is the 
             intersection of Dom of In and the
             current region domRegion *)

          newDom = DomIntersection[rhsExpDom,domRegion];

          localModuleDecl =  Append[localModuleDecl,
				    Alpha`decl[newIn,
					       localDecl[[2]],
					       newDom]];

          (* set out as local var *)
          localModuleVar= Append[localModuleVar,localOut];
          localOutDecl=getDeclaration[sys,localOut];
          localModuleDecl = Append[localModuleDecl,localOutDecl];

          (* update the connexion structure, add
             newIn in the In field *)
          posInConnexion = Position[connexionStructure, {localIn,_}];
   
          If[ Length[posInConnexion]=!=1, 
            Message[alpha0ToAlphard::pb2,localIn] ];

          connexionStructure = ReplacePart[connexionStructure,
            Append[connexionStructure[[posInConnexion[[1,1]],2]],
                  {newIn,i}],
                  {posInConnexion[[1,1]],2}];

          (* set newIn in the output of the current
             cell *)
          localOutputList=Append[ localOutputList,newIn ];
          cellOutputList=Append[ cellOutputList,localIn ];
        ];(* end DomEmptyQ if2 *)
			 
        (* Building input from connexion  *)

        (* The connexion equation is 
            Out=In.affine 
            where In.affine is produced in
            in the current region  
            Out is input in the current cell 
            Out is NOT set as local var /already done/
            Out=In.affine is NOT set as local eq /already done/
            here, rhs is In.affine *)

        rhsExpDom = expDomain[sys,curEq[[2]]];
        rhsContextDom = getContextDomain[sys,{6,j,2}];

(*
        If[ rhsDom[[1]]!= domRegion[[1]], 
             ashow[ rhsDom ]; ashow[ domRegion ];
             Throw[ Message[ alpha0ToAlphard::dimpb ] ]
        ];
*)

        Check[
          rhsDom = DomIntersection[rhsExpDom,rhsContextDom],
          Throw[ Message[ alpha0ToAlphard::intersectionpb ] ]
        ];

        If[ rhsDom[[1]] === domRegion[[1]], 
          domInter = DomIntersection[ rhsDom, domRegion ],
          domInter = DomEmpty[1]
        ];

        If[ dbg&&DomEmptyQ[domInter], Print["Empty intersection..."]];

        If[ !DomEmptyQ[domInter],
          (* connexEq=Append[connexEq,curEq]; *)
          newIn=getPart[sys,{6,j,1}];
          localInputList=Append[ localInputList,newIn];
          cellInputList=Append[ cellInputList,newIn];
        ]
      ,(* End If isConnextionEqQ if1 *)

      (* A mirror equation *)
      (isMirrorEqQ[sys,curEq,controlSignals]), (* if3 *)
        If[ dbg, Print["Examining mirror equation: ", 
            ashow[ curEq,silent->True ] ] ];

(*
        dbg = True;
*)
        (* Building output from Mirror *) 
        If[ MemberQ[getOutputVars[sys],curEq[[1]]], (* if4 *)

          (* outVar = localOutVar.affine in module, 
           +> localOutVari is output from the ith cell,
           equation outVar = localOutVar.affine 
           is kept and 
           equation localOutVar =
             case 
               localOutVar1
               ...
	     esac
           is added 
         *)

          rhsExpDom = expDomain[ sys, curEq[[2,1]] ];
	    (* modified by Tang 27 11 2001 
	       rhsContextDom = getContextDomain[sys,{6,j,2}];*)
          rhsContextDom = getContextDomain[sys,{6,j,2,2}];
	    (* If[dbg,Print["rhsExpDom",show[rhsExpDom]]];
	       If[dbg,Print["rhsContextDom",show[rhsContextDom]]]; *)

          If[ rhsExpDom[[1]] != rhsContextDom[[1]], 
            show[rhsExpDom];show[rhsContextDom];
            alpha0ToAlphard::domPb = "dimensions are different";
            Throw[ Message[ alpha0ToAlphard::domPb ] ]
          ]; 

          rhsDom = DomIntersection[rhsExpDom,rhsContextDom];

          If[ rhsDom[[1]] === domRegion[[1]],
            domInter=DomIntersection[ rhsDom, domRegion ],
            domInter = DomEmpty[1] (* Force empty domain *)
          ];

          If[ dbg&&DomEmptyQ[domInter], Print["Empty intersection..."]];

          If[ !DomEmptyQ[domInter], (* if5 *)
            connexEq = Append[connexEq,curEq];
            localIn = getRhsOfMirror[sys[[6,j]]];

            If[ dbg, Print["Local in: ", localIn ] ];

            newIn = getNewName[Join[{sys},$library],
	      localIn<>ToString[i]];

            localModuleVar =
              Append[localModuleVar,localIn];

            localDecl = getDeclaration[sys,localIn];
            localModuleDecl = 
              Append[localModuleDecl,localDecl];

            localModuleVar = Append[localModuleVar,newIn];
            localModuleDecl =  Append[localModuleDecl, 
                Alpha`decl[newIn,
                localDecl[[2]],
                domInter]];

            posInConnexion = 
              Position[connexionStructure,
                {localIn,_}];

            If[ Length[posInConnexion]=!=1,
              Message[alpha0ToAlphard::pb3,localIn]];
            connexionStructure = 
              ReplacePart[connexionStructure,
                Append[connexionStructure[[posInConnexion[[1,1]],2]],
                     {newIn,i}],
               {posInConnexion[[1,1]],2}];

            (* It may happen that this variable 
               has already been set as output of the cell
               because of a connexion Equation *)
            If[ !MemberQ[localOutputList,newIn],
              localOutputList = Append[localOutputList,newIn];
              cellOutputList = Append[cellOutputList,localIn]
            ];
          ];(* end DomEmptyQ if5 *)
 
        ]; (* end Building output Mirror --- if4 --- *) 
			   
        (* Building input from Mirror *)
        rhsMirror = getRhsOfMirror[sys[[6,j]]];
        lhsMirror = getPart[sys,{6,j,1}];

        If[ (MemberQ[getInputVars[sys],rhsMirror]||
          MemberQ[controlSignals,rhsMirror]),  (* if6 *)

          If[ dbg, Print[rhsMirror, " is a potential input"] ];

          (* Out=In --> here, rhs is In
            Out is input in the cells *)
          rhsExpDom = expDomain[sys,curEq[[2]]];
          rhsContextDom = getContextDomain[sys,{6,j,2}];

          rhsDom = DomIntersection[rhsExpDom,rhsContextDom];
          If[ dbg, Print["Domain of rhs: ", 
			 ashow[ rhsDom, silent->True ] ] ];

          If[ rhsExpDom[[1]] === domRegion[[1]],
            domInter = DomIntersection[ rhsDom, domRegion],
            domInter = DomEmpty[ 1 ] (* Force domain to be empty... *) 
	  ];
          If[ dbg, Print["Domain inter: ", 
			 ashow[ domInter, silent->True ] ] ];

          If[ dbg, 
            If[ DomEmptyQ[domInter], 
	      Print["Empty intersection..."], Print["Not empty"] ]
          ];

          If[ !DomEmptyQ[domInter], (* if7 *)
            connexEq=Append[connexEq,curEq];
            (* It may happen that this variable 
              has already been set as output of
              the cell
              because of a connexion Equation *)

            If[ !MemberQ[localInputList,lhsMirror],
              cellInputList=
                Append[cellInputList,lhsMirror];
              localInputList=
                Append[localInputList,lhsMirror]];
              localModuleVar=
                Append[localModuleVar,lhsMirror];
              localModuleDecl = 
              Append[localModuleDecl,getDeclaration[sys,lhsMirror]
            ];
          ](* end if DomEmpty if7 *)
        ] (* end input Mirror if6 *) 
      , (* end MIrrorQ if3 *)
        (* Other cases *)
        True,
        If[ dbg, Print["Equation: ", ashow[ curEq,silent->True ],
		      " not considered..."] ];
      ]; (* End of Which *)

      ,{j,1,Length[sys[[6]]]}
    ]; (* End Do loop --- do1 --- *)

   localModuleVar = removeDoubleVar[localModuleVar];
   localModuleDecl = removeDoubleDecl[localModuleDecl];
   localOutputList = removeDoubleVar[localOutputList];
   localInputList = removeDoubleVar[localInputList];
   cellOutputList = removeDoubleVar[cellOutputList];
   cellInputList = removeDoubleVar[cellInputList];

   curName = "cell"<>sys[[1]]<>ToString[i];

   If[ verb,
     Print["---- Cell name: ", curName ];
     (* Print["   control: ",controlSignals]; *)
     Print["---- Inputs: ", localInputList];
     Print["---- Outputs: ", localOutputList]
   ];

    If[ Length[cellOutputList]===0,
      If[ !muteOpt,
        Print["alphaToAlphard::warning: cell ",curName,
         " has no output and is not generated." ] ],
      If[ dbg, 
        Print[ curName ]; Print[ curRegion[[1]] ]; Print[ curRegion[[2]] ] ];

      curCell =
        buildOneCell[sys,
          curName,
          curRegion[[1]],
          curRegion[[2]],
          controlSignals,
          cellInputList,
          cellOutputList
         (*,  options*) ];

    If[ dbg, Print[".... cell ",   curName , " built "]];


     realInput = Map[First,curCell[[3]]];
(*     controlSignalsInput = Intersection[controlSignals,realInput]; *)
(* Intersection is sorting the result, which is not wanted *)
    controlSignalsInput={};
    Do[ If[ Cases[realInput,controlSignals[[i]],Infinity]=!={},
     controlSignalsInput=Append[controlSignalsInput,controlSignals[[i]]]],
       {i,1,Length[controlSignals]}
    ];

     curUse = 
       use[curName,
           curRegion[[1]],
           (* j,N -> j,N *) 
           idMatrix[curRegion[[1,2]],curRegion[[1,2]]],
             Map[
               var[#] &,
               Join[localInputList,controlSignalsInput ]],
               localOutputList
       ];

     (* show[curUse]; *)
     useList = Append[useList,curUse];
     listCell=Append[listCell,curCell]
   ] (* end If Length ... *)
  ,{i,1,Length[listRegion]}]; (* end for each region *)

   (*********  building new module ***********
      ** Building connexion equations ** *)
 
    Do[ curConnexion = connexionStructure[[i]];
    If [dbg, Print["studying connexion: ",curConnexion]];
      (* redundancy problems *) 
      curConnexion=ReplacePart[curConnexion,
        Union[curConnexion[[2]]],
        2];
     If[ Length[curConnexion[[2]]]>0,
       curDecl=getDeclaration[sys,curConnexion[[1]]];
       (* the cur var is a connexion variable,
          for each mirror var, it is declared on the 
          domain of the corresponding region *)

       (* for each region concerned *)
          domCurVar=Part[curDecl,3];
          curListRestrict = {};
       Do[ curCurName = curConnexion[[2,j,1]] ;
         curCurRegion =  curConnexion[[2,j,2]];
         domRegion = 
           DomExtend[
             listRegion[[curCurRegion,1]],
               Prepend[listRegion[[curCurRegion,1,2]],"t"]];
           domInter = 
             DomIntersection[domRegion,domCurVar];
           curListRestrict = 
             Append[curListRestrict,
               restrict[domInter,var[curCurName]]];
          ,{j,1,Length[curConnexion[[2]]]}];

        connexEq = Append[connexEq,
           equation[curConnexion[[1]],case[curListRestrict]]]
                   ]
     ,{i,1,Length[connexionStructure]}];
    If [dbg, Print["studying connexion done "]];
   	 
    (* removing equations counted twice, this should 
       not appear but it does indeed ! *) 
       connexEq = Union[connexEq];
		
    newModule = 
      system[sys[[1]], sys[[2]], sys[[3]], sys[[4]],
             localModuleDecl,
             Join[connexEq,useList]];

  (* *********** *)
  (* I am not sure that these functions work properly... *)
  newModule = simplifyConnexions[newModule];
  newModule = convexizeAll[newModule];
  (* *********** *)
  If[ dbg, Print["The new module is: ", ashow[newModule, silent->True]] ];
  res = Append[listCell,newModule];
  If[ verb,
      Print["-- Adding local variables in library for isolating output pins"]];

  res = isolateOutputList[res, debug -> True]

];


(* simplify connection which are in form 
   BOut = Case 
         D1 : Bout1[t,p]
	 D2 : Bout2[t,p]
	 esac
   Bin=Bout[t,p-1]

   into 
   Bin = Case 
         D1+[0,1] : Bin1[t,p-1]
	 D2+[0,1] : Bout2[t,p-1]
	 esac
*)
Clear[simplifyConnexions];

simplifyConnexions[]:=
  Module[{res},
	 res=simplifyConnexions[$result];
	 If [MatchQ[res,Alpha`system[___]],
	     $program=$result;
	     $result = res];
	res];
	    
simplifyConnexions[sys_Alpha`system]:= 
Module[{curSys,rhsVar,lhsVar},
  (* Save sys *)
  curSys = sys;

  (* For all equation that is a connection *)
  Do[ curEq = sys[[6,i]];
    If[ isConnexionEqQ[curSys,curEq],
	(*
	Print[ "Connection equation: ", ashow[ curEq , silent -> True ]];
	 *)
      lhsVar = curEq[[1]]; (* Get lhs of equation *)
      rhsVar = getPart[curEq,{2,1,1}]; (* Get rhs of equation *)

      If[ MemberQ[getLocalVars[sys],rhsVar],
	  (*
         Print[ "SubstituteInDef: ", lhsVar, " ", rhsVar ];
	   *)
         curSys = substituteInDef[curSys,lhsVar,rhsVar]
      ];

      curSys = removeUnusedVar[curSys,rhsVar]],
     {i,1,Length[sys[[6]]]}
  ];
  curSys = normalize[curSys];
  curSys
];
	      
simplifyConnexions[a___]:= Message[ symplifyConnexions::params ];


(* replace all occurence of Alpha`var[a___] which is not 
surrouneded by an Alpha`affine by Alpha`affine[Alpha`var,identity] *)

Clear[normalizeIdDepLib];

normalizeIdDepLib[lib1_List]:=
Module[{res},
  res = Map[normalizeIdDep,lib1];
  res
];

normalizeIdDepLib[]:=
Module[{res1,res},
  res1=normalizeIdDep[$result];
  If[ MatchQ[res1,Alpha`system[___]],
	     $result=res1];
  res=normalizeIdDepLib[$library];
  If[ MatchQ[res,List[___Alpha`system]], $library=res];
  res
];

normalizeIdDepLib[a___]:= Message[normalizeIdDepLib::params ];

Clear[normalizeIdDep];
normalizeIdDep[]:=
Module[{},
  res=normalizeIdDep[$result];
  If[ MatchQ[res,Alpha`system[___]],
    $program=$result;
    $result = res
  ];
  $result
];

normalizeIdDep[sys_Alpha`system]:=
Module[{},
  newEq = Map[normalizeIdDepInEq[sys,#] &, sys[[6]]];
  newSys = ReplacePart[sys,newEq,6]
];

normalizeIdDep[a___]:= Message[normalizeIdDep::params];

Clear[normalizeIdDepInEq];
normalizeIdDepInEq[eq_Alpha`equation]:=
  normalizeIdDepInEq[$result,eq];
normalizeIdDepInEq[sys_Alpha`system,eq_Alpha`equation]:=
Module[{curEq,posVarInEq,curPos,addId,nameVar,declVar,indicesVar,
  idMat},
  curEq=eq;
  posVarInEq = Position[eq,Alpha`var[___]];
  Do[ 
    curPos= posVarInEq[[i]];
    addId=False;
    If[ Length[curPos]===1,
       addId=True,
       If[!MatchQ[getPart[eq,Drop[curPos,-1]],Alpha`affine[___]],
		    addId=True,
		    addId=False]
    ];
    If[ addId,
       nameVar=getPart[eq,Append[curPos,1]];
       declVar = getDeclaration[sys,nameVar];
       If[ declVar==={},
         Message[normalizeIdDepInEq::error],
         indicesVar=declVar[[3,2]];
         idMat=idMatrix[indicesVar,indicesVar];
         curEq=ReplacePart[curEq,
				       Alpha`affine[Alpha`var[nameVar],
						    idMat],
				       curPos]
      ]
    ];
    ,{i,1,Length[posVarInEq]}
  ];
  curEq
];

normalizeIdDepInEq[use1_Alpha`use]:=
  normalizeIdDepInEq[$result,use1];

normalizeIdDepInEq[sys_Alpha`system,use1_Alpha`use]:=
  Module[{},
	 (* to be implemented *) 
	 use1];
normalizeIdDepInEq[a___]:= Message[ normalizeIdDepInEq::params ];


(* isolateOutput is a function that checks that the output 
   are not read in the Alphard code (which is forbidden in Vhdl) 
   and add a  local vairable if they are *)

Clear[isolateOutputList];
isolateOutputList[lib1_List, opts:___Rule]:=
Module[{res},
  res = Map[isolateOutput[#,opts]&,lib1];
  res
];

isolateOutputList[opts:___Rule]:=
Module[{res1,res},
  res1=isolateOutput[$result, opts];
  If[ MatchQ[res1,Alpha`system[___]],
    $result=res1];
    res = isolateOutputList[$library, opts];
    If[ MatchQ[res,List[___Alpha`system] ], $library=res];
  res
];

isolateOutputList[a___]:= Message[isolateOutputList::params ];

Clear[isolateOutput];
isolateOutput[opts:___Rule]:=
Module[{res1},
  res1 = isolateOutput[$result,opts];
  If[ MatchQ[res1,Alpha`system[___]], $result=res1];
  $result
];

isolateOutput[sys_Alpha`system,opts:___Rule]:=
Catch[
  Module[ {listOutput,tempSys,curOutput,posOutputVar,newName,dbg},
    listOutput = Map[First,sys[[4]]];

    tempSys=sys;

    Do[ 
      curOutput=listOutput[[i]];
      posOutputVar=Position[tempSys[[6]],Alpha`var[curOutput]];
      If[ Length[posOutputVar]=!=0,
        newName=getNewName[tempSys,curOutput<>"loc"<>ToString[i]];
        If[ dbg, Print["    Adding local variable: ", newName] ];
        tempSys = addlocal[tempSys, newName, Alpha`var[curOutput] ];
      ],
      {i,1,Length[listOutput]}
    ];

    tempSys
  ]
];
	   
isolateOutput[a___]:= 
  (Message[isolateOutput::WrongArg,a];Throw["ERROR"]);

(**** Independent functions for structuring programs ****)

Clear[buildSubsystemFrom]

buildSubsystemFrom[sys_Alpha`system,
		   nameNew_String,
		   domainUse_Alpha`domain,
		 nameIndices:List[___String],
		 listInputVar:List[___String],
		 listOutputVar:List[___String],
		 listLocalVar:List[___String]]:=
  Module[{listOldEq,listNewEq,listAllDecl,
	  listNewInput,listNewOutput,listNewlocal,
	  parameterNew,paramDom	  },
	 (* select the equation to project *) 
	 listOldEq=Select[sys[[6]],MemberQ[Union[listLocalVar,listOutputVar],
					   Part[#,1]] &];
	 listNewEq = Map[projectEquation[#,nameIndices] &,listOldEq];
	 listAllDecl=Union[sys[[3]],sys[[4]],sys[[5]]];
	 listNewInput =   Select[listAllDecl,
				 MemberQ[listInputVar,First[#]] &];
	 listNewOutput = Select[listAllDecl,
				MemberQ[listOutputVar,First[#]] &];
	 listNewlocal = Select[listAllDecl,
			       MemberQ[listLocalVar,First[#]] &];
	 (* parameterNew=Join[nameIndices,sys[[2,2]]];
	 paramDom=DomExtend[sys[[2]],parameterNew];
	 paramDom=DomIntersection[paramDom,domainUse];*) 
	 Alpha`system[nameNew,
		      domainUse,
		      listNewInput,
		      listNewOutput,
		      listNewlocal,
		      listOldEq]
       ]

buildSubsystemFrom[a___]:= Message[buildSubsystemFrom::wrongArg,a]

(* build use from build the use corresponding to the structuration 
   from given variables *)

Clear[buildUseFrom]

buildUseFrom[sys_Alpha`system,
	     nameNew_String,
	     domainUse_Alpha`domain,
	   nameIndices:List[___String],
	   listInputVar:List[___String],
	   listOutputVar:List[___String]]:=
  Module[{parameterNew,paramAssign,listInputExp},
	 parameterNew=Join[nameIndices,sys[[2,2]]];
	 paramAssign=idMatrix[parameterNew,parameterNew];
	 listInputExp=Map[Alpha`var[#] &,listInputVar];
	 Alpha`use[nameNew,
		   domainUse,
		   paramAssign,
		   listInputExp,
		   listOutputVar]
       ]


buildUseFrom[a___]:=  Message[buildUseFrom::wrongArg,a]

(* structureFrom structure an alpha program given a list of 
   indices and a list of variable (which will be computed in the
   subsystem *)
 
structureFrom[indices:List[___String]]:=
  module[{res},
	 res=structureFrom[$result,indices];
	 If [MatchQ[res[[2]],Alpha`system[___]],
	     $library=Prepend[$library,res[[1]]];
	     $result=res[[2]];
	     putSystem[$result];
	     $result,
	     Message[structureFrom::Failed];
	     $Failed]
       ]


structureFrom[sys_Alpha`system,indices:List[___String]]:=
  Module[{listStructVar},
	 (* structure with local vars *)
	   listStructVar=Map[First,sys[[5]]];
	 structureFrom[sys,indices,listStructVar]
       ]

structureFrom[indices:List[___String],listAllVars:List[__String]]:=
  module[{res},
	 newName = getNewName["Sub"<>$result[[1]]];
	 structureFrom[indices,listAllVars,newName]
       ]

structureFrom[indices:List[___String],listAllVars:List[__String],newName:_String]:=
  module[{res},
	 res=structureFrom[$result,indices,listAllVars,newName];
	 If [MatchQ[res[[2]],Alpha`system[___]],
	     $library=Prepend[$library,res[[1]]];
	     $result=res[[2]];
	     putSystem[$result];
	     $result,
	     Message[structureFrom::Failed];
	     $Failed]
       ]

structureFrom[sys_Alpha`system,
	      indices:List[___String],
	      listAllVars:List[__String]]:=
  Module[{newName},
	 newName="Sub"<>sys[[1]];
	 newName=getNewName[newName];
	 structureFrom[sys,indices,listAllVars,newName]
       ]

  structureFrom::indiceNotOK = "ERROR: the indices `1` are not in all 
domains (use renameIndices)"
structureFrom::domsNotOK = "ERROR: some domains have not the same
projection on `1` "

structureFrom[sys_Alpha`system,
	      indices:List[___String],
	      listAllVars:List[__String],
	      newName_String]:=
  Catch[
    Module[{listSubsystemDecl,listSubsystemIndices,
	    indiceInIndices,indicesOK, projectionDomVarSub,
	    firstDom,OtherDomEqual1,domsOK,extensionDom,
	    listSubsystemEquation,newSysLocalVars,varUsedInSubEq,listInputVars,
	    listNewSystemEq,varUsedInNewSys,listOutputVars,listLocalVars,
	    useAst,subSystem,newSysLocalDecl,newSysLocalEqs,listLocalEqVars},

	   (* Check that the name of indice is coherent *)

	     listAllOldDecl = Join[sys[[3]],sys[[4]],sys[[5]]];
	   listSubsystemDecl = Select[listAllOldDecl,
				      MemberQ[listAllVars,First[#]] &];
	   listSubsystemIndices = Map[getPart[#,{3,2}] &,listSubsystemDecl];
	   indiceInIndices = Map[Complement[#,indices]==={} &,
				 listSubsystemIndices];
	   indicesOK = Apply[And,indiceInIndices];
	   If [!indiceOK,
	       Message[structureFrom::indiceNotOK,indices];
	       Throw[{$Failed,$Failed}]];

	   (* Check that the indices are the last one for each
	      variable *)

	     Print["Warning: I assume that the indices ",indices,
		   " are in correct posistion (rightMost) in all
		   variable "];

	   (* checks that all var have same projection on indices *)

	       domainVarSubsystem = Map[Part[#,3] &,listSubsystemDecl];
	   projectionDomVarSub = Map[DomProject[#,Join[indices,sys[[2,2]]]] &,
				     domainVarSubsystem];
	   firstDom=projectionDomVarSub[[1]];
	   OtherDomEqual1 = Map[DomEqualQ[#,firstDom] &,
				projectionDomVarSub];
	   domsOK = Apply[And,OtherDomEqual1];
	   If [domsOK=!=True,
	       Message[structureFrom::domsNotOK,indices];
	       Map[show,projectionDomVarSub];
	       (* TODO: enumerate the vars (?) *)
		 Throw[{$Failed,$Failed}]];
	   extensionDom=firstDom;

	   (* Check that there are not dependencies on indices *)

	     Print["Warning: I assume that there are no dependencies  on",
		   indices," in the equations" ];

	   (* Tests OK *) 

	       Print["Tests OK, starting Structuring ... "];

	   (* Get Input variables of subsystem (used in but not in
	   listAllVars) *)

	     listSubsystemEquation = 
	       Select[sys[[6]],
		      MemberQ[listAllVars,Part[#,1]] &];
	   varUsedInSubEq=Cases[listSubsystemEquation,
				Alpha`var[_],
				Infinity];
	   listInputVars = Complement[Map[First,varUsedInSubEq],
				      listAllVars];

	   (* list Output Vars (used outside or output of original system)*)

	     listNewSystemEq = 
	       Select[sys[[6]],
		      Not[MemberQ[listAllVars,Part[#,1]]] &];
	   varUsedInNewSys = Cases[listNewSystemEq,
				   Alpha`var[_],
				   Infinity];
	   listOutputVars= Union[Intersection[Map[First,varUsedInNewSys],
					      listAllVars],
				 Map[First,sys[[4]]] (* output vars *) ];

	   (* listLocalVars: other vars  *)

	     listLocalVars =Complement[listAllVars,
				       listOutputVars];

	   Print[" Building use .... "];
	   useAst = buildUseFrom[sys,
				 newName,
				 extensionDom,
				 indices,
				 listInputVars,
				 listOutputVars];

	   Print[" Building Subsystem .... "];
	   subSystem = buildSubsystemFrom[sys,
					  newName,
					  extensionDom,
					  indices,
					  listInputVars,
					  listOutputVars,
					  listLocalVars];

	   Print[" Building new system .... "];
	   newSysLocalVars=Complement[listAllVars,listOutputVars];
	   newSysLocalDecl= Select[sys[[5]],
				   Not[MemberQ[newSysLocalVars,
					    First[#]]] &];
	   listLocalEqVars=Complement[Map[First,newSysLocalDecl],
				      listOutputVars];
	   newSysLocalEqs= Select[sys[[6]],
				  MemberQ[listLocalEqVars,
					  First[#]] &];
	    newSysLocalEqs=Append[newSysLocalEqs,
				  useAst];
	   newSystem= Alpha`system[sys[[1]],
				   sys[[2]],
				   sys[[3]],
				   sys[[4]],
				   newSysLocalDecl,
	   newSysLocalEqs];
{normalize[removeIdEqus[subSystem]],
	   normalize[removeIdEqus[newSystem]]}
	   ]
    ]

structureFrom[a___]:=  Message[StructureFrom::wrongArg,a]

alphardTimeLife[]:= 
Catch[
  Module[{res,unionOfRes},
    (* This test is to cover the case when the library contains
       only one controller *)
    If[ Length[ $library ] <= 1, 
      alphardTimeLife::nolib = "alphardTimeLife::warning::$library has only one module"; 
      Print[ alphardTimeLife::nolib ];
      Check[ res = {alphardTimeLife[$result]} , 
        Throw[ Message[alphardTimeLife::error] ] ],
      Check[ res = Map[alphardTimeLife, Drop[$library,-1] ], Throw[Null]]
    ];
    unionOfRes = 
      Fold[DomUnion, res[[1]], res];
    unionOfRes
  ]
];
  
alphardTimeLife[lib:List[___Alpha`system]]:=
  Module[{},
	 Map[alphardTimeLife,lib]] 

alphardTimeLife::Warning = "your system does not seem to be part of an
Alphard system";

alphardTimeLife[sys:_Alpha`system]:=
Catch[
  Module[{nbPar,nbTime,nbSpace,allDecl,oneDecl,checkFirstIndex,
    allDomains,allProjectedDomains,unionOfAllDom},

    sys1 = addAllParameterDomain[sys];
    nbPar = sys1[[2,1]];
    oneDecl = Which[Length[sys1[[3]]]>=1,sys1[[3,1]],
      Length[sys1[[4]]]>=1,sys1[[4,1]],
      Length[sys1[[5]]]>=1,sys1[[5,1]],
      True,Message[alphardTimeLife::Warning]
    ]; 

    (* No multi dimensionnal time *)
    nbTime=1;
    nbSpace=oneDecl[[3,1]]-nbTime;
    (* If[ nbSpace<0 || nbSpace>2,
	     Message[alphardTimeLife::Warning2]]; *)
    allDecl=Join[sys1[[3]],sys1[[4]],sys1[[5]]];
    checkFirstIndex=Union[Map[getPart[#,{3,2,1}] &, allDecl]];
    If[ Length[checkFirstIndex]=!=1,
      Message[alphardTimeLife::Warning,checkFirstIndex],
      (* else, perform the projection *)
      allDomains=Map[Part[#,3] &,allDecl];
      allProjectedDomains=Map[DomProject[#,checkFirstIndex] &,
				     allDomains];
      unionOfAllDom= Fold[DomUnion,
        allProjectedDomains[[1]],
        allProjectedDomains];
    ];
    convexize[unionOfAllDom]
  ]
];
alphardTimeLife::WrongArg="Wrong Argument for alphardTimeLife: `1`";
alphardTimeLife[a___]:=Message[alphardTimeLife::WrongArg,a];
 
Clear[alphardFirstStep];

alphardFirstStep[]:=
Catch[
 Module[{dom1,bbDom1},
   Check[dom1=alphardTimeLife[],Throw[Null]];
   
   alphardFirstStep::error = 
   "error while calling getBoundingBox. First step assumed to be 0";

   bbDom1 = Check[ getBoundingBox[dom1], 
	     Throw[ Message[ alphardFirstStep::error ];0 ]];
   bbDom1[[1,1]]
   ]
];
alphardFirstStep::wrongArg=
"wrong Argument for function alphardFirstStep : `1` "

alphardFirstStep[a:___]:=Message[alphardFirstStep::wrongArg,Map[Head,{a}]]


Clear[setOutputVar]

setOutputVar[var1_String]:=
 Module[{res},
	  res=setOutputVar[$result,var1];
          If[MatchQ[res,Alpha`system[___]],
		  $result=res,$result]
       ]

setOutputVar::varNotFound="variable `1` not found in system `2`"
setOutputVar::notLocalVar="variable `1` must be a local variable in system `2`"

 setOutputVar[sys1:system[___],var1:_String]:=
    Module[{decl1,posDecl,res1,res2},
	  decl1=getDeclaration[sys1,var1];
          If [!MatchQ[decl1,decl[___]],
	      Message[setOutputVar::varNotFound,var1,sys1[[1]]];
              Return[sys1]];
          posDecl=Position[sys1,decl1];
          If[posDecl[[1,1]]=!=5,
	    Message[setOutputVar::notLocalVar,var1,sys1[[1]]];
            Return[sys1]];
          res1 = Delete[sys1, posDecl[[1]]];
          res2 = Insert[res1,decl1,{4,-1}];
	  res2
        ]

 setOutputVar::wrongArg="wrong Argument for function setOutputVar : `1` "

  setOutputVar[a:___]:=Message[setOutputVar::wrongArg,Map[Head,{a}]]
 

 Clear[insertFunction]

Options[insertFunction]={debug->False}

insertFunction[var1:_String, func1:_String,options___Rule]:=
Module[{res},
      res=insertFunction[$result,var1, func1, options];
If [MatchQ[res,Alpha`system[___]],$result=res,$result]
      ]

insertFunction[sys1:_,var1:_String, func1:_String,options___Rule]:=
Module[{},
      def1=getDefinition[sys1,var1];

If[def1=!={},
      newDef=Alpha`call[func1,{def1}],
      newDef=def1];
newSys=sys1/.(def1->newDef)
      ]

 insertFunction::wrongArg="wrong Argument for function insertFunction : `1` "
 insertFunction[a:___]:=Message[insertFunction::wrongArg,Map[Head,{a}]]

		


End[]
EndPackage[]


