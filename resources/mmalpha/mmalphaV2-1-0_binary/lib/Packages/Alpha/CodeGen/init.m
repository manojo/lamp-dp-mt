(* file: $MMALPHA/lib/Package/Alpha/CodeGen/init.m
   AUTHOR : Fabien QuillerÅÈ
   CONTACT : http://www.irisa.fr/cosi/ALPHA
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


        $Author: quinton $
        $Date: 2008/12/29 18:03:24 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/CodeGen/init.m,v $
        $Revision: 1.2 $
        $Log: init.m,v $
        Revision 1.2  2008/12/29 18:03:24  quinton
        Replaced Cut.m by CutMMA.m

        Revision 1.1  2005/03/11 16:41:33  trisset
        added codeGen to V2

        Revision 1.32  2004/06/30 15:00:58  quinton
        Added the definition of the idiv operator...

        Revision 1.31  2004/06/09 16:02:00  quinton
        Minor modifications.

        Revision 1.30  2004/04/26 08:34:17  risset
        added system File before patrice visit

        Revision 1.29  2003/04/15 15:06:27  risset
        commit after Axiocom week

        Revision 1.28  2003/03/31 14:54:52  risset
        slight change before adding the debugC option

        Revision 1.27  2003/01/07 17:34:34  quinton
        Minor correction

        Revision 1.26  2002/10/21 15:55:48  quinton
        Some modifications to cover multidimensional schedules. I still have some
        doubt regarding one part of this version, concerning the function infGen,
        when the option AlreadySchedule is set.

        Revision 1.25  2002/10/16 12:21:58  risset
        small changes after the big post-samos debugging phase

        Revision 1.24  2002/09/12 14:47:26  risset
        commit after patrice update and correction of Pipecontrol

        Revision 1.23  2002/09/10 15:58:35  quinton
        Merge of my version and that of Tanguy. Not sure that everything works as
        expected.

        Revision 1.22  2002/09/04 11:10:00  risset
        last modifs from tang

        Revision 1.21  2002/08/28 11:39:03  risset
        fewchanges for debugging

        Revision 1.20  2002/05/28 14:31:08  quinton
        Editing corrections related to modifications to cGen. Now, cGen can be called
        without giving $result and $schedule in the arguments. Moreover, if no schedule
        has been calculated, cGen complains.

        Revision 1.19  2002/03/29 14:12:53  risset
        Options.m

        Revision 1.18  2002/03/01 10:40:18  risset
        improved the stimuli options, corrected ludovic s bug

        Revision 1.17  2002/01/18 14:04:58  risset
        corrected a bug in INorm and rewrite in imperative form fabien
        functionnal code.... (no comment)

        Revision 1.16  2002/01/17 10:29:50  risset
        modify the Pipeline.m package for pipall with boundary

        Revision 1.15  2002/01/15 10:37:50  risset
        corrected the compile file copy of cGen

        Revision 1.14  2002/01/15 10:24:06  risset
        corrected the noPrint Options

        Revision 1.13  2001/12/13 08:50:24  risset
        added the BitOperateur.m

        Revision 1.12  2001/11/14 10:24:58  quinton
        Correction for scalars was incorporated, and a new matlab option has been
        added to allow code generator to produce code which is executable under
        Matlab..

        Revision 1.11  2001/08/20 09:54:35  risset
        added the <> operator to cGen

        Revision 1.10  2001/06/21 16:05:59  risset
        new codeGen from Induraj

        Revision 1.8  2001/02/02 10:40:38  quillere
        Now also considers output aliases for loop variables declaration,
        Bug was : with a system with only ouput variables, t variables were
        not declared.
        Added the domain of aliases to the alias structure,
        thus also changed mkAlias prototype (added the unused d parameter).

        Revision 1.7  2001/02/01 16:24:54  quillere
        Added substitution in output aliases for value assigned parameters.
        Moved the ouput file closing instruction to the correct place
        (a failure during code generation left ouput file opened)

        Revision 1.6  2001/01/15 09:02:03  risset
        mise a jour

        Revision 1.5  1999/06/02 09:20:56  quillere
        added interactive code generator

        Revision 1.4  1999/05/28 14:53:24  quillere
        added CVS header and GNU info

*)

BeginPackage["Alpha`CodeGen`"];

Unprotect[cGen];
Unprotect[userInterface];
Unprotect[userMatlab];
Unprotect[dduserInterface];
Unprotect[ddcGen];
Protect[alias];
userInterface::usage = 
"userInterface[sys:_system,pVal:_List] builds an interactive interface
for system sys";

userMatlab::usage = 
"userMatlab[sys:_system,pVal:_List] build an Matlab interface for
system sys";

dduserInterface::usage = 
"dduserInterface[sys:_system,pVal:_List] build an interactive
interface for system sys";

cGen::usage = 
"cGen[sys, sch, f, pVal, opts]  generates  C-code  for  system   sys  with
schedule sch into file f. Parameters need to be fixed by the list of rules
pVal, e.g. {\"N\"->10, \"M\"->8},  with options opts.  Any  free (i.e. not 
fixed  by a rule) parameter becomes a integer parameter of the generated C 
function (does not work). cGen[file, pVal] does the same for $result   and 
$schedule. If $schedule is absent cGen shoud generate unscheduled,  demand 
driven code... but it does not... cGen returns a boolean value.";

infGen::usage =
"infGen[sys, schedule, options] is used to perform the iNormalisation
without code generation (should be followed by iNormCGen). Use this
function for debug, to avoid re-doing the iNormalisation that is very
time consuming. infGen[options] does as infGen on $result and $schedule.
To use infGen, run the sequence var = infGen[opts] followed by
iNormCGen[ var, ... ] with the same parameters as in cGen.";

iNormCGen::usage = 
"iNormCGen[sys, file, pVal, options] does cGen of an i normalized program. 
This is for debug use. The iNormalisation process is time consuming (should be used qfter infGen[])";

ddcGen::usage = 
"ddcGen[sys,file,pVal,options] generates demand driven c code. 
WARNING, this function is bugged, please use cGen with a schedule instead ";

internalFormat::usage = 
"internalFormat: option (boolean) for cGen. If True, cGen does not 
generate a file but the internal AST of the c-Code";

mkPType::usage="";
mkContext::usage="";
mkAlias::usage="";
pre::usage="";

(* noSched::usage = "option of cGen to generate demand driven code"; *)
Begin["`Private`"];

Needs["Fail`"];
Needs["Alpha`Domlib`"];
Needs["Alpha`Semantics`"];
Needs["Alpha`"];
Needs["Alpha`Tables`"];
Needs["Alpha`Matrix`"];
Needs["Alpha`Normalization`"];
Needs["Alpha`Substitution`"];
Needs["Alpha`CutMMA`"];
Needs["Alpha`Options`"];
Needs["Alpha`ScheduleTools`"];
Needs["Alpha`INorm`"];
Needs["Alpha`CodeGen`Loops`"];
Needs["Alpha`CodeGen`Restrict`"];
Needs["Alpha`CodeGen`Domains`"];
Needs["Alpha`CodeGen`Output`"];

(* === *)

Clear[cGen];

cGen::wrongArg = "`1`";
cGen::noResult = "No default system in $result.";
cGen::noSchedule = "No default schedule in $schedule.";
cGen::checked = "aborted because of a previous error in `1`.";
cGen::nofile = "Cannot write `1`.";
cGen::option = "Unexpected option : `1`.";
cGen::optdisabled = 
"Option noSched->True is disabled, because program is bugged...";

Options[cGen] = 

{verbose->True, debug->False, rewrite->True, interactive->True,
 internalFormat->False, (* noSched->False, *) noPrint->False, matlab->False,
 bitTrue->False, alreadySchedule->False, stimuli->False,include->False};

cGen[
 file:_String,
 pVal:{(_String->_)...},
 options:___Rule] :=
(* Arguments: a file name, the values of the parameters, and options only.
  $result assumed, and $schedule assumed also *)
Catch[
  Module[{dbg, resOK, schOk, optnoSched, alrs},
    dbg = debug/.{options}/.Options[ cGen ];
    optDebugC= debugC /. {options} /. Options[ cGen ];	 

    If[ dbg, Print["Calling cGen form 1"] ];

    (* Check that $result is OK *)
    resOk = MatchQ[$result, system[_,_,_,_,_,_]];

    (* Check that $schedule is OK *)
    schOk = MatchQ[$schedule, scheduleResult[_,_,_]];

    (* Compute noSched option *)
    (* FIXIT *)
    optnoSched = False; (* noSched/.{options}/.Options[ cGen ]; *)

    If[ optnoSched, Throw[ Message[cGen::optdisabled ];False ] ];

    alrs = alreadySchedule/.{options}/.Options[ cGen ];

    If[ dbg, Print["resOK, schOK, optnoSched, alrs : ", resOk, schOk, optnoSched, alrs ] ];
	 
    Which[
      (* If $result is not OK, complain *)
      !resOk
    , 
      Throw[ Message[cGen::noResult];False ]

    , 
      (* If already scheduled run it *)
      (* FIXIT: should be in a check *)
      alrs
    ,
        cGen::alrsimposs = "the option alreadyScheduled is currently disabled";
        Throw[ Message[ cGen::alrsimposs ] ];
        cGen[splitCaseUnion[$result], scheduleResult[], file, pVal, options],

      (* If not, check schedule *)
      schOk && !optnoSched,
        cGen[ splitCaseUnion[$result], $schedule, file, pVal, options],

      !schOk || optnoSched,
      (* 
         ddcGen[$result, file, pVal, options]
      *)
      Throw[ Message[ cGen::noSchedule ];False ],

      True , Throw[ Message[cGen::noSchedule];False ]
    ]
  ] (* Module *)
];
cGen::notSchedule = "Sorry the program is not already scheduled " 
cGen::noOrder = "Sorry cannot reorder equation for valid code "

(* Second form: system, file, parameter values, options *)
cGen[
 sys1:_system,
 file:_String,
 pVal:{(_String->_)...},
 options:___Rule] :=
