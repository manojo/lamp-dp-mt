BeginPackage["Alpha`Visual3D`",
  {"Alpha`",
   "Alpha`Tables`",
   "Alpha`Semantics`",
   "Alpha`Domlib`"
      (*                               "Graphics`Colors`" *)
  }];

(* This package contains a few functions to show 3D polyhedra.
   Function planes is used to compute the faces of a polyhedron 
   given by its vertices. This function is not useful if MMAlpha
   is used. It returns a pair composed of the sets of vertices 
   of each face, and the planes delimiting the faces. The second
   main function of this package is myPolyhedron, which takes a
   list of planes, and a list of faces - as produced by planes, -
   and produces a list of convex polygons, which can be displayed
   by MMA without additional triangularization *)

Visual3D::note = "Documentation revised on August 10, 2004";

Visual3D::usage =
"The Alpha`Visual3D` package contains a few functions to visualize
and animate 3D domains. The main function is vshow, other functions 
are facets, and listPlanes. Some functions are exported only for debugging
purposes.";

facets::usage = 
"facets[dom] computes the list of polygons corresponding to the domain dom."; 

listPlanes::usage = 
"listPlanes[l,p] returns the pair {l,lp} where lp is the lists of planes in p which contain point l.";

maxR::usage = 
"maxR is an option of vshow. It allows the viewpoint of the final picture to 
be set. See stepR for more details.";

minR::usage = 
"minR is an option of vshow. It allows the r parameter of the viewpoint 
to be changed. By default, minR is 1. See also stepR and maxR,
and ViewPoint of Mathematica.";

orderPolygon::usage = "only here for debugging purposes.";

stepR::usage = 
"stepR is an option of vshow. It allows the step of the r parameter of the 
viewpoint to be changed, when one wants the domains to be animated. 
By default, stepR is 1. Combined with minR and maxR, it allows a sequence
of pictures with viewpoint between minR and maxR, by steps stepR to be 
drawn.";

threeDDomainQ::usage = "only here for debugging purposes.";

twoDDomainQ::usage = "only here for debugging purposes.";

vp1::usage = 
"vp1 is an option of vshow, allowing the first parameter of ViewPoint to
be changed. Default value is 3.";

vp3::usage = 
"vp3 is an option of vshow, allowing the third parameter of ViewPoint to 
be changed. Default value is 1.";

vshow::usage = 
"vshow[d] shows a 2D or 3D graphic picture of the 3D domain d. 
vshow[var] shows the domain of variable var in $result (see
Options[vshow] for more details).";

listPlanes::errType = "parameters are a point and a list of equations";

units::usage = "only here for debugging purposes.";

Options[vshow]:= {
  minR->1., stepR->1., maxR -> 1., vp1->3,
  vp3->1, 
  TextStyle->{FontSize->10}, 
  AspectRatio->Automatic, 
  Axes->True,
  AxesEdge->{{-1,-1},{-1,-1},{-1,-1}},
  AxesStyle->Thickness[0.01],
  BoxStyle->Dashing[{0.02,0.02}],
  AxesLabel->{"x","y","z"},
  Ticks->{units,units,units}
}

(* ===================== Private definitions ===================== *)

Begin["`Private`"]

showDomain::usage =
"showDomain[d:_domain] displays the plot of a domain of dimension less or equal 
to 3, or any list of such domains. showDomain[d:_domain, name_String]
displays with the title \"name\"  specified."

(* show a 2D domain *)
Clear[showDomain];
showDomain::domain = "error while parsing the domain.";
showDomain::noOutput="showDomain: no Output.";
showDomain::bb = "error while computing bounding box.";

showDomain[ dom_String ] :=
Catch[
  showDomain[ Check[ readDom[dom], Throw[ Message[ showDomain::domain ] ] ] ]
];

