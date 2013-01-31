BeginPackage["Alpha`CheckAlpha0`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
CheckAlpha0Debug::usage = "Debug Switch";
CheckAlpha0Debug = False;
CheckAlpha0Translatelist::usage = "";
CheckAlpha0TranslateSYSTEMDECLARATION::usage = "";
CheckAlpha0TranslateDECLARATION::usage = "";
CheckAlpha0TranslateDOMAINPARAM::usage = "";
CheckAlpha0TranslateDOMAIN::usage = "";
CheckAlpha0TranslatePOLYHEDRON::usage = "";
CheckAlpha0TranslateCONSTRAINT::usage = "";
CheckAlpha0TranslateGENERATOR::usage = "";
CheckAlpha0TranslateEQUATION::usage = "";
CheckAlpha0TranslateASSIGNMENT::usage = "";
CheckAlpha0TranslateUSESTATEMENT::usage = "";
CheckAlpha0TranslateRHSEQ::usage = "";
CheckAlpha0TranslateCASEXP::usage = "";
CheckAlpha0TranslateRESTEXP::usage = "";
CheckAlpha0TranslateAFFEXP::usage = "";
CheckAlpha0TranslateMATRIX::usage = "";
CheckAlpha0TranslateMATRIXNUM::usage = "";
CheckAlpha0TranslateVAREXP::usage = "";
CheckAlpha0TranslateDONOTCHECK::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","CheckAlpha0.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file CheckAlpha0 "]]
];
Clear[ CheckAlpha0TranslateList ];
CheckAlpha0TranslateList[ l:{___Integer}, opts:___Rule ]:= l;
CheckAlpha0TranslateList[ l:{___Real}, opts:___Rule ]:= l;
CheckAlpha0TranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
CheckAlpha0TranslateList[ l:{___String}, opts:___Rule ]:= l;
CheckAlpha0TranslateList[ l:___ ]:= 
  If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateList::error3, l]];False
Clear[ CheckAlpha0TranslateSYSTEMDECLARATION ];
CheckAlpha0TranslateSYSTEMDECLARATION[ x:system[name_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trname, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$name, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ name, _String ],Null, Throw[ Message[ CheckAlpha0TranslateSYSTEMDECLARATION::error1,name, x] ] ];
      trname = name;
      trparamDecl = CheckAlpha0TranslateDOMAINPARAM[ paramDecl, opts ];
      trinputDeclList = Map[ CheckAlpha0TranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ CheckAlpha0TranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ CheckAlpha0TranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ CheckAlpha0TranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncCheckAlpha0[system, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateSYSTEMDECLARATION[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ CheckAlpha0TranslateDECLARATION ];
CheckAlpha0TranslateDECLARATION[ x:decl[varName_, varType:(integer | boolean | integer[_String, _Integer]), domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ CheckAlpha0TranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ varType, integer | boolean | integer[_String, _Integer] ],Null, Throw[ Message[ CheckAlpha0TranslateDECLARATION::error1,varType, x] ] ];
      trvarType = varType;
      trdomain = CheckAlpha0TranslateDOMAIN[ domain, opts ];
    semFuncCheckAlpha0[decl, decl[varName, varType, domain], debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateDECLARATION[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateDECLARATION::error3, x ]];False)

Clear[ CheckAlpha0TranslateDOMAINPARAM ];
CheckAlpha0TranslateDOMAINPARAM[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslateDOMAINPARAM::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckAlpha0TranslateDOMAINPARAM::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckAlpha0TranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    dimension  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateDOMAINPARAM[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateDOMAINPARAM::error3, x ]];False)

Clear[ CheckAlpha0TranslateDOMAIN ];
CheckAlpha0TranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckAlpha0TranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckAlpha0TranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    dimension  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateDOMAIN[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateDOMAIN::error3, x ]];False)

Clear[ CheckAlpha0TranslatePOLYHEDRON ];
CheckAlpha0TranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ CheckAlpha0TranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ CheckAlpha0TranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslatePOLYHEDRON[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslatePOLYHEDRON::error3, x ]];False)

Clear[ CheckAlpha0TranslateCONSTRAINT ];
CheckAlpha0TranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckAlpha0TranslateList[ x, opts ],
        _, (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateCONSTRAINT::error3, x ]];False)
    ];

CheckAlpha0TranslateCONSTRAINT[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateCONSTRAINT::error3, x ]];False)

Clear[ CheckAlpha0TranslateGENERATOR ];
CheckAlpha0TranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckAlpha0TranslateList[ x, opts ],
        _, (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateGENERATOR::error3, x ]];False)
    ];

CheckAlpha0TranslateGENERATOR[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateGENERATOR::error3, x ]];False)

Clear[ CheckAlpha0TranslateEQUATION ];
CheckAlpha0TranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _use, CheckAlpha0TranslateUSESTATEMENT[ x, opts ],
        _?(isMirrorEqQ[$current, #1] & ), CheckAlpha0TranslateDONOTCHECK[ x, opts ],
        _?(!isMirrorEqQ[$current, #1] & ), CheckAlpha0TranslateASSIGNMENT[ x, opts ],
        _, (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateEQUATION::error3, x ]];False)
    ];

CheckAlpha0TranslateEQUATION[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateEQUATION::error3, x ]];False)

