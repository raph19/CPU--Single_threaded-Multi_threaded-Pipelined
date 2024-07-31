
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY ALUtest IS
END ALUtest;
 
ARCHITECTURE behavior OF ALUtest IS 
 
 
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
  --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		
		
		A <= "00000000000000000000000000001111" ;
		B <= "00000000000000000000000000000001" ;
		Op <= "0000" ;
		wait for 62 ns;	
			
      A <= "00000000000000000000000000010000" ;
		B <= "00000000000000000000000000000001" ;
		Op <= "0001" ;
      wait for 63 ns;	
		
		A <= "11111111111111111111111111111111" ;
		B <= "00000000000000000000000000000000" ;
		Op <= "0010" ;
      wait for 62 ns;	
		
		A <= "11111111111111111111111111111111" ;
		B <= "11111111111111111111111111111111" ;
		Op <= "0011" ;
      wait for 63 ns;	
		
		A <= "00000000000000000000000000000000" ;
		B <= "00000000000000000000000000000000" ;
		Op <= "0100" ;
      wait for 62 ns;	
		
		A <= "11111111111111111111111111111111" ;
		B <= "00000000000000000000000000000000" ;
		Op <= "0110" ;
      wait for 63 ns;	
		 
		A <= "10000000000000000000000000000000" ;
		B <= "00000000000000000000000000000000" ;
		Op <= "1000" ;
      wait for 62 ns;	
		
		A<= "11111111111111111111111111111111" ;
		B<= "00000000000000000000000000000000";
		Op<= "1001" ;
      wait for 63 ns;	
		
		A<= "10111111111111111111111111111111";
		B<= "00000000000000000000000000000000" ;
		Op<= "1010" ;
      wait for 62 ns;	
		
		A<= "11111111111111110000000000000000" ;
		B<= "00000000000000000000000000000000" ;
		Op<= "1100" ;
      wait for 63 ns;	
		
		A<= "00000000000000001111111111111111";
		B<= "00000000000000000000000000000000";
		Op<= "1101" ;
      wait for 62 ns;	
		
		A<= "00000000000000000000000000000000" ;
		B<= "00000000000000000000000000000000" ;
		Op<= "0000" ;
      wait for 63 ns;	
		
		A<= "00000000000000000000000010000000";
		B<=  "00000000000000000000000100000000";
		Op<= "0001" ;
      wait for 62 ns;	
		
		A<= "10000000000000000000000000000000" ;
		B<= "10000000000000000000000000000000" ;
		Op<= "0000" ;
      wait for 63 ns;	
		
		A<= "00000000000000000000000000000000" ;
		B<=  "11111111111111111111111111111111";
		Op<= "0001" ;
      wait for 62 ns;	
		
		
		A<= "11111111111111111111111111111111" ;
		B<= "11111111111111111111111111111111" ;
		Op<= "0000" ;
      wait for 63 ns;


      wait;
   end process;

END;
