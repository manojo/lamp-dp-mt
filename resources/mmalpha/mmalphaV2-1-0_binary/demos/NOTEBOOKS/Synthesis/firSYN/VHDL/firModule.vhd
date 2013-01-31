-- VHDL Model Created for "system firModule" 
-- 25/4/2010 18:24:33.286871
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY firModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1In : IN  SIGNED (15 DOWNTO 0);
  xXMirr1In : IN  SIGNED (15 DOWNTO 0);
  ser1Out : OUT Array4To100OfInteger
);
END firModule;

ARCHITECTURE behavioural OF firModule IS
    SIGNAL ser1Xctl1 :  STD_LOGIC;
    SIGNAL HXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL xXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx11 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx1Reg2Xloc : Array3To101OfInteger;
    SIGNAL pipeCH11 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCH1Reg1 : Array3To100OfInteger;
    SIGNAL pipeCx12 : Array4To100OfInteger;
    SIGNAL pipeCH12 : Array4To100OfInteger;
    SIGNAL ser1Xctl1XIn : Array4To100OfBoolean;
    SIGNAL ser12 : Array4To100OfInteger;
    SIGNAL pipeCx14 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCH14 :  SIGNED (15 DOWNTO 0);


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for cellfirModule1
COMPONENT cellfirModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1 : IN SIGNED (15 DOWNTO 0);
  xXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCx1 : OUT SIGNED (15 DOWNTO 0);
  pipeCH1 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellfirModule2
COMPONENT cellfirModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx1Reg2Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCH1Reg1 : IN SIGNED (15 DOWNTO 0);
  ser1Xctl1XIn : IN STD_LOGIC;
  pipeCx1 : OUT SIGNED (15 DOWNTO 0);
  pipeCH1 : OUT SIGNED (15 DOWNTO 0);
  ser1 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellfirModule4
COMPONENT cellfirModule4
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx1Reg2Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCH1Reg1 : IN SIGNED (15 DOWNTO 0);
  pipeCx1 : OUT SIGNED (15 DOWNTO 0);
  pipeCH1 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for ControlfirModule
COMPONENT ControlfirModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ser1Xctl1 : OUT STD_LOGIC
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  HXMirr1 <= HXMirr1In;

  pipeCH1Reg1(3) <= pipeCH11;

  G1 : FOR p IN 5 TO 100 GENERATE
    pipeCH1Reg1(p) <= pipeCH12(-1 + p);
  END GENERATE;

  pipeCH1Reg1(4) <= pipeCH14;

  pipeCx1Reg2Xloc(3) <= pipeCx11;

  G2 : FOR p IN 5 TO 101 GENERATE
    pipeCx1Reg2Xloc(p) <= pipeCx12(-1 + p);
  END GENERATE;

  pipeCx1Reg2Xloc(4) <= pipeCx14;

  G3 : FOR p IN 4 TO 100 GENERATE
    ser1Out(p) <= ser12(p);
  END GENERATE;

  G4 : FOR p IN 4 TO 100 GENERATE
    ser1Xctl1XIn(p) <= ser1Xctl1;
  END GENERATE;

  xXMirr1 <= xXMirr1In;

  G5 : ControlfirModule PORT MAP (clk, CE, rst, ser1Xctl1));

  G6 : cellfirModule1 PORT MAP (clk, CE, rst, HXMirr1(2)(2), xXMirr1(2)(2), pipeCx11(2)(2), (2)(2));

  G7 : cellfirModule2 PORT MAP (clk, CE, rst, pipeCx1Reg2Xloc(4)(100), pipeCH1Reg1(4)(100), ser1Xctl1XIn(4)(100), pipeCx12(4)(100), pipeCH12(4)(100), (4)(100));

  G8 : cellfirModule4 PORT MAP (clk, CE, rst, pipeCx1Reg2Xloc(3)(3), pipeCH1Reg1(3)(3), pipeCx14(3)(3), (3)(3));

END BEHAVIOURAL;

