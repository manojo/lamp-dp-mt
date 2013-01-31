-- VHDL Model Created for "system mux" 
-- 23/4/2010 14:36:38.504533
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY mux IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ctl : IN STD_LOGIC;
  input : IN SIGNED (15 DOWNTO 0);
  output : OUT SIGNED (15 DOWNTO 0)
);
END mux;

ARCHITECTURE behavioural OF mux IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    output <= input WHEN ctl = '1' ELSE "0000000000000000";

END behavioural;

