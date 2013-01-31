-- VHDL Model Created for "system prodVect" 
-- 5/1/2009 21:53:47.053944
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE aTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE aReg2TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE bXMirr1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE CTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY prodVect IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  a : IN aTYPE;
  b : IN  SIGNED (15 DOWNTO 0);
  c : OUT  SIGNED (15 DOWNTO 0)
);
END prodVect;

ARCHITECTURE behavioural OF prodVect IS
    SIGNAL aReg2 : aReg2TYPE;
    SIGNAL bXMirr1 : bXMirr1TYPE;
    SIGNAL C : CTYPE;


  -- Insert missing components here!

COMPONENT prodVectModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aReg2In : IN aReg2InTYPE;
  bXMirr1In : IN bXMirr1InTYPE;
  COut : OUT COutTYPE
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p IN 1 TO 20 GENERATE
    bXMirr1(p) <= b;
  END GENERATE;

  G2 : FOR p IN 1 TO 20 GENERATE
    aReg2(p) <= a(t);
  END GENERATE;

  G3 : FOR p IN 1 TO 20 GENERATE
    c(p) <= C(20,p);
  END GENERATE;

  G4 : prodVectModule PORT MAP (clk, CE, Rst, aReg2, bXMirr1, C);
END BEHAVIOURAL;

