-- VHDL Model Created for "system cellfirrModule1" 
-- 23/4/2010 8:38:35.131510
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellfirrModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  dXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCE17Reg3Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx35Reg4Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx37Reg5Xloc : IN SIGNED (15 DOWNTO 0);
  WXctl1PReg7Xloc : IN STD_LOGIC;
  YReg8Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCE17 : OUT SIGNED (15 DOWNTO 0);
  pipeCx35 : OUT SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0);
  WXctl1P : OUT STD_LOGIC;
  Y : OUT SIGNED (15 DOWNTO 0)
);
END cellfirrModule1;

ARCHITECTURE behavioural OF cellfirrModule1 IS
    SIGNAL Yloc5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCE17Reg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCx35Reg4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCx37Reg5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL W :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL WReg6 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL WReg9 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL WXctl1PReg7 :  STD_LOGIC;
    SIGNAL YReg8 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    Y <= Yloc5;

    WXctl1P <= WXctl1PReg7;

    pipeCx37 <= pipeCx37Reg5;

    pipeCx35 <= pipeCx35Reg4;

    pipeCE17 <= pipeCE17Reg3;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCE17Reg3 <= pipeCE17Reg3Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN pipeCx35Reg4 <= temp; temp := pipeCx35Reg4Xloc; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN pipeCx37Reg5 <= temp; temp := pipeCx37Reg5Xloc; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN WXctl1PReg7 <= WXctl1PReg7Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN YReg8 <= YReg8Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN WReg9 <= temp; temp := W; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN WReg6 <= W; END IF;
                END IF;
    END PROCESS;

    TSep1 <= (pipeCE17Reg3 * pipeCx35Reg4);

    TSep2 <= (WReg6 + TSep1);

    W <= "0000000000000000" WHEN WXctl1PReg7 = '1' ELSE TSep2;

    Yloc5 <= (YReg8 + (WReg9 * pipeCx37Reg5));

END behavioural;

