BeginPackage["Alpha`vhdlCell`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
vhdlCellDebug::usage = "Debug Switch";
vhdlCellDebug = False;
vhdlCellTranslatelist::usage = "";
vhdlCellTranslateSYSTEMDECLARATION::usage = "";
vhdlCellTranslateDECLARATION::usage = "";
vhdlCellTranslateDOMAINPARAM::usage = "";
vhdlCellTranslateDOMAIN::usage = "";
vhdlCellTranslatePOLYHEDRON::usage = "";
vhdlCellTranslateCONSTRAINT::usage = "";
vhdlCellTranslateGENERATOR::usage = "";
vhdlCellTranslateEQUATION::usage = "";
vhdlCellTranslateASSIGNMENT::usage = "";
vhdlCellTranslateELEMENTS::usage = "";
vhdlCellTranslateAFFEXPE::usage = "";
vhdlCellTranslateMATRIX::usage = "";
vhdlCellTranslateMATRIXNUM::usage = "";
vhdlCellTranslateBINEXPE::usage = "";
vhdlCellTranslateBINEXP::usage = "";
vhdlCellTranslateUNEXPE::usage = "";
vhdlCellTranslateUNEXP::usage = "";
vhdlCellTranslateVAREXPORCONSTE::usage = "";
vhdlCellTranslateVAREXPE::usage = "";
vhdlCellTranslateCONSTEXPE::usage = "";
vhdlCellTranslateVAREXP::usage = "";
vhdlCellTranslateCONSTEXP::usage = "";
vhdlCellTranslateSUBEXPRESSION::usage = "";
vhdlCellTranslateAFFEXP::usage = "";
vhdlCellTranslateVAREXPORCONST::usage = "";
vhdlCellTranslateCASEMUX::usage = "";
vhdlCellTranslateRESTEXP::usage = "";
vhdlCellTranslateIFEXP::usage = "";
vhdlCellTranslateCONTROLEXPRESSION::usage = "";
vhdlCellTranslateIFMUX::usage = "";
vhdlCellTranslateSUBMUX2::usage = "";
vhdlCellTranslateCASEXP::usage = "";
vhdlCellTranslateRESTEXPMUX2::usage = "";
vhdlCellTranslateUSESTATEMENT::usage = "";
vhdlCellTranslateCALLSTATEMENT::usage = "";
vhdlCellTranslateCALLEXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","vhdlCell.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file vhdlCell "]]
];
Clear[ vhdlCellTranslateList ];
vhdlCellTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
vhdlCellTranslateList[ l:{___Real}, opts:___Rule ]:= l;
vhdlCellTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
vhdlCellTranslateList[ l:{___String}, opts:___Rule ]:= l;
vhdlCellTranslateList[ l:___ ]:= 
  If[vhdlCellDebug,Message[ vhdlCellTranslateList::error3, l]];False
Clear[ vhdlCellTranslateSYSTEMDECLARATION ];
vhdlCellTranslateSYSTEMDECLARATION[ x:system[systemName_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trsystemName, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$systemName, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ systemName, _String ],Null, Throw[ Message[ vhdlCellTranslateSYSTEMDECLARATION::error1,systemName, x] ] ];
      trsystemName = systemName;
      trparamDecl = vhdlCellTranslateDOMAINPARAM[ paramDecl, opts ];
      trinputDeclList = Map[ vhdlCellTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ vhdlCellTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ vhdlCellTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ vhdlCellTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncCell["system", systemName, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateSYSTEMDECLARATION[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ vhdlCellTranslateDECLARATION ];
vhdlCellTranslateDECLARATION[ x:decl[varName_, varType_, domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ vhdlCellTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ varType, _ ],Null, Throw[ Message[ vhdlCellTranslateDECLARATION::error1,varType, x] ] ];
      trvarType = varType;
      trdomain = vhdlCellTranslateDOMAIN[ domain, opts ];
    {varName, varType}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateDECLARATION[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateDECLARATION::error3, x ]];False)

Clear[ vhdlCellTranslateDOMAINPARAM ];
vhdlCellTranslateDOMAINPARAM[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ vhdlCellTranslateDOMAINPARAM::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ vhdlCellTranslateDOMAINPARAM::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ vhdlCellTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateDOMAINPARAM[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateDOMAINPARAM::error3, x ]];False)

Clear[ vhdlCellTranslateDOMAIN ];
vhdlCellTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ vhdlCellTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ vhdlCellTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ vhdlCellTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateDOMAIN[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateDOMAIN::error3, x ]];False)

