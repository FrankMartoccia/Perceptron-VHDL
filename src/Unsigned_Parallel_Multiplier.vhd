library IEEE;
use IEEE.std_logic_1164.all;

entity Unsigned_Parallel_Multiplier is
    generic (
        Nbit_x: positive; -- Number of bits of the vector x_p
        Nbit_w: positive   -- Number of bits of the vector w_p
    );
    port(
        x_p: in std_logic_vector(Nbit_x - 1 downto 0); 
        w_p: in std_logic_vector(Nbit_w - 1 downto 0);
        p  : out std_logic_vector(Nbit_x + Nbit_w - 1 downto 0) -- Product vector
    );
end entity Unsigned_Parallel_Multiplier;

architecture beh of Unsigned_Parallel_Multiplier is
    component FULL_ADDER is
    port
    (
        a    : IN std_logic ;
        b    : IN std_logic ;
        cin  : IN std_logic ;
        s    : OUT std_logic ;
        cout : OUT std_logic 
    );
    end component;
    
    component HALF_ADDER is
    port
    (
        a    : IN std_logic ;
        b    : IN std_logic ;
        s    : OUT std_logic ;
        cout : OUT std_logic 
    );
    end component;
	
	signal carry_signal: std_logic_vector((Nbit_x)*(Nbit_w-1) - 1 downto 0); -- Vector that mantains the values of the carry
	signal sum_signal: std_logic_vector((Nbit_x - 1)*(Nbit_w - 2) - 1 downto 0); -- Vector that mantains the values of the sums
	signal product: std_logic_vector((Nbit_x*Nbit_w)-1 downto 0); -- Vector that mantains the values of the partial products
	
begin
	-- Process that computes the values of the partial products and initializes the values of the product vector
	p_process : process(x_p,w_p)
	begin
		for i in 0 to Nbit_w-1 loop
			for j in 0 to Nbit_x-1 loop
				product((i*Nbit_x) + j) <= x_p(j) and w_p(i);
			end loop;
		end loop;
	end process p_process;
	
	p(0) <= product(0); -- Setting of the first bit of the result
	
	-- Generation of the Unsigned Parallel Multiplier's components 
	GEN_row: for i in 1 to Nbit_w-1 generate
		GEN_column: for j in 0 to Nbit_x-1 generate
		FIRST_ROW: 		if i = 1 generate
			RIGHT_HA: 		if j = 0 generate
								FIRST_ROW: HALF_ADDER
								port map 
								(
									a => product(1),
									b => product(Nbit_x),
									s => p(1), -- Setting of the second bit of the result
									cout => carry_signal(j)
								);
			end generate RIGHT_HA;
			CENTRAL_FA: 		if j > 0 and j < Nbit_x-1 generate
								FIRST_ROW: FULL_ADDER
								port map 
								(
									a => product(j+1),
									b => product(Nbit_x+j),
									cin => carry_signal(j-1),
									s => sum_signal(j-1),
									cout => carry_signal(j)
								);
			end generate CENTRAL_FA;
			LEFT_HA:			if j = Nbit_x-1 generate
								FIRST_ROW: HALF_ADDER
								port map
								(
									a => carry_signal(j-1),
									b => product(Nbit_x+j),
									s => sum_signal(j-1),
									cout => carry_signal(j)
								);
			end generate LEFT_HA;
		end generate FIRST_ROW;
		
		INTERNAL_ROW:	if i > 1 and i < Nbit_w-1 generate
			RIGHT_HA:		if j = 0 generate
								INTERNAL_ROW: HALF_ADDER
								port map
								(
									a => sum_signal((Nbit_x-1)*(i-2)),
									b => product(Nbit_x*i),
									s => p(i), -- Setting of the i-bit of the result
									cout => carry_signal(Nbit_x*(i-1))
								);
			end generate RIGHT_HA;
			CENTRAL_FA:			if j > 0 and j < Nbit_x-1 generate
								INTERNAL_ROW: FULL_ADDER
								port map
								(
									a => sum_signal((Nbit_x-1)*(i-2) + j),
									b => product((Nbit_x*i) + j),
									cin => carry_signal(Nbit_x*(i-1) + j-1),
									s => sum_signal((Nbit_x-1)*(i-1) + j-1),
									cout => carry_signal((Nbit_x*(i-1)) + j)
								);
			end generate CENTRAL_FA;
			LEFT_FA: 			if j = Nbit_x-1 generate
								INTERNAL_ROW: FULL_ADDER
								port map
								(
									a => carry_signal((Nbit_x)*(i-1) - 1),
									b => product((Nbit_x*i) + j),
									cin => carry_signal(Nbit_x*(i-1) + j-1),
									s => sum_signal((Nbit_x-1)*(i-1) + j-1),
									cout => carry_signal((Nbit_x*(i-1)) + j)
								);
			end generate LEFT_FA;
		end generate INTERNAL_ROW;
			
		LAST_ROW:		if i = Nbit_w-1 generate
			RIGHT_HA:		if j = 0 generate
							LAST_ROW: HALF_ADDER
							port map
							(
								a => sum_signal((Nbit_x-1)*(i-2)),
								b => product(Nbit_x*i),
								s => p(i),
								cout => carry_signal(Nbit_x*(i-1))
							);
			end generate RIGHT_HA;
			CENTRAL_FA:		if j > 0 and j < Nbit_x-1 generate
							LAST_ROW: FULL_ADDER
							port map
							(
								a => sum_signal((Nbit_x-1)*(i-2) + j),
								b => product((Nbit_x*i) + j),
								cin => carry_signal(Nbit_x*(i-1) + j-1),
								s => p(i+j), -- Setting of the internal bits of the result
								cout => carry_signal((Nbit_x*(i-1)) + j)
								);
			end generate CENTRAL_FA;
			LEFT_FA:		if j = Nbit_x-1 generate
							LAST_ROW: FULL_ADDER
							port map
							(
								a => carry_signal((Nbit_x)*(i-1) - 1),
								b => product((Nbit_x*i) + j),
								cin => carry_signal(Nbit_x*(i-1) + j-1),
								s => p(i+j), -- Setting of the last bit of the result
								cout => p(i+j+1)
							);
			end generate LEFT_FA;
		end generate LAST_ROW;
		end generate GEN_column;
	end generate GEN_row;
end architecture beh;