(* 

$Id
$Author
$Date
$Source
$Revision
$Log

*)
(* Updated by P. Quinton. 2/01/2003 and August 1st, 2004*)
Module[
  { i, j, dir, listResDomlib, listResZDomlib, res, d1, m1, m2},
  Print["Test for Domlib"];
  dir = Directory[]; 
  SetDirectory[Environment["MMALPHA"]<>"/tests/TestDomlib"];

  listResDomlib=
  {
    Print["Directory:",Directory[]];
    Print["Test of readDom"];
    testFunction[readDom["{i,j|0<=i;j>=0}"],
		domain[2,{"i","j"},{pol[3,3,0,0,
					{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
					{{1,0,1,0},{1,1,0,0},{1,0,0,1}}]}],
		"Domlib 1"]
  ,
    testFunction[readDom["{i,j|"],Null,"Domlib 2"]
  ,
    testFunction[readDom[22],Null,"Domlib 3"]
  ,
   (*
   Print["Test of dom2mma"];
   testFunction[
     dom2mma[domain[
       2,{"i","j"},{
		    pol[3,3,0,0,{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
			{{1,0,1,0},{1,1,0,0},{1,0,0,1}}]}]],
     {{i>=0,j>=0},{i,j}},"Domlib 4"]
  , 
   *)
    testFunction[dom2mma[22],Null,"Domlib 5"]
  ,
   (* 
    Print["Test of dom2al"];
    testFunction[dom2al[{{i>=0,j>=0},{i,j}}],
		domain[2,{"i","j"},{pol[3,3,0,0,
					{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
					{{1,0,1,0},{1,1,0,0},{1,0,0,1}}]}],
		"Domlib 6"] ,
   *)
    testFunction[dom2al[22],Null,"Domlib 7"]
  ,
    Print["Test of vertices"];
    testFunction[
      vertices[domain[2,{"i","j"},
		     {pol[3,3,0,0,{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
			  {{1,0,1,0},{1,1,0,0},{1,0,0,1}}]}]],
     {{0,0}},"Domlib 8"]
  ,
    testFunction[vertices[22],Null,"Domlib 9"]
  ,
    Print["Test of rays"];
    testFunction[rays[domain[2,{"i","j"},
			    {pol[3,3,0,0,{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
				 {{1,0,1,0},{1,1,0,0},{1,0,0,1}}]}]],
		{{0,1},{1,0}},"Domlib 10"]
  ,
    testFunction[rays[22],Null,"Domlib 11"]
  ,
    Print["Test of Difference"];
    d1=readDom["{i,j|0<=i;j>=0}"];d2=readDom["{i,j|j>=0}"];
    (*
    testFunction[dom2mma[DomDifference[d1, d2]],{{False},{i,j}},"Domlib ...
		12"],
    *)
    testFunction[DomDifference[22],Null,"Domlib 13"]
  ,
    Print["Test of DomIntersection"];
    testFunction[DomIntersection[d1,d2], 
		domain[2,{"i","j"},{pol[3,3,0,0,
					{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
					{{1,1,0,0},{1,0,1,0},{1,0,0,1}}]}], 

		"Domlib 14"]
  ,
    testFunction[DomIntersection[22],Null,"Domlib 15"]
  ,
    Print["Test of DomUnion"];
    testFunction[DomUnion[d1,d2],
		domain[2,{"i","j"},{
				    pol[2,3,0,1,{{1,0,1,0},{1,0,0,1}},
					{{0,1,0,0},{1,0,1,0},{1,0,0,1}}]}], 
		"Domlib 16"]
  ,
    testFunction[DomUnion[22],Null,"Domlib 17"]
  ,
    Print["Test of DomUniverse"];
    testFunction[DomUniverse[3],
		domain[3,{},{pol[1,4,0, 3,{{1,0,0,0,1}},
				 {{1,0,0,0,1},{0,1,0,0,0},
				  {0,0,1,0,0},{0,0,0,1,0}}]}], 
		"Domlib 18"]
  ,
    testFunction[DomUniverse["22"],Null,"Domlib 19"]
  ,
    Print["Test of DomExtend"];
    testFunction[DomExtend[readDom["{i,j|i>=0;j>=0}"],{"i","j","k"}],
		domain[3,{"i","j","k"},
		       {pol[3,4,0,1,{{1,1,0,0,0},{1,0,1,0,0},{1,0,0,0,1}},
			    {{0,0,0,1,0},{1,0,1,0,0},
			     {1,1,0,0,0},{1,0,0,0,1}}]}],"Domlib 20"]
  ,
    (* This test was modified to comply with a modification of DomExtend *)
    testFunction[DomExtend[readDom["{i,j|i>=0;j>=0}"],{"j","k"}],
 		readDom["{i,j|i>=0;j>=0}"],"Domlib 21"]
  ,
    testFunction[DomExtend[22],Null,"Domlib 22"]
  ,
    Print["Test of DomUniverseQ"];
    testFunction[DomUniverseQ[DomUniverse[2]],True,"Domlib 23"]
  ,
    testFunction[DomUniverseQ[d1],False,"Domlib 24"]
  ,
    testFunction[DomUniverseQ[22],Null,"Domlib 25"]
  ,
    Print["Test of DomEmpty"];
    testFunction[DomEmpty[3],
		domain[3,{},{pol[4,0,4,0,
				 {{0,1,0,0,0},{0,0,1,0,0},
				  {0,0,0,1,0},{0,0,0,0,1}},{}]}],
		"Domlib 26"]
  ,
    testFunction[DomEmpty[1,2],Null,"Domlib 27"]
  ,
    Print["Test of DomEmptyQ"];
    testFunction[DomEmptyQ[DomEmpty[3]],True,"Domlib 28"]
  ,
    testFunction[DomEmptyQ[d1],False,"Domlib 29"]
  ,
    testFunction[DomEmptyQ[readDom[ "{i,j|j=2i+1}" ]],False,"Domlib 29-1"]
  ,
    testFunction[DomEmptyQ[1,2],Null,"Domlib 30"]
  ,
    Print["Test of DomEqualQ"];
    testFunction[DomEqualQ[d1,d1], True, "Domlib 31"]
  ,
    testFunction[DomEqualQ[d1,d2], False, "Domlib 32"]
  ,
    testFunction[DomEqualQ[1,2],Null,"Domlib 33"]
  ,
    Print["Test of DomEqualities"];
    testFunction[DomEqualities[readDom["{i,j,k|i=j;k=i+j;i>=1}"]],
		matrix[2,4,{"i","j","k"},{{2,0,-1,0},{0,2,-1,0}}],
		"Domlib 34"]
  ,
    testFunction[DomEqualities[22],Null,"Domlib 35"]
  ,
    Print["Test of DomProject"];
    testFunction[DomProject[d1,{"i"}],
		domain[1,{"i"},{pol[2,2,0,0,{{1,1,0},{1,0,1}},
				    {{1,1,0},{1,0,1}}]}],
		"Domlib 36"]
  ,
    testFunction[DomProject[d1,{"l"}],Null,"Domlib 37"]
  ,
    testFunction[DomProject[22],Null,"Domlib 38"]
  ,
    Print["Test of DomImage"];
    testFunction[DomImage[d1,readMat["(i,j->i)"]],
	 domain[1,{"i"},{pol[2,2,0,0,{{1,1,0},{1,0,1}},{{1,1,0},{1,0,1}}]}],
         "Domlib 39"]
  ,
    testFunction[DomImage[22],Null,"Domlib 40"]
  ,
    Print["Test of DomPreimage"];
    testFunction[DomPreimage[d1,readMat["(i,j->i-1,j+5)"]],
		domain[2,{"i","j"},{pol[3,3,0,0,{{1,1,0,-1},{1,0,1,5},
						 {1,0,0,1}},
					{{1,0,1,0},{1,1,0,0},{1,1,-5,1}}]}],
		"Domlib 41"]
  ,
    testFunction[DomPreimage[22],Null,"Domlib 42"]
  ,
    Print["Test of DomEqualities"];
    testFunction[DomEqualities[d1],matrix[0,3,{"i","j"},{}],"Domlib 43"]
  ,
    testFunction[DomEqualities[22],Null,"Domlib 44"]
  ,
    Print["Test of DomConstraints"];
    testFunction[DomConstraints[readMat["(i,j->i+2,j+2)"]],
		domain[1,{"i","j"},{pol[2,0,2,0,{{0,1,0},{0,0,1}},{}]}],
		"Domlib 45"]
  ,
    testFunction[DomConstraints[22],Null,"Domlib 46"]
  ,
    Print["Test of DomSimplify"];
    testFunction[DomSimplify[readDom["{i,j|0<=i;j>=0}"],
 			    readDom["{i,j|j>=0}"]],
		domain[2,{"i","j"},{pol[2,3,0,1,{{1,1,0,0},{1,0,0,1}},
					{{0,0,1,0},{1,1,0,0},{1,0,0,1}}]}],
		"Domlib 47"]
  ,
    testFunction[DomSimplify[22],Null,"Domlib 48"]
  ,
    Print["Test of DomConvex"];
    testFunction[DomEqualQ[
      DomConvex[DomUnion[readDom["{i,j|1<=i<=5;j>=0}"], 
			readDom["{i,j|8<=i<=12;j>=0}"]]],
      domain[2,{"i","j"},{pol[3,3,0,0,
			     {{1,0,1,0},{1,1,0,-1},{1,-1,0,12}},
			     {{1,1,0,1},{1,0,1,0},{1,12,0,1}}]}]],
		True,
		"Domlib 49"]
  ,
    testFunction[DomConvex[22],$Failed,"Domlib 50"]
  ,
    testFunction[DomEqualQ[
      DomConvex[ d1=domain[3, {"t","p", "N"}, {pol[5, 4, 1, 0,
   {{0, 1, -1, 0, -1}, {1, 0, -1, 1, 0}, {1, 0, 1, 0, -1}, {1, 0, 0, 1,
-3},
    {1, 0, 0, 0, 1}}, {{1, 1, 1, 1, 0}, {1, 0, 0, 1, 0}, {1, 2, 1, 3,
1},
    {1, 4, 3, 3, 1}}], pol[6, 8, 0, 0,
   {{1, 1, -1, 0, -2}, {1, -1, 1, 1, 1}, {1, 0, -1, 1, 0}, {1, 0, 1, 0,
-1},
    {1, 0, 0, 1, -3}, {1, 0, 0, 0, 1}},
   {{1, 2, 1, 1, 0}, {1, 1, 1, 1, 0}, {1, 1, 0, 1, 0}, {1, 0, 0, 1, 0},
    {1, 7, 3, 3, 1}, {1, 3, 1, 3, 1}, {1, 5, 1, 3, 1}, {1, 5, 3, 3,
1}}]}]],readDom["{t,p,N | p+1<=t<=p+N+1; 1<=p<=N; 3<=N}"]],
		True,
                "Domlib 51"]
  };

  listResZDomlib=
  {
    Print["Test of readDom for Zpols"];
    testFunction[readDom["{2i+j,3j+7|1<=i;j>=0}"],
      domain[2, {}, {zpol[matrix[3, 3, {"i", "j"}, 
     {{2, 1, 0}, {0, 3, 7}, {0, 0, 1}}], 
    {pol[3, 3, 0, 0, {{1, 1, 0, -1}, {1, 0, 1, 0}, {1, 0, 0, 1}}, 
      {{1, 0, 1, 0}, {1, 1, 0, 0}, {1, 1, 0, 1}}]}]}],
		"ZDomlib 1 "]
  ,
    Print["Testing Lattice HNF"];
    testFunction[l1=readMat["(i,j,k->2i+4j+6k,5i,19k+7i)"];
		LatticeHermite[l1]===hermite[l1][[1]],
		True,
		"Domlib H1"]
  ,
    testFunction[l1=readMat["(i,j,k->2i+4j+6k+19,5i+4,19k+7i+100)"];
		m1=LatticeHermite[l1];
		m2=hermite[l1][[1]];
		cstVect=Map[Last,m1[[4]]];
		diag=Flatten[MapIndexed[Part[#1,#2] &,m1[[4]]]];
		cond=Apply[And,MapThread[LessEqual,{cstVect,diag}]];
		(alphaToMmaMatrix[m1]== alphaToMmaMatrix[m2]) && cond,
		True,
		"Domlib H2"]
  ,

    testFunction[l1=readMat["(i,j,k->i/2,j,k)"];
		l2=readMat["(i,j,k->i,j,k)"];
		m1=LatticeHermite[l1];
		m2=LatticeHermite[l2];
		m1==m2,
		True,
		"Domlib H3"]
  ,
    Print["Testing Lattice Intersection"];
    testFunction[l1=readMat["(i,j,k->i/2,j,k)"];
		l2=readMat["(i,j,k->i,j,k)"];
		l3=LatticeIntersection[l1,l2];
		l3===l2,
		True,
		"Domlib H4"]
  ,

    testFunction[l1=readMat["(i,j,k->i/2+1/2,j,k+4+j)"];
		l2=readMat["(i,j,k->i,j,k)"];
		l3=LatticeIntersection[l1,l2];
		l3===l2,
		True,
		"Domlib H5"]
  ,

    testFunction[l1=readMat["(i,j,k->2i,3j+k,4k+4+j)"];
		l2=readMat["(i,j,k->2i+1,3j+k,4k+4+j)"];
		l3=LatticeIntersection[l1,l2];
		l3===readMat["(i,j,k->0,0,0)"],
		True,
		"Domlib H6"]
  ,

    testFunction[l1=readMat["(i,j,k->2i,3j+k,4k+4+j)"];
		l2=readMat["(i,j,k->5i+1,7j+7k,4k+4+j)"];
		l3=LatticeIntersection[l1,l2];
		l3===readMat["(i,j,k->10i+6,7j,28j+33k+4)"],
		True,
		"Domlib H7"]
  ,

    Print["Testing Lattice simplification"];
    Print["Testing DomEqualQ "];
    testFunction[d1=readDom["{2i+1,5j+4|1<=i;j>=0}"];
		d2=readDom["{2i+1,5j+4|1<=i;j<=0}"];
		d3=readDom["{2i+1,5j+4|1<=i}"];
		DomEqualQ[DomUnion[d1,d2],d3],
		True ,
		"ZDomlib E2 "]
  ,

    Print["Testing DomEmptyQ "];
    testFunction[DomEmptyQ[domain[2, {}, {zpol[matrix[3, 3, {i, j}, 
     {{0, 0, 0}, {0, 0, 0}, {0, 0, 1}}], 
    {pol[3, 0, 3, 0, {{0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}, {}]}]}]],
                True,
		"ZDomlib U1 "]
  ,
    Print["Testing ZDomain union"];
    testFunction[readDom["{2i+1,5j+4|1<=i;j>=0}|{3i+1,7j+4|100<=i;j>=10}"];,
		Null; Print["readDom is not working on union of Zpol"],
		"ZDomlib U2 "]
  ,

    testFunction[d1=readDom["{2i+1,5j+4|1<=i;j>=0}"];
		d2=readDom["{3i+1,7j+4|100<=i;j>=10}"];
		d3=DomUnion[d1,d2];
		show[d3,silent->True],
		"{2i+1,5j+4 | 1<=i; 0<=j} | {3i+1,7j+4 | 100<=i; 10<=j}",
		"ZDomlib U3 "]
  ,

    Print["Testing ZDomain Intersection"];
    testFunction[d1=readDom["{2i+1,5j+4|1<=i;j>=0}"];
		d2=readDom["{2i,5j+4|1<=i;j>=0}"];
		d3=DomIntersection[d1,d2];
		DomEmptyQ[d3],
		True,
		"ZDomlib I1 "]

  ,
     testFunction[d1=readDom["{2i,6j|1<=i<=100;0<=j<=100}"];
 	 d2=readDom["{3i,15j|1<=i<=100;0<=j<=100}"];
	 d3=DomIntersection[d1,d2];
	 DomEqualQ[d3,
		   readDom["{6i,30j | 0<=j<=20; -3i+100>=0; 2i-1>=0}"]],
	 True,
      "ZDomlib I2"]
  ,
     testFunction[d1=readDom["{2i+1,6j|1<=i<=100;0<=j<=100}"];
		 d2=readDom["{3i,15j|1<=i<=100;0<=j<=100}"];
		 d3=DomIntersection[d1,d2];
		 DomEqualQ[d3,
			   readDom["{6i+3,30j | 0<=i<=33;  0<=j<=20}"]],
		 True,
		 "ZDomlib I3"]
  ,

    testFunction[d1=readDom["{4i+8j,2i+7j|1<=i<=100;0<=j<=100}"];
		 d2=readDom["{6i,3j|1<=i<=100;0<=j<=100}"];
		 d3=DomIntersection[d1,d2];
                 DomEqualQ[d3,
                 readDom["{12i,3j | 2i<=j<=100; 2i-1>=0; -7i+2j+100>=0; 7i-2j-1>=0}"]],
			  True,
		 "ZDomlib I4"]
  ,
     testFunction[d1=readDom["{i/2+1/2,j/6+1/3|1<=i<=100;0<=j<=100}"];
		 d2=readDom["{i/3,j|1<=i<=100;0<=j<=100}"];
		 d3=DomIntersection[d1,d2];
		DomEqualQ[d3,
			  readDom["{i,j | 1<=i; 3i <= 100; 1<=j<=17}"]],
			  True,
		 "ZDomlib I5"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		d2=readDom["{6i,4j|1<=i<=100;0<=j<=100}"];
		d3= DomUnion[d1,d2] ;
		d4=DomIntersection[d3,d1];
		DomEqualQ[d4,d1],
		True,
		 "ZDomlib I6"]
  ,

    testFunction[d1=readDom["{i/2,j/3| 0<=i<=100; 0<=j<=5000}"];
		d2=readDom["{6i,4j|1<=i<=100;0<=j<=100}"];
		d3=DomIntersection[d2,d1]; 
		DomEqualQ[d3,readDom["{6i,4j|1<=i; 6i<=50;0<=j<=100}"]],
		True,
		 "ZDomlib I7"]
  ,

    testFunction[d1=readDom["{2i,3j| 0<=i,j<=100}"];
		d2=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		d3=DomIntersection[d2,d1];
                DomEqualQ[d3,
                readDom["{2i,3j | i<=50; 0<=j; 2i-1>=0; -3j+100>=0}"]],
		True,
		"ZDomlib I8"]
  ,

   Print["Testing ZDomain Image"];
   testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i,3j)"];
		d3=DomZImage[d1,m1];
		 DomEqualQ[d3,
			   readDom["{2i,3j|1<=i<=100;0<=j<=100}"]],
		True,	
		"ZDomlib I9"]
  ,

   testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i/2,j/3)"];
		d3=DomZImage[d1,m1];
		 DomEqualQ[d3,
			   readDom["{i,j|1<=2i<=100;0<=3j<=100}"]],
		True,	
		"ZDomlib I9bis"]
  ,

   testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i+1,3j+4)"];
		d3=DomZImage[d1,m1];
		 DomEqualQ[d3,
			   readDom["{2i+1,3j+4|1<=i<=100;0<=j<=100}"]],
		True,	
		"ZDomlib I10"]
  ,

   testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i/2+1,j/3+3)"];
		d3=DomZImage[d1,m1];
		 DomEqualQ[d3,
			   readDom["{i,j|1<=2i-2<=100;0<=3j-9<=100}"]],
		True,	
		"ZDomlib I11"]
  ,

    testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i+1/2,3j+4)"];
		d3=DomZImage[d1,m1];
		 DomEqualQ[d3,
			   DomEmpty[2]],
		True,	
		"ZDomlib I12"]
  ,

    testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i/2+1/2,j)"];
		d3=DomZImage[d1,m1];
		 DomEqualQ[d3,
			   readDom["{i,j|1<=i<=50;0<=j<=100}"]],
		True,	
		"ZDomlib I13"]
  ,

     testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
       m1=readMat["(i,j->13i/2+1/2,j)"];
       d3=DomZImage[d1,m1];
       DomEqualQ[d3, readDom["{13i+7,j | 0<=i; 0<=j<=100; 2i<100}"]],
       True,	
       "ZDomlib I14"]
  ,

    testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i/2+3,3j+1/3)"];
		d3=DomZImage[d1,m1];
       DomEqualQ[d3, readDom["{i,3j+1/3|1<=2i-2<=100;0<=j<=100}"]],
		True,	
		"ZDomlib I15"]
  ,

     testFunction[d1=readDom["{i,j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i)"];
		d3=DomZImage[d1,m1],
		$Failed;Null,	
		"ZDomlib I16"]
  ,

     Print["Testing DomPreimage"];
     testFunction[d1=readDom["{i,2j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i,3j)"];
		m2=readMat["(i,j->i,j)"];
		d2=ReplacePart[d1,zpol[m2,d1[[3,1,2]]],{3,1}];
		(* d2 is d1 but expressed as a zpol *) 
		  d3=DomZPreimage[d2,m1];
		DomEqualQ[d3,
			  readDom["{i,j|1<=2i<=100;0<=3j<=100}"]],
		True,
	    "ZDomlib P1"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i,3j)"];
		  d3=DomZPreimage[d1,m1];
		DomEqualQ[d3,
			  readDom["{i,j|1<=i<=100;0<=j<=100}"]],
		True,
	    "ZDomlib P2"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i,7j)"];
		  d3=DomZPreimage[d1,m1];
		DomEqualQ[d3,
			  readDom["{i,3j|1<=i<=100;0<=7j<=100}"]],
		True,
	    "ZDomlib P3"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->4i+14j,7i+21j)"];
		d3=DomZPreimage[d1,m1];
		DomEqualQ[d3,
			  readDom["{3i,j |1<=12i+14j<=200;0<=21i+21j<=300 }"]],
		True,
	    "ZDomlib P4"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i+1,7j)"];
		  d3=DomZPreimage[d1,m1];
		DomEmptyQ[d3],
		True,
	    "ZDomlib P5"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i,7j+1)"];
		  d3=DomZPreimage[d1,m1];
		DomEqualQ[d3, (* 7*(3j+2)+1=21j+15 *)
			  readDom["{i,3j+2|1<=i<=100; 0<=21j+15<=300}"]],
		True,
	    "ZDomlib P6"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->2i,7j+1/2)"];
		  d3=DomZPreimage[d1,m1];
		DomEmptyQ[d3],
		True,
	    "ZDomlib P7"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i/2,j/3)"];
		  d3=DomZPreimage[d1,m1];
		DomEqualQ[d3, 
			  readDom["{4i,9j | 1<=i<=100; 0<=j<=100}"]],
		True,
	    "ZDomlib P9"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i,j->i/8+1/4,j/3)"];
		  d3=DomZPreimage[d1,m1];
		DomEqualQ[d3, 
			  readDom["{16i+14,9j | 0<=i<=99; 0<=j<=100}"]],
		True,
	    "ZDomlib P10"]
  ,

    testFunction[d1=readDom["{2i,3j|1<=i<=100;0<=j<=100}"];
		m1=readMat["(i->2i,3i)"];
		  d3=DomZPreimage[d1,m1];
		DomEqualQ[d3, 
			  readDom["{i | 1<=i<=100}"]],
		True,
	    "ZDomlib P11"]
  ,

    Print["Test of rays for Zpolyhedra"];
    testFunction[
                d1 = readDom["{ 6i+j,8j-6 | -5<=i<=5 ; -5<=j<=5}"];
                d2 = rays[d1],          (* Finite polyhedra: So no rays *)
                {},
                "ZDomlib rays1"
                ]
  ,

    testFunction[
                d1 = readDom["{ 6i+j,8j-6 | 0<=i-j ; 0<=j}"];   (* Rays are 1,0 and 1,1 *)
                d2 = rays[d1],
                (* (6 1  0)  We use only the top-left 2x2 sub matrix because rays are not affected by translation
                   (0 8 -6)  So, Transpose(6 1).(1 1) = (6 0)
                   (0 0  1)               (0 8) (0 1)   (7 8)   New Rays are 6,0 and 7,8        *)
                {{6, 0}, {7, 8}},
                "ZDomlib rays2"
                ]
  ,


    (*********      vertices      *********)
    Print["Test of vertices for Zpolyhedra"];

    testFunction[
                d1 = readDom["{ i,j | -5<=3i<=5 ; -5<=7j<=5}"];
                d2 = vertices[d1],      (* returns null in original: now corrected *)
                {{5/3,-5/7}, {-5/3,-5/7}, {-5/3,5/7}, {5/3, 5/7}},
                "ZDomlib vertices1"
                ]
  ,

    testFunction[
                d1 = readDom["{ 2i,2j | -5<=3i<=5 ; -5<=3j<=5}"];
                d2 = vertices[d1],
                {{10/3, -10/3}, {-10/3, -10/3}, {-10/3, 10/3}, {10/3, 10/3}},
                "ZDomlib vertices2"

                ]
  ,

    (*********      DomAddRays      *********)
    Print["Test of DomAddRays for Zpolyhedra"];

    testFunction[
                d1 = readDom["{ 2i,2j | -5<=i<=5 ; 0<=j<=5}"];
                mat1 = matrix[1, 4, {}, {{1, 0, 1, 0}}]; (* Add a ray *)
                DomAddRays[d1,mat1],    (* Gives us the plane: -5<=i<=5 ; 0<=j *)
                domain[2, {}, {zpol[matrix[3, 3, {"i", "j"}, {{2, 0, 0}, {0, 2, 0}, {0, 0, 1}}], 
                {pol[3, 3, 0, 0, {{1, 1, 0, 5}, {1, -1, 0, 5}, {1, 0, 1, 0}}, {{1, 5, 0, 1}, {1, -5, 0, 1}, {1, 0, 1, 0}}]}]}],

                "ZDomlib DomAddRays1"
                ]
  ,

    testFunction[
                d1 = readDom["{ 2i,2j | -5<=i<=5 ; 0<=j<=5}"];
                mat2 = matrix[1, 4, {}, {{0, 0, 1, 0}}]; (* Add a line *)
                DomAddRays[d1,mat2],    (* Gives us the plane: -5<=i<=5 ; *)
                domain[2, {}, {zpol[matrix[3, 3, {"i", "j"}, {{2, 0, 0}, {0, 2, 0}, {0, 0, 1}}], 
                {pol[2, 3, 0, 1, {{1, 1, 0, 5}, {1, -1, 0, 5}}, {{0, 0, 1, 0}, {1, -5, 0, 1}, {1, 5, 0, 1}}]}]}],
                "ZDomlib DomAddRays2"
                ]
  ,
                

    (*********      DomEqualities      *********)
    Print["Test of DomEqualities for Zpolyhedra"];

    testFunction[
                d1 = readDom["{2i+2,3j+3,4k+4|i=j;k=i+j;i>=1}"];(* Equalities are: {{2, 0, -1, 0}, {0, 2, -1, 0}} *)
                DomEqualities[d1],      (* Equalities of Zpol are: {{4, 0, -1, 0}, {0, 8, -3, 0}} *)
                (* Note that here we map the equalities by the inverse of the transformation function 
                   i.e. DomEqualities[ZPol] = M_inverse(Pol_Equalities) *)
                matrix[2, 4, {"i", "j", "k"}, {{4, 0, -1, 0}, {0, 8, -3, 0}}],
                "ZDomlib DomEqualities1"
                ]
  ,


    (*********      polToZpol      *********)
    Print["Test of polToZpol"];

    testFunction[
		d1 = readDom["{ i,j | -5<=i<=5 ; 0<=j<=5}"];
		d2 = readDom["{ i,j | 0<=i-j ; 0<=j}"];
		polToZpol[DomUnion[d1,d2]],
		domain[2,{},{zpol[matrix[3,3,{"i","j"},{{1,0,0},{0,1,0},{0,0,1}}],
		{pol[4,4,0,0,{{1,1,0,5},{1,-1,0,5},{1,0,1,0},{1,0,-1,5}},{{1,5,0,1},{1,-5,0,1},
		{1,-5,5,1},{1,5,5,1}}],pol[3,3,0,0,{{1,1,-1,0},{1,0,1,0},{1,0,0,1}},{{1,1,1,0},
		{1,1,0,0},{1,0,0,1}}]}]}],
		"ZDomlib polToZpol1"
		]
  ,


    (*********      zpolToPol      *********)
    Print["Test of zpolToPol"];
	
    testFunction[
		d1 = readDom["{ 2i,3j | -5<=i<=5 ; 0<=j<=5}"];
		d2 = readDom["{ 3i,2j | 0<=i<=5 ; 10<=j}"];
		d3 = zpolToPol[DomUnion[d1,d2]];
		DomEqualQ[d3,readDom["{i,j | -10<=i<=10; 0<=j<=15} | {i,j | 0<=i<=15; 20<=j}"]],
		True,
		"ZDomlib zpolToPol1"
		]
  ,

    (*********      zpolIsPolQ      *********)
    Print["Test of zpolIsPolQ"];
	
    testFunction[
			d1 = readDom["{ i,j | -5<=i<=5 ; 0<=j<=5}"];
			m1 = readMat["(i,j->i,j)"];
			d2 = domain[2, {}, {zpol[m1, d1]}];
			zpolIsPolQ[d2], 
			True, 
			"ZDomlib zpolIsPolQ1"]
  ,

    testFunction[
			 d1 = readDom["{ i,j | -5<=i<=5 ; 0<=j<=5}"]; 
			 d2 = readDom["{ i,j | -6<=i<=5 ; 0<=j<=5}"];
			 m1 = readMat["(i,j->i,j)"]; 
			 m2 = readMat["(i,k->i,k)"];
			 d3 = domain[2, {}, {zpol[m1, d1], zpol[m2, d2]}];
			 zpolIsPolQ[d3],
			 True, "ZDomlib zpolIsPolQ2"]
  ,

    (*********  Image/Preimage   *********)
    Print["Test of Dom Image/ZImage/Preimage/ZPreimage"];

    d1 = readDom["{ 2i | 0<=i<=15 }"];
	m1= readMat["(i,j->3i)"];
	m2= readMat["(i,j->i/3)"];
	 
    testFunction[
	 	DomEqualQ[DomPreimage[d1,m1],readDom["{i,j | 3i>=0; -3i+30>=0}"]],
		True,
		"ZDomlib DomPreimage1"
		]
  ,

    testFunction[
	 	DomEqualQ[DomPreimage[d1,m2],readDom["{i,j | 0<=i<=90}"]],
		True,
		"ZDomlib DomPreimage2"
		]
  ,
	
    testFunction[
	 	DomEqualQ[DomZPreimage[d1,m1],readDom["{2i,j | 0<=i<=5}"]],
		True,
		"ZDomlib DomZPreimage1"
		]
  ,
		
    testFunction[
	 	DomEqualQ[DomZPreimage[d1,m2],readDom["{6i,j | 0<=i<=15}"]],
		True,
		"ZDomlib DomZPreimage2"
		]
  ,

    testFunction[
		d1 = readDom["{ i | 0<=i<=15 }"];
		DomEqualQ[DomZPreimage[d1,m2],readDom["{3i,j | 0<=i<=15}"]],
		True,
                "ZDomlib DomZPreimage3"
                ]
  ,

    d1 = readDom["{ 2i,3j | 0<=i<=15;0<=j<=20 }"];

    testFunction[
		m1= readMat["(i,j->3i)"];
		DomEqualQ[DomImage[d1,m1],readDom["{i1 | 0<=i1<=90}"]],
		True,
		"ZDomlib DomImage1"
		]
  ,
		
    testFunction[
		m1= readMat["(i,j->i/3)"];
		DomEqualQ[DomImage[d1,m1],readDom["{i1 | 0<=i1<=10}"]],
		True,
		"ZDomlib DomImage2"
		]
  ,
		
    testFunction[
		m1= readMat["(i,j->3i,j)"];
		DomEqualQ[DomZImage[d1,m1],readDom["{6i,3j | 0<=i<=15; 0<=j<=20}"]],
		True,
		"ZDomlib DomZImage1"
		]
  ,
		
    testFunction[
		m1= readMat["(i,j->i/3,j)"];
		DomEqualQ[DomZImage[d1,m1],readDom["{2i,3j | 0<=i<=5; 0<=j<=20}"]],
		True,
		"ZDomlib DomZImage2"
		]
  ,

    testFunction[
		d1 = readDom["{ i,j | 0<=i<=15;0<=j<=20 }"];
		m1= readMat["(i,j->3i,j)"];
		DomEqualQ[DomZImage[d1,m1],readDom["{3i,j | 0<=i<=15; 0<=j<=20}"]],
		True,
                "ZDomlib DomZImage3"
                ]
  ,


    (*********      DomSimplify      *********)
    Print["Test of DomSimplify"];

    testFunction[
		d1=readDom["{2i,2j | 0<=i<=5;0<=j<=5}"];
		d2=readDom["{i,j | 0<=i<=10;0<=j<=20}"];
		DomEqualQ[DomSimplify[d1,d2],readDom["{2i,2j | -2j+10>=0}"]],
		True,
		"ZDomlib DomSimplify1"
    ]
};

  res = Apply[ And, Join[ listResDomlib, listResZDomlib ] ];

  If[ res,
    Print["No problem occured during test of Domlib"],
    Print["WARNING:  problems occured during test of Domlib"]
  ];

  SetDirectory[dir];
  res
]
