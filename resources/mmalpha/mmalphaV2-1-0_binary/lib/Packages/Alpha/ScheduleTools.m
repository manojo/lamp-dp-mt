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
*)
BeginPackage["Alpha`ScheduleTools`", 
  { "Alpha`Domlib`",
    "Alpha`",
    "Alpha`Options`",
    "Alpha`Lexicographic`",
    "Fail`",
  (*  "DiscreteMath`Combinatorica`", *)
    "Combinatorica`",
    "Alpha`Matrix`",
    "Alpha`Tables`",		
    "Alpha`Semantics`",
    "Alpha`Substitution`",
    "Alpha`Normalization`",
    "Alpha`Properties`", 
    "Alpha`ChangeOfBasis`",
    "Alpha`VertexSchedule`",
    "Alpha`Static`"  }
]

(* Standard head for CVS

	$Author $
	$Date: 2009/05/22 10:24:36 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/ScheduleTools.m,v $
	$Revision: 1.4 $
	$Log: ScheduleTools.m,v $
	Revision 1.4  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.3  2008/12/29 17:39:17  quinton
	Replaced DiscreteMath`Combinatorica by Combinatorica package.
	
	Revision 1.2  2007/04/09 18:49:52  quinton
	appSched was modified to add new possibilities in choosing the projection direction
	
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.39  2004/06/16 14:57:31  risset
	switched to ZDomlib
	
	Revision 1.38  2004/06/09 15:44:29  quinton
	Minor modifications.
	
	Revision 1.37  2003/04/18 08:35:26  risset
	added the simplifyUseInputs function
	
	Revision 1.36  2002/10/21 08:25:01  quinton
	appSched was corrected to cover the case of multidimensional time.
	
	Revision 1.35  2002/09/04 16:38:08  quinton
	Edition correction.
	
	Revision 1.34  2002/08/30 14:52:51  risset
	slight modifs
	
	Revision 1.33  2002/08/29 09:13:36  risset
	added the isScheduledQ function and also options to appSched to provide the prokection function
	
	Revision 1.32  2002/05/28 14:40:21  quinton
	Corrections were made to appSched. In particular, the indices are now called
	t and p, if there is only one time dimension.
	
	Revision 1.31  2001/09/13 16:40:36  quinton
	Minor modifs
	
	Revision 1.28  2001/08/16 14:25:24  quinton
	Minor corrections.
	
	Revision 1.26  2001/04/21 05:22:42  quinton
	Correction of some Ifs for MMA 4.0
	
	Revision 1.25  2000/02/14 08:25:21  risset
	correct a bug in DomEqulities
	
	Revision 1.24  1999/12/10 16:59:05  risset
	commited struct Sched and ZDomlib
	
	Revision 1.23  1999/11/15 17:09:22  risset
	added buildSchedConstraints
	
	Revision 1.22  1999/11/08 16:55:13  quinton
	Few minor corrections to ShowSchedResult
	
	Revision 1.21  1999/08/12 14:57:09  quinton
	Option sortOrder added to showSchedResult, to select the presentation
	order of the result.
	
	Revision 1.20  1999/08/12 09:49:07  quinton
	Added an option onlyVar in showSchedResult, to see only the schedule of
	a list of variables. Default value is onlyVar->all
	
	Revision 1.19  1999/05/28 09:34:04  risset
	remove context Alpha of scheduleResult
	
	Revision 1.18  1999/05/18 16:24:30  risset
	change many packages for documentation
	
	Revision 1.17  1999/05/14 12:12:41  quinton
	A few corrections.
	
	Revision 1.16  1999/05/12 09:21:12  risset
	 load options.m before Alpha.m
	
	Revision 1.15  1999/05/12 08:28:27  risset
	 load options.m before Alpha.m
	
	Revision 1.14  1999/05/10 13:14:14  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.13  1999/05/06 07:51:36  quillere
	removed appTFSched. changed error handling in appSched
	
	Revision 1.12  1999/04/29 10:23:38  risset
	 added a complete check of Farkasschedule
	
	Revision 1.11  1999/04/22 10:07:27  risset
	erase patrice s last commit because it crushed old results
	
	Revision 1.9  1999/03/02 15:49:27  risset
	added GNU software text in each packages
	
	Revision 1.8  1998/12/16 13:38:35  risset
	added simplifySchedule
	
	Revision 1.7  1998/11/27 12:20:19  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.6  1998/04/10 08:03:20  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.5  1998/02/24 14:56:39  risset
	as

	Revision 1.4  1997/06/26 14:11:53  risset
	commited Alphard.m v1

	Revision 1.3  1997/05/19 10:41:35  risset
	corrected exported bug in depedancies

	Revision 1.2  1997/04/22 07:54:47  risset
	Added multiDim Scheduling

	Revision 1.1  1997/04/10 15:10:54  risset
	added Options.m ScheduleTools.m OldSchedule.m remove NewSchedule.m

*)




applySchedule::usage = 
"applySchedule[] applies the schedule $schedule to $result. The
resulting system is the original one where all the change of basis in
$schedule have been performed and where the first index can
interpreted as the time everywhere except for the input and output
variables.  applySchedule[sys_Alpha`system] applies the schedule
$schedule to system `sys'.  applySchedule[sys_Alpha`system,
sched_Alpha`Schedule] applies the schedult `sched' to system
`sys'. See also: schedule, $schedule."

showSchedResult::usage = 
"showSchedResult[sched1_Alpha`ScheduleResult] pretty prints the
schedule sched1, equivalent to show[sched1]"

other::usage = 
"other is an option of appSched which means for other variables";

renameIndices::usage =
"renameIndices[sys:Alpha`system,indiceList:{___String}] rename the
indices of all the local variables of the system `sys' according to
the list given `indiceList' (including the output of `use').
renameIndices[sys:Alpha`system,indiceList:{___String},var:(_String|{__String})]
rename the change the name in only one variable `var' (or a list of
given variable)"

appSched::usage = 
"appSched[ sys, sch, options ] returns a scheduled system, according to 
sch. appSched[ sch, options ] applies schedule sch to $result. 
appSched[ options ] applies schedule $schedule to $result.
appSched is equivalent to ApplySchedule but works for 
multidimensionnal scheduling. The projection direction is 
chosen automatically by MMAlpha, but if necessary, it can be chosen 
using the projMatrix or the projVector options. See ?appSchedOptions
for more informations.";

