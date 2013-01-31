(* file: $MMALPHA/lib/Package/Alpha/CodeGen/Loops.m
   AUTHOR : Fabien Quilleré
   CONTACT : http://www.irisa.fr/cosi/ALPHA
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


        $Author: trisset $
        $Date: 2005/04/12 13:01:03 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/CodeGen/Loops.m,v $
        $Revision: 1.2 $
        $Log: Loops.m,v $
        Revision 1.2  2005/04/12 13:01:03  trisset
        resolved conflict

        Revision 1.1  2005/03/11 16:41:33  trisset
        added codeGen to V2

        Revision 1.12  2004/06/09 15:58:21  quinton
        Minor modifications.

        Revision 1.11  2002/09/10 15:13:33  quinton
        Minor corrections.

        Revision 1.10  2002/09/04 16:46:05  quinton
        Correction of bug in CodeGen.

        Revision 1.9  2002/08/28 11:30:11  risset
        corrected a little bug Loops.m

        Revision 1.8  2002/06/06 15:26:01  risset
        small changes

        Revision 1.7  2002/03/01 10:40:18  risset
        improved the stimuli options, corrected ludovic s bug

        Revision 1.6  2002/01/18 14:04:57  risset
        corrected a bug in INorm and rewrite in imperative form fabien functionnal code.... (no comment)

        Revision 1.5  2002/01/17 10:29:50  risset
        modify the Pipeline.m package for pipall with boundary

        Revision 1.4  1999/05/28 14:53:24  quillere
        added CVS header and GNU info

*)

BeginPackage["Alpha`CodeGen`Loops`"];

Unprotect[mkLoop];
mkUpperBound::wrongArg = "`1`";

mkLoop::usage = 
"mkLoop[d, lev, pdim, pval:{___Rule}, code:_] generates a c loop for
domain d, starting at level lev, with parameter dimension pdim, and
pval being a list of rules which instanciate parameters (some of them,
or even none is pval is the empty list); code is the AST to be
included in the nest (actually it may be anything, it is
includedverbatim).";

Begin["`Private`"];

Needs["Alpha`"];
Needs["Alpha`Domlib`"];
Needs["Alpha`CodeGen`Output`"];

(* === *)

