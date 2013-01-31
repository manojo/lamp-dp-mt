-- VHDL Model Created for "system fir" 
-- 25/4/2010 18:24:33.427286
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

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
    SIGNAL HXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL xXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL ser1 : Array4To100OfInteger;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for firModule
COMPONENT firModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1In : IN  SIGNED (15 DOWNTO 0);
  xXMirr1In : IN  SIGNED (15 DOWNTO 0);
  ser1Out : OUT Array4To100OfInteger
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  HXMirr1 <= H;

  xXMirr1 <= x;

  G1 : FOR p IN 4 TO 100 GENERATE
    res(p) <= ser1(104,p);
  END GENERATE;

  G2 : firModule PORT MAP (clk, CE, rst, HXMirr1, xXMirr1, ser1));

END BEHAVIOURAL;

