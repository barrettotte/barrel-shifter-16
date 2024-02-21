library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_tb is
end entity mux2x1_tb;

architecture test of mux2x1_tb is
    signal i_a_tb   : std_logic_vector(7 downto 0) := "000000000";
    signal i_b_tb   : std_logic_vector(7 downto 0) := "000000001";
    signal i_sel_tb : std_logic := '0';
    signal o_d_tb   : std_logic_vector(7 downto 0);
begin
    dut : entity work.mux2x1
        generic map (
            c_bits => 8
        )
        port map(
            i_a   => i_a_tb,
            i_b   => i_b_tb,
            i_sel => i_sel_tb,
            o_d   => o_d_tb
        );
    
    process begin
        -- output a
        wait for 10ns;

        -- output b
        i_sel_tb <= '1';
        wait for 10ns;

        -- output a
        i_sel_tb <= '0';
        wait for 10ns;

        -- output b
        i_sel_tb <= '1';
        wait for 10ns;

        -- done
        wait;
    end process;

end architecture test;
