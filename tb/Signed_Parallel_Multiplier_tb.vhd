library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Signed_Parallel_Multiplier_tb is  
end Signed_Parallel_Multiplier_tb;

architecture beh of Signed_Parallel_Multiplier_tb is

	-- Constants

    constant clk_period     : time := 100 ns; -- Clock period
    constant Nbit_x         : positive := 8; -- Number of bits of the vector x_p
	constant Nbit_w         : positive := 9; -- Number of bits of the vector w_p
	    
    component Signed_Parallel_Multiplier
        generic(
            Nbit_x : positive;
            Nbit_w : positive
        );
        port(
            x_p_sign : in  std_logic_vector(Nbit_x - 1 downto 0);
            w_p_sign : in  std_logic_vector(Nbit_w - 1 downto 0);
            p_sign   : out std_logic_vector(Nbit_x + Nbit_w - 1 downto 0)
        );
    end component Signed_Parallel_Multiplier;
	
	-- Signals used in the TB 

	signal x_tb    : std_logic_vector(Nbit_x-1 downto 0) := (others => '0');
    signal w_tb    : std_logic_vector(Nbit_w-1 downto 0) := (others => '0');
    signal p_tb    : std_logic_vector((Nbit_x) + (Nbit_w)-1 downto 0) := (others => '0');
	
	signal clk     : std_logic := '0';
	signal testing : boolean := true;
	
	begin
		clk <= not clk after clk_period/2 when testing else '0';
		
		-- Definition of the DUT

		dut: Signed_Parallel_Multiplier
		generic map (
			Nbit_x => Nbit_x,
			Nbit_w => Nbit_w
			)
		port map (
			x_p_sign => x_tb,
			w_p_sign => w_tb,
			p_sign => p_tb
			);
			
		-- Definition of the stimuli to apply to the DUT

		stimulus : process 
			begin
				x_tb <= (others => '0');
				w_tb <= (others => '0');
				wait for 200 ns;
				x_tb <= "00000101";
				w_tb <= "000000011";
				wait for 400 ns;
				x_tb <= "00101101";
				w_tb <= "000000101";
				wait for 400 ns;
				x_tb <= "00001100";
				w_tb <= "000000011";
				wait for 400 ns;
				x_tb <= "11111111";
				w_tb <= "011111111";
				wait for 400 ns;
				x_tb <= "10111111";
				w_tb <= "011101111";
				wait for 400 ns;
				x_tb <= "11011011";
				w_tb <= "001001101";
				wait for 400 ns;
				x_tb <= (others => '0');
				w_tb <= (others => '0');
				wait for 400 ns;
				testing <= false;
		end process;
end beh;