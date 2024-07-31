
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_B : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Immed : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           ALU_zero : out  STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is

component ALU
    Port ( A : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Op : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
           Output : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

component mux2x1
    Port ( a : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;			  

SIGNAL  muxout : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin
mux : mux2x1
	port map( a => RF_B,
				 b => Immed,
				 sel => ALU_Bin_sel,
				 output => muxout);	

EXALU : ALU
	port map( A => RF_A,
             B => muxout,
             Op => ALU_func,
             Output => ALU_out,
             Zero => ALU_zero,
             Cout => open,
             Ovf => open);

end Behavioral;

