BeginPackage["Alpha`SystemProgramming`", {"Alpha`Domlib`",
				"Alpha`"}]

(* 
makeDoc::usage = 
"makeDoc[ package ] generates a latex file in directory 
$MMAlpha/doc/packages/package .";
*)

SymbolsInContext::usage = 
"SymbolsInContext[\"context`\"] gives a HoldList of all symbols in
context.";

HoldList::usage = 
"HoldList[element..] is a list that does not evaluate its elements.
Mapping a function over its elements turns it into an ordinary list.";

SystemSymbols::usage = "systemSymbols is a HoldList of all system symbols";

GlobalSymbols::usage = 
"GlobalSybols is a HoldList of all global (user-defined symbols";

DangerousSymbols::usage = 
"DangerousSymbols is a HoldList of system symbol  that should probably
not be called as functions.";

HasOptions::usage = "HasOptions[symbol] is True if symbol has any options.";

UndocumentedQ::usage = "UndocumentedQ[symbol] is True if symbol has no usage message.";

UnprotectedQ::usage = "UnprotectedQ[symbol] is True if symbol is unprotected.";

HasAttribute::usage = "HasAttribute[symbol, attr] is True if symbol has the 
attribute attr.";

HasOption::usage = "HasOption[symbol, opt] is True if symbol has the given option opt.";

SetAllOptions::usage = "SetAllOptions[name1 ->value1, name2 -> value2, ...] sets the 
specified default values for all symbols that know about the options.";

compareDirs::usage = 
"compareDirs[dir1,dir2] checks all files in dir1 and gives the information regarding date of modification. There is an option onlyMFiles to compare only files with suffixes .m";

Options[ compareDirs ] = { onlyMFiles -> True };

statusFile::usage = 
"statusFile[ f, d1, d2 ] returns 0 if file f is identical in d1 and d2, 1 if it is different and newer in d1, 2 if it is different and newer in d2.";

Begin["`Private`"]

(* This function is local, and used in makeDoc. Should be 
   removed...*)
Clear[putDocSym];
putDocSym[ pack:_String, sym:_, docFile:_ ] :=
Module[ {doc},
  (* Header of section *)
  Put[ 
      OutputForm[ "\\section{The \\texttt{"<>ToString[sym]<>"} function}\n" ],
        docFile
  ];

  doc = sym::latex;

  If[ !MatchQ[doc, _String],
    Put[ OutputForm[ "The description of this function is empty." ], docFile];
    Put[ OutputForm[ sym::usage ], docFile ],
    Put[ OutputForm[ doc ], docFile ]
  ];

];
putDocSym[___] := Message[ putDocSym::params ];

(* 
   This function (under construction) checks a package, and 
 produces a latex file for it. It the package is called, say
 pack, makeDoc[pack] puts in directory $MMAlpha/doc/packages/pack 
 a latex file pack.tex, which is chapter of the technical manual
 of MMAlpha. This chapter is build from items of the form 
 sym::latex = "blabla" which are put in file pack.m . 
   The description of a symbol generates a section in this file. 
 The description of the package itself, pack::latex, generates
 the first paragraph of the file. 
*)
Clear[makeDoc]; 
makeDoc[ pack:_String ] := 
Module[ { currDir, docFile },
Catch[
  Module[ { symbolList, doc, docFileName },
    
    currDir = Directory[];
    symbolList = 
      SymbolsInContext["Alpha`"<>pack<>"`"];
    symbolList = 
      With[ {s = Symbol[ pack ]}, 
        Complement[ symbolList, HoldList[ s ] ] 
      ];
    symbolList = Sort[ symbolList ];
    Print[ FullForm[ symbolList ] ];

    If[ symbolList === {}, 
      makeDoc::wrgpack = 
      "Package `1` does not contain symbols. Please check it.";
      Throw[ Message::makeDoc, pack ]
    ];

    SetDirectory[ $rootDirectory<>"/doc/packages/"<>pack ];

    docFileName = pack<>".tex";

    Check[ 
      docFile = OpenWrite[ docFileName, PageWidth -> Infinity ],
      makeDoc::errow = "error while opening doc file";
      Throw[ Message[ makeDoc::errow ] ]
    ];

    (* Header of chapter *)
    Put[ 
      OutputForm[ "\\chapter{The \\texttt{"<>pack<>"} package}\n" ],
        docFile
    ];

    doc = With[ { s = Symbol[pack]}, s::latex ];

    If[ !MatchQ[ doc, _String ],
      Put[ OutputForm[ "The description of the package is empty." ], docFile],
      Put[ OutputForm[ doc ], docFile ]
    ];

    Map[ Function[ file, putDocSym[ pack, file, docFile ] ], symbolList ];

  ]
];
  SetDirectory[ currDir ];
  Close[ docFile ];
];
makeDoc[___] := Message[ makeDoc::params ];

