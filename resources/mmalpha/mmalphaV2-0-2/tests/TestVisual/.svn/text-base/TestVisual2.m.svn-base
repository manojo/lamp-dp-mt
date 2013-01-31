(*!!TUTORIAL: The following comment is usefull for the Tester *)

(*  SetDirectory[Environment["MMALPHA"]<>"/tests/VisualT"] 
 Just type
 <<visualManualT.m 
in MMA session *)
test1=True

(* !!TUTORIAL: for each function, anounce its test *)

Print["******* Testing showDomain*********\n"];

(* !!TUTORIAL: explanation of the test, for a notebook it may be 
different than for an emacs interface *)

Print["Two dimemsionnal domains will be drawn on the screen, 
 please check that they correspond to the
description
given in text"];

dom1 = Alpha`domain[2, {}, {Alpha`pol[4, 4, 0, 0,
       {{1, 0, 1, -1}, {1, -1, 1, 3}, {1, -1, -1, 9}, {1, 1, -1, -1}},
       {{1, 2, 1, 1}, {1, 4, 1, 1}, {1, 6, 3, 1}, {1, 5, 4, 1}}]}]
Print["dom1: should be a bounded quadrilater..."];
showDomain[dom1];
InputString["\nType return to continue\n"];


dom2 = Alpha`domain[2, {"t", "p"}, {Alpha`pol[3, 3, 0, 0,
       {{1, 0, -1, 4}, {1, 0, 1, -1}, {1, 1, -1, 0}},
       {{1, 1, 0, 0}, {1, 4, 4, 1}, {1, 1, 1, 1}}]}]
Print["dom2: infinite triagle, 2 points and a ray..."]
showDomain[dom2];
InputString["\nType return to continue\n"];

dom3 = Alpha`domain[2, {"t", "p"}, {Alpha`pol[3, 3, 0, 0,
       {{1, 0, 1, -1}, {1, -1, 1, 3}, {1, 1, -2, 0}},
       {{1, 2, 1, 1}, {1, 6, 3, 1}, {1, 4, 1, 1}}],
       Alpha`pol[3, 2, 1, 0,
       {{0, 0, 1, -4}, {1, 1, 0, -8}, {1, 0, 0, 1}},
       {{1, 1, 0, 0}, {1, 8, 4, 1}}]}] 
Print["dom3:  compound domain, 2 polyhedra... "]
showDomain[dom3];
InputString["\nType return to continue\n"];

dom4 = Alpha`domain[2, {"t", "p"}, {Alpha`pol[2, 2, 1, 1,
       {{0, 0, 1, 0}, {1, 0, 0, 1}},
       {{0, 1, 0, 0}, {1, 0, 0, 1}}]}];
Print["dom4: A line ..."];
showDomain[dom4];
InputString["\nType return to continue\n"];

dom5 = Alpha`domain[1, {"i"}, {Alpha`pol[2, 2, 0, 0,
       {{1, 1, -1}, {1, 0, 1}},
       {{1, 1, 0}, {1, 1, 1}}]}];
Print["dom5: A one dim graph ..., with the tittle \"ONE DIM GRAPH\" "];
showDomain[dom5,"ONE DIM GRAPH"];
InputString["\nType return to continue\n"];


dom6 = Alpha`domain[2, {i, j}, {Alpha`pol[3, 3, 0, 0,
    {{1, 1, 0, -1}, {1, -1, 0, 10}, {1, 0, 1, -1}},
    {{1, 0, 1, 0}, {1, 1, 1, 1}, {1, 10, 1, 1}}]}];
Print["dom6: long x short y arrows pointing up..."]
showDomain[dom6];
InputString["\nType return to continue\n"];


dom7 = Alpha`domain[2, {"i","j"}, {
        Alpha`pol[2, 3, 0, 1, {
            {1, -1, 0, 10},
            {1, 0, 0, 1}},{
            {0, 0, 1, 0},
            {1, -1, 0, 0},
            {1, 10, 0, 1}}]}]
Print["dom7:  A half plane..."];
showDomain[dom7];
InputString["\nType return to continue\n"];


dom8 = Alpha`domain[2, {"i","j"}, {
        Alpha`pol[1, 2, 0, 1, {
            {1, -1, 0, -1}}, {
            {0, 0, 1, 0},
            {1, -1, 0, 1}}], 
        Alpha`pol[1, 2, 0, 1, {
            {1, 0, 1, -1}}, {
            {0, 1, 0, 0},
            {1, 0, 1, 1}}]}]
Print["dom8: two half planes..."];
showDomain[dom8];
InputString["\nType return to continue\n"];


(* !!TUTORIAL: don't forget to test what should not work also *)

Print["Testing ERRORS messages"]

dom9=readDom["{i,j,k | i,j,k >= 0 }"]
Print["dom9: Testing Dimension greater than two"];
 res1=Check[showDomain[dom9];False,True,showDomain::noOutput]; 
If  [!res1,Print["Problem 1 for bbDomain"];test1=False];


Print["dom10: Showing empty domain"]
dom10=DomEmpty[2];
res1=Check[showDomain[dom10];False,True,showDomain::noOutput];
If  [!res1,Print["Problem 2 for bbDomain"];test1=False];


Print["Testing wrong parameters "];
res1=Check[showDomain[abcd];False,True,showDomain::wrongP];
If  [!res1,Print["Problem 2 for bbDomain"];test1=False];


If [test1,Print["Error messages are OK for showDomain"],
    Print["Problem with error messages of showDomain"]];

test1






