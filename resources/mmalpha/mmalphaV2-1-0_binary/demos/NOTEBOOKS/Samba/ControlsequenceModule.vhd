-- VHDL Model Created for "system ControlsequenceModule" 
-- 23/4/2010 8:53:7.786960
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY ControlsequenceModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  expr2 : OUT STD_LOGIC
);
END ControlsequenceModule;

ARCHITECTURE BEHAVIOURAL OF ControlsequenceModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStateexpr2, nextStateexpr2 : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= 0;
          curStateexpr2 <= initState;
        ELSE
          counter <= counter + 1;
          curStateexpr2 <= nextStateexpr2;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal expr2
  PROCESS(counter, curStateexpr2)
  BEGIN
    CASE curStateexpr2 IS
      WHEN initState => IF counter = 1 THEN
                            nextStateexpr2 <= trueState;
                           ELSE nextStateexpr2 <= initState;
                        END IF;
      WHEN trueState => IF counter = 2 THEN
                            nextStateexpr2 <= falseState;
                           ELSE nextStateexpr2 <= trueState;
                        END IF;
      WHEN falseState => IF counter = 101 THEN
                            nextStateexpr2 <= finalState;
                           ELSE nextStateexpr2 <= falseState;
                        END IF;
      WHEN OTHERS => nextStateexpr2 <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal expr2
  PROCESS(curStateexpr2)
  BEGIN
    CASE curStateexpr2 is
      WHEN initState => expr2 <= '0';
      WHEN trueState => expr2 <= '1';
      WHEN falseState => expr2 <= '0';
      WHEN finalState => expr2 <= '0';
      WHEN others =>  expr2 <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

