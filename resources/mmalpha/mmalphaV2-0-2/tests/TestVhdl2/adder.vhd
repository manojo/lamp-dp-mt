-- VHDL Model Created for "system adder" 
-- 15/7/2003 0:34:25
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY adder IS
PORT(
  Ck: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  x : IN  INTEGER RANGE -32768 TO 32767;
  y : IN  INTEGER RANGE -32768 TO 32767;
  z : OUT  INTEGER RANGE -32768 TO 32767
);
END adder;

ARCHITECTURE behavioural OF adder IS


  -- Insert missing components here!---------
BEGIN

    z <= (x + y);

END behavioural;

