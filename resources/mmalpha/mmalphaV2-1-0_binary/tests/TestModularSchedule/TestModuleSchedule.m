dir = Directory[]
SetDirectory[Environment["MMALPHA"]<>"/tests/TestModularSchedule/"];
Print["Test for ModularSchedule.m"];


res1= 
{


}

testResult = Apply[And,res1] 

SetDirectory[dir];

If [testResult,
    Print["**** Test OK for ModularSchedule.m "],
    Print["**** Something was wrong for ModularSchedule.m"]];

testResult

