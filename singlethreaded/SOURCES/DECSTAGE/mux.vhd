
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.myRegister.all;

entity mux is
    Port ( Input : in  registers;
           sel : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end mux;
 
architecture Behavioral of mux is

SIGNAL s_input : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin
 
 Output <= Input (to_integer(unsigned(sel))) after 10 ns;			 

end Behavioral;

