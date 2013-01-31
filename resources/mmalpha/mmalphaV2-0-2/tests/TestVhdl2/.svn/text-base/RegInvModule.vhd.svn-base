-- VHDL Model Created for "system RegInvModule" 
-- 26/6/2000 22:33:21
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
PACKAGE TYPES IS
  TYPE AATYPE IS ARRAY (1 TO 3) OF std_logic;
  TYPE BBTYPE IS ARRAY (1 TO 3) OF std_logic;
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;

ENTITY RegInvModule IS
PORT(
  Ck, CE, Rst : IN STD_LOGIC;
  a : IN std_logic;
  b : OUT std_logic
);
END RegInvModule;

ARCHITECTURE behavioural OF RegInvModule IS
  SIGNAL AA : AATYPE;
  SIGNAL BB : BBTYPE;

  -- Insert missing components here!
COMPONENT RegInvCell IS
PORT(
  Ck, CE, Rst : IN STD_LOGIC;
  A1 : IN std_logic;
  B1 : OUT std_logic
);
END COMPONENT;

BEGIN

  G1 : FOR p IN 1 TO 3 GENERATE
    G2 : RegInvCell PORT MAP (ck, CE, Rst, BB(p));
  END GENERATE;

  AA(1) <= a;

  G3 : FOR p IN 2 TO 3 GENERATE
    AA(p) <= BB(-1 + p);
  END GENERATE;

  b <= BB(3);
END BEHAVIOURAL;

