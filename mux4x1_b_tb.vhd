library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- We need the input_array type too
type input_array is array (0 to 3) of std_logic_vector(3 downto 0);

entity tb_mux4x1_b is
-- Testbench has no ports
end tb_mux4x1_b;

architecture Behavioral of tb_mux4x1_b is

    -- Component declaration
    component mux4x1_b
        Port ( 
            A  : in  input_array;
            S  : in  STD_LOGIC_VECTOR (1 downto 0);
            B  : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals to connect to the MUX
    signal A_tb : input_array := (
        0 => "0001",
        1 => "0010",
        2 => "0100",
        3 => "1000"
    );
    signal S_tb : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal B_tb : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the MUX
    UUT: mux4x1_b
        port map(
            A => A_tb,
            S => S_tb,
            B => B_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply all select values
        S_tb <= "00"; wait for 10 ns;
        S_tb <= "01"; wait for 10 ns;
        S_tb <= "10"; wait for 10 ns;
        S_tb <= "11"; wait for 10 ns;

        -- Finish simulation
        wait;
    end process;

end Behavioral;
