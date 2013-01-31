-- VHDL Model Created for "system ControlprodVectModule" 
-- 25/4/2010 18:25:17.733412
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY ControlprodVectModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  CXctl1 : OUT STD_LOGIC
);
END ControlprodVectModule;

ARCHITECTURE BEHAVIOURAL OF ControlprodVectModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStateCXctl1, nextStateCXctl1 : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= -1;
          curStateCXctl1 <= initState;
        ELSE
          counter <= counter + 1;
          curStateCXctl1 <= nextStateCXctl1;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal CXctl1
  PROCESS(counter, curStateCXctl1)
  BEGIN
    CASE curStateCXctl1 IS
      WHEN initState => IF counter = 0 THEN
                            nextStateCXctl1 <= trueState;
                           ELSE nextStateCXctl1 <= initState;
                        END IF;
      WHEN trueState => IF counter = 1 THEN
                            nextStateCXctl1 <= falseState;
                           ELSE nextStateCXctl1 <= trueState;
                        END IF;
      WHEN falseState => IF counter = 20 THEN
                            nextStateCXctl1 <= finalState;
                           ELSE nextStateCXctl1 <= falseState;
                        END IF;
      WHEN OTHERS => nextStateCXctl1 <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal CXctl1
  PROCESS(curStateCXctl1)
  BEGIN
    CASE curStateCXctl1 is
      WHEN initState => CXctl1 <= '0';
      WHEN trueState => CXctl1 <= '1';
      WHEN falseState => CXctl1 <= '0';
      WHEN finalState => CXctl1 <= '0';
      WHEN others =>  CXctl1 <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

