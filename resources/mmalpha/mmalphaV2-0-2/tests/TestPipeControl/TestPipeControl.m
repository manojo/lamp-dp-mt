BeginPackage["Alpha`TestPipeControl`",
  {"Alpha`","Alpha`Domlib`","Alpha`PipeControl`","Alpha`Pipeline`",
  "Alpha`Static`"}];

Begin["`Private`"]

Module[
  {res,aaa,bbb,ccc,p1,p2,i,ii,ji,kk,j,k,finalRes},

res = 
{
  testFunction[
    const2al[{ii,ji,kk},
    Alpha`ge[2ii+kk,2]],{1,2,0,1,-2},
    "PipeControl 1"]
,
  testFunction[
    const2mma[{i,j,k},{0, 2, 0, 1, -2}],
    List[List[i, j, k],Equal[Plus[Times[2, i], k],2]],
    "PipeControl 2"
  ]
,
  testFunction[
    const2mma[{"i","j","k"},{0, 2, 0, 1, -2}],
    List[List[Alpha`Work`i, Alpha`Work`j, Alpha`Work`k],
      Equal[Plus[Times[2, Alpha`Work`i], Alpha`Work`k],2]],
    "PipeControl 3"
  ]
,
  testFunction[dom2mma["{i,j,k|i=2;j>=k+2i}"],
    {{Alpha`Work`i==2,Alpha`Work`j-Alpha`Work`k>=4},{Alpha`Work`i,Alpha`Work`j,
    Alpha`Work`k}},
    "PipeControl 4"]
,
  testFunction[dom2al[dom2mma["{i,j,k|i=2;j>=k+2i}"]],
    readDom["{i, j, k|i = 2;j - k>= 4}"],"PipeControl 5"]
,
  testFunction[
    aaa = readDom["{i,j,k|i=2;j>=k+2i}"];
    ccc = domExplode[aaa];
    ccc,{readDom["{i, j, k|i = 2}"], 
    readDom["{i, j, k|(j - k) >= 4}"]},"PipeControl 6"]
,
  testFunction[domHalfSpaceQ[readDom["{i,j|i+j>=2}"]],True,
    "PipeControl 7"]
,
  testFunction[domHalfSpaceQ[readDom["{i,j|i+j>=2;i=3}"]],False,
  "PipeControl 8"]
,
  testFunction[domHalfSpaceQ[v],False,"PipeControl 9"]
,
  testFunction[domHalfSpaceQ[readDom["{i,j|i>=2;i>=0}"]],True,
  "PipeControl 10"]
,
  testFunction[findSepHalfSpace["case {i|i=1}:A;{i|i>=2}:B; esac"],
    {readDom["{i|i>=2}"]},
    "PipeControl 11"]
,
  testFunction[
    aaa = findSepHalfSpace["case {i|i<=1;i>=-4}:A;{i|i>=2}:B;esac"];
    aaa[[1]],readDom["{i|i<=1}"],
  "PipeControl 12"]
,
  testFunction[
    load["MV6.alpha"];
    ccc = findPipeControl["loadC"];
    ccc,{readDom["{t,p|p<=t}"]},
    "PipeControl 13"]
,
  testFunction[findPipeControl["B1"],{},
    "PipeControl 14"]
,
  load["MV7.alpha"];
  testFunction[findPipeControl["loadC"],{},
    "PipeControl 15"]
,
  testFunction[
    load["MV6.alpha"];
    p1 = pipeall["loadC",
      "case  {t,p | t=p-1; 0<=p<=3} : True.(t,p->);  {t,p | p<=t<=p+3; 0<=p<=3} : False.(t,p->); esac","loadCP.(t,p->t+1,p+1)"];
    analyze[p1,scalarTypeCheck->False],True,
    "PipeControl 16"]
,
  testFunction[
    load["MV6.alpha"];
    p2=pipeControl["loadC"];
    analyze[p2,scalarTypeCheck->False],True,
    "PipeControl 17"]
};

finalRes=Apply[And,res]

];

End[];

EndPackage[];
