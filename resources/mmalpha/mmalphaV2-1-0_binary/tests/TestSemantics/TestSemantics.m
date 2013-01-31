dir = Directory[]
SetDirectory[Environment["MMALPHA"]<>"/tests/TestSemantics/"];
Print["Test for Semantics.m, WARNING allmost nothing is tested here"];

res1= 
{
Print["Testing replaceByEquivExpr"];
testFunction[load["app98_merge.alpha"];
	     replaceByEquivExpr[$result,{6,1,2,1,6,2,2},"F.(i,j,k->i+1,1,k-1)"],<<"RTest1","replaceByEquivExpr 1"],
testFunction[replaceByEquivExpr[{6,1,2,1,6,2,2},"F.(i,j,k->i+1,1,k-1)"],<<"RTest1","replaceByEquivExpr 2"],
testFunction[load["app98_merge.alpha"];
	     replaceByEquivExpr[$result,"F.(i,j,k->i+1,j-N+1,k-1)","F.(i,j,k->i+1,1,k-1)"],<<"RTest2","replaceByEquivExpr 3"],
testFunction[load["app98_merge.alpha"];
	     replaceByEquivExpr["F.(i,j,k->i+1,j-N+1,k-1)","F.(i,j,k->i+1,1,k-1)"];$result,<<"RTest2","replaceByEquivExpr 4"],
testFunction[dom1=expDomain["F"];
	     DomEqualQ[dom1,
	       readDom["{i,j,k,N | 1<=i<=N; 1<=j<=N; 0<=k<=N; 10<=N}"]],
	     True,"expDomain 1"],
testFunction[dom1=expDomain[ Alpha`const[0]];
	     DomEqualQ[dom1,
		     DomUniverse[0]],
	     True,"expDomain 2"],
(* testFunction[exp1=index[matrix[3,3,{"j","N"},{{1,0,0},{0,1,0},{0,0,1}}]];
	     DomEqualQ[expDomain[exp1],
	       readDom["{j,N | 10<=N}"]],
		True,"expDomain 3"], *)
testFunction[exp1= binop[add, affine[var["F"], matrix[5, 5, {"i", "j", "k", "N"}, 
     {{1, 0, 0, 0, 0}, {0, 0, 0, 0, 1}, {0, 0, 1, 0, 0}, {0, 0, 0, 1, 0}, 
      {0, 0, 0, 0, 1}}]], affine[var["F"], 
    matrix[5, 5, {"i", "j", "k", "N"}, 
     {{0, 0, 0, 0, 2}, {0, 1, 0, 0, 1}, {0, 0, 1, 0, -1}, {0, 0, 0, 1, 0}, 
      {0, 0, 0, 0, 1}}]]];
	     DomEqualQ[expDomain[exp1],
	       readDom["{i,j,k,N | 1<=i<=N; 0<=j<=N-1; 1<=k<=N; 10<=N}"]],
	     True,"expDomain 4"],
Print["expDomain noit tested on Calls, unop, if, reduce"];
testFunction[dom1=expDomain[ affine[var["A"], matrix[4, 5, {"i", "j", "k", "N"}, 
    {{1, 0, 0, 0, -1}, {0, 1, 0, 0, -1}, {0, 0, 0, 1, 0}, {0, 0, 0, 0, 1}}]]];
	     DomEqualQ[dom1,
		     readDom["{i,j,k,N | 2<=i<=N+1; 2<=j<=N+1; 10<=N}"]],
	     True,"expDomain 5"],
testFunction[dom1=expDomain[restrict[domain[4, {"i", "j", "k", "N"}, 
    {pol[6, 5, 1, 0, {{0, 0, 0, 1, 0, 0}, {1, 1, 0, 0, 0, -2}, 
       {1, -1, 0, 0, 1, 0}, {1, 0, 1, 0, 0, -2}, {1, 0, -1, 0, 1, 0}, 
       {1, 0, 0, 0, 0, 1}}, {{1, 0, 1, 0, 1, 0}, {1, 2, 2, 0, 2, 1}, 
       {1, 0, 0, 0, 1, 0}, {1, 1, 0, 0, 1, 0}, {1, 1, 1, 0, 1, 0}}]}], 
   affine[var["A"], matrix[4, 5, {"i", "j", "k", "N"}, 
     {{1, 0, 0, 0, -1}, {0, 1, 0, 0, -1}, {0, 0, 0, 1, 0}, 
      {0, 0, 0, 0, 1}}]]]];
	     DomEqualQ[dom1,
		     readDom["{i,j,k,N | 2<=i<=N; 2<=j<=N; k=0; 10<=N}"]],
	     True,"expDomain 6"],
testFunction[dom1=expDomain[ case[{restrict[domain[3, {"i", "j", "N"}, 
      {pol[5, 5, 0, 0, {{1, 1, 0, 0, -1}, {1, -1, 0, 1, -1}, 
         {1, 0, 1, 0, -1}, {1, 0, -1, 1, -1}, {1, 0, 0, 0, 1}}, 
        {{1, 1, 1, 2, 1}, {1, 0, 0, 1, 0}, {1, 1, 0, 1, 0}, 
         {1, 1, 1, 1, 0}, {1, 0, 1, 1, 0}}]}], 
     affine[var["F"], matrix[5, 4, {"i", "j", "N"}, 
       {{1, 0, 0, 1}, {0, 1, 0, 1}, {0, 0, 1, 0}, {0, 0, 1, 0}, 
        {0, 0, 0, 1}}]]], restrict[domain[3, {"i", "j", "N"}, 
      {pol[4, 3, 1, 0, {{0, 0, 1, -1, 0}, {1, 1, 0, 0, -1}, 
         {1, -1, 0, 1, -1}, {1, 0, 0, 0, 1}}, 
        {{1, 1, 2, 2, 1}, {1, 0, 1, 1, 0}, {1, 1, 1, 1, 0}}]}], 
     affine[var["F"], matrix[5, 4, {"i", "j", "N"}, 
       {{1, 0, 0, 1}, {0, 1, -1, 1}, {0, 0, 1, 0}, {0, 0, 1, 0}, 
        {0, 0, 0, 1}}]]], restrict[domain[3, {"i", "j", "N"}, 
      {pol[4, 3, 1, 0, {{0, 1, 0, -1, 0}, {1, 0, 1, 0, -1}, 
         {1, 0, -1, 1, -1}, {1, 0, 0, 0, 1}}, 
        {{1, 1, 0, 1, 0}, {1, 1, 1, 1, 0}, {1, 2, 1, 2, 1}}]}], 
     affine[var["F"], matrix[5, 4, {"i", "j", "N"}, 
       {{1, 0, -1, 1}, {0, 1, 0, 1}, {0, 0, 1, 0}, {0, 0, 1, 0}, 
        {0, 0, 0, 1}}]]], restrict[domain[3, {"i", "j", "N"}, 
      {pol[4, 2, 2, 0, {{0, 1, 0, -1, 0}, {0, 0, 1, -1, 0}, 
         {1, 0, 0, 1, -1}, {1, 0, 0, 0, 1}}, 
        {{1, 1, 1, 1, 0}, {1, 1, 1, 1, 1}}]}], 
     affine[var["F"], matrix[5, 4, {"i", "j", "N"}, 
       {{1, 0, -1, 1}, {0, 1, -1, 1}, {0, 0, 1, 0}, {0, 0, 1, 0}, 
        {0, 0, 0, 1}}]]]}]];
	     DomEqualQ[dom1,
		     readDom["{i,j,N | 1<=i<=N-1; 1<=j<=N-1; 10<=N} | {i,j,N | 1<=i<=N-1; j=N; 10<=N} |
 {i,j,N | i=N; 1<=j<=N-1; 10<=N} | {i,j,N | i=N; j=N; 10<=N}"]],
	     True,"expDomain 7"],
load["app98_merge.alpha"];
testFunction[DomEqualQ[getContextDomain[$result,{6,2,1}],
		       readDom["{i,j,N | 1<=i<=N; 1<=j<=N; 10<=N}"]],
	     True,
	     "getContexDomain 1"],
(* load["Gauss.alpha"];
testFunction[DomEqualQ[getContextDomain[$result,{6, 1, 4, 1}],
		       readDom["{i,j,k,N | 1<=i<=N; 1<=j<=N; 1<=k<=N}"]],
	     True,
	     "getContexDomain 2"],*)


	load["decimation.alpha"];
	normalize[];
	
	Print["test of getContextDomain"];
	testFunction[
		DomEqualQ[getContextDomain[{6,2,2,1,2,2,3,2,1,1}],readDom["{j,N | 0<=j<=N-2}"]],
		True,
		"ZSemantics getCtxtDom1"
		],

	Print["test of expType"];
	testFunction[
		expType[{6,2,2,1,2,2,3,2,1,1}],
		real,
		"ZSemantics expType1"
                ],

	Print["test of expDimension"];
	testFunction[
		expDimension[{6,2,2,1,2,2,3,2,1,1}],
		2,
		"ZSemantics expDimension1"
		],

	Print["test of expDomain"];
	testFunction[
		DomEqualQ[expDomain[{6,2,2,1,2,2}],readDom["{3i,j,N | -j<=i; 0<=j<=N-2}"]],
		True,
		"ZSemantics expDomain1"
		],

	Print["test of replaceByEquivExpr"];
	testFunction[
		replaceByEquivExpr["X.(i,j->i,j)","X.(i,j->i/3,3j)"],
		<<ZAST1,
		"ZSemantics replaceByEquivExpr"
		]

}

testResult = Apply[And,res1] 

SetDirectory[dir];

If [testResult,
    Print["**** Test OK for Semantics.m "],
    Print["**** Something was wrong for Semantics.m"]];

testResult
