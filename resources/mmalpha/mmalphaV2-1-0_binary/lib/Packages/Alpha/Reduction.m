(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : D. Wilde
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

BeginPackage["Alpha`Reduction`", {"Alpha`Domlib`",
				  "Alpha`",
				  "Alpha`Options`",
				  "Alpha`Matrix`",
				  "Alpha`Tables`",
			          "Alpha`Semantics`",
				  "Alpha`Normalization`",
			          "Alpha`Substitution`",
				  "Alpha`Pipeline`"
				  }]
(* $Id: Reduction.m *)
Reduction::note = 
"Documentation revised on August 8, 2004";

Reduction::usage =
"The Alpha`Reduction` package contains transformations to deal with 
reduction operators.";

Reduction::note = 
"This package is not completed. In particular, it contains two functions
splitReduction and splitReduce which do no work.";

serializeReduce::usage = 
"serializeRecuce[pos] serializes the reduction at position pos in
$result. serializeReduce[pos, spec] serializes the reduction at position 
pos in $result using serialization specifier spec (spec is a string).
Parameter pos may be either a position in the AST, or the name
(string) of a variable whose definition has the form \"pos = reduction\".
serializeReduce[sys, pos, spec] does the same to program
sys. Parameter spec is a string containing the new variable name composed
with the new serialized dependence (parameters need not be given 
explicitly). For example: \"Z.(i,k->i,k-1)\" means that the serialized 
variable will be \"Z\" and the serialize direction will be the vector 
(0,-1). If no spec is given, the function guesses the direction
of serialization, and the option (invert -> False|True) allows this
direction to be changed. The guess is based on the null space of the
reduction function, and it works only if this null space has exactly
one vector."

isolateReductions::usage = 
"isolateReductions[] locates all the reductions in a system and isolates
these reductions in new equations"; 

isolateOneReduction::usage = "isolates one reduction";

splitReduction::usage = 
"splitReduction[y] tries to rewrite the reduction at rhs of symbol y
as a sequence of reduction. This function does not work currently.";

(*-------------------------------------------------------------------------*)
Begin["`Private`"]

(* Convert polyhedron with identity matrix to zpolyhedron*)
Clear[PtoZ];
PtoZ::params = "wrong parameters"
PtoZ[a:Alpha`domain[0,_,_]] := a;
PtoZ[po:Alpha`domain[dim_Integer,id_List,p:{_Alpha`pol..}]] :=
        Alpha`domain[dim,{},{Alpha`zpol[Alpha`matrix[dim+1,dim+1,id,IdentityMatrix[dim+1]],p]}];
PtoZ[a_Alpha`domain] := a;
PtoZ[___] := Message[PtoZ::params];

Clear[redundantQ];
redundantQ[m:Alpha`matrix[r_,c_,_,mat_]] := 
  (identityQ[m] || (Drop[mat,-1]==Table[0,{i,r-1},{j,c}]));

(* convert zpolyhedron with identity matrix to polyhedron*)
Clear[ZtoP];
ZtoP::params = "wrong parameters";
ZtoP[zp:Alpha`domain[dim_Integer,id_List,z:{_Alpha`zpol..}]] :=
        If[redundantQ[z[[1,1]]] && Length[z]===1,Alpha`domain[dim,z[[1,1,3]],z[[1,2]]],zp];
ZtoP[a_Alpha`domain] := a;
ZtoP[___] := Message[ZtoP::params];
			
Clear[splitReduction];

Options[ splitReduction ] := { debug -> False };

splitReduction[ s:_String, opts:___Rule ] :=
Module[ {temp},
   temp = $result;
   $result = 
   Check[ splitReduction[$result, s, opts ],
	temp ];
   $result
];

splitReduction[ sys:_system, s:_String, opts:___Rule ]:=
Catch[
  Module[ {dbg, red, op, exp, f, h, u, mmah, mmaf, mmau, f1,
           indexes, pm, pmNumber },

    dbg = debug/. {opts} /. Options[ serializeReduce ];

    If[ !MemberQ[ Union[ getLocalVars[ sys ], getOutputVars[ sys ] ], s ],
      splitReduction::wrgvar = 
        "`1` should be a local or output var of this system"; 
      Throw[ Message[ splitReduction::wrgvar, s ] ]
    ];

    Check[ red = getEquation[ sys, s ],
	 splitReduction::wrgequ = 
	 "there is no equation with `s` as lhs";
      Throw[ Message[ splitReduction::wrgequ, s ] ]
    ];

    Check[ red = red[[2]], 
	 splitReduction::wrgequ1 = 
	 "rhs of `s` is not a reduction";
      Throw[ Message[ splitReduction::wrgequ, s ] ]
    ];
    
    (* Check that it is a reduction *)
    If[ Head[red] =!= reduce,
      serializeReduce::notared = "selected expression is not a reduction";
      Throw[ Message[serializeReduce::notared]; {}]
    ];

    (* Get operator *)
    op = Part[red,1];
    If[ dbg, Print["Operator: ", op ] ];

    (* Get dependence function *)
    f = Part[red,2];
    If[ dbg, Print["Dep function: ", f ] ];

    (* Get expression *)
    exp = Part[red,3];
    If[ dbg, Print["Expression: ", exp ] ];

    (* Get parameters *)
    pm = getSystemParameters[ sys ];
    pmNumber = Length[ pm ];

    (* Drop parameters of affine function *)
    (* Get indexes in f *)
    indexes = f[[3]]; If[ dbg, Print["indexes : ", indexes ] ];
   
    (* Map f to mma matrix *)
    mmaf = alphaToMmaMatrix[ f ]; 
    If[ dbg, Print["mmaf : ", mmaf ] ];

    (* Remove last vectors which correspond to parameters *)
    mmaf = Drop[ mmaf, - pmNumber ]; 
    If[ dbg, Print["mmaf : ", mmaf ] ];

    (* Remove last column which correspond to parameters, 
       unless mmaf is empty *)
    If[ mmaf =!= {}, 
      mmaf = Transpose[ Drop[ Transpose[ mmaf ], -1 ] ]
    ];
    If[ dbg, Print["mmaf : ", mmaf ] ];
    f1 = mmaToAlphaMatrix[ mmaf, Drop[indexes,-1] ]; 
    If[ dbg, Print["f1 : ", f1 ] ];

    (* Compute Right Hermite decomposition of f1 *)
    {h,u} = hermite[ f1 ];

    (* Print it *)
    Print["Hermite form :"];
    Map[ ashow, {h,u}];

    (* Get MMA form of h and u *)
    mmaf = alphaToMmaMatrix[ f1 ];
    If[ dbg, Print["MMa form of f ", mmaf ] ];
    mmah = alphaToMmaMatrix[ h ];
    If[ dbg, Print["MMa form of h ", mmah ] ];
    mmau = alphaToMmaMatrix[ u ];
    If[ dbg, Print["MMa form of u ", mmau ] ];


  ]
];
splitReduction::params = "wrong arguments";
splitReduction[___] := Message[ splitReduction::params ];

(* Procedure to get a subtree from the pos vector *)
Clear[partPos]
partPos[expr_,{pos__}]:=Part[expr,pos]

(* Definition of the identity for commutative/associative operators *)
Clear[opIdentity]
opIdentity[Alpha`add]:=Alpha`const[0]
opIdentity[Alpha`mul]:=Alpha`const[1]
opIdentity[Alpha`max]:=Alpha`const[-Infinity]
opIdentity[Alpha`min]:=Alpha`const[Infinity]
opIdentity[Alpha`and]:=Alpha`const[True]
opIdentity[Alpha`or] :=Alpha`const[False]
opIdentity[_]:=
(Print["Reduce: ? reduction must be over a commutative/associative operator."];
Alpha`const[0])

(* From Matrix.m : *)
(* inverseInContext[M_Alpha`matrix, D_Alpha`domain] *)
(*    find the left inverse of M (called M') in the context of domain D *)
(*    such that M' M y = y  forall y in D *)

(* 
  ????????????
 *)
Clear[outExp];
outExp[f:_matrix, Y_, In:domain[dim_, ix_, {p_, ps___}],
       ctx:_domain, idx_, id_]:=
Module[{P,P1,g},
   If[DomEmptyQ[In],
      Return[{Alpha`restrict[ctx,affine[id,idMatrix[idx,{}]]]}]
   ];
   P = Alpha`domain[dim, ix, {p}];
   (* the {"k", "N"} is a patch ... s/b the inverse index set ... *)
   g = ReplacePart[inverseInContext[f, P], idx, {3}];
   P1 = DomZPreimage[P,g];
   Prepend[
      outExp[f, Y, DomDifference[In, P],
                   DomDifference[ctx, P1], idx, id],
      Alpha`restrict[P1, Alpha`affine[Y,g] ]
   ]
];
outExp::params = "wrong parameters";
outExp[___] := Message[ outExp::params ];

(*
   Parameters: 
   - sys : an Alpha system AST 
   - pos : position of the reduce[] in that AST, or string indicating
which equation contains a reduction
   - spec : spec of the pipe variable, ex: A.(i,j->j+1) 
*)
Clear[serializeReduce];
Options[serializeReduce] = { debug -> False, verbose -> False,
        norm -> False, invert -> False };

(* First form: no system given *)
(* No spec given *)
serializeReduce[pos:(_List|_String), opts:___Rule] :=
   serializeReduce[pos, "", opts];
serializeReduce[pos:(_List|_String), spec:_String, opts:___Rule ]:=
Module[ {temp},
   temp = $result;
   $result = 
   Check[ serializeReduce[$result, pos, spec, opts ],
	temp ];
   $result
];

(* Main form *)
serializeReduce[sys:_system, posSpec:(_List|_String), 
  spec_String, opts:___Rule ] :=
Catch[
  Module[ {specAST,Y,T,red,dom,op,f,exp,idx,
       Ydom5, Ydom4, Ydom3, Ydom2, Ydom1, Ydom, 
       Ytyp, Yeqn, dbg, vrb, pos, result, nospec},
  
  dbg = debug/. {opts} /. Options[ serializeReduce ];
  normOpt = norm/. {opts} /. Options[ serializeReduce ];
  inv = invert/. {opts} /. Options[ serializeReduce ];

  (* nospec True if specification is empty. In this case
     we will guess the serialization direction *)
  nospec = (spec==="");

  (* Position given by variable *)
  If[ MatchQ[ posSpec, _String ],
    Check[ pos = Position[ sys, getDefinition[ sys, posSpec ] ],
       serializeReduce::wrongpos = "position is not a local var of sys";
       Throw[ Message[serializeReduce::wrongpos]; {}]
    ];
    If[pos === {}, 
      serializeReduce::wrongsymb = 
        "the symbol does not correspond to any equation.";
      Throw[ Message[serializeReduce::wrongsymb]; {} ]
    ];
    pos = First[ pos ],
    If[posSpec==={},
      serializeReduce::nopos = "no position given";
      Throw[ Message[serializeReduce::nopos]; {} ],
      pos = posSpec
    ]
  ];
(* change *)
  (* Parse second expression *)
  If[ !nospec,
    Check[ 
      specAST = readExp[ spec, If[Head[sys[[2,3,1]]]===Alpha`pol,sys[[2,2]],sys[[2,3,1,1,3]]] ],
      serializeReduce::errorReadExp = "could not parse second parameter";
      Throw[ Message[serializeReduce::errorReadExp]; {} ]
    ];
  
    If[ dbg, Print[ specAST ] ];
    (* Check that this expression has the correct syntax *)
    If[ !MatchQ[ specAST, affine[ var [_], _matrix ]], 
      serializeReduce::errorSpec = "spec should have the form \"Var.dep\".";
      Throw[ Message[serializeReduce::errorSpec]; {}]
    ];
  ];
   
  (* Get the symbol *)
  If[ nospec, Y = ToString[Unique["ser"]],
    Y = Part[specAST,1,1]
  ]; (* Y is the symbol to be reduced *)
  If[ dbg, Print[ Y ] ];

  (* Get the reduction *)
  Check[
    red = partPos[sys,pos],
    serializeReduce::errorpos = "wrong position";
    Throw[ Message[serializeReduce::errorpos]; {}]
  ];
  If[ dbg, Print["Expression to be reduced is: ", red ] ];

  (* Check that it is a reduction *)
  If[ Head[red] =!= reduce,
    serializeReduce::notared = "selected expression is not a reduction";
    Throw[ Message[serializeReduce::notared]; {}]
  ];

  (* Get operator *)
  op = Part[red,1];
  If[ dbg, Print["Operator: ", op ] ];

  (* Get dependence function *)
  f = Part[red,2];
  If[ dbg, Print["Dep function: ", f ] ];

  (* Get expression *)
  exp = Part[red,3];
  If[ dbg, Print["Expression: ", exp ] ];

  (* Check the dimensions of f *)
  If[ (f[[2]]-f[[1]])=!=1,	(* C.numCols - C.numRows must equal 1 *)
    serializeReduce::onedim = "cannot serialize multidimensional reductions";
    Throw[ Message[serializeReduce::onedim]; {}]
  ];

  (* Get the matrix which gives the direction of the serialization *)
  If[ !nospec, 
    T = Part[specAST,2],
    Module[ {ns},
      ns = nullSpaceVectors[ f ];
      If[ Length[ ns ] =!= 1, 
        serializeReduce::wrngnullspace = 
          "reduction function must have one and only one null space vector";
        Throw[ Message[serializeReduce::wrngnullspace ] ]; {} 
      ];
      (* If the invert option is set, invert nullspace vector *)
      If[ inv, ns = -ns];
      (* Build the translation Matrix corresponding to nullspace *)
      T = translationMatrix[ f[[3]], ns[[1]] ];
    ]
  ];

  If[ dbg, Print["T matrix is: ", T ] ];

  serializeReduce::notatrans = 
    "the serialization dependence is not a proper translation";
  If[ !translationQ[ T ] || identityQ[ T ], 
    Throw[ Message[ serializeReduce::notatrans ] ]; {} ];

  If[ T[[1]]=!=f[[2]],
    serializeReduce::notcompatible = 
      "the serialization dependence is not compatible with the dimension of the body of the reduction";
    Throw[ Message[serializeReduce::notcompatible]; {}]
  ];

  (* check T with the reduction vector f *)
  (* T = I +/- d;  f.T = f.I +/- f.d;  f.d = 0; --> f.T = f *)
  If[f=!=composeAffines[f,T],
    Print["serializeReduce: ? The serialization dependence:"];
    ashow[T];
    Print["is not in null space of projection of the reduce:"];
    ashow[f];
    serializeReduce::error = "unexpected error";
    Throw[ Message[serializeReduce::error]; {}]
   ];

  (* get domain of expression in spec*)
  dom = expDomain[sys,exp];
  If[ dbg, Print[ "Domain of expression in reduction is : ", dom ];
    ashow[dom] ];

  (* get domain of reduction expression *)
  Ydom5 = getContextDomain[sys,pos];
  If[ dbg, Print[ "Domain of reduction expression (in context) is : ", Ydom5 ];
    ashow[Ydom5] ];

  (* Get indexes of expression *)
  idx = If[Head[Ydom5[[3,1]]]===Alpha`pol,Ydom5[[2]],Ydom5[[3,1,1,3]]];

  (* Check compatibility of f and indexes *)
  If[f[[1]]-1 =!= Length[idx],
    Print["Dimension of reduction does not match its context."];
    Throw[ Message[serializeReduce::error]; {}]
  ];

  (* Compute pre-image of Ydom5 by f *)
  Ydom4 = DomZPreimage[Ydom5,f];
  (* Compute intersection with dom *)
  Ydom3 = DomIntersection[dom,Ydom4];
  (* Compute pre-image of Ydom3 by T^-1 *)
  Ydom2 = DomZPreimage[Ydom3,inverseMatrix[T]];
  (* Compute union of these domains *)
  Ydom1 = DomUnion[Ydom2, Ydom3];
  (* Compute Ydom *)
  Ydom  = DomConvex[Ydom1];

  (* I guess that this is Hervé's test *)
  If[Not[DomEmptyQ[DomDifference[Ydom,Ydom1]]],
    Print["function T cannot totally define f(dom(exp))"];
    Throw[ Message[serializeReduce::error]; {}]
  ];

  (* Build type *)
  Ytyp = expType[sys,exp];

  (* Build result : change*)
  Yeqn = 
    equation[Y,
      case[{
        restrict[
          DomDifference[Ydom, Ydom3],
          affine[opIdentity[op],idMatrix[If[Head[Ydom[[3,1]]]===Alpha`pol,Ydom[[2]],Ydom[[3,1,1,3]]],{}]]
        ],
        restrict[
          Ydom3,
            binop[op,
              affine[var[Y], T],
              exp
            ]
        ]
      }]
   ];

   result = 
   Insert[
      Insert[
         ReplacePart[sys,
	    normalize[		(* clean up dumb case statements *)
               case[
	          outExp[f, var[Y],
                     DomDifference[Ydom,Ydom2],
                     Ydom5, idx, opIdentity[op]
                  ]
               ]
	    ], pos
	 ],
         decl[Y, Ytyp, Ydom],
         {5,1}
      ],
      Yeqn,
      {6,1}
   ];

   If[ normOpt, result = normalize[ result ] ];

   result

  ]
];
serializeReduce::params = "wrong parameters";
serializeReduce[___] := Message[ serializeReduce::params ];

