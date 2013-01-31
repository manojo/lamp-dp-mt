BeginPackage["Alpha`vhdlTestBench`",
{"Alpha`",
 "Alpha`Domlib`",
 "Alpha`Tables`",
 "Alpha`Matrix`", 
 "Alpha`Options`", 
 "Alpha`Vhdl2`", 
 "Alpha`Visual`",
		       (* "Alpha`VertexSchedule`", *)
 "Alpha`Substitution`",
 "Alpha`Static`",
 "Alpha`Semantics`",
 "Alpha`CheckModule`", 
 "Alpha`CheckCell`", 
 "Alpha`CheckController`", 
 "Alpha`VertexSchedule`", 
 "Alpha`Alphard`"
}
];

(* Standard head for CVS

	$Author: quinton $
	$Date: 2008/12/29 17:55:02 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/VhdlTestBench.m,v $
        $Revision: 1.7 $
	$Log: VhdlTestBench.m,v $
	Revision 1.7  2008/12/29 17:55:02  quinton
	Minor corrections.
	
	Revision 1.6  2005/07/04 08:26:17  ebecheto
	little modif of a typing error
	
	Revision 1.5  2005/05/20 13:18:49  trisset
	correct VhdlTestBench.m
	
	Revision 1.4  2005/05/13 08:21:10  ebecheto
	Ed modif for truncate_*SB procedure
	
	Revision 1.3  2005/03/31 13:43:24  trisset
	update VhdlTestBench for 2D array (started)
	
	Revision 1.2  2005/03/14 16:18:59  trisset
	added VhdlTestBench
	
	Revision 1.1  2005/03/14 14:39:11  trisset
	added VhdlTestBench
	
	Revision 1.2  2004/04/26 08:34:14  risset
	added system File before patrice visit
	
	Revision 1.1  2003/12/12 13:13:24  risset
	 add vhdlTestBench
	

*)
(*

 Generation of test bench files from Alphard 
 
*)

VhdlTestBanch::usage = 
"Package,contains definition of funtion for generating test benches for VHDL generated from Alphard"
vhdlTestBenchGen::usage="vhdlTestBenchGen[sys] generates a VHDL test bench for  the VHDL component generated from sys with the a2v command. sys mustbe a valid Alphard system, it works if sys is a cell, a module or a controller (not an interface), as for a2v, the parameters must be assigned. vhdlTestBenchGen[] applies on $result"

mkVhdlLoop::usage="test"
mkVhdlLowerBound::usage="test"
mkVhdlUpperBound::usage="test"

alpHardStim::usage = 
"alphaHardStim[] generates stimuli files from the description of a AlpHard program with 
fixed parameters. These stimuli files follow the execution order of the VHDL 
program synthesized by the a2v command.";

Options[ alphHardStim ] := { verbose -> False, debug -> False };

minValue::usage =
"minValue[ t ] returns the minimum value allowed for Alpha type t";

maxValue::usage =
"maxValue[ t ] returns the maximum value allowed for Alpha type t";

storeVariable::usage = 
"storeVariable[ v, min, max ] stores in file stimvar.txt the values 
v[ min ] through v[ max ] of Mathematica function v by steps of one. 
Result is written line by line with the form var[ i ] = value. This file can 
be read afterwards by the stimuli generator";

Begin["`Private`"];

Clear[ storeVariable ];
storeVariable[ v:_Symbol, min:_Integer, max:_Integer ]:=
Catch[
  Module[ { file, fileName },
    fileName = "stim"<>ToString[ v ]<>".txt";
    file = OpenWrite[ fileName, PageWidth -> Infinity ];

    Do[ 
       Put[ OutputForm[ToString[v]<>"[ "<>ToString[i]<>" ] = "<>ToString[ v[i] ] ], file ]
    ,
      { i, min, max }
    ];

    Close[ file ]

  ];
];
storeVariable[ ___ ] := Message[ storeVariable::params ];

Clear[ minValue ];
minValue[ type:_, opts:___Rule ] :=
Catch[
  Module[ { dbg, mv },
    dbg = debug/.{opts}/.Options[alpHardStim];
    mv = 
    Which[
      type === integer
    ,
      -2^31 
    ,
      MatchQ[ type, integer["S", _ ] ]
    , 
      -2^(type[[2]] - 1) 
    ,
      MatchQ[ type, integer["U", _ ] ]
    , 
      0
    ,
      boolean
    ,
      0
    ,
      True
    ,
      minValue::erroroftype = "type `1` not recognized";
      Message[ minValue::erroroftype, type ];
    ];

    If[ dbg, Print[ "Min value : ", mv ] ];

    mv

  ]
];
minValue[ ___ ] := Message[ minValue::params ];

Clear[ maxValue ];
maxValue[ type:_, opts:___Rule ] :=
Catch[
  Module[ { dbg, mv },
    dbg = debug/.{opts}/.Options[alpHardStim];
    mv = 
    Which[
      type === integer
    ,
      2^(31) - 1 
    ,
      MatchQ[ type, integer["S", _ ] ]
    , 
      2^(type[[2]] - 1) - 1 
    ,
      MatchQ[ type, integer["U", _ ] ]
    , 
      2^(type[[2]]) - 1
    ,
      boolean
    ,
      1
    ,
      True
    ,
      maxValue::erroroftype = "type `1` not recognized";
      Message[ maxValue::erroroftype, type ];
    ];

    If[ dbg, Print[ "Max value : ", mv ] ];

    mv
  ]
];
maxValue[ ___ ] := Message[ maxValue::params ];


