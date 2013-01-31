-- VHDL Model Created for "system firrModule" 
-- 23/4/2010 8:38:36.891153
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

USE work.TYPES.all

ENTITY firrModule IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  dXMirr1In : IN  SIGNED (15 DOWNTO 0);
  xXMirr1In : IN  SIGNED (15 DOWNTO 0);
  xXMirr2In : IN  SIGNED (15 DOWNTO 0);
  YOut : OUT Array-1To2OfInteger
);
END firrModule;

ARCHITECTURE behavioural OF firrModule IS
    SIGNAL WXctl1PXInit :  STD_LOGIC;
    SIGNAL dXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCE171 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCE17Reg3Xloc : Array0To3OfInteger;
    SIGNAL pipeCx351 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx35Reg4Xloc : Array0To3OfInteger;
    SIGNAL pipeCx371 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx37Reg5Xloc : Array-1To3OfInteger;
    SIGNAL WXctl1P1 :  STD_LOGIC;
    SIGNAL WXctl1PReg7Xloc : Array1To3OfBoolean;
    SIGNAL Y1 :  SIGNED (15 DOWNTO 0);
    SIGNAL YReg8Xloc : Array0To3OfInteger;
    SIGNAL pipeCE172 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx352 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx372 :  SIGNED (15 DOWNTO 0);
    SIGNAL WXctl1P2 :  STD_LOGIC;
    SIGNAL Y2 :  SIGNED (15 DOWNTO 0);
    SIGNAL WXctl1PXInitXIn :  STD_LOGIC;
    SIGNAL xXMirr2 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCE174 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx354 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx374 :  SIGNED (15 DOWNTO 0);
    SIGNAL Y4 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCE176 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx356 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx376 :  SIGNED (15 DOWNTO 0);
    SIGNAL WXctl1P6 :  STD_LOGIC;
    SIGNAL Y6 :  SIGNED (15 DOWNTO 0);
    SIGNAL xXMirr1 :  SIGNED (15 DOWNTO 0);
    SIGNAL pipeCx377 :  SIGNED (15 DOWNTO 0);


  -- Insert missing components here!



-- Components for calls to external functions

-- Component for cellfirrModule1
COMPONENT cellfirrModule1
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  dXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCE17Reg3Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx35Reg4Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx37Reg5Xloc : IN SIGNED (15 DOWNTO 0);
  WXctl1PReg7Xloc : IN STD_LOGIC;
  YReg8Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCE17 : OUT SIGNED (15 DOWNTO 0);
  pipeCx35 : OUT SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0);
  WXctl1P : OUT STD_LOGIC;
  Y : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellfirrModule2
COMPONENT cellfirrModule2
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCE17Reg3Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx35Reg4Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx37Reg5Xloc : IN SIGNED (15 DOWNTO 0);
  YReg8Xloc : IN SIGNED (15 DOWNTO 0);
  WXctl1PXInitXIn : IN STD_LOGIC;
  pipeCE17 : OUT SIGNED (15 DOWNTO 0);
  pipeCx35 : OUT SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0);
  WXctl1P : OUT STD_LOGIC;
  Y : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellfirrModule4
COMPONENT cellfirrModule4
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  xXMirr2 : IN SIGNED (15 DOWNTO 0);
  pipeCx37Reg5Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCE17 : OUT SIGNED (15 DOWNTO 0);
  pipeCx35 : OUT SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0);
  Y : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellfirrModule6
COMPONENT cellfirrModule6
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  pipeCE17Reg3Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx35Reg4Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCx37Reg5Xloc : IN SIGNED (15 DOWNTO 0);
  WXctl1PReg7Xloc : IN STD_LOGIC;
  YReg8Xloc : IN SIGNED (15 DOWNTO 0);
  pipeCE17 : OUT SIGNED (15 DOWNTO 0);
  pipeCx35 : OUT SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0);
  WXctl1P : OUT STD_LOGIC;
  Y : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for cellfirrModule7
