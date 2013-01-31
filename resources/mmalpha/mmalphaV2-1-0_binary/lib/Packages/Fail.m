BeginPackage["Fail`"];

Attributes[verbFail] = {};
Attributes[chkFail] = {};
ClearAll[chkFail];
ClearAll[verbFail];

chkFail::usage = "chkFail[a] throws an exception if a is $Failed, else
returns a";
verbFail::usage = "verbFail[mess, expr] prints the message if expr is
$Failed, and returns exp";

Begin["`Private`"];

chkFail[a:_] := If[a===$Failed||a===Null,Throw[$Failed],a];
verbFail[mess:_, expr:_] := If[expr===$Failed,Message[mess];$Failed,expr];

Attributes[verbFail] = {Protected, ReadProtected, HoldFirst};
Attributes[check] = {Protected, ReadProtected};

End[];
EndPackage[];
