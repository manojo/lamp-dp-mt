Catch[
Module[ {schedSav, res, dir},
  dir = Directory[];
  schedSav = $schedule;
  SetDirectory[Environment["MMALPHA"]<>"/tests/TestCodeGen/"];

  Print["Test for CodeGen"];
  (* The Run command of Mathematica does not heritate from all the path,
     and variables I do not know how to change that on cygwin *)

  res = True;

  Print["Tests the Loop.m package "];
 
  (* Basically one function: mkLoop *)

  (* No parameter *)
  res = res 
    && testFunction[
         mkLoop[readDom["{i,j,N|1<=i<=N;j=2i}"], 1, 1, {}, "code"],
         block[
           hseq["for (", hseq[symbol["i"], " = ", hseq[1]], "; ", 
           hseq[symbol["i"], " <= ", symbol["N"]], "; ", "++", 
           symbol["i"], ")"], 
           vseq[
             hseq[symbol["j"], " = ", Times[2, symbol["i"]], ";"], "code"]
         ],
         "Test Loop 1"];

  If[ ! res, Throw["Error"] ];
 
  res = res 
    && testFunction[
         mkLoop[readDom["{i,j,N|1<=i<=N;j=2i}"], 1, 1, {"N"->10}, "code"],
         block[hseq["for (", hseq[symbol["i"], " = ", hseq[1]], "; ", 
           hseq[symbol["i"], " <= ", 10], "; ", "++", symbol["i"], ")"], 
           vseq[hseq[symbol["j"], " = ", 
           Times[2, symbol["i"]], ";"], "code"]
         ],
         "Test Loop 2"];

  If[ ! res, Throw["Error"] ];

  res = res && 
     testFunction[
       mkLoop[readDom["{i,j,N|1<=i<=N;j=2i}"], 2, 1, {"N"->10}, "code"],
       vseq[hseq[symbol["j"], " = ", Times[2, symbol["i"]], ";"], "code"],
       "Test Loop 3"];

  If[ ! res, Throw["Error"] ];

  Print["Testing Restrict.m"];

  res = res && 
    testFunction[
      mkRestrictExpr[ readDom["{i,j,N|1<=i<=N;j=2i}"], {"i1", "i2"}, 
        1, {}, "code", "code2"],
      hseq[hseq["(", 
        hseq[And[Equal[Plus[Times[2, symbol["i1"]], 
          Times[-1, symbol["i2"]]], 0], 
        GreaterEqual[Plus[-2, symbol["i2"]], 0], 
        GreaterEqual[Plus[Times[-1, symbol["i2"]], Times[2, symbol["N"]]], 
		    0]]], ") ? ", "code", ":", "\n"], hseq["\t", "code2"]
      ],
      "Test Restrict 1"];

  If[ ! res, Throw["Error"] ];

  res = res && 
    testFunction[
      mkRestrict[readDom["{i,j,N|1<=i<=N;j=2i}"], 1, {}, "code2"],
      block[hseq[" if (", 
        hseq[And[Equal[Plus[Times[2, symbol["i"]], 
          Times[-1, symbol["j"]]], 0], 
        GreaterEqual[Plus[-2, symbol["j"]], 0], 
        GreaterEqual[Plus[Times[-1, symbol["j"]], Times[2, symbol["N"]]], 
          0]]], ")"], "code2"
      ],
    "Test Restrict 2"];

  If[ ! res, Throw["Error"] ];
  
  Print["Testing Domain.m "];

  res = res && 
    testFunction[
      mkDomain["var1", integer, readDom["{i,j,N,M|1<=i<=N;j=2i}"], 2, 
        {"N" -> 10}],
      List[vseq[
        left["#define ", "var1", "(", list["i", "j"], ") ", "_", "var1", "[", 
        Plus[-1, "(i)"], "]"]], 
        vseq[hseq["int", " * _", "var1", " = (", "int", 
        " *) malloc(sizeof(", "int",
        ")*(", 10, "));"]], vseq[hseq["free(_", "var1", ");"]], 
        left["#undef ", "var1"]
      ],
      "Test Domain 1"];

  If[ ! res, Throw["Error"] ];
  
  res = res && 
    testFunction[
      mkDomain["var1", integer,readDom["{i,j,N,M|1<=i<=j;1<=j<=M}"], 2, 
      {"N" -> 10}],
      List[vseq["struct {", vseq["  int dim2;", "  int dim0;"], 
      hseq["} __var1 = {", 
      list[Ceiling["M"], Plus[-1, Times[-1, Ceiling["M"]]]], "};"], 
      left["#define ", "var1", "(", list["i", "j"], ") ", "_", "var1", "[", 
      Plus["(i)", "__var1.dim0", Times["(j)", "__var1.dim2"]], "]"]], 
      vseq[hseq["int", " * _", "var1", " = (", "int", 
        " *) malloc(sizeof(", "int",
        ")*(", Power[Ceiling["M"], 2], "));"]], 
      vseq[hseq["free(_", "var1", ");"]], left["#undef ", "var1"]
      ],
      "Test Domain 2"];

  If[ ! res, Throw["Error"] ];

  (* domAllocDims ??? test made by Fabien *)

  testlist := {
    {readDom["{i,j,k | i=2k; j=1}"], 0},
    {readDom["{i,j,N | j=i-N; N+1<=i<=2N}"],1},
    {readDom["{i,j,N | i=N; 1<=j<=N}"], 1},
    {readDom["{i,j,N | i=N; j=N+1}"],1},
    {readDom["{i,j,N | 1<=i<=N; 1<=j<=N+1}"],1},
    {readDom["{i,j,N,M | N=2M; 1<=i<=N; 1<=j<=M}"],2},
    {readDom["{i,j,N,M | 3j=M; i=N; N=2M}"],2},
    {readDom["{i,j,k,l,N,M | 3j=2k; 5i=3k; -M<=i<=(N,M,8);(M-N, -M)<=l<=M+N; l<=8; l<=M+2}"],2}
   };

  res = res && 
    testFunction[Map[Apply[domAllocDims, #]&, testlist],
    {{3}, {1}, {2}, {}, {1, 2}, {1, 2}, {}, {4, 1}},
    "Test Domain 3"];
 
  If[ ! res, Throw["Error"] ];

  Print["Testing the parameter passing of  the cGen function "];

  Check[ 
    load["Alpha/verySimple.alpha"],
    Throw[ Null ]
  ];

  sched1 = scheduleResult["SimpleEx", 
  List[List["a", List["n", "N"], sched[List[0, 0], 0]], 
    List["c", List["n", "N"], sched[List[0, 0], 2]], 
      List["A", List["n", "N"], sched[List[0, 0], 1]]], List[0, 2]];

  $schedule=Null;
  res = res && 
    testFunction[cGen["C/verySimple.c"],False,"test cGen 1 "];

  If[ ! res, Throw["Error"] ];

  res = res && 
    testFunction[cGen["C/verySimple.c",{}],False,"test cGen 2 "];

  If[ ! res, Throw["Error"] ];

  res = res && 
    testFunction[cGen[$result, sched1, "C/verySimple.c", {}],True,
    "test cGen 3 "];

  If[ ! res, Throw["Error"] ];


  $schedule=sched1;

  res = res && 
    testFunction[cGen[$result,  "C/verySimple.c", {}],True,"test cGen 4 "];

  If[ ! res, Throw["Error"] ];

  res = res && 
    testFunction[cGen[  "C/verySimple.c", {}],True,"test cGen 5 "];

  If[ ! res, Throw["Error"] ];

  res = res && 
    testFunction[cGen[  "C/verySimple.c", {"N"->10}],True,"test cGen 6 "];

  Print["Testing options of  the cGen function (to be completed ) "];
  
  res = res && 
    testFunction[MatchQ[cGen[ $result, sched1,
      "C/verySimple.c", {"N"->10},internalFormat->True],
      vseq[___]],
      True,"test cGen 7 "];

res=res && testFunction[MatchQ[cGen[ $result, sched1,
			"C/verySimple.c", {"N"->10},internalFormat->True,interactive->False],
		   vseq[___]],
		       True,"test cGen 8 "];

res=res && testFunction[MatchQ[cGen[ $result, sched1,
			"C/verySimple.c", {"N"->10},
			internalFormat->True,matlab->True],
		   vseq[___]],
		       True,"test cGen 9 "];

res=res && testFunction[cGen[ $result, sched1,"C/verySimple.c", {"N"->10},rewrite->False],
		       $Failed,"test cGen 10 "];
test1=$result/.(real->integer["S",8]);
res=res && testFunction[MatchQ[cGen[ test1, sched1,
			"C/verySimple.c", {"N"->10},
			internalFormat->True,bitTrue->True],
		   vseq[___]],
		       True,"test cGen 11 "];

res=res && testFunction[cGen[ $result, sched1,
			"C/verySimple.c", {"N"->10},
			    stimuli->True],
		       True,"test cGen 12 "];

$schedule=sched1;
prog1=appSched[$result,$schedule];
res=res && testFunction[cGen[prog1,
			"C/verySimple.c", {"N"->10},
			alreadySchedule->True],
		       True,"test cGen 13 "];
addLocal["A1=A"];
changeOfBasis["A1.(n->n+1)"];
normalize[];
res=res && testFunction[
  cGen[$result, "C/verySimple.c", {"N" -> 10}, 
      alreadySchedule -> True], False, "test cGen 13 "];


(************ Sarting the tests ******************)
Print["Longer test Tests the cGen function "];
opSys = Switch[$OperatingSystem,
	      "WindowsNT", "cygwin",
	      "Unix", "solaris",
	      "Linux","linux",
	      _, $OperatingSystem];

echo "" > resTest;
echo "" > errTest;

Clear[PRun];
buildCML[]:=commandLine="make \"FILE\"="<>cFile<>" \"TEST\"="<>testFile<>" \"OSTYPE\"="<>opSys<>" 1>>resMake 2>errMake "; 

Clear[PRun];
PRun[x_]:=(Print[x];Run[x]);
     (* the scheme is: define the variables cFile, testFile, build 
      the command line (with buildCML) then execute it with PRun *) 
load["Alpha/lx.a"];
schedule[];
cGen[$result,$schedule,"C/lx.c",{"N"->3},noPrint->True];
cFile="lx";
testFile="lx1";
buildCML[];
If[PRun[commandLine]=!=0,
   Print["************************************"];
  Print["Probleme with test "<>testFile<>" for c file "<>cFile<>".c, \n here is the exact message: "];
  Print[Apply[StringJoin,Map[StringJoin[#,"\n"] &,ReadList["errMake",String]]]];
  res=res&&False, 
  res    ];

load["Alpha/simple0.alpha"];
schedule[];
cGen[$result,$schedule,"C/simple0.c",{"N" -> 3, "M" -> 4},noPrint->True];
cFile="simple0";
testFile="simple0";
buildCML[];
If[PRun[commandLine]=!=0,
   Print["************************************"];
  Print["Probleme with test "<>testFile<>" for c file "<>cFile<>".c, \n here is the exact message: "];
  Print[Apply[StringJoin,Map[StringJoin[#,"\n"] &,ReadList["errMake",String]]]];
  res=res&&False, 
  res    ];

load["Alpha/simple1.alpha"];
schedule[];
cGen[$result,$schedule,"C/simple1.c",{"N" -> 3, "M" -> 4},noPrint->True];
cFile="simple1";
testFile="simple1";
buildCML[];
If[PRun[commandLine]=!=0,
   Print["************************************"];
  Print["Probleme with test "<>testFile<>" for c file "<>cFile<>".c, \n here is the exact message: "];
  Print[Apply[StringJoin,Map[StringJoin[#,"\n"] &,ReadList["errMake",String]]]];
  res=res&&False, 
  res    ];


If[res,
  Print["Test for CodeGen OK"],
  Print["Problems during test for CodeGen"]];

res;

(* 
res1= 
{
Print["-------------- Testing cGen --------------**"];

testFunction[SetDirectory["./testLx/"];
	     load["lx.a"];
	     cGen["lx.c",{"N"->3},interactive->True,rewrite->True,noPrint->True];
	     Run["gcc -lm lx.c -o lx"];
	     Run["gcc -lm check.c -o compare"];
	     Run["compare 2>result"];
	    ReadList["result",String],
	     {"Lx was  ok"},
	     "check Lx"]
,
testFunction[SetDirectory["../testLud/"];
	     load["lud.a"];
	     cGen["lud.c",{"N"->3},interactive->True,rewrite->True,noPrint->True];
	     Run["gcc -lm lud.c -o lud"];
	     Run["gcc -lm check.c -o compare"];
	     Run["compare 2>result"];
	      ReadList["result",String],
	     {"Lud was correct"},
	     "check Lud"]
,
testFunction[SetDirectory["../testCholesky/"];
	     load["cholesky.a"];
	     cGen["chol.c",{"N"->3},interactive->True,rewrite->True,noPrint->True];
	     Run["gcc -lm chol.c -o chol"];
	     Run["gcc -lm check.c -o compare"];
	     Run["compare 2>result"];
	     ReadList["result",String], 
	     {"Cholesky was ok"},
	     "check Cholesky"]
}
testResult = Apply[And,res1] 

$schedule=schedSav;
SetDirectory[dir];


testResult


*)

$schedule=schedSav;
SetDirectory[dir];


res
]
]
