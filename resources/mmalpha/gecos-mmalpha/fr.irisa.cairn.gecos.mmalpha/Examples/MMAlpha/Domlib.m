(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Doran Wilde
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
        $Author: risset $
	$Date: 2004/06/16 15:14:05 $
	$Source: /udd/alpha/CVS/alpha_beta/Mathematica/lib/Packages/Alpha/newPackages/Domlib.m,v $
	$Revision: 1.1 $
	$Log: Domlib.m,v $
	Revision 1.1  2004/06/16 15:14:05  risset
	added new and old Packages
	
	Revision 1.45  2004/04/23 15:35:23  quinton
	dos2unixed version.
	
	Revision 1.44  2003/07/18 12:52:39  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.42  2003/07/02 07:58:50  risset
	added Modifications for Zpolyhedra
	
	Revision 1.40  2002/10/21 08:21:13  quinton
	DomExtend was modified so that it is not necessary that the domain index
	be the same as the first indexes of the extension indexes. Hope this does not
	create any problem. This modification was necessary for codeGen.
	
	Revision 1.39  2002/09/12 14:47:21  risset
	commit after patrice update and correction of Pipecontrol
	
	Revision 1.38  2002/09/04 16:23:40  quinton
	Correction of some bugs in DomImage.
	
	Revision 1.37  2002/09/04 11:19:55  risset
	corrected a slight bug in the indexe mechanism for DomImage
	
	Revision 1.36  2002/07/17 09:12:29  quinton
	Removed a forgotten trace...
	
	Revision 1.35  2002/07/16 09:44:39  quinton
	Function DomImage was modified, so as to get as readable indexes
	as possible. The heuristics is as follows. An original index name is kept
	whenever on find an identity component in the linear function. For example,
	if the linear function is (i,j,k->j+1,k+1), then the first component j+1 is an
	identity function (plus 1), and the second component also. So the new
	indexes become (j,i).
	
	Revision 1.34  2002/06/07 12:00:27  quinton
	DomConvex was modified to cover the case when the domain
	is empty.
	
	Revision 1.33  2002/05/28 08:23:46  risset
	corrected a bug in getContextDomain: use of DomImage[dom,mat,params]
	
	Revision 1.32  2002/01/17 10:29:47  risset
	modify the Pipeline.m package for pipall with boundary
	
	Revision 1.31  2001/08/23 13:11:55  risset
	merged with conflict
	
*)

BeginPackage["Alpha`Domlib`"];

DomLib::usage = "Library of domain functions:
		DomIntersection[d1, d2]
		DomUnion[d1, d2]
		DomDifference[d1, d2]
		DomSimplify[d1, d2]
		DomConvex[d]
		DomImage[d, m]
                DomZImage[d,m]
                DomZPreimage[d,m]
		DomPreimage[d, m]
                LatticeHermite[m]
                LatticeIntersection[m1,m2]
                LatticeDifference[m1,m2]
                LatticePreimage[m1,m2]
                LatticeImage[m1,m2]
		DomConstraints[m]
		DomRays[m]
		DomUniverse[n]
		DomEmpty[n]
		DomUniverseQ[d]
                DomEmptyQ[d]
		DomEqualQ[d1, d2]	
                DomCost[d, c]
		DomRightHermite[m]
		DomLeftHermite[m]
		DomBasis[m]
		DomMatrixSimplify[m1,m2]
		DomAddRays[d1,m2]
		DomVisual[d1,d2]
		DomLTQ[d1,d2,idx,pdim]
		DomSort[l,idx,pdim,time]
		DomIntEmptyQ[d1,d2]"

domlib::usage =
"Math link. Link to the external program \"domlib\" which implements domain
operators. Contains the definition of several functions...";

DomIntersection::usage = "DomIntersection[d1, d2]
	returns the domain intersection of domains d1 and d2."

DomUnion::usage = "DomUnion[d1, d2]
	returns the domain union of domains d1 and d2."

DomDifference::usage = "DomDifference[d1, d2]
	returns the domain difference of domain d1 less d2."

DomSimplify::usage = "DomSimplify[d1, d2]
	returns a domain equal to d1 simplified in the context of d2."

DomConvex::usage = "DomConvex[d]
	returns the minimum convex polyhdron which encloses (polyhedral or Z) 
	domain d. Warning (4/11/98), this function was bugged in Polylib, 
	current	implementation uses DomRays instead of DomConvex"

DomImage::usage = "DomImage[d,m] returns the image of domain d under transformation 
matrix m. This function will always return a polyhedral domain. For a ZDomain, it returns 
the image of the rational polyhedral domain enclosing the ZDomain"

DomPreimage::usage = "DomPreimage[d,m] returns the preimage of domain d under 
transformation matrix m. This function will always return a polyhedral domain. For a
ZDomain, it returns the pre-image of the rational polyhedral domain enclosing the ZDomain"

LatticeHermite::usage = "LatticeHermite[m]
	returns the Lattice in Hermite Normal Form."

LatticeIntersection::usage = "LatticeIntersection[m1,m2]
	returns the Intersection of Lattices m1 and m2."

LatticeDifference::usage = "LatticeDifference[m1,m2]
	returns the Difference of Lattices m1 and m2."

LatticePreimage::usage = "LatticePreimage[m1,m2]
	returns the Preimage of Lattice m1 by the function m2."

LatticeImage::usage = "LatticeImage[m1,m2]
	returns the Image of Lattices m1 by the function m2."

DomConstraints::usage = "DomConstraints[m]
	returns the minimum convex polyhdron defined by constraints in matrix m.
	DomConstraints[m1,m2] returns the Zpolyhedra obtained by image
        of Polyhedra P by invertible mapping a, and P is the minimum convex
        Polyhedra satisfying constraints given in b;
	Z = m1(DomConstraints[m2])"

DomRays::usage = "DomRays[m]
	returns the minimum convex polyhdron defined by rays in matrix m."

DomUniverse::usage = "DomUniverse[n]
	returns the universe domain of dimension n."

DomEmpty::usage = "DomEmpty[n]
	returns the empty domain of dimension n."

DomUniverseQ::usage = "DomUniverseQ[d]
	returns True if domain d is the universe, False otherwise."

DomEmptyQ::usage = "DomEmptyQ[d]
	returns True if domain d is empty, False otherwise."

DomEqualQ::usage = "DomEqualQ[d]
	returns True if domain d1 is equivilant to d2, False
	otherwise."


DomRightHermite::usage = "DomRightHermite[m]
	returns {Q, H} where m = QH, Q unimodular, H
	hermite. (Warning, bugged function please use hermiteR[]) "
  
DomLeftHermite::usage = "DomLeftHermite[m]
        returns {H, Q} where m = HQ, Q unimodular, H hermite.
(Warning, bugged function please use hermiteL[])"

DomBasis::usage = "DomBasis[m]
	returns a row basis of m (Gauss Jordan-elimination)" 

DomMatrixSimplify::usage = "DomMatrixSimplify[m1,m2]
        returns m1 simplified in the presence of m2."

DomAddRays::usage = "DomAddRays[d1,m2]
        returns the domain d1 augmented with rays from matrix m2. rays
        are in Alpha format (i.e. n+2 components for n
        dimensions). Example: d1 is {i,j | i >= 0}, mat1=matrix[3, 4,
        {}, {{1, 0, 1, 0}, {1, 10, 10, 1}}],
        DomAddRays[d1,mat1] gives {i,j | 0<=i<=(j,10)}"


DomExtend::usage = 
"DomExtend[dom_Alpha`domain, idx_List] extends  dom to the indices in
the index list idx. This list should contains the indices of dom.";

DomEqualities::usage = 
"DomEqualities[d] returns the matrix of equations (lineality space) of
domain d (does not handle union of convexes).";

DomProject::usage =  
"DomProject[dom_Alpha`domain, idx:{__String}] projects dom onto the indices
in the index list idx. Reorders indices and changes the dimension
accordingly.";

DomLTQ::usage = "DomLTQ[dom1_domain, dom2_domain,
idx_Integer, pdim_Integer] compares dom1 and dom2 at index position
idx. pdim is the dimension of the parameter space. Returns 1 if
dom1>dom2, returns -1 if dom1<dom2, returns 0 if dom1><dom2.";

DomSort::usage = "DomSort[l:{__domain}, idx:_Integer, pdim:_Integer,
time:True|False] returns the topological order of the list of domains
l; idx is the level to consider for sorting, pdim is the parameter
space dimension. Returns a list of logical times (one per
domain) if time is True, else returns a list permutation of l
(application of this permutation to l returns a sorted list).";

DomIntEmptyQ::usage = "DomIntEmptyQ[dom1_Alpha`domain, dom2_Alpha`domain]
	returns True if dom1 contains no integer points in the context of
	dom2, else returns False.";

DomZImage::usage = "DomZImage[domain, matrix]. Finds the ZImage of the domain by the matrix.
This function may or may not return a ZDomain depending on the transformation matrix";

DomZPreimage::usage ="DomZPreimage[domain, matrix]. Finds the ZPreimage of 
the domain by the matrix. This function may or may not return a ZDomain depending on 
the transformation matrix";

DomVertices::usage = "DomVertices[domain, context] finds the
parametrized vertices of a list of parametrized polyhedra (the
domain). context is the domain of parameters. It returns a list of
couples. Each element of this list contains a parameter domain, and a
list of parametrized vertices. DomVertices[polyhedron,parameter]
finds the parametrized vertices of a parametrized polyhedron, given a
parameter polyhedron. DomVertices[polyhedron], finds the vertices of
the non-parametrized polyhedron; it returns {{e,l}} where e is the
universe 0-domain and l is a list of non-parametrized vertices.";


