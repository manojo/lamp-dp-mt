(* Test file for the function unimodularCompletion of the matrix
   package *)
(* Just Type <<unimodularCompletionTest.m  and see what happens *)
Print["Testing the unimodularCompletion function\n\n"]

unimodularCompletionTest=0;

res1=unimodularCompletion["FAUX PARAMETRE (EXPRES)"];
If [res1===Null,Print[" **** Test1 OK **** "],Print["Probleme with
Test1"];
    unimodularCompletionTest=1];

res2= unimodularCompletion[{1,1,1}];
If [res2===Alpha`matrix[4, 4, {}, {{1, 1, 1, 0},{1, 0, 0, 0}, {0, 0, 1, 0}, 
   {0, 0, 0, 1}}],Print[" *** Test2 OK *** "],
    Print["Probleme with Test2"];
    unimodularCompletionTest=1];

res3 = unimodularCompletion[{1,4,7}];
If [res3===Alpha`matrix[4, 4, {}, {{1, 4, 7, 0}, {0, 1, 1, 0}, {0, 0, 1, 0}, 
   {0, 0, 0, 1}}],Print[" *** Test3 OK *** "],
    Print["Probleme with Test3"];
    unimodularCompletionTest=1];

res4= unimodularCompletion[matrix[2, 4, {}, {{5, 15, 3, 0}, {0, 0, 0, 1}}]];
If [res4===Alpha`matrix[4, 4, {}, {{5, 15, 3, 0}, {0, 1, 0, 0}, {2, 5, 1, 0}, 
   {0, 0, 0, 1}}],Print[" *** Test4 OK *** "],
    Print["Probleme with Test4"];
    unimodularCompletionTest=1];

res5= unimodularCompletion[matrix[2, 4, {}, {{5, 15, 10, 0}, {0, 0, 0, 1}}]];
If [res5==={},Print[" *** Test5 OK *** "],
    Print["Probleme with Test5"];
      unimodularCompletionTest=1];


If [unimodularCompletionTest===0,
    Print["The function UnimodularCompletion is OK"];True,
    Print["Something is wrong in unimodularCompletion"];False]