(*
  mkLoop: creates a domain scanner.

  Output is an AST of C-code, it can be printed by either printC
  (printing on screen) or writeCcode (printing in a file).
  Both of these output functions are located in in
  Alpha`CodeGen`Output`.
  
  Example of generated code:

  Mathematica command line:
    mkLoop[readDom["{i,j,N|1<=i<=N;j=2i}"], 1, 1, {}, "code"]

  Result:
    vseq[
      block[
        hseq["for (",
	     hseq["i", " = ", 1], "; ",
	     hseq["i", " <= ", "N"], "; ",
	     "++","i",")"],
	vseq[
	  vseq[
	    hseq["j", " = ", Times[2, "i"], ";"], 
	    "code"]]]
    ]

  Printed by printC:  
    for (i = 1; i <= N; ++i)
    {
      j = 2*i;
      code
    }

*)  

Clear[mkLoop];

mkLoop::wrongArg = "`1`";

mkLoop::param = "param dim (`3`) + level (`2`) is greater than domain dim (`1`).";
mkLoop::noBounds = "no lower or upper bound for polyhedron";

mkLoop[
 d:_domain,
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 code:_,
 opts:___Rule] :=

Module[{dom, body, dbg},

  dbg = False; 
  If[ dbg, Print["Form 1"] ];
  If[DomEmptyQ[d],
    deadCode,

    (* We need to eliminate the INDICES (not the parameters)
      which are after level+1 *)
    dom = (* project out dimensions greater than lev *)
    Module[{dim, mat},
      dim = d[[1]];
      If[lev+pdim>dim,
        Message[mkLoop::param, dim, lev, pdim];
	Throw[$Failed]
      ];

      (* Build the identity matrix max with rows deleted *)
      mat = matrix[pdim+lev+1, dim+1, d[[2]],
              Drop[IdentityMatrix[dim+1], {lev+1, -pdim-2}]];
      (* Take the image by the matrix, and select the good 
        indices names *)
      ReplacePart[DomImage[d, mat], Drop[d[[2]], {lev+1, -pdim-1}], 2] 
    ];

    (* Try to join adjacent polyhedra *)
    If[Length[dom[[3]]]>1,
      mkLoop::domains = 
        "domain is a union of `1` polyhedra. Don't know how to generate code for this.";
      Message[mkLoop::domains, Length[dom[[3]]]];
      Throw[$Failed]
    ];

    (* Recurse to levels *)
    body = If[lev+pdim<d[[1]], 
              mkLoop[d, lev+1, pdim, pval, code, opts],
	      code
    ];

    (* If deadCode found at this level, return it *)
    If[ body === deadCode, 
      deadCode,
      (* Otherwise, recurse *)
      mkLoop[dom[[3,1]], lev, pdim, symbol/@dom[[2]],
      Function[{x},
        Rule[symbol[x[[1]]],x[[2]]]]/@pval, body, opts]
    ]
  ]
];

mkLoop[
 p:_pol,
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule},
 code:_,
 opts:___Rule] :=

Module[{eq,dbg},
  (* Select in the inequalities of the domain, those ones which
     have a non numerical coefficient on indice number level *)
  dbg = debug/.{opts}/.{debug->False};

  If[ dbg, Print["Form 2"] ];
  eq = Select[Cases[p[[5]],{0, __}], Not[#[[lev+1]]==0]&];

  If[Length[eq]>0,

    (* If there are such equalities we only take the last one *)
    mkEqTest[Last[eq], lev, pdim, idx, pval, code],

    (* Otherwise, select ineq >= ind(Level) and ineq <=  ind(Level) *)
    Module[{ineq, lb, ub},
      ineq = Cases[p[[5]],{1, __}];

      lb = Select[ineq, Greater[#[[lev+1]],0]&];

      ub = Select[ineq, Less[#[[lev+1]],0]&];

      If[lb=={},
        Message[mkLoop::noBounds]; Throw[$Failed]
      ];

      (* Previously this...
      If[lb=={} || ub=={},
        Message[mkLoop::noBounds]; Throw[$Failed]
      ];
       *)

      lowerBound = mkLowerBound[lb, lev, pdim, idx, pval];
      If[ dbg, Print[ lowerBound ] ];
      lowerBoundValue = lowerBound[[3]];
      (* This was modified *)
      If[ ub =!= {}, 
        upperBound = mkUpperBound[ub, lev, pdim, idx, pval];
        upperBoundValue = lowerBound[[3]];
        If[ dbg, Print[ upperBound ] ],
        upperBound = +Infinity;
      ];

      If[IntegerQ[upperBoundValue] && 
        IntegerQ[lowerBoundValue] &&
        (upperBoundValue <= lowerBoundValue),
        If[upperBoundValue < lowerBoundValue, 
          res = deadCode,
          (* else if upperBoundValue = lowerBoundValue *)
          If[upperBoundValue == lowerBoundValue, 
            res=block[hseq[lowerBound,";"],code],
            (* Should not happen. FIXIT *)
            Print["PROBLEM", Throw["ERROR"]]
          ]
        ],
       (* else, bound are not integers *)

       If[ dbg, Print["--------- lb :"]; printC[lowerBoundValue] ];
       If[ dbg, Print["--------- ub :"]; printC[upperBoundValue] ];
       res = 
       block[
         If[ upperBound=!=Infinity,
           hseq[
             "for (", lowerBound, 
             "; ", upperBound,
             "; ", "++", idx[[lev]], ")"
           ],
           hseq[
             "for (", lowerBound, 
             "; ", "++", idx[[lev]], ")"
           ]
         ],
         code
       ]
     ];
      If[ dbg, Print["Fini form 2"] ];
      res
    ]
  ]
];

mkLoop[a___] :=
Module[{},
  Message[mkLoop::wrongArg, {a}];
  Throw[$Failed]
];

(* === *)

Unprotect[mkEqTest];
Clear[mkEqTest];

 mkEqTest::wrongArg = "`1`";
 mkEqTest::zero = "coef should not be zero !";

mkEqTest[
 eq:{__Integer},
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule},
 code:_] :=
Module[ {indiceVect, den, val, num},

  indiceVect = Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;
  num = (eq.indiceVect);

  (* FIXIT.. I do not know who added this statement... Maybe
  myself! Patrice *)
  (*
  If[num === 0, Message[mkEqTest::zero];Throw[$Failed] ];
   *)

  den = -eq[[lev+1]];
  mod1 = Mod[num,den];

  If[ NumberQ[mod1],

    If[mod1==0, 
      vseq[hseq[idx[[lev]], " = ", num/den, ";"], code],
      deadCode (* the only possible value is not integral *)
    ],

    If[ Abs[den]==1,
      vseq[hseq[idx[[lev]], " = ", num/den, ";"], code],
      block[
        hseq["if (", "((", num, ")%", den, ") == 0)"],
        vseq[hseq[idx[[lev]], " = (", num, ")/", den, ";"], code]
      ]
    ]
  ]
];

mkEqTest[a___] :=
Module[{},
  Message[mkEqTest::wrongArg, {a}];
  Throw[$Failed]
];

Protect[mkEqTest];

(* === *)

Unprotect[mkLowerBound];
Clear[mkLowerBound];

mkLowerBound::wrongArg = "`1`";

(*  re-written in a readable way *)
 (* bound is a list of list. Each list is wrtten in Polylib format
  {eqOrIneq,firstIndiceCoed,...,ConstantCoef} (???), 
   lev is the level of the indice we look for bounfd (?)
   idx is the indice list in the form symbol[ind1] *)

mkLowerBound[
 bounds:{__List},
 lev:_Integer?NonNegative, 
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule}] :=

Module[{tmp,indiceVect,curBound,den,val,num,tmp1,dbg},
  indiceVect=Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;

  dbg = False; (* Could be changed, if needed, but an option 
    would be better... FIXIT *)

  (* Don't know if this is correct... Previously that was {} *)
  tmp = {};

  Do[curBound = bounds[[i]];
    den = -(curBound.indiceVect);
    num = curBound[[lev+1]];
    val = den/num;
    tmp1 = 
      If[IntegerQ[val],
        hseq[val],
        If[NumberQ[val],
          Ceiling[val],
          If[Abs[num]==1,
            hseq[den/num],
            hseq["rceil((", den, "),(", num, "))"]
          ]
        ]
      ];

    If[ dbg, Print[ FullForm[tmp], FullForm[tmp1] ] ];
    tmp = Append[tmp, tmp1];

    ,{i,1,Length[bounds]}
  ];
  If[ dbg, 
    Print["lb ::::::: "];
    Print["Full form: ", FullForm[ tmp ] ];
    Print["printC: "];Map[ printC, tmp ]
  ];
  hseq[ idx[[lev]], " = ", Apply[ Max,tmp ]]
];

mkLowerBound[a___] :=
Module[{},
  Message[mkLowerBound::wrongArg, {a}];
  Throw[$Failed]
];

Protect[mkLowerBound];

(* === *)

Unprotect[mkUpperBound];
Clear[mkUpperBound];

mkUpperBound::wrongArg = "`1`";

mkUpperBound[
 bounds:{__List},
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule}] :=

Module[{tmp, v},
  indiceVect=Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;
  tmp={};
  Do[ curBound=bounds[[i]];
    den = -(curBound.indiceVect);
    num = curBound[[lev+1]];
    val = den/num;
    tmp = 
      Append[tmp,
        If[IntegerQ[val],
          val,
          If[NumberQ[val],
            Floor[val],
              If[Abs[num]==1,
                den/num,
                hseq["rfloor((", -den, "),(", -num, "))"]
              ]
          ]
        ]
      ]
    ,{i,1,Length[bounds]}
  ];

  hseq[idx[[lev]], " <= ", Apply[Min,tmp]]
];

mkUpperBound_old[
 bounds:{__List},
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule}] :=
  Module[{tmp, v},
	 v = Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;
	 tmp = Map[
	   Function[{x},
		    With[{den = -(x.v), num = x[[lev+1]]},
			 With[{val = den/num},
			      If[IntegerQ[val],
				 val,
				 If[NumberQ[val],
				    Floor[val],
				    If[Abs[num]==1,
				       den/num,
				       hseq["rfloor((", -den, "),(", -num, "))"]
				     ]
				  ]
			       ]
			    ]
		       ]
		  ],
	   bounds];
	 hseq[idx[[lev]],
	      " <= ",
	      Min@@tmp]
	 ];

mkUpperBound[a___] :=
  Module[{},
	 Message[mkUpperBound::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[mkUpperBound];

End[];

Protect[mkLoop];

EndPackage[];



