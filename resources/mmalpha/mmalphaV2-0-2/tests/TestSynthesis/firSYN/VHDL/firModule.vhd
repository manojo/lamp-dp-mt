-- VHDL Model Created for "system firModule" 
-- 5/1/2009 21:53:24.412385
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE HXMirr1InTYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE xXMirr1InTYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE ser1OutTYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE HXMirr1TYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE xXMirr1TYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE ser1Xctl1XInTYPE IS ARRAY (4 TO 100) OF  STD_LOGIC;
  TYPE ser11TYPE IS ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY firModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1In : IN HXMirr1InTYPE;
  xXMirr1In : IN xXMirr1InTYPE;
  ser1Out : OUT ser1OutTYPE
);
END firModule;

ARCHITECTURE behavioural OF firModule IS
    SIGNAL ser1Xctl1 :  STD_LOGIC;
    SIGNAL HXMirr1 : HXMirr1TYPE;
    SIGNAL xXMirr1 : xXMirr1TYPE;
    SIGNAL ser1Xctl1XIn : ser1Xctl1XInTYPE;
    SIGNAL ser11 : ser11TYPE;


  -- Insert missing components here!

COMPONENT ControlfirModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ser1Xctl1 : OUT STD_LOGIC
);
END COMPONENT;
COMPONENT cellfirModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1 : IN  SIGNED (15 DOWNTO 0);
  xXMirr1 : IN  SIGNED (15 DOWNTO 0);
  ser1Xctl1XIn : IN  STD_LOGIC;
  ser1 : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p IN 4 TO 100 GENERATE
    HXMirr1(p) <= HXMirr1In(p);
  END GENERATE;

  G2 : FOR p IN 4 TO 100 GENERATE
    ser1Out(p) <= ser11(p);
  END GENERATE;

  G3 : FOR p IN 4 TO 100 GENERATE
    ser1Xctl1XIn(p) <= ser1Xctl1;
  END GENERATE;

  G4 : FOR p IN 4 TO 100 GENERATE
    xXMirr1(p) <= xXMirr1In(p);
  END GENERATE;

  G5 : ControlfirModule PORT MAP (clk, CE, Rst, ser1Xctl1);

  G6 : FOR p IN 4 TO 100 GENERATE
    G7 : cellfirModule1 PORT MAP (clk, CE, Rst, HXMirr1(p), xXMirr1(p), ser1Xctl1XIn(p), ser11(p));
  END GENERATE;
END BEHAVIOURAL;

