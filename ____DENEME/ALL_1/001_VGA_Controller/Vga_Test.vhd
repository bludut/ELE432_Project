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
	signal s_Pos_HL_L_Y, s_Pos_HL_L_X, s_Pos_HL_R_Y, s_Pos_HL_R_X : std_logic_vector(9 downto 0);	-- Positions of Headlight Left and Right
	
	signal s_Pos_Gear_LU_Y, s_Pos_Gear_LU_X, s_Pos_Gear_LD_Y, s_Pos_Gear_LD_X : std_logic_vector(9 downto 0);	-- Positions of Gear Left_UP and Left_Down
	signal s_Pos_Gear_RU_Y, s_Pos_Gear_RU_X, s_Pos_Gear_RD_Y, s_Pos_Gear_RD_X : std_logic_vector(9 downto 0);	-- Positions of Gear Right_UP and Right_Down
	
	signal s_Pos_Car_Y, s_Pos_Car_X : std_logic_vector(9 downto 0);	-- Positions of Car
		
begin
	-- Mode select
		process(i_Dist_Ena,i_Pos_Y,i_Pos_X,i_Row_Num,i_Column_Num)
		begin
		
		----------------------------------------------------------------------------		
		-- Headlight Initial Position Generate for shifting
		----------------------------------------------------------------------------
		if( (signed(i_Pos_Y) + 0) < 0 and (abs(signed(i_Pos_Y) + 0)) <= 5 ) then		-- Initial_Pos = 0,  	Length_Headlight_Y = 5			
			s_Pos_HL_L_Y <= (others => '0' );
		else
			s_Pos_HL_L_Y <= (i_Pos_Y + 0);
		end if;		
		
		if( (signed(i_Pos_X) + 5) < 0 and (abs(signed(i_Pos_X) + 5)) <= 10 ) then		-- Initial_Pos = 5,  	Length_Headlight_X = 10			
			s_Pos_HL_L_X <= (others => '0' );
		else
			s_Pos_HL_L_X <= (i_Pos_X + 5);
		end if;		
		------------------------------------	------------------------------------
--		if( (signed(i_Pos_Y) + 0) < 0 and (abs(signed(i_Pos_Y) + 0)) <= 5 ) then		-- Initial_Pos = 0,  	Length_Headlight_Y = 5			
--			s_Pos_HL_R_Y <= (others => '0' );
--		else
--			s_Pos_HL_R_Y <= (i_Pos_Y + 0);
--		end if;		
		
		if( (signed(i_Pos_X) + 35) < 0 and (abs(signed(i_Pos_X) + 35)) <= 10 ) then		-- Initial_Pos = 35,  	Length_Headlight_X = 10			
			s_Pos_HL_R_X <= (others => '0' );
		else
			s_Pos_HL_R_X <= (i_Pos_X + 35);
		end if;		
		----------------------------------------------------------------------------
		
		
		----------------------------------------------------------------------------		
		-- Gears_Left Initial Position Generate for shifting (Up and Down Respectively)
		----------------------------------------------------------------------------
		if( (signed(i_Pos_Y) + 10) < 0 and (abs(signed(i_Pos_Y) + 10)) <= 15 ) then		-- Initial_Pos = 10,  	Length_Gear_Y = 15			
			s_Pos_Gear_LU_Y <= (others => '0' );
		else
			s_Pos_Gear_LU_Y <= (i_Pos_Y + 10);
		end if;		
		
		if( (signed(i_Pos_X) + 0) < 0 and (abs(signed(i_Pos_X) + 0)) <= 5 ) then		-- Initial_Pos = 0,  	Length_Gear_X = 5			
			s_Pos_Gear_LU_X <= (others => '0' );
		else
			s_Pos_Gear_LU_X <= (i_Pos_X + 0);
		end if;		
		------------------------------------	------------------------------------
		if( (signed(i_Pos_Y) + 50) < 0 and (abs(signed(i_Pos_Y) + 50)) <= 15 ) then		-- Initial_Pos = 50,  	Length_Gear_Y = 15			
			s_Pos_Gear_LD_Y <= (others => '0' );
		else
			s_Pos_Gear_LD_Y <= (i_Pos_Y + 50);
		end if;		
		
--		if( (signed(i_Pos_X) + 0) < 0 and (abs(signed(i_Pos_X) + 0)) <= 5 ) then		-- Initial_Pos = 0,  	Length_Gear_X = 5			
--			s_Pos_Gear_LD_X <= (others => '0' );
--		else
--			s_Pos_Gear_LD_X <= (i_Pos_X + 0);
--		end if;		
		----------------------------------------------------------------------------		
		
		
		----------------------------------------------------------------------------		
		-- Gears_Righ Initial Position Generate for shifting (Up and Down Respectively)
		----------------------------------------------------------------------------
