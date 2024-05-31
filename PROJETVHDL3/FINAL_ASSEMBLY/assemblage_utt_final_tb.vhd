-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity assemblage_utt_final_tb is
end entity assemblage_utt_final_tb;

architecture testbench of assemblage_utt_final_tb is
  -- Déclaration des signaux pour le test bench
  signal tb_CLK : std_logic := '0';
  signal tb_Reset : std_logic := '0';
  signal tb_afficheur : std_logic_vector(31 downto 0);

  signal Done : boolean := False;

begin

  -- Instanciation de l'entité banc
  UTT : entity work.assemblage_utt_final(Behaviour)
    port map (
      CLK => tb_CLK,
      Reset => tb_Reset,
      afficheur => tb_afficheur
    );
   
    tb_CLK <= '0' when Done else not tb_CLK after 10 ns;
    tb_Reset <= '1', '0' after 1 ns;

  process
  begin



    wait until tb_afficheur/=x"00000000";
    wait for 1ns;
    Done <= True;
  
    wait;
    
  end process;

end architecture testbench;