Clear[ vhdlCellTranslatePOLYHEDRON ];
vhdlCellTranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ vhdlCellTranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ vhdlCellTranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ vhdlCellTranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ vhdlCellTranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ vhdlCellTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ vhdlCellTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslatePOLYHEDRON[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslatePOLYHEDRON::error3, x ]];False)

Clear[ vhdlCellTranslateCONSTRAINT ];
vhdlCellTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, vhdlCellTranslateList[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateCONSTRAINT::error3, x ]];False)
    ];

vhdlCellTranslateCONSTRAINT[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCONSTRAINT::error3, x ]];False)

Clear[ vhdlCellTranslateGENERATOR ];
vhdlCellTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, vhdlCellTranslateList[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateGENERATOR::error3, x ]];False)
    ];

vhdlCellTranslateGENERATOR[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateGENERATOR::error3, x ]];False)

Clear[ vhdlCellTranslateEQUATION ];
vhdlCellTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        equation[_, _call], vhdlCellTranslateCALLSTATEMENT[ x, opts ],
        _equation, vhdlCellTranslateASSIGNMENT[ x, opts ],
        _use, vhdlCellTranslateUSESTATEMENT[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateEQUATION::error3, x ]];False)
    ];

vhdlCellTranslateEQUATION[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateEQUATION::error3, x ]];False)

Clear[ vhdlCellTranslateASSIGNMENT ];
vhdlCellTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ vhdlCellTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = vhdlCellTranslateELEMENTS[ rightHandSide, opts ];
    semFuncCell["equation", leftHandSide, rightHandSide, trrightHandSide, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateASSIGNMENT[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateASSIGNMENT::error3, x ]];False)

Clear[ vhdlCellTranslateELEMENTS ];
vhdlCellTranslateELEMENTS[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, vhdlCellTranslateCASEMUX[ x, opts ],
        _if, vhdlCellTranslateIFMUX[ x, opts ],
        _affine, vhdlCellTranslateAFFEXPE[ x, opts ],
        _binop, vhdlCellTranslateBINEXPE[ x, opts ],
        _unop, vhdlCellTranslateUNEXPE[ x, opts ],
        _var, vhdlCellTranslateVAREXPE[ x, opts ],
        _const, vhdlCellTranslateCONSTEXPE[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateELEMENTS::error3, x ]];False)
    ];

vhdlCellTranslateELEMENTS[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateELEMENTS::error3, x ]];False)

Clear[ vhdlCellTranslateAFFEXPE ];
vhdlCellTranslateAFFEXPE[ x:affine[affExpression_, affineFunction_], opts:___Rule ] :=
Module[ {traffExpression, traffineFunction, tr$affExpression, tr$affineFunction},
  Catch[
      traffExpression = vhdlCellTranslateVAREXPORCONSTE[ affExpression, opts ];
      traffineFunction = vhdlCellTranslateMATRIX[ affineFunction, opts ];
    {"register"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateAFFEXPE[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateAFFEXPE::error3, x ]];False)

Clear[ vhdlCellTranslateMATRIX ];
vhdlCellTranslateMATRIX[ x:matrix[d1_, d2_, indexes:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trindexes, trmmaMatrix, tr$d1, tr$d2, tr$indexes, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ vhdlCellTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ vhdlCellTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ indexes, {___String} ],Null, Throw[ Message[ vhdlCellTranslateMATRIX::error1,indexes, x] ] ];
      trindexes = indexes;
      trmmaMatrix = vhdlCellTranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateMATRIX[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateMATRIX::error3, x ]];False)

Clear[ vhdlCellTranslateMATRIXNUM ];
vhdlCellTranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ vhdlCellTranslateList[#,opts]&, x ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateMATRIXNUM::error3, x ]];False)
    ];

vhdlCellTranslateMATRIXNUM[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateMATRIXNUM::error3, x ]];False)