Catch[
  Module[{dbg},
    dbg = debug/.{options}/.Options[ cGen ];
    optDebugC= debugC /. {options} /. Options[ cGen ];	 
    optVerbose = verbose /. {options} /. Options[cGen];
    optAlreadySchedule = alreadySchedule /. {options} /. Options[ infGen ];
	    
    If[ dbg, Print["Calling cGen form 2"] ];
    If[optAlreadySchedule,
      If[ dbg || optVerbose, Print["Checking equation order ..."] ];
        permut = equationOrderQ[sys1,checkSched -> False,options];
        If[ dbg, Print["Permutation: ",permut] ];
        If[ permut===False,cGen::noOrder;Throw[False],
        If[ MatchQ[permut,List[___Integer]],
        If[ dbg|| optVerbose, 
          Print["re-ordering equations ..."] 
        ];
      newSys=normalize[reorderEquations[sys1, permut,options]],

      (* permut===True, no permutation *)
      newSys=normalize[sys1]]];
      schedSys=identitySchedule[newSys,1,options,verbose->False];
      cGen[newSys, schedSys,file, pVal, options]
    ,
      If[ MatchQ[$schedule, scheduleResult[_,_,_]],
        cGen[splitCaseUnion[$result],$schedule, file, pVal, options],  
        (* forgot the alradySchedule Function *)
        Message[cGen::noSchedule ];
        Throw[False]
      ]
      (* ddcGen[sys1, file, pVal, options]*)
    ]
  ]
];

(* Third form: system, schedule, file, parameter values, options *)
cGen[
 sys1:_system,
 sch:_scheduleResult,
 file:_String,
 pVal:{(_String->_)...},
 options:___Rule] :=
 Module[{dbg},
   dbg = debug/.{options}/.Options[ cGen ];
   optDebugC= debugC /. {options} /. Options[ cGen ];	 
   If[ dbg, Print["Calling cGen form 3"] ];
   cGen[sys1, chkFail[ convertSchedule[sch] ], file, pVal, options]
 ];
 
(* Form 4: system, schedule, file, parameters, options *)
cGen[
 sys1:_system,
 sch:_List,
 file:_String,
 pVal:{(_String->_)...},
 options:___Rule] :=
Catch[
  Module[{dbg},
    dbg = debug/.{options}/.Options[ cGen ];
    optDebugC= debugC /. {options} /. Options[ cGen ];	 
    If[ dbg, Print["Calling cGen form 4"] ];
    sys = Check[ infGen[sys1, sch, options], Throw[ Null ] ];
    iNormCGen[ sys, file, pVal, options ]
  ]
];

Clear[iNormCGen];

iNormCGen[
 sys1:_system,
 file:_String,
 pVal:{(_String->_)...},
 options:___Rule] := 
