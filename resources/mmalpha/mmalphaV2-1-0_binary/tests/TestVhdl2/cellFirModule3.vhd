-- VHDL Model Created for "system cellFirModule3" 
-- 23/4/2010 14:36:44.863272
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellFirModule3 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  Y_reg7loc : IN SIGNED (15 DOWNTO 0);
  xPipe_reg5loc : IN SIGNED (15 DOWNTO 0);
  HPipeES_reg4loc : IN SIGNED (15 DOWNTO 0);
  xPipeES_reg3loc : IN SIGNED (15 DOWNTO 0);
  xPipe_ctl2P_reg2loc : IN STD_LOGIC;
  HPipe_ctl1P_reg1loc : IN STD_LOGIC;
  Y : OUT SIGNED (15 DOWNTO 0);
  xPipe : OUT SIGNED (15 DOWNTO 0);
  HPipeES : OUT SIGNED (15 DOWNTO 0);
  xPipeES : OUT SIGNED (15 DOWNTO 0);
  xPipe_ctl2P : OUT STD_LOGIC;
  HPipe_ctl1P : OUT STD_LOGIC
);
END cellFirModule3;

ARCHITECTURE behavioural OF cellFirModule3 IS
    SIGNAL HPipe_ctl1Ploc6 :  STD_LOGIC;
    SIGNAL xPipe_ctl2Ploc5 :  STD_LOGIC;
    SIGNAL xPipeESloc4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL HPipeESloc3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL xPipeloc2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL HPipe :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL HPipe_ctl1 :  STD_LOGIC;
    SIGNAL HPipe_ctl1P_reg1 :  STD_LOGIC;
    SIGNAL HPipeES_reg4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL HPipe_reg6 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL HPipe_reg8 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL xPipe_ctl2 :  STD_LOGIC;
    SIGNAL xPipe_ctl2P_reg2 :  STD_LOGIC;
    SIGNAL xPipeES_reg3 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL xPipe_reg5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL xPipe_reg9 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL Y_reg7 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    HPipe_ctl1P <= HPipe_ctl1Ploc6;

    xPipe_ctl2P <= xPipe_ctl2Ploc5;

    xPipeES <= xPipeESloc4;

    HPipeES <= HPipeESloc3;

    xPipe <= xPipeloc2;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN Y_reg7 <= Y_reg7loc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN xPipe_reg5 <= temp; temp := xPipe_reg5loc; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN HPipeES_reg4 <= temp; temp := HPipeES_reg4loc; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN xPipeES_reg3 <= temp; temp := xPipeES_reg3loc; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN xPipe_ctl2P_reg2 <= xPipe_ctl2P_reg2loc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN HPipe_ctl1P_reg1 <= HPipe_ctl1P_reg1loc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN xPipe_reg9 <= xPipeloc2; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN HPipe_reg8 <= temp; temp := HPipe; END IF;
      END IF;
    END PROCESS;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN HPipe_reg6 <= HPipe; END IF;
                END IF;
    END PROCESS;

    xPipeESloc4 <= xPipeES_reg3;

    HPipeESloc3 <= HPipeES_reg4;

    xPipe_ctl2Ploc5 <= xPipe_ctl2P_reg2;

    xPipe_ctl2 <= xPipe_ctl2Ploc5;

    xPipeloc2 <= xPipeESloc4 WHEN xPipe_ctl2 = '1' ELSE xPipe_reg5;

    HPipe_ctl1Ploc6 <= HPipe_ctl1P_reg1;

    HPipe_ctl1 <= HPipe_ctl1Ploc6;

    HPipe <= HPipeESloc3 WHEN HPipe_ctl1 = '1' ELSE HPipe_reg6;

    Y <= (Y_reg7 + (HPipe_reg8 * xPipe_reg9));

END behavioural;

