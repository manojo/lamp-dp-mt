(* Test for the AlpHard to Vhdl package: This AlpHard program is 
from Yannick/Tanguy Grobner basis computations *)

(* initial setting: assigning the parameters for the module *)
dir=Directory[];
dirGrob="/udd/risset/alpha_beta/Mathematica/tests/TestVhdl/Grobner/";
SetDirectory[dirGrob];

load["root.alpha"];
(* analyze[{recurse->True}]; Quite long! *)
 assignParameterValue["Tinit",0];
 assignParameterValue["Duration",6];
 assignParameterValue["Nbproc",5];
(* asave["root065.alpha"]  *)
lib1=Drop[$library,-1];
load["root065.alpha"];
$library=Append[lib1,$result];

(* Vhdl generation *)
SetDirectory["/tmp"];
av[]
files={"definition.vhd","addition.vhd","coefcomp.vhd","cell1b.vhd","sortcell.vhd","galmul.vhd","multiplex.vhd","total.vhd"}

Clear[copyTailFile]
copyTailFile[file1_String,file2_String]:= 
  Module[{},
	   Run["tail +3 "<>file1<>" >> "<>file2]];
Clear[diffTailFile]
diffTailFile[file1_String,file2_String]:= 
  Module[{},
	 Run["diff "<>file1<>" "<>file2]];

MapThread[copyTailFile,{files,Map[StringJoin["/tmp/T",#] &,files]}]; 
MapThread[copyTailFile,{Map[StringJoin["/tmp/",#] &,files],
			Map[StringJoin["/tmp/Good",#] &,files]}] ;
res=MapThread[copyTailFile,{Map[StringJoin["/tmp/T",#] &,files],
			Map[StringJoin["/tmp/Good",#] &,files]}] ;
t1=If [res===Table[0,{i,1,Length[res]}],
    Print["OK"];
    DeleteFile[Map[StringJoin["/tmp/Good",#] &,files]];
    DeleteFile[Map[StringJoin["/tmp/T",#] &,files]];
    True,
    Print["Problem during comparison of vhdl files, see vhd files in /tmp/ "];False]

(* For simulation  *)
(* load["root.alpha"];
inlineAll[];
 assignParameterValue["Tinit",0];
 assignParameterValue["Duration",6];
 assignParameterValue["Nbproc",5];
 asave["inroot065.alpha"]; *)
load["inroot065.alpha"];
writeC["/tmp/root065.c"];
Run["cc /tmp/root065.c -o /tmp/root065 "];
Run["/tmp/root065 < data >/tmp/result"];
t2=testFunction[diffTailFile["result","/tmp/result"],0,"vhdl 2"]

(* load["cell1.alpha"];
inlineAll[];
 assignParameterValue["Tinit",0];
 assignParameterValue["Duration",6];
asave["inroot055.alpha"]; 
writeC["cell106.c"];

load["newsort.alpha"]
inlineAll[];
 assignParameterValue["Tinit",1];
 assignParameterValue["Tinit2",1];
 assignParameterValue["Duration",5];
asave["inroot066.alpha"]; 
writeC["sort116.c"]; *)

SetDirectory[dir];
If [t1 && t2, 
    Print["VHDL Tests OK "];True,
    Print["Problems during VHDL tests"];False];
