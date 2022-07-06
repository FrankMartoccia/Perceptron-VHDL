library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Signed_Parallel_Multiplier is 
    generic (
        Nbit_x: positive; -- Number of bits of the vector x_p
        Nbit_w: positive  -- Number of bits of the vector w_p
    );
    port(
        x_p_sign: in std_logic_vector(Nbit_x - 1 downto 0);
        w_p_sign: in std_logic_vector(Nbit_w - 1 downto 0);
        p_sign  : out std_logic_vector(Nbit_x + Nbit_w - 1 downto 0) -- Product vector with sign
    );
end entity Signed_Parallel_Multiplier;

architecture beh of Signed_Parallel_Multiplier is 

	component Unsigned_Parallel_Multiplier
		generic (
			Nbit_x: positive;
			Nbit_w: positive
		);
		port(
			x_p: in std_logic_vector(Nbit_x - 1 downto 0);
			w_p: in std_logic_vector(Nbit_w - 1 downto 0);
			p  : out std_logic_vector(Nbit_x + Nbit_w - 1 downto 0) -- Product vector without sign
			);
	end component Unsigned_Parallel_Multiplier;

	signal x_sign    : std_logic; -- Sign of the x_p_sign vector
    signal w_sign    : std_logic; -- Sign of the w_p_sign vector
	signal x_p_unsign: std_logic_vector(Nbit_x - 1 downto 0); -- x_p vector without sign
    signal w_p_unsign: std_logic_vector(Nbit_w - 1 downto 0); -- w_p vector without sign
    signal p_unsign  : std_logic_vector(Nbit_x + Nbit_w - 1 downto 0); -- p vector without sign
	
begin
	
	x_sign <= x_p_sign(Nbit_x - 1); -- Value of the MSB used for the sign representation of the x_p_sign vector
    w_sign <= w_p_sign(Nbit_w - 1); -- Value of the MSB used for the sign representation of the w_p_sign vector
	x_p_unsign <= std_logic_vector(abs(signed(x_p_sign))); -- Absolute value of the signal to pass to the Unsigned_Parallel_Multiplier
	w_p_unsign <= std_logic_vector(abs(signed(w_p_sign))); -- Absolute value of the signal to pass to the Unsigned_Parallel_Multiplier
	p_sign <= std_logic_vector(unsigned(not(p_unsign)) + 1) when ((x_sign xor w_sign) = '1') else p_unsign;
	
	UPM: Unsigned_Parallel_Multiplier
		generic map(
            Nbit_x => Nbit_x,
            Nbit_w => Nbit_w
        )
        port map(
            x_p => x_p_unsign,
            w_p => w_p_unsign,
            p   => p_unsign
        );
	
end architecture beh;