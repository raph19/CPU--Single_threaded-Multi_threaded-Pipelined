
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity decoder is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Dout : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end decoder;

architecture Behavioral of decoder is 

SIGNAL s_dout : STD_LOGIC_VECTOR (31 DOWNTO 0); 

begin
decode:
	for i in 0 to 31 generate 
		s_dout(i)<= '1' when Awr = i else
					 '0';
	end generate;

Dout <= s_dout after 10 ns; 
end Behavioral;

