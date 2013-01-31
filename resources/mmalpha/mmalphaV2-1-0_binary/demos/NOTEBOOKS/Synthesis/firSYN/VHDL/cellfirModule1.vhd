-- VHDL Model Created for "system cellfirModule1" 
-- 25/4/2010 18:24:32.724861
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellfirModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1 : IN SIGNED (15 DOWNTO 0);
  xXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCx1 : OUT SIGNED (15 DOWNTO 0);
  pipeCH1 : OUT SIGNED (15 DOWNTO 0)
);
END cellfirModule1;

ARCHITECTURE behavioural OF cellfirModule1 IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCx1 <= xXMirr1;

    pipeCH1 <= HXMirr1;

END behavioural;

