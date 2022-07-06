library IEEE;
use IEEE.std_logic_1164.all;

entity Parallel_Multiplier is 
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
end entity Parallel_Multiplier;

architecture beh of Parallel_Multiplier is

    component Signed_Parallel_Multiplier
        generic (
            Nbit_x: positive; -- Number of bits of the vector x_p
            Nbit_w: positive  -- Number of bits of the vector w_p
        );
        port(
            x_p_sign: in std_logic_vector(Nbit_x - 1 downto 0);
            w_p_sign: in std_logic_vector(Nbit_w - 1 downto 0);
            p_sign  : out std_logic_vector(Nbit_x + Nbit_w - 1 downto 0) -- Product vector with sign
        );
    end component Signed_Parallel_Multiplier; 

    component DFF_N is
        generic(N : integer);
            
        port( 
            clk     : in std_logic;
            a_rst_n : in std_logic;
            d       : in std_logic_vector(N - 1 downto 0);
            q       : out std_logic_vector(N - 1 downto 0)
        );
                
    end component DFF_N;

begin
    SPM_0: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_0,
            w_p_sign => w_p_0,
            p_sign   => p_0
        );

    SPM_1: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_1,
            w_p_sign => w_p_1,
            p_sign   => p_1
        );
    
    SPM_2: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_2,
            w_p_sign => w_p_2,
            p_sign   => p_2
        );

    SPM_3: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_3,
            w_p_sign => w_p_3,
            p_sign   => p_3
        );

    SPM_4: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_4,
            w_p_sign => w_p_4,
            p_sign   => p_4
        );

    SPM_5: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_5,
            w_p_sign => w_p_5,
            p_sign   => p_5
        );

    SPM_6: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_6,
            w_p_sign => w_p_6,
            p_sign   => p_6
        );


    SPM_7: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_7,
            w_p_sign => w_p_7,
            p_sign   => p_7
        );

    SPM_8: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_8,
            w_p_sign => w_p_8,
            p_sign   => p_8
        );

    SPM_9: Signed_Parallel_Multiplier
        generic map(
            Nbit_x => 8,
            Nbit_w => 9
        )
        port map(
            x_p_sign => x_p_9,
            w_p_sign => w_p_9,
            p_sign   => p_9
        );
        
end architecture beh;

