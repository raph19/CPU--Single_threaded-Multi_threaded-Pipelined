
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY PROCESSOR_MC_TB IS
END PROCESSOR_MC_TB;
 
ARCHITECTURE behavior OF PROCESSOR_MC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROCESSOR_MC
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
			 
			PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			 
			MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
         MM_WrEn : out  STD_LOGIC;--mem
         MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0));--mem
      
    END COMPONENT;
	 
component MEM
	port ( clk : in std_logic;
			 inst_addr : in std_logic_vector(10 downto 0);
			 inst_dout : out std_logic_vector(31 downto 0);
			 data_we : in std_logic;
			 data_addr : in std_logic_vector(10 downto 0);
			 data_din : in std_logic_vector(31 downto 0);
			 data_dout : out std_logic_vector(31 downto 0));
end component;	

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
	signal Instr : std_logic_vector(31 downto 0) := (others => '0');
	signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
	
	--Outputs
	signal PC : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 8	ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROCESSOR_MC PORT MAP (
          Clk => Clk,
          Reset => Reset,
			  
			 PC => PC,
			 Instr => Instr,
			 
			 MM_RdData => MM_RdData,
			 
		  	 MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn, 
          MM_WrData => MM_WrData);
			 
	m : MEM
	port map (clk => Clk,
				 inst_addr => PC(12 downto 2),
				 inst_dout => Instr,
				 data_we => MM_WrEn,
				 data_addr => MM_Addr(12 downto 2),
				 data_din => MM_WrData,
				 data_dout => MM_RdData);
      

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Reset <= '1';
		wait for 12 ns; 
		  
		  
		  
		Reset <= '0';
      wait for Clk_period*10; 
      wait for 100 ns;	

     

      -- insert stimulus here 

      wait;
   end process;

END;
