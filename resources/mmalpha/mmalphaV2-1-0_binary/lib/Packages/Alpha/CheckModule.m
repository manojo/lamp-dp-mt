BeginPackage["Alpha`CheckModule`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
CheckModuleDebug::usage = "Debug Switch";
CheckModuleDebug = False;
CheckModuleTranslatelist::usage = "";
CheckModuleTranslateSYSTEMDECLARATION::usage = "";
CheckModuleTranslateDECLARATION::usage = "";
CheckModuleTranslateDOMAINPARAM::usage = "";
CheckModuleTranslateDOMAIN::usage = "";
CheckModuleTranslatePOLYHEDRON::usage = "";
CheckModuleTranslateCONSTRAINT::usage = "";
CheckModuleTranslateGENERATOR::usage = "";
CheckModuleTranslateEQUATION::usage = "";
CheckModuleTranslateASSIGNMENT::usage = "";
CheckModuleTranslateUSESTATEMENT::usage = "";
CheckModuleTranslateCONNECTION::usage = "";
CheckModuleTranslateCASEXP::usage = "";
CheckModuleTranslateRESTEXP::usage = "";
CheckModuleTranslateAFFEXP::usage = "";
CheckModuleTranslateMATRIX::usage = "";
CheckModuleTranslateMATRIXNUM::usage = "";
CheckModuleTranslateVAREXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","CheckModule.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file CheckModule "]]
];
Clear[ CheckModuleTranslateList ];
CheckModuleTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
CheckModuleTranslateList[ l:{___Real}, opts:___Rule ]:= l;
CheckModuleTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
CheckModuleTranslateList[ l:{___String}, opts:___Rule ]:= l;
CheckModuleTranslateList[ l:___ ]:= 
  If[CheckModuleDebug,Message[ CheckModuleTranslateList::error3, l]];False
Clear[ CheckModuleTranslateSYSTEMDECLARATION ];
CheckModuleTranslateSYSTEMDECLARATION[ x:system[name_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trname, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$name, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ name, _String ],Null, Throw[ Message[ CheckModuleTranslateSYSTEMDECLARATION::error1,name, x] ] ];
      trname = name;
      trparamDecl = CheckModuleTranslateDOMAINPARAM[ paramDecl, opts ];
      trinputDeclList = Map[ CheckModuleTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ CheckModuleTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ CheckModuleTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ CheckModuleTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncCheckModule[system, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateSYSTEMDECLARATION[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ CheckModuleTranslateDECLARATION ];
CheckModuleTranslateDECLARATION[ x:decl[varName_, varType:(integer | boolean | integer[_String, _Integer]), domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ CheckModuleTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ varType, integer | boolean | integer[_String, _Integer] ],Null, Throw[ Message[ CheckModuleTranslateDECLARATION::error1,varType, x] ] ];
      trvarType = varType;
      trdomain = CheckModuleTranslateDOMAIN[ domain, opts ];
    semFuncCheckModule[decl, decl[varName, varType, domain], debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateDECLARATION[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateDECLARATION::error3, x ]];False)

Clear[ CheckModuleTranslateDOMAINPARAM ];
CheckModuleTranslateDOMAINPARAM[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckModuleTranslateDOMAINPARAM::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckModuleTranslateDOMAINPARAM::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckModuleTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    dimension  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateDOMAINPARAM[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateDOMAINPARAM::error3, x ]];False)

Clear[ CheckModuleTranslateDOMAIN ];
CheckModuleTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckModuleTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckModuleTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckModuleTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    dimension  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateDOMAIN[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateDOMAIN::error3, x ]];False)

Clear[ CheckModuleTranslatePOLYHEDRON ];
CheckModuleTranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ CheckModuleTranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ CheckModuleTranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ CheckModuleTranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ CheckModuleTranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ CheckModuleTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ CheckModuleTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslatePOLYHEDRON[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslatePOLYHEDRON::error3, x ]];False)

Clear[ CheckModuleTranslateCONSTRAINT ];
CheckModuleTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckModuleTranslateList[ x, opts ],
        _, (If[CheckModuleDebug,Message[ CheckModuleTranslateCONSTRAINT::error3, x ]];False)
    ];

CheckModuleTranslateCONSTRAINT[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateCONSTRAINT::error3, x ]];False)

Clear[ CheckModuleTranslateGENERATOR ];
CheckModuleTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckModuleTranslateList[ x, opts ],
        _, (If[CheckModuleDebug,Message[ CheckModuleTranslateGENERATOR::error3, x ]];False)
    ];

CheckModuleTranslateGENERATOR[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateGENERATOR::error3, x ]];False)

