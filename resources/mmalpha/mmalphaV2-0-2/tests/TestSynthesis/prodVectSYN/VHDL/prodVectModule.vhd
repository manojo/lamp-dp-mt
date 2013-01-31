-- VHDL Model Created for "system prodVectModule" 
-- 5/1/2009 21:53:46.848288
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE aReg2InTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE bXMirr1InTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE COutTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE bXMirr1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE aReg2TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE CXctl1XInTYPE IS ARRAY (1 TO 20) OF  STD_LOGIC;
  TYPE C1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY prodVectModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aReg2In : IN aReg2InTYPE;
  bXMirr1In : IN bXMirr1InTYPE;
  COut : OUT COutTYPE
);
END prodVectModule;

ARCHITECTURE behavioural OF prodVectModule IS
    SIGNAL CXctl1 :  STD_LOGIC;
    SIGNAL bXMirr1 : bXMirr1TYPE;
    SIGNAL aReg2 : aReg2TYPE;
    SIGNAL CXctl1XIn : CXctl1XInTYPE;
    SIGNAL C1 : C1TYPE;


  -- Insert missing components here!

COMPONENT ControlprodVectModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  CXctl1 : OUT STD_LOGIC
);
END COMPONENT;
COMPONENT cellprodVectModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  bXMirr1 : IN  SIGNED (15 DOWNTO 0);
  aReg2 : IN  SIGNED (15 DOWNTO 0);
  CXctl1XIn : IN  STD_LOGIC;
  C : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p IN 1 TO 20 GENERATE
    aReg2(p) <= aReg2In(p);
  END GENERATE;

  G2 : FOR p IN 1 TO 20 GENERATE
    bXMirr1(p) <= bXMirr1In(p);
  END GENERATE;

  G3 : FOR p IN 1 TO 20 GENERATE
    COut(p) <= C1(p);
  END GENERATE;

  G4 : FOR p IN 1 TO 20 GENERATE
    CXctl1XIn(p) <= CXctl1;
  END GENERATE;

  G5 : ControlprodVectModule PORT MAP (clk, CE, Rst, CXctl1);

  G6 : FOR p IN 1 TO 20 GENERATE
    G7 : cellprodVectModule1 PORT MAP (clk, CE, Rst, bXMirr1(p), aReg2(p), CXctl1XIn(p), C1(p));
  END GENERATE;
END BEHAVIOURAL;

