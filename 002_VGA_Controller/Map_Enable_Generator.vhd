library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;

entity Map_Enable_Generator is
	Generic(
				g_Total_Row : integer := 480;
				g_Total_Column : integer := 640
				);
	Port(
			i_Dist_Ena : in Std_logic;
			i_Row_Num : in std_logic_vector (9 downto 0) ;
			i_Column_Num : in std_logic_vector (9 downto 0);
			i_Pos_X : in std_logic_vector(9 downto 0);
			i_Pos_Y : in std_logic_vector(9 downto 0);
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			o_Disp_Ena : out std_logic
			);
end Map_Enable_Generator;


architecture arch of Map_Enable_Generator is
	constant Car_Col_1 : std_logic_vector(15 downto 0) := "1111000011110000";
	constant Car_Col_2 : std_logic_vector(15 downto 0) := (others=>'0');
	constant Car_Col_3 : std_logic_vector(15 downto 0) := (others=>'0');
	
	constant Y_LENGTH : std_logic_vector(15 downto 0) ;
	
	signal s_Pos_Y : std_logic_vector(9 downto 0);
	signal s_ControlClock : std_logic;

begin

s_ControlClock <= s_Pos_Y(6) xor  '1';

	process(s_ControlClock)
	begin
		if(rising_edge(s_ControlClock)) then
		
		end if;
	
	end process;

	
	
	
	
		process(i_Dist_Ena,i_Pos_Y,i_Pos_X,i_Row_Num,i_Column_Num)
		begin
		s_Pos_Y <= std_logic_vector(unsigned(i_Row_Num) - unsigned(i_Pos_Y));
		
		--   50         230                    410             590
		--            225 235                405 415 
		--         11100001  11101011    110010101  110011111
		--
			-- Road 
			if(i_Dist_Ena = '1' and 
				(s_Pos_Y(6) xor '1') = '1' and
				((i_Column_Num >= "011100001" and i_Column_Num <= "011101011") or (i_Column_Num >= "0110010101" and i_Column_Num <= "0110011111"))
				) then
					o_Disp_Ena <= '1';
					o_Red <=(others => '1');
					o_Green <=(others => '1');
					o_Blue <=(others => '1');
					-- Barriers left and right
			elsif(i_Dist_Ena = '1' and 
				(i_Column_Num <= "0000110010" or i_Column_Num >= "1001001110")) then
					o_Disp_Ena <= '1';
					
					o_Red <=(others => '0');
					o_Green <=(others => '1');
					o_Blue <=(others => '0');
			else
					o_Disp_Ena <= '0';
			end if;
			
		end Process;
								
	
end arch;