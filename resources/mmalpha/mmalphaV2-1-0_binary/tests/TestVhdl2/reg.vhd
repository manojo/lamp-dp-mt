-- VHDL Model Created for "system reg" 
-- 23/4/2010 14:36:38.111776
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY reg IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN SIGNED (15 DOWNTO 0);
  z : OUT SIGNED (15 DOWNTO 0)
);
END reg;

ARCHITECTURE behavioural OF reg IS


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN z <= x; END IF;
                END IF;
    END PROCESS;

END behavioural;

