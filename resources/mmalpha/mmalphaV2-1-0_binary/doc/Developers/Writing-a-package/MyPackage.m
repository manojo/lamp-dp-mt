(* 
  The following is an example of MMAlpha package. Its structure is 
  roughly as follows: 
   - Gnu license
   - Package declaration and usage statements for exported objects.
   - Private part of the package.

  Read if carefully.

  The way this package is written is not always met by all MMAlpha 
  packages, simply because it resulted from a pretty long experience
  of using MMA (some of these experiences were pretty bad). 
  Do not complain about this : MMAlpha was written by many people over
  about 15 years, and Tanguy and myself make our best to clean code
  whenever we find some time. But time is a very expensive resource...

  Patrice Quinton
*)

(* file: $MMALPHA/lib/Package/MyPackage.m
   AUTHOR : The Alpha Contributors 
   CONTACT : http://www.irisa.fr/api/ALPHA
   COPYRIGHT  (C) INRIA
   
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   (see file : $MMALPHA/LICENSING).

   etc...

*)
BeginPackage["Alpha`MyPackage`", {"Alpha`Domlib`","Alpha`",
                                      "Alpha`Options`",
				      "Alpha`Matrix`",
                                      "Alpha`Substitution`",
                                      "Alpha`Normalization`",
				      "Alpha`Tables`"}];

