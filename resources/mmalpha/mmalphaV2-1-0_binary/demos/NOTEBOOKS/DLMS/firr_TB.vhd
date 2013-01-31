------------------------------------------------------------------------
-- VHDL test bench file for system firr
-- Generated with vhdlTestBench.m at 3/9/2010
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

ENTITY testbench_firr is
END testbench_firr;

ARCHITECTURE behavioural OF testbench_firr IS

---insert component of firr here 
 
-- Design independent signals 

  -- Integers to and from tested component 

  SIGNAL rst_0 : std_logic := '0';
  SIGNAL clk : std_logic := '0';
  SIGNAL ce : std_logic := '0';

  CONSTANT clk_rate : TIME := 20 ns;

  CONSTANT clk_init : TIME := 50 ns;

---- Design dependent signals
  -- Inputs
  SIGNAL sig_x :  SIGNED (15 DOWNTO 0);
  SIGNAL sig_d :  SIGNED (15 DOWNTO 0);
  -- Outputs
  SIGNAL sig_res :  SIGNED (15 DOWNTO 0);


BEGIN 

---- Instantiation of the components

  comp : firr PORT MAP( clk => clk, ce => ce, rst => rst_0, x => sig_x, d => sig_d, res => sig_res );

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
  VARIABLE x :  SIGNED (15 DOWNTO 0);
  VARIABLE d :  SIGNED (15 DOWNTO 0);
 --outputs
  VARIABLE res :  SIGNED (15 DOWNTO 0);

---- Design dependent Buffers
  -- Inputs
  VARIABLE temp_buffer_x : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
  VARIABLE temp_buffer_d : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
 --outputs
  VARIABLE temp_buffer_res : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');

---- Design dependent file declaration
  --Inputs
  FILE stim_file_x :text OPEN READ_MODE IS "stim_x.txt";
  FILE stim_file_d :text OPEN READ_MODE IS "stim_d.txt";
  --Outputs
  FILE stim_file_res :TEXT OPEN WRITE_MODE IS "stim_res.txt";

---- Design dependent line declaration
  --Inputs
  VARIABLE stim_line_x : LINE ;
  VARIABLE stim_line_d : LINE ;
  --Outputs
  VARIABLE stim_line_res : LINE ;


  VARIABLE timecounter : INTEGER := -6; -- indicate the step t.
  -- Initialisation is design dependent

BEGIN
  IF rst_0 = '0' THEN
  -- Signal initialisation


  ELSIF clk'EVENT AND clk='1' THEN
---- Reading stimuli files

  IF (timecounter >= 1) AND (timecounter <= 10) THEN 
  FOR n IN 1 TO 10 LOOP
    READLINE(stim_file_x, stim_line_x);
    HREAD(stim_line_x, temp_buffer_x, good);
    x := SIGNED(temp_buffer_x  (15 DOWNTO 0));
   ASSERT good REPORT "read text i/o read error" SEVERITY ERROR;
  END LOOP;
  END IF;

  IF (timecounter >= 3) AND (timecounter <= 10) THEN 
  FOR n IN 3 TO 10 LOOP
    READLINE(stim_file_d, stim_line_d);
    HREAD(stim_line_d, temp_buffer_d, good);
    d := SIGNED(temp_buffer_d  (15 DOWNTO 0));
   ASSERT good REPORT "read text i/o read error" SEVERITY ERROR;
  END LOOP;
  END IF;


-- Affectation to signals

  sig_x <= x;
  sig_d <= d;

  res := sig_res;


-- Writing stimuli to files

  IF (timecounter >= 4) AND (timecounter <= 10) THEN 
  FOR n IN 3 TO 10 LOOP
    temp_buffer_res  (15 DOWNTO 0) := std_logic_vector(res());
    HWRITE(stim_line_res, temp_buffer_res);
    WRITELINE( stim_file_res , stim_line_res);
  END LOOP;
  END IF;


-- End of process, increment of timecounter

  timecounter := timecounter+1;

  ASSERT NOT endstim REPORT "end of stimuli file. Stop the rtl!" SEVERITY ERROR;
  endstim := ENDFILE(stim_file_x) OR ENDFILE(stim_file_d) ;

  -- severity error does not stop the simulation, whether failure does!
  -- But the process has to continue until the end of the calculation

  ASSERT timecounter <= 11
-- May be upBound ?
  REPORT " Failure asked on purpose, normaly result is written in stimres.txt "
  SEVERITY FAILURE;
  END IF;

END PROCESS;

END BEHAVIOURAL;

