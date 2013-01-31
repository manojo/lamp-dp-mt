-- VHDL Model Created for "system fir" 
-- 5/1/2009 21:53:24.607936
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE HXMirr1TYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE xXMirr1TYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE ser1TYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY fir IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN  SIGNED (15 DOWNTO 0);
  H : IN  SIGNED (15 DOWNTO 0);
  res : OUT  SIGNED (15 DOWNTO 0)
);
END fir;

ARCHITECTURE behavioural OF fir IS
    SIGNAL HXMirr1 : HXMirr1TYPE;
    SIGNAL xXMirr1 : xXMirr1TYPE;
    SIGNAL ser1 : ser1TYPE;


  -- Insert missing components here!

COMPONENT firModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1In : IN HXMirr1InTYPE;
  xXMirr1In : IN xXMirr1InTYPE;
  ser1Out : OUT ser1OutTYPE
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p IN 4 TO 100 GENERATE
    HXMirr1(p) <= H;
  END GENERATE;

  G2 : FOR p IN 4 TO 100 GENERATE
    xXMirr1(p) <= x;
  END GENERATE;

  G3 : FOR p IN 4 TO 100 GENERATE
    res(p) <= ser1(104,p);
  END GENERATE;

  G4 : firModule PORT MAP (clk, CE, Rst, HXMirr1, xXMirr1, ser1);
END BEHAVIOURAL;

