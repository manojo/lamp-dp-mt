-- VHDL Model Created for "system TimesModule" 
 --  11/6/2004 12:35:44

library IEEE;
use IEEE.std_logic_1164.all;
 library test;
 use test.definition.all;


entity TimesModule is
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      AMirrorIn : In std_logic_vector(0 to 0);
      BMirrorIn : In std_logic_vector(0 to 0);
      S_Plus1Out : Out std_logic_vector(0 to 15) );
end TimesModule;


architecture Behavioral of TimesModule is

  signal Cin_Plus1_ctl1_Init : std_logic;
  signal S_Plus1_ctl1_Init : std_logic;
  signal BB_ctl1_Init : std_logic;
  signal BMirror : std_logic_vector(0 to 0);
  signal AMirror : std_logic_vector(0 to 0);
  signal S_Plus11 : std_logic_vector(0 to 0);
  signal S_Plus1_reg7loc : std_logic_vector(1 to 16);
  signal AA1 : std_logic_vector(0 to 0);
  signal AA_reg5loc : std_logic_vector(1 to 16);
  signal B_In1 : B_In1Type;
  signal B_In_reg4loc : B_In_reg4locType;
  signal BB_ctl11 : std_logic_vector(0 to 0);
  signal BB_ctl1_reg3loc : std_logic_vector(1 to 16);
  signal Cin_Plus1_ctl11 : std_logic_vector(0 to 0);
  signal Cin_Plus1_ctl1_reg2loc : std_logic_vector(1 to 16);
  signal S_Plus1_ctl11 : std_logic_vector(0 to 0);
  signal S_Plus1_ctl1_reg1loc : std_logic_vector(1 to 16);
  signal S_Plus1_ctl1_In : std_logic_vector(0 to 0);
  signal Cin_Plus1_ctl1_In : std_logic_vector(0 to 0);
  signal BB_ctl1_In : std_logic_vector(0 to 0);
  signal S_Plus12 : std_logic_vector(1 to 15);
  signal AA2 : std_logic_vector(1 to 15);
  signal B_In2 : B_In2Type;
  signal BB_ctl12 : std_logic_vector(1 to 15);
  signal Cin_Plus1_ctl12 : std_logic_vector(1 to 15);
  signal S_Plus1_ctl12 : std_logic_vector(1 to 15);
 
Component cellTimesModule1
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      BMirror : In std_logic;
      AMirror : In std_logic;
      S_Plus1_ctl1_In : In std_logic;
      Cin_Plus1_ctl1_In : In std_logic;
      BB_ctl1_In : In std_logic;
      S_Plus1 : Out std_logic;
      AA : Out std_logic;
      B_In : Out Integer range -32767 to 32767;
      BB_ctl1 : Out std_logic;
      Cin_Plus1_ctl1 : Out std_logic;
      S_Plus1_ctl1 : Out std_logic );
end Component;

 
Component cellTimesModule2
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      S_Plus1_reg7loc : In std_logic;
      AA_reg5loc : In std_logic;
      B_In_reg4loc : In Integer range -32767 to 32767;
      BB_ctl1_reg3loc : In std_logic;
      Cin_Plus1_ctl1_reg2loc : In std_logic;
      S_Plus1_ctl1_reg1loc : In std_logic;
      S_Plus1 : Out std_logic;
      AA : Out std_logic;
      B_In : Out Integer range -32767 to 32767;
      BB_ctl1 : Out std_logic;
      Cin_Plus1_ctl1 : Out std_logic;
      S_Plus1_ctl1 : Out std_logic );
end Component;

 
Component ControlTimesModule
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      Cin_Plus1_ctl1_Init : Out std_logic;
      S_Plus1_ctl1_Init : Out std_logic;
      BB_ctl1_Init : Out std_logic );
end Component;


begin

ETIQUETTE1 : FOR i IN 1 to 1 GENERATE 
   AA_reg5loc(i) <= AA1(i-1);
END GENERATE ETIQUETTE1;

ETIQUETTE2 : FOR i IN 2 to 16 GENERATE 
   AA_reg5loc(i) <= AA2(i-1);
END GENERATE ETIQUETTE2;

ETIQUETTE3 : FOR i IN 0 to 0 GENERATE 
   AMirror(i) <= AMirrorIn(i);
END GENERATE ETIQUETTE3;

ETIQUETTE4 : FOR i IN 0 to 0 GENERATE 
   BB_ctl1_In(i) <= BB_ctl1_Init;
