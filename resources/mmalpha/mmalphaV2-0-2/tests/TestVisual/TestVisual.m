BeginPackage["Alpha`TestVisual`",
  {"Alpha`","Alpha`Domlib`","Alpha`Visual`"}];

Begin["`Private`"];



Module[ {res, dom1, test1},

$testResult = True; 

(* It has been settled by Tanguy and Patrice on 06/24/96.
   In the following, the comments starting by !!TUTORIAL 
   are part of the building test tutorial *)

(* Obsolete... *)
(*!!TUTORIAL: The following comment is usefull for the Tester *)
(*  SetDirectory[Environment["MMALPHA"]<>"/tests/VisualT"] 
 Just type <<visualAutoT.m in MMA session *)

(* !!TUTORIAL Standard function test (completely automatic 
   The variable test1 is set to false when one test has failed.
   Do not forget to number the tests so that the tester can easily 
   find back which test has failed *)

res =
    {

testFunction[
dom1 = Alpha`domain[2, {}, {Alpha`pol[4, 4, 0, 0,
       {{1, 0, 1, -1}, {1, -1, 1, 3}, {1, -1, -1, 9}, {1, 1, -1, -1}},
   {{1, 2, 1, 1}, {1, 4, 1, 1}, {1, 6, 3, 1}, {1, 5, 4, 1}}]}];
getBoundingBox[dom1]==={{2, 6}, {1, 4}},
True,
"Visual 1"],

testFunction[
dom11=readDom["{i,j| 1<=i,j<=4} | {i,j| 5<=i,j<=10}"];
getBoundingBox[dom11]==={{1, 4}, {1, 4}},
True,
"Visual 2"],

testFunction[
dom2 = Alpha`domain[2, {"t", "p"}, {Alpha`pol[3, 3, 0, 0,
       {{1, 0, -1, 4}, {1, 0, 1, -1}, {1, 1, -1, 0}},
  {{1, 1, 0, 0}, {1, 4, 4, 1}, {1, 1, 1, 1}}]}];
getBoundingBox[dom2]==={{1, Infinity}, {1, 4} },
True,
"Visual 3"],

testFunction[
dom4 = Alpha`domain[2, {"t", "p"}, {Alpha`pol[2, 2, 1, 1,
       {{0, 0, 1, 0}, {1, 0, 0, 1}},
       {{0, 1, 0, 0}, {1, 0, 0, 1}}]}];
getBoundingBox[dom4]==={{0, Infinity}, {0, 0}},
True,
"Visual 4"],

testFunction[
dom5 = Alpha`domain[1, {"i"}, {Alpha`pol[2, 2, 0, 0,
       {{1, 1, -1}, {1, 0, 1}},
       {{1, 1, 0}, {1, 1, 1}}]}];
getBoundingBox[dom5]==={{1, Infinity}},
True,
"Visual 5"],


testFunction[
dom6 = Alpha`domain[2, {i, j}, {Alpha`pol[3, 3, 0, 0,
    {{1, 1, 0, -1}, {1, -1, 0, 10}, {1, 0, 1, -1}},
    {{1, 0, 1, 0}, {1, 1, 1, 1}, {1, 10, 1, 1}}]}];
getBoundingBox[dom6]==={{1,10},{1,Infinity}},
True,
"Visual 6"],

testFunction[
dom7 = Alpha`domain[2, {"i","j"}, {
        Alpha`pol[2, 3, 0, 1, {
            {1, -1, 0, 10},
            {1, 0, 0, 1}},{
            {0, 0, 1, 0},
            {1, -1, 0, 0},
            {1, 10, 0, 1}}]}];

getBoundingBox[dom7]===List[List[DirectedInfinity[1],10],
  List[0,DirectedInfinity[1]]],
True,
"Visual 7"]
    };

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