(* This function provides a new name for a variable *)
Clear[redName];
redName[v:_Symbol]:=
  StringReplace[ "red"<>ToString[ Unique[v] ], "$"->"" ];
redName[v:_]:=
  StringReplace[ "red"<>ToString[ Unique[ToString[v]] ], "$"->"" ];
redName::params = "wrong parameters";
redName[___]:=Message[redName::params];



Clear[isolateOneReduction];
Options[ isolateOneReduction ] = { debug -> False };
isolateOneReduction[ pos:_List, opts:___Rule ]:=
Module[ {res},
      $program = $result;
      res = Check[ isolateOneReduction[ $result, pos, opts ], $program ];
      $result = res
];
isolateOneReduction[ sys:_system, pos:_List, opts:___Rule ]:=
Catch[
  Module[ {lhs, posEquation, newLhs, res, expression, redEquation, dbg},
    dbg = debug /. {opts} /. Options[isolateOneReduction];

    (* Get position of equation *)
    posEquation = Take[ pos, 2 ];

    (* Get lhs of equation *)
    Check[ 
      lhs = First[ getPart[ sys, posEquation ] ],
      isolateOneReduction::error1 = "could not get lhs";
      Throw[ Message[isolateOneReduction::error1] ]
    ];

    If[ dbg, Print["lhs: ", lhs ] ];
    newLhs =  redName[ lhs ]; 

    If[ dbg, Print["newLhs: ", newLhs] ];

    redEquation = getPart[ sys, pos ];
    If[ dbg, Print["reduction equation: ", redEquation ] ];

    (* This should be changed in Substitution.m *)
    res = addLocal[ sys, newLhs, pos, opts, contextDomain -> False ];
    If[ dbg, ashow[res] ]; res
  ]
];
isolateOneReduction::params = "wrong parameters";
isolateOneReduction[___] := Message[ isolateOneReduction::params ];

