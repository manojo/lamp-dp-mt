-- VHDL Model Created for "system cellsequenceModule2" 
-- 23/4/2010 8:53:8.434507
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellsequenceModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  expr1 : IN SIGNED (15 DOWNTO 0);
  MXctl2PReg5Xloc : IN STD_LOGIC;
  pipeCDB9Reg6Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCQS9Xctl1PReg8Xloc : IN STD_LOGIC;
  TSep3 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  MXctl2P : OUT STD_LOGIC;
  pipeCDB9 : OUT SIGNED (15 DOWNTO 0);
  pipeCQS9Xctl1P : OUT STD_LOGIC
);
END cellsequenceModule2;

ARCHITECTURE behavioural OF cellsequenceModule2 IS
    SIGNAL Mloc1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MatchQ :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MatchQReg4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MXctl2PReg5 :  STD_LOGIC;
    SIGNAL pipeCDB9Reg6 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCQS9 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCQS9Reg7 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCQS9Xctl1PReg8 :  STD_LOGIC;
    SIGNAL TSep1 :  STD_LOGIC;
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep6 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep7 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep8 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep9 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCQS9Xctl1P <= pipeCQS9Xctl1PReg8;

    pipeCDB9 <= pipeCDB9Reg6;

    MXctl2P <= MXctl2PReg5;

    M <= Mloc1;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MReg2 <= expr1; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN MReg3 <= temp; temp := expr1; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MXctl2PReg5 <= MXctl2PReg5Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCDB9Reg6 <= pipeCDB9Reg6Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCQS9Xctl1PReg8 <= pipeCQS9Xctl1PReg8Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCQS9Reg7 <= pipeCQS9; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MatchQReg4 <= MatchQ; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MReg1 <= Mloc1; END IF;
                END IF;
    END PROCESS;

    pipeCQS9 <= TSep3 WHEN pipeCQS9Xctl1PReg8 = '1' ELSE pipeCQS9Reg7;

    TSep4 <= (MReg1 - "0000000000001000");

    TSep5 <= "0000000000000000" WHEN "0000000000000000" > TSep4 ELSE TSep4;

    TSep6 <= (MReg2 - "0000000000001000");

    TSep7 <= (MReg3 + MatchQReg4);

    TSep8 <= TSep6 WHEN TSep6 > TSep7 ELSE TSep7;

    TSep9 <= TSep5 WHEN TSep5 > TSep8 ELSE TSep8;

    Mloc1 <= "0000000000000000" WHEN MXctl2PReg5 = '1' ELSE TSep9;

    TSep1 <=  '1' WHEN pipeCQS9 = pipeCDB9Reg6 ELSE '0';

    TSep2 <= "1111111111110100";

    MatchQ <= "0000000000001111" WHEN TSep1 = '1' ELSE TSep2;

END behavioural;

