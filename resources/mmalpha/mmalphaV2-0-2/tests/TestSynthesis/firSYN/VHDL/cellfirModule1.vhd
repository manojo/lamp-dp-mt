-- VHDL Model Created for "system cellfirModule1" 
-- 5/1/2009 21:53:24.121952
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY cellfirModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HXMirr1 : IN  SIGNED (15 DOWNTO 0);
  xXMirr1 : IN  SIGNED (15 DOWNTO 0);
  ser1Xctl1XIn : IN  STD_LOGIC;
  ser1 : OUT  SIGNED (15 DOWNTO 0)
);
END cellfirModule1;

ARCHITECTURE behavioural OF cellfirModule1 IS
    SIGNAL ser1loc1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL ser1Reg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------
   -- $MissingComponents$
BEGIN

    ser1 <= ser1loc1;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN ser1Reg1 <= ser1loc1; END IF;
                END IF;
    END PROCESS;

    TSep1 <= (HXMirr1 * xXMirr1);

    TSep2 <= (ser1Reg1 + TSep1);

    ser1loc1 <= "0000000000000000" WHEN ser1Xctl1XIn = '1' ELSE TSep2;

END behavioural;

