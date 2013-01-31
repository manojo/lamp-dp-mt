-- VHDL Model Created for "system multiplex" 
 --  6/3/2005 12:58:47

library IEEE;
use IEEE.std_logic_1164.all;
  
entity multiplex is
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      RRlam1 : In Integer range -32767 to 32767;
      RRx1 : In Integer range -32767 to 32767;
      RRy1 : In Integer range -32767 to 32767;
      RRlam2 : In Integer range -32767 to 32767;
      RRx2 : In Integer range -32767 to 32767;
      RRy2 : In Integer range -32767 to 32767;
      ck2 : In std_logic;
      Olam1 : Out Integer range -32767 to 32767;
      Olam2 : Out Integer range -32767 to 32767;
      Ox : Out Integer range -32767 to 32767;
      Oy : Out Integer range -32767 to 32767 );
end multiplex;


architecture Behavioral of multiplex is


begin


  Olam1 <= 
    RRlam1 when (ck2 = '1' ) else RRlam2;

  Olam2 <= 0;

  Ox <= 
    RRx1 when (ck2 = '1' ) else RRx2;

  Oy <= 
    RRy1 when (ck2 = '1' ) else RRy2;


end Behavioral;


