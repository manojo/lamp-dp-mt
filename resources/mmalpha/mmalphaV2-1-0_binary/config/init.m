(* Standard head for CVS

        $Author: quinton $
        $Date: 2009/05/22 09:44:37 $
        $Source: /local/chroot/cvsroot/irisa/mmalpha/config/init.m,v $
        $Revision: 1.4 $
        $Log: init.m,v $
        Revision 1.4  2009/05/22 09:44:37  quinton
        May 2009

        Revision 1.3  2008/12/30 18:17:40  quinton
        Added an instruction regarding the encoding used in MMAlpha, in order to avoid a lot of extra messages when loading the packages (with version 6. of MMA). Hope that this was the right thing to do.

        Revision 1.2  2008/07/27 14:24:56  quinton
        Most recent version.

        Revision 1.1.1.1  2005/03/07 15:32:10  trisset
        testing mmalpha repository

        Revision 1.44  2004/06/08 16:21:57  quinton
        Mise a jour corrections mineures

        Revision 1.43  2001/06/22 07:23:47  risset
        *** empty log message ***

        Revision 1.42  1999/07/21 15:32:40  risset
        commited for GNU release 1.0

        Revision 1.41  1999/05/12 08:28:42  risset
         load options.m before Alpha.m

        Revision 1.40  1999/05/07 09:23:25  risset
        added init_user.bash

        Revision 1.39  1998/12/14 15:44:40  quillere
        new init.m for autoload stuff

*)

(* Print a message... *)
$CharacterEncoding = "IsoLatin1";
Print["****************"];
Print["Loading MMAlpha V2 (LipForge)..."];
Print["Executing init.m file in $MMAlpha/config/init.m "];

(* First of all, set the root of the Alpha-related directories *)
Unprotect[Alpha`$rootDirectory];
Alpha`$rootDirectory =  Environment["MMALPHA"];
Protect[Alpha`$rootDirectory];

If[Alpha`$rootDirectory===$Failed,
  Print["Environment variable MMALPHA is not defined."];
  Print["Alpha cannot be loaded."];
  Quit[]
];
   
Print["MMALPHA environment variable is ", Environment["MMALPHA"] ];

(* Extend Mathematica's search path for 'standard' packages *)
$Path = Append[$Path, Alpha`$rootDirectory<>"/lib/Packages"];

Off[Syntax::com];

Get["setup.m"]; 

(* 'forceload' the basic definitions *)
(* The default value for $RecursionLimit, 256, has proven to be too
   small when manipulating huge programs. *)
(* Even more, 1024 is not enough for scheduling we set it to 10000 *)
$RecursionLimit = 100000

Needs["Alpha`Options`"];
Needs["Alpha`Domlib`"];
Needs["Alpha`"];

(* And a nice greeting... *)
Print["---"];
Print["Alpha V2.0 Initialization"];
Print["The Documentation can be found in ",Environment["MMALPHA"],"/doc/user"];
Print["Current version in ", Environment["MMALPHA"]];
Print["Current directory is ",Directory[]];
Print["If you use the notebook interface, you can open the master notebook: "]
Print["In[1]:= start[];"];
(*      
        Remove all symbols created at the global level on the fly
        Remove["Global`*"];

*)
Print["End of init.m"];
