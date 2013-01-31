BeginPackage["Alpha`CheckController`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
CheckControllerDebug::usage = "Debug Switch";
CheckControllerDebug = False;
CheckControllerTranslatelist::usage = "";
CheckControllerTranslateSYSTEMDECLARATION::usage = "";
CheckControllerTranslateDECLARATION::usage = "";
CheckControllerTranslateDOMAIN::usage = "";
CheckControllerTranslatePOLYHEDRON::usage = "";
CheckControllerTranslateCONSTRAINT::usage = "";
CheckControllerTranslateGENERATOR::usage = "";
CheckControllerTranslateEQUATION::usage = "";
CheckControllerTranslateASSIGNMENT::usage = "";
CheckControllerTranslateCASEXP::usage = "";
CheckControllerTranslateRESTEXP::usage = "";
CheckControllerTranslateAFFEXP::usage = "";
CheckControllerTranslateMATRIX::usage = "";
CheckControllerTranslateMATRIXNUM::usage = "";
CheckControllerTranslateCONSTEXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","CheckController.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file CheckController "]]
];
Clear[ CheckControllerTranslateList ];
CheckControllerTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
CheckControllerTranslateList[ l:{___Real}, opts:___Rule ]:= l;
CheckControllerTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
CheckControllerTranslateList[ l:{___String}, opts:___Rule ]:= l;
CheckControllerTranslateList[ l:___ ]:= 
  If[CheckControllerDebug,Message[ CheckControllerTranslateList::error3, l]];False
Clear[ CheckControllerTranslateSYSTEMDECLARATION ];
CheckControllerTranslateSYSTEMDECLARATION[ x:system[name_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trname, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$name, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ name, _String ],Null, Throw[ Message[ CheckControllerTranslateSYSTEMDECLARATION::error1,name, x] ] ];
      trname = name;
      trparamDecl = CheckControllerTranslateDOMAIN[ paramDecl, opts ];
      trinputDeclList = Map[ CheckControllerTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ CheckControllerTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ CheckControllerTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ CheckControllerTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncCheckController[system, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, debug -> CheckControllerDebug]  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateSYSTEMDECLARATION[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ CheckControllerTranslateDECLARATION ];
CheckControllerTranslateDECLARATION[ x:decl[varName_, varType_, domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ CheckControllerTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      trvarType = CheckControllerTranslateboolean[ varType, opts ];
      trdomain = CheckControllerTranslateDOMAIN[ domain, opts ];
    semFuncCheckController[decl, decl[varName, varType, domain], debug -> CheckControllerDebug]  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateDECLARATION[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateDECLARATION::error3, x ]];False)

Clear[ CheckControllerTranslateDOMAIN ];
CheckControllerTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ CheckControllerTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ CheckControllerTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ CheckControllerTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    dimension  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateDOMAIN[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateDOMAIN::error3, x ]];False)

Clear[ CheckControllerTranslatePOLYHEDRON ];
CheckControllerTranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ CheckControllerTranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ CheckControllerTranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ CheckControllerTranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ CheckControllerTranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ CheckControllerTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ CheckControllerTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslatePOLYHEDRON[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslatePOLYHEDRON::error3, x ]];False)

Clear[ CheckControllerTranslateCONSTRAINT ];
CheckControllerTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckControllerTranslateList[ x, opts ],
        _, (If[CheckControllerDebug,Message[ CheckControllerTranslateCONSTRAINT::error3, x ]];False)
    ];

CheckControllerTranslateCONSTRAINT[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateCONSTRAINT::error3, x ]];False)

Clear[ CheckControllerTranslateGENERATOR ];
CheckControllerTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, CheckControllerTranslateList[ x, opts ],
        _, (If[CheckControllerDebug,Message[ CheckControllerTranslateGENERATOR::error3, x ]];False)
    ];

CheckControllerTranslateGENERATOR[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateGENERATOR::error3, x ]];False)

Clear[ CheckControllerTranslateEQUATION ];
CheckControllerTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, CheckControllerTranslateASSIGNMENT[ x, opts ],
        _, (If[CheckControllerDebug,Message[ CheckControllerTranslateEQUATION::error3, x ]];False)
    ];

CheckControllerTranslateEQUATION[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateEQUATION::error3, x ]];False)

Clear[ CheckControllerTranslateASSIGNMENT ];
CheckControllerTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ CheckControllerTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = CheckControllerTranslateCASEXP[ rightHandSide, opts ];
    trrightHandSide  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateASSIGNMENT[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateASSIGNMENT::error3, x ]];False)

Clear[ CheckControllerTranslateCASEXP ];
CheckControllerTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ CheckControllerTranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    semFuncCheckController[case, trexpressionList, debug -> CheckControllerDebug]  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateCASEXP[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateCASEXP::error3, x ]];False)

Clear[ CheckControllerTranslateRESTEXP ];
CheckControllerTranslateRESTEXP[ x:restrict[domain_, expression_], opts:___Rule ] :=
Module[ {trdomain, trexpression, tr$domain, tr$expression},
  Catch[
      trdomain = CheckControllerTranslateDOMAIN[ domain, opts ];
      trexpression = CheckControllerTranslateAFFEXP[ expression, opts ];
    trexpression  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateRESTEXP[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateRESTEXP::error3, x ]];False)

Clear[ CheckControllerTranslateAFFEXP ];
CheckControllerTranslateAFFEXP[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = CheckControllerTranslateCONSTEXP[ expression, opts ];
      traffineFunction = CheckControllerTranslateMATRIX[ affineFunction, opts ];
    trexpression  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateAFFEXP[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateAFFEXP::error3, x ]];False)

Clear[ CheckControllerTranslateMATRIX ];
CheckControllerTranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trmmaMatrix, tr$d1, tr$d2, tr$in, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ CheckControllerTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ CheckControllerTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ CheckControllerTranslateMATRIX::error1,in, x] ] ];
      trin = in;
      trmmaMatrix = CheckControllerTranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateMATRIX[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateMATRIX::error3, x ]];False)

Clear[ CheckControllerTranslateMATRIXNUM ];
CheckControllerTranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ CheckControllerTranslateList[#,opts]&, x ],
        _, (If[CheckControllerDebug,Message[ CheckControllerTranslateMATRIXNUM::error3, x ]];False)
    ];

CheckControllerTranslateMATRIXNUM[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateMATRIXNUM::error3, x ]];False)

Clear[ CheckControllerTranslateCONSTEXP ];
CheckControllerTranslateCONSTEXP[ x:const[constant:(True | False)], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, True | False ],Null, Throw[ Message[ CheckControllerTranslateCONSTEXP::error1,constant, x] ] ];
      trconstant = constant;
    True  ] (* End Catch *)
]; (* End Module *)
CheckControllerTranslateCONSTEXP[ x:___ ] := (If[CheckControllerDebug,Message[ CheckControllerTranslateCONSTEXP::error3, x ]];False)

End[];
EndPackage[];
