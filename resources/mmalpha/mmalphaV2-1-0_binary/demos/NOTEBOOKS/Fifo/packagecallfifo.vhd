-- VHDL Model Created for "system callfifo" 
-- 23/4/2010 14:23:33.019508
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

PACKAGE TYPES IS
  TYPE Array0ToInfinityOfBoolean IS  ARRAY (0 TO Infinity) OF  STD_LOGIC;
  TYPE Array0ToInfinityOfInteger IS  ARRAY (0 TO Infinity) OF  SIGNED (15 DOWNTO 0);
END TYPES;

