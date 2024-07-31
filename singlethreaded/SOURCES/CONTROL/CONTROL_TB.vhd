
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ALU_zero : IN  std_logic;
         ByteOp : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         Rst : IN  std_logic;
         Clk : IN  std_logic 
        );
    END COMPONENT;
    

   --Inputs
   signal ALU_zero : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal ByteOp : std_logic;
   signal MEM_WrEn : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_Sel,
          ImmExt => ImmExt,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn,
          Instr => Instr,
          Rst => Rst,
          Clk => Clk
        );

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
      Rst <= '1';
		wait for 40 ns; 

	
		Rst <= '0';
		Instr <= "10000000000000000000000000110000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000110001";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000110010";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000110011";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000110100";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000110101";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000110110";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000111000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000111001";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000111010";
		wait for 40 ns;
		

		Rst <= '0';
		Instr <= "10000000000000000000000000111100";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "10000000000000000000000000111101";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "11100000000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
	   Instr <= "11100100000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "11000000000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "11001000000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "11001100000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "11111100000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "00000000000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "00000100000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "00001100000000000000000000000000";
	   	wait for 40 ns;
		
		Rst <= '0';
		Instr <= "00011100000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "00111100000000000000000000000000";
		wait for 40 ns;
		
		Rst <= '0';
		Instr <= "01111100000000000000000000000000";
		wait for 40 ns;	

      wait for Clk_period*10;
 
      -- insert stimulus here 

      wait;
   end process;

END;
