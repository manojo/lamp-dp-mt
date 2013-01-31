BeginPackage["Alpha`TwosFunctions`"];

(* Standard head for CVS
	$Author: ebecheto $
	$Date: 2005/09/28 11:13:22 $
	$Revision: 1.1 $
	$Log: TwosFunctions.m,v $
	Revision 1.1  2005/09/28 11:13:22  ebecheto
	
	Usefull functions, helps understanding of Fixed Point arithmetics in MMALPHA
	
	
*)

TwosCompForm::usage=
"TwosCompForm[aRealValue,Coding:{b,m,n},options] transform a Real number into {digitsForm,Position of the comma} ex: {{0,1,0,0},1} represent 0.100 in binary and 0.5 in decimal \nType Options[TwosCompForm] for available options";
FixPointForm::usage="FixPointForm take a list of digits and an integer representing the position of the Fix Point, and add the point in the list. Ex : FixPointForm[{1,0,1,1,1},2] returns {1,0,\".\",1,1,1}";
InterpretedValue::usage="InterpretedValue[{digits,pointPos}] gives the signed value of the digit writted form with the given fix point position. Ex : InterpretedValueorm[{1,1,1,1,1,1},4] returns -0.25";
IntegerSignedForm::usage="Such as InterpretedValue, but does not care of the fix point position and return an integer. Ex : IntegerSignedForm[{1,1,1,1,1,1},4] returns -1";
TwosTable::usage="TwosTable[{list of numbers to explain},{b,m,n},options] Show numbers encoded with the Two's complement. b: bit Length. m: integerPart Length, n: fractionalPart Length. Note that b=m+n+1 because of the Sign bit. Type Options[TwosCompForm] for the options
\n\[FilledSmallSquare]a value in green has a lack of bit to be encoded with full fractionnalPart precision. \n\[FilledSmallSquare]a value in red is out of bounds. Limits are due to the choosen encoding. \n\[FilledSmallSquare]a value in orange combines the two above problem";
TwosTableToTex::usage="Same as TwosTable exept no StyleForm is applied, which permits easily a transfert into a LateX document together with the function ToLaTeX. Use it as follows :
\ntt = TwosTableToTex[{7.75, 7.5, 0.75, 0.5, 0, -0.25, -0.5, -0.75, -7.5, -7.75, -8}, {6, 3, 2}];
\nftt = FlattenAt[tt, {2}];
\nExport[\"try.tex\", LaTeXTable[ftt], \"Text\"]
";
PossibleCoding::usage="PossibleCoding[a maximum Real value, a minumin Real value] Give ideas of coding regarding the definition domain required to code properly max and min values. One might gives only one argument which integerpart is the max and Fractionnal part the min. Exemple:
\n\[FilledSmallSquare]PossibleCoding[14.2, 7.0001] and PossibleCoding[14.0001] are equivalent.";
LaTeXTable::usage="Thanks to LaTeXTables.nb Copyrighted by the CERN.1997\n
LaTeXTable[a : {{___} ...}] returns an expression ready to be Exported to a .tex file :
\nExport[\"try.tex\", LaTeXTable[{{___} ...}], \"Text\"]
Then in your main .tex files, simply type : \include{try}";


Begin["`Private`"]; 

Clear[TwosCompForm];
TwosCompForm::OutOfBounds:="`1` is not in the bounds [`2`,`3`] due to the coding choice. Error will occurs";
TwosCompForm::Approx:="`1` would be approximated to the nearest underneath value divisible by `2`";
TwosCompForm::Domain:="The domain of this Coding is : [`1`,`2`], with a precision of `3`";
Options[TwosCompForm]:={message->False,printDom->False};

TwosCompForm[a_,Codage:{b_,m_,n_},opts:___]:=
Module[{res,tcf,pos,color={0,0,0},msg},
       msg=message/.{opts}/.Options[TwosCompForm];
       If[!(-2^m<=a<=2^m-0.5^n),
	  color={1,0,0}; If[msg,Message[TwosCompForm::OutOfBounds,a,-2^m,2^m-0.5^n]]];
       If[Mod[FractionalPart[a],2.^-n]!=0,
	  color=color+{0,0.5,0}; If[msg,Message[TwosCompForm::Approx,a,0.5^n]]];
       If[a>=0,pos=0,pos=1];
       tcf=RealDigits[(-1)^pos*a-2.^(m+1)*pos,2,b,m];
       res={tcf,color}
];

Clear[FixPointForm];
FixPointForm[{digits_,pointPos_}]:=Insert[digits,".",pointPos+1];

Clear[FormerInterpretedValue];  (* unused actualy *)
FormerInterpretedValue[{digits_,pointPos_}]:=
Module[{res,tmp},
       If[digits[[1]]==0,res=FromDigits[{digits,pointPos},2.],
	  tmp=digits/.{0->1,1->0};
	  res=-FromDigits[{tmp,pointPos},2.]-2^(pointPos-Length[digits])];
       res
       (*or simply res=FromDigits[{digits,pointPos},2]-2.*digits[[1]]*)
];
Clear[InterpretedValue];
InterpretedValue[{digits_,pointPos_}]:=
   FromDigits[{digits,pointPos},2.]-(2.^(pointPos))*digits[[1]];
       
Clear[IntegerSignedForm];
IntegerSignedForm[{digits_,_}]:=
IntegerPart[InterpretedValue[{digits,Length[digits]}]]; 
(*IntegerPart is needed to get an Integer value an not a Real value. Kind of casting*)


(* This function is just FromDigit[{digits_,pointPos_},2]
Clear[FromRealDigits];
FromRealDigits[{digits_,pointPos_}]:=
 2.0^(pointPos-Length[digits])*Fold[2.0*#1+#2&,0,digits]; *)


TwosTable[ee_, Codage : {b_, m_, n_},opts:___] := Module[{tcf,couleur,iv,isf,prt},
prt=printDom/.{opts}/.Options[TwosCompForm];
If[prt,Message[TwosCompForm::Domain,-2^m,2^m-0.5^n,0.5^n]];

    TableForm[{
InputForm[#],{tcf,couleur}=TwosCompForm[#,Codage,opts];{tcf[[1]]},
{FixPointForm[tcf]},iv=InterpretedValue[tcf];
StyleForm[iv,FontColor->RGBColor@@couleur],
isf=IntegerSignedForm[tcf];
StyleForm[isf,FontColor->RGBColor@@couleur]
 } &/@ ee, 
TableHeadings -> {None, 
StyleForm[#,FontFamily->"Times New Roman",FontSize->12,FontWeight->"Bold"]&/@
{"InputForm", b bits Digits , FixedPointForm, InterpretedValue, IntegerSignedForm}}, 
TableSpacing->{3,1,1,0}]]

TwosTableToTex[ee_, Codage : {b_, m_, n_}] := Module[{tcf,color},
{
{"InputForm",ToString[b]<>"bits Digits", "FixedPointForm", "InterpretedValue", "IntegerSignedForm"},
  {#, {tcf,color}=TwosCompForm[#,Codage];tcf[[1]],
    FixPointForm[tcf],
      InterpretedValue[tcf],
	IntegerSignedForm[tcf]
	} &/@ ee
	      }	      
];

(*To check the accuracy of thoses function, launch:
<<TwosFunctions.m;TwosFunctionsExemple[]
*)

TwosFunctionsExemple[opts:___]:=TwosFunctionsExemple[{6,3,2},opts];
TwosFunctionsExemple[code:{_,_,_},opts:___]:=
TwosTable[{7.75,7.5,0.75,0.5,0,-0.25,-0.5,-0.75,-7.5,-7.75,-8,-802,1.07,15.7},code,opts];

ExpectedValue[Codage:_][a_]:=InterpretedValue[TwosCompForm[a,Codage][[1]]];
IntegerSignedForm[Codage:_][a_]:=IntegerSignedForm[TwosCompForm[a,Codage][[1]]];

Clear[PossibleCoding];
PossibleCoding[a_Real]:=RecommendedCoding[a,a];
PossibleCoding[a_Real,amin_Real]:=Module[{ai,af,aff,bi,m,n,bf,bb,mm,nn,sCode="",dCode="",iandf},
{ai,m} = RealDigits[IntegerPart[a], 2];bi=m;n=0;
If[!(-2^m<=ai<=2^m-0.5^n),Print["PB"]];
Print["To code ",IntegerPart[a]," the integerPart of ",a," (biggest Integer Part), ",bi," bits are needed including the signed bits."];
af=FractionalPart[Abs[amin]];
bf=Ceiling[Log[0.5, af]];
Print["To code ",af," the FractionalPart of ",Abs[amin]," (smallest Fractional Part), ",bf," bits are recquired but precision is not garanteed."];

iandf=Ceiling[Log[2,bf+bi+1]];
Do[sCode=sCode<>" Coding={"<>
ToString[#1]<>", "<>ToString[#2]<>", "<>ToString[#3]<>
"}"&[bb=i*2^iandf,mm=bi,nn=bb-bi-1];
dCode=dCode<>"   ["<>ToString[#1]<>", "<>ToString[#2]<>"]   "&[-2.^mm,2.^mm-0.5^n]
,{i,1,3}];
If[2*bi+bf+1<=2^iandf,
sCode=" Coding={"<>ToString[#1]<>", "<>ToString[#2]<>", "<>ToString[#3]<>
"}"&[bb=2^iandf,mm=2*bi,nn=bb-2*bi-1]
<>sCode;
dCode="   ["<>ToString[#1]<>", "<>ToString[#2]<>"]   "&[-2.^mm,2.^mm-0.5^n]
<>dCode;
];


sCode=" Coding={"<>ToString[#1]<>", "<>ToString[#2]<>", "<>ToString[#3]<>
"}"&[bb=bf+bi+1,mm=bi,nn=bb-bi-1]
<>sCode;
dCode="   ["<>ToString[#1]<>", "<>ToString[#2]<>"]   "&[-2.^mm,2.^mm-0.5^n]
<>dCode;

Print["Ideas of possible Codings are : "<>sCode];
(*Print["Which has respectives domains : "<>dCode] *)
];
PossibleCoding[___]:=Print["Real input is needed if you want to put the value \"2\" you should better enter \"2.\""];


(*Thanks to LaTeXTables.nb Copyrighted by the CERN.1997*)
(*By the way it is more some kind of Copyleft than Copyright *)
(*just added a little modif for _List and c!{}*)

Clear[LaTeXForm];
LaTeXForm[a_String] := a;
LaTeXForm[a_List] :=StringJoin@@ToString/@a;
LaTeXForm[a_ /; NumberQ[a]] := ToString[a];
LaTeXForm[a_] := "\\(" <> ToString[TeXForm[a]] <> "\\)"


Clear[LaTeXrow];
LaTeXrow[a_List] := 
StringJoin[Join[
		StringJoin [ToString[LaTeXForm[#]], " & "] & /@  
        Drop[a, -1] , {StringJoin[ToString[LaTeXForm[Last[a]]], 
				  " \\\\ \n  \n"]} (*\\hline*)
		]
	]

Clear[LaTeXTable];
LaTeXTable[a : {{___} ...}] := 
"\\begin{tabular}{" <>
StringJoin @@ Table["|c!{}", {Max[Length /@ a]}] <>
"|" <> 
"}\n \\hline\n" <>
StringJoin @@ LaTeXrow /@ a <>
"\n \\hline\n" <>
"\\end{tabular}"

Clear[ToLaTeX];
ToLaTeX[a : {{___} ...}]:=
Module[{toarray,skipn},
       toarray=StringReplace[LaTeXTable[a],
	   { (*"tabular" -> "array",*)
	    "  " -> " ", "\\hline" -> ""}];
       skipn=StringReplace[toarray, {"\n" -> ""}];
       StringReplace[skipn, {"\\\\   \end" ->"\end"}]
];



End[] (*End of Private context*)
EndPackage[];