END GENERATE ETIQUETTE4;

ETIQUETTE5 : FOR i IN 1 to 1 GENERATE 
   BB_ctl1_reg3loc(i) <= BB_ctl11(i-1);
END GENERATE ETIQUETTE5;

ETIQUETTE6 : FOR i IN 2 to 16 GENERATE 
   BB_ctl1_reg3loc(i) <= BB_ctl12(i-1);
END GENERATE ETIQUETTE6;

ETIQUETTE7 : FOR i IN 1 to 1 GENERATE 
   B_In_reg4loc(i) <= B_In1(i-1);
END GENERATE ETIQUETTE7;

ETIQUETTE8 : FOR i IN 2 to 16 GENERATE 
   B_In_reg4loc(i) <= B_In2(i-1);
END GENERATE ETIQUETTE8;

ETIQUETTE9 : FOR i IN 0 to 0 GENERATE 
   BMirror(i) <= BMirrorIn(i);
END GENERATE ETIQUETTE9;

ETIQUETTE10 : FOR i IN 0 to 0 GENERATE 
   Cin_Plus1_ctl1_In(i) <= Cin_Plus1_ctl1_Init;
END GENERATE ETIQUETTE10;

ETIQUETTE11 : FOR i IN 1 to 1 GENERATE 
   Cin_Plus1_ctl1_reg2loc(i) <= Cin_Plus1_ctl11(i-1);
END GENERATE ETIQUETTE11;

ETIQUETTE12 : FOR i IN 2 to 16 GENERATE 
   Cin_Plus1_ctl1_reg2loc(i) <= Cin_Plus1_ctl12(i-1);
END GENERATE ETIQUETTE12;

ETIQUETTE13 : FOR i IN 0 to 0 GENERATE 
   S_Plus1_ctl1_In(i) <= S_Plus1_ctl1_Init;
END GENERATE ETIQUETTE13;

ETIQUETTE14 : FOR i IN 1 to 1 GENERATE 
   S_Plus1_ctl1_reg1loc(i) <= S_Plus1_ctl11(i-1);
END GENERATE ETIQUETTE14;

ETIQUETTE15 : FOR i IN 2 to 16 GENERATE 
   S_Plus1_ctl1_reg1loc(i) <= S_Plus1_ctl12(i-1);
END GENERATE ETIQUETTE15;

ETIQUETTE16 : FOR i IN 0 to 0 GENERATE 
   S_Plus1Out(i) <= S_Plus11(i);
END GENERATE ETIQUETTE16;

ETIQUETTE17 : FOR i IN 1 to 15 GENERATE 
   S_Plus1Out(i) <= S_Plus12(i);
END GENERATE ETIQUETTE17;

ETIQUETTE18 : FOR i IN 1 to 1 GENERATE 
   S_Plus1_reg7loc(i) <= S_Plus11(i-1);
END GENERATE ETIQUETTE18;

ETIQUETTE19 : FOR i IN 2 to 16 GENERATE 
   S_Plus1_reg7loc(i) <= S_Plus12(i-1);
END GENERATE ETIQUETTE19;

ETIQUETTE20: ControlTimesModule Port Map(Ck,CE,Rst, Cin_Plus1_ctl1_Init,S_Plus1_ctl1_Init,BB_ctl1_Init);
 
ETIQUETTE21 : FOR i IN 0 to 0 GENERATE 
   ETIQUETTE22: cellTimesModule1 PORT MAP( Ck,CE,Rst, BMirror(i),AMirror(i),S_Plus1_ctl1_In(i),Cin_Plus1_ctl1_In(i),BB_ctl1_In(i),S_Plus11(i),AA1(i),B_In1(i),BB_ctl11(i),Cin_Plus1_ctl11(i),S_Plus1_ctl11(i));
 END GENERATE  ETIQUETTE21;

ETIQUETTE23 : FOR i IN 1 to 15 GENERATE 
   ETIQUETTE24: cellTimesModule2 PORT MAP( Ck,CE,Rst, S_Plus1_reg7loc(i),AA_reg5loc(i),B_In_reg4loc(i),BB_ctl1_reg3loc(i),Cin_Plus1_ctl1_reg2loc(i),S_Plus1_ctl1_reg1loc(i),S_Plus12(i),AA2(i),B_In2(i),BB_ctl12(i),Cin_Plus1_ctl12(i),S_Plus1_ctl12(i));
 END GENERATE  ETIQUETTE23;



end Behavioral;


