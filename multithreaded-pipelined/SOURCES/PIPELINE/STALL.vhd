
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity STALL is
	Port ( Clk : IN STD_LOGIC;
			 Reset : IN STD_LOGIC;
			 rt_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 rs_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 rt_2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 MemRead : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			 PC_LdEn : OUT STD_LOGIC;
			 en : OUT STD_LOGIC);
end STALL;

architecture Behavioral of STALL is
	type state is (A,B,C);
	signal s : state;
begin
	process 
	begin
	wait until Clk'event and Clk ='1';
		if (Reset='1') then 
			s <= A;
		else
			case s is
				when A =>
					if ( MemRead = "001111" AND (rt_2 = rs_1 OR rt_2 = rt_1)) then
						PC_LdEn <= '0';
						en <= '1';
						s <= B;
					else 
						PC_LdEn <= '1';
						en <= '1';
						s <= A;
					end if;
				when B =>
					PC_LdEn <= '0';
					en <= '0';
					s <= A;
				when others =>
					s<=A;
			end case;
		end if;
	end process;
end Behavioral;

