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
BeginPackage["Alpha`Substitution`", {"Alpha`Domlib`",
				     "Alpha`",
				     "Alpha`Options`",
				     "Alpha`Matrix`",
				     "Alpha`Tables`",
                                     "Alpha`Static`",
                                     "Alpha`Normalization`",
				     "Alpha`Semantics`"
				     }]

(*  $Id: Substitution.m,v 1.6 2009/05/22 10:24:36 quinton Exp $

    changelog:
    5/14/1993, Z. Chamski: changed 'substituteDef' to 'substituteInDef',
                           added 'occursInDef' and 'accessByPath'.
    5/17/1993, Z. Chamski: changed 'occursInDef' to 'getOccursInDef',
                           added predicate 'occursInDefQ'
    6/02/1993, Z. Chamski: updated usage messages wrt. new conventions
    6/04/1993, Z. Chamski: added faculty to specify lists of occurrences in
                           'getOccursInDef' and 'substituteInDef'
    6/16/1993, Z. Chamski: moved 'accessByPath' to "Alpha`Tables`"
    6/18/1993, Z. Chamski: added interactive occurrence search
                           ('getInteractive')
    7/26/1993, Z. Chamski: added 'unusedVarQ', 'removeUnusedVar' and
                           'removeAllUnusedVars'
    11/30/1993, Z. Chamski: completed the definitions of 'unusedVarQ',
			   'removeUnusedVar' and 'removeAllUnusedVars'.
			   Cleaned up documentation strings.
			   Added "Alpha`" package prerequisite.
    11/30/1993, Z. Chamski: added 'getOccurs'.
    4/20/1994,  D. Wilde  : fixed bug in substituteInDef[system,
                           lhs_String, substituted_String, rank] :=...
    4/6/1995,   P. Quinton : fixed bug in substituteInDef, so that
                           arguments can be symbols
                             same for replaceDefinition
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:36 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Substitution.m,v $
	$Revision: 1.6 $
	$Log: Substitution.m,v $
	Revision 1.6  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.5  2008/12/29 17:41:57  quinton
	SubstituteInDef and getOccursInDef were modified and simplified.
	
	Revision 1.4  2008/04/01 19:44:38  quinton
	Added functions isOutputRegular aso. to check if an output is of the form o = v and change it if necessary. Also removed a bug of the version MMA 6.0 due to a double semicolon
	
	Revision 1.3  2005/05/13 08:21:10  ebecheto
	Ed modif for truncate_*SB procedure
	
	Revision 1.2  2005/04/29 10:26:19  trisset
	added setBitWidth
	
	Revision 1.1.1.1  2005/03/07 15:32:14  trisset
	testing mmalpha repository
	
	Revision 1.36  2004/09/16 13:44:56  quinton
	Updated documentation
	
	Revision 1.35  2004/08/02 13:15:03  quinton
	Documentation updated for reference manual
	
	Revision 1.34  2004/06/16 14:57:34  risset
	switched to ZDomlib
	
	Revision 1.33  2004/04/26 08:34:14  risset
	added system File before patrice visit
	
	Revision 1.32  2003/07/18 12:52:42  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.30  2002/09/12 14:47:22  risset
	commit after patrice update and correction of Pipecontrol
	
	Revision 1.29  2002/06/07 11:55:07  quinton
	addLocal was modified.
	
	Revision 1.28  1999/12/10 16:59:05  risset
	commited struct Sched and ZDomlib
	
	Revision 1.27  1999/05/18 16:24:30  risset
	change many packages for documentation
	
	Revision 1.26  1999/05/10 13:14:15  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.25  1999/03/02 15:49:28  risset
	added GNU software text in each packages
	
	Revision 1.24  1998/12/16 13:38:35  risset
	added simplifySchedule
	
	Revision 1.23  1998/04/10 08:03:23  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.22  1998/02/16 17:07:03  risset
	Packages pass all tests

	Revision 1.21  1997/08/27 15:16:45  fdupont
	Fixed a bug in unusedVarQ

	Revision 1.20  1997/07/09 14:25:41  fdupont
	minor bug fix

	Revision 1.19  1997/06/26 16:01:37  fdupont
	minor bug fix

	Revision 1.18  1997/06/20 13:33:14  risset
	added a message for addlocal

	Revision 1.17  1997/06/16 15:58:18  fdupont
	added addlocal with position specification

	Revision 1.16  1997/05/22 14:43:34  risset
	corrected messages

	Revision 1.15  1997/05/19 10:41:45  risset
	corrected exported bug in depedancies

	Revision 1.14  1997/05/13 13:41:01  risset
	report Patrice modifs on usage

	Revision 1.13  1997/04/22 10:57:25  risset
	removed some cycling dependencies between packages

	Revision 1.12  1997/04/10 09:19:56  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.11  1997/03/19 15:22:03  fdupont
	buggy contexts

	Revision 1.10  1997/03/19 13:19:39  fdupont
	...oops

	Revision 1.9  1997/03/19 13:10:19  fdupont
	corrected Need[] bug

	Revision 1.8  1997/02/07 11:01:09  fdupont
	corrected a big bug in substituteInDef : now an occurence of the variable is replaced with the RHS of its definition, *restricted with the declaration domain of this variable*. This ensures that both programs, before and after substitution, are equivalent.

	Revision 1.7  1996/06/24 13:55:09  risset
	added standard head comments for CVS



*)

Substitution::note = 
"Documentation revised on August 8, 2004";

Substitution::usage =     
"Alpha`Substitution` is the package which contains the 
functions for substituting Alpha variables.";

addLocal::usage = "see addlocal in Substitution.m";

addlocal::usage = 
"addlocal[sys, var, exp] declares a new local variable var in system sys
and defines it as exp on the domain of exp as calculated by expDomain.
All instances of exp in sys are replaced with the variable var.\n
addlocal[sys, var, pos] adds a new local variable var defined on the 
context domain of pos (as calculated by getContextDomain[])
and adds the definition of var as the expression at position pos.
The expression defined by pos is replaced by var. Default value of 
sys is $result. WARNING: This function is kept for backward compatibility, 
but it is not sufficiently specified, please use rather addLocalLHS or addLocalRHS functions";

