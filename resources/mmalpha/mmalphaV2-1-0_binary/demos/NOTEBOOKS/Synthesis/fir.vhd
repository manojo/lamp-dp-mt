-- VHDL Model Created for "system fir" 
-- 30/7/2008 17:38:34.615533
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE HXMirr1TYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE xXMirr1TYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE ser1TYPE IS ARRAY (20 TO 100) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library work;
use work.definition.all;


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

BEGIN

  HXMirr1(2) <= H;

  xXMirr1(2) <= x;

  G1 : FOR p IN 20 TO 100 GENERATE
    res(p) <= ser1(20,p);
  END GENERATE;

  G2 : firModule PORT MAP (clk, CE, Rst, HXMirr1, xXMirr1, ser1);
END BEHAVIOURAL;

