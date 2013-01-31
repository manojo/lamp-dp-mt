-- VHDL Model Created for "system computeDistancesModule" 
-- 25/4/2010 18:25:36.904699
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY computeDistancesModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  descriptorXMirr1In : IN  SIGNED (14 DOWNTO 0);
  imageReg4In : IN Array0To99OfSigned14To0;
  dOut : OUT Array0To99OfSigned14To0
);
END computeDistancesModule;

ARCHITECTURE behavioural OF computeDistancesModule IS
    SIGNAL dlocXctl1 :  STD_LOGIC;
    SIGNAL descriptorXMirr1 :  SIGNED (14 DOWNTO 0);
    SIGNAL pipeCdescriptor11 :  SIGNED (14 DOWNTO 0);
    SIGNAL pipeCdescriptor1Reg8 : Array0To99OfSigned14To0;
    SIGNAL pipeCdescriptor12 : Array0To99OfSigned14To0;
    SIGNAL imageReg4 : Array0To99OfSigned14To0;
    SIGNAL dlocXctl1XIn : Array0To99OfBoolean;
    SIGNAL d2 : Array0To99OfSigned14To0;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for cellcomputeDistancesModule1
COMPONENT cellcomputeDistancesModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  descriptorXMirr1 : IN SIGNED (14 DOWNTO 0);
  pipeCdescriptor1 : OUT SIGNED (14 DOWNTO 0)
);
END COMPONENT;

-- Component for cellcomputeDistancesModule2
COMPONENT cellcomputeDistancesModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCdescriptor1Reg8 : IN SIGNED (14 DOWNTO 0);
  imageReg4 : IN SIGNED (14 DOWNTO 0);
  dlocXctl1XIn : IN STD_LOGIC;
  pipeCdescriptor1 : OUT SIGNED (14 DOWNTO 0);
  d : OUT SIGNED (14 DOWNTO 0)
);
END COMPONENT;

-- Component for ControlcomputeDistancesModule
COMPONENT ControlcomputeDistancesModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  dlocXctl1 : OUT STD_LOGIC
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  descriptorXMirr1 <= descriptorXMirr1In;

  G1 : FOR p IN 0 TO 99 GENERATE
    dlocXctl1XIn(p) <= dlocXctl1;
  END GENERATE;

  G2 : FOR p IN 0 TO 99 GENERATE
    dOut(p) <= d2(p);
  END GENERATE;

  G3 : FOR p IN 0 TO 99 GENERATE
    imageReg4(p) <= imageReg4In(p);
  END GENERATE;

  pipeCdescriptor1Reg8(0) <= pipeCdescriptor11;

  G4 : FOR p IN 1 TO 99 GENERATE
    pipeCdescriptor1Reg8(p) <= pipeCdescriptor12(-1 + p);
  END GENERATE;

  G5 : ControlcomputeDistancesModule PORT MAP (clk, CE, rst, dlocXctl1));

  G6 : cellcomputeDistancesModule1 PORT MAP (clk, CE, rst, descriptorXMirr1(-1)(-1), (-1)(-1));

  G7 : cellcomputeDistancesModule2 PORT MAP (clk, CE, rst, pipeCdescriptor1Reg8(0)(99), imageReg4(0)(99), dlocXctl1XIn(0)(99), pipeCdescriptor12(0)(99), (0)(99));

END BEHAVIOURAL;