Clear[alphHardStim];
alpHardStim[ opts:___Rule ]:=
Catch[
    Module[ { dbg, vrb, inpts, locals, equs },

    dbg = debug/.{opts}/.Options[ alpHardStim ];
    vrb = verbose/.{opts}/.Options[ alpHardStim ];

    If[ !checkModule[], 
      alpHardStim::notmodule = 
        "$result should be a VHDL module, i.e. checModule must return True";
      Throw[ Message[ alpHardStim::notmodule ] ];
    ];

    If[ getSystemParameters[] =!= {},
      alpHardStim::wrgparams = 
        "$result should not contain parameters, these must have been set before...";
      Throw[ Message[ alpHardStim::wrgparams ] ];
    ];

    inpts = getInputVars[];
    equs = Cases[ $result[[6]], equation[ x_, affine[ var[i_], m:matrix[__] ] ]/;MemberQ[inpts,i] ];

    locals = Map[ First, equs ];
    If[ dbg, Print[ locals ] ];

    (* Case of input variables *)
    Do[
      Module[ { lhs, dom, procs, time, indices, procsIndices, mat, timelb, timeub, rhs,
        alpHardStimFile, translation, minV, maxV, type },
        lhs = equs[[i,1]];
        rhs = equs[[i,2,1,1]];

        If[ dbg, Print[ "lhs: ", lhs ] ];
        If[ dbg, Print[ "rhs: ", rhs ] ];
        dom = getDeclarationDomain[ lhs ];
        If[ dbg, Print[ "Def domain: ", ashow[ dom, silent -> True ] ] ];
        indices = dom[[2]];

        If[ indices[[1]] =!= "t", 
          alpHardStim::noindextime = 
            "first index of all variables should be \"t\"...";
          Throw[ Message[ alpHardStim::noindextime ] ];
        ];

        If[ indices[[2]] =!= "p", 
          alpHardStim::noproctime = 
            "second index of all variables should be \"p\"...";
          Throw[ Message[ alpHardStim::noindextime ] ];
        ];

        procIndices = Drop[ indices, 1 ];
        procs = DomProject[ dom, procIndices ];
        If[ dbg, Print[ "Proc domain: ", ashow[ procs, silent -> True ] ] ];
        procbounds = getBoundingBox[ procs ];
        If[ dbg, Print[ "proc bounds: ", procbounds ] ];

        If[ Length[ procIndices ] =!= 1,
          alpHardStim::procdim = 
           "currently supporting only unidimensional proc variables...";
          Throw[ Message[ alpHardStim::procdim ] ];
        ];

        If[ procbounds[[1,1]] =!= procbounds[[1,2]],
          alpHardStim::arrayInput = 
            "variable `1` is not read sequentially on a single input port...";
          Throw[ Message[ alpHardStim::arrayInput ] ];
        ];

        time = DomProject[ dom, {"t"} ]; 
        If[ dbg, Print[ "time domain: ", ashow[ dom, silent -> True ] ] ];
        tbounds = getBoundingBox[ time ];
        If[ dbg, Print[ "time bounds: ", tbounds ] ];

        If[ !MatchQ[ tbounds, {{_Integer, _Integer}} ],
          alpHardStim::timebounds = 
            "time bounds should be finite integers...";
          Throw[ Message[ alpHardStim::timebounds ] ];
        ];
        timelb = tbounds[[1,1]];
        timeub = tbounds[[1,2]];

        mat = alphaToMmaMatrix[ equs[[i,2,2]] ];
	translation = getTranslationVector[ equs[[i,2,2]] ];
        If[ dbg, Print[ "Matrix: ", mat ] ];
	If[ dbg, Print[ "Translation vector: ", translation ] ];

	type = expType[ rhs ];
	If[ dbg, Print[ "Type: ", type ] ];

        minV = minValue[ type, opts ];
        maxV = maxValue[ type, opts ];

	(* Open alpHardStimulus file *)
        alpHardStimFile = OpenWrite[ "alpHardStim"<>rhs<>".txt", PageWidth -> Infinity ];

	(* Read stimulus file *)
	If[ 
          FileInformation[ "stim"<>rhs<>".txt" ] === {},
          alpHardStim::nostimfile = 
	  "no stimulus file stim"<>rhs<>".txt. Outputs for variable "<>rhs<>" are symbolic..."; 
          Message[ alpHardStim::nostimfile ] 
        ,
          (* Reading input in Work context *)
          BeginPackage["Alpha`Work`"];
            Get[ "stim"<>rhs<>".txt"];
          EndPackage[];
        ];

        (* Generate input order *)
        Do[

	   With[ 
             { 
               value = ToExpression["Alpha`Work`"<>ToString[rhs[ First[mat.{t,p}] + 
                 First[ translation ] ] ] ],
               address = First[mat.{t,p}] +  First[ translation ] 
             }
           ,

             If[ dbg, Print["At time: ", t, " read ", rhs, "[", address , "]" ] ];
             If[ dbg, Print["Value is: ", ToExpression[ "Alpha`Work`"<>rhs<>"["<>
               ToString[address]<>"]" ] ] ];

	     If[ value < minV || value > maxV, 
		 alpHardStim::outofrange = "warning: value of `1` is `2` and is out of its type range";
		 Message[ alpHardStim::outofrange, rhs[ address ], value ]
             ];

             Put[ 
               OutputForm[
                 ToString[ value ] <> "\t-- Time: "<> ToString[t]<> ", read : "<>
                 ToString[ rhs ] <> "["<> ToString[ address ] <> "] " 
               ]
             , 
               alpHardStimFile 
             ]
           ]
        ,
          {t,timelb,timeub}

        ];
        Close[ alpHardStimFile ];

	With[ {u = "Alpha`Work`"<>ToString[rhs]}, Clear[ u ]; Remove[ u ] ];

      ]; (* End Module *)
    ,
      {i,1,Length[locals]}
    ];

    (* Case of output variables *)
    outpts = getOutputVars[];
    equs = Cases[ $result[[6]], equation[ x_, affine[ var[i_], m:matrix[__] ] ]/;MemberQ[outpts,x] ];

    locals = Map[ First, equs ];
    If[ dbg, Print[ locals ] ];

    Do[
      Module[ { lhs, dom, procs, time, indices, procsIndices, mat, timelb, timeub, rhs,
        alpHardStimFile, translation, minV, maxV, type, timeProcDom, indexDom, 
        indexlb, indexub, lhsIndexes },

        lhs = equs[[i,1]];
        rhs = equs[[i,2,1,1]];

        If[ dbg, Print[ "lhs: ", lhs ] ];
        If[ dbg, Print[ "rhs: ", rhs ] ];

	(* Get the declaration domain of the output variable *)
        dom = getDeclarationDomain[ lhs ];
        If[ dbg, Print[ "Def domain: ", ashow[ dom, silent -> True ] ] ];

	(* Get the matrix *)
        mat = matrix2mma[ equs[[i,2,2]] ];
        If[ dbg, Print[ "Matrix: ", mat ] ];

	(* Compute the image *)
	timeProcDom = DomImage[ dom, equs[[i,2,2]] ];
        If[ dbg, Print[ "Domain: ", ashow[ timeProcDom, silent -> True ] ] ];

        indices = timeProcDom[[2]];
        If[ dbg, Print[ indices ] ];

    (*
        If[ indices[[1]] =!= "t", 
          alpHardStim::noindextime = 
            "first index of all variables should be \"t\"...";
          Throw[ Message[ alpHardStim::noindextime ] ];
        ];

        If[ indices[[2]] =!= "p", 
          alpHardStim::noproctime = 
            "second index of all variables should be \"p\"...";
          Throw[ Message[ alpHardStim::noindextime ] ];
        ];

     *)

        procIndices = Drop[ indices, 1 ];
        procs = DomProject[ timeProcDom, procIndices ];
        If[ dbg, Print[ "Proc domain: ", ashow[ procs, silent -> True ] ] ];

        procbounds = getBoundingBox[ procs ];
        If[ dbg, Print[ "proc bounds: ", procbounds ] ];

        If[ Length[ procIndices ] =!= 1,
          alpHardStim::procdim = 
           "currently supporting only unidimensional proc variables...";
          Throw[ Message[ alpHardStim::procdim ] ];
        ];

        If[ procbounds[[1,1]] =!= procbounds[[1,2]],
          alpHardStim::arrayInput = 
            "variable `1` is not read sequentially on a single input port...";
          Throw[ Message[ alpHardStim::arrayInput ] ];
        ];

        time = DomProject[ timeProcDom, Take[indices,1] ]; 
        If[ dbg, Print[ "time domain: ", ashow[ time, silent -> True ] ] ];
        tbounds = getBoundingBox[ time ];
        If[ dbg, Print[ "time bounds: ", tbounds ] ];

        If[ !MatchQ[ tbounds, {{_Integer, _Integer}} ],
          alpHardStim::timebounds = 
            "time bounds should be finite integers...";
          Throw[ Message[ alpHardStim::timebounds ] ];
        ];
        timelb = tbounds[[1,1]];
        timeub = tbounds[[1,2]];

	type = expType[ rhs ];
	If[ dbg, Print[ "Type: ", type ] ];

        minV = minValue[ type, opts ];
        maxV = maxValue[ type, opts ];

	(* Open alpHardStimulus file *)
        alpHardStimFile = OpenWrite[ "alpHardStim"<>lhs<>".txt", PageWidth -> Infinity ];

	(* Check dimension of output *)
	(* Dimension different from 1 is not accepted right now *)
        If[ 
          dom[[1]] =!= 1
        , 
          alpHardStim::dimoutput = 
	  "dimension of outputs must be 1 in current version";
          Message[ alpHardStim::dimoutput ] 
        ];

	(* Get the lower and upper bounds of the time index *)
        indexlb = getBoundingBox[ dom ][[1,1]];
        indexub = getBoundingBox[ dom ][[1,2]];
	If[ dbg, Print[ "lb : ", indexlb ] ];
	If[ dbg, Print[ "ub : ", indexub ] ];
        
	(* Read stimulus file *)
	If[ 
          FileInformation[ "stim"<>lhs<>".txt" ] === {},
          alpHardStim::nostimfile = 
	  "no stimulus file stim"<>lhs<>".txt. Outputs for variable "<>lhs<>" are symbolic..."; 
          Message[ alpHardStim::nostimfile ] 
        ,
          (* Reading input in Work context *)
          BeginPackage["Alpha`Work`"];
            Get[ "stim"<>lhs<>".txt"];
          EndPackage[];
        ];

	(* Generate a list of 3-uples, the first is the index in the variable, 
          the second one is the time index, and the third one is the value *)
	With[ 
          { name = ToExpression[ "Alpha`Work`"<>ToString[lhs] ] },
          lhsIndexes = Table[ {i, (mat.{i,1})[[1]], name[i]}, {i,indexlb, indexub} ]
        ];

	If[ dbg, Print[ lhsIndexes ] ];

	(* Sort by increasing value of time instants (second value ) *)
	lhsIndexes = Sort[ lhsIndexes, #1[[2]]<#2[[2]]& ];
	If[ dbg, Print[ lhsIndexes ] ];

        (* Generate the value in the file *)
        Do[

	   With[ 
             { 
               value = lhsIndexes[[i,3]],
               address = lhsIndexes[[i,1]],
               time = lhsIndexes[[i,2]]
             }
           ,

             If[ dbg, Print["At time: ", time, " read ", lhs, "[", address , "]" ] ];
             If[ dbg, Print["Value is: ", value ] ];

	     If[ value < minV || value > maxV, 
		 alpHardStim::outofrange = "warning: value of `1` is `2` and is out of its type range";
		 Message[ alpHardStim::outofrange, lhs[ address ], value ]
             ];

             Put[ 
               OutputForm[
                 ToString[ value ] <> "\t-- Time: "<> ToString[time]<> ", read : "<>
                 ToString[ lhs ] <> "["<> ToString[ address ] <> "] " 
               ]
             , 
               alpHardStimFile 
             ]

           ]
        ,
          {i,1,Length[ lhsIndexes ] }

        ];

	With[ {u = "Alpha`Work`"<>ToString[lhs]}, Clear[ u ]; Remove[ u ] ];

        Close[ alpHardStimFile ];

      ]; (* End Module *)
    ,
      {i,1,Length[locals]}
    ];

  ]
];

alpHardStim[___] := Message[ alpHardStim::params ];

Clear[vhdlTestBenchGen];

Options[vhdlTestBenchGen]={debug->True,syntx->True,Options[a2v]};

vhdlTestBenchGen[options___Rule]:= vhdlTestBenchGen[$result,options];

vhdlTestBenchGen::unknsys= "system `1` neither recognized as a cell or a controller or a module";

vhdlTestBenchGen[ sys:_system, options___Rule ]:=
Catch[
  Module[ { s87, dbg, isCell, isController, isModule, isNothing },

    stdl = stdLogic/.{options}/.Options[ a2v ];
    s87 = False;   (* Change it to True to recover the old syntax *)
    dbg = debug/.{options}/.Options[ a2v ];

    (* Check the type of file *)
    isCell = checkCell[ sys ]; 
    If[ dbg&&isCell, Print[ "Program was recognized as a cell" ] ];
    isController = checkController[ sys ];
    If[ dbg&&isController, Print[ "Program was recognized as a controller" ] ];
    isModule = checkModule[ sys ];
    If[ dbg&&isModule, Print[ "Program was recognized as a module" ] ];

    (* Force a controller not to be a Module also...*)
    If[ isController && isModule, isModule = False ];

    If[ !isCell && !isController && !isModule,
      vhdlTestBenchGen::isnothing = "program must be either a cell, a module or a controller";
      Throw[ Message[ vhdlTestBenchGen::isnothing] ];
    ];

    (* Check that it is not both a cell, a controller etc. *)
    If[ (isCell && isController) || ( isCell && isModule ) || (isController && isModule),
      vhdlTestBenchGen::isboth = "program cannot be more than one type of component";
      Throw[ Message[ vhdlTestBenchGen::isboth ] ];
    ];

    (* Check that $library contains the program *)
    If[ 
      !MemberQ[ systemNames[], sys[[1]] ]
    ,
      vhdlTestBenchGen::notinlib = "current system does not belong to $library";
      Throw[ Message[ vhdlTestBenchGen::notinlib ] ]
    ];

    (* s87 is a flag for choosing the VHDL Syntax. By default, it is the
    current syntax, if True, the 1987 syntax is choosen *)
    If[ dbg, Print["syntax 1987 choosen [True|False] :"s87]];
      
    (* Vhdl test bench file *)
    tbFileName = sys[[1]]<>"_TB.vhd";  
    If[ dbg, Print[ "test bench is in ", tbFileName ] ];

    (* Temporary file *)
    tempFileName = ".TB_"<>sys[[1]]<>".vhd"; 
    If[ dbg, Print[ "temporary file is in ", tempFileName ] ];

    (* If the test bench already exists, copy it to temporary file, 
     and delete it *)

    If[ 
      FileInformation[tbFileName]=!={}
    ,
      If[ FileInformation[ tempFileName ] =!= {}, DeleteFile[ tempFileName ] ];
      CopyFile[tbFileName,tempFileName];
      DeleteFile[tbFileName]
    ];

    (* Open the test bench file *)
    file1 = OpenWrite[tbFileName, PageWidth -> Infinity];

    (******************* Get the date ********************)
    today=Date[];
    date = ToString[today[[2]]]<>"/"<>ToString[today[[3]]]<>"/"<>ToString[today[[1]]];
    If[ dbg, Print["++++Date : \n", date, "\n\n" ] ];

    (******************* Clock cycle and init time ********************)
    clockRate="20 ns";
    clockInit="50 ns";

    (*******************  Setting Librairies ********************)
    (* Result is in libs *)
    libs=
       "------------------------------------------------------------------------\n"<>
       "-- VHDL test bench file for system "<>sys[[1]]<>"\n"<>
       "-- Generated with vhdlTestBench.m at "<>date<>"\n"<> 
       "------------------------------------------------------------------------\n"<>
       "library ieee;\n"<>
       "USE ieee.std_logic_textio.all;\n"<>
        "USE std.textio.all;\n"<>
        "USE ieee.std_logic_1164.all;\n"<>
        "USE ieee.std_logic_signed.all;\n"<>
        "USE ieee.numeric_std.all;\n\n"<>
        "USE work.all;\n"<>
        "USE work.types.all;\n"<>
        "USE work.definition.max;\n"<>
        "USE work.definition.min;\n\n"<>
        "ENTITY testbench_"<>sys[[1]]<>" is\n"<>
        "END testbench_"<>sys[[1]]<>";\n\n"<>
        "ARCHITECTURE behavioural OF testbench_"<>sys[[1]]<>" IS\n\n";
    If[ dbg, Print["++++Libraries : \n", libs, "\n\n" ] ];

        
    (*******************  Component declaration ********************)
    (* Result is in component *)
    componentName = sys[[1]]<>".component";
    If[
      FileInformation[componentName]=!={},
      (* inserting the component file *) 
      listString = ReadList[componentName, String];
      listString2 = Map[#<>"\n"&,listString];
      component = Apply[StringJoin ,listString2]
    ,
      (* else re-build the component *)
      component = buildComponent[sys,options]
    ];
    If[ dbg, Print["++++Component : \n", component, "\n\n" ] ];

    (*******************  Component instantiation  ********************)
    (* Result is in instance *)
    inputDecl=sys[[3]];
    inputMap="";
    Do[
      curVar=inputDecl[[i,1]];
      curDecl="sig_";

      If[ 
        (inputDecl[[i,3,1]]-sys[[2,1]])>1,			     
        (* if a var V is an array  in Vhdl its  type is Vtype *)
        vhdlType1=curVar<>"Type"
      ,
         (* else there is the getVhdlType function *)
         vhdlType1=getVhdlType[sys,curVar]
      ];
      curDecl=curVar<>" => "<>curDecl<>curVar<>", ";
      inputMap = inputMap<>curDecl

    ,
      {i,1,Length[inputDecl]}
    ]; (* end DO *)

    (* Build the output map list in outputMap *)
    outputDecl = sys[[4]];
    outputMap="";
    Do[
      curVar=outputDecl[[i,1]];
      curDecl="sig_";
      If[ 
        (outputDecl[[i,3,1]]-sys[[2,1]])>1,			     
        (* if a var V is an array  in Vhdl its  type is Vtype *)
        vhdlType1=curVar<>"Type"
      ,
        (* else there is the getVhdlType function *)
        vhdlType1=getVhdlType[sys,curVar]
      ];
      curDecl=curVar<>" => "<>curDecl<>curVar<>", ";
      outputMap=outputMap<>curDecl

    ,
      {i,1,Length[outputDecl]}
    ]; (* end DO *)

    outputMap = StringDrop[outputMap,-2];

    (* Build the component instance *)
    componentInstance = 
     "\n  comp : "<>sys[[1]]<>" PORT MAP( "<>
     "clk => clk, ce => ce, rst => rst_0, "<>
     inputMap<>
     outputMap<>
     " );\n";

    (* Finally, build the instance *)
    instance=
      "\n"<>
      "BEGIN \n"<>
      "\n---- Instantiation of the components\n"<>
      componentInstance;
    If[ dbg, Print["++++Instance : \n", instance, "\n\n" ] ];


    (******************* Clock generation  ********************)
    (* Result in clockGen *)
    clockGen = 
      "\n-- clock, clock enable and reset generation \n\n"<>
      "  ce <= '1' AFTER clk_rate;\n"<>
      "  rst_0 <= '1' AFTER clk_init;\n"<>
      "  clk <= NOT clk AFTER clk_rate;\n";
    If[ dbg, Print["++++Clock generation : \n", clockGen, "\n\n" ] ];

    (*******************  process start  ********************)
    (* Result in processStart *)
    processStart=
      "\n-- Process start \n"<>
      "stimuli : PROCESS( clk, rst_0 )\n";
    If[ dbg, Print["++++Process start : \n", processStart, "\n\n" ] ];

    (*******************  signal declaration  ********************)
    (* Result is in sig *)

    (* Input signal declarations in inputSigDecl *)
    inputSigDecl="";
    Do[
      curVar=inputDecl[[i,1]];
      curDecl="  SIGNAL sig_";
      If[ 
        (inputDecl[[i,3,1]]-sys[[2,1]])>1,			     
        (* if a var V is an array  in Vhdl its  type is Vtype *)
        vhdlType1=curVar<>"TYPE",
        (* else there is the getVhdlType function *)
        vhdlType1=getVhdlType[sys,curVar]
      ];
      curDecl=curDecl<>inputDecl[[i,1]];
      curDecl=curDecl<>" : "<>vhdlType1<>";\n";
      inputSigDecl=inputSigDecl<>curDecl

    ,
      {i,1,Length[inputDecl]}
    ]; (* end DO *)

    (* Output signal declarations in variable outputSigDecl *)
    outputSigDecl="";
    Do[
      curVar=outputDecl[[i,1]];
      curDecl="  SIGNAL sig_";
      If[ 
        (outputDecl[[i,3,1]]-sys[[2,1]])>1,			     
        (* if a var V is an array  in Vhdl its  type is Vtype *)
        vhdlType1=curVar<>"TYPE"
      ,
        (* else there is the getVhdlType function *)
        vhdlType1=getVhdlType[sys,curVar]
      ];
      curDecl=curDecl<>outputDecl[[i,1]];
      curDecl=curDecl<>" : "<>vhdlType1<>";\n";
      outputSigDecl=outputSigDecl<>curDecl

    ,
      {i,1,Length[outputDecl]}
    ]; (* End DO *)

    sig=
      "\n-- Design independent signals \n\n"<>
      "  -- Integers to and from tested component \n\n"<>
      "  SIGNAL rst_0 : std_logic := '0';\n"<> 
      "  SIGNAL clk : std_logic := '0';\n"<>
      "  SIGNAL ce : std_logic := '0';\n\n"<>
      "  CONSTANT clk_rate : TIME := "<>clockRate<>";\n\n"<>
      "  CONSTANT clk_init : TIME := "<>clockInit<>";\n\n"<>
      "---- Design dependent signals\n"<>
      "  -- Inputs\n"<>inputSigDecl<>"  -- Outputs\n"<>outputSigDecl<>"\n";
    If[ dbg, Print["++++Signal declarations : \n", sig, "\n\n" ] ];

    (******************* variable declaration  ********************)
    inputVarDecl="";
    inputBufDecl="";
    inputFileDecl="";
    inputLineDecl="";

    Do[
      curVar=inputDecl[[i,1]];
      curDeclVar="  VARIABLE ";
      curDeclBuf="  VARIABLE temp_buffer_";
      curDeclFile="  FILE stim_file_";
      curDeclLine="  VARIABLE stim_line_";

      If[ (inputDecl[[i,3,1]]-sys[[2,1]])>1,			     
        (* if a var V is an array  in Vhdl its  type is Vtype *)
        vhdlType1=curVar<>"TYPE"
      ,
        (* else there is the getVhdlType function *)
        vhdlType1=getVhdlType[sys,curVar]
      ];

      If[ 
        s87,   (* old syntax 1987, Ed Modif 18/05/05 *)
        inputTextIs=" :text IS IN \"stim_"
      ,
        inputTextIs=" :text OPEN READ_MODE IS \"stim_"
      ];

      curDeclVar=curDeclVar<>inputDecl[[i,1]];
      curDeclVar=curDeclVar<>" : "<>vhdlType1<>";\n";
      curDeclBuf=curDeclBuf<>inputDecl[[i,1]];
      curDeclBuf=curDeclBuf<>" : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');\n";
      curDeclFile=curDeclFile<>inputDecl[[i,1]];
      curDeclFile=curDeclFile<>inputTextIs<>curVar<>".txt\";\n";
      curDeclLine=curDeclLine<>inputDecl[[i,1]];
      curDeclLine=curDeclLine<>" : LINE ;\n";
      inputVarDecl=inputVarDecl<>curDeclVar;
      inputBufDecl=inputBufDecl<>curDeclBuf;
      inputFileDecl=inputFileDecl<>curDeclFile;
      inputLineDecl=inputLineDecl<>curDeclLine

    ,
      {i,1,Length[inputDecl]}
    ]; (* End DO *)

    outputVarDecl="";
    outputBufDecl="";
    outputFileDecl="";
    outputFileDeclString=""; (*Add by Ed 10/05/05 to stop the simu *)
    outputLineDecl="";

    Do[
      curVar=outputDecl[[i,1]];
      curDeclVar="  VARIABLE ";
      curDeclBuf="  VARIABLE temp_buffer_";
      curDeclFile="  FILE stim_file_";
      curDeclLine="  VARIABLE stim_line_";
      outputFileDeclString=outputFileDeclString<>"stim"<>curVar<>".txt ";

      If[ 
        (outputDecl[[i,3,1]]-sys[[2,1]])>1,			     
        (* if a var V is an array  in Vhdl its  type is Vtype *)
        vhdlType1=curVar<>"TYPE",
        (* else there is the getVhdlType function *)
        vhdlType1=getVhdlType[sys,curVar]
      ];

      If[ s87,   (* old syntax 1987, Ed Modif 18/05/05 *)
        outputTextIs=" :TEXT IS OUT \"stim_",
        outputTextIs=" :TEXT OPEN WRITE_MODE IS \"stim_"
      ];

      curDeclVar=curDeclVar<>outputDecl[[i,1]];
      curDeclVar=curDeclVar<>" : "<>vhdlType1<>";\n";
      curDeclBuf=curDeclBuf<>outputDecl[[i,1]];
      curDeclBuf=curDeclBuf<>" : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');\n";
      curDeclFile=curDeclFile<>outputDecl[[i,1]];
      curDeclFile=curDeclFile<>outputTextIs<>curVar<>".txt\";\n";
      curDeclLine=curDeclLine<>outputDecl[[i,1]];
      curDeclLine=curDeclLine<>" : LINE ;\n";
      outputVarDecl=outputVarDecl<>curDeclVar;
      outputBufDecl=outputBufDecl<>curDeclBuf;
      outputFileDecl=outputFileDecl<>curDeclFile;
      outputLineDecl=outputLineDecl<>curDeclLine;

      (* Insert a file for controller systems *)
      If[
        isController,
        controlFile = "  FILE check_control_";
        controlLine = "  VARIABLE control_line_";
        controlBuffer = "  VARIABLE temp_control_buffer_";
        If[ s87,  
          outputTextCtrlIs=" :TEXT IS OUT \"check_control_",
          outputTextCtrlIs=" :TEXT OPEN WRITE_MODE IS \"check_control_"
        ];
        outputFileDecl = outputFileDecl<>
        controlFile<>curVar<>outputTextCtrlIs<>curVar<>".txt\";\n"<>
        controlBuffer<>curVar<>" : STD_LOGIC := '0';\n"<>
        controlLine<>curVar<>" : LINE ;\n"
      ]
    ,
      {i,1,Length[outputDecl]}
    ]; (* End DO *)

    (******************* variable declaration  ********************)
    (* Result is in varDecl *)

    (* Start of the time counter *)

    Check[
      time1 = alphardTimeLife[],
      vhdlTestBenchGen::wrongTimeLife = "could not get the time life";
      If[ dbg, Print["Time1: ", time1 ] ];
      Close[ file1 ];
      Throw[ Message[ vhdlTestBenchGen::wrongTimeLife ] ]
    ];

    If[ dbg, Print["Time1: ", time1 ] ];
    time2 = getBoundingBox[time1]; 
    If[ dbg, Print["Time2: ", time2 ] ];

    startTime= ToString[time2[[1,1]]-1];
    startTimePlus1= ToString[time2[[1,1]]];

    varDecl=
       "\n-- Design independent variables \n"<>
       "  VARIABLE temp_buffer:	STD_LOGIC_VECTOR (31 DOWNTO 0);\n"<>
       "  VARIABLE temp_buffer_out: STD_LOGIC_VECTOR (31 DOWNTO 0);\n"<>
       "  VARIABLE endstim : BOOLEAN := FALSE; -- end of stimulation\n"<>
       "  VARIABLE good : BOOLEAN; -- check current read in stimuli file\n"<>
       "  VARIABLE i,i1,i2,i3,i4 : INTEGER; -- loop counter\n"<>
       "  VARIABLE j : INTEGER; -- loop counter\n"<>
       "  CONSTANT space : STRING := \"  \";  -- Blank string \n\n"<>
       "---- Design dependent variables\n"<>
       "  --Inputs\n"<>inputVarDecl<>" --outputs\n"<>outputVarDecl<>"\n"<>
       "---- Design dependent Buffers\n"<>
       "  -- Inputs\n"<>inputBufDecl<>" --outputs\n"<>outputBufDecl<>"\n"<>
       "---- Design dependent file declaration\n"<>
       "  --Inputs\n"<>inputFileDecl<>"  --Outputs\n"<>outputFileDecl<>"\n"<>
       "---- Design dependent line declaration\n"<>
       "  --Inputs\n"<>inputLineDecl<>"  --Outputs\n"<>outputLineDecl<>"\n\n"<>
       "  VARIABLE timecounter : INTEGER := "<>startTimePlus1<>"; -- indicate the step t.\n  -- Initialisation is design dependent\n\n";
    If[ dbg, Print["++++Variable declarations : \n", varDecl, "\n\n" ] ];

    (******************* signal initialisation  ********************)
    sigInit = "  -- Signal initialisation\n\n";
    If[ dbg, Print["++++Signal initializations : \n", sigInit, "\n" ] ];
       
    (******************* Read stimuli ********************)
    inputStimRead="";
    sigText="sig_";
    stimText="stim_file_";
    bufferText="temp_buffer_";
    lineText="stim_line_";
    type = "";
    sizeType = "";

    Do[
      curDom=inputDecl[[i,3]];
      curVar=inputDecl[[i,1]];	  
	  
      (* Get the type *)
      vhdlType1 = getVhdlType[sys,curVar];
      If[
        StringPosition[vhdlType1,"SIGNED",IgnoreCase -> True] =!= {}
      ,
        type = "SIGNED";
        sizeType = StringReplace[vhdlType1,"SIGNED"->"",IgnoreCase -> True]
      ,
        If[
          StringPosition[vhdlType1,"STD_LOGIC_VECTOR",IgnoreCase -> True] =!= {}
        ,
          type = "STD_LOGIC_VECTOR";
          sizeType = StringReplace[vhdlType1,"STD_LOGIC_VECTOR"->"",IgnoreCase -> True]
        ,
          If[
            StringPosition[vhdlType1,"STD_LOGIC",IgnoreCase -> True] =!= {}
          ,
            type = "";
            sizeType = "(0)"
          ,
            type = "INTEGER";
            sizeType = ""
          ]
        ]
      ];

      (* Get time domain *)
      domTemporel = DomProject[curDom, {curDom[[2,1]]}];
      boundBox = getBoundingBox[domTemporel];
      upBound = boundBox[[1, 2]];
      downBound = boundBox[[1, 1]] ;

      (* Get proc domain(s) *)
      indiceLoop = StringReplace[ToString[Take[curDom[[2]],
                            {2,Length[curDom[[2]]]-sys[[2,1]]}]],
                        {"{"->"(","}"->")"}];
      (* This was modified, since we may find an external module with
        no processor numbers (the calling system) *)
      If[ indiceLoop === "()", indiceLoop = "" ];
      If[ 
        isCell
      ,
        (* For a cell there is no internal loop *)
        indiceLoop = ""
      ];

      curCode =
        "    READLINE("<>stimText<>curVar<>", "
      <>
        lineText<>curVar<>");\n"
      <>
        "    HREAD("<>lineText<>curVar<>", "
      <>
        bufferText<>curVar<>", good);\n"
      <>
        "    "<>curVar<>indiceLoop<>" := "
      <>
        type<>"("<>bufferText<>curVar<>sizeType<>");\n"
      <>
        "   ASSERT good REPORT \"read text i/o read error\" SEVERITY ERROR;"
      ;

      If[ 
        isModule && !isController
      ,
	(* This was changed, to cover the case of the main program
        loopStructure = mkVhdlLoop[curDom, 2, sys[[2,1]], {}, curCode, options]
	 *)
        loopStructure = mkVhdlLoop[curDom, 1, sys[[2,1]], {}, curCode, options]
      ,
        (* For a cell there is no internal loop*)
        If[ 
          isController
        ,
          loopStructure = ""
        ,
          loopStructure = curCode]
      ];

      curRead="  IF (timecounter >= "<>
        ToString[downBound]<>") AND (timecounter <= "<>
        ToString[upBound]<>") THEN \n"<>loopStructure<>
        "  END IF;\n\n";

      inputStimRead=inputStimRead<>curRead
    ,
      {i,1,Length[inputDecl]}
    ]; (* End DO *)


    stimRead=
       "---- Reading stimuli files\n\n"<>
       inputStimRead;
    If[ dbg, Print["++++Input stimuli read : \n", stimRead, "\n\n" ] ];

    (******************* stimuli write  ********************)

    outputStimWrite="";
    sigText="sig_";
    stimText="stim_file_";
    bufferText="temp_buffer_";
    lineText="stim_line_";

    Do[
      curDom=outputDecl[[i,3]];
      curVar=outputDecl[[i,1]];	  
      type = "";
      sizeType = "";

      (* Get the type *)
      vhdlType1 = getVhdlType[sys,curVar];

      If[
        StringPosition[vhdlType1,"signed",IgnoreCase -> True] =!= {}
      ,
        type = "std_logic_vector";
        sizeType = StringReplace[vhdlType1,"signed"->"",IgnoreCase -> True]
      ,
        If[
          StringPosition[vhdlType1,"std_logic_vector",IgnoreCase -> True] =!= {}
        ,
          type = "std_logic_vector";
          sizeType = StringReplace[vhdlType1,"std_logic_vector"->"",IgnoreCase -> True]
        ,
          If[StringPosition[vhdlType1,"std_logic",IgnoreCase -> True] =!= {}
          ,
            type = "std_logic";
            sizeType = "(0)"
          ,
            type = "integer";
            sizeType = ""
          ]
        ]
      ];

      domTemporel = DomProject[curDom, {curDom[[2,1]]}];
      boundBox = getBoundingBox[domTemporel];
      upBound = boundBox[[1, 2]];
      downBound = boundBox[[1, 1]];

      (* Get proc domain(s) *)
      indiceLoop = StringReplace[ToString[Take[curDom[[2]],
                           {2,Length[curDom[[2]]]-sys[[2,1]]}]],
                          {"{"->"(","}"->")"}];
      If[ 
        isCell || isController
      ,
        (* For a cell there is no internal loop *)
        indiceLoop = ""
      ];

      If[
        isController
      ,
        (* for a controller *)
        timeDom = "  IF (timecounter >= "<>startTimePlus1<>") THEN \n"
      ,
        timeDom = "  IF (timecounter >= "<>ToString[downBound+1]<>") AND (timecounter <= "
          <>ToString[upBound]<>") THEN \n"
      ];

      curCode="    "<>bufferText<>curVar<>sizeType<>" := "<>
        type<>"("<>curVar<>indiceLoop<>");\n"<>
        "    HWRITE("<>lineText<>curVar<>", "<>
        bufferText<>curVar<>");\n"<>
        "    WRITELINE( "<>stimText<>curVar<>" , "<>
        lineText<>curVar<>");";

      If[ 
        isModule && !isController
      ,
        (* ************ Modified 
        loopStructure= mkVhdlLoop[curDom, 2, sys[[2,1]], {}, curCode],
        *)
        loopStructure= mkVhdlLoop[curDom, 1, sys[[2,1]], {}, curCode]
      ,
        (* cell or controller *)
        If[ 
          isController
        ,
          loopStructure = curCode,
          loopStructure = curCode
        ]
      ];

      curWrite= 
        timeDom<>loopStructure<>"  END IF;\n\n";

      (* Fill in the controller file is needed *)
      If[
        isController
      ,
        controlFileText = "check_control_";
        controlLineText = "control_line_";
        controlBufferText = "temp_control_buffer_";
        curWrite = curWrite<>
          "\n"<>timeDom<>
          "WRITE("<>controlLineText<>curVar<>", timecounter);\n"<>
          "WRITE("<>controlLineText<>curVar<>", space);\n"<>
        controlBufferText<>curVar<>" := "<>curVar<>";\n"<>
          "WRITE("<>controlLineText<>curVar<>", "<>controlBufferText<>curVar<>");\n"<>
          "WRITELINE( "<>controlFileText<>curVar<>" , "<>controlLineText<>curVar<>");\n"<>
          "  END IF;\n"
      ];
      outputStimWrite=outputStimWrite<>curWrite
    ,
      {i,1,Length[outputDecl]}
    ];

    stimWrite=
       "-- Writing stimuli to files\n\n"<>
       outputStimWrite;
    If[ dbg, Print["++++stimuli write : \n", stimWrite, "\n\n" ] ];

    (******************* stimuli affectation  ********************)

    inputSigAff="";
    Do[
      curVar=inputDecl[[i,1]];
      curAff="  sig_";
      curAff=curAff<>curVar<>" <= "<>curVar<>";\n";
      inputSigAff=inputSigAff<>curAff
    ,
      {i,1,Length[inputDecl]}
    ];

    outputSigAff="";
    Do[
      curVar=outputDecl[[i,1]];
      curAff="sig_";
      curAff="  "<>curVar<>" := "<>curAff<>curVar<>";\n";
      outputSigAff=outputSigAff<>curAff
    ,
      {i,1,Length[outputDecl]}
    ];

    stimAffectation=
       "-- Affectation to signals\n\n"<>
       inputSigAff<>"\n"<>
       outputSigAff<>"\n";
    If[ dbg, Print["++++stimuli Affectation : \n", stimAffectation, "\n\n" ] ];

    (******************* process start  ********************)
    processContent=
      "BEGIN\n"<>
      "  IF rst_0 = '0' THEN\n"<>
      sigInit<>"\n"<>
      "  ELSIF clk'EVENT AND clk='1' THEN\n"<>
      stimRead<>"\n"<>
      stimAffectation<>"\n"<>
      stimWrite<>"\n";

    (******************* process end  ********************)

    If[
      isController
    ,
      (* For a controller *)
      endStim="endstim := FALSE;\n"
    ,
      (* For the other cases *)
      endStim="endstim := ";

      Do[
        curVar=inputDecl[[i,1]];
        curDecl="ENDFILE(stim_file_";
        curDecl=curDecl<>curVar<>") OR ";
        endStim=endStim<>curDecl
      ,
        {i,1,Length[inputDecl]}
      ];

      endStim = "  "<>StringDrop[endStim,-3];
      endStim = endStim<>";\n\n"
    ];

    processEnd=
      "-- End of process, increment of timecounter\n\n"<>
      "  timecounter := timecounter+1;\n\n"<>
      "  ASSERT NOT endstim REPORT \"end of stimuli file. Stop the rtl!\" SEVERITY ERROR;\n"<>
      endStim<>
      "  -- severity error does not stop the simulation, whether failure does!\n"<>
      "  -- But the process has to continue until the end of the calculation\n\n"<>
      "  ASSERT timecounter <= "<>ToString[upBound+1]<>"\n"<>"-- May be upBound ?"<> 
      "\n  REPORT \" Failure asked on purpose, normaly result is written in "<>
      outputFileDeclString<>
      "\"\n  SEVERITY FAILURE;\n"<>
      "  END IF;\n"<>
      "\n"<>
      "END PROCESS;\n"<>
      "\n"<>
      "END BEHAVIOURAL;\n";

    Check[
      Which[
        isController
      , 
        (Print[ sys[[1]], " was recognized as a Controller."];
        body = vhdlControllerTestBenchGen[sys,  options ])
      , 
        isCell
      ,
        (Print[ sys[[1]], " was recognized as a Cell."];
        body = vhdlCellTestBenchGen[ sys, options ])
      , 
        isModule
      ,  
        (Print[ sys[[1]], " was recognized as a Module."];
        body = vhdlModuleTestBenchGen[ sys, options ])
      ,
        True
      , 
        Throw[Message[vhdlTestBenchGen::unknsys, sys[[1]]] ]
      ]; (* Which *)

      res = libs<>component<>sig<>instance<>clockGen<>processStart<>varDecl<>
        processContent<>processEnd;

      Put[OutputForm[res],file1];
      Close[file1];
  
      Print[tbFileName," Generated"];
  
      If[ FileInformation[tempFileName]=!={}, DeleteFile[tempFileName] ];
	     
    ,  (* if the above failed, we restore the old TestBecnh *)
       Print["Test bench generation failed, restoring old Test bench"];
       If[ FileInformation[tempFileName]=!={},
		CopyFile[".TB_"<>TrString[sys[[1]]]<>".vhd",tbFileName]
       ];
       Close[file1];
       res="ERROR"
    ]; (* end Check *) 

  ];
];(* End function *)

vhdlTestBenchGen::wrongArg="wrong Argument for function vhdlTestBenchGen : `1` ";

vhdlTestBenchGen[a:___]:=Message[vhdlTestBenchGen::wrongArg,Map[Head,{a}]];

buildComponent::usage="debug";

Clear[buildComponent];

Options[buildComponent]={debug->False};

buildComponent[sys:_system,options___Rule]:=(Print["buildComponent not yet implemented \nplease provide component for",sys[[1]]];"---insert component of "<>sys[[1]]<>" here \n ");

buildComponentTemp[sys:_system,options___Rule]:=
Module[{},
  dbg = debug/.{options}/.Options[ a2v ];
  clkEn = clockEnable/.{options}/.Options[ a2v ];
  stdl = stdLogic/.{options}/.Options[ a2v ];
       
  component = 
    StringJoin[ 
      "\nCOMPONENT ",
      sys[[1]],
      "\n",
      If[ clkEn, 
        "PORT(\n  Clk: IN STD_LOGIC;\n  CE : IN STD_LOGIC;\n  Rst : IN STD_LOGIC",
        "PORT(\n  Clk: IN STD_LOGIC;\n  Rst : IN STD_LOGIC"],
        Map[
          ";"<>Alpha`Vhdl2`vhdlDeclEnt[#,"IN",options]&,
          indecls
        ],
        Map[
          ";"<>Alpha`Vhdl2`vhdlDeclEnt[#,"OUT",options]&,
          outdecls
        ],
        "\n);\nEND COMPONENT",
        ";\n"
    ];
       
];

buildComponent::wrongArg="wrong Argument for function buildComponent : `1` ";

buildComponent[a:___]:=Message[buildComponent::wrongArg,Map[Head,{a}]];


(* mkVhdlLoop taken from CodeGen/Loops.m and slightly modify to generate 
Vhdl *)

Unprotect[mkVhdlLoop];

Clear[mkVhdlLoop];

mkVhdlLoop::wrongArg = "`1`";

mkVhdlLoop::param = "param dim (`3`) + level (`2`) is greater than domain dim (`1`).";
mkVhdlLoop::noBounds = "no lower or upper bound for polyhedron";

mkVhdlLoop[
 d:_domain,
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 pval:{___Rule},
 code:_,
 opts:___Rule] :=

Module[{dom, body, dbg},

  dbg = debug/.{opts}/.{debug->False};
  If[ dbg, Print["Form 1 of mkVhdlLoop"] ];
  If[ dbg, Print["Domain: ", ashow[ d, silent->True ] ] ];
  If[ dbg, Print["Level: ", lev ] ];
  If[ dbg, Print["Parameter dimension: ", pdim ] ];
  If[ dbg, Print["Parameter value: ", pval ] ];
  If[ dbg, Print["Code: ", code ] ];

  If[
    DomEmptyQ[d]
  ,
    deadCode
  ,

    (* We need to eliminate the INDICES (not the parameters)
      which are after level+1 *)
    dom = (* project out dimensions greater than lev *)
    Module[{dim, mat},
      dim = d[[1]];
      If[
        lev+pdim>dim
      ,
        Message[mkVhdlLoop::param, dim, lev, pdim];
	Throw[$Failed]
      ];

      (* Build the identity matrix max with rows deleted *)
      mat = matrix[pdim+lev+1, dim+1, d[[2]],
              Drop[IdentityMatrix[dim+1], {lev+1, -pdim-2}]];
      (* Take the image by the matrix, and select the good 
        indices names *)
      ReplacePart[DomImage[d, mat], Drop[d[[2]], {lev+1, -pdim-1}], 2] 
    ];

    (* Try to join adjacent polyhedra *)
    If[Length[dom[[3]]]>1,
      mkVhdlLoop::domains = 
        "domain is a union of `1` polyhedra. Don't know how to generate code for this.";
      Message[mkVhdlLoop::domains, Length[dom[[3]]]];
      Throw[$Failed]
    ];

    (* Recurse to levels *)
    body = If[lev+pdim<d[[1]], 
              mkVhdlLoop[d, lev+1, pdim, pval, code, opts],
	      code
    ];

    (* If deadCode found at this level, return it *)
    If[ body === deadCode, 
      deadCode,
      (* Otherwise, recurse *)
      mkVhdlLoop[dom[[3,1]], lev, pdim, symbol/@dom[[2]],
      Function[{x},
        Rule[symbol[x[[1]]],x[[2]]]]/@pval, body, opts]
    ]
  ]
];

mkVhdlLoop[
 p:_pol,
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule},
 code:_,
 opts:___Rule] :=

Module[{eq,dbg},
  (* Select in the inequalities of the domain, those ones which
     have a non numerical coefficient on indice number level *)
  dbg = debug/.{opts}/.{debug->False};

  If[ dbg, Print["Form 2"] ];
  eq = Select[Cases[p[[5]],{0, __}], Not[#[[lev+1]]==0]&];

  If[Length[eq]>0,

    (* If there are such equalities we only take the last one *)
    (* we remove the 'symbol' head before translating to string *)
    lowerBound=mkVhdlEqTest[Last[eq], lev, pdim, idx, pval, code];
       res = "  FOR "<>idx[[lev,1]]<>" IN "<>
            ToString[lowerBound/.{idx[[1]]->"timecounter",symbol[x:_]->x}]<>
             " TO "<> ToString[lowerBound/.{idx[[1]]->"timecounter",symbol[x:_]->x}] <>" LOOP\n"<>
         code <>"  END LOOP;\n",

    (* Otherwise (if [Length[eq]=0),
       select ineq >= ind(Level) and ineq <=  ind(Level) *)
    Module[{ineq, lb, ub},
      ineq = Cases[p[[5]],{1, __}];

      lb = Select[ineq, Greater[#[[lev+1]],0]&];

      ub = Select[ineq, Less[#[[lev+1]],0]&];

      If[lb=={},
        Message[mkVhdlLoop::noBounds]; Throw[$Failed]
      ];

      (* Previously this...
      If[lb=={} || ub=={},
        Message[mkVhdlLoop::noBounds]; Throw[$Failed]
      ];
       *)

      lowerBound = mkVhdlLowerBound[lb, lev, pdim, idx, pval];
      If[ dbg, Print[ lowerBound ] ];
      lowerBoundValue = lowerBound;
      (* This was modified *)
      If[ ub =!= {}, 
        upperBound = mkVhdlUpperBound[ub, lev, pdim, idx, pval];
        upperBoundValue = lowerBound;
        If[ dbg, Print[ upperBound ] ],
        upperBound = +Infinity;
      ];


       If[ dbg, Print["--------- lb :"]; printC[lowerBoundValue] ];
       If[ dbg, Print["--------- ub :"]; printC[upperBoundValue] ];
       res = 
         If[ upperBound=!=Infinity,
             "  FOR "<>idx[[lev,1]]<>" IN "<>
             StringReplace[ToString[lowerBound/.{idx[[1]]->"timecounter",symbol[x:_]->x}],
                           {"Max["->"Max(","]"->")"}]<>
             " TO "<> StringReplace[ToString[upperBound/.{idx[[1]]->"timecounter",symbol[x:_]->x}],
                  {"Min["->"Min(","]"->")"}]<>" LOOP\n",
             Message[mkVhdlLoop::InfinieUpperBound];
             deadCode
         ]<>
         code<>"\n  END LOOP;\n";
      If[ dbg, Print["Fini form 2"] ];
      res
    ]
  ]
];

mkVhdlLoop[a___] :=
Module[{},
  Message[mkVhdlLoop::wrongArg, {a}];
  Throw[$Failed]
];


Unprotect[mkVhdlLowerBound];
Clear[mkVhdlLowerBound];

mkVhdlLowerBound::wrongArg = "`1`";

(*  re-written in a readable way *)
 (* bound is a list of list. Each list is wrtten in Polylib format
  {eqOrIneq,firstIndiceCoed,...,ConstantCoef} (???), 
   lev is the level of the indice we look for bounfd (?)
   idx is the indice list in the form symbol[ind1] *)

mkVhdlLowerBound[
 bounds:{__List},
 lev:_Integer?NonNegative, 
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule}] :=

Module[{tmp,indiceVect,curBound,den,val,num,tmp1,dbg},
  indiceVect=Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;

  dbg = False; (* Could be changed, if needed, but an option 
    would be better... FIXIT *)

  tmp = {};

  Do[curBound = bounds[[i]];
    den = -(curBound.indiceVect);
    num = curBound[[lev+1]];
    val = den/num;
    tmp1 = 
      If[IntegerQ[val],
        val,
        If[NumberQ[val],
          Ceiling[val],
          If[Abs[num]==1,
            den/num,
	     Message[mkVhdlLowerBound::RationnalLowerBound];
	     deadCode]
        ]
      ];

    If[ dbg, Print[ FullForm[tmp], FullForm[tmp1] ] ];
    tmp = Append[tmp, tmp1];

    ,{i,1,Length[bounds]}
  ];
  If[ dbg, 
    Print["lb ::::::: "];
    Print["Full form: ", FullForm[ tmp ] ];
    Print["printC: "];Map[ printC, tmp ]
  ];
  Apply[ Max,tmp ]
];

mkVhdlLowerBound[a___] :=
Module[{},
  Message[mkVhdlLowerBound::wrongArg, {a}];
  Throw[$Failed]
];

Protect[mkVhdlLowerBound];

(* === *)

Unprotect[mkVhdlUpperBound];
Clear[mkVhdlUpperBound];

mkVhdlUpperBound::wrongArg = "`1`";

mkVhdlUpperBound[
 bounds:{__List},
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__symbol},
 pval:{___Rule}] :=

Module[{tmp, v},
  indiceVect=Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;
  tmp={};
  Do[ curBound=bounds[[i]];
    den = -(curBound.indiceVect);
    num = curBound[[lev+1]];
    val = den/num;
    tmp = 
      Append[tmp,
        If[IntegerQ[val],
          val,
          If[NumberQ[val],
            Floor[val],
              If[Abs[num]==1,
                den/num,
		 Message[mkVhdlUpperBound::RationnalUpperBound];
		 deadCode
              ]
          ]
        ]
      ]
    ,{i,1,Length[bounds]}
  ];

Apply[Min,tmp]
];


mkVhdlUpperBound[a___] :=
  Module[{},
	 Message[mkVhdlUpperBound::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[mkVhdlUpperBound];


Protect[mkVhdlLoop];



Unprotect[mkVhdlEqTest];
Clear[mkVhdlEqTest];

 mkVhdlEqTest::wrongArg = "`1`";
 mkVhdlEqTest::zero = "coef should not be zero !";
mkVhdlEqTest::emptyLoop = "Warning, empry loop, not implemented yet...."
mkVhdlEqTest::notUnitStep = "Warning: non-unit stride loop, not implemented yet "
 
mkVhdlEqTest[
 eq:{__Integer},
 lev:_Integer?NonNegative,
 pdim:_Integer?NonNegative,
 idx:{__},
 pval:{___Rule},
 code:_]:=
Module[ {indiceVect, den, val, num},

  indiceVect=Join[{0}, ReplacePart[idx, 0, lev], {1}] /. pval;
  num = (eq.indiceVect);


  den = -eq[[lev+1]];
  mod1 = Mod[num,den];

  If[ NumberQ[mod1],

    If[mod1==0, 
      num/den,
      Message[mkVhdlEqTest::emptyLoop]; $Failed
    ],

    If[ Abs[den]==1,
      num/den,
      Message[mkVhdlEqTest::notUnitStep]; $Failed
      ]
    ]
  ]

mkVhdlEqTest[a___] :=
Module[{},
  Message[mkVhdlEqTest::wrongArg, {a}];
  Throw[$Failed]
];

Protect[mkVhdlEqTest];



End[];
EndPackage[];
