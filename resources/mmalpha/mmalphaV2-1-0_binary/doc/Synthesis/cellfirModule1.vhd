-- VHDL Model Created for "system cellfirModule1" 
-- 1/8/2008 10:29:33.014582
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library work;
use work.definition.all;


ENTITY cellfirModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1 : IN  SIGNED (15 DOWNTO 0);
  xXMirr1 : IN  SIGNED (15 DOWNTO 0);
  pipeCx3 : OUT  SIGNED (15 DOWNTO 0);
  pipeCH3 : OUT  SIGNED (15 DOWNTO 0)
);
END cellfirModule1;

ARCHITECTURE behavioural OF cellfirModule1 IS


  -- Insert missing components here!---------
BEGIN

    pipeCx3 <= xXMirr1;

    pipeCH3 <= HXMirr1;

END behavioural;

