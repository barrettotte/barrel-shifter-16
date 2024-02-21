library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        i_data  : in std_logic_vector(15 downto 0);
        i_left  : in std_logic;
        i_shift : in std_logic_vector(15 downto 0);        
        o_data  : out std_logic_vector(15 downto 0)
    );
end top;

architecture behavioral of top is
begin
    shifter : entity work.barrelshifter
        generic map (
            c_bits => 16,
            c_shift_bits => 4
        )
        port map(
            i_data  => i_data,
            i_left  => i_left,
            i_shift => i_shift,
            o_data  => o_data
        );
end behavioral;
