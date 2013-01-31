res=True

Print["Test1:3 parameter does nothing"];
load["Test1.alpha"];
test1=$result;
(* ashow[]; *)
sched1=schedule[test1];
If [testSched[test1,sched1],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : Last result should be:"];
Print["T_c{i, j, N, M, P} = 0\n"]];


Print["Test2: No parameter,  matrix product"];
test2=load["Test2.alpha"][[1]];
(* ashow[]; *)
sched1=schedule[test2]
If [testSched[test2,sched1] ,
    Print["OK"];res=res&&True,
    res=res&& False;
    Print["Problem: Last result should be:"];
Print["T_a{i, k} = 0\n
T_b{j} = 0\n
T_c{i} = 6\n
T_A{i, k} = 1\n
T_C{i, k} = 1+k\n
"]]

Print["Test3: assignement of a vector, 1 parameter "]
test3=load["Test3.alpha"][[1]];
(* ashow[]; *)
sched1= schedule[test3];
If [testSched[test3,sched1],
    Print["OK"];res=res&&True,
    res=res&& False;
    Print["Problem: Last result should be:"];
    Print["T_v{i, N} = i\n"]]

Print["Test4: Testing schedule Type 0"];
test4=load["TestscheduleType.alpha"][[1]];
(* ashow[]; *)
sched1=schedule[test4,scheduleType->sameLinearPart]
If [testSched[test4,sched1],
    Print["OK"];res=res&&True,
    res=res&& False;
    Print["Problem: Last result should be:"];
    Print["T_a{k, N} = 0\n
T_b{j, N} = 4 + j\n
T_A1{i, N} = 1 + i\n
T_A2{i, N} = 3 + i\n"]]


res
