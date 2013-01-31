Print["Test of Static -- This version is in : ",Directory[]];
Module[{d2, d3, d4, d6},

res = 
{

Print["Test of analyze"];
load["test0.alpha"];
(*	This test should provide no ERROR, no WARNING, no
	information messages, and return True *)
testFunction[ analyze[{verbose->False, recurse->False}], True, "analyze 1" ], 

(* 	Testing analyze[] with options verbose and recurse. 
	This test should provide no ERROR, one WARNING message, lots of
	information messages, and return True *)
testFunction[ analyze[{verbose->True, recurse->True}], True, "analyze 2" ],

(* 	Testing analyze[] on a buggy program 
	This test should provide lots of ERROR messages and return False *)
load["test1.alpha"];
testFunction[ analyze[{verbose->True, recurse->True}], False, "analyze 3" ],

(*	Testing the dep[] function *)
Print["Test of dep"];
load["test0.alpha"];
getSystem["ZeroColumn"];
testFunction[ dep[], <<DEP1, "dep 1" ], 

getSystem["Gauss"];
d2=Catch[dep[]];
testFunction[ d2, "ERROR", "dep 2" ],

load["test2.alpha"];
testFunction[ dep[], <<DEP3, "dep 3" ], 

load["test2.alpha"];
testFunction[ dep[{eliminatesDoubles -> True}], <<DEP4, "dep 4" ], 

d5=Catch[dep[bidouille]];
testFunction[d5, "ERROR", "dep 5" ]

}
] (* Module *)

finalRes=Apply[And,res];
If [finalRes,
    Print["No problem occured during test of Static.m"],
Print["WARNING: problems occured during test of Static.m"]];

finalRes


