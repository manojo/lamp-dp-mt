(* 
  This file should be copied in the home directory of Mathematica
  The homedir of Mathematica can be found by evaluating variable
  $HomeDirectory after starting Mathematica.
*)

(* Evaluate the init file of your MMAlpha config *)
(* MMALPHA is an environment variable which should be set before *)
Get[Environment["MMALPHA"]<>"/config/init.m"];

(* Keep track of environment for debugging purpose *)
$MMAlpha = Environment["MMALPHA"];
(* Keep track of the home dir of Mathematica *)
$MMAlphaInitFile = Directory[];

(* Define your notebook environment *)
$myNotebooks = "C:/Aquinton/myNotebooks";
(* Define your own master notebook *)
$myMasterNotebook = "myMaster.nb";
