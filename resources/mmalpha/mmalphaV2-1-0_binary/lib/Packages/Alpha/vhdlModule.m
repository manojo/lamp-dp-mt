BeginPackage["Alpha`vhdlModule`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`",
	
"Alpha`Options`", 
"Alpha`Static`"}];
vhdlModuleDebug::usage = "Debug Switch";
vhdlModuleDebug = False;
vhdlModuleTranslatelist::usage = "";
vhdlModuleTranslateSYSTEMDECLARATION::usage = "";
vhdlModuleTranslateDECLARATION::usage = "";
vhdlModuleTranslateDOMAINPARAM::usage = "";
vhdlModuleTranslateDOMAIN::usage = "";
vhdlModuleTranslatePOLYHEDRON::usage = "";
vhdlModuleTranslateCONSTRAINT::usage = "";
vhdlModuleTranslateGENERATOR::usage = "";
vhdlModuleTranslateEQUATION::usage = "";
vhdlModuleTranslateASSIGNMENT::usage = "";
vhdlModuleTranslateUSESTATEMENT::usage = "";
vhdlModuleTranslateCONNECTION::usage = "";
vhdlModuleTranslateCASEXP::usage = "";
vhdlModuleTranslateRESTEXP::usage = "";
vhdlModuleTranslateCONST::usage = "";
vhdlModuleTranslateAFFEXP::usage = "";
vhdlModuleTranslateMATRIX::usage = "";
vhdlModuleTranslateMATRIXNUM::usage = "";
vhdlModuleTranslateVAREXPORCONSTE::usage = "";
vhdlModuleTranslateVAREXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","vhdlModule.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file vhdlModule "]]
];
Clear[ vhdlModuleTranslateList ];
vhdlModuleTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
vhdlModuleTranslateList[ l:{___Real}, opts:___Rule ]:= l;
vhdlModuleTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
vhdlModuleTranslateList[ l:{___String}, opts:___Rule ]:= l;
vhdlModuleTranslateList[ l:___ ]:= 
  If[vhdlModuleDebug,Message[ vhdlModuleTranslateList::error3, l]];False
 (* ------- *)

 Clear[ vhdlModuleTranslateSYSTEMDECLARATION ];
vhdlModuleTranslateSYSTEMDECLARATION[ x:system[name_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trname, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$name, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ name, _String ],Null, Throw[ Message[ vhdlModuleTranslateSYSTEMDECLARATION::error1,name, x] ] ];
      trname = name;
      trparamDecl = vhdlModuleTranslateDOMAINPARAM[ paramDecl, opts ];
      trinputDeclList = Map[ vhdlModuleTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ vhdlModuleTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ vhdlModuleTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ vhdlModuleTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncModule["system", name, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateSYSTEMDECLARATION[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ vhdlModuleTranslateDECLARATION ];
vhdlModuleTranslateDECLARATION[ x:decl[varName_, varType:integer | boolean | integer[_String, _Integer], domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ vhdlModuleTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ varType, integer | boolean | integer[_String, _Integer] ],Null, Throw[ Message[ vhdlModuleTranslateDECLARATION::error1,varType, x] ] ];
      trvarType = varType;
      trdomain = vhdlModuleTranslateDOMAIN[ domain, opts ];
    semFuncModule["decl", varName, varType, domain, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateDECLARATION[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateDECLARATION::error3, x ]];False)

Clear[ vhdlModuleTranslateDOMAINPARAM ];
vhdlModuleTranslateDOMAINPARAM[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ vhdlModuleTranslateDOMAINPARAM::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ vhdlModuleTranslateDOMAINPARAM::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ vhdlModuleTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateDOMAINPARAM[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateDOMAINPARAM::error3, x ]];False)

Clear[ vhdlModuleTranslateDOMAIN ];
vhdlModuleTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ vhdlModuleTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ vhdlModuleTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ vhdlModuleTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateDOMAIN[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateDOMAIN::error3, x ]];False)

Clear[ vhdlModuleTranslatePOLYHEDRON ];
vhdlModuleTranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ vhdlModuleTranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ vhdlModuleTranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ vhdlModuleTranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ vhdlModuleTranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ vhdlModuleTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ vhdlModuleTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslatePOLYHEDRON[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslatePOLYHEDRON::error3, x ]];False)

Clear[ vhdlModuleTranslateCONSTRAINT ];
vhdlModuleTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, vhdlModuleTranslateList[ x, opts ],
        _, (If[vhdlModuleDebug,Message[ vhdlModuleTranslateCONSTRAINT::error3, x ]];False)
    ];

vhdlModuleTranslateCONSTRAINT[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateCONSTRAINT::error3, x ]];False)

Clear[ vhdlModuleTranslateGENERATOR ];
vhdlModuleTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, vhdlModuleTranslateList[ x, opts ],
        _, (If[vhdlModuleDebug,Message[ vhdlModuleTranslateGENERATOR::error3, x ]];False)
    ];

vhdlModuleTranslateGENERATOR[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateGENERATOR::error3, x ]];False)

Clear[ vhdlModuleTranslateEQUATION ];
vhdlModuleTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, vhdlModuleTranslateASSIGNMENT[ x, opts ],
        _use, vhdlModuleTranslateUSESTATEMENT[ x, opts ],
        _, (If[vhdlModuleDebug,Message[ vhdlModuleTranslateEQUATION::error3, x ]];False)
    ];

vhdlModuleTranslateEQUATION[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateEQUATION::error3, x ]];False)

