-- Squelette pour l'exercice RamChip

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RamChip_tb is
  
end entity;

architecture Bench of RamChip_tb is
    signal Address : std_logic_vector(3 downto 0);
  signal Data : std_logic_vector(7 downto 0);
  signal nCS, nWE, nOE : std_logic; -- Défaut: tous les signaux inactifs
begin

    test : entity work.RamChip(Behaviour)
    port map (
      Address => Address,
      Data => Data,
      nCS => nCS,
      nWE => nWE,
      nOE => nOE
    );
  

    Test_Process : process
  begin

    nWE <= '1';
    nOE <= '1';
    nCs<='1';
    Address <= (others => '0');
    Data <= (others => 'Z');
    wait for 10 NS;

    -- Test Read/Write conflict
    nCs<='0';
    nWE <= '0';
    nOE <= '0';
    wait for 10 NS;
    nWE <= '1';
    nOE <= '1';
    wait for 10 NS;
    nCs<='1';
    wait for 10 NS;

    -- Écrire des données dans la mémoire

    nCs<='0';
    wait for 10 NS;
    
    Address <= "0001";
    wait for 5 NS;
    Data <= "00000010";  
    wait for 5 NS;
    nWE <= '0';
    wait for 20 NS;
    nWE <= '1';
    Data <= "ZZZZZZZZ"; 
    nCs<='1';
    wait for 20 NS;

    nCs<='0';
    wait for 10 NS;

    Address <= "1001";
    wait for 5 NS;
    Data <= "11110000"; 
    wait for 5 NS;
    nWE <= '0';
    wait for 20 NS;
    nWE <= '1';
    Data <= "ZZZZZZZZ"; 
    nCs<='1';
    wait for 20 NS;
    

    
    -- nWE <= '1';  
    -- nOE <= '0';  
    -- wait for 10 ns;
    nCs<='0';
    wait for 10 NS;

    Address <= "0001";  -- Lire l'emplacement 0
    wait for 10 ns;
    nOE <= '0';
    wait for 10 NS;
    -- assert Data = "00000010" 
    --     report "Erreur de lecture des données";
    nOE <= '1';
    Data <= "ZZZZZZZZ"; 
    nCs<='1';
    wait for 20 NS;
    
    nCs<='0';
    wait for 10 NS;

    Address <= "1001"; 
    wait for 10 ns;
    nOE <= '0';
    -- assert Data = "11110000" 
    --     report "Erreur de lecture des données";
    wait for 10 NS;
    nOE <= '1';
    wait for 20 NS;

    Data <= "ZZZZZZZZ"; 
    nOE <= '1';  -- Arrêter la lecture
    nCS <= '1';  -- Désélectionner la puce
    wait;

  end process;

end architecture;


