-- VHDL Model Created for "system loadregister" 
-- 15/7/2003 0:34:27
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY loadregister IS
PORT(
  Ck: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ctl : IN  STD_LOGIC;
  ValInit : IN  INTEGER RANGE -32768 TO 32767;
  result : OUT  INTEGER RANGE -32768 TO 32767
);
END loadregister;

ARCHITECTURE behavioural OF loadregister IS
    SIGNAL s :  INTEGER RANGE -32768 TO 32767 := 0;
    SIGNAL z :  INTEGER RANGE -32768 TO 32767 := 0;


  -- Insert missing components here!---------
BEGIN

    result <= z;

    PROCESS(ck) BEGIN IF (ck = '1' AND ck'EVENT) THEN
      IF CE='1' THEN z <= s; END IF;
                END IF;
    END PROCESS;

    s <= ValInit WHEN ctl = '1' ELSE 0;

END behavioural;

