BeginPackage["Alpha`TestPipeline`",
	     {"Alpha`","Alpha`Domlib`","Alpha`Pipeline`"}];

Begin["`Private`"];

Module[ {res, p1, p2, p3, p4, p5, p6},

$testResult = True; 

res = 
{
  testFunction[
    load["MV1.alpha"];
    p1 = pipeall["C", "b.(i,j->j)", "BB.(i,j->i+1,j)"];
    p1===<<MV61.ast,
    True,"Pipeline 1"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p2 = pipeall["C", "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
    p2===<<MV62.ast,
    True,"Pipeline 2"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p3 = pipeall[{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)"];
    p3===<<MV61.ast,
    True,"Pipeline 3"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p4 = pipeall[{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
    p4===<<MV62.ast,
    True,"Pipeline 4"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p5 = pipeall[$result,"C", "b.(i,j->j)", "BB.(i,j->i+1,j)"];
    p5===<<MV61.ast && p5=!=$result ,
    True,"Pipeline 5"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p6 = pipeall[$result,"C", "b.(i,j->j)", "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
    p6===<<MV62.ast || p6 =!= $result,
    True,"Pipeline 6"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p5 = pipeall[$result,{"C"}, "b.(i,j->j)", "BB.(i,j->i+1,j)"];
    p5===<<MV61.ast && p5=!=$result,
    True,"Pipeline 7"
  ]
,
  testFunction[
    p6 = pipeall[$result,{"C"}, "b.(i,j->j)", 
      "BB.(i,j->i+1,j)", "{i,j| i>=-1}"];
    p6===<<MV62.ast || p6 =!= $result,
    True,"Pipeline 9"
  ]
,
  testFunction[
    load["MV1.alpha"];
    p5 = pipeall[$result,"C", readExp["b.(i,j->j)",$result[[2]]], 
	     readExp["BB.(i,j->i+1,j)",$result[[2]]]];
    p5===<<MV61.ast && p5=!=$result,
    True,"Pipeline 10"
  ]
,
  testFunction[
    load["MV1.alpha"]; p1 = $result;
    pipeall["C",
      readExp["b.(i,j->j)",$result[[2]]],
      readExp["BB.(i,j->i+1,j)",$result[[2]]], 
      readDom["{i,j| i>=-1}",$result[[2]]]];
    p6 = $result;
    p6===<<MV62.ast || p6 =!= p1,
    True,"Pipeline 11"
  ]
,
  testFunction[
    prog2=<<1.ast;
    load["MV1.alpha"];prog1 = $result;
    p1 = First[Position[$result,readExp["b.(i,j->j)",{"N"}]]];
    Check[
      pipeline[p1,"B1.(i,j->i,j+1)"]; p2 = False,
      p2 = True
    ];
    p2,
    True,"Pipeline 12"
  ]
,
  testFunction[
    $result=<<1.ast;
    p1 = First[Position[$result,readExp["b.(i,j->j)",{"N"}]]];
    pipeline[p1,"B1.(i,j->i+1,j)"]; 
    nprog1=!=<<8.ast,
    True,"Pipeline 12.1"
  ]
,
  testFunction[
    prog2=<<2.ast;
    load["MV1.alpha"]; prog1 = $result;
    pipeall["C","b.(i,j->j)","B1.(i,j->i,j+1)"];
    prog1===$result,
    True,"Pipeline 13"
  ]
,
  testFunction[
    load["MV1.alpha"]; p1 = $result;
    pipeall["C","b.(i,j->j)","B1.(i,j->i+1,j)"];
    p1=!=$result,
    True,"Pipeline 14"
  ]
,
  testFunction[
    load["MV1P2.alpha"];
    pipeIO["c",readExp["C"],
      readExp["C2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | i <=N}"]];
    $result === <<4.ast,
    True,"Pipeline 15"
  ]
,
  testFunction[
    load["MV1P2.alpha"];
    pipeIO["c","C","C2.(i,j->i+1,j+1)","{i,j | i <=N}"];
    $result === <<4.ast,
    True, "Pipeline 16"
  ]
,
  testFunction[load["MV1P2.alpha"]; 
    pipeIO["c", "C", "C2.(i,j->i+1,j+1)", "{i,j | i <=N}"], << 
    Test18.ast, "Pipeline 17"]
,
  testFunction[load["MV1P1.alpha"]; 
    pipeIO[$result,"B1",readExp["b.(i,j,N->j,N)"],
    readExp["B2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | j >=0}"]],
    <<7.ast, "Pipeline 18"
  ]
,
  testFunction[
    pipeIO[$result,"B1",readExp["b.(i,j,N->j,N)"],
    readExp["B2.(i,j,N->i+1,j+1,N)"],readDom["{i,j,N | j >=0}"]],
    <<7.ast, "Pipeline 19"
  ]
,
  testFunction[
    load["MV1P1.alpha"];
    pipeIO[$result,"B1","b.(i,j->j)","B2.(i,j->i+1,j+1)","{i,j | j >=0}"],
    <<7.ast, "Pipeline 20"]
,
  testFunction[
    load["MV1P1.alpha"];
    pipeIO["B1","b.(i,j->j)","B2.(i,j->i+1,j+1)","{i,j | j >=0}"],
    <<7.ast, "Pipeline 21"]
,
  testFunction[load["MV1Sched.alpha"]; 
    pipeall["C", {6, 1, 2, 1, 2, 2, 3, 3}, 
    affine[var["pipeCb19"], 
      matrix[4, 
        4, {"t", "p", 
          "N"}, {{1, 0, 0, 0}, {0, 1, 0, 1}, {0, 0, 1, 0}, {0, 0, 0, 1}}]]], <<
     Test25.ast, "Pipeline 22"]
,
  testFunction[load["MV1Sched.alpha"]; 
    pipeall["C", {6, 1, 2, 1, 2, 2, 3, 3}, "pipeCb19.(t,p->t,p+1)"], << 
    Test25.ast, "Pipeline 23"]

};

$testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
