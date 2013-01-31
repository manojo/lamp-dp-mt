BeginPackage["Alpha`VhdlLibGen`"];
(* Standard head for CVS
	$Author: ebecheto $
	$Date: 2005/08/31 13:02:04 $
	$Revision: 1.2 $
	$Log: VhdlLibGen.m,v $
	Revision 1.2  2005/08/31 13:02:04  ebecheto
	added Head for CVS
	
 *)
Begin["`Private`"];
     
VHDLpk=packageVhdl[
	procedureVhdl[
		 "Truncate_LSB",SameType[{"totrunc","SIGNAL","IN"},{"truncated","SIGNAL","OUT"}],
	{"truncated <= totrunc(totrunc'high downto totrunc'high -truncated'length+1); \n"}
	],
	procedureVhdl[
		 "Truncate_LSSB",SameType[{"totrunc","SIGNAL","IN"},{"truncated","SIGNAL","OUT"}],
	{"truncated <= totrunc(totrunc'high-1 downto totrunc'high -truncated'length); \n"}
	],
	procedureVhdl[
		 "Truncate_MSB",SameType[{"totrunc","SIGNAL","IN"},{"truncated","SIGNAL","OUT"}],
	{"truncated <= totrunc(totrunc'low + truncated'length-1 downto totrunc'low);\n"}
	],
	procedureVhdl[
		 "Reduce_MSB",SameType[{"toreduce","SIGNAL","IN"},{"reduced","SIGNAL","OUT"}],
	{{"
        subtype LM2 is SameType (toreduce'length+reduced'low-2 downto reduced'low);
\n         variable A_Positive, A_Negative : BOOLEAN;
\n"},
	 {"
        for i in toreduce'high-toreduce'length+reduced'length to toreduce'high loop
\n          if (toreduce(i)='0') then
\n            A_Positive:=True; else
\n            A_Negative:=True; 
\n          end if;
\n        end loop;
\n        if (A_Positive and A_Negative) then
\n          if (toreduce(toreduce'high)='0') then      -- Overflow
\n            reduced(reduced'high-1 downto reduced'low)<=LM2'(others=>'1');
\n            reduced(reduced'high)<='0';
\n          else                                       -- Underflow
\n            reduced(reduced'high-1 downto reduced'low)<=LM2'(others=>'0');
\n            reduced(reduced'high)<='1';
\n          end if;
\n        else
\n          reduced<=toreduce(toreduce'low+reduced'length-1 downto toreduce'low);
\n        end if;
\n  --  <----- it is assumed that toreduce'length > reduced'length  ---->     
\n"}}
	],

	functionVhdl[
		"min",{{"L","R","INTEGER"},{"INTEGER"}},{"
	if L < R then\n
	    return L;\n
	else\n
	    return R;\n
	end if;\n"}		
	],
	functionVhdl[
		"max",{{"L","R","INTEGER"},{"INTEGER"}},{"
	if L > R then\n
	    return L;\n
	else\n
	    return R;\n
	end if;\n"}		
	],	  	
      
	functionVhdl[
		     "plusOne",SameType[{"A","B"},{""}],{{"
	variable carry: STD_ULOGIC;
\n	variable BV: SameType (A'left downto A'right);
\n	variable sum: SameType (A'left+1 downto A'right);
\n      -- add two signed numbers of the same length
\n      -- both arrays must have range (msb downto 0)
\n	-- pragma map_to_operator ADD_TC_OP
\n	-- pragma type_function LEFT_SIGNED_ARG
\n      -- pragma return_port_name Z
"},{"
	if (A(A'left) = 'X' or B(B'left) = 'X') then
\n            sum := (others => 'X');
\n            return(sum);
\n	end if;
\n	carry := '0';
\n	BV := B;
\n
\n	for i in 0 to A'left loop
\n	    sum(i) := A(i) xor BV(i) xor carry;
\n	    carry := (A(i) and BV(i)) or
\n		    (A(i) and carry) or
\n		    (carry and BV(i));
\n	end loop;
\n      sum(sum'high):=carry;
\n	return sum;
"}}
     ]


];

End[];


ToVhdlPackage::usage = "To write another thing in the package, use the following syntax :
\n\[FilledSmallSquare]procedureVhdl[\"name\",SameType[{input1,input2 ...,,IN},{output1,output2 ...,OUT},{io1,io2...,INOUT},{\"body\"}]
\n\[FilledSmallSquare]procedureVhdl[\"name\",{{ina,inb,...,IN,Type1},{inc,ind,...,IN,Type2}, ...{outa,outb,...,OUT,TypeOut1},{outc,outd,...,OUT,TypeOut2},{....,INOUT,TypeIO}...},{\"body\"}]
\n\[FilledSmallSquare]procedureVhdl[\"name\",{{ina,IN,Type},{outa,OUT,TypeOut}},{{\"variables declaration\"},{\"body\"}}]
\n\[FilledSmallSquare]procedureVhdl[\"name\",{{ina,[Designator],IN,Type},{outa,[Designator],OUT,TypeOut}},{{\"variables declaration\"},{\"body\"}}]

\n\nIf it is a function (remember that it has only one output)
\n\[FilledSmallSquare]functionVhdl[\"name\",SameType[{input1, input2 ...},{output},{\"body\"}]
\n\[FilledSmallSquare]functionVhdl[\"name\", {ina,inb,...,Type1},{inc,ind,...,Type2}, ...{TypeOut},{\"body\"}]
\n\[FilledSmallSquare]functionVhdl[\"name\", {ina,inb,...,[Designator],Type1}, ...{TypeOut},{\"body\"}]
\"text of the body of the function\"
\n\n\[FilledSmallSquare][Designator] is optional and could be : SIGNAL | VARIABLE | CONSTANT
\nThe body is either {\"body\"} or {{\"var decl\"},{\"body\"}}
\nIn \"var decl\" any pattern SameType would be interpreted as a type to enumerate by the variable 'types' defined in VhdeLibGen.m";

Begin["`Private`"];

ToVhdlPackage::pkgBody = "Body `1`  not recognized as a List";
ToVhdlPackage::noPattern = "ToVhdlPackage called with no matching pattern with: `1`";



types={"SIGNED","STD_LOGIC_VECTOR"};  (* add the differents types you need to generate multiple procedures or functions which only has same type of inputs and outputs *)



    (*  Needed function To convert a List into a String *)
ListToString[a_List] := 
    Module[{res = "", aa},
	   aa = Flatten[a];
	   Do[res = res <> ToString[aa[[i]]] <> ",", {i, 1, Length[aa]}];
	   res = StringDrop[res, -1];
	   res];

SymbolToList[a_]:=  (* Input Symbol made of List  *)
Module[{res = {}},
       Do[res=Append[res,a[[i]]],{i,1,Length[a]}];
       res
       ];
    
Clear[packDef];packDef="";Clear[packBody];packBody=""; (* Initialization *)



    (*  Join the different parts of the package *)
     (*ToVhdlPackage[]:=ToString[pk]; (*or ToVhdlPackage[Alpha`Vhdl`LibGen`pk] ...?*) *)
ToVhdlPackage[]:=ToVhdlPackage[VHDLpk]; (*or Alpha`Vhdl`LibGen`pk ...?*)
ToVhdlPackage[pkg:_packageVhdl]:=ToVhdlPackage[pkg,types];
(*ToVhdlPackage[pkg:_Alpha`Vhdl`LibGen`packageVhdl]:=ToVhdlPackage[pkg,types];*)

ToVhdlPackage[pkg:_packageVhdl,typ:_List]:=
Module[{i,L=Length[pkg],vbr=False,res=""},
       If[vbr,Print[L," elements are presents in ",pkg[[0]],". The first element is a ",pkg[[1,0]] ] ];
       Do[
	  ToVhdlPackage[pkg[[i]],typ],
       {i,L}
       ];
(*******************After the processing of all the procedures and function packDef and packBody are correctly written*********************)

       res="\n\nlibrary IEEE;\nuse IEEE.std_logic_1164.all;\nuse IEEE.std_logic_signed.all;\nuse IEEE.numeric_std.all;\n\n"
       <>"Package definition is \n\n"
       <>packDef
       <>"end definition; \n\n\n"
       <>"Package body definition is \n\n"
       <>packBody
       <>"end definition; -- Package body\n";
       res
];

(*whichever procedure or function*)  

ToVhdlPackage[pouf:_,typ:_List]:=
Module[{nbT=Length[typ],newios={},temp,body,vbody,dbg=False},
       If[MatchQ[pouf[[2]],_SameType],
	  If[dbg,Print[pouf[[0]]," is Head of pouf ",pouf[[2]],"with type Length:",nbT] ];
	  Do[
	     newios=Map[Append[#,typ[[i]]]&,pouf[[2]],{1}];
	     temp=SymbolToList[newios];
	     body=pouf[[3]];
	     If[Length[body]==2,
		vbody=StringReplace[pouf[[3,1]],"SameType"->typ[[i]] ]; (*pattern replacing*)
		body[[1]]=vbody
	     ];
	     ToVhdlPackage[pouf[[]],pouf[[1]],temp,body],
	  {i,1,nbT}
	  ],
	  If[dbg,Print["Types are allready written by user:",pouf[[2]] ] ];
	  ToVhdlPackage[pouf[[]],pouf[[1]],pouf[[2]],pouf[[3]]]  
       ]  (* without SameType, Types are allready written by user *)
];

ToVhdlPackage[_procedureVhdl,name_String,ios_List,body_List]:=
Module[{i,dbg=False,beforeIs,beforeBegin="",afterBegin,designator,inouts="",L=Length[ios],D=0},
       If[dbg,Print["ToVhdlPackage[_procedureVhdl,_String,_List,_List] nbIos:",L]];
       For[i=1,i<=L,i++,
	   designator=ToUpperCase[ToString[ios[[i,-3]]]];
	   If[designator=="SIGNAL"||designator=="VARIABLE"||designator=="CONSTANT",
	      designator=designator<>" ";D=1,
	      designator=""
	   ];
	   inouts=inouts<>" "<>designator
	   <>ListToString[Drop[ios[[i]],-2-D]]<>" : "
	   <>ios[[i,-2]]<>" "          (* IN, OUT or INOUT *)
	   <>ios[[i,-1]]<>";"
	   
       ];
       inouts=StringDrop[inouts,-1];   (*remove the last comma*)
       beforeIs="procedure "<>name<>"("<>inouts<>")";
       If[Length[body]==2,
	  beforeBegin=body[[1]]<>"\n";   (*  Declaration of Variables or types or subtypes*)
	  afterBegin=body[[2]],
	  
	  afterBegin=body;        
       ];
       packDef=packDef<>beforeIs<>";\n";
       packBody=packBody<>beforeIs<>" is\n"<>beforeBegin<>" Begin \n"<>afterBegin<>"\n end "<>name<>";\n\n"
];           

ToVhdlPackage[_procedureVhdl,name_String,ios_List,body]:=Throw[Message[ToVhdlPackage::pkgBody,body]];

ToVhdlPackage[_functionVhdl,name_String,ios_List,body_List]:=
Module[{i,dbg=False,beforeIs,beforeBegin="",afterBegin,designator,D=0,inouts=""},
       If[dbg,Prinf["Call of ToP, with _functionVhdl"] ];
       For[i=1,i<Length[ios],i++,
	   designator=ToUpperCase[ToString[ios[[i,-2]]]];
	   If[designator=="SIGNAL"||designator=="VARIABLE"||designator=="CONSTANT",
	      designator=designator<>" ";D=1,
	      designator=""
	   ];
	   inouts=inouts<>" "<>designator<>ListToString[Drop[ios[[i]],-1-D]]
	   <>" : "<>ios[[i,-1]];            
	   If[dbg,Print["|ios:",ListToString[Drop[ios[[i]],-1-D]],"|"] ]
	   (* ie, SIGNAL A,B : ZBIT *)
	   
       ];
       beforeIs="function "<>name<>"("<>inouts<>") return "<>ios[[-1]];
       If[Length[body]==2,
	  beforeBegin=body[[1]]<>"\n";   (*  Declaration of Variables or types or subtypes*)
	  afterBegin=body[[2]],
	  afterBegin=body;        
       ];

       packDef=packDef<>beforeIs<>";\n";
       packBody=packBody<>beforeIs<>" is\n"<>beforeBegin<>" Begin \n"<>afterBegin<>"\n end "<>name<>";\n\n"
];

(*Throw will stop the process, I want just a warning*)
(*ToVhdlPackage[notgood___]:=Throw[Message[ToVhdlPackage::noPattern,notgood]];*)
ToVhdlPackage[notgood___]:=Message[ToVhdlPackage::noPattern,notgood];

End[];       (* Fin du contexte prive du package *)
EndPackage[] (* Fin du package Vhdl  *)

