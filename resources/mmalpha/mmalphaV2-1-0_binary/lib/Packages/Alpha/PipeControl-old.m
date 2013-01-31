(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Patricia Le Moenner, Patrice Quinton
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
BeginPackage["Alpha`PipeControl`",{"Alpha`Domlib`",
				   "Alpha`",
				   "Alpha`Options`",
				   "Alpha`Matrix`",
				   "Alpha`Properties`",
				   "Alpha`Tables`",
				   "Alpha`Semantics`",
				   "Alpha`Substitution`",
				   "Alpha`Normalization`",
				   "Alpha`Pipeline`",
				   "Alpha`Control`",
				   "Alpha`Alphard`",
(*
                                   "Alpha`Uniformization`", 
*)
				     "Alpha`CodeGen`Domains`"
			     }];

(* changelog:
    28/3/95 P. Quinton
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:37 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/PipeControl.m,v $
	$Revision: 1.11 $
	$Log: PipeControl.m,v $
	Revision 1.11  2009/05/22 10:24:37  quinton
	May 2009
	
	Revision 1.10  2008/12/29 17:37:02  quinton
	Minor corrections
	
	Revision 1.9  2008/11/30 11:35:07  quinton
	Commented a Print
	
	Revision 1.8  2008/09/27 11:34:03  quinton
	Correction of a small bug in pipeInfo which made pipeVars incomplete.
	
	Revision 1.7  2008/07/31 16:50:57  quinton
	The report function of PipeControl.m was extended. It is much more accurate, and it fills on the fly a global variable, $showGraph which can be user to generate a .dot file for
	GraphVis. The $showGraph variable is defined in Alpha.m. It can be used by the function
	showViz which is in VertexSchedule. Another function, showDepViz generates a .dot
	file to display the dependence graph using GraphViz.
	
	Revision 1.6  2008/07/30 15:46:22  quinton
	Improvement to the report function.
	
	Revision 1.5  2008/07/27 13:29:56  quinton
	Most recent version.
	
	Revision 1.4  2008/04/25 16:37:13  quinton
	Added a mute option, if True, absolutely no messages. Modified pipeVars, so that it executes immediately a command if it finds one that applies, instead of examining the whole program, which takes hours...
	
	Revision 1.3  2008/04/18 17:31:55  quinton
	Correction of a bug (see movementDomain)
	
	Revision 1.2  2007/04/09 18:38:03  quinton
	Modifications to pipeInfo and make sure no pipeline is done on a union of domains
	
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.45  2004/09/16 13:46:50  quinton
	Updated version
	
	Revision 1.44  2004/07/12 12:09:08  quinton
	Removed underscores in generated variables
	
	Revision 1.43  2003/08/01 15:57:44  quinton
	pipeInfo was modified in order to detect other uniformization
	situations. Could be run to pipeline programs.
	
	Revision 1.42  2003/07/16 13:24:44  quinton
	Added a report function which gives some information on a
	system.
	
	Revision 1.41  2002/10/15 12:50:49  risset
	update and commit after cvs problem
	
	Revision 1.40  2002/09/24 07:22:20  quinton
	Minor edition correction.
	
	Revision 1.39  2002/09/12 14:47:22  risset
	commit after patrice update and correction of Pipecontrol
	
	Revision 1.38  2002/09/11 13:05:21  quinton
	Now, PipeControl tries several vectors of the null space.
	
	Revision 1.37  2002/09/10 15:12:16  quinton
	option added in findPipeControl. A few minor
	corrections... There are still some problems with the delocalize
	function...
	
	Revision 1.36  2002/07/16 12:16:55  quinton
	Added the possibility of having options without the list form in pipeControl
	There was an error in eq2le et eq2ge... which was corrected.
	There was a bug in delocalizeControl, when the number of
	processor indexes is > than 2. Did no find how to fix it.
	
	Revision 1.35  2002/01/17 10:29:48  risset
	modify the Pipeline.m package for pipall with boundary
	
	Revision 1.34  2001/09/13 16:48:46  quinton
	Changed the default value of verbose option to False in some
	fonctions.
	
	Revision 1.33  2001/08/16 07:37:44  quinton
	Debug option added to pipeControl, and a bug corrected.
	
	Revision 1.32  2001/05/04 11:39:17  quinton
	Modifications to pipeInfo[].
	
	Revision 1.31  2001/01/15 09:02:01  risset
	mise a jour
	
	Revision 1.30  1999/05/27 09:31:43  risset
	commited docs
	
	Revision 1.29  1999/05/18 16:24:28  risset
	change many packages for documentation
	
	Revision 1.28  1999/05/10 13:14:14  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.27  1999/03/02 15:49:24  risset
	added GNU software text in each packages
	
	Revision 1.26  1998/12/16 13:38:34  risset
	added simplifySchedule
	
	Revision 1.25  1998/12/11 16:08:35  risset
	corrected a bug in Pipeline.m
	
	Revision 1.24  1998/11/27 12:20:17  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.23  1998/07/07 10:00:09  quinton
	I do not remember which corrections were done...
	
	Revision 1.22  1998/04/17 14:22:17  quinton
	Mise à jour

	Revision 1.21  1998/04/10 08:03:18  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.20  1998/03/12 11:28:44  risset
	Schedule.m

	Revision 1.19  1998/03/12 08:00:44  quinton
	Ajout de la fonction pipeInfo

	Revision 1.18  1998/02/16 17:06:55  risset
	Packages pass all tests

	Revision 1.16  1997/07/03 13:28:40  fdupont
	a few bugs

	Revision 1.15  1997/06/27 16:10:18  fdupont
	added control signal delocalization (delocalizeControl[])

	Revision 1.14  1997/06/26 13:12:18  fdupont
	Bug fixes to aim Alpha0v2

	Revision 1.2  1997/04/15 16:01:18  quinton
	Pas de modifs majeures.

	Revision 1.1  1997/04/15 15:32:01  quinton
	Initial revision

	Revision 1.5  1997/04/10 09:19:39  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.4  1996/06/24 13:54:47  risset
	added standard head comments for CVS



*)
(* ================ Preamble and documentation part ================ *)

     eq2ge::usage = "";
     eq2le::usage = "";

(* package documentation *)
PipeControl::usage = 
"This package contains functions to transform case expressions for the
pipeline of control variables. 
These functions are: pipeControl,
pipeAllControl, report, uniformizeMatrix, uniformizeDep, findSepHalfSpace, findPipeControl, domExplode.";

(* In this package}, usage messages are written within the Private part
   *)
pipeAllControl::usage =  
"pipeAllControl[sys, options] generates pipeline control signals 
for all the control variables present in sys (see pipeControl[]) 
and returns the modified system. pipeAllControl[options] applies 
to $result.";

pipeControl::usage = 
"pipeControl[var] generates a pipelined control signal from the
definition of variable var.  pipeControl[sys, var] does the same to
program contained in symbol sys. pipeControl checks that var is
defined using a doubly nested case expression. The current version
only covers the case when var is defined on a 2-dimensional domain,
and we assume that the first dimension is the time. The new variable
is named varPipe. pipeControl may not succeed for the following
reasons: the pipeline direction is searched among the halfspaces found
in the separating domains of the inside case expression and this
heuristics may fail. In practice, we believe that it is reasonable..."

pipeInfo::usage = 
"pipeInfo[occ:{__Integer}] returns information about pipelining
occurrence occ in $result. If the occurrence can be piped, then
pipeInfo returns a list formed by the occurence and the pipevector. 
If not, it returns $Failed. pipeInfo[] applies pipeInfo on all
dependencies of  $result. pipeInfo[ sys, occ ], or pipeInfo[ sys ] do
the same to program sys. pipeInfo has an option execute -> True|False,
When this option is set, pipeInfo executes the first pipe it has found";

execute::usage = 
"Option of pipeInfo. If True, pipeInfo tries to pipeline system,
according to the informations it has found";

pipeConstants::usage = 
"Option of pipeInfo. If True, pipeInfo tries to pipeline constants";

oneStep::usage = 
"Option of pipeInfo. If True, pipeInfo returns the first operation to perform. 
Default value is False.";

Options[ pipeInfo ] = 
  {debug -> False, verbose -> False, position -> False, 
   execute -> False, pipeConstants -> False, mute -> False, oneStep -> False};

pipeVars::usage =
"pipeVars[] executes pipeInfo until it converges, a bounded number of times";

iterations::usage = "Option of pipeVars. Gives the maximum number of times that pipeInfo can be called.";

uniformizeMatrix::usage = 
"uniformizeMatrix[ mat, contextDom ] tries to find out if mat can 
be made uniform in the context defined by contextDom, and returns 
the uniform matrix found.";

constantizeMatrix::usage = 
"constantizeMatrix[ mat, contextDom ] eliminates as many indexes 
as possible in the context defined by contextDom, and returns the 
matrix found.";

constantizeOccur::usage = 
"constantizeOccur[occ] tries to transform into constants the dependency
occ in program $result, by eliminating as many redundant indexes as
possible. The parameter occ specifies the position of the dependency,
and can be obtained using the getOccurs function.";

mkUniform::usage = 
"mkUniform[occ] uniformizes the dependence occ in $result. This
function should be called only after getting the result of uniformizeOccur";

uniformizeOccur::usage = 
"uniformizeOccur[occ] tries to uniformize the dependency occ in
program $result. The parameter occ specifies the position of the
dependency, and can be obtained using the getOccurs function.";

reportDep::usage = 
"reportDep[ repFile, occ, opts ] analyzes an dependency given by 
its occurrence occ, with options opts, and writes the report in the
output stream repFile. This function is called by report.";

report::usage = 
"report[] analyzes all dependences of $result and gives information on
it in file current.report. report has options. report[name] analyzes a
program in file name.alpha and puts the result in file name.report.";

findSepHalfSpace::usage = 
"findSepHalfSpace[exp] finds a list of separating hyperplanes for
binary case expression exp. The method is heuristic in that the
candidate hyperplanes are taken within the constraints defining the
case expression. exp can be either a String or an Ast";

findPipeControl::usage = 
"findPipeControl[x] finds if symbol x is defined using a doubly
nested case expression, and returns the list of separating hyperplanes
with time coefficient equal to 1, of the second level case expression.
This function is used in the control signal generation.";

domExplode::usage = 
"domExplode[dom] produces a list of halfspace from a domain definition.";
domExplode1::usage = 
"domExplode1[dom] produces a list of halfspace from a domain definition.";

route::usage = 
"route[ occ, {var, v}, dom1, dom2 ] routes occurence occ in $result,
between dom1 and dom2, with routing vector v."

delocalizeControl::usage = "";

isTemporalCaseEquQ::usage = "";

isSpatialCaseEquQ::usage = 
"isSpatialCaseEquQ[ eq ] is True if equation eq is a spatial case, and can
therefore be interpreted as hardware. Such an equation has the form lhs = rhs, 
where rhs is case[ dom1: var, dom2: var ] and dom1 and dom2 are contain only
constraints on the processor indexes.";

(* ===================== Private definitions ===================== *)

Begin["`Private`"]

