-- VHDL Model Created for "system ControlfirModule" 
-- 5/1/2009 21:53:23.803981
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY ControlfirModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  ser1Xctl1 : OUT STD_LOGIC
);
END ControlfirModule;

ARCHITECTURE BEHAVIOURAL OF ControlfirModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStateser1Xctl1, nextStateser1Xctl1 : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= 99;
          curStateser1Xctl1 <= initState;
        ELSE
          counter <= counter + 1;
          curStateser1Xctl1 <= nextStateser1Xctl1;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal ser1Xctl1
  PROCESS(counter, curStateser1Xctl1)
  BEGIN
    CASE curStateser1Xctl1 IS
      WHEN initState => IF counter = 100 THEN
                            nextStateser1Xctl1 <= trueState;
                           ELSE nextStateser1Xctl1 <= initState;
                        END IF;
      WHEN trueState => IF counter = 101 THEN
                            nextStateser1Xctl1 <= falseState;
                           ELSE nextStateser1Xctl1 <= trueState;
                        END IF;
      WHEN falseState => IF counter = 104 THEN
                            nextStateser1Xctl1 <= finalState;
                           ELSE nextStateser1Xctl1 <= falseState;
                        END IF;
      WHEN OTHERS => nextStateser1Xctl1 <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal ser1Xctl1
  PROCESS(curStateser1Xctl1)
  BEGIN
    CASE curStateser1Xctl1 is
      WHEN initState => ser1Xctl1 <= '0';
      WHEN trueState => ser1Xctl1 <= '1';
      WHEN falseState => ser1Xctl1 <= '0';
      WHEN finalState => ser1Xctl1 <= '0';
      WHEN others =>  ser1Xctl1 <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

