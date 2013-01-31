BeginPackage["Alpha`TestAlpha`",{"Alpha`","Alpha`Domlib`"}];

Begin["`Private`"];

(* Written by P. Quinton, 6/2/98 *)

(* Test for Alpha.m *)

Module[{ res1 },

$testResult = True; 

res1 = 

{
  testFunction[load["Test1.alpha"];$result,<<"RTest1","Alpha 1"],
  testFunction[load[22],Null,"Alpha 2"],
  testFunction[Check[show[],$Failed],Null,"Alpha 3"],
  (*
  testFunction[show[22],Null,"Alpha 4"],
   *)
  If[$OperatingSystem === "MacOS",
     testFunction[Check[showMat[readMat["(i,j->i+2,j+2)"]],$Failed],
		Null,"Alpha 5"];
     testFunction[showMat[22],Null,"Alpha 6"],True
   ],
  (*
  testFunction[Check[showLib[],$Failed],Null,"Alpha 7"],
  testFunction[showLib[22],Null,"Alpha 8"],
   *)
  testFunction[Check[ashow[],$Failed],Null,"Alpha 9"],
  (*
  testFunction[ashow[22],Null,"Alpha 10"],
  testFunction[Check[ashowLib[],$Failed],Null,"Alpha 11"],
  testFunction[ashowLib[22],Null,"Alpha 12"],
   *)
  testFunction[
    load["Test1.alpha"];
    save[$TemporaryPrefix<>"TT.alpha"];
    load[$TemporaryPrefix<>"TT.alpha"];$result,<<RTest1,"Alpha 13"],
  testFunction[SetDirectory[$tmpDirectory];save[],Null,"Alpha 14"],
    SetDirectory[Environment["MMALPHA"]<>"/tests/TestAlpha/"];
  testFunction[
    load["Test1.alpha"];
    asave[$tmpDirectory<>"/TT.alpha"];
    load[$tmpDirectory<>"/TT.alpha"];$result,<<RTest1,"Alpha 15"],
  testFunction[asave[],Null,"Alpha 16"],
  testFunction[
    load["Test2.alpha"];
    Check[saveLib[$tmpDirectory<>"TT.alpha"];
    load[$tmpDirectory<>"TT.alpha"];,$Failed],Null,"Alpha 17"],
  testFunction[
    load["Test2.alpha"];
    Check[asaveLib[$tmpDirectory<>"TT.alpha"];
    load[$tmpDirectory<>"TT.alpha"];,$Failed],Null,"Alpha 18"],
  testFunction[
    load["Test2.alpha"];
    getPart[$result,{2,3}],
    {pol[1,1,0,0,{{1,1}},{{1,1}}]},"Alpha  19"];
  testFunction[
    load["Test2.alpha"];
    getPart[$result,1],Null,"Alpha 20"],
  testFunction[
    load["Test2.alpha"];
    getPart[$result,{12}],Null,"Alpha 21"],
    If[$result===$Failed,Print["ICIIII1"]];
  testFunction[
    load["Test2.alpha"];
    getSystem["exemple6"],<<RTest2,"Alpha 22"],
    If[$result===$Failed,Print["ICIIII"]];
  testFunction[
    load["Test2.alpha"];
    getSystem[22],$Failed,"Alpha 23"], (* *)
    If[$result===$Failed,Print["ICIIII"]];
  testFunction[getSystem["abc"],$result,"Alpha 24"],
    If[$result===$Failed,Print["ICIIII"]];
  testFunction[Check[changeOfBasis["S.(t->t+2)"];
  putSystem[];,$Failed],Null,
  "Alpha 25"],
  testFunction[putSystem[33],Null,"Alpha 26"],
  testFunction[readAlpha["Test1.alpha"][[1]],<<RTest1,"Alpha 27"],
  testFunction[readAlpha[1,2],Null,"Alpha 28"],
  testFunction[readExp["A+B"],binop[add,var["A"],var["B"]],"Alpha 29"],
  testFunction[readExp[1],Null,"Alpha 30"],
  testFunction[readExp["{i|i=2}"],Null,"Alpha 31"],
  testFunction[readDom["{i|i=2}"],domain[1,{"i"},
    {pol[2,1,1,0,{{0,1,-2},{1,0,1}},{{1,2,1}}]}],"Alpha 32"],
  testFunction[readDom[1],Null,"Alpha 33"],
  testFunction[readMat["(i,j->i+3,2j)"],
    matrix[3,3,{"i","j"},{{1,0,3},{0,2,0},{0,0,1}}], "Alpha 34"],
  testFunction[readMat[1,2],Null,"Alpha 35"]
  (*
,

  (* Testing writeC *)
  testFunction[load["MV1.alpha"];writeC["MV1.c","-p 10"];
  ReadList["MV1.c",Record,RecordSeparators->{}]===
  ReadList["MV1.c",Record,RecordSeparators->{}],True,"writeC 1"],
  DeleteFile["MV1.c"];True
  ,

  (* Testing Zpols *)
testFunction[MatchQ[load["Zpol1.alpha"],{Alpha`system[___]}],True,"Alpha
Zpol 1" ],
testFunction[MatchQ[load["ZpolAffineRationnal.alpha"],{Alpha`system[___]}],True,"Alpha
Zpol 2" ],
testFunction[MatchQ[load["ZpolRestrict.alpha"],{Alpha`system[___]}],
  True,"Alpha Zpol 3" ],
testFunction[MatchQ[load["ZpolNoSquarseIntMat.alpha"],{Alpha`system[___]}],True,"Alpha
Zpol 4" ],
testFunction[MatchQ[load["ZpolUse1.alpha"],{Alpha`system[___],Alpha`system[___]}],True,"Alpha
Zpol 5" ],
  testFunction[
    saveLib[$tmpDirectory<>"ZpolUse1.alpha"];
    load[$tmpDirectory<>"ZpolUse1.alpha"],load["ZpolUse1.alpha"],
    "Alpha Zpol 6"],
  testFunction[MatchQ[readDom["{i,2j,N,M | 0<=i<=N;0<=j<=N}"],
    Alpha`domain[_,_,{Alpha`zpol[___]}]],True,"Alpha Zpol 7"]
 *)
};

$testResult = $testResult && Apply[And,res1];

]

End[];

EndPackage[];
