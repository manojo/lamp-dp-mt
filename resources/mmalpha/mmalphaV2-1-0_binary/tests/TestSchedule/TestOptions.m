Module[ {res,res1,sched1,testD,testobj},
  res=True;

  Print["***Debug option"];
  test1=load["Test1.alpha"][[1]];
  (* ashow[test1]; *)
  If[ testSched[test1,schedule[test1,debug->True]],
    Print["OK"];res=res && True,
    res=res && False;
    TestOptions::error = "Error during test of Options";
    Message[ TestOptions::error ];
    Print["Warning, Last result should be \n T_c{i, j, N, M, P} = 0"]
  ];


  Print["\n***verbose (False) on the same program"];
  If[ testSched[test1,schedule[test1,verbose->False]],
    Print["OK"];res=res && True,
    res=res && False;
    Message[ TestOptions::error ];
    Print["Last result should be \n scheduleResult[1, {{c, {i, j, N, M, P}, 	        sched[{0, 0, 0, 0, 0}, 0]}}]"]
    ];
    
  Print["\n***default value for $result"];
  If[ testSched[schedule[]],
    Print["OK"];res=res && True,
    res=res && False; 
    Message[ TestOptions::error ];
    Print["Warning, Last result should be \n T_c{i, j, N, M, P} = 0"]
  ];

  Print["\n***scheduleType option"];
  testscheduleType=load["TestSchedType.alpha"][[1]];
  (* ashow[]; *)

  Print["affine by variable"];
  sched1=schedule[testscheduleType,scheduleType->affineByVar];
  If[ testSched[]&&(sched1[[2,2,3,1]]=!=sched1[[2,3,3,1]]),
    Print["OK"];res=res && True,
    res=res && False;  
    Message[ TestOptions::error ];
    Print["Last result should be: \n
    T_a{k, N} = 0\n
    T_A1{k, N} = 1+k\n
    T_A2{i, N} = 3 + i\n
    T_b{i, N} = 4 + i"]
  ];

  Print["affine of unique linear Part"];
  sched1=schedule[testscheduleType,scheduleType->sameLinearPart];
  If[ testSched[]&&(sched1[[2,2,3,1]]===sched1[[2,3,3,1]]),
    Print["OK"];res=res && True,
    res=res && False;      Message[ TestOptions::error ];
    Print["Last result should be: \n
    T_a{k, N} = 0\n
    T_A1{k, N} = 1+k\n
    T_A2{i, N} = 3 + i\n
    T_b{i, N} = 4 + i"]
  ];

  Print["affine of unique linear part except on parameters "];
  testscheduleType2=load["TestSchedType2.alpha"][[1]];
  sched1=schedule[testscheduleType2,scheduleType->sameLinearPartExceptParam];
  If[ testSched[]&&(sched1[[2,3,3,1]]=!=sched1[[2,4,3,1]])&&
    (sched1[[2,2,3,1]]===sched1[[2,3,3,1]]),
    Print["OK"];res=res && True,
    res=res && False;      Message[ TestOptions::error ];
    Print["Last result should be: \n
    T_a{k, N} = 0\n
    T_b{j, N} = 4 + j\n
    T_A1{i, N} = 1 + i\n
    T_A2{i, N} = 3 + i\n
    "]
  ];

  Print["\n** optimizationType option"];
  testobj=load["TestUnbounded.alpha"][[1]];
  Print["No objectibve function on unbounded time"];
  If[ testSched[schedule[testobj,optimizationType->Null]],
    Print["OK"];res=res && True,
    res=res && False;      Message[ TestOptions::error ];
    Print["Last result should be:"];
    Print["T_x{i} = 0\n
T_w{p} = 0\n
T_X{i} = 2 + i\n
T_y{i} = 1 + i\n"]];

	Print["And Failing if the total time is minimized"];
	res1=schedule[testobj,optimizationType->time];
If[(res1=!=$Failed) && (res1=!=$Null) (* Problem, $Failed is not returned sometimes *),
    res=res && False;Print["Probleme with TestUnbounded "],
 Print["OK"];res=res && True];

Print["\n***Testing Rationnal resolution for Pip"];
load["TestRat.alpha"];
(* ashow[]; *)
	Print["First in Rationnal"];
If[MatchQ[schedule[integerSolution->False],scheduleResult["test6", {{"A1", {"j", "N"}, sched[{1/3, 0}, 0]}, 
    {"A2", {"j", "N"}, sched[{1/3, 0}, 2/3]}}, {0, 0}]],
   Print["OK"];res=res && True,
   res=res && False;      Message[ TestOptions::error ];
   Print["Last result should be:"];
   Print["\n
             j\n
T_A1{j, N} = -\n
             3\n
             2   j\n
T_A2{j, N} = - + -\n
             3   3\n"]
    ];

  Print["Then in integer"];
  If[ testSched[schedule[integerSolution->True]],
       Print["OK"];res=res && True,
    res=res && False;      Message[ TestOptions::error ];
    Print["Last result should be:"];
    Print["
T_A1{j, N} = j\n
T_A2{j, N} = j\n"]];



	Print["\n***Testing added constraints"];
load["MMunif.alpha"];
sched1=schedule[addConstraints->{"TaD1==2","TaD2==3","TaD3>=3",
"Ca>=5","TCD1+TCD2+TAD1>=10","Tc[i1,j,N]=10N+3i1+4"}];
If [sched1===scheduleResult["prodVect", {{"a", {"i", "j", "N"}, sched[{2, 3, 3}, 5]}, 
    {"b", {"i", "j", "N"}, sched[{0, 0, 0}, 0]}, 
    {"c", {"i", "j", "N"}, sched[{3, 0, 10}, 4]}, 
    {"B", {"i", "j", "k", "N"}, sched[{1, 0, 0, 0}, 0]}, 
    {"A", {"i", "j", "k", "N"}, sched[{3, 1, 3, 3}, 4]}, 
    {"C", {"i", "j", "k", "N"}, sched[{6, 1, 3, 3}, 2]}}, {13, 4}],
    Print["OK"];res=res && True,
    res=res && False;
Print["Result should be:"];
Print["T_a{i, j, N} = 5 + 2 i + 3 j + 3 N\n
T_b{i, j, N} = 0\n
T_c{i, j, N} =4 + 3 i + 10 N\n
T_B{i, j, k, N} = i \n
T_A{i, j, k, N} = 4 + 3 i +  j + 3 k + 3 N\n
T_C{i, j, k, N} = 2 + 6 i +  j + 3 k + 3 N\n
"]];

Print["Testing durations Options"];
testD=load["TestDuration.alpha"][[1]];
If [testSched[testD,schedule[durations->{}]],
   Print["OK"];res=res && True,
    res=res && False;
Print["Last result should be : \n
T_b{i, j, N} = 0\n
T_B{i, j, k, N} = 1\n
T_A{i, j, k, N} = 2\n
T_C{i, j, k, N} = 2 + k\n
T_c{i, j, N} = 3 + j\n
"]];

If [testSched[testD,schedule[durations->{1,2,3,10,100,1000}]],
    Print["OK"];res=res && True,
    res=res && False;    
    Message[ TestOptions::error ];
    Print["Last result should be : \n
    T_b{i, j, N} = 0\n
    T_B{i, j, k, N} = 1\n
    T_A{i, j, k, N} = 2\n
    T_C{i, j, k, N} = 2 + k\n
    T_c{i, j, N} = 3 + j\n
  "]
  ];

  If[ testSched[testD,schedule[duration->{1,2,3,10,100,1000}]],
     Print["OK"];res=res && True,
     res=res && False;    Message[ TestOptions::error ];
     Print["Last result should be : \n
  T_a{i, j, N} = 0\n
  T_b{i, j, N} = 0\n
  T_c{i, j, N} = 113 + 1000 j\n
  T_B{i, j, k, N} = 10\n
  T_A{i, j, k, N} = 110\n
  T_C{i, j, k, N} = 110 + 1000 k\n
  \n"];
  Print["This should be corrected"]
  ];


  If [ testSched[testD,schedule[durations->{1,2,3,5,10,100}]],
       Print["OK"];res=res && True,
     res=res && False;
Print["Last result should be \n 
T_a{i, j, N} = 0\n
T_b{i, j, N} = 0\n
T_c{i, j, N} = 18 + 100 j\n
T_B{i, j, k, N} = 5\n
T_A{i, j, k, N} = 15\n
T_C{i, j, k, N} = 15 + 100 k\n"]];

	Print["*** outputForm option"];
test1=load["Test1.alpha"][[1]];
(* ashow[test1]; *)
If [MatchQ[schedule[test1,outputForm->domain], Alpha`domain[___]],
     Print["OK"];res=res && True,
    res=res && False;
    Print["Warning, The outputForm->domain does not work"]];

  If[ MatchQ[schedule[test1,outputForm->lpSolve], Alpha`lpProg[___]],
    Print["OK"];res=res && True,
    res=res && False;    Message[ TestOptions::error ];
    Print["Warning, The outputForm->lpSolve does not work"]];

res
]
