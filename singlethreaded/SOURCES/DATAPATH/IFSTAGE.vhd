
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component REG
		port( CLK : in  STD_LOGIC;
            RST : in  STD_LOGIC;
            WE : in  STD_LOGIC;
            Datain : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
            Dataout : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

component mux2x1
    Port ( a : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

SIGNAL  adderout : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  adder4out : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  muxout : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  PCout : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

thePC : REG
		port map (CLK => Clk,
                RST => Reset,
					 WE => PC_LdEn,
                Datain => muxout,
                Dataout => PCout);
MUX : mux2x1
		port map (a => adder4out,
					 b => adderout,
					 sel => PC_sel,
					 output => muxout);

adderout <= adder4out + PC_Immed;
adder4out <= PCout + 4;			
PC<=PCout;
		 
end Behavioral;
