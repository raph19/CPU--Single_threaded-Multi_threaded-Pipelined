
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_TB IS
END DECSTAGE_TB;
 
ARCHITECTURE behavior OF DECSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_Sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_Sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_Sel => RF_B_Sel,
          ImmExt => ImmExt,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
     -- hold reset state for 100 ns.
		
		Instr<="11001100000000010000000000000000";
		RF_WrEn<='0';
		ALU_out<="00000000000000000000000000000001";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_B_Sel<='0';
		ImmExt <= "00";
      wait for 150 ns;
		
		
		Instr<="11001000000000010000011111111111";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000001";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_B_Sel<='1';
		ImmExt <= "00";
		
      wait for 150 ns;
		
		
		Instr<="11100100001000100000100001000001";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000000000000000000000000010";
		RF_WrData_Sel<='1';
		RF_B_Sel<='0';
		ImmExt <= "01";
      wait for 150 ns;
		
		
		Instr<="11100000010000110000011000000011";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000110";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_B_Sel<='0';
		ImmExt <= "10";
      wait for 150 ns;
		
		
		Instr<="11111100100001000001110000000001";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000000000000000000000000100";
		RF_WrData_Sel<='1';
		RF_B_Sel<='0';
		ImmExt <= "11";
      wait for 150 ns;
		
		
		Instr<="00000000110001010100011111111111";
		RF_WrEn<='0';
		ALU_out<="00000000000000000000000000000101";
		MEM_out<="11000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_B_Sel<='1';
		ImmExt <= "00";
      wait for 150 ns;	
		
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
