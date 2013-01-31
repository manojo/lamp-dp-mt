-- VHDL Model Created for "system cellcomputeDistancesModule1" 
-- 25/4/2010 18:25:36.557534
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellcomputeDistancesModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  descriptorXMirr1 : IN SIGNED (14 DOWNTO 0);
  pipeCdescriptor1 : OUT SIGNED (14 DOWNTO 0)
);
END cellcomputeDistancesModule1;

ARCHITECTURE behavioural OF cellcomputeDistancesModule1 IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCdescriptor1 <= descriptorXMirr1;

END behavioural;

