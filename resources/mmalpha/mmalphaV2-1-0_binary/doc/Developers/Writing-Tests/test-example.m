Module[{dir, res1, testresult},

  dir = Directory[];  (* Save current directory *)

  (* Go in test directory *)
  SetDirectory[Environment["MMALPHA"]<>"/tests/TestAlpha/"];
  Print["Test for Alpha.m"];

  (* Build a list of boolean values *)
  res1= 
  {
    testFunction[load["Test1.alpha"];$result,<<"RTest1","Alpha 1"],
    testFunction[load[22],Null,"Alpha 2"],
    testFunction[Check[show[],$Failed],Null,"Alpha 3"],
    testFunction[show[22],Null,"Alpha 4"],
    (* ... *)
    ReadList["MV1.c",Record,RecordSeparators->{}]===
      ReadList["MV1.c",Record,RecordSeparators->{}],True,"writeC 1"],
    DeleteFile["MV1.c"];True
  }

  (* And the list *)
  testResult = Apply[And,res1];

  (* Back to initial dir *)
  SetDirectory[dir];

  (* Diagnostic *)
  If[ testResult,
    Print["**** Test OK for Alpha.m "],
    Print["**** Something was wrong for Alpha.m"]];

  (* Do not forget to return the result *)
  testResult
] (* End module *)
