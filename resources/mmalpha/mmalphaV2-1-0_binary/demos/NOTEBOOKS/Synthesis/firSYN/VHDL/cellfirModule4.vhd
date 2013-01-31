-- VHDL Model Created for "system cellfirModule4" 
-- 25/4/2010 18:24:32.762831
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellfirModule4 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCx1Reg2Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCH1Reg1 : IN SIGNED (15 DOWNTO 0);
  pipeCx1 : OUT SIGNED (15 DOWNTO 0);
  pipeCH1 : OUT SIGNED (15 DOWNTO 0)
);
END cellfirModule4;

ARCHITECTURE behavioural OF cellfirModule4 IS
    SIGNAL pipeCx1Reg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCx1Reg2 <= pipeCx1Reg2Xloc; END IF;
                END IF;
    END PROCESS;

    pipeCx1 <= pipeCx1Reg2;

    pipeCH1 <= pipeCH1Reg1;

END behavioural;

