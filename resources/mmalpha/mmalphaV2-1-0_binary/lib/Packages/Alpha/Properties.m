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
BeginPackage["Alpha`Properties`", {"Alpha`Domlib`",
				   "Alpha`",
				   "Alpha`Matrix`",
				   "Alpha`Tables`",
				   "Alpha`Substitution`",
				   "Alpha`Normalization`"
				 }]

(* $Id: Properties.m,v 1.1 2005/03/11 16:40:17 trisset Exp $

   changelog:
     11/30/1993, Z. Chamski:	fixed documentation strings.
*)
(* Standard head for CVS

	$Author: trisset $
	$Date: 2005/03/11 16:40:17 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Properties.m,v $
	$Revision: 1.1 $
	$Log: Properties.m,v $
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.7  2004/09/16 13:46:51  quinton
	Updated version
	
	Revision 1.6  1999/05/05 11:00:05  risset
	corrected uniformQ
	
	Revision 1.5  1999/03/02 15:49:25  risset
	added GNU software text in each packages
	
	Revision 1.4  1997/05/19 10:41:22  risset
	corrected exported bug in depedancies

	Revision 1.3  1997/04/10 09:19:43  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.2  1996/06/24 13:54:51  risset
	added standard head comments for CVS



*)
Properties::note = 
"Documentation checked on August 8, 2004"; 

Properties::usage =
"The Alpha`Properties` package contains the definition of various 
property-checking functions. Should be used as the preferred place 
for adding new property-checking predicates that might be of large 
interest.";

Properties::note = 
"This package should probably merged with other packages such as
Tables, Substitution, etc.";

allDomEqualQ::usage =
"allDomEqualQ[domList] is True is all the domains in the list domList
are equal.";

allDomDisjointQ::usage =
"allDomDisjointQ[domList] is True if all the domains in a list domList
are two-by-two disjoint.";

allDomUnion::usage =
"allDomUnion[domList] returns the domain which is the union of the domains in
domList."

uniformQ::usage =
"uniformQ[sys] is True if the Alpha program sys is uniform 
(all dependences between local variables are translations), 
False otherwise. The default value of sys is $result. 
uniformQ can also be applied to an Alpha matrix or to 
an affine AST.";

Begin["`Private`"]

(* Checks if all the domains in the list are equal ... *)
(* a horrific function: doing C in Mathematica ; the domain list is supposed
   nonempty *)

Clear[allDomEqualQ];

allDomEqualQ[domList:{_Alpha`domain..}] :=
Block[
  {refDomain = First[domList],
   nextDomain = refDomain,
   remaining = Rest[domList]},

  While[Length[remaining] > 0,	(* while there's smthg to test ... *)
    nextDomain = First[remaining] ; (* check if first == crnt *)
    If[DomEqualQ[refDomain, nextDomain],
      remaining = Rest[remaining],
	 Return[False]
    ]
  ];	(* return FALSE if cond doesn't hold *)
  Return[True]
];			(* otherwise it's OK *)

allDomEqualQ[___] := Message[ allDomEqualQ::params ];

(* return a domain which is a union of a list of Domain  *)
Clear[ allDomUnion ];

allDomUnion[domList:{_Alpha`domain..}] :=
  Block[{refDomain = First[domList],
         nextDomain = refDomain,
         remaining = Rest[domList]},
        While[Length[remaining] > 0,    (* while there's smthg to union ... *)
              nextDomain = First[remaining] ; (* check if first == crnt *)
              refDomain=DomUnion[refDomain,nextDomain];
              remaining = Rest[remaining]];
        Return[refDomain]]

allDomUnion[___] := Message[ allDomUnion::params ];

(* Checks if the domains are two by two disjoint; first, computes the set of
   possible combinations (in terms of positions in the cartesian product
   list,) then computes two-by-two intersections until a nonempty one is found
   or the list is exhausted ; the positions are pairs of integers ; variable
   'unchecked' holds the list of pairs to be checked at any moment *)

Clear[allDomDisjointQ];

allDomDisjointQ[domList:{_Alpha`domain..}] :=
  With[{lg = Length[domList]},
       Block[{unchecked = FlattenAt[Table[Table[{i,j}, {j, i+1, lg}],
					  {i, 1, lg-1}],
				    Table[{k}, {k, 1, lg-1}]],
	      crnt},
	     crnt = First[unchecked] ;
	     While[Length[unchecked] > 0,
		   If[DomEmptyQ[
		     DomIntersection[domList[[crnt[[1]]]],
					    domList[[crnt[[2]]]]]],
		      (unchecked = Rest[unchecked] ;
		       crnt = First[unchecked]),
		      Return[False]]] ;
	     Return[True]]];

allDomDisjoint[___] := Message[ allDomDisjoint::params ];

(* check uniformity of a function (matrix), an affine expression, a definition
   or a whole program. Should be much smarter about pseudo-diffusions. *)

Clear[uniformQ];

uniformQ[m_Alpha`matrix] := translationQ[m];
					(* matrix: must be a translation *)

uniformQ[aff:Alpha`affine[exp_, fn_]] := uniformQ[fn];
					(* affine expresion: check the matrix
					   *)

uniformQ[Alpha`system[_,_,_,_,locals_,equas_]] :=
(* In a complete program, check only dependences between local variables *)
Module[ {listAllDepLocToLoc,listEqLocEqAll,
  (* apply uniformQ to loc-loc deps *)
  (* so you need to remove other ones *)
  locNames = Cases[locals, Alpha`decl[id_,_,_] -> id]},

  listEqLocEqAll =
    DeleteCases[equas, 
      Alpha`equation[name_ /;	!MemberQ[locNames,  name],_],
      Infinity
  ];
  (* Map[show,listEqLocEqAll]; *)
  listAllDepLocToLoc= 
    Flatten[Map[Cases[Part[#, 2],
		   Alpha`affine[var[name_ /; MemberQ[locNames, name]],
				mat_] -> mat, 
		   Infinity] &,     
	     listEqLocEqAll]
    ];
  (* Map[Print,listAllDepLocToLoc];
     Map[show,listAllDepLocToLoc]; *)
  Apply[ And, Map[uniformQ,listAllDepLocToLoc] ]
];

uniformQ[exp_] :=
  Apply[And, Map[uniformQ,
		 Cases[exp,
		       Alpha`affine[_, mat_Alpha`matrix] -> mat,
		       Infinity]]];

uniformQ[] := uniformQ[$result];

uniformQ::WrongArg="Wrong Argument for uniformQ";

uniformQ[a___]:=(Message[uniformQ::WrongArg];False)

End[]
EndPackage[]
