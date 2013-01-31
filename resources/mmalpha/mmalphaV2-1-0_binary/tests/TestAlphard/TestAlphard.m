Module[ {dir, res},

dir = Directory[];

SetDirectory[Environment["MMALPHA"]<>"/tests/TestAlphard"];
Print["testing getArrayDomains"];

res= 
{
  testFunction[
    load["MV6.alpha"];l1=getArrayDomains[],{{domain[2, {"p", "N"}, {pol[3, 2, 1, 0, {{0, 1, 0, -1}, {1, 0, 1, -2}, {1, 0, 0, 1}}, {{1, 0, 1, 0}, {1, 1, 2, 1}}]}], {{6, 2, 2}, {6, 5, 2}, {6, 1, 2, 1, 1}, {6, 3, 2, 1, 1}, {6, 4, 2, 1, 1}}}, {domain[2, {"p", "N"}, {pol[3, 3, 0, 0, {{1, -1, 1, 0}, {1, 1, 0, -2}, {1, 0, 0, 1}}, {{1, 0, 1, 0}, {1, 2, 2, 1}, {1, 1, 1, 0}}]}], {{6, 2, 2}, {6, 5, 2}, {6, 1, 2, 1, 2}, {6, 3, 2, 1, 1}, {6, 4, 2, 1, 2}}}},"Alphard 1"],

testFunction[showSpaceDom[l1],{Null,Null},"Alphard 2"],

testFunction[load["MV83.alpha"];getArrayDomains[],{{domain[1, {"j"}, {pol[2, 1, 1, 0, {{0, 1, -1}, {1, 0, 1}}, {{1, 1, 1}}]}], {{6, 2, 2}, {6, 5, 2}, {6, 6, 2}, {6, 7, 2}, {6, 8, 2}, {6, 9, 2}, {6, 10, 2}, {6, 14, 2}, {6, 1, 2, 1, 1}, {6, 1, 2, 1, 2}, {6, 4, 2, 1, 1}, {6, 11, 2, 1, 1}, {6, 13, 2, 1, 1}}}, {domain[1, {"j"}, {pol[2, 2, 0, 0, {{1, -1, 4}, {1, 1, -2}}, {{1, 4, 1}, {1, 2, 1}}]}],  {{6, 2, 2}, {6, 3, 2}, {6, 5, 2}, {6, 6, 2}, {6, 7, 2}, {6, 8, 2}, {6, 9, 2}, {6, 10, 2}, {6, 12, 2}, {6, 14, 2}, {6, 1, 2, 1, 1}, {6, 1, 2, 1, 2}, {6, 4, 2, 1, 2}, {6, 11, 2, 1, 1}, {6, 13, 2, 1, 2}}}}, "Alphard 3"],

testFunction[
  load["MV85.alpha"];s1=buildControler[{"initLoadCPipe"}];analyze[s1],True,"Alphard 4"],

testFunction[
  load["mouv2.alpha"];(* Attention: tres long *)(* getArrayDomains[]; *)s1=buildControler[{"loadut","loadvt"}];analyze[s1],True,"Alphard 5"],

testFunction[
  load["MV8.alpha"];d1=$result[[6,1,2]];isSpaceDepQ[d1],True,"Alphard 6"],

testFunction[
  load["MV8.alpha"];eq1=$result[[6,1]];isConnexionEqQ[$result,eq1],True,"Alphard 7"],

(* testing buildInterface  *)
testFunction[load["MV84.alpha"];buildInterface[];analyze[{recurse->True,scalarTypeCheck->False}],True,"Alphard 8"],

(* testing buildInterface  *)
testFunction[load["MV84.alpha"];ad=getArrayDomains[];d1=ad[[1,1]];p1=ad[[1,2]];d2=ad[[2,1]];p2=ad[[2,2]];s1=buildOneCell[d1,p1,{"initLoadCPipe"},{"loadCPipereg1","B1reg1","A"}, {"loadCPipe","B1","C"}]; analyze[s1,{recurse->True,scalarTypeCheck->False}], True, "Alphard 9"],

testFunction[load["MV84.alpha"];s2=buildOneCell[d2,p2,{"initLoadCPipe"},{"Bin","A"}, {"loadCPipe","B1","C"}]; analyze[s2,{recurse->True,scalarTypeCheck->False}], True, "Alphard 9.1"],

(* testing isMirrorQ *) 
testFunction[load["MV83.alpha"];buildInterface[];getSystem["prodVect"];isMirrorEqQ[$result[[6,1]]],True,"Alphard 10"],

testFunction[load["MV83.alpha"];isMirrorEqQ[$result[[6,2]]] ,True,"Alphard 11"],

(* This test is quite suspicious... I changed the result to False, which 
seems more reasonable *)
testFunction[load["MV83.alpha"];ashow[$result[[6,3]]];isMirrorEqQ[$result[[6,3]]],False,"Alphard 12"],

testFunction[load["MV83.alpha"];isMirrorEqQ[$result[[6,4]]],False,"Alphard 13"],
testFunction[load["MV83.alpha"];Print[" testing alpha0ToAlphardModule[]"];load["MV84.alpha"];buildInterface[];getSystem["prodVectModule"];ad1= getArrayDomains[];l1=alpha0ToAlphardModule[$result,ad1,{"initLoadCPipe"}];analyze[{recurse->True,scalarTypeCheck->False}],True,  "Alphard 14"],


testFunction[Print["testing alpha0ToAlphard[]"];load["MV84.alpha"];l1=alpha0ToAlphard[{"initLoadCPipe"}];analyze[{recurse->True,scalarTypeCheck->False}], True, "Alphard 15"],

(*
  This test cannot be done on any kind of environement... 
testFunction[load["exFlo4.alpha"];writeC["exFlo.c"];Run["cc exFlo.c -o exFlo"];Run["exFlo <data >results"];alpha0ToAlphard[{"C_ctl1_Init"}];inlineAll[];writeC["exFloHard.c"];Run["cc exFloHard.c -o exFloHard"];Run["exFloHard <data >newresults"];Run["diff results newresults"],0,"Alphard 16"],
*)

load["exFlo4.alpha"];
writeC[$tmpDirectory<>"/exFlo.c"];
Run["cc "<>$tmpDirectory<>"/exFlo.c -o "<>$tmpDirectory<>"/exFlo"];
Run[$tmpDirectory<>"/exFlo <data >"<>$tmpDirectory<>"/results"];
alpha0ToAlphard[{"C_ctl1_Init"}];
inlineAll[];
writeC[$tmpDirectory<>"/exFloHard.c"];
Run["cc "<>$tmpDirectory<>"/exFloHard.c -o "<>$tmpDirectory<>"/exFloHard"];
Run[$tmpDirectory<>"/exFloHard <data >"<>$tmpDirectory<>"/newresults"];
testFunction[Run["/usr/bin/diff "<>$tmpDirectory<>"/results "<>$tmpDirectory<>"/newresults"],1,"Alphard 16"],

(* DeleteFile[{"/tmp/exFloHard.c","/tmp/exFlo","/tmp/exFloHard","/tmp/exFlo.c",
		 "/tmp/results","/tmp/newresults"}];*)
(* Ne marche pas a cause de WriteC 
load["MV86.alpha"];
writeC["/tmp/MV.c"];
Run["cc /tmp/MV.c -o /tmp/MV"];
Run["/tmp/MV <dataMV >/tmp/resultsMV"]
alpha0ToAlphard[{"initLoadCPipe"}]
inlineAll[];
writeC["/tmp/MVHard.c"];
Run["cc /tmp/MVHard.c -o /tmp/MVHard"];
Run["/tmp/MVHard <dataMV >/tmp/newresultsMV"];
testFunction[Run["diff /tmp/resultsMV /tmp/newresultsMV"],0,"Alphard
	    17"], 

DeleteFile[{"/tmp/MVHard.c","/tmp/MV","/tmp/MVHard","/tmp/MV.c",
	    "/tmp/resultsMV","/tmp/newresultsMV"}]; *)

testFunction[load["bug2.a"];alpha0ToAlphard[{"Cin_Plus1_ctl1_Init","S_Plus1_ctl1_Init","BB_ctl1_Init"}];analyze[{recurse->True,scalarTypeCheck->False}], True,	     "Alphard 17"]

(* load["bug2.a"];
ad1=getArrayDomains[{"Cin_Plus1_ctl1_Init","S_Plus1_ctl1_Init","BB_ctl1_Init"}];
l1=alpha0ToAlphardModule[$result,
			 ad1,
			 {"Cin_Plus1_ctl1_Init","S_Plus1_ctl1_Init",
			  "BB_ctl1_Init"}]; *)
(* av[] *)


(* load["mult.alpha0v2"];
alpha0ToAlphard[{"Cin_Plus1_ctl1_Init","S_Plus1_ctl1_Init","BB_ctl1_Init"}];
testFunction[analyze[{recurse->True,scalarTypeCheck->False}],
	     True,
	     "Alphard 18"],
 asave["TimeLib.a"];
 assignParameterValue["W",16];
 assignParameterValueLib["W",16]; 

load["fir.alpha0v2"];
buildInterface[] ;
getSystem["firModule"];
ad1=getArrayDomains[{"Y_ctl1_Init", "xpipe_ctl2_Init", "xpipe_ctl1"}];
 buildControler[{"Y_ctl1_Init", "xpipe_ctl2_Init", "xpipe_ctl1"}] 
l1=alpha0ToAlphardModule[$result,
			 ad1,
			 {"Y_ctl1_Init", "xpipe_ctl2_Init",
			  "xpipe_ctl1"}];
testFunction[analyze[{recurse->True,scalarTypeCheck->False}],
	     True,
	     "Alphard 19"],

load["fir.alpha0v2"];
alpha0ToAlphard[{"Y_ctl1_Init", "xpipe_ctl2_Init", "xpipe_ctl1"}];
analyze[{recurse->True,scalarTypeCheck->False}];

av[]; 

testFunction[load["bug3.a"];l1=controlVars[];alpha0ToAlphard[l1];analyze[{recurse->True,scalarTypeCheck->False}], True, "Alphard 20"] *)
};

  res = Select[ res, #=!="*****"& ];

  If[ res === {}, 
      tests::testnf = "could not find this test";
      Message[ tests::testnf ]
  ];


testResult = Apply[And,res];

SetDirectory[dir];

If [testResult,
    Print["**** Test OK for Alphard.m "],
    Print["**** Something was wrong for Alphard.m"]];

testResult

]
