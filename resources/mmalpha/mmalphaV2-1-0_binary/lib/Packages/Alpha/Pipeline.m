(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : The Alpha Contributors 
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
 BeginPackage["Alpha`Pipeline`", {"Alpha`Domlib`",
			 	 "Alpha`",
				 "Alpha`Options`",
				 "Alpha`Matrix`",
				 "Alpha`Tables`",
				 "Alpha`Semantics`",
				 "Alpha`Substitution`",
                                 "Alpha`Normalization`"
				 }]

(* $Id: Pipeline.m,v 1.4 2010/04/14 17:59:22 quinton Exp $

   changelog:
   6/15/1993, Z. Chamski:    moved 'lookUpFor' into package "Alpha`Tables`"
   11/30/1993, Z. Chamski:   merged 'pipeall into the package. Added single
			       string pipeline specification to 'pipeline'.
			       Added "Alpha`" context prerequisite.
   20/03/95   D. Wilde:       Version 2.3
   06/08/95   F. de Dinechin: Modified to handle parameters 
   07/18/95   P. Quinton: a few modifs in PipeAll. 
   14/01/97   T. Risset writing of a doc wit precise semantic,
               corrections according to this doc

 Standard head for CVS

	$Author: quinton $
	$Date: 2010/04/14 17:59:22 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Pipeline.m,v $
	$Revision: 1.4 $
	$Log: Pipeline.m,v $
	Revision 1.4  2010/04/14 17:59:22  quinton
	Minor modifications
	
	Revision 1.3  2008/12/29 17:38:23  quinton
	Minor corrections.
	
	Revision 1.2  2008/04/18 17:32:41  quinton
	Correction of a bug (see movementDomain)
	
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.47  2003/08/01 14:11:09  quinton
	Corrections in Pipeline.m. pipeall was modified in order to accept arguments
	either in string form or as asts. test of Pipeline was made.
	
	Revision 1.46  2003/07/16 13:06:50  quinton
	Minor edition done while correcting a bug found using pipeIO. In fact, this
	bug concerned Alpha.m
	
	Revision 1.45  2002/02/27 09:51:01  risset
	added a message for pipeIO when an error occured (previous message was not clear)
	
	Revision 1.44  2002/01/17 10:29:48  risset
	modify the Pipeline.m package for pipall with boundary
	
	Revision 1.43  2001/08/16 07:55:51  quinton
	Some cosmetic changes, and correction of some bugs.
	
	Revision 1.39  2000/02/14 08:25:21  risset
	correct a bug in DomEqulities
	
	Revision 1.38  1999/07/21 15:32:55  risset
	commited for GNU release 1.0
	
	Revision 1.37  1999/05/27 09:31:44  risset
	commited docs
	
	Revision 1.36  1999/05/10 13:14:14  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.35  1999/03/02 15:49:24  risset
	added GNU software text in each packages
	
	Revision 1.34  1998/12/11 16:08:34  risset
	corrected a bug in Pipeline.m
	
	Revision 1.33  1998/11/27 12:24:59  alpha
	nothing
	
	Revision 1.32  1998/11/27 12:20:17  risset
	commit by tanguy, corrected schedule, added sundeep packages and correction by Manju
	
	Revision 1.31  1998/05/04 11:46:30  risset
	commited tag v0-9-1

	Revision 1.30  1998/04/10 08:03:19  risset
	updated ToAlpha0v2 and Alphard.m

	Revision 1.29  1998/02/16 17:06:57  risset
	Packages pass all tests

	Revision 1.28  1997/07/07 17:41:31  risset
	 achanged a message and corrected a little bug

	Revision 1.27  1997/07/03 07:44:31  fdupont
	fixed the bug about scalar types in pipeIO

	Revision 1.26  1997/06/19 17:01:20  fdupont
	creputain de foutu bug a la con (un sys oublie dans un getDeclaration dans pipeline) corrige apres trois heures de recherches, je hais mathematica. Florent

	Revision 1.25  1997/05/22 15:18:07  alpha
	yeh

	Revision 1.24  1997/05/19 10:41:21  risset
	corrected exported bug in depedancies

	Revision 1.23  1997/05/16 13:49:52  risset
	corrected PipeControl.m

	Revision 1.22  1997/05/15 16:05:05  risset
	change needs order

	Revision 1.21  1997/05/14 16:47:38  risset
	added the VHDL demo

	Revision 1.20  1997/05/13 12:29:30  alpha
	 little things

	Revision 1.19  1997/05/13 10:06:09  risset
	 added a little change in the calling form

	Revision 1.18  1997/04/22 07:54:41  risset
	Added multiDim Scheduling

	Revision 1.17  1997/04/10 09:19:41  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.16  1997/04/08 13:05:41  risset
	 tanguy's changes

	Revision 1.15  1997/02/05 16:21:44  risset
	Correction of the Pipeline package

	Revision 1.14  1996/06/24 13:54:49  risset
	added standard head comments for CVS



*)
Pipeline::usage =
"Package. Contains the definition of the pipeline transformation.
Containes the funcitons pipeline, pipeall, pipeIO"

pipeline::usage =
"pipeline[position,pipespec] pipelines in system $result expression
given by position according to pipeline specification pipespec,
and puts the result in $result. pipeline[sys, position,pipespec] does
the same to program contained in symbol sys. Parameter pipespec
provides the name of the new variable, and the pipeline direction in
the textual form \"newname.translation\" (example: \"B.(i,j->i,j+1)\"
means that new pipeline variable is B and data movement is (0,1)).
Parameter position gives the position of the expression in the
program, using the conventions of the Mathematica function Position
(see getPart)."

