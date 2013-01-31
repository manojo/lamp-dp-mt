(* file: $MMALPHA/lib/Package/UniformizationTools.m
   AUTHOR :Manjunathaiah. M  
             University of Reading, U.K.
           and  Tanguy Risset
             IRISA, France
	     
	     The writing of this package has been supported by the 
	     SARACEN projet.

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

BeginPackage["Alpha`UniformizationTools`", {"Alpha`Domlib`",
					    "Alpha`",
					    "Alpha`Options`",
					    "Alpha`Matrix`",
					    "Alpha`Tables`",
					    "Alpha`Zpol`"}]



vecInBasisQ::usage="vecInBasisQ[vec_List,basis1_basis]
check if vector  `vec' is in the space indicated by `basis1'. `basis1Xs'
is in the format of the result of the findHermiteBasis[] function,
i.e. an integer `k' and a basis, vecInBasisQ checks whether the vector
is in the space spanned by the `k' first vectors of the basis. "

getVertices::usage= "getVertices[dom1_Alpha`domain] returns the list
of vertices of the domain `dom1' as a list of vectors
 (6 indices-> 6 components)"

getEqualities::usage = "getEqualities[dom1_Alpha`domain] returns the list
of equalities of the domain `dom1' as a list of vectors (6 indices-> 7 components)"

getLines::usage ="getLines[dom1_Alpha`domain] returns the list
of lines of the domain `dom1' as a list of vectors
 (6 indices-> 6 components)"

getBasis::usage = "getBasis[basis_basis] take as input a
basis in the format of the result of findHermiteBasis[] and returns
the basis (as row vectors) of the corresponding space.
findHermiteBasis gives column vectors and an integer indicating k that
the k first vectors are spanning the considered space, getBasis will
collect these k first column vectors and form a row matrix."

properSubspaceQ::usage = "properSubspaceQ[basis1_basis, basis2_basis] returns
True if subspace spanned by basis1 is included in subspace spanned by basis2
else False. the two basis are expresse in the format of the result of
the findHermiteBasis[] function"

intersectionBasisQ::usage = "intersectionBasisQ[basis1_basis, basis2_basis] 
returns True if the intersection of the input bases is not null and False
otherwise the two basis are expresse in the format of the result of
the findHermiteBasis[] function"

intersectionBasis::usage = "intersectionBasis[basis1_basis,
					      basis2_basis] 
returns a list of vectors that forms a basis for subspace of basis1 
intersection basis2. 
The inputs are specified the format of the result of
the findHermiteBasis[]. This is based on
algorithm from stage III report (????)."

domainBasis::usage ="domainBasis[adom_] returns an integral 
basis for a domain. The input
adom is specified in the Alpha's domain format. It is equivalent to 
findHermiteBasis, but return the resut in the form {_Integer,List[___List]}"

Begin["`Private`"]

intersectionBasis2::usage = "intersectionBasis[basis1_Matrix, basis2_Matrix] returns a list of vectors that forms a basis for subspace of basis1 intersection
basis2. The inputs are specified in hermite normal form"

DEBUG[level_, vargs__] := (Print["DBG : "]; Print[vargs];) /; ($SDEBUG > level)


(* general routines for computing on subspaces and compositions of subspaces *)


Clear[sumOfSubspaces]

sumOfSubspaces[basis1_ , basis2_] := Module[{sum, sumbasis},
(* invoke routine from Alpha package *)
  sum = findHermiteBasis[Append[basis1,basis2]];
  Return[sum];
]

getBasis[basis_] := Take[Transpose[basis[[2]]], {1, basis[[1]]}]; 

(* check if the dimension of space spanned by basis2 remains unaltered *)
properSubspaceQ[basis1:{_Integer,List[___List]}, basis2:{_Integer,List[___List]}] := Module[{newbas},
  Which[ 
  (* test for dimension inclusion *)
  basis1[[1]] > basis2[[1]], False,
  (* test for subspace inclusion *)
  True, (newbas = findHermiteBasis[Join[getBasis[basis1],getBasis[basis2]]];
          DEBUG[3, "properSubSpace : ", newbas];
          Return[newbas[[1]] === basis2[[1]]])
  ]
]

properSubspaceQ::WrongArg="Wrong Arg for properSubspaceQ"
properSubspaceQ[a___]:=(Message[ properSubspaceQ::WrongArg];Throw[$Failed])


intersectionBasisQ[basis1_, basis2_] := 
    properSubspaceQ[basis1, basis2] || 
    properSubspaceQ[basis2, basis1] ||
    (tmpbas = findHermiteBasis[Join[getBasis[basis1], getBasis[basis2]]] ; 
           (tmpbas[[1]] < (basis1[[1]] + basis2[[1]]))
    )


intersectionBasis2[basis1_, basis2_] :=   Which[
    properSubspaceQ[basis1, basis2], Return[basis2],
    properSubspaceQ[basis2, basis1], Return[basis1],
    True, Return[findHermiteBasis[Join[getBasis[basis1], getBasis[basis2]]]]
]


findBasis2[basis1_,basis2_] := Block[
  {OrthoComp1 = NullSpace[getBasis[basis1]],
  OrthoComp2 = NullSpace[getBasis[basis2]],
  sumbas, nbas},
  sumbas = findHermiteBasis[Join[OrthoComp1, OrthoComp2]];
  nbas = NullSpace[getBasis[sumbas]];
  (* cast it into hermite normal form before returning *)
  If[nbas === {}, Return[nbas], Return[findHermiteBasis[nbas]]];
]

intersectionBasis[basis1_, basis2_] := Which[
    properSubspaceQ[basis1, basis2], Return[basis1],
    properSubspaceQ[basis2, basis1], Return[basis2],
    True, Return[findBasis2[basis1, basis2]]
]



(* get vertices of a polyhedra *)
Clear[getVertices];

getVertices[adom_] := Module[{vertices},
  (* do vertex  normalization *)
  xver[vert_] := Return[Drop[Drop[Map[#/Last[vert] &, vert], 1], -1]];

  (* identify the vertices *)
  vertices = Select[adom[[3]][[1]][[6]], 
                    (First[#] === 1 && Last[#] =!=  0 &) ];

  Return[Map[xver[#] &, vertices]];
]

(* get rays of a polyhedra; including the lines as well *)
Clear[getRays];
getRays[adom_] := rays[adom]; 




Clear[getEqualities];
getEqualities[adom_] := Return[Map[Drop[#, 1] &,
                   Select[adom[[3]][[1]][[5]], 
                    (First[#]  ==  0 &)]]];

Clear[getLines];
getLines[adom_] := Return[Map[Drop[Drop[#, 1], -1] &,
                   Select[adom[[3]][[1]][[6]], 
                    (First[#]  ==  0 &)]]];

(* compute a basis for the  subspace lin(domain) *)
Clear[domainBasis];
domainBasis[adom_] := Module[{tmat,vmat},
  (* to handle special cases of a single vertex which
     findHermiteBasis does not handle properly  *)
  If[Length[getRays[adom]] === 0 && Length[getVertices[adom]] === 1,
    (* pass the vertices *)
    Return[findHermiteBasis[getVertices[adom]]],
    (* else pass the domain *)
    tmat = findHermiteBasis[adom];
    Return[{Part[tmat,1], alphaToMmaMatrix[Part[tmat,2]]}];
  ]
]

Clear[vecInBasisQ];
(* True if vec \in basis; false otherwise *)
vecInBasisQ[vec_,basis_] := 
  With[{tmpb = findHermiteBasis[Transpose[Append[getBasis[basis], vec]]]},
       Return[tmpb[[1]] === basis[[1]]];
]
vecInBasisQ::WrongArg="Wrong Arg for vecInBasisQ"
vecInBasisQ[a___] :=(Message[ vecInBasisQ::WrongArg];Throw[$Failed])

End[] 
EndPackage[]
