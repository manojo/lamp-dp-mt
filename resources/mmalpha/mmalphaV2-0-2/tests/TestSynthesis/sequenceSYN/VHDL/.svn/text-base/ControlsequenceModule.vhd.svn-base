-- VHDL Model Created for "system ControlsequenceModule" 
-- 5/1/2009 21:54:13.467387
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY ControlsequenceModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  MXctl2 : OUT STD_LOGIC
);
END ControlsequenceModule;

ARCHITECTURE BEHAVIOURAL OF ControlsequenceModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStateMXctl2, nextStateMXctl2 : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= 0;
          curStateMXctl2 <= initState;
        ELSE
          counter <= counter + 1;
          curStateMXctl2 <= nextStateMXctl2;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal MXctl2
  PROCESS(counter, curStateMXctl2)
  BEGIN
    CASE curStateMXctl2 IS
      WHEN initState => IF counter = 1 THEN
                            nextStateMXctl2 <= trueState;
                           ELSE nextStateMXctl2 <= initState;
                        END IF;
      WHEN trueState => IF counter = 2 THEN
                            nextStateMXctl2 <= falseState;
                           ELSE nextStateMXctl2 <= trueState;
                        END IF;
      WHEN falseState => IF counter = 101 THEN
                            nextStateMXctl2 <= finalState;
                           ELSE nextStateMXctl2 <= falseState;
                        END IF;
      WHEN OTHERS => nextStateMXctl2 <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal MXctl2
  PROCESS(curStateMXctl2)
  BEGIN
    CASE curStateMXctl2 is
      WHEN initState => MXctl2 <= '0';
      WHEN trueState => MXctl2 <= '1';
      WHEN falseState => MXctl2 <= '0';
      WHEN finalState => MXctl2 <= '0';
      WHEN others =>  MXctl2 <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

