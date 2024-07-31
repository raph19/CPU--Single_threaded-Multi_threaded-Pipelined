
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY RFtest IS
END RFtest;
 
ARCHITECTURE behavior OF RFtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         CLK : IN  std_logic;
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
			Rst : in  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
	signal Rst :   STD_LOGIC := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          CLK => CLK,
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
			 Rst => Rst
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
      Ard1 <= "00001";
      Ard2 <= "00000";
      Awr <= "00001";
      Din <= "00000000000000000000000000000101";
      WrEn <= '0';  
      Rst <= '1';	
		wait for 100 ns;	
		
		 Ard1 <= "00001";
      Ard2 <= "00000";
      Awr <= "00001";
      Din <= "00000000000000000000000000000001";
      WrEn <= '1'; 
      Rst <= '0';			
   	wait for 100 ns;
		
		Ard1 <= "00001";
      Ard2 <= "00010";
      Awr <= "00010";
      Din <= "00000000000000000000000000000010";
      WrEn <= '1';    
      Rst <= '0';	   
		wait for 100 ns;
		
		 Ard1 <= "00010";
      Ard2 <= "00011";
      Awr <= "00011";
      Din <= "00000000000000000000000000000011";
      WrEn <= '1';    
      Rst <= '0';	   		
		wait for 100 ns;
		
		 Ard1 <= "00011";
      Ard2 <= "00100";
      Awr <= "00100";
      Din <= "00000000000000000000000000000100";
      WrEn <= '1';     
      Rst <= '0';	    
		wait for 100 ns;	
		
		 Ard1 <= "00100";
      Ard2 <= "00000";
      Awr <= "00000";
      Din <= "00000000000000000000000000000001";
      WrEn <= '1';     
      Rst <= '0';	  
		wait for 100 ns;
		
		Ard1 <= "00101";
      Ard2 <= "00100";
      Awr <= "00101";
      Din <= "00000000000000000000000000000101";
      WrEn <= '1';    
      Rst <= '0';	   
		wait for 100 ns;
		
		Ard1 <= "00000";
      Ard2 <= "00110";
      Awr <= "00110";
      Din <= "00000000000000000000000000000110";
      WrEn <= '1';    
      Rst <= '0';	   
		wait for 100 ns;
		
		Ard1 <= "00110";
      Ard2 <= "00111";
      Awr <= "00111";
      Din <= "00000000000000000000000000000111";
      WrEn <= '1';     
      Rst <= '0';	  
		wait for 100 ns;
		
		Ard1 <= "00111";
      Ard2 <= "01000";
      Awr <= "01000";
      Din <= "00000000000000000000000000001000";
      WrEn <= '1';     
      Rst <= '0';	  
		wait for 100 ns;
		

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
