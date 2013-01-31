-- VHDL Model Created for "system sequence" 
-- 5/1/2009 21:54:14.739196
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE DBXMirr1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE QSXMirr1TYPE IS ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE MTYPE IS ARRAY (0 TO 20) OF  SIGNED (15 DOWNTO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

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
    SIGNAL DBXMirr1 : DBXMirr1TYPE;
    SIGNAL QSXMirr1 : QSXMirr1TYPE;
    SIGNAL M : MTYPE;


  -- Insert missing components here!

COMPONENT sequenceModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1In : IN DBXMirr1InTYPE;
  QSXMirr1In : IN QSXMirr1InTYPE;
  MOut : OUT MOutTYPE
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p IN 1 TO 20 GENERATE
    DBXMirr1(p) <= DB;
  END GENERATE;

  G2 : FOR p IN 1 TO 20 GENERATE
    QSXMirr1(p) <= QS;
  END GENERATE;

  res <= M(20);

  G3 : sequenceModule PORT MAP (clk, CE, Rst, DBXMirr1, QSXMirr1, M);
END BEHAVIOURAL;

