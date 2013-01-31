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

BeginPackage["Alpha`Options`"]
(* Standard head for CVS

	$Author $
	$Date: 2003/12/12 13:17:00 $
	$Source: /udd/alpha/CVS/alpha_beta/Mathematica/lib/Packages/Alpha/Options.m,v $
	$Revision: 1.48 $
	$Log: Options.m,v $
	Revision 1.48  2003/12/12 13:17:00  risset
	 minor modif
	
	Revision 1.47  2003/07/02 08:25:49  risset
	accepting call in a2v
	
	Revision 1.46  2003/06/20 13:00:20  quinton
	Added the onlyModules option of alpha2Alphard
	
	Revision 1.45  2003/01/17 09:47:04  risset
	commit after a long silence by Tanguy (before visiting Rennes)
	
	Revision 1.44  2002/12/03 12:52:26  risset
	replaced the Pip.m by the new Pip.m with function solveWithPip
	
	Revision 1.43  2002/09/09 15:38:27  quinton
	Few minor corrections.
	
	Revision 1.42  2002/08/29 09:12:41  risset
	added options for appSched
	
	Revision 1.41  2002/07/16 12:36:40  quinton
	A few options added.
	
	Revision 1.40  2002/05/28 14:38:15  quinton
	Various new options were added for various functions. An option contextDomain
	for addLocal, an option invert for serializeReduction, and options norm, inputEquations
	and allLibrary for removeIdEqus.
	
	Revision 1.39  2002/03/29 14:12:52  risset
	Options.m
	
	Revision 1.38  2002/01/17 10:29:48  risset
	modify the Pipeline.m package for pipall with boundary
	
	Revision 1.37  2002/01/15 10:24:23  risset
	corrected the noPrint Options
	
	Revision 1.36  2001/12/13 08:49:43  risset
	added the BitOperateur.m
	
	Revision 1.35  2001/11/14 10:32:25  quinton
	Correction for scalars was incorporated, and a new matlab option has been
	added to allow code generator to produce code which is executable under
	Matlab..
	
	Revision 1.31  2001/07/06 12:44:39  risset
	small changes
	
	Revision 1.30  2001/01/15 09:02:01  risset
	mise a jour
	
	Revision 1.29  2000/07/04 11:51:33  quinton
	Ajout de quelques options pour Vhdl2.m
	
	Revision 1.28  2000/06/06 15:44:06  risset
	minor changes
	
	Revision 1.27  2000/05/26 17:58:25  quinton
	*** empty log message ***
	
	Revision 1.26  2000/05/26 13:27:42  risset
	add options to analyze
	
	Revision 1.25  1999/12/10 16:59:03  risset
	commited struct Sched and ZDomlib
	
	Revision 1.24  1999/11/08 17:21:10  quinton
	Corrections to depGSraph. Added options labelSize and labelOffset.
	
	Revision 1.23  1999/08/12 14:55:41  quinton
	Options onlyVar and sortOrder added to showSchedResult, to allow results
	to be shown in a specific order, and for only a few variables.
	
	Revision 1.22  1999/08/11 14:53:01  quinton
	Few minor corrections.
	
	Revision 1.21  1999/05/18 16:24:26  risset
	change many packages for documentation
	
	Revision 1.20  1999/05/10 15:20:57  risset
	supressed the Decomposition Package, put it in Cut
	
	Revision 1.19  1999/05/10 14:56:21  alpha
	 changed things for docs
	
	Revision 1.18  1999/05/10 13:14:14  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.17  1999/05/06 12:08:51  risset
	corrected isSpaceSepQ
	
	Revision 1.16  1999/04/29 10:31:08  risset
	suppressed MultiDim.m
	
	Revision 1.15  1999/04/19 15:06:09  risset
	corrected Options outputForm
	
	Revision 1.14  1999/04/02 08:15:17  risset
	added FarkasSchedule
	
	Revision 1.13  1999/03/02 15:49:23  risset
	added GNU software text in each packages
	
	Revision 1.12  1998/12/18 10:49:58  risset
	changed the alphaFormat usage
	
	Revision 1.11  1998/12/16 13:38:33  risset
	added simplifySchedule
	
	Revision 1.10  1998/11/27 12:20:16  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.9  1998/10/14 11:55:45  risset
	added the equlitySimpl
	
	Revision 1.8  1998/06/03 14:49:04  risset
	change duration option

	Revision 1.7  1998/03/12 10:02:59  risset
	added addConstraints for multiDim sched

	Revision 1.6  1998/02/16 17:06:54  risset
	Packages pass all tests

	Revision 1.5  1997/09/12 11:54:27  risset
	added things

	Revision 1.4  1997/06/10 12:58:10  fdupont
	a few options added

	Revision 1.3  1997/06/03 13:05:16  risset
	added message error to dep and option to eliminate duplicates dependencies

	Revision 1.2  1997/04/22 07:54:39  risset
	Added multiDim Scheduling

	Revision 1.1  1997/04/10 15:10:47  risset
	added Options.m ScheduleTools.m OldSchedule.m remove NewSchedule.m

*)