showDomain[dom_domain?twoDDomainQ] :=
Catch[
  Module[{bb,origin},
	bb = Check[ bbDomain[dom], Throw[ showDomain::bb ] ];
	If [MatchQ[bb,{{},{},{___},{___}}],
	    Message[showDomain::noOutput],
	    origin=setOrigin[bb];
	    arrowSize[0.025, bbAdjust[bb,.25,.05]];
	    Show[Graphics[domain2graph[dom, bbAdjust[bb,.25,0],origin],
			  PlotRange -> bbAdjust[bb,.25,.05],
			  AspectRatio -> 1.0,
			  Axes -> True,
			  PlotLabel -> "Domain\n------",
		      PlotRegion -> Automatic,
			  GridLines -> Automatic]]
	  ]
      ]
]; (* Catch *)

showDomain[ dom_domain?twoDDomainQ, domName_String ] :=
Catch[
  Module[{bb,origin},
	bb = bbDomain[dom];
	If [MatchQ[bb,{{},{},{___},{___}}],
	    Message[showDomain::noOutput],
	    origin=setOrigin[bb];
	    arrowSize[0.025, bbAdjust[bb,.25,.05]];
	    Show[Graphics[domain2graph[dom, bbAdjust[bb,.25,0],origin],
			  PlotRange -> bbAdjust[bb,.25,.05],
			  AspectRatio -> 1.0,
			  Axes -> True,
			  PlotLabel -> "\nDomain: "<>domName<>"\n",
			  PlotRegion -> Automatic,
			  GridLines -> Automatic]]
	  ]
      ]
]; (* Catch *)
showDomain[a___]:= showDomain::params ;

Clear[twoDDomainQ];
twoDDomainQ[d:_domain] := d[[1]] <= 2;
twoDDomainQ[___] := Message[ twoDDomainQ::params ];

bbDomain::usage =

"bbDomain[d:_domain] returns a list representing the bounding box of
domain d: {{xmin,xmax},{ymin,ymax},{xneg,xpos}, {yneg,ypos}}.
{xmin,xmax},{ymin,ymax} is the bounding box of the vertices.
{xneg,xpos}, {yneg,ypos} indicate that the domain is infinite in one of
these directions ( x negative, x positive...)"

(* Note: A frame is the structure indicating in which direction the
   polyhedron is infinite *)


(************ bbDomain functions *****************)

(* Add a ray x to frame {x1,x2} *)

Clear[bbFrame];
bbFrame[x_, {x1_, x2_}] :=
  If[x<0, {1, x2},
     If[x>0, {x1, 1}, {x1, x2}]
   ];

bbFrame::wrongP="wrong Parameter for bbFrame: `1`";
  
bbFrame[a___]:=
Module[{},
	Message[bbFrame::wrongP,a];
       ];


(* bbPtList translates the list of Vertex/Ray/Lines of a polyhedron 
   into a bounding box *)
Clear[bbPtList];

(* for one dimensional domains *)
(* empty point list *)
bbPtList[ 1, {}, res_] := res;
  
(* first result, point is ray (d==0) or vertex (d!=0) *)
bbPtList[ 1, {{1, x_, d_}, pts___}, {{},{}, fx_, fy_}] :=
  If[d == 0, 
     bbPtList[ 1, {pts}, {{},{}, bbFrame[x,fx], fy}],
     bbPtList[ 1, {pts}, {{x/d, x/d}, {0, 0}, fx, fy}] ];

(* line *)
bbPtList[ 1, {{0, x_, d_}, pts___}, {{xi_,xa_}, {yi_, ya_}, fx_, fy_}] :=
  bbPtList[ 1, {pts}, {{xi,xa}, {yi, ya}, bbFrame[-x,bbFrame[x,fx]], fy}];

