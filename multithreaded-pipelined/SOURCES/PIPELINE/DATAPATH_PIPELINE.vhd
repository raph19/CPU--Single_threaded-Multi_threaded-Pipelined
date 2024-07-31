
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DATAPATH_PIPELINE is
	 Port ( PC_sel : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  Instr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
			  r_Instr : out STD_LOGIC_VECTOR (31 DOWNTO 0 );
           RF_B_Sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 DOWNTO 0);
           ALU_zero : out  STD_LOGIC;
         --RF_WrEn : in  STD_LOGIC;--
         --RF_WrData_sel : in  STD_LOGIC;--
			--ByteOp: in  STD_LOGIC;--
         --MEM_WrEn : in  STD_LOGIC;--
         --ALU_func : in  STD_LOGIC_VECTOR (3 DOWNTO 0);--
         --ALU_Bin_sel : in  STD_LOGIC;--
			  control_out : in STD_LOGIC_VECTOR (8 DOWNTO 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           MM_WrEn : out  STD_LOGIC;--mem
           MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0);--mem
           MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0));--mem
end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is
Component IFSTAGE 
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

component EXSTAGE_2
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
END COMPONENT;

component REG9
	Port (  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (8 DOWNTO 0);
           Dataout : out  STD_LOGIC_VECTOR (8 DOWNTO 0));
end component;
			  
component FORWARD
	Port (rs_2 : in STD_LOGIC_VECTOR (4 DOWNTO 0); 
			rt_2 : in STD_LOGIC_VECTOR (4 DOWNTO 0);
			rd_3 : in STD_LOGIC_VECTOR (4 DOWNTO 0);
			rd_4 : in STD_LOGIC_VECTOR (4 DOWNTO 0);
			RegWrite3 : in STD_LOGIC;
			RegWrite4 : in STD_LOGIC;
			FRW_A : out STD_LOGIC_VECTOR (1 DOWNTO 0);
			FRW_B : out STD_LOGIC_VECTOR (1 DOWNTO 0));
end component;

component STALL
	Port ( Clk : IN STD_LOGIC;
			 Reset : IN STD_LOGIC;
			 rt_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 rs_1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 rt_2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 MemRead : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			 PC_LdEn : OUT STD_LOGIC;
			 en : OUT STD_LOGIC);
END component;

SIGNAL  s_control_2 : STD_LOGIC_VECTOR (8 DOWNTO 0);
SIGNAL  s_control_3 : STD_LOGIC_VECTOR (8 DOWNTO 0);
SIGNAL  s_control_4 : STD_LOGIC_VECTOR (8 DOWNTO 0);
SIGNAL  s_Immed : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Immed_2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Instr_1 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Instr_2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Instr_3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_Instr_4 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_RF_A : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_A_2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_RF_B : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_B_2 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_B_3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_ALU_out : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_ALU_out3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_ALU_out4 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_MEM_out : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_MEM_out4 : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL  s_PC_LdEn : STD_LOGIC;
SIGNAL  s_en_1 : STD_LOGIC;
SIGNAL  s_FRW_A : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL  s_FRW_B : STD_LOGIC_VECTOR (1 DOWNTO 0);



begin

IFF : IFSTAGE
	port map ( PC_Immed => s_Immed_2,
				  PC_sel => PC_sel,
              PC_LdEn => s_PC_LdEn,
              Reset => Reset,
              Clk => Clk,
              PC => PC);
				  
instr_1 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => s_en_1,
             Datain => Instr,
             Dataout => s_Instr_1);

DEC : DECSTAGE
	Port map ( Instr => s_Instr_1,
              RF_WrEn => s_control_4(8),
              ALU_out => s_ALU_out4,
              MEM_out => s_MEM_out4,
              RF_WrData_sel => s_control_4(7),
              RF_B_Sel => RF_B_Sel,
              ImmExt => ImmExt,
              Clk => Clk, 
              Immed => s_Immed,
              RF_A => s_RF_A,
              RF_B => s_RF_B);
				  
control_reg_2 : REG9
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => control_out,
             Dataout => s_control_2);

instr_2 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_Instr_2,
             Dataout => s_Instr_3);

A_2 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_RF_A,
             Dataout => s_A_2);
				 
B_2 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_RF_B,
             Dataout => s_B_2);
				 
Immed_2 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_Immed,
             Dataout => s_Immed_2);

EX : EXSTAGE_2
	port map ( RF_A => s_A_2,
              RF_B => s_B_2,
				  C => s_ALU_out3,
				  A => s_ALU_out4,
              Immed => s_Immed_2,
				  FRW_A => s_FRW_A,
				  FRW_B => s_FRW_B,
              ALU_Bin_sel => s_control_2(0),
              ALU_func => s_control_2(4 DOWNTO 1),
              ALU_out => s_ALU_out,
              ALU_zero => ALU_zero);

control_reg_3 : REG9
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_control_2,
             Dataout => s_control_3);
				 
instr_3 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_Instr_2,
             Dataout => s_Instr_3);
				  
ALU_out_3 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_ALU_out,
             Dataout => s_ALU_out3);

B_3 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_B_2,
             Dataout => s_B_3);				 


MEM : MEMSTAGE
	Port map ( ByteOp => s_control_3(6),
              MEM_WrEn =>  s_control_3(5),
              ALU_MEM_Addr => s_ALU_out3,
              MEM_DataIn => s_B_3,
              MEM_DataOut => s_MEM_out,
              MM_Addr =>  MM_Addr,
              MM_WrEn => MM_WrEn,
              MM_WrData => MM_WrData,
              MM_RdData => MM_RdData);

control_reg_4 : REG9
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_control_3,
             Dataout => s_control_4);
				 
instr_4 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_Instr_3,
             Dataout => s_Instr_4);

ALU_out_4 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_ALU_out3,
             Dataout => s_ALU_out4);
				  
MEM_out_4 : REG
	port map (CLK => Clk,
             RST => Reset,
             WE => '1',
             Datain => s_MEM_out,
             Dataout => s_MEM_out4);	
				 
frw : FORWARD
	Port map (rs_2 => s_Instr_2(25 DOWNTO 21),
				 rt_2 => s_Instr_2(15 DOWNTO 11),
				 rd_3 => s_Instr_3(20 DOWNTO 16),
				 rd_4 => s_Instr_4(20 DOWNTO 16),
				 RegWrite3 => s_control_3(8),
				 RegWrite4 => s_control_4(8),
				 FRW_A => s_FRW_A,
				 FRW_B => s_FRW_B);

stl : STALL
	Port map (Clk => Clk,
				 Reset => Reset,
				 rt_1 => s_Instr_1(15 DOWNTO 11),
				 rs_1 => s_Instr_1(25 DOWNTO 21),
				 rt_2 => s_Instr_2(15 DOWNTO 11),
				 MemRead => Instr(31 DOWNTO 26),
				 PC_LdEn => s_PC_LdEn,
				 en => s_en_1);
				 
r_Instr <= s_Instr_1;

end Behavioral;

