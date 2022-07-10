library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Perceptron_results_tb is 
end entity Perceptron_results_tb;

architecture beh of Perceptron_results_tb is 
	
	-- Constants
	
	constant clk_period     : time := 100 ns; -- Clock period
	constant reset : time := 25 ns; -- Reset time 
	
	component Perceptron is
		port(
			-- Input values for x  
			x_0: in std_logic_vector(7 downto 0);
			x_1: in std_logic_vector(7 downto 0);
			x_2: in std_logic_vector(7 downto 0);
			x_3: in std_logic_vector(7 downto 0);
			x_4: in std_logic_vector(7 downto 0);
			x_5: in std_logic_vector(7 downto 0);
			x_6: in std_logic_vector(7 downto 0);
			x_7: in std_logic_vector(7 downto 0);
			x_8: in std_logic_vector(7 downto 0);
			x_9: in std_logic_vector(7 downto 0);

			-- Input values of w
			w_0: in std_logic_vector(8 downto 0);
			w_1: in std_logic_vector(8 downto 0);
			w_2: in std_logic_vector(8 downto 0);
			w_3: in std_logic_vector(8 downto 0);
			w_4: in std_logic_vector(8 downto 0);
			w_5: in std_logic_vector(8 downto 0);
			w_6: in std_logic_vector(8 downto 0);
			w_7: in std_logic_vector(8 downto 0);
			w_8: in std_logic_vector(8 downto 0);
			w_9: in std_logic_vector(8 downto 0);
			
			clk: in std_logic;
			rst: in std_logic;
			b: in std_logic_vector(8 downto 0); -- Bias
			
			s_out: out std_logic_vector(15 downto 0) -- Output of the Perceptron
		);
	end component Perceptron;
	
	-- Values of the vectors x
	signal x_0_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_1_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_2_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_3_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_4_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_5_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_6_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_7_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_8_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal x_9_tb : std_logic_vector(7 downto 0) := (others => '0');
	
	-- Values of the vectors w 
	signal w_0_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_1_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_2_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_3_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_4_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_5_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_6_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_7_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_8_tb : std_logic_vector(8 downto 0) := (others => '0');
	signal w_9_tb : std_logic_vector(8 downto 0) := (others => '0');
	
	signal b_tb   : std_logic_vector(8 downto 0) := (others => '0');

	signal s_out_tb : std_logic_vector(15 downto 0);

	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal testing : boolean := true;
	
	begin
		clk <= not clk after clk_period/2 when testing else '0';
		rst <= '1' after reset; 

		dut: Perceptron
		port map(
			x_0 => x_0_tb,
			x_1 => x_1_tb,
			x_2 => x_2_tb,
			x_3 => x_3_tb,
			x_4 => x_4_tb,
			x_5 => x_5_tb,
			x_6 => x_6_tb,
			x_7 => x_7_tb,
			x_8 => x_8_tb,
			x_9 => x_9_tb,
			
			w_0 => w_0_tb,
			w_1 => w_1_tb,
			w_2 => w_2_tb,
			w_3 => w_3_tb,
			w_4 => w_4_tb,
			w_5 => w_5_tb,
			w_6 => w_6_tb,
			w_7 => w_7_tb,
			w_8 => w_8_tb,
			w_9 => w_9_tb,
		
			clk => clk,
			rst => rst,
			b => b_tb,
			
			s_out => s_out_tb
		);
		
		process_bias: process
			begin
				wait for 400 ns;
				-- Test 1
				x_0_tb <= "01111111";
				x_1_tb <= "01111111";
				x_2_tb <= "01111111";
				x_3_tb <= "01111111";
				x_4_tb <= "01111111";
				x_5_tb <= "01111111";
				x_6_tb <= "01111111";
				x_7_tb <= "01111111";
				x_8_tb <= "01111111";
				x_9_tb <= "01111111";			
				
				w_0_tb <= "100000001";
				w_1_tb <= "100000001";
				w_2_tb <= "100000001";
				w_3_tb <= "100000001";
				w_4_tb <= "100000001";
				w_5_tb <= "100000001";
				w_6_tb <= "100000001";
				w_7_tb <= "100000001";
				w_8_tb <= "100000001";
				w_9_tb <= "100000001";
				b_tb   <= "100000001";
				wait for 1000 ns;
				-- Test 2
				w_0_tb <= "100110100";
				w_1_tb <= "100110100";
				w_2_tb <= "100110100";
				w_3_tb <= "100110100";
				w_4_tb <= "100110100";
				w_5_tb <= "100110100";
				w_6_tb <= "100110100";
				w_7_tb <= "100110100";
				w_8_tb <= "100110100";
				w_9_tb <= "100110100";
				
				b_tb   <= "100000001";
				wait for 1000 ns;
				-- Test 3
				w_0_tb <= "110000000";
				w_1_tb <= "110000000";
				w_2_tb <= "110000000";
				w_3_tb <= "110000000";
				w_4_tb <= "110000000";
				w_5_tb <= "110000000";
				w_6_tb <= "110000000";
				w_7_tb <= "110000000";
				w_8_tb <= "110000000";
				w_9_tb <= "110000000";
				b_tb   <= "110000000";
				wait for 1000 ns;
				-- Test 4
				w_0_tb <= "111000000";
				w_1_tb <= "111000000";
				w_2_tb <= "111000000";
				w_3_tb <= "111000000";
				w_4_tb <= "111000000";
				w_5_tb <= "111000000";
				w_6_tb <= "111000000";
				w_7_tb <= "111000000";
				w_8_tb <= "111000000";
				w_9_tb <= "111000000";
				b_tb   <= "111000000";
				wait for 1000 ns;
				-- Test 5
				w_0_tb <= "000000000";
				w_1_tb <= "000000000";
				w_2_tb <= "000000000";
				w_3_tb <= "000000000";
				w_4_tb <= "000000000";
				w_5_tb <= "000000000";
				w_6_tb <= "000000000";
				w_7_tb <= "000000000";
				w_8_tb <= "000000000";
				w_9_tb <= "000000000";
				b_tb   <= "000000000";
				wait for 1000 ns;
				-- Test 6
				w_0_tb <= "001000000";
				w_1_tb <= "001000000";
				w_2_tb <= "001000000";
				w_3_tb <= "001000000";
				w_4_tb <= "001000000";
				w_5_tb <= "001000000";
				w_6_tb <= "001000000";
				w_7_tb <= "001000000";
				w_8_tb <= "001000000";
				w_9_tb <= "001000000";
				b_tb   <= "001000000";
				wait for 1000 ns;
				-- Test 7
				w_0_tb <= "010000000";
				w_1_tb <= "010000000";
				w_2_tb <= "010000000";
				w_3_tb <= "010000000";
				w_4_tb <= "010000000";
				w_5_tb <= "010000000";
				w_6_tb <= "010000000";
				w_7_tb <= "010000000";
				w_8_tb <= "010000000";
				w_9_tb <= "010000000";
				b_tb   <= "010000000";
				wait for 1000 ns;
				-- Test 8
				w_0_tb <= "011001100";
				w_1_tb <= "011001100";
				w_2_tb <= "011001100";
				w_3_tb <= "011001100";
				w_4_tb <= "011001100";
				w_5_tb <= "011001100";
				w_6_tb <= "011001100";
				w_7_tb <= "011001100";
				w_8_tb <= "011001100";
				w_9_tb <= "011001100";
				b_tb   <= "011111111";
				wait for 1000 ns;
				-- Test 9
				w_0_tb <= "011111111";
				w_1_tb <= "011111111";
				w_2_tb <= "011111111";
				w_3_tb <= "011111111";
				w_4_tb <= "011111111";
				w_5_tb <= "011111111";
				w_6_tb <= "011111111";
				w_7_tb <= "011111111";
				w_8_tb <= "011111111";
				w_9_tb <= "011111111";
				b_tb   <= "011111111";
				wait for 1500 ns;
				testing <= false;
		end process;
end beh;