(* 
  This is a MMA file for testing functions of the Vhdl2
  package. This can be called using the test function of 
  MMAlpha.
*)
Module[{res1, testResult},
  dir = Directory[];
  SetDirectory[Environment["MMALPHA"]<>"/tests/TestVhdl2"];
  Print["Test for Vhdl2.m"];

  res1= 
  {
    Print["Testing a2v"];
    testFunction[load["adder.alpha"]; a2v[stdLogic -> True]; 
      Drop[ReadList["adder.vhd", Record], 4], << R1, "Vhdl 1"]
  ,
    testFunction[load["adder.alpha"]; a2v[]; 
      Drop[ReadList["adder.vhd", Record], 4], << R2, "Vhdl 2"]
  ,
    testFunction[load["reg.alpha"]; a2v[]; 
      Drop[ReadList["reg.vhd", Record], 4], << R3, "Vhdl 3"]
  ,
    testFunction[load["addreg.alpha"]; a2v[]; 
      Drop[ReadList["addreg.vhd", Record], 4], << R4, "Vhdl 4"]
  ,
    testFunction[load["addreg.alpha"]; a2v[stdLogic -> True]; 
      Drop[ReadList["addreg.vhd", Record], 4], << R5, "Vhdl 5"]
  ,
    testFunction[load["mux.alpha"]; a2v[]; 
      Drop[ReadList["mux.vhd", Record], 4], << R6, "Vhdl 6"]
  ,
    testFunction[load["mux.alpha"]; a2v[stdLogic -> True]; 
      Drop[ReadList["mux.vhd", Record], 4], << R7, "Vhdl 7"]
  ,
    testFunction[load["loadregister.alpha"]; a2v[stdLogic -> True]; 
      Drop[ReadList["loadregister.vhd", Record], 4], << R8, "Vhdl 8"]
  ,
    testFunction[load["loadregister.alpha"]; a2v[]; 
      Drop[ReadList["loadregister.vhd", Record], 4], << R9, "Vhdl 9"]
  ,
    testFunction[load["cellFirModule1.alpha"]; a2v[]; 
      Drop[ReadList["cellFirModule1.vhd", Record], 4], << R11, "Vhdl 11"]
  ,
    testFunction[load["cellFirModule3.alpha"]; a2v[]; 
      Drop[ReadList["cellFirModule3.vhd", Record], 4], << R18, "Vhdl 18"]
  ,
    testFunction[load["cellFirModule4.alpha"]; a2v[]; 
      Drop[ReadList["cellFirModule4.vhd", Record], 4], << R19, "Vhdl 19"]
  ,
    testFunction[load["controlFirModule.alpha"]; assignParameterValue["N", 5]; 
      assignParameterValue["M", 10]; a2v[]; 
      Drop[ReadList["controlFirModule.vhd", Record], 4], << R14, "Vhdl 14"]
  ,
    testFunction[load["firfir.alpha"]; a2v[]; 
      Drop[ReadList["firModule.vhd", Record], 4], << R15, "Vhdl 15"]
  , 
    testFunction[load["cellFirModule3.alpha"]; a2v[stdLogic -> True]; 
      Drop[ReadList["cellFirModule3.vhd", Record], 4], << R12, "Vhdl 12"]
  ,
    testFunction[load["cellFirModule4.alpha"]; a2v[stdLogic -> True]; 
      Drop[ReadList["cellFirModule4.vhd", Record], 4], << R13, "Vhdl 13"]
  ,
    testFunction[load["logical.alpha"]; a2v[]; 
      Drop[ReadList["logical.vhd", Record], 4], << R16, "Vhdl 16"]
  ,
    testFunction[load["logical.alpha"]; a2v[stdLogic->True]; 
      Drop[ReadList["logical.vhd", Record], 4], << R17, "Vhdl 17"]
  };

  testResult = Apply[And,res1];

  SetDirectory[dir];

  If[ testResult,
    Print["**** Test OK for Vhdl2.m "],
    Print["**** Something was wrong during the test of Vhdl2.m"]];

  testResult
]
