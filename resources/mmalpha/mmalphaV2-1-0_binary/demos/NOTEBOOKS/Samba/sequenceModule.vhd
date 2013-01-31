-- VHDL Model Created for "system sequenceModule" 
-- 23/4/2010 8:53:9.428168
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
  TSep3In : IN Array1To10OfInteger;
  MOut : OUT Array0To10OfInteger
);
END sequenceModule;

ARCHITECTURE behavioural OF sequenceModule IS
    SIGNAL expr2 :  STD_LOGIC;
    SIGNAL M2 : Array2To10OfInteger;
    SIGNAL expr1 : Array1To11OfInteger;
    SIGNAL MXctl2P2 : Array2To10OfBoolean;
    SIGNAL MXctl2PReg5Xloc : Array2To11OfBoolean;
    SIGNAL pipeCDB92 : Array2To10OfInteger;
    SIGNAL pipeCDB9Reg6Xloc : Array1To11OfInteger;
    SIGNAL pipeCQS9Xctl1P2 : Array2To10OfBoolean;
    SIGNAL pipeCQS9Xctl1PReg8Xloc : Array2To11OfBoolean;
    SIGNAL TSep3 : Array1To10OfInteger;
    SIGNAL M3 :  SIGNED (15 DOWNTO 0);
    SIGNAL MXctl2P3 :  STD_LOGIC;
    SIGNAL pipeCDB93 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCQS9Xctl1P3 :  STD_LOGIC;
    SIGNAL MXctl2PXInitXIn :  STD_LOGIC;
    SIGNAL pipeCQS9Xctl1PXInitXIn :  STD_LOGIC;
    SIGNAL M4 :  SIGNED (15 DOWNTO 0);
    SIGNAL DBXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCDB94 :  SIGNED (15 DOWNTO 0);


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for cellsequenceModule2
COMPONENT cellsequenceModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  expr1 : IN SIGNED (15 DOWNTO 0);
  MXctl2PReg5Xloc : IN STD_LOGIC;
  pipeCDB9Reg6Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCQS9Xctl1PReg8Xloc : IN STD_LOGIC;
  TSep3 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  MXctl2P : OUT STD_LOGIC;
  pipeCDB9 : OUT SIGNED (15 DOWNTO 0);
  pipeCQS9Xctl1P : OUT STD_LOGIC
);
END COMPONENT;

-- Component for cellsequenceModule3
COMPONENT cellsequenceModule3
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  expr1 : IN SIGNED (15 DOWNTO 0);
  pipeCDB9Reg6Xloc : IN SIGNED (15 DOWNTO 0);
  MXctl2PXInitXIn : IN STD_LOGIC;
  pipeCQS9Xctl1PXInitXIn : IN STD_LOGIC;
  TSep3 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  MXctl2P : OUT STD_LOGIC;
  pipeCDB9 : OUT SIGNED (15 DOWNTO 0);
  pipeCQS9Xctl1P : OUT STD_LOGIC
);
END COMPONENT;

-- Component for cellsequenceModule4
COMPONENT cellsequenceModule4
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  pipeCDB9 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for ControlsequenceModule
COMPONENT ControlsequenceModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  expr2 : OUT STD_LOGIC
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  DBXMirr1 <= DBXMirr1In;

  G1 : FOR p IN 3 TO 11 GENERATE
    expr1(p) <= M2(-1 + p);
  END GENERATE;

  expr1(2) <= M3;

  expr1(1) <= M4;

  G2 : FOR p IN 2 TO 10 GENERATE
    MOut(p) <= M2(p);
  END GENERATE;

  MOut(1) <= M3;

  MOut(0) <= M4;

  G3 : FOR p IN 3 TO 11 GENERATE
    MXctl2PReg5Xloc(p) <= MXctl2P2(-1 + p);
  END GENERATE;

  MXctl2PReg5Xloc(2) <= MXctl2P3;

  MXctl2PXInitXIn <= expr2;

  G4 : FOR p IN 3 TO 11 GENERATE
    pipeCDB9Reg6Xloc(p) <= pipeCDB92(-1 + p);
  END GENERATE;

  pipeCDB9Reg6Xloc(2) <= pipeCDB93;

  pipeCDB9Reg6Xloc(1) <= pipeCDB94;

  G5 : FOR p IN 3 TO 11 GENERATE
    pipeCQS9Xctl1PReg8Xloc(p) <= pipeCQS9Xctl1P2(-1 + p);
  END GENERATE;

  pipeCQS9Xctl1PReg8Xloc(2) <= pipeCQS9Xctl1P3;

  pipeCQS9Xctl1PXInitXIn <= expr2;

  G6 : FOR p IN 1 TO 10 GENERATE
    TSep3(p) <= TSep3In(p);
  END GENERATE;

  G7 : ControlsequenceModule PORT MAP (clk, CE, rst, expr2));

  G8 : cellsequenceModule2 PORT MAP (clk, CE, rst, expr1(2)(10), MXctl2PReg5Xloc(2)(10), pipeCDB9Reg6Xloc(2)(10), pipeCQS9Xctl1PReg8Xloc(2)(10), TSep3(2)(10), M2(2)(10), MXctl2P2(2)(10), pipeCDB92(2)(10), (2)(10));

  G9 : cellsequenceModule3 PORT MAP (clk, CE, rst, expr1(1)(1), pipeCDB9Reg6Xloc(1)(1), MXctl2PXInitXIn(1)(1), pipeCQS9Xctl1PXInitXIn(1)(1), TSep3(1)(1), M3(1)(1), MXctl2P3(1)(1), pipeCDB93(1)(1), (1)(1));

  G10 : cellsequenceModule4 PORT MAP (clk, CE, rst, DBXMirr1(0)(0), M4(0)(0), (0)(0));

END BEHAVIOURAL;

