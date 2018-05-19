library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;
entity Wall_Generator is
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
end Wall_Generator;


architecture arch of Wall_Generator is
	constant X_LENGTH : std_logic_vector(9 downto 0) := "0000000010";			-- Wall_Length_X = 2			
	constant Y_LENGTH : std_logic_vector(9 downto 0) := "0000000010";			-- Wall_Length_Y = 2		

	  constant M_x : std_logic_vector(9 downto 0) :=    "0101000000";  --320
	  constant M_y : std_logic_vector(9 downto 0) :=    "0011110000";  --240
	  constant radius6 : std_logic_vector(9 downto 0) :="0011100110"; --230
	  constant wdth : std_logic_vector(9 downto 0) :=   "0000000010";  --2
		  
	signal s_Pos_X,s_Pos_Y : std_logic_vector(9 downto 0);	-- Buna gerek kalmayabilir.

begin
		process(i_Dist_Ena,i_Pos_Y,i_Pos_X,i_Row_Num,i_Column_Num)
		begin
		-- 	Barrier_Left	  		Road1 				 Road2						Road3			 Barrier_Right
		-- 0 					 50      		   230                    410            		 590					640
		--            				 			 225 235                405 415 
		--
		--						      WALL1						WALL2							WALL3	
		--                       140                  320                     500
		--							 90     190	         270     370		         450     550
		--
		--
			-- Generate WALL2: 

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
		       (std_logic_vector( (signed((i_Column_Num - M_x))*signed(i_Column_Num - M_x)) + 
				( signed( i_Row_Num - M_y)*signed( i_Row_Num - M_y))) <  radius6*radius6 ) and
		      (abs(signed(i_Row_Num - M_y)*signed(M_x-i_Pos_X)) < abs(signed(M_y - i_Pos_Y) * signed(i_Column_Num - M_x))) and 
			   (abs(signed(i_Row_Num - M_y-2)*signed(M_x-i_Pos_X)) > abs(signed(M_y - i_Pos_Y) * signed(i_Column_Num - M_x-2))) 
			--	((i_Row_Num+2 - M_y+2) >= i_Pos_Y * (i_Column_Num+2 - M_x+2))
				--i_Row_Num <= (i_Pos_Y + Y_LENGTH) 	and 	i_Row_Num >= s_Pos_Y 	and
				--i_Column_Num <= (320) 	and 	i_Column_Num >= 0 
				) then
				o_Disp_Ena <= '1';
				o_Red <=(others => '0');
			   o_Green <=(others => '0'); 
			   o_Blue <=(others => '1');	
			else
					o_Disp_Ena <= '0';
		   end if;
			
		end Process;
		
		
		
			--if(i_Dist_Ena = '1' and 
			--i_Row_Num <= (i_Pos_Y + Y_LENGTH) 	and 	i_Row_Num >= s_Pos_Y 	and
			--	i_Column_Num <= (i_Pos_X + X_LENGTH) 	and 	i_Column_Num >= s_Pos_X) then
			--		o_Disp_Ena <= '1';
			--		o_Red <=(others => '0');
				--	o_Green <=(others => '0');
			--	o_Blue <=(others => '1');	
			--else
				--	o_Disp_Ena <= '0';
		   --end if;
			
		--end Process;			
							
	
end arch;