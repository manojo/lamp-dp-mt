(* file: $MMALPHA/lib/Package/Alpha/BitOperators.m
   AUTHOR :  Tanguy Risset
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
(* 
  This package contains functions to generate bit true dependend operatores 
 *)

BeginPackage["Alpha`BitOperators`",{"Alpha`Domlib`",
  "Alpha`",
  "Alpha`Matrix`",
  "Alpha`Tables`",
  "Alpha`Semantics`",
  "Alpha`Substitution`",
  "Alpha`Normalization`",
  "Alpha`Static`"
}];

BitOperator::usage="BitOperator.m is a package for helping the designer
to realize bit-true simulation and exact bitwidh VHDL synthesis"  

prepareBitFile::usage=
"prepareBitFile[fileName_String] extract, from $result, all declaration and all 
operators and list them in file \"fileName\". the new types and operators are 
initalized in file \"fileName\": integer are changed to integer[\"S\",16], 
real are changed to real[\"S\",16,16], already bit-True types are conserved. 
Operators \"op\" are initialized to fixedPointOp[op,16,16,16,16,16,16] 
(i.e. fixed point operators with operands and results with 16 bits for 
integral part and 16 bits for fractionnal part) or integerOp[op,16,16,16] 
(i.e. integral operator with operands and results on 16 bits) depending on 
the type (real or integer) of the variable which is on the left hand side 
of the equation in which the operator occurs. 
prepareBitFile[fileName_String,bitWidth:_Integer] does the 
same thing with \"bitWidth\" instead of 16. the file \"fileName\" can
be edited by hand to set more precisely the behaviour of each
operators.";

setBitSize::usage=
"setBitSize[fileName_String] set the bitwidth and operators of $result
from the information contained in file \"fileName\". After execution
of this instruction the Alpha program cannot be visualize with
\"ashow\" (it is no more an Alpha program actually), but the C code
can be generated with cGen";

Begin["`Private`"];

Clear[prepareBitFile];

Clear[findOperator];

findOperator[F_, Expr_, Pos_]:=
Catch[ 
  Module[{Oper, Liste, i},

    (* --- Get the operator *)
    Oper=Part[Expr,0];

    (* --- Traitement en fonction de l operateur --- *)
    Check[
    Switch[
      Oper
    ,
      (* Binary operator *)
      binop
    , 
      WriteString[F, Part[Expr,1], " : ",
		       nouvelOp[Part[Expr,1],$tailleBit,
				expType[$result,
					getPart[$result,
						Join[Take[Pos,2],{1}]]]],
					" \n"];
           Write[F, Append[Pos,1]];
           findOperator[F, Part[Expr,2], Append[Pos,2]];
           findOperator[F, Part[Expr,3], Append[Pos,3]]
    ,
      (* Unary operator *)
      unop
    , 
      findOperator[F, Part[Expr,2], Append[Pos,2]]
    ,
      if
    , 
      findOperator[F, Part[Expr,1], Append[Pos,1]];
      findOperator[F, Part[Expr,2], Append[Pos,2]];
      findOperator[F, Part[Expr,3], Append[Pos,3]]
    ,
      affine
    , 
      findOperator[F, Part[Expr,1], Append[Pos,1]]
    ,
      restrict
    , 
      findOperator[F, Part[Expr,2], Append[Pos,2]]
    ,
      case
    , 
      Liste=Part[Expr,1];
          For[i=1, i<=Length[Liste], i=i+1,
            findOperator[F, Part[Liste,i], Append[Append[Pos,1],i]]
	  ]
    ,
      call
    , 
      Liste=Part[Expr,2];
          For[i=1, i<=Length[Liste], i=i+1,
            findOperator[F, Part[Liste,i], Append[Append[Pos,2],i]]
	  ]
    ,
      reduce
    , 
      findOperator[F, Part[Expr,3], Append[Pos,3]]
	   ],
    findOperator::error = "while running findOperator";
    Throw[ findOperator::error ]
  ] (* end check *)
  ]
];

findOperator::WrongArg="Wrong arguments: `1`";

findOperator[a___]:=Message[findOperator::WrongArg,Map[Head,{a}]];


(* Allows an Alpha program to be pre-processed before C code generation *)

(* Default input file is $result *)
prepareBitFile[NomFichier_String,tailleBits_Integer]:=
  prepareBitFile[$result,NomFichier,tailleBits];

(* Default bit value is 16 *)
prepareBitFile[NomFichier_String]:=
 Module[{}, prepareBitFile[$result,NomFichier,16]];

(* Full form *)
prepareBitFile[sys:_system,NomFichier_String,tailleBits_Integer]:=
Catch[
  Module[{Program, i,j,Liste,Decl, Equa, Expr, Type, Fich},

    (* GLOBAL VARIABLE SET HERE *) 
    $tailleBit=tailleBits;

    (* --- Initialisation de l ecriture du fichier --- *)
    Fich=OpenWrite[NomFichier];
    (* --- Programme a traiter --- *)
    Program=sys;

    (* --- Prise en compte des variabes ---*)
    Print["=> Recherche des variables du programme..."];
    WriteString[Fich, "# Declaration des variables\n"];
    WriteString[Fich, "BeginDec\n"];
    For[i=3, i<=5, i=i+1,
      Liste=Part[Program, i];
      For[j=1, j<=Length[Liste], j=j+1,
        Decl=Part[Liste,j];
        WriteString[Fich, Part[Decl,1], " : ", Part[Decl,2], " : ",
			     nouveauType[Part[Decl,2],tailleBits], " \n"]
       ]
    ];

    WriteString[Fich, "EndDec\n\n"];

    (* --- Prise en compte des operateurs --- *)
    Print["=> Recherche des operateurs du systeme..."];
    WriteString[Fich, "# Operateurs du programme\n"];
    WriteString[Fich, "BeginOper\n"];
    Liste=Part[Program,6];
    For[i=1, i<=Length[Liste], i=i+1,
      Equa=Part[Liste,i];
      Type=Part[Equa,0];
      Switch[
        Type
      ,
        equation
      , 
        findOperator[Fich, Part[Equa,2], List[6,i,2]]
      ,
        use
      , 
        Expr=Part[Equa,4];
        For[j=1, j<=Length[Expr], j=j+1,
          findOperator[Fich, Part[Expr,j], List[6,i,4,j]]
        ] 
      ]    
    ]; 

    WriteString[Fich, "EndOper"];

    (* --- Fermeture du fichier --- *)
    Close[Fich]
  ]
];

prepareBitFile::WrongArg="Wrong arguments `1`";

prepareBitFile[a___]:=Message[prepareBitFile::WrongArg,Map[Head,{a}]];

Clear[nouveauType];

nouveauType[type1_,tailleBits_Integer]:=
  Module[{tailleBitsEntier},
    tailleBitsEntier=4*(Quotient[tailleBits-1,4]+1);
    If [tailleBitsEntier===12,tailleBitsEntier=16];
    If [tailleBitsEntier===20||tailleBitsEntier===24||tailleBitsEntier===28,tailleBitsEntier=32];
    Switch[type1,
		real,"real[\"S\","<>ToString[tailleBits]<>","<>ToString[tailleBits]<>"]",
		real[___],type1,
		integer,"integer[\"S\","<>ToString[tailleBits]<>"]",
		integer[___],type1,
		_,"integer[\"S\","<>ToString[tailleBits]<>"]"]
    ];


nouveauType::WrongArg="Wrong arguments: `1`";

nouveauType[a___]:=Message[nouveauType::WrongArg,Map[Head,{a}]];


Clear[nouvelOp];

nouvelOp[op1_,tailleBits_Integer,type1_]:=
  Module[{functionName,opName,newOpName},
    functionName =
    Switch[
      type1
    ,
      real
    ,
      "fixedPointOp"
    ,
      real[___]
    ,
      "fixedPointOp"
    ,	
      integer
    ,
      "IntegerOp"
    ,
      integer[___]
    ,
      "IntegerOp"
    , 
      _
    ,
      "IntegerOp"
    ];
 	 
    opName =
    Switch[
      op1
    ,
      fixedPointOp[___]
    ,
      ToString[op1[[1]]]
    ,
      integerOp[___]
    ,
      ToString[op1[[1]]]
    ,
      _
    ,
      ToString[op1]
    ];

    newOpName=Switch[type1,
                      real,functionName<>"["<>opName<>","<>ToString[tailleBits]<>","<>
                               ToString[tailleBits]<>","<>ToString[tailleBits]<>","<>
                                 ToString[tailleBits]<>","<>ToString[tailleBits]<>","<>
                                ToString[tailleBits]<>"]",
                      real[___],functionName<>"["<>opName<>","<>ToString[tailleBits]<>","<>
                               ToString[tailleBits]<>","<>ToString[tailleBits]<>","<>
                                 ToString[tailleBits]<>","<>ToString[tailleBits]<>","<>
                                ToString[tailleBits]<>"]",
                      integer,functionName<>"["<>opName<>","<>ToString[tailleBits]<>","<>
                               ToString[tailleBits]<>","<>ToString[tailleBits]<>"]",
                      integer[____],functionName<>"["<>opName<>","<>ToString[tailleBits]<>","<>
                               ToString[tailleBits]<>","<>ToString[tailleBits]<>"]",
                      _, functionName<>"["<>opName<>","<>ToString[tailleBits]<>","<>
                               ToString[tailleBits]<>","<>ToString[tailleBits]<>"]"
     ];
  ];

nouvelOp::WrongArg="Wrong arguments: `1`";

nouvelOp[a___]:=Message[nouvelOp::WrongArg,Map[Head,{a}]];

(*
   - setBitSize: utilise le fichier de bits afin de modifier l ASTST -
   - en affectant une taille aux variables et aux operateurs       - 
   ----------------------------------------------------------------- *)
Clear[setBitSize];

setBitSize[NomFichier_] :=
Catch[ 
  Module[{Fich,Program,Lu,i,j,Liste,Old,New,TypeLu,
				 p0,p1,Posi},

    (* --- Initialisation de la lecture du fichier --- *)
    Check[
      Fich = OpenRead[NomFichier],
      setBitSize::readingfile = "error while reading bit .dat file";
      Throw[ setBisSize::readingfile ];
    ];

    (* --- Programme a traiter --- *)
    Program = Alpha`$result;
    (*
    Print["Program: ", Program ];
     *)

    (* --- Traitement du type des variables --- *)
    Print["=> Mise a jour des variables du programme..."];
    Lu = Read[Fich, String]; (* Entete de la section variables *)
    Lu = Read[Fich, String]; (* BeginDec *)
  
    For[i=3, i<=5, i=i+1,
      Liste = Part[Program, i];
      Print[ Liste ];

      For[j=1, j<=Length[Liste], j=j+1,

        Old = Part[Liste,j,1]; (* Nom de la variable dans le programme *)
        Print[ "Old: ", Old ];
        Lu=Read[Fich,String];
        Print[ "Lu: ", Lu ];
        p0=Part[StringPosition[Lu, ":"],1,1]-2;
        Print[ "p0: ", p0 ];

        New = StringTake[Lu,p0]; (* Nom de la variable dans le fichier *)
        Print[ "New: ", New ];
        If[
          Old!=New,
          Print["Attention: Le fichier a ete modifie!!!"];
          Close[Fich];
          Return[]
        ];
 
        p1 = Part[StringPosition[Lu, ":"],2,1]+2;
        Print["p1: ", p1 ];

        TypeLu=StringTake[Lu,{p1,StringLength[Lu]}]; (* type de la variable *)
        TypeLu=Read[StringToStream[TypeLu]];
        Program=ReplacePart[Program,TypeLu,{i,j,2}]
      ]
    ];

    Lu=Read[Fich, String]; (* EndDec *)
    If[Lu!="EndDec",
      Print["Attention: Le fichier a ete modifie!!!"];
      Close[Fich];
      Return[]
    ];    

    (* --- Traitement du type des operateurs --- *)
    Print["=> Mise a jour des operateurs du programme..."];
    (*    Lu = Read[Fich, String]; (* Ligne vide *)
     Print[ "Lu =", Lu ]; *)
    Lu = Read[Fich, String]; (* Entete de la section operateurs *)
    Print[ "Lu =", Lu ];
    Lu = Read[Fich, String]; (* BeginOper *)
    Print[ "Lu =", Lu ];
    Lu = Read[Fich, String];
    Print[ "Lu =", Lu ];
  
    While[
      Lu!="EndOper",

      p0 = Part[StringPosition[Lu, ":"],1,1]-2;
	  Print[ "p0: ", p0 ];

      New = StringTake[Lu,p0]; (* Operateur ds le fichier *)
      New = Read[StringToStream[New]];     
      p1 = Part[StringPosition[Lu, ":"],1,1]+2;
      TypeLu = StringTake[Lu,{p1,StringLength[Lu]}]; (* Type de l operateur *) 
      TypeLu = Read[StringToStream[TypeLu]];
      Posi = Read[Fich]; (* Position ds l AST *)
      Old = Program;
      For[i=1, i<=Length[Posi], i=i+1,
        Old=Part[Old, Part[Posi,i]] (* Operateur ds l AST *)
      ];

      If[Old!=New,
        Print["Attention: Le fichier a ete modifie!!!"];
        Close[Fich];
        Return[]
      ];

      Program = ReplacePart[Program, TypeLu, Posi];
      (*
      Lu = Read[Fich,String]; (* Lecture bidon *)
       *)
      Lu = Read[Fich,String] (* Operateur suivant *)
    ];

    (* --- Fermeture du fichier --- *)
    Close[Fich];

    (* --- Nouveau programme --- *)
    Alpha`$result=Program
  ]
]

setBitSize::WrongArg="Wrong arguments: `1`"

setBitSize[a___]:=Message[setBitSize::WrongArg,Map[Head,{a}]]

End[] (* --- `Private` --- *)
EndPackage[] (* --- Alpha`BitOperators --- *)
