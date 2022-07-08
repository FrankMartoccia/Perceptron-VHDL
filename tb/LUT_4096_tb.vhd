library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LUT_4096_tb is
end LUT_4096_tb;

architecture beh of LUT_4096_tb is

	-- Constants
	
	constant clk_period     : time := 100 ns; -- Clock period
	
	component LUT_4096
	port (
		address : in  std_logic_vector(12 downto 0);
		sigmoid_out : out std_logic_vector(15 downto 0) 
	);
	end component LUT_4096;
	
	-- Signals used in the TB 

    signal address_tb : std_logic_vector(12 downto 0) := (others => '0');
    signal sigmoid_out_tb : std_logic_vector(15 downto 0); 
	signal address_value_tb : integer range 0 to 4096 := 0;
	
	signal clk     : std_logic := '0';
	signal testing : boolean := true;
	
	begin
		clk <= not clk after clk_period/2 when testing else '0';
		
		-- Definition of the DUT
		
		dut: LUT_4096
		port map (
			address => address_tb,
			sigmoid_out => sigmoid_out_tb
		);
			
	-- Definition of the stimuli to apply to the dut
	
		stimulus : process
			begin
				wait for 200 ns;
				for i in 0 to 4095 loop
					address_tb <= std_logic_vector(to_unsigned(address_value_tb, 13));
					address_value_tb <= address_value_tb + 1;
					wait for 400 ns;
				end loop;
                testing  <= false;
		end process;
end beh;