(*  This Package is here to gather all the options used in different
    packages. As soon as a Packages uses an option, you include this
    package in the opening includes *)
    


(*  General options, used in several functions  *)

debug::usage = "option (Boolean). If True, debug mode. "

verbose::usage = "option (Boolean). If True, print intermediate information."

recurse::usage = "option (Boolean). If True, apply the function
recursively to all the subsystem."

library::usage = "option (List of Alpha`system). Defines the library which
must be used by the function."

(* Options of addLocal *)

contextDomain::usage = "option of addLocal. If True (default), the new
variable is added with the contextual domain of the expression, with the
form of addLocal with a position. Otherwise, the expression domain is 
used.";

(* Options of serialize *)

invert::usage = "option of serializeReduce. If True (default False), 
the nullspace vector is inverted"; 

(* Options of SubSystems *)

norm::usage = "option of removeIdEqus. If True, normalization is done"; 
inputEquations::usage = "option of removeIdEqus. If False, an equation
of the forme X = in, where in is an input variable, is not removed.";

allLibrary::usage = "option of removeIdEqus (default False). If set to 
True, all programs of library are treated."; 

(* Options to the scheduler *)

resolutionSoft::usage = "(+) resolutionSoft is an option of
schedule. If resolutionSoft -> pip, the schedule is computed using Pip,
through a file interface (implemented in Farkas resolution only). 
None of the following are yet implemented:
If resolutionSoft -> mma, the schedule is computed using the Mathematica
function ConstrainedMin (implemented in Vertex resolution only).
 resolutionSoft -> lpSolve the schedule is computed using the LpSolve library
function ConstrainedMin (not implemented yet).";

pip::usage="possible value (default) of the options resolutionSoft of
schedule" 
mma::usage="possible value  of the options resolutionSoft of schedule"
lpSolve::usage="possible value of the options resolutionSoft of schedule" 


schedMethod::usage = " Options of schedule (symbol), select the
scheduling method to be used. schedMethod->farkas (default) stands for
P. Feautrier's method (using PIP with file interface) implemented in
the scheduleFarkas function. schedMethod->farkas2 stands for the most recent 
implementation of this method (ModularSchedule) .schedMethod->Vertex stands for
P. Quinton's vertex method (using MMA linear resolveur). WARNING: the
setting of this options greatly influence the setting of the others
options of schedule because they correspond to two completely
different implementations"

farkas::usage= "value of options schedMethod of schedule, the schedule 
will be computed with P. Feautrier's method (using PIP with file
interface)"
vertex::usage="value of options schedMethod of schedule, the schedule 
will be computed with P. Quinton's vertex method (using MMA linear resolveur)"


integerSolution::usage = "(+) integerSolution is an option of
schedule. 
If integerSolution -> True (default for farkas resolution)
 the schedule has integral coefficients. If integerSolution ->
False, (default for Vertex resolution)
the schedule may have rational coefficients.";

bigParPos::usage=" bigParPos is an option of
Pip related functions, Integer type. It indicates the position of the big Paramter. If set to negative integer, there is no big parameter"