Clear[ isSpatialCaseEquQ ];
isSpatialCaseEquQ[ eq:_equation ]:=
Catch[
Module[ { mtch, doms, res, indx },

  (* Assuming that the system is in $result *)
  Check[
    indx = getDeclarationDomain[ eq[[1]] ],
    isSpatialCaseEquQ::wrgEq = "the lhs of this equation is not declared";
    Throw[ Message[ isSpatialCaseEquQ::wrgEQ ] ]
  ];

  (* Checks the first index *)
  indx = indx[[2]];

  If[ indx[[1]] =!= "t", Return[ False ]];
  If[ Length[ indx ] === 2 && indx[[2]] =!= "p", Return[ False ]];
  If[ Length[ indx ] === 3 && indx[[2]] =!= "p1" && indx[[3]] =!= "p2", Return[ False ]];

  (* First, check that the form is a case with 2 branches *)
  mtch = 
    MatchQ[ eq[[2]], 
      case[{restrict[_domain,var[_]], restrict[_domain,var[_]]}]
    ];
  If[ !mtch, Return[ mtch ] ];

  (* Then, get the domains *)
  doms = Cases[ eq[[2]], _domain, 3 ];

  (* Project the domains over the time index *)
  res = Map[ DomProject[ #, {"t"} ]&, doms ];

  (* Check that all projections are the full space *)
  (* This means that the constraints in the domain do not involve the
     time *)
  res = Apply[ And, Map[ DomUniverseQ, res ] ]; res

]
]; (* Catch *)

isSpatialCaseEquQ[___]:=Message[isSpatialCaseEquQ::params];

Clear[ isTemporalCaseEquQ ];
isTemporalCaseEquQ[ eq:_equation ]:=
Catch[
Module[ { mtch, doms, res, indx },

  (* Assuming that the system is in $result *)
  Check[
    indx = getDeclarationDomain[ eq[[1]] ],
    isTemporalCaseEquQ::wrgEq = "the lhs of this equation is not declared";
    Throw[ Message[ isTemporalCaseEquQ::wrgEQ ] ]
  ];

  (* Checks the first index *)
  indx = indx[[2]];

  If[ indx[[1]] =!= "t", Return[ False ]];
  If[ Length[ indx ] === 2 && indx[[2]] =!= "p", Return[ False ]];
  If[ Length[ indx ] === 3 && indx[[2]] =!= "p1" && indx[[3]] =!= "p2", Return[ False ]];

  (* First, check that the form is a case with 2 branches *)
  mtch = 
    MatchQ[ eq[[2]], 
      case[
        {restrict[
           _domain, 
           if[
              _var,
              case[{restrict[___],restrict[___]}],
              case[{restrict[___],restrict[___]}]
           ]
         ]
        }
      ]
    ];

  If[ !mtch, Return[ mtch ] ];

  (* Then, get the domains *)
  doms = Cases[ eq[[2]], _domain, Infinity ];

  (* Remove time index *)
  indx = Drop[ indx, 1 ];

  (* Project the domains over the time index *)
  res = Map[ DomProject[ #, indx ]&, doms ];

  (* Check that all projections are the full space *)
  (* This means that the constraints in the domain do not involve the
     processors *)
  res = Apply[ And, Map[ DomUniverseQ, res ] ]; res

]
]; (* Catch *)

isSpatialCaseEquQ[___]:=Message[isSpatialCaseEquQ::params];


Clear[pipeName];
pipeName[v:_Symbol]:=
  StringReplace[ "pipe"<>ToString[ Unique[v] ], "$"->"" ];
pipeName[v:_]:=
  StringReplace[ "pipe"<>ToString[ Unique["C"<>ToString[v]] ], "$"->"" ];
pipeName::params = "wrong parameters";
pipeName[___]:=Message[pipeName::params];

Clear[ uniformizeMatrix ]; 

uniformizeMatrix::nonsquare = "matrix `1` is not square";

uniformizeMatrix::args = "first argument should be an alpha matrix, and second
one a domain";

uniformizeMatrix::noeq = "no equalities in domain";

uniformizeMatrix[mat:Alpha`matrix[d_,d1_,ind_,m_],cs_Alpha`domain]:=
Catch[
  Module[{mm,index1,index2,ss,dbg,defm},
    (* If matrix already uniform, return input *)
    If[uniformQ[mat],Throw[mat]];

    (* check square matrix *)
    If[d=!=d1,Throw[(Message[uniformizeMatrix::nonsquare,mat];$Failed)]];

    (* build {"i1","i2", ...} *)
    index2=ToExpression[Table["i"<>ToString[i],{i,d-1}]];

    (* build {"i1","i2", ..., 1} *)
    index1=Append[index2,1];

    (* get equalities from m *)
    mm=Drop[m,-1].index1;
    If[ dbg, Print["equalities: ", mm ] ];

    (* build {"di1","di2", ... } *)
    index3=ToExpression[Table["di"<>ToString[i],{i,d-1}]];
    cc = eqsDomain[cs];
    If[ dbg, Print["Equations of domain: ", cc ] ];

    (* Do not send a message, unless debug option *)
    If[cc=={}&&dbg, Print[uniformizeMatrix::noeq]];
    If[cc=={},Throw[$Failed]];

    cc = cc.index1; (* get the equalities of cs *)
    cc = Map[Equal[#1,0]&,cc]; (* translate into mma equalities *)

    (* call solve, solving for di1, di2, etc, eliminating 
      i1,i2, ... *)
    If[ dbg, Print["Calling solve with\, ", 
      Union[MapThread[Equal[#1,#2]&,{index2+index3,mm}],cc],
      index3,
      Drop[index1,-1]
      ]
    ];

    Off[ Solve::svars ];
    ss = Solve[Union[MapThread[Equal[#1,#2]&,{index2+index3,mm}],cc],
	 index3,Drop[index1,-1]];
    On[ Solve::svars ];

    If[ Length[ss[[1]]]=!=d-1, Throw[$Failed] ];
    ss = Map[#1[[2]]&,ss[[1]]]; (* get Vecteur *)

    If[ !And@@Map[IntegerQ,ss], Throw[$Failed],
       translationMatrix[ind,ss]
    ]
  ]
];
uniformizeMatrix[mat_,cs_]:=(Message[uniformizeMatrix::args];{});

(* *)
Clear[ mkUniform ];
Options[uniformizeOccur] = {verbose -> False, debug -> False, 
  execute -> False };

mkUniform[ occ:{___Integer}, opts:___Rule ] :=
Catch[
  Module[ {r, dbg},
    dbg = debug/.{opts}/.Options[mkUniform];
    Check[ r = uniformizeOccur[ occ, opts ], 
      mkUniform::failed = "mkUniform did not succeed";
      Throw[ Message[ mkUniform::failed ] ] ];
    If[ !MatchQ[ r, _matrix ], 
      If[ dbg, Print["Occurrence : ", occ ] ];
      Throw[ Message[ mkUniform::failed ] ] 
    ];
    If[ dbg, Print[ ashow[ r, silent -> True ] ] ];
    $result = ReplacePart[ $result, r, Append[ occ, 2 ] ]
  ]
];

mkUniform[___] := Message[ mkUniform::args ];

(* *)
Clear[uniformizeOccur];

Options[uniformizeOccur] = {verbose -> False, debug -> False, 
  execute -> False};

uniformizeOccur::args = "wrong parameters.";
uniformizeOccur::position = "wrong position.";
uniformizeOccur::notaffine = "position is not an affine dependency."
uniformizeOccur::nonsquare = "dependence matrix is not square.";
uniformizeOccur::getcontext = "error while computing the context domain.";

uniformizeOccur[occ:{__Integer},opts___]:=
  Catch[
    Module[ {dep, mat, varname, optverbose, ctxdom, res, defm, 
      optdebug, optexecute},
	dep = Check[getPart[$result,occ],
          Throw[Message[uniformizeOccur::position]]];

        optverbose = verbose/.{opts}/.Options[uniformizeOccur];
        optdebug = debug/.{opts}/.Options[uniformizeOccur];
        optexecute = execute/.{opts}/.Options[uniformizeOccur];

	If[ optdebug, Print["Dependency: ", ashow[dep, silent ->True ]]];
	If[ !MatchQ[ dep, affine[___] ], 
          Throw[ Message[ uniformizeOccur::position ] ]];

	varname = dep[[1,1]]; mat = dep[[2]];

        If[ !squareMatrixQ[mat],Throw[ Message[ uniformizeOccur::nonsquare]]];

	If[ uniformQ[mat],
	   If[ optdebug, Print["is uniform"]];Throw[mat]];

	ctxdom = 
          Check[ getContextDomain[occ], Throw[uniformizeOccur::getcontext] ];

	If[ optdebug, 
          Print["Context domain: ", ashow[ctxdom, silent->True], occ]];

	(* Do not print messages *)
	defm = $Messages;
        $Messages = {}; 
        res = 
          Check[ uniformizeMatrix[ mat, ctxdom ],
	      $Failed
	]; 
        $Messages = defm; 
     res
   ] (* module *)
  ]; (* catch *)
uniformizeOccur[___]:=Message[uniformizeOccur::args];

Clear[constantizeMatrix];

constantizeMatrix::args = "first argument should be an alpha matrix, and second
one a domain";

constantizeMatrix::noeq = "no equalities in domain";

constantizeMatrix[ mat:Alpha`matrix[d_,d1_,ind_,m_],cs_Alpha`domain, opts:___Rule]:=
  Catch[
    Module[{ mm, index1, index2, ss, dbg, newMat},
      (* Options *)
      dbg = debug/.{opts}/.Options[constantizeOccur];    
      (* build {"i1","i2", ...} *)
      index2 = ToExpression[Table["i"<>ToString[i],{i,d-1}]];
      (* build {"i1","i2", ..., 1} *)
      index1 = Append[index2,1];
      (* get equalities from m *)
      mm = Drop[m,-1].index1;
      (* build {"di1","di2", ... } *)
      index3 = ToExpression[Table["di"<>ToString[i],{i,d-1}]];
      cc = eqsDomain[cs];
      (* No equalities in domain *)
      If[cc=={},Throw[(Message[uniformizeMatrix::noeq];$Failed)]];
      cc = cc.index1; (* get the equalities of cs *)
      cc = Map[Equal[#1,0]&,cc]; (* translate into mma equalities *)
      (* call solve, solving for di1, di2, i1, i2, ... *)
      ss = Solve[ 
          Union[ MapThread[ Equal[#1,#2]&, {index3, mm}], cc],
          Join[ index3, Drop[index1,-1] ] 
           ];
      If[ dbg, Print["Result of solving:",  ss ]];
           
      (* Pick up the first d results *)
      ss = Take[ ss[[1]], d - 1 ];
      (* Transform into string, and replace 1st and last char by ( and ) *)
      ss = "(" <> 
           StringDrop[ StringDrop[ ToString[ Map[ #[[2]]&, ss ] ], 1 ], -1 ] <>
           ")"; 
      (* Insert indexes *)
      ss = 
        StringInsert[ 
          ss, 
          StringDrop[ StringDrop[ ToString[ index2 ], 1 ], -1 ]<>" -> ",
          2 
        ];
      If[ dbg, Print[ ss ]];
      (* Parse matrix *)
      newMat = readMat[ ss ]; 
      (* Replace index by indexes of initial matrix *)
      newMat = ReplacePart[ newMat, ind, 3 ]; 
      If[ dbg, Print[ newMat ] ]; 
      newMat

   ] (* End Module *)
]; (* End Catch *)
constantizeMatrix[mat_,cs_]:=(Message[constantizeMatrix::args];{});

(* *)
Clear[constantizeOccur];
Options[constantizeOccur] = {verbose -> False, debug -> False};

constantizeOccur::args = "wrong parameters.";
constantizeOccur::position = "wrong position.";
constantizeOccur::notaffine = "position is not an affine dependency."
constantizeOccur::getcontext = "error while computing the context domain.";

constantizeOccur[occ:{__Integer},opts___]:=
  Catch[
    Module[ {dep, mat, varname, optverbose, ctxdom, res, defm, optdebug},
	dep = Check[getPart[$result,occ],Throw[Message[uniformizeOccur::position]]];
        optverbose = verbose/.{opts}/.Options[uniformizeOccur];
        optdebug = debug/.{opts}/.Options[uniformizeOccur];
	If[ optdebug, Print["Dependency: ", ashow[dep, silent ->True ]]];
	If[ !MatchQ[ dep, affine[___] ], Throw[ Message[ uniformizeOccur::position ] ]];
	varname = dep[[1,1]]; mat = dep[[2]];
	ctxdom = 
          Check[ getContextDomain[occ, opts], 
                 Throw[uniformizeOccur::getcontext]];

	If[ optdebug, 
            Print["Context domain: ", ashow[ctxdom, silent->True], " occurence: ", occ] ];
	(* Do not print messages *)
	defm = $Messages;
        $Messages = {}; 
        (* Do not check *)
        res = constantizeMatrix[ mat, ctxdom, opts];
        $Messages = defm; res
	 ] (* module *)
  ]; (* catch *)
constantizeOccur[___]:=Message[constantizeOccur::args];

(* *)
Clear[report];

Options[report] = 
  {
   verbose -> False, debug -> False, position -> False, 
   showUniformDeps -> True,
   showNonUniformDeps -> True, 
   showSquareDeps -> True, 
   showNonSquareDeps -> True, 
   showUniformizableDeps -> True, 
   showNonUniformizableDeps -> True
  };
report::args = "Wrong arguments.";
report::input = "$result is not a system. You probably forgot to load a program.";

(* Change on April 26, 2003. *)
report[fileName:_String, opts:___Rule]:=
Catch[ 
Module[ {repFile, listOflhs, res},
  (* Load system *)
  Check[ load[ fileName<>".alpha" ], 
    report::noFile = "no file `1`.alpha";
    Throw[ Message[report::noFile, fileName ] ]
  ];

  (* To clear report file *)
  repFile = OpenWrite[ fileName<>".report" ];

  (* Put some info *)
  WriteString[repFile, "Reporting on system: ", $result[[1]], "\n" ];
  WriteString[repFile, "  System was in $result  \n"];
  WriteString[
    repFile, 
    Date[][[3]],"/",Date[][[2]],"/",Date[][[1]]," -- ",
    Date[][[4]],"h ",Date[][[5]],"mn ",Date[][[6]],"s"
  ];

  listOflhs = Cases[$result, equation[s_, _] -> s, Infinity];
  res = 
  Map[ 
    Function[ s, 
      report[ repFile, s, opts] ],
    listOflhs
  ];

  (* Remove empty lists of res *)
  res = Select[ res, #1=!={}& ]; 

  (* Call the resource analysis *)
  analyzeResources[ repFile, res ];

  Close[ repFile ];

]
];

(* Change on April 26, 2003. *)
report[opts:___Rule]:=report["current",opts];
report[name:_String, opts:___Rule]:=
Module[ {repFile, listOflhs, res, listOfEq },
  (* To clear report file *)
  repFile = OpenWrite[ name<>".report" ];

  (* Put some info *)
  WriteString[repFile, "Reporting on system: ", $result[[1]], "\n" ];
  WriteString[repFile, "  System was in $result  \n"];
  WriteString[
    repFile, 
    Date[][[3]],"/",Date[][[2]],"/",Date[][[1]]," -- ",
    Date[][[4]],"h ",Date[][[5]],"mn ",Date[][[6]],"s\n\n"
  ];

  WriteString[repFile, "System:\n", ashow[ silent -> True ] ];

  (* Get the lhs in the order of the equations *)
  listOflhs = Cases[$result, equation[s_, _] -> s, Infinity];

  res = 
  Map[ 
    Function[ s, 
      report[ repFile, s, opts] ],
    listOflhs
  ];

  (* List equations that cannot be interpreted as hardware *)
  listOfEq = MapThread[ List, {res,Cases[$result,equation[__],Infinity]} ];
  listOfEq = Select[ listOfEq, #[[1]] === {}& ];
  If[ listOfEq =!= {}, 
    WriteString[ repFile, "\n\n---- These equations cannot be translated to hardware:\n" ],
    WriteString[ repFile, "\n\n---- All equations can be translated to hardware:\n"]
  ];
  Map[ WriteString[ repFile, ashow[#[[2]], silent->True]<>"\n" ]&, listOfEq];

  (* Remove empty lists of res *)
  res = Select[ res, #1=!={}& ]; 
  (* Print[ res ]; *)
  $showGraph = res;

  (* Now take care of the use statements *)
  WriteString[ repFile, "\n\n---- Use statements:\n"];
  listOfuse = Cases[$result, use[__], Infinity];
  res2 = 
  Map[ 
    Function[ u, 
      report[ repFile, u, opts] ],
    listOfuse
  ];


  (* Call the resource analysis *)
  If[ res =!= {}, analyzeResources[ repFile, res ],
    WriteString[ repFile, "\n  ** No resources used\n" ] ];

  Close[ repFile ];

];

(* Report on one single equation *)
report[ repFile:_, lhs:_String, opts:___Rule]:=
Module[
 {mm, deps, optverbose, optdebug, nonSquareDeps, nonUniformDeps, 
  squareDeps, optposition, optsqd, optnsqd, optud, optnud,
  optuzabled, optnuzabled, eq, rhs, eqPosition, res},

  optverbose = verbose/. {opts}/. Options[report];
  optdebug = debug /. {opts} /. Options[report];
  optposition = position /. {opts} /. Options[report];
  optsqd = showSquareDeps /. {opts} /. Options[report];
  optnsqd = showNonSquareDeps /. {opts} /. Options[report];
  optud = showUniformDeps /. {opts} /. Options[report];
  optnud = showNonUniformDeps /. {opts} /. Options[report];
  optuzabled = showUniformizableDeps /. {opts}
   /. Options[report];
  optnuzabled = showNonUniformizableDeps /. {opts}
   /. Options[report];

  (* This Catch is to close the file, in case of error *)
  Catch[ 

    (* Check that $result is a system... *)
    If[ 
      Not[ MatchQ[ $result, _system ]], 
	Throw[ Message[ report::input ] ] 
    ];

    (* First, check that lhs is a correct variable, i.e., either
        an output or a local variable *)
    Check[
      eq = getEquation[ lhs ],
        report::noEq = "there is no equation defining `1`";
      Throw[ Message[ report::noEq, lhs ] ]
    ];

    (* Call a function to analyze the equation, if not input equation *)
    (* The analysis, besides wrinting stuff in the report file, returns 
       a diagnosis regarding the type of equation. If the result is the 
       empty list, the equation is not hardware interpretable. Otherwise,
       it is either an input, an output, a register, a connection, a spatial 
       equation, a control equation, an operator 
    *)
    res = analyzeEquation[ repFile, eq, lhs ];

    (* If we have an input equation, we are done *)
    If[ res =!= {}, 
      WriteString[repFile, "  ** This equation can be interpreted as hardware"];
      Return[ res ] 
    ];

    (* *)
    WriteString[repFile, "  ** This equation cannot be interpreted as hardware\n"];
    (* Get right-hand side *)
    rhs = getDefinition[ lhs ];

    (* Quit, if input equation *)

    (* Get equation position *)
    eqPosition = First[ Position[ $result, equation[ lhs, _ ] ] ]; 

    (* Look for the list of dependencies of this equation *)
    deps = Position[rhs, affine[_var,_matrix]];
    deps = Map[ Join[ eqPosition, {2}, # ]&, deps ];

    If[ deps === {}, 
      WriteString[ repFile, "  ** No dependency\n" ] ];

    (* For each dependence, call function reportDep *)
    report::error = "error while calling reportDep"; 
    Map[
      Check[ reportDep[ repFile, #1, opts ], Throw[ report::error ] ]&, 
      deps
    ];
  ]; (* Catch *)
  res
];

(* Analysis of a use statement *)
report[ repFile:_, useStat:_use, opts:___Rule]:=
Module[
 {mm, deps, optverbose, optdebug, nonSquareDeps, nonUniformDeps, 
  squareDeps, optposition, optsqd, optnsqd, optud, optnud,
  optuzabled, optnuzabled, calledSys, result, calledDom},

  optverbose = verbose/. {opts}/. Options[report];
  optdebug = debug /. {opts} /. Options[report];
  optposition = position /. {opts} /. Options[report];
  optsqd = showSquareDeps /. {opts} /. Options[report];
  optnsqd = showNonSquareDeps /. {opts} /. Options[report];
  optud = showUniformDeps /. {opts} /. Options[report];
  optnud = showNonUniformDeps /. {opts} /. Options[report];
  optuzabled = showUniformizableDeps /. {opts}
   /. Options[report];
  optnuzabled = showNonUniformizableDeps /. {opts}
   /. Options[report];

  calledSys = useStat[[1]];
  calledDom = useStat[[2]];
  results = useStat[[5]];
  WriteString[ repFile, "\n  ** Use statement:\n"];
  WriteString[ repFile, "    ** name: ", calledSys, "\n"];
  WriteString[ repFile, "    ** extension domain ", 
    ashow[ calledDom, silent -> True ], "\n" ];
  WriteString[ repFile, "    ** results: ", results, "\n"];

	
];
report[___]:=Message[report::args];

Clear[ analyzeResources ];
analyzeResources[ repFile:_, res:_]:=
Module[ {nbregInt, nbregReal, nbmuxInt, nbmuxReal, 
  nbop, nbop1, nbmul, nbaddsub},
  (* The result of report is a list of records describing the
     used resources *)

  WriteString[ repFile, "\n\n------\n  **** Resources used:\n" ];
  nbregInt = Select[ res, MatchQ[ #1, {"register", integer|integer[__], __ }]& ];
  nbregInt = Apply[ Plus, Map[ Part[#1,3]&, nbregInt ] ]; 
  nbregReal = Select[ res, MatchQ[ #1, {"register", real, __ }]& ];
  nbregReal = Apply[ Plus, Map[ Part[#1,3]&, nbregReal ] ]; 

  If[ nbregInt =!= 0, 
    WriteString[ repFile, "  ", nbregInt, " integer registers\n" ]
  ];
  If[ nbregReal =!= 0, 
    WriteString[ repFile, "  ", nbregReal, " floating-point registers\n" ]
  ];

  nbmux = Select[ res, MatchQ[ #1, {"mux", integer|integer[__]|real, __ }]& ];
  WriteString[ repFile, "  ", Length[nbmux], " integer or floating-point mux\n" ];

  (* Analysis of operators *)
  nbop = Select[ res, (#1[[1]] == "binop") || (#1[[1]] == "unop") ||
                      (#1[[1]] == "mux")  && 
    MatchQ[#1[[2]],integer|integer[__]|real]& ];

  (* nbop1 is the list formed by all operators appearing in a binop list *)
  nbop1 = Map[ Part[#1,3]&, nbop ];
  (* nbop2 is the list formed by the binop lists, less the operators *)
  nbop = Map[ Drop[#1,{3,3}]&, nbop ];

  (* We distribute the operators *)
  nbop = 
    MapThread[ 
      Function[ {l1,l2}, Map[ Function[ {x}, Prepend[l1,x] ], l2 ] ],
      {nbop,nbop1}
    ];
  nbop = Flatten[ nbop,1 ];

  (* Number of elements *)
  nbmul = Select[ nbop, First[#1]===mul&];
  WriteString[ repFile, "  ", Length[nbmul], " multipliers \n"];
  nbaddsub = Select[ nbop, First[#1]===add || First[#1]===sub&];
  WriteString[ repFile, "  ", Length[nbaddsub], " adders/subtracters \n"];

  WriteString[ repFile, "  ** Analysis of operators\n" ];
  Map[ 
    If[ #1[[4]] === #1[[5]], 
      WriteString[ repFile, "  ", #1[[1]], " at ", #1[[4]], "\n" ],
      WriteString[ repFile, "  ", #1[[1]], " from ", #1[[4]], 
        " to ", #1[[5]], "\n" ]
    ]&,
    nbop
  ];
];
analyzeResources[___]:=Message[analyzeResources::args];

Clear[ analyzeEquation ];
analyzeEquation[ repFile:_, eq:_, lhs:_ ]:=
Catch[
  Module[ 
    {rhs, eqPosition, idEquation, inputEquation, localEquation,
     outputEquation, mirrorEquation, declar, indexes, lgIndexes,
     scheduled1d, scheduled2d, allocated, register, operators, type,
     declarDom, regEq, regNumber, connectEq, ub, lb, muxEq, binops,
     unops,error,dbg,scalar,controlEq,connexionEq},

    dbg = False; 
    (* Get declaration of equation *)
    declar = getDeclaration[ lhs ]; 

    (* Get right-hand side *)
    rhs = getDefinition[ lhs ];

    (* Get equation position *)
    eqPosition = First[ Position[ $result, equation[ lhs, _ ] ] ]; 

    (* Print equation *)
    If[ optverbose, Print[ ashow[ getEquation[ lhs ] ] ] ];

    (* Write equation in report file *)
    WriteString[  repFile, "\n\n-- Equation: \n" ];
    WriteString[  repFile, "    ",
         ashow[ getEquation[ lhs ], silent->True ], "\n" ];

    (* Write declaration *)
    WriteString[  repFile, "  ** Declaration: \n" ];
    WriteString[  repFile, "    ", ashow[ getDeclaration[ lhs ], silent->True], "\n" ];

    (* Write type of lhs *)
    type = declar[[2]];
    WriteString[ repFile, "  ** Type is: ", type, "\n"];

    (* Write type of equation, i.e., output or local *)
    outputEquation = MemberQ[ getOutputVars[], lhs ];
    If[ outputEquation, 
      WriteString[ repFile, "  ** Output equation\n" ] ];

    (* See if input equation *)
    inputEquation = 
      (MatchQ[ rhs, var[v:_]/; MemberQ[ getInputVars[], v ]]||
      MatchQ[ rhs, affine[var[v:_],_]/; MemberQ[ getInputVars[], v ]]);
    localEquation = !outputEquation && !inputEquation;

    If[ inputEquation, 
      WriteString[ repFile, "  ** Input equation\n" ] ];

    If[ localEquation, 
      WriteString[ repFile, "  ** Local equation\n" ] ];

    (* Get parameters *)
    params = getSystemParameters[$result];

    (* Quit if input equation. Return no resources *)
    If[ inputEquation, Return[{"input", lhs, 
      Cases[ rhs, var[x:_] -> x, Infinity ]} ] ];

    (* Write indexes of equation *)
    indexes = Drop[ declar[[3,2]], -Length[params] ];
    WriteString[ repFile, "  ** Indexes: ", indexes, "\n"];
    lgIndexes = Length[ indexes ];

    (* See if scheduled *)
    Which[

      (* This is a scalar *)
      lgIndexes === 0
    , 
      scalar = True;
      scheduled1d = False; scheduled2d = False; allocated = False; 
      WriteString[ repFile, "  ** Scalar\n" ]
    ,
      (* One dimension of time, no allocation *)
      (lgIndexes === 1)&&(indexes[[1]] === "t")
    ,
       scheduled1d = True; scheduled2d = False; allocated = False; 
       WriteString[ repFile, "  ** Scheduled, one time dimension\n" ]
    ,
      (* One dimension of time and several dim of processors *)
      (lgIndexes === 2)&&(indexes[[1]] === "t")&&
      (indexes[[2]] === "p")
    ,
      scheduled1d = True; scheduled2d = False; allocated = True; 
      WriteString[ repFile, "  ** Scheduled and allocated, one time dimension and one space dimension\n" ]
    ,
      (* One dimension of time and several dim of processors *)
      (lgIndexes > 2)&&(indexes[[1]] === "t")&&
      (indexes[[2]] === "p1")&&(indexes[[3]] === "p2")
    ,
      scheduled1d = True; scheduled2d = False; allocated = True; 
      WriteString[ repFile, "  ** Scheduled and allocated, one time dimension and two space dimension\n" ]
    ,
      (lgIndexes >= 2)&&(indexes[[1]] === "t")&&
      (indexes[[2]] =!= "p")&& (indexes[[2]] =!= "p1")
    ,
        scheduled1d = True; sheduled2d = False; allocated = False; 
        WriteString[ repFile, "  ** Scheduled and not allocated, one time dimension\n" ]
    ,
      (lgIndexes >= 2)&&(indexes[[1]] === "t1")&&
      (indexes[[2]] === "t2"),
        scheduled1d = False; scheduled2d = True; allocated = False; 
        WriteString[ repFile, "  ** Scheduled, more than one time dimension\n" ]
    ];


    (* Check various properties *)
(*
    If[ spatialCaseQ[ rhs ], Print[" spatial case "] ];

    (* Check various properties *)
    If[ temporalCaseQ[ rhs ], Print[" temporal case "] ];
*)

    If[ isConnexionEqQ[ eqPosition ], Print[" temporal case "] ];

    (* Check if identity equation *)
    idEquation = (MatchQ[ eq, equation[ lhs, var[_] ] ]||
        MatchQ[ eq, equation[ lhs, affine[ var[_], m:_ ] ]/;identityQ[m] ]);
    If[ idEquation, 
      WriteString[ repFile, "  ** Identity equation\n" ] ];

    (* Find out if mirror equation *)
    mirrorEquation = 
      (MatchQ[ eq, equation[ lhs, var[v:_]/; MemberQ[ getInputVars[], v] ] ]||
        MatchQ[ eq, equation[ lhs, affine[ var[v:_], m:_ ] ]/;
          (identityQ[m]&& MemberQ[ getInputVars[], v ])]);
    If[ mirrorEquation, 
      WriteString[ repFile, "  ** Mirror equation\n" ] ];

    (* If the equation is local and identity and not mirror, 
       then it could be removed *)
    If[ idEquation && localEquation && !mirrorEquation, 
      WriteString[ repFile, "  ** Definition of "<>lhs<>
        " could be removed\n" ] ];

    (* Find out if equations is a register, a mux, a connection
       or a computation equation *)
    connectEq = False; regEq = False; regNumber = 0; 
    muxEq = False; operatorEq = False; 

    (* We do this only if one dimensional schedule *)
    If[ scheduled1d, 

      Which[
        (* A register, or a connection *)
        MatchQ[ rhs, affine[_,m:_]/;translationQ[m] ]
      ,
        Module[ { tv, m },
          m = rhs[[2]];
          tv = getTranslationVector[m];
          Which[ 
            tv[[1]] <0
          , 
            regEq = True; regNumber = -tv[[1]];
            WriteString[ repFile, "  ** ",type," Register\n" ]
          ,
            allocated
          ,
            connectEq = True; 
            WriteString[ repFile, "  ** Connection\n" ]
          ] (* Which *)
        ]
      ,
        (* *)
        isTemporalCaseEquQ[ eq ]
      ,
        muxEq = True;
        WriteString[ repFile, "  ** Temporal case equation\n" ];
        WriteString[ repFile, "  ** ",type," Mux\n" ]
      , 
        (* Another style of mux *)
        MatchQ[ rhs, if[var[_], var[_], var[_]] ]
      ,
        muxEq = True;
        WriteString[ repFile, "  ** Multiplexer\n" ];
        WriteString[ repFile, "  ** ",type," Mux\n" ]
      ,
        (* Otherwise, it could be an operator *)
        True
      , 
        binops = Cases[ rhs, binop[op:_,_,_]->op, {0,Infinity}];
        unops = Cases[ rhs, unop[op:_,_]->op, {0,Infinity}];
        If[ Length[binops] >0|| Length[unops]>0, 
          operatorEq = True; 
          WriteString[ repFile, "  ** Combinatorial logic\n" ];
          WriteString[ repFile, "  ** Binops: ", binops,"\n" ];
          WriteString[ repFile, "  ** Unops: ", unops,"\n" ]
        ]
      ]; (* Which *)

    ];

    (* If the equation is a connection, just return it *)
    If[ connectEq, Return[{"connect", lhs, 
      Cases[ rhs, var[x:_] -> x, Infinity ]} ] ];

    (* If the equation is a control equation, signal it *)
    If[ isControlEquQ[ eq ], 
      WriteString[ repFile, "  ** Control equation\n" ]; 
      Return[{"control equation", lhs, "tt", "ff"}]
    ];

    (* If the equation is a connection equation, signal it *)
    If[ isConnexionEqQ[ eq ], 
      WriteString[ repFile, "  ** Connection equation\n" ]; 
      Return[{"connection equation", lhs,
         Cases[ rhs, var[x:_] -> x, Infinity ]} ] 
    ];

    (* If the equation is a mirror equation, signal it *)
    If[ isMirrorEqQ[ eq ], 
      WriteString[ repFile, "  ** Mirror equation\n" ]; 
      Return[{"mirror equation", lhs, 
        Cases[ rhs, var[x:_] -> x, Infinity ]} ] 
    ];

    (* If the equation is a spatial case equation, signal it *)
    If[ isSpatialCaseEquQ[ eq ], 
      WriteString[ repFile, "  ** Spatial case equation\n" ]; 
      Return[{"spatial equation", lhs,          
        Cases[ rhs, var[x:_] -> x, Infinity ]} ] 
    ];

    (* If the equation uses resources, one give its time 
      domain *)
    If[ regEq||muxEq||operatorEq, 
      declarDom = declar[[3]];
      Check[ 
        If[ dbg, Print["domain: ", show[ declarDom, silent -> True ] ] ];
        If[ dbg, Print["pdim: ", Length[params] ] ];
        bounds = computeBounds[ declarDom, Length[params],{}];
        If[ dbg, Print[ "bounds: ", bounds ] ],
        Null
      ];
      Which[ 
        bounds ==={}
      , 
        Print["error: ", ashow[ declarDom, silent -> True ] ]
      ,
        bounds[[1,1]] === {}
      ,
        lb = bounds[[1,2]]/.Floor[x:_]->x;
        ub = bounds[[1,3]]/.Ceiling[x:_]->x;
        WriteString[ repFile, "  ** Valid from ", lb, " <= t <= ", ub, "\n" ]
      ,
        bounds[[1,1]] =!= {}
      ,
        lb = bounds[[1,1]]; ub = bounds[[1,1]];
        WriteString[ repFile, "  ** Valid at t = ", lb, "\n" ]
      ]
   ];

    res = 
    Join[
      If[ regEq, {"register", type, regNumber, lb, ub, lhs, 
	Cases[ rhs, var[x:_] -> x, Infinity ]}, {} ],
      If[ muxEq, {"mux", type, {"mux"}, lb, ub, lhs, 
	Cases[ rhs, var[x:_] -> x, Infinity ]}, {} ],
      If[ operatorEq&&Length[binops]>0, {"binop", type, binops, lb, ub, lhs, 
	Cases[ rhs, var[x:_] -> x, Infinity ]}, {} ],
      If[ operatorEq&&Length[unops]>0, {"unop", type, unops, lb, ub, lhs, 
	Cases[ rhs, var[x:_] -> x, Infinity ]}, {} ]
    ]
  ]
];
analyzeEquation[___]:=Message[analyzeEquation::args];
Clear[ reportDep ];
reportDep[ repFile:_, dep:{___Integer}, opts:___Rule ]:=
Module[ {mat, squareDep, uniform, uniformizable}, 

  Catch[

  (* Print dependency *)
  WriteString[ repFile, "  ** Dependency: " ];
  WriteString[ repFile, 
    ashow[ getPart[ $result, dep ], silent -> True ]
  ];
  WriteString[ repFile, "\n     Occurrence: ", dep, "\n" ];

  (* Get matrix *)
  mat = getPart[ $result, dep ][[2]];

  (* Check non square dependencies *)
  squareDep = squareMatrixQ[ mat ];

  If[ squareDep, 
    WriteString[ repFile, "    ** is square\n"],
    WriteString[ repFile, "    ** is not square\n" ];
  ];


  (* Is dep uniform? *)
  uniformDep = (squareDep && uniformQ[ mat ]);

  (* If uniform, report, and return *)
  If[ uniformDep, 
    WriteString[ repFile, "    ** is uniform\n"];
    Throw[ Null ]
  ];

  (* If non uniform and square, try to uniformize it *)
  WriteString[ repFile, "    ** is not uniform\n"];
  If[ squareDep, 
    mat1 = uniformizeOccur[ dep, opts ]
  ];
  uniformizable = (mat1 =!= $Failed); 

(* 
    If[ uniformizable, 
      WriteString[ repFile, "     ** can be uniformized\n"];
      WriteString[ repFile, "    "<>" -> Execute the command:" ];
      WriteString[ repFile, 
        "    mkUniform[ "<>ToString[ dep ]<>" ]\n"];
      Throw[ Null ]
    ]
*)

  (* Dep is non square, call pipeInfo *)
  Check[
    pipeInfo1 = pipeInfo[ dep, opts ],
    Print[ dep ]; ashow[ getPart[ $result, dep ] ]; Throw[ Null ]
  ];
  If[ pipeInfo1 === {}, 
    WriteString[ repFile, "    ** No possible pipeline\n" ],
    WriteString[ repFile, "    ** Possible pipeline: \n", 
      "     -> Execute the command: ", pipeInfo1, "\n" ]
  ];

  ]; (* Catch *)  
];

(* pipeVars *)
Clear[ pipeVars ];
Options[ pipeVars ] = {debug -> False, verbose -> False, iterations -> 20, mute -> False};
pipeVars[ opts:___Rule ] := 
  Module[ {it, end, morePipe, res, maxit, optMute},
    maxit = iterations/.{opts}/.Options[ pipeVars ];
    optMute = mute/.{opts}/.Options[ pipeVars ];

    it = 0;           (* Number of iterations done *)
    morePipe = True;  (* True if something to pipe *)
    ended = (it >= maxit) || !morePipe ;  (* True if one should stop *)
    While[ !ended, 
      res = pipeInfo[ opts, execute -> True, verbose -> False, mute -> optMute, oneStep -> True ];
      it = it+1;
      morePipe = (res =!= {});   (* Something to pipeline *)
      ended = ((it >= maxit) || !morePipe) ;
    ];
    If[ it >= maxit, 
	Print["Warning. There are still variables to pipeline..."]
    ];
  ];
pipeVars[___] := Message[ pipeVars::params ];

(* pipeInfo *)
Clear[ pipeInfo ];
pipeInfo::position = "parameter is not a position in $result."; 

pipeInfo::notaffine = "position does not give an affine dependency."

pipeInfo::mbUnion = 
"could not run DomEqualities properly. Does not apply to unions of
domains."

pipeInfo::errDomImage = 
"Error while computing image of domain."; 

pipeInfo[ opts:___Rule ] := pipeInfo[ $result, opts ];

pipeInfo[ sys:_system, opts:___Rule ]:=
Module[ {v,c,dbg,pi,exec,piv,pic,dept,vrb,optMute,optOneStep},

  dbg = debug /. {opts} /. Options[ pipeInfo ];
  exec = execute /. {opts} /. Options[ pipeInfo ];
  cst = pipeConstants /. {opts} /. Options[ pipeInfo ];
  vrb = verbose /.{opts}/. Options[ pipeInfo ];
  optMute = mute /.{opts}/. Options[ pipeInfo ];
  optOneStep = oneStep/.{opts}/.Options[ pipeInfo ];

  If[ optMute, vrb = False ];

  (* Before going on, look for non uniform dependences *)
(*
  I dropped this part, since it requires dependencies to
  be square, and is subsumed by uniformizeOccur

  dept = getDependences[];

  If[ dept =!= {}, 
    Print["Dependences to uniformize : "];
    ashow[dtable[dept]];
    Print["Run: Map[uniformize, getDependences[]]"]
  ];

*)
  (* All occurrences of variables *)
  v = getOccurs[ affine[ _var, _matrix ] ];
  v = Union[ v ];

  (* All occurrences of constants *)
  c = getOccurs[ affine[ _const, _matrix ] ];
  c = If[ cst, Union[ c ], {} ];

  If[ dbg, Print[v] ];
  If[ dbg, Print[c] ];

  If[ dbg, Print["Analyzing variables"]]; 

  (* Option oneStep : one stops looking as soon as one possibility is found *)
  If[ optOneStep, 
    Module[ { lv, fv },
      piv = {}; lv = v;
      While[ piv === {} && lv =!= {}, 
        piv = pipeInfo[ sys, First[ lv ], opts ];
        lv = Drop[ lv, 1 ];
      ];
    ]
  ,
    piv = Map[ pipeInfo[ sys, #1, opts]& , v ];
  ];

  If[ !ListQ[ piv ], piv = {piv} ];
  If[ dbg, Print["piv: ",  piv ] ];

  If[ dbg && cst, Print["Analyzing constants"] ]; 
  (* Option oneStep : one stop looking as soon as one possibility is found *)
  If[ optOneStep, 
    Module[ { lc },
      pic = {}; lc = c;
      While[ pic === {} && lc =!= {}, 
        pic = pipeInfo[ sys, First[ lc ], opts ];
        lc = Drop[ lc, 1 ];
      ];
    ]
  ,
    pic = If[ cst, Map[ pipeInfo[ sys, #1, opts]& , c ], {}];
  ];

  If[ !ListQ[ pic ], pic = {pic} ];
  If[ dbg, Print[ "pic: ", pic ] ];
  pi = Complement[ Union[ piv, pic ], {{}}];

  (* Report, and execute first command, if any *)
  Which[ 
    pi === {}, 
      If[ !optMute, Print["Nothing to pipeline"] ];{},
    exec, 
      If[ !optMute, Print["Executing : " , pi[[1]] ] ];
      ToExpression[ pi[[1]] ];
      If[ vrb, Print["Rerun pipeInfo..."] ]; pi
    ,
    True, If[ !optMute, Print["Operations to perform:\n", pi ] ]; pi
  ]

];

(* Version without system *)
pipeInfo[ occ:{__Integer}, opts:___Rule ] := pipeInfo[ $result, occ, opts ];


pipeInfo[ sys:_system, occ:{__Integer}, opts:___Rule ]:= 
Catch[
  Module[ {exp, varname, mat, lp, ns, lg, optdebug, squareQ, inputDep,
	   dom, eqmat, optposition, occloc, lhs, constantQ, res1, outputDep,
           dimlhs, dimrhs, unif, command, indexdom1, indexdom2, res,
	   optverbose, transfo, optMute},

    optdebug = debug /. {opts} /. Options[ pipeInfo ];
    optverbose = verbose /. {opts} /. Options[ pipeInfo ];
    optverbose = verbose /. {opts} /. Options[ pipeInfo ];
    optMute = mute /. {opts} /. Options[ pipeInfo ];
    If[ optMute, optverbose = False ];

    (* Get part of system *)
    If[ optdebug || optverbose, Print["\n-------- Analyzing occurrence : ",
      occ ]];

    (* Get lhs of equation *)
    lhs = getPart[ sys, Take[ occ, 2 ] ][[1]]; 
    If[ optdebug || optverbose, Print["LHS : ", lhs ] ];

    (* Get corresponding expression *)
    exp = Check[ getPart[ sys, occ], Throw[ Message[pipeInfo::position] ] ];
    occloc = If[ optposition, occ, 
      If[ optdebug, ashow[ getPart[ $result, occ ], silent -> True]] ];

    If[ optdebug || optverbose, 
      Print[ "Expression: ", ashow[exp,silent->True] ] ];

    (* Check that it is an affine dependency *)
    If[ !MatchQ[ exp, affine[___] ], Throw[ Message[pipeInfo::notaffine] ] ];
    constantQ = MatchQ[ exp, affine[_const,_] ];

    (* Get var name *)
    varname = exp[[1,1]];

    (* Get context domain *)
    dom = getContextDomain[ sys, occ ];
    If[ optdebug || optverbose , 
        Print[ "Context domain: ", ashow[ dom, silent->True] ]];

    (* Do not consider the case of a union... *)
    If[ MatchQ[ dom, domain[_Integer, _, {pol_, __ } ] ],
        Print[ "Domain is a union... There is maybe something to pipeline, but I cannot guess it..."]; Throw[ {} ]
    ];

    (* Compute domequalities - This is a patch, since DomEqualities is
       incorrect *)
    Check[
      eqmat = Map[ Drop[ #, -1 ]&, DomEqualities[ dom ][[ 4 ]]], 
      Message[ pipeInfo::mbUnion ]; Throw[{}] ];

    (* Get the complementary space of equalities, {} if full dimensional *)
    If[ optdebug || optverbose , Print[ "Equality matrix: ", eqmat ]];
(* 
    eqmat = If[ eqmat =!= {}, NullSpace[ eqmat ], {} ];
    If[ optdebug, Print[ "Complementary matrix: ", eqmat ]];
*)

    (* Get matrix *)
    mat = exp[[2]];

    (* Check several properties *)

    squareQ = squareMatrixQ[ mat ]; 
    identQ = If[ squareQ, identityQ[ mat ], False ];
    inputDep = MemberQ[ getInputVars[ sys ], varname ];
    outputDep = MemberQ[ getOutputVars[ sys ], lhs ];

    If[ optdebug, 
      Print[ "Variable: ", varname, 
       " Dependency: ", ashow[ mat, silent->True ], 
       If[ squareQ, " Square, ", " Non square, " ],
       If[ constantQ, " Constant, ", " Non constant, " ],
       If[ outputDep, "Lhs is an output variable,", 
         "Lhs is a local variable, " ],
       If[ !constantQ && inputDep, 
           "Rhs is an input variable ", 
           "Rhs is a local or output variable " ] ]
    ];

    Which[

      (* Cond *)
      (* If dependency is already uniform, nothing to do *)
      uniformQ[ mat ]
    , 
      If[ optdebug||optverbose, 
        Print[ "Dependency is already uniform" ] 
      ]; 
      Throw[{}]
    ,

      (* Cond *)
      (* Input rhs variable or constant, 
         square dependency: try to pipeline *)
      (inputDep || constantQ) && squareQ
    , 
      If[ optdebug || optverbose, Print["Calling pipeline 1... "] ];
      res = tryPipeline[ sys, occ, varname, mat, eqmat, opts ]; 
      transfo = "Pipeline";
      Throw[ res ]
    ,

      (* Cond *)
      (* Input, and non square: one can pipeline *)
      (inputDep || constantQ) && !squareQ
    , 
      If[ optdebug||optverbose, Print["Calling pipeline 2... "] ];
      res = tryPipeline[ sys, occ, varname, mat, eqmat, opts ]; 
      transfo = "Pipeline";
      Throw[ res ]
    ,

      (* Cond *)
      (* If the dependency is in the definition of an output
         variable, there is nothing to do *)
      !inputDep && !constantQ && MemberQ[ getOutputVars[], lhs ]
    , 
      If[ optdebug||optverbose, 
        Print[ "Dependency in an output equation" ] 
      ]; Throw[{}]
    ,
      (* Cond *)
      True
    , 
      (* First, try a pipeline *)
      If[ optdebug||optverbose, Print["Trying a pipeline 3..."] ];
      transfo = "Pipeline";
      res1 = tryPipeline[ sys, occ, varname, mat, eqmat, opts ];
      If[ res1 ==={} && (optdebug||optverbose), 
        Print["Pipeline failed..."] 
      ];

      (* If the pipeline gives something, return *)
      If[ res1 =!= {}, Throw[ res1 ] ];

      (* 
        Now, we look for an alignment, if the dimension of
        the lhs is less than that of the rhs 
      *)
      (* Compute null space of eqmat, i.e, basis of lineality
          of domain *)
       
      (* Get dimension of the space *)
      transfo = "Alignment";
      dimlhs = mat[[2]]-1;
      If[ optdebug, Print["Dimension of lhs: ", dimlhs ] ];
      dimrhs = mat[[1]]-1;
      If[ optdebug, Print["Dimension of rhs: ", dimrhs ] ];

      Module[ { indexes, mat1, params, newindexes, matindexes},
        command = {};
        If[ ! squareQ, 
          If[ optdebug||optverbose, Print[" non square dependency." ] ];
          If[ outputDep, Print["Output dependency"]];
          If[ dimrhs > dimlhs, 
            If[ optdebug|| optverbose, 
              Print["Trying an alignment of lhs using a change of basis..."]
            ];

            (* Get the parameters *)
            params = getSystemParameters[ sys ];

            (* Get the indexes less the parameters *)
            indexes = Drop[ mat[[3]], - Length[ params ] ];

            (* Find how many indexes to be added *)
            newindexes = Table[ "i"<>ToString[j], {j, 1, dimrhs - dimlhs}];

            (* Build the cob command. Be careful that you 
              have to introduce quotes in the commands *)
            newindexes = Map["\""<>#<>"\""&,Join[ newindexes, indexes ] ];
            matindexes = Map["\""<>#<>"\""&, mat[[3]] ];
            command = 
              "changeOfBasis[\""<>lhs<>"\","<>
              ToString[ ReplacePart[ mat, matindexes, 3] ]<>
              ", "<>ToString[ newindexes ]<>"];normalize[];",
            command = {}
          ];
          If[ command =!= {}, 
            If[ !optMute, Print["----> Execute the command: "];
            Print[ command ]; Print["(", transfo, ")." ] ];
          ];
	    Throw[ If[ command === {}, command, {command} ] ] 
        ]
      ];

      (* 
         Then, we look for a possible uniformization
      *)
      transfo = "Uniformization";
      If[ optdebug||optverbose, Print["Try uniformization..."] ];
      unif = uniformizeOccur[ occ ];
      If[ unif =!= {}&& unif =!= $Failed, 
        command = "mkUniform["<>ToString[ occ ]<>"]";
        If[ !optMute, Print["----> Execute the command: "];
        Print[ command ]; Print["(", transfo, ")." ] ];
        Throw[ {command} ]
      ];

      (*
        Now, we try to route the data... To do so, we get the
        vectors of the null space of the dependency which are 
        parallel to the null space of the lineality space of 
        the domain. This is therefore the intersection of the 
        null space of the 
        lineality space of the domain, and of the null space of
        the dependency, or, the null space of the union of the
        lineality space and the dependency space.
      *)

      transfo = "Route";
      ceqmat = 
        If[ eqmat === {}, IdentityMatrix[dimlhs], NullSpace[ eqmat ] ];

      (* Compute difference matrix *)
      Check[
        lp = getLinearPart[ mat ], 
        Throw[Message[ PipeControl::wrglinspace ] ]
      ];

      If[ optdebug, Print[ "Linear space of dependency : ", lp ] ];
      lp = lp - IdentityMatrix[ dimlhs ]; 

      If[ optdebug, Print[ "Difference matrix: ", lp ] ];

      (* Remove possible 0 vector *)
      lp = Complement[ Union[ lp ], {Table[ 0, {iter, 1, dimlhs, 1}]}];

      If[ optdebug, Print[ "Difference vectors: ", lp ] ];

      rs = lp; 

      (*
        rs = Union[ NullSpace[lp], ceqmat ];
        Print[ rs ];
        rs = If[ rs === {}, IdentityMatrix[dimlhs], 
                 NullSpace[ Union[ lp, ceqmat ] ] ];

        If[ optdebug||optverbose, 
            Print["Nullspace vectors in non lineality space : ", ns] ];
       *)
  
       If[ rs === {}, 
          If[ optdebug||optverbose, 
            Print["No pipelining, no routing."]
          ];
          Throw[ { } ]
        ];

        (* Now, get the image of the domain by the dependence function *)
        If[ optdebug, Print["Initial domain : ", 
          ashow[ dom, silent -> True ] ] ];
        Check[ imdom = DomImage[ dom, mat ],
          If[ optdebug, Message[ pipeInfo::errDomImage ] ] ];

        If[ optdebug, Print["Final domain : ", 
          ashow[ imdom, silent -> True ] ] ];

        indexdom1 = Map["\""<>#<>"\""&, dom[[2]] ];
        indexdom2 = Map["\""<>#<>"\""&, imdom[[2]] ];
        command = 
          StringJoin[
            "route",
            "[\"", lhs, "\", ",
            ToString[occ],
            ", \""<>varname<>"\", ",
            ToString[ rs[[1]] ],
            ", ",
            ToString[ ReplacePart[ dom, indexdom1, 2 ] ],
            ", ",
            ToString[ ReplacePart[ imdom, indexdom2, 2 ] ],
            "]"
          ];
        If[ optverbose, Print["----> Potential use of the command: \n", command ] ];
        If[ optverbose, Print["but route does not work currently..." ] ];
        Throw[ {} ];
    ]
  ] (* Module *)
]; (* Catch *)

pipeInfo::params = "wrong parameters";
pipeInfo[___] := Message[ pipeInfo::params ];

Clear[ tryPipeline ];
(*
    This function is called when the dependency is square, 
    refers to an input variable or a constant
*)
tryPipeline[ sys:_system, occ:_, varname:_, mat:_, eqmat:_, opts:___Rule ]:=
Catch[
Module[ 
  {unimodc, dimmat, ceqmat, cl, cn, optverbose, optdebug, lhs, 
   indexes, params, declar, quotedindexes, pipeTree, pipeTreeForPrint },
  (* 
    eqmat is the matrix of equalities of the domain. It gives the
    lineality space. We need to compute the vectors both belonging
    to the null space of the dependence function, and the lineality
    space of the domain. To do so, 
    - we compute ceqmat, the lineality space of domain, then 
    the null space of ceqmat
    - then we do the union of ceqmat and lp, the lineality
    space of the dependence function,
    - then we compute the null space of this new basis.
  *)

  optverbose = verbose/.{opts}/.Options[pipeInfo];
  optdebug = debug/.{opts}/.Options[pipeInfo];

  If[ optdebug||optverbose, Print[".... Calling tryPipeline..."] ];
(*
  If[ optdebug || optverbose, 
    Print["Input dependence or constant, square matrix"]];
*)

(*
  If[ squareMatrixQ[ mat ], Print[ "Square dep" ], Print[ "Non square matrix" ]];
*)

  (* Get dimension of the space *)
  dimmat = mat[[2]]-1;

  (* Compute null space of eqmat *)
  If[ optdebug || optverbose, Print[ "Equality matrix is: ", eqmat ] ];
  ceqmat = If[ eqmat === {}, IdentityMatrix[dimmat], NullSpace[ eqmat ] ];
  If[ optdebug || optverbose, 
    Print[ "Basis of lineality space is : ", ceqmat ] ];

  ceqmat = If[ ceqmat === {}, IdentityMatrix[dimmat], NullSpace[ ceqmat ] ];
  If[ optdebug || optverbose, Print[ "Null space of domain is : ", ceqmat ] ];

  (* Get linear part of dependence matrix *)
  Check[
    lp = getLinearPart[ mat ], 
    Throw[Message[ PipeControl::wrglinspace ] ]
  ];

  (* Remove possible 0 vector *)
  lp = Complement[ Union[lp], {Table[ 0, {iter, 1, dimmat, 1}]}];
  If[ optdebug || optverbose, Print[ "Linear space of dependency : ", lp ] ];

  ns = Union[ lp, ceqmat ];
  ns = If[ ns === {}, IdentityMatrix[dimmat], 
           NullSpace[ Union[ lp, ceqmat ] ] ];

  If[ optdebug||optverbose, 
      Print["Nullspace vectors in lineality space : ", ns] ];

  lg = Length[ ns ];

  Which[ 
    lg === 0, 
    If[ otpdebug || optverbose,
      Print["No nullspace vectors in the direction of the domain"];
      Print["Nothing to pipeline "]];
      Throw[ {} ]
  ,
    lg === 1, 
    If[ optdebug || optverbose,
       Print["One nullspace vector in the direction of the domain"];
       Print["This occurrence should be pipelined"];
    ];


    (* Patch *)
    Module[ {movementDomain,pipelineVector,dom},
      dom = getContextDomain[sys,occ]; 
      pipelineVector=ns[[1]]; 
      pipelineVector = translationMatrix[ dom[[2]], pipelineVector ];
      If[ optdebug, Print[ "pipeline matrix: "];ashow[ pipelineVector ] ];
      (* Compute domain where we change the definition *)
      Check[
        movementDomain = 
          DomIntersection[ dom, DomImage[dom, pipelineVector] ],
          Throw[Message[buildPipelineEquation::err1]]
      ];
      If[ optdebug, Print[ "movement domain: "]; ashow[ movementDomain ] ];
      If[ DomEmptyQ[ movementDomain ], 
        If[ optverbose || optdebug, 
          Print[ "Movement domain is empty, no possible pipeline" ] ];
        Throw[ {} ] 
      ];
    ];

    (* Return the pipeall command which has to be done *)

    (* How this is done currently. 
       - one builts a pipeall expression of the form 
       pipeall[ var, occ, pipeExpr, domain ] which can be run to 
       pipe the expression. 
       - a boundary domain is given only if the indexes of var 
       are t and p (plus parameters), so as to avoid pipeIO.
    *)

    (* Find lhs of equation where the expression has been 
       found *)
    lhs = getPart[ sys, Append[ Take[ occ, 2 ], 1 ] ];

    (* Get param list *)
    params = getSystemParameters[ sys ];

    (* Compute list of indexes *)
    declar = getDeclaration[ sys, lhs ];
    indexes = declar[[3,2]];

    (* Add quotes to indexes *)
    quotedindexes = Map[ "\""<>#1<>"\""&, indexes ];

    (* Compute pipeTree *)
    pipeTree = 
      affine[ var[ "\""<>pipeName[ varname]<>"\"" ], 
              translationMatrix[ quotedindexes, ns[[1]] ] ];
    pipeTreeForPrint = 
      affine[ var[ pipeName[ varname] ], 
              translationMatrix[ indexes, ns[[1]] ] ];

    (* Look at first index, and if it is t, assume that the
       system is scheduled. In this case, if there is only one
       processor dimension, suggest a boundary domain *)
    Module[ {bd, dom, domTranslated, domDiff, domExtended, 
      paddzeroparams, matrays },
      If[ (indexes[[1]] =!= "t")||
(*          (indexes[[2]] =!= "p") || *)
          (Length[ indexes ]-Length[ params ] =!= 2), 
        bd = "",

        (* Compute domain of lhs *)
        dom = getDeclarationDomain[ lhs ];
        If[ optdebug || optverbose, 
          Print[ "decl domain: ",ashow[ dom, silent -> True ] ] 
        ];
        paddzeroparams = Table[0,{i,1,Length[params]}];

        (* Extend domain to cylinder in t *)
        matrays = 
          matrix[1,dom[[1]]+2,{},
          {Prepend[Append[Join[{1,0},paddzeroparams],0],0]}];
        If[ obpDebug, Print[ "Matrix : ", matrays ] ];
        domExtended = 
          DomAddRays[dom,
            matrix[1,dom[[1]]+2,{},
            {Prepend[Append[Join[{1,0},paddzeroparams],0],0]}]];
        If[ optdebug || optverbose, Print["Dom extended : ", 
                       ashow[ domExtended, silent -> True ] ] 
        ];

        (* Translate this domain by - null space vector *)
        domTranslated = 
          DomImage[ 
            domExtended, 
            translationMatrix[ declar[[3,2]], -ns[[1]] ]
        ];
        If[ optdebug || optverbose, Print["Dom translated : ", 
                       ashow[ domTranslated, silent -> True ] ] 
        ];
        (* Compute difference with dom extended *)
        domDiff = 
          DomDifference[ domTranslated, domExtended ];
        If[ optdebug || optverbose, Print["Dom difference : ", 
                       ashow[ domDiff, silent -> True ] ] 
        ];
        (* Extend domain backward to have a hyperplane *)
        domExtended = 
          DomAddRays[ domDiff, 
            matrix[1,dom[[1]]+2,{},
            {Prepend[Append[ns[[1]],0],1]}]];
        If[ optdebug || optverbose, Print["Dom extended backwards : ", 
                       ashow[ domExtended, silent -> True ] ] 
        ];
        (* Remove inequalities on parameters *)
        paramVects = Map[ Join[{0,0},#]&, IdentityMatrix[ Length[ params ] ] ];
        If[ optdebug, Print["param vect: ", paramVects ] ];
        domExtended = 
          Fold[ 
            Function[ {dom,vect}, 
              DomAddRays[ dom, matrix[1, dom[[1]]+2, {}, 
                {Prepend[Append[vect,0],0]}] ] ],
            domExtended, paramVects
          ];
        If[ optdebug || optverbose, Print["Dom extended backwards : ", 
          ashow[ domExtended, silent -> True ] ]
        ];
        If[ DomEmptyQ[ domExtended ], bd ="",
          (* Replace indexes in bd by their quoted version 
             to allow execution of commande *)
          bd = ReplacePart[ domExtended, quotedindexes, 2 ]
        ]
      ];

      command = 
        StringJoin[
          "pipeall[ {}, ",
          (* Expression itself *)
          ToString[ occ ],
          ", ",
          ToString[ pipeTree ]
          , 
          If[ bd === "", "", ","<>ToString[bd] ],
          "]"
        ];
      If[ optverbose, Print["----> Execute the command: "]; Print[ command ] ];
      Throw[ command ]
    ] (* End module *)
  ,
    lg > 1,
    If[ optdebug || optverbose,
      Print["Several nullspace vectors in the direction of the domain"];
      Print["This occurrence should be pipelined several times"];
    ];

    Throw[ "pipeline["<>ToString[occ]<>", {\""<>pipeName[varname]<>"\", "<>
              ToString[ns[[1]]]<>"}]" ]
    ]
  ]
];
tryPipeline[___] := Message[ tryPipeline::args ];

Clear[route];
Options[ route ] := { debug -> False };
route::wrgocc = 
"Error: occurence description is incorrect."
route::wrgpipe1 = 
"Error: routing vector is incorrect."
route::wrngname = 
"Warning, name of new variable already used";

route[ 
       occ:{__Integer}, {variable:_String, vect:{__Integer}}, dom1:_domain, 
       dom2:___domain, opts:___Rule ] :=
Catch[
  Module[ {dbg, dom, lhs, ctxdom, eqmat, d1, d2, sys, lhsdecl, eq, trm, save,
           domeq, newdecl },
    (* Get options *)
    dbg = debug/.{opts}/.Options[ route ];

    (* Save $result *)
    sys = $result;

    If[ dbg, Print["Entering route function" ] ];
    If[ dbg, Print["New variable name : ", variable ] ]; 
    If[ dbg, Print["Routing vector : ", vect ] ];
    (* Get lhs *)
    Check[ lhs = getPart[ sys, Take[ occ, 2 ] ][[1]],
      Throw[ Message[ route::wrgocc ] ] ]; 
    If[ dbg, Print["Lhs : ", lhs ] ];
    Check[ lhsdecl = getDeclaration[ lhs ],
      Throw[ Message[ route::wrgocc ] ] ]; 
    indexes = lhsdecl[[3]][[2]];
    If[ dbg, Print["indexes : ", indexes ] ];
    lg = Length[ vect ];
    If[ lg =!= Length[ indexes ], 
      Throw[ Message[ route::wrgpipel ] ] ];
    (* If the new name already exists *)
    If[MemberQ[getVariables[sys],variable],
       Throw[(Message[ route::wrngname];sys)]];

    (* Cross the finger *)
    d1 = DomAddRays[dom1,
           matrix[1,dom1[[1]]+2,{},
           {Prepend[Append[vect,0],1]}]];
    If[ dbg, Print[ "Domain 1 extended : ", ashow[d1,silent->True] ] ];

    (* Cross the finger, again *)
    d2 = DomAddRays[dom2,
           matrix[1,dom2[[1]]+2,{},
           {Prepend[Append[-vect,0],1]}]];
    If[ dbg, Print[ "Domain 2 extended : ", ashow[d2,silent->True] ] ];

    (* Compute intersection *)
    domeq = DomIntersection[ d1, d2 ];
    d2 = DomDifference[
           DomDifference[ domeq, dom1 ],
           dom2];
    If[ dbg, Print[ "Intersection domain : ", ashow[d2,silent->True] ] ];

    (* Equation *)
    trm = translationMatrix[ indexes, vect ];
    show[ trm ];
    eq = Alpha`equation["v", 
           Alpha`case[{
             Alpha`restrict[ d2, Alpha`affine[ Alpha`var[ "v" ], trm ] ],
             Alpha`restrict[ dom2, getPart[ sys, occ ] ]
           }]
         ];
    show[eq]; 
    newdecl = decl[variable, Part[lhsdecl, 2], domeq ];
    $result = 
      system[ $result[[1]], $result[[2]], $result[[3]], $result[[4]],
        Prepend[$result[[5]],newdecl], (* declarations *)
        Insert[ ReplacePart[ $result[[6]], Alpha`var[ variable ],
                Drop[ occ, 1 ] ],
        eq, Part[ occ, 2 ] ]
      ]
  ]
];

route[___]:=Message[route::params];
route::params = "wrong parameters";

(* eqsDomain gets all equalities of a domain *)
(* this function is local, and used in uniformizeMatrix *)
Clear[eqsDomain];
eqsDomain[dom_String]:=eqsDomain[readDom[dom]];
eqsDomain[dom_]:=Module[{x},
		    x=dom[[3]][[1]][[5]];
		Map[Drop[#1,1]&,Select[x,#1[[1]]===0&]]
		    ];

(* eq2ge replaces all equalities of a domain by a >= inequality *)
(* this function is local, and is used in findSepHalfSpace *)
Clear[eq2ge];
eq2ge[dom_String]:=eq2ge[readDom[dom]];
eq2ge[dom_]:=
Module[{x},
  x=dom2mma[dom];
  dom2al[x/.Equal[u_,v_]:>GreaterEqual[u,v]]
];

(* eq2le replaces all equalities of a domain by a <= inequality *)
(* this function is local, and user in findSepHalfSpace *)
Clear[eq2le];
eq2le[dom_String]:=eq2le[readDom[dom]];
eq2le[dom_]:=
Module[{x},
  x = dom2mma[dom];
  dom2al[x/.Equal[u_,v_]:>LessEqual[-u,-v]]
];

(* ge2le inverts inequalities *)
Clear[ge2le];
ge2le[dom_String]:=ge2le[readDom[dom]];
ge2le[dom_]:=
Module[{x},
  x=dom2mma[dom];
  dom2al[x/.Alpha`ge[u_,v_]:>Alpha`ge[-u,-v+1]]
];

(* domHalfSpaceQ 
Clear[domHalfSpaceQ];
domHalfSpaceQ[dom_String]:=domHalfSpaceQ[readDom[dom]]; 
domHalfSpaceQ[Alpha`domain[dim_,ind_,{Alpha`pol[nc_,_,_,_,c_,_]}]]:=
  nc===2 && c[[1]][[1]] ===1;
domHalfSpaceQ[x_]:=(Message[domHalfSpaceQ::arg];False);
*)

(* A few local functions *)
Clear[linpart,coeff,oper];
(* linpart Takes the linear part of a constraint *)
linpart[x_]:=Drop[Drop[x,1],-1];
(* coeff Takes the coefficient of a constraint *)
coeff[x_]:=Part[x,-1];

(* oper returns the operator of a constraint, in Alpha form *)
oper[x_]:=With[{y=Part[x,1]},If[y===1,Alpha`ge,Alpha`eq]];


(* this function produces a list of halfspace from a domain definition *)
Clear[domExplode];
domExplode::params = "wrong params";
domExplode[x_Alpha`domain]:=
Module[{listPol,polDim,polIndices,finalRes,redondantIneq,
  curPol,listEqIneq,listMat,listDom},

  listPol=x[[3]];
  polDim=x[[1]];
  polIndices=x[[2]];
  finalRes={};
  redondantIneq=Join[{1},Table[0,{j,1,polDim}],{1}];

  (* for each polyhedron *)
  Do[curPol=listPol[[i]];
    listEqIneq= curPol[[5]];
    listEqIneq=DeleteCases[listEqIneq,redondantIneq];
    listMat=Map[Alpha`matrix[2,polDim+2, polIndices,
	{#,redondantIneq}]&,listEqIneq];
    listDom=Map[DomConstraints,listMat];
    finalRes=Join[listDom,finalRes],
    {i,1,Length[listPol]}
  ];
  finalRes
];

domExplode[___]:= Message[domExplode::params];

(* local function which gives the coefficient of the first index in
   the domain *)
Clear[coeff1stIndex];
coeff1stIndex[d_Alpha`domain]:=
  With[{c=d/.Alpha`domain[_,_,{Alpha`pol[_,_,_,_,x_,___]},___]:>x[[1]][[2]]},
	 If[IntegerQ[c],c,(Print["wrong argument for function coeff1stIndex"];{})]
       ];


(* Finds a pipe direction for a Control variable *)
Clear[findPipeControl];

findPipeControl::undef = 
"could not find an equation for this variable";
findPipeControl::arg = 
"rhs of this variable is not the definition of a control signal";
findPipeControl::nosep = 
"no separating half planes for the case expression";

(* Option added. Patrice *)
findPipeControl[ x_String, opts:___Rule ]:=
  findPipeControl[ $result, x, opts ];
findPipeControl[ sys_system, x_String, opts:___Rule ]:=
Catch[
  Module[{def,eq1,s,h,dbg},
    dbg = debug/.{opts}/.Options[pipeControl];
    def = getDefinition[sys,x]; (* take the lhs of symbol x *)
    eq1 = getEquation[sys,x]; (* take the equation defining x *)

    If[ dbg, Print["------- Entering findPipeControl " ] ];
    (* check that not empty *)
    If[def==={},Throw[Message[separateDef::undef]],def];

    (* Check type of argument *)
    If[isControlEquQ[eq1],Null,
      Throw[(Message[findPipeControl::arg];{})]
    ];

    (* Get the second level case *)
    def = def/.{Alpha`case[{Alpha`restrict[_,y:case[___]],___}]:>y,
		       Alpha`case[{y:case[___]}]:>y}; 
    If[dbg,Print["trying to separate :\n",show[def,silent->True]]];
    Check[
      s = findSepHalfSpace[def,opts],
      findPipeControl::fHSpaceErr = "error while calling findHalfSpace";
      Throw[Message[findPipeControl::nosep]; {}]
    ];

    If[s==={},
      Throw[Message[findPipeControl::nosep]],s
    ];

    If[ dbg, 
      Print["Separating hyperplanes: ", Map[show[#,silent->True] &,s] ] ];
(*  This statement was commented, but I do not know why... 
    Patrice. FIXIT. 
    Select[s, With[{c=coeff1stIndex[#1]}, c===1||c===-1]& ]
    *)
    s
  ]
];


(* Find a list of separating hyperplanes for a case expression *)
Clear[findSepHalfSpace];
findSepHalfSpace::arg = 
"argument should be a binary case expression";

(* parse if needed *)
findSepHalfSpace[x_String,opts:___Rule]:=findSepHalfSpace[readExp[x],opts];
findSepHalfSpace[x_Alpha`case,opts:___Rule]:=
Catch[
  Module[{ branch1,branch2,d1,d2,e1,e2,s1,s2, intersec, dbg},
    dbg = debug/.{opts}/.Options[pipeControl];
	 (*
    dbg = True ;  (* uncomment this line if you want to debug that function *)
	  *)
    (* first branch of the case *)
    branch1=x/.Alpha`case[{a_,b_}]->a;
    (* second branch of the case *)
    branch2=x/.Alpha`case[{a_,b_}]->b;
    (* first domain in d1 *)
    d1 = branch1/.Alpha`restrict[d_,_]->d;
     If [dbg,Print[" branch 1:"]; show[d1]];
    (* second domain in d2 *)
    d2 = branch2/.Alpha`restrict[d_,_]->d;
     If [dbg,Print[" branch 2:"]; show[d2]];

    Check[
      intersec = DomIntersection[d1,d2];
      findSepHalfSpace::wrgcase = 
        "in the definition of `1`, the branch of the case expression have overlapping domains";
      If[ !DomEmptyQ[ intersec ], 
        Throw[ Message[ findSepHalfSpace::wrgcase ] ] ],
      findSepHalfSpace::error = "error while calling DomIntersection";
      Throw[ Message[ findSepHalfSpace::wrgcase ] ] 
    ];

    (* explode domains *)
    e1 = domExplode[d1];
    If [dbg,Print["exploded domains for branch 1:"]; Map[show, e1]];
    (* explode domains *)
    e2 = domExplode[d2];
    If [dbg,Print["exploded domains for branch 2:"]; Map[show, e2]];

    (* replace equalities by 2 inequalities *)
    e1 = Union[Map[eq2ge,e1],Map[eq2le,e1]];
    e2 = Union[Map[eq2ge,e2],Map[eq2le,e2]]; 

    s1 = Select[e1,
              DomEmptyQ[DomIntersection[#1,d2]]&];

    s1 = Select[s1,domHalfSpaceQ];

    If [dbg,Print["keep only half space not present in both for branch 1:"]; Map[show, s1]];
    s2 = Select[e2,
       DomEmptyQ[DomIntersection[#1,d1]]&];

    s2 = Select[s2,domHalfSpaceQ];

    If [dbg,Print["keep only half space not present in both for branch 2:"]; Map[show, s2]];
    Union[s1,Map[ge2le,s2]]
  ]
]/;MatchQ[x,Alpha`case[{a_,b_}]];
findSepHalfSpace[x_]:=(Message[findSepHalfSpace::arg];{});


(* Pipeline control variable *)
(* This function first builds a new pipeline variable called
   "var:Pipe" (the ':' makes name conflicts impossible), then removes
   it, because this variable actually replaces the old mux variable.
*)

Clear[pipeControl];

pipeControl::unknownvar = "var `1` is unknown";
pipeControl::wrglinspace = "could not get linear space.";
pipeControl::nosep = 
"no separating half planes for the case expression";
pipeControl::wrngdim =
"dimension of space indices is not 1 or 2. Higher dimensions not supported.";
pipeControl::wrngpos = "position `1` of `2` seems to be wrong";
pipeControl::wrgprojv = 
"projection vector `1` is probably of wrong dimension";
pipeControl::nullpipevec = 
"pipeline vector for `1` has null time projection: this control signal
must be a diffusion. Trying to delocalize it.";

pipeControl::nohspace = 
"could not find a supporting hyperplane for the domain...";

pipeControl::args= 
"parameter should be a var (String)"; 

pipeControl::errpipe = 
"could not pipeline the control expression. Ask MMAlpha staff";

pipeControl::nopipevec = 
"Sorry, No pipeline vector could be found for variable `1`"

pipeControl[var_String,opts:___Rule]:=  (* default system *)
Module[{},
  $program = Alpha`$result;	 
  $result=pipeControl[$program,var,opts]
];

(* Pipeline control variable. *)
pipeControl[ sys:_system, variable_String, opts:___Rule ]:=
Catch[
  Module[{vec,lin,nn,pos,pp,dom,exp,projvect,dec,dim,tm,
    newsys,dep11,nameIn,nameInit,paramlist,newDomInit,newDep,
    domTrue,domFalse,newrhs,newVariableName,posNewEq,domExp,
    nbEqDomExp,realDimExp ,newDomB1,newDomB2,vrb,dbg,lhSpaces,
    newsys1},

    dbg = debug/.{opts}/.Options[toAlpha0v2];
    vrb = verbose/.{opts}/.Options[toAlpha0v2];

   (* Check that var exists *)    
   If[MemberQ[getLocalVars[sys],variable],Null,
     Throw[(Message[pipeControl::unknownvar,variable];sys)]
   ];

   If[ dbg, Print["\n\n------------- Entering PipeControl\n\n"] ];

   If[ dbg, Print["Pipelining variable: \n", 
	ashow[ getEquation[ sys, variable ], silent ->True ] ] 
   ];

   (* Build default projvect *)
   dec = getDeclaration[ sys, variable ];
   dim = dec[[3]][[1]]; (* dimension of variable *)
   If[dim-sys[[2]][[1]]>4,
	      Throw[(Message[pipeControl::wrngdim];sys)]];

   (* It only works with 1 time dimension...*)
   projvect = Prepend[Table[0,{i,1,dim-1}],1];

   (* Get  position of equation *)
    def = getDefinition[sys,variable]; (* take the lhs of symbol x *)
     (* pos = Position[ sys, equation[variable,___] ]; *)
   If[def==={},
     Throw[(Message[pipeControl::wrngpos," ? " ,variable];sys)]];

   (* Compute position of  expression, second level case
   pos = Join[pos[[1]],{2,1,1}]; 
   exp = getPart[sys,pos];   *)	   
   exp = def/.{Alpha`case[{Alpha`restrict[_,y:case[___]],___}]:>y,
		       Alpha`case[{y:case[___]}]:>y};
   pos = Position[ sys, exp ];
   If[pos==={},
              Throw[(Message[pipeControl::wrngpos," ? " ,variable];sys)],
              pos=First[pos]
   ];

   If[dbg,Print["equation is :",show[def,silent->True]]]; 
   If[dbg,Print["trying to separate :",show[exp,silent->True]]];

   (* Get context domain of the expression to pipeline *)
   domContext =  convexize[getContextDomain[sys,pos]];
   domExp  = expDomain[sys,pos];
   realDomExp = convexize[DomIntersection[domContext,domExp]];

   If[ dbg, Print["the real domain of expr is", 
	ashow[ realDomExp , silent ->True ] ] 
   ];   

   If[ dbg, Print["the context domain of expr is", 
	ashow[ domContext , silent ->True ] ] 
   ];   

   nbEqDomExp = 
     Length[Part[DomEqualities[
       DomConvex[realDomExp]],4]];

   realDimExp = domExp[[1]] - nbEqDomExp;

    (*
   If[ realDimExp - nbParam==2, $$temp=sys];
     *)

   nbParam = sys[[2]][[1]];

   If[ dbg, Print["the real dimension of domain of expr is ", 
	realDimExp - nbParam];  
   ];   

   If[realDimExp-nbParam <=0,
     Throw[(Message[pipeControl::wrngdim];sys)],
     If[ vrb || dbg, Print["     From dimension ", realDimExp - nbParam ,
       " to dimension ", realDimExp - nbParam - 1 ] ];
   ];

   projvect = Prepend[Table[0,{i,1,dim-1}],1];
   If[ dbg, Print["Projection vector: ", projvect] ];

   (* Compute separating hyperplanes *)
   vec = 
     Check[ 
       findPipeControl[ sys, variable, opts ], 
       (* Look for separating hyperplanes *)
       pipeControl::findPipeControlErr = "error while calling findPipeControl";
       Throw[ Message[ pipeControl::findPipeControlErr ]; sys] 
     ];

   (* FIXIT. Message *)
   (* Return if empty *)
   If[ vec==={}, 
     pipeControl::findPipeControlEmpty = 
       "pipe control vectors are empty";
     Throw[ Message[ pipeControl::findPipeControlEmpty ]; sys] 
   ];
 
   If[ dbg, 
     Print["I take the First one"];
   ];

   (* Select 1st vector *)
   lin = linHalfSpace[vec[[1]]];
   If[ dbg, Print["lin half space: "]; Print[ lin ] ];

   (* Compute null space *)
   nullSpace = NullSpace[lin];
   If[ dbg, Print["Null space vectors: "]; Print[ nullSpace ] ];

   (* Keep the elements of the null space that contains a non
      null component along time *)
   nn = Select[nullSpace,First[#]=!=0 &];

   If[ dbg, Print["Null space vectors with non null 1 component : ", nn ] ];

   If[Length[nn]===0,
     If[ verb, 
     Print["       Warning, no pipe vector was found for control signal ", 
       variable] ;
     Print["       --> assuming broadcasted signal"] ];
     Throw[ delocalizeControl[ sys, variable,opts ] ];
   ];

   (* By choosing systematically the first vector, one may fail... *)

   Module[ {i, pipeVectorFound,tempVar},
     i = 1; 
     pipeVectorFound = False;
 
    While[ (!pipeVectorFound) && (i <= Length[ nn ]), 

      (* Chose the vector *)
      pipe1 = nn[[i]];

      (* Remove the coefficient on the parameter, parameters are constants *)
      pipe1=Drop[pipe1,-nbParam];
      pipe1=Join[pipe1,Table[0,{i,1,nbParam}]];

      (* Added by tanguy: if the context domain contains some equalities, 
         The pipeline should be done within this space,hence we must choose 
         a vector into this space. The solution choosen here is probably 
         not the best one: 
         - use the solve function to try to combine the different vector 
         of the kernel so as to obtain a vector which is in the 
         lineality space *) 
     
      domEq=Last[DomEqualities[realDomExp]];
      If[ Length[domEq]>0,
        If[dbg,
          Print["Trying to fir the pipe vect into the lineality space ..."]
        ];

        If[ dbg,Print["Initial pipe Vect: ",pipe1]];
        numberOfLines=Length[domEq];

        (* Removing parameter because they should be considered as 
           constants *) 
        (* Linear equalities, removing constant, column vectors are 
           equalities *)
        domLinEq = Transpose[Map[Drop[#,-1-nbParam] &,domEq]]; 

        (* Symbolic variables names *)
        nsp = Select[nullSpace,First[#]===0 &];
        nsp=Map[Drop[#,-nbParam] &,nsp]; 

        tempPipe1=Drop[pipe1,-nbParam];
        TableVar = Table[tempVar[ToString[i]], {i, 1, Length[nsp]}];
        If [dbg,Print["TableVar= ",symbolicExpr]];
        symbolicExpr= tempPipe1+Dot[TableVar,nsp];
        If [dbg,Print["symbolicExpr= ",symbolicExpr]];
        tab1 = Table[0,{i,1,numberOfLines}];
        If [dbg,Print["equation= ",Dot[symbolicExpr,domLinEq],"==", tab1]];
        Off[Solve::svars];
        solu1=Solve[Dot[symbolicExpr,domLinEq]==tab1,TableVar];
        On[Solve::svars];
        If[ dbg,Print["solution= ",solu1]];
        (* Currently I do not know what to do if there is no solution .... *) 

        If[ Length[solu1]>0,    
          (* if we are here then there is a solution *) 
          newTableVar=TableVar/.solu1[[1]];
          freeVar = Select[newTableVar , MatchQ[#, tempVar[_]] &];
          If[ dbg,Print["free vars: ",freeVar]];
          newRule=Join[Map[Rule[#,0] &,freeVar],solu1[[1]]];
          If [dbg,Print["NewRule: ",newRule]];
          coefVect=TableVar/.newRule;
          If [dbg,Print["Coefficient for modyfiying pipe Vect: ",coefVect]];
          finalVect=tempPipe1+Dot[coefVect,nsp];
          pipe1=Join[finalVect,Table[0,{i,1,nbParam}]],
          If [dbg,Print["Finally pipe Vect: ",pipe1]];
   				 (*else, so solution *) 
          If[dbg,Print["fit failed  ..."]];		    
        ]
      ];
     
	
      If[ dbg, Print["Pipe vector chosen at level ",i," :" , pipe1 ] ];

      (* FIXIT *)
      If[pipe1[[1]]===0,
        Print[pipeControl::nullpipevec,variable];
        delocalizeControl[sys,variable,opts]; pipeVectorFound = True ];

      (* Make sure that pipeline vector time projection > 0 *)
      If[pipe1[[1]]<0,pipe1=-pipe1];

      (* Compute the cylinder generated by adding the projection 
        direction to context domain *)
      newDomContext=
        DomAddRays[domContext,
          matrix[1,domContext[[1]]+2,{},
          {Prepend[Append[projvect,0],0]}]];

      If[newDomContext===$Failed,
        (Message[pipeControl::wrgprojv,projvect]; Throw[sys])
      ];

      If[ dbg, Print[ "newDomContext before removing equalities: ", 
        ashow[ newDomContext, silent -> True ] ] ];

      (* Remove the equalities of newDomContext. 
             THIS SHOULD BE CORRECTED. FIXIT *) 
      newDomContext=
         ReplacePart[ newDomContext,
           Select[newDomContext[[3,1,5]], First[#]=!=0
           &],{3,1,5}];

      If[ dbg, Print[ "newDomContext after : \n", 
         ashow[ newDomContext, silent -> True ] ] ];

      (* Get all halfplanes of the resulting domain *)
      newDomContext = domExplode[newDomContext];
      If[ dbg, Print[ "Half spaces: " ] ];
      If[ dbg, Map[ ashow, newDomContext ] ];

      (* For debbuging purpose. FIXIT *)
	   (*
      If[ dbg,Global`$$dom = newDomContext];
	    *)

      (* Compute linear Half Spaces *)
      lhSpaces = Map[ linHalfSpace, newDomContext ];
      If[ dbg, Print[ "Linear half spaces: ", lhSpaces ] ]; 

      (* Select those such that pipeline vector points outwards   *)
      newDomContext = 
         Select[ newDomContext, (linHalfSpace[#1].pipe1)[[1]]>0&];

      If[ dbg, Print[ "Half space selected : ", 
        Map[show[#,silent->True] &,newDomContext] ] ]; 
      (* If none, signal and stop *)
      If[ newDomContext==={},
        i = i+1,
        pipeVectorFound = True
      ];
      If[ dbg, Print[ pipeVectorFound ] ];

    ]; (* While *)

     (* Print[ i ]; Print[ Length[ nn ] ]; *)

    If[ i > Length[ nn ], 
      (Print[pipeControl::nohspace];
       Print["Delocalizing control..."];
       newsys = delocalizeControl[sys,variable,opts];
       Throw[newsys])
    ];

  ];

  (* If more than one half space, chose the first one, and issue a warning *)
  pipeControl::manyhspace = 
  "warning: several supporting hyperplane were found. The first one was
  chosen";
  If[ Length[newDomContext]>1, Print[pipeControl::manyhspace] ];

  (* Extend pipeline vector to parameters *)
  pipe1 = Join[pipe1,Table[0,{i,1,dim-Length[pipe1]}]];

  (* Create new variable name *)
  newVariableName = getNewName[sys,variable<>"P"];
  If[ dbg, Print["New var name: ", newVariableName ] ];

  (* Compute translation matrix for pipeline *)
  tm = Check[translationMatrix[getDeclaration[sys,variable][[3,2]],pipe1],
	     Throw[sys]
  ];	     

  (* To avoid a message from pipeline *)
  Off[pipeline::noCheck];
  If[ dbg,
    Print["pipeline performed: newsys = pipeline[ sys, pos, newVariableName, tm, newDomContext[[1]] ]"];
    Print["with pos=",pos,"\n tm=",tm,"newDomContext[[1]]=",newDomContext[[1]]];
  ];
  Check[newsys = pipeline[ sys, pos, newVariableName, tm, newDomContext[[1]] ],
    Throw[On[pipeline::noCheck];
    Message[pipeControl::errpipe];
    sys]
  ];

  On[pipeline::noCheck];

  posNewEq=
    First[Position[newsys, equation[newVariableName,_]]];

  newEq = getPart[newsys,posNewEq];

  newEq=simplifyInContext[newsys,newEq];
  newsys=ReplacePart[newsys,newEq,posNewEq];

  (* This is the new domain where the True part is
    initialized. We intersect is with each case branch below *)

  newDomInit = 
    getPart[newsys,Join[posNewEq,{2,1,1,1}]];
If [dbg,Print["newDomInit",show[newDomInit,silent->True]]];
  newCaseBranch = 
    getPart[newsys,Join[posNewEq,{2,1,1,2}]]/.
	       (d1:_Alpha`domain :>   
		DomIntersection[d1,newDomInit]);
      newsys=ReplacePart[newsys,newCaseBranch,
			      Join[posNewEq,{2,1,1,2}]
  ];

  (* Normalizing the definition of the old variable 
     which should contains only spatial cases 
  newsys = normalizeDef[newsys,variable]; commented out*)

  newsys = convexizeAll[newsys]; 

	   
  (* The translator to AlpHard needs to have the
    initialization branch put in a separate variable *)

  If[ dbg, Print["Spatial dimension of the new case branch: ", realDimExp - nbParam - 2 ] ]; 

  If[realDimExp - nbParam - 2 >= 1,

    Check[ 
      newsys = pipeControl[newsys,newVariableName,opts],
      Throw[ sys ]
      ],
     
    (* else, : [realDimExp - nbParam = 1 we have only a temporal signal 
     In that case, we
       have finished the pipecontrol process, the translator
       to AlpHard needs to have the initialization branch
       put in a separate variable *)
(*
    nameInit = newVariableName<>"_Init";
*)
    nameInit = newVariableName<>"XInit";
    If[ dbg, Print["Name init var: ", nameInit ] ];

    If[dbg,Print["before addlocal"];ashow[newsys]];
 		 
    newsys = addlocal[newsys, nameInit, Join[posNewEq,{2,1,1}]];

    If[dbg,Print["after addlocal"];ashow[newsys]];
    (* The previous addlocal has produced a time case without a
       restriction, ie 
       case 
         var_Init;
         {t,p|...}: ...;
       esac;
       To get a space/time case we need to reintroduce a
       restriction in front of var_Init, and also the identity
       dependency 
    *)
    dom = getDeclaration[newsys, nameInit][[3]];
    dep11 = matrix[ dom[[1]]+1,
      dom[[1]]+1,
      dom[[2]] (* the index list *),
      IdentityMatrix[dom[[1]]+1] 
    ];

    newsys = 
      ReplaceAll[ newsys,
        { var[nameInit]-> restrict[ dom, affine[var[nameInit],
                                           dep11] ] 
        } 
    ];

    (* Also, the definition of var_In is not a space/time case
       since it starts with a restriction (the addLocal pointed
       to a space domain. We therefore need to surround it with a
       case 
    *)
    newsys = 
      ReplaceAll[newsys,
        {equation[nameInit, rhs_]->equation[nameInit, case[{rhs}]]}
    ];
		 

    If[dbg,Print["after je sais pas quoi "];ashow[newsys]];
    (* Finally we delocalize the control initialization
       variable (see below)     *)
    newsys = delocalizeControl[ newsys, nameInit , opts] 

    ];
    newsys

  ]
];

pipeControl[___]:=Message[pipeControl::args];


(* FIXIT *)
(* Delocalize (i.e. remove the processor indices of) a control variable.
   This function is called in two cases:

   1/  the variable is a control pipeline initialization variable,
       i.e varInit:{t,p| p=0, ...} (or sth like this) defined by
       var_ctl[t,p1,p2] = case {p=0; t=0} : True;
                               {p=0; t>0}: False;
			  esac;      
       We add a new local variable var_In = var_Init
       then we change this definition to 
          var_In[t,p1,p2...] = var_Init[t]
       and the semantics is preserved.

   2/  the variable is a full control variable which couldn t be
       pipelined, eg var_ctl:{t,p1,p2|  ...} defined by
       var_ctl[t,p1,p2] = case {t=0} : True;
                               {t>0}: False;
			  esac;
       it is possible to do the same in this case, and the semantics is
       also preserved.
*)

Clear[delocalizeControl];
delocalizeControl[sys:_system, variable:_String, opts:___Rule ]:=
Catch[
  Module[ { dom, pos, newsys, dep, nameIn, paramlist, newInitDom, newDep,
    domTrue, domFalse, newrhs, posTrue, posFalse, posDomTrue, posDomFalse,
    dbg, indexes, processorIndexes },


    If[ dbg, Print[ "Calling delocalize on variable : ", variable ] ];

    (* Name of new variable *)
(*
    nameIn = variable<>"_In";
*)
    nameIn = variable<>"XIn";

    (* First add a new local variable *)
    pos = First[ Position[ sys, var[variable] ] ];
    newsys = addlocal[sys, nameIn, pos];

    (* Now we need to change the domain of this variable
      and its definition, by removing the processor indices *)

    (* Get list of parameters *)
    paramlist = Part[newsys,2,2];

    (* Get the domain of variable *);   
    dom = getDeclaration[newsys, variable][[3]] ;

    (* Find out how many processor *)
    indexes = dom[[2]];
    processorIndexes = 
      Drop[ Drop[ indexes, 1 ], - Length[ paramlist ] ];
    If[ dbg, Print["Processor indexes: ", processorIndexes ] ]; 

(* 
    If[ Length[ processorIndexes ] > 1, 
      pipeControl::errordelocalize = 
       "        Warning: attempt to delocalize a 2 D variable, "<>
       "        which is currently not possible";
      Throw[ Print[ pipeControl::errordelocalize ];sys ] 
    ];
*)

    (* Project it on the time index (plus the parameters) *)
    newInitDom = DomProject[dom, Join[{"t"}, paramlist ]];

    (* NewDep is the dependency (t,p1,p2..->t) 
       between var_Init and var_In*)
    newDep = matrix[Length[paramlist]+2,
      Length[dom[[2]]]+1,
      dom[[2]],
      Delete[IdentityMatrix[Length[dom[[2]]]+1],
	Map[List,
	    Table[i,{i,2,Length[dom[[2]]]- Length[paramlist]}] 
        ]
      ] 
    ];

    (* Get position of the equation defining variable *)
    pos = First[ Position[ newsys, equation[variable,_] ] ];

    (* Get both time subdomains 
    If[ dbg, Print[ InputForm[ getPart[ newsys, pos ] ] ], ]; *)

    posTrue = Position[getPart[newsys,pos],True];
    posFalse = Position[getPart[newsys,pos],False];

    If[ Length[posTrue]=!=1 || Length[posFalse]=!=1,
      delocalizeControl::error = 
        "Warning, Something Wrong in delocalize Control"; 
      Throw[ Message[ delocalizeControl::error ] ] 
    ];

    posDomTrue = Join[pos,Append[Drop[posTrue[[1]],-3],1]];
    posDomFalse = Join[pos,Append[Drop[posFalse[[1]],-3],1]];
    domTrue = getPart[newsys, posDomTrue ];
    domFalse = getPart[newsys,posDomFalse ];

    (* Restrict them, just to be sure *)
    domTrue = DomIntersection[ domTrue, dom];
    domFalse = DomIntersection[ domFalse, dom];

    (* Save domains in global variable, for further exploration *)
    (*
    If[ dbg, Global`$$dt = domTrue; 
             Global`$$df = domFalse
    ];
     *)

    (* And project them to remove the processor indices *)
    (* Here is the bug. It is not always possible to project
       on all processor indexes... *)
    domTrue =  DomProject[domTrue, Join[{"t"}, paramlist ]];
    domFalse =  DomProject[domFalse, Join[{"t"}, paramlist ]];

    (*
    Global`$$dt1 = domTrue;
    Global`$$df1 = domFalse;
     *)

    If[ !DomEmptyQ[ DomIntersection[ domTrue, domFalse ] ], 
      Print[ "There is a problem here... See variables $$dt1 and $$df1" ] ];

    (* A dependency (t,N1,N2...->) for the True and False *)
    dep = Alpha`matrix[1,
      Length[newInitDom[[2]]]+1,
      newInitDom[[2]],
      {Join[Table[0,{Length[newInitDom[[2]]]} ],
      {1}]} 
    ];

    (* Which allows us to build the new RHS for variable *)
    newrhs = 
      Alpha`case[
        {Alpha`restrict[newInitDom,
           Alpha`case[{Alpha`restrict[
             domTrue,
               Alpha`affine[Alpha`const[True], dep]],
                 Alpha`restrict[
                   domFalse,
                   Alpha`affine[Alpha`const[False],
		  dep]
                 ]
         } ]]}
         ];


    (* And the new system *)
    newsys = ReplaceAll[newsys,
			    {Alpha`decl[variable,type_,_]
			     ->Alpha`decl[variable,
					  type,
					  newInitDom],
			     Alpha`equation[variable,_]
			     ->Alpha`equation[variable,
					       newrhs ],
			     Alpha`var[variable]
			     ->Alpha`affine[Alpha`var[variable],
					    newDep]
			     } ];	 

    If[ vrb || dbg || True, 
      Print["--- Control generated in cell(s): "<>
        ashow[
          DomProject[
            getDeclarationDomain[newsys,nameIn]
          ,
            Drop[getDeclarationDomain[newsys,nameIn][[2]],1]
          ]
        , 
          newsys[[2]]
        ,
          silent->True
        ]
      ]
    ];
	   newsys
    ]
];

delocalizeControl[___] := Message[ delocalizeControl::params ];


Clear[pipeAllControl]; 
Options[pipeAllControl] = {verbose->True, mute -> False};

pipeAllControl::args="Wrong arguments.";

pipeAllControl[] := pipeAllControl[{}];

pipeAllControl[ options:___Rule ] := pipeAllControl[ {options} ];

pipeAllControl[{options___Rule}] := 
  Module[{},
	 $program = $result;
	 $result = pipeAllControl[ $result, options ]
       ];

pipeAllControl[sys:_system, options___Rule] :=
Catch[
  Module[{ verb, ctrlist, i, newsys, dbg, muteOpt },
    verb = verbose/.{options}/.Options[pipeAllControl];
    dbg = debug/.{options}/.Options[pipeAllControl];
    muteOpt = mute/.{options}/.Options[pipeAllControl];
    If[ muteOpt, verb = False ];

    ctrlist = Map[First, Select[sys[[6]], isControlEquQ ] ];
    If[ dbg, Print["Control variables: ", ctrlist ] ];

    newsys = sys;

(*
    ctrllist = {"X_ctl2"};
*)
    ctrllist = {"Xctl2"};

    For[i=1, i<=Length[ctrlist], i=i+1,
      If[verb, Print["  Pipelining control for: ",ctrlist[[i]] ] ];
      Check[
        newsys = pipeControl[newsys, ctrlist[[i]], options],
        Throw[ sys ]
      ]
    ];
    newsys
  ]
];

pipeAllControl[___]:=Message[pipeAllControl::args]; 

End[];
EndPackage[]

