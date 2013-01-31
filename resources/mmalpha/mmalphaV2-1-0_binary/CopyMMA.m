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

  (* A useful local function. copyF["fileName"] copies the file fileName from
   directory sourceDir to directory destDir. It therefore assumes that sourceDir
   and destDir have been set *)
  Clear[copyF];
  copyF[n:_String] := copyF[n, sourceDir, destDir];
  copyF[n:_String, sd:_String, dd:_String] := 
  Catch[
    Module[ {},
      Check[
        CopyFile[ sd<>"/"<>n, dd<>"/"<>n ],
        copyF::err = "Could not copy file `1`";
        Throw[ Message[ copyF::err, sd<>"/"<>n ] ]
      ];
      WriteString[ contentFile, "File "<>sd<>"/"<>n<>"\n  was copied into "<>dd<>"/"<>n<>"\n"];
    ]
  ];
  copyF[___] := Print["Argument Error..."];

  (* Another useful function. coyyDir["dirName"] makes a copy if all files in 
   sourceMMA/dirName into destMMA/dirName. It prints the source directory, it also
   writes all files copied into a text file whose name is contentFile. After a full copy,
   it removes the CVS directory. *)
  Clear[copyDir];
  copyDir[n:_String, opts:___Rule] := 
  Catch[
    Module[ {dir, sourced, destd, flag, files, dirs, butFiles, dbg, bizarreFiles},

      (* Save directory *)
      dir = Directory[];
      dbg = debug/.{opts}/.{debug->False};

      (* Get the list of files not to be read *)
      butFiles = fileExceptions/.{opts}/.{fileExceptions->{}};

      (* Set source directory *)
      sourced = sourceMMA<>"/"<>n;

      (* Set destination directory *)
      destd = destMMA<>"/"<>n;
      If[ dbg, Print["Copying ", sourced ] ];
      WriteString[ contentFile, "\n\n*******************\n" ];
      WriteString[ contentFile, "Copying full directory "<>n<>" \n" ];

      If[ dbg, Print["Source directory: ",  sourced ] ];
      If[ dbg, Print["Destination directory: ", destd ] ];
 
      CreateDirectory[ destd ];

      SetDirectory[ sourced ];
      files = FileNames[ ];
      If[ dbg, Print[ files ] ];

      (* Add some special files *)
      bizarreFiles = Select[ files, StringMatchQ[ #, "*.#*" ]& ];
      If[ 
        bizarreFiles =!= {}, 
        WriteString[ contentFile, "In directory: ", sourced, " files : ", bizarreFiles, " were not copied." ] 
      ];
      files = Complement[ files, bizarreFiles ];

      (* Add some special files *)
      bizarreFiles = Select[ files, StringMatchQ[ #, "*~*" ]& ];
      If[ bizarreFiles =!= {}, 
        WriteString[ contentFile, "In directory: ", sourced, " files : ", bizarreFiles, " were not copied." ] 
      ];
      files = Complement[ files, bizarreFiles ];

      (* Remove exceptions *)
      If[ dbg, Print[ "Exception files : ", butFiles ] ];
      files = Complement[ files, butFiles ];

      dirs = Select[ files, DirectoryQ ];
      If[ dbg, Print[ "Files which are directories: ", files ] ];

      files = Complement[ files, dirs, {".cvsignore", ".DS_Store"} ];
      If[ dbg, Print[ "Files to be copied: ",  files ] ];

      Check[
        Map[ copyF[#,sourced,destd]&, files ],
	(* In case of error *)
        copyDir::err = "Error while copying directory";
        SetDirectory[ dir ];
        Throw[ Message[ copyDir::err ] ]
      ];

      SetDirectory[ dir ];

    ]
  ];
  copyDir[x:___] := Print["Argument Error...: ", FullForm[{x}]];

  Catch[
    (* These assignement need to be changed in order 
       to adapt this utilitary *)
    sourceMMA = "/Users/patricequinton/mmalpha";
    destMMA = "/Users/patricequinton/Recherche/Alpha/mmalphaV2-1-0";

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
    (* Version of 2010/04-21 *)
    sourceDir = sourceMMA;
    destDir = destMMA;
    Print["Copying ", sourceDir];
    WriteString[ contentFile, "\n\n****************\n" ];
    WriteString[ contentFile, "Copying from main directory\n" ];

    SetDirectory[sourceDir];

    copyF["CopyMMA.m"];  (* Copy this file to possibly check what was done *)
    copyF["index.html"];
    copyF["README"];
    copyF["content.html"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* bin.cygwin *)
    copyDir["bin.cygwin", debug -> False ];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* bin.cygwin32 *)
    copyDir["bin.cygwin32" ];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* bin.darwin *)
    copyDir["bin.darwin" ];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* bin.linux *)
    copyDir["bin.linux"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* config *)
    copyDir["config"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos *)
    copyDir["demos"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS *)
    copyDir["demos/NOTEBOOKS"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Distances *)
    copyDir["demos/NOTEBOOKS/Distances"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/DLMS *)
    copyDir["demos/NOTEBOOKS/DLMS"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Domlib *)
    copyDir["demos/NOTEBOOKS/Domlib"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Fifo *)
    copyDir["demos/NOTEBOOKS/Fifo"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Fir *)
    copyDir["demos/NOTEBOOKS/Fir"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Getting-started *)
    copyDir["demos/NOTEBOOKS/Getting-started"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Introduction *)
    copyDir["demos/NOTEBOOKS/Introduction"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Matmult *)
    copyDir["demos/NOTEBOOKS/Matmult"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Matvect *)
    copyDir["demos/NOTEBOOKS/Matvect"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Samba *)
    copyDir["demos/NOTEBOOKS/Samba"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/StructuredScheduler *)
    copyDir["demos/NOTEBOOKS/StructuredScheduler"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* demos/NOTEBOOKS/Synthesis *)
    copyDir["demos/NOTEBOOKS/Synthesis"];


    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc *)
    copyDir["doc"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Alphard *)
    copyDir["doc/Alphard"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Dataflow-Schedule *)
    copyDir["doc/Dataflow-Schedule"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Developers *)
    copyDir["doc/Developers"];
    copyDir["doc/Developers/Alpha0v2"];
    copyDir["doc/Developers/Compiling"];
    copyDir["doc/Developers/Scheduler"];
    copyDir["doc/Developers/Write-Read-Alpha"];
    copyDir["doc/Developers/Writing-a-package"];
    copyDir["doc/Developers/Writing-Documentation"];
    copyDir["doc/Developers/Writing-Tests"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Distribution *)
    copyDir["doc/Distribution"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Doc-MMA-Darwin *)
    copyDir["doc/Doc-MMA-Darwin"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Install *)
    copyDir["doc/Install"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Meta *)
    copyDir["doc/Meta"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/packages *)
    (* *************************** *)
    copyDir["doc/Packages"];
    copyDir["doc/Packages/Alpha"];
    copyDir["doc/Packages/ChangeOfBasis"];
    copyDir["doc/Packages/CheckAlphard"];
    copyDir["doc/Packages/CodeGen"];
    copyDir["doc/Packages/Control"];
    copyDir["doc/Packages/Cut"];
    copyDir["doc/Packages/Domlib"];
    (*     copyDir["doc/Packages/MakeDoc"]; *)
    copyDir["doc/Packages/Matrix"];
    copyDir["doc/Packages/Meta"];
    copyDir["doc/Packages/Normalization"];
    copyDir["doc/Packages/PipeControl"];
    copyDir["doc/Packages/Reduction"];
    copyDir["doc/Packages/Schedule"];
    copyDir["doc/Packages/Semantics"];
    copyDir["doc/Packages/Static"];
    copyDir["doc/Packages/StructuredScheduler"];
    copyDir["doc/Packages/Substitution"];
    copyDir["doc/Packages/SubSystems"];
    copyDir["doc/Packages/Tests"];
    copyDir["doc/Packages/ToAlpha0v2"];
    copyDir["doc/Packages/Uniformization"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/PeriodicSystems *)
    copyDir["doc/PeriodicSystems"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Pipeline *)
    copyDir["doc/Pipeline"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/PolyLib *)
    copyDir["doc/PolyLib"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/QuickStart *)
    copyDir["doc/QuickStart"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/ReferenceManual *)
    copyDir["doc/ReferenceManual"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Schedule *)
    copyDir["doc/Schedule"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Synthesis *)
    copyDir["doc/Synthesis"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Technical-Manual *)
    copyDir["doc/Technical-Manual"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Test-Bench *)
    copyDir["doc/Test-Bench"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Tests *)
    copyDir["doc/Tests"];

    (* ************************** *)
    (* To be exploited not copied *)

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Tutorial *)
    copyDir["doc/Tutorial"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* doc/Users *)
    copyDir["doc/Users"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* lib *)
    copyDir["lib"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* lib/Packages *)
    copyDir["lib/Packages"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* lib/Packages/Alpha *)
    copyDir["lib/Packages/Alpha"];

    (* List of files needed 
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

     *)

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* lib/Packages/Alpha/CodeGen *)
    copyDir["lib/Packages/Alpha/CodeGen"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* lib.darwin *)
    copyDir["lib.darwin"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* maintenance *)
    copyDir["maintenance"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources *)
    copyDir["sources"];

    (* BitOperators *)
    (* Not copied *)

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Code_Gen *)
    copyDir["sources/Code_Gen"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Code_Gen/Test *)
    copyDir["sources/Code_Gen/Test"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Domlib *)
    copyDir["sources/Domlib"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/MakeIncludes *)
    copyDir["sources/MakeIncludes"];

    (* sources/Mathlink not copied *)

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Pip *)
    copyDir["sources/Pip"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Pip/piplib-1.3.3 *)
    copyDir["sources/Pip/piplib-1.3.3"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/polylib-5.22.3 *)
    copyDir["sources/polylib-5.22.3"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Pretty *)
    copyDir["sources/Pretty"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Read_Alpha *)
    copyDir["sources/Read_Alpha"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Sed *)
    copyDir["sources/Sed"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Write_Alpha *)
    copyDir["sources/Write_Alpha"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Write_Alpha/Test *)
    copyDir["sources/Write_Alpha/Test"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Write_C *)
    copyDir["sources/Write_C"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* sources/Write_C/Test *)
    copyDir["sources/Write_C/Test"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests *)
    copyDir["tests"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestAlpha *)
    copyDir["tests/TestAlpha"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestAlphard *)
    copyDir["tests/TestAlphard"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestChangeOfBasis *)
    copyDir["tests/TestChangeOfBasis"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodegen *)
    copyDir["tests/TestCodegen"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/Alpha *)
    copyDir["tests/TestCodeGen/Alpha"];    

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/C *)
    copyDir["tests/TestCodeGen/C"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/goodC *)
    copyDir["tests/TestCodeGen/goodC"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/testCholesky *)
    copyDir["tests/TestCodeGen/testCholesky"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/testFile *)
    copyDir["tests/TestCodeGen/testFile"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/testLud *)
    copyDir["tests/TestCodeGen/testLud"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestCodeGen/testLx *)

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestDecomposition *)
    copyDir["tests/TestDecomposition"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestDomlib *)
    copyDir["tests/TestDomlib"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestInstall *)
    copyDir["tests/TestInstall"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestMatrix *)
    copyDir["tests/TestMatrix"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestModularSchedule *)
    copyDir["tests/TestModularSchedule"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestMultiDim *)

    (* "tests/TestNewSchedule" not copied *)


    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestNormalization *)
    copyDir["tests/TestNormalization"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestPip *)
    copyDir["tests/TestPip"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestPipeControl *)
    copyDir["tests/TestPipeControl"];


    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestPipeline *)
    copyDir["tests/TestPipeline"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestSchedule *)
    copyDir["tests/TestSchedule"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestStatic *)
    copyDir["tests/TestSemantics"];
    copyDir["tests/TestStatic"];
    copyDir["tests/TestSubstitution"];
    copyDir["tests/TestSubSystems"];

    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* tests/TestSynthesis *)
    copyDir["tests/TestSynthesis"];
    copyDir["tests/TestTables"];
    copyDir["tests/TestUniformization"];
    copyDir["tests/TestUniformizationTools"];
    copyDir["tests/TestVertexSchedule"];
    copyDir["tests/TestVhdl2"];
    copyDir["tests/TestVhdlTestBench"];
    copyDir["tests/TestVisual"];
    copyDir["tests/TestWrite_C"];


    (* -------------------------- *)
    (* Version of 2010/04/21 *)
    (* VHDL *)
    copyDir["VHDL"];

  ];

  (* Close content file *)
  Close[ contentFile ];

  Print[" ********* Copy done... "];

  (* Move to current directory *)
  SetDirectory[dir];     
]

