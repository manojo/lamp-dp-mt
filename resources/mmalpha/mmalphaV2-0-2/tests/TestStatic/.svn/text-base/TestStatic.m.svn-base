BeginPackage["Alpha`TestStatic`",
  {"Alpha`","Alpha`Domlib`","Alpha`Options`","Alpha`Static`"}];

Begin["`Private`"];

Module[ {res, d1, d2, d3, d4, d5},

$testResult = True; 

res = 
{
  testFunction[
    load["test0.alpha"];
    analyze[{verbose->False, recurse->False}],
    True,"Static 1"
  ],
  testFunction[
    load["test0.alpha"];
    analyze[{verbose->False, recurse->True}],
    True,"Static 2"
  ],
  testFunction[
    load["test1.alpha"];
    !analyze[{verbose->True, recurse->True}],
    True,"Static 3"
  ],
  testFunction[
    load["test0.alpha"];
    getSystem["ZeroColumn"];
    d1=dep[],
    <<DEP1,"Static 4"
  ],
  testFunction[
    load["test0.alpha"];
    getSystem["ZeroColumn"];
    d1=dep[],
    <<DEP1,"Static 5"
  ],
  testFunction[
    load["test0.alpha"];
    getSystem["Gauss"];
    d2=Catch[dep[]];
    Length[d2]===2,
    True,"Static 6"
  ],
  testFunction[
    load["test2.alpha"];
    d3=dep[],
    <<DEP3,"Static 7"
  ],
  testFunction[
    load["test2.alpha"];
    d4=dep[{eliminatesDoubles -> True}],
    <<DEP4,"Static 8"
  ],
  testFunction[
    load["test2.alpha"];
    Check[
      d5 = dep[bidouille],
      True
    ],
    True,"Static 9"
  ]

(*  The remaining tests are disabled
,
  Print["Test of analyze"];
  testFunction[
    load["EXAMPLEZPOLS/decimation.alpha"];
    analyze[],
    True,
    "ZStatic analyze1"
 ],

	testFunction[
		load["EXAMPLEZPOLS/ZpolUnion.alpha"];
		analyze[],
		True,
		"ZStatic analyze2 : should have given one warning"
		],
		
	testFunction[
		load["EXAMPLEZPOLS/Zpol2.alpha"];
		analyze[],
		True,
		"ZStatic analyze3"
		],
		
	testFunction[
		load["EXAMPLEZPOLS/ZpolParam.alpha"];
		analyze[],
		True,
		"ZStatic analyze4"
		],
		
	testFunction[
		load["EXAMPLEZPOLS/ZpolComposeAffine.alpha"];
		analyze[],
		True,
		"ZStatic analyze5"
		],
		
	testFunction[
		load["EXAMPLEZPOLS/ZpolInput.alpha"];
		analyze[],
		True,
		"ZStatic analyze6"
		],
		
	testFunction[
		load["EXAMPLEZPOLS/ZpolNoSquarseIntMat.alpha"];
		analyze[],
		True,
		"ZStatic analyze7"
		],
		
	testFunction[
		load["EXAMPLEZPOLS/Zpol1.alpha"];
		analyze[],
		True,
		"ZStatic analyze8"
		],

	testFunction[
		load["EXAMPLEZPOLS/SATz.alpha"];
		analyze[],
		True,
		"ZStatic analyze9"
		],

	testFunction[
		load["EXAMPLEZPOLS/ZpolUse1.alpha"];
		analyze[{recurse->True}],
		True,
		"ZStatic analyze10"
		],

Print["************** known bug with dep[] ************"];True
         Print["Test of dep"];
	testFunction[
		load["EXAMPLEZPOLS/decimation.alpha"];
		dep[],
		<<EXAMPLEZPOLS/ZAST1,
		"ZStatic dep1"
		] ,

        Print["Test of checkUseful"];
	load["EXAMPLEZPOLS/ChkUseful.alpha"];
	testFunction[
		DomEmptyQ[checkUseful["YY"]],
		True,
		"ZStatic chkUseful1"
		],

	testFunction[
		DomEmptyQ[checkUseful["ZZ"]],
		False,
		"ZStatic chkUseful2"
		]
 *)
};

  $testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
