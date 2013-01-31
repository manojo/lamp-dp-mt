-- VHDL Model Created for "system ControlfirrModule" 
-- 23/4/2010 8:38:34.247960
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY ControlfirrModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  WXctl1PXInit : OUT STD_LOGIC
);
END ControlfirrModule;

ARCHITECTURE BEHAVIOURAL OF ControlfirrModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStateWXctl1PXInit, nextStateWXctl1PXInit : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= -2;
          curStateWXctl1PXInit <= initState;
        ELSE
          counter <= counter + 1;
          curStateWXctl1PXInit <= nextStateWXctl1PXInit;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal WXctl1PXInit
  PROCESS(counter, curStateWXctl1PXInit)
  BEGIN
    CASE curStateWXctl1PXInit IS
      WHEN initState => IF counter = 3 THEN
                            nextStateWXctl1PXInit <= trueState;
                           ELSE nextStateWXctl1PXInit <= initState;
                        END IF;
      WHEN trueState => IF counter = 9 THEN
                            nextStateWXctl1PXInit <= falseState;
                           ELSE nextStateWXctl1PXInit <= trueState;
                        END IF;
      WHEN falseState => IF counter = 10 THEN
                            nextStateWXctl1PXInit <= finalState;
                           ELSE nextStateWXctl1PXInit <= falseState;
                        END IF;
      WHEN OTHERS => nextStateWXctl1PXInit <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal WXctl1PXInit
  PROCESS(curStateWXctl1PXInit)
  BEGIN
    CASE curStateWXctl1PXInit is
      WHEN initState => WXctl1PXInit <= '0';
      WHEN trueState => WXctl1PXInit <= '1';
      WHEN falseState => WXctl1PXInit <= '0';
      WHEN finalState => WXctl1PXInit <= '0';
      WHEN others =>  WXctl1PXInit <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

