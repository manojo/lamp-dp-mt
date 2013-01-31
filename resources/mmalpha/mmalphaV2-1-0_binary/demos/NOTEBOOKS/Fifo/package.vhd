-- VHDL Model Created for "system callfifo" 
-- 3/5/2009 21:1:42.223842
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

-- USE work.types.all;

PACKAGE TYPES IS
  TYPE RinTYPE IS ARRAY (0 TO Infinity) OF  SIGNED (15 DOWNTO 0);
  TYPE TinTYPE IS ARRAY (0 TO Infinity) OF  STD_LOGIC;
  TYPE RoutTYPE IS ARRAY (0 TO Infinity) OF  SIGNED (15 DOWNTO 0);
  TYPE ToutTYPE IS ARRAY (0 TO Infinity) OF  STD_LOGIC;
END TYPES;
USE work.types.all;

