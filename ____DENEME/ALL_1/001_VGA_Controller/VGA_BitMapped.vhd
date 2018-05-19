 library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;
entity Vga_BitMapped is
	Port(
			i_Dist_Ena : in Std_logic;
			i_Row_Num : in std_logic_vector (9 downto 0) ;
			i_Column_Num : in std_logic_vector (9 downto 0);

			
			i_xPos : in std_logic_vector (9 downto 0);
			i_yPos : in std_logic_vector (9 downto 0);
			--i_Length : in std_logic_vector(3 downto 0);	-- sonradan ekliycem bunu
			
			o_RGB : out std_logic_vector (5 downto 0);	-- 5-4 : R, 3-2 : G ,1-0 : B
			o_Disp_Ena : out Std_logic
			);
end Vga_BitMapped;


architecture arch of Vga_BitMapped is

	constant BALL_SIZE: unsigned (9 downto 0):= (3=>'1' ,others=>'0');
	-- ball left and right boundary
	signal shape_x_left, shape_x_right: unsigned(9 downto 0);
	-- ball top and bottom boundary
	signal shape_y_top, shape_y_bottom: unsigned(9 downto 0);
	-- round ball image ROM
	type rom_type is array(0 to 7) of
	std_logic_vector(0 to 7); 
	constant BALL_ROM: rom_type:= (
	"00111100",
	"01111110",
	"11111111", 
	"11111111", 
	"11111111", 
	"11111111",
	"01111110",
	"00111100");
		
	signal rom_addr, rom_col: unsigned(2 downto 0);
	signal rom_data: std_logic_vector(7 downto 0);
	signal rom_bit: std_logic;
	-- new signal to indicate if scan coord is within ball
	signal shape_disp_on: std_logic;
	signal shape_area_on : std_logic;

begin

	--
	shape_y_top <= unsigned(i_Column_Num);
	shape_x_left <=unsigned(i_Row_Num);
	shape_y_bottom <= unsigned(i_Column_Num) + BALL_SIZE;
	shape_x_right <= unsigned(i_Row_Num) + BALL_SIZE;
	
	-- scan coordinate within square ball.
	shape_area_on <= '1' when	(shape_x_left <= unsigned(i_Column_Num)) and 
										(unsigned(i_Column_Num) <= shape_x_right) and
										(shape_y_top <= unsigned(i_Row_Num)) and 
										(unsigned(i_Row_Num) <= shape_y_bottom) else 
						  '0';
					
	-- map scan coord to ROM addr/col
	rom_addr <= unsigned(i_Row_Num(2 downto 0)) - shape_y_top(2 downto 0);
	rom_col <= unsigned(i_Column_Num(2 downto 0)) - shape_x_left(2 downto 0);
	rom_data <= BALL_ROM(to_integer(rom_addr));
	rom_bit <= rom_data(to_integer(rom_col));
	shape_disp_on <= '1' when (shape_area_on = '1') and (rom_bit = '1') and (i_Dist_Ena = '1')else 
	              '0';


	-- The color of the shape
	o_RGB <= "110000";
	

		
	
	
end arch;