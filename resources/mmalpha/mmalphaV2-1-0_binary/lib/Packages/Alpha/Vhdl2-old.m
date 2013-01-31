BeginPackage["Alpha`Vhdl2`",{"Alpha`", "Alpha`Domlib`",
				      "Alpha`Semantics`",
				      "Alpha`Tables`",
			 	      "Alpha`Options`",
				      "Alpha`Visual`",
                                      "Alpha`vhdlCell`",
                                      "Alpha`vhdlCont`",
                                      "Alpha`vhdlModule`",
				      "Alpha`CheckCell`",
				      "Alpha`CheckModule`",
                                      "Alpha`CheckController`"}];

(* Standard head for CVS

	$Author: trisset $
	$Date: 2005/03/11 16:40:17 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Vhdl2.m,v $
	$Revision: 1.1 $
	$Log: Vhdl2.m,v $
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.19  2004/09/16 13:46:51  quinton
	Updated version
	
	Revision 1.18  2004/03/12 07:59:45  quinton
	Added Lyrtech option.
	
	Revision 1.17  2003/12/12 13:17:02  risset
	 minor modif
	
	Revision 1.16  2003/07/16 13:37:11  quinton
	Many corrections to the generation of the stdLogic option.
	
	Revision 1.15  2003/06/27 12:53:40  risset
	 no modif in practice (just blank lines)
	
	Revision 1.14  2003/05/06 15:34:19  risset
	modify a2v to accept use without extension domain in cells
	
	Revision 1.13  2003/04/28 15:15:59  quinton
	A few bugs in the stdlogic option corrected
	
	Revision 1.12  2002/12/03 12:52:26  risset
	replaced the Pip.m by the new Pip.m with function solveWithPip
	
	Revision 1.11  2002/09/12 14:47:24  risset
	commit after patrice update and correction of Pipecontrol
	
	Revision 1.10  2002/07/16 12:39:18  quinton
	Absolute value added.
	
	Revision 1.9  2002/05/28 15:53:50  quinton
	Extensions to the Vhdl generator, in order to generate stdlogic vectors.
	The corresponding option is stdLogic. This has not been fully tested yet...
	
	Revision 1.8  2001/08/16 15:14:06  quinton
	If corrected
	
	Revision 1.7  2001/07/06 12:44:40  risset
	small changes
	
	Revision 1.6  2001/02/02 08:59:36  risset
	corrected Vhdl2.m which was broken, remove showVhdl form Vhdl.m
	

*)

General::params = "wrong parameters"; 

Vhdl2::usage = 
"Alpha`Vhdl2` contains the Vhdl generator. The main function is a2v.";

$vhdlCurrent::usage = 
"vhdlCurrent is a global variable owned by Vhdl, which contains the 
current program";
$vhdlOutputFile::usage = "";

a2v::usage = 
"a2v[] translates in Vhdl all the files contained in $library. 
a2v[lib] translates in Vhdl all the files contained in library
lib. a2v[sys] translates in Vhdl the system sys. a2v has many 
options (see Options[a2v]). a2v[elem,tinit] runs a2v on library
or system elem, and fixes the initial value of the time to the
integer value tinit.";

(*
This function was removed from external functions. PQ August 2004.
a2vOneFile::usage = ""; 
*)

bitWidth::usage=
"bitWidth[sys,var] gives the bit width of variable var. Default 
value of sys is $result.";

bitWidthOfExpr::usage=
"bitWidth[sys,expr] gives the bit width of an expression. Default
of sys is $result.";

getVhdlType::usage = 
"getVhdlType[sys,var] return the vhdl type of the element of array var";

showVhdl::usage = 
"showVhdl[] prints the Vhdl generated for the system in $result. 
showVhdl[s] show the content of the file s.vhd.";

stim::usage=
"stim[] post processes all the simuli files (replace blanks by zeros). 
These files are generated from a C code in hexadecimal and there is no 
format in C to write zeros in for the first digits.";

(*
vhdlType::usage = "vhdlType[s] gives the Vhdl type of a scalar 
alpha type (integer, boolean, integer[S,n] or integer[U,n]).";

vhdlDeclEnt::usage = 
"vhdl[{var,s},"IN"|"OUT"] returns the Vhdl declaration of variable
var, with scalar type s. Internal function.";

vhdlDeclArc::usage = "internal function.";

genLibrary::usage = 
"genLibrary[] generates the library statement. Internal function.";
*)

