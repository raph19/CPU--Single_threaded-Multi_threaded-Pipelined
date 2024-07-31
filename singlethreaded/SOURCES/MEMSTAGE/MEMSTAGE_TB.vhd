
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEMSTAGE_TB IS
END MEMSTAGE_TB;
 
ARCHITECTURE behavior OF MEMSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         ByteOp : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
component MEM 
	 Port (
			 clk : in std_logic;
		  	 inst_addr : in std_logic_vector(10 downto 0);
			 inst_dout : out std_logic_vector(31 downto 0);
			 data_we : in std_logic;
			 data_addr : in std_logic_vector(10 downto 0);
			 data_din : in std_logic_vector(31 downto 0);
			 data_dout : out std_logic_vector(31 downto 0));
end component;

   --Inputs
   signal ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
signal clk : std_logic := '0';
 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);
   
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );
memory : MEM
	port map( clk => clk,
		   	 inst_addr => "00000000000",
			    inst_dout => open,
			    data_we => MM_WrEn,
			    data_addr => MM_addr(12 downto 2),
			    data_din => MM_WrData,
			    data_dout => MM_RdData);
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns
      Mem_WrEn <='0';
		ALU_MEM_Addr <="00000000000000000000000000000001";
		MEM_DataIn <="10000000000000000000000000000001";
		ByteOp <= '0';
      wait for 200 ns;	
		
      Mem_WrEn <='1';
		ALU_MEM_Addr <="00000000000000000000000000000001";
		MEM_DataIn <="10000000000000000000000000000001";
		ByteOp <= '0';
      wait for 200 ns;
		
      Mem_WrEn <='1';
		ALU_MEM_Addr <="00000000000000000000000000000010";
		MEM_DataIn <="10000000000000000000000000000010";
		ByteOp <= '1';
      wait for 200 ns;	
		
      Mem_WrEn <='1';
		ALU_MEM_Addr <="00000000000000000000000000000011";
		MEM_DataIn <="10000000000000000000000000000011";
		ByteOp <= '1';
      wait for 200 ns;	
		
      Mem_WrEn <='1';
		ALU_MEM_Addr <="00000000000000000000000000000100";
		MEM_DataIn <="10000000000000000000000000000100";
		ByteOp <= '0';
      wait for 200 ns;	
		
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