Catch[
  Module[{dbg, info, optVerbose, optInternalFormat, s,
    optInteractive, optBitTrue, optStimuli ,
    optMatlab, date, v, f, sys, rew, stimFiles,tempFile},

    dbg = debug/.{options}/.Options[ cGen ];
    optDebugC= debugC /. {options} /. Options[ cGen ];	 
    optVerbose = verbose /. {options} /. Options[cGen];
    optInternalFormat = internalFormat /. {options} /. Options[ cGen ];
    optInteractive = interactive /. {options} /. Options[ cGen ];
    optMatlab = matlab /. {options} /. Options[ cGen ];
    optBitTrue = bitTrue /. {options} /. Options[ cGen ];
    optStimuli = stimuli /. {options} /. Options[ cGen ];
    rew = rewrite /. {options} /. Options[ cGen ];

    If[ dbg, Print["Calling iNormCGen form 3"] ];
    info = FileInformation[file];
    date = Date[];

    (* Check that file does not exist, unless option rewrite
       is set, or option internalFormat ?? *)
    If[ info =!= {} && ! rew && !optInternalFormat,
      cGen::file = "file `1` exists (consider using rewrite option).";
      Message[cGen::file, file]; Throw[ $Failed ]
    ];

    (* Open file, only if option internal format is not set *)
    Check[ 
      s = If[ !optInternalFormat, OpenWrite[file] ],
      Message[cGen::nofile, file]; Throw[ $Failed ]
    ];

    (* This Catch is provided to handle an exception inside 
     the code generation, as we need to close the write file
     s if something wrong happens *)
    Catch[

    code = 
    Module[{tf, verb, vars, pDim, idx, param, ctx},

      (* Create a function for traces *)
      If[ optVerbose||dbg,
        verb[a___] := Print[a],
        verb[a___] := Null
      ];

      verb["Generating code for system ", sys1[[1]]];

      sys = sys1;
      pDim = sys[[2,1]];

      (* Generate variables *)
      (* Get list of declarations *)
      v = List@@Take[sys, {3,5}]; 

      f = 
        Function[{d},
          If[MatchQ[d, _decl],
            (* The call here was changed to transmit all options *)
            Apply[ mkDomain, Join[List@@d,{pDim, pVal, options}] ],
            {Apply[mkAlias, Join[d, alias[pDim, pVal]]], "", "",
                 left["#undef ", d[[1]]]}
          ]
        ];

      If[ dbg, Print["Applying mkdomain to: ", v] ];

      vars = 
        Map[
          Map[ f, #]&,
          v
        ];

      If[ dbg, Print["Applying mkdomain, done..."] ];

      idx = Apply[ Union, Map[ Drop[ Part[#, 3, 2],-pDim]&,
				  Join@@Take[sys,{4,5}]]
      ];

      param = Select[sys[[2,2]]/.pVal, StringQ];

      ctx = mkContext[sys];

      vseq[
        hseq["/* Generated: ", date[[3]], "/", 
             date[[2]], "/", date[[1]],
             " at ", date[[4]], ":", date[[5]], ":", date[[5]], 
             " */"
        ],

        preamble[options],

        block[
          hseq["void ", sys[[1]], "(",
            list@@
            (* Call to mkType changed to send options *)
            Join[
              Map[
                StringJoin[mkType[#[[2]],options],"* _", #[[1]]]&,
                Join@@Take[sys, {3,4}]
              ],
              Map[
                StringJoin["int ", #]&, 
                param
              ]
            ],
            ")"
          ], (* hseq *)

          vseq[
            hseq["/* Aliases for all variables */"],
            Map[Part[#,1]&, vseq@@Join@@vars],
            hseq[" "],
            hseq["/* Allocate memory for local variables */"],
            Map[Part[#,2]&, vseq@@vars[[3]]],
            hseq[" "],
            hseq["/* Loop variables */"],
            vseq@@Map[StringJoin["int ", #, ";"]&, idx],
            hseq[" "],
            hseq["/* A few loops */"],
            If[ dbg, Print["A few loops..."] ];
            cGen[ctx, sys[[6]], 1, pDim, pVal, options],
            hseq[" "],
            hseq["/* Clean up local variables' memory */"],
            hseq["/* Commented out because it was crashing at run time*/"],
            hseq["/*"],
            Map[Part[#,3]&, vseq@@vars[[3]]],
            hseq["*/"],
            hseq["/* And finally undef aliases */"],
            Map[Part[#,4]&, vseq@@Join@@vars]
          ]
        ], (* Block *)

        hseq[" "],

        If[optInteractive,
           userInterface[sys, pVal,options],
           If[optMatlab,
             userMatlab[sys, pVal,options],
             hseq[]
           ]
        ] (* If *)
      ] (* vseq *)

    ]; (* Module of code = *)

    (* Here, the C code is generated only if the option 
      internalFormat is not set, which is the default. *)
    If[!optInternalFormat,
      verb["Writing file ", file, "..."];
      writeCcode[s,code];
    ];

    (* The compiled file is copied in the current directory, if 
      it is not already here. It can be used to compile on Cygwin
      or Unix the C file, with the bitTrue option. 
    *)
    If[ 
      (FileInformation["compile"]==={})&& optBitTrue,
      Print["Copying file compile..."];
      CopyFile[Environment["MMALPHA"]<>
      "/sources/BitOperators/compile","compile"]
    ]; (* If *)

    ]; (* This is the end of the Catch *)
    If[ optInternalFormat, code, Close[s];True ]

  ] (* Module *)

]; (* Catch *)

iNormCGen[a___] :=
Module[{},
  Message[iNormCGen::params]; Print[Map[Head,{a}]];
  False
];


(* Form 5: system, parameter values, and options *)
cGen[
  sys:_system,
  pVal:{(_String->_)...},
  options:___Rule] :=
 Module[{dbg},
   dbg = debug/.{options}/.Options[ cGen ];
   optDebugC= debugC /. {options} /. Options[ cGen ];	 
    dbg = True; 
   If[ dbg, Print["Calling cGen form 5"] ];

  With[{ctx = mkContext[sys],
    pDim = sys[[2,1]]},
    Check[
      Map[cGen[ctx, #, 1, pDim, pVal, options]&, vseq@@sys[[6]]],
      Message[cGen::checked, "let"];
      Throw[False]
    ]
  ]
 ];

(* Form 6: context, code of equations, 
   level, parameter dimensions, parameter values
   and options 
*)
cGen[
 ctx:List[__List],
 code:_let,
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
Module[{dbg},
  dbg = debug/.{options}/.Options[ cGen ];
  optDebugC= debugC /. {options} /. Options[ cGen ];	 
  If[ dbg, Print["Calling cGen form 6"] ];

  Check[
    Map[cGen[ctx, #, lev, pDim, pVal, options]&, vseq@@code],
    Message[cGen::checked, "let"];
    Throw[False]
  ]
];

(* Form 7: context, code is a loop, level, dimension of parameters, 
 parameter values, and options *)
cGen[
 ctx:List[__List],
 code:loop[d_domain, c_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
Module[{dbg, res,cCode},

  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling cGen form 7"] ];
  If[ dbg, Print["code :", code] ];

  Check[
    If[d[[1]]>=lev+pDim,
       Catch[
         res = cGen[ctx, c, lev+1, pDim, pVal, options];
         If[ dbg, Print["**************Calling mkLoop"]];
         res = mkLoop[d, lev, pDim, pVal, res ]
       ],
       res = cGen[ctx, c, lev+1, pDim, pVal, options]; 
       res
    ],       
    Print["Erreur...."];
    ashow[d];
    Print[lev];
    Message[cGen::checked, "loop"];
    Throw[$Failed]
  ];
  res
];

(* Form 8: context, code: restriction, level, parameter dimensions, 
 parameter values, options *)
cGen[
 ctx:List[__List],
 code:restrict[d_domain, c_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
Module[{dbg},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling cGen form 8"] ];

  Check[
    Catch[mkRestrict[d, pDim, pVal, cGen[ctx, c, lev, pDim, pVal, options]]],
    Message[cGen::checked, "restrict"];
    Throw[False]
  ]
];
  
(* Form 9: context, code: equation, level, parameter dimensions, 
 parameter values, options *)
cGen[
 ctx:List[__List],
 code:equation[v:_String, c_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
Module[{dbg, context},
  dbg = debug/.{options}/.Options[ cGen ];
  optDebugC= debugC /. {options} /. Options[ cGen ];	 
 
  If[ dbg, Print["Calling cGen form 9"] ];

  context = Select[ctx, Equal[First[#], v]&];
  idx = context[[1,2]];
  type = context[[1,3]];
  If[ dbg, Print[ context ] ];
  If[ dbg, Print[ idx ] ];
  If[ dbg, Print[ type ] ];
  Check[ 
    out = 
      hseq[v, "(", list@@Drop[idx, -pDim], ") = ",
        cGen[ctx, idx, c, lev, pDim, pVal, options], ";"
      ],
      Message[cGen::checked, "equation"]; Throw[$Failed]
    ];

  If[Length[context] =!= 1, Message[cGen::noCtx]; Throw[$Failed]];

  If[ dbg, Print[ 9000 ] ];
  If[debug /. {options} /. Options[cGen],

    sidx = Apply[list, Drop[idx, -pDim]];
    vseq[out,
      hseq["printf(\"", 
        v, 
        "(", 
        sidx/.Rule[s_String, "%i"],
        ") = ",
        mkPType[type], 
        "\\n\", ",
        sidx, 
        ", ", v, "(", sidx, ")",
        ");"
      ]
    ]
  ];

  out
]; (* Module *)
	 
(* Form 10: context, index, code: affine, level, parameter dims,
     etc. *)
cGen[
 ctx:List[__List],
 idx:List[__String],
 code:affine[var[v:_String], m:_matrix],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
Module[{dbg},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling cGen form 10"] ];

  Check[
    With[{id = Join[idx /.pVal, {1}]},
	 hseq[v, "(", list@@Drop[m[[4]].id, -pDim-1], ")"]
       ],
    Message[cGen::checked, "affine"];
    Throw[False]
  ]
]; (* Module *)
  
cGen[
 ctx:List[__List],
 idx:List[__String],
 code:affine[const[v:_], m:_matrix],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
  hseq[v];
  
cGen[
 ctx:List[__List],
 idx:List[__String],
 code:binop[op:_, v1_, v2_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
  Check[
    If[prefixQ[op],
       hseq[ binOp[op], 
	   (* warning the first parenthesis is included in the binop[op]
	    for prefix operators *)
	    cGen[ctx, idx, v1, lev, pDim, pVal, options], ", ",
	    cGen[ctx, idx, v2, lev, pDim, pVal, options], ")"],
       hseq["(",
	    cGen[ctx, idx, v1, lev, pDim, pVal, options], " ", binOp[op], " ",
	    cGen[ctx, idx, v2, lev, pDim, pVal, options], ")"]],
    Message[cGen::checked, "binop"];
    Throw[False]
  ];

cGen[
 ctx:List[__List],
 idx:List[__String],
 code:unop[op:_, v:_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
  hseq[unOp[op], "(", cGen[ctx, idx, v, lev, pDim, pVal, options], ")"];

(* Added by tanguy for call *)
cGen[
 ctx:List[__List],
 idx:List[__String],
 code:call[fnct:_, paramList:_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
Module[{},
       temp=  Flatten[
		      Map[{cGen[ctx, idx,  # , lev, 
				pDim, pVal, options],","} &,
			  paramList]];
       hseq[ToString[fnct], "(", 
	    Apply[hseq,
		  Drop[temp,-1 (* remove last comma *)]
	    ], (* apply hseq on the sequence *)
	    ")"]
]

cGen[
 ctx:List[__List],
 idx:List[__String],
 code:if[v1_, v2_, v3_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{(_String->_)...},
 options:___Rule] :=
  Check[
    hseq["(",
	    cGen[ctx, idx, v1, lev, pDim, pVal, options], "? ",
	    cGen[ctx, idx, v2, lev, pDim, pVal, options], ": ",
	    cGen[ctx, idx, v3, lev, pDim, pVal, options], ")"],
    Message[cGen::checked, "binop"];
    Throw[False]
];

Clear[ prefixQ ];
prefixQ[op:_] :=
  MatchQ[op,min|max|integerOp[___]|fixedPointOp[___]];

binOp[add] := "+";
binOp[and] := "&";
binOp[div] := "/";
binOp[idiv] := "/";
binOp[eq] := "==";
binOp[gt] := ">";
(* Correction by PQ, April 9, 2003 *)
(* binOp[gte] := ">="; *)
binOp[ge] := ">=";
binOp[lt] := "<";
(* Correction by PQ, April 9, 2003 *)
(* binOp[lte] := "<="; *)
binOp[le] := "<=";
binOp[mod] := "%";
binOp[mul] := "*";
binOp[ne] := "!=";
binOp[or] :=  "|";
binOp[sub] := "-";
binOp[xor] := "^";

binOp[max] := "max(";
binOp[min] := "min(";

(*   integerOp[fnct:_,sizeOp1:_,sizeOp2:_,sizeRes] *)
binOp[bitOp1:integerOp[___]]:=
     hseq["Operateur_Entier(",ToString[ bitOp1[[1]]], ",",
	 ToString[bitOp1[[2]]],",",ToString[bitOp1[[3]]], ",", 
	 ToString[bitOp1[[4]]],","];

(*   fixedPointOp[fnct:_,sizeIntOp1:_,sizeRatOp1:_,
                   sizeIntOp2,sizeRatOp2:_,sizeIntRes:_,sizeRatRes:_] *)
binOp[bitOp1:fixedPointOp[___]]:=
     hseq["Operateur_VirguleFixe(",ToString[ bitOp1[[1]]], ",",
	 ToString[bitOp1[[2]]],",",ToString[bitOp1[[3]]], ",", 
	 ToString[bitOp1[[4]]],",",ToString[bitOp1[[5]]], ",", 
	 ToString[bitOp1[[6]]],",",ToString[bitOp1[[7]]], ","];


unOp[sqrt] = "sqrt";
unOp[neg] = "-";
unOp[abs] = "abs";
unOp[not] = "!";

cGen[a___] :=
Module[{},
  Message[cGen::wrongArg, Map[Head,{a}]];
  False
];

(* === *)

Unprotect[mkAlias];
Clear[mkAlias];

 mkAlias::wrongArg = "`1`";

mkAlias[
  al:_String,
  def:_String,
  pDim:_Integer,
  pVal:{(_String->_)...}] :=
  left["#define ", al, " ",def];

mkAlias[
  al:_String,
  affine[var[def:_String], m:_matrix],
  d:_domain,
  pDim:_Integer,
  pVal:{(_String->_)...}] :=
    With[{idx = Drop[m[[3]], -pDim],
	  af = Drop[m[[4]].Append[m[[3]]/.pVal, 1], -1-pDim]},
	 left["#define ", al, "(", list@@idx, ") ", def, "(", list@@af, ")"]
       ];

mkAlias[a___] :=
  Module[{},
	 Message[mkAlias::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[mkAlias];

(* === *)

Unprotect[mkContext];
Clear[mkContext];

 mkContext::wrongArg = "`1`";

 mkContext::noLink = "alias `1` -> `2` but no declaration for `2`";

mkContext[
  sys:_system] :=
  With[{vars = Join@@Take[sys, {3,5}]},
       Map[mkContext[vars, #]&, vars]
       ];

mkContext[
  vars:_List,
  var:_decl] :=
  List[
    var[[1]],
    var[[3,2]],
    var[[2]]
  ];

mkContext[
  vars:_List,
  var:_alias] :=
  With[{equ = Select[vars, Equal[First[#], var[[2,1,1]]]&]},
       If[Length[equ] === 1,
	  List[
	    var[[1]],
	    var[[2,2,3]],
	    mkContext[vars, equ[[1]]][[3]]
	  ],
	  Message[mkContext::noLink, var[[1]], var[[2,1,1]]];Throw[$Failed]]
       ];

mkContext[a___] :=
  Module[{},
	 Message[mkContext::wrongArg, {a}];
	 Print[a];
	 Throw[$Failed]
       ];

Protect[mkContext];

(* === *)

Unprotect[mkPType];
Clear[mkPType];

 mkPType::wrongArg = "`1`";

(* should be used for interface generator
  mkPType[integer[_,8]] :="%c" 
  mkPType[integer[_,16]] :="%hd" *)

mkPType[integer[___]] = "%i";
mkPType[integer] = "%i";

(* If real are float mkPType[real] = "%g"; *)
(* If real are double I don't know the format. FIXIT *)

mkPType[real] = "%f";
mkPType[real[___]] = "%g";
mkPType[boolean] = "%i";

mkPType[a___] := 
  Module[{},
	 Message[mkPType::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[mkPType];

(* === *)

Unprotect[preamble];
Clear[preamble];
preamble[options:___Rule] :=
  Module[{optMatlab, optBitTrue,optInclude, matlabInclude,otherInclude},
    optMatlab=matlab/.{options}/.Options[cGen];
    optBitTrue=bitTrue/.{options}/.Options[cGen];
    optInclude=include/.{options}/.Options[cGen];
    If[MatchQ[optInclude,_String],optInclude={optInclude}];

    matlabInclude=If[optMatlab,left["#include \"mex.h\" "]," "];
    bitTrueInclude=If[optBitTrue,left["#include \"bitTrueOps.h\" "]," "];
    otherInclude= If[MatchQ[optInclude,{___String}],
                    Apply[vseq,
                         Map[left["#include \""<>#<>"\" "] &,optInclude]],
                    (* else no other include *)" "];

    vseq[left["/* Code generated by MMAlpha code generator ",
              "version 0.2.6 (02/02/2001 11:35) FQ */"],
         left[""],
         If[!optBitTrue,left["#include <stdlib.h>"],left[""]],
         left["#include <stdio.h>"],
         left["#include <math.h>"],
         left["#include <assert.h>"],
         matlabInclude,
         bitTrueInclude,
         otherInclude,
         left[""],
         left["#define min(a,b) ((a) > (b) ? (b) : (a))"],
         left["#define max(a,b) ((a) > (b) ? (a) : (b))"],
         left["#define power(a, i) ((a)^(i))"],
         (*left["int power(int a, int i) { return ((i>1) ? a*power(a,i-1) : a); }"],*)
         left["static int rfloor (int a, int b) {"],
         left["  assert (b>0);"],
         left["  return ((a<0) ? ((a+1)/b)-1 : a/b);"],
         left["}"],		
         left["static int rceil (int a, int b) {"],
         left["  assert (b>0);"],
         left["  return ((a>0) ?  ((a-1)/b)+1 : a/b);"],
         left["}"],
         left[""]
    ]
];

Protect[preamble];
	
(* === *)
Unprotect[preamble2];
Clear[preamble2]
preamble2 = vseq[left["#define True 1"],
		 left["#define False 0"],
		 left[""],
                 left["typedef struct {"],
	         left["    int value;"],
		 left["    int computed; } intvar;"],

		 left["typedef struct {"],
	         left["    float value;"],
		 left["    int computed; } floatvar;"],
		 left[""]
              ];

Protect[preamble2];

(* === *)
Unprotect[infGen];

Clear[infGen];
infGen::wrongArg = "`1`";
infGen::schedule = "schedule is corrupted ?";
infGen::outputVarForm = 
"the form of the equation defining output var `1` is not good (should be mirror equation "

Options[infGen] = Options[cGen];

(* Call without system and schedule *)
infGen[ options:___Rule ] :=
Catch[
  chkFail[
    If[ MatchQ[$result, system[_,_,_,_,_,_]] &&
        MatchQ[$schedule, scheduleResult[_,_,_]],
      infGen[$result, $schedule]
    ]
  ]
];

(* Call with scheduleResult form of schedule *)
infGen[
 sys:_system,
 sch:_scheduleResult,
 options:___Rule] :=
  Catch[
    chkFail[
      infGen[sys, chkFail[convertSchedule[sch]], options]
    ]];

(* General form *)
infGen[
 sys1:_system,
 tf1:_List,
 options:___Rule] :=
Catch[
  Module[{ optVerbose, dbg, optAlreadySchedule, outvars, sys, tf, k,
    locvars, outputs, outdoms, outdefs, equivs, sloc, locs, tfDim },

    (* Getting options *)
    optVerbose = verbose /. {options} /. Options[infGen]; 
    dbg = debug /. {options} /. Options[ infGen ];
    optAlreadySchedule = alreadySchedule /. {options} /. Options[ infGen ];

    (* Get output variables *)
    outvars = getOutputVars[sys1]; 

    If[ dbg, Print["Starting infGen ...."] ];

    (* Dimension of timing function *)
    k = Length[tf1[[1,2]]];

    (* Dimension of timing-function *)
    (* This was added in order to cover the case of 2D timing 
       functions *)
    If[ optVerbose, Print["Dimension of time is :", k ] ];

    (* New Names for output vars *)
    outputs = Map[List[#, getNewName[sys, "out"<>#]]&,outvars];

    (* Adding Equations:  v1=outv; outv=RHS for all output v1=RHS *) 
    sys = Fold[addlocal[#1, #2[[2]], #2[[1]]]&, sys1, outputs];

    (* Save system for debug *)
    If[ dbg, 
      Print[ "System saved in file temp.alpha after adding output mirrors" ];
      asave[ sys, "temp.alpha" ];
    ];

    (* Get local variables *)
    locvars = getLocalVars[sys];

    (* Replace v1 by outv1 for all output v1 in schedule *)
    tf = ReplaceAll[ tf1, Map[Apply[Rule, #]&, outputs]];

    If[ dbg, Print["Timing function is :",  tf ] ];

    If[ optAlreadySchedule,
      (********* Sys is already scheduled ************)
      If[ dbg|| optVerbose, Print["Checking schedule ..."] ];

      If[!isScheduledQ[sys1,onlyLocalVars->True,durations->0,options],
        Throw[ Message[cGen::notSchedule]; False ];
      ];

    (* Building schedule for output vars and applying on 
        output vars *) 
    If[optVerbose||dbg,
      Print["Applying schedule to outputVars..."]
    ];

    (* Get the list of output definitions *)
    outputDefs = Map[getDefinition[sys,#] &,outputs];

    Do[ 
      If[ dbg, Print[ i ] ];

      curOutput = outputs[[i,2]];

      If[ dbg, Print["Scheduling output: ", curOutput ] ];
      curOutDef = getDefinition[sys,curOutput];

      (* The output should be of the form affine something *)
      (* FIXIT *)
      (* Maybe, we could accept something with no affine matrix ... *)
      If[ !MatchQ[ curOutDef, affine[var[_],matrix[___]]],
        Throw[ Message[infGen::outputVarForm,curOutput] ]
      ];

      (* The time function for the output var is the first 
          component of the affine fonction of the RHS of its definition *)
      If[ dbg, Print[ curOutDef ] ];

      (* There was a bug here... when the time function is multi-dimensional *)
      timeFunc = Take[curOutDef[[2,4]], k];
      If[ dbg, Print["Timing function is :",  timeFunc ] ];

      Check[
        sys = appVarSched[ sys, curOutput, timeFunc, options ],
        infGen::appvarsched = "error while calling appVarSched";
        Message[infGen::appvarsched];Throw[False]
      ]; 
      If[ dbg, Print[ sys ] ];
      ,{i,1,Length[outputs]}
    ];


    sys = simplifyAffines[ normalize[sys] ];

    If[ dbg, ashow[ sys ] ];

    , (* Else *)

      (********* Sys is NOT already scheduled, schedule is given********)
      (* Applying schedule to all vars *)
      If[ optVerbose||dbg, Print["Applying schedule..."] ];

      (* Apply schedule *)
      Check[ 
        sys = appSched[ sys, tf, options ],
        infGen::errappsched = "error while calling appSched";
        Throw[ Message[ infGen::errappsched ] ]
      ];
(*
      If[ dbg, ashow[ sys ] ]
*) 
    ];

(*
    Check[ 
      save[ sys, "tempcGen2.alpha" ],
      Throw[ sys1 ] 
    ];
*)

    If[ dbg, Print["saved in file tempcGen2.alpha"] ];

    (* Normalize system *)
    Check[
      sys = normalize[ sys ],
      infGen::normalize = "error while calling normalize";
      Throw[ Message[ infGen::normalize ] ]
    ];

    (* Simplify affine expressions *)
    Check[ 
      simplifyAffines[ sys ], 
      infGen::simplify = "error while calling simplifyAffines";
      Throw[ Message[ infGen::simplify ] ]
    ];

    outputDefs = Map[getDefinition[sys,#] &,outputs];

    (* Extract output defintions *)
    outdefs = Select[sys[[6]], MemberQ[outvars, #[[1]]]&];

    equivs = Map[inverseEquation[#, sys[[4]], sys[[5]]]&, outdefs];

    sys = ReplacePart[sys,
        Select[sys[[6]], MemberQ[locvars, #[[1]]]&],
    6];

    (* Save again in temp. *)
    asave[ sys, "temp.alpha"];
    If[ dbg, Print["saved again in file temp.alpha"] ];

    If[ dbg, Print["Calling iNorm..."] ];
    Check[ 
      sys = iNorm[sys, k, verbose -> optVerbose, debug -> dbg],
      cGen::erriNorm = "error while calling iNorm"; 
      Message[ cGen::erriNorm ];
      Throw[ sys1 ]
    ];

    If[ dbg, Print["... done"] ];
    locs = Complement[locvars, Last/@outputs]; 
    If[ dbg, 
      Print[ locs ];
      Print[ sys[[5]] ];
      Print[ equivs ]
    ];

    sys = ReplacePart[sys,
      Join[ Select[ sys[[5]], MemberQ[locs, First[#]]& ], equivs ], 5
    ];

    If[ dbg,Print["exiting infGen ...."] ];
    sys
  ]
];

infGen[a___] :=
Module[{},
  infGen::wrongArg = "wrong arguments `1`";
  Message[infGen::wrongArg, {a}];
    Throw[$Failed]
];

Protect[infGen];

(* === *)

Unprotect[inverseEquation];
Clear[inverseEquation];

 inverseEquation::wrongArg = "`1`";
 inverseEquation::context = "could not find domain in context";
 inverseEquation::corrupted = "equation should be either a=b or a=b.mat";

inverseEquation[
  e:_equation,
  lctx:List[__decl],
  rctx:List[__decl]] :=
  Which[MatchQ[e, equation[_String, var[_String]]],
	Rule[var[e[[2,1]]], var[e[[1]]]],
	MatchQ[e, equation[_String, affine[var[_String], _matrix]]],
	Module[{out, loc, ldom, rdom, mat},
	       out = e[[1]];
	       loc = e[[2,1,1]];
	       ldom = With[{tmp = Cases[lctx, decl[out, t_, d_]->d]},
			  If[Length[tmp]=!=1,
			     Message[inverseEquation::context];Throw[$Failed],
			     First[tmp]]];
	       rdom = With[{tmp = Cases[rctx, decl[loc, t_, d_]->d]},
			  If[Length[tmp]=!=1,
			     Message[inverseEquation::context];Throw[$Failed],
			     First[tmp]]];
	       mat = ReplacePart[inverseInContext[e[[2,2]], ldom], rdom[[2]], 3];
	       alias[loc, affine[var[out], mat], rdom]
	     ],
	True,
	Message[inverseEquation::corrupted]; Throw[$Failed]
      ];

inverseEquation[a___] :=
  Module[{},
	 Message[inverseEquation::wrongArg, {a}];
	 Throw[$Failed]
       ];

Protect[inverseEquation];

(* === *)

Clear[userInterface];

userInterface::wrongArg = "`1`";

userInterface[
 sys:_system,
 pVal:{(_String->_)...},
 options:___Rule] := 
With[{pDim = sys[[2,1]],
	inputs = sys[[3]],
	outputs = sys[[4]],
	optNoPrint = noPrint /. {options} /. Options[ cGen ],
	optStimuli = stimuli /. {options} /. Options[ cGen ],
	param = Select[sys[[2,2]]/.pVal, StringQ]
	},

  Module[{read, write, mem},

    mem = 
      Map[Function[{dcl},
      (* Call to mkDomain changed to get the options *)
        vseq@@mkDomain[StringJoin[dcl[[1]]],
	  dcl[[2]],
          dcl[[3]],
	  pDim,
	  pVal,options]],
	vseq@@Join[sys[[3]], sys[[4]]]
      ];
	  
    (* stimuli files *) 
    stimuliFileOpen=vseq[];
    stimuliFileClose=vseq[];
	  
    Do[
      curInputVar=inputs[[i,1]];
      curCcode =
        hseq[
          " FILE   *file_",curInputVar,
          "=fopen(\"stim",
          curInputVar,".txt\",\"w\"); "];

      stimuliFileOpen=Append[ stimuliFileOpen,curCcode];
      stimuliFileClose=Append[ stimuliFileClose,
				   hseq["fclose(file_",curInputVar,");"]];
      ,{i,1,Length[inputs]}
    ];
	  
    Do[
      curOutputVar=outputs[[i,1]];
      curCcode = 
        hseq[
          " FILE   *file_",curOutputVar,
          "=fopen(\"stim",
          curOutputVar,".txt\",\"w\"); "];

      stimuliFileOpen = Append[ stimuliFileOpen,curCcode];
      stimuliFileClose = 
        Append[ stimuliFileClose,
          hseq["fclose(file_",curOutputVar,");"]
      ];
      ,{i,1,Length[outputs]}
    ];
	  
    read =
      Map[Function[{dcl},
        With[{sidx = Apply[list,Drop[dcl[[3,2]], -pDim]]},

          If[
            dcl[[3,1]]>pDim,
	    mkLoop[dcl[[3]], 1, pDim, pVal,
              vseq[
                If[!optNoPrint,
                  hseq["fprintf(stdout, \"",
                    dcl[[1]], "[", ReplaceAll[sidx, Rule[s_String, "%i"]],
					     "]?\", ",
					     sidx, ");"
                  ],
                  hseq[" "]
                ],
                hseq["fscanf(stdin, \"",
                  mkPType[dcl[[2]]],
                    "\", ", StringJoin["&(", dcl[[1]]],
                    "(", sidx, ")));"
                ],

                If[optStimuli,
                  vseq[
                    If[!optNoPrint,
                    hseq["fprintf(file_",dcl[[1]],",\"",
                      dcl[[1]], "[",
                      ReplaceAll[sidx,
                      Rule[s_String, "%i"]],
                      "]=\", ",
                      sidx, ");"
                    ],
                    hseq["  "]],
                    hseq["fprintf(file_",dcl[[1]],",\"", 
(* Previously 
                      (* mkPType[dcl[[2]]]*)"%.8x", *)
                      mkPType[dcl[[2]]],
                      "\\n\", ",
                      StringJoin["(", dcl[[1]]],
                      "(", sidx, ")));"
                    ]
                  ],
                  hseq[" "]
                ]
              ]
            ],
            vseq[
              If[!optNoPrint,
                hseq["fprintf(stdout, \"",
                dcl[[1]], "[]?\"); " ],
                hseq[" "]
              ],
              hseq["fscanf(stdin, \"",
                mkPType[dcl[[2]]],
                "\", ",
                StringJoin["&(", dcl[[1]]],
                "()));"
              ],
              If[optStimuli,
                If[!optNoPrint,
                  hseq["fprintf(file_",dcl[[1]],",\"",
                    dcl[[1]], "=\"); " ],
                    hseq["fprintf(file_",dcl[[1]],",\"", 
(* Previously                      (* mkPType[dcl[[2]]]*) "%.8x", *)
                      mkPType[dcl[[2]]],
                       "\\n\", ", StringJoin["(", dcl[[1]]],
                       "()));"
                    ]
                  ],
                  hseq[" "]]
				 
             ]
           ]
         ]
       ]
     ,
     vseq@@inputs
   ];

      write =
      Map[Function[{dcl},
		  With[{sidx = Apply[list,Drop[dcl[[3,2]], -pDim]]},
		      If[dcl[[3,1]]>pDim,
			mkLoop[dcl[[3]], 1, pDim, pVal,
			      vseq[
			     If[!optNoPrint,
			       hseq["fprintf(stdout, \"",
				   dcl[[1]], "[",
				   list@@Array["%i"&, Length[sidx]],
				   "]=",
				   mkPType[dcl[[2]]], "\\n\", ", sidx, ", ", 
				   dcl[[1]], "(", sidx, "));"
			       ],
			       hseq["fprintf(stdout, \"",
				   mkPType[dcl[[2]]], "\\n\", ",
				   dcl[[1]], "(", sidx, "));"]
			     ],
			     If[optStimuli,
			       If[!optNoPrint,
				      hseq["fprintf(file_",dcl[[1]],",\"",
					  dcl[[1]], "[",
					  list@@Array["%i"&, Length[sidx]],
					  "]=",
(* Previously				  (* mkPType[dcl[[2]]] *)"%.8x", "\\n\", ", sidx, ", ", *)
					  mkPType[dcl[[2]]], "\\n\", ", sidx, ", ", 
					  dcl[[1]], "(", sidx, "));"					 
				      ],
				      hseq["fprintf(file_",dcl[[1]],",\"", 
(* Previously 					  (* mkPType[dcl[[2]]] *)"%.8x", *)
					  mkPType[dcl[[2]]],
					  "\\n\", ", StringJoin["(", dcl[[1]]],
					  "(", sidx, ")));"]
			       ]
			       ,
			       hseq[" "] (* no stimuli *) 
			       ]
			      ]
			]
			,
		vseq[
		     If[!optNoPrint,
		       hseq["fprintf(stdout, \"",
			   dcl[[1]], "=",
			   mkPType[dcl[[2]]],
			   "\\n\", ", dcl[[1]], "());"],
		       hseq["fprintf(stdout, \"",
			   mkPType[dcl[[2]]],
			   "\\n\", ", dcl[[1]], "());"]
		     ],
		     If[optStimuli,
		       If[!optNoPrint,
			 hseq["fprintf(file_",dcl[[1]],",\"",
			     dcl[[1]], "=",
(* Previously			     (* mkPType[dcl[[2]]] *)"%.8x", *)
			     mkPType[dcl[[2]]],
			     "\\n\", ", dcl[[1]], "());"],
			 hseq["fprintf(file_",dcl[[1]],",\"",
(* Previously		     (* mkPType[dcl[[2]]] *)"%.8x", *)
			     mkPType[dcl[[2]]],
			     "\\n\", ", StringJoin["(", dcl[[1]]],
			     "()));"]],
		       hseq[" "]]]
		      ]
	]	  
      ] ,
	 vseq@@outputs
      ];

	block[hseq["int ", (*sys[[1]]<>"I",*) "main (void)"],
	     vseq[
		  Map[Part[#,1]&, mem],
		  Map[Part[#,2]&, mem],
		  vseq@@Map[StringJoin["int ", #, ";"]&,
			   Union@@Map[Drop[Part[#, 3, 2],-pDim]&,
				     Join[inputs, outputs]]],
		  If[optStimuli,
		    stimuliFileOpen,
		    vseq[" "]],
		  read,
		  hseq[sys[[1]], "(",
		      list@@Map[StringJoin["_", First[#]]&,
			       Join[inputs, outputs]],
		      ");"],
		  write,
		  If[optStimuli,
		    stimuliFileClose,
		    vseq[" "]],
		  (* vseq["/* commented because failled at run time ", *)
		   Map[Part[#,3]&, mem],
		   (* ,"*/" ], *)
		  Map[Part[#,4]&, mem],
		  vseq[" exit(0);"]
	     ]
	]
    ]
  ];

userInterface[a___] :=
  Module[{},
	 Message[userInterface::wrongArg, {a}];
	 Throw[$Failed]
       ];


(* === *)
(* Tanguy Nov 2001 
      userMatlab is copied from user interface to provide an interface 
      for a use of the c-code in Matlab *)
Clear[userMatlab];

userMatlab::wrongArg = "`1`";

userMatlab[
 sys:_system,
 pVal:{(_String->_)...},
 options:___Rule] := 
  With[{pDim = sys[[2,1]],
    inputs = sys[[3]],
    outputs = sys[[4]],
    param = Select[sys[[2,2]]/.pVal, StringQ]
	},
 
    Module[{read, write, mem,declareVarMatlab},
      declareVarMatlab[decl1_Alpha`decl]:=
      Module[{},
       (* Changed to tranmsit options to mkType *)
        declC1 = vseq[hseq[mkType[decl1[[2]], options]," *",decl1[[1]],";"]];
        numberOfIndices=decl1[[3,1]]-pDim;
        If[ MemberQ[sys[[4]],decl1], (* output variable *)
          If[numberOfIndices===0,
            declC1 = Append[declC1,hseq["int ",
                       StringJoin["sizeM",decl1[[1]]],"=1;"]];
            declC1 = Append[declC1,hseq["int ",
                       StringJoin["sizeN",decl1[[1]]],"=1;"]],
          (* else: 1 or 2 dim array *)
            bound1 = 
	    (* Options transmitted *)
              findBound[decl1[[1]],decl1[[2]],decl1[[3]],pDim,pVal,options];

            sizeM=bound1[[1,2]]-bound1[[1,1]]+1;
            declC1=
              Append[declC1,hseq["int ",StringJoin["sizeM",decl1[[1]]],
                     "=",ToString[sizeM],";"]];
            If[ numberOfIndices>1, 
                sizeN=bound1[[2,2]]-bound1[[2,1]]+1;
                declC1=Append[declC1,hseq["int ", 
                         StringJoin["sizeN",decl1[[1]]],"=",
                         ToString[sizeN],";"]],
		declC1=Append[declC1,hseq["int ",
                         StringJoin["sizeN",decl1[[1]]],"=1;"]]
            ]
          ]
        ];
        declC1
      ];
    memNew=Apply[vseq,Map[declareVarMatlab,Join[sys[[3]],sys[[4]]]]];	    

    (* code for inputs *)
    codeInput=vseq[];
    Do[curInput=sys[[3,i,1]];
      codeInput=Append[codeInput,
        hseq[curInput," = mxGetPr(prhs[",ToString[i-1],"]);"]];
      ,{i,1,Length[sys[[3]]]}
    ]; (* Do *)
 
    (* code for output *)
    codeOutput=vseq[];
    Do[
      curOutput=sys[[4,i,1]];
      codeOutput=
        Append[codeOutput,
          hseq["plhs[",ToString[i-1],"]=  mxCreateDoubleMatrix(",
          StringJoin["sizeM",curOutput],",",
          StringJoin["sizeN",curOutput],",mxREAL);"]
        ];

      codeOutput=
        Append[codeOutput,
        hseq[curOutput," = mxGetPr(plhs[",ToString[i-1],"]);"]];
      ,{i,1,Length[sys[[4]]]}
    ];  (* Do *)

    block[hseq["void mexFunction( int nlhs, mxArray *plhs[], ", 
		  "int nrhs, const mxArray *prhs[] )"],
	     vseq[" "," ",
		  memNew," "," ",
		  codeInput," "," ",
		  codeOutput," "," ",
		  hseq[sys[[1]], "(",
		      list@@Map[First[#]&,
			       Join[inputs, outputs]],
		      ");"],
		  hseq["return;"]
	     ]
	]
    ]
  ];

userMatlab[a___] :=
  Module[{},
	 Message[userMatlab::wrongArg, {a}];
	 Throw[False]
       ];
    

(* === *)
Clear[ddcGen];


 ddcGen::wrongArg = "`1`";
 ddcGen::noResult = "No default system in $result.";
 ddcGen::checked = "aborted because of a previous error in `1`.";
 ddcGen::nofile = "Cannot write `1`.";
 ddcGen::file = "file `1` exists (consider using rewrite option).";
 ddcGen::option = "Unexpected option : `1`.";
 ddcGen::params = "Unscheduled code requires parameters set, set parameters or try scheduled code";

Options[ddcGen] = Options[cGen];
 
ddcGen[
 sys :_system,
 file:_String,
 pVal:{___Rule},
 options:___Rule] := 
Module[{dbg, res},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 1"] ];

  res = 
  With[{info = FileInformation[file]},
   
   If[Or[info === {}, rewrite /. {options} /. Options[ddcGen],
     internalFormat /. {options} /. Options[ddcGen]],
     With[
       {s = If[ !(internalFormat /. {options} /. Options[ddcGen]),
	  OpenWrite[file]
	],
	optVerbose = verbose /. {options} /. Options[ddcGen],
	dbg = debug /. {options} /. Options[ddcGen],
	optInternalFormat = internalFormat /. {options} /. Options[ddcGen],
	optInteractive = interactive /. {options} /. Options[cGen],
	optMatlab = matlab /. {options} /. Options[cGen]
       },

       If[ dbg, Print["Calling ddcGen"] ];

       If[s=!=$Failed,
         With[{ code = Catch[
           Module[{ verb, vars, pDim, idx,parm, ctx,param,idList,idList2},
             If[optVerbose||dbg,
	       verb[a___] := Print[a],
	       verb[a___] := Null];
	     
	     (* Check if parameter values provided *)
	     pDim = sys[[2,1]];
	     parm = sys[[2,2]]/.pVal;
	     If[MemberQ[Map[NumberQ[#]&,parm],False],Message[ddcGen::params];Throw[$Failed],
	     Print["Parameters fine"];
	     Print["WARNING!!! dddcGen should not be called, it is bugged"]];
	     
	     verb["Generating code for system ", sys[[1]]]; 
	     
	     ctx = mkContext[sys];
	     
     (*  normalize system if user wants, option ommited not useful *)
     (*  sys=If[normalize/.{options}/.Options[ddcGen],
	     simplifyAffines[normalize[sys]],
	     sys];*)
	     
     (* replace indices with indices of variable having max dimensions *)
	     With[{ lengths=Map[Length[#[[2]]]&,ctx]},
		 idList =ctx[[Position[lengths,Last[Sort[lengths]]][[1]] ,2]];
		 idList2=Drop[idList[[1]],-pDim];
		 renameIndices[sys,idList2];
	     ];
	     
	     vars = 
               Map[
                 Map[
                   Function[{d},
                     If[MatchQ[d, _decl],
		       (* Call to mkDomain changed to send all options *)
                       Apply[mkDomain,
                         Join[List@@d,
                           {pDim, pVal, options}]
                       ],
                       {Apply[mkAlias, Join[d, alias[pDim, pVal]]], "", "",
			      left["#undef ", d[[1]]]}]
		   ], #]&,
		 List@@Take[sys, {3,5}]];

	     (* At this point, the data structure of vars seems to 
	      be the following one. 
	      . vars[[1]] is a list of descriptors for the inputs
	      . vars[[2]] is a list of descriptors for the outputs
	      . vars[[3]] is a list of descriptors for the local vars
	      Each descriptor contains four fields. The first one is
	      a define statement, the second one is a declaration, 
	      the 3d one a malloc statement, the fourth one an 
	      undef statement *)
	     
	     idx = Apply[Union,Map[Drop[Part[#, 3, 2],-pDim]&,
				  Join@@Take[sys,{4,5}]]];
	     
	     param = Select[sys[[2,2]]/.pVal, StringQ];
	     ctx = mkContext[sys];
	     
	     If[ dbg, Print["ctx: ",  ctx ] ];	     

	     vseq[
               With[{date=Date[]},
                 hseq["/* Generated: ", 
                   date[[3]], "/", 
                   date[[2]], "/", 
                   date[[1]],
		  " at ", date[[4]], ":", date[[5]], ":", date[[5]], " */"]
	       ],
	       
	       If[optInteractive,
                 vseq[preamble[options],
                   preamble2],
                   hseq["/*Function to be used in another system*/","\n"]
	       ];
	       If[optMatlab,
                 vseq[preamble[options],
                   preamble2],
                   hseq["/*Matlab interface not implemented here*/","\n"]
	       ],
		  
       (* we have free var(), mallocs and decl of functions at top of C prog *)
	       Block[
                 {freevars = 
		    (If[ dbg, Print[ "Computing freevars" ] ];
                    If[optInteractive,
                      Map[Part[#,3]&, vseq@@Join@@vars],
                      Map[Part[#,3]&, vseq@@vars[[3]]]
		    ]),
		    
                  mallocs = 
		    (If[ dbg, Print[ "Computing mallocs" ] ];
                    If[optInteractive,
                      If[ dbg, Print[ "vars", FullForm[vars] ] ];
		      Module[{v,x, 
                      auxf = 
                      Function[{x},
                        With[{t=x[[2,1]]},
			    If[ Length[t]>=10, hseq["_", Take[t,{3,10}] ],
			      hseq["/* Error ",x," */"]
			    ]
			]
		      ]
		             },
			    v = vseq@@Join@@vars;
			    If[dbg, Print[ FullForm[v] ] ];
                            Global`$$v = v; 
			    x = Map[ aux, v ];
			    Global`$$x = x;x
			    ]
		      (*
                      Map[hseq["_",Take[#[[2,1]],{3,10}]]&,
			 vseq@@Join@@vars
		      ]*),
                      If[ dbg, Print[ "vars", FullForm[vars] ] ];
                      Map[hseq["_",Take[#[[2,1]],{3,10}]]&,
			 vseq@@vars[[3]]
		      ]
                    ]),
		    
                  declfunc = 
		    Module[{d},
                    d = Map[Function[{x},
                          hseq[mkType[x[[3]], options],
			      " Compute_",x[[1]],"( );"]],ctx];
		    If[ dbg, Print["d",FullForm[d] ] ];d
		    ]
                  },
		 
		 vseq[
		      hseq["/* declaration of all functions */"], 
		      vseq@@declfunc,
		      hseq[" "],
		      hseq["/* aliases for all variables */"],
		      Map[Part[#,1]&, vseq@@Join@@vars],
		      hseq[" "],
		      hseq["/* declare all the variables */"],
		      Map[If[ Depth[#[[2,1]]]>=3,
                              hseq[Part[#[[2,1]],{1,2,3}],";"],
			    hseq["/* Error */"]]&, 
			 vseq@@Join@@vars],
		      hseq[" "],
		      hseq["/* the Compute_var statements */"],

		      Print["1"];
		      ddcGen[sys, 1, pDim, pVal, options],

		      Print["2"];
		      hseq[" "],
		      (* This writes the "main()" or "sysI()" depending 
		       on options *)
		      Print["3"];
		      (*
		      dduserInterface[sys,mallocs,freevars,pVal,options],
		       *)
		      hseq["/* User interface */"],
		      Print["4"];
		      hseq[" "],
		      hseq["/* and finally undef aliases */"],
		      Map[Part[#,4]&, vseq@@Join@@vars]
		      (*If[optInteractive,
			  Map[Part[#,4]&, vseq@@Join@@vars],
			  Map[Part[#,4]&, vseq@@vars[[3]]]]*)
		 ]
	       ], (* Block *)
	       hseq[" "]
	       
	     ]
	   ]]
	 },
	     If[!optInternalFormat,
	       If[ dbg, Print[" Writing file " ] ];
	       verb["Writing file ", file, "..."];
	       writeCcode[s,code];
	       Close[s];
	       True,
	       code
	     ]
	 ],
	 Message[ddcGen::nofile, file]; $Failed
       ]
     ],
     Message[ddcGen::file, file]; $Failed
   ]
  ];

  If[ dbg, Print["Exiting ddcGen form 1"] ];
  res

];

ddcGen[
 sys:_system,
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule]:=
Module[{dbg, res},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 2"] ];

  res = Check[
     
     Module[{inputComp,eqnComp,ctx,changeRule},
	  
	    ctx = mkContext[sys];
	    changeRule = Map[RuleDelayed[#[[1]],"Compute_"<>#[[1]]]&,ctx];
	    Clear[pre]; 
	    pre=List[];
	    inputComp = 
	        Map[Function[{inpvar},
			    With[{type=mkType[inpvar[[2]], options],
				  sidx = Apply[list,
					      Drop[inpvar[[3,2]], -pDim]]},
				vseq[
				     hseq[type," Compute_",inpvar[[1]],"(", sidx,")"],
				     vseq@@Map[StringJoin["int ",#,";"]&,sidx],
				     hseq["{"],
				     hseq["  return (&",inpvar[[1]],"(",sidx,"))->value;"],
				     hseq["}","\n"]
				]
			    ]
		],vseq@@sys[[3]]
		];
	    
	    eqnComp =
	        Map[Function[{eqn},
			    With[{context= Select[ctx, Equal[First[#], eqn[[1]]]&]},
				If[Length[context] =!= 1,
				  Message[ddcGen::noCtx];
				  Throw[$Failed]];
				
				  show[eqn];

				  With[{type = mkType[context[[1,3]],options],
					  sidx = Apply[list,
						      Drop[context[[1,2]], -pDim]],
					  optDebug = debug/.{options}/.Options[ddcGen],
					  optDebugC= debugC /. {options} /. Options[VirtexGen];
                                                  code = ddcGen[ctx, eqn,lev,pDim,pVal,options]},

				      vseq[hseq[type," Compute_",context[[1,1]],"(",sidx,")"],
					  
					  vseq@@Map[StringJoin["int ",#,";"]&,sidx],
					  hseq["{"],
					  hseq[" ",type,"var  *temp;"],
					  hseq[" temp = &",context[[1,1]],"(",sidx,");"],
					   If[optDebug, hseq["printf(\"","Computing ",context[[1,1]], 
							   "(", sidx/.Rule[s_String, "%i"], ")  ",
							      "\\n\", ", sidx, ");"],
					    hseq[""]],
					  hseq[" if (!temp->computed){"],
					  code,
					  hseq["  temp->computed = 1;}"],
					  hseq[" return temp->value;"],
					  hseq["}"],
					  hseq[""]
				      ]]
			    ]
		],vseq@@sys[[6]]
		];
	    vseq[hseq[" "],
		 vseq@@pre/.changeRule,
		 inputComp,
		 eqnComp,
		 hseq[" "]
	    ]
],
     Message[ddcGen::checked,"Compute_code"];
     Throw[$Failed]
  ];

  If[ dbg, Print["Exiting ddcGen form 2"] ];
  res

]; (* Module *)

     
ddcGen[
 ctx:List[__List],
 code:equation[v:_String, c_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
Module[{dbg, res},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 3"] ];

  res  = Check[
    With[{context = Select[ctx, Equal[First[#], v]&],
	   
    changeRule =
      Map[RuleDelayed[#[[1]],"Compute_"<>#[[1]]]&,ctx]},
	
    If[Length[context] =!= 1, Message[ddcGen::noCtx]; Throw[$Failed]];
	
    Module[{idx,type,code1},

      idx = context[[1,2]];
      type = context[[1,3]];
      code1 = ddcGen[ctx, idx, c, lev, pDim, pVal, options]/.changeRule;
 
      With[{out = vseq[hseq["  temp->value  = ", code1 ,";"]] },

        If[dbg,
	  vseq[out,
	      With[{sidx = Apply[list, Drop[idx, -pDim]]},
		  hseq["printf(\"", v, "(", sidx/.Rule[s_String, "%i"],
		      ") = ",
		      mkPType[type], "\\n\", ",
		      sidx, ", (&", v, "(", sidx, "))->value",
			");"]]],
	  out
	] (* If *)
      ] (* With *)
    ] (* Module *)
    ], (* With *)
    Message[ddcGen::checked, "equation"];
    Throw[$Failed]
  ];
  If[ dbg, Print["Exiting ddcGen form 3"] ];
  res

];

ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:reduce[op1_,aff1_:matrix,c_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
Module[{dbg},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 4"] ];

  Check[With[{t = ToString[Length[pre]+1],
	     pName = Take[ctx[[1,2]],-pDim]},
	
	  (* EXAMPLE  to explain ::  B(i, j, N) = reduce(+, (i,j,k,N->i,j,N), Y); with  N->param   *)

	  Module[{idRule,expDom,indx,lhsIndx,allIndx,domEqns,fDomEqns,formatIndx,
		    initDom,domPre,domFinal,aff2,newExpDomIndx},
		
		(* for remaining code indices change, so we will make rule to do so *)
		    idRule = Map[Rule[#,#<>t]&,Drop[aff1[[3]],-pDim]];

		(*  Tell what functions in pre are  for *)
		   pre = Prepend[pre,hseq["/*for reductions*/"]];

		    expDom = expDomain[c];
		    
    (* THIS SECTION MAKES DOMAINS TO BEGIN,
	    1.DOMAIN OF RHS OF AFFINE PARAMETERIZED BY LHS OF EQN
	    2.DOMAIN OF LHS INDICES TO SERVE AS PARAM DOMAIN*)
		
		(* from aff, indx is: {i1, j1, N } also lhsIndx is : {i,j} ; we assuming t=1 here*)
		    indx = Join[Take[aff1[[3]],{1,aff1[[1]]-2}]/.idRule,pName];
		    lhsIndx = Drop[idx,-pDim];
		
		(* allindx is : {i1,j1,N,i,j} with {i,j} from lhs *)
		    allIndx = Join[indx,lhsIndx];
		
		   
		(* domeqns is : {i1=i,j1=j} and  fDomEqns puts ";" in between *)
		    domEqns = MapThread[StringJoin[#1,"=",#2]&,{Take[indx,{1,Length[lhsIndx]}],lhsIndx}];
		    fDomEqns = StringJoin[ domEqns[[1]] , Map[ StringJoin[";",#]&,Rest[domEqns] ] ];

		(* put commas in list to make right format *)
		    formatIndx = StringJoin[ allIndx[[1]] , Map[ StringJoin[",",#]&,Rest[allIndx] ] ];
		  
		(* we use readDom on : {i1,j1,N,i,j | i1=i;j1=j} *)
		    initDom=readDom["{"<>formatIndx<>"|"<>fDomEqns<>"}"];
		
		
    (* DOMAINS->DONE;WE EXTEND AFFINE TO LHS INDICES,ADDED AS PARAMETER DOMAIN *)
               
                (* here the extension of aff1 *) 
                     aff2 = extendMatrix[aff1/.idRule,lhsIndx];
      
    (* THE CORE OPERATIONS *)
   
	       (* We take preimage of domain by affine *)
	           domPre = DomPreimage[initDom,aff2];
  
                   newExpDomIndx = Join[expDom[[2]]/.idRule,lhsIndx];
   
                
	       (* We intersect with domain of expr( with parameter domain added and indices changed) *)
	           domFinal = DomIntersection[domPre,DomExtend[expDom/.idRule,newExpDomIndx]];
	            Print["Reduction over domain :"];
	            Print[domFinal];
	      
		 
	   With[{dom = domFinal,
		   (* if restrict,generate if statement else simple one to accumulate by op*)
		   code1 = If[MatchQ[c,restrict[___]],
			     mkRestrict[c[[1]]/.idRule,pDim,pVal,
				       hseq["temp",t," ",binOp[op1]," = ", 
					   ddcGen[ctx, aff1[[3]]/.idRule,c[[2]], lev, pDim, pVal, options],";"]],
			     hseq["temp",t," ",binOp[op1],"= ",  
				 ddcGen[ctx, aff1[[3]]/.idRule, c, lev, pDim, pVal, options],";"]]},
	       
	       (* Make function bodies for temporary vars *)
	       pre = Append[pre,vseq[hseq["float Compute_temp",t,"(",list@@lhsIndx,")"],
				    vseq@@Map[hseq["int ",#,";"]&,lhsIndx],
				    hseq["{"],
				    (*Add to the beggining the temporary variable and new indices*)
				    vseq@@Map[hseq["  int ",#, " = 0;"]&,Drop[aff1[[3]]/.idRule,-pDim]],
				    hseq["  float temp",t," = ",If[MatchQ[op1,mul],"1","0"],";"],
				    (* Loop the domain and put the code *)
				    mkLoop[dom,lev,Length[idx],pVal,code1],
				    hseq["  return temp",t,";"],
				    hseq["}"],
				    hseq[""]
	       ]];
	       
	       (* This is only thing returned rest put in pre *)
	       hseq["Compute_temp",t,"(",list@@lhsIndx,")"]
	       
	   ]
	  ]
 ],
      
      Message[ddcGen::checked, "reduce"];
      Throw[$Failed]
  ]
];


ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:case[__List],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
Module[{dbg},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 5"] ];

Check[
      (* domain is obvious if restrict is there else calculated*)
      With[{dom1 = If[MatchQ[code[[1,1]],restrict[___]],
		     code[[1,1,1]],
		     expDomain[code[[1]]]],

	    (* code over above domains*) 
	    putcode = If[MatchQ[code[[1,1]],restrict[___]],
			ddcGen[ctx, idx, code[[1,1,2]], lev, pDim, pVal, options],
			ddcGen[ctx, idx, code[[1,1]], lev, pDim, pVal, options]]},

	  (* (dom-condition) ? (putcode) : (case called again ||  error put) *)
	  If[Length[code[[1]]]>1,
	    mkRestrictExpr[dom1,idx,pDim,pVal,putcode,
			  ddcGen[ctx,idx,case[Drop[code[[1]],1]],lev,pDim,pVal,options]],
	    mkRestrictExpr[dom1,idx,pDim,pVal,putcode,hseq[
			  "(printf(\"case violation \"),exit(-1),1)"]]
	  ]],

				  
      Message[ddcGen::checked,"case"];
      Throw[$Failed]
]
];




ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:restrict[d:_domain,c_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
Module[{dbg},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 6"] ];

  Check[
      mkRestrictExpr[d,idx,pDim,pVal,ddcGen[ctx, idx, c, lev, pDim, pVal, options],
		    hseq[ "(printf(\"restrict  violation \"),exit(-1),1)"]],
    Message[ddcGen::checked, "restrict"];
    Throw[$Failed]
  ]
];

 
ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:affine[var[v:_String], m:_matrix],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
Module[{dbg, res},
  dbg = debug/.{options}/.Options[ cGen ];
  If[ dbg, Print["Calling ddcGen form 7"] ];

  res = Check[
    With[{id = Join[idx /.pVal, {1}]},
	 hseq[v, "(", list@@Drop[m[[4]].id, -pDim-1], ")"]
       ],
    Message[ddcGen::checked, "affine"];
    Throw[$Failed]
  ];
  If[ dbg, Print["Exiting ddcGen form 7" ] ]; 
  res
];
  
ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:affine[const[v:_], m:_matrix],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
  hseq[v];

ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:var[v:_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
  hseq[v,"(",list@@Drop[idx,-pDim],")"];
  
ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:binop[op:_, v1_, v2_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
  Check[
    If[prefixQ[op],
       hseq[op,
	    "(",
	    ddcGen[ctx, idx, v1, lev, pDim, pVal, options], ", ",
	    ddcGen[ctx, idx, v2, lev, pDim, pVal, options], ")"],
       hseq["(",
	    ddcGen[ctx, idx, v1, lev, pDim, pVal, options], " ", binOp[op], " ",
	    ddcGen[ctx, idx, v2, lev, pDim, pVal, options], ")"]],
    Message[ddcGen::checked, "binop"];
    Throw[$Failed]
  ];

ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:unop[op:_, v:_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
  hseq[unOp[op], "(", ddcGen[ctx, idx, v, lev, pDim, pVal, options], ")"];
     
ddcGen[
 ctx:List[__List],
 idx:List[__String],
 code:if[v1_, v2_, v3_],
 lev:_Integer?NonNegative,
 pDim:_Integer?NonNegative,
 pVal:{___Rule},
 options:___Rule] :=
  Check[
    hseq["(",
	    ddcGen[ctx, idx, v1, lev, pDim, pVal, options], "? ",
	    ddcGen[ctx, idx, v2, lev, pDim, pVal, options], ": ",
	    ddcGen[ctx, idx, v3, lev, pDim, pVal, options], ")"],
    Message[ddcGen::checked, "binop"];
    Throw[$Failed]
];

(* === *)
Clear[extendMatrix];

  extendMatrix::wrongArg = "`1`";

extendMatrix[
  m:_matrix,
  l:List[__String]] :=
  With[{ids = Join[m[[3]], l],
	x = Length[l],
	a = m[[1]]-1,
	b = m[[2]]-1,
	mat = Map[Drop[#,-1]&, Drop[m[[4]],-1]],
	cst = Drop[Map[Last, m[[4]]],-1]},
       If[Length[ids] != Length[Union[ids]],
	  Throw[$Failed],
	  matrix[a+x+1, b+x+1, ids,
		 Join[
		   MapThread[Append,{Map[Join[#,Table[0,{i,x}]]&, mat], cst}],
		   Take[IdentityMatrix[b+x+1], -x-1]
		 ]
	       ]
	]
     ];


extendMatrix[a___] :=
  Module[{},
	 Message[extendMatrix::wrongArg, {a}];
	 Throw[$Failed]
       ];


(* === *)

Clear[dduserInterface];

 dduserInterface::wrongArg = "`1`";

dduserInterface[
 sys:_system,
 malloc:m_,
 freevar:f_,
 pVal:{___Rule},
 options:___Rule] := 
Module[{dbg, res},

      dbg = debug/.{options}/.Options[cGen];
      If[ dbg, Print["Calling dduserInterface "] ];

  res = 
  With[{pDim = sys[[2,1]],
	optInteractive =interactive/.{options}/.Options[ddcGen],
	optNoPrint = noPrint/.{options}/.Options[ddcGen],
	inputs = sys[[3]],
	outputs = sys[[4]],
	param = Select[sys[[2,2]]/.pVal, StringQ]
	},
   
       Module[{read, write,evalOuts,evalOuts2,mem,ins,outs,free},
	    
	     ins=getInputVars[sys];
	     outs=getOutputVars[sys];
	     mem=vseq[hseq[" "],
		     hseq["/*Allocate memory to global variables*/"],
		     m,
		     hseq[" "]
	      ];
	      free=vseq[hseq[" "],
		       hseq["/*Free the memory*/"],
		       f,
		       hseq[" "]];
	      read =
		Map[Function[{dcl},
			     With[{sidx = Apply[list,
					       Drop[dcl[[3,2]], -pDim]],
			      doms = Map[domain[dcl[[3,1]],dcl[[3,2]],List[#]]&,dcl[[3,3]]]},

				 vseq@@Map[ mkLoop[#, 1, pDim, pVal,
				           vseq[
						hseq["if(!(&",dcl[[1]],"(",sidx,"))->computed)"],
						hseq["{"],
						If[!optNoPrint,hseq["fprintf(stdout, \"",
						    dcl[[1]], "[",
						    ReplaceAll[sidx,
							      Rule[s_String, "%i"]],
						    "]?\", ",
						    sidx, ");"
						],hseq["/* Prints omitted */"]],
						hseq["fscanf(stdin, \"", mkPType[dcl[[2]]],
						    "\", ", StringJoin["&((&", dcl[[1]]],
						    "(", sidx, "))->value));"],
						hseq["(&",dcl[[1]],"(", sidx, "))->computed = 1;"],
						hseq["}"]
					   ]
				 ]&,doms
				 ]
			     ]
			   ],
		    vseq@@inputs
		    ];
	      write =
		Map[Function[{dcl},
			     With[{sidx = Apply[list,
						Drop[dcl[[3,2]], -pDim]]},
				  If[dcl[[3,1]]>pDim,
				     mkLoop[dcl[[3]], 1, pDim, pVal,
					    If[!optNoPrint,hseq["fprintf(stdout, \"",
						 dcl[[1]], "[",
						 list@@Array["%i"&, Length[sidx]],
						 "]=",
						 mkPType[dcl[[2]]],
						 "\\n\", ", sidx, ", (&", dcl[[1]],
							       "(", sidx, "))->value);"]
					      ,hseq["fprintf(stdout"," ,\"",mkPType[dcl[[2]]],"\\n\" , (&", dcl[[1]],
						   "(", sidx, "))->value);"]]],

				               hseq["fprintf(stdout, \"",
						 dcl[[1]], "=",
						 mkPType[dcl[[2]]],
						 "\\n\", ", dcl[[1]], "());"]
				   ]
				]
			   ],
		    vseq@@outputs
		    ];
	     
	      evalOuts = 
	        Map[Function[{dcl},
			     With[{sidx = Apply[list,
					       Drop[dcl[[3,2]],-pDim]]},
				 If[dcl[[3,1]]>pDim,
				    mkLoop[dcl[[3]], 1, pDim, pVal,
					 hseq["(&",dcl[[1]],"(",sidx,"))->value  =  Compute_",
					     dcl[[1]],"(",sidx,");"]],
				   hseq[dcl[[1]]," = Compute_",dcl[[1]],"();"]
			         ]
			      ]
			     ],
		    vseq@@outputs
		   ];

		evalOuts2 = 
	        Map[Function[{dcl},	
			     With[{sidx = Apply[list,
					       Drop[dcl[[3,2]],-pDim]]},
				 If[dcl[[3,1]]>pDim,
				    	mkLoop[dcl[[3]], 1, pDim, pVal,
					 	hseq["",dcl[[1]],"(",sidx,")->value  =  Compute_",
						    		    dcl[[1]],"(",sidx,");"]],
				   	hseq[dcl[[1]]," = Compute_",dcl[[1]],"();"]
			         ]
			      ]
			     ],
		    vseq@@outputs
		   ];
	      
	      If[optInteractive,
		block[hseq["int ", (*sys[[1]]<>"I",*) "main (void)"],
		     vseq[
			  vseq@@Map[StringJoin["int ", #, ";"]&,
				   Union@@Map[Drop[Part[#, 3, 2],-pDim]&,
					     Join[inputs, outputs]]],
			  mem,
			  read,
			  evalOuts,
			  write	,
			  free
		     ]
		],
	        vseq[hseq["int ", sys[[1]]<>"I", "(",
			   hseq@@Map[StringJoin[#[[1]],","]&,Drop[Join[sys[[3]],sys[[4]]],-1]],
			   Last[sys[[4]]][[1]],")"],
		    vseq@@Map[StringJoin[mkType[#[[2]],options],"var *",#[[1]],";"]&,
			     Join[sys[[3]],sys[[4]]]],
		    vseq[
			 hseq["{"],
			 
			 vseq@@Map[StringJoin["int ", #, ";"]&,
				  Union@@Map[Drop[Part[#, 3, 2],-pDim]&,
					    Join[inputs, outputs]]],
			 vseq@@Map[hseq[StringJoin["_",#," = ",#,";"]]&,Join[ins,outs]],
			 mem,
			 hseq[""],
			 evalOuts2,
			 free,
			 hseq["}"]
		    ]
		]
	      ]
       ]
  ];

  If[ dbg, Print["Exiting dduserInterface"] ];
  res

];


dduserInterface[a___] :=
  Module[{},
	 Message[dduserInterface::wrongArg, {a}];
	 Throw[$Failed]
       ];

(* === *)

End[];
Protect[cGen];
Protect[userInterface];
Protect[ddcGen];
Protect[dduserInterface];
EndPackage[];









