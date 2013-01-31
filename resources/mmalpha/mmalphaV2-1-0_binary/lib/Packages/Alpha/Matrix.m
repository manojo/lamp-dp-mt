(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Zbigniew Chamski
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

BeginPackage["Alpha`Matrix`", 
{"Fail`","Alpha`Domlib`","Alpha`Options`","Alpha`","Alpha`Tables`"}];

(* $Id: Matrix.m,v 1.3 2009/05/22 10:24:36 quinton Exp $

   changelog:
   5/14/1993, Z. Chamski: fixed pbs with surjections over the origin
   6/01/1993, Z. Chamski: added inverseMatrix and unimodularQ
   6/02/1993, Z. Chamski: added unitMatrix and translationQ
   6/30/1993, Z. Chamski: added canonicalProjection
   7/12/1993, Z. Chamski: added convexize
   10/01/1993, Z. Chamski: added addLinSPace
   10/05/1993, Z. Chamski: added getTranslationVector
   10/07/1993, Z. Chamski: added convHull
   6/12/1994, T. Risset: added isNullLinearPart
   6/12/1994, T. Risset: added isIdLinearPart
   23/03/1995, D. Wilde version 2.3

*)
(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:36 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Matrix.m,v $
	$Revision: 1.3 $
	$Log: Matrix.m,v $
	Revision 1.3  2009/05/22 10:24:36  quinton
	May 2009
	
	Revision 1.2  2008/04/18 16:57:06  quinton
	Minor edition correction
	
	Revision 1.1.1.1  2005/03/07 15:32:12  trisset
	testing mmalpha repository
	
	Revision 1.60  2004/09/16 13:42:27  quinton
	Updated documentation
	
	Revision 1.59  2004/08/02 13:16:36  quinton
	Documentation updated for reference manual
	
	Revision 1.58  2004/07/08 14:06:50  risset
	commit Zpol changes
	
	Revision 1.57  2004/06/16 14:57:29  risset
	switched to ZDomlib
	
	Revision 1.55  2004/04/26 14:48:58  quinton
	Correction to the definition of alphaToMmaMatrix, when the dimension of
	the matrix is 0, the result should be {}.
	
	Revision 1.54  2003/07/18 12:19:42  risset
	changes from Abhishek for Zpolyhedra
	
	Revision 1.53  2003/07/16 13:41:29  quinton
	Added the functions deleteColumn and deleteRow,
	and dropParameters.
	
	Revision 1.52  2003/07/02 07:58:51  risset
	added Modifications for Zpolyhedra
	
	Revision 1.51  2002/09/24 07:09:34  quinton
	Corrections to solveDiophantine.
	
	Revision 1.50  2002/09/10 15:10:10  quinton
	Minor corrections
	
	Revision 1.49  2002/06/07 11:59:29  quinton
	A function nullSpaceVectors has been added.
	A new form of mmaToAlphaMatrix has been added, where you
	can specify the list of indexes of the Alpha Matrix.
	
	Revision 1.48  2001/11/14 10:32:25  quinton
	Correction for scalars was incorporated, and a new matlab option has been
	added to allow code generator to produce code which is executable under
	Matlab..
	
	Revision 1.47  2001/04/21 06:55:21  quinton
	Change file from dos to unix format
	
	Revision 1.46  2001/04/20 17:24:21  quinton
	
	Minor corrections.
	
	Revision 1.45  1999/05/28 14:48:44  quillere
	added a simplifyAffines case for if
	
	Revision 1.44  1999/05/27 09:31:43  risset
	commited docs
	
	Revision 1.43  1999/05/19 08:32:06  alpha
	*** empty log message ***
	
	Revision 1.42  1999/05/18 16:24:26  risset
	change many packages for documentation
	
	Revision 1.41  1999/05/18 15:27:46  risset
	transfert of getSystem* form Matrix to Tables.m
	
	Revision 1.40  1999/05/10 15:20:56  risset
	supressed the Decomposition Package, put it in Cut
	
	Revision 1.39  1999/05/10 13:14:13  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.38  1999/05/06 14:24:23  quillere
	Added Tables in needed packages (for simplifyAffines)
	
	Revision 1.37  1999/05/06 12:08:51  risset
	corrected isSpaceSepQ
	
	Revision 1.36  1999/03/02 15:49:21  risset
	added GNU software text in each packages
	
	Revision 1.35  1998/12/11 15:07:48  quillere
	min symbol was used as local symbols, changed this (min is an Alpha AST symbol)
	
	Revision 1.34  1998/12/07 09:52:27  risset
	corrected a bug in suppressRowNum
	
	Revision 1.33  1998/11/27 12:20:15  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.32  1998/11/06 14:16:25  quinton
	Added getSystemName, getSystemParameters, getSystemParameterDomain
	
	Revision 1.31  1998/10/05 09:13:15  quillere
	corrected unimodCompl
	
	Revision 1.30  1998/09/25 13:32:11  risset
	rien du tout
	
	Revision 1.29  1998/09/24 15:40:19  risset
	changed unimodularCompl not to do an error
	
	Revision 1.28  1998/09/24 15:29:28  risset
	changed unimodularCompl not to do an error
	
	Revision 1.27  1998/04/10 08:03:15  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.26  1998/03/13 16:00:10  quinton
	Ajoute de getLinearPart, correction de NullLinearPart

	Revision 1.25  1998/02/16 17:06:51  risset
	Packages pass all tests

	Revision 1.24  1998/02/04 10:08:25  risset
	snf

	Revision 1.23  1998/02/03 09:02:12  quillere
	Some messages changed (Patrice)

	Revision 1.22  1997/11/06 08:16:26  quillere
	*** empty log message ***

	Revision 1.21  1997/10/09 12:29:46  quillere
	Added a MMA implementation of Darte''s Smith Normal Form computation.
	Modified unimodCompl such that it uses the SNF.
	Added a new inverseInContext

	Revision 1.20  1997/07/10 14:56:39  quillere
	added a generalized unimodular completion -> unimodCompl

	Revision 1.19  1997/06/26 14:11:47  risset
	commited Alphard.m v1

	Revision 1.18  1997/06/26 13:14:55  fdupont
	Bug fixes to aim Alpha0v2

	Revision 1.17  1997/05/22 14:43:23  risset
	corrected messages

	Revision 1.16  1997/05/20 08:56:29  quillere
	Correction de quelques erreurs (';' oubliés)

	Revision 1.15  1997/04/10 09:19:29  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.14  1996/08/06 09:55:05  risset
	added a message for non integral matrices in hermite

	Revision 1.13  1996/06/24 13:54:41  risset
	added standard head comments for CVS



*)

Matrix::note = "Documentation revised on March 11, 2008";

Matrix::usage = 
"The Alpha`Matrix` package contains a few functions related to
Alpha matrices. These functions are 
alphaToMmaMatrix, composeAffines, convHull, convexize, convexizeAll,
deleteColumn, deleteRow, determinant, dropColumns, dropParameters, 
dropRows, emptyLinearPartQ, getLinearPart, getTranslationVector, 
hermite, hermiteL, hermiteR, inverseMatrix, identityQ, idLinearPartQ,
idMatrix, inverseInContext, nullSpaceVectors, mmaToAlphaMatrix, 
nullLinearPartQ, simplifyAffines, solveDiophantine, smithNormalForm, 
squareMatrixQ, suppressRowNum, translationMatrix, translationQ, unimodularQ, 
composeAffines, inverseMatrix, unimodularQ, unimodularCompletion, 
unimodCompl.";

addLinSpace::usage =
"Obsolete function, replaced by the generalized ChangeOfBasis."

alphaToMmaMatrix::usage=
"alphaToMmaMatrix[mat] translates a linear function from
Alpha format into Mathematica format (list of list). If the linear function
mat was affine (non nul constant part) this constant part is
lost. 
\n
Example:\n
alphaToMmaMatrix[\n
matrix[3, 3, {i, j}, {{1, 2, 0}, {0, 3, 0}, {0, 0, 1}}]\n
]\n
gives {{1, 2}, {0, 3}}."

canonicalProjection::usage =
"Obsolete. canonicalProjection[dom, pos] returns a projected domain obtained 
by supressing the indices given by the integer list pos.";

canonicalProjection::note =
"OBSOLETE. Replaced by (generalized) ChangeOfBasis.";

composeAffines::usage = 
"composeAffines[m1,m2] returns the composition of two affine matrices
m1 and m2. These matrices are described in the Alpha format."
composeAffines::params = "wrong parameters";

convHull::usage =
"convHull[ldom] returns the convex hull of a (possibly empty) list of 
domains ldom."
convHull::note =
"If the input list is empty, returns an empty list."
convHull::params = "wrong parameters";

convexize::usage =
"convexize[domain] returns the convex hull of domain if domain is
convex, otherwise returns domain unmodified. Used to convexize a union 
of domains (try to use DomConvex instead)."; 

convexize::params = "wrong parameters"; 

convexizeAll::usage =
"convexizeAll[sys] tries to convexize all the non-convex domains of
sys (default $result) and returns the modified system.";
convexizeAll::params = "wrong parameters";
convexizeAll::error = "error while trying to convexize system";

deleteColumn::usage = 
"deleteColumn[m,k] removes the k-th column of the Alpha matrix m. It removes
also index k of m.";

deleteRow::usage = 
"deleteRow[m,k] removes the k-th row of the Alpha matrix m. It does not touch
the index list of m.";

determinant::usage=
"determinant[m] gives the determinant of a square Alpha matrix. The result
can be integer or rationnal, the constant part is not taken into account.";

dropColumns::usage =
"dropColumns[m,n] removes n columns of the Alpha matrix m, from front if n
is positive, from end if n is negative. This function does not touch the 
dimensions nor the indexes of the matrix.";

dropParameters::usage = 
"dropParameters[sys,m] removes the rows of Alpha matrix m corresponding to 
parameters of system sys (default $result). If there are too many 
parameters, dropParameters returns m unchanged.";

dropRows::usage = 
"dropRows[m,n] removes n rows of the Alpha matrix m, from front if n is 
positive, from the end otherwise. This function does not touch the 
dimensions nor the indexes of the matrix.";

emptyLinearPartQ::usage =
"emptyLinearPartQ[m] is True if the linear part of matrix m is empty, 
False otherwise.";
emptyLinearPartQ::params = "wrong parameters"; 

getLinearPart::usage =
"getLinearPart[m] returns the linear part of an affine function m."
getLinearPart::params = "wrong parameters"; 

getTranslationVector::usage =
"getTranslationVector[m] returns the translation vector of a square 
affine function m."
getTranslationVector::params = "wrong parameters"; 

hermite::usage = 
"hermite[m] returns the left hermite decomposition {h,u}
(as Alpha matrices) of m1 (such that m1=composeAffines[h,u]).\n
WARNING: Currently, this function only deals with linear function (the
constant part is ignored).";

hermiteL::usage = 
"hermiteL[m] performs the left Hermite decomposition of
the Mathematica matrix m and returns mathematica matrices 
{H,Q} where Q unimodular, H upper triangular and m = Dot[H,Q].";

hermiteR::usage = 
"hermiteR[m] computes the right Hermite decomposition of the 
Mathematica matrix m and returns Mathematica matrices {H,Q},
where Q is unimodular, H is lower triangular, and m=Dot[Q,H].";

inverseMatrix::usage = 
"inverseMatrix[m] computes and returns the inverse of a square affine 
matrix m.";

identityQ::usage =
"identityQ[m] is True if an Alpha affine function m is the identity, 
False otherwise."
identityQ::params = "wrong parameters";

idLinearPartQ::usage =
"idLinearPartQ[m] is True if the linear part of the affine function
given as Alpha matrix m is the identity, False otherwise.";
idLinearPartQ::params = "wrong parameters"; 

idMatrix::usage =  
"idMatrix[idx_List,idy_List] returns the transformation matrix for
dependence (idx->idy), where idx and idy are lists of index names. It
is assumed that names in idy are also in idx. 
\nExample:\n
idMatrix[{\"i\",\"j\"},{\"i\",\"i\",\"j\"}] = \n
matrix[4, 3, {\"i\",\"j\"}, {{1,0, 0}, {1, 0, 0}, {0, 1, 0}, {0, 0, 1}}].";
idMatrix::params = "wrong parameters";

inverseInContext::usage = 
"inverseincontext[m,d] computes the inverse matrix of Alpha matrix m in 
context with domain d, i.e., taking into account the lineality space 
defined by d.";

inverseMatrix::noinverse = "matrix has no inverse";
inverseMatrix::nonsquare = "matrix is not square";
inverseMatrix::params = "wrong parameters";

isIdLinearPart::usage =
"obsolete form of idLinearPartQ.";

isNullLinearPart::usage =
"obsolete form of nullLinearPartQ.";

nullSpaceVectors::usage = 
"nullSpaceVectors[mat] gives the list of vectors of the null space
of Alpha matrix mat.";

mmaToAlphaMatrix::usage = 
"mmaToAlphaMatrix[m] returns the Alpha form of a Mathematica matrix m.
mmaToAlphaMatrix[m,i] returns the Alpha form of matrix m with index
(list of strings) i. mmaToAlphaMatrix[m,c:List[___]] returns the Alpha
form of a linear function Z -> mZ+c. 
\nExample: \nmmaToAlphaMatrix[{{1, 2},{0, 3}},{1,4}]\ngives the Alpha matrix 
which represents the affine function (i,j->i+2j+1,3j+4). 

mmaToAlphaMatrix[m,c,i] returns the
Alpha form of linear function Z -> mZ+c, with index (string list) i."

nullLinearPartQ::usage = 
"nullLinearPartQ[m] is True if the linear part of the affine function
given as Alpha matrix m is null, False otherwise."
isNullLinearPart::params = "wrong parameters"; 
nullLinearPartQ::params = "wrong parameters";

solveDiophantine::usage=
"solveDiophantine[a,b] solves  the linear diophantine system 
of equations aX = b where a is a MMA matrix, and b a MMA vector. The 
solution has the form {x1,n,M} where x1 is a particular solution 
of aX=b, n is the number of columns of M, and M is a matrix such 
that X=Mt (t is a n-vector) is the general solution of aX=0. The 
general solution of aX=b is x1+Mt. If the system has no integral
solution, then x1 is {}. solveDiophantine[a] solves  the linear 
diophantine system of equation  ax=0 where a is a MMA matrix."

smithNormalForm::usage = 

"smithNormalForm[mat computes the Smith Normal Form of an
Alpha matrix mat and returns {u,s,v} (Alpha matrices), where u,v are
unimodular and s is diagonal such that mat = u.s.v. 
smithNormalForm[m] computes the Smith Normal Form of a
Mathematica matrix m.";

squareMatrixQ::usage = 
"squareMatrixQ[m] is True if m is a square Alpha matrix.";
  
subMatrices::usage = 
"subMatrices[m1,m2] subtracts two matrices m1 and m2. This function is for
internal use by the Pipeline function."
subMatrices::params = "wrong parameters";

suppressRowNum::usage = 
"suppressRowNum[mat,i] suppresses row i in (MMAlpha) matrix mat.";

translationMatrix::usage = 
"translationMatrix[ind, vec] returns an Alpha translation matrix 
corresponding to the function: (ind -> ind+vec), where ind is a
list of indices and vec an integral vector."
translationMatrix::params = "wrong parameters";
translationMatrix::length = "length of vector is inconsistent with number of indices.";

translationQ::usage =
"translationQ[m] is True if the full rank affine function m is
a translation, False otherwise."
translationQ::params = "wrong parameters";

unimodularQ::usage =
"unimodularQ[m] is True if an MMAlpha affine matrix m is square and
unimodular, False otherwise."
unimodularQ::params = "wrong parameters";

isNullLinearPart::params = "wrong parameters"; 
nullLinearPartQ::params = "wrong parameters";

unimodularCompletion::usage = 
"unimodularCompletion[vl] completes a vector list vl into a unimodular
matrix which is returned. unimodularCompletion[mat] takes the vector 
expressed as an Alpha matrix mat and completes it into a unimodular 
Alpha matrix which is returned. If the original vector is of size n, 
the resulting matrix is of size (n+1)*(n+1) and the first row of the 
resulting matrix is the original vector with 0 appended as constant term.
For example, \nunimodularCompletion[{1,1,1}] returns
\n
matrix[4, 4, {}, {{1, 1, 1, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}, {0, 1, 0, 0}}]\n
and 
\nunimodularCompletion[matrix[4, 4, {}, {{1, 1, 1, 0},  {0, 0, 0, 1}}] 
\n returns \n
matrix[4, 4, {}, {{1, 1, 1, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}, 
		  \n{0, 1, 0, 0}}].";

unimodularCompletion::params = "wrong parameters";
unimodularCompletion::err1 = "the vector `1` cannot be completed in a
unimodular fashion";

unimodCompl::usage = 
"unimodCompl[mat] returns an unimodular completion of
matrix mat, or $Failed if an error occurs. The result is an
Alpha matrix. The indices of the result are those of mat, with some
new arbitrary indices if necessary.  Exemple : completion of
(i,j->2i) returns (i,j,k->2i+k,j,i). The optional parameter
indicates the dimension of the parameter space (0 if none).
\nunimodCompl[mat] is the mathematica version (no
constant row and column). It returns a square unimodular MMAlpha
matrix. First lines of this matrix are the matrix mat (modulo an
extension on the right).  
\n
For exemple: {{2,0,0},{1,2,0}} will be completed as:
\n
{{2,0,0,1,0}, {1,2,0,0,1}, {0,0,1,0,0}, {1,0,0,0,0}, {0,1,0,0,0}}.
\n
unimodCompl[mat,nbPar] returns a MMA matrix or $Failed if an error 
occurs. mat is a (k*(n+p+1) MMA matrix, it represents a 
k-dimensional affine function for a n-dim variable, with
a p-dim parameter space. Thus, the last column is the constant
column. nbPar is the parameter space dimension, i.e. p. The function
computes n from p and mat. The result is a MMA matrix, which has at
least (n+p+1) rows and exactly (n+p+1) columns. The first k rows are
exactly mat. If the result isn't square, it means that some dimension
will be added by the returned change of basis.";

simplifyAffines::usage = 
"simplifyAffines[] simplifies all affine functions in system $result. 
\nsimplifyAffines[sys] simplifies all affine functions on system sys."; 
simplifyAffines::failed = "";
simplifyAffines::wrongArg = "`1`";
simplifyAffines::system = "system is incorrect";

matrixSimplify::failed = "";
matrixSimplify::wrongArg = "`1`";

Begin["`Private`"]

(*
*)
Clear[ deleteColumn ];
deleteColumn[ m:_matrix, k:_Integer ]/;(k<=m[[2]]) :=
  matrix[ m[[1]], m[[2]]-1, Delete[ m[[3]], k ], 
    Map[ Delete[ #, k ]&, m[[4]] ] ];
deleteColumn[___] := deleteColumn[ deleteColumn::params ];

(*
*)
Clear[ deleteRow ];
deleteRow[ m:_matrix, k:_Integer ]/;(k<m[[1]]) :=
  matrix[ m[[1]]-1, m[[2]], m[[3]], 
    Delete[ m[[4]], k ] ];
deleteColumn[___] := deleteColumn[ params ];

(*
*)
Clear[dropParameters];
dropParameters[ m:_matrix ] := dropParameters[ $result, m ];
dropParameters[ sys:_system, m:_matrix ] := 
  Module[ {params, lp, nbrows},
    params = getSystemParameters[ sys ];
    lp = Length[params];
    nbrows = m[[1]];
    (* This is a kludge. Normally, the parameter should always 
    appear *)
    If[ lp === 0||lp>=nbrows, m, 
      Fold[ deleteRow, m, Table[ i, {i,nbrows-1,nbrows-lp,-1} ] ]
    ]
  ];
dropParameters::params = "wrong parameters";
dropParameters[___] := Message[ dropParameters::params ];

(******** change ********)
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

Clear[nullSpaceVectors];
nullSpaceVectors[m:_matrix]:=
Catch[
  Module[ { mmamat },
    Check[ mmamat = alphaToMmaMatrix[ m ],
      nullSpaceVectors::error1 = "error while calling alphaToMmaMatrix";
      Throw[ Message[ nullSpaceVectors::error1 ] ] 
    ];
    (* We use the NullSpace function of Mathematica *)
    NullSpace[ mmamat ]
  ]
];
nullSpaceVectors::params = "wrong params";
nullSpaceVectors[___]:= Message[ nullSpaceVectors::params ];

(******** change ********)
Clear[translationMatrix];
translationMatrix[ind:{_String...},vec:{(_Integer | _Rational)...}]:=
Module[{l},
       l=Length[ind];
       If[l=!=Length[vec],
	  Message[translationMatrix::length];$Failed,
	  RattoInt[Alpha`matrix[l+1,l+1,ind,IdentityMatrix[l+1]+Transpose[Append[Table[0,{l},{l+1}],Append[vec,0]]]]]]
       ];
translationMatrix[___] := (Message[translationMatrix::params];$Failed)

Clear[composeAffines];
composeAffines[Alpha`matrix[rows1_, cols1_, ind1_, m1_ /; m1 =!= {}],
	       Alpha`matrix[rows2_, cols2_, ind2_, m2_ /; m2 =!= {}]]:=
Catch[
  Module[{dot1},
    dot1=Check[m1.m2,Throw[$Failed]];
    RattoInt[InttoRat[Alpha`matrix[rows1, cols2, ind2, m1.m2]]]
  ]
];

composeAffines[Alpha`matrix[rows1_, cols1_, ind1_, m1_ /; m1 == {}],
	       Alpha`matrix[rows2_, cols2_, ind2_, m2_]] :=
  Alpha`matrix[rows1, cols2, ind2, {}]

composeAffines[___] := (Message[composeAffines::params];$Failed)

(* *********************************************** *)
(* check for unimodularity of a matrix             *)
(****** change ******)
(* note that false was returned in prev implementation for (i,j->2i,j/2) *)
Clear[unimodularQ]
unimodularQ[m:Alpha`matrix[rows_, cols_, _, List[__]]] :=
  And[(rows == cols), (Abs[Det[RattoInt[m][[4]]]] == 1)]

unimodularQ[_Alpha`matrix] := False
unimodularQ[___] := (Message[unimodularQ::params];$Failed)


(* ********************************** *)
(* invert an uncomplete square matrix *)
(****** change ******)
Clear[inverseMatrix]
inverseMatrix[Alpha`matrix[rows_, cols_, inds_, m:List[__]]] :=
  If[rows == cols,
     RattoInt[Alpha`matrix[rows, cols, inds, Inverse[m]]],
     Message[inverseMatrix::nonsquare];$Failed]
inverseMatrix[_Alpha`matrix] := (Message[inverseMatrix::noinverse];$Failed)
inverseMatrix[___] := (Message[inverseMatrix::params];$Failed)

(* ****************************************************** *)
(* some helpful functions for generating typical matrices
   - nth canonical vector,
   - null matrix,
   - nth canonical projection matrix,
   - vector part of a square matrix.
*)

Clear[nthCanonicalVector]
nthCanonicalVector[dim_Integer, n_Integer] :=
  Join[Table[0, {i, 1, n-1}], {1}, Table[0, {i, n+1, dim}]]

Clear[nullMatrix]
nullMatrix[n_Integer] := Table[Table[0, {j,1,n}], {i,1,n}]

(* canonical projection matrix used when transforming domains and affine
   functions; the validity of pos is _NOT_ checked; negative means count from
   the end *)
(* multiDrop is something Mma lacks ...*)

(* nthCanonicalProjection
Produces a Mathematica matrix corresponding to a canonical
projection (a projection that strips off some coordinates.)
Parameters:
1) number of indices (integer,) 
2) positions of the coordinates to be removed.
Returns the associated matrix (Mathematica form) with its last line removed.
*)

Clear[nthCanonicalProjMatrix]
nthCanonicalProjMatrix[numOfIndices_Integer, pos_Integer] :=
  With[{fullDim = numOfIndices + 1},
       Drop[IdentityMatrix[fullDim], {pos}]]

nthCanonicalProjMatrix[numOfIndices_Integer, pos:{_Integer..}] :=
  With[{fullDim = numOfIndices + 1},
       multiDrop[IdentityMatrix[fullDim], Sort[pos]]]

(* Drop any series of elements in a list; the positions given are supposed to
   be valid and ordered in ascending order *)

Clear[multiDrop]
multiDrop[l_List, pos:{_Integer..}] :=
  Drop[multiDrop[l, Rest[pos]], {First[pos]}]

multiDrop[l_List, {}] := l

multiDrop[l_List, pos_Integer] := Drop[l, {pos}]

multiDrop[{}, _] := {}

Clear[vectorPart]
vectorPart[m_ /; MatrixQ[m]] :=
  Map[Drop[#, -1] &, m]

(* canonical projection: just removes an index (or a list of indices) in a
   vector or a domain specification; negative positions means counting from the
   end; returns the unchanged vector/domain if pos is either 0 or out of
   bounds, i.e., abs value greater than the dimension
   *)

Clear[canonicalProjection];
canonicalProjection[l_List, pos:(_Integer | {_Integer..})] :=
If[Apply[And, Map[(And[Abs[#] <= Length[l], # =!= 0])&, ToList[pos]]],
  multiDrop[l, pos],
  l
];

(******** change ********)
canonicalProjection[dm2:Alpha`domain[s_Integer,_,{Alpha`zpol[Alpha`matrix[r_,c_,idx_List,mx_],p:{Alpha`pol[_,_,_,_,_,_]}]}],po:(_Integer|{_Integer..})]:=
Module[ 
  {res,tmp,lt,cut},
       cut[a1_,a2_] := Map[Part[a1,#]&,a2];
       res = canonicalProjection[Alpha`domain[s,idx,p],po];
       lt = Sort[Complement[Table[i,{i,Length[mx]}],ToList[po]]];
       tmp = Map[Part[mx,#]&,lt];
       tmp = Map[cut[#,lt]&,tmp];
       Alpha`domain[res[[1]],{},{Alpha`zpol[Alpha`matrix[r,c,res[[2]],tmp],res[[3]]]}]
];

canonicalProjection[d_:domain, pos:(_Integer | {_Integer..}) ] :=
Module[ 
  {numOfIndices, indexes, mat},
  numOfIndices = Part[d, 1];
  indexes = Part[d, 2];
  mat = 
      matrix[
        numOfIndices - Length[ToList[pos]] + 1 (* rows *), 
        numOfIndices + 1 (* columns *),
        multiDrop[Part[d, 2], pos] (* indices *),
        nthCanonicalProjMatrix[numOfIndices, pos]
      ];

  (* This was added, and I do not know why and what it does... Patrice
     FIXIT *)
  If[Apply[And, Map[(And[Abs[#] <= numOfIndices, # =!= 0])&, ToList[pos]]],
    DomImage[ d, mat ],
    d
  ]
];
canonicalProjection::params = "wrong parameters";
canonicalProjection[___] := Message[ canonicalProjection::params];

(****************************************************************************)
(* add "some lineality space" to a domain ... new indices given in terms of *)
(* pairs "final position, index name" .*)

Clear[addLinSpace]
addLinSpace[Alpha`domain[numOfInds_Integer,
			 indexNames_List,
			 polyhedra_List],
	    newIndices_List] :=
  With[{sortedList = Sort[newIndices]},
       Alpha`domain[numOfInds+Length[newIndices],
		    Fold[(Insert[#1, Part[#2,2], Part[#2,1]])&,
			 indexNames,
			 sortedList], (* this inserts names in appropriate
					 order ... *)
		    Map[addLinSpaceToPol[#, sortedList]&, polyhedra]]]

(* add lineality space to a polyhedron; takes a single polyhedron and expands
   it adding new unconstrained indices with names and FINAL positions
   specified by the second parameter; the index list is SORTED by ascending
   index position *)

Clear[addLinSpaceToPol]
addLinSpaceToPol[Alpha`pol[constrs_Integer,
			   rays_Integer,
			   equas_Integer,
			   infiniteRays_Integer,
			   constrList_List,
			   rayList_List],
		 newIndexList_List] :=
  Part[
    With[{newIndexPositions = Map[First, newIndexList],
	  totalIndexNumber = Length[newIndexList] +
	  Length[First[constrList]] -2},
	 With[{
	       mx = 
	       Alpha`matrix[
		 constrs,
		 totalIndexNumber + 2,
		 {},
		 Map[extendLine[#, newIndexPositions]&,
		     constrList]]},
	      (* Print["Matrix = ", mx]; *)
	      DomConstraints[mx]]],
    3, 1]				(* first element of the list of
					   polyhedra *)

Clear[extendLine]
extendLine[line:{_Integer..}, newIndexPositions:{_Integer..}] :=
  Fold[Insert[#1, 0, 1 + #2]&, line, newIndexPositions]


(* ************************************************************************ *)
(* check whether a function is a translation or not ... *)
(****** change ******)
(* note that false was returned in prev implementation for (i,j->i-5/6,j+1/2)*)
Clear[translationQ]
translationQ[mt:Alpha`matrix[rows_, cols_, _, List[__]] /; rows == cols ] :=
  Drop[vectorPart[InttoRat[mt][[4]]], -1] - IdentityMatrix[rows - 1] == nullMatrix[rows - 1]

translationQ[_matrix] := False
translationQ[___] := (Message[translationQ::params];$Failed)



(* check whether an affine function is an identity function or not *)
(****** change ******)
(* {{2, 0, 0}, {0, 2, 0}, {0, 0, 2}} is identity matrix??? *)
Clear[identityQ]
identityQ[mat:Alpha`matrix[rows_, cols_, _, List[__]] /; rows == cols ] :=
  InttoRat[mat][[4]] === IdentityMatrix[cols]

identityQ[_matrix] := False
identityQ[___] := (Message[identityQ::params];$Failed)


Clear[convexize];
(* change *)
convexize[dmn:Alpha`domain[dn_,_,mlst:{_Alpha`zpol..}]]:=
Module[{ptoz,ztop,tmp},
	ztop[Alpha`zpol[Alpha`matrix[sr_,sc_,sid_,sm_],slst:{_Alpha`pol..}]]
		:= Alpha`domain[dn,sid,slst];
	ptoz[Alpha`domain[_Integer,sid_List,slst:{_Alpha`pol..}],zmat_]
		:= Alpha`zpol[zmat,slst];
	tmp = ReplacePart[dmn,Map[ptoz[convexize[ztop[#]],#[[1]]]&,mlst],{3}]
];
					     
Options[ convexize ] := {debug->False};
convexize[ dom:_domain, opts:___Rule] :=
Module[ {dbg, convHull, d, res},
  dbg = debug/.{opts}/.Options[convexize];
  If[ dbg, Print["dom: ", ashow[dom, silent ->True] ] ];
  convHull = DomConvex[dom];
  If[ dbg, Print["convHull: ", convHull ]];
  d = DomDifference[ convHull, dom ];
  res = If[DomEmptyQ[d],convHull,dom];
  If[ dbg, Print["res: ",res ] ];
  res
];
convexize[___] := (Message[convexize::params];$Failed)

(* convexizeAll[] applies convexise to all domains of the Alpha
  program *)

Clear[convexizeAll]

convexizeAll[]:=
Catch[
  Module[{res},
	 res=Check[convexizeAll[$result],Throw[$Failed]];
	 If[MatchQ[res,system[___]],
	    $program=$result;
	    $result = res,
	    (Message[convexizeAll::error];Throw[$Failed])];
	    $result = res
	]
]

convexizeAll[sys:_system]:=
Catch[
  Module[{posDomain,curPos,curDom, newCurDom},
	 posDomain=Position[sys,Alpha`domain[___],Infinity];
	 curSys=sys;
	 Do [curPos = posDomain[[i]];
	     curDom=getPart[curSys,curPos];
	     If[Length[curDom[[3]]]>1,
		 newCurDom=Check[convexize[curDom],Throw[Null]];
		 curSys = ReplacePart[curSys,newCurDom,curPos]]
	   ,{i,1,Length[posDomain]}];
	 curSys]
];
	 
convexizeAll[___] := (Message[convexizeAll::params];$Failed)

(* convex hull of any number of domains: convex hull of their union; all
   domains are supposed to have the same dimension ... *)

Clear[convHull];
convHull[domList:{_Alpha`domain...}] :=
  DomConvex[
    Fold[DomUnion,
	 DomEmpty[getDimension[First[domList]]],
	 domList]];
convHull[{}] := {};
convHull[___] := (Message[convHull::params];$Failed)


Clear[nullLinearPartQ];
nullLinearPartQ[Alpha`matrix[n1_,n2_,_,lines_]] :=
  If [Map[Take[#,n2-1]&, Drop[lines,-1]]==Table[0,{i,n1-1},{j,n2-1}],
      True,
      False];
nullLinearPartQ[___] := (Message[nullLinearPartQ::params];$Failed)

(******* change ********)
Clear[getLinearPart];
getLinearPart[mat2:Alpha`matrix[n1_,n2_,_,_]] :=
  Map[Take[#,n2-1]&, Drop[InttoRat[mat2][[4]],-1]];
getLinearPart[___] := Message[getLinearPart::params];

Clear[emptyLinearPartQ];
emptyLinearPartQ[Alpha`matrix[n1_,n2_,{},lines_]] := True;
emptyLinearPartQ[Alpha`matrix[n1_,n2_,_,lines_]] := False;
emptyLinearPartQ[___] := Message[emptyLinearPartQ::params];

Clear[isNullLinearPart];
isNullLinearPart[x___] := nullLinearPartQ[x];

(******** change *********)
Clear[idLinearPartQ];
idLinearPartQ[mat2:Alpha`matrix[n1_,n2_,_,_]] :=
  If [Map[Take[#,n1-1]&, Drop[InttoRat[mat2][[4]],-1]]==IdentityMatrix[n1-1],
      True,
      False];
idLinearPartQ[___] := (Message[idLinearPartQ::params];$Failed)

Clear[isIdLinearPart];
isIdLinearPart[x___]:=idLinearPartQ[x];

(* idMatrix -- build the transformation matrix for dependence (idx->idy) *)
(*          It is assumed that names in idy are also in idx.             *)
(* ex: idMatrix[{"i","j"},{"i","i","j"}]                                  *)
(*     matrix[4, 3, {i, j}, {{1, 0, 0}, {1, 0, 0}, {0, 1, 0}, {0, 0, 1}}] *)

Clear[idMatrix];
idMatrix::wrgindex = "indexes of second list should belong to first one";
idMatrix[idx:{___String}, idy:{___String}]:=
Catch[
Module[{m},
  leni = Length[idy]+1;
  lenj = Length[idx]+1;
  Map[If[!MemberQ[idx,#1],Message[idMatrix::wrgindex];Throw[$Failed]]&,idy];
  m = Alpha`matrix[ leni, lenj, idx,
        Table[ If[ (i<leni && j<lenj && (Part[idy,i]===Part[idx,j])) ||
                   (i===leni && j===lenj), 1, 0 ],
               {i,1,leni}, {j,1,lenj}] ]
    ]
];
idMatrix[___] := (Message[idMatrix::params];$Failed)

(*------------------------------------------------------------------------*)
(* inverseInContext has been renamed oldInverseInContext *)
(* oldinverseInContext[m, d] *)
(*    find the left inverse of m (called m') in the context of domain d *)
(*    such that m' m y = y  forall y in d *)

(* Problem: the indices names are not returned... *)

Clear[oldinverseInContext]
oldinverseInContext[m_Alpha`matrix, d_Alpha`domain] :=
Module[{a,t,a1,am,u,m1,m2,h},
  (* extract out the lineality space from d *)
  a = DomEqualities[d];
  am = If[ a[[1]]===0, m,
          (* preconditon a -> a1 *)
          t = squareMatrix[First[DomLeftHermite[a]]];
          a1 = composeAffines[inverseMatrix[t],a];
          joinRows[a1, m]
       ];
  (* inverse is garanteed to be integral by preconditioning done on a *)
  h = DomRightHermite[am];
  (* h[[2]] should be identity with rows-cols rows of 0's appended to end *)
  If [identityQ[ dropRows[ h[[2]], h[[2,2]]-h[[2,1]] ] ], Null,
      Print["? inverseInContext: Non invertable function"];
      show[m];
      Print["in"];
      show[d];
  ];
  u  = inverseMatrix[First[h]];
  m1 = dropColumns[dropRows[u,Part[m,2]-Part[u,1]],Part[u,2]-Part[m,1]];
  m2 = dropColumns[dropRows[u,Part[m1,1]],Part[u,2]-Part[m,1]]; (* context *)
  DomMatrixSimplify[m1, m2]
]

Clear[dropColumns]
(* remove n cols from a matrix.  From end if n is neg. From front if pos *)
dropColumns[Alpha`matrix[nr_,nc_,i_,m_], x_Integer] :=
  Alpha`matrix[nr, nc-Abs[x], i, Map[Drop[#1,x]&, m]];
dropColumns[___] := Message[ dropColumns::params ];

Clear[dropRows]
(* remove n rows from a matrix.  From end if n is neg. From front if pos *)
dropRows[Alpha`matrix[nr_,nc_,i_,m_], x_Integer] :=
  Alpha`matrix[nr-Abs[x], nc, i, Drop[m,x]]

Clear[squareMatrix]
(* return the largest square submatrix *)
squareMatrix[m1:Alpha`matrix[nr_,nc_,_,_]]:=
  If[nr>nc, dropRows[m1, nc-nr],
  If[nc>nr, dropColumns[m1,nr-nc],
  m1]]

Clear[joinColumns]
(* join columns of two matrices *)
joinColumns[M1:Alpha`matrix[r1_,c1_,i1_,m1_],
               Alpha`matrix[r2_,c2_,i2_,m2_]]:=
Module[{i},
  If[r1=!=r2,
      (Print["? joinColumns: rows not same"];
        Return[M1]
      )];
  Alpha`matrix[r1,c1+c2,Join[i1,i2],
               Map[Join[Part[m1,#1],Part[m2,#1]]&,Table[i,{i,1,r1}]]
              ]
]

Clear[joinRows]
(* join rows of two matrices *)
joinRows[M1:Alpha`matrix[r1_,c1_,i1_,m1_],
            Alpha`matrix[r2_,c2_,i2_,m2_]]:=
( If[c1=!=c2,
      ( Print["? joinRows: cols not same"];
        Return[M1]
      )];
  Alpha`matrix[r1+r2,c1,i1,Join[m1,m2]]
)

(*-------------------------------------------------------------------------*)
Attributes[inverseInContext] = {};
Clear[inverseInContext];

inverseInContext::failed = "";
inverseInContext::wrongArg = "`1`";
inverseInContext::noInverse = "non invertable function";

(* Switch off error messages *)
Off[inverseInContext::failed];
Off[inverseInContext::noInverse];

inverseInContext[
 m:_matrix,
 d:_domain] := verbFail[inverseInContext::failed,
   Catch[
     Module[{matA, matT, matC, matX, matQ, matI, matR, indices},
	    matA = DomEqualities[d][[4]];
	    matX = If[matA=={},m[[4]],
		      res = (chkFail[hermiteL[matA]][[1]]);
		      matT = Take[#, Length[matA]]&/@res;
		      matC = Inverse[matT].matA;
		      Join[m[[4]], matC]];
	    matQ = unimodCompl[matX];
	    (*Print[MatrixForm[matX],"    ", MatrixForm[matQ]];*)
	    If[Length[matQ]>Length[matX],
	       Message[inverseInContext::noInverse];Throw[$Failed],
	       matI = Inverse[matQ];
	       matR =
		 Take[#1,Length[m[[4]]]]&/@Take[matI,Length[m[[4,1]]]];
	       (* the last line may not be [0..0 1] when there are     *) 
	       (*  equalities in Im(d,m). This is a temporary solution *)
	       matR = ReplacePart[matR,
				  Append[Table[0,{Length[First[matR]]-1}],1],
				  Length[matR]];
	       indices = Table[FromCharacterCode[ToCharacterCode["i"]-1+z],{z,1,Length[First[matR]]-1}];
	       matrix[Length[matR], Length[First[matR]], indices, matR]
	     ]
	  ]
   ]];

inverseInContext[a___] :=
  Module[{},
	 Message[inverseInContext::wrongArg,{a}];
	 $Failed];

(*
Attributes[inverseInContext] = {Protected,ReadProtected};
*)

(*-------------------------------------------------------------------------*)

Clear[unimodularCompletion];

(* The input is in the form {1,2,1,...,9} *)
unimodularCompletion[vect1_List]:=
  Module[{vectSize,firstRow,secondRow,matrix1},
	vectSize=Length[vect1];
	(* Building the Alpha`matrix *)
	firstRow=Append[vect1,0];  
	secondRow=Table[If [i<=vectSize,0,1],{i,1,vectSize+1}];
	matrix1=Alpha`matrix[2,vectSize+1,{},{firstRow,secondRow}];
	unimodularCompletion[matrix1]
      ]

(* no change, cannot apply to rational matrices *)
unimodularCompletion[matrix1:Alpha`matrix[2,matSize_,{___},
                                   {firstRow_,secondRow_}]]:=
Module[{hu1,h1,u1,tempRow,res},
	hu1= hermite[matrix1];
	h1=hu1[[1]];
	u1=hu1[[2]];
	If [
		h1[[4,1,1]]!=1,
		Print["the vector  cannot be completed in a unimodular fashion"];
		res={},
		res=u1
	]
]

unimodularCompletion[a___]:=Message[unimodularCompletion::params];

(* This implementation of the smith normal  {U,S,V} such that M=USV
All matrices are Alpha Matrices, the constant part is reported on the 
U matrix *)

(*------------------------------------------------------------------------*)
(* a MMA implementation of Darte's SNF computation *)

ClearAll[lowerRow];
ClearAll[lowerColumn];
ClearAll[rowEx];
ClearAll[columnEx];
ClearAll[rowInv];
ClearAll[columnInv];
ClearAll[rowAdd];
ClearAll[columnAdd];
ClearAll[multiple];
Clear[smithNormalForm];

(*------------------------------------------------------------------------*)
lowerRow::failed = "";
lowerRow::wrongArg = "`1`";
lowerRow::row = "row number is to large";

lowerRow[
  m : _/;MatrixQ[m],
  q : _Integer?Positive] := verbFail[lowerRow::failed,
  Catch[
    Module[{dimn, dimp, l},
	   dimn = Length[m];dimp = Length[First[m]];
	   If[q > dimn, Message[lowerRow::row];Throw[$Failed]];
	   If[q >=dimp, Throw[0]];
	   l = Sort[Select[Transpose[{Abs/@Drop[m[[q]], q-1],
				  Table[i,{i,q,dimp}]}],(First[#]!=0)&]];
	   If[l=={},
	      0,
	      If[(Length[l]==1)&&(l[[1,2]]==q),
		 0,
		 l[[1,2]]
	       ]
	    ]
	 ]
  ]];

lowerRow[a___] :=
  Module[{},
	 Message[lowerRow::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
lowerColumn::failed = "";
lowerColumn::wrongArg = "`1`";

lowerColumn[
  m : _/;MatrixQ[m],
  q : _Integer?Positive] := verbFail[lowerColumn::failed,
  Catch[
    chkFail[lowerRow[Transpose[m],q]]
  ]];

lowerColumn[a___] :=
  Module[{},
	 Message[lowerColumn::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
rowEx::failed = "";
rowEx::wrongArg = "`1`";
rowEx::row = "row is to large";

rowEx[
  m : _/;MatrixQ[m],
  a : _Integer?Positive,
  b : _Integer?Positive] := verbFail[rowEx::failed,
  Catch[
    Module[{row},
	   If[(a>Length[m])||(b>Length[m]),
	      Message[rowEx::row]; Throw[$Failed]];
	   row = m[[a]];
	   ReplacePart[ReplacePart[m,m[[b]],a],row,b]
	 ]
  ]];

rowEx[a___] :=
  Module[{},
	 Message[rowEx::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
columnEx::failed = "";
columnEx::wrongArg = "`1`";

columnEx[
  m : _/;MatrixQ[m],
  a : _Integer?Positive,
  b : _Integer?Positive] := verbFail[columnEx::failed,
  Catch[
    Transpose[chkFail[rowEx[Transpose[m],a,b]]]
  ]];

columnEx[a___] :=
  Module[{},
	 Message[columnEx::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
rowInv::failed = "";
rowInv::wrongArg = "`1`";
rowInv::row = "row is to large";

rowInv[
  m : _/;MatrixQ[m],
  a : _Integer?Positive] := verbFail[rowInv::failed,
  Catch[
    Module[{},
	   If[a>Length[m],
	      Message[rowInv::row];Throw[$Failed]];
	   ReplacePart[m, -m[[a]], a]
	 ]
  ]];

rowInv[a___] :=
  Module[{},
	 Message[rowInv::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
columnInv::failed = "";
columnInv::wrongArg = "`1`";

columnInv[
  m : _/;MatrixQ[m],
  a : _Integer?Positive] := verbFail[columnInv::failed,
  Catch[
    Transpose[chkFail[rowInv[Transpose[m], a]]]
  ]];

columnInv[a___] :=
  Module[{},
	 Message[columnInv::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
rowAdd::failed = "";
rowAdd::wrongArg = "`1`";
rowAdd::row = "row is to large";

rowAdd[
  m : _/;MatrixQ[m],
  a : _Integer?Positive,
  b : _Integer?Positive,
  x : _Integer] := verbFail[rowAdd::failed,
  Catch[
    Module[{},
	   If[(a>Length[m])||(b>Length[m]),
	      Message[rowAdd::row];Throw[$Failed]];
	   ReplacePart[m, m[[a]] + x*m[[b]], a]
	 ]
  ]];

rowAdd[a___] :=
  Module[{},
	 Message[rowAdd::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
columnAdd::failed = "";
columnAdd::wrongArg = "`1`";

columnAdd[
  m : _/;MatrixQ[m],
  a : _Integer?Positive,
  b : _Integer?Positive,
  x : _Integer] := verbFail[columnAdd::failed,
  Catch[
    Transpose[chkFail[rowAdd[Transpose[m], a, b, x]]]
  ]];

columnAdd[a___] :=
  Module[{},
	 Message[columnAdd::wrongArg,{a}];
	 $Failed];

suppressRowNum::dimToBig = " Dimension number `1` to big"

suppressRowNum[mat_Alpha`matrix,i_Integer]:=
  Module[{mat1},
	 If [i>=mat[[1]],
	     Message[suppressRowNum::dimToBig,i];
	     mat1=mat,
	     mat1=ReplacePart[mat,Delete[mat[[4]],i],4];
	     mat1=ReplacePart[mat1,mat1[[1]]-1,1];
	   ];
	 mat1]

suppressRowNum::wronArg="wrong arguments"

suppressRowNum[a___]:=Message[suppressRowNum::wronArg]

(*------------------------------------------------------------------------*)
(* change : works for rationals too *)
multiple::failed = "";
multiple::wrongArg = "`1`";
multiple::row = "row argument (`1`) is larger than length (`2`)";

multiple[
  m : _/;MatrixQ[m],
  q : (_Integer | _Rational)?Positive,
  0] := 0;

multiple[
  m : _/;MatrixQ[m],
  q : (_Integer | _Rational)?Positive,
  x : (_Integer | _Rational)] := verbFail[columnAdd::failed,
  Catch[
    Module[{lm, dim, pos},
	   dim = Min[Length[m],Length[m[[1]]]];
	   If[q>dim,Message[multiple::row,q,dim];Throw[$Failed]];
	   If[q==dim, 0,
	      lm = Mod[Transpose[Drop[Transpose[Drop[m,q]],q]],x];
	      pos = Position[lm,i_/;(i!=0)];
	      If[pos=={}, 0,
		 pos[[1,2]]+q
	       ]
	    ]
	 ]
  ]];

multiple[a___] :=
  Module[{},
	 Message[multiple::wrongArg,{a}];
	 $Failed];

(*------------------------------------------------------------------------*)
smithNormalForm::failed = "";
smithNormalForm::wrongArg = "`1`";
smithNormalForm::bailout = "an infinite loop was detected. Contact Alpha
staff";

smithNormalForm[
  m : _/;MatrixQ[m]] := verbFail[smithNormalForm::failed,
  Catch[
    Module[{mQ, mR, mS, n, p, q, i, k, x, encore, fini, pivot, bailout},bailout=0;
	   n = Length[m];
	   p = Length[First[m]];
	   mS = m;
	   mQ = IdentityMatrix[n];
	   mR = IdentityMatrix[p];
	   mini = Min[n,p];
	   For[q=1, q<=mini, q=q+1,
	       encore = 1;
	       While[encore != 0,
		     fini = 1;
		     While[fini != 0,
			   i = chkFail[lowerColumn[mS, q]];
			   While[i != 0,
				 If[i != q,
				    mS = chkFail[rowEx[mS, i, q]];
				    mQ = chkFail[columnEx[mQ, i, q]]];
				 pivot = mS[[q,q]];
				 If[pivot<0,
				    pivot = -pivot;
				    mS = chkFail[rowInv[mS, q]];
				    mQ = chkFail[columnInv[mQ, q]];
				  ];
				 For[k=q+1, k<=n,  k=k+1,
				     If[mS[[k,q]] != 0,
					x = Floor[mS[[k,q]] / pivot];
					mS = chkFail[rowAdd[mS, k, q, -x]];
					mQ = chkFail[columnAdd[mQ, q, k, x]]];
				   ];
				 i = chkFail[lowerColumn[mS, q]];
			       ];
			   i = chkFail[lowerRow[mS, q]];
			   fini = 0;
			   While[i != 0,
				 If[i != q,
				    fini = 1;
				    mS = chkFail[columnEx[mS, i, q]];
				    mR = chkFail[rowEx[mR, i, q]]];
				 pivot = mS[[q,q]];
				 If[pivot<0,
				    pivot = -pivot;
				    mS = chkFail[columnInv[mS, q]];
				    mR = chkFail[rowInv[mR, q]]];
				 For[k=q+1, k<=p,  k=k+1,
				     If[mS[[q,k]] != 0,
					x = Floor[mS[[q,k]] / pivot];
					mS = chkFail[columnAdd[mS, k, q, -x]];
					mR = chkFail[rowAdd[mR, q, k, x]]];
				   ];
				 i = chkFail[lowerRow[mS, q]];
			   ];
			   If[bailout++ > 100, Message[smithNormalForm::bailout];Throw[$Failed]];
			 ];
		     pivot = mS[[q,q]];
		     If[pivot<0,
			mS = chkFail[rowInv[mS, q]];
			mQ = chkFail[columnInv[mQ, q]]];
		     encore = chkFail[multiple[mS, q, pivot]];
		     If[encore!=0,
			mS = chkFail[columnAdd[mS, q, encore, 1]];
			mR = chkFail[rowAdd[mR, encore, q, -1]]];
		   ];
	     ];
	   {mQ, mS, mR}
	   ]
  ]];

smithNormalForm[mat1:Alpha`matrix[n1_,n2_,ind_,_List]]:=
  Catch[
    Module[{cstPart,mat1Bis,kernelMat,snf1,u,s,v,inverseU,
	   newCstPart,newS,newU ,newV,coeffs},
	   coeffs = RattoInt[mat1][[4]];
	  (* first get the constant Part *)
	    cstPart=Map[Last,Drop[coeffs,-1]];
	   kernelMat= alphaToMmaMatrix[mat1];
	  
	  snf1=Check[smithNormalForm[kernelMat],Throw[$Failed]];
	  u=snf1[[1]];
	  s=snf1[[2]];
	  v=snf1[[3]];
	  inverseU =Inverse[u];
	  
	smithNormalForm::nonIntegerMatrix="Internal problem: a
	  unimodular matrix returned was not unimodular";
	  If [!MatchQ[Flatten[inverseU],List[___Integer]],
	      Message[smithNormalForm::nonIntegerMatrix];
	      Throw[$Failed]];

	  (* the constant part is a problem:
	     we must have MZ+c = usvZ+c = u(s+cv^{-1})v 
	     Hence we return {u,s+cv^{-1},v} *)
	    
	    newCstPart =Dot[inverseU,cstPart];
	  newS = ReplacePart[mmaToAlphaMatrix[s,newCstPart],
			     ind,
			     3];
	  (* setting up indices names *)
	    newU = ReplacePart[mmaToAlphaMatrix[u],
			       ind,
			       3];
	  newV = ReplacePart[mmaToAlphaMatrix[v],
			     ind         ,
			     3];
	  {newU,newS,newV}
	  ]
  ];

	
smithNormalForm[a___] :=
  Module[{},
	 Message[smithNormalForm::wrongArg,{a}];
	 $Failed];

(* test : mat1 = {{10,-4},{0,6},{20,-5}}; *)
(* result should be :
{{{2, 1, 1}, {-18, -10, -9}, {-5, -3, -3}}, 
  {{1, 0}, {0, 30}, {0, 0}}, {{50, -17}, {-3, 1}}}
*)

(* End / smithNormalForm ------------------------------------------------------*)

(******** change ********)
Clear[alphaToMmaMatrix];
alphaToMmaMatrix[matr:Alpha`matrix[n1_,n2_,{},_]] := {};
alphaToMmaMatrix[matr:Alpha`matrix[n1_,n2_,ind_,_]]:=
  Module[{},Map[Drop[#,-1] &, Drop[InttoRat[matr][[4]],-1]]];

alphaToMmaMatrix::WrongArg="Wrong argument for alphaToMmaMatrix"

alphaToMmaMatrix[a___]:= (Message[alphaToMmaMatrix::WrongArg];
			  $Failed)
(*
  This function was modified in order to add a second 
  or third argument, which is the index list. 

  Also, the function does not work on an empty matrix... 
*)
Clear[mmaToAlphaMatrix];
mmaToAlphaMatrix[{}] := 
  Message[ mmaToAlphaMatrix::dim ]; 
mmaToAlphaMatrix::dim = 
  "matrix is empty, and I cannot guess index dimensions. Use \
				    mmaToAlphaMatrix[ {}, indexes ] \
				    instead"; 
(******* change *******)
mmaToAlphaMatrix[l_List]:=
Module[{n1,n2,coeffs},
  n1=Length[l];
  n2=Length[l[[1]]];
  coeffs=Append[Map[Append[#,0]  &,l],Append[Table[0,{i,1,n2}],1]];
  RattoInt[Alpha`matrix[n1+1,n2+1,{},coeffs]]
];

mmaToAlphaMatrix::wrongSize= "Wrong size for the arguments of
  mmaToAlphaMatrix"

(* New form added by P. Quinton *)
mmaToAlphaMatrix[{}, ind:{___String}]:=
Catch[
  Module[ {alphaMat, vector},
    vector = Table[ 0, {i,1,Length[ind]} ];
    vector = Append[ vector, 1 ];
    alphaMat = matrix[ 1, Length[ind]+1, ind, {vector} ]
  ]
];

mmaToAlphaMatrix[l:_List, ind:{___String}]:=
Catch[
  Module[ {alphaMat},
    If[ Length[ ind ] != Dimensions[l][[2]],
      mmaToAlphaMatrix::wrgindices = "index list size is incorrect";
      Throw[ Message[ mmaToAlphaMatrix::wrgindices ] ]
    ];
    alphaMat = mmaToAlphaMatrix[ l ];
    ReplacePart[ alphaMat, ind, 3 ]
  ]
];

(******* change *******)
mmaToAlphaMatrix[l_List,c:{(_Integer | _Rational)...}]:=
Catch[
  Module[{n1,n2,coeffs},
    n1=Length[l];
    n2=Length[l[[1]]];
    If [Length[c]=!=Length[l],
      Message[mmaToAlphaMatrix::wrongSize];
        Throw[$Failed]];
        coeffs=Append[MapThread[Append[#1,#2] & ,{l,c}],
          Append[Table[0,{i,1,n2}],1]];
          RattoInt[Alpha`matrix[n1+1,n2+1,{},coeffs]]
  ]
];

(* New form added by P. Quinton *)
mmaToAlphaMatrix[l:_List, c:_List, ind:{___String}]:=
Catch[
  Module[ {alphaMat},
    If[ Length[ ind ] != Dimensions[ l ][[2]],
      mmaToAlphaMatrix::wrgindices = "index list size is incorrect";
      Throw[ Message[ mmaToAlphaMatrix::wrgindices ] ]
    ];
    alphaMat = mmaToAlphaMatrix[ l, c];
    ReplacePart[ alphaMat, ind, 3 ]
  ]
];

mmaToAlphaMatrix::wrongArg= "Wrong argument for mmaToAlphaMatrix";

mmaToAlphaMatrix[a___]:= (Message[mmaToAlphaMatrix::WrongArg];
			  $Failed)

(* hermite is a correct HNF form for Alpha matrices 
 In the decomposition, we do not take into account the 
constant part *)
 
hermite::notIntegral="Warning: hermite decomposition performed on
 non-integral matrix: `1`, result certainly false"


(******** change *******)
Clear[hermite];
hermite[m:matrix[1, n2:_Integer, ind_, mat:_ ]]:=
  { m, idMatrix[ ind, ind ] };
hermite[m3:Alpha`matrix[n1_,n2_,ind_,_]]:=
  Module[{matMMA,transpMMA, htranspMMA,hMMA,hInvMMA,uMMA,u,h,mat},
	 mat = InttoRat[m3][[4]];
	 If[Last[Last[mat]]=!=1,
	    Message[hermite::notIntegral,mat]];
	 matMMA=Drop[Map[Drop[#,-1] &,mat],-1];
	 (* Transpose the matrix because hermiteK computes the other Hform*)
	 transpMMA=Transpose[matMMA];
	 hutranspMMA=hermiteK[transpMMA];
	 hMMA=  Transpose[hutranspMMA[[2]]];
	 uMMA= Transpose[hutranspMMA[[1]]];
	 (* build MMA Matrix *)
	 u=Alpha`matrix[n2,n2,ind,
			Append[Map[Append[#,0] &,uMMA],
			       Append[Table[0,{i,1,n2-1}],1]]];
	 h=Alpha`matrix[n1,n2,ind,
			Append[MapThread[Append[#1,#2] &,
					 {hMMA,Map[Last,Drop[mat,-1]]}],
			       Append[Table[0,{i,1,n2-1}],1]]];
	 {RattoInt[h],RattoInt[u]}];

hermite[a___]:= 
  Module[{},
	 Print["Parameter error in hermite",a];
	 $Failed
       ]



(* HNF FORM IMPLEMENTED FROM ALAIN DARTE THESIS p 17 *)

Clear[ppc]

ppc[m_List,q_Integer]:= 
  Module[{col,mini,pos,ppcres,colPos,colNzero,goodPos},
	 col=Map[Part[#,q] &,m];
	 colPos=Map[Abs,col];
	 (* n-q last coef of col *)
	   colNzero=Select[Take[colPos,{q+1,Length[m]}],(#!=0 &)];
	 If [colNzero=={},ppcres=0,
	     mini=Apply[Min,colNzero];
	     pos=Position[colPos,mini];
	     goodPos=Select[pos,Part[#,1]>q &];
	     If [goodPos!={},goodPos[[1,1]],Print["Error"];0]
	   ]
       ]

ppc[a___]:= 
  Module[{},
	 Print["Parameter error in ppc",a];
	 $Failed
       ]

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



(* return Q H such that Q unimodular and H upper triangular *)
Clear[hermiteK];

hermiteK[m_List]:=
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


hermiteK[a___]:= 
  Module[{},
	 Print["Parameter error in hermite",a];
	 $Failed
       ]


Clear[hermiteL]
hermiteL::failed = "";
hermiteL::wrongArg = "`1`";

hermiteL[m_List]:=
  Module[{tm,hm},
	 tm=Transpose[m];
	 hm=hermiteK[tm];
	 {Transpose[hm[[2]]],Transpose[hm[[1]]]}]
	  
hermiteL[a___]:= verbFail[hermiteL::failed,
  Module[{},
	 Message[hermiteL::wrongArg,{a}];$Failed
       ]
];

Clear[hermiteR]
hermiteR::failed = "";
hermiteR::wrongArg = "`1`";

hermiteR[m_List]:=hermiteK[m]

hermiteR[a___]:= 
  verbFail[hermiteR::failed,
    Module[{},
	   Message[hermiteR::wrongArg,{a}];$Failed
	   ]
  ];


(* 
   solveDiophantine solves a linear diophantine equation system 
   Ax=b. The method used here is explained in Banerjee book "gnagnagna the
   foundations". The result is expressed by a particular solution of 
   Ax=b and the general solution of Ax=0.

   The particular solution of Ax=b is a vector, the general solution
   is a triplet x0*n*M: vector*integer*matrix.
   x0 is a particular solution of Ax=b, matrix M (k*n) is the set of
   solutions x=Mt, t in Z^{n} of Ax=0. 

*)

Clear[solveDiophantine];
Options[ solveDiophantine ] := {debug->False};
(* If called with only a matrix, assume vector b is 0 *)
solveDiophantine[a_List/;MatrixQ[a], opts:___Rule ]:=
  solveDiophantine[a,Table[0,{i,1,Length[a]}]]
(* change *)
solveDiophantine[a1:_List/;MatrixQ[a1],b1:_List/;VectorQ[b1], opts:___Rule ]:=
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
    dbg = debug/.{opts}/.Options[ solveDiophantine ];

    p=Length[a];      (* p is the number of lines of a *)
    k=Length[a[[1]]]; (* k is the number of columns of a *)

    If[ Length[b]!=p,Print[a,b];
      solveDiophantine::wrgmatsize = 
        "wrong size for  matrices in solveDiophantine";
      Throw[ Message[ solveDiophantine::wrgmatsize ] ]
(* Should we return this?
      {{},{},{}},
*)
    ];

    (* Call Hermite normal form on a *)
    Check[
      hu=hermiteL[a],
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

solveDiophantine[a___]:=
  Module[{},
	 Print["Parameter error insolveDiophantine",a];
	 $Failed
       ]


Clear[squareMatrixQ];
(* very simple function used in PipeControl.m *)
squareMatrixQ[mat:matrix[d_,d1_,ind_,m_]]:= d === d1;
squareMatrixQ[x_]:=False;

(* ---- unimodular completion / Fabien ------- *)

Attributes[unimodCompl] = {};
Clear[unimodCompl];

unimodCompl::failed="";
unimodCompl::wrongArg = "`1`";
unimodCompl::paramSpace = "nbPar to large";
unimodCompl::dim = "specified and effective dimensions mismatch";
unimodCompl::corrupted = "last line of matrix is not {0.., 1}";
unimodCompl::shape = "`1` is not a matrix";

unimodCompl[
 mat : _matrix] := verbFail[unimodCompl::failed,
  unimodCompl[mat,0]];

unimodCompl[
 mat : _matrix,
 nbPar : _Integer?NonNegative] := verbFail[unimodCompl::failed,
  Catch[
    Module[{um, indices,indList, lastLine},
	   indList[
	   size:_Integer?Positive,
	   char:_String/;StringLength[char]==1]:=
	     Module[{z},
		    Table[FromCharacterCode[ToCharacterCode[char]-1+z],
			  {z,1,size}]];
	   (* parameters check*)
	   m = mat[[4]];
	   If[Not[MatrixQ[m]],
	      Message[unimodCompl::shape,m];Throw[$Failed]];
	   If[(Length[m]!=mat[[1]])||(Length[First[m]]!=mat[[2]]),
	      Message[unimodCompl::dim];Throw[$Failed]];
	   lastLine = Last[m];

	   If[Not[(And@@((#==0)&/@Drop[lastLine,-1]))&&(Last[lastLine]==1)],
	      Message[unimodCompl::corrupted];Throw[$Failed]];
	   um = unimodCompl[Drop[m,-1],nbPar];
	   If[um==$Failed, Throw[$Failed]];
	   indices=Take[Join[mat[[3]],Complement[indList[Length[um]-1,"i"], mat[[3]]]], Length[um]-1];
	   matrix[Length[um], Length[um[[1]]], indices, um]
	 ]
  ]];

unimodCompl[m : _/; MatrixQ[m]] := verbFail[unimodCompl::failed,
  Catch[
    Module[{matQ, matS, matR, snf, x},
	   snf = chkFail[smithNormalForm[m]];
	   matQ = snf[[1]];
	   matR = snf[[3]];
	   matS = extendMatrix[completeMatrix[snf[[2]]]];
	   x = Length[matS] - Length[matQ];
	   If[x>0,
	      matQ = Join[
		MapThread[Join,{matQ,
				Table[0,{i,1,Length[matQ]},{j,1,x}]}],
		MapThread[Join,{Table[0,{i,1,x},{j,1,Length[matQ]}],
				IdentityMatrix[x]}]
	      ]
	    ];
	   x = Length[matS] - Length[matR];
	   If[x>0,
	      matR =  Join[
		MapThread[Join,{matR,
				Table[0,{i,1,Length[matR]},{j,1,x}]}],
		MapThread[Join,{Table[0,{i,1,x},{j,1,Length[matR]}],
				IdentityMatrix[x]}]
	      ]
	    ];
	   Dot[matQ, matS, matR]
	 ]
  ]];

unimodCompl[
 mat:_/;MatrixQ[mat],
 nbPar:_Integer?NonNegative]:= verbFail[unimodCompl::failed,
  Catch[
    Module[{oldDim},
	   oldDim = Length[First[mat]] - (nbPar+1);
	   Which[oldDim>0,
		 Module[{newDim, nbRows, aMat, bMat, tMat, botMat, uMat},
			nbRows = Length[mat];
			tMat = Transpose[mat];
			uMat = unimodCompl[Transpose[Take[tMat,oldDim]]];
			If[uMat==$Failed, Throw[$Failed]];
			aMat = Take[#,oldDim]& /@ uMat;
			newDim = Length[aMat];
			bMat = Join[Transpose[Take[tMat,-(nbPar+1)]],
				    Table[0,{i,nbRows+1,newDim},{j,0,nbPar}]];
		     botMat = Transpose[Join[Table[0,{j,1,oldDim},{i,0,nbPar}],
					     IdentityMatrix[nbPar+1]]];
			Join[MapThread[Join,{aMat,bMat}],botMat]
		      ],
		 oldDim==0,
		 Join[mat,IdentityMatrix[nbPar+1]],
		 oldDim < 0,
		 Message[unimodCompl::paramSpace];Throw[$Failed]
	       ]
	 ]
  ]];

unimodCompl[a___]:= verbFail[unimodCompl::failed,
  Module[{},
	 Message[unimodCompl::wrongArg,{a}];$Failed
	 ]];

Attributes[unimodCompl] = {Protected,ReadProtected};

Clear[extendMatrix];
(* 
  mat must be lower triangular square 
  extends mat to an unimodular lower triangular square matrix
*)
extendMatrix[mat:_/;MatrixQ[mat]] :=
  Catch[
    Module[{n, iMat, aMat, extLength, zeroMatrix},
	   n=Length[mat];
	   iMat=Table[If[i==j,If[mat[[i,j]]==1,0,1],0],{i,1,n},{j,1,n}];
	   aMat=Select[iMat,(Not[And@@((#1==0)&/@#1)])&];
	   If[aMat!={},
	      extLength = Length[aMat];
	      zeroMatrix = Table[0,{i,1,extLength},{j,1,extLength}];
	      Join[
		MapThread[Join,{mat,Transpose[aMat]}],
		MapThread[Join,{aMat,zeroMatrix}]],
	      mat]
	 ]
  ];

Clear[completeMatrix];
(*
  mat must be a lower triangular matrix
  complete mat with I and 0 matrices and returns
  a square lower triangular matrix
*)
completeMatrix[mat:_/;MatrixQ[mat]]:=
  Module[{r, c, add},
	 r = Length[mat];
	 c = Length[mat[[1]]];
	 Which[ c > r,
		Join[mat,Table[If[i==j,1,0],{i,r+1,c},{j,1,c}]],
		c < r,
		MapThread[Join,{mat,
				Table[If[i==j,1,0],{i,1,r},{j,c+1,r}]}],
		c == r,
		mat
		]
       ];





(* ---- End / unimodular completion / Fabien ------- *)

Clear[simplifyAffines];

simplifyAffines[] :=
  Module[{tmp},
	 If[MatchQ[$result, system[_String, _domain, {___decl},{___decl},{___decl},{___equation}]], 
	    tmp = simplifyAffines[$result];
	    If[MatchQ[tmp, system[_String, _domain, {___decl},{___decl},{___decl},{___equation}]],
	       $program = $result;
	       $result = tmp,
	       $Failed],
	    Message[simplifyAffines::system];$Failed]];

simplifyAffines[
  sys : _system] := verbFail[simplifyAffines::failed,
  Catch[
    Module[{syseq},
	   syseq = sys[[6]];
	   If[!MatchQ[syseq, {equation__}],
	      Message[simplifyAffines::system];Throw[$Failed]];
	   syseq =
	     (chkFail[simplifyAffines[#,DomEqualities[getDeclaration[sys,First[#]][[3]]]]])& /@ syseq;
	   ReplacePart[sys, syseq, 6]
	 ]
  ]];

simplifyAffines[
  obj : _equation,
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (equation)"];*)
    equation[obj[[1]],chkFail[simplifyAffines[obj[[2]], ctx]]]
  ];

simplifyAffines[
  obj : _call,
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (call)"];*)
    call[obj[[1]],Map[chkFail[simplifyAffines[#, ctx]] &,obj[[2]]]]
  ];

simplifyAffines[
  obj : _restrict,
  ctx : _matrix] :=
  Catch[
    Module[{rlin, exctx},
	   (*Print["simplifyAffines (restrict)"];*)
	   rlin = Union[DomEqualities[obj[[1]]][[4]],ctx[[4]]];
	   exlin = matrix[Length[rlin],
			  ctx[[2]],
			  ctx[[3]],
			  rlin];
	   restrict[obj[[1]],chkFail[simplifyAffines[obj[[2]], 
						     exlin]]]
	 ]
  ];

simplifyAffines[
  obj : _case,
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (case)"];*)
    case[chkFail[simplifyAffines[#, ctx]]& /@ obj[[1]]]
  ];
 
simplifyAffines[
  unop[op:_, exp:_],
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (unop)"];*)
    unop[op,chkFail[simplifyAffines[exp, ctx]]]
  ];
 
simplifyAffines[
  obj : _affine,
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (affine)"];*)
    affine[obj[[1]],matrixSimplify[obj[[2]],ctx]]
  ];

simplifyAffines[
  obj : _if,
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (binop)"];*)
    if[obj[[1]],chkFail[simplifyAffines[obj[[2]], ctx]],chkFail[simplifyAffines[obj[[3]], ctx]]]
  ];

simplifyAffines[
  obj : _binop,
  ctx : _matrix] :=
  Catch[
    (*Print["simplifyAffines (binop)"];*)
    binop[obj[[1]],chkFail[simplifyAffines[obj[[2]], ctx]],chkFail[simplifyAffines[obj[[3]], ctx]]]
  ];

simplifyAffines[
  obj : _var,
  cts : _matrix] :=
  Catch[
    (*Print["simplifyAffines (var)"];*)
    obj];
    
simplifyAffines[a___] :=
  Module[{},
	 Message[simplifyAffines::wrongArg,{a}];
	 $Failed];

(* === *)

matrixSimplify::failed = "";
matrixSimplify::wrongArg = "`1`";

Clear[matrixSimplify];

matrixSimplify[
  mat : _matrix,
  lin : _matrix] := verbFail[matrixSimplify::failed,
    Catch[
      Module[{exmat, exlin, res, mm1, mm2, score1, score2, mm},
	     mm2 = mat[[4]];
	     exmat = Append[Append[#,0]& /@ Delete[mat[[4]],-1],
			    Table[If[i==mat[[2]]+1,1,0],{i,1,mat[[2]]+1}]];
	     exlin = matrix[lin[[1]], lin[[2]]+1, lin[[3]],
			    Map[Append[#,0]&, lin[[4]]]];
	     res =
	       DomMatrixSimplify[matrix[Length[exmat],Length[exmat[[1]]],{},exmat],exlin][[4]];
	     mm1 = Append[Map[Delete[#,-1]&,
			      Delete[res,-1]],
			  Last[mm2]];
	     score1 = (Plus@@(#*#))& /@ mm1;
	     score2 = (Plus@@(#*#))& /@ mm2;
	     mm = MapThread[(If[#1[[2]]<=#2[[2]], #1[[1]],#2[[1]]])&,
			    {Transpose[{mm1,score1}],Transpose[{mm2,score2}]}];
	     ReplacePart[mat,mm,4]
	     ]
    ]];

matrixSimplify[a___] :=
  Module[{},
	 Print[a];
	 Message[matrixSimplify::wrongArg,{a}];
	 $Failed];


(* === *)


(* ************************************************************************ *)

Clear[subMatrices]
subMatrices[mat1:Alpha`matrix[rows1_, cols1_, ind1_, _],
	       mat2:Alpha`matrix[rows2_, cols2_, ind2_, _]]:=
Catch[Module[{UnParamIndices,m1,m2,a,b,t},
If[rows1 =!= rows2,Throw[$Failed]];
If[cols1 =!= cols2,Throw[$Failed]];
If[Length[ind1] =!= Length[ind2],Throw[$Failed]];
m1=InttoRat[mat1][[4]];
m2=InttoRat[mat2][[4]];
a=Subtract[getPart[m1,{1}],getPart[m2,{1}]];
t=Table[i,{i,2,rows1}];
b=Map[getPart[m1,List[#]]&,t];
RattoInt[Alpha`matrix[rows1,cols1,ind1,Join[{a},b]]]]]

subMatrices[___]:= (Message[subMatrices::params];$Failed)


(******** change ********)
(* 1. gives erroneous results for rational matrices *)
(* extracting the translation vector from a matrix, supposed to be a
   translation matrix
   Warning, previously the result was : (i,j->i+1,j+1) => {-1,-1}
   I modified it and it is now  (i,j->i+1,j+1) => {1,1}*)
Clear[getTranslationVector];
getTranslationVector[mat1:Alpha`matrix[l1_,l2_,_,_]] :=
  Map[Last[#]&, Drop[InttoRat[mat1][[4]], -1]];
getTranslationVector[___] := (Message[getTranslationVector::params];$Failed)




Clear[determinant]

Options[determinant]={debug->False}

determinant[m:_matrix,options___Rule]:=
Catch[
   Module[{mmaMat,lastCoef,detMmaMat},
    dbg = debug/.{options}/.Options[ determinant ];
      If[m[[1]]=!=m[[2]],Message[determinant::notSquaremat,m];
                         Throw[$Failed]];
      mmaMat=alphaToMmaMatrix[m];
      Det[mmaMat]
      ]
]

determinant::wrongArg="wrong Argument for function determinant : `1` "

determinant[a:___]:=Message[determinant::wrongArg,Map[Head,{a}]]

End[]
EndPackage[]
