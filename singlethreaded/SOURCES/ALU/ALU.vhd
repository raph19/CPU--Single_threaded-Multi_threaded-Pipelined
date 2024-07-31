
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Op : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
           Output : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

SIGNAL s_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL s_cout : STD_LOGIC;
SIGNAL s_zero : STD_LOGIC;
SIGNAL s_ovf : STD_LOGIC;

begin
process (A,B,s_out) is
begin
 case Op is
	when "0000" =>
	 s_out <= A + B;
	when "0001" =>
	 s_out <= A - B;
	when "0010" =>
	 s_out <= A AND B ;
	when "0011" =>
	 s_out <= A OR B;
	when "0100" =>
	 s_out <= NOT A;
	when "0110" =>
	 s_out <= A NOR B;
	when "0101" =>
	 s_out <= A NAND B;
	when "1000" =>
	 s_out(31) <= A(31) ;
	 s_out(30 DOWNTO 0) <= A(31 DOWNTO 1);
	when "1001" =>
	 s_out(0) <= '0' ;
	 s_out(31 DOWNTO 1) <= A(30 DOWNTO 0);
	when "1010" =>
	 s_out(31) <= '0' ;
	 s_out(30 DOWNTO 0) <= A(31 DOWNTO 1);
	when "1100" =>
	 s_out(0) <= A(31);
	 s_out(31 DOWNTO 1) <= A(30 DOWNTO 0);
	when "1101" =>
	 s_out(31) <= A(0) ;
	 s_out(30 DOWNTO 0) <= A(31 DOWNTO 1);
	when others =>
	 s_out <=B; 
end case;
end process;


process (A,B,s_out)
 begin
 
 
  if (s_out="00000000000000000000000000000000" AND s_cout='0') then s_zero<='1';
  else s_zero<='0';
  end if;
  
  
  if (A(31)='1' AND B(31)='1' AND Op="0000") then s_cout<='1';
  else s_cout<='0';
  end if;
  
  if (s_cout='1' OR ( B>A AND Op="0001")) then s_ovf<='1';
  else s_ovf<='0';
  end if;
 end process;

Cout<=s_cout;  
Output <= s_out after 10ns;
Ovf <= s_ovf after 10ns;
Zero <= s_zero after 10ns;

end Behavioral;