pipeline::translation = 
"Error, matrix is not a translation, transformation aborted.";
pipeline::wrngname = 
"Warning, name of new variable already used";
pipeline::args = 
"Error, in arguments of pipelines,possible arguments forms are: \n
pipeline[occur:List[_Integer..],pipeSpec_String]\n 
pipeline[sys_Alpha\`system,occur:List[_Integer..],pipeSpec_String]\n
pipeline[sys:Alpha\`system,occur:List[_Integer..],newVarName_String,
pipelineVector_Alpha\`matrix]"

pipeline::parseError = 
"Error, parse error in arguments,transformation aborted";
pipeline::noCheck = "Warning, the expression to pipeline do not have 
the form exp.(z->f(z)), correctness of the pipeline not checked."
pipeline::wrongDim = 
"Error, wrong dimension for the pipeline vector,transformation aborted"
pipeline::wrongPipeVect = 
"Error: impossible to pipeline along this direction (The pipeline
vector is not in the kernel of the dependance uniformized).
Transformation aborted."
pipeline::bdintersec = 
"Error: bounding domain is probably wrong."
pipeline::wrgocc = 
"Error: occurence description is incorrect."
pipeline::wrgpipe1 = 
"Error: pipe expression is incorrect."

pipeall::usage =
"pipeall[var, exp, pipespec] pipelines in program $result all
occurrences of expression exp within equation whose left-hand side is
var according to pipeline specification pipespec, and returns the
result in $result.  pipeall[sys, var, exp, pipespec] does the
same to program contained in symbol sys. 
pipeall[var, exp, pipespec, bd] pipelines exp of var definition 
using pipespec, but extend the domain of pipeline to the boundary
given by domain bd. Parameter var can be either a single variable, 
a list of variables, or the empty list, in which case the expression
is pipelined in all the program simultaneously.
The parameters can be specified either in textual form or as 
AST. For example, 
pipeall[\"X\",\"a.(i,j,k->i,j+1,k)\",\"A.(i,j,k->i,j+1,k)\"] 
pipes all occurences of \"a.(i,j,k->i,j+1,k)\" in the definition of X, 
using the pipeline specification \"A.(i,j,k->i,j+1,k)\". The pipeline
specification contains the name to be used for the pipeline variable
(here \"A\"), and the direction of pipeline given as a translation
(here, vector (0,1,0)). Similarly, 
pipeall[\"X\",\"a.(i,j,k->i,j+1,k)\",\"A.(i,j,k->i,j+1,k)\", 
\"{i,j,k|i>=0}\"] 
pipes all occurences of \"a.(i,j,k->i,j+1,k)\" in the definition of X, 
using the pipeline specification \"A.(i,j,k->i,j+1,k)\", withing 
the boundary \"{i,j,k|i>=0}\"].
In case of error, pipeall returns Null, and leaves $result unchanged. 
For programming purposes, pipeall may 
also be called with the form pipeall[sys,var,expression,pipespec], 
where expression and pipeline are abstract syntax trees. Parameter
expression can also be replaced by the occurrence number of the 
expression. See also the function pipeInfo which gives hints about
which pipeline commands to perform."

pipeAll::usage = pipeall::usage;

(* Error messages *)
pipeall::nodecl = "variable `1` not declared";
pipeall::wrsubexp = "Error while parsing sub-expression to be pipelined.";
pipeall::expnf = "sub-expression to be pipelined was not found";
pipeall::expnfInVar = 
"In var `1`, sub-expression to be pipelined was not found";

pipeall::expperr ="Error while parsing pipeline specification.";
pipeall::noCheck = 
"Warning, the pipeline specification does not have the form
exp.(z->f(z)), correctness of the pipeline not checked."
pipeall::wrongDim = 
"Error, Wrong dimension for the pipeline vector, transformation aborted";
pipeall::wrongPipeVect = 
"Error: impossible to pipeline along this direction (The pipeline
vector is not in the kernel of the dependance uniformized),
transformation aborted."

pipeIO::usage =

"pipeIO[var,exp,pipespec,boundary] pipelines in $result I/O expression
exp occuring in variable var to plane boundary according to pipeline
specification pipespec. pipeIO[sys,var,exp,pipespec,boundary] does the
same to program contained in symbol sys. Parameters var and exp are
strings. Parameter pipespec is the pipeline specification string in
the form \"newVar.direction\" (example: \"X1.(t->t-1)\").  Parameter
boundary is given in textual form (example: \" \{i,j | 2i+3j+4>=0
\}\").  For example, pipeIO[\"y\",\"x\",\"X.(t,n->t+1,n+1)\",\"
\{t,n|n>=-1\}\"] pipes all occurences of x in definition of y in
$result to plane \" \{t,n | n>=-1\}\", with new name X, and pipeline
direction (1,1).  If something wrong happens, pipeIO returns the
system unmodified.  For programming purpose, exp, pipespec and
boundary can be given as AST instead of textual form.  Also, the
position of the expressions to pipeline may be given. See test file
pipeIOT.m in $MMALPHA/test."

Options[pipeIO] = {debug->False,verbose->True};

buildPipelineEquation::WrongArg = 
"wrong arguments for buildPipelineEquation: `1`, aborting pipeline";
pipeIO::nodecl="Declaration of variable `1` not found";
pipeIO::expnf="sub-expression to be pipelined was not found";
pipeIO::noTranslation="pipeline function is not a translation";
pipeIO::pol=" The bound must be a convex";
pipeIO::dimBnd=
"Dimension of the bounding hyperplane incoherent with pipeline vector"; 
pipeIO::scalarDot= 
"Warning: it might be impossible to use pipeIO for pipelining along
this direction (the dot product of pipeVector and normal to data
Hyperplan is equal to : `1`, should be equal to one 1)";
pipeIO::wrsubexp="Parse error in sub-expression";
pipeIO::expperr="Parse error in pipeline expression";
pipeIO::Domerr="Parse error in bounding domain";
pipeIO::equality1= "The Domain of the expression to pipeline must have
at least one equality"; 

pipeIO::WrongArg = "Wrong argument for PipeIO:";
pipeIO::VDim = "Dimension incompatibility between pipe Vector and expression 
to pipeline";
pipeIO::PipeVectInDomain= "Wrong pipe vector, the pipe vector is 
 (probably) contained in the domain where the pipeline should end" 

Begin["`Private`"];

(* 
Given an expression exp specified by its path, a varName and an Alpha
domain, buildPipelineEquation extracts a possible domain D1
(temporarily intersection of the exp domain R and the declaration
decl[N,T,D] of the LHS variable.)  The pipeline variable is declared
as decl[newVarName,T,D1] where D1 = D inter R. The equation defining
this new variable is

   equation[newVarName,
            case[{restrict[D1 - translate(D1, pipelineVector), exp],
	          restrict[D1 inter translate(D1, pipelineVector),
		           affine[var[newVarName], -pipelineVector]]]]]

The expression exp itself is replaced by var[newVarName].

WARNING: we insert the new equation using an absolute path, so be careful
when modifying the following code!!!
*)

Clear[buildPipelineEquation];
buildPipelineEquation::usage = 
"buildPipelineEquation[ e, v, d, p ] builds a pipeline equation 
for expression e, new variable v, domain d, and pipeline vector p.
This function is not intended to be called directly."; 

buildPipelineEquation::err1 = "error while calling DomIntersection";
buildPipelineEquation::err2 = "error while calling DomDifference";
buildPipelineEquation::err3 = "error while inverting pipeline Matrix";

buildPipelineEquation[ 
  exp_,
  varName:_String,
  domain:_domain,
  pipelineVector:_matrix, opts:___Rule 
] :=
Catch[
  Module[ { movementDomain, indexMatrix, domDiff, invMat, dbg },

    dbg = debug/.{opts}/.Options[ pipeline ];

  (*
  Print["99999999999999"];
  ashow[exp];
  Print[ varName ];
  Print["Pipeline Vector: ", pipelineVector ];
  ashow[ domain ];

  Global`$bvar = {exp, varName, domain, pipelineVector };
  *)

    (* Compute domain where we change the definition *)
    Check[
      movementDomain = 
        DomIntersection[ domain, DomImage[domain, pipelineVector] ],
      Throw[Message[buildPipelineEquation::err1]]
    ];

    If[ dbg, Print[ "movement domain: ", 
               ashow[ movementDomain, silent -> True ] ]
    ];

    If[ DomEmptyQ[ movementDomain ], 
      buildPipelineEquation::err4 = "movement domain is empty";
      Throw[Print[buildPipelineEquation::err4];Null]
    ];

    (* Get the index matrix from expression *)
    indexMatrix=exp[[1]];

    (* Compute domain where we change the definition *)
    Check[
      domDiff = DomDifference[domain, movementDomain],
      Throw[Message[buildPipelineEquation::err2]]
    ];

    If[ dbg, Print[ "definition domain: ", 
               ashow[ domDiff, silent -> True ] ]
    ];

    If[ DomEmptyQ[ domDiff ], 
      pipeall::wrgboundary = 
        "definition domain is empty. Check the boundary domain, and reverse the inequality";
      Throw[ Message[ pipeall::wrgboundary ] ] 
    ];

    (* Get the inverse matrix of the pipeline vector *)
    Check[
      invMat = inverseMatrix[pipelineVector],
      Throw[Message[buildPipelineEquation::err3]]
    ];

    If[
      MatchQ[ exp, index[m_] ],
      equation[ varName,
       case[
         {restrict[ domDiff, exp ],
          restrict[ movementDomain,
                    binop[ add, affine[ var[varName],
                                        invMat
                                      ],
                                index[ subMatrices[
                                         composeAffines[
                                           indexMatrix,
                                           pipelineVector],
                                         indexMatrix
                                         ]
                                ]
                    ]
          ]
         }
        ] (* case *)
     ],  (* equation *)
     equation[
       varName,
       case[
         {restrict[ domDiff, exp ],
          restrict[
            movementDomain,
            affine[
              var[varName],
              invMat
            ]
          ]
         }
       ] (* case *)
     ] (* equation *)
    ] (* If *)
  ] (* Module *)
]; (* Catch *)
buildPipelineEquation[a___]:=Throw[Message[buildPipelineEquation::WrongArg,a]];

