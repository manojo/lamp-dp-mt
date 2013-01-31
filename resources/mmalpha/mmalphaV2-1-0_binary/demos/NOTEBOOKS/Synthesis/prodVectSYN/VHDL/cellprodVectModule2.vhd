-- VHDL Model Created for "system cellprodVectModule2" 
-- 25/4/2010 18:25:17.938407
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellprodVectModule2 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCb1Reg3 : IN SIGNED (15 DOWNTO 0);
  aReg2 : IN SIGNED (15 DOWNTO 0);
  CXctl1XIn : IN STD_LOGIC;
  pipeCb1 : OUT SIGNED (15 DOWNTO 0);
  C : OUT SIGNED (15 DOWNTO 0)
);
END cellprodVectModule2;

ARCHITECTURE behavioural OF cellprodVectModule2 IS
    SIGNAL Cloc2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL CReg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    C <= Cloc2;

    pipeCb1 <= pipeCb1Reg3;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN CReg1 <= Cloc2; END IF;
                END IF;
    END PROCESS;

    TSep1 <= (aReg2 * pipeCb1Reg3);

    TSep2 <= (CReg1 + TSep1);

    Cloc2 <= "0000000000000000" WHEN CXctl1XIn = '1' ELSE TSep2;

END behavioural;

