-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (OP: in Std_logic_vector(2 downto 0);
        A,B: in Std_logic_vector(31 downto 0);
        S: out Std_logic_vector(31 downto 0);
        N, Z, C, V: out Std_logic);
end entity;

architecture Behaviour of alu is
    signal A_resized : signed(32 downto 0);
    signal B_resized : signed(32 downto 0);
    signal S_resized : signed(32 downto 0);
begin
    A_resized <= signed('0' &A);
    B_resized <= signed('0'&B);
    --S_resized <= resize(signed(S),33);
    
    process(OP,A_resized,B_resized, S_resized) 
    begin
        case OP is 
            when "000" =>
            S_resized <= A_resized + B_resized;
            when "001" =>
            S_resized <= B_resized;
            when "010" =>
            S_resized <= A_resized - B_resized;
            when "011" =>
                S_resized <= A_resized;
            when "100" =>
                S_resized <= A_resized OR B_resized;
            when "101" =>
                S_resized <= A_resized AND B_resized;
            when "110" =>
                S_resized <= A_resized XOR B_resized;
            when "111" =>
                S_resized <= NOT A_resized; 
            when others =>
                S_resized <= (others => 'U');
        end case;

        if OP="000" or OP = "010" then 
        C <= S_resized(32);
        else 
        C<='0';
        end if; 

        if S_resized(31 downto 0) = x"00000000" then 
        Z <= '1';
        else 
        Z <= '0';
        end if; 

        if ((OP="000" or OP = "010")and ((A(31) xor B(31)) = '0') and ((S_resized(31) xor A(31)) = '1')) then 
        V <= '1';
        else 
        V <= '0';
        end if; 

        end process;

        S<=Std_logic_vector(S_resized(31 downto 0));
        N <= S_resized(31);
end architecture;


