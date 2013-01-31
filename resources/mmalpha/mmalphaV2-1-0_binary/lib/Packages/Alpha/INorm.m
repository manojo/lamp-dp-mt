(* file: $MMALPHA/lib/Package/Alpha/INorm.m
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


        $Author: quinton $
        $Date: 2009/05/22 10:24:36 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/INorm.m,v $
        $Revision: 1.2 $
        $Log: INorm.m,v $
        Revision 1.2  2009/05/22 10:24:36  quinton
        May 2009

        Revision 1.1  2005/03/11 16:40:17  trisset
        added all remaining packages to V2

        Revision 1.6  2002/10/21 08:24:01  quinton
        A few modifications to correct some bugs in codeGen, when dealing
        with multidimensional time.

        Revision 1.5  2002/01/18 14:05:25  risset
        corrected a bug in INorm.m

        Revision 1.4  2002/01/17 10:29:47  risset
        modify the Pipeline.m package for pipall with boundary

        Revision 1.3  1999/05/14 10:42:29  quillere
        Correction of R-normalization (in rneq). There was a serious bug: the
        context of an equation was just the intersection of the lhs variable
        domain and the restrictions.  Now intersects this with the domain of
        rhs.

        Revision 1.2  1999/05/10 14:56:21  alpha
         changed things for docs

        Revision 1.1  1999/05/06 14:15:49  quillere
        Added INorm.m to the shared MMALPHA archive.  Removed advanced options.
        This version knows only about complete time separation.

        Revision 2.3  1999/05/06 13:59:29  quillere
        First version for shared MMALPHA

        Revision 2.2  1999/05/04 11:43:42  quillere
        Added CVS head

 
*)
 
BeginPackage["Alpha`INorm`"];

Unprotect[iNorm, rnf];

 iNorm::usage = "iNorm[s:_system, k:_Integer, options] computes the
 imperative form of system s. k is the dimension of time. As usual,
 iNorm[k, options] means $result = iNorm[$result, k, options]. See
 Options[iNorm] for options.";

 rnf::usage = "rnf[s:_system] returns the R normal form of s.";

Begin["`Private`"];

Needs["Fail`"];
Needs["Alpha`"];
Needs["Alpha`Domlib`"];
Needs["Alpha`Options`"];
Needs["Alpha`Tables`"];
Needs["Alpha`Normalization`"];
Needs["Alpha`Semantics`"];

(* === *)

 INorm::wrongArg = "`1`";

(* === *)

 iNorm::wrongArg = INorm::wrongArg;
 iNorm::failed = "";
 iNorm::option = "Unexpected option : `1`.";

Options[iNorm] = {verbose->False,
		   debug->False};
Clear[iNorm];

iNorm[
  k:_Integer?Positive,
  options:___Rule] :=
  Catch[
    With[{s = chkFail[iNorm[$result, k, options]]},
	 $program = $result;
	 $result = s
	 ]
    ];


iNorm[
  s:_system,
  k:_Integer?Positive,
  options:___Rule] := 
