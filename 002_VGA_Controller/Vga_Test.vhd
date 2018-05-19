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
	constant X_LENGTH : std_logic_vector(9 downto 0) := "00" & X"32";
	constant Y_LENGTH : std_logic_vector(9 downto 0) := "00" & X"4B";

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
		
---------------------------------------------------Headlight Genarator
			if(i_Dist_Ena = '1' and 
				(i_Row_Num <= (i_Pos_Y + X"05") and i_Row_Num >= s_Pos_Y) and 
				((i_Column_Num <= (i_Pos_X + X"0F")and i_Column_Num >= s_Pos_X + X"05") or		-- left
				  ((i_Column_Num <= (i_Pos_X) + X"2D")and i_Column_Num >= s_Pos_X + X"23")))then  -- right
					o_Disp_Ena <= '1';
					o_Red <=(others => '1');
					o_Green <=(others => '1');
					o_Blue <=(others => '1');
			
--------------------------------------------------- Gear Genarator
			elsif(i_Dist_Ena = '1' and 
				((i_Row_Num <= (i_Pos_Y + X"19")and i_Row_Num >= s_Pos_Y + X"0A") or
				  (i_Row_Num <= (i_Pos_Y + X"41")and i_Row_Num >= s_Pos_Y + X"32")) and
			
				((i_Column_Num <= (i_Pos_X + X"05")and i_Column_Num >= s_Pos_X) or		
				  (i_Column_Num <= (i_Pos_X + X"32")and i_Column_Num >= s_Pos_X + X"2D")))then
					o_Disp_Ena <= '1';
					o_Red <=("10011111");
					o_Green <=("10011111");
					o_Blue <=(others => '0');
---------------------------------------------------
			elsif(i_Dist_Ena = '1' and 
				  (i_Row_Num <= (i_Pos_Y + X"4B")and i_Row_Num >= s_Pos_Y) and
			     (i_Column_Num <= (i_Pos_X + X"2D")and i_Column_Num >= s_Pos_X + X"05"))then
					o_Disp_Ena <= '1';
					o_Red <=(others => '0');
					o_Green <=(others => '0');
					o_Blue <=(others => '1');
			else
					o_Disp_Ena <= '0';
			end if;
			
		end Process;
end arch;