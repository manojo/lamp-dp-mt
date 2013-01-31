Module[{dir},
  dir = Directory[];
  SetDirectory[Environment["MMALPHA"] <> "/lib/Packages"];
  doDoc["Alpha.m", "Alpha.tex", 
	targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
(*

  doDoc["Alpha/Domlib.m", "Domlib.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Zpol.m","Zpol.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
 *)

       (*
  doDoc["Alpha/Visual.m", "Visual.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Visual3D.m","Visual3D.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Static.m", "Static.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/SubSystems.m", "SubSystems.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Matrix.m","Matrix.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Tables.m","Tables.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/MakeDoc.m", "MakeDoc.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Normalization.m", "Normalization.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Semantics.m", "Semantics.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/ChangeOfBasis.m", "ChangeOfBasis.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Substitution.m", "Substitution.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Reduction.m", "Reduction.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Cut.m", "Cut.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/INorm.m", "INorm.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/INormalize.m", "INormalize.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Alphard.m", "Alphard.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/BinExpansion.m", "BinExpansion.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/BitOperators.m", "BitOperators.tex", 
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Control.m","Control.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/INormalize.m","INormalize.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Lexicographic.m","Lexicographic.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/LinearAlg.m","LinearAlg.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Meta.m","Meta.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/ModularSchedule.m","ModularSchedule.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Omega.m","Omega.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Options.m","Options.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Pipeline.m","Pipeline.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/PipeControl.m","PipeControl.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Properties.m","Properties.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Reduction.m","Reduction.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Schedule.m","Schedule.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/ScheduleTools.m","ScheduleTools.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Schematics.m","Schematics.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/SystemCTestBench.m","SystemCTestBench.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/SystemCTools.m","SystemCTools.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/SystemProgramming.m","SystemProgramming.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/ToAlpha0v2.m","ToAlpha0v2.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Transformation.m","Transformation.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Uniformization.m","Uniformization.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/UniformizationTools.m","UniformizationTools.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
	*)
  doDoc["Alpha/VertexSchedule.m","VertexSchedule.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
       (*
  doDoc["Alpha/FarkasSchedule.m","FarkasSchedule.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Vhdl2.m","Vhdl2.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/VhdlTestBench.m","VhdlTestBench.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/DesignManagement.m","DesignManagement.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Lexicographic.m","Lexicographic.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/LinearAlg.m","LinearAlg.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Meta.m","Meta.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/ModularSchedule.m","ModularSchedule.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Options.m","Options.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
  doDoc["Alpha/Schematics.m","Schematics.tex",
    targetDir -> Environment["MMALPHA"] <> "/doc/ReferenceManual"];
	*)
  SetDirectory[dir];
];
