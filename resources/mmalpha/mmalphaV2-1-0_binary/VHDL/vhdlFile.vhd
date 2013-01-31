              ------------------------------------------------
-- Memory for Kasami coefficients

COMPONENT kasami IS
  PORT 
  (
    address : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    data : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
  );
END COMPONENT;


--
              ------------------------------------------------
--
--  This is a generic read-only memory.
--  Parameters are the name, the size, the word length, the values.
--  The address length is inferred by the size
-- 

-- Memory for Kasami coefficients

-- Entity definition
ENTITY kasami IS
  PORT 
  (
    address : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    data : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
  );
END $$name;

-- Architecture
ARCHITECTURE archiOfkasami OF kasami IS

  TYPE values IS ARRAY (0 TO 7) 
    OF STD_LOGIC_VECTOR(5 DOWNTO 0);

  CONSTANT rom : values :=
    ("00001", "00001", "00000", "00000", "00001", "01000", "00010");
      
   SIGNAL addr : integer range 0 to 3;
  
BEGIN  
  
-- Convert the address into integer, in order to access the array
  addr <= conv_integer(unsigned(address));
-- Get the value
  data <= rom(addr);
 
END archiOfkasami;
              ------------------------------------------------
--
-- Component for a periodic enable of period 10
-- 

COMPONENT genEnable10 IS  
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    ceGen : IN STD_LOGIC;
    periodicGe : OUT STD_LOGIC
  );
END COMPONENT;

               --------------------------------------------------

-- This VHDL Pattern allows a periodic enable to be generated.
-- The parameters are the name, the period, the period minus one,
-- the size of the counter (it is calculated automatically by the
-- generator)
--
-- Periodic enable generator with period 7
--

ENTITY genEnable10 IS  
  PORT(
    clk : IN STD_LOGIC;         -- global clock
    rst : IN STD_LOGIC;         -- reset signal
    ceGen : IN STD_LOGIC;      -- general clock enable signal
--    CE_period: IN STD_LOGIC_VECTOR (Alpha`Vhdl2`Private`periodMun$1647 DOWNTO 0);
    periodicGe : OUT STD_LOGIC     -- periodic clock enable
  );
END genEnable10;
 
ARCHITECTURE archiOfgenEnable10 OF genEnable10 IS
    
  SIGNAL counter : STD_LOGIC_VECTOR (4 DOWNTO 0);

  BEGIN
      
  PROCESS(clk,rst,size,ceGen)
  BEGIN
    IF rst='0' THEN                     -- enable is 0 when rst
      counter <= $periodInBinary$;
      periodicGe <='0';
    ELSIF rising_edge(clk) THEN
      IF(ceGen='1') THEN                -- when ceGen is 1, increment counter
        IF (counter < Alpha`Vhdl2`Private`periodMun$1647) THEN
          counter <= counter + 1;
          periodicGe <='0';
        ELSE
          counter <= 0;                 -- or set counter to 0 when period reached
          periodicGe <='1';
        END IF;
      ELSE
        periodicGe <= '0';                  -- if ceGen is 0, do not increment
                                        -- counter, and periodic enable is 0
      END IF;
    END IF;
  END PROCESS;             
   
END archiOfgenEnable10;
 

      -------------------------------------------------------------------------
--
-- This is a Fsm
--
COMPONENT myFsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    CE_gen : IN STD_LOGIC;
    $  fifo1_Out : OUT STD_LOGIC;
  fifo2_Out : OUT STD_LOGIC$
  );
END myFsm;
      -------------------------------------------------------------------------
--
--
--
ENTITY myFsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    CE_gen : IN STD_LOGIC;
  fifo1_Out : OUT STD_LOGIC;
  fifo2_Out : OUT STD_LOGIC
  );
END myFsm;

ARCHITECTURE archiOfmyFsm OF myFsm IS
   
-- Declaration of the states
TYPE state_type IS (state0, state4, state7, state22, final);

ATTRIBUTE ENUM_ENCODING: STRING;
ATTRIBUTE ENUM_ENCODING OF state_type : TYPE IS $encoding$;

SIGNAL curstate, nextstate : STATE_TYPE;
SIGNAL count : INTEGER;

BEGIN

-- Transition function --
PROCESS(count,curstate,rst)
BEGIN
  CASE curstate IS
    WHEN state0 => IF counter = 0 THEN nextstate <= state4;
      ELSE nextstate <= state0; END IF;
    WHEN state4 => IF counter = 4 THEN nextstate <= state7;
      ELSE nextstate <= state4; END IF;
    WHEN state7 => IF counter = 7 THEN nextstate <= state22;
      ELSE nextstate <= state7; END IF;
    WHEN state22 => IF counter = 22 THEN nextstate <= final;
      ELSE nextstate <= state22; END IF;
    WHEN final => nextstate <= final;
  END CASE;
END PROCESS;

-- Generation function 
PROCESS(curstate)
BEGIN 
  CASE curstate IS
    WHEN state0 => 
      BEGIN fifo1_Out <= '0'; fifo2_Out <= '1' END;
    WHEN state4 => 
      BEGIN fifo1_Out <= '1'; fifo2_Out <= '0' END;
    WHEN state7 => 
      BEGIN fifo1_Out <= '0'; fifo2_Out <= '1' END;
    WHEN state22 => 
      BEGIN fifo1_Out <= '1'; fifo2_Out <= '0' END;

  END CASE;
END PROCESS;  
                           
---- Process courent state
PROCESS(rst,clk,CE_gen)
BEGIN
  IF(rst='0') THEN
    curstate <= state0;
    count <= 0;
  ELSIF(rising_edge(clk)) THEN
    IF (CE_gen='1') THEN
      curstate <= nextstate;
      count <= count+1;
    ELSE
      count <= count;
      curstate <=  curstate;
    END IF;
  END IF;
END PROCESS;
END archiOfmyFsm;               


