(* file: $MMALPHA/lib/Package/Synthesis.m
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
  "Alpha`Allocate`",
  {"Alpha`",
   "Alpha`Domlib`",
   "Alpha`Tables`",
   "Alpha`Matrix`",
   "Alpha`Options`", 
   "Alpha`Normalization`", 
   "Alpha`Properties`", 
   "Alpha`Static`", 
   "Alpha`Substitution`",
   "Alpha`SubSystems`",
   "Alpha`Semantics`", 
   "Alpha`Schedule`", 
   "Alpha`ScheduleTools`", 
   "Alpha`Pipeline`", 
   "Alpha`PipeControl`", 
   "Alpha`ToAlpha0v2`", 
   "Alpha`Alphard`", 
   "Alpha`Vhdl2`",
   "Alpha`VertexSchedule`"}];

(* Standard head for CVS

	$Author: 
	$Date: 
	$Source: 
	$Revision: 
	$Log:
	
*)

Allocate::note = "Documentation not yet revised.";

Allocate::usage = 
"The Alpha`Allocate` package contains functions to allocate a design.";

allocTable::usage = 
"allocTable[ sys, opts ] produces an allocation table for a system sys.";

Options[ allocTable ] = { debug -> False, verbose -> False }

$allocTable::usage = 
 "$allocTable contains the allocation table for all systems.$"

showAT::usage = "showAT[ dt ] displays the content of the allocation table";

(* ===================== Private definitions ===================== *)

Begin["`Private`"]
 
Clear[allocTable];
allocTable[ opts:___Rule ] := allocTable[ $result ];

allocTable[ sys:_system, opts:___Rule ] :=
Catch[ 
  Module[ { vrb, dbg, sn, pind, tind},

  (* Get options *)
  vrb = verbose/.{opts}/.Options[ allocTable ];
  dbg = debug/.{opts}/.Options[ allocTable ];

  (* ----- Modify getSystemName to cover case of system *)
  sn = getSystemName[ ]; 

  If[ ! StringMatchQ[ sn, "cell*Module*"], 
    allocTable::wrongSystem = "System name should have the form cell*Module*";
    Message[ allocTable::wrongSystem ]; Throw[ {} ] 
  ];

  $allocTable = Map[ allocTable[ #, opts]&,  $result[[6]] ];

  pind = getSystemParameters[];

  (* Assuming one local var at least *)
  tind = getDeclarationDomain[ First[ getLocalVars[] ] ][[2]];
  tind = Select[ tind, !MatchQ[#,"p1"|"p2"]& ];

  (* Add informations to allocTable *)
  $allocTable = 
    { sn, getSystemParameterDomain[],
      getInputVars[], getOutputVars[],
      Map[ Prepend[ 
             #, 
           DomProject[ getDeclarationDomain[ First[ # ] ], tind ] ]&, 
           $allocTable 
      ]
    }

  ]
];

(* allocTable, applied to a single equation *)
(* Simple connexion *)
allocTable[ 
  equation[lhs:_String, var[rhs:_String] ]
, 
  opts:___Rule ] :=
Catch[
  Module[ { vrb, dbg },

  {lhs, "connexion", rhs}

  ]
];

(* Connection, with an identity matrix *)
allocTable[ 
  equation[lhs:_String, affine[ var[rhs:_String],m:_matrix/;identityQ[m]] ]
  , opts:___Rule ] :=
Catch[
  Module[ { vrb, dbg },

  {lhs, "connexion", rhs}

  ]
];

(* A register *)
allocTable[ 
  equation[lhs:_String, affine[ var[rhs:_String],m:_matrix/;translationQ[m]] ]
  , opts:___Rule ] :=
Catch[
  Module[ { vrb, dbg, tv, nreg },

  (* Read the translation vector associated to the matrix m *)
  tv = getTranslationVector[ m ];

  (* Get the number of registers *)
  nreg = - First[ getTranslationVector[ m ] ];  

  (* Check that all other values are 0 *)
  tv = Drop[ tv, 1 ];
  If[ tv =!= Table[ 0, {i,1,Length[ tv ]} ],
    allocTable::wrongRegister = "Wrong translation vector";
    Message[ allocTable::wrongRegister ]; Throw[ {} ] 
  ];

  {lhs, "register", rhs, nreg }
  ]
];

(* A binary operator *)
allocTable[ 
  equation[
    lhs:_String, 
    binop[ bop:_, 
      var[arg1:_String] | affine[ var [arg1:_String], m1:_matrix/;identityQ[m1] ],
      var[arg2:_String] | affine[ var [arg2:_String], m2:_matrix/;identityQ[m2] ]
    ] 
  ]
, 
  opts:___Rule ] :=
Catch[
  Module[ { vrb, dbg, tv, nreg },

  {lhs, "binop", arg1, bop, arg2}

  ]
];

(* A multiplexer *)
allocTable[ 
  equation[
    lhs:_String, 
    case[{ 
	restrict[
          d1:_domain, 
          if[ 
            var[ctrl1:_] | affine[ var[ctrl1:_], m0:_matrix/;identityQ[m0] ], 
            var[val1:_] | affine[ var[val1:_], m1:_matrix/;identityQ[m1] ] |
            const[val1:_] | affine[ const[val1:_], m1:_matrix ],
            var[val2:_] | affine[ var[val2:_], m1:_matrix/;identityQ[m2] ] |
            const[val2:_] | affine[ const[val2:_], m2:_matrix ]
          ]
        ]
      ,
	restrict[
          d2:_domain, 
          if[ 
            var[ctrl1:_] | affine[ var[ctrl1:_], m3:_matrix/;identityQ[m3] ], 
            var[val3:_] | affine[ var[val3:_], m4:_matrix/;identityQ[m4] ] |
            const[val3:_] | affine[ const[val3:_], m4:_matrix ],
            var[val4:_] | affine[ var[val4:_], m5:_matrix/;identityQ[m5] ] |
            const[val4:_] | affine[ const[val4:_], m4:_matrix ]
          ]
        ]
	  }]
  ]
, 
  opts:___Rule ] :=
Catch[
  Module[ { vrb, dbg, tv, nreg },

  {lhs, "mux", ctrl1, val1, val4}

  ]
];

(* A nothing *)
allocTable[ 
  equation[ lhs:_String, __]
, 
  opts:___Rule ] := {lhs, "nothing"}
allocTable::params = "wrong parameters";
allocTable[___] := Message[allocTable::params];

(* Show the dependence table *)
Clear[ showAT ];
showAT[] := showAT[ $allocTable ];
showAT[ {sy:_String, d:_domain, i:_, o:_, u:{___}} ]:=
  (
  Print[ "Allocation table for system: ", sy];
  Print[ "   on processors: ", show[ d, silent->True ] ];
  Print[ "  Inputs: ", i ];
  Print[ "  Outputs: ", o ];
  Map[ showAT, u ];
   );
showAT[ {d:_domain, v:___ } ]:=
  (
   Print[ "      at time instants: ", show[ d, silent->True ], 
    {v}]
   );
allocTable::params = "wrong parameters";
allocTable[___] := Message[allocTable::params];

End[];
EndPackage[]

