-- VHDL Model Created for "system cellsequenceModule1" 
-- 5/1/2009 21:54:13.948986
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY cellsequenceModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  M : OUT  SIGNED (15 DOWNTO 0)
);
END cellsequenceModule1;

ARCHITECTURE behavioural OF cellsequenceModule1 IS


  -- Insert missing components here!---------
   -- $MissingComponents$
BEGIN

    M <= "0000000000000000";

END behavioural;

