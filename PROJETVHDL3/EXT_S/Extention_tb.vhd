library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Extention_tb is
end entity Extention_tb;

architecture testbench of Extention_tb is
  
  signal E : std_logic_vector(7 downto 0);  
  signal S : std_logic_vector(31 downto 0);

begin
  -- Instanciation du composant SignExtension
  SEXT : entity work.Extention(Behaviour)
    generic map (
      N => 8
    )
    port map (
      E => E,
      S => S
    );

  -- Processus de stimulation (stimulus process)
  stim_proc : process
  begin
    -- Test avec une valeur positive (0x3A)
    E <= "00111010";
    wait for 10 ns;

    -- Test avec une valeur négative (0xBC)
    E <= "10111100";
    wait for 10 ns;

    -- Test avec une valeur maximale positive (0xFF)
    E <= "11111111";
    wait for 10 ns;

    -- Test avec une valeur minimale négative (0x80)
    E <= "10000000";
    wait for 10 ns;

    -- Fin de la simulation
    wait;
  end process stim_proc;

end architecture testbench;
