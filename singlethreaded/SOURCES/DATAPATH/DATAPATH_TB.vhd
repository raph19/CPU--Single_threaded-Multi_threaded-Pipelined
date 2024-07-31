
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY DATAPATH_TB IS
END DATAPATH_TB;
 
ARCHITECTURE behavior OF DATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0);
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_Sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_zero : OUT  std_logic;
         ByteOp : IN  std_logic;
         MEM_WrEn : IN  std_logic;
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
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_Sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          PC => PC,
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_Sel => RF_B_Sel,
          ImmExt => ImmExt,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );


	memory : MEM
      port map (clk => Clk,
					 inst_addr => PC(12 DOWNTO 2),
					 inst_dout => Instr,
			       data_we => MM_WrEn,
					 data_addr => MM_Addr(12 downto 2),
					 data_din => MM_WrData,
					 data_dout =>MM_RdData);	
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
			wait for 25 ns;
			
			PC_sel <= '0';
         PC_LdEn <='1';
			
			Reset <= '0';
			wait for clk_period*1;
			
			Reset <= '0';
			--addi
			PC_sel <= '0';
         PC_LdEn <='1';
			RF_WrEn <='1';
         RF_WrData_sel <= '0';
         RF_B_Sel <= '0';
         ImmExt <= "10";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";
         ByteOp <= '0';
         MEM_WrEn <= '0';
        	wait for clk_period*1;
			--ori
			PC_sel <= '0';
         PC_LdEn <='1';
			RF_WrEn <='1';
         RF_WrData_sel <= '0';
         RF_B_Sel <= '0';
         ImmExt <= "00";
         ALU_Bin_sel <= '1';
         ALU_func <= "0011";
         ByteOp <= '0';
         MEM_WrEn <= '0';
        	wait for  clk_period*1;
			--sw
			PC_sel <= '0';
         PC_LdEn <='1';
			RF_WrEn <='0';
         RF_WrData_sel <= '1';
         RF_B_Sel <= '1';
         ImmExt <= "10";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";
         ByteOp <= '0';
         MEM_WrEn <= '1';
        	wait for clk_period*1;
			--lw
			PC_sel <= '0';
         PC_LdEn <='1';
			RF_WrEn <='1';----------
         RF_WrData_sel <= '1';----
         RF_B_Sel <= '0';
         ImmExt <= "10";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";
         ByteOp <= '0';
         MEM_WrEn <= '0';
        	wait for clk_period*1;
			--lb
			PC_sel <= '0';
         PC_LdEn <='1';
			RF_WrEn <='1';
         RF_WrData_sel <= '1';
         RF_B_Sel <= '0';
         ImmExt <= "10";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";
         ByteOp <= '1';
         MEM_WrEn <= '0';
        	wait for  clk_period*1;
			--nand	
			PC_sel <= '0';
         PC_LdEn <='1';
			RF_WrEn <='1';
         RF_WrData_sel <= '1';-------
         RF_B_Sel <= '1';----
         ALU_Bin_sel <= '0';
         ALU_func <= "0000";
         ByteOp <= '0';
         MEM_WrEn <= '0';
        	wait for clk_period*1;
			
			


      -- insert stimulus here 

      wait;
   end process;

END;
