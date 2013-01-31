BeginPackage["Alpha`alpha`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`",
	
"Alpha`Options`", 
"Alpha`Static`"}];
alphaDebug::usage = "Debug Switch";
alphaDebug = False;
alphaTranslatelist::usage = "";
alphaTranslateLIBRARY::usage = "";
alphaTranslateSYSTEMDECLARATION::usage = "";
alphaTranslateDECLARATION::usage = "";
alphaTranslateDOMAIN::usage = "";
alphaTranslatePOLYHEDRON::usage = "";
alphaTranslateCONSTRAINT::usage = "";
alphaTranslateGENERATOR::usage = "";
alphaTranslateEQUATION::usage = "";
alphaTranslateASSIGNMENT::usage = "";
alphaTranslateEXPRESSION::usage = "";
alphaTranslateCASEXP::usage = "";
alphaTranslateRESTEXP::usage = "";
alphaTranslateIFEXP::usage = "";
alphaTranslateAFFEXP::usage = "";
alphaTranslateMATRIX::usage = "";
alphaTranslateBINEXP::usage = "";
alphaTranslateUNEXP::usage = "";
alphaTranslateREDEXP::usage = "";
alphaTranslateVAREXP::usage = "";
alphaTranslateCONSTEXP::usage = "";
Begin[ "`Private`" ];
With[{f=$rootDirectory<>"/"<>fileName[{"lib","Packages","Alpha","alpha.sem"}]},
  Check[ Get[ f ],
       Print[ "Error while trying reading file alpha "]]
];
Clear[ alphaTranslateList ];
alphaTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
alphaTranslateList[ l:{___Real}, opts:___Rule ]:= l;
alphaTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
alphaTranslateList[ l:{___String}, opts:___Rule ]:= l;
alphaTranslateList[ l:___ ]:= 
  If[alphaDebug,Message[ alphaTranslateList::error3, l]];False
 (* ------- *)

 Clear[ alphaTranslateLIBRARY ];
alphaTranslateLIBRARY[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, Map[ alphaTranslateSYSTEMDECLARATION[#,opts]&, x ],
        _, (If[alphaDebug,Message[ alphaTranslateLIBRARY::error3, x ]];False)
    ];

alphaTranslateLIBRARY[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateLIBRARY::error3, x ]];False)

