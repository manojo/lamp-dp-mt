(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Florent Dupont de Dinechin
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

   $Author: quinton $
   $Date: 2009/05/22 10:24:36 $
   $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/ToAlpha0v2.m,v $
   $Revision: 1.8 $
   $Log^$

*)
BeginPackage["Alpha`ToAlpha0v2`", {"Alpha`Domlib`",
				   "Alpha`",
				   "Alpha`Options`",
				   "Alpha`Matrix`",
				   "Alpha`Properties`",
				   "Alpha`Tables`",
				   "Alpha`Semantics`",
				   "Alpha`Substitution`",
				   "Alpha`Normalization`",
				   "Alpha`ChangeOfBasis`",
				   "Alpha`Pipeline`",
				   "Alpha`CutMMA`",
				   "Alpha`SubSystems`",
				   "Alpha`Control`",
                                   "Alpha`Visual`",
				   "Alpha`PipeControl`"
				 }]

ToAlpha0v2::usage =

"ToAlpha0v2: Package. Contains functions for the transformation of
scheduled programs into Alpha0v2 form: decomposeSTdeps,
makeInputMirrorEqus[], toAlpha0v2[]";

needSeparation::usage="debugUse";

toAlpha0v2::usage =
"toAlpha0v2[sys_Alpha`system,options_List] converts a scheduled program
`sys' (see schedule[] and applySchedule[]) to Alpha0v2 form. The program
`sys' is assumed to be such that all the local variables have the same
dimension (see uniformizeDims[]) and all the dependencies are
uniform. This function calls in sequence spaceTimeDecomposition[]
makeAllMuxControl[], pipeAllControl[] and decomposeSTdeps[]. See these
transformations for further information. WARNING: if there is more
than one space index then pipeAllControl[] doesn't work yet.
If sys is not present then the transformations apply to $result and
modify it. The option list is optional. ";


steps::usage = "steps is an option of toAlpha0v2. It gives a list
of numbers, each one corresponding to a step.";

(* THE FOLLOWING WAS CUT FROM Transformation.m          *)

makeSimpleExpr::usage =
"makeSimpleExpr[sys] renames all the subexpressions which are not simple
until the program as no more composed expression (in the sense of the
analysis performed by needSeparation). Currently, the expression
simplified are only the one involving multiplexer and operators";

makeSimpleExpr::reclim =
"More than five passes: there must be a problem.";

makeSimpleExpr::args="Wrong arguments.";

(* End of the part cut from Transformation.m *)

decomposeSTdeps::usage =
"decomposeSTdeps[sys] splits, in sys, each dependency
involving space and time into two dependencies, one on space, the
other on time. decomposeSTdeps[] applies to $result and modifies it.";

decomposeSTdeps::args="Wrong arguments.";

makeInputMirrorEqus::usage =

"makeInputMirrorEqus[sys_Alpha`system,options_List] adds to system
`sys' mirror equations fot the inputs. This low-level transformation
is needed before the translator to AlpHard is invoked. `sys' is
optional, defaults to $result, and the option list is optional, too
(see Options[makeInputMirrorEqus]).";

makeInputMirrorEqus::args="Wrong arguments.";

toAlpha0v2::args="Wrong arguments.";

reuseCommonExpr::usage = "reuseCommonExpr[sys_Alpha`system] attemps to
gather expressions used several time by adding local variables for
these expressions in system `sys'. 
reuseCommonExpr[sys_Alpha`system,var_String,expr_] specifically add
  variable `var' for expr `expr' (which s in ast form). Currently only
  RHS of equation are scanned up for multiple uses";

 
integerToBooleanSyst::usage =
"integerToBooleanSyst[<syst_Alpha`system>]
Function, change all * in and and all + in or. Returns the resulting 
AST";

booleanToIntegerSyst::usage =
"booleanToInteger[<syst_Alpha`system>]
Function, change all and in * and all or in +. Returns the resulting 
AST";

(* For debugging
paramUniformQ::usage =""
isTempMatrixQ::usage =""
isSpaceMatrixQ::usage =""
makeTimeMat::usage ="zut"
makeSpaceMat::usage =""
*)

correctIdEqs::usage="debug";

splitMax::usage= "splitMax[sys]returns the system sys	in which 
the Max4 has been replaced by calls to Max operators, splitMax[]
applies this to $result";

convexQ::usage = 
"convexQ[sys] is true if system sys does not contain non convex 
domains.";

shiftProcessorSpace::usage =
"shiftProcessorSpace[] shifts positively the processor space of all
variables of a program. This is used to make sure that the processor indexes
are positive, as some tools do not support negative indexes";

Begin["`Private`"]

