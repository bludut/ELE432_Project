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
			
			i_Btn_Up: in std_logic;
			i_Btn_Down: in std_logic;
			i_Btn_Right: in std_logic;
			i_Btn_Left: in std_logic;
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			
			o_ADV_Sync : out std_logic;
			o_ADV_Blank : out std_logic;
			o_ADV_Clk : out std_logic;
			o_HS : out std_logic;
			o_VS : out std_logic;
			
			o_Lost_LED : out std_logic
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
			i_Pos_X : in std_logic_vector(9 downto 0);
			i_Pos_Y : in std_logic_vector(9 downto 0);
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			o_Disp_Ena : out std_logic
			);
	end component Vga_Test;
	
	
	
	------------------------------------------------------------------
	-- WALL GENERATOR
	------------------------------------------------------------------
	component Wall_Cars_Generator is
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
			
			Cnst_2Car : in std_logic_vector(9 downto 0);
			Cnst_3Car : in std_logic_vector(9 downto 0);
			Cnst_4Car : in std_logic_vector(9 downto 0);	
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			o_Disp_Ena : out std_logic
			);
	end component Wall_Cars_Generator;
	
	
	------------------------------------------------------------------
	-- GOLDEN GENERATOR
	------------------------------------------------------------------	
	component All_Golden_Generator is
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
	end component All_Golden_Generator;
	
		
	----------------------------------------------------------------------
	--	ROAD GENERATOR
	----------------------------------------------------------------------
	component Road_Generator is
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
	end component;
	
	----------------------------------------------------------------------
	--	CRASH CONTROL
	----------------------------------------------------------------------
	component Crash_Control is
	port(
		i_clk : in std_logic;
		i_Wall_En :in  std_logic;
		i_Golden_En :in  std_logic;
		i_Car_En :in  std_logic;
		
		o_Lost :out  std_logic
	);
	end component;

	
signal pixel_clk : std_logic;	
signal disp_en : std_logic;
signal row_count : integer;
signal column_count : integer;

signal DisplaySelect : std_logic_vector(7 downto 0);



---------------------- 	RGB Outpus   --------------------------------
signal Red_Test,Green_Test,Blue_Test : std_logic_vector(7 downto 0);

signal Red_WALL1,Green_WALL1,Blue_WALL1 : std_logic_vector(7 downto 0);
signal Red_WALL2,Green_WALL2,Blue_WALL2 : std_logic_vector(7 downto 0);
signal Red_WALL3,Green_WALL3,Blue_WALL3 : std_logic_vector(7 downto 0);

signal Red_GOLD1,Green_GOLD1,Blue_GOLD1 : std_logic_vector(7 downto 0);
signal Red_GOLD2,Green_GOLD2,Blue_GOLD2 : std_logic_vector(7 downto 0);
signal Red_GOLD3,Green_GOLD3,Blue_GOLD3 : std_logic_vector(7 downto 0);

signal Red_Road,Green_Road,Blue_Road : std_logic_vector(7 downto 0);
----------------------------------------------------------------------   

-- Current X and Y positions of Car
signal s_Car_Pos_X,s_Car_Pos_Y : std_logic_vector(9 downto 0):= (others => '0');
signal s_Road_Pos_Y : std_logic_vector(9 downto 0):= (others => '0');

signal Refresh_Rate_Timer : unsigned(18 downto 0); -- 1100110100010100000
signal RefreshClock: std_logic:='0';
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
			i_Pos_X 			=> s_Car_Pos_X, --"00" & X"20",	-- Car_Length_X = 32	
			i_Pos_Y 			=> s_Car_Pos_Y, --"00" & X"20",	-- Car_Length_Y = 32	
			
			o_Red 			=> Red_Test  ,
			o_Green 			=> Green_Test  ,
			o_Blue 			=> Blue_Test	,
			o_Disp_Ena		=> DisplaySelect(0)
	);
	
	
------------------------------------     WALL GENERATOR FOR COLUMNS     -------------------------------
	-- Column1 => DisplaySelect(1)   Column2 => DisplaySelect(2)   Column3 => DisplaySelect(3) 
-------		-------		-------		-------		-------		-------		-------		-------		-------	
	-- Column1_Car_Generator
Column1_Car_Generator:component Wall_Cars_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => "0001110011",		-- 115 = b0001110011
			i_Pos_Y => s_Road_Pos_Y,
			
			Cnst_2Car => std_logic_vector(to_unsigned(200,10)),
			Cnst_3Car => std_logic_vector(to_unsigned(400,10)),
			Cnst_4Car => std_logic_vector(to_unsigned(600,10)),
			
			o_Red => Red_WALL1,
			o_Green => Green_WALL1,
			o_Blue => Blue_WALL1,
			o_Disp_Ena => DisplaySelect(1)
			);
-------		-------		-------		-------		-------		-------		-------		-------		-------
	-- Column2_Car_Generator
