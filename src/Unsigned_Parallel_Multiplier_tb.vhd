library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Unsigned_Parallel_Multiplier_tb is  
end Unsigned_Parallel_Multiplier_tb;

architecture beh of Unsigned_Parallel_Multiplier_tb is

    constant clk_period     : time := 100 ns;
    constant Nbit_x         : positive := 8;
	constant Nbit_w         : positive := 9;
	    
    component Unsigned_Parallel_Multiplier
        generic(
            Nbit_x : positive;
            Nbit_w : positive
        );
        port(
            x_p : in  std_logic_vector(Nbit_x - 1 downto 0);
            w_p : in  std_logic_vector(Nbit_w - 1 downto 0);
            p   : out std_logic_vector(Nbit_x + Nbit_w - 1 downto 0)
        );
    end component Unsigned_Parallel_Multiplier;
	
	signal x_tb    : std_logic_vector(Nbit_x-1 downto 0) := (others => '0');
    signal w_tb    : std_logic_vector(Nbit_w-1 downto 0) := (others => '0');
    signal p_tb    : std_logic_vector((Nbit_x) + (Nbit_w)-1 downto 0) := (others => '0');
	
	signal clk     : std_logic := '0';
	signal testing : boolean := true;
	
	begin
		clk <= not clk after clk_period/2 when testing else '0';
		dut: Unsigned_Parallel_Multiplier
		generic map (
			Nbit_x => Nbit_x,
			Nbit_w => Nbit_w
			)
		port map (
			x_p => x_tb,
			w_p => w_tb,
			p => p_tb
			);
			
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
				x_tb <= (others => '0');
				w_tb <= (others => '0');
				wait for 400 ns;
				testing <= false;
		end process;
end beh;