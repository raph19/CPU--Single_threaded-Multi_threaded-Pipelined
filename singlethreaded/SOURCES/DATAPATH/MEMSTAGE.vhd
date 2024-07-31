
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEMSTAGE is
    Port ( ByteOp: in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 DOWNTO 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 DOWNTO 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

component memCLOUD
    Port ( input : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

SIGNAL  s_ALU_MEM_Addr : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

MM_WrEn <= MEM_WrEN;
s_ALU_MEM_Addr <= ALU_MEM_Addr + 4;
MM_Addr <= s_ALU_MEM_Addr;
MEM_DataOut <= MM_RdData;

DataOut : memCLOUD 
	port map ( input => MEM_DataIn,
				  sel => ByteOp,
				  output => MM_WrData);
				 
end Behavioral;