linearExpQ::usage = "linearExpQ[exp,{symbols}] is True if exp is a linear expression 
formed with symbols, False otherwise.";

linearConstraintQ::usage = 
"linearConstraintQ[c,{symbols}] is True if c is a linear constraint
formed with symbols, False otherwise."; 

linearConstraintQ::notalinearc = "`1` is not a linear constraint on variables `2`";

linHalfSpace::usage = 
"linHalfSpace[h] returns the mma Matrix corresponding to the Alpha
half-space `h'"; 

linHalfSpace::arg = "argument is not a Half Space";

const2mma::usage = 
"const2mma[indexList,vectorList] converts a constraint, expressed as a list of 
index names and a list of vectors, into Mathematica form";

const2mma::typeError = 
"parameters: `1` should be an index list (free mma symbols) and a list of integers";

dom2mma::usage = 
"dom2mma[d] converts Alpha domain d into a pair {constraints,index} (e.g.
{{i,j},{i+j>=2,...}}) suitable for MMa"; 

dom2mma::typeError = "parameter should be a domain. Note: dom2mma does not 
handle union of domains, for the moment.";

dom2mma::wrgdom = "error while calling const2mma. Input domain seems to be incorrect.";

dom2al::usage = 
"dom2al[{cst,ind}] translates a domain given in MMA
form into its alpha encoding. `ind' is a list of indexes, and `cst' is
a list of constraints of the form i+j > 2. Warning: left-hand side is
the linear part, and right-hand side is an integer."

dom2al::typeErr = "parameters should be {constraint,index}";
dom2al::cst2l = "error when calling internal function const2al.";
dom2al::domcpr = "error when calling internal function domCompRays.";
const2al::usage = 
"const2al[ind,c] translates in alpha form constraint `c' of the mma
form. `ind' is an index list (e.g. \{i,j\}) and c is a constraint in
form `eq[i+2j,3]'"

domCompRays::usage = 
"domCompRays[dom] recomputes the rays of the Alpha domain `dom' and
returns an Alpha domain. domCompRays ignores the ray part of `dom', and
recomputes it. This function allows one to modify a ray in a domain,
and to update the domain accordingly.";

domCompRays::arg = "parameter should be an Alpha domain";

domHalfSpaceQ::usage = 
"domHalfSpaceQ[dom] is True if Alpha domain `dom' is a half-space. `dom' is either a String or an Ast";

domHalfSpaceQ::arg = "parameter should be an Alpha domain";

hypercube::usage = "hypercube[n] creates a hypercubic domain (in mma form) 
of dimension n, and size 10. dom2l[hypercube[n]] allows such a domain to 
be translated into alpha form. Useful for testing purposes"; 

hypercube::typeError = "wrong arguments.";

vertices::usage = "vertices[d] returns the list of vertices of Alpha domain
d. vertices[{const,index}] returns the vertices of domain given in MMA form.";

vertices::typeError = "parameter should be a domain either in Alpha or in MMA form";

rays::usage = "rays[d] returns the list of rays of Alpha domain
d. rays[{const,index}] returns the vertices of domain given in MMA form.";

polToZpol::usage = "If domain d is a union of polyhedra, polToZpol[d] returns the
equivalent Z-polyhedra, otherwise it returns the domain as such.";

zpolToPol::usage = "If domain d is a ZDomain, zpolToPol[d] will return the rational
polyhedral domain enclosing the ZDomain, otherwise it returns the domain as such.";
zpolIsPolQ::usage = "zpolIsPolQ[d:domain] returns true if the zpolyehdron retruned is actually a polyhedron (i.e. has identity matrices as lattices)"

rays::typeError = "parameter should be a domain either in Alpha or in MMA form";

Begin["`Private`"]

(* zpolIsPolQ check whether a zpolhedron is a real polyhedron, this function is used by DomZimage to change the result to a polyhedron when possible *)

