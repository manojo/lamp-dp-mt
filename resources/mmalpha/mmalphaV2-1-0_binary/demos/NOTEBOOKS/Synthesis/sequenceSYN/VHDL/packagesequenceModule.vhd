-- VHDL Model Created for "system sequenceModule" 
-- 25/4/2010 18:25:5.735703
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE Array0To20OfInteger IS  ARRAY (0 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE Array1To20OfBoolean IS  ARRAY (1 TO 20) OF  STD_LOGIC;
  TYPE Array1To20OfInteger IS  ARRAY (1 TO 20) OF  SIGNED (15 DOWNTO 0);
  TYPE Array1To21OfInteger IS  ARRAY (1 TO 21) OF  SIGNED (15 DOWNTO 0);
END TYPES;

