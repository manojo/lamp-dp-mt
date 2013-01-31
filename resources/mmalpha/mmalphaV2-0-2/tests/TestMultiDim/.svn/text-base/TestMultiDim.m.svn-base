dir = Directory[];


 SetDirectory[Environment["MMALPHA"]<>"/tests/TestMultiDim"]; 

res=True;

load["MMunif.alpha"];
If[ testSched[schedule[multiDimensional->True]],
Print["OK"];res = res && True,
Print["Last result should be (1-dimensionnal): \n
T_a{i, j, N} = 0\n
T_b{i, j, N} = 0\n
T_c{i, j, N} = i + j + N\n
T_B{i, j, k, N} = i\n
T_A{i, j, k, N} = j\n
T_C{i, j, k, N} = -1 + i + j + k\n"];
res=res && False];

load["multi1.alpha"];
If [testSched[schedule[multiDimensional->True]],
Print["OK"];res=res && True,
res=res && False;
    Print["Last result should be (2-dimensionnal): \n
T_a{i, j, k, N} = -1 + i\n
                  -1 + k\n
T_b{i, j, k, N} = -1 + i\n
                  -k + N\n"]];

load["multi2.alpha"];
If [testSched[schedule[multiDimensional->True]],
Print["OK"];res=res && True,
res=res && False;
Print["Last result should be (2-dimensionnel): \n
T_a{i, j, k, N} = -1 + i\n
                  -1 + k\n
T_b{i, j, k, N} = -1 + i\n
                  -k + N\n
T_c{i, j, k, N} = i\n
                  0\n"]]

Print["testing addition of Constraints "];
If [testSched[schedule[multiDimensional->True,
		       addConstraints -> {{"TaD1==2"},{"TaD3==2"}}]],
Print["OK"];res=res && True,
res=res && False;
Print["Last result should be (2-dimensionnel): \n
T_a{i, j, k, N} = -2 + 2 i\n
                  -2 + 2 k\n
T_b{i, j, k, N} = -2 + 2 i\n
                  -k + N\n
T_c{i, j, k, N} = -1 + 2 i\n
                  0"]
  ];

If [res,
    Print["No problem occured during test of MultiDim.m"],
    Print["WARNING: problems occured during test of MultiDim.m"]];

SetDirectory[dir];

res 
