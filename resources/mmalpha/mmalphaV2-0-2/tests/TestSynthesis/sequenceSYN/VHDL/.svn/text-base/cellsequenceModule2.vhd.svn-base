-- VHDL Model Created for "system cellsequenceModule2" 
-- 5/1/2009 21:54:14.008492
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY cellsequenceModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  DBXMirr1 : IN  SIGNED (15 DOWNTO 0);
  QSXMirr1 : IN  SIGNED (15 DOWNTO 0);
  MReg2Xloc : IN  SIGNED (15 DOWNTO 0);
  MXctl2XIn : IN  STD_LOGIC;
  M : OUT  SIGNED (15 DOWNTO 0)
);
END cellsequenceModule2;

ARCHITECTURE behavioural OF cellsequenceModule2 IS
    SIGNAL Mloc1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MatchQ :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MatchQReg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL MReg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  STD_LOGIC;
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep6 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------
   -- $MissingComponents$
BEGIN

    M <= Mloc1;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN MReg2 <= MReg2Xloc; END IF;
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

    TSep3 <= (MReg1 - "0000000000001000");

    TSep4 <= (MReg2 + MatchQReg3);

    TSep5 <= TSep3 WHEN TSep3 > TSep4 ELSE TSep4;

    TSep6 <= "0000000000000000" WHEN "0000000000000000" > TSep5 ELSE TSep5;

    Mloc1 <= "0000000000000000" WHEN MXctl2XIn = '1' ELSE TSep6;

    TSep1 <=  '1' WHEN QSXMirr1 = DBXMirr1 ELSE '0';

    TSep2 <= "1111111111110100";

    MatchQ <= "0000000000001111" WHEN TSep1 = '1' ELSE TSep2;

END behavioural;

