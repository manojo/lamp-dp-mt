-- VHDL Model Created for "system firModule" 
-- 1/8/2008 10:29:33.954955
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE HXMirr1InTYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE xXMirr1InTYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE ser1OutTYPE IS ARRAY (20 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE HXMirr1TYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE xXMirr1TYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCx31TYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCx3Reg2XlocTYPE IS ARRAY (3 TO 101) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCH31TYPE IS ARRAY (2 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCH3Reg1TYPE IS ARRAY (3 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCx32TYPE IS ARRAY (20 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCH32TYPE IS ARRAY (20 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE ser1Xctl1XInTYPE IS ARRAY (20 TO 100) OF  STD_LOGIC;
  TYPE ser12TYPE IS ARRAY (20 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCx34TYPE IS ARRAY (3 TO 19) OF  SIGNED (15 DOWNTO 0);
  TYPE pipeCH34TYPE IS ARRAY (3 TO 19) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library work;
use work.definition.all;


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
    SIGNAL pipeCx31 : pipeCx31TYPE;
    SIGNAL pipeCx3Reg2Xloc : pipeCx3Reg2XlocTYPE;
    SIGNAL pipeCH31 : pipeCH31TYPE;
    SIGNAL pipeCH3Reg1 : pipeCH3Reg1TYPE;
    SIGNAL pipeCx32 : pipeCx32TYPE;
    SIGNAL pipeCH32 : pipeCH32TYPE;
    SIGNAL ser1Xctl1XIn : ser1Xctl1XInTYPE;
    SIGNAL ser12 : ser12TYPE;
    SIGNAL pipeCx34 : pipeCx34TYPE;
    SIGNAL pipeCH34 : pipeCH34TYPE;


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
  pipeCx3 : OUT  SIGNED (15 DOWNTO 0);
  pipeCH3 : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;


COMPONENT cellfirModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx3Reg2Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCH3Reg1 : IN  SIGNED (15 DOWNTO 0);
  ser1Xctl1XIn : IN  STD_LOGIC;
  pipeCx3 : OUT  SIGNED (15 DOWNTO 0);
  pipeCH3 : OUT  SIGNED (15 DOWNTO 0);
  ser1 : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;


COMPONENT cellfirModule4
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx3Reg2Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCH3Reg1 : IN  SIGNED (15 DOWNTO 0);
  pipeCx3 : OUT  SIGNED (15 DOWNTO 0);
  pipeCH3 : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;

BEGIN

  HXMirr1(2) <= HXMirr1In(2);

  pipeCH3Reg1(3) <= pipeCH31(2);

  G1 : FOR p IN 21 TO 100 GENERATE
    pipeCH3Reg1(p) <= pipeCH32(-1 + p);
  END GENERATE;

  G2 : FOR p IN 4 TO 20 GENERATE
    pipeCH3Reg1(p) <= pipeCH34(-1 + p);
  END GENERATE;

  pipeCx3Reg2Xloc(3) <= pipeCx31(2);

  G3 : FOR p IN 21 TO 101 GENERATE
    pipeCx3Reg2Xloc(p) <= pipeCx32(-1 + p);
  END GENERATE;

  G4 : FOR p IN 4 TO 20 GENERATE
    pipeCx3Reg2Xloc(p) <= pipeCx34(-1 + p);
  END GENERATE;

  G5 : FOR p IN 20 TO 100 GENERATE
    ser1Out(p) <= ser12(p);
  END GENERATE;

  G6 : FOR p IN 20 TO 100 GENERATE
    ser1Xctl1XIn(p) <= ser1Xctl1;
  END GENERATE;

  xXMirr1(2) <= xXMirr1In(2);

  G7 : ControlfirModule PORT MAP (clk, CE, Rst, ser1Xctl1);

    G8 : cellfirModule1 PORT MAP (clk, CE, Rst, HXMirr1(2), xXMirr1(2), pipeCx31(2), pipeCH31(2));

  G9 : FOR p IN 20 TO 100 GENERATE
    G10 : cellfirModule2 PORT MAP (clk, CE, Rst, pipeCx3Reg2Xloc(p), pipeCH3Reg1(p), ser1Xctl1XIn(p), pipeCx32(p), pipeCH32(p), ser12(p));
  END GENERATE;

  G11 : FOR p IN 3 TO 19 GENERATE
    G12 : cellfirModule4 PORT MAP (clk, CE, Rst, pipeCx3Reg2Xloc(p), pipeCH3Reg1(p), pipeCx34(p), pipeCH34(p));
  END GENERATE;
END BEHAVIOURAL;

