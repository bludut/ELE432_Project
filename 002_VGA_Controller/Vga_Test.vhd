library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;
entity Vga_Test is
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
end Vga_Test;


architecture arch of Vga_Test is
	constant X_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20";
	constant Y_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20";

	signal s_Pos_Y,s_Pos_X : std_logic_vector(9 downto 0);
begin
	-- Mode select
		process(i_Dist_Ena,i_Pos_Y,i_Pos_X,i_Row_Num,i_Column_Num)
		begin
		if(signed(i_Pos_Y) < 0 and std_logic_vector(abs(signed(i_Pos_Y))) <= Y_LENGTH) then
			
			s_Pos_Y <= (others => '0' );
		else
			s_Pos_Y <= i_Pos_Y;
		end if;
		
		if(signed(i_Pos_X) < 0 and std_logic_vector(abs(signed(i_Pos_X))) <= X_LENGTH) then
			s_Pos_X <= (others => '0' );
		else
			s_Pos_X <= i_Pos_X;
		end if;
		
		
			if(i_Dist_Ena = '1' and 
				i_Row_Num <= (i_Pos_Y + Y_LENGTH)and i_Row_Num >= s_Pos_Y and
				i_Column_Num <= (i_Pos_X + X_LENGTH)and i_Column_Num >= s_Pos_X) then
					o_Disp_Ena <= '1';
			else
					o_Disp_Ena <= '0';
			end if;
		end Process;
		
		o_Red <=(others => '1');
		o_Green <=(others => '0');
		o_Blue <=(others => '0');
							
	
end arch;