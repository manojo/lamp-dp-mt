(* ;-*-C-*- *)
(* static.m
   ======== 12/04/93 ------------------------------------------------- 01/03/95
 *)
(* Static analysis of an ALPHA program. The commands are: 
   - analyze, find, findAlpha, evalDom, evalDomAlpha, and
   dep.
   Usage updated by P. Quinton, 1/3/95
   findalpha replaced by findAlpha. (findalpha points to findAlpha,
   temporarily).
*)
(* $Id: Static.m,v 1.5 2010/04/14 18:03:50 quinton Exp $



   changelog: 1/3/95   by P. Quinton. usage updated
              19/4/95  by F. de Dinechin. Corrected a bug in addeq
	      which caused an error when analyze was run on another
	      system as $result
	      Changed a few meaningless names into explicit ones.
	      28/4/95 by F.de Dinechin. Added options control;
	               analyze now works with structured Alpha.
	      16/5/95 by F. de Dinechin. Global rewrite. find, etc
	              aliased to getDeclaration. 
              28/3/96 by F. de Dinechin. added parameter-aware 
	                analysis. Added proper use analysis.
			Corrected some bugs, added some other bugs


Warning : analyze needs the variable $RecursionLimit to be set 
to 1024 to run big programs without problem. 
	      
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2010/04/14 18:03:50 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Static.m,v $
	$Revision: 1.5 $
	$Log: Static.m,v $
	Revision 1.5  2010/04/14 18:03:50  quinton
	Minor modifications.
	
	Revision 1.4  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.3  2008/04/25 16:41:36  quinton
	Added a mute option, when True, absolutely no messages.
	
	Revision 1.2  2008/04/18 17:12:51  quinton
	Minor edition corrections
	
	Revision 1.1.1.1  2005/03/07 15:32:12  trisset
	testing mmalpha repository
	
	Revision 1.65  2004/12/29 09:57:07  quinton
	I made a small modification in the dep[] function, in order
	to have something compatible with the periods parameter
	of VertexSchedule.
	
	Revision 1.64  2004/09/16 13:44:57  quinton
	Updated documentation
	
	Revision 1.63  2004/08/02 13:14:43  quinton
	Documentation updated for reference manual
	
	Revision 1.62  2004/06/16 14:57:33  risset
	switched to ZDomlib
	
	Revision 1.60  2004/03/12 17:08:37  quinton
	A little bug.
	
	Revision 1.59  2003/12/12 13:17:01  risset
	 minor modif
	
	Revision 1.58  2003/07/18 12:52:42  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.56  2003/07/02 07:58:53  risset
	added Modifications for Zpolyhedra
	
	Revision 1.55  2002/09/10 15:12:51  quinton
	Minor corrections.
	
	Revision 1.54  2002/07/16 12:36:04  quinton
	The function expDomain does not check on the fly case expressions.
	This is now done by getContextDomain. Function analyze was modified
	in order to call getContextDomain to do the case checks.
	
	Revision 1.53  2001/08/16 14:30:02  quinton
	If modified for MMA 4.0
	
	Revision 1.52  2000/05/26 13:27:43  risset
	add options to analyze
	
	Revision 1.51  1999/12/10 16:59:05  risset
	commited struct Sched and ZDomlib
	
	Revision 1.50  1999/08/12 06:40:05  quinton
	Catch ajouté, et $Failed enlevés dans usewithextension
	
	Revision 1.49  1999/07/21 15:32:55  risset
	commited for GNU release 1.0
	
	Revision 1.48  1999/05/14 13:48:46  risset
	merge with Patrice version
	

	Revision 1.45  1999/05/06 12:08:51  risset
	corrected isSpaceSepQ
	
	Revision 1.44  1999/04/30 12:47:07  quinton
	Corrections of Patrice
	
	Revision 1.43  1999/04/20 13:04:45  risset
	mzrge two version of Static.m, apparently Patrice commited a version did not inclyded previous changes
	
	Revision 1.36  1998/02/16 17:07:57  quillere
	improved dep implementation (recursive->map)

	Revision 1.35  1998/02/10 08:56:37  quillere
	removed a double definition of identityMatrix

	Revision 1.34  1998/01/09 10:14:07  risset
	Tang

	Revision 1.33  1997/11/19 18:38:04  quillere
	added semantics for external pointwise operators

	Revision 1.32  1997/06/10 12:58:12  fdupont
	a few options added

	Revision 1.31  1997/06/03 13:04:42  risset
	added message error to dep and option to eliminate duplicates dependencies

	Revision 1.30  1997/05/20 08:56:38  quillere
	Correction de quelques erreurs (';' oubliés)

	Revision 1.29  1997/05/19 10:41:42  risset
	corrected exported bug in dependancies

	Revision 1.28  1997/05/13 13:40:57  risset
	report Patrice modifs on usage

	Revision 1.27  1997/04/10 15:10:56  risset
	added Options.m ScheduleTools.m OldSchedule.m remove NewSchedule.m

	Revision 1.26  1997/04/10 09:19:54  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.25  1997/02/21 10:43:50  fdupont
	minor changes to checkUseful

	Revision 1.24  1997/02/12 14:58:18  fdupont
	 bug fix in checkUseful

	Revision 1.23  1997/02/06 10:52:47  fdupont
	Minor change to checkUseful

	Revision 1.22  1997/02/06 10:32:12  fdupont
	added checkUseful

	Revision 1.21  1997/02/06 09:21:25  fdupont
	Added scalar type checking and corrected a few bugs

	Revision 1.20  1996/07/02 10:17:46  fdupont
	There was a bug : Analysis successful with never defined variables. It was a forgotten ; . I removed it

	Revision 1.19  1996/06/24 13:55:05  risset
	added standard head comments for CVS



*)
BeginPackage["Alpha`Static`",  {"Alpha`Domlib`", 
				"Alpha`",
				"Alpha`Options`",
				"Alpha`Matrix`",
				"Alpha`Tables`",
				"Alpha`Semantics`",
				"Alpha`Substitution`",
				"Alpha`Normalization`",
				"Alpha`Properties`",
				 "Alpha`ChangeOfBasis`",
				 "Alpha`SubSystems`"
				}]