Clear[ vhdlCellTranslateBINEXPE ];
vhdlCellTranslateBINEXPE[ x:binop[binaryOp:(add | sub | mul | div | or | and | xor | min | max | eq | ne | le | lt | ge | gt | minus | div | mod), operand1_, operand2_], opts:___Rule ] :=
Module[ {trbinaryOp, troperand1, troperand2, tr$binaryOp, tr$operand1, tr$operand2},
  Catch[
      If[ MatchQ[ binaryOp, add | sub | mul | div | or | and | xor | min | max | eq | ne | le | lt | ge | gt | minus | div | mod ],Null, Throw[ Message[ vhdlCellTranslateBINEXPE::error1,binaryOp, x] ] ];
      trbinaryOp = binaryOp;
      troperand1 = vhdlCellTranslateSUBEXPRESSION[ operand1, opts ];
      troperand2 = vhdlCellTranslateSUBEXPRESSION[ operand2, opts ];
    {"expression"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateBINEXPE[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateBINEXPE::error3, x ]];False)

Clear[ vhdlCellTranslateBINEXP ];
vhdlCellTranslateBINEXP[ x:binop[binaryOp:(add | sub | mul | div | or | and | xor | min | max | eq | ne | le | lt | ge | gt | minus | mod), operand1_, operand2_], opts:___Rule ] :=
Module[ {trbinaryOp, troperand1, troperand2, tr$binaryOp, tr$operand1, tr$operand2},
  Catch[
      If[ MatchQ[ binaryOp, add | sub | mul | div | or | and | xor | min | max | eq | ne | le | lt | ge | gt | minus | mod ],Null, Throw[ Message[ vhdlCellTranslateBINEXP::error1,binaryOp, x] ] ];
      trbinaryOp = binaryOp;
      troperand1 = vhdlCellTranslateSUBEXPRESSION[ operand1, opts ];
      troperand2 = vhdlCellTranslateSUBEXPRESSION[ operand2, opts ];
    {"expression"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateBINEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateBINEXP::error3, x ]];False)

Clear[ vhdlCellTranslateUNEXPE ];
vhdlCellTranslateUNEXPE[ x:unop[unaryOp:(neg | not | sqrt | abs), operand_], opts:___Rule ] :=
Module[ {trunaryOp, troperand, tr$unaryOp, tr$operand},
  Catch[
      If[ MatchQ[ unaryOp, neg | not | sqrt | abs ],Null, Throw[ Message[ vhdlCellTranslateUNEXPE::error1,unaryOp, x] ] ];
      trunaryOp = unaryOp;
      troperand = vhdlCellTranslateSUBEXPRESSION[ operand, opts ];
    {"expression"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateUNEXPE[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateUNEXPE::error3, x ]];False)

Clear[ vhdlCellTranslateUNEXP ];
vhdlCellTranslateUNEXP[ x:unop[unaryOp:(neg | not | sqrt | abs), operand_], opts:___Rule ] :=
Module[ {trunaryOp, troperand, tr$unaryOp, tr$operand},
  Catch[
      If[ MatchQ[ unaryOp, neg | not | sqrt | abs ],Null, Throw[ Message[ vhdlCellTranslateUNEXP::error1,unaryOp, x] ] ];
      trunaryOp = unaryOp;
      troperand = vhdlCellTranslateSUBEXPRESSION[ operand, opts ];
    {"expression"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateUNEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateUNEXP::error3, x ]];False)

Clear[ vhdlCellTranslateVAREXPORCONSTE ];
vhdlCellTranslateVAREXPORCONSTE[ x:_, opts:___Rule ] :=
    Switch[ x,
        _var, vhdlCellTranslateVAREXPE[ x, opts ],
        _const, vhdlCellTranslateCONSTEXPE[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateVAREXPORCONSTE::error3, x ]];False)
    ];

vhdlCellTranslateVAREXPORCONSTE[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateVAREXPORCONSTE::error3, x ]];False)

Clear[ vhdlCellTranslateVAREXPE ];
vhdlCellTranslateVAREXPE[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ vhdlCellTranslateVAREXPE::error1,identifier, x] ] ];
      tridentifier = identifier;
    {"var"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateVAREXPE[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateVAREXPE::error3, x ]];False)

Clear[ vhdlCellTranslateCONSTEXPE ];
vhdlCellTranslateCONSTEXPE[ x:const[constant:(_Integer | _Real | True | False)], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],Null, Throw[ Message[ vhdlCellTranslateCONSTEXPE::error1,constant, x] ] ];
      trconstant = constant;
    {"const"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateCONSTEXPE[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCONSTEXPE::error3, x ]];False)

Clear[ vhdlCellTranslateVAREXP ];
vhdlCellTranslateVAREXP[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ vhdlCellTranslateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    {"var"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateVAREXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateVAREXP::error3, x ]];False)

