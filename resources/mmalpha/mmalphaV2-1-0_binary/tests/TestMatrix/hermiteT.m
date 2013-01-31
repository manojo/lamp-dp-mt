(* Test hermite *)

(* first hermiteR *)
Print["testing hermiteR "]; 
T1=True;
m1={{1,0,8,4},{8,7,6,5}}
hu1=hermiteR[m1];
If [hu1[[2]]=!={{1, 0, 8, 4}, {0, 7, -58, -27}},
T1=False;Print["Problem 1 with
hermiteR:",m1];Print["The hermite decomposition may be correct but it
may not have the requested properties"] ];
If[Det[hu1[[1]]]=!=1,T1=False;Print["Problem 1bis with
hermiteR:",m1]];

m2=Transpose[m1];
hu1=hermiteR[m2];
If [hu1[[2]]=!={{1, 0}, {0, 1}, {0, 0}, {0, 0}},T1=False;Print["Problem 2
with
hermiteR:",m2]];

m1={{1,2,3},{1,2,3},{4,5,6}};
hu1=hermiteR[m1];
If [hu1[[2]]=!={{1, 2, 3}, {0, 3, 6}, {0, 0,0}},T1=False;Print["Problem 3 with
hermiteR:",m1]];
 
m1={{1,2,3},{9,8,7},{4,30,67}};
hu1=hermiteR[m1];
If [hu1[[2]]=!={{1, 0, 43}, {0, 2, 15}, {0, 0, 55}},
    T1=False;Print["Problem 4 with
hermiteR:",m1]];
If[Dot[hu1[[1]],hu1[[2]]],T1=False;Print["Problem 5 with
hermiteR:",m1]];

hu2=hermiteR[m1];
If [hu2=!=hu1,T1=False;Print["Problem 6 with hermiteR"]];
 
m1={{1,2,3},{9,8,7},{4,30,67}};
hu1=hermiteR[m1];
hu3=hermiteL[Transpose[m1]];
hu4={Transpose[hu3[[2]]],Transpose[hu3[[1]]]};
If[hu4=!=hu1,T1=False;Print["Problem  7 with hermiteL"]];



mat1=readMat["(i,j,k->2i+3j+4,3k-3i,i+j+k)"]
h= hermite[mat1]
 
If[h=!= {matrix[4, 4, {"i", "j", "k"}, 
    {{1, 0, 0, 4}, {0, 3, 0, 0}, {3, 1, 4, 0}, {0, 0, 0, 1}}], 
   matrix[4, 4, {"i", "j", "k"}, 
    {{2, 3, 0, 0}, {-1, 0, 1, 0}, {-1, -2, 0, 0}, {0, 0, 0, 1}}]},
   Print["Problem 1 with hermite"];T1=False]

If [T1,Print["Test OK for hermiteR"],
    Print["Problem with hermiteR"];
    Print["Warning, We where testing if the current results where
    exactely the same as before. Some of the function tested may have
    several correct results (like hermite for non square matrices,
    please check by hand"]]


(********************* test smithNormalForm *********)

Print["Testing smithNormalForm"]
T2=True

mat5=readMat["(i,j,k->2i,3i+3k+3j,j)"]; 
ms1=smithNormalForm[mat5]
If [mat5[[4]] =!= Dot[ms1[[1,4]],ms1[[2,4]],ms1[[3,4]]], 
    Print["Problem 1 with smithNormalForm"];T2=False]
(*{matrix[4, 4, {i, j, k}, 
   {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}], 
  matrix[4, 4, {i, j, k}, {{2, 0, 0, 0}, {0, 3, 0, 0}, {0, 0, 1, 0}, 
    {0, 0, 0, 1}}], matrix[4, 4, {i, j, k}, 
   {{1, 0, 0, 0}, {1, 1, 1, 0}, {0, 1, 0, 0}, {0, 0, 0, 1}}]} *)
sm2=smithNormalForm[mat5[[4]]]
If [mat5[[4]] =!= Dot[sm2[[1]],sm2[[2]],sm2[[3]]], 
    Print["Problem 2 with smithNormalForm"];T2=False]

If [(Abs[Det[sm2[[1]]]]=!=1) || (Abs[Det[sm2[[3]]]]=!=1),
        Print["Problem 3 with smithNormalForm"];T2=False]


mat5=readMat["(i,j,k->2i,3i+3k+3j+2,j+4)"]; 
ms1=smithNormalForm[mat5]
If [mat5[[4]] =!= Dot[ms1[[1,4]],ms1[[2,4]],ms1[[3,4]]], 
    Print["Problem 4 with smithNormalForm"];T2=False]

mat6=readMat["(i,j,k->2i,3i+3k+3j,12j)"];
If[smithNormalForm[mat6]=!={matrix[4, 4, {"i", "j", "k"}, 
   {{2, -1, 0, 0}, {3, -1, 0, 0}, {0, 2, -1, 0}, {0, 0, 0, 1}}], 
  matrix[4, 4, {"i", "j", "k"}, {{1, 0, 0, 0}, {0, 6, 0, 0}, {0, 0, 12, 0}, 
    {0, 0, 0, 1}}], matrix[4, 4, {"i", "j", "k"}, 
   {{1, 3, 3, 0}, {0, 1, 1, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}]},
   Print["Warning 5 with smithNormalForm, please check by hand"];T2=False]

m7= {{2,4,8,9},{3,6,9,12}}
m8= smithNormalForm[m7]
If [m7 =!= Dot[m8[[1]],m8[[2]],m8[[3]]], 
    Print["Problem 7 with smithNormalForm"];T2=False]
If [m8[[2]]=!={{1, 0, 0, 0}, {0, 3, 0, 0}},
  Print["Problem 8 with smithNormalForm"];T2=False]

m1=Alpha`matrix[5,3,{"i","j"},{{1,2,0},{3,4,0},{5,6,0},{7,8,0},{0,0,1}}]
m2=smithNormalForm[m1]
If [m1 =!= composeAffines[m2[[1]],composeAffines[m2[[2]],m2[[3]]]], 
    Print["Problem 9 with smithNormalForm"];T2=False]
If [m2[[2,4]]=!={{1, 0, 0}, {0, 2, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 1}},
  Print["Problem 10 with smithNormalForm"];T2=False]

If [T2,Print["Test OK for smithNormalForm"],
    Print["Problem with smithNormalForm"];]


(***************** solveDiophantine ********************)

T3=True;
Print["Testing solveDiophantine"];

m={{1,0,-2,-1,0,0},{0,1,0,1,0,0},{1,0,0,0,-3,0},{0,1,0,0,0,1}}
If[solveDiophantine[m]=!= {{0, 0, 0, 0, 0, 0}, 2, 
  {{3, 0}, {-3, 2}, {0, 1}, {3, -2}, {1, 0}, {3, -2}}},
   Print["Problem 1 with solve Diophantine"];T3=False];


m={{1,0,-2,0,0,0},{0,1,0,1,0,0},{1,0,0,0,-2,-1},{0,1,0,0,0,1}}
If[solveDiophantine[m]=!= {{0, 0, 0, 0, 0, 0}, 2, 
  {{0, -2}, {-2, 0}, {0, -1}, {2, 0}, {-1, -1}, {2, 0}}},
   Print["Problem 2 with solve Diophantine"];T3=False];


If[solveDiophantine[m,{1,2,3,4}]=!={{1, 6, 0, -4, 0, -2}, 2, 
  {{0, -2}, {-2, 0}, {0, -1}, {2, 0}, {-1, -1}, {2, 0}}},
    Print["Problem 3 with solve Diophantine"];T3=False];

If[solveDiophantine[{{1,0,0},{2,0,0},{0,1,0},{0,0,1}},{1,2,1,1}]
   =!={{1, 1, 1}, 0, {{}, {}, {}}},
    Print["Problem 4 with solve Diophantine"];T3=False];

If[solveDiophantine[{{1,0,0},{2,0,0},{0,1,0},{0,0,1}},{1,1,1,1}]
   =!= {{}, 0, {{}, {}, {}}},
     Print["Problem 5 with solve Diophantine"];T3=False];

If[ solveDiophantine[{{4,0},{0,1}},{3,1}] =!= {{}, 0, {{}, {}}},
     Print["Problem 6 with solve Diophantine"];T3=False];


If [T3,Print["Test OK for solveDiophantine"],
    Print["Problem with solveDiophantine"];
    Print["Warning, We where testing if the current results where
    exactely the same as before. Some of the function tested may have
    several correct results (like hermite for non square matrices,
    please check by hand"]];



T1 && T2 && T3
