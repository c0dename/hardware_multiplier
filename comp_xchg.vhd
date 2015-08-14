----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:03 04/10/2013 
-- Design Name: 
-- Module Name:    comp_xchg - Behavioral 
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

entity comp_xchg is
    Port ( clk,reset,mode  : in  STD_LOGIC;
				in_1 : in  STD_LOGIC_VECTOR (7 downto 0);
           in_2 : in  STD_LOGIC_VECTOR (7 downto 0);
           out_1 : out  STD_LOGIC_VECTOR (7 downto 0);
           out_2 : out  STD_LOGIC_VECTOR (7 downto 0));
end comp_xchg;

architecture Behavioral of comp_xchg is

begin

process(clk,reset)
begin
if reset = '0' then
	out_1 <= (others => '0');
	out_2 <= (others => '0');
elsif clk'event and clk ='1' then
	if (mode = '1') then -- ascending
		if in_1 < in_2 then
				out_1 <= in_1;
				out_2 <= in_2;
		else 					
			out_1 <= in_2;
			out_2 <= in_1;
		end if;
	else					 -- descending
		if in_1 < in_2 then
					out_1 <= in_2;
					out_2 <= in_1;
		else 					
				out_1 <= in_1;
				out_2 <= in_2;
		end if;
	end if;
end if;
end process;
end Behavioral;
