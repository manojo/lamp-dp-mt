-- VHDL Model Created for "system adder" 
-- 23/4/2010 14:36:38.082194
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY adder IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN SIGNED (15 DOWNTO 0);
  y : IN SIGNED (15 DOWNTO 0);
  z : OUT SIGNED (15 DOWNTO 0)
);
END adder;

ARCHITECTURE behavioural OF adder IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    z <= (x + y);

END behavioural;

