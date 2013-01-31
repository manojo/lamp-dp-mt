-- VHDL Model Created for "system cellsequenceModule4" 
-- 23/4/2010 8:53:8.504732
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellsequenceModule4 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  pipeCDB9 : OUT SIGNED (15 DOWNTO 0)
);
END cellsequenceModule4;

ARCHITECTURE behavioural OF cellsequenceModule4 IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCDB9 <= DBXMirr1;

    M <= "0000000000000000";

END behavioural;

