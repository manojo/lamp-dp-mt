-- VHDL Model Created for "system logical" 
-- 23/4/2010 14:36:45.065418
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY logical IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN SIGNED (15 DOWNTO 0);
  y : IN SIGNED (15 DOWNTO 0);
  z : OUT STD_LOGIC
);
END logical;

ARCHITECTURE behavioural OF logical IS
    SIGNAL X1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL Y1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL leq :  STD_LOGIC;
    SIGNAL lne :  STD_LOGIC;
    SIGNAL lle :  STD_LOGIC;
    SIGNAL llt :  STD_LOGIC;
    SIGNAL lge :  STD_LOGIC;
    SIGNAL lgt :  STD_LOGIC;


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

    leq <=  '1' WHEN X1 = Y1 ELSE '0';

    lne <=  '1' WHEN X1 = Y1 ELSE '0';

    lle <=  '1' WHEN X1 <= Y1 ELSE '0';

    llt <=  '1' WHEN X1 < Y1 ELSE '0';

    lge <=  '1' WHEN X1 >= Y1 ELSE '0';

    lgt <=  '1' WHEN X1 <= Y1 ELSE '0';

    z <= (((((leq AND lne) AND lle) AND llt) AND lge) AND lgt);

END behavioural;

