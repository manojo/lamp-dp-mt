(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : P. Le Moenner, T. Risset, P. Quinton
   CONTACT : http://www.irisa.fr/api/ALPHA
   COPYRIGHT  (C) INRIA
   
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   (see file : $MMALPHA/LICENSING).

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library(see file : $MMALPHA/LICENSING);
   if not, write to the Free Software Foundation, Inc., 59 Temple
   Place - Suite 330, Boston, MA  02111-1307, USA.   
*)
BeginPackage["Alpha`MakeDoc`", {"Alpha`", "Alpha`Options`"}];

(* Standard head for CVS

	$Author: quinton $
	$Date: 2009/05/22 10:24:37 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/MakeDoc.m,v $
	$Revision: 1.3 $
	$Log: MakeDoc.m,v $
	Revision 1.3  2009/05/22 10:24:37  quinton
	May 2009
	
	Revision 1.2  2008/12/29 17:35:52  quinton
	Minor corrections.
	
	Revision 1.1  2008/07/27 13:29:56  quinton
	Most recent version.
	
	Revision 1.16  2004/12/29 09:58:02  quinton
	Minor correction.
	
	Revision 1.15  2004/09/16 13:40:54  quinton
	Updated documentation
	
	Revision 1.14  2004/08/02 13:20:42  quinton
	Documentation updated for reference manual
	
	Revision 1.13  2004/06/14 16:37:19  quinton
	Extensions of doDoc and makeDoc
	
	Revision 1.12  2004/06/09 15:30:11  quinton
	Minor corrections.
	
	Revision 1.11  2004/01/09 16:51:07  quinton
	Updated version, including better Latex generation. Not completely tested.
	
	Revision 1.10  1999/05/10 14:56:21  alpha
	 changed things for docs
	
	Revision 1.9  1999/05/10 13:14:13  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.8  1999/03/02 15:49:20  risset
	added GNU software text in each packages
	
	Revision 1.7  1997/05/19 10:41:07  risset
	corrected exported bug in depedancies

	Revision 1.6  1997/05/13 14:48:58  alpha
	modif of some usages

	Revision 1.5  1997/05/13 12:29:27  alpha
	 little things

	Revision 1.4  1996/06/24 13:54:39  risset
	added standard head comments for CVS



*)
MakeDoc::usage =
"MakeDoc is a package which contains functions for the automatic
creation of a reference Manual. MakeDoc contains functions doDoc and
makeDoc.";

MakeDoc::note =
"Functions of MakeDoc read all usage and note statements of a
package, and for each one, they produce a Latex macro entry alphausage or
alphanote. Before creating an entry, substitutions are performed on
the text, so that special words (such as $schedule) and special
characters (such as _) are transformed. The substitution list is in
the private variable repRules in the file MakeDoc.m.";

doDoc::usage =
"doDoc[ package, texFile ] generates in file texFile the documentation
LaTex file associated to a Mathematica file package. doDoc extracts
the information contained in the usage and note descriptions placed at
the beginning of file package, and produces an output Latex file.
doDoc[ package ] automatically writes in a file which has the name 
package where the .m suffix is replaced by .tex. 
doDoc[ Package, functionList ] generates the documentation only for 
the functions enumerated in functionList (as Strings). doDoc has 
options fullLatex and callFile which allow a complete latex file, 
resp. a calling Latex file to be produced. If there exists a file
incl-textFile in the target directory, then a Latex input statement is
added in the documentation package.";

fullLatex::usage = 
"fullLatex is an option of doDoc and makeDoc. Default value is
False. If True, the latex file contains the preamble and the
\\end{document} statement.  Otherwise, it should be used in an input
file";

targetDir::usage = 
"option of doDoc. By default, it is \"\". Gives the name of a directory
where the latex file and the calling latex file should be written.";

callFile::usage = 
"callFile is an option of doDoc and makeDoc. Default valus is False.
If True, a latex calling file is created.";

sourceDir::usage = 
"option of makeDoc. Default value is Null. If Null, the source package
are those of $MMALPHA. Their names are in the file $MMALPHA/sources/
MaleDoc/List_modules. Otherwise, these names are prefixed by the 
value of the sourceDir option.";