Clear[ vhdlCellTranslateCONSTEXP ];
vhdlCellTranslateCONSTEXP[ x:const[constant:(_Integer | _Real | True | False)], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],Null, Throw[ Message[ vhdlCellTranslateCONSTEXP::error1,constant, x] ] ];
      trconstant = constant;
    {"const"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateCONSTEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCONSTEXP::error3, x ]];False)

Clear[ vhdlCellTranslateSUBEXPRESSION ];
vhdlCellTranslateSUBEXPRESSION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _affine, vhdlCellTranslateAFFEXP[ x, opts ],
        _binop, vhdlCellTranslateBINEXP[ x, opts ],
        _unop, vhdlCellTranslateUNEXP[ x, opts ],
        _var, vhdlCellTranslateVAREXP[ x, opts ],
        _const, vhdlCellTranslateCONSTEXP[ x, opts ],
        _call, vhdlCellTranslateCALLEXP[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateSUBEXPRESSION::error3, x ]];False)
    ];

vhdlCellTranslateSUBEXPRESSION[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateSUBEXPRESSION::error3, x ]];False)

Clear[ vhdlCellTranslateAFFEXP ];
vhdlCellTranslateAFFEXP[ x:affine[affExpression_, affineFunction_], opts:___Rule ] :=
Module[ {traffExpression, traffineFunction, tr$affExpression, tr$affineFunction},
  Catch[
      traffExpression = vhdlCellTranslateVAREXPORCONST[ affExpression, opts ];
      traffineFunction = vhdlCellTranslateMATRIX[ affineFunction, opts ];
    {"affine"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateAFFEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateAFFEXP::error3, x ]];False)

Clear[ vhdlCellTranslateVAREXPORCONST ];
vhdlCellTranslateVAREXPORCONST[ x:_, opts:___Rule ] :=
    Switch[ x,
        _var, vhdlCellTranslateVAREXP[ x, opts ],
        _const, vhdlCellTranslateCONSTEXP[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateVAREXPORCONST::error3, x ]];False)
    ];

vhdlCellTranslateVAREXPORCONST[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateVAREXPORCONST::error3, x ]];False)

Clear[ vhdlCellTranslateCASEMUX ];
vhdlCellTranslateCASEMUX[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ vhdlCellTranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    {"casemux"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateCASEMUX[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCASEMUX::error3, x ]];False)

Clear[ vhdlCellTranslateRESTEXP ];
vhdlCellTranslateRESTEXP[ x:restrict[domain_, ifExpression_], opts:___Rule ] :=
Module[ {trdomain, trifExpression, tr$domain, tr$ifExpression},
  Catch[
      trdomain = vhdlCellTranslateDOMAIN[ domain, opts ];
      trifExpression = vhdlCellTranslateIFEXP[ ifExpression, opts ];
    {"rest"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateRESTEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateRESTEXP::error3, x ]];False)

Clear[ vhdlCellTranslateIFEXP ];
vhdlCellTranslateIFEXP[ x:if[ifCondition_, alt1_, alt2_], opts:___Rule ] :=
Module[ {trifCondition, tralt1, tralt2, tr$ifCondition, tr$alt1, tr$alt2},
  Catch[
      trifCondition = vhdlCellTranslateCONTROLEXPRESSION[ ifCondition, opts ];
      tralt1 = vhdlCellTranslateSUBEXPRESSION[ alt1, opts ];
      tralt2 = vhdlCellTranslateSUBEXPRESSION[ alt2, opts ];
    {"ifexp"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateIFEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateIFEXP::error3, x ]];False)

Clear[ vhdlCellTranslateCONTROLEXPRESSION ];
vhdlCellTranslateCONTROLEXPRESSION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _affine, vhdlCellTranslateAFFEXP[ x, opts ],
        _var, vhdlCellTranslateVAREXP[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateCONTROLEXPRESSION::error3, x ]];False)
    ];

vhdlCellTranslateCONTROLEXPRESSION[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCONTROLEXPRESSION::error3, x ]];False)

