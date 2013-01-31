-- VHDL Model Created for "system callfifo" 
-- 23/4/2010 14:23:33.019508
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY callfifo IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  busin : IN  SIGNED (15 DOWNTO 0);
  op1 : IN  STD_LOGIC;
  op2 : IN  STD_LOGIC;
  full : OUT  STD_LOGIC;
  empty : OUT  STD_LOGIC;
  wordout : OUT  SIGNED (15 DOWNTO 0)
);
END callfifo;

ARCHITECTURE behavioural OF callfifo IS
    SIGNAL Rin : Array0ToInfinityOfInteger;
    SIGNAL Tin : Array0ToInfinityOfBoolean;
    SIGNAL Rout : Array0ToInfinityOfInteger;
    SIGNAL Tout : Array0ToInfinityOfBoolean;


  -- Insert missing components here!



-- Components for calls to external functions
***** Warning: component fifo.component not found
Do not forget to add it in the directory.

  -- $MissingComponents$


BEGIN

  G1 : FOR p IN 0 TO Infinity GENERATE
    wordout(p) <= Rout(128,p);
  END GENERATE;

  G2 : FOR p IN 0 TO Infinity GENERATE
    full(p) <= Tout(0,p);
  END GENERATE;

  G3 : FOR p IN 0 TO Infinity GENERATE
    empty(p) <= Tout(128,p);
  END GENERATE;

END BEHAVIOURAL;

