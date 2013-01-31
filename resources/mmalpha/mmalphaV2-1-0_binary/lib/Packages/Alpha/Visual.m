(* 
   file: $MMALPHA/lib/Package/Visual.m
   AUTHOR : D. Wilde, T. Risset
   CONTACT : http://www.irisa.fr/api/ALPHA
   COPYRIGHT  (C) INRIA
   
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   (see file : $MMALPHA/LICENSING).

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library(see file : $MMALPHA/LICENSING);
   if not, write to the Free Software Foundation, Inc., 59 Temple
   Place - Suite 330, Boston, MA  02111-1307, USA.   
*)

BeginPackage["Alpha`Visual`",{"Alpha`Domlib`",
			      "Alpha`",
			      "Alpha`Static`"}]

(* 

  The source of this file is  $MMALPHA/lib/Packages/Alpha/Visual.m

  Standard head file for CVS

	$Author: trisset $
	$Date: 2005/03/11 16:40:17 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/Visual.m,v $
	$Revision: 1.1 $
	$Log: Visual.m,v $
	Revision 1.1  2005/03/11 16:40:17  trisset
	added all remaining packages to V2
	
	Revision 1.18  2004/09/16 13:40:13  quinton
	Updated documentation
	
	Revision 1.17  2004/08/02 13:21:02  quinton
	Documentation updated for reference manual
	
	Revision 1.16  2004/01/09 17:18:52  quinton
	Trying to commit my version, after removing conflicts... Not sure it will work.
	
	Revision 1.15  2003/12/12 13:17:02  risset
	 minor modif
	
	Revision 1.14  2003/07/18 12:52:43  risset
	Undo Abhishek changes because it was failing on Windows
	
	Revision 1.12  2001/04/21 07:21:02  quinton
	Minor corrections
	
	Revision 1.11  1999/12/10 16:59:06  risset
	commited struct Sched and ZDomlib
	
	Revision 1.10  1999/05/10 15:21:00  risset
	supressed the Decomposition Package, put it in Cut
	
	Revision 1.9  1999/03/02 15:49:31  risset
	added GNU software text in each packages
	
	Revision 1.8  1997/05/19 10:41:53  risset
	corrected exported bug in depedancies

	Revision 1.7  1997/04/10 09:20:03  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.6  1996/06/25 16:38:20  risset
	commit before others remarks on reference Package

	Revision 1.5  1996/06/24 13:55:14  risset
	added standard head comments for CVS

	Revision 1.4  1996/06/24 13:43:12  risset
	corrected

*)

Visual::note = "Documentation revised on August 10, 2004";

Visual::usage = 
"The Alpha`Visual` packages contains a few functions to visualize 1D
or 2D domains. The main function is showDomain. Function getBoundingBox
is also used in some other packages, as well as function bbDomain, 
which is poorly written.";

bbDomain::usage =
"bbDomain[d] returns a list representing the bounding box of domain
d. This has the form {{xmin,xmax},{ymin,ymax},{xneg,xpos},
{yneg,ypos}} where {xmin,xmax},{ymin,ymax} is the bounding box of the
vertices, {xneg,xpos}, {yneg,ypos} indicate that the domain is
infinite in one of these directions. If xneg and xpos are 0, no
rays. If xneg is 1, negative ray, if yneg is 1, positive ray. 
Same for yneg and ypos";

(*
bbPolList::usage = ""; (* To allow this function to be tested *)
*)

getBoundingBox::usage=
"getBoundingBox[dom] gives the bounds of the smallest rectangle
containing dom. This function is temporary, in particular it
does not handle domains that are union of polyhedra (in fact it work
only on convex polyhedra. It should be reimplemented using DomProject)."

showDomain::usage =
"showDomain[d] displays a plot of any 1D or 2D domain or any list of
1D or 2D domains. showDomain[d, name] displays d with the title
name specified.";

Begin["`Private`"]

(* 
  Note: A frame is the structure indicating in which direction the
  polyhedron is infinite. (I guess that a frame is the second part 
  of the result)
*)