addLocalLHS::usage = 
"addLocalRHS[var, exp] is similar to addlocal (see addlocal) but 
its action is more clearly defined. From a set of equations such as
\nA =...; X =...A...\n addLocalLHS[\"B\",\"A\"] changes it into\n
B = A; A =...; X =...B....\n
i.e., B is added in the LHS of the equation using A.";

addLocalRHS::usage = 
"addLocalRHS[var, exp] is similar to addlocal (see addlocal) but 
its action is more clearly defined. From a set of equations such as
\nA =Y; X =...A...\n addLocalRHS[\"B\",\"A\"] changes it into\n
A=B;B=Y;X=...B....,\n
i.e., B is added in the RHS of the equation using A, except if 
A is an input, in which case it acts as addLocalLHS:\n
B=A; X=...B....";

addlocal::invalidPos = "Not the position of an expression";
addlocal::empty = "Domain of new variable is empty";
addlocal::params = "wrong parameters";
addlocal::note = 
"addlocal is more or less the inverse transformation of substituteInDef."

getNewName::usage = 
"getNewName[sys,var] checks that the identifier \"var\" is not already 
used in sys (default $result) and returns it if not. If this 
identifier already exists, it returns a modified version of \"var\" 
by duplicating its last letter.";

getOccurs::usage =
"getOccurs[sys,p] finds out the positions of a pattern p in system sys, 
and returns a Mathematica position specifier containing the list of 
occurrences of p in $result. The pattern p can be a string (e.g. 
\"A.(i,j->i+j)\"), in which case it is parsed, or it can be an Alpha 
AST. The result of getOccurs is a list of positions specifiers that
are defined with respect to sys. A position specifier can then be 
used in the function Part to access the element. For example, if the
position is {6,2,3}, then Part[sys,6,2,3] gives the element. One can
also use getPart[sys,{6,2,3}], which is easier to use directly.";

getOccursInDef::usage =
"getOccursInDef[sys, var, p] lists the positions of occurrences of 
a pattern p in the definition of variable lhs inside an ALPHA program
sys (default $result). 
\ngetOccursInDef[sys, var, p, rank] gives the position number rank
in the result of getOccursInDef[sys, var, p].
rank specifies which occurrence to report (1 = first, 2 = second, 
{1,2}= first and second, etc).";

replaceDefinition::usage = 
"replaceDefinition[lhs, rhs] replaces the definition of a variable lhs 
in an equation of program $result with the Alpha expression rhs.
replaceDefinition[sys, lhs, rhs] replaces the definition of variable 
lhs in an ALPHA program sys with the Alpha expression rhs and return 
the new system. lhs is a variable name (either symbol or string). 
rhs is either an ast or a string.";

replaceDefinition::note =
"The function returns a copy of the original program in which the rhs of the
equation defining the specified variable is replaced by an expression passed
as parameter. The result of the substitution is not normalized. The meaning
of the program may be changed by this transformation."

replaceDefinition::lhs=
"lhs should be a variable name, either
in String of Symbol form";

replaceDefinition::rhs="rhs should be an Alpha expression";

replaceDefinition::arg1="first argument should be an alpha ast";
replaceDefinition::WrongArg = "Wrong Argument for replace Definition: `1`"

substituteInDef::usage = 
"substituteInDef[lhs, var] substitutes in $result all occurrences of
variable `var' in the RHS of the definition of variable `lhs' by the
definition of `var', and returns the new system in $result.
substituteInDef[lhs,var,rank] substitutes occurrences `rank' of
variable `var' in the RHS of the defition of variable `lhs' by the
definition of `var'. The parameter rank specifies which occurrence to
replace ( 1 = first, 2 = second, {1,2}= first and second,
etc). substitute[sys,lhs,var] and substitute[sys,lhs,var,rank] do
the same on program contained in symbol `sys'.";

occursInDefQ::usage =
"occursInDefQ[sys,var,p] returns True if the pattern p occurs in the
of the definition of the variable var. Default value of sys is $result.
p can be either a string or an AST.";

unusedVarQ::usage =
"unusedVarQ[sys,var] is True if var is used in the rhs of an equation
of system sys, False otherwise. Default value of sys is $result.";

removeUnusedVar::usage =
"removeUnusedVar[sys,var] removes the definition of unused variable
var in system sys. The default value of sys is $result."; 

removeAllUnusedVars::usage =
"removeAllUnusedVars[sys] removes the definitions of all unused local
variables of system sys (default, $result).";

isOutputRegular::usage = 
"isOutputRegular[sys,o] is True if output variable o has the form
o = v[__] where v is a simple variable. This predicate allows one to 
detect non regular outputs";

areAllOutputsRegular::usage =
"areAllOutputsRegular[ sys ] is True if all outputs of sys have the form
o = v[__], False otherwise. areAllOutputsRegular[] does the same to $result.";

mkOutputRegular::usage =
"mkOutputRegular[sys,o] makes output variable o regular, if necessary.
In other words, it makes sure that the definition of o has the form 
o = v where v is a simple local variable. mkOutputRegular[o] does the
same to $result."

mkAllOutputsRegular::usage =
"mkAllOutputsRegular[sys] makes all output variables of sys regular.
mkAllOutputsRegular[] does the same on $result."

replaceInDef::usage =
"replaceInDef[sys, def, v, exp] replaces the first occurrence of var v
in definition def by Alpha expression exp. replaceInDef[ def, v, exp ]
does the same on $result.";

replaceInput::usage =
"replaceInput[sys, v, exp] replaces input var v by a new definition";

Begin["`Private`"]

(* " *)
Clear[ replaceInput ];
replaceInput[var:_String, exp:_String] :=
Catch[
  Module[ {pg,rpg,ss},
    pg = $program; rpg = $result;
    Check[ 
      ss = replaceInput[ $result, var, exp ],
      replaceInput::err1 = "could not achieve replacement ";
      $result = rpg; $program = pg;
      Throw[ Message[replaceInput::err1] ];
    ];
    $program = rpg; $result = ss
  ];
];

replaceInput[sys:_system, v:_String, exp:_String] :=
Catch[
  Module[ {inputs, ss, occ, ee, aff, dom, deff },
    ss = sys;

    inputs = getInputVars[ sys ];
    If[ !MemberQ[ inputs, v ],
      replaceInput::err2 = "could not find input var `1` ";
      Throw[ Message[replaceInput::err2, v] ];
    ];

    replaceInput::err3 = "could not find occurences of var `1` ";
    Check[
      occ = getOccurs[ sys, var[ v ] ],
      Throw[ Message[replaceInDef::err3, v] ];
    ];

    If[ occ === {}, Throw[ Message[replaceInDef::err3, var ] ] ];

    ee = readExp[ exp, getSystemParameters[ ss ] ];

    If[ ee === Null,
      replaceInDef::err4 = "could not parse expression `1` ";
      Throw[ Message[replaceInDef::err4, exp] ];
    ];

    If[ !MatchQ[ ee, affine[ var[ v ], _matrix ] ], 
      replaceInDef::err5 = "expression should be of the form `1`.(dependence)";
      Throw[ Message[replaceInDef::err5, v] ];
    ];

    aff = ee[[2]];
    dom = getDeclarationDomain[ sys, v ];
    ashow[ dom ];

    Check[
      dom = DomImage[ dom, aff ],
      replaceInDef::err5 = "could not compute image of input domain";
      Throw[ Message[replaceInDef::err6] ];
    ];

    ss = ReplacePart[ ss, occ -> ee ]; 

    def = getDeclaration[ sys, v ];

    occDecl = getOccurs[ sys, decl[ v, ___ ] ];

    ss = ReplacePart[ ss, occDecl -> decl[ v, def[[2]], dom ] ]

  ]
];
replaceInput[___] := Message[ replaceInput::params ];

(* replaceInDef *)
Clear[ replaceInDef ];
replaceInDef[def:_String, var:_String, exp:_String] :=
Catch[
  Module[ {pg,rpg,ss},
    pg = $program; rpg = $result;
    Check[ 
      ss = replaceInDef[ $result, def, var, exp ],
      replaceInDef::err1 = "could not achieve replacement ";
      $result = rpg; $program = pg;
      Throw[ Message[replaceInDef::err1] ];
    ];
    $program = rpg; $result = ss
  ];
];

replaceInDef[sys:_system, def:_String, var:_String, exp:_String] :=
Catch[
  Module[ {ss, ee, eq, occ},
    ss = sys;
    Check[
      eq = getEquation[ sys, def ],
      replaceInDef::err2 = "could not find equation for symbol `1` ";
      Throw[ Message[replaceInDef::err2, def] ];
    ];

    replaceInDef::err3 = "could not find var `1` in definition of `2` ";
    Check[
      occ = getOccursInDef[ sys, def, var ],
      Throw[ Message[replaceInDef::err3, var, def] ];
    ];

    If[ occ === {}, Throw[ Message[replaceInDef::err3, var, def] ] ];

    ee = readExp[ exp, getSystemParameters[ ss ] ];

    If[ ee === Null,
      replaceInDef::err4 = "could not parse expression `1` ";
      Throw[ Message[replaceInDef::err4, exp] ];
    ];

    ss = ReplacePart[ ss, occ[[1]] -> ee ];
    ashow[ ss ];
    ss

  ]
];

replaceInDef[___] := Message[ replaceInDef::params ];

(* 
  Added Nov. 2007. Checks if an output var is regular, i.e., defined
  by means of a local variable 
*)
Clear[isOutputRegular];
isOutputRegular[ o:_String ] := isOutputRegular[ $result, o ];

isOutputRegular[ sys:_system, o:_String ] :=
Catch[
  Module[ {ovs, equat},
    Check[ 
      ovs = getOutputVars[ sys ],
      isOutputRegular::error1 = "error while looking vor local variables";
      Throw[ Message[ isOutputRegular::error1, o ] ]
    ];
    If[ !MemberQ[ ovs, o ], 
      isOutputRegular::notOutputVar = "`1` is not an output variable";
      Throw[ Message[ isOutputRegular::notOutputVar, o ] ]
    ];
    Check[ 
      equat = getEquation[ sys, o ],
      isOutputRegular::error2 = "could not find definition of `1`";
      Throw[ Message[ isOutputRegular::error2, o ] ]
    ];
    MatchQ[ equat, equation[ o, var[ _ ]|affine[ var[_], _] ] ]
  ]
];

isOutputRegular[ ___ ] := Message[ isOutputRegular::param ]

(* 
  Added Nov. 2007. Makes an output variable regular.
*)
Clear[ areAllOutputsRegular ];

areAllOutputsRegular[] := areAllOutputsRegular[ $result ];

areAllOutputsRegular[ sys: _system ] := 
Catch[
  Module[ {ov,res},
    Check[
      ov = getOutputVars[ sys ],
      areAllOutputsRegular::error1 = "error while calling getOutputVars";
      Throw[ Message[ areAllOutputsRegular::error1 ] ]
    ];

    Check[ 
      Apply[ And, Map[ isOutputRegular[ sys, # ]&, ov ] ],
      areAllOutputsRegular::error2 = "error while calling isOutputRegular";
      Throw[ Message[ areAllOutputsRegular::error2 ] ]
    ]

  ]
];

areAllOutputsRegular[ ___ ] := Message[ areAllOutputsRegular::param ];


(* 
  Added Nov. 2007. Makes an output variable regular.
*)
Clear[mkAllOutputsRegular];

mkAllOutputsRegular[] :=
  ($program = $result;
   Check[
     $result = mkAllOutputsRegular[ $program ],
     $result = $program
   ];
 $result
);

mkAllOutputsRegular[ sys: _system ] := 
Catch[
  Module[ {ov,res},
    Check[
      ov = getOutputVars[ sys ],
      mkAllOutputsRegular::error1 = "error while calling getOutputVars";
      Throw[ Message[ mkAllOutputsRegular::error1 ] ]
    ];

    Check[ 
      res = Fold[ mkOutputRegular, sys, ov ],
      mkAllOutputsRegular::error2 = "error while calling getOutputVars";
      Throw[ Message[ mkAllOutputsRegular::error2 ] ]
    ];
    res 
  ]
];

mkAllOutputsRegular[ ___ ] := Message[ mkAllOutputsRegular::param ];

(*  *)
Clear[mkOutputRegular];
mkOutputRegular[ o:_String ] := 
  ($program = $result;
   Check[
     $result = mkOutputRegular[ $program, o ],
     $result = $program
   ];
 $result
);

mkOutputRegular[ sys:_system, o:_String ] :=
Module[ {res},
  Catch[
    Check[ 
      If[ isOutputRegular[ sys, o ], 
        mkOutputRegular::error1 = "`1` is already regular";
        Throw[ Message[ mkOutputRegular::error1, o ] ]; sys
      ],
      mkOutputRegular::error2 = "error while calling isOutputRegularr";
      Throw[ Message[ mkOutputRegular::error2 ] ]; sys
    ];

    Check[ 
      res = addLocalRHS[ sys, getNewName[o], o ],
      mkOutputRegular::error3 = "could not add local definition for `1`";
      Throw[ Message[ mkOutputRegular::error3, o ] ]; res = sys
    ]

  ];
  res
];

mkOutputRegular[ ___ ] := Message[ mkOutputRegular::param ]

(****************************************)
(* replace the definition of a variable *)
(****************************************)
Clear[replaceDefinition];

(* implicit program ==> use $result *)

replaceDefinition[lhs_, rhs_] := (* Filter second arg *)
  replaceDefinition[ToString[lhs], rhs];

replaceDefinition[lhs_String, rhs_String] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = replaceDefinition[Alpha`$program, lhs, rhs];
   If[ Alpha`$result===$Failed, Alpha`$result=Alpha`$program;$Failed, Alpha`$result]
  );

replaceDefinition[lhs_String, rhs_] :=
  (Alpha`$program = Alpha`$result ;
  Alpha`$result = replaceDefinition[Alpha`$program, lhs, rhs];
   If[ Alpha`$result===$Failed, Alpha`$result=Alpha`$program;$Failed, Alpha`$result]
  )

(* explicit program ==> don t change default variables *)
replaceDefinition::WrongExpr="Wrong Alpha expression: `1`"

replaceDefinition[alpha_Alpha`system, lhs_String, rhs_String] :=
  Module[{exp1},
	 exp1=readExp[rhs, alpha[[2]]];
	 If [exp1===Null,
	     Message[replaceDefinition::WrongExpr,rhs];
	     $Failed,
	     replaceDefinition[alpha,lhs,exp1]]]

replaceDefinition::VarNotFound="Equation defining `1` was not found"

replaceDefinition[alpha_Alpha`system, lhs_String, rhs_] :=
  Module[{occurs},
	 occurs=getOccurs[alpha,Alpha`equation[lhs, _]];
	 If [occurs==={},
	     Message[replaceDefinition::VarNotFound,lhs];
	     $Failed,
	     alpha /. {Alpha`equation[lhs, _] -> Alpha`equation[lhs, rhs]}]]

(* Filter second arg *)
replaceDefinition[alpha_Alpha`system, lhs_, rhs_] :=
  replaceDefinition[alpha, symToString[lhs], rhs]

replaceDefinition[$Failed, _, rhs_/;rhs=!=Null] :=
  ( Message[replaceDefinition::arg1]; $Failed );
replaceDefinition[_, $Failed, rhs_/;rhs=!=Null] :=
  ( Message[replaceDefinition::lhs];$Failed );
replaceDefinition[_, _, $Failed] :=
  ( Message[replaceDefinition::rhs];$Failed );

(* universal kitchen sink *)
replaceDefinition[$Failed, _] := (Message[replaceDefinition::lhs];$Failed);
replaceDefinition[_, $Failed] := (Message[replaceDefinition::rhs];$Failed);

replaceDefiniton[a___] := Message[replaceDefinition::WrongArg,a]

(************************************************************)
(* substitute the occurence of a variable by its definition *)
(************************************************************)
Clear[substituteInDef];

(* implicit program ==> use $result *)

substituteInDef[lhs_String, substituted_String] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = substituteInDef[Alpha`$program, lhs, substituted])/;
MatchQ[ $result, _system];

substituteInDef[lhs_String, substituted_String] :=
  (substituteInDef::notsys = "$result is not a system";
   Message[ substituteInDef::notsys ])/;!MatchQ[ $result, _system];

substituteInDef[lhs_String,
		substituted_String,
	        rank:(_Integer | {_Integer..})] :=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = substituteInDef[Alpha`$program, lhs, substituted, rank])

  (*
substituteInDef[$Failed, _] := $Failed		(* universal kitchen sink *)
substituteInDef[_, $Failed] := $Failed

substituteInDef[lhs_, rhs_] :=	(* filter symbols *)
  substituteInDef[symToString[lhs], symToString[rhs]]

substituteInDef[lhs_, rhs_, rank:(_Integer | {_Integer..})] :=
  substituteInDef[symToString[lhs], symToString[rhs], rank]
   *)

(* explicit program ==> do not change default variables *)

substituteInDef[alpha_Alpha`system, lhs_String, substituted_String] := 
Catch[
  Module[ { exp0, exp1, occs },
    Check[
      exp0 = getDeclaration[alpha,substituted],
      substituteInDef::decl = "could not find variable `1` in program `2`";
      Throw[Message[substituteInDef::decl, substituted, alpha]]
    ];
    exp0 = exp0[[3]];

    exp1 = 
    Check[
      getDefinition[alpha,substituted],
      substituteInDef::def = "could not find definition of variable `1`";
      Throw[Message[substituteInDef::def, substituted]]

    ];

    Check[
      occs = getOccursInDef[ alpha, lhs, substituted ],
      substituteInDef::err = "error while calling getOccursInDef";
      Throw[ Message[ substituteInDef::err ] ]
    ];

	  (*
    If[ 
      getOccursInDef[ alpha, lhs, substituted ] === {},
      substituteInDef::noocc = "there is no occurence of variable `1` in definition of variable `2`";
      Throw[Message[substituteInDef::noocc, substituted, lhs]]
    ];
	   *)

    replaceDefinition[alpha, lhs,
        getDefinition[alpha, lhs] /.
        Alpha`var[substituted] -> Alpha`restrict[exp0,exp1]
    ]
  ]

];
				     

(* occurrence list supplied ==> modify only the relevant occurrences *)

substituteInDef[
  alpha_Alpha`system,
  lhs_String,
  substituted_String,
  rank:(_Integer | {_Integer..})] := 
Catch[
  Module[{exp0,exp1},
    Check[
      exp0 = getDeclaration[alpha,substituted],
      substituteInDef::decl = "could not find variable `1` in program `2`";
      Throw[Message[substituteInDef::decl, substituted, alpha]]
    ];
    exp0 = exp0[[3]];


    exp1 = 
    Check[
      getDefinition[alpha,substituted],
      substituteInDef::def = "could not find definition of variable `1`";
      Throw[Message[substituteInDef::def, substituted]]

    ];

    exp3 = 
    Check[
      exp3 = Part[getOccursInDef[alpha,lhs, Alpha`var[substituted]],
			    rank],
      substituteInDef::occ = "could not find occurence `1` of variable `2`";
      Throw[Message[substituteInDef::def, rank, substituted]]
    ];

    Check[ReplacePart[alpha,
      Alpha`restrict[ exp0,exp1], exp3],
		   Throw[$Failed]
    ]
  ]
];

  (*

substituteInDef[$Failed, _, _] := $Failed
substituteInDef[_, $Failed, _] := $Failed
substituteInDef[_, _, $Failed] := $Failed

substituteInDef[alpha_Alpha`system, lhs_, rhs_] :=	
(* filter symbols *)
   substituteInDef[alpha, symToString[lhs], rhs]/;Not[StringQ[lhs]]

substituteInDef[alpha_Alpha`system, lhs_, rhs_] :=	
(* filter symbols *)
   substituteInDef[alpha, lhs, symToString[rhs]]/;Not[StringQ[rhs]]

substituteInDef[alpha_Alpha`system, lhs_, rhs_,
   rank:(_Integer | {_Integer..})] :=
 substituteInDef[alpha, symToString[lhs], rhs, rank]/;Not[StringQ[lhs]]

substituteInDef[alpha_Alpha`system, lhs_, rhs_, rank:(_Integer | {_Integer..})] :=
 substituteInDef[alpha, lhs, symToString[rhs], rank]/;Not[StringQ[rhs]]
   *)

substituteInDef[___] := Message[ substituteInDef::params ];

(***************************************************)
(* check for occurrences of a pattern in a program *)
(***************************************************)

Clear[getOccurs]

getOccurs[stringPattern_String] :=
  getOccurs[Alpha`$result, stringPattern]

getOccurs[pattern_] :=
  getOccurs[Alpha`$result, pattern]

getOccurs[sys_Alpha`system, stringPattern_String] :=
  getOccurs[sys, readExp[stringPattern,sys[[2]]]]

getOccurs[sys_Alpha`system, pattern_] :=
  Position[sys, pattern]

(***********************************************************************)
(* check for the occurences of a pattern in some variable''s definition *)
(***********************************************************************)
Clear[getOccursInDef];

(* implicit program ==> use $result *)

getOccursInDef[lhs_String, rhs_] :=
  getOccursInDef[Alpha`$result, lhs, rhs]

(*
getOccursInDef[$Failed, _] := $Failed		(* universal kitchen sink *)
getOccursInDef[_, $Failed] := $Failed
*)

(* explicit program ==> don t change default variables *)

getOccursInDef[alpha_Alpha`system, lhs_String, rhs_String] := 
Catch[
      Module[{def},
    Check[
      def = getDefinition[alpha, lhs],
      getOccursInDef::def = "could not find definition of variable `1`";
	     Throw[ Message[ getOccursInDef::def, lhs ] ]
    ];

    Map[(Join[First[Position[alpha, def]], #])&,
      Position[def, readExp[rhs,alpha[[2]]]]]

  ]
];

(* This definition applies for a pattern *)
getOccursInDef[alpha_Alpha`system, lhs_String, rhs_] := 
  With[{def = getDefinition[alpha, lhs]},
        Map[(Join[First[Position[alpha, def]], #])&,
	   Position[def, rhs]]]

(*
getOccursInDef[$Failed, _, _] := $Failed		(* universal kitchen sink *)
getOccursInDef[_, $Failed, _] := $Failed
getOccursInDef[_, _, $Failed] := $Failed

getOccursInDef[_, _, _] := $Failed		(* if all else fails ... *)
 *)

(*****************************************************************************)
(* extract the position of the nth occurrence of a pattern in the definition
   of a variable *)
(*****************************************************************************)

getOccursInDef[lhs_, patt_, rank:(_Integer | {_Integer..})] :=
Catch[
  Module[{occurlist},
    Check[
      occurlist = getOccursInDef[lhs, patt],
      Throw[ {} ]
    ];
    If[occurlist =!= {}, Part[occurlist, rank], {}]
  ]
];

getOccursInDef[prog_Alpha`system, lhs_, patt_, 
  rank:(_Integer | {_Integer..})] :=
Catch[
  Module[{occurlist},
    Check[
      occurlist = getOccursInDef[prog, lhs, patt],
      Throw[{}]
    ];
    If[occurlist =!= {}, Part[occurlist, rank], {}]
  ]
];

getOccursInDef[___] := Message[ getOccursInDef::params ];

(***********************************************************************)
(* check for the presence of a pattern in the definition of a variable *)
(***********************************************************************)
Clear[occursInDefQ];

occursInDefQ[var_String,patt_String] := getOccursInDef[var,patt] =!= {};
occursInDefQ[prog_Alpha`system,var_String,patt_String] :=
 getOccursInDef[prog,var,patt] =!= {};
occursInDefQ[var_, patt_String]:=
  occursInDefQ[symToString[var],patt];
occursInDefQ[var_String, patt_]:=
  occursInDefQ[symToString[var],symToString[patt]];
occursInDefQ[var_, patt_]:=
  occursInDefQ[symToString[var],symToString[patt]];


(************************************************************************)
(* Removal of unused variables: often a consequence of the substitution *)
(************************************************************************)

Clear[unusedVarQ];
unusedVarQ[varName_String] :=
  unusedVarQ[Alpha`$result, varName];

unusedVarQ[varName_] :=
  unusedVarQ[symToString[varName]];

unusedVarQ[_] := False;

unusedVarQ[Alpha`system[n_, p_, i_, o_, locals_, equas_],
	   varName_String] :=
  Apply[And, Map[(Position[#, 
			   Alpha`var[varName]
			 ] === {})&, 
		 equas]];

unusedVarQ[_, _] := False;


(* remove a supposedly unused variable; checks if it is really the case *)

Clear[removeUnusedVar];
(* Filter varName *)
removeUnusedVar[varName_] := removeUnusedVar[symToString[varName]];

removeUnusedVar[varName_String] :=
  ($program = $result;
   $result = removeUnusedVar[$program, varName]);

(* Filter varName *)
removeUnusedVar[sys_,varName_] := 
       removeUnusedVar[sys,symToString[varName]];

removeUnusedVar[sys:Alpha`system[n_,p_,i_,o_,locals_,equas_],
		varName_String] :=
  If[unusedVarQ[sys, varName],
     Alpha`system[n,p,i,o,
		  DeleteCases[locals, Alpha`decl[varName,_,_]],
		  DeleteCases[equas, Alpha`equation[varName,_]]],
     sys];


(* remove all variables that appear unused with 'unusedVarQ' *)

Clear[removeAllUnusedVars];
removeAllUnusedVars[] :=
  ($program = $result;
   $result = removeAllUnusedVars[$program]);

removeAllUnusedVars[sys:Alpha`system[n_,p_,i_,o_,locals_,equas_]] :=
With[
  {unusedList = 
    Cases[locals,
      Alpha`decl[varName_ /; unusedVarQ[sys, varName],_,_] -> varName]},
    Alpha`system[
      n,p,i,o,
      DeleteCases[locals,
        Alpha`decl[varName_ /; MemberQ[unusedList, varName],_,_]]
    ,
      DeleteCases[equas,
        Alpha`equation[varName_ /; MemberQ[unusedList, varName], _]
      ]
    ]
];

removeAllUnusedVars[ ___ ] := Message[ removeAllUnusedVars::params ];

(****************************************************************************)
(* addlocal                                                                 *)
(*                                                                          *)
(* Create a local variable.                                                 *)
(* Specification is : "var = expression"                                    *)
(*                    |         |                                           *)
(* Variable to be added        the definition of the variable               *)
(*  (must be a local var)      (cannot be recursive)                        *)
(*                             All instances of expression in the program   *)
(*                             are replace by var.                          *)
(*                                                                          *)
(*--------------------------------------------------------------------------*)
(* A program sketch :                                                       *)
(*                                                                          *)
(* A : { i,j | ... } of integer ;                                           *)
(* let                                                                      *)
(*   A   = ... ;    (if A is an output or local only)                       *)
(*   ... = ... A ... ;                                                      *)
(* tel                                                                      *)
(*                                                                          *)
(* Transformed by command:                                                  *)
(*    addlocal["B = A"];                                                    *)
(*                                                                          *)
(* If A is an output or local variable, it becomes...                       *)
(*                                                                          *)
(* A : { i,j | ... } of integer ;                                           *)
(* B : { i,j | ... } of integer ;                                           *)
(* let                                                                      *)
(*   A   = B;                                                               *)
(*   B   =  ... ;                                                           *)
(*   ... = ... B ... ;                                                      *)
(* tel                                                                      *)
(*                                                                          *)
(* If A is an input or a non-trivial expression (not a single variable),    *)
(* it becomes...                                                            *)
(*                                                                          *)
(* let                                                                      *)
(*   B   = A;                                                               *)
(*   ... = ... B ... ;                                                      *)
(* tel                                                                      *)
(****************************************************************************)

Clear[addLocal];
Clear[addlocal];
(* Added to comply with identifier style of MMAlpha *)
addLocal[p___]:= addlocal[p];  

Options[ addLocal ] := { debug -> False, contextDomain -> True };

(* Two definitions for backward compatibility. They are bugged : 
   addlocal["c = {i|i>0} : x"] does not work, because it is parsed
   as an equality (boolean expression) instead of an equation,
   and often the priorities go wrong, so the head of the tree is not
   the Alpha`eq but some operator of the RHS *)
addlocal[spec:_String, opts:___Rule]:=
( 
  $program = $result;
  Check[
    $result = addlocal[ $program, spec, opts],
    $result = $program;Null
  ]
);

addlocal[sys:_system, spec:_String, opts:___Rule ]:=
Catch[
  Module[
    {v,t,e},
    Check[    
      t = readExp[spec,sys[[2]]],(* var = expression *)
      addLocal::error1 = "error while parsing expression"; 
      Throw[ Message[addLocal::error1] ]
    ];
    If[ t[[1]]=!=eq || Head[t[[2]]]=!=var,
      addLocal::error2 = "specification must be an equation";
      Throw[ Message[addLocal::error2] ]
    ];
    v  = Part[t,2,1];      (* new local var name string *)
    e  = Part[t,3];
    If[ debug/.{opts}/.Options[ addLocal ], Print[ v, e ] ];
    addlocal[ sys, v, e, opts]
  ]
];

addlocal[sys:_system, LHS:_String, pos:{_Integer..}, opts:___Rule ] :=
  addlocal[sys, LHS, {pos}, opts];

addlocal::exprNotIdentical="addlocal, the expressions indicated by the
list of positions: `1` are not syntactically identical"

addlocal[sys:_system, LHS:_String, 
  listOfPos: List[(List[___Integer])..], opts:___Rule ] :=
Catch[
  Module[ {d1,d2,d3,d,s1,s2,s3,pos,expr1, dbg},

    dbg = debug/.{opts}/.Options[addLocal];
    (* This option was added to force an expression domain 
       to be used for the declaration *)
    ctx = contextDomain /. {opts} /. Options[addLocal];

    pos = listOfPos[[1]];

    (* initialisation for the decl domain if LHS *)
    If[ ctx, 
      d1 = 
        Check[getContextDomain[sys, pos],
        Message[addlocal::invalidPos]; Throw[sys]
      ];

      If[ dbg, Print[ "Contextual domain of expression is: ", 
             ashow[ d1, silent->True ] ] ]
    ];

    d2 = Check[expDomain[sys,pos],
      Message[addlocal::invalidPos,listOfPos];Throw[sys]];
    If[ dbg, Print[ "Domain of expression is: ", 
             ashow[ d2, silent->True ] ] ];

    (* If the option contexDomain is set (default) one take the
     intersection of the domain and the context domain *)
    If[ ctx, 
      d = Check[
            DomIntersection[d1,d2],
            addlocal::pbDomIntersection = 
              "problem while calling domIntersection";
            Message[addlocal::pbDomIntersection,listOfPos];Throw[sys]
      ],
      d = d2
    ];

    expr1 = Check[getPart[sys,pos],
       Message[addlocal::invalidPos]; Throw[sys]];

    Do[
      pos = listOfPos[[i]];
      expr2 = Check[getPart[sys,pos],
       Message[addlocal::invalidPos]; Throw[sys]];
      If[ expr2=!=expr1,
        Message[addlocal::exprNotIdentical];
	 Throw[sys]
      ];

      (* The comments below have been added by tang 
	for the use construct *)
      If[Length[pos]<3 || pos[[1]]=!=6 (* || pos[[3]]=!=2 *) ,
        Message[addlocal::invalidPos];Throw[sys] 
      ];

      d1 = Check[getContextDomain[sys, pos],
	Message[addlocal::invalidPos]; Throw[sys]];

      d2 = Check[expDomain[sys,pos],
	Message[addlocal::invalidPos,listOfPos]; Throw[sys]];

      If[ dbg, Print["d:",d]; ashow[d]; Print["d1:",d1]; ashow[d1];
        Print["d2:",d2]; ashow[d2] ];

      d3 = DomIntersection[ d1, d2 ];
      If[ dbg,  Print["d3: ",d3]; ashow[d3] ];

      d3 = DomUnion[ d, d3];
      If[ dbg, Print["d3: ",d3]; ashow[d3] ];

      d = Check[ convexize[ d3 ], 
        addlocal::convexize = "error while calling convexize";
	Message[addlocal::convexize]; Throw[sys]
      ];

      If[ DomEmptyQ[d],
	 Message[addlocal::empty]; Throw[sys] ]
    ,
      {i,1,Length[listOfPos]}
    ]; (* End Do loop *)
	   
    s1 = Insert[sys, decl[LHS, expType[sys, pos], d], {5,1}];

    s2 = s1;

    Do[pos=listOfPos[[i]];
      s2 =  ReplacePart[s2, var[LHS], pos]
    ,
      {i,1,Length[listOfPos]}
    ];
	   
    Insert[s2, equation[LHS, expr1], {6,1} ]
  ]
];

addlocal[LHS:_String, RHS_, opts:___Rule] :=
( 
  $program = $result;
  Check[
    $result = addlocal[$program,LHS,RHS,opts],
    $result = $program;
  ];
  $result
)

addlocal[sys:_system, LHS:_String, RHS:_String, opts:___Rule] :=
Catch[
  Module[ {exp},
    Check[
      exp = readExp[ RHS, sys[[2]] ],
      addlocal::errorParse = "could not parse expression";
      Throw[ Message[ addlocal::errorParse ] ]
    ];
    addlocal[sys, LHS, exp, opts]
  ]
];

addlocal[sys:_system, LHS:_String, RHS_, opts:___Rule] :=
Catch[
  Module[{d,pos,s1,s2,s3},
    If[ MemberQ[ getVariables[sys], LHS] , 
      addlocal::var = "Variable already exists";
      Throw[ Message[addlocal::var] ]
    ];

    (* add local to declarations *)
    d = convexize[ expDomain[sys, RHS] ];
    If[ DomEmptyQ[d],
      Throw[ Message[addlocal::empty] ]
    ];

    (* Insert declaration *)
    s1 = Insert[sys, decl[LHS, expType[sys, RHS], d], {5,1}];
    (* search for instances of exp in equations *)
    pos = Position[s1[[6]], RHS];  

    s2 = 
    If[ pos=!={},
      (* Prepend all positions with 6 *)
      ( pos = Map[ Function[x,Prepend[x,6]], pos ];  
       (* position of usages *)
       (* Replace positions by var[LHS] *)
      ReplacePart[s1, var[LHS], pos] ), 
      (* If pos is empty, keep s1 *)
      s1 
    ];

    If[ Head[RHS]===var,
      pos = Position[s2[[6]], equation[RHS[[1]],_],{1}];
      If[ pos=!={},  (* s/b True always for locals and outputs *)
        (pos = Map[Function[x,Prepend[x,6]],pos];
          (* position of usages*)
         pos = Map[Function[x,Append[x,1]],pos];
         s3 = ReplacePart[s2,LHS,pos];
         Insert[s3, equation[RHS[[1]],var[LHS]], {6,1}] ),
         Insert[s2, equation[LHS,RHS], {6,1}] 
      ],
      Insert[s2, equation[LHS,RHS], {6,1}]    
    ]
  ]
];
addlocal::WrongArg="Wrong Argument for addLocal `1`"

addlocal[a___]:= Message[addlocal::WrongArg,a];

(*---------------------------------------------------------------------------*)

(****************************************************************************)
(* addlocalLHS, addlocalRHS                                                 *)
(* added by Tanguy in, 2004 the addlocal function mix two treatment         *)
(* (1) change A=...;X=...A... into B=A;A=...;X=...B... and                  *)
(* (2) change A=...;X=...A... int  A=B;B=...;X=...B...                      *)
(*                                                                          *)
(* the original addlocal perfomed (2) (which is what I call addLocalRHS)    *)
(* and (1) (which is what I call addLocalLHS) for input or "non trivial     *)
(*  expression"                                                             *)
(*  addLocalRHS is currently exactly addlocal                               *)
(* addlocalLHS[var, expression]                                             *)
(* Create a local variable.                                                 *)
(* Specification is : "var = expression"                                    *)
(*                    |         |                                           *)
(* Variable to be added        the definition of the variable               *)
(*  (must be a local var)      (cannot be recursive)                        *)
(*                             All instances of expression in the program   *)
(*                             are replace by var.                          *)
(*                                                                          *)
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
(*    addlocalLHS["B = A"]; or                                              *)
(*    addlocalLHS["B","A"];                                                 *)
(*    addlocalLHS["B",var["A"]];                                            *)
(*                                                                          *)
(*                                                                          *)
(* A : { i,j | ... } of integer ;                                           *)
(* B : { i,j | ... } of integer ;                                           *)
(* let                                                                      *)
(*   B   = A;                                                               *)
(*   A   =  ... ;                                                           *)
(*   ... = ... B ... ;                                                      *)
(* tel                                                                      *)
(*                                                                          *)
(* If A is an an output it remains an output (it is not replaced by B)      *)
(****************************************************************************)
Clear[addLocalRHS];
addLocalRHS[x___]:=addlocal[x];
Clear[addLocalLHS];

Options[ addLocalLHS ] := { debug -> False, contextDomain -> True };

(* Two definitions for backward compatibility. They are bugged : 
   addLocalLHS["c = {i|i>0} : x"] doesn not work, because it is parsed
   as an equality (boolean expression) instead of an equation,
   and often the priorities go wrong, so the head of the tree is not
   the Alpha`eq but some operator of the RHS *)
addLocalLHS[spec:_String, opts:___Rule]:=
( 
  $program = $result;
  Check[
    $result = addLocalLHS[ $program, spec, opts],
    $result = $program;Null
  ]
);

addLocalLHS[sys:_system, spec:_String, opts:___Rule ]:=
Catch[
  Module[
    {v,t,e},
    Check[    
      t = readExp[spec,sys[[2]]],(* var = expression *)
      addlocal::error1 = "error while parsing expression"; 
      Throw[ Message[addlocal::error1] ]
    ];
    If[ t[[1]]=!=eq || Head[t[[2]]]=!=var,
      addlocal::error2 = "specification must be an equation";
      Throw[ Message[addlocal::error2] ]
    ];
    v  = Part[t,2,1];      (* new local var name string *)
    e  = Part[t,3];
    If[ debug/.{opts}/.Options[ addLocalLHS ], Print[ v, e ] ];
    addLocalLHS[ sys, v, e, opts]
  ]
];

addLocalLHS[sys:_system, LHS:_String, pos:{_Integer..}, opts:___Rule ] :=
  addLocalLHS[sys, LHS, {pos}, opts];

addlocal::exprNotIdentical="addLocalLHS, the expressions indicated by the
list of positions: `1` are not syntactically identical"; 

addLocalLHS[sys:_system, LHS:_String, 
  listOfPos: List[(List[___Integer])..], opts:___Rule ] :=
Catch[
  Module[ {d1,d2,d3,d,s1,s2,s3,pos,expr1, dbg},

    dbg = debug/.{opts}/.Options[addLocalLHS];
    (* This option was added to force an expression domain 
       to be used for the declaration *)
    ctx = contextDomain /. {opts} /. Options[addLocalLHS];

    pos = listOfPos[[1]];

    (* initialisation for the decl domain if LHS *)
    If[ ctx, 
      d1 = Check[getContextDomain[sys, pos],
        Message[addlocal::invalidPos]; Throw[sys]];
      If[ dbg, Print[ "Contextual domain of expression is: ", 
             ashow[ d1, silent->True ] ] ]
    ];

    d2 = Check[expDomain[sys,pos],
      Message[addlocal::invalidPos,listOfPos];Throw[sys]];
    If[ dbg, Print[ "Domain of expression is: ", 
             ashow[ d2, silent->True ] ] ];

    (* If the option contexDomain is set (default) one take the
     intersection of the domain and the context domain *)
    If[ ctx, 
      d = Check[
            DomIntersection[d1,d2],
            addlocal::pbDomIntersection = 
              "problem while calling domIntersection";
            Message[addlocal::pbDomIntersection,listOfPos];Throw[sys]
      ],
      d = d2
    ];

    expr1=Check[getPart[sys,pos],
       Message[addlocal::invalidPos]; Throw[sys]];

    Do[
      pos = listOfPos[[i]];
      expr2 = Check[getPart[sys,pos],
       Message[addlocal::invalidPos]; Throw[sys]];
      If[ expr2=!=expr1,
        Message[addlocal::exprNotIdentical];
	 Throw[sys]
      ];


      (* The comments below have been added by tang 
	for the use construct *)
      If[Length[pos]<3 || pos[[1]]=!=6 (* || pos[[3]]=!=2 *) ,
        Message[addlocal::invalidPos];Throw[sys] 
      ];

      d1 = Check[getContextDomain[sys, pos],
	Message[addlocal::invalidPos]; Throw[sys]];

      d2 = Check[expDomain[sys,pos],
	Message[addlocal::invalidPos,listOfPos]; Throw[sys]];

      If[ dbg, Print["d:",d]; ashow[d]; Print["d1:",d1]; ashow[d1];
        Print["d2:",d2]; ashow[d2] ];

      d3 = DomIntersection[ d1, d2 ];
      If[ dbg, 
        Print["d3: ",d3]; ashow[d3];
      ];
      d3 = DomUnion[ d, d3];
      If[ dbg, 
        Print["d3: ",d3]; ashow[d3];
      ];
      d = Check[ convexize[ d3 ],
        addlocal::convexize = "error while calling convexize";
	Message[addlocal::convexize]; Throw[sys]
      ];

      If[ DomEmptyQ[d],
	 Message[addlocal::empty]; Throw[sys] ],
      {i,1,Length[listOfPos]}
    ]; (* End Do loop *)
	   
    s1 = Insert[sys, 
      decl[LHS, expType[sys, pos], d], 
		       {5,1}];
    s2 = s1;

    Do[pos=listOfPos[[i]];
      s2 =  ReplacePart[s2, var[LHS], pos],
      {i,1,Length[listOfPos]}
    ];
	   
    Insert[s2, equation[LHS, expr1], {6,1} ]
  ]
];

addLocalLHS[LHS:_String, RHS_, opts:___Rule] :=
( 
  $program = $result;
  Check[
    $result = addLocalLHS[$program,LHS,RHS,opts],
    $result = $program;
  ];
  $result
)

addLocalLHS[sys:_system, LHS:_String, RHS:_String, opts:___Rule] :=
Catch[
  Module[ {exp},
    Check[
      exp = readExp[ RHS, sys[[2]] ],
      addlocal::errorParse = "could not parse expression";
      Throw[ Message[ addlocal::errorParse ] ]
    ];
    addLocalLHS[sys, LHS, exp, opts]
  ]
];

addLocalLHS[sys:_system, LHS:_String, RHS_, opts:___Rule] :=
Catch[
  Module[{d,pos,s1,s2,s3},
    If[ MemberQ[ getVariables[sys], LHS] , 
      addlocal::var = "Variable already exists";
      Throw[ Message[addlocal::var] ]
    ];

    (* add local to declarations *)
    d = expDomain[sys, RHS];
    If[ DomEmptyQ[d],
      Throw[ Message[addlocal::empty] ]
    ];

    (* Insert declaration *)
    s1 = Insert[sys, decl[LHS, expType[sys, RHS], d], {5,1}];
    (* search for instances of exp in equations *)
    pos = Position[s1[[6]], RHS];  

    s2 = 
    If[ pos=!={},
      (* Prepend all positions with 6 *)
      ( pos = Map[ Function[x,Prepend[x,6]], pos ];  
       (* position of usages *)
       (* Replace positions by var[LHS] *)
      ReplacePart[s1, var[LHS], pos] ), 
      (* If pos is empty, keep s1 *)
      s1 
    ];

    Insert[s2, equation[LHS,RHS], {6,1}] 
    
  ]
];
addlocal::WrongArg="Wrong Argument for addLocalLHS `1`"

addLocalLHS[a___]:= Message[addlocal::WrongArg,a];

(*---------------------------------------------------------------------------*)
(* getNewName is used when manipulating Alpha program, we want to
use a identificator not already used *) 

Clear[getNewName];
getNewName::WrongArg = "Wrong Arguments for
getNewName: `1`"
Options[getNewName]={verbose->True}

getNewName[s1_String,opts:___Rule]:=getNewName[$result,s1,opts];

getNewName[sys_,s1:_String,opts:___Rule]:=
Module[{occurs,verb},
  verb = verbose/.{opts}/.Options[getNewName];
   occurs = Cases[sys,s1,Infinity];
   If[ Length[occurs]>1,
     res = getNewName[ sys,s1<>StringTake[ s1, -1 ] ],
     res = s1
   ];
   res
];

getNewName[a___]:= 
  (Message[getNewName::WrongArg,a];Throw["ERROR"])


End[]
EndPackage[]
