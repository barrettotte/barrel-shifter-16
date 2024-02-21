library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end entity top_tb;

architecture test of top_tb is
    constant c_clk_period : time := 50ns;
    signal i_clk_tb       : std_logic := '0';
    signal i_left_btn_tb  : std_logic := '0';
    signal i_right_btn_tb : std_logic := '0';
    signal o_data_tb      : std_logic_vector(15 downto 0);
begin
    -- clock toggle
    process begin
        i_clk_tb <= '0';
        wait for c_clk_period / 2;
        i_clk_tb <= '1';
        wait for c_clk_period / 2;
    end process;
    
    dut : entity work.top
        port map (
            i_clk       => i_clk_tb,
            i_left_btn  => i_left_btn_tb,
            i_right_btn => i_right_btn_tb,
            o_data      => o_data_tb
        );

    -- stimulus
    process begin
        wait for 5ns;

        -- test right button pressed
        i_left_btn_tb <= '0';
        i_right_btn_tb <= '1';
        wait for 100ns;
        assert o_data_tb = "0000011110001000" report "Right shift test failed" severity error;

        -- test left button pressed
        i_left_btn_tb <= '1';
        i_right_btn_tb <= '0';
        wait for 100ns;
        assert o_data_tb = "0001111000100000" report "Left shift test failed" severity error;

        -- test no buttons pressed
        i_left_btn_tb <= '0';
        i_right_btn_tb <= '0';
        wait for 100ns;
        assert o_data_tb = "0000111100010000"  report "No shift test failed" severity error;

        -- test both buttons pressed
        i_left_btn_tb <= '1';
        i_right_btn_tb <= '1';
        wait for 100ns;
        assert o_data_tb = "0000111100010000"  report "Both shifts test failed" severity error;

        -- done
        wait;
    end process;

end architecture test;
