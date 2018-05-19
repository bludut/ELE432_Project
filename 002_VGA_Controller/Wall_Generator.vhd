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
	constant X_LENGTH : std_logic_vector(9 downto 0) := "00" & X"32";			-- Wall_Length_X = 100			
	constant Y_LENGTH : std_logic_vector(9 downto 0) := "00" & X"48";			-- Wall_Length_Y = 150		

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
				i_Row_Num <= (i_Pos_Y + Y_LENGTH) 	and 	i_Row_Num >= s_Pos_Y 	and
				i_Column_Num <= (i_Pos_X + X_LENGTH) 	and 	i_Column_Num >= s_Pos_X) then
					o_Disp_Ena <= '1';
					o_Red <=(others => '0');
					o_Green <=(others => '0');
					o_Blue <=(others => '1');	
			else
					o_Disp_Ena <= '0';
			end if;
			
		end Process;			
							
	
end arch;