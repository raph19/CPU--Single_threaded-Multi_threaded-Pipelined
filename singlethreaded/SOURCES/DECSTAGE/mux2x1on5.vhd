----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:56:16 03/25/2020 
-- Design Name: 
-- Module Name:    mux2x1on5 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2x1on5 is
    Port ( a : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(4 DOWNTO 0));
end mux2x1on5;

architecture Behavioral of mux2x1on5 is

begin
 output <= a when sel='0' else b;

end Behavioral;

