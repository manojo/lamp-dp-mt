BeginPackage["Alpha`CheckCell`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
CheckCellDebug::usage = "Debug Switch";
CheckCellDebug = False;
CheckCellTranslatelist::usage = "";
CheckCellTranslateSYSTEMDECLARATION::usage = "";
CheckCellTranslateDECLARATION::usage = "";
CheckCellTranslateDOMAINPARAM::usage = "";
CheckCellTranslateDOMAIN::usage = "";
CheckCellTranslatePOLYHEDRON::usage = "";
CheckCellTranslateCONSTRAINT::usage = "";
CheckCellTranslateGENERATOR::usage = "";
CheckCellTranslateEQUATION::usage = "";
CheckCellTranslateASSIGNMENT::usage = "";
CheckCellTranslateELEMENTS::usage = "";
CheckCellTranslateAFFEXP::usage = "";
CheckCellTranslateMATRIX::usage = "";
CheckCellTranslateMATRIXNUM::usage = "";
CheckCellTranslateBINEXP::usage = "";
CheckCellTranslateUNEXP::usage = "";
CheckCellTranslateVAREXPORCONST::usage = "";
CheckCellTranslateVAREXPE::usage = "";
CheckCellTranslateCONSTEXPE::usage = "";
CheckCellTranslateVAREXP::usage = "";
CheckCellTranslateCONSTEXP::usage = "";
CheckCellTranslateSUBEXPRESSION::usage = "";
CheckCellTranslateCASEMUX::usage = "";
CheckCellTranslateRESTEXP::usage = "";
CheckCellTranslateIFEXP::usage = "";
CheckCellTranslateCONTROLEXPRESSION::usage = "";
CheckCellTranslateIFMUX::usage = "";
CheckCellTranslateSUBMUX2::usage = "";
CheckCellTranslateCASEXP::usage = "";
CheckCellTranslateRESTEXPMUX2::usage = "";
CheckCellTranslateUSESTATEMENT::usage = "";
CheckCellTranslateCALLEXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","CheckCell.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file CheckCell "]]
];
Clear[ CheckCellTranslateList ];
CheckCellTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
CheckCellTranslateList[ l:{___Real}, opts:___Rule ]:= l;
CheckCellTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
CheckCellTranslateList[ l:{___String}, opts:___Rule ]:= l;
CheckCellTranslateList[ l:___ ]:= 
  If[CheckCellDebug,Message[ CheckCellTranslateList::error3, l]];False
Clear[ CheckCellTranslateSYSTEMDECLARATION ];
CheckCellTranslateSYSTEMDECLARATION[ x:system[systemName_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trsystemName, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$systemName, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ systemName, _String ],Null, Throw[ Message[ CheckCellTranslateSYSTEMDECLARATION::error1,systemName, x] ] ];
      trsystemName = systemName;
      trparamDecl = CheckCellTranslateDOMAINPARAM[ paramDecl, opts ];
      trinputDeclList = Map[ CheckCellTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ CheckCellTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ CheckCellTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ CheckCellTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncCheckCell[system, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateSYSTEMDECLARATION[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ CheckCellTranslateDECLARATION ];
CheckCellTranslateDECLARATION[ x:decl[varName_, varType:boolean | integer | integer[_, _], domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ CheckCellTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ varType, boolean | integer | integer[_, _] ],Null, Throw[ Message[ CheckCellTranslateDECLARATION::error1,varType, x] ] ];
      trvarType = varType;
      trdomain = CheckCellTranslateDOMAIN[ domain, opts ];
    semFuncCheckCell[decl, decl[varName, varType, domain], debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateDECLARATION[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateDECLARATION::error3, x ]];False)

Clear[ CheckCellTranslateDOMAINPARAM ];
CheckCellTranslateDOMAINPARAM[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckCellTranslateDOMAINPARAM::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckCellTranslateDOMAINPARAM::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckCellTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    semFuncCheckCell[domain, dimension, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateDOMAINPARAM[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateDOMAINPARAM::error3, x ]];False)

Clear[ CheckCellTranslateDOMAIN ];
CheckCellTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckCellTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckCellTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckCellTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    dimension  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateDOMAIN[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateDOMAIN::error3, x ]];False)

Clear[ CheckCellTranslatePOLYHEDRON ];
CheckCellTranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ CheckCellTranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ CheckCellTranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ CheckCellTranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ CheckCellTranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ CheckCellTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ CheckCellTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslatePOLYHEDRON[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslatePOLYHEDRON::error3, x ]];False)

Clear[ CheckCellTranslateCONSTRAINT ];
CheckCellTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckCellTranslateList[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateCONSTRAINT::error3, x ]];False)
    ];

