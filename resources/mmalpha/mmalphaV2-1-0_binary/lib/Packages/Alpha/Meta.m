(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Patrice Quinton
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
BeginPackage["Alpha`Meta`",{"Alpha`","Alpha`Domlib`","Alpha`Tables`","Alpha`Matrix`",
  "Alpha`Options`", "Alpha`Static`", "Alpha`SystemProgramming`"}];

(* Standard head for CVS

	$Author: quinton $
	$Date: 2007/12/29 10:36:31 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Meta.m,v $
	$Revision: 1.2 $
	$Log: Meta.m,v $
	Revision 1.2  2007/12/29 10:36:31  quinton
	After a check of the documentation. A few errors were corrected. Did not try this on the Vhdl Generator, so has to be used with care.
	
	Revision 1.1  2005/03/14 14:39:11  trisset
	added VhdlTestBench
	
	Revision 1.15  2004/04/26 08:34:13  risset
	added system File before patrice visit
	
	Revision 1.14  2002/09/12 14:47:22  risset
	commit after patrice update and correction of Pipecontrol
	
	Revision 1.13  2002/05/28 15:55:00  quinton
	Meta was modified to include properly the options.
	
	Revision 1.12  2001/09/13 16:52:34  quinton
	Bug in the translation of tr$... was corrected.
	
	Revision 1.11  2001/08/16 07:22:47  quinton
	If were corrected. Also, possibility to name the translation of
	arguments tr$xxx instead of trxxx
	
	Revision 1.10  2000/05/26 18:00:38  quinton
	*** empty log message ***
	
	Revision 1.8  1999/07/30 09:49:10  risset
	commited V1.0.0
	
	Revision 1.7  1999/07/21 15:32:55  risset
	commited for GNU release 1.0
	
	Revision 1.6  1999/07/02 11:55:56  quinton
	Correction for strings in RHS of rules.
	
	Revision 1.5  1999/03/02 15:49:22  risset
	added GNU software text in each packages
	
	Revision 1.4  1998/11/06 14:29:29  quinton
	Again...
	
*)

(* 
      Author: P. Quinton, quinton@irisa.fr - May, June 1998
      This package contains a meta translator for Alpha programs. Its 
      documentation is in the notebook Meta.nb
*)

General::error = "error in `1`";
General::error1="Error while analyzing argument `2` of expression `1`";
General::error2="Error while analyzing expression `1`";
General::error3="The structure of expression `1` does not match the template";

directory::usage = 
"option of meta. Gives the directory where the semantic file is to be
found. If Null, the directory is $MMALPHA/lib/Packages/Alpha.";

meta::usage = ""; 
Options[meta] = { verbose -> False, debug -> False, check -> False,
 directory -> Null };

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

meta::noinputfile = 
"file `1` does not exist. Maybe you are not in the right directory...";
meta::wrgarg = " Wrong Argument to Meta: `1`"

meta[ fn:_String, opts:___Rule ] := 
Catch[
  Module[{ m, m1, m2, inputFile, outputFile, stream, dbg, ctx, dir, semfile },
    packageName = fn; (* Store the package name in a global variable *)
    dbg = debug/.{opts}/.{debug->False}; (* Read the options *)
    inputFile = fn<>".meta"; (* the name of the input file *)
    
    If[ dbg, Print["-- meta was called with a string"] ];

    (* Check that the inputFile exists *)
    If[ FileInformation[ inputFile ] === {}, 
        Throw[ Message[ meta::noinputfile, inputFile ] ]
        ];
    If[ dbg, Print["Input file: ", inputFile, " exists"] ];

    (* Print context *)
    If[ dbg, Print["Context is :",$Context]];

    (* While reading the input file, we go in context Alpha`Work, after
       removing all names in this context *)
    ctx = "Alpha`Work`";

    If[ dbg, Print["New Context will be: ",ctx]];
    (* Set the new context, and import some packages in it *)
    BeginPackage[
      ctx,
       {"Alpha`","Alpha`Domlib`","Alpha`Tables`","Alpha`Matrix`",
        "Alpha`Options`","Alpha`Static`","Alpha`Meta`"}
    ];

    (* Clear context *)
    With[{u=ctx<>"*"},
      If[ dbg, Print["Cleaning ",u]];
      Print[ FullForm[ SymbolsInContext[ ctx ] ] ];
      Print[ Apply[ List, SymbolsInContext[ctx]]==={} ];
      If[ Apply[ List, SymbolsInContext[ctx]] =!= {}, Remove[u] ]
    ];

    With[{u=ctx<>"Private`*"},
      If[ dbg, Print["Cleaning ",u]];
      If[ SymbolsInContext[ ctx<>"Private`"] =!= {}, Remove[u] ]
    ];

    (* Clear also context Alpha`meta` and Alpha`meta`Private` *)
    With[{u="Alpha`"<>fn<>"`*"},
      If[ dbg, Print["Cleaning ",u]];
      Print[ SymbolsInContext[ "Alpha`"<>fn<>"`" ] ];
      If[ SymbolsInContext[ "Alpha`"<>fn<>"`"] =!= {}, Remove[u] ]
    ];

    With[{u="Alpha`"<>fn<>"`Private`*"},
      If[ dbg, Print["Cleaning ",u]];
      Print[ SymbolsInContext[ u ] ];
      If[ SymbolsInContext[u] =!= {}, Remove[u] ]
    ];

    (* To be cleaned *)
    If[dbg,Print["Context is :",$Context]];

    (* Read input file *)
    If[ dbg, Print["Reading file ",fn<>".meta"]];
    x = ReadList[ inputFile, Record, RecordSeparators -> {} ];

    (* Replace on the fly a few strings in the input strean *)
    x = StringReplace[ x, {"::=" -> ":>", "\n" -> " "} ][[1]];

    (* Read again, and parse *)
    If[ dbg, Print["Parsing file ",fn<>".meta"]];
    stream = StringToStream[ x ];     
    x = ReadList[ stream, Expression ];

    (* Quit context Alpha`Work` *)
    EndPackage[];

    (* Clear context *)
    If[dbg, Print["Context is now:",$Context]];

    outputFile = fn<>".m";
    If[ dbg, Print[ "Output file is: ", outputFile ] ];

    (* This variable will contain the list of functions defined 
       by the meta-analysis of the input file. Used to create 
       the usage entries in the new package *)
	 $newFunctions = {fn<>"Translatelist"};
 
    x = x[[1]]; 

    If[ dbg, Print["---- List of functions defined by the meta analysis: "]; 
      Map[Print,x] 
    ];

    If[ dbg, Print["----"] ];
    If[ dbg, Print[" Options:", opts ] ];

    m = Map[ meta[ #, opts]& , x ];

    Print["Meta translator, version 0.9 -- October 1998"];
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

    (* Debug switch *)
    WriteString[
      outputFile,
      packageName<>"Debug::usage = \"Debug Switch\";\n"<>
      packageName<>"Debug = False;\n"
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
    
    dir = directory/.{opts}/.Options[meta];

    If[ dbg||vrb, Print["Directory option is: ", dir] ];

    (* If dir is Null, one reads the semantic file in the lib directory *)
    semfile = 
      If[ dir === Null, $rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha",
                                                    "fn.sem"} ],
                        dir ];

    Print[ "Directory of semantic file:", semfile ];

    WriteString[
      outputFile, 
      If[ dir === Null, 
        "With[{f=$rootDirectory<>\"/\"<>fileName[{\"lib\",\"Packages\",\"Alpha\",\""<>fn<>".sem\"}]},\n", 
        "With[{f=\""<>dir<>"/"<>fn<>".sem\"},\n"
      ]<>
      "  Check[ Get[ f ],\n"<>
      "       Print[ \"Error while trying reading file "<>fn<>" \"]]\n];\n"
    ];

    (* The translateList function *)
    With[{name=fn<>"TranslateList"},
    WriteString[ outputFile, 
      "Clear[ "<>name<>" ];\n"<>
      name<>"[ l:{___Integer}, opts:___Rule ]:= l;\n"<>
      name<>"[ l:{___Real}, opts:___Rule ]:= l;\n"<>
      name<>"[ l:{___Symbol}, opts:___Rule ]:= l;\n"<>
      name<>"[ l:{___String}, opts:___Rule ]:= l;\n"<>
(*    name<>"[ l:_]//;\n"<>
      "  Head[l]===Pattern&&MatchQ[l[[1]],_Symbol]&&\n"<>
      "    MatchQ[l[[2]],BlankNullSequence[_Symbol]]:=\n"<>
      "    Map[ Translate"<>ToString[l[[2]][[1]]]<>", l ]\n"<> *)
      name<>"[ l:___ ]:= \n  If["<>packageName<>"Debug,Message[ "<>name<>"::error3, l]];False\n"
    ]
    ];

    (* *)
    WriteString[ outputFile, " (* ------- *)\n\n " ];
    (* The new functions *)
    If[ m=!=Null,
      WriteString[ outputFile, Apply[ StringJoin, m] ] ];

    WriteString[ outputFile, " (* ------- *) " ];
    (* End *)
    WriteString[ 
      outputFile, 
      "End[];\nEndPackage[];\n"
    ];
    Close[ outputFile ]; 
    (* Clean Alpha`Work`*)
    Remove["Alpha`Work`*"];
    If[dbg,Print["Context Alpha`Work` was cleaned..."]];

  ]
];

(* Translation of an abstract node, i.e., a rule of the form f:>e[args]:>body *)
meta::boundsymb = "Symbol `1` is not free in the Global environment";
meta[ param:(f_:>(e_[a:___]:>g_)), opts:___Rule ]:=
Module[{dmod, emod, fName, cl, main, error, vrb, dbg },

  (* Get Options *)
  vrb = verbose /. {opts} /. Options[meta];
  dbg = debug /. {opts} /. Options[meta];
  If[ vrb||dbg, Print[ "Translating the abstract node: ", param ]];

  (* Check names *)
  If[ ValueQ[f], Throw[ Message[ meta::boundsymb, f ] ] ];

  (* Build the function name *)
  fName = packageName<>"Translate"<>ToString[ f ]; 

  (* Append this name to the private global variable $newFunctions *)
  $newFunctions = Append[ $newFunctions, fName ];

  (* Generate the clear *)
  cl = "Clear[ " <> fName <> " ];";

  (* Generate the main part of the definition *)
  main = fName <> "[ x:" <> 
  ToString[ Apply[ e, trParams[ {a} ] ] ] <> ", opts:___Rule ] :=\n" <> 
         ToString[ trBody[ Evaluate[{a}], g, Evaluate[fName], opts ] ];

  (* Generate the error case *)
  error = fName <> "[ x:___ ] := (If["<>packageName<>"Debug,Message[ " <> fName <> "::error3, x ]];False)";
  StringJoin[ cl, "\n", main, "\n", error, "\n\n" ]
];

(* Translation of a switch rule,  of the form f:> list of patterns *)
meta[ param:(f_:>g:{__}), opts:___Rule] := 
Module[{dmod, emod, fName, cl, main, error, vrb, dbg },

  (* Options *)
  vrb = verbose/.{opts}/.Options[meta];
  dbg = debug/.{opts}/.Options[meta];
  If[ vrb||dbg, Print[ "Translating the switch rule: ", param ] ];
  If[ ValueQ[f], Throw[ Message[ meta::boundsymb, f ] ] ];

  (* Auxiliary local function *)
  aux[x:_] := 
  Module[{ p, s },
    Which[ 
 (* one blank added by tanguy to v to allow more complexe pattern test *)
     MatchQ[ x, u_[v__]->_Symbol], 
      p = x[[1]]; s = x[[2]];
      "        "<>ToString[p]<>", "<>packageName<>"Translate"<>ToString[ s ]<>"[ x, opts ],\n",
      MatchQ[ x, u_[v__]->{_Symbol}], 
      p = x[[1]]; s = x[[2]][[1]];
      "        "<>ToString[p]<>", Map[ "<>packageName<>"Translate"<>ToString[ s ]<>"[#,opts]&, x ],\n",
      True, Throw[ Message[ meta::wrgarg, x ] ]
    ]
  ];

  (* Name of the function *)
  fName = packageName<>"Translate"<>ToString[ f ]; 

  (* Append new function name to $newFunctions *)
  $newFunctions = Append[ $newFunctions, fName ];

  (* Generate the clear *)
  cl = "Clear[ " <> fName <> " ];";

  (* Generate the main definition *)
  main = fName <> "[ x:_, opts:___Rule ] :=\n"; 
  (* Translate the rhs as a Switch which calls alternatives depending on 
     pattern found *)
  main = main <>"    Switch[ x,\n"<>
         Apply[StringJoin, Map[ aux, g ] ]<>
         "        _, (If["<>packageName<>"Debug,Message[ " <> fName <> "::error3, x ]];False)\n" <>
         "    ];\n";

  (* Generate the error case *)
  error = fName <> "[ x:___ ] := (If["<>packageName<>"Debug,Message[ " <> fName <> "::error3, x ]];False)";
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
trBody[ x_, y_, fName:_String, opts:___Rule ] := 
Module[ {listeid, ck, newy}, 
  (* Get check option *)
  ck = check/.{opts}/.Options[meta];
  (* Build list of parameters *)
  listeid = 
    Join[
      Map[ "tr"<>ToString[ First[ # ] ]&, x ],
      Map[ "tr$"<>ToString[ First[ # ] ]&, x ]
    ];
  (* The body of a function consists of the following elements: 
     - a Module
     - a Catch expression
     - inside a Check, a list of calls to functions translating the arguments
	( only if the check option is true )
     - the error case for the check: a message
  *)
  newy = y/.(u:_String:>"\""<>u<>"\"");
  StringJoin[
    "Module[ ", ToString[ listeid ] , ",\n",
    "  Catch[\n",
    If[ ck, "    Check[\n", ""],
    Apply[ StringJoin, Map[ trOneArg[ #, fName ]&, x ] ], 
    "    ",
    ToString[ newy ],
    If[ ck,
      StringJoin[
        ",\n", (* Second arg of Check *)
        "    Message[ ",
        fName, 
        "::error2, x ]\n",
        "    ] (* End Check *)\n"
      ], ""
    ],
    "  ] (* End Catch *)\n",
    "]; (* End Module *)"
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
    " = "<>packageName<>"Translate",
    ToString[ x[[2]] ],
    "[ ",
    ToString[x[[1]]],
    ", opts ];\n"
  ]
];

(* Translation of one argument of the form x:{symbol}  *)
trOneArg[ x:_, fName:_String ]/;
  Head[x]===Pattern&&MatchQ[x[[1]], _Symbol] && MatchQ[x[[2]],{_Symbol}] :=
  Module[{s},
    s = First[ x[[2]] ];
    (* This statement assigns a value to the translated expression 
       In the first version, the translation of a symbol, say x, 
       was named "trx", and for aesthetic reasons, I name it 
       tr$x now, but for compatibility reasons, I kept both names *)
    StringJoin[
      "      tr",
      ToString[ First[ x ] ],
      " = Map[ "<>packageName<>"Translate",
      ToString[ First[ x[[2]] ] ],
      "[#,opts]&, ", 
      ToString[ x[[1]] ],
      " ];\n",
      "      tr$",
      ToString[ First[ x ] ],
      " = tr",
      ToString[ First[ x ] ],
      ";\n"
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
    " ],Null, Throw[ Message[ ",
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

