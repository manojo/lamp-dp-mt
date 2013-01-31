BeginPackage["Alpha`TestCutMMA`",
  {"Alpha`","Alpha`Domlib`","Alpha`CutMMA`","Alpha`Normalization`"}];

Begin["`Private`"];

(* Test of CutMMA.m *)
(* Modified 2008-12-31 *)

$testResult = True; 

Module[{dir,sys0,error,test1},

res={
  testFunction[
    load["Test2.alpha"]; 
    cut["Z","{i|i>=1}","Zout","Zin"],<<RTest2,"Cut 1"]
,
  testFunction[
    load["Test2.alpha"]; 
    cut["Z","{i|2}","Z1","Z2"],Null,"Cut 2"]
,
  testFunction[cut[
    load["Test2.alpha"]; 
    "Zout","{i|i>=1}","Z","Z"],Null,"Cut 3"]
,
  testFunction[
    load["Test2.alpha"]; 
    cut["Zout","{i|i>=1}","Z","Zin"],Null,"Cut 4"]
,
  testFunction[
    load["MV6.alpha"]; sys0 = $result;

    (* first form *) 
    cut["B1","{t,p | p<=t<=p+3; 0<=p<=1}","B11","B12"];
    normalize[];
    test1 = <<AST1; test1 === $result, 
    True ,"Cut 5"
  ]
,
  testFunction[
    load["MV6.alpha"]; 
    cut["B1","{t,p | p<=t<=p+3; 0<=p<=1}","B11","B12"];
    normalize[];
    $result === <<AST1, True, "Cut 6"]
,
  testFunction[
    load["MV6.alpha"]; 
    normalize[cut["B1",readDom["{t,p | p<=t<=p+3; 0<=p<=1}",
      $result[[2,2]]],"B11","B12"]],
    <<AST1,"Cut 8"]
,
  testFunction[
    load["MV6.alpha"]; 
    normalize[cut["B1",readDom["{t,p | p<=t<=p+3; 0<=p<=1}",
      $result[[2,2]]],"B11","B12"]],
    <<AST1,"Cut 9"]
,
(*
  testFunction[
    load["Zpol1.alpha"];
    cut["XX","{i,4j | 0<=i<=N; 0<=2j<=N }","XX1","XX2"];
    normalize[],
    <<ZAST1,
   "ZCut 1"
  ]
,
  testFunction[
    $result = <<ZAST1;
    decompose["x.(i,j->2i)","Y"],
    <<ZAST2,
   "ZCut 2"
  ]
,
  testFunction[
    $result = <<ZAST1;
    merge["XX1","XX2","Y"];
    normalize[],
    <<ZAST3,
    "ZCut 3"
  ]
, *)

  (* "test of mergeCaseBranches" *)
  testFunction[
    $result=<<ZAST3;
    mergeCaseBranches[{6,1,2},{1,2}],
    <<ZAST4,
    "ZCut mergeCB1"
  ]

  };

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
