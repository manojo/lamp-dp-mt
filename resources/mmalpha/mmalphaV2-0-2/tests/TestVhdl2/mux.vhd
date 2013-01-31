-- VHDL Model Created for "system mux" 
-- 15/7/2003 0:34:27
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY mux IS
PORT(
  Ck: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ctl : IN  STD_LOGIC;
  input : IN  SIGNED (15 DOWNTO 0);
  output : OUT  SIGNED (15 DOWNTO 0)
);
END mux;

ARCHITECTURE behavioural OF mux IS


  -- Insert missing components here!---------
BEGIN

    output <= input WHEN ctl = '1' ELSE "0000000000000000";

END behavioural;

