BeginPackage["Alpha`TestAlpha`",
  {"Alpha`","Alpha`Domlib`","Alpha`Tables`"}];

Begin["`Private`"];

Module[{ res },

$testResult = True; 

res = 
{
  (* ---> Test (partiel) de Tables.m *)
  testFunction[
    load["MV6.alpha"];
    getOutputVars[]==={"c"}, 
    True, "Tables 1"
  ]
,
  testFunction[
    load["MV6.alpha"];
    getVariables[]==={"a", "A", "b", "B1", "c", "C", "loadC"},
    True, "Tables 2"
  ]
,
  testFunction[
    load["MV6.alpha"];
    getLocalVars[]==={"B1", "A", "C", "loadC"},
    True, "Tables 3"
  ]

,
  testFunction[
    load["MV6.alpha"];
    getInputVars[]==={"a", "b"},
    True, "Tables 4"
  ]

,
  (* Test of getDimension for Zpolyhedra *)
  testFunction[
    load["test1.alpha"];
    getDimension[readDom["{ 6i+j,8j-6 | -5<=i<=5 ; -5<=j<=5}"]] === 2,
    True, 
    "ZTables 1" ]
,

  (* Test of getDeclaration for Zpolyhedra *)
  testFunction[
    load["test1.alpha"];
    getDeclaration["XX"],
    decl["XX", integer, domain[4, {}, {zpol[matrix[5, 5, {"i", "j", "N", "M"}, {{1, 0, 0, 0, 0}, {0, 2, 0, 0, 0}, {0, 0, 1, 0, 0}, {0, 0, 0, 1, 0}, {0, 0, 0, 0, 1}}], {pol[5, 6, 0, 1, {{1, 1, 0, 0, 0, 0}, {1, -1, 0, 1, 0, 0}, {1, 0, 1, 0, 0, 0}, {1, 0, -1, 1, 0, 0}, {1, 0, 0, 0, 0, 1}}, {{0, 0, 0, 0, 1, 0}, {1, 0, 0, 0, 0, 1}, {1, 0, 0, 1, 0, 0}, {1, 1, 0, 1, 0, 0}, {1, 1, 1, 1, 0, 0}, {1, 0, 1, 1, 0, 0}}]}]}]],
    "ZTables 2"]
,
  (* Test of getDefinition for Zpolyhedra *)
  testFunction[
    load["test1.alpha"];
    getDefinition["ZZ"],
    affine[var["XX"], matrix[5, 5, {"i", "j", "N", "M"}, {{2, 0, 0, 0, 0}, {0, 1, 0, 0, 0}, {0, 0, 2, 0, 0}, {0, 0, 0, 2, 0}, {0, 0, 0, 0, 2}}]],
    "ZTables 3"]
,
  (* Test of getEquation for Zpolyhedra *)
  testFunction[
    load["test1.alpha"];
    getEquation["ZZ"],
    equation["ZZ", affine[var["XX"], 
      matrix[5, 5, {"i", "j", "N", "M"}, {{2, 0, 0, 0, 0}, {0, 1, 0, 0, 0}, 
      {0, 0, 2, 0, 0}, {0, 0, 0, 2, 0}, {0, 0, 0, 0, 2}}]]
    ],
   "ZTables 4"]
(*
,
	testFunction[
		DomEqualQ[getDeclarationDomain["XX"],
		domain[4, {}, {zpol[matrix[5, 5, {"i", "j", "N", "M"}, {{1, 0, 0, 0, 0}, {0, 2, 0, 0, 0}, {0, 0, 1, 0, 0}, {0, 0, 0, 1, 0}, {0, 0, 0, 0, 1}}], {pol[7, 9, 0, 0, {{1, 0, 0, -1, 1, -1}, {1, -1, 0, 1, 0, 0}, {1, 0, 1, 0, 0, 0}, {1, 0, 0, 1, 0, -2}, {1, 1, 0, 0, 0, 0}, {1, 0, -1, 1, 0, 0}, {1, 0, 0, 0, 0, 1}}, {{1, 0, 0, 0, 1, 0}, {1, 0, 1, 1, 1, 0}, {1, 0, 0, 1, 1, 0}, {1, 1, 0, 1, 1, 0}, {1, 1, 1, 1, 1, 0}, {1, 2, 2, 2, 3, 1}, {1, 0, 2, 2, 3, 1}, {1, 0, 0, 2, 3, 1}, {1, 2, 0, 2, 3, 1}}]}]}]],
		True,
		"ZTables getDecDom1"
		]
*)

(*
1. A syntax error is given if I try to declare the parameter domain of an Alpha program as a 
   Z-polyhedra.
2. Need to add a getIndex function which returns the index list of the domain : diff from index
   list of matrix??
*)


};

$testResult = $testResult && Apply[And,res];

]

End[];

EndPackage[];

