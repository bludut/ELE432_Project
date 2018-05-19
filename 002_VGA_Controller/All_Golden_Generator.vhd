library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;
entity All_Golden_Generator is
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
			
			Cnst_2Gold : in std_logic_vector(9 downto 0);
			Cnst_3Gold : in std_logic_vector(9 downto 0);
			Cnst_4Gold : in std_logic_vector(9 downto 0);		
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			o_Disp_Ena : out std_logic
			);
end All_Golden_Generator;


architecture arch of All_Golden_Generator is

	------------------------------------------------------------------
	-- GOLDEN GENERATOR
	------------------------------------------------------------------
	component Golden_Generator is
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
	end component Golden_Generator;
		
--	constant Cnst_2Car : std_logic_vector(9 downto 0) := "00" & X"C8";		-- Second Car offset = 200 
--	constant Cnst_3Car : std_logic_vector(9 downto 0) := "00" & X"C8";		-- Second Car offset = 200
--	constant Cnst_3Car : std_logic_vector(9 downto 0) := "00" & X"C8";		-- Second Car offset = 200

	

	signal o_Golden_Disp_Ena : std_logic_vector(3 downto 0);
begin

	-- 1st Golden
Golden1:component Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => i_Dist_Ena,
			i_Row_Num => i_Row_Num,
			i_Column_Num => i_Column_Num,
			i_Pos_X => i_Pos_X,
			i_Pos_Y => i_Pos_Y,
			
			o_Red => o_Red,
			o_Green => o_Green,
			o_Blue => o_Blue,
			o_Disp_Ena => o_Golden_Disp_Ena(0)
			);
			
	-- Second Car
Car2:component Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => i_Dist_Ena,
			i_Row_Num => i_Row_Num,
			i_Column_Num => i_Column_Num,
			i_Pos_X => i_Pos_X,
			i_Pos_Y => i_Pos_Y + Cnst_2Gold,
			
			o_Red => open,
			o_Green => open,
			o_Blue => open,
			o_Disp_Ena => o_Golden_Disp_Ena(1)
			);
			
	-- Third Car
Car3:component Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => i_Dist_Ena,
			i_Row_Num => i_Row_Num,
			i_Column_Num => i_Column_Num,
			i_Pos_X => i_Pos_X,
			i_Pos_Y => i_Pos_Y + Cnst_3Gold,
			
			o_Red => open,
			o_Green => open,
			o_Blue => open,
			o_Disp_Ena => o_Golden_Disp_Ena(2)
			);
			
	-- 4th Car
Car4:component Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => i_Dist_Ena,
			i_Row_Num => i_Row_Num,
			i_Column_Num => i_Column_Num,
			i_Pos_X => i_Pos_X,	
			i_Pos_Y => i_Pos_Y + Cnst_4Gold,
			
			o_Red => open,
			o_Green => open,
			o_Blue => open,
			o_Disp_Ena => o_Golden_Disp_Ena(3)
			);
			
			
-- OR'ed display enable
	o_Disp_Ena <=  o_Golden_Disp_Ena(0) or
						o_Golden_Disp_Ena(1) or
						o_Golden_Disp_Ena(2) or
						o_Golden_Disp_Ena(3);
				

end arch;