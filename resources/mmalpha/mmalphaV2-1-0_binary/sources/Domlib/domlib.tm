 /*  file: $MMALPHA/sources/Domlib/domlib.tm
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
   Place - Suite 330, Boston, MA  02111-1307, USA. */  
:Evaluate:	BeginPackage["Alpha`Domlib`"];
:Evaluate:	Begin["`Private`"];

:Begin:
:Function:	ML_LatticeHnf
:Pattern:	Alpha`Domlib`LatticeHermiteC[m1_Alpha`matrix]
:Arguments:	{m1}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	mirrorDomain
:Pattern:	Alpha`Domlib`mirrorDomain[d_Alpha`domain]
:Arguments:	{d}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:
:Evaluate: Alpha`Domlib`mirrorDomain::usage = "mirrorDomain[d] returns the domain d as is";

:Begin:
:Function:	mirrorZDomain
:Pattern:	Alpha`Domlib`mirrorZDomain[zd_Alpha`domain]
:Arguments:	{zd}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:
:Evaluate: Alpha`Domlib`mirrorZDomain::usage = "mirrorDomain[zd] returns the Z-domain zd as is";

:Begin:
:Function:	mirrorMatrix
:Pattern:	Alpha`Domlib`mirrorMatrix[m_Alpha`matrix]
:Arguments:	{m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:
:Evaluate: Alpha`Domlib`mirrorMatrix::usage = "mirrorMatrix[m] returns the matrix m as is";

:Begin:
:Function:	ML_LatticeIntersection
:Pattern:	Alpha`Domlib`LatticeIntersectionC[m1_Alpha`matrix, m2_Alpha`matrix]
:Arguments:	{m1,m2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_LatticeDifference
:Pattern:	Alpha`Domlib`LatticeDifferenceC[m1_Alpha`matrix, m2_Alpha`matrix]
:Arguments:	{m1,m2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_LatticeImage
:Pattern:	Alpha`Domlib`LatticeImageC[m1_Alpha`matrix, m2_Alpha`matrix]
:Arguments:	{m1,m2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_LatticePreimage
:Pattern:	Alpha`Domlib`LatticePreimageC[m1_Alpha`matrix, m2_Alpha`matrix]
:Arguments:	{m1,m2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_Intersection
:Pattern:	Alpha`Domlib`DomIntersectionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZZ_Intersection
:Pattern:	Alpha`Domlib`DomZZIntersectionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZP_Intersection
:Pattern:	Alpha`Domlib`DomZPIntersectionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_PZ_Intersection
:Pattern:	Alpha`Domlib`DomPZIntersectionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_Union
:Pattern:	Alpha`Domlib`DomUnionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZZ_Union
:Pattern:	Alpha`Domlib`DomZZUnionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_PZ_Union
:Pattern:	Alpha`Domlib`DomPZUnionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZP_Union
:Pattern:	Alpha`Domlib`DomZPUnionC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_Difference
:Pattern:	Alpha`Domlib`DomDifferenceC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZZ_Difference
:Pattern:	Alpha`Domlib`DomZZDifferenceC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZP_Difference
:Pattern:	Alpha`Domlib`DomZPDifferenceC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_PZ_Difference
:Pattern:	Alpha`Domlib`DomPZDifferenceC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:	{d1, d2}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:      ML_Simplify
:Pattern:       Alpha`Domlib`DomSimplifyC[d1_Alpha`domain, d2_Alpha`domain]
:Arguments:     {d1, d2}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:	ML_Convex
:Pattern:	Alpha`Domlib`DomConvex[d_Alpha`domain]
:Arguments:	{d}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_Image
:Pattern:	Alpha`Domlib`DomImageC[d_Alpha`domain, m_Alpha`matrix]
:Arguments:	{d, m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZImage
:Pattern:	Alpha`Domlib`DomZImageC[d_Alpha`domain, m_Alpha`matrix]
:Arguments:	{d, m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZPImage
:Pattern:	Alpha`Domlib`DomZPImageC[d_Alpha`domain, m_Alpha`matrix]
:Arguments:	{d, m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_Preimage
:Pattern:	Alpha`Domlib`DomPreimageC[d_Alpha`domain, m_Alpha`matrix]
:Arguments:	{d, m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZPPreimage
:Pattern:	Alpha`Domlib`DomZPPreimageC[d_Alpha`domain, m_Alpha`matrix]
:Arguments:	{d, m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZPreimage
:Pattern:	Alpha`Domlib`DomZPreimageC[d_Alpha`domain, m_Alpha`matrix]
:Arguments:	{d, m}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:	ML_ZEmptyQ
:Pattern:	Alpha`Domlib`DomZEmptyQC[d_Alpha`domain]
:Arguments:	{d}
:ArgumentTypes:	{Manual}
:ReturnType:	Manual
:End:

:Begin:
:Function:      ML_Constraints
:Pattern:       Alpha`Domlib`DomConstraints[m_Alpha`matrix]
:Arguments:     {m}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_Rays
:Pattern:       Alpha`Domlib`DomRays[m_Alpha`matrix]
:Arguments:     {m}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_Cost
:Pattern:       Alpha`Domlib`DomCost[d_Alpha`domain, c_List]
:Arguments:     {d, c}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_RightHermite
:Pattern:       Alpha`Domlib`DomRightHermite[m_Alpha`matrix]
:Arguments:     {m}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_LeftHermite
:Pattern:       Alpha`Domlib`DomLeftHermite[m_Alpha`matrix]
:Arguments:     {m}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_MatrixBasis
:Pattern:       Alpha`Domlib`DomBasis[m_Alpha`matrix]
:Arguments:     {m}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_MatrixSimplify
:Pattern:       Alpha`Domlib`DomMatrixSimplifyC[m1_Alpha`matrix,m2_Alpha`matrix]
:Arguments:     {m1,m2}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_DomAddRays
:Pattern:       Alpha`Domlib`DomAddRaysC[d1_Alpha`domain,m2_Alpha`matrix]
:Arguments:     {d1,m2}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_DomPrint
:Pattern:       Alpha`Domlib`DomPrint[d1_Alpha`domain,d2_Alpha`domain]
:Arguments:     {d1,d2}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_DomLTQ
:Pattern:       Alpha`Domlib`DomLTQ[d1_Alpha`domain,d2_Alpha`domain,idx_Integer,pdim_Integer]
:Arguments:     {d1,d2,idx,pdim}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_DomSort
:Pattern:       Alpha`Domlib`DomSort[dl:{__Alpha`domain}, idx_Integer, pdim_Integer, time:True|False]
:Arguments:     {dl,idx,pdim, time}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_DomIntEmptyQ
:Pattern:       Alpha`Domlib`DomIntEmptyQ[d1_Alpha`domain,d2_Alpha`domain]
:Arguments:     {d1,d2}
:ArgumentTypes: {Manual}
:ReturnType:    Manual
:End:

:Begin:
:Function:      ML_findV
:Pattern:       Alpha`Domlib`Private`findV[m:{_Integer,_Integer,lm_/;MatrixQ[lm]},
	                                   p:{_Integer,_Integer,lp_/;MatrixQ[lp]}]
:Arguments:     { m,p }
:ArgumentTypes: { Manual }
:ReturnType:    Manual
:End:

:Evaluate:	End[];
:Evaluate:	EndPackage[];
