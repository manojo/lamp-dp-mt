-- VHDL Model Created for "system ControlcomputeDistancesModule" 
-- 25/4/2010 18:25:36.284883
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY ControlcomputeDistancesModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  dlocXctl1 : OUT STD_LOGIC
);
END ControlcomputeDistancesModule;

ARCHITECTURE BEHAVIOURAL OF ControlcomputeDistancesModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStatedlocXctl1, nextStatedlocXctl1 : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= 0;
          curStatedlocXctl1 <= initState;
        ELSE
          counter <= counter + 1;
          curStatedlocXctl1 <= nextStatedlocXctl1;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal dlocXctl1
  PROCESS(counter, curStatedlocXctl1)
  BEGIN
    CASE curStatedlocXctl1 IS
      WHEN initState => IF counter = 3 THEN
                            nextStatedlocXctl1 <= trueState;
                           ELSE nextStatedlocXctl1 <= initState;
                        END IF;
      WHEN trueState => IF counter = 4 THEN
                            nextStatedlocXctl1 <= falseState;
                           ELSE nextStatedlocXctl1 <= trueState;
                        END IF;
      WHEN falseState => IF counter = 23 THEN
                            nextStatedlocXctl1 <= finalState;
                           ELSE nextStatedlocXctl1 <= falseState;
                        END IF;
      WHEN OTHERS => nextStatedlocXctl1 <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal dlocXctl1
  PROCESS(curStatedlocXctl1)
  BEGIN
    CASE curStatedlocXctl1 is
      WHEN initState => dlocXctl1 <= '0';
      WHEN trueState => dlocXctl1 <= '1';
      WHEN falseState => dlocXctl1 <= '0';
      WHEN finalState => dlocXctl1 <= '0';
      WHEN others =>  dlocXctl1 <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