addConstraints::usage = "option of schedule. The type is : List of
 String or List of List of String (in case of MultiDim schedule),
 default value : {}. Additional constraints for the LP.  add
 constrains expressed in the strings to the current scheduling
 process.
 schedule[addConstraints->{\"TA[i,j,N]=i+2j-2\",\"TBD2==2\",\"TBD1+2TBD3>=1\"}]\\
 Impose that the schedule function of variable A is i+2j-2, Then we
 have constraints on the coefficients of the timing function of the
 B variable (the  second coefficient
 must be 2, etc...). In case of a multi-dimensionnal scheduling, the
 ith list is added to the constraints of the ith dimension"


durations::usage = "option of schedule (List) default {}.  select a
mode for counting the duration of instructions.  durations -> {} : each
equation is 1 (whatever complex is the computation)
(default). durations -> ListOfInteger: The duration of each equation is
given by the user the options \"durationByEq\" indicates whether these
values stand for a duration by equation (default in Farkas resolution,
not implemented in Vertex resolution) or a duration by dependence
(default in Vertex resolution, not implemented in Farkas resolution).
durations -> ListOfListOfInteger: same as previous one but for
multidimensionnal scheduling (one list of integer by dimension).  "

durationByEq::usage=" option of schedule (boolean) indicates whether the
duration values given in the \"durations\" option stand
 for a duration by equation (default in Farkas resolution,
not implemented in Vertex resolution) or a duration by dependence
(default in Vertex resolution, not implemented in Farkas resolution).
In the case of a duration by equation, the
list must contain as many integer as there are VARIABLES (do not
forget the inputs and output), the order is the order of declaration
in the Alpha program. In the case of a duration by dependence, the 
 must contain as many integer as there are dependecies  
the order is the order of the dependencies returned by the dep[]
function "


givenSchedVect::usage = "options of Schedule, List of schedule given
  for some variable, the syntaxe for each schedule is the one present
  in $schedule: {{a, {i, j, N}, sched[{0, 0, 0}, 0]}} (The list of
  indice may be replaced by {}) "; 

affineByVar::usage="Value of option scheduleType of schedule, the
		 resulting schedule will be affine by variable"
sameLinearPart::usage="Value of option scheduleType of schedule, the
		 resulting schedule will be affine by variable with
		 the same linear part for all local variables"
sameLinearPartExceptParam::usage="Value of option scheduleType of schedule, the
		 resulting schedule will be affine by variable with
		 the same linear part for all local variables"
scheduleType::usage = "scheduleType is an option of schedule (symbol) which
gives the type of the schedule searched.  scheduleType -> affineByVar (default)
: affine by variable schedule.  scheduleType -> sameLinearPart: affine with
constant linear part.  scheduleType -> sameLinearPartExceptParam: affine with constant linear
part except for the parameters";

optimizationType::usage = " options of schedule (symbol), indicates
the objective fonction used by the schedule: minimizing time, delays
on dependencies of nothing.  optimizationType->time tries to get
aminimal time schedule (default).  optimizationType->delay tries to
minimize the delays on the dependencies (not implemented currently)
optimizationType->Null no objective function is provided (not
implemented in Vertex resolution). In that case the coefficient of the
timing function are minimized lexicographically (from output to
input)."

time::usage="possible value (default) of option optimizationType of schedule"
delay::usage="possible value of option optimizationType of
schedule"
multi::usage="possible value  of option optimizationType of schedule or of option structSchedType of buildSchedConstraints"
mono::usage="possible value  of option structSchedType of buildSchedConstraint"

scheduleDim::usage="Option of buildSched Constraint (integer or list
of integer), indicates the dimension to which the constraints should
be set" 

structSchedType::usage="Option of buildSched Constraint
(integer or list of integer), indicates whether the use will be
pipelined (no additionnal dimension in the schedule) or considered as
an instantaneous call (additionnal dimention in the schedule)"


multiSchedDepth::usage= "options of schedule (integer) indicating the depth of
the  current schedule taking place in a multi dimensionnal scheduling
process
(this option should not be set by the user, it is for internal use only)"


onlyVar::usage = " Option of schedule which is a list of string
(default value: all)
 indicating the only variables that we wish to schedule. Warning, if 
some variable are needed for the computation of the one indicated,
 the function will try to find their execution dates in $schedule 
(only implemented in the Farkas method)"

all::usage="value of various options (onlyVar, onlyDep,....)"
onlyDep::usage = " Option of schedule which is a list of integer
(default value: all) indicating the only dependences  that we wish to schedule (used for 
multiSched[]) "


objFunction::usage = "objFunction is an option of schedule which gives
the type of minimization done for minimizing what we try to minimize
(i.e. time or delay or whatever). the technique for that is to build a
function of the parameters of the system and to minimize the
  coefficient of this function with respect to constraints which
  ensure that this function is greater than what we want to minimize. 
The technique used by default (objFunction->lexicographic) 
in the Farkas resolution is to minimize
  lexicographically the coefficient of this function in the order of
  their declaration in the Alpha program. but one can chose to
  minimize them in another order:
  objFunction->lexicographic[\"N\",\"P\",\"M\"] (not implemented anywhere)
or to minimize a function of these coefficients example:
  objFunction->2\"N\"+\"P\" (only implemented in the vertex			     resolution) "

lexicographic::usage="possible value of the objFunction option of the
  schedule function"
checkSched::usage = 
"(+) checkSched is an option of schedule which allows a schedule 
to be checked for a given Alpha program. This option can be used only
for affine by variable schedules. The form of this 
option is checkSched -> list, where list has the same syntax as 
$schedule (see ?$schedule for more information).\n
WARNING: this option is not implemented";


parameterConstraints::usage = 
"parameterConstraints is an option of dep. If set, constraints on the
parameters are included in the domains of the dependencies. Default is
False";

subSystems::usage= "options of schedule (boolean) and dep indicating
whether or not the function takes into account the calls to other
  systems (default, false)"

subSystemSchedule::usage = "option of schedule (list), indicates, 
if the subSystems option is set to True, the schedules of the
  different subsystems called in the system to schedule for performing
  a structured scheduling"
 
multiDimensional::usage=" option of Schedule (boolean), indicates 
if we perform a multi dimensional scheduling or mono dimensionnal
  scheduming (default)"

outputForm::usage = "options of schedule, gselect the output of the
schedule which may be a schedule, a LP, a domain .... The default
value is outputForm->scheduleResult i.e. the result isx a schedule (see
?$schedule). other value: outputForm->lpSolve (Linear Programming
problem (LP) formated for lp_solve), outputForm->lpMMA (LP
formated for MMA (to be implemented)), outputForm->domain (schedule polytope (Alpha`domain,Warning works for small programs))"

dataFlowConstantsNull::usage = 
"dataFlowConstantsNull is an option of scd. Its default value is True,
forcing the constant part of the first level of a data-flow schedule
to be 0 for all variables.";

dataFlowPeriod::usage = 
"dataFlowPeriod is an option of scd. Its default value is 1. If set to
an  integer, forces the period of the data-flow schedule to be this
integer. If set to any non integral value, the data-flow period is
choosen automatically,  and assumed to be >=1. Most often used in
combination with dataFlowConstantsNull set to False.";

dataFlowVariables::usage = 
"dataFlowVariables is an option of scd, which is considered only for
data-flow schedules. Its default value is <<all>>, meaning that all
variables are considered for data-flow scheduling. If it is set to a
list of strings, it gives the list of variables which must not be
inserted in the dataflow variables. These variables will be considered
only for scheduling in the next dimensions of the schedule.";

verticesPositives::usage = 
"verticesPositives is an option of scd, scheduleConstraints, and 
timeMinSchedConstraints. Its default value is False. When set, this
option forces the scheduler to find timing-functions which are positive
at the vertices of the domains of the variables. Usually, only
constraints on rays of the domains are taken into account. This option
is not used, as it most often results in non-integral (i.e. strictly
rational) schedules."

(* Options of showSchedResult *)
sortOrder::usage = 
"sortOrder is an option of showSchedResult, which specifies the order
in which the results are given. Default is noOrder. Other possibilities
are lexicographic, or an integer which specifies the number of coefficient
given backwards";

noOrder::usage = 
"noOrder is a value for the option sortOrder of showSchedResult";

(* Options of dep *)

eliminatesDoubles::usage = "Options of dep[], if set to False 
dep[] returns the usual dependence list. If set to True, the dependences
  returned does not contain twice the same dependence"

equalitySimpl::usage = " options of dep[], if set to True, try to
  simplify the dep according to the context (default True)" 

(* Options to analyze[] *)

scalarTypeCheck::usage = "option to analyze[] (Boolean). If True,
perform scalar type checking. For internal use mostly."

(* Options to inlineAll[] and inlineSubsystem[]*)

occurence::usage =
"option of inlineAll[] and inlineSubsystem[] (Integer). 
When a given subsystem is used several times in
the same caller system, the value of occurence selects the instance to
be inlined.";

rename::usage =
"option of inlineAll[] and inlineSubsystem[] (Boolean). 
rename -> True  forces the renaming of all variables, whereas
if rename -> False, variables are renamed only in case of conflict.";

renameCounter::usage = "option of inlineAll[] and inlineSubsystem[]
(Integer, default 1).  Sets the value to be appended to variable names
in case when they are renamed to avoid name conflicts. ";

current::usage = 
"option of inlineAll[] and inlineSubsystem[] (Boolean). If
True, $result and $program are updated.";

underscore::usage = 
"option of inlineSubsystem and inlineAll (Boolean). When True
(default), new identifier separator is _, whereas it is X otherwise";

indexnorm::usage="option of normalize[] (Boolean). indexnorm -> True
  normalizes index expressions also. The default is False."


(* Option of simplify system *) 
alphaFormat::usage="options of simplifySystem: alphaFormat->Alpha (default)
simplify a system to the standard normalized Alpha
form. alphaFormat->Alpha0 simplify to Alpha0 format,
alphaFormat->AlpHard is not implemented"
Alpha0::usage="value of the alphaFormat options of simplifySystem";
(* Options of toAlpha0v2 *)

initZeroReg::usage = "options of toAlpha0v2: initZeroReg->False 
do not generate a control signal for the register that are initialized
with a zero. These register will be initialized by the Rst signal"

(* options  of Uniformization *)
verifyCone::usage = "verifyCone is an option of uniformization
which verifies whether the dependence cone is pointed if set to True (default value)
or does not if it is False."

alignInp::usage = "alignInp is an option of uniformization. If set to
True the uniformize function will try to uniformize a dependence by
aligning the input instead of routing the dependence. The default
value is False."

routeOnce::usage = "routeOnce is an option of uniformization. If
set to True the uniformize function  will perform routing for the
first vector of the route. The default value
is False."

tmpFile::usage = "tmpFile is an option of uniformization. If
set to True the uniformize function  will output a file in /tmp
directory after each iteration of uniformization. The default value
is False."

silent::usage = "option of show (False). If silent is True, show does not print
its result, but returns a string.";

allVariablesAllowed::usage = "Option of changeOfBasis, default False. If True 
the change of basis can be applied to any variable. Not yet operational...";

showSquareDeps::usage = "option of uniformizeInfo";
showNonSquareDeps::usage = "option of uniformizeInfo";
showUniformDeps::usage = "option of uniformizeInfo";
showNonUniformDeps::usage = "option of uniformizeInfo";
showUniformizableDeps::usage = "option of uniformizeInfo";
showNonUniformizableDeps::usage = "option of uniformizeInfo";

minimize::usage = "option of simplex. Default is True";

boundedDelay::usage = "option of timeMinSchedConstraints. Currently not used.";
extraEdges::usage = "Option of depGraph, allowing edges to be added";

labelOffset::usage = 
"Option of depGraph, allowing the offset of the position of a label 
to be modified. Default is 0.025.";

labelSize::usage = 
"Option of depGraph, allowing the size of the labels to be changed.
Default value is 0.1 .";
onlyIdDep::usage = 
"Option of depGraph (default False), If set to True, build a graph where only 
identity dependences are present. (require an aligned program).";

cellType::usage = "Option of Vhdl";
tempFile::usage = "Option of Vhdl";
vhdlLibrary::usage = "Option of Vhdl"; 
compass::usage = "Option of Vhdl";
compactCode::usage = "Option of Vhdl";
clockEnable::usage = "Option of Vhdl";
skipLines::usage = "Option of Vhdl";
stdLogic::usage = "Option of Vhdl. If set, produces stdlogic types";
initialize::usage = "Option of vhdlType. If set, produces initialized declarations";
controler::usage = "Option value for option cellType of alphaToVHDL"; 
cell::usage = "Option value for option cellType of alphaToVHDL"; 
module::usage = "Option value for option cellType of alphaToVHDL"; 
rewrite::usage = "rewite: option (boolean) for cGen. If True, output file is
overwritten if it already exists.";
include::usqge = "include: option of code Generators, specify as a list of string the list of file to be included (default: False)"
noPrint::usage = 
"boolean option of cGen. If True, the generated C code does not provide 
prompts before the inputs, nor before the outputs, which makes it easier
to run a test from an input file";

alreadySchedule::usage = 
"option of cGen (boolean, default false), if set to True, cGen does not 
perform schedule neither change of Basis: WARNING not Implemented yet ";

stimuli::usage = 
"option of cGen (boolean, default False), if set to True, cGen 
generates one stimuli file by input and output variable";

interactive::usage = 
"interactive is a (boolean) option of cGen. If True, cGen also generates 
a function main which (i) reads system inputs on stdin (ii) evaluates the 
system, (iii) prints the outputs on stdout";

matlab::usage = 
"matlab is a boolean option of cGen. If True, cGen also generates a 
function mexFunction which is used for interface with matlab code";

bitTrue::usage = 
"bitTrue is a boolean option of cGen. If True, cGen includes the 
bitOperators.h file in the C code and produces the compile script to 
compile the code";

debugC::usage = 
"debugC: option (boolean) for VirtexGen. If True, Virtexgen generates 
a function main which (i) reads system inputs on stdin (ii) evaluate 
the system, (iii) prints the outputs on stdout (the output are not 
significant in that case)";

onlyLocalVars::usage = "option used  when a function shouyld be applied sometimes nly on local variables "

projVector::usage= "options of appSched to indicate what is the projection vector (appSched will try to find a unimodulary completion that is a projection along this vector) should be a Mathematica Vector (integer list) for instance: {1,0,0}(dimension is the number of indices plus parameter). Warning, this function does not try very hard to find a projection, the first one found is choosen. If it failed, please use the projMatrix options "

projMatrix::usage= "options of appSched to indicate what is the projection Matrix used for completing the schedule. should be a Mathematica Matrix (list of list of integer) for instance: {{1,0,0},{0,1,0}}. This matrix is a linear Matrix, i.e. it does not contains the affine part information (dimension is the number of indices plus parameter) "

(* Options of getContextDomain *)

checkCase::usage = 
"checkCase is an option of getContextDomain. If set, the function
checks on the fly that the branches of the case expressions do not 
overlap. False by default.";

(* Options of simplifySpaceDom *)
mergeDomains::usage =
"mergeDomains is an option of simplifySpaceDom. If set (True), the
domains are merged before the simplification is applied. Default
value is False";

extDomUseCOB = " extDomUseCOB is an option of changeOfBasis used internal 
to allow a non identity part on extention indices during a recursive change of basis, this option should not be used by the end user (the resulting program maybe wrong))"

onlyModules::usage = 
"onlyModules is an option of alpha2ToAlphard. If set (True), the
program does not accept a system which is not a module. Default is
False."; 

startTime::usage=
"startTime is an options of systemC generator for controleurs to indicate the 
starting time of an Alphard program, i.e. the smallest value taken by the t index upon all the domains of the library, default Infinity" 
systemCFiles::usage=
"systemCFile is an options of systemC generator that indicates whether the codeis generated in one
.h file (option value 1, default value) or in two files (.h and .cpp file, option value 2)" 

busWidth::usage=
"options of socLibGen (default 32) set the bus Width used during the generation of the systemC 
interface to Alphard programs"

inputOrOutput::usage=
"options of  socLibGen for internal use"
Begin["`Private`"]

(* should be suppressed 

sameLinearPart::usage = 
"sameLinearPart is an option of scd, scheduleConstraints, and
timeMinSchedConstraints.  Its default value is False. If set, this
option requires variables having the same dimensionality to be
scheduled by an affine function whose linear part is the same.  For
example, A[i,j,k] and B[i,j,k] would be scheduled at time
a.i+b.j+c.k+d, where only d could change";

depComputed::usage = 
"depComputed is an option of scd (default False). If set, the scheduler assumes
that the dependency table has already been computed during a previous call to 
scd. The value of the dependency table is in $scheduleDepTable. This option 
accelerates notably the computation of the scheduler. However, be careful that 
the dependency table is not reset when loading a new program..."

saveSchedule::usage = "saveSchedule is an option of scd. If set to 
True, the schedule is saved in a file ending with .scd .";
optimisationType::usage = ""; 
*)



End[]
EndPackage[]
