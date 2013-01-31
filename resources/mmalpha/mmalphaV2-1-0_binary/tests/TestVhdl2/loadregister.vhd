-- VHDL Model Created for "system loadregister" 
-- 23/4/2010 14:36:38.590435
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY loadregister IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ctl : IN STD_LOGIC;
  ValInit : IN SIGNED (15 DOWNTO 0);
  result : OUT SIGNED (15 DOWNTO 0)
);
END loadregister;

ARCHITECTURE behavioural OF loadregister IS
    SIGNAL s :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL z :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    result <= z;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN z <= s; END IF;
                END IF;
    END PROCESS;

    s <= ValInit WHEN ctl = '1' ELSE "0000000000000000";

END behavioural;

