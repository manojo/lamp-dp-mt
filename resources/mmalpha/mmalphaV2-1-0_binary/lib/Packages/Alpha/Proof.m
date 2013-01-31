(* 
   file: $MMALPHA/lib/Package/Proof.m
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
BeginPackage["Alpha`Proof`", 
  {"Alpha`Domlib`",
   "Alpha`",
   "Alpha`Options`",
   "Alpha`Matrix`",
   "Alpha`Tables`",
   "Alpha`Static`",
   "Alpha`Normalization`",
   "Alpha`VertexSchedule`",
   "Alpha`ScheduleTools`",
   "Alpha`SubSystems`",
   "Alpha`Substitution`",
   "Alpha`Semantics`"
}];

(*  
    $Id: Proof.m,v 1.2 2010/04/14 18:00:15 quinton Exp $
*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2010/04/14 18:00:15 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Proof.m,v $
	$Revision: 1.2 $
	$Log: Proof.m,v $
	Revision 1.2  2010/04/14 18:00:15  quinton
	Minor modifications.
	
	Revision 1.1  2009/05/22 10:24:36  quinton
	May 2009
	
*)

Proof::note = 
"Documentation revised on August 8, 2004";

Proof::usage =     
"Alpha`Proof` is the package which contains the 
functions for proving Alpha properties."; 

Options[ evaluateDef ] = { numberOfSubstitutions -> 100 };
evaluateDef::usage = 
"evaluateDef[sys, v] evaluates variable v by substitution, until either the
maximum number of iterations is reached, or v does depend only on constants
or inputs.";

Options[ induction ] = { numberOfSubstitutions -> 100 };
induction::usage = 
"induction[sys, p, i] tries to prove property described by variable
p by induction on index i.";

(* "  *)
inputQ::usage = 
"inputQ[ v ] is True if v is an input";

(* *)
decreasingIndexQ::usage = 
"decreasingIndexQ[ m, p ] is True if values of parameter p in m 
 is decreasing.";

Begin["`Private`"]

(* " *)
Clear[ induction ];
induction[ p:_String, ind:_String ] :=
  (induction[ $result, p, ind ]);
induction[ sys:_system, p:_String, ind:_String, opts:___Rule ] :=
Catch[
  Module[ { iter, dbg, sched, params, depDom, vv, ss, pg, rr, lib, equat, 
    maxIter },

    maxIter = numberOfSubstitutions/.{opts}/.Options[ evaluateDef ];    
    (* *)
    lib = $library;
    rr = $result; 

    (* *)
    inlineAll[]; normalize[]; ashow[];
    putSystem[];

    (* Force debug *)
    dbg = True;

    Check[ 
      sched = scd[],
      induction::noSched = 
      "This system has no schedule and an induction cannot be found.";
      Throw[ Message[ induction::noSched ] ];
    ];

    sched = getSchedule[ p ];
    Print[ sched ];

    params = getSystemParameters[];
    Print[ params ];

    If[ !MemberQ[ params, ind ], 
	induction::notParam = "ind is not a parameter";
        Throw[ Message[ induction::notParam ] ]
    ];

    depDom = getSystemParameterDomain[];
    depDom = DomProject[ depDom, { ind } ];
    If[ dbg, ashow[ depDom ] ];

    vv = vertices[ depDom ];
    Print[ vv ];
    If[ vv === {}, 
      induction::notVertices = "parameter domain is not bounded";
      Throw[ Message[ induction::notVertices ] ]
    ];

    vv = First[ vv ];
    If[ !MatchQ[ vv, {_Integer} ],
      induction::vertexNotInteger = "vertex is not an integer";
      Throw[ Message[ induction::vertexNotInteger ] ]
    ];
    
    vv = First[ vv ];
  
    fixParameter[ ind, vv ];
    ashow[ ];

    (* Evaluate predicate *)
    evaluateDef[ p ];

    equat = getEquation[ p ];

    ashow[ equat[[2,2]] ];
    ashow[ equat[[2,3]] ];

    If[ equat[[2,2]] === equat[[2,3]], Print[ "Base case proven..." ]
	];

    dbg = False;

    (* Start again from fresh library *)
    $library = lib;
    $result = rr;

    For[
      iter = 0;
      (* Get the dependence table, and keep only dependencies on p *)
      dt = dep[];
      dt = 
      Cases[ 
        dt, 
        depend[ _, p, x:_String/;!inputQ[x],
          m:_matrix/;!decreasingIndexQ[ m, ind, params ],__ ], 2 
      ];
      Print[ Length[ dt ] ]; Print[ iter, maxIter ];
      ashow[dtable[dt]],
      iter <= maxIter && Length[ dt ] > 0,
      iter++,
      If[ True, Print[" --- Iteration number: " iter ] ];
      sv = dt[[1,3]];
      If[ dbg, Print[" -- Variable to be substituted: ",  sv ] ];
      substituteInDef[ p, sv ]; normalize[]; 

      If[ dbg, ashow[] ]; 
      dt = dep[];
      dt = 
      Cases[ 
        dt, 
        depend[ _, p, x:_String/;!inputQ[x],
          m:_matrix/;!decreasingIndexQ[ m, ind, params ],__ ], 2 
      ];
      If[ dbg, ashow[dtable[dt] ] ]
    ];

    Return[];

  ]
];
induction[ ___ ] := Message[ induction::params ];

(* This predicate is True if *)
Clear[ decreasingIndexQ ];
decreasingIndexQ[ m:_matrix, p:_String, params:_ ] := 
Module[ {mmaM, lgp, exp, cmp},
  (* Get the mma matrix in m *)
  mmaM = m[[4]];
  (*  Print[ mmaM ]; *)
  (* Evaluate matrix on indexes (1 added to cope with homogeneous coordinates *)
  exp = mmaM.Append[ m[[3]], 1 ];
  (* Evaluate comparison *)
  cmp = Map[ Simplify[ #<p, p>0 ]&, exp ];

  lgp = Length[ params ];
  (* Drop the last value, because homogeneous coordinates, and
    drop also parameter part *)
  cmp = Drop[ cmp, -lgp-1 ];
  MemberQ[ cmp, True ]
];
decreasingIndexQ[___] := Message[ decreasingIndexQ::params ];

(* This predicate is True if v is an input of the system in $result *)
Clear[ inputQ ];
inputQ[ v:_String ] :=
  (MemberQ[ getInputVars[], v ]);
inputQ[___] := Message[ inputQ::params ];

(* 
  This function evaluates a definition until all its dependencies
  are either inputs or constants. There is a maximum number of iterations.
*)  
Clear[ evaluateDef ];
evaluateDef[ v:_String, opts:___Rule ] :=
Catch[
  Module[ {dt, iter, sv, ss, dbg, maxIter},
    maxIter = numberOfSubstitutions/.{opts}/.Options[ evaluateDef ];
    (* Force debug *)
    dbg = False;
    For[
      iter = 0;

      (* Get the dependence table, and keep only dependencies on p *)
      dt = dep[];
      dt = Cases[ dt, depend[ _, v, x:_String/;!inputQ[x],__ ], 2 ];
      ashow[dtable[dt]],
      iter <= maxIter && Length[ dt ] > 0,
      iter++,
      If[ True, Print[" --- Iteration number: " iter ] ];
      sv = dt[[1,3]];
      If[ dbg, Print[" -- Variable to be substituted: ",  sv ] ];
      substituteInDef[ v, sv ]; normalize[]; 

      If[ dbg, ashow[] ]; 
      dt = dep[];
      dt = Cases[ dt, depend[ _, v, x:_String/;!inputQ[x],__ ], 2 ];
      If[ dbg, ashow[dtable[dt] ] ]
    ];
    Print["Value of iter: ", iter ];
    ashow[];
  ]
];
evaluateDef[___] := Message[ evaluate::params ];

End[];
EndPackage[];
