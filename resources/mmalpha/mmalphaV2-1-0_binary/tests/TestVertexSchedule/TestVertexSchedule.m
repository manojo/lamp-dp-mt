(* Written by P. Quinton, 19/5/04 *)
(*
   This test file check some functions of the VertexSchedule 
   package. 
*)
dir = Directory[];
SetDirectory[Environment["MMALPHA"]<>"/tests/TestVertexSchedule/"];

Module[ {res,res1},
  Print["Test for VertexSchedule.m"];

  res1= 
    {
  
    testFunction[
      load["matmults.alpha"];
      adaptUses[];
      loadScheduleLibrary["dot"];
      res = scd[addConstraints -> {TBD4 == 0}],
      (* res>>VTest1; *)
      <<VTest1,"VertexSchedule 1-1"]
  ,    
    testFunction[
      load["matmults.alpha"];
      adaptUses[];
      loadScheduleLibrary["dot"];
      res = structSched[],
      (* res>>VTest1-2; *)
      <<VTest1-2,"VertexSchedule 1-2"]
  ,
    testFunction[
      load["fulladder.alpha"];
      loadScheduleLibrary["FullAdder"];
      res = scd[],
      (* res>>VTest2; *)
      <<VTest2,"VertexSchedule 2-1"]
  ,
    testFunction[
      load["fulladder.alpha"];
      adaptUses[];
      loadScheduleLibrary["FullAdder"];
      res = structSched[],
       res>>VTest2-2; 
      <<VTest2-2,"VertexSchedule 2-2"]
  ,
    testFunction[
      load["testscd1.alpha"];
      getSystem["add"];
      scd[addConstraints -> {TaD1 == 1, TbD1 == 1, TcD1 == 1}];
      getSystem["testscd1"];
      adaptUses[];
      res = scd[],
      res>>VTest3-1;
      <<VTest3-1,"VertexSchedule 3-1"]
  ,
    testFunction[
      load["testscd1.alpha"];
      getSystem["add"];
      scd[addConstraints -> {TaD1 == 1, TbD1 == 1, TcD1 == 1}];
      getSystem["testscd1"];
      res = Check[ structSched[];False, True ],
      res,"VertexSchedule 3-2"]
  ,
    testFunction[
      load["testscd1.alpha"];
      adaptUses[];
      res = structSched[],
      res>>VTest3-3;
      <<VTest3-3,"VertexSchedule 3-3"]
  };

  testResult = Apply[And,res1];

  SetDirectory[dir];

  If[ testResult,
    Print["**** Test OK for VertexSchedule.m "],
    Print["**** Something was wrong for VertexSchedule.m"]
  ];

testResult
];

