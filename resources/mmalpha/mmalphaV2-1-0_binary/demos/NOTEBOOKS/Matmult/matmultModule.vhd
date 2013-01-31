-- VHDL Model Created for "system matmultModule" 
-- 29/12/2008 10:40:32.167878
-- Alpha2Vhdl Version 0.9 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

PACKAGE TYPES IS
 TYPE LineTYPE1 IS ARRAY (INTEGER RANGE <>) OF  SIGNED (15 DOWNTO 0);
 TYPE LineTYPE2 IS ARRAY (INTEGER RANGE <>) OF  STD_LOGIC;
  TYPE aXMirr1InTYPE IS ARRAY (1 TO 1) OF LineTYPE1 (1 TO 100);
  TYPE TSep1InTYPE IS ARRAY (1 TO 100) OF LineTYPE1 (1 TO 100);
  TYPE COutTYPE IS ARRAY (1 TO 100) OF LineTYPE1 (0 TO 100);
  TYPE aXMirr1TYPE IS ARRAY (1 TO 1) OF LineTYPE1 (1 TO 100);
  TYPE C1TYPE IS ARRAY (1 TO 1) OF LineTYPE1 (1 TO 1);
  TYPE CReg1XlocTYPE IS ARRAY (1 TO 100) OF LineTYPE1 (1 TO 101);
  TYPE pipeCa51TYPE IS ARRAY (1 TO 1) OF LineTYPE1 (1 TO 1);
  TYPE pipeCa5Reg2XlocTYPE IS ARRAY (2 TO 101) OF LineTYPE1 (1 TO 100);
  TYPE pipeCb5Xctl1PP1TYPE IS ARRAY (1 TO 1) OF LineTYPE2 (1 TO 1);
  TYPE pipeCb5Xctl1PPReg5XlocTYPE IS ARRAY (2 TO 101) OF LineTYPE2 (1 TO 1);
  TYPE pipeCb5Xctl1P1TYPE IS ARRAY (1 TO 1) OF LineTYPE2 (1 TO 1);
  TYPE pipeCb5Xctl1PReg4XlocTYPE IS ARRAY (1 TO 100) OF LineTYPE2 (2 TO 101);
  TYPE pipeCb5Xctl1PPXInitXInTYPE IS ARRAY (1 TO 1) OF LineTYPE2 (1 TO 1);
  TYPE TSep1TYPE IS ARRAY (1 TO 100) OF LineTYPE1 (1 TO 100);
  TYPE C2TYPE IS ARRAY (2 TO 100) OF LineTYPE1 (2 TO 100);
  TYPE pipeCa52TYPE IS ARRAY (2 TO 100) OF LineTYPE1 (2 TO 100);
  TYPE pipeCb5Xctl1P2TYPE IS ARRAY (2 TO 100) OF LineTYPE2 (2 TO 100);
  TYPE C3TYPE IS ARRAY (2 TO 100) OF LineTYPE1 (1 TO 1);
  TYPE pipeCa53TYPE IS ARRAY (2 TO 100) OF LineTYPE1 (1 TO 1);
  TYPE pipeCb5Xctl1PP3TYPE IS ARRAY (2 TO 100) OF LineTYPE2 (1 TO 1);
  TYPE pipeCb5Xctl1P3TYPE IS ARRAY (2 TO 100) OF LineTYPE2 (1 TO 1);
  TYPE C5TYPE IS ARRAY (1 TO 1) OF LineTYPE1 (2 TO 100);
  TYPE pipeCa55TYPE IS ARRAY (1 TO 1) OF LineTYPE1 (2 TO 100);
  TYPE pipeCb5Xctl1P5TYPE IS ARRAY (1 TO 1) OF LineTYPE2 (2 TO 100);
  TYPE C8TYPE IS ARRAY (1 TO 100) OF LineTYPE1 (0 TO 0);
END TYPES;
USE work.types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

ENTITY matmultModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aXMirr1In : IN aXMirr1InTYPE;
  TSep1In : IN TSep1InTYPE;
  COut : OUT COutTYPE
);
END matmultModule;

