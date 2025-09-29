-- Full Adder using Behavioral Architecture with if-else (VHDL-93)
-- Signal names: I0, I1, Cin, S, Cout
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( 
        I0  : in  STD_LOGIC;  -- First input bit
        I1  : in  STD_LOGIC;  -- Second input bit
        Cin : in  STD_LOGIC;  -- Carry input
        S   : out STD_LOGIC;  -- Sum output
        Cout: out STD_LOGIC   -- Carry output
    );
end full_adder;

architecture behavioral of full_adder is
begin
    -- Behavioral description using a process with if-else statements
    process(I0, I1, Cin)
    begin
        -- Check all possible input combinations
        if (I0 = '0' and I1 = '0' and Cin = '0') then
            S <= '0';
            Cout <= '0';
        elsif (I0 = '0' and I1 = '0' and Cin = '1') then
            S <= '1';
            Cout <= '0';
        elsif (I0 = '0' and I1 = '1' and Cin = '0') then
            S <= '1';
            Cout <= '0';
        elsif (I0 = '0' and I1 = '1' and Cin = '1') then
            S <= '0';
            Cout <= '1';
        elsif (I0 = '1' and I1 = '0' and Cin = '0') then
            S <= '1';
            Cout <= '0';
        elsif (I0 = '1' and I1 = '0' and Cin = '1') then
            S <= '0';
            Cout <= '1';
        elsif (I0 = '1' and I1 = '1' and Cin = '0') then
            S <= '0';
            Cout <= '1';
        else  -- I0 = '1' and I1 = '1' and Cin = '1'
            S <= '1';
            Cout <= '1';
        end if;
    end process;
    
end behavioral;
