(* file: $MMALPHA/lib/Package/Alpha/CodeGen/Domains.m
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
        $Date: 2005/03/11 16:41:33 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/CodeGen/Domains.m,v $
        $Revision: 1.1 $
        $Log: Domains.m,v $
        Revision 1.1  2005/03/11 16:41:33  trisset
        added codeGen to V2

        Revision 1.15  2004/06/09 15:59:26  quinton
        Minor modifications.

        Revision 1.14  2002/09/12 14:47:26  risset
        commit after patrice update and correction of Pipecontrol

        Revision 1.13  2002/09/10 15:15:01  quinton
        Minor corrections.

        Revision 1.12  2002/08/28 11:39:02  risset
        fewchanges for debugging

        Revision 1.11  2002/08/26 12:24:46  quinton
        Needs CodeGen`init replaced by Needs CodeGen

        Revision 1.10  2002/05/28 14:29:08  quinton
        Editing corrections related to modifications to cGen.

        Revision 1.9  2002/03/01 10:40:18  risset
        improved the stimuli options, corrected ludovic s bug

        Revision 1.8  2001/12/13 08:50:24  risset
        added the BitOperateur.m

        Revision 1.7  2001/11/14 10:24:58  quinton
        Correction for scalars was incorporated, and a new matlab option has been
        added to allow code generator to produce code which is executable under
        Matlab..

        Revision 1.6  2001/06/21 16:05:59  risset
        new codeGen from Induraj

        Revision 1.5  2001/01/15 09:02:03  risset
        mise a jour

        Revision 1.4  1999/06/02 09:20:56  quillere
        added interactive code generator

        Revision 1.3  1999/05/28 14:53:24  quillere
        added CVS header and GNU info

*)


BeginPackage["Alpha`CodeGen`Domains`"];

polytopeBox::usage = "";

Unprotect[mkDomain, domAllocDims];

findBound::usage = 
"findBound[name, type, dom, pdim, pval, options] return a list of list
containing the bounds of a parameterized domain. name is any string, type
is either integer, real or boolean, dom is the domain, pdim is the number
of dimensions of the parameters, and pval is a list of rules defining
the values of the parameters, if needed. ";

computeBounds::usage = 
"computeBounds[ dom, pdim, pval, options] return a list of lists
containing the bounds of a parameterized domain dom. pdim is the
number of parameters of dom. pval is a list of rules assigning 
values to the parameters, otherwise, {}. The result of computeBounds
is a list of lists of the form { eq, lb, ub }, one for each dimension
of the domain. If eq is not {}, then along this dimension there is
an equality, and then lb and ub are {}. Conversely, if eq is {}, 
then the domain has a parameterized lower and upper bounds.";

domAllocDims::usage = "domAllocDims[d:_domain, pdim:_Integer] returns
a list of the dimensions to consider when allocating memory for the domain.";

optNoSchedule::usage = "Option of mkDomain.  When True, generates memory allocation with memorizing";

mkType::usage = ""; 

Begin["`Private`"];

Needs["Fail`"];
Needs["Alpha`"];
Needs["Alpha`Domlib`"];
Needs["Alpha`CodeGen`"];
Needs["Alpha`CodeGen`Output`"];
(* Needed to get the matlab option *)
Needs["Alpha`Options`"];

(* === *)

Clear[mkDomain];
mkDomain::usage = 
"mkDomain[n, t, d, pdim, pval, opts] generates a list of C expressions
for a variable of name n of type t, whose definition domain is d.
pdim is the parameter dimension, and pval is the list of values
assigned to the parameters, in form of rules. mkDomain returns 4
portion of C-code: the alias (correspondence between multidimensionnal
arrays of Alpha and linear array in C), the declaration of the linear
array, the free of the variable and the undef of the alias ";

mkDomain::failed = "";
mkDomain::wrongArg = "`1`";
mkDomain::eq = "Should not have equations in bounds";
mkDomain::nobound = "No bound";
Options[mkDomain] = 
  {Alpha`CodeGen`noSched ->False, matlab -> False};

(* This case when the domain has the same value than pdim *)
mkDomain[
 name:_String,
 type:(real|real[___]|integer[__]|integer|boolean),
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 option:___Rule]/;d[[1]]==pdim := 
 verbFail[mkDomain::failed,
   Catch[
     Module[
       {cType, nsched}, 

       Print[name];
       Print[type];
       Print[d];
       Print[pdim];
       Print[pval];
       Print[option];

       (* This is the noSchedule option *)
       nsched = Alpha`CodeGen`noSched/.{option}/.Options[ mkDomain ];

       (* This is to transmit the options to mkType *)
       cType = If[ nsched , mkStruType[type], mkType[type, option] ]; 
       {left["#define ", name, "()", " ", "*_"<>name],
        hseq[cType, " *_"<>name, " = malloc(sizeof(", cType,
             "));"],
        hseq["free(", "_"<>name, ");"],
        left["#undef ", name]
       }
     ] (* Module *)
   ]
 ];	
		
(* This case when the domain has a higher dimension than pdim *)
mkDomain[
 name:_String,
 type:(real|real[___]|integer[__]|integer|boolean),
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 option:___Rule]/;d[[1]]>pdim := 
verbFail[mkDomain::failed,
  Catch[
    Module[
      {dom, idl, dims, bounds, strv, ul, cType, nsched, vrb, dbg, pp},

(*       dbg = True;  *)

      (* Convexized domain *)
      dom = DomConvex[d];  

      (* Generates a list of elements 1 to d[[i]]-pdim *)
      idl = Array[Identity, d[[1]]-pdim];
      If[ dbg, Print[ "idl: ", idl ] ];

      (* Catch the noSchedule option value *)
      nsched = Alpha`CodeGen`noSched/.{option}/.Options[ mkDomain ];

      (* This is to transmit the options to mkType *)
      cType =  If[ nsched, mkStruType[type], mkType[type, option] ];

      (* Get the allocation dimensions of the domain *)
      dims  = domAllocDims[dom, pdim];
      If[ dbg, Print[ "Dimensions for allocation: ", dims ] ];

      (* ??? *)
      strv = Join[Take[dom[[2]], -pdim]/.pval, {1}];
      If[ dbg, Print[ "strv: ", strv ] ];

      (* Get the box enclosing the domain *)
      pp = polytopeBox[dom, pdim]; 
      If[ dbg, Print["Enclosing box:" , pp ] ]; 
      pp = Part[ pp, dims];
      If[ dbg, Print["pp:" , pp ] ]; 

      bounds = 
        Map[
          Function[{b},
            If[First[b]=!={},
              Message[mkDomain::eq];Throw[$Failed]];
            If[b[[2]]=={}||b[[3]]=={},
              Message[mkDomain::nobound];Throw[$Failed]];
            Module[{lb, ub},
              lb = Floor[Max@@Map[Dot[#,strv]&, b[[2]]]];
              ub = Ceiling[Min@@Map[Dot[#,strv]&, b[[3]]]];
	      {lb, ub}
            ]
          ], (* Function *)
          pp
        ];
      If[ dbg, Print["bounds: ", bounds ] ];

      ul = 
        ReplaceAll[idl,
          Join[
            MapThread[RuleDelayed, {dims, bounds}],
            {_Integer:>{0,0}}
          ]
        ];
      If[ dbg, Print["ul: ", ul ] ];

      Module[{w, wi, vol, ofs, def, defs, v, idx, str, malloc, 
                   free, addr},
        w[1] = 1;
        w[i_] := w[i] =
        Expand[w[i-1]*(ul[[i-1,2]]-ul[[i-1,1]]+1)];
        wi = Map[w, idl];
        ofs  =  Expand[- Dot[wi,(First/@ul)]];
        vol = w[dom[[1]]-pdim+1];
        def = 
          Append[
                 MapThread[List,{idl, 1-Map[Apply[Subtract, #]&, ul], wi}],
                 {0, 0, ofs}
          ];
        defs = 
          Select[def, 
                 And[Not[NumberQ[#[[3]]]], #[[2]]=!=1]&
          ];
        v = Map[
              Function[{s},If[s[[2]]===1,0,
                       If[NumberQ[s[[3]]],
                          s[[3]],
                          "__"<>name<>".dim"<>ToString[s[[1]]]]]],
              def
            ];
        idx = Join[StringJoin["(", #, ")"]& /@ Drop[d[[2]], -pdim], {1}];
        str = 
          If[defs=={},
             vseq[],
             vseq["struct {",
               vseq@@Map[Function[{x},
                 StringJoin["  int dim",
                 ToString[x[[1]]],
                 ";"]],
                 defs
                        ],
                 hseq[StringJoin["} __", name, " = {"],
                 list@@Map[Last,defs], "};"]
                  ]
          ]; (* If *)
        malloc = vseq[hseq[cType, " * _", name, " = (", cType,
          " *) malloc(sizeof(", cType, ")*(", vol,
          "));"]];
        free  = vseq[hseq["free(_", name, ");"]];
        addr = 
          vseq[
            left["#define ", name, "(",
              Apply[
                list, 
                Drop[d[[2]], -pdim]
              ], 
            ") ",
            "_", name, "[", v.idx, "]"
            ]
          ]; (* vseq *)
        {Join[str, addr], malloc, free, left["#undef ", name]}
      ] (* Module *)
    ]  (* Module *)
  ]
];

(* Error case *)
mkDomain[a___] :=
  Module[{},
	 Message[mkDomain::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* This is for test... *)
mkDomain["test"] :=
  Map[Apply[mkDomain, #]&, testlist];

mkDomain[dom:_domain, pdim:_Integer] :=
  mkDomain["test", integer, dom, pdim, {}, {{}}];

(* findBound is extracted from above for matlab purpose *)
(* This function computes the bounds of a domain (see usage) *)
(* The parameters are the same as for mkDomain *)
Clear[ findBound ];
findBound[
 name:_String,
 type:_,
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 option:___Rule]/;d[[1]]==pdim := {}

findBound[
 name:_String,
 type:_,
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 option:___Rule]/;d[[1]]>pdim := 
Catch[
  Module[
    {dom = DomConvex[d],  (* Convex closure of dom *)
     (* Index list, from 1 to d[[1]]-pdim *)
     idl = Array[Identity, d[[1]]-pdim], 
     dims, bounds, strv, ul,
     cType, nsched, pb},

     (* noSched option of mkDomain *)
     nsched = Alpha`CodeGen`noSched/.{option}/.Options[mkDomain];
     cType = If[ nsched, mkStruType[type], mkType[type, option] ];

     (* See above for comments *)
     dims  = domAllocDims[dom, pdim];
(*
     Print["allocation dimensions: ", dims ];
*)     
     strv = Join[Take[dom[[2]], -pdim]/.pval, {1}];

     (* Computes *)
     pb = polytopeBox[dom, pdim];
(*
     Print[ "polytopeBox: ", pb ];
*)
     pb = Part[pb, dims];
(*
     Print[" part of polytopeBox: ", pb ];
*)
     bounds = 
       Map[Function[{b},
         If[First[b]=!={},
           Message[mkDomain::eq];Throw[$Failed]];
           If[b[[2]]=={}||b[[3]]=={},
             Message[mkDomain::nobound];Throw[$Failed]];
             Module[{lb, ub},
               lb = Floor[Max@@Map[Dot[#,strv]&, b[[2]]]];
               ub = Ceiling[Min@@Map[Dot[#,strv]&, b[[3]]]];
              {lb, ub}
             ]
           ],
         Part[polytopeBox[dom, pdim], dims]
       ];
    bounds
  ] (* Module *)
];

findBound[a___] :=
  Module[{},
	 Message[findBound::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

(* computeBounds is like findBound *)
Clear[ computeBounds ];
computeBounds[
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 option:___Rule]/;d[[1]]==pdim := {}

computeBounds[
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 option:___Rule]/;d[[1]]>pdim := 
Catch[
  Module[
    {dom = DomConvex[d],  (* Convex closure of dom *)
     (* Index list, from 1 to d[[1]]-pdim *)
     idl = Array[Identity, d[[1]]-pdim], 
     bounds, strv, ul,
     nsched, pb, dbg},

     dbg = False; 

     (* noSched option of mkDomain *)
     nsched = Alpha`CodeGen`noSched/.{option}/.Options[mkDomain];

     (* See above for comments *)
     strv = Join[Take[dom[[2]], -pdim]/.pval, {1}];
     If[ dbg, Print["strv ", strv ]];

     (* Computes *)
     pb = polytopeBox[dom, pdim];
     If[ dbg, Print[ "polytopeBox: ", pb ] ];

     (* Auxiliary function *)
     (* This function provides equalities or bounds *)
     auxF = 
       Function[{b},
         Module[{eq, lb, ub},
           Which[
             First[b]=!={}
           ,
             eq = First[Dot[First[b],strv]];
             lb = {}; ub = {}
           ,
             b[[2]]=={}||b[[3]]=={}
           ,
             Message[mkDomain::nobound];Throw[$Failed]
           ,
             True
           , 
             eq = {};
             lb = Floor[Max@@Map[Dot[#,strv]&, b[[2]]]];
             ub = Ceiling[Min@@Map[Dot[#,strv]&, b[[3]]]]
           ];
           {eq, lb, ub}
         ]
       ];

     bounds = Map[ auxF, pb ]
  ] (* Module *)
];

computeBounds[a___] :=
  Module[{},
	 Message[computeBounds::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

Unprotect[mkType];
(* mkType is called by mkDomain, and findBound *)
Clear[mkType];
Options[ mkType ] := {debug -> False, verbose -> False, matlab -> False };
mkType::usage = "mkType[type] generates a type...";
mkType::wrongArg = "`1`";
mkType[integer["U",n:_Integer], opts:___Rule] := 
  Module[{},
    Which[
      n<=8,"int", (* should be char *)
      9<=n<=16,"short", (* should be short *)
      16<=n<=32,"int"]
    ];
mkType[integer["S",n:_Integer], opts:___Rule] := 
  mkType[integer["U",n], opts]  

mkType[integer, opts:___Rule] := "int";

(* For Matlab, real should be double *)
mkType[real, opts:___Rule] := 
  Module[{mtl},
    mtl = Alpha`Options`matlab/.{opts}/.Options[ mkType ];
    If[ mtl, "double", "float" ]
  ];

(* For Matlab, real should be double *)
mkType[real[___], opts:___Rule] := 
  Module[{mtl},
    mtl = Alpha`Options`matlab/.{opts}/.Options[ mkType ];
    If[ mtl, "double", "float" ]
  ];
mkType[boolean, opts:___Rule] := "int";

mkType[a___] := 
  Module[{},
	 Print[Context[a]];
	 Print[FullForm[a]];
	 Print[MatchQ[a,integer["U",_]]];
	 Message[mkType::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[mkType];

(* === *)

Unprotect[mkStruType];
Clear[mkStruType];

mkStruType::wrongArg = "`1`";

mkStruType[integer["U",n:_Integer]] := 
Module[{},
  Which[n<=8,"intvar",
    9<=n<=16,"intvar",
    16<=n<=32,"intvar"]
];

mkStruType[integer["S",n:_Integer]] := 
(* Check this... *)
  mkStruType[integer["U",n+1]];
mkStruType[integer] := "intvar";
mkStruType[real] := "floatvar";
mkStruType[real["S",n:_Integer,m:_Integer]] := "floatvar";
mkStruType[boolean] := "intvar";

mkStruType[a___] := 
Module[{},
  Print[Context[a]];
  Print[FullForm[a]];
  Print[MatchQ[a,integer["U",_]]];
  Message[mkStruType::wrongArg, {a}];
  Throw[$Failed]
];

Protect[mkStruType];

(* === *)

Clear[domAllocDims];

domAllocDims::wrongArg = "`1`";

domAllocDims[
 dom:_domain,
 pdim:_Integer?NonNegative] :=
  With[{dim = dom[[1]] - pdim,
	idm  = IdentityMatrix[dom[[1]]], 
	idv = Array[Identity, dom[[1]]],
	sets = equaSets[dom, pdim]},
       fullsize = (* list of dimensions that are not involved in any equation 
		   *)
	 Complement[Take[idv, dim],
		    Union@@Map[Last, sets]];
       Join[
	 fullsize,
	 Apply[Join,
	       Map[
		 Function[{e},
			  Module[{tmp, ptop, cstr},
				 cstr = (* constraints to build the polytope
					   eq: previous ones
					   ineq: for any dim x: 0<=x<=1 *)
				   Join[
				     First[e],
				     Map[Join[{1}, #, {0}]&,idm], 
				     Map[Join[{1}, -#, {1}]&,idm]];
				 ptop = (* build the polytope *)
				   Function[{m},
					    DomConstraints[
					      matrix[Length[m],
						     Length[First[m]],
						     dom[[2]],m]
					    ]
					  ][cstr];
				 box = (* get the box *)
				   polytopeBox[ptop];
				 box = (* keep only intersecting dimensions *)
				   Part[box, Last[e]];
				 tmp = (* list of {size, dimension} *)
				   MapThread[
				     List[-Subtract@@#1, #2]&,
				     {box, Last[e]}];
				 tmp = (* order using sizes *)
				   Sort[tmp];
				 Take[
				   Map[
				     Last,
				     tmp],
				   Length[Last[e]] - Length[First[e]]]
				 (* Finally extract the n first ordered
				    dimensions. What is n ? Assume we have 3
				    dimensions, locked by 2 equations; let's
				    keep only 1 (3-2) *)
				 ]
			],
		 sets]
	     ]
       ]
     ];

domAllocDims[a___] :=
  Module[{},
	 Message[domAllocDims::wrongArg, {a}];
	 Throw[$Failed]
       ];

domAllocDims["test"] :=
  Map[Apply[domAllocDims, #]&, testlist];


testlist := {
	 {readDom["{i,j,k | i=2k; j=1}"], 0},
	 {readDom["{i,j,N | j=i-N; N+1<=i<=2N}"],1},
	 {readDom["{i,j,N | i=N; 1<=j<=N}"], 1},
	 {readDom["{i,j,N | i=N; j=N+1}"],1},
	 {readDom["{i,j,N | 1<=i<=N; 1<=j<=N+1}"],1},
	 {readDom["{i,j,N,M | N=2M; 1<=i<=N; 1<=j<=M}"],2},
	 {readDom["{i,j,N,M | 3j=M; i=N; N=2M}"],2},
	 {readDom["{i,j,k,l,N,M | 3j=2k; 5i=3k; -M<=i<=(N,M,8);(M-N, -M)<=l<=M+N; l<=8; l<=M+2}"],2}
	 };

(* === *)

Unprotect[equaSets];
Clear[equaSets];

 equaSets::usage = "equaSets[d:_domain] returns a list of couples, each couple is a list of equations and a list a integers ; the integers are the numbers of the dimensions which are concerned by the equations.  The list of couples is such that to couples don't have any common dimensions.  In others words, it returns distinct lineality spaces";

 equaSets::wrongArg = "`1`";

equaSets[
 dom:_domain,
 pdim:_Integer?NonNegative] :=
  With[{dim = dom[[1]] - pdim,
	idv = Array[Identity, dom[[1]]]},
       With[{eqs =  (* get all equations which involves non param dimensions. For
		       exemple, would rule out N=3 if N was a parameter.
		       The rule zeroes the constants *)
	     Cases[Select[dom[[3,1,5]], Apply[Or,
					      Map[Not[#==0]&,
						  Take[Rest[#],dim]]]&],
		   {0, c:___, _}->{0, c, 0}]},
	    Module[{h,x,b,y,t,rule,lhead,tmp},
		   tmp = (* for each eq, build a couple
			    {eq, list of dimensions involved in this equation}
			    The lhead head is needed to avoid unwanted rule applications
			    in the next statement *)
		     Apply[lhead,
			   Map[
			     Function[{eq},
				      List[{eq},
					   Select[
					     MapThread[If[(#1==0)||(#2>dim), 0, #2]&,
						       {Drop[Rest[eq], -1], idv}],
					     Not[#==0]&
					     ]]],
			     eqs]];
		   rule = (* this is a rule to merge two couples (see above) which share
			     ast least one dimension *)
		     RuleDelayed[Condition[lhead[h___, x_, b___, y_, t___],
					   Intersection[x[[2]], y[[2]]]=!={}],
				 lhead[h, b, t,
				      {Join[x[[1]], y[[1]]],
				       Union[x[[2]], y[[2]]]}
				       ]
			       ];
		   Apply[List, tmp //. rule]
		 ]
	  ]
     ];

equaSets[a___] :=
  Module[{},
	 Message[equaSets::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[equaSets];

(* === *)

Clear[polytopeBox];

polytopeBox::wrongArg = "`1`";
polytopeBox::dim = "dim should be greater than 0";
  
polytopeBox[d:_domain] := 
  With[{l = MapThread[Join,Map[polytopeBox, d[[3]]]]},
       {Min@@#, Max@@#}& /@ l
       ];

polytopeBox[p:_pol] :=
  With[{l = Rest /@ p[[6]]},
       Transpose[Map[(Drop[#, -1]/Last[#])&, l]]
     ];

polytopeBox[d:_domain, pdim:_Integer?NonNegative] :=
Module[{dc, mats, dim, id, projDomains, auxFunction,dbg},

  dbg = False; 

  (* Get the dimension less the parameters' dimension *)
  dim = d[[1]]-pdim;
  id = IdentityMatrix[d[[1]]+1];

  (* If dimension is 0, error *)
  If[ dim<1, Message[polytopeBox::dim]; Throw[$Failed] ];

  (* Build a list of projection matrix, one for each 
     dimension of dim *)
  mats = Array[matrix[2+pdim, d[[1]]+1, {},
			     Join[{id[[#]]},Take[id, -1-pdim]]]&, dim];
  If[ dbg, Print["projection matrix: ", mats] ];

  (* Convexize domain d *)
  dc = DomConvex[d];
  If[ dbg, Print["dom convex: ", ashow[ dc, silent -> True ] ] ];

  (* Build a list of projected domains *)
  projDomains = DomImage[dc, #]& /@ mats ;
  If[ dbg, 
    Map[ Print[ ashow[#, silent->True ] ]&, projDomains ] ];

  (* Define an auxiliary function, which is to be run on a list 
     of projected domains *)
  auxFunc = 
    Function[{proj},
      Module[{eqs, ineqs, lb, ub, f},
        (* Get equalities *)
        eqs = 
          If[proj[[3,1,3]]==0,
           {},
           Cases[proj[[3,1,5]], {0, 1, c:___}->{1, c}]
        ];
        If[ dbg, Print[ " equalities: ", eqs ] ];

        ineqs = 
          If[proj[[3,1,1]]-proj[[3,1,3]]==0,
            {},
            Cases[proj[[3,1,5]], {1, c:___}->{c}]
         ];
         If[ dbg, Print[ " inequalities: ", ineqs ] ];

         (* The lower bounds are the list of integer in the inequalities
            which are positive *)
         lb = Cases[ineqs, {i:_Integer?Positive, ___}];
         (* The upper bounds are the list of integers in the inequalities
            which are negative *)
         ub = Cases[ineqs, {i:_Integer?Negative, ___}];

         (* This function takes a list, removes its first element, 
           and divides what remains by the first element *)
         f = Function[{v}, Rest[v]/-First[v]];
         If[ dbg, Print["lb: ", lb] ];
         If[ dbg, Print["ub: ", ub] ];
         If[ dbg, Print[ {f/@eqs, f/@lb, f/@ub} ] ];
         {f/@eqs, f/@lb, f/@ub}
      ]
    ];

  Map[
    auxFunc, projDomains
  ]
];

polytopeBox[a___] :=
  Module[{},
	 Message[polytopeBox::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

End[];

Protect[mkDomain, domAllocDims];

Map[
  If[!StringQ[#::usage], Print["Warning: no usage for public symbol ", #]]&,
  Symbol/@Names["`*"]
];

EndPackage[];