--		if( (signed(i_Pos_Y) + 10) < 0 and (abs(signed(i_Pos_Y) + 10)) <= 15 ) then		-- Initial_Pos = 10,  	Length_Gear_Y = 15			
--			s_Pos_Gear_RU_Y <= (others => '0' );
--		else
--			s_Pos_Gear_RU_Y <= (i_Pos_Y + 10);
--		end if;		
		
		if( (signed(i_Pos_X) + 45) < 0 and (abs(signed(i_Pos_X) + 45)) <= 5 ) then		-- Initial_Pos = 45,  	Length_Gear_X = 5			
			s_Pos_Gear_RU_X <= (others => '0' );
		else
			s_Pos_Gear_RU_X <= (i_Pos_X + 45);
		end if;		
		------------------------------------	------------------------------------
--		if( (signed(i_Pos_Y) + 50) < 0 and (abs(signed(i_Pos_Y) + 50)) <= 15 ) then		-- Initial_Pos = 50,  	Length_Gear_Y = 15			
--			s_Pos_Gear_RD_Y <= (others => '0' );
--		else
--			s_Pos_Gear_RD_Y <= (i_Pos_Y + 50);
--		end if;		
		
--		if( (signed(i_Pos_X) + 45) < 0 and (abs(signed(i_Pos_X) + 45)) <= 5 ) then		-- Initial_Pos = 45,  	Length_Gear_X = 5			
--			s_Pos_Gear_RD_X <= (others => '0' );
--		else
--			s_Pos_Gear_RD_X <= (i_Pos_X + 45);
--		end if;		
		----------------------------------------------------------------------------	


		----------------------------------------------------------------------------		
		-- Car Initial Position Generate for shifting
		----------------------------------------------------------------------------
		if( (signed(i_Pos_Y) + 0) < 0 and (abs(signed(i_Pos_Y) + 0)) <= 75 ) then		-- Initial_Pos = 0,  	Length_Headlight_Y = 75			
			s_Pos_Car_Y <= (others => '0' );
		else
			s_Pos_Car_Y <= (i_Pos_Y + 0);
		end if;		
		
		if( (signed(i_Pos_X) + 5) < 0 and (abs(signed(i_Pos_X) + 5)) <= 40 ) then		-- Initial_Pos = 5,  	Length_Headlight_X = 40			
			s_Pos_Car_X <= (others => '0' );
		else
			s_Pos_Car_X <= (i_Pos_X + 5);
		end if;				
		----------------------------------------------------------------------------	
		
		
		-----------------------			Headlight Genarator			-----------------------
		if(i_Dist_Ena = '1' and 
			(signed(i_Row_Num) <= (signed(i_Pos_Y) + 5) and ((i_Row_Num) >= (s_Pos_HL_L_Y))) and 
			(((signed(i_Column_Num) <= (signed(i_Pos_X) +5+10)) and ((i_Column_Num) >= (s_Pos_HL_L_X))) or		-- Left
			 ((signed(i_Column_Num) <= (signed(i_Pos_X) +35+10))and ((i_Column_Num) >= (s_Pos_HL_R_X)))))then  	-- Right
				o_Disp_Ena <= '1';
				o_Red <=(others => '1');
				o_Green <=(others => '1');
				o_Blue <=(others => '1');
					
					
		-----------------------				Gear Genarator	 		----------------------- 
		elsif(i_Dist_Ena = '1' and 
			(((signed(i_Row_Num) <= (signed(i_Pos_Y) +10+15)) and ((i_Row_Num) >= (s_Pos_Gear_LU_Y))) or		-- Up and Down
			 ((signed(i_Row_Num) <= (signed(i_Pos_Y) +50+15)) and ((i_Row_Num) >= (s_Pos_Gear_LD_Y)))) and
			(((signed(i_Column_Num) <= (signed(i_Pos_X) +0+5)) and ((i_Column_Num) >= (s_Pos_Gear_LU_X))) or	-- Left and Right
			 ((signed(i_Column_Num) <= (signed(i_Pos_X) +45+5)) and ((i_Column_Num) >= (s_Pos_Gear_RU_X)))))then
				o_Disp_Ena <= '1';
				o_Red <=("10011111");
				o_Green <=("10011111");
				o_Blue <=(others => '0');		
		
		
		-----------------------				Car Genarator			-----------------------
		elsif(i_Dist_Ena = '1' and 
			(signed(i_Row_Num) <= (signed(i_Pos_Y) + 0+75) and ((i_Row_Num) >= (s_Pos_Car_Y))) and 
			((signed(i_Column_Num) <= (signed(i_Pos_X) +5+40)) and ((i_Column_Num) >= (s_Pos_Car_X))))then  	
				o_Disp_Ena <= '1';
				o_Red <=(others => '1');
				o_Green <=(others => '0');
				o_Blue <=(others => '0');	
				
		else
				o_Disp_Ena <= '0';
		end if;
	
		end Process;
		
end arch;