(* bbDomains find the bounding box of a Domain or a list of domains.
  The result is a list of four pairs: 
   {{xmin,xmax},{ymin,ymax},{xneg,xpos},{yneg,ypos}}
   where xneg,pos,yneg,ypos indicate wheter the domain is unbounded
   in this direction  *)

Clear[bbDomain];
bbDomain[domain[dim_,_,p_ ]] :=
Catch[
  If[dim>2, 
    bbDomain::dim = "The dimension of domain should be 1 or 2";
    Throw[ Message[ bbDomain::dim ] ]
  ];

  (* Now call the function bbPolList on p *)
  bbPolList[dim, p, {{},{},{0,0},{0,0}}]
];
bbDomain[d:_List] := bbDomList[d];
bbDomain::wrongP="wrong Parameter for bbDomain: `1` should be a domain";
bbDomain[a___]:= Message[bbDomain::wrongP,a];

(* 
  Parses down a list of polyhedra, combines all of their points into
  one great list. 
  First argument is the dimension, second argument is a list of 
  polyhedra, third is the result.
*)
Clear[bbPolList];
(* 
  dim is the dimension of the domain
  Does not check that dimension of polyhedra are corrects...
*)
(* Recursive call *)
bbPolList[
  dim:_Integer, 
  {pol[_,_,_,_,_,pt1_],pt2___}, 
  res:{_List,_List,{_Integer,_Integer},{_Integer,_Integer}}
] :=
  bbPolList[dim, {pt2}, bbPtList[dim, pt1, res] ];
(* Empty list *)
bbPolList[_Integer, {}, 
  res:{_List,_List,{_Integer,_Integer},{_Integer,_Integer}}
] := res;
bbPolList::wrongP = "wrong Parameter for bbPolList: `1`"
bbPolList[a___]:= Message[bbPolList::wrongP,a];


(* 
  bbPtList translates the list of Vertex/Ray/Lines of a polyhedron 
  into a bounding box 
*)

Clear[bbPtList];

(* For one dimensional domains, and empty point list *)
bbPtList[ 1, {}, res_] := res;
  
(* 
  First result, point is ray (d==0) or vertex (d!=0) 
*)
bbPtList[ 1, {{1, x_, d_}, pts___}, {{},{}, fx_, fy_}] :=
  If[d == 0, 
     bbPtList[ 1, {pts}, {{},{}, bbFrame[x,fx], fy}],
     bbPtList[ 1, {pts}, {{x/d, x/d}, {0, 0}, fx, fy}] 
  ];

(* line *)
bbPtList[ 1, {{0, x_, d_}, pts___}, {{xi_,xa_}, {yi_, ya_}, fx_, fy_}] :=
  bbPtList[ 1, {pts}, {{xi,xa}, {yi, ya}, bbFrame[-x,bbFrame[x,fx]], fy}]

(* ray (d==0) or vertex (d!=0) *)
bbPtList[ 1, {{1, x_, d_}, pts___}, {{xi_,xa_}, {yi_, ya_}, fx_, fy_}] :=
  If[d == 0,
     bbPtList[ 1, {pts}, {{xi,xa}, {yi, ya}, bbFrame[x,fx], fy}],
     {{If[x/d<xi, x/d, xi], If[x/d>xa, x/d, xa]}, {yi, ya}, fx, fy}
  ];

(* for two dimensional domains *)
(* compute the min and max (x,y) in a two dimensional domain *)
(* empty point list *)
bbPtList[ 2, {}, res_] := res;
  
(* first result *)
bbPtList[ 2, {{s_, x_, y_, d_}, pts___}, {{},{}, fx_, fy_}] :=
  If[s==1,
     If[d == 0,
        (* ray *)
	  bbPtList[ 2, {pts}, {{},{}, bbFrame[x, fx], bbFrame[y, fy]}],
        (* point *)
	    bbPtList[ 2, {pts}, {{x/d, x/d},{y/d, y/d},fx,fy}]
      ],
     (* line *)
       bbPtList[ 2, {pts}, {{},{}, bbFrame[-x,bbFrame[x,fx]],
			    bbFrame[-y,bbFrame[y,fx]]}]
   ];

