(* file: $MMALPHA/lib/Package/Alpha/CodeGen/Output.m
   AUTHOR : Fabien Quilleré
   CONTACT : http://www.irisa.fr/cosi/ALPHA
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


        $Author: trisset $
        $Date: 2005/03/11 16:41:33 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha/CodeGen/Output.m,v $
        $Revision: 1.1 $
        $Log: Output.m,v $
        Revision 1.1  2005/03/11 16:41:33  trisset
        added codeGen to V2

        Revision 1.4  2001/02/02 10:23:18  quillere
        Added generator for True and False

        Revision 1.3  1999/06/02 09:20:56  quillere
        added interactive code generator

        Revision 1.2  1999/05/28 14:53:24  quillere
        added CVS header and GNU info

*)

BeginPackage["Alpha`CodeGen`Output`"];

Unprotect[writeCcode, printC];
Unprotect[vseq, hseq, block, list, left, symbol, deadCode];

 writeCcode::usage = "writeCcode[].";
 printC::usage = "printC[].";

Begin["`Private`"];

Unprotect[Format];
Format[vseq[x___]] := "-C-code-";
Format[hseq[x___]] := "-C-code-";
Format[block[x___]] := "-C-code-";
Format[list[x___]] := "-C-code-";
Format[left[x___]] := "-C-code-";
Format[deadCode] := "-C-code-";
Protect[Format];

(* === *)

Clear[printC];

 printC::wrongArg = "`1`";

printC[tree:_] := printC[tree, 2];

printC[tree:_vseq, tab:_Integer?NonNegative] :=
  Module[{},
	 printC[#, tab]& /@ tree;
       ];

printC[tree:_block, tab:_Integer?NonNegative] :=
  Module[{},
	 printC[hseq[tree[[1]], " {"], tab];
	 printC[tree[[2]], tab+2];
	 printC["}", tab];
       ];

printC[tree:_left, tab:_Integer?NonNegative] :=
  Print[treeToC[hseq@@tree]];
  

printC[tree:_, tab:_Integer?NonNegative] :=
  Print[StringJoin@@Array[" "&, tab], treeToC[tree]];

(* === *)

Clear[writeCcode];

 writeCcode::wrongArg = "`1`";

writeCcode[f:_OutputStream, tree:_] :=
  Catch[
    writeCcode[f, tree, 0]
  ];
  
writeCcode[f:_OutputStream, tree:_vseq, tab:_Integer?NonNegative] :=
  Catch[
    Module[{},
	   writeCcode[f, #, tab]& /@ tree;
	 ]
  ];

writeCcode[f:_OutputStream, tree:_block, tab:_Integer?NonNegative] :=
  Catch[
    Module[{},
	   writeCcode[f, hseq[tree[[1]], " {"], tab];
	   writeCcode[f, tree[[2]], tab+2];
	   writeCcode[f, "}", tab];
	 ]
  ];

writeCcode[f:_OutputStream, tree:_left, tab:_Integer?NonNegative] :=
  Catch[
    WriteString[f, treeToC[hseq@@tree], "\n"]
  ];
  

writeCcode[f:_OutputStream, tree:_, tab:_Integer?NonNegative] :=
  Catch[
    WriteString[f, StringJoin@@Array[" "&, tab], treeToC[tree], "\n"]
  ];

writeCcode[a___] :=
  Module[{},
	 Message[writeCcode::wrongArg, {a}];
	 $Failed
	 ];

(* === *)

Unprotect[treeToC];
Clear[treeToC];

 treeToC::wrongArg = "`1`";

treeToC[l:_hseq] :=
  Apply[StringJoin, Map[treeToC,l]];

treeToC[list[]] :=
  "";

treeToC[list[f_]] :=
  treeToC[f];

treeToC[list[f_,r__]] :=
  StringJoin[treeToC[f], ", ", 
	     If[Length[{r}]==1,
		treeToC[r],
		treeToC[list[r]]]];

treeToC[Plus[f_,r__]] :=
  StringJoin["(", ToString[Apply[Plus,treeToC/@{f,r}]], ")"];

treeToC[Times[f_,r__]] :=
  StringJoin[If[f===-1,
		"-",
		StringJoin[treeToC[f], "*"]],
	     If[Length[{r}]==1,
		treeToC[r],
		treeToC[Times[r]]]];

treeToC[And[f:_, r:__]] :=
  StringJoin[treeToC[f], " && ",
	     If[Length[{r}] == 1,
		treeToC[r],
		treeToC[And[r]]]
	   ];

treeToC[Power[e:_,i:_Integer]] :=
   StringJoin["power(", treeToC[e], ",", treeToC[i],")"];

treeToC[Max[f:_,r:__]] :=
  StringJoin["max(", treeToC[f], ",",
	     If[Length[{r}]==1,
		treeToC[r],
		treeToC[Max[r]]],
	     ")"];

treeToC[Min[f:_,r:__]] :=
  StringJoin["min(", treeToC[f], ",",
	     If[Length[{r}]==1,
		treeToC[r],
		treeToC[Min[r]]],
	     ")"];

treeToC[Equal[l_,r_]] :=
  StringJoin["(", treeToC[l], " == ", treeToC[r], ")"];

treeToC[GreaterEqual[l_,r_]] :=
  StringJoin["(", treeToC[l], " >= ", treeToC[r], ")"];

treeToC[c:_Ceiling] :=
  If[Position[c, _Rational]=!={},
     StringJoin["((int)ceil(", StringJoin@@(treeToC/@c), "))"],
     StringJoin[StringJoin@@(treeToC/@c)]
   ];

treeToC[c:_Floor] :=
  If[Position[c, _Rational]=!={},
     StringJoin["((int)floor(", StringJoin@@(treeToC/@c), "))"],
     StringJoin[StringJoin@@(treeToC/@c)]
   ];

treeToC[r:_Rational] :=
ToString[r, CForm];
(*  StringJoin["(", treeToC[Numerator[r]], "/", treeToC[Denominator[r]], ")"];*)

treeToC[i:_Integer] := ToString[i];

treeToC[s:_String] := s;

treeToC[symbol[s:_String]] := s;

treeToC[deadCode] := "/* dead code removed */";

treeToC[a:_] :=
  StringJoin[ToString[a]];

treeToC[a___] :=
  Module[{},
	 Message[treeToC::wrongArg, {a}];
	 Throw[$Failed]
       ];

treeToC[True] = "1";

treeToC[False] = "0";

Protect[treeToC];

End[];

Protect[writeCcode, printC];
Protect[vseq, hseq, block, list, left];

EndPackage[];
