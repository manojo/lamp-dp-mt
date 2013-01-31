(* file: $MMALPHA/lib/Package/Synthesis.m
   AUTHOR : P. Quinton
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

BeginPackage[
  "Alpha`Synthesis`",
  {"Alpha`",
   "Combinatorica`",
   "Alpha`Domlib`",
   "Alpha`Tables`",
   "Alpha`Matrix`",
   "Alpha`Options`", 
   "Alpha`Normalization`", 
   "Alpha`Properties`", 
   "Alpha`Static`", 
   "Alpha`Substitution`",
   "Alpha`SubSystems`",
   "Alpha`Semantics`", 
   "Alpha`Schedule`", 
   "Alpha`ScheduleTools`", 
   "Alpha`Pipeline`", 
   "Alpha`PipeControl`", 
   "Alpha`ToAlpha0v2`", 
   "Alpha`Alphard`", 
   "Alpha`Vhdl2`",
   "Alpha`VertexSchedule`"}];

(* Standard head for CVS

	$Author: 
	$Date: 
	$Source: 
	$Revision: 
	$Log:
	
*)

Synthesis::note = "Documentation not yet revised.";

Synthesis::usage = 
"The Alpha`Synthesis` package contains functions to synthesize a design.";

syn::usage = 
"syn[ file, opts ] tries to synthesize parallel Vhdl from Alpha program 
file.alpha.";
optionsOfScheduler::usage = "Option of syn, contains options to be passed to the scheduler";

pipe::usage =
"pipe is an option of syn. If True (default), pipeVars is called, otherwise, it is not.";

placementSteps::usage = 
"placementSteps is an option of syn. This is a string that 
contains additional steps to be performed after piping the variables. 
Typically, one would add some change of basis that would place 
one dimensional variables into the time space of the architecture.";

Options[ syn ] = { debug -> False, verbose -> False, 
 optionsOfScheduler -> {}, parameterRules -> {}, schedMethod -> farkas,
 optionsOfAppSched -> {}, placementSteps -> "", pipe -> True };

synPeriodic::usage =
  "synPeriodic[ ] generates a periodic data-flow system";

findPeriods::usage = 
  "findPeriods finds out the periods of a data-flow system";

Options[ synPeriodic ] = { debug -> False, verbose -> False, 
  addConstraints -> {}, parameterRules -> {}, mute -> False, romData -> {},
  optionsOfScheduler -> {} };

romData::usage =
"romData is an option of synPeriodic. By default, it is the empty list.
It contains a list of pairs { var, romDatafile } where var is a variable
described as a ROM and romDatafile is a file that contains the ROM data
for this variable. romDatafile is suffixed by .rom, and it contains a
list of vhdl values.";

parameterRuleOfUse::usage = 
"parameterRuleOfUse[ useEq, parameterList, parameterRules ] find out the
set of rules that apply to the parameters of a system called in a use equation,
from the list of parameters of its calling system, and a set of parameterRules.";


addRegisters::usage = 
"addRegisters[ vara, varb, n ] adds n registers between variables vara
and varb. In other words, vara becomes a delayed version of varb by 
n cycles";

addDeclaration::usage = 
  "addDeclaration[ v, type ] adds the declaration of v with type t";

(* ===================== Private definitions ===================== *)

Begin["`Private`"]
 
Clear[ addDeclaration ];
addDeclaration[ v:_String, d:_domain, t:_ ]:=
Catch[
  Module[ {},
    $result = 
      ReplacePart[ $result, 
		   5 -> Append[$result[[5]], decl[v,t,d] ] ]
  ];
];
addDeclaration[___] := Message[ addDeclaration::params ];

Clear[ addRegisters ];
addRegisters[ vara:_String, varb:_String, nb:_Integer ] :=
Catch[
  Module[ { varbDel, lgParams }, 

  (* Check existence of vara and of varb *)
  If[ !MemberQ[ getLocalVars[], vara ],
    addRegisters::wrgvar = 
      "variable `1` does not exist or is not a local variable.";
      Throw[ Message[ addRegisters::wrgvar, vara ] ]
  ];

  If[ !MemberQ[ getLocalVars[], varb ],
    addRegisters::wrgvar = 
      "variable `1` does not exist or is not a local variable.";
      Throw[ Message[ addRegisters::wrgvar, varb ] ]
  ];

  (* Build new name of varb *)
  varbDel = varb<>"DelBy"<>ToString[nb];

  (* If this delayed variable already exist, OK, otherwise, 
    add its declaration *)
  If[ !MemberQ[ getLocalVars[], varbDel ], 
    addDeclaration[ varbDel, getDeclarationDomain[ varb ], 
      expType[ varb ] ] 
  ];

  (* Add a register between vara and varDelayed *)
  lgParams = Length[ getSystemParameters[] ];

  $result = 
    ReplacePart[ $result, 
      6 -> Append[ $result[[6]], 
         use[ "registerFile", 
           getSystemParameterDomain[], 
	      matrix[2, lgParams+1, getSystemParameters[], 
               {
		     Append[ Table[0, {i,1,lgParams} ], nb ],
		     Append[ Table[0, {i,1,lgParams} ], 1 ]
	       }
           ],
           {var[ varb ]}, { varbDel } ] 
         ] 
    ];

  (* Replace occurrences of varb by varbDel *)
  $result = replaceDefinition[ vara, getDefinition[ vara ]/.
			 {varb -> varbDel} ];

  ];
];
addRegisters[___] := Message[addRegisters::params];

Clear[ parameterRuleOfUse ];
parameterRuleOfUse[ useEq:use[__], pmRules:_ ]:=
Module[ {save, res, dbg},
  Catch[
    Module[ { mm, values, sys, useName, params, pmList },

      dbg = False;
      save = $result;
      useName = useEq[[1]];

      (* Get the parameter list of the calling system $result *)
      Check[ 
        pmList = getSystemParameters[],
        parameterRuleOfUse::errgetparams = 
          "error while getting the parameters of the calling system";
        Throw[ Message[parameterRuleOfUse::errgetparams]; res = {} ]
      ];

      (* Get the matrix of the parameter transformation of the call *)
      Check[
        mm = useEq[[3]];
        mm = matrix2mma[ mm ],
        parameterRuleOfUse::errmat = "error while getting the matrix of the use";
        Throw[ Message[parameterRuleOfUse::errmat]; res = {} ]
      ];
      If[ dbg, Print[ "matrix: ", mm ] ];


      (* Check the dimensions *)
      If[ Dimensions[ mm ][[2]] =!= Length[ pmList ] + 1,
        parameterRuleOfUse::errdim = 
        "dimension of parameter list does not match that of matrix";
        Throw[ Message[parameterRuleOfUse::errdim]; res = {} ]
      ];

      (* The values of the paramaters are obtained by applying the matrix
       to the parameter list, with a 1 at the end provided for the homogeneous
       coordinate, and droppping one dimension afterwards *)
      values = Drop[ mm.Append[ pmList, 1 ], -1 ];
      If[ dbg, Print[ "values:", values ] ];

      (* Get the called system *)
      Check[ 
        sys = getSystem[ useName ];
        params = getSystemParameters[],
        parameterRuleOfUse::errsystem = "error while getting called system";
        Throw[ Message[parameterRuleOfUse::errsystem]; res = {} ]
      ];

      (* Check the dimensions of the parameters *)
      If[ Dimensions[ values ][[1]] =!= Length[ params ],
        parameterRuleOfUse::errparams = 
          "dimension of called system parameters does not fit values";
        Throw[ Message[parameterRuleOfUse::errparams]; res = {} ]
      ];

      If[ dbg, Print[ "params: ", params ] ];
      If[ dbg, Print[ "pmRules ", pmRules ] ];

      values = values/.pmRules;
      If[ dbg, Print[ "values: ", values ]];

      res = MapThread[ Rule[#1,#2]&, { params, values } ];
      res = { useName, res};
      If[ dbg, Print[ "result: ", res ] ];
      res
    ];
  
  ];
  $result = save; res

];
parameterRuleOfUse[___] := Message[ parameterRuleOfUse::params ];


Clear[ synPeriodic ];
synPeriodic[ file:_String, opts:___Rule ] :=
Module[ { traceFile },
Catch[ 
  Module[ {addC, connectedC, nsVectors, periodsOfVars, periodsOfUses, results,
           objF, durs, durz, 
           addCOpts, dbg, vrb, omute, equs, sched, uses, others, 
	   optOfSched, 
	   vhdlComp, vhdlArchi, vhdlDecl, mainVhdl, mainComponent, 
           mainComponentsUsed, mainPackage,
	   dirSyn, bTime, eTime, vhdlDirectory, componentsOfMain,
	   mainVhdlFile, result, vhdlNames, lscheds, paramsRules, params,
           paramsOfUses, shiftsOfUses, sys, saveprog, savelib, lib, 
           listOfEnables,
           listOfResets, declOfEnables, declOfResets, shiftsOfResets, vhdlFSM,
	   callEnables, callRegisters, listOfDelEnables, declOfDelEnables,
	   listOfPeriodsAndShifts, listOfNamesAndShifts, listOfPeriods,
	   adaptedSignals, vhdlDeclOfAdapted, scheds, 
           resultOfa2v, numberOfEquations, diffInSchedules, romDataOpt, 
           resOfFindPeriods, listOfMessages, lastMessages},

    (* *)
    Alpha`Work`M = 2; 
    Clear[ Alpha`Work`M ];

    (* Get options. addCOpts receives additional options for scd *)
    addCOpts = addConstraints/.{opts}/.Options[ synPeriodic ];
    dbg = debug/.{opts}/.Options[ synPeriodic ];
    vrb = verbose/.{opts}/.Options[ synPeriodic ];
    omute = mute/.{opts}/.Options[ synPeriodic ];
    optOfSched = optionsOfScheduler/.{opts}/.Options[ synPeriodic ];

    (* Set initial time *)
    bTime = TimeUsed[];

    If[ vrb, Print[ "++++  Loading file..." ] ];

    Check[ load[ file, mute->True ], 
      synPeriodic::errorLoad = 
        "error while loading file. synPeriodic aborted...";
      Throw[ Message[ synPeriodic::errorLoad ] ]
    ];

    (* Create the directory where the traces will be put *)
    dirSyn = Directory[]<>"/"<>getSystemName[]<>"SYNPERIODIC/";
    If[ dbg, Print["Directory: ", dirSyn ] ];
    If[ FileInformation[ dirSyn ] === {}, CreateDirectory[ dirSyn ] ];

    If[ FileInformation[ dirSyn<>"/VHDL" ] === {}, 
      CreateDirectory[ dirSyn<>"/VHDL" ] ];

    Check[ 
      traceFile = OpenWrite[ dirSyn<>"trace.txt " ],
      Close[Streams[][[-1]]];
      traceFile = OpenWrite[ dirSyn<>"trace.txt " ]
    ];

    (* Put some info *)
    WriteString[ traceFile, "(* ----------\n  Trace file \n  " ];
    WriteString[ traceFile,
      Date[][[3]],"/",Date[][[2]],"/",Date[][[1]]," -- ",
      Date[][[4]],"h ",Date[][[5]],"mn ",Date[][[6]],"s\n  List of commands executed\n  ----------  *)\n"
    ];

    (* Step 0.a : load system, and load schedudes of components *)
    WriteString[ traceFile, "\n---- Step 0.a: Loading the system  ----" ];
    WriteString[ traceFile, "load[ file, mute -> True ];\n" ];
    If[ (vrb||dbg) && !omute, 
      Print["---- Step 0.a: Loading the system ---- "]];

    If[ vrb, Print[ "---- File loaded ..." ] ];


    (* Step 0.b : load schedules *)
    WriteString[ traceFile, "\n---- Step 0.b: Loading the schedules  ----" ];
    If[ (vrb||dbg) && !omute, 
      Print["---- Step 0.b:  Loading the schedules  ---- "]];

    Module[ {listOfUses},
      Check[
        listOfUses = getUseCalls[],
        synPeriodic::wrgprogram = "could not get the list of use calls...";
        Throw[ Message[ synPeriodic::wrgprogram ] ]
      ];

      Check[
        Map[ loadScheduleLibrary[#]&, listOfUses ],
        synPeriodic::missingsched = "could not get all the schedules of the uses...";
        Throw[ Message[ synPeriodic::missingsched ] ]
      ];

    ];
    If[ vrb, Print[ "---- Schedules loaded ..." ] ];

    (* Step 1 -------------------------------- *)
    WriteString[ traceFile, "\n---- Step 1: Computing the periods ----" ];
    WriteString[ traceFile, "\nfindPeriods[ ];\n" ];
    If[ (vrb||dbg) && !omute, 
      Print["---- Step 1: Computing the periods ---- "]];

    (* Computes the periods of the system. Does not check that this
     system is well-formed. *)
    Check[ 
      resOfFindPeriods = findPeriods[ opts ]
    ,
      synPeriods::err1 = "error while computing periods";
      Throw[ synPeriods::err1 ]
    ];

    (* Assign only if result of call is correct, as it may be Null *)
    {nsVectors, connectedC, periodsOfVars, periodsOfUses} = 
      resOfFindPeriods;

    If[ periodsOfVars === {}, 
      synPeriodic::monoch = 
        "This component is monochronous. No need for periodic analysis.";
        Throw[ Message[ synPeriodic::monoch ] ];
    ];

    If[ vrb||dbg, Print[ "---- Periods computed ..." ] ];
    WriteString[ traceFile, "  Null space vectors: ", nsVectors ];
    WriteString[ traceFile, "\n  Connected components: ", connectedC ];
    WriteString[ traceFile, "\n  Periods of variables: ", periodsOfVars ];
    WriteString[ traceFile, "\n  Periods of uses:", periodsOfUses ];
    WriteString[ traceFile, "\n ---- Step 1 was successful ----"];
    If[ dbg, Print["----Periods of uses:", periodsOfUses ] ];

    If[ !omute, Print["---- Step 1 was successful"] ];

    (* Step 2.a -------------------------------- *)
    WriteString[ traceFile, "\n---- Step 2.a: Scheduling the system ----" ];

    If[ (vrb||dbg) && !omute, 
      Print["---- Step 2.a: Scheduling the system ---- "]];

    (* Get the list of uses *)
    uses = Cases[ $result[[6]], use[___] ];

    (* Schedule the system *)
    (* Compute the constraints for scd *)
    addC = Map[ genAddC, connectedC ];

    (* Get output vars of system *)
    results = getOutputVars[];

    (* Get declarations *)
    results = Map[ getDeclaration, results ];

    (* Build pairs variables and number of dimensions *)
    results = Map[ {#[[1]], #[[3,1]]}& , results ];

    (* Generate the time coefficients, make sure that they are declared in 
      the Work context *)
    results = Map[ Table[ ToExpression["Alpha`Work`T"<>#[[1]]<>"D"<>ToString[i]], 
      {i,1,#[[2]]}]&, results ];

    (* Generate objective function *)
    objF = Apply[ Plus, Flatten[ results ] ];

    (* Infer the durations *)
    (* Currently, this is useless. Initially, I assumed I would
     put durations of 1 except to connexions. Actually, in order to
     generate a simple Vhdl, it is required that no register are in 
     the code. This may change, but currently, it is safer to do so *)

    equs = Table[0,{i,1,Length[dep[][[1]]]}];
    If[ dbg, Print["Durations: ", equs] ];

    durs = durations/.optOfSched/.Options[ scd ];
    durz = durationsNonZero/.optOfSched/.Options[ scd ];

    If[ durs =!= {}||durz =!= {}, equs = {}];

    WriteString[ traceFile, "\n  Durations: ", equs ];
    WriteString[ traceFile, "\n  Objective Function: ", objF ];
    WriteString[ traceFile, "\n  Constraints: ", addC ];
    WriteString[ traceFile, "\n  Periods of uses: ", periodsOfUses ];
    WriteString[ traceFile, "\n  Periods of vars: ", periodsOfVars ];

    If[ dbg, 
      ashow[];
      Print[ addC ];
      Print[ FullForm[addCOpts] ];
      Print[ objF ]
    ];

    If[ dbg, 
      Print["scd[ optimizationType -> Null, periods -> ", periodsOfUses,
      ",addConstraints -> ", Union[ addC, addCOpts ], 
	    Apply[ Sequence, optOfSched ],
      " objFunction -> ", objF, ", durations -> ", equs, ", verbose -> False]"
      ]
    ];

    WriteString[ traceFile, 
      "\nscd[ optimizationType -> Null, periods -> ", periodsOfUses,
      ",addConstraints -> ", Union[ addC, addCOpts ],
      " objFunction -> ", objF, ", durations -> ", equs, ", verbose -> False]"
    ];

    (* Calls the scheduler, and returns the results *)
    Check[ 
      sched = 
        scd[ optimizationType -> Null, 
	     periods -> periodsOfUses,
             addConstraints -> Union[ addC, addCOpts ],
	     objFunction -> objF, durations -> equs, verbose -> False,
             Apply[ Sequence, optOfSched ], 
	     additionalObjectiveFunction -> True, integerSolution -> False ],
      synPeriodic::schedpb = "message was emitted during schedule calculation...";
      Message[ synPeriodic::schedpb ];
    ];

    If[ Cases[ sched, Indeterminate, Infinity ] =!= {} || sched === Null, 
	synPeriodic::nosched = "could not find a schedule. Aborting...";
	Throw[ Message[ synPeriodic::nosched ] ]
    ];

    WriteString[ traceFile, "\n --- Schedule found" ];
    If[ dbg, Print[ " ---- Schedule found: " ]; showSchedResult[] ];

    (* Step 2.b -----------------------------  *)
    If[ vrb||dbg, 
      Print["---- Step 2.b: Generating additional registers ---- "]];
    WriteString[ traceFile, 
       "\n---- Step 2.b: Generating additional registers ---- "];

    (* Get the list of true dependencies where the schedule of the
     lhs is different from that of the rhs *)
    diffInSchedules = 
    Select[ dep[][[1]], getSchedule[#[[2]]][[3]] =!=  
	    getSchedule[#[[3]]][[3]]&];

    If[ (dbg) && diffInSchedules =!= {}, 
      Print[ "\n    Adaptors have to be put for dependences" ];
      show[ dtable[ diffInSchedules ] ];
    ];

    (* This auxiliary function is used in order to generate
     information regarding the adaptation between signals *)
    Clear[ auxFunc ];
    auxFunc[ d:_depend ] := 
    Catch[
      Module[ { ext, orig },
        ext = getSchedule[ d[[2]] ];
        orig = getSchedule[ d[[3]] ];
	      If[ dbg, Print[ ext ] ];
	      If[ dbg, Print[ orig ] ];
        If[ Length[ ext[[2]] ] =!= Length[ orig[[2]] ], 
          Print["Impossible to adapt dependency: ", 
            show[ dtable[{d}], silent -> True ],
            " since they have different number of indexes." ];
	    ashow[ ext ]; Print[ ext ];
	    ashow[ orig ]; Print[ orig ]; 
            Throw[ "" ]             
        ];
        If[ ext[[3,1]] =!= orig[[3,1]], 
          Print["Impossible to adapt dependency: ", 
		show[ dtable[{d}], silent -> True ],
            " since they have different affine schedules." ]; 
	    Print[ "Schedule of extremity: ",  ext ];
	    Print[ "Schedule of origin: ", orig ]; 
          Throw[ "" ] 
        ];
        {ext[[1]], orig[[1]], expType[ ext[[1]] ], ext[[3,2]] - orig[[3,2]]}
      ]
    ];
    auxFunc[___] := Message[ auxFunc::params ];

    (* Returns pairs of signals and the number of registers 
      between these signals *)
    diffInSchedules = 
      Map[ 
        auxFunc,
        diffInSchedules
    ];
  
    If[ dbg, Print["  List of differences in schedules: ", 
      diffInSchedules] ];

    If[ diffInSchedules === {} && dbg, Print[ "No adaptation to do" ] ];
 
    If[ MemberQ[ diffInSchedules, "" ], 
      synPeriodic::failure = 
        "could not adapt schedules... Sorry, no code was generated .";
	Throw[ Message[ synPeriodic::failure ] ] 
    ];

    (* Now, add registers for all pairs of variables that have 
     a difference in the schedule *)

    For[ 
      i = 1, 
      i <= Length[ diffInSchedules ], 
      i++,

      Module[ { vara, varb, scd1, scd2, varbDel, pov },
        vara = diffInSchedules[[i,1]];
        varb = diffInSchedules[[i,2]];

        varbDel = varb<>"DelBy"<>ToString[ diffInSchedules[[i,4]] ];

        If[ !MemberQ[ getLocalVars[], varbDel], 
          addRegisters[ vara, varb, diffInSchedules[[i, 4]] ];

          scd1 = getSchedule[ vara ];
          scd2 = getSchedule[ varb ];

          (* Update the list of periods of uses *)
          (* Get the period of varb, as period of delayed varibale
            will be the same  *)
          pov = Select[ periodsOfVars, #[[2]]===varb& ];
          pov = pov[[1,1]];
          periodsOfVars = Append[ periodsOfVars, { pov, varbDel } ];

          (* Add a period in the list of periodsOfUses, for the 
            new added register *)
          periodsOfUses = Append[ periodsOfUses, pov ];

          (* Update the schedule *)
          $schedule = 
            scheduleResult[ 
              $schedule[[1]], 
              Append[ $schedule[[2]], 
                {varbDel,scd1[[2]],scd1[[3]]} 
            ]
          ];
        ];
      ];
    ];

    (* Put the new system *)
    putSystem[];

    (* Update the list of uses, as system was modified *)
    uses = Cases[ $result[[6]], use[___] ];

    (* Call depGraphViz *)
    depGraphViz[ displaySchedule -> True ];
    WriteString[ traceFile, "\n--- Dependence graph was printed in dot form in ", 
      Directory[]];

    (* Step 3 -------------------------------- *)
    (* Set value of parameters *)
    WriteString[ traceFile, "\n---- Step 3: Setting parameter's value ..." ];
    If[ vrb, Print[ "---- Step 3: Setting parameter's value ..." ] ];

    (* Get the list of system parameters *)
    params = getSystemParameters[];
    paramsRules = parameterRules/.{opts}/.Options[synPeriodic];

    If[ Union[ Map[ First, paramsRules ]] =!= Union[ params ], 
      synPeriodic::warnParameters = 
      "Warning: some parameters are not assigned. Vhdl will be incomplete...";
      Print[ synPeriodic::warnParameters ]
    ];

    (* We built, for each use in the system, a transformation of the 
     rule in order to know the value of the parameter *)
    Check[
      paramsOfUses = Map[ parameterRuleOfUse[#, paramsRules ]&, uses ],
      synPeriodic::errrules = "error while finding parameter rules";
      Throw[ Message[synPeriodic::errrules] ]
    ];

    WriteString[ traceFile, "\n---- Parameters's values were set ..." ];
    If[ dbg, Print[ "----  Parameter's value was set..." ] ];

    (* Step 4 -------------------------------- *)
    WriteString[ traceFile,
       "\n---- Step 4: Generating the delayed enable signals ---- "];
    If[ vrb||dbg, 
      Print["---- Step 4: Generating the delayed enable signals ---- "]];

    (* We now have the scheduling, and we can add the proper registers
     whenever they are needed *)

    (* For each use, we compute the shift that it has to get. This shift
      is computed based on the schedule of its first input *)
    shiftOfUses = {};
    Do[
       Module[ {oneUse, ivars, ovars, ischeds, oscheds, scheds},
         oneUse = uses[[i]];
         If[ dbg, Print[" ------- Considering use # ", i, " ", oneUse[[1]] ]]; 
         ivars = oneUse[[4]]/.{var[u_]->u};
         ovars = oneUse[[5]]/.{var[u_]->u};
         ischeds = Flatten[ Map[ Cases[ sched[[2]],{#,__}]&, ivars ], 1 ];
         oscheds = Flatten[ Map[ Cases[ sched[[2]],{#,__}]&, ovars ], 1 ];
	 scheds = Join [ 
           Map[ {#[[1]], #[[3,2]]}&, ischeds ],
           Map[ {#[[1]], #[[3,2]]}&, oscheds ]
         ];
         If[ dbg, Print[ "Shifts of inputs and outputs: ", scheds ];
           Print[" ----> This component will be shifted by: ", scheds[[1,2]],
         " cycles."]];
         shiftOfUses = Append[ shiftOfUses, { oneUse[[1]], scheds[[1,2]] } ];
       ]
       ,
      {i,1,Length[uses]}
    ];

    If[ dbg, Print[ "Shifts of the uses: ", shiftOfUses ] ];

    (* Compute the list of reset signals *)
    listOfResets = 
      Complement[ Union[ Map[ Last, shiftOfUses ], {0} ] ];
    shiftOfResets = listOfResets;
    If[ dbg, Print[ "Shifts of resets: ", shiftOfResets ] ];

    listOfResets = Map[ "reset"<>ToString[#]&, listOfResets ];
    If[ dbg, Print[ "Reset signals: ", listOfResets ] ];
    declOfResets = 
    Apply[ StringJoin, Map[ "    SIGNAL "<>#<>" : STD_LOGIC;\n"&, 
      listOfResets ] ];
    If[ dbg, Print[ "Declarations of reset signals: ", declOfResets ] ];

    (* Compute for each use, the list of its name, its period and its shift *)
    listOfPeriodsAndShifts = 
      MapThread[ Insert[ #1, #2, 2 ]&, {shiftOfUses, periodsOfUses}];
    If[ dbg, 
	Print[ "List of uses, periods and shifts: ",
        listOfPeriodsAndShifts ] 
    ]; 

    (* Add the name of the corresponding enable. It is "" if the use
     is a ROM, an overSampling or an underSampling, and also if the
     shift is 0 *)
    listOfDelEnables = 
      Map[ 
	  Which[ 
            #[[1]] === "ROM" ||  #[[1]] === "overSampling" ||
	    #[[1]] === "underSampling" || #[[1]] == "upSampling" ||
            #[[1]] === "downSampling"
          , 
            ""
          ,
            #[[-1]] === 0, 
            "enable"<>ToString[ #[[2]] ]
          ,
          True
          ,
            "enable"<>ToString[ #[[2]] ]<>"_"<>ToString[ #[[-1]] ]
          ]&,
      listOfPeriodsAndShifts ];

    If[ dbg, Print["List of delayed enable signals: ",  listOfDelEnables ] ]; 

    (* Built the list of names, periods, shift and enable names *)
    listOfPeriodsAndShifts = 
      MapThread[ Append[ #1, #2 ]&, 
        {listOfPeriodsAndShifts, listOfDelEnables} 
      ];

    If[ dbg, Print["List of periods and shifts: ",  listOfPeriodsAndShifts ] ];

    (* Built the corresponding declaration list *)
    declOfDelEnables = Union[ listOfDelEnables ];
    If[ dbg, Print["List of delayed enable signals: ",  listOfDelEnables ] ]; 

    (* We now generate the components and the architectures of the 
     enable generators *)

    (* Built the list of names and shifts, by removing the items 
     that have either a "" enable name or a 0 shift *)
    listOfNamesAndShifts = 
      Select[ 
       listOfPeriodsAndShifts, (#[[3]] =!= 0) && (#[[4]] =!= "")& ];

    listOfNamesAndShifts = 
    Union[ 
      Complement[ Map[ {#[[2]], #[[3]],#[[-1]]}&, listOfNamesAndShifts ], {""} ] 
    ];

    If[ dbg, Print["List of names and shifts: ",  listOfNamesAndShifts ] ];

    vhdlRegisters = 
    Map[ 
      Module[ {vhdlCode,vhdlF,enName},
        enName = #[[3]];
        vhdlCode = 
            genVhdl[ "Registers", "$name$" -> "Registers"<>enName,
             "$size$" -> ToString[#[[2]]], "$comment$" ->
             "Register file for "<>enName];
        vhdlF = OpenWrite[ Directory[]<>"/"<>getSystemName[]<>
              "synPeriodic/Vhdl/Registers"<>enName<>".vhd"];
        WriteString[ vhdlF, vhdlCode[[2,1]] ];
        Close[ vhdlF ];
        vhdlF = OpenWrite[ Directory[]<>"/"<>getSystemName[]<>
             "synPeriodic/Vhdl/Registers"<>enName<>".component"];
        WriteString[ vhdlF, vhdlCode[[1,1]] ];
        Close[ vhdlF ];
        vhdlCode
      ]&, listOfNamesAndShifts
    ];

    (* Find the number of equations. It is used to number the 
      labels of the PORT MAPS *)
    numberOfEquations = Length[ $result[[6]] ];

    (* Add the calls to the register files *)
    callRegisters = 
      MapThread[ 
        genVhdl[ "CallRegisters", "$name$" -> "Registers"<>#1[[3]],
		 "$enableIn$" -> "enable"<>ToString[#1[[1]]],
	 "$enableOut$" -> #1[[3]], "$number$" -> ToString[#2] ]&,
        {listOfNamesAndShifts,
         Range[ numberOfEquations + 1, 
		numberOfEquations + Length[ listOfNamesAndShifts ] ]}
    ];

    callRegisters = 
      Apply[ StringJoin, Map[ "   "<>First[#]<>"\n"&, callRegisters ] ];

    If[ dbg, Print[ "Calls to registers: ", callRegisters ]];

    (*
    (* Add if needed one equation for reset0 *)
    If[ MemberQ[ Union[ shiftOfResets ], 0 ], 
      callRegisters = callRegisters <>"    reset0 <= rst;" ];
     *)

    (* Step 5 -------------------------------- *)
    If[ vrb||dbg, Print["---- Step 5: Generating the enables ---- "]];

    (* listOfPeriodsAndShifts is the reference here *)
    If[ dbg, Print["List of periods and shifts: ",  listOfPeriodsAndShifts ] ];

    If[ dbg, Print["List of enables: ", listOfDelEnables ] ];

    (* Compute the list of enable signals *)
    (* There is one such signal for each period *)
    listOfEnables = Complement[ Union[ listOfDelEnables ], {""}];

    listOfPeriods = 
      Complement[ 
        Map[ #[[2]]&, 
	     Select[ listOfPeriodsAndShifts, Last[#]=!=""&] 
           ], {1} 
      ];

    If[ dbg, Print[ "List of names and shifts: ", listOfNamesAndShifts ] ];
    If[ dbg, Print[ "Enable signals: ", listOfEnables ] ];
    If[ dbg, Print[ "List of periods: ", listOfPeriods ] ];

    (* Build declarations of enable signals *)
    declOfEnables = 
    Apply[ StringJoin, 
      Map[ "    SIGNAL "<>#<>" : STD_LOGIC;\n"&, listOfEnables ] ];
    If[ dbg, Print[ "Declarations of enable signals: ", declOfEnables ] ];

    (* We now generate the components and the architectures of the 
     enable generators *)
    vhdlEnables = Map[ 
      Module[ {vhdlCode,vhdlF},
        vhdlCode = 
          genVhdl[ "PeriodicEnable", "$name$" -> "PeriodEnable"<>ToString[#], 
           "$period$" -> ToString[#], "$comment$" -> "Periodic enable "<>
           ToString[#] ];
        vhdlF = OpenWrite[ Directory[]<>"/"<>getSystemName[]<>
	 "synPeriodic/Vhdl/PeriodicEnable"<>ToString[#]<>".vhd"];
	      WriteString[ vhdlF, vhdlCode[[2,1]] ];
	Close[ vhdlF ];
        vhdlF = OpenWrite[ Directory[]<>"/"<>getSystemName[]<>
	 "synPeriodic/Vhdl/PeriodicEnable"<>ToString[#]<>".component"];
        WriteString[ vhdlF, vhdlCode[[1,1]] ];
	Close[ vhdlF ];
        vhdlCode
        ]&, listOfPeriods
    ];

    (* Add the calls to the enable generators *)
    callEnables = 
      MapThread[ 
        genVhdl[ "CallPeriodicEnable", "$name$" -> "PeriodEnable"<>ToString[#1],
	 "$enable$" -> "enable"<>ToString[#1], "$number$" -> ToString[#2] ]&,
        { listOfPeriods, 
         Range[ numberOfEquations + Length[ listOfNamesAndShifts ] + 1, 
           numberOfEquations + Length[ listOfNamesAndShifts ] + 
             Length[ listOfPeriods ]]}
    ];
    callEnables = 
      Apply[ StringJoin, Map[ "   "<>First[#]<>"\n"&, callEnables ] ];

    (* Add if needed one equation for enable1 *)
    If[ MemberQ[ Union[ periodsOfUses ], 1 ], 
      callEnables = callEnables <>"    enable1 <= CE;\n\n" ];

    (* Step 6 -------------------------------- *)
    If[ vrb||dbg, 
      Print["---- Step 6: Generating the FSM ---- "]];

    (* We now generate the FSM *)
    vhdlFSM = 
        genVhdl["Fsm", listOfResets, 
          MapThread[ {#1,#2}&, {shiftOfResets,listOfResets} ],
          "$name$"->"FSM", "$comment$" -> "Controller"];

    (* Create the files for the FSM *)
    Module[ {vhdlF},
      vhdlF = OpenWrite[ Directory[]<>"/"<>getSystemName[]<>
        "synPeriodic/Vhdl/FSM.vhd"];
      WriteString[ vhdlF, vhdlFSM[[2,1]] ];
      Close[ vhdlF ];
      vhdlF = OpenWrite[ Directory[]<>"/"<>getSystemName[]<>
        "synPeriodic/Vhdl/FSM.component"];
      WriteString[ vhdlF, vhdlFSM[[1,1]] ];
      Close[ vhdlF ];
    ];

    (* Create the call to the FSM that has to be added to the code *)
    callFSM = genVhdl[ "CallFsm", listOfResets, 
      "$number$" -> ToString[ numberOfEquations ] ];
    callFSM = First[ callFSM ]<>"\n";

    (* Step 7 -------------------------------- *)
    If[ vrb||dbg, 
      Print["---- Step 7: Generating Vhdl of called systems ---- "]];

    (* Now, generate the "normal VHDL". Before, fix the values of
     the parameters *)
    savelib = $library;  (* save library *)
    saveprog = $result;  (* save $result *)
    sys = $library;

    Do[
      Check[
        sys = fixParameter[ paramsRules[[i]][[1]], paramsRules[[i]][[2]], 
        $result[[1]], sys, recurse -> False, mute -> True ],
        synPeriodic::errsettingparams = "could not set parameter value in main";
        $result = saveprog; (* Restore $result *)
        $library = savelib;
        Throw[ Message[ synPeriodic::errsettingparams ] ]
      ];
      ,
      {i,1,Length[paramsRules]}
    ];

    sys = getSystem[ $result[[1]], sys ];

    $result = saveprog;
    $library = savelib;

    (* Translate into VHDL the system. Result is a list of 
     components, a list of architectures and a list of names. 
     The architectures are written in a file, in the VHDL directory *)

    (* Get the current value of the list of messages generated so far *)
    listOfMessages = $MessageList; 

    Check[
      result = 
      MapThread[ equationAnalysis[#1, #2, #3, #4, #5,
        Directory[]<>"/"<>getSystemName[]<>"synPeriodic/VHDL", opts ]&, 
        {uses, periodsOfUses, shiftOfUses, paramsOfUses, Range[Length[uses]]} ],
      (* Throw an exception if a new message was generated, unless 
       the message is related to the ROM values *)
      lastMessages = 
        Complement[ $MessageList, listOfMessages, 
		  {HoldForm[MessageName[genVhdl,"RomValuesLg"]]} ];
      If[ lastMessages =!= {}, Throw["Error... "] ]
    ];

    WriteString[ traceFile, "\n --- Vhdl files generated " ];

    (* Step 8 -------------------------------- *)
    If[ vrb||dbg, 
      Print["---- Step 8: Generating Vhdl of calling system ---- "]];

    (* We generate the vhdl code for the calling system *)
    Check[ 
      resultOfa2v = 
        First[ a2v[sys, noVhdlFile -> True, 
                   stdLogic -> True, mute -> True, verbose -> False,  
                   vhdlPatterns -> True] ];

      If[ Length[ resultOfa2v ] === 3, 
        {mainCodeVhdl, mainComponent, mainComponentsUsed} = resultOfa2v;
         mainPackage = Null,
         {mainCodeVhdl, mainPackage, 
          mainComponent, mainComponentsUsed} = resultOfa2v;
      ]
      ,
      synPeriodic::wrgvhdl = "Could not generate Vhdl code";
      Throw[ Message[ synPeriodic::wrgvhdl ] ]
    ];

    (* Now, we insert in the main Vhdl code the components that
      were found in vhdlComp *)
    vhdlComp = Map[ First, result ];
    componentsOfMain = "-- Pre-defined components\n\n"<>
    Apply[ StringJoin, vhdlComp ];

    (* We substitute the components in the place holder of the main vhdl *)
    mainCodeVhdl = StringReplace[ mainCodeVhdl, "-- $MissingComponents$" ->
      componentsOfMain<>Apply[StringJoin, 
        Map[ First, vhdlEnables ] ]<>
        Map[ First, vhdlRegisters]<>vhdlFSM[[1,1]]
    ];

    (* We substitute the declarations in the place holder of the main vhdl *)
    mainCodeVhdl = StringReplace[ mainCodeVhdl, "  -- $MissingDeclarations$" ->
      "  -- Declaration of reset and enable signals\n"<>
      declOfResets<>declOfEnables
    ];

    (* We substitute in mainCodeVhdl the clock-enables and the resets *)
    Do[
       mainCodeVhdl = 
       StringReplace[ mainCodeVhdl, 
        {"$CE"<>ToString[i]<>"$" -> listOfDelEnables[[i]],
         "$Rst"<>ToString[i]<>"$" -> "reset"<>ToString[shiftOfUses[[i,2]]]}
      ];
       ,
      {i,1,Length[ periodsOfUses ]}
    ];

    If[ dbg, Print[ "Call to registers for enables: ", callRegisters ] ];

    (* We substitute in mainCodeVhdl the calls *)
    mainCodeVhdl = 
      StringReplace[ mainCodeVhdl, " -- $AdditionalCode$" -> callFSM<>
      callEnables<>callRegisters ];

    (* We substite the declarations of ROM addresses with the 
     correct declaration in the vhdl code. The correct type was
     supplied while generating the call to the ROM. We also do the
     same for the signals that were replaced by the adapted signals 
     the list of which is in adaptedSignals *)

    vhdlDecl = Map[ #[[4]]&, result ];
    (*    vhdlDecl = Select[ vhdlDecl, # =!= {}& ]; *)
    If[ dbg, Print["Declarations of adapted signals: ", vhdlDecl ] ];

    vhdlDeclOfAdapted = 
    Map[ 
      If[ #1 =!= {}, 
        Module[ {x},
          x = Cases[ adaptedSignals, {#1[[1]],y_} ];
          If[ Length[x] =!= 1, {}, {x[[1,2]],#1[[2]]} ]
          ],
        {}]&, 
      vhdlDecl
    ];

    If[ dbg, 
      Print["Declarations of replaced signals: ", vhdlDeclOfAdapted ] ];

    mainCodeVhdl = 
      Fold[
        Function[ { code, nt },
		  If[ nt === {}, code,
            StringReplace[ code, 
              Shortest[("SIGNAL "<>nt[[1]])~~__~~";"~~EndOfLine] 
			   -> "SIGNAL "<>nt[[1]]<>" : "<>nt[[2]]<>";"
            ]
          ]
        ],
        mainCodeVhdl, Union[ vhdlDecl, vhdlDeclOfAdapted ]
      ];

   (* Write main file *)
    mainVhdlFile = OpenWrite[ dirSyn<>"/VHDL/"<>getSystemName[]<>".vhd" ];
    WriteString[ mainVhdlFile, mainCodeVhdl ];
    Close[ mainVhdlFile ];

    (* We now substitute some place holders in the main Vhdl *)
    vhdlArchi = Map[ #[[2]]&, result ];
    vhdlNames = Map[ #[[3]]&, result ];

    If[ dbg||True, Print["101010101010 --- Modify delete components "] ];
    Module[ {fileToDelete},
       fileToDelete = FileNames[ "*.component", dirSyn<>"/VHDL" ] ;
       DeleteFile[ fileToDelete ]
    ];

    (* Get end time *)
    eTime = TimeUsed[];
    WriteString[ traceFile, "\n----  Total time: ", eTime - bTime, " seconds"];

    Print["----  Congratulations, you made it ! "];
    Print["----  Total time: ", eTime - bTime, " seconds"];
  ];
];
  If[ dbg, Print["Closing trace file..."] ];
  Close[ traceFile ];
];

(* synPeriodic::params = "wrong parameters"; *)
synPeriodic[___] := Message[synPeriodic::params];

(* This function generates the Vhdl for an equation *)
(* eq is an equation, pe is the period, rank is the rank of the use, 
  shift is the shift of the beginning, and params is the replacement
 rules for the parameters of the system *)
Clear[ equationAnalysis ];
equationAnalysis[ eq:_, pe:_Integer, shift:_,
		  params:_,  rank:_Integer, vhdlFile:_, opts:___Rule ] := 
Catch[
  Module[ {vhdlComp, vhdlArchi, vhdlDecl, vhdlF, vhdlName, dbg, vrb, pmR,
    romDataOpt },

    vrb = verbose/.{opts}/.Options[ synPeriodic ];
    dbg = debug/.{opts}/.Options[ synPeriodic ];
    pmR = parameterRules/.{opts}/.Options[ synPeriodic ];
    (* romData is the option for the ROM values *)
    romDataOpt = romData/.{opts}/.Options[ synPeriodic ];

    (* vhdlDecl is used only for the ROM generator, as the type of the
      ROM address has to be returned *)
    vhdlDecl = {};

    If[ dbg,
      Print["--- Equation : ", ashow[ eq, silent->True ] ];
      Print["---- Shift: ", shift ];
      Print["----Params: ", params ];
    ];

    vhdlComp = {};
    vhdlArchi = {};
    vhdlName = "";

    (* We now have a big switch, depending on the type of equation found *)
    Switch[ eq,

      (* A simple equation A = B : generate a connection *)
      equation[_String, _String ], 
      Module[ {},
        If[ dbg, Print["Just a connection..."] ]; 
          vhdlArchi = eq[[1]]<>" <= "<>eq[[2]];
      ]
    ,

      (* A simple equation A = var[B], idem above  *)
      equation[_String, var[_String] ], 
      Module[ {},
        If[ dbg, Print["Just a connection..."] ]; 
          vhdlArchi = eq[[1]]<>" <= "<>eq[[2,1]];
        ]
    ,

      (* oversampling. We just put a connection *)
      use[("overSampling"|"upSampling"),___], 
      Module[ {l,r},
        If[ dbg, Print["Just a connection..."] ]; 
          l = eq[[4,1]]; r = eq[[5,1]]; 
          If[ MatchQ[ l, var[_] ], l = First[ l ]];
          If[ MatchQ[ r, var[_] ], r = First[ r ]];
          vhdlArchi =  r<>" <= "<>l;
        ]
    ,

      (* undersampling. We just put a connection *)
      use[("underSampling"|"downSampling"),___], 
      Module[ {l,r},
        If[ dbg, Print["Just a connection..."] ]; 
          l = eq[[4,1]]; r = eq[[5,1]]; 
          If[ MatchQ[ l, var[_] ], l = First[ l ]];
          If[ MatchQ[ r, var[_] ], r = First[ r ]];
          vhdlArchi =  r<>" <= "<>l;
      ]
    ,

    (* A ROM. We generate the component in a file, using genVhdl
      function in Vhdl2.m  *)
      use["ROM",___], 
      Module[{ m, c, comp, archi, vals, decl, wl, variable, 
        romFile},

        (* variable is the variable of the ROM *)
        variable = eq[[5,1]]; 

        (* m is the matrix of the use *)
        m = eq[[3]]; 

        (* c is size of the ROM. It is obtained from
          the parameter of the ROM, times the matrix, and then
          we apply the replacement rules defined by the 
          parameters of the calling system *)
        c = First[ m[[4]].Append[ m[[3]], 1 ] ]/.pmR;

        (* Build the name of the call: name of the 
          ROM appended with the rank in the uses *)
        vhdlName = "ROM"<>ToString[rank];

        (* Find out values for the variable *)
        romFile = Select[ romDataOpt, MatchQ[ #, {variable,_}]& ];

        (* Define the values to 0 *)
        If[ romFile === {}, 
          Print["No values for ROM of variable ", variable ];
	  vals = Table[ 0, {i,1,c} ],
          romFile = romFile[[1,2]]; 
	  If[ FileInformation[ romFile ] === {}, 
            synPeriodic::noRomFile = "ROM file `1` does not exist";
            Message[ synPeriodic::noRomFile, romFile ];
            vals = Table[ 0, {i,1,c} ],
            vals = Get[romFile];
            synPeriodic::noRomFile = 
              "ROM data for variable `1` do not have the correct length (`2` values instead of `3`). Zero values assumed.";
            If[ Length[ vals ] =!= c, 
              Message[ synPeriodic::wrongRom, variable, Length[ vars ], c ];
              vals = Table[ 0, {i,1,c} ]
            ];
          ];
        ];

	(* Add backslashed quotes to values *)
        vals = ToString[ Map[ "\""<>#<>"\""&, vals ] ];

        (* Remove initial and final parentheses *)
        vals = 
          StringDrop[ 
            StringDrop[ 
              ToString[ vals ], 
              1 
            ], 
            -1 
         ];

        (* Get the word length *)
        decl = getDeclaration[ eq[[5,1]] ];
        wl = If[ MatchQ[ decl[[2]], integer["S",_]],
          decl[[2,2]], 16 ];
        If[ dbg, Print["Generate a ROM at period: ", pe, 
          " rank: ", rank, " word length: ", wl, 
          " size: ", c, " values: \n", vals ] 
        ];

        (* Call the vhdl generator *)
        { vhdlComp, vhdlArchi } = 
        genVhdl["ROM", "$name$" -> vhdlName, 
          "$period$" -> ToString[pe],
          "$size$" -> ToString[c], 
          "$wordLength$" -> ToString[wl], 
          "$comment$" -> "ROM of size "<>ToString[c]<>
          " and of word length "<>ToString[wl],
          "$values$" -> vals];

        (* Find out the modified declaration for the address *)
        (* This is because the addresses of the ROM are declared 
          as integer with a range equal to the number of 
          addresses, and not a std logic. We return the name 
          of the address and its new type *)
        vhdlDecl = {eq[[4,1,1]], 
                "INTEGER RANGE 0 TO "<>ToString[ c - 1 ]};
        ]
    ,

      (* A modulo address generator. We also use genVhdl *)
      use["ModuloAddress",___], 
      Module[{m,c},
        (* Same meaning for m and c as for the ROM *)
        m = eq[[3]]; 
        c = First[ m[[4]]. Append[ m[[3]], 1 ] ]/.pmR;
        If[ dbg, 
          Print["Generate a modulo address generator at period: ", pe,
          " rank: ", rank, " size: ", c ]];
        vhdlName = "ModuloAddress"<>ToString[rank];
        { vhdlComp, vhdlArchi } = 
          genVhdl["ModuloAddress", "$name$" -> vhdlName,
            "$period$" -> ToString[c],
            "$comment$" -> "Modulo address of period: "<>
            ToString[c]
          ]
      ]
    ,

      (* A register *)
      use["registerFile",___], 
      Module[{m,c},
        (* Same meaning for m and c as for the ROM *)
        m = eq[[3]]; 
        If[ dbg, 
          Print[ m ]; 
          Print[ pmR ]; 
          Print[
            First[ m[[4]]. Append[ m[[3]], 1 ] ]
          ]
        ];

        c = First[ m[[4]]. Append[ m[[3]], 1 ] ]/.pmR;

        If[ dbg,
          Print["Generate a register. ", 
          " rank: ", rank, " size: ", c ]
        ];

        If[ c =!= 1, 
	    (*
          Print[ "Generating the register File: ", rank, vhdlName, ToString[c], "type: ", 
		 "$type$" -> getVhdlType[ eq[[4,1,1]] ] ];
	     *)
          vhdlName = "registerFile"<>ToString[rank];
          (* Set global variable $vhdlCurrent, for the getVhdlType function. This is 
           an horrible kludge, as this function uses this variable... *)
          $vhdlCurrent = $result;

          { vhdlComp, vhdlArchi } = 
            genVhdl["registerFile", "$name$" -> vhdlName,
              "$size$" -> ToString[c], "$type$" -> getVhdlType[ eq[[4,1,1]] ],
              "$comment$" -> "Register file of size: "<>
              ToString[c]
           ]
        ]
      ]
    ,

    (* Another use. We need to find the component, make a copy of 
      it in the directory, in order to insert it in the main program *)
      use[_String,___], 
      If[ dbg, 
        Print["11111111111111111"];
        Print["Directory: ", Directory[] ];
        Print["Looking for component of: ", eq[[1]] ]
      ];

      Module[ {fn, fileC, fileV},       
        fn = FileNames["*.component"]; 
        fileC = eq[[1]]<>".component";
        fileV = eq[[1]]<>".vhd";
        If[ !MemberQ[ fn, eq[[1]]<>".component" ]
        , 
          Print["Warning: could not find component for file ", eq[[1]] ]
        ,
          (* Copy component in vhdl directory, if not already present *)
          If[ FileInformation[ vhdlFile<>"/"<>fileC ] === {},
            CopyFile[ fileC, vhdlFile<>"/"<>fileC ] ];
        ];
      ];
    ,
      _, 
      Null
    ];

    (* Write a VHDL file if the name is not "" *)
    If[ 
       MatchQ[ vhdlFile, _String ] && vhdlName =!= "", 
	vhdlF = OpenWrite[ vhdlFile<>"/"<>vhdlName<>".vhd" ];
	WriteString[ vhdlF, First[ vhdlArchi ]];
	Close[ vhdlF ];
	vhdlF = OpenWrite[ vhdlFile<>"/"<>vhdlName<>".component" ];
	WriteString[ vhdlF, First[ vhdlComp ] ];
	Close[ vhdlF ];
    ];

    (* Return the pair component, architecture *)
    {vhdlComp, vhdlArchi, vhdlName, vhdlDecl}
  ]
];
equationAnalysis[___] := Message[equationAnalysis::params];

Clear[ findPeriods ];
findPeriods[ opts:___Rule ] :=
Module[ {vhdlFile, dbg, vrd },
  Catch[
    Module[ { rom, crom, dept, depSimple, 
	      depUseOver, depUseUnder, otherDepUse, relOfSimple, 
              graphOfSimple, relOfOver, graphOfOver, relOfUnder, 
	      graphOfUnder, relOfOthers, graphOfOthers, graphOfUnion, 
	      connectedC, reducedGraph, relOfLambdasOver, lambdaVars,
	      coefsOfOver, coefsOfUnder, relOfLambdasUnder, elO, elU,
	      sols, graphOfLambdas, isolated, iMatrix, nsVectors,
	      periods, periodsOfVars, periodsOfUses, uses, vars,
	      lp }, 

      (* Get options *)
      dbg = debug/.{opts}/.Options[ synPeriodic ];
      vrb = verbose/.{opts}/.Options[ synPeriodic ];

      (* Compute dependence table *)
      Check[ 
        dept = dep[],
        synPeriodic::dep = "error while computing dependence table";
        Throw[ Message[ synPeriodic::dept ] ];
      ];

      (* Get the list of simple dependencies *)
      depSimple = dept[[1]];    

      (* Get the list of oversampling dependences *)
      depUseOver = 
      Union[ 
        Cases[ dept[[2]], dependuse[ "overSampling", ___ ] ],
        Cases[ dept[[2]], dependuse[ "upSampling", ___ ] ]
      ];
      If[ dbg, Print[ "Over-sampling dependences:", depUseOver ] ];

      (* Get the list of undersampling dependences *)
      depUseUnder = 
      Union[ 
        Cases[ dept[[2]], dependuse[ "underSampling", ___ ] ],
        Cases[ dept[[2]], dependuse[ "downSampling", ___ ] ]
      ];
      If[ dbg, Print[ "Under-sampling dependences: ", depUseUnder ] ];

      (* Get the list of variables *)
      vars = getVariables[];

      (* Build the association use statement and use *)
      uses = Cases[ $result[[6]], use[n:_,_,_,x:_,y:_]->{n,x,y}];
      uses = uses/.{var[x:_String]->x};
      If[ dbg, Print["uses: ", uses ]];

      (* If no oversampling and/or undersampling, return *)
      If[ depUseOver === {} && depUseUnder === {}, 
	  findPeriods::useless = "No oversampling or undersampling"; 
	  Print[ findPeriods::useless ];
	  Throw[ {{},{{1,"lambda1",vars}},
            Map[{1,#}&, vars], Table[1,{i,1,Length[uses]}] } ] 
	  ];

      (* Get the list of other use dependences *)
      otherDepUse = Complement[ dept[[2]], Union[ depUseOver, depUseUnder ] ];
      If[ dbg, Print[ "Other dependences: ", otherDepUse ] ];

      (* Build the simple dependence binary relation *)
      relOfSimple = Map[ {#[[2]],#[[3]]}&, depSimple ];
      If[ dbg, Print[ relOfSimple ] ];

      (* We built the relations between variables which are related
       by an oversampler *)
      If[ depUseOver === {},
        relOfOver={}; coefsOfOver={}
      ,
        relOfOver = Map[ {#[[2,1]],#[[3,1]]}&, depUseOver ];

        (* Make sure that the oversampling rate does not involve
         any non fixer parameter *)
        (* Get the linear part of each dependence matrix *)
        lp = Map[ getLinearPart[ #[[6]] ]&, depUseOver ];
        (* Check that it is a vector of 0''s including possibly {} *)
        lp = Map[ MatchQ[#,{{0...}}]&, lp ];
        lp = Apply[ And, lp ];
        synPeriodic::nonconstantovers = 
	  "one of the oversampling rates depends on a symbolic parameter and is not constant. Cannot compute the periods. Make sure that all rates are constant.";
        If[ !lp, Throw[ Message[synPeriodic::nonconstantovers] ] ];

        (* For each such relation, we get the oversampling rate. It is given
        as the last coefficient of the dependence matrix in the dependuse *)
        coefsOfOver = Map[ #[[6,4,1,-1]]&, depUseOver ];

        If[ dbg, Print[ "Use dependencies with oversampling: ", depUseOver ] ];
        If[ dbg, Print[ "Variables related by oversampling: ", relOfOver ] ];
        If[ dbg, Print[ "Coefficients of over-sampling dependences:", 
           coefsOfOver ] 
        ];
      ];

      (* Make sure that the undersampling rates do not involve
       any non fixer paremeter *)
      If[ depUseUnder === {}, 
        relOfUnder = {}; coefsOfUnder = {}
      ,
        (* Same treatment as for oversampling rates *)
        lp = Map[ getLinearPart[ #[[6]] ]&, depUseUnder ];
        lp = Map[ MatchQ[#,{{0...}}]&, lp ];
        lp = Apply[ And, lp ];
        synPeriodic::nonconstantunders = 
	  "one of the undersampling rates depends on a symbolic parameter and is not constant. Cannot compute the periods. Make sure that all rates are constant.";
        If[ !lp, Throw[ Message[synPeriodic::nonconstantunders] ] ];

        (* We built the relations between variables which are related
         by an undersampler *)
        relOfUnder = Map[ {#[[2,1]],#[[3,1]]}&, depUseUnder ];

        (* For each such relation, we get the undersampling rate. It is given
        as the last coefficient of the dependence matrix in the dependuse *)
        coefsOfUnder = Map[ 1/#[[6,4,1,-1]]&, depUseUnder ];

        If[ dbg, Print[ "Use dependencies with undersampling: ", 
          depUseUnder ] ];
        If[ dbg, Print[ "Variables related by oversampling: ", relOfUnder ] ];
        If[ dbg, Print[ "Coefficients of over-sampling dependences:", 
          coefsOfUnder ] 
        ];
      ];

      (* Build the dependence relation created by subsystems, knowing that they
        all are monochromatic *)
      relOfOthers = Map[ Flatten[Outer[List,#[[2]],#[[3]]],1]&, otherDepUse ];
      relOfOthers = Apply[ Union, relOfOthers];
      If[ dbg, Print[ "Relations between other variables: ",  relOfOthers ] ];
 
      (* We compute the undirected union of the simple dependences and of the 
       use dependences *)
      graphUnion = MakeUndirected[ MakeGraph[ vars, 
        Function[{x,y},
		 MemberQ[ Union[relOfSimple, relOfOthers], {x,y} ] ],
           VertexLabel->True  
      ] ];

      (* Connected components displays groups of variables which 
       have the same period *)
      connectedC = ConnectedComponents[ graphUnion ];
      connectedC = Map[ vars[[#]]&, connectedC];
      connectedC = MapThread[ {"lambda"<>ToString[#1],#2}&, 
        {Range[Length[connectedC]],connectedC}];
      If[ dbg, Print[ "Connected components :", connectedC ] ];

      (* lambdaVars contains the name of the periods to be found *)
      (* We call these the lambda coefficients *)
      lambdaVars = Map[ First, connectedC ];
      If[ dbg, Print["Lambda vars: ", lambdaVars ] ];
      If[ Length[ lambdaVars ] === 1, 
	  Return[ { {}, connectedC, {}, {} } ]
	  ];

      (* We now build the relations between the lambdas coefficients *)
      relOfLambdasOver = 
        MapThread[ {#1,#2}&, 
         {Map[ findComponent[ #, connectedC ]&, Map[ First, relOfOver ] ],
          Map[ findComponent[ #, connectedC ]&, Map[ Last, relOfOver ] ]} ];

      (* Build the relations between the lambdas, due to oversampling *)
      relOfLambdasOver = 
        MapThread[ Append[ #1, #2 ]&, {relOfLambdasOver, coefsOfOver}];
      If[ dbg, Print[ "Oversampling relations between lambda coefficients: ", 
        relOfLambdasOver ] ];

      (* We now build the relations between the lambdas due to undersampling *)
      relOfLambdasUnder = 
        MapThread[ {#1,#2}&, 
         {Map[ findComponent[ #, connectedC ]&, Map[ First, relOfUnder ] ],
          Map[ findComponent[ #, connectedC ]&, Map[ Last, relOfUnder ] ]} ];
      relOfLambdasUnder = 
        MapThread[ Append[ #1, #2 ]&, {relOfLambdasUnder, coefsOfUnder}];
      If[ dbg, Print[ "Undersampling relations between lambda coefficients: ", 
        relOfLambdasUnder ] ];

      (* Finally build the union *)
      relOfLambdas = Union[ relOfLambdasUnder, relOfLambdasOver ];
      If[ dbg, Print[ "Relations between the lambda coefficients: ",
		      relOfLambdas ]];

      (* Build the incidence matrix *)
      iMatrix = Map[ eqToVector[ #, lambdaVars ]&, relOfLambdas ];

      (* Get the null space vectors of this matrix, this gives the
       solutions periods *)
      nsVectors = NullSpace[ iMatrix ];

      (* Analyze solution *)
      Which[ 
        nsVectors === {}, Throw[ "No solution..." ]
      ,
	Length[ nsVectors ] === 1, 
        nsVectors = First[ nsVectors ];
        If[ dbg, Print[ "One solution: ", nsVectors ] ]; 
      ,
	Length[ nsVectors ] >= 1, 
        Print[ "There are several independent components" ];
	Print[ nsVectors ];
	nsVectors = First[ nsVectors ]
     ];

      (* When there is only one solution, compute the periods *)
      periods = Apply[ LCM, nsVectors ]/nsVectors; 
      nsVectors = Apply[ LCM, periods ]/periods;

      (* Add to each connected component its period *)
      connectedC = MapThread[ Prepend[ #1,#2 ]&, {connectedC, nsVectors} ];

      (* Build the association variable, period. This is done by applying
       two functions to the connected list. Pretty hard to read, but works... *)
      periodsOfVars = 
      Flatten[
        Map[ Function[ {u}, Map[ Function[ {x}, {u[[1]], x}], u[[3]] ] ],
	     connectedC ], 1 ];
      If[ dbg, Print[ "Periods of variables:", periodsOfVars ] ];

      (* Find the periods of the uses *)
      periodsOfUses = 
        Map[ 
	  Function[{x},
            Which[ 
              x[[1]] == "overSampling" || x[[1]] == "upSampling",
              getPeriodOfVar[ x[[2,1]], periodsOfVars ]
            ,
              x[[1]] == "underSampling" || x[[1]] == "downSampling",
              getPeriodOfVar[ x[[3,1]], periodsOfVars ]
            ,
               x[[2]] =!= {}, getPeriodOfVar[ x[[2,1]], periodsOfVars ]
            ,
               x[[3]] =!= {}, getPeriodOfVar[ x[[3,1]], periodsOfVars ]
            ,
	      True, {}
            ]
          ], uses
      ];

      If[ dbg, Print[ "Periods of uses:", periodsOfUses ] ];

      Return[ { nsVectors, connectedC, periodsOfVars, periodsOfUses }];

    ];
  ]
];
findPeriods::params = "wrong parameters";
findPeriodis[___] := Message[findPeriods::params];

(* Auxiliary function of findPeriods. Gets the period of a variable *)
Clear[ getPeriodOfVar ]; 
getPeriodOfVar[ v:_String, l:_ ] :=
Module[ {s},
  s = Cases[ l, {p:_Integer, v}->p ];
  First[ s ]
];
getPeriodOfVar[___] := Message[ getPeriodOfVar::params ];

(* Auxiliary function of synPeriodic. It generates the addContraints 
 options for the scd function *)
Clear[ genAddC ]; 
genAddC[ {p:_Integer, _, v:{___String}} ]:=
Module[ {c},
  c = Map[ "T"<>#<>"D1"&, v ];
  c = Apply[ "Equal", Append[ c, p ] ];
  ToString[ c ]
];
genAddC::params = "wrong parameters"; 
genAddC[___] := Message[ genAddC::params ];

(* Auxiliary function of synPeriodic. It transforms a 3-uplet 
 {origin, extremity, number} into a line of the incidence matrix
 from which the period is going to be computed *)
Clear[ eqToVector ]; 
eqToVector[ {o:_String, e:_String, w:_}, varVector:{___String} ] :=
Module[ {v},
  Map[ Which[# === o, 1, # === e, -w, True, 0]&, varVector ]
];
eqToVector::params = "wrong parameters"; 
eqToVector[___] := Message[ eqToVector::params ];

(* Auxiliary function of synPeriodic. From a variable and
 the connected component list of the dependence graph, it returns
 the component to which this variable belongs *)
Clear[ findComponent ];
findComponent[ var:_String, cc:_List ]:=
  Module[ {res},
    res = First[ First[ Select[ cc, MemberQ[ Last[ # ], var ]& ] ] ]
];
findComponent::params = "wrong parameters";
findComponent[___] := Message[findComponent::params ];

(* The main function *)
Clear[ syn ];
syn[ file:_String, opts:___Rule ] :=
Catch[
  Module[ { vrb, dbg, optsScheduler, paramsRules, 
    params, dirSyn, resAnalyze, optScd,
    traceFile, tempName, optsAppSched, pSteps, bTime, eTime, pipeOpt },

    (* Set initial time *)
    bTime = TimeUsed[];

    (* Get options *)
    vrb = verbose/.{opts}/.Options[ syn ];
    dbg = debug/.{opts}/.Options[ syn ];
    optScd = schedMethod/.{opts}/.Options[ syn ];
    pSteps = placementSteps/.{opts}/.Options[ syn ];
    pipeOpt = pipe/.{opts}/.Options[ syn ];

    If[ vrb, Print[ "++++  Loading file..." ] ];

    Check[ load[ file, mute->True ], 
      syn::errorLoad = "error while loading file. syn aborted...";
      Throw[ Message[ syn::errorLoad ] ]
    ];

    (* Create the directory where the traces will be put *)
    dirSyn = Directory[]<>"/"<>getSystemName[]<>"SYN/";
    If[ dbg, Print["Directory: ", dirSyn ] ];
    If[ FileInformation[ dirSyn ] === {}, CreateDirectory[ dirSyn ] ];

    (* Open the trace File, and if it fails, try to recover problem *)
    Check[ 
      traceFile = OpenWrite[ dirSyn<>"trace.txt " ],
      Close[Streams[][[-1]]];
      traceFile = OpenWrite[ dirSyn<>"trace.txt " ]
    ];

    (* Put some info *)
    WriteString[ traceFile, "(* ----------\n  Trace file \n  " ];
    WriteString[ traceFile,
      Date[][[3]],"/",Date[][[2]],"/",Date[][[1]]," -- ",
      Date[][[4]],"h ",Date[][[5]],"mn ",Date[][[6]],"s\n  List of commands executed\n  ----------  *)\n"
    ];

    WriteString[ traceFile, "(* ++++ Loading... *)\n" ];
    WriteString[ traceFile, "load[ ", file, " mute -> True ];\n" ];

    If[ dbg, ashow[] ];
    If[ vrb, Print[ "----  File loaded ..." ] ];

    If[ Length[$library] > 1, 
      If[ vrb, Print[ "++++  Inlining ..." ] ];
      Check[ 
        WriteString[ traceFile, "(* ++++  Inlining ... *)\n" ];
        WriteString[ traceFile, 
          "inlineAll[]; removeIdEqus[]; normalize[]; simplifySystem[], \n" 
        ];
        inlineAll[]; removeIdEqus[]; normalize[]; simplifySystem[], 
        syn::errorInlining = "error while inlining file. syn aborted...";
        asave[ dirSyn<>getSystemName[]<>"WrongInlinded.alpha" ];
        Close[ traceFile ];
        Throw[ Message[ syn::errorInlining ] ]
      ];

      ashow[];

      If[ vrb, Print[ "----  File inlined ..." ] ];
      tempName = getSystemName[]<>"Inlined.alpha";
      asave[ dirSyn<>getSystemName[]<>"Inlined.alpha" ];
      (* This is a trick to make sure that only the main system is in the library *)
      load[ dirSyn<>getSystemName[]<>"Inlined.alpha" ];
      WriteString[ traceFile, 
        "asave[ "<>tempName<>" ];\nload[ "<>tempName<>" ];\n" 
      ];
    ];

    If[ vrb, Print[ "++++  Analyzing ..." ] ];

    WriteString[ traceFile, "(* ++++  Analyzing ... *)\n" ];
    WriteString[ traceFile, "analyze[ mute -> True ]\n" ];
    Check[ resAnalyze = analyze[ mute -> True],
      syn::errorAnalyze = "error while analyzing file. syn aborted...";
      asave[ dirSyn<>getSystemName[]<>"WrongAnalyzed.alpha" ];
      WriteString[ traceFile, syn::errorAnalyze ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorAnalyze ] ]
    ];

    If[ !resAnalyze, 
      syn::errorAnalyze = "error while analyzing file. syn aborted...";
      asave[ dirSyn<>getSystemName[]<>"WrongAnalyzed.alpha" ];
      WriteString[ traceFile, "++++  error while analyzing file ..." ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorAnalyze] ]
    ];

    If[ vrb, Print[ "----  Analysis successful ..." ] ];

    If[ vrb, Print[ "++++  Scheduling ... \n" ] ];
    WriteString[ traceFile, "(* ++++  Scheduling ... *)\n" ];
    (* Getting options of the scheduler *)
    optsScheduler = optionsOfScheduler/.{opts}/.Options[ syn ];

    (* Getting options of appSched *)
    optsAppSched = optionsOfAppSched/.{opts}/.Options[ syn ];

    tempName = If[ optsScheduler === {}, "", 
      StringDrop[
        StringDrop[
          Apply[ StringJoin, Map[ ToString, {optsScheduler} ] ],
          -1
        ],
          1
      ]
    ];

    Which[ 
      optScd === farkas
    , 
      WriteString[ traceFile, 
        "schedule[ "<>tempName<>" scheduleType -> sameLinearPart, mute ->True ]\n" ];
      Check[ schedule[ Apply[Sequence,optsScheduler], scheduleType -> sameLinearPart, 
        mute->True ],
        syn::errorSchedule = "error while scheduling file using schedule. syn aborted...";
        asave[ dirSyn<>getSystemName[]<>"WrongScheduled.alpha" ];
        WriteString[ traceFile, syn::errorSchedule ];
        Close[ traceFile ];
        Throw[ Message[ syn::errorSchedule ] ]
      ]
    ,
      optScd === vertex
    ,
      WriteString[ traceFile, "scd[ "<>tempName<>" ]\n" ];
      Check[ scd[ Apply[Sequence, optsScheduler] ],
        syn::errorSchedule = "error while scheduling file using scd. syn aborted...";
        asave[ dirSyn<>getSystemName[]<>"WrongScheduled.alpha" ];
        WriteString[ traceFile, syn::errorSchedule ];
        Close[ traceFile ];
        Throw[ Message[ syn::errorSchedule ] ]
      ]
    ,
      True
    ,
      syn::unknownScheduleType = "unknown schedule type. syn aborted...";
      asave[ dirSyn<>getSystemName[]<>"WrongScheduled.alpha" ];
      WriteString[ traceFile, syn::unknownScheduleType ];
      Close[ traceFile ];
      Throw[ Message[ syn::unknownScheduleType ] ]
    ];

    If[ vrb, Print[ "----  File scheduled..." ] ];

    If[ vrb, Print[ "++++  Applying schedule ..." ] ];
    WriteString[ traceFile, "(* ++++ Applying schedule ... *)\n" ];

    tempName = If[ optsAppSched === {}, "", 
      ToString[ Apply[Sequence,optsAppSched] ] ];
    WriteString[ traceFile, "appSched[ "<>tempName<>" ]\n" ];
    Check[ appSched[ Apply[Sequence, optsAppSched] ],
      syn::errorAppSched = "error while applying schedule. syn aborted...";
      asave[ dirSyn<>getSystemName[]<>"WrongAppShed.alpha" ];
      WriteString[ traceFile, syn::errorAppSched ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorAppSched ] ]
    ];

    asave[ dirSyn<>getSystemName[]<>"Scheduled.alpha" ];
    (* Save schedule *) 
    Put[ $schedule, dirSyn<>getSystemName[]<>".scd" ];

    If[ vrb, Print[ "----  Schedule applied..." ] ];

    If[ pipeOpt, 
      If[ vrb, Print[ "++++  Piping variables ...\n" ] ];
      WriteString[ traceFile, "pipeVars[ mute -> True ]\n" ];
      Check[ pipeVars[ mute -> True, pipeInputOutputs->True ],
        syn::errorPipeVars = "error while piping variables. syn aborted...";
        asave[ dirSyn<>getSystemName[]<>"WrongPiped.alpha" ];
        WriteString[ traceFile, syn::errorPipeVars ];
        Close[ traceFile ];
        Throw[ Message[ syn::errorPipeVars ] ]
      ];



      If[ vrb, Print[ "----  Variables piped..." ] ];
      asave[ dirSyn<>getSystemName[]<>"Piped.alpha" ];
    ];

    If[ pSteps =!= "", 
      If[ vrb, Print[ "++++  Placement steps ..." ] ];
      WriteString[ traceFile, "(* ++++ Placement steps ... *)\n" ];
      WriteString[ traceFile, pSteps, "\n" ];
      Check[ ToExpression[ pSteps ],
        syn::errorPipeVars = "error while piping variables. syn aborted...";
        asave[ dirSyn<>getSystemName[]<>"WrongPiped.alpha" ];
        WriteString[ traceFile, syn::errorPipeVars ];
        Close[ traceFile ];
        Throw[ Message[ syn::errorPipeVars ] ]
      ];

      If[ vrb, Print[ "----  Placement done..." ] ];
      asave[ dirSyn<>getSystemName[]<>"Placed.alpha" ];
    ];

    If[ vrb, Print[ "++++  Generating Alpha0 ..." ] ];
    WriteString[ traceFile, "(* ++++ Generating Alpha0 ...*) \n" ];
    WriteString[ traceFile, "toAlpha0v2[ mute -> True, verbose -> False ]\n" ];
    Check[ 
      toAlpha0v2[ mute -> True, verbose -> False ];
      simplifySystem[alphaFormat -> Alpha0] (* ; normalize[] *)
    ,
      syn::errorAlpha0 = "error while generating Alpha0. syn aborted...";
      asave[ dirSyn<>getSystemName[]<>"WrongAppAlpha0.alpha" ];
      WriteString[ traceFile, syn::errorAlpha0 ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorAlpha0 ] ]
    ];

    If[ vrb, Print[ "----  Alpha0 generated..." ] ];
    asave[ dirSyn<>getSystemName[]<>"Alpha0.alpha" ];

    If[ vrb, Print[ "----  Writes a report..." ] ];
    report[ dirSyn<>getSystemName[], debug -> False ];

    If[ vrb, Print[ "++++  Generating AlpHard ..." ] ];
    WriteString[ traceFile, "(* ++++ Generating AlphHard ... *)\n" ];
    WriteString[ traceFile, 
      "alpha0ToAlphard[ mergeDomains -> True, verbose-> False, mute -> True ]\n" ];
    Check[ alpha0ToAlphard[ mergeDomains->True, verbose -> False, 
                            mute -> True],
      syn::errorAlphard = "error while generating Alphard. syn aborted...";
      asaveLib[ dirSyn<>getSystemName[]<>"WrongAlphard.alpha" ];
      WriteString[ traceFile, syn::errorAlphard ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorAlphard ] ]
    ];

    If[ vrb, Print[ "----  AlpHard generated..." ] ];
    asaveLib[ dirSyn<>getSystemName[]<>"Alphard.alpha" ];

    If[ vrb, Print[ "++++  Setting parameter's value ..." ] ];
    WriteString[ traceFile, "(* ++++ Setting parameter's value ... *)\n" ];
    (* Get the list of system parameters *)
    params = getSystemParameters[];
    paramsRules = parameterRules/.{opts}/.Options[syn];
    If[ Map[ First, paramsRules ] =!= params, 
      syn::errorParameters = "value of parameters not specified. Vhdl not generated. syn aborted...";
      asave[ dirSyn<>getSystemName[]<>"WrongParametersFixed.alpha" ];
      WriteString[ traceFile, syn::errorParameters ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorParameters ] ]
    ];


    Check[ 
      Do[ 
        WriteString[ traceFile, "fixParameter[ "<>ToString[ paramsRules[[i]][[1]] ]<>", "<>
		      ToString[ paramsRules[[i]][[2]] ]<>", mute->True ]\n" ];
        fixParameter[ paramsRules[[i]][[1]], paramsRules[[i]][[2]], mute->True ],
        {i,1,Length[paramsRules]} 
      ]
    ,
      syn::errorFixParameter = "error while fixing value of parameters. syn aborted...";
      WriteString[ traceFile, syn::errorFixParameter ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorFixParameters ] ]
    ];

    If[ vrb, Print[ "----  Parameter's value was set..." ] ];
    asaveLib[ dirSyn<>getSystemName[]<>"ParametersFixed.alpha" ];

    If[ vrb, Print[ "++++  Generating Vhdl ..." ] ];
    WriteString[ traceFile, "(* ++++ Generating Vhdl ... *)\n" ];
    WriteString[ traceFile, "a2v[ vhdlDir->", ToString[getSystemName[]], 
      "SYN/VHDL, mute->True, verbose->False, 
      vhdlPatterns -> False ];\n" ];
    Check[ a2v[ vhdlDir->getSystemName[]<>"SYN/VHDL", mute->True, verbose->False, 
      vhdlPatterns -> False ],
      syn::errorVhdl = "error while generating Vhdl. syn aborted...";
      WriteString[ traceFile, syn::errorVhdl ];
      Close[ traceFile ];
      Throw[ Message[ syn::errorVhdl ] ]
    ];

    If[ dbg||True, Print["101010101010 --- Modify delete components "] ];
    Module[ {fileToDelete},
       fileToDelete = FileNames[ "*.component", getSystemName[]<>"SYN/VHDL" ] ;
       DeleteFile[ fileToDelete ]
    ];

    eTime = TimeUsed[];

    If[ vrb, Print[ "----  Vhdl was generated in Directory "<>getSystemName[]<>"SYN/VHDL" ] ];
    Print["----  Congratulations, you made it ! "];
    Print["----  Total time: ", eTime - bTime, " seconds"];
    WriteString[ traceFile, "(*\n----  Vhdl was generated in Directory "<>getSystemName[]<>"SYN/VHDL",
		 "\n----  Congratulations, you made it ! \n", 
		 "----  Total time: ", eTime - bTime, " seconds\n *)\n" ];
    Close[ traceFile ];

  ]
];
syn::params = "wrong parameters";
syn[___] := Message[syn::params];
	
End[];
EndPackage[];

