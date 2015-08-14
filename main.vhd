library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( 
           mode : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  out_view : out STD_LOGIC_VECTOR (7 downto 0);
			  out_next_btn : in STD_LOGIC
			  );
end main;

architecture Behavioral of main is

component comp_xchg is
    Port ( clk,reset,mode  : in  STD_LOGIC;
			  in_1 : in  STD_LOGIC_VECTOR (7 downto 0);
           in_2 : in  STD_LOGIC_VECTOR (7 downto 0);
           out_1 : out  STD_LOGIC_VECTOR (7 downto 0);
           out_2 : out  STD_LOGIC_VECTOR (7 downto 0));
end component comp_xchg;

component debounce is
   port(
      clk, reset: in std_logic;
      sw: in std_logic;
      db_level, db_tick: out std_logic
   );
end component debounce ;

signal un0, un1, un2, un3, un4, un5, un6, un7  : STD_LOGIC_VECTOR (7 downto 0);
signal out_index : integer range 0 to 7;
signal counter : integer range 0 to 200000000;
signal debounced_btn: std_logic;
signal s00,s01,s02,s03,s04,s05,s06,s07,s10,s12,s14,s16,s11,s13,s15,s17,s21,s22,s25,s26,s30,s34,s31,s35,s32,s36,s33,s37,s42,s44,s43,s45,s51,s52,s53,s54,s55,s56 :  STD_LOGIC_VECTOR (7 downto 0);

begin
-- inputs
un0 <= "11100001";
un1 <= "11100001";
un2 <= "11100100";
un3 <= "00001000";
un4 <= "00010000";
un5 <= "01000001";
un6 <= "01000001";
un7 <= "11000010";

-- stage 1
cx0: comp_xchg port map(clk,reset,mode,un0,un1,s00,s01);
cx1: comp_xchg port map(clk,reset,mode,un2,un3,s02,s03);
cx2: comp_xchg port map(clk,reset,mode,un4,un5,s04,s05);
cx3: comp_xchg port map(clk,reset,mode,un6,un7,s06,s07);
-- stage 2
cx4: comp_xchg port map(clk,reset,mode,s00,s02,s10,s12);
cx5: comp_xchg port map(clk,reset,mode,s04,s06,s14,s16);
cx6: comp_xchg port map(clk,reset,mode,s01,s03,s11,s13);
cx7: comp_xchg port map(clk,reset,mode,s05,s07,s15,s17);
-- stage 3
cx8: comp_xchg port map(clk,reset,mode,s11,s12,s21,s22);
cx9: comp_xchg port map(clk,reset,mode,s15,s16,s25,s26);
-- stage 4
cx10: comp_xchg port map(clk,reset,mode,s10,s14,s30,s34);
cx11: comp_xchg port map(clk,reset,mode,s21,s25,s31,s35);
cx12: comp_xchg port map(clk,reset,mode,s22,s26,s32,s36);
cx13: comp_xchg port map(clk,reset,mode,s13,s17,s33,s37);
-- stage 5
cx14: comp_xchg port map(clk,reset,mode,s32,s34,s42,s44);
cx15: comp_xchg port map(clk,reset,mode,s33,s35,s43,s45);
-- stage 6
cx16: comp_xchg port map(clk,reset,mode,s31,s42,s51,s52);
cx17: comp_xchg port map(clk,reset,mode,s43,s44,s53,s54);
cx18: comp_xchg port map(clk,reset,mode,s45,s36,s55,s56);

db: debounce port map(clk,reset,out_next_btn,open,debounced_btn);

process(clk, reset)
begin
if reset ='0' then 
	out_view <= (others => '0');
	out_index <= 0;
elsif clk'event and clk ='1' then
	if debounced_btn = '1' then
		out_index <= out_index + 1;
	end if;
	case out_index is
		when 0 => out_view <= s30;
		when 1 => out_view <= s51;
		when 2 => out_view <= s52;
		when 3 => out_view <= s53;
		when 4 => out_view <= s54;
		when 5 => out_view <= s55;
		when 6 => out_view <= s56;
		when 7 => out_view <= s37;
	end case;
end if;
end process;

end Behavioral;
