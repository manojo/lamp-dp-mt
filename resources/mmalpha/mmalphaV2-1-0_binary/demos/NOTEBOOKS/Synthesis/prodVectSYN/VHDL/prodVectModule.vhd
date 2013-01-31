-- VHDL Model Created for "system prodVectModule" 
-- 25/4/2010 18:25:18.232204
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY prodVectModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aReg2In : IN Array1To20OfInteger;
  bXMirr1In : IN  SIGNED (15 DOWNTO 0);
  COut : OUT Array1To20OfInteger
);
END prodVectModule;

ARCHITECTURE behavioural OF prodVectModule IS
    SIGNAL CXctl1 :  STD_LOGIC;
    SIGNAL bXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCb11 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCb1Reg3 : Array1To20OfInteger;
    SIGNAL pipeCb12 : Array1To20OfInteger;
    SIGNAL aReg2 : Array1To20OfInteger;
    SIGNAL CXctl1XIn : Array1To20OfBoolean;
    SIGNAL C2 : Array1To20OfInteger;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for cellprodVectModule1
COMPONENT cellprodVectModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  bXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCb1 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellprodVectModule2
COMPONENT cellprodVectModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCb1Reg3 : IN SIGNED (15 DOWNTO 0);
  aReg2 : IN SIGNED (15 DOWNTO 0);
  CXctl1XIn : IN STD_LOGIC;
  pipeCb1 : OUT SIGNED (15 DOWNTO 0);
  C : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for ControlprodVectModule
COMPONENT ControlprodVectModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  CXctl1 : OUT STD_LOGIC
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  G1 : FOR p IN 1 TO 20 GENERATE
    aReg2(p) <= aReg2In(p);
  END GENERATE;

  bXMirr1 <= bXMirr1In;

  G2 : FOR p IN 1 TO 20 GENERATE
    COut(p) <= C2(p);
  END GENERATE;

  G3 : FOR p IN 1 TO 20 GENERATE
    CXctl1XIn(p) <= CXctl1;
  END GENERATE;

  pipeCb1Reg3(1) <= pipeCb11;

  G4 : FOR p IN 2 TO 20 GENERATE
    pipeCb1Reg3(p) <= pipeCb12(-1 + p);
  END GENERATE;

  G5 : ControlprodVectModule PORT MAP (clk, CE, rst, CXctl1));

  G6 : cellprodVectModule1 PORT MAP (clk, CE, rst, bXMirr1(0)(0), (0)(0));

  G7 : cellprodVectModule2 PORT MAP (clk, CE, rst, pipeCb1Reg3(1)(20), aReg2(1)(20), CXctl1XIn(1)(20), pipeCb12(1)(20), (1)(20));

END BEHAVIOURAL;

