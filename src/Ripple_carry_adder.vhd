library IEEE;
use IEEE.std_logic_1164.all;

entity Ripple_carry_adder is
  generic (Nbit : positive);
  port (
    a    : in std_logic_vector(Nbit - 2 downto 0);
    b    : in std_logic_vector(Nbit - 2 downto 0);
    cin  : in std_logic;
    s    : out std_logic_vector (Nbit - 1 downto 0);
    cout : out std_logic
  );
end Ripple_carry_adder;


architecture beh of Ripple_carry_adder is 

component full_adder is
  port (
    a    : in  std_logic;
    b    : in  std_logic;
    cin  : in  std_logic;
    s    : out std_logic;
    cout : out std_logic
  );
end component;

signal carry : std_logic_vector (Nbit - 1 downto 1);

begin

GEN: for i in 1 to Nbit generate

	FIRST_FA: if i = 1 generate
		FA_1: full_adder 
			port map (
				a    => a(i-1),
				b    => b(i-1),
				cin  => cin,
				s    => s(i-1),
				cout => carry(i)		
			);
	end generate FIRST_FA;
	
	INTERNAL_FA: if i > 1 and i < Nbit generate
		FA_M: full_adder 
			port map (
				a    => a(i-1),
				b    => b(i-1),
				cin  => carry(i-1),
				s    => s(i-1),
				cout => carry(i)		
			);			
	end generate INTERNAL_FA;	
	
	LAST_FA: if i = Nbit generate
		FA_LAST: full_adder
			port map(
				a    => a(Nbit-2),
				b    => b(Nbit-2),
				cin  => carry(Nbit-1),
				s    => s(Nbit-1),
				cout => cout
			);
	end generate LAST_FA;

end generate GEN;

end beh;










