-- Pll_50_to_25.vhd

-- Generated using ACDS version 14.1 186 at 2018.04.22.12:41:12

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Pll_50_to_25 is
	port (
		clk_clk           : in  std_logic := '0'; --           clk.clk
		pll_0_outclk0_clk : out std_logic;        -- pll_0_outclk0.clk
		reset_reset_n     : in  std_logic := '0'  --         reset.reset_n
	);
end entity Pll_50_to_25;

architecture rtl of Pll_50_to_25 is
	component Pll_50_to_25_pll_0 is
		port (
			refclk   : in  std_logic := 'X'; -- clk
			rst      : in  std_logic := 'X'; -- reset
			outclk_0 : out std_logic;        -- clk
			locked   : out std_logic         -- export
		);
	end component Pll_50_to_25_pll_0;

	signal reset_reset_n_ports_inv : std_logic; -- reset_reset_n:inv -> pll_0:rst

begin

	pll_0 : component Pll_50_to_25_pll_0
		port map (
			refclk   => clk_clk,                 --  refclk.clk
			rst      => reset_reset_n_ports_inv, --   reset.reset
			outclk_0 => pll_0_outclk0_clk,       -- outclk0.clk
			locked   => open                     --  locked.export
		);

	reset_reset_n_ports_inv <= not reset_reset_n;

end architecture rtl; -- of Pll_50_to_25