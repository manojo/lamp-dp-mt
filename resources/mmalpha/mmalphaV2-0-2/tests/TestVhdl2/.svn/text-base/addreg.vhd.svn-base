-- VHDL Model Created for "system addreg" 
-- 15/7/2003 0:34:26
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY addreg IS
PORT(
  Ck: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN  SIGNED (15 DOWNTO 0);
  y : IN  SIGNED (15 DOWNTO 0);
  z : OUT  SIGNED (15 DOWNTO 0)
);
END addreg;

ARCHITECTURE behavioural OF addreg IS
    SIGNAL X1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL Y1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


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

    z <= (X1 + Y1);

END behavioural;

