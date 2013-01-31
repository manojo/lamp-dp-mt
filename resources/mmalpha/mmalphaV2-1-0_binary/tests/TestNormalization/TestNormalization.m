BeginPackage["Alpha`TestNormalization`",
  {"Alpha`","Alpha`Domlib`","Alpha`Tables`", "Alpha`Substitution`","Alpha`Normalization`"}];

Begin["`Private`"];

(* Written by P. Quinton, 4/1/98 *)
(* Updated and checked on dec. 27, 2002 *)

Module[ {dir, res, allTest, a, b, ast2, ast3, ast4, ast5}, 

$testResult = True; 

res=
  {
  testFunction[
    load["Test1.alpha"];
    addLocal["U","Z"];substituteInDef["Z","U"];
    substituteInDef["Z","U"];
    normalize[];
    $result,<<RTest11,"Normalize 1"
],
  testFunction[
    $result = <<RTest11;
    substituteInDef["U","U"];normalize[];
    (* $result>>RTest12; *)
    $result,
    <<RTest12,"Normalize 2"
],
  testFunction[
    $result = <<RTest12;
    normalize["Z"];
    (* $result>>RTest13; *)
    $result,<<RTest13,"Normalize 3"
],
  testFunction[
    load["Test2.alpha"];
    normalizeInCtxt[getDefinition["Z"],readDom["{i|i>=0}"]],
    <<RTest2,"Normalize 4"
  ],
  testFunction[
    load["Test3.alpha"];
    simplifyInContext[];
    (* $result>>RTest3; *)
    $result,<<RTest3,"Normalize 5"
  ],
  testFunction[
    load["tn1.alpha"];
    simplifyInContext[],<<AST1,"Normalize 6"
  ],
  testFunction[
    $result = <<AST1;
    simplifyInContext[],<<AST1,"Normalize 7"
  ],
  testFunction[
    load["tn1.alpha"];
    ast2=substituteInDef["A","B"];
    ast2,<<AST2,"Normalize 8"
  ],
  testFunction[
    $result = <<AST2;
    ast3=substituteInDef["A","A"];
    ast3,<<AST3,"Normalize 9"]
  ,
  testFunction[
    $result = <<AST3;
    ast4=substituteInDef["A","A"];
    ast4,<<AST4,"Normalize 10"]
  ,
  Print["Normalizing... (takes a little while)..."];
  ast5=normalize[];
  testFunction[ast5,<<AST5,"Normalize 11"]
(*
  ,
  Print["Test of normalize"];
  testFunction[
    load["decimation.alpha"];
    normalize[],
    <<ZAST1,
    "ZNormalization norm1"
    ],

  Print["Test of normalizeQ"];
  testFunction[
    normalizeQ[<<ZAST1],
    True,
    "ZNormalization normQ1"
  ],

  Print["Test of simplifyInCtxt"];
  testFunction[
    load["tn2.alpha"];
    simplifyInContext[],
    <<ZAST2,
    "ZNormalization simplifyInCtxt1"
  ],

  Print["Test of minRestrictInCtxt"];
  testFunction[
    a=load["tn2.alpha"];
    d=readDom["{2i | i>=0}"];
    minRestrictInCtxt[a,d],
    <<ZAST3,
    "ZNormalization minRestrictInCtxt1"
   ]
*)
  };

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