verbFail[iNorm::failed,
  Catch[
    With[
      {pdim=s[[2,1]],
       locvars = getLocalVars[s], (* list of local variables *)
       outvars = getOutputVars[s]}, (* list of output variables *)

      Module[{rs,  (* r-normal form of the system *)
        stats, (* set of equations defining local variables *)
        outstats, (* set of equations defining output variables *)
        optVerbose,optDebug},

        (* test for unkown options *)
        With[
          {unkown =
           Complement[First/@{options},
           First/@Options[iNorm]]},

           Scan[Message[iNorm::option, #]&, unkown]
        ];

        (* parse options *)
        optVerbose = verbose /. {options} /. Options[iNorm];
        optDebug = debug /. {options} /. Options[iNorm];

        (* debug is not used *)
        (* other options will be used by sepLoops *)

        If[optVerbose, Print["rNormalizing..."]];

        rs = chkFail@rnf[s,options];

	(*
        If[optDebug,
          Print["R-Normal form: \n"];
          show[rs]
        ];
	 *)

        (* separate local and output statements *)
        (* set of equations defining local variables *)
        stats = Select[rs[[6]], MemberQ[locvars, #[[2,1]]]&];

        (* set of equations defining output variables *)
        outstats = Select[rs[[6]], MemberQ[outvars, #[[2,1]]]&];

        If[optVerbose, Print["iNormalizing..."]];

        (* This is the core : time-separation of local statments *)
        Check[
          stats = 
            sepLoops[stats, 1, k, pdim, rs[[2]], options],
          iNorm::errsepLoops = "error while calling sepLoop";        
          Throw[ Message[ iNorm::errsepLoops ] ]
        ];

        If[optDebug, Print["setLoops done ..."]];

        (* first level loops may be controled by parameter
           constraints. Take them out: loop[dom, body] goes
           restrict[pdom, loop[simplifiedDom, body]] *)

        newStats=let[];

        Do[
          l=stats[[i]];
          newL = 
          Module[ {p,e,nd,a},
            (* p is the projection of dom on parameter space *)
            p = chkFail@DomProject[l[[1]], s[[2,2]]];

            (* e is the extension of p to the space
               of dom i.e. e is dom with only
               parameter constraints *)
            e = chkFail@DomExtend[p, l[[1,2]]];

            (* nd is dom simplified in the context of  p *)
            nd = chkFail@DomSimplify[l[[1]], e];
            p = DomSimplify[p, s[[2]]];
            If[chkFail@DomUniverseQ[p],
              loop[nd, l[[2]]],
              restrict[p, loop[nd, l[[2]]]]
            ]
          ];

          newStats=Append[newStats,newL];
			     
          ,{i,1,Length[stats]}
        ];

        stats = newStats;
	(*
        If[optDebug,
          Print["After parameter simplification: \n"];
          show[stats]
        ];
	 *)
		     
        (* join local and output statments and put them in the
           R-normal system; no other changes *)
        ReplacePart[rs, Join[stats, outstats], 6]
      ]
    ]
  ]
];

iNorm[a___] :=
  Module[{}, Message[iNorm::wrongArg, {a}];$Failed];

(* === *)

Unprotect[sepLoops];

Clear[sepLoops];
sepLoops::wrongArg = INorm::wrongArg;
sepLoops[
  lr:let[___loop],   (* statements *)
  lev:_Integer?Positive,   (* current level *) 
  k:_Integer?Positive,     (* time level  *)
  pdim:_Integer?NonNegative, (* parameter dimension *)
  ctx:_domain,             (* current context *) 
  options:___Rule] :=
Module[{tmp, optDebug, optCompact = False,res},
  (* get options *)
  optDebug = debug /. {options} /. Options[iNorm];
  If[optDebug,
    Print["======================================"];
    Print["level ", lev]
  ];

  If[Length[lr] == 0,
    res = lr,
    If[lev <= k,
      (* separate time loops *)
      Module[{},
		 
        (* first, each loop is isolated in a particular let 
           where it is controled by the projection of its domaine on 
           the lev first indices *)

        Check[ 
          tmp =
            Map[loop[projection[#[[1]], lev, pdim, False], let[#]]&,
	       lr]
        ,
          setLoops::err = "error while projecting loop...";
          Throw[ Message[ setLoops::err ] ]
	];

	     (*        If[ optDebug, Print["tmp: ", ashow[ tmp, silent -> True ] ] ]; 
		 
        If[optDebug,
          Print["Context is : ", ashow[ctx, silent -> True ] ];
          Print["*** Add control domains:"];
          Print["Program saved in TMP_Control.alpha"];
          save[tmp,"TMP_CONTROL.alpha"];
        ];

        If[ optDebug, Print["tmp: ", ashow[ tmp, silent -> True ] ] ];
	      *)
		 
        If[optDebug, Print["*** Separate and sort"] ];
        tmp = (* separate and sort *)
          sepLoopsLevel[tmp, lev, pdim, options];
        If[optDebug, Print["*** Separate and sort done ..."] ];

        If[ optDebug, Print["tmp: ", tmp ] ];
		 
        If[optDebug, Print["*** Apply new restrictions to equations domains"] ];
        Check[
          (* apply new restrictions to equations domains *)
          tmp = 
            Map[ 
              Function[{r}, loop[r[[1]], reportRestrict@@r] ],
              tmp
            ]
        ,
          iNorm::errloop = "error while calling loop";
          Throw[ Message[ iNorm::errloop ] ];
        ];
        If[optDebug, Print["*** Apply new restrictions to equations domains: done..."] ];
		 
        Global`$$xxx = tmp;

        (*
        If[optDebug,
          Print["*** Apply restrictions:"];
          Print["File saved in TMP_RESTR.alpha"];
          save[tmp,"TMP_RESTR.alpha"];
        ];
	 *)


        (* Recursive call: apply this to all list of loops *)
        Do[
          If[ optDebug, Print["iteration ", i ] ];
          lp = tmp[[i]];
          If[ optDebug, Print["lp =  ", lp ] ];

          Check[ 
            newctx = DomIntersection[lp[[1]],DomExtend[ctx, lp[[1,2]]]]
          ,
            iNorm::errExtend = "error while calling DomExtend";
            Throw[ Message[ iNorm::errExtend ] ]
          ];

	  If[ optDebug, Print["Calling sepLoop with next level"]];

          newLoop= sepLoops[lp[[2]], lev+1, k, pdim, newctx, options];
	  If[ optDebug, Print["Calling sepLoop with next level: done..."]];
          tmp = ReplacePart[tmp,newLoop,{i,2}]
        ,
          {i,1,Length[tmp]}
        ];
		 
  tmp = Select[tmp, And[Length[#[[2]]]>0, !DomEmptyQ[#[[1]]]]&];
		 
  tmp = (* take restrictions to root when possible *)
    Map[joinRestrict, tmp];
		 
  If[optDebug,
    Print["*** Join restrictions:"];
    Print["file savec in TMP_JOINR.alpha"];
     (*
    save[tmp,"TMP_JOINR.alpha"];
      *)
  ];

  (* Remove let when only one equation, must be the 
    last transformation *)
  Map[Function[{lp},
   If[Length[lp[[2]]] == 1,
     With[{eq = First[lp[[2]]]},
   If[MatchQ[eq, _loop|_restrict] && optCompact,
     With[{d = DomIntersection[DomExtend[lp[[1]],
eq[[1]][[2]]],
     eq[[1]]]},
 loop[d,eq[[2]]]],
    ReplacePart[lp, eq, 2]]
     ],
      lp
    ]],
   res=tmp]
  ],

	   (* if lev > k then just simplifies the loop/restrict domain 
	    in the context	   *)
	   tmp=let[];
	   Do[l=lr[[i]];
	     (* at this time, it should still be a loop *)
	     If[!MatchQ[l, loop[_domain, _]],
	       Throw[$Failed]];
	     cd = DomSimplify[l[[1]],DomExtend[ctx, l[[1,2]]]];
	     (* in this level of recursion, lev == k+1;
	      if k==dimension of variable then
	      do not produce a loop but a restriction
	      else  produce a (spatial) loop
	      these comments are from Fab, I do not get them*)
	     newLoop=If[lev+pdim > l[[1,1]],
		       (* of course, if no constraints, do not add a
		       restrict *)
		       If[DomUniverseQ[cd],
			 (* no restriction *)
			 l[[2]],
			 (* cd is the set of remaining constraints *)
			 restrict[cd, l[[2]]]
		       ],
		       (* produce the loop *)
		       loop[cd, l[[2]]]
	     ];
	     tmp=Append[tmp,newLoop];
	      ,{i,1,Length[lr]}];

	   If[optDebug,
	     Print["*** simplify In Context:"];
	     (*
	     show[ctx];
	      show[tmp];*)
	   ];

	  res= tmp
	 ]
       ];
       If[optDebug,
	 Print["END level ", lev];
	 Print["======================================"]];
       res
 ] ;

sepLoops[a___] :=
  Module[{},
	 Message[sepLoops::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[sepLoops];

(* === *)

Unprotect[sepLoopsLevel];

 sepLoopsLevel::wrongArg = INorm::wrongArg;

sepLoopsLevel[
  lr:let[___loop],
  lev:_Integer?Positive,
  pdim:_Integer?NonNegative,
  options___Rule] :=
  Module[{sp, e, u, res},
	 (* sp is the list of remaining loops *)
	 sp = Rest[lr];
	 (* res is the (partial) result *)
	 res = let[First[lr]];
	 (* u is the covered domain (union of domain of proceeded loops) *)
	 u = First[lr][[1]];

	 (* while remaining loops in the original list *)
	 While[Length[sp] > 0, 
	       (* e is the currently proceeded loop *)
	       e = First[sp];
	       (* so update the list of remaining loops *)
	       sp = Rest[sp];
	       (* now proceed x:
		  for any loop x in res
		    on dom(x)-dom(e), do stat(x)
		    on dom(x).dom(e), do stat(x) and stat(e)
		    on dom(e)-u, do only stat(e) *)
	       onlyX=Map[loop[domDifference[#[[1]], e[[1]]] ,#[[2]]] &,
			res];
	       onBoth=Map[loop[DomIntersection[#[[1]],e[[1]]],
			     Join[#[[2]], e[[2]]]] &,
			res];
	       onlyE=let[loop[domDifference[e[[1]],u],e[[2]]]];
	       res = Join[onlyX,onlyE,onBoth];
	       (* remove empty loops *)
	       res = Select[res, Not[DomEmptyQ[#[[1]]]]&];
	       (* and finally update the covered domain *)
	       u = domUnion[u, e[[1]]];
	     ]; (* end of while *)

         (* do not allow multiple polyhedra domains, so separate them into
	    multiple domains, sepDomain provides a disjoint union of 
	  domain *)
	     res=Join@@Map[
			   Function[{r},
				   Apply[let,
					Map[loop[#, r[[2]]]&,
					   sepDomain[r[[1]]]]
				   ]
			   ],
			   res];

	 (* Do not forget the main stuff, sort all the loop ! *)
	 (* res = Sort[res, Equal[DomLTQ[#1[[1]], #2[[1]], lev],
	    -1]&]; *)
	 (* MapIndexed[Print[-1+#2[[1]], ": ", sprint[#1[[2]]]]&,
	    List@@res]; *)
	 If[Length[res] == 1,
	    res,
	   tmp=Apply[List,res];
	   h=Head[res];
	   sortedDoms=DomSort[Map[First,tmp], lev, pdim, False];
	   Apply[h,Part[tmp,sortedDoms]]
	 ]
  ];
    
sepLoopsLevel[a___] :=
  Module[{},
	 Message[sepLoopsLevel::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[sepLoopsLevel];

(* === *)

Unprotect[projection];

Clear[projection];

 projection::wrongArg = INorm::wrongArg;
 projection::dim = "cannot project dimension `1` of a `2`-dimensional domain.";

(* project domain d on a subset of indices containing: 
 the lev first indice and the parameters *)
projection[
  d:_domain,
  lev:_Integer?Positive,
  pdim:_Integer?NonNegative,
  relax:True|False] :=
  With[{n = d[[1]]},
    If[lev>n-pdim,
       (*       Global`$$proj = {d,lev,pdim,relax};*)
      Message[projection::dim, lev, n-pdim];Throw[$Failed]
    ];

    (* replace the code by DomProject which was equivalent *)
    newIndices= Drop[d[[2]], {lev+1, n-pdim}];
    dom=DomProject[d,newIndices];
       
    (* relax means: for all dimension level-1, 
      forget the constraints *)
    If[relax && lev>1,
	 With[{m = matrix[lev-1, dom[[1]]+2, {},
			 Map[Join[{0}, #, {0}]&,
			    Take[IdentityMatrix[dom[[1]]], lev-1]]]},
	     dom = DomAddRays[dom, m];
    ];
  ];
  dom
];
 

projection[a___] :=
  Module[{},
	 Message[projection::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[projection];

(* === *)

Unprotect[reportRestrict];

reportRestrict::wrongArg = INorm::wrongArg;

Clear[reportRestrict];

reportRestrict[
 d_domain,
 l:let[__loop]] :=
Module[ {auxF},
  auxF[x:_] :=
  Module[ {ext, int, varloop},
    ext = DomExtend[ d, x[[1,2]] ];
    int = DomIntersection[ ext, x[[1]] ];
    varloop = loop[ int, x[[2]] ]
  ];

Map[
  Function[{x},
    loop[DomIntersection[DomExtend[d,x[[1,2]]],
			    x[[1]]],
		    x[[2]]]
	     ],
  l]

];

reportRestrict[a___] :=
  Module[{},
	 Message[reportRestrict::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[reportRestrict];

(* === *)

Unprotect[joinRestrict];

 joinRestrict::wrongArg = INorm::wrongArg;
 joinRestrict::internal = "`1`";

Clear[joinRestrict];

joinRestrict[
 lp:loop[d_domain, l_let]] :=
  With[{lcases = Cases[l, _loop|_restrict]},
       If[Length[lcases] == Length[l],
	  With[{ldom = Map[DomProject[First[#], d[[2]]]&, lcases]},
	       With[{newD = With[{tmp = sepDomain[Fold[DomUnion,
						       First[ldom],
						       Rest[ldom]]]},
				 DomIntersection[d, Fold[DomUnion,
							 First[tmp],
							 Rest[tmp]]]]},
		    If[Length[newD[[3]]]>1,
		       (* do not do anything if it would create
			  a multi-pol control domain *)
		       lp,
		       (* else go *)
		       loop[newD,
			    Map[Function[{x},
					 If[MatchQ[x, _loop|_restrict],
					    With[{cd = DomSimplify[x[[1]],
								   DomExtend[newD,
									     x[[1,2]]]]},
						   If[DomUniverseQ[cd],
						      x[[2]],
						      ReplacePart[x,cd,1]
						    ]],
					    x]],
				l]]
		     ]
		  ]
	     ],
	  lp]
     ];

joinRestrict[a___] :=
  Module[{},
	 Message[joinRestrict::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[joinRestrict];

(* === *)

Unprotect[sepDomain];

Clear[sepDomain];

 sepDomain::wrongArg = INorm::wrongArg;

sepDomain[
 dom:_domain] :=
  Module[{d, dl, res, u, x},
	 If[Length[dom[[3]]]==1,
	    {dom},
	    x = DomConvex[dom];
	    d = domDifference[x, domDifference[x, dom]];
	    dl = Map[Function[{p}, domain[d[[1]], d[[2]], {p}]],d[[3]]];
	    u = First[dl];
	    res = {u};
	    dl = Rest[dl];
	    While[dl =!= {},
		  x = First[dl];
		  dl = Rest[dl];
		  x = domDifference[x, u];
		  res = Append[res, x];
		  u = domUnion[u,x];
		];
	    Select[Join@@Map[sepDomain,res], Not[DomEmptyQ[#]]&]
	    ]
       ];

sepDomain[a___] :=
  Module[{},
	 Message[sepDomain::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[sepDomain];

(* === *)

Unprotect[rnf];

Clear[rnf];

 rnf::wrongArg = INorm::wrongArg;
 rnf::failed = "";
 rnf::eqShape = "Corrupted equation in the system";
 rnf::restrict = "";
 rnf::use = "Could not r-normalize a system which has use statments.";
 rnf::reduce = "Could not r-normalize a system which has reductions.";

Clear[applyRneq];
applyRneq[sys:_system,eq:_use]:=  (Message[rnf::use];Throw[$Failed]);
applyRneq[sys:_system,eq:_equation]:=   
    rneq[sys, eq, getDeclarationDomain[sys, eq[[1]]]]
applyRneq[eq:___]:= (Message[rnf::eqShape];Throw[$Failed])


rnf[
 s:_system, options___Rule] := verbFail[rnf::failed,
   Catch[
     With[{sys = normalize[s]},
	  Module[{declList, res},
		(* join all the var declaration *) 
		declList = Apply[Join, Take[s, {3,5}]];
		newEq=Apply[Join,Map[applyRneq[sys,#] &, sys[[6]]]];
		res = ReplacePart[sys,newEq,6]; 
		res
	  ]
	]
   ]
]
rnf[a___] :=
  Module[{},
	 Message[rnf::wrongArg, {a}];
	 $Failed
	 ];

Protect[rnf];

(* === *)

Unprotect[rneq];

Clear[rneq];

 rneq::wrongArg = INorm::wrongArg;

rneq[
 s:_system,
 eq:equation[name:_String, rhs:_],
 ctx:_domain] :=
  Module[{},
	 rneq[s, eq[[1]], eq[[2]], ctx]
	 ];

rneq[
 s:_system,
 name:_String,
 restrict[d:_domain, rhs:_],
 ctx:_domain] :=
  If[ctx[[1]] == d[[1]],
     rneq[s, name, rhs, DomIntersection[ctx, d]],
     Message[rnf::restrict]
   ];

rneq[
 s:_system,
 name:_String,
 case[cl:_List],
 ctx:_domain] :=
  Apply[Join, Map[rneq[s, name, #, ctx]&, cl]];

rneq[
 s:_system,
 name:_String,
 rhs:_var|_const|_binop|_unop|_if|_affine|_call,
 ctx:_domain] :=
  let[loop[DomIntersection[ctx, expDomain[s, rhs]],
	   equation[name, rhs]]
    ];

rneq[
 s:_system,
 name:_String,
 rhs:_reduce,
 ctx:_domain] :=
  Module[{},
	 Message[rnf::reduce];
	 Throw[$Failed]
       ];

rneq[a___]:=
  Module[{},
	 Print[Head/@{a}];
	 Message[rneq::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[rneq];

(* === *)

 domUnion::usage = "domUnion[d1:_domain, d2:_domain] returns the union domain of d1 and d2. Unlike DomUnion, it tries to minimize the number of polyhedra (by combining adjacent polyhedra)";

Clear[domUnion];

 domUnion::wrongArg = "`1`";
 domUnion::dim = "dimensions mismatch.";

domUnion[
  d1:_domain,
  d2:_domain] :=
  Catch[
    With[{dim = d1[[1]]},
	 If[dim =!= d2[[1]],
	    Message[domUnion::dim];
	    Throw[$Failed]];
	 With[{union = DomUnion[d1, d2]},
	      If[DomEmptyQ[union],
		 union,
		 Module[{tmp, diff},
			tmp = DomConvex[union];
			diff = DomDifference[tmp, union];
			If[DomEmptyQ[diff],
			   tmp,
			   DomDifference[tmp, diff]
			 ]
		      ]
	       ]
	    ]
       ]
  ];

domUnion[a___] :=
  Module[{},
	 Message[domUnion::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

 domDifference::usage = "domDifference[d1:_domain, d2:_domain] returns the difference between d1 and d2. This is a fixe for a bug of DomDifference when d2 is empty";

Clear[domDifference];

 domDifference::wrongArg = "`1`";
 domDifference::dim = "dimensions mismatch.";

domDifference[
  d1:_domain,
  d2:_domain] :=
  Catch[
    If[d1[[1]] =!= d2[[1]],
       Message[domDifference::dim]; Throw[$Failed],
       If[DomEmptyQ[d2],
	  d1,
	  DomDifference[d1, d2]
	]
     ]
  ];

domDifference[a___] :=
  Module[{},
	 Message[domDifference::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

Unprotect[sprint];
Clear[sprint];
sprint[a_] := show[a, silent->True];
Protect[sprint];

(* === *)

End[];

Protect[iNorm, rnf];
Protect[compact, norestrict, level];

EndPackage[];
