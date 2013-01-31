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
(*
        $Author: trisset $
        $Date: 2005/03/11 16:40:17 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Lexicographic.m,v $
        $Revision: 1.1 $
        $Log: Lexicographic.m,v $
        Revision 1.1  2005/03/11 16:40:17  trisset
        added all remaining packages to V2

        Revision 1.2  1999/04/26 12:30:04  quillere
        removed Alpha`Tools` need

        Revision 1.1  1999/04/26 09:19:51  quillere
        added temporary AppSched packages -- will have dispatch it

*)

BeginPackage["Alpha`Lexicographic`"];

Unprotect[domLexGreater, domLexLower,
	  lexLowerQ, lexGreaterQ,
	  lexLowerOrEqualQ, lexGreaterOrEqualQ];

 domLexGreater::usage = "domLexGreater[v:_Matrix] returns a domain D
such that for all z in D, z>v, where > means lexicographically greater. V is a
parametrized vertex. If v is a n*(p+1) matrix, D is a n+p domain, and the p last
dimensions are parameter dimensions. Example: domLexGreater[{{1,0},{0,2}}]
returns {a,b,c | c+1<=a} | {a,b,c | a=c; 3<=b}, where c is the parameter index.
domLexGreater[v:_Vector] is a shortcut for 0-dimensional parameter
space. (i.e. domLexGreater[{0,0,1}] means domLexGreater[{{0},{0},{1}}].";

 domLexLower::usage = "domLexLower[v:_Matrix] returns a domain D
such that for all z in D, z<v, where < means lexicographically lower. V is a
parametrized vertex. If v is a n*(p+1) matrix, D is a n+p domain, and the p last
dimensions are parameter dimensions. Example: domLexLower[{{1,0},{0,2}}]
returns {a,b,c | a<=c-1} | {a,b,c | a=c; b<=1}, where c is the parameter index.
domLexLower[v:_Vector] is a shortcut for 0-dimensional parameter
space. (i.e. domLexLower[{0,0,1}] means domLexGreater[{{0},{0},{1}}].";

 lexGreaterQ::usage = "lexGreaterQ[a:_Matrix, b:_Matrix, p:_domain] returns True 
if a is lexicographicallygreater than b for any value of parameters in p. a and b 
are parametrized vectors.";

 lexGreaterOrEqualQ::usage = "lexGreaterOrEqualQ[a:_Matrix, b:_Matrix,
p:_domain] returns True if a is lexicographically greater or equal than b for
any value of parameters in p. a and b are parametrized vectors.";

 lexLowerQ::usage = "lexLowerQ[a:_Matrix, b:_Matrix, p:_domain] returns True 
if a is lexicographically lower than b for any value of parameters in p. a and b 
are parametrized vectors.";

 lexLowerOrEqualQ::usage = "lexLowerOrEqualQ[a:_Matrix, b:_Matrix, p:_domain]
returns True if a is lexicographically lower or equal than b for any value of
parameters in p. a and b are parametrized vectors.";

Begin["`Private`"];

Needs["Fail`"];
Needs["Alpha`"];
Needs["Alpha`Domlib`"];

(* === *)

 Lexicographic::wrongArg = "`1`";

(* === *)

Clear[domLexGreater];

 domLexGreater::wrongArg = Lexicographic::wrongArg;

domLexGreater[
 v:{__Integer}] := 
  Catch[domLexGreater[v,Length[v]]];

domLexGreater[
 v:{__Integer},
 k:_Integer] :=
  Catch[domLexGreaterOrLower[List/@v,k,1]];

domLexGreater[
 v:_?MatrixQ] :=
  Catch[domLexGreater[v,Length[v]]];

domLexGreater[
 v:_?MatrixQ,
 k:_Integer] :=
  Catch[res = domLexGreaterOrLower[v,k,1]];

domLexGreater[a___] :=
  Module[{},
	 Message[domLexGreater::wrongArg, {a}];
	 $Failed
	 ];

(* === *)

Clear[domLexLower];

 domLexLower::wrongArg = Lexicographic::wrongArg;

domLexLower[
 v:{__Integer}] := 
  Catch[domLexLower[v,Length[v]]];

domLexLower[
 v:{__Integer},
 k:_Integer] :=
  Catch[domLexGreaterOrLower[List/@v,k,-1]];

domLexLower[
 v:_?MatrixQ] :=
  Catch[domLexLower[v,Length[v]]];

domLexLower[
 v:_?MatrixQ,
 k:_Integer] :=
  Catch[domLexGreaterOrLower[v,k,-1]];

domLexLower[a___] :=
  Module[{},
	 Message[domLexLower::wrongArg, {a}];
	 $Failed
	 ];

(* === *)

(* this is the core. sign controls the function:
    1 -> computes domLexGreater
   -1 -> computes domLexLower *)

Clear[domLexGreaterOrLower];

 domLexGreaterOrLower::kdim = "k is larger than length(v) (`2` > `1`).";

domLexGreaterOrLower[
 v:_?MatrixQ,
 k:_Integer,
 sign:(1|-1)] :=
  Module[{dim=Length[v], p = Length[First[v]]-1, l, lm},
	 If[k>dim || k<1,
	    Message[domLexGreaterOrLower::kdim, Length[v], k]; $Failed,
	    lm = Table[matrix[l,dim+p+2, indexList[dim+p],
			      MapThread[Join,
					{Join[Array[{0}&, l-1],
					      {{1}}],
					 sign*Take[IdentityMatrix[dim],
						   l],
					 -sign*Take[v,l]+
					 Join[
					   Array[0&, {l-1, p+1}],
					   {Join[Array[0&, p], {-1}]}
					   ]
					 }
					 ]
			      ],
			      {l,1,k}];
	    lm = DomConstraints /@ lm;
	    Fold[DomUnion, First[lm], Rest[lm]]
	  ]
       ];

domLexGreaterOrLower[a___] :=
  Throw[$Failed];

(* === *)

Clear[lexGreaterQ];

 lexGreaterQ::failed = "";
 lexGreaterQ::wrongArg = Lexicographic::wrongArg;
 lexGreaterQ::dim = "matrices mismatch.";
 lexGreaterQ::param = "matrices and param mismatch.";
 lexGreaterQ::domimage = "failed.";

lexGreaterQ[
  a:_/;MatrixQ[a, IntegerQ],
  b:_/;MatrixQ[b, IntegerQ],
  p:_domain] :=
  verbFail[lexGreaterQ::failed,
    Catch[
      With[{strict = chkFail[domLexLower[{1}]],
	    nonStrict = chkFail[domLexLower[{0}]]},
	   lexGreaterOrLowerQ[a, b, p, strict, nonStrict, lexGreaterQ, False]
	 ]
    ]
  ];

lexGreaterQ[a___] :=
  Module[{},
	 Message[lexGreaterQ::wrongArg, {a}];
	 $Failed
       ];
  
(* === *)

Clear[lexGreaterOrEqualQ];

 lexGreaterOrEqualQ::failed = "";
 lexGreaterOrEqualQ::wrongArg = Lexicographic::wrongArg;
 lexGreaterOrEqualQ::dim = "matrices mismatch.";
 lexGreaterOrEqualQ::param = "matrices and param mismatch.";
 lexGreaterOrEqualQ::domimage = "failed.";

lexGreaterOrEqualQ[
  a:_/;MatrixQ[a, IntegerQ],
  b:_/;MatrixQ[b, IntegerQ],
  p:_domain] :=
  verbFail[lexGreaterOrEqualQ::failed,
    Catch[
      With[{strict = chkFail[domLexLower[{1}]],
	    nonStrict = chkFail[domLexLower[{0}]]},
	   lexGreaterOrLowerQ[a, b, p, strict, nonStrict, lexGreaterOrEqualQ, True]
	 ]
    ]
  ];
  
lexGreaterOrEqualQ[a___] :=
  Module[{},
	 Message[lexGreaterOrEqualQ::wrongArg, {a}];
	 $Failed
       ];
  
(* === *)

Clear[lexLowerQ];

 lexLowerQ::failed = "";
 lexLowerQ::wrongArg = Lexicographic::wrongArg;
 lexLowerQ::dim = "matrices mismatch.";
 lexLowerQ::param = "matrices and param mismatch.";
 lexLowerQ::domimage = "failed.";

lexLowerQ[
  a:_/;MatrixQ[a, IntegerQ],
  b:_/;MatrixQ[b, IntegerQ],
  p:_domain] :=
  verbFail[lexLowerQ::failed,
    Catch[
      With[{strict = chkFail[domLexGreater[{-1}]],
	    nonStrict = chkFail[domLexGreater[{0}]]},
	   lexGreaterOrLowerQ[a, b, p, strict, nonStrict, lexLowerQ, False]
	 ]
    ]
  ];
  
lexLowerQQ[a___] :=
  Module[{},
	 Message[lexLowerQ::wrongArg, {a}];
	 $Failed
       ];
  
(* === *)

Clear[lexLowerOrEqualQ];

 lexLowerOrEqualQ::failed = "";
 lexLowerOrEqualQ::wrongArg = Lexicographic::wrongArg;
 lexLowerOrEqualQ::dim = "matrices mismatch.";
 lexLowerOrEqualQ::param = "matrices and param mismatch.";

lexLowerOrEqualQ[
  a:_/;MatrixQ[a, IntegerQ],
  b:_/;MatrixQ[b, IntegerQ],
  p:_domain] :=
  verbFail[lexLowerOrEqualQ::failed,
    Catch[
      With[{strict = chkFail[domLexGreater[{-1}]],
	    nonStrict = chkFail[domLexGreater[{0}]]},
	   lexGreaterOrLowerQ[a, b, p, strict, nonStrict, lexLowerOrEqualQ, True]
	 ]
    ]
  ];
  
lexLowerOrEqualQ[a___] :=
  Module[{},
	 Message[lexLowerOrEqualQ::wrongArg, {a}];
	 $Failed
       ];
  
(* === *)

Unprotect[lexGreaterOrLowerQ];

Clear[lexGreaterOrLowerQ];

lexGreaterOrLowerQ[
  a:_/;MatrixQ[a, IntegerQ],
  b:_/;MatrixQ[b, IntegerQ],
  p:_domain,
  strict:_domain,
  nonStrict:_domain,
  function:(lexGreaterQ|lexLowerQ|lexGreaterOrEqualQ|lexLowerOrEqualQ),
  orEqual:(True|False)] :=
  Catch[
    With[{pdim = p[[1]]},
	 If[Length[a] =!= Length[b],
	    Message[function::dim]; Throw[$Failed]];
	 If[Not[Length[First[a]] === Length[First[b]] === pdim+1],
	    Message[function::param]; Throw[$Failed]];
	 With[{v = First[a]-First[b]},
	      Module[{mat, dom, strictly, nonStrictly},
		     mat = matrix[2, pdim+1, p[[2]], 
				  {v, Append[Array[0&, pdim], 1]}];
		     dom = DomImage[p, mat];
		     strictly := DomEmptyQ[DomIntersection[strict, dom]];
		     nonStrictly := DomEmptyQ[DomIntersection[nonStrict, dom]];
		     If[Rest[a] === {},
			If[orEqual, nonStrictly, strictly],
			Or[strictly, And[nonStrictly,
				      lexGreaterOrLowerQ[Rest[a], Rest[b],
							 p, strict,
							 nonStrict,
							 function,
							 orEqual]]]
		      ]
		   ]
	    ]
       ]
  ];
  
lexGreaterOrLowerQ[a___] :=
  Module[{},
	 Print["lexGreaterOrLowerQ"];
	 Scan[Print, {a}];
	 Throw[$Failed]
       ];

Protect[lexGreaterOrLowerQ];

(* === *)

Clear[indexList];

indexList[
 size:_Integer] :=
  With[{code = First[ToCharacterCode["a"]]},
	 Array[FromCharacterCode[code-1+#]&, {size}]
     ];

indexList[a___] := Throw[$Failed];

End[];

Unprotect[domLexGreater, domLexLower,
	  lexGreaterQ, lexLowerQ,
	  lexLowerOrEqualQ, lexGreaterOrEqualQ];

EndPackage[];