Clear[ alphaTranslateSYSTEMDECLARATION ];
alphaTranslateSYSTEMDECLARATION[ x:system[name_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_], opts:___Rule ] :=
Module[ {trname, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock, tr$name, tr$paramDecl, tr$inputDeclList, tr$outputDeclList, tr$localDeclList, tr$equationBlock},
  Catch[
      If[ MatchQ[ name, _String ],Null, Throw[ Message[ alphaTranslateSYSTEMDECLARATION::error1,name, x] ] ];
      trname = name;
      trparamDecl = alphaTranslateDOMAIN[ paramDecl, opts ];
      trinputDeclList = Map[ alphaTranslateDECLARATION[#,opts]&, inputDeclList ];
      tr$inputDeclList = trinputDeclList;
      troutputDeclList = Map[ alphaTranslateDECLARATION[#,opts]&, outputDeclList ];
      tr$outputDeclList = troutputDeclList;
      trlocalDeclList = Map[ alphaTranslateDECLARATION[#,opts]&, localDeclList ];
      tr$localDeclList = trlocalDeclList;
      trequationBlock = Map[ alphaTranslateEQUATION[#,opts]&, equationBlock ];
      tr$equationBlock = trequationBlock;
    {name, paramDecl, inputDeclList, outputDeclList, localDeclList, equationBlock}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateSYSTEMDECLARATION[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateSYSTEMDECLARATION::error3, x ]];False)

Clear[ alphaTranslateDECLARATION ];
alphaTranslateDECLARATION[ x:decl[varName_, type_, domain_], opts:___Rule ] :=
Module[ {trvarName, trtype, trdomain, tr$varName, tr$type, tr$domain},
  Catch[
      If[ MatchQ[ varName, _String ],Null, Throw[ Message[ alphaTranslateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ type, _Symbol ],Null, Throw[ Message[ alphaTranslateDECLARATION::error1,type, x] ] ];
      trtype = type;
      trdomain = alphaTranslateDOMAIN[ domain, opts ];
    {varName, type, trdomain}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateDECLARATION[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateDECLARATION::error3, x ]];False)

Clear[ alphaTranslateDOMAIN ];
alphaTranslateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedron_], opts:___Rule ] :=
Module[ {trdimension, trindexList, trpolyedron, tr$dimension, tr$indexList, tr$polyedron},
  Catch[
      If[ MatchQ[ dimension, _Integer ],Null, Throw[ Message[ alphaTranslateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],Null, Throw[ Message[ alphaTranslateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedron = Map[ alphaTranslatePOLYHEDRON[#,opts]&, polyedron ];
      tr$polyedron = trpolyedron;
    {dimension, indexList, polyedron}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateDOMAIN[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateDOMAIN::error3, x ]];False)

Clear[ alphaTranslatePOLYHEDRON ];
alphaTranslatePOLYHEDRON[ x:pol[a_, b_, c_, d_, constraintList_, generatorList_], opts:___Rule ] :=
Module[ {tra, trb, trc, trd, trconstraintList, trgeneratorList, tr$a, tr$b, tr$c, tr$d, tr$constraintList, tr$generatorList},
  Catch[
      If[ MatchQ[ a, _Integer ],Null, Throw[ Message[ alphaTranslatePOLYHEDRON::error1,a, x] ] ];
      tra = a;
      If[ MatchQ[ b, _Integer ],Null, Throw[ Message[ alphaTranslatePOLYHEDRON::error1,b, x] ] ];
      trb = b;
      If[ MatchQ[ c, _Integer ],Null, Throw[ Message[ alphaTranslatePOLYHEDRON::error1,c, x] ] ];
      trc = c;
      If[ MatchQ[ d, _Integer ],Null, Throw[ Message[ alphaTranslatePOLYHEDRON::error1,d, x] ] ];
      trd = d;
      trconstraintList = Map[ alphaTranslateCONSTRAINT[#,opts]&, constraintList ];
      tr$constraintList = trconstraintList;
      trgeneratorList = Map[ alphaTranslateGENERATOR[#,opts]&, generatorList ];
      tr$generatorList = trgeneratorList;
    {a, b, c, d, constraintList, generatorList}  ] (* End Catch *)
]; (* End Module *)
alphaTranslatePOLYHEDRON[ x:___ ] := (If[alphaDebug,Message[ alphaTranslatePOLYHEDRON::error3, x ]];False)

Clear[ alphaTranslateCONSTRAINT ];
alphaTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, alphaTranslateList[ x, opts ],
        _, (If[alphaDebug,Message[ alphaTranslateCONSTRAINT::error3, x ]];False)
    ];

alphaTranslateCONSTRAINT[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateCONSTRAINT::error3, x ]];False)

Clear[ alphaTranslateGENERATOR ];
alphaTranslateGENERATOR[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, alphaTranslateList[ x, opts ],
        _, (If[alphaDebug,Message[ alphaTranslateGENERATOR::error3, x ]];False)
    ];

alphaTranslateGENERATOR[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateGENERATOR::error3, x ]];False)

Clear[ alphaTranslateEQUATION ];
alphaTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, alphaTranslateASSIGNMENT[ x, opts ],
        _use, alphaTranslateUSESTATEMENT[ x, opts ],
        _, (If[alphaDebug,Message[ alphaTranslateEQUATION::error3, x ]];False)
    ];

alphaTranslateEQUATION[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateEQUATION::error3, x ]];False)

Clear[ alphaTranslateASSIGNMENT ];
alphaTranslateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_], opts:___Rule ] :=
Module[ {trleftHandSide, trrightHandSide, tr$leftHandSide, tr$rightHandSide},
  Catch[
      If[ MatchQ[ leftHandSide, _String ],Null, Throw[ Message[ alphaTranslateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = alphaTranslateEXPRESSION[ rightHandSide, opts ];
    {leftHandSide, rightHandSide}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateASSIGNMENT[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateASSIGNMENT::error3, x ]];False)

Clear[ alphaTranslateEXPRESSION ];
alphaTranslateEXPRESSION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _case, alphaTranslateCASEXP[ x, opts ],
        _restrict, alphaTranslateRESTEXP[ x, opts ],
        _if, alphaTranslateIFEXP[ x, opts ],
        _affine, alphaTranslateAFFEXP[ x, opts ],
        _binop, alphaTranslateBINEXP[ x, opts ],
        _unop, alphaTranslateUNEXP[ x, opts ],
        _reduce, alphaTranslateREDEXP[ x, opts ],
        _var, alphaTranslateVAREXP[ x, opts ],
        _const, alphaTranslateCONSTEXP[ x, opts ],
        _, (If[alphaDebug,Message[ alphaTranslateEXPRESSION::error3, x ]];False)
    ];

alphaTranslateEXPRESSION[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateEXPRESSION::error3, x ]];False)

Clear[ alphaTranslateCASEXP ];
alphaTranslateCASEXP[ x:case[expressionList_], opts:___Rule ] :=
Module[ {trexpressionList, tr$expressionList},
  Catch[
      trexpressionList = Map[ alphaTranslateEXPRESSION[#,opts]&, expressionList ];
      tr$expressionList = trexpressionList;
    expressionList  ] (* End Catch *)
]; (* End Module *)
alphaTranslateCASEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateCASEXP::error3, x ]];False)

Clear[ alphaTranslateRESTEXP ];
alphaTranslateRESTEXP[ x:restrict[domain_, expression_], opts:___Rule ] :=
Module[ {trdomain, trexpression, tr$domain, tr$expression},
  Catch[
      trdomain = alphaTranslateDOMAIN[ domain, opts ];
      trexpression = alphaTranslateEXPRESSION[ expression, opts ];
    {domain, expression}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateRESTEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateRESTEXP::error3, x ]];False)

Clear[ alphaTranslateIFEXP ];
alphaTranslateIFEXP[ x:if[condition_, alt1_, alt2_], opts:___Rule ] :=
Module[ {trcondition, tralt1, tralt2, tr$condition, tr$alt1, tr$alt2},
  Catch[
      trcondition = alphaTranslateEXPRESSION[ condition, opts ];
      tralt1 = alphaTranslateEXPRESSION[ alt1, opts ];
      tralt2 = alphaTranslateEXPRESSION[ alt2, opts ];
    {condition, alt1, alt2}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateIFEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateIFEXP::error3, x ]];False)

Clear[ alphaTranslateAFFEXP ];
alphaTranslateAFFEXP[ x:affine[expression_, affineFunction_], opts:___Rule ] :=
Module[ {trexpression, traffineFunction, tr$expression, tr$affineFunction},
  Catch[
      trexpression = alphaTranslateEXPRESSION[ expression, opts ];
      traffineFunction = alphaTranslateMATRIX[ affineFunction, opts ];
    {expression, affineFunction}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateAFFEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateAFFEXP::error3, x ]];False)

Clear[ alphaTranslateMATRIX ];
alphaTranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trmmaMatrix, tr$d1, tr$d2, tr$in, tr$mmaMatrix},
  Catch[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ alphaTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ alphaTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ alphaTranslateMATRIX::error1,in, x] ] ];
      trin = in;
      If[ MatchQ[ mmaMatrix, _ ],Null, Throw[ Message[ alphaTranslateMATRIX::error1,mmaMatrix, x] ] ];
      trmmaMatrix = mmaMatrix;
    mmaMatrix  ] (* End Catch *)
]; (* End Module *)
alphaTranslateMATRIX[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateMATRIX::error3, x ]];False)

