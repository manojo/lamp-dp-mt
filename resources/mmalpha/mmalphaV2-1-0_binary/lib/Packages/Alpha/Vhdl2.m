BeginPackage["Alpha`Vhdl2`",
  {"Alpha`", 
   "Alpha`Domlib`",
   "Alpha`Semantics`",
   "Alpha`Tables`",
   "Alpha`Options`",
   "Alpha`Visual`",
   "Alpha`vhdlCell`",
   "Alpha`vhdlCont`",
(*                                      "Alpha`VhdlLibGen`", *)
   "Alpha`vhdlModule`",
   "Alpha`CheckCell`",
   "Alpha`CheckModule`",
   "Alpha`CheckController`"}
];

(* Standard head for CVS

	$Author: quinton $
	$Date: 2010/04/14 17:40:47 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Vhdl2.m,v $
	$Revision: 1.10 $
	$Log: Vhdl2.m,v $
	Revision 1.10  2010/04/14 17:40:47  quinton
	Function vhdlIDType was added. Some modifications done to genVhdl functions. Function checkVhdlIdentifiers added. Variable
	$vhdlTypes added and function findVarType.
	
	Revision 1.9  2009/05/22 10:24:37  quinton
	May 2009
	
	Revision 1.8  2008/12/29 17:47:59  quinton
	Quite modified to introduce new functions to generate Vhdl files from patterns. See genVhdl.
	
	Revision 1.7  2008/07/30 15:48:19  quinton
	Added a mute option.
	
	Revision 1.6  2008/04/21 19:48:28  quinton
	Added an option vhdlDir to function a2v. If True, the vhdl files are created in a local directory called VHDL. If False, the vhdl files are created in the current directory. If this option has a string value, it is used to define the directory
	
	Revision 1.5  2007/04/09 18:55:52  quinton
	Minor modifications
	
	Revision 1.4  2006/09/09 14:29:23  quinton
	Added test to check when use statements have non bounded extension interval. Vhdl is still generated in this case for modules, but a message is also emitted.
	
	Revision 1.3  2005/08/29 14:06:36  ebecheto
	Ed modif for truncate_*SB procedure
	
	Revision 1.2  2005/05/13 08:21:10  ebecheto
	Ed modif for truncate_*SB procedure
	
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

$vhdlTypes::usage =
"$vhdlTypes contains the types of the variables found in a module. 
Each entry has the form {var, vhdlType}";

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

noVhdlFile::usage = 
"noVhdlFile is an option of a2v. If true (default value is false), no 
vhdl file is produced, and instead, result is list of 2 strings";

vhdlPatterns::usage = 
"vhdlPatterns is an option of a2v. If true (by default) some particular
modules, such as ROM, address generators, etc. are assumed to be generated
using a pattern. Currently, patterns are in MMALPHA/VHDL.";

bitWidth::usage=
"bitWidth[sys,var] gives the bit width of variable var. Default 
value of sys is $result.";

bitWidthOfExpr::usage=
"bitWidth[sys,expr] gives the bit width of an expression. Default
of sys is $result.";

findVarType::usage =
"findVarType[ var ] returns the type entry found in $vhdlTypes";

getVhdlType::usage = 
"getVhdlType[sys,var] return the vhdl type of the element of array var";

showVhdl::usage = 
"showVhdl[] prints the Vhdl generated for the system in $result. 
showVhdl[s] show the content of the file s.vhd.";

stim::usage=
"stim[] post processes all the simuli files (replace blanks by zeros). 
These files are generated from a C code in hexadecimal and there is no 
format in C to write zeros in for the first digits.";

vhdlIDType::usage = 
"vhdlIDType[s] gives an indentifier summarizing the 
alpha type of an Alpha scalar type. It is used to build the 
names of array types";

vhdlType::usage = "vhdlType[s] gives the Vhdl type of a scalar 
alpha type (integer, boolean, integer[S,n] or integer[U,n]).";

vhdlDeclEnt::usage = 
"vhdl[{var,s},\"IN\"|\"OUT\"] returns the Vhdl declaration of variable
var, with scalar type s. Internal function.";

vhdlDeclArc::usage = "internal function.";

genLibrary::usage = 
"genLibrary[] generates the library statement. Internal function.";

genVhdl::usage = 

"genVhdl[ dir, name, subs ] reads the VHDL pattern file name.vhdx in
directory dir and produces a Vhdl file name.vhd after substitution of
some parameters in the content of name. The substititions are
specified in a sequence subs of rewriting rules of the forme $$parameter
-> string. A documentation of all patternss is given by ?vhdlPatterns.
genVhdl[ name, subs ] reads patterns in directory $vhdlPatternsDir";

vhdlPatterns::usage = 
"The list of VHDL pattern files available is ROM, etc.";

vhdlROM::usage = 
"ROM.vhdx is a ROM pattern. Its parameters are $$name etc.";

vhdlPeriodicEnable::usage = 
"PeriodicEnable.vhdx is a generator for a periodic enable signal. Its parameters
are $$name, $$periode.";

$vhdlPatternsDir = Environment[ "MMALPHA" ]<>"/VHDL";

Begin["`Private`"]; 

(* Arguments: size, wordLength, name, values *)
Clear[ genVhdl ];
genVhdl[ "ROM", r:___Rule ] :=
Catch[
    Module[ { component, archi, size, wordLength, name, addrLength, values, 
      comment, valuesDecoded },

    (* Size of the ROM *)
    size = StringReplace[ "$size$", {r} ];
    genVhdl::WordSize = "size of ROM is missing";
    genVhdl::WordSizeNotInt = 
      "Warning: size of ROM is not an integer. Check the Vhdl.";
    If[ size === "$size$", Throw[ Message[ genVhdl::WordSize ] ] ];
    If[ !IntegerQ[ToExpression[size]], Print[ genVhdl::WordSizeNotInt ] ];

    wordLength = StringReplace[ "$wordLength$", {r} ];
    genVhdl::RomWordLength = "word length of ROM is missing";
    If[ wordLength === "$wordLength$", 
      Throw[ Message[ genVhdl::RomWordLength ] ] ];

    name = StringReplace[ "$name$", {r} ];
    genVhdl::RomName = "name of ROM is missing";
    If[ name === "$name$", Throw[ Message[ genVhdl::RomName ] ] ];

    addrLength = Ceiling[ N[Log[2,ToExpression[size]]] ];

    values = StringReplace[ "$values$", {r} ];
    genVhdl::RomValues = "values of ROM `1` are missing. Vhdl generated anyway.";
    If[ name === "$values$", Message[ genVhdl::RomValues, name ] ];

    (* Check that values have a correct length *)
    valuesDecoded = ToExpression[ "{"<>values<>"}" ];

    If[!Apply[ And, Map[ ToExpression[wordLength] === StringLength[#]&, 
      valuesDecoded ] ]
    , 
      genVhdl::RomValuesLg = "some values of ROM `1` do not have a correct length. Vhdl generated anyway.";
      Message[ genVhdl::RomValuesLg, name ] 
    ];

    (* Check that number of values is correct *)
    If[ Length[ valuesDecoded =!= size ]
    , 
      genVhdl::RomValuesNm = "number of values of ROM `1` does not match the size of this ROM. Vhdl generated anyway.";
      Message[ genVhdl::RomValuesNm, name ] 
    ];

    comment = StringReplace[ "$comment$", {r} ];
    Check[
      archi = load[ $vhdlPatternsDir<>"/ROM.vhdx" ];
      component = load[ $vhdlPatternsDir<>"/ComponentOfROM.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, $vhdlPatternsDir<>"/ROM.vhdx" ] ]
    ];

    archi = StringReplace[ archi, 
      {"$values$" -> values, r, 
       "$wordLengthMun$"->ToString[ToExpression[wordLength]-1],
       "$sizeMun$" -> ToString[ToExpression[size]-1] }];
    component = StringReplace[ component, 
      {"$values$" -> values, r, 
       "$wordLengthMun$"->ToString[ToExpression[wordLength]-1],
       "$sizeMun$" -> ToString[ToExpression[size]-1] }];

    { component, archi }

  ]
];

(* Parameters are the name, the size (length of the register file)
 and a comment *)
genVhdl[ "Registers", r:___Rule ] :=
Catch[
  Module[ { component, archi, size, name, type, comment, sizeMun,
    sizeMDe, def, output },

    size = StringReplace[ "$size$", {r} ];
    genVhdl::RegSize = "size of register is missing";
    genVhdl::RegSizeNotInt = 
      "Warning: size of register is not an integer. Check the Vhdl.";
    If[ size === "$size$", Throw[ Message[ genVhdl::RegSize ] ] ];
    If[ !IntegerQ[ToExpression[size]], Print[ genVhdl::RegSizeNotInt ] ];

    sizeMun = ToString[ ToExpression[size] - 1 ];
    sizeMDe = ToString[ ToExpression[sizeMun] - 1 ];

    name = StringReplace[ "$name$", {r} ];
    genVhdl::RegName = "name of register is missing";
    If[ name === "$name$", Throw[ Message[ genVhdl::RegName ] ] ];

    comment = StringReplace[ "$comment$", {r} ];
    Check[
      archi = load[ $vhdlPatternsDir<>"/Registers.vhdx" ];
      component = load[ $vhdlPatternsDir<>"/ComponentOfRegisters.vhdx" ],
      genVhdl::regunknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::regunknownFile, 
        $vhdlPatternsDir<>"/Registers.vhdx" ] ]
    ];

    If[ size === "1", 
	type = "STD_LOGIC"; def = "regfile <= inreg"; output = "regfile",
        type = "STD_LOGIC_VECTOR (0 TO "<>sizeMun<>")"; 
	def = "regfile <= inreg & regfile(0 TO "<>sizeMDe<>")"; 
	output = "regfile(0)"
    ];

    archi = 
    StringReplace[ archi, { r, "$type$" -> type, "$def$" -> def,
      "$comment$" -> comment, "$output$" -> output } ];

    component = StringReplace[ component, { r, "$type$" -> type, "$def$" -> def,
      "$output$" -> output} ];

    { component, archi }

  ]
];

(* Parameters are the name, the size (length of the register file)
 and a comment *)
genVhdl[ "registerFile", r:___Rule ] :=
Catch[
  Module[ { component, archi, size, name, type, comment, sizeMun,
    sizeMDe, def, output },

    size = StringReplace[ "$size$", {r} ];

    genVhdl::RegSize = "size of register is missing";
    genVhdl::RegSizeNotInt = 
      "Warning: size of register is not an integer. Check the Vhdl.";
    If[ size === "$size$", Throw[ Message[ genVhdl::RegSize ] ] ];
    If[ !IntegerQ[ToExpression[size]], Print[ genVhdl::RegSizeNotInt ] ];

    sizeMun = ToString[ ToExpression[size] - 1 ];
    sizeMDe = ToString[ ToExpression[sizeMun] - 1 ];

    name = StringReplace[ "$name$", {r} ];
    genVhdl::RegName = "name of register is missing";
    If[ name === "$name$", Throw[ Message[ genVhdl::RegName ] ] ];

    comment = StringReplace[ "$comment$", {r} ];
    Check[
      archi = load[ $vhdlPatternsDir<>"/RegisterFile.vhdx" ];
      component = load[ $vhdlPatternsDir<>"/ComponentOfRegisterFile.vhdx" ],
      genVhdl::regunknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::regunknownFile, 
        $vhdlPatternsDir<>"/Registers.vhdx" ] ]
    ];

    archi = 
    StringReplace[ archi, 
    { r, "$comment$" -> comment } ];

    component = StringReplace[ component, 
    { r, "$comment$" -> comment } ];

    { component, archi }

  ]
];