bbPtList[ 2, {{s_, x_, y_, d_}, pts___}, {{x1_,x2_},{y1_, y2_},fx_,fy_}] :=
  If[s==1,
    If[d == 0,
      (* ray *)
      bbPtList[ 2, {pts}, {{x1,x2}, {y1, y2}, bbFrame[x, fx], bbFrame[y, fy]}],
      (* point *)
      bbPtList[ 2, {pts}, 
        {{If[x/d < x1,x/d,x1], If[x/d > x2,x/d,x2]},
	 {If[y/d < y1,y/d,y1], If[y/d > y2,y/d,y2]},fx,fy}
      ]
    ],
    (* line *)
      bbPtList[ 2, {pts}, {{x1,x2}, {y1, y2}, bbFrame[-x,bbFrame[x,fx]],
			    bbFrame[-y,bbFrame[y,fx]]}]
  ];

 bbPtList::wrongP="wrong Parameter for bbPtList: `1`"
 bbPtList[a___]:= Message[bbPtList::wrongP,a];

(* Adds a ray x to frame {x1,x2} *)
(* 
  Obviously, x should be an integer???
*)
Clear[bbFrame];
bbFrame[x:_Integer, {x1:_Integer, x2:_Integer}] :=
  If[x<0, {1, x2},
     If[x>0, {x1, 1}, {x1, x2}]
  ];
bbFrame::wrongP = "wrong Parameter for bbFrame: `1`"
bbFrame[a___] := Message[bbFrame::wrongP,a];

(* Combines the bounding boxes of a list of domains *)
Clear[bbDomList];
bbDomList[{d_, ds___}] := bbCombine[bbDomain[d], bbDomList[{ds}]]
bbDomList[{}] := {}
bbDomList::wrongP="wrong Parameter for bbDomList: `1`"
bbDomList[a___]:= Message[bbDomList::wrongP,a];

(* Combines extremal vertices of two bounding boxes *)

Clear[bbCombine1];
bbCombine1[{z1_,z2_}, {z3_,z4_}] := { Min[z1,z3], Max[z2,z4] }
  bbCombine1[{z1_,z2_}, {}] := {z1,z2}
  bbCombine1[{},{z1_,z2_}] := {z1,z2}
  bbCombine1[{},{}] := {}
bbCombine1::wrongP="wrong Parameter for bbCombine1: `1`"
bbCombine1[a___]:= Message[bbCombine1::wrongP,a];

(* Combines infinite directions of two bounding boxes *)

Clear[bbCombine2];
bbCombine2[{z1_,z2_}, {z3_,z4_}] := { Max[z1,z3], Max[z2,z4] }
bbCombine2[{z1_,z2_}, {}] := {z1,z2}
bbCombine2[{},{z1_,z2_}] := {z1,z2}
bbCombine2[{},{}] := {}
bbCombine2::wrongP="wrong Parameter for bbCombine2: `1`"
bbCombine2[a___]:= Message[bbCombine2::wrongP,a];

(* Combines the bounding boxes of a list of domains *)

Clear[bbCombine];
bbCombine[{x1_,y1_,x2_,y2_},{x3_,y3_,x4_,y4_}] :=
  { bbCombine1[x1,x3], bbCombine1[y1,y3],
   bbCombine2[x2,x4], bbCombine2[y2,y4] }
bbCombine[{x1_,y1_,x2_,y2_},{}] := {x1,y1,x2,y2}
bbCombine[{},{x1_,y1_,x2_,y2_}] := {x1,y1,x2,y2}
bbCombine[{},{}] := {}
  
bbCombine::wrongP = "wrong Parameter for bbCombine: `1`"
bbCombine[a___] := Message[bbCombine::wrongP,a];

(*
  showDomain 
*)
(* bbAdjust: adjust bounding box by adding a frame -- relative 
   lots of good heuristics built in. 
   n is relative frame in direction of rays only,
   m is relative frame in all directions  *)

