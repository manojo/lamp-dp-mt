(* Written by P. Quinton, 4/1/98 *)
Print["Test for Normalize"];

load["Test1.alpha"];
addLocal["U","Z"];substituteInDef["Z","U"];
substituteInDef["Z","U"];
normalize[];
(* $result>>RTest11; *)
testFunction[$result,<<RTest11,"Normalize 1"];
substituteInDef["U","U"];normalize[];
(* $result>>RTest12; *)
testFunction[$result,<<RTest12,"Normalize 2"];
normalize["Z"];
(* $result>>RTest13; *)
testFunction[$result,<<RTest13,"Normalize 3"];
load["Test2.alpha"];
testFunction[normalizeInCtxt[getDefinition["Z"],readDom["{i|i>=0}"]],
<<RTest2,"Normalize 4"];
load["Test3.alpha"];
simplifyInContext[];
(* $result>>RTest3; *)
testFunction[$result,<<RTest3,"Normalize 5"];
Print["End of test"];

