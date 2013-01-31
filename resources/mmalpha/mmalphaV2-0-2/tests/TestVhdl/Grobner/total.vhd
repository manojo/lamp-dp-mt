-- VHDL Model Created for "system total" 
 --  6/3/2005 12:58:51

library IEEE;
use IEEE.std_logic_1164.all;
 library test;
 use test.definition.all;


entity total is
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      Ilam1 : In Ilam1Type;
      Ilam2 : In Ilam2Type;
      Ix1 : In Ix1Type;
      Ix2 : In Ix2Type;
      Iy1 : In Iy1Type;
      Iy2 : In Iy2Type;
      ck2 : In std_logic_vector(1 to 1);
      Redu : In std_logic_vector(1 to 1);
      Iinit : In std_logic_vector(1 to 1);
      Iend : In std_logic_vector(1 to 1);
      Sl1 : Out Sl1Type;
      Sl2 : Out Sl2Type;
      Sx : Out SxType;
      Sy : Out SyType;
      Ss : Out std_logic_vector(5 to 5);
      Send : Out std_logic_vector(5 to 5);
      Sendsort : Out std_logic_vector(5 to 5);
      Sinit : Out std_logic_vector(5 to 5) );
end total;


architecture Behavioral of total is

  signal Ol1 : Ol1Type;
  signal Ol2 : Ol2Type;
  signal Ox : OxType;
  signal Oy : OyType;
  signal Os : std_logic_vector(2 to 5);
  signal Oend : std_logic_vector(2 to 5);
  signal Oendsort : std_logic_vector(2 to 5);
  signal Oinit : std_logic_vector(2 to 5);
  signal OOl1 : OOl1Type;
  signal OOl2 : OOl2Type;
  signal OOx : OOxType;
  signal OOy : OOyType;
  signal OOs : std_logic_vector(1 to 1);
  signal OOinit : std_logic_vector(1 to 1);
  signal OOend : std_logic_vector(1 to 1);
  signal OOendsort : std_logic_vector(1 to 1);
  signal IIl1 : IIl1Type;
  signal IIl2 : IIl2Type;
  signal IIx : IIxType;
  signal IIy : IIyType;
  signal IIs : std_logic_vector(2 to 5);
  signal IIend : std_logic_vector(2 to 5);
  signal IIendsort : std_logic_vector(2 to 5);
  signal IIinit : std_logic_vector(2 to 5);
 
Component cell1b
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      Ilam1 : In Integer range -32767 to 32767;
      Ilam2 : In Integer range -32767 to 32767;
      Ix1 : In Integer range -32767 to 32767;
      Ix2 : In Integer range -32767 to 32767;
      Iy1 : In Integer range -32767 to 32767;
      Iy2 : In Integer range -32767 to 32767;
      ck2 : In std_logic;
      Redu : In std_logic;
      Iinit : In std_logic;
      Iend : In std_logic;
      Olam1 : Out Integer range -32767 to 32767;
      Olam2 : Out Integer range -32767 to 32767;
      Ox : Out Integer range -32767 to 32767;
      Oy : Out Integer range -32767 to 32767;
      Os : Out std_logic;
      Oinit : Out std_logic;
      Oend : Out std_logic;
      endsort : Out std_logic );
end Component;

 
Component sortcell
      Port ( Ck : In std_logic;
      CE : In std_logic;
      Rst : In std_logic ;
      Il1 : In Integer range -32767 to 32767;
      Il2 : In Integer range -32767 to 32767;
      Ix : In Integer range -32767 to 32767;
      Iy : In Integer range -32767 to 32767;
      Isign : In std_logic;
      Iend : In std_logic;
      Iendsort : In std_logic;
      Iinit : In std_logic;
      Ol1 : Out Integer range -32767 to 32767;
      Ol2 : Out Integer range -32767 to 32767;
      Ox : Out Integer range -32767 to 32767;
      Oy : Out Integer range -32767 to 32767;
      Os : Out std_logic;
      Oend : Out std_logic;
      Oendsort : Out std_logic;
      Oinit : Out std_logic );
end Component;


begin

ETIQUETTE1 : FOR i IN 1 to 1 GENERATE 
   ETIQUETTE2: cell1b PORT MAP( Ck,CE,Rst, Ilam1(i),Ilam2(i),Ix1(i),Ix2(i),Iy1(i),Iy2(i),ck2(i),Redu(i),Iinit(i),Iend(i),OOl1(i),OOl2(i),OOx(i),OOy(i),OOs(i),OOinit(i),OOend(i),OOendsort(i));
 END GENERATE  ETIQUETTE1;

