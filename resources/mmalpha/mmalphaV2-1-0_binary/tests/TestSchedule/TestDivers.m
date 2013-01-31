res=True;

Print["Testing affine functions"]
testAffine2=load["TestAffine2.alpha"][[1]];
(* ashow[testAffine2]; *)
sched1=schedule[];
If [testSched[testAffine2,sched1],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : Last result should be:"];
    Print["Last result should be(not checked):"];
    Print["T_a{i, k, N} = 0\n
T_b{j, N} = 0\n
T_c{i, N} = N\n
T_A{i, k, N} = i\n
T_B{i, j, N} = -1 + i\n
T_C{k, i, N} = -1 + i\n"]];



Print["Testing union of prolyhedra"];
testUnion=load["TestUnion.alpha"][[1]];
(* ashow[testUnion]; *)
sched1=schedule[ratOrInt->0];
If [testSched[testUnion,sched1],
 Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : Last result should be (not checked):"];
    Print["T_x{i} = 0\n
T_w{p} = 0\n
T_y{i} = 0\n
              4\n
T_Y{t, p} = -(-) + t\n
              3\n"]];

Print["Testing non computable program"];
testWrong=load["TestWrong.alpha"];
(* ashow[testWrong]; *)
If [schedule[]=!= $Failed, 
    Print["Problem with TestWrong.alpha"],
    Print["OK"]];

Print["Testing Unbounded Time program"];
testUnbounded=load["TestUnbounded.alpha"];
(* ashow[]; *)
res1=schedule[];
If [(res1=!=$Failed) && (res1=!=$Null) (* Problem, $Failed is not returned sometimes *), 
    Print["Problem with TestUnbounded.alpha"],
    Print["OK"]];
  
Print["But If you do not specify an objective function:"];
sched1=schedule[optimizationType->Null];
If [testSched[sched1],
    Print["OK"]; res=res&&True,
    res=res&& False;
    Print["Problem : Last result should be (not checked):"];
    Print[" T_x{i} = 0 \n
T_w{p} = 0\n 
T_y{i} = 2 + i\n
T_X{i} = 1+i\n
"]];

res