Clear[bbAdjust];
bbAdjust[{{x1_,x2_},{y1_,y2_},{x3_,x4_},{y3_,y4_}},n_,m_] :=
  Module[{xn,yn,xm,ym},
    xn = Ceiling[(x2-x1+.5)*n];
    yn = Ceiling[(y2-y1+.5)*n];
    xm = Ceiling[(x2-x1+.5)*m];
    ym = Ceiling[(y2-y1+.5)*m];
    {{Floor[x1]-xn*x3-xm,Ceiling[x2]+xn*x4+xm},
     {Floor[y1]-yn*y3-ym,Ceiling[y2]+yn*y4+ym}}
  ];
bbAdjust[{{},{},_,_},_,_] := {{0,1},{0,1}}
bbAdjust::wrongP="wrong Parameter for bbAdjust: `1`"
bbAdjust[a___]:= Message[bbAdjust::wrongP,a];

(* *)
Clear[setOrigin];
(* For an empty domain *)
setOrigin[{{},{},{0,0},{0,0}}] := {0.,0.};
setOrigin[{{x_,_},{y_,_},{_,_},{_,_}}] :=
Module[ {originX,originY},
  originX = x*1.0;
  originY = y*1.0;
  {originX,originY}
];
setOrigin::wrongP="wrong Parameter for setOrigin: `1`";
setOrigin[a___]:= Message[setOrigin::wrongP,a];

(* Absolute and relative arrow sizing functions *)
Clear[arrowSize];
arrowSize[s_, {{x1_,x2_},{y1_,y2_}}] := 
 (
   $arrowdx = (x2-x1);
   $arrowdy = (y2-y1);
   $arrow = {{0,s},{0,-s},{3*s,0}}
 );
arrowSize::wrongP="wrong Parameter for arrowSize: `1`";
arrowSize[a___]:= Message[arrowSize::wrongP,a];

(* 
  Builds an arrow at (x1, y1) pointing in direction (x2, y2) 
*)
Clear[arrow];
arrow[ {x1_, y1_} ,{x2_, y2_} ] := 
  Module[{sn, cs, tmp},
    tmp = N[Sqrt[x2*x2+y2*y2]];
    sn = y2/tmp;
    cn = x2/tmp;
    Polygon[{{x1,y1},{x1,y1},{x1,y1}} +
      $arrow.{{cn*$arrowdx,sn*$arrowdy},{-sn*$arrowdx,cn*$arrowdy}}
    ]
  ];
arrow::wrongP="wrong Parameter for arrow: `1`";
arrow[a___]:= Message[arrow::wrongP,a];

(* 
  Draws a circle of n evenly spaced vectors to test arrows 
*)
Clear[testArrows]
testArrows[n_,s_] := 
  Module[{a,b,x,y,g,t},
    g={};
    b = {{-s-1,s+1},{-s-1,s+1}};
    arrowSize[.025,b];
    t=2*3.1416/n;
    For[ a=0.0, a<2*3.1416, a=a+t,
      x = s*Cos[a];
      y = s*Sin[a];
      g = Append[g, Line[{{0,0},{x,y}}] ];
      g = Append[g, arrow[{x,y},{x,y}] ]
    ];

    Show[Graphics[g, PlotRange -> b,
      AspectRatio -> 1.0,
      Axes -> True,
      PlotLabel -> "Domain Plot\n-----------",
      PlotRegion -> Automatic,
      GridLines -> None ]
    ]
  ];
testArrows::wrongP="wrong Parameter for testArrows: `1`";
testArrows[a___]:= Message[testArrows::wrongP,a];

(*
  Ray end
*)
Clear[rayEnd];
rayEnd[{{xmin_, xmax_}, {ymin_, ymax_}},x1_,y1_,d_,x2_,y2_] := 
  Module[{k},
    k = Min[ 
      If[x2==0, Infinity, Max[(xmin-(x1/d))/x2, (xmax-(x1/d))/x2] ],
      If[y2==0, Infinity, Max[(ymin-(y1/d))/y2, (ymax-(y1/d))/y2] ] 
    ];
    {(x1/d)+(k*x2), (y1/d)+(k*y2)}
  ];
rayEnd::wrongP="wrong Parameter for rayEnd: `1`";
rayEnd[a___]:= Message[rayEnd::wrongP,a];