Clear[ CheckAlpha0TranslateASSIGNMENT ];
CheckAlpha0TranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ CheckAlpha0TranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = CheckAlpha0TranslateRHSEQ[ rightHandSide, opts ];
    semFuncCheckAlpha0[assignment, rightHandSide, equation[leftHandSide, rightHandSide], debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateASSIGNMENT[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateASSIGNMENT::error3, x ]];False)

Clear[ CheckAlpha0TranslateUSESTATEMENT ];
CheckAlpha0TranslateUSESTATEMENT[ x:use[id_, extension_, paramAssign_, inputList_, idList:{___String}], opts:___Rule ] :=
Module[ {trid, trextension, trparamAssign, trinputList, tridList, tr$id, tr$extension, tr$paramAssign, tr$inputList, tr$idList},
  Catch[
      If[ MatchQ[ id, _String ],Null, Throw[ Message[ CheckAlpha0TranslateUSESTATEMENT::error1,id, x] ] ];
      trid = id;
      trextension = CheckAlpha0TranslateDOMAIN[ extension, opts ];
      trparamAssign = CheckAlpha0TranslateMATRIX[ paramAssign, opts ];
      trinputList = Map[ CheckAlpha0TranslateVAREXP[#,opts]&, inputList ];
      tr$inputList = trinputList;
      If[ MatchQ[ idList, {___String} ],Null, Throw[ Message[ CheckAlpha0TranslateUSESTATEMENT::error1,idList, x] ] ];
      tridList = idList;
    semFuncCheckAlpha0[use, {id, extension, paramAssign, inputList, idList}, debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateUSESTATEMENT[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateUSESTATEMENT::error3, x ]];False)

Clear[ CheckAlpha0TranslateRHSEQ ];
CheckAlpha0TranslateRHSEQ[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, CheckAlpha0TranslateCASEXP[ x, opts ],
        _restrict, CheckAlpha0TranslateRESTEXP[ x, opts ],
        _affine, CheckAlpha0TranslateAFFEXP[ x, opts ],
        _binop, CheckAlpha0TranslateDONOTCHECK[ x, opts ],
        _, (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateRHSEQ::error3, x ]];False)
    ];

CheckAlpha0TranslateRHSEQ[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateRHSEQ::error3, x ]];False)

Clear[ CheckAlpha0TranslateCASEXP ];
CheckAlpha0TranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ CheckAlpha0TranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    semFuncCheckAlpha0[case, trexpressionList, debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateCASEXP[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateCASEXP::error3, x ]];False)

Clear[ CheckAlpha0TranslateRESTEXP ];
CheckAlpha0TranslateRESTEXP[ x:restrict[domain_, expression_], opts:___Rule ] :=
Module[ {trdomain, trexpression, tr$domain, tr$expression},
  Catch[
      trdomain = CheckAlpha0TranslateDOMAIN[ domain, opts ];
      trexpression = CheckAlpha0TranslateAFFEXP[ expression, opts ];
    semFuncCheckAlpha0[restrict, trdomain, trexpression, debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateRESTEXP[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateRESTEXP::error3, x ]];False)

Clear[ CheckAlpha0TranslateAFFEXP ];
CheckAlpha0TranslateAFFEXP[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = CheckAlpha0TranslateVAREXP[ expression, opts ];
      traffineFunction = CheckAlpha0TranslateMATRIX[ affineFunction, opts ];
    semFuncCheckAlpha0[affexp, traffExpression, affineFunction, debug -> CheckAlpha0Debug]  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateAFFEXP[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateAFFEXP::error3, x ]];False)

Clear[ CheckAlpha0TranslateMATRIX ];
CheckAlpha0TranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trmmaMatrix, tr$d1, tr$d2, tr$in, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ CheckAlpha0TranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ CheckAlpha0TranslateMATRIX::error1,in, x] ] ];
      trin = in;
      trmmaMatrix = CheckAlpha0TranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateMATRIX[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateMATRIX::error3, x ]];False)

Clear[ CheckAlpha0TranslateMATRIXNUM ];
CheckAlpha0TranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ CheckAlpha0TranslateList[#,opts]&, x ],
        _, (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateMATRIXNUM::error3, x ]];False)
    ];

CheckAlpha0TranslateMATRIXNUM[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateMATRIXNUM::error3, x ]];False)

Clear[ CheckAlpha0TranslateVAREXP ];
CheckAlpha0TranslateVAREXP[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ CheckAlpha0TranslateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    Null  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateVAREXP[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateVAREXP::error3, x ]];False)

Clear[ CheckAlpha0TranslateDONOTCHECK ];
CheckAlpha0TranslateDONOTCHECK[ x:_, opts:___Rule ] :=
Module[ {},
  Catch[
    True  ] (* End Catch *)
]; (* End Module *)
CheckAlpha0TranslateDONOTCHECK[ x:___ ] := (If[CheckAlpha0Debug,Message[ CheckAlpha0TranslateDONOTCHECK::error3, x ]];False)

End[];
EndPackage[];