appSchedOptions::usage =
"appSched chooses automatically the projection direction for variables, 
and this sometimes may not be convenient. There are several ways to
specify more precisely the schedule. Option projVector allows a 
projection vector to be specified. For example, projVector -> {1,0,0}
would say that the first component of all variables will be replaced by
the time given by the schedule, in a 3-dimensional space. However, this
option can be used only if all variables of the system are already 
placed in the same space, which may not be the case. Similarly, one
can specify the projection matrix, using the projMatrix option. For
example, projMatrix -> {{1,0,0},{0,0,1}} will project all variables
on components 1 and 3. Again, this may not be convenient if all variables
are not in the same space. Another way of specifying the projection is
to use the timeDimensions option. Specifying timeDimensions -> {2} 
says that the component of all variables that will be replaced by 
the time is the second dimension. This is equivalent to the option
projVector -> {0,1,0}, but less dependant on the dimension of the 
variables. Moreover, one can specify the time dimensions variable by
variable, using the variables option. This option may take several
forms. variables -> varlist, where varlist is a list of local variables,
restricts appSched to be applied to only variables in varlist. 
variables -> {{ var, timeDimensions }, ... } allows the value of option 
timeDimensions to be attached to each individual variable. For example,
variables -> {{ \"A\", {2} }, { \"B\", {1} }} says that for variable 
A, the time dimensions is 2, and for variable B, it is 1. One can
also factorize this list as in variables ->{{{\"A\",\"C\"}, {2}, 
{\"B\", {1}}}, and also use the keyword other to specify the 
time dimensions for all remaining variables, as in 
variables -> {{ \"A\", {2} }, { \"B\", {1} }, { other, {3} }}.
Notice that timeDimensions is a list of dimensions: this is a provision
for a multi-dimensional schedule, but this has not been tested yet.
Also, remember that no garantee is given that these options provide
a possible projection, as this depends on the existence of a unimodular
transformation combining the schedule and the projection. In other words,
appSched may fail sometimes. A final warning: projection vector or 
matrices should include the parameters' dimensions.";

timeDimensions::usage = 
"timeDimensions is an option of appSched and appVarSched that gives the 
list of dimensions that are to be assigned to time. This option 
gives a hint to appSched. Say a variable has indexes i,j,k (including
parameters), then timeDimensions->{2} means that index j is going
to be replaced by the time and thus, indexes i and k will become 
processors. This hint may not always work. See also ?appSchedOptions.";

variables::usage = 
"option of appSched. It gives the list of variables for which the schedule
must be applied. Default value is Null, and means all variables. See
also ?appSchedOptions for the exact syntax of this option."; 

appVarSched::usage = 
"appVarSched[sys:_system,var_String,time_Matrix,options] apply a single COB to a variable, 
the schedule is to be given as a Mathematica matrix (List of List of integer). This function 
is for internal use ";

convertSchedule::usage = 
"convertSchedule[sch:_scheduleResult]. Takes a schedule table and
returns an equivalent time functions table. This format is used by
lifetime, appSched, and other functions";

identitySchedule::usage = "identitySchedule[sys,dim] build the identity schedule
of dimension `dim` dor system sys. The identity schedule simply consist of the lexicographic order 
on the `dim`first indices (i.e. the program is already scheduled " 

 isScheduledQ::usage="isScheduleQ[sys,dim] check whether the sys is scheduled or not
(with a schedule of dimension dim. isScheduledQ[sys] assumes a linear schedule"

testSched::usage = 
"testSched[sys:_system, sch:_scheduleResult] tests the the schedule
for the given system. When flow dependencies are not satisfied, it
prints messages and returns False.  testSched[sys:_system,
sch:_scheduleResult, var:_String] test schedule for var only. Param
sys may be a dependencies table.  Default: testSched[] test $result
with $schedule.";

equationOrderQ::usage=
"equationOrderQ[sys] checks if the equations are correctly ordered to generate code with a schedule with duration of 0 for some equation (i.e. graph of dependencies internal to te loop nest is topologicaly sorted; If the answer is Yes, the function returns True otherwise it attempts to find a permutation of the equations that is correct(returns a list of integer). This function does not take into account dependencies involving input or output variables WARNING, this function is temporarily disable because of an internal bug (TopologicalSort)"

reorderEquations::usage="reorderEquations[sys,permutation] reordersx the equation of system sys according to the permutation given (which only concern the local variables, see the function equationOrderQ). The output equation are put at the end of the program."

buildPseudoAlpha::usage=
"buildPseudoAlpha[sys_] returns a system `sys2' in which all the
subsystems called by `sys' have been replaced by equations on the
output variables of the sub-system use. This function is used in order
to be able to schedule a structured system. buildPseudoAlpha[] is by
default applied to $result "

buildSchedConstraints::usage=
"buildSchedConstraints[sys_,List[sched_scheduleResult]] builds a list
of constraints (strings) that correspond to the schedules given as
second argument for all the subsystem called in
`sys'. buildSchedConstraints[] calls the function
buildSchedConstraints[$result,$scheduleLibrary]";

buildSchedConstraintForUse::usage=
"buildSchedConstraintForUse[sys_,use1_use,sched_SchedulResult]
build a list of constraints (strings) that correspond to the schedule
given in sched of the subsystem used in `use1' which is part of `sys'";

isReducibleQ::usage=
"isReducibleQ[sys] checks wether a structured Alpha program is
`reducible' in the sens described in Irisa research report PI1140: the
dependency between output and input of a subsystems have identity on
the extension part"

addBufferVars::usage="addBufferVars[sys:_Alpha`system] adds systematically a
 local `buffer' variables  for each input and each output of each use of subsystems in `sys' (warning, if the input is not a simple variable, the function fails, this function is to be for internal use, please refer to simplifyUseInputs[])"

applyschedule::nset="The $schedule variable is not set"
applySchedule::nset2="The $result variable is not set"
applySchedule::pb1="problem during change of basis, operation aborted"
applySchedule::restore="$result unchanged"
applySchedule::WrongArg = " Wrong argument for applySchedule, `1`,
$result unchanged"
applyScheduleToVar::WrongArg = " Wrong argument for applyScheduleToVar, `1`,
$result unchanged"

Options[applySchedule] = {verbose -> False, debug -> False};

makeNumInstr::WrongArg = " Wrong argument for makeNumInstr `1`, fatal
  error"
showSchedResult::NoSchedule = " No schedule to show "
showAffByVarSchedResult::WrongArg =  " Wrong argument for showAffByVarSchedResult, `1`"
showAllAffByVarSchedResult::WrongArg =  
" Wrong argument for showAllAffByVarSchedResult, `1`"

appSched::failed = "could not apply the schedule";
appSched::wrongArg = "`1`";
appSched::missing = "schedule not found for variable `1`";
appSched::noSchedule = "no default schedule ($schedule)";

convertSchedule::failed = "";
convertSchedule::wrongArg = "`1`";
convertSchedule::corrupted = "corrupted schedule";

testSched::failed = "";
testSched::wrongArg = "`1`";
testSched::missing = "schedule missing for variable `1`";

getSchedule::usage = 
"getSchedule[ var ] returns the schedule of var, as it appears in $schedule";

getSystemSchedule::usage =
"getSystemSchedule[ sys ] gets the schedule of system sys if it exists in 
the schedule library, $scheduleLibrary.";

scheduleOnly::usage =
"schedulOnly is an option of showSchedResult. If True, only the value of
the schedule is displayed. Default value is False.";

stringForm::usage = 
"stringForm is an option of showSchedResult. If True, the output of the 
function is a string, otherwise, the result is printed out.";

Begin["`Private`"] 

Clear[applySchedule];

(* Without argument, $result and $schedule are assumed *)
applySchedule[opts:___Rule]:= 
  Module[{},
	 If[!MatchQ[$schedule,scheduleResult[___]],
	    Message[applySchedule::nset],
	   applySchedule[$schedule,opts]]
      ];

(* If a system is specified *)
applySchedule[sys_Alpha`system,opts:___Rule]:=
Module[{initialProgr,finalProg},
  initialProg=sys;	
  If[!MatchQ[$schedule,scheduleResult[___]],
    Message[applySchedule::nset],
    Check[ finalProg = applySchedule[initialProg,$schedule,opts];
    $result = normalize[finalProg];
    $program = initialProg;
    $result,
    Message[applySchedule::restore];
    Clear[$result];
    $program = initialProg;
    $result=$program]
  ]
];

(* A schedule is specified, but no system. Assume $result *)
applySchedule[sched1_scheduleResult,opts:___Rule]:= 
Module[{initialProgr,finalProg},	
  initialProg=$result;	
  If[!MatchQ[$result,Alpha`system[___]],
    Message[applySchedule::nset2],
    Check[finalProg = applySchedule[initialProg,sched1,opts];
    $result=normalize[finalProg];
    $program = initialProg;
    $result,
    Message[applySchedule::restore];
    Clear[$result];
    $program = initialProg;
    $result=$program]
  ]
];

(* applySchedule[sys1_Alpha`system,sched1:scheduleResult[___]]:=
  applySchedule[sys1,sched1,0] *)


applySchedule[sys1_Alpha`system,
	      sched1:scheduleResult[___],
	      opts:___Rule]:=
Module[{error1,initialProgr},
  initialProg = sys1;	
  error1 = 0; 
(*	 If [sched1[[1]]!=1,
	     Print["Applying schedule of type no ",
		   sched1[[1]],"not implemented"];
	     error1=1;
	   ];*)
	 
  If[error1==0,
    Check[ sys2 = applySchedToVar[ sys1, sched1[[2]], opts],
    Message[applySchedule::pb1];initialProg]
  ]
];

applySchedule[a___]:=(Message[applySchedule::WrongArg,a];Null)

(* applySchedToVar applies a single change of basis on a single variable
option==1 for debug  *)

Clear[applySchedToVar];

applySchedToVar[
  sys1_Alpha`system,
  {firstSched:{nomVar_String,
               indiceList_List,
               sched[schedVect_List, const_Integer]},
   otherSched___}, opts:___Rule]:=

Module[{error1,timeFunctionMatrix,vectorTest,nullTimeVector,
  HQMatrix,QMatrix,line2,lineN,res,res2,idMat1,newIndiceList,
  nbParam,schedVectMod,schedVectConst,vrb},

  vrb = verbose/.{opts}/.Options[applySchedule];
  dbg = debug/.{opts}/.Options[applySchedule];

  error1=0;
  res=sys1;

  (* If the variable is inout or output, we do nothing *)
  If[ Cases[sys1[[4]],Alpha`decl[nomVar,___]]!={},
    (* Print["Warning: Basis change not performed on output variable ",
		  nomVar ] *)
    error1=1];

  If[ Cases[sys1[[3]],Alpha`decl[nomVar,___]]!={},
	    (* Print["Warning: Basis change not performed on input variable ",
		  nomVar ] *)
    error1=1];

  If[ Length[indiceList] != Length[schedVect],
    Print["Problem schedVect (",schedVect,") and indiceList (",
		  indiceList,") are incompatible"];
    error1=1];

  (* If the Tau vector is null, we cannot complete the
     vector unimodularly thus we have to add a dimension
     during the basis change *)

  vectorTest = Table[0,{Length[schedVect]}];

  If[ schedVect==vectorTest, 
    nullTimeVector=True,
    nullTimeVector=False];
	 
  (* If the variable is a scalar, we MUST add a dimension *)
  nbParam = sys1[[2,1]];
  If[ nbParam == Length[schedVect], nullTimeVector=True];
	 
  If[ (!nullTimeVector)&&(error1==0),
    (* Matrix which we must complete unimodulary 
      The coefficients concerning the parameters must be 
      null: they must be considered as constants *)

    schedVectMod = Join[Drop[schedVect,-nbParam],
			Table[0,{i,1,nbParam}]];
    timeFunctionMatrix=
      Alpha`matrix[2,
        Length[schedVectMod]+1,
        indiceList,
        {Append[schedVectMod,0],
         Append[vectorTest,1]}];

    QMatrix = unimodularCompletion[timeFunctionMatrix];

    If[ QMatrix==={},
      error1=2,
 
      If[ !unimodularQ[QMatrix],
        Print["Problem for variable ",
        nomVar,", Matrix not unimodular:\n", QMatrix];
        error1=2
      ];

      If[ Take[QMatrix[[4,1]],Length[QMatrix[[4,1]]-1]] != 
        Append[schedVectMod,0],
		    Print["Unimodular completion failed for variable ",
			  nomVar,", schedVectMod is :",schedVectMod,
			  " and Matrix is good:\n",QMatrix];
		    error1=3
      ];

      (* We put back the coefficients on the parameters
       and the constant parameter in the first row of Qmatrix *)

      schedVectConst = Append[schedVect,const];
      QMatrix=ReplacePart[QMatrix,schedVectConst,{4,1}];
		  
      (* Add the new indice now *)
      newIndiceList=Prepend[Take[indiceList,
					     {2,Length[indiceList]-
					      sys1[[2,1]]}
					      ], (*  i,j -> t,j *)
					  "t"
      ];

      If[ (*option===1*) dbg,
        Print["newIndices",newIndiceList];
        Print["Variable ", nomVar," Time vector",schedVect];
        Print["unimodular Completion:\n",QMatrix]
      ];

      If[ error1==0,
        If[vrb,Print["applying changeOfBasis["<> 
          nomVar<>"."<>show[QMatrix,silent->True]<>","<>
	    ToString[newIndiceList]<>"]"]
        ];
        res = changeOfBasis[sys1, nomVar, QMatrix,newIndiceList];
      ]
    ]
  ];

  (* If the vector could not be unimodulary completed *)
  If[ ((nullTimeVector)&&(error1==0)||(error1==2)),
    If[ (error1==2),error1=0];
      (* In this case, we build the change of basis matrix as:
	        (  tau ) 
		(  Id  )                         *)
      Print["Warning: adding a dimension for variable ",nomVar];

      idMat1=IdentityMatrix[Length[indiceList]+1];
      QMatrix=Alpha`matrix[Length[indiceList]+2,
				 Length[indiceList]+1,
				 indiceList,
				 Prepend[idMat1,
					 Append[schedVect,const]]
      ];

      If[ (*option===1*) dbg,
        Print["Variable ", nomVar," Time vector",schedVect];
        Print[" Completion:\n",QMatrix]];
        If[ error1==0,
          If[vrb,Print["applying changeOfBasis["<> 
	            nomVar<>"."<>show[QMatrix,silent->True]<>","<>
			    "etc... ]"]
          ];
          res=changeOfBasis[sys1,
		  nomVar,
		  QMatrix,
                  Prepend[Take[indiceList,
						{1,
						 Length[indiceList]-
						 sys1[[2,1]]}],
					   "t"]
          ];
        ];
      ];
      If[ (* option===1 *) dbg,ashow[normalize[res]]];

      res2=applySchedToVar[res, {otherSched},opts]
];
	    
applySchedToVar[sys_,{},opts:___Rule]:=sys;

applyScheduleToVar[a___]:=Message[applyScheduleToVar::WrongArg,a];


(***********************************************************)
(* showSchedResult *) 

show[x_scheduleResult,opts:___Rule]:=(showSchedResult[x,opts];)
show[{v:_String, i:{___String}, s:sched[___]}, opts:___Rule] := 
  showAffByVarSchedResult[v,i,{s}, opts];

Options[showSchedResult] = 
  {onlyVar -> all, sortOrder -> noOrder, scheduleOnly -> False, 
   stringForm -> False};

(* Get the schedule of a system *)
Clear[ getSystemSchedule ];
getSystemSchedule[sys:_String] :=
Module[ {res},
  res = Cases[ $scheduleLibrary, scheduleResult[ sys, ___ ], Infinity ];
  If[ res =!= {}, res = First[ res ] ];
  res
];
getSystemSchedule[___]:=Message[getSystemSchedule::params];

(* Get the schedule of a variable *)
Clear[ getSchedule ];
getSchedule[x:_String] :=
Module[ {res},
  res = Cases[ $schedule, {x,_,sched[__]},Infinity ];
  getSchedule::noSched = "variable `1` has no schedule";
  If[ res === {}, Message[ getSchedule::noSched, x ] ];
  If[ res =!= {}, res = First[ res ] ];
  res
];
getSchedule[___]:=Message[getSchedule::params];

Clear[showSchedResult];
showSchedResult::unknorder = 
    "`1` is not an order for showSchedResult";

(* Without schedule specified, assume $schedule *)
showSchedResult[opts:___Rule]:=showSchedResult[$schedule,opts];

(* Recurse on list *)
showSchedResult[x:{__Alpha`scheduleResult},opts:___Rule]:=
    Map[(Print["----"];showSchedResult[#])&,x];

(* Assume a single schedule *)
(* Here, I (PQ) made a modification, to cope with the format of 
   schedules given by Vertex schedule. In the "normal" format of
   Tanguy, we only have the system name, and the list of schedules
   for the variables. In the Vertex format, and only in the schedule
   library, the second argument gives the list of parameter''s names
   Modification done May 19, 2004.
*)
showSchedResult[
    res1:scheduleResult[name:_String,p:{___String},si:_List,so:_List],
    opts:___Rule] := 
showSchedResult[scheduleResult[name,Union[si,so],p],opts];

(* The normal case *)
showSchedResult[res1:scheduleResult[___],opts:___Rule]:=
Catch[
  Module[
    { scheduleType, v, scheduleList, sord, optString, res },

    v = onlyVar/.{opts}/.Options[showSchedResult];
    sord = sortOrder/.{opts}/.Options[showSchedResult];

    optString = stringForm/.{opts}/.Options[ showSchedResult ];

    scheduleListe = res1[[2]];

    If[ v=!= all,
        scheduleListe = Select[ scheduleListe, MemberQ[ v, #[[1]]]& ]
    ];
	 
    Which[
      sord === noOrder, Null,
      sord === lexicographic, 
      scheduleListe = Sort[ scheduleListe, OrderedQ[#1,#2]& ],
      MatchQ[sord, _Integer], 
      scheduleListe = 
        Sort[ scheduleListe, 
          Less[#1[[3]][[1]][[-sord]],#2[[3]][[1]][[-sord]]]&],
	   True, Message[showSchedResult::unknorder, sord]
    ];
	 
    res = showAllAffByVarSchedResult[scheduleListe, opts];
    If[ !optString, Print[ res ], Return[ res ] ];
  ]
];
showSchedResult[Null]:=Null; 
showSchedResult[a___]:=Message[showSchedResult::NoSchedule];

(* 
  showAllAffByVarSchedResult prints all schedules
*)
Clear[showAllAffByVarSchedResult];
(* If only one schedule, call show *)
showAllAffByVarSchedResult[{var:_String, indices:_List, scheds:_sched},
  opts:___Rule] :=
showAffByVarSchedResult[var,indices,{scheds},opts];

(* A list of schedules: map *)
showAllAffByVarSchedResult[ls:_List, opts:___Rule] :=
Module[ {res},
  res = Apply[ StringJoin, Map[ showAffByVarSchedResult[#,opts]<>"\n"&, ls ] ];
  res = StringDrop[ res, -1 ]
];

showAllAffByVarSchedResult[{},opts]:=Null; 
showAllAffByVarSchedResult[a___]:=
  (Message[showAllAffByVarSchedResult::WrongArg,a];
   Null);

(* 
  Shows one schedule
*)
Clear[showAffByVarSchedResult];
(* If in list form *)
showAffByVarSchedResult[
{
  var:_String,
  indices:_List,
  scheds:_
},
  opts:___Rule
]:=
showAffByVarSchedResult[ var, indices, scheds, opts ];

(* If there is only one schedule, create a list *)
showAffByVarSchedResult[
  var:_String,
  indices:_List,
  scheds:_sched,
  opts:___Rule
]:=
showAffByVarSchedResult[ var, indices, {scheds}, opts ];

(* Standard form *)
showAffByVarSchedResult[
  nomVar_String,
  indices_List,
  scheds:List[___sched],
  opts:___Rule
]:=
Module[ 
  { tauList, const, l1, blank, optSchedOnly, res},

  optSchedOnly = scheduleOnly/.{opts}/.Options[ showSchedResult ];

  tauList=scheds[[1,1]];
  const = scheds[[1,2]];

  res = 
    If[ optSchedOnly, "",
      "T_"<>nomVar<>ToString[indices]<>" = "
    ]
  <>
    ToString[
      Plus[Apply[Plus,MapThread[Times,{tauList,indices}]],
      const]
    ];

  If[ Length[scheds]>1,
    l1 = StringLength["T_"<>nomVar<>ToString[indices]<>" = "];
    blank= Apply[StringJoin,Table[" ",{i,1,l1}]];
    Do[
      tauList=scheds[[i,1]];
      const = scheds[[i,2]];
      res = res <> blank <>
        ToString[
          Plus[Apply[Plus,MapThread[Times,{tauList,indices}]],
			    const]
       ]
    ,
      {i,2,Length[scheds]}
    ]
  ];

  res

];
showAffByVarSchedResult[a___]:=(Message[showAffByVarSchedResult::WrongArg,a];
				Null);

(* renameindices can be use for renaming the indices for a given 
   variable or for all the variables when they have a common
   interpretation of indices (uniform program) *)

Clear[renameIndices];
renameIndices[newList:{__String},opts___Rule]:= 
  Module[{},
	 $result=Check[renameIndices[$result,newList,opts],$result]];

renameIndices::noParam= " The parameter should not be present in the
indice list ";

renameIndices[sys_Alpha`system,newList:{__String},opts___Rule]:= 
  Catch[
    Module[{nameParam },
	   nameParam = sys[[2,2]];
	   If [Intersection[nameParam,newList]=!={},
	       Message[renameIndices::noParam];
	       Throw[sys]];
	   renameIndices[sys,newList,Map[First,sys[[5]]],opts]
	 ]
  ];


renameIndices[sys_Alpha`system,
	    newList:{__String},
	    var:_String,
	      opts___Rule]:=
  Module[{},
	 renameIndices[sys,newList,{var},opts]];

renameIndices::notEnoughIndices="Not enough indices where provided to 
renames these indices: `1`, for variable `2`";

renameIndices[sys_Alpha`system,
	    newList:{__String},
	    varList:{__String},
	      opts___Rule]:=
Catch[
  Module[{nbParam,newsys, curVar,curIndiceList,
    indiceTaken,indiceWithParam,idMat1,stringExpr},
    nbParam=sys[[2,1]];
    newsys=sys;
    Do[ 
      curVar=varList[[i]];
      curIndiceList = getDeclarationDomain[newsys,curVar][[2]];
      If[ 
        Length[curIndiceList]>Length[newList]+nbParam
      ,
        Message[renameIndices::notEnoughIndices,
          Drop[curIndiceList,-nbParam],curvar];
	Throw[sys]
      ,
	indiceTaken=Take[newList,Length[curIndiceList]-nbParam];
	idMat1 = idMatrix[indiceTaken,indiceTaken];
	stringExpr = curVar<>"."<>ashow[idMat1,silent->True];
	newsys = changeOfBasis[ newsys, stringExpr, opts],
      ]
    ,
      {i,1,Length[varList]}
    ];
  newsys]
];

renameIndices::args= " wrong arguments ";

renameIndices[a___]:=renameIndices::args;

(************* Function provided by Fabien in AppSched.m ************)
Options[appSched] = {verbose->False, debug -> False, variables -> all};

Clear[appSched];

(* Call with system, schedule, and options *)
appSched[
 sys:_system,
 sch:_scheduleResult,
 options:___Rule] :=
Catch[
  Module[ {cv, ap, dbg},
    dbg = debug /.{options}/.Options[appSched];
    If[ dbg, Print["Call 1 with system, schedule and options"] ];
    (* Converts the schedule *)
    cv = Check[ convertSchedule[sch], Throw[ Null ] ];
    (* Call of appSched properly speaking *)
    ap = Check[ appSched[sys, cv , options ], Throw[ Null ] ]
  ]
];

(* Call with only the tf list *)
(* Not sure this is necessary, since one cannot 
   convert the list, unless the schedule is defined *)
appSched[
 tf:_List,
 options:___Rule] := 
Catch[
  Module[{ sys, vrb, dbg},
    dbg = debug /.{options}/.Options[appSched];
    If[ dbg, Print["Call 2 with tf and options"] ];

    (* $result does not contain a system, error *)
    If[!MatchQ[$result,_system],
      appSched::noSystem = "no default system ($result)";
      Message[appSched::noSystem];Throw[Null]
    ];

    (* normalize system, and call appSched *)
    sys = Check[appSched[$result,tf,options], Throw[Null]];
    sys = normalize[sys];

    (* modify $program and $result *)
    $program = $result;
    $result = sys
  ]
];

(* Call with schedule and options *)
appSched[
 sch:_scheduleResult,
 options:___Rule] := 
Catch[
  Module[ {cv, dbg},
    dbg = debug /.{options}/.Options[appSched];
    If[ dbg, Print["Call 3 with schedule and options"] ];
    (* Convert schedule into tf *)
    cv = Check[ convertSchedule[sch],Throw[Null] ];
    (* Call of appSched properly speaking *)
    Check[ appSched[ cv , options], Throw[Null] ]
  ]
];

(* Call with options only *)
appSched[options:___Rule] := 
Catch[
  Module[ {dbg}, 
    dbg = debug /.{options}/.Options[appSched];
    If[ dbg, Print["Call 4 with only options"] ];

    If[ !MatchQ[$schedule,_scheduleResult],
      Throw[Message[appSched::noSchedule]]
    ];

    appSched[$schedule, options]
  ]     
];


(* Main call with system, tf list, and options *)
(* 
  tf is the conversion of $schedule, using the convertSchedule function 
  It is a list of pairs, whose first argument is a variable name, 
  and second argument is a list of schedules for the variable.
*)
appSched[
  sys:_system,
  tf:_List,
  options:___Rule] := 

Catch[
  Module[{listVar, listTF, dbg, vrb, localVars, varsOfOption, optProjVector,
          optProjMatrix, optProcDim, optVars},

    (* Get options *)
    dbg = debug /.{options}/.Options[appSched];
    vrb = verbose /.{options}/.Options[appSched];
    optVariables = variables/.{options}/.Options[appSched];
    optProjVector = projVector /. {options}/. Options[appVarSched];
    optProjMatrix = projMatrix /. {options}/. Options[appVarSched];
    optTimeDim = timeDimensions /. {options}/. Options[appVarSched];
    optVars = variables/.{options}/. Options[appVarSched];

    If[ dbg, Print[ "tf: ", tf ] ];
    (* Get list of local vars *)
    listVar = getLocalVars[sys]; 
    localVars = listVar;

    (* listTF seems to be the list of schedules *)
    listTF = Join@@Map[Cases[tf, {#, _}]&, getLocalVars[sys]];
    If[ dbg, Print[ "listTF: ", listTF ] ];

    (* More than one schedule ??? *)
    If[Length[Union[Map[First, listTF]]] =!= Length[listTF],
      appSched::redundant = 
        "more than one schedule found, for at least one variable";
      Throw[Message[appSched::redundant]];
    ];

    If[Length[listTF]<Length[listVar],
      Scan[Message[appSched::missing,#]&, Complement[listVar,First/@listTF]];
      Throw[Null]
    ];

    (* Expand a possible other keyword in variables option *)
    optVars = variables /.{options}/. Options[appSched];
    varsOfOption = Cases[ optVars, _String, Infinity ];

    optVars = optVars/.{ other -> Complement[localVars, varsOfOption] };

    (* Recursive call to appVarSched *)
    Fold[
      Check[
        If[ vrb, Print["Calling appVarSched on : ", #2[[1]], " ", #2[[2]]] ];
        appVarSched[#1, #2[[1]], #2[[2]], projVector->optProjVector, 
           projMatrix -> optProjMatrix, timeDimensions -> optTimeDim, 
           variables -> optVars, debug -> dbg, verbose -> vrb ], 
        Print["Error...", Throw[ Null ] ]
      ]&,
      sys, listTF
    ]
  ]
];

appSched[a___] :=
  Module[{},
	 Message[appSched::wrongArg,{a}];
	 $Failed];

(* === *)

Options[appVarSched] = { verbose->False, recurse->False, debug->False, projVector->{},projMatrix->{}, timeDimensions->{}};

Clear[appVarSched];

appSched::multiDim=" Sorry cannot chose the projection vector for multidimensionnal schedules "
appSched::wrongDim="wrong Dimension of projection vector for var `1`, dimension should be `2`.  Forgetting projection vector "
appSched::notUnimod= "Cannot complete time function `1` only with projection veCtor, please give explicitely the projection Matrix"
appSched::notUnimod2= "Cannot complete time function `1` unimodulary with projection Matrix: `2` , please change the matrix"
appSched::wrongDim2= "wrong number of row of projection matrix for var `1`, number of row should be `2`.  Forgetting projection Matrix "


appVarSched[
 sys:_system,
 name:_String,
 cob:_/;MatrixQ[cob],
 options:___Rule] :=
Catch[
  Module[{parDim, cobMat, indList, timeDim, optDebug, optVerbose, 
    optProjVector,optProjMatrix ,dbg, procDim, cobMatTemp, vrb,
    projVector1,projMatrix1,varDimension, optTimeDim, var,
    localVars, varsOfOption },

    optDebug = debug /. {options}/. Options[appVarSched];
    optVerbose = verbose /. {options}/. Options[appVarSched];
    optProjVector = projVector /. {options}/. Options[appVarSched];
    optProjMatrix = projMatrix /. {options}/. Options[appVarSched];
    optTimeDim = timeDimensions /. {options}/. Options[appVarSched];
    optVars = variables/.{options}/. Options[appVarSched];

    dbg = debug /.{options}/. Options[appVarSched];
    vrb = verbose /.{options}/. Options[appVarSched];

    (* auxiliary function *)
    Clear[aux];
    aux[{s:{__String},i:{___Integer}}]:=
      Map[ {#,i}&, s ];

    (* If the var options has default value and timeDimensions is set, 
       distribute *)
    If[ optVars === all && MatchQ[ optTimeDim, {__Integer} ],
      optVars = Map[ {#, optTimeDim}&, getLocalVars[ sys ] ] ];

    (* If the var option has factorized positions, distribute
       the positions on the list of local variables *)
    If[ MatchQ[ optVars, {{{__String},{___Integer}}..} ],
      optVars = Apply[ Union, Map[ aux, optVars ] ] ];

    (* Get options for variable named name *)
    Which[ 
      MatchQ[ optVars, {{_String,{___Integer}}..} ], 
      var = Select[ optVars, First[#]===name& ];
      If[ Length[var]>1, Print["Length of option variable is wrong. Option variables Ignored."];
        var = {name,{}}, var = First[ var ] 
      ]
    ,
      MatchQ[ optVars, {___String}],
      var = Select[ Map[ {#,{}}&, optVars ], First[#]===name& ];
      If[ Length[var]>1, Print["Length of option variable is wrong. Option variables Ignored."];
        var = {name,{}}, var = First[ var ] 
      ]
    ,
      optVars === all,
      var = {name,{}}
    ,
      True, Print["Option variable has a wrong form. Ignored."];
      var = {name,{}}
    ];

    (* If variable does not appear in list of vars, do nothing *)
    If[ optVars =!= all && var === {},
      Return[sys] ];
    
    optTimeDim = Last[var];
    If[ vrb, Print["Calling appVarSched with variable ", name,
       " schedule matrix ", cob, " and time dimension ", optTimeDim ]
    ];

    (* Get dimension of parameters *)
    parDim = sys[[2,1]];

    (* Check that parDim is an integer *)
    If[ Not[ MatchQ[ parDim, _Integer] ],
      Message[appVarSched::system];Throw[Null]
    ];

    (* Check that optTimeDim is a list of integer *)
    If[ Not[ MatchQ[ optTimeDim, {___Integer}] ],
      appVarSched::timeDimensions=
        "timeDimensions should be a list of integers.";
      Message[appVarSched::timeDimensions];Throw[Null]
    ];

    (* Get time dimension *)
    timeDim = Length[cob];

    (* Compute unimodular completion of cob *)
    cobMat = Check[unimodCompl[cob,parDim], 
                   appSched::unimod = "error while calling unimodCompl";
                   Throw[ Message[appSched::unimod] ]
             ];

    If[ optDebug, Print["Time dimension : ", timeDim ] ];
    If[ optDebug, Print["Cob matrix before : ", cobMat] ];

    varDimension = Length[cob[[1]]]-1;
    If[ optDebug, Print["Var dimension : ", varDimension] ];
    If[ optDebug, Print["Parameter dimension : ", parDim ] ];

    Catch[
      If[ optProjVector=!={},
        projVector1= {optProjVector};
        projMatrix1=NullSpace[projVector1];
        If[ Length[cob]>1, Message[appSched::multiDim]; Throw[Null]];

	If[ varDimension=!=Length[projVector1[[1]]], 
          Message[appSched::wrongDim,name,varDimension]; Throw[Null]];

        cobMatTemp=Join[cob,Map[Append[#,0] &,projMatrix1]];

        (* Adding homogeneous dimension row *)
        cobMatTemp=Append[cobMatTemp,Append[Table[0,{i,1,varDimension}],1]];

        If[ Abs[Det[cobMatTemp]]=!=1,
          Message[appSched::notUnimod,cob];Throw[Null]
        ];

        cobMat=cobMatTemp;
      ] (* If *)
    ]; (* Catch *)

    Catch[
      If[ optProjMatrix=!={},
      projMatrix1=optProjMatrix;

      If[ Length[cob]+Length[projMatrix1]=!=varDimension, 
        Message[appSched::wrongDim2,name,varDimension-Length[cob]]; 
        Throw[Null]
      ];

      If[ varDimension=!=Length[projMatrix1[[1]]], 
        Message[appSched::wrongDim,name,varDimension]; Throw[Null]
      ];

      cobMatTemp=Join[cob,Map[Append[#,0] &,projMatrix1]];

      (* Adding homogeneous dimension row *)
      cobMatTemp=Append[cobMatTemp,Append[Table[0,{i,1,varDimension}],1]];

      If[ Abs[Det[cobMatTemp]]=!=1,
        Message[appSched::notUnimod2,cob,cobMatTemp];Throw[Null]
      ];

      cobMat=cobMatTemp;
      ]
    ]; (* Catch *)
    
    Catch[
      If[ optTimeDim=!={},

      (* Check that proc dimensions are within var dimension range *)
      If[ Apply[ Or, Map[ #1<=0 || #1>varDimension-parDim &, optTimeDim ] ], 
        appSched::wrongDim3 = 
          "Projection dimensions should be compatible with variable dimension. This option was ignored...";
        Message[appSched::wrongDim3,name]; 
        Throw[Null]
      ];

      (* Projection matrix is just identity where time dimensions
         were removed *)
      projMatrix1 = Drop[ IdentityMatrix[ varDimension ], optTimeDim ];

      If[ vrb, Print[ projMatrix1 ] ];

      If[ Length[cob]+Length[projMatrix1]=!=varDimension, 
        Message[appSched::wrongDim2,name,varDimension-Length[cob]]; 
        Throw[Null]
      ];

      If[ varDimension=!=Length[projMatrix1[[1]]], 
        Message[appSched::wrongDim,name,varDimension]; Throw[Null]
      ];

      cobMatTemp=Join[cob,Map[Append[#,0] &,projMatrix1]];

      (* Adding homogeneous dimension row *)
      cobMatTemp=Append[cobMatTemp,Append[Table[0,{i,1,varDimension}],1]];

      If[ Abs[Det[cobMatTemp]]=!=1,
        Message[appSched::notUnimod2,cob,cobMatTemp];Throw[Null]
      ];

      cobMat=cobMatTemp;
      ]
    ]; (* Catch *)
    
    If[ optDebug, Print["Cob matrix after  : ",cobMat] ];

    (* May be necessary to add a dimension to the cob matrix *)
    If[(Length[cobMat]>Length[cob[[1]]]) && optVerbose||dbg,
      Print["Warning: adding ",
        Length[cobMat]-Length[cob[[1]]],
         " dimension(s) for variable ", name]
    ];

    (* Build index list *)
    procDim = Length[cobMat] - parDim - 2; 
    procNames=If[MemberQ[sys[[2,2]],"p"],
		If [MemberQ[sys[[2,2]],"P"],
		      getNewName[sys,"p",verbose->False],
			   "P"],
		"p"];
    indList = 
    Which[
      timeDim == 1 && procDim == 1, {"t",procNames},
      timeDim == 1, 
      Join[ {"t"}, Table[ procNames<>ToString[k], 
                     {k, 1, Length[cobMat] - 1 - parDim - 1}]
      ],
      True, 
      Join[
        Table[("t"<>ToString[i]),{i,1,timeDim}],
        Table[ procNames<>ToString[k], 
              {k, 1, Length[cobMat] - 1 - parDim - timeDim}]
	(*
        Table[FromCharacterCode[ToCharacterCode["i"]-1+z],
          {z,1,Length[cobMat]-1-parDim-timeDim}]
	 *)
      ]
    ];

    (* Build change of basis matrix *)
    cobMat = matrix[Length[cobMat],
          Length[First[cobMat]],
          getDeclaration[sys,name][[3,2]],
          cobMat];

    (* Some info... *)
    If[optVerbose||dbg,
      Print["Doing CoB on variable ",name," with matrix ", 
      ashow[cobMat, silent->True],
      " (time dim: ", timeDim, ", proc dim: ",
      procDim, ", new indices: ", indList, ")"]
    ];

    Check[ 
       changeOfBasis[ sys, name, cobMat, indList, options ],
       appSched::cob = "error while calling changeOfBasis";
       Throw[Message[appSched::cob]]
    ]
  ]
];

appVarSched[a___] :=
Module[{},
  appVarSched::wrongArg = "`1`:\n wrong arguments";
  Message[appVarSched::wrongArg,{a}];
  Throw[$Failed]
];

(* === *)

Clear[convertSchedule];

convertSchedule[] := If[MatchQ[$schedule,_scheduleResult],
		       convertSchedule[$schedule],
		       $Failed];


convertSchedule[
  sch : scheduleResult[_, _List, _List]] := verbFail[convertSchedule::failed,
    Catch[
      Module[{func},
	     func[l:_List] :=   
                Module[{tab, zero},
		      If[Not[MatchQ[l,List[_String,{___String},sched[{___Integer},_Integer]..]]], 
                        Message[convertSchedule::corrupted];Throw[$Failed]];
		      tab = Map[Apply[List,#]&, Drop[l,2]]; (* tab is {{{1,2},3}}, for {sched[{1,2},3]} *)
		      {First[l],Map[Flatten,tab]}
		      ];
	     func[___] := (Message[convertSchedule::corrupted];Throw[$Failed]);
	     Map[func,sch[[2]]]
	   ]
    ]];


(* virtual schedule *) 
convertSchedule[scheduleResult[]]={{}}

convertSchedule[a___] :=
Module[{},
      Message[convertSchedule::wrongArg,{a}];
      $Failed];

(* identitySched[sys,level] builds the identity Schedule for an Alpha program i.e. the 
schedule where the "level" first indices is the schedule of each variable (valid only if the 
program is already scheduled) *)

Clear[identitySchedule]

identitySchedule[sys:_system,level:_Integer,options:___Rule]:=
Catch[
      Module[{optVerbose,allDecl,allSched,finalSched},
	    optVerbose = verbose /. {options}/. Options[testSched];
	    allDecl=Join[sys[[3]],sys[[4]],sys[[5]]];
	    allSched=Map[identitySchedule[sys,#,level,options] &,allDecl];
	    finalSched=scheduleResult[sys[[1]],allSched,{0}];
	    If[!testSched[sys,finalSched,verbose->False,onlyLocalVars->True],
	      If[optVerbose,Print["Warning, the identity schedule is not valid (probably due to I/O)    "]];
	    ];
	    finalSched
      ]
]


identitySchedule::tooFewDims="Cannot chose a schedule of dimension `1` for variable `2`: not enough dimensions" 

identitySchedule[sys:_system,decl1:_decl,level:_Integer,options:___Rule]:=
Module[{varName,dimVar,idMat,subIdMat},
      varName=decl1[[1]];
      dimVar=decl1[[3,1]];
      If[dimVar-sys[[2,1]]<level,
	Message[identitySchedule::tooFewDims,level, decl1[[1]]];Throw[NULL]];
      (* building {{1,0,....},
	           {0,1,0,...} (up to level)
                        ....
		     {0,...,0}} *)
      idMat=IdentityMatrix[dimVar];
      subIdMat=Take[idMat,level];
      Join[{varName,decl1[[3,2]]},Map[sched[#,0] &,subIdMat ]]
	]



 identitySchedule::wrongArg="wrong Argument for function identitySchedule : `1` "

  identitySchedule[a:___]:=Message[identitySchedule::wrongArg,Map[Head,{a}]]

identitySched[sys:_system,level:_Integer,]



 Clear[isScheduledQ]

Options[isScheduledQ] = {debug->False,onlyLocalVars->False,durations->{}}

isScheduledQ[options:___Rule]:=isScheduledQ[$result,1,options];

isScheduledQ[sys:_system,options:___Rule]:=isScheduledQ[sys,1,options];

 isScheduledQ[sys:_system,dim:_Integer,options:___Rule]:=
    Module[{optOnlyLocalVars,optDebug,optDurations,idSched,isValid},
      optOnlyLocalVars = onlyLocalVars /. {options}/. Options[isScheduledQ];
      optDebug = debug /. {options}/. Options[isScheduledQ];
      optDurations = durations /. {options}/. Options[isScheduledQ];
      
      idSched=identitySchedule[sys,dim,options,verbose->False];
      isValid=testSched[sys,idSched,options,verbose->False]
       ]

 isScheduledQ::wrongArg="wrong Argument for function isScheduledQ : `1` "

  isScheduledQ[a:___]:=Message[isScheduledQ::wrongArg,Map[Head,{a}]]

Options[testSched] = {verbose->True, debug->False, durations->{},onlyLocalVars ->False};

Clear[testSched];

(* empty *)

testSched[options:___Rule] :=
  testSched[$result, $schedule, options];

(* with scheduleResult *)
     
     testSched[
	       h:___,
	       sch:_scheduleResult,
	       t:___] :=
testSched[h, convertSchedule[sch], t];

(* default system *)

testSched[
 tf:{__List},
 var:_String,
 options:___Rule] :=
  If[MatchQ[$result, system[_,_,_,_,_,_]],
     testSched[dep[$result],tf, var, options],
     $Failed];

testSched[
 tf:{__List},
 options:___Rule] :=
  If[MatchQ[$result, system[_,_,_,_,_,_]],
     testSched[dep[$result], tf, options],
     $Failed];

(* with system *)

testSched[
 sys:_system,
 tf:{__List},
 var:_String,
 options:___Rule] :=
  testSched[dep[sys], tf, var, options];

testSched[
 sys:_system,
 tf:{__List},
 options:___Rule] :=
Module[{depends,optOnlyLocalVars, depends2, depends3},
      depends=dep[sys]	;
      optOnlyLocalVars = onlyLocalVars /. {options}/. Options[testSched];
      depends3=depends;
      If [optOnlyLocalVars,(* remove output vars *) 
			  depends2=dtable[Select[depends[[1]],Not[MemberQ[Map[First, sys[[4]]],#[[2]]]] &]];
			  depends3=dtable[Select[depends2[[1]],Not[MemberQ[Map[First, sys[[3]]],#[[3]]]] &]];
			  ];
      testSched[depends3, tf,  options]
      ]

(* with dep table *)

testSched[
 dt:dtable[{___depend},___],
 tf:{__List},
 var:_String,
 options:___Rule] :=
  Module[{d},
	 d = dtable[Cases[dt[[1]], depend[__,var,___]]];
	 testSched[d, tf, options]
       ];

testSched[
 dt:dtable[{___depend},___],
 tf:{__List},
 options:___Rule] :=
  Catch[
    Module[{times,newOptions},
	   optDurations = durations /. {options}/. Options[testSched];
	   If[optDuration=!={},
	     If [Not[MatchQ[optDurations,_Integer|{}]],
		    Print["Sorry, only simple integer allowed for duration option currently, forgetting duration..."];
		    newOptions=Select[{options},Not[MatchQ[#,Rule[durations,___]]] &],
		    newOptions={options}],
	     newOptions={options}];
	   Apply[And,
		 Map[Apply[testSched,Join[{#,tf},newOptions]]&,
		     dt[[1]]]]
	 ]
  ];

testSched[
 dp:_depend,
 tf:{__List},
 options:___Rule] := verbFail[testSched::failed,
  Catch[
    Module[{lX, lY, d, m, pX, pY, mat, im, neg, intersec,optVerbose},
	   optVerbose = verbose /. {options}/. Options[testSched];
	   optDebug = debug /. {options}/. Options[testSched];
	   optDuration = durations /. {options}/. Options[testSched];
	   If[optDebug,
	     Print["Testing ", show[dtable[{dp}], silent->True]]];
	   pX = Position[tf, dp[[2]]];
	   If[pX==={},
	      Message[testSched::missing, dp[[2]]];
	      Throw[$Failed]];
	   lX = tf[[pX[[1,1]],2]];
	   pY = Position[tf, dp[[3]]];
	   If[pY==={},
	      Message[testSched::missing,dp[[3]]];
	      Throw[$Failed]];
	   lY = tf[[pY[[1,1]],2]];
	   d = dp[[4]];
	   m = lX - lY.d[[4]];
	   mat = matrix[Length[m]+1, Length[m[[1]]], dp[[4,3]],
			Append[m, Table[If[i==Length[m[[1]]],1,0],{i,1,Length[m[[1]]]}]]];
	   (* added for the duration option. if the duration is set for this 
	   equation, we shift the time domain by it *) 
	   If [MatchQ[optDuration, _Integer],
		     mat=ReplacePart[mat,mat[[-1,-2,-1]]-optDuration+1,{-1,-2,-1}]];    
	   If[optDebug,
	     Print["duration = ",optDuration, " taken into account"]];
	   If [optDebug,show[mat]];
	   im = With[{im = DomImage[dp[[1]],mat]},
		     ReplacePart[im, Array[StringJoin["t",ToString[#]]&, Length[im[[2]]]],2]];
	   If[optDebug,
	      With[{vect = Append[dp[[1,2]], 1]},
		   Print["Time is ", m.vect,
			 ", takes values on: ", show[im,silent->True]]]];
	   neg = domLexLower[Append[Array[0&,{im[[1]]-1}],1]];
	   intersec = DomIntersection[im, neg];
	   If[DomEmptyQ[intersec],
	      True,
	     If[optVerbose,
	       Print["Error : the dependency ",show[dtable[{dp}],silent->True], "
is not respected on ", show[DomIntersection[dp[[1]],
					    DomPreimage[intersec,
							mat]], silent->True]];
	       Print["        value: ", show[im,silent->True]]];
	      False]
	 ]
  ]];

testSched[a___] :=
  Module[{},
	 Message[testSched::wrongArg,Print[a];{a}];
	 $Failed];

(* === *)



 Clear[equationOrderQ]
Options[equationOrderQ]={debug->False,checkSched->True}

equationOrderQ[options___Rule]:=
    Module[{res},
	  res= equationOrderQ[$result,options]
         ]

equationOrderQ[sys:_system,options___Rule]:=
Module[{depends,depends2,depends3,listEq,adjMat,curDep,curLHS,curMat,optDebug,
	result,idDepGraph,permutation,posRHS,posLHS},
      optDebug = debug /. {options}/. Options[equationOrderQ];
      optCheckSched = checkSched /. {options}/. Options[equationOrderQ];
      If [optDebug,Print["starting equationOrderQ  ....... "]];
      If [optCheckSched,
		       If [optDebug,Print["checking Schedule..."]];
		       If[!isScheduledQ[sys,onlyLocalVars->True,durations->0],
			 Print["Warning, it seems that program ",sys[[1]],
			      " is not scheduled "]]
		       ];
      depends=dep[sys][[1]];
      depends2=Select[depends,Not[MemberQ[Map[First, sys[[4]]],#[[2]]]] &];
      depends3=Select[depends2,Not[MemberQ[Map[First, sys[[3]]],#[[3]]]] &];
      listEq=Map[First,sys[[6]]];
      (* remove output vars *)
      listEq=Select[listEq,MemberQ[Map[First,sys[[5]]],#] &];
      If [optDebug,Print["listEq",listEq]];
      If [optDebug,Print["depends3"];show[dtable[depends3]]];
      (* adjacencyMatrix for identity dependencies *) 
      adjMat=Table[Table[0,{j,1,Length[listEq]}],{i,1,Length[listEq]}];
      result=True;
      (* for each identity dep, check textual order *)
      Do[curDep=depends3[[i]];
	curRHS=curDep[[3]];
	curLHS=curDep[[2]];
	posRHS=Position[listEq,curRHS];
	posLHS=Position[listEq,curLHS];
	If[ posRHS==={} || posLHS==={},
	Print["Warning, some I/O variable is used in Computation in a non standard way, please check"],
	(* else OK *) 
	posLHS=posLHS[[1,1]];
	posRHS=posRHS[[1,1]];
	curMat=curDep[[4]];
	If [identityQ[curMat],
		     If [optDebug,Print["Dep number ",i,"..."]];
		     If[posLHS<posRHS,
		       If [optDebug,Print["Not oriented! "]];
		       result=False];
		     adjMat=ReplacePart[adjMat,1,{posRHS,posLHS}];
	]
	]
	,{i,1,Length[depends3]}];
      
      idDepGraph=Graph[adjMat,listEq];
      If [optDebug,Print["id Dep Graph ",idDepGraph]];
      If [optDebug,Print["temp result is  ",result]];
      If [result===False,
		result=Check[permutation=TopologicalSort[idDepGraph];
			    If [optDebug,Print["proposed order",
					      Permute[listEq,permutation]]];
			    permutation,
			    False];
      ];
      result 
]

 equationOrderQ::Wrongarg="wrong Argument for function equationOrderQ : `1` "

  equationOrderQ[a:___]:=Message[equationOrderQ::wrongArg,Map[Head,{a}]]



 Clear[reorderEquations]

 Options[reorderEquations]={debug->False}

reorderEquations::permutation= "the permutation should be `1` long "

reorderEquations[permutation:{___Integer},options___Rule]:=
      Module[{res},
	    res=reorderEquations[$result,permutation,options];
	    If[MatchQ[res,system[___]],
	      $result=res,
	      $result]
	    ]

reorderEquations[sys:_system,permutation:{___Integer},options___Rule]:=
Catch[
      Module[{optDebug,listEq,listLocalEq,listOutputEq,newLocalEq,newEq},
	    optDebug = debug /. {options}/. Options[equationOrderQ];
	    If [optDebug,Print["starting reorder Equation ....... "]];
	    listEq=sys[[6]];
	    (* remove output equation *) 
	    listLocalEq=Select[listEq,Not[MemberQ[Map[First, sys[[4]]],#[[1]]]] &];
	    listOutputEq=Select[listEq,MemberQ[Map[First, sys[[4]]],#[[1]]] &];
	    If [Length[permutation]=!=Length[listLocalEq],
		      Message[ reorderEquations::permutation,Length[listLocalEq]];
			     Throw[sys]];
	    newLocalEq=Permute[listLocalEq,permutation];
	    newEq=Join[newLocalEq,listOutputEq];
	    ReplacePart[sys,newEq,{6}]
	    ]
      ]

 reorderEquations::wrongArg="wrong Argument for function reorderEquations : `1` "

  reorderEquations[a:___]:=Message[reorderEquations::wrongArg,Map[Head,{a}]]



(***************************************************************)
(***************************************************************)
(* Set of function used for structured scheduling              *)
(***************************************************************)
(***************************************************************)


 buildNewEqs::usage=" in test "

Options[buildSchedConstraints]={debug->False,scheduleDim->1,structSchedType->mono,multiSchedDepth->1}

Clear[buildSchedConstraints];
buildSchedConstraints[opt:___Rule]:=
  Module[{},
     buildSchedConstraints[$result,$scheduleLibrary,opt]
  ]

buildSchedConstraints[sys:_system,opt:___Rule]:=
  buildSchedConstraints[sys,$scheduleLibrary,opt];

buildSchedConstraints[
  schedLib:List[(_Alpha`scheduleResult|_List)...],opt:___Rule]:=
  buildSchedConstraints[$result,schedLib,opt];

buildSchedConstraints::schedNotFound="schedule not found for sub-system `1`"
buildSchedConstraints::nodepth="option multiSchedDepth should be set";
buildSchedConstraints::LengthScheduleDim="Warning, the length of the
options scheduleDim should be `1`"
buildSchedConstraints::LengthOptStructSchedType="Warning, the length of the
options structSchedType should be `1`"

buildSchedConstraints[sys_Alpha`system,
  schedLib:List[(_Alpha`scheduleResult|_List)...],
  opt:___Rule]:=
Catch[
  Module[{optDebug,optScheduleDim,optStructSchedType,
    nextOptScheduleDim,nextOptStructSchedType,
    allUses,nbUse,nbSched,constraintList,nextOptions,optMultiSchedDepth,
    curUse,curUseName,curSched,curConstraintList},

    optDebug=debug/.{opt}/.Options[buildSchedConstraints];
    optScheduleDim=scheduleDim/.{opt}/.Options[buildSchedConstraints];
    optMultiSchedDepth=multiSchedDepth/.{opt}/.Options[buildSchedConstraints];
    optStructSchedType=structSchedType/.{opt}/.Options[buildSchedConstraints];

 (* scheduleDim is 1 if the constraints are for pipeline
    approach, it is a list of integer otherwise indicating the 
    depth of the resulting constraints
    stuctSchedType is linear or multi or list of these. 
    In both cases, the length of the listmust be the 
    number of uses *)
	   
 (* Check that multisched option and multisched depth are
    set *)
    If[ optStructSchedType===multi && optMultiSchedDepth<=1,
       Message[ buildSchedConstraints::nodepth ];
       Throw[{}];Return[{}]];


    (* Get uses *)
    allUses=Select[sys[[6]],MatchQ[#,Alpha`use[___]] &];
    (* Get number of uses *)
    nbUse=Length[Union[Map[First,allUses]]];

    (* Check dimension of option structSchedType *)
    If[ optScheduleDim=!=1,
      If[ Length[optScheduleDim]=!=Length[allUses],
        Message[buildSchedConstraints::LengthScheduleDim,Length[allUses]],
        nextOptScheduleDim=optScheduleDim
      ],
      nextOptScheduleDim=Table[1,{i,1,Length[allUses]}]
    ];

    (* Check option *)
    If[ optStructSchedType=!=mono&&optStructSchedType=!=multi,
      If[ Length[optStructSchedType]=!=Length[allUses],
	 Message[buildSchedConstraints::LengthOptStructSchedType,
	   Length[allUses]]; Throw["{}"],
	 nextOptStructSchedType=optStructSchedType
      ],
      nextOptStructSchedType=Table[optStructSchedType,{i,1,Length[allUses]}]
    ];

    (* Check that the schedule library contains enough 
       schedules... *)
    nbSched=Length[schedLib];
    constraintList=	   
      If[ optStructSchedType===mono,
        {},
        Table[{},{i,1,optMultiSchedDepth}]
      ];
    If[ nbUse>nbSched,
      Print["Incompatibility between the number of schedule
available and the number of uses of ", $result[[1]]];Throw[{}],

    Do[ 
      nextOptions={debug->optDebug,
      scheduleDim->nextOptScheduleDim[[i]],
      structSchedType->nextOptStructSchedType[[i]]};
      curUse=allUses[[i]];
      curUseName=curUse[[1]];

      (* I changed here the pattern, as $scheduleLibrary 
        may contain schedules given in the vertex format *)
      curSched=
        Select[
          schedLib,
          First[#]===curUseName&&Head[#]===Alpha`scheduleResult &
        ];
      (* I (PQ) changed this, so that the schedule results given
      by VertexSchedule are "filtered" from the second argument *)
      curSched = 
	Map[
          Function[ {x}, 
            If[ MatchQ[x,scheduleResult[name:_,params:_,sin:_,so:_]],
		scheduleResult[x[[1]],x[[3]],x[[4]]],
		x
            ]
          ],
          curSched		       
	];
      
      If[ optDebug,Print["\n********  USE ",curUseName,"******"]];
      If[ optDebug,showSchedResult[curSched]];
      If[ optDebug,show[curUse]];
      If[ optDebug,
        Print["structSchedType: ",nextOptStructSchedType[[i]]]];

      If[ curSched==={},
        Message[buildSchedConstraints::schedNotFound,curUseName],
        curSched=First[curSched]];

      curConstraintList=
        Apply[buildSchedConstraintForUse,
          Join[{sys,curUse,curSched},nextOptions]];

      If[ optDebug,Print["current builded constraints:
			      \n",curConstraintList]];
      constraintList=
        Which[

          optStructSchedType===mono,
          Join[constraintList,curConstraintList],

          optStructSchedType===multi,
          Which[
            Length[constraintList]===Length[curConstraintList],
            MapThread[
		 Join,{constraintList,curConstraintList}],
	       Length[constraintList]>
		 Length[curConstraintList],
	       MapThread[
		 Join,
		 {constraintList,
		  Join[curConstraintList,
		       Table[{},{j,1,Length[constraintList]-
				 Length[curConstraintList]}]]}],
  
            True,
            Print["Problem1 in buildSchedConstraints,"];Throw[{}]
          ], (* Which *)

        True, (* optStructSchedType is a list *)
        If[nextOptStructSchedType[[i]]===mono,
          MapThread[
            Join,
            {constraintList,
            Join[{curConstraintList},
            Table[{}, {j,1,Length[constraintList]-1}]]}
          ],
          If [Length[curConstraintList]>optMultiSchedDepth,
            Print["in buildSchedConstraints: sorry options  multiSchedDepth is not set to a correct value "]; Throw[{}],
            MapThread[
              Join,
	    {constraintList,
	     Join[curConstraintList,
		  Table[{},{j,1,Length[constraintList]-
			    Length[
			      curConstraintList]}]]}]]
         ] (* If *)
       ]; (* Which *)
		 
       If[ optDebug,Print["builded constraints: \n",constraintList]],
         {i,1,Length[allUses]}]
   ];
  constraintList
  ]
];
buildSchedConstraints[___]:=Message[buildSchedConstraints::params];



Clear[buildSchedConstraintForUse];
Options[buildSchedConstraintForUse]:=Options[buildSchedConstraints]

 buildSchedConstraintForUse::noVarForm= " in use of `1` The input variable have not the form of simple variables";

 buildSchedConstraintForUse::paramAssign = "Sorry the non identity
 parameter assignement fonction (restricted on parameter is not
 implemented"

  buildSchedConstraintForUse[sys:_system,
  use1:_use,
  sched1:_Alpha`scheduleResult,
  opts:___Rule]:=
  Module[
    {optDebug,optStructSchedType,optScheduleDim,
     inVars,outVarNames,nbParam,DepMat,SelectDepMat,idMatLoc,
     inVarNames,SubNames,inSubNames,outSubNames,coupledNames,
     constraintsLinear,constraintsConstant,vertexSched},

     optDebug=debug/.{opts}/.Options[buildSchedConstraintForUse];
     optScheduleDim=scheduleDim/.{opts}/.Options[buildSchedConstraints];
     optStructSchedType=
      structSchedType/.{opts}/.Options[buildSchedConstraints];

    (* Get the names of the input/output variables of the caller *)
    inVars=use1[[4]];
    outVarNames=use1[[5]];
    If[ !(MatchQ[inVars,List[Alpha`var[_String]..]]),
      Message[buildSchedConstraintForUse::noVarForm,use1[[1]]];
      Return[{}]];

    (* Checking that the parameter assignement function is
      identity *)
    nbParam=sys[[2,1]];
    DepMat=Part[use1,3,4];

    (* This sets a boolean flag telling the the schedule has the
       Vertex format *)
    (* PQ. 19/05/04 *)
    vertexSched = 
      MatchQ[ sched1, scheduleResult[_String,_List,{{_String,__}...}]];
    If[ optDebug, 
	If[ vertexSched, Print["This is a Vertex type Schedule"],
	Print["This is a Farkas type Schedule"]
    ]];		    

    inVarNames = Map[First,inVars];

    (* Get the names of the input/output variables of the called *)
    (* A small modification, to comply with the format of the
       Vertex schedule *)
    (* PQ. 19/05/04 *)
    If[ !vertexSched, 
      SubNames = Map[First,sched1[[2]]];
      inSubNames = Take[SubNames,Length[inVarNames]];
      outSubNames = Take[SubNames,{Length[inVarNames]+1,
                      Length[inVarNames]+Length[outVarNames]}]
    ,
      inSubNames = Map[First,sched1[[2]]];
      outSubNames = Map[First,sched1[[3]]]
    ];

    coupledNames=MapThread[{#1,#2} &,{Join[inVarNames,outVarNames],
					   Join[inSubNames,outSubNames]}];
    If[ 
       Length[sched1[[2,1]]]>3,
       Print["schedule multiDim not implemented yet"];
       Return[{}]
    ];

    constraintsConstant=
      buildConstantPartSchedConstraintForUse[
       sys,use1,sched1,coupledNames,opts];
       constraintsConstant ]
       
buildSchedConstraintForUse[___]:=Message[buildSchedConstraintForUse::WrongArg]

buildConstantPartSchedConstraintForUse::varNotFound=
"variable `1` not found in schedule of system `2`"

(* This is the function that really build the constraints for a single
   use, it generates all the constraints, the result is a list (if
   mono  mode is selected in the option StructSchedType)
   or a list of list (if multi mode) *)

Clear[buildConstantPartSchedConstraintForUse];

buildConstantPartSchedConstraintForUse[sys:_system,
  use1:_use,sched1:_scheduleResult,coupledNames:List[_List..],opts:___Rule]:=
  Module[
    {optDebug,nbParam,optScheduleDim, optStructSchedType,
     nbExtension,firstInVar,nbParamCalled,
     firstInVarCalled,schedFirstInVar,constFistInVar,constraintList,
     curExtConstraints,extConstraints,
     curVar,nbIndiceCurVar,curVarCalled,nbIndiceCurVarCalled,
     schedCurVar,constCurVar,curConstraint,vertexSched
    },

    (* In this function all the variables are followed by "called"
       when they correspond to names in the subsystem called, all the
       nbIndice variables include implicitly the parameter *)

    (* Get options *)
    optDebug=debug/.{opts}/.Options[buildSchedConstraintForUse];
    optScheduleDim=scheduleDim/.{opts}/.Options[buildSchedConstraints];
    optStructSchedType=
    structSchedType/.{opts}/.Options[buildSchedConstraints];

    (* Set a flag to say if the schedule has the Vertex format *)
    (* PQ. 19/05/04 *)
    vertexSched = MatchQ[sched1,scheduleResult[_String,_List,{{_String,__}...}]];

    (********* Caller information *******************************)
    nbParam = sys[[2,1]];
    nbExtension = use1[[2,1]];
    firstInVar = coupledNames[[1,1]];

    If[ optDebug, Print["First in var: ", firstInVar ] ];

    (********* Called information *******************************)
    nbParamCalled = use1[[3,1]]-1;
    firstInVarCalled = coupledNames[[1,2]];
    If[ optDebug, Print["First in var called: ", firstInVarCalled ] ];

    (* Look for the schedule of the first input var in the schedule *)
    schedFirstInVar = 
      First[Select[sched1[[2]], First[#]===firstInVarCalled &]];
    If[ optDebug, Print["Schedule of the first in var: ", schedFirstInVar ] ];

    nbIndiceFirstInVar = Length[getDeclaration[sys,firstInVar][[3,2]]];
    nbIndiceFirstInVarCalled =
      nbIndiceFirstInVar-nbExtension+nbParamCalled;

    If[ schedFirstInVar === {},
      Message[buildConstantPartSchedConstraintForUse::varNotFound,
      firstInVarCalled,use1[[1]]]
    ];

    constFistInVar = Part[schedFirstInVar,3,2];
    constraintList={};
    extConstraints={};

    (* Set the constraints on the regular indices of the  first var *)
    If[ optDebug, Print["Callee Indices constraints: "] ];

    Do[ 
      curConstraint = 
          buildOneSchedConstraint[
            firstInVar,firstInVar,dim,dim,schedFirstInVar[[3,1,dim]],1];
      If[ optDebug, Print[curConstraint] ];

      constraintList = Append[constraintList,curConstraint];

      If[ optStructSchedType===multi,
        curExtConstraints = 
          buildOneSchedConstraint[firstInVar,firstInVar,dim,dim,0,1];
        extConstraints=Append[extConstraints,curExtConstraints]
      ]
 
     ,{dim,1,nbIndiceFirstInVar-nbExtension}
    ]; (* Do *)

    (********* Do loop on the couples of coupledNames ************
      Remember that coupledNames is a list of couples. Each couple
      correspond to a name of a variable input or output to a use
      (effective parameter)  associated with the name of the 
      corresponding variable in the subsystem called
      (formal parameter)                                        *)


    Do[ 
      curVar = coupledNames[[i,1]];
      nbIndiceCurVar=Length[getDeclaration[sys,curVar][[3,2]]];
      curVarCalled=coupledNames[[i,2]];
      nbIndiceCurVarCalled=nbIndiceCurVar-nbExtension+nbParamCalled;

      (* This selects the schedule of the variable *)
      (* If the schedule has the form of a Vertex schedule, 
         it has to be changed *)
      (* PQ. 19/05/2004 *)
      If[ !vertexSched,
        schedCurVar = 
          First[Select[sched1[[2]],First[#]===curVarCalled &]]
      ,
        schedCurVar = 
          First[Select[Join[sched1[[2]],sched1[[3]]],
		       First[#]===curVarCalled &]]
      ]; 

      constCurVar = Part[schedCurVar,3,2];

      (********* set the constraint on the constant part ********)
      curConstraint="C"<>curVar<>"-C"<>firstInVar<>"=="<>
        ToString[constCurVar-constFistInVar];
      If [optDebug,Print["Constant constraint: ",curConstraint]];
      constraintList=Append[constraintList,curConstraint];
      If [optStructSchedType===multi,
	 curExtConstraints ="C"<>curVar<>"-C"<>firstInVar<>"==0";
	 extConstraints=Append[extConstraints,curExtConstraints]];

      (********* set the constraints on the regular indices ********)
      If[ optDebug, Print["Callee Indices constraints: "] ];

        Do[ 
          curConstraint = 
          buildOneSchedConstraint[
          curVar,curVar,dim,dim,schedCurVar[[3,1,dim]],1];

          If[ optDebug, Print[ curConstraint] ];

            constraintList = Append[constraintList,curConstraint];
            If[ optStructSchedType === multi,
              curExtConstraints =
              buildOneSchedConstraint[curVar,curVar,dim,dim,0,1];
              extConstraints=Append[extConstraints,curExtConstraints]]
              ,{dim,1,nbIndiceCurVar-nbExtension}
             ];

	     (******  set the constraint on the extension indices ********)
	     Do [curExtConstraints=
              (* TcurVarDxxx-TfirstInVarDyyy == 0    *)
              buildOneSchedConstraint[curVar,firstInVar,
                nbIndiceCurVar-nbExtension+dim,
                nbIndiceFirstInVar-
                nbExtension+dim,
                0,2];
              extConstraints=Append[extConstraints,curExtConstraints];
              If [optDebug,Print["Extension constraints: "]];
              If [optDebug,Print[extConstraints]];
                ,{dim,1,nbExtension-nbParam}
              ];
	     
             (***** then set the constraint on the parameter of the called ***)
             (* for each parameter of the called program, 
		  we must set the corresponding value to all the 
		  parameter/extension indices involved in the
		  parameter assignement of this parameter *)

             (** first Do loop: on the parameter of the called ***)
             Do[
               curParamAssignRow=use1[[3,4,dim]];
               (* second Do loop on all the parameters/ext indices
                  of the caller which may be used in the assignment 
                  of the a parameter of the called *)
                Do [callCoef=curParamAssignRow[[callerDim]];
                  If [callCoef=!=0,
                   (***  set a constraints on the caller param **)
                    callStringCoeff=If[callCoef===1,"",
                      ToString[callCoef]];

                    curConstraint= buildOneSchedConstraint[
                      curVar,firstInVar,
                      nbIndiceCurVar- 
                        nbExtension+callerDim,
                      nbIndiceFirstInVar-
                        nbExtension+callerDim,
                      callStringCoeff,
                      callStringCoeff,
                      schedCurVar[[3,1,
                        nbIndiceCurVarCalled+dim- nbParamCalled]]
                        -schedFirstInVar[[3,1,
                        nbIndiceFirstInVarCalled+
                        dim-nbParamCalled]],
                      2
                    ];
                    If [optDebug,Print["Parameter constraints: "]];
                    If [optDebug,Print[curConstraint]];
                    constraintList = Append[constraintList, curConstraint]
                  ];
                  ,{callerDim,1,Length[curParamAssignRow]-1 }
                ]
                  ,{dim,1,nbParamCalled}
             ];

	     (***  another do loop for the caller parameters 
               which are not use in the	assignement for which
	       the coefs must be the same for all variables
	       (as extension indices) *)
             Do[ 
               assigParMat=use1[[3,4]];
               paramColumn=Map[Part[#,-nbParam+callerDim-2] &,
                 assigParMat];
               If[ 
                 paramColumn===Table[0,{k,1,Length[paramColumn]}],
                 (***  set a constraints on the caller param **)
                 curConstraint = 
		   buildOneSchedConstraint[
                     curVar,firstInVar,
                     nbIndiceCurVar-nbParam+callerDim,
                     nbIndiceFirstInVar-nbParam+callerDim,
			       0,2
		   ];
                   If[ optDebug,Print["Parameter constraints: "]];
                   If [optDebug,Print[curConstraint]];
                   constraintList=Append[constraintList,curConstraint];
               ];

               If [optStructSchedType===multi,
			   curExtConstraints=buildOneSchedConstraint[
			     curVar,firstInVar,
			     nbIndiceCurVar-nbParam+callerDim,
			     nbIndiceFirstInVar-nbParam+callerDim,
			     0,2];
			   extConstraints=
			     Append[extConstraints,curExtConstraints]
                ]
		     ,{callerDim,1,nbParam}
              ]
	     ,{i,2,Length[coupledNames]}
         ];

	 (* constraintList contains the list of constraints relative
	    to the subsystem, extConstraints contains the list of
	    constraints relative to the extension domain *)
         predRes=Table[{},{i,1,optScheduleDim-1}];
	 res=Join[predRes,
		  If [optStructSchedType===mono,
		      Join[constraintList,extConstraints],
		      {extConstraints,constraintList}]
		];
	 res]
	 
buildConstantPartSchedConstraintForUse[___]:=buildConstantPartSchedConstraintForUse::WongArg		   

Clear[buildOneSchedConstraint]

buildOneSchedConstraint[var1:_String,
 var2:_String,dim1:_Integer,dim2:_Integer,
 value1:_Integer,typeC:_Integer]:=
buildOneSchedConstraint[var1, var2,dim1,dim2,"","",value1,typeC]

buildOneSchedConstraint[var1:_String,
 var2:_String,dim1:_Integer,dim2:_Integer,
  coeff1:_String,coeff2:_String,
 value1:_Integer,typeC:_Integer]:=
  Module[{str1,str2,constr},
	 (* typeC is one if the constraint is of type 
	   Tvar1Ddim1==value1 
	    and two if  the constraint is of type 
	    Tvar1Ddim1-Tvar2Ddim2-value1==0 *)
	   str1=StringJoin["T",var1,"D",ToString[dim1]];
	 str2=StringJoin["T",var2,"D",ToString[dim2]];
	 If[typeC===1,
	    constr=StringJoin[str1,"==",ToString[value1]],
	    constr=StringJoin[str1,"-",str2,"==",ToString[value1]]];
	 constr]

buildOneSchedConstraint[a:___]:= 
  (Message[buildOneSchedConstraint::WrongArg];"0==0";Print[InputForm[a]];)

(************* buildPseudoAlpha[] remove the uses from an Alpha
	 program, replace them by equlities to 0
	 (used for structured scheduling) **************) 
	 
Clear[buildPseudoAlpha]
	 buildPseudoAlpha[]:=
	   buildPseudoAlpha[$result]
	 
buildPseudoAlpha[sys:_Alpha`system]:=
  Module[{equs,useEqs,newEqs,oldEqs,brandNewEqs},
	 eqs=sys[[6]];
	 useEqs=Select[eqs,Length[Position[#,use]]=!=0 &];
	 newEqs=Apply[Join,Map[buildNewEqs[sys,#] &,useEqs]];
	 oldEqs=Select[eqs,Length[Position[#,use]]===0 &];
	 brandNewEqs=Join[oldEqs,newEqs];
	 Alpha`system[sys[[1]],sys[[2]],sys[[3]],sys[[4]],sys[[5]],
		      brandNewEqs]]
	 
Clear[buildNewEqs]
buildNewEqs[sys_Alpha`system,use1:_Alpha`use]:=
  Module[{outVars,outIndices,outMatrices,outEqs},
	 outVars=use1[[5]];
	 outIndices=Map[getIndexNames[sys,#] &,outVars];
	 outMatrices=Map[Alpha`matrix[1,Length[#]+1,#,{Append[Table[0,{i,1,Length[#]}],1]}] &,outIndices];
	 outTypes=Map[If[getDeclaration[#][[2]]===boolean,False,0] &,outVars];
	 outEqs=MapThread[Alpha`equation[#1,
	   Alpha`affine[Alpha`const[#3],#2]] &,{outVars,outMatrices,outTypes}]]



(*************  isReducibleQ check thereducibility of a program with
  respect to the notion introdcuced in PI "Structured Scheduling of
  R.E " **********************************************************)

Clear[isReducibleQ]

isReducibleQ[sys:_Alpha`system]:=
  Module[{res, deps,useDeps,normalDeps,curUseDep,curOutVars,curInVars,
	  curExtDom,nbExtIndices,oneOutVar,possibleDeps},
	 res=True;
	 deps=dep[sys];
	 useDeps=deps[[2]];
	 normalDeps=deps[[1]];
	 (* fir eacch use  *)
	 Do[curUseDep=useDeps[[i]];
	    curOutVars=curUseDep[[3]];
	    curInVars=curUseDep[[2]];
	    curExtDom=curUseDep[[5]];
	    nbExtIndices= curExtDom[[1]];
	    (* for each out var *)
	    Do [oneOutVar=curOutVars[[j]];
		(* for dependencies  "in  depends on out "
		   the dep  part is indentity *)
		possibleDeps=Select[normalDeps,
				    ((Part[#,3]===oneOutVar) && 
				     (MemberQ[curInVars,Part[#,2]]))  &];
		If [possibleDeps=!={},
		    If[!Apply[And,
			  Map[checkReducibilityDep[sys,#,curExtDom] &,
			      possibleDeps]],
		       res=False]]
	      ,{j,1,Length[curOutVars]}];
	   ,{i,1,Length[useDeps]}];
	 res]

Clear[checkReducibilityDep]

checkReducibilityDep[sys:_system,depLoc:_depend,curExtDom:_domain]:=
  Module[{lhsVar,rhsVar,nbLhsIndices,nbRhsIndices,idMatLoc,DepMat,
	  SelectDepMat},
	 lhsVar=depLoc[[2]];
	 rhsVar=depLoc[[3]];
	 nbLhsIndices=Length[getIndexNames[sys,lhsVar]];
	 nbRhsIndices=Length[getIndexNames[sys,rhsVar]];
	 If [nbLhsIndices =!= nbRhsIndices,
	     Print["Warning, input ", lhsVar ,
		   " do not have same index as output ",
		   rhsVar ," not checking reducibility here "]; 
	     Return[True],
	     DepMat=Part[depLoc,4,4];
	     SelectDepMat=Take[Map[
	       Function[x,Take[x,nbLhsIndices-curExtDom[[1]]]],DepMat],
			       nbLhsIndices-curExtDom[[1]]];
	     idMatLoc=IdentityMatrix[nbLhsIndices-curExtDom[[1]]];
	     idMatLoc===SelectDepMat]
       ]


(************* addBufferVars add buffers variable for input and output
  of a use, **********************************************************)

Clear[addBufferVars]
addBufferVars[]:=
  Module[{tempSys},
	 tempSys=addBufferVars[$result];
	 If [MatchQ[tempSys,_system],
	     $result=tempSys,
	     $result]]

addBufferVars[sys:_Alpha`system]:=
  Module[{eqs,useEqs,curSys},
	 eqs=sys[[6]];
	 useEqs=Select[eqs,Length[Position[#,use]]=!=0 &];
	 curSys=sys;
	 Do[curUse=useEqs[[i]];
	    curSys=addBufferVarsForUse[curSys,curUse],
	    {i,1,Length[useEqs]}];
	 curSys]


addBufferVars[___]:=addBufferVars::WrongArg

Clear[addBufferVarsForUse]
addBufferVarsForUse::usage="in test"

addBufferVarsForUse[curUse:_use]:=
  Module[{tempSys},
	 tempSys=  addBufferVarsForUse[$result,curUse];
	 If [MatchQ[tempSys,_system],
	     $result=tempSys,
	     $result]]

addBufferVarsForUse[sys:_system,curUse:_use]:=
  Module[{listInVars, curSys,curVar,curVarName,newVar,posUses,posUse,
	  localUse},
	 posUses=Position[sys,curUse];
	 If[posUses==={},Message[addBufferVarsForUse::UseNotFound];
	    Return[sys],
	    posUse=First[posUses]];
	 (* posUse is the position of the use equation in the AST *)
	 curSys=sys;
	 localUse=curUse;
	 listInVars=curUse[[4]];
	 Do[curVar= listInVars[[i]];
	    curVarPos=Join[posUse,{4,i}];
	    If [!MatchQ[curVar,var[_String]],
		Print["Warning, input to use of ",localUse[[1]]," is not
  a variable"];Return[sys],
		curVarName=curVar[[1]]];
	    newVar=getNewName[StringJoin[curVarName,"IN"]];
	    (* The addLocal MUST use the position here *)
	    curSys=addLocal[ curSys,newVar,curVarPos];
	    (* update the position of the use  in sys *)
	      localUse=localUse/.(curVarName->newVar);
	    posUses=Position[curSys,localUse];
	    If[posUses==={},Message[addBufferVarsForUse::UseNotFound];
	       Return[curSys],
	       posUse=First[posUses]]
	   ,{i,1,Length[ listInVars]}];
	 listOutVars=localUse[[5]];
	 Do[curVarName= listOutVars[[i]];
	    If [!MatchQ[curVarName,_String],
		Print["Warning, input to use of ",localUse[[1]]," is not
  a variable"];Return[sys]];
	    newVar=getNewName[StringJoin[curVarName,"OUT"]];
	    (* the addLocal uses  name (position doesn't work here *)
	      curSys=addLocal[ curSys, StringJoin[newVar,"=",curVarName]]
	    ,{i,1,Length[ listOutVars]}];
	 curSys]

addBufferVarsForUse[___]:=addBufferVarsForUse::WrongArg
	    


End[] 
EndPackage[]
