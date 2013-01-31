-- VHDL Model Created for "system sequenceModule" 
-- 23/4/2010 8:53:9.428168
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE Array0To10OfInteger IS  ARRAY (0 TO 10) OF  SIGNED (15 DOWNTO 0);
  TYPE Array1To10OfInteger IS  ARRAY (1 TO 10) OF  SIGNED (15 DOWNTO 0);
  TYPE Array1To11OfInteger IS  ARRAY (1 TO 11) OF  SIGNED (15 DOWNTO 0);
  TYPE Array2To10OfBoolean IS  ARRAY (2 TO 10) OF  STD_LOGIC;
  TYPE Array2To10OfInteger IS  ARRAY (2 TO 10) OF  SIGNED (15 DOWNTO 0);
  TYPE Array2To11OfBoolean IS  ARRAY (2 TO 11) OF  STD_LOGIC;
END TYPES;