Clear[ shiftProcessorSpace ];
shiftProcessorSpace[ opts:___Rule ] := 
Catch[
  Module[ {s, vars, doms, domsProjected, indexes, params, dbg },
    dbg = debug/.{opts}/.{debug->False};

    vars = getLocalVars[ ];
    If[ dbg, Print[ "Variables: ", vars ] ];

    doms = Map[ getDeclarationDomain, vars ];
    If[ dbg, Print[ "Their domains: ", doms ] ];

    indexes = Map[ #[[2]]&, doms ];
    params = getSystemParameters[];
    indexes = Map[ Drop[ #, -Length[ params ] ]&, indexes ];
    If[ dbg, Print["Indexes of variables: ", indexes ] ];

    (* Check indexes *)
    indexes = Map[ #==={"t","p"}&, indexes ];
    If[ !Apply[ And, indexes ], 
      shiftProcessorSpace::wrgindex = "all variable indexes should be t and p";
      Throw[ Message[ shiftProcessorSpace::wrgindex ] ];
    ];

    Check[
      domsProjected = Map[ DomProject[#,{"p"}]&, doms ];
      If[ dbg, Print["Projected domains: ",  domsProjected ] ];

      bds = Map[ getBoundingBox, domsProjected ];
      If[ dbg, Print[ "Boundaries: ", bds ] ],
      shiftProcessorSpace::err = "error while projecting domains or compuing bounds";
      Throw[ Message[ shiftProcessorSpace::err ] ];
    ];

    s = Apply[ Min, Map[ #[[1,1]]&,  bds ] ];
    If[ dbg, Print["Minimum value of p: ", s ] ];

    If[ s>=0 && dbg, Print["No shift necessary"] ];

    (* Do the change of basis *)
    Check[
      If[ s < 0,
        If[ dbg, Print["Shifting by ", -s ]];
        Map[ changeOfBasis[ #<>".(t,p->t,p+"<>ToString[-s]<>")" ]&, vars ];
      ],
      shiftProcessorSpace::err2 = "error while applying change of basie";
      Throw[ Message[ shiftProcessorSpace::err2 ] ];
    ];
  ]
];
shiftProcessorSpace[___] := Message[ shiftProcessorSpace::params ];

Clear[ convexQ ];
convexQ[] := convexQ[ $result ];
convexQ[ sys:_system ] := (convexizeAll[ sys ] === sys );
convexQ[___] := Message[convexQ::params];

(***********************************************************)
(***********************************************************)
(* ENSEMBLE DE FONCTIONS POUR LA SEPARATION ESPACE/TEMPS *)
(***********************************************************)
(***********************************************************)


(* Is an Alpha matrix uniform? (parameterized version, unlike
   uniformQ) *)
(*  unused in the end, but I leave it here *)

Clear[paramUniformQ];

paramUniformQ[mat_Alpha`matrix, nbparams_Integer]:=
  Catch[
    If[mat[[1]]=!=mat[[2]],
       Throw[False]];
    Module[{n,i,j,m},
	   n=mat[[1]]-nbparams-1;
	   m=mat[[4]];
	   For[ i=1, i<=n, i=i+1,
		For[ j=1, j<=n, j=j+1,
		     If[(i==j),
			If[m[[i]][[j]]=!=1, Throw[False]],
			If[m[[i]][[j]]=!=0, Throw[False]] ];
		   ]];
	   Throw[True]
	 ]
  ];
		
Clear[isTempMatrixQ];

isTempMatrixQ[mat_Alpha`matrix, nbparams_Integer]:=
  Catch[
    If[mat[[1]]=!=mat[[2]],
       Throw[False]];
    Module[{n,i,j,m},
	   n=mat[[1]]-nbparams-1;
	   m=mat[[4]];
	   (* is it uniform ? *)
	   For[ i=1, i<=n, i=i+1,
		For[ j=1, j<=n, j=j+1,
		     If[(i==j),
			If[m[[i]][[j]]=!=1, Throw[False]],
			If[m[[i]][[j]]=!=0, Throw[False]] ];
		   ]];
	   (* are all the space constant coefficients zero ?
	    (counting in the parameters) *)
	   For[ i=2, i<=n, i=i+1,
		For[ j=n+1, j<=mat[[1]], j=j+1,
		     If[m[[i]][[j]]=!=0, Throw[False]] ] ];
	   Throw[True]
	 ]
  ];


Clear[isSpaceMatrixQ];

isSpaceMatrixQ[mat_Alpha`matrix, nbparams_Integer]:=
  Catch[
    If[mat[[1]]=!=mat[[2]],
       Throw[False]];
    Module[{n,i,j,m},
	   n=mat[[1]]-nbparams-1;
	   m=mat[[4]];
	   (* is it uniform ? *)
	   For[ i=1, i<=n, i=i+1,
		For[ j=1, j<=n, j=j+1,
		     If[(i==j),
			If[m[[i]][[j]]=!=1, Throw[False]],
			If[m[[i]][[j]]=!=0, Throw[False]] ];
		   ]];
	   (* are all the time constant coefficients zero ?
	    (counting in the parameters) *)
	   For[ j=n+1, j<=mat[[1]], j=j+1,
		  If[m[[1]][[j]]=!=0, Throw[False]] ];
	   Throw[True]
	 ]
  ];


Clear[makeTimeMat];

makeTimeMat[mat_Alpha`matrix]:=
  Module[{m},
	 m=IdentityMatrix[mat[[1]]];
	 Alpha`matrix[
	   mat[[1]],
	   mat[[2]],
	   mat[[3]],
	   ReplacePart[m,
		       mat[[4]][[1]],
		       1 ] ]
       ];



Clear[makeSpaceMat];

makeSpaceMat[mat_Alpha`matrix]:=
  Module[{m},
	 m=IdentityMatrix[mat[[1]]];
	 Alpha`matrix[
	   mat[[1]],
	   mat[[2]],
	   mat[[3]],
	   ReplacePart[mat[[4]],
		       m[[1]],
		       1 ] ]
       ];


Clear[decomposeSTdeps];

(* This definition was added to have standard options *)
decomposeSTdeps[ options:___Rule ] := decomposeSTdeps[ {options} ];

decomposeSTdeps[options_List]:=
  Module[{},
	 program = $result;
	 $result = decomposeSTdeps[ $result, options ] 
       ];

decomposeSTdeps[sys:_system, options:___Rule ]:=decomposeSTdeps[sys,{options}];

decomposeSTdeps[sys:_system, options_List]:=
Module[{verb,muteOpts,dbg},
  dbg = debug/.options/.Options[toAlpha0v2];
  verb = verbose/.options/.Options[toAlpha0v2];
  muteOpts = mute/.options/.Options[toAlpha0v2];
  If[ muteOpts, verb = False ];
  decomposeSTdeps1[sys,1,verb,dbg]
];

decomposeSTdeps[___]:=Message[decomposeSTdeps::args];

decomposeSTdeps1[sys:_system, counter_Integer, verb_, dbg:_]:=
Catch[
  Module[{locVars, equList, posList, uses, outuses},

    (* First get a list of the equations of the local variables *)
    locVars = getLocalVars[ sys ];

    (* We do not consider outputs of uses *)
    (* Modification PQ 20/05/04 *)
    uses = Cases[ sys[[6]], use[___] ];
    outuses = Apply[ Union, Map[ Part[#1,5]&, uses ] ];
    locVars = Complement[ locVars, outuses ];

    (* Get equations *)
    equList = Map[ getEquation[sys,#]&,locVars ];	

    (* Then remove from this list the equations which are already
       correct : A=B; and A=B.dep; *)
    posList = Position[ equList, equation[lhs_,_Alpha`var] ];
    equList = Delete[ equList, posList ];
    posList = Position[equList, equation[lhs_, affine[_var,m_matrix] ] ];
    equList = Delete[equList, posList];

    (* Then look for all the dependencies which are uniform (to
      avoid considering  the pipeline init variables)
      and add local variables for them by recursively calling
      decomposeSTdeps.
      When there is no longer such a dependency, call
      decomposeSimpleEqus which will actualy perform the
      space/time decomposition. 
    *)

    posList =  Position[equList, 
			     Alpha`affine[_Alpha`var,
					  m_Alpha`matrix]
			     /; (m[[2]]==m[[1]] && !identityQ[m])
    ];

    If[posList=!={},
      Module[{pos1,pos2,pos,lhsName,rhsName,newSys},
        pos1 = First[posList];

        If[ dbg, 
          Print["----------------"];
          Print[ pos1 ];
        ];

        lhsName=equList[[First[pos1]]] [[1]];
        rhsName=getPart[equList, Join[pos1,{1,1}]];
(*
        rhsName=rhsName<>"_reg"<>ToString[counter];
*)
        rhsName=rhsName<>"Reg"<>ToString[counter];
        (* build the corresponding position in the
           initial system     *)
        pos2 = First[Position[sys, equation[lhsName,_ ]]];
        pos = Join[ pos2, Delete[pos1,1]];
        If[ verb||dbg, 
          Print["  In equation of ",lhsName,
          ", adding a local variable: ",rhsName] ];

        If[ dbg,
	     Print["2222222222222 ", pos ] 
        ];

      Check[
        newSys = addlocal[sys, rhsName, pos ],
	Print[ rhsName, pos ];

        Print["ERROR"]; newSys = sys; Return[]
      ];

        If[ dbg, 
	     Print["3333333333333 ", pos ]
        ];

	     decomposeSTdeps1[newSys,counter+1,verb,dbg]
      ],
    (* If there is no more local variable to add *)
    decomposeSimpleEqus[sys,verb&&!muteOpt]
    ]
  ]
];

Clear[decomposeSimpleEqus];

decomposeSimpleEqus[sys_Alpha`system, verb_]:=
  Module[{paramDom,nbParams,locVars,equList, posList,
	  pos,oldEqus,newDecls,newEqus,i, uses, outuses},
	 paramDom = sys[[2]];
	 nbParams = paramDom[[1]];

	 (* First get a list of the equations of the local variables*)
	 locVars = Map[ First, sys[[5]] ];

         (* We do not consider outputs of uses *)
         (* Modification PQ 20/05/04 *)
         uses = Cases[ sys[[6]], use[___] ];
         outuses = Apply[ Union, Map[ Part[#1,5]&, uses ] ];

         locVars = Complement[ locVars, outuses ];

	 equList = Map[ getEquation[sys,#]&, locVars ];	

	 (* Keep only the ones which will be S/T decomposed: *)
	 equList = Cases[equList, 
			 Alpha`equation[_, Alpha`affine[_Alpha`var,
							m_Alpha`matrix]]
			 /; m[[1]]==m[[2]] ];

	 (* Then remove from this list the equations which are already
	   in either space or time form *)
         posList = Position[equList, 
			    Alpha`equation[lhs_,
					   Alpha`affine[_Alpha`var,
							m_Alpha`matrix]]
			    /; (isTempMatrixQ[m,nbParams] 
				|| isSpaceMatrixQ[m,nbParams] )
			    ];
	 equList = Delete[equList, posList];

         (* Debug option *)
	 If[ verb, Print[" Decomposing the space/time dependencies" ]];

	 (* Now let us decompose the equations in equList *)
	 oldEqus = sys[[6]];
	 newDecls = {} (* the local variables to be added*);
	 newEqus = {}  (* their equations *);

         For[ i=1, i<=Length[equList], i=i+1,
           Module[{equ, m, name, namereg, nameregloc, d, idlist, eq1, eq2, dom1, dom2},
	     equ = equList[[i]];
             If[ verb, Print[ ashow[ equ, silent->True ] ] ];
	     namereg = equ[[1]];
	     name = equ[[2]][[1]][[1]];
	     (* tests added by Tanguy, If the variable as RHS
		is not scheduled, the decomposition is not
		correct *)
	     If[ !MemberQ[getInputVars[sys],name],
             (* The underscore was added, as I got once 
                a nasty conflict with a variable aloc... *) 

(*
			 nameregloc = namereg<>"_loc";
*)
               nameregloc = namereg<>"Xloc";
               If[ verb, 
                 Print["  Space/time dependency to decompose in ", namereg];
                 Print["  Adding local variable ", nameregloc]
               ];

               m = equ[[2]][[2]];
               d = getDeclaration[sys,name];

               (* If we do nothing, m and is i1,i2->...
                  so we replace these indices with the t,p1,p2...*)
               idlist = d[[3]][[2]];
               m = ReplacePart[m, idlist, 3];

               (* Decompose the dependency m into a space dependency and a time dependency *)
               tm = makeTimeMat[m]; If[ dbg, show[ tm ] ];
               sm = makeSpaceMat[m]; If[ dbg, show[ sm ] ];

               (* Remove the equation from the initial equations*)
               oldEqus = Delete[oldEqus, Position[oldEqus, Alpha`equation[namereg,_]]];

               (* and add the two new equations *)
               dom1 = d[[3]]; 
               If[ dbg, Print[ ashow[ dom1, silent->True ] ] ];
               dom2 = DomPreimage[ d[[3]], sm ]; 
               If[ dbg, Print[ ashow[ dom2, silent->True ] ] ];

               newDecls = Prepend[newDecls, 
                         Alpha`decl[ nameregloc, d[[2]], dom2 ]
                        ];

               eq1 = Alpha`equation[ nameregloc, Alpha`affine[Alpha`var[name], sm ] ];
               eq2 = Alpha`equation[ namereg, Alpha`affine[Alpha`var[nameregloc], tm ] ]; 
 
               If[ dbg, Print[ ashow[ eq1, silent->True ] ]; 
                   Print[ ashow[ eq2, silent->True ] ] ]; 
               newEqus = 
                 Join[newEqus,
                   {Alpha`equation[ nameregloc, Alpha`affine[Alpha`var[name], sm ] ],
                    Alpha`equation[ namereg, Alpha`affine[Alpha`var[nameregloc], tm ] ] 
                 }]
            ]
           ]
         ];

         (* Return the new system *)
	 Alpha`system[sys[[1]],sys[[2]],sys[[3]],sys[[4]],
		      Join[newDecls, sys[[5]]],
		      Join[newEqus, oldEqus] 
         ]
  ];  (* End Module *)


(* corrects x[i]=Y into x[i]=Y[i] *)
Clear[correctIdEqs];

Correctideqs[]:=
  Module[{},
	 $result=correctIdEqs[$result]
       ];

correctIdEqs[sys_Alpha`system]:=
  Module[{res,eqs,eqsId,curEq,newEq},
	 res=sys;
	 eqs=sys[[6]];
	 eqsId=Select[eqs,
		      MatchQ[#,Alpha`equation[a_String,
					      Alpha`var[b_String]]]
  &];
	 Do[curEq=eqsId[[i]];
	    newEq=
	      Alpha`equation[curEq[[1]],
			     Alpha`affine[curEq[[2]],
					  idMatrix[
					    getIndexNames[sys,curEq[[1]]],
					    getIndexNames[sys,curEq[[1]]]]]];
	    res=res/.(curEq->newEq),
	    {i,1,Length[eqsId]}];
	 res
       ];

correctIdEqs::args="Wrong arguments.";

correctIdEqs[___]:= Message[correctIdEqs::args];

Clear[makeInputMirrorEqus];
makeInputMirrorEqus[] := makeInputMirrorEqus[{}];
makeInputMirrorEqus[options_List] := 
  Module[{},
	 Alpha`$program =Alpha`$result;
	 Alpha`$result = makeInputMirrorEqus[Alpha`$result,options]
       ];
makeInputMirrorEqus[sys_Alpha`system, options_List]:=
  Module[{verb, inputVars,i, j, newsys, posList, varName, muteOpt},
	 verb = verbose/.options/.Options[toAlpha0v2];
	 muteOpt = mute/.options/.Options[toAlpha0v2];
         If[ muteOpt, verb = False ];

	 inputVars = getInputVars[sys];
	 outputVars = getOutputVars[sys];
	 newsys=sys;
	 (* First remove the input variables appearing in dependencies*)
	 For[i=1, i<=Length[inputVars], i=i+1,
	     varName = inputVars[[i]];
	     j=1;
	     While[ (posList = Position[newsys, 
					Alpha`affine[Alpha`var[varName], _ ]
				      ];
		     (* if it is already the RHS of an equation,
			remove it*)
		     posList = Select[posList,
				      (Length[#]>3)&];
		    posList=!={} ),
		    If[verb,
		       Print["  Adding mirror equation for input ",varName]];
		    newsys = addlocal[newsys,
(*
				      varName<>"_mirr"<>ToString[j],
*)
				      varName<>"XMirr"<>ToString[j],
				      First[posList]];
		    j=j+1;
		  ]
	   ];
	 (*then remove the other input variables *)
	 For[i=1, i<=Length[inputVars], i=i+1,
	     varName = inputVars[[i]];
	     j=1;
	     While[ (posList = Position[newsys, 
					Alpha`var[varName] ];
		     posList = Select[posList,
				      (Length[#]>3)&];
		     posList = Select[posList,
				      (!MatchQ[getPart[newsys,
						       Delete[#,-1]],
					       _Alpha`affine])&];
		     posList=!={} ),
		    If[verb,
		       Print["  Adding mirror equation for input ",varName]];
		    newsys = addlocal[newsys,
(*
				      varName<>"XMirr"<>ToString[j],
*)
				      First[posList]];
		    j=j+1;
		  ]
	   ];
	 (*then we do the same thing for the output variables
	   appearing in the dependencies  *)
   For[i=1, i<=Length[outputVars], i=i+1,
     varName = outputVars[[i]];
     j=1;
     While[ (posList = Position[newsys, Alpha`affine[Alpha`var[varName], _ ]];
	     posList = Select[posList, (Length[#]>3)&];
             posList=!={} ),
       If[verb, Print["  Adding mirror equation for output ",varName]];
       newsys = addlocal[newsys,
(*
				      varName<>"XMirr"<>ToString[j],
*)
         First[posList]
       ];
       j=j+1;
     ]
   ];
   newsys
];

makeInputMirrorEqus[___]:=Message[makeInputMirrorEqus::args];


(*************************************************************)
(*        toAlpha0v2[],      written by Florent              *)

Options[toAlpha0v2] = 
  { verbose->True,initZeroReg->True,debug->False,
    steps -> All, mute -> False };

Clear[toAlpha0v2];

toAlpha0v2[options___Rule] := 
  Module[{},
	 $program = $result;
	 $result = toAlpha0v2[ $result, options ]
       ];

toAlpha0v2::dimPb =
"The local variables should all have the same dimension";

toAlpha0v2[sys:_system, options___Rule] := 
Catch[
Module[
  {verb,loclist,tidx,spaceidx,newsys,dbg,stps,uses,outputsOfUses},
  verb = verbose/.{options}/.Options[toAlpha0v2];
  dbg = debug/.{options}/.Options[toAlpha0v2];

  (* stps is a new option to do only one particular step of toAlpha0v2 *)
  stps = steps/.{options}/.Options[toAlpha0v2];

  (* mute is a new option to send no messages *)
  muteOpt = mute/.{options}/.Options[toAlpha0v2];

  If[ muteOpt, verb = False ];

  Catch[
    (* Remove of loclist the output of uses *)

    (* Time Index *)
    tidx = {1}; (* Assuming only one time index *)

    (* Space indices *)
    spaceidx = Table[i+1, {i, sys[[5]][[1]][[3]][[1]]-sys[[2]][[1]]-1}];
    If[verb, Print["Time index: ",tidx, "  space indices: ",spaceidx]];
    newsys = sys; 

    If[ stps == All || MemberQ[stps,1],

      (* Checking that all variables have the right dimension *)
      (* Get the use statements *)
      uses = Cases[ sys[[6]], use[___] ];
      (* Extract outputs of the uses *)
      outputOfUses = Apply[ Union, Map[ Part[#1,5]&, uses ] ];
      If[ dbg, Print[ "Use statements:\n ", 
		      Map[ ashow[#1,silent->True]&, uses ] ] ];
      If[ dbg, Print[ "Outputs of use statements : ", outputOfUses ] ];
	
      (* Get list of local variables *)
      loclist = Complement[ getLocalVars[sys], outputOfUses ];
      If[ dbg, Print["List of local variables: ", loclist ] ];

      (* Get dimensions of loclists *)
      loclist = Map[ First[ Part[getDeclaration[sys,#],3] ]&, loclist ];
      If[ dbg, Print[ "Their dimension: ", loclist ] ];

      (* Check that all variables have the right dimension *)
      If[ 
        Length[ Union[ loclist  ] ] >1,
        Message[toAlpha0v2::dimPb];
      ];

      If[verb, Print["--- Space time decomposition of the equations (Step 1)"]];
      Check[
        newsys = spaceTimeDecomposition[newsys,tidx,spaceidx,options],
        (* If there is an error, save result in temp0.alpha *)
        asave[newsys, "temp0.alpha"];
        Throw[ Print["File was saved in temp0.alpha"];sys ]
      ];
      If[ dbg, asave[newsys, "temp0.alpha"] ]
    ];

    simplifySystem[newsys];
    asave[newsys, "temp.alpha"];

    (* Check that system is convex *)
    If[ !convexQ[ newsys ], 
      If[ !muteOpt, Print["Warning, tried to convexize system"] ]; 
      newsys = convexizeAll[ newsys ] 
    ];

(* Bug here 
    If[verb, Print["--- Making binary cases"]];
    Check[
      newsys = makeBinaryCases[newsys,options] ,
      asave[newsys, "temp01.alpha"];
      Throw[Print["File was saved in temp01.alpha"];sys]
    ];
 *)

      (* A check point in case of problem *)
      If[ dbg, asave[newsys, "temp01.alpha"] ];
    ];

    If[ stps == All || MemberQ[stps,2],
      If[verb, Print["--- Generating multiplexors (Step 2)"]];
      Check[
        newsys = makeAllMuxControl[ newsys, tidx, spaceidx, options],
        asave[newsys, "temp.alpha"];
        Throw[Print["File was saved in temp.alpha"];sys]
      ];

      (* Simplify System *)
      simplifySystem[ newsys, alphaFormat -> Alpha0 ];
 
      (* Check that system is convex *)
      If[ !convexQ[ newsys ], 
        If[ !muteOpt, Print["Warning, tried to convexize system"] ]; 
        newsys = convexizeAll[ newsys ] 
      ];

      (* A check point in case of problem *)
      If[ dbg, asave[newsys, "temp.alpha"] ];
    ];

    If[ stps == All || MemberQ[stps,3],
      If[verb, Print["--- Pipelining control signals (Step 3)"]];
      Check[
        newsys = pipeAllControl[ newsys, options ],
        asave[ newsys, "temp1.alpha"];
        Print["File was saved in temp1.alpha"];
        newsys
      ];

      (* Simplify System *)
      simplifySystem[ newsys, alphaFormat -> Alpha0 ];

      (* A second check point in case of problem *)
      If[ dbg, asave[newsys, "temp1.alpha"] ]
    ];

(*
    Temporarily skipped... 
    FIXIT. I just wonder if we cannot do AlpHard before we 
    apply totally toAlphard, in particular, separation of 
    dependencies... 
*)

    If[ stps == All || MemberQ[stps,4],
      If[verb, Print["--- Separating space time in dependencies (Step 4)"]];

      Check[
        newsys = decomposeSTdeps[newsys,{options}],
(*
        FIXIT. It is not clear if it is needed to simplify
        the system here or not...
        newsys = simplifySystem[newsys,alphaFormat->Alpha0],
*)
        asave[newsys, "temp2.alpha"];
        Throw[Print["File was saved in temp2.alpha"];sys]
      ];

    ];


    If[ stps == All || MemberQ[stps,5],
      If[verb, Print["--- Generating simple equations (step 5)"]];
      Check[
        newsys = makeSimpleExpr[newsys,options],
        asave[newsys, "temp3.alpha"];
        Throw[Print["File was saved in temp3.alpha"];sys]
      ];
    ];


    If[ stps == All || MemberQ[stps,6],
      If[verb, Print["--- Generating mirror equations (step 6)"]];
      Check[
        newsys = makeInputMirrorEqus[newsys,{options}];
        newsys = correctIdEqs[newsys],
        asave[newsys, "temp4.alpha"];
        Throw[Print["File was saved in temp4.alpha"];sys]
      ];
    ];

    If[verb, Print["--- The End..."]];
    newsys
   ]
];

toAlpha0v2[___]:=Message[toAlpha0v2::args];


(*    From here on, the code is cut from Transformation.m   *)

(*************************************************************) 

(*       Separation of expressions       *)

(* An equation is said to be simple if there is at most one operator
   or one dependency in it  *)


(* 

   needSeparation returns all the expressions contained in the ast that
   need a separation to be simple. 05/07/99 This function was previously
   removed from the toAlpha0 function, I add it again simply to forbid
   the use of expression in the multiplexers. 

   10/4/2001. I modified this function. 
   The idea is to find out not the expression, but the position
   of the expression... PQ.
*)
Clear[findInPosition];
findInPosition[ast:_system, exp1:_, exp2:_]:=
Module[{x,z,y},
  x = Position[ast, exp1, Infinity];
  If[ x === {}, {},
(*
    If[ Length[x]>1, Print["findInPosition::Warning..."] ];
*)
    x = x[[1]]; (* Print[x]; *)
    z = Apply[Part, Prepend[x,ast]]; 
    (* Print["Expression found:\n", z]; *)
    y = Position[ z, exp2, Infinity]; (* Print[y]; *)
    {Join[x,y[[1]]]}
  ]
];
findInPosition[___]:=Message[findInPosition::wrongparams];
findInPosition::wrongparams = "wrong parameters...";



(* needSeparation returns all the expressions contained in the ast
that need a separation to be simple 
05/07/99 This function was previously removed from the toAlpha0
function, I add it again simply to forbid the  use of expression in 
the multiplexers *)

Clear[needSeparation];
needSeparation[] := needSeparation[Alpha`$result];
needSeparation[ast_Alpha`system] := 
Union[
  (* An if statement with a non identity condition *)
  (* ********* Why? *)
(*
  findInPosition[ast,Alpha`if[Alpha`affine[Alpha`var[id_],func_],_,_], 
    Alpha`affine[Alpha`var[id_],func_]],
*)
  (* if with expression inside *)
  (* ********* Why? *)
(*
  findInPosition[ast,Alpha`if[_, Alpha`affine[Alpha`var[id_],func_],_], 
    Alpha`affine[Alpha`var[id_],func_]],
*)
  (* ********* Why? *)
(*
  findInPosition[ast,Alpha`if[_, _, Alpha`affine[Alpha`var[id_],func_]],
    Alpha`affine[Alpha`var[id_],func_]],
*)
  findInPosition[ast,Alpha`if[Alpha`binop[a_,b_,c_],_,_],
    Alpha`binop[a_,b_,c_]],
(* Do not forget if inside ifs *)
  findInPosition[ast,Alpha`if[Alpha`if[a_,b_,c_],_,_],
    Alpha`if[a_,b_,c_]],
  findInPosition[ast,Alpha`if[_,Alpha`binop[a_,b_,c_],_],
    Alpha`binop[a_,b_,c_]],
(* Do not forget if inside ifs *)
  findInPosition[ast,Alpha`if[_,Alpha`if[a_,b_,c_],_],
    Alpha`if[a_,b_,c_]],
  findInPosition[ast, Alpha`if[_,_,Alpha`binop[a_,b_,c_]],
    Alpha`binop[a_,b_,c_]],
(* Do not forget if inside ifs *)
  findInPosition[ast, Alpha`if[_,_,Alpha`if[a_,b_,c_]],
    Alpha`if[a_,b_,c_]],
  findInPosition[ast, Alpha`if[Alpha`unop[a_,b_],_,_], 
    Alpha`unop[a_,b_]],
  findInPosition[ast, Alpha`if[_,Alpha`unop[a_,b_],_], 
    Alpha`unop[a_,b_]],
  findInPosition[ast, Alpha`if[_,_,Alpha`unop[a_,b_]],
    Alpha`unop[a_,b_]],

(* case inside a if (i.e. other form of multiplexer 
	 with expressions inside *)
  findInPosition[ast,
    Alpha`if[_,Alpha`case[
      {___,Alpha`restrict[d_,
      Alpha`affine[Alpha`var[id_],func_]],___}],_],
      Alpha`affine[Alpha`var[id_],func_]
  ],
  findInPosition[ast,
     Alpha`if[_, _, Alpha`case[
       {___,Alpha`restrict[d_,
       Alpha`affine[Alpha`var[id_],func_]],___}]],
     Alpha`affine[Alpha`var[id_],func_]],
  findInPosition[ast, Alpha`if[_,Alpha`case[
       {___,Alpha`restrict[d_,
       Alpha`binop[a_,b_,c_],_],___}],_],
       Alpha`binop[a_,b_,c_]],
  findInPosition[ast, Alpha`if[_,_,Alpha`case[
       {___,Alpha`restrict[d_,
       Alpha`binop[a_,b_,c_]],___}]],
       Alpha`binop[a_,b_,c_]],
  findInPosition[ast, Alpha`if[_,Alpha`case[
       {___,Alpha`restrict[d_,
       Alpha`unop[a_,b_],_],___}],_],
       Alpha`unop[a_,b_]],
  findInPosition[ast, 
     Alpha`if[_,_,Alpha`case[{___,Alpha`restrict[d_,Alpha`unop[a_,b_]],___}]],
     Alpha`unop[a_,b_]],
  findInPosition[ast, Alpha`if[Alpha`case[b_],_,_],
		 Alpha`case[b_]]
 (* special treatment for calls, always extract them, execpt if they are like: x=call[...] 
  to be implemented soon *)
 ,
 posCall=Map[Drop[#,-1] &,Position[ast,call,Infinity]];
 posCall2=Select[posCall,Length[#]>3 &];
 posCall2 
  ];

Clear[makeOneSimpleExpr];

makeOneSimpleExpr[sys_Alpha`system, p:_, listeVar_List, opts:___Rule]:=
  Module[{nom,l,f,vrb, muteOpt},
    vrb = verbose/.{opts}/.Options[ toAlpha0v2 ];
    muteOpt = mute/.{opts}/.Options[ toAlpha0v2 ];
    If[ muteOpt, vrb = False ];

    nom = GenereNomVar["T","Sep",listeVar];
    If[ p==={},
      sys,
      If[ vrb, Print[nom, " generated ..."] ];
      decompose[sys,
        p,
        nom]
    ]
 ];

Clear[makeSimpleExpr,makeSimpleExpr1];

makeSimpleExpr[opts:___Rule]:=
Module[{},
  $program=Alpha`$result;
  $result=makeSimpleExpr1[$result,opts]
];

makeSimpleExpr[sys1_Alpha`system,opts:___Rule]:=
  makeSimpleExpr1[sys1,opts];

makeSimpleExpr[___]:=Message[makeSimpleExpr::args];

makeSimpleExpr1[Alpha`system[id_,par_,
			     {in___},{out___},{loc___},
			     eqn_], opts:___Rule]:=
Module[{syst1,listExpr,oneExpr,listNoms,dbg},
  dbg = debug/.{opts}/.Options[ toAlpha0v2 ];
  syst1=Alpha`system[id,par,{in},{out},{loc},eqn];

(*
  Modification by P. Quinton, April 10, 2001. In the previous
  version, one located the expressions to be separated, not 
  their position. So, it could happen that the expression 
  separated was not the one that was found by needSeparation, 
  hence a bug. Here, needSeparation has been modified to 
  return a list of positions. Only the first one is separated, 
  as the separation may change the structure of the system, 
  and a position may become meaningless. The process is 
  iterated until no more expression has to be separated. 
  Note that this process may create several new names for
  same expressions... This could be optimized somehow...
*)

  Catch[
    listExpr = needSeparation[syst1];
    (* Print["call: ",Map[Drop[#,-1] &,Position[syst1,call,Infinity]]]; *)

    While[(listExpr!={}),
      If[ dbg, Print["Expressions needing separation: ",
                   listExpr]];
      oneExpr=listExpr[[1]];
      If[dbg, Print["Expression: ",oneExpr]];
      llnoms = Join[ Cases[syst1[[5]], 
                       Alpha`decl[id2_, _, _] -> id2], 
                     Cases[syst1[[3]], 
                       Alpha`decl[id2_, _, _] -> id2],
                     Cases[syst1[[4]], 
                       Alpha`decl[id2_, _, _] -> id2]];
      syst1 = makeOneSimpleExpr[syst1,oneExpr,llnoms,opts];
      listExpr = needSeparation[syst1];
    ];
    syst1
  ]
];
makeSimpleExpr1[___]:=Message[makeSimpleExpr1::args];


(***********************************************************)
(***********************************************************)

(* GENERE UNE DECLARATION *)

Clear[ModifieIneq];
ModifieIneq[{{a_,b_,c_,d_},suite___},temp_,spat1_,spat2_]:= Join[{{a,b,c,d-(b*temp)-(c*spat1)}},ModifieIneq[{suite},temp,spat1,spat2]];
ModifieIneq[{{a_,b_,c_,d_,e_},suite___},temp_,spat1_,spat2_]:= Join[{{a,b,c,d,e-(b*temp)-(c*spat1)-(d*spat2)}},ModifieIneq[{suite},temp,spat1,spat2]];
ModifieIneq[{},temp_,spat1_,spat2_]:={};

Clear[ModifieConv];
ModifieConv[{{a_,b_,c_,d_},suite___},temp_,spat1_,spat2_]:= Join[{{a,b+temp,c+spat1,d}},ModifieConv[{suite},temp,spat1,spat2]];
ModifieConv[{{a_,b_,c_,d_,e_},suite___},temp_,spat1_,spat2_]:= Join[{{a,b+temp,c+spat1,d+spat2,e}},ModifieConv[{suite},temp,spat1,spat2]];
ModifieConv[{},temp_,spat1_,spat2_]:={};

Clear[FabriqueDecl];
FabriqueDecl[Alpha`decl[A_,B_,
			Alpha`domain[C_,D_,
				     {Alpha`pol[E_,F_,G_,H_,J_,K_]}]],
	     temp_,
	     spat1_,
	     spat2_,
	     NN_]:=
  Alpha`decl[NN,B,
	     Alpha`domain[C,D,
			  {Alpha`pol[E,F,G,H,
				     ModifieIneq[J,temp,spat1,spat2],
				     ModifieConv[K,temp,spat1,spat2]]}]];

Clear[GenereDecl];
GenereDecl[id_,temp_,spat1_,spat2_,NN_,Alpha`system[nom_,par_,{in___},{out___},{loc___},{eqs___}]]:=
FabriqueDecl[getDeclaration[Alpha`system[nom,par,{in},{out},{loc},{eqs}],id],temp,spat1,spat2,NN];


Clear[FabriqueDecl2];
FabriqueDecl2[Alpha`decl[A_,B_,
			Alpha`domain[C_,D_,E___]],
	      newDom_,
	      NN_]:=
  Alpha`decl[NN,B, newDom];

Clear[GenereDecl2];
GenereDecl2[id_,temp_,spat1_,spat2_,NN_,
	    Alpha`system[nom_,par_,{in___},{out___},{loc___},{eqs___}],
	    newDom_]:=
FabriqueDecl2[getDeclaration[Alpha`system[nom,par,{in},{out},{loc},{eqs}],id],
	      newDom,NN];


(* GENERE UNE DEFINITION TEMPORELLE ou SPATIALE*)

Clear[GenereDef]
GenereDef[id_,temp_,spat1_,spat2_,NN_,Alpha`matrix[a_,dim_,ll_,b_]]:=
If[dim===3,
Alpha`equation[NN,Alpha`affine[Alpha`var[id],Alpha`matrix[3,3,ll,{{1, 0, -temp}, {0, 1, -spat1}, {0, 0, 1}}]]],
If[dim===4,
Alpha`equation[NN,Alpha`affine[Alpha`var[id],Alpha`matrix[4,4,ll,{{1, 0, 0, -temp}, {0, 1, 0, -spat1}, {0, 0, 1, -spat2}, {0, 0, 0, 1}}]]],
Print["Error : dimension must be 2 or 3"]]]


(* GENERE UN NOM DE VARIABLE *)

Clear[GenereNomVar]
GenereNomVar[nom_,ext_,ll_] := Block [{x = 1, NN},
( NN = StringJoin[ToString[nom],ToString[ext],ToString[x]];
 While[ Intersection[{NN},ll ] ==={NN},
(x = x + 1;
NN = StringJoin[ToString[nom],ToString[ext],ToString[x]])];
Return[NN])]
		   

(***********************************************************)
(***********************************************************)

Clear[ModifieListeMatrix]
ModifieListeMatrix[{{x1_,y1_,z1_,v1_},{x2_,y2_,z2_,v2_},{x3_,y3_,z3_,v3_},{x4_,y4_,z4_,v4_}}]:={{x1,y1,z1,0},{x2,y2,z2,v2},{x3,y3,z3,v3},{x4,y4,z4,v4}}
ModifieListeMatrix[{{x1_,y1_,z1_},{x2_,y2_,z2_},{x3_,y3_,z3_}}]:={{x1,y1,0},{x2,y2,z2},{x3,y3,z3}}

Clear[ModifieListeMatrixTime]
ModifieListeMatrixTime[{{x1_,y1_,z1_,v1_},
			{x2_,y2_,z2_,v2_},
			{x3_,y3_,z3_,v3_},
			{x4_,y4_,z4_,v4_}}]:=
  {{x1,y1,z1,v1},
   {x2,y2,z2,0},
   {x3,y3,z3,0},
   {x4,y4,z4,v4}}

ModifieListeMatrixTime[{{x1_,y1_,z1_},
			{x2_,y2_,z2_},
			{x3_,y3_,z3_}}]:=
  {{x1,y1,z1},
   {x2,y2,0},
   {x3,y3,z3}}

(* TR 05/05/95, add localvars parameter *)
(* ExpAtraiter returns a list:  *)
(* -the original dep function (when there are space AND time dependence *)
(* -the value of the time dep (?)  *)
(* -The matrix used for the space dep only *)
(* -the name  of the variable on which apply these deps *)
(* added a fidth arresult: the martrix used for the time dep only *)
(* added a six and seventh result: value of the two space deps *)
(* the second is 0 if there is only one space dim *)
Clear[ExpATraiter]
ExpATraiter[{Alpha`equation[id1_,exp_]},localvars_]:= 
  Block[{trouve = False, ll, doublet},
	If[(Intersection[localvars,{id1}] !={}),
	   (ll = Cases[{exp},
		       Alpha`affine[Alpha`var[id2_],
				    Alpha`matrix[a_,b_,c_,d_]
				  ]-> 
				    {id2, d, 
				     Alpha`affine[Alpha`var[id2],
						  Alpha`matrix[a,b,c,d]], 
				     a, b, c, id2},
		       Infinity];
	    While[ (ll !={}) && (! trouve),
		   (doublet = ll[[1]];
		    If[(Intersection[localvars,{doublet[[1]]}] !={}),
		       If[listeSpatTempQ[doublet[[2]]],
			  (trouve = True;
			   (* TR *)
			   Return[{doublet[[3]],
				   -Last[First[doublet[[2]]]],
				   Alpha`matrix[doublet[[4]],
						doublet[[5]],
						doublet[[6]],
						ModifieListeMatrix[doublet[[2]]]],
				   doublet[[7]],
				   Alpha`matrix[doublet[[4]],
						doublet[[5]],
						doublet[[6]],
						ModifieListeMatrixTime[doublet[[2]]]],
				   -Last[doublet[[2,2]]],
				   If [doublet[[4]]==4,
				       -Last[doublet[[2,3]]],
				       0]}]),
			  ll = Drop[ll,1],
			  trouve = True] (* Cas d'erreur *),
		       ll = Drop[ll,1]])];
	    If[ll==={}, Return[{}], Null(* rien *)]),Null
	   (* rien *)] ]






(* TR 05/05/95, add localvars parameter *)
 (* replace Alpha`localvares by     *)
(* Cases[{loc}, Alpha`decl[id2_, _, _] ->   id2] *)
(* 20/07/95 modify this function so that the registers *) 
(* suit all in the cells and not outside *)


Clear[depSpatTempDec]

depSpatTempDec[sys_Alpha`system]:=
  depSpatTempDec1[{},sys]


depSpatTempDec[]:=
  (Alpha`$program = Alpha`$result ;
   Alpha`$result = depSpatTempDec1[{},
				  Alpha`$program])


depSpatTempDec1[equats_,
	       Alpha`system[id_,par_,{in___},
			    {out___},{loc___},
			    {Alpha`equation[id1_,exp_],suite___}]]:= 
  Module[{Ndecl,eqs,llnoms,Nexp,ll,NN,NewDom,sys},
	(Ndecl = {loc};
	 (* TR *)
	 sys = Alpha`system[id,par,{in},
			      {out},{loc},
			      {Alpha`equation[id1,exp],suite}];
	 eqs = equats;
	 llnoms = Join[ Cases[{loc}, Alpha`decl[id2_, _, _] -> id2], 
			Cases[{in}, Alpha`decl[id2_, _, _] -> id2],
			Cases[{out}, Alpha`decl[id2_, _, _] -> id2]];
	 
	 Nexp = Alpha`equation[id1,exp];
	 While[ (ExpATraiter[{Nexp},
			     Cases[{loc}, 
				   Alpha`decl[id2_, _, _] ->   id2] ]
		 !={}
		 ),
		(ll = ExpATraiter[{Nexp},
				  Cases[{loc}, Alpha`decl[id2_, _, _]
					->   id2]
				];
		 NN = GenereNomVar[ll[[4]],"reg",llnoms];
		 llnoms = Join[llnoms,{NN}];
(*	TR	 eqs = Join[eqs, 
			    {GenereDef[ll[[4]], ll[[2]], 0, 0,
				   NN, ll[[3]]]}
				   ]; *)
		 eqs = Join[eqs, 
			    {GenereDef[ll[[4]],0, ll[[6]], ll[[7]],
				   NN, ll[[3]]]}
				   ];
(* Here I change, I want that the domain of the new variable *) 
(* fit exactly it use necessary, thus I will use getContextDomain *)
(* to know where I must define the new variable *)
(* it is the image of the context of the expression by the *)
(* temporal dependance  *)
                 NewDom=DomImage[getContextDomain[
		   Position[$result,ll[[1]],Infinity][[1]]],ll[[5]]];
		 Ndecl = Join[Ndecl, 
			      {GenereDecl2[ll[[4]], 0, 
					  ll[[6]], ll[[7]], NN,sys,NewDom]}];

(*   TR              Ndecl = Join[Ndecl, 
			      {GenereDecl[ll[[4]], ll[[2]], 
					  0, 0, NN, 
					  Alpha`system[id,par,
						       {in},{out},
						       {loc},
						       {Alpha`equation[id1,
								       exp],
							suite}]]}
                                                           ]; *)  	
(*TR		 Nexp = (Nexp /. { ll[[1]] :>
				  Alpha`affine[Alpha`var[NN],
					       ll[[3]]],
				  X_ :> X }) TR*)
		 Nexp = (Nexp /. { ll[[1]] :>
				  Alpha`affine[Alpha`var[NN],
					       ll[[5]]],
				  X_ :> X })
		 ) 
		];
	 eqs = Join[eqs,{Nexp}];
	 depSpatTempDec1[eqs,Alpha`system[id,par,{in},{out},Ndecl,{suite}]]) ]

depSpatTempDec1[eqs_,Alpha`system[id_,par_,{in___},{out___},{loc___},{}]]:=
  Alpha`system[id,par,{in},{out},{loc},eqs]






(***********************************************************)
(***********************************************************)
(* ENSEMBLE DE FONCTIONS POUR LE RENOMMAGE DES IFS  *)
(***********************************************************)
(***********************************************************)
(* TR 05/05/95 add localvars parameter                     *)
Clear[ResExpATraiterIf]
ResExpATraiterIf[Alpha`restrict[dom1_,
				Alpha`if[_,
					 Alpha`affine[varOrConst_,
						      Alpha`matrix[a_,b_,c_,d_]],
					 _]
			      ],
	                       localvars_]:=
  Block[{isVar,id2},
	(isVar=MatchQ[varOrConst,Alpha`var[id2_]];
	If [isVar,	
	    {If[(Intersection[localvars,{id2}] !={}), -Last[d[[1]]],0],
	     If[(Intersection[localvars,{id2}] !={}),-Last[d[[2]]],0],
	     If[(b===4) && (Intersection[localvars,{id2}] !={}),-Last[d[[3]]],0],
	     Alpha`affine[Alpha`var[id2],Alpha`matrix[a,b,c,d]],
	     id2,
	     dom1,
	     Alpha`matrix[a,b,c,d]},
	    {0,
	     0,
	     0,
	     Alpha`affine[varOrConst,Alpha`matrix[a,b,c,d]],
	     varOrConst[[1]],
	     dom1,
	     Alpha`matrix[a,b,c,d]}])]

Clear[ExpATraiterIf]
ExpATraiterIf[{Alpha`equation[id1_,exp_]},localvars_]:= 
  ResExpATraiterIf[
    First[
      Union[Cases[{exp},
		  Alpha`restrict[dom1_,
				 Alpha`if[_,Alpha`affine[Alpha`var[id2_],
							 Alpha`matrix[a_,b_,c_,d_]],
					  _]],
		  Infinity],
	    Cases[{exp},
		  Alpha`restrict[dom1_,
				 Alpha`if[_,Alpha`affine[Alpha`const[id2_],
							 Alpha`matrix[a_,b_,c_,d_]],
					  _]],
		  Infinity]]],
      localvars]


Clear[PrendType]

PrendType[Alpha`decl[a_,b_,c_]]:= b

Clear[RenommageIf]


RenommageIf[]:=(Alpha`$program = Alpha`$result ;
		Alpha`$result = RenommageIf[{},Alpha`$program])

RenommageIf[equats___,
	    Alpha`system[id_,par_,{in___},{out___},{loc___},{Alpha`equation[id1_,exp_],suite___}]
]:=Block[{Ndecl,eqs,llnoms,Nexp,elt,NN,typeb,id0,id2,id3},
      (Ndecl = {loc};
       eqs = equats;
       llnoms = Join[ Cases[{loc}, Alpha`decl[id0_, _, _] -> id0], 
		      Cases[{in}, Alpha`decl[id2_, _, _] -> id2],
		      Cases[{out}, Alpha`decl[id3_, _, _] -> id3]];
       Nexp = Alpha`equation[id1,exp];
       While[ (ExpATraiterIf[{Nexp},
			     Cases[{loc}, Alpha`decl[id2_, _, _] -> id2]]
	       !={}),
	      (elt = ExpATraiterIf[{Nexp},
				   Cases[{loc}, 
					 Alpha`decl[id2_, _, _] ->
					   id2]];
	       NN = GenereNomVar[elt[[5]],"int",llnoms];

	       llnoms = Join[llnoms,{NN}];
	       eqs = Join[eqs, {Alpha`equation[NN,elt[[4]]]}];
		   If[(Intersection[Cases[{loc}, Alpha`decl[id2_, _, _] 
					  -> id2],{elt[[5]]}] 
		       !={}),
		      (Ndecl = Join[Ndecl, 
				    {GenereDecl[elt[[5]],
						elt[[1]],
						elt[[2]],
						elt[[3]],
						NN,
						Alpha`system[id,
							     par,
							     {in},
							     {out},
							     {loc},
							     {Alpha`equation[id1,
									 exp],
							      suite}]]}];
		       If [MatchQ[elt[[5]],Alpha`var[_]],  (* replace a
						      variable *) 
			     Nexp = (Nexp /.  {elt[[4]] :>
					       Alpha`var[NN],
					       X_ :> X }),
			 (pos1=(Position[Nexp,lt[[4]]])[[1]];
			    Nexp=ReplacePart[Nexp,Alpha`var[NN],pos1])]
		       ),
		      (typeb = PrendType[getDeclaration[Alpha`system[id,
								     par,
								     {in},
								     {out},
								     {loc},
								     {Alpha`equation[id1,
										     exp],
								      suite}],id1]];
		       Ndecl = Join[Ndecl, {Alpha`decl[NN,typeb,elt[[6]]]}];
		      If [MatchQ[elt[[5]],Alpha`var[_]],  (* replace a
						      variable *) 
		        Nexp = (Nexp /. {elt[[4]] :> Alpha`var[NN],X_
					 :> X}),
			(pos1=(Position[Nexp,elt[[4]]])[[1]];
			    Nexp=ReplacePart[Nexp,Alpha`var[NN],pos1])]
					 )
		      ]
	       )
	      ];
       eqs = Join[eqs,{Nexp}];
       RenommageIf[eqs,Alpha`system[id,par,{in},{out},Ndecl,{suite}]])
      ]

RenommageIf[eqs_,Alpha`system[id_,par_,{in___},{out___},{loc___},{}]]:=
Alpha`system[id,par,{in},{out},{loc},eqs]


(* Function used for the reuseCommonExpr function *)
getNumBerUse[sys_Alpha`system,expr_]:= 
  Module[{},
	 If [!MatchQ[expr,Alpha`var[___]],	     
	     Length[Position[sys,expr]],
	     1 (* Do not add new variable in that case *)]]

getNumBerUse::args="Wrong arguments.";

getNumBerUse[a___]:= getNumBerUse::args

(* reuseCommonExpr attempts to simplify an alpha system by detecting 
   reuse of subexpression and introducing a new variable for this
   reuse *)
Options[ reuseCommonExpr ] = {verbose->False};

reuseCommonExpr[opts:___Rule]:=
Module[{newLib,res},
   (* Do the operation on the whole library... *)
   newLib = 
    Check[
      Map[reuseCommonExpr[#1,opts]&,$library],
      $library (* If there was an error, return the library *)
    ];

   (* Do the same to $result *)
   res = Check[reuseCommonExpr[$result,opts],$result];
   (* updating $result *)
   $library=newLib;
   $result=res;
   newLib
];

(* Minor edition corrections *)
reuseCommonExpr[sys_Alpha`system,opts:___Rule]:=
Module[{newsys,listNumBerReuse,listRHS,exprToReuse,
  nameVar,counter,originalVarNum,finalVarNum,vrb},

  vrb = verbose/.{opts}/.Options[ reuseCommonExpr ];

  (* First heuristic: check the complete RHS of equalities     *) 
  originalVarNum = Length[sys[[6]]];

  (* Get all the RHS, excuding uses *)
  If[ vrb, Print["In system ", sys[[1]], " ..."] ];
    listRHS = Union[Map[Part[#,2] &,
		   DeleteCases[sys[[6]],
			     Alpha`use[___]]]];

  (* Get the number of reuses *)
  listNumBerReuse = 
    Map[getNumBerUse[sys,#] &,
       (* for each RHS of equation *)
	 listRHS];


  newsys=sys; (* Save old system *)

  (* count the number of replacement *)
  counter = 0;
  Do[ 
    If[ listNumBerReuse[[i]]>=2,
       counter = counter + 1;
       exprToReuse =  listRHS[[i]];
       nameVar=getNewName[newsys,"expr"<>ToString[counter]];
       If[ vrb, Print["      Expression ", 
         show[exprToReuse,silent->True] ,
         " used ", ToString[listNumBerReuse[[i]]]," times "]
      ];
      newsys = 
      Check[
        reuseCommonExpr[newsys,nameVar, exprToReuse]
      ,
        newsys
      ];
      ],
    {i,1,Length[listRHS]}
  ];
	 
  (* Clean system *)
  If[ counter===0,
     If[ vrb, Print[" no simplification "] ],
     If[ vrb, 
               Print["eliminating redundant variables, please wait ..."] ];
       newsys=removeIdEqus[newsys];
       finalVarNum = Length[newsys[[6]]];
     If[ vrb,
       Print[originalVarNum - finalVarNum," variable eliminated"] 
     ];
  ];
  newsys
];

reuseCommonExpr::expNotFound = " expression `1` was not found ";

reuseCommonExpr[sys_Alpha`system,nameVar_String,expr_,opts:___Rule]:=
  Module[{positionExpr,newsys,vrb},

    vrb = verbose/.{opts}/.Options[reuseCommonExpr];
    positionExpr = Position[sys,expr];
    newsys=sys;
    If[ Length[positionExpr]===0,
      Message[reuseCommonExpr::expNotFound,expr],
      newsys = addlocal[newsys,nameVar,positionExpr];
    ]; 
    newsys];


reuseCommonExpr::args = "Wrong arguments.";

reuseCommonExpr[a___]:=Message[reuseCommonExpr::args]


(* local function that are usefull for DEMOS *)
(* Tanguy Risset 15/04/95 *)
(* replace * by And *)



(* * -> and *)
Clear[changeTimeInAnd]

changeTimeInAnd[] := changeTimeInAnd[Alpha`$result]

changeTimeInAnd[syst_Alpha`system]:=
  syst /. {Alpha`mul->Alpha`and}

(* and -> * *)
Clear[changeAndInTime]

changeAndInTime[] := changeAndInTime[Alpha`$result]

changeAndInTime[syst_Alpha`system]:=
  syst /. {Alpha`and->Alpha`mul}

(* + -> or *)
Clear[changePlusInOr]

changePlusInOr[] :=changePlusInOr[Alpha`$result]

changePlusInOr[syst_Alpha`system]:=
  syst /. {Alpha`add->Alpha`or}

(* or -> + *)
Clear[changeOrInPlus]

changeOrInPlus[] :=changeOrInPlus[Alpha`$result]

changeOrInPlus[syst_Alpha`system]:=
  syst /. {Alpha`or->Alpha`add}

(* boolean -> integer *)
(* These two function are dangerous *)
(* Where are the real boolean (control signal) ? *)
Clear[changeBooleanInInteger]

changeBooleanInInteger[] := changeBooleanInInteger[Alpha`$result]

changeBooleanInInteger[syst_Alpha`system]:=
  syst /. {Alpha`boolean->Alpha`integer}

(* integer 0> boolean *)
Clear[changeIntegerInBoolean]

changeIntegerInBoolean[] := changeIntegerInBoolean[Alpha`$result]

changeIntegerInBoolean[syst_Alpha`system]:=
  syst /. {Alpha`integer->Alpha`boolean}

(* integer syst ->  boolean syst *)
Clear[integerToBooleanSyst]

integerToBooleanSyst[] := integerToBooleanSyst[Alpha`$result]

integerToBooleanSyst[sys_Alpha`system]:=
  (Alpha`$program = Alpha`$result;
  sys1=changeTimeInAnd[sys];
  sys2=changePlusInOr[sys1];
  Alpha`$result=sys2)

(* boolean syst -> integer syst *)
Clear[booleanToIntegerSyst]

booleanToIntegerSyst[] := booleanToIntegerSyst[Alpha`$result]

booleanToIntegerSyst[sys_Alpha`system]:=
  (Alpha`$program = Alpha`$result;
  sys1=changeAndInTime[sys];
  sys2=changeOrInPlus[sys1];
  Alpha`$result=sys2)


Clear[splitMax]

splitMax[]:= 
  Module[{res},
	 res=splitMax[$result];
	 If [MatchQ[res,Alpha`system[___]],
	     $result=res,
	     $result]
       ]

splitMax[sys1:_Alpha`system]:= 
  Catch[
    Module[{res},
	   res=sys1/.(Alpha`call["Max4",{par1_,par2_,par3_,par4_}]->
		      Alpha`binop[max,Alpha`binop[max,par1,par2],
				       Alpha`binop[max,par3,par4]]);
	   res]
  ]

splitMax::wrongArg="wrong Argument for splitMax"
splitMax[___]:=Message[splitMax::wrongArg]


			

End[]
EndPackage[]

