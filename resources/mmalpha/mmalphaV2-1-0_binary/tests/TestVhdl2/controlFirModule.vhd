-- VHDL Model Created for "system controlFirModule" 
-- 23/4/2010 14:36:38.940087
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY controlFirModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  HPipe_ctl1P_Init : OUT STD_LOGIC;
  xPipe_ctl2P_Init : OUT STD_LOGIC
);
END controlFirModule;

ARCHITECTURE BEHAVIOURAL OF controlFirModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStateHPipe_ctl1P_Init, nextStateHPipe_ctl1P_Init : STATE_TYPE;
  SIGNAL curStatexPipe_ctl2P_Init, nextStatexPipe_ctl2P_Init : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= 0;
          curStateHPipe_ctl1P_Init <= initState;
          curStatexPipe_ctl2P_Init <= initState;
        ELSE
          counter <= counter + 1;
          curStateHPipe_ctl1P_Init <= nextStateHPipe_ctl1P_Init;
          curStatexPipe_ctl2P_Init <= nextStatexPipe_ctl2P_Init;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal HPipe_ctl1P_Init
  PROCESS(counter, curStateHPipe_ctl1P_Init)
  BEGIN
    CASE curStateHPipe_ctl1P_Init IS
      WHEN initState => IF counter = 1 THEN
                            nextStateHPipe_ctl1P_Init <= trueState;
                           ELSE nextStateHPipe_ctl1P_Init <= initState;
                        END IF;
      WHEN trueState => IF counter = 2 THEN
                            nextStateHPipe_ctl1P_Init <= falseState;
                           ELSE nextStateHPipe_ctl1P_Init <= trueState;
                        END IF;
      WHEN falseState => IF counter = 7 THEN
                            nextStateHPipe_ctl1P_Init <= finalState;
                           ELSE nextStateHPipe_ctl1P_Init <= falseState;
                        END IF;
      WHEN OTHERS => nextStateHPipe_ctl1P_Init <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal HPipe_ctl1P_Init
  PROCESS(curStateHPipe_ctl1P_Init)
  BEGIN
    CASE curStateHPipe_ctl1P_Init is
      WHEN initState => HPipe_ctl1P_Init <= '0';
      WHEN trueState => HPipe_ctl1P_Init <= '1';
      WHEN falseState => HPipe_ctl1P_Init <= '0';
      WHEN finalState => HPipe_ctl1P_Init <= '0';
      WHEN others =>  HPipe_ctl1P_Init <= '0';
    END CASE;
  END PROCESS;

  -- Controller for signal xPipe_ctl2P_Init
  PROCESS(counter, curStatexPipe_ctl2P_Init)
  BEGIN
    CASE curStatexPipe_ctl2P_Init IS
      WHEN initState => IF counter = 2 THEN
                            nextStatexPipe_ctl2P_Init <= trueState;
                           ELSE nextStatexPipe_ctl2P_Init <= initState;
                        END IF;
      WHEN trueState => IF counter = 3 THEN
                            nextStatexPipe_ctl2P_Init <= falseState;
                           ELSE nextStatexPipe_ctl2P_Init <= trueState;
                        END IF;
      WHEN falseState => IF counter = 7 THEN
                            nextStatexPipe_ctl2P_Init <= finalState;
                           ELSE nextStatexPipe_ctl2P_Init <= falseState;
                        END IF;
      WHEN OTHERS => nextStatexPipe_ctl2P_Init <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal xPipe_ctl2P_Init
  PROCESS(curStatexPipe_ctl2P_Init)
  BEGIN
    CASE curStatexPipe_ctl2P_Init is
      WHEN initState => xPipe_ctl2P_Init <= '0';
      WHEN trueState => xPipe_ctl2P_Init <= '1';
      WHEN falseState => xPipe_ctl2P_Init <= '0';
      WHEN finalState => xPipe_ctl2P_Init <= '0';
      WHEN others =>  xPipe_ctl2P_Init <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

