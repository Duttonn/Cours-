library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplexeur2vers1_tb is
end entity multiplexeur2vers1_tb;

architecture testbench of multiplexeur2vers1_tb is
  -- Déclaration des signaux pour le test bench
  signal A, B : std_logic_vector(7 downto 0);  -- Entrées de 8 bits (N=8)
  signal COM : std_logic;                       -- Commande de sélection sur 1 bit
  signal S : std_logic_vector(7 downto 0);       -- Sortie de 8 bits

begin
 
  UUT : entity work.multiplexeur2vers1(Behaviour)
    generic map (
      N => 8
    )
    port map (
      A => A,
      B => B,
      COM => COM,
      S => S
    );

  -- Processus de stimulation (stimulus process)
  stim_proc : process
  begin
    -- Test avec COM = '0' (sélection de A)
    A <= "01010101";
    B <= "10101010";
    COM <= '0';
    wait for 10 ns;

    -- Test avec COM = '1' (sélection de B)
    A <= "11110000";
    B <= "00001111";
    COM <= '1';
    wait for 10 ns;

    -- Test avec COM = '0' (sélection de A)
    A <= "11001100";
    B <= "00110011";
    COM <= '0';
    wait for 10 ns;

    -- Fin de la simulation
    wait;
  end process stim_proc;

end architecture testbench;
