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
    Print["Test of DomIntersection"];
    d1=readDom["{i,j|0<=i;j>=0}"];d2=readDom["{i,j|j>=0}"];
    testFunction[DomIntersection[d1,d2], 
		domain[2,{"i","j"},{pol[3,3,0,0,
					{{1,1,0,0},{1,0,1,0},{1,0,0,1}},
					{{1,1,0,0},{1,0,1,0},{1,0,0,1}}]}], 

		"Domlib 14"]
  };

  res = Apply[ And, Join[ listResDomlib, listResZDomlib ] ];

  If[ res,
    Print["No problem occured during test of Domlib"],
    Print["WARNING:  problems occured during test of Domlib"]
  ];

  SetDirectory[dir];
  res
]