(*
  The pipeline function is intended to pipeline - or uniformize - an
  expression. It can be called in several ways: 
  pipeline[{sys}, occur, pipeSpec, {dom1}, opts ]
  pipeline[{sys}, occur, newvarname, pipelineVector, {dom1}, opts ]

  - sys is the system to be pipelined ($result, by default), 
  - occur is the occurence number of the expression to be pipelined, 
  - pipeSpec is a textual expression of the form "NewVar.(dep)" where 
  dep is the translation describing the pipeline vector, 
  - dom1 is a boundary domain expressed as a half space
  
  pipeSpec can be replaced directly by the new var name, and the 
  pipeline vector given in matrix form

*)

Clear[pipeline];
Options[ pipeline ] := { debug -> False };

(* Call with no system. Notice that boundary domain has a default value *)
pipeline[ 
  occur: {__Integer}, 
  pipeSpec:(_String|{_String,{__Integer}}), 
  dom1:(_domain|_String):DomEmpty[0], 
  opts:___Rule ]:=
Catch[
  Module[ { tmp },
    (* Run pipeline *)
    tmp = pipeline[ $result, occur, pipeSpec, dom1, opts ];
    (* If it fails, restore situation *)
    If[ tmp =!= Null,
      ($program = $result;
       $result = tmp),
       Null ]
  ]
];

(* Call with everything *)
pipeline[ 
  sys:_system, 
  occur:{__Integer}, 
  pipeSpec:(_String|{_String,{__Integer}}),
  dom1:(_domain|_String):DomEmpty[0], 
  opts:___Rule ] :=
Catch[
  Module[{ pipeExp, newVarName, pipeVector, dbg, domparsed },
    (* Get options *)
    dbg = debug/.{opts}/.Options[ pipeline ];

    If[ dbg, Print[ "Version 1 of pipeline" ] ];
    If[ dbg, Print["Dom1: ", dom1] ];

    (* Analyze pipe expression, if needed *)
    If[ MatchQ[ pipeSpec, _String ],
      pipeExp = readExp[pipeSpec,sys[[2]]];

      (* If analysis fails, exception *)
      If[ pipeExp === Null, Throw[Message[pipeline::parseError]] ];

      (* Get new variable name *)
      newVarName = Part[pipeExp, 1, 1]; 
      If[ dbg, Print["New variable name : ", newVarName] ]; 

      (* Get pipe vector *)
      pipeVector = pipeExp[[2]]; 
      If[ dbg, Print["Pipeline vector : ",pipeVector] ];

      If[ !translationQ[pipeVector], 
        Throw[Message[pipeline::translation]] ],

      (* In this call form, the pipe specification is 
         given as a pair {varName, pipeVector}, where 
         the pipe vector has to be translated into an
         Alpha matrix. Hence what follows. *)
      newVarName = pipeSpec[[1]];
      If[ dbg, Print["New variable name : ", newVarName] ]; 
      pipeVector = pipeSpec[[2]]; 
      If[ dbg, Print["Pipeline vector : ",pipeVector] ];

      Module[ {indexes, decl, lhs, mat, lg},
        Check[ lhs = getPart[ sys, Take[ occur, 2 ] ][[1]],
          Throw[ Message[ pipeline::wrgocc ] ] ]; 
        If[ dbg, Print["Lhs : ", lhs ] ];
        Check[ decl = getDeclaration[ lhs ],
          Throw[ Message[ pipeline::wrgocc ] ] ]; 
        indexes = decl[[3]][[2]];
        If[ dbg, Print["indexes : ", indexes ] ];
        lg = Length[ pipeVector ];
        If[ lg =!= Length[ indexes ], 
          Throw[ Message[ pipeline::wrgpipel ] ] ];
        mat = IdentityMatrix[ lg +1  ];
        mat = Append[ Delete[ mat, -1 ], Append[ pipeVector, 1 ] ];
        mat = Transpose[ mat ]; 
        pipeVector = matrix[ lg+1, lg+1, indexes, mat ]; 
        If[ dbg, show[ pipeVector ]];
      ]
    ];

    (* Parse dom1, if it is in string form *)
    If[ MatchQ[ dom1, _String], 
      Check[ domparsed = readDom[ dom1 ],
        Throw[ Message[ pipeline::parseerror ] ] ],
      domparsed = dom1
    ];

    If[ dbg, Print[ "Boundary domain: ", ashow[domparsed,silent->True] ] ];

    (* If everything is OK, pipe! *)
    If[ dbg, Print["------- Calling the pipeline function."] ];

    pipeline[ sys, occur, newVarName, pipeVector, domparsed, opts ]

  ] (* Module *)
]; (* Catch *)
pipeline::parseerror = "Could not parse boundary domain";

pipeline[ sys:system[n_, p_, i_, o_, locals_, equas_],
  occur:{__Integer},
  newVarName:_String,
  pipelineVector:_matrix,
  domBounding:_domain:DomEmpty[0], opts:___Rule ] :=
