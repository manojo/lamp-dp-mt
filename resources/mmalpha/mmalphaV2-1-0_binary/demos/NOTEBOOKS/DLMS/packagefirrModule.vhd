-- VHDL Model Created for "system firrModule" 
-- 23/4/2010 8:38:36.891153
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE Array0To3OfInteger IS  ARRAY (0 TO 3) OF  SIGNED (15 DOWNTO 0);
  TYPE Array-1To2OfInteger IS  ARRAY (-1 TO 2) OF  SIGNED (15 DOWNTO 0);
  TYPE Array1To3OfBoolean IS  ARRAY (1 TO 3) OF  STD_LOGIC;
  TYPE Array-1To3OfInteger IS  ARRAY (-1 TO 3) OF  SIGNED (15 DOWNTO 0);
END TYPES;

