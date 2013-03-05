-- VHDL Model Created for "system cellmatmultModule2" 
-- 29/12/2008 10:40:28.980524
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY cellmatmultModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  CReg1Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCa5Reg2Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PReg4Xloc : IN  STD_LOGIC;
  TSep1 : IN  SIGNED (15 DOWNTO 0);
  C : OUT  SIGNED (15 DOWNTO 0);
  pipeCa5 : OUT  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1P : OUT  STD_LOGIC
);
END cellmatmultModule2;

ARCHITECTURE behavioural OF cellmatmultModule2 IS
    SIGNAL CReg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCa5Reg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCb5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCb5Reg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCb5Xctl1PReg4 :  STD_LOGIC;


  -- Insert missing components here!---------
   -- $MissingComponents$
BEGIN

    pipeCb5Xctl1P <= pipeCb5Xctl1PReg4;

    pipeCa5 <= pipeCa5Reg2;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN CReg1 <= CReg1Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCa5Reg2 <= pipeCa5Reg2Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCb5Xctl1PReg4 <= pipeCb5Xctl1PReg4Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCb5Reg3 <= pipeCb5; END IF;
                END IF;
    END PROCESS;

    pipeCb5 <= TSep1 WHEN pipeCb5Xctl1PReg4 = '1' ELSE pipeCb5Reg3;

    C <= (CReg1 + (pipeCa5Reg2 * pipeCb5));

END behavioural;