CheckCellTranslateCONSTRAINT[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCONSTRAINT::error3, x ]];False)

Clear[ CheckCellTranslateGENERATOR ];
CheckCellTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckCellTranslateList[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateGENERATOR::error3, x ]];False)
    ];

CheckCellTranslateGENERATOR[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateGENERATOR::error3, x ]];False)

Clear[ CheckCellTranslateEQUATION ];
CheckCellTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, CheckCellTranslateASSIGNMENT[ x, opts ],
        _use, CheckCellTranslateUSESTATEMENT[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateEQUATION::error3, x ]];False)
    ];

CheckCellTranslateEQUATION[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateEQUATION::error3, x ]];False)

Clear[ CheckCellTranslateASSIGNMENT ];
CheckCellTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ CheckCellTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = CheckCellTranslateELEMENTS[ rightHandSide, opts ];
    semFuncCheckCell[assignment, trrightHandSide, equation[leftHandSide, rightHandSide], debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateASSIGNMENT[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateASSIGNMENT::error3, x ]];False)

Clear[ CheckCellTranslateELEMENTS ];
CheckCellTranslateELEMENTS[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, CheckCellTranslateCASEMUX[ x, opts ],
        _if, CheckCellTranslateIFMUX[ x, opts ],
        _affine, CheckCellTranslateAFFEXP[ x, opts ],
        _binop, CheckCellTranslateBINEXP[ x, opts ],
        _unop, CheckCellTranslateUNEXP[ x, opts ],
        _var, CheckCellTranslateVAREXP[ x, opts ],
        _const, CheckCellTranslateCONSTEXP[ x, opts ],
        _call, CheckCellTranslateCALLEXP[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateELEMENTS::error3, x ]];False)
    ];

CheckCellTranslateELEMENTS[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateELEMENTS::error3, x ]];False)

Clear[ CheckCellTranslateAFFEXP ];
CheckCellTranslateAFFEXP[ x:affine[affExpression_, affineFunction_], opts:___Rule ] :=
Module[ {traffExpression, traffineFunction, tr$affExpression, tr$affineFunction},
  Catch[
      traffExpression = CheckCellTranslateVAREXPORCONST[ affExpression, opts ];
      traffineFunction = CheckCellTranslateMATRIX[ affineFunction, opts ];
    semFuncCheckCell[affexp, traffExpression, affineFunction, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateAFFEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateAFFEXP::error3, x ]];False)

Clear[ CheckCellTranslateMATRIX ];
CheckCellTranslateMATRIX[ x:matrix[d1_, d2_, indexes:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trindexes, trmmaMatrix, tr$d1, tr$d2, tr$indexes, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ CheckCellTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ CheckCellTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ indexes, {___String} ],Null, Throw[ Message[ CheckCellTranslateMATRIX::error1,indexes, x] ] ];
      trindexes = indexes;
      trmmaMatrix = CheckCellTranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateMATRIX[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateMATRIX::error3, x ]];False)

Clear[ CheckCellTranslateMATRIXNUM ];
CheckCellTranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ CheckCellTranslateList[#,opts]&, x ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateMATRIXNUM::error3, x ]];False)
    ];

CheckCellTranslateMATRIXNUM[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateMATRIXNUM::error3, x ]];False)

Clear[ CheckCellTranslateBINEXP ];
CheckCellTranslateBINEXP[ x:binop[binaryOp:add | sub | mul | div | or | and | xor | min | max | eq | ne | le | lt | gt | ge | minus | div | mod, operand1_, operand2_], opts:___Rule ] :=
Module[ {trbinaryOp, troperand1, troperand2, tr$binaryOp, tr$operand1, tr$operand2},
  Catch[
      If[ MatchQ[ binaryOp, add | sub | mul | div | or | and | xor | min | max | eq | ne | le | lt | gt | ge | minus | div | mod ],Null, Throw[ Message[ CheckCellTranslateBINEXP::error1,binaryOp, x] ] ];
      trbinaryOp = binaryOp;
      troperand1 = CheckCellTranslateSUBEXPRESSION[ operand1, opts ];
      troperand2 = CheckCellTranslateSUBEXPRESSION[ operand2, opts ];
    semFuncCheckCell[binop, troperand1, troperand2, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateBINEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateBINEXP::error3, x ]];False)

