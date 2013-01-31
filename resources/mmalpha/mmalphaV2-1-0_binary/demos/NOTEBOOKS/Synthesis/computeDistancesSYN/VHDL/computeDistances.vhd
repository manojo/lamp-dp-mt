-- VHDL Model Created for "system computeDistances" 
-- 25/4/2010 18:25:37.044863
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY computeDistances IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  descriptor : IN  SIGNED (14 DOWNTO 0);
  image : IN Array0To99OfSigned14To0;
  distances : OUT  SIGNED (14 DOWNTO 0)
);
END computeDistances;

ARCHITECTURE behavioural OF computeDistances IS
    SIGNAL descriptorXMirr1 :  SIGNED (14 DOWNTO 0);
    SIGNAL imageReg4 : Array0To99OfSigned14To0;
    SIGNAL d : Array0To99OfSigned14To0;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for computeDistancesModule
COMPONENT computeDistancesModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  descriptorXMirr1In : IN  SIGNED (14 DOWNTO 0);
  imageReg4In : IN Array0To99OfSigned14To0;
  dOut : OUT Array0To99OfSigned14To0
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  descriptorXMirr1 <= descriptor;

  G1 : FOR p IN 0 TO 99 GENERATE
    imageReg4(p) <= image(p);
  END GENERATE;

  G2 : FOR p IN 0 TO 99 GENERATE
    distances(p) <= d(24,p);
  END GENERATE;

  G3 : computeDistancesModule PORT MAP (clk, CE, rst, descriptorXMirr1, imageReg4, d));

END BEHAVIOURAL;