Begin["`Private`"]; 

Options[ a2v ] := { debug -> False, verbose -> False, tempFile -> False, 
  cellType -> Null, compass -> False, compactCode -> False, 
  clockEnable -> True, vhdlLibrary -> "", skipLines -> False, 
  compactCode -> False, stdLogic -> True, initialize -> False,
  lyrtech -> False }; 

(* Gets the type of a given variable *)
Clear[getVhdlType];
getVhdlType[ v:_String, opts:___Rule ] :=
  getVhdlType[$vhdlCurrent, v, opts];
getVhdlType[ sys:_system, v:_String, opts:___Rule] :=
Catch[
  Module[{d, t},
    Check[d = getDeclaration[ sys, v ],Throw[Message[getVhdlType::err]]];
    t = d[[2]];
    vhdlType[t, opts]
  ]
];
getVhdlType::err := "Error while calling getDeclaration";
getVhdlType[___]:=Message[getVhdlType::params];


Clear[bitWidth];
bitWidth::varNotFound= "variable `1` not found in system `2`";

bitWidth[var1:_String]:=  bitWidth[$result,var1];

bitWidth[sys:_Alpha`system,var1:_String]:=
  Module[{},
	 decl1=getDeclaration[sys,var1];
	 If [decl1==={},
	     Message[bitWidth::varNotFound,var1,sys[[1]]];Return[16],
	     bitWidth[var1,decl1[[2]]]]];

bitWidth[var1:_String,type1:_]:=
  Module[{res},
	 res=Switch[type1,
		Alpha`integer[_,_],type1[[2]],
		Alpha`integer,16,
		boolean,1,
		_,16];
       res];

bitWidth::params="Wrong Argument for bitWidth";
bitWidth[___]:=Message[bitWidth::params];

Clear[bitWidthOfExpr];

Options[bitWidthOfExpr]={debug->False}

bitWidthOfExpr[expr_,options___Rule] := bitWidthOfExpr[$result,expr];

bitWidthOfExpr[sys_,varName:_String,options___Rule]:=
  bitWidth[sys,varName];
bitWidthOfExpr[sys_,var[varName:_String],options___Rule]:=
  bitWidth[sys,varName];
bitWidthOfExpr[sys_,const[const1:_],options___Rule]:=
  Ceiling[Log[const1]]; 
bitWidthOfExpr[sys_,binop[add , arg1_,arg2_],options___Rule]:=
  Max[bitWidthOfExpr[sys,arg1],bitWidthOfExpr[sys,arg2]]+1; 
bitWidthOfExpr[sys_,binop[sub , arg1_,arg2_],options___Rule]:=
  Max[bitWidthOfExpr[sys,arg1],bitWidthOfExpr[sys,arg2]]+1; 
bitWidthOfExpr[sys_,binop[mul , arg1_,arg2_],options___Rule]:=
  bitWidthOfExpr[sys,arg1]+bitWidthOfExpr[sys,arg2]; 
(* all others binop operators *)
bitWidthOfExpr[sys_,binop[_ , arg1_,arg2_],options___Rule]:=
  Max[bitWidthOfExpr[sys,arg1],bitWidthOfExpr[sys,arg2]]; 
bitWidthOfExpr[sys_,unop[_ , arg1_],options___Rule]:=
  bitWidthOfExpr[sys,arg1]; 
bitWidthOfExpr[sys_,if[ _ , arg1_, arg2_],options___Rule]:=
  Max[bitWidthOfExpr[sys,arg1],bitWidthOfExpr[sys,arg2]]; 
bitWidthOfExpr[sys_,affine[ arg1_, mat_],options___Rule]:=
  bitWidthOfExpr[sys,arg1]; 
bitWidthOfExpr[sys_,restrict[ dom_,arg1_],options___Rule]:=
  bitWidthOfExpr[sys,arg1]; 
bitWidthOfExpr[sys_,case[ expList_ ],options___Rule]:=
  Apply[Max,Map[bitWidthOfExpr[sys,#]&,expList]];
bitWidthOfExpr[sys_, expList_List,options___Rule]:=
  Apply[Max,Map[bitWidthOfExpr[sys,#]&,expList]];
(* we do not know for a call *)
bitWidthOfExpr[sys_,call[ id_,expList_ ],options___Rule]:=
  Apply[Max,Map[bitWidthOfExpr[sys,#]&,expList]];
bitWidthOfExpr[sys_,reduce[ caseop_,mat_,exp ],options___Rule]:=
  bitWidthOfExpr[sys,arg1];

bitWidthOfExpr::wrongArg=
"wrong Argument for function bitWidthOfExpr, could not evaluate bitWidth of :"

bitWidthOfExpr[a:___]:=(Print[bitWidthOfExpr::wrongArg,Map[Head,{a}]];16)

(* This function defines the vhdl Type of Alpha expressions *)
Clear[vhdlType];
vhdlType[ t:boolean, opts:___Rule ]:=  " STD_LOGIC";
vhdlType[ t:integer, opts:___Rule ]:=  
Module[ {stdl, init},
  stdl = stdLogic/.{opts}/.Options[ a2v ];
  init = initialize/.{opts}/.Options[ a2v ];
  If[ !stdl, 
    If[ init, " INTEGER RANGE -32768 TO 32767 := 0",
      " INTEGER RANGE -32768 TO 32767"
    ],
    If[ init, " SIGNED (15 DOWNTO 0) := \""<>
              Apply[StringJoin,Table["0",{i,1,16}]]<>"\"",
      " SIGNED (15 DOWNTO 0)"
    ]
  ]
];
vhdlType[ t:integer["U",k:_Integer], opts:___Rule ]:=  
Module[ {stdl, init},
  stdl = stdLogic/.{opts}/.Options[ a2v ];
  init = initialize/.{opts}/.Options[ a2v ];
  If[ !stdl, 
    If[ init, 
      " INTEGER RANGE 0 TO "<>ToString[2^(t[[2]]-1)-1]<>" := \""<>
              Apply[StringJoin,Table["0",{i,1,k}]]<>"\"",
      " INTEGER RANGE 0 TO "<>ToString[2^(t[[2]]-1)-1]
    ],
    If[ init, 
      "UNSIGNED ("<>ToString[k-1]<>" DOWNTO 0) := \""<>
              Apply[StringJoin,Table["0",{i,1,k}]]<>"\"",
      "UNSIGNED ("<>ToString[k-1]<>" DOWNTO 0)"
    ]
  ]
];
vhdlType[ t:integer["S",k:_Integer], opts:___Rule]:=  
Module[ {stdl, init},
  stdl = stdLogic/.{opts}/.Options[ a2v ];
  init = initialize/.{opts}/.Options[ a2v ];
  If[ !stdl, 
    With[{n = 2^(t[[2]]-1)},
    " INTEGER RANGE "<>
           ToString[-n]<>" TO "<>
           ToString[n-1]<>
           If[ init, " := 0", ""]
    ],
    " SIGNED ("<>ToString[k-1]<>" DOWNTO 0)"<>
    If[ init, " := \""<>Apply[StringJoin,Table["0",{i,1,k}]]<>"\"", ""]
  ]
];
vhdlType::typeUnknown = "this type `1` is unknown";
vhdlType[x:___] := (Print[{x}[[1]]];Message[vhdlType::typeUnknown,{x}];"");

(* This function produces one declaration in the entity 
   part *)
Clear[vhdlDeclEnt];
vhdlDeclEnt[{v:_String,t:_},inout:("IN"|"OUT"),opts:___Rule]:=
  "\n  "<>v<>" : "<>inout<>" "<>vhdlType[t, opts, initialize -> False];
vhdlDeclEnt[{v:_String,t:_,_},inout:("IN"|"OUT"),opts:___Rule]:=
  "\n  "<>v<>" : "<>inout<>" "<>t;
vhdlDeclEnt::typeUnknown = "this type `1` is unknown";
vhdlDeclEnt[x:___]:= (Print[{x}[[1]]];
  Message[vhdlDeclEnt::typeUnknown,{x}];"");

(* This function produces the declaration in the architecture
   part *)
Clear[vhdlDeclArc];
vhdlDeclArc[{v:_String,t:_},opts:___Rule]:=
((*Print[vhdlType[t,opts]];*)
  "    SIGNAL "<>v<>" : "<>vhdlType[t,opts,initialize->True]<>";\n");
vhdlDeclArc[{v:_String,t:_,_},opts:___Rule]:=
  "    SIGNAL "<>v<>" : "<>t<>";\n";
vhdlDeclArc::typeUnknown = "this type `1` is unknown";
vhdlDeclArc[x:___]:= 
  (Print[{x}];Message[vhdlDeclArc::typeUnknown,{x}];"");

(*   This function allows one to see the generated Vhdl code for
     a system *)

Options[ showVhdl ] := {debug -> False, verbose -> False, tempFile ->
False};

Clear[showVhdl];
showVhdl::params = "wrong parameter";
showVhdl::file = "could not locate `1`.vhd";
showVhdl::empty = "$result does not contain an Alpha program";
showVhdl[ opts:___Rule ]:=
Catch[
  Module[{name},
    If[MatchQ[$result,system[_String,___]],name=$result[[1]],
       Throw[Message[showVhdl::empty]]];
    showVhdl[name,opts];  
  ];
];
showVhdl[ name:_String, opts:___Rule ]:=
Module[{dir, tmp, locvar},
  tmp = tempFile/.{opts}/.Options[a2v];
  dir = If[tmp,"/tmp/",""];
  Catch[
    If[ FileInformation[dir<>name<>".vhd"]=={} , 
      Throw[ Message[showVhdl::file, dir<>name<>".vhd" ] ] ];

      locvar = ReadList[ dir<>name<>".vhd", Record, 
             RecordSeparators -> {} ]; 
      If[ locvar ==={}, Message[ showVhdl::empty ], Print[ locvar[[1]] ] ];
  ];
];
showVhdl[___] := Message[ showVhdl::params ];
showVhdl::empty := "Vhdl file is empty";

(*
  Called on one element of the library.
*)
Clear[a2vOneFile];
a2vOneFile[sys_system, opts:___Rule]:=
Module[{codevhdl, component, componentsUsed, fd, optverbose, 
        optdebug, lib, result, componentFile, componentsTemp},

  opttempFile = tempFile /. {opts} /. Options[ a2v];
  optverbose = verbose /. {opts} /. Options[ a2v ];
  optdebug = debug /. {opts} /. Options[ a2v ];
  tp = cellType /. {opts} /. Options[ a2v ]; 

  Catch[
    If[ optverbose || optdebug, Print["Translating ", sys[[1]] ] ];
    $vhdlCurrent = sys;

    Check[
      fd = 
         OpenWrite[
           If[opttempFile,"/tmp/",""]<>sys[[1]]<>".vhd",
           PageWidth->Infinity],
           Throw[ Message[ a2v::openwrite ] ] ];

    Check[
      componentFile = 
         OpenWrite[
           If[opttempFile,"/tmp/",""]<>sys[[1]]<>".component",
           PageWidth->Infinity],
           Throw[ Message[ a2v::openwrite ] ] ];

    (* Generates the libraries used by the Vhdl module *)
    lib = Check[genLibrary[ opts ],Throw[Null]];

    (*  If the typeCell parameter is not Null, we use it to force the
    choice of the translater, otherwise, we let checkController,
    checkCell, or checkModule decide (the normal case) *)
    If[ tp =!= Null,
      Which[
        tp === "controler", 
        Check[ result = vhdlCont[ sys, vhdlLibrary -> lib, opts], 
               Throw[ Message[ a2v::error1, sys[[1]] ] ]
        ],
        tp === "cell",
        Check[ result = vhdlCell[ sys, vhdlLibrary -> lib, opts ], 
               Throw[ Message[ a2v::error2, sys[[1]] ] ] 
        ],
        tp === "module", 
        Check[ result = vhdlModule[ sys, vhdlLibrary -> lib, opts ],
               Throw[ Message[ a2v::error3, sys[[1]] ] ] 
        ],
        True, Throw[Message[ a2v::error5 ] ]
      ],
      Which[
        checkController[sys], 
          (Print[ sys[[1]], " was recognized as a Controller."];
          Check[ result = vhdlCont[ sys, vhdlLibrary -> lib, opts ], 
               Throw[ Message[ a2v::error1, sys[[1]] ] ] ]),
        checkCell[sys],
          (Print[ sys[[1]], " was recognized as a Cell."];
          Check[ result = vhdlCell[ sys, vhdlLibrary -> lib, opts ], 
               Throw[ Message[ a2v::error2, sys[[1]] ] ] ]),
        checkModule[sys],  
          (Print[ sys[[1]], " was recognized as a Module."];
          Check[ result = vhdlModule[ sys, vhdlLibrary -> lib, opts ],
               Throw[ Message[ genArchitecture::error3, sys[[1]] ] ] ]),
        True, Throw[Message[a2v::unknsys, sys[[1]]] ]
      ]; (* Which *)
    ];

    (* Extract the results *)
    {codevhdl, component, componentsUsed} = result;

    (* Write the component code in file componentFile *)
    Put[OutputForm[component],componentFile];

    (* Write the vhdl code *)
    If[ componentsUsed =!= {},
    componentTemp = 
    Map[
      Function[{x},
      Module[{ccc},
        With[{s = ReadList[ x<>".component", String ]},
          ccc = Apply[StringJoin,Table[s[[i]]<>"\n",{i,1,Length[s]}]]
        ];
(*
        Print["Component found:", ccc];
*)
        ccc
      ]
      ],componentsUsed];
    Put[
      OutputForm[
      StringReplace[
        codevhdl,"---------" -> Apply[StringJoin, componentTemp]]
      ], fd
    ],
      Put[ OutputForm[codevhdl], fd ]
    ];

    Print["Vhdl code was written in file ", sys[[1]]<>".vhd"];

    Print["Component description :"]; Print[component];

    If[ componentsUsed =!= {},
      Print["Components used :"]; Print[componentsUsed]];


]; (* Catch *)
  Close[fd];
  Close[componentFile];
];
a2vOneFile[___]:=Message[a2vOneFile::params];

(* 
  a2v takes a library of alpha systems, and generates vhd files for 
  each one of the systems. Prints out the translation times.
*)
Clear[a2v];
a2v::argt ="wrong parameters";
a2v::openwrite = "could not open an output file";
a2v::unknsys = 
"System `1` is neither recognized as a cell, a module or a controller.
To find out the problem, use the following sequence\n
getSystem[\"`1`\"];checkCell[debug->True];\n
getSystem[\"`1`\"];checkController[debug->True];\n
getSystem[\"`1`\"];checkModule[debug->True];\n
One of these command might explain why your system cannot 
be translated to Vhdl. Also, remember that a system cannot
be tranlsated to Vhdl if the parameter values haven't been 
set using the fixParameter function. ";
a2v::error1 = "Error while calling vhdlCont on `1`";
a2v::error2 = "Error while calling vhdlCell on `1`";
a2v::error3 = "Error while calling genModule on `1`";
a2v::error5 = "The value of option typeCell is wrong...";

a2v[x:_system, Tinit_Integer:0, opts:___Rule]:= 
	a2v[{x}, Tinit, opts ];
a2v[ Tinit_Integer:0, opts:___Rule ] := a2v[ $library, Tinit, opts ];
a2v[x:{__system}, Tinit_Integer:0, opts:___Rule]:= 
Module[{ fd, dbg, vrb, opttempFile, tp },

(*  Get options *)
  opttempFile = tempFile /. {opts} /. Options[ a2v ];
  vrb = verbose/.{opts}/.Options[a2v];
  dbg = debug/.{opts}/.Options[a2v];
  tp = cellType /. {opts} /. Options[a2v];

(*  Directory where Vhdl files are genenated *)
  If[ opttempFile, 
      dir="/tmp/";Print["Vhdl files will be generated in /tmp"], 
      dir=""];

  Catch[
    (*  Initialize $vhdlCurrent *)
    $vhdlCurrent={};	

    Print["\nPlease wait...\n"];

    If[ dbg, Print[ "Opening vhd file" ] ];

    (*  Open the output vhd file *)
    Check[ fd = OpenWrite[dir<>"definition.vhd",PageWidth->Infinity], 
           Throw[ Message[ a2v::openwrite ] ] ];

    (*  Write the header of the vhdl definition *)
    Put[ OutputForm["library IEEE;\nuse IEEE.std_logic_1164.all;\n use IEEE.std_logic_signed.all;\n
use IEEE.numeric_std.all;\n Package definition is \n"],fd];

    (*  Call a2vOneFile on each element of the library *)
    Map[ Print[ Part[ Timing[ a2vOneFile[#,opts]], 1 ],
                " needed to translate ", #1[[1]]]&, 
                 x ];

    (*  Write the footer of the vhdl definition *)
    Put[ OutputForm["end definition; \n"], fd];

    If[ optverbose, 
        Print[ "File: definition.vhd generated."];
        Map[ Print[ "File: ", #1[[1]]<>".vhd", " generated."]&, x];
    ];
    Print[ "End of translation."]

  ]; (* Catch *)
  Close[fd];     (* To make sure that file is closed, in case of abort *)
]; (* Module *)
av[___] := Message[av::params];

Attributes[av]={(*Locked, Protected, ReadProtected*)};

Clear[genLibrary];
genLibrary::usage = "genLibrary returns a string"; 
genLibrary::pb = "unable to decide if a declaration package was necessary."
genLibrary[ opts:___Rule ] := 
  Module[{ testPack, pack, res, cellule, dbg, vrb, stdl },
    dbg = debug /. {opts} /. Options[a2v];
    vrb = verbose /. {opts} /. Options[a2v];
    cp = compass /. {opts} /. Options[a2v];
    stdl = stdLogic /. {opts} /. Options[a2v];

    If[ dbg, Print["Calling genLibrary" ] ];
        testPack = packageDefQ[$vhdlCurrent];

(*
    In av, we had this statement, which I do not understand...
    pack = 
      If[ testPack,
          "-- Wonder if this is useful?\n"<>
          "library test;\nuse test.definition.all;\n\n",
          "",
          Message[genLibrary::pb];""];
*)
    pack = "\n"; 

    cellule = 
	   If[ checkCell[$vhdlCurrent]&&cp,
	       StringJoin[
		 "library COMPASS_LIB;\n use COMPASS_LIB.STDCOMP.all;\n", 
		 "library COMPASS_LIB; \n use COMPASS_LIB.COMPASS.all;\n "],
	       ""];
	 
    res = 

    StringJoin[
      If[ vrb||dbg, "\n-- The following was generated by genLibrary", ""],
      "\nlibrary IEEE;\n",
      "use IEEE.std_logic_1164.all;\nuse IEEE.std_logic_signed.all;\nuse IEEE.numeric_std.all;\n",
(*
      If[ stdl, "use IEEE.arith.all ... etc;\n", "" ],
*)
      cellule,
      pack,
      If[ vrb||dbg, "-- End genLibrary\n", ""] 
    ]; res
  
];

(************************************************************************)
(* packageDefQ -                                                        *)
(* In : a subsystem *)
(* Out: booleen                                                         *)
(* True if a definition package is necessary, i.e., the system contains
   an array *)
(************************************************************************)
(*
  This function is purely local to genLibrary. It returns True
  if a subSystem contains an array, in order to add a new declaration
  library
*)
Clear[packageDefQ];
packageDefQ[ system[_,domain[dPar_,_,_],in_,out_,loc_,_] ] :=  
Module[{ entierTabQ },

  (*
    This function is purely local to packageDefQ. It returns true
    if a list of declarations decla contains the declaration of
    an array
  *)
  Clear[entierTabQ];
  entierTabQ[decla_List,d_] := 
    Length[ 
      Cases[decla,
	    decl[_,integer,domain[dVar_,_,_]] /; ((dVar-d) > 1),
      Infinity ] ] > 0;
  entierTabQ[___]:=Throw[Message[entierTabQ::params]];

(* Body of packageDefQ *)
  entierTabQ[in,dPar] || entierTabQ[out,dPar] ||
     entierTabQ[loc,dPar] ]; 
packageDefQ[___]:=Throw[Message[packageDefQ::params]];

Clear[stim]

Options[stim]={debug->False}

stim[options___Rule]:=
Module[{},
  	  Print["Post processing stimuli files..."];
	  stimFiles=FileNames["stim*"];
	  tempFile=getTemporaryName[];
	  Do[curFile=stimFiles[[i]];
	     Run["sed 's/ /0/g' <",curFile," >",tempFile];
	     DeleteFile[curFile];
	     CopyFile[tempFile,curFile],
	     {i,1,Length[stimFiles]}]
    ]; 

stim::wrongArg="wrong Argument for function stim : `1` "

stim[a:___]:=Message[stim::wrongArg,Map[Head,{a}]]

End[];       (* Fin du contexte prive du package *)
EndPackage[] (* Fin du package Vhdl  *)


