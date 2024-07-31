--------------------------------------------------------------------------------
-- Company: 
-- Engineer:

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEMtest IS
END MEMtest;
 
ARCHITECTURE behavior OF MEMtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM
    PORT(
         clk : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_addr : IN  std_logic_vector(10 downto 0);
         data_din : IN  std_logic_vector(31 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_we : std_logic := '0';
   signal data_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_din : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
   signal data_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM PORT MAP (
          clk => clk,
          inst_addr => inst_addr,
          inst_dout => inst_dout,
          data_we => data_we,
          data_addr => data_addr,
          data_din => data_din,
          data_dout => data_dout
        );

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
			inst_addr <= "00000000000";
         data_we <= '0';
         data_addr <= "00000000000";
         data_din <="00000000000000000000000000000000";
			wait for 100 ns;	
		
			inst_addr <= "00000000001";
         data_we <= '1';
         data_addr <= "00000000000";
         data_din <="00000000000000000000000000000010";			
			wait for 100 ns;	
		
			inst_addr <= "00000000011";
         data_we <= '1';
         data_addr <= "00000000001";
         data_din <="00000000000000000000000000000001";			
			wait for 100 ns;	
		
			inst_addr <= "00000000100";
         data_we <= '1';
         data_addr <= "00000000010";
         data_din <="00000000000000000000000000000010";			
			wait for 100 ns;	
		
			inst_addr <= "00000000101";
         data_we <= '1';
         data_addr <= "00000000011";
         data_din <="00000000000000000000000000000011";			
			wait for 100 ns;	
		
			inst_addr <= "00000000110";
         data_we <= '1';
         data_addr <= "00000000100";
         data_din <="00000000000000000000000000000100";			
			wait for 100 ns;	
		
			inst_addr <= "00000000111";
         data_we <= '1';
         data_addr <= "00000000101";
         data_din <="00000000000000000000000000000101";			
			wait for 100 ns;	
		
			inst_addr <= "00000001000";
         data_we <= '0';
         data_addr <= "00000000110";
         data_din <="00000000000000000000000000000110";			
			wait for 100 ns;	
		
			inst_addr <= "00000001001";
         data_we <= '1';
         data_addr <= "00000000111";
         data_din <="00000000000000000000000000000111";			
			wait for 100 ns;	
		
			inst_addr <= "00000001010";
         data_we <= '1';
         data_addr <= "00000001000";
         data_din <="00000000000000000000000000001000";			
			wait for 100 ns;

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