(* one dimensional lines *)
(* change one dimensional into two dimensional *)
Clear[line2graph];
line2graph[1, bb_,{{s1_,x1_,d1_},{s2_,x2_,d2_}},origin_List] :=
  line2graph[2,bb,{{s1,x1,0,d1},{s1,x2,0,d2}},origin];

(* two dimensional lines *)
line2graph[2,bb_,{{1,x1_,y1_,d1_},{1,x2_,y2_,d2_}},origin_List] := 
  Module[{p},
    If[d1==0,
      If[d2==0,
        (* ray - ray *) {},
        (* ray - point *) p = rayEnd[bb,x2,y2,d2,x1,y1];
        { Line[{{x2/d2,y2/d2}, p}], arrow[p, {x1,y1}] }
      ],
      If[d2==0,
        (* point - ray *) p = rayEnd[bb,x1,y1,d1,x2,y2];
        { Line[{{x1/d1,y1/d1}, p}], arrow[p, {x2,y2}] },
        (* point - point *)
        { Line[{{x1/d1,y1/d1}, {x2/d2,y2/d2}}] }
      ]
    ]
  ];

(* point - line *)
line2graph[2,bb_,{{1,x1_,y1_,d1_},{0,x2_,y2_,_}},origin_List] :=
  Module[{p1,p2,originX,originY},
    If[d1==0, 
      (* ray - line == replace line with origin *)
      originX=origin[[1]];
      originY=origin[[2]];
      p1 = rayEnd[bb,originX, originY, 1,x1,y1];
      {Dashing[{.02}],Line[{p1,{originX, originY}}],
      Dashing[{}], arrow[p1,{x1,y1}]}
    ,
      p1 = rayEnd[bb,x1,y1,d1,x2,y2];
      p2 = rayEnd[bb,x1,y1,d1,-x2,-y2];
      { Line[{p1, p2}], arrow[p1,{x2,y2}], arrow[p2,{-x2,-y2}] }
    ]
  ];

(* line - point *)
line2graph[2,bb_,{{0,x1_,y1_,_},{1,x2_,y2_,d2_}},origin_List] :=
  Module[ {p1,p2,originX,originY},
    If[d2==0,
      (* ray - line == replace line with origin *)
      originX=origin[[1]];
      originY=origin[[2]];
      p1 = rayEnd[bb,originX,originY, 1,x2,y2];
       {Dashing[{.02}],Line[{p1,{originX, originY}}],
       Dashing[{}], arrow[p1,{x2,y2}]}
      ,
      p1 = rayEnd[bb,x2,y2,d2,x1,y1];
      p2 = rayEnd[bb,x2,y2,d2,-x1,-y1];
      { Line[{p1, p2}], arrow[p1,{x1,y1}], arrow[p2,{-x1,-y1}] }
    ]
  ];
line2graph::wrongP="wrong Parameter for line2graph: `1`"
line2graph[a___]:= Message[line2graph::wrongP,a];

(*
  Polyhedron to graph
*)
Clear[pol2graph];
pol2graph[1, bb_, pol[elen_ ,rlen_ ,_ ,_ ,elist_ ,rlist_],origin_List] :=
Module[{v, g, r},
  g = {PointSize[.025], Thickness[.0075]};
  v = {};
  Do [
    r = Part[rlist, j];
    v = Append[v, r];
    g = Join[g,
     If[ And[First[r]==1, Last[r]=!=0],
       {Point[ Append[Drop[Drop[r,1],-1]/Last[r],0] ]},
       {}
     ]],
     {j, rlen}
  ];
  g = Join[g, If [ Length[v]==2, line2graph[1,bb,v,origin], {} ] 
         ];
  g
];

