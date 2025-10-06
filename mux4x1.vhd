library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

type input_array is array (0 to 3) of std_logic_vector(3 downto 0);


entity mux4x1_b is
    Port ( 
        A  : in  input_array;
        S  : in  STD_LOGIC_VECTOR (1 downto 0);
        B   : out STD_LOGIC_VECTOR (3 downto 0);
    );
end mux4x1_b;

architecture behavioral of mux4x1_b is
begin
    process(A, S)
       case S is
            when "00" =>
                B <= A(0);
            when "01" =>
                B <= A(1);
            when "10" =>
                B <= A(2);
            when "11" =>
                B <= A(3);
            when others =>
                B <= (others => '0');
        end case;
    end process;
end behavioral;