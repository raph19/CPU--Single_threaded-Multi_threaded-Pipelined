
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity DATAPATH_MC is
	 Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  r_Instr : out STD_LOGIC_VECTOR (31 DOWNTO 0 );
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
end DATAPATH_MC;

architecture Behavioral of DATAPATH_MC is

component IFSTAGE 
	 Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

component DECSTAGE
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
end component;

component EXSTAGE
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RF_B : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Immed : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           ALU_zero : out  STD_LOGIC);
end component;

component MEMSTAGE
    Port ( ByteOp: in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

component REG
	Port (  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           Dataout : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

SIGNAL  s_Immed : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Instr : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_RF_A : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_A : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_RF_B : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_B : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_ALU_out : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_ALU_out2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_MEM_out : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_MEM_out2 : STD_LOGIC_VECTOR (31 DOWNTO 0);


begin

IFF : IFSTAGE
	port map ( PC_Immed => s_Immed,
				  PC_sel => PC_sel,
              PC_LdEn => PC_LdEn,
              Reset => Reset,
              Clk => Clk,
              PC => PC);
				  
instruction : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => Instr,
             Dataout => s_Instr);

DEC : DECSTAGE
	Port map ( Instr => s_Instr,
              RF_WrEn => RF_WrEn,
              ALU_out => s_ALU_out2,
              MEM_out => s_MEM_out2,
              RF_WrData_sel => RF_WrData_sel,
              RF_B_Sel => RF_B_Sel,
              ImmExt => ImmExt,
              Clk => Clk, 
              Immed => s_Immed,
              RF_A => s_RF_A,
              RF_B => s_RF_B);

A : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_RF_A,
             Dataout => s_A);
				 
B : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_RF_B,
             Dataout => s_B);

EX : EXSTAGE
	port map ( RF_A => s_A,
              RF_B => s_B,
              Immed => s_Immed,
              ALU_Bin_sel => ALU_Bin_sel,
              ALU_func => ALU_func,
              ALU_out => s_ALU_out,
              ALU_zero => ALU_zero);
				  
ALU_out : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_ALU_out,
             Dataout => s_ALU_out2);				  


MEM : MEMSTAGE
	Port map ( ByteOp => ByteOp,
              MEM_WrEn =>  MEM_WrEn,
              ALU_MEM_Addr => s_ALU_out2,
              MEM_DataIn => s_B,
              MEM_DataOut => s_MEM_out,
              MM_Addr =>  MM_Addr,
              MM_WrEn => MM_WrEn,
              MM_WrData => MM_WrData,
              MM_RdData => MM_RdData);
				  
MEM_out : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_MEM_out,
             Dataout => s_MEM_out2);	
				 
r_Instr <= s_Instr;

end Behavioral;

