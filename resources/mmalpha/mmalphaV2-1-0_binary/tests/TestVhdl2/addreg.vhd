-- VHDL Model Created for "system addreg" 
-- 23/4/2010 14:36:38.181676
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY addreg IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN SIGNED (15 DOWNTO 0);
  y : IN SIGNED (15 DOWNTO 0);
  z : OUT SIGNED (15 DOWNTO 0)
);
END addreg;

ARCHITECTURE behavioural OF addreg IS
    SIGNAL X1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL Y1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN X1 <= x; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN Y1 <= y; END IF;
                END IF;
    END PROCESS;

    z <= (X1 + Y1);

END behavioural;