Clear[isolateReductions];
Options[ isolateReductions ] := { debug -> False, verbose -> False};
isolateReductions[ opts:___Rule ] :=
Module[ {temp},
  temp = $result;
  $result = 
    Check[ isolateReductions[ $result, opts ], temp ]
];

isolateReductions[sys:_system, opts:___Rule]:=
Catch[
  Module[ {redcases, dbg, vrb, savesys = sys, lhs, firstRed, res},
    dbg = debug /. {opts} /. Options[ isolateReductions ];
    vrb = verbose /. {opts} /. Options[ isolateReductions ];

    (* Initializing while loop *)
    (* Initialize result to sys *)
    res = sys;
    (* Get list of positions of reductions *)
    redcases = Position[ res, reduce[_,_,_] ];
    redcases = Select[ redcases, Length[#]>3& ];
    If[ dbg, Print["Initial reductions: ", redcases] ];

    While[ redcases =!= {},
      (* Get first position in reduction list *)
      firstRed = redcases[[1]];
      (* Get the corresponding lhs *)
      lhs = Apply[ Part, 
              Append[
                Prepend[ Take[firstRed,2], $result ], 1
	      ]
      ];
      If[ dbg, Print["lhs: ", lhs ] ];
      If[ vrb || dbg, Print["--- Isolating reduction in Definition of ",
			      lhs ] 
      ];

      Check[ res = isolateOneReduction[ res, firstRed, opts ],
           isolateReductions::error = "error while calling isolateReduction";
           Throw[ Message[ isolateReductions::error ]; savesys ]
      ];
      ashow[res];
      redcases = Position[ res, reduce[_,_,_] ];
      redcases = Select[ redcases, Length[#]>3& ];
      If[ dbg, Print["Reductions at end of loop: ", redcases] ]; 
    ]; (* for next loop *)
    res
  ]
];
isolateReductions::params = "wrong parameters";
isolateReductions[___] := Message[ isolateReductions::params ];

(* test *)
(* load["durbin.alpha"]; *)
(* pos = Part[getOccurs[$result,Alpha`reduce[_,_,_]],1] *)
(* spec = "Z.(k,i,N->k,i-1,N)" *)
(* serializeReduce[pos,spec]; *)
(* show[] *)


(************* split Reduce ******************************)
(* is currently not finished, it appears to be very complicated in 
   the general case, if someone ever needs it, we will certainly need
   to split the top operator after the reduce, and hence we must be
   able to restructurate the ast will algebraic rules *)

splitReduce::usage=
"splitReduce[sys:_system,pos:_List] tries to separate a reduce of 
sys into two reduce (for example, reduce(+,func,A+B+C) ->
reduce(+,func,A+B)+reduce(+,func,C)) and return
the resulting system. The position pos must be the position of the binop
around which the splitting is done. This should work for any reducible
operators. splitReduce[pos_List] apply on $result"

Clear[splitReduce];
splitReduce[pos_List]:=
  Module[{res},
	 res=splitReduce[$result,pos];
	 If[MatchQ[res,_system],
	    $result=res,
	    $result]]

splitReduce::WrongPos=" getPart[sys,`1`] should retrun a binop"
splitReduce::reduceNotFound="sorry, the position `1` is not in a
reduce"
splitReduce::wrongArg=" Wrong Argument for splitReduce"
splitReduce::WrongOp=" sorry, the operator of the reduction is `1` and
the splitting operator is `2`, they should be the same"

splitReduce[sys:_Alpha`system,pos_List]:=
Catch[
  Module[{},
	 expAst=getPart[sys,pos];
	 If [!MatchQ[expAst,_binop],
	     Message[splitReduce::WrongPos,pos];
	     Throw[sys]];
	 theOp=expAst[[1]];
	 posReduce=Map[Drop[#,-1] &,Position[sys,reduce]];
	 goodPosReduce=
	   Select[posReduce,Take[pos,Length[#]]===# &];
	 If [Length[goodPosReduce]=!=1,
	     Message[splitReduce::reduceNotFound,pos];
	     Throw[sys]];
	 thePosReduce=goodPosReduce[[1]];
	 astReduce=getPart[sys,thePosReduce];
	 If[(astReduce[[1]]=!=theOp)&&(astReduce[[1]]=!=minus||theOp=!=add),
	    Message[splitReduce::WrongOp,astReduce[[1]],theOp];
	    Throw[sys]];
	 (* the ast reduce[op,f,....binop[op,s1,s2]] is changed into 
	    reduce[op,f,....binop[op,s1,0(op)]]op reduce[op,f,s2] 
	    where 0(op) is the identity element of op *)
	 domS2=expDomain[sys,pos];
	 nbIndices=domS2[[1]];
	 expIndices=If[Head[domS2[[3,1]]]===Alpha`pol,domS2[[2]],domS2[[3,1,1,3]]];
	 identOp=opIdentity[theOp];
	 expIdentOp=
	   Alpha`affine[identOp,
	     Alpha`matrix[1,nbIndices+1,expIndices,
			  {Append[Table[0,{i,1,nbIndices}],1]}]];

	 newReduce1=ReplacePart[astReduce,
				expIdentOp,
				Append[Drop[pos,Length[thePosReduce]],3]];
	 newReduce2=Alpha`reduce[theOp,astReduce[[2]],expAst[[3]]];
	 newAst=Alpha`binop[theOp,newReduce1,newReduce2];
	 newAst>>/tmp/tt;
	 show[newAst];
	 newSys=ReplacePart[sys,newAst,thePosReduce[[1]]]
       ]
]

splitReduce[a___]:=splitReduce::wrongArg
End[]
EndPackage[]