Clear[statusFile];
statusFile[ f:_String, d1:_String, d2:_String ]:=
Catch[
  Module[{ date1, date2, y1, y2, m1, m2, day1, day2, h1, h2, mn1, mn2, 
           s1, s2, status, cf1, cf2 },
    Check[ date1 = FileDate[d1<>"/"<>f],
           Throw[ Message[ statusFile::d1inex, f1, d1 ] ] ];
    Check[ date2 = FileDate[d2<>"/"<>f], 
           Throw[ Message[ statusFile::d1inex, f2, d2 ] ] ];
    {y1, m1, day1, h1, mn1, s1} = date1;
    {y2, m2, day2, h2, mn2, s2} = date2;
    status = 
    Which[ 
      date1 == date2, 0,
      y1>y2 || y1==y2 && m1>m2 || y1==y2 && m1==m2 && day1>day2 ||
      y1==y2 && m1==m2 && day1==day2 && h1>h2 ||
      y1==y2 && m1==m2 && day1==day2 && h1==h2 && mn1>mn2 ||
      y1==y2 && m1==m2 && day1==day2 && h1==h2 && mn1==mn2 &&s1>s2, 1,
      True, 2
    ]; 
    
    If[ status =!= 0, 
      cf1 = ReadList[d1<>"/"<>f, Record, RecordSeparators ->{}];
      cf2 = ReadList[d2<>"/"<>f, Record, RecordSeparators ->{}]; 
      If[ cf1 === cf2, status = 0 , Null],
      Null
    ];

    status
  ]
];
statusFile[___] := Message[statusFile::params];
statusFile::params = "wrong parameters"; 
statusFile::d1inext = "could not locate file `1` in directory `2`";

Clear[compareDirs];
compareDirs[ d1:_String, d2:_String, opts:___ ] :=
Module[ { curDir, result, onlyM }, 
  curDir = Directory[];
  onlyM = onlyMFiles/.{opts}/.Options[ compareDirs ];

  result = 
  Catch[
    Module[{ f1, f2 },
    
      Check[SetDirectory[d1],Throw[Null]];
      Check[f1 = FileNames[If[onlyM, "*.m", Null]],
                           Throw[Null]];  (* Get files of f1 *)

      Check[SetDirectory[d2],Throw[Null]];
      Check[f2 = FileNames[If[onlyM, "*.m", Null]],
                           Throw[Null]];  (* Files of f2 *)

      Map[ 
        Function[ {x},
          Module[ {stat},
            Which[
              !MemberQ[f2,x], Print["File ", x," does not appear in ", d2],
              True, stat = statusFile[ x, d1, d2 ]; 
                    Which[ stat == 1, 
                           Print["File ", x," is newer in ", d1],
                           stat == 2, 
                           Print["File ", x," is newer in ", d2]
                    ]
            ]
          ]
        ],
        f1
      ];

    ]
  ];
  SetDirectory[ curDir ];
  result
];
compareDirs[___] := Message[compareDirs::params];

Clear[HoldList];
SetAttributes[HoldList, HoldAll];

Format[holdlist:_HoldList] := List @@ HoldForm /@ holdlist;

Clear[SymbolsInContext];
SymbolsInContext[context:_String]:=
  HoldList @@ ToHeldExpression /@ Names[context<>"*"] /. Hold[sym_] :> sym;

(* A nice way to reuse messages of Mathematica. As message SymbolsInContext
   does not exist, General::string is called...  *)
SymbolsInContext[arg_] := nothing /;
    Message[SymbolsInContext::string, 1, SymbolsInContext];
SymbolsInContext[args___] := nothing /;
    Message[SymbolsInContext::argx, SymbolsInContext, Length[{args}]];

HoldList/: Select[ holdlist_HoldList, body_& ] :=
    With[{newf = Function[sym,bd,{HoldFirst}] /. bd :> body /. # :> sym},
	Select[ holdList, newf ]
    ];

HoldList/: Map[ body_&, holdlist_HoldList, arg___] := 
    With[ {newf = Function[ sym, bd, {HoldFirst} ] /. bd :> body /. # :> sym},
	Map[ newf, holdlist, args ]
    ];

HoldList/: Map[f_, HoldList[elements___], args___] :=
	List @@ Map[f, Hold[elements], args];

HoldList/: Through[HoldList[elements___][args___]] :=
	List @@ Through[Hold[elements][args]];

SystemSymbols := SymbolsInContext["System`"];
GlobalSymbols := SymbolsInContext["Global`"];

DangerousSymbols = HoldList[
	Abort, Exit, Quit, Debug, Dialog, Interrupt, Edit, EditIn, EditDef,
	EditDefinition, Trace, TraceDialog, TracePrint, TraceScan, $TracePostAction, 
	$TracePreAction, Throw, $Throw, In, Out
	];

(* Useful predicates *)
SetAttributes[ {HasOptions, UndocumentedQ, UnprotectedQ,
	        HasAttribute, HasOption}, HoldFirst ];

HasOptions[ sym:_Symbol ] := Length[Options[Unevaluated[sym]]] > 0;
UndocumentedQ[ sym:_Symbol ] := Head[ sym::usage ] =!= String;
HasAttribute[ sym:_Symbol , attr_ ] := MemberQ[ Attributes[sym], attr ];
HasOption[ sym:_Symbol, opt_ ] := MemberQ[ First /@ Options[ Unevaluated[sym] ], opt ];
UnprotectedQ[ sym:_Symbol ] := !HasAttribute[ sym, Protected ];

(* Set option defaults for several symbols at once *)
SetAllOptions[arg: (opt_ -> _) | (opt_ :> _)] :=
Module[ {syms},
        syms = HoldList @@ ToHeldExpression /@ Names["*"] /. Hold[ sym:_] :> sym;
        syms = Select[ syms, HasOption[ #, opt ]& ];
	Map[ SetOptions[ #, arg ]&, syms ];
];
SetAllOptions[ arg: (_Rule | RuleDelayed )...] := (SetAllOptions /@ {arg}; );

(* Improve ValueQ for symbols *)
protected = Unprotect[ ValueQ ];
ValueQ[ sym:_Symbol ] /; !HasAttributes[ sym, ReadProtected ] := Length[ OwnValues[sym] ] > 0;
Protect[ Evaluate[protected] ];

End[];

(* Protect[ *)
EndPackage[];
