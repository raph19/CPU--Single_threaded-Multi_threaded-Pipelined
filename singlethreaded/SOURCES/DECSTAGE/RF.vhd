
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.myRegister.all;

entity RF is
    Port ( CLK : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Awr : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Din : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           WrEn : in  STD_LOGIC;
			  Rst : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is

component REG
		port( CLK : in  STD_LOGIC;
            RST : in  STD_LOGIC;
            WE : in  STD_LOGIC;
            Datain : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
            Dataout : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;
component decoder
		port( Awr : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
            Dout : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;
component mux
		port( Input : in  registers;
				sel : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
				Output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;


SIGNAL  s_we  : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_decoderout : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Dout : registers;
		  
begin
	decoder1 : decoder 
		port map (Awr => Awr,
					 Dout => s_decoderout );
	
	Register0 : REG
		port map (CLK => CLK,
                RST => Rst,
					 WE => '1',
                Datain =>"00000000000000000000000000000000",
                Dataout => s_Dout(0));
		
	
	generate_registers:
	for i in 1 to 31 generate
		s_we(i) <= WrEn AND s_decoderout(i)  after 2ns;
		Register31 : REG
			Port Map (CLK=>CLK,
						 Datain=>Din,
						 RST => Rst,
						 WE=>s_we(i),
						 Dataout=>s_Dout(i));
	end generate;
		
	mux1: mux 
		port map (Input => s_Dout,
					sel => Ard1,
					Output => Dout1);
	 
	
	mux2 : mux 
		port map (Input => s_Dout,
				  sel => Ard2,
				  Output => Dout2);
	
	
	  
	  

end Behavioral;

