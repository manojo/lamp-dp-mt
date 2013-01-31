-- VHDL Model Created for "system addition" 
 --  6/3/2005 12:58:48

library IEEE;
use IEEE.std_logic_1164.all;
  
entity addition is
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      Ilam1 : In Integer range -32767 to 32767;
      Ilam2 : In Integer range -32767 to 32767;
      lllam1 : In Integer range -32767 to 32767;
      lllam2 : In Integer range -32767 to 32767;
      Ix1 : In Integer range -32767 to 32767;
      Ix2 : In Integer range -32767 to 32767;
      Iy1 : In Integer range -32767 to 32767;
      Iy2 : In Integer range -32767 to 32767;
      Ux1 : In Integer range -32767 to 32767;
      Ux2 : In Integer range -32767 to 32767;
      Uy1 : In Integer range -32767 to 32767;
      Uy2 : In Integer range -32767 to 32767;
      Rlam1 : Out Integer range -32767 to 32767;
      Rx1 : Out Integer range -32767 to 32767;
      Ry1 : Out Integer range -32767 to 32767;
      Rlam2 : Out Integer range -32767 to 32767;
      Rx2 : Out Integer range -32767 to 32767;
      Ry2 : Out Integer range -32767 to 32767 );
end addition;


architecture Behavioral of addition is

 
Component galmul
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      gal1 : In Integer range -32767 to 32767;
      gal2 : In Integer range -32767 to 32767;
      gal3 : Out Integer range -32767 to 32767 );
end Component;


begin

ETIQUETTE1: galmul Port Map(Ck,CE,Rst, Ilam1,lllam1,Rlam1);
 
ETIQUETTE2: galmul Port Map(Ck,CE,Rst, Ilam2,lllam2,Rlam2);
 

  Rx1 <= (Ix1 + Ux1);

  Ry1 <= (Iy1 + Uy1);

  Rx2 <= (Ix2 + Ux2);

  Ry2 <= (Iy2 + Uy2);


end Behavioral;


