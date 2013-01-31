(* file: $MMALPHA/lib/Package/Alpha/CodeGen/Restrict.m
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
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/CodeGen/Restrict.m,v $
        $Revision: 1.1 $
        $Log: Restrict.m,v $
        Revision 1.1  2005/03/11 16:41:33  trisset
        added codeGen to V2

        Revision 1.4  2002/01/18 14:04:57  risset
        corrected a bug in INorm and rewrite in imperative form fabien's functionnal code.... (no comment)

        Revision 1.3  2001/06/21 16:05:59  risset
        new codeGen from Induraj

        Revision 1.2  1999/05/28 14:53:24  quillere
        added CVS header and GNU info

*)

BeginPackage["Alpha`CodeGen`Restrict`"];

Unprotect[mkRestrict];
Unprotect[mkRestrictExpr];

 mkRestrict::usage = "mkRestrict[d:_domain, pdim:_Integer, 
pval:{___Rule}, code:_] generates a c if statment which tests that the 
constraints of d are satisfied. pdim is the parameter space, pval is
the list of parameter value specifications (see ?cGen for details) and 
code is to be inserted as body: if (d is satisfied) { code }.For multiple 
polyhedra p(i) in d,above becomes: if( p(1)satisfied || p(2)satisfied...){ code }";

mkRestrictExpr::usage = "mkRestrictExpr[d:_domain, idx,pdim:_Integer, 
pval:{___Rule}, code:_, code2:_] generates a c (? :) statment which tests that the 
constraints of d are satisfied. pdim is the parameter space, pval is
the list of parameter value specifications (see ?cGen for details) and 
code is to be inserted as body:  (d is satisfied)? code_1 : code_2 .For multiple 
polyhedra p(i) in d,above becomes: ( p(1)satisfied || p(2)satisfied...)? code_1 : code_2";


Begin["`Private`"];
Needs["Alpha`"];
Needs["Alpha`Domlib`"];
Needs["Alpha`CodeGen`Output`"];

(* === *)

Clear[mkRestrict];

 mkRestrict::wrongArg = "`1`";

 mkRestrict::param = "param dim (`3`) + level (`2`) is greater than
domain dim (`1`).";
 mkRestrict::noBounds = "no lower or upper bound for polyhedron";


mkRestrict[
 d:_domain,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 code:_] :=
  Module[{ testl,testllist},
	 If[DomEmptyQ[d],
	    Message[mkRestrict::empty]; Throw[$Failed]];
	
	(*-for each polyhedra of domain get list of checks-*)

	 testlist = hseq@@Map[ mkTest[#, pdim, pval, d[[2]]]& , d[[3]] ];
	
	(*-the testl has "testpoly1 || testpoly2 ||..." for multiple polyhedra in domain-*)

	 If[Length[d[[3]]]>1,
	   testl = hseq@@Join[ToString[testlist[[1]]],Map[StringJoin[ToString[" || "],ToString[#]]&,Rest[testlist]]],
	   testl = hseq@@testlist];
	   
	 Which[testl === hseq[False],
	       deadCode,
	       testl === hseq[True],
	       code,
	       True,
	       block[hseq[" if (", testl, ")"],
		     code
		     ]
	     ]
       ];

mkRestrict[a___] :=
  Module[{},
	 Message[mkRestrict::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)


Clear[mkRestrictExpr];

 mkRestrictExpr::wrongArg = "`1`";

 mkRestrictExpr::param = "param dim (`3`) + level (`2`) is greater than
domain dim (`1`).";
 mkRestrictExpr::noBounds = "no lower or upper bound for polyhedron";


mkRestrictExpr[
 d:_domain,
 idx:List[___],
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 code:_,
 code2:_] :=
  Module[{dom , testl,testllist,ruleIndx,length},
	 If[DomEmptyQ[d],
	    Message[mkRestrictExpr::empty]; Throw[$Failed]];

	 (* replace indices of domain *)
	 length = Min[Length[d[[2]]],Length[idx]];
	 ruleIndx = MapThread[Rule[#1,#2]&,{Take[d[[2]],{1,length}],Take[idx,{1,length}]}];
	 dom=d/.ruleIndx;
	
	(*-for each polyhedra of domain get list of checks-*)

	 testlist = hseq@@Map[ mkTest[#, pdim, pval, dom[[2]]]& , dom[[3]] ];
	
	(*-the testl has "testpoly1 || testpoly2 ||..." for multiple polyhedra in domain-*)

	 If[Length[dom[[3]]]>1,
	   testl = hseq@@Join[ToString[testlist[[1]]],Map[StringJoin[ToString[" || "],ToString[#]]&,Rest[testlist]]],
	   testl = hseq@@testlist];
	
	 Which[testl === False,
	       deadCode,
	       testl === True,
	       code,
	       True,
	       hseq[hseq["(",testl, ") ? ",code,":","\n"],hseq["\t",code2]]
	       
	     ]
  ];

mkRestrictExpr[a___] :=
  Module[{},
	 Message[mkRestrictExpr::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

Unprotect[mkTest];
usage="go nothing" ;

Clear[mkTest];

 mkTest::wrongArg = "`1`";

mkTest[
 p:_pol,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 idx:List[__String]] :=
  Apply[And, Map[mkTest[#, pdim, pval, idx]&, p[[5]]]];


mkTest[
 v:List[__Integer],
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 idx:List[__String]] :=
  With[{ctrl = First[v]},
       With[{vect = Rest[v].Append[symbol/@idx, 1] /. pval /. symbol[x:_Integer]->x},
	      If[ctrl==1,
		 GreaterEqual[vect, 0],
		 Equal[vect, 0]
	       ]
	    ]
     ];

mkTest[a___] :=
  Module[{},
	 Message[mkTest::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[mkTest];

(* === *)

End[];

Protect[mkRestrict];
Protect[mkRestrictExpr];
EndPackage[];