(*
makeDoc::usage=
"(see makeDoc::note).
makeDoc[ filelist ] generates a latex documentation file from all the
packages indicated in file filelist. One .tex file is generated for
each .m file using doDoc[]. If the .tex file already exists, 
makeDoc replaces it only if it is older than the .m file.
makeDoc[\"clean\"] removes all the .tex doc files.  makeDoc[\"export\"]
builts a special documentation for external users.  makeDoc[] take as
input file the file: MMALPHA/sources/MakeDoc/List_modules which
contains the List of existing packages."
*)

makeDoc::usage = 
"This function does not work, currently. Use doDoc instead.
makeDoc[] updates the Reference Manual of MMAlpha by running 
the file genReferenceManual.m in directory\n
$MMALPHA/doc/ReferenceManual/\n
This produces new versions of the latex files describing the 
packages. The Reference Manual can be produced using Latex on 
referenceManual.tex. See also doDoc."; 

Begin["`Private`"]

Options[doDoc] = { debug->False, verbose -> False, fullLatex -> False, 
  callFile -> False, targetDir->"" }

Options[makeDoc] = { debug->False, verbose -> False, 
  sourceDir->Null }

(* 
  Automatic generation of technical documentation of MMAlpha 
  packages.
  authors : Patricia Le Moenner, Tanguy Risset, Patrice Quinton
*)

    repRules = 
    {
      "MMAlpha" -> "\\MMAlpha{}",
      "MmAlpha" -> "\\MMAlpha{}",
      "$schedule" -> "\$schedule",
      "$scheduleDepTable" -> "\$scheduleDepTable",
      "$scheduleLibrary" -> "\$scheduleLibrary",
      "$scheduleMDSol" -> "\$scheduleMDSol",
      "$program" -> "\$program",
      "$result" -> "\$result",
      "$library" -> "\$library",
      "$MMALPHA" -> "\$MMALPHA",
      "$testDirectory" -> "\$testDirectory",
      "$testResult" -> "\$testResult",
      "$testIdentifier" -> "\$testIdentifier",
      "$testReportFile" -> "\$testReportFile",
      "$rootDirectory" -> "\$rootDirectory",
      "$tmpDirectory" -> "\$tmpDirectory",
      "$demoDirectory" -> "\$demoDirectory",
      "$masterNotebook" -> "\$masterNotebook",
      "$myNotebooks" -> "\$myNotebooks",
      "$myMasterNotebook" -> "\$myMasterNotebook",
      "$runTime" -> "\$runTime",
      "$depCone" -> "\$depCone",
      "$dependencyConstraints" -> "\$dependencyConstraints",
      "$optimalityConstraints" -> "\$optimalityConstraints",
      "$coneList" -> "\$coneList",
      "$Failed" -> "\$Failed",
      "$vhdlCurrent" -> "\$vhdlCurrent",
      "$vhdlOutputFile" -> "\$vhdlOutputFile",
      "$vhdlPatternsDir" -> "\$vhdlPatternsDir",
      "$showGraph" -> "\$showGraph",
      "->" -> "$ \\rightarrow $",
(*      "\$"->"\\\$",  *)
      "\^"->"\\verb+^+",
      "^"->"\^",
      "_"->"\\_",
      "~"->"\\verb+~+",
      "&"->"\&",
      "%"->"\%",
      ">"->"$>$",
      "<"->"$<$",
      "|"->"$|$",
      "\\"->"\\\\",
(*
      "\n" -> "\\\\",
*)
      "{"->"\{",
      "}"->"\}",
      "$P" -> "\$P"
    };   

rootDir = Environment["MMALPHA"];

If[
  rootDir===$Failed,
  Print["? Environment variable MMALPHA is not defined."];
  Quit[]
];

(*********************************************************************)
(* string is the whole name of a Mathematica package                *)
(* PackageQ answers whether the package name ".m" is suffixed  or not*)
(*********************************************************************)
Clear[ packageQ ];
packageQ[ string_ ] := 
  Module[{length,suffix},
	 length = First[ Last[ StringPosition[ string , "." ] ] ];
	 suffix = StringDrop[ string , length - 1 ];
	 Equal[ suffix , ".m" ]
       ];
packageQ[___] := Message[ packageQ::params ];


(*********************************************************************)
(* expr is a Mathematica expression                                  *)
(* endDeclarationQ answers whether the declaration of the package    *)
(* studied is ended or not                                           *)
(*********************************************************************)
Clear[ endDeclarationQ ];
endDeclarationQ[ expr_ ] := 
  (StringMatchQ[ ToString[ expr ] , "*`Private`*" ] ||
   StringMatchQ[ ToString[ expr ] , "*`private`*" ])
endDeclarationQ[___] := Message[ endDeclaration::params ];

(*********************************************************************)
(* string is the whole name of a Mathematica package                 *)
(* extractPackageName extracts the localName (in its directory) of   *)
(* the package and drops its ".m" suffix                             *)
(*********************************************************************)

Clear[ extractPackageName ];
extractPackageName[ string_ ] := 
Module[{length,localName,name},
(*
  length = First[ Last[ StringPosition[ string , "/" ] ] ];
  localName = StringDrop[ string , length ];
  name = StringTake[ localName , ( StringLength[ localName ] - 2 ) ]
  name = ToLowerCase[StringTake[name,1]]<>StringDrop[name,1]
*)
  name = StringReplace[ StringDrop[ string, -2 ], "/"->"`" ]<>"`"
];
extractPackageName[___] := Message[ extractPackageName::params ];

(*********************************************************************)
(* fileName is the name of the latex file to generate                *)
(* createLatexHeader creates the latex file 's header. It includes   *)
(* the latex macros used to format the documentation informations.   *)
(*********************************************************************)
Clear[ createLatexHeader ];
createLatexHeader[ fileName_ ] := 
Module[{header, hdrFile},
  hdrFile = Environment["MMAlpha"]<>"/doc/packages/MakeDoc/header.tex";

  OpenRead[ hdrFile ];
  line = Read[ hdrFile, String ];
  While[ 
    line =!= EndOfFile,
    WriteString[ fileName, line, "\n" ];
    line = Read[ hdrFile, String ]
  ]
];
createLatexHeader[___] := Message[ createLatexHeader::params ];

(*********************************************************************)
(* fileName is the name of the latex file to generate                *)
(* createEndLatex includes the latex instructions ending the file    *)
(*********************************************************************)
Clear[ createEndLatex ];
createEndLatex[ fileName_ ] := 
  Module[{endingText},
	 endingText = 
	   StringJoin[
	     "\n\\printindex\n" , \
	     "\\end{document}" , \
	     "\n" ];
	 WriteString[ fileName , endingText ]
       ];

createEndLatex[a___]:=(createEndLatex[createLatexSection::WrongArg,a];Throw["ERROR"]);

(*********************************************************************)
(* FUNCTIONS DEALING WITH GENERATION OF LATEX SECTIONS               *)
(* A section is associated to a Mathematica package                  *)
(*********************************************************************)

(*********************************************************************)
(* fileName is the name of the latex file to generate                *)
(* sectionTitle is the name of the studied Mathematica package       *)
(* creates a latex command \section{sectionTitle} in the latex file  *)
(*********************************************************************)

Clear[ createLatexSection ];
createLatexSection[ fileName_ , sectionTitle_ ] :=
  Module[{text},
    text = 
      StringJoin[
        "% Section header\n",
(*        "\n" , *)
        "\\section{The ",
        sectionTitle, 
        " package ",
        "} \n"
      ];
    (* Write a section *)
    WriteString[  fileName , text ];
    (* Write a label *)
    WriteString[  fileName, "\\label{label:"<>sectionTitle<>"}\n" ]
  ];
createLatexSection[a___]:=(Message[createLatexSection::WrongArg,a];Throw["ERROR"])

(*********************************************************************)
(* FUNCTIONS DEALING WITH TREATMENT OF ::usage MATHEMATICA  COMMENTS *)
(* This type of comment is associated to a Latex macros named        *)
(* \alphausage which takes 3 parameters                              *)
(*********************************************************************)

(*********************************************************************)
(* expr is a string readen from the studied Mathematica package      *) 
(* usageQ tests whether or not its argument contains the pattern     *)
(* "::usage"                                                         *)
(*********************************************************************)
 
Clear[ usageQ ];
usageQ[ expr_ ] := 
  StringMatchQ[ ToString[expr] , "*::usage*" ];
usageQ[___] := Message[ usageQ::params ];

(*********************************************************************)
(* fileName is the name of the latex file to generate                *)
(* expr is a string readen from the studied Mathematica package      *)
(* packageName is the name of the studied Mathematica package        *) 
(* usageInformations extracts from expr the worthly informations to  *)
(* fill the fields of the \alphausage latex macro                    *)
(*********************************************************************)
Clear[ usageInformations ];
usageInformations[ fileName:_String , expr_ , packageFileName:_String, 
  packageName:_String, 
  opts:___Rule ] :=  
  usageInformations[ fileName , expr , packageFileName, packageName , {}, opts];

usageInformations[ fileName:_String , expr_ , packageFileName: _String, 
  packageName:_String , 
  functionList:_List, opts:___Rule ] :=  
Module[{limit1,limit2,result,string,secName,secText,dbg},
  dbg = debug/.{opts}/.{debug->False};
  If[ dbg, Print[ FullForm[ expr ] ] ];
  (* Get the Set part of the usage expression *)
  string = Cases[ expr, 
    HoldPattern[Set[MessageName[x:_,"usage"],s:_]]:>{ToString[HoldForm[x]],s}, Infinity];
  string = First[ string ];
  secName = First[string];
  secText = Last[string];

  If[ dbg, Print[ "Section name : ", secName ] ];
  If[ dbg, Print[ "Section text : ", secText ] ];

  If[ (functionList =!= {}) &&  !(MemberQ[functionList,secName]),
    result = "",
(*
    secText = 
      StringReplace[secText, "\n"->"\\\\\n" ];
*)
    secName = StringReplace[ secName, repRules ];
    secText = StringReplace[ secText, repRules ];
    If[ dbg, Print[ "Section text : ", secText ] ];
    result = 
(*
    Do not generate package 
      If[secName===packageName,
        StringJoin["\\packageusage{", secName,"}{",secText,"}\n\n"],
*)
    StringJoin[ 
      "\\alphausage{", secName,"}{",secText,"}{",packageFileName, "}{", packageName,"}\n",
      "\\index{",secName,"}\n\n"
    ];
(*
      ];
*)
    If[ dbg, Print[ "Result : ", result ] ];
  ];
  WriteString[ fileName , result ]
];
usageInformations[a___]:=(Message[usageInformations::WrongArg,a];Throw["ERROR"])


(*********************************************************************)
(* FUNCTIONS DEALING WITH TREATMENT OF ::note MATHEMATICA  COMMENTS  *)
(* This type of comment is associated to a Latex macros named        *)
(* \alphanote which takes 2 parameters                               *)
(*********************************************************************)

(*********************************************************************)
(* expr is a string readen from the studied Mathematica package      *) 
(* noteQ tests whether or not its argument contains the pattern      *)
(* "::note"                                                          *)
(*********************************************************************)

Clear[ noteQ ];
noteQ[ expr_ ] := 
  StringMatchQ[ ToString[ expr ] , "*::note*" ];
noteQ[___] := Message[ noteQ::params ];

(*********************************************************************)
(* fileName is the name of the latex file to generate                *)
(* expr is a string read from the studied Mathematica package      *)
(* noteInformations extracts from expr the useful informations to    *)
(* fill the fields of the \alphausage latex macro                    *)
(*********************************************************************)
Clear[ noteInformations ];
noteInformations[ fileName:_String , expr_, opts:___Rule ] :=  
  noteInformations[ fileName , expr, {}, opts ];

noteInformations[ fileName:_String , expr_ , 
  functionList_List, opts:___Rule ] :=  
Module[{limit1,limit2,result,string,dbg},
  dbg = debug/.{opts}/.{debug->False};
  If[ dbg, Print[ FullForm[ expr ] ] ];

  (* Get the Set part of the usage expression *)
  string = Cases[ expr, 
    HoldPattern[Set[MessageName[x:_,"note"],s:_]]:>{ToString[HoldForm[x]],s}, Infinity];
  string = First[ string ];
  secName = First[string];
  secText = Last[string];

  If[ dbg, Print[ "Section name : ", FullForm[secName] ] ];
  If[ dbg, Print[ "Section text : ", FullForm[secText] ] ];

  If[ (functionList =!= {}) &&  !(MemberQ[functionList,secName]),
    result = "",
(*
    secText = 
      StringReplace[secText, "\n"->"\\\\\n" ];
*)
    secName = StringReplace[ secName, repRules ];
    secText = StringReplace[ secText, repRules ];
    If[ dbg, Print[ "Section text : ", secText ] ];
    result = 
    StringJoin[ 
      "\\alphanote{" , 
      secName,
      "}{" , 
      secText,
      "} \n \n" ];
    If[ dbg, Print[ "Result : ", result ] ];
  ];
  WriteString[ fileName , result ]
];
noteInformations[a___]:=(Message[noteInformations::WrongArg,a];Throw["ERROR"])

(*********************************************************************)
(* FUNCTIONS DEALING WITH TREATMENT OF A WHOLE MATHEMATICA  PACKAGE  *)
(*********************************************************************)

(*********************************************************************)
(* packageFileName is the package name                                         *)
(* fullName is the LaTex file name                                      *)
(* packageBodyTreatment makes the documentation file from the        *)
(* comment section of the Mathematica package                        *)
(*********************************************************************)
Clear[ packageBodyTreatment ];
packageBodyTreatment[ packageFileName:_String, fullName:_String, 
  includeName:_String,
  opts:___Rule ] := 
  packageBodyTreatment[packageFileName,fullName,includeName,{},otps];

packageBodyTreatment[ packageFileName:_String, fullName:_String, 
  includeName:_String,
  functionList:_List, opts:___Rule ] := 
Module[{fileStream, packageName, expr,dbg},

  dbg = debug/.{opts}/.{debug->False};

  (* Open package file *)
  fileStream = OpenRead[ packageFileName ];
  If[ fileStream === $Failed, Return[] ];
		    
  packageName = extractPackageName[ packageFileName ]; 

  If[ dbg, Print[ "Package name: ", packageName ] ];
  createLatexSection[ fullName , packageName ];
  If[ dbg, Print[ "Section created" ] ];
  If[ includeName =!= "", 
    WriteString[ fullName, "\\input{"<>includeName<>"}\n" ]
  ];
  If[ dbg, Print[ "Input created" ] ];

  expr = ""; 
  While[
    expr=!=EndOfFile && !endDeclarationQ[ expr ],     

    (* Read one expression from input file *)
    expr = Read[ fileStream , HoldForm[ Expression ] ];

    (* If this is a usage, then call usageInformations *)
    If[	usageQ[ expr ] , 
      usageInformations[ fullName , expr , packageFileName, packageName, functionList, opts ] 
    ];

    (* If this is a note, then call note *)
    If[ noteQ[ expr ] ,
      noteInformations[ fullName , expr, functionList, opts ] 
    ];

  ]; 
  Close[ fileStream ]; 
];
packageBodyTreatment[a___]:=(Message[packageBodyTreatment::WrongArg,a];
  Throw["ERROR"])

(*
  packageName is the package name
  latexName is the LaTex file name
  packageTreatment generates the documentation LaTex file related
  to a Mathematica package
  the Header and End have been commented by tabguy        
*)
Clear[ packageTreatment ];
(* No file list *)
packageTreatment[ 
  packageName:_String, 
  latexName:_String, opts:___Rule ] :=
  packageTreatment[ packageName, latexName, {}, opts ];

(* Everything given *)
packageTreatment[ 
  packageName:_String, 
  latexName:_String, 
  functionList:_List, 
  opts:___Rule ] :=
Catch[
  Module[ 
    {commentFile, fl, cf, callFileName, callFileNumber, fullName,
     dbg, dirName, includeName, includePath},
    (* Option callFile *)
    cf = callFile/.{opts}/.Options[ doDoc ];
    dbg = debug/.{opts}/.Options[ doDoc ];
    dirName = targetDir/.{opts}/.Options[ doDoc ];

    (* Option fullLatex. Cannot be True if callFile option set *)
    fl = !cf && fullLatex/.{opts}/.Options[ doDoc ];

    (* fullName is the name of the latex file, with the directory 
       prepended *)
    fullName = If[ dirName =!="", dirName<>"/"<>latexName, latexName ];
    (* callFileName is the name of the calling latex file *)
    callFileName = If[ dirName =!="", dirName<>"/call"<>latexName, 
      "call"<>latexName ];
    (* includeName is the name of latex file to be included if there
    exists one in the directory dirName *)
    includeName = "incl-"<>latexName;
    includePath = If[ dirName =!="", dirName<>"/incl-"<>latexName, 
      "incl-"<>latexName ];
    If[ dbg, 
      Print[ "Package name: ", packageName, "\nLatex Name: ", latexName,
        "\nDirName: ", dirName, "\nFull name: ", fullName ] 
    ];

    (* Open Latex file *)
    Check[ 
      commentFile = OpenWrite[ fullName ],
      packageTreatment::openerr = "could not open file `1`";
      Throw[ Message[ packageTreatment::openerr, fullName ] ]
    ];

    (* Add info *)
    WriteString[ commentFile, 
      "%\n% File created on "<>ToString[Date[]]<>" by "<>
      "makeDoc.\n%\n"]; 

    (* Open calling file *)
    If[ cf, 
      Check[ 
        callFileNumber = OpenWrite[ callFileName ],
        packageTreatment::openerr = "could not open file `1`";
        Throw[ Message[ packageTreatment::openerr, callFileName ] ]
      ]
    ];

    (* Put header in calling file *)
    If[ cf, 
      WriteString[ callFileName, 
        "%\n% File created on "<>ToString[Date[]]<>" by "<>
        "makeDoc.\n%\n"]; 
      createLatexHeader[ callFileName ];
      (* Add input latex file *)
      WriteString[ callFileName, "\\input{"<>latexName<>"}\n" ];
      WriteString[ callFileName, "\\printindex\n"];
      WriteString[ callFileName, "\\end{document}\n" ]
    ];
    
    (* If a full latex file is needed, put header *)
    If[ fl, createLatexHeader[ fullName ] ];

    (* Look if there exists an include name, and if so, add the 
       input command *)
    If[ !FileInformation[ includePath ] =!= {}, 
      (* file does not exist, if so, set it to "" *)
      includeName = ""
    ];

    packageBodyTreatment[ packageName , fullName, includeName,
      functionList, opts ];

    (* Idem end of file *)
    If[ fl, createEndLatex[ fullName ] ];
    Close[ commentFile ];
    If[ cf, Close[ callFileNumber ] ]
  ]
];
packageTreatment[a___]:=(Message[packageTreatment::WrongArg,a];
  Throw["ERROR"])

(*********************************************************************)
(* FUNCTION CALLED BY THE MATHEMATICA  USER TO GENERATE              *)
(* AUTOMATICALLY DOCUMENTATION FILES FROM A MATHEMATICA PACKAGE      *)
(*********************************************************************)

(*********************************************************************)
(* packageName is a package name                                           *)
(* by default, doDoc generates the associated documentation LaTex    *)
(* file of the Mathematica package                                   *)
(* its name is constituted from the package name : the .m suffix is  *)
(* substituted by .tex                                               *)
(*********************************************************************)
Clear[doDoc];
(* No latex file, no function list given *)
doDoc[ packageName:_String, opts:___Rule ]:= 
  doDoc[ packageName, {},opts];

(* No latex file, function list *)
doDoc[ packageName_String , 
  functionList:_List, opts:___Rule ]:=
  doDoc[ packageName , 
(*
  extractPackageName[ packageName ]<>".tex", 
*)
  StringDrop[packageName,-2]<>".tex",
  functionList, opts ];

(* 
  package name give, latex name given, no function list
*)
doDoc[ 
  packageName:_String , 
  latexName:_String, opts:___Rule ] := 
doDoc[ packageName , latexName, 
  {}, opts ];
       
doDoc[ packageName:_String , latexName:_String, functionList_List, opts:___Rule ] := 
Catch[
  Module[ { },
    If[ !packageQ[ packageName ],
      Print[ "file should end with .m" ] ;
      Throw["ERROR"],
      Check[ 
        packageTreatment[ packageName, latexName, functionList, opts ],
        Throw[ Null ]
      ];
    ]
  ]
];
doDoc[a___]:=(Message[doDoc::WrongArg,a];Throw["ERROR"]);

(*
  New form of makeDoc 
*)
Clear[makeDoc];
makeDoc[] := 
Module[ 
    {dir,docdir},
  dir = Directory[];
  docdir = setMMADir[{"doc", "ReferenceManual"}];
  Print["-- Updating Reference Manual in ",docdir];
  Get["genReferenceManual.m"];
  Print["-- Done. Run Latex2e on referenceManual.tex"];
  SetDirectory[dir];
];
makeDoc[___] := Message[makeDoc::params];

(* Obsolete form 

(*********************************************************************)
(* makedoc[FileList_String]                                          *)
(* make the documentation (with doDoc) for all the modules present   *)
(* in the file FileList. The documentation is updated if it is already*)
(* present                                                           *)
(* The default fileList is "List_modules"                            *)
(* makeDoc["clean"] remove all the .tex file of the doc              *)
(********************************************************************)

Clear[makeDoc];

makeDoc[opts:___Rule] := 
  makeDoc[rootDir<>"/sources/MakeDoc/List_modules", opts];

makeDoc[fich1:_String, opts:___Rule] :=
Module[
  {listExport, sDir},

  (* This is a list of the files that are to be exported *)
  listExport=
  {(* Alpha.m *)
    "load","show","ashow","save","asave","asaveLib",
    "getSystem","putSystem","writeC","writeTex",
    "readExp","readDom","readMat","$program",
    "$result","$library","$schedule",
    (* Domlib.m *)
    "DomAddRays", "DomEmptyQ", "DomEqualities",
    "DomSimplify", "DomConstraints",   "DomEqualQ",
    "DomPreimage", "DomUnion", "DomConvex", "DomExtend", 
    "DomUniverse",  "DomImage", "DomProject", 
    "DomUniverseQ", "DomDifference",  "DomIntersection",
    "DomRays",  "DomEmpty",
    (* Matrix.m *) 
    "translationMatrix","composeAffines","inverseMatrix",
    "unimodularQ","translationQ","identityQ",
    "inverseInContext","idMatrix","unimodularCompletion",
    "smithNormalForm","hermite","hermiteL","hermiteR",
    "solveDiophantine",
    (* Tables.m *)
    "getVariables","getLocalVars","getInputVars",
    "getOutputVars","getDeclaration","getDefinition",
    "getEquation",
    (* Static.m *)
    "analyze","dep","checkUseful",
    (* semantics *)
    "expType","expDimension","expDomain","getPart",
    "getContextDomain",
    "addAllParameterDomain",
    (* Schedule.m *)
    "schedule",
    (* ScheduleTool *)
    "applySchedule","showSchedResult",
    (* MultiDim *)
    "multiSched",
    (* Visual.m *)
    "showDomain",
    (* Subsystems.m *)
    "inlineSubsystem","inlineAll","assignParameterValue",
    "removeIdEqus",
    (* Demos *)
    "goDemo",
    (* Cut.m *)
    "cut",
    (* Substitution.m *)
    "replaceDefinition","substituteInDef","unusedVarQ",
    "removeUnusedVar","removeAllUnusedVar","addlocal",
    (* ChangeOfBasis.m *)
    "changeOfBasis",
    (* Decomposition.m *)
    "decompose",
    (* Merge.m *)
    "merge","mergeCaseBranches",
    (* Normalization.m *)
    "normalize","normalize0","normalizeDef","normalizeDef0",
    (* Pipeline.m *)
    "pipeline","pipeall","pipeIO",
    (* Reduction.m *) 
    "serializeReduce",
    (* Control.m *)
    "spaceTimeCase","needsMuxQ","makeMuxControl",
    "controlVars",
    (* PipeControl.m *) 
    "pipeControl",
    (* Transformation *)
    "EquationSpatTemp",
    (* ToAlpha0v2.m  *)
    "toAlpha0v2","makeSimpleExpr","decomposeSTdeps",
    "makeInputMirrorEqs",
    (* Alphard  *)
    "alpha0ToAlphard",
    (* Vhdl.m  *)
    "alphaToVHDL"
  };

  (* *)

  Print[ "fich1: ", fich1 ];

  Switch[ fich1,
    "clean",
      makeDoc[rootDir<>"/sources/MakeDoc/List_modules",1,{}, opts]
  ,
    "export",
      makeDoc[rootDir<>"/sources/MakeDoc/List_modules",0, listExport, opts];
      Print["\n\nThe latex Document file is in the directory\n$MMALPHA/sources/MakeDoc/exportModuleDoc.tex "];
  ,
     _,
     makeDoc[fich1,0,{}, opts];
     Print["\n\nThe latex Document file is in the directory\n$MMALPHA/sources/MakeDoc/moduleDoc.tex "];
  ]
];
doDoc::file = " file `1` is not a .m file" 

makeDoc[ fich1_String, option_Integer, functionList_List, opts:___Rule ]:=
  Module[{fileStream,name,cond,length,suffix,prefix,compt,fullFile,sDir,
	 tDir},
    (* fileStream  list of modules *)
    (* name : complete name of module (with directory)*)
    (* cond : boolean 1 if the .tex should be updated *)
    (* for the current module                       *)
    (* prefix: complete name of the module without  *)
    (*         the ".m" at the end                  *)
		 
  (* The source directory, if not specified, will be $MMALPHA *)
  sDir = sourceDir/.{opts}/.Options[makeDoc];
  tDir = targetDir/.{opts}/.Options[makeDoc];
  Print["Target dir is ", tDir]; 

  sDir = If[ sDir === Null, Environment["MMALPHA"] ];
  Print[ "Source Dir: ", sDir ];
  If[ tDir =="", tDir = sDir ];

  If[ option==1,Print["Cleaning"]];
    (* Opening file which contains files to be documented *)
    fileStream = OpenRead[fich1]; 
    compt=0;
    (* Get file name *)
    name = Read[fileStream,String];
    While[ name=!=EndOfFile,
      (* Depends on target directory *)
      name = tDir<>name;
      length = First[Last[StringPosition[name,"."]]];
      suffix = StringDrop[name , length - 1];
      If[!Equal[suffix,".m"],Message[doDoc::file,name]];
        prefix = StringDrop[name,-2];
        cond = 0;
        If[ FileType[(prefix<>".tex")] === None,
          cond=1,(* .tex does not exists *)
          list1 = Drop[FileDate[name],-1];
          list2 = Drop[FileDate[prefix<>".tex"],-1];
          If[ ((list1[[1]]>list2[[1]]) ||
              ((list1[[1]]===list2[[1]])&&
               (list1[[2]]>list2[[2]])) ||
              ((list1[[1]]===list2[[1]])&&
              (list1[[2]]===list2[[2]])&&
              (list1[[3]]>list2[[3]])) ||
              ((list1[[1]]===list2[[1]])&&
              (list1[[2]]===list2[[2]])&&
              (list1[[3]]===list2[[3]])&&
              (list1[[4]]>list2[[4]])) ||
              ((list1[[1]]===list2[[1]])&&
              (list1[[2]]===list2[[2]])&&
              (list1[[3]]===list2[[3]])&&
              (list1[[4]]===list2[[4]])&&
              (list1[[5]]>list2[[5]]))) ,
            cond=1, (* .tex is older than .m *)
            cond=0
          ]
        ];
        If[ cond==1,
          Print["\nDoc Update: "<>name];
          If[ !(FileType[(prefix<>".tex")] === None),	
             ToExpression["!(\\rm -f "<>prefix<>".tex"<>")"]
          ]; 
          compt=compt+1;
          Print["Calling doDoc"];
          Print[prefix];
          doDoc[ name, prefix<>".tex", functionList, opts];
        ];
        If[ option==1,
          Print["removing "<>prefix<>".tex"];
          DeleteFile[ prefix<>".tex" ];
(*
          ToExpression["!(\\rm -f "<>prefix<>".tex"<>")"]
*)
        ];
        name = Read[fileStream,String];
      ];
    If[ compt==0,Print["\nDoc Up to Date"]
    ];
];
*)
makeDoc[a___]:=(Message[makeDoc::WrongArg,a];Throw["ERROR"])

End[]
EndPackage[]



