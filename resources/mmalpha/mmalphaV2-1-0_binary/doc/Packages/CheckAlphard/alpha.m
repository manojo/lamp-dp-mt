BeginPackage["Alpha`alpha`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`", 
"Alpha`Options`", 
"Alpha`Static`"}];
translateList::usage = "";
translateLIBRARY::usage = "";
translateSYSTEMDECLARATION::usage = "";
translateDECLARATION::usage = "";
translateDOMAIN::usage = "";
translatePOLYHEDRON::usage = "";
translateCONSTRAINT::usage = "";
translateGENERATOR::usage = "";
translateEQUATION::usage = "";
translateASSIGNMENT::usage = "";
translateUSESTATEMENT::usage = "";
translateEXPRESSION::usage = "";
translateCASEXP::usage = "";
translateRESTEXP::usage = "";
translateIFEXP::usage = "";
translateAFFEXP::usage = "";
translateMATRIX::usage = "";
translateMATRIXNUM::usage = "";
translateBINEXP::usage = "";
translateUNEXP::usage = "";
translateREDEXP::usage = "";
translateVAREXP::usage = "";
translateCONSTEXP::usage = "";
Begin[ "`Private`" ];
Check[ Get["alpha.sem" ],
       Print[ "Are you sure that the file alpha.sem exists?"]
];
Clear[ translateList ];
translateList[ l:{___Integer} ]:= l;
translateList[ l:{___Real} ]:= l;
translateList[ l:{___Symbol} ]:= l;
translateList[ l:{___String} ]:= l;
translateList[ l:___ ]:= Message[ translateList::error3, l];
Clear[ translateLIBRARY ];
translateLIBRARY[ x:_ ] :=
    Switch[ x,
        _List, Map[ translateSYSTEMDECLARATION, x ],
        _, Message[ translateLIBRARY::error3, x ]
    ];

translateLIBRARY[ x:___ ] := Message[ translateLIBRARY::error3, x ] ; 

Clear[ translateSYSTEMDECLARATION ];
translateSYSTEMDECLARATION[ x:system[name_, paramDecl_, inputDeclList_, outputDeclList_, localDeclList_, equationBlock_] ] :=
Module[ {trname, trparamDecl, trinputDeclList, troutputDeclList, trlocalDeclList, trequationBlock},
  Catch[
    Check[
      If[ MatchQ[ name, _String ],, Throw[ Message[ translateSYSTEMDECLARATION::error1,name, x] ] ];
      trname = name;
      trparamDecl = translateDOMAIN[ paramDecl ];
      trinputDeclList = Map[ translateDECLARATION, inputDeclList ];
      troutputDeclList = Map[ translateDECLARATION, outputDeclList ];
      trlocalDeclList = Map[ translateDECLARATION, localDeclList ];
      trequationBlock = Map[ translateEQUATION, equationBlock ];
    {name, paramDecl, inputDeclList, outputDeclList, localDeclList, equationBlock},
    Message[ translateSYSTEMDECLARATION::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateSYSTEMDECLARATION[ x:___ ] := Message[ translateSYSTEMDECLARATION::error3, x ] ; 

Clear[ translateDECLARATION ];
translateDECLARATION[ x:decl[varName_, type_, domain_] ] :=
Module[ {trvarName, trtype, trdomain},
  Catch[
    Check[
      If[ MatchQ[ varName, _String ],, Throw[ Message[ translateDECLARATION::error1,varName, x] ] ];
      trvarName = varName;
      If[ MatchQ[ type, _Symbol ],, Throw[ Message[ translateDECLARATION::error1,type, x] ] ];
      trtype = type;
      trdomain = translateDOMAIN[ domain ];
    {varName, type, trdomain},
    Message[ translateDECLARATION::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateDECLARATION[ x:___ ] := Message[ translateDECLARATION::error3, x ] ; 

Clear[ translateDOMAIN ];
translateDOMAIN[ x:domain[dimension_, indexList:{___String}, polyedronList_] ] :=
Module[ {trdimension, trindexList, trpolyedronList},
  Catch[
    Check[
      If[ MatchQ[ dimension, _Integer ],, Throw[ Message[ translateDOMAIN::error1,dimension, x] ] ];
      trdimension = dimension;
      If[ MatchQ[ indexList, {___String} ],, Throw[ Message[ translateDOMAIN::error1,indexList, x] ] ];
      trindexList = indexList;
      trpolyedronList = Map[ translatePOLYHEDRON, polyedronList ];
    {dimension, indexList, polyedronList},
    Message[ translateDOMAIN::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateDOMAIN[ x:___ ] := Message[ translateDOMAIN::error3, x ] ; 

Clear[ translatePOLYHEDRON ];
translatePOLYHEDRON[ x:pol[constraintsNum_, generatorsNum_, equationsNum_, linesNum_, constraintList_, generatorList_] ] :=
Module[ {trconstraintsNum, trgeneratorsNum, trequationsNum, trlinesNum, trconstraintList, trgeneratorList},
  Catch[
    Check[
      If[ MatchQ[ constraintsNum, _Integer ],, Throw[ Message[ translatePOLYHEDRON::error1,constraintsNum, x] ] ];
      trconstraintsNum = constraintsNum;
      If[ MatchQ[ generatorsNum, _Integer ],, Throw[ Message[ translatePOLYHEDRON::error1,generatorsNum, x] ] ];
      trgeneratorsNum = generatorsNum;
      If[ MatchQ[ equationsNum, _Integer ],, Throw[ Message[ translatePOLYHEDRON::error1,equationsNum, x] ] ];
      trequationsNum = equationsNum;
      If[ MatchQ[ linesNum, _Integer ],, Throw[ Message[ translatePOLYHEDRON::error1,linesNum, x] ] ];
      trlinesNum = linesNum;
      trconstraintList = Map[ translateCONSTRAINT, constraintList ];
      trgeneratorList = Map[ translateGENERATOR, generatorList ];
    {constraintsNum, generatorsNum, equationsNum, linesNum, constraintList, generatorList},
    Message[ translatePOLYHEDRON::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translatePOLYHEDRON[ x:___ ] := Message[ translatePOLYHEDRON::error3, x ] ; 

Clear[ translateCONSTRAINT ];
translateCONSTRAINT[ x:_ ] :=
    Switch[ x,
        _List, translateList[ x ],
        _, Message[ translateCONSTRAINT::error3, x ]
    ];

translateCONSTRAINT[ x:___ ] := Message[ translateCONSTRAINT::error3, x ] ; 

Clear[ translateGENERATOR ];
translateGENERATOR[ x:_ ] :=
    Switch[ x,
        _List, translateList[ x ],
        _, Message[ translateGENERATOR::error3, x ]
    ];

translateGENERATOR[ x:___ ] := Message[ translateGENERATOR::error3, x ] ; 

Clear[ translateEQUATION ];
translateEQUATION[ x:_ ] :=
    Switch[ x,
        _equation, translateASSIGNMENT[ x ],
        _use, translateUSESTATEMENT[ x ],
        _, Message[ translateEQUATION::error3, x ]
    ];

translateEQUATION[ x:___ ] := Message[ translateEQUATION::error3, x ] ; 

Clear[ translateASSIGNMENT ];
translateASSIGNMENT[ x:equation[leftHandSide_, rightHandSide_] ] :=
Module[ {trleftHandSide, trrightHandSide},
  Catch[
    Check[
      If[ MatchQ[ leftHandSide, _String ],, Throw[ Message[ translateASSIGNMENT::error1,leftHandSide, x] ] ];
      trleftHandSide = leftHandSide;
      trrightHandSide = translateEXPRESSION[ rightHandSide ];
    {leftHandSide, rightHandSide},
    Message[ translateASSIGNMENT::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateASSIGNMENT[ x:___ ] := Message[ translateASSIGNMENT::error3, x ] ; 

Clear[ translateUSESTATEMENT ];
translateUSESTATEMENT[ x:use[id_, extension_, paramAssign_, inputList_, idList_] ] :=
Module[ {trid, trextension, trparamAssign, trinputList, tridList},
  Catch[
    Check[
      If[ MatchQ[ id, _String ],, Throw[ Message[ translateUSESTATEMENT::error1,id, x] ] ];
      trid = id;
      trextension = translateDOMAIN[ extension ];
      trparamAssign = translateMATRIX[ paramAssign ];
      trinputList = Map[ translateEXPRESION, inputList ];
      If[ MatchQ[ idList, {_String} ],, Throw[ Message[ translateUSESTATEMENT::error1,idList, x] ] ];
      tridList = idList;
    {id, extension, paramAssign, expList, idList},
    Message[ translateUSESTATEMENT::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateUSESTATEMENT[ x:___ ] := Message[ translateUSESTATEMENT::error3, x ] ; 

Clear[ translateEXPRESSION ];
translateEXPRESSION[ x:_ ] :=
    Switch[ x,
        _case, translateCASEXP[ x ],
        _restrict, translateRESTEXP[ x ],
        _if, translateIFEXP[ x ],
        _affine, translateAFFEXP[ x ],
        _binop, translateBINEXP[ x ],
        _unop, translateUNEXP[ x ],
        _reduce, translateREDEXP[ x ],
        _var, translateVAREXP[ x ],
        _const, translateCONSTEXP[ x ],
        _, Message[ translateEXPRESSION::error3, x ]
    ];

translateEXPRESSION[ x:___ ] := Message[ translateEXPRESSION::error3, x ] ; 

Clear[ translateCASEXP ];
translateCASEXP[ x:case[expressionList_] ] :=
Module[ {trexpressionList},
  Catch[
    Check[
      trexpressionList = Map[ translateEXPRESSION, expressionList ];
    expressionList,
    Message[ translateCASEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateCASEXP[ x:___ ] := Message[ translateCASEXP::error3, x ] ; 

Clear[ translateRESTEXP ];
translateRESTEXP[ x:restrict[domain_, expression_] ] :=
Module[ {trdomain, trexpression},
  Catch[
    Check[
      trdomain = translateDOMAIN[ domain ];
      trexpression = translateEXPRESSION[ expression ];
    {domain, expression},
    Message[ translateRESTEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateRESTEXP[ x:___ ] := Message[ translateRESTEXP::error3, x ] ; 

Clear[ translateIFEXP ];
translateIFEXP[ x:if[condition_, alt1_, alt2_] ] :=
Module[ {trcondition, tralt1, tralt2},
  Catch[
    Check[
      trcondition = translateEXPRESSION[ condition ];
      tralt1 = translateEXPRESSION[ alt1 ];
      tralt2 = translateEXPRESSION[ alt2 ];
    {condition, alt1, alt2},
    Message[ translateIFEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateIFEXP[ x:___ ] := Message[ translateIFEXP::error3, x ] ; 

Clear[ translateAFFEXP ];
translateAFFEXP[ x:affine[expression_, affineFunction_] ] :=
Module[ {trexpression, traffineFunction},
  Catch[
    Check[
      trexpression = translateEXPRESSION[ expression ];
      traffineFunction = translateMATRIX[ affineFunction ];
    {expression, affineFunction},
    Message[ translateAFFEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateAFFEXP[ x:___ ] := Message[ translateAFFEXP::error3, x ] ; 

Clear[ translateMATRIX ];
translateMATRIX[ x:matrix[d1_, d2_, in:{___String}, mmaMatrix_] ] :=
Module[ {trd1, trd2, trin, trmmaMatrix},
  Catch[
    Check[
      If[ MatchQ[ d1, _Integer ],, Throw[ Message[ translateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],, Throw[ Message[ translateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],, Throw[ Message[ translateMATRIX::error1,in, x] ] ];
      trin = in;
      trmmaMatrix = translateMATRIXNUM[ mmaMatrix ];
    mmaMatrix,
    Message[ translateMATRIX::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateMATRIX[ x:___ ] := Message[ translateMATRIX::error3, x ] ; 

Clear[ translateMATRIXNUM ];
translateMATRIXNUM[ x:_ ] :=
    Switch[ x,
        _List, Map[ translateList, x ],
        _, Message[ translateMATRIXNUM::error3, x ]
    ];

translateMATRIXNUM[ x:___ ] := Message[ translateMATRIXNUM::error3, x ] ; 

Clear[ translateBINEXP ];
translateBINEXP[ x:binop[binaryOp:add | sub | mul | div | or | and | xor | min | max | eg | ne | le | lt | gt | minus | div | mod, operand1_, operand2_] ] :=
Module[ {trbinaryOp, troperand1, troperand2},
  Catch[
    Check[
      If[ MatchQ[ binaryOp, add | sub | mul | div | or | and | xor | min | max | eg | ne | le | lt | gt | minus | div | mod ],, Throw[ Message[ translateBINEXP::error1,binaryOp, x] ] ];
      trbinaryOp = binaryOp;
      troperand1 = translateEXPRESSION[ operand1 ];
      troperand2 = translateEXPRESSION[ operand2 ];
    {operand1, binaryOp, operand2},
    Message[ translateBINEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateBINEXP[ x:___ ] := Message[ translateBINEXP::error3, x ] ; 

Clear[ translateUNEXP ];
translateUNEXP[ x:unop[unaryOp:minus | not | sqrt, operand_] ] :=
Module[ {trunaryOp, troperand},
  Catch[
    Check[
      If[ MatchQ[ unaryOp, minus | not | sqrt ],, Throw[ Message[ translateUNEXP::error1,unaryOp, x] ] ];
      trunaryOp = unaryOp;
      troperand = translateEXPRESSION[ operand ];
    {unaryOp, operand},
    Message[ translateUNEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateUNEXP[ x:___ ] := Message[ translateUNEXP::error3, x ] ; 

Clear[ translateREDEXP ];
translateREDEXP[ x:red[commutativeOp:add | mult | or | xor | and | min | max, affineExp_, expression_] ] :=
Module[ {trcommutativeOp, traffineExp, trexpression},
  Catch[
    Check[
      If[ MatchQ[ commutativeOp, add | mult | or | xor | and | min | max ],, Throw[ Message[ translateREDEXP::error1,commutativeOp, x] ] ];
      trcommutativeOp = commutativeOp;
      traffineExp = translateAFFEXP[ affineExp ];
      trexpression = translateEXPRESSION[ expression ];
    {commutativeOp, affineExp, expression},
    Message[ translateREDEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateREDEXP[ x:___ ] := Message[ translateREDEXP::error3, x ] ; 

Clear[ translateVAREXP ];
translateVAREXP[ x:var[identifier_] ] :=
Module[ {tridentifier},
  Catch[
    Check[
      If[ MatchQ[ identifier, _String ],, Throw[ Message[ translateVAREXP::error1,identifier, x] ] ];
      tridentifier = identifier;
    identifier,
    Message[ translateVAREXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateVAREXP[ x:___ ] := Message[ translateVAREXP::error3, x ] ; 

Clear[ translateCONSTEXP ];
translateCONSTEXP[ x:const[constant:_Integer | _Real | True | False] ] :=
Module[ {trconstant},
  Catch[
    Check[
      If[ MatchQ[ constant, _Integer | _Real | True | False ],, Throw[ Message[ translateCONSTEXP::error1,constant, x] ] ];
      trconstant = constant;
    constant,
    Message[ translateCONSTEXP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
] (* End Module *)
translateCONSTEXP[ x:___ ] := Message[ translateCONSTEXP::error3, x ] ; 

End[];
EndPackage[];
