-- VHDL Model Created for "system cell2e1" 
-- 26/12/2007 17:38:55.871485
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library work;
use work.definition.all;


ENTITY cell2e1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  c : IN  STD_LOGIC;
  B : IN  SIGNED (15 DOWNTO 0);
  D : OUT  SIGNED (15 DOWNTO 0)
);
END cell2e1;

ARCHITECTURE behavioural OF cell2e1 IS
    SIGNAL Cloc :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------
BEGIN

    Cloc <= "0000000000000000" WHEN B = '1' ELSE (B * B);

END behavioural;

