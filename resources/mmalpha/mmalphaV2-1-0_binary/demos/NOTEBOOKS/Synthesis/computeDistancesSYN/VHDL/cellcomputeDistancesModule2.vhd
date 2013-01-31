-- VHDL Model Created for "system cellcomputeDistancesModule2" 
-- 25/4/2010 18:25:36.597485
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellcomputeDistancesModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCdescriptor1Reg8 : IN SIGNED (14 DOWNTO 0);
  imageReg4 : IN SIGNED (14 DOWNTO 0);
  dlocXctl1XIn : IN STD_LOGIC;
  pipeCdescriptor1 : OUT SIGNED (14 DOWNTO 0);
  d : OUT SIGNED (14 DOWNTO 0)
);
END cellcomputeDistancesModule2;

ARCHITECTURE behavioural OF cellcomputeDistancesModule2 IS
    SIGNAL absValue :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL absValueReg7 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL diff :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL diffReg1 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL diffReg2 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL diffReg3 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL dloc :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL dlocReg6 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL tempReg5 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL TSep1 :  STD_LOGIC;
    SIGNAL TSep2 :  SIGNED (14 DOWNTO 0) := "000000000000000";
    SIGNAL TSep3 :  SIGNED (14 DOWNTO 0) := "000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    pipeCdescriptor1 <= pipeCdescriptor1Reg8;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN absValueReg7 <= absValue; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN dlocReg6 <= dloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN tempReg5 <= pipeCdescriptor1Reg8; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN diffReg3 <= diff; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN diffReg2 <= diff; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN diffReg1 <= diff; END IF;
                END IF;
    END PROCESS;

    diff <= (imageReg4 - tempReg5);

    TSep1 <=  '1' WHEN diffReg1 > 0 ELSE '0';

    TSep2 <=  - (diffReg3 );

    absValue <= diffReg2 WHEN TSep1 = '1' ELSE TSep2;

    TSep3 <= (dlocReg6 + absValueReg7);

    dloc <= "000000000000000" WHEN dlocXctl1XIn = '1' ELSE TSep3;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN d <= dloc; END IF;
                END IF;
    END PROCESS;

END behavioural;

