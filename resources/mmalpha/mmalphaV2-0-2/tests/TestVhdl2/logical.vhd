-- VHDL Model Created for "system logical" 
-- 15/7/2003 0:34:43
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY logical IS
PORT(
  Ck: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN  SIGNED (15 DOWNTO 0);
  y : IN  SIGNED (15 DOWNTO 0);
  z : OUT  STD_LOGIC
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
BEGIN

    PROCESS(ck) BEGIN IF (ck = '1' AND ck'EVENT) THEN
      IF CE='1' THEN X1 <= x; END IF;
                END IF;
    END PROCESS;

    PROCESS(ck) BEGIN IF (ck = '1' AND ck'EVENT) THEN
      IF CE='1' THEN Y1 <= y; END IF;
                END IF;
    END PROCESS;

    leq <=  '0' WHEN X1 = Y1;

    lne <=  '0' WHEN X1 = Y1;

    lle <=  '0' WHEN X1 <= Y1;

    llt <=  '0' WHEN X1 < Y1;

    lge <=  '0' WHEN X1 >= Y1;

    lgt <=  '0' WHEN X1 <= Y1;

    z <= (((((leq AND lne) AND lle) AND llt) AND lge) AND lgt);

END behavioural;

