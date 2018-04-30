	component Pll_50_to_25 is
		port (
			clk_clk           : in  std_logic := 'X'; -- clk
			reset_reset_n     : in  std_logic := 'X'; -- reset_n
			pll_0_outclk0_clk : out std_logic         -- clk
		);
	end component Pll_50_to_25;

	u0 : component Pll_50_to_25
		port map (
			clk_clk           => CONNECTED_TO_clk_clk,           --           clk.clk
			reset_reset_n     => CONNECTED_TO_reset_reset_n,     --         reset.reset_n
			pll_0_outclk0_clk => CONNECTED_TO_pll_0_outclk0_clk  -- pll_0_outclk0.clk
		);

