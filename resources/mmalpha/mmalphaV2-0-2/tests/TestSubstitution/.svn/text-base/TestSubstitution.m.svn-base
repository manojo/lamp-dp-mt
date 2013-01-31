BeginPackage["Alpha`TestSubstitution`",
	     {"Alpha`","Alpha`Domlib`","Alpha`Substitution`","Alpha`Static`"}];

Begin["`Private`"];

(* Test of Substitution.m *)

Module[{p1,p2,p3,p4,p5,res,A,B,bb},

$testResult = True; 

res = 
{
  (* Test of substituteInDef *)

  testFunction[
    load["test_subs.alpha"];
    substituteInDef["A","B"],
    <<AST1,"Substitution 1"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    substituteInDef["A","B"],
    <<AST2,"Substitution 2"]
,
  testFunction[
    load["test_subs.alpha"];
    replaceDefinition["A","a"],
    <<AST3,
    "Substitution 3"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    replaceDefinition[A,"a.b.c"],
    $Failed,
    "Substitution 4"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    replaceDefinition[A.bb,"a"],$Failed,
    "Substitution 5"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    substituteInDef[A,B,{1,3}],
    Null,
    "Substitution 6"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    !unusedVarQ[B],True,
    "Substitution 7"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    removeUnusedVar["B"],
    <<AST4,
    "Substitution 8"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    substituteInDef["A","B"];
    unusedVarQ["B"],
    True,
    "Substitution 9"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    substituteInDef["A","B"];
    removeUnusedVar["B"],
    <<AST5,
    "Substitution 10"
  ]
,
  testFunction[
    load["test_subs2.alpha"];
    ashow[];
    addLocal["E","A+A"];
    (Length[$result[[6]]]===5)&&analyze[verbose->False],
    True,
    "Substitution 11"
  ]
,

  testFunction[
    load["test_subs2.alpha"];p1=$result;
    addLocal["E","A+A"];
    Length[$result[[6]]]+Length[p1[[6]]]===9,
    True,
    "Substitution 12"
  ]
,
  testFunction[
    load["test_subs2.alpha"];
    addLocal["E",{6,1,2,1,2,2}]; p1 = $result;
    (p1[[1]]==="bidon")&&(Length[p1[[6]]]===5),
   True,
    "Substitution 13"
  ]
,
  testFunction[
    load["test_subs2.alpha"];
    addLocal["E",{{6,1,2,1,2,2}}]; p1 = $result;
    (p1[[1]]==="bidon")&&(Length[p1[[6]]]===5)&&
    (analyze[p1,{verbose->False}]),
    True,
    "Substitution 14"
  ]
,
  testFunction[
    load["test_subs2.alpha"];
    addlocal["E",{{6,1,2,1,2,2,2,2},{6,1,2,1,1,2}}]; p1 = $result;
    (p1[[1]]==="bidon")&&(Length[p1[[6]]]===5)
    &&(analyze[p1,{verbose->False}]),
    True,
    "Substitution 15"
  ]
,
  testFunction[
    load["test_subs2.alpha"];
    addlocal["E",{{6,1,2,1,1,2},{6,1,2,1,2,2,2,1}}]; p1 = $result;
    (p1[[1]]==="bidon")&&(Length[p1[[6]]]===4)
     &&(analyze[p1,{verbose->False}]),True,
    "Substitution 16"
  ]
,
  testFunction[
    load["test_subs2.alpha"]; p1 = $result;
    addLocalLHS["E","A+A"]; 
    Length[$result[[6]]]+Length[p1[[6]]]===9,True,
    "Substitution 17"
  ]
,
  testFunction[
    load["test_subs2.alpha"]; 
    addLocalLHS["E",{6,1,2,1,2,2}]; p1 = $result;
    (p1[[1]]==="bidon")&&(Length[p1[[6]]]===5),True,
    "Substitution 18"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    substituteInDef["Y","X"],
    <<ZAST1,
    "Substitution 19"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    replaceDefinition["Y",
      "case { i,j |j = N-1} : w.(i,j->2j); {i,j |j < N-1} : Y.(i,j->3i,j/2);esac"],
    <<ZAST2,
    "Substitution 20"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    getOccurs["X.(i,j->3i,j)"],
    {{6,2,2,1,1,1,2,3},{6,2,2,1,1,2,2,3,3}},
    "Substitution 21"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    getOccursInDef["y","X.(i,j->3i,j)"],
    {},
    "Substitution 22"
  ]
,
  testFunction[
    occursInDefQ["Y","w.(i,j->j)*X.(i,j->3i,j)"],
    True,
    "Substitution 23"
  ]
,
  testFunction[
    unusedVarQ["Z"],
    True,
    "Substitution 24"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    removeAllUnusedVars[],
    <<ZAST3,
    "Substitution 25"
  ]
(*
,
  testFunction[
    load["test_subs4.alpha"];
    addlocal["new","w.(i,j->j)*X.(i,j->3i,j)"],
    <<ZAST4,
    "Substitution 26"
  ]
 *)
,
  testFunction[
    load["test_subs4.alpha"];
    isOutputRegular["y"],
    True,
    "Substitution 27"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    isOutputRegular["Z"],
    Null,
    "Substitution 28"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    areAllOutputsRegular[],
    True,
    "Substitution 29"
  ]
,
  testFunction[
    load["test_subs.alpha"];
    areAllOutputsRegular[],                
    True,
    "Substitution 30"
  ]
,
  testFunction[
    load["test_subs4.alpha"];
    mkOutputRegular["y"];,
    Null,
    "Substitution 31"
  ]

};


$testResult = $testResult && Apply[And,res];

]

End[];

EndPackage[];
