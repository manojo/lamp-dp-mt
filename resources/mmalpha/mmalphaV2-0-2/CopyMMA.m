(* 
  This file contains a Mathematica program that allows one 
  to extract a new version of Mathematica and create it in 
  another directory. To work as you expect, you have to set
  variables sourceMMA and destMMA manually in this file. Also
  all files copied are directly specified in this file. The 
  purpose of it is to make sure that the copy mechanism runs
  on Mathematica, independendly on the available platform or
  OS type. 
  
  Currently, you have to set the value of the variables 
  sourceMMA and destMMA with the absolute path of the source
  directory (typically .../alpha_beta/) and of the destination
  directory. Warning: currently, the source directory is NOT
  the value of the $MMALPHA environment variable, but eventually,
  it will be the same. 

  The files that are extracted here are those needed to built a
  reasonable version of MMAlpha, but they are probably not complete. 
  The current version was done in order to check the compilation of 
  the source directory, without modifying the CVS local version. 

*)

Module[
  {sourceMMA, destMMA, dir, sourceDir, destDir, copyF, ft, contentFile, dd},

  (* A useful local function *)
  Clear[copyF];
  copyF[n:_String] := 
  Catch[
    Module[ {},
      Check[
        CopyFile[ sourceDir<>"/"<>n, destDir<>"/"<>n ],
        copyF::err = "Could not copy file `1`";
        Throw[ Message[ copyF::err, sourceDir<>"/"<>n ] ]
      ];
      WriteString[ contentFile, "File "<>n<>"\n" ];
    ]
  ];
  copyF[___] := Print["Argument Error..."];

  (* Another useful function *)
  Clear[copyDir];
  copyDir[n:_String] := 
  Catch[
    Module[ {dir, sourced, destd, flag},
      (* Save directory *)
      dir = Directory[];

      (* Set source directory *)
      sourced = sourceMMA<>"/"<>n;

      (* Set destination directory *)
      destd = destMMA<>"/"<>n;
      Print["Copying ", sourced ];
      WriteString[ contentFile, "\n\n*******************\n" ];
      WriteString[ contentFile, "Copying full directory "<>n<>" \n" ];
      Check[
        flag = CopyDirectory[ sourced, destd ];
        If[ flag === $Failed, Print["******* Error while copying directory: ",
					FullForm[ sourced ], "\nin directory: ",
					FullForm[ destd ] ] ];
        SetDirectory[ destd ];
        WriteString[ contentFile, 
          Apply[ StringJoin, Map[ "File "<>#<>"\n"&, FileNames[ ] ] ] 
        ],
        copyF::err = "Could not copy file `1`";
        SetDirectory[ dir ];
        Throw[ Message[ copyF::err, sourceDir<>"/"<>n ] ]
      ];

      (* Remove CVS directory, if any *)
      If[ FileInformation["CVS"] =!= {}, 
         DeleteDirectory["CVS", DeleteContents->True ] ];

      SetDirectory[ dir ];

    ]
  ];
  copyDir[___] := Print["Argument Error..."];

  Catch[
    (* These assignement need to be changed in order 
       to adapt this utilitary *)
    sourceMMA = "/Users/quinton/mmalpha";
    destMMA = "/Users/quinton/Recherche/Alpha/mmalphaV2-0-2";

    (* Save current directory *)
    dir = Directory[];

    (* Assume the destination directory exists *)
    copyMMA::nodestdir = 
	"destination directory `1`does not exist. Please, create it.";
    Check[
      ft = FileType[ destMMA ],
      Throw[ Message[ copyMMA::nodestdir, destMMA ] ]
    ];
    Print["Status of ", destMMA, " is ", ft ];
    If[ ft === None, Throw[ Message[ copyMMA::nodestdir, destMMA ] ] ];

    (* Open the content file and write header *)
    contentFile = OpenWrite[ destMMA<>"/content.txt" ];
    dd = Date[];
    WriteString[ contentFile, 
      StringJoin[
        "This MMAlpha directory was extracted on ",
        ToString[dd[[2]]],
        "/",
        ToString[dd[[3]]],
        "/",
        ToString[dd[[1]]],
        " at ",
        ToString[dd[[4]]],
        ":",
        ToString[dd[[5]]],
        ":",
        ToString[dd[[6]]],
        "\n"
      ]
    ];
    WriteString[ contentFile, "From directory: "<>sourceMMA<>"\n" ];
    WriteString[ contentFile, "On machine: "<>$MachineName<>"\n" ];
    WriteString[ contentFile, "of user: "<>$UserName<>"\n\n" ];


    (* -------------------------- *)
    (* Main directory *)
    (* Version of 2008/09/06 *)
    sourceDir = sourceMMA;
    destDir = destMMA;
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from main directory\n" ];

    SetDirectory[sourceDir];
(*    copyF["LICENCING"]; *)
    copyF["CopyMMA.m"];  (* Copy this file to possibly check what was done *)
    copyF["index.html"];
    copyF["README"];
    copyF["welcome.html"];

    (* -------------------------- *)
    (* bin.cygwin *)
    (* Version of 2008/09/06 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/bin.cygwin";

    (* Set destination directory *)
    destDir = destMMA<>"/bin.cygwin";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /bin.cygwin\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
(*
    copyF["README"];           (* Needed *)
*)
    copyF["code_gen.exe"];     (* Needed *)
    copyF["cygwin1.dll"];      (* Needed *)
    copyF["domlib.exe"];       (* Needed *)
    copyF["index.html"];       (* Needed *) 
    copyF["pip.exe"];          (* Needed *)
    copyF["read_alpha.exe"];   (* Needed *)
    copyF["write_alpha.exe"];  (* Needed *)
(*
    copyF["write_c.exe"];      (* ?? *)
*)

    (* -------------------------- *)
    (* Version of 2008/09/06 *)
    (* bin.cygwin32 *)
    copyDir["bin.cygwin32"];

    (* -------------------------- *)
    (* Set source directory *)
    (* Version of 2008/09/06 *)
    sourceDir = sourceMMA<>"/bin.darwin";

    (* Set destination directory *)
    destDir = destMMA<>"/bin.darwin";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /bin.darwin\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["code_gen"];
    copyF["domlib"];
    copyF["index.html"]; 
    copyF["pip"];
    copyF["read_alpha"];
    copyF["README"];
    copyF["write_alpha"];
    copyF["write_c"];

    (* -------------------------- *)
    (* Set source directory *)
    (* Version of 2008/09/06 *)
    (* bin.linux *)
    copyDir["bin.linux"];

    (* -------------------------- *)
    (* config *)
    (* Version of 2008/09/06 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/config";

    (* Set destination directory *)
    destDir = destMMA<>"/config";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /config\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["diagnose.m"];           (* Needed *)
    copyF["index.html"];       (* Needed *)
    copyF["init.m"];           (* Needed *)
    copyF["README"];           (* Needed *)
    copyF["tbs.txt"];          (* Needed *)

    (* -------------------------- *)
    (* demos *)
    (* Set source directory *)
    (* Version of 2008/09/06 *)
    sourceDir = sourceMMA<>"/demos";

    (* Set destination directory *)
    destDir = destMMA<>"/demos";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["demos.html"];       (* Needed *)
    copyF["index.html"];       (* Needed *)
    copyF["README"];           (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS *)
    (* Version of 2008/09/06 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["master.nb"];           (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Distances *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Distances";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Distances";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Distances\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["distances.alpha"];        (* Needed *)
    copyF["Distances.nb"];           (* Needed *)
    copyF["README"];        (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Domlib *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Domlib";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Domlib";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Domlib\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Domlib.nb"];           (* Needed *)
    copyF["lu.alpha"];           (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Fifo *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Fifo";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Fifo";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Fifo\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Fifo.nb"];           (* Needed *)
    copyF["fifo1.alpha"];       (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Fir *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Fir";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Fir";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Fir\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Fir.nb"];           (* Needed *)
    copyF["fir.alpha"];       (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Getting-started *)

    (* Version of 2008/09/06 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Getting-started";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Getting-started";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Getting-started\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Getting-started.nb"];           (* Needed *)
    copyF["prodVect.alpha"];               (* Needed *)
    copyF["binaryAdder.alpha"];       (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Introduction *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Introduction";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Introduction";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Introduction\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Introduction.nb"];           (* Needed *)
    (* Removed in version V2-0-2
    copyF["mma-intro.nb"];           (* Needed *)
     *)
    copyF["exemple2.alpha"];       (* Needed *)
    copyF["exemple3wrg.alpha"];       (* Needed *)
    copyF["exemple9.alpha"];       (* Needed *)
    copyF["MV1.alpha"];       (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Matmult *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Matmult";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Matmult";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Matmult\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["matmult.nb"];           (* Needed *)
    copyF["matmult.alpha"];           (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Matvect *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Matvect";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Matvect";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Matvect\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["matvect.nb"];           (* Needed *)
    copyF["MV1.alpha"];           (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/Samba *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/Samba";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/Samba";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Samba\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["samba.nb"];           (* Needed *)
    copyF["Samba.alpha"];           (* Needed *)

    (* -------------------------- *)
    (* demos/NOTEBOOKS/StructuredScheduler *)
    (* Version of 2008/09/06 *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/demos/NOTEBOOKS/StructuredScheduler";

    (* Set destination directory *)
    destDir = destMMA<>"/demos/NOTEBOOKS/StructuredScheduler";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /demos/NOTEBOOKS/Scheduler\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["StructuredScheduler.nb"];           (* Needed *)
    copyF["fulladder.alpha"];           (* Needed *)
    copyF["matmult.alpha"];           (* Needed *)
    copyF["matmults.alpha"];           (* Needed *)
    copyF["testscd1.alpha"];           (* Needed *)
    copyF["testscd2.alpha"];           (* Needed *)
    copyF["testscd3.alpha"];           (* Needed *)
    copyF["testscd4.alpha"];           (* Needed *)


    (* -------------------------- *)
    (* Set source directory *)
    (* Version of 2008/09/06 *)
    (* demos/NOTEBOOKS/Synthesis *)
    copyDir["demos/NOTEBOOKS/Synthesis"];

    (* -------------------------- *)
    (* doc *)
    (* Version of 2008/09/06 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/doc";
    (* Set destination directory *)
    destDir = destMMA<>"/doc";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /doc\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["alpha.gif"];
    copyF["alphaDoc.html"];
    copyDir["doc/Alphard"];
    copyDir["doc/Developers"];
    copyDir["doc/Distribution"];
    copyDir["doc/Doc-MMA-Darwin"];
    copyF["FixedPointArithmeticInMMAlpha.pdf"];
    copyDir["doc/Install"];
    copyF["MMAlphaDoc.html"];
    copyDir["doc/Pipeline"];
    copyDir["doc/PolyLib"];
    copyDir["doc/QuickStart"];
    copyDir["doc/ReferenceManual"];
    copyDir["doc/Schedule"];
    copyDir["doc/Technical-Manual"];
    copyDir["doc/Users"];
    copyF["developersDoc.html"];
    copyF["docMMAlpha.html"];
    copyF["generalDoc.html"];
    copyF["index.html"];
    copyDir["doc/packages"];
    copyDir["doc/tutorial"];

    (* -------------------------- *)
    (* lib *)
    (* Version of 2008/09/06. No changes *)

    (* Set source directory *)
    sourceDir = sourceMMA<>"/lib";

    (* Set destination directory *)
    destDir = destMMA<>"/lib";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /lib\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["index.html"];           (* Needed *)
    (* =======  README missing *)
    (* Not copied : 
       MathLink
    *)

    (* -------------------------- *)
    (* lib/Packages *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/lib/Packages";

    (* Set destination directory *)
    destDir = destMMA<>"/lib/Packages";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /lib/Packages\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["README"];  (* ?? *)
    copyF["Alpha.m"];              (* Needed *)
(*    copyF["Pip.m"];                (* Needed *)
 *)
    copyF["Fail.m"];               (* Needed *)
    copyF["index.html"];           (* Needed *)
    copyF["Setup.m"];              (* ?? *)

    (* Not copied : 
       Doc
    *)

    (* -------------------------- *)
    (* lib/Packages/Alpha *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/lib/Packages/Alpha";

    (* Set destination directory *)
    destDir = destMMA<>"/lib/Packages/Alpha";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /lib/Alpha\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Alphard.m"];               (* Needed *)
    (*
    copyF["BinExpansion.m"];          (* Needed *)
    copyF["BitOperators.m"];          (* ? *)
     *)
    copyF["ChangeOfBasis.m"];         (* ? *)
    copyF["CheckAlpha0.m"];             (* Generated Automatically *)
    copyF["CheckAlpha0.meta"];          (* Source file *)
    copyF["CheckAlpha0.sem"];           (* Needed *)
    copyF["CheckCell.m"];             (* Generated Automatically *)
    copyF["CheckCell.meta"];          (* Source file *)
    copyF["CheckCell.sem"];           (* Needed *)
    copyF["CheckController.m"];       (* Generated Automatically *)
    copyF["CheckController.meta"];    (* Source file *)
    copyF["CheckController.sem"];     (* Needed *)
    copyF["CheckModule.m"];           (* Generated Automatically *)
    copyF["CheckModule.meta"];        (* Source file *)
    copyF["CheckModule.sem"];         (* Needed *)
    copyF["Control.m"];               (* Needed *)
    copyF["CutMMA.m"];                   (* Needed *)
    (*
    copyF["Demos.m"];                 (* ? *)
     *)
    copyF["Domlib.m"];                (* Needed *)
    copyF["FarkasSchedule.m"];        (* Needed *)
    (*
    copyF["Format.m"];                (* ? *)
     *)
    copyF["INorm.m"];                 (* Needed *)
    (*
    copyF["Inormalize.m"];            (* Needed *)
     *)
    copyF["Lexicographic.m"];         (* ? *)
    (*
    copyF["LinearAlg.m"];             (* Needed *)
    copyF["MakeDoc.m"];               (* Needed for documentation *)
     *)
    copyF["Matrix.m"];                (* Needed *)
    copyF["Meta.m"];                  (* Needed for generation *)
    (*
    copyF["ModularSchedule.m"];       (* Needed *)
     *)
    copyF["Normalization.m"];         (* Needed *)
    (*
    copyF["Omega.m"];                 (* ? *)
     *)
    copyF["Options.m"];               (* Needed *)
    copyF["PipeControl.m"];           (* Needed *)
    copyF["Pipeline.m"];              (* Needed *)
    copyF["Properties.m"];            (* Needed *)
    copyF["README"];             (* Needed *)
    copyF["Reduction.m"];             (* Needed *)
    copyF["Schedule.m"];              (* Needed *)
    (*
    copyF["Schedule2.m"];             (* ? *)
     *)
    copyF["ScheduleTools.m"];         (* Needed *)
    copyF["Schematics.m"];            (* Needed *)
    copyF["Semantics.m"];             (* Needed *)
    copyF["Static.m"];                (* Needed *)
    copyF["SubSystems.m"];            (* Needed *)
    copyF["Substitution.m"];          (* Needed *)
    copyF["Synthesis.m"];          (* Needed *)
    (*
    copyF["SystemCTestBench.m"];      (* Needed *)
    copyF["SystemCTools.m"];          (* Needed *)
     *)
    copyF["SystemProgramming.m"];     (* Needed *)
    copyF["Tables.m"];                (* Needed *)
    copyF["ToAlpha0v2.m"];            (* Needed *)
    (*
    copyF["Transformation.m"];        (* Needed *)
    copyF["Uniformization.m"];        (* Needed *)
    copyF["UniformizationTools.m"];   (* Needed *)
     *)
    copyF["VertexSchedule.m"];        (* Needed *)
    copyF["Vhdl2.m"];                 (* Needed *)
    copyF["VhdlTestBench.m"];         (* Needed *)
    copyF["Visual.m"];                (* Needed *)
    copyF["Visual3D.m"];              (* Needed *)
    copyF["Zpol.m"];                  (* Needed *)
    copyF["autoload.m"];              (* Generated Automatically *)
    (*
    copyF["index.html"];              (* Needed *)
    copyF["systemCCell.m"];           (* Generated Automatically *)
    copyF["systemCCell.meta"];        (* Source file *)
    copyF["systemCCell.sem"];         (* Needed *)
    copyF["systemCControler.m"];      (* Generated Automatically *)
    copyF["systemCControler.meta"];   (* Source file *)
    copyF["systemCControler.sem"];    (* Needed *)
    copyF["systemCModule.m"];         (* Generated Automatically *)
    copyF["systemCModule.meta"];      (* Source file *)
    copyF["systemCModule.sem"];       (* Needed *)
     *)
    copyF["vhdlCell.m"];              (* Generated Automatically *)
    copyF["vhdlCell.meta"];           (* Source file *)
    copyF["vhdlCell.sem"];            (* Needed *)
    copyF["vhdlCont.m"];              (* Generated Automatically *)
    copyF["vhdlCont.meta"];           (* Source file *)
    copyF["vhdlCont.sem"];            (* Needed *)
    copyF["vhdlModule.m"];            (* Generated Automatically *)
    copyF["vhdlModule.meta"];         (* Source file *)
    copyF["vhdlModule.sem"];          (* Needed *)
    (* Not copied : 
       change.log, Nana.m, Simul.m, Vhdl.m
    *)

    (* -------------------------- *)
    (* sources *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/lib/Packages/Alpha/CodeGen";

    (* Set destination directory *)
    destDir = destMMA<>"//lib/Packages/Alpha/CodeGen";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /lib/Packages/Alpha/CodeGen\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Domains.m"];                        (* Needed *)
    copyF["init.m"];                           (* Needed *)
    copyF["Loops.m"];                          (* Needed *)
    copyF["Output.m"];                        (* Needed *)
    copyF["Restrict.m"];                       (* Needed *)

    (* -------------------------- *)
    (* lib.cygwin : ********* ??? *)

    (* -------------------------- *)
    (* maintenance : ********* ??? *)

    (* -------------------------- *)
    (* sources *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources";

    (* Set destination directory *)
    destDir = destMMA<>"/sources";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Makefile"];                        (* Needed *)
    copyF["index.html"];                      (* Needed *)
    copyF["README"];                          (* Needed *)
    copyF["polylib-5.22.3.tar.gz"];           (* Needed *)

    (* Not copied : 
       v2.3-notes and version
    *)

    (* -------------------------- *)
    (* sources/Pip *)
     (*
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Pip";

    (* Set destination directory *)
    destDir = destMMA<>"/sources/Pip";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /Pip\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];

    copyF["Makefile"];                        (* Needed *)
    copyF["README"];                          (* Needed *)
    copyF["funcall.h"];                       (* Needed *)
    copyF["integrer.c"];                      (* Needed *)
    copyF["linear.sol"];                      (* ? *)
    copyF["maind.c"];                         (* Needed *)
    copyF["sol.c"];                           (* Needed *)
    copyF["sol.h"];                           (* Needed *)
    copyF["tab.c"];                           (* Needed *)
    copyF["tab.h"];                           (* Needed *)
    copyF["traiter.c"];                       (* Needed *)
    copyF["type.h"];                          (* Needed *)
      *)

    (* Not copied : 
       Obj.cygwin, as it should be created automatically
    *)

    (* -------------------------- *)
    (* sources/Code_Gen *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Code_Gen";

    (* Set destination directory *)
    destDir = destMMA<>"/sources/Code_Gen";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Code_Gen\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["gen.c"];
    copyF["gen.h"];
    copyF["lex.c"];
    copyF["lex.l"];
    copyF["Makefile"];        
    copyF["node.h"];
    copyF["nodeprocs.c"];
    copyF["nodeprocs.h"];
    copyF["README"];
    copyF["VERSION"];
    copyF["y.tab.h"];
    copyF["yacc.y"];
    copyF["y.output"];

    (* -------------------------- *)
    (* sources/Code_Gen/Obj.darwin *)
    (* Set source directory *)
    (*    sourceDir = sourceMMA<>"/sources/Code_Gen/Obj.darwin"; *)

    (* Set destination directory *)
    (*    destDir = destMMA<>"/sources/Code_Gen/Obj.darwin"; *)
    (*    Print["Copying ", sourceDir]; *)
    (*    WriteString[ contentFile, "\n\n****************\n" ]; *)
    (*    WriteString[ contentFile, "Copying from /sources/Code_Gen/Obj.darwin\n" ]; *)

    (*    SetDirectory[sourceDir]; *)
    (*    CreateDirectory[destDir]; *)
    (*    copyF["code_gen"]; *)
    (*    copyF["errormsg.o"]; *)
    (*    copyF["errors.o"]; *)
    (*    copyF["gen.o"]; *)
    (*    copyF["Lattice.o"];         *)
    (*    copyF["Matop.o"]; *)
    (*    copyF["nodeprocs.o"]; *)
    (*    copyF["NormalForms.o"]; *)
    (*    copyF["polyhedron.o"]; *)
    (*    copyF["SolveDio.o"]; *)
    (*    copyF["vector.o"]; *)
    (*    copyF["yacc.o"]; *)
    (*    copyF["Zpolyhedron.o"]; *)

    (* -------------------------- *)
    (* sources/Code_Gen/Test *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Code_Gen/Test";

    (* Set destination directory *)
    destDir = destMMA<>"/sources/Code_Gen/Test";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Code_Gen/Test\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Makefile"];
    copyF["README"];

    (* -------------------------- *)
    (* sources/Domlib *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Domlib";

    (* Set destination directory *)
    destDir = destMMA<>"/sources/Domlib";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Domlib\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];

    copyF["Makefile"];                        (* Needed *)
    copyF["Makefile.Visual"];                 (* Needed *)
    copyF["Makefile.linux"];                  (* Needed *)
    copyF["Makefile.darwin"];                  (* Needed *)
    copyF["README"];                          (* Needed *)
    copyF["domlib.c"];                        (* Needed *)
    copyF["domlib.tm"];                       (* Needed *)
    (* Not copied : 
       Obj.cygwin, as it should be created automatically
    *)

    (* -------------------------- *)
    (* sources/Domlib/Obj.darwin *)
    (* Set source directory *)
    (*    sourceDir = sourceMMA<>"/sources/Domlib/Obj.darwin"; *)

    (* Set destination directory *)
    (*    destDir = destMMA<>"/sources/Domlib/Obj.darwin"; *)
    (*    Print["Copying ", sourceDir]; *)
    (*    WriteString[ contentFile, "\n\n****************\n" ]; *)
    (*    WriteString[ contentFile, "Copying from /sources/Domlib/Obj.darwin\n" ]; *)

    (*    SetDirectory[sourceDir]; *)
    (*    CreateDirectory[destDir]; *)

    (*    copyF["domlib"];                        (* Needed *) *)
    (*    copyF["domlib.o"];                 (* Needed *) *)
    (*    copyF["domlibtm.c"];                  (* Needed *) *)
    (*    copyF["domlibtm.o"];                  (* Needed *) *)

    (* -------------------------- *)
    (* sources/MakeIncludes *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/MakeIncludes";

    (* Set destination directory *)
    destDir = destMMA<>"/sources/MakeIncludes";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/MakeIncludes\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["Makefile.checkvars"];                 (* Needed *)
    copyF["Makefile.config"];                 (* Needed *)
    copyF["Makefile.cygwin"];                 (* Needed *)
    copyF["Makefile.cygwin.4.2"];                 (* Needed *)
    copyF["Makefile.darwin"];               (* Needed *)
    copyF["Makefile.darwin.5.2"];               (* Needed *)
    copyF["Makefile.darwin.6.0"];               (* Needed *)
    copyF["Makefile.linux"];                  (* Needed *)
    copyF["Makefile.linux.3.0.1"];                  (* Needed *)
    copyF["Makefile.linux.4.2"];                  (* Needed *)
    copyF["Makefile.linux.6.0"];                  (* Needed *)
    copyF["Makefile.rules"];                  (* Needed *)
    copyF["README"];                         (* Needed *)

    (* Not copied : 
       Makefile.solaris and Makefile.sunos4
    *)

    (* Not copied : Mathlink *)

    (* -------------------------- *)
    (* sources/Pip *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Pip";

    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Pip";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Pip\n" ];

    copyF["Makefile"];              (* N *)

    (* -------------------------- *)
    (* sources/Pip/piplib-1.3.3 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Pip/piplib-1.3.3";

    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Pip/piplib-1.3.3";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Pip/piplib-1.3.3\n" ];

    copyF["Makefile"];              (* N *)

    (* -------------------------- *)
    (* sources/Pretty *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Pretty";
    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Pretty";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Pretty\n" ];

    copyF["item.h"];                (* N *)
    copyF["itemprocs.c"];                (* N *)
    copyF["itemprocs.h"];                (* N *)
    copyF["lex.l"];                (* N *)
    copyF["Makefile"];              (* N *)
    copyF["readitem.c"];                (* N *)
    copyF["writeitem.c"];                (* N *)
    copyF["writeitem.h"];                (* N *)

    (* -------------------------- *)
    (* sources/Read_Alpha *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Read_Alpha";
    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Read_Alpha";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Read_Alpha\n" ];

    copyF["Makefile"];              (* N *)
    copyF["README"];              (* N *)
    copyF["lex.l"];                 (* N *)
    copyF["node.c"];                (* N *)
    copyF["node.h"];                (* N *)
    copyF["nodetypes.h"];           (* N *)
    copyF["read_alpha.c"];           (* N *)
    copyF["yacc.y"];                (* N *)

    (* -------------------------- *)
    (* sources/Sed *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Sed";
    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Sed";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Sed\n" ];

    copyF["TransMatForPip.sed"];              (* N *)
    copyF["sup_antislash_pip.sed"];              (* N *)

    (* -------------------------- *)
    (* sources/Lp_Solve *)
    (* Set source directory *)
(*
    sourceDir = sourceMMA<>"/sources/Lp_Solve";
    (* Set destination directory *)
    destDir = destMMA<>"/sources/Lp_Solve";
    SetDirectory[sourceDir];
    Print["Copying ", sourceDir];
    CreateDirectory[destDir];

    (* -------------------------- *)
    (* sources/Polylib/Lp_Solve/lp_solve_2.2 *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Lp_Solve/lp_solve_2.2";
    (* Set destination directory *)
    destDir = destMMA<>"/sources/Lp_Solve/lp_solve_2.2";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];

    Print["Copying ", sourceDir];
    copyF["CHANGELOG"];              (* N *)
    copyF["HARTMUT_DOCUMENTATION"];  (* N *)
    copyF["MANIFEST"];               (* N *)
    copyF["MIPLIB_RESULTS"];         (* N *)
    copyF["Makefile"];               (* N *)
    copyF["NETLIB_RESULTS"];         (* N *)
    copyF["README"];                 (* N *)
    copyF["debug.c"];                (* N *)
    copyF["debug.h"];                (* N *)
    copyF["demo.c"];                 (* N *)
    copyF["from_solve.c"];           (* N *)
    copyF["hash.c"];                 (* N *)
    copyF["hash.h"];                 (* N *)
    copyF["lex.l"];                  (* N *)
    copyF["lp.y"];                   (* N *)
    copyF["lp2mps.c"];               (* N *)
    copyF["lp_solve.1"];             (* N *)
    copyF["lp_solve.c"];             (* N *)
    copyF["lp_solve.man"];           (* N *)
    copyF["lpglob.h"];               (* N *)
    copyF["lpkit.c"];                (* N *)
    copyF["lpkit.h"];                (* N *)
    copyF["mps2lp.c"];               (* N *)
    copyF["patchlevel.h"];           (* N *)
    copyF["presolve.c"];             (* N *)
    copyF["read.c"];                 (* N *)
    copyF["read.h"];                 (* N *)
    copyF["readmps.c"];              (* N *)
    copyF["solve.c"];                (* N *)
 *)


    (* -------------------------- *)
    (* sources/MakeDoc *)
    (* Set source directory *)
    (*
    sourceDir = sourceMMA<>"/sources/MakeDoc";
    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/MakeDoc";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/MakeDoc\n" ];

    copyF["How-to-make-a-doc.tex"];              (* N *)
    copyF["README"];                             (* N *)
    copyF["moduleDoc.tex"];              (* N *)
     *)

    (* -------------------------- *)
    (* sources/Write_Alpha *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Write_Alpha";
    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Write_Alpha";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Write_Alpha\n" ];

    copyF["item.h"];                 (* N *)
    copyF["itemprocs.c"];                 (* N *)
    copyF["itemprocs.h"];                 (* N *)
    copyF["lex.l"];                 (* N *)
    copyF["Makefile"];              (* N *)
    copyF["node.h"];                (* N *)
    copyF["node2item.c"];           (* N *)
    copyF["node2item.h"];           (* N *)
    copyF["nodeprocs.c"];           (* N *)
    copyF["nodeprocs.h"];           (* N *)
    copyF["README"];                (* N *)
    copyF["writeitem.c"];           (* N *)
    copyF["writeitem.h"];           (* N *)
    copyF["yacc.y"];                (* N *)

    (* -------------------------- *)
    (* sources/Write_Alpha/Test *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Write_Alpha/Test";
    (* Set destination directory *)
    (* =========== Not sure of what is here =========== *)
    destDir = destMMA<>"/sources/Write_Alpha/Test";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Write_Alpha/Test\n" ];

    copyF["ast"];              (* N *)    
    copyF["dom1.alpha"];       (* N *)
    copyF["dom1.ast"];         (* N *)
    copyF["out"];              (* N *)
    copyF["red1.alpha"];       (* N *)
    copyF["red1.ast"];         (* N *)
    copyF["xref"];             (* N *)
    copyF["xrf"];              (* N *)

    (* -------------------------- *)
    (* sources/Write_C *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Write_C";
    (* Set destination directory *)
    destDir = destMMA<>"/sources/Write_C";
    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Write_C\n" ];

    copyF["Makefile"];            (* N *)
    copyF["yacc.y"];              (* N *)
    copyF["yacc.c"];              (* N *)
    copyF["y.tab.h"];              (* N *)

    (* -------------------------- *)
    (* sources/Write_C/Obj.darwin *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Write_C/Obj.darwin";

    (* Set destination directory *)
    destDir = destMMA<>"/sources/Write_C/Obj.darwin";
    SetDirectory[sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Write_C/Obj.darwin\n" ];

    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    copyF["errormsg.o"];            (* N *)
    copyF["errors.o"];              (* N *)
    copyF["Lattice.o"];             (* N *)
    copyF["Matop.o"];               (* N *)
    copyF["matrix.o"];              (* N *)
    copyF["NormalForms.o"];         (* N *)
    copyF["polyhedron.o"];          (* N *)
    copyF["SolveDio.o"];            (* N *)
    copyF["vector.o"];              (* N *)
    copyF["write_c"];               (* N *)
    copyF["yacc.o"];                (* N *)
    copyF["Zpolyhedron.o"];         (* N *)

    (* -------------------------- *)
    (* sources/Write_C/Test *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/sources/Write_C/Test";
    (* Set destination directory *)
    destDir = destMMA<>"/sources/Write_C/Test";
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /sources/Write_C/Test\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    Print["Copying ", sourceDir];
    copyF["Makefile"];              (* N *)
    copyF["R4.alpha"];              (* N *)
    copyF["R4.ast"];                (* N *)
    copyF["R4.c"];                  (* N *)
    copyF["R5.alpha"];              (* N *)
    copyF["R5.ast"];                (* N *)
    copyF["R5.c"];                  (* N *)
    copyF["conv.alpha"];            (* N *)
    copyF["conv.ast"];              (* N *)
    copyF["conv.c"];                (* N *)
    copyF["convert.ast"];           (* N *)
    copyF["convert.c"];             (* N *)
    copyF["cosparam.ast"];          (* N *)
    copyF["cosparam.c"];            (* N *)
    copyF["florent.alpha"];         (* N *)
    copyF["florent.ast"];           (* N *)
    copyF["inline.alpha"];          (* N *)
    copyF["inline.ast"];            (* N *)
    copyF["inline.c"];              (* N *)
    copyF["matmul.alpha"];          (* N *)
    copyF["matmul.ast"];            (* N *)
    copyF["matmul.c"];              (* N *)
    copyF["pdgeru1.alpha"];         (* N *)
    copyF["pdgeru1.ast"];           (* N *)
    copyF["pdgeru1.c"];             (* N *)
    copyF["pdgeru2.alpha"];         (* N *)
    copyF["pdgeru2.ast"];           (* N *)
    copyF["pdgeru2.c"];             (* N *)
    copyF["pdscal.alpha"];          (* N *)
    copyF["pdscal.ast"];            (* N *)
    copyF["pdscal.c"];              (* N *)
    copyF["resultsbefore"];         (* N *)
    copyF["t.c"];                   (* N *)
    copyF["t1.alpha"];              (* N *)
    copyF["t1.ast"];                (* N *)
    copyF["t1.c"];                  (* N *)
    copyF["test1.alpha"];           (* N *)
    copyF["test1.ast"];             (* N *)
    copyF["test1.c"];               (* N *)
    copyF["test2.alpha"];           (* N *)
    copyF["test2.ast"];             (* N *)
    copyF["test2.c"];               (* N *)
    copyF["test3.alpha"];           (* N *)
    copyF["test3.ast"];             (* N *)
    copyF["test3.c"];               (* N *)
    copyF["test4.alpha"];           (* N *)
    copyF["test4.ast"];             (* N *)
    copyF["test4.c"];               (* N *)
    copyF["test5.alpha"];           (* N *)
    copyF["test5.ast"];             (* N *)
    copyF["test5.c"];               (* N *)
    copyF["useramr.alpha"];         (* N *)
    copyF["useramr.ast"];           (* N *)
    copyF["useramr.c"];             (* N *)

  ];


    (* -------------------------- *)
    (* tests *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/tests";

    (* Set destination directory *)
    destDir = destMMA<>"/tests";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /tests\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["README"];           (* Needed *)
    copyF["index.html"];       (* Needed *)
    copyF["testMMA.nb"];       (* Needed *)
    (* Not copied : 
       MathLink
    *)

    copyDir["tests/TestAlpha"];
    copyDir["tests/TestAlphard"];
    copyDir["tests/TestChangeOfBasis"];

    (* -------------------------- *)
    (* tests/TestCodegen *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/tests/TestCodegen";

    (* Set destination directory *)
    destDir = destMMA<>"/tests/TestCodegen";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /tests/TestCodegen\n" ];

    CopyDirectory[ sourceDir, destDir ];
    SetDirectory[ destDir ];
    DeleteDirectory["CVS", DeleteContents->True ];
    DeleteDirectory["Alpha/CVS", DeleteContents->True ];
    DeleteDirectory["C/CVS", DeleteContents->True ];
    DeleteDirectory["goodC/CVS", DeleteContents->True ];
    DeleteDirectory["testCholesky/CVS", DeleteContents->True ];
    DeleteDirectory["testFile/CVS", DeleteContents->True ];
    DeleteDirectory["testLud/CVS", DeleteContents->True ];
    DeleteDirectory["testLx/CVS", DeleteContents->True ];

    copyDir["tests/TestCutMMA"];
    copyDir["tests/TestDecomposition"];
    copyDir["tests/TestDomlib"];
    copyDir["tests/TestInstall"];
    copyDir["tests/TestMatrix"];
    copyDir["tests/TestModularSchedule"];
    copyDir["tests/TestMultiDim"];
  (*
    copyDir["tests/TestNewSchedule"];
   *)
    copyDir["tests/TestNormalization"];
    copyDir["tests/TestPip"];
    copyDir["tests/TestPipeControl"];
    copyDir["tests/TestPipeline"];

  (* Could not figure out why this command does not work, so decided
   to make a manual copy 
    copyDir["tests/TestSchedule"];
   *)

    (* -------------------------- *)
    (* tests *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/tests/TestSchedule";

    (* Set destination directory *)
    destDir = destMMA<>"/tests/TestSchedule";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /tests\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["armaUnif.alpha"];           (* Needed *)
    copyF["bug1.alpha"];           (* Needed *)
    copyF["bugApply.alpha"];           (* Needed *)
    copyF["bugPat.alpha"];           (* Needed *)
    copyF["DLMS_Alpha0.alpha"];           (* Needed *)
    copyF["durbin1.alpha"];           (* Needed *)
    copyF["durbin2.alpha"];           (* Needed *)
    copyF["fib2.alpha"];           (* Needed *)
    copyF["fib.alpha"];           (* Needed *)
    copyF["Kalman.alpha"];           (* Needed *)
    copyF["MatMat.alpha"];           (* Needed *)
    copyF["MMunif.alpha"];
    copyF["MMunifSched.alpha"];
    copyF["PIC3Unif3.alpha"];
    copyF["PIC4Sched1.alpha"];
    copyF["PIC-struct-sched.alpha"];
    copyF["RapidTestSched.m"];
    recopyF["duce.alpha"];
    copyF["Test1.alpha"];
    copyF["Test1.m"];
    copyF["Test2.alpha"];
    copyF["Test2N.alpha"];
    copyF["Test3.alpha"];
    copyF["Test4.alpha"];
    copyF["Test6.alpha"];
    copyF["Test7.alpha"];
    copyF["TestAffine2.alpha"];
    copyF["TestBug1.alpha"];
    copyF["TestBug2.alpha"];
    copyF["TestDivers.m"];
    copyF["TestDuration2.alpha"];
    copyF["TestDuration.alpha"];
    copyF["TestOptions.m"];
    copyF["TestOrdre2.alpha"];
    copyF["TestRat.alpha"];
    copyF["TestSchedType2.alpha"];
    copyF["TestSchedType.alpha"];
    copyF["TestSchedule.m"];
    copyF["TestScheduleTools.m"];
    copyF["TestscheduleType.alpha"];
    copyF["TestStructSched.m"];
    copyF["TestTime.m"];
    copyF["TestUnbounded2.alpha"];
    copyF["TestUnbounded.alpha"];
    copyF["TestUnion.alpha"];
    copyF["TestUschedule.m"];
    copyF["TestWrong.alpha"];
    copyF["use.alpha"];

    (* -------------------------- *)
    (* tests *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/tests/TestSynthesis";

    (* Set destination directory *)
    destDir = destMMA<>"/tests/TestSynthesis";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /tests\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["fir.alpha"];           (* Needed *)
    copyF["MV1.alpha"];           (* Needed *)
    copyF["samba.alpha"];           (* Needed *)
    copyF["TestSynthesis.m"];           (* Needed *)

    copyDir["tests/TestSemantics"];
    copyDir["tests/TestStatic"];
    copyDir["tests/TestSubSystems"];
    copyDir["tests/TestSubstitution"];
    copyDir["tests/TestTables"];
    copyDir["tests/TestUniformization"];
    copyDir["tests/TestUniformizationTools"];
    copyDir["tests/TestVhdl"];
    copyDir["tests/TestVhdl2"];
    copyDir["tests/TestVisual"];
    copyDir["tests/TestWrite_C"];

    (* -------------------------- *)
    (* lib.darwin *)
    (* Set source directory *)
    sourceDir = sourceMMA<>"/lib.darwin";

    (* Set destination directory *)
    destDir = destMMA<>"/lib.darwin";
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from /lib.darwin\n" ];

    SetDirectory[sourceDir];
    CreateDirectory[destDir];
    copyF["libcodegen.a"];                        (* Needed *)
    copyF["libpoly.a"];                        (* Needed *)
    copyF["libpolymsg.a"];                        (* Needed *)
    copyF["libpolyx.a"];                        (* Needed *)
    copyF["libpretty.a"];                        (* Needed *)


  (* Close content file *)
  Close[ contentFile ];

  Print[" ********* Copy done... "];

  (* Move to current directory *)
  SetDirectory[dir];     
]   