(* ray (d==0) or vertex (d!=0) *)
bbPtList[ 1, {{1, x_, d_}, pts___}, {{xi_,xa_}, {yi_, ya_}, fx_, fy_}] :=
  If[d == 0,
     bbPtList[ 1, {pts}, {{xi,xa}, {yi, ya}, bbFrame[x,fx], fy}],
     {{If[x/d<xi, x/d, xi], If[x/d>xa, x/d, xa]}, {yi, ya}, fx, fy}];

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
	    bbPtList[ 2, {pts}, {{If[x/d < x1,x/d,x1], If[x/d > x2,x/d,x2]},
				 {If[y/d < y1,y/d,y1], If[y/d > y2,y/d,y2]},fx,fy}
				 ]
      ],
     (* line *)
       bbPtList[ 2, {pts}, {{x1,x2}, {y1, y2}, bbFrame[-x,bbFrame[x,fx]],
			    bbFrame[-y,bbFrame[y,fx]]}]
   ];

bbPtList::wrongP="wrong Parameter for bbPtList: `1`";
  
bbPtList[a___]:=
  Module[{},
	 Message[bbPtList::wrongP,a];
       ];

(* parses down a list of polyhedra, combines all of their points into
   one great list *)
Clear[bbPolList];
bbPolList[dim_, {Alpha`pol[_,_,_,_,_,pt1_],pt2___}, res_] :=
  bbPolList[dim, {pt2}, bbPtList[dim, pt1, res] ];
bbPolList[_, {}, res_] := res;
  
bbPolList::wrongP="wrong Parameter for bbPolList: `1`";
  
bbPolList[a___]:=
  Module[{},
	 Message[bbPolList::wrongP,a];
       ];


(* combine extremal vertices of two bounding boxes *)

Clear[bbCombine1];
bbCombine1[{z1_,z2_}, {z3_,z4_}] := { Min[z1,z3], Max[z2,z4] };
bbCombine1[{z1_,z2_}, {}] := {z1,z2};
bbCombine1[{},{z1_,z2_}] := {z1,z2};
bbCombine1[{},{}] := {};
 
bbCombine1::wrongP="wrong Parameter for bbCombine1: `1`";
  
bbCombine1[a___]:=
  Module[{},
	 Message[bbCombine1::wrongP,a];
       ];


(* combine infinite directions of two bounding boxes *)

Clear[bbCombine2];
bbCombine2[{z1_,z2_}, {z3_,z4_}] := { Max[z1,z3], Max[z2,z4] };
bbCombine2[{z1_,z2_}, {}] := {z1,z2};
bbCombine2[{},{z1_,z2_}] := {z1,z2};
bbCombine2[{},{}] := {};

bbCombine2::wrongP="wrong Parameter for bbCombine2: `1`";
  
bbCombine2[a___]:=
  Module[{},
	 Message[bbCombine2::wrongP,a];
       ];

(* Combines the bounding boxes of a list of domain *)

Clear[bbCombine];
bbCombine[{x1_,y1_,x2_,y2_},{x3_,y3_,x4_,y4_}] :=
  { bbCombine1[x1,x3], bbCombine1[y1,y3],
   bbCombine2[x2,x4], bbCombine2[y2,y4] };
bbCombine[{x1_,y1_,x2_,y2_},{}] := {x1,y1,x2,y2};
bbCombine[{},{x1_,y1_,x2_,y2_}] := {x1,y1,x2,y2};
bbCombine[{},{}] := {};
  
bbCombine::wrongP="wrong Parameter for bbCombine: `1`";
  
bbCombine[a___]:=
Module[{},
	 Message[bbCombine::wrongP,a];
       ];


(* Combines the bounding boxes of a list of domain *)

Clear[bbDomList];

bbDomList[{d_, ds___}] := bbCombine[bbDomain[d], bbDomList[{ds}]];
bbDomList[{}] := {};
bbDomList::wrongP="wrong Parameter for bbDomList: `1`";
  
bbDomList[a___]:=
Module[{},
	 Message[bbDomList::wrongP,a];
       ];


(* bbDomain find the bounding box of a Domain or a list of domains
   The result is a list of four pairs: 
   {{xmin,xmax},{ymin,ymax},{xneg,xpos},{yneg,ypos}}
   where xneg,pos,yneg,ypos indicate wheter the domain is unbounded
   in this direction  *)

Clear[bbDomain];

bbDomain[Alpha`domain[dim_,_,p_ ]] :=
  If[dim>2, (Print["\n Domain is greater then two !!!"];
	     {{},{},{0,0},{0,0}}),
     bbPolList[dim, p, {{},{},{0,0},{0,0}}]
   ];

bbDomain[d_List] := bbDomList[d];

(* Standard way of handling wrong parameter for functions *)
bbDomain::wrongP = 
"wrong Parameter for bbDomain: `1` should be an Alpha\`Domain";
  
bbDomain[a___]:=
  Module[{},
	 Message[bbDomain::wrongP,a];
       ];


(*********** showDomain functions *******************)

(* bbAdjust: adjust bounding box by adding a frame -- relative 
   lots of good heuristics built in. 
   n is relative frame in direction of rays only,
   m is relative frame in all directions  *)

Clear[bbAdjust];
bbAdjust[{{x1_,x2_},{y1_,y2_},{x3_,x4_},{y3_,y4_}},n_,m_] :=
  Block[{xn,yn,xm,ym},
	xn = Ceiling[(x2-x1+.5)*n];
	yn = Ceiling[(y2-y1+.5)*n];
	xm = Ceiling[(x2-x1+.5)*m];
	ym = Ceiling[(y2-y1+.5)*m];
	{{Floor[x1]-xn*x3-xm,Ceiling[x2]+xn*x4+xm},
	 {Floor[y1]-yn*y3-ym,Ceiling[y2]+yn*y4+ym}}
	 ];

bbAdjust[{{},{},_,_},_,_] := {{0,1},{0,1}};
  
bbAdjust::wrongP="wrong Parameter for bbAdjust: `1`";
  
bbAdjust[a___]:=
  Module[{},
	 Message[bbAdjust::wrongP,a];
       ];

Clear[setOrigin];
setOrigin[{{x_,_},{y_,_},{_,_},{_,_}}] :=
  Module[{originX,originY},
	 originX = x*1.0;
	 originY = y*1.0;
	 {originX,originY}];

setOrigin::wrongP="wrong Parameter for setOrigin: `1`";
  
setOrigin[a___]:=
  Module[{},
	 Message[setOrigin::wrongP,a];
       ];

(* absolute and relative arrow sizing functions *)
Clear[arrowSize];
arrowSize[s_, {{x1_,x2_},{y1_,y2_}}] := (
					 $arrowdx = (x2-x1);
					 $arrowdy = (y2-y1);
					 $arrow = {{0,s},{0,-s},{3*s,0}}
					 );

arrowSize::wrongP="wrong Parameter for arrowSize: `1`";
  
arrowSize[a___]:=
Module[{},
	 Message[arrowSize::wrongP,a];
       ];

(* Build an arrow at (x1, y1) pointing in direction (x2, y2) *)
Clear[arrow];
arrow[ {x1_, y1_} ,{x2_, y2_} ] := 
  Block[{sn, cs, tmp},
	tmp = N[Sqrt[x2*x2+y2*y2]];
	sn = y2/tmp;
	cn = x2/tmp;
	Polygon[{{x1,y1},{x1,y1},{x1,y1}} +
		  $arrow.{{cn*$arrowdx,sn*$arrowdy},{-sn*$arrowdx,cn*$arrowdy}}]
      ];

arrow::wrongP="wrong Parameter for arrow: `1`"
arrow[a___]:=
Module[{},
	 Message[arrow::wrongP,a];
      ];

(* draw a circle of n evenly spaced vectors to test arrows *)
Clear[testArrows];
testArrows[n_,s_] := 
  Block[{a,b,x,y,g,t},
	g={};
	b = {{-s-1,s+1},{-s-1,s+1}};
	arrowSize[.025,b];
	t=2*3.1416/n;
	For [a=0.0, a<2*3.1416, a=a+t,
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
		      GridLines -> None ]]
      ];

