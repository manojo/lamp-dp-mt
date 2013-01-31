BeginPackage["Alpha`TestSubSystems`",
  {"Alpha`","Alpha`Domlib`","Alpha`SubSystems`"}];

Begin["`Private`"];

Module[ {res},

$testResult = True; 

res= 
{
  testFunction[
    load["add1Hard.alpha"];
    fixParameter["N",10];
    Length[Cases[Append[$library,$result],"N",Infinity]],
		0,
		"SubSystems 1"
  ]
,
  testFunction[
    load["add1Hard.alpha"];
    assignParameterValue["N",10];
		(Length[Cases[$library,"N",Infinity]]=!=0)&&(Length[Cases[$result,"N",Infinity]]===0),
		True,
		"SubSystems 2"
  ]
,
  testFunction[
    load["ZpolUse1.alpha"];
    inlineAll[],
    <<ZAST1,
    "Test 3 SubSystems"
  ]
	
};


$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];

