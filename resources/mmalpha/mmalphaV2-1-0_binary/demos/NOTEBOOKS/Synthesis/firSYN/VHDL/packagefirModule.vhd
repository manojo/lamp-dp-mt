-- VHDL Model Created for "system firModule" 
-- 25/4/2010 18:24:33.286871
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE Array3To100OfInteger IS  ARRAY (3 TO 100) OF  SIGNED (15 DOWNTO 0);
  TYPE Array3To101OfInteger IS  ARRAY (3 TO 101) OF  SIGNED (15 DOWNTO 0);
  TYPE Array4To100OfBoolean IS  ARRAY (4 TO 100) OF  STD_LOGIC;
  TYPE Array4To100OfInteger IS  ARRAY (4 TO 100) OF  SIGNED (15 DOWNTO 0);
END TYPES;

