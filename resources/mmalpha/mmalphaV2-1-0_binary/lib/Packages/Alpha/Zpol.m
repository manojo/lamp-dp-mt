(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR :  Tanguy Risset
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
BeginPackage["Alpha`Zpol`", {"Alpha`Domlib`",  
			     "Alpha`",
                               "Alpha`Options`",
                               "Alpha`Matrix`",
			     "Alpha`Tables`"
			     }]

(* $Id: Zpol.m,v 1.1 2005/03/11 16:40:17 trisset Exp $  *)
(* Standard head for CVS

	$Author: trisset $
	$Date: 2005/03/11 16:40:17 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Zpol.m,v $
	$Revision: 1.1 $
	$Log: Zpol.m,v $
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.4  2004/09/16 13:45:23  quinton
	Updated documentation
	
	Revision 1.3  2004/08/02 13:13:26  quinton
	Documentation updated for reference manual
	
	Revision 1.2  2004/07/08 14:06:51  risset
	commit Zpol changes
	
	Revision 1.1  2001/05/07 14:26:26  risset
	restaur Zpol.m
	
	Revision 1.16  2001/05/07 13:39:44  risset
	test for control M
	
	Revision 1.15  1999/12/10 16:59:06  risset
	commited struct Sched and ZDomlib
	
	Revision 1.14  1999/05/18 16:24:33  risset
	change many packages for documentation
	
	Revision 1.13  1999/05/10 15:21:00  risset
	supressed the Decomposition Package, put it in Cut
	
	Revision 1.12  1999/05/10 14:56:23  alpha
	 changed things for docs
	
	Revision 1.11  1999/05/06 12:08:52  risset
	corrected isSpaceSepQ
	
	Revision 1.10  1999/04/15 13:18:14  quinton
	Corrections
	
	Revision 1.9  1999/03/02 15:49:31  risset
	added GNU software text in each packages
	
	Revision 1.8  1997/05/19 10:41:55  risset
	corrected exported bug in depedancies

	Revision 1.7  1997/04/10 09:20:05  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.6  1996/07/22 15:18:25  risset
	added image by rationnal matrix

	Revision 1.5  1996/06/24 13:55:15  risset
	added standard head comments for CVS



*)

Zpol::note = "Documentation revised on August 10, 2004";

Zpol::usage =
"The Alpha`Zpol` package contains additional functions for computing
with Z-polyhedra. These functions are expressLatticeWithMat, 
expressZpolWithMat, getMatOfZpol, and getPolOfZpol.";

Zpol::note = 
"The internal representation of a Zpol is:\ndomain[dim_Integer, {___String},
{___zpol[m_matrix,{___pol}]}] (which is m(p)).";

expressLatticeWithMat::usage=
"expressLatticeWithMat[sys,m] returns a system where all Z-polyhedra 
using lattices corresponding to the matrix m are rewritten so as 
to appear with matrix m as lattice. Default value of sys is $result.
expressLatticeWithMat[sys,m,pos] modifies only the 
Z-domain at position pos of the Alpha abstract syntax tree."

