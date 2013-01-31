BeginPackage["Alpha`TestVhdlTestBench`",
  {"Alpha`","Alpha`Domlib`","Alpha`VhdlTestBench`"}];

Begin["`Private`"];

(* Test of CutMMA.m *)
(* Modified 2008-12-31 *)
<<Alpha/VhdlTestBench.m;
$testResult = True; 

Module[{dir,sys0,error,test1},

res={
  testFunction[
    Clear[$result ];
    Clear[$library];
    load["firFixed.alpha"]; 
    DeleteFile[ "fir_TB.vhd" ];
    vhdlTestBenchGen[ debug -> False ];
    FileInformation[ "fir_TB.vhd" ] =!= {}
  ,
    True
  ,
    "vhdlTestBenchGen 1"
  ]
,
  testFunction[
    Clear[$result ];
    Clear[$library];
    load["fir.alpha"]; 
    vhdlTestBenchGen[ debug -> False]
  ,
    Null
  ,
    "vhdlTestBenchGen 2"
  ]
};

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
