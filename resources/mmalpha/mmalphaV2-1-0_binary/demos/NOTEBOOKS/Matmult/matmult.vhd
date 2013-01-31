-- VHDL Model Created for "system matmult" 
-- 30/11/2008 14:18:18.080811
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
 TYPE LineTYPE1 IS ARRAY (INTEGER RANGE <>) OF  SIGNED (15 DOWNTO 0);
  TYPE aTYPE IS ARRAY (1 TO 10) OF  SIGNED (15 DOWNTO 0);
  TYPE bTYPE IS ARRAY (1 TO 10) OF  SIGNED (15 DOWNTO 0);
  TYPE cTYPE IS ARRAY (1 TO 10) OF  SIGNED (15 DOWNTO 0);
  TYPE aXMirr1TYPE IS ARRAY (1 TO 10) OF LineTYPE1 (1 TO 10);
  TYPE bXMirr1TYPE IS ARRAY (1 TO 10) OF LineTYPE1 (1 TO 10);
  TYPE CTYPE IS ARRAY (1 TO 10) OF LineTYPE1 (1 TO 10);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY matmult IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  a : IN aTYPE;
  b : IN bTYPE;
  c : OUT cTYPE
);
END matmult;

ARCHITECTURE behavioural OF matmult IS
    SIGNAL aXMirr1 : aXMirr1TYPE;
    SIGNAL bXMirr1 : bXMirr1TYPE;
    SIGNAL C : CTYPE;


  -- Insert missing components here!

COMPONENT matmultModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aXMirr1In : IN aXMirr1InTYPE;
  bXMirr1In : IN bXMirr1InTYPE;
  COut : OUT COutTYPE
);
END COMPONENT;


  ----BEGIN

  G1 : matmultModule PORT MAP (clk, CE, Rst, aXMirr1, bXMirr1, C);
END BEHAVIOURAL;

