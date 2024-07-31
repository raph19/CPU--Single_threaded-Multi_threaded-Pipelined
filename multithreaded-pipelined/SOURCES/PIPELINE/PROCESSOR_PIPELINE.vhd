
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PROCESSOR_PIPELINE is
	port ( Clk : in STD_LOGIC;
			 Reset : in STD_LOGIC;
			 PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			 Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			 MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			 MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
          MM_WrEn : out  STD_LOGIC;--mem
          MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0));--mem
end PROCESSOR_PIPELINE;

architecture Behavioral of PROCESSOR_PIPELINE is

component DATAPATH_PIPELINE
	 Port ( PC_sel : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  r_Instr : out STD_LOGIC_VECTOR (31 DOWNTO 0 );
           RF_B_Sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           ALU_zero : out  STD_LOGIC;
			  control_out : in STD_LOGIC_VECTOR (8 DOWNTO 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           MM_WrEn : out  STD_LOGIC;--mem
           MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0));--mem
end component;

component CONTROL_PIPELINE
	 Port ( PC_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           ImmExt : out  STD_LOGIC_VECTOR (1 DOWNTO 0);
			  output : out STD_LOGIC_VECTOR (8 DOWNTO 0);
           ALU_zero : in  STD_LOGIC;
			  Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end component;

SIGNAL s_PC_sel,s_PC_LdEn,s_RF_B_sel,s_ALU_zero: STD_LOGIC;
signal s_Instr : std_logic_vector (31 downto 0);
SIGNAL s_control : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL s_ImmExt : STD_LOGIC_VECTOR (1 DOWNTO 0);


begin
d : DATAPATH_PIPELINE
	port map( PC_sel => s_PC_sel,
             RF_B_sel => s_RF_B_sel, 
             ImmExt => s_ImmExt,
				 control_out => s_control,
             ALU_zero => s_ALU_zero,
			    Instr => Instr,
				 r_Instr => s_Instr,
             Reset => Reset,
             Clk => Clk,
             PC => PC,
             MM_Addr => MM_Addr,
             MM_WrEn => MM_WrEn,
             MM_WrData => MM_WrData,
             MM_RdData => MM_RdData);
				 
c : CONTROL_PIPELINE
	port map (PC_sel => s_PC_sel,
             RF_B_sel => s_RF_B_sel,
             ImmExt => s_ImmExt,
				 output => s_control,
             ALU_zero => s_ALU_zero,
			    Instr => s_Instr,
             Rst => Reset,
             Clk => Clk);


end Behavioral;

