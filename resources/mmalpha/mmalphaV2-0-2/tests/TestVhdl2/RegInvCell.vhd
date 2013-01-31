-- VHDL Model Created for "system RegInvCell" 
-- 26/6/2000 22:33:20
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;

ENTITY RegInvCell IS
PORT(
  Ck, CE, Rst : IN STD_LOGIC;
  A1 : IN std_logic;
  B1 : OUT std_logic
);
END RegInvCell;

ARCHITECTURE behavioural OF RegInvCell IS
    SIGNAL A2 :  STD_LOGIC;

BEGIN

    PROCESS(ck) BEGIN IF (ck = '1' AND ck'EVENT) THEN
                  IF CE='1' THEN A2 <= A1; END IF;
                END IF;
    END PROCESS;

    B1 <= NOT A2;

END behavioural;

