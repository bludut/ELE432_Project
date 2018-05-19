library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;
entity Road_Generator is
	Generic(
				g_Total_Row : integer := 480;
				g_Total_Column : integer := 640
				);
	Port(
			i_Dist_Ena : in Std_logic;
			i_Row_Num : in std_logic_vector (9 downto 0) ;			
			i_Column_Num : in std_logic_vector (9 downto 0);
			i_Pos_X : in std_logic_vector(9 downto 0);  --araba
			i_Pos_Y : in std_logic_vector(9 downto 0);
			
			o_Red : out std_logic_vector (7 downto 0);
			o_Green : out std_logic_vector (7 downto 0);
			o_Blue : out std_logic_vector (7 downto 0);
			o_Disp_Ena : out std_logic
			);
end Road_Generator;


architecture arch of Road_Generator is
	--constant X_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20"; --arabanin uzunlugu
	--constant Y_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20";
     constant wdth : std_logic_vector(9 downto 0) :=   "0000000010";  --2
	  constant M_x : std_logic_vector(9 downto 0) :=    "0101000000";  --320
	  constant M_y : std_logic_vector(9 downto 0) :=    "0011110000";  --240
	
	  signal s_Pos_Y : std_logic_vector(9 downto 0);
	  signal s_Pos_X : std_logic_vector(9 downto 0);

begin
		process(i_Dist_Ena,i_Pos_Y,i_Pos_X,i_Row_Num,i_Column_Num)
		begin
		s_Pos_Y <= std_logic_vector(unsigned(i_Row_Num) - unsigned(i_Pos_Y));
		s_Pos_X <= std_logic_vector(unsigned(i_Column_Num) - unsigned(i_Pos_X));
		
		-- cubuk
		if(i_Dist_Ena = '1' and i_Column_Num < M_x and i_Row_Num > 240 and i_Row_Num < 243 )  --sola mavi yatay çizgi çekiyor merkezden
			  then
				o_Disp_Ena <= '1';
					o_Red <=(others => '0');
               o_Green <=(others => '0');
	    			o_Blue <=(others => '1');
					
		else
					o_Disp_Ena <= '0';
			end if;
			
			
	--	s_Pos_Y <= std_logic_vector(unsigned(i_Row_Num) - unsigned(i_Pos_Y));
		
		--   50         230                    410             590
		--            225 235                405 415 
		--         11100001  11101011    110010101  110011111
		--
			-- Road 
	--		if(i_Dist_Ena = '1' and 
	--			(s_Pos_Y(6) xor '1') = '1' and
	--			((i_Column_Num >= "011100001" and i_Column_Num <= "011101011") or (i_Column_Num >= "0110010101" and i_Column_Num <= "0110011111"))
	--			) then
	--				o_Disp_Ena <= '1';
	--				o_Red <=(others => '1');
	--				o_Green <=(others => '0');
	--				o_Blue <=(others => '0');
	--				-- Barriers left and right
	--		elsif(i_Dist_Ena = '1' and 
	--			(i_Column_Num <= "0000110010" or i_Column_Num >= "1001001110")) then
	--				o_Disp_Ena <= '1';
	--				
	--				o_Red <=(others => '0');
	--				o_Green <=(others => '1');
	--				o_Blue <=(others => '0');
	--		else
	--				o_Disp_Ena <= '0';
	--		end if;
			
		end Process;
								
	
end arch;