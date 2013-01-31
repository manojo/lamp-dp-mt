-- VHDL Model Created for "system cellfirrModule7" 
-- 23/4/2010 8:38:35.246724
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellfirrModule7 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  xXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0)
);
END cellfirrModule7;

ARCHITECTURE behavioural OF cellfirrModule7 IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCx37 <= xXMirr1;

END behavioural;

