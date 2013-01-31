-- VHDL Model Created for "system cellfirrModule4" 
-- 23/4/2010 8:38:35.195236
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellfirrModule4 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  xXMirr2 : IN SIGNED (15 DOWNTO 0);
  pipeCx37Reg5Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCE17 : OUT SIGNED (15 DOWNTO 0);
  pipeCx35 : OUT SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0);
  Y : OUT SIGNED (15 DOWNTO 0)
);
END cellfirrModule4;

ARCHITECTURE behavioural OF cellfirrModule4 IS
    SIGNAL Yloc4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL EReg2 :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL EReg2Xloc :  SIGNED (15 DOWNTO 0) := "0000000000000000";
    SIGNAL pipeCx37Reg5 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    Y <= Yloc4;

    EReg2Xloc <= E;

    PROCESS(clk) BEGIN IF (clk = '1' AND clk'EVENT) THEN
      IF CE='1' THEN EReg2 <= EReg2Xloc; END IF;
                END IF;
    END PROCESS;

    PROCESS(clk) VARIABLE temp:  SIGNED (15 DOWNTO 0);
    BEGIN
      IF (clk = '1' AND clk'EVENT) THEN
        IF CE='1' THEN pipeCx37Reg5 <= temp; temp := pipeCx37Reg5Xloc; END IF;
      END IF;
    END PROCESS;

    pipeCx37 <= pipeCx37Reg5;

    pipeCx35 <= xXMirr2;

    pipeCE17 <= EReg2;

    Yloc4 <= "0000000000000000";

END behavioural;

