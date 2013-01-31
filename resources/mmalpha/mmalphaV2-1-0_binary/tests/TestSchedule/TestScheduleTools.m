res=True;

Print["Testing appSched "]
testAS1=load["MMunif.alpha"][[1]];
(* Ashow[testAffine2]; *)
sched1=schedule[testAS1];
AS2=appSched[testAS1,sched1];
If [AS2=!=testAS1,
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : appSched not performed "];
];

Print["Testing isScheduledQ "]
If [!isScheduledQ[AS2],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : program  should not be considered as  Scheduled after appSched (because of I/O)   "];
];

If [isScheduledQ[AS2,onlyLocalVars->True],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : program  should  be considered as  Scheduled after appSched (options onlyLocalVars)   "];
];

If [!isScheduledQ[testAS1],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : isScheduledQ corrupted (MMunif is not scheduled) "];
];

Print["Testing appSched with projVector and projMatrix options "];
sched2=schedule[testAS1,scheduleType->sameLinearPart];
Check[AS3=appSched[testAS1,sched2,projVector->{0,1,0,0}];
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : projVector options of appSched "];
];

Check[AS3=appSched[testAS1,sched2,projMatrix -> {{0, 0, 1, 0}, {0, 1, 0, 0}, {0, 0, 0, 1}}];
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : projMatrix options of appSched "];
];

Print["Testing equationOrderQ and reorder equation "]
dlms0=load["DLMS_Alpha0.alpha"][[1]];
addAllParameterDomain[];
If [isScheduledQ[onlyLocalVars -> True, durations -> 0, verbose -> True],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : isScheduleQ corrupted   "];
];
Print["known bug : equationOrderQ corrupted   "];
(*permut = equationOrderQ[checkSched -> False]
If [MatchQ[permut,List[__Integer]],
	  Print["OK"]; res=res&&True,
	  res=res&& False;
	  Print["Problem : equationOrderQ corrupted   "];
];*)
Print["known bug : reorderEquations corrupted   "];
(*
Newsys = reorderEquations[dlms0, permut];
If[dlms0[[6,permut[[1]]]]===newSys[[6,1]],
  Print["OK"]; res=res&&True,
  res=res&& False;
  Print["Problem : reorderEquations corrupted   "];
];*)
	  

Print["Testing rename Indices "]
testAS1=load["MMunif.alpha"][[1]];
newSys=renameIndices[$result,{"t1","t2","p3"}];
If [MatchQ[newSys,system[___]] && Take[newSys[[5,1,3,2]],3]==={"t1","t2","p3"},
  Print["OK"]; res=res&&True,
  res=res&& False;
  Print["Problem : renameIndices corrupted   "];
];

testAS1=load["PIC3Unif3.alpha"][[-1]];
newSys=renameIndices[$result,{"t1","t2","p3","p5"}];
  If [Length[newSys[[5]]]===14,
		Print["OK"]; res=res&&True,
		res=res&& False;
		Print["Problem : renameIndices  corrupted   "];
      ]; 

newSys=renameIndices[testAS1,{"t1","t2","p3","p5"},recurse->True];
   If [Length[newSys[[5]]]===13 &&  Take[newSys[[5,1,3,2]],4]==={"t1","t2","p3","p5"} &&  Take[$library[[-2,3,1,3,2]],2]==={"t1","t2"},
		Print["OK"]; res=res&&True,
		res=res&& False;
		Print["Problem : renameIndices  corrupted   "];
      ]; 

  res