Clear[ CheckModuleTranslateEQUATION ];
CheckModuleTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, CheckModuleTranslateASSIGNMENT[ x, opts ],
        _use, CheckModuleTranslateUSESTATEMENT[ x, opts ],
        _, (If[CheckModuleDebug,Message[ CheckModuleTranslateEQUATION::error3, x ]];False)
    ];

CheckModuleTranslateEQUATION[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateEQUATION::error3, x ]];False)

Clear[ CheckModuleTranslateASSIGNMENT ];
CheckModuleTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ CheckModuleTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = CheckModuleTranslateCONNECTION[ rightHandSide, opts ];
    semFuncCheckModule[assignment, trrightHandSide, equation[leftHandSide, rightHandSide], debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateASSIGNMENT[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateASSIGNMENT::error3, x ]];False)

Clear[ CheckModuleTranslateUSESTATEMENT ];
CheckModuleTranslateUSESTATEMENT[ x:use[id_, extension_, paramAssign_, inputList_, idList:{___String}], opts:___Rule ] :=
Module[ {trid, trextension, trparamAssign, trinputList, tridList, tr$id, tr$extension, tr$paramAssign, tr$inputList, tr$idList},
  Catch[
      If[ MatchQ[ id, _String ],Null, Throw[ Message[ CheckModuleTranslateUSESTATEMENT::error1,id, x] ] ];
      trid = id;
      trextension = CheckModuleTranslateDOMAIN[ extension, opts ];
      trparamAssign = CheckModuleTranslateMATRIX[ paramAssign, opts ];
      trinputList = Map[ CheckModuleTranslateVAREXP[#,opts]&, inputList ];
      tr$inputList = trinputList;
      If[ MatchQ[ idList, {___String} ],Null, Throw[ Message[ CheckModuleTranslateUSESTATEMENT::error1,idList, x] ] ];
      tridList = idList;
    semFuncCheckModule[use, {id, extension, paramAssign, inputList, idList}, debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateUSESTATEMENT[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateUSESTATEMENT::error3, x ]];False)

Clear[ CheckModuleTranslateCONNECTION ];
CheckModuleTranslateCONNECTION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, CheckModuleTranslateCASEXP[ x, opts ],
        _restrict, CheckModuleTranslateRESTEXP[ x, opts ],
        _affine, CheckModuleTranslateAFFEXP[ x, opts ],
        _, (If[CheckModuleDebug,Message[ CheckModuleTranslateCONNECTION::error3, x ]];False)
    ];

CheckModuleTranslateCONNECTION[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateCONNECTION::error3, x ]];False)

Clear[ CheckModuleTranslateCASEXP ];
CheckModuleTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ CheckModuleTranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    semFuncCheckModule[case, trexpressionList, debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateCASEXP[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateCASEXP::error3, x ]];False)

Clear[ CheckModuleTranslateRESTEXP ];
CheckModuleTranslateRESTEXP[ x:restrict[domain_, expression_], opts:___Rule ] :=
Module[ {trdomain, trexpression, tr$domain, tr$expression},
  Catch[
      trdomain = CheckModuleTranslateDOMAIN[ domain, opts ];
      trexpression = CheckModuleTranslateAFFEXP[ expression, opts ];
    semFuncCheckModule[restrict, trdomain, trexpression, debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateRESTEXP[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateRESTEXP::error3, x ]];False)

Clear[ CheckModuleTranslateAFFEXP ];
CheckModuleTranslateAFFEXP[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = CheckModuleTranslateVAREXP[ expression, opts ];
      traffineFunction = CheckModuleTranslateMATRIX[ affineFunction, opts ];
    semFuncCheckModule[affexp, traffExpression, affineFunction, debug -> CheckModuleDebug]  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateAFFEXP[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateAFFEXP::error3, x ]];False)

Clear[ CheckModuleTranslateMATRIX ];
CheckModuleTranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trmmaMatrix, tr$d1, tr$d2, tr$in, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ CheckModuleTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ CheckModuleTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ CheckModuleTranslateMATRIX::error1,in, x] ] ];
      trin = in;
      trmmaMatrix = CheckModuleTranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateMATRIX[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateMATRIX::error3, x ]];False)

Clear[ CheckModuleTranslateMATRIXNUM ];
CheckModuleTranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ CheckModuleTranslateList[#,opts]&, x ],
        _, (If[CheckModuleDebug,Message[ CheckModuleTranslateMATRIXNUM::error3, x ]];False)
    ];

CheckModuleTranslateMATRIXNUM[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateMATRIXNUM::error3, x ]];False)

Clear[ CheckModuleTranslateVAREXP ];
CheckModuleTranslateVAREXP[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ CheckModuleTranslateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    Null  ] (* End Catch *)
]; (* End Module *)
CheckModuleTranslateVAREXP[ x:___ ] := (If[CheckModuleDebug,Message[ CheckModuleTranslateVAREXP::error3, x ]];False)

End[];
EndPackage[];