ARCHITECTURE behavioural OF matmultModule IS
    SIGNAL pipeCb5Xctl1PPXInit :  STD_LOGIC;
    SIGNAL aXMirr1 : aXMirr1TYPE;
    SIGNAL C1 : C1TYPE;
    SIGNAL CReg1Xloc : CReg1XlocTYPE;
    SIGNAL pipeCa51 : pipeCa51TYPE;
    SIGNAL pipeCa5Reg2Xloc : pipeCa5Reg2XlocTYPE;
    SIGNAL pipeCb5Xctl1PP1 : pipeCb5Xctl1PP1TYPE;
    SIGNAL pipeCb5Xctl1PPReg5Xloc : pipeCb5Xctl1PPReg5XlocTYPE;
    SIGNAL pipeCb5Xctl1P1 : pipeCb5Xctl1P1TYPE;
    SIGNAL pipeCb5Xctl1PReg4Xloc : pipeCb5Xctl1PReg4XlocTYPE;
    SIGNAL pipeCb5Xctl1PPXInitXIn : pipeCb5Xctl1PPXInitXInTYPE;
    SIGNAL TSep1 : TSep1TYPE;
    SIGNAL C2 : C2TYPE;
    SIGNAL pipeCa52 : pipeCa52TYPE;
    SIGNAL pipeCb5Xctl1P2 : pipeCb5Xctl1P2TYPE;
    SIGNAL C3 : C3TYPE;
    SIGNAL pipeCa53 : pipeCa53TYPE;
    SIGNAL pipeCb5Xctl1PP3 : pipeCb5Xctl1PP3TYPE;
    SIGNAL pipeCb5Xctl1P3 : pipeCb5Xctl1P3TYPE;
    SIGNAL C5 : C5TYPE;
    SIGNAL pipeCa55 : pipeCa55TYPE;
    SIGNAL pipeCb5Xctl1P5 : pipeCb5Xctl1P5TYPE;
    SIGNAL C8 : C8TYPE;


  -- Insert missing components here!

