-- VHDL Model Created for "system cell1" 
-- 26/12/2007 17:37:46.101317
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library work;
use work.definition.all;


ENTITY cell1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  A : IN  SIGNED (15 DOWNTO 0);
  S : OUT  SIGNED (15 DOWNTO 0)
);
END cell1;

ARCHITECTURE behavioural OF cell1 IS
    SIGNAL a :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL b :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL e :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL c :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL d :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------
BEGIN

    a <= ("0000000000000000" + A);

    b <= a;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN c <= b; END IF;
                END IF;
    END PROCESS;

    d <= ((a + b) - c);

    e <=  - (a );

    S <= c;

END behavioural;

