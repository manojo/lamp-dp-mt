BeginPackage["Alpha`vhdlCont`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
vhdlContDebug::usage = "Debug Switch";
vhdlContDebug = False;
vhdlContTranslatelist::usage = "";
vhdlContTranslateSYSTEMDECLARATION::usage = "";
vhdlContTranslateDECLARATION::usage = "";
vhdlContTranslateDOMAIN::usage = "";
vhdlContTranslatePOLYHEDRON::usage = "";
vhdlContTranslateCONSTRAINT::usage = "";
vhdlContTranslateGENERATOR::usage = "";
vhdlContTranslateEQUATION::usage = "";
vhdlContTranslateASSIGNMENT::usage = "";
vhdlContTranslateCASEXP::usage = "";
vhdlContTranslateRESTEXP::usage = "";
vhdlContTranslateAFFEXP::usage = "";
vhdlContTranslateMATRIX::usage = "";
vhdlContTranslateMATRIXNUM::usage = "";
vhdlContTranslateCONSTEXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","vhdlCont.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file vhdlCont "]]
];
Clear[ vhdlContTranslateList ];
vhdlContTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
vhdlContTranslateList[ l:{___Real}, opts:___Rule ]:= l;
vhdlContTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
vhdlContTranslateList[ l:{___String}, opts:___Rule ]:= l;
vhdlContTranslateList[ l:___ ]:= 
  If[vhdlContDebug,Message[ vhdlContTranslateList::error3, l]];False
Clear[ vhdlContTranslateSYSTEMDECLARATION ];
vhdlContTranslateSYSTEMDECLARATION[ x:system[systemName_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trsystemName, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$systemName, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ systemName, _String ],Null, Throw[ Message[ vhdlContTranslateSYSTEMDECLARATION::error1,systemName, x] ] ];
      trsystemName = systemName;
      trparamDecl = vhdlContTranslateDOMAIN[ paramDecl, opts ];
      trinputDeclList = Map[ vhdlContTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ vhdlContTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ vhdlContTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ vhdlContTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    semFuncCont["system", systemName, trinputDeclList, troutputDeclList, trequationBlock, opts]  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateSYSTEMDECLARATION[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ vhdlContTranslateDECLARATION ];
vhdlContTranslateDECLARATION[ x:decl[varName_, varType_, domain_], opts:___Rule ] :=
Module[ {trvarName, trvarType, trdomain, tr$varName, tr$varType, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ vhdlContTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      trvarType = vhdlContTranslateboolean[ varType, opts ];
      trdomain = vhdlContTranslateDOMAIN[ domain, opts ];
    {varName, domain}  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateDECLARATION[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateDECLARATION::error3, x ]];False)

Clear[ vhdlContTranslateDOMAIN ];
vhdlContTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedronList, tr$dimension, tr$indexList, tr$polyedronList},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ vhdlContTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ vhdlContTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ vhdlContTranslatePOLYHEDRON[#,opts]&, polyedronList ];
      tr$polyedronList = trpolyedronList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateDOMAIN[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateDOMAIN::error3, x ]];False)

Clear[ vhdlContTranslatePOLYHEDRON ];
vhdlContTranslatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList, tr$constraintsNum, tr$generatorsNum, tr$equationsNum, tr$linesNum, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ constraintsNum, _Integer ],Null, Throw[ Message[ vhdlContTranslatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],Null, Throw[ Message[ vhdlContTranslatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],Null, Throw[ Message[ vhdlContTranslatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],Null, Throw[ Message[ vhdlContTranslatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ vhdlContTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ vhdlContTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslatePOLYHEDRON[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslatePOLYHEDRON::error3, x ]];False)

Clear[ vhdlContTranslateCONSTRAINT ];
vhdlContTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, vhdlContTranslateList[ x, opts ],
        _, (If[vhdlContDebug,Message[ vhdlContTranslateCONSTRAINT::error3, x ]];False)
    ];

vhdlContTranslateCONSTRAINT[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateCONSTRAINT::error3, x ]];False)

Clear[ vhdlContTranslateGENERATOR ];
vhdlContTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, vhdlContTranslateList[ x, opts ],
        _, (If[vhdlContDebug,Message[ vhdlContTranslateGENERATOR::error3, x ]];False)
    ];

vhdlContTranslateGENERATOR[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateGENERATOR::error3, x ]];False)

Clear[ vhdlContTranslateEQUATION ];
vhdlContTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, vhdlContTranslateASSIGNMENT[ x, opts ],
        _, (If[vhdlContDebug,Message[ vhdlContTranslateEQUATION::error3, x ]];False)
    ];

vhdlContTranslateEQUATION[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateEQUATION::error3, x ]];False)

Clear[ vhdlContTranslateASSIGNMENT ];
vhdlContTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ vhdlContTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = vhdlContTranslateCASEXP[ rightHandSide, opts ];
    semFuncCont["equation", leftHandSide, trrightHandSide]  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateASSIGNMENT[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateASSIGNMENT::error3, x ]];False)

Clear[ vhdlContTranslateCASEXP ];
vhdlContTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ vhdlContTranslateRESTEXP[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    trexpressionList  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateCASEXP[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateCASEXP::error3, x ]];False)

Clear[ vhdlContTranslateRESTEXP ];
vhdlContTranslateRESTEXP[ x:restrict[domain_, expression_], opts:___Rule ] :=
Module[ {trdomain, trexpression, tr$domain, tr$expression},
  Catch[
      trdomain = vhdlContTranslateDOMAIN[ domain, opts ];
      trexpression = vhdlContTranslateAFFEXP[ expression, opts ];
    {domain, trexpression}  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateRESTEXP[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateRESTEXP::error3, x ]];False)

Clear[ vhdlContTranslateAFFEXP ];
vhdlContTranslateAFFEXP[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = vhdlContTranslateCONSTEXP[ expression, opts ];
      traffineFunction = vhdlContTranslateMATRIX[ affineFunction, opts ];
    trexpression  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateAFFEXP[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateAFFEXP::error3, x ]];False)

Clear[ vhdlContTranslateMATRIX ];
vhdlContTranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trmmaMatrix, tr$d1, tr$d2, tr$in, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ vhdlContTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ vhdlContTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ vhdlContTranslateMATRIX::error1,in, x] ] ];
      trin = in;
      trmmaMatrix = vhdlContTranslateMATRIXNUM[ mmaMatrix, opts ];
    Null  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateMATRIX[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateMATRIX::error3, x ]];False)

Clear[ vhdlContTranslateMATRIXNUM ];
vhdlContTranslateMATRIXNUM[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ vhdlContTranslateList[#,opts]&, x ],
        _, (If[vhdlContDebug,Message[ vhdlContTranslateMATRIXNUM::error3, x ]];False)
    ];

vhdlContTranslateMATRIXNUM[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateMATRIXNUM::error3, x ]];False)

Clear[ vhdlContTranslateCONSTEXP ];
vhdlContTranslateCONSTEXP[ x:const[constant:(True | False)], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, True | False ],Null, Throw[ Message[ vhdlContTranslateCONSTEXP::error1,constant, x] ] ];
      trconstant = constant;
    constant  ] (* End Catch *)
]; (* End Module *)
vhdlContTranslateCONSTEXP[ x:___ ] := (If[vhdlContDebug,Message[ vhdlContTranslateCONSTEXP::error3, x ]];False)

End[];
EndPackage[];
