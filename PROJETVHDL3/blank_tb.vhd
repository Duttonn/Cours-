-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity blank_tb is
end entity blank_tb;

architecture testbench of blank_tb is
  -- Déclaration des signaux pour le test bench
  signal tb_CLK : std_logic := '0';
  signal tb_Reset : std_logic := '0';
  signal tb_sortie : std_logic_vector(31 downto 0);

  signal Done : boolean := False;

begin

  -- Instanciation de l'entité banc
  Blank : entity work.blank(Behaviour)
    port map (
      CLK => tb_CLK,
      Reset => tb_Reset,
      sortie => tb_sortie
    );
   
    tb_CLK <= '0' when Done else not tb_CLK after 10 ns;
    tb_Reset <= '1', '0' after 1 ns;

  process
  begin



    wait until tb_sortie/=x"00000000";
    wait for 1ns;
    Done <= True;
  
    wait;
    
  end process;

end architecture testbench;
