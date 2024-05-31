library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture testbench of alu_tb is
    -- Déclaration des signaux pour les ports de l'ALU
    signal OP : std_logic_vector(2 downto 0);
    signal A, B, S : std_logic_vector(31 downto 0);
    signal N, Z, C, V : std_logic;
    
    -- Déclaration des constantes pour les opérations
    constant ADD_OP : std_logic_vector(2 downto 0) := "000";
    constant SUB_OP : std_logic_vector(2 downto 0) := "010";
    constant OR_OP : std_logic_vector(2 downto 0) := "100";
    constant AND_OP : std_logic_vector(2 downto 0) := "101";
    constant XOR_OP : std_logic_vector(2 downto 0) := "110";
    constant NOT_OP : std_logic_vector(2 downto 0) := "111";
    
begin
    -- Instanciation de l'unité arithmétique et logique (UAL) alu
    ALU: entity work.alu
        port map (
            OP => OP,
            A => A,
            B => B,
            S => S,
            N => N,
            Z => Z,
            C => C,
            V => V
        );
    
    -- Processus de test pour stimuler l'UAL avec différentes opérations
    stimulus: process
    begin
        -- Test d'addition overflow
        OP <= ADD_OP;
        A <= "01111111111111111111111111111111"; 
        B <= "00000000000000000000000000000001";  
        wait for 10 ns;

        -- Test d'addition zéro
        OP <= ADD_OP;
        A <= "11111111111111111111111111111111"; 
        B <= "00000000000000000000000000000001";  
        wait for 10 ns;

        -- Test d'addition carry
        OP <= ADD_OP;
        A <= "11000000000000000000000000000001"; 
        B <= "01000000000000000000000000000001";  
        wait for 10 ns;

        -- Test d'addition 
        OP <= ADD_OP;
        A <= "00000000000000000000000000000001"; 
        B <= "00000000000000000000000000000001";  
        wait for 10 ns;
        
        -- Test de soustraction
        OP <= SUB_OP;
        A <= "01111111111111111111111111111111";  
        B <= "10000000000000000000000000000000";  
        wait for 10 ns;
        
        -- Test de OR
        OP <= OR_OP;
        A <= "10101010101010101010101010101010";
        B <= "01010101010101010101010101010101";
        wait for 10 ns;
        
        -- Test de AND
        OP <= AND_OP;
        A <= "11110000111100001111000011110000";
        B <= "00001111000011110000111100001111";
        wait for 10 ns;
        
        -- Test de XOR
        OP <= XOR_OP;
        A <= "11111111000000001111111100000000";
        B <= "00000000111111110000000011111111";
        wait for 10 ns;
        
        -- Test de NOT
        OP <= NOT_OP;
        A <= "01010101010101010101010101010101";
        wait for 10 ns;
        
        
        wait;
    end process;
    
end architecture;
