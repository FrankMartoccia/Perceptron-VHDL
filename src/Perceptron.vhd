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

    );
