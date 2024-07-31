
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PROC_SC is
	port ( Clk : in STD_LOGIC;
			 Reset : in STD_LOGIC);
end PROC_SC;

architecture Behavioral of PROC_SC is  
   
component DATAPATH  
	 Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           RF_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_Sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
           ALU_zero : out  STD_LOGIC;
			  ByteOp: in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           MM_WrEn : out  STD_LOGIC;--mem
           MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0));--mem
end component;

component CONTROL 
	 Port ( PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
         
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           ImmExt : out  STD_LOGIC_VECTOR (1 DOWNTO 0);
			  
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 DOWNTO 0);
           ALU_zero : in  STD_LOGIC;

			  ByteOp: out  STD_LOGIC;
			  
           MEM_WrEn : out STD_LOGIC;
			  
			  Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end component;

component MEM
	port ( clk : in std_logic;
			 inst_addr : in std_logic_vector(10 downto 0);
			 inst_dout : out std_logic_vector(31 downto 0);
			 data_we : in std_logic;
			 data_addr : in std_logic_vector(10 downto 0);
			 data_din : in std_logic_vector(31 downto 0);
			 data_dout : out std_logic_vector(31 downto 0));
end component;		

SIGNAL s_PC_sel,s_PC_LdEn,s_RF_WrEn,s_RF_WrData_sel,s_RF_B_sel,s_ALU_Bin_sel,s_ALU_zero,s_ByteOp,s_MEM_WrEn,s_MM_WrEn : STD_LOGIC;
SIGNAL s_PC,s_Instr,s_MM_Addr,s_MM_WrData,s_MM_RdData : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL s_ALU_func : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL s_ImmExt : STD_LOGIC_VECTOR (1 DOWNTO 0);

begin

d : DATAPATH 
	port map( PC_sel => s_PC_sel,
             PC_LdEn => s_PC_LdEn,
             RF_WrEn => s_RF_WrEn,
             RF_WrData_sel => s_RF_WrData_sel,
             RF_B_sel => s_RF_B_sel, 
             ImmExt => s_ImmExt,
             ALU_Bin_sel => s_ALU_Bin_sel,
             ALU_func => s_ALU_func,
             ALU_zero => s_ALU_zero,
			    ByteOp => s_ByteOp,
             MEM_WrEn => s_MEM_WrEn, 
			    Instr => s_Instr,
             Reset => Reset,
             Clk => Clk,
             PC => s_PC,
             MM_Addr => s_MM_Addr,
             MM_WrEn => s_MM_WrEn,
             MM_WrData => s_MM_WrData,
             MM_RdData => s_MM_RdData);
c : CONTROL
	port map (PC_sel => s_PC_sel,
             PC_LdEn => s_PC_LdEn,
             RF_WrEn => s_RF_WrEn,
             RF_WrData_sel => s_RF_WrData_sel,
             RF_B_sel => s_RF_B_sel,
             ImmExt => s_ImmExt,
             ALU_Bin_sel => s_ALU_Bin_sel,
             ALU_func => s_ALU_func,
             ALU_zero => s_ALU_zero,
			    ByteOp => s_ByteOp,
             MEM_WrEn => s_MEM_WrEn,
			    Instr => s_Instr,
             Rst => Reset,
             Clk => Clk);
m : MEM
	port map (clk => Clk,
				 inst_addr => s_PC(12 downto 2),
				 inst_dout => s_Instr,
				 data_we => s_MM_WrEn,
				 data_addr => s_MM_Addr(12 downto 2),
				 data_din => s_MM_WrData,
				 data_dout => s_MM_RdData);

end Behavioral;

