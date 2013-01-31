dir = Directory[]
SetDirectory[Environment["MMALPHA"]<>"/tests/TestUniformization/"];
Print["Test for Uniformization.m"];


res1= 
{
Print["-------------- Testing initUniformization --------------**"];
testFunction[load["arma.alpha"];
	     initUniformization[];
	     DomEqualQ[$depCone,
		       readDom["{i,j | (0,j)<=i}"]],
	     True,
	     "initUniformization 1"],
testFunction[Apply[And,MapThread[DomEqualQ, {$coneList,
Map[readDom,
{"{i,j | i=0; j<=0}",
"{i,j | i=0; j<=0}",
"{i,j | 0<=i; j=0}",
"{i,j | i=j; 0<=j}",
"{i,j | 0<=i; j=0}",
"{i,j | 0<=j; 7i-8j>=0}"}]}]],
	     True,
	     "initUniformization 1bis"],
testFunction[load["parma.alpha"];
	     initUniformization[];
	     DomEqualQ[$depCone,
		       readDom["{i,j,N,M | (j,0)<=i; N=0; M=0}"]],
	     True,
	     "initUniformization 2"],
testFunction[load["gj.alpha"];
	      Check[initUniformization[],True],
	     True,
	     "initUniformization 3"],
testFunction[load["multistepgj.alpha"];
	     initUniformization[];
	     DomEqualQ[$depCone,
		       readDom["{i,j,k,N | 0<=i; 0<=j; 0<=k; N=0}"]],
	     True,
	     "initUniformization 4"],
Print["-------------- Testing getDependencies --------------**"];
testFunction[load["multistepgj.alpha"];
	     getDependences[],
	     <<dep1,
	     "getDependencies 1"],
Print["-------------- Testing depCone --------------**"];
testFunction[d1=<<dep1;
	     DomEqualQ[depCone[d1[[1]]],
		       readDom["{i,j,k,N | i=0; 0<=j; 0<=k; N=0}"]],
	     True,
	     "depCone 1"],
Print["-------------- Testing getPipeVecs --------------**"];
testFunction[load["multistepgj.alpha"];
	     getPipeVecs[d1[[2]]]=== {{0, 1, 0, 0}, {1, 0, 0, 0}},
	     True,
	     "getpipeVecs 1"],
Print["-------------- Testing getRouteVecs --------------**"];
testFunction[getRouteVecs[d1[[4]]]===  {{-2 + "N", {1, 0, 0, 0}}, {1, {2, 0, 1, 0}}},
	     True,
	     "getRouteVecs 1"],
Print["-------------- Testing whichRule --------------**"];
testFunction[whichRule[d1[[1]]],
	     3,
	     "whichRule 1"],
Print["-------------- Testing pipeDep --------------**"];
testFunction[p1=pipeDep[$result,d1[[1]],getPipeVecs[d1[[1]]][[1]]];
	     Length[$result[[5]]]+1===Length[p1[[5]]],
	     True,
	     "pipeDep 1"],
Print["-------------- Testing uniformize --------------**"];
testFunction[load["arma.alpha"];
	    Print["testing on arma please wait ..."];
	     Do[Map[uniformize[#]&,getDependences[]];
		Print["Pass number ",i," finished "],
		{i,1,3}];
	     uniformQ[$result],
	     True,
	     "unifomize 1"],
Print["-------------- Testing uniformize --------------**"];
testFunction[load["parma.alpha"];
	    Print["testing on parma please wait ..."];
	     Do[Map[uniformize[#]&,getDependences[]];
		Print["Pass number ",i," finished "],
		{i,1,3}];
	     uniformQ[$result],
	     True,
	     "unifomize 2"],
testFunction[load["multistepgj.alpha"];
	     Print["testing on multistepgj  please wait ..."];
	     initUniformization[];
	     dd = getDependences[$result];
	     i=1;
	     While[dd=!={},
		   Print["Uniformizing number ",i];
		   show[dtable[{dd[[1]]}]];
		   (* lin(D) and Null(A) *)
		     verboseInfo[dd[[1]]];
		   uniformize[dd[[1]]];
		   normalize[];
		   convexizeAll[];
		   dd = getDependences[$result];
		   i=i+1];
	     uniformQ[$result],
	     True,
	     "uniformize 3"],
Print["-------------- Testing callUniformize --------------**"];
callUniformize["arma.alpha"];
testFunction[uniformQ[load["arma.alpha.URE.new"][[1]]],
	     True,
	     "callUniformize 1"]
}

testResult = Apply[And,res1] 

SetDirectory[dir];

If [testResult,
    Print["**** Test OK for Uniformization.m "],
    Print["**** Something was wrong for Uniformization.m"]];

testResult