genVhdl[ "CallFsm", outputs:{__String}, r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    op = outputs;
    op = Append[ Map[ #<>", "&, Drop[ op, -1 ] ], Last[ op ]];
    op = StringJoin[ op ];

    Check[
      archi = load[ $vhdlPatternsDir<>"/CallFsm.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, $vhdlPatternsDir<>"/fsm.vhdx" ] ]
    ];

    archi = StringReplace[ archi, {"$outputs$" -> op, r } ]

  ]
];

(* Generator fot a call to periodic enable function *)
genVhdl[ "CallPeriodicEnable", r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/CallPeriodicEnable.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, $vhdlPatternsDir<>"/CallPeriodicEnable.vhdx" ] ]
    ];

    archi = StringReplace[ archi, { r } ]

  ]
];

(* Generation of a call to a single register *)
genVhdl[ "CallReg", r:___Rule ] :=
Catch[
  Module[ { archi, op, size },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/CallReg.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/CallRegisters.vhdx" ] ]
    ];

    size = "$size$"/.{r};
    If[ size =!= 1, 
      Print[ "Warning: could not generate a register of size ",
         size, " for signals ", "$lhs$"/.{r}, " and ",
				 "$rhs$"/.{r} ] ];

    archi = StringReplace[ archi, { r } ]

  ]
];

