library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;
entity Crash_Control is
	Generic(
				g_Total_Row : integer := 480;
				g_Total_Column : integer := 640;
				
				g_Car_L_X: std_logic_vector(9 downto 0) := "00" & X"20";		-- Car_Length_X = 32	
				g_Car_L_Y: std_logic_vector(9 downto 0) := "00" & X"20";		-- Car_Length_Y = 32	
				
				g_WALL2_L_X: std_logic_vector(9 downto 0) := "00" & X"64";	-- Wall_Length_X = 100	
				g_WALL2_L_Y: std_logic_vector(9 downto 0) := "00" & X"96"	-- Wall_Length_Y = 150	
				);
	Port(
			i_Car_Pos_X : in std_logic_vector(9 downto 0);
			i_Car_Pos_Y : in std_logic_vector(9 downto 0);
			
			i_WALL2_Pos_X : in std_logic_vector(9 downto 0);
			i_WALL2_Pos_Y : in std_logic_vector(9 downto 0);
			
			o_Crash : out std_logic
			);
end Crash_Control;


architecture arch of Crash_Control is
--	constant X_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20";
--	constant Y_LENGTH : std_logic_vector(9 downto 0) := "00" & X"20";

	signal C_X, C_Y : integer;		-- Refers to Car positions
	signal I2_X, I2_Y : integer;	-- Refers to WALL2 positions
	
	
	signal s_Car_L_X, s_Car_L_Y: integer;
	signal s_WALL2_L_X, s_WALL2_L_Y: integer;

	
--	signal b1_I2_X, b2_I2_X : integer;	-- Borders to WALL2 X positions
	
--	signal s_Crash : std_logic;	-- Crash signal for wait until operation below.


begin

-- Convert std_ to integer for simplicity
		s_Car_L_X   <= to_integer(unsigned(g_Car_L_X));
		s_Car_L_Y   <= to_integer(unsigned(g_Car_L_Y));
		s_WALL2_L_X <= to_integer(unsigned(g_WALL2_L_X));
		s_WALL2_L_Y <= to_integer(unsigned(g_WALL2_L_Y));

		process(i_Car_Pos_X, i_Car_Pos_Y, i_WALL2_Pos_X, i_WALL2_Pos_Y)
		begin

	--	C_X <= to_integer(unsigned(i_Car_Pos_X));
	--	C_Y <= to_integer(unsigned(i_Car_Pos_Y));		--
	--	I2_X <= to_integer(unsigned(i_WALL2_Pos_X));	--
	--	I2_Y <= to_integer(unsigned(i_WALL2_Pos_Y));

	
	
--		b1_I2_X <= to_integer(unsigned(i_WALL2_Pos_X));					-- border 1 for I2_X
--		b2_I2_X <= to_integer(unsigned(i_WALL2_Pos_X+g_WALL2_L_X)); -- border 2 for I2_X
		

		-- Convert stdlogic to integer 
		for I in 0 to to_integer(unsigned(g_WALL2_L_X)) loop
			for J in 0 to to_integer(unsigned(g_Car_L_Y)) loop		
					
					I2_X <= to_integer(unsigned(i_WALL2_Pos_X)) + I;	--
					I2_Y <= to_integer(unsigned(i_WALL2_Pos_Y));
					C_X <= to_integer(unsigned(i_Car_Pos_X));
					C_Y <= to_integer(unsigned(i_Car_Pos_Y)) + J;		--

					if (I2_X = C_X) and (I2_Y = C_Y) then
						o_Crash <= '1';
--						s_Crash <= '1';
--						wait until s_Crash= '0';
						
					elsif (I2_X = C_X) and (I2_Y + s_WALL2_L_Y = C_Y) then
						o_Crash <= '1';
--						s_Crash <= '1';
--						wait until s_Crash= '0';
						
					elsif (I2_X = C_X + s_Car_L_X) and (I2_Y = C_Y) then
						o_Crash <= '1';
--						s_Crash <= '1';
--						wait until s_Crash= '0';
						
					elsif (I2_X = C_X + s_Car_L_X) and (I2_Y + s_WALL2_L_Y = C_Y) then
						o_Crash <= '1';
--						s_Crash <= '1';
--						wait until s_Crash= '0';
						
					else
						o_Crash <= '0';
--						s_Crash <= '0';
						
					end if;
					
			end loop;
		end loop;

		end Process;
								
	
end arch;