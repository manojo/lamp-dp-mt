BeginPackage["Alpha`alpha2mma`",{"Alpha`",
"Alpha`Domlib`",
"Alpha`Tables`",
"Alpha`Matrix`",
	
"Alpha`Options`", 
"Alpha`Static`"}];
alpha2mmaDebug::usage = "Debug Switch";
alpha2mmaDebug = False;
alpha2mmaTranslatelist::usage = "";
alpha2mmaTranslateDOMAIN::usage = "";
alpha2mmaTranslateSYSTEM::usage = "";
alpha2mmaTranslatePOL::usage = "";
alpha2mmaTranslateCONSTRAINT::usage = "";
alpha2mmaTranslateGENERATORS::usage = "";
alpha2mmaTranslateEQUATION::usage = "";
alpha2mmaTranslateASSIGNMENT::usage = "";
alpha2mmaTranslateEXPRESSION::usage = "";
alpha2mmaTranslateBINOP::usage = "";
alpha2mmaTranslateVAR::usage = "";
alpha2mmaTranslateAFFINE::usage = "";
alpha2mmaTranslateEXPRESSIONAFFINE::usage = "";
alpha2mmaTranslateMATRIX::usage = "";
alpha2mmaTranslateRESTRICT::usage = "";
alpha2mmaTranslateCASE::usage = "";
alpha2mmaTranslateCONST::usage = "";
alpha2mmaTranslateUSESTATEMENT::usage = "";
Begin[ "`Private`" ];
With[{f="/Users/patricequinton/mmalpha/doc/Packages/Meta/alpha2mma.sem"},
  Check[ Get[ f ],
       Print[ "Error while trying reading file alpha2mma "]]
];
Clear[ alpha2mmaTranslateList ];
alpha2mmaTranslateList[ l:{___Integer}, opts:___Rule ]:= l;
alpha2mmaTranslateList[ l:{___Real}, opts:___Rule ]:= l;
alpha2mmaTranslateList[ l:{___Symbol}, opts:___Rule ]:= l;
alpha2mmaTranslateList[ l:{___String}, opts:___Rule ]:= l;
alpha2mmaTranslateList[ l:___ ]:= 
  If[alpha2mmaDebug,Message[ alpha2mmaTranslateList::error3, l]];False
 (* ------- *)

 Clear[ alpha2mmaTranslateDOMAIN ];