Clear[ vhdlModuleTranslateASSIGNMENT ];
vhdlModuleTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ vhdlModuleTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = vhdlModuleTranslateCONNECTION[ rightHandSide, opts ];
    semFuncModule["assignment", leftHandSide, trrightHandSide, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateASSIGNMENT[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateASSIGNMENT::error3, x ]];False)

Clear[ vhdlModuleTranslateUSESTATEMENT ];
vhdlModuleTranslateUSESTATEMENT[ x:use[id_, extension_, paramAssign_, inputList_, idList:{___String}], opts:___Rule ] :=
Module[ {trid, trextension, trparamAssign, trinputList, tridList, tr$id, tr$extension, tr$paramAssign, tr$inputList, tr$idList},
  Catch[
      If[ MatchQ[ id, _String ],Null, Throw[ Message[ vhdlModuleTranslateUSESTATEMENT::error1,id, x] ] ];
      trid = id;
      trextension = vhdlModuleTranslateDOMAIN[ extension, opts ];
      trparamAssign = vhdlModuleTranslateMATRIX[ paramAssign, opts ];
      trinputList = Map[ vhdlModuleTranslateVAREXP[#,opts]&, inputList ];
      tr$inputList = trinputList;
      If[ MatchQ[ idList, {___String} ],Null, Throw[ Message[ vhdlModuleTranslateUSESTATEMENT::error1,idList, x] ] ];
      tridList = idList;
    semFuncModule["use", id, extension, paramAssign, inputList, idList, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateUSESTATEMENT[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateUSESTATEMENT::error3, x ]];False)

Clear[ vhdlModuleTranslateCONNECTION ];
vhdlModuleTranslateCONNECTION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, vhdlModuleTranslateCASEXP[ x, opts ],
        _restrict, vhdlModuleTranslateRESTEXP[ x, opts ],
        _affine, vhdlModuleTranslateAFFEXP[ x, opts ],
        _const, vhdlModuleTranslateCONST[ x, opts ],
        _, (If[vhdlModuleDebug,Message[ vhdlModuleTranslateCONNECTION::error3, x ]];False)
    ];

vhdlModuleTranslateCONNECTION[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateCONNECTION::error3, x ]];False)

Clear[ vhdlModuleTranslateCASEXP ];
vhdlModuleTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ vhdlModuleTranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    trexpressionList  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateCASEXP[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateCASEXP::error3, x ]];False)

Clear[ vhdlModuleTranslateRESTEXP ];
vhdlModuleTranslateRESTEXP[ x:restrict[domain_, expression_], opts:___Rule ] :=
Module[ {trdomain, trexpression, tr$domain, tr$expression},
  Catch[
      trdomain = vhdlModuleTranslateDOMAIN[ domain, opts ];
      trexpression = vhdlModuleTranslateAFFEXP[ expression, opts ];
    {domain, trexpression}  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateRESTEXP[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateRESTEXP::error3, x ]];False)

Clear[ vhdlModuleTranslateCONST ];
vhdlModuleTranslateCONST[ x:const[constant:_Integer | _Real | True | False], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],Null, Throw[ Message[ vhdlModuleTranslateCONST::error1,constant, x] ] ];
      trconstant = constant;
    {"const"[constant]}  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateCONST[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateCONST::error3, x ]];False)

Clear[ vhdlModuleTranslateAFFEXP ];
vhdlModuleTranslateAFFEXP[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = vhdlModuleTranslateVAREXPORCONSTE[ expression, opts ];
      traffineFunction = vhdlModuleTranslateMATRIX[ affineFunction, opts ];
    {trexpression, affineFunction}  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateAFFEXP[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateAFFEXP::error3, x ]];False)

Clear[ vhdlModuleTranslateMATRIX ];
vhdlModuleTranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trmmaMatrix, tr$d1, tr$d2, tr$in, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ vhdlModuleTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ vhdlModuleTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ vhdlModuleTranslateMATRIX::error1,in, x] ] ];
      trin = in;
      trmmaMatrix = vhdlModuleTranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateMATRIX[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateMATRIX::error3, x ]];False)

Clear[ vhdlModuleTranslateMATRIXNUM ];
vhdlModuleTranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ vhdlModuleTranslateList[#,opts]&, x ],
        _, (If[vhdlModuleDebug,Message[ vhdlModuleTranslateMATRIXNUM::error3, x ]];False)
    ];

vhdlModuleTranslateMATRIXNUM[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateMATRIXNUM::error3, x ]];False)

Clear[ vhdlModuleTranslateVAREXPORCONSTE ];
vhdlModuleTranslateVAREXPORCONSTE[ x:_, opts:___Rule ] :=
    Switch[ x,
        _var, vhdlModuleTranslateVAREXP[ x, opts ],
        _const, vhdlModuleTranslateCONST[ x, opts ],
        _, (If[vhdlModuleDebug,Message[ vhdlModuleTranslateVAREXPORCONSTE::error3, x ]];False)
    ];

vhdlModuleTranslateVAREXPORCONSTE[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateVAREXPORCONSTE::error3, x ]];False)

Clear[ vhdlModuleTranslateVAREXP ];
vhdlModuleTranslateVAREXP[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ vhdlModuleTranslateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    identifier  ] (* End Catch *)
]; (* End Module *)
vhdlModuleTranslateVAREXP[ x:___ ] := (If[vhdlModuleDebug,Message[ vhdlModuleTranslateVAREXP::error3, x ]];False)

 (* ------- *) End[];
EndPackage[];
