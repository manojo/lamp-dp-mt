BeginPackage["Alpha`TestDecomposition`",
  {"Alpha`","Alpha`Domlib`","Alpha`Options`","Alpha`CutMMA`"}];

Begin["`Private`"];

$testResult = True; 

(* Written by P. Quinton, 12/1/98 *)
Module[ {dir,res},

res = 
{
testFunction[
  load["Test.alpha"];
  decompose["x","U"],<<RTest1,"Decompose 1"
],
testFunction[
  $result <<RTest1;
  decompose["Z.(i->i+2)+x.(i->)","V"],<<RTest2,"Decompose 2"
],
testFunction[
  Check[decompose[22],Null],Null,"Decompose 3"
],
testFunction[Check[decompose["UU","W"],Null],Null,"Decompose 4"],
testFunction[Check[decompose["UU.2","W"],Null],Null,"Decompose 5"],
testFunction[Check[decompose["x","U"],Null],Null,"Decompose 6"]
};

  $testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];

