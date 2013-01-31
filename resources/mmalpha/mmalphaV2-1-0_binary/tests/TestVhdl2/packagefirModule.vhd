-- VHDL Model Created for "system firModule" 
-- 23/4/2010 14:36:40.441920
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE Array0To5OfInteger IS  ARRAY (0 TO 5) OF  SIGNED (15 DOWNTO 0);
  TYPE Array1To6OfInteger IS  ARRAY (1 TO 6) OF  SIGNED (15 DOWNTO 0);
  TYPE Array2To5OfBoolean IS  ARRAY (2 TO 5) OF  STD_LOGIC;
  TYPE Array2To5OfInteger IS  ARRAY (2 TO 5) OF  SIGNED (15 DOWNTO 0);
  TYPE Array2To6OfBoolean IS  ARRAY (2 TO 6) OF  STD_LOGIC;
END TYPES;

