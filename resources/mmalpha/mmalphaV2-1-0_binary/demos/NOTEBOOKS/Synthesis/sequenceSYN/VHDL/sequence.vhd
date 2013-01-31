-- VHDL Model Created for "system sequence" 
-- 25/4/2010 18:25:5.873039
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY sequence IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  QS : IN  SIGNED (15 DOWNTO 0);
  DB : IN  SIGNED (15 DOWNTO 0);
  res : OUT  SIGNED (15 DOWNTO 0)
);
END sequence;

ARCHITECTURE behavioural OF sequence IS
    SIGNAL DBXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL TSep3 : Array1To20OfInteger;
    SIGNAL M : Array0To20OfInteger;


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for sequenceModule
COMPONENT sequenceModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1In : IN  SIGNED (15 DOWNTO 0);
  TSep3In : IN Array1To20OfInteger;
  MOut : OUT Array0To20OfInteger
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  DBXMirr1 <= DB;

  G1 : FOR p IN 1 TO 20 GENERATE
    TSep3(p) <= QS;
  END GENERATE;

  res <= M(20);

  G2 : sequenceModule PORT MAP (clk, CE, rst, DBXMirr1, TSep3, M));

END BEHAVIOURAL;

