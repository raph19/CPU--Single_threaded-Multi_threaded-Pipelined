
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_Sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_A : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_B : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component RF
    Port ( CLK : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Awr : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Din : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           WrEn : in  STD_LOGIC;
			  Rst : in  STD_LOGIC);
end component;

component mux2x1on5
    Port ( a : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (4 DOWNTO 0));
end component;

component mux2x1
    Port ( a : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;
 
component CLOUD
	 port ( a : in STD_LOGIC_VECTOR (1 DOWNTO 0);
			  b : in STD_LOGIC_VECTOR (15 DOWNTO 0);
			  output : out STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

SIGNAL  mux1out : STD_LOGIC_VECTOR (4 DOWNTO 0);
SIGNAL  mux2out : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

DECRF : RF
	port map( CLK => Clk,
             Ard1 => Instr(25 DOWNTO 21),
				 Ard2 => mux1out, 
				 Awr => Instr(20 DOWNTO 16),
             Dout1 => RF_A,
				 Dout2 => RF_B,
				 Din => mux2out,
				 WrEn => RF_WrEn,
				 Rst => '0');

mux1 : mux2x1on5
	port map( a => Instr(15 DOWNTO 11),
				 b => Instr(20 DOWNTO 16),
				 sel => RF_B_sel,
				 output => mux1out);

mux2 : mux2x1
	port map( a => ALU_out,
				 b => MEM_out,
				 sel => RF_WrData_sel,
				 output => mux2out);	
IMM : CLOUD		
	port map( a => ImmExt,
				 b => Instr(15 DOWNTO 0),
				 output => Immed);

end Behavioral;
