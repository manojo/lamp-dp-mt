(* file: $MMALPHA/lib/Package/Alpha.m
   AUTHOR : The Alpha Contributors 
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

(* 
  Modified for MacOSX. Actually, I wonder whether I should make any
  difference with Unix
*)
Which[
  $OperatingSystem == "MacOSX",
  Print["Mac OS X version "];
  BeginPackage["Alpha`",{"Alpha`Options`","Alpha`Domlib`"}]
,
  $OperatingSystem == "Unix",
  Print["Unix version "];
  BeginPackage["Alpha`",{"Alpha`Options`","Alpha`Domlib`"}]
,
  $OperatingSystem == "WindowsNT",
  Print["Windows NT version "];
  BeginPackage["Alpha`",{"Alpha`Options`","Alpha`Domlib`"}]
];
	
 
(* Modification of June 23, 2001. To run MMAlpha on Windows 2000, I 
   needed to change the default value of $TemporaryPrefix, now
   set to C:/Temp/. P. Quinton. 
   By the way, I also de-commented the DeleteFile for temporary
   files 
*)

(*      $Author: quinton $
	$Date: 2008/07/31 16:56:16 $
	$Source: /local/chroot/cvsroot/irisa/mmalpha/lib/Packages/Alpha.m,v $
	$Revision: 1.10 $
	$Log: Alpha.m,v $
	Revision 1.10  2008/07/31 16:56:16  quinton
	The report function of PipeControl.m was extended. It is much more accurate, and it fills on the fly a global variable, $showGraph which can be user to generate a .dot file for
	GraphVis. The $showGraph variable is defined in Alpha.m. It can be used by the function
	showViz which is in VertexSchedule. Another function, showDepViz generates a .dot
	file to display the dependence graph using GraphViz.
	
	Revision 1.9  2008/07/27 13:24:16  quinton
	Minor edition differences.
	
	Revision 1.8  2008/04/21 19:42:59  quinton
	Modification to the load function. A mute option was added. If True, load prints nothing
	
	Revision 1.7  2008/04/01 19:36:30  quinton
	Added the Visual3D package
	
	Revision 1.6  2007/04/09 17:14:34  quinton
	show command allows use dependencies to be viewed now
	
	Revision 1.5  2005/09/21 17:55:17  ebecheto
	update VhdlLibGen
	
	Revision 1.4  2005/04/12 13:01:03  trisset
	resolved conflict
	
	Revision 1.3  2005/04/07 16:46:08  quinton
	Adaptation to MacOSX
	
	Revision 1.2  2005/03/24 09:01:33  ebecheto
	updated the autoload list
	
	Revision 1.1.1.1  2005/03/07 15:32:11  trisset
	testing mmalpha repository
	
	Revision 1.91  2005/03/02 13:36:48  risset
	commit before canada
	
	Revision 1.90  2004/09/16 13:39:28  quinton
	Updated documentation
	
	Revision 1.89  2004/08/02 13:12:44  quinton
	Documentation updated for reference manual
	
	Revision 1.88  2004/06/09 15:11:50  quinton
	Minor corrections in the tests function
	
	Revision 1.87  2004/04/23 15:14:44  quinton
	New version including data-flow schedules. This version of Alpha has been
	dos2unixed.
	
	Revision 1.86  2004/03/12 16:44:38  quinton
	Minor editing corrections.
	
	Revision 1.85  2004/01/09 16:43:51  quinton
	Minor corrections
	
	Revision 1.84  2003/07/16 13:13:36  quinton
	A small bug found in read_alpha for Windows, since the parameters
	should not be separated by spaces...
	
	Revision 1.83  2003/06/27 13:59:31  risset
	supressed the ishow and showZP function which are replaced by show
	
	Revision 1.82  2003/01/17 09:47:28  risset
	commit after a long silence by Tanguy (before visiting Rennes)
	
	Revision 1.81  2002/11/15 08:44:26  quinton
	Two variables, $myNotebooks and $myMasterNotebook were created. They
	can be assigned respectively to the path towards a directory where the user has
	its own notebooks, and to the name of the "master" notebook of the user in the
	$myNotebooks directory. Then, a function myStart has been added, which works
	in a similar way as start, and a function link allows to create a button toward a
	user's notebook.
	
	Revision 1.80  2002/09/11 13:27:37  risset
	after update of patrice changes
	
	Revision 1.79  2002/07/16 12:51:53  quinton
	Minor modifications.
	
	Revision 1.78  2001/12/13 08:47:57  risset
	added the BitOperateur.m
	
	Revision 1.77  2001/10/29 16:29:25  quinton
	Added call to SystemProgramming
	
	Revision 1.76  2001/09/03 06:09:39  quinton
	Added a new global variable $runTime to keep track of information
	related to schedule. This variable is set by the schedulers, and
	may be used for performance measurements.
	
	Revision 1.75  2001/08/23 15:23:32  risset
	*** empty log message ***
	
	Revision 1.74  2001/08/16 16:10:07  quinton
	Added Schematics package.
	
	Revision 1.73  2001/08/14 14:22:53  quinton
	The temporaryFile function has been changer for compatibility
	with MMA under Windows2000.
	
	Revision 1.72  2001/07/09 14:20:32  risset
	merged with Patrice version
	
	Revision 1.71  2001/05/22 12:15:10  quinton
	Typos
	
	Revision 1.70  2001/04/09 16:06:44  quinton
        Correction of typo (Lenght instead of Length), and 
        extension of show to use in dependence tables.
	
	Revision 1.69  2000/07/04 10:05:23  quinton
	Ajout de lappel de Vhdl2.m
	
	Revision 1.67  2000/02/14 08:26:46  risset
	correct a bug in DomEqulities
	
	Revision 1.66  1999/12/10 16:59:49  risset
	commited struct Sched and ZDomlib
	
	Revision 1.65  1999/10/11 13:26:27  quinton
	Symbol equation added in list of protected Alpha symbols
	
	Revision 1.64  1999/07/21 15:32:53  risset
	commited for GNU release 1.0
	
	Revision 1.63  1999/05/19 07:29:47  risset
	Few things
	
	Revision 1.62  1999/05/12 08:28:23  risset
	 load options.m before Alpha.m
	
	Revision 1.61  1999/05/10 15:20:54  risset
	supressed the Decomposition Package, put it in Cut
	
	Revision 1.60  1999/05/10 14:56:18  alpha
	 changed things for docs
	
	Revision 1.59  1999/05/10 13:15:12  risset
	modify several thing for the refernce Manual, supressed Packages Equivalence and Transformation
	
	Revision 1.58  1999/05/06 14:31:20  quillere
	Added INorm package, replacing Inormalize
	
	Revision 1.57  1999/05/05 10:57:18  risset
	added Properties.m
	
	Revision 1.56  1999/04/30 09:58:51  quinton
	Version mise a jour avec les corrections de Patrice
	
	Revision 1.55  1999/04/29 10:22:58  risset
	 little things
	
	Revision 1.54  1999/04/23 08:26:02  risset
	some sligth modifs
	
	Revision 1.53  1999/04/19 15:26:12  risset
	write Back my version of Alpha with correction on readAlpha for notebooks, there is a clash with the previous verison of patrice
	

	Revision 1.48  1999/03/26 15:03:02  risset
	some slight modif for PC
	
	Revision 1.47  1999/03/24 16:31:14  risset
	commited Alpha.m for PC
	
	Revision 1.46  1999/03/24 16:18:59  risset
	version compatible with PC
	
	Revision 1.45  1999/03/17 15:08:20  risset
	add changes for compatibility with WindowsNT version
	
	Revision 1.44  1998/12/16 13:38:30  risset
	added simplifySchedule
	
	Revision 1.43  1998/12/15 13:14:34  alpha
	added Check* packages in autoload packages list
	
	Revision 1.42  1998/12/15 13:13:01  quillere
	moved the autoload file to lib/Packages/Alpha/ instead of lib/Packages/
	
	Revision 1.41  1998/12/14 14:52:14  quillere
	moved the autoload stuff outside of the package context (I don\`t know what was wrong with it )
	
	Revision 1.40  1998/12/11 16:22:11  quillere
	Added the autoload stuff
	
	Revision 1.39  1998/12/10 16:10:08  quillere
	Remove $result, $program, $library, $schedule form the protected symbols list !
	
	Revision 1.38  1998/12/10 15:49:35  quillere
	Corrected an unbalanced ] and moved  an unuseful ,
	
	Revision 1.37  1998/12/08 16:34:02  risset
	started the cleaning up gor GNU licence
	
	Revision 1.36  1998/11/06 13:39:21  quinton
	Correction to the definition of systemNames
	
	Revision 1.35  1998/10/30 09:04:25  quinton
	The function systemNames was added by P. Quinton.
	
	Revision 1.34  1998/07/03 12:39:42  risset
	put back demoDirectory

	Revision 1.32  1998/05/04 11:46:19  risset
	commited tag v0-9-1

	Revision 1.31  1998/04/30 14:31:34  risset
	*** empty log message ***

	Revision 1.30  1998/04/24 14:34:10  quinton
	Functions on[], demoLink, fileName, packageLink added

	Revision 1.29  1998/03/20 08:03:22  quinton
	Added a few global variables

	Revision 1.26  1997/10/09 12:40:40  quillere
	Bug in writeC: passed $result instead of specified system to write_c

	Revision 1.25  1997/06/26 14:14:16  risset
	commited Alphard.m v1

	Revision 1.24  1997/05/19 10:42:33  risset
	corrected exported bug in depedancies

	Revision 1.23  1997/05/13 13:40:36  risset
	report Patrice modifs on usage

	Revision 1.22  1997/05/13 13:06:25  alpha
	alsj

	Revision 1.21  1997/04/10 09:17:11  fdupont
	Domlib mathlink modified so that the Global context is no longer needed.

	Revision 1.20  1997/04/08 13:05:16  risset
	 tanguy's changes

	Revision 1.19  1997/02/12 13:44:24  fdupont
	Cleaned up putSystem

	Revision 1.18  1996/07/24 09:16:34  alpha
	adding showZpol

	Revision 1.17  1996/07/24 09:06:38  fdupont
	Correction d'un bug de readExp, readMat, readDom lorsque la liste de parametres etait vide (Florent)

	Revision 1.16  1996/07/22 14:49:34  risset
	added showZpol (as show)

	Revision 1.5  1996/06/24 13:55:15  risset
	added standard head comments for CVS
*)

Unprotect[add, affine, and, binop, boolean, bottom, call, case, const,
  decl, depend, div, domain, dtable, eq, equation, 
  exportAlphaFunctions,
  ge, gt, idiv, if, integer, le, let, loop, lt, matrix, max,
  min, mod, mul, neg, not, notype, or, pol, real, reduce,
  restrict, sqrt, sub, system, unknown, unop, use, var, xor,
  zpol,  sched, scdc, quast, newParam, pip, $testDirectory, $tmpDirectory,
  $demoDirectory, $rootDirectory, $MMALPHA, equation, integerOp, 
  dependuse, fixedPointOp	 
];

 General::WrongArg = "wrong pararameters";
 General::params = "wrong pararameters";

Alpha::note = 
"Documentation revised on August 10, 2004";

Alpha::usage = 
"MmAlpha is a Mathematica-based implementation of the
ALPHA language.  The \"Alpha`\" package contains basic commands for
the MmAlpha system.  The name \"Alpha`\" is also a root name for all
packages and symbols of MmAlpha.";

Alpha::note = 
"In this package, there is a description of some structures (domain,
pol), of global variables ($coneList, $demoDirectory, $depCone, 
$library, $masterNotebook, $MMALPHA, $myMasterNotebook, $myNotebooks, 
$program, $result, $rootDirectory, $schedule, $scheduleLibrary, 
$testDirectory, $tmpDirectory, $showGraph), and finally of some functions. Among these, 
ashow, ashowLib, asave, asaveLib, getSystem, load, myStart, putSystem,
save, saveLib, show, showLib, showMat, start, and systemNames
are important for a user. Functions getPart, readAlpha, readDom, 
readExp, readDom, testFunction, tests, varTypes, writeC, astQ, 
fileName, openTemporary, getTemporary, packageLink, demoLink, docLink, 
link, exportAlphaFunctions, and setMMADir are useful for developers. 
Function writeTex, enTete, and wrap are unused of incomplete."

domain::usage = 
"domain[dim, idx, lpol] is the structure representing 
a domain. dim is the (integer) dimension of the domain, 
idx is the list of dimension names and lpol is a list of
polyhedra or of Z-polyhedra. See also ?pol or ?zpol.";

domain::note =
"Domains of Alpha are either polyhedra, unions of polyhedra, Z-polyhedra, 
i.e., intersection of a polyhedron and of a lattice, or unions of 
Z-polyhedra. Note also that in domains of Z-Polyhedra, the 
index part is empty.";

pol::usage = 
"pol[nbConstraints, nbRays, nbEq, nblines, cons, rays] is 
the representation of a polyhedron in Alpha.
nbConstraints (integer) is the number of
constraints (equalities and inequalities), 
nbRays (integer) is the number of rays
(including lines), nbEq (integer) is the number of equalities,
nblines (integer) is the number of lines, cons (matrix) is the
set of equalities and inequalities, and rays (matrix) is the 
set of rays and lines. Inequalities and rays are represented
by lists of integers with a leading 1, and equalities or lines
by lists of integers with a leading 0. See also ?domain and ?zpol.";

zpol::usage = 
"zpol[m, lpol] is the representation of a Z-polyhedron in Alpha.
m is an Alpha matrix which represents the Z-lattice, and lpol
is a list of polyhedra. See also ?domain and ?pol.";

$coneList::usage=
"$coneList contains the list of dependence cones of all 
the dependences of $result. This variable is set by the 
initUniformization function, and it is a list of domains.";

$demoDirectory::usage = 
"$demoDirectory contains the path of the demo directory of MMAlpha."; 

$depCone::usage= 
"$depCone is a glocal variable which contains the 
dependence cone of $result. This variable is set by the
initUniformization function, and is in domain.";

$showGraph::usage = 
"this global variable is set by the report function";

$library::usage =
"$library is the Mathematica symbol which holds the list of Alpha
programs (systems and subsystems) most recently loaded using
load. The system in $result is also present in  $library.";

$masterNotebook::usage = 
"$masterNotebook is the path of the master.nb notebook, which gives 
access to all demo notebooks on Alpha. To open it, use the command 
NotebookOpen[$masterNotebook] or start[].";

$MMALPHA::usage = 
"$MMALPHA contains the path of the MMAlpha directory. This variable is 
set by an environment variable called MMALPHA."; 

$myMasterNotebook::usage = 
"$myMasterNotebook is the name of the notebook that you have placed
in the $myNotebooks directory to access your own examples. To open
it, evaluate myStart[].";

$myNotebooks::usage = 
"$myNotebooks contains the path of the directory containing your examples.
You can set this path in your init.m file. This file, placed in your home
directory, is loaded by Mathematica before any other Mathematica command."

$program::usage =
"$program is a Mathematica symbol which keeps the abstract
syntax tree of the source of any transformation. It is initialized
by load, and changed when a (second) transformation is applied. The
most recent AST is kept in $result (see ?$result)";

$result::usage =
"$result is the Mathematica symbol which holds the result of the
most recent operation (load or transformation). It is the default
source program for many transformations. When it is used by default by
a transformation, it is also modified by this transformation";

$rootDirectory::usage ="$rootDirectory contains the path of the MMAlpha 
directory. It is set to $MMALPHA"; 

$schedule::usage = 
"$schedule is the Mathematica symbol that contains the schedule 
information of a system after the execution of the schedule or
the scd functions. The format of $schedule is:\n
scheduleResult[name, \n
  List[{var, varIndices, sched[tauVect, constCoef]}],\n
  objFunction].\n 
where name is the name of the system, var is a variable of sys,
varIndices is the list of indexes of var, tauVect is a list
of integer corresponding to the linear part of the schedule of
var, constCoef is the affine part, and objFunction is the 
objective function that was used to find the schedule.";

$scheduleLibrary::usage=
"$scheduleLibrary is the list of the schedules that have been computed for 
various programs since the beginning of the current session."

$testDirectory::usage = 
"$testDirectory is the path name of the directory that contains the 
test files for all packages. Currently set to $MMALPHA/tests/";

$tmpDirectory::usage = 
"$tmpDirectory is the pathname of the directory that will be used 
for all temporary files, i.e. /tmp/ on unix, C:/tmp/ on WindowsNT 
(strongly recommended).";

$runTime::usage = 
"$runTime is a global variable that stores the running time of 
the scheduler."; 

(* file functions *)
ashow::usage = 
"ashow[sys] pretty prints in array notation the program contained in sys. Default value of sys is $result. See also show.";

ashowLib::usage =
"ashowLib[lib] prints in array notation all the systems of a library lib. 
Default value of lib is $library. Warning, currently does not work 
on notebooks, use ashow[lib] instead. See also show, ashow.";

asave::usage = 
"asave[sys,filename] saves the array notation pretty printed version of
$result in file filename. Default value of sys is $result. See also
save, load, saveLib, asaveLib.";

asaveLib::usage =
"asavelib[lib,filename] saves in array notation all systems 
contained in library lib in file filename. Default value of 
lib is $library. See also save, asave.";

fshow::usage = "obsolete form of show.";

getPart::usage = 
"getPart[exp,position] returns the subexpression of exp which is
designated by position.  The parameter position is a list of integers
following the convention of the Mathematica function Position. For
example, getPart[exp,{2,3}] identifies the third subtree of the second
subtree of exp. Warning: getPart does not accept in second parameter a
list of positions such as those returned by the Mathematica function
Position.";

getSystem::usage =
"getSystem[sys,lib] extracts the system named sys from the library lib 
and selects it as the current system. Default value of lib is 
$library. See also putSystem.";

load::usage = 
"load[filename] parses the ALPHA program contained in file filename 
and returns the corresponding abstract syntax tree. As a side effect, 
symbols $program and $result are loaded with the parsed program.
See also save, asave, asaveLib.";

myStart::usage = 
"myStart[] opens the $myMasterNotebook notebook placed in the
directory $MMALPHA/myNotebooks.";
on::usage = "on[] is an obsolete form of start[]. It opens the Master 
Notebook.";

putSystem::usage =
"putSystem[sys,lib] puts the system sys (default $result) into library 
lib (default $library). If sys already exists in lib, it is replaced, 
otherwise it is appended. See also getSystem.";
putSystem::params = "called with wrong parameters.";

readAlpha::usage =
"readAlpha[filename] parses the ALPHA program in file filename
and returns its abstract syntax tree. Does not modify $program 
nor $result.";

readDom::usage =
"readDom[dom] parses the ALPHA domain dom and returns its abstact syntax
tree. To parse a parametric domain such as {i|i<N}, it is
mandatory to supply the parameter domain or the parameter 
names as a second argument, for example:\n
readDom[\"{i,j | ... }\", {\"N\"}]\n
readDom[\"{i,j | ... }\",domain[1,{\"N\"}, ...] ] .";

readExp::usage =
"readExp[exp] parses the ALPHA expression exp and returns its 
abstact syntax tree. readExp[exp,paramNames] or 
readExp[exp,paramDom] are used  to parse a parametric
expression. Example: \n
readExp[\"A.(i,j,N->N,N) + B.(i,N->i,N)\"]\n
readExp[\"A.(i,j->N) + B.(i->i)\", {\"N\"}]\n
readExp[\"A.(i,j->N) + B.(i->i)\", domain[1,{\"N\"}, ...] ].";

readMat::usage = 
"readMat[dep] parses the ALPHA dependency dep and returns its matrix 
abstract syntax tree. To parse a parametric dependency such as (i,j->N),
it is mandatory to supply the parameter domain 
or the parameter names, e.g.:\n
readMat[\"(i,j,N->i)\"]\n 
readMat[\"(i,j->i)\", {\"N\"}]\n
readMat[\"(i,j->i)\",domain[1,{\"N\"}, ...] ] ." ;

save::usage = 
"save[sys,filename] saves the standard notation pretty printed
version of sys in file filename. Default value of sys is $result.
See also load, asave, saveLib, asaveLib.";

saveLib::usage =
"savelib[lib,filename] saves all systems contained in library lib
in file filename in standard notation.";

show::usage=
"show[var] pretty-prints the program, the domain, the matrix or 
the schedule contained in symbol var. Default value of var is 
$result. show[var, p] pretty prints the domain or the matrix 
contained in symbol var taking parameter domain p into account. 
var and p should be abstract syntax trees.";

showLib::usage = 
"showLib[lib] prints all the systems of library lib in standard notation. 
Default value of lib is $library. Warning, currently does not 
work in notebooks, use show[lib] instead";

showMat::usage = 
"showMat[m] pretty-prints the matrix m in Alpha format.";

start::usage = "start[] opens the Master Notebook.";

systemNames::usage = 
"systemNames[] returns the list of system names loaded in $library."; 

testFunction::usage = 
"testFunction[expr,resOfExpr,message_String] is used for building tests. It
evaluates expr and compare it the resOfExpr, return True if the two are 
equal, False otherwise and prints a standard message (using the information 
of message: usually a test number to identify the test). This function is
for developers.";

tests::usage = 
"tests[PackageName] call the test procedure for the package 
PackageName. tests[] calls the test procedure 
for all MMAlpha packages. Warning: a complete test takes a long time.";

varTypes::usage= 
"varTypes[sys] lists the types of all variables of sys. Default value
of sys is $result."

writeC::usage = 
"writeC[sys,f,opts] generates C code from the system sys in file f.  
Default value of sys is $result and default value of f is \"Alpha.c\". 
opts are options that are sent to the C generator. 
Option \"-p num1 num2 ...\" sets Alpha parameters to value 
num1, num2, etc. The C code is correct only if all Alpha parameters 
are assigned values. The \"-g\" option provides a debug version, 
where all equation calls are printed out. The \"-s\" option is for 
the generation of C code to be interfaced with the Signal language. 
WARNING: writeC does not work properly for systems with unbounded domains.";

writeTex::usage =
"writeTex[sys,f] generates the Latex form of the program
contained in symbol sys (default $result) into file f 
(default \"Alpha.tex\") of the current directory. 
writeTex[...,\"-a\"] produces a program in array notation. 
Warning: writeTex overwrites an already existing output f file.";

writeTex::note =
"This function is available only on Unix, and seldom used. Its 
output is not guaranteed.";
    
astQ::usage = "astQ[exp] is True if expression exp is an AST, False otherwise.";

(* A function to create fileNames *)
fileName::usage = 
"fileName[{__String}] returns the path expression corresponding to the
file according to the operating system in use. Actually, this function 
is not necessary, since Mathematica converts all pathnames from the 
Unix form.";

openTemporary::usage = 
"openTemporary[] works as the Mathematica function OpenTemporary, but
opens the file in the $tmpDirectory and return the corresponding 
stream. The command Close[openTemporary[] returns the name of 
the temporary file (warning: there is an inconsistency in this 
function due to Mathematica between the Unix version and the WindowsNT 
version: on Unix, the full name returned is (\"/tmp/...\") while 
on WindowsNT, only the name of the file is returned. Please use 
getTemporaryName[] to get the name of a temporary file instead.";
 
getTemporaryName::usage=
"getTemporaryFile[] returns the full name of a new temporary file. 
It is equivalent to Close[OpenTemporary[]] on a unix plateform and 
it has the same behaviour on other plateforms.";

(*
packageLink::usage = 
"packageLink[doc] creates an hyperlink button aiming at the Alpha 
package documentation notebook \"doc.nb\". This button may then be cut 
and pasted anywhere. Clicking on the button opens the package 
documentation notebook. Example:\n
packageLink[\"Alpha\"]\n
creates a button aiming at the documentation notebook Alpha.nb 
placed in directory $MMALPHA/doc/packages/Alpha.";
*)

demoLink::usage = 
"demoLink[demo] creates an hyperlink button aiming at the Alpha 
demo notebook \"demo.nb\". This button may then be cut and pasted anywhere. 
Example:\n
demoLink[\"Fir\"]\n
creates a button aiming at the demo notebook Fir.nb 
placed in directory $MMALPHA/demos/NOTEBOOKS/Fir.\n
demoLink[d,demo] creates an hyperlink button aiming at notebook 
demo.nb in directory d of $MMALPHA/demos/NOTEBOOKS.";

docLink::usage = "docLink[file] creates an hyperlink button
aiming at the Alpha documentation notebook \"file.nb\". This button may then be
cut-and-pasted anywhere. docLink[d:_String, file:_String] creates an
hyperlink button aiming at notebook file.nb in directory d of
$MMALPHA/doc/packages."

link::usage = 
"link[file] creates an hyperlink button aiming at the Alpha
notebook \"file.nb\" in directory $myNotebooks. This button may then
be cut-and-pasted anywhere. link[d, file] creates an
hyperlink button aiming at notebook \"file.nb\" in directory d of
$myNotebooks."

exportAlphaFunctions::usage = 
"exportAlphaFunctions[] writes DeclarePackage commands for all functions 
of the MMAlpha standard packages. This function is automatically executed
when loading Alpha.m (see after the EndPackage instruction) whenever the
autoload.m does not exists, and creates this file. The autoload.m file 
is located in the Alpha directory. Each time you want to add a new package
to MMAlpha, add an entry in the local variable \"contexts\" of Alpha.m, then 
remove the autoload.m file: a new one will be created.";

setMMADir::usage = 
"setMMADir[List[___String]] does the SetDirectory[] function work, but 
the path is specified as a list of strings and hence is valid on 
different plateforms (Windows, Unix)."; 

setMMADir::note = 
"Actually this function is not
needed as Mathematica changes on the fly the path names depending on 
the platform.";

wrap::usage = 
"wrap[exp,contextFile,result] evaluates the expression exp in the
context given in the file contextFile, and returns the result in 
the file result. This function is not currently finished.";

wrap::note = 
"wrap is used for running examples in separate sessions
of Mathematica, for example, using a remote MMAlpha installation. The
idea would be to control the execution, and to use only one licence
to run these examples. The price to pay would be the start time of 
Mathematica.";

enTete::usage="enTete[symb1_] prints out the standard skeleton for
programming a new function named symb1 in MMAlpha (for developper use
only)."

mute::usage = "option (Boolean). If True, function prints absolutely no information."

(* ===================== Private definitions ================== === *)

Begin["`Private`"];

Format[scdc[x_]] := x;
Format[scdc[x_String, y_Integer]] := x <> ToString[y];


(* 
  This modification may be temporary. On Windows 2000, the temporary
  prefix variable seems to be inconsistent. *)
  If[ $OperatingSystem === "WindowsNT",
    Unprotect[ $TemporaryPrefix ];
     $TemporaryPrefix = "C:/Temp/";
     Print[ "$TemporaryPrefix was set to : ", $TemporaryPrefix ];
     Protect[ $TemporaryPrefix ]];

(*
  This function is meant to execute commands in batch, in an incremental way
*)
(* The context is $program, $result, $library, $schedule, $scheduleLibrary, 
$depCone, $coneList *)
Clear[wrap];
wrap[exp:_, context:_String, result:_String]:=
Catch[
  Module[{dir,r,u},
    SetDirectory[fileName[ {$rootDirectory, "lib", "Packages"}] ];
    u = Get[context];
    Print[result];
    exp >> result
  ]
];
wrap::params = "wrong parameters";
wrap[___] := Message[wrap::params];

sprint::usage = "sprint[a] is a shortcut for ashow[a,silent->True]"

load::param = "should be called with a file name";
load::notFound =" File `1` not found ";
load::notalpha = "file was not an ALPHA system";
show::params = "wrong parameters.";
show::error = "error while showing program or expression";
show::empty = "empty object to show";
showMat::params = "wrong parameters.";
showMat::nimpl = "this function is available only on MacOS";
showLib::params = "called with wrong parameters.";
asaveLib::params = "called with wrong parameters.";
saveLib::params = "called with wrong parameters.";
asave::params = "called with wrong parameters.";
save::params = "called with wrong parameters.";
ashowLib::params = "called with wrong parameters.";
ashow::params = "called with wrong parameters.";
save::nimpl = "MMAlpha is only available on Unix, MacOS or WindowsNT";
getPart::wrgpos = "position out of expression.";
getPart::params = "called with wrong parameters.";
getSystem::params = "called with wrong parameters.";
readAlpha::nofile = "unknown input file";
readAlpha::parserr = "error while parsing file";
readAlpha::params = "should be called with a file name";
readExp::params = "called with wrong parameters"; 
readExp::parserr = "there was an error while parsing the expression";
readDom::params = "called with wrong parameters";  readDom::parserr =
"error while parsing the domain";
readMat::params = "called with wrong parameters"; 
astQ::params = "wrong parameters";


Clear[setMMADir];
setMMADir::usage = 
"setMMADir[location] sets the working directory to path location,
relative to the MMALPHA directory. location is either a single string, 
or a list of strings representing a path.";
setMMADir::nofile = "No such directory";
setMMADir[location:{__String}]:=
Module[{dir},
  Check[ 
    SetDirectory[ 
      ToFileName[ Prepend[ location, Environment["MMALPHA"] ] ]
    ],
    Message[ setMMADir::nofile ]
  ]
];
setMMADir[___]:=Message[setMMADir::params];

Clear[systemNames]; 
systemNames::libempty = "the library is empty";
systemNames[] := (Message[systemNames::libempty ];{})/;
  !MatchQ[ $library, {__Alpha`system} ];
systemNames[] := Map[ First, $library ];



(* Test directory *)
Clear[$testDirectory];
$testDirectory = 
  Environment["MMALPHA"]<>"/tests/";


(* Demo directory *)
Clear[$demoDirectory];
$demoDirectory = 
Which[
  $OperatingSystem === "Unix" || $OperatingSystem === "MacOSX",  
  Environment["MMALPHA"]<>"/demos/"
,
  $OperatingSystem === "WindowsNT", 
  $rootDirectory<>"\\demos\\",
  True, Print["Unsupported OS"]
];


(* tmp directory directory *)
Clear[$tmpDirectory];
$tmpDirectory = 
Which[
	$OperatingSystem === "MacOSX", "/tmp/", (* same as Unix *)
	$OperatingSystem === "Unix", "/tmp/",
	$OperatingSystem === "WindowsNT", 
		If[ FileType["C:\\TEMP"]===Directory,
		    "C:\\TEMP\\",
		    If [FileType["C:\\TEMP"]===None,
		        Print[" Warning, C:\\TEMP\\ do not exists, creating it "];
			CreateDirectory["C:\\TEMP"];
			"C:\\TEMP\\", 
			Print["Strong Warning: could not create temporary directry  C:\\TEMP\\"]]],
	True, Print["Unsupported OS"]
];

(* openTemporary is the same as OpenTemporary except that
  it opens the file in a tmp directory *)
Clear[openTemporary];
openTemporary[]:=
  Module[{outStream,tempStream,dir},
    outStream=
      Which[
        $OperatingSystem === "MacOSX",
        OpenTemporary[]
      ,
        $OperatingSystem === "Unix",
        OpenTemporary[]
      ,
        $OperatingSystem === "WindowsNT", 
        If[ $VersionNumber<4.,
          dir = Directory[];
          SetDirectory[$tmpDirectory];
          tempStream = OpenTemporary[];
          SetDirectory[dir];
          tempStream,
          OpenTemporary[]]
      ,
        True, Print["Unsupported OS"]]
  ];

openTemporary::WrongArg="Wrong arguments ";
  
openTemporary[a___]:=openTemporary::WrongArg;

(* getTemporaryName returns the name of a new temporary file,
   this function is equivalement to Close[OpenTemporary], but there is a
   different behaviour  in V3 and V4 of MMA for that *)
Clear[getTemporaryName];
getTemporaryName[]:=
  Module[{outName,tempName},
    outName=
      Which[
        $OperatingSystem === "MacOSX",
        Close[openTemporary[]]
      ,
        $OperatingSystem === "Unix",
        Close[openTemporary[]]
      ,
        $OperatingSystem === "WindowsNT", 
	If [$VersionNumber<4.,
          (* special kludge for Jeff Verdonck:
           comment the following line *)
          tempName=Close[openTemporary[]];
          $tmpDirectory<>tempName,
          Close[openTemporary[]]
        ]
      ,
        True, Print["Unsupported OS"]]
  ];

getTemporaryName::WrongArg="Wrong arguments ";

getTemporaryName[a___] = getTemporaryName::WrongArg;

(* Master Notebook *)
Clear[$masterNotebook];
$masterNotebook = 
Which[
  $OperatingSystem === "MacOSX", Environment["MMALPHA"]<>"/demos/NOTEBOOKS/master.nb",
  $OperatingSystem === "Unix",  Environment["MMALPHA"]<>"/demos/NOTEBOOKS/master.nb",
  $OperatingSystem === "WindowsNT",  Environment["MMALPHA"]<>"\\demos\\NOTEBOOKS\\master.nb",
  True, Print["Unsupported OS"]
];

(* on *)
Clear[on];
on[]:= NotebookOpen[$masterNotebook];
on[___]:=Message[on::params];

(* start *)
Clear[start];
start[]:= 
Module[{},
  Print[$masterNotebook];
  NotebookOpen[$masterNotebook]
];
start[___]:=Message[on::params];

(* start *)
Clear[myStart];
myStart[]:= 
Module[{},
  Print[$myNotebooks<>"/"<>$myMasterNotebook];
  NotebookOpen[$myNotebooks<>"/"<>$myMasterNotebook]
];
myStart[___]:=Message[on::params];

Clear[fileName];
fileName[n:{__String}]:=
Catch[
  Which[
    $OperatingSystem == "Unix" || $OperatingSystem == "MacOSX", 
    Apply[ StringJoin, 
      Map[ #1<>"/"&, Drop[ n, -1 ] ] 
         ] <> Last[ n ]
  ,
    $OperatingSystem == "WindowsNT", 
    Apply[ StringJoin, 
      Map[ #1<>"\\"&, Drop[ n, -1 ] ] 
         ] <> Last[ n ],
    True, Throw[ Message[ fileName::os ]]
  ]
]; (* Catch *)
fileName[___] := Message[ fileName::params ];
fileName::os := "unknown operating system";



(*
   Double usage with docLink...
Clear[packageLink];

packageLink::params = "wrong parameters.";
packageLink::file = "could not find file.";
packageLink::os = "unsupported OS";
packageLink[s:_String]:=
Catch[ 
Module[{fullname},
	fullname = fileName[{"","doc", "packages", s, s<>".nb"}];
	Print["This package is at address: ", $rootDirectory<>fullname];
	If[ FileInformation[ $rootDirectory<>fullname ] === {}, Throw[ Message[ packageLink::file ] ]];
	Button[	s, 
		With[{x=fullname},
			ButtonFunction :> 
			NotebookOpen[ $rootDirectory<>x ]
		], 
		ButtonEvaluator -> Automatic, 
		Active -> True,
		ButtonStyle->Hyperlink ]
	]
];
packageLink[ ___ ] := Message[ packageLink::params ];
*)

Clear[demoLink]; 

demoLink::params = "wrong parameters.";
demoLink::file = "could not find file.";
demoLink::os = "unsupported OS";
demoLink[s:_String]:=
  demoLink[s, s];
demoLink[d:_String, s:_String]:=
Catch[ 
Module[{fullname},
  fullname = fileName[{"NOTEBOOKS", d , s<>".nb"}];
  Print[fullname];
  If[ FileInformation[ $demoDirectory<>fullname ] === {}, 
    Throw[ Message[ demoLink::file ] ]
  ];
  Button[s, 
    With[{ x = fullname}, ButtonFunction :> 
      NotebookOpen[ StringJoin[ $demoDirectory, x ] ]], 
      ButtonEvaluator -> Automatic, 
      Active -> True,
      ButtonStyle->Hyperlink ]
  ]
];
demoLink[ ___ ] := Message[ demoLink::params ];

Clear[docLink]; 

docLink::params = "wrong parameters.";
docLink::file = "could not find file.";
docLink::os = "unsupported OS";
docLink[s:_String]:=
  docLink[s, s];
docLink[d:_String, s:_String]:=
Catch[ 
Module[{fullname},
	fullname = ToFileName[{$rootDirectory,"doc","packages", d}, s<>".nb"];
	Print[fullname];
	If[ FileInformation[ fullname ] === {}, 
	    Throw[ Message[ docLink::file ] ]];
	Button[	s, 
		With[{ x = fullname}, ButtonFunction :> 
		NotebookOpen[ StringJoin[ x ] ]], 
		ButtonEvaluator -> Automatic, 
		Active -> True,
		ButtonStyle->Hyperlink ]
	]
];
docLink[ ___ ] := Message[ docLink::params ];

Clear[link]; 

link::params = "wrong parameters.";
link::file = "could not find file.";
link::os = "unsupported OS";
link[s:_String]:= link[s, s];
link[d:_String, s:_String]:=
Catch[ 
Module[{fullname},
  fullname = ToFileName[{$myNotebooks, d}, s<>".nb"];
  Print[fullname];
  If[ FileInformation[ fullname ] === {}, 
    Throw[ Message[ link::file ] ]];
      Button[s, 
        With[{ x = fullname}, ButtonFunction :> 
          NotebookOpen[ StringJoin[ x ] ]], 
          ButtonEvaluator -> Automatic, 
          Active -> True,
          ButtonStyle->Hyperlink 
      ]
  ]
];
link[ ___ ] := Message[ link::params ];

(* Definition of test *)
Options[ tests ] = {debug->False,verbose->False};

Clear[tests];
tests::usage = 
"tests[] starts a complete test of all MMA packages. tests[package:_String]
calls the test file of package (suffix .m is added to package).
tests[package:_String,testname:_String] tries test testname of package.";

tests::notestfile = "unknown test file `1`";
tests::notestname = "unknown test number ";

tests[opts:___Rule] := 
Module[{currdir,f1,f2,res1,res2},
    currdir = Directory[];
    SetDirectory[$testDirectory];
    f1 = 
    {"Alpha", 
     "Domlib",
     "Tables",
     "Matrix",
     "CutMMA",
     "Normalization"  , 
     "Static",
     "ChangeOfBasis",
     "Substitution"};
    f2= { (*  "PipeControl",      *)
     "Pipeline",
     "Schedule",
     "MultiDim",
     "Visual",
     "Alphard",
     "Vhdl2"
    }; 

     res1=Apply[And,Map[tests[#1,opts]&,f1]];
     continue = 
       (Print["the test of the elementary MMALPHA
          function was ",If [!res1, " NOT OK"," OK "]];
       InputString["Do you want to continue the tests?"]);
       If [continue=!="n",
	   res2=Apply[And,Map[tests,f2]],
	 res2=True];
	 SetDirectory[currdir];
       If[res1&&res2,
           Print["\n------------- > All Tests were passed successfully."],
	   Print["\n************* > There was  errors during some tests"]];
       res1&&res2
];

tests[all] := 
Module[{currdir,f},
    currdir = Directory[];
    SetDirectory[$testDirectory];
    f = FileNames[]; 
    Map[tests,Map[StringDrop[#,4] &,f]];
    SetDirectory[currdir];
];

tests[package:_String,opts:___Rule]:=
Catch[
  Module[{currdir,p,tp,res},
    (* Save directory *)
    currdir = Directory[];
    p = package<>".m"; (* Package name *)
    tp = "Test"<>p; (* Test file *)

    Print[$testDirectory];
    Check[SetDirectory[$testDirectory<>"/Test"<>package],Throw[Null]];

    If[ !MemberQ[FileNames[],tp],Throw[SetDirectory[currdir];
	   Message[tests::notestfile,tp]]
    ];

    Print["Calling Test",p];
    res = Check[Get["Test"<>p],$Failed,testFunction::abntest];
    SetDirectory[currdir];
    If[res,
      Print["------------- > Test for ",package," was passed successfully."],
      Print["************* > There was an error during the test of package: ",package]];
    res
  ]
];
tests[package:_String,testname:_String,opts:___Rule]:=
Catch[
  Module[{currdir,p,tp,testcommand,dbg},
    dbg = debug/.{opts}/.Options[tests];

    currdir = Directory[];
    p = package<>".m"; (* Package name *)
    tp = "Test"<>p; (* Test file *)
    If[ dbg, Print[ "Test file: ", tp ] ];

    Check[SetDirectory[$testDirectory<>"/Test"<>package],Throw[Null]];

    If[!MemberQ[FileNames[],tp],Throw[SetDirectory[currdir];
      Message[tests::notestfile,tp]]];
    If[ dbg, Print[ "Test name: ", FullForm[testname] ] ];
    testcommand = FindList[tp,testname];
    Print["Calling Test ",testname," of package ",p];
    If[ dbg, Print[ "Test command: ", FullForm[testcommand] ] ];
    Map[ToExpression,testcommand];
    SetDirectory[currdir];
  ]
];

tests::params = "wrong parameters"; 
tests[___] := Message[tests::params];

(* Definition of testFunction *)
Clear[testFunction];
testFunction::usage = 
"testFunction[exp, result, testID] compares the evaluation of exp to
result. Returns True if they are equal, False and emits a message if
it is different. testID is a string which identifies the test";

testFunction::abntest = "************* -> abnormal result in test `1`";
testFunction::wrgparam = "wrong parameters";

testFunction[exp : _, result : _, testId : _String, opts:___Rule] := 
Module[{vrb},
  vrb = verbose/.{opts}/.{verbose -> False};
  If[exp =!= result, 
     Message[testFunction::abntest,testId];
     If[vrb,Print[FullForm[exp],FullForm[result]]];
     False, 
     Print["--------> Passed test ",testId];
   True]
];
testFunction[___] := Message[testFunction::wrgparam]; 



(* astQ *)
Clear[astQ];
astQ[param:_]:= 
Catch[
 (Check[show[param,silent->True],Throw[False]];True)
];
astQ[___]:=Message[astQ::params];

(* Resets global variables *)
(* $library = {};
$result = {};
$program = {}; *)

(******************** LOAD ********************************)

Clear[load];
load::err = "error while loading file. Probably not an alpha program";
Options[ load ] = {mute->False};

(* Addition March 24 2008 *)
load[filename:_String/;StringMatchQ[filename,"*.ax"], opts:___Rule] :=
Catch[
  Module[ {st},
    st = ReadList[ filename, Record, RecordSeparators -> {"/\n"} ];
    Print[ FullForm[ st ] ]
  ]
];
load[filename_String, opts:___Rule] :=
Catch[
  Module[{tree,name,optm},
    optm = mute/.{opts}/.Options[ load ];

    If[ FileInformation[filename]=!={},
      Check[
        tree = readAlpha[filename],
        Throw[Message[load::err]]
      ],
      Throw[Message[load::notFound,filename]];
      tree={}
    ];

    Which[ 
      Head[tree] === Alpha`system
    ,
      If[ !optm, Print["System Loaded"] ];
        $library = {tree};
        $program = tree;
        $result = tree
    ,
      Head[tree] === List
    ,
      If[ !optm, Print[" Library Loaded"] ];
          $library = tree;
          $program = Last[tree];
          $result =  Last[tree]
    ,
      True
    ,
      Message[load::notalpha];
    ]
  ];
  tree
];
load[___]:=Message[load::param];

(******************** END LOAD ********************************)

Options[show] = {silent -> False};
 (******************** SHOW  ********************************)

Which[
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix", (* Unix or MacOSX version *)
Clear[show];
(* Addition 14/03/2004 - Was missing in the MacOS version, corrected 
   April 9, 2007  *)
show[dependuse[
       name:_String, 
       iv:{___String}, (* input variables *)
       ov:{___String}, (* ouptut variables *)
       i:_Integer, (* ? *)
       paramsDom:_domain, (* parameters domain *)
       paramsMatrix:_matrix (* parameters matrix *)
     ],
     _,
     opts:___Rule
]:=
Print[
  StringJoin[
    name,                      (* show the name *)
    "[",ashow[ paramsMatrix, silent -> True ],"]",
    If[ iv=={}, "()", 
	"("<>Map[ #1<>","&, Drop[iv,-1]]<>Last[iv]<>")"
    ],
    " <- ",
    If[ ov=={}, "()", 
	"("<>Map[ #1<>","&, Drop[ov,-1]]<>Last[ov]<>")"
    ]
  ]
];
  show[opts:___Rule]:=show[$result,opts];
  show[x:_,opts:___Rule]:=show[x,{},opts];

  show[opts:___Rule] := show[$result,opts];
  show[x:_,opts:___Rule] := show[x,{},opts];
  show[x:dtable[depend:_,dependUse:_],paramDom:_,opts:___Rule] :=
  Module[ {},
    Print["-- Regular dependencies:"];
    show[dtable[depend],paramDom,opts];
    If[ dependUse =!= {}, 
      Print["-- Dependencies of use statements:"];
      Map[show[#,paramDom,opts]&,dependUse],
      Print["No use statement"]
    ];
  ];
  show[x:_,paramDom:_, opts:___Rule] := 
  Catch[
  Module[{sil,res,tempfile},
    sil = silent/.{opts}/.Options[show];
    (* Send x to write_alpha, and get result in temporary file *)
    tempfile = getTemporaryName[];
    If[paramDom =!= {},
      Put[x,"!write_alpha -p "<>ToString[paramDom[[1]]]<>" > "<>
           tempfile],
           Put[x,"!write_alpha >"<>tempfile];]; 
        (* As Print, show returns Null *)
	res = First[ReadList[tempfile,Record,RecordSeparators->{}]];
        DeleteFile[tempfile];
	If[res === {}, Message[show::empty]; res ,
          (* Remove last \n *)
          res = StringDrop[res,-1]
        ];
	(* return a string if option silent is True, else print result *)
	If[sil,res,Print[res]]
        ] (* Module *)
    ]; (* Catch *)
  show[z1:zpol[d_,{},_],opts___Rule]:=
  Module[{indices},
          indices=Check[z1[[3,2]]];
          If[!MatchQ[indices,List[___String]],Message[show::error],
              (* else *) show[ReplacePart[z1,indices,2],opts]]
       ];
  show[___]:=Message[show::params]
,
  $OperatingSystem === "WindowsNT", 
(* 
	The pretty printer can be called from MMA, but has
	to take its input in a file, and to produce its output to a file. 
*)

Clear[show];
(* Addition 14/03/2004 *)
show[dependuse[
       name:_String, 
       iv:{___String}, (* input variables *)
       ov:{___String}, (* ouptut variables *)
       i:_Integer, (* ? *)
       paramsDom:_domain, (* parameters domain *)
       paramsMatrix:_matrix (* parameters matrix *)
     ],
     _,
     opts:___Rule
]:=
Print[
  StringJoin[
    name,                      (* show the name *)
    "[",ashow[ paramsMatrix, silent -> True ],"]",
    If[ iv=={}, "()", 
	"("<>Map[ #1<>","&, Drop[iv,-1]]<>Last[iv]<>")"
    ],
    " <- ",
    If[ ov=={}, "()", 
	"("<>Map[ #1<>","&, Drop[ov,-1]]<>Last[ov]<>")"
    ]
  ]
];
show[opts:___Rule]:=show[$result,opts];
show[x:_,opts:___Rule]:=show[x,{},opts];
show[x:dtable[depend:_,dependUse:_],paramDom:_,opts:___Rule] :=
(
  Print["Regular dependences: "];
  show[dtable[depend],paramDom,opts];
  Print["Subsystems dependences: "];
  show[dtable[dependUse],{},opts];
);


(* Addition 16/10/2000 *)
show[use[d1:_domain, x:_String, d2:_domain, y:_String, m:_matrix, 
  d3:_domain]]:=
  (* d1 : use domain. d2: extended use domain, whenever the 
     dependency is not invertible.
     x: used variable,
     y: using variable,
     m: affine function of y,
     d3: source domain of the dependency
  *)
StringJoin[
  show[ d1, silent->True ],  (* show the usage domain *)
  If[ !DomUniverseQ[d2],     (* show the extended domain if necessary *)
      ":: "<>show[ d2, silent->True ],""],
  ": ",
  x, " <- ",                 (* show the used variable *)
  "  ", y,".",               (* show the using variable *)
  ashow[ m, silent->True ]   (* print the dependency *)
(*
    "\n( ",
    show[ d3, silent->True ]," )"
*)
];

(* 15/05/2003: for Zpols *) 
show[z1:zpol[d_,{},_],opts___Rule]:=
  Module[{indices},
    indices=Check[z1[[3,2]]];
    If[!MatchQ[indices,List[___String]],Message[show::error],
      (* else *) show[ReplacePart[z1,indices,2],opts]]
];

show[dtable[x:{___use},_,opts:___Rule]]:=(Map[show,x]);
show[dtable[x:{___dependuse}],_,opts:___Rule]:=
  (Map[show[#1,{},silent->True]&,x]);


show[x:_,paramDom:_,opts:___Rule] :=
Catch[
  Module[{sil,res,tempAST,tempAlpha,tempErr},
    sil = silent/.{opts}/.Options[show];
    (* Write expression in temporary file *)
    tempAST = getTemporaryName[];
    tempAlpha =getTemporaryName[];
    tempErr =getTemporaryName[];
    Put[x,tempAST];
    (* Call writeAlpha on the file *)
    Run[StringJoin["write_alpha < ",tempAST,
			    " 1> ",tempAlpha,
			  " 2> ",tempErr]];
    res = First[ReadList[tempAlpha,Record,
				RecordSeparators->{}]];
    (* Remove last \n *)
    res = StringDrop[res,-1];
    err1=ReadList[tempAlpha,Record,RecordSeparators->{}];
    If[Length[err1]>1,Print[err1]];
      DeleteFile[{tempAST,tempAlpha,tempErr}]; 
      (* return a string if option silent is True, else print result *)
     If[sil,res,Print[res]]
  ]
];
show[___]:=Message[show::params],

True (* Other OS *),
 Print["Unsupported OS"];Throw[Null]
]


 (******************** END SHOW  ********************************)


(* To show a matrix *)
Which[
True (*should work on All OS *), 
(* This function is only available on MacOs. To add it to 
   Unix version, we must before define the silent option of show *)
  Clear[showMat];
showMat[lm:{__matrix},opts:___Rule]:=
  Map[showMat[#1,opts]&,lm]; (* listable *)
    showMat[m_matrix,opts:___Rule]:=
Module[{res,sil},
    sil = silent/.{opts}/.Options[show]; (* same options as show *)
    res=StringDrop[show[affine[var["X"],m],silent->True],2];
    If[sil,res,Print[res]]
     ];
showMat[___]:=Message[showMat::params],
True,
Clear[showMat];
showMat[___]:=Message[showMat::nimpl]
]

(* Please do not remove fshow anymore Thank you ! TR *)
Clear[fshow];
fshow[a___]:=show[a];


 (******************** SAVE  ********************************)

(* save a file *)
Which[
  $OperatingSystem === "Unix",  (* Unix version *)
  Clear[save];
  save[filename_String] :=
    Put[$result, StringJoin["!write_alpha > ", filename]];
  save[x_, filename_String] := Put[x, StringJoin["!write_alpha >", filename]];
  save[___]:=Message[save::params]
,
  $OperatingSystem === "MacOSX", (* Mac OS X, is as unix *)
  Clear[save];
  save[filename_String] := save[$result,filename];
  save[x:_,filename_String] :=
    Module[{s},
	   If[MemberQ[FileNames[],filename],DeleteFile[filename]];
	   s=show[x,silent->True];
	   Put[s,filename]; 
	 ];
  save[___]:=Message[save::params]
,
  $OperatingSystem === "WindowsNT", 
  Clear[save];
  save[filename_String] := save[$result,filename];
  save[x:_,filename_String] :=
  Module[{s,tempAST},
    If[MemberQ[FileNames[],filename],DeleteFile[filename]];
      tempAST =getTemporaryName[];
      Put[x,tempAST];
      (* Call writeAlpha on the file *)
      Run[StringJoin["write_alpha < ",tempAST," > ",filename]];
      DeleteFile[{tempAST}]	
  ];
  save[___]:=Message[save::params]
,
  True, (* Any other *)
  Message[save::nimpl];
];


(******************** END SAVE   ****************************** **)

Clear[varTypes]
varTypes[]:=varTypes[$result]
varTypes[sys:_system]:=(With[{vars=Join[sys[[3]],sys[[4]],sys[[5]]]},
	Map[Print[" Var ",First[#], " type ",Last[#]] &,
	Map[{First[#],Part[#,2]} &,vars]]];Null)


 (******************** ASHOW   ********************************)

(* show a file in array form *)
Clear[ashow];
Which[
  (* Unix or Mac OS X *)
  $OperatingSystem === "MacOSX" ||
  $OperatingSystem === "Unix",
  ashow[opts:___Rule] := ashow[$result,opts];
  ashow[x:_,opts:___Rule]:=ashow[x,{},opts];
  ashow[x:_,paramDom:_,opts:___Rule] :=
  Catch[
    Module[{sil,res},
      sil = silent/.{opts}/.Options[show];
      (* Send x to write_alpha, and get result in temporary file *)
      tempfile = Close[OpenTemporary[]];
      If[paramDom =!= {},Put[x,"!write_alpha -a -p"<>
         ToString[paramDom[[1]]]<>">"<>tempfile];,
      Put[x,"!write_alpha -a >"<>tempfile];]; 
      (* As Print, show returns Null *)
      res = First[ReadList[tempfile,Record,RecordSeparators->{}]];
      DeleteFile[tempfile];
      If[res === {},Print["param:",x];Throw[Message[show::error]]];
      (* Remove last \n *)
      If[res=!={},res = StringDrop[res,-1]];
      (* return a string if option silent is True, else print result *)
      If[sil,res,Print[res]]
    ] (* Module *)
  ]; (* Catch *)
  ashow[x_Alpha`zpol]:=show[x];
  ashow[___]:=Message[ashow::params]
,
     
  $OperatingSystem === "WindowsNT", 
  (* 
	The pretty printer can be called from MMA, but has
	to take its input in a file, and to produce its output to a file. 
  *)

  Clear[ashow];
  ashow[opts:___Rule]:=ashow[$result,opts];
  ashow[x:_,opts:___Rule]:=ashow[x,{},opts];
  ashow[x:_,paramDom:_,opts:___Rule] :=
  Catch[
    Module[{sil,res,tempAST,tempAlpha},
        sil = silent/.{opts}/.Options[show];
        (* Write expression in temporary file *)
	tempAST =getTemporaryName[];
	tempAlpha =getTemporaryName[];
        Put[x,tempAST];
        (* Call writeAlpha on the file *)
        Run[StringJoin["write_alpha -a < ",tempAST," > ",tempAlpha]];
        res = First[ReadList[tempAlpha,Record,
                RecordSeparators->{}]];
        (* Remove last \n *)
        If[res=!={},res = StringDrop[res,-1]];
        DeleteFile[{tempAST,tempAlpha}]; 
        (* return a string if option silent is True, else print result *)
        If[sil,res,Print[res]]
	]
    ];
  ashow[___]:=Message[ashow::params]
,
  True, 
  Print["Unknown OS"]
];


(******************** END ashow   ********************************)


sprint[a_] := ashow[a, silent->True];

 (******************** asave   ********************************)
(* save a file in array form *)
Which[
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix of Mac OS X version *)
  Clear[asave];
  asave[filename_String] :=
             Put[$result, StringJoin["!write_alpha -a>", filename]];
  asave[x_, filename_String] := 
    Put[x, StringJoin["!write_alpha -a>", filename]];
  asave[___]:=Message[asave::params]
,

  $OperatingSystem === "WindowsNT", 
  Clear[asave];
  asave[filename_String] := asave[$result,filename];
  asave[x:_,filename_String] :=
  Module[{s,tempAST},
    If[MemberQ[FileNames[],filename],DeleteFile[filename]];
      tempAST = getTemporaryName[];
      Put[x,tempAST];
      (* Call writeAlpha on the file *)
      Run[StringJoin["write_alpha -a < ",tempAST," > ",filename]];
      DeleteFile[{tempAST}]	
  ];
  asave[___]:=Message[save::params]
,
  True, (* Any other *)
  Message[asave::nimpl];
];

(******************** end asave   ********************************)

(******************** ashowlib   ********************************)

(* ashowLib : prints the whole library using array notation ----------*)
Clear[ashowLib];
Which[
  (* Unix *)
  $OperatingSystem === "MacOSX" || $OperatingSystem === "Unix",
  ashowLib[] := Put[Alpha`$library, "!write_alpha -a"];
  ashowLib[x_] := Put[x, "!write_alpha -a"];
  ashowLib[___]:=Message[ashowLib::params]
,
  $OperatingSystem === "WindowsNT",
  ashowLib[]:=ashowLib[$library];
  ashowLib[x_]:=ashowLib[x,{}];
  ashowLib[x_, paramDom_]:=(Map[ashow,x];Null),

(* Any other OS *)

True, Print["Unknown OS"]
];

(******************** end ashowLib   ********************************)

(******************** showlib   ********************************)

(* showLib : prints the whole library --------------------------------*)
Clear[showLib];
Which[
  (* Unix *)
  $OperatingSystem === "MacOSX" || $OperatingSystem === "Unix",
  showLib[] := Put[Alpha`$library, "!write_alpha"];
  showLib[x_] := Put[x, "!write_alpha"];
  showLib[___]:=Message[showLib::params]
,
  $OperatingSystem === "WindowsNT",
  showLib[]:=showLib[$library];
  showLib[x_]:=showLib[x,{}];
  showLib[x_, paramDom_]:=(Map[show,x];Null)
,
  (* Any other OS *)
  True, Print["Unknown OS"]
];

(******************** end showLib   ********************************)

(******************** asaveLib   ********************************)

(* asaveLib : save the whole library to a file -----------------------*)
Which[
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
  Clear[asaveLib];
  asaveLib[filename_String] :=
     Put[Alpha`$library, StringJoin["!write_alpha -a>", filename]];
  asaveLib[x_, filename_String] :=
     Put[x, StringJoin["!write_alpha -a>", filename]];
  asaveLib[___]:=Message[asaveLib::params]
,
  $OperatingSystem === "WindowsNT", 
  Clear[asaveLib];
  asaveLib[filename_String] := asaveLib[$library,filename];
  asaveLib[x:_,filename_String] :=
  Module[{s,tempAST},
    If[MemberQ[FileNames[],filename],DeleteFile[filename]];
      tempAST =getTemporaryName[];
      Put[x,tempAST];
      (* Call writeAlpha on the file *)
      Run[StringJoin["write_alpha -a < ",tempAST," > ",filename]];
      DeleteFile[{tempAST}]	
  ];
  asaveLib[___]:=Message[asaveLib::params]
,
  True, (* Any other *)
  Message[asaveLib::nimpl];
];


(* saveLib : save the whole library to a file ------------------------*)
Which[
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
  Clear[saveLib];
  saveLib[filename_String] :=
    Put[Alpha`$library, StringJoin["!write_alpha>", filename]];
  saveLib[x_, filename_String] :=
    Put[x, StringJoin["!write_alpha>", filename]];
  saveLib[___]:=Message[saveLib::params]
,
 
  $OperatingSystem === "WindowsNT", 
  Clear[saveLib];
  saveLib[filename_String] := saveLib[$library,filename];
  saveLib[x:_,filename_String] :=
  Module[{s,tempAST},
    If[MemberQ[FileNames[],filename],DeleteFile[filename]];
    tempAST = getTemporaryName[];
    Put[x,tempAST];
    (* Call writeAlpha on the file *)
    Run[StringJoin["write_alpha  < ",tempAST," > ",filename]];
    DeleteFile[{tempAST}]	
  ];
  saveLib[___]:=Message[saveLib::params]
,
  True, (* Any other *)
  Message[saveLib::nimpl];
];


Clear[getPart];
getPart[exp_, {occur__}] := Check[Part[exp, occur],Message[getPart::wrgpos]];
getPart[exp_, {}] := {};
getPart[___]:=Message[getPart::params];

(* getSystem : changes current system --------------------------------*)
Clear[getSystem];
getSystem::libNotSet=
  "$library does not seem to contain a list of systems";
getSystem[id_String, lib_List] :=
Module[{systemFound},
  systemFound = Cases[lib, Alpha`system[id,__], 1];
  If[ systemFound=!={},
    (  Alpha`$result = First[systemFound];
       Alpha`$program = Alpha`$result ) ,
    (  Print[id, " : not found in the library."];
       $result )
  ]
];

getSystem[id_String] := 
  If[ValueQ[$library]&&MatchQ[$library,{__system}],
     ($result=getSystem[id, $library]),
     Message[getSystem::libNotSet]
  ];
getSystem[id_String] := getSystem[id, $library];
getSystem[___] := (Message[getSystem::params];$Failed)

(* putSystem : puts a system into a library --------------------------*)
Clear[putSystem];
putSystem[sys:Alpha`system[id_,__], lib_List] :=
Module[{systemFound},
  systemFound = Position[lib, Alpha`system[id,__], 1];
  If[ systemFound=!={},
      ((*Print[id, " replaced in library."]; *)
       ReplacePart[lib, sys, systemFound]) ,
      ((*Print[id, " added to library."]; *)
       Append[lib, sys])
      ] 
    ];
putSystem[] := 
  Alpha`$library = putSystem[Alpha`$result, Alpha`$library];
putSystem[sys_Alpha`system] := 
  Alpha`$library = putSystem[sys,Alpha`$library];
putSystem[lib_List] := putSystem[Alpha`$result, lib];
putSystem[___]:=Message[putSystem::params];

(* readAlpha : reads from file and parses a complete program -----------*)
Which[

  (* Windows version *)
  $OperatingSystem === "WindowsNT"
,
  Clear[readAlpha];
  readAlpha[fileName_String] :=
  Catch[
    Module[{fullname,tempFileOut,tempFileErr,resOut,resErr},
      If[ StringMatchQ[fileName,"*:*"],
        (* the path contains a drive like C: *)
        fullname = fileName,
        fullname = Directory[]<>"\\"<>fileName
      ]; 

      If[FileInformation[fullname]=={},Throw[Message[readAlpha::nofile]]];

      (* These files are created in a temporary directory, I do
         not know where. Try the command in MMA to see... *)
      tempFileOut = getTemporaryName[];
      tempFileErr = getTemporaryName[];

      (* Call read_alpha *)
      (* See the documentation in doc/Developpers/Write-Read-Alpha if
         needed *)
      Run[StringJoin["read_alpha < ", fileName," 1> ",
		  tempFileOut," 2> ", tempFileErr]];

      Check[
        resOut=Get[tempFileOut];
        (* Read[tempFileErr,String] does not work I don't know why *)
        resErr=First[ReadList[tempFileErr, Record, RecordSeparators->{}]]
      ,
        Throw[Message[readAlpha::parserr]]
      ];

      (* Print errors only if something wrong *)
      If[ resErr =!= {}, Print[resErr] ];
      DeleteFile[{tempFileOut,tempFileErr}]; 
      resOut
    ] (* Module *)
  ]; (* Catch *)
  readAlpha[___] := Message[readAlpha::params]
,

  (* Unix version or Linux *)
  $OperatingSystem === "MacOSX" ||
  $OperatingSystem === "Unix"
,  
  Clear[readAlpha];
  readAlpha[fileName_String] :=
  Catch[
    Module[{fullname,resOut,resErr,tempFileOut,tempFileRes},
      fullname = fileName; (* Relative path needed for parseAlpha *)
      If[FileInformation[fullname]=={},Throw[Message[readAlpha::nofile]]];

      (* These files are created in /tmp/ *)
      tempFileOut  = getTemporaryName[];
      tempFileErr  = getTemporaryName[];

      (* Call read_alpha *)
      (* See the documentation in doc/Developpers/Write-Read-Alpha if
         needed *)
      Run[StringJoin["read_alpha < ", fileName," 1> ",
          tempFileOut," 2> ", tempFileErr]];

      Check[
        resOut = Get[tempFileOut];
        (* Read[tempFileErr,String] does not work I don't know why *)
        resErr = First[ReadList[tempFileErr,
				   Record,
				   RecordSeparators->{}]]
      ,
        Throw[Message[readAlpha::parserr]]
      ];

      (* Print errors only if something wrong *)
      If[ resErr =!= {}, Print[resErr] ];
      DeleteFile[{tempFileOut,tempFileErr}]; 
      resOut
    ] (* Module *)
  ]; (* Catch *)
  readAlpha[___] := Message[readAlpha::params]
,
  (* Any other OS *)
  True, Print["Unknown OS"]
];

(* readExp : parse a string representing an ALPHA expression ---------*)
Clear[readExp];
readExp[E_String, paramDom_Alpha`domain] := 
  readExp[E, paramDom[[2]] ];
(* Thanks to Doran and Tanguy for the -p flag *)

readExp[E_String] := readExp[E,{}];

readExp[E_String, P:{___String}] :=
Which[
  (* Unix *)
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
  Catch[
    Module[{tempFileOut,tempFileErr,resOut,resErr}, 
      tempFileOut  =getTemporaryName[];
      tempFileErr  =getTemporaryName[];
      If[ Length[P]===0,
        RunThrough[StringJoin["read_alpha -E  -o ",
          tempFileOut," 2> ", tempFileErr],E],
        RunThrough[StringJoin["read_alpha -E -p ",ToString[P],
          " -o ", tempFileOut,
          " 2> ", tempFileErr],E]];
			
        Check[resOut=Get[tempFileOut];
        (* Read[tempFileErr,String] does not work I don't
		    know why *)
        resErr=ReadList[tempFileErr,
          Record,
          RecordSeparators->{}],
        Throw[Message[readAlpha::parserr]]];
        DeleteFile[{tempFileOut,tempFileErr}]; 
        If[Length[resErr]>0,Print[First[resErr]]];
        resOut
    ]
  ]
,

  (* WindowsNT *)
  $OperatingSystem === "WindowsNT",
  Catch[
    Module[{tempFileOut,tempFileErr,resOut,resErr},

      tempFileOut  = getTemporaryName[];
      tempFileErr  = getTemporaryName[];

      (* P is the parameter string *)
      If[ Length[P]===0,

        RunThrough[StringJoin["read_alpha -E  -o ",
				   tempFileOut," 2> ", tempFileErr],E],
	Par1 = StringJoin[Map[StringJoin[ToString[#]," "] &,P]];
	RunThrough[StringJoin["read_alpha -E -p ",Par1,
				   " -o ", tempFileOut,
				   " 2> ", tempFileErr],E]
      ];		

      Check[resOut = Get[tempFileOut];		
        (* Read[tempFileErr,String] does not work I don't
           know why *)
      resErr=ReadList[tempFileErr,
	   Record,
	   RecordSeparators->{}],
      Throw[Message[readAlpha::parserr]] ];
      DeleteFile[{tempFileOut,tempFileErr}]; 
      If[Length[resErr]>0,Print[First[resErr]]];
    resOut
    ]
  ]
,
  True,  (* Any other OS *)
	  Print["Unknown OS"]
];
readExp[___]:=Message[readExp::params];

(* readDom : parse a string representing an ALPHA domain -------------*)
Clear[readDom];
(* One can call readDom with no parameter domain *)
readDom[D_String] := readDom[D,{}];
(* with a full parameter domain *)
readDom[D_String, paramDom_Alpha`domain] :=
  readDom[D, paramDom[[2]] ];
(* or with a list of parameters *)
readDom[D_String, P:{___String}] :=
Which[
(* Unix *)
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
Catch[
  Module[{tempFileOut,tempFileErr,resOut,resErr}, 
	 tempFileOut  =getTemporaryName[];
	 tempFileErr  =getTemporaryName[];
	 If[ Length[P]===0, 
	     RunThrough[StringJoin["read_alpha -D  -o ",
				   tempFileOut," 2> ", tempFileErr],D],
	     RunThrough[StringJoin["read_alpha -D -p ",ToString[P],
				   " -o ", tempFileOut,
				   " 2> ", tempFileErr],D]];		
	 Check[resOut=Get[tempFileOut];
	       (* Read[tempFileErr,String] does not work I don't
		  know why *)
		 resErr=ReadList[tempFileErr,
				 Record,
				 RecordSeparators->{}],
	       Throw[Message[readAlpha::parserr]]];
	 DeleteFile[{tempFileOut,tempFileErr}]; 
	 If[Length[resErr]>0,Print[First[resErr]]];
	 resOut
	 ]
  ]
,

  (* WindowsNT *)
  $OperatingSystem === "WindowsNT",
  Catch[
    Module[{tempFileOut,tempFileErr,resOut,resErr,command},
      tempFileOut  = getTemporaryName[];
      tempFileErr  = getTemporaryName[];

      (* P is the parameter string *)
      If[ Length[P]===0,
        (* This case is OK *)
        RunThrough[StringJoin["read_alpha -D  -o ",
          tempFileOut," 2> ", tempFileErr],D],
       
        command = 
          StringJoin[
            "read_alpha -D -p ",
            StringReplace[ ToString[P], " "->"" ],
            " -o ", tempFileOut,
            " 2> ", tempFileErr
          ];

        RunThrough[ command, D ]
      ];

      Check[resOut=Get[tempFileOut];
        (* Read[tempFileErr,String] does not work I don't
		    know why *)
        resErr = ReadList[tempFileErr, Record, RecordSeparators->{}],
        Throw[Message[readAlpha::parserr]]
      ];
  (*
      DeleteFile[{tempFileOut,tempFileErr}];
  *)
      If[Length[resErr]>0,Print[First[resErr]]];
      resOut
    ]
  ]
,
  (* Any other OS *)
  True, 
  Print["Unknown OS"]
];
readDom[___]:=Message[readDom::params];

(* readMat : parse a string representing an ALPHA domain -------------*)
Clear[readMat];
readMat[D_String, paramDom_Alpha`domain] := 
   readMat[D, paramDom[[2]] ];
readMat[D_String] := readMat[D,{}];
readMat[D_String, P_List] :=
Which[
  (* Unix *)
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
  Catch[
    Module[{tempFileOut,tempFileErr,resOut,resErr}, 
	 tempFileOut  =getTemporaryName[];
	 tempFileErr  =getTemporaryName[];
	 If[ Length[P]===0, 
	     RunThrough[StringJoin["read_alpha -M  -o ",
				   tempFileOut," 2> ", tempFileErr],D],
	     RunThrough[StringJoin["read_alpha -M -p ",ToString[P],
				   " -o ", tempFileOut,
				   " 2> ", tempFileErr],D]];		
	 Check[resOut=Get[tempFileOut];
	       (* Read[tempFileErr,String] does not work I don't
		  know why *)
		 resErr=ReadList[tempFileErr,
				 Record,
				 RecordSeparators->{}],
	       Throw[Message[readAlpha::parserr]]];
	 DeleteFile[{tempFileOut,tempFileErr}]; 
	 If[Length[resErr]>0,Print[First[resErr]]];
	 resOut
	 ]
  ]
,

  $OperatingSystem === "WindowsNT",
  Catch[
    Module[{tempFileOut,tempFileErr,resOut,resErr},
	   tempFileOut  =getTemporaryName[];
	   tempFileErr  =getTemporaryName[];
	 If[ Length[P]===0,
	     RunThrough[StringJoin["read_alpha -M  -o ",
				   tempFileOut," 2> ", tempFileErr],D],
	     RunThrough[StringJoin[Flatten[{"read_alpha -M -p ",
                                   (* corrected a bug, to be done for unix *)
                                    Map[StringJoin[ToString[#]," "] &,P],
				   " -o ", tempFileOut,
				   " 2> ", tempFileErr}]],D]];		
	   Check[resOut=Get[tempFileOut];
		 (* Read[tempFileErr,String] does not work I don't
		    know why *)
		   resErr=ReadList[tempFileErr,
				   Record,
				   RecordSeparators->{}],
		 Throw[Message[readAlpha::parserr]]];
	   DeleteFile[{tempFileOut,tempFileErr}]; 
	   If[Length[resErr]>0,Print[First[resErr]]];
	   resOut
	]
	   
  ]
, 
  (* Any other OS *)
  True, Princ["Unknown OS"]
];
readMat[___]:=Message[readMat::params];

(******************** writeC   ********************************)
(* Convert a Alpha program in C *)
writeC::params="wrong parameters for writeC"
Clear[writeC];
writeC[] := writeC[$result,"Alpha.c",""];
writeC[sys_Alpha`system] := writeC[sys, "Alpha.c", ""];
writeC[sys_Alpha`system,nom_String] := writeC[sys, nom, ""];
writeC[nom_String]       := writeC[$result, nom, ""];
writeC[nom_String, op_String] :=  writeC[$result,nom,op];
Which[
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
  writeC[sys_Alpha`system, nom_String, op_String] :=
  Catch[
    Module[{fullname,tempFileOut,tempFileErr,resOut,resErr},
      If[ StringMatchQ[nom,"*:*"],
        (* the path contains a drive like C: *)
        fullname=nom,
        fullname = Directory[]<>"/"<>nom
      ]; 
      Print[ "fullname: ", fullname ];
      Print[ "op: ", op ];
      tempFileOut  = fullname;
      tempFileErr  =getTemporaryName[];
      Put[sys,StringJoin["!write_c ",op," 1> ",
        tempFileOut," 2> ", tempFileErr]
      ];
      Check[(* Read[tempFileErr,String] does not work I don't
		    know why *)
        resErr=First[ReadList[tempFileErr,
				   Record,
				   RecordSeparators->{}]],
        Throw[Message[writeC::parserr]]
      ];
      DeleteFile[{tempFileErr}]; 
      If[ !MatchQ[resErr,{}],Print[resErr]];
    ]
  ];
  (* writeC[sys_Alpha`system, nom_String, op_String] :=
    Put[sys,"!write_c "<>op<>" >"<>nom]; *)
  writeC[___]:=Message[writeC::params]
,

  $OperatingSystem === "WindowsNT", 
  writeC[sys_Alpha`system, nom_String, op_String] :=
  Catch[
    Module[{fullname,tempFileOut,tempFileErr,resOut,resErr},
	   If [StringMatchQ[nom,"*:*"],
	       (* the path contains a drive like C: *)
		 fullname=nom,
	       fullname = Directory[]<>"\\"<>nom]; 
	   tempFileOut  = fullname;
	   tempFileErr  =getTemporaryName[];
	   tempFileIn  =getTemporaryName[];
	   Put[sys,tempFileIn];
	   command=
	     StringJoin["write_c ",op," < ",tempFileIn," 1> ",
			      tempFileOut," 2> ", tempFileErr];
	   Run[command];
	   Check[(* Read[tempFileErr,String] does not work I don't
		    know why *)
		   resErr=First[ReadList[tempFileErr,
				   Record,
				   RecordSeparators->{}]],
            Throw[Message[writeC::parserr]]];
	 DeleteFile[{tempFileErr,tempFileIn}]; 
	If [!MatchQ[resErr,{}],Print[InputForm[resErr]]];
	 ]
  ];
  writeC[___]:=Message[writeC::params]
,
  True, (* Any other OS *)
  Message[writeC::nimpl];
];

(******************** end writeC   ********************************)

(* writeTex : function for calling write_tex -------------------------*)
Clear[writeTex];
Which[
  $OperatingSystem === "MacOSX" ||
    $OperatingSystem === "Unix",  (* Unix version *)
  (* Unix or MacOSX *)
  writeTex[] := writeTex[$result,"Alpha.tex","-d"];
  writeTex[x1_Alpha`system] := writeTex[x1,"Alpha.tex","-d"];
  writeTex[x1_String] :=writeTex[$result,x1,"-d"];
  writeTex[x1_String,x2_] :=  writeTex[$result,x1,x2];
  writeTex[x1_]:= writeTex[$result,"Alpha.tex",x1];
  writeTex[sys_Alpha`system,nom_String,op_] :=
  If[ StringMatchQ[ToString[op],"*-d*"], Put[$result,"!write_alpha -t >"<>nom],
        If [StringMatchQ[ToString[op],"*-a*"],
                         Put[$result,"!write_alpha -t -a >"<>nom],
                Print["\n Unknown option: "<>ToString[op]<>" \n"]]],
  (* Other OS *)
  True,
  writeTex[___]:=Message[writeTex::unimpl];
  writeTex::unimpl = "writeTex is not available on this plateform";
];


(* load a Common Nana Format file: 
   a shortcut to '<<"!read_nana < ....."'. In addition,
   sets '$program' and '$result' *)


If[$OperatingSystem === "Unix",

   (* These function are for internal use only *)
     
   Clear[loadNana];
   
   loadNana[] :=				(* no parameters *)
     Print["Please Provide a filename (like "Filename.alpha") "];
   
   loadNana[filename_String] :=
     Module[{tree = Get[StringJoin["!read_nana < ", filename]]},
	    If[Head[tree] === Alpha`function
		 ( Print["function Loaded"];
		  $library = {tree};
		  $program = tree;
		  $result = tree
		  ),
	       If[Head[tree] === List,
        ( Print["Library Loaded"];
	 $library = tree;
	 $program = Last[tree];
	 $result =  Last[tree]
	 ),
		  Print["? load: file was not in CNF format"]
		]
	     ];
	    tree
	    ];
   

 ];


(* Autoload stuff -- main function exportAlphaFunctions is below
   First some configuration *)

(* Name of the autoload file   -------------------------------------------- *)
Unprotect[`autoloadFile]; 
Clear[autoloadFile];
autoloadFile = $rootDirectory<>"/lib/Packages/Alpha/autoload.m";
Protect[autoloadFile];

(* List of all Alpha autoloaded packages --
   Please DO NOT remove the back quote ! *)
Unprotect[`contexts]; Clear[contexts];
contexts = {
	    "Alpha`Alphard`",
(*
	    "Alpha`BinExpansion`",
	    "Alpha`BitOperators`",
*)
	    "Alpha`ChangeOfBasis`",
	    "Alpha`CheckCell`",
	    "Alpha`CheckController`",
	    "Alpha`CheckModule`",
	    "Alpha`CodeGen`Loops`",
	    "Alpha`CodeGen`Restrict`",
	    "Alpha`CodeGen`Domains`",
	    "Alpha`CodeGen`Output`",
	    "Alpha`CodeGen`",
	    "Alpha`Control`",
	    "Alpha`CutMMA`", 
(*	    "Alpha`Demos`", *)
	    "Alpha`Domlib`",
	    "Alpha`INorm`",
(*	    "Alpha`InterfGen`VirtexGen`", 
	    "Alpha`InterfGen`SocLibGen`", *)
	    "Alpha`UniformizationTools`",
	    "Alpha`MakeDoc`",  (* Added by PQ, July 2004 *)
	    "Alpha`Matrix`",
	    "Alpha`Meta`",
	    "Alpha`Normalization`", 
	    "Alpha`Options`",
(*	    "Alpha`Pip`", *)
	    "Alpha`Pipeline`",
	    "Alpha`PipeControl`",
	    "Alpha`Properties`",
	    "Alpha`Reduction`",  
	    "Alpha`Schedule`",
	    "Alpha`ScheduleTools`",
	    "Alpha`FarkasSchedule`",
	    "Alpha`VertexSchedule`",
	    "Alpha`Semantics`",
	    "Alpha`Schematics`",
	    "Alpha`Static`",
	    "Alpha`Substitution`",
	    "Alpha`Schematics`",
	    "Alpha`SubSystems`",
	    "Alpha`SystemProgramming`",
	    "Alpha`Synthesis`",
	    "Alpha`Tables`",
	    "Alpha`ToAlpha0v2`",
	    "Alpha`Uniformization`",
(*	    "Alpha`Vhdl`", *)
	    "Alpha`vhdlCell`",
	    "Alpha`vhdlCont`",
	    "Alpha`vhdlModule`",
	    "Alpha`VhdlLibGen`",
	    "Alpha`vhdlTestBench`",
	    "Alpha`Vhdl2`",
	    "Alpha`Visual`",
	    "Alpha`Visual3D`"
	    };
Protect[contexts];

(* exportAlphaFunctions :function to build autoload information ----------- *)
Clear[exportAlphaFunctions];

exportAlphaFunctions::wrongArg = "`1`";

exportAlphaFunctions[] := exportAlphaFunctions[autoloadFile];

exportAlphaFunctions[
  fileName:_String] :=
  With[{f = OpenWrite[fileName]},
    Print[ contexts ];
    Scan[Needs, contexts]; (* contexts: see below *)
    WriteString[f, "(*\n   This file was automatically produced --",
		   " DO NOT EDIT --\n*)\n\n"];
    Print[ contexts ];
    Thread[writeDeclarePackage[f, contexts]];
    Close[f];
  ];

exportAlphaFunctions[a___] :=
Module[{},
   Message[exportAlphaFunctions::wrongArg, {a}];
   $Failed
];

(* Private function. Writes a DeclarePackage for context ctx ------------ *)
(* Please DO NOT remove the back quote ! *)
Unprotect[`writeDeclarePackage];
Clear[writeDeclarePackage];

writeDeclarePackage[
  s:_OutputStream,
  ctx:_String] :=
With[{names = Names[ctx<>"*"]},
  If[Length[names] > 0,
    WriteString[s, "DeclarePackage[", InputForm[ctx], ",{\n" ];
    Scan[WriteString[s, "  ", InputForm[#], ",\n"]&,
	       Drop[names, -1]
    ];
    WriteString[s, "  ", InputForm[Last[names]], "\n"];
    WriteString[s, "  }];"];
    WriteString[s, "\n\n"];
  ]
];

Protect[writeDeclarePackage];

(* 
  enTete function used for programming function; 
  shortcut for declaring correctly a new function in MMAlpha 
  (including options transmition, wrong arg trapping and so on) 
*)
Clear[enTete];

enTete[fun_]:=
Module[{n1,res},
   n1=ToString[fun];
   res = StringJoin[
     n1,"::usage=\" ... \"\n\n",   (* usage part *)
     "Clear[",n1,"];\n\n",         (* Clear *)
     "Options[",n1,"]={debug->False}\n\n", (* Options *)
     n1,"[arg1, arg2, options___Rule]:=\n   Module[{},\n        ]\n\n", (* Arguments *)
     n1,"::params=\"wrong parameters ",  (* Error message when called with wrong arguments *)
     n1, " : `1` \"\n\n", 
     n1,"[a:___]:=Message[",n1,"::params,Map[Head,{a}]]\n\n"
  ];
  OutputForm[res]
];

enTete::wrongArg="wrong Argument for function enTete : `1` ";
enTete[a:___]:=Message[enTete::wrongArg,Map[Head,{a}]];



End[];

Protect[add, affine, and, binop, boolean, bottom, call, 
	case, const,decl, depend, div, domain, dtable, eq, equation, 
	exportAlphaFunctions, ge, gt, idiv, if, integer, le, let, loop, 
        lt, matrix, max, min, mod, mul, neg, not, notype, or, pol, 
        real, reduce,restrict, sqrt, sub, system, unknown, unop, 
        use, var, xor, zpol, sched, scdc, quast, newParam, pip, 
	scheduleResult,$testDirectory, $tmpDirectory, $demoDirectory, 
	$rootDirectory, $MMALPH,integerOp, fixedPointOp, dependuse
];


EndPackage[];

(* If the autoloadFile does exists, read it else build it *)

If[FileType[Alpha`Private`autoloadFile] === None,
   Print["Building the functions list (first time only). Please wait"];
   exportAlphaFunctions[],
   Get[Alpha`Private`autoloadFile]
 ]
Unprotect[Information];
Information[s:_Symbol/;MemberQ[Attributes[s], Stub]] := Null;
Protect[Information];