ETIQUETTE3 : FOR i IN 2 to 2 GENERATE 
   IIl1(i) <= OOl1(i-1);
END GENERATE ETIQUETTE3;

ETIQUETTE4 : FOR i IN 3 to 5 GENERATE 
   IIl1(i) <= Ol1(i-1);
END GENERATE ETIQUETTE4;

ETIQUETTE5 : FOR i IN 2 to 2 GENERATE 
   IIl2(i) <= OOl2(i-1);
END GENERATE ETIQUETTE5;

ETIQUETTE6 : FOR i IN 3 to 5 GENERATE 
   IIl2(i) <= Ol2(i-1);
END GENERATE ETIQUETTE6;

ETIQUETTE7 : FOR i IN 2 to 2 GENERATE 
   IIx(i) <= OOx(i-1);
END GENERATE ETIQUETTE7;

ETIQUETTE8 : FOR i IN 3 to 5 GENERATE 
   IIx(i) <= Ox(i-1);
END GENERATE ETIQUETTE8;

ETIQUETTE9 : FOR i IN 2 to 2 GENERATE 
   IIy(i) <= OOy(i-1);
END GENERATE ETIQUETTE9;

ETIQUETTE10 : FOR i IN 3 to 5 GENERATE 
   IIy(i) <= Oy(i-1);
END GENERATE ETIQUETTE10;

ETIQUETTE11 : FOR i IN 2 to 2 GENERATE 
   IIs(i) <= OOs(i-1);
END GENERATE ETIQUETTE11;

ETIQUETTE12 : FOR i IN 3 to 5 GENERATE 
   IIs(i) <= Os(i-1);
END GENERATE ETIQUETTE12;

ETIQUETTE13 : FOR i IN 2 to 2 GENERATE 
   IIend(i) <= OOend(i-1);
END GENERATE ETIQUETTE13;

ETIQUETTE14 : FOR i IN 3 to 5 GENERATE 
   IIend(i) <= Oend(i-1);
END GENERATE ETIQUETTE14;

ETIQUETTE15 : FOR i IN 2 to 2 GENERATE 
   IIendsort(i) <= OOendsort(i-1);
END GENERATE ETIQUETTE15;

ETIQUETTE16 : FOR i IN 3 to 5 GENERATE 
   IIendsort(i) <= Oendsort(i-1);
END GENERATE ETIQUETTE16;

ETIQUETTE17 : FOR i IN 2 to 2 GENERATE 
   IIinit(i) <= OOinit(i-1);
END GENERATE ETIQUETTE17;

ETIQUETTE18 : FOR i IN 3 to 5 GENERATE 
   IIinit(i) <= Oinit(i-1);
END GENERATE ETIQUETTE18;

ETIQUETTE19 : FOR i IN 2 to 5 GENERATE 
   ETIQUETTE20: sortcell PORT MAP( Ck,CE,Rst, IIl1(i),IIl2(i),IIx(i),IIy(i),IIs(i),IIend(i),IIendsort(i),IIinit(i),Ol1(i),Ol2(i),Ox(i),Oy(i),Os(i),Oend(i),Oendsort(i),Oinit(i));
 END GENERATE  ETIQUETTE19;

ETIQUETTE21 : FOR i IN 5 to 5 GENERATE 
   Sl1(i) <= Ol1(i);
END GENERATE ETIQUETTE21;

ETIQUETTE22 : FOR i IN 5 to 5 GENERATE 
   Sl2(i) <= Ol2(i);
END GENERATE ETIQUETTE22;

ETIQUETTE23 : FOR i IN 5 to 5 GENERATE 
   Sx(i) <= Ox(i);
END GENERATE ETIQUETTE23;

ETIQUETTE24 : FOR i IN 5 to 5 GENERATE 
   Sy(i) <= Oy(i);
END GENERATE ETIQUETTE24;

ETIQUETTE25 : FOR i IN 5 to 5 GENERATE 
   Ss(i) <= Os(i);
END GENERATE ETIQUETTE25;

ETIQUETTE26 : FOR i IN 5 to 5 GENERATE 
   Send(i) <= Oend(i);
END GENERATE ETIQUETTE26;

ETIQUETTE27 : FOR i IN 5 to 5 GENERATE 
   Sendsort(i) <= Oendsort(i);
END GENERATE ETIQUETTE27;

ETIQUETTE28 : FOR i IN 5 to 5 GENERATE 
   Sinit(i) <= Oinit(i);
END GENERATE ETIQUETTE28;



end Behavioral;


