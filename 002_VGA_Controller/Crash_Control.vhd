library IEEE;
use IEEE.std_logic_1164.All;
use IEEE.numeric_std.All;
use IEEE.std_logic_unsigned.All;

entity Crash_Control is
	port(
		i_clk : in std_logic;
		i_Wall_En :in  std_logic;
		i_Golden_En :in  std_logic;
		i_Car_En :in  std_logic;
		
		o_Lost :out  std_logic
	);
end Crash_Control;


architecture arch of Crash_Control is

signal s_Score : unsigned (15 downto 0) :=(others => '0');
signal s_lost : std_logic;
signal s_Counter : unsigned(3 downto 0);
begin

s_lost <= i_Wall_En and i_Car_En;
	process(i_clk)
	begin
		if(rising_edge(i_clk)) then
			if(s_lost = '1') then
				s_Counter <= s_Counter + 1;
				
				if(s_Counter = "0001") then
					o_Lost <= '0';
				else 
					o_Lost <= '1';
				end if;
			end if;
		end if;
	end process;	

	
	end arch;
