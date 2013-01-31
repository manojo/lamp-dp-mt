testSchedir=Directory[];
SetDirectory[Environment["MMALPHA"]<>"/tests/TestNewSchedule/"];


Print["Rapid (~3mn) and automatic Test for the scheduler"];
finalResultHere=True;
Print["testing on Matrix Matrix product, please wait..."];
load["MMunif.alpha"]
schedule[verbose->False];
sched1 = scheduleResult[1, {{"a", {"i", "j", "N"}, sched[{0, 0, 0}, 0]}, 
    {"b", {"i", "j", "N"}, sched[{0, 0, 0}, 0]}, 
    {"c", {"i", "j", "N"}, sched[{0, 0, 2}, 1]}, 
    {"B", {"i", "j", "k", "N"}, sched[{1, 0, 0, 0}, 0]}, 
    {"A", {"i", "j", "k", "N"}, sched[{0, 1, 0, 0}, 0]}, 
    {"C", {"i", "j", "k", "N"}, sched[{0, 0, 1, 1}, 0]}}, {2, 1}]
If[testSched[],
 Print["OK"],
 Print["Problem with MMunif.alpha"];
 showSchedResult[$schedule];Print["should be "];showSchedResult[sched1];
 finalResultHere=False]


Print["Testing the addition of constraints"]
load["Test2.alpha"];
sched2= scheduleResult[1, {{"a", {"i", "k"}, sched[{2, 2}, -4]}, 
    {"b", {"j"}, sched[{0}, 0]}, {"c", {"i"}, sched[{0}, 15]}, 
    {"A", {"i", "k"}, sched[{2, 2}, -3]}, 
    {"C", {"i", "k"}, sched[{2, 2}, -2]}}, {15}]
schedule[verbose->False,addConstraints->
{"TaD1==2","TaD2==2","TCD1+TCD2>=4"}]
Print[testSched[]];
If [testSched[],
 Print["OK"],
 showSchedResult[$schedule];Print["should be "];showSchedResult[sched2];
 finalResultHere=False;
Print["Problem with added constraints on MMunif.alpha"]]

Print["Testing on non computable system"]
testWrong=load["TestWrong.alpha"];
schedule1=schedule[verbose->False];
If [schedule1===$Failed,Print["OK"],finalResultHere=False;
Print["Problem with TestWrong.alpha"]];

If[finalResultHere,Print["\n\n The rapid test of the scheduler is OK \n\n"],
Print["\n\n There was some problem during rapid test, please check\n\n"]]


SetDirectory[dir];
finalResultHere
