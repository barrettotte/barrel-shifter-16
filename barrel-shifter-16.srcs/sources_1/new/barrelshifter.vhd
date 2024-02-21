library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrelshifter is
    generic (
        c_bits       : integer := 16;
        c_shift_bits : integer := 4
    );
    port (
        i_data  : in std_logic_vector(c_bits-1 downto 0);
        i_left  : in std_logic;
        i_shift : in std_logic_vector(c_shift_bits-1 downto 0);        
        o_data  : out std_logic_vector(c_bits-1 downto 0)
    );
end entity barrelshifter;

architecture behavioral of barrelshifter is
    signal shift_target : std_logic_vector(c_bits-1 downto 0);
    signal shifted : std_logic_vector(c_bits-1 downto 0);

    -- https://stackoverflow.com/questions/13584307/reverse-bit-order-on-vhdl
    function reverse_any_vector (a: in std_logic_vector)
    return std_logic_vector is
        variable result: std_logic_vector(a'range);
        alias aa: std_logic_vector(a'reverse_range) is a;
    begin
        for i in aa'range loop
            result(i) := aa(i);
        end loop;
        return result;
    end;

begin
    shift_target <= i_data when i_left = '0' else reverse_any_vector(i_data);
    shifted <= std_logic_vector(shift_right(unsigned(shift_target), to_integer(unsigned(i_shift))));
    o_data <= shifted when i_left = '0' else reverse_any_vector(shifted);
end architecture behavioral;