(* Generation of a call to a register file *)
genVhdl[ "CallRegisterFile", r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/CallRegisterFile.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/CallRegisterFile.vhdx" ] ]
    ];

    archi = StringReplace[ archi, { r } ]

  ]
];


(* Generation of a call to a register file, for enable signals *)
genVhdl[ "CallRegisters", r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/CallRegisters.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/CallRegisters.vhdx" ] ]
    ];

    archi = StringReplace[ archi, { r } ]

  ]
];

(* The parameters of this functions are its name, its period (a string)
 an optional comment, the period minus 1 as a binary string *)
genVhdl[ "PeriodicEnable", r:___Rule ] :=
Catch[
  Module[ { component, archi, period, periodMun, name, periodInBin, comment, 
            counterSize, zero },

    name = StringReplace[ "$name$", {r} ];
    genVhdl::PEName = "name of periodic enable is missing";
    If[ name === "$name$", Throw[ Message[ genVhdl::PEName ] ] ];

    period = StringReplace[ "$period$", {r} ];
    genVhdl::PEPeriod = "period of periodic enable is missing";
    If[ period === "$period$", Throw[ Message[ genVhdl::PEPeriod ] ] ];

    comment = StringReplace[ "$comment$", {r} ];

    periodInBin = ToExpression[ period ];
    periodMunInBin = ToExpression[ period ] - 1;

    periodInBin = IntegerDigits[ periodInBin, 2 ];
    periodMunInBin = IntegerDigits[ periodMunInBin, 2 ];
    counterSize = Length[ periodMunInBin ] - 1;

    periodInBin = Map[ ToString, periodInBin];
    periodMunInBin = Map[ ToString, periodMunInBin];
    periodInBin = "\""<>Apply[ StringJoin, periodMunInBin]<>"\"";
    periodMunInBin = "\""<>Apply[ StringJoin, periodMunInBin]<>"\"";

    zero = "\""<>Apply[ StringJoin, Table[ "0", {i,0,counterSize} ] ]<>"\"";

    Check[
      archi = load[ $vhdlPatternsDir<>"/PeriodicEnable.vhdx" ];
      component = load[ $vhdlPatternsDir<>"/ComponentOfPeriodicEnable.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, $vhdlPatternsDir<>"/ROM.vhdx" ] ]
    ];

    archi = StringReplace[ archi, 
      {r, "$periodMun$"->ToString[periodMunInBin], 
          "$periodInBin$"->ToString[periodInBin], 
          "$size$" -> ToString[counterSize],
          "$zero$" -> zero
      } ];
    component = StringReplace[ component, 
      {r,  "$size$" -> ToString[counterSize]
      } ];

    { component, archi }

  ]
];

(* Arguments: name, period, comment *)
genVhdl[ "ModuloAddress", r:___Rule ] :=
Catch[
  Module[ { component, archi, period, periodMun, name, comment },

    name = StringReplace[ "$name$", {r} ];
    genVhdl::MAName = "name of modulo address is missing";
    If[ name === "$name$", Throw[ Message[ genVhdl::MAName ] ] ];

    period = StringReplace[ "$period$", {r} ];
    genVhdl::MAPeriod = "period of modulo address is missing";
    If[ period === "$period$", Throw[ Message[ genVhdl::MAPeriod ] ] ];

    comment = StringReplace[ "$comment$", {r} ];

    periodMun = 
      Which[ 
        MatchQ[ period, _Integer ], period - 1, 
        MatchQ[ period, _String ],  ToExpression[ period ] - 1,
        True, Throw[ 
          genVhdl::MAperiod = "period must be an integer or a string";
          Message[ genVhdl::MAperiod ] ] 
    ];

    (* Eliminate the case of period less than 2 ! *)
    If[ periodMun == 0,
      genVhdl::MASize = "Size of address must be greater than 0";
      Throw[ Message[ genVhdl::MAsize ] ]
    ];

    periodMun = ToString[ periodMun ];

    Check[
      archi = load[ $vhdlPatternsDir<>"/ModuloAddress.vhdx" ];
      component = load[ $vhdlPatternsDir<>"/ComponentOfModuloAddress.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/ModuloAddress.vhdx" ] ]
    ];

    archi = StringReplace[ archi, 
      {r, "$periodMun$"->ToString[periodMun] } ];
    component = StringReplace[ component, 
      {r, "$periodMun$"->ToString[periodMun] } ];

    { component, archi }

  ]
];