Clear[ vhdlCellTranslateIFMUX ];
vhdlCellTranslateIFMUX[ x:if[ifCondition_, alt1_, alt2_], opts:___Rule ] :=
Module[ {trifCondition, tralt1, tralt2, tr$ifCondition, tr$alt1, tr$alt2},
  Catch[
      trifCondition = vhdlCellTranslateCONTROLEXPRESSION[ ifCondition, opts ];
      tralt1 = vhdlCellTranslateSUBMUX2[ alt1, opts ];
      tralt2 = vhdlCellTranslateSUBMUX2[ alt2, opts ];
    {"ifmux"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateIFMUX[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateIFMUX::error3, x ]];False)

Clear[ vhdlCellTranslateSUBMUX2 ];
vhdlCellTranslateSUBMUX2[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, vhdlCellTranslateCASEXP[ x, opts ],
        _affine, vhdlCellTranslateAFFEXP[ x, opts ],
        _binop, vhdlCellTranslateBINEXP[ x, opts ],
        _unop, vhdlCellTranslateUNEXP[ x, opts ],
        _var, vhdlCellTranslateVAREXP[ x, opts ],
        _const, vhdlCellTranslateCONSTEXP[ x, opts ],
        _, (If[vhdlCellDebug,Message[ vhdlCellTranslateSUBMUX2::error3, x ]];False)
    ];

vhdlCellTranslateSUBMUX2[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateSUBMUX2::error3, x ]];False)

Clear[ vhdlCellTranslateCASEXP ];
vhdlCellTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ vhdlCellTranslateRESTEXPMUX2[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    {}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateCASEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCASEXP::error3, x ]];False)

Clear[ vhdlCellTranslateRESTEXPMUX2 ];
vhdlCellTranslateRESTEXPMUX2[ x:restrict[domain_, restExpression_], opts:___Rule ] :=
Module[ {trdomain, trrestExpression, tr$domain, tr$restExpression},
  Catch[
      trdomain = vhdlCellTranslateDOMAIN[ domain, opts ];
      trrestExpression = vhdlCellTranslateSUBEXPRESSION[ restExpression, opts ];
    {}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateRESTEXPMUX2[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateRESTEXPMUX2::error3, x ]];False)

Clear[ vhdlCellTranslateUSESTATEMENT ];
vhdlCellTranslateUSESTATEMENT[ x:use[id_, domainExtension_, paramAssign_, inputList_, idList:{___String}], opts:___Rule ] :=
Module[ {trid, trdomainExtension, trparamAssign, trinputList, tridList, tr$id, tr$domainExtension, tr$paramAssign, tr$inputList, tr$idList},
  Catch[
      If[ MatchQ[ id, _String ],Null, Throw[ Message[ vhdlCellTranslateUSESTATEMENT::error1,id, x] ] ];
      trid = id;
      trdomainExtension = vhdlCellTranslateDOMAIN[ domainExtension, opts ];
      trparamAssign = vhdlCellTranslateMATRIX[ paramAssign, opts ];
      trinputList = Map[ vhdlCellTranslateVAREXP[#,opts]&, inputList ];
      tr$inputList = trinputList;
      If[ MatchQ[ idList, {___String} ],Null, Throw[ Message[ vhdlCellTranslateUSESTATEMENT::error1,idList, x] ] ];
      tridList = idList;
    semFuncCell["use", id, domainExtension, paramAssign, inputList, idList, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateUSESTATEMENT[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateUSESTATEMENT::error3, x ]];False)

Clear[ vhdlCellTranslateCALLSTATEMENT ];
vhdlCellTranslateCALLSTATEMENT[ x:equation[leftHandSide_, funcCall_], opts:___Rule ] :=
Module[ {trleftHandSide, trfuncCall, tr$leftHandSide, tr$funcCall},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ vhdlCellTranslateCALLSTATEMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trfuncCall = vhdlCellTranslateCALLEXP[ funcCall, opts ];
    semFuncCell["equation", leftHandSide, funcCall, trfuncCall, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateCALLSTATEMENT[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCALLSTATEMENT::error3, x ]];False)

Clear[ vhdlCellTranslateCALLEXP ];
vhdlCellTranslateCALLEXP[ x:call[funcName_, funcOps_], opts:___Rule ] :=
Module[ {trfuncName, trfuncOps, tr$funcName, tr$funcOps},
  Catch[
      If[ MatchQ[ funcName, _String ],Null, Throw[ Message[ vhdlCellTranslateCALLEXP::error1,funcName, x] ] ];
      trfuncName = funcName;
      trfuncOps = Map[ vhdlCellTranslateSUBEXPRESSION[#,opts]&, funcOps ];
      tr$funcOps = trfuncOps;
    {"expression"}  ] (* End Catch *)
]; (* End Module *)
vhdlCellTranslateCALLEXP[ x:___ ] := (If[vhdlCellDebug,Message[ vhdlCellTranslateCALLEXP::error3, x ]];False)

End[];
EndPackage[];