COMPONENT cellfirrModule7
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  xXMirr1 : IN SIGNED (15 DOWNTO 0);
  pipeCx37 : OUT SIGNED (15 DOWNTO 0)
);
END COMPONENT;

-- Component for ControlfirrModule
COMPONENT ControlfirrModule
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  WXctl1PXInit : OUT STD_LOGIC
);
END COMPONENT;

  -- $MissingComponents$


BEGIN

  dXMirr1 <= dXMirr1In;

  pipeCE17Reg3Xloc(3) <= pipeCE171;

  pipeCE17Reg3Xloc(1) <= pipeCE172;

  pipeCE17Reg3Xloc(0) <= pipeCE174;

  pipeCE17Reg3Xloc(2) <= pipeCE176;

  pipeCx35Reg4Xloc(3) <= pipeCx351;

  pipeCx35Reg4Xloc(1) <= pipeCx352;

  pipeCx35Reg4Xloc(0) <= pipeCx354;

  pipeCx35Reg4Xloc(2) <= pipeCx356;

  pipeCx37Reg5Xloc(3) <= pipeCx371;

  pipeCx37Reg5Xloc(1) <= pipeCx372;

  pipeCx37Reg5Xloc(0) <= pipeCx374;

  pipeCx37Reg5Xloc(2) <= pipeCx376;

  pipeCx37Reg5Xloc(-1) <= pipeCx377;

  WXctl1PReg7Xloc(3) <= WXctl1P1;

  WXctl1PReg7Xloc(1) <= WXctl1P2;

  WXctl1PReg7Xloc(2) <= WXctl1P6;

  WXctl1PXInitXIn <= WXctl1PXInit;

  xXMirr1 <= xXMirr1In;

  xXMirr2 <= xXMirr2In;

  YOut(2) <= Y1;

  YOut(0) <= Y2;

  YOut(-1) <= Y4;

  YOut(1) <= Y6;

  YReg8Xloc(3) <= Y1;

  YReg8Xloc(1) <= Y2;

  YReg8Xloc(0) <= Y4;

  YReg8Xloc(2) <= Y6;

  G1 : ControlfirrModule PORT MAP (clk, CE, rst, WXctl1PXInit));

  G2 : cellfirrModule1 PORT MAP (clk, CE, rst, dXMirr1(2)(2), pipeCE17Reg3Xloc(2)(2), pipeCx35Reg4Xloc(2)(2), pipeCx37Reg5Xloc(2)(2), WXctl1PReg7Xloc(2)(2), YReg8Xloc(2)(2), pipeCE171(2)(2), pipeCx351(2)(2), pipeCx371(2)(2), WXctl1P1(2)(2), (2)(2));

  G3 : cellfirrModule2 PORT MAP (clk, CE, rst, pipeCE17Reg3Xloc(0)(0), pipeCx35Reg4Xloc(0)(0), pipeCx37Reg5Xloc(0)(0), YReg8Xloc(0)(0), WXctl1PXInitXIn(0)(0), pipeCE172(0)(0), pipeCx352(0)(0), pipeCx372(0)(0), WXctl1P2(0)(0), (0)(0));

  G4 : cellfirrModule4 PORT MAP (clk, CE, rst, xXMirr2(-1)(-1), pipeCx37Reg5Xloc(-1)(-1), pipeCE174(-1)(-1), pipeCx354(-1)(-1), pipeCx374(-1)(-1), (-1)(-1));

  G5 : cellfirrModule6 PORT MAP (clk, CE, rst, pipeCE17Reg3Xloc(1)(1), pipeCx35Reg4Xloc(1)(1), pipeCx37Reg5Xloc(1)(1), WXctl1PReg7Xloc(1)(1), YReg8Xloc(1)(1), pipeCE176(1)(1), pipeCx356(1)(1), pipeCx376(1)(1), WXctl1P6(1)(1), (1)(1));

  G6 : cellfirrModule7 PORT MAP (clk, CE, rst, xXMirr1(-2)(-2), (-2)(-2));

END BEHAVIOURAL;

