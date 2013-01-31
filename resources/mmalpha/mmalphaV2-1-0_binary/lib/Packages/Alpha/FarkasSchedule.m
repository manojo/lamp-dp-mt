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
BeginPackage["Alpha`FarkasSchedule`", {"Alpha`Domlib`",
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
				 "Alpha`ScheduleTools`" }]

(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:36 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/FarkasSchedule.m,v $
	$Revision: 1.9 $
	$Log: FarkasSchedule.m,v $
	Revision 1.9  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.8  2008/12/29 17:35:00  quinton
	Minor edition corrections.
	
	Revision 1.7  2008/12/21 13:34:02  quinton
	Minor edition changes.
	
	Revision 1.6  2008/04/25 16:40:18  quinton
	Added a mute option, when True, absolutely no messages.
	
	Revision 1.5  2008/04/18 16:55:24  quinton
	Forgotten correction...
	
	Revision 1.3  2005/07/11 17:32:16  quinton
	Modified version for Mac OS X
	
	Revision 1.2  2005/03/14 12:37:20  trisset
	 corrected the bug I introduced in FArkasSchedule.m
	
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.26  2004/07/12 10:55:20  quinton
	Corrected a bug in $runTime
	
	Revision 1.25  2004/06/09 15:29:35  quinton
	Minor corrections.
	
	Revision 1.24  2003/07/02 08:25:48  risset
	accepting call in a2v
	
	Revision 1.23  2003/04/28 14:43:22  quinton
	Typo corrections.
	
	Revision 1.22  2003/04/15 15:04:52  risset
	commit after Axiocom week
	
	Revision 1.21  2003/01/07 17:19:05  quinton
	Minor correction in the analysis of additional constraints
	
	Revision 1.20  2002/09/12 14:47:21  risset
	commit after patrice update and correction of Pipecontrol
	
	Revision 1.19  2002/05/28 15:56:21  quinton
	Minor corrections.
	
	Revision 1.18  2001/09/14 14:20:20  quinton
	Modification of the $runTime variable value
	
	Revision 1.16  2001/08/23 15:23:20  risset
	*** empty log message ***
	
	Revision 1.15  2001/08/23 14:03:38  risset
	merged with Patrice version
	
	Revision 1.14  2000/11/13 09:44:32  risset
	added Pip timing
	
	Revision 1.13  2000/02/14 08:25:19  risset
	correct a bug in DomEqulities
	
	Revision 1.12  1999/12/10 16:59:03  risset
	commited struct Sched and ZDomlib
	
	Revision 1.11  1999/11/15 17:09:22  risset
	added buildSchedConstraints
	
	Revision 1.10  1999/07/30 09:49:08  risset
	commited V1.0.0
	
	Revision 1.9  1999/05/28 09:30:04  risset
	remove context Alpha of scheduleResult
	
	Revision 1.8  1999/05/19 07:29:49  risset
	Few things
	
	Revision 1.7  1999/05/18 16:24:25  risset
	change many packages for documentation
	
	Revision 1.6  1999/05/06 12:08:49  risset
	corrected isSpaceSepQ
	
	Revision 1.5  1999/04/29 10:23:38  risset
	 added a complete check of Farkasschedule
	
	Revision 1.4  1999/04/22 10:07:37  risset
	corrected some bug relative to the new options
	
	Revision 1.3  1999/04/19 15:06:07  risset
	corrected Options outputForm
	
	Revision 1.2  1999/04/02 08:26:47  risset
	added FarkasSchedule
	
	Revision 1.1  1999/04/02 08:15:15  risset
	added FarkasSchedule
	
	Revision 1.53  1999/03/17 15:08:30  risset
	add changes for compatibility with WindowsNT version
	
	Revision 1.52  1999/03/02 15:49:25  risset
	added GNU software text in each packages
	
	Revision 1.51  1998/11/27 12:20:18  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.50  1998/06/03 14:49:01  risset
	change duration option

	Revision 1.49  1998/05/04 11:46:34  risset
	commited tag v0-9-1

	Revision 1.48  1998/04/23 07:38:44  risset
	l

	Revision 1.47  1998/03/12 11:28:47  risset
	Schedule.m

	Revision 1.46  1998/03/12 10:00:02  risset
	added addConstraints for multiDim sched

	Revision 1.45  1998/03/11 09:02:39  risset
	a

	Revision 1.44  1998/02/19 08:24:41  risset
	modifed ToAlpha0v2.m

	Revision 1.43  1998/02/16 17:07:00  risset
	Packages pass all tests

	Revision 1.42  1998/02/10 10:37:22  risset
	corrected Schedule.m

	Revision 1.41  1997/11/07 13:52:20  risset
	corrected debug

	Revision 1.40  1997/11/05 16:17:38  risset
	 added a debug option for stefan

	Revision 1.39  1997/10/14 13:49:36  risset
	added test for reduce and use

	Revision 1.38  1997/09/29 15:28:31  risset
	changed mppip to pip

	Revision 1.37  1997/09/12 11:54:04  risset
	added things

	Revision 1.36  1997/06/26 14:11:50  risset
	commited Alphard.m v1

	Revision 1.35  1997/06/06 14:57:28  risset
	 put back the eliminatesDoubles -> False

	Revision 1.34  1997/06/03 12:56:21  risset
	set the eliminateDoubles option in the dep[] used in schedule and MultiDim

	Revision 1.33  1997/05/22 14:43:31  risset
	corrected messages

	Revision 1.32  1997/05/19 10:41:26  risset
	corrected exported bug in depedancies

	Revision 1.31  1997/05/13 12:29:35  alpha
	 little things

	Revision 1.30  1997/05/13 11:09:22  risset
	slkdj
	Revision 1.29  1997/04/24 15:20:21  risset
	corrected a little bug of readOneConstr

	Revision 1.28  1997/04/22 07:54:44  risset
	Added multiDim Scheduling

	Revision 1.27  1997/04/16 15:29:27  risset
	corrected the addConstraints syntax

	Revision 1.26  1997/04/10 15:10:50  risset
	added Options.m ScheduleTools.m OldSchedule.m remove scheduleFarkas.m

	Revision 1.3  1997/04/10 09:19:35  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.2  1997/04/08 13:05:31  risset
	 tanguy s changes

	Revision 1.1  1997/04/07 15:05:26  risset
	Added scheduleFarkas.m
	

*)
FarkasSchedule::usage =
  "Package.  Schedule for  alpha program with Farkas method, 
 These function should be used through the schedule[] interface
(Package Schedule.m)"



farkasSchedule::usage=
"(+) farkasSchedule[sys_Alpha`system], finds the schedule of alpha system
<sys>. farkasSchedule[] finds the schedule of $result and puts the result in
$schedule.  farkasSchedule[sys_Alpha`system, {options}] calls farkasSchedule with
non default options. Options[farkasSchedule] provides the options of
schedule, and ?option provides information on option.  ?$schedule
provides info on output formats of farkasSchedule).  By default, the
  schedule is affine by variable The schedule computation may take a
long time (2 minutes for 10 instructions). More information is
available in the file $MMALPHA/doc/user/Scheduler_user_manual.ps.";

multiSched::usage = "(+) multiSched[sys_Alpha`system], finds a
multiDimensionnal schedule alpha system <sys> using the farkasSchedule
scheduling function at each dimension. multiSched[] finds the
schedule of $result and puts the result in $schedule.
multiSched[sys_Alpha`system, {options}] calls schedule with non
default options. Options[multiSched] provides the options of schedule,
and ?option provides information on option.  See also:
applySchedule. "




farkasSchedule::NoReduce= " Sorry, I cannot schedule a system with a
reduction, please serialize the reduction before."
farkasSchedule::NoUse= " Sorry, I cannot schedule a system with a
use of another system, please inline it before."
farkasSchedule::PbInTotalTime="Problem when computing total time of schedule"
farkasSchedule::nonUnifProg = " The programme scheduled is not uniform "
farkasSchedule::WrongArg = " Wrong argument for farkasSchedule, `1`, schedule aborted"
splitListDep::WrongArg = " Wrong argument for splitListDep `1`, fatal
  error"
printSplittedDepList::WrongPar = " Wrong argument for
  printSplitListDep `1`"
printOneDepListe::WrongPar = " Wrong argument for
 printOneDepListe  `1`"
makeRefline::WrongArg = " Wrong argument for makeRefline `1`, fatal
  error"
makeRefline::UnknownOption = "Wrong value for the objFunction option"
getNumberFarkasCoef::nonConvex = " Non convex domain encountered
  (domain should have been convexized), taking first polyhedron as
  total domain"
getNumberFarkasCoef::WrongPar= " Wrong argument for getNumberFarkasCoef `1`, fatal
  error"
buildDuration::NotImplemented = " This duration is not implemented
  yet, please choose another one (duration -> 0 for instance), fatal error"
buildDuration::WrongSize = " Wrong size for the duration list: the
  list should contains `1` values, fatal error "
buildDuration::UnrecognizedValue = " Unknown value for duration
 option: `1`, fatal error"
buildDuration::WrongArg = " Wrong argument for buildDuration : `1`, fatal
  error"
makeTableEq::WrongPar = "  Wrong argument for makeTableEq `1`, fatal
  error"
makeTableEq::unknownOptionValue = "wrong value for the objFunction option:`1`"
getRelativeNum::M1=" number of instruction not found: `1` fatal
  error"
getRelativeNum::NumNotFound=" number is duration is not implemented
  yet, please choose another one (durations -> {} for instance), fatal error"
buildDuration::WrongSize = " Wrong size for the duration list: the
  list should contains `1` values, fatal error "
buildDuration::UnrecognizedValue = " Unknown value for durations
 option: `1`, fatal error"
buildDuration::WrongArg = " Wrong argument for buildDuration : `1`, fatal
  error"
makeTableEq::WrongPar = "  Wrong argument for makeTableEq `1`, fatal
  error"
makeTableEq::unknownOptionValue = "wrong value for the objFunction option:`1`"
getRelativeNum::M1=" number of instruction not found: `1` fatal
  error"
getRelativeNum::NumNotFound=" number of instruction ot found: `1`fatal
  error"
getRelativeNum::NameNotFound="variable not found: `1` fatal
  error"
getRelativeNum::WrongArg = "  Wrong argument for getRelativeNum `1`, fatal
  error"
makePositivityConstraint::M1 = " Internal Error when building
  positivity constraints: fatal error" 
makePositivityConstraint::WrongArg =  "  Wrong argument for     
  makePositivityConstraint `1`, fatal  error"
makeObjFunctionConstraint::LocalVAr = " The  objective function
  should not be set for local Variables " 
makeObjFunctionConstraint::InputVAr = " The  objective function
  should not be set for input Variables " 
makeObjFunctionConstraint::M1 =  " Internal Error when building
  positivity constraints: fatal error" 
makeObjFunctionConstraint::WrongArg =  "  Wrong argument for makeTableEq `1`, fatal error"
makeNumDepSplitted::Pb1 = "internal problem when manipulating
 dependancies: fatal error" 
makeNumDepSplitted::WrongArg = "  Wrong argument for
 makeNumDepSplitted: `1`, fatal error"
makeDepConstraint::pb2 = "Internal error: no source var for
  dependancy, fatal error " 
makeDepConstraint::pb3= "Internal error: no goal var for
  dependancy, fatal error " 
makeDepConstraint::pb4= "Internal error in setting epsilon in dep
 fatal error "
makeDepConstraint::M1 = " Internal Error when building
 dependence constraints: fatal error" 
makeDepConstraint::M2 = " Internal Error when building
 dependence constraints: fatal error" 
makeDepConstraint::Pb1 =  " Internal Error when building
 dependence constraints: fatal error" 
makeDepConstraint::Pb1bis = " Internal Error when building
 dependence constraints: fatal error" 
makeDepConstraint::WrongArg = 
"  Wrong argument for makeDepConstraint : `1`, fatal error"
addConstSchedType::WrongArg =  "  Wrong argument for
  makeDepConstraint : `1`, fatal error"
checkLine::err1 = " internal error: line has wong structure "
checkLine::err2 = " internal error: line has wong structure "
checkLine::err3 = " internal error: line has wong structure "
checkLine::err4 = " internal error: line has wong structure "
checkLine::err5 = " internal error: line has wong structure "
checkLine::err6 = " internal error: line has wong structure "
checkLine::err7 = " internal error: line has wong structure "
checkLine::err8 = " internal error: line has wong structure "
checkLine::err9 = " internal error: line has wong structure "
checkLine::err10 = " internal error: line has wong structure "
checkLine::err11 = " internal error: line has wong structure "
checkLine::err12 = " internal error: line has wong structure "
checkLine::err13 = " internal error: line has wong structure "
checkLine::err14 = " internal error: line has wong structure "
checkLine::WrongArg = "  Wrong argument for makeDepConstraint : `1`"
fichierPip::WrongArg = "  Wrong argument for fichierPip :
  `1`, fatal error "
matPipOneEq::WrongArg = "  Wrong argument for matPipOneEq :
  `1`, fatal error "
writeFile::WrongArg= "  Wrong argument for writeFile :
  `1`, fatal error "
testeqIneq::WrongArg = "  Wrong argument for testeqIneq :
  `1`, fatal error "
writemat::WrongArg =  "  Wrong argument for writemat :
  `1`, fatal error "
writematOneLine::WrongArg  =  "  Wrong argument for writematOneLine :
  `1`, fatal error "
readPipResult::newparmEncoutered =
 "pip could not solve this problem with integral 
solution, please try again with option ratOrInt->0, fatal error"
printAllTau::err1 = " Internal Error when printing result" 
printAllTau::WrongArg = " Wrong parameter in printAllTau `1`"
 printOneTau::WrongArg = " Wrong parameter in printOnTau `1`"
getFinalForm::WrongArg =  " Wrong parameter in getFinalForm `1`"
getOneVarFinalSched::WrongArg =  " Wrong parameter in
 getOneVarFinalSched :  `1`"
printAllConstraint::WrongArg = " Wrong parameter in printAllConstraint `1`"
printOneConstraint::tableStructPb1 = "internal error in printOneConstraint"
printOneConstraint::tableStructPb2 ="internal error in
  printOneConstraint"
printOneConstraint::tableStructPb2bis =  "internal error in
  printOneConstraint"
printOneConstraint::tableStructPb3 = "internal error in
  printOneConstraint"
printOneConstraint::tableStructPb4= "internal error in
  printOneConstraint"
printOneConstraint::WrongArg = " Wrong parameter in
printOneConstraint :  `1`"
readOneConstr::WrongSyntax1 = " Wrong syntax for added
 constraints: No closing brackets encountered in `1`, constraint forgotten" 
readOneConstr::WrongVarName = " Wrong syntax for added
 constraints: unrecognized variable: `1`, constraint forgotten" 
readOneConstr::WrongVarName2 = " Wrong syntax for added
 constraints: unrecognized variable number: `1`, constraint forgotten" 
readOneConstr::PbInExpr = " Problem when reading added
 constraint: the constant part is not integral: `1`, constraint
  forgotten "
readOneConstr::WrongArg= " Wrong parameter in `1`, no constraints added "

readOneConstr::IncompatibleOptions= 
"There is incompatibility between the fact that the schedule is given 
and the fact that you want to impose one of its coefficient on variable `1`, 
added constraints forgotten";

readOneConstr::wrongSyntax1 = " Sorry, the syntax of the constraint
must constain the \"]=\" String (and not \"]  =\")";

readOneConstr::Underscore = " Sorry, I cannot add constraints if the name of the variable (`1`) contains two or more underscores "
modifyLine::WrongVarName1 =  "Error when adding
 constraints: unrecognized variable number: `1`, fatal error " 
modifyLine::IncompatibleOptions=" There is incompatibility between
  the fact that the schedule is given and the fact that you want to
  impose one of its coefficient on variable `1`, added constraints forgotten"
modifyLine::WrongArg = "Parameter Error in ModifyLine: `1`"
modifyLine::WrongExpr  = "Unrecognized expression: `1`"
modifyLine::WrongVarName2 =  "Error when adding
 constraints: unrecognized variable number: `1`, fatal error " 
modifyLine::WrongVarName2 =  "Error when adding
 constraints: unrecognized variable number: `1`, fatal error " 
modifyLine::WrongDim =  "Error when adding
 constraints: fatal error" 
modifyLine::WrongVar = "Error when adding
 constraints: unrecognized variable number: `1`, fatal error "
modifyLine::WrongSymbol	=  "Unrecognized added constraints: unrecognized
  symbol: `1`"
reorderSchedResult::Pb1 = "strange things  happen when writing
  file for pip "
convexiseDom::Pb = " could not convexise domain: result is : `1`,
fatal error"
convexiseDom::WrongArg =  " Wrong parameter in
convexiseDom :  `1`, fatal error "

convexiseSplittedDep::WrongArg =  " Wrong parameter in
convexiseSplittedDep :  `1`, fatal error "
getNewListDep::WrongArg = " Wrong parameter in
getNewListDep :  `1`, fatal error "
getNewListDep::WrongDepNumber = " dependance number `1` does not
  exist, cannot take it into account"
getNewListDep::WrongValueForOnlyDep = "Wrong value for the onlyDep
  option, taking all deps into account"

Begin["`Private`"] 


(************************************************************************

                      * * * *    S C H E D U L E   * * * *
		      
************************************************************************

In this packages, shedule are linear by variable hence we don not 
set several schedule function of a single variable.

In the following of the listing, it should be clear what 
we call equation and instruction. The following statement:

      A = case 
         D1 : expr1
	 D2 : expr2
	 esac

is an EQUATION (which can be represented by A) 
which contains two INSTRUCTIONS (implicitely
A=D1:expr1 and A=D2:expr2

at the higher level of function,the  data structure used 
in the program are <sched>, <schedDom> and <tableDep>. We
briefly describe them here.

             <sched> == {<schedDom>,<tableDep>}

             <schedDom> == schedDomain[<instr_list>]
             <instr> == {"NomVar", <domSched_list>}
             <domSched> ==> {numinstr, nbparam, positivar_list, 
   	                paramList, <domain>}

             <tableDep> == dtable[<dep_list>]    
             <dep> == depend[dom, lhsvr, rhsvar, mat]    
************************************************************************)


(************************************************************************
**  farkasSchedule[sys_Alpha system,options]
**  Take an Alpha`system and an option 
**  
**   
**  Return the schedule , print the resulting schedule to
**  the screen.
************************************************************************)

Options[farkasSchedule] := {debug -> False,
  		         verbose -> True,
                         mute -> False,
		         resolutionSoft->pip,
		         integerSolution->True,
		         addConstraints->{},
		         durations->{},
		         durationByEq->True,
		         checkSched->{},
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
			    timeFile->Null
			 };

Clear[farkasSchedule];

farkasSchedule::Failed= "no schedule could be found"

farkasSchedule[{options___Rule}] := 
  Module[{},
	 Message[schedule::ObsoleteSyntax];
         farkasSchedule[options]]

