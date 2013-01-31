------------------------------------------------------------------------
-- VHDL test bench file for system fir
-- Generated with vhdlTestBench.m at 4/25/2010
------------------------------------------------------------------------
library ieee;
USE ieee.std_logic_textio.all;
USE std.textio.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.all;

USE work.all;
USE work.types.all;
USE work.definition.max;
USE work.definition.min;

ENTITY testbench_fir is
END testbench_fir;

ARCHITECTURE behavioural OF testbench_fir IS

---insert component of fir here 
 
-- Design independent signals 

  -- Integers to and from tested component 

  SIGNAL rst_0 : std_logic := '0';
  SIGNAL clk : std_logic := '0';
  SIGNAL ce : std_logic := '0';

  CONSTANT clk_rate : TIME := 20 ns;

  CONSTANT clk_init : TIME := 50 ns;

---- Design dependent signals
  -- Inputs
  SIGNAL sig_x :  SIGNED (2 DOWNTO 0);
  SIGNAL sig_w :  SIGNED (2 DOWNTO 0);
  -- Outputs
  SIGNAL sig_y :  SIGNED (5 DOWNTO 0);


BEGIN 

---- Instantiation of the components

  comp : fir PORT MAP( clk => clk, ce => ce, rst => rst_0, x => sig_x, w => sig_w, y => sig_y );

-- clock, clock enable and reset generation 

  ce <= '1' AFTER clk_rate;
  rst_0 <= '1' AFTER clk_init;
  clk <= NOT clk AFTER clk_rate;

-- Process start 
stimuli : PROCESS( clk, rst_0 )

-- Design independent variables 
  VARIABLE temp_buffer:	STD_LOGIC_VECTOR (31 DOWNTO 0);
  VARIABLE temp_buffer_out: STD_LOGIC_VECTOR (31 DOWNTO 0);
  VARIABLE endstim : BOOLEAN := FALSE; -- end of stimulation
  VARIABLE good : BOOLEAN; -- check current read in stimuli file
  VARIABLE i,i1,i2,i3,i4 : INTEGER; -- loop counter
  VARIABLE j : INTEGER; -- loop counter
  CONSTANT space : STRING := "  ";  -- Blank string 

---- Design dependent variables
  --Inputs
  VARIABLE x :  SIGNED (2 DOWNTO 0);
  VARIABLE w :  SIGNED (2 DOWNTO 0);
 --outputs
  VARIABLE y :  SIGNED (5 DOWNTO 0);

---- Design dependent Buffers
  -- Inputs
  VARIABLE temp_buffer_x : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
  VARIABLE temp_buffer_w : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
 --outputs
  VARIABLE temp_buffer_y : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');

---- Design dependent file declaration
  --Inputs
  FILE stim_file_x :text OPEN READ_MODE IS "stim_x.txt";
  FILE stim_file_w :text OPEN READ_MODE IS "stim_w.txt";
  --Outputs
  FILE stim_file_y :TEXT OPEN WRITE_MODE IS "stim_y.txt";

---- Design dependent line declaration
  --Inputs
  VARIABLE stim_line_x : LINE ;
  VARIABLE stim_line_w : LINE ;
  --Outputs
  VARIABLE stim_line_y : LINE ;


  VARIABLE timecounter : INTEGER := -1; -- indicate the step t.
  -- Initialisation is design dependent

BEGIN
  IF rst_0 = '0' THEN
  -- Signal initialisation


  ELSIF clk'EVENT AND clk='1' THEN
---- Reading stimuli files

  IF (timecounter >= 0) AND (timecounter <= 10) THEN 
  FOR i IN 0 TO 10 LOOP
    READLINE(stim_file_x, stim_line_x);
    HREAD(stim_line_x, temp_buffer_x, good);
    x := SIGNED(temp_buffer_x  (2 DOWNTO 0));
   ASSERT good REPORT "read text i/o read error" SEVERITY ERROR;
  END LOOP;
  END IF;

  IF (timecounter >= 1) AND (timecounter <= 3) THEN 
  FOR k IN 1 TO 3 LOOP
    READLINE(stim_file_w, stim_line_w);
    HREAD(stim_line_w, temp_buffer_w, good);
    w := SIGNED(temp_buffer_w  (2 DOWNTO 0));
   ASSERT good REPORT "read text i/o read error" SEVERITY ERROR;
  END LOOP;
  END IF;


-- Affectation to signals

  sig_x <= x;
  sig_w <= w;

  y := sig_y;


-- Writing stimuli to files

  IF (timecounter >= 4) AND (timecounter <= 10) THEN 
  FOR i IN 3 TO 10 LOOP
    temp_buffer_y  (5 DOWNTO 0) := std_logic_vector(y());
    HWRITE(stim_line_y, temp_buffer_y);
    WRITELINE( stim_file_y , stim_line_y);
  END LOOP;
  END IF;


-- End of process, increment of timecounter

  timecounter := timecounter+1;

  ASSERT NOT endstim REPORT "end of stimuli file. Stop the rtl!" SEVERITY ERROR;
  endstim := ENDFILE(stim_file_x) OR ENDFILE(stim_file_w) ;

  -- severity error does not stop the simulation, whether failure does!
  -- But the process has to continue until the end of the calculation

  ASSERT timecounter <= 11
-- May be upBound ?
  REPORT " Failure asked on purpose, normaly result is written in stimy.txt "
  SEVERITY FAILURE;
  END IF;

END PROCESS;

END BEHAVIOURAL;

