------ALAKSAME TO EXSTAGE OSTE NA MPORI NA ILOPIITHI TO FORWARDING.
-----PROSTHESAME DIO POLIPLEKTES GIA NA GINETE I SOSTI PRAKSI GIA KATHE
-----INSTRUCTION, ME VASI TA SIMATA APO TI FORWARD VATHMIDA.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EXSTAGE_2 is
	 Port ( RF_A : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  C : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  A : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_B : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Immed : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  FRW_A : in std_logic_vector ( 1 downto 0);
			  FRW_B : in std_logic_vector ( 1 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           ALU_zero : out  STD_LOGIC);
end EXSTAGE_2;

architecture Behavioral of EXSTAGE_2 is


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

component mux4
    Port ( a : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  c : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  d : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           sel : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;		  

SIGNAL  muxout : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  muxoutB : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  muxoutA : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin
mux : mux2x1
	port map( a => RF_B,
				 b => Immed,
				 sel => ALU_Bin_sel,
				 output => muxout);	

muxA : mux4
	port map (a => A,
				 b => RF_A,
				 c => C,
				 d => "00000000000000000000000000000000",
				 sel => FRW_A,
				 output => muxoutA);
				 
muxB : mux4
	port map (a => A,
				 b => muxout,
				 c => C,
				 d => "00000000000000000000000000000000",
				 sel => FRW_B,
				 output => muxoutB);

EXALU : ALU
	port map( A => muxoutA,
             B => muxoutB,
             Op => ALU_func,
             Output => ALU_out,
             Zero => ALU_zero,
             Cout => open,
             Ovf => open);

end Behavioral;

