(* file: $MMALPHA/lib/Package/Schedule.m
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
BeginPackage["Alpha`Schedule`", {"Alpha`Domlib`",
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
				 "Alpha`SubSystems`",
				 "Alpha`ScheduleTools`",
				 "Alpha`VertexSchedule`",
				 "Alpha`FarkasSchedule`"}]

(* Standard head for CVS

   $Author: quinton $
   $Date: 2004/07/12 10:52:16 $
   $Source: /udd/alpha/CVS/alpha_beta/Mathematica/lib/Packages/Alpha/Schedule.m,v $
   $Revision: 1.70 $
   $Log: Schedule.m,v $
   Revision 1.70  2004/07/12 10:52:16  quinton
   Corrected a bug when $runTime is not set. Minor correction.

   Revision 1.69  2004/06/09 15:38:47  quinton
   Minor correction.

   Revision 1.68  2002/09/04 08:02:59  risset
   test for cvs

   Revision 1.67  2002/08/29 09:10:30  risset
   Corrected a small bug: the schedule[] function did not return any result (a ; badly placed)

   Revision 1.66  2001/10/29 16:37:45  quinton
   Minor corrections.

   Revision 1.65  2001/09/13 16:38:44  quinton
   Minor modifs

   Revision 1.63  2001/04/21 07:00:50  quinton
   Changed file format from windows to unix

   Revision 1.62  2001/04/21 05:19:10  quinton
   Minor corrections

   Revision 1.61  1999/12/10 16:59:03  risset
   commited struct Sched and ZDomlib

   Revision 1.60  1999/05/28 09:34:02  risset
   remove context Alpha of scheduleResult

   Revision 1.59  1999/05/18 16:24:28  risset
   change many packages for documentation

   Revision 1.58  1999/05/06 07:45:59  risset
   little bug of chjeckOptions

   Revision 1.57  1999/04/29 10:23:37  risset
    added a complete check of Farkasschedule

   Revision 1.56  1999/04/22 10:07:36  risset
   corrected some bug relative to the new options
   
   Revision 1.55  1999/04/19 15:06:08  risset
   corrected Options outputForm
	
   Revision 1.54  1999/04/02 08:15:17  risset
   added FarkasSchedule
   

   
   *)
 Schedule::usage =
  "Package.  Schedule for  alpha program The only function used is :
schedule[]"
  
 structSched::usage = "structSched[] try to find a structured
scheduling for $result, using $scheduleLibrary for schedule of
subsystems. The default mode is linear, i.e. no dimension is added for 
subsystems. By setting the option structSchedType to multi, the
schedule of the subsystems will be in an additionnal
dimension. Warning, in that case, you MUST set the depth of the
schedule expected with the multSchedDepth options. Example:
structSched[structSchedType->multi,multiSchedDepth->2]
finds the schedule of $result and puts"

 schedule::usage = "schedule[] finds the schedule of $result and puts
the result in $schedule. schedule[sys_Alpha`system], finds the
schedule of alpha system `sys' and puts the result in $schedule
(affine by variable by default).  schedule[sys_Alpha`system, options]
calls schedule with non default options. Options[schedule] provides
  the options of schedule, and ?opt1 provides information on option
  opt1.  ?$schedule provides info on the output format of the schedule.
  The schedule computation may take a long time 
  (2 minutes for 20 instructions). More information is available in the file
  $MMALPHA/doc/user/²Scheduler_user_manual.ps."

checkOptions::usage="checkOption[sys_Alpha`system,options___Rule]
check that the set of option of schedule is coherent, returned a new
set of option in which some option have been changed by default to
cope with incoherent options if possible"

checkOptions::wrongOptionsValue= "Unknown options value for schedule: `1`"
checkOptions::sameLinPartImpossible = "Using the samelinearPart
  options, all the local variables of the system must have the same
  number of indices"
checkOptions::NotImplInFarkas= "Sorry, value `1` of option is not
  implemented in Faraks method, try schedMethod->vertex"

benchSched::usage = 
"benchSched[f] runs the scheduler on alpha file f, or on 
list of alpha files f.";
Options[ benchSched ] = 
{ verbose->False, debug -> False, scheduleType -> farkas, outputFile -> Null };

farkas::usage = "option of benchSched";
vertex::usage = "option of benchSched";

Begin["`Private`"] 

Clear[runSched];
(* This local function calls the simple scheduler, 
 and returns a list containing the name, the number
 of variables, of constraints, the time needed, and 
 a flag S of F *)

runSched[ opts:___Rule ] :=
Module[{res,vrb,dbg,schedT,opt1},
  schedT = scheduleType/.{opts}/.Options[benchSched];
  opt1 = Select[ {opts}, !MatchQ[ #, scheduleType -> _ ]& ];
  opt1 = Select[ opt1, !MatchQ[ #, outputFile -> _ ]& ];
  Check[
    If[ schedT === farkas, 
      Apply[ schedule, opt1 ]; res = $runTime,
      Apply[ scd, opt1 ]; res = $runTime, 
    ],
    Throw[ Message[ benchSched::errsched ] ]
  ];
  res
];

Clear[runStructSched];
(* This local function calls the simple scheduler, 
   and returns a list of the form 
   { systemName, etc... *)
runStructSched[  opts:___Rule ] :=
Module[{res,vrb,dbg,schedT,opt1},
  schedT = scheduleType/.{opts}/.Options[benchSched];
  opt1 = Select[ {opts}, !MatchQ[ #, scheduleType -> _ ]& ];
  opt1 = Select[ opt1, !MatchQ[ #, outputFile -> _ ]& ];
  Check[
    If[ schedT === farkas, 
      Apply[ structSched, opt1 ]; res = $runTime,
      Apply[ scd, opt1 ]; res = $runTime 
    ],
    Throw[ Message[ benchSched::errstructsched ] ]
  ];
  res
];
runStructSched[ ___ ] := Message[ runStructSched::params ];

Clear[benchSched];
benchSched::pb = "Problem 1"; 
benchSched::filenotfound = "Could not find file '1'"; 
benchSched::errstructsched = "Error while calling the structured scheduler"; 
benchSched::errsched = "Error while calling the scheduler"; 
benchSched[listeFiles: {__String}, verb:___Rule] :=
  Map[ benchSched[ #, verb]&,  listeFiles];
benchSched[fileN : _String, verb : ___Rule] :=
  Catch[
    Module[{sys1, result, vrb, dbg, names, fn },
      vrb = verbose/.{verb}/.Options[benchSched];
      dbg = debug/.{verb}/.Options[benchSched];
      fn = outputFile/.{verb}/.Options[benchSched];

      If[ dbg, Print[ "loading file" ] ];
      Check[
        If[ vrb, Print["************* loading ", fileN, " ********\n"] ];
        (* load file, and get last file *)
        load[fileN], 
        Throw[Message[ benchSched::filenotFound, fileN ] ]
      ];

      (* If there are uses, inline and compute structured schedule *)
      If[ Cases[$result, use[___], Infinity] =!= {},

        If[ vrb, Print["--- Structured scheduling"] ];

        If[ vrb, Print["  --- Scheduling subsystems "] ];
          (* This is done recursively *)
          names = systemNames[];

          result = 
          Map[
            (
             getSystem[#];
             If[Cases[#, use[___], Infinity] =!= {},
             runStructSched[ verb ],
             runSched[ verb ]])&, 
	     Drop[ names, -1 ]
          ];
          If[ dbg, Print[ result ] ];

          If[ vrb, Print[" -- Scheduling main system (", Last[names], 
                ")"] 
          ];

          getSystem[ names[[-1]] ];
          result = Append[ result, runStructSched[ verb ] ];

          If[ vrb, Print["  -- Schedule flat program"] ];
          removeIdEqus[inlineAll[{verb}]];
          result =  
            Append[ result, runSched[ verb] ];
          If[ MatchQ[fn,_String],
            fn = fn<>".bench";
            If[ FileInformation[ fn ], DeleteFile[ fn ] ];
            Put[ result, fn ];
            Print[ "Schedule was saved in file ", fn ];
          ];
          result,

        (* if no uses, schedule anyway *)
        result = runSched[ verb ];
        If[ MatchQ[fn,_String],
          fn = fn<>".bench";
          If[ FileInformation[ fn ], DeleteFile[ fn ] ];
          Put[ result, fn ];
          Print[ "Schedule was saved in file ", fn ];
        ];
        result
      ]
    ]
  ];
        	
benchSched::wrongArg = "wrong Argument for function benchSched : `1`";
benchSched[a : ___] := Message[benchSched::wrongArg, Map[Head, {a}]]

Clear[schedule];
Options[schedule] := 
  {debug -> False,
   verbose -> True,
   schedMethod->farkas,
   scheduleType->affineByVar,
   multiDimensional->False,
   optimizationType->time,
   objFunction->lexicographic,
   addConstraints->{},
   durations->{},
   durationByEq->True,
   checkSched->{},
   onlyVar -> all,
   givenSchedVect ->{},
   onlyDep -> all,
   integerSolution->True,
   outputForm->scheduleResult,
   multiSchedDepth->1,
   subSystems->False,
   resolutionSoft->pip,
   subSystemSchedule->$scheduleLibrary
};

schedule[options___Rule] := 
  Module[
    {tempRes,optMultiDimensional},
    tempRes=Catch[schedule[$result, options]];
    If[ MatchQ[tempRes,scheduleResult[___]],
    $schedule=tempRes;
    tempRes,
    tempRes]
  ];

schedule::ObsoleteSyntax = "Warning, you are using an obsolete syntax
for the options mechanism of schedule, in the right mechanism you just
set the rules for options as aditionnal parameters to the function,
example: schedule[$result,debug->True]";

Options[schedule] := Options[farkasSchedule];

schedule[{options___Rule}]:=
  Module[{},
	 Message[schedule::ObsoleteSyntax];
	 schedule[options]];

schedule[sys0:Alpha`system[___], {options___Rule}]:=
  Module[{},
	 Message[schedule::ObsoleteSyntax];
	 schedule[sys0,options]];

schedule[sys0:Alpha`system[___], options___Rule]:=
  Catch[
    Module[{optSchedMethod,optMultiDimensional,newOptionsList,res},

      (* new options take several rules as input and return a list
         of rules *) 
      newOptionsList = checkOptions[sys0,options];

      optSchedMethod=schedMethod/.newOptionsList/.Options[schedule];
      optMultiDimensional=multiDimensional/.newOptionsList/.Options[schedule];

      Which[
        optSchedMethod===farkas,
        If [optMultiDimensional,
          res=Catch[multiSched[sys0,options]],
          res=Catch[farkasSchedule[sys0,options]]],

        optSchedMethod===vertex,res=Catch[scd[sys0,options]],

        True,Message[schedule::WrongOptionValue,optSchedMethod]
      ]; (* Which *)

      If [MatchQ[$schedule,_scheduleResult],
        If [!MatchQ[$scheduleLibrary,_List],
          $scheduleLibrary={$schedule},
          $scheduleLibrary=Append[DeleteCases[$scheduleLibrary,
                                                     scheduleResult[
                                                         $schedule[[1]],
                                                          ___]],
                                         $schedule]
        ]
      ];
      (* This global variable contains information 
       regarding the execution of the scheduler *)
      (* Done July 10, 2004, PQ, to avoid a bug when $runTime is not
         set. Would be better to identify the origin of the bug... *)
      If[ !MatchQ[ $runTime, _List ], 
        Print["Warning: $runTime was set to {}"];$runTime = {}
      ];
      $runTime = Append[ $runTime, "Flat" ];
      If[ MatchQ[ res, scheduleResult[___] ], 
        $runTime = Append[ $runTime, Last[ res ] ] ];
      res
    ]
  ];



(*** structSched: structured scheduling ****)
Clear[structSchedule];

structSched[options___Rule] := 
Module[{tempRes,optMultiDimensional},
  tempRes=Catch[structSched[$result, options]];
  If [MatchQ[tempRes,scheduleResult[___]],
    $schedule=tempRes;
    tempRes,
    tempRes]
];

Options[structSched] := 
  {debug -> False,
   schedMethod->farkas,
   structSchedType->mono,
   addConstraints->{},
   durations->{},
   durationByEq->True,
   multiSchedDepth->1,
   subSystems->True,
   subSystemSchedule->$scheduleLibrary
  };

structSched[sys0:_system, options___Rule]:=
Catch[
  Module[{optSchedMethod,optStructSchedType,optAddConstraints,
    optMultSchedDepth,optDebug,addeConstraints,opt},

    (* Get options *)
    optSubSystemSchedule=
		subSystemSchedule/.{options}/.Options[structSched];
    optDebug=
		debug/.{options}/.Options[structSched];
    optAddConstraints=
		addConstraints/.{options}/.Options[structSched];
    optMultiSchedDepth=
		multiSchedDepth/.{options}/.Options[structSched];
    optSchedMethod=
		schedMethod/.{options}/.Options[structSched];
    optStructSchedType=
		structSchedType/.{options}/.Options[structSched];

    addedConstraints = 
      buildSchedConstraints[
        sys0,
        multiSchedDepth -> optMultiSchedDepth,
        structSchedType -> optStructSchedType,
        subSystemSchedule -> optSubSystemSchedule, options ];

    If[ optDebug, Print["built constraints:\n",addedConstraints] ];

    (* ====================  This modification in temporary... *)
    (*
    addedConstraints = Complement[ addedConstraints, {"TAD1==0","TBD1==0"}];
     *)
    If[ optDebug, 
      Print["builded constraints:\n", FullForm[addedConstraints]] ];

    If[ optStructSchedType===mono,
      optAddConstraints =
        Join[optAddConstraints,addedConstraints],

      Which[
        Length[optAddConstraints]===0,
        optAddConstraints=addedConstraints,

        Length[optAddConstraints]===Length[addedConstraints],
        optAddConstraints= MapThread[Join,{optAddConstraints,
					   addedConstraints}],
        True, Print["structSched: Sorry, the addedConstraints"<>
                    " should be a list of length ",
                    Length[addedConstraints]];Throw["ERROR"];];
      ];

      Which[
        optSchedMethod===farkas,
        If [ optStructSchedType=!=mono,
          res = 
            Catch[schedule[sys0,
                  subSystems->True,
                  addConstraints->optAddConstraints,
                  multiDimensional->True,
                  options]],
          res =
            Catch[schedule[sys0,
                  subSystems->True,
                  addConstraints->optAddConstraints,
                  multiDimensional->False,
                  options]]],

        optSchedMethod===vertex,
          Message[structSched::WrongOptionValue,optSchedMethod],
        True,
          Message[structSched::WrongOptionValue,optSchedMethod]
      ];

      If [MatchQ[$schedule,_scheduleResult],
        If [!MatchQ[$scheduleLibrary,_List],
          $scheduleLibrary={$schedule},
          $scheduleLibrary = 
            Append[DeleteCases[
                     $scheduleLibrary, 
                     scheduleResult[ $schedule[[1]], ___]],
              $schedule]
        ]
       ];

      (* Set $runTime *)
      $runTime = $runTime /. "Flat" -> "Structured";
      If[ MatchQ[ res, scheduleResult[___] ], 
        $runTime = Append[ $runTime, Last[ res ] ] ];
      res
  ]
];

Clear[checkOptions]

checkOptions[options___Rule]:=
  checkOptions[$result,options]

checkOptions[sys_Alpha`system,
	    options___Rule]:=
  Module[{optDebug,optVerbose,optResolutionSoft,
	  optRatOrInt,optAddConstraints,
	  optDurations,optCheckSched,optScheduleType,optObjFunction,
	  optOnlyVar,optGivenSchedVect,
	  optOnlyDep,optOutputForm,optionList,
	  optDurationByEq,optSchedMethod,
	  optMultiSchedDepth,optMultiDimensional,
          listNumIndices,newOptions},
	 optDebug = debug/.{options}/.Options[schedule];
	 optVerbose= verbose/.{options}/.Options[schedule];
	 optResolutionSoft= resolutionSoft/.{options}/.Options[schedule];
	 optRatOrInt = integerSolution/.{options}/.Options[schedule];
	 optAddConstraints = addConstraints/.{options}/.Options[schedule];
	 optDurations=durations/.{options}/.Options[schedule];
	 optCheckSched=checkSched/.{options}/.Options[schedule];
	 optScheduleType=scheduleType/.{options}/.Options[schedule];
	 optOptimizationType=optimizationType/.{options}/.Options[schedule];
	 optOnlyVar=onlyVar/.{options}/.Options[schedule];
	 optGivenSchedVect=givenSchedVect/.{options}/.{givenSchedVect ->{}};
	 optOnlyDep=onlyDep/.{options}/.Options[schedule];
	 optOutputForm=outputForm/.{options}/.Options[schedule];
	 optDurationByEq=durationByEq/.{options}/.Options[schedule];
	 optSchedMethod=schedMethod/.{options}/.Options[schedule];
	 optMultiSchedDepth=multiSchedDepth/.{options}/.Options[schedule];
	 optObjFunction=objFunction/.{options}/.Options[schedule];
	 optMultiDimensional=multiDimensional/.{options}/.Options[schedule];
	 
        newOptions={options};
	    If [optVerbose,Print["Checking options..."];];
          (* No Checks actaully... just for confidence *)

          (*** Options schedMethod  ****)
             If [!MemberQ[{vertex,farkas},optSchedMethod],
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
                 Message[checkOptions::wrongOptionsValue,optMultiDimensional];
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
                 Message[checkOptions::wrongOptionsValue,optOptimizationType];
                 Throw[$Failed]]; 

	     (*** Options optAddConstraints  ****)
             If [!MatchQ[optAddConstraints,List[___String]|List[___List]],
                 Message[checkOptions::wrongOptionsValue,optAddConstraints];
                 Throw[$Failed]]; 

             (*** Options optDurations ****)
             If [!MatchQ[optDurations,List[___Integer]|List[___List]],
                 Message[checkOptions::wrongOptionsValue,optDurations];
                 Throw[$Failed]]; 
             (* The check is done in the scheduling process  *)

             (*** Options optOutputForm ****)
             If [!MemberQ[{scheduleResult,lpSolve,lpMMA,domain},
                  optOutputForm],
                 Message[checkOptions::wrongOptionsValue,optOutputForm];
                 Throw[$Failed]]; 

             (*** Options optResolutionSoft ****)
             If [!MemberQ[{pip,mma,lpSolve},optResolutionSoft],
                 Message[checkOptions::wrongOptionsValue,optOutputForm];
                 Throw[$Failed]]; 

             (*** Options optObjFunction ****)
                (*  No Check Here *)
             If [!MatchQ[optObjFunction,_],
                 Message[checkOptions::wrongOptionsValue,optObjFunction];
                 Throw[$Failed]]; 

            (**** Options optOnlyVar ****) 
            If [!MatchQ[optOnlyVar,List[___String]|List[___List]|all],
                 Message[checkOptions::wrongOptionsValue,optOnlyVar];
                 Throw[$Failed]]; 

            (**** Options optOnlyDep ****) 
            If [!MatchQ[optOnlyDep,List[___Integer]|List[___List]|all],
                 Message[checkOptions::wrongOptionsValue,optOnlyDep];
                 Throw[$Failed]]; 

            (* special test for Farkas method *)
            If [optSchedMethod===farkas,
                If [!MatchQ[optObjFunction,lexicographic],
                     Message[checkOptions::NotImplInFarkas,optObjFunction];
                     Throw[$Failed]];
                If [optSubSystems,
                     Message[checkOptions::NotImplInFarkas,SubSystems];
                     Throw[$Failed]]];

newOptions
	    ]

checkOptions[a___]:=(Message[checkOptions::WrongArg,a];
				Throw["ERROR"])

		 
End[] 
EndPackage[]


