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
        $Author: quinton $
	$Date: 2010/04/10 19:54:44 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Domlib.m,v $
	$Revision: 1.8 $
	$Log: Domlib.m,v $
	Revision 1.8  2010/04/10 19:54:44  quinton
	A correction was done to DomUniverse, which appeared to be incorrect. PQ
	
	Revision 1.7  2008/12/29 17:33:58  quinton
	Essentially, modification to dom2mma and const2mma so that symbols are translated into the special context Alpha`Work`
	
	Revision 1.6  2008/12/21 13:32:37  quinton
	Added functions DomTrueRays (returns the rays which are not lines of a domain),
	DomConstraints (returns the constraints of a domain) and DomLines (returns the lines
	of a domain).
	
	Revision 1.5  2008/07/27 13:29:56  quinton
	Most recent version.
	
	Revision 1.4  2008/04/18 16:52:33  quinton
	Correction to DomEmptyQ. I removed the function solveEqualities and replaced calls to this function by a call to external function solveDiophantine in package Matrix
	
	Revision 1.3  2008/04/01 19:39:07  quinton
	Changed the symbol Global sccdc into scdc, not sure that it does not hurt. A few character editions
	
	Revision 1.2  2005/04/07 16:51:50  quinton
	Adaptation to MacOSX
	
	Revision 1.50  2004/12/29 09:59:30  quinton
	Minor correction.
	
	Revision 1.49  2004/09/16 13:43:14  quinton
	Updated documentation
	
	Revision 1.48  2004/08/02 13:15:48  quinton
	Documentation updated for reference manual
	
	Revision 1.47  2004/07/08 14:06:48  risset
	commit Zpol changes
	
	Revision 1.46  2004/06/16 14:57:28  risset
	switched to ZDomlib
	
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

BeginPackage["Alpha`Domlib`"]
(*
BeginPackage["Alpha`Domlib`",
{"Alpha`Matrix`"}];
*)

Domlib::note = "Documentation revised on August 10, 2004"; 

DomLib::usage = 
"Domlib is a library of domain functions. It contains the functions const2al,
const2mma, dom2mma, dom2al, domCompRays, DomAddRays, DomBasis, DomConstraints,
DomConvex, DomCost, DomDifference, DomEmpty, DomEmptyQ, DomEqualities,
DomEqualQ, DomExtend, DomImage, DomIntersection, DomIntEmptyQ, DomLeftHermite,
DomLTQ, DomMatrixSimplify, DomPreimage, DomProject, DomRays, DomRightHermite,
DomSimplify, DomSort, DomUnion, DomUniverse, DomUniverseQ, DomVertices,
DomVisual, DomZImage, DomZPreimage, hypercube, LatticeDifference,
LatticeImage, LatticeIntersection, LatticeHermite, LatticePreimage,
linearConstraintQ, linearExpQ, linHalfSpace, polToZpol, rays, vertices,
and zpolToPol.";

Domlib::err1 = "Error... `1";
Domlib::xxx = "Error... `1";

Domlib::note =
"Domlib is based upon the PolyLib library, which is a set of public domain 
C programs first developed at Irisa. Domlib is interfaced to this library
using MathLink."; 

domlib::usage =
"Math link. Link to the external program \"domlib\". The mechanism of 
MathLink is pretty complicated and needs to be clarified here.";