COMPONENT ControlmatmultModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCb5Xctl1PPXInit : OUT STD_LOGIC
);
END COMPONENT;
COMPONENT cellmatmultModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aXMirr1 : IN  SIGNED (15 DOWNTO 0);
  CReg1Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PPXInitXIn : IN  STD_LOGIC;
  TSep1 : IN  SIGNED (15 DOWNTO 0);
  C : OUT  SIGNED (15 DOWNTO 0);
  pipeCa5 : OUT  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PP : OUT  STD_LOGIC;
  pipeCb5Xctl1P : OUT  STD_LOGIC
);
END COMPONENT;
COMPONENT cellmatmultModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  CReg1Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCa5Reg2Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PReg4Xloc : IN  STD_LOGIC;
  TSep1 : IN  SIGNED (15 DOWNTO 0);
  C : OUT  SIGNED (15 DOWNTO 0);
  pipeCa5 : OUT  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1P : OUT  STD_LOGIC
);
END COMPONENT;
COMPONENT cellmatmultModule3
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  CReg1Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCa5Reg2Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PPReg5Xloc : IN  STD_LOGIC;
  TSep1 : IN  SIGNED (15 DOWNTO 0);
  C : OUT  SIGNED (15 DOWNTO 0);
  pipeCa5 : OUT  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PP : OUT  STD_LOGIC;
  pipeCb5Xctl1P : OUT  STD_LOGIC
);
END COMPONENT;
COMPONENT cellmatmultModule5
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  aXMirr1 : IN  SIGNED (15 DOWNTO 0);
  CReg1Xloc : IN  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1PReg4Xloc : IN  STD_LOGIC;
  TSep1 : IN  SIGNED (15 DOWNTO 0);
  C : OUT  SIGNED (15 DOWNTO 0);
  pipeCa5 : OUT  SIGNED (15 DOWNTO 0);
  pipeCb5Xctl1P : OUT  STD_LOGIC
);
END COMPONENT;
COMPONENT cellmatmultModule8
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  C : OUT  SIGNED (15 DOWNTO 0)
);
END COMPONENT;


  ----BEGIN

  G1 : FOR p2 IN 1 TO 100 GENERATE
    aXMirr1(1)(p2) <= aXMirr1In(1)(p2);
  END GENERATE;

  COut(1)(1) <= C1(1)(1);

  G2 : FOR p1 IN 2 TO 100 GENERATE
    G3 : FOR p2 IN 2 TO 100 GENERATE
        COut(p1)(p2) <= C2(p1)(p2);
    END GENERATE;
  END GENERATE;

  G4 : FOR p1 IN 2 TO 100 GENERATE
    COut(p1)(1) <= C3(p1)(1);
  END GENERATE;

  G5 : FOR p2 IN 2 TO 100 GENERATE
    COut(1)(p2) <= C5(1)(p2);
  END GENERATE;

  G6 : FOR p1 IN 1 TO 100 GENERATE
    COut(p1)(0) <= C8(p1)(0);
  END GENERATE;

  CReg1Xloc(1)(2) <= C1(1)(1);

  G7 : FOR p1 IN 2 TO 100 GENERATE
    G8 : FOR p2 IN 3 TO 101 GENERATE
        CReg1Xloc(p1)(p2) <= C2(p1)(-1 + p2);
    END GENERATE;
  END GENERATE;

  G9 : FOR p1 IN 2 TO 100 GENERATE
    CReg1Xloc(p1)(2) <= C3(p1)(1);
  END GENERATE;

  G10 : FOR p2 IN 3 TO 101 GENERATE
    CReg1Xloc(1)(p2) <= C5(1)(-1 + p2);
  END GENERATE;

  G11 : FOR p1 IN 1 TO 100 GENERATE
    CReg1Xloc(p1)(1) <= C8(p1)(0);
  END GENERATE;

  pipeCa5Reg2Xloc(2)(1) <= pipeCa51(1)(1);

  G12 : FOR p1 IN 3 TO 101 GENERATE
    G13 : FOR p2 IN 2 TO 100 GENERATE
        pipeCa5Reg2Xloc(p1)(p2) <= pipeCa52(-1 + p1)(p2);
    END GENERATE;
  END GENERATE;

  G14 : FOR p1 IN 3 TO 101 GENERATE
    pipeCa5Reg2Xloc(p1)(1) <= pipeCa53(-1 + p1)(1);
  END GENERATE;

  G15 : FOR p2 IN 2 TO 100 GENERATE
    pipeCa5Reg2Xloc(2)(p2) <= pipeCa55(1)(p2);
  END GENERATE;

  pipeCb5Xctl1PPReg5Xloc(2)(1) <= pipeCb5Xctl1PP1(1)(1);

  G16 : FOR p1 IN 3 TO 101 GENERATE
    pipeCb5Xctl1PPReg5Xloc(p1)(1) <= pipeCb5Xctl1PP3(-1 + p1)(1);
  END GENERATE;

  pipeCb5Xctl1PPXInitXIn(1)(1) <= pipeCb5Xctl1PPXInit;

  pipeCb5Xctl1PReg4Xloc(1)(2) <= pipeCb5Xctl1P1(1)(1);

  G17 : FOR p1 IN 2 TO 100 GENERATE
    G18 : FOR p2 IN 3 TO 101 GENERATE
        pipeCb5Xctl1PReg4Xloc(p1)(p2) <= pipeCb5Xctl1P2(p1)(-1 + p2);
    END GENERATE;
  END GENERATE;

  G19 : FOR p1 IN 2 TO 100 GENERATE
    pipeCb5Xctl1PReg4Xloc(p1)(2) <= pipeCb5Xctl1P3(p1)(1);
  END GENERATE;

  G20 : FOR p2 IN 3 TO 101 GENERATE
    pipeCb5Xctl1PReg4Xloc(1)(p2) <= pipeCb5Xctl1P5(1)(-1 + p2);
  END GENERATE;

  G21 : FOR p1 IN 1 TO 100 GENERATE
    G22 : FOR p2 IN 1 TO 100 GENERATE
        TSep1(p1)(p2) <= TSep1In(p1)(p2);
    END GENERATE;
  END GENERATE;

  G23 : ControlmatmultModule PORT MAP (clk, CE, Rst, pipeCb5Xctl1PPXInit);

  G24 : cellmatmultModule1 PORT MAP (clk, CE, Rst, aXMirr1(1)(1), CReg1Xloc(1)(1), pipeCb5Xctl1PPXInitXIn(1)(1), TSep1(1)(1), C1(1)(1), pipeCa51(1)(1), pipeCb5Xctl1PP1(1)(1), pipeCb5Xctl1P1(1)(1));

  G25 : FOR p1 IN 2 TO 100 GENERATE
    G26 : FOR p2 IN 2 TO 100 GENERATE
        G27 : cellmatmultModule2 PORT MAP (clk, CE, Rst, CReg1Xloc(p1)(p2), pipeCa5Reg2Xloc(p1)(p2), pipeCb5Xctl1PReg4Xloc(p1)(p2), TSep1(p1)(p2), C2(p1)(p2), pipeCa52(p1)(p2), pipeCb5Xctl1P2(p1)(p2));
    END GENERATE;
  END GENERATE;

  G28 : FOR p1 IN 2 TO 100 GENERATE
    G29 : cellmatmultModule3 PORT MAP (clk, CE, Rst, CReg1Xloc(p1)(1), pipeCa5Reg2Xloc(p1)(1), pipeCb5Xctl1PPReg5Xloc(p1)(1), TSep1(p1)(1), C3(p1)(1), pipeCa53(p1)(1), pipeCb5Xctl1PP3(p1)(1), pipeCb5Xctl1P3(p1)(1));
  END GENERATE;

  G30 : FOR p2 IN 2 TO 100 GENERATE
        G31 : cellmatmultModule5 PORT MAP (clk, CE, Rst, aXMirr1(1)(p2), CReg1Xloc(1)(p2), pipeCb5Xctl1PReg4Xloc(1)(p2), TSep1(1)(p2), C5(1)(p2), pipeCa55(1)(p2), pipeCb5Xctl1P5(1)(p2));
  END GENERATE;

  G32 : FOR p1 IN 1 TO 100 GENERATE
    G33 : cellmatmultModule8 PORT MAP (clk, CE, Rst, C8(p1)(0));
  END GENERATE;
END BEHAVIOURAL;

