-- Full Adder using Behavioral Architecture with if-else (VHDL-93)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( 
        A   : in  STD_LOGIC;  -- First input bit
        B   : in  STD_LOGIC;  -- Second input bit
        Cin : in  STD_LOGIC;  -- Carry input
        Sum : out STD_LOGIC;  -- Sum output
        Cout: out STD_LOGIC   -- Carry output
    );
end full_adder;

architecture behavioral of full_adder is
begin
    -- Behavioral description using a process with if-else statements
    process(A, B, Cin)
    begin
        -- Check all possible input combinations
        if (A = '0' and B = '0' and Cin = '0') then
            Sum <= '0';
            Cout <= '0';
        elsif (A = '0' and B = '0' and Cin = '1') then
            Sum <= '1';
            Cout <= '0';
        elsif (A = '0' and B = '1' and Cin = '0') then
            Sum <= '1';
            Cout <= '0';
        elsif (A = '0' and B = '1' and Cin = '1') then
            Sum <= '0';
            Cout <= '1';
        elsif (A = '1' and B = '0' and Cin = '0') then
            Sum <= '1';
            Cout <= '0';
        elsif (A = '1' and B = '0' and Cin = '1') then
            Sum <= '0';
            Cout <= '1';
        elsif (A = '1' and B = '1' and Cin = '0') then
            Sum <= '0';
            Cout <= '1';
        else  -- A = '1' and B = '1' and Cin = '1'
            Sum <= '1';
            Cout <= '1';
        end if;
    end process;
    
end behavioral;
