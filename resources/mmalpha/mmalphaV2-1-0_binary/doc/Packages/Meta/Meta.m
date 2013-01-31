BeginPackage["Alpha`Meta`",{"Alpha`","Alpha`Domlib`","Alpha`Tables`","Alpha`Matrix`",
	"Alpha`Options`", "Alpha`Static`"}];

(* 
      Author: P. Quinton, quinton@irisa.fr - May, June 1998
      This package contains a meta translator for Alpha programs. Its 
      documentation is in the notebook Meta.nb
*)

General::error = "error in `1`";
General::error1="Error while analyzing argument `2` of expression `1`";
General::error2="Error while analyzing expression `1`";
General::error3="The structure of expression `1` does not match the template";

meta::usage = ""; 
Options[meta] = { verbose -> False, debug -> False };
trBody::usage = "";
trParams::usage = "";
trOneArg::usage = "";

getType::usage = ""; 
getSystemName::usage = ""; 
getSystemParameters::usage = ""; 
getSystemParameterDomain::usage = ""; 

typeQ::usage = ""; 
target::usage = ""; 


(* ===================== Private definitions ===================== *)

Begin["`Private`"]

Clear[ getVarType ]; 
getVarType::usage = 
"getVarType[ var ] gives the scalar type of var in $result."; 
getVarType[ var:_String ] := 
Catch[ 
  Module[{d},
    d = Check[ getDeclaration[ var ], Throw[ Message[ getType::var ] ] ]; 
    d[[2]]
  ]
]; 
getVarType[ ___ ] := Message[ getVarType::params ]; 
getVarType::var = "Could not get the type of this var."; 

Clear[ getSystemName ]; 
getSystemName::usage = 
"getSystemName[] gives the name of $result."; 
getSystemName[] := 
If[ 
  MatchQ[ $result, system[ _String, __ ] ], 
  $result[[1]], 
  Message[ getSystemName::result ] ];
getSystemName[ ___ ] := Message[ getSystemName ::params ]; 
getSystemName::result = "Are you sure that an Alpha program was loaded?";

Clear[ getSystemParameters ]; 
getSystemParameters::usage = 
"getSystemParameters[] gives the parameters of $result."; 
getSystemParameters[] := 
If[ 
  MatchQ[ $result, system[ _String, __ ] ], 
  $result[[2]][[2]], 
  Message[ getSystemName::result ] ];
getSystemParameters[ ___ ] := Message[ getSystemParameters::params ]; 

Clear[ getSystemParameterDomain ]; 
getSystemParameterDomain::usage = 
"getSystemParameterDomain[] gives the domain of the parameters of system $result.";
getSystemParameterDomain[] := 
If[ 
  MatchQ[ $result, system[ _String, __ ] ], 
  $result[[2]], 
  Message[ getSystemName::result ] ];
getSystemParameterDomain[ ___ ] := Message[ getSystemParameterDomain::params ]; 

