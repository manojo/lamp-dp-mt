(* file: $MMALPHA/lib/Package/Uniformization.m
   AUTHOR :Manjunathaiah. M  
             University of Reading, U.K.
           and  Tanguy Risset
             IRISA, France
	     
	     The support provided by EPSRC grant "SARACEN"
	     (No. GR/K95413) and franco British collaboration 
	     grant "Remit" (No. PN 97.093) is acknowledged
	     in the developpement of this package


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

BeginPackage["Alpha`Uniformization`", {"Alpha`Domlib`",
				 "Alpha`",
				 "Alpha`Options`",
				 "Alpha`Matrix`",
				 "Alpha`Tables`",
				 "Alpha`UniformizationTools`",         
				 "Alpha`Semantics`",
				 "Alpha`Substitution`", 
				 "Alpha`Normalization`",
				 "Alpha`Properties`",
				 "Alpha`Static`",
				 "Alpha`Pipeline`",
				 "Alpha`Zpol`"}]


Uniformization::usage= "Package. Unifomization of
 system of affine recurrence equations. 
The uniformization implemented here assumes that
   the system is fully indexed and only computation equations
   are passed to any uniformization function"

(* two categories of procedures *)

(* first category : transformations of dependences *)

(* choosing appropriate transformation *)
getDependences::usage = "getDependences[sys_]. Return the list of
non-uniform dependences."
whichRule::usage = "whichRule[sys_, dep_]. checks which rule should be
used for uniformization: local
uniformity, pipelining, routing, of the dependence \" dep \". the
dependence \" dep \" is written in the format of the result of the
dep[]
function
"

(* pipelining *)
getPipeVecs::usage = "getPipeVecs[ dep_]. returns a list of possible 
pipeline vectors for the pipelining of dependence \" dep \".  the
dependence \" dep \" is written in the format of the result of the
dep[] function"

pipeDep::usage = "pipeDep[sys_, dep_, pipevec_List]. returns a new system
after uniformizing dependence \" dep \" with the pipeline vector \"
pipevec \". the
dependence \" dep \" is written in the format of the result of the
dep[] function
"

(* routing *) getRouteVecs::usage = "getRouteVecs[sys_, dep_]. returns
a list of routing vectors and the routing coefficients for the routing
of dependence \" dep \".  the dependence \" dep \" is written in the
format of the result of the dep[] function "

 routeDep::usage =
"routeDep[sys_, dep_, route_]. returns a new system 
 after uniformizing dependence \" dep \" with the routing
decomposition \" route \". the structure of route is the one returned
by the getRouteVecs function"

(* input equation *)
alignInput::usage = " alignInput[sys_, dep_]. returns a
new system after uniformizing the dependence \" dep \" with an input
equation. the dependence \" dep \" is written in the
format of the result of the dep[] function"

(* local uniformity *)
uniformizeLocal::usage = "uniformizeLocal[sys_, dep_]. returns a new
system after re-writing the index mapping for dependence \" dep\" in
such a way that it is uniform." 

(* second category : consistency checking procedures *)
initUniformization::usage = "initUniformization[sys_]. initializes the
system dependence cone and verifies if the cone is pointed. Outputs
the extremal rays of the cone (list of list)."

verifyPipe::usage="verifyPipe[dep_, pipevec_]. checks if the
  dependence cone of \" dep\" and the chosen vector \" pipevec\" are pointed
  (necessary condition) and also if it is consistent with the current
 system cone  (sufficient condition)."


verifyRoute::usage = "verifyRoute[sys_, dep_, route_]   checks if the
  dependence cone of \" dep \" and the chosen vectors \" route \" are pointed
  (necessary condition) and also if it is consistent with current system cone 
  (sufficient condition)."  



(* dependence related functions *)
depCone::usage = "depCone[depast_]. returns the data dependence cone of
the dependence depast in Alpha domain format. The dependence cone is ...."

(* automatic transformations *)
uniformize::usage = "uniformize[sys_,dep_]. Attempts
to uniformize dep in  \" sys\" . The dependence \" dep \" is written in the
format of the result of the dep[] function"

callUniformize::usage = "callUniformize[file_String,options]. Loads 
a system of equations from the `file'  
 and invokes
uniformization routine  with default options. The uniformized system is written
back to a file named file.URE."

(* messages *)
Begin["`Private`"] 
verifyRoute::invalid = "Choice of vectors `1` is invalid. Given vector
and dependence cones are not pointed. "
verifyPipe::invalid = "Choice of vectors `1` is invalid. Given vector
and dependence cones are not pointed. "
uniformize::dcomp = "routing decomposition not possible for this dependence."
initCone::msg = "Initialized system dependence cone. Cone is pointed with extremal rays `1` "
initCone::invalid = "System dependence cone  is not pointed and has lines `1` "
checkTimeCone::valid = "Choice of vectors `1` valid "
checkTimeCone::invalid = "Choice of vectors `1` is invalid. System timing
cone is not pointed."
extendSysIndex::req = "Routing transformation Failed for variable `1`. The
equation defined by `2` and (possibly the entire system)
requires an additional index."





(* made global for debugging*)
checkTimeCone::usage="checkTimeCone[depCone, vecs]. Not to be used directly";
applyRule1::usage="empty"
applyRule2::usage="empty"
applyRule3::usage="empty"
applyRule4::usage="empty"
addRaysToCone::usage="empty"
getIntBasis::usage="empty"
depVec::usage="empty"
depDomain::usage="empty"
showDepCone::usage="empty"
pipeVecs::usage="empty"
routeVecs::usage="empty"
unimodularBasis::usage="empty"
unimodularCone::usage="empty"
checkVecInLinSpace::usage="empty"
usePipeIO::usage="empty"
affTransMat::usage="empty"
localUniformQ::usage = "empty"
alignInputQ::usage="empty"
getUniformizationVecs::usage = "getUniformizationVecs[dep_,intbasis_]. 
Returns a list of uniformizing vector "
uniformdomQ::usage = "uniformdomQ[dep_, dom_] applies a series
of tests to check if the dependence is uniform within a given domain(local uniformity)"
pointedConeQ::usage = "pointedConeQ[_Matrix] Returns True if the cone
defined by Matrix is pointed and false otherwise "
updateSysCone::usage = "empty"
initCones::usage = "empty"


Clear[dropConst];
(* drop the constant part and return the indexing matrix *)
dropConst[mat_] := Return[Drop[Map[Drop[#, -1]&, mat], -1]];
(* get the constant part as a vector *)
getConst[mat_] := Return[Flatten[Drop[Map[Take[#, -1]&, mat], -1]]];

Clear[addRaysToCone];
(* add the trays to dcone. vecs are specified in list format *)
addRaysToCone[trays_, dcone_] := Module[
{indi,mats, tcone},
  tcone=dcone;
  (* cast rays into alpha matrix format for DomAddRays *)
  mats = Alpha`matrix[Length[trays]+1,
	                   Length[trays[[1]]]+2,
			   tcone[[2]],
			   Append[
			     Map[Append[Prepend[#,1],0] &,
				 trays],
			     Append[
			       Table[0,{i,1,Length[trays[[1]]]+1}],1]]];

  (* add the rays to the dcone *)
  Return[DomAddRays[tcone,mats]];
]


Clear[idempotentQ];
idempotentQ[depast:Alpha`depend[adom_,_,_,adep_,_]] :=
  idempotentQ[dropConst[adep[[4]]]];

idempotentQ[depmat_] := depmat === depmat.depmat;

Clear[pointedConeQ];
pointedConeQ[cone_] := Block[{sol},
  sol = NullSpace[cone];
  If[sol === {}, Return[True],
     Return[MemberQ[Map[FreeQ[#, x_ /; x < 0]&, sol], True] != True]
  ]
]

Clear[showDepCone];
(* works only for dimension of domain < 2 *)
showDepCone[depast_Alpha`depend] := Module[{dcone},
 dcone = DepCone[depast];
 Return[Show[GraphicsArray[{showDomain[depDomain[depast], "range"],
		     showDomain[dcone, "cone"]}], PlotLabel ->show[dtable[{depast}], silent -> True] ]];
]

Clear[depDomain]
(* compute the range of dependence *)
depDomain[depast:Alpha`depend[adom_,_,_,depmat_,_]] :=
  Module[{indi,dvec, theta, range},
  (* get dependence vector  *)
  dvec = depVec[depast];
  (*  compute the range  as the
     image of adom under affine transformation theta *)
  (* first construct the affine transformation matrix : theta *)
  theta = mmaToAlphaMatrix[dvec[[1]], dvec[[2]]];
  (* compute the convex polytope image under theta *)
  (* insert the indices *)
  theta = ReplacePart[theta,adom[[2]],3];
  range = DomImage[adom, theta];
  Return[range];
]


Clear[depCone];
depCone[depast:Alpha`depend[adom_,_,_,adep1_,_]]:=
  Module[{range,dcone,verticesAndRays},

  (* compute the range of  theta *)
  range = depDomain[depast];

  (* next construct a cone from vertices and rays of range *)
  (* start with an empty domain *)
  dcone = DomEmpty[adom[[1]]];
  (* add the index names *)
  dcone = ReplacePart[dcone, adom[[2]], 2];
  (* collect all the vertices and rays of range *)
  verticesAndRays = Union[getVertices[range],rays[range]];
 (* BUG:  DomSimplify added by Tanguy because 
   of a bug  which is apparently in DomAddRays *)
  Return[DomSimplify[addRaysToCone[verticesAndRays, dcone],
		   DomUniverse[adom[[1]]]]];
]


Clear[hasLinesQ];

(* check if the domain has lines *)

hasLinesQ[domain[_,_,pl_]] := pl[[1]][[4]] > 0;

Clear[pipeVecs]
(* compute a new basis which contains the dependence cone *)
pipeVecs[depast:depend[dom_,lhs_,rhs_,dep_,_], intbasis_] :=
  Module[{dcone, conebasis, dmat, bmat,vecs, trays},

  (* if cone is included in intbasis, then return rays of cone as
     pipeline vectors *)
  dcone = depCone[depast];
  If [ properSubspaceQ[domainBasis[dcone], intbasis] === True,
       Return[rays[dcone]]];

  (* else, ensure that the cone is pointed with intbasis *)
  vecs = getBasis[intbasis];
  trays = rays[dcone]; 
 
  (* ensure that the pipeline basis and the dependence cone are pointed *)
  (* init matrix *)
  bmat = trays;
  Do[ (bmat = Append[bmat, vecs[[i]]];
      If [pointedConeQ[Transpose[bmat]]  === True,
        bmat,
        (* else, last row is multiplied by -1 *)
        bmat= ReplacePart[bmat, -1(Last[bmat]), -1];
      ]),
      {i, Length[vecs]}
     ];
  (* return the last k rows as the new basis (pipelining vectors) *)
  Return[Take[bmat, -(Length[vecs])]];  
]

Clear[makeStr];

makeStr[indi_] := Block[{v1,v2},
  v1= Map[ToString, indi];
  v2 = Outer[List, v1, {","}];
  v2 = Flatten[v2];
  Return[StringDrop[StringJoin[v2], -1]];
]

(* obsolete : using MMalpha's pipeline package *)
Clear[genPipeSubsystem];
(* construct pipeline equations explicitly *)
genPipeSubsystem[depast:Alpha`depend[dom_, lhs_, rhs_, dep_,_], pipe_]:= genPipeSubsystem[$result, depast, pipe];

genPipeSubsystem[sys_, depast:depend[dom_, lhs_, rhs_, dep_,_], pipe_]:= Module[
{alpha,phi,indi,d1,d2,tmat,amat,rvar},
       
  indi = dom[[2]];
  (* compute the translation matrix   T(I) = I + pipe *) 
  tmat = IdentityMatrix[Length[indi]];
  (* add the pipeline vector as a translation *)
  tmat = Transpose[Append[tmat, pipe]];
  (* make an alpha matrix *)
  lastrow = Append[Table[0, {Length[indi]}], 1];
  (* add the last row *)
  tmat = Append[tmat, lastrow];
  amat = Alpha`matrix[Length[indi]+1, Length[indi]+1,
                            indi,
                            tmat];
  (* compute the two domains *)
  (* d1 is an affine transformation of dom *)
  d1 = DomImage[dom, amat];
  (* pipeline should occur only  within the computation domain *)
  d1 = DomIntersection[dom, d1];
  (* domain where input to the pipeline occurs  *)
  d2 = DomDifference[dom,d1];
  (* construct the two equations *)
  rvar = getNewName[sys, ToString[Unique[rhs]]];
  newdep = Append[Transpose[Append[IdentityMatrix[Length[indi]], -pipe]],lastrow];
  newdep =  Alpha`matrix[Length[indi]+1, Length[indi]+1,
                            indi,
                            newdep];
  (* pipeline equation *)
  eqn1 = Alpha`equation[rvar, 
               Alpha`restrict[d1, 
                       affine[Alpha`var[rvar],newdep]]];

  (* input to the pipeline *)
  eqn2 = Alpha`equation[rvar, 
                  Alpha`restrict[d2, 
                       affine[Alpha`var[rhs],
                       dep]]];

  Return[{eqn1,eqn2}];
]

(* obsolete : using MMAlpha's pipeline package *)
Clear[pipeVar];
pipeVar[sys_, depast:depend[dom_,lhs_,rhs_,adep_,_], pvect_] := Module[
{asys, psys,  rpos, rexp, eqn1,eqn2,eqndom},

  (* generate pipeline equations *)
   subsys = genPipeSubsystem[depast, pvect];

  (* insert subsystem into AST *)
  eqn1 = subsys[[1]];
  eqn2 = subsys[[2]];
  eqndom = dom;

  (* modify  the original equation *)
   rpos = getOccursInDef[sys, lhs, affine[var[rhs],adep],1]; 
   rexp = getPart[sys, rpos];
   (* change the index mapping *)
   rexp =  ReplacePart[rexp, IdentityMatrix[rexp[[2,1]]], {2,4}];
   (* change the variable name *)
   rexp = ReplacePart[rexp, eqn1[[1]], {1,1}];

  (* replace the rhs expression, insert a declaration and the eqns  *)
  (* todo: type of variable has to be fixed to type of the rhs. Also 
     depend function should return a position paramter to take care of
     multiple rhs definitions in seperate equations.
  *)
  (* construct a composite equation for the pipeline subsystem *)
  psys = Alpha`equation[eqn1[[1]],
           Alpha`case[ {
             Alpha`restrict[eqn2[[2,1]],Alpha`affine[eqn2[[2,2,1]],eqn2[[2,2,2]]]],
             Alpha`restrict[eqn1[[2,1]],Alpha`affine[eqn1[[2,2,1]],eqn1[[2,2,2]]]]
        }]];
  
  (* update the syntax tree *)
  asys = Insert[Insert[ ReplacePart[sys, rexp, rpos],
          Alpha`decl[eqn1[[1]], Alpha`integer, eqndom], {5,1}],
          psys, {6,1}];

  Return[asys];

]


Clear[usePipeall];
usePipeall[asys_, depast:depend[dom_,lhs_,rhs_,depMat_,_], pvect_] := 
  Catch[
  Module[
  {rpos, rexp, pexp, pvar, pipexpr, indi, pipespec},
   (* make the string to pass to pipeline command *)

   rexp = Alpha`affine[Alpha`var[rhs],depMat];

   (* create the pipeline expression *)
   pexp = translationMatrix[rexp[[2]][[3]], pvect];
   pvar = getNewName[asys, ToString[Unique[rhs]]];
   pipexpr = affine[var[pvar], pexp];
   
  (* and  invoke pipeline command  *)
  Return[pipeall[asys, lhs, rexp, pipexpr]];

  (* make a string  
  indi = rexp[[2]][[3]];
  pipespec = StringJoin[pvar, ".(" <> makeStr[indi] <> "->" <> makeStr[indi+pvect] <> ")" ];
  pipeline[rpos, pipespec];
  *)
  ]
]

usePipeall[a___]:=Message[usePipeall::WrongArg,a];


Clear[getPipeVecs];

getPipeVecs[depast:depend[dom_,lhs_,rhs_,dep_,_]] :=
  Module[{vecs, intbasis},

  (* get the pipeline vectors *)
  intbasis = getIntBasis[depast];
  (* check with dependence cone *)
  Return[pipeVecs[depast,intbasis]];
]


Clear[pipeDep];
(* updates the syntax tree with pipeline subsystem *)
pipeDep[depast:depend[___], pipe_, options___Rule] :=   
  Catch[
  Module[
  {sys,tmp},
  sys = $result;
  tmp = pipeDep[sys, depast, pipe, options]; 
  If [tmp =!= Null,
      (Alpha`$program = Alpha`$result;
       Alpha`$result = tmp),
       Null ];
  ];
]

(* returns a new system agumented with pipeline equations *)
pipeDep[asys_, depast:depend[___], pipe_, options___Rule] := 
  Catch[
  Module[
  {tmpsys, optVerb, optVerf},
  optVerb = verbose/.{options}/.Options[uniformize];
  optVerf = verifyCone/.{options}/.Options[uniformize];

  If [optVerb,
    Print["Pipelining dependence "];
    show[dtable[{depast}]];
    Print[" with vector ",  pipe];
  ];

  tmpsys = usePipeall[asys, depast, pipe]; 
  (* update dependence cone *)
  If[ optVerf, updateSysCone[depast, {pipe}]];
  Return[tmpsys];
 ];
]

Clear[unimodularBasis]

(* returns a unimodular extension of the extremal rays of dcone *)
unimodularBasis[dcone_, options___Rule] := Block[
  {erays, optDbug},
  erays = rays[dcone];
  (* todo: might need to check if determinant is positive *)
  optDbug = debug/.{options}/.Options[uniformize];
  If [optDbug,
    Print["rays : ", rays[dcone], ", erays : \n",
	  Take[unimodCompl[erays], Length[erays]]];
    ];
  Return[Take[unimodCompl[erays], Length[erays]]];
]

(* returns a cone  which includes the input cone. The
   extremal rays of the resulting cone form a unimodular basis *)
Clear[unimodularCone];
(* compute a cone which include dcone and whose rays form a unimodular basis *)
unimodularCone[dcone_] := Module[{urays,ucone},
  (* get a unimodular cone *)
  urays = unimodularBasis[dcone];
  (* start with an empty domain and add the index names *)
  ucone = DomEmpty[dcone[[1]]];
  ucone = ReplacePart[ucone, dcone[[2]], 2];
  (*  add the rays to the empty domain*)
  ucone = addRaysToCone[urays, ucone];
    
  Return[ucone];
]

Clear[routeVecs];
routeVecs[depast:depend[dom_,lhs_,rhs_,dep_,_], options___Rule] := 
  Catch[
  Module[{  dcone,  erays, theta, alphas, routes},
  (* compute the routing coefficients by solving : \Phi . x = \theta *)
  (* start with the dependence cone *)
  dcone = depCone[depast];
  (* find a unimodular extension of dcone *)
    
  erays = unimodularBasis[dcone, options];
  (* compute theta *)
  theta = depVec[depast];
  (* and we have the coefficients *)
  alphas = Check[LinearSolve[Transpose[erays],
				  theta[[1]].dom[[2]]+theta[[2]]], 
      Throw[(Message[uniformize::dcomp];Null)]];

  (* and the routing vectors *)
  routes = MapThread[{#1, #2} &, {alphas, erays}];
  (* next check that the  routing vector are not in lin(D)
     decompose them if they are *)
  routes = checkVecInLinSpace[depast, routes];
  (* return the routing vectors and the dependence cone *)
  Return[routes];
       ]
]

Clear[extendSysIndex];


extendSysIndex[depast:depend[dom_,lhs_,rhs_,adep_,_], rin_] := Module[
{nvecs},
  Message[extendSysIndex::req, rhs,lhs];
]

Clear[checkVecInLinSpace];

(* If routing vector belongs to lin(D), decompose it using vectors in 
   nullspace of lin(D). If nullspace is empty then inform the user
   to add another dimension to the dependence and re-index the system *)

checkVecInLinSpace[depast:depend[dom_,lhs_,rhs_,adep_,_], rvecs_] :=  Module[
{domb,  nvecs, nalpha, nvect, rvectors},

  (* decompose vectors in lin(D) using vectors not in lin(D) *)
  decomposeRoute[rin_, nvec_] := Block[{dummy},
    nalpha = nalpha + rin[[1]];
    Return[{rin[[1]], rin[[2]] - nvec}];
       
  ];

  (* decompose  rvecs that are in lin(D) *)

  (* first compute basis vector in orthogonal space of lin(D) *)
  nalpha = 0;
  domb = domainBasis[dom];
  (* compute vectors in the orthogonal subspace of lin(D) *)
  nvecs = NullSpace[getBasis[domb]];

  (* check if re-indexing is required *)
  If[((Length[nvecs] == 0) && (Length[Map[vecInBasisQ[#[[2]], domb]&, rvecs]] > 0)) === True,
     (* routing is possible only with an extended system *)
     Return[extendSysIndex[depast, rvecs]],
     ( (* use first vector from the nullspace of lin(D) *)
       nvect = nvecs[[1]]; 
       (* ensure the choice forms  a pointed cone *)
       If [pointedConeQ[
        Transpose[Append[Cases[rvecs, {c_,r_}:>r], nvect]]]  === True,
         nvect,
         (* else, choose negative of nvecs as the routing vector *)
         nvect = -(nvect)
       ]
     )
  ];  

  (* decompose the route vectors using null space vectors *)
  rvectors = Map[If[vecInBasisQ[#[[2]], domb],
                   (nalpha = nalpha + #[[1]];
                   (*  decomposition using null space vector *)
                    {{nalpha, nvect},{#[[1]], #[[2]] - nvect}}
                   ),
                   {#}
                 ] &, rvecs];

  Return[ Flatten[rvectors,1]];
]

(* this decomposition method is based on Patrice's paper: but it
won't work for the example in the paper !. The decomposition
given in paper seems to be incorrect *)

checkVecInLinSpaceOld[rvecs_, depast:depend[dom_,lhs_,rhs_,adep_,_]] :=  Module[
{domb, len1, len2, routesinlin, routesoutlin, nvecs},

  (* decompose vectors in lin(D) using vectors not in lin(D) *)
  decomposeRoutes[rin_, rout_] := Block[{routvec, alpha, newrins},
    (* choosing the first vector as default *)
    routvec = rout[[1]];
    (* decompose all rins in terms of routvec *)
    alpha = routvec[[1]];
    newrins = Cases[rin, {c_,r_}:> {c,r - routvec[[2]]}];
    alpha = alpha + Apply[Plus,Cases[rin, {c_,r_}:> c]];
    (* replace the first rout with the new routvec *)
    Return[Join[Append[newrins,{alpha, routvec[[2]]}], Rest[rout]]];
       
  ];

  (* partition the rvecs into routes in lin(D) and  not in lin(D)   *)
  domb = domainBasis[dom];
  routesinlin  = Select[rvecs, vecInBasisQ[#[[2]], domb] &];
  routesoutlin = Select[rvecs, Not[vecInBasisQ[#[[2]], domb]] &];

  (* check for vectors in lin(D) *)
  len1 = Length[routesinlin];
  len2 = Length[routesoutlin];

  Which[
    (* no vectors in lin(D) *)
    len1 == 0, Return[rvecs], 
    (* decomposing using routesout  doesn't work for Patrice's example
    len1 > 0 && len2 > 0, Return[decomposeRoutes[routesinlin, routesoutlin]],
    *)
    (* some  vectors in lin(D) *)
    len1 > 0 , 
         (* try to use  vectors in orthogonal subspace of lin(D) *)
         (nvecs = NullSpace[getBasis[domainBasis[dom]]];
          If[ nvecs != {},  
              Return[decomposeRoutes[routesinlin, {{0, nvecs[[1]]}}]],
              (* if not the dimension of the system has to be extended *)
              extendSysIndex[depast, routesinlin] 
	    ]
         )
  ];
  
]

Clear[depVec];
(* return {(I-A), -b} *)
depVec[depast:depend[dom_,_,_,depmat_,_]] := Module[{adep, A,b,theta},
(* substitute equalities from the domain in depmat  *)
  adep = DomMatrixSimplify[depmat, DomEqualities[dom]];
  A = dropConst[adep[[4]]];
  b = getConst[adep[[4]]];
  Return[{(IdentityMatrix[Length[A]] - A), (-b)}];
]


Clear[getRouteVecs];
getRouteVecs[depast:depend[dom_,lhs_,rhs_,dep_,_], options___Rule] := 
  Catch[
  Module[{vecs},
  vecs = routeVecs[depast, options]; 
  Return[vecs];
  ]
]


Clear[usePipeIO];
(* calls PipeIO with the route *)
usePipeIO[asys_, depast:depend[dom_,lhs_,rhs_,depmat_,_], routes_, options___Rule] :=
  Catch[
  Module[{rvecs, coeff, amats, newroutes},

  If[ route === {}, Return[asys]];
  (* construct the alpha  matrix for each routing component alpha.phi *)
  amats = Map[routeMat[dom, #] &, routes];
  newroutes = MapThread[{#1, #2[[2]]} &, {amats, routes}];
  (* apply useAlphaPipeIO *)
  Return[useAlphaPipeIO[asys, newroutes,depast,options]];
       ];
]


Clear[useAlphaPipeIO];

useAlphaPipeIO[route:List[__List],depend_Alpha`depend,options___Rule]:=
  Catch[
  Module[{res},
	 res=useAlphaPipeIO[$result,route,depend,options];
	 If [MatchQ[res,Alpha`system[___]],
	     $program=$result;
	     $result=res];
	 $result]
]

useAlphaPipeIO[sys_Alpha`system,route:List[__List],depend_Alpha`depend,
  options___Rule]:=
  Catch[
  Module[{curSys,curDepend,transfoDone,curRoute,curRouteUpdated,curVarList,
	  newVarList,newVar,curTransMat, optVerb, optDbug,
  optRouteOnce, lenRoute},

     (* set the options *)
     optVerb = verbose/.{options}/.Options[uniformize];
     optDbug = debug/.{options}/.Options[uniformize];
     optRouteOnce = routeOnce/.{options}/.Options[uniformize];

	 curSys=sys;
	 curDepend=depend;
	 (*  This variable recall the dependency beyween the original domain 
	     (first source domain) and the current source domain, it is used
	     to transform the information of the route according to the
	     transformations that have already been done *)
	   transfoDone =idMatrix[route[[1,1,3]],route[[1,1,3]]];
	 If[optVerb, show[transfoDone];];
         If[optRouteOnce, lenRoute = 1, lenRoute=Length[route]];
	 Do[curRoute=route[[i]];
	    curRouteUpdated=ReplacePart[curRoute,
					composeAffines[curRoute[[1]],transfoDone],
					1];
	    curVarList=Map[First,curSys[[5]]];
	    curSys=
	      normalize[usePipeIOOnce[curSys,curRouteUpdated,curDepend,options]];

		newVarList=Map[First,curSys[[5]]];
	    newVar=Complement[ newVarList,curVarList];
	    If [Length[newVar]=!=1,
		Print["Warning,no var added"],
		curDepend=First[Select[getDependences[curSys],
				       Part[#,3]===depend[[3]] &]]];

	    curTransMat=buildTranslMatFromVec[curRoute];
	    transfoDone=composeAffines[transfoDone,curTransMat];
	    If[optVerb, Print["var added: ",newVar]],
	    {i,1,lenRoute}];
	 curSys]
]

usePipeIO[a___]:=Message[usePipeIO::WrongArg,a]


Clear[usePipeIOOnce]

usePipeIOOnce[sys_Alpha`system,routeOne_List,depend_Alpha`depend, options___Rule]:=
  Catch[
    Module[
      {expr1,positionExpr1, contextDomList,contextDomExpr1,
       domExpr1,domSource,mat0mat,mat1mat,
       mat1,domGoal,equDomGoal,newEquDomGoal,
       domBound,newName,pipeVect,pipeVecAffine,
       pipeVecMat,res, optVerb, optDbug},

     (* set the options *)
     optVerb = verbose/.{options}/.Options[uniformize];
     optDbug = debug/.{options}/.Options[uniformize];

      newName=getNewName[sys,ToString[Unique[depend[[3]]]]];
      (* expression to be pipeline *)
	expr1=Alpha`affine[Alpha`var[depend[[3]]],depend[[4]]];
      (* Compute the context domain  of the expression,
	 take the union of all the uses of the expression *)
	  positionExpr1=Position[sys,expr1];
      If [Length[positionExpr1]<1,
	  Message[usePipeIOOnce::exprNotFound,expr1];
	  Throw[sys]];
      contextDomList=Map[getContextDomain[sys,#] &,positionExpr1];
      contextDomExpr1= Fold[DomUnion,
			    contextDomList[[1]],
			    Drop[contextDomList,1]];
      domExpr1=expDomain[expr1];
      mat1=buildTranslMatFromVec[routeOne];

      If[optVerb, Print["Routing ",depend[[3]], " with new Var
      ",newName,"  along direction: ",routeOne[[2]]]];

	(* domSource is the domain where the pipe starts *)
	domSource=DomIntersection[contextDomExpr1,domExpr1];
      (* domGoal is the domain where the pipe stops *)
	    domGoal=DomImage[domSource,mat1];
      equDomGoal=DomEqualities[domGoal];
      If [equDomGoal[[1]]<1,
	  Throw["ERROR"],
	  (* Currently the first column is missing in the
	     matrix returned by DomEqualities *)
	    theEquality=equDomGoal[[4,1]];
	      If [Dot[Drop[theEquality,-1],routeOne[[2]]]<0,
		  theEquality=-theEquality];
	       newEquDomGoal=Alpha`matrix[1,
					  equDomGoal[[2]]+1,
					  equDomGoal[[3]],
					  {Prepend[theEquality,1]}];
	       ];
      (* dombound is the half space (supporting domBound)
	      in which the pipeline takes place. WARNING,
	      we may have to check that the dot product of the normal to
	      the hyperplane and the pipe vector is positive *)
	     domBound=DomConstraints[newEquDomGoal];
       If[optDbug, Print["Bounding hyperplane: "]; show[domBound];]; 
	       (* rewrite the pipe vector in matrix form for
		  pipeIO *)
	       pipeVecMat=idMatrix[equDomGoal[[3]],equDomGoal[[3]]];
	   pipeVect=Append[routeOne[[2]],1];
	   If [Length[pipeVect]=!=pipeVecMat[[1]],
	       Message[usePipeIOOnce::pipeVectNotCorrect,pipeVect];Throw[sys]];
	   pipeVecAffine=MapThread[Append,
				   {Map[Drop[#,-1] &,pipeVecMat[[4]]],
				    pipeVect}];
	   pipeVecMat=ReplacePart[pipeVecMat,pipeVecAffine,4];
	     (* use PipeIO *)
    res=pipeIO[sys,
	       depend[[2]],
	       expr1,
	       Alpha`affine[Alpha`var[newName],
			    pipeVecMat],
	       domBound];
	   res]
  ]

usePipeIOOnce[a___]:=Message[usePipeIOOnce::WrongArg,a]

(* This function takes the a matrix which express the translation 
   (for instance "(i,j,k) is tranlated of k*(1,0,0)" and returnd the
   matrix expressiing the transformation i.e: (i,j,k->i+k,j,k) *)
Clear[buildTranslMatFromVec]

buildTranslMatFromVec[routeOne_List]:=
  Module[{mat0mat,mat1mat,mat1},
      (* if the route spec is `k times v1' then mat0mat represents k*v1 *)
	   mat0mat=routeOne[[1,4]];
	 (* and we need mat1= Id-k*v1 *)
	    mat1mat=IdentityMatrix[Length[mat0mat]] -
	      Append[Drop[mat0mat,-1],
		     Table[0,{i,1,Length[mat0mat]}]];
	 mat1 = ReplacePart[routeOne[[1]],mat1mat,4];
	 mat1]

buildTranslMatFromVec[a___]:= Message[buildTranslMatFromVec::WrongArg,a]


Clear[affTransMat];
(* compute the affine transformation matrix T(I) = I - alpha.phi *) 
affTransMat[dom:domain[_,indi_,_],route:{alphas_, phi:{_Integer..}}] :=
  Module[{tmat, tcon, amat},
  getCoeffs[x_, lindi_] := Map[Coefficient[x, #]&, lindi];
  getConsts[x_, lindi_] := (x /. Map[(# -> 0) &, lindi] );
  tmat = Map[getCoeffs[#, indi]&,  alphas(phi)];
  tcon = getConsts[alphas (phi), indi];
  amat = mmaToAlphaMatrix[(IdentityMatrix[Length[indi]]-tmat), -(tcon)];
  (* insert the indices  and return an Alpha matrix *)
  Return[ReplacePart[amat,indi,3]];
]

(* covert the route : alpha.phi into an alpha matrix  *)
Clear[routeMat];
(* compute the affine transformation matrix T(I) = I - alpha.phi *) 
routeMat[dom:domain[_,indi_,_],route:{alphas_, phi:{_Integer..}}] :=
  Module[{tmat, tcon, amat},
  getCoeffs[x_, lindi_] := Map[Coefficient[x, #]&, lindi];
  getConsts[x_, lindi_] := (x /. Map[(# -> 0) &, lindi] );
  tmat = Map[getCoeffs[#, indi]&,  alphas(phi)];
  tcon = getConsts[alphas (phi), indi];
  amat = mmaToAlphaMatrix[tmat, tcon];
  (* insert the indices  and return an Alpha matrix *)
  Return[ReplacePart[amat,indi,3]];
]


(* obsolete : using MMAlpha's pipeline package *)
(* construct the equations explicitly *)
Clear[genRouteSubsystem];
genRouteSubsystem[depast:depend[dom_, lhs_, rhs_, dep_,_], route_] := 
genRouteSubsystem[$result, depast,route];

genRouteSubsystem[sys_, depast:depend[dom_, lhs_, rhs_, dep_,_], route_] := Module[
{alpha,phi,indi,d1,d2,amat,rvar,lastrow,newdep,eqn1,eqn2},

  If[ route === {}, Return[{}],
      ( alpha = route[[1]];
        phi = route[[2]];
        indi = dom[[2]];
        (* compute the affine transformation matrix T(I) = I -
	   alpha.phi *) 
        amat = TransMat[depast,route];
        (* compute the two domains *)
        (* d2 is an affine transformation of dom *)
        d2 = DomImage[dom, amat];
        (* union and difference with d2 to give d1 *)
        d1 = DomDifference[DomConvex[DomUnion[dom,d2]], d2];
        (* construct the two equations *)
        rvar = getNewName[sys, ToString[Unique[rhs]]];
        lastrow = Append[Table[0, {Length[indi]}], 1];
        newdep = Append[Transpose[Append[IdentityMatrix[Length[indi]], -phi]],lastrow];
        newdep =  Alpha`matrix[Length[phi]+1, Length[phi]+1,
                            indi,
                            newdep];
        eqn1 = Alpha`equation[rvar, 
                  Alpha`restrict[d1, 
                       affine[Alpha`var[rvar],newdep]]];

        (* compute inverse of transformation matrix *)
        (* Bug : compute inverse  *)
        (* newdep = Inverse[dropConst[amat[[4]]]]; *)

        (* simple inverse doesn't exist always. But inverse in context
           will. *)

        newdep = inverseInContext[amat,dom];
    
        eqn2 = Alpha`equation[rvar, 
                  Alpha`restrict[d2, 
                       affine[Alpha`var[rhs],
                       composeAffines[dep, newdep]]]];  
        Return[{eqn1,eqn2}];
      )
      ]
]

(* obsolete : using MMAlpha's pipeline package *)
Clear[routeVar];
routeVar[sys_, depast:depend[dom_,lhs_,rhs_,dep_,_], rvects_] := Module[
  {dumdep, asys, rpos, rexp, rsys, curroute,subsys, eqn1, eqn2, eqndom, adep},

  curroute = First[rvects]; (* current routing vector *)
   
  If[curroute === {}, Return[sys],
  (
  (* generate routing equations *)
  subsys = genRouteSubsystem[depast,curroute];
  (* insert the subsystem into the AST *)
  eqn1 = subsys[[1]];
  eqn2 = subsys[[2]];
  eqndom = DomConvex[DomUnion[eqn1[[2,1]], eqn2[[2,1]]]];

  (* get  the original equation *)
   rpos = getOccursInDef[sys, lhs, affine[var[rhs],_],1];
   rexp = getPart[sys, rpos];
   (* change the index mapping *)
   rexp =  ReplacePart[rexp, IdentityMatrix[rexp[[2,1]]], {2,4}];
   (* change the variable name *)
   rexp = ReplacePart[rexp, eqn1[[1]], {1,1}];

  (* replace the rhs expression, insert a declaration and the eqns  *)
  (* todo: type of variable has to be fixed to type of the rhs. Also 
     depend function should return a position paramter.
  *)
  (* construct a composite equation for each routing variable *)
  rsys = Alpha`equation[eqn1[[1]],
           Alpha`case[ {
             Alpha`restrict[eqn2[[2,1]],Alpha`affine[eqn2[[2,2,1]],eqn2[[2,2,2]]]],
             Alpha`restrict[eqn1[[2,1]],Alpha`affine[eqn1[[2,2,1]],eqn1[[2,2,2]]]]
        }]];

  (* update the syntax tree *)
  asys = Insert[Insert[ ReplacePart[sys, rexp, rpos],
          Alpha`decl[eqn1[[1]], Alpha`integer, eqndom], {5,1}],
          rsys, {6,1}];

  (* apply the routing vectors to  each subsytem recursively *)
  (* make a dummy depend for next equation which is eqn2  *)
  dumdep = Alpha`depend[eqn2[[2,1]], eqn2[[1]], rhs, eqn2[[2,2,2]], _]; 
  Return[routeVar[asys, dumdep, Rest[rvects]]];
  )
  ]
]

Clear[routeDep];
(* updates the syntax tree with routing subsystem *)
routeDep[depast:depend[___], routes_,options___Rule] := 
  Catch[
  Module[
  {asys,tmp},
  asys = $result;
  tmp = routeDep[asys, depast, routes, options]; 
  If [tmp =!= Null,
      (Alpha`$program = Alpha`$result;
       Alpha`$result = tmp),
       Null];
  ]
]

routeDep[asys_, depast:depend[dom_,lhs_,rhs_,dep_,_], routes_,
options___Rule] := 
  Catch[
  Module[
    {tmpsys, optVerb,optVerf, tmp, optInpAlign},

    optVerb = verbose/.{options}/.Options[uniformize];
    optVerf = verifyCone/.{options}/.Options[uniformize];
    optInpAlign = alignInp/.{options}/.Options[uniformize];

    If[optInpAlign, 
     tmp = checkRule2[asys, depast, options];
     If[tmp[[1]] === True,
        Return[applyRule2[asys, depast, tmp[[2]], options]]];
    ];

    If [optVerb,
      Print["Routing dependence "];
      show[dtable[{depast}]];
      Print[" with vectors ",  routes];
    ];
    tmpsys = usePipeIO[asys, depast, routes,options]; 
    (* update time cone : drop the routing coefficients and pass only the vectors *)
    If[optVerf, updateSysCone[depast, Cases[routes, {c_,r_}:>r]]];
    Return[tmpsys];
  ]
]

Clear[initUniformization];

initUniformization[] := initUniformization[$result];

initUniformization[asys_] := Module[{fulldeptab, deptab, locals},

  (* initialize the system dependence cone *)
  (* get the dependence table : without simplifying in context *)
  fulldeptab = dep[asys, equalitySimpl -> False];
  locals = getLocalVars[asys];
  (* pick up the computation equations *)
  (* drop the output equations *)
  deptab = Cases[fulldeptab[[1]], depend[_,lhs_,_,_,_] /;
  Intersection[{lhs}, locals]  =!= {}];
  (* drop the input equations *)
  deptab = Cases[deptab, depend[_,_,rhs_,_,_] /;
  Intersection[{rhs}, locals]  =!= {}];
  initSysCone[deptab]

  (* any other initializations can be put here  *)
]

Clear[initCones];
initCones[] := Block[{},
  conelist = {};(* list of all cones for debugging *)
  $depCone = {}; (* current timing cone *)
  $coneList = {};(* cones of the initial affine system *)
  Return[];
 ];

Clear[initSysCone];

(* initialize the cone enclosing the dependences of the affine system
 *)
initSysCone[alldeps_] := Module[{dcone},

  (* global lists *)
   initCones[];
  (* get the cones of all the dependences *)
  $coneList = Map[depCone, alldeps];

  (* convHull does not work properly *)
  (*  Do[$depCone = convHull[{$depCone, $coneList[[i+1]]}], {i,
      Length[$coneList]-1}]; *)

  $depCone = $coneList[[1]];
  (* collect all the vertices and rays of range *)
  Do[$depCone = 
  addRaysToCone[Union[getVertices[$coneList[[i]]],rays[$coneList[[i]]]], $depCone], {i,
      Length[$coneList]}]; 

  If[hasLinesQ[$depCone] == True,
    Message[initCone::invalid, getLines[$depCone]];{},
   rays[$depCone]
  ]
   
]

(* Verify chosen pipe vector is consistent with system cone *)
Clear[verifyPipe];

verifyPipe[depast_, pipevec_] := Module[{tcone, vecray},

  (* necessary condition *)
  tcone = depCone[depast];
  (* treat the pipevec as a ray for the purpose of verification*)
  vecray = {pipevec};
  tcone = addRaysToCone[vecray,tcone];
  (* check if  dependence cone is  pointed *)
  If[hasLinesQ[tcone] === True,
     Message[verifyPipe::invalid, pipevec]; Throw[$Failed]
  ];

  (* sufficient condition : check with system dependence cone *)
  checkTimeCone[tcone, pipevec]; 			   
				   
]

(* Verify chosen routing vectors are consistent with system cone *)
Clear[verifyRoute];

verifyRoute[depast_, route_] := Module[{tcone, rvecs},
  (* throw away the coefficient for routing vectors *)
  rvecs = Cases[route, {c_,r_}:>r];
  (* necessary condition *)

  tcone = depCone[depast];
  tcone = addRaysToCone[rvecs,tcone];
  (* check if  dependence cone is  pointed *)
  If[hasLinesQ[tcone] === True,
     Message[verifyRoute::invalid, rvecs]; Throw[$Failed]
  ];

  (* sufficient condition *)
  checkTimeCone[tcone, rvecs];		   
				   
]


Clear[checkTimeCone];
(* checks if the given cone and  current time cone  form a  pointed cone *)
checkTimeCone[depcone_, vecs_] := Module[
  {tcone},

  tcone = depcone;

  (* check with current global time cone *)
  If[ $depCone =!= {},
      tcone = addRaysToCone[Union[getVertices[$depCone],rays[$depCone]], tcone]
  ];
 
  (* check if it global time cone is still pointed! *)
  If[hasLinesQ[tcone] === True,
     (Message[checkTimeCone::invalid, vecs]; Throw[$Failed];),
     (* Message[checkTimeCone::valid, vecs];*)True
     ]

]

Clear[updateSysCone]
(* update the system dependence cone *)

updateSysCone[depast_, vecs_ ] := Module[{tcone},

  (* add the vecs to the dependence cone *)
  tcone = depCone[depast];
  tcone = addRaysToCone[vecs,tcone];

  (* update the current time cone *)
  If[ $depCone === {},
      $depCone = tcone,
      (* does not work : $depCone = convHull[{$depCone, tcone}] *)
      $depCone = addRaysToCone[Union[getVertices[tcone],rays[tcone]], $depCone]];
  
  (* maintain a global list of dependence cones for debugging *)
  conelist = Append[conelist,  tcone];			     
]

Clear[$depCone]
(* get the current cone rays *)
$depCone[] := rays[$depCone];

Clear[checkScheduleCone];
(* this checks the original time cone of the affine system (affine cone)
 with the current cone *)
checkScheduleCone[cur_, aff_] := Block[
  {tcone},
  tcone = convHull[{cur,aff}];
  If[hasLinesQ[tcone] == True,
     Message[checkScheduleCone::noschedule],
     tcone
  ]
  
]


Clear[getIntBasis];

getIntBasis[depast:depend[dom_,_,_,depmat_,_]] := 
Module[{intbas, adep, depbas, dombas},
       dombas = domainBasis[dom];
(* substitute equalities from the domain in dep  *)
  adep = DomMatrixSimplify[depmat, DomEqualities[dom]];
  (* drop the constant part and compute null space *)
  depbas =  NullSpace[Drop[Map[Drop[#, -1]&, adep[[4]]], -1]];
  If[depbas === {}, Return[depbas],
     Return[intersectionBasis[findHermiteBasis[depbas],dombas]]];
]

Clear[getUniformizationVecs];

getUniformizationVecs[depast:depend[dom_,_,_,dep_,_], intbas_] := Module[{intbas, depbas, dombas},

  If[intbas === {}  , 
    (* needs routing *)
    getRouteVecs[depast],
    (* admits pipelining *)
    getPipeVecs[depast, intbas]
  ]

]


(* Returns true if the non-uniformity could be removed using 
   an input equation  else false *)
Clear[alignInputQ];
alignInputQ[depast:depend[___]] := 
alignInputQ[$result, depast];

(* Predicate : True means Rule 2 can be applied *)
alignInputQ[asys_, depast:depend[dom_,_,rhsvar_,depmat_,_], options___Rule] := Module[
  {adep, rpos,u1,u2, deptab, inpVars, inpEqs, inpList,  optDbug},

  optDbug = debug/.{options}/.Options[uniformize];

  (* compute the image of domain under  the dependence *)
  (* substitute equalities from the domain in dep  *)
  adep = DomMatrixSimplify[depmat, DomEqualities[dom]];
  u1 = DomImage[dom, adep];

  (* the dependence table contains the input equations *)
  deptab = dep[asys, equalitySimpl -> False];
  inpVars = getInputVars[asys];
  (* get the input equations *)
  inpEqs = Cases[deptab[[1]], depend[_,_,rhs_,_,_] /;
  Intersection[inpVars, {rhs}]  =!={}];
  (* restrict it to those which matches rhsvar *)
  inpEqs = Cases[inpEqs, depend[_,lhs_,_,_,_] /;
  Intersection[{lhs}, {rhsvar}] =!= {}];
  (* pick the equations satisfying the domain inclusion condition  *)
  inpList = Cases[inpEqs, depend[adom_,_,_,_,_] /;
                  DomEqualQ[DomConvex[DomUnion[u1,adom]], adom] === True
	];

  If[optDbug,
     If[inpList =!= {}, Print["inpList = "]; show[dtable[inpList]];
        Print["dependence domain = "]; show[u1];];
   ];

  If[inpList === {}, 
     Return[{False, {}}], 
     Return[{True, First[inpList]}]];
]

Clear[alignInput];
(* uniformize the dependence using an input equation *)
alignInput[depast_, inpEqn_, options___Rule] :=  Module[
{sys,tmp,routes},
  sys = $result;
  tmp = alignInput[sys, depast, options];
  If [tmp =!= Null,
      (Alpha`$program = Alpha`$result;
       Alpha`$result = tmp),
      Alpha`$result
      ];
]

alignInput[sys_, depast:depend[dom_,lhs_,rhs_,depmat_,_], inpEqn:depend[indom_,inlhs_,inrhs_,indepmat_,_], options___Rule] := Module[
  {asys,rpos, rpos2, eqn, newvar,rexp,rexp2,neweqn,optVerb, optDbug},

  optVerb = verbose/.{options}/.Options[uniformize];
  optDbug = debug/.{options}/.Options[uniformize];

  If [optVerb,
     Print["Uniformizing dependence"];
     show[dtable[{depast}]];				             
     Print[" with input alignment rule"];
  ];
    
  (* modify the dependence in the original equation *)
  (* get the position of rhs variable in the original equation *)
  rpos = getOccursInDef[sys, lhs, affine[var[rhs],depmat],1];
  (* get a new name for the variable *)
  newvar = getNewName[sys, ToString[Unique[rhs]]];
  rexp = getPart[sys, rpos];
  rexp = ReplacePart[rexp,IdentityMatrix[rexp[[2,1]]], {2,4}];
  (* change the variable name *)
  rexp = ReplacePart[rexp, newvar, {1,1}];

  (* construct the new input equation *)
  neweqn = Alpha`equation[newvar, affine[var[inrhs], composeAffines[indepmat, depmat]]];

  If[optDbug,
     Print["neweqn : "]; 
     show[neweqn]
   ];

  (* insert the changes into the tree *)
  asys = Insert[Insert[ ReplacePart[sys, rexp, rpos],
             Alpha`decl[neweqn[[1]], Alpha`integer, dom], {5,1}],
              neweqn, {6,1}];
  Return[asys];
]

Clear[uniformizeLocal];
(* uniformize a dependence satisfying local uniformity test *)
uniformizeLocal[depast_, options___Rule] :=   
  Module[{asys, tmp},
  asys = $result;
  tmp = uniformizeLocal[$result, depast, options]; 
  If [tmp =!= Null,
      (Alpha`$program = Alpha`$result;
       Alpha`$result = tmp),
       Alpha`$result;
    ];
]

uniformizeLocal[sys_, depast:depend[adom_,lhs_,rhs_,depmat_,_],
		options___Rule] := 
Module[
{rpos,rexp,rexpNew,asys, idmat, newindex, A, b, B, c, d, zmat, lmat,
 rvec, imat,optVerb,optDbug},

  optVerb = verbose/.{options}/.Options[uniformize];
  optDbug = debug/.{options}/.Options[uniformize];
  If [optVerb,
     Print["Uniformizing dependence"];
     show[dtable[{depast}]];					       
     Print[" with local uniformity rule"];
  ];

  (* get the position of rhs in the  equation *)
  rpos = getOccursInDef[sys, lhs, affine[var[rhs],depmat],1];
  rexp = Alpha`affine[Alpha`var[rhs],depmat];
  (* compute the index mapping matrix *)
  A = Drop[Map[Drop[#, -1]&, depmat[[4]]], -1];
  b = Flatten[Drop[Map[Take[#, -1]&, depmat[[4]]], -1]];
  idmat = IdentityMatrix[Length[b]];

  (* do variable elimination *)
  (* first get the equalities from the domain *)
  B = getEqualities[adom];
  (* extract the constants from the equalities *)
  c = Cases[B, x_ :> Last[x]];
  (* intrepret the constants in the equalities *)
  c = -c;
  (* drop the constants from equalities *)
  B = Cases[B, x_ :> Drop[x, -1]];
  (* pad with zeros to the right to align with lmat *)
  zmat = Table[0, {j, Length[b]}];
  B  = Map[Join[#, zmat]&, B];
  lmat = Join[MapThread[Join[#1, #2] &, {(A - idmat), -idmat}], B];
  rvec = Join[-b,c];
  d = solveDiophantine[lmat, rvec];
  (* pick out the last n elements as the solution *)
  d = Drop[d[[1]], Length[b]];

  If [optDbug,
    Print["lmat = ", MatrixForm[lmat]];
    Print["rvec = ", rvec]; 
    Print["d = ", d];
  ];

  (* construct the new index *)
  lastrow = Append[Table[0, {Length[b]}], 1];
  (* make a copy *)
  newindex = depmat;
  imat = Append[Transpose[Append[IdentityMatrix[Length[b]], d]], lastrow];
  newindex = ReplacePart[newindex, imat, {4}];
  rexpNew = ReplacePart[rexp,newindex, {2}];
  (* insert the changes into the AST  *)
  asys = replaceByEquivExpr[sys,rexp,rexpNew]; 
  Return[asys];
]
 
Clear[localUniformQ];
(* test whether a dependence is uniform with respect to a given domain.
   this test is stronger than what is currently avaialble in Alpha. This
   applies multiple tests in a hierarchical fashion. Simple tests are
   first tried and if they do not reveal uniformity stronger test are applied.
*)

localUniformQ[depast:depend[adom_,_,_,adep_,_]] := Module[{depmat, dombas, depbas},
  (* get the dependence matrix and drop the constant part *)
  depmat = Drop[Map[Drop[#, -1]&, adep[[4]]], -1];

  (* compute a basis for the  null space of dependence : nullspace (I - A) *)
  depbas = NullSpace[IdentityMatrix[Part[Dimensions[depmat], 1]] - depmat];
  (* cast it into hermite normal form *)
  If[depbas === {}, Return[False],
    (depbas = findHermiteBasis[depbas];
     (* compute a basis for the domain *)
     dombas = domainBasis[adom];
     (* check for Inclusion of dombas in depbas *)
     Return[properSubspaceQ[dombas,depbas]];
    )
    ]
]


Clear[checkUniformQ];

checkUniformQ[adep_, dom_] := Block[{dep},
  dep = DomMatrixSimplify[adep, DomEqualities[adom]]; 
  Which[
   (* check the dependence matrix for Identity *) 
    uniformQ[dep], True, 
   (* check the condition lin(dom) is in Null(I-A) *)
   uniformdomQ[dep, dom], True,
   (* default - declare dependence as non-uniform *)
    True, False
  ]
]

Clear[checkUniformity];
(* Predicate : to test if the dependence is uniform *)
checkUniformity[depast:depend[_,_,_,depmat_,_]] := Return[uniformQ[depmat]];

Clear[getDepVecs];
getDepVecs[] := getDepVecs[$result] ;
getDepVecs[asys_] :=  Module[{fulldeptab, deptab, depmat, depvecs}, 
  (* get the dependence table *)
  fulldeptab = dep[asys,equalitySimpl -> False ];
  locals = getLocalVars[asys];
  (* pick up the computation equations *)
  (* drop the output equations *)
  deptab = Cases[fulldeptab[[1]], depend[_,lhs_,_,_,_] /;
  Intersection[{lhs}, locals] =!= {}];
  (* drop the input equations *)
  deptab = Cases[deptab, depend[_,_,rhs_,_,_] /;
  Intersection[{rhs}, locals]  =!= {}];
  depvecs = Map[depVec, deptab];
  Return[{deptab,depvecs}];
] 



Clear[getDependences];
(* tabulate the dependences for computation equations and also
   initialize the dependence cone *)

getDependences[] := getDependences[$result];
getDependences[asys_] := Module[{fulldeptab, deptab, depmat, uniformsys, alldeps, nondeps, vectors, syslist}, 

  (* should do error reporting for equations not fully indexed  *)

  (* get the dependence table *)
  fulldeptab = dep[asys,equalitySimpl -> False];
  locals = getLocalVars[asys];
  (* pick up the computation equations *)
  (* drop the output equations *)
  deptab = Cases[fulldeptab[[1]], depend[_,lhs_,_,_,_] /;
  Intersection[{lhs}, locals] =!= {}];
  (* drop the input equations *)
  deptab = Cases[deptab, depend[_,_,rhs_,_,_] /;
  Intersection[{rhs}, locals]  =!= {}];
  (* drop dependences that are already uniform  *)
  nondeps = Cases[deptab, adep_ /; checkUniformity[adep] =!= True];
  Return[nondeps];
] 

Clear[whichRule];
whichRule[depast_] := Block[{},
 Which[
    checkRule1[depast], Print["Rule1 : Uniformize with Local
      Uniformity"];Return[1], 
    checkRule3[depast],  Print["Rule3 : Pipeline the dependence"];
    Return[3],
    checkRule4[depast],  Print["Rule4 : Route the dependence"];
    Return[4],
    True, Print["Automatic support not yet implemented for these types of dependences"];Return[$Failed]
  ]
]

Clear[checkRule1];
checkRule1[depast_] := Return[localUniformQ[depast]];
Clear[checkRule3];
checkRule3[depast_] := Return[getIntBasis[depast] =!= {} ];
Clear[checkRule2];
checkRule2[asys_, depast_, options___Rule] := Return[alignInputQ[asys, depast, options]]; 
Clear[checkRule4];
checkRule4[depast_] := Return[getIntBasis[depast] === {}];

Clear[applyRule1];
applyRule1[asys_, depast:depend[dom_,_,rhs_,adep_,_],
options___Rule]:= Return[uniformizeLocal[asys, depast, options]];


Clear[applyRule2];
applyRule2[asys_, depast:depend[___], inpEq_, options___Rule] := 
  Return[alignInput[asys, depast,inpEq, options]];


Clear[applyRule3];
applyRule3[asys_, depast:depend[___], options___Rule] := 
  Catch[
  Module[
  {pipevec, optVerf, tmpver},
  pipevec = getPipeVecs[depast];
  (* default : choose the first vector as pipeline vector *)
  pipevec = pipevec[[1]];
  optVerf = verifyCone/.{options}/.Options[uniformize];
  If[optVerf, 
    verifyPipe[depast, pipevec];
  ];
  Return[pipeDep[asys, depast, pipevec, options]];
]
]


Clear[applyRule4];
applyRule4[asys_, depast_, options___Rule] := 
  Catch[
  Module[
  {route, optVerify, optInpAlign},

  optInpAlign = alignInp/.{options}/.Options[uniformize];
  If[optInpAlign, 
    Return[routeDep[asys, depast, route, options]],
    (* else route the dependence *)
    (* todo: choose the first element of the list returned  as the route *)
    route = getRouteVecs[depast,options];
    If[route===Null, Return[Null]];

    optVerify = verifyCone/.{options}/.Options[uniformize];
    If[optVerify === True, 
      verifyRoute[depast,route];
    ];
    Return[routeDep[asys, depast, route, options]];
   ];
 ]
]


Clear[uniformize];
uniformize[depast:depend[___], options___Rule] := 
  Catch[
  Module[{asys, tmp},
  asys = $result;
  tmp = uniformize[asys, depast, options];
  If [tmp =!= Null,
      (Alpha`$program = Alpha`$result;
       Alpha`$result = tmp),
       Return[Null];
      ]
  ]
]

(* uniformize the given dependence *)
uniformize[asys_, depast:depend[___], options___Rule] := 
  Catch[
    Module[{optVerb},
	   Which[
	     checkRule1[depast], Return[applyRule1[asys, depast, options]],
	     checkRule3[depast], Return[applyRule3[asys, depast, options]],
	     checkRule4[depast], Return[applyRule4[asys, depast, options]],
	     True, (Print["Automatic support not yet implemented for these
types of dependences"]; Return[Null])
	     ]
	 ]
  ]

Clear[uniformization];

Options[uniformize] := {verbose->False,
                            debug->False,
                            verifyCone -> False,
                            alignInp -> False,
                            routeOnce-> False,
                            tmpFile -> False
                           }

uniformization[count_, options___Rule] :=
  Module[{nondeps, tmp,file1,count1,optVerb, optDbug, optTmpFiles}, 

  optVerb = verbose/.{options}/.Options[uniformize];
  optDbug = debug/.{options}/.Options[uniformize];
  optTmpFiles = tmpFile/.{options}/.Options[uniformize];
  
  (* collect non-uniform dependences *)
  nondeps = getDependences[];
  If[Length[nondeps] > 0,
    ( 
    If [optVerb,
      Print["\n----------------------------------------- "];
      Print["Uniformization Iteration = ", count];
      Print["----------------------------------------- "];
      Print[ "No. of non-uniform dependences = ", Length[nondeps]];
      Print["**************************************************************"];
      show[dtable[nondeps]];
      Print["**************************************************************"];
      ];
      (* lin(D) and Null(A) : requires debug.m to be loaded *)
      (* If[optDbug, verboseInfo[nondeps[[1]]];]; *)
      tmp=uniformize[nondeps[[1]], options];
      If[!MatchQ[tmp,Alpha`system[___]], Return[$failed]];
      normalize[];
      convexizeAll[];
      If[optTmpFiles, asave["/tmp/uniform" <> ToString[count]<>".alpha"];];
      (* ... and then re-initialize the dependence table *)
      uniformization[count+1,options];
    )
   ];

] 


Clear[callUniformize];
callUniformize[file_, options___Rule] := Module[{asys, count, fname, tmp},
  (* this function is used as a hook to invoke uniformization from 
     SARACEN's IRF. The idea is to construct an Alpha program 
     (or an AST ? Not clear which is the better option) for each
     nested loop from a multiphase algorithm with the same header
     information. The resulting program is stored in "file.URE" which
     is passed as a parameter to this call.
  *)


  (* some global initializations *)
  count = 1;
  tmp = load[file];
  If[tmp === Null, Return[]];

  (* todo : should do error reporting for equations not fully indexed  *)

  If[getDependences[] === {}, 
     (Print["System is already uniform: Returning without any
processing \n"]; 
     Return[]) ];

  (* perform some initialization *)
  initUniformization[$result];

  (* return if uniformization failed *)
  If[uniformization[count, options] === $Failed, 
   Print["\nUniformization not complete "];
   Return[];
  ];

  (* else save the final result *)
  If[optVerb,Print["System dependence cone  with extremal rays: ", rays[$depCone]]];
  (* write back the results into a file with extension URE. *)
  fname = file <> ".URE";
  If[FileNames[fname] =!= {},
    (Print["\nFile : " <> fname <> " exists \n"];
    Print["Saving in File : " <> fname <> ".new \n"];
    fname =  fname <> ".new";),
   ];

  Print["\nUniformization complete: \nA uniform system is saved in File : "
	  <> fname <>"\n"];
  asave[fname];

]

End[] 
EndPackage[]

