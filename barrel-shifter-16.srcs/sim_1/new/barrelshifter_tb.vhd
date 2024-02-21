library ieee;
use ieee.std_logic_1164.all;

entity barrelshifter_tb is
end entity barrelshifter_tb;

architecture test of barrelshifter_tb is
    signal i_data_tb  : std_logic_vector(15 downto 0) := (others => '0');
    signal i_left_tb  : std_logic := '0';
    signal i_shift_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal o_data_tb  : std_logic_vector(15 downto 0);
begin
    dut : entity work.barrelshifter
        generic map (
            c_bits => 16,
            c_shift_bits => 4
        )
        port map (
            i_data  => i_data_tb,
            i_left  => i_left_tb,
            i_shift => i_shift_tb,
            o_data  => o_data_tb
        );

    stimulus:
    process begin
        wait for 5ns;

        -- test right shift
        i_data_tb <= "0000000011111111";
        i_left_tb <= '0';
        i_shift_tb <= "0100";
        wait for 10ns;

        -- test left shift
        i_data_tb <= "0000000011111111";
        i_left_tb <= '1';
        i_shift_tb <= "0011";
        wait for 10ns;

        -- done
        wait;
    end process stimulus;

end architecture test;