(* 
  The BeginPackage statement has two arguments. The first one defines
  the name of the package, and the second one is a list of all packages
  whose functions are needed by functions of myPackage. 

  The name of a package is a string of the form Alpha`MyPackage` .
  All packages (except the root Alpha` are placed in directory 
  $MMALPHA/lib/Packages/Alpha in a file named MyPackage.m .

  Package start with an uppercase letter. Functions of MMAlpha all 
  start with a lowercase letter to avoid potential name conflicts 
  with Mathematica functions. 
*)

(*
  The commented lines below are automatically updated by CVS. 
  See the CVS usage.
*)

(* $Id: MyPackage.m,v 1.1 2006/05/28 16:22:24 quinton Exp $

   changelog:

   07/15/1993, D. Wilde:	full text specification of COBs for batch use.
   11/29/1993, Z. Chamski:	fixed normalization problem preventing
				 identity changes of basis from changing index
				 names.
   -----/1995, D. Wilde         extended change of basis
   05/05/1995, P. Quinton:      warning messages for addDimension
                                   added
   06/07/1995, F. de Dinechin   adapted changeOfBasis to handle
                                  parameters and subsystems
                                  The generalized CoB is still to do.
*)

(* Standard head for CVS

	$Author: quinton $
	$Date: 2006/05/28 16:22:24 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/doc/Developers/Writing-a-package/MyPackage.m,v $
	$Revision: 1.1 $
	$Log: MyPackage.m,v $
	Revision 1.1  2006/05/28 16:22:24  quinton
	html documentation
	
	Revision 1.1  2004/09/16 14:16:25  quinton
	Update
	
	Revision 1.32  2003/04/29 09:49:35  risset
	 added the extDomainCOB fuction and tests
	
	Revision 1.31  2003/04/18 08:35:14  risset
	added the simplifyUseInputs function
	
etc...

*)

(*
  Here should be placed a usage statement for each exported 
  object (function, option, etc.). The rule is that any 
  symbol mentioned between the BeginPackage and the Private 
  statements is visible from anywhere in Mathematica, provided
  that MyPackage has been loaded (using Get or better, Needs).
  A usage statement also provides a on line help by typing 
  ?MyPackage of ?foo as here.
  
  Be careful on the form of the usage statements: they are
  used by the automatic generator of the Alpha`Makedoc` package
  to produce the reference manual. See the file genReferenceManual.m
  in the directory $MMAlpha/doc/ReferenceManual .
*)

(* Update this note every time you do a modification of 
   the documenation *)
MyPackage::note = 
"Documentation revised on August 1st, 2004";

(* Please, respect the form of this statement *)
MyPackage::usage =
"The Alpha`MyPackage` contains the definition of the foo transformation 
(see foo)."

(*
  usage should follow as close as possible the way Mathematica 
  on line help are written.
*)
foo::usage = 
"foo[ a ] returns the a Alpha program with blue keywords.
foo[ ] runs foo on the Alpha program contained in $result";

(* 
  A function may have options. Options are MMA rules. Some options,
  such as debug or verbose are "standard". They are defined in the 
  Options package. See inside the foo function how options are used.

  Other options, as color here, are related to only one function.
  They should be documented using a usage statement, in order to be
  exported and have an on-line help. With this options, the foo 
  function could be used as
  foo[ program, debug -> True, color -> Green ]
*)
Options[ foo ] = { debug -> False, verbose -> False, color -> Blue }

color::usage = 
"color is an option of foo. Default is Blue. Can be set to any other 
color defined in the AllColors package.".

(*
  The Private statement starts the private part of the package. 
  Here will be written all functions of the package. Those functions, 
  such as foo, who have a usage statement before the Private statement
  are de facto external functions. The others are private functions.
*)
Begin["`Private`"];

(* 
  Definition of the foo function. It starts with a mandatory 
  Clear statement, in order to make sure that the full definition 
  of the function is cleaned when the package is loaded.
*)
Clear[ foo ];

(* 
  A first definition (by pattern matching). If foo is called with 
  no first argument -- but possibly with options, then foo[ $result ]
  should be called. $result is actually a global symbol defined in 
  the Alpha` package. It contains usually the current Alpha program.
*)
foo[ opt___Rule ] := foo[ $result, opts ];

(*
  Another definition, when the first argument is given
*)
foo[ a:_system, opts:___Rule ] :=
(* A Catch statement to catch potential Throw statement for 
  exceptions 
*)
Catch[
  (* Please, indent 2 characters ... *)
  (* A Module allows some local declarations to be used *)
  Module[ {localId1, localId2, dbg, vrb, cl },
    (* Capture options *)
    (* These statements are very standard. dbg will get the 
       value of the debug option, once replaced either by the
       {opts} list of rules, or, by default, by the Options[ foo ]
       list of default options
    *)
    dbg = debug/.{opts}/.Options[ foo ];
    vrb = verbose/.{opts}/.Options[ foo ];
    cl = color/.{opts}/.Options[ foo ];

    (* Typical argument check : tests some condition 
      on the a argument, then in case of error, throws a
      message which is captured by the enclosing Catch 
      statement. This has three effects. First, a (clear?) 
      error message is issued. Second, the structure of 
      the code is quite clear, as a Throw provides a sort
      of escape mechanism. Third, the foo function can be
      run inside a Check statement which checks whether an
      error message is issued, and take the appropriate action.
      See an example below. 
      Note : do not issue a message unless an error happens.
      If case of warning, print a warning message.  
     *)
    If[ badQ[a], 
      (* It is a good practice to put the error message definition
        close to its use for reading code purpose *)
      foo::badprog  = "bad argument";
      Throw[ Message[foo::badprog] ]
    ];

    (* 
      Here is an example of a "safe" call to a MMAlpha function, 
      named someMMAFunction. Assuming that someMMAFunction has been
      written in such a way that an error message is issued if an
      error occurs, then the Check function will evaluate the second
      part (see the Mathematica Help) and throw an exception. It
      may be needed or not to issue a new error message at your 
      convenience. To avoid a cascade of error message, one may
      just evaluate Throw[ Null ] to throw the Null expression. 
    *)
    localId1 = 
      Check[ someMMAFunction[ a ],
        foo::error1 = "error while calling someMMAFunction";
        Throw[ Message[ foo::error1 ] ]
      ];

    etc...
  ]
];

(* 
  Last but not least. This statement ensures that it foo is called
  with a wrong argument, then an error message is issued (which can
  be catched by a Check statement. Here the message foo::params is
  standard and defined in the Alpha package by a GeneralMessage 
  statement. But you could replace this by any other message...
*)
foo[___] := Message[ foo::params ];

(* 
  This is a private function. Actually, it can be called from
  anywhere with the name Alpha`MyPackage`Private`privateFoo[ ... ]
  which is of course not obvious... This is how MMA hides private
  objects...
*)
Clear[ privateFoo ];
privateFoo[ ... ] :=
privateFoo[___] := Message[ privateFoo::params ];

End[]; 
EndPackage[];


