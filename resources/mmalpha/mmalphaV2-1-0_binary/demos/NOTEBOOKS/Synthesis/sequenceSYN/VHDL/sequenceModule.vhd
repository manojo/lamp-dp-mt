-- VHDL Model Created for "system sequenceModule" 
-- 25/4/2010 18:25:5.735703
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY sequenceModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1In : IN  SIGNED (15 DOWNTO 0);
  TSep3In : IN Array1To20OfInteger;
  MOut : OUT Array0To20OfInteger
);
END sequenceModule;

ARCHITECTURE behavioural OF sequenceModule IS
    SIGNAL pipeCQS1Xctl1 :  STD_LOGIC;
    SIGNAL MXctl2 :  STD_LOGIC;
    SIGNAL DBXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL M1 :  SIGNED (15 DOWNTO 0);
    SIGNAL MReg2Xloc : Array1To21OfInteger;
    SIGNAL pipeCDB11 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCDB1Reg4 : Array1To20OfInteger;
    SIGNAL M2 : Array1To20OfInteger;
    SIGNAL pipeCDB12 : Array1To20OfInteger;
    SIGNAL MXctl2XIn : Array1To20OfBoolean;
    SIGNAL pipeCQS1Xctl1XIn : Array1To20OfBoolean;
    SIGNAL TSep3 : Array1To20OfInteger;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for cellsequenceModule1
COMPONENT cellsequenceModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  pipeCDB1 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellsequenceModule2
COMPONENT cellsequenceModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  MReg2Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCDB1Reg4 : IN SIGNED (15 DOWNTO 0);
  MXctl2XIn : IN STD_LOGIC;
  pipeCQS1Xctl1XIn : IN STD_LOGIC;
  TSep3 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  pipeCDB1 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for ControlsequenceModule
COMPONENT ControlsequenceModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCQS1Xctl1 : OUT STD_LOGIC;
  MXctl2 : OUT STD_LOGIC
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  DBXMirr1 <= DBXMirr1In;

  MOut(0) <= M1;

  G1 : FOR p IN 1 TO 20 GENERATE
    MOut(p) <= M2(p);
  END GENERATE;

  MReg2Xloc(1) <= M1;

  G2 : FOR p IN 2 TO 21 GENERATE
    MReg2Xloc(p) <= M2(-1 + p);
  END GENERATE;

  G3 : FOR p IN 1 TO 20 GENERATE
    MXctl2XIn(p) <= MXctl2;
  END GENERATE;

  pipeCDB1Reg4(1) <= pipeCDB11;

  G4 : FOR p IN 2 TO 20 GENERATE
    pipeCDB1Reg4(p) <= pipeCDB12(-1 + p);
  END GENERATE;

  G5 : FOR p IN 1 TO 20 GENERATE
    pipeCQS1Xctl1XIn(p) <= pipeCQS1Xctl1;
  END GENERATE;

  G6 : FOR p IN 1 TO 20 GENERATE
    TSep3(p) <= TSep3In(p);
  END GENERATE;

  G7 : ControlsequenceModule PORT MAP (clk, CE, rst, pipeCQS1Xctl1, MXctl2));

  G8 : cellsequenceModule1 PORT MAP (clk, CE, rst, DBXMirr1(0)(0), M1(0)(0), (0)(0));

  G9 : cellsequenceModule2 PORT MAP (clk, CE, rst, MReg2Xloc(1)(20), pipeCDB1Reg4(1)(20), MXctl2XIn(1)(20), pipeCQS1Xctl1XIn(1)(20), TSep3(1)(20), M2(1)(20), (1)(20));

END BEHAVIOURAL;