const2al::usage = 
"const2al[ind,c] translates in Alpha form the constraint c. 
ind is an index list (e.g. {\"i\",\"j\"}) and c is a constraint in
form eq[i+2j,3] or ge[i+2j,3].";

const2mma::usage = 
"const2mma[indexList,vectorList] converts a constraint, expressed as a list of 
index names and a list of vectors, into Mathematica form";

dom2mma::usage = 
"dom2mma[d] converts Alpha domain d into a pair {constraints,index} (e.g.
{{i,j},{i+j>=2,...}}) suitable for Mathematica."; 
	
dom2al::usage = 
"dom2al[{cst,ind}] translates a domain given in MMA
form into its Alpha encoding. ind is a list of indexes, and cst is
a list of constraints of the form i+j > 2. Warning: left-hand side is
the linear part, and right-hand side is an integer.";

dom2al::note =
"In dom2al, the symbols must be strings, otherwise there is a problem.
This has to be checked.";

domCompRays::usage = 
"domCompRays[dom] recomputes the rays of the Alpha domain dom and
returns an Alpha domain. domCompRays ignores the ray part of dom, and
recomputes it. This function allows one to modify a contraint in a domain,
and to update the domain accordingly.";

domHalfSpaceQ::usage = 
"domHalfSpaceQ[dom] is True if the Alpha domain dom is a half-space. dom 
is either a string or an ast.";

DomAddRays::usage = 
"DomAddRays[dom,m] returns the domain dom augmented with rays from the matrix
m. rays are in Alpha format (i.e. n+2 components for n dimensions).\n
Example: \n
dom is {i,j | i >= 0},\n
m=matrix[3, 4, {}, {{1, 0, 1, 0}, {1, 10, 10, 1}}],\n
DomAddRays[dom,m] returns {i,j | 0<=i<=(j,10)}."

DomBasis::usage = 
"DomBasis[m] returns a row basis of the Alpha matrix m using Gauss 
Jordan-elimination.";

DomConstraints::usage = 
"DomConstraints[m] returns the minimum convex polyehdron defined by 
the constraint matrix m. DomConstraints[m1,m2] returns the Z-polyhedron 
obtained by image of the polyhedrom P by the invertible mapping m1, 
where P is the minimum convex Polyhedron satisfying the constraints 
given in m2, i.e., Z = m1(DomConstraints[m2]).";

DomConvex::usage = 
"DomConvex[d] returns the minimum convex polyhedron which encloses the
(polyhedral or Z) domain d. Warning (4/11/98), this function was bugged 
in Polylib, and the current implementation uses DomRays instead of 
DomConvex.";

DomCost::usage = 
"DomCost[d, c] returns the interval of values of the cost function c
evaluated over domain d = {MinN, MinD, MinI, MaxN, MaxD, MaxI}."

DomCost::note =
"DomCost is a function of the Domlib library, and what it does in 
not clear.";

DomDifference::usage = 
"DomDifference[d1, d2] returns the domain difference of domain d1 less d2."

DomEmpty::usage = 
"DomEmpty[n] returns the empty domain of dimension n."

DomEmptyQ::usage = 
"DomEmptyQ[d] returns True if domain d is empty, False otherwise. The
test of emptyness is based uniquely on the rational polyhedron, not the 
integral polyhedron."

DomEqualities::usage = 
"DomEqualities[d] returns the matrix of equations (lineality space) of
domain d (does not handle union of convexes).";

DomEqualQ::usage = 
"DomEqualQ[d] returns True if domain d1 is equivalant to d2, False
otherwise."

DomExtend::usage = 
"DomExtend[dom, idx] extends  dom to the indices in the index list idx. 
This list should contains the indices of dom.";

DomImage::usage = 
"DomImage[d,m] returns the image of the domain d under the transformation 
matrix m. This function always returns a polyhedral domain. 
If d is a Z-Domain, it returns the image of the rational polyhedral 
domain enclosing the Z-Domain."

DomIntersection::usage = 
"DomIntersection[d1, d2] returns the domain intersection of domains d1 and d2."

DomIntEmptyQ::usage = 
"DomIntEmptyQ[dom1, dom2] returns True if dom1 contains no integral points
in the context of dom2, False otherwise. ??";

DomLeftHermite::usage = 
"DomLeftHermite[m] returns {H, Q} where m = HQ, Q unimodular, H hermite.
(Warning, bugged function please use hermiteL[]).";

DomLTQ::usage = 
"DomLTQ[dom1, dom2, idx, pdim] compares dom1 and dom2 at index position
idx (integer). pdim is the dimension of the parameter space. Returns 1 if
dom1>dom2, returns -1 if dom1<dom2, returns 0 if dom1><dom2 (whatever it
means.)";

DomLTQ::note = 
"DomLTQ does not check the type and number of parameters.";

DomMatrixSimplify::usage = 
"DomMatrixSimplify[m1,m2] returns m1 simplified in the presence of m2.";

DomPreimage::usage = 
"DomPreimage[d,m] returns the preimage of the domain d under the transformation 
matrix m. This function always returns a polyhedral domain. For a
ZDomain, it returns the pre-image of the rational polyhedral domain 
enclosing the ZDomain.";

DomProject::usage =  
"DomProject[dom, idx] projects dom onto the indices given 
in the index list idx. Reorders indices and changes the dimension
accordingly.";

DomRays::usage = 
"DomRays[m] returns the minimum convex polyhedron defined by the rays 
given in the matrix m.";

DomRightHermite::usage = 
"This function is bugged, use hermiteR instead.
DomRightHermite[m] returns the Hermite decomposition {Q, H} of the
Alpha matrix m, i.e. m = QH, Q unimodular, H Hermite.";
  
DomSimplify::usage = 
"DomSimplify[d1, d2] returns a domain equal to d1 simplified in 
the context of d2. In other words, we remove of the definition of
d1 all constraints which are implied by d2.";

DomSort::usage = 
"DomSort[ldom, idx, pdim, time:True|False] returns the 
topological ordered list of domains ldom. idx is the level to 
consider for sorting, pdim is the parameter space dimension. 
Returns a list of logical times (one per domain) if time is True, 
otherwise it returns a permutation of ldom. An application of this 
permutation to ldom returns a sorted list.";

DomSort::note = 
"This function seems to be fragile. The only place where it is used 
is in the INorm package.";

DomUnion::usage = 
"DomUnion[d1, d2] returns the domain union of domains d1 and d2."

DomUniverse::usage = 
"DomUniverse[n]	returns the universe domain of dimension n."

DomUniverseQ::usage = 
"DomUniverseQ[d] returns True if domain d is the universe, False otherwise."

DomVertices::usage = 
"DomVertices[ldom, context] finds the parametrized vertices of a list 
of parametrized polyhedra ldom. context is the domain of 
parameters. It returns a list of pairs whose elements contain 
a parameter domain, and a list of parametrized vertices. 
DomVertices[pol, param] finds the parametrized vertices 
of a parametrized polyhedron pol.
DomVertices[pol], finds the vertices of the non-parametrized 
polyhedron pol. It returns {{e,l}} where e is the universe 0-domain and 
l is a list of non-parametrized vertices.";

DomVertices::note =
"This function seems to be fragile. It is used nowhere in MMAlpha.";

DomVisual::usage = 
"DomVisual[d1,d2] visualizes the domain d1 with the Opera tool. d2 is
the parameter domain. Warning if the domain d2 is ommited, it is
replaced by the parameter domain of $result. WARNING: CURRENTLY NOT
AVAILABLE (the function does nothing)."
  
DomZImage::usage = 
"DomZImage[dom, mat] finds the Z-image of the domain dom by the matrix mat.
This function may or may not return a Z-Domain depending on the 
transformation matrix.";
  
DomZPreimage::usage =
"DomZPreimage[dom, mat] finds the Z-Preimage of the domain dom by the 
matrix mat. This function may or may not return a Z-Domain depending on 
the transformation matrix.";

hypercube::usage = 
"hypercube[n] creates a hypercubic domain (in Mathematica form) of dimension n, 
and size 10. dom2l[hypercube[n]] allows such a domain to 
be translated into Alpha form. Useful for testing purposes."; 

LatticeDifference::usage = 
"LatticeDifference[m1,m2] returns the difference of the lattices m1 and m2.";

LatticeDifference::note =
"Seems to return a list of matrices.";

LatticeImage::usage = 
"LatticeImage[m1,m2] returns the image of the lattice m1 by the function m2.";

LatticeIntersection::usage = 
"LatticeIntersection[m1,m2] returns the intersection of the lattices m1 and m2.";

LatticeHermite::usage = 
"LatticeHermite[m] returns the lattice m in Hermite Normal Form.";

LatticePreimage::usage = 
"LatticePreimage[m1,m2]	returns the preimage of the lattice m1 by the 
function m2.";

linearConstraintQ::usage = 
"linearConstraintQ[c,{symbols}] is True if c is a linear constraint
formed with symbols, False otherwise."; 

linearExpQ::usage = 
"linearExpQ[exp,{symbols}] is True if exp is a linear expression 
formed with symbols, False otherwise.";

linearConstraintQ::notalinearc = 
"`1` is not a linear constraint on variables `2`";

linHalfSpace::usage = 
"linHalfSpace[h] returns the Mathematica Matrix corresponding to the Alpha
half-space h."; 

polToZpol::usage = 
"If the domain d is a union of polyhedra, polToZpol[d] returns the
equivalent Z-polyhedron, otherwise it returns d as is.";

rays::usage = 
"rays[d] returns the list of rays of the Alpha domain d. rays[{const,index}]
returns the vertices of d given in Mathematica form.";

vertices::usage = 
"vertices[d] returns the list of vertices of the Alpha domain d. 
vertices[{const,index}] returns the vertices of d given in Mathematica form.";

zpolToPol::usage = 
"If the domain d is a Z-Domain, zpolToPol[d] returns the rational polyhedral
domain enclosing d, otherwise it returns d as is.";

zpolIsPolQ::usage = 
"zpolIsPolQ[d] is True if the Z-polyhedron d is actually a polyhedron
(i.e. has identity matrices as lattices).";

(* Error messages *)

linHalfSpace::arg = "argument is not a Half Space";

const2mma::typeError = 
"parameters: `1` should be an index list (free mma symbols) and a list of integers";

dom2mma::typeError = "parameter should be a domain. Note: dom2mma does not 
handle union of domains, for the moment.";

dom2mma::wrgdom = "error while calling const2mma. Input domain seems to be incorrect.";

dom2al::typeErr = "parameters should be {constraint,index}";
dom2al::cst2l = "error when calling internal function const2al.";
dom2al::domcpr = "error when calling internal function domCompRays.";
domCompRays::arg = "parameter should be an Alpha domain";

domHalfSpaceQ::arg = "parameter should be an Alpha domain";

hypercube::typeError = "wrong arguments.";

vertices::typeError = "parameter should be a domain either in Alpha or in MMA form";

rays::typeError = "parameter should be a domain either in Alpha or in MMA form";

DomTrueRays::usage = 
"DomTrueRays[ dom ] returns the list of true rays of dom, i.e. rays which
are not lines";

DomConstraintsOfDom::usage = 
"DomConstrainsOfDom[ dom ] returns the constraints "; 

DomLines::usage = 
"DomLines[ dom ] returns the lines of dom"; 

Begin["`Private`"]

(* Installs the link to the external program "domlib" (C-based implementation
   of domain operators 'union', 'intersection', 'difference' etc. *)

(* That's where one create global symbols... *)
Print["Loading Domlib"];
Print["Context is: ", $Context];
Module[{domlib},
  Which[
    (* Unix *)
    $OperatingSystem=="Unix" || $OperatingSystem=="MacOSX",
    Uninstall /@ Cases[Links[], LinkObject["domlib", __]];
    domlib = Install["domlib"];
    If[domlib === $Failed, Print["Warning: could not install domlib"]]
  ,
    (* Windows *)
    $OperatingSystem=="WindowsNT",			
    Print["Installing Zdomlib"];
    (* domlib=Install[Environment["MMALPHA"]<>"\bin.cygwin32\domlib.exe"];
    domlib = Install["domlib"];	
    domlib = Install[Environment["MMALPHA"]<>"\bin.cygwin32\domlib"];*)
    (* Where is it... *)
    Print[" I am going to install Domlib "]; (* Added by Patrice to trace
					      *)
    domlib = Install["Domlib"];
    Print["domlib is : ",domlib];
    If[domlib === $Failed, Print["Warning: could not install domlib"]] 
  ]
];

(* zpolIsPolQ checks whether a zpolhedron is a real polyhedron. 
   This function is used by DomZimage to change the result to a 
   polyhedron when possible 
*)

Clear[polToZpol];
polToZpol::params = "wrong parameters"
polToZpol[a:Alpha`domain[0,_,_]] := a;
polToZpol[po:Alpha`domain[dim_Integer,id_List,p:{_Alpha`pol..}]] :=
        Alpha`domain[dim,{},{Alpha`zpol[Alpha`matrix[dim+1,dim+1,id,IdentityMatrix[dim+1]],p]}];
polToZpol[a_Alpha`domain] := a;
polToZpol[___] := Message[PtoZ::params];

(* Maybe one should convexize the domain returned by zpolToPol *)
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
       res];

zpolIsPolQ[zp:Alpha`domain[dim_Integer,id_List,z:{_Alpha`pol..}]] := True;

zpolIsPolQ[$Failed] := $Failed;

zpolIsPolQ[___] := Message[zpolIsPolQ::params];

DomPrint::usage = 
"DomPrint[d1,d2] shows the domain d1, with d2 being the parameter domain.
WARNING: CURRENTLY NOT AVAILABLE (the function does nothing)";

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
      DomIntersectionC[d1,d2]
    ]
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

(*  Union of polyhedra or ZPolyhedra*)
Clear[DomUnion];
DomUnion::params = "wrong parameters";
(* Polyhedra *)
DomUnion[d1:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}], d2:Alpha`domain[_,_,{Alpha`pol[_,_,_,_,_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomUnion::wrongDim]],
      DomUnionC[d1,d2]]
  ]
];

(* ZPolyhedra *)
DomUnion[d1:Alpha`domain[_,_,{Alpha`zpol[_,_]..}], d2:Alpha`domain[_,_,{Alpha`zpol[_,_]..}]]:=
Catch[
  Module[{},
    If[ d1[[1]]=!=d2[[1]],
      Alpha`ashow[d1];Alpha`ashow[d2];
      Throw[Message[DomUnion::wrongDim]]
    ];

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
DomUnion[___] := Message[DomUnion::params];

Clear[DomUniverse];
DomUniverse[d:_Integer]:=
  DomUniverse[d,Table[ "i"<>ToString[k],{k,1,d}]];
DomUniverse[d_Integer, indexes:{___String}] :=
Module[
  { i, j, rv },
  (* This part computes the list of rays and vertices of the
    domain. For an unknown reason, the unique vertex has to be 
    the last one... *)
  rv = 
    Table[Which[j==i+1, 1, i==0 && j==(d+2),1,True, 0],
                   {i,0,d}, {j,1,d+2}
    ];
  (* Put the first element at the end... *)
  rv = Drop[ Append[ rv, rv[[1]] ], 1 ];
  Alpha`domain[
    d,indexes,
    {
      Alpha`pol[1,d+1,0,d,
        {Table[Which[i==1, 1, i==(d+2), 1, True, 0], {i,d+2} ] },
        rv
      ]
    }
  ]
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
DomUniverseQ[_Alpha`domain] := False;
DomUniverseQ[___]:=Message[DomUniverseQ::params];
DomUniverseQ::params = "wrong parameters";
DomUniverseQ::usage = 
"DomUniverseQ[d] returns True if domain d is the universe, False otherwise."

(* 

  This function is only used in DomEmptyQ. The idea is to 
  find out if there is an integral solution to this system, 
  whenever we discover that the domain is not empty.

*)
Clear[noIntegralSoln];
noIntegralSoln[{}] := False;
noIntegralSoln[c_List] := 
Catch[
  Module[ { app, mmap, argSolve, sol, dbg, mmap2, res1, res2 },
    dbg = False; 
    (* Compute the arguments *)
    argSolve = Map[ 
      (List[{Take[#,{2,Length[#]-1}]},{-Last[#]}])&, c
    ];
    If[ dbg, Print[ "Argument of solveDiophantine: ", argSolve ] ]; 
    Check[
      sol = Apply[ Alpha`Matrix`solveDiophantine, argSolve[[1]] ],
      DomEmptyQ::err = "error while calling solveDiophantine";
      Throw[ Message[ DomEmptyQ::err ] ];
    ];
    If[ dbg, Print[ "solution: ", sol ] ]; 

    mmap2 = Map[
      (First[Alpha`Matrix`solveDiophantine[{Take[#,{2,Length[#]-1}]},{-Last[#]}]]=={})&,
      c  
    ]; 
    If[ dbg, Print[ "mmap2 ", mmap2 ] ];
    res2 = Apply[ And, mmap2 ];
    If[ dbg, Print["res2: ", res2] ]; res2
  ]
];

(*
  Checking the emptyness of a domain is not obvious...
*)
(* **************** *)
Clear[DomEmptyQ];
(* First case: the domain is a polyhedron *)
(* When the dimension of the domain is equal to the number 
   of equalities minus one, then the domain is necessary empty *)
DomEmptyQ[Alpha`domain[d_,_,{Alpha`pol[_,_,e_,_,c_,_]}]]/;(e==d+1) := True;
DomEmptyQ[Alpha`domain[d_,_,{Alpha`pol[_,_,e_,_,c_,_]}]] :=
Module[ { s, dbg },
    (* If not, then try to find out if the system of equalities has an 
       integral solution. If it has not, then the polyhedron is empty. *)
    dbg = False; s={};
    For[i=1,i<=Length[c],i++,If[First[c[[i]]]==0,s=Append[s,c[[i]]]]];
    If[ dbg, Print["System s: ", s] ];
    noIntegralSoln[s]
];

(* 
  For a Z-polyhedron, call the function in the Polylib
*)
DomEmptyQ[d: Alpha`domain[_,_,{Alpha`zpol[_,p_]}]] :=
Module[{s},
  If[DomZEmptyQC[d],
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
DomProject1[dm2:Alpha`domain[_,_,{Alpha`zpol[Alpha`matrix[_,_,_,_],{_Alpha`pol..}]}],idlst2:{__String}]:=
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

(* For a Z-polyhedron *)
DomProject[dm3:Alpha`domain[zdm:_Integer,_,zlst:{_Alpha`zpol..}],idlst3:{__String}]:=
Module[
  {tmp},
  tmp = ReplacePart[dm3,Map[DomProject1[ReplacePart[dm3,{#},{3}],
    idlst3][[3,1]]&,zlst],{3}];
  ReplacePart[tmp,tmp[[3,1,1,2]]-1,{1}]
];

(* For a polyhedron *)
DomProject[dom:_Alpha`domain, idx:{__String}]:=
Catch[
  Module[{m,idy,leni,lenj,i,j},
    idy  = Part[dom,2];
    If[Complement[idx, idy] =!= {},Throw[Message[DomProject::wrgindex]]];
    leni = Part[dom,1]+1;
    lenj = Length[idx]+1;
    m = Alpha`matrix[ lenj, leni, idy,
          Table[ If[ (i<leni && j<lenj && (Part[idy,i]===Part[idx,j])) ||
             (i===leni && j===lenj), 1, 0 ], {j,1,lenj}, {i,1,leni}] 
        ];
    ReplacePart[ DomImage[dom, m], idx, 2 ]
  ] (* Module *)
]; (* Catch *)

(* project on dimension 0 *)
DomProject[dom:_Alpha`domain,{}]:=DomUniverse[0];

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
     ]		(* error : doesn't work on 0-dim polyhedra *)
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
]		(* error : doesn't work on 0-dim polyhedra *)

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

Clear[DomSimplify];
DomSimplify::params = "wrong parameters";
DomSimplify[
  d1:Alpha`domain[_,_,{_Alpha`pol..}],
  d2:Alpha`domain[_,_,{_Alpha`pol..}]] := DomSimplifyC[d1,d2];

DomSimplify[
  d1:Alpha`domain[_,_,{_Alpha`pol..}],
  d2:Alpha`domain[_,_,{_Alpha`zpol..}]] := DomSimplifyC[d1,zpolToPol[d2]];

DomSimplify[
  d1:Alpha`domain[dim_,_,mlst:{_Alpha`zpol..}],d2:Alpha`domain[_,_,{_Alpha`pol..}]] :=
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
const2mma[ 
  ind:{}|{(_Symbol|_String)..},
  x:{___Integer}]/;Length[x]==Length[ind]+2:=
Catch[
  Module[{o,lp,c,ind1},

    (* The following is tricky. All indexes are created as symbols in
      the special context Alpha`Work`, in order not to conflict with those
      of MMAlpha *)
    BeginPackage["Alpha`Work`"];
    ind1 = ToExpression[ind];
    EndPackage[];
    Check[o=oper[x],Throw[Message[const2mma::wrgx]]];
    Check[lp=linpart[x],Throw[Message[const2mma::wrgx]]];
    Check[c=coeff[x],Throw[Message[const2mma::wrgx]]];
    {ind1,o[lp.ind1,-c]}
  ]
]
const2mma[a___]:=Message[const2mma::typeError,a];

(* converts a pair index, constraint into an alpha constraint *)
Clear[const2al];
const2al::typeError = "parameters should be an index list (free mma symbols) and a constraint";
const2al[
  ind:{__},
  (h:(Alpha`eq|Alpha`ge))[exp_,n_Integer]
]:=
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
dom2mma[dd: Alpha`domain[dim_,ind1_,{Alpha`pol[_,_,_,_,c_,_]}]]:=
Catch[
  Module[{d,ind},
   (* This is needed in order to create indexes that are not conflicting
     with those of MMAlpha *)
    BeginPackage["Alpha`Work`"];
    ind = ToExpression[ind1];
    EndPackage[];
    Check[
      d = Map[const2mma[ind,#1]&,c],
      Throw[Message[dom2mma::wrgdom]]
    ];
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

(* Encodes a pair {index,constraints} into an alpha domain *)
Clear[dom2al];

(* Universe bottom domain *)
dom2al[{{},{}}]:=DomUniverse[0]; 

(* Encode constraints before processing *)
dom2al[{const:{___?constraintMmaQ}/;Length[const]>0,y:{}|{(_Symbol|_String|scdc[___])..}}]:=
     dom2al[{Map[encode,const],y}]; 

(* Definition, properly speaking *)
dom2al[{const:{___?constraintQ},ind:{__}}]:= 
Catch[
  Module[{m,d},
(*    Print[FullForm[const]]; *)
    Check[m = Map[const2al[ind,#1]&,const],Throw[Message[dom2l::cst2l]]];
(*    Print[FullForm[m]]; 
    Print[Length[const]]; *)
    Check[
      d = domCompRays[
            Alpha`domain[
              Length[ind],
                ind,
                {Alpha`pol[Length[const],0,0,0,m,{}]}
                             ]
                         ],
          Throw[Message[dom2al::domcpr]]
    ];
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

Clear[ DomConstraintsOfDom ];
DomConstraintsOfDom[d:_Alpha`domain]:=
Module[{c,tc,eq},
  c = d[[3]][[1]][[5]];
  c = Drop[ c, -1 ];
  tc = Select[ c, #[[1]] === 1& ];
  tc = Map[ Drop[#,1]&, tc];
  eq = Select[ c, #[[1]] === 0& ];
  eq = Map[ Drop[#,1]&, eq];
  {tc,eq}
];
DomConstraintsOfDom[d:_Alpha`domain, index:_String]:=
Catch[
  Module[{c,tc,eq,indexPos},
    If[ !MemberQ[ d[[2]], index ],
      DomConstraintsOfDom::wrngindex = "index does belong to domain";
      Throw[ DomConstraintsOfDom::wrngindex ]
    ];
    indexPos = First[First[Position[ d[[2]], index ] ] ];
    c = d[[3]][[1]][[5]];
    c = Drop[ c, -1 ];
    c = Select[ c, (Part[#,indexPos+1]=!=0)&];
    tc = Select[ c, #[[1]] === 1& ];
    tc = Map[ Drop[#,1]&, tc];
    eq = Select[ c, #[[1]] === 0& ];
    eq = Map[ Drop[#,1]&, eq];
    {tc,eq}
  ]
];
DomConstraintsOfDom[___] := Message[ DomConstraintsOfDom::params ];

Clear[ DomLines ];
DomLines[d:Alpha`domain[dim_,ind_,{x:Alpha`pol[_,_,_,_,c_,_]}]]:=
Module[{sr,br,r},
  r = d[[3]][[1]][[6]];
  (* Lines *)
  br = Select[r,Last[#]==0&&First[#]==0&];
  br = Map[Drop[Drop[#,-1],1]&,br];
  br
];
DomLines[___] := Message[ DomLines::params ];

Clear[ DomTrueRays ];
DomTrueRays[d:Alpha`domain[dim_,ind_,{x:Alpha`pol[_,_,_,_,c_,_]}]]:=
Module[{sr,br},
  r = d[[3]][[1]][[6]];
  (* True rays *)
  sr = Select[r,Last[#]==0&&First[#]==1&];
  sr = Map[Drop[Drop[#,-1],1]&,sr];
  sr
];
DomTrueRays[___] := Message[ DomTrueRays::params ];

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
Clear[ DomAddRays ];
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
  DomAddRaysC[d1,m1];
DomAddRays[___] := DomAddRays::params;

(* Calls the polylib library in order to recompute the rays of 
a domain*)
Clear[domCompRays];
domCompRays[Alpha`domain[dim_,ind_,{Alpha`pol[lig_,_,_,_,c_,_]}]]:=
	Alpha`Domlib`DomConstraints[Alpha`matrix[lig,dim+2,ind,c]];

domCompRays[x_]:=(Message[domCompRays::arg]);

Clear[DomVisual];
DomVisual::mess1="Argument should be a domain"
DomVisual[d1_Alpha`domain]:=
Module[{dParam},
  dParam=Alpha`$result[[2]];
  Alpha`Domlib`DomVisual[d1,dParam]
];

DomVisual[d1_Alpha`domain,d2_Alpha`domain]:=
  Alpha`Domlib`DomPrint[d1,d2];
DomVisual[___]:=DomVisual::mess1;

End[]

EndPackage[]