Clear[ CheckCellTranslateUNEXP ];
CheckCellTranslateUNEXP[ x:unop[unaryOp:neg | not | sqrt, operand_], opts:___Rule ] :=
Module[ {trunaryOp, troperand, tr$unaryOp, tr$operand},
  Catch[
      If[ MatchQ[ unaryOp, neg | not | sqrt ],Null, Throw[ Message[ CheckCellTranslateUNEXP::error1,unaryOp, x] ] ];
      trunaryOp = unaryOp;
      troperand = CheckCellTranslateSUBEXPRESSION[ operand, opts ];
    troperand  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateUNEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateUNEXP::error3, x ]];False)

Clear[ CheckCellTranslateVAREXPORCONST ];
CheckCellTranslateVAREXPORCONST[ x:_, opts:___Rule ] :=
    Switch[ x,
        _var, CheckCellTranslateVAREXPE[ x, opts ],
        _const, CheckCellTranslateCONSTEXPE[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateVAREXPORCONST::error3, x ]];False)
    ];

CheckCellTranslateVAREXPORCONST[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateVAREXPORCONST::error3, x ]];False)

Clear[ CheckCellTranslateVAREXPE ];
CheckCellTranslateVAREXPE[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ CheckCellTranslateVAREXPE::error1,identifier, x] ] ];
      tridentifier = identifier;
    var[identifier]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateVAREXPE[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateVAREXPE::error3, x ]];False)

Clear[ CheckCellTranslateCONSTEXPE ];
CheckCellTranslateCONSTEXPE[ x:const[constant:_Integer | _Real | True | False], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],Null, Throw[ Message[ CheckCellTranslateCONSTEXPE::error1,constant, x] ] ];
      trconstant = constant;
    const[constant]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateCONSTEXPE[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCONSTEXPE::error3, x ]];False)

Clear[ CheckCellTranslateVAREXP ];
CheckCellTranslateVAREXP[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ CheckCellTranslateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    True  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateVAREXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateVAREXP::error3, x ]];False)

Clear[ CheckCellTranslateCONSTEXP ];
CheckCellTranslateCONSTEXP[ x:const[constant:_Integer | _Real | True | False], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],Null, Throw[ Message[ CheckCellTranslateCONSTEXP::error1,constant, x] ] ];
      trconstant = constant;
    True  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateCONSTEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCONSTEXP::error3, x ]];False)

Clear[ CheckCellTranslateSUBEXPRESSION ];
CheckCellTranslateSUBEXPRESSION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _affine, CheckCellTranslateAFFEXP[ x, opts ],
        _binop, CheckCellTranslateBINEXP[ x, opts ],
        _unop, CheckCellTranslateUNEXP[ x, opts ],
        _var, CheckCellTranslateVAREXP[ x, opts ],
        _const, CheckCellTranslateCONSTEXP[ x, opts ],
        _call, CheckCellTranslateCALLEXP[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateSUBEXPRESSION::error3, x ]];False)
    ];

CheckCellTranslateSUBEXPRESSION[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateSUBEXPRESSION::error3, x ]];False)

Clear[ CheckCellTranslateCASEMUX ];
CheckCellTranslateCASEMUX[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ CheckCellTranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    semFuncCheckCell[case, trexpressionList, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateCASEMUX[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCASEMUX::error3, x ]];False)

Clear[ CheckCellTranslateRESTEXP ];
CheckCellTranslateRESTEXP[ x:restrict[domain_, ifExpression_], opts:___Rule ] :=
Module[ {trdomain, trifExpression, tr$domain, tr$ifExpression},
  Catch[
      trdomain = CheckCellTranslateDOMAIN[ domain, opts ];
      trifExpression = CheckCellTranslateIFEXP[ ifExpression, opts ];
    semFuncCheckCell[restrict, trdomain, trifExpression, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateRESTEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateRESTEXP::error3, x ]];False)

Clear[ CheckCellTranslateIFEXP ];
CheckCellTranslateIFEXP[ x:if[ifCondition_, alt1_, alt2_], opts:___Rule ] :=
Module[ {trifCondition, tralt1, tralt2, tr$ifCondition, tr$alt1, tr$alt2},
  Catch[
      trifCondition = CheckCellTranslateCONTROLEXPRESSION[ ifCondition, opts ];
      tralt1 = CheckCellTranslateSUBEXPRESSION[ alt1, opts ];
      tralt2 = CheckCellTranslateSUBEXPRESSION[ alt2, opts ];
    semFuncCheckCell[if, trifCondition, ifCondition, tralt1, alt1, tralt2, alt2, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateIFEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateIFEXP::error3, x ]];False)

Clear[ CheckCellTranslateCONTROLEXPRESSION ];
CheckCellTranslateCONTROLEXPRESSION[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = CheckCellTranslateVAREXP[ expression, opts ];
      traffineFunction = CheckCellTranslateMATRIX[ affineFunction, opts ];
    semFuncCheckCell[controlexpression, expression, affineFunction, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateCONTROLEXPRESSION[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCONTROLEXPRESSION::error3, x ]];False)

