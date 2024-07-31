
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
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
end CONTROL;

architecture Behavioral of CONTROL is
	type state is (RESET,A,B,C,D,E,F,li,lui,addi,nandi,ori,br,beq,bne,bez,bnez,lb,sb,lw,sw,end_state);
	signal s : state;
begin
	process 
	begin
	wait until Clk'event and Clk ='1';
		if (Rst='1') then 
			PC_LdEn  <= '0';
			RF_WrEn  <= '0';
			MEM_WrEn <= '0';
			s <= A;
		else
			case s is
				when A =>
					RF_WrEn  <= '0';
					MEM_WrEn <= '0';
					if (Instr(31 downto 26)="100000") then
						s <= B;
					elsif (Instr(31 downto 27)="11100") then
						s <= C;
					elsif (Instr(31 downto 29)="110") then
						s <= D;
					elsif (Instr(31 downto 26)="111111") or (Instr(31 downto 26)="000000") or (Instr(31 downto 26)="000001") then
						s <= E;
					elsif (Instr(31 downto 26)="000011") or (Instr(31 downto 26)="000111") or (Instr(31 downto 26)="001111")  or (Instr(31 downto 26)="011111") then
						s <= F; 
					else 
						s <=end_state;
					end if;
				when B =>
					PC_sel     <= '0'; 
					PC_LdEn    <= '1';
					RF_WrEn    <= '1';
					RF_WrData_sel<= '0';
					RF_B_sel   <= '0';
					ALU_Bin_sel<= '0';
					ALU_func   <= Instr(3 downto 0);
					s          <= end_state ;
				when C =>
					PC_sel     <= '0'; 
					PC_LdEn    <= '1';
					RF_WrEn    <= '1';
					RF_B_sel   <= '0';
					ALU_Bin_sel<= '1';
					ALU_func   <= "1111";
					if (Instr(26)='1') then
						s <= lui;
					else
						s <= li;
					end if;
				when li =>
					ImmExt <= "10";
					s <= end_state ;
				when lui =>
					ImmExt <= "01";
					s<= end_state ;
				when D =>
					PC_sel     <= '0'; 
					PC_LdEn    <= '1';
					RF_WrEn    <= '1';
					RF_B_sel   <= '0';
					ALU_Bin_sel<= '1';
					if (Instr(27 downto 26)="00") then 
						s <= addi;
					elsif (Instr(27 downto 26)="10") then 
						s <= nandi;
					elsif (Instr(27 downto 26)="11") then 
						s <= ori ;
					end if;
				when addi =>
					ALU_func <= "0000";
					ImmExt <= "10";
					s <= end_state ;
				when nandi =>
					ALU_func <= "0101";
					ImmExt <= "00";
					s <= end_state ;
				when ori =>
					ALU_func <= "0011";
					ImmExt <= "00";
					s <= end_state ;
				when E => 
					PC_LdEn    <= '1';
					RF_WrData_sel<= '0';
					ALU_Bin_sel<= '0';
					ImmExt     <= "11";
					if (Instr(27 downto 26) = "11") then
						s <= br;
					elsif (Instr(27 downto 26) = "00") then
						s <= beq;
					elsif (Instr(27 downto 26) = "01") then
						s<= bne;
					end if;
				when br =>
					PC_LdEn <= '1';
					s       <= end_state ;
				when beq =>
					RF_B_sel <= '1';
					ALU_func <= "0001";
					if (ALU_zero='0') then
						s <= bez ;
					else
						s <= bnez;
					end if;
				when bez =>
					PC_sel <= '1';
					s <= end_state ;
				when bnez =>
					PC_sel <= '0';
					s <= end_state ;
				when bne =>
					RF_B_sel <= '1';
					ALU_func <= "0001";
					if (ALU_zero='0') then
						s <= bez;
					else
						s <= bnez;
					end if;
				when F =>
					ALU_func   <= "0000";
					ImmExt     <= "10";
					PC_sel     <= '0';
					PC_LdEn    <= '0';
					ALU_Bin_sel<= '1';
					if (Instr(31 downto 26)="000011" or Instr(31 downto 26)="001111") then
						RF_WrEn 		  <= '1';
						RF_WrData_sel <= '1';
						RF_B_sel      <= '0';
						if (Instr(29)='1') then
							s <= lw;
						else
							s <= lb;
						end if;
					else
						RF_WrEn 		  <= '0';
						RF_WrData_sel <= '0';
						RF_B_sel      <= '1';
						MEM_WrEn      <= '1';
						if (Instr(29)='1') then
							s <= sw;
						else
							s <= sb;
						end if;
					end if;
				when lb =>
					ByteOp <= '1';
					s <= end_state ;
				when sb =>
					ByteOp <= '1';
					s <= end_state ;
				when lw =>
					ByteOp <= '0';
					s <= end_state ;
				when sw =>
					ByteOp <= '0';
					s <= end_state ;
				when end_state =>
					PC_LdEn <= '0';
					s <= A;
				when others => s <= A;
			end case;
		end if;	
	end process;
end Behavioral;

