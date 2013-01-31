dir = Directory[]
SetDirectory[Environment["MMALPHA"]<>"/tests/TestUniformizationTools/"];
Print["Test for UniformizationTools (LinearAlg.m)"];


res1= 
{
Print["-------------- Testing findHermiteBasis --------------**"];
(* Testing find hermite Basis 
 Testing this function is difficult, if the results 
   are not exactly the same as before, one shoudl check by hand that 
   the propoerties of findHermiteBasis are conserved that is: the 
   coordinates of the polyhedron in the new basis are null on the last 
   coordinates *)
dom1=readDom["{i,j,k | i=k}"];
testFunction[findHermiteBasis[dom1],
{2, matrix[4, 4, {"i", "j", "k"}, 
{{1, 0, 1, 0}, {0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 1}}]},
  "findHermiteBasis1"],
  (* result should be:
{2, matrix[4, 4, {i, j, k}, 
{{1, 0, 1, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}]} or 
{2, matrix[4, 4, {i, j, k}, 
{{1, 0, 1, 0}, {0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 1}}]} *)
     
dom1=domain[3, {"i1", "i2", "i3"}, {pol[3, 3, 1, 1, 
{{0, 0, 0, 1, 0}, {1, 1, 0, 0, 0}, {1, 0, 0, 0, 1}}, 
{{0, 0, 1, 0, 0}, {1, 6, 0, 0, 0}, {1, 0, 0, 0, 1}}]}];
testFunction[findHermiteBasis[dom1],
{2, matrix[4, 4, {"i1", "i2", "i3"}, 
    {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}]},
  "findHermiteBasis2"],
  
  (*should be  {2, matrix[4, 4, {i1, i2, i3}, 
{{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}]} *)
     
     Print["The following Warning message is usual..."];
mat1=readMat["(i,j,k->i+k+1,i+k+1)"];
testFunction[findHermiteBasis[mat1],
{1, matrix[4, 4, {"i", "j", "k"}, 
{{1, 0, 1, 0}, {0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 1}}]},
  "findHermiteBasis3"],
(* result should be:
{1, matrix[4, 4, {i, j, k}, 
   {{1, 0, 1, 0}, {0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 1}}]}
 *)

     matMMa1={{1, 0, 1, 1}, {1, 0, 1, 1}, {0, 0, 0, 1}};
     testFunction[findHermiteBasis[matMMa1],
{2, {{1, 0, 1, 0}, {0, 0, 0, 1}, {1, 0, 0, 0}, {1, 1, 0, 0}}},
       "findHermiteBasis4"],


       matMMa2={{1, 0, 1, 1}};
testFunction[findHermiteBasis[matMMa2],
{1, {{1, 0, 1, 0}, {0, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 1}}},
  "findHermiteBasis5"],


testFunction[findHermiteBasis[{{1,1,0},{1,1,1}}],
   {2, {{1, 1, 1}, {1, 1, 0}, {0, 1, 0}}},
 "findHermiteBasis6"],

dom2=readDom["{i,j,k| i=j}"];
bas1=findHermiteBasis[dom2];
testFunction[DomEqualQ[DomImage[dom2,inverseMatrix[bas1[[2]]]],
	      readDom["{i,j,k | k=0}"]],
  True,
  "findHermiteBasis7"],

testFunction[
findHermiteBasis[{{0, 0, 0, 0}, {1, 1, 0, 0}, {0, 0, 1, 0}, {0, 0,
 0, 1}}],
{3, {{1, 0, 0, 1}, {1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1,
 0}}}, 
 "findHermiteBasis8"],

testFunction[findHermiteBasis[{{0, 0, 0, 0}, {1, 2, 0,
 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}] , {3, {{1, 0, 0, 0}, {2, 0, 0, 1},
 {0, 1, 0, 0}, {0, 0, 1, 0}}},  "findHermiteBasis9"],


testFunction[ findHermiteBasis[{{7,0,0},{7,0,0},{4,3,5},{4,3,5}}] ,
 {2, {{1, 4, 0}, {0, 3, 1}, {0, 5, 2}}},  "findHermiteBasis10"],

Print["-------------- Testing Basis related stuff --------------**"];
basis1={1, {{-1, 1}, {-1, 0}}};
basis2={2, {{-1, 1}, {-1, 0}}};
vec={1,0};
testFunction[vecInBasisQ[vec,basis1],
	     False,
	     "vecInBasis 1"],
testFunction[vecInBasisQ[vec,basis2],
	     True,
	     "vecInBasis 2"],
testFunction[getBasis[basis1],
	     {{-1,-1}},
	     "getBasis 1"],
testFunction[getBasis[basis2],
	     {{-1, -1}, {1, 0}},
	     "getBasis 2"],
testFunction[properSubspaceQ[basis1,basis2],
	    True,
	     "properSubspaceQ 1"],
testFunction[properSubspaceQ[basis2,basis1],
	     False,
	     "properSubspaceQ 2"],
testFunction[intersectionBasisQ[basis1,basis2],
	    True,
	     "intersectionBasisQ 1"],
basis3={1,{{-1,1},{1,0}}};
testFunction[intersectionBasisQ[basis3,basis1],
	     False,
	     "intersectionBasisQ 2"],
testFunction[intersectionBasis[basis1,basis2],
	    basis1,
	     "intersectionBasis 1"],
testFunction[intersectionBasis[basis3,basis1],
	     {},
	     "intersectionBasis 2"],
testFunction[intersectionBasis[basis3,basis2],
	     basis3,
	     "intersectionBasis 3"],
dom1=readDom["{i,j,k,l,N,M | i=j; 0<=i,k,j,N}"];
testFunction[domainBasis[dom1],
	     {5, {{0, 0, 0, 0, 1, 1}, {0, 0, 0, 0, 1, 0}, {0, 0, 0, 1, 0, 0}, 
   {1, 0, 0, 0, 0, 0}, {0, 0, 1, 0, 0, 0}, {0, 1, 0, 0, 0, 0}}},
	     "domainBasis 1"],
Print["-------------- Testing get/vertices/lines/equalities --------------**"];
dom1=readDom["{i,j,k,l,N,M | i=j; 0<=i,k,j,N}"];
testFunction[getVertices[dom1],
	     {{0, 0, 0, 0, 0, 0}},
	     "getVertices 1"],
testFunction[getLines[dom1],
	     {{0, 0, 0, 1, 0, 0}, {0, 0, 0, 0, 0, 1}},
	     "getLines 1"],
testFunction[getEqualities[dom1],
	     {{1, -1, 0, 0, 0, 0, 0}},
	     "Equalities 1"]
}

testResult = Apply[And,res1] 

SetDirectory[dir];

If [testResult,
    Print["**** Test OK for linearAlg.m "],
    Print["**** Something was wrong for linearAlg.m"]];

testResult