Clear[ typeQ ];
typeQ::usage = "typeQ[ t ] is True if t is a scalar type"; 
typeQ[t:_] := MemberQ[ {Alpha`real, Alpha`integer, Alpha`boolean}, t];
typeQ[___] := Message[ typeQ::params ];

(* *)
Clear[meta];
meta::usage = 
"meta[fileName] reads the file fileName.meta and the file fileName.sem,
and translates these files into a mathematica package called
filename.m. The file fileName.meta contains a set of meta-rules, and
fileName.sem contains  the semantic functions associated with these
rules."

meta::noinputfile = "file `1`.meta does not exist.";
meta[ fn:_String, opts:___Rule ] := 
Catch[
  Module[{ m, m1, m2, inputFile, outputFile, stream, dbg, ctx },
    dbg = debug/.{opts}/.{debug->False};
    inputFile = fn<>".meta";
    
    If[ FileInformation[ inputFile ] === {}, 
        Throw[ Message[ meta::noinputfile, inputFile ] ],
        ];
    If[dbg,Print["Context is :",$Context],];

    ctx = "Alpha`"<>fn<>"`";
    If[dbg,Print["New Context will be: ",ctx],];
    BeginPackage[
      ctx,
       {"Alpha`","Alpha`Domlib`","Alpha`Tables`","Alpha`Matrix`",
        "Alpha`Options`","Alpha`Static`","Alpha`Meta`"}
    ];
    With[{u=ctx<>"*"},Remove[u]];
    If[dbg,Print["Context is :",$Context],];
    x = ReadList[ inputFile, Record, RecordSeparators -> {} ];
    x = StringReplace[ x, {"::=" -> ":>", "\n" -> " "} ][[1]];
    stream = StringToStream[ x ];     
    x = ReadList[ stream, Expression ];
    EndPackage[];
    If[dbg,Print["Context is :",$Context],];

    outputFile = fn<>".m";

    (* This variable with contain the list of functions defined 
       by the meta-analysis of the input file. Used to create 
       the usage entries in the new package *)
    $newFunctions = {"translateList"};
    x = x[[1]]; 
    m = Map[ meta[ #, opts]& , x ];

    Print["Meta translator, version 0.9 -- June 1998"];
    Print["The new package is created in file: ", outputFile];
    Print["List of new functions :\n",  $newFunctions ]; 
    OpenWrite[ outputFile ]; 

    (* BeginPackage instruction *)
    WriteString[ 
      outputFile, 
      "BeginPackage[\"Alpha`"<>fn<>
      "`\",{\"Alpha`\",\n\"Alpha`Domlib`\",\n\"Alpha`Tables`\",\n\"Alpha`Matrix`\",
	\n\"Alpha`Options`\", \n\"Alpha`Static`\"}];\n"
    ];

    (* Usage entries *)
    WriteString[
      outputFile, 
      Apply[ StringJoin,
        Map[ ToString[#]<>"::usage = \"\";\n"&, $newFunctions ]
      ]
    ];

    (* Begin Private *)
    WriteString[ 
      outputFile, 
      "Begin[ \"`Private`\" ];\n"
    ];
    
    (* *)
    WriteString[
      outputFile, 
      "Check[ Get[\""<>fn<>".sem\" ],\n"<>
      "       Print[ \"Are you sure that the file "<>fn<>".sem exists?\"]\n];\n"
    ];

    (* The translateList function *)
    WriteString[ outputFile, 
      "Clear[ translateList ];\n"<>
      "translateList[ l:{___Integer} ]:= l;\n"<>
      "translateList[ l:{___Real} ]:= l;\n"<>
      "translateList[ l:{___Symbol} ]:= l;\n"<>
      "translateList[ l:{___String} ]:= l;\n"<>
(*    "translateList[ l:_]//;\n"<>
      "  Head[l]===Pattern&&MatchQ[l[[1]],_Symbol]&&\n"<>
      "    MatchQ[l[[2]],BlankNullSequence[_Symbol]]:=\n"<>
      "    Map[ translate"<>ToString[l[[2]][[1]]]<>", l ]\n"<> *)
      "translateList[ l:___ ]:= Message[ translateList::error3, l];\n"
    ]; 

    (* The new functions *)
    WriteString[ outputFile, Apply[ StringJoin, m] ];

    (* End *)
    WriteString[ 
      outputFile, 
      "End[];\nEndPackage[];\n"
    ];
    Close[ outputFile ]; 
  ]
];

(* Translation of an abstract node, i.e., a rule of the form f:>e[args]:>body *)
meta::boundsymb = "Symbol `1` is not free in the Global environment";
meta[ param:(f_:>(e_[a:___]:>g_)), opts:___Rule ]:=
Module[{dmod, emod, fName, cl, main, error, vrb },

  (* Get Options *)
  vrb = verbose /. {opts} /. Options[meta];
  If[ vrb, Print[ "Translating the abstract node: ", param ],];

  (* Check names *)
  If[ ValueQ[f], Throw[ Message[ meta::boundsymb, f ] ], ];

  (* Build the function name*)
  fName = "translate"<>ToString[ f ]; 

  (* Append this name to the private global variable $newFunctions *)
  $newFunctions = Append[ $newFunctions, fName ];

  (* Generate the clear *)
  cl = "Clear[ " <> fName <> " ];";

  (* Generate the main part of the definition *)
  main = fName <> "[ x:" <> 
  ToString[ Apply[ e, trParams[ {a} ] ] ] <> " ] :=\n" <> 
         ToString[ trBody[ Evaluate[{a}], g, Evaluate[fName] ] ];

  (* Generate the error case *)
  error = fName <> "[ x:___ ] := Message[ " <> fName <> "::error3, x ] ; ";
  StringJoin[ cl, "\n", main, "\n", error, "\n\n" ]
];

(* Translation of a switch rule,  of the form f:> list of patterns *)
meta[ param:(f_:>g:{__}), opts:___Rule] := 
Module[{dmod, emod, fName, cl, main, error, vrb },

  (* Options *)
  vrb = verbose/.{opts}/.Options[meta];
  If[ vrb, Print[ "Translating the switch rule: ", param ], ];
  If[ ValueQ[f], Throw[ Message[ meta::boundsymb, f ] ], ];

  (* Auxiliary local function *)
  aux[x:_] := 
  Module[{ p, s },
    Which[ 
      MatchQ[ x, u_[v_]->_Symbol], 
      p = x[[1]]; s = x[[2]];
      "        "<>ToString[p]<>", translate"<>ToString[ s ]<>"[ x ],\n",
      MatchQ[ x, u_[v_]->{_Symbol}], 
      p = x[[1]]; s = x[[2]][[1]];
      "        "<>ToString[p]<>", Map[ translate"<>ToString[ s ]<>", x ],\n",
      True, Throw[ Message[ meta::wrgarg, x ] ]
    ]
  ];

  (* Name of the function *)
  fName = "translate"<>ToString[ f ]; 

  (* Append new function name to $newFunctions *)
  $newFunctions = Append[ $newFunctions, fName ];

  (* Generate the clear *)
  cl = "Clear[ " <> fName <> " ];";

  (* Generate the main definition *)
  main = fName <> "[ x:_ ] :=\n"; 
  (* Translate the rhs as a Switch which calls alternatives depending on 
     pattern found *)
  main = main <>"    Switch[ x,\n"<>
         Apply[StringJoin, Map[ aux, g ] ]<>
         "        _, Message[ " <> fName <> "::error3, x ]\n" <>
         "    ];\n";

  (* Generate the error case *)
  error = fName <> "[ x:___ ] := Message[ " <> fName <> "::error3, x ] ; ";
  StringJoin[ cl, "\n", main, "\n", error, "\n\n" ]
];

meta[x:___]:=(Print[FullForm[x]];Message[ meta::params, x ]); 
meta::params = "Error while translating `1`";

Clear[ trParams ];

(* Make the function Listable *)
trParams[ a:{___Pattern} ]:=
  Map[ trParams, a ];  

(* Translation of one parameter. This function is used to translate
   the arguments of the left-hand side of a meta-rule into a formal parameter
   of the generated function *)
trParams[ a:_Pattern]:=
Module[{h, p}, 
  h = a[[1]]; (* First element of a *)
  p = a[[2]]; (* Pattern associated to p *)
(* There are two cases here. If the parameter has the form of a pattern, 
   generate a simple named pattern. If the parameter is a list, one generate
   a real pattern ------------ To be changed *)
  Which[
    (Head[p] === Blank||Head[p] === Symbol),
    Pattern[ Evaluate[ h ], Blank[] ],
    MatchQ[ p, List[_] ], (* *)
      If[ MatchQ[ p[[1]], _BlankSequence | _BlankNullSequence ],
          Pattern[ Evaluate[ h ], Evaluate[ p ] ],
          Pattern[ Evaluate[ h ], Blank[] ] ],
    MatchQ[ p, Alternatives[___]],
    Pattern[ Evaluate[ h ], Evaluate[ p ]],
    True, 
    Print[h,p];Message[ trParams::error, a ]
  ] 
];

trParams[ x:___ ] := Message[ trParams::params, x ]; 
trParals::params = "Error while translating `1`";
trParams::error = "Argument `1` is not a valid pattern";

(* Translation of the body of a function *)
Clear[ trBody ];

(* This function is called with 3 parameters: the lhs part, x, the rhs part, y,
   and the function name, fName *)
trBody[ x_, y_, fName:_String ] := 
Module[ {listeid}, 
  (* Build list of parameters *)
  listeid = Map[ "tr"<>ToString[ First[ # ] ]&, x ];
  (* The body of a function consists of the following elements: 
     - a Module
     - a Catch expression
     - inside a Check, a list of calls to functions translating the arguments
     - the error case for the check: a message
  *)
  StringJoin[
    "Module[ ", ToString[ listeid ] , ",\n",
    "  Catch[\n",
    "    Check[\n",
    Apply[ StringJoin, Map[ trOneArg[ #, fName ]&, x ] ], 
    "    ",
    ToString[ Unevaluated[ y ] ],
    ",\n", (* Second arg of Check *)
    "    Message[ ",
    fName, 
    "::error2, x ]\n",
    "    ] (* End Check *)\n",
    "  ] (* End Catch *)\n",
    "] (* End Module *)"
  ]
]; 
trBody[ ___ ] := Message[ trBody::params ]; 

(* This function generates the code for the translation of one 
   argument, in the body of the definition *)
Clear[ trOneArg ];

(* Translation of one argument of the form x:symbol *)
trOneArg[ x:_, fName:_String ]/;
  Head[x]===Pattern&&MatchQ[x[[1]], _Symbol]&&MatchQ[x[[2]],_Symbol] := 
Module[{}, 
  StringJoin[
    "      tr",
    ToString[ First[x] ],
    " = translate",
    ToString[ x[[2]] ],
    "[ ",
    ToString[x[[1]]],
    " ];\n"
  ]
];

(* Translation of one argument of the form x:{symbol}  *)
trOneArg[ x:_, fName:_String ]/;
  Head[x]===Pattern&&MatchQ[x[[1]], _Symbol] && MatchQ[x[[2]],{_Symbol}] :=
  Module[{s},
    s = First[ x[[2]] ];
    StringJoin[
      "      tr",
      ToString[ First[ x ] ],
      " = Map[ translate",
      ToString[ First[ x[[2]] ] ],
      ", ", 
      ToString[ x[[1]] ],
      " ];\n"
    ]
  ];

(* Translation of one argument of the form x:pattern, where pattern is
   none of the other previous cases *)
trOneArg[ x:_, fName:_String ]/;
  Head[x]===Pattern&&MatchQ[x[[1]], _Symbol]&&Not[MatchQ[x[[2]],_Symbol]] := 
Module[{},
  StringJoin[
    "      If[ MatchQ[ ", 
    ToString[ x[[1]] ], 
    ", ",
    ToString[ x[[2]] ], 
    " ],, Throw[ Message[ ",
    fName,
    "::error1,", 
    ToString[ x[[1]] ], 
    ", x", 
    "] ] ];\n",
    "      tr",
    ToString[ First[ x ] ],
    " = ",
    ToString[ First[ x ] ],
    ";\n"
  ]
];

trOneArg[ x: ___ ] := (Print[ {x} ];Message[ trOneArg::params ]);

End[];
EndPackage[]

