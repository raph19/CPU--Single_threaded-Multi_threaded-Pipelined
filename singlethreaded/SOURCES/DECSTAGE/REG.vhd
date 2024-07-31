
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity REG is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Dataout : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end REG;

architecture Behavioral of REG is
signal s_dataout : STD_LOGIC_VECTOR (31 DOWNTO 0);
begin

	process
	begin
		wait until CLK'event and CLK='1';
		if RST='1' then 
			s_dataout <= "00000000000000000000000000000000";
		elsif WE='1' then 
			s_dataout <= Datain;
		else
		   s_dataout <= s_dataout;
		end if;
	end process;	
	
	Dataout <= s_dataout after 10ns;
end Behavioral;
