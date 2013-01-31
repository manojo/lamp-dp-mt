(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : P. Quinton
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

BeginPackage[
  "Alpha`VertexSchedule`",
  {"Alpha`",
   "Alpha`Domlib`",
   "Alpha`Tables`",
   "Alpha`Matrix`",
   "Alpha`Options`", 
   "Alpha`Normalization`", 
   "Alpha`Static`", 
   "Alpha`Substitution`",
   "Alpha`Semantics`", 
   "DiscreteMath`Combinatorica`",
   "Graphics`Colors`"}];

(* Standard head for CVS

	$Author: trisset $
	$Date: 1997/02/18 09:20:01
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/VertexSchedule.m,v $
	$Revision: 1.1 $
	$Log: VertexSchedule.m,v $
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.28  2004/08/02 13:19:23  quinton
	Corrected generation of boolean expressions
	
	Revision 1.27  2004/07/12 12:08:17  quinton
	Corrected $runTime bug
	
	Revision 1.26  2004/06/09 15:25:54  quinton
	Corrections to the structured scheduler scd.
	Added a function adaptUses to add mirror inputs and outputs for the uses.
	
	Revision 1.25  2004/03/26 10:10:10  risset
	corrected a bug in depGraph (getVariables[] instead of getVariables[sys] and sortEquation
	
	Revision 1.24  2004/03/12 16:57:48  quinton
	New functions loadScheduleLibrary and saveScheduleLibrary that
	allow schedules to be saved in the same form as that in variable
	$scheduleLibrary. This allows structured scheduling. Note that schedules
	with symbolic values are now allowed.
	
	Revision 1.23  2003/09/12 11:56:21  quinton
	Minor correction.
	
	Revision 1.22  2003/07/16 13:40:27  quinton
	In vertexschedule.m, indroduction of function ishow to pretty print
	an imperative program. In fact, it appears that ashow does the
	job, but it does not print out aliases. Also, added functions
	DomDimension, DomTrueDimension, DomSingletonQ, and DomTrueDimension.
	Functions ishowhseq, getIndexes, dropIndexesDep etc should not
	be exported. Examples are in the notebook SingleAssign.
	
	Revision 1.21  2003/07/02 10:49:48  quinton
	Correction of a bug in the use of depGraph, after the modification
	done in the output of depGraph.
	
	Addition of a new option in depGraph. variables -> equations returns the
	dependence graph where the variables are given in the order of the equations
	(after the inputs). Combined with sortEquations, it allows a dependence
	graph to be obtained with the vertices in the topological order of the first
	index.
	
	Revision 1.20  2003/07/01 12:33:14  quinton
	VertexSchedule.m was modified in order to add new options to
	the depGraph function. Now, this function returns the pair
	formed by the variable list and the graph. Moreover, a variable
	option allows one to specify which subset of the variables
	are used in the graph, and the order of this list is
	significant. variable -> all, by default, works the usual
	way.
	
	Revision 1.19  2003/06/27 12:50:56  risset
	added the sortEquation function (that uses the depGraph function)
	
	Revision 1.18  2003/01/07 17:32:01  quinton
	Minor correction
	
	Revision 1.17  2001/09/03 06:20:17  quinton
	Modified to set the variable $runTime
	
	Modified also to eliminate uses with extensions, and check the format
	of $scheduleLibrary. Now check that the schedule in $scheduleLibrary
	was not produced by the farkas method.
	
	Revision 1.15  2001/08/16 16:12:12  quinton
	A few modifications
	
	Revision 1.14  2001/04/21 06:43:17  quinton
	Typo corrections
	
	Revision 1.13  2001/01/15 10:18:45  risset
	Removed the simplify Options of VertexSchedule, otherwise it
crushes the one of Cut.m
	
	Revision 1.12  2000/11/23 16:12:58  quinton
	*** empty log message ***
	
	Revision 1.11  1999/12/20 08:16:24  quinton
	Correction of a bug.
	
	Revision 1.10  1999/11/08 17:20:38  quinton
	Correction to depGraph
	
	Revision 1.9  1999/05/28 09:34:04  risset
	remove context Alpha of scheduleResult
	
	Revision 1.8  1999/05/18 16:24:31  risset
	change many packages for documentation
	
	Revision 1.7  1999/05/14 14:00:57  risset
	nothing
	
	Revision 1.6  1999/05/14 12:54:52  quinton
	Corrections to scd. Manual update with previous version.
	
	Revision 1.2  1999/04/15 13:18:40  quinton
	Options adjusted
	
	Revision 1.1  1999/03/31 15:38:22  quinton
	This package contains the structured scheduler. Replaces the Goodies.m
	package.
	
	Revision 1.6  1999/03/26 17:11:27  quinton
	Addition of function depGraph, depCycles, constOf, valueOf, slackOf
	
	Revision 1.5  1999/03/02 15:49:19  risset
	added GNU software text in each packages
	
	Revision 1.4  1998/09/25 15:18:31  quinton
	*** empty log message ***
	
*)

VertexSchedule::note = "Documentation revised on August 1st, 2004.";

VertexSchedule::usage = 
"The Alpha`VertexSchedule` package is one of the two scheduling packages
of MMAlpha. Functions of the Alpha`Schedule` package should be preferred,
but in some cases, VertexSchedule offers some interesting functionalities.
Symbols defined in this package are $dependencyConstraints, 
$optimalityConstraints, $scheduleDepTable, $scheduleLibrary, 
$scheduleMDSol. Functions are checkSchedOptions, constOf, depComponents,
depCycles, depGraph, DomDimension, DomSingletonQ, DomTrueDimension,
eliminateVar, encodeSchedule, equations, ishow, isIndentityOnDim,
getLinPart, getUseSchedule, loadScheduleLibrary, matrixTransPart, 
polDomainQ, timeMinSchedConstraints, saveScheduleLibrary, scd, slackOf,
sortEquations, zpolDomainQ
";

$dependencyConstraints::usage = 
"$dependencyConstraints contains the  dependency constraints used for
solving the scheduling. It is a list whose entries correspond directly
to the entries of the deptable. The last element is the set of
dependency variables. This global variable is set when calling the
scheduleConstraints  function";

$optimalityConstraints::usage = 
"$optimalityConstraints contains the  optimality (total time, etc)
constraints used for solving the scheduling. It is a list, whose
entries are pairs {variables, constraints}. This global variable is set
by the timeMinSchedConstraints function";

$scheduleDepTable::usage = 
"when set, $scheduleDepTable containts the dependency table of $result. It is
computed by a call to scd.";

$scheduleLibrary::usage = 
"$scheduleLibrary containts the schedules found by the scheduler when
called on the elements of the current library. These schedules are used
when the scheduler is called with the structured option";

$scheduleMDSol::usage = 
"$scheduleMDSol is an array which gathers information during a call to 
the scd function. $scheduleMDSol[i] contains a list {o,c,v,sol}
consisting  of the objective function, constraints, variables, and
solution to the linear problem solved when dealing with dimension i of
the schedule. For a unidimensional schedule, only level 1 is set. For a
dataflow schedule, level 1 corresponds to  the dataflow leve, and other
levels to the multidimensional schedule of the  inside indexes.";

adaptUses::usage = 
"adaptUses[] modifies all use statements, by adding extra input 
equations";

(*
adaptOneUse::usage = "";
*)

addSchedule::usage = 
"addSchedule is an option of loadScheduleLibrary. Default value is 
True. If True, the schedule contained in file sys.scdlib is added
to $scheduleLibrary, where it replaces a previous schedule for the
current system.";

affineDepConsts::usage = "exported for debugging purposes.";
Options[affineDepConsts] =
 { boundedDelay->False, verbose -> False, debug -> False,
   dependenciesOnly -> False, verticesPositive->False };

checkSchedOptions::usage = 
"checkSchedOptions[options] checks the options against the 
options of scd"; 

constOf::usage = "constOf[symbol] gives the value of symbol";

depComponents::usage = 
"depComponents[] computes the strongly connected components of 
the dependence graph";

Options[ depComponents ] := 
    { silent -> False, debug -> False, verbose -> False, extraEdges -> {}, 
      durations -> {}, eliminatesDoubles -> False };

depCycles::usage = 
"depCycles[] computes the elementary cycles in the dependence graph. 
depCycles[ selfDep->False ] computes the elementary cycles, 
without the self dependences";

Options[ depCycles ] := 
    { silent -> False, debug -> False, verbose -> False, extraEdges -> {}, 
      durations -> {}, eliminatesDoubles -> False, selfDep -> True };

depGraph::usage = 
"depGraph[] computes the dependence graph of $result in the format
of the Combinatorica package. This function assumes that the dependence
graph has already been computed.";

Options[ depGraph ] := 
    { silent -> False, debug -> False, verbose -> False, extraEdges -> {}, 
      durations -> {}, eliminatesDoubles -> False, 
      labelSize -> 0.1, labelFactor -> 1.2, onlyIdDep->False,
      variables -> all };

DomDimension::usage = 
"DomDimension[d] gives the dimension of domain d, including the 
parameter dimension (see DomTrueDimension to get the dimension 
with de parameter dimension)";

DomSingletonQ::usage = 
"DomSingletonQ[sys, d] is True if the true dimension of d is 0 and 
if d is the universal domain. DomSingletonQ[d] is equivalent to 
DomSingletonQ[$result,d]"; 

DomTrueDimension::usage = 
"DomTrueDimension[sys,d] gives the dimension of domain d less the 
dimension of the parameter space of sys. DomTrueDimension[d] is 
equivalent to DomDimension[$result,d]";

eliminateVar::usage = 
"eliminateVar[v] removes variable v, after checking that the variable
is useless"; 

Options[ eliminateVar ] = {normalizeSystem -> True, alphaFormat -> Alpha0};

encodeSchedule::usage = 
"encodeSchedule[sys, params, sol, opts] returns the encoding of the
schedule sol of system sys, with parameters params, using options opts.
Among the options of encodeSchedule, one option allows one to choose
between the Farkas format and the Vertex format";

equations::usage = 
"equations is an option value of the option variables of depGraph. If 
True, the variables of are ordered in the order given by the equations, 
with input first.";

ishow::usage = 
"ishow[] pretty-prints $result, without calling the external C 
program. It supports some features of the imperative form (such as
aliases) which ashow does not support.";
(*
ishowhseq::usage = "";
ishowvseq::usage = "";
*)

isIdentityOnDim::usage="isIdentityOnDim[mat,{1,3}] (for instance) 
checks that matrix mat1 is identity on dimension 1 and 3"

getLinPart::usage = 
"getLinPart[m] computes the mma form of the linear part of the Alpha
matrix m, considered as an affine function. Note: use getLinearPart
instead.";
getLinPart::params = "called with wrong parameters";

getUseSchedule::usage = 
"getUseSchedule[ x ] obtains the schedule of the use entry of a dependency table x,
by looking in the global variable $scheduleLibrary.";

(*
gp::usage = 
"gp[g,n] computes the n-th power of graph g. This is different from GraphPower which makes the union of the power of a graph"; 
*)

loadScheduleLibrary::usage =
"loadScheduleLibrary[sys] loads in global variable $scheduleLibrary 
the content of the file sys.scdlib";

Options[ loadScheduleLibrary ] = 
  { addSchedule -> True, parameterRules -> {} };

matrixTransPart::usage = 
"matrixTransPart[m] computes the mma form of the translation part of
the Alpha matrix m, considered as an affine function.";
matrixTransPart::params = "called with wrong parameters";

"parameterRules is an option of loadScheduleLibraty. Default value
is {}. It contains replacement rules for the parameters."

periodicFactor::usage = 
"periodicFactor is an option of getUseSchedule. Its default value is 1."<>
"The first parameter of the schedule of a subsystem is multiplied by"<>
"factor";

saveScheduleLibrary::usage =
"saveScheduleLibrary[sys] saves in global variable $scheduleLibrary 
the content of the file sys.scdlib";

Options[ saveScheduleLibrary ] = { onlyMainSystem -> False };
onlyMainSystem::usage = 
"onlyMainSystem is an option of saveScheduleLibrary. If True, only 
the schedule of the system in $result is saved, otherwise (default)
all schedules in $scheduleLibrary are saved."

timeMinSchedConstraints::usage = 
"timeMinSchedConstraints[] computes the constraints needed to minimize
the total execution time of
$result. timeMinSchedConstraints[var_String] computes only the
dependence constraints for variable var. Options of
timeMinSchedConstraints are sameLinearPart (default False),
addConstraints ({}) and verbose (False).";

timeMinSchedConstraints::params = "called with wrong parameters.";
timeMinSchedConstraints::norm = "input system is not normalized.";
timeMinSchedConstraints::emptyprog = "input system empty.";

Options[timeMinSchedConstraints] = 
       {scheduleType->affineByVar, 
	verbose -> False, 
        onlyVars -> all,
        reuseSchedule -> False, 
        onlyEquations -> all,
        addConstraints -> {}, 
        verticesPositive -> False, 
	depComputed -> False, 
        dataFlow -> False};

(* *)
saveSchedule::usage = 
"saveSchedule is an option of scd. If True, $schedule is saved in 
file sys.scd, where sys is the name of the scheduled system.";

(* scd *)
scd::usage = 
"***scd[] finds out the schedule that minimizes the total computation time
for a bounded Alpha program. Fails if the system is not bounded. scd can 
also be used to find a multidimensional schedule, or a dataflow schedule.
An option allows a structured schedule to be found.";

Options[scd] = 
  {
   verbose -> False, 
   debug -> False, 
   onlyEquations -> all,
   onlyVars -> all,
   resolutionSoft -> MMA, (* ou PIP, ou LpSolve *)
   integerSolution -> True, (* not relevant *)
   addConstraints -> {},  (* done *)
   durations -> {},
   periods -> {},
   durationByEq -> True,  (* A faire *)
   (* simplifySystem -> False,  Simplify system of inequalities *)
   onlyDep -> all, (*  *)
   scheduleType -> affineByVar, (* sameLinearPart *)
   optimizationType -> time, (* Null, delay *)
   objFunction -> lexicographic, (* a function *)
   verticesPositive -> False, (* Signaler verticesPositive *)
   subSystemSched -> $scheduleLibrary, 
   multidimensional -> False, 
   depComputed -> False,
   dataFlowVariables -> all, 
   dataFlowConstantsNull -> True, 
   dataFlow -> False, 
   reuseSchedule -> False, 
   dataFlowPeriod -> 1,
   subSystems -> True, 
   dataFlowObjective -> Null,
   eliminatesDoubles -> False,
   saveSchedule -> False
 };

(* A function that calls the simplex method *)
simplex::usage = 
"simplex[o,c,v] finds the minimum of function o on contraints c (list) 
for list of variables v. Variables are not assumed to be linear"; 

Options[simplex] = { minimize->True, verbose->True };

Options[scheduleConstraints]=
      { scheduleType->affineByVar, 
        verbose->False,
        addConstraints->{},
	multidimensional -> False, 
        verticesPositive -> False, 
	dependenciesOnly -> False, 
        onlyEquations -> all,
        onlyVars -> all,
        onlyDep -> all, 
        debug -> False,
	depComputed -> False, 
        durations -> {}, 
        reuseSchedule -> False, 
        subSystems -> True, 
        eliminatesDoubles -> False,
        dataFlow -> False };

Options[ eliminateVar ] = {verbose -> False, debug -> False };

Options[ locateEliminations ] = { verbose -> False };

slackOf::usage = 
"slackOf[listOfConstraints] gives the difference between the lhs and 
the rhs in the constraints, using the solution contained in $scheduleMDSol[1].
This function allows somehow to explore a given schedule."; 

(*
slg::usage = 
"slg[g] shows graph g. slg[g,Directed] shows g as a directed graph.
This function is a slight modification of ShowLabeledGraph.";
*)

sortEquations::usage=
"sortEquations[sys:_system] returns a the same system where the equation 
have been reordered in such a way that all computation executed 
simultaneously (with duration 0) can be executed in the textual order,
it currently assumes that the time is one dimensionnal and the first indice."

(*
getIndexes::usage = "";
dropIndexesDep::usage = "";
dropIndexesDom::usage = "";
*)

zpolDomainQ::usage = 
"zpolDomainQ[d] is true if d is a domain with z-polyhedra";

(* ===================== Private definitions ===================== *)

Begin["`Private`"]
 
(* *)
Clear[adaptOneUse];
(* adaptOneUse applies to an equation. Returns {} if this is
  not a use statement. If it is a use statement, returns a list
  of new inputs, and a new use statement *)
adaptOneUse[ eq:_equation, {i:_Integer} ]:= {{}, {eq}};
adaptOneUse[ eq:_use, {i:_Integer} ]:= 
Module[ {inputs, newInputs, newEquations, newUse, newDecls}, 
  (* Get the input expressions of the use *)
  inputs = eq[[4]];
  (* Create new inputs, one for each input of the use *)
  newInputs = 
    Table[ "adaptIn"<>ToString[i]<>ToString[k], {k,1,Length[inputs]} ];
  (* Create additional equations *)
  newEquations = 
    MapThread[ equation[ #1, #2 ]&, {newInputs, inputs} ];
  (* Change the use *)
  newUse = ReplacePart[ eq, Map[ var[#]&, newInputs ], 4 ];
  (* Get the new declarations of inputs *)
  newDecls = MapThread[ decl[#1, expType[#2], expDomain[#2] ]&, 
		    {newInputs, inputs} ];
  (* Returns the list of new declarations, and the list of 
     equations and use *)
  {newDecls, Append[ newEquations, newUse ]}
];	
adaptOneUse[___] := Message[ adaptOneUse::params ];
	     
(* *)
Clear[adaptUses];
adaptUses[] := 
Catch[
  Module[ {res},
    Check[
      res = adaptUses[$result],
      adaptUses::failure = "could not adapt uses";
      Throw[Message[ adaptUses::failure]]
    ];
    $result = res
  ]
]
adaptUses[sys:_system]:=
Catch[
  Module[ { eqs, temp, newEqs, newDecls },
    (* Get the equations *)
    eqs = sys[[6]];
    (* This returns a list of pairs newdeclarations, newuses *)
    temp = MapIndexed[ adaptOneUse, eqs ];
    (* Gather all first members, and join in order to obtain 
       the new declarations *)
    newDecls = Apply[ Join, Map[ First, temp ] ];
    (* Same for equations *)
    newEqs = Apply[ Join, Map[ Last, temp ] ];
    (* Return new system *)
    system[ sys[[1]], sys[[2]], sys[[3]], sys[[4]],
	    Join[ sys[[5]], newDecls ],
	    newEqs ]
  ]	  
];
adaptUses[___] := Message[ adaptUses::params ];

(* *)
Clear[ saveScheduleLibrary ];
saveScheduleLibrary[ opts:___Rule ] := 
  saveScheduleLibrary[ getSystemName[], opts ];
saveScheduleLibrary[ sys:_String, opts:___Rule ]:=
Catch[
  Module[ {fname, onlyM, sn, scheds},
    onlyM = onlyMainSystem/.{opts}/.Options[ saveScheduleLibrary ];
    fname = sys<>".scdlib";
    If[ FileInformation[ fname ]=!={}, DeleteFile[ fname ] ];
    nm = getSystemName[];
    If[ onlyM, 
      scheds = Select[ $scheduleLibrary, Function[ {n}, First[n] == nm ] ],
      scheds = $scheduleLibrary
    ];
    Put[ scheds, fname ];
    Print[ "Schedule(s) were saved in file ", fname ];
  ]
];
saveScheduleLibrary[___] := Message[ saveScheduleLibrary::params ];

Clear[ loadScheduleLibrary ];
loadScheduleLibrary[ opts:___Rule ] := 
  loadScheduleLibrary[ getSystemName[], opts ];
loadScheduleLibrary[ sys:_String, opts:___Rule ]:=
Catch[
  Module[ {fname, adds, names},
    adds = addSchedule/.{opts}/.Options[loadScheduleLibrary];
    paramsRules = parameterRules/.{opts}/.Options[loadScheduleLibrary];

    fname = sys<>".scdlib";
    If[ 
      FileInformation[ fname ]==={}, 
      loadScheduleLibrary::nofile = "file `1` does not exist";
      Throw[ Message[ loadScheduleLibrary::nofile, fname ] ] 
    ];

    If[ adds, 
      (* Get new schedules *)
      newElmts = Get[fname];
      (* Get names of new programs *)
      names = Map[ First, newElmts ];
      (* Remove old schedules *)
      $scheduleLibrary = 
        Select[ $scheduleLibrary, Function[ {n}, !MemberQ[ names, First[n] ] ] ];
      (* Apply replacement rules to schedules *)
      newElmts = newElmts/.paramsRules;

      (* Replace by new read schedules *)
      $scheduleLibrary = Join[ $scheduleLibrary, newElmts ]
    ,
      $scheduleLibrary = Get[ fname ]
    ]
  ]
];
loadScheduleLibrary[___] := Message[ loadScheduleLibrary::params ];

(* This function shows a list of objects in vertical sequence,
   with separater sep and tabulation tab. For example: 
   ishowhseq[ { titi, toto, tutu }, ";", 2 ] will output
    titi;
    toto;
    tutu
 *)
Clear[ishowhseq];
ishowhseq[ {}, _, _, opts:___Rule ] := "";
ishowhseq[ l:{__}, sep:_, tab:_Integer, opts:___Rule ] :=
  Apply[ StringJoin, Table[ ishow[l[[i]], tab]<>sep, {i,1, Length[l]-1},
		   opts] ]<>
  ishow[l[[Length[l]]], tab, opts];
ishowhseq[ l:{__}, sep:_, tab:_Integer, ind:_String, opts:___Rule ] :=
  Apply[ 
    StringJoin, 
    Table[ ishow[l[[i]], tab, ind, opts]<>sep, {i,1, Length[l]-1} ] 
  ]<>
  ishow[l[[Length[l]]], tab, ind, opts];
ishowhseq[___] := Message[ ishowhseq::params ];

(* This function shows a list of objects in horizontal sequence, 
   separated by a separater sep, with tabulation tab *)
Clear[ishowvseq];
ishowvseq[ {}, _, _, opts:___Rule ] := "";
ishowvseq[ l:{__}, sep:_, tab:_Integer, opts:___Rule ] :=
  Apply[ StringJoin, Table[ ishow[l[[i]], tab, opts]<>sep<>"\n", {i,1, Length[l]-1} ] ]<>
  ishow[l[[Length[l]]], tab];
ishowvseq[ l:{__}, sep:_, tab:_Integer, ind:_String ] :=
  Apply[ StringJoin, Table[ ishow[l[[i]], tab, ind, opts]<>sep<>"\n", {i,1, Length[l]-1} ] ]<>
  ishow[l[[Length[l]]], tab, ind, opts];
ishowvseq[___] := Message[ ishowvseq::params ];

(* 
  Function for getting the indexes of a variable or an 
  alias. Normally, the function getIndexNames would do, but it 
  does not work for an alias.
  ***********  This function has to be corrected for aliases
*)
Clear[getIndexes];
getIndexes[a:_String]:=
Module[ {truedcl, al, params},
  (* Get the number of parameters in $result *)
  params = getSystemParameters[ $result ];
  lpar = Length[ params ];
  dcl = Join[ $result[[3]], $result[[4]], $result[[5]] ];
  truedcl = Cases[ dcl, decl[a,___] ];
  al = Cases[ dcl, Alpha`CodeGen`alias[a, ___ ]];
  getDecl::nodcl = "could not find the declaration of `1`";
  Which[ 
    truedcl === {} && al === {}, Message[ getDecl::nodcl, a ],
    truedcl === {}, al = {},
    True, Drop[ getIndexNames[a], -lpar ]
  ]
];  
getIndexes::params = "wrong parameters";
getIndexes[___] := Message[ getIndexes::params ];


(* 
  Predicate which defines a domain 
*)
Clear[ polDomainQ ];
polDomainQ[ domain[_Integer, {___String}, {___pol} ] ] := True;
polDomainQ[___] := False;

(* 
  Predicate which defines a domain 
*)
Clear[ zpolDomainQ ];
zpolDomainQ[ domain[_Integer, {___String}, {_zpol} ] ] := True;
zpolDomainQ[___] := False;

(* 
  This function is a pretty-printer for Alpha program, with an 
  extension to the imperative language extension 
*)
(*
  Abstract syntax of the imperative form.

  -- as usual
  system := 
    system[ <name>, <parameterdomain>, {<inputdecl>}, {<outputdecl>}, 
      {<localdecl>}, <instruction let> ]

  -- change: introduction of aliases
  localdecl ::= variable decl | alias decl
  alias declaration := alias[ name, <affine expression>, <domain> ]

  -- new
  <let instruction> := let[ <instruction list> ]
  <loop> := loop[ <domain>, <instruction list> ]
  <instruction> := <let instruction> | <loop> | <equation>
  <equation> := as usual

  -- There are several semantics constraints to be satisfied regarding
  indexes in the loop, etc..

*)
Clear[ishow];
(* Standard options *)
Options[ishow] = {debug->False,verbose->False};
(* $result form *)
ishow[ opts:___Rule ] := ishow[ $result, opts ];

(* The classical equation form *)
ishow[ sys:system[ n:_String, params:_domain, 
  inputDecl:_, outputDecl:_, localDecl:_, equs:{___} ], 
  opts:___Rule
] := 
  StringJoin[
    "system ",
    n,
    " : ",
    ashow[params, silent->True],
    If[ inputDecl === {}, 
      "()", 
      "\n(\n"<>ishowvseq[inputDecl, ";", 1, opts ]<> ";\n)"
    ],
    If[ outputDecl === {}, "returns ()", 
      "\nreturns (\n"<>ishowvseq[outputDecl, ";", 1, opts ]<> ";\n);"
    ],
    If[ localDecl === {}, "",
      "\nvar \n"<>ishowvseq[localDecl,";",1,opts]<>";"
    ],
    "\nlet\n",
    ishowvseq[equs,";",1,opts],
    ";\ntel;"
  ];

(* The let form for imperative languages *)
ishow[ sys:system[ n:_String, params:_domain, 
  inputDecl:_, outputDecl:_, localDecl:_, l:_let ], opts:___Rule ] := 
  StringJoin[
    "system ",
    n,
    " : ",ashow[params, silent->True],
    If[ inputDecl === {}, 
      " () ", 
      "\n(\n"<>ishowvseq[inputDecl, ";", 1, opts ]<> ";\n)"
    ],
    If[ outputDecl === {}, "returns ();", 
      "\nreturns (\n"<>ishowvseq[outputDecl, ";", 1, opts ]<> ";\n);"
    ],
    If[ localDecl === {}, "",
      "\nvar \n"<>ishowvseq[localDecl,";",1, opts]<>";"
    ],
    "\nlet\n",
    ishow[l,1,opts],
    ";\ntel;"
  ];

(* 
  In a declaration, the domain is a singleton if it is a scalar 
  type
*)
ishow[ decl[a:_, type:_, d:_domain?DomSingletonQ ], tab:_Integer,
     opts:___Rule ] :=
  StringJoin[
    spaces[tab],
    a,
    " : ",
    ToString[type]
  ];

(*
  General case of a declaration
*)
ishow[ decl[a:_, type:_, 
	    d:_domain ], tab:_Integer, opts:___Rule  ]:=
Module[ 
  {d1, ind},
  If[ polDomainQ[d], ind = d[[2]], ind = dom[[3,1,1,3]] ];
  d1 = DomProject[d, Drop[ ind, -Length[ getParameters[$result ] ] ] ];
  StringJoin[
    spaces[tab],
    a,
    " : ",
    ashow[d1, silent->True],
    " of ",
    ToString[type]
  ]
];

(*
  Case of an alias in a declaration.
*)
ishow[ Alpha`CodeGen`alias[a:_, exp:_, 
  dom:_domain], tab:_Integer,
  opts:___Rule ]:=
Module[ 
  {d1,ind},
  If[ polDomainQ[dom], ind = dom[[2]],
    ind = dom[[3,1,1,3]]
  ];

  (* Project the domain on non parameter indexes *)
  d1 = DomProject[dom, Drop[ ind, 
    -Length[ getParameters[$result ] ] ] ];
  StringJoin[
    spaces[tab],
    a,
    " :",
    " alias of ",
    ashow[ exp, silent -> True],
    " on ",
    ashow[ d1, silent -> True]
  ]
];

(*
  Case of a let expression
*)
ishow[ Alpha`let[ inst:___], tab:_Integer, opts:___Rule ]:=
    ishowvseq[ {inst}, ";", tab + 1,opts];

(* 
  Case of a loop
*)
ishow[ Alpha`loop[ dom:_domain, inst:___], tab:_Integer, opts:___Rule ]:=
(* Project dom to remove parameters *)
Module[ 
  {ind, lparams, d1, dbg},
  dbg = debug/.{opts}/.Options[ishow];
  If[ dbg, Print[ "Domaine: ", dom ] ];
  If[ polDomainQ[ dom ], ind = dom[[2]], ind = dom[[3,1,1,3]] ];
  d1 = DomProject[dom, Drop[ ind, 
    -Length[ getParameters[$result ] ] ] ];
  StringJoin[
    spaces[tab],
    "loop++ ", 
    ashow[ d1, silent->True ],
    " : \n",
    ishowvseq[ {inst}, ";", tab+1, opts],
    "\n", spaces[tab],"end loop"
  ]
];

(*
  Case of an equation
*)
ishow[ equation[ lhs:_, rhs:_ ], tab:_Integer, opts:___Rule ]:= 
(* Get indexes of lhs *)
  With[ {ind = getIndexes[lhs]},
    If[ ind =!= {},
      StringJoin[
        spaces[tab],
        lhs,
        "[",
        ishowhseq[ind,",",tab,opts],
        "] = ",
        ishow[ rhs, tab+1, ind, opts ]
      ],
      StringJoin[
        spaces[tab],
        lhs,
        " = ",
        ishow[ rhs, tab+1, ind, opts ]
      ]
    ]
  ];

(*
  Case expression 
*)
ishow[ case[ r:___ ], tab:_Integer, ind:_String, opts:___Rule ] :=
  "\n"<>spaces[tab]<>"case\n"<> ishowvseq[ r, ";", tab+1, ind, opts ]<>";\n"<>
  spaces[tab]<>"esac";

(* 
  Restriction
*)
ishow[ restrict[ d:_domain, e:_ ], tab:_Integer, ind:_String, opts:___Rule ] :=
Module[ 
  {d1, ind},
  If[ polDomainQ[d], ind = d[[2]], 
    ind = dom[[3,1,1,3]]
  ];
  d1 = DomProject[d, Drop[ ind, 
    -Length[ getParameters[$result ] ] ] ];
  spaces[tab]<>ishow[d1, tab, ind, opts]<>" : "<>ishow[e, tab, ind, opts]
];

(* 
  This function removes the index part in the ouptut form of
  a dependence function. For example, (i,j -> i+j,N) is rewritten
  [i+j,N]. It also removes the parameters.
*)
Clear[ dropIndexesDep ];
dropIndexesDep[ s:_String ]:= dropIndexesDep[ $result, s ];
dropIndexesDep[ sys:_system, s:_String ]:=
  Module[ {pospt, posarrow, form },
    pospt = StringPosition[s,"."][[1,1]];
    posarrow = StringPosition[s,"->"][[1,2]];
    form = 
      StringTake[ s, {1,pospt-1} ]<>"("<>
      StringTake[ s, {posarrow+1,StringLength[s]} ];
    StringReplace[ form, {"("->"[", ")"->"]", " "->""} ]
  ];
dropIndexesDep::params = "wrong parameters";
dropIndexesDep[___] := Message[ dropIndexesDep::params ];

ishow[ x: affine[ var:_, dep:_ ], tab:_Integer, ind:_, opts:___Rule ] := 
With[ {dep1 = dropParameters[ dep ]},
  dropIndexesDep[ $result, ashow[ affine[ var, dep1 ], silent -> True ] ]
];
 
Clear[ dropIndexesDom ];
dropIndexesDom[ s:_String ] := dropIndexesDom[ $result, s ];
dropIndexesDom[ sys:_system, s:_String ]:=
  StringReplace[
    "{" <> StringTake[s, {StringPosition[s, "|"][[1, 1]], 
      StringLength[s]}], " "->""
  ];
dropIndexesDom::params = "wrong parameters";
dropIndexesDom[___] := Message[ dropIndexesDom::params ];

(* 
   A domain is pprinted using ashow, then dropping the indexes to
   get the array form. Parameter tab gives the indentation level,
   and ind is not used here.
*)
ishow[ d:_domain, tab:_Integer, ind:_String ] :=
(* Project the domain to remove the parameters *)
Module[ 
  {d1},
  Print[ d ];
  d1 = DomProject[d, Drop[ d[[2]], 
    -Length[ getParameters[$result ] ] ] ];
  dropIndexesDom[ $result, ashow[ d, silent -> True ] ]
];

(* 
   A binary operator is pprinted in an obvious way.
*)
ishow[ binop[ op:_, exp1:_, exp2:_] , tab:_Integer, ind:_ ] :=
  ishow[ exp1, tab, ind ]<>ishow[ op ]<>ishow[ exp2, tab, ind ];

(*
   ishow of a string is the string itself
*)
ishow[ s:_String, tab:_, ind:_ ] := s;

(*
   ishow of operators. To be completed...
*)
ishow[ add ] := " + ";
ishow[ sub ] := " - ";
ishow[ mul ] := " * ";

ishow[ const[c:_], tab:_, ind:_, opts:___Rule ] := ToString[ c ];

ishow[ var[c:_], tab:_, ind:_, opts:___Rule ] := ToString[ c ];

ishow[ x:_, tab:_Integer, opts:___Rule ] := ToString[ x ]; 

(*
  spaces[n] gives 2n spaces
*)
Clear[ spaces ];
spaces[ n:_Integer ] := Apply[ StringJoin, Table[ "  ", {i, 1, n} ] ];
spaces[___] := Message[ spaces::params ];



Clear[ DomDimension ];
DomDimension[ d:_domain ] := d[[1]];
DomDimension::params = "wrong parameters";
DomDimension[___] := Message[ DomDimension::params ];

Clear[ DomTrueDimension ];
DomTrueDimension[ d:_domain ] := DomTrueDimension[ $result, d ];
DomTrueDimension[ sys:_system, d:_domain ] :=
  Module[ {pdom},
    pdom = getSystemParameterDomain[ sys ];
    d[[1]] - pdom[[1]]
  ];
DomTrueDimension::params = "wrong parameters";
DomTrueDimension[___] := Message[ DomTrueDimension::params ];

Clear[DomSingletonQ];
DomSingletonQ[ d:_domain ]:=DomSingletonQ[ $result, d ];
DomSingletonQ[ sys:_system, d:_domain ] :=
  DomTrueDimension[ sys, d ] === 0 && DomUniverseQ[ d ];
DomSingletonQ::params = "wrong parameters";
DomSingletonQ[___] := Message[ DomSingletonQ::params ];

(*
   This is the end of ishow
*)

(* slackOf *)
Clear[slackOf];
slackOf::nosched = "$scheduleMDSol does not contain a schedule solution";
slackOf[lc:___]:=
Catch[
  Module[{s=$scheduleMDSol[1],c},
    (* No schedule was computed: exit *)
    If[ Length[ s ] =!= 4, Throw[ Message[ slackOf::nosched ] ], Null];
    (* Get the value of the solution in $scheduleMDSol, as a list
       of rules *)
    s = s[[4]][[2]]; 
    (* Remplace inequalities in c by expression temp, to avoid evaluation *)
    c = lc/.x_>=y_ -> temp[x,y];
    (* Apply rules, and return first value *)
    c = c/.s; Map[ First, c ]
  ]
];
slackOf[___]:=Message[slackOf::params];

(* function which returns the constraints involving a symbol in 
   the previous call of scd *)
Clear[constOf];
constOf::nosched = "$scheduleMDSol[1] is not properly set. Run scd[] before.";
constOf[sym:_Symbol]:=
  With[{s=$scheduleMDSol[1]},
        If[Length[s]===4, constOf[s[[2]],sym], Message[constOf::nosched]]
  ];
constOf[lc:_,sym:_Symbol]:=
  Part[ lc, Map[ First, Position[lc,sym] ] ];
constOf[___]:=Message[constOf::params];

(* function which returns the value of a symbol in a schedule *)
Clear[valueOf];
valueOf::nosched = "$scheduleMDSol[1] is not properly set. Run scd[] before.";
valueOf[sym:_Symbol]:=
  With[{s=$scheduleMDSol[1]},
        If[Length[s]===4, valueOf[s[[4]][[2]],sym], Message[valueOf::nosched]]
  ];
valueOf[sol:{___Rule},sym:_Symbol]:=sym/.sol;
valueOf[___]:=Message[valueOf::params];

(* Local function *)
Clear[rang];
rang[{},_]:={};
rang[s:{__List},l:_]:=Map[rang[#,l]&,s];
rang[{s1_,s2_},l_]:=
 Map[First[First[Position[l,#]]]&,{s1,s2}];
rang[___] := Message[ rang::params];

(*
    The following functions are extracted from the package
    DiscreteMath`Combinatorica, and adapted to vizualize
    dependency graphs. In order not to conflict with the 
    corresponding functions of this package, the names have
    been modified. 

    Arrows -> arrows
    MinimumEdgeLength -> mal
    ShowLabeledGraph -> slg
    FindPlotRange -> fpr
    PointsAndLines -> pal
    GraphLabels -> gl

*)

(* function arrows taken from Combinatorica *)
Clear[arrows];
arrows[Graph[e_,v_]] :=
  Module[{pairs=ToOrderedPairs[Graph[e,v]], size, triangle, selfVertices},
    (* Remove self pairs from graph *)
    selfVertices = Cases[pairs,{x_,x_}]; (* Find out self edges *)
    pairs = Complement[ pairs, selfVertices ]; (* Remove from pairs *)
    size = Min[0.05, mel[v,pairs]/3];  (* MinimumEdgeLength *)
    triangle={ {0,0}, {-size,size/2}, {-size,-size/2} };
    Map[
      (Polygon[
         TranslateVertices[
           RotateVertices[
             triangle,
             Arctan[Apply[Subtract,v[[#]]]]+Pi
           ],
           v[[ #[[2]] ]]
         ]
       ])&,
       pairs
    ]
  ];
arrows[___]:=Message[arrows::params];

(* mel taken from Combinatorica *)
Clear[mel];
mel[v_List,pairs_List] :=
	Max[ Select[
		Chop[ Map[(Sqrt[ N[(v[[#[[1]]]]-v[[#[[2]]]]) . 
			(v[[#[[1]]]]-v[[#[[2]]]])] ])&,pairs] ],
		(# > 0)&
	], 0.001 ];
mel[___]:=Message[mel::params];
 
(*  This function was taken from DiscreteMath`Combinatorica *)
Arctan[{x_,y_}] := Arctan1[Chop[{x,y}]]
Arctan1[{0,0}] := 0
Arctan1[{x_,y_}] := ArcTan[x,y]

(* 
    ShowLabeledGraph: modified version
*)
Clear[slg];
slg[g_Graph,type_:Directed] := slg[g,Range[V[g]],type];
slg[g1_Graph,labels_List,type_:Undirected,opts:___Rule] :=
Catch[
  Module[{pairs=ToOrderedPairs[g1], 
          (* g=NormalizeVertices[g1], *) g=g1, v},
    v = Vertices[g];
    Show[
      Graphics[
        Join[pal[g],  (* PointsAndLines *)
(*	Map[(Line[Chop[ v[[#]] ]])&, pairs],*)
(* See ShowGraph to understand... *)
        If[SameQ[type,Directed],arrows[g],{}],  (* Arrows *)
        gl[v,labels,opts]  (* GraphLabels *)
      ]
    ],
    {AspectRatio->1, PlotRange->fpr[v]} (* FindPlotRange *)
    ]
  ]
];
slg::params = "wrong parameters";
slg[___]:=Message[slg::params];

(* A slight modification to change 0.05 coefficients to 0.3 *)
Clear[fpr];
fpr[v_List] :=
	Module[{xmin=Min[Map[First,v]], xmax=Max[Map[First,v]],
			ymin=Min[Map[Last,v]], ymax=Max[Map[Last,v]]},
		{ {xmin - 0.3 Max[1,xmax-xmin], xmax + 0.3 Max[1,xmax-xmin]},
		  {ymin - 0.3 Max[1,ymax-ymin], ymax + 0.3 Max[1,ymax-ymin]} }
	];
fpr[___]:=Message[fpr::params];

(* Modification in order to see reflexive vertices *)
Clear[pal];
pal[Graph[e_List,v_List]] :=
Module[{pairs=ToOrderedPairs[Graph[e,v]],selfVertices},
  selfVertices = Cases[pairs,{x_,x_}]; (* Find out self edges *)
  pairs = Complement[ pairs, selfVertices ]; (* Remove from pairs *)
  selfVertices = Map[ First, selfVertices ]; (* Get self vertices *)
  Join[
    {PointSize[ 0.015 ]},
    Map[Point,Chop[v]],
    Map[(Line[Chop[ v[[#]] ]])&,pairs], {Red},
    (* Paint self vertices in red *)
    Map[Point,Chop[Part[v,selfVertices]]], {Black}
  ]
];
pal[___]:=Message[pal::params];

(* A small modification to have bigger labels, and a bigger offset *)
Clear[gl];
gl[v_List,l_List,opts:___Rule] :=
  Module[{i,lbSize,lbFactor},
    {lbSize, lbFactor} = 
       {labelSize, labelFactor}/.{opts}/.Options[ depGraph ];
  r = 
  Table[ 
    Text[ StyleForm[l[[i]],FontSize->lbSize],
          v[[i]]*lbFactor ],{i,Length[v]}]; r
  ];
gl[x:___]:=Message[gl::params];
 
(*
     ------------- This function computes the cycles of the dependence graph
*)
Clear[ depCycles ];
depCycles[opts:___Rule]:=
Catch[
  Module[ {graph, cc, v, dd, sv},
    sv = selfDep/.{opts}/.Options[depCycles];
    Check[ graph = Last[ depGraph[ silent -> True, opts ] ], 
           Throw[Message[depCycles::depgraph]]];
    cc = ExtractCycles[ graph, Directed ];
    If[ !sv, cc = Complement[cc, Cases[cc, {x:_,x:_}]] ];
    v = getVariables[];
    Map[Part[v,#]&,cc]
  ]
];
depCycles[___] := Message[depCycles::params];

(*
     ------------- This function gives the strongly connected components
                   of the dependence graph
*)
Clear[ depComponents ];
depComponents[opts:___Rule]:=
Catch[
  Module[ {graph, cc, v },
    Check[ graph = Last[ depGraph[ silent -> True, opts ] ], 
           Throw[Message[depCycles::depgraph]]];
    cc = StronglyConnectedComponents[ graph ];
    v = getVariables[];
    Map[Part[v,#]&,cc]
  ]
];
depComponents[___] := Message[depComponents::params];

(* returns True if the matrix is identity on the specified 
 dimension. warning, if the matrix is not square, it still tryes... *)

Clear[isIdentityOnDim]
isIdentityOnDim[mat1:_matrix,indices:List[___Integer]]:=
Module[{m},
       m=mat1[[4]];
       res=True;
       Do[curIndice=indices[[i]];
	  If[curIndice=indices[[i]];
	     curIndice>mat1[[1]],Return[res=False],
	     (* else OK *)
	     curRow=m[[curIndice]];
	     If[curIndice>mat1[[2]],Return[res=False],
		(* else OK *)
		res=res && curRow[[curIndice]]/m[[-1,-1]]===1;
		res=res && Union[Delete[curRow,curIndice]]==={0};
	     ]
	  ]
	  ,{i,1,Length[indices]}];
       res]
isIdentityOnDim[a___]:=Message[idIdentityOnDim::WrongArg]

(*
     ------------- This function draws the dependence graph
*)
Clear[ depGraph ];
depGraph::noSystem = "$result does not seem to contain an Alpha system";
depGraph[ opts:___Rule ]:=depGraph[$result,opts];
depGraph[sys:_system, opts:___Rule ]:=
Catch[
  Module[{ v, vars, pairs, usepairs, dd, graph, sil, dbg, vrb, extraE, durs, 
    onlyId, timeIndices, vv, gv, rg },
    { sil, dbg, vrb, extraE, durs, onlyId, vv } = 
      { silent, debug, verbose, extraEdges, durations, onlyIdDep,
        variables }/.{opts}/.
      Options[ depGraph ];

    (* Check that $result is a system *)
    If[ !MatchQ[ sys, system[___] ], Throw[ depGraph::noSystem ]];
      (* Recompute dep Table *)
    dd = dep[ sys, subSystems->True, parameterConstraints -> True, opts ];
    If[ dbg, Print["Dependence graph is " ], Null ];
    If[ dbg, Print[ ashow[ dd, silent -> True ] ] ];

  (* Option onlyId selects only those dependencies which are 
     identities on the first index *)
    If[ onlyId=!=False,
      If[MatchQ[onlyId,List[___Integer]],
        timeIndices=onlyId,
        timeIndices={1}
      ];
      dd1=dtable[Select[dd[[1]], 
          isIdentityOnDim[#[[4]],timeIndices] &]];
	     
      If[ dbg, Print["Dependence with only id deps "], Null];
      If[ dbg, Print[ ashow[ dd1, silent -> True ] ] ];
      dd=dd1
    ];

    (* Get variables (depending on options) *)
    gv = getVariables[sys];

    Which[ 
      (* Option variables is all *)
      vv === all,
      vars = getVariables[sys]
    ,
      (* Option variables is equations *)
      vv === equations, 
      
      (* First, get all lhs of equations *)
      vars = 
        Map[ 
          Function[ x, If[ Head[x] === use, Last[x], First[x] ] ],
          $result[[6]] 
        ]; 
      Print[ vars ];
      vars = Flatten[ vars ];
      vars = Join[ getInputVars[sys], vars ]; (* Then prepend all input vars *)

    ,
      (* If the variable option is not all, it is a list of variables
         which should be a permutation of getVariables[sys] *)
      True, 
      vars = vv;
(*
      If[ (Union[ vars ] != Union[ gv ]) ||
          (Length[ vars ] != Length[ gv ]), 
        depGraph::notallvars = 
          "option variable should be either all or a permutation of all variables";
        Throw[ Message[ depGraph::notallvars ] ]
      ];
*)
    ];

    (* Print order of variables chosen *)
    If[ dbg, Print["Order of the variables : "];Print[ vars ] ];

    (* Get pairs of dependent data *)
    pairs = Map[Apply[List,Take[#,{2,3}]]&, First[dd]]; 
    pairs = Map[ Reverse, pairs ]; 
    If[ dbg, Print["Dependence pairs: ", pairs ] ];

    (* Get pairs of use arguments, if they exist *)
    ddused = If[ Length[dd] === 2, Last[ dd ], {} ];
    If[ ddused =!= {},
      usedpairs = Map[Apply[List,Take[#,{2,3}]]&, Last[dd]]; 
      usedpairs = Flatten[ Map[Outer[List,Last[#],First[#]]&,usedpairs], 2],
      usedpairs = {}
    ];
    usedpairs = Map[ Reverse, usedpairs ]; 
    If[ dbg, Print["Used pairs: ", usedpairs ] ];

    (* Get the embedding of graph *)
    rg = rang[ Join[ pairs, usedpairs], vars];
    If[ dbg, Print["rang: ", rg] ];

    (* Remove of rang those arcs with empty name *)
    rg = Select[ rg, First[#]=!={}&&Last[#]=!={}& ];
    If[ dbg, Print["rang: ", rg] ];

    graph = FromOrderedPairs[ rg, CircularVertices[ Length[ vars ] ] ]; 

    If[ dbg, Print[ graph ] ];

    If[ !sil, 
        slg[ graph , vars, Directed, opts ]]; (* ShowLabeledGraph *)
    
    (* Return both the var list and the graph *)
    {vars, graph}
  ]
];
depGraph[___]:= Message[depGraph::params];

(* 

This is under work... I would like to print the 
dependence graph in the order given by the topological 
sort...

Clear[topoDG];
topoDG[ sys:_system, opts ] :=
Catch[
  Module****************
];
topoDG[___] := Message[depGraph::params];

*)

(* Initialize $scheduleLibraty *)
Print["Do not forget to change the initialization of $scheduleLibrary"];
$scheduleLibrary = {};

(*     ------------- This function sort the equation such that the equation 
executed at the same instant can be executed in the textual ordrer 
(for code gen), currently it build a graph from dep to use the Topological sort function of Mathematica *)
Clear[ sortEquations];

sortEquations::noUse="sortEquations does not accept use "
sortEquations::CycleInGraph="The dependence graph contains cycle with identity dep along the dimension given by the 
metric (option onlyIdDep is `1`), impossible to sort the equation, sort aborted "
sortEquations[ opts:___Rule ]:=
     Module[{res},
	    res=sortEquations[ $result, opts ];
	    If[MatchQ[res,system[___]],$result=res];
	    $result]

sortEquations[sys:_system, opts:___Rule ]:=
Catch[
  Module[{sil, dbg, vrb, extraE, durs, onlyId , vars, dg,topoS,
	  orderedVarList,equationList,useList,
	  curVar,curEq,newSys},
    { sil, dbg, vrb, extraE, durs } = 
      { silent, debug, verbose, extraEdges, durations }/.{opts}/.Options[ depGraph ];
	 onlyId=onlyIdDep/.{opts}/.{onlyIdDep->True};
    (* Check that sys is a system *)
	 If[dbg,Print["**** entering sortEquations ****"]];
	  If[Position[sys,use,Infinity]=!={},
	     (* Message[sortEquations::noUse];Throw[sys]; *)
	 Print["Warning, currently we only put uses at the end, to be corrected, Please 
 check the result "]];
	 vars=getVariables[sys];
	 (* I HOPE that they will use the same numerotation in depGraph *)
	 dg=Last[depGraph[sys,opts,silent->True,onlyIdDep->True]];
	 topoS=TopologicalSort[dg];
	 If[!MatchQ[ topoS,List[___Integer]],
	    Message[sortEquations::CycleInGraph,onlyId];Throw[sys]];
	 If[dbg,Print["NewOrder: ",topoS]];
	 (* permute the variable *)
	 orderedVarList=Permute[vars,topoS];
	 (* remove Input variables *)
	 If[dbg, Print["orderedVarList",orderedVarList]];
	 orderedVarList=Select[ orderedVarList,!MemberQ[getInputVars[sys],#] &];
	 equationList={};
	 useList={};
	 curVarList=orderedVarList;
	 (* yes, there is a while *)
	 While[curVarList=!={},
	       curVar=curVarList[[1]];
	       curVarList=Drop[curVarList,1];
	       curEq=getEquation[sys,curVar];
	       (* If there is a use, we delete all the output of the 
		use from curVarList *)
	       If[MatchQ[curEq,use[___]],
		  outputList=curEq[[5]];
		  curVarList=Complement[curVarList,outputList];
		  useList=Append[useList,curEq],
		  (* else equation *)
		  equationList=Append[equationList,curEq]];
	 ];
	 equationList   =Join[equationList,useList];
	 newSys=ReplacePart[sys,equationList,6];
	 newSys
	 
	 
  ]
]

sortEquations[a___]:=Message[sortEquations::WrongArg]
(*
    ---- This function is not used...
*)
Clear[locateEliminations];
locateEliminations[]:=
Module[ {l,lvars},
  lvars = getLocalVars[];
  l = Cases[ $result[[6]], 
    equation[ lhs_, var[ rhs_ ] ]/;
    MemberQ[lvars,lhs]&&getDeclarationDomain[lhs]===getDeclarationDomain[rhs], 2 ];
  Map[ Print["Call eliminateLeftVar[ ", #[[1]] , " ]"]&, l];
  l = Cases[ $result[[6]], equation[ lhs_, restrict[ d_, var[ rhs_ ] ] ], 2 ];
  Print[ l ]; 
  Map[ Print["You can replace ", #[[1]], " by ", #[[2]][[1]], " if domains are the same" ]&, l];
];
locateEliminations[___] := Message[ locateEliminations::params ];

(*
    ---- This function is not used...
*)
Clear[eliminateVar];
eliminateVar::nosys = "$result does not contain a system";
eliminateVar::notavar = "`1` is not a local variable"; 
eliminateVar::noeq = "there is no equation defining `1`"; 
eliminateVar::notidentity = "the equation defining `1`is not an identity";
eliminateVar::wrg = "could not find the equations containing occurences of `1`";
eliminateVar::wrgsubs = "error while eliminating `1`";
eliminateVar::wrgrem = "error while removing `1`";
eliminateVar::notsamedecl = "variable `1` and `2` do not have the same definition domain";
eliminateVar[ v:_String, opts:___Rule ]:=
Catch[
  Module[{ e, occs, lhsv, vrb, dbg, temp, norm, alphaF },
    {vrb, dbg, norm, alphaF} = 
      {verbose, debug, normalizeSystem, alphaFormat}/.{opts}/.Options[ eliminateVar ];
    If[ !MatchQ[ $result, system[___]], 
        Throw[ Message[ eliminateVar::nosys ] ]
    ];
    If[ !MemberQ[ getLocalVars[], v ],
        Throw[ Message[ eliminateVar::notavar, v ] ]
    ];
    Check[ e = getEquation[ v ], 
           Throw[ Message[ eliminateVar::noeq, v ] ] ]; 
    Print[e];
    If[ !MatchQ[ e, equation[ v , var[ _String ] ] ] &&
        !MatchQ[ e, equation[ v , affine[ var[ _String ], 
                              m:_matrix ]/;identityQ[m] ] ], 
        Throw[ Message[ eliminateVar::notidentity, v ] ] 
    ];

    (* Get lhs variable *)
    lhsv = 
    Which[ 
      MatchQ[ e, equation[ v, var[ _String ] ] ], e[[2]][[1]],
      True, e[[2]][[1]][[1]] 
    ];
    Print[ lhsv]; 
    If[ getDeclarationDomain[v] =!= getDeclarationDomain[ lhsv ],
       Throw[Message[eliminateVars::notsamedecl,v, lhsv ] ] ];

    (* Get the list of positions of v in rhs equations *)
    occs = getOccurs[ v ]; 
    (* Get the list of equation positions *)
    occs = Map[ Take[#,2]&, occs ];
    Check[ lhsv = Map[ getPart[ $result, # ][[1]]&, occs ], 
           Throw[ Message[ eliminateVar::wrg, v ] ] ];
    Check[ Map[ (If[ vrb, Print[ "Eliminating ", v , " in definition of ", # ] ];
         substituteInDef[ #, v ])&, lhsv ], 
           Throw[ Message[ eliminateVar::wrgsubs, v ] ] 
    ];
    (* Now, remove the var *)
    Check[ If[ vrb, Print[ "Remove variable ", v ] ]; removeUnusedVar[ v ], 
      Throw[ Message[ eliminateVar::wrgrem, v ] ]
    ];
    Print[ norm ];
    (* Normalize, if necessary *)
    If[ norm && (alfaF =!= Alpha0), Print[norm0];normalize[] ];
    If[ norm , normalize0[] ];
  ]
];
eliminateVar[___] := Message[ eliminateVar::params ];

(*
    ---- This function transforms an alpha matrix into a mma one
*)
Clear[matrix2mma];
matrix2mma[Alpha`matrix[d1:_Integer,d2:_Integer,index:{__String},mm:_?MatrixQ]]:=
  mm;
matrix2mma[___]:=Message[matrix2mma::params];

(*
    ---- This function returns the linear part of an alpha matrix
*)
Clear[getLinPart];
getLinPart[ Alpha`matrix[ d1:_Integer, d2:_Integer, index:{___String}, mm:_?MatrixQ ] ]:=
  Map[ Drop[ #1, -1 ]&, Drop[ mm , -1 ]];
getLinPart[___]:=Message[getLinPart::params];

(*
    ---- This function returns the translation part of an alpha matrix
*)
Clear[matrixTransPart];
matrixTransPart[ Alpha`matrix[ d1:_Integer, d2:_Integer, index:{___String}, mm:_?MatrixQ] ]:=
  Drop[ Last[ Transpose[ mm ] ], -1 ];
matrixTransPart[___]:=Message[matrixTransPart::params];

(* Undocumented, not external yet... *)
Clear[affineDepConsts];
affineDepConsts::params = "called with wrong parameters";
affineDepConsts::verticeserr = 
"Error while calling the vertices function";
affineDepConsts::rayserr = "Error while calling the rays function";

(* 
    Parameters are:
    - leftv:   the left variable, 
    - dom:     the domain of dependency,
    - rightv:  the rhs variable,
    - mm:      the dependence matrix,
    - v:       the list of variables,
    - taus:    the list of tau coefficients,
    - alphas:  the list of alpha coefficient
*)
affineDepConsts[ 
    dp:depend[ dom:_domain, 
            leftv:_String, 
            rightv:_String, 
            mm:(_matrix|Null), _ ], 
   v:{__String}, dur:_Integer, 
   taus:{__}, alphas:{__}, options:___Rule]:=
Module[{ cr, posr, constr, vb, crays, cvertices, ccvertices, ccrays,
        linpart, multidim, bd, constraints, dbg, dponly, ve, ra, 
        cposv, cposr, domLocal },

  (* Get Options *)
  vb = verbose/.{options}/.Options[affineDepConsts]; 
  dbg = debug/.{options}/.Options[affineDepConsts]; 
  (* Not used yet *)
  bd = boundedDelay/.{options}/.Options[affineDepConsts];
  dponly = dependenciesOnly/.{options}/.Options[affineDepConsts];
  vpc = verticesPositive/.{options}/.Options[affineDepConsts];

  (* *)
  If[ vb || dbg, 
    Print["--- LHS variable: ", leftv, ", RHS variable: ", rightv ] 
  ];

  (* If dom is a union, replace it by its convex closure *)
  If[ Length[ dom[[3]] ]>1, 
      domLocal = DomConvex[ dom ], domLocal = dom ];

  (* Vertices and rays *)
  ve = Check[vertices[ domLocal ], 
             Throw[Message[affineDepConsts::verticeserr]]];
  If[ dbg, Print["Vertices of domain: ", ve] ];
  ra = Check[rays[ domLocal ],
             Throw[Message[affineDepConsts::rayserr]]];
  If[ dbg, Print["Rays: ",ra] ];

  (* Position of lhs symbol *)
  posl = Position[ v, leftv ][[1]][[1]];
  If[ dbg, Print["Position of lhs: ",posl] ];

  (* coeffs and constant of lhs symbol *)
  cl = taus[[ posl ]]; constl = alphas[[ posl ]]; 
  If[ dbg, Print["Coeffs of lhs: ",cl] ];
  If[ dbg, Print["Constant of lhs: ",constl] ];

  If[ rightv =!= "",
    (* Position of rhs symbol *)
    posr = Position[ v, rightv ][[1]][[1]]; 
    If[ dbg, Print["Position of rhs: ",posr] ];

    (* coeffs and constant of rhs symbol *)
    cr = taus[[ posr ]]; constr = alphas[[ posr ]]; 
    If[ dbg, Print["Coeffs of rhs: ",cr] ];
    If[ dbg, Print["Constant of rhs: ",constr] ];

    (* linear part of dep *)
    linpart = getLinPart[mm]; 
    If[ dbg, Print["Linear part of dep: ", linpart] ];

    (* translation part *)
    trans = matrixTransPart[mm]; 
    If[ dbg, Print["Translation part of dep: ", trans] ];

    If[ dbg, Print["Duration ", dur] ];

    (* Build dependence constraints *)
    cvertices = 
      Which[ 
        ve==={{}},  (* The vertex set may be empty *)
          Union[Map["ge"[-cr.trans+constl-constr, dur ]&,ve]],
        cr==={},    (* The cr may be empty *)
          Union[Map["ge"[cl.#1+constl-constr, dur ]&,ve]],
        linpart==={},  (* The linpart may be empty *)
          Union[Map["ge"[cl.#1-cr.trans+constl-constr, dur ]&,ve]],
        True,
          Union[Map["ge"[cl.#1-cr.(linpart.#1+trans)+constl-constr, dur ]&,ve]]
      ];
    If[dbg,Print["Dependence constraints due to vertices: ",cvertices] ];

    crays=
      Union[Map["ge"[cl.#1-cr.(linpart.#1),0]&,ra]];
    If[dbg,Print["Dependence constraints due to rays: ",crays] ];
  , (* else *)
  cvertices = {};
  crays = {}
  ];

(* Do not compute positivity constraints on vertices, except is asked *)
(* There seemed to be a bug here... it was - constl before... *)
  cposv = If[vpc, Map["ge"[cl.#1 + constl,0]&,ve],{}]; 
  If[dbg, Print["Positivity constraints due to vertices: ", cposv ] ];
  cposr = Map["ge"[cl.#1,0]&,ra];
  If[dbg, Print["Positivity constraints due to rays: ", cposr ] ];

  (* Return the dependence constraints, or all constraints *)
  constraints = If[ dponly, Union[ cvertices, crays],
                    Union[ cvertices, crays, cposr, cposv ] ];

  (* Remove True from the constraints *)
  constraints = Complement[ constraints, {True} ];
  If[vb, 
     Print[ "    Constraints: ", 
        constraints/.{"ge"[x_,y_]->GreaterEqual[x,y]} ] 
  ];
  constraints
];
affineDepConsts[y:___]:= Message[affineDepConsts::params];

(* Main function to compute deps *)
Clear[scheduleConstraints];
scheduleConstraints::params = "called with wrong parameters.";
scheduleConstraints::norm = "input system is not normalized.";
scheduleConstraints::emptyprog = "input system empty.";
scheduleConstraints::noUse = 
"Warning: no use statements in this program.";
scheduleConstraints::wrgduration = 
"the duration list should have the same length as the dependence
table."; 
scheduleConstraints[options:___Rule]:=scheduleConstraints[$result,{},options];
scheduleConstraints[sys:_Alpha`system,options:___Rule]:=scheduleConstraints[sys,{},options];
scheduleConstraints[variable:_String,options:___Rule]:=
	scheduleConstraints[ Alpha`$result, variable, options];
scheduleConstraints [ sys:_Alpha`system, variable:(_String|{}), options:___Rule]:=
Catch[
  Module[{v,lv,iv,ov,declarat,dims,
          coeffstau,coeffsalpha,defs,aux,result,result1,pos,oploc,slp,
          vrb,extrac,multidim,
	  bd, vpc, dponly, dbg, depcomp, sbs, useConstraints,df,
          onlyV, onlyE, onlyD, reuseS},

    (* Reset global variables *)
    $dependencyConstraints = {}; 

    (* Check system *) 
    If[sys==={},Throw[Message[scheduleConstraint::emptyprog]] ];

    (* Run only on normalized programs *)
    If[!normalizeQ[sys],Throw[Message[scheduleConstraint::norm]] ];

    (* Get options *)
    sbs = subSystems/.{options}/.Options[scheduleConstraints]; (* option *)
(*
    This option is not of much use... The idea is to force the timing 
    function to be positive on vertices, but generally, it produces 
    very bad solutions...
*)
    vpc = verticesPositive/.{options}/.Options[scheduleConstraints]; 
    (* option *)
    dponly = dependenciesOnly/.{options}/.Options[scheduleConstraints]; 
    (* option *)
    slp = scheduleType/.{options}/.Options[scheduleConstraints]; 
    (* verbose option *)
    vrb = verbose/.{options}/.Options[scheduleConstraints]; 
    df = dataFlow/.{options}/.Options[scheduleConstraints]; 

    (* Force multidimensional, if dataflow *)
    multidim = If[df, True, 
      multidimensional/.{options}/.Options[scheduleConstraints]]; 
    dbg = debug/.{options}/.Options[scheduleConstraints]; 
    depcomp = depComputed/.{options}/.Options[scheduleConstraints];
    dur = durations/.{options}/.Options[scheduleConstraints];
    onlyV = onlyVars/.{options}/.Options[scheduleConstraints];
    onlyE = onlyEquations/.{options}/.Options[scheduleConstraints];

    (* Correction 21/12/02 *)
    If[ onlyE =!= all, 
      Print["Warning: option onlyEquations in not implemented"] ];

    onlyD = onlyDep/.{options}/.Options[scheduleConstraints];
    reuseS = reuseSchedule/.{options}/.Options[scheduleConstraints];

    (* Compute variables *)
    lv = getLocalVars[]; (* local vars *)
    (* Remove unneeded variables *)
    If[ onlyV =!= all, lv = Intersection[ lv, onlyV ] ];
    iv = getInputVars[]; (* input vars *)
    (* Remove unneeded variables *)
    If[ onlyV =!= all, iv = Intersection[ iv, onlyV ] ];
    ov = getOutputVars[]; (* output vars *)
    (* Remove unneeded variables *)
    If[ onlyV =!= all, ov = Intersection[ ov, onlyV ] ];
    v = Union[lv,iv,ov];  (* all vars *)

    (* Check that variable exists *)
    If[ variable =!= {},
      If[ !MemberQ[ v, variable ],
         Throw[ Message[ scheduleConstraints::wrgvar,variable ] ] ]
      ];

    dv = Union[lv,ov]; (* defined vars, i.e., local and output *)
    declarat = Map[getDeclaration,v]; (* Get declarations of all vars *)
    domains = Map[#1[[3]]&,declarat]; (* Get domains of all vars *)
    dims = Map[First[#1]&,domains];   (* Get dims of all vars *)

    (* Build list of tau coeffs *)
    coeffstau = 
	MapThread[Table[ToExpression[StringJoin["T",#2,"D",ToString[i]]],
                  {i,1,#1}]&,{dims,v}];
    If[slp === sameLinearPart ,coeffstau = 
	MapThread[If[MemberQ[lv,#2],Table[ToExpression["TD"<>ToString[i]],
                  {i,1,#3}],#1]&,
                  {coeffstau,v,dims}]
      ];

    (* Build list of alpha coeffs *)
    coeffsalpha = Map[ToExpression["A"<>#1]&,v];

    (* Compute dep table *)
    If[ !depcomp, 
        If[ dbg, Print[ "Computing dependency Table" ] ];
        $scheduleDepTable = 
           Check[ dep[ sys, options, parameterConstraints -> True,
                  subSystems -> True ], 
                  Throw[ Message[ scheduleConstraints::dep ]  ] ],
        If[ !MatchQ[ $scheduleDepTable, 
               dtable[{___depend},{___dependuse}] | dtable[{___depend}] ], 
            Throw[ Message[ scheduleConstraints::nodeptable ] ] ];
    ];

    (* First, keep only the dependencies needed *)
    If[ onlyD =!= all, 
      With[ {dept = $scheduleDepTable[[1]]}, 
        $scheduleDepTable = 
           dtable[ Table[ Part[ dept, onlyD[[i]] ] , {i, 1, Length[onlyD] } ] ]
      ]
    ];

    If[ vrb || dbg, Print["Dependencies kept are:"];
      show[ $scheduleDepTable ];
      Print["----------------------------"];
    ];

    (* Now, remove from dep Table all dependencies involving 
       needless variables *)

    (* The following does not work for use dep, therefore it
       was removed. Feb 5, 2004. It has to be checked *)

(*
    $scheduleDepTable = 
    dtable[
      With[ {dept = $scheduleDepTable[[1]]},
        Select[
          dept, 
          Function[{x},
            Module[{v1, v2},
              v1 = x[[2]]; v2 = x[[3]]; 
              MemberQ[ v, v1 ]&&MemberQ[ v, v2 ]
            ]
          ]
        ]
      ]
    ];

*)

    (* Modif 21/12/02 *)
    If[ dbg, Print["Dependency Table:\n", 
      ashow[$scheduleDepTable, silent->True] ] 
    ];
    If[ dbg, Print["Computing dependence constraints"] ];
   
    (* Check duration *)
    If[ dur === {}, 
        dur = Table[1, {i, 1, Length[ $scheduleDepTable[[1]] ]} ]  ];

    If[ Length[dur]=!=Length[ $scheduleDepTable[[1]]], 
        Throw[ Message[ scheduleConstraints::wrgduration ] ] ];
    
    (* Find defs *)
    Module[{ listvariables },
      (* Computes only constraints for variable, if said so *)
      listvariables = If[ variable =!= {}, {variable}, v];

      (* Call affineDepConsts on input variables *)
      result1 = 
        Map[ 
          affineDepConsts[ 
            depend[
              getDeclarationDomain[ # ],
              #,
              "",
              Null,
              _],
          v, 0, coeffstau, coeffsalpha, options]&,
          iv];

      (* Call affineDepConsts *)
      result = 
        MapThread[ affineDepConsts[ #1, v, #2, coeffstau, 
                                  coeffsalpha, options ]&, 
           {$scheduleDepTable[[1]], dur} ];

      (* Join all *)
      result = Join[ result1, result ];

    ]; (* Module *)

    (* Remove True *)
    result = Map[ Complement[ #, {True} ]&, result ];

    (* Get coefficients *)
    pos = Map[Position[v,#1][[1]][[1]]&,v];
    pos = Union[Flatten[Map[Part[coeffstau,#1]&,pos]],
                Flatten[Map[Part[coeffsalpha,#1]&,pos]]
                 ];

    If[!multidim,

      (* Unidimensional *)
      result = result/."ge"[x_,y_]->GreaterEqual[x,y];

      (* The function returns a list of dependence constraints, following the 
         order of the deptable, and the list of variables. As a side effect, 
         the global variable $scheduleConstraints is set *)
      $dependencyConstraints = 
         { Complement[ Apply[ Union, result ], {True} ] , pos };

      (* Use statements *)
      If[ sbs, 
        useConstraints = 
        If[ Length[$scheduleDepTable]=!=2, 
            If[ vrb, Print[ scheduleConstraints::noUse ] ]; {},
        Check[ useConstraints = 
              getUseSchedule[ $scheduleDepTable[[2]], options ], 
              Throw[ "Error while calling getUseSchedule..." ] ]
        ];

(*
	  getUseSchedule[ $scheduleDepTable[[2]], options, debug->True ];
*)  

        $dependencyConstraints = 
            {
              Union[ $dependencyConstraints[[1]], 
                   Apply[ Union, Map[ #[[1]]&, useConstraints ] ] ] ,
              Union[ $dependencyConstraints[[2]], 
                   Apply[ Union, Map[ #[[2]]&, useConstraints ] ] ]
            }
         ];

        $dependencyConstraints
      , (* else if !multidim *)

      (* Multidimensional *)
      Module[{aux, temp},
        (* Auxiliary function *)
        (* This function is called to built the final 
           form of the constraints. The index is used
           to build the number of the slack variable. 
           the c set of constraints correspond to entry
           number index of the dependence table. When 
           index is Null, one does not create dependence
           constraints: this is to cover the case of the 
           positivity constraints for the input variables
        *)
        Clear[ aux ];
        aux[ c:_, index:(_Integer|Null) ] := 
        Module[ {cons1, cons2, vars, cons3, cons},               
          (* Constraints of the form x>=1 *)
          cons1 = Cases[ c, "ge"[_,x_]/;x>0,2]; 
          (* Other constraints *)
          cons2 = Cases[ c, "ge"[x_,0]->x>=0,2]; 
          If[index=!=Null,
            cons1 = Table[cons1[[i]][[1]]>=
                        dur[[index]]*ToExpression["slack"<>ToString[index]],
                           {i,1,Length[cons1]}];
            vars = {ToExpression["slack"<>ToString[index]]};
          , (* else *)
            cons1 = {}; vars = {};
          ];
          cons3 = Map[0<=#1<=1&,vars];
          cons = Complement[Union[ cons3, cons1, cons2],{True}];
          {cons, vars}
        ]; (* End Module *)

        (* The first constraints are for the 
           inputs *)
        With[ { r1 = Take[result,Length[iv]], 
                r2 = Drop[result,Length[iv]]},
          temp = 
            MapThread[ aux, {r1, Table[ Null, { i, 1, Length[ r1 ] } ] } ];

          temp = 
            Join[ temp,
              MapThread[ aux, {r2, Table[ i,{ i, 1, Length[ r2 ] } ] } ]
            ];
        ];

        pos = Union[ pos, Apply[ Union, Map[ Last, temp ] ] ];
        (* Same result as in the unidimensional case *)
        $dependencyConstraints = { Map[ First, temp ], pos };
       
      ]
    ];

    (* Replace already found values, if reuseSchedule option is True *)
    If[ reuseS, 
      Module[ {rules,varNamesloc},
        (* This auxiliary function returns a list of rules 
           corresponding to results of the schedule *)
        Clear[auxFunction];
        auxFunction[{name:_String, {___String}, sched[values:{___Integer},
                   constant:_Integer]}]:=
        Module[ { tauCoeffs, alphaCoeff },
          tauCoeffs = 
            Table[ToExpression["T"<>name<>"D"<>ToString[i]]->values[[i]],
                            {i,1,Length[values]}];
          alphaCoeff = ToExpression["A"<>name] -> constant;
          Append[ tauCoeffs, alphaCoeff ]
        ];

        (* We compute all rules *)
        rules = Apply[Union,Map[auxFunction,$schedule[[2]]]];
        If[ dbg , Print[rules] ];

        (* And the variables *)
        varNamesloc = Map[First,rules];
        If[ dbg, Print[varNamesloc] ];

        (* Uptade dependency constraints *)
        $dependencyConstraints = 
        With[ {r = $dependencyConstraints[[1]], 
               v = $dependencyConstraints[[2]]},
          {Complement[r/.rules,{True}],Complement[v,varNamesloc]}
        ];
        If[ dbg, Print[$dependencyConstraints] ]
      ]
    ]; (* end If *)
    
    $dependencyConstraints
  ]
];
scheduleConstraints[___]:=Message[scheduleConstraints::params];
scheduleConstraints::wrgvar = "`1` is not a variable of this program.";
scheduleConstraints::nodeptable = "the dependency table has not been computed";
scheduleConstraints::dep = "error while computing the dependency table";

(* 
	This function produces the constraints needed to minimize
	the total time of a schedule. 
*)
Clear[timeMinSchedConstraints];
timeMinSchedConstraints::verticeserr = 
"Error while calling the vertices function";
timeMinSchedConstraints::rayserr = "Error while calling the rays function";
timeMinSchedConstraints::wrgvar = "`1` is not a variable of this program.";
timeMinSchedConstraints[options:___Rule]:=
	timeMinSchedConstraints[Alpha`$result,{},options];
timeMinSchedConstraints[sys:_Alpha`system,options:___Rule]:=
	timeMinSchedConstraints[sys,{},options];
timeMinSchedConstraints[variable:_String,options:___Rule]:=
	timeMinSchedConstraints[Alpha`$result,variable,options];
timeMinSchedConstraints[sys:_Alpha`system,variable:(_String|{}),options:___Rule]:=

Catch[
  Module[
   {lv,iv,ov,v,params,declarat,domains,dims,coeffstau,
    coeffsalpha,coeffsparams,aparam,slp,verb,dbg,depcomp,df,reuseS,onlyV,onlyE},

    (* Check value of system *)
    If[sys==={},Throw[Message[timeMinSchedConstraints::emptyprog]] ];

    (* Consider only normalized systems *)
    If[!normalizeQ[sys],Throw[Message[timeMinSchedConstraints::norm]] ];
 
    (* Get options *)
    { slp, verb, dbg, depcomp, df, onlyV, onlyE, reuseS } = 
	{scheduleType, verbose, debug, depComputed, dataFlow, 
         onlyVars, onlyEquations, reuseSchedule }/.
		{options}/.Options[timeMinSchedConstraints];

    (* Reset $optimalityConstraints *)
    $optimalityConstraints = {};

    (* Compute variables *)
    lv = getLocalVars[]; (* local vars *)
    (* Remove unneeded variables *)
    If[ onlyV =!= all, lv = Intersection[ lv, onlyV ] ];
    iv = getInputVars[]; (* input vars *)
    (* Remove unneeded variables *)
    If[ onlyV =!= all, iv = Intersection[ iv, onlyV ] ];
    ov = getOutputVars[]; (* output vars *)
    (* Remove unneeded variables *)
    If[ onlyV =!= all, ov = Intersection[ ov, onlyV ] ];
    v = Union[lv,iv,ov];  (* all vars *)

    If[ dbg, Print["Computing time minimal constraints." ] ];
    (* Check that variable exists, if system called for one variable only *)
    If[ variable =!= {}, 
    If[ Complement[{variable}, v ]=!={},
       Throw[Message[timeMinSchedConstraints::wrgvar,variable]] ] ];

    declarat = Map[getDeclaration,v]; (* Get declarations of all vars *)
    domains = Map[#1[[3]]&,declarat]; (* Get domains of all vars *)
    dims = Map[First[#1]&,domains];   (* Get dims of all vars *)

    (* Build list of tau coeffs *)
    coeffstau = 
	MapThread[Table[ToExpression[StringJoin["T",#2,"D",ToString[i]]],
                        {i,1,#1}]&,{dims,v}];
    If[slp === sameLinearPart, 
       coeffstau = 
	MapThread[If[MemberQ[lv,#2],Table[ToExpression["TD"<>ToString[i]],
                                          {i,1,#3}],#1]&,
                  {coeffstau,v,dims}] 
      ];

    (* Build list of alpha coeffs *)
    coeffsalpha = Map[ToExpression["A"<>#1]&,v];

    (* Get list of parameters *)
    params = sys[[2]][[2]];

    (* Build list of params coefficients *)
    coeffsparams = Map[ToExpression["T"<>#1]&,params];

    (* NB: The name of constant for param is aparam *)

    (* This auxiliary function computes the set of constraints 
       for one particular variable, and is intended to be used aftewards
       by a Map *)
    Clear[aux];
    aux[varaux:_String]:=
    Module[{ve,ra,defs,cposv,cnewposv,cposr,cnewposr,
            posl,cl,constl,vetrunc,ratrunc},
      posl=Position[v,varaux][[1]][[1]]; (* Get position of lhs symbol *)
      cl=coeffstau[[posl]];constl=coeffsalpha[[posl]]; (* coeffs and constant of lhs symbol *)

      (* Compute declaration domain of varaux *)
      Module[{dom = getDeclarationDomain[varaux]},
     
     	If[dbg,Print["Variable ", varaux, "\n"] ];
	If[dbg,Print["Domain : ", varaux, "\n"]; show[dom,silent->True] ];
	
        (* If dom is a union, replace it by its convex closure *)
        If[ Length[ dom[[3]] ]>1, dom = DomConvex[ dom ] ];

        (* Vertices and rays *)
        ve = Check[vertices[dom],
                   Throw[Message[timMinSchedConstraints::verticeserr]]];
        ra = Check[rays[dom],
                   Throw[Message[timMinSchedConstraints::raysserr]]];
        If[dbg,Print["Vertices: ",ve, "\nRays: ",ra] ];

        (* Vertices and rays truncated *)
	vetrunc = Map[Take[#1,-Length[params]]&,ve];
	raytrunc = Map[Take[#1,-Length[params]]&,ra]; 

	(* Remove rays with 0 in parameters *)
	(* Il faut oser le faire! Explanations: transpose {ra, raytrunc} to 
	   build pairs of rays and raytruncated, then select only those pairs
           such that one component of raytrunc is non zero at least, transpose
           the selected list, and re assign to ra and raytrunc. *)
	If[ df, 
	{ra, raytrunc} = 
           If[ raytrunc === {{}}, {ra, {{}}}, 
		Transpose[ 
			Select [ Transpose [{ ra, raytrunc }], 
			         !Apply[ And, Map[ # === 0&, #[[2]] ] ]& 
				] (* Select *)
			 ] ] (* Transpose *)
	]; 
        If[dbg,Print["Vertices truncated to params: ",
               vetrunc, "\nRays on params: ",raytrunc] ]; 

	(* Positivity constraints on vertices *)
(*
        cnewposv = 
          Map[
            Global`aparam - constl +
            (Join[Table[0,{i,1,Length[cl]-Length[coeffsparams]}],
                  coeffsparams] - cl).# >= 0&, ve
          ];
*)
        cposv = 
          MapThread[coeffsparams.#1 + 
                    Global`aparam - cl.#2 - constl>=0&,{vetrunc,ve}]; 
        If[dbg,Print["Positivity on vertices: ", cposv] ];
(*
        If[Simplify[ cnewposv ] =!= Simplify [ cposv ], 
           Throw["Error while computing truncated vertices"]];
*)
	(* Constraints on Rays *)
(*
        cnewposr = 
          Map[
            (Join[Table[0,{i,1,Length[cl]-Length[coeffsparams]}],
                  coeffsparams] - cl).# >= 0&, ra
          ];
*)
        cposr = MapThread[coeffsparams.#1 - cl.#2 >=0&,{raytrunc,ra}]; 
(*
        If[ Simplify[ cnewposr ] =!= Simplify [ cposr ],
            Throw["Error while computing truncated rays"]];
*)
        If[dbg,Print["Positivity on rays: ", cposr] ];

        Union[cposr,cposv]
           ]  (* With *)
         ]; (* Module *)
    (* End of aux function *)

    (* Computes only constraints for variable var, if said so *)
    If[ variable=!={}, v = variable ];

    (* Apply aux function to each variable, and build result *)
    result = Map[ {#, Complement[ aux[#], {True} ]}&, v];

    (* Get list of coefficients *)
    pos = Map[Position[v,#1][[1]][[1]]&,v];
    pos = Union[Flatten[Map[Part[coeffstau,#1]&,pos]],
                Flatten[Map[Part[coeffsalpha,#1]&,pos]]
               ];

    (* Set global variables *)
    pos = Union[ pos, coeffsparams, {Global`aparam} ];
    $optimalityConstraints = { result, pos };

    (* Replace already found values, if reuseSchedule option is True *)
    If[ reuseS, 
      Module[ {rules,varNamesloc},
        (* This auxiliary function returns a list of rules 
           corresponding to results of the schedule *)
        Clear[auxFunction];
        auxFunction[{name:_String, {___String}, sched[values:{___Integer},
                   constant:_Integer]}]:=
        Module[ { tauCoeffs, alphaCoeff },
          tauCoeffs = 
            Table[ToExpression["T"<>name<>"D"<>ToString[i]]->values[[i]],
                            {i,1,Length[values]}];
          alphaCoeff = ToExpression["A"<>name] -> constant;
          Append[ tauCoeffs, alphaCoeff ]
        ];

        (* We compute all rules *)
        rules = Apply[Union,Map[auxFunction,$schedule[[2]]]];
        If[ dbg, Print[rules] ];
        (* And the variables *)
        varNamesloc = Map[First,rules];
        If[ dbg, Print[varNamesloc] ];

        (* Uptade dependency constraints *)
        $optimalityConstraints = 
        With[ {r = $optimalityConstraints[[1]], 
               v = $optimalityConstraints[[2]]},
          {Complement[r/.rules,{True}],Complement[v,varNamesloc]}
        ];
        If[ dbg, Print[$optimalityConstraints] ];
      ]
    ]; (* end If *)
    
    $optimalityConstraints


    ]
];
timeMinSchedConstraints[___]:=Message[timeMinSchedConstraints::params];

Clear[checkSchedOptions];
scd::wrglib = 
"the variable $scheduleLibrary does not have a format suited to 
vertex schedule.";
scd::params = "called with wrong parameters.";
scd::norm = "input system is not normalized.";
scd::emptyprog = "input system empty.";
scd::verboseOpt = "`1` is not a value for the verbose Option";
scd::debugOpt = "`1` is not a value for the debug Option";
scd::resolutionSoftOpt = "`1` is not a value for the resolutionSoft Option";
scd::integerSolutionOpt = "`1` is not a value for the integerSolution Option";
scd::addConstraintsOpt = "`1` is not a value for the addConstraints Option";
scd::durationsOpt = "`1` is not a value for the durations Option";
scd::periodsOpt = "`1` is not a value for the periods Option";
scd::onlyVarOpt = "`1` is not a value for the onlyVars Option";
scd::onlyDepOpt = "`1` is not a value for the onlyDep Option";
scd::scheduleTypeOpt = "`1` is not a value for the scheduleType Option";
scd::optimizationTypeOpt = 
  "`1` is not a value for the optimizationType Option";
scd::objFunctionOpt = 
"`1` is not a value for the objFunction Option";
scd::verticesPositiveOpt = 
"`1` is not a value for the verticesPositive Option";
scd::subSystemSchedOpt = 
"`1` is not a value for the subSystemSched Option";
scd::multidimensionalOpt = 
"`1` is not a value for the multidimensional Option";
scd::depComputedOpt = 
"`1` is not a value for the depComputed Option";
scd::dataFlowVariablesOpt = 
"`1` is not a value for the dataFlowVariables Option";
scd::dataFlowOpt = 
"`1` is not a value for the dataFlow Option";
scd::dataFlowPeriodOpt = 
"`1` is not a value for the dataFlowPeriod Option";
scd::subSystemsOpt = 
"`1` is not a value for the subSystems Option";
scd::dataFlowObjectiveOpt = 
"`1` is not a value for the dataFlowObjective Option";
scd::eliminatesDoublesOpt = 
"`1` is not a value for the eliminatesDoubles Option";
scd::unknownOpt = "`1` is not an Option of scd";
checkSchedOptions[ opts:___Rule ]:=
Catch[
  Module[{vrb, dbg, resSoft, intSol, addC, dur, onlyV, schedType, 
          optType, objFunc, verticesPos, subsSched, multidim, depC, 
          dfV, df, dfP, subS, dfObj, elimD, reuseS, per },
    With[ {unO = Complement[ {opts}/.(x_->y_)->x, 
                            Options[ scd ]/.(x_->y_)->x ]},
          If[ unO =!= {}, Map[ Message[ scd::unknownOpt,# ]&, unO ];
                          Throw[ "Abcd" ]];
    ]; 

    vrb = verbose/.{opts}/.Options[scd];
    If[ !MatchQ[vrb,(True|False)],
        Throw[ Message[ scd::verboseOpt, vrb ] ] ];

    dbg = debug/.{opts}/.Options[scd];
    If[ !MatchQ[dbg,(True|False)],
        Throw[ Message[ scd::debugOpt, dbg ] ] ];

    resSoft = resolutionSoft/.{opts}/.Options[scd];
    If[ !MatchQ[resSoft,(MMA|PiP|LpSolve)],
        Throw[ Message[ scd::resolutionSoftOpt, resSoft ] ] ];

    intSol = integerSolution/.{opts}/.Options[scd];
    If[ !MatchQ[intSol,(True|False)],
        Throw[ Message[ scd::integerSolutionOpt, intSol ] ] ];

    addC = addConstraints/.{opts}/.Options[scd];
    If[ !MatchQ[addC,{___}],
        Throw[ Message[ scd::addConstraintsOpt, addC ] ] ];

    dur = durations/.{opts}/.Options[scd];
    If[ !MatchQ[dur,{___Integer}],
        Throw[ Message[ scd::durationsOpt, dur ] ] ];

    per = periods/.{opts}/.Options[scd];
    If[ !MatchQ[per,{___Integer}],
        Throw[ Message[ scd::periodsOpt, dur ] ] ];

    onlyV = onlyVars/.{opts}/.Options[scd];
    If[ !MatchQ[onlyV,(all|{___String})],
        Throw[ Message[ scd::onlyVarOpt, onlyV ] ] ];

    onlyD = onlyDep/.{opts}/.Options[scd];
    If[ !MatchQ[onlyD,(all|{___Integer})],
        Throw[ Message[ scd::onlyDepOpt, onlyD ] ] ];

    schedType = scheduleType/.{opts}/.Options[scd];
    If[ !MatchQ[schedType,(affineByVar|sameLinearPart)],
        Throw[ Message[ scd::scheduleTypeOpt, schedType ] ] ];

    optType = optimizationType/.{opts}/.Options[scd];
    If[ !MatchQ[optType,(time|Null|delay)],
        Throw[ Message[ scd::optimizationTypeOpt, optType ] ] ];

    objFunc = objFunction/.{opts}/.Options[scd];
    If[ !MatchQ[objFunc,(lexicographic|_)],
        Throw[ Message[ scd::objectiveFunctionOpt, objFunc ] ] ];
    
    verticesPos = verticesPositive/.{opts}/.Options[scd];
    If[ !MatchQ[verticesPos,(True|False)],
        Throw[ Message[ scd::verticesPositiveOpt, verticesPos ] ] ];

    subsSched = subSystemSched/.{opts}/.Options[scd];
    If[ !MatchQ[subsSched,({}|_)],
        Throw[ Message[ scd::subSystemSchedOpt, subsSched ] ] ];

    multidim = multidimensional/.{opts}/.Options[scd];
    If[ !MatchQ[multidim,(True|False)],
        Throw[ Message[ scd::multidimensionalOpt, multidim ] ] ];

    depC = depComputed/.{opts}/.Options[scd];
    If[ !MatchQ[depC,(True|False)],
        Throw[ Message[ scd::depComputedOpt, depC ] ] ];

    dfV = dataFlowVariables/.{opts}/.Options[scd];
    If[ !MatchQ[dfV,(all|{___})],
        Throw[ Message[ scd::dataFlowVariablesOpt, dfV ] ] ];

    df = dataFlow/.{opts}/.Options[scd];
    If[ !MatchQ[df,(True|False)],
        Throw[ Message[ scd::dataFlowOpt, df ] ] ];

    dfP = dataFlowPeriod/.{opts}/.Options[scd];
    If[ !MatchQ[dfP,(_Integer|True)],
        Throw[ Message[ scd::dataFlowPeriodOpt, dfP ] ] ];

    subS = subSystems/.{opts}/.Options[scd];
    If[ !MatchQ[subS,(True|False)],
        Throw[ Message[ scd::subSystemsOpt, subS ] ] ];

    dfObj = dataFlowObjective/.{opts}/.Options[scd];
    If[ !MatchQ[dfObj,_],
        Throw[ Message[ scd::dataFlowObjectiveOpt, dfObj ] ] ];

    elimD = eliminatesDoubles/.{opts}/.Options[scd];
    If[ !MatchQ[elimD,(True|False)],
        Throw[ Message[ scd::eliminatesDoublesOpt, elimD ] ] ];

  ];
];
(*
checkSchedOptions[___]:=Message[checkSchedOptions::params];
    yyy = xxx/.{opts}/.Options[scd];
    If[ !MatchQ[yyy,(True|False)],
        Throw[ Message[ scd::xxxOpt, yyy ] ] ];
scd::xxxxOpt = "`1` is not a value for the xxxx Option";
*)

(* 

*)
Clear[scd];
scd::nosol2d = "No multidimensional solution";
scd::error1 = "Error while calling scheduleConstraints";
scd::error2 = "Error while calling timeMinSchedConstraints";
scd::work = "dataFlow and subsystems are not compatible options (at least, for now)";
scd::nosol2D = "I could not find out a 2D schedule";
scd::nosolDF = "While looking for a data-flow schedule, I could not find out a 2D schedule";
scd[options:___Rule]:=scd[$result,options];

(* ---------------- Unidimensional case *)
scd::extracud = "addConstraints must be a simple list in the unidimensional case";
scd[ sys:_Alpha`system, options:___Rule]/;
And[Not[multidimensional/.{options}/.Options[scd]],
Not[dataFlow/.{options}/.Options[scd]]]:=
Catch[
  
  Check[ checkSchedOptions[ options ], Throw[ Null ] ];

  (* Check value of system *)
  If[ sys==={},Throw[scd::emptyProg] ];

  Module[ { vrb, dbg, c, c1, v, o, params, solution, objectivef, 
            multidim, rf, objf, constraints, depcomp, df, extrac, dfCN, 
            dfp, optType, optsubsystems, svs, stucturedOrNot },

    (* Getting options *)
    dbg = debug/.{options}/.Options[scd];
    slp = scheduleType/.{options}/.Options[scd];
    objf = objFunction/.{options}/.Options[scd];
    If[ objf === lexicographic, objf = Null ]; (* Kludge *)
    depcomp = depComputed/.{options}/.Options[scd];
    vrb = verbose/.{options}/.Options[scd];
    optType = optimizationType/.{options}/.Options[scd]; 
    optsubsystems = subSystems/.{options}/.Options[scd];
    svs = saveSchedule/.{options}/.Options[scd];

    If[ dbg, Print["We are in the unidimensional variant..."] ];

    (* Get extra constraints *)
    extrac = addConstraints/.{options}/.Options[scheduleConstraints]; 
    If[ !MatchQ[extrac, {___}], Throw[Message[ scd::extracud ] ] ];

    (* Getting the dependency constraints *)
    If[ dbg, Print[ "Calling scheduleConstraints"] ];
    c = Check[ scheduleConstraints[ sys, options ], 
        Throw[ Message[ scd::error1 ] ] ]; 

    (* Getting the optimality constraints *)
    If[ optType === time, 
        (If[ vrb, Print[ "Calling timeMinSchedConstraints" ] ];
        o = Check[ timeMinSchedConstraints[ sys, options ], 
            Throw[ Message[ scd::error2 ] ] ]),
        o = {{},{}}];

    (* Get system parameters *)
    params = sys[[2]][[2]];

    (* If empty params, set objf to constant *)
    If[ params === {} && ! multidim , objf = 1 ];

    (* To optimize, consider first parameter in priority *)
    params = Map[ToExpression["T"<>#1]&, params];

    (* Look for unidimensional schedule *)
    If[ vrb, Print["Looking for a unidimensional schedule..."] ];

    (* Get variables *)
    v = Union[ c[[2]], o[[2]] ]; 

    (* Get dependency constraints *)
    c = c[[1]];
    If[ vrb, Print[ "Dependency constraints: ", c ] ];

    (* Idem optimization constraints *)
    o = If[ o[[1]] === {}, {}, Apply[ Union, Map[ Last, o[[1]] ] ] ];
    If[ vrb, Print[ "Optimisation constraints: ", o ] ];

    (* Total constraints (including extra constraints) *)
    c = Union[ c, o, extrac ]; 
 
    If[MemberQ[ c, False],
       (Print["No unidimensional schedule (False)"]; 
        $schedule = {};Throw[Null])
    ];

    (* Set objective function, first param default *)
    objectivef = 
      Which[
            objf =!= Null, objf,
            optType === time && params === {}, 1, 
            optType === time , params[[1]],
            optType =!= time , 1
           ];

    (* Set $scheduleMDSol *)
    $scheduleMDSol[ 1 ] = {objectivef, c, v};

    (* Call simplex *)
    solution = 
      Check[simplex[ objectivef, c, v ] (* simplex *),
            (Print["No unidimensional schedule"];
            $schedule = {};Throw[Null])
      ]; (* End Check *)


    (* Set $scheduleSolution *)
    If[vrb, Print["Solution to simplex :"]; Print[solution]];
    $scheduleMDSol[ 1 ] = { objectivef, c, v, solution }; 
    $schedule = encodeSchedule[ sys, params, solution, options ];

    (* Add new schedule to the library *)
    $scheduleLibrary = storeSchedule[ sys, sys[[2]][[2]], $schedule, options ]; 
    If[ svs, 
      Module[ {fname},
        fname = $result[[1]]<>".scd";
        If[ FileInformation[ fname ], DeleteFile[ fname ] ];
        Put[ $schedule, fname ];
        Print[ "Schedule was saved in file ", fname ];
      ]
    ];

    (* Set $runTime *)
    (* The result is the name of the system, the number of
       variables, constraints, time, the method (vertex of farkas)
       and structured of flat *)
    $runTime = {sys[[1]], Length[v], Length[c], $runTime, "Vertex",
                If[ Cases[sys[[6]], use[___] ] === {}, "Flat", "Structured" ]
               };

    (* Done July 10, 2004, PQ, to avoid a bug when $runTime is not
       set. Would be better to identify the origin of the bug... *)
    If[ !MatchQ[ $runTime, _List ], 
      Print["Warning: $runTime was set to {}"];$runTime = {}
    ];
    Print[ $runTime ];
    If[ MatchQ[ $schedule, scheduleResult[___] ], 
      $runTime = Append[ $runTime, Last[ $schedule ] ] ];

    (* Return $schedule *)
    $schedule
  ]  (* Module *)
];  (* Catch *)

(* Data Flow Option *)
scd::dfp = "the dataFlowPeriod cannot be less than 1";
scd::dfv = 
"variables `1` in the dataFlowVariables options are not variables of this program";
scd::extracdf = 
"extra constraints should be a list of list of constraints for a dataflow schedule"; 
scd[ sys:_Alpha`system, options:___Rule]/;
(dataFlow/.{options}) === True :=
Catch[
 
  Check[ checkSchedOptions[ options ], Throw[ Null ] ];

  (* Check value of system *)
  If[sys==={},Throw[sched::emptyProg] ];

  Module[ 
    { vrb, dbg, c, v, o, params, solution, multidim, rf, objf, objectivef,
      constraints, depcomp, df, extrac, dfCN, dfp, slv, oldslv, sc, sol, d,
      tempdt, tempudt, vorigine, vextremite, unsatisfiedEdges, 
      firstDimC, otherC, r, cons, constantC, dv, depC, cwithd, cwithoutd,
      dur, dfo, temp, svs, niv, per },

    (* Getting options *)
    dfo = dataFlowObjective/.{options}/.Options[scd];
    dur = durations/.{options}/.Options[scd];
    per = periods/.{options}/.Options[scd];
    dbg = debug/.{options}/.Options[scd];
    slp = scheduleType/.{options}/.Options[scd];
    objf = objectiveFunction/.{options}/.Options[scd];
    depcomp = depComputed/.{options}/.Options[scd];
    vrb = verbose/.{options}/.Options[scd];
    df = dataFlow/.{options}/.Options[scd];
    dfV = dataFlowVariables/.{options}/.Options[scd];
    svs = saveSchedule/.{options}/.Options[scd];

(* Check option *)
    If[ dfV =!= all, 
      temp = Complement[Map[ToString,dfV],getVariables[sys]];
      If[ temp =!= {}, Throw[Message[scd::dfv,temp] ] ]
    ];

(* Number of input variables *)
    niv = Length[ getInputVars[] ];

    dfCN = dataFlowConstantsNull/.{options}/.Options[scd];
    dfp = dataFlowPeriod/.{options}/.Options[scd];
    If[ IntegerQ[ dfp ] && dfp < 1, Throw[ Message[ scd::dfp ] ] ];
    sbs = subsystems/.{options}/.Options[scd];

    If[ dbg, Print["We are in the dataFlow variant..."] ];

    (* Subsystems are not handled for the moment *)
    If[ sbs, Throw[ Message[ scd::work ] ] ];

    (* Get extra constraints *)
    extrac = addConstraints/.{options}/.Options[scheduleConstraints]; 
    (* Check *)
    If[ extrac =!= {}&&!MatchQ[ extrac, { _List,__List }], 
        Throw[ Message[scd::extracdf] ] ];

    (* Force multidim *)
    multidim = True;

    (* Getting the dependency constraints *)
    Print[ "Calling scheduleConstraints to compute the constraints with unit delays" ];

    (* Call scheduleConstraints without durations *)
    cwithoutd = Check[ scheduleConstraints[ sys, 
                 verbose -> vrb, 
                 multidimensional -> multidim, 
                 depComputed -> depcomp,
                 dataFlow -> df, debug -> dbg, verbose->vrb ],
                 Throw[ Null ] ];

    (* Normal call *)
    If[ dur =!= {}, 
      Print[ "Calling scheduleConstraints to compute the constraints with specified durations" ];
      cwithd = Check[ scheduleConstraints[ sys, options], Throw[Null] ],
      cwithd = cwithoutd
    ];

    If[ dbg, Print["cwithoutd: ", cwithoutd] ]; 
    If[ dbg, Print["cwithd: ", cwithd] ]; 

    (* Getting the optimality constraints *)
    Print[ "Calling ", timeMinSchedConstraints ];
    o = Check[ timeMinSchedConstraints[ sys, options], Throw[Null] ];

    (* Get system parameters *)
    params = sys[[2]][[2]];

    (* If empty params, set objf to constant *)
    If[ params === {} && ! multidim , objf = 1 ];

    (* Build the list of parameter variables in the form "Tparam" *)
    params = Map[ToExpression["T"<>#1]&, params];

    If[ vrb||dbg, Print["Looking for a dataflow schedule..."] ];

    (* We first gather all the constraints without delay (see the output 
       format of scheduleConstraints), in order to check that there is 
       no unsatisfied constraint *)
    c = Apply[ Union, cwithoutd[[1]] ];

    (* Add extra constraints (option) *)
    c = Union[ c, If[extrac==={}, {}, extrac[[1]]] ]; 
    If[ vrb||dbg, Print[ "Dependency constraints :\n", c ] ];
    If[ vrb||dbg, Print[ "Variables : ", $dependencyConstraints[[2]] ] ];
    
    (* Check first that constraints do not contain already False *)
    If[MemberQ[ c, False],
       (Print["No dataflow schedule"]; $schedule = {};Throw[Null])
    ];

    (* Initialize list of unsatisfied edges *)
    unsatisfiedEdges = Range[ 1, Length[ $scheduleDepTable[[1]] ] ];
    If[ vrb||dbg, Print[ "Unsatisfied edges are: ", unsatisfiedEdges ] ];

    (* find the list of slack variables *)
    slv = Select[$dependencyConstraints[[2]], 
                 StringMatchQ[ToString[#1],"slack*"]&];
    If[ vrb||dbg, Print[ "Slack variables :\n", slv ] ];

    d = 1; Clear[$scheduleMDSol];

(*  Consider the first level *)

    Print["Dimension : ", d ];

    (* for the dataflow option, the first run is automatic: 
       all first dim coefficients get the same value (1), all other 
       the value 0, except the coefficients of the parameters 
       and the slack *)

    (* variables *)
    depC = $dependencyConstraints[[2]]; 

    (* Get the list of first dimension variables *)
    firstDimC = Select[ depC,
                        StringTake[ ToString[#], -2 ] === "D1"& ];

    (* Keep only those variables which are listed in the 
       dataFlowVariable option, if it is set *)
    If[ dfV =!= all, 
        firstDimC = 
          Intersection[ 
            firstDimC, 
            Map[ ToExpression[ "T"<>ToString[#]<>"D1"] &, dfV ] 
          ]  
        ];

    If[ vrb||dbg, Print["Coefficients which are kept: ", firstDimC ] ];

    (* Get list of constants. If the dataFlowConstantNull option is set, 
       these constants will be forced to 0 *)
    constantC = 
        If[ dfCN, {}, Select[ depC, 
                            StringTake[ ToString[#], 1 ] === "A"& ] ];

    (* Other coefficients *)
    otherC = Complement[ $optimalityConstraints[[2]],
                         Union[ firstDimC, slv, params, {Global`aparam},
                                constantC ] ];

    (* Compute partial solution. We force first coefficients to be either
       dfp if it is an integer, or just equal otherwise *)
    If[ IntegerQ[dfp], 
        r = Union[ Map[ # == dfp&, firstDimC ], Map[ # == 0&, otherC ] ], 
        r = If[ Length[ firstDimC ] >= 1, 
                Union[ MapThread[ #1 == #2&, 
                                  {Drop[firstDimC,-1],Drop[firstDimC,1]} 
                                 ], {firstDimC[[1]]>=1}, Map[ # == 0&, otherC ] ],
                {}];
    ];

    (* Remove satisfied constraints *)
    r = Complement[ r, {True} ];

    If[ vrb||dbg, Print["Partial solution: ", r ] ]; 

    (* Take dependency constraints, and r *)
    c = Union[ r, Apply[ Union, cwithoutd[[1]] ], 
               If[ extrac==={}, {}, extrac[[1]]] ];
    If[ vrb||dbg, Print["Dependence constraints:\n", c] ]; 

    (* Take only dependency variables *)
    v = $dependencyConstraints[[2]];
    If[ dbg, Print["Variables :\n", v ] ]; 

    (* Look for unsatisfied constraints *)
    cons = c/.Map[#[[1]]->#[[2]]&, r] ;
    cons =  Select[Transpose[{ c, cons }],
                   Part[ #, 2] === False &];
    If[ cons =!= {},
        Throw[ Message[ scd::nosolDF ];
               Print[ "Unsolvable constraints are \n:", cons] ] ];

    (* Select objective function *)
    If[ dbg||vrb, Print[ " slack variables : ", slv ] ]; 
    If[ dbg||vrb, Print[ " parameters : ", params ] ]; 
    objectivef = - Apply[ Plus, slv ];
    If[ dbg||vrb, Print[ " objective function ", objectivef ] ]; 

    (* Store problem, to be able to have information if the simplex call
       fails... *)
    $scheduleMDSol[ d ] = { objectivef, c, v };

    If[ vrb||dbg, 
      Print[ "Calling simplex: ", "objective function: ", objectivef, 
      "\nconstraints: ", c, "\nvariables: ", v ] ]; 
    (* Call simplex *)
    Check[ 
        sol = simplex[ objectivef, c, v ],
        Throw [Message[ scd::nosol2d ] ];
    ]; (* End Check *)

    (* Store problem and solution *)
    $scheduleMDSol[ d ] = { objectivef, c, v, sol };

    (* Keep slack variables which are not 1 *)
    oldslv = slv; 
    If[ dbg, Print["Slack variables before : ", oldslv ] ]; 
    If[ dbg, Print["Solution : ", sol[[2]]]];
    slv = MapThread[ If [#2 < 1, #1, Null]&, {slv, slv/.sol[[2]]}];
    slv = Complement[ slv, {Null} ];
    If[ dbg, Print["New Slack variables : ", slv ] ]; 
    If[ slv === oldslv, Throw[ "Stop!" ] ];

    (* A second run is provided, only if the dataFlowObjective option is
       set *)
    (* Run simplex again, setting all the slack variables to 1 *)

    If[ dfo =!= Null,
      Print["Second run of the simplex, for first dimension"];
      c = Union[ Apply[ Union, cwithd[[1]]], 
                 Map[ #==1&, Complement[oldslv,slv] ], r,
                 If[ extrac==={}, {}, extrac[[1]]] ];
      Check[ 
        sol = simplex[ dfo, c, v ], 
        Throw [Message[ scd::nosol2d ] ];
      ];

      If[ vrb&&dbg, Print["Solution : ", sol ] ]; 
      If[ !IntegerQ[ sol[[1]] ], Throw[ Message[ scd::notrat ] ] ]; 

      (* Keep Solution *)
      $scheduleMDSol[ d ] = {objectivef, c, v, sol};
      If[ sol === Null, Throw[Null] ]

    ];  (* If *)

    (* Compute unsaturated edges of the dependence graph *)
    (* Number of the slack variables which are equal to 1, they
       give the rank of the dependencies satisfied *)
    sc = Cases[ sol[[2]], y:(x:_->1)/;MemberQ[ oldslv, x ]->y ];
    sc = Map[ ToExpression[ StringDrop[ ToString[#[[1]]], 5 ] ]&, sc ];

    (* Show dependencies unsatisfied *)
    unsatisfiedEdges = Complement[ unsatisfiedEdges, sc ];
    If[ vrb, Print["Unsatisfied edges: ", unsatisfiedEdges ] ]; 
    If[ unsatisfiedEdges === {}, Break[] ];

    (* Select constraints corresponding to non satisfied edges *)
    tempudt = dtable[ Map[ Part[ $scheduleDepTable[[1]], # ]&, 
              unsatisfiedEdges ] ];
    If[ vrb, 
      Print["Unsatisfied dependencies :\n", show[ tempudt, silent->True ] ] ];

    (* To get the dependencies, one selects in $dependencyConstraints 
       the constraints corresponding to the unsatisfiedEdges of the
       dependence graph. However, one need to drop the first niv
       elements, which correspond to the positivity constraints on 
       the inputs *)
    s = Map[ Part[ Drop[$dependencyConstraints[[1]],niv], #]&, 
          unsatisfiedEdges ]; 
    s = Union[ s, Take[$dependencyConstraints[[1]],niv] ];

    (* Get the constraints for the next run, including extra constraints *)
    c = Union[ Apply[ Union, s ], If[ Length[extrac]>=2, extrac[[2]],{}] ]; 

    d = d+1;

    While[  
      c =!= {} , 

      Print["Dimension : ", d ];

      (* Compute the variables which are still in the dependence graph *)
      (* Origins of edges *)
      vorigine = Map[ Part[ #, 2]&, tempudt[[1]] ];  

      (* Extremities of edges *)
      vextremite = Map[ Part[ #, 3]&, tempudt[[1]] ];  

      If[ vrb, Print[ "Origin variables: ", vorigine, 
          "\nExtremity variables: ", vextremite ] ]; 

      (* extremities which are not origins *)
      vextremite = Complement[ vextremite, vorigine ];

      (* Keep only the optimality constraints which correspond
         to origin vertices *)
      o = Select[ $optimalityConstraints[[1]], 
                  Function[{x}, MemberQ[ vorigine, x[[1]] ] ] ];
      If[ vrb, Print[ "Variables which are still in : ", o ] ];
      c = Union[ c, Apply[ Union, Map[ Last, o ] ] ];              
      If[ vrb, Print["Constraints : ", c ] ];
      v = Union[ slv, $optimalityConstraints[[2]] ]; 
      If[ vrb, Print[ "Variables: ", v ] ]; 
       
      (* Add constraints to keep 0 the first dimension coefficients *)
      c = Union[ c, Map[ # == 0&, firstDimC ] ];

      (* Now, we are ready to look for the schedule *)
      (* Select objective function *)
      If[ dbg||vrb, Print[ " slack variables : ", slv ] ]; 
      If[ dbg||vrb, Print[ " parameters : ", params ] ]; 
      objectivef = 
        Which[ 
         (* No parameters *)
         params === {}, - Apply[ Plus, slv ], 
         (* Otherwise *)
         True , 
           params.Reverse[Table[10^i,{i,1,Length[params]}]]
              - 10^(Length[params]+1)* Apply[Plus, slv]
         ];
      If[ dbg||vrb, Print[ " objective function ", objectivef ] ]; 

      (* Store problem, to be able to have information if the simplex call
         fails... *)
      $scheduleMDSol[ d ] := { objectivef, c, v };

      If[ vrb||dbg, Print[ "Calling simplex: ", "objective function: ", objectivef, 
      "\nconstraints: ", c, "\nvariables: ", v ] ]; 
      (* Call simplex *)
      Check[ 
          sol = simplex[ objectivef, c, v ],
          Throw [Message[ scd::nosol2d ] ];
      ]; (* End Check *)

      (* Store problem and solution *)
      $scheduleMDSol[ d ] := { objectivef, c, v, sol };

      (* Keep slack variables which are not 1 *)
      oldslv = slv; 
      If[ dbg, Print["Slack variables before : ", oldslv ] ]; 
      slv = MapThread[ If [#2 < 1, #1, Null]&, {slv, slv/.sol[[2]]}];
      slv = Complement[ slv, {Null} ];
      If[ vrb||dbg, Print["New Slack variables : ", slv ] ]; 
      If[ slv === oldslv, Throw[ "Stop!" ] ];

      (* Compute unsaturated edges of the dependence graph *)
      (* Number of the slack variables which are equal to 1, they
         give the rank of the dependencies satisfied *)
      sc = Cases[ sol[[2]], y:(x:_->1)/;MemberQ[ oldslv, x ]->y ];
      sc = Map[ ToExpression[ StringDrop[ ToString[#[[1]]], 5 ] ]&, sc ];

      (* Show dependencies unsatisfied *)
      unsatisfiedEdges = Complement[ unsatisfiedEdges, sc ];
      If[ vrb, Print["Unsatisfied edges: ", unsatisfiedEdges ] ]; 
      If[ unsatisfiedEdges === {}, Break[] ];

      (* Select constraints corresponding to non satisfied edges *)
      tempudt = dtable[ Map[ Part[ $scheduleDepTable[[1]], # ]&, 
                unsatisfiedEdges ] ];
      If[ vrb, Print["Unsatisfied dependencies :\n", show[ tempudt, silent->True ] ] ];
      s = Map[ Part[ $dependencyConstraints[[1]], #]&, unsatisfiedEdges ]; 

      (* Get the constraints for the next run, including extra constraints,
         if there are some *)
      c = Union[ Apply[ Union, s ], If[ Length[extrac]>=d, extrac[[d]], {} ]]; 

      d = d+1;
    ]; (* End While *)

    Print["Schedule is of dimension ", d ];
    $schedule = 
       Table[
             encodeSchedule[ sys, params, $scheduleMDSol[j][[4]], options ],
             {j, 1, d, 1}
            ];
    If[ svs, 
      Module[ {fname},
        fname = $result[[1]]<>".scd";
        If[ FileInformation[ fname ], DeleteFile[ fname ] ];
        Put[ $schedule, fname ];
        Print[ "Schedule was saved in file ", fname ];
      ]
    ];
    $schedule
  ]  (* Module *)
];  (* Catch *)
scd[___]:=Message[sched::params];


(* ----------- Normal multidimensional schedule *)
scd::extracmd = 
"extra constraints should be a list of list of constraints for a multidimensional schedule"; 
scd[ sys:_Alpha`system, options:___Rule]/;
(multidimensional/.{options}/.Options[ scd]) === True :=
Catch[
 
  (* Check value of system *)
  If[sys==={},Throw[scd::emptyProg] ];

  Module[ 

         { vrb, c, v, o, params, solution, multidim, rf, objf, objectivef, 
           constraints, depcomp, extrac, slv, oldslv, sc, sol, d,
           tempdt, tempudt, vorigine, vextremite, unsatisfiedEdges, svs },

    (* Getting options *)
    slp = scheduleType/.{options}/.Options[scd];
    multidim = multidimensional/.{options}/.Options[scd];
    objf = objectiveFunction/.{options}/.Options[scd];
    depcomp = depComputed/.{options}/.Options[scd];
    vrb = verbose/.{options}/.Options[scd];
    svs = saveSchedule/.{options}/.Options[scd];

    (* Get extra constraints *)
    extrac = addConstraints/.{options}/.Options[scheduleConstraints]; 
    (* Check *)
    If[ extrac =!= {}&&!MatchQ[ extrac, { _List,__List }], Throw[Message[scd::extracmd]] ];

    (* Getting the dependency constraints *)
    If[ vrb, Print[ "Calling scheduleConstraints" ] ];
    c = Check[ scheduleConstraints[ sys, options], Throw[Null] ];

    (* Getting the optimality constraints *)
    If[ vrb, Print[ "Calling timeMinSchedConstraints" ] ];
    o = Check[ timeMinSchedConstraints[ sys, options], Throw[Null] ];

    (* Get system parameters *)
    params = sys[[2]][[2]];

    (* To optimize, consider first parameter in priority *)
    params = Map[ToExpression["T"<>#1]&, params];

    (* Case of multidimensional schedule *)
    If[ vrb, Print["Looking for a multidimensional schedule..."] ];

    (* Check first that constraints do not contain already False *)
    c = Apply[ Union, c[[1]] ];

    (* Add extra constraints *)
    c = Union[ c, If[ extrac === {}, {}, extrac[[1]]] ]; 
    If[ vrb, Print[ "Dependency constraints :\n", c ] ];

    If[MemberQ[ c, False],
       (Print["No Multidimensional schedule"]; $schedule = {};Throw[Null])
    ];

    (* Initialize list of unsatisfied edges *)
    unsatisfiedEdges = Range[ 1, Length[ $scheduleDepTable[[1]] ] ];
    If[ vrb, Print[ unsatisfiedEdges ] ];

    (* find the list of slack variables *)
    Print["Something should be changed here!!!"];
    slv = Select[$dependencyConstraints[[2]], 
                 StringMatchQ[ToString[#1],"slack*"]&];
    If[ vrb, Print[ "Slack variables :\n", slv ] ];

    (* Set dimension, and reset $scheduleMDSol, where the attempts are
       saved *)
    d = 1; Clear[$scheduleMDSol];

    While[  
      c =!= {} , 

      Print["Dimension : ", d ];
      Print[ slv ]; 

      Which[ 
        d>1,

        (* Add extra constraints of level d *)
        c = Union[ c, If[Length[extrac]>=d, extrac[[d]],{} ]]; 

        (* Add optimality constraints *)
        (* Compute the variables which are still in the dependence graph *)
        (* Origins of edges *)
        vorigine = Map[ Part[ #, 2]&, tempudt[[1]] ];  

        (* Extremities of edges *)
        vextremite = Map[ Part[ #, 3]&, tempudt[[1]] ];  
        If[ dbg, Print[ vorigine, vextremite ] ]; 
        (* extremities which are not origins *)
        vextremite = Complement[ vextremite, vorigine ];

        (* Keep only the optimality constraints which correspond
           to origin vertices *)
        o = Select[ $optimalityConstraints[[1]], 
                    Function[{x}, MemberQ[ vorigine, x[[1]] ] ] ];
        c = Union[ c, Apply[ Union, Map[ Last, o ] ] ];              
        If[ dbg, Print["Constraints : ", c ] ];
        v = Union[ slv, $optimalityConstraints[[2]] ]; 
        Print[ v ], 

        True, 
        v = Union[ slv, $optimalityConstraints[[2]] ];
      ]; (* End Which *)

      (* Set objective function *)
      Print[ objf, params ]; 
      Which[ 
            objf === Null && params === {}, objectivef = - Apply[ Plus, slv ],
            objf === Null, objectivef = params[[1]] - 10000* Apply[Plus, slv], 
            True, objectivef = objf
      ];
      Print[ objectivef ]; 

      (* Store problem *)
      $scheduleMDSol[ d ] := { objectivef, c, v };

      (* If not df, maximize the sum of slack variables *)
      Check[ 
            sol = simplex[ objectivef, c, v ],
            Throw [Message[ scd::nosol2d ] ];
      ]; (* End Check *)

      If[ vrb, Print[ sol ] ];

      (* Keep Solution *)
      $scheduleMDSol[ d ] = {objectivef, c, v, sol};
      If[ sol === Null, Throw[Null] ];

      (* Compute unsaturated edges of the dependence graph *)
      (* Number of the slack variables which are equal to 1, they
         give the rank of the dependencies satisfied *)
      sc = Cases[ sol[[2]], y:(x:_->1)/;MemberQ[ slv, x ]->y ];
      sc = Map[ ToExpression[ StringDrop[ ToString[#[[1]]], 5 ] ]&, sc ];

      (* Show dependencies unsatisfied *)
      unsatisfiedEdges = Complement[ unsatisfiedEdges, sc ];
      Print["UnsatisfiedEdges :", unsatisfiedEdges ]; 
      If[ unsatisfiedEdges === {}, Break[] ];

      (* Select constraints corresponding to non satisfied edges *)
      tempudt = dtable[ Map[ Part[ $scheduleDepTable[[1]], # ]&, 
                      unsatisfiedEdges ] ];
      If[ vrb, Print["Unsatisfied dependencies :\n", show[ tempudt, silent->True ] ] ];
      s = Map[ Part[ $dependencyConstraints[[1]], #]&, unsatisfiedEdges ]; 

      (* Keep slack variables which are not 1 *)
      oldslv = slv; 
      slv = MapThread[ If [#2 < 1, #1, Null]&, {slv, slv/.sol[[2]]}];
      slv = Complement[ slv, {Null} ];
      If[ slv == oldSvl, Throw[ "Stop!" ] ];

      (* Get the constraints for the next run *)
      c = Apply[ Union, s ]; 

      d = d+1;
    ]; (* End While *)

    Print["Schedule is of dimension ", d ];
    $schedule = 
      Table[
            encodeSchedule[ sys, params, $scheduleMDSol[j][[4]], options ],
            {j, 1, d, 1}
      ];

    If[ svs, 
      Module[ {fname},
        fname = $result[[1]]<>".scd";
        If[ FileInformation[ fname ], DeleteFile[ fname ] ];
        Put[ $schedule, fname ];
        Print[ "Schedule was saved in file ", fname ];
      ]
    ];
    $schedule

  ]  (* Module *)
];  (* Catch *)


(* This function computes the coefficients of a variable in a system *)
Clear[ coefficientsVariable ]; 
coefficientsVariable::params = "wrong parameters"; 
coefficientsVariable::usage = 
"coefficientsVariable[ sys, v ] returns the list of scheduling coefficients of variable
v in system sys";
coefficientsVariable[ sys:_system, v:_String ] := 
Module[ { dim }, 
  dim = getDeclarationDomain[ sys, v ][[1]]; 
  {Table[ ToExpression[ "T" <>  v  <> "D" <> ToString[ i ] ], {i,1,dim} ], 
   ToExpression[ "A" <>  v ]}
]; 
coefficientsVariable[ ___ ] := Message[ coefficientsVariable::params ]; 

Clear[ storeSchedule ];
storeSchedule::usage = 
"storeSchedule[ sys, params, solution ] adds (or replaces) the schedule of sys to global 
variable $scheduleLibrary, for further use in hierarchical scheduling";
storeSchedule[ sys:_system, params:_, solution:_, options:___Rule ] := 
Module[ {ivare, ovars, name, isched, osched},
  ivars = getInputVars[ sys ]; 
  ovars = getOutputVars[ sys ];
  name = sys[[1]];

  (* This was corrected, to make sure that the schedules are 
     given in the order of the input and output variables *)
  isched = 
    Apply[ Join, 
      Map[ 
        Function[ {a},
          Select[ solution[[2]], Function[{b}, Part[b,1]==a] ] 
        ],
        ivars
      ]
    ];   
  osched = 
    Apply[ Join, 
      Map[ 
        Function[ {a},
          Select[ solution[[2]], Function[{b}, Part[b,1]==a] ] 
        ],
        ovars
      ]
    ];   
(*
  Here, there is a compatibility problem with Tanguy's 
  schedule. Tanguy adds the schedule in the raw form...
*)
  $scheduleLibrary = 
    Prepend[ 
      Select[ $scheduleLibrary, #[[1]] =!= name& ],
      scheduleResult[name, params, isched, osched]
    ]
];
storeSchedule[ ___ ] := Message[ storeSchedule::params ]; 

Clear[getUseSchedule];
getUseSchedule::usage = 
"getUseSchedule[ x ] obtains the schedule of the use entry of a dependency table x,
by looking in the global variable $scheduleLibrary.";
scd::nosched = 
"$scheduleLibrary does not contain a schedule for subsystem `1`";
scd::ivars = 
"number of input vars of use does not match schedule"; 
scd::ovars = 
"number of output vars of use does not match schedule"; 
scd::unknvar = 
"variable `1` is unknown in $result";

Options[ getUseSchedule ] = { debug -> False, periodicFactor -> 1 };

(* Fonction is listable *)
getUseSchedule[ x:{___dependuse}, opts:___Rule ]:= 
Module[ {per,dbg},
  dbg = debug/.{opts}/.Options[scd];
  per = periods/.{opts}/.Options[scd];
  If[ dbg, Print["Entering getUseSchedule..."] ];
  If[ dbg, Print["Periods: ", per] ];
  (* Modification 14/3/2004 *)
  (* A new option periods was added to scd *)
  (* The length of this parameter should be equal to the numbers 
    of use statements *)
  If[ per =!= {}&& Length[ per ] =!= Length[ $scheduleDepTable[[2]] ],
    Print[ "getUseSchedule:warning:length of periods is different of number \n",
     "of uses, assume periods are 1"];
    (* Force default values *)
    per ={}
  ];
  If[ per === {}, 
    (* call with periods 1 *)
    Map[ getUseSchedule[#,opts]&, x ],
    Table[ getUseSchedule[x[[i]],opts,periodicFactor->per[[i]]], {i,1,Length[x]} ]
  ]
];
scd::extension = "Sorry, I cannot schedule a use with extension..."; 
getUseSchedule[ x: dependuse[ name:_String, ivars: {___String}, ovars: {___String}, 
  useIndex:_Integer, dom:_, mat:_ ], opts:___Rule ]:=
Catch[
  Module[ {sch, isched, osched, res, resi, reso, auxf, 
    useconstant, useparamsconstants, paramscaller, 
    dbg, paramscallee, mmamat, mmatrans, paramsRules, workmat,
    actualparams, periodicf, useextconstants, extraDimensions },

    (* Get options *)
    dbg = debug/.{opts}/.Options[scd];
    vrb = verbose/.{opts}/.Options[scd];
    periodicf = periodicFactor/.{opts}/.Options[getUseSchedule];

    If[ vrb||dbg, Print["-----------------------\n",
		   "Entering getUseSchedule on subsystem: ", name ] ];

    (* First, one check that the extension domain does not
     exist in the use, as it is not covered by the method 
     currently *)
    If[ dbg, Print[ "Extension domain: ", show[ dom, silent->True ] ] ];
    (* 
    If[ dom=!=$result[[2]], Throw[ Message[ scd::extension ] ] ];
    *)

    (* Auxiliary function which maps a schedule in form {"a", sched[ ... ]} to 
       a set of constraints *)
    Clear[ auxf ]; 
    auxf[{ v:_String, s: Alpha`sched[ {___}, _ ] }, 
           input:(True|False)]:=
    Module[{coefsindex, coefsconstants, coefsp, coefs,
            coefsSched, constants, l, 
            coefsParamsCalled, coefsParamsCalledValue, 
	    coefsLinearValue, coefConstantValue,
            constLinear, constParams, constConstant,
            coefsext, constExtensions
	   },

      (* Get the list of coefficients of variable v *)
      If[ dbg, Print["--------------\n",
                     "Variable considered is: ", v ]];
      Check[ coefs = coefficientsVariable[ $result, v ], 
             Throw[ Message[ scd::unknvar, v ] ] ];

      (* coefs is the list of symbolic coefficients of v in calling 
         system *)
      If[ dbg, Print[ "Coefficients (coefs) of variable ",v,
                      " in calling system are: ", coefs]];

      (* l is the number of dimensions of v without the parameter dimensions *)
      l = Length[ coefs[[1]] ] - Length[ paramscaller ];
      If[ dbg, Print[ "Dimensions of variable ",v,
                      " less params dimensions is: ", l]];

      (* coefsindex is the list of index coefficients, i.e. the coefficients
         of the linear part less the parameter coefficients, less
	 the extension coefficients *)
      coefsindex = Take[ coefs[[1]], l-extraDimensions ]; 
      If[ dbg, Print[ "Index coefficients (coefsindex) are ", coefsindex]];

      (* coefsp is the list of parameter coefficients *)
      coefsp = Drop[ coefs[[1]], l ]; 
      If[ dbg, Print[ "Params coefficients (coefsp) are ", coefsp]];

      (* coefsext is the list of extension index coefficients *)
      coefsext = 
        Take[ Drop[ coefs[[1]], l-extraDimensions ], extraDimensions ];
      If[ dbg, Print[ "Extension coefficients (coefsext) are ", coefsext]];

      (* coefsconstants is the constant coefficient *)
      coefsconstants = coefs[[2]]; 
      If[ dbg, 
	  Print[ "Constant coefficient (coefsconstants) is ", 
		 coefsconstants]
      ];

      (* mmamat is the linear transformation of the caller's parameters *)
      If[ dbg, Print["Linear transformation of the caller's parameters (mmamat): ", mmamat] ];

      (* coefsParamsCalled is now the list of coefficients of the parameters 
         in the caller system, plus the extension coefficients. It is
	 obtained by doing the dot product of mmamat by the vector of 
	 all parameter coefficients *)
      coefsParamsCalled = 
        If[ mmamat == {}, {}, mmamat.Join[ coefsext, coefsp ]];

      If[ dbg, 
          Print[ "Actual coefficients (coefsParamsCalled) of parameters in called system are ",  coefsParamsCalled]
      ];

      (* Now, we get the actual value of these coefficients *)
      (* coefsLinearValue is the list of coefficients of linear part 
         of v - without the parameters *)
      If[ dbg, Print[ "s is ", s]];     
      coefsLinearValue = Take[ s[[1]], l-extraDimensions ];
      If[ dbg, Print[ "Coefficients of linear (coefslinear) part are ", 
		      coefsLinearValue]];

      (* coefsParamsCalledValue is the list of values of coefficients 
        of the parameters, in the called system *)
      coefsParamsCalledValue = Drop[ s[[1]], l-extraDimensions ];
      If[ dbg, 
          Print[ "Value of coefficients (coefsParamsCalledValue) of parameters in called system are ", coefsParamsCalledValue]
      ];
      
      If[ dbg, 
          Print["Parameters of caller (paramscaller:) ", paramscaller, 
		"\nParameters of called (paramscallee:) ", paramscallee,
                "\nCoefficients of parameters in caller (coefsp:) ",
		coefsp,
                "\nCoefficients of parameters in called (coefsParamsCalled:) ",
	  coefsParamsCalled]
      ];

      (* coefConstantValue is the value of the coefficient of the constant *)
      coefConstantValue = s[[2]] + 
        useconstant + Drop[ s[[1]], l-extraDimensions ].mmatrans;
      If[ dbg, Print[ "Coefficient of constant (coefConstantValue) is: ",      
        coefConstantValue]];

      (* Add constraints to values of extension coefficients *)
      constExtensions = 
        MapThread[ #1==#2&, {coefsext, useextconstants} ];

      (* Modify coefsParams to get adapted coefficients *)
      If[ dbg, 
        Print[ "Parameter constants in the use (useparamsconstants) is: ", 
	       useparamsconstants]
      ];

      coefsParams = 
        If[ mmamat == {},
            {},
            MapThread[ #1 + #2&, 
             { coefsParamsCalledValue, 
	       mmamat.Join[ useextconstants, useparamsconstants ] } ] 
        ];

      If[ dbg, Print[ "Coefficient parameters, once adapted are ", 
                      coefsParams]];

      (* Building constraints relative to parameters *)
      constParams = 
        MapThread[ 
(*
      I don't no if I must keep the inequality or not...
	  If[ input, #1<=#2, #1 == #2]&, 
*)
          #1==#2&,
          {coefsParamsCalled, coefsParams}
    ]; 

      If[ dbg, Print[ "Constraints due to parameters: ", 
                      constParams]];

(* ****************** 
      constConstant = If[ input, coefsconstants<=coefConstantValue, 
                                 coefsconstants == coefConstantValue ];
*)
      constConstant = coefsconstants == coefConstantValue;

      If[ dbg, Print[ "Constraints due to constants: ", 
                      constConstant]];

      constLinear = MapThread[ #1 == #2&, {coefsindex, coefsLinearValue} ];

      If[ dbg, Print[ "Constraints due to linear part: ", 
                      constLinear]];

      Join[ constLinear, constParams, constExtensions, { constConstant } ]
    ]; 
    auxf[a:___]:=
      (Print[{a}];Print["Parameter error while calling auxf function"]);
    (* End of definition of auxf *)

    dbg = debug/.{opts}/.Options[ getUseSchedule ];

    (* Check $scheduleLibrary *)
    If[ !MatchQ[$scheduleLibrary, {(_List|_Alpha`scheduleResult)...}], 
      Throw[ Message[ scd::wrglib ] ] ];

    (* Get caller parameters *)
    Check[ 
      paramscaller = getSystemParameters[],
      scd::errcallparams = "could not get the parameters of the caller system";
      Throw[ Message[ scd::errcallparams ] ]
    ];

    If[ dbg, Print[ "Parameters of the calling system: ", paramscaller] ];
    (* Convert calling matrix to mma form *)
    mmamat = alphaToMmaMatrix[ mat ];

    If[ dbg, Print[ "alpha form of the calling matrix is: ", 
		    mat, "\n",
		    ashow[mat, silent->True ] ]
    ];		    
    If[ dbg, Print[ "MMA form of the calling matrix is: ", mmamat] ];
    (* Get the translation part of mat *)
    mmatrans = matrixTransPart[ mat ];

    If[ dbg, Print[ "Translation of the calling matrix is: ", mmatrans] ];

    (* Get in sch the schedule out of the scheduleLibrary *)
    If[ dbg, Print[ "Dependence table entry: ", x] ];
    sch = Select[ $scheduleLibrary, (#[[1]] === name)&&(Head[#]===scheduleResult)& ];
    If[ dbg, Print[ "Schedule found for system ", name, ": ", sch] ];

    (* If sch empty, error *)
    If[ sch === {}, Throw[ Message[ scd::nosched, name ] ] ];

    (* sch is a list of list *)
    sch = sch[[1]];

    (* Check that the number of actual input variables is the same as the 
       formal variables *)
    If[ Length[ ivars ] =!= Length[ sch[[3]] ], 
        Throw[ Message[ scd::ivars ] ] ];
    If[ dbg, Print["Number of actual input arguments is OK"]];

    (* Idem output arguments *)
    If[ Length[ ovars ] =!= Length[ sch[[4]] ], 
        Throw[ Message[ scd::ovars ] ] ];
    If[ dbg, Print["Number of actual output arguments is OK"]];

    (* paramscallee is the parameters in the called subsystem *)
    paramscallee = sch[[2]]; 

    (* In case the schedule is symbolic, we try to apply to
      it replacement rules for the parameters *)

    (* paramscallee is the list of parameters. sch is the schedule 
      as found in the library. *)
    If[ dbg, Print["Schedule : ",sch ]];

    (* Get the parameters matrix in the dependuse *)
    (* x is the dependeuse expression, and its 6th element is the 
       matrix that maps the calling parameters to the callee parameters *)
    workmat = Part[x,6];
    If[ dbg, Print["Parameter matrix: ", workmat] ];

    (* Get the actual values of the parameters of the callee system *)
    (* workmat[[4]] is the matrix, workmat is the index list, and 
       remember that the affine transformation is encoded in homogeneous
       coordinates *)
    actualparams = Drop[ workmat[[4]].Append[workmat[[3]],1], -1 ];

    (* Check that the number of params are the same *)
    If[ Length[paramscallee] =!= Length[actualparams], 
	getUseSchedule::wrgsched = 
        "use does not match parameter dimensions. Check your system using"<>
	" analyze.";
	Throw[ Message[ getUseSchedule::wrgsched ] ]
    ];

    (* Build the rules matching formal parameters and values in 
       the schedule *)
    paramsRules = 
      MapThread[ #1->#2&, {paramscallee, actualparams} ];
    If[ dbg, Print["Actual values of the parameters: ", actualparams] ];
    If[ dbg, Print["Rules found: ", paramsRules] ];

    (* Keep only symbolic rules *)
    paramsRules = Select[ paramsRules, !NumberQ[Part[#1,1]]& ];
    If[ dbg, Print["Symbolic rules found: ", paramsRules] ];

    (* Add periodicFactor rule to it *)
    paramsRules = Append[ paramsRules, "$P" -> periodicf ];
    If[ dbg, Print["Symbolic rules plus periodicity: ", paramsRules] ];

    (* Apply this to schedule *)
    sch = sch/.paramsRules;
    If[ True, Print["New schedule: ", sch] ];

    (* isched is the schedule of the inputs, and osched, that of the 
       outputs of the system *)
    isched = sch[[3]]; osched = sch[[4]];

    If[ dbg, Print["Schedule of inputs is: ", isched]];
    If[ dbg, Print["Schedule of outputs is: ", osched]];
    If[ dbg, Print["Parameters (in subsystem) are: ", paramscallee]];
    
    (* useconstant is the offset of the use, in the form 
       AlphaVars`Tuse# *)
    useconstant = ToExpression[ "AlphaVars`Tuse"<>ToString[ useIndex ] ];

    If[ dbg, Print["Constant is : ", useconstant]];

    (* useparamsconstants is the list of coefficients that we assign
       to parameters in the caller system *)
    useparamsconstants = 
      Map[ ToExpression[ "AlphaVars`Tuse"<>#<>ToString[ useIndex ] ]&, 
      paramscaller ];

    If[ dbg, Print["Calling system parameter coefficients are: ", 
             useparamsconstants]];

    (* extraDimensions is the number of additional dimensions of use
       because of the use statement *)
    extraDimensions = dom[[1]] - Length[ paramscaller ];
    If[ dbg, Print[ "Extension dimensions of use is: ", extraDimensions]];

    (* Define use extensions constants for the extensions indexes *)
    useextconstants =
      Table[ ToExpression[ "AlphaVars`TuseExt"<>ToString[i]<>
        ToString[ useIndex ] ], 
        {i,1,extraDimensions} ];
    If[ dbg, Print[ "Coefficient of constant (useextconstants) is: ", 
		      useextconstants]];

    (* Transform the schedule in a set of constraints for MMA *)
    If[ dbg, Print["ivars: ", ivars ] ];
    If[ dbg, Print["isched: ", isched ] ];
    resi = 
     Table[ {ivars[[i]], isched[[i]][[3]]}, {i, 1, Length[ isched ]}];
    reso = 
     Table[ {ovars[[i]], osched[[i]][[3]]}, {i, 1, Length[ osched ]}];

    If[ dbg, Print["resi before call: ", resi ] ];
    If[ dbg, Print["resi before call: ", reso ] ];
    
    (* Call the auxiliary function *)
    resi = Apply[ Union, Map[ auxf[#,True]&, resi] ]; 
    reso = Apply[ Union, Map[ auxf[#,False]&, reso ] ];
    If[ dbg, Print["resi: ", resi]];
    If[ dbg, Print["reso: ", reso]];

    (* Add the use constant *)
    res = 
      { Union[ 
          resi, reso, 
	  { useconstant >= 0 }, 
	  Map[ #>=0&, useparamsconstants ] 
        ], 
        Union[ useparamsconstants, {useconstant} ] 
      };

    (* Add the extension coefficients *)
    res = {res[[1]], Union[res[[2]], useextconstants]};
    
    If[ vrb||dbg, Print["Result : ",res] ];
    res
  ]
];
getUseSchedule[x: ___ ] := (Print[{x}];Message[ getUseSchedule::params ];)

Clear[ encodeSchedule ];
encodeSchedule[ sys:_system, params:_, solution:_, options:___Rule ] := 
Module[ { lv, vrb, v, multidim, rf, objf, depcomp, 
          df, aux, dbg, reuseS, oldSchedule, result, reuseVars },

    (* Getting options *)
    slp = scheduleType/.{options}/.Options[scd];
    multidim = multidimensional/.{options}/.Options[scd];
    rf = ruleForm/.{options}/.Options[scd];
    objf = objectiveFunction/.{options}/.Options[scd];
    depcomp = depComputed/.{options}/.Options[scd];
    vrb = verbose/.{options}/.Options[scd];
    df = dataFlow/.{options}/.Options[scd];
    onlyV = onlyVars/.{options}/.Options[scd];
    onlyE = onlyEquations/.{options}/.Options[scd]; (* Not used yet *)
    reuseS = reuseSchedule/.{options}/.Options[scd];

(*  To be set, when needed... *)
    dbg = False; 

    (* List of local variables, taking into account the onlyVars option *)
    lv = getLocalVars[ sys ];
    If[ onlyV =!= all, lv = Intersection[ lv, onlyV ] ];

    (* List of all variables, taking into account the onlyVars option *)
    v = getVariables[sys];
    If[ onlyV =!= all, v = Intersection[ v, onlyV ] ];

    (* Keep track of previous schedule, if the reuse option is set *)
    If[ reuseS, oldSchedule = $schedule[[2]]; 
                reuseVars = Map[First, oldSchedule],
                oldSchedule = {}; reuseVars = {}];

    If[ dbg, Print[ "params: ", params, "\nSolution: ", solution,  
                    "\nOptions: ", {options} ]];

    (* Auxiliary function *)
    Clear[ aux ];
    aux[ var:_ ]:=
    Module[ { dField, indexField, schedField, temp1, temp2 },
      If[ dbg, Print["======== var: ", var ]];
      dField = getDeclaration[ sys, var ][[3]]; 
      If[ dbg, Print["Declaration: ", dField ]];
      indexField = dField[[2]];
      If[ dbg, Print["Indexes: ", indexField ]];
      temp1 = 
        Alpha`sched[
          If[slp =!= sameLinearPart ||!MemberQ[lv, var ],
             Table[
		      ToExpression["T"<> var<>"D"<>ToString[i]],
		      {i,1,dField[[1]]}
                  ],  (* Table *)
             Table[
                      ToExpression["TD"<>ToString[i]],
		      {i,1,dField[[1]]}
                  ]   (* Table *)
             ], (* If *)
          ToExpression["A"<> var ]
          ];
      If[ dbg, Print["temp1: ", temp1 ]];        
      temp2 = temp1/.solution[[2]];  (* sched, substituted with sol *)
      schedField = temp2; 
      If[ dbg, Print["indexField: ", indexField ]];        
      If[ dbg, Print["schedule: ", schedField ]];        
        { var, indexField, schedField }
          ];

      result = 
      Alpha`scheduleResult[ 
        sys[[1]], (* Name of the system *)
        Union[
          Map[ aux, Complement[v,reuseVars] ], 
          oldSchedule
        ],
        Append[params,Global`aparam]/.solution[[2]]  
      ];

      result

];
encodeSchedule[___] := Message[ encodeSchedule::params ];

Clear[simplex];
simplex::bingo = "Congratulations! you have found a bug in ConstrainedMin or
ConstrainedMax. Example is in file errorSimplex.m . Report to Wolfram Research";
simplex[f:_,c:_,v:_,options:___Rule]:=
Catch[
Module[{ f1, c1, newv, rules, sol, mn, vrb, t},
        vrb = verbose/.{options}/.Options[simplex];
	mn = minimize /.{options}/.Options[simplex];

	rules = Map[#1->#1-$$x&,v];
        f1 = f/.rules;

        (* Replace equalities with two inequalities... There are bugs in MMA *)
        c1 = Flatten[ c/.(x_==y_)->{x>=y,x<=y} ];
        
	t = Timing[sol = 
	If[mn,
	   Check[ ConstrainedMin[ f1, c1/.rules, Append[ v, $$x ] ], 
                  Throw[Null]],
	   Check[ ConstrainedMax[ f1, c1/.rules, Append[ v, $$x ] ], 
                  Throw[Null]]
  	  ]] [[1]];

        $runTime = t; 

        If[ MemberQ[(c1/.rules)/.sol[[2]],False], 
            {f1, c1/.rules, sol[[2]]} >> "errorSimplex.m";
            Throw[ Message[simplex::bingo] ]
        ];

        If[ vrb, 
            Print[ Length[ c1 ], " constraints, ", Length[ v ], " variables ", 
                   t ] ];

        With[ {x = Last[ sol[[2]] ] [[2]]}, 
	{ sol[[1]], MapThread[ #1->#2[[2]] - x&, { v, Drop[ sol[[2]], -1 ] } ] }
        ]

      ]
];
simplex[___]:=Message[simplex::params];

gp[g_Graph,1] := g;

gp[g_Graph,n_Integer] :=
  Module[{prod=p=Edges[g]},
    Do [
      prod = prod . p,
      {n-1}
    ];
    Graph[prod, Vertices[g]]
  ];
gp[___] := Message[gp::params];
gp::params = "wrong parameters...";

End[];
EndPackage[]

