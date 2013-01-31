-- VHDL Model Created for "system cellprodVectModule1" 
-- 5/1/2009 21:53:46.556478
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY cellprodVectModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  bXMirr1 : IN  SIGNED (15 DOWNTO 0);
  aReg2 : IN  SIGNED (15 DOWNTO 0);
  CXctl1XIn : IN  STD_LOGIC;
  C : OUT  SIGNED (15 DOWNTO 0)
);
END cellprodVectModule1;

ARCHITECTURE behavioural OF cellprodVectModule1 IS
    SIGNAL Cloc1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL CReg1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep1 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL TSep2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------
   -- $MissingComponents$
BEGIN

    C <= Cloc1;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN CReg1 <= Cloc1; END IF;
                END IF;
    END PROCESS;

    TSep1 <= (aReg2 * bXMirr1);

    TSep2 <= (CReg1 + TSep1);

    Cloc1 <= "0000000000000000" WHEN CXctl1XIn = '1' ELSE TSep2;

END behavioural;

