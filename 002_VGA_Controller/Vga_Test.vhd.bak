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
			i_Mode : in std_logic_vector (2 downto 0);
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0)
			);
end Vga_Test;


architecture arch of Vga_Test is
	type t_matrix is array (0 to 7) of std_logic_vector(7 downto 0);
	signal Pattern_Red : t_matrix ;
	signal Pattern_Green : t_matrix ;
	signal Pattern_Blue : t_matrix ;

begin
	-- Mode select
		process(i_Dist_Ena,i_Mode)
		begin
			if(i_Dist_Ena = '1') then
				case i_Mode is
					when "000" =>
						o_Red <= Pattern_Red(0);
						o_Green <= Pattern_Green(0);
						o_Blue <= Pattern_Blue(0);
					when "001" =>
						o_Red <= Pattern_Red(1);
						o_Green <= Pattern_Green(1);
						o_Blue <= Pattern_Blue(1);
					when "010" =>
						o_Red <= Pattern_Red(2);
						o_Green <= Pattern_Green(2);
						o_Blue <= Pattern_Blue(2);
					when "011" =>
						o_Red <= Pattern_Red(3);
						o_Green <= Pattern_Green(3);
						o_Blue <= Pattern_Blue(3);
					when "100" =>
						o_Red <= Pattern_Red(4);
						o_Green <= Pattern_Green(4);
						o_Blue <= Pattern_Blue(4);
					when "101" =>
						o_Red <= Pattern_Red(5);
						o_Green <= Pattern_Green(5);
						o_Blue <= Pattern_Blue(5);
					when "110" =>
						o_Red <= Pattern_Red(6);
						o_Green <= Pattern_Green(6);
						o_Blue <= Pattern_Blue(6);
					when others	=>
						o_Red <= Pattern_Red(7);
						o_Green <= Pattern_Green(7);
						o_Blue <= Pattern_Blue(7);
					end case;				
			else
				o_Red <=(others => '0');
				o_Green <=(others => '0');
				o_Blue <=(others => '0');
			end if;
		end Process;
		
		
	-------------------------------------------------------
	-- 							Pattern 1
	-------------------------------------------------------
		Pattern_Red(0) <= (others => '1')  ;
		Pattern_Green(0) <= (others => '0') ;
		Pattern_Blue(0) <= (others => '0');

	-------------------------------------------------------
	-- 							Pattern 2
	-------------------------------------------------------
		Pattern_Red(1) <= (others => '0') ;
		Pattern_Green(1) <= (others => '1') ;
		Pattern_Blue(1) <= (others => '0') ;
	
	-------------------------------------------------------
	-- 							Pattern 3
	-------------------------------------------------------
		Pattern_Red(2) <=  (others => '0');
		Pattern_Green(2) <= (others => '0') ;
		Pattern_Blue(2) <= (others => '1') ;
	
	-------------------------------------------------------
	-- 							Pattern 4
	-------------------------------------------------------
		Pattern_Red(3) <=  (others => '1') when ( i_Column_Num < g_Total_Column/4) else 
								 (others => '0');
		Pattern_Green(3) <= (others => '1') when ( i_Column_Num > g_Total_Column/4 - 1 and i_Column_Num <  g_Total_Column/2 ) else 
								 (others => '0'); 
		Pattern_Blue(3) <= (others => '1') when ( i_Column_Num > g_Total_Column/2 - 1) else 
								 (others => '0'); 
	
	-------------------------------------------------------
	-- 							Pattern 5
	-------------------------------------------------------
		Pattern_Red(4) <=  (others => '1') when ( i_Row_Num < g_Total_Row/4 ) else 
								 (others => '0');
		Pattern_Green(4) <= (others => '1') when ( i_Row_Num > g_Total_Row/4 - 1 and i_Row_Num <  g_Total_Row/2 ) else 
								 (others => '0'); 
		Pattern_Blue(4) <= (others => '1') when ( i_Row_Num > g_Total_Row/2 - 1) else 
								 (others => '0'); 
	-------------------------------------------------------
	-- 							Pattern 6
	-------------------------------------------------------
		Pattern_Red(5) <= (others => '1') when (i_Column_Num(5) = '0' xor
                                          i_Row_Num(5) = '1') else
                    (others => '0'); 
		Pattern_Green(5) <= Pattern_Red(5) ;
		Pattern_Blue(5) <=  Pattern_Red(5);
	-------------------------------------------------------
	-- 							Pattern 7
	-------------------------------------------------------
		Pattern_Red(6) <= (others => '1') when (i_Column_Num(6) = '0' xor
                                          i_Row_Num(6) = '1') else
                    (others => '0'); 
		Pattern_Green(6) <= Pattern_Red(6) ;
		Pattern_Blue(6) <=  Pattern_Red(6);
	-------------------------------------------------------
	-- 							Pattern 8
	-------------------------------------------------------
		Pattern_Red(7) <= (others => '1') when (i_Column_Num(7) = '0' xor
                                          i_Row_Num(7) = '1') else
                    (others => '0'); 
		Pattern_Green(7) <= Pattern_Red(7) ;
		Pattern_Blue(7) <=  Pattern_Red(7);
		
end arch;