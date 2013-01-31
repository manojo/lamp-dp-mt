-- VHDL Model Created for "system firr" 
-- 23/4/2010 8:38:37.097264
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY firr IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN  SIGNED (15 DOWNTO 0);
  d : IN  SIGNED (15 DOWNTO 0);
  res : OUT  SIGNED (15 DOWNTO 0)
);
END firr;

ARCHITECTURE behavioural OF firr IS
    SIGNAL dXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL xXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL xXMirr2 :  SIGNED (15 DOWNTO 0);
    SIGNAL Y : Array-1To2OfInteger;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for firrModule
COMPONENT firrModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  dXMirr1In : IN  SIGNED (15 DOWNTO 0);
  xXMirr1In : IN  SIGNED (15 DOWNTO 0);
  xXMirr2In : IN  SIGNED (15 DOWNTO 0);
  YOut : OUT Array-1To2OfInteger
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  dXMirr1 <= d;

  xXMirr2 <= x;

  xXMirr1 <= x;

  res <= Y(2);

  G1 : firrModule PORT MAP (clk, CE, rst, dXMirr1, xXMirr1, xXMirr2, Y));

END BEHAVIOURAL;

