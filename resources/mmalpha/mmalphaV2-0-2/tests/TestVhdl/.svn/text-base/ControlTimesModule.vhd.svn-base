-- VHDL Model Created for "system ControlTimesModule" 
 --  11/6/2004 12:35:40

library IEEE;
use IEEE.std_logic_1164.all;
  
entity ControlTimesModule is
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      Cin_Plus1_ctl1_Init : Out std_logic;
      S_Plus1_ctl1_Init : Out std_logic;
      BB_ctl1_Init : Out std_logic );
end ControlTimesModule;


architecture state_machine of ControlTimesModule is
  signal cpt: Integer;

  type Cin_Plus1_ctl1_InitStates is (E0,E0bis,E1,E2);
  signal currentCin_Plus1_ctl1_InitState, nextCin_Plus1_ctl1_InitState :Cin_Plus1_ctl1_InitStates;

  type S_Plus1_ctl1_InitStates is (E0,E0bis,E1,E2);
  signal currentS_Plus1_ctl1_InitState, nextS_Plus1_ctl1_InitState :S_Plus1_ctl1_InitStates;

  type BB_ctl1_InitStates is (E0,E0bis,E1,E2);
  signal currentBB_ctl1_InitState, nextBB_ctl1_InitState :BB_ctl1_InitStates;
BEGIN 

reset_sm : PROCESS
 begin
-- compass stateMachine adj currentCin_Plus1_ctl1_InitState
-- compass stateMachine adj currentS_Plus1_ctl1_InitState
-- compass stateMachine adj currentBB_ctl1_InitState

  WAIT UNTIL (Ck = '1' AND Ck'event);

  IF Rst ='1' THEN 
   cpt <= -1;
   currentCin_Plus1_ctl1_InitState <= E0;
   currentS_Plus1_ctl1_InitState <= E0;
   currentBB_ctl1_InitState <= E0;
  ELSE
   cpt <= cpt + 1;
   currentCin_Plus1_ctl1_InitState <= nextCin_Plus1_ctl1_InitState;
   currentS_Plus1_ctl1_InitState <= nextS_Plus1_ctl1_InitState;
   currentBB_ctl1_InitState <= nextBB_ctl1_InitState;
  END IF;
 END PROCESS;

evolution_Cin_Plus1_ctl1_Init : PROCESS(cpt, currentCin_Plus1_ctl1_InitState)
 begin 
 CASE currentCin_Plus1_ctl1_InitState IS
  WHEN E0 => IF (cpt < 0) THEN nextCin_Plus1_ctl1_InitState <= E0;
    ELSIF (cpt = 0) THEN nextCin_Plus1_ctl1_InitState <= E1;
 ELSE  nextCin_Plus1_ctl1_InitState <= E0bis; --error 
 END IF;
  WHEN E1 =>  IF (cpt = 1) THEN nextCin_Plus1_ctl1_InitState <= E2; 
 ELSE nextCin_Plus1_ctl1_InitState <= E0bis; -- error
 END IF;
  WHEN E2 => IF ((cpt >= 2) AND (cpt < 16 )) THEN nextCin_Plus1_ctl1_InitState <= E2; 
 ELSE nextCin_Plus1_ctl1_InitState <= E0bis; -- error
  END IF;
   IF (cpt = 16) THEN nextCin_Plus1_ctl1_InitState <= E0bis;  
 ELSE nextCin_Plus1_ctl1_InitState <= E0bis; -- error
 END IF;-- remise a zero de la SM
  WHEN OTHERS => -- erreurs et hors service
   nextCin_Plus1_ctl1_InitState <= E0bis ;
 END CASE;
END PROCESS;

output_Cin_Plus1_ctl1_Init : PROCESS(currentCin_Plus1_ctl1_InitState)
 begin
 CASE currentCin_Plus1_ctl1_InitState IS
  WHEN E1=>Cin_Plus1_ctl1_Init <= '0'; 
  WHEN E2=>Cin_Plus1_ctl1_Init <= '1'; 
  WHEN OTHERS =>
   Cin_Plus1_ctl1_Init <= 'X';
 END CASE;
END PROCESS;
evolution_S_Plus1_ctl1_Init : PROCESS(cpt, currentS_Plus1_ctl1_InitState)
 begin 
 CASE currentS_Plus1_ctl1_InitState IS
  WHEN E0 => IF (cpt < 0) THEN nextS_Plus1_ctl1_InitState <= E0;
    ELSIF (cpt = 0) THEN nextS_Plus1_ctl1_InitState <= E1;
 ELSE  nextS_Plus1_ctl1_InitState <= E0bis; --error 
 END IF;
  WHEN E1 =>   IF ((cpt >= 1) AND (cpt < 16 )) THEN nextS_Plus1_ctl1_InitState <= E1;; 
 ELSE nextS_Plus1_ctl1_InitState <= E0bis; -- error
  END IF;
    IF (cpt = 16) THEN nextS_Plus1_ctl1_InitState <= E2;; 
 ELSE nextS_Plus1_ctl1_InitState <= E0bis; -- error
 END IF;
  WHEN E2=> IF (cpt = 17) THEN nextS_Plus1_ctl1_InitState <= E0bis; 
 ELSE nextS_Plus1_ctl1_InitState <= E0bis; -- error
 END IF;-- remise a zero de la SM
  WHEN OTHERS => -- erreurs et hors service
   nextS_Plus1_ctl1_InitState <= E0bis ;
 END CASE;
END PROCESS;

output_S_Plus1_ctl1_Init : PROCESS(currentS_Plus1_ctl1_InitState)
 begin
 CASE currentS_Plus1_ctl1_InitState IS
  WHEN E1=>S_Plus1_ctl1_Init <= '0'; 
  WHEN E2=>S_Plus1_ctl1_Init <= '1'; 
  WHEN OTHERS =>
   S_Plus1_ctl1_Init <= 'X';
 END CASE;
END PROCESS;
evolution_BB_ctl1_Init : PROCESS(cpt, currentBB_ctl1_InitState)
 begin 
 CASE currentBB_ctl1_InitState IS
  WHEN E0 => IF (cpt < 0) THEN nextBB_ctl1_InitState <= E0;
    ELSIF (cpt = 0) THEN nextBB_ctl1_InitState <= E1;
 ELSE  nextBB_ctl1_InitState <= E0bis; --error 
 END IF;
  WHEN E1 =>  IF (cpt = 1) THEN nextBB_ctl1_InitState <= E2; 
 ELSE nextBB_ctl1_InitState <= E0bis; -- error
 END IF;
  WHEN E2 => IF ((cpt >= 2) AND (cpt < 16 )) THEN nextBB_ctl1_InitState <= E2; 
 ELSE nextBB_ctl1_InitState <= E0bis; -- error
  END IF;
   IF (cpt = 16) THEN nextBB_ctl1_InitState <= E0bis;  
 ELSE nextBB_ctl1_InitState <= E0bis; -- error
 END IF;-- remise a zero de la SM
  WHEN OTHERS => -- erreurs et hors service
   nextBB_ctl1_InitState <= E0bis ;
 END CASE;
END PROCESS;

output_BB_ctl1_Init : PROCESS(currentBB_ctl1_InitState)
 begin
 CASE currentBB_ctl1_InitState IS
  WHEN E1=>BB_ctl1_Init <= '0'; 
  WHEN E2=>BB_ctl1_Init <= '1'; 
  WHEN OTHERS =>
   BB_ctl1_Init <= 'X';
 END CASE;
END PROCESS;

END state_machine;

