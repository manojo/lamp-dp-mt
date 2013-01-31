-- VHDL Model Created for "system cellsequenceModule2" 
-- 25/4/2010 18:25:5.247847
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
  MReg2Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCDB1Reg4 : IN SIGNED (15 DOWNTO 0);
  MXctl2XIn : IN STD_LOGIC;
  pipeCQS1Xctl1XIn : IN STD_LOGIC;
  TSep3 : IN SIGNED (15 DOWNTO 0);
  M : OUT SIGNED (15 DOWNTO 0);
  pipeCDB1 : OUT SIGNED (15 DOWNTO 0)
);
END cellsequenceModule2;

ARCHITECTURE behavioural OF cellsequenceModule2 IS
    SIGNAL Mloc1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MatchQ :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MatchQReg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCQS1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCQS1Reg5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  STD_LOGIC;
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep6 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep7 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCDB1 <= pipeCDB1Reg4;

    M <= Mloc1;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MReg2 <= MReg2Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN pipeCQS1Reg5 <= pipeCQS1; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MatchQReg3 <= MatchQ; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MReg1 <= Mloc1; END IF;
                END IF;
    END PROCESS;

    pipeCQS1 <= TSep3 WHEN pipeCQS1Xctl1XIn = '1' ELSE pipeCQS1Reg5;

    TSep4 <= (MReg1 - "0000000000001000");

    TSep5 <= (MReg2 + MatchQReg3);

    TSep6 <= TSep4 WHEN TSep4 > TSep5 ELSE TSep5;

    TSep7 <= "0000000000000000" WHEN "0000000000000000" > TSep6 ELSE TSep6;

    Mloc1 <= "0000000000000000" WHEN MXctl2XIn = '1' ELSE TSep7;

    TSep1 <=  '1' WHEN pipeCQS1 = pipeCDB1Reg4 ELSE '0';

    TSep2 <= "1111111111110100";

    MatchQ <= "0000000000001111" WHEN TSep1 = '1' ELSE TSep2;

END behavioural;

