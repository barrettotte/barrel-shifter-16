library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        i_clk       : in std_logic;
        i_left_btn  : in std_logic;
        i_right_btn : in std_logic;
        o_data      : out std_logic_vector(15 downto 0)
    );
end top;

architecture rtl of top is
    signal example_data : std_logic_vector(15 downto 0) := "0000111100010000";
    signal shift_dir : std_logic := '0';
    signal shift_amt : std_logic_vector(3 downto 0) := "0000";
begin
    process(i_clk) is begin
        if (rising_edge(i_clk)) then
            if (i_left_btn = '1' and i_right_btn = '1') then
                -- don't do anything when both buttons pressed
                shift_amt <= "0000";
                shift_dir <= '0';
            elsif (i_left_btn = '1') then
                shift_amt <= "0001";
                shift_dir <= '1';
            elsif (i_right_btn = '1') then
                shift_amt <= "0001";
                shift_dir <= '0';
            else
                shift_amt <= "0000";
                shift_dir <= '0';
            end if;
        end if;
    end process;

    shifter : entity work.barrelshifter
        generic map (
            c_bits => 16,
            c_shift_bits => 4
        )
        port map(
            i_data  => example_data,
            i_left  => shift_dir,
            i_shift => shift_amt,
            o_data  => o_data
        );
end rtl;
