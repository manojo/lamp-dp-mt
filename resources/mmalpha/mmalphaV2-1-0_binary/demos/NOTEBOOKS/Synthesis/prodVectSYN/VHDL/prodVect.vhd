-- VHDL Model Created for "system prodVect" 
-- 25/4/2010 18:25:18.367275
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY prodVect IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  a : IN Array1To20OfInteger;
  b : IN  SIGNED (15 DOWNTO 0);
  c : OUT  SIGNED (15 DOWNTO 0)
);
END prodVect;

ARCHITECTURE behavioural OF prodVect IS
    SIGNAL aReg2 : Array1To20OfInteger;
    SIGNAL bXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL C : Array1To20OfInteger;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for prodVectModule
COMPONENT prodVectModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aReg2In : IN Array1To20OfInteger;
  bXMirr1In : IN  SIGNED (15 DOWNTO 0);
  COut : OUT Array1To20OfInteger
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  bXMirr1 <= b;

  G1 : FOR p IN 1 TO 20 GENERATE
    aReg2(p) <= a(t);
  END GENERATE;

  G2 : FOR p IN 1 TO 20 GENERATE
    c(p) <= C(20,p);
  END GENERATE;

  G3 : prodVectModule PORT MAP (clk, CE, rst, aReg2, bXMirr1, C));

END BEHAVIOURAL;