Clear[ alphaTranslateBINEXP ];
alphaTranslateBINEXP[ x:binop[binaryOp:add | mult | or | xor | min | max | minus | div | mod, operand1_, operand2_], opts:___Rule ] :=
Module[ {trbinaryOp, troperand1, troperand2, tr$binaryOp, tr$operand1, tr$operand2},
  Catch[
      If[ MatchQ[ binaryOp, add | mult | or | xor | min | max | minus | div | mod ],Null, Throw[ Message[ alphaTranslateBINEXP::error1,binaryOp, x] ] ];
      trbinaryOp = binaryOp;
      troperand1 = alphaTranslateEXPRESSION[ operand1, opts ];
      troperand2 = alphaTranslateEXPRESSION[ operand2, opts ];
    {operand1, binaryOp, operand2}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateBINEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateBINEXP::error3, x ]];False)

Clear[ alphaTranslateUNEXP ];
alphaTranslateUNEXP[ x:unop[unaryOp:minus | not | sqrt, operand_], opts:___Rule ] :=
Module[ {trunaryOp, troperand, tr$unaryOp, tr$operand},
  Catch[
      If[ MatchQ[ unaryOp, minus | not | sqrt ],Null, Throw[ Message[ alphaTranslateUNEXP::error1,unaryOp, x] ] ];
      trunaryOp = unaryOp;
      troperand = alphaTranslateEXPRESSION[ operand, opts ];
    {unaryOp, operand}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateUNEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateUNEXP::error3, x ]];False)

Clear[ alphaTranslateREDEXP ];
alphaTranslateREDEXP[ x:red[commutativeOp:plus | mult | or | xor | min | max, affineExp_, expression_], opts:___Rule ] :=
Module[ {trcommutativeOp, traffineExp, trexpression, tr$commutativeOp, tr$affineExp, tr$expression},
  Catch[
      If[ MatchQ[ commutativeOp, plus | mult | or | xor | min | max ],Null, Throw[ Message[ alphaTranslateREDEXP::error1,commutativeOp, x] ] ];
      trcommutativeOp = commutativeOp;
      traffineExp = alphaTranslateAFFEXP[ affineExp, opts ];
      trexpression = alphaTranslateEXPRESSION[ expression, opts ];
    {commutativeOp, affineExp, expression}  ] (* End Catch *)
]; (* End Module *)
alphaTranslateREDEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateREDEXP::error3, x ]];False)

Clear[ alphaTranslateVAREXP ];
alphaTranslateVAREXP[ x:var[identifier_], opts:___Rule ] :=
Module[ {tridentifier, tr$identifier},
  Catch[
      If[ MatchQ[ identifier, _String ],Null, Throw[ Message[ alphaTranslateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    identifier  ] (* End Catch *)
]; (* End Module *)
alphaTranslateVAREXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateVAREXP::error3, x ]];False)

Clear[ alphaTranslateCONSTEXP ];
alphaTranslateCONSTEXP[ x:const[constant:_Integer | _Real | True | False], opts:___Rule ] :=
Module[ {trconstant, tr$constant},
  Catch[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],Null, Throw[ Message[ alphaTranslateCONSTEXP::error1,constant, x] ] ];
      trconstant = constant;
    constant  ] (* End Catch *)
]; (* End Module *)
alphaTranslateCONSTEXP[ x:___ ] := (If[alphaDebug,Message[ alphaTranslateCONSTEXP::error3, x ]];False)

 (* ------- *) End[];
EndPackage[];
