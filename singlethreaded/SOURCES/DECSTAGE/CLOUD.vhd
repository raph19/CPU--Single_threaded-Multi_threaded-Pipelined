
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLOUD is
    Port ( a : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (15 DOWNTO 0);
           output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end CLOUD;

architecture Behavioral of CLOUD is

begin
process (a,b) is
begin
 if (a="10") then --sign extend 
	output (15 DOWNTO 0) <= b;
	output (31 DOWNTO 16) <= (others => b(15));
 elsif (a="11") then --sign extend,olisthisi 
	output(17 DOWNTO 2) <= b;
	output(31 DOWNTO 18) <= (others => b(15));
	output (1 DOWNTO 0) <= "00";
 elsif (a="00") then --zero fill
	output (31 DOWNTO 16) <= "0000000000000000";
	output(15 DOWNTO 0) <= b;
 elsif (a="01") then--zero fill,olisthisi
	output (31 DOWNTO 16) <= b;
	output(15 DOWNTO 0) <= "0000000000000000";
 end if;
end process;

end Behavioral;

