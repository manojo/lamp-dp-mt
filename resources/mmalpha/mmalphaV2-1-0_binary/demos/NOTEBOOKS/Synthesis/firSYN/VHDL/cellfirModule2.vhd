-- VHDL Model Created for "system cellfirModule2" 
-- 25/4/2010 18:24:32.751822
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellfirModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx1Reg2Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCH1Reg1 : IN SIGNED (15 DOWNTO 0);
  ser1Xctl1XIn : IN STD_LOGIC;
  pipeCx1 : OUT SIGNED (15 DOWNTO 0);
  pipeCH1 : OUT SIGNED (15 DOWNTO 0);
  ser1 : OUT SIGNED (15 DOWNTO 0)
);
END cellfirModule2;

ARCHITECTURE behavioural OF cellfirModule2 IS
    SIGNAL ser1loc3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCx1Reg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL ser1Reg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    ser1 <= ser1loc3;

    pipeCH1 <= pipeCH1Reg1;

    pipeCx1 <= pipeCx1Reg2;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCx1Reg2 <= pipeCx1Reg2Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN ser1Reg3 <= ser1loc3; END IF;
                END IF;
    END PROCESS;

    TSep1 <= (pipeCH1Reg1 * pipeCx1Reg2);

    TSep2 <= (ser1Reg3 + TSep1);

    ser1loc3 <= "0000000000000000" WHEN ser1Xctl1XIn = '1' ELSE TSep2;

END behavioural;

