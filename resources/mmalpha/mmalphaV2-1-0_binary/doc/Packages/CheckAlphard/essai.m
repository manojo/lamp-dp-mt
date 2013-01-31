(*=================================================================*)
(*                     Semantic actions of the                     *)
(*                   Meta-Syntax for Controllers                   *)
(*                       in  AlpHard Program                       *)
(*=================================================================*)
(*All the function have the same name. The difference is made by   *)
(*the pattern.                                                     *)
(*When there is no problem the function "Print" information and    *)
(*the result is Null  (the result of a Print is Null)              *)
(*When there is a problem the result is a error message            *)
(*Some conditions are verify by the syntax and other ones by the   *)
(*semantic                                                         *)
(*=================================================================*)


(*=================================================================*)
(*Here the global variable *)

$NbParam::usage = "$NbParam est une variable globale pour Meta...";

(*=================================================================*)

Clear[ semanticFunction ]; 

(*============*)
(*   SYSTEM   *)
(*============*)

semanticFunction[ system , x:{name:_, paramDecl:_, inputDeclList:_, outputDeclList:_, localDeclList:_, trequationBlock:_} ,opts:___Rule] := 
Module[{  },	
    Catch[
(*In a controller we have no inputs this condition is verify by the syntax*)
      	    If[ inputDeclList==={}, 
		(*then*)Print["There is no inputs"] ,
		(*else*)Throw[ Message [ semanticFunction::error, inputDeclList] ]      (*Never used beacause It's a syntax error*)
	      ];
         ];
       ];

(*===========================*)
(* Declarations of variables *)
(*===========================*)

semanticFunction[ decl , {varName:_, type:_, trdomain:_}, opts:___Rule] := 
Module[{  },	
    Catch[
(*In a controller inputs are allways boolean this condition is verify by the syntax*)
      	    If[ type === boolean , 
		(*then*)Print["The output is boolean"] ,
		(*else*)Throw[ Message [ semanticFunction::error, type] ]
						(*Never used beacause It's a syntax error*)
	      ];
         ];
       ];


(*======================*)
(* Domain specification *)
(*======================*)

Clear[ getDimension ]; 

getDimension[ domain , { dimension:_, indexList:_, polyedronList:_ }] :=
Module[{  },
(*Here we get the number of parameters and put it in a global variable*)
$NbParam = dimension;
	
	];

semanticFunction::undef = "trying to evaluate an undefined variable instance";



(* Error case *)
General::undef = "trying to evaluate an undefined variable instance.";
semanticFunction[x:___] := 
Module[{  },	
	Print["semanticFunction applied to ", x ];Message[ semanticFunction::params ];
      ];