pol2graph[2, bb_, pol[elen_ ,rlen_ ,_ ,_ ,elist_ ,rlist_],origin_List] :=
Module[{v, g, e, r},
  g = {PointSize[.025], Thickness[.0075]};
  Do[ (* put out lines *)
    e = Drop[Part[elist, i],1];
    v = {};
    Do [
      r = Part[rlist, j];
      v = Join[v, If[ Dot[e,Drop[r,1]]==0, {r},{}] ],
      {j, rlen}
    ];
    g = Join[g, If [ Length[v]==2, line2graph[2,bb,v,origin], {} ] ],
     {i, elen}
  ];
  Do[ (* put out points *)
    r = Part[rlist, j];
    g = Join[g,
      If[ And[First[r]==1, Last[r]=!=0],
        {Point[ Drop[Drop[r,1],-1]/Last[r] ]},
        {}
      ]
    ],
  {j,rlen}
  ];
  g
];
pol2graph::params = "wrong parameters";
pol2graph[___] := Message[ pol2graph::params ];

(* list of polyhedrons to graph *)
pols2graph[dim_,bb_,{ph_, pt___},origin_List] :=
  Join[pol2graph[dim,bb,ph,origin], pols2graph[dim,bb,{pt},origin]]
pols2graph[_,_,{},origin_] := {}
  
pols2graph::wrongP="wrong Parameter for pols2graph: `1`"
  
pols2graph[a___]:= Message[pols2graph::wrongP,a];

(* 
  Domain to graph
*)
Clear[dom2graph];
doms2graph[{d_, ds___}, bb_,origin_List] :=
  Join[domain2graph[d, bb,origin], doms2graph[{ds}, bb,origin]];
doms2graph[{},_,origin_List] := {};
doms2graph::wrongP="wrong Parameter for doms2graph: `1`"
doms2graph[a___]:= Message[doms2graph::wrongP,a];

(* domain to graph *)
Clear[domain2graph];
domain2graph[ domain[dim_,_,ps_], bb_,origin_List ] := 
  pols2graph[dim, bb, ps,origin];
domain2graph[ d:_List, bb_,origin_List] := 
  doms2graph[d, bb,origin];
domain2graph::wrongP="wrong Parameter for domain2graph: `1`"
domain2graph[a___]:= Message[domain2graph::wrongP,a];

(* Plot a domain *)
(* Dom can be a single domain or list of domains *)

Clear[showDomain];
(* If domain is given as a string, parse it *)
showDomain[dom_String] := showDomain[readDom[dom]];

showDomain::noOutput="showDomain: no Output "

showDomain[dom:_domain] :=
Catch[
  Module[{bb,origin},
    Check[
      bb = bbDomain[dom],
      Throw[ Message[showDomain::noOutput] ]
    ];

    origin = setOrigin[bb];
    arrowSize[ 0.025, bbAdjust[bb,.25,.05] ];
    Show[
      Graphics[
        domain2graph[ dom, bbAdjust[bb,.25,0], origin ],
          PlotRange -> bbAdjust[bb,.25,.05],
	  AspectRatio -> 1.0,
	  Axes -> True,
	  PlotLabel -> "Domain\n------",
          PlotRegion -> Automatic,
	  GridLines -> Automatic
      ]
    ]
  ]
];

showDomain[dom:_domain, domName:_String] :=
Catch[
  Module[{bb,origin},
    Check[
      bb = bbDomain[dom],
      Throw[ Message[showDomain::noOutput] ]
    ];

    origin=setOrigin[bb];
    arrowSize[0.025, bbAdjust[bb,.25,.05]];
    Show[
      Graphics[
        domain2graph[dom, bbAdjust[bb,.25,0],origin],
        PlotRange -> bbAdjust[bb,.25,.05],
        AspectRatio -> 1.0,
        Axes -> True,
        PlotLabel -> "\nDomain: "<>domName<>"\n",
        PlotRegion -> Automatic,
        GridLines -> Automatic
      ]
    ]
  ]
];
showDomain::wrongP="wrong Parameter for showDomain: `1` should be a domain"
showDomain[a___]:= Message[showDomain::wrongP,a];


(* 
  GetBoundingBox finds the bounding Box of a domain of any 
  dimension, by looking at the vertex of the domain. It takes the
  maximum of the coordinates of all the vertex on each coordinates
  and set it to Infinity if one of the vertex is a ray with a non nul
  coefficient for that coordinate
*)

getBoundingBox::noRays := "No ray in this polyhedron "
getBoundingBox::NoInfBound := "NoInfBound Found"

