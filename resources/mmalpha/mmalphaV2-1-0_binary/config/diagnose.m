(* Standard head for CVS

        $Author: quinton $
        $Date: 2008/12/30 18:18:06 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/config/diagnose.m,v $
        $Revision: 1.1 $
        $Log: diagnose.m,v $
        Revision 1.1  2008/12/30 18:18:06  quinton
        A forgotten diagnosis file.


*)

Module[
  { diagnoseFile, pathVariable, mmalphaEnv, osTypeEnv, osTypeMma, 
      versionNumber, testsDomlib, initCount },

  diagnoseFile = OpenWrite[ "~/diagnosis.txt"];
  Print["Executing diagnose.m file in $MMAlpha/config/init.m "];
  WriteString[ diagnoseFile, "Executing diagnose.m file in $MMAlpha/config/init.m\n"];

  mmalphaEnv = Environment[ "MMALPHA" ];
  If[ mmalphaEnv === $Failed, 
    Print["Environment variable MMALPHA is not defined."];
    Print["Alpha cannot be loaded."];
    WriteString[ diagnoseFile, 
      "Environment variable MMALPHA is not defined.\n"];
    WriteString[ diagnoseFile, "Alpha cannot be loaded.\n"];
    Print["--> Solution: set environment variable. See installation manual. Hint: remember not to launch Mathematica directly, but from a console window, as a direct call may not inherit the environment variables."];
    WriteString[ diagnoseFile, "--> Solution: set environment variable. See installation manual.\n"];
    Print["Quitting Mathematica..."];
    WriteString[ diagnoseFile, "Quitting Mathematica..."];
    Close[ diagnoseFile ];
    Quit[]
  ];

  Print["MMALPHA environment variable is ", Environment["MMALPHA"] ];
  WriteString[ diagnoseFile, 
    "\nMMALPHA environment variable is: ", 
    Environment["MMALPHA"], "\n" ];

  (* Checking that MMalpha is installed *)
  If[ FileNames[ mmalphaEnv ] === {}, 
    Print["MMALPHA is not where your MMALPHA environment variable says it should be. Connot proceed further."];
    WriteString[ diagnoseFile, "\nMMALPHA is not where your MMALPHA environment variable says it should be. Connot proceed further.\n"];
    Print["--> Solution: check value of environment variable"];
    WriteString[ diagnoseFile, "--> Solution: check value of environment variable"];
    Print["Quitting Mathematica..."];
    WriteString[ diagnoseFile, "Quitting Mathematica..."];

    Close[ diagnoseFile]; Quit[]
  ,
    Print["MMALPHA is installed."];
    WriteFile[ diagnosefile, "\nMMALPHA is installed\n"]
  ];

  pathVariable = Environment["PATH"];
  Print[ "\nEnvironment path is: ", pathVariable ];
  WriteString[ diagnoseFile, "\nEnvironment path is: " pathVariable, "\n" ];

  osType = Environment["OSTYPE"];
  Print[ "Environment OSTYPE is: ", osType ];
  WriteString[ diagnoseFile, "\nEnvironment OSTYPE is: ", osType, "\n" ];

  osTypeMma = $OperatingSystem;
  Print[ "$OperatingSystem is: ", osTypeMma];
  WriteString[ diagnoseFile, "\n$OperatingSystem is: ", osTypeMma, "\n" ];

  mmaVersion = $Version;
  Print[ "$Version is: ",  $Version ];
  WriteString[ diagnoseFile, "\n$Version is: ",  $Version, "\n" ];

  mmaVersion = $VersionNumber;
  Print[ "Version number is: ",  $VersionNumber ];
  WriteString[ diagnoseFile, "\nVersion number is: ",  $Version, "\n" ];

  baseDirectory = $UserBaseDirectory;
  Print[ "Base directory is : ",  baseDirectory ];
  WriteString[ diagnoseFile, "\nBase directory is: ",  baseDirectory, "\n" ];

  (* Checking path *)
  If[ StringCases[ pathVariable, mmalphaEnv<>"/bin."<>osType ] === {},
    Print["PATH environment variable  should contain ", 
	    mmalphaEnv<>"/bin."<>osType, ". Cannot run MMALPHA"];
    WriteString[ diagniseFile, "\nPATH environment variable  should contain ", 
	    mmalphaEnv<>"/bin."<>osType, ". Cannot run MMALPHA\n"];
    Print["--> Solution: add the proper /bin... directory in $Path."];
    WriteString["--> Solution: add the proper /bin... directory in $Path."];
    Print["Quitting Mathematica..."];
    WriteString[ diagnoseFile, "Quitting Mathematica..."];
    Close[ diagnoseFile]; Quit[]
  , 
    Print["PATH variable is OK"];
    WriteString["\nPATH variable is OK\n"]
  ];

  (* Checking Version Number *)
  If[ mmaVersion <= 4., 
    Print["Mathematica versions older than 4.0 are not supported. Cannot run MMALPHA"];
      WriteString[ diagnoseFile, "\nMathematica versions older than 4.0 are not supported. Cannot run MMALPHA\n"];
    Print["Quitting Mathematica..."];
    WriteString[ diagnoseFile, "Quitting Mathematica..."];
    Close[ diagnoseFile]; Quit[]
  , 
    Print["Version is OK"];
    WriteFile[ diagnosefile, "\nVersion is OK\n"]
  ];

  (* Checking presence of init.m file *)
  Print["Files in base directory:", FileNames["*", baseDirectory<>"/Kernel/"]];
  If[ FileNames["*init.m", baseDirectory<>"/Kernel"] === {},
    Print["There is no init.m file. Cannot run MMALPHA."];
    Print["--> Solution: add an init.m file in directory ", baseDirectory<>"/Kernel"];
    Print["    A possible model is in $MMALPHA/config/init-for-you.m"];
    WriteString[ diagnoseFile, "\nThere is no init file. Cannot run MMALPHA\n"];
    WriteString[ diagnoseFile, "--> Solution: add an init.m file in directory ", baseDirectory<>"/Kernel"];
    WriteString[ diagnoseFile,"    A possible model is in $MMALPHA/config/init-for-you.m"];
    Print["Quitting Mathematica..."];
    WriteString[ diagnoseFile, "Quitting Mathematica..."];
    Close[ diagnoseFile]; Quit[]
  , 
    initCount = ByteCount/.FileInformation[baseDirectory<>"/Kernel/init.m"];
    If[ initCount <= 100, 
	Print["The init.m file contains only ", initCount, " characters",
         "and is likely not a correct init file. Please, check it."];
        WriteString[ diagnoseFile, "\nThe init.m file contains only ", initCount, " characters and is likely not a correct init file. Please, check it.\n"];
	Print["--> Solution: when Mathematica does not find out an init file in this place, it creates one with just one comment. Copy the init file model init-for-you.m in $MMALPHA/config in this place under the name init.m."];
	WriteString[ diagnoseFile, "--> Solution: when Mathematica does not find out an init file in this place, it creates one with just one comment. Copy the init file model init-for-you.m in $MMALPHA/config in this place under the name init.m."];
    ];

    Print["There is an init file. OK."];
    WriteFile[ diagnosefile, "There is an init file. OK."]
  ];

  (* Checking that ReadDom is running *)
  Module[ {d1, d2, dd},
    Check[ 
      d1 = readDom["{i,j|0<=i;j>=0}"];
      d2 = readDom["{i,j|j>=0}"]
    ,
      Print["Could not read domains, ReadDom probably not installed. Cannot proceed further"];
      WriteString[ diagnoseFile, "\nCould not read domains, ReadDom probably not installed. Cannot proceed further\n"];
      Close[ diagnoseFile]; Quit[]
    ];

    If[ !MatchQ[ d1, _Alpha`domain ], 
      Print["Could not read domains, ReadDom probably not installed. Cannot proceed further"];
      WriteString[ diagnoseFile, "\nCould not read domains, ReadDom probably not installed. Cannot proceed further\n"];
      Close[ diagnoseFile]; Quit[]
    ];

    (* Checking that Domlib is running *)
    Check[ 
      dd = DomIntersection[d1,d2];    
    ,
      Print["Could not compute domains. Domlib probably not installed. Cannot proceed further"];
      WriteString[ diagnoseFile, "\nCould not compute domains, Domlib probably not installed. Cannot proceed further\n"];
      Close[ diagnoseFile]; Quit[]
    ];


    (* Checking result *)
    If[ dd =!= domain[2,{"i","j"},{pol[3,3,0,0,
      {{1,1,0,0},{1,0,1,0},{1,0,0,1}},
      {{1,1,0,0},{1,0,1,0},{1,0,0,1}}]}], 
      Print["Domlib probably corrupted. Cannot proceed further"];
      WriteString[ diagnoseFile, "\nDomlib probably corrupted. Cannot proceed further\n"];
      Close[ diagnoseFile]; Quit[]
    ];

    Print["Domlib is installed and running..."];
    WriteString[ diagnoseFile, "\nDomlib is installed and running...\n"];
    Print["Everything seems to be OK"];

  ]; (* End of test of Domlib *)

  (* Testing Pip 
  Run[ "Pip" ];
  Run["echo $PATH"];
  Run["export $BIDON='BBB'; echo $BIDON"];
  *)

  Close[ diagnoseFile ];

]
