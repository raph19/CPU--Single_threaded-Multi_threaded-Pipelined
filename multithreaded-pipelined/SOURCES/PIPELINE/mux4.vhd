
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux4 is
    Port ( a : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  c : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  d : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           sel : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end mux4;

architecture Behavioral of mux4 is

begin
output <= a when sel="00" else
			 b when sel="01" else
			 c when sel="10" else
			 d when sel="11";

end Behavioral;