Column2_Car_Generator:component Wall_Cars_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => "0100100111",		-- 295 = b0100100111
			i_Pos_Y => s_Road_Pos_Y,
			
			Cnst_2Car => std_logic_vector(to_unsigned(200,10)),
			Cnst_3Car => std_logic_vector(to_unsigned(400,10)),
			Cnst_4Car => std_logic_vector(to_unsigned(600,10)),
			
			o_Red => Red_WALL2,
			o_Green => Green_WALL2,
			o_Blue => Blue_WALL2,
			o_Disp_Ena => DisplaySelect(2)
			);
-------		-------		-------		-------		-------		-------		-------		-------		-------			
		-- Column3_Car_Generator
Column3_Car_Generator:component Wall_Cars_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => "0111011011",		-- 475 = b0111011011
			i_Pos_Y => s_Road_Pos_Y,
			
			Cnst_2Car => std_logic_vector(to_unsigned(0,10)),
			Cnst_3Car => std_logic_vector(to_unsigned(400,10)),
			Cnst_4Car => std_logic_vector(to_unsigned(600,10)),
			
			o_Red => Red_WALL3,
			o_Green => Green_WALL3,
			o_Blue => Blue_WALL3,
			o_Disp_Ena => DisplaySelect(3)
			);
--------------------------------------------------------------------------------------------------------			
		
	
------------------------------------     GOLDEN GENERATOR FOR COLUMNS    -------------------------------
	-- Column1 => DisplaySelect(4)   Column2 => DisplaySelect(5)   Column3 => DisplaySelect(6) 
-------		-------		-------		-------		-------		-------		-------		-------		-------	
	-- Column1_Golden_Generator
Column1_Golden_Generator:component All_Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => "0001110011",		-- 115 = b0001110011
			i_Pos_Y => s_Road_Pos_Y,
			
			Cnst_2Gold => std_logic_vector(to_unsigned(100,10)),
			Cnst_3Gold => std_logic_vector(to_unsigned(300,10)),
			Cnst_4Gold => std_logic_vector(to_unsigned(500,10)),
			
			o_Red => Red_GOLD1,
			o_Green => Green_GOLD1,
			o_Blue => Blue_GOLD1,
			o_Disp_Ena => DisplaySelect(4)
			);
-------		-------		-------		-------		-------		-------		-------		-------		-------

	-- Column2_Golden_Generator
Column2_Golden_Generator:component All_Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => "0100100111",		-- 295 = b0100100111
			i_Pos_Y => s_Road_Pos_Y,
			
			Cnst_2Gold => std_logic_vector(to_unsigned(100,10)),
			Cnst_3Gold => std_logic_vector(to_unsigned(300,10)),
			Cnst_4Gold => std_logic_vector(to_unsigned(500,10)),
			
			o_Red => Red_GOLD2,
			o_Green => Green_GOLD2,
			o_Blue => Blue_GOLD2,
			o_Disp_Ena => DisplaySelect(5)
			);
-------		-------		-------		-------		-------		-------		-------		-------		-------

	-- Column3_Golden_Generator
Column3_Golden_Generator:component All_Golden_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => "0111011011",		-- 475 = b0111011011
			i_Pos_Y => s_Road_Pos_Y,
			
			Cnst_2Gold => std_logic_vector(to_unsigned(100,10)),
			Cnst_3Gold => std_logic_vector(to_unsigned(300,10)),
			Cnst_4Gold => std_logic_vector(to_unsigned(500,10)),
			
			o_Red => Red_GOLD3,
			o_Green => Green_GOLD3,
			o_Blue => Blue_GOLD3,
			o_Disp_Ena => DisplaySelect(6)
			);
-------		-------		-------		-------		-------		-------		-------		-------		-------


	-- Road_Generator
u4:component Road_Generator 
	Generic map(
				g_Total_Row => 480,
				g_Total_Column => 640
				)
	Port map(
			i_Dist_Ena => disp_en,
			i_Row_Num => std_logic_vector(to_unsigned(row_count,10)),
			i_Column_Num => std_logic_vector(to_unsigned(column_count,10)),
			i_Pos_X => (others => '0'),
			i_Pos_Y => s_Road_Pos_Y,
			
			o_Red => Red_Road,
			o_Green => Green_Road,
			o_Blue => Blue_Road,
			o_Disp_Ena => DisplaySelect(7)
			);		
	
	

------------------------------------------------------------------------------------------------------
--					MULTIPLEXER
------------------------------------------------------------------------------------------------------	
	
-- RED Multiplexer 	
		o_Red <= 	Red_Test when DisplaySelect(0)= '1' else
						Red_WALL1 when DisplaySelect(1)= '1' else
						Red_WALL2 when DisplaySelect(2)= '1' else
						Red_WALL3 when DisplaySelect(3)= '1' else
						Red_GOLD1 when DisplaySelect(4)= '1' else
						Red_GOLD2 when DisplaySelect(5)= '1' else
						Red_GOLD3 when DisplaySelect(6)= '1' else
						Red_Road when DisplaySelect(7)= '1' else
					(others=> '0');
