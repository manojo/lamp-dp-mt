BeginPackage["Alpha`Schematics`",
  {"Alpha`",
   "Alpha`Domlib`",
   "Alpha`Tables`",
   "Alpha`Matrix`",
   "Alpha`Options`"
  (* "Graphics`Colors`", *)
  (*   "DiscreteMath`Combinatorica`" *)
}];

(* package documentation *)
Schematics::usage = 
"This package contains functions for drawing a raw schematics of an Alpha 
programs";

(* yFactor is the form factor for any box. By convention, the x size 
   is 1. offsetX is the x offset reserved for drawing input connexions. 
   offsetY is the y offset. 
 *) 
Options[schematics]={yFactor -> 0.2, offsetX -> 0.5, offsetY ->
0.1, sPositions -> {columns->2}, fSize->20, partShown ->  {{0.,1.},{0.,1.}}}; 

partShown::usage = 
"partShown is an option of schematics. It defines the region of the
plot that will be shown. Default is Automatic and corresponds to a
region {{0,1},{0,1}}, which displays the full schematics. partShown
->{{0.2,0.4},{0.3,1.2}} would display a region whose coordinates,
relative to the schematics, are changed.";

fSize::usage = "fSize is an option of schematics, which changes
the size of the font used to show symbols. Default value is 20 .";

sPositions::usage = 
"sPositions is an option of schematics. Default value is square.
sPositions -> Null stacks the operators.  sPositions -> {columns ->
nb} gives the number of columns of the diagram.  sPositions may be a
list of coordinates for the operators. In this case, make sure that
the number of positions is the same as the number of operators.";

square::usage = "square is an option value for option sPosition in 
the schematics function. sPosition -> square asks for a square shaped
schematics layout.";

columns::usage = "columns is an option value for option sPosition in 
the schematics function. sPositions->{columns->nb} asks for a nb
column schematics layout.";

yFactor::usage = 
"yFactor is the form factor of boxes used by the schematics
function. Default value is 0.2 .";

offsetX::usage = 
"offsetX is the X offset value for schematics. Default value is 0.5 .";

offsetY::usage = 
"offsetY is the Y offset value for schematics. Default value is 0.1 .";

newName::usage = 
"newName[ sys, v ] returns a new unique name built from variable v. 
newName[ v ] does the same in $result. This function cannot be used
in any context. Use getNewName instead.";

skeleton::usage = "skeleton[] gives the skeleton of $result";
skeleton::typeErr = "wrong parameters";

schematics::usage = "schematics[] draws a schematic diagram of the 
program $result. See Options[schematics] to get the options of 
schematics.";

flattenEquation::usage = "";

flattenSkeleton::usage = "ddddd";

findAliases::usage = "";

(* ===================== Private definitions ===================== *)

Begin["`Private`"];