genVhdl[ "Fsm", outputs:{__String}, 
    seq:{{_Integer,_String}..}, r:___Rule ] :=
Catch[
  Module[ { component, archi, name, comment, states, actions, encoding,
            numberOfDigits, values, op, sequence },

    name = StringReplace[ "$name$", {r} ];
    genVhdl::FsmName = "name of fsm is missing";
    If[ name === "$name$", Throw[ Message[ genVhdl::FsmName ] ] ];

    comment = StringReplace[ "$comment$", {r} ];

    (* Get the outputs *)
    op = Map[ "    "<>#<>" : OUT STD_LOGIC"&, outputs];
    op = Append[ Map[ #<>";\n"&, Drop[ op, -1 ] ], Last[ op ]];
    op = StringJoin[ op ];

    (* Always have an initial state, even with no action *)
    sequence = seq;
    If[ sequence[[1,1]] =!= 0, sequence = Prepend[ sequence, {0,""}] ];

    (* Extract the states *)
    values = Map[ First, sequence ];
    states = Map[ "state"<>ToString[#]&, values ];
    (* Add a final state *)
    states = Append[ states, "final" ];

    (* Remove first value, and add final one *)
    values = Append[ Drop[ values, 1 ], Last[ values ] + 1 ];

    (* Get the encoding of the states *)
    numberOfStates = Length[ states ];
    encoding = Range[ 0, numberOfStates-1 ];
    numberOfDigits = Ceiling[ N[ Log[2, numberOfStates ] ] ];
    encoding = Map[ IntegerString[ #, 2, numberOfDigits ]&, encoding ];
    encoding = Append[ Map[ #<>" "&, Drop[ encoding, -1 ] ], 
			    Last[ encoding ] ];
    encoding = "\""<>Apply[ StringJoin, encoding ]<>"\"";

    (* Get the transitions *)
    transitions = MapThread[ 
      Function[{s,v,n},
        "    WHEN "<>s<>" => IF count = "<>ToString[v]<>" THEN nextstate <= "
        <>n<>
        ";\n      ELSE nextstate <= "<>s<>"; END IF;\n"],
  { Drop[ states, -1], values, Drop[ states, 1 ] } ];
    transitions = Append[ transitions, 
      "    WHEN "<>Last[ states ]<>" => nextstate <= "<>Last[ states ]<>";" ];
    transitions = Apply[ StringJoin, transitions ];

    (* Compute the actions *)
    (* Remove instants with no signal *)
    actions = Select[ sequence, #[[2]] =!= ""& ];
    actions = Map[ {"state"<>ToString[#[[1]]],#[[2]]}&, actions ];
    actions = Map[
      #[[2]]<>" <= '0' WHEN curstate = "<>#[[1]]<>" ELSE '1';\n"&,
      actions
    ];
    actions = Apply[ StringJoin, actions ];

    states = StringDrop[ StringDrop[ ToString[ states ], -1 ], 1 ];

    Check[
      archi = load[ $vhdlPatternsDir<>"/Fsm.vhdx" ];
      component = load[ $vhdlPatternsDir<>"/ComponentOfFsm.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, $vhdlPatternsDir<>"/fsm.vhdx" ] ]
    ];

    archi = StringReplace[ archi, 
      {"$states$" ->  states, 
       "$transitions$" -> transitions,
       "$actions$" -> actions, 
       "$encoding$" -> encoding, 
       "$outputs$" -> op, r } ];
    component = StringReplace[ component, 
      {"$states$" ->  states, 
       "$transitions$" -> transitions,
       "$actions$" -> actions, 
       "$outputs$" -> op, r } ];

    { component, archi }

  ]
];

(* Generation of use. Parameters are the number of the generate label, 
  the name of the called module, and the list of arguments *)
genVhdl[ "Use", r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/Use.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/Use.vhdx" ] ]
    ];

    archi = StringReplace[ archi, { r } ]

  ]
];

(* Generation of use loop. Gx: for p in lb to up etc.
  Parameters are 
  $label1$ : the external label 
  $label2$ : the internal label
  $lb$: the lower bound
  $ub$: the upper bound
  $name$: the name of the called system
  $arguments$: the arguments
 *)
genVhdl[ "UseLoop", r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/UseLoop.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/UseLoop.vhdx" ] ]
    ];

    archi = StringReplace[ archi, { r } ]

  ]
];

(* Generation of use double loop. Gx: for p1 in lb1 to up1 etc.
  Parameters are 
  $label1$ : the first loop label 
  $label2$ : the second loop label 
  $label2$ : the internal label
  $lb1$, $lb2$: the lower bounds
  $ub1$, $ub2$: the upper bounds
  $name$: the name of the called system
  $arguments$: the arguments
 *)
genVhdl[ "UseDoubleLoop", r:___Rule ] :=
Catch[
    Module[ { archi, op },

    (* Get the outputs *)
    Check[
      archi = load[ $vhdlPatternsDir<>"/UseDoubleLoop.vhdx" ],
      genVhdl::unknownFile = "could not read file `1`";
      Throw[ Message[ genVhdl::unknownDir, 
        $vhdlPatternsDir<>"/UseLoop.vhdx" ] ]
    ];

    archi = StringReplace[ archi, { r } ]

  ]
];


genVhdl::err := "Error while calling genVhdl";
genVhdl[x:___]:=(Print[{x}];Message[genVhdl::params];)

Options[ a2v ] := { debug -> False, verbose -> False, tempFile -> False, 
  cellType -> Null, compass -> False, compactCode -> False, 
  clockEnable -> True, vhdlLibrary -> "", skipLines -> False, 
  compactCode -> False, stdLogic -> True, initialize -> False,
  lyrtech -> False, vhdlDir -> False, mute -> False, vhdlPatterns -> False,
  noVhdlFile -> False
 }; 

(* Finds the entry type in $vhdlTypes *)
Clear[findVarType];
findVarType[ v:_String, opts:___Rule ] :=
Catch[
  Module[{e},
    e = Select[ $vhdlTypes, First[#] === v& ];
    Which[ 
      Length[e] === 1
    , 
      First[e]
    ,
      Length[e] === 0
    , 
      findVarType::noentry = "no entry in $vhdlTypes for variable `1`";
      Throw[ Message[ findVarType::noentry, v ]; {} ]
    ,
      True
    , 
      findVarType::severalentry = "several entries in $vhdlTypes for variable `1`";
      Throw[ Message[ findVarType::severalentry, v ]; {} ]
    ]
  ]
];
getVhdlType::err := "Error while calling getDeclaration";
getVhdlType[___]:=Message[getVhdlType::params];
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

(* This function returns an indentifier for the type of an Alpha expression *)
Clear[vhdlIDType];
vhdlIDType[ t:boolean, opts:___Rule ]:=  "Boolean";
vhdlIDType[ t:integer, opts:___Rule ]:=  "Integer";
vhdlIDType[ t:integer["U",k:_Integer], opts:___Rule ]:=  
Module[ {stdl, init},
  stdl = stdLogic/.{opts}/.Options[ a2v ];
  init = initialize/.{opts}/.Options[ a2v ];
  If[ !stdl, 
      "Integer0To"<>ToString[2^(t[[2]]-1)-1],
      "Unsigned"<>ToString[k-1]<>"To0"
  ]
];
vhdlIDType[ t:integer["S",k:_Integer], opts:___Rule]:=  
Module[ {stdl, init},
  stdl = stdLogic/.{opts}/.Options[ a2v ];
  If[ !stdl, 
    With[{n = 2^(t[[2]]-1)},
    "IntRange"<>
           ToString[-n]<>"To "<>
           ToString[n-1]
    ],
    "Signed"<>ToString[k-1]<>"To0"
  ]
];
vhdlIDType::typeUnknown = "this type `1` is unknown";
vhdlIDType[x:___] := (Print[{x}[[1]]];Message[vhdlType::typeUnknown,{x}];"");

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
  "\n  "<>v<>" : "<>inout<>vhdlType[t, opts, initialize -> False];
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
Module[{dir, tmp, locvar, optvhdlDir},
  tmp = tempFile/.{opts}/.Options[a2v];
  optvhdlDir = vhdlDir/.{opts}/.Options[a2v];

  (* vhdlDir supersedes tempfile *)
  dir = Directory[]<>"/";
  If[ optvhdlDir, opttempFile = False; dir = dir<>"/VHDL/" ];
  If[ StringQ[ optvhdlDir], opttempFile = False; dir=Directory[]<>"/"<>
    optvhdlDir<>"/"];
  If[tmp, dir = "/tmp/"];

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
        optdebug, lib, result, componentFile, componentsTemp, 
        opttempFile, optvhdlDir, dir, optMute, optNF, typeDeclarations
        },

  opttempFile = tempFile /. {opts} /. Options[ a2v];
  optvhdlDir = vhdlDir /. {opts} /. Options[ a2v];
  optverbose = verbose /. {opts} /. Options[ a2v ];
  optdebug = debug /. {opts} /. Options[ a2v ];
  tp = cellType /. {opts} /. Options[ a2v ]; 
  optMute = mute /. {opts} /. Options[ a2v ]; 
  optNF = noVhdlFile /. {opts} /. Options[ a2v ];
  
  If[ optNF,
    (* If option noVHDL file is true, do not open files, but set 
      value of reference dir to current directory *)
    dir = Directory[]<>"/",
    dir = Directory[]<>"/";
    If[ optvhdlDir, opttempFile = False; dir = dir<>"/VHDL/" ];
    If[ StringQ[ optvhdlDir], opttempFile = False; dir= dir<>"/"<>
      optvhdlDir<>"/"];
    If[ opttempFile, dir = "/tmp/"];
  ];

  Catch[
    If[ optverbose || optdebug, Print["Translating ", sys[[1]] ] ];
    $vhdlCurrent = sys;
    $vhdlTypes = {};

    (* Only if option no vhdl files is false *)
    If[ !optNF,
      Check[
        fd = 
          OpenWrite[ dir<>sys[[1]]<>".vhd", PageWidth->Infinity]
      ,
        Throw[ Message[ a2v::openwrite ] ] 
      ];

      Check[
        componentFile = 
          OpenWrite[ dir<>sys[[1]]<>".component", PageWidth->Infinity]
      ,
        Throw[ Message[ a2v::openwrite ] ] 
      ];
    ];

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

      (* In a previous version, vhdl code would not be generated when an
       error was detected. Now, code is generated, as it may help understand
       why errors happen *)
      Which[
        checkController[sys], 
          (If[ !optMute, Print[ sys[[1]], " was recognized as a Controller."] ];
          Check[ result = vhdlCont[ sys, vhdlLibrary -> lib, opts ], 
               Message[ a2v::error1, sys[[1]] ] ]),
        checkCell[sys],
          (If[ !optMute, Print[ sys[[1]], " was recognized as a Cell."] ];
          Check[ result = vhdlCell[ sys, vhdlLibrary -> lib, opts ], 
               Message[ a2v::error2, sys[[1]] ] ]),
        checkModule[sys],  
          (If[ !optMute, Print[ sys[[1]], " was recognized as a Module."] ];
          Check[ result = vhdlModule[ sys, vhdlLibrary -> lib, opts ],
               Message[ a2v::error3, sys[[1]] ] ]),
        True, Throw[Message[a2v::unknsys, sys[[1]]] ]
      ]; (* Which *)
    ];

    (* Extract the results. For a cell, or a controller, we have
      3 elements, for a module, we have 4 elements  *)
    If[ Length[ result ] === 3,
      {codevhdl, component, componentsUsed} = result;
      typeDeclarations = Null,
      {codevhdl, typeDeclarations, component, componentsUsed} = result
    ];

    (* If a package has to be written, open file, and write package later.
     NB: several packages may be written...  *)
    If[ typeDeclarations =!= Null && !optNF,
      Check[
       packageFile = 
          OpenWrite[
            dir<>"package"<>sys[[1]]<>".vhd",
            PageWidth->Infinity],
            Throw[ Message[ a2v::openwrite ] ] 
       ]
    ];


    (* We have in any case, to add to the VHDL component declaration the
     component declarations of the uses, for the components that are available
     in the directory *)

    (* Remove predefined elements from components used *)
    componentsUsed = Complement[ componentsUsed, {"ROM", "underSampling", 
     "overSampling", "ModuloAddress", "registerFile" } ];

    If[ componentsUsed =!= {},
      componentsTemp = 
      Map[
        Function[{x},
          Module[{ccc,s},
            If[ FileInformation[ dir<>x<>".component" ] =!= {},
              s = ReadList[ dir<>x<>".component", String ];
              ccc = "\n-- Component for "<>x<>"\n"<>
                Apply[StringJoin,Table[s[[i]]<>"\n",{i,1,Length[s]}]],
              Print[ " ***** Warning: component ", x<>".component not found",
		       " in directory "<>dir];
              ccc ="***** Warning: component "<>x<>".component not found\n"<>
                "Do not forget to add it in the directory.\n";
            ];
            ccc
          ]
        ],
        componentsUsed
      ];
 
     (* Update codevhdl *)
      codevhdl = 
        StringReplace[
          codevhdl,"---------" -> 
          "\n\n-- Components for calls to external functions\n"<>
          Apply[StringJoin, componentsTemp]
        ];
    ];

    (* Only if the option noFile is not set *)
    If[ !optNF,
      (* Write the package code in file packageFile *)
      If[ typeDeclarations =!= Null,
      Put[ OutputForm[typeDeclarations], packageFile ] ];

      (* Write the component code in file componentFile *)
      Put[OutputForm[component],componentFile];

      (* Write the vhdl code *)
      Put[ OutputForm[codevhdl], fd ];

      If[ !vrb, 
        Print["Vhdl code was written in file ", dir<>sys[[1]]<>".vhd"];

        Print["Component description :"]; Print[component];

        If[ componentsUsed =!= {},
          Print["Components used :"]; Print[componentsUsed]];
      ]
    ];

  ]; (* Catch *)

  If[ ! optNF, 
    (* When option no file is not set, close files *)
    If[ typeDeclarations =!= Null, Close[packageFile] ];
    Close[fd];
    Close[componentFile]
  ,  
    (* Otherwise, return result, after update  *)
    If[ Length[ result ] === 3,
      result = {codevhdl, component, componentsUsed},
      result = {codevhdl, typeDeclarations, component, componentsUsed}
    ];
    result
  ]
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
Module[{ fd, dbg, vrb, opttempFile, tp, outputFormated, optvhdlDir, optMute, optNF, res},

  (* Locally defined function. *)
  Clear[vhdlHeader];
  vhdlHeader::usage = "vhdlHeader[id] creates the header of the vhd file. "; 
  vhdlHeader[idf:_String]:= 
  Module[
    { date, jj, mm, aa, hh, mn, ss },

    jj=ToString[Date[][[3]]]; 
    mm=ToString[Date[][[2]]]; 
    aa=ToString[Date[][[1]]];
    hh=ToString[Date[][[4]]]; 
    mn=ToString[Date[][[5]]]; 
    ss=ToString[Date[][[6]]];
    date = StringJoin["-- ",jj,"/",mm,"/",aa," ",hh,":",mn,":",ss,"\n"];
    StringJoin[
      "-- VHDL Model Created for system \"",
      idf,
      "\" \n",
      date,
      "-- by Alpha2Vhdl Version 0.9 "
    ]
  ];
  vhdlHeader[___] := Throw[Message[vhdlHeader::params]];

(* Initialize $vhdlTypes *)
  $vhdlTypes = {};

(*  Get options *)
  opttempFile = tempFile /. {opts} /. Options[ a2v ];
  optvhdlDir = vhdlDir /. {opts} /. Options[ a2v ];
  vrb = verbose/.{opts}/.Options[a2v];
  dbg = debug/.{opts}/.Options[a2v];
  tp = cellType /. {opts} /. Options[a2v];
  optMute = mute /. {opts} /. Options[a2v];
  optNF = noVhdlFile /. {opts} /. Options[ a2v ];

  If[ !optNF, 
    (*  Directory where Vhdl files are genenated *)
    dir = Directory[]<>"/";
    If[ optvhdlDir , opttempFile = False; dir=Directory[]<>"/VHDL/"];
    If[ StringQ[ optvhdlDir], opttempFile = False; dir=Directory[]<>"/"<>
      optvhdlDir<>"/"];
    If[ opttempFile, dir="/tmp/" ];

    If[ FileInformation[ dir ] === {}, CreateDirectory[ dir ] ];

    (* Ed Try to modif
     dir="/tmp/"; If[ !optMute, Print["Vhdl files will be generated in /tmp"] ], 
     dir=""*)

     If[ !optMute, Print["Vhdl files will be generated in ",dir] ],
     If[ !optMute, Print["No Vhdl files will be generated"] ];
  ];

  Catch[
    (*  Initialize $vhdlCurrent *)
    $vhdlCurrent={};	

    If[ !optMute,  Print["\nPlease wait...\n"] ];

    If[ dbg, Print[ "Opening vhd file" ] ];

    If[ !optNF,
      (*  Open the output vhd file *)
      Check[ fd = OpenWrite[dir<>"definition.vhd",PageWidth->Infinity], 
             Throw[ Message[ a2v::openwrite ] ] 
      ];
    ];

    (*  Writing of the truncate procedure Ed modif 22/07/05  *)

    (*  Clear[outputFormated]; ???? 
     This does not work...
     outputFormated = vhdlHeader["definition.vhd"]<>ToVhdlPackage[];
    *)
    outputFormated = vhdlHeader["definition.vhd"];

    If[ !optNF, Put[ OutputForm[outputFormated], fd] ];

    (*  Call a2vOneFile on each element of the library *)
    (* This statement is pretty unreadable, sorry. The With part
       is here to compute effectively the translation, and then
       the time message is issued only if the mute option is not
       set... *)
    res = 
    Map[ 
	With[ { y = Timing[ a2vOneFile[#,opts]] },
          If[ !optMute, Print[ Part[ y,  1 ],
           " needed to translate ", #1[[1]]] ]; 
        If[ optNF, Part[ y, 2 ] ]
        ]&, 
        x 
    ];
  

    If[ optverbose, 
        Print[ "File: definition.vhd generated."];
        Map[ Print[ "File: ", #1[[1]]<>".vhd", " generated."]&, x];
    ];

    (* Remove component files *)

    (*
    Module[ {fileToDelete}, 
      If[ !optvhdlDir,
	  fileToDelete = FileNames[ "*.component"];
          DeleteFile[ fileToDelete ],
	  fileToDelete = FileNames[ "*.component", vhdlFile ];
      ];
    ];
     *)

    If[ !optMute, Print[ "End of translation."] ]

  ]; (* Catch *)

  If[ !optNF,
    Close[fd];     (* To make sure that file is closed, in case of abort *)
  ]; res

]; (* Module *)
a2v[___] := Message[av::params];

Attributes[av]={(*Locked, Protected, ReadProtected*)};

Clear[genLibrary];
genLibrary::usage = "genLibrary returns a string"; 
genLibrary::pb = "unable to decide if a declaration package was necessary."
genLibrary[ opts:___Rule ] := 
  Module[{ testPack, pack="", res, cellule, dbg, vrb, stdl },
    dbg = debug /. {opts} /. Options[a2v];
    vrb = verbose /. {opts} /. Options[a2v];
    cp = compass /. {opts} /. Options[a2v];
    stdl = stdLogic /. {opts} /. Options[a2v];

    If[ dbg, Print["Calling genLibrary" ] ];
        testPack = packageDefQ[$vhdlCurrent];

    (* Previous comment by ...? 
    In av, we had this statement, which I do not understand...

    pack = 
      If[ testPack,
          "-- Could be useful\n"<>
          "library test;\nuse test.definition.all;\n\n",
          "",
          Message[genLibrary::pb];""];
     *)

    (* Modified by Ed but should be improved later  
    pack ="\nlibrary work;\nuse work.definition.all;\n\n"; 
    *)

    pack = ""; (* Modified by PQ, October 2008 *)
    cellule = 
	   If[ checkCell[$vhdlCurrent]&&cp,
	       StringJoin[
		 "library COMPASS_LIB;\n use COMPASS_LIB.STDCOMP.all;\n", 
		 "library COMPASS_LIB; \n use COMPASS_LIB.COMPASS.all;\n "],
	       ""];
	 
    res = 
    StringJoin[
      If[ vrb||dbg, "\n\n-- The following was generated by genLibrary", ""],
      "\nLIBRARY IEEE;\n",
      "USE IEEE.std_logic_1164.all;\nUSE IEEE.std_logic_signed.all;",
      "\nUSE IEEE.numeric_std.all;\n",
(*
      "\n\nUSE work.types.all;\n",
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


