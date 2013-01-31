(* This is a simple init.m file. It has to be copied with the name
 init.m in ~/Library/Mathematica/Kernel for version 6 and 7 of Mathematica. If 
 you have an earlier version, it has to be put in your home directory. *)
Module[ {env},
  Catch[
    Print["****************"];
    env = Environment["MMALPHA"];
    If[ env === $Failed, 
	  mmalpha::noenv = "The MMALPHA environment variable is not set";
	  Throw[ Message[ mmalpha::noenv ] ]
    ];
    Print["MMALPHA is in directory ", env ];
    Print["Now executing ", env<>"/config/init.m"];
    Get[ env<>"/config/init.m" ]
  ]
]
