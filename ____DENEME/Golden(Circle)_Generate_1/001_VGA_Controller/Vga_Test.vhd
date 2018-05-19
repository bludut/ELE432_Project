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
			i_Pos_X : in std_logic_vector(9 downto 0); --araba position
			i_Pos_Y : in std_logic_vector(9 downto 0);
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			o_Disp_Ena : out std_logic
			);
end Vga_Test;


architecture arch of Vga_Test is
	--constant X_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20"; --araba uzunluğu
	--constant Y_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20";
     
	  constant wdth : std_logic_vector(9 downto 0) :=   "0000000011";  --3
	  constant M_x : std_logic_vector(9 downto 0) :=    "0101000000";  --320
	  constant M_y : std_logic_vector(9 downto 0) :=    "0011110000";  --240
	  
	  constant radius1 : std_logic_vector(9 downto 0) := "0000011110"; --30
	  constant radius2 : std_logic_vector(9 downto 0) := "0001000110"; --70  
	  constant radius3 : std_logic_vector(9 downto 0) := "0001101110"; --110
	  constant radius4 : std_logic_vector(9 downto 0) := "0010010110"; --150
	  constant radius5 : std_logic_vector(9 downto 0) := "0010111110"; --190
	  constant radius6 : std_logic_vector(9 downto 0) := "0011100110"; --230
	  
	  
	signal s_Pos_Y,s_Pos_X : std_logic_vector(9 downto 0);
begin
	-- Mode select
		process(i_Dist_Ena,i_Pos_Y,i_Pos_X,i_Row_Num,i_Column_Num)
		begin
			if(i_Dist_Ena = '1' and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) >=  radius1*radius1 ) and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <=  (radius1+wdth)*(radius1+wdth))) then
					o_Disp_Ena <= '1';
			
			elsif(i_Dist_Ena = '1' and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) >=  radius2*radius2 ) and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <=  (radius2+wdth)*(radius2+wdth))) then
					o_Disp_Ena <= '1';
			
			elsif(i_Dist_Ena = '1' and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) >=  radius3*radius3 ) and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <=  (radius3+wdth)*(radius3+wdth))) then
					o_Disp_Ena <= '1';
			
			elsif(i_Dist_Ena = '1' and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) >=  radius4*radius4 ) and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <=  (radius4+wdth)*(radius4+wdth))) then
					o_Disp_Ena <= '1';
			
			elsif(i_Dist_Ena = '1' and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) >=  radius5*radius5 ) and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <=  (radius5+wdth)*(radius5+wdth))) then
					o_Disp_Ena <= '1';
			
			elsif(i_Dist_Ena = '1' and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) >=  radius6*radius6 ) and 
				(std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <=  (radius6+wdth)*(radius6+wdth))) then
					o_Disp_Ena <= '1';
			else
					o_Disp_Ena <= '0';
			end if;
		
		end Process;
		
		o_Red <=(others => '1');
		o_Green <=(others => '0');
		o_Blue <=(others => '0');
							
	
end arch;