Clear[ findAliases ];
findAliases[]:=
Catch[
  Module[{vars, equalities, equalities2, predicate, funcAux, g, labels,
          g1, g2, tcofg},
    vars = getLocalVars[];
    equalities1 = Cases[ $result[[6]], equation[ lhs:_, var[x:_]]:> {lhs,x}];
    equalities2 = 
      Cases[ $result[[6]], 
             equation[ lhs:_, affine[var[x:_],m_?identityQ]]:> {lhs,x}];
    equalities = Union[equalities1,equalities2];
    predicate = 
    Map[ Apply[DomEqualQ,Map[getDeclarationDomain,#]]&, equalities ];
    g = 
    Map[First, Select[ Transpose[ {equalities, predicate} ],Part[#,2]& ] ];

    Print["Computing transitive closure"];
    labels = Apply[Union,g]; 
    g = Map[ First[First[Position[labels,#]]]&, g ,{2,2}];
    g1 = FromOrderedPairs[g];
    ShowGraph[g1];
    g2 = TransitiveClosure[g1];
    ShowGraph[g2];
    tcofg = ToOrderedPairs[g2]   

  ] (* End Module *)
]; (* End Catch *)
findAliases[___]:= Message[findAliases::params];
findAliases::params = "wrong parameters...";

(* skeleton produces an abstraction of the program *)
Clear[skeleton];
(* skeleton of a system is a structure of the form
   system[ name, ... ] 
   where name is the name of the system and 
   ... the skeletons of its equations 
*)
skeleton[system[name:_String,params:_,inputs:{___decl},
	 outputs:{___decl},
	 locals:{___decl},
	 eqs:{(_equation|_use)...}]]:=
  system[name,Map[skeleton,eqs]];
(* skeleton of an equation is a liste of its lhs, and
   the skeleton of its rhs *)
skeleton[equation[lhs:_String,rhs:_]]:=
	{lhs,skeleton[rhs]};
(* Case of a mux operator: same condition. WARNING: the 
  "" as a first argument is an horrible patch. Do not change! *)
skeleton[
  case[{restrict[_,if[c:_,e1:_,e2:_] ], 
        restrict[_,if[c:_,e3:_,e4:_] ]} ] ]:=
  mux["",skeleton[e1],skeleton[e4],skeleton[c]];
skeleton[case[x:{___}]]:=
  Apply[case, Prepend[Map[skeleton,x],""]];
skeleton[restrict[_,exp:_]]:=skeleton[exp];
skeleton[affine[exp:_,dep:_]]/;
  (translationQ[dep]&&First[getTranslationVector[dep]]=!=0):=
  skeleton[unop[reg,exp]];
skeleton[affine[exp:_,dep:_]]/;
  !identityQ[dep]:=skeleton[unop[connexion,exp]];
skeleton[affine[exp:_,dep:_]]/;
  identityQ[dep]:=skeleton[exp];
(* WARNING: the 
  "" as a first argument is an horrible patch. Do not change! *)
skeleton[if["",c:_,l:_,r:_]]:=if["",skeleton[c],skeleton[l],skeleton[r]];
skeleton[var[v:_]]:=v;
skeleton[const[c:_]]:=c;
skeleton[binop[op_,e1_,e2_]]:=binop[op,skeleton[e1],skeleton[e2]];
skeleton[unop[op_,e_]]:=unop[op,skeleton[e]];
skeleton[reduce[op_,m_,e:_]]:=reduce[op,skeleton[e]];

(* A use statement has several outputs that are not
   connected*)
skeleton[use[op:_,d:_,m:_,e:{___},o:{___}]]:=
  {o,use[op,Map[skeleton,e]]};

skeleton[x:___]:=
  (Print["While processing element: ", x ];
   Message[skeleton::params];)
skeleton::params = "wrong paramaters";

(*
  This function creates a new name for a variable x
*)
Clear[newName];
newName[ x:_String ] := newName[ $result, x ];

newName[sys:_system,x:_String]:=
Catch[
  Module[{y},
    If[ !IntegerQ[ $newNameNumber ],
      newName::error = "$newNameNumber is not set...";
      Throw[ Message[ newName::error1 ] ]
    ];

    y=x<>ToString[$newNameNumber=$newNameNumber+1];

    If[MemberQ[getVariables[sys],y],newName[sys,x],y]
  ]
];
newName::params = "wrong parameters";
newName[___]:=Message[newName::params];

(* FlattenSkeleton replaces the skeleton of the program by a 
	list of elementary equations *)
Clear[flattenSkeleton];
flattenSkeleton[]:=flattenSkeleton[$result];
flattenSkeleton[sys:_system]:=
Catch[
Module[{sk,sk2,result,ff1,ff2,reste,funcAux},
  (* This auxiliary function is used to flatten the 
     equations. It takes two lists of equations, x and y, 
     Maps flattenEquation on x, and returns a new pair
     {x,y} . This functions "fixpoints" when y is empty *)
  funcAux[p:{x:_,y:_}]:=
  Which[
    y==={},p,
    True,
    Module[{r1,r2},
      r1 = Map[flattenEquation[sys,#]&,y];
      {Union[x,Map[First,r1]],Apply[Union,Map[Last,r1]]}
    ]    
  ];
  $newNameNumber = 0;
  sk = skeleton[sys];
  sk2 = sk[[2]];
  (* Compute the fixpoint of funcAux, and take the 
     first element of the pair *)
  result = First[FixedPoint[funcAux,{{},sk2}]];
  system[sk[[1]],result]
]
];
flattenSkeleton[___]:=Message[flattenSkeleton::params];

(* Flatten one equation -- 
	This function replaces compound expressions that appear in an 
	equation, by inserting new variables. For example, Y = (A+B)*C
	will be rewritten as Y = Y.1 *C ; Y.1 = A+B. To do so, a set 
	of rewrite rules are defined. These rewrite rules have a side effect:
	they append new definitions at the end of a list called acc, initially
	empty. These rules are applied on the parameters. As a result, the
	function returns the modified input equation, and the list acc 
	of all added definitions. The new symbols are formed by appending 
	a number to the right of the lhs symbol.
*)
Clear[flattenEquation];
flattenEquation[sys:_system,{lhs_,rhs_}]:=
Module[{temp,flr,acc,x,y,
        complexExpr = (_binop|_unop|_if)},
    acc = {};
    (* The following is a set of rewrite rules which will be
       applied until convergence *)
    flr = {
        (h:(if|mux))["",c:(_binop|_unop),l:_,r:_]:>
	        (acc=Union[acc,{{x=newName[sys,lhs],c}}];h["",x,l,r]),
        (h:(if|mux))["",c:_,l:(_binop|_unop),r:_]:>
	        (acc=Union[acc,{{x=newName[sys,lhs],l}}];h["",c,x,r]),
        (h:(if|mux))["",c:_,l:_,r:(_binop|_unop)]:>
	        (acc=Union[acc,{{x=newName[sys,lhs],r}}];h["",c,l,x]),
        binop[op_,l:(_binop|_unop),r:(_binop|_unop)] :> 
	        (acc=Union[acc,{{x=newName[sys,lhs],l},{y=newName[sys,lhs],r}}];binop[op,x,y]),
        binop[op_,l:(_binop|_unop),r:_] :> 
		(acc=Append[acc,{x=newName[sys,lhs],l}];binop[op,x,r]),
        binop[op_,l:_,r:(_binop|_unop)] :> 
		(acc=Append[acc,{y=newName[sys,lhs],r}];binop[op,l,y]),
        case["",l:(___?(!MatchQ[#,complexExpr]&)),m:complexExpr,r:___] :>
		(acc=Union[acc,{{x=newName[sys,lhs],m}}];case["",l,x,r]),
        use[op_,l:(___?(!MatchQ[#,complexExpr]&)),m:complexExpr,r:___] :>
		(acc=Union[acc,{{x=newName[sys,lhs],m}}];use[op,l,x,r]),
        use[op_,l:{___}] :> Flatten[use[op,l],1,List],
        unop[op_,l:(_binop|_unop)] :> 
	        (acc=Append[acc,{x=newName[sys,lhs],l}];unop[op,x]),
        reduce[op_,l:(_binop|_unop)] :> 
	        (acc=Append[acc,{x=newName[sys,lhs],l}];reduce[op,x])
	       };
   temp = {lhs,rhs}//.flr;
   {temp,acc}
(*   {{lhs,temp[[1]]},temp[[2]]} *)
];


(* Schematics draws the schematics of an Alpha program *)
Clear[schematics];
schematics[ opts:___Rule ]:=schematics[ $result, opts ]; (* Default option *)
schematics[ sys:_system, opts:___Rule ]:=
Catch[
Module[{ sk, vars, positions, varNumber, offset, yfactor, opNumber, sp,
        nbColumns, nbRows, sk1, minCol, maxCol, minRow, maxRow,
        varTables, outputTable, funcAux, minx, maxx, miny, maxy, 
        ps },
  ps = partShown/.{opts}/.Options[schematics];
  sp = sPositions/.{opts}/.Options[schematics];
  yfactor = yFactor/.{opts}/.Options[schematics];
  fs = fSize/.{opts}/.Options[schematics];

  (* Auxiliary function. Draws a vertical line, for variable name var,
	at position pos. The x coordinate of the ith line is 1+i*offset *)
  drawLine[{var:_,pos:_}]:=
	{
	  Line[{{1+pos*offset,yfactor},
               {1+pos*offset,(nbRows+1)*yfactor}}],Red,
	  Text[var,{1+(pos-0.3)*offset,yfactor},{0,1},{0,-1},
		TextStyle->{FontSize->(fs/2)}]
	};

	(* Compute the flattened skeleton of $result *)
	sk = flattenSkeleton[sys];

	(* Get the list of variables of $result, union the new 
	   variables introduced in the skeleton *)
	vars = Union[getVariables[sys],Map[First,sk[[2]]]];

	(* Number of variables *)
	varNumber = Length[vars];

	(* Number of operators in the skeleton *)
	opNumber = Length[sk[[2]]];

	(* Create a table of positions for the operators. By default,
	   these positions are all {1,n}, meaning that we draw a vertical
	   stack of operators. 
           If the sPosition option has been used, this option is a 
           list of pairs {x,y}, each one corresponding to a position
           in a virtual grid. This list must have as many elements 
           as operators. Subject to changes, when the position 
           parameter will be computed automatically *)
	positions = 
          Which[ 
            sp === Null, 
              Table[{1,i},{i,1,opNumber}],
            MatchQ[sp,l:{{_Integer,_Integer}..}/;Length[l]===opNumber],
              sp,
            sp === square, 
            Module[{rac},
              rac = Ceiling[Sqrt[opNumber]];
              Take[
                Flatten[Table[{i,j},{i,1,rac},{j,1,rac}],1],
                opNumber
              ]
            ],
            MatchQ[sp,{Alpha`Schematics`columns->_Integer?Positive}],
            Module[{col,row},
              col = sp[[1]][[2]]; row = Quotient[opNumber,col]+1;
              Take[
                Flatten[Table[{i,j},{i,1,col},{j,1,row}],1],
                opNumber
              ]
            ],

            True,
              Print["Warning: error in the sPositions parameter."];
              Print["Default vertical stacking presentation used."];
              Table[{1,i},{i,1,opNumber}]
          ];

	(* Compute the offset between successive lines, for drawLine *)
	offset = (offsetX/.{opts}/.Options[schematics])*0.5/(varNumber+1);

        (* Compute the operators, column by column *)
        (* Number of columns *)
        nbColumns = With[ {m=Map[ First, positions ]},
                          minCol = Min[m]; maxCol = Max[m];
                          maxCol-minCol ];

        (* Number of rows *)
        nbRows = With[ {m=Map[ Last, positions ]},
                          minRow = Min[m]; maxRow = Max[m];
                          maxRow-minRow ];

        (* *)

        (* Order the operators column by column *)
        sk1 = Transpose[{sk[[2]],positions}];
        columns = 
          Table[ 
            Select[sk1, First[Last[ # ]]===i&],
            {i,minCol,maxCol}
          ];
        (* Find out the list of internal signals inputs of 
           each column *)
        (* The following statement returns a list, whose i-th
           entry is the list of input signals of the operators
           of the i-th column of operators. But first, we 
           define an auxiliary function for the Map *)
        funcAux[x:_]:=
          With[{temp = Last[ First [x] ]},
            Apply[ List,
                 If[ Length[temp]>1, Drop[ temp, 1 ], x ] ]
          ];
        varTables = 
          Map[ 
            Map[ funcAux, # ]&, 
            columns ];

        (* Union each entry *)
        varTables = 
          Map[ Apply[Union,#]&, varTables ];
        (* Discard input of the system *)
        varTables = 
          Map[ Complement[ #, getInputVars[] ]&, varTables ];
        (* Index varTables *)
        varTables = 
          Map[ Table[ {#[[i]],i}, {i,1,Length[#]} ]&, varTables ];

        (* Create a table of positions for each output of 
           an operator *)
        outputTable = Apply[ Union, columns ];
        outputTable = Map[ {First[First[#]],Last[#]}&, outputTable];

	(* Map schematics over operators *)
	schema = Union[
                {},
	        MapThread[
                  schematics[#1,#2,varTables,outputTable,opts]&,
                  {sk[[2]],positions}
                ]
	     ];

        (* Compute range *)
        minx = minCol; maxx = maxCol+1.5;
        miny = (minRow)*yfactor-0.1; maxy = (maxRow+1)*yfactor+0.3;
        Module[{psx, psX, psy, psY},
          Which[ 
            ps === Automatic, 
            Show[Graphics[schema],AspectRatio->Automatic],
            MatchQ[ps,{{_Real,_Real},{_Real,_Real}}],
              {{psx, psX}, {psy, psY}} = ps;   
              Show[Graphics[schema],AspectRatio->Automatic,
                   PlotRange->{{maxx*psx,maxx*psX},
                               {maxy*psy,maxy*psY}}],
            True,Print["Error in the partShow option. Default value assumed."];
            Show[Graphics[schema],AspectRatio->Automatic]
          ]
        ]
      ]
];

(* Draws the schematics of one operator *)
schematics[ {lhs:_,exp:_}, 
            {x:_Integer,y:_Integer}, 
            varTable:_, 
            outputTable:_,
            opts:___Rule ]:=

Module[{deltax = offsetX/.{opts}/.Options[schematics],
	deltay = offsetY/.{opts}/.Options[schematics],
	yfactor = yFactor/.{opts}/.Options[schematics]},
        fs = (fSize/.{opts}/.Options[schematics])*(1-deltax)*2;
	{
	  (* draw the box *)
	  box[x,y,exp,varTable[[x]],outputTable,opts],
	  (* draw the icon inside the box *)
	  drawIcon[x,y,deltax,deltay,yfactor,exp,fs],
	  (* add the name of the output var *)
	  Text[lhs,{x+1-deltay,(y+0.7)*yfactor},{-1,0},
	      TextStyle->{FontSize->fs/2}],
          (* Draw output line *)
          Line[{{x+1-deltay,(y+0.5)*yfactor},{x+1,(y+0.5)*yfactor}}],
          If[ MemberQ[ getOutputVars[], lhs ],
            {Green,anchor[x+1-0.04,(y+0.5)*yfactor,0.1*yfactor],Black},
            {}
          ]
	 }
    ];
schematics[x:___]:=
(*Print["schematics called with parameters: ", x];*)
Message[schematics::params];
schematics::params="wrong parameters";

(* This function draws an input or output icon, at 
   position x,y, with size s *)
Clear[anchor];
anchor::params = "parameter error";
anchor[ x:_Real, y:_Real, s:_Real]:=
  {
   Polygon[{{x,y-s},{x+s,y-s},{x+2s,y},{x+s,y+s},{x,y+s},{x,y}}]
  };
anchor[___]:= Message[anchor::params];

(* 
   This function draws an operator at virtual position 
   x, y. 

   To understand how all this works, some explanations are
   needed. An operator at position x, y is drawn in a
   rectangle whose bottom-left corner has position 
   x, y*yFactor. yFactor is an option of schematics, and
   allows the form factor of the schematics to be changed.
   Inside the box of the operator, a band of coordinates
   0<=x<=offsetX is devoted to vertical rails for interconnecting
   the inputs of the operators. The offsetX option must be
   between 0 and 1. The second part of the band is devoted
   to drawing the operator. Similarly, the part of the box
   with coordinates 0<=y<=offsetY is devoted to horizontal 
   rails for connecting outputs.

   box has a varTable as a parameter, to 
   find out the end point of its input argument connections.
   A varTable is a list of entries {A,number} where 
   A is an input argument, and number is the rank of this
   argument. This rank is used to find out the vertical
   rail of this argument. 

   box has also an outputTable as parameter, which contains
   the position of the operators which produce symbols.

   An input argument of the operator which is also an 
   input of the system is shown as an anchor (filled polygon)
   placed at abscissa x+offsetX*0.8 . Other input arguments are 
   shown as dots placed at abscissa between x and x+offsetX*0.5,
   depending on the rank of the input in the varTable.

*)
Clear[box];
box[x:_Integer,y:_Integer,exp:_,varTable:_,outputTable:_,opts:___Rule]:=
Module[{deltax = offsetX/.{opts}/.Options[schematics],
 	deltay = offsetY/.{opts}/.Options[schematics],
	yfactor = yFactor/.{opts}/.Options[schematics],
	xoffset},
  yoffset = deltay*0.5/(Length[outputTable]+1); (* offset of output lines *)
  xoffset = deltax*0.5/(Length[varTable]+1); (* offset of input lines *)

(* Auxiliary function which draws one input. Parameters
   are the label s of the input, and the yposition *)
  Clear[ drawOneInput ];
  drawOneInput[s:_,ypos:_]:=
    Module[
      {i, temp1, temp2, output, j},

      (* get the rank of symbol s in varTable *)
      i = First[First[Position[varTable,s]]];

      (* compute the graphics needed for the input *)
      temp1 = 
        Which[
          MemberQ[getInputVars[],s],
          {
           Line[{
             {x+deltax*0.8,(y+ypos)*yfactor},
             {x+deltax,(y+ypos)*yfactor}}],
           Blue,anchor[x+deltax*0.8,(y+ypos)*yfactor,0.1*yfactor],Black
          },
          i=!={},
          {Text["\[FilledSmallCircle]",{x+i*xoffset,(y+ypos)*yfactor},
                TextStyle->{FontSize->fs/2}
               ],
           Line[{
             {x+i*xoffset,(y+ypos)*yfactor},
             {x+deltax,(y+ypos)*yfactor}}]},
          True, {}
        ]; (* Which *)

      (* Now, we draw the connection to the input *)
      output = Select[ outputTable, First[#]===s& ];
      temp2 = 
        If[ output === {}|| i==={}, 
          {}, 
          Module[{xo,yon,j},
            j = Position[ Map[First,outputTable], s ][[1]][[1]];
            xo = First[Last[First[output]]];
            yo = Last[Last[First[output]]];
            {Red,
            Line[{
              {x+i*xoffset,(y+ypos)*yfactor},
              {x+i*xoffset,(yo+j*yoffset)*yfactor},
              {xo+1,(yo+j*yoffset)*yfactor},
              {xo+1,(yo+0.5)*yfactor}
            }],Text["\[FilledSmallCircle]",{xo+1,(yo+0.5)*yfactor},
                    TextStyle->{FontSize->fs/2}],Black
            }
          ]
        ];
      temp = Join[
        temp2,
        temp1,
        {Text[s,{x+deltax-0.01,(y+ypos+0.1)*yfactor},
              {1,0},TextStyle->{FontSize->fs/2}]}
      ]; (* Join *)
      temp
   ]; (* Module *)

  Clear[drawInputs];
  drawInputs[binop[op:_,s1:_,s2:_]]:=
	{drawOneInput[s1,0.3],drawOneInput[s2,0.7]};
  drawInputs[unop[op:_,s:_]]:=
	{drawOneInput[s,0.5]};
  drawInputs[reduce[op:_,s:_]]:=
	{drawOneInput[s,0.5]};
  drawInputs[case["",s1:_,s2:_]]:=
	{drawOneInput[s1,0.3],drawOneInput[s2,0.7]};
  drawInputs[(if|mux)["", c:_,s1:_,s2:_]]:=
	{drawOneInput[s1,0.25],drawOneInput[s2,0.5],drawOneInput[c,0.75]};
  drawInputs[use[op_,args:___]]:=
    With[{l=Length[{args}]},
        Table[drawOneInput[{args}[[i]],i/(l+1)],{i,1,l}]
    ];
  drawInputs[case["",args:___]]:=
    With[{l=Length[{args}]},
        Table[drawOneInput[{args}[[i]],i/(l+1)],{i,1,l}]
    ];
  (* This corresponds to a simple connexion *)
  drawInputs[s:_]:={drawOneInput[s,0.5]};

(* Body of box *)
  If[ !MatchQ[ exp, _String ]&&!MatchQ[ exp, unop[connexion,_] ],
        {
	 (* Draw box *)
	 Line[{{x+deltax,(y+deltay)*yfactor},
	       {x+1-deltay,(y+deltay)*yfactor},
	       {x+1-deltay,(y+1-deltay)*yfactor},
	       {x+deltax,(y+1-deltay)*yfactor},
	       {x+deltax,(y+deltay)*yfactor}}],
	 drawInputs[exp]
	},
    {drawInputs[exp]}
  ]

];
box[___]:=Message[box::params];

Clear[drawIcon];
drawIcon[x:_Integer,
         y:_Integer,
         deltax:_Real,
         deltay:_Real,
         yf:_Real,
         binop[op:_,_,_],fs:_]:=
	{Red,Text[icon[op],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         if[___],fs:_]:=
	{Blue,Text[icon[if],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs*.75}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         mux[___],fs:_]:=
	{Blue,Text[icon[mux],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs*.75}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         case["",__],fs:_]:=
	{Blue,Text[icon[case],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs*.75}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         use[name:_,__],fs:_]:=
	{Blue,Text[name,{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs*.5}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
        unop[connexion,___],fs:_]:=
	{Black,Text[icon[connexion],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs}],
         Line[{{x+deltax,(y+0.5)*yf},{x+1,(y+0.5)*yf}}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         unop[reg,exp:_],fs:_]:=
	{Red,Text[icon[reg],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         unop[op:_,_],fs:_]:=
	{Red,Text[icon[op],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
         reduce[op:_,_],fs:_]:=
	{Blue,Text[iconReduce[op],{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
	TextStyle->{FontSize->fs}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,yf:_Real,
        _String,fs:_]:=
	{Black,(* Text["=",{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
         TextStyle->{FontSize->fs}] *)
         Line[{{x+deltax,(y+0.5)*yf},{x+1,(y+0.5)*yf}}]};
drawIcon[x:_Integer,y:_Integer,deltax:_Real,deltay:_Real,
         yf:_Real,u:_,fs:_]:=
	Text["?",{x+deltax/2+0.5-deltay/2,(y+0.5)*yf},
        TextStyle->{FontSize->fs}];
drawIcon[___]:=Message[drawicon::params];


Clear[icon];
icon[if]:="if";
icon[mux]:="mux";
icon[reg]:="reg";
icon[sqrt]:="\[Sqrt]";
icon[mul]:="\[Times]";
icon[use]:="use";
icon[add]:="+";
icon[sub]:="-";
icon[neg]:="-";
icon[div]:="\[Divide]";
icon[case]:="case";
icon[not]:="not";
icon[or]:="or";
icon[and]:="and";
icon[xor]:="xor";
icon[connexion]:="\[RightTeeArrow]";
icon[Alpha`equal]:="= or reg";
icon[_]:="?";

Clear[iconReduce];
iconReduce[add]:="\[Sum]"
iconReduce[mul]:="\[Product]"
iconReduce[or]:="\[Or]"
iconReduce[and]:="\[And]"
iconReduce[_]:="?";
End[];
EndPackage[]

