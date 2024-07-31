
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY REGtest IS
END REGtest;
 
ARCHITECTURE behavior OF REGtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          Datain => Datain,
          Dataout => Dataout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      RST <= '1';
		WE <= '1';
		Datain <= "00000000001000000000000000001100";
      wait for 100 ns;
		
		RST <= '0';
		WE <= '1';
		Datain <= "00000000001000000000000000001100";
      wait for 100 ns;	
		
		RST <= '0';
		WE <= '0';
		Datain <= "00000000001000000000000000001111";
      wait for 100 ns;	
		
		RST <= '0';
		WE <= '1';
		Datain <= "00000000001000000000000000001111";
      wait for 100 ns;	
		
		RST <= '1';
		WE <= '0';
		Datain <= "00000000000000000000000000011111";
      wait for 100 ns;	
		
		RST <= '0';
		WE <= '1';
		Datain <= "00000000000000000000000000001100";
      wait for 100 ns;	
		
		RST <= '0';
		WE <= '0';
		Datain <= "00000000001000000000000000011100";
      wait for 100 ns;	
		
		RST <= '1';
		WE <= '0';
		Datain <= "00000000001000000000000000001100";
      wait for 100 ns;	
		
		RST <= '0';
		WE <= '1';
		Datain <= "00000000001000000000000000001111";
      wait for 100 ns;	
		
		RST <= '0';
		WE <= '1';
		Datain <= "00000000001000000000000001111100";
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