Catch[
  Module[{LHSdecl,RHSrestrict,expAst,matAst,nbRow,nbCol,mat2,
          theta,rayPipeVect,rayPipeMat,domPlusRay,eqnPipe,typeExp,dbg,
          expDom,boundDom},

    dbg = debug/.{opts}/.Options[ pipeline ];
    If[ dbg, Print[ "Version 2 of pipeline" ] ];
    If[ dbg, Print[ "Boundary domain is: ", 
                    ashow[domBounding,silent->True] ] ];

    (* If the new name already exists *)
    If[MemberQ[getVariables[sys],newVarName],
       Throw[(Message[pipeline::wrngname];sys)]];

    (* LHS decl : declaration of the LHS variable var_1 *)
    LHSdecl = getDeclaration[ sys,
                Part[ lookUpFor[ sys, occur, equation], 1 ] ];
    If[ dbg, Print["Declaration of LHS variable : ", LHSdecl] ];

    RHSrestrict = lookUpFor[sys, occur, restrict];
    expAst = getPart[sys,occur];
    If[ dbg, Print["AST of the expression : "]; show[expAst] ];

    (* check if the pipeline vector belong to the 
       kernel of the broadcast *)
    If[ MatchQ[ expAst, index[m_] ],
      matAst = expAst[[1]];
      nbRow=matAst[[1]];
      nbCol=matAst[[2]];
      If[nbCol=!=pipelineVector[[1]],
        Throw[(Message[pipeline::wrongDim];sys)]
      ]];

    If[ !MatchQ[ expAst, affine[exp1_,aff1_] ],
      Message[pipeline::noCheck],
      matAst = expAst[[2]];
      nbRow=matAst[[1]];
      nbCol=matAst[[2]];
      If[nbCol=!=pipelineVector[[1]],
        Throw[(Message[pipeline::wrongDim];sys)],

    (* The pipeline vector must be in the
       kernel of the broadcast, hence the following test *)

    mat2=composeAffines[matAst,pipelineVector];
    If[ mat2 =!= matAst,
      Throw[(Message[pipeline::wrongPipeVect];sys)]];
    ]];
    If[ dbg, show[RHSrestrict] ];
    (* expDom modified by Florent
    expDom = getContextDomain[sys, occur] 
    Then modified by Tanguy, the domain of the new
    variable is the intersection of the domain of the
    expression and the context domain of this
    expression.
    The next modification is the following, if a
    boundary domain is given, the domain is extended
    along the pipe vector up to the boundary   *)
     
    expDom = 
      DomIntersection[ getContextDomain[sys, occur],
         expDomain[ sys, occur] ];
    If[ dbg, Print["Domain ",newVarName,"  "] ];
    If[ dbg, show[expDom] ];

    If [!DomEmptyQ[domBounding],
      (* In that case we pipeline up to the border of domBounding *)
      (* theta is the opposite of the translation vecteur,*)
      theta  = -getTranslationVector[pipelineVector]; 
      If[ dbg, Print[ "Translation vector : ", theta ] ];
      (* rayPipeVect is the theta vector in the DomLib form *)
      rayPipeVect = Append[Prepend[theta,1],0];
      (* rayPipeMat is the form needed to use DomAddRays *) 
      rayPipeMat = 
        matrix[ 1, Length[rayPipeVect],{},{rayPipeVect} ];
      (* We compute the domain obtained by adding rayPipeVect
         as a ray of expDom *)
      domPlusRay = DomAddRays[expDom,rayPipeMat];
      If[ dbg, Print[ "Domain plus ray ", 
                      ashow[ domPlusRay, silent->True ] ] ];
      (* The domain where to pipeline is now the intersection 
         of domPlusRay and domBounding *)
      Check[expDom =  DomIntersection[domPlusRay, domBounding],
        Throw[Message[pipeline::bdintersec]]];
      If[ dbg, Print[ "Domain where to pipeline: ", 
               ashow[ expDom, silent->True ] ] ];
    ];

    Check[
      eqnPipe = 
        buildPipelineEquation[
          getPart[sys, occur],
          newVarName,
          expDom,
          pipelineVector, opts],
      (* Print["999999999999000000000000"];*)
      Throw[ sys ]
    ];

    If[ eqnPipe === Null, 
	(*
      Print["999999999999000000000000"]; 
      Print[ newVarName ];
      ashow[ sys ];
      Global`$$system = sys;
	 *)
      Throw[ sys ] 
    ];

    typeExp = expType[sys,getPart[sys,occur]];
	   
    sys3 = system[n, p, i, o,
            Prepend[locals,
              decl[newVarName,
(*
                Part[LHSdecl, 2], 
*)
                typeExp,
                expDom]],
                Insert[ReplacePart[equas,Alpha`var[newVarName],
                Drop[occur, 1]],
	     eqnPipe,
	     Part[occur, 2]]];
    If[ dbg, Print["----- Resulting system : "]; ashow[sys3] ];
    sys3
    ] (* Module *)
  ]; (* Catch *)
pipeline[a___]:= (Print[{a}];Message[pipeline::args]);

(* N.B.: as opposed to 'pipeline', new variable definition is inserted at the
   _beginning_ of the list of equations. *)

(* Other form for pipeall *)
Clear[pipeAll];
pipeAll[x:___] := pipeall[x];

(*
  pipeall[ eqn (one element or list ), subExpr, pipeExpr, {domBound}, options ]
*)
Clear[pipeall];

(* Call without system, eqnVarName, subExpr, pipeExpr, and optional 
   boundary domain *)
pipeall[ 
  eqnVarName:(_String|{___String}),
  subExpr:_,
  pipeExpr:_,
  dom1:(_domain|_String):DomEmpty[0], 
  opts:___Rule ]:=
Module[ 
  {tmp, dbg},
  dbg = debug/.{opts}/.Options[pipeline];
  If[ dbg, Print[ "Form 1" ] ];
  tmp = pipeall[ $result, eqnVarName, subExpr, pipeExpr, dom1, opts ];
  If[ tmp =!= Null,
    ($program = $result;
     $result = tmp ),
     $result
  ]
];

(* 
  Call with system, var name(e), any kind of subexpr and pipeexpr, 
  and domBound as a String. Parse domain, and call full form 
*)
pipeall[
  sys:_system,
  eqnVarName:(_String|{___String}),
  subExpr:_, (* String, *)
  pipeExpr:_, (* String, *)
  domBound:_String,
  opts:___Rule ]:=
Catch[
  Module[
    {domBoundTree, dbg},

    dbg = debug/.{opts}/.Options[pipeline];
    If[ dbg, Print[" Form 3" ] ];

    domBoundTree = readDom[domBound,sys[[2]]];  
    If[ domBoundTree === Null,
      (Message[pipeall::Domerr]; Throw[Null]) 
    ];

    (* Call pipeall *)
    pipeall[ 
      sys, 
      If[ MatchQ[ eqnVarName, _String ],
        {eqnVarName}, 
        eqnVarName
      ],
      subExpr, 
      pipeExpr, 
      domBoundTree,
      opts 
    ]
  ]
];

(* 
  Full call, parse if any of the first arguments is a string. 
  Boundary domain is implicit 
*)
pipeall[
  sys:_system,
  eqnVarName:(_String|{___String}),
  subExpr:_, (* String, *)
  pipeExpr:_, (* String, *)
  domBound:(_domain):DomEmpty[0], 
  opts:___Rule ]:=
  (* See the condition on the patterns at the end of the 
     definition : one of subExpr, pipeExpr, domBound should be 
     a string *)
