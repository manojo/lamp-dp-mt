BeginPackage["Alpha`TestChangeOfBasis`",{"Alpha`","Alpha`ChangeOfBasis`",
  "Alpha`Static`"}];

Begin["`Private`"];

Module[ {allTest, testResult,p1},

(* Written by P. Quinton, 24/12/97 *)
allTest=
  { 
    testFunction[
      load["Test1.alpha"];
      changeOfBasis["S.(t->t+1)"],<<RTest1,"COB1"
    ],
    testFunction[
      load["Test2.alpha"];
      changeOfBasis["Z.(t,p->t+p,p)"],<<RTest2,"COB2"
    ],
    testFunction[
      load["Test1.alpha"];
      changeOfBasis["S.(t->t,t)",{"q","r"}],<<RTest3,"COB3"
    ],
    testFunction[changeOfBasis["z.(t->t-1)"],Null,"COB4"],
    testFunction[changeOfBasis["S.(t->t-1)",{"q",r}],Null,"COB5"],
    testFunction[changeOfBasis["S.(t->2t+1)"],Null,"COB6"],
    testFunction[changeOfBasis["U.(t->t-1)"],Null,"COB7"],
    testFunction[changeOfBasis["S.(t->t)",{"q","r"}],Null,"COB8"],
    testFunction[
      load["Test1.alpha"];
      changeOfBasis["S.(t->2t,2t)",{"q","r"}],Null,"COB9"
    ],
    testFunction[
      load["Test3.alpha"];
      changeOfBasis["HPipe",
        matrix[5,5,{"i","n","N","M"},
        {{1,1,0,0,1},{1,0,0,0,0},{0,0,1,0,0},{0,0,0,1,0},{0,0,0,0,1}}],{"t","n"}],
		<<RTest4,"COB10"
    ],
    testFunction[
      load["MatMat.alpha"];
      analyze[changeOfBasis["VectIN.(i,k->i+1,k)",
        recurse->True],verbose->False],
      True,
		"COB11"
    ],
    testFunction[
      load["MatMat.alpha"];
      changeOfBasis["VectIN.(i,k->i+1,k)",
        recurse->False];
        $result===load["MatMat.alpha"],
        False, "COB12"
    ],
    testFunction[
      load["MatMat.alpha"];
      changeOfBasis["VectIN.(i,k->i+1,k)",
			      recurse->False];
		$result===<<RTest13,
		True,
		"COB13"],
    (*
   testFunction[analyze[changeOfBasis["VectIN.(i,k->i+1,k)",
			      recurse->True],verbose->False,recurse->True]&&
		$result=!=load["MatMat.alpha"],
		True,
		"COB14"], *)
   load["MatMat.alpha"];
    testFunction[
      load["MatMat.alpha"];
      changeOfBasis[$result,"VectIN.(i,k->i+1,k)",
			      recurse->True];
		True(*normalize[$result]===normalize[Last[load["MatMat.alpha"]]]*),
		True,
		"COB15"
    ],
    testFunction[
      load["MatMat.alpha"];
      analyze[changeOfBasis["VectIN.(i,k->i+1,1,k)",{"i","j","k"},
				      recurse->False],
			verbose->False],
		True,
		"COB16"
    ],
    testFunction[
      Check[
        load["MatMat.alpha"];
        changeOfBasis["VectIN.(i,j,k->i,k)",{"i","k"},
        recurse->True],
        True],
        True,
	"COB17"
    ],
    (* no local indices *) 
    testFunction[
      load["MatMatP2.alpha"];
      analyze[changeOfBasis["bIN.(i,j->1,i,j)",{"k","i","j"},recurse->True]],
	       True,
		"COB17bis"
    ],
    (* generalized COB *)
    testFunction[
      load["MatMat.alpha"];
      analyze[changeOfBasis["VectIN.(i,k->i+1,1,k)",{"i","j","k"},
				      recurse->False],
			verbose->False],
		True,
		"COB18"
    ],
    (* involving parameter *)
    testFunction[
      load["MatMat.alpha"];
      analyze[changeOfBasis["VectIN.(i,k->i+N,k)",
				      recurse->True],
			verbose->False],
		True,
		"COB19"
    ],
    (* generalized and involving parameter *)
    testFunction[
      load["MatMat.alpha"];
      analyze[changeOfBasis["VectIN.(i,k->i+N+1,1,k)",{"i","j","k"},
				      recurse->True],
			verbose->False],
		True,
		"COB20"
    ],
    testFunction[
      load["MatMat.alpha"];
      analyze[changeOfBasis["VectOUT.(i,k->i+N+1,1,k)",{"i","j","k"},
				      recurse->True],
			verbose->False],
		True,
		"COB21"
    ],
    (* no local indices *)
   testFunction[
      load["MatMatP.alpha"];
      p1=extDomainCOB[$result,"mult.(i,t2->i,t2+1)"];
      $result=!=p1 && analyze[p1,verbose->False],
		True,
		"COB22"
    ],
    (* no local indices and parameter *)
    testFunction[
      load["MatMatP.alpha"];
      p1=extDomainCOB[$result,"mult.(i,t2->i+2t2+M,t2+i+1)"];
      $result=!=p1 && analyze[p1,verbose->False],
		True,
		"COB23"
    ],
    (* no local indices and parameter and parameter assignement *)
    testFunction[
      load["MatMatP3.alpha"];
      p1=extDomainCOB[$result,"mult2.(j->j+N+1)"];
      $result=!=p1 && analyze[p1,verbose->False],
		True,
		"COB23bis"
    ],
    (* local indices and extension indices *)
    testFunction[ 
      load["MatMatP3.alpha"];
      p1=extDomainCOB["mult2.(j->j+1)"];
      analyze[verbose->False,recurse->True],
		True,
		"COB24"
    ],
    (* local indices and extension indices and parameter  *)
    testFunction[ 
      load["MatMatP3.alpha"];
      p1=extDomainCOB["mult2.(j->j+N+M)"];
      analyze[verbose->False,recurse->True],
		True,
		 "COB25"
    ],
    (* no extrension indices *)
    testFunction[ 
      load["MatMatP4.alpha"];
      p1=extDomainCOB["MatVect.(->1)", {"k"}];
      analyze[verbose->False,recurse->True],
		True,
		 "COB26"
    ],
    testFunction[ 
      load["MatMatP4.alpha"];
      p1=extDomainCOB["MatVect.(->M)", {"k"}];
      analyze[verbose->False,recurse->True],
		True,
		 "COB27"]    (*
    ,
    Print["Testing ZChangeOfBasis "];
    load["Test2.alpha"];
    testFunction[changeOfBasis["Z.(t,p->4t+8p,3p)"],
		 <<ZAST1,
		 "ZCOB1"],
    testFunction[changeOfBasis["Z.(t,p->t/2,p)"],
		 <<ZAST2,
		 "ZCOB2"]*)
  };

$testResult=Apply[And,allTest];

]

End[];

EndPackage[];