Static::note = 
"Documentation revised on August 10, 2004";

Static::usage = 
"The Alpha`Static` package contains functions for the static analysis 
of Alpha programs. These functions are: analyze, dep, and checkUseful.";

(* StaticObsolete::usage = "
find : see getDeclaration\n
findalpha : see getDecl\n
findAlpha : see getDeclaration\n
evalDom : see expDomain\n
evalDomAlpha : see expDomainAlpha"
*)

analyze::usage =
"analyze[sys] performs a static analysis of system sys (default $result)
and returns True if
the analysis is successful (even with warnings), False otherwise.
The analyze function has options verbose, recurse, library and
scalarTypeCheck (see Options[analyze]). Option verbose (Boolean;
default True) reports analysis progress.  Option recurse (Boolean;
defaut False) recursively looks up for all the subsystems involved and
analyzes them, too.  Option library (List; default $library) gives the
library to search for subsystems. Example of option usage:
analyze[recurse->True, verbose->False]";

analyze::WrongOptions = "options must be False or True.";
analyze::ERROR = "`1`";

dep::usage = 
"dep[sys] generates a dependency table for sys (default $result).
The form of the table is:\n
dtable[{\n
  depend[ Domain, LHS_var_name, RHS_var_name, Matrix, RHS_var_domain],\n
  depend[ Domain, LHS_var_name, RHS_var_name, Matrix, RHS_var_domain],\n
  . . . \n
].\n
The table may be pretty--printed using show[dep[]]."

dep1::usage =
"dep1[sys, {occur:{_Integer..}, occurs___}] generates dependency
table entries for all occurrences in the list. Used by dep[] to
generate the dependency table.";

checkUseful::usage = 
"checkUseful[sys, var] checks that the variable var is used in the
system sys for all the points of its domain. Default value of sys
is $result. If var is omitted, the function is applied to all variables
of sys.";

checkEquations::usage = "";

checkEquation::usage = "";

checkDeclarations::usage =
"This function is a private function of the package.";

buildLHSIdList::usage =
"This function is a private function of the package.";

buildRHSIdList::usage =
"This function is a private function of the package.";

checkDefinitions::usage "";

checkVhdlIdentifiers::usage =
"checkVhdlIdentifiers[ sys ] checks that the variables of system sys can be distinguished
without case sensitivity. checkVhdlIdentifiers[] does the same for $result";

Begin["`Private`"] 

(* Added by P. Quinton on April 2010.  *)
Clear[checkVhdlIdentifiers];
heckVhdlIdentifiers[ opts:___Rule ]:= checkVhdlIdentifiers[ $result ];

checkVhdlIdentifiers[sys:_system, opts:___Rule] := 
Module[ {vars, vrb, dbg, varsUC, wrgVars},
  dbg = True;
  vars = Join[ getLocalVars[ sys ], getInputVars[ sys ], getOutputVars[ sys ] ];
	varsUC = Map[ ToUpperCase, vars ];

  If[ Length[ vars ] === Length[ Union[ varsUC ] ], 
    Return[],
    wrgVars = Select[ vars, Length[ Cases[ varsUC, ToUpperCase[#] ] ] >1& ];
      Print[" *** Warning: in program ", sys[[1]], " and for identifiers in ",
	    wrgVars, " there may be a problem when generating VHDL code, since Vhdl is not case-sensitive" ];
  ];
];
checkVhdlIdentifiers[___] := Message[ checkVhdlIdentifiers::params ];




(*--------------------------------------------------------------*)
Clear[ checkDefinitions ];
checkDefinitions[]:=
Module[ { ld, v, dec, def, declar },
  ld = getLocalVars[];
	Print[ ld ];
  For[ i=1, i<= Length[ ld ], i=i+1,
       Print[ i ];
    v = ld[[i]];
       Print[ v ];
    dec = getDeclarationDomain[ v ]; 
    def = expDomain[ getDefinition[ v ] ];
    If[ !DomEqualQ[ dec, def ]
    ,
      Print["Warning. For variable: ", v, "  there is a problem..."];
      declar = getDeclaration[ v ];
      $result = $result/.
        {declar -> decl[ v, declar[[2]], def ]};
    ]
  ]
];
checkDefinitions[___] := Message[ checkDefinition::params ];

Clear[analyze];

Options[analyze] = {verbose->True,
		    recurse->False,
		    library:>Alpha`$library, 
		    scalarTypeCheck->False,
		    checkSubSystems->True,
                    mute->False}

analyze[] := analyze[$result];

analyze[ syst:_system ] := analyze[syst, {}];

analyze[$Failed, ___] := 
  ( Print["Analysis not possible."];
    $Failed);

analyze[{}, ___] :=  (* when load fails *)
  ( Print["Nothing to analyze."];
    $Failed);

analyze[options_List] := analyze[$result, options];

analyze[syst:_system, options_List:{}]:= 
Module[ {verb, rec, lib, scalar, analysis, subSystems, results,
	  success, checkSubs, vars},
  analysis = 
  Catch[ 
    verb = verbose/.options/.Options[analyze];
    rec = recurse/.options/.Options[analyze];
    mu = mute/.options/.Options[analyze];
    If[ mu, verb = False ];
    lib = library/.options/.Options[analyze];
    scalar = scalarTypeCheck/.options/.Options[analyze];
    checkSubs = checkSubSystems/.options/.Options[analyze];
    vars = variable/.options/.Options[analyze];

    If[
      Union[{False, True}, {verb}, {rec}, {scalar},{checkSubs}] =!= {False, True},
      Message[analyze::WrongOptions]; Throw[$Failed]
    ];

    If[
      rec
    ,
      subSystems = findAllSubSystems[ syst[[6]], lib];
      If[
        verb,
        Print["Need to analyze : ",  Join[ subSystems, {syst[[1]]} ]]
      ];

      results = 
        Map[
          Function[
            analyze[getSystemClean2[#, lib],Join[{recurse->False},options]]
          ],
          subSystems 
        ]
      ,
      results = {} 
    ];

    If[
      verb,
      (Print[" "]; Print["Static Analysis of system ", syst[[1]] ] ) 
    ];

    (* First, syntactic checks on the declarations  *)
    (* Abort here if there was an error *)
    If[
      checkDeclarations[ syst, verb],
      Throw[$Failed]
    ]; 

    (* Verify the consistency of the system for all values of the parameters *)
    (* Check the consistency of all the equations, and subsystem uses *)
    If[
      checkEquations[syst, lib, verb, scalar, checkSubs],
      Throw[$Failed]
    ];

    (* Check outputs. Added by PQ on Nov. 2007 *)
    If[ !mu, Print["--Checking regularity of output equations"] ];
    If[ 
      !areAllOutputsRegular[ syst ],
      Print["----Outputs equations are not regular. Use mkAllOutputsRegular."],
      If[ verb, Print["----Outputs equations are regular." ]]
    ];

    (* Check outputs. Added by PQ on Nov. 2007 *)
    If[ !mu, Print["--Checking Vhdl identifiers"] ];
    checkVhdlIdentifiers[ syst ];

    Throw[Null]
  ];

  If[
    analysis === $Failed,
    If[ verb, Print["\n*** Analysis failed ***"]	]; 
    success = False,
    If[	verb, Print["\nAnalysis Successful..."]	];
    success = True
  ];
	
  (* If option recurse is set, call analyze on library *)
  If[
    rec,
    success = Apply [ And, Append[ results, success] ];
    If[
      verb,
      If[ 
        success,
        If[ !mu, Print["\nRecursive Analysis Successful."] ],
        Print["\n***Recursive Analysis failed ***"]
      ]
    ]
  ];

  success 
]; (* End Module *)

analyze[options___Rule] := analyze[Alpha`$result, {options}];
analyze[sys_Alpha`system,options___Rule] := analyze[sys, {options}];

analyze[____] := $Failed;


(*--------------------------------------------------------------*)
(*    findAllSubSystems recursively finds all the subsystems
      use d in the equation list   *)

Clear[ findAllSubSystems ];

findAllSubSystems[ equs_List, lib_List] :=
Module[ {matches, others},
  matches = Union[  Cases[ equs, use[name_,_,_,_,_] -> name ] ];
  others = Map[ Function[ getSystemClean[#, lib] ], matches ];
  others = Complement[ others, {$Failed}]; 
  others = Map[ Function[ findAllSubSystems[ #[[6]], lib ] ], others ]; 
  Flatten[ Union[ matches, others ] ]
];

findAllSubSystems[___] := Message[ findAllSubSystems::params ];

(* These are local functions *)
(* This function is the same as getSystem, except that it does not
   change $result and $program       *)
Clear[getSystemClean, getSystemClean2];
getSystemClean[id_String, lib_List] :=
Module[{systemFound},
       systemFound = Cases[lib, Alpha`system[id,__] ];
       If[ systemFound=!={},
	   First[systemFound],
	   $Failed ]
     ];

getSystemClean2[id_String, lib_List] :=
Module[{systemFound},
       systemFound = Cases[lib, Alpha`system[id,__] ];
       If[ systemFound=!={},
	   First[systemFound],
	   (Print["ERROR: subsystem ",id, " not found in library."];
	    $Failed) ]
     ];


(*--------------------------------------------------------------*)
(* checkDeclarations[] verifies that the variables are declared,
	       and that the declared variables are used *)

checkDeclarations[ sys:system[ name_, params_, 
				     {input___}, {output___},
				     {local___}, 
				     {eqns___} ],
                   verb_] :=   
Module[ 
  { inputids, outputids, localids, lhsids, rhsids,
      declids, bodyids, tmp, error},
	error = False;
	inputids =  Cases[ {input}, Alpha`decl[id_, _, _] -> id];
	outputids = Cases[ {output}, Alpha`decl[id_, _, _] -> id];
	localids =  Cases[ {local}, Alpha`decl[id_, _, _] -> id];
	lhsids = buildLHSIdList[{eqns}];
	rhsids = buildRHSIdList[{eqns}]; 
	If[
		verb, 
		Print["--Checking declaration of variables."]
	];

	declids = Union[ inputids, outputids, localids ]; 
	bodyids = Union[ lhsids, rhsids ];
	tmp = Complement[ bodyids, declids];
	If[
		tmp =!= {},
		Print[ "ERROR: Variable(s) ", ToString[tmp]," not declared.\n" ];
		error = True
	];

	(* Single assignment rule *)
	If[
		verb,
		Print["--Checking single assignment rule."]
	];
	
	If[
		Length[lhsids] != Length[Union[lhsids]],
		Print[
			"ERROR: Variable(s) ",
			StringJoin[Union[Map[
				Function[
					x,
					If[
						Count[lhsids,x] >1,
						x<>" ",
						""
					  ]
					],
					lhsids
				]]]
		];
		Print["        defined by more than one equation.\n"];
		error = True;
	];

	If[
		verb, 
		Print["--Checking definitions of output/local variables."]
	];
	error = error || allOutLocAtTheLHS[ lhsids, Union[outputids, localids]];

	If[
		verb, 
		Print["--Checking definition of input variables."]
	];
	error = error || noInputIdAtTheLHS[ lhsids, inputids];

	If[
		verb, 
		Print["--Checking that input/local variables are used."]
	];
	allInLocIdsAtTheRHS[ rhsids, Union[inputids, localids]];
	error
]; (* End Module *)
	
checkDeclarations[____] :=
 ( Print["Problem in checkDeclarations."];
   Throw[$Failed] )


(* The following functions are used by checkDeclaration *)

Clear[allOutLocAtTheLHS];

allOutLocAtTheLHS[ lhsids___, {id_, idlist___}] :=
	If[
		MemberQ[ lhsids, id],
		allOutLocAtTheLHS[ lhsids, {idlist}],
		Print["ERROR: Output/local variable ",id];
		Print["       does not appear at the LHS of any equation.\n"];
		allOutLocAtTheLHS[ lhsids, {idlist}];
		True
	]

allOutLocAtTheLHS[ lhsids___, {}] := False;

Clear[allInLocIdsAtTheRHS];

allInLocIdsAtTheRHS[ rhsids___, {id_, idlist___}] :=
	If[
		MemberQ[ rhsids, id],
		allInLocIdsAtTheRHS[ rhsids, {idlist}],
		Print["WARNING: Input/local variable ", id, " does not appear at the RHS of any equation\n"];
		allInLocIdsAtTheRHS[ rhsids, {idlist}];
		True
	]

allInLocIdsAtTheRHS[ rhsids___, {}] := False;

Clear[noInputIdAtTheLHS];

noInputIdAtTheLHS[ lhsids___, {id_, idlist___} ] :=
	If[
		MemberQ[ lhsids, id],
		Print["ERROR: Input variable : ", id];
		Print["       appears at the LHS of an equation or system use.\n"];
		noInputIdAtTheLHS[ lhsids, {idlist}];
		True,
		noInputIdAtTheLHS[ lhsids, {idlist}]
	];

noInputIdAtTheLHS[ lhsids___, {}] := False;


(* ************* Cleaning stopped here *)

(*---------------------------------------------------------------*)
(* checkEquations is called by analyze[].                        *)

Clear[checkEquations];

checkEquations[ sys:_system, lib___, verb_, scalar_,checkSubs_] :=
Module[{errorList},
  If[ verb,
    Print["--Checking type and domain consistency in the equations:"]];
  errorList = Map[ Function[ equ, checkEquation[ sys, equ, lib,
    verb, scalar, checkSubs] ],
    sys[[6]] (* the equations... *)
  ];
  (* return True if errorList contains some True s*)
  Union[errorList]=!={False}
];

(* Check equation when the equation is a use...
   Returns True if there has been an error, False if this use is OK *)
(* This function is too long.. FIXIT *)

Clear[ checkEquation ];
checkEquation[ v:_String, opts:___Rule ] := 
Catch[
  Module[ { eq, vrb, dbg },
    Check[ 
      eq = getEquation[ v ],
      checkEquation::nodef = "var '1' not defined";
      Throw[ Message[ checkEquation::nodef, v ] ] 
    ];

    {vrb, dbg} = {verbose, debug}/.{opts}/.Options[ analyze ];

    checkEquation[ $result, getEquation[ v ], True, True, False ];
  ];
];
checkEquation[ sys:_system, 
	       use[name_, extdom_, passgn_, actin_,actout_],
	       lib___,
	       verb_,
	       scalar_,
	       checkSubs_] :=
Module[ {matches, ss, error, sspdom, pextdom, projdom, paramdom, paramlist,
	  i, lhsdom, rhsdom, decldom, tmp, localerror},
  Catch[
    If[ verb, Print["----use ", name,"..."]];
    error = False;
    matches = Cases[lib, system[name, _,_,_,_,_]];

    (* Check that subsystem exists in library *)
    If[ (matches == {}),
      (* If check subsystem option set *)
      If[ checkSubs, 
        (Print["ERROR: Declaration of system : ", name];
         Print["       not found in library.\n"];
         Throw[ True] )
        ,
        Throw[False]
      ]
    ];

    (* Check that subsystem is declared only once *)
    If[ Length[matches] >1,
       Print["WARNING: more than one declarations of ",
	     name, " in library. Using the first.\n"] 
    ];

    ss = matches[[1]];

    (* Check the number of inputs *)
    If[ Length[actin] != Length[ ss[[3]] ], 
      (Print["ERROR: Subsystem ", name, 
       " used with ", Length[actin],
       " input(s)"];
       Print["        ",  Length[ss[[3]]], " expected.\n"];
         error = True) 
    ];

    (* Check number of outputs *)
    If[ Length[actout] != Length[ ss[[4]] ], 
      (Print["ERROR: Subsystem ", name,
        " used with ", Length[actout],
        " output(s),"];
       Print["        ", Length[ss[[4]]], " expected.\n"];
       error = True) 
    ];

    sspdom = ss[[2]];
    (* Check assignement of parameters *)
    If[ passgn[[1]]-1 =!= sspdom[[1]],
      (Print["ERROR: In use ", name, ", ",
       passgn[[1]]-1, 
       " parameter(s) assigned,"];
       Print["        ", sspdom[[1]], " expected.\n"];
		error = True) 
    ];

    (* Check indices of lhs *)
    If[ passgn[[2]] - 1 =!= extdom[[1]],
      (Print["ERROR: In use ", name, ", ", 
       passgn[[2]] -1, " indice(s) on the LHS"];
       Print["        of the parameter assignation, ",
       extdom[[1]], " expected.\n"];
       error = True) 
    ];

    If[ error, Throw[True] ];

    (* Check that the extension domain is not empty *)
    paramdom = sys[[2]];	(* change *)
    paramlist = If[Head[paramdom[[3,1]]]===Alpha`pol,paramdom[[2]],paramdom[[3,1,1,3]]];
    pextdom = addParameterDomain[ extdom, paramdom ];
    projdom = DomProject[ pextdom, paramlist ];
    tmp = DomDifference[ paramdom, projdom];

    If[ !DomEmptyQ[ tmp ],
	       (Print["WARNING: In use ", name, "," ];
		Print["         empty extension domain for parameters in :"];
		ashow[ tmp ])
    ];

    (* Check that the parameters assigned fall within
	      the parameter domain of the subsystem *)
    rhsdom = DomImage[pextdom, passgn]; (* change : check for ZImage/Image *)
    tmp = DomDifference[ rhsdom, zpolToPol[sspdom] ]; (***????????????????***)

    If[ !DomEmptyQ[ tmp ],
	    (Print["ERROR: Subsystem ", name];
	     Print["        used with unpermitted parameter values :"];
	     (* in the show, we replace the index list of
		tmp with those of sspdom *)
	     ashow[tmp/.(If[Head[rhsdom[[3,1]]]===Alpha`pol,rhsdom[[2]],rhsdom[[3,1,1,3]]])	(* change *)
			-> (If[Head[sspdom[[3,1]]]===Alpha`pol,sspdom[[2]],sspdom[[3,1,1,3]]]) ]; Print[" "];
	     error = True) 
    ];

    (* Check the inputs as if they were equations : 
	   formal = actual *)
    For[i=1,
      i<=Length[actin],
      i=i+1,

      error = error || 
      Catch[
        localerror=False;
        If[ scalar,
          ltype = ss[[3]][[i]][[2]];
          rtype = expType[ sys, actin[[i]] ];
          If[ matchTypes[ltype,rtype]  =!= ltype,
            Print["ERROR: in use ", name,
            ", type of actual input ",i,
            " (", rtype, ")"];
            Print["       conflicts with type of formal input ",
            i," (", ltype, ")"];
            localerror=True; 
          ]
        ];

        decldom = ss[[3]][[i]][[3]];
        lhsdom = substDom[ decldom, extdom, passgn, ss[[2]][[1]] ]; 
        rhsdom = expDomain[ sys, actin[[i]] ];
        If[ rhsdom === $Failed, Throw[True] ];
        If[ lhsdom[[1]] =!= rhsdom[[1]],
          (Print["ERROR: In use ", name,
           ", dimension of #", i, " actual input"];
           Print["        don't match dimension ",
             " of formal input ",
             ss[[3]][[i]][[1]]  ]; Print[" "];
	  Throw[True])
        ];

        subdom = DomDifference[ 
            addParameterDomain[ lhsdom, sys[[2]] ],
		rhsdom
        ];

        If[ DomEmptyQ[ subdom],
		  Null,
			  (Print["ERROR: In use ", name,
				 ", input #",i,
				 " not assigned over the domain :"];
			   ashow[subdom, sys[[2]] ]; Print[" "];
			   Throw[True])];
		      localerror  
        ] (* End Catch *)
      ]; (* End For *)

      (* Check the outputs as if they were equations :
         actual = formal*)
      For[i=1,
        i<=Length[actout],
        i=i+1,
        error = error || 
        Catch[
          localerror=False;
          If[scalar,
			 rtype = ss[[4]][[i]][[2]];
			 ltype = expType[ sys, actout[[i]] ];
            If[ matchTypes[ltype,rtype]  =!= ltype,
              Print["ERROR: in use ", name,
		   ", type of actual output ",i,
		   " (", ltype, ")"];
	     Print["       conflicts with type of formal output ",
		   i," (", rtype, ")"];
	     localerror=True; 
            ]
          ];
          decldom = ss[[4]][[i]][[3]];
          rhsdom = substDom[ decldom, 
					 extdom,
					 passgn,
					 ss[[2]][[1]] 
          ]; 
          lhsdom = expDomain[ sys, actout[[i]] ];
          If[ lhsdom === $Failed, Throw[True] ];
          If[ lhsdom[[1]] =!= rhsdom[[1]],
	  (Print["ERROR: In use ",name,
		 ", dimension of return variable ",
		 actout[[i]] ];
	   Print["        ",
		 "don't match dimension of formal output ",
		 ss[[4]][[i]][[1]]  ]; Print[" "];
		   Throw[True])
          ];

          subdom = DomDifference[ 
            addParameterDomain[ lhsdom, sys[[2]] ],
            rhsdom];

          If[ !DomEmptyQ[ subdom],
            (Print["ERROR: In use ", name,
             ", return variable ",actout[[i]] ];
             Print["        ",
             "not assigned over the domain :" ];
             ashow[subdom, sys[[2]] ]; Print[" "];
             Throw[True])
          ];
        localerror
        ]
      ]; (* End For *)
      error 
  ]
];

(* Check equation when the equation is an equation...
   Returns True if there has been an error, False if this equation is OK *)

checkEquation[ sys:_system,
	       e: equation[var_, expr_],
	       lib___, 
	       verb_,
	       scalar_,
	       checkSubs_]  :=
Module[
  {rtype, ltype, lhsdom, rhsdom, subdom, projdom, paramdom, 
   paramlist, tmp, error, casePositions, equationPosition},

  If[ verb, Print["----equation defining ", var]];  
  dbg = False;

  error = False; 

  Catch[
    (* Checking types of lhs and rhs *)

    If[scalar,
       rtype = expType[sys,expr];
       ltype = getDeclaration[ sys, var ] [[2]];
       If[ matchTypes[ltype,rtype]  =!= ltype,
	   Print["ERROR: in equation defining ", var];
	   Print["       type of LHS (", ltype,
		 ") conflicting with type of RHS (",rtype,")"];
	   error = True;
	 ]
     ];
    

    (* Get lhs and rhs domain *)
    lhsdom = getDeclaration[ sys, var ] [[3]];
    
    rhsdom = expDomain[ sys, expr ];

    (* Checking cases. This was added by Patrice (11/7/2002) 
       to replace the on the fly check by expDomain which was
       too restrictive. *)
    casePositions = Position[ e, case[___] ];

    If[ dbg, Print[ casePositions ] ]; 
    equationPosition = First[ Position[ sys, e ] ]; 
    If[ dbg, Print[ equationPosition ] ];
    casePositions = Map[ Join[ equationPosition, # ]&, casePositions ];
    casePositions = Map[ Append[ #, 1 ]&, casePositions ];
    If[ dbg, Print[ casePositions ] ];

    Map[ getContextDomain[ sys, #, checkCase -> True ]&, casePositions ];

    If [ rhsdom === $Failed, Throw[True] ];

    (* Check dimensions *)
    If[ lhsdom[[1]] =!= rhsdom[[1]],
	(Print["ERROR: In equation defining variable : ", var];
	 Print["        domains of the RHS and LHS have different dimensions.\n"];
	 Throw[True])];
  
    (* Get parameter domain *)
    paramdom = sys[[2]];

    (* subdom is the difference between the domain of the lhs 
       and the rhs *)
    subdom = 
      DomDifference[ addParameterDomain[ lhsdom, paramdom ],
				   rhsdom];
    paramlist = 
      If[Head[paramdom[[3,1]]]===Alpha`pol,paramdom[[2]],paramdom[[3,1,1,3]]];	(* change *)

    (* Project subdom on the parameters *)
    projdom = DomProject[subdom, paramlist];

    (* Compute the difference between the parameter dom, and 
       the projection of subdom on the parameters *)
    tmp = DomDifference[ paramdom, projdom];

    (* If subdom is not empty, this means that 
       the variable is not defined on all points of its
       declaration domain. There are two cases. If tmp is
       empty, the error concerns all parameters. If tmp is
       not empty, then we know for which values of the parameters
       the definition is missing *)
    If[ !DomEmptyQ[ subdom],      
      If[ DomEmptyQ[tmp],
        (Print["ERROR: Variable ", var,
         " not defined over the domain :"];
         ashow[subdom, sys[[2]] ]; Print[" "];
         Throw[True]
        )
      ,
       (Print["ERROR: For the values of the parameters in : "];
        ashow[ DomIntersection[ paramdom, projdom]];
        Print["        variable ", var, 
          " not defined over the domain : "];
          ashow[subdom, sys[[2]] ]; Print[" "];
          Throw[True]
       ) 
      ]
    ];
    error
  ] (* End Catch *)
];

checkEquation[a:___] := Message[ checkEquation::params ];

Clear[buildLHSIdList];

(******* working fine on Zpol ***********)
buildLHSIdList[lts_List] := 
	Block[
		{},
		buildLHSIdLista[{}] := {};
		buildLHSIdLista[{Alpha`equation[id_, _], eqs___}] := 
			Join[{id}, buildLHSIdLista[{eqs}]];
		buildLHSIdLista[{Alpha`use[_,_,_,_,retids___], eqs___}] := 
			Join[retids, buildLHSIdLista[{eqs}]];
		buildLHSIdLista[lts]
	];


Clear[buildRHSIdList];

(******* working fine on Zpol ***********)
buildRHSIdList[lts_List] :=
	Block[
		{},
		buildRHSIdLista[{}] := {};
		buildRHSIdLista[{Alpha`equation[_, exp_], eqs___}] := 
			Union[buildExprIdList[exp], buildRHSIdLista[{eqs}]];
		buildRHSIdLista[{Alpha`use[_,_,_,exprs___,_], eqs___}] := 
			Union[ Flatten[Map[ buildExprIdList, exprs]],buildRHSIdLista[{eqs}]];
		buildRHSIdLista[lts]
	];

buildExprIdList[lts_] := Block[{},
  buildExprIdLista[Alpha`var[id_]] := {id}; (* .......................... id *)
  buildExprIdLista[Alpha`const[_]] := {}; (* ................ num or boolean *)
  buildExprIdLista[Alpha`index[_]] := {}; (* ...............index expression *)
  buildExprIdLista[Alpha`binop[_,exp1_,exp2_]] := (* ................. binop *)
    Union[ buildExprIdLista[exp1], 
	   buildExprIdLista[exp2] ];
  buildExprIdLista[Alpha`call[_String,args_List]] := (* ............... call *)
    Join@@(buildExprIdLista /@ args);
  buildExprIdLista[Alpha`unop[_,exp_]] := (* .......................... unop *)
    buildExprIdLista[exp]; 
  buildExprIdLista[Alpha`if[exp1_,exp2_,exp3_]] := (* ................... if *)
    Union[ buildExprIdLista[exp1], 
	   buildExprIdLista[exp2],
	   buildExprIdLista[exp3] ]; 
  buildExprIdLista[Alpha`affine[exp_,_]] := (*....................... affine *)
    buildExprIdLista[exp]; 
  buildExprIdLista[Alpha`restrict[_,exp_]] := (* ...................restrict *)
    buildExprIdLista[exp]; 
  buildExprIdLista[Alpha`case[{exp_,exps___}]] := (* .................. case *)
    Union[ buildExprIdLista[exp],
	   buildExprIdLista[Alpha`case[{exps}]]]; 
  buildExprIdLista[Alpha`case[{}]] := {};
  buildExprIdLista[Alpha`reduce[_,_,exp_]] :=  (* ....................reduce *)
    buildExprIdLista[exp];  
  buildExprIdLista[lts] ]



Clear[identityMatrix];
identityMatrix::usage = 
"identityMatrix[ ids ] returns the Alpha identity Matrix built on indexes
ids (strings)"; 
identityMatrix[ids:{}|{_String..}] :=
Module[{dim},
   dim = Length[ids]+1;
   Alpha`matrix[dim, dim, ids, IdentityMatrix[dim]]
];
identityMatrix[___] := Message[ identityMatrix::params ]; 

(*----------------------------------------------------------------*)
(*           Fonctions pour l''analyse des dependances           *)
(*           Utilisees par le package Schedule.m                *)


(* This is the old version of getContext *)
(* until the DomProject problem is solved *)
(* TR 23/08/95 *)
getContext[sys_Alpha`system, {occur:{_Integer..}, occurs___}] :=
( Print["? doesn't make sense to find a context for a list"];
  Print["  of occurences."];
  $Fail )

(* change *)
getContext[sys_Alpha`system, occur:{_Integer..}] :=
Module[{exp,dom},
    exp = lookUpFor[sys, occur, Alpha`equation]; (* = equation[var,exp] *)
    dom = Part[getDeclaration[sys, Part[exp,1]], 3]; (* = domain of var *)
    If[
    	Head[dom[[3,1]]]===Alpha`pol,
	ReplacePart[                                 (* put in good indices *)
		getContext1[dom,identityMatrix[dom[[2]]], Part[exp,2], Drop[occur,3]],
		dom[[2]],{1,2}
	],
	ReplacePart[                                 (* put in good indices *)
		getContext1[dom,identityMatrix[dom[[3,1,1,3]]], Part[exp,2], Drop[occur,3]],
		dom[[3,1,1,3]],{1,3,1,1,3}
	]
     ]
]

(* This is the new version which does not work 

getContext[sys:_system, {occur:{_Integer..}, occurs___}] :=
( Print["? doesn't make sense to find a context for a list"];
  Print["  of occurences."];
  $Fail )

getContext[sys_Alpha`system, occur:{_Integer..}] :=
Module[{exp,dom,dvar},
    exp = lookUpFor[sys, occur, Alpha`equation]; 
    dvar= Part[getDeclaration[sys, Part[exp,1]], 3]; 
    dom = DomIntersection[dvar, DomProject[sys[[2]],dvar[[2]] ] ];
    ReplacePart[                                 
      getContext1[dom,
                  identityMatrix[Part[dom,2]], Part[exp,2], Drop[occur,3]],
      dom[[2]],
      {1,2}
    ]
]
*)
(* getContext1[dom_,mat_, Alpha`restrict[dom1_,exp_], occur:{_Integer..}] :=
    getContext1[DomIntersection[dom, dom1],mat,exp,Drop[occur,1]] *)

(* change *)
getContext1[dom_,mat_, Alpha`restrict[dom1_,exp_], occur:{_Integer..}] :=
    getContext1[
      DomIntersection[
        dom,
        DomZPreimage[dom1,mat]
	],
      mat,exp,Drop[occur,1]
    ]

(* getContext1[dom_,mat1_, Alpha`affine[exp_,mat2_], occur:{_Integer..}] :=
    getContext1[DomImage[dom,mat2], composeAffines[mat2,mat1],
                      exp, Drop[occur,1]] *)

getContext1[dom_,mat1_, Alpha`affine[exp_,mat2_], occur:{_Integer..}] :=
    getContext1[dom, composeAffines[mat2,mat1], exp, Drop[occur,1]]

getContext1[dom_,mat1_, Alpha`index[mat2_], occur:{_Integer..}] :=
    {dom, composeAffines[mat2,mat1]}

getContext1[dom_, mat_, exp_, {pos_, poss___}] :=
    getContext1[dom, mat, Part[exp,pos], {poss}]

getContext1[dom_, mat_, _, {}] := {dom, mat}


(* Global function *)
Clear[dep];

Options[dep] = 
  {debug -> False,
   verbose -> True,
   eliminatesDoubles->False,
   (* This options is added by Tanguy in order to eliminate
      double dependencies which are exactly equal *)
   equalitySimpl->True
   (* This option was added by Manju to forbid
      simplification of the dependencies by equalitites 
      in the context*),
   parameterConstraints->False,
   subSystems->True};

dep::UseNotImplemented = "use construct can not be handle by dep function";
dep::WrongArg = "Wrong Argument for dep function: `1`"
dep1::WrongArg="Wrong Argument for dep1 function: `1`" 

dep[ ] := dep[$result,{}];
dep[ optionsList_List ]:= dep[ $result, optionsList ];
dep[ options:___Rule ]:= dep[ $result, {options} ];
dep[sys_Alpha`system]:= dep[sys,{}];
dep[sys_Alpha`system, options:___Rule]:= dep[sys,{options}];


dep[ sys: Alpha`system[ name_, param_, in_, out_, loc_, eqns_ ],
  optionsList_List]:=
Catch[
  Module[{ depRes1, optSimplify, uses, optsubsystems, occurs, dbg , dp1, xx },

    (* Option to handle subsystems *)
    optsubsystems = subSystems/.optionsList/.Options[dep];
    dbg = debug/.optionsList/.Options[dep]; 

    (* List of use statements *)
    uses = Cases[ sys, use[___], Infinity ]; 
    If[ !optsubsystems && uses != {}, Throw[ Message[ dep::UseNotImplemented ] ] ];
    If[ dbg, Print[ "Use statements: ", uses ] ];

    (* List of occurrences of vars *)
    occurs = getOccurs[ sys, var[_] ];
    If[ dbg, Print[ "Occurences of equations: ", occurs ]];    

    (* Keep only real equations *)
    occurs = Select[ occurs, MatchQ[ getPart[ sys, Take[ #, 2 ] ], equation[___] ]& ];
    If[ dbg, Print[ "Occurrences of real equations: ", occurs ] ];

    (* Calling dep1 *)
    depRes1 = dep1[ sys, occurs, optionsList ];

    If[ dbg, Print[ "Normal dependencies: \n", ashow[ Alpha`dtable[ depRes1 ], silent->True ] ] ];

    (* This options is added by Tanguy in order to eliminate
       double dependencies which are exactly equal *)
    optSimplify = eliminatesDoubles/.optionsList/.Options[dep];
    If[ optSimplify, depRes1 = Union[ depRes1 ] ];

    If[ dbg, Print[ "Calling dep1 with uses ", uses, " and options ", optionsList ] ];
    (* Add use dependencies, if not empty. This modification 
       was done in such a way that dep[subsystems->True] and dep[] give
       the same result, when there are no use statements *)
    xx = 
    With[ {dp1 = dep1[ sys, uses, optionsList]},
      If[ optsubsystems && dp1 =!= {}, 
        dtable[ 
          depRes1, 
          (*
          Select[dep1[ sys, uses, optionsList ],#=!={} & ]
          *)
          dp1
        ], 
        Alpha`dtable[ depRes1 ] ] 
    ];
    xx
    ]
];

dep[a___]:= Message[dep::params];

(* Local function *)
Clear[dep1];

Options[dep1] := Options[dep]

(* To call dep1 on a list of uses, Map it on a use plus the rank of the use 
   in sys *)
dep::usewithextension = "`1`: this use statement contains a dimension extension"; 
dep::usewithexpressions = "`1`: this use statement contains expressions as inputs"; 
dep::usewithnonidentityparam = 
"`1`: this statement contains a non identity  parameter expression"; 

(* The dep1 function is listable *)
dep1[ sys_, u:{use[___]...}, opts:{___Rule} ] := 
    MapThread[ dep1[ sys, #1, #2, opts ]&, {u, Range[Length[u]]} ];
(* Case of a use statement. Added by Patrice *)

(*
  I removed this case, as it would produce no depuse for 
  a system without input and output lists, and that is not 
  compatible with the periods parameters... PQ. December 2004
(* empty list of input vars *)
dep1[ sys_, 
      u: use[
             ssName:_String, 
             ssDom:_domain, 
             ssMat:_matrix, 
             ssIn: {},
             ssOut: {__}], 
      r:_Integer,
      opts:{___Rule}] := {}
*)

dep1[ sys_, 
      u: use[
             ssName:_String, 
             ssDom:_domain, 
             ssMat:_matrix, 
             ssIn: {___},
             ssOut: {__}], 
      r:_Integer,
      opts:{___Rule}] := 
Catch[
  Module[{ params, dbg, simplifyEq },
    (* debug option *)
    dbg = debug/.opts/.Options[ dep1 ];
    simplifyEq=equalitySimpl/.opts/.Options[dep1];
	If[ dbg, Print[ "Analyzing: ", ashow[ u, silent->True ] ]]; 
    (* Reject use with extension, for the moment *)
    If[ (* ssDom =!= sys[[2]] *) False, 
        Throw[ Message[ dep::usewithextension, ashow[ u, silent->True ] ] ] ];
    (* Reject input or output arguments which are not simple variables *)
    If[ !MatchQ[ ssIn, {var[_]...} ], 
        Throw[ Message[ dep::usewithexpressions, ashow[ u, silent->True ] ] ] ];
    (* Get the parameters *)
    params = If[Head[sys[[2,3,1]]]===Alpha`pol,sys[[2,2]],sys[[2,3,1,1,3]]];	(* change *)
    (* Reject the case of non identity actual parameters, for the moment *)
(*
    If[ ssMat =!= identityMatrix[params], 
        Throw[ Message[ dep::usewithnonidentityparam, ashow[ u, silent->True ] ] ], ];
*)
    (* Return a dependuse entry *)
    Alpha`dependuse[ ssName, Map[ First, ssIn ], ssOut, r, ssDom, ssMat ]
  ]
]; 

(* dep1 is listable *)
dep1[ sys_, occ: { {_Integer..}.. }, opts:{___Rule}] := 
  Map[ dep1[ sys, #, opts]&, occ ];

(* compute dependency table *)
dep1[ sys_, occ: {_Integer..}, opts:{___Rule}] := 
Module[ { rhsvar, rhsdom, lhsvar, context, intersect, preim, pc ,simplifyEq, dbg},

   (* Get options *)
   pc = parameterConstraints/.opts/.Options[dep1];
   simplifyEq=equalitySimpl/.opts/.Options[dep1];
	(* Get the rhs var *)
   rhsvar = getPart[sys, occ][[1]];

   (* Get the domain of the rsh variable. Depends on the option 
      parameterConstraints *)

   If[ !pc, rhsdom = getDeclaration[sys, rhsvar][[3]],
            rhsdom = getDeclarationDomain[sys, rhsvar] ];

   (* Get the equation defining the lhsvar *)
   lhsvar = lookUpFor[sys, occ, Alpha`equation][[1]];

   (* Get the context of the occurence *)
   context = Check[ getContext[sys, occ], Throw[ Message[ dep::error ] ] ];

   (* Compute the preimage of the rhsdom by the context *)
   preim = Check[ 
     DomZPreimage[rhsdom,context[[2]]], Throw[ Null ] 		(* change *)
   ];

   (* Intersect the first part of the context by the preimage *)
   intersect = 
   Check[ 
     DomIntersection[ 
       context[[1]], 
       preim
     ], 
     Throw[ Null ] 
   ];

   If[ simplifyEq===False, 
     newContext=context[[2]],
     newContext = 
     DomMatrixSimplify[
       context[[2]],
       DomEqualities[ context[[1]] ]
     ]
   ];

   (* Return the entry *)
   Alpha`depend[ 
     intersect,
     lhsvar,
     rhsvar,
     newContext,
     rhsdom
   ]
]; (* Module *)

dep1[sys_, {}, opts:{___Rule}] := {}

dep1[sys_, a___]:= (Message[dep1::WrongArg,a];Throw["ERROR"])




(*----------------checkUseful--------------------------*)
(* Local function *)
Clear[checkUsefulEqu];

checkUsefulEqu[sys:_system, varname_String] :=
Catch[
  Module[{usedomain,positionlist},
	 usedomain = Check[ addParameterDomain[ getDeclaration[ sys,
							varname][[3]],
					sys[[2]] ], 
		            Throw[ Message[ checkUsefulEqu::interr ] ]
			  ];
	 
         positionlist = Position[sys, Alpha`var[varname], Infinity];
	 If [positionlist=!={},
	     usedomain = getContextDomain[sys,positionlist[[1]]];
	     Map[Function[(usedomain =
			   DomDifference[usedomain,
					 getContextDomain[sys,#]];
			   )],
		 positionlist]];
	 If[ (!DomEmptyQ[usedomain])&&(!MemberQ[getOutputVars[sys],varname]),
	     Print["Variable ",varname,
		   " declared but never used on domain:"];
	     ashow[usedomain];
	   ];
	usedomain
      ]
]; (* Catch *)
checkUsefulEqu[___] := Message[ checkUsefulEqu::params ];

(* Global Function  *)
Clear[checkUseful];
checkUseful[] := checkUseful[$result];
checkUseful[varname_String] := checkUsefulEqu[ $result, varname ];
checkUseful[sys:_system,varname_String] := checkUsefulEqu[ sys, varname ];

checkUseful[sys:_system] :=
Module[{varlist},
  varlist = Map[First, Join[ sys[[3]], sys[[5]] ] ];
  Map[ Function[checkUsefulEqu[sys,#]],
    varlist ];
];
checkUseful[___] := Message[ checkUseful::params ];

End[]
(* end the private context *)

EndPackage[]  
(* end the package context *)