testArrows::wrongP="wrong Parameter for testArrows: `1`";
testArrows[a___]:=
  Module[{},
	 Message[testArrows::wrongP,a];
       ];

Clear[rayEnd];
rayEnd[{{xmin_, xmax_}, {ymin_, ymax_}},x1_,y1_,d_,x2_,y2_] := 
  Block[{k},
	k = Min[ If[x2==0, Infinity, Max[(xmin-(x1/d))/x2, (xmax-(x1/d))/x2] ],
		 If[y2==0, Infinity, Max[(ymin-(y1/d))/y2, (ymax-(y1/d))/y2] ] ];
	{(x1/d)+(k*x2), (y1/d)+(k*y2)}
	];
rayEnd::wrongP="wrong Parameter for rayEnd: `1`";
rayEnd[a___]:=
  Module[{},
	 Message[rayEnd::wrongP,a];
       ];

(* one dimensional lines *)
(* change one dimensional into two dimensional *)
Clear[line2graph];
line2graph[1, bb_,{{s1_,x1_,d1_},{s2_,x2_,d2_}},origin_List] :=
  line2graph[2,bb,{{s1,x1,0,d1},{s1,x2,0,d2}},origin];

(* two dimensional lines *)
line2graph[2,bb_,{{1,x1_,y1_,d1_},{1,x2_,y2_,d2_}},origin_List] := 
  Block[{p},
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
  Block[{p1,p2,originX,originY},
	If[d1==0,( (* ray - line == replace line with origin *)
		  originX=origin[[1]];
		  originY=origin[[2]];
		  p1 = rayEnd[bb,originX, originY, 1,x1,y1];
		  {Dashing[{.02}],Line[{p1,{originX, originY}}],
		   Dashing[{}], arrow[p1,{x1,y1}]}
		  ),
	   ( p1 = rayEnd[bb,x1,y1,d1,x2,y2];
	    p2 = rayEnd[bb,x1,y1,d1,-x2,-y2];
	    { Line[{p1, p2}], arrow[p1,{x2,y2}], arrow[p2,{-x2,-y2}] }
	    )
	   ]
      ];

(* line - point *)
line2graph[2,bb_,{{0,x1_,y1_,_},{1,x2_,y2_,d2_}},origin_List] :=
  Block[{p1,p2,originX,originY},
	If[d2==0,( (* ray - line == replace line with origin *)
		  originX=origin[[1]];
		  originY=origin[[2]];
		  p1 = rayEnd[bb,originX,originY, 1,x2,y2];
		  {Dashing[{.02}],Line[{p1,{originX, originY}}],
		   Dashing[{}], arrow[p1,{x2,y2}]}
		  ),
	   ( p1 = rayEnd[bb,x2,y2,d2,x1,y1];
	    p2 = rayEnd[bb,x2,y2,d2,-x1,-y1];
	    { Line[{p1, p2}], arrow[p1,{x1,y1}], arrow[p2,{-x1,-y1}] }
	    )
	   ]
      ];

line2graph::wrongP="wrong Parameter for line2graph: `1`";
  
line2graph[a___]:=
  Module[{},
	 Message[line2graph::wrongP,a];
       ];

Clear[pol2graph];
pol2graph[1, bb_, Alpha`pol[elen_ ,rlen_ ,_ ,_ ,elist_ ,rlist_],origin_List] :=
  Block[{v, g, r},
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
	  {j, rlen}];
	g = Join[g, If [ Length[v]==2, line2graph[1,bb,v,origin], {} ] ];
	g
	];

pol2graph[2, bb_, Alpha`pol[elen_ ,rlen_ ,_ ,_ ,elist_ ,rlist_],origin_List] :=
  Block[{v, g, e, r},
	g = {PointSize[.025], Thickness[.0075]};
	Do[ (* put out lines *)
        e = Drop[Part[elist, i],1];
	  v = {};
	  Do [
	    r = Part[rlist, j];
	    v = Join[v, If[ Dot[e,Drop[r,1]]==0, {r},{}] ],
	    {j, rlen}];
	  g = Join[g, If [ Length[v]==2, line2graph[2,bb,v,origin], {} ] ],
	  {i, elen}];
	Do [ (* put out points *)
        r = Part[rlist, j];
	  g = Join[g,
		   If[ And[First[r]==1, Last[r]=!=0],
		       {Point[ Drop[Drop[r,1],-1]/Last[r] ]},
		       {}
		       ]
		 ],
	  {j,rlen}];
	g
	];

(* list of polyhedrons to graph *)
pols2graph[dim_,bb_,{ph_, pt___},origin_List] :=
  Join[pol2graph[dim,bb,ph,origin], pols2graph[dim,bb,{pt},origin]];
pols2graph[_,_,{},origin_] := {};
  
pols2graph::wrongP="wrong Parameter for pols2graph: `1`";
  
pols2graph[a___]:=
  Module[{},
	 Message[pols2graph::wrongP,a];
       ];

Clear[dom2graph];
doms2graph[{d_, ds___}, bb_,origin_List] :=
  Join[domain2graph[d, bb,origin], doms2graph[{ds}, bb,origin]];
doms2graph[{},_,origin_List] := {};
doms2graph::wrongP="wrong Parameter for doms2graph: `1`";
  
doms2graph[a___]:=
  Module[{},
	 Message[doms2graph::wrongP,a];
       ];

(* domain to graph *)
Clear[domain2graph];
domain2graph[Alpha`domain[dim_,_,ps_], bb_,origin_List] := 
  pols2graph[dim, bb, ps,origin];
domain2graph[d_List, bb_,origin_List]                   := 
  doms2graph[d, bb,origin];

domain2graph::wrongP="wrong Parameter for domain2graph: `1`";
  
domain2graph[a___]:=
  Module[{},
	 Message[domain2graph::wrongP,a];
       ];

showDomain[x:___] := vshow[x];  (* Redirect showDomain *)

Clear[threeDDomainQ];
threeDDomainQ[d:_domain] := d[[1]]==3;
threeDDomainQ[___] := Message[threeDDomainQ::params];

Clear[vshow];
vshow::facets = "error while computing the facets of the domains.";
vshow::params = "wrong parameters";
vshow::eqinex = "no equation defining `1`";

(* Redirect 2D vshow *)
vshow[ d:_domain?twoDDomainQ, opts:___Rule ] := showDomain[ d ]; 

(* Visualiser les domaines d'une équation *)
vshow[ s:_String, opts:___Rule ]:=
Catch[
  Module[{eq, d1, d2},
    Check[ eq = getEquation[ s ], Throw[ Message[ show::eqinex, s ] ] ];
    d1 = getDeclaration[ s ][[3]];
    d2 = expDomain[ getDefinition [ s ] ];
    d1 = DomIntersection[ d1, d2 ];
    vshow[ d1, opts ]
  ]
];

(* If the domain is a union, replace it as a list of domains *)
vshow[ 
  domain[dim:_Integer,
         ind:{___String},
         p:{_pol,__pol}], 
         opts:___Rule 
]:= vshow[ Map[domain[dim,ind,{#}]&,p], opts];
vshow[ d:_domain, opts:___Rule ]:=vshow[ {d}, opts ];
vshow[ ld:{___domain}, opts:___Rule ]:=
Catch[
  Module[{pl,gr,OptminR,rays,dim,OptstepR,OptmaxR,optvp1,optvp3,
          optTextStyle, optAspectRatio, optAxes, optAxesEdge, 
          optAxesStyle, optBoxStyle, optAxesLable, optTicks},

    (* Get the options *)
    OptminR = minR/.{opts}/.Options[vshow];
    OptstepR = stepR/.{opts}/.Options[vshow];
    OptmaxR = maxR/.{opts}/.Options[vshow];
    optvp1 = vp1/.{opts}/.Options[vshow];
    optvp3 = vp3/.{opts}/.Options[vshow];
    optTextStyle = TextStyle/.{opts}/.Options[vshow];
    optAspectRatio = AspectRatio/.{opts}/.Options[vshow];
    optAxes = Axes/.{opts}/.Options[vshow];
    optAxesEdge = AxesEdge/.{opts}/.Options[vshow];
    optAxesStyle = AxesStyle/.{opts}/.Options[vshow];
    optAxesLabel = AxesLabel/.{opts}/.Options[vshow];
    optTicks = Ticks/.{opts}/.Options[vshow];
    optBoxStyle = BoxStyle/.{opts}/.Options[vshow];

    (* Compute the facets of the list of domains, anf
       flatten them *)
    Check[gr = Map[facets,ld], Throw[Message[vshow::facets]]];		
    gr = Flatten[gr]; 

    (* Call Graphics3D *)
    Table[
	        Show[Graphics3D[gr],
	             AspectRatio->optAspectRatio,
                     Axes->optAxes,
                     AxesEdge->optAxesEdge,
                     AxesStyle->optAxesStyle,
                     BoxStyle->optBoxStyle,
                     AxesLabel->optAxesLabel,
                     Ticks->{units,units,units},
                     ViewPoint->{optvp1,2*i,optvp3},
                     TextStyle->optTextStyle,
                     SphericalRegion->True
                ],{i,OptminR,OptmaxR,OptstepR}]
      ]
];
vshow[___] := Message[vshow::params];

(* Define the type point *)
Clear[point];
point = {_,_,_};

(* This function takes a domain, and returns a 3 argument result: 
   - the list of indices of the domain,
   - a list whose element are vertices of the domain which belong 
   to a same facet of the domain,
   - the list of inequalities of the domain.

This intermediate result will  serve to compute the polygons of the
figure, once the vertices are reordered. 

A degenerated domain (i.e., a 2D domain ) has only one polygon. The
second argumant has therefore only one list of vertices, and the third
one has only the inequalities of the domain.
*)
Clear[facets];
facets::params = "wrong parameters";
facets::wrgvertices = "error while computing the vertices of the domain";
facets::wrgrays = "error while computing the rays of the domain";
facets::wrgdom2mma = "error while calling dom2mma.";
facets::wrgequalities = "domain has more than one equalities.";
facets::wrgdimension = "domain is not three dimensional.";
facets::infntdomain = "domain is infinite. Cannot show it.";
facets[d:_domain]:=
Catch[
  Module[{mmadomain,indices,equalites,inequalities,v,lb,r,lp,
          wrappedd},
	(* Check that the domain is 3D *)
	If[d[[1]] =!= 3, Throw[facets::wrgdimension]];
	(* Compute the vertices of the domain *)
	Check[ve = vertices[d],Throw[facets::wrgvertices]];
	(* Compute the rays *)
	Check[r = rays[d], Throw[facets::wrgrays]];
	(* Domain should not have rays *)
	If[r =!= {}, 
           Print["Domain \n", show[d,silent->True], "\n has rays"];
           Throw[Message[facets::infntdomain]]];

	(* Using domm2mma, compute the indices and the inequalities of 
	   the domain *)
	Check[{inequalities,indices} = 
          dom2mma[d],Throw[facets::wrgdom2mma]];
	(* Select the equalities *)
	equalities = Cases[inequalities, Equal[x_,y_]]; 
	(* select the inequalities *)
 	inequalities = Cases[inequalities, GreaterEqual[x_,y_]:>x == y];

   Which[
	(* If the domain has one equality, the vertices already form a
	   polygon *)
	Length[equalities] === 1, lp = {ve};
	       Map[orderPolygon[indices,#1,inequalities]&,lp],
	(* 2 equalities: we have a line *)
	Length[equalities] === 2, lp = {Green,AbsoluteThickness[3.],Line[ve]}, 
        (* 3 equalities: we have a single point *)
	Length[equalities] === 3, lp = {Red,AbsolutePointSize[8.],Point[ve[[1]]]},
        (* Otherwise *)
        True,
	(* Now we compute lists of points which form a polygon. 
	   Such points are those which satisfy a same equality. 
	   To build these lists, we select the vertices which satisfy
	   an equality, and we map this operation in turn on all 
	   equalities *)
	(* f1 is a function which combines indices and points to provide
	   a list of rule e.g. {i-> 1, j -> 2, k ->10} *)
	Clear[f1,f2];
	f1 = Function[{point},MapThread[Rule[#1,#2]&,{indices,point}]];
	(* f2 is a function which evaluates an equality on a list of points *)
	f2 = Function[{equ,listpoint},Map[equ/.f1[#1]&,listpoint]];
	lb = Map[f2[#1,ve]&, inequalities];
	lb = Map[Table[If[#1[[i]],ve[[i]],0],{i,1,Length[ve]}]&,lb];
	lp = Map[Select[#1,#1 =!= 0&]&,lb];
        Map[orderPolygon[indices,#1,inequalities]&,lp] 
   ] (* Which *)
   ] (* Module *)
]; (* Catch *)
facets[___] := Message[facets::params];

(* Interface between orderPolygon and planes *)
(* ListPlanes takes a point and a list of equalities, and finds out all planes
   which contain the point *)
Clear[listPlanes];
listPlanes[indices:_,l:point,p:{___Equal}]:=
Module[{r},
  r = MapThread[(#1->#2&),{indices,l}];
  o = p/.r;{l,
      Select[Table[If[o[[i]],p[[i]],Null],{i,1,Length[o]}],#1=!=Null&]}
      ];
listPlanes[___]:=Message[listPlanes::errType];

(* This function reorders the points in a polyhedron *)
Clear[reorder];
reorder::typeErr = 
  "parameters should be a list of pairs of points and list of planes";
reorder::error = "do not find a next one in `1`";
reorder[l:{{p:point,{___Equal}}}]:=l;
reorder[arg:{deb:{p:point,l:{___Equal}},seq:__}]:=
	Module[{next},
		next = Select[{seq},Intersection[#1[[2]],l]=!={}&];
		If[next==={},Message[reorder::error,arg],
			With[{n=next[[1]]},
		           Prepend[reorder[Prepend[Complement[{seq},{n}],n]],
					deb]]]
	];
reorder[___]:=Message[reorder::typeErr];

(* *)
Clear[orderPolygon];
orderPolygon::usage = 
"orderPolygon[l,p] orders the points of l in such a way that they form
a convex polygon, assuming that l forms a face of a polyhedron
delimited by the planes p.";

(* the algorithm used consists in ordering the points of l so that
   each point shares a common intersection plane with the next one.
   One is then sure that successive points form segments of the 
   convex polyhedron  *)
(* Called by myPoly, and calls listPlanes, then reorder *)
orderPolygon::errType = 
  "paramaters should be a list of points and a list of planes";
orderPolygon[indices:_,l:{point...},p:{___Equal}]:=
Catch[
	Module[{temp,common},
		Check[temp = Map[listPlanes[indices,#1,p]&,l],Throw[Null]];
		common = Apply[Intersection,Transpose[temp][[2]]];
		temp = Map[{#1[[1]],Complement[#1[[2]],common]}&,temp];
		Polygon[Map[First,reorder[temp]]]
		]
]
orderPolygon[x:___]:=(Print[x];Message[orderPolygon::errType]);

Clear[units];
units[xmin_,xmax_]:=Range[Floor[xmin],Floor[xmax],1];

End[];
EndPackage[]

