library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder_Tree_tb is
end Adder_Tree_tb;

architecture beh of Adder_Tree_tb is

    constant clk_period     : time := 100 ns; -- Clock period
	constant reset : time := 25 ns;
	
	component Adder_Tree
		port(
			l1_s1_in1 : in std_logic_vector(16 downto 0);
			l1_s1_in2 : in std_logic_vector(16 downto 0);
			l1_s2_in1 : in std_logic_vector(16 downto 0);
			l1_s2_in2 : in std_logic_vector(16 downto 0);
			l1_s3_in1 : in std_logic_vector(16 downto 0);
			l1_s3_in2 : in std_logic_vector(16 downto 0);
			l1_s4_in1 : in std_logic_vector(16 downto 0);
			l1_s4_in2 : in std_logic_vector(16 downto 0);
			l1_s5_in1 : in std_logic_vector(16 downto 0);
			l1_s5_in2 : in std_logic_vector(16 downto 0);
			
			clk: in std_logic;
			rst: in std_logic;
			b  : in std_logic_vector(8 downto 0); 
        
			sum: out std_logic_vector(20 downto 0) 		
		);
	end component Adder_Tree;
	
	-- Signals used in the TB 
	signal in1_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in2_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in3_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in4_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in5_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in6_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in7_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in8_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in9_tb  : std_logic_vector(16 downto 0):= (others => '0');
	signal in10_tb : std_logic_vector(16 downto 0):= (others => '0');
	
	signal rst_tb : std_logic := '0';
	signal b_tb   : std_logic_vector(8 downto 0); 
        
	signal sum_tb : std_logic_vector(20 downto 0):= (others => '0');
	
	signal clk     : std_logic := '0';
	signal testing : boolean := true;
	
	begin
		clk <= not clk after clk_period/2 when testing else '0';
		rst_tb <= '1' after reset; 
		
		dut: Adder_Tree
		port map (
			l1_s1_in1 => in1_tb,
			l1_s1_in2 => in2_tb,
			l1_s2_in1 => in3_tb,
			l1_s2_in2 => in4_tb,
			l1_s3_in1 => in5_tb,
			l1_s3_in2 => in6_tb,
			l1_s4_in1 => in7_tb,
			l1_s4_in2 => in8_tb,
			l1_s5_in1 => in9_tb,
			l1_s5_in2 => in10_tb,
			
			clk => clk,
			rst => rst_tb,
			b   => b_tb,
			sum => sum_tb
			);
		
		stimulus : process
			begin
				in1_tb  <= "11100100110001100";
				in2_tb  <= "00000011100110011";
				in3_tb  <= "10110100010110000";
				in4_tb  <= "00111100110110100";
				in5_tb  <= "00001100100110110";
				in6_tb  <= "01100010000110111";
				in7_tb  <= "00000011101010010";
				in8_tb  <= "00001101000010111";
				in9_tb  <= "11000010100001110";
				in10_tb  <= "00011001011000111";
				b_tb <= "000101100";
				wait for 400 ns;
				in1_tb  <= "11101011110001101";
				in2_tb  <= "00001100000110101";
				in3_tb  <= "00001111100011111";
				in4_tb  <= "01011100110001010";
				in5_tb  <= "00001011110110111";
				in6_tb  <= "11001100001100000";
				in7_tb  <= "01001100111110110";
				in8_tb  <= "11101100001100011";
				in9_tb  <= "01011010111000000";
				in10_tb  <= "10101011100100111";
				b_tb <= "010011011";
				wait for 400 ns;
				in1_tb  <= "11000000001010010";
				in2_tb  <= "01110110111110111";
				in3_tb  <= "01101001111111010";
				in4_tb  <= "00100111010001110";
				in5_tb  <= "11101001000110100";
				in6_tb  <= "00001011000101110";
				in7_tb  <= "11001101100101001";
				in8_tb  <= "10110101101101110";
				in9_tb  <= "00010111101100001";
				in10_tb  <= "00111101001111011";
				b_tb <= "001000000";
				wait for 400 ns;
				in1_tb  <= "00111011111010111";
				in2_tb  <= "10010000100101110";
				in3_tb  <= "01001011011100011";
				in4_tb  <= "00010011011111110";
				in5_tb  <= "11101100111011011";
				in6_tb  <= "11110011010001001";
				in7_tb  <= "11000000110001110";
				in8_tb  <= "00111011100111010";
				in9_tb  <= "00000111010011110";
				in10_tb  <= "10000000101111101";
				b_tb <= "000100000";
				wait for 400 ns;
				in1_tb  <= "00000000100111111";
				in2_tb  <= "10011011011101111";
				in3_tb  <= "11010000011000100";
				in4_tb  <= "11100100110111110";
				in5_tb  <= "11001110101001010";
				in6_tb  <= "11100101011000111";
				in7_tb  <= "10111011011001011";
				in8_tb  <= "10111010100011010";
				in9_tb  <= "11110100010011100";
				in10_tb  <= "10111011011001000";
				b_tb <= "100100100";
				wait for 400 ns;
				in1_tb  <= "11111010110001110";
				in2_tb  <= "10010001110111101";
				in3_tb  <= "11010100101011111";
				in4_tb  <= "00101101010100011";
				in5_tb  <= "00111001000001000";
				in6_tb  <= "10100000000111011";
				in7_tb  <= "11100001110001010";
				in8_tb  <= "11010001101011010";
				in9_tb  <= "10111001101010100";
				in10_tb  <= "10101010011110001";
				b_tb <= "000011001";
				wait for 400 ns;
				in1_tb  <= "11110100011111000";
				in2_tb  <= "00010011010110110";
				in3_tb  <= "10110100001010100";
				in4_tb  <= "11110101100101110";
				in5_tb  <= "01101001110010000";
				in6_tb  <= "11100101111000010";
				in7_tb  <= "10111011010011010";
				in8_tb  <= "10100110011110000";
				in9_tb  <= "01110110110011100";
				in10_tb  <= "10000110001001010";
				b_tb <= "001111110";
				wait for 400 ns;
				in1_tb  <= "00110011011110101";
				in2_tb  <= "00000101011011011";
				in3_tb  <= "11101101000101100";
				in4_tb  <= "11101010100010100";
				in5_tb  <= "01110110111011101";
				in6_tb  <= "01001010011111100";
				in7_tb  <= "00111001000100001";
				in8_tb  <= "01011011011101101";
				in9_tb  <= "11001010100111000";
				in10_tb  <= "11000111111000001";
				b_tb <= "100100010";
				wait for 400 ns;
				in1_tb  <= "00011101011110110";
				in2_tb  <= "00001100100111101";
				in3_tb  <= "00010001010110111";
				in4_tb  <= "10000011101011111";
				in5_tb  <= "01111000110101100";
				in6_tb  <= "11000011100101001";
				in7_tb  <= "10110110010001101";
				in8_tb  <= "11111000010011111";
				in9_tb  <= "10110110101111101";
				in10_tb  <= "11001000100010010";
				b_tb <= "010001010";
				wait for 400 ns;
				in1_tb  <= "01010011000111100";
				in2_tb  <= "11110110000000011";
				in3_tb  <= "11000100000110110";
				in4_tb  <= "11001001100001000";
				in5_tb  <= "01011100011000011";
				in6_tb  <= "01000000001011010";
				in7_tb  <= "00000101001100011";
				in8_tb  <= "01011000101111100";
				in9_tb  <= "10001001100000101";
				in10_tb  <= "11001111010110011";
				b_tb <= "110010010";
				wait for 400 ns;
				testing  <= false;
        end process;
end beh;
	
	