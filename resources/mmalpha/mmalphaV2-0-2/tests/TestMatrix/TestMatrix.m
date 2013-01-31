BeginPackage["Alpha`TestMatrix`",
  {"Alpha`","Alpha`Domlib`","Alpha`Tables`","Alpha`Matrix`"}];

Begin["`Private`"];

Module[{dir,t1,t2,res},

$testResult = True; 

res=
{
  (* Test of translationMatrix *)

  testFunction[translationMatrix[{"i", "j"}, {1, 2}], 
    matrix[3, 3, {"i", "j"}, {{1, 0, 1}, {0, 1, 2}, {0, 0, 1}}],"Matrix 1"]
,
  testFunction[translationMatrix[{"i", "j"}, {1, 2, 3}], $Failed,"Matrix 2"]
, 
  testFunction[translationMatrix[2], $Failed, "Matrix 3"]
,
  (* Test of composeAffines *)
  testFunction[
    composeAffines[readMat["(i,j->j,i)"], readMat["(i,j->j+1,i+3)"]], 
    matrix[3, 3, {"i", "j"}, {{1, 0, 3}, {0, 1, 1}, {0, 0, 1}}], 
    "Matrix 4"]
,
  testFunction[composeAffines[2], $Failed, "Matrix 5"]
,
  testFunction[
    composeAffines[readMat["(i,j->j,i)"], readMat["(i,j->j,i,i)"]], 
    $Failed, "Matrix 6"]
, 
  (* Test of unimodularQ *)
  testFunction[unimodularQ[readMat["(i,j->j,i)"]], True, "Matrix 7"]
,
  testFunction[unimodularQ[readMat["(i,j->j,2i)"]], False, 
    "Matrix 8"]
,
  testFunction[unimodularQ[readMat["(i,j->j)"]], False, "Matrix 9"]
,
  testFunction[unimodularQ[22], $Failed, "Matrix 10"]
,
  (* Test of inverseMatrix *)
  testFunction[inverseMatrix[readMat["(i,j->i+1,j+1)"]], 
    matrix[3, 
      3, {"i", "j"}, {{1, 0, -1}, {0, 1, -1}, {0, 0, 1}}], 
    "Matrix 11"]
,
  testFunction[inverseMatrix[readMat["(i,j->i+1)"]], $Failed, 
    "Matrix 12"]
, 
  testFunction[inverseMatrix[readMat["(i,j->i+1,2j)"]], 
    matrix[3, 3, {"i", "j"}, {{2, 0, -2}, {0, 1, 0}, {0, 0, 2}}], 
    "Matrix 13"]
, 
  testFunction[inverseMatrix[22], $Failed, "Matrix 14"]
,
  (* Test of identityQ *)
  testFunction[identityQ[readMat["(i,j->i,j)"]],True, 
    "Matrix 15"]
,
  testFunction[identityQ[readMat["(i,j->i,j+1)"]],False,
    "Matrix 16"]
, 
  testFunction[identityQ[22],$Failed,"Matrix 17"]
,
  (* Test of translationQ *)
  testFunction[translationQ[readMat["(i,j->i,j+1)"]],True, 
    "Matrix 18"]
,
  testFunction[translationQ[readMat["(i,j->i,2j+1)"]],False,
    "Matrix 19"]
, 
  testFunction[translationQ[22],$Failed,"Matrix 20"]
,
  (* Test of convexize *)
  testFunction[
    DomEqualQ[
    convexize[
      readDom["{i,j|0<=i<=10;0<=j<=10;i<=j}|{i,j|0<=i<=10;0<=j<=10;i>j}"]], 
    readDom["{i,j | 0<=i<=10; 0<=j<=10}"]],True, "Matrix 21"]
,
  testFunction[
  convexize[
    readDom["{i,j|0<=i<=10;0<=j<=10;i<=j}|{i,j|0<=i<=10;0<=j<=10;i>j+1}"]],
  domain[2,{"i","j"},{
      pol[3,3,0,
        0,{{1,1,0,0},{1,0,-1,10},{1,-1,1,0}},{{1,10,10,1},{1,0,0,1},{1,0,10,
            1}}],pol[3,3,0,
        0,{{1,-1,0,10},{1,0,1,0},{1,1,-1,-2}},{{1,10,0,1},{1,2,0,1},{1,10,8,
            1}}]}] , "Matrix 22"]
,
  testFunction[convexize[22],$Failed,"Matrix 23"]
,
  (* Test of convexizeAll *)
  load["Test.alpha"];
  testFunction[convexizeAll[];
  (DomEqualQ[$result[[5, 1, 3]], 
  domain[2, {"i", 
      "j"}, {pol[4, 4, 0, 
        0, {{1, -1, 0, 10}, {1, 0, 1, 0}, {1, 1, 0, 0}, {1, 0, -1, 10}}, {{1, 
            0, 0, 1}, {1, 10, 0, 1}, {1, 0, 10, 1}, {1, 10, 10, 1}}]}]]
  && DomEqualQ[$result[[6, 1, 2, 1]], 
  domain[2, {"i", 
      "j"}, {pol[3, 3, 0, 
        0, {{1, 1, 0, 0}, {1, 0, -1, 10}, {1, -1, 1, 0}}, {{1, 10, 10, 1}, {1,
             0, 0, 1}, {1, 0, 10, 1}}], 
      pol[3, 3, 0, 
        0, {{1, -1, 0, 10}, {1, 0, 1, 0}, {1, 1, -1, -2}}, {{1, 10, 0, 1}, {1,
             2, 0, 1}, {1, 10, 8, 1}}]}]]
  &&
  DomEqualQ[$result[[6, 2, 2, 1]], 
  domain[2, {"i", 
      "j"}, {pol[1, 3, 0, 
        2, {{1, 0, 0, 1}}, {{0, 1, 0, 0}, {0, 0, 1, 0}, {1, 0, 0, 1}}]}]]), 
  True, "Matrix 24"]
,
  testFunction[convexizeAll[22],$Failed, "Matrix 25"]
,
  (* Test of getDimension *)
  testFunction[getDimension[readDom["{i,j,k|i>=k}"]], 3, "Matrix 26"]
,
  testFunction[getDimension[22],$Failed, "Matrix 27"]
,
  (* Test of getTranslationVector *)
  testFunction[getTranslationVector[readMat["(i,j,k->i+1,j+2,k-3)"]], {1,2,-3},
   "Matrix 28"]
,
  testFunction[getTranslationVector[readMat["(i,j,k->i+1,2j+2,k-3)"]],
   {1,2,-3}, "Matrix 29"]
,
  testFunction[getTranslationVector[readMat["(i,j,k->i+1,2j+2)"]], {1,2}, 
  "Matrix 30"]
,
  testFunction[getTranslationVector[22], $Failed, "Matrix 31"]
,
  (* Test of isNullLinearPart *)
  testFunction[isNullLinearPart[readMat["(i,j,k->1,2,3)"]], True, "Matrix 32"]
,
  testFunction[isNullLinearPart[readMat["(i,j,k->i+1,j+2,k-3)"]], False, 
  "Matrix 33"]
,
  testFunction[isNullLinearPart[22], $Failed, "Matrix 34"]
,
  (* Test of nullLinearPartQ *)
  testFunction[nullLinearPartQ[readMat["(i,j,k->1,2,3)"]], True, "Matrix 35"]
,
  testFunction[nullLinearPartQ[readMat["(i,j,k->i+1,j+2,k-3)"]], False, 
  "Matrix 36"]
,
  testFunction[nullLinearPartQ[22], $Failed, "Matrix 37"]
,
  (* Test of idLinearPartQ *)
  testFunction[idLinearPartQ[readMat["(i,j,k->1,2,3)"]], False, "Matrix 38"]
,
  testFunction[idLinearPartQ[readMat["(i,j,k->i+1,j+2,k-3)"]], True, 
  "Matrix 39"]
,
  testFunction[idLinearPartQ[22], $Failed, "Matrix 40"]
,
  testFunction[isIdLinearPart[readMat["(i,j,k->1,2,3)"]], False, "Matrix 39"]
,
  (* Test of idMatrix *)
  testFunction[idMatrix[{"i","j"},{"j","i"}], 
  matrix[3,3,{"i","j"},{{0,1,0},{1,0,0},{0,0,1}}], "Matrix 40"]
,
  testFunction[idMatrix[{"i","j"},{"j","k"}], $Failed, "Matrix 41"]
,
  testFunction[idMatrix[22], $Failed, "Matrix 42"]
,
  (* Test of hermite *)
  testFunction[
    hermite[readMat["(i,j,k->i+2j+3k,2i+j,k)"]],{
      matrix[4,4,{"i","j","k"},{{1,0,0,0},{2,3,0,0},{0,0,1,0},{0,0,0,1}}],
      matrix[4,4,{"i","j","k"},{{1,2,3,0},{0,-1,-2,0},{0,0,1,0},{0,0,0,1}}]},
    "Matrix 43"]
,
  testFunction[hermite[22],$Failed,"Matrix 44"]
,
  (* Test of solveDiophantine *)
  testFunction[
  solveDiophantine[{{1,-2,0},{1,0,-3}},{1,0}],{{3,1,1},1,{{6},{3},{2}}},
  "Matrix 45.1"]
,
  testFunction[
  solveDiophantine[{{0},{1},{0}},{0,2,0}],{{2},0,{{}}},
  "Matrix 45.2"]
,
  testFunction[
  solveDiophantine[{{0},{2},{0}},{0,2,0}],{{1},0,{{}}},
  "Matrix 45.3"]
,
  testFunction[
  solveDiophantine[{{0},{2},{0}},{0,1,0}],{{},0,{{}}},
  "Matrix 45.4"]
,
  testFunction[solveDiophantine[22],$Failed,"Matrix 45.5"]
,
  (* Test of squareMatrixQ *)
  testFunction[squareMatrixQ[readMat["(i,j->i,j)"]],True,"Matrix 46"]
,
  testFunction[squareMatrixQ[readMat["(i,j->i)"]],False,"Matrix 47"]
,
  testFunction[squareMatrixQ[22],False,"Matrix 48"]
,
  (* Test of unimodCompl *)
  testFunction[unimodCompl[readMat["(i,j->2i)"]],
  matrix[4,3,{"i","j","k"},{{2,0,0},{0,1,0},{1,0,0},{0,0,1}}],"Matrix 49"]
,
  testFunction[unimodCompl[22],$Failed,"Matrix 50"]
,
  (* Test of inverseInContext *)
  testFunction[inverseInContext[readMat["(i,j->i)"],readDom["{i,j|i=j}"]],
  matrix[3,2,{"i"},{{1,0},{1,0},{0,1}}],"Matrix 51"]
,
  testFunction[inverseInContext[22],$Failed,"Matrix 52"]
,
  (* Test of smithNormalForm *)
  testFunction[
  smithNormalForm[{{1,2,1}}],{{{1}},{{1,0,0}},{{1,2,1},{0,1,0},{0,0,1}}},
  "Matrix 53"]
,
  testFunction[smithNormalForm[22],$Failed,"Matrix 54"]
,
  (* Test of hermiteL *)
  testFunction[hermiteL[{{1,1,0}}],{{{1,0,0}},{{1,1,0},{1,0,0},{0,0,1}}},
  "Matrix 55"],testFunction[hermiteL[22],$Failed,"Matrix 56"]
,
  (* Test of hermiteR *)
  testFunction[hermiteR[{{1,1,0}}],{{{1}},{{1,1,0}}},"Matrix 57"]
,
  testFunction[hermiteR[22], $Failed, "Matrix 58"]
,
  (* Test of translationMatrix *)
  testFunction[
		translationMatrix[{"i", "j"}, {1/3, 2/7}],
		matrix[3, 3, {"i", "j"}, {{21, 0, 7}, {0, 21, 6}, {0, 0, 21}}],
		"ZMatrix trMat1"
		]
,
  (* Test of composeAffines *)
  testFunction[
		composeAffines[readMat["(i,j->3j/2+3,i/3+2)"],readMat["(i,j->j+1,i+3)"]],
		matrix[3, 3, {"i", "j"}, {{9, 0, 45}, {0, 2, 14}, {0, 0, 6}}],
		"ZMatrix coAff1"
		]
,
  (* Test of inverseMatrix *)
   testFunction[
		inverseMatrix[readMat["(i,j->i/2+1,2j)"]],
		matrix[3,3,{"i","j"},{{4,0,-4},{0,1,0},{0,0,2}}],
		"ZMatrix invMat1"
		]
,
  (* Test of unimodularQ *)
   testFunction[
		unimodularQ[readMat["(i,j->2i,j/2)"]],
		False,
		"ZMatrix unimodQ1"
		]
,
  (* Test of translationQ *)
	testFunction[
		translationQ[readMat["(i,j->i-5/6,j+1/2)"]],	(* note that false was returned in prev implementation *)
		True,
		"ZMatrix transQ1"
		]
,
  (* Test of identityQ *)
	testFunction[
		identityQ[matrix[3, 3, {"i", "j"}, {{2, 0, 0}, {0, 2, 0}, {0, 0, 2}}]],
		True,
		"ZMatrix identQ1"
		]	(* should be allowed: but will confirm *)
,
  (* Test of getTranslationVector *)
	testFunction[
		getTranslationVector[readMat["(i,j,k->i/3+1,3j/2+2)"]],
		{1, 2},
		"ZMatrix getTrV1"
		]	(* used to give erroneous results for rational matrices *)
,

  (* Test of getLinearPart *)
    testFunction[
		getLinearPart[readMat["(i,j,k->i+j/2+1,2j+2,3k/2-3)"]],
		{{1, 1/2, 0}, {0, 2, 0}, {0, 0, 3/2}},
		"ZMatrix getLiP1"
		]	(* used to give erroneous results for rational matrices *)
,
  (* Test of NullLinearPartQ *)
	testFunction[
		isNullLinearPart[readMat["(i,j,k->1/2,2/3,3/5)"]],
		True,
		"ZMatrix nuLPQ1"
		]
,
  (* Test of idLinearPartQ *)
	testFunction[
		idLinearPartQ[readMat["(i,j,k->i+1/2,j+2/3,k-3/5)"]],
		True,
		"ZMatrix idLPQ1"
		]
,
  (* Test of subMatrices *)
	testFunction[
		m1=readMat["(i,j,k->i,j,k)"];
		m2=readMat["(i,j,k->2i/3+1/2,2j+2,k-3)"];
		subMatrices[m2,m1],
		matrix[4, 4, {"i", "j", "k"}, {{-2, 0, 0, 3}, {0, 12, 0, 12}, {0, 0, 6, -18}, {0, 0, 0, 6}}],
		"ZMatrix subM1"
		]
,
  (* Test of hermite *)
    testFunction[
		mat1=readMat["(i,j,k->i/2+j/3+4,k/3-i/3,i+j+k)"];
		h= hermite[mat1],
		{matrix[4, 4, {"i", "j", "k"}, {{1, 0, 0, 24}, {0, 2, 0, 0}, {0, 0, 6, 0}, {0, 0, 0, 6}}], 
		matrix[4, 4, {"i", "j", "k"}, {{3, 2, 0, 0}, {-1, 0, 1, 0}, {1, 1, 1, 0}, {0, 0, 0, 1}}]},
		"ZMatrix hermite1"
		]
,
  (* Test of alphaToMmaMatrix *)
    testFunction[
		mat1=readMat["(i,j,k->i/2+j/3+4,k/3-i/3,i+j+k)"];
		alphaToMmaMatrix[mat1],
		{{1/2, 1/3, 0}, {-1/3, 0, 1/3}, {1, 1, 1}},
		"ZMatrix alpToMma1"
		]
,
  (* Test of mmaToAlphaMatrix *)
	testFunction[
		mmaToAlphaMatrix[{{1/2,1/3,0},{-1/3,0,1/3},{3,1,1}},{1,2,5/6}],
		matrix[4, 4, {}, {{3, 2, 0, 6}, {-2, 0, 2, 12}, {18, 6, 6, 5}, {0, 0, 0, 6}}],
		"ZMatrix mmaToAlp1"
		]
,
  (* Test of canonicalProjection *)
    testFunction[
      d=readDom["{2i+5j+7k+7 , 3j+6k+i-4 , 3k-3j+2i | 0<i<2 ; 0<2j<2}"];
      canonicalProjection[d,{1,3}],
      domain[1, {}, {zpol[matrix[4, 4, {"j"}, {{3, -4}, {0, 1}}], 
      {pol[2, 1, 1, 0, {{0, 2, -1}, {1, 0, 1}}, {{1, 1, 2}}]}]}],
      "ZMatrix canProj1"
    ]
,
  (* Test of smithNormalForm *)
    testFunction[
		smithNormalForm[readMat["(i,j,k->2i,3i+3k+j,j/3)"]],
		{matrix[4, 4, {"i", "j", "k"}, {{0, -2, -1, 0}, {3, -3, -1, 0}, {1, 0, 0, 0}, {0, 0, 0, 1}}], matrix[4, 4, {"i", "j", "k"}, {{1, 0, 0, 0}, {0, 3, 0, 0}, {0, 0, 18, 0}, {0, 0, 0, 3}}], matrix[4, 4, {"i", "j", "k"}, {{0, 1, 0, 0}, {-1, 0, -3, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}]},
		"ZMatrix SNF1"
		]
};

       (*
t1=<<hermiteT.m;
t2=<<unimodularCompletionTest.m;
	*)

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