Catch[
  Module[
    {subExpTree, occurList, pipeTree, newVarName, pipeVector, pipeDomain, 
     dbg},

    dbg = debug/.{opts}/.Options[pipeline];
    If[ dbg, Print[" Form 2" ] ];

    (* Parse sub expression, if needed *)
    Which[ 
      MatchQ[ subExpr, _String ],
      subExpTree = readExp[ subExpr, sys[[2]] ];
      
      (* If wrong, signal, and return Null *)
      If[ 
        subExpTree === Null,
        pipeall::wrsubexp = 
          "Error while parsing sub-expression to be pipelined.";
        Throw[Message[pipeall::wrsubexp]] 
      ]
    ,
      (* Form of occurrence given *)
      MatchQ[ subExpr, {__Integer} ],
      subExpTree = getPart[ sys, subExpr ];
      If[ dbg, Print[" subExpTree: ",  subExpTree ] ];
    ,
      True,
      subExpTree = subExpr;
      If[ dbg, Print[" subExpTree unchanged: ", subExpTree ] ];
    ];

    (* Parse pipe expression, if needed *)
    If[ MatchQ[ pipeExpr, _String ],
      pipeTree = readExp[pipeExpr,sys[[2]]];

      (* If wrong, signal, and return Null *)
      If[ pipeTree === Null,
        pipeIO::expperr="Parse error in pipeline expression";
        Throw[Message[pipeall::expperr]] 
      ],
      pipeTree = pipeExpr
    ];
    If[ dbg, Print[ "pipeTree : ", FullForm[ pipeTree ] ] ];

    (* Now, call "standard" pipeall *)
    If[ dbg, Print["------- Calling pipeall function."] ];
    pipeall[ 
      sys, 
      If[ MatchQ[ eqnVarName, _String ],
        {eqnVarName}, 
        eqnVarName
      ],
      subExpTree, 
      pipeTree, 
      domBound,
      opts 
    ]
  ]
]/;(MatchQ[subExpr,(_String|{__Integer})]||
  MatchQ[pipeExpr,_String]);


(* 
  Standard call. Arguments are already parsed.
*)
pipeall[ 
  sys:_system,
  eqnVarNames:(_String|{___String}),
  subExpTree:_affine,
  pipeTree:_affine, 
  domBound:(_domain):DomEmpty[0],
  opts:___Rule ]:=
Catch[
  Module[{eqnDecls,eqnDeclDom,eqnDefinitions,occurList,
    newVarName,pipeVector,pipeDomain,expDom1,posEmpty,
    matAst,nbRow,nbCol,mat2,typeExp,newsys,dbg,eqnVarNamesLoc},

    dbg = debug/.{opts}/.Options[ pipeline ];

    (* Replace single var by list if needed *)
    eqnVarNamesLoc = 
      If[ MatchQ[ eqnVarNames, _String ], {eqnVarNames}, eqnVarNames ];

    (* If eqnVarNamesLoc is empty, then all equations are concerned *)
    If[ eqnVarNames === {}, 
      eqnVarNamesLoc = Join[ getLocalVars[], getOutputVars[] ] 
    ];

    (* Get declaration of variables *)
    eqnDecls = Map[getDeclaration,eqnVarNamesLoc];

    (* Check the result, and send a message if wrong *)
    If[MemberQ[eqnDecls,{}],
      posEmpty=Position[eqnDecls,{}];
      Throw[ Message[pipeall::nodecl,eqnVarNamesLoc[[posEmpty[[1]]]]]] 
    ];

    If[ dbg, Print["Declarations of variables : ", eqnDecls ]];

    (* Get expression domain of sub expression *)
    expDom1 = expDomain[subExpTree];
    If[ expDom1 === $Failed,
      Throw[ Message[pipeall::expperr] ]
    ];

    If[ dbg, Print["Domain of expression : "]; show[expDom1] ];
	
    If[ dbg, Print["Variable Names : ", eqnVarNamesLoc ] ];

    (* Get the definitions of variables *)
    eqnDefinitions = Map[ getDefinition, eqnVarNamesLoc ];

    (* Check the result, and DO NOT send a message if wrong, as 
      getDefinition already does this. Return Null *)
    If[ MemberQ[eqnDefinitions,{}],Throw[Null] ];
    If[ dbg, Print["Definition of variable : ", eqnDefinitions] ];

    (* Get list of occurrences of expression in definitions of 
        variable *)

    (* Build the Declaration domain of the pipeVar as the union 
        of all the domains of the context in which the expression is
        used (this was set by Tanguy on the 9/10/98)*)

    (* Get list of occurences of sub expression tree in rhs of 
       equations whose lhs is in eqnVarNamesLoc *)
    occurList = 
       Apply[
         Join,
         Map[getOccursInDef[sys,#1,subExpTree] &,
				eqnVarNamesLoc]
    ];
 
    If[ dbg, Print["List of occurences of variables : ", occurList ] ];

    Which[
      (* Error: no occurrence at all *)
      occurList === Table[{}, {Length[occurList]} ],
        Throw[Message[pipeall::expnf]],

      (* Error, There is one wrong occurrence of an expression *)
      MemberQ[occurList,{}],
        posEmpty = Position[occurList,{}];
        Message[pipeall::expnfInVar,eqnVarNamesLoc[[posEmpty[[1]]]]],

      (* Otherwise *)
      True, 
      (* Compute list of contexts of expression *)
      domContextOccursList = Map[getContextDomain[sys,#1] &,
                                   occurList];
      (* By folding unions *)
      Check[ 
        domContextOccurs =
          Fold[DomUnion,
            domContextOccursList[[1]],
            Drop[domContextOccursList,1]
        ],
        pipeall::errunion = "error while computing the contexts";
        Throw[ Message[ pipeall::errunion ] ]
      ];

      pipeDomain = domContextOccurs
    ]; (* Which *)
     
    (* The following is done only if a non empty domain is 
       given as boundary domain *)
    If[ domBound =!= DomEmpty[0],

      useDomain = pipeDomain; 
      If[ dbg, Print["useDomain is   : ", 
        show[useDomain,silent->True]] ];

      (* Added by Tanguy 
        we build the pipeDomain from the pipeVector, the 
        domain where the expr is used and the bound domain *) 
      nbIneqBnd = domBound[[3,1,1]];
      nbEqBnd = domBound[[3,1,3]];
      If[ ((nbIneqBnd =!= 2)||(nbEqBnd=!=0)),
        pipeIO::bnd1=" The bound must be an half space";
        Throw[(Message[pipeall::bnd1];sys)]
      ];

      (* In that case we pipeline up to the border 
        of the domBounding *)

      (* Theta is the opposite of the translation vecteur *)
      pipeVector   = Part[pipeTree,2];
      theta  = -getTranslationVector[pipeVector]; 
      If[ dbg, Print["Computing pipeDomain bound: Theta is  : ", 
                  theta ] ];

      (* rayPipeVect is the same in DomLib form *)
      rayPipeVect = Append[ Prepend[theta,1], 0];
      If[ dbg, Print[ "ray Pipe Vector: ", rayPipeVect ] ];

      (* rayPipeMat is the form needed to use DomAddRays *) 
      rayPipeMat = 
        matrix[1, Length[rayPipeVect], {}, {rayPipeVect} ];
      If[ dbg, Print[ "ray Pipe Matrix: ", rayPipeMat ] ];

      domPlusRay = DomAddRays[ useDomain, rayPipeMat ];
      If[ dbg, Print[ "dom plus ray: ", 
                 ashow[ domPlusRay, silent -> True ] ] ];

      pipeDomain =  DomIntersection[domPlusRay, domBound];

      If[ dbg, Print["pipeDomain is   : ", 
        show[pipeDomain,silent->True]] 
      ];
    ];

    (* Now, call the true function *)
    pipeallkernel[sys, eqnVarNamesLoc, subExpTree, pipeTree, pipeDomain, opts]
  ]
];


pipeallkernel[sys_Alpha`system,
        eqnVarNames_List, (* List of Eqn where the expression is *)
        subExpTree_,
        pipeTree_,
	pipeDomain_,
        opts:___Rule ] :=
Catch[
  Module[{occurList,peq,
    newVarName,pipeVector,posEmpty,
    matAst,nbRow,nbCol,mat2,typeExp,newsys,dbg},

    (* Get declaration of variable *)

    dbg = debug/.{opts}/.Options[ pipeline ];

    If[ dbg, Print["Pipeline domain : ", 
                    ashow[ pipeDomain, silent -> True ] ] ];

    (* Build the Declaration domain of the pipeVar as the union 
        of all the domains of the context in which the expression is
        used (this was set by Tanguy on the 9/10/98)*)

    occurList = Apply[Join,
			     Map[getOccursInDef[sys,#1,subExpTree] &,
				eqnVarNames]];

    If[ dbg, Print["List of occurences of variables : ", occurList ] ];

    Which[(* Error: no occurrence at all *)
      occurList === Table[{}, {Length[occurList]} ],
      Throw[Message[pipeall::expnf]],

      (* Error, there is one wrong occurrence of an expression *)
      MemberQ[occurList,{}],
        posEmpty = Position[occurList,{}];
        Message[pipeall::expnfInVar,eqnVarNames[[posEmpty[[1]]]]]
    ];

    (* If the expression is found nowhere,
      empty, signal, and return Null *)

    newVarName   = Part[pipeTree,1,1];
    pipeVector   = Part[pipeTree,2];
 
   (* This case covers indexed expressions *)
    If[ MatchQ[ subExpTree, index[m_] ],
       matAst = subExpTree[[1]];  
       nbRow=matAst[[1]];         
       nbCol=matAst[[2]];

       (* Check the dimension *)
       If[ nbCol=!=pipeVector[[1]],
         Throw[(Message[pipeall::wrongDim];sys)]
       ]
    ];

    (* This case covers affine expressions *)
    If[ !MatchQ[ subExpTree, affine[exp1_,aff1_] ],
      Message[pipeall::noCheck],
      matAst = subExpTree[[2]];
      nbRow=matAst[[1]];
      nbCol=matAst[[2]];
      If[nbCol=!=pipeVector[[1]],
        Throw[(Message[pipeall::wrongDim];sys)]
      ];

      (* The pipeline vector must be in the 
         kernel of the broadcast, hence the
         following test *)
      mat2=composeAffines[matAst,pipeVector];
      If[ mat2[[4]] =!= matAst[[4]],
         Throw[(Message[pipeall::wrongPipeVect];sys)]
      ];
    ];

    typeExp =  expType[sys,subExpTree];

    Check[
      peq = buildPipelineEquation[
           subExpTree, newVarName, pipeDomain, pipeVector, opts
      ],
      Throw[ Null ]
    ];

    Insert[
      Insert[
        ReplacePart[ sys, var[newVarName], occurList ],
	       decl[ newVarName, typeExp , pipeDomain ],
	       {5,1}],    (* insert as first local decl *)
        peq,
      {6,1}
    ]      (* Insert as first equation *)
  ] (* Module *)
]; (* Catch *)

pipeall[sys_/;Not[MatchQ[sys,Alpha`system[___]]],_,_,_]:=
  (Print["Wrong 1st arg"]);

