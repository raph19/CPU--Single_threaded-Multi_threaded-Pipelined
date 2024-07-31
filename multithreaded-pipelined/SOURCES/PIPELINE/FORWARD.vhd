
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FORWARD is
	Port (rs_2 : in STD_LOGIC_VECTOR (4 DOWNTO 0); 
			rt_2 : in STD_LOGIC_VECTOR (4 DOWNTO 0);
			rd_3 : in STD_LOGIC_VECTOR (4 DOWNTO 0);
			rd_4 : in STD_LOGIC_VECTOR (4 DOWNTO 0);
			RegWrite3 : in STD_LOGIC;
			RegWrite4 : in STD_LOGIC;
			FRW_A : out STD_LOGIC_VECTOR (1 DOWNTO 0);
			FRW_B : out STD_LOGIC_VECTOR (1 DOWNTO 0));
end FORWARD;

architecture Behavioral of FORWARD is

begin
	process(rs_2, rt_2, rd_3, rd_4, RegWrite3, RegWrite4)
	begin
		if (RegWrite3='1' and rd_3/="00000" and rd_3 = rs_2) then
			FRW_A <= "10";
		elsif (RegWrite4='1' and rd_4/="00000" and rd_4 = rs_2) then 
			FRW_A <= "00";
		else
			FRW_A <= "01";
		end if;

		if (RegWrite3='1' and rd_3/="00000" and rd_3 = rt_2) then 
			FRW_B <= "10";
		elsif (RegWrite4='1' and rd_4/="00000" and rd_4 = rt_2) then 
			FRW_B <= "00";
		else
			FRW_B <= "01";
		end if;
	end process;
end Behavioral;

