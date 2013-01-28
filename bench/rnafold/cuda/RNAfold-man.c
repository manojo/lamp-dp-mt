if (manoptmode == '-')
switch (manopt) {
  case 'h':
    printf("-h Display this information\n\nOption -h displays a command option overview.\n");
    break;
  case 'H':
    printf("-H <option> Display detailed information on <option>\n\nThis displays the corresponding section of the RNAfold manual for the\ngiven command line option.\n");
    break;
  case 'v':
    printf("-v Show version\n\nThis shows the version number of RNAfold.\n");
    break;
  case 'b':
    printf("-b <value> Set number of blocks\n\nThis switch sets the number of CUDA-blocks.\n");
    break;
  case 'T':
    printf("-T <value> Set number of threads per blocks\n\nThis switch sets the number of threads per CUDA-block.\n");
    break;
  case 'e':
    printf("-e <value> Set energy range (kcal/mol)\n\nThis sets the energy range for suboptimal results. value is the\ndifference to the minimum free energy for the sequence.\n");
    break;
  case 'c':
    printf("-c <value> Set energy range (%%%%)\n\nThis sets the energy range as percentage value of the minimum free\nenergy. For example, when -c 10 is specified, and the minimum free\nenergy is -10.0 kcal/mol, the energy range is set to -9.0 to -10.0\nkcal/mol.\n");
    break;
  case 'M':
    printf("-M <value> Set maximal loop length\n\nThis option sets the maximum lengths of the considered internal and\nbulge loops. The default value here is 30. For unrestricted loop\nlengths, use option -M n. This will increase calculation times and\nmemory requirements.\n");
    break;
  case 'w':
    printf("-w <value> Set window size\n\nBeginning with position 1 of the input sequence, the analysis is\nrepeatedly processed on subsequences of the specified size. After each\ncalculation, the results are printed out and the window is moved by the\nwindow position increment (-W), until the end of the input sequence is\nreached.\n");
    break;
  case 'W':
    printf("-W <value> Set window position increment\n\nThis option specifies the increment for the window analysis mode (-w).\n");
    break;
  case 'B':
    printf("-B Show best results in window mode\n\nThis option specifies, that only the best results are shown in window\nmode.\n");
    break;
  case 'S':
    printf("-S <value> Specify output width for structures\n\nThis splits the structure strings into parts of the specified length.\nThis option is useful when displaying results for long sequences that\nwould otherwise not fit onto the screen.\n");
    break;
  case 'f':
    printf("-f <filename> Read input from file\n\nLet RNAfold load its input data from file. file can contain a plain\nsingle sequence, or multiple sequences in fasta format. When given\nmultiple sequences, each sequence is processed separately in the order\nof input.\n\nValid characters in an input sequence are \"ACGU\" and \"acgu\". \"T\" and \"t\"\nwill be converted to \"U\". Other letters are mapped to \"N\" and will not\nbe paired. All other characters are ignored.\n");
    break;
  case 'z':
    printf("-z Colored output\n\nThis option enables colored output. In interactive mode, this is the\ndefault setting, so use -z to disable colors here.\n");
    break;
  default: fprintf(stderr, "unknown command line option -%c\n", manopt);
}
else
switch (manopt) {
  case 's':
    printf(":s Show current configuration\n\nThis command shows the current settings in an interactive RNAfold\nsession.\n");
    break;
  case 'd':
    printf(":d Reset configuration\n\nThis command sets all settings to their default values.\n");
    break;
  case 'e':
    printf(":e <string> Execute system command\n\nCommand :e executes a system command.\n");
    break;
  case 'q':
    printf(":q Quit\n\nThis command quits an interactive RNAfold session.\n");
    break;
  default: fprintf(stderr, "unknown command :%c\n", manopt);
}
