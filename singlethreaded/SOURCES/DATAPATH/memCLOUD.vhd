library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity memCLOUD is
    Port ( input : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end memCLOUD;

architecture Behavioral of memCLOUD is

begin
process (sel,input) is
begin
 if (sel='0') then
	output<=input;
 elsif (sel='1') then --zeroFill
	output(31 DOWNTO 8)<="000000000000000000000000";
	output(7 DOWNTO 0)<= input(7 DOWNTO 0);
 end if;
end process;

end Behavioral;

