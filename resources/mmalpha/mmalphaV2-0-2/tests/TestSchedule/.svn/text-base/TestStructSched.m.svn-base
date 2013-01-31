res=True;

Print["***Testing Structured scheduling"]
load["MatMat.alpha"];
getSystem["MatVect"];
If [testSched[schedule[]],
      Print["OK"];res=res && True,
    res=res && False;
    Print["***************Error structSched 1"]];

getSystem["MatMat"];
If [testSched[structSched[]],
      Print["OK"];res=res && True,
    res=res && False;
    Print["***************Error structSched 2"]];

structSched[structSchedType->multi,multiSchedDepth->2];
If [testSched[$schedule]&& Length[$schedule[[2,1]]>3],
      Print["OK"];res=res && True,
    res=res && False;
    Print["***************Error structSched 3"]];

(*
load["Kalman.alpha"];
Map[schedule[#,verbose->False] &, Drop[$library,-1]];
addBufferVarsForUse[$result[[6,1]]];
ashow[];
addBufferVarsForUse[$result[[6,5]]];
addBufferVarsForUse[$result[[6,-1]]
];
If[ testSched[structSched[] ],
  Print["OK"];res=res && True,
  res=res && False;
  Print["***************Error structSched 4"]];
*)
res
