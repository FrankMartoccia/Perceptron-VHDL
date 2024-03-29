library ieee;
use ieee.std_logic_1164.all;

entity DFF_N is
	generic(N : integer);
		
	port( 
		clk     : in std_logic;
		a_rst_n : in std_logic;
		d       : in std_logic_vector(N - 1 downto 0);
		q       : out std_logic_vector(N - 1 downto 0)
	);
			
end DFF_N;

architecture struct of DFF_N is   
  begin
   
  ddf_n_proc: process(clk, a_rst_n)
		begin
			if(a_rst_n = '0') then
				q <= (others => '0');
			elsif(rising_edge(clk)) then
				q <= d;
			end if;
		end process;
   
end struct;
    