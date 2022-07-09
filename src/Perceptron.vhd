library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Perceptron is
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
		
		s_out: out std_logic_vector(15 downto 0) --Output of the Perceptron
    );
end Perceptron;

architecture beh of Perceptron is

	component DFF_N is
		generic(N : integer);
			
		port( 
			clk     : in std_logic;
			a_rst_n : in std_logic;
			d       : in std_logic_vector(N - 1 downto 0);
			q       : out std_logic_vector(N - 1 downto 0)
		);
				
	end component DFF_N;
	
	component Parallel_Multiplier is 
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
	
	component Adder_Tree is 
		port(
			-- Values of the products that have to be summed
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
			b: in std_logic_vector(8 downto 0); -- Bias
			
			sum: out std_logic_vector(20 downto 0) -- Sum vector

		);
	end component Adder_Tree;
	
	-- Look Up table
	component LUT_4096 is
		port (
			address : in  std_logic_vector(11 downto 0);
			sigmoid_out : out std_logic_vector(15 downto 0) 
		);
	end component LUT_4096;
	
	-- Output signals of the first layer of registers
	signal x_0_r1_out: std_logic_vector(7 downto 0);
	signal x_1_r1_out: std_logic_vector(7 downto 0);
	signal x_2_r1_out: std_logic_vector(7 downto 0);
	signal x_3_r1_out: std_logic_vector(7 downto 0);
	signal x_4_r1_out: std_logic_vector(7 downto 0);
	signal x_5_r1_out: std_logic_vector(7 downto 0);
	signal x_6_r1_out: std_logic_vector(7 downto 0);
	signal x_7_r1_out: std_logic_vector(7 downto 0);
	signal x_8_r1_out: std_logic_vector(7 downto 0);
	signal x_9_r1_out: std_logic_vector(7 downto 0);

	signal w_0_r1_out: std_logic_vector(8 downto 0);
	signal w_1_r1_out: std_logic_vector(8 downto 0);
	signal w_2_r1_out: std_logic_vector(8 downto 0);
	signal w_3_r1_out: std_logic_vector(8 downto 0);
	signal w_4_r1_out: std_logic_vector(8 downto 0);
	signal w_5_r1_out: std_logic_vector(8 downto 0);
	signal w_6_r1_out: std_logic_vector(8 downto 0);
	signal w_7_r1_out: std_logic_vector(8 downto 0);
	signal w_8_r1_out: std_logic_vector(8 downto 0);
	signal w_9_r1_out: std_logic_vector(8 downto 0);
	
	signal b_r1_out  : std_logic_vector(8 downto 0);
	
	-- Input signals of the second layer of registers
	signal p_0_r2_in: std_logic_vector(16 downto 0);
	signal p_1_r2_in: std_logic_vector(16 downto 0);
	signal p_2_r2_in: std_logic_vector(16 downto 0);
	signal p_3_r2_in: std_logic_vector(16 downto 0);
	signal p_4_r2_in: std_logic_vector(16 downto 0);
	signal p_5_r2_in: std_logic_vector(16 downto 0);
	signal p_6_r2_in: std_logic_vector(16 downto 0);
	signal p_7_r2_in: std_logic_vector(16 downto 0);
	signal p_8_r2_in: std_logic_vector(16 downto 0);
	signal p_9_r2_in: std_logic_vector(16 downto 0);
	
	-- Output signals of the second layer of registers	
	signal p_0_r2_out: std_logic_vector(16 downto 0);
	signal p_1_r2_out: std_logic_vector(16 downto 0);
	signal p_2_r2_out: std_logic_vector(16 downto 0);
	signal p_3_r2_out: std_logic_vector(16 downto 0);
	signal p_4_r2_out: std_logic_vector(16 downto 0);
	signal p_5_r2_out: std_logic_vector(16 downto 0);
	signal p_6_r2_out: std_logic_vector(16 downto 0);
	signal p_7_r2_out: std_logic_vector(16 downto 0);
	signal p_8_r2_out: std_logic_vector(16 downto 0);
	signal p_9_r2_out: std_logic_vector(16 downto 0);
	
	signal s_r3_in : std_logic_vector(20 downto 0); -- Input signal of the last register
	signal s_r3_out: std_logic_vector(20 downto 0); -- Output signal of the last register
	
	signal s_lut_in: std_logic_vector(20 downto 0); -- Input of the LUT (2's complement if is negative)
	signal s_lut_out: std_logic_vector(15 downto 0); -- Output of the LUT
	
begin
	
    lut_process: process(s_r3_out, s_lut_out)
    begin
		-- The 2's complement is needed if the input of the LUT is negative
        if(s_r3_out(20) = '0') then
            s_lut_in <= s_r3_out;
        else
            s_lut_in <= std_logic_vector(unsigned(not(s_r3_out)) + 1);
        end if;
		-- If the input of the LUT is negative, we get the output of the Perceptron
		-- from the output of the LUT exploiting simmetry
        if (s_r3_out(20) = '0') then 
            s_out <= std_logic_vector(unsigned(s_lut_out));
        else
            s_out <= std_logic_vector(32766 - unsigned(s_lut_out));
        end if;
    end process;	
	
	-- Registers of the first layer
	-- Registers of the x input vectors
	REG_0_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_0,
			q => x_0_r1_out
		);

	REG_1_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_1,
			q => x_1_r1_out
		);

	REG_2_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_2,
			q => x_2_r1_out
		);

	REG_3_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_3,
			q => x_3_r1_out
		);

	REG_4_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_4,
			q => x_4_r1_out
		);
		
	REG_5_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_5,
			q => x_5_r1_out
		);
		
	REG_6_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_6,
			q => x_6_r1_out
		);
		
	REG_7_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_7,
			q => x_7_r1_out
		);
		
	REG_8_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_8,
			q => x_8_r1_out
		);
		
	REG_9_x: DFF_N
		generic map(
			N => 8
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => x_9,
			q => x_9_r1_out
		);
		
	-- Registers of the w input vectors
	REG_0_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_0,
			q => w_0_r1_out
		);
		
	REG_1_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_1,
			q => w_1_r1_out
		);
		
	REG_2_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_2,
			q => w_2_r1_out
		);
		
	REG_3_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_3,
			q => w_3_r1_out
		);
		
	REG_4_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_4,
			q => w_4_r1_out
		);
		
	REG_5_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_5,
			q => w_5_r1_out
		);
		
	REG_6_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_6,
			q => w_6_r1_out
		);
		
	REG_7_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_7,
			q => w_7_r1_out
		);
		
	REG_8_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_8,
			q => w_8_r1_out
		);
		
	REG_9_w: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => w_9,
			q => w_9_r1_out
		);
		
	REG_b: DFF_N
		generic map(
			N => 9
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => b,
			q => b_r1_out
		);
		
	PM: Parallel_Multiplier
		port map(
			x_p_0 => x_0_r1_out,
			x_p_1 => x_1_r1_out,
			x_p_2 => x_2_r1_out,
			x_p_3 => x_3_r1_out,
			x_p_4 => x_4_r1_out,
			x_p_5 => x_5_r1_out,
			x_p_6 => x_6_r1_out,
			x_p_7 => x_7_r1_out,
			x_p_8 => x_8_r1_out,
			x_p_9 => x_9_r1_out,
			
			w_p_0 => w_0_r1_out,
			w_p_1 => w_1_r1_out,
			w_p_2 => w_2_r1_out,
			w_p_3 => w_3_r1_out,
			w_p_4 => w_4_r1_out,
			w_p_5 => w_5_r1_out,
			w_p_6 => w_6_r1_out,
			w_p_7 => w_7_r1_out,
			w_p_8 => w_8_r1_out,
			w_p_9 => w_9_r1_out,
			
			p_0 => p_0_r2_in,
			p_1 => p_1_r2_in,
			p_2 => p_2_r2_in,
			p_3 => p_3_r2_in,
			p_4 => p_4_r2_in,
			p_5 => p_5_r2_in,
			p_6 => p_6_r2_in,
			p_7 => p_7_r2_in,
			p_8 => p_8_r2_in,
			p_9 => p_9_r2_in
		);
			
	-- Registers of the second layer			
	REG_0_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_0_r2_in,
			q => p_0_r2_out
		);	

	REG_1_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_1_r2_in,
			q => p_1_r2_out
		);	

	REG_2_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_2_r2_in,
			q => p_2_r2_out
		);	

	REG_3_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_3_r2_in,
			q => p_3_r2_out
		);	

	REG_4_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_4_r2_in,
			q => p_4_r2_out
		);	

	REG_5_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_5_r2_in,
			q => p_5_r2_out
		);	

	REG_6_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_6_r2_in,
			q => p_6_r2_out
		);	

	REG_7_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_7_r2_in,
			q => p_7_r2_out
		);	

	REG_8_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_8_r2_in,
			q => p_8_r2_out
		);	

	REG_9_p: DFF_N
		generic map(
			N => 17
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => p_9_r2_in,
			q => p_9_r2_out
		);		

	AT: Adder_Tree
		port map(
			l1_s1_in1 => p_0_r2_out,
			l1_s1_in2 => p_1_r2_out,
			l1_s2_in1 => p_2_r2_out,
			l1_s2_in2 => p_3_r2_out,
			l1_s3_in1 => p_4_r2_out,
			l1_s3_in2 => p_5_r2_out,
			l1_s4_in1 => p_6_r2_out,
			l1_s4_in2 => p_7_r2_out,
			l1_s5_in1 => p_8_r2_out,
			l1_s5_in2 => p_9_r2_out,
			
			clk => clk,
			rst => rst,
			b => b_r1_out,
			
			sum => s_r3_in
		);
	
	-- Register of the sum value 
	REG_s: DFF_N
		generic map(
			N => 21
		)
		port map(
			clk => clk,
			a_rst_n => rst,
			d => s_r3_in,
			q => s_r3_out
		);		

	LUT: LUT_4096
		port map(
			address => s_lut_in(18 downto 7),
			sigmoid_out => s_lut_out
		);
end beh;	
	