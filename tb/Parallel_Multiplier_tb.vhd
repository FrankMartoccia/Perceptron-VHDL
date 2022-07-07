library IEEE;
use IEEE.std_logic_1164.all;

entity Parallel_Multiplier_tb is  
end Parallel_Multiplier_tb;

architecture beh of Parallel_Multiplier_tb is

	-- Constants

    constant clk_period     : time := 100 ns; -- Clock period
	    
    component Parallel_Multiplier
        port(
            -- Values of the vectors x to multiply
            x_p_0: in std_logic_vector(7 downto 0);
            x_p_1: in std_logic_vector(7 downto 0);
            x_p_2: in std_logic_vector(7 downto 0);
            x_p_3: in std_logic_vector(7 downto 0);
            x_p_4: in std_logic_vector(7 downto 0);
            x_p_5: in std_logic_vector(7 downto 0);
            x_p_6: in std_logic_vector(7 downto 0);
            x_p_7: in std_logic_vector(7 downto 0);
            x_p_8: in std_logic_vector(7 downto 0);
            x_p_9: in std_logic_vector(7 downto 0);
            
            -- Values of the vectors w to multiply
            w_p_0: in std_logic_vector(8 downto 0);
            w_p_1: in std_logic_vector(8 downto 0);
            w_p_2: in std_logic_vector(8 downto 0);
            w_p_3: in std_logic_vector(8 downto 0);
            w_p_4: in std_logic_vector(8 downto 0);
            w_p_5: in std_logic_vector(8 downto 0);
            w_p_6: in std_logic_vector(8 downto 0);
            w_p_7: in std_logic_vector(8 downto 0);
            w_p_8: in std_logic_vector(8 downto 0);
            w_p_9: in std_logic_vector(8 downto 0);

            -- Values of the products
            p_0 : out std_logic_vector(16 downto 0);
            p_1 : out std_logic_vector(16 downto 0);
            p_2 : out std_logic_vector(16 downto 0);
            p_3 : out std_logic_vector(16 downto 0);
            p_4 : out std_logic_vector(16 downto 0);
            p_5 : out std_logic_vector(16 downto 0);
            p_6 : out std_logic_vector(16 downto 0);
            p_7 : out std_logic_vector(16 downto 0);
            p_8 : out std_logic_vector(16 downto 0);
            p_9 : out std_logic_vector(16 downto 0)
        );
    end component Parallel_Multiplier;
	
	-- Signals used in the TB 

	signal x_p_0_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_1_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_2_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_3_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_4_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_5_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_6_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_7_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_8_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal x_p_9_tb  : std_logic_vector(7 downto 0) := (others => '0');

    signal w_p_0_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_1_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_2_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_3_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_4_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_5_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_6_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_7_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_8_tb  : std_logic_vector(8 downto 0) := (others => '0');
    signal w_p_9_tb  : std_logic_vector(8 downto 0) := (others => '0');

    signal p_0_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_1_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_2_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_3_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_4_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_5_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_6_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_7_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_8_tb    : std_logic_vector(16 downto 0) := (others => '0');
    signal p_9_tb    : std_logic_vector(16 downto 0) := (others => '0');
	
	signal clk     : std_logic := '0';
	signal testing : boolean := true;
	
	begin
		clk <= not clk after clk_period/2 when testing else '0';
		
		-- Definition of the DUT

		dut: Parallel_Multiplier
		port map (
			x_p_0 => x_p_0_tb,
            x_p_1 => x_p_1_tb,
            x_p_2 => x_p_2_tb,
            x_p_3 => x_p_3_tb,
            x_p_4 => x_p_4_tb,
            x_p_5 => x_p_5_tb,
            x_p_6 => x_p_6_tb,
            x_p_7 => x_p_7_tb,
            x_p_8 => x_p_8_tb,
            x_p_9 => x_p_9_tb,

			w_p_0 => w_p_0_tb,
            w_p_1 => w_p_1_tb,
            w_p_2 => w_p_2_tb,
            w_p_3 => w_p_3_tb,
            w_p_4 => w_p_4_tb,
            w_p_5 => w_p_5_tb,
            w_p_6 => w_p_6_tb,
            w_p_7 => w_p_7_tb,
            w_p_8 => w_p_8_tb,
            w_p_9 => w_p_9_tb,

			p_0 => p_0_tb,
            p_1 => p_1_tb,
            p_2 => p_2_tb,
            p_3 => p_3_tb,
            p_4 => p_4_tb,
            p_5 => p_5_tb,
            p_6 => p_6_tb,
            p_7 => p_7_tb,
            p_8 => p_8_tb,
            p_9 => p_9_tb
			);
			
		-- Definition of the stimuli to apply to the DUT

		stimulus : process 
            begin
				x_p_0_tb <= "11100100";
				w_p_0_tb <= "101100110";
				x_p_1_tb <= "11000110";
				w_p_1_tb <= "001000011";
				x_p_2_tb <= "00000001";
				w_p_2_tb <= "011100000";
				x_p_3_tb <= "11001100";
				w_p_3_tb <= "011101010";
				x_p_4_tb <= "11101101";
				w_p_4_tb <= "010000011";
				x_p_5_tb <= "00010110";
				w_p_5_tb <= "010000101";
				x_p_6_tb <= "00000111";
				w_p_6_tb <= "111100001";
				x_p_7_tb <= "10011011";
				w_p_7_tb <= "010000111";
				x_p_8_tb <= "01000000";
				w_p_8_tb <= "000011001";
				x_p_9_tb <= "11001001";
				w_p_9_tb <= "011000111";
				wait for 400 ns;
				x_p_0_tb <= "11101011";
				w_p_0_tb <= "101111100";
				x_p_1_tb <= "11000110";
				w_p_1_tb <= "110000110";
				x_p_2_tb <= "10000110";
				w_p_2_tb <= "000001001";
				x_p_3_tb <= "00001101";
				w_p_3_tb <= "100111110";
				x_p_4_tb <= "01000011";
				w_p_4_tb <= "110111011";
				x_p_5_tb <= "11100011";
				w_p_5_tb <= "000011000";
				x_p_6_tb <= "11101011";
				w_p_6_tb <= "110101101";
				x_p_7_tb <= "10011000";
				w_p_7_tb <= "011100000";
				x_p_8_tb <= "10100000";
				w_p_8_tb <= "010101011";
				x_p_9_tb <= "10111101";
				w_p_9_tb <= "100100111";
				wait for 400 ns;
				x_p_0_tb <= "11000000";
				w_p_0_tb <= "101000000";
				x_p_1_tb <= "00101001";
				w_p_1_tb <= "101100010";
				x_p_2_tb <= "00111011";
				w_p_2_tb <= "111011001";
				x_p_3_tb <= "01111101";
				w_p_3_tb <= "101100101";
				x_p_4_tb <= "11011010";
				w_p_4_tb <= "001101101";
				x_p_5_tb <= "01111111";
				w_p_5_tb <= "011011011";
				x_p_6_tb <= "01000100";
				w_p_6_tb <= "100001011";
				x_p_7_tb <= "11101000";
				w_p_7_tb <= "110110000";
				x_p_8_tb <= "11101110";
				w_p_8_tb <= "100111101";
				x_p_9_tb <= "10010001";
				w_p_9_tb <= "001111011";
				wait for 400 ns;
				x_p_0_tb <= "00111011";
				w_p_0_tb <= "110111111";
				x_p_1_tb <= "11101011";
				w_p_1_tb <= "001101000";
				x_p_2_tb <= "11001000";
				w_p_2_tb <= "100111000";
				x_p_3_tb <= "01001011";
				w_p_3_tb <= "000110001";
				x_p_4_tb <= "10010010";
				w_p_4_tb <= "110001110";
				x_p_5_tb <= "11011100";
				w_p_5_tb <= "111001110";
				x_p_6_tb <= "01100010";
				w_p_6_tb <= "100000011";
				x_p_7_tb <= "01101111";
				w_p_7_tb <= "101001111";
				x_p_8_tb <= "11101110";
				w_p_8_tb <= "010000000";
				x_p_9_tb <= "11001110";
				w_p_9_tb <= "101111101";
				wait for 400 ns;
				x_p_0_tb <= "00000000";
				w_p_0_tb <= "010101110";
				x_p_1_tb <= "10011111";
				w_p_1_tb <= "010101100";
				x_p_2_tb <= "11001101";
				w_p_2_tb <= "011110111";
				x_p_3_tb <= "10111011";
				w_p_3_tb <= "011011001";
				x_p_4_tb <= "11110100";
				w_p_4_tb <= "011101110";
				x_p_5_tb <= "00011000";
				w_p_5_tb <= "101000110";
				x_p_6_tb <= "10011100";
				w_p_6_tb <= "101111010";
				x_p_7_tb <= "10011011";
				w_p_7_tb <= "001001110";
				x_p_8_tb <= "11101100";
				w_p_8_tb <= "010111011";
				x_p_9_tb <= "11101010";
				w_p_9_tb <= "011001000";
				wait for 400 ns;
				x_p_0_tb <= "11111010";
				w_p_0_tb <= "010001010";
				x_p_1_tb <= "11000111";
				w_p_1_tb <= "000000011";
				x_p_2_tb <= "01001000";
				w_p_2_tb <= "101111100";
				x_p_3_tb <= "11101111";
				w_p_3_tb <= "001110001";
				x_p_4_tb <= "01110101";
				w_p_4_tb <= "010110100";
				x_p_5_tb <= "00101011";
				w_p_5_tb <= "011010110";
				x_p_6_tb <= "11100101";
				w_p_6_tb <= "101011100";
				x_p_7_tb <= "10101010";
				w_p_7_tb <= "110101010";
				x_p_8_tb <= "00110011";
				w_p_8_tb <= "010101010";
				x_p_9_tb <= "10010000";
				w_p_9_tb <= "011110001";
				wait for 400 ns;
				x_p_0_tb <= "11110100";
				w_p_0_tb <= "100001110";
				x_p_1_tb <= "01111100";
				w_p_1_tb <= "010111100";
				x_p_2_tb <= "00001001";
				w_p_2_tb <= "001010111";
				x_p_3_tb <= "10101101";
				w_p_3_tb <= "011010011";
				x_p_4_tb <= "10101101";
				w_p_4_tb <= "010101001";
				x_p_5_tb <= "00001010";
				w_p_5_tb <= "100111100";
				x_p_6_tb <= "10011110";
				w_p_6_tb <= "000111011";
				x_p_7_tb <= "10110010";
				w_p_7_tb <= "011001110";
				x_p_8_tb <= "11100110";
				w_p_8_tb <= "010000110";
				x_p_9_tb <= "10011100";
				w_p_9_tb <= "001001010";
				wait for 400 ns;
				x_p_0_tb <= "00110011";
				w_p_0_tb <= "111010100";
				x_p_1_tb <= "01111010";
				w_p_1_tb <= "101001111";
				x_p_2_tb <= "10000010";
				w_p_2_tb <= "110000111";
				x_p_3_tb <= "10110110";
				w_p_3_tb <= "001000100";
				x_p_4_tb <= "11111011";
				w_p_4_tb <= "001010110";
				x_p_5_tb <= "01000101";
				w_p_5_tb <= "110111011";
				x_p_6_tb <= "10011101";
				w_p_6_tb <= "011100101";
				x_p_7_tb <= "01010001";
				w_p_7_tb <= "010011100";
				x_p_8_tb <= "01000111";
				w_p_8_tb <= "011000111";
				x_p_9_tb <= "01101110";
				w_p_9_tb <= "111000001";
				wait for 400 ns;
				x_p_0_tb <= "00011101";
				w_p_0_tb <= "011001100";
				x_p_1_tb <= "01111011";
				w_p_1_tb <= "001110010";
				x_p_2_tb <= "00000110";
				w_p_2_tb <= "100110110";
				x_p_3_tb <= "01001111";
				w_p_3_tb <= "110010001";
				x_p_4_tb <= "01000100";
				w_p_4_tb <= "101111110";
				x_p_5_tb <= "01010110";
				w_p_5_tb <= "000100111";
				x_p_6_tb <= "11110000";
				w_p_6_tb <= "111011011";
				x_p_7_tb <= "01110101";
				w_p_7_tb <= "010111110";
				x_p_8_tb <= "11110111";
				w_p_8_tb <= "111001000";
				x_p_9_tb <= "10001101";
				w_p_9_tb <= "100010010";
				wait for 400 ns;
				x_p_0_tb <= "01010011";
				w_p_0_tb <= "000110100";
				x_p_1_tb <= "00011110";
				w_p_1_tb <= "000000101";
				x_p_2_tb <= "01111011";
				w_p_2_tb <= "101000000";
				x_p_3_tb <= "00000000";
				w_p_3_tb <= "101001100";
				x_p_4_tb <= "11110001";
				w_p_4_tb <= "011010110";
				x_p_5_tb <= "00000110";
				w_p_5_tb <= "001011111";
				x_p_6_tb <= "11011001";
				w_p_6_tb <= "001000100";
				x_p_7_tb <= "00110000";
				w_p_7_tb <= "110000010";
				x_p_8_tb <= "10000101";
				w_p_8_tb <= "111001111";
				x_p_9_tb <= "11000110";
				w_p_9_tb <= "010110011";
				wait for 400 ns;
                testing  <= false;
        end process
end beh;