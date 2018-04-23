-- SW9 low	(active high reset)
-- SW8 high (active low reset)

library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;

entity Vga_Top_Design is
	port(
			i_Clk : in std_logic;
			i_Rst : in std_logic;
			i_Mode : in std_logic_vector(2 downto 0);
			i_VGA_Reset : in std_logic;
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			
			o_ADV_Sync : out std_logic;
			o_ADV_Blank : out std_logic;
			o_ADV_Clk : out std_logic;
			o_HS : out std_logic;
			o_VS : out std_logic
	);

end Vga_Top_Design;

architecture arch of Vga_Top_Design is

	------------------------------------------------------------------
	--					Pll Components
	-------------------------------------------------------------------
  component Pll_50_to_25 is
        port (
            clk_clk           : in  std_logic := 'X'; -- clk
            reset_reset_n     : in  std_logic := 'X'; -- reset_n
            pll_0_outclk0_clk : out std_logic         -- clk
        );
    end component Pll_50_to_25;
	
	------------------------------------------------------------------
	--					VGA_Controller Components
	-------------------------------------------------------------------
	component Vga_Controller is
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
	end component Vga_Controller;

	------------------------------------------------------------------
	--						VGA_Test Component
	------------------------------------------------------------------
	component Vga_Test is
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
	end component Vga_Test;
	
	
signal pixel_clk : std_logic;	
signal disp_en : std_logic;
signal row_count : integer;
signal column_count : integer;

begin

-- ADV clock connection
	o_ADV_Clk <= pixel_clk;

	
	-- PLL connections		
		    u0 : component Pll_50_to_25
        port map (
            clk_clk           => i_Clk,           --           clk.clk
            reset_reset_n     => i_Rst,     --         reset.reset_n
            pll_0_outclk0_clk => pixel_clk  -- pll_0_outclk0.clk
        );

		  
	-- Vga_Controller Connections
u1 : component Vga_Controller
			generic map(
			
				g_Horiz_Disp => 640 ,
				g_Horiz_FP => 16 ,
				g_Horiz_Sync =>  96,
				g_Horiz_BP =>  48,
				g_Horiz_Pol =>  '0',

				g_Vert_Disp =>  480,
				g_Vert_FP =>  10,
				g_Vert_Sync =>  2,
				g_Vert_BP =>  33,
				g_Vert_Pol =>  '0'			
			)
			port map(
			i_Pixel_Clk 	=> pixel_clk,
			i_Reset 			=> i_VGA_Reset,
			o_Disp_En		=> disp_en ,
			o_Dir_Blnk 		=> o_ADV_Blank,
			o_Sync_Green 	=> o_ADV_Sync,
			o_HS 				=> o_HS,
			o_VS 				=> o_VS,
			o_Row_Count 	=> row_count,
			o_Column_Count => column_count
			);
			
	-- Vga_Test Connections
u2 : component Vga_Test
			generic map(
			g_Total_Row => 480,
			g_Total_Column => 640
			)
			port map(
			i_Dist_Ena		=> disp_en,
			i_Row_Num 		=> std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num	=> std_logic_vector(to_unsigned(column_count,10)),
			i_Mode 			=> i_Mode,
			o_Red 			=> o_Red,
			o_Green 			=> o_Green,
			o_Blue 			=> o_Blue			
			);
end arch;