alpha2mmaTranslateDOMAIN[ x:domain[d_, i:{___String}, p_], opts:___Rule ] :=
Module[ {trd, tri, trp, tr$d, tr$i, tr$p},
  Catch[
    Check[
      If[ MatchQ[ d, _Integer ],Null, Throw[ Message[ alpha2mmaTranslateDOMAIN::error1,d, x] ] ];
      trd = d;
      If[ MatchQ[ i, {___String} ],Null, Throw[ Message[ alpha2mmaTranslateDOMAIN::error1,i, x] ] ];
      tri = i;
      trp = Map[ alpha2mmaTranslatePOL[#,opts]&, p ];
      tr$p = trp;
    Null,
    Message[ alpha2mmaTranslateDOMAIN::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateDOMAIN[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateDOMAIN::error3, x ]];False)

Clear[ alpha2mmaTranslateSYSTEM ];
alpha2mmaTranslateSYSTEM[ x:system[n_, p_, id_, od_, ld_, e_], opts:___Rule ] :=
Module[ {trn, trp, trid, trod, trld, tre, tr$n, tr$p, tr$id, tr$od, tr$ld, tr$e},
  Catch[
    Check[
      If[ MatchQ[ n, _String ],Null, Throw[ Message[ alpha2mmaTranslateSYSTEM::error1,n, x] ] ];
      trn = n;
      trp = alpha2mmaTranslateDOMAIN[ p, opts ];
      trid = Map[ alpha2mmaTranslateDECLARATION[#,opts]&, id ];
      tr$id = trid;
      trod = Map[ alpha2mmaTranslateDECLARATION[#,opts]&, od ];
      tr$od = trod;
      trld = Map[ alpha2mmaTranslateDECLARATION[#,opts]&, ld ];
      tr$ld = trld;
      tre = Map[ alpha2mmaTranslateEQUATION[#,opts]&, e ];
      tr$e = tre;
    semanticFunction[system, {n, p, id, od, ld, tre}],
    Message[ alpha2mmaTranslateSYSTEM::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateSYSTEM[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateSYSTEM::error3, x ]];False)

Clear[ alpha2mmaTranslatePOL ];
alpha2mmaTranslatePOL[ x:pol[a_, b_, c_, d_, co_, ge_], opts:___Rule ] :=
Module[ {tra, trb, trc, trd, trco, trge, tr$a, tr$b, tr$c, tr$d, tr$co, tr$ge},
  Catch[
    Check[
      If[ MatchQ[ a, _Integer ],Null, Throw[ Message[ alpha2mmaTranslatePOL::error1,a, x] ] ];
      tra = a;
      If[ MatchQ[ b, _Integer ],Null, Throw[ Message[ alpha2mmaTranslatePOL::error1,b, x] ] ];
      trb = b;
      If[ MatchQ[ c, _Integer ],Null, Throw[ Message[ alpha2mmaTranslatePOL::error1,c, x] ] ];
      trc = c;
      If[ MatchQ[ d, _Integer ],Null, Throw[ Message[ alpha2mmaTranslatePOL::error1,d, x] ] ];
      trd = d;
      trco = Map[ alpha2mmaTranslateCONSTRAINT[#,opts]&, co ];
      tr$co = trco;
      trge = Map[ alpha2mmaTranslateGENERATORS[#,opts]&, ge ];
      tr$ge = trge;
    pol[tra, trb, trc, trd, trco, trge],
    Message[ alpha2mmaTranslatePOL::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslatePOL[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslatePOL::error3, x ]];False)

Clear[ alpha2mmaTranslateCONSTRAINT ];
alpha2mmaTranslateCONSTRAINT[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, alpha2mmaTranslateList[ x, opts ],
        _, (If[alpha2mmaDebug,Message[ alpha2mmaTranslateCONSTRAINT::error3, x ]];False)
    ];

alpha2mmaTranslateCONSTRAINT[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateCONSTRAINT::error3, x ]];False)

Clear[ alpha2mmaTranslateGENERATORS ];
alpha2mmaTranslateGENERATORS[ x:_, opts:___Rule ] :=
    Switch[ x,
        _List, alpha2mmaTranslateList[ x, opts ],
        _, (If[alpha2mmaDebug,Message[ alpha2mmaTranslateGENERATORS::error3, x ]];False)
    ];

alpha2mmaTranslateGENERATORS[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateGENERATORS::error3, x ]];False)

Clear[ alpha2mmaTranslateEQUATION ];
alpha2mmaTranslateEQUATION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _equation, alpha2mmaTranslateASSIGNMENT[ x, opts ],
        _use, alpha2mmaTranslateUSESTATEMENT[ x, opts ],
        _, (If[alpha2mmaDebug,Message[ alpha2mmaTranslateEQUATION::error3, x ]];False)
    ];

alpha2mmaTranslateEQUATION[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateEQUATION::error3, x ]];False)

Clear[ alpha2mmaTranslateASSIGNMENT ];
alpha2mmaTranslateASSIGNMENT[ x:equation[c_, e_], opts:___Rule ] :=
Module[ {trc, tre, tr$c, tr$e},
  Catch[
    Check[
      If[ MatchQ[ c, _String ],Null, Throw[ Message[ alpha2mmaTranslateASSIGNMENT::error1,c, x] ] ];
      trc = c;
      tre = alpha2mmaTranslateEXPRESSION[ e, opts ];
    semanticFunction[assignment, {c, tre}],
    Message[ alpha2mmaTranslateASSIGNMENT::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateASSIGNMENT[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateASSIGNMENT::error3, x ]];False)

Clear[ alpha2mmaTranslateEXPRESSION ];
alpha2mmaTranslateEXPRESSION[ x:_, opts:___Rule ] :=
    Switch[ x,
        _binop, alpha2mmaTranslateBINOP[ x, opts ],
        _var, alpha2mmaTranslateVAR[ x, opts ],
        _affine, alpha2mmaTranslateAFFINE[ x, opts ],
        _restrict, alpha2mmaTranslateRESTRICT[ x, opts ],
        _case, alpha2mmaTranslateCASE[ x, opts ],
        _const, alpha2mmaTranslateCONST[ x, opts ],
        _, (If[alpha2mmaDebug,Message[ alpha2mmaTranslateEXPRESSION::error3, x ]];False)
    ];

alpha2mmaTranslateEXPRESSION[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateEXPRESSION::error3, x ]];False)

Clear[ alpha2mmaTranslateBINOP ];
alpha2mmaTranslateBINOP[ x:binop[op_, op1_, op2_], opts:___Rule ] :=
Module[ {trop, trop1, trop2, tr$op, tr$op1, tr$op2},
  Catch[
    Check[
      If[ MatchQ[ op, _Symbol ],Null, Throw[ Message[ alpha2mmaTranslateBINOP::error1,op, x] ] ];
      trop = op;
      trop1 = alpha2mmaTranslateEXPRESSION[ op1, opts ];
      trop2 = alpha2mmaTranslateEXPRESSION[ op2, opts ];
    semanticFunction[binop, {op, trop1, trop2}],
    Message[ alpha2mmaTranslateBINOP::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateBINOP[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateBINOP::error3, x ]];False)

Clear[ alpha2mmaTranslateVAR ];
alpha2mmaTranslateVAR[ x:var[v_], opts:___Rule ] :=
Module[ {trv, tr$v},
  Catch[
    Check[
      If[ MatchQ[ v, _String ],Null, Throw[ Message[ alpha2mmaTranslateVAR::error1,v, x] ] ];
      trv = v;
    semanticFunction[var, v],
    Message[ alpha2mmaTranslateVAR::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateVAR[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateVAR::error3, x ]];False)

Clear[ alpha2mmaTranslateAFFINE ];
alpha2mmaTranslateAFFINE[ x:affine[e_, m_], opts:___Rule ] :=
Module[ {tre, trm, tr$e, tr$m},
  Catch[
    Check[
      tre = alpha2mmaTranslateEXPRESSIONAFFINE[ e, opts ];
      trm = alpha2mmaTranslateMATRIX[ m, opts ];
    semanticFunction[affine, {e, trm}],
    Message[ alpha2mmaTranslateAFFINE::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateAFFINE[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateAFFINE::error3, x ]];False)

Clear[ alpha2mmaTranslateEXPRESSIONAFFINE ];
alpha2mmaTranslateEXPRESSIONAFFINE[ x:_, opts:___Rule ] :=
    Switch[ x,
        _var, alpha2mmaTranslateVAR[ x, opts ],
        _const, alpha2mmaTranslateCONST[ x, opts ],
        _, (If[alpha2mmaDebug,Message[ alpha2mmaTranslateEXPRESSIONAFFINE::error3, x ]];False)
    ];

alpha2mmaTranslateEXPRESSIONAFFINE[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateEXPRESSIONAFFINE::error3, x ]];False)

Clear[ alpha2mmaTranslateMATRIX ];
alpha2mmaTranslateMATRIX[ x:matrix[d1_, d2_, in:{___String}, m_], opts:___Rule ] :=
Module[ {trd1, trd2, trin, trm, tr$d1, tr$d2, tr$in, tr$m},
  Catch[
    Check[
      If[ MatchQ[ d1, _Integer ],Null, Throw[ Message[ alpha2mmaTranslateMATRIX::error1,d1, x] ] ];
      trd1 = d1;
      If[ MatchQ[ d2, _Integer ],Null, Throw[ Message[ alpha2mmaTranslateMATRIX::error1,d2, x] ] ];
      trd2 = d2;
      If[ MatchQ[ in, {___String} ],Null, Throw[ Message[ alpha2mmaTranslateMATRIX::error1,in, x] ] ];
      trin = in;
      If[ MatchQ[ m, _ ],Null, Throw[ Message[ alpha2mmaTranslateMATRIX::error1,m, x] ] ];
      trm = m;
    m,
    Message[ alpha2mmaTranslateMATRIX::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateMATRIX[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateMATRIX::error3, x ]];False)

Clear[ alpha2mmaTranslateRESTRICT ];
alpha2mmaTranslateRESTRICT[ x:restrict[d_, e_], opts:___Rule ] :=
Module[ {trd, tre, tr$d, tr$e},
  Catch[
    Check[
      trd = alpha2mmaTranslateDOMAIN[ d, opts ];
      tre = alpha2mmaTranslateEXPRESSION[ e, opts ];
    semanticFunction[restrict, {d, tre}],
    Message[ alpha2mmaTranslateRESTRICT::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateRESTRICT[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateRESTRICT::error3, x ]];False)

Clear[ alpha2mmaTranslateCASE ];
alpha2mmaTranslateCASE[ x:case[e_], opts:___Rule ] :=
Module[ {tre, tr$e},
  Catch[
    Check[
      tre = Map[ alpha2mmaTranslateEXPRESSION[#,opts]&, e ];
      tr$e = tre;
    semanticFunction[case, e, tre],
    Message[ alpha2mmaTranslateCASE::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateCASE[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateCASE::error3, x ]];False)

Clear[ alpha2mmaTranslateCONST ];
alpha2mmaTranslateCONST[ x:const[c_], opts:___Rule ] :=
Module[ {trc, tr$c},
  Catch[
    Check[
      If[ MatchQ[ c, _ ],Null, Throw[ Message[ alpha2mmaTranslateCONST::error1,c, x] ] ];
      trc = c;
    c,
    Message[ alpha2mmaTranslateCONST::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateCONST[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateCONST::error3, x ]];False)

Clear[ alpha2mmaTranslateUSESTATEMENT ];
alpha2mmaTranslateUSESTATEMENT[ x:use[sn_, d_, m_, iv_, ov:{__String}], opts:___Rule ] :=
Module[ {trsn, trd, trm, triv, trov, tr$sn, tr$d, tr$m, tr$iv, tr$ov},
  Catch[
    Check[
      If[ MatchQ[ sn, _String ],Null, Throw[ Message[ alpha2mmaTranslateUSESTATEMENT::error1,sn, x] ] ];
      trsn = sn;
      trd = alpha2mmaTranslateDOMAIN[ d, opts ];
      trm = alpha2mmaTranslateMATRIX[ m, opts ];
      triv = Map[ alpha2mmaTranslateVAR[#,opts]&, iv ];
      tr$iv = triv;
      If[ MatchQ[ ov, {__String} ],Null, Throw[ Message[ alpha2mmaTranslateUSESTATEMENT::error1,ov, x] ] ];
      trov = ov;
    semanticFunction[use, {sn, d, m, iv, ov}],
    Message[ alpha2mmaTranslateUSESTATEMENT::error2, x ]
    ] (* End Check *)
  ] (* End Catch *)
]; (* End Module *)
alpha2mmaTranslateUSESTATEMENT[ x:___ ] := (If[alpha2mmaDebug,Message[ alpha2mmaTranslateUSESTATEMENT::error3, x ]];False)

 (* ------- *) End[];
EndPackage[];