Clear[polToZpol];
polToZpol::params = "wrong parameters"
polToZpol[a:Alpha`domain[0,_,_]] := a;
polToZpol[po:Alpha`domain[dim_Integer,id_List,p:{_Alpha`pol..}]] :=
        Alpha`domain[dim,{},{Alpha`zpol[Alpha`matrix[dim+1,dim+1,id,IdentityMatrix[dim+1]],p]}];
polToZpol[a_Alpha`domain] := a;
polToZpol[___] := Message[PtoZ::params];

(* maybe one should convexize the domain returned by zpolToPol *)
Clear[zpolToPol];
zpolToPol::params = "wrong parameters";
zpolToPol[zp:Alpha`domain[dim_Integer,id_List,z:{_Alpha`zpol..}]] :=
	Alpha`domain[dim,z[[1,1,3]],Flatten[Map[DomImage[Alpha`domain[dim,#[[1,3]],#[[2]]],#[[1]]][[3]] &,z]]];
zpolToPol[a_Alpha`domain] := a;
zpolToPol[___] := Message[ZtoP::params];


Clear[ zpolIsPolQ];
 zpolIsPolQ::params = "wrong parameters";
 zpolIsPolQ[zp:Alpha`domain[dim_Integer,id_List,z:{_Alpha`zpol..}]] :=
Module[{listZpol,curZpol,curMat,curDeterminant},
       listZpol=z;
       res=Catch[Do[
		    curZpol=listZpol[[i]];
		    curMat=curZpol[[1]];
		    If[curMat[[1]]=!=curMat[[2]],
		       (* not square matrix *) 
		       Throw[False],
		       (* square matrix *)
		       curDeterminant=Det[curMat[[4]]];
		       If[Abs[curDeterminant]=!=1,
			  Throw[False],
			  True]]
		       ,{i,1,Length[listZpol]}];
		 Throw[True];
       ];
       res]

zpolIsPolQ[zp:Alpha`domain[dim_Integer,id_List,z:{_Alpha`pol..}]] := True

zpolIsPolQ[$Failed] := $Failed

zpolIsPolQ[___] := Message[zpolIsPolQ::params];

DomCost::usage = "DomCost[d, c]
	returns the interval of values of the cost function c
	evaluated over domain d = {MinN, MinD, MinI, MaxN, MaxD,
	MaxI}."

DomPrint::usage = "DomPrint[d1,d2]
        Visualize the domain d1, with d2 being the parameter domain.WARNING: CURRENTLY NOT AVAILABLE (the function does nothing)"


DomVisual::usage = 
"DomVisual[d1,d2] visualize the domain d1 with the Opera tool. d2 is
the parameter domain. Warning If the domain d2 is ommited, it is
replaced by the parameter domain of $result. WARNING: CURRENTLY NOT
AVAILABLE (the function does nothing)"

(* install the link to the external program "domlib" (C-based implementation
   of domain operators 'union', 'intersection', 'difference' etc. *)

(* C'est ici qu'on crée des symboles globaux.... *)
Module[{domlib},
  Which[
    $OperatingSystem=="MacOS",
	If[Cases[Links[],LinkObject["Domlib.PPC",__]]==={},
       domlib = Install[":sources:Domlib:domlib.PPC"],
       domlib = ""];Print[domlib];
    If[domlib === $Failed, Print["Warning: could not install domlib"]],
    $OperatingSystem=="Unix",
    Uninstall /@ Cases[Links[], LinkObject["domlib", __]];
    domlib=Install["domlib"];
    If[domlib === $Failed, Print["Warning: could not install domlib"]],
    $OperatingSystem=="WindowsNT",			
    Print["Installing Zdomlib"];
    (* domlib=Install[Environment["MMALPHA"]<>"\bin.cygwin32\domlib.exe"];
     domlib=Install["domlib"];	
     domlib=Install[Environment["MMALPHA"]<>"\bin.cygwin32\domlib"];*)
     domlib=Install["Domlib"];
     Print["domlib is : ",domlib];
     If[domlib === $Failed, Print["Warning: could not install domlib"]] 
  ]
];

(* *)

LatticeHermite::params = "wrong parameters";
LatticeHermite[___] := Message[LatticeHermite::params];
LatticeHermite[m1:Alpha`matrix[_,_,_,_]]:=
    Module[{}, 
	      If [ (m1[[1]] != m1[[2]]),
		  Message[LatticeHermite::NotaLattice];
		  Alpha`show[m1],
		  LatticeHermiteC[m1]]]

LatticeIntersection::params = "wrong parameters";
LatticeIntersection[___] := Message[LatticeIntersection::params];
LatticeIntersection[m1:Alpha`matrix[_,_,_,_], m2:Alpha`matrix[_,_,_,_]]:=
    Module[{}, 
	      If [ ( (m1[[1]] != m1[[2]]) || (m1[[1]]!=m2[[1]]) || (m2[[1]]!=m2[[2]]) ),
		  Message[LatticeIntersection::IncompatibleLattices];
		  Alpha`show[m1];Alpha`show[m2],
		  LatticeIntersectionC[m1,m2]]]

LatticeDifference::params = "wrong parameters";
LatticeDifference[___] := Message[LatticeDifference::params];
LatticeDifference[m1:Alpha`matrix[_,_,_,_], m2:Alpha`matrix[_,_,_,_]]:=
    Module[{}, 
	      If [ ( (m1[[1]] != m1[[2]]) || (m1[[1]]!=m2[[1]]) || (m2[[1]]!=m2[[2]]) ),
		  Message[LatticeDifference::IncompatibleLattices];
		  Alpha`show[m1];Alpha`show[m2],
		  LatticeDifferenceC[m1,m2]]]

LatticePreimage::params = "wrong parameters";
LatticePreimage[___] := Message[LatticePreimage::params];
LatticePreimage[m1:Alpha`matrix[_,_,_,_], m2:Alpha`matrix[_,_,_,_]]:=
    Module[{}, 
	      If [ ( (m1[[1]] != m1[[2]]) || (m1[[1]]!=m2[[1]])  ),
		  Message[LatticePreimage::IncompatibleLattice and Function];
		  Alpha`show[m1];Alpha`show[m2],
		  LatticePreimageC[m1,m2]]]

LatticeImage::params = "wrong parameters";
LatticeImage[___] := Message[LatticeImage::params];
LatticeImage[m1:Alpha`matrix[_,_,_,_], m2:Alpha`matrix[_,_,_,_]]:=
    Module[{}, 
	      If [ ( (m1[[1]] != m1[[2]]) || (m1[[1]]!=m2[[1]]) || (m2[[1]]!=m2[[2]]) ),
		  Message[LatticeImage::IncompatibleLattice and Function];
		  Alpha`show[m1];Alpha`show[m2],
		  LatticeImageC[m1,m2]]]

(* Converts a rational matrix to an integral one *)
Clear[RattoInt];
RattoInt[inp1:Alpha`matrix[num1_Integer,num2_Integer,idx_List,l_List]] :=
Module[{temp,mu},
       mu[a_,b_] := Map[#*a&,b];
       temp[li_] := Apply[LCM,Map[Denominator[#]&,li]];
       Alpha`matrix[num1,num2,idx,Map[mu[temp[Flatten[l]],#]&,l]]
];

(* Converts a integral matrix to an rational one *)
Clear[InttoRat];
InttoRat[inp1:Alpha`matrix[nm1_Integer,nm2_Integer,ix_List,lt_List]] :=
Module[{temp,div},
       div[a_,b_] := Map[#/a&,b];
       Alpha`matrix[nm1,nm2,ix,Map[div[Last[Last[lt]],#]&,lt]]
];


idQ::params = "Wrong parameters";
Clear[idQ]
idQ[mat:Alpha`matrix[rows_, cols_, _, List[__]] /; rows == cols ] :=
  InttoRat[mat][[4]] === IdentityMatrix[cols]

idQ[_matrix] := False
idQ[___] := (Message[idQ::params];$Failed)

DomZImage::params = "wrong parameters";
DomZImage[___] := Message[DomZImage::params];
DomZImage[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], m1:Alpha`matrix[_,_,_,_]]:=
     Module[{res},
	      If [(d1[[1]]=!=m1[[2]]-1) || (m1[[1]]=!=m1[[2]]) ,
		Message[DomZImage::Incompatibledimensions];
		Alpha`show[d1];Alpha`show[m1],
		res = DomZPImageC[d1,m1];
                  If[zpolIsPolQ[res],
                     zpolToPol[res],
                     res
		  ]
		]
	]
DomZImage[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],m1:Alpha`matrix[_,_,_,_]]:=
	Module[{res},
	       If [(d1[[1]]=!=m1[[2]]-1)  || (m1[[1]]=!=m1[[2]]) ,
                   Message[DomZImage::Incompatibledimensions];
                   Alpha`show[d1];Alpha`show[m1],
                   res = DomZImageC[d1,m1];
                   If[zpolIsPolQ[res],
                      zpolToPol[res],
			res
                   ]
		]
	]

Clear[DomImage];
DomImage::params = "wrong parameters `1`";
DomImage[a___] := Message[DomImage::params,a];
DomImage[
 d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}],
 m1:Alpha`matrix[_,_,_,_]]:=
DomImage[d1, m1, DomEmpty[0]];

DomImage[
  d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}],
  m1:Alpha`matrix[_,_,_,_],
  paramDom:Alpha`domain[___]
]:=
Catch[
  Module[{ params, res, indexes, linearPart, vect, posOfOnes, i, 
           initialIndexes, newIndex},

    (* Get list of parameters *)
    Params = paramDom[[2]];

    (* Check dimensions of the domains *)
    If[ d1[[1]]=!=m1[[2]]-1,
      Throw[ 
        Message[DomImage::Incompatibledimensions];
        Alpha`ashow[d1]; Alpha`ashow[m1]
      ]
    ];

    (* Call domLib *)
    res = DomImageC[d1,m1];

    (* The following is a heuristics in order to 
       obtain as readable indexes as possible. The C DomImage
       function returns a domain whose indexes are i1, i2, etc.
       By looking at the linear part of the affine transformation
       m1, one replace index ik by an index of the initial 
       indexes of domain d1, when there is no ambiguity. 
       This is the case if the k-th row of m1 is a unit 
       vector (0, ... 1, ... 0). If the 1 is say, in position 
       j, then index ik is replaced by the j-th index of d1.
    *)

    (* Get the indexes of the initial domain *)
    initialIndexes = d1[[2]];

    (* Get the indexes of the resulting domain *)
    indexes = res[[2]];
    (* For some reasons, DomImage may be called with a matrix with
       an empty index set... *)
    If[ indexes === {}, 
      indexes = Table[ "i"<>ToString[k], {k,1,res[[1]]} ]
    ];

    (* Get the linear part of the matrix m1. Notice that
       one cannot call the function getLinearPart of Matrix.m, 
       as Domlib cannot instanciate other packages... *)
    linearPart = 
      Map[Take[#,m1[[2]]-1]&, Drop[m1[[4]],-1]];

    (* For each row of linearPart, look if the row
    is a unit vector, and replace the index if needed *)
    For[ i=1, i<=Length[linearPart], i=i+1, 
      vect = linearPart[[i]];
      vect = Map[#/Last[Last[m1[[4]]]] &, vect];
      posOfOnes = Position[ vect, 1 ]; (* Positions of 1 in vect *)

      (* If one and only one 1 *)
      If[ Length[ posOfOnes ] === 1, 
        newIndex = initialIndexes[[posOfOnes[[1,1]]]];
        If[ !MemberQ[ indexes, newIndex ],
          indexes = ReplacePart[ indexes, newIndex, i ]
        ]
      ]
    ];

    (* Replace indexes in resulting domain *)
    res = ReplacePart[ res, indexes, 2 ];
    res
  ]
];
		    
DomImage[d1:Alpha`domain[d_,i_,z:{_Alpha`zpol..}],m1:Alpha`matrix[_,_,_,_]]:=
	Module[{},
		If [(d1[[1]]=!=m1[[2]]-1),
			Message[DomImage::Incompatibledimensions];
			Alpha`show[d1];Alpha`show[m1],
			DomImage[zpolToPol[d1],m1]
		]
];

Clear[DomDifference];
DomDifference::params = "wrong parameters: `1`";

DomDifference[a___] := Message[DomDifference::params,Map[Head,{a}]];
DomDifference[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}],d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomDifference::wrongDim]],
      DomDifferenceC[d1,d2]]
  ]
];
DomDifference[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomDifference::wrongDim]],
      DomZZDifferenceC[d1,d2]]
  ]
]; 	     
DomDifference[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomDifference::wrongDim]],
      DomZPDifferenceC[d1,d2]]
  ]
];
DomDifference[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}],d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomDifference::wrongDim]],
      DomPZDifferenceC[d1,d2]]
  ]
]; 	     
Clear[DomIntersection];
DomIntersection::params = "wrong parameters";
DomIntersection::wrongDim = "Domains do not have the same dimension."

DomIntersection[a___] := (Print[a];Message[DomIntersection::params];)
DomIntersection[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}],d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomIntersection::wrongDim]],
      DomIntersectionC[d1,d2]]
  ]
];
DomIntersection[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomIntersection::wrongDim]],
      DomZZIntersectionC[d1,d2]]
  ]
];
DomIntersection[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}],d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomIntersection::wrongDim]],
      DomPZIntersectionC[d1,d2]]
  ]
];
DomIntersection[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomIntersection::wrongDim]],
      DomZPIntersectionC[d1,d2]]
  ]
];
Clear[DomUnion];
DomUnion::params = "wrong parameters";
DomUnion[___] := Message[DomUnion::params];
DomUnion[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomUnion::wrongDim]],
      DomUnionC[d1,d2]]
  ]
];
DomUnion[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}], d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomUnion::wrongDim]],
      If[
		DomEmptyQ[d1],
		d2,
		If[
			DomEmptyQ[d2],
			d1,
			DomZZUnionC[d1,d2]
		]
	]
       ]
  ]
];
DomUnion[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomUnion::wrongDim]],
      If[
      	DomEmptyQ[d2],
	d1,
	DomPZUnionC[d1,d2]
	]
       ]	
  ]
];
DomUnion[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}], d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomUnion::wrongDim]],
      If[
      	DomEmptyQ[d1],
	d2,
	DomZPUnionC[d1,d2]
	]
       ]
  ]
];
Clear[DomUniverse];
DomUniverse[d_Integer] :=
Module[{i,j},
  Alpha`domain[d,{},{
        Alpha`pol[1,d+1,0,d,
	    {Table[Which[i==1, 1, i==(d+2), 1, True, 0], {i,d+2} ] },
	     Table[Which[j==i+1, 1, i==0 && j==(d+2),1,True, 0],
                          {i,0,d}, {j,1,d+2}]
		  ]}]
		];
DomUniverse::params = "wrong parameters";
DomUniverse[___] := Message[DomUniverse::params];
DomUniverse::usage = "DomUniverse[n] returns the universe domain of dimension n."

Clear[DomEmpty];
DomEmpty[d_Integer] :=
Module[{i,j},
  Alpha`domain[d,{},{
		  Alpha`pol[(d+1),0,(d+1),0,
		    Table[Which[j==i+1, 1, True, 0], {i,1,d+1}, {j,1,d+2}],
		    {}
		  ]}]
		];
DomEmpty[___]:=Message[DomEmpty::params];
DomEmpty::params = "wrong parameters";
Alpha`Domlib`DomEmpty::usage = "DomEmpty[n] returns the empty domain of dimension n."

Clear[DomUniverseQ];
DomUniverseQ[Alpha`domain[d_,_,{Alpha`pol[_,_,_,l_,_,_]}]] :=
		(d==l);
DomUniverseQ[_Alpha`domain] := False
DomUniverseQ[___]:=Message[DomUniverseQ::params];
DomUniverseQ::params = "wrong parameters";
DomUniverseQ::usage = 
"DomUniverseQ[d] returns True if domain d is the universe, False otherwise."

Clear[noIntegralSoln];
noIntegralSoln[{}] := False;
noIntegralSoln[c_List] := Apply[And,Map[(First[solveEqualities[{Take[#,{2,Length[#]-1}]},{-Last[#]}]]=={})&,c]];

Clear[DomEmptyQ];
DomEmptyQ[Alpha`domain[d_,_,{Alpha`pol[_,_,e_,_,c_,_]}]] :=
Module[{s},
	If[(d+1)==e,
		True,
		s={};
		For[i=1,i<=Length[c],i++,If[First[c[[i]]]==0,s=Append[s,c[[i]]]]];
		noIntegralSoln[s]
	]
];
DomEmptyQ[d: Alpha`domain[_,_,{Alpha`zpol[_,p_]}]] :=
Module[{s},
	If[DomZEmptyQC [d],
		True,
		s={};
		For[i=1,i<=Length[p[[1,5]]],i++,If[First[p[[1,5,i]]]==0,s=Append[s,p[[1,5,i]]]]];
		noIntegralSoln[s]
	]
];

DomEmptyQ[Alpha`domain[d_,i_,z_]] := 
Module[{},
	Apply[And,Map[DomEmptyQ[Alpha`domain[d,i,{#}]]&,z]]
];

DomEmptyQ[a_Alpha`domain] := False;
DomEmptyQ[x:___]:=(Print[x];Message[DomEmptyQ::params];)
DomEmptyQ::params = "wrong parameters";
DomEmptyQ::usage = "DomEmptyQ[d] returns True if domain d is empty, False otherwise."


Clear[DomEqualQ];
DomEqualQ[A_Alpha`domain,B_Alpha`domain]:=
  (* Do not call DomDifference if dimensions are not the same! *)
  If[ A[[1]]==B[[1]], 
    DomEmptyQ[DomDifference[A,B]]&&DomEmptyQ[DomDifference[B,A]],
    False
    ]

DomEqualQ[___]:=Message[DomEqualQ::params];
DomEqualQ::params = "wrong parameters";
DomEqualQ::usage = 
"DomEqualQ[d] returns True if domain d1 is equivalant to d2, False
otherwise."


Clear[DomEqualities];
DomEqualities[d1:Alpha`domain[dim_,ind_,
                             {Alpha`pol[_,_,numEqs_,_,eqs_,_], ___}]] :=
Module[{x,res,nbRows},
  If[Length[d1[[3]]]>1, 
   (* This function does not work for union of domains *)
   res={}; nbRows=0, 
   res=Cases[eqs, {0,x__}->{x}];nbRows=numEqs];
   Alpha`matrix[nbRows, dim+1, ind, res]
];

(**** change ****)
DomEqualities::singular = "Matrix is singular";
DomEqualities[d3:Alpha`domain[_,_,{Alpha`zpol[outp:Alpha`matrix[_,_,_,matfn_],{Alpha`pol[_,_,_,_,cons_,_]}]}]]:=
Catch[
  Module[{sr,temp,mu},
	temp[l_] := If[Length[l]===0,{{}},Apply[LCM,Map[Denominator[#]&,l]]];
	mu[a_,b_] := Map[#*a&,b];
	If[Det[matfn]===0,Throw[Message[DomEqualities::singular]]];

	(* Identify Equalities *)
	sr = Select[cons,First[#]==0&];
	sr = Map[Drop[#,1]&,sr];

	(* Image of equalities by matfn *)
	sr = If[Length[sr]==0,{{}},Transpose[Inverse[matfn].Transpose[sr]]];
	sr = Map[mu[temp[#],#]&,sr];
	Alpha`matrix[Length[sr],Length[sr[[1]]],d3[[3]][[1]][[1]][[3]],sr]
	]
];

DomEqualities[___]:=Message[DomEqualities::params];
DomEqualities::params = "wrong parameters";
DomEqualities::union = 
  "DomEqualities::union:Warning: this function should not be called on unions of convexes...";
DomEqualities::usage = 
"DomEqualities[d] returns the matrix of equations (lineality space) of
d."

Clear[DomProject];
DomProject::wrgindex = "some of the projection indices do not appear in domain";

(**** change ****)
DomProject1[dm2:Alpha`domain[_,_,{Alpha`zpol[Alpha`matrix[_,_,_,_],{_Alpha`pol..}]}],idlst2:{___String}]:=
  Module[{sr,br,rs,newmat,seq,reord},
	 (* Call DomProject on Polyhedra *)
	  sr = dm2[[3,1,2]];
	  sr = ReplacePart[dm2,sr,{3}];
	  sr = ReplacePart[sr,dm2[[3]][[1]][[1]][[3]],{2}];
	  br = DomProject[sr,idlst2];   (* Incompatible index lst will be handled by polyhedral domproject *)

	 (* Adjust dimension and id_list *)
	  rs = ReplacePart[dm2,br[[3]],{3,1,2}];
	  rs = ReplacePart[rs,Length[br[[2]]]+1,{3,1,1,1}];
	  rs = ReplacePart[rs,Length[br[[2]]]+1,{3,1,1,2}];
	  rs = ReplacePart[rs,br[[2]],{3,1,1,3}];
	  rs = ReplacePart[rs,br[[1]],{1}];

	 (* Adjust the transformation matrix *)
	  newmat = rs[[3]][[1]][[1]][[4]];
	  sr = dm2[[3]][[1]][[1]][[3]];
	  br = br[[2]];
	  reord[ls_,i_] := Map[ls[[#]]&,i];
	  seq = Map[Position[sr,#][[1]][[1]]&,br];
	  seq = Append[seq,Length[sr]+1];
	  sr = {};
	  sr = Map[reord[newmat[[#]],seq]&,seq];

	 (* Final result *)
	  rs = ReplacePart[rs,sr,{3,1,1,4}]
	];

DomProject[dm3:Alpha`domain[zdm:_Integer,_,zlst:{_Alpha`zpol..}],idlst3:{___String}]:=
Module[
	{tmp},
	tmp = ReplacePart[dm3,Map[DomProject1[ReplacePart[dm3,{#},{3}],idlst3][[3,1]]&,zlst],{3}];
	ReplacePart[tmp,tmp[[3,1,1,2]]-1,{1}]
];

DomProject[dom:_Alpha`domain, idx:{___String}]:=
Catch[
  Module[{m,idy,leni,lenj,i,j},
	  idy  = Part[dom,2];
	  If[Complement[idx, idy] =!= {},Throw[Message[DomProject::wrgindex]]];
	  leni = Part[dom,1]+1;
	  lenj = Length[idx]+1;
	  m = Alpha`matrix[ lenj, leni, idy,
	        Table[ If[ (i<leni && j<lenj && (Part[idy,i]===Part[idx,j])) ||
                   (i===leni && j===lenj), 1, 0 ], {j,1,lenj}, {i,1,leni}] ];
	  ReplacePart[ DomImage[dom, m], idx, 2 ]
	] (* Project *)
]; (* Catch *)



DomProject::usage =  
"DomProject[dom_Alpha`domain, idx:{__String}] projects dom onto the indices
in the index list idx. Reorders indices and changes the dimension
accordingly."
DomProject::params = "wrong parameters";
DomProject[___] := Message[DomProject::params];


(* 
   October 19, 2002.
   I modified this function in order to correct a bug in cGen. 
   The old version checked that the index list of the domain
   to be extended is a prefix of the new index list. Actually
   this is not necessary. What is needed is that the new index
   list is at least as long as the domain index list. What I did
   is to check this, and also, if the domain index list is not
   a prefix of the extension index, I replace the first indexes
   by those of the extension. 
 *)
Clear[DomExtend];
DomExtend::wrgindex = "index list is not an extension of the domain indices.";
(**** change ****)
DomExtend1[dm1:Alpha`domain[dimen_,_,{Alpha`zpol[Alpha`matrix[_,_,_,_],{_Alpha`pol..}]}],idlst1:{___String}]:=
  Module[{sr,br,rs,newcol,newmat,lst,seq,reord},

	 (* Call DomExtend on Polyhedra *)
	  sr = dm1[[3,1,2]];
	  sr = ReplacePart[dm1,sr,{3}];
	  sr = ReplacePart[sr,dm1[[3,1,1,3]],{2}];
	  br = DomExtend[sr,idlst1];   (* Incompatible index lst will be handled by polyhedral domxtend *)
	 
	 (* Adjust dimension and id_list *)
	  newcol[l_] := Map[Insert[#,0,-2]&,l];
	  rs = ReplacePart[dm1,br[[3]],{3,1,2}];
	  newmat = rs[[3,1,1,4]];
	  sr = dm1[[3,1,1,3]];
	  Map[If[FreeQ[sr,#],newmat = Insert[newcol[newmat],PadLeft[{1,0},Length[newmat]+1],-2]]&,br[[2]]];
	  rs = ReplacePart[rs,Length[newmat],{3,1,1,1}];
	  rs = ReplacePart[rs,Length[newmat],{3,1,1,2}];
	  rs = ReplacePart[rs,br[[1]],{1}];
	  rs = ReplacePart[rs,br[[2]],{3,1,1,3}];

	 (* Adjust the transformation matrix *)
	  br = br[[2]];
	  lst = sr;
	  reord[ls_,i_] := Map[ls[[#]]&,i];
	  Map[If[FreeQ[sr,#],lst = Append[lst,#]]&,br];
	  sr = {};
	  seq = Map[Position[lst,#][[1]][[1]]&,br];
	  seq = Append[seq,Length[newmat]];
	  sr = Map[reord[newmat[[#]],seq]&,seq];

	 (* Final result *)
	  rs = ReplacePart[rs,sr,{3,1,1,4}]
	];

DomExtend[dm4:Alpha`domain[_Integer,_,zlst1:{_Alpha`zpol..}],idlst4:{___String}]:=
Module[
	{tmp},
	tmp = ReplacePart[dm4,Map[DomExtend1[ReplacePart[dm4,{#},{3}],idlst4][[3,1]]&,zlst1],{3}];
	ReplacePart[tmp,tmp[[3,1,1,2]]-1,{1}]
];
			
DomExtend[dom:_Alpha`domain, indexList:{___String}]:=
Catch[
  Module[ {m, idy, leni, lenj, i, j, preim, idx},
    (* Indexes of dom *)
    idy  = Part[dom,2];
    (* Indexes of extension *)
    idx = indexList;
    (* We check that the first indexes are the same...*)
    (* 
    If[ Complement[idy,idx]=!={},Throw[Message[DomExtend::wrgindex]] ];
    *)
    (* Dimension of dom *)
    leni = Part[dom,1]+1;
    (* Length of new indexes *)
    lenj = Length[idx]+1;

    If[ lenj < leni, Throw[Message[DomExtend::wrgindex]] ];
    
    If[ Complement[idy,idx]=!={}, 
      idx = Join[ idy, Drop[ idx, Length[ idy ] ] ] ];

    m = Alpha`matrix[ leni, lenj, idx,
        Table[ If[ (i<leni && j<lenj && (Part[idy,i]===Part[idx,j])) ||
                   (i===leni && j===lenj), 1, 0 ], {i,1,leni}, {j,1,lenj}] ];

    Check[ 
      preim = Alpha`Domlib`DomPreimage[dom, m], 
      DomExtend::errPreimage = "error while calling DomPreimage";
      Throw[ Message[ DomExtend::errPreimage ] ]
    ];

    ReplacePart[ preim, idx, 2 ]
  ] (* Module *)
]; (* Catch *)


DomExtend::usage = 
"DomExtend[dom_Alpha`domain, idx_List] extends dom to the indices in
the index list idx. This list should contains the indices of dom.";

DomExtend::params = "wrong parameters: `1`";
DomExtend[a___] := Message[DomExtend::params, {a}];

DomPreimage::params = "wrong parameters";
DomPreimage[___] := Message[DomPreimage::params];
DomPreimage[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], m1:Alpha`matrix[_,_,_,_]]:=
     Module[{},
	      If [d1[[1]]=!=m1[[1]]-1 ,
		Message[DomPreimage::Incompatibledimensions];
		Alpha`show[d1];Alpha`show[m1],
                DomPreimageC[d1,m1]]]
DomPreimage[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],m1:Alpha`matrix[_,_,_,_]]:=
	Module[{},
		If [(d1[[1]]=!=m1[[1]]-1) ,
		Message[DomPreimage::Incompatibledimensions];
		Alpha`show[d1];Alpha`show[m1],
		DomPreimageC[zpolToPol[d1],m1]]]

DomZPreimage::params = "wrong parameters";
DomZPreimage[___] := Message[DomPreimage::params];
DomZPreimage[d1:Alpha`domain[0,_,_], m1:Alpha`matrix[_,_,_,_]]:= DomPreimage[d1,m1]

(*
DomZPreimage[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], m1:Alpha`matrix[_,_,_,_]]:=
     Module[{res},
	      If [(d1[[1]]=!=m1[[1]]-1),
		Message[DomZPreimage::Incompatible dimensions];
		Alpha`show[d1];Alpha`show[m1],
		res = DomZPPreimageC[d1,m1];
                  If[zpolIsPolQ[res],
                     zpolToPol[res],
                     res
		  ]
              ]
     ]		(* error : doesn,t work on 0-dim polyhedra *)
 *)
	
DomZPreimage[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], m1:Alpha`matrix[_,_,_,_]]:=
     Module[{res},
	If[Last[Last[RattoInt[m1][[4]]]] =!= 1,
		If [(d1[[1]]=!=m1[[1]]-1),
		Message[DomZPreimage::Incompatible dimensions];
		Alpha`show[d1];Alpha`show[m1],
		res = DomZPPreimageC[d1,m1];
		If[zpolIsPolQ[res],
                   zpolToPol[res],
                   res
                ]
		],
           DomPreimage[d1,m1]
	]
]		(* error : doesn,t work on 0-dim polyhedra *)

DomZPreimage[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}],m1:Alpha`matrix[_,_,_,_]]:=
	Module[{res},
		If [(d1[[1]]=!=m1[[1]]-1) ,
		Message[DomZPreimage::Incompatible dimensions];
		Alpha`show[d1];Alpha`show[m1],
		res = DomZPreimageC[d1,m1];
		If[zpolIsPolQ[res],
                   zpolToPol[res],
                   res
                ]
		]
	]


(**** change ****)
(* Usage: DomConstraints[a,b] gives the Zpolyhedra obtained by Transformation 
          of Polyhedra P by integral mapping a, and P is the minimum convex
          Polyhedra satisfying constraints given in b;
          i.e. P = Domconstraints[b];
          Zpol = a(P);
*)

DomConstraints::wrgidxlst = "index list of the two matrices must be same";
DomConstraints[matA:Alpha`matrix[_,_,_,_],matB:Alpha`matrix[_,_,_,_]]:=
Catch[
 Module[{p},
	If[matA[[3]]=!=matB[[3]],Throw[Message[DomProject::wrgidxlst]]];
	p = DomConstraints[matB];
	Alpha`domain[p[[1]],{},{Alpha`zpol[matA,p[[3]]]}]
	](* Project *)
];(* Catch *)

DomConstraints::params = "wrong parameters";
DomConstraints[___] := Message[DomConstraints::params];

DomSimplify::params = "wro parameters";
DomSimplify[d1:Alpha`domain[_,_,{_Alpha`pol..}],d2:Alpha`domain[_,_,{_Alpha`pol..}]] := DomSimplifyC[d1,d2];
DomSimplify[d1:Alpha`domain[_,_,{_Alpha`pol..}],d2:Alpha`domain[_,_,{_Alpha`zpol..}]] := DomSimplifyC[d1,zpolToPol[d2]];
DomSimplify[d1:Alpha`domain[dim_,_,mlst:{_Alpha`zpol..}],d2:Alpha`domain[_,_,{_Alpha`pol..}]] :=
Module[{tempDom},
	tempDom = Map[Alpha`zpol[#[[1]],DomPreimage[DomSimplify[DomImage[Alpha`domain[dim,#[[1,3]],#[[2]]],#[[1]]],d2],#[[1]]][[3]]]&,mlst];
	Alpha`domain[dim,{},tempDom]
];
(*DomSimplify[a___] := (Print[a];Message[DomSimplify::params])*)
DomSimplify[a___] := Print[a];


DomMatrixSimplify::params = "wrong parameters";
(* change *)
DomMatrixSimplify[matA:Alpha`matrix[_Integer,_Integer,_,_],matB:Alpha`matrix[r_Integer,c_Integer,_,_]]:=
	Module[{},
		If[
			((r==0) || (c==0)),
			matA,
			DomMatrixSimplifyC[matA,matB]
		]
	];
DomMatrixSimplify[___] := Message[DomMatrixSimplify::params];

DomConvex::params = "wrong parameters";
DomConvex[___] := Message[DomConvex::params];

(* 5/11/98 there is a bug is the DOMCOnvex of Polylib, 
   we replace the DomConvex of DomLib by this DomConvex *)
Clear[DomConvex];
(* Added by Patrice, to cover properly case when d is empty... *)
DomConvex[d:_Alpha`domain/;DomEmptyQ[d]]:= d;

(********** change **********)
(* for Zpol: returns the convex polyhedra enclosing it *)
DomConvex[dmn:Alpha`domain[dn_,_,mlst:{_Alpha`zpol..}]]:=
Module[{ztop,plst,domunlst},
       ztop[Alpha`zpol[Alpha`matrix[sr_,sc_,sid_,sm_],slst:{_Alpha`pol..}]]
            := Alpha`domain[dn,sid,slst];
       plst = Map[DomImage[ztop[#],#[[1]]]&,mlst];
       domunlst = DomEmpty[dn];
       domunlst[[2]]=dmn[[3,1,1,3]];
       For[i = 1, i <= Length[plst], i += 1,domunlst=DomUnion[domunlst,plst[[i]]]];
       DomConvex[domunlst]
];

DomConvex[d_Alpha`domain]:=
Module[{raysD, sortedRaysD, mat1, res},
  raysD=Union[Flatten[Map[Part[#,6] &,d[[3]]],1]];
  sortedRaysD=Map[Reverse,Sort[Map[Reverse,raysD]]];
  mat1=Alpha`matrix[Length[sortedRaysD],
			   Length[sortedRaysD[[1]]],
			   d[[2]],
			   sortedRaysD];
  res=DomRays[mat1]
];
DomConvex[___] := (Message[DomConvex::params];$Failed)


DomLTQ[d1:_Alpha`domain, d2:_Alpha`domain, idx:_Integer] :=
  DomLTQ[d1, d2, idx, 0];

DomVertices::wrongArg = "`1`";
DomVertices::findV = "ML_findV returned suspicious result: `1`";
DomVertices::dim = "domain cannot have less dimensions that parameters";

DomVertices[
 dom:_Alpha`domain,
 param:_Alpha`domain] :=
  Which[
    First[param] == 0,
    DomVertices[dom],
    First[dom] == First[param],
    {{param,{{}}}},
    First[dom] < First[param],
    Message[DomVertices::dim];$Failed,
    True,
    Catch[
      Join@@Join@@Outer[
	DomVertices[#1,#2,param[[2]]]&, 
	dom[[3]], param[[3]]]
    ]
  ];

DomVertices[
 dom:_Alpha`domain] :=
  Catch[
    Join@@DomVertices/@dom[[3]]
  ];

DomVertices[
 polyhedron:_Alpha`pol,
 parameters:_Alpha`pol,
 ind:{___String}] :=
  Module[{res},
	 If[MatchQ[parameters,pol[1, 1, 0, 0, {{1, 1}}, {{1, 1}}]],
	    DomVertices[polyhedron],
	    res=findV[
	      {polyhedron[[1]],
	       Length[polyhedron[[5,1]]],
	       polyhedron[[5]]},
	      {parameters[[1]],
	       Length[parameters[[5,1]]],
	       parameters[[5]]}];
	      (* res is a list of {domain, {vertices}} *)
	      (* map transformation on res, where transformation is : *)
	      (* domain -> alpha`domain, each vertice -> delete last element *) 
	      (* of each composant and divide by this element *)
	      If[!MatchQ[res,_List],
		 Message[DomVertices::findV, res];
		 Throw[$Failed],
		 Map[
		   Function[{sol},{With[{cst=Join[parameters[[5]],
						  Delete[sol[[1]],-1]]},
					DomConstraints[
					  Alpha`matrix[Length[cst],
						       Length[First[cst]],
						       ind,
						       cst]]],
				   ((Delete[#1,-1]/Last[#1])& /@ #1)& /@ sol[[2]]
				   }],
		   res]
	       ]
	  ]
       ];
  

DomVertices[
 polyhedron:_Alpha`pol] :=
  Module[{},	      
	 {{DomUniverse[0],
	   (({#1})&/@(Delete[Delete[#1,1],-1]/Last[#1]))& /@
	   Select[polyhedron[[6]],((First[#1]==1)&&(Last[#1]!=0))&]
	   }}
	   ];

DomVertices[a___]:=
  Module[{},
	 Message[DomVertices::wrongArg,{a}];
	 $Failed
	 ];


(* hypercube *)
Clear[hypercube];
hypercube[n:_Integer]:=
With[{t = Table[ToExpression["i"<>ToString[i]],{i,1,n}]},
     {Union[Map[#1<=10&,t],Map[#1>=0&,t]],t}];
hypercube[___]:=Message[hypercube::typeError];

(* constraintQ *)
Clear[constraintQ];
constraintQ[(Alpha`eq|Alpha`ge)[_,_Integer]]:=True;
constraintQ[___]:=False;

(* domHalfSpaceQ *)
Clear[domHalfSpaceQ];
(* if String, parse before *)
domHalfSpaceQ[dom_String]:=domHalfSpaceQ[Alpha`readDom[dom]]; 
domHalfSpaceQ[Alpha`domain[dim_,ind_,{Alpha`pol[nc_,_,_,_,c_,_]}]]:=
  Module[{},
	 nc===2 && c[[1]][[1]] ===1];
domHalfSpaceQ[x_]:=(Message[domHalfSpaceQ::arg];False);

(* A few local functions *)
Clear[linpart,coeff,oper];
(* linpart Takes the linear part of a constraint *)
linpart[x_]:=Drop[Drop[x,1],-1];
(* coeff Takes the coefficient of a constraint *)
coeff[x_]:=Part[x,-1];
(* oper returns the operator of a constraint, in Alpha form *)
Clear[oper];
oper[x:{___Integer}]:=With[{y=Part[x,1]},If[y===1,GreaterEqual,Equal]];
oper[___]:=Message[oper::errType];

(* constraintMmaQ *)
Clear[constraintMmaQ];
constraintMmaQ[False]:=True;
constraintMmaQ[Equal[x_,y_Integer]]:=True;
constraintMmaQ[GreaterEqual[x_,y_Integer]]:=True;
constraintMmaQ[LessEqual[x_,y_Integer]]:=True;
constraintMmaQ[Greater[x_,y_Integer]]:=True;
constraintMmaQ[Less[x_,y_Integer]]:=True;
constraintMmaQ[___]:=False;


(* This function transforms an alpha constraint into a mma symbolic
   constraint, i.e. a pair index, constraint *)
Clear[const2mma];
const2mma[ind:{}|{(_Symbol|_String)..},x:{___Integer}]/;Length[x]==Length[ind]+2:=
Catch[
Module[{o,lp,c,ind1},
       Check[ind1=ToExpression[ind],Throw[Message[const2mma::wrgx]]];
       Check[o=oper[x],Throw[Message[const2mma::wrgx]]];
       Check[lp=linpart[x],Throw[Message[const2mma::wrgx]]];
       Check[c=coeff[x],Throw[Message[const2mma::wrgx]]];
   {ind,o[lp.ind1,-c]}
  ]
]
const2mma[a___]:=Message[const2mma::typeError,a];

(* converts a pair index, constraint into an alpha constraint *)
Clear[const2al];
const2al::typeError = "parameters should be an index list (free mma symbols) and a constraint";
const2al[ind:{__},(h:(Alpha`eq|Alpha`ge))[exp_,n_Integer]]:=
  Flatten[{If[h===Alpha`eq,0,1],Map[Coefficient[exp,#1]&,ind],-n}];
const2al[___]:=Message[const2al::typeError];

(* encodes an alpha domain into a pair {index,constraints} *)
(* warning: the constraint representation may or may not contain
   a so called positivity constraint 1>=0 (see document polylib.ps in 
   $MMALPHA/doc/user). This contraint has to be removed *)
Clear[dom2mma];
dom2mma[x_String]:=dom2mma[Alpha`readDom[x]];

dom2mma[Alpha`domain[dim_,{},{x:pol[_,_,_,_,c_,_]}]]:=
  dom2mma[
	Alpha`domain[dim,
		Table["i"<>ToString[i],{i,1,dim}],
		{x}
		]
	];

dom2mma[Alpha`domain[0,{},{pol[_,_,_,_,c_,_]}]]:={{},{}};
dom2mma[Alpha`domain[dim_,ind1_,{Alpha`pol[_,_,_,_,c_,_]}]]:=
Catch[
  Module[{d},
	 (* This should be modified *)
	   ind=ToExpression[ind1];
	 Check[d = Map[const2mma[ind,#1]&,c],Throw[Message[dom2mma::wrgdom]]];
	 d = Map[#1[[2]]&,d];
	 d = {Complement[d,{True}],ind};
	 If[MemberQ[d[[1]],False],d={{False},ind}];
	 d
	 ]
];
dom2mma[domain[dim_,ind_,p:{_pol,__pol}]]:=
Module[{mm},
  mm=Map[dom2mma[domain[dim,ind,{#1}]]&,p];
  {Apply[Or,Map[First,mm]],mm[[1]][[2]]}
	];
dom2mma[___]:=Message[dom2mma::typeError];


Clear[linearExpQ];
linearExpQ[_Integer,l:{__Symbol}]:=True;
linearExpQ[a:_Symbol,l:{__Symbol}]:=True/;MemberQ[l,a];
linearExpQ[Times[_Integer,a:_Symbol],l:{__Symbol}]:=True/;MemberQ[l,a];
linearExpQ[HoldPattern[x:Plus[(_Symbol|_Integer|Times[_Integer,_Symbol])..]],l:{__Symbol}]:=
	Complement[Variables[x],l]==={};
linearExpQ[___]:=False;

Clear[linearConstraintQ];
linearConstraintQ[c:_,l:{__Symbol}]:=
Catch[
  Module[{pols},
	If[!MatchQ[c,
            (Equal|GreaterEqual|
             Greater|Less|LessEqual)[a:_?(linearExpQ[#1,l]&),b:_?(linearExpQ[#1,l]&)]],
            Throw[Message[linearConstraintQ::notalinearc,c,l];False],
	    True] (* If *)
         ]
     ];
linearConstraintQ[___]:=Message[linearConstraintQ::params];

(* encode *)
Clear[encode];
encode[False]:=Alpha`ge[0,1];
encode[Equal[x_,y_Integer]]:=Alpha`eq[x,y];
encode[GreaterEqual[x_,y_Integer]]:=Alpha`ge[x,y];
encode[LessEqual[x_,y_Integer]]:=Alpha`ge[-x,-y];
encode[Greater[x_,y_Integer]]:=Alpha`ge[x,y+1];
encode[Less[x_,y_Integer]]:=Alpha`ge[-x,-y-1];
encode[___]:=Message[encode::typeErr];

linHalfSpace::domNotHalfSpace = " Domain is not a half Space "
(* gets the linear part of a Half-space definition *)


Clear[linHalfSpace];


linHalfSpace[
 x:Alpha`domain[dim_,ind_,{Alpha`pol[_,_,_,_,c_,_]}]]:=
  Module[{mmaMat,numParam},
	 If [domHalfSpaceQ[x],
	     mmaMat = {Drop[Drop[c[[1]],1],-1]};
	     mmaMat,
	     Message[linHalfSpace::domNotHalfSpace];
	     {}]]
	     

linHalfSpace[x_]:=(Message[linHalfSpace::arg];Print[x];{});

(* encodes a pair {index,constraints} into an alpha domain *)
Clear[dom2al];
(* universe bottom domain *)
dom2al[{{},{}}]:=DomUniverse[0]; 
(* Encode constraints before processing *)
dom2al[{const:{___?constraintMmaQ}/;Length[const]>0,y:{}|{(_Symbol|_String|Global`scdc[___])..}}]:=
     dom2al[{Map[encode,const],y}]; 
(* Definition, properly speaking *)
dom2al[{const:{___?constraintQ},ind:{__}}]:= 
  Catch[
    Module[{m,d},
      Check[m = Map[const2al[ind,#1]&,const],Throw[Message[dom2l::cst2l]]];
      Check[d = domCompRays[
                   Alpha`domain[
                     Length[ind],
                     ind,
                     {Alpha`pol[Length[const],0,0,0,m,{}]}
                               ]
                           ],
            Throw[Message[dom2al::domcpr]]];
      d
       ]
  ];
dom2al[x:___]:=(Print[Hold[{x}]];Message[dom2al::typeErr]);

Clear[vertices];
(* vertices[{const:{___?constraintMmaQ},y:(ind:{}|{(_Symbol|_Symbol)..})}]:=*)
vertices[{const:{___?constraintMmaQ},y:{ind:_}}]:=
Catch[
  Module[{d,v,temp},
	Check[d=dom2al[{const,y}],Message[vertices::errdom2al]];
	v = d[[3]][[1]][[6]];
	v = Select[v,Last[#]!=0&&First[#]==1&];
	v = Map[Drop[#,1]&,v];
	temp[l_] :=  Map[#/Last[l]&,l];
	v = Map[temp[#]&,v];
	Map[Drop[#,-1]&,v]
	]
];
vertices[d:Alpha`domain[dim_,ind_,{x:Alpha`pol[_,_,_,_,c_,_]}]]:=
  Module[{v,temp},
	v = d[[3]][[1]][[6]];
	v = Select[v,Last[#]!=0&&First[#]==1&];
	v = Map[Drop[#,1]&,v];
	temp[l_] :=  Map[#/Last[l]&,l];
	v = Map[temp[#]&,v];
	Map[Drop[#,-1]&,v]
	];

(**** change ****)
vertices::dim = "Incompatible dimensions";
vertices[Alpha`domain[dn_,i_,{Alpha`zpol[Alpha`matrix[ry_,cl_,_,m_],{Alpha`pol[_,_,_,_,_,q_]}]}]]:=
Catch[
  Module[{sr,temp},
	If[((dn+1=!=ry) || (ry=!=cl)),Throw[Message[vertices::dim]]];
	sr = Select[q,Last[#]!=0&&First[#]==1&];
	sr = Map[Drop[#,1]&,sr];
	sr = Transpose[m.Transpose[sr]];
	temp[l_] :=  Map[#/Last[l]&,l];
	sr = Map[temp[#]&,sr];
	Map[Drop[#,-1]&,sr]
	]
];

vertices[x:___]:=(Print[{x}];Message[vertices::typeError]);

Clear[rays];
rays[{const:{___?constraintMmaQ},y:(ind:{}|{(_Symbol|_Symbol)..})}]:=
Catch[
  Module[{d,sr,br},
	Check[d=dom2al[{const,y}],Message[vertices::errdom2al]];
	r = d[[3]][[1]][[6]];
	(* True rays *)
	sr = Select[r,Last[#]==0&&First[#]==1&];
	sr = Map[Drop[Drop[#,-1],1]&,sr];
	(* Lines *)
	br = Select[r,Last[#]==0&&First[#]==0&];
	br = Map[Drop[Drop[#,-1],1]&,br];
	Union[sr,br,-br]
	]
];
rays[d:Alpha`domain[dim_,ind_,{x:Alpha`pol[_,_,_,_,c_,_]}]]:=
  Module[{sr,br},
	r = d[[3]][[1]][[6]];
	(* True rays *)
	sr = Select[r,Last[#]==0&&First[#]==1&];
	sr = Map[Drop[Drop[#,-1],1]&,sr];
	(* Lines *)
	br = Select[r,Last[#]==0&&First[#]==0&];
	br = Map[Drop[Drop[#,-1],1]&,br];
	Union[sr,br,-br]
];

(**** change ****)
rays::dim = "Incompatible dimensions";
rays[Alpha`domain[d_,i_,{Alpha`zpol[Alpha`matrix[ray_,col_,_,m_],{Alpha`pol[_,_,_,_,_,r_]}]}]]:=
Catch[
  Module[{sr,br},
	(* True rays *)
	If[((d+1=!=ray) || (ray=!=col)),Throw[Message[rays::dim]]];
	sr = Select[r,Last[#]==0&&First[#]==1&];
	sr = Map[Drop[Drop[#,-1],1]&,sr];
	(* Lines *)
	br = Select[r,Last[#]==0&&First[#]==0&];
	br = Map[Drop[Drop[#,-1],1]&,br];
	(* Rays *)
	sr = Union[sr,br,-br];
	br = Drop[Map[Drop[#,-1]&,m],-1];
	If[Length[sr]==0,{},Transpose[br.Transpose[sr]]]
	]
];


rays[___]:=Message[rays::typeError];

(**** change ****)
DomAddRays::dim = "Incompatible dimensions";
DomAddRays[dm:Alpha`domain[dmn_,_,{Alpha`zpol[Alpha`matrix[r1_,c1_,_,m1_],{Alpha`pol[_,_,_,_,_,_]}]}],tr:Alpha`matrix[r2_,c2_,_,mat_]]:=
  Module[{sr,br,rs,ln,temp},
	(* Find m_inverse *)
	If[((dmn+1=!=r1) || (r1=!=c1) || (c1=!=c2-1)),Throw[Message[DomAddRays::dim]]];
	sr = Inverse[m1];
	temp[l_] := Apply[LCM,Map[Denominator[#]&,l]];
	mu[a_,b_] := Map[#*a&,b];

	(* For Rays *)
	   br = Select[mat,First[#]==1&];
	   br = Map[Drop[#,1]&,br];
	   (* Rays after inverse mapping *)
	   br = If[Length[br]==0,{},Transpose[sr.Transpose[br]]];
	   br = Map[mu[temp[#],#]&,br];
	   rs = Map[Prepend[#,1]&,br];
	 
	(* For Lines *)
	   br = Select[mat,First[#]==0&];
	   br = Map[Drop[#,1]&,br];
	   (* Lines after inverse mapping *)
	   br = If[Length[br]==0,{},Transpose[sr.Transpose[br]]];
	   br = Map[mu[temp[#],#]&,br];
	   ln = Map[Prepend[#,0]&,br];

	(* Form new matrix and polyhedron *)
	   sr = Union[ln,rs];
	   sr = ReplacePart[tr,sr,{4}];
	   br = dm[[3]][[1]][[2]][[1]];
	   br = ReplacePart[dm,br,{3,1}];

	(* Call DomAddRays for Polyhedra *)
	 
	   ReplacePart[dm,DomAddRays[br,sr][[3]][[1]],{3,1,2,1}]
	];

 DomAddRays[d1_Alpha`domain,m1_Alpha`matrix]:=
      DomAddRaysC[d1,m1]

(* Calls the polylib library in order to recompute the rays of 
a domain*)
Clear[domCompRays];
domCompRays[Alpha`domain[dim_,ind_,{Alpha`pol[lig_,_,_,_,c_,_]}]]:=
	Alpha`Domlib`DomConstraints[Alpha`matrix[lig,dim+2,ind,c]];

domCompRays[x_]:=(Message[domCompRays::arg]);


Clear[DomVisual]
DomVisual::mess1="Argument should be a domain"
DomVisual[d1_Alpha`domain]:=
			Module[{dParam},
				dParam=Alpha`$result[[2]];
			 	Alpha`Domlib`DomVisual[d1,dParam]
				]

DomVisual[d1_Alpha`domain,d2_Alpha`domain]:=
			Module[{},
				Alpha`Domlib`DomPrint[d1,d2]
				]
DomVisual[___]:=DomVisual::mess1;


Clear[solveEqualities];
Options[ solveEqualities ] := {debug->False};
(* If called with only a matrix, assume vector b is 0 *)
solveEqualities[a_List/;MatrixQ[a], opts:___Rule ]:=
  solveEqualities[a,Table[0,{i,1,Length[a]}]]
(* change *)
solveEqualities[a1:_List/;MatrixQ[a1],b1:_List/;VectorQ[b1], opts:___Rule ]:=
Catch[
  Module[
    {hu,h,u,rank,uInv,res,solExist,curLevel,solCur,solPart,dbg,i,a,b,c,mu,findlcm},
    findlcm[l_List] := Apply[LCM,Map[Denominator[#]&,l]];
    mu[l1_List,lm_Integer] := Map[lm*#&,l1];
    a = Map[mu[#,findlcm[#]]&,a1];
    c = Map[findlcm[#]&,a1];
    b = {};
    For[i=1 ,i<=Length[c] ,i+=1 ,b=Append[b,b1[[i]]*c[[i]]]];
    (* To debug, set this to True *)
    dbg = debug/.{opts}/.Options[ solveEqualities ];

    p=Length[a];      (* p is the number of lines of a *)
    k=Length[a[[1]]]; (* k is the number of columns of a *)

    If[ Length[b]!=p,Print[a,b];
      solveEqualities::wrgmatsize = 
        "wrong size for  matrices in solveEqualities";
      Throw[ Message[ solveEqualities::wrgmatsize ] ]
(* Should we return this?
 {{},{},{}},
*)
    ];

    (* Call Hermite normal form on a *)
    Check[
      hu=hermL[a],
      Throw[ Null ]
    ];

    If[ dbg, Print[ hu ] ];

    h = hu[[1]];
    u = hu[[2]];

    (* Number of 0 columns in h gives the rank of the system *)
    rank = k-Length[Select[Map[Apply[And,Map[(#==0 &),#]] &,
				      Transpose[h]],
				# &]];

    (* Take the last n-rank column of u^{-1} *)
    uInv = Inverse[u];
    res = Map[Drop[#,rank] &,uInv];

    If[ dbg, Print[ "Inverse of u: ", uInv ] ];
    If[ dbg, Print[ "res: ", res ] ];

    (* Remains to solve: ht=b, we do that by substitution. 
       The h matrix is a lower triangular matrix (échelonnée...)
       and the idea is to compute incremantally the solution, 
       starting from the value {0, ... 0}. The tricky part
       is that matrix h may have some 0 elements on the 
       diagonal, so that diagonal element may be 0. This is
       handled using the index curLevel. 
    *)
    solPart = Table[0,{i,1,k}];
    If[ dbg, Print[ "solving h.t = b, with h = ",h," and b = ", b ] ];
    If[ dbg, Print[ "solPart: ", solPart ] ];


    If[ dbg, Print[ "p: ",p ] ];
    If[ dbg, Print[ "b: ", b ] ];

    (* This is to compare the solution of what h.t = b with that 
       of LinearSolve. I guess that we could use this function 
       instead of the following program, but one does not know 
       if LinearSolve returns always an integral solution. PQ. *)    
    If[ dbg, Print[ "Result of linear solve: ", 
      LinearSolve[ h, b ] ] ]; 

    (* There was something very strange here... The loop goes on, 
       even if there is no solution... So I replaced the Do loop 
       by a while loop, and I put Breaks whenever I had solExist 
       False. PQ. *)

    (* Initialize the While loop *)
    i = 1; 

    solExist = True;
    curLevel = 1; (* curLevel is the actual position of the "diagonal"
                     element *)

    While[ solExist && i<=p,

      If[ dbg, Print[ "i: ", i, "\nh[[i]]: ", h[[i]] ] ];
      If[ dbg, Print[ "solExist: ", solExist ] ];
      If[ dbg, Print[ "curLevel: ", curLevel ] ];
      If[ dbg, Print[ "solPart: ", solPart ] ];

      (* curLevel must not be greater than k, the number of 
         comlumns of h *)
      If[ curLevel > k, 

        If[ Dot[h[[i]], solPart] =!= b[[i]], 
          (* The system has no solution, as the
             current solution does not meet h(i).solPart = b(i), 
             where h(i) is the i-th row of h *)
          solExist = False; Break[] 
        ]
        (* The current solution is OK, and we are going 

        *)
        ,

        (* curLevel is <= k *)
        If[ h[[i,curLevel]] == 0,
          If[ Dot[h[[i]], solPart] =!= b[[i]], 
            (* The system has no solution, as the
               current solution does not meet h(i).solPart = b(i), 
               where h(i) is the i-th row of h *)
            If[ dbg, Print[ "No solution" ] ];
            solExist = False; Break[]
          ],

          (* Extend current solution *)
          (* If, up to now, the current solution solPart is 
             OK, then we will modify solPart in order to integrate
             the i-th row of the system. First, we compute the
             i-th element of the solution, named solCur
          *)
          solCur = (b[[i]]-Dot[h[[i]],solPart])/h[[i,curLevel]];
          If[ dbg, Print["solCur: ", solCur ] ];

          (* Then, we check that solCur is integral, otherwise, 
             it means that there is no integral solution *)
          If[ !IntegerQ[solCur],
            (* The system has no integral solution *)
            solExist = False; Break[]
          ];

          If[ dbg, Print[ "solPart: ", solPart ] ];   
          If[ dbg, Print[ "solCur: ",solCur ] ];   
          If[ dbg, Print[ "curLevel: ", curLevel ] ];   

          (* Finally, if solCur is integral, we integrate it
             into solPart, at position curLevel *)
          solPart = ReplacePart[ solPart, solCur, curLevel];

          If[ dbg, Print[ "solPart: ", solPart ] ];   

          (* Now, we increment curLevel *)
          curLevel = curLevel+1;
          If[ dbg, Print[ "curLevel: ", curLevel ] ];   

        ]
      ];
      i = i+1;		    
	  ]; (* While *)

    If[ dbg, Print[ "solExist: ", solExist ] ];
    If[ dbg, Print[ "res: ", res ] ];
    If[ solExist,
      {Dot[Inverse[u],solPart],k-rank,res},
      {{},k-rank,res}
    ]
  ]
];

solveEqualities[a___]:=
  Module[{},
	 Print["Parameter error insolveEqualities",a];
	 $Failed
       ]

Clear[hermL]
hermL::failed = "";
hermL::wrongArg = "`1`";

hermL[m_List]:=
  Module[{tm,hm},
	 tm=Transpose[m];
	 hm=hermK[tm];
	 {Transpose[hm[[2]]],Transpose[hm[[1]]]}]
	  
hermL[a___]:= verbFail[hermL::failed,
  Module[{},
	 Message[hermL::wrongArg,{a}];$Failed
       ]
];

(* exchange rows l1 and l2 of matrix mat *)
Clear[echL]

echL[mat_List,l1_Integer,l2_Integer]:=
  Module[{ll1,mat1},
	 ll1=mat[[l1]];
	 mat1=ReplacePart[mat,mat[[l2]],l1];
	 ReplacePart[mat1,ll1,l2]]

echL[a___]:=
  Module[{},
	 Print["Parameter error in echL",a];
	 $Failed
       ]

(* exchange columns c1 and c2 of matrix mat *)
Clear[echC]

echC[mat_List,c1_Integer,c2_Integer]:=
  Module[{mattr},
	 mattr=Transpose[mat];
	 Transpose[echL[mattr,c1,c2]]
       ]

echC[a___]:=
  Module[{},
	 Print["Parameter error in echC",a];
	 $Failed
       ]

(* multiply line i of mat by x *)
Clear[mulL]

mulL[m_List,i_Integer,x_Integer]:=
  Module[{},
	 ReplacePart[m,x*m[[i]],i]]

mulL[a___]:=
  Module[{},
	 Print["Parameter error in mulL",a];
	 $Failed
       ]

(* multiply column  i of mat by x *)
Clear[mulC]

mulC[m_List,i_Integer,x_Integer]:=
  Module[{},
	 Transpose[mulL[Transpose[m],i,x]]
       ]

mulC[a___]:=
  Module[{},
	 Print["Parameter error in mulC",a];
	 $Failed
       ]

(* addition x times row q to row k of matrix m *)
Clear[addL]

addL[m_List,k_Integer,q_Integer,x_Integer]:=
  Module[{newL},
	 newL=m[[k]]+x*m[[q]];
	 ReplacePart[m,newL,k]]

addL[a___]:=
  Module[{},
	 Print["Parameter error in addL",a];
	 $Failed
       ]

(* addition x times column q to column k of matrix m *)
Clear[addC]

addC[m_List,k_Integer,q_Integer,x_Integer]:=
  Module[{},
	 Transpose[addL[Transpose[m],k,q,x]]
       ]
addC[a___]:=
  Module[{},
	 Print["Parameter error in addC",a];
	 $Failed
       ]

Clear[hermK];

hermK[m_List]:=
  Module[{n,p,hm,qm,pivot,x,i,numNullRows,posNullRows,wrongPosRows,oneWrongRow},
	 n=Length[m];
	 p=Length[m[[1]]];
	 hm=m;
	 qm=IdentityMatrix[n];
	 Do [i=ppc[hm,q];
	     While[(i!=0),
		   If [(i!=q),
		       hm=echL[hm,i,q];
		       qm=echC[qm,i,q]];
		   pivot=Part[hm,q,q];
		   If [pivot<0,
		       pivot=-pivot;
		       hm=mulL[hm,q,-1];
		       qm=mulC[qm,q,-1]];
		   Do [If[hm[[k,q]]!=0,
			  x=Floor[hm[[k,q]]/pivot];
			  hm=addL[hm,k,q,-x];
			  qm=addC[qm,q,k,x]]
		     ,{k,q+1,n}];
		   i=ppc[hm,q];]; (* end While *)
	     pivot=hm[[q,q]];
	     If [pivot<0,
		 pivot=-pivot;
		 hm=mulL[hm,q,-1];
		 qm=mulC[qm,q,-1]];
	     If [pivot!=0,
		 Do[If [hm[[k,q]]!=0,
			x=Floor[hm[[k,q]]/pivot];
			hm=addL[hm,k,q,-x];
			qm=addC[qm,q,k,x]];
		   ,{k,1,q-1}];
	       ], 
	   {q,1,Min[p,n]}]; (* enddo global *)
	   (* Apparently, this HNF do not fit 
	      to what we are looking  for. Indeed for the following  Matrix:
	       {{1, 1, 0}, {0, 0, 0}, {0, 0, 1}, {0, 0, 0}}}
	       it is in HNF while we would like the second row to 
	       be at the end *)
	   (* The algorithm is: if a null row is encountered before 
	      the end, it is pushed as a buble to the end *)
	   (* compute the number of null rows *)
	   numNullRows=Length[Select[hm,Apply[And,Map[(#==0 &), #]]&]];
	   posNullRows=Position[hm,Table[0,{i,1,p}]];
	 (* select the wrong Null Rows *)
	 wrongPosRows=Select[posNullRows, (Part[#,1]<=n-numNullRows) &];
	 While[Length[wrongPosRows]>0,
	       oneWrongRow=Part[wrongPosRows,1,1];
	       Do [ hm=echL[hm,count,count+1];
		    qm=echC[qm,count,count+1];
		 ,{count,oneWrongRow,n-1}];
	      posNullRows=Position[hm,Table[0,{i,1,p}]];
	       wrongPosRows=Select[posNullRows,  (Part[#,1]<=n-numNullRows) &];
	     ];
	 {qm,hm}]


hermK[a___]:= 
  Module[{},
	 Print["Parameter error in hermite",a];
	 $Failed
       ]

End[]

EndPackage[]
