library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder_Tree is 
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
end entity Adder_Tree;

architecture beh of Adder_Tree is 
    
    component DFF_N 
        generic( N : integer);        
        port( 
            clk     : in std_logic;
            a_rst_n : in std_logic;
            d       : in std_logic_vector(N - 1 downto 0);
            q       : out std_logic_vector(N - 1 downto 0)
        );
    end component DFF_N;

    component Ripple_carry_adder
        generic (Nbit : positive);
        port (
          a    : in std_logic_vector(Nbit - 2 downto 0);
          b    : in std_logic_vector(Nbit - 2 downto 0);
          cin  : in std_logic;
          s    : out std_logic_vector (Nbit - 1 downto 0);
          cout : out std_logic
        );
    end component Ripple_carry_adder;

     -- Output signals for the adders in the first layer
     signal l1_s1_out: std_logic_vector(17 downto 0);
     signal l1_s2_out: std_logic_vector(17 downto 0);
     signal l1_s3_out: std_logic_vector(17 downto 0);
     signal l1_s4_out: std_logic_vector(17 downto 0);
     signal l1_s5_out: std_logic_vector(17 downto 0);

     -- Input signals for the adders in the second layer
     signal l2_s1_in1: std_logic_vector(17 downto 0);
     signal l2_s1_in2: std_logic_vector(17 downto 0);
     signal l2_s2_in1: std_logic_vector(17 downto 0);
     signal l2_s2_in2: std_logic_vector(17 downto 0);
     signal l2_s3_in1: std_logic_vector(17 downto 0);
    
     -- Output signals for the adders in the second layer
     signal l2_s1_out: std_logic_vector(18 downto 0);
     signal l2_s2_out: std_logic_vector(18 downto 0);
     signal l2_s3_out: std_logic_vector(19 downto 0);
     
     -- Input signals for the adders in the third layer
     signal l3_s1_in1: std_logic_vector(18 downto 0);
     signal l3_s1_in2: std_logic_vector(18 downto 0);
     
     -- Output signals for the adders in the third layer
     signal l3_s1_out: std_logic_vector(19 downto 0);
     
     -- Input signals for the adders in the fourth layer
     signal l4_s1_in1: std_logic_vector(19 downto 0);
     signal l4_s1_in2: std_logic_vector(19 downto 0);

     signal resized_b: std_logic_vector(18 downto 0);
	 signal resized_l2_s3_in1: std_logic_vector(18 downto 0);

begin

    resized_b <= std_logic_vector(resize(signed(b), resized_b'length)); -- Resize of the bias vector
	resized_l2_s3_in1 <= std_logic_vector(resize(signed(l2_s3_in1), resized_l2_s3_in1'length)); -- Resize of the l2_s3_in1 vector

    -- First layer of adders
    l1_s1: Ripple_carry_adder 
        generic map(
            Nbit => 18
        )
        port map(
            a => l1_s1_in1,
            b => l1_s1_in2,
            cin => '0',
            s => l1_s1_out,
            cout => open
        );
    l1_r1: DFF_N
        generic map(
            N => 18
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l1_s1_out,
            q => l2_s1_in1
        );

    l1_s2: Ripple_carry_adder 
        generic map(
            Nbit => 18
        )
        port map(
            a => l1_s2_in1,
            b => l1_s2_in2,
            cin => '0',
            s => l1_s2_out,
            cout => open
        );
    l1_r2: DFF_N
        generic map(
            N => 18
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l1_s2_out,
            q => l2_s1_in2
        );

    l1_s3: Ripple_carry_adder 
        generic map(
            Nbit => 18
        )
        port map(
            a => l1_s3_in1,
            b => l1_s3_in2,
            cin => '0',
            s => l1_s3_out,
            cout => open
        );
    l1_r3: DFF_N
        generic map(
            N => 18
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l1_s3_out,
            q => l2_s2_in1
        );

    l1_s4: Ripple_carry_adder 
        generic map(
            Nbit => 18
        )
        port map(
            a => l1_s4_in1,
            b => l1_s4_in2,
            cin => '0',
            s => l1_s4_out,
            cout => open
        );
    l1_r4: DFF_N
        generic map(
            N => 18
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l1_s4_out,
            q => l2_s2_in2
        );

    l1_s5: Ripple_carry_adder 
        generic map(
            Nbit => 18
        )
        port map(
            a => l1_s5_in1,
            b => l1_s5_in2,
            cin => '0',
            s => l1_s5_out,
            cout => open
        );
    l1_r5: DFF_N
        generic map(
            N => 18
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l1_s5_out,
            q => l2_s3_in1
        );

    -- Second layer of adders
    l2_s1: Ripple_carry_adder 
        generic map(
            Nbit => 19
        )
        port map(
            a => l2_s1_in1,
            b => l2_s1_in2,
            cin => '0',
            s => l2_s1_out,
            cout => open
        );
    l2_r1: DFF_N
        generic map(
            N => 19
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l2_s1_out,
            q => l3_s1_in1
        );

    l2_s2: Ripple_carry_adder 
        generic map(
            Nbit => 19
        )
        port map(
            a => l2_s2_in1,
            b => l2_s2_in2,
            cin => '0',
            s => l2_s2_out,
            cout => open
        );
    l2_r2: DFF_N
        generic map(
            N => 19
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l2_s2_out,
            q => l3_s1_in2
        );

    l2_s3: Ripple_carry_adder 
        generic map(
            Nbit => 20
        )
        port map(
            a => resized_l2_s3_in1,
            b => resized_b,
            cin => '0',
            s => l2_s3_out,
            cout => open
        );
    l2_r3: DFF_N
        generic map(
            N => 20
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l2_s3_out,
            q => l4_s1_in2
        );

    -- Third layer of adders
    l3_s1: Ripple_carry_adder 
        generic map(
            Nbit => 20
        )
        port map(
            a => l3_s1_in1,
            b => l3_s1_in2,
            cin => '0',
            s => l3_s1_out,
            cout => open
        );
    l3_r1: DFF_N
        generic map(
            N => 20
        )
        port map(
            clk => clk,
            a_rst_n => rst,
            d => l3_s1_out,
            q => l4_s1_in1
        );

    -- Fourth layer of adders
    l4_s1: Ripple_carry_adder 
        generic map(
            Nbit => 21
        )
        port map(
            a => l4_s1_in1,
            b => l4_s1_in2,
            cin => '0',
            s => sum,
            cout => open
        );

end architecture beh;