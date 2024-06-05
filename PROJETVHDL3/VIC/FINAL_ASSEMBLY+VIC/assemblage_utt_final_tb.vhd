-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity assemblage_utt_final_tb is
end entity assemblage_utt_final_tb;

architecture testbench of assemblage_utt_final_tb is
  -- Déclaration des signaux pour le test bench
  signal tb_CLK : std_logic := '0';
  signal tb_Reset,tb_IRQ0,tb_IRQ1 : std_logic := '0';
  signal tb_afficheur : std_logic_vector(31 downto 0);
  


  signal Done : boolean := False;

begin

  -- Instanciation de l'entité banc
  UTT : entity work.assemblage_utt_final(Behaviour)
    port map (
      CLK => tb_CLK,
      Reset => tb_Reset,
      afficheur => tb_afficheur,
      IRQ0=>tb_IRQ0,
      IRQ1=>tb_IRQ1
    );
   
    tb_CLK <= '0' when Done else not tb_CLK after 10 ns;
    tb_Reset <= '1', '0' after 1 ns;

  process
  type table is array(63 downto 0) of std_logic_vector(31 downto 0);
  alias mem_tb : table is << signal .UTT.mem.banc : table >>;

  begin


    --changer IRQ0 et IRQ1 pour activer les interruptions avant que afficheur soit bon et verifier la memoire 
    wait for 200ns; --on attends 10 coups de clock

    tb_IRQ0<='1';
    wait for 39ns;
    tb_IRQ0<='0';
    wait for 600ns;
    assert mem_tb(16)=x"00000002" report "erreur sur test IRQ0";
    wait for 10ns;

    -- wait for 80ns;

    -- tb_IRQ1<='1';
    -- wait for 39ns;
    -- tb_IRQ1<='0';
    -- wait for 600ns;
    -- assert mem_tb(16)=x"00000004" report "erreur sur test IRQ1";
    -- wait for 10ns; 


    -- tb_IRQ0<='1';
    -- tb_IRQ1<='1';
    -- wait for 39ns;
    -- tb_IRQ1<='0';
    -- tb_IRQ0<='0';
    -- wait for 39ns;
    -- assert mem_tb(16)=x"00000005" report "erreur sur test IRQ1 + IRQ0";

    -- -- wait until tb_afficheur/=x"00000000";
    wait for 4 us; --50 clocks à 20ns
    -- wait until tb_afficheur>x"00000091";
    assert tb_afficheur=x"00000091" report "erreur sur afficheur";
    wait for 1ns;
    Done <= True;
  
    wait;
    
  end process;

end architecture testbench;
