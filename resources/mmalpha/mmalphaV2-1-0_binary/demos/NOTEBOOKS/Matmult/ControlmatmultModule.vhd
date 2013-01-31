-- VHDL Model Created for "system ControlmatmultModule" 
-- 29/12/2008 10:40:27.368145
-- Alpha2Vhdl Version 0.9 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY ControlmatmultModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCb5Xctl1PPXInit : OUT STD_LOGIC
);
END ControlmatmultModule;

ARCHITECTURE BEHAVIOURAL OF ControlmatmultModule IS

  SIGNAL counter: INTEGER; -- Declaration of the counter;

  -- Declaration of the states
  TYPE state_type IS (initState, trueState, falseState, finalState);
  ATTRIBUTE ENUM_ENCODING: STRING;
  ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS "00 01 10 11";

  SIGNAL curStatepipeCb5Xctl1PPXInit, nextStatepipeCb5Xctl1PPXInit : STATE_TYPE;
BEGIN

  -- Synchronous reset process
  PROCESS (clk, rst)
  BEGIN
    IF clk = '1' AND clk'event THEN
      IF CE = '1' THEN
        IF rst = '0' THEN
          counter <= 3;
          curStatepipeCb5Xctl1PPXInit <= initState;
        ELSE
          counter <= counter + 1;
          curStatepipeCb5Xctl1PPXInit <= nextStatepipeCb5Xctl1PPXInit;
        END IF;
      END IF;
    END IF;
  END PROCESS;

  -- Controller for signal pipeCb5Xctl1PPXInit
  PROCESS(counter, curStatepipeCb5Xctl1PPXInit)
  BEGIN
    CASE curStatepipeCb5Xctl1PPXInit IS
      WHEN initState => IF counter = 3 THEN
                            nextStatepipeCb5Xctl1PPXInit <= trueState;
                           ELSE nextStatepipeCb5Xctl1PPXInit <= initState;
                        END IF;
      WHEN trueState => IF counter = 4 THEN
                            nextStatepipeCb5Xctl1PPXInit <= falseState;
                           ELSE nextStatepipeCb5Xctl1PPXInit <= trueState;
                        END IF;
      WHEN falseState => IF counter = 102 THEN
                            nextStatepipeCb5Xctl1PPXInit <= finalState;
                           ELSE nextStatepipeCb5Xctl1PPXInit <= falseState;
                        END IF;
      WHEN OTHERS => nextStatepipeCb5Xctl1PPXInit <= finalState;
    END CASE;
  END PROCESS;

  -- Output function for signal pipeCb5Xctl1PPXInit
  PROCESS(curStatepipeCb5Xctl1PPXInit)
  BEGIN
    CASE curStatepipeCb5Xctl1PPXInit is
      WHEN initState => pipeCb5Xctl1PPXInit <= '0';
      WHEN trueState => pipeCb5Xctl1PPXInit <= '1';
      WHEN falseState => pipeCb5Xctl1PPXInit <= '0';
      WHEN finalState => pipeCb5Xctl1PPXInit <= '0';
      WHEN others =>  pipeCb5Xctl1PPXInit <= '0';
    END CASE;
  END PROCESS;
END BEHAVIOURAL;

