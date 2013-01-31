BeginPackage["Alpha`TestSynthesys`",{"Alpha`","Alpha`Domlib`",
      "Alpha`Synthesis`","Alpha`Options`", "Alpha`VertexSchedule`"}];

Begin["`Private`"];

(* Written by P. Quinton, 4/1/2009 *)

Module[{ res1, res },

$testResult = True; 

Print["      =============          "];
Print["This test checks that the synthesis procedure is OK. It takes
some time..."];
res1 = 

{
  testFunction[
    syn["fir.alpha", parameterRules -> {"N" -> 4, "M" -> 100}, 
      verbose -> False, schedMethod -> vertex, 
      optionsOfScheduler -> {addConstraints -> {"TxD1>=1"}}],
    Null, "Synthesis 1"]
  ,
  testFunction[
    syn["MV1.alpha", parameterRules -> {"N" -> 20}, pipe -> True ],
    Null, "Synthesis 2"]
  ,
  testFunction[
    syn["Samba.alpha", parameterRules -> {"X" -> 20,
      "Y" -> 100}, schedMethod -> vertex, pipe -> True],
    Null, "Synthesis 3"]

};

$testResult = $testResult && Apply[And,res1];

]

End[];

EndPackage[];
