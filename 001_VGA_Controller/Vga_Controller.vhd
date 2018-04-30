library IEEE;
use IEEE.std_logic_1164.All;


entity Vga_Controller is
	-- Parameter values can be set by using the table in the appendix.
	Generic(
				-- Generics for horizontal signal
				g_Horiz_Disp : integer := 640 ;
				g_Horiz_FP : integer := 16 ;
				g_Horiz_Sync : integer := 96;
				g_Horiz_BP : integer := 48;
				g_Horiz_Pol : std_logic := '0';
				-- Generics for vertical signal
				g_Vert_Disp : integer := 480;
				g_Vert_FP : integer := 10;
				g_Vert_Sync : integer := 2;
				g_Vert_BP : integer := 33;
				g_Vert_Pol : std_logic := '0'
	
				);
	Port(
			-- Input pins for VGA_Controller
			i_Pixel_Clk : in std_logic;
			i_Reset : in std_logic;
			-- Output pins for VGA_Controller
			o_Disp_En : out std_logic;
			o_Dir_Blnk : out std_logic;
			o_Sync_Green : out std_logic;
			o_HS : out std_logic;
			o_VS : out std_logic;
			o_Row_Count : out integer ;
			o_Column_Count : out integer 			
			);

end Vga_Controller;



architecture arch of Vga_Controller is
	constant c_Horiz_Period : integer := g_Horiz_BP + g_Horiz_Disp + g_Horiz_FP + g_Horiz_Sync ;
	constant c_Vert_Period : integer := g_Vert_BP + g_Vert_Disp + g_Vert_FP + g_Vert_Sync ;
begin
	process(i_Pixel_Clk)
		variable v_Horiz_Count : integer range 0 to c_Horiz_Period-1 := 0;
		variable v_Vert_Count : integer range 0 to c_vert_Period-1 := 0;
	begin
		-- Initiate the Direck Blank and sync on green as 0 meaning will not be used
		o_Dir_Blnk <= '1';
		o_Sync_Green <= '0';
		if(i_Reset = '1') then
			v_Horiz_Count := 0 ;
			v_Vert_Count := 0;
			o_HS <= '0';
			o_VS <= '0';
			o_Disp_En <= '0';
			o_Column_Count <= 0;
			o_Row_Count <= 0;
		
		-- At every rising edge of the i_Pixel_Clk
		elsif(i_Pixel_Clk'event and i_Pixel_Clk = '1') then
			
			-- Counters	
			if(v_Horiz_Count < c_Horiz_Period-1) then
					v_Horiz_Count := v_Horiz_Count + 1;	
				else
					v_Horiz_Count := 0;
						if(v_Vert_Count < c_Vert_Period-1) then
						v_Vert_Count := v_Vert_Count + 1;
						else
						v_Vert_Count := 0;
						end if;
			end if;
			 
			-- HS pulse generation
				if(v_Horiz_Count < (g_Horiz_Disp+g_Horiz_FP+g_Horiz_Sync) and v_Horiz_Count >  (g_Horiz_Disp+g_Horiz_FP)) then
					o_HS <= not g_Horiz_Pol ;
				else
					o_HS <= g_Horiz_Pol;
				end if;
		
			-- VS pulse generation
				if(v_Vert_Count < (g_Vert_Disp+g_Vert_FP+g_Vert_Sync) and v_Vert_Count >  (g_Vert_Disp+g_Vert_FP)) then
					o_VS <= not g_Vert_Pol ;
				else
					o_VS <= g_Vert_Pol;
				end if;
			
			-- Row_count generation
				if(v_Vert_Count < g_Vert_Disp) then
					o_Row_Count <= v_Vert_Count;
				end if;
				
			-- Column_count generation
				if(v_Horiz_Count < g_Horiz_Disp) then
					o_Column_Count <= v_Horiz_Count;
				end if;
				
			-- Display enable generation
				if(v_Horiz_Count < g_Horiz_Disp and v_Vert_Count < g_Vert_Disp) then
					o_Disp_En <= '1';
				else
					o_Disp_En <= '0';
				end if;
		end if;
	end process;
end arch;