-- GREEN Multiplexer 	
		o_Green <= 	Green_Test when DisplaySelect(0)= '1' else
						Green_WALL1 when DisplaySelect(1)= '1' else
						Green_WALL2 when DisplaySelect(2)= '1' else
						Green_WALL3 when DisplaySelect(3)= '1' else
						Green_GOLD1 when DisplaySelect(4)= '1' else
						Green_GOLD2 when DisplaySelect(5)= '1' else
						Green_GOLD3 when DisplaySelect(6)= '1' else
						Green_Road when DisplaySelect(7)= '1' else
		         (others=> '0');
-- BLUE Multiplexer 	
		o_Blue <= 	Blue_Test when DisplaySelect(0)= '1' else
						Blue_WALL1 when DisplaySelect(1)= '1' else
						Blue_WALL2 when DisplaySelect(2)= '1' else
						Blue_WALL3 when DisplaySelect(3)= '1' else
						Blue_GOLD1 when DisplaySelect(4)= '1' else
						Blue_GOLD2 when DisplaySelect(5)= '1' else
						Blue_GOLD3 when DisplaySelect(6)= '1' else
						Blue_Road when DisplaySelect(7)= '1' else
				   (others=> '0');	
		
------------------------------------------------------------------------------------------------------
-- 	MAP SHIFTER
------------------------------------------------------------------------------------------------------	
Map_Shift_Proc : process(RefreshClock,i_VGA_Reset)
begin
	if(i_VGA_Reset = '1') then
	   s_Road_Pos_Y <= (others => '0');
	elsif( rising_edge(RefreshClock)) then
	    s_Road_Pos_Y <= std_logic_vector(unsigned(s_Road_Pos_Y) + 1);
	end if;
	
end process;


------------------------------------------------------------------------------------------------------
-- 	POSITION GENERATOR
------------------------------------------------------------------------------------------------------	
PositionGenerator : Process(RefreshClock,i_Btn_Down,i_Btn_Up,i_Btn_Left,i_Btn_Right)
begin

	if(i_VGA_Reset = '1') then
		s_Car_Pos_X <= ( 5 => '1', others => '0');
		s_Car_Pos_Y <= ( 5 => '1', others => '0');
	elsif( rising_edge(RefreshClock)) then
		if(i_Btn_Up = '0') then
			s_Car_Pos_Y <= std_logic_vector(unsigned(s_Car_Pos_Y)-3);
		elsif(i_Btn_Down = '0') then
			s_Car_Pos_Y <= std_logic_vector(unsigned(s_Car_Pos_Y)+3);
		end if;
		
		if(i_Btn_Left = '0') then
			s_Car_Pos_X <= std_logic_vector(unsigned(s_Car_Pos_X)-3);
		elsif(i_Btn_Right = '0') then
			s_Car_Pos_X <= std_logic_vector(unsigned(s_Car_Pos_X)+3);
		end if;
		
	end if;  
	
end process;

------------------------------------------------------------------------------------------------------
-- 	REFRESH CLOCK GENERATOR
------------------------------------------------------------------------------------------------------	
--	Horizontal Period = g_Horiz_BP + g_Horiz_Disp + g_Horiz_FP + g_Horiz_Sync = 16 +96 +48 + 640 = 800
-- Vertcal Period = g_Vert_BP + g_Vert_Disp + g_Vert_FP + g_Vert_Sync = 480 + 10 + 2 + 33 = 525
--	Refresh Period = 800*525
RefreshClockProc: process(i_VGA_Reset,pixel_clk)
begin
	if(i_VGA_Reset = '1') then
		RefreshClock <= '0';
		Refresh_Rate_Timer <= (others => '0');
		
	elsif( rising_edge(pixel_clk)) then
		if (Refresh_Rate_Timer = "1100110100010100000") then
			RefreshClock <= RefreshClock xor '1';
			Refresh_Rate_Timer <= (others => '0');
		else
			Refresh_Rate_Timer <= Refresh_Rate_Timer + 1 ;
		end if;
	end if;
end process;

 
 
	----------------------------------------------------------------------
	--	CRASH CONTROL
	----------------------------------------------------------------------
Crash_Control_Blk: component Crash_Control
	port map(
		i_clk => RefreshClock, 
		i_Wall_En => (DisplaySelect(1) or DisplaySelect(2) or DisplaySelect(3)),
		i_Golden_En => (DisplaySelect(4) or DisplaySelect(5) or DisplaySelect(6)),
		i_Car_En => DisplaySelect(0),
	   o_Lost =>o_Lost_LED); 

end arch;