dir = Directory[]
 SetDirectory[Environment["MMALPHA"]<>"/tests/TestPipeline"]; 

res = 
{
load["MV1.alpha"];
Print["testing pipeall"];
p1 = pipeall["C", "b.(i,j->j)", "BB.(i,j->i+1,j)"];
If [p1===<<MV61.ast,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p2 = pipeall["C", "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
If [p2===<<MV62.ast,
    Print["OK"];True,Print["Problem"];False]; True,
load["MV1.alpha"];
p3 = pipeall[{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)"];
If [p1===p3,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p4 = pipeall[{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
If [p4===p2,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p5 = pipeall[$result,"C", "b.(i,j->j)", "BB.(i,j->i+1,j)"];
If [p1===p5 && p5=!=$result ,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p6 = pipeall[$result,"C", "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
If [p6===p2 || p6 =!= $result,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p5 = pipeall[$result,{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)"];
If [p1===p5 && p5=!=$result ,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p6 = pipeall[$result,{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
If [p6===p2,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p5 = pipeall[$result,"C", readExp["b.(i,j->j)",$result[[2]]], 
	     readExp["BB.(i,j->i+1,j)",$result[[2]]]];
If [p1===p5 && p5=!=$result ,
    Print["OK"];True,Print["Problem"];False],
load["MV1.alpha"];
p6 = pipeall[$result,"C",
	     readExp["b.(i,j->j)",$result[[2]]],
	     readExp["BB.(i,j->i+1,j)",$result[[2]]], 
	     readDom["{i,j| i>=-1}",$result[[2]]]];
If [p6===p2 || p6 =!= $result,
    Print["OK"];True,Print["Problem"];False],

prog2=<<1.ast;
prog1=First[load["MV1.alpha"]];
Error=0;
Print["Testing pipeline function"];
p1=First[Position[$result,readExp["b.(i,j->j)",{"N"}]]];
Print["pipeline b in C with pipe vector (0,1), should failed "];
pipeline[p1,"B1.(i,j->i,j+1)"];
If [prog1=!=$result,
    Print["Problem with test1"];False,
    Print["test1 OK \n \n"];True],
Print["pipeline b in C with pipe vector (1,0), should succeed"];
nprog1=pipeline[p1,"B1.(i,j->i+1,j)"];
If [nprog1=!=<<8.ast,
    Error=2;Print["Problem with test2"];False,
    Print["test2 OK\n \n"];True],
Print["Testing pipeall function"];
prog2=<<2.ast;
prog1=First[load["MV1.alpha"]];
Print["pipeline b in C with pipe vector (0,1), should failed "];
pipeall["C","b.(i,j->j)","B1.(i,j->i,j+1)"];
If [prog1=!=$result,
    Error=3;Print["Problem with test3"];False,
    Print["test3 OK\n\n"];True];
load["MV1.alpha"];
Print["pipeline b in C with pipe vector (1,0), should succeed"];
pipeall["C","b.(i,j->j)","B1.(i,j->i+1,j)"];
If [prog2=!=$result,
    Error=4;Print["Problem with test4"];False,
    Print["test4 OK\n\n"];True];



load["MV1P2.alpha"];
(* $result >> 5.ast *)
prog0= << 5.ast;
sys1=pipeIO[$result,"c",readExp["C"],
       readExp["C2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | i <=N}"]];
(* sys1 >> 4.ast *)
prog1=<<4.ast;
If [prog1=!=sys1,
    Error=1;Print["Problem with test11"];False,
    Print["test11 OK \n \n"];True],
sys1=pipeIO["c",readExp["C"],
       readExp["C2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | i <=N}"]];
If [prog1=!=$result,
    Error=2;Print["Problem with test22"];False,
    Print["test22 OK \n \n"];True],
load["MV1P2.alpha"];
sys1=pipeIO[$result,"c","C","C2.(i,j->i+1,j+1)","{i,j | i <=N}"];
If [(prog1=!=sys1)||($result=!=prog0),
    Error=3;Print["Problem with test33"];False,
    Print["test33 OK \n \n"];True],
load["MV1P2.alpha"];
sys1=pipeIO["c","C","C2.(i,j->i+1,j+1)","{i,j | i <=N}"];
If [prog1=!=$result,
    Error=4;Print["Problem with test44"];False,
    Print["test44 OK \n \n"];True],
load["MV1P1.alpha"];
(* $result >> 6.ast *)
prog0= << 6.ast;
sys1=pipeIO[$result,"B1",readExp["b.(i,j,N->j,N)"],
       readExp["B2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | j >=0}"]];
(*  sys1 >> 7.ast *)
prog1=<<7.ast;
If [prog1=!=sys1,
    Error=1;Print["Problem with test111"];False,
    Print["test111 OK \n \n"];True],
sys1=pipeIO["B1",readExp["b.(i,j,N->j,N)"],
       readExp["B2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | j >=0}"]];
If [prog1=!=$result,
    Error=2;Print["Problem with test222"];False,
    Print["test222 OK \n \n"];True],
load["MV1P1.alpha"];
sys1=pipeIO[$result,"B1","b.(i,j->j)","B2.(i,j->i+1,j+1)","{i,j | j >=0}"];
If [(prog1=!=sys1)||($result=!=prog0),
    Error=3;Print["Problem with test333"];False,
    Print["test333 OK \n \n"];True],
load["MV1P1.alpha"];
sys1=pipeIO["B1","b.(i,j->j)","B2.(i,j->i+1,j+1)","{i,j | j >=0}"];
If [prog1=!=$result,
    Error=4;Print["Problem with test444"];False,
    Print["test444 OK \n \n"];True],

load["MV6.alpha"];
res1 = pipeline[$result,
	 {6, 4, 2, 1, 1, 2},
	 "loadCPipe",
	 readMat["(i1,i2->i1+1,i2+1)"]];
res2= pipeline[$result,
	 {6, 4, 2, 1, 1, 2},
	 "loadCPipe",
	 readMat["(i1,i2->i1+1,i2+1)"],
	 readDom["{t,p | 0<=p}"]];
(* If [res1=!=res2,
    Print["Problem1"];False,
    Print["Test1 OK\n\n"];True], This test does not work *)
res3= pipeline[$result,
	 {6, 4, 2, 1, 1, 2},
	 "loadCPipe",
	 readMat["(i1,i2->i1+1,i2+1)"],
	 readDom["{t,p | 0<=t}"]];
If[DomEqualQ[DomConvex[getDeclaration[res3,"loadCPipe"][[3]]],
	     readDom["{t,p | (0,p-1)<=t<=p+3;p<=3}"]],
Print["Test 2 OK \n\n"];True,
Print["Problem2\n"];False]

}
finalRes=Apply[And,res];
Print[res];
If [finalRes,
    Print["No problem occured during test of Pipeline.m"],
Print["WARNING: problems occured during test of Pipeline.m"]];

finalRes


