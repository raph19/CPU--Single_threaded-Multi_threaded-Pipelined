
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY IFSTAGE_TB IS
END IFSTAGE_TB;
 
ARCHITECTURE behavior OF IFSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
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
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
	signal Instr : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant Clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          PC => PC
        );

memory : MEM
      port map (clk => Clk,
					 inst_addr => PC(12 DOWNTO 2),
					 inst_dout => Instr,
			       data_we => '0',
					 data_addr => "00000000000",
					 data_din => "00000000000000000000000000000000",
					 data_dout =>open);	

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
      PC_Immed<="00000000000000000000000000000000"; 
		PC_Sel<='0'; 
		PC_LdEn<='0';
		Reset<='1';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000001";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000010";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000011";
		PC_Sel<='1';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000100";
		PC_Sel<='1';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000101"; 
		PC_Sel<='1';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000110";
		PC_Sel<='1';
		PC_LdEn<='0';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000000111";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;	

		PC_Immed<="00000000000000000000000000001000";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;

		PC_Immed<="00000000000000000000000000001001";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