Clear[ CheckCellTranslateIFMUX ];
CheckCellTranslateIFMUX[ x:if[ifCondition_, alt1_, alt2_], opts:___Rule ] :=
Module[ {trifCondition, tralt1, tralt2, tr$ifCondition, tr$alt1, tr$alt2},
  Catch[
      trifCondition = CheckCellTranslateAFFEXP[ ifCondition, opts ];
      tralt1 = CheckCellTranslateSUBMUX2[ alt1, opts ];
      tralt2 = CheckCellTranslateSUBMUX2[ alt2, opts ];
    semFuncCheckCell[if, trifCondition, ifCondition, tralt1, alt1, tralt2, alt2, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateIFMUX[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateIFMUX::error3, x ]];False)

Clear[ CheckCellTranslateSUBMUX2 ];
CheckCellTranslateSUBMUX2[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, CheckCellTranslateCASEXP[ x, opts ],
        _affine, CheckCellTranslateAFFEXP[ x, opts ],
        _binop, CheckCellTranslateBINEXP[ x, opts ],
        _unop, CheckCellTranslateUNEXP[ x, opts ],
        _var, CheckCellTranslateVAREXP[ x, opts ],
        _const, CheckCellTranslateCONSTEXP[ x, opts ],
        _, (If[CheckCellDebug,Message[ CheckCellTranslateSUBMUX2::error3, x ]];False)
    ];

CheckCellTranslateSUBMUX2[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateSUBMUX2::error3, x ]];False)

Clear[ CheckCellTranslateCASEXP ];
CheckCellTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ CheckCellTranslateRESTEXPMUX2[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    semFuncCheckCell[case, trexpressionList, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateCASEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCASEXP::error3, x ]];False)

Clear[ CheckCellTranslateRESTEXPMUX2 ];
CheckCellTranslateRESTEXPMUX2[ x:restrict[domain_, restExpression_], opts:___Rule ] :=
Module[ {trdomain, trrestExpression, tr$domain, tr$restExpression},
  Catch[
      trdomain = CheckCellTranslateDOMAIN[ domain, opts ];
      trrestExpression = CheckCellTranslateSUBEXPRESSION[ restExpression, opts ];
    True  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateRESTEXPMUX2[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateRESTEXPMUX2::error3, x ]];False)

Clear[ CheckCellTranslateUSESTATEMENT ];
CheckCellTranslateUSESTATEMENT[ x:use[id_, domainExtension_, paramAssign_, inputList_, idList:{___String}], opts:___Rule ] :=
Module[ {trid, trdomainExtension, trparamAssign, trinputList, tridList, tr$id, tr$domainExtension, tr$paramAssign, tr$inputList, tr$idList},
  Catch[
      If[ MatchQ[ id, _String ],Null, Throw[ Message[ CheckCellTranslateUSESTATEMENT::error1,id, x] ] ];
      trid = id;
      trdomainExtension = CheckCellTranslateDOMAIN[ domainExtension, opts ];
      trparamAssign = CheckCellTranslateMATRIX[ paramAssign, opts ];
      trinputList = Map[ CheckCellTranslateVAREXP[#,opts]&, inputList ];
      tr$inputList = trinputList;
      If[ MatchQ[ idList, {___String} ],Null, Throw[ Message[ CheckCellTranslateUSESTATEMENT::error1,idList, x] ] ];
      tridList = idList;
    semFuncCheckCell[use, {id, domainExtension, paramAssign, expList, idList}, trinputList, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateUSESTATEMENT[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateUSESTATEMENT::error3, x ]];False)

Clear[ CheckCellTranslateCALLEXP ];
CheckCellTranslateCALLEXP[ x:call[funcName_, funcOps_], opts:___Rule ] :=
Module[ {trfuncName, trfuncOps, tr$funcName, tr$funcOps},
  Catch[
      If[ MatchQ[ funcName, _String ],Null, Throw[ Message[ CheckCellTranslateCALLEXP::error1,funcName, x] ] ];
      trfuncName = funcName;
      trfuncOps = Map[ CheckCellTranslateSUBEXPRESSION[#,opts]&, funcOps ];
      tr$funcOps = trfuncOps;
    semFuncCheckCell[call, {funcName, funcOps}, trfuncOps, debug -> CheckCellDebug]  ] (* End Catch *)
]; (* End Module *)
CheckCellTranslateCALLEXP[ x:___ ] := (If[CheckCellDebug,Message[ CheckCellTranslateCALLEXP::error3, x ]];False)

End[];
EndPackage[];
