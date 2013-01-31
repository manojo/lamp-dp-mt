(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : Tanguy Risset
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

BeginPackage["Alpha`Omega`", {"Alpha`Domlib`",
			      "Alpha`",
                                "Alpha`Matrix`",
				"Alpha`Tables`"
				    }]
(* Standard head for CVS

	$Author $
	$Date: 1999/03/02 15:49:23 $
	$Source: /udd/alpha/CVS/alpha_beta/Mathematica/lib/Packages/Alpha/Omega.m,v $
	$Revision: 1.5 $
	$Log: Omega.m,v $
	Revision 1.5  1999/03/02 15:49:23  risset
	added GNU software text in each packages
	
	Revision 1.4  1997/10/09 07:46:52  quillere
	Corrected a syntax error

	Revision 1.3  1997/05/19 10:41:17  risset
	corrected exported bug in depedancies

	Revision 1.2  1997/05/13 12:59:38  risset
	adlkj

	Revision 1.1  1997/04/24 12:56:27  risset
	added the Omega.m package

*)

Omega::usage="Package for interface with Omega calculator of Bill
Pugh"

readDomOmega::usage =
"readDomOmega[domain_String]\n
Function. Parses an Omega (Bill Pugh Tool) domain 
   and returns
the abstact syntax tree of the corresponding domain in Alpha.
No parameters are allowed"

loadDomOmega::usage =
"loadDomOmega[file_String]\n
Function. Parses an Omega (Bill Pugh Tool) domain 
   contained in a file and returns
the abstact syntax tree of the corresponding domain in Alpha.
No parameters are allowed"


showDomOmega::usage =
"showDomOmega[domain_Alpha`domain]\n
Function. Parses an ALPHA domain and write on screen 
it in Omega Format 
"

writeDomOmega::usage = 
"writeDomOmega[B_Alpha`domain]\n
Function. Parses an ALPHA domain and write in  a string  
 in Omega Format "

integerDomEmptyQ::usage = 
"integerDomEmptyQ[d_Alpha`domain]\n
Function. Test (with omega) if a domain is integer empty or not "

integerHull::usage = 
"integerHull[d_Alpha`domain]\n
Function. Computes (with omega) the integer hull of a domain "

integralDomSimplify::usage = "integralDomSimplify[dom1], simplify a
domain  if it is a union of domain which is equal to its convex hull,
WARNING, the execution may be long"

(* ===================== Private definitions ===================== *)

Begin["`Private`"]
(* readDomOmega : parse a string representing an Omega domain -------------*)

Clear[readDomOmega]

readDomOmega::wrongPar="Wrong arguments"

readDomOmega[B_String] := RunThrough["read_alpha -B", B]

readDomOmega[___]:=Message[readDomOmega::wrongPar]

(**** loadDomOmega, same but from a file ***)

Clear[loadDomOmega]
loadDomOmega::wrongPar="Wrong arguments"
loadDomOmega::fnf="File `1` not found"

loadDomOmega[filename_String] := 
  Module[{stream1,domdomList1,domList1,domList1bis,domList2,domString},
	 stream1=OpenRead[filename];
	 If [stream1===$Failed, 
	     Message[loadDomOmega::fnf,filename],
	     domList1=ReadList[stream1,String,RecordSeparators->{"#"}];
	     (* removing empty lines *)
	     domList1bis=Select[domList1,(StringLength[#1]=!=0) &];
	     (* removing comment lines *)
	     domList2=Select[domList1bis,(StringTake[#1,1]=!="#") &];
	     If [Length[domList2]>0,
		 (* Getting only one domain *)
		   domString=Apply[StringJoin,domList2];
		 RunThrough["read_alpha -B", domString],
		 Null
		 ]
	   ]
       ]

loadDomOmega[___]:=Message[loadDomOmega::wrongPar]

(* showDomOmega : print a domain in Omega format -------*)

Clear[showDomOmega]

showDomOmega::wrongPar="Wrong arguments"

showDomOmega[B_Alpha`domain] := Put[B,"!write_alpha -B"]


showDomOmega[___]:=Message[showDomOmega::wrongPar];


(* writeDomOmega : print a domain in Omega format in a file *)

Clear[writeDomOmega]

writeDomOmega::wrongPar="Wrong arguments"
writeDomOmega::pb1=" probably I/O Problem"
writeDomOmega::pb2=" I/O Problem"

writeDomOmega[b_Alpha`domain] := 
  Module[{name1,stream1,domdomList1,domList2,res},
	 name1="/tmp/writeDomOmega"<>Environment["USER"];
	 Put[b,"!write_alpha -B >"<>name1];
	 stream1=OpenRead[name1];
	 If [stream1===$Failed, 
	     Message[writeDomOmega::fnf,filename],
	     domList1=ReadList[stream1,String,RecordSeparators->{"#","\n"}];
	     domList2=Select[domList1,(StringTake[#1,1]=!="#") &];
	     If [Length[domList2]>0,
		 res=Apply[StringJoin,domList2];
		 Close[stream1](* ;
		 Run["rm "<>name1]*),
		 Message["writeDomOmega::pb1"]
	       ];
	   ];
	 res
	 ]


writeDomOmega[___]:=Message[writeDomOmega::wrongPar];


(* integerDomEmptyQ tests integral emptyness *)

Clear[integerDomEmpty];

integerDomEmptyQ::wrongPar= "Wrong arguments"
integerDomEmptyQ::pb1= "Problem in reading Omega's answer, see file `1`"

integerDomEmptyQ[d_Alpha`domain]:=
  Module[{name1,name2,str1,str2,str3,str4,str5,str6},
	 name1="/tmp/integerDomEmpty1"<>Environment["USER"];
	 name2="/tmp/integerDomEmpty2"<>Environment["USER"];
	 str1="# test with Omega \n";
	 str2="Dom1:= ";
	 str3=writeDomOmega[d];
	 str4=";\n";
	 str5="\n";
	 str6="Dom1;";
	 Put[OutputForm[str1<>str2<>str3<>str4<>str5<>str6],name1];
	 Run["oc <"<>name1<>" >"<>name2];
	 domFinal=loadDomOmega[name2];
	 If [MatchQ[domFinal,Alpha`domain[___]],
		    Run["rm "<>name1<>" "<>name2];
		    If [DomEmptyQ[domFinal],
			True,
			False],
	     Message[integerDomEmptyQ::pb1,name2];
	     False]
       ]

integerDomEmptyQ[___]:=Message[integerDomEmptyQ::wrongPar];


(* integerHull tests integral emptyness *)

Clear[integerDomEmpty];

integerHull::wrongPar= "Wrong arguments"

integerHull[d_Alpha`domain]:=
  Module[{name1,name2,str1,str2,str3,str4,str5,str6},
	 name1="/tmp/integerHull1"<>Environment["USER"];
	 name2="/tmp/integerHull2"<>Environment["USER"];
	 str1="# hull with Omega \n";
	 str2="Dom1:= ";
	 str3=writeDomOmega[d];
	 str4=";\n";
	 str5="\n";
	 str6="Hull Dom1;";
	 Put[OutputForm[str1<>str2<>str3<>str4<>str5<>str6],name1];
	 Run["oc <"<>name1<>" >"<>name2];
	 domFinal=loadDomOmega[name2]
       ]

integerHull[___]:=Message[integerHull::wrongPar];


Clear[integralDomSimplify]

integralDomSimplify[dom1_Alpha`domain]:=
  Module[{integerHull1,convHull1,res1,res2},
	 integerHull1=integerHull[dom1];
	 convHull1 = DomConvex[dom1];
	 (* testing if union is not an union *)
	 If [Length[dom1[[3]]]>1,
		    If [DomEqualQ[integerHull1,convHull1],
			res1=convHull1,
			res1=dom1],
	     res1=dom1];
	 (* testing integral emptiness *)
	 If [Not[DomEmptyQ[res1]],
	     If [integerDomEmptyQ[res1],
		 res2=DomEmpty[res1[[1]]],
		 res2=res1]];
	 res2
       ]


  integralDomSimplify[a___]:=(Message[integralDomSimplify::WrongArg,a];
			      Throw["ERROR"])
  
End[]
EndPackage[]
