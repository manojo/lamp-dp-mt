-- VHDL Model Created for "system cellfirModule2" 
-- 1/8/2008 10:29:33.067807
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

library work;
use work.definition.all;


ENTITY cellfirModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx3Reg2Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCH3Reg1 : IN  SIGNED (15 DOWNTO 0);
  ser1Xctl1XIn : IN  STD_LOGIC;
  pipeCx3 : OUT  SIGNED (15 DOWNTO 0);
  pipeCH3 : OUT  SIGNED (15 DOWNTO 0);
  ser1 : OUT  SIGNED (15 DOWNTO 0)
);
END cellfirModule2;

ARCHITECTURE behavioural OF cellfirModule2 IS
    SIGNAL ser1loc3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCH3loc2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCx3loc1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCx3Reg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL ser1Reg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------
BEGIN

    ser1 <= ser1loc3;

    pipeCH3 <= pipeCH3loc2;

    pipeCx3 <= pipeCx3loc1;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCx3Reg2 <= pipeCx3Reg2Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN ser1Reg3 <= ser1loc3; END IF;
                END IF;
    END PROCESS;

    pipeCx3loc1 <= pipeCx3Reg2;

    pipeCH3loc2 <= pipeCH3Reg1;

    TSep1 <= (pipeCH3loc2 * pipeCx3loc1);

    TSep2 <= (ser1Reg3 + TSep1);

    ser1loc3 <= "0000000000000000" WHEN ser1Xctl1XIn = '1' ELSE TSep2;

END behavioural;