Clear[getBoundingBox];
(* 
  dom1 is a domain, listBound is the list of pairs of bounds
  already found and level is the coordinate that we are currently 
  looking at. Recursive function calling level+1) 
*)
(* 
  The function looks at every ray. If the last coefficient is not 
  zero, it tests the intersection of the ray by the hyperplane of the 
  last variable equal to one as a bound. If the last coefficient is zero,
  and if it is of the right sign (+ for upper bound) it sets the bound
  to Infinity
*)

getBoundingBox[dom1:_domain] := getBoundingBox[dom1,{},1];

getBoundingBox[dom1:_domain, listBound:_List, level_Integer]:=
Module[ {dim,nbRay,bInf,bSup,newList1,
  numberCurrentRay,currentRay},

  If[ Part[dom1,1]<level, Return[listBound ] ];

  dim = Part[dom1,1]; (* get dimension of domain *)
  nbRay = Part[dom1,3,1,2]; (* get number of rays *)

  If[ nbRay<=0,
    (* If no rays, emit a message and ??? *)
    Message[getBoundingBox::noRays], 

    (* Upper bound *)
    numberCurrentRay = 1;
    currentRay = Part[dom1,3,1,6,numberCurrentRay];

    (* We must find a ray that give rise to a bound *)
    While[ (numberCurrentRay <= nbRay)&&
      ((currentRay[[dim+2]]==0)&&
       (currentRay[[level+1]] <= 0)),

      numberCurrentRay=numberCurrentRay+1;
      currentRay = Part[dom1,3,1,6,numberCurrentRay];
    ];

    (* It is a real ray, not a vertex *)
    If[ 
      currentRay[[dim+2]]==0,
      (* it is a real ray, not a vertex *)
      If[
         currentRay[[level+1]] > 0 ||
         currentRay[[1]]==0 && currentRay[[level+1]]!=0 
         ,
         bSup=Infinity
      ],
      bSup=currentRay[[level+1]]/currentRay[[dim+2]]
    ];

    numberCurrentRay = numberCurrentRay+1;

    While[ 
      numberCurrentRay <= nbRay && bSup != Infinity,
      currentRay = Part[dom1,3,1,6,numberCurrentRay];
      If[ currentRay[[dim+2]]==0,
        If[
          currentRay[[level+1]] > 0 ||
          currentRay[[1]]==0 && currentRay[[level+1]]!=0,
          bSup=Infinity
        ],
	bSup=Max[bSup, currentRay[[level+1]]/currentRay[[dim+2]]]
      ];

      numberCurrentRay=numberCurrentRay+1;
    ];

    numberCurrentRay=1;  (* Lower bound *)
    currentRay = Part[dom1,3,1,6,numberCurrentRay];

    While[ numberCurrentRay <= nbRay && currentRay[[dim+2]]==0 &&
		 currentRay[[level+1]] >= 0,
      numberCurrentRay=numberCurrentRay+1;
      currentRay = Part[dom1,3,1,6,numberCurrentRay];
    ];

   If[ currentRay[[dim+2]]==0,
     If[
       currentRay[[level+1]] < 0||
       currentRay[[1]]==0 && currentRay[[level+1]]!=0,
       bInf=Infinity],
       bInf=currentRay[[level+1]]/currentRay[[dim+2]
     ]
   ];

   numberCurrentRay=numberCurrentRay+1;

   While[ 
     numberCurrentRay <= nbRay && bInf != Infinity,
     currentRay = Part[dom1,3,1,6,numberCurrentRay];
     If[ currentRay[[dim+2]]==0,
       If[
         currentRay[[level+1]] < 0||
         currentRay[[1]]==0 && currentRay[[level+1]]!=0,
         bInf=Infinity
       ],
       bInf=Min[bInf,currentRay[[level+1]]/currentRay[[dim+2]]]
     ];
     numberCurrentRay=numberCurrentRay+1;
   ];
   ];
   newList1=Append[listBound,{bInf,bSup}];
   getBoundingBox[dom1,newList1,level+1]
];

getBoundingBox::params = "wrong parameters";
getBoundingBox[___] := Message[ getBoundingBox::params ];

End[]
EndPackage[]

