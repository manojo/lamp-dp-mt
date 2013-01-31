(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR :  Zbigniew Chamski
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
(* display configuration: compact printing *)

Format[Continuation[_]] := ""
Format[LineBreak[_]] := ""
Format[StringBreak[_]] := ""

(* by-passing an oddity of Mathematica: (c[ad]r '()) ==> ERROR. After the
   following modification, Last will accept to take the last and first element
   of an empty list ... *)

Unprotect[System`First]
System`First[{}] := {}
Protect[System`First]
Unprotect[System`Last]
System`Last[{}] := {}
Protect[System`Last]

(* A useful function: if an object 'x' is NOT a list, convert 'x' to 'List[x]' *)

Unprotect[System`ToList]
Clear[System`ToList]
System`ToList[l_List] := l;
System`ToList[l_ /; Head[l] =!= List] := List[l];
System`ToList[l_, ln__] := Join[ToList[l], ToList[ln]];
System`ToList[] := {};
System`ToList::usage=
"Converts any object to a list: adds head 'List' if not
present.\n\nToList[{a,b,c}] ---> {a,b,c}. ToList[a,b[c]] ---> {a, b[c]}."
Protect[System`ToList];

Unprotect[System`Pname];
Clear[System`Pname];
System`Pname[x_] := ToString[HoldForm[x]];
System`Pname::usage=
"Build a string representation of an unevaluated expression."
SetAttributes[System`Pname, {Protected, HoldFirst}];

Unprotect[System`DirectedInfinity];
DirectedInfinity/: Format[DirectedInfinity[],  InputForm]:= TextForm[Infinity];
DirectedInfinity/: Format[DirectedInfinity[-1],InputForm]:= TextForm[-Infinity];
DirectedInfinity/: Format[DirectedInfinity[_], InputForm]:= TextForm[Infinity];
Protect[System`DirectedInfinity];

True;	(* be silent at the end ... *)