pipeall[_,ag2_/;Not[StringQ[ag2]],_,_]:=
  (Print["Wrong 2d arg"]);

pipeall[x:___]:=
  (Print["wrong arguments"];)


(* pipeIO
         Uses: Matrix::getTranslationVector
         Matrix::translationQ
*)

Clear[pipeIO];
pipeIO[ eqnVarName_String,
	subExpr:_,
        pipeExpr_String,
        bnd_String,
        opts:___ ] :=
Module[{tmp,sys},
  sys=$result;
  tmp=pipeIO[sys,eqnVarName,subExpr,pipeExpr,bnd,opts];
  If[ MatchQ[tmp,Alpha`system[___]],
     (Alpha`$program = Alpha`$result;
      Alpha`$result = tmp ),
      Alpha`$result
  ]
];

pipeIO[ sys_Alpha`system,
	eqnVarName_String,
	subExpr:_,
        pipeExpr_String,
        bnd_String,
        opts:___ ] :=
  Catch[
    Module[
    {subExpTree,occurList,pipeTree,newVarName,pipeVector,pipeDomain,domBnd},
      (* parse sub expression, if a string *)
      If[ MatchQ[ subExpr, _String ],
        subExpTree = readExp[subExpr,sys[[2]]],
        subExpTree = subExpr
      ];

      (* Get expression, if occurence is given *)
      If[ MatchQ[ subExpr, _List ],
        subExpTree = getPart[sys,subExpr]
      ];

      (* if wrong, signal, and return Null *)
      If[ subExpTree === Null,
	  (Message[pipeIO::wrsubexp]; Throw[Null]) ];

      (* parse pipe expression *)
      pipeTree = readExp[pipeExpr,sys[[2]]];
      (* if wrong, signal, and return Null *)
      If[ pipeTree === Null,
	  (Message[pipeIO::expperr]; Throw[Null]) ];

      (* reading the bound domain of pipeIO *)
      domBnd = readDom[bnd,sys[[2]]];

      (* now, call "standard" pipeall *)
      tmp=pipeIO[sys,eqnVarName,subExpTree,pipeTree,domBnd,opts];
      If[ MatchQ[tmp,Alpha`system[___]],
	  tmp,
	  Alpha`$result
	  ]
    ]
  ];


(* This definition is for compatibility with previous version *)
pipeIO[ {var_String, subExpr_String},
        pipeExpr_String,
        bnd_String, opts:___ ] :=
  pipeIO[var,subExpr,pipeExpr,bnd,opts];

pipeIO[sys_Alpha`system,
       exp_,                 (* ast of expression to be pipelined *)
       expPos_List,          (* positions of expression to be pipelined *)
       pipeExpr_String,      (* ex: "X1.(t->t-1)" new var and direction *)
       bnd_String,
       opts:___ ]:=          (* ex: "{i,j | 2i+3j+4>=0}" *)
(Message[pipeIO::WrongArg];Throw["ERROR"]);

pipeIO[eqnVarName_String,
       exp_,                 (* ast of expression to be pipelined *)
       pipe_,                (* ast of the pipeline function *)
       bnd_Alpha`domain,
       opts:___]:=              (* ast of the bounding domain  *)
Module[{tmp,sys},
  sys=$result;
  tmp=pipeIO[sys,eqnVarName,exp,pipe,bnd,opts];
  If[ MatchQ[tmp,Alpha`system[___]],
      (Alpha`$program = Alpha`$result;
       Alpha`$result = tmp ),
       Alpha`$result
  ]
];

(* This is the version of pipeIO that is executed internaly 
   it does not modify $result.
   Updated by Tanguy on 31/01 
   The semantics of this transformation  is explained in the document
   entitled <<theoretical basis of pipeline package>> *)

pipeIO[sys_Alpha`system,
       eqnVarName_String,
       exp_,                 (* ast of expression to be pipelined *)
       pipe_,                (* ast of the pipeline function *)
       bnd_Alpha`domain,opts:___]:=    (* ast of the bounding domain  *)
Module[
  {eqnDecl,expPos,pipeVar,pipeT,matAst,nbRow,nbCol,matAst2,theta,
   mbPol,nbIneqBnd,nbEqBnd,dimBnd,normalHyp,scalarDot,domExpr,
   domExprEquality,scalarDot2,rayPipeVect,rayPipeMat,bigDomPipesa,
   realDomPipe,pipeEndDom,hq,u,matH,h,h1,h2,h1bis,h2bis,vrb,dbg},

   dbg = debug/.{opts}/.Options[pipeIO];
   vrb = verbose/.{opts}/.Options[pipeIO];

  (* Get the declaration of variable *)
   Check[ eqnDecl = getDeclaration[sys,eqnVarName],
          Message[pipeIO::nodecl,eqnVarName];Throw[sys]
   ];
   If[ dbg, Print["Declaration of variable is: ", eqnDecl ] ];

  (* Get list of occurrences of expression in definition of 
     the variable *)
   expPos  = getOccursInDef[sys,eqnVarName,exp];

   (* If empty, signal, and return Null *)
   If[dbg, Print["exp is ", exp, "\nVarName is ", eqnVarName] ];
   If[dbg, Print["Occurrences of exp are ", expPos] ];
   If[ expPos === {}, Throw[Message[pipeIO::expnf]]];

   (* Analyze the pipe vector *)
   pipeVar = Part[pipe,1,1];   (* name of pipeline var *)
   pipeT  = Part[pipe,2];      (* pipeline Translation-matrix *)
				       
   (* Check if pipevector is a simple translation *)
   If[!translationQ[pipeT],
      Throw[(Message[pipeIO::noTranslation];sys)]
   ];
      
   (* Extract out the pipeline vector *)
   theta  = getTranslationVector[pipeT]; 
   If[ dbg, Print[ "Pipeline vector (theta): ", theta ] ];
      
  (* Analyze the boundary equation *)
   nbPol=Length[bnd[[3]]];
   If[nbPol=!=1, 
      Throw[(Message[pipeIO::pol];sys)]
   ];
   nbIneqBnd=bnd[[3,1,1]];
   nbEqBnd = bnd[[3,1,3]];
   If[((nbIneqBnd =!= 2)||(nbEqBnd=!=0)),
       pipeIO::bnd2=" The bound must be an half space";
       Throw[(Message[pipeIO::bnd2];sys)]
   ];
      
   dimBnd=bnd[[1]];
   If[dimBnd=!=Part[pipeT,1]-1,
     If[ dbg, 
       Print["dimBnd=",bnd[[1]]];
       Print["pipeT=",pipeT]
     ]; 
     Throw[(Message[pipeIO::dimBnd];sys)]
   ];
      
  (* NormalHyp is the normal to the Hyperplane defining the 
     border.
	Print["pipeT="];show[pipeT]; *)
  normalHyp = Drop[Drop[bnd[[3,1,5,1]],-1],1];
  If[ dbg, Print["Normal to the hyperplane: ",  normalHyp ] ];
  (* ScalarDot is the scalar product of the previous normal 
     and the pipeVector, it indicates (by its sign if we 
     perform a pipeInput or pipeOutput)*)
  scalarDot = normalHyp.theta;

  (* This condition is necessary because we use inverseInContext *)
  If[ Abs[ scalarDot=!=1 ],
      Throw[(Message[pipeIO::scalarDot,scalarDot];sys)]
  ];
      
  (* In the following, There are three domains.
     domExpr is the domain where the expression is used 
      (end of the pipeline domain)
     realDomPipe is the Whole pipeline domain
     pipeEndDom is the domain "on the other side of realDomPipe"
     (initialisation in case of input pipe, output in case of 
     output pipe). *)

  (* Compute the domain where the expression to pipeline is used 
    (as it is done in pipeall)*)
  domExpr = getContextDomain[sys, expPos];

  (* Check that the pipeVector has the correct dimension: 
     the same as the dimension of exprDom *)
   pipeIO::pipeVDim = 
    "the pipeline vector: `1` do not have the correct dimension: `2`";
   If[Part[pipeT,1]-1=!=Part[domExpr[[1]]],
      Throw[(Message[pipeIO::pipeVDim,pipeT,Part[domExpr[[1]]]])]1
   ];
	  
  (* Little patch because of a bug in getContextDomain: call the
     indices as they are called in the transformation matrix 
     given by the user 	*)
   domExpr = ReplacePart[domExpr, Part[pipeT,3], {2}];

  (* Computation of the domain on which the expression
     is realy used is the intersection of ContextDomain and 
     ExpDomain. *)
   domExpr = DomIntersection[domExpr,expDomain[sys,First[expPos]]];

   Check[ domExprEquality = DomEqualities[domExpr], Throw[ Null ]];

   If[dbg, 
      Print["domExpr is ", ashow[domExpr,silent->True], 
            "\nequalities in domain are: ", 
            ashow[domExprEquality, silent->True]]];

   (* At the moment, DomExpr must have only one Equality *)
   If[domExprEquality[[1]] < 1, 
     Throw[(Message[pipeIO::equality1];sys)];
   ];

   (* ScalarDot2 is the scalar product between the equality of DomExpr 
      and the pipe vector. It must be equal to one,
      otherwise the pipe Domain will not be convex *)
   scalarDot2 = theta.Drop[domExprEquality[[4,1]],-1];
   If[ dbg, Print[ "Pipeline vector: ", theta ] ];
   If[ dbg, Print[ Drop[domExprEquality[[4,1]],-1] ] ];

   If[Abs[scalarDot2]=!=1,
     pipeIO::equality2= 
"Sorry, impossible to use pipeIO for pipelining along this direction
(the dot product of pipeVector and the normal to the data Hyperplane is
equal to : `1` and it should be equal to 1)";
     Print["Pipe vector is : ", theta];
     Print["Normal to data hyperplane is : ", 
       Drop[ domExprEquality[[4,1]],-1]];
     Throw[(Message[pipeIO::equality2,scalarDot2];sys)]
   ];
      
   (* Print["domExpr"];show[domExpr]; *)

   (* bigDomPipe is domExpr which has been extended along the 
	 pipeline vector with the function DomAddRays. This function
	 needs a matrix whose rows are the rays to add, we add, to
	 theta, a 1 at the beguinning (for rays instead of lines)
	 and a 0 at the end (for rays instead of vertex) 	 *)

   rayPipeVect = Append[Prepend[If[scalarDot===1,-theta,theta],1],0];
   opositeRayPipeVect = Append[Prepend[If[scalarDot===1,theta,-theta],1],0];
   rayPipeMat =
      Alpha`matrix[1,Length[rayPipeVect],{},{rayPipeVect}];
      opositeRayPipeMat =
      Alpha`matrix[1,Length[opositeRayPipeVect],{},{opositeRayPipeVect}];

      (*Print["domExpr="];show[domExpr];
       Print["bnd="];show[bnd];
       Print["ray added ",rayPipeMat]; *)
      bigDomPipe=DomAddRays[domExpr,rayPipeMat];
      (* the real domaine is bigDomEpr intersected with the boundary
	 domain *)
	realDomPipe= DomIntersection[bigDomPipe,bnd];
      
      (*  pipeEndDom is the difference between the realDomPipe, and the 
	 same domain shifted by the pipeVector theta (input pipe)
	 of -theta (output pipe)*)
	  pipeEndDom = If[scalarDot>0,
		       DomDifference[realDomPipe,
					    DomImage[realDomPipe,
							    pipeT]],
                      DomDifference[realDomPipe,
					   DomImage[
					     realDomPipe,
					     inverseMatrix[pipeT]]]];
      
    (* h is a matrix where the pipe vector is the kernel 
       One possible construction 
       is take pipeVector=HU hermite decomposition of pipeVector,
       take V=(U^{t})^{-1} and h = V where the first row is replace 
       by the second row, Indeed, 
       pipV = (k,0 ,..,0).U thus
       U^{t}.(k,0,0...,0)^t=pipeV^{t} thus 
       (k,0,0...,0)^t=(U^{t})^{-1} pipeV^{t} 
       thus (0,0,0...,0)^t=h  pipeV^{t}*)


      hq=hermiteL[{theta}];
      u=Inverse[Transpose[hq[[2]]]];
      u=ReplacePart[u,u[[2]],1];
      matH=Join[Map[Append[#,0] &,u],
                {Join[Table[0,{dimBnd}],{1}]}];
      
      h  = Alpha`matrix[dimBnd+1,dimBnd+1, Part[domExpr,2],matH];
      
    (* h is not invertible but in the context of domExpr it is 
       (or should be, maybe a check is needed here), h1 gives,
       given a point h(z) in the image of h AND in domEpr, the 
        corresponding z *)

      (* Print["u",u];
	 Print["q=",hq[[2]]];
	 Print["h="];show[h];*)


      h1 = inverseInContext[h,domExpr]; 
      If [h1===$Failed,
	    Message[pipeIO::PipeVectInDomain];
	    Throw[sys]];

      (* h1bis gives,
	 given a point h(z) in the image of h AND in pipeEndDom, the 
	 corresponding z, it is the same as h1 but for piping output *)
      h1bis = inverseInContext[h,pipeEndDom]; 

      (* Print["h1="];show[h1]; 
      Print["h1bis="];show[h1bis]; *)
   (* h2 give the value to initialize pipeVar in pipeEndDom,
      the initialisation is done be composing Expr with an affine
      function expr.(z->f(z)), f(z) is the point reached from z in
    domExpr by following the pipeVector. Thus, f(z) is such that 
    h(z) = h(f(z)), as f(z) is in domExpr, we get f(z)=h1(h(z)).*)
    
      h2=composeAffines[h1,h];
      h2bis=composeAffines[h1bis,h];
      (* Print["h2="];show[h2]; 
      Print["h2bis="];show[h2bis]; *)

  (* BUILDING THE NEW PROGRAM
      *)
If[MatchQ[exp,Alpha`index[m_]],
  If[scalarDot===1,
(*     pipe input for index expressions *)
    Insert[
      Insert[
        ReplacePart[sys,
          Alpha`restrict[domExpr,Alpha`var[pipeVar]], expPos],
        Alpha`decl[pipeVar, eqnDecl[[2]], realDomPipe], {5,1}],
      Alpha`equation[pipeVar,
        Alpha`case[{
          Alpha`restrict[pipeEndDom,Alpha`affine[exp,h2]],
          Alpha`restrict[DomDifference[realDomPipe, 
					    pipeEndDom],
                         Alpha`binop[add,Alpha`affine[Alpha`var[pipeVar],
                                      inverseMatrix[pipeT]],
	      Alpha`index[subMatrices[composeAffines[exp[[1]],pipeT],exp[[1]]]
			             ]]]
        }]], {6,1}
    ],
(*      pipe output for index expressions *)
    Insert[
      Insert[
        ReplacePart[sys,
          Alpha`affine[Alpha`restrict[pipeEndDom,Alpha`var[pipeVar]],h2bis], 
		    expPos],
        Alpha`decl[pipeVar, eqnDecl[[2]], realDomPipe], {5,1}],
      Alpha`equation[pipeVar,
        Alpha`case[{
          Alpha`restrict[domExpr,exp],
          Alpha`restrict[DomDifference[realDomPipe,
					    domExpr],
                         Alpha`binop[add,Alpha`affine[Alpha`var[pipeVar],
                                      inverseMatrix[pipeT]],
	      Alpha`index[subMatrices[composeAffines[exp[[1]],pipeT],exp[[1]]]
			             ]]]
        }]], {6,1}
	]
],
  If[scalarDot===1,
(*      pipe input for other expressions *)
    Insert[
      Insert[
        ReplacePart[sys,
          Alpha`restrict[domExpr,Alpha`var[pipeVar]], expPos],
        Alpha`decl[pipeVar, eqnDecl[[2]], realDomPipe], {5,1}],
      Alpha`equation[pipeVar,
        Alpha`case[{
          Alpha`restrict[pipeEndDom,Alpha`affine[exp,h2]],
          Alpha`restrict[DomDifference[realDomPipe, 
					    pipeEndDom],
                         Alpha`affine[Alpha`var[pipeVar],
                                      inverseMatrix[pipeT]]]
        }]], {6,1}
    ],
(*      pipe output for other expressions *)
    Insert[
      Insert[
        ReplacePart[sys,
          Alpha`affine[Alpha`restrict[pipeEndDom,Alpha`var[pipeVar]],h2bis], 
		    expPos],
        Alpha`decl[pipeVar, eqnDecl[[2]], realDomPipe], {5,1}],
      Alpha`equation[pipeVar,
        Alpha`case[{
          Alpha`restrict[domExpr,exp],
          Alpha`restrict[DomDifference[realDomPipe,
					    domExpr],
                         Alpha`affine[Alpha`var[pipeVar],
                                      inverseMatrix[pipeT]]]
        }]], {6,1}
	]
]
]
];


pipeIO[___]:= Throw[ Message[pipeIO::WrongArg] ];



(*-------------------------------------------------------------------------*)
Clear[pipeInput];
pipeInput[sys_Alpha`system,
	  eqnVarName_String,
	  subExpr_String,
	  pipeExpr_String,
	  bnd_String ]:= 
  pipeIO[sys,
	  eqnVarName,
	  subExpr,
	  pipeExpr,
	  bnd];

Clear[pipeOutput];
(* A VOIR *)

End[];

EndPackage[];

