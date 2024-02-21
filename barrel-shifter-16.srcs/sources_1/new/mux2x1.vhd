library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    generic (
        c_bits : integer := 1
    );
    port (
        i_a   : in std_logic_vector(c_bits-1 downto 0);
        i_b   : in std_logic_vector(c_bits-1 downto 0);
        i_sel : in std_logic;
        o_d   : out std_logic_vector(c_bits-1 downto 0)
    );
end entity mux2x1;

architecture rtl of mux2x1 is
begin
    o_d <= i_a when i_sel = '0' else i_b;
end architecture rtl;
