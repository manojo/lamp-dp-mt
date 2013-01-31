-- VHDL Model Created for "system sequenceModule" 
-- 5/1/2009 21:54:14.540817
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE DBXMirr1InTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE QSXMirr1InTYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE MOutTYPE IS ARRAY (0 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE M1TYPE IS ARRAY (0 TO 0) OF  SIGNED (15 DOWNTO 0);
  TYPE MReg2XlocTYPE IS ARRAY (1 TO 21) OF  SIGNED (15 DOWNTO 0);
  TYPE DBXMirr1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE QSXMirr1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE M2TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE MXctl2XInTYPE IS ARRAY (1 TO 20) OF  STD_LOGIC;
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY sequenceModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1In : IN DBXMirr1InTYPE;
  QSXMirr1In : IN QSXMirr1InTYPE;
  MOut : OUT MOutTYPE
);
END sequenceModule;

ARCHITECTURE behavioural OF sequenceModule IS
    SIGNAL MXctl2 :  STD_LOGIC;
    SIGNAL M1 : M1TYPE;
    SIGNAL MReg2Xloc : MReg2XlocTYPE;
    SIGNAL DBXMirr1 : DBXMirr1TYPE;
    SIGNAL QSXMirr1 : QSXMirr1TYPE;
    SIGNAL M2 : M2TYPE;
    SIGNAL MXctl2XIn : MXctl2XInTYPE;


  -- Insert missing components here!

COMPONENT ControlsequenceModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  MXctl2 : OUT STD_LOGIC
);
END COMPONENT;
COMPONENT cellsequenceModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  M : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;
COMPONENT cellsequenceModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1 : IN  SIGNED (15 DOWNTO 0);
  QSXMirr1 : IN  SIGNED (15 DOWNTO 0);
  MReg2Xloc : IN  SIGNED (15 DOWNTO 0);
  MXctl2XIn : IN  STD_LOGIC;
  M : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p IN 1 TO 20 GENERATE
    DBXMirr1(p) <= DBXMirr1In(p);
  END GENERATE;

  MOut(0) <= M1(0);

  G2 : FOR p IN 1 TO 20 GENERATE
    MOut(p) <= M2(p);
  END GENERATE;

  MReg2Xloc(1) <= M1(0);

  G3 : FOR p IN 2 TO 21 GENERATE
    MReg2Xloc(p) <= M2(-1 + p);
  END GENERATE;

  G4 : FOR p IN 1 TO 20 GENERATE
    MXctl2XIn(p) <= MXctl2;
  END GENERATE;

  G5 : FOR p IN 1 TO 20 GENERATE
    QSXMirr1(p) <= QSXMirr1In(p);
  END GENERATE;

  G6 : ControlsequenceModule PORT MAP (clk, CE, Rst, MXctl2);

    G7 : cellsequenceModule1 PORT MAP (clk, CE, Rst, M1(0));

  G8 : FOR p IN 1 TO 20 GENERATE
    G9 : cellsequenceModule2 PORT MAP (clk, CE, Rst, DBXMirr1(p), QSXMirr1(p), MReg2Xloc(p), MXctl2XIn(p), M2(p));
  END GENERATE;
END BEHAVIOURAL;

