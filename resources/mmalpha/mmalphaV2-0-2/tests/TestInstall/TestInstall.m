BeginPackage["Alpha`TestInstall`",
  {"Alpha`","Alpha`Domlib`","Alpha`Options`","Alpha`Static`"}];

Begin["`Private`"];

$testResult = True; 

Module[ {res,file,globalres,path},

globalres =
{
  testFunction[
    res = True;
    Check[
      Close[ $testReportFile ]; 
      $testReportFile = OpenWrite[ Environment["MMALPHA"]<>
       "/tests/TestingReport.txt"],
      res = False
    ];

    If[ res, 
      WriteString[ $testReportFile, "Test report file was cleaned" ];
      WriteString[ $testReportFile, "\nDate: ", DateString[] ];
      WriteString[ $testReportFile, "\nEntering installation test" ],
      Print[ "Could not open file $testReportFile" ]
    ];
    res,
    True,
    "Install 1"
  ]
,
  testFunction[
    res = MatchQ[Environment["MMALPHA"],_String];
    If[ res, 
      WriteString[ $testReportFile, "\nMMALPHA is set to: ", 
        Environment["MMALPHA"]],
      WriteString[ $testReportFile, "\nMMALPHA improperly set" ];
      Throw[ res = False ]
    ];
    res,
    True,
    "Install 2"
  ]
,
  testFunction[
    res = Cases[ Links[], LinkObject["domlib",__] ];
    Print[ res ];
    Which[ 
      res === {},
      WriteString[ $testReportFile, "\ndomlib not open"]; res = False,
      Length[ res ] > 1,
      WriteString[ $testReportFile, "\nseveral domlib are open" ]; 
        res = False,
      Length[ res ] === 1,
        WriteString[ $testReportFile, "\ndomlib open in link: ", res[[1]] ]; 
        res = True
    ];
    res,
    True,
    "Install 3"
  ]
,
  testFunction[
    res = True;
    Check[
      path = Environment["PATH"],
      res = False
    ];

    If[ res, 
      WriteString[ $testReportFile, "\nPATH environment set" ],
      Print[ "\nCould not get Path environment variable" ]
    ];
    res,
    True,
    "Install 4"
  ]
,
  testFunction[
    WriteString[ $testReportFile, "\nOS Type: ", Environment["OSTYPE"] ];
    WriteString[ $testReportFile, "\nOperating system: ", $System ];
    WriteString[ $testReportFile, "\nOperating system: ", $OperatingSystem ];
    WriteString[ $testReportFile, "\nMMA Version: ", $Version ];
    WriteString[ $testReportFile, "\nMMA Version number: ", $VersionNumber ];
    WriteString[ $testReportFile, "\nLaunch directory: ", $LaunchDirectory ];
    WriteString[ $testReportFile, "\nHome directory: ", $HomeDirectory ];
    WriteString[ $testReportFile, "\nPath: ", $Path ];
    True,
    True,
    "Install 5"
  ]
,
  testFunction[
    With[ {basedir = $UserBaseDirectory<>"/Kernel", dir = Directory[]},
      SetDirectory[ basedir ];
      res = FileNames[];
      Print[ res ];
      If[ MemberQ[ res, "init.m"], res = True, 
        WriteString[ $testReportFile, 
          "\nthere is no init.m file in the base directory ", basedir ]; 
        res = False 
      ]; 
      SetDirectory[ dir ]; 
      ];
    res,
    True,
    "Install 6"
  ]

    };

  $testResult = $testResult && Apply[And,res];

];

End[];

EndPackage[];
