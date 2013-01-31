-- VHDL Model Created for "system cellprodVectModule1" 
-- 25/4/2010 18:25:17.915295
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellprodVectModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  bXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCb1 : OUT SIGNED (15 DOWNTO 0)
);
END cellprodVectModule1;

ARCHITECTURE behavioural OF cellprodVectModule1 IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCb1 <= bXMirr1;

END behavioural;

