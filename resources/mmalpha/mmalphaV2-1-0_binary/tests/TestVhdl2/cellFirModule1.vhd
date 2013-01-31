-- VHDL Model Created for "system cellFirModule1" 
-- 23/4/2010 14:36:38.636438
-- Alpha2Vhdl Version 0.9 

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;

ENTITY cellFirModule1 IS
PORT(
  clk: IN STD_LOGIC;
  CE : IN STD_LOGIC;
  Rst : IN STD_LOGIC;
  H_mirr1 : IN SIGNED (15 DOWNTO 0);
  x_mirr1 : IN SIGNED (15 DOWNTO 0);
  Y : OUT SIGNED (15 DOWNTO 0);
  xPipe : OUT SIGNED (15 DOWNTO 0);
  HPipeES : OUT SIGNED (15 DOWNTO 0);
  xPipeES : OUT SIGNED (15 DOWNTO 0)
);
END cellFirModule1;

ARCHITECTURE behavioural OF cellFirModule1 IS
    SIGNAL xPipeESloc4 :  SIGNED (15 DOWNTO 0) := "0000000000000000";


  -- Insert missing components here!---------

-- $MissingComponents$
BEGIN

    xPipeES <= xPipeESloc4;

    xPipeESloc4 <= x_mirr1;

    HPipeES <= H_mirr1;

    xPipe <= xPipeESloc4;

    Y <= "0000000000000000";

END behavioural;