farkasSchedule[options___Rule] := 
  Module[{tempRes},
	 tempRes=Check[farkasSchedule[$result, options],$Failed];
	 If [MatchQ[tempRes,scheduleResult[___]],
	     $schedule=tempRes;
	     tempRes,
	     Message[farkasSchedule::Failed];
	     $Failed]];


farkasSchedule[sys0:Alpha`system[___], {options___Rule}]:=
  Module[{},
	 Message[schedule::ObsoleteSyntax];
         farkasSchedule[sys0,options]];


farkasSchedule[sys0:Alpha`system[___], options___Rule]:=
Catch[
Module[{error,optDebug,optVerbose,optResolutionSoft,
	optRatOrInt,optAddConstraints,
       optDuration,optCheckSched,optScheduleType,optObjFunction,
	optOnlyVar,optGivenSchedVect,
	optOnlyDep,optOutputForm,optionList,
	optDurationByEq,optSchedMethod,optMultiSchedDepth,optMultiDimensional,
	optSubSystems,optSubSystemSchedule,
     sys,uniformQ,paramSpace,
	inputDomains,outputDomains,localDomains,listInputVars,listOutputVars,
	   newOnlyVar,listLocalVars,listDep,splittedListDep, refline,
	 duration1,structTableEq,result,nbVar,nbConstr,nbKbytes,
	numInstrVar,numDepSplitted,
	structAddedEq,addedConstraints,paramCoef,phiCoefs,
	paramVect,time1,dimNumber,tempFile1,temptempFile1, optMute},

   
  (***************    setting of  the options ***************)
  error=0;
  optPerf = timeFile/.{options}/.Options[farkasSchedule];
  optDebug = debug/.{options}/.Options[farkasSchedule];
  optVerbose= verbose/.{options}/.Options[farkasSchedule];
  optMute= mute/.{options}/.Options[farkasSchedule];
  If[ optMute, optVerbose = False ];
  optResolutionSoft= resolutionSoft/.{options}/.Options[farkasSchedule];
  optRatOrInt = integerSolution/.{options}/.Options[farkasSchedule];
  optAddConstraints = addConstraints/.{options}/.Options[farkasSchedule];
  optDuration=durations/.{options}/.Options[farkasSchedule];
  optCheckSched=checkSched/.{options}/.Options[farkasSchedule];
  optScheduleType=scheduleType/.{options}/.Options[farkasSchedule];
  optOptimizationType=optimizationType/.{options}/.Options[farkasSchedule];
  optOnlyVar=onlyVar/.{options}/.Options[farkasSchedule];
  optGivenSchedVect=givenSchedVect/.{options}/.{givenSchedVect ->{}};
  optOnlyDep=onlyDep/.{options}/.Options[farkasSchedule];
  optOutputForm=outputForm/.{options}/.Options[farkasSchedule];
  optDurationByEq=durationByEq/.{options}/.Options[farkasSchedule];
  optSchedMethod=schedMethod/.{options}/.Options[farkasSchedule];
  optMultiSchedDepth=multiSchedDepth/.{options}/.Options[farkasSchedule];
  optObjFunction=objFunction/.{options}/.Options[farkasSchedule];
  optSubSystems=subSystems/.{options}/.Options[farkasSchedule];
  optSubSystemSchedule=subSystemsSchedule/.{options}/.Options[farkasSchedule];
  optMultiDimensional=multiDimensional/.{options}/.Options[farkasSchedule];
      

  If[ MatchQ[optAddConstraints,List[__List]],
  (* If addConstraints is a list of list, this corresponds 
      to multiDim scheduling *)
  dimNumber = If[ optOptimzationType===multi,
			   optMultiSchedDepth,
		   1];
  If [dimNumber > Length[optAddConstraints],
	       optAddConstraints = {},
	       optAddConstraints = optAddConstraints[[dimNumber]]]];

  If [optDebug,Print["optimization Type: ",optOptimizationType]];

  optionList = {optDebug,optVerbose,optResolutionSoft,optRatOrInt,
		    optAddConstraints,optDuration,optCheckSched,
		    optScheduleType,optOptimizationType,optOnlyVar,
		    optGivenSchedVect,optOnlyDep,optOutputForm,
		    optDurationByEq,optSchedMethod,optMultiSchedDepth,
		    optObjFunction,	optSubSystems,optSubSystemSchedule,
		    optMultiDimensional, optMute};

		  
  (* add the parameter constraints *)
  sys=addAllParameterDomain[sys0];
       
  posReduce = Position[sys,Alpha`reduce,Infinity];
  If [posReduce=!={},
    Message[farkasSchedule::NoReduce];
    Throw[$Failed]];

  posUse = Position[sys,Alpha`use,Infinity];
  If [posUse=!={} ,
    If [!optSubSystems,
      Message[farkasSchedule::NoUse];
      Throw[$Failed]]
  ];
       
  paramSpace=sys[[2]];
  listInputVars=getInputVars[sys];
  listOutputVars=getOutputVars[sys];
  listLocalVars=getLocalVars[sys];
  numInstrVar = makeNumInstr[listInputVars,
				  listLocalVars,
				  listOutputVars];
       
  If[ optionList[[1]],
    Print["Number of Variables: "];
    Print[numInstrVar]
  ];

  (* Compute the list of all dependancies  *)
  If[ optVerbose,
    Print["Dependence analysis..."]]; 
       
  listDep = dep[sys,eliminatesDoubles -> False];
       
  If[ optGivenSchedVect=!={},
    checkGivenSchedVect[sys,optionList]];
       
  If[ optOnlyDep =!=all,
    listDep = getNewListDep[listDep, optionList]];
       
  (* If we want to schedule only some variables
     Warning, this option is fragile *)
  If[ optOnlyVar=!=all,
    newOnlyVar = checkOptOnlyVar[sys,
      numInstrVar,
      listDep,
      optionList];
    If[ newOnlyVar =!= {},
      numInstrVar = setInstrToSchedule[numInstrVar, newOnlyVar];
      nameOnlyVar = Map[First,numInstrVar];
		 
      listInputVars=Intersection[listInputVars, nameOnlyVar];
      listOutputVars=Intersection[listOutputVars, nameOnlyVar];
      listLocalVars=Intersection[listLocalVars, nameOnlyVar]; 
      listDep = setDepToSchedule[numInstrVar, listDep]
    ];
  ];

  If[ optionList[[1]],
    Print["Dependencies (numbered in this order):"];
    show[listDep]
  ];
       

  (* For simplification of the resulting problem,
     we keep one single convex domains (no union of
     polyhedra *)
  localDomains= Map[getDomainOfVar[sys,#] &, listLocalVars];
  inputDomains= Map[getDomainOfVar[sys,#] &, listInputVars];
  outputDomains= Map[getDomainOfVar[sys,#] &, listOutputVars];
  localDomains=  Map[convexiseDom,localDomains];
  inputDomains = Map[convexiseDom,inputDomains];
  outputDomains= Map[convexiseDom,outputDomains];
       
  (* We classify the dependencies in five categories :
     Output <- Local,
     Output <- Input
     Local <- Output
     Local <- input
     Local <- Local 
     Output <- Output*)
	 
   splittedListDep=splitListDep[listDep,
				      listInputVars,
				      listLocalVars,
				      listOutputVars,
				      optionList];
       
  (* Get the correspondance number for each Dep *)
  numDepSplitted = makeNumDepSplitted[listDep,splittedListDep];
       
       
  (* For simplification of the LP: convexise all domain dep *)
  splittedListDep =
	 convexiseSplittedDep[splittedListDep];
       
       
  (* Build the reference line. This line will indicates 
    the structure of a row of a matrix representing 
    a constraint. This structure is detailled below 
    in the makeRefline function *)
	   
  refline=makeRefline[paramSpace,
			       numInstrVar,
			       splittedListDep,
			       listInputVars,
			       listLocalVars,
			       listOutputVars,
			       inputDomains,
			       localDomains,
			       outputDomains,
			       optionList];
       
  (* Build the duration of each dependance List integer  *)
  Check[ duration1 = buildDuration[sys,numInstrVar,optionList],
         Throw[ $Failed ]
  ];

  If[ optVerbose, Print["Building LP..."] ];
       
       (* structTableEq is the structured constraints matrix *)
	 
	 structTableEq= makeTableEq[paramSpace,
				    numInstrVar,
				    splittedListDep,
				    numDepSplitted,
				    listInputVars,
				    listLocalVars,
				    listOutputVars,
				    inputDomains,
				    localDomains,
				    outputDomains,
				    duration1,
				    refline,
				    optionList];

       $runTime = {Length[Flatten[structTableEq[[1]],Infinity]],
                         2*Length[structTableEq]};

       If [(* optVerbose *) !optMute,
	   Print["LP: ",Length[Flatten[structTableEq[[1]],Infinity]],"
			   variables, ",2*Length[structTableEq]," Constraints"]];
       
	 
       If [(optOutputForm=!=scheduleResult)||(optDebug),
	   (* does all the other output format: lpSolve, 
	      lpMMA, domain  *)
	   printAllConstraint[structTableEq,
			      refline,
			      numInstrVar,
			      splittedListDep,
			      optionList]];
       
       If[ optVerbose, Print["Writing file for PIP...."] ];

       tempFile1  = getTemporaryName[];
	   If[ optDebug, Print["temporary file: ", tempFile1] ];

       results = fichierPip[tempFile1
			(*"/tmp/fichier"<> 
			    Environment["USER"]*), 
			  structTableEq,
			  refline,optionList];
			  

       If[ !optDebug, DeleteFile[tempFile1]];
       If [results===Null,
	   error = 1,
	   result=results[[2]];
	   phiCoefs = results[[1]];
	   (* computing total time *)
	     If [optOptimizationType === time ,
		 If [sys[[2,1]]>0,
		     paramCoef = Drop[phiCoefs,-1];
		     paramVect= sys[[2,2]];
		     If [Length[paramCoef]=!=Length[paramVect],
			 Message[farkasSchedule::PbInTotalTime];
			 time1 = 0,
			 time1=Dot[paramVect,paramCoef]+
			   Last[phiCoefs]],
		     time1 = Last[phiCoefs];
		   ];
		 If [optVerbose,
		     Print["Total execution Time: ",time1]];
	       ];
	   If [optVerbose && (10 <= optionList[[9]] <= 20),
	       Print["number Of satisfied edges:",
		     ToExpression[phiCoefs[[1]]]];
	       Print["These are: ",Drop[phiCoefs,1]];];
	 ];
       
       If [error===0,
	   result=reorderSchedResult[result,
				     numInstrVar,
				     refline];
	   result=getFinalForm[result, 
			       ToExpression[phiCoefs],
			       numInstrVar,
			       {localDomains,
				outputDomains,
				inputDomains},
			       refline,
			       optionList];
	   result=ReplacePart[result, sys[[1]] ,1],
		result=Null];
      
       $schedule = result;

       If [optVerbose,showSchedResult[result]];
         result  
       ]
];


farkasSchedule[a___]:=Message[farkasSchedule::WrongArg,a];




Clear[multiSched]

Options[multiSched] := Options[farkasSchedule];

multisched::ObsoleteSyntax = "Warning, you are using an obsolete syntax
for the options mechanism of schedule, in the right mechanism you just
set the rules for options as aditionnal parameters to the function,
example: multiSched[$result,debug->True]"
 multisched::Failed = farkasSchedule::Failed 
multiSched::MultiNotFound = "No multi dimensionnal schedule found, sorry..."
multiSched::WongArg = "Wrong argument for multiSched : `1`"


multiSched[{options___Rule}]:=
  Module[{},
	 Message[multisched::ObsoleteSyntax];
	 multiSched[options]]

multiSched[sys0:Alpha`system[___], {options___Rule}]:=
  Module[{},
	 Message[multisched::ObsoleteSyntax];
	 multiSched[sys0,options]]



multiSched[options___Rule]:=
  Module[{tempRes},
	 tempRes=Check[multiSched[$result, options],$Failed];
	 If [MatchQ[tempRes,scheduleResult[___]],
	     $schedule=tempRes;
	     tempRes,
	     Message[multisched::Failed];
	     $Failed]]

multiSched[sys_Alpha`system, options___Rule]:=
  Module[{error,optDebug,optVerbose,optResolutionSoft,
	  optRatOrInt,optAddConstraints,
	  optDuration,optCheckSched,optScheduleType,optOptimizationType,
	  optOnlyVar,optGivenSchedVect,optOnlyDep,optOutputForm,
	   optDurationByEq,optSchedMethod,optMultiSchedDepth,optObjFunction,
	  optMultiDimensional,	optSubSystems,optSubSystemSchedule,
	  optionList,depList,listInputVars,
	  listOutputVars,listLocalVars,numInstrVar,gDepMMA,
	  unScheduledDep,epsilonList,schedFinal,multiSched1,counter,sigma,
	  depToSchedule,depToScheduleNextTime,
	  schedResult1,grainSize,gDepOrdered,optionsLocal,
	  passCounter,schedGiven,varToSchedule,totalNbVar,reallyFinal,
	  listZeroDep,curOptDuration, curOptAddConstraints,satisfiedDep },
	 
	 error=0; 
	 optDebug = debug/.{options}/.Options[multiSched];
	 optVerbose= verbose/.{options}/.Options[multiSched];
	 optResolutionSoft= resolutionSoft/.{options}/.Options[multiSched];
	 optRatOrInt = integerSolution/.{options}/.Options[multiSched];
	 optAddConstraints =
	   addConstraints/.{options}/.Options[multiSched];
	 optDuration=durations/.{options}/.Options[multiSched];
	 optCheckSched=checkSched/.{options}/.Options[multiSched];
	 optScheduleType=scheduleType/.{options}/.Options[multiSched];
	 optOptimizationType=optimizationType/.{options}/.Options[multiSched];
	 optOnlyVar=onlyVar/.{options}/.Options[multiSched];
	 optGivenSchedVect=givenSchedVect/.{options}/.Options[multiSched];
	 optOnlyDep=onlyDep/.{options}/.Options[multiSched];
	 optOutputForm=outputForm/.{options}/.Options[multiSched];
	 optDurationByEq=durationByEq/.{options}/.Options[multiSched];
	 optSchedMethod=schedMethod/.{options}/.Options[multiSched];      
	 optMultiSchedDepth=multiSchedDepth/.{options}/.Options[multiSched];	
	 optObjFunction=objFunction/.{options}/.Options[multiSched];	 
	 optMultiDimensional=
  multiDimensional/.{options}/.Options[multiSched];
	 optSubSystems=subSystems/.{options}/.Options[farkasSchedule];
	 optSubSystemSchedule=subSystemsSchedule/.{options}/.Options[farkasSchedule];
       
	   optionList = {optDebug,optVerbose,optResolutionSoft,optRatOrInt,
		       optAddConstraints,optDuration,optCheckSched,
		       optScheduleType,optOptimizationType,optOnlyVar,
		       optGivenSchedVect,optOnlyDep,optOutputForm,
		       optDurationByEq,
	  optSchedMethod,optMultiSchedDepth,
		       optObjFunction,	optSubSystems,optSubSystemSchedule,
			 optMultiDimensional};
	 
	   
	 If [optVerbose,
	     Print["Starting multidimensionnal scheduling on program ",
		   sys[[1]]]];
	 depList = dep[sys,eliminatesDoubles -> False];
	 listInputVars=getInputVars[sys];
	 listOutputVars=getOutputVars[sys];
	 listLocalVars=getLocalVars[sys];   
	 numInstrVar = makeNumInstr[listInputVars,
				    listLocalVars,
				    listOutputVars];
	 totalNbVar = Length[numInstrVar];
	 (* Boolean indicating that there remain some dependance to
	    schedule *)
	 unScheduledDep = True;
	 (* List of Integer that will indicate at each level, which
	    dependance have been scheduled *)
	 epsilonList = Table[0,{i,1,Length[depList[[1]]]}];
	 depNumList = Table[i,{i,1,Length[depList[[1]]]}];
	 satisfiedDep = Table[0,{i,1,Length[depList[[1]]]}];
	 (* epsilonList reduces as the dimension of the schedule grow,
	    while satisfiedDep do not *)

	 schedFinal = {};
	 (* counter of depht of the schedule *)
	 counter=0;
	 While[(unScheduledDep)||(optMultiSchedDepth>counter),
	       counter=counter+1;
	       If [optionList[[2]],
		   Print["Scheduling dimension number ",counter]];
	       (* getting the duration of this dimension in case of 
		  dimension-variable duration *)
		 If [MatchQ[optDuration,List[__List]],
		     If [counter>Length[optDuration],
			 If [optVerbose,Print["Warning, no duration
	       specified for this dimension, setting duration option to 0"]];
			 curOptDuration = {},
			 curOptDuration = optDuration[[counter]]],
		     (* else MatchQ *)
		       curOptDuration = optDuration];
	       (* getting the constraints of this dimension in case of 
		  dimension-variable added constraints *)
		 If [MatchQ[optAddConstraints,List[__List]],
		     If [counter>Length[optAddConstraints],
			 If [optDebug,Print["Warning, no Constraints
	       specified for this dimension, setting no additional constraints"]];
			 curOptAddConstraints = {},
			 curOptAddConstraints = optAddConstraints[[counter]]],
		     (* else MatchQ *)
		       curOptAddConstraints = optAddConstraints];
		     

	       (* setting the list of dependence with zero duration *)
		   listZeroDep = {};
	       If [MatchQ[curOptDuration,List[__Integer]],
		   (* compute, for each dep, if its duration is set to 
		      0 by the duration option *)
		   MultiDim::Pb1 = "Internal Problem: var `1` not found ";
		   Module[{curDep,curVar,posCurVar,curDuration},
			  listAllVar = Join[listInputVars,
					    listOutputVars,
					    listLocalVars];
			  Do [ curDep = depList[[1,i]];
			       curVar = curDep[[2]];
			       posCurVar = Position[listAllVar,curVar];
			       If [Length[posCurVar]=!=1,
				   Message[MultiDim::Pb1,curVar]];
			       curDuration = getPart[curOptDuration,posCurVar[[1]]];
			       If [curDuration===0,
				   listZeroDep = Append[listZeroDep ,i]],
			       {i,1,Length[depList[[1]]]}]
			];
		 ];
                If[True (* optDebug *),Print["duration options:",curOptDuration]];
	       
	       depToSchedule = Map[Part[depNumList,#] &,
				   Flatten[Position[satisfiedDep,0],1]];
	       (* We add here the "semper" dependance which have a
		  duration of zero, this should useless now 
	       depToSchedule = Sort[Union[ depToSchedule, listZeroDep]]; *)
	       optionsLocal = {multiDimensional->True,
			       optimizationType->multi,
			       multiSchedDepth->counter,
			       onlyDep ->depToSchedule,
			       (* This rule overwrites previous rule
				  on addConstraints and duration *)
			       addConstraints-> curOptAddConstraints,
			       durations -> curOptDuration };
	       If [(* optionList[[1]] *) True,
		   Print["dep to schedule: ",depToSchedule];
		 ];

	       (******************CALL TO SCHEDULE ******************)
	       schedResult1 = 
		 Catch[Apply[farkasSchedule,
			     Join[{sys},optionsLocal,{options}]]];
	       (************************************ ******************)
	       If [schedResult1===$Failed,Throw[$Failed]];
	       If [optionList[[1]],
		   Print["resultFound:"];
		   showSchedResult[schedResult1]];
	        sigma = schedResult1[[3,1]];
	       If [(sigma === 0)&&(Length[schedResult1[[3]]]>1),
		   Message[multiSched::MultiNotFound];
		   (*  unScheduledDep = False;
		      schedFinal = Null; *)
		     Break ];
	       epsilonList = Drop[schedResult1[[3]],1];
	       Do [satisfiedDep=If[epsilonList[[i]]===1,
				   ReplacePart[satisfiedDep,1,
					       depToSchedule[[i]]],
				   satisfiedDep]
		   , {i,1,Length[epsilonList]}];
	         If [ optionList[[1]]  ,
		   Print["satisfiedDep = ",satisfiedDep ]];
	       schedFinal = Append[schedFinal,schedResult1[[2]]];
	       (* unScheduledDep must be True if some dep are not 
		  scheduled that is : 
		  There are some epsilon in epsilonList which 
		  are 0, and these epsilon do not correspond to 
		  dependencies with duration = 0 *)
		 depToScheduleNextTime = Map[Part[depNumList,#] &,
					     Flatten[Position[epsilonList,0],
						     1]];
	       depToScheduleNextTime = 
		 Complement[depToScheduleNextTime,listZeroDep ];
	       unScheduledDep = (Length[depToScheduleNextTime]>0);

	     ];
	 If [schedFinal === Null,
	     multiSched1=Null,
	     If [optionList[[2]],
		 Print["Schedule Found has ", counter ," dimensions"]];
	     multiSched1 = schedFinal[[1]];
	     Do [multiSched1 = 
		   MapThread[Append[#1,Part[#2,3]] &,
			     {multiSched1,schedFinal[[i]]}],
		 {i,2,counter}]];

  (* Modification done here by P. Quinton, on Feb. 28, 2006
    in order to have the standard form of scheduleResult *)
  (* The first element of this structure is the name of the system, 
    and the last one : I do not know yet... *)
 
  reallyFinal = scheduleResult[ sys[[1]], multiSched1, {} ];
 
  (*
    Removed, as showSchedResult fails ... ********** Has to be fixed
  If[ (counter >= 1)&&(optionList[[2]]), showSchedResult[reallyFinal] ];
  *)

  $schedule = reallyFinal;
  reallyFinal
];

multiSched[a___]:= (Message[multiSched::WongArg,a];
  Throw["ERROR"]);





(* isUniformQ is a predicate indicating if a systen is in correct
   uniform form to be handle by the schedule, the condition that sys
   must met are: same number of indices for all local variable, all
   dependance unifomes (or depending on parameters) ...  *)

Clear[isUniformQ]

isUniformQ[sys_:Alpha`system]:=
  Module[{},
	 Print["isUniformQ is not written, gessing ...True !"];
	 True]


(* splitListDep : take the dependance table and split it into 
   six different categories: 
   Output <- Local,
   Output <- Input
   Local <- Output
   Local <- input
   Local <- Local
   Out <- Out *)

Clear[splitListDep]

splitListDep[listDep_Alpha`dtable,
	     sys_Alpha`system]:=
  splitListDep[listDep,sys,{}]


	 
splitListDep[listDep_Alpha`dtable,
	     listInputVars_List,
	     listLocalVars_List,
	     listOutputVars_List,
	     optionList_List]:= 
  Module[{locToOut,inToOut ,inToLoc,locToLoc,outToLoc,outToOut,realDepList},
	 realDepList = listDep[[1]];
	 locToOut = Select[
	   Select[realDepList, 
		  MemberQ[listLocalVars,Part[#1,3]] &] (* from local *),
	   MemberQ[listOutputVars,Part[#1,2]] &]; (* to output *)
	 inToOut = Select[
	   Select[realDepList, 
		  MemberQ[listInputVars,Part[#1,3]] &] (* from input *),
	   MemberQ[listOutputVars,Part[#1,2]] &]; (* to output *)
	 inToLoc = Select[
	   Select[realDepList, 
		  MemberQ[listInputVars,Part[#1,3]] &] (* from input *),
	   MemberQ[listLocalVars,Part[#1,2]] &]; (* to local *)
	 locToLoc = Select[
	   Select[realDepList, 
		  MemberQ[listLocalVars,Part[#1,3]] &] (* from local *),
	   MemberQ[listLocalVars,Part[#1,2]] &]; (* to local *)
	 outToLoc = Select[
	   Select[realDepList, 
		  MemberQ[listOutputVars,Part[#1,3]] &] (* from output *),
	   MemberQ[listLocalVars,Part[#1,2]] &]; (* to local *)
	 outToOut = Select[
	   Select[realDepList, 
		  MemberQ[listOutputVars,Part[#1,3]] &] (* from Output *),
	   MemberQ[listOutputVars,Part[#1,2]] &]; (* to output *)
	   (* Order defined in the main function farkasSchedule[] *)
	 {locToOut,inToOut,outToLoc,inToLoc,locToLoc,outToOut}  
       ]



splitListDep[a___]:= (Message[splitListDep::WrongArg,a];
		      Throw[$Failed])

(* For debug use *)
Clear[printSplittedDepListe];

printSplittedDepListe[splitted_List]:=
	Module[{lengths,lengthsAdded},
	       lengths=Map[Length,splitted];
	       (* numbering dependancies *)
	       lengthsAdded = Drop[FoldList[Plus,1,lengths],-1];
	       MapThread[printOneDepListe,{splitted,lengthsAdded}]
	     ]
      
printSplittedDepListe[a___]:=Message[printSplittedDepList::WrongPar,a]

printOneDepListe[depList_List,number_Integer]:=
  Module[{nbDep},
	 nbDep=Length[depList];
	 MapThread[ (Print["Dep number ",#1," from ",#2[[3]]," to
  ",#2[[2]]," on: "];show[#2[[1]]]) &,
		    {Table[i,{i,number,number+nbDep-1}],
		     depList}]
       ]

printOneDepListe[a,___]:= Message[printOneDepListe::WrongPar,a]



(****************************************************************)
(*************************  REFLINE *****************************

 make refline fill the reference line for buildung the matrix 
  Definition of refline:
	     <refline>  =  {{nbPhi},
	                    {<localtau_List>,
	                     <outputtau_List>
			     <inputputtau_List>},
			    {{nbLocalalpha},
			     {nbOutputalpha},
			     {nbInputalpha}},
			    {<farkasLambdaLocToOut>,
			     <farkasLambdaInToOut>,
			     <farkasLambdaOutToLoc>,
			     <farkasLambdaInToLoc>,
			     <farkasLambdaLocToLoc>,
			     <farkasLambdaLocToLoc>},
			    {<farkasMuLocal>,
			     <farkasMuOutput>,
			     <farkasMuInput>},
			    {<farkasRhoLocal>,
			     <farkasRhoOutput>,
			     <farkasRhoInput>},
			    {1},
			    {1}}
			    

{nbPhi} 
  is the number of coef for the objective function
  If the objective function is the global exec time  
  then Phi is a vector of lenght the number of parameters plus 
  a constant part.
  If the objective the \\sigma(\\epsilon_i) for multidimensionnl
  scheduling, Phi is a vector whose first component is 
  sigma= \\sigma(\\epsilon_i) and the others are the epsilon_i 
  (see part II for notation). 
							     
 <localtau_List>
 (List of {numberInstr,dimension} of the
  the local variables (all these dimension
		       must be the same),
  <outputtau_List>
  (List of {numberInstr,dimension} the
   the output variables 
   <inputputtau_List>,
   (List of {numberInstr,dimension} of 
    the input variables
    {nbLocalalpha},
    {nbOutputalpha},
    {nbInputalpha},
    <farkasLambdaLocToOut>
    (List of {numberdep,nbLambdaLocToOut}
     for each dependance LocToOut where,
     nbLambdaLocToOut is the number of 
     Farkas coefficient necessary to impose 
     the dependance),
    <farkasLambdaInToOut>
    (List of {numberdep,nbLambdaInToOut}
     for each dependance InToOut where,
     nbLambdaInToOut is the number of 
     Farkas coefficient necessary to impose 
     the dependance),
    <farkasLambdaOutToLoc>
    (List of {numberdep,nbLambdaOutToLoc}
     for each dependance OutToLoc where,
     nbLambdaOutToLoc is the number of 
     Farkas coefficient necessary to impose 
     the dependance),
    <farkasLambdaInToLoc>
    (List of {numberdep,nbLambdaInToLoc}
     for each dependance InToLoc where,
     nbLambdaInToLoc is the number of 
     Farkas coefficient necessary to impose 
     the dependance),
    <farkasLambdaLocToLoc>
    (List of {numberdep,nbLambdaLocToLoc}
     for each dependance LocToLoc where,
     nbLambdaLocToLoc is the number of 
     Farkas coefficient necessary to impose 
     the dependance),
    <farkasLambdaOutToOut>
    (List of {numberdep,nbLambda}
     for each dependance OutToOut where,
     nbLambda is the number of 
     Farkas coefficient necessary to impose 
     the dependance),
    <farkasMuInput>
    (List of {numberInstr,nbMuInput} for each 
     input where, nbMuInput is the number of 
     Farkas coefficient necessary to impose 
     the positivity condition on the input),
    <farkasMuOutput>
    (List of {numberInstr,nbMuOutput} for each 
     input where, nbMuOutput is the number of 
     Farkas coefficient necessary to impose 
     the positivity condition on the Output),
    <farkasMuLocal>
    (List of {numberInstr,nbMuLocal} for each 
     input where, nbMuLocal is the number of 
     Farkas coefficient necessary to impose 
     the positivity condition on the local
     variables (all thes number must be equal),
    <farkasrhoLocal>
     (List of {numberInstr,nbrhoOutput} for each 
     input where, nbrhoOutput is the number of 
     Farkas coefficient necessary to impose 
     the constraints that the objective function is
      greater than each local function 
      (* temporarily set to o *)
    <farkasrhoOuptu>
     (List of {numberInstr,nbrhoOutput} for each 
     input where, nbrhoOutput is the number of 
     Farkas coefficient necessary to impose 
     the constraints that the objective function is
      greater than each output function 
    <farkasrhoInput>
     (List of {numberInstr,nbrhoOutput} for each 
     input where, nbrhoOutput is the number of 
     Farkas coefficient necessary to impose 
     the constraints that the objective function is
      greater than each input function 
      (* temporarily set to o *)


     {1} (constant),
     {1} ({-1|0|1}
	  % -1 --> line <0
	  %  0 --> line =0* 
	  % +1 --> line >0)}
    
    *)

Clear[makeRefline]


makeRefline[paramSpace_Alpha`domain,
	     numInstrVar_List,
	    splittedListDep_List,
	    listInputVars_List,
	    listLocalVars_List,
	    listOutputVars_List,
	    inputDomains_List,
	    localDomains_List,
	    outputDomains_List,
	      options_List]:=
  Module[{nbParam,localTauList,outputTauList,inputTauList,
	  nbLocalAlpha,nbOutputAlpha,nbInputAlpha,
	  farkasLambdaLocToOut,farkasLambdaInToOut,
	  farkasLambdaInToLoc,farkasLambdaLocToLoc,
	  farkasLambdaOutToLoc,farkasMuInput,
	  farkasMuOutput,farkasMuLocal,dimLocal,n2,n3,n4,n5,n6,n7,
	  listOutputDomainsInDep,farkasLambdaOutToOut,farkasRhoLocal,
		 farkasRhoOutput,farkasRhoInput,refline,nbPhi,nbEpsilon},
	 
	 nbParam=paramSpace[[1]];
	 
	 localTauList = 
	   Table[{i+Length[listInputVars]+Length[listOutputVars],
		  localDomains[[i,1]]},
		 {i,1,Length[listLocalVars]}];
	 outputTauList = Table[{i+Length[listInputVars],outputDomains[[i,1]]},
			      {i,1,Length[listOutputVars]}];
	 inputTauList = Table[{i,inputDomains[[i,1]]},
			      {i,1,Length[listInputVars]}];
	 nbLocalAlpha= Length[listLocalVars];
	 nbOutputAlpha= Length[listOutputVars];
	 nbInputAlpha= Length[listInputVars];

	 
	 n2=Length[splittedListDep[[1]]];
	 n3=n2+Length[splittedListDep[[2]]];
	 n4=n3+Length[splittedListDep[[3]]];
	 n5=n4+Length[splittedListDep[[4]]];
	 n6=n5+Length[splittedListDep[[5]]];
	 n7=n6+Length[splittedListDep[[6]]];
	(*  LocToOut *)
	 listOutputDomainsInDep = Map[Part[#1,1]&,splittedListDep[[1]]];
	 farkasLambdaLocToOut = 
	   Table[{i,getNumberFarkasCoef[listOutputDomainsInDep[[i]]]},
		 {i,1,n2}];
	 listOutputDomainsInDep = Map[Part[#1,1] &,splittedListDep[[2]]];
	 farkasLambdaInToOut = 
	   Table[{i,getNumberFarkasCoef[listOutputDomainsInDep[[i-n2]]]},
		 {i,n2+1,n3}];
	 listOutputDomainsInDep = Map[Part[#1,1] &,splittedListDep[[3]]];
	 farkasLambdaOutToLoc =
	   Table[{i,getNumberFarkasCoef[listOutputDomainsInDep[[i-n3]]]},
		 {i,n3+1,n4}];
	 listOutputDomainsInDep = Map[Part[#1,1] &,splittedListDep[[4]]];
	 farkasLambdaInToLoc =
	   Table[{i,getNumberFarkasCoef[listOutputDomainsInDep[[i-n4]]]},
		 {i,n4+1,n5}];
	 listOutputDomainsInDep = Map[Part[#1,1] &,splittedListDep[[5]]];
	 farkasLambdaLocToLoc =
	   Table[{i,getNumberFarkasCoef[listOutputDomainsInDep[[i-n5]]]},
		 {i,n5+1,n6}];
	 (* outToOut *)
	 listOutputDomainsInDep = Map[Part[#1,1] &,splittedListDep[[6]]];
	 farkasLambdaOutToOut =
	   Table[{i,getNumberFarkasCoef[listOutputDomainsInDep[[i-n6]]]},
		 {i,n6+1,n7}];

	 
	farkasMuInput= Table[{i,getNumberFarkasCoef[inputDomains[[i]]]},
			   {i,1,Length[listInputVars]}];
	 farkasMuOutput=Table[{i+Length[listInputVars],
			       getNumberFarkasCoef[outputDomains[[i]]]},
			     {i,1,Length[listOutputVars]}];
	 farkasMuLocal=Table[{i+Length[listInputVars]+Length[listOutputVars],
			        getNumberFarkasCoef[localDomains[[i]]]},
			     {i,1,Length[listLocalVars]}];

	 (* unless prooven necessary, no farkas rho for Local
	 variable nor Input *)
	 farkasRhoLocal = Map[ReplacePart[#,0,2] &, farkasMuLocal];
	 farkasRhoInput = Map[ReplacePart[#,0,2] &, farkasMuInput];
	 farkasRhoOutput = farkasMuOutput;
	 
	 Switch[options[[9]],
		time,nbPhi = nbParam+1,
		Null,nbPhi= 0,
		multi,nbPhi = n7+1,
		_,Message[makeRefline::UnknownOption];Throw[$Failed]];
	 
	 refline  =  {{nbPhi},
		      {localTauList,outputTauList,inputTauList},
		      {{nbLocalAlpha},{nbOutputAlpha},{nbInputAlpha}},
		      {farkasLambdaLocToOut,farkasLambdaInToOut,
		       farkasLambdaOutToLoc,farkasLambdaInToLoc,
		       farkasLambdaLocToLoc,farkasLambdaOutToOut},
		      {farkasMuLocal,farkasMuOutput,farkasMuInput},
		      {farkasRhoLocal,farkasRhoOutput,farkasRhoInput},
		      {1},
		      {1}}
		      ]

makeRefline[a___]:=
  Module[{},
	 Message[makeRefline::WrongArg,{a}];
	 Print[a];
	 Throw[$Failed]]
      
(* This function gives the number of farkas coefficient 
   that will appear when ensuring a positivity condition on these 
   domains.
   in domains 
   nbIneq,nb sommet,nq eq in Ineq, nb lines in sommet *)

Clear[getNumberFarkasCoef]

getNumberFarkasCoef[dom1_Alpha`domain]:=
  Module[{onePol,numberIneq,numberEq},
	 (* A this developpement point the domains should NOT be convex *)
	 If  [Length[dom1[[3]]]>1,
	      Message[getNumberFarkasCoef::nonConvex];
	      onePol=dom1[[3,1]],
	      onePol=dom1[[3,1]]];
	 
	 numberIneq = onePol[[1]];
	 numberEq =   onePol[[3]];
	 (* one coef by ineq, two coef  by eq, 1 coef for the constant*)
	 numberIneq+numberEq+1]

getNumberFarkasCoef[a___]:=(Message[getNumberFarkasCoef::WrongPar,a];
			    Throw[$Failed])



(********************* Build Duration ***********************)

buildDuration[sys_Alpha`system,
	      numInstrVar_List,
	      options_List]:= 
Module[{nbInstr},
  nbInstr = Length[sys[[3]]]+Length[sys[[4]]]+Length[sys[[5]]];
  Switch[options[[6]],
    {}, If[ options[[1]], Print["Duration : 1 for each equation "]];
          Table[1,{i,1,nbInstr}],
    {___Integer}, 
        If[ nbInstr=!=Length[options[[6]] ],
          Message[buildDuration::WrongSize,nbInstr];
          Print["Durations should be given in the following order: ",
            Join[getInputVars[sys],getOutputVars[sys],getLocalVars[sys]]
          ];
          Throw[$Failed];Null,

          If[ options[[2]],
            posNotNull = 
            Table[
              If[ options[[6,i]]=!=0, numInstrVar[[i,1]], 0],
              {i,1,nbInstr}
            ];
            posNotNull=Select[posNotNull,#=!=0 &];
            Print["Duration not null for :", posNotNull]
          ]
        ]; options[[6]],
     ___,Message[buildDuration::UnrecognizedValue,options[[6]]];
	           Table[1,{i,1,nbInstr}]
	] (* Switch *)
];

buildDuration[a___]:= (Message[buildDuration::WrongArg];
		       Throw[$Failed])


(* makeTableExpr build the structured matrix (with structure 
   indicated by refline that represents all the constraints *)
	
Clear[makeTableEq]

makeTableEq[paramSpace_Alpha`domain,
	    numInstrVar_List,
	    splittedListDep_List,
	    numDepSplitted_List,
	    listInputVars_List,
	    listLocalVars_List,
	    listOutputVars_List,
	    inputDomains_List,
	    localDomains_List,
	    outputDomains_List,
	    duration_List,
	    refline_List,
	    options_List]:= 
Module[{tauLoc,tauOut,tauIn, alphaLoc ,alphaOut,alphaIn,
	      farLocToOut,farInToOut,farOutToLoc,farInToLoc,farLocToLoc,
	       muLoc,muOut,muIn,rhoLoc,rhoOut,rhoIn,line0,
	matLocalPos,matOuputPos,matInputPos,finalMat,phiCoef,matOutputObj,
	matAddedConstraints,addedConstraints,
	farOutToOut,schedTypeAddConstraints,numbersInVar,numbersOutVar,
	numbersLocVar,absoluteNumDep} ,
       
       (* making line 0 which represent a constraint with only 0 in it
	    *)
	 phiCoef=Table[0,{i,1,refline[[1,1]]}];
       tauLoc=Map[Table[0,{i,1,#1[[2]]}] &,refline[[2,1]]];
       tauOut=Map[Table[0,{i,1,#1[[2]]}] &,refline[[2,2]]];
       tauIn=Map[Table[0,{i,1,#1[[2]]}] &,refline[[2,3]]];
       alphaLoc=Table[0,{i,1,refline[[3,1,1]]}];
       alphaOut=Table[0,{i,1,refline[[3,2,1]]}];
       alphaIn=Table[0,{i,1,refline[[3,3,1]]}];
       farLocToOut = Map[Table[0,{i,1,#1[[2]]}] &,refline[[4,1]]];
       farInToOut = Map[Table[0,{i,1,#1[[2]]}] &,refline[[4,2]]];
       farOutToLoc = Map[Table[0,{i,1,#1[[2]]}] &,refline[[4,3]]];
       farInToLoc = Map[Table[0,{i,1,#1[[2]]}] &,refline[[4,4]]];
       farLocToLoc = Map[Table[0,{i,1,#1[[2]]}] &,refline[[4,5]]];
       farOutToOut = Map[Table[0,{i,1,#1[[2]]}] &,refline[[4,6]]];
       muLoc = Map[Table[0,{i,1,#1[[2]]}] &,refline[[5,1]]];
       muOut = Map[Table[0,{i,1,#1[[2]]}] &,refline[[5,2]]];
       muIn = Map[Table[0,{i,1,#1[[2]]}] &,refline[[5,3]]];
       rhoLoc = Map[Table[0,{i,1,#1[[2]]}] &,refline[[6,1]]];
       rhoOut = Map[Table[0,{i,1,#1[[2]]}] &,refline[[6,2]]];
       rhoIn = Map[Table[0,{i,1,#1[[2]]}] &,refline[[6,3]]];
       line0={phiCoef,
	      {tauLoc,tauOut,tauIn},
	      {alphaLoc ,alphaOut,alphaIn},
	      {farLocToOut,farInToOut,farOutToLoc,farInToLoc,farLocToLoc,
	       farOutToOut},
	      {muLoc,muOut,muIn},{rhoLoc,rhoOut,rhoIn},{0},{0}};

       numbersInVar = Map[Part[#,2] &,
			  Take[numInstrVar,{1,Length[listInputVars]}]];
       numbersOutVar = Map[Part[#,2] &,
			  Take[numInstrVar,
			       {Length[listInputVars]+1,
				Length[listInputVars]+
				Length[listOutputVars]}]];
       numbersLocVar = Map[Part[#,2] &,
			  Take[numInstrVar,
			       {Length[listInputVars]+
				Length[listOutputVars]+1,
				Length[numInstrVar]}]];

       

	 (* Constraints on the positivity of the schedule of
	 local variables *)
	     matLocalPos=
	       If [Length[listLocalVars]>=1,
		   Apply[Join,MapThread[
		     makePositivityConstraint,
		     (* Number of the instruction *)
		       {numbersLocVar,
			(* Domain *)
			localDomains,
			(* line0 *)
			Table[line0,{i,1,Length[listLocalVars]}], 
			 (* numInstrVar *)
			 Table[numInstrVar,{i,1,Length[listLocalVars]}],
			(* options *)
			 Table[options,{i,1,Length[listLocalVars]}]
			}]
		       ],
		   {}];

	 (* Constraints on the positivity of the schedule of
	 Output variables *)
	   matOutputPos=
	     If [Length[listOutputVars]>=1,
		 Apply[Join,MapThread[
		   makePositivityConstraint,
		   (* Number of the instruction *)
		     {numbersOutVar,
 		      (* Domain *)
		      outputDomains,
		      (* line0 *)
		      Table[line0,{i,1,Length[listOutputVars]}],
			 (* numInstrVar *)
			 Table[numInstrVar,{i,1,Length[listOutputVars]}],
			(* options *)
			 Table[options,{i,1,Length[listOutputVars]}]
		      }]
		     ],
		 {}];

	 (* Constraints on the positivity of the schedule of
	 Input variables *)
	 matInputPos=
	   If [Length[listInputVars]>=1,
	       Apply[Join,MapThread[
		 makePositivityConstraint,
		 (* Number of the instruction *)
		   {numbersInVar,
		    (* Domain *)
		    inputDomains,
		    (* line0 *)
		    Table[line0,{i,1,Length[listInputVars]}],
		    (* numInstrVar *)
		    Table[numInstrVar,{i,1,Length[listInputVars]}],
		    (* options *)
		    Table[options,{i,1,Length[listInputVars]}]
		    }]
		   ],
	       {}];
       
	 (* Constraints on the Objective function (greater than 
	    any output timing function *)
	     Switch[options[[9]],
		    time,matOutputObj=
		      If [Length[listOutputVars]>=1,
			  Apply[Join,MapThread[
			    makeObjFunctionConstraint,
			    (* Number of the instruction *)
			      {Table[i+Length[listInputVars],
				     {i,1,Length[listOutputVars]}],
			       (* Domain *)
			       outputDomains,
			       (* numInstrVar *)
			       Table[numInstrVar,{i,1,Length[listOutputVars]}],
			       (* line0 *)
			       Table[line0,{i,1,Length[listOutputVars]}] }]
			      ],
			  {}],
		    Null,matOutputObj={},
		    multi,matOutputObj=
		      makeEpsilonConstraint[line0,options],
		    _,Message[makeTableEq::unknownOptionValue,options[[9]]]];
		 

	 (* Constraints on the Dependency    *)
	       matDepTemp = {};
       absoluteNumDep = 1;
       Do[	 
	 matDepTemp = 
	   Join[ matDepTemp,
		 If [Length[splittedListDep[[i]]]>0,
		     Apply[Join,MapThread[
		       makeDepConstraint,
		       {(* Number of the dependance*)
			splittedListDep[[i]],
			(* line0 *)
			Table[line0,{i,1,Length[splittedListDep[[i]]]}],
			(* instrList *)
			Table[numInstrVar,
			      {i,1,Length[splittedListDep[[i]]]}],
			(* duration *)
			Table[duration,
			      {i,1,Length[splittedListDep[[i]]]}],
			(* relative Number of the dep *)
			Table[i,
			      {i,1,Length[splittedListDep[[i]]]}],
			(* absolute Number of the dep *)
			numDepSplitted[[i]],
			(* options *)
			Table[options,
			      {i,1,Length[splittedListDep[[i]]]}]}]],
		     {}]];
	 absoluteNumDep = absoluteNumDep+Length[splittedListDep[[i]]],
	 {i,1,6}];
       matDep=matDepTemp;
     

       (* addition of other constraints *)
       Check[
	 matAddedConstraints =        
	   If[options[[5]]==={},{},
             addedConstraints = 
             Apply[Join,
               MapThread[readOneConstr,
                 {options[[5]], Table[line0,{i,1,Length[options[[5]]]}],
                  Table[numInstrVar,{i,1,Length[options[[5]]]}],
                  Table[options,{i,1,Length[options[[5]]]}]}]
             ];
             If[options[[2]],
               Print[Length[addedConstraints], 
               " Recognized added Constraints: "];
               printAllConstraint[addedConstraints, 
                 refline, 
                 numInstrVar,
                 splittedListDep,
                 options
               ]
             ];
           addedConstraints
         ],
       Schedule::addconserror = "error while analyzing additional constraints";
       Throw[ Message[Schedule::addconserror] ];
     ];

       If [(options[[8]]=== sameLinearPart)||
	     (options[[8]]===sameLinearPartExceptParam) (* unique linear part *),
	   schedTypeAddConstraints=addConstSchedType[paramSpace,
						     line0,
						     options],
	 schedTypeAddConstraints={}];
       
       (**************** BUILDING THE CONSTRAINTS MATRIX ******)

       finalMat= Join[  matLocalPos  ,
		      matOutputPos , 
		      matInputPos ,
		      matOutputObj , 
		      matDep ,
		      matAddedConstraints,
		      schedTypeAddConstraints]

     ]

makeTableEq[a___]:= (Message[makeTableEq::WrongPar,a];
		     Throw[$Failed])

Clear[makeEpsilonConstraint]

makeEpsilonConstraint[line0_List,
		      options_List]:= 
  Module[{line1,allLines},
	 (* First we set the constraint: 
	    \sigma = G  - \Sigma(\epsilon_i),
	    then we set \epsilon_i <= 1 *)
	   allLines = {} ;
	 line1 = line0;
	 (* \sigma *)
	 line1 = ReplacePart[line1,1,{1,1}];
	 Do[line1 = ReplacePart[line1,1,{1,i}] (* + epsilon *),
	    {i,2,Length[line0[[1]]]}];
	 (* -10000 for -G *)
	 line1=ReplacePart[line1,-10000,{7,1}];
	 allLines=Append[allLines,line1];

	 Do[line1=line0;
	    (* - epsilon *)
	      line1 = ReplacePart[line1,-1,{1,i}];
	    (* +1 *)
		line1 = ReplacePart[line1,1,{7,1}];
	    (* >= 0 *)
		  line1 = ReplacePart[line1,1,{8,1}];
	    allLines=Append[allLines,line1],
	    {i,2,Length[line0[[1]]]}];
	 allLines]
	

	 
		      

(* makePositivityConstraint ensure the positivity condition: 
   ***** FARKAS RECALL *************************

   T_{numInstr}[i,j,N] >= 0 on dom1 

   dom1 is expressed by A[i,j,N] >= 0 

   Farkas says : 
  ( \exists x >= 0 / Ax = b ) <=> (\forall y , yA >= 0 => yb >= 0)

   We use it as : 
   ( \exists x >= 0 / xA = b ) <=> (\forall y , Ay >= 0 => by >= 0)
   

   In fact we use the affine form : 
   D= Ax + b >= 0, f(x)=Tx+t
   f(x) is positive on D if and only if there exists L, l such that 
   (T t) = (L)(A b) + l  <=> (T t) - (L)(A b) - l = 0 
   
   we introduce the farkas multiplieur and write, for each domension 
   of the tau an equality 
*)

Clear[makePositivityConstraint]

makePositivityConstraint[numInstr_Integer,
			 dom1_Alpha`domain,
			 line0_List,
			 numInstrVar_List,
			 options_List]:=
Module[{line1,nbIn,nbOut,nbLoc,relativeNum,locOutIn,relativePosition,dim1,
	constraints,columnk,finalMat,listGivenVar,listGivenNum},
       nbLoc=Length[line0[[2,1]]];
       nbOut=Length[line0[[2,2]]];
       nbIn=Length[line0[[2,3]]];

       (* First check that the schedule is not given *)
	 If [options[[11]] =!= {},
	     (* Options[[11]] is a list of 
		{"nameVAr",{},sched[{1,2,3},3],sched[....]}} *)
	     listGivenVar = Map[First,options[[11]]];
	     listGivenNum = Map[Part[#,2] &,
				Select[numInstrVar,
				       MemberQ[listGivenVar,First[#]] &]];

	     If [MemberQ[listGivenNum,numInstr],
		 (* No need to add positivity constraints *)
		 Return[{}]]];

       (* else building the positivity constraint *)
	   
	   
	   (* integer indicating of the variable is input, output 
	      or local *)
       relativePosition =getRelativeNum[numInstr,
					numInstrVar,
					line0];
       locOutIn= relativePosition[[1]];
       relativeNum = relativePosition[[2]];

       dim1=Part[dom1,1];
       finalMat={};
       constraints=dom1[[3,1,5]];
       (* Here we must write the constraints in the form 
	  Ax + b >= 0, hence we must split the equality *)
	 
	 constraints2=Flatten[Map[If [Part[#,1]===0,
				      {Drop[#,1],-Drop[#,1]},
				      {Drop[#,1]}] &,
				  constraints],
			      1];
       
       
       (*  Loop : for each dimension k add an equality *)
	   Do [
	     line1=line0;
	     (* the coef of tau_k is one *)
	       line1 = ReplacePart[line1,1,{2,locOutIn,relativeNum,k}];
	     (* get the coef of the Mu, i.e column k of the 
		constraint matrix *)
		 columnk=Map[Part[#,k] &,constraints2];
	     line1 = ReplacePart[line1,
				 -Append[columnk,0] 
				 (* for the lam_0 *),
				 {5,locOutIn,relativeNum}];
	     
	     (* equality *)
	       line1 = ReplacePart[line1,0,{8,1}];
	     line1 = ReplacePart[line1,0,{7,1}];  
	     finalMat=Append[finalMat,line1];
	     ,
	     {k,1,dim1} ];
       
       (* Constant Part Now : remains to add the Lam_0
	  coeff in last eq *)
	     line1=line0;
       (* alpha + ... *)
	       line1 = ReplacePart[line1,1,{3,locOutIn,relativeNum}];
       columnk=Map[Part[#,dim1+1] &,constraints2];
       line1 = ReplacePart[line1,
			   -Append[columnk,1 (* for the Lam 0 *)], 
			   {5,locOutIn,relativeNum}];
       line1 = ReplacePart[line1,0,{8,1}];
       (* Constant *)
	 line1 = ReplacePart[line1,0,{7,1}];  
       finalMat=Append[finalMat,line1];  
       finalMat
 
       ]

makePositivityConstraint[a___]:=
  (Message[makePositivityConstraint::WrongArg,a];
   Throw[$Failed])

(* makeObjFunctionConstraint ensure the condition that 
   the objective function is greater than the time function of the ouput
   ***** FARKAS RECALL *************************
   For each output O
   phi[N] + phi_0 - T_{numO}[i,j,N] >= 0 on dom_O 

   dom_0 is expressed by A[i,j,N] + b>= 0 

   T(x)+t is positive on D if and only if there exists L, l such that 
   (T t) - (L)(A b) - l = 0 
   
   we introduce the farkas multiplieur rho and write, for each domension 
   of the tau an equality 
*)


Clear[makeObjFunctionConstraint]

makeObjFunctionConstraint[numInstr_Integer,
			 dom1_Alpha`domain,
			  numInstrVar_List,
			 line0_List]:=
Module[{line1,nbIn,nbOut,nbLoc,relativeNum,locOutIn,dim1,relativePosition,
	constraints,columnk,finalMat,nbPhi},
       nbLoc=Length[line0[[2,1]]];
       nbOut=Length[line0[[2,2]]];
       nbIn=Length[line0[[2,3]]];


       (* integer indicating of the variable is input, output 
	  or local *)
	 relativePosition =getRelativeNum[numInstr,
					  numInstrVar,
					  line0];
       locOutIn= relativePosition[[1]];
       relativeNum = relativePosition[[2]];
       If [locOutIn =!= 2, 
	   Message[makeObjFunctionConstraint::InputVAr]];



       dim1=Part[dom1,1];
       finalMat={};
       (* A VOIR *)
       nbPhi=Length[line0[[1]]];
       constraints=dom1[[3,1,5]];
       (* Here we must write the constraints in the form 
	  Ax + b >= 0, hence we must split the equality *)

	 constraints2=Flatten[Map[If [Part[#,1]===0,
				      {Drop[#,1],-Drop[#,1]},
				      {Drop[#,1]}] &,
				  constraints],
			      1];
			      
			      
       (*  Loop : for each dimension k add an equality *)
	 Do [
	          line1=line0;
		  (* the coef of tau_k is - one *)
		  line1 = ReplacePart[line1,-1,{2,locOutIn,relativeNum,k}];
		  (* get the coef of the Rho, i.e column k of the 
		     constraint matrix *)
		    columnk=Map[Part[#,k] &,constraints2];
		  line1 = ReplacePart[line1,
				      -Append[columnk,0] 
				      (* for the lam_0 *),
				      {6,locOutIn,relativeNum}];
		  

		  If [dim1-nbPhi+2<=k<=dim1,
		      (* Coef of Phi is one *)
			line1 = ReplacePart[line1,1,{1,k-(dim1-nbPhi+1)}];
		    ];
		  (* equality *)
		    line1 = ReplacePart[line1,0,{8,1}];
		  (* constant *)
		      line1 = ReplacePart[line1,0,{7,1}];  
		  finalMat=Append[finalMat,line1];
		  ,
		  {k,1,dim1} ];

       (* Constant Part Now : remains to add the Lam_0
	  coeff in last eq *)
	   line1=line0;
       (* Phi_0 + ... *)
	     line1 = ReplacePart[line1,1,{1,nbPhi}];
       (* - alpha + ... *)
       line1 = ReplacePart[line1,-1,{3,locOutIn,relativeNum}];
       columnk=Map[Part[#,dim1+1] &,constraints2];
       line1 = ReplacePart[line1,
			   -Append[columnk,1 (* for the rho 0 *)], 
			   {6,locOutIn,relativeNum}];
       (* equlity *)
       line1 = ReplacePart[line1,0,{8,1}];
       (* Constant *)
	 line1 = ReplacePart[line1,0,{7,1}];  
       finalMat=Append[finalMat,line1];  
       
       finalMat
       ]




makeObjFunctionConstraint[a___]:=
  (Message[makeObjFunctionConstraint::WrongArg,a];
   Throw[$Failed])

(* makeDepConstraint ensure the condition that 
   the depandance A[i,j,k] <- B[f[i,j,k]] is ensured on the domain
   dom_dep of the dependance   on
   which it happens by the relation :
   TA[i,j,k] - TB[f(i,j,k)] - duration_dep >= 0 on dom_dep= Ax + b >= 0
   ***** FARKAS RECALL *************************
   For each output dep

   T(x)+t is positive on D if and only if there exists L, l such that 
   (T t) - (L)(A b) - l = 0 

   Here we must have
                                
   (T_goal t_s) - (T_source t_s)(D d) - duration - L (A b) - l = 0

   we introduce the farkas multiplieur Lambda and write, for each domension 
   of the tau an equality 

   Warning, in the makeComstraint function, some coefficient of the LP
   can be modified by two sources : when A depnds of A, this
   coefficients are the coeffs of the Tau and alpha (hence we must not
   use the ReplacePart on line1 stupidely )
   

*)


Clear[makeDepConstraint]

makeDepConstraint[dep1_depend,
		  line0_List,
		  instrList_List,
		  duration_List,
		  relativeNumDep_Integer,
		  absoluteNumDep_Integer,
		  options_List]:=
Module[{line1,nbIn,nbOut,nbLoc,dim1,nameInstrSource,nameInstrGoal,
	numInstrSource, numInstrGoal,locOutInSource,relativeNumSource,
	locOutInGoal,relativePositionSource,relativePositionGoal,
	relativeNumGoal,typeDep,dom1,k,goalGiven,sourceGiven,
	goalSchedVectGiven,goalSchedVect,goalConstant,sourceSchedVectGiven,
	sourceSchedVect,sourceConstant,listGivenVar,
	constraints,columnk,finalMat, matDep,colDep,depthSched},

       nbLoc=Length[line0[[2,1]]];
       nbOut=Length[line0[[2,2]]];
       nbIn=Length[line0[[2,3]]];
       nameInstrSource = dep1[[3]];
       nameInstrGoal = dep1[[2]];

      (* debug:
	 Print["depend: ",nameInstrSource,"-->",nameInstrGoal," with mat :"];
	 show[dep1[[4]]];  *)

       varSource= Select[instrList,
			 Part[#,1]===nameInstrSource &];
       If [varSource === {},
	   Message[makeDepConstraint::pb2];Throw[$Failed],
	   numInstrSource = varSource[[1,2]]];

       varGoal = Select[instrList,
			 Part[#,1]===nameInstrGoal &];
       If [varGoal === {},
	   Message[makeDepConstraint::pb3];Throw[$Failed],
	   numInstrGoal = varGoal[[1,2]]];
				
       (* locOutInSource:  Integer indicating if the source
	  is an input (3) , output(2) or local(1)
	   relativeNumSource: Integer i indicating the i^th such 
	   variable (for example the i^th input *)


	 relativePositionSource =getRelativeNum[numInstrSource,
						instrList,
						line0];
       locOutInSource= relativePositionSource[[1]];
       relativeNumSource = relativePositionSource[[2]];
       
       relativePositionGoal =getRelativeNum[numInstrGoal,
					    instrList,
					    line0];
       locOutInGoal= relativePositionGoal[[1]];
       relativeNumGoal = relativePositionGoal[[2]];
       
   
       (* Select the dependance type, which gives in which 
	  part of line0[[4]] the Lambda coeffs will be sets *)
 
       If [(locOutInSource === 3) && (locOutInGoal === 2),
	   (* In to Out *) 
	     typeDep=2];
       If [(locOutInSource === 3) && (locOutInGoal  === 1),
	   (* In to Loc *) 
	     typeDep=4];
       If [(locOutInSource === 2) && (locOutInGoal  === 2),
	   (* Out to Out *) 
	   typeDep=6];
       If [(locOutInSource === 2) && (locOutInGoal === 1),
	   (* Out to Loc *) 
	     typeDep=3];
       If [(locOutInSource === 1) && (locOutInGoal === 2),
	   (* Loc to Out *) 
	     typeDep=1];
       If [(locOutInSource === 1) && (locOutInGoal === 1),
	   (* Loc to Loc *) 
	     typeDep=5];


       goalGiven = False;
       sourceGiven = False;
       (* First check that the schedule is not given *)
	 If [options[[11]] =!= {},
	     (* Options[[11]] is a list of {"nameVAr",{{1,2,3},3}} *)
	     listGivenVar = Map[First,options[[11]]];
	     If [options[[9]]===multi, (* multidimensionnel
					     sched *)
		   depthSched = options[[16]],
		 depthSched = 1];

	     If [MemberQ[listGivenVar,nameInstrGoal],
		 goalGiven = True;
		 goalSchedVectGiven = 
		   Select[options[[11]],First[#]===nameInstrGoal &];
		 If [goalSchedVectGiven==={},
		     Message[makeDepConstraint::internalError];
		     Throw[$Failed],
		     If [length[goalSchedVectGiven[[1]]]
			 <2+depthSched,
			 Message[makeDepConstraint::WrongDimSched],
			 goalSchedVectGiven[[1]];
			 Throw[$Failed],
			 goalSchedVect = 
			   goalSchedVectGiven[[1,2+depthSched,1]];
			 goalConstant = 
			   goalSchedVectGiven[[1,2+depthSched,2]]];
		     
		     If [Length[goalSchedVect]=!=
			   Length[line0[[2,locOutInGoal,relativeNumGoal]]],
			 Message[makeDepConstraint::wrongSchedVectGiven];
			 Throw[$Failed]];
		       ]];
	     If [MemberQ[listGivenVar,nameInstrSource],
		 sourceGiven = True;
		 sourceSchedVectGiven = 
		   Select[options[[11]],First[#]===nameInstrSource &];
		 If [sourceSchedVectGiven==={},
		     Message[makeDepConstraint::internalError];
		     Throw[$Failed],
		     If [length[sourceSchedVectGiven[[1]]]
			 <2+depthSched,
			 Message[makeDepConstraint::WrongDimSched],
			 sourceSchedVectGiven[[1]];
			 Throw[$Failed],
			 sourceSchedVect = 
			   sourceSchedVectGiven[[1,2+depthSched,1]];
			 sourceConstant = 
			   sourceSchedVectGiven[[1,2+depthSched,2]]];
		   ]];
	   ];


       dom1 = dep1[[1]];
       dim1=Part[dom1,1];
       finalMat={};
       constraints=dom1[[3,1,5]];
       (* Here we must write the constraints in the form 
	  Ax + b >= 0, hence we must split the equality *)

	 constraints2=Flatten[Map[If [Part[#,1]===0,
				      {Drop[#,1],-Drop[#,1]},
				      {Drop[#,1]}] &,
				  constraints],
			      1];
			      
       (* debug Print["on ",constraints2];	    *) 
       (* (T_goal t_s) - (T_source t_s)(D d) - duration - L (A b) - lam_0
				      = 0 *)

	   (* Matrix of the dependance *)
	   matDep=dep1[[4,4]];

       If [Length[matDep]-1=!=
	     Length[line0[[2,locOutInSource,relativeNumSource]]],
	   Message[makeDepConstraint::Pb1];Throw[$Failed]];
       If [Length[matDep[[1]]]-1=!=
	     Length[line0[[2,locOutInGoal,relativeNumGoal]]],
	   Message[makeDepConstraint::Pb1bis];Throw[$Failed]];

       (*  Loop : for each dimension k add an equality *)
	 Do [ line1=line0;
	      (* the coef of tau_goal is  one *)
		If [!goalGiven,
		    line1 = 
		      ReplacePart[line1,
				  line1[[2,locOutInGoal,relativeNumGoal,k]]+1,
				  {2,locOutInGoal,relativeNumGoal,k}],
		    line1=ReplacePart[line1,
				  line1[[7,1]]+goalSchedVect[[k]],
				  {7,1}]];

		    (* get the coef of the Lambda, i.e column k of the 
		 constraint matrix *)
		  columnk=Map[Part[#,k] &,constraints2];
	      line1 = ReplacePart[line1,
				  -Append[columnk,0] 
				  (* 0 for the lam_0 *),
				  {4,typeDep,relativeNumDep}];
	      
	      (* The coef of tau_source are -(the k^th column of 
		 the Dependance matrix) *)
		colDep = Map[Part[#,k] &,matDep];

		If [!sourceGiven,
		    line1 = ReplacePart[line1,
					Plus[line1[[2,
						    locOutInSource,
						    relativeNumSource]],
					     -Drop[colDep,-1]
					     (* Drop the constant Term *)
					       (* Plus is   listable *)], 
					{2,locOutInSource,relativeNumSource}],
		    line1 = ReplacePart[line1,
					line1[[7,1]]+ 
					  Dot[sourceSchedVect,
					     -Drop[colDep,-1]],
					     (* Drop the constant Term *)
					{7,1}]];
		    
		    
	      (* equality *)
		line1 = ReplacePart[line1,0,{8,1}];
	      (* constant : nul *)

	      (*  Print["domain: ",constraints2];
		  Print["line1[[4,",typeDep,"]]",line1[[4,typeDep]]]; 
		  Print["line1 : ", line1]; *)
		    finalMat=Append[finalMat,line1],
	      {k,1,dim1} ];
       
       (* Constant Part Now : remains to add the Lam_0
	  coeff in last eq *)
	   line1=line0;
       (* + alpha_goal + ... *)
	     If [!goalGiven,
		 line1 = ReplacePart[line1,
				     line1[[3,locOutInGoal,relativeNumGoal]]+1,
				     {3,locOutInGoal,relativeNumGoal}],
		 line1 = ReplacePart[line1,
				     line1[[7,1]]+goalConstant,
				     {7,1}]];
		 
       columnk=Map[Part[#,dim1+1] &,constraints2];
       (* Lambda coefs - (L l)b -Lam_0*)
       line1 = ReplacePart[line1,
			   -Append[columnk,1 (* for the Lam 0 *)], 
			   {4,typeDep,relativeNumDep}];
       (* -(Tau_source t_s)(d)  *) 
	 colDep = Map[Part[#,dim1+1] &,matDep];
          If [!sourceGiven,
	      line1 = ReplacePart[line1,
				  Plus[line1[[2,
					      locOutInSource,
					      relativeNumSource]],
				       -Drop[colDep,-1]
				       (* Drop the constant Term *)
					 (* Plus is   listable *)], 
				  {2,locOutInSource,relativeNumSource}],
	      line1 = ReplacePart[line1,
				  line1[[7,1]]+
				    Dot[sourceSchedVect,
					-Drop[colDep,-1]],
				       (* Drop the constant Term *)
				  {7,1}]];
	      


	      (* -alpha_source *)
          If [!sourceGiven,
	      line1 =
		ReplacePart[line1,
			    line1[[3,locOutInSource,relativeNumSource]]-1,
			    {3,locOutInSource,relativeNumSource}],
	      line1 =
		ReplacePart[line1,
			    line1[[7,1]]-sourceConstant,
			    {7,1}]];
	      
	      (* equlity *)
		  line1 = ReplacePart[line1,0,{8,1}];
       (* - duration, if the schedule is multidimensionnal, 
	  it is -duration*\epsilon_{numDep+1} except if the duration
          is 0 in which case it is -\epsilon_{numDep+1} *)
		    If [(options[[9]]===multi),
			(* multidim *)
			  If [Length[line1[[1]]]<absoluteNumDep,
			      Message[makeDepConstraint::pb4];
			      Throw[$Failed],
			      Switch[duration[[numInstrGoal]],
				    0,
				    (* - epsilon *)
				    line1 =
				      ReplacePart[line1,
						  line1[[1,absoluteNumDep+1]]
						  -1,
						  {1,absoluteNumDep+1}],
				    _, 
				    (* - duration*epsilon *)
				     line1 =
					ReplacePart[line1,
						    line1[[1,absoluteNumDep+1]]
						    -duration[[numInstrGoal]],
						    {1,absoluteNumDep+1}]]],
			(* non multidim *)
			    line1 = ReplacePart[line1,
						line1[[7,1]]
						-duration[[numInstrGoal]],
						{7,1}]];  
       finalMat=Append[finalMat,line1];  

        (* Print["domain: ",constraints2];
       Print["line1 : ", line1];
       Print["line1[[4,",typeDep,"]]",line1[[4,typeDep]]]; *)
       finalMat
       ]

			 
makeDepConstraint[a___]:=
  (Message[makeDepConstraint::WrongArg,a];
   Throw[$Failed])

Clear[getRelativeNum];

getRelativeNum[nameInstr_String,numInstrVar_List,line0_List]:=
Module[{coupleInstrList,numInstr},
  coupleInstrList = Select[numInstrVar,Part[#,1]===nameInstr &];

  If[ !(Length[coupleInstrList]>0),
    Message[getRelativeNum::NameNotFound,nameInstr];
    Throw[$Failed],
    numInstr = coupleInstrList[[1,2]];
    getRelativeNum[numInstr,numInstrVar,line0]
  ]
];

getRelativeNum[numInstr_Integer,numInstrVar_List,line0_List]:=
Module[
  {rankOfVar,rankOfVarList,nbIn,nbOut,nbLoc,locOutIn,relativeNum},

  (* rank is the rank in nimInstrVar *)
  rankOfVarList = Position[Map[Part[#,2] &,numInstrVar],numInstr];

  If[ !(Length[rankOfVarList]>0),
    Message[getRelativeNum::NumNotFound,numInstr];Throw[$Failed],
     rankOfVar = rankOfVarList[[1,1]];
     nbLoc=Length[line0[[2,1]]];
     nbOut=Length[line0[[2,2]]];
     nbIn=Length[line0[[2,3]]];

     (* locOutIn:  Integer indicating if the source
	is an input (3) , output(2) or local(1)
	relativeNum: Integer i indicating the i^th such 
	variable (for example the i^th input *)
    If[ rankOfVar <= nbIn, 
      locOutIn=3; relativeNum=rankOfVar,
      If[ nbIn < rankOfVar <= nbIn+nbOut,
        locOutIn=2; relativeNum=rankOfVar-nbIn,
        If[ nbIn+nbOut < rankOfVar <= nbIn+nbOut+nbLoc, 
          locOutIn=1; relativeNum=rankOfVar-nbIn-nbOut
        ,
          Message[getRelativeNum::M1,numInstr];Throw[$Failed]
        ]
      ]
    ]
  ];
  {locOutIn,relativeNum}
];

getRelativeNum[a___]:=
  (Message[getRelativeNum::WrongArg,a];
   Throw[$Failed])

Clear[getDomainOfVar];

getDomainOfVar[sys_Alpha`system,numInstr_Integer]:= 
  Module[{nbIn,nbOut,nbLoc,res},
	 nbIn = Length[sys[[3]]];
	 nbOut = Length[sys[[4]]];
	 nbLoc = Length[sys[[5]]];
	 If [1<= numInstr <= nbIn,
	     res = sys[[3,numInstr-nbIn,3]],
	     	 If [nbIn+1<= numInstr <= nbIn+nbOut,
		     res = sys[[4,numInstr,3]],
		     If [nbIn+nbOut+1<= numInstr <= nbIn+nbOut+nbLoc,
			 res = sys[[5,numInstr-nbIn-nbOut,3]],
			 Message[getDomainOfVar::error,numInstr];
			 Throw[$Failed]]]];
	 res]

getDomainOfVar[sys_Alpha`system,nameInstr_String]:= 
  Module[{res},
	 res=Part[getDeclaration[sys,nameInstr],3]]
	 

getDomainOfVar[a___]:=
  (Message[getDomainOfVar::WrongArg,a];
   Throw[$Failed])

Clear[addConstSchedType]

addConstSchedType[paramSpace_Alpha`domain,
		  line0_List,
		  options_List]:=
  Module[{nbLocalVars,nbDim,nbParam, upperBound,newConstraints,line1 },
	 nbLocalVars = Length[line0[[2,1]]];
	 nbDim = Length[line0[[2,1,1]]];
	 nbParam = paramSpace[[1]];
	 (* upperBound represent the number of indices 
	    on which the simgle linear part constraint is 
	    enforced *)
	 upperBound = If [options[[8]]===sameLinearPart,nbDim,nbDim-nbParam];
	 newConstraints = {};
	 If [nbLocalVars>1,
	     Do [
	       Do[ line1=line0;
		   (* for each dim i *) 
		     (* Tau_curVar_i = Tau_1_i *)
		     line1 = ReplacePart[line1,-1,{2,1,1,i}];
		   line1 = ReplacePart[line1,1,{2,1,curVar,i}];
		   (* equality *)
		     line1 = ReplacePart[line1,0,{8,1}];
		   newConstraints = Append[newConstraints,line1]
		   ,
		   {i,1,upperBound}]
	       ,
	       {curVar,2,nbLocalVars}];
	   ];
	 newConstraints]

addConstSchedType[a___]:=(Message[addConstSchedType::WrongArg,a];
			  Throw[$Failed])



Clear[checkLine]
checkLine[line1_List,line0_List]:=
  Module[{lTemp,res},
	 res=True;
	 (* Taus *)
	 lTemp = MapThread[SameQ,{Map[Length,line1[[2,1]]],
				  Map[Length,line0[[2,1]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err1];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[2,2]]],
				  Map[Length,line0[[2,2]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err2];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[2,3]]],
				  Map[Length,line0[[2,3]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err3];res=False;Print[lTemp]];
	 (* alphas *)
	   If [Length[line1[[4]]]=!=Length[line0[[3,1]]],
	       Message[checkLine::err4];res=False];
	   If [Length[line1[[5]]]=!=Length[line0[[3,2]]],
	       Message[checkLine::err5];res=False];
	   If [Length[line1[[6]]]=!=Length[line0[[3,3]]],
	       Message[checkLine::err6];res=False];
	 (* Farkas Lam*)
	 lTemp = MapThread[SameQ,{Map[Length,line1[[4,1]]],
				  Map[Length,line0[[4,1]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err7];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[4,2]]],
				  Map[Length,line0[[4,2]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err8];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[4,3]]],
				  Map[Length,line0[[4,3]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err9];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[4,4]]],
				  Map[Length,line0[[4,4]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err10];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[4,5]]],
				  Map[Length,line0[[4,5]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err11];res=False;Print[lTemp]];
	 (* Farkas Mu *)

	 lTemp = MapThread[SameQ,{Map[Length,line1[[5,1]]],
				  Map[Length,line0[[5,1]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err12];res=False;Print[lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[5,2]]],
				  Map[Length,line0[[5,2]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err13];res=False;
	     Print["lTemp=",lTemp]];
	 lTemp = MapThread[SameQ,{Map[Length,line1[[5,3]]],
				  Map[Length,line0[[5,3]]]}];
	 If [Apply[And,lTemp]=!= True,
	     Message[checkLine::err14];res=False;Print[lTemp]];

	 res
       ]

checkLine[a___]:=Message[checkLine::WrongArg,a]



(*  FICHIER PIP IS TEMPORARILY COPIED HERE *)

(**************************       fichierPip         **************************
**
**
**        Take <table_eq>,  <refline>
**
**        
**
**        Write the file "fichier$USER.pip". This is the entry file for "PIP"
**         . The line are all terminates by " \ ". 
**
******************************************************************************)


Clear[fichierPip];
fichierPip[ fich_String,mat_, refline_,options_List] :=
  Module[{matrice,fichInput1,fichInput2,fichOutput,result,
    matrice2,silentOrNot,dir,command,timePip,dbg},

     dbg = False; (* Force or not debug option *)
     If[ dbg, Print["fichier: ", fich]];
     fichInput1 = fich<>".pip";
	 If[ dbg, Print["fichier input 1: ", fichInput1]];
     fichInput2 = fich<>"2.pip";
     fichOutput = fich<>".pipres";

    (*
    Print["Fichier Input 1: ", fichInput1 ];
    Print["Fichier Input 2: ", fichInput2 ];
    Print["Fichier Output: ", fichOutput ];
     *)

    matrice = matPip[mat,options];
	 
    Check[ writeFile[ fichInput1, matrice, refline, options], 
      Print[ "File fichInput1 was not written !" ]];
    If[ dbg, Print[ FileInformation[ fichInput1 ] ] ];
	 
    (* options[[2]] is verbose *)
    If[(options[[2]])||options[[1]],
	   Print["Solving the LP..."]];

    Which[
      $OperatingSystem === "Unix" || $OperatingSystem ==="MacOSX",
      Run["sed -f "<>Environment["MMALPHA"]<>"/sources/Sed/sup_antislash_pip.sed "<>fichInput1<>" > "<>fichInput2]
    ,
      $OperatingSystem == "WindowsNT" || $OperatingSystem == "MSDOS",
      command="sed.exe -f "<>Environment["MMALPHA"]
         <>"/sources/Sed/sup_antislash_pip.sed "
	 <>fichInput1<>" > "<>fichInput2;
      Print["Wrong command:", command];
      command="sed.exe -f sup_antislash_pip.sed "
        <>fichInput1<>" > "<>fichInput2;
      Print["Executing : ", command];
      dir=Directory[];
      SetDirectory[Environment["MMALPHA"]<>"/sources/Sed/"];
      Print["In directory: ", Directory[] ];
      Run[command];
      SetDirectory[dir]
    ];

    (* Remove input file if not debug *)
    If[ !options[[1]], DeleteFile[fichInput1] ]; 

    (* If verbose, then run Pip with option -s *)	
    If[ !options[[2]], silentOrNot=" -s ", silentOrNot="  "]; 

    (* 
     Always keep the silent option, otherwise, this pollutes the shell
     *)
    silentOrNot = " -s ";
	
    timePip = 
    Timing[
      Which[
        $OperatingSystem === "Unix" || $OperatingSystem ==="MacOSX",
        Run["pip "<>silentOrNot<>fichInput2<>" > "<>fichOutput]
      ,
        $OperatingSystem == "WindowsNT"||$OperatingSystem == "MSDOS",
        Run["dos2unix "<>fichInput2];
		Run["pip.exe "<>silentOrNot<>fichInput2<>" > "<>fichOutput]
      ]
    ];
	
    If[ dbg, Print[ FileInformation[ fichOutput ] ] ];

(*
	If [True (* options[[2]] *),
	 Print["******************************* \n
                 PIP time ", First[timePip]];
	 Print["******************************* \n"]];
*)

    (* Store the run time in $runTime *)
    (* Done July 10, 2004, PQ, to avoid a bug when $runTime is not
           set. Would be better to identify the origin of the bug... *)
    If[ !MatchQ[ $runTime, _List ], 
      Print["Warning: $runTime was set to {}"];$runTime = {}
    ];

    $runTime = Append[ $runTime, First[timePip] ]; (* Time *)
    $runTime = Prepend[ $runTime, First[$result] ]; (* Name *)
    $runTime = Append[ $runTime, "Farkas" ];  (* Signature *)

    result = readPipResult[ fichOutput, refline, options];

    (* If not debug mode, suppress the temp files *)

    If[ !dbg, 
      Run["rm "<>fichInput2]; 
      Run["rm "<>fichOutput],
      Print["File "<>fichInput1<>","<>fichInput2<>", "<>fichOutput<>" generated"]
    ]; 
	
  result
];

fichierPip[a___]:=(Message[fichierPip::WrongArg,a];
		   Throw[$Failed])

(**************************       matPip         *****************************
 **
 **    Take <table_eq>
 **
 **    Return the matrix which is the equation system to resolve 
 **      {{line1}, {line2}, ...}
 **       {linek} == {{{coefTauLoc1}, ....}
 **       The system is : linek >= 0 for all k 
 **
 ****************************************************************************)

Clear[matPip]

matPip[mat1_List,options_List]:=
  Module[{newmat},
	(* matPipOneEq returns a list of one or two lines
	   We Joins all these lines *)
	  newmat=Apply[Join,Map[matPipOneEq[#,options] &,mat1]];
	newmat]


Clear[matPipOneEq]

matPipOneEq[line_List,options_]:= 
  Module[{eqIneq,flatLine,line2,line3,line4,res},
	eqIneq=Part[Last[line],1];
	 (* Reverse the order of the timing functions *)
	  line2=ReplacePart[line,Map[Reverse,line[[2,1]]],{2,1}];
	  line3=ReplacePart[line2,Map[Reverse,line2[[2,2]]],{2,2}];
	  line4=ReplacePart[line3,Map[Reverse,line3[[2,3]]],{2,3}];
	 (* Last coef of line is the eq or Ineq flag *)
	  flatLine=Flatten[Drop[line4,-1]];
	res=testeqIneq[flatLine,eqIneq];
	res]

matPipOneEq[a___]:=(Message[matPipOneEq::WrongArg,a];
		    Throw[$Failed])


Clear[testeqIneq]

testeqIneq[line_, 0] := {line, -line} (* equation *)

testeqIneq[ line_, 1] := {line} (* Inequation : >= *)

testeqIneq[ line_, -1] := {line} (* Inequation : <= *)

testeqIneq[ line_, 2] := {}   (* case were a variable of the LP
					is positif. And with PIP all
					variable are positives by
					default. This constraints are
					obsolete *)

testeqIneq[a___]:= (Message[testeqIneq::WrongArg,a];Throw[$Failed])

(**************************       writeFile         *****************************
**
**      Take the out matrice of the function matPip.
**
**      Return nothing.
**
**      Write in the file : "fichier$USER.pip" the matrice corresponding 
**      at the first argument. This file is an entry file for PIP . 
**
******************************************************************************)

Clear[writeFile];

writeFile[ inputFile_String, matrice_, refline_,options_List] :=
Module[{Commentaire,firstTau,
  lastTauLoc,lastTauOut,lastTauIn,
  nn,nl,nm,np,bg,nq,temp,lastAlpha,
  file2,file3,tempFile2,tempFile3},

  Commentaire = ToString[refline];

  (* get the "abscisse" of the first coef of the Taus,
	  the last and the last of the Alphas *) 

  firstTau=refline[[1,1]]+1 (* params plus phi0 *);
	 
  lastTauLoc=firstTau+Apply[Plus,Map[Part[#,2] &,refline[[2,1]]]]-1;
  lastTauOut=lastTauLoc+Apply[Plus,Map[Part[#,2] &,refline[[2,2]]]];
  lastTauIn=lastTauOut+Apply[Plus,Map[Part[#,2] &,refline[[2,3]]]];
  lastAlpha=lastTauIn+refline[[3,1,1]]+refline[[3,2,1]]+refline[[3,3,1]];
	 
       (* nn = Length[matrice[[1]]]-1; *)
	  nn = Length[matrice[[1]]]; 
      (* One Big parameter to allow Tau_i to be negative *)
       (* 1/09/98 after Dagsthul discussion : no big par but an 
	  additionnal shift variable (last variable)*)
       (* np = 1; 
	 np = 0;  *)
	    np = 0; 
       nl = Length[matrice];
     nm = 0;
      (* the BG is the last coeff of each line 
     bg =Length[matrice[[1]]]; 
       bg = -1; *)
       bg = -1;
       (* Integer solution nq=1*)
       If [ options[[4]]===False,
	    nq = 0,
	    nq = 1];
       
      
      
      (*  Write the begining of the pip file. *)
	 
	 If [options[[1]],
	     Print["Opening: ",inputFile]];
       file = OpenWrite[inputFile];
       Write[file, OutputForm["((" <> Commentaire <>")"]];
       Write[file, nn, OutputForm[" "], np, OutputForm[" "], nl,
	     OutputForm[" "], nm, OutputForm[" "], bg, OutputForm[" "], nq]; 
       
       Write[file, OutputForm["("]];
       Close[file];
       
       (* write the matrice in the file file2 
	  At the end there is ")())". The last char of the entry file
	  to	 PIP *)
	 
	 file2  =getTemporaryName[];
       file3  = getTemporaryName[];
       
      If [options[[1]],
	  Print["Opening ",file2]];

      temp2 = OpenWrite[file2];
      writemat[temp2, matrice,firstTau,lastAlpha,options];

      Close[temp2];
      
      (* use sed to change :
	 
	 {  => #[
	 }  => ]
	 ,  =>    (space) 
	 
	 file : mat.tmp to mat2.tmp *)   
	
	If [options[[1]],
	    Print["Running sed process on ",file2," to ",file3]];

      
(* Trying to find a bug ... *)
        Which[
	  $OperatingSystem === "Unix"||$OperatingSystem ==="MacOSX",
	Run["sed -f $MMALPHA/sources/Sed/TransMatForPip.sed "<>file2<>" >" <> file3 ],
	(($OperatingSystem == "WindowsNT")||($OperatingSystem == "MSDOS")),
	  (*
      command="sed.exe -f "<>Environment["MMALPHA"]<>"/sources/Sed/TransMatForPip.sed "<>file2<>" >" <> file3;
*)
      command="sed.exe -f TransMatForPip.sed "<>file2<>" >" <> file3;
      Print["Command executed: ", command];
	      dir=Directory[];
	      SetDirectory[Environment["MMALPHA"]<>"/sources/Sed/"];
	      Run[command];
	      SetDirectory[dir]];

      (* Join the two file : fichier.pip which is the begin of the entry
	 file to PIP, and mat2.pip which is the matrix. *)
	
	If [options[[1]],
	    Print["Appending ",file3, " the end of ",inputFile]];
      Run["cat "<>file3<>" >> "<>inputFile];

	If [options[[1]],
             Print[file2, file3," generated"],
	    DeleteFile[file2];DeleteFile[file3];
	  ]
     ]

writeFile[___]:= Message[writeFile::WrongArg];

Clear[writemat]

(* For each line compute the coef of the Big Parameter,
   put this coef at the end of the line,
   write this line at the end of the file.
   After the last line, there is :    )()) *)

writemat[file_,mat_List,firstTau_Integer,lastAlpha_Integer,options_]:=
  Module[{indexMat},
        indexMat=Table[i,{i,1,Length[mat]}];
        MapThread[writematOneLine[file,#1,firstTau,lastAlpha,#2,options] &,
		  {mat,indexMat},1];
        PutAppend[")())", file]
      ]

writemat[a___]:= (Message[writemat::WrongArg,a];Throw[$Failed])


Clear[writematOneLine];

writematOneLine[file_,line_List,firstTau_Integer,
		lastAlpha_Integer,index_,options_]:=
  Module[{line2,coeffShift},
	 
	 coeffShift=evalcoefShift[line,firstTau,lastAlpha];
	 (* in multi dim sched case, \sigma the first obj function
	    variable is maximized,
	    hence it is \sigma' - G can be negative *) 
	   
	   coeffBG=0;
	   (* 01/09/98 After Dagsthul discussion, we decided 
	      that it is impossible to use big parameter for 
	      ensuring that the variable is positive, hence we will 
	      just add a "shift" variable such that the real 
	      value of a variable x will be x'-shift. hence, this 
	      evaluation of cieffBG will be in fact the coef of the x'
	      (common to every body). Hence we do not use any
		parameter
		in our LP, moreover, When I tried to use the big
		parameter to get a max instead of a min, I had problem
		hence, I use a constant for perfoming the change of
		basis sigma->G_sigma*)
	     line2=line;
	 line2 = Insert[line2, -coeffShift, -2]; 
	 
	 (* coeffBG = line[[1]] *)  
	   
	   PutAppend[line2, file];  
	 
	 If [(Mod[index,100]==0)&&(options[[2]]),
	     Print["Writing line ",index]];	 
      ];

writematOneLine[a___]:= (Message[writematOneLine::WrongArg,a];Throw[$Failed]);


Clear[evalcoefShift];

(* evaluate the sum of the coefficient of line which are situated 
    between first and last *)
evalcoefShift[line_List,first_Integer,last_Integer]:=
    If[(first>Length[line])||(last>Length[line]),
                 Print["ERROR in evalcoefShift (fichierPip)"],
                 Apply[Plus,Take[line,{first,last}]]]

evalcoefShift[___]:= Message[evalcoefShift::WrongArg]


(***********************************************************************)
(*                                                                     *)
(*             readPipResult                                           *)
(*                                                                     *)
(*                                                                     *)
(***********************************************************************)


(* 
	This function gets the result given by Pip for a LP 
	Problem generated for scheduling and writes it in a more
	easy-to-read Manner. The structure of the file is known, the 
	refline (indicating how many phi,tau,alpha,llambda,... are 
	present in the file) is given as second argument and 
	we should retrieve the value of the last variable to all taus
	and alphas 
*)

Clear[readPipResult];

readPipResult[ file_String, refline_List,
		(* {nbphi_List,nbTau_List,nbAlpha_List,rest___} *)
	      options_List ]:=
Module[{res,nbPhi,nbInstr,nbTotTau,listNegCoef,
  stream1,offset,offsetAlpha,res2,resBis,res1,posList,posTheList,dbg},
	 
  dbg = False; 
  If[ dbg, Print[" file: ", file ] ];
  If[ dbg, Print[" refline: ", refline ] ]; 
  nbPhi = refline[[1,1]];
  stream1 = OpenRead[file];
	 
  (* 
    res is a list containing the record encountered 
	the  record which indicates the beginning of the coefs 
	is {"List"}, the other are alternatively 
	{"\n"} and {"Nb1","Nb2"} where Nb1 is the coef of the Big Par
    and Nb2 is the coeff of the variable 
   *)
  res = ReadList[stream1,Word,
			RecordSeparators->{"#[","]",",","("},
			RecordLists->True];

  posList = Position[res,"list"];
  ReadPipResult::PipOutputError = " No schedule found, sorry	 ..." ;
  If[ Length[posList]=!=1,
	    Message[ReadPipResult::PipOutputError,posList];
	    Throw[$Failed]
  ];
	 
  posTheList=posList[[1,1]];
  res=Drop[res,posTheList];
  If[ Apply[Or,
		   Map[StringMatchQ[#1[[1]],"*newparm*"] &,
		       res]],
	     Message[readPipResult::newparmEncoutered];
	     Throw[$Failed]
  ];

  (* offset is the offset after what the coeff of the tau starts,
	it corresponds to the coeffs of the objective function but
	currently, there are no obective function 
  *)
	   
  offset=nbPhi+1;
  offsetAlpha=offset+
	   Apply[Plus,Map[Part[#,2] &,refline[[2,1]]]]+
	     Apply[Plus,Map[Part[#,2] &,refline[[2,2]]]]+
	       Apply[Plus,Map[Part[#,2] &,refline[[2,3]]]];
  offsetAll = offsetAlpha + refline[[3,1,1]]+
	      refline[[3,2,1]]+ refline[[3,3,1]];
  (* remove on element over two (which is {}) *)
		resBis= Map[First,Part[res,Table[2i-1,{i,1,Quotient[Length[res],2]}]]];
  listNegCoef = Select[Map[ToExpression ,resBis], Negative];
  If [Length[listNegCoef]>=1,
		   Print["WARNING: some coef of the PIP solution where
	 negative\n Please use the function checkSched to check the schedule"]];

  (* Here the res has the form 
	    {c1,c2,...,cn,shift} where shift should be
	    retreived to all variables , in the order:
	    Tau1i Tau1N Tau2i Tau2N...Alpha1 Alpha2... *)

  shiftCoef = ToExpression[Last[resBis]];
  If[ options[[1]], Print["Shift coef: ",shiftCoef] ];
  resBis = MapIndexed[If[offset <= First[#2]<= offsetAll,
			       ToExpression[#1]-shiftCoef,
			       ToExpression[#1]] &,resBis];
  Close[stream1];
  If[ Length[res]<6,
    If[ options[[2]],
      Print["\n\nNo schedule was found, sorry...\n\n"],
      Null
	],
	(* getting the coefficients of the Phi function 
	    The first Phi is the sigma (- sum of epsilon) in the
	 multidimentionnal case, we have previously donne the change
	 pf basis \sigma' = 10000 - \sigma, hence this bins.... 
	 WARNING, if you change the 10000 here do not forget to change
	 it before too ! this is awful and temporary 
	*)
    If[ options[[9]]===multi,
      res1 = Prepend[Take[resBis,{2,nbPhi}],-First[resBis]+10000],
	     (*else *)
      res1=Take[resBis,{1,nbPhi}]
    ];

    res2=
    printAllTau[resBis,offset,offsetAlpha,refline,1,options];
  {res1,res2}]
];

(*********** printAllTau ***************************)
(* Build the schedule from the stream, recursive, take as paramemter 
       the res_list  obtained from the Pip file, 
       the current offset of the current Tau in the res List, 
       The information present in refline about the current Tau
          ({num of current Tau, Dimension})
       The offset of the Alpha (constant terms) in res,
       The number of parameters

   return the schedule found in the form 
   <schedFoundList>
   <schedFound>={<TauFound>,<alphaFound>}
   <TauFound>= IntegerList
   <alphaFound= Integer
*)

Clear[printAllTau];

printAllTau[res_List,
	    offset_Integer,
	    offsetAlpha_Integer,
	    refline_List,
	    numInRefline_Integer,
	    options_List]:=
  Module[{newOffset,TauList,TauListExpr,alphaExpr,
	  alphaPos,otherResults,nb1,nb2,nb3,result},
	 (* extract one Tau *)
	  nb1=Length[refline[[2,1]]];
	 nb2=Length[refline[[2,2]]];
	 nb3=Length[refline[[2,3]]];

	 If [numInRefline > nb1+nb2+nb3,
	     result={},
	     dimCurVar= If [1<= numInRefline <= nb1,
			    refline[[2,1,numInRefline,2]],
			    If [1 <= numInRefline-nb1 <= nb2,
				refline[[2,2,numInRefline-nb1,2]],
				If [1 <= numInRefline - nb1 - nb2   <=   nb3,
				    refline[[2,3,numInRefline - nb1 - nb2,2]],
				    Message[printAllTau::err1]]]];
	     
	     {newOffset,TauList}=printOneTau[res,
					     offset,
					     dimCurVar,
					     options];
	     
	     TauListExpr=If [Length[TauList]>=1,
			     If [StringQ[First[TauList]],
				 Map[ToExpression,TauList],
				 TauList],
			     TauList];
	     
	     alphaPos=offsetAlpha+numInRefline-1;
	     
	     alphaExpr= If [StringQ[res[[alphaPos]]],
			    ToExpression[res[[alphaPos]]],
			    res[[alphaPos]]];
	     otherResults=printAllTau[res,
				      newOffset,
				      offsetAlpha,
				      refline,
				      numInRefline+1,
				      options];
	     result=Join[{{TauListExpr,alphaExpr}},otherResults]];
	 result

	   ]

	
  
  printAllTau[a___]:=
  Module[{},
	 Message[printAllTau::wrongP,a];
       ]

(* print the line of one tau *)
(*  one instance print one coordinate of one Tau *)
(* offset indicates the offset of current  Tau coordinate in res *)
(* return a pair:
   {the  offset of the next coordinate (or next tau),
   the list of the coordinates of Tau}   *)

Clear[printOneTau]

printOneTau[res_List,
	    offset_Integer,
	    numberDim_Integer,
	    options_List]:=
  Module[{invTauith,invTau,tauList},
	 invTau = Take[res,{offset,offset+numberDim-1}];
	 tauList = Reverse[invTau];
	 res1={offset+numberDim,tauList};
	 Return[res1]
       ]


  
  printOneTau[a___]:=
  Module[{},
	 Message[printOneTau::WrongArg,a];
       ]


(***********************************************************)
(*   Building the final sol                                *)
(*  
 for affine by variable schedule (scheduleType 1):      
   schedule[1,<schedOneVar>_List]
   with     <schedOneVar>={"nomVar",
	                   indiceList_List,
			   sched[<schedVect>_List,const_Integer]}
   
   for multidimensionnal schedule (not written yet), it should be:
   schedule[12,<schedOneVaMulti>_List]
   with     <schedOneVarMulti>={"nomVar",
	                   indiceList_List,
			   {sched[<schedVect>_List,const_Insteger],
			   sched[<schedVect>_List,const_Insteger],..}}
**********************************************************)

Clear[getFinalForm];

getFinalForm[schedResult_List, 
	     phiCoeffs_List,
	     numInstrVar_List,
	     {localDomains_List,
	      outputDomains_List,
	      inputDomains_List},
	     refline_List,
	     options_List]:=
Module[{scheduleList, nameVar,numVar,sched1,rankVarList},
       (* Here we suppose that the schedule vectors of schedResult
	  are in the order of the numInstrVar (increasing order) *)
	 
	 scheduleList= 
	   MapThread[getOneVarFinalSched,
		     {schedResult,
		      Join[inputDomains,outputDomains,localDomains],
		      Map[First,numInstrVar],
		      (* Temporary *)
		      Table[1,{i,1,Length[numInstrVar]}]}];

       (* setting the given sched vect *)
        If [options[[11]]=!= {},
	    Do [ nameVar=options[[11,i,1]];
		 (* numVar is the rank of the variable in numInstrVar *)
		   rankVarList=Position[Map[First,numInstrVar],nameVar];
		 If [!(Length[rankVarList]>0),
		     Message[getFinalForm::givenSchedPb],
		     numVar = rankVarList[[1,1]];
		     
		     sched1=options[[11,i,3]];
		     scheduleList = ReplacePart[scheduleList,
						sched1,
						{numVar,3}]],
		     {i,1,Length[options[[11]]]}];
	 
	  ];
	  Return[scheduleResult[1,scheduleList,phiCoeffs]]
     ]
	  
				     

getFinalForm[a___]:= Message[getFinalForm::WrongArg,a]




Clear[getOneVarFinalSched];

getOneVarFinalSched[schedule_List,
		    domVar_Alpha`domain,
		    nomVar_String,
		    scheduleType_Integer]:=
  Module[{indiceList,schedVect1,schedConst1,res1},
	 If [(scheduleType==1),
	     (* take the first sched vector, forget the others *)
	       indiceList=domVar[[2]];
	     schedVect1=schedule[[1]];
	     schedConst1=schedule[[2]];
	     res1={nomVar,
		   indiceList,
		   sched[schedVect1,schedConst1]} ];
	 res1]	    

getOneVarFinalSched[a___]:= Message[getOneVarFinalSched::WrongArg,a]




(* printOneConstraint Print one constraints in a readable form 
   Take as parameter:
   The constraint (strucutred as refline),
   the refline, the instrList, the dependance list 
 *)


Clear[printVarNameList]
printVarNameList[refline_List,instrList_List]:=
  Module[{numInstr, nameInstr,nameTauInstr,tauVector ,nameAlpha,
	 muVector,rhoVector , nameDep,nameFark,farkasVector, nbPhi,
	  phiVector,tauV,muV,rhoV,lamDepV,alphaV,finalV},
	 tauV={};
	 muV={};
	 rhoV={};
	 lamDepV={};
	 alphaV={};
	 (* for local, output, input *) 	   
	     Do[
		 (* for each variable *)
		   Do [
		     numInstr=refline[[2,locOutIn,numVar,1]];
		     (* get the number of the first instr in refline *)
		       
		       (* get its name *)
		       nameInstr=instrList[[numInstr,1]]; 
		     nameTauInstr = "T"<>ToString[nameInstr]<>"D";
		     tauVector=Table[nameTauInstr<>ToString[j],
				     {j,1, refline[[2,locOutIn,numVar,2]]}];
		     nameAlpha = "C"<>ToString[nameInstr];
		     muVector = Table["Mu"<>nameTauInstr<>ToString[j],
				     {j,1, refline[[5,locOutIn,numVar,2]]}];
		     rhoVector = Table["Rho"<>nameTauInstr<>ToString[j],
				     {j,1,
				      refline[[6,locOutIn,numVar,2]]}];
		     tauV=Join[tauV,tauVector];
		     muV=Join[muV,muVector];
		     rhoV=Join[rhoV,rhoVector];
		     alphaV=Join[alphaV,{nameAlpha}],
		     {numVar,1,Length[refline[[2,locOutIn]]]}],
	       {locOutIn,1,3}];
		 (* Now do it for the farkas coefs *)
	 Do[
		 (* for each dep *)
		   Do [
		     nameDep=refline[[4,farkasCoefType,numDep,1]];
		     (* get the number of the first instr in refline *)
		       
		       nameFark =
			 "LamDepT"<>ToString[farkasCoefType]
		     <>""<>ToString[nameDep]<>"";
		     farkasVector= Table[nameFark<>ToString[j],
			     {j,1,refline[[4,farkasCoefType,numDep,2]]}];
		     lamDepV=Join[lamDepV,farkasVector],
		     {numDep,1,Length[refline[[4,farkasCoefType]]]}],
	       {farkasCoefType,1,5}];

	 (* Coeffs of Phi and phi0 *)
	   nbPhi=refline[[1,1]];
	   phiVector=Table["Phi"<>ToString[j],{j,1,nbPhi-1}];
	 finalV=Join[phiVector,{"Phi0"},tauV ,alphaV,muV,rhoV,lamDepV];
	 finalV
	 
       ]

printVarNameList[a___]:= Message[printVarNameList::WrongArg];


Clear[printAllConstraint]

printAllConstraint[mat_List, 
		   refline_List, 
		   instrList_List,
		   depList_List,
		 options_List]:= 
  Module[{constraints,listVar1,posConstraints,strListVar,separIneq,
	  lpSolveProgram,schedulePolytope,strDom1},
	 (* We  print the list of variable only in the debug options
	    is set *)
	   listVar1=printVarNameList[refline,instrList];
	 strListVar=StringDrop[StringDrop[ToString[listVar1],1],-1];
	 separIneq=Which[options[[13]]===scheduleResult,","(*print on screen *),
			 True,";"];
	 constraints=
	   MapThread[printOneConstraint,
		     {mat,
		      Table[ refline, {i,1,Length[mat]}],
		      Table[ instrList, {i,1,Length[mat]}],
		      Table[ depList, {i,1,Length[mat]}],
		      Table[ separIneq, {i,1,Length[mat]}],
		      Table[ options, {i,1,Length[mat]}]}
		      ];
	 posConstraints=Map[StringJoin[ #, ">=0; "] &,
			    Select[listVar1,
				   And[Not[StringMatchQ[#,"T*D*"]],
				       Not[StringMatchQ[#,"C*"]]] &]];
	 Which[options[[13]]===lpSolve,
	       (* LP SOLVE PROGRAM *)
	       Print["LP SOLVE FORMAT, WARNING, some Variable may be negative "];
	       lpSolveProgram=StringJoin[
		 "min:",First[listVar1],";\n",
		 constraints,"int :",strListVar,";"];
	       Print[lpSolveProgram];
	       Print[First[listVar1]g,";"];
	       Map[Print,constraints];
	       Print["int :",strListVar,";"];
	       Throw[Alpha`lpProg[lpSolveProgram]],
	     
	       (* Schedule Polytope: ALPHA DOMAIN *)
	       options[[13]]===domain,
	       strDom1=StringJoin["{",strListVar,
				  "|",StringJoin[constraints],
				  StringDrop[StringJoin[posConstraints],-2],"}"];
	       Print[strDom1];
	       schedulePolytope=readDom[strDom1];
	       Print[strDom1];
	       Throw[schedulePolytope],

	       (* Simple printing on the screen for debugging *)
	       options[[13]]===scheduleResult,       (* Print[strListVar]; *)
	       Map[Print,constraints],
	       (* other options for outputForm *)
		  True,
	       val1=options[[13]];
	       Print[Context[val1]];
	       Message[printAllConstraint::NotImplemented,options[[13]]]];
       ]

 printAllConstraint::NotImplemented="Sorry, the value `1` of option 
ouputForm is not implemented"

printAllConstraint[a___]:= Message[printAllConstraint::WrongArg];


Clear[printOneConstraint]

printOneConstraint[constraint_List, 
		   refline_List, 
		   instrList_List,
		   depList_List,
		 separIneq_String,
		 options_List]:= 
  Module[{expr,alphaShift,locOutIn,numInstr,numVar,i,
	  nameInstr,nameTauInstr,tauVector,nameAlpha , 
	  tauCoefs,phiVector,phiCoefs,exprIPhi0,exprInPhi,
	  exprInTau,exprInAlpha,exprInVar,
	  muVector,  muCoefs,exprInMu,numDep,nameDep,
	  nameFark ,farkasVector,farkasCoefs,farkasCoefType,
	  exprInFarkas,constraintType,constantTerm,exprInRho,
	  rhoVector,rhoCoefs,nbPhi,res},
	 expr=0; (* expr is the left part of expr >= 0 
		    expressed by the constraint *)

	   nbPhi=refline[[1,1]];
	 alphaShift = nbPhi+
	     Apply[Plus,
			      Join[Map[Part[#,2] &,refline[[2,1]]],
				   Map[Part[#,2] &,refline[[2,2]]],
				   Map[Part[#,2] &,refline[[2,3]]]]];
	 (* for local, output, input *) 	   
	     Do[
		 (* for each variable *)
		   Do [
		     numInstr=refline[[2,locOutIn,numVar,1]];
		     (* get the number of the first instr in refline *)
		       
		       (* get its name *)
		       nameInstr=instrList[[numInstr,1]]; 
		     nameTauInstr = "T"<>ToString[nameInstr]<>"D";
		     tauVector=Table[nameTauInstr<>ToString[j],
				     {j,1, refline[[2,locOutIn,numVar,2]]}];
		     nameAlpha = "C"<>ToString[nameInstr];
		     tauCoefs= constraint[[2,locOutIn,numVar]];
		     If [Length[tauVector]=!=
			   Length[tauCoefs],
			 Message[printOneConstraint::tableStructPb1];
			 exprInTau=0,
			 exprInTau= Dot[tauVector,tauCoefs]];
		     (* coef of alpha *)
		     exprInAlpha = nameAlpha * constraint[[3,locOutIn,numVar]];
		     (* Coef of the Mus *)
		     muVector = Table["Mu"<>nameTauInstr<>ToString[j],
				     {j,1, refline[[5,locOutIn,numVar,2]]}];
		     muCoefs= constraint[[5,locOutIn,numVar]];

		     If [Length[muVector]=!=
			   Length[muCoefs],
			 Message[printOneConstraint::tableStructPb2];
			 Print["MuVector",muVector];
			 exprInMu=0,
			 exprInMu= Dot[muVector,muCoefs]];

		     rhoVector = Table["Rho"<>nameTauInstr<>ToString[j],
				     {j,1, refline[[6,locOutIn,numVar,2]]}];
		     rhoCoefs= constraint[[6,locOutIn,numVar]];

		     If [Length[rhoVector]=!=
			   Length[rhoCoefs],
			 Message[printOneConstraint::tableStructPb2bis];
			 Print["rhoVector",rhoVector];
			 exprInRho=0,
			 exprInRho= Dot[rhoVector,rhoCoefs]];
		     (* complete expr *)
		     exprInVar=exprInTau+exprInAlpha+exprInMu+exprInRho;
		     expr = expr+exprInVar,
		     {numVar,1,Length[refline[[2,locOutIn]]]}],
	       {locOutIn,1,3}];
		 (* Now do it for the farkas coefs *)
	 Do[
		 (* for each dep *)
		   Do [
		     nameDep=refline[[4,farkasCoefType,numDep,1]];
		     (* get the number of the first instr in refline *)
		       
		       (* get its name *)
		       nameFark =
			 "LamDepT"<>ToString[farkasCoefType]
		     <>""<>ToString[nameDep]<>"";
		     farkasVector=
		       Table[nameFark<>ToString[j],
			     {j,1,refline[[4,farkasCoefType,numDep,2]]}];
		     
		     farkasCoefs= constraint[[4,farkasCoefType,numDep]];
		     If [Length[farkasVector]=!=
			   Length[farkasCoefs],
			 Message[printOneConstraint::tableStructPb3];
			 Print["farkasVector",farkasVector];
			 Print[constraint];
			 Print["farkasCoefs",farkasCoefs];
			 exprInFarkas=0,
			 exprInFarkas= Dot[farkasVector,farkasCoefs]];
		     
		     expr = expr+exprInFarkas,
		     {numDep,1,Length[refline[[4,farkasCoefType]]]}],
	       {farkasCoefType,1,5}];

	 (* Coeffs of Phi and phi0 *)
	   phiVector=Table["Phi"<>ToString[j],
				     {j,1,nbPhi-1}];
	 phiCoefs= Drop[constraint[[1]],-1];	 
	 exprInPhi0 =  "Phi0" * constraint[[1,nbPhi]];
	 If [Length[phiVector]=!=
	       Length[phiCoefs],
	     Message[printOneConstraint::tableStructPb4];
	     exprInPhi=0,
	     exprInPhi= Dot[phiVector,phiCoefs]+exprInPhi0];

	 constantTerm = constraint[[7,1]];
	 expr=expr+constantTerm+exprInPhi;
	 constraintType = If [constraint[[8,1]] < 0," <= 0",
			      If [constraint[[8,1]]=== 0," = 0",
				  If [constraint[[8,1]]> 0," >= 0"]]];
	 res=StringJoin["   ",ToString[expr], constraintType,separIneq];
	 res
	 ]

printOneConstraint[a___]:=
  (Message[printOneConstraint::WrongArg,a])



(********************** readOneConstr **************************
is a parser to read added constraints.
The syntaxe is : 
constraint ::= CONSTRAINT1 | CONSTRAINT2
CONSTRAINT1 ::= LHS >= LHS | LHS == LHS 
LHS ::= ATOM1 | -ATOM1 | LHS + ATOM1 | LHS - ATOM1
ATOM1 ::= INTEG ATOM2 | ATOM2 | INTEG * ATOM2
INTEG is an integer A
TOM2 is a name of variables following this syntaxe:
          TnameofinstrDnumberofdimension (ex TAD5)
	  or Cnameofdinstruction (ex CA)
	 
For instrance TAD1 + CB >= 0 
mean that the constraints where the somme of the first coeff of the 
instruction A plus the constant term of the  instr B must be >=0

CONSTRAINT2 ::= HEAD `=` RHS
HEAD ::= NAME`[`INDICES`]`
NAME ::= `T`NAMEVAR
INDICES ::=   INDICE | INDICES`,`INDICE
RHS ::=  IND1 | -IND1 | RHS + IND1 | RHS - IND1
IND1 ::= INTEG INDICE | INDICE | INTEG * INDICE


NAMEVAR is the name of one variable of the Alpha Program
 The indices present in the RHS must be referenced in the LHS
example of constraint: 
TA[i,j,N]=2i+3j+4n+2
set the value of the timing function of A.

readOneConstr take as input one constraint (String) and a <line_eq> 
filed with 0's which has the following structure: 
 <line_eq>  =  {<phi>, {<tau_loc>,<tau_out>,<tau_in>},
                 {<alpha_Loc>,<alpha_out>,<alpha_in>}.
		 {<ladep_??>,<ladep_??>,<ladep_??>,<ladep_??>,<ladep_??>}.
		 {<mu_loc>,<mu_out>,<mu_in>},
		 {<rho_out>},
		 <cst>,<eqOrineq>}


*)

Clear[readOneConstr]


readOneConstr[constr_String/;StringLength[constr]>=1,
	      line0_,
	      instrPosList_,
	    options_List]:=
  Module[{constr1,pos1,pos2,pos2res,rhs1,function,check,
	  indiceList,functionExpr,nbIn,nbOut,nbLoc,locOutIn,
	  relativeNum,relativePosition,error,currVarGiven,
	  coeffs,varName,curCoeff,lConstr,res},

	 error = 0;
	 (* No error for the moment *)
	 check=0;
	 nbLoc=Length[line0[[2,1]]];
	 nbOut=Length[line0[[2,2]]];
	 nbIn=Length[line0[[2,3]]];

	  If [Length[pos1=StringPosition[constr,"_"]]>=1,
              Message[readOneConstr::Underscore,constr];
              Throw[$Failed]];
	 (* CONSTRAIN2 : Constraint of type TA[i,k]=1+2k+3 *)
	 If [Length[pos1=StringPosition[constr,"["]]>=1,
	     check=1;
	     pos2=StringPosition[constr,"]="];
	     If [pos2==={},
		 Message[readOneConstr::wrongSyntax1,constr];
		 res={line0}; error = 1];
	     If [error ===0,
		 (* name of the variable *)
		   varName=StringTake[constr,{2,pos1[[1,1]]-1}];
		 If [Intersection[{varName},Map[Part[#,1] &,
					       instrPosList]]=={},
		     Message[readOneConstr::WrongVarName,varName];
		     res={line0};error = 2]];
	      If [error ===0,
		  (* Check if the schedule given in $schedule
		     do not interfere with the current constraint *)
		  If [options[[11]]=!={},
		      Do [ currVArGiven = options[[11,i,1]];
			   If [currVarGiven===varName,
			       Message[readOneConstr::IncompatibleOptions,
				 varName];
			       res={line0};
			       error = 3],
			   {i,1,Length[options[[11]]]}]]
		  ];
	     If [error ===0,
		     (* get the number of the variable *)
		       relativePosition =getRelativeNum[varName,
							instrPosList,
							line0];
		     locOutIn= relativePosition[[1]];
		     relativeNum = relativePosition[[2]];
		     
		     
		     (* indice list indicated in the constraints *)
		       indices=StringTake[constr,
					  {pos1[[1,1]]+1,pos2[[1,1]]-1}];
		     indiceList=ToExpression["{"<>indices<>"}"];
		     (* timing function to impose *)
		       function=StringTake[constr,
					   {pos2[[1,1]]+2,
					    StringLength[constr]}];
		     functionExpr=ToExpression[function];
		     (* coeffs is the list of coeff of
			the Tau of the variable *)
		       coeffs=Map[Coefficient[functionExpr,#] &,indiceList];
		     lConstr={};		 
		     (* creating one constraint for each Tau *)
		       Do [curCoeff=coeffs[[i]];
			   (* tau_i - coeff = 0 *)
			     line1 = line0;
			   line1=ReplacePart[line1,
					     1,
					     {2,locOutIn,relativeNum,i}];
			   line1=ReplacePart[line1,
					     -curCoeff,
					     {7,1}];
			   lConstr=Append[lConstr,line1];
			   ,{i,1,Length[coeffs]}];
		     (* Creating On constraint for each Alpha *)
			 (* This is a trick to get the constant part of 
			    a polynome,assign all the variable to 0 *)
			 cstCoeff=Fold[#1/.(#2->0) &,functionExpr,indiceList];
		     
		     If [!MatchQ[cstCoeff,_Integer],
			 Message[readOneConstr::PbInExpr,cstCoeff];	
			 lconstr={line0},
			 (* Alpha_A - cstCoeff = 0 *)
			   line1 = line0;
			 line1=ReplacePart[line1,
					   1,
					   {3,locOutIn,relativeNum}];
			 line1=ReplacePart[line1,
					   -cstCoeff,
					   {7,1}];
			 lConstr=Append[lConstr,line1]];
		     res=lConstr;
		   ];
	       ];

	 (* form CONSTRAINT1 ex TAD1 == 2 *)
	 If [Length[pos1=StringPosition[constr,">="]]>=1,
	     check=2;
	     (* inequality, getting expression on the LHS *)
	       constr1=ToExpression[StringTake[constr,pos1[[1,1]]-1]];
	     rhs1=ToExpression[StringTake[constr,{pos1[[1,1]]+2,
					  StringLength[constr]}]];
	     constr1=constr1 - rhs1;

	     Check[line1=Catch[modifyLine[constr1,line0,1,instrPosList,options]],
		   If [line1===$Failed,line1=line0]];
	     line1=ReplacePart[line1,{1},8] ;
	     res={line1}
	   ];
	 If [Length[pos1=StringPosition[constr,"=="]]>=1,
	     check=3;
(*
Print["constr",constr, " pos ", pos1];
*)
	     (* equality, getting expression on the LHS *)
	       constr1=ToExpression[StringTake[constr,pos1[[1,1]]-1]];
(*
Print["constr1",constr1];
*)
	     rhs1=ToExpression[StringTake[constr,{pos1[[1,1]]+2,
						  StringLength[constr]}]];
	     constr1=constr1 - rhs1;	
	     Check[line1=Catch[modifyLine[constr1,line0,1,instrPosList,options]],
		   If [line1===$Failed,line1=line0]];
	     line1=ReplacePart[line1,{0},8];
	     res={line1}
	     ];
	 If [check===0,
	     Print["ERROR in readOneConstr, constraint  unrecognized:",
		   constr];
	     res={line0}];
	 res
	 ]


readOneConstr[a___]:= 
  Module[{},
	 Message[readOneConstr::WrongArg,a];
	 {}]

 

(* Transform a symbolic expression expression of type TAD2+TAD2 into 
   the corresponding constraints constriants in the form of a line
   of the matrice of contraints (model: line0) *)

Clear[modifyLine]


modifyLine[symb1_Symbol,line0_,coeff_Integer,numInstrVar_List,options_List]:=
  Module[{symbString,posD,s1,s2,numInstr,numDim,nbLoc,nbOut,nbIn,
	  relativeNum,locOutIn,relativePosition,nameInstr,currVarGiven },
	 symbString=ToString[symb1];
	 nbLoc=Length[line0[[2,1]]];
	 nbOut=Length[line0[[2,2]]];
	 nbIn=Length[line0[[2,3]]];
	 
	 If [StringPosition[symbString,"T"]=!={} &&
	       Part[StringPosition[symbString,"T"],1]==={1,1},
	     posD=StringPosition[symbString,"D"];
	     (* getting the name of instruction *)
	     s1=StringTake[symbString, {2,Part[posD,-1,1]-1}];
	     (* Check if the schedule given in $schedule
		do not interfere with the current constraint *)
	       If [options[[11]]=!={},
		   Do [ currVarGiven = options[[11,i,1]];
			If [currVarGiven===s1,
			    Message[modifyLine::IncompatibleOptions,
			      s1];
			    Throw[$Failed]],
			{i,1,Length[options[[11]]]}]];
	     relativePosition =getRelativeNum[s1,
					      numInstrVar,
					      line0];
	     locOutIn= relativePosition[[1]];
	     relativeNum = relativePosition[[2]];

	     numDim=ToExpression[StringTake[symbString,
					    {Part[posD,-1,1]+1,
					     StringLength[symbString]}
					    ]];
	     If [MatchQ[line0[[2,locOutIn]],l_List/;(Length[l]>=relativeNum)],
		 If [MatchQ[Part[line0,2,locOutIn,relativeNum],
			    l_List/;(Length[l]>=numDim)],
		     line1=ReplacePart[line0,
				       coeff+
				       line0[[2,locOutIn,relativeNum,numDim]],
				       {2,locOutIn,relativeNum,numDim}],
		     Message[modifyLine::WrongDim];
		     Throw[$Failed]],
		 Message[modifyLine::WrongVar,symb1];
		 Throw[$Failed]], (* else du if
					    constraint=Tquelquechose *)
	       If [Part[StringPosition[symbString,"C"],1]==={1,1},
		 nameInstr=StringTake[symbString,
				      {2,StringLength[symbString]}
				      ];
		 relativePosition =getRelativeNum[nameInstr,
						  numInstrVar,
						  line0];
		 locOutIn= relativePosition[[1]];
		 relativeNum = relativePosition[[2]];

		 If [MatchQ[line0[[3,locOutIn]],
			    l_List/;(Length[l]>=relativeNum)],
		     line1=ReplacePart[line0,
				       coeff+
					 line0[[3,locOutIn,relativeNum]],
				       {3,locOutIn,relativeNum}],
		     Message[modifyLine::WrongVarName3,symb1];
		     Throw[$Failed]],
		 Message[modifyLine::WrongSymbol,symbString];
		 Throw[$Failed]]];
	 line1]

modifyLine[Plus[a_,b__],line0_List,coeff_Integer,numInstrVar_List,options_List]:=
  Module[{line1,line2},
	 line1=modifyLine[a,line0,coeff,numInstrVar,options];
	 line2=modifyLine[Plus[b],line1,coeff,numInstrVar,options];
	 line2]



modifyLine[Times[a_Integer,b_],line0_List,coeff_Integer,numInstrVar_List,options_List]:=
  modifyLine[b,line0,a*coeff,numInstrVar,options]

(* Constant part of the ineq *)
modifyLine[a_Integer,line0_List,coeff_Integer,numInstrVar_List,options_List]:=
Module[{line1},
       line1=ReplacePart[line0,coeff*a+Part[line0,7,1],{7,1}];
       line1]
	 
modifyLine[a_,b_,c_,d_,e_]:= 
  Module[{},
	 Message[modifyLine::WrongExpr,a];
	 b]

modifyLine[a___]:= Message[modifyLine::WrongArg,a]



(* The result of Pip is given in order: Local var, then Output, then
   Input. We want the order: Input, Output, Local *)
   
Clear[reorderSchedResult];

reorderSchedResult[result_List,
		   numInstrVar_List,
		   refline_List]:= 
  Module[{nbIn,nbLoc,nbOut,resLoc,resOut,resIn},
	 nbLoc=Length[refline[[2,1]]];
	 nbOut=Length[refline[[2,2]]];
	 nbIn=Length[refline[[2,3]]];
	 If [nbIn+nbOut+nbLoc =!= Length[numInstrVar],
	     Message[reorderSchedResult::Pb1]];	     	
	 resLoc = Take[result,{1,nbLoc}];
	 resOut = Take[result,{nbLoc+1,nbLoc+nbOut}];
	 resIn = Take[result,{nbLoc+nbOut+1,Length[numInstrVar]}];
	 Join[resIn,resOut,resLoc]
       ]


Clear[convexiseDom]

convexiseDom[dom1_Alpha`domain]:=
  Module[{polList,newPol,res},
	 newPol=DomConvex[dom1];
	 If [!MatchQ[newPol,Alpha`domain[_,_,{_}]],
	     Message[convexiseDom::Pb,newPol];Throw[$Failed]];
       newPol]

convexiseDom[a___]:= (Message[convexiseDom::WrongArg,a];
		      Throw[$Failed])


(* this function convexise all the domains of the deps *)
Clear[convexiseSplittedDep]

convexiseSplittedDep[listDep_List]:=
  Module[{nbDepType,newSplittedDep,tempDep},
	 nbDepType=Length[listDep];
	 newSplittedDep={};
	 Do [tempDep = listDep[[i]];
	     tempDep = 
	       Map[ ReplacePart[#1,convexiseDom[#1[[1]]],1] &,tempDep];
	     newSplittedDep=Append[newSplittedDep,tempDep],
	     {i,1,nbDepType}];
	 newSplittedDep
       ]

convexiseSplittedDep[a___]:=
  (Message[convexiseSplittedDep::WrongArg,a];
   Throw[$Failed])

getNewListDep[depTable_Alpha`dtable,
	      options_List]:=
  Module[{res,numDep,listDep},
	 listDep=depTable[[1]];
	 If [!MatchQ[options[[12]],List[___Integer]],
	     Message[getNewListDep::WrongValueForOnlyDep];
	     res=listDep,
	     res={};
	     If [Length[options[[12]]]>0,
		 Do [numDep = options[[12,i]];
		     If [numDep>Length[listDep],
			 Message[getNewListDep::WrongDepNumber,numDep],
			 res=Append[res,listDep[[numDep]]]],
		     {i,1,Length[options[[12]]]}];
	       ]];
	 Alpha`dtable[res]]
	     
getNewListDep[a___]:=(Message[getNewListDep::WrongArg,a];
		      Throw[$Failed])	 

Clear[makeNumDepSplitted]

makeNumDepSplitted[listDep_Alpha`dtable,
		   splittedListDep_List]:= 
  Module[{numDepSplitted,curNumList, curNumDep},
	 numDepSplitted={};
	 Do[
	   curNumList = {};
	   Do[ 
	     curNumDep =
	       Position[listDep[[1]],splittedListDep[[i,j]]];
	     If [Length[curNumDep]< 1,
		 Message[makeNumDepSplitted::Pb1];
		 Throw[$Failed],
		 curNumList= Append[curNumList,curNumDep[[1,1]]]];
	     ,
	     {j,1,Length[splittedListDep[[i]]]}];
	   numDepSplitted= Append[numDepSplitted,curNumList],
	   {i,1,6}];
	 numDepSplitted]

makeNumDepSplitted[a___]:=(Message[makeNumDepSplitted::WrongArg,a];
		      Throw[$Failed])	 


makeNumInstr::usage = " internal function build from the three lists of input,
output and local variable, the list of correspondance between a number
of variable and its name"

checkGivenSchedVect::usage = "internal function used for checking the 
givenSchedVect option validity"
setDepToSchedule::usage = "internal function used for  changing the
list of variable scheduled"
setInstrToSchedule::usage = "internal function used for  changing the
list of variable scheduled"
checkOptOnlyVar::usage = "internal function used for  checking that 
the onlyVar option of Schedule is used correctly"

checkOptOnlyVar::badValue  = "The onlyVar option should be a list 
of string, we forget the option given..."
checkOptOnlyVar::UnrecognizedVar = " unrecognized variable: `1`, we
forget the onlyVar option "
checkOptOnlyVar::givenSchedVect = "The schedule of `1` is  needed to
find the schedule, it  should be set in the givenSchedVect option" 
checkOptOnlyVar::ScheduleNotGiven = "The schedule of `1` is  needed to
find the schedule, it  should be set in the givenSchedVect option" 
checkOptOnlyVar::WrongArg =  
"Wrong argument for checkOptOnlyVar, `1`"
checkOptOnlyVar::UnrecognizedVar = "There are some unknown variable in
`1`, we forget the onlyVar option "
checkOptOnlyVar::AlsoVar= "Warning: schedluing also variable `1`"
setInstrToSchedule::WrongArg = "Wrong argument for checkOptOnlyVar, `1`"
setDepToSchedule::WrongArg= "Wrong argument for checkOptOnlyVar, `1`"
checkGivenSchedVect::SchedGivenTwice = "in option givenSchedVect, the
schedule of variable `1` is given twice"
checkGivenSchedVect::VarNotFound= "var `1` not found in program"
checkGivenSchedVect::WrongSizeSchedVect = " wrong size for the
  scheduling vector given for variable `1`"
checkGivenSchedVect::WrongForm = " the givenSchedVect option should be
a List of List"
 checkGivenSchedVect::WrongArg= "Wrong argument  `1`"

(*  makeNumInstr[] make the correspondance between 
    the variable and the number of instruction, return 
     a list of {"nmaeVAr"_String,numberInstr_Integer}*)

makeNumInstr[listInputVars_List,
	      listLocalVars_List,
	     listOutputVars_List]:=
  Module[{list1,list2,list3},
	 list1=Table[{listInputVars[[i]],i},{i,1,Length[listInputVars]}];
	 list2=Table[{listOutputVars[[i]],
		     i+Length[listInputVars]},
		     {i,1,Length[listOutputVars]}];
	 list3=Table[{listLocalVars[[i]],
		      i+Length[listOutputVars]+Length[listInputVars]},
		     {i,1,Length[listLocalVars]}];
	 Join[list1,list2,list3]
       ]



makeNumInstr[a___]:=(Message[makeNumInstr::WrongArg];
		     Throw["ERROR2"])


(*****************************************************************
  
  Tools for multidimensional scheduling 

*****************************************************************)

(* Check if the option onlyVar is correctly used. i.e: 
   if the variables exists
   if they can be schedule without any other information, 
   and if it is not the case, check that $schedule is set *)

Clear[checkOptOnlyVar]

checkOptOnlyVar[sys_Alpha`system,
		numInstrVar_List,
		listDep_Alpha`dtable,
		options_List]:=
  Module[{listOnlyVar,error,res,listAllVar,fromTo,gDep,gDepOrdered,
	  scheduleSet,newListOnly,newVar,nameNewVar,lastVertex},
	 listOnlyVar=options[[10]];
	 error=0;
	 res=listOnlyVar;
	 (* list of String *)
	 If [!MatchQ[listOnlyVar,List[___String]],
	     Message[checkOptOnlyVar::badValue];
	     error=1;res={}];
	 listAllVar=Map[First,numInstrVar];
	 (* variables exist *)
	 If [!Apply[And,Map[MemberQ[listAllVar,#] &,listOnlyVar]],
	     Message[checkOptOnlyVar::UnrecognizedVar,listOnlyVar];
	     error=1;res={}];
	 (* Check that we do not need any other variables *)
	   
	 If [False, (* error===0 *)
	     (* This function will build a graph (structure used int he 
		Combinatorica.m Package *)
	       Clear[fromTo];
	     fromTo[x1_String,x2_String]:=
	       Module[{l1,l2},
		      l1 = Map[(Part[#,3]===x1)&&(Part[#,2]===x2) &,
			       listDep[[1]]];
		      l2=Select[l1,# &];
		      If [Length[l2]>0,True,False]];
	   fromTo::erreur="fatal internal error ";
	     fromTo[a___]:= Module[{},
				   Message[fromTo::erreur];
				   Print[a];
				   Throw["ERROR"]];
	     gDep = MakeGraph[Map[Part[#,1] &,numInstrVar],
			      fromTo];
	     (* ShowGraph[gDep,Directed];ShowLabeledGraph[gDep] 
		gDepOrdered has its vertex in topological order *)
	       
	       
	       gDepOrdered = TopologicalSort[gDep];
	     If [!MatchQ[gDepOrdered,List[___Integer]],
		 Message[checkOptOnlyVar::pb1];
		 Return[listOnlyVar]];
	     (* remove the unused vars, first get the 
		last vertex to schedule *)
	       lastVertex=Length[listAllVar];
	     nameLastVertex =
	       listAllVar[[gDepOrdered[[lastVertex]]]];
	     While[(!MemberQ[listOnlyVar,nameLastVertex])
		     && (lastVertex>0),
		   lastVertex=lastVertex-1;
		   nameLastVertex =
		     listAllVar[[gDepOrdered[[lastVertex]]]]];
	     gDepOrdered = Take[gDepOrdered,{1,lastVertex}];
	     (* We look, if a vertex is not in listOnlyVar, if it is an 
		input or if there is really a dependence form this point
		to a point of listOnlyVar *)
	       newListOnly=listOnlyVar;
	     Do [
	       newVar=gDepOrdered[[i]];
	       nameNewVar=listAllVar[[gDepOrdered[[i]]]];
	       
	       If [!MemberQ[newListOnly,nameNewVar],
		   Message[checkOptOnlyVar::AlsoVar,nameNewVar];
		   newListOnly = Prepend[newListOnly,nameNewVar]];
		       (* To implement here: a test checking that the 
			  variable is really implied in a dependency *)
	       ,
	       {i,1,lastVertex}];
	   res=newListOnly];
	 res]

checkOptOnlyVar[a___]:=(Message[checkOptOnlyVar::WrongArg,a];
				Throw["ERROR"])

Clear[setInstrToSchedule];

setInstrToSchedule[numInstrVar_List,onlyVar_List]:=
  Module[{newNumInstrVar},
	 
	 newNumInstrVar = Select [numInstrVar,
				  MemberQ[onlyVar,
					  First[#]] &];
	 newNumInstrVar]

setInstrToSchedule[a___]:=Message[setInstrToSchedule::WrongArg]


Clear[setDepToSchedule]

setDepToSchedule[numInstrVar_List,
		  listDep_Alpha`dtable]:=
  Module[{listNameVar,newListDep},
       listNameVar=Map[First,numInstrVar];
       (* remove all the dependancies whose goal arrive to
	  unschedulevariables *)

       newListDep = Alpha`dtable[Select[listDep[[1]],
					(MemberQ[listNameVar,
						 Part[#,2]]) &]];
       newListDep
     ]

setDepToSchedule[a___]:=Message[setDepToSchedule::WrongArg]

checkGivenSchedVect[sys_Alpha`system,
		    options_List]:=
  Module[{listGivenSched,listNames,nameVar,decl},
	 listGivenSched=options[[11]];
	 If [!MatchQ[listGivenSched,List[___List]],
	     Message[checkGivenSchedVect::WrongForm];
	     Throw["ERROR"]];
	 listNames = Map[First,listGivenSched];
	 If [Length[Union[listNames]]=!=Length[listNames],
	     Message[checkGivenSchedVect::SchedGivenTwice,nameVar];
	     Throw["ERROR"]];
	 
	 Do [nameVar = listGivenSched[[i,1]];
	     decl = getDeclaration[nameVar];
	     If [decl ==={},
		 Message[checkGivenSchedVect::VarNotFound,nameVar];
		 Throw["ERROR"],
	         If [Length[decl[[3,2]]] =!= Length[listGivenSched[[i,3,1]]],
		     Message[checkGivenSchedVect::WrongSizeSchedVect,nameVar];
		   Throw["ERROR"]];
	       ];
	   ,
	   {i,1,Length[listGivenSched]}]
       ]
	

checkGivenSchedVect[a___]:=(Message[checkGivenSchedVect::WrongArg,a];
			   Throw["ERROR"])


		 
End[] 
EndPackage[]