expressZpolWithMat::usage=
"expressZpolWithMat[z,M] attempts to change the representation    
of the Z-polyhedron z. Assuming z = N(P), we expect a result of the 
form w = M(P') where M is the matrix given as second argument, hence 
it returns M(P') where P'=M^{-1} N(P). If M and N do not represent 
the same lattice, it gives a warning and return z unchanged. 
If z is a union of Z-polyhedra, it fails."

getMatOfZpol::usage=
"getMatOfZpol[z] returns the matrix used for identifying the 
lattice of a Z-polyhedron z. If z=M(P), it returns M. If Z is already a 
polyhedron, it returns the identity matrix. If z is a union of 
Z-polyhedra, it fails."

getPolOfZpol::usage=
"getPolOfZpol[z] returns the polyhedron used as source for generating 
a Z-polyhedron z. If z=M(P), it returns P. If z is already 
a polyhedron, it returns z. If z is a union of Z-polyhedra, it fails.";

Begin["`Private`"]

Clear[getPolOfZpol]

Options[getPolOfZpol]={debug->False}

getPolOfZpol[d:domain[dim_,_,{_zpol}],options___Rule]:=
Module[{pol,indices},
       pol=d[[3,1,2]];
       indices=d[[3,1,1,3]];
       domain[dim,indices,pol]
       ]

getPolOfZpol[d:domain[dim_,_,{___pol}],options___Rule]:=d

getPolOfZpol[d:_domain,options___Rule]:=$Failed

getPolOfZpol::wrongArg="wrong Argument for function getPolOfZpol : `1` "

getPolOfZpol[a:___]:=Message[getPolOfZpol::wrongArg,Map[Head,{a}]]


Clear[getMatOfZpol]

Options[getMatOfZpol]={debug->False}

getMatOfZpol[d:domain[dim_,_,{_zpol}],options___Rule]:=d[[3,1,1]]

getMatOfZpol[d:domain[dim_,_,{___pol}],options___Rule]:=
Module[{indices},
       indices=d[[2]];
       idMatrix[indices,indices]];

getMatOfZpol[d:_domain,options___Rule]:=$Failed

getMatOfZpol::wrongArg="wrong Argument for function getMatOfZpol : `1` "

getMatOfZpol[a:___]:=Message[getMatOfZpol::wrongArg,Map[Head,{a}]]




Clear[expressZpolWithMat]

Options[expressZpolWithMat]={debug->False}


expressZpolWithMat[d:domain[dim_,_,{_zpol}],M:_matrix,options___Rule]:=
Module[{N,Minv,MinvN,P,PPrime,res},
       N=getMatOfZpol[d];
       P=getPolOfZpol[d];
       If[First[hermite[N]]=!=First[hermite[M]],
          Print["Warning, the matrix does not reprensent the canonical Lattice, expression impossible "];
          Return[d]];
       Minv=inverseMatrix[M];
       MinvN=composeAffines[Minv,N];
       PPrime=DomImage[P,MinvN];
       res=domain[d[[1]],d[[2]],{zpol[M,PPrime[[3]]]}]
]
                    
(* if the zpolyhedron is a polyhedron *)
expressZpolWithMat[d:domain[dim_,_,{___pol}],m:_matrix,options___Rule]:=
Module[{},
       If[Abs[determinant[m]]===1,Return[d],
          Print["Warning, the matrix does not reprensent the canonical Lattice "];
          Return[d]]
       ]

expressZpolWithMat::wrongArg="wrong Argument for function expressZpolWithMat : `1` "

expressZpolWithMat[a:___]:=Message[expressZpolWithMat::wrongArg,Map[Head,{a}]]



Clear[expressLatticeWithMat]

Options[expressLatticeWithMat]={debug->False}

expressLatticeWithMat[M:_matrix,options___Rule]:=
Module[{res},
       res=expressLatticeWithMat[$result,M,options];
       If[MatchQ[res,_system],
          $result=res,
          $result]
       ]

expressLatticeWithMat[sys:_system,M:_matrix,options___Rule]:=
Module[{dbg,posMat,hermiteOfM,concernedMatricesPos, tempSys},
       dbg = debug/.{options}/.Options[expressLatticeWithMat];
       (* get all the position of the matrices in the Alpha system *) 
       posMat=Map[Drop[#,-1] &, Position[sys,matrix,Infinity]];
       If[dbg,Print["posMat",posMat]];
       (* select the ones that correspond to M *)
       hermiteOfM=First[hermite[M]];
       concernedMatricesPos=Select[posMat,First[hermite[getPart[sys,#]]]===hermiteOfM &];
       (* select only the ones that are lattices of Zpols *) 
       concernedMatricesPos=Select[concernedMatricesPos,getPart[sys,Append[Drop[#,-1],0]]===zpol &];
       If[dbg,Print["Position of concerned matrives: ",concernedMatricesPos]];
       tempSys=sys;
       Do[tempSys=expressLatticeWithMat[tempSys,M,Drop[concernedMatricesPos[[i]],-3]]
          ,{i,1,Length[concernedMatricesPos]}];
       tempSys]

expressLatticeWithMat[M:_matrix,pos:_List,options___Rule]:=
Module[{res},
       res=expressLatticeWithMat[$result,M,pos,options];
       If[MatchQ[res,_system],
          $result=res,
          $result]
  ]

expressLatticeWithMat::wrongPos="Wrong position given to expressLatticeWithMat: object at pos `2`  of system `1` is not a Zpol" 

expressLatticeWithMat[sys:_system,M:_matrix,pos:_List,options___Rule]:=
Module[{zpol1,newZpol,newSys},
       zpol1=getPart[sys,pos];
       If[!MatchQ[zpol1,_domain],
          Message[expressLatticeWithMat::wrongPos,sys[[1]],pos];
          Return[sys]];
       newZpol=expressZpolWithMat[zpol1,M];
       newSys=ReplacePart[sys,newZpol,pos]]
       

expressLatticeWithMat::wrongArg="wrong Argument for function expressLatticeWithMat : `1` "

expressLatticeWithMat[a:___]:=Message[expressLatticeWithMat::wrongArg,Map[Head,{a}]]




End[]

EndPackage[]
