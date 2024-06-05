-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity vic_tb is
end entity vic_tb;

architecture testbench of vic_tb is
  -- Déclaration des signaux pour le test bench
  signal tb_CLK : std_logic := '0';
  signal tb_Reset : std_logic;
  signal tb_VICPC : std_logic_vector(31 downto 0);
  signal tb_IRQ_SERV, tb_IRQ0, tb_IRQ1,tb_IRQ : std_logic;

  signal Done : boolean := False;

begin

  -- Instanciation de l'entité banc
  VIC : entity work.vic(Behaviour)
    port map (
      CLK=>tb_CLK,
      RESET=>tb_Reset,
      IRQ_SERV=>tb_IRQ_SERV,
      IRQ0=>tb_IRQ0,
      IRQ1=>tb_IRQ1,
      IRQ =>tb_IRQ,
      VICPC=> tb_VICPC
    );
    
    tb_CLK <= '0' when Done else not tb_CLK after 5 ns;
    tb_Reset <= '1', '0' after 1 ns;

  process
  begin
    tb_IRQ_SERV <='0';
    tb_IRQ0 <='0';
    tb_IRQ1 <='0';
      --test 1 IRQ0 seul
      tb_IRQ0<='1';
      wait for 15 ns;
      tb_IRQ0<='0';
      wait for 15 ns;

      wait for 1 ns;
      assert tb_IRQ='1' report "erreur test 1 IRQ "; 
      assert tb_VICPC=x"00000009" report "erreur test 1 VICPC "; 
      
      wait for 15 ns;
      tb_IRQ_SERV<='1';
      wait for 15 ns;
      tb_IRQ_SERV<='0';
      wait for 15 ns;
      -- tb_Reset<='1';

      --test 2 IRQ1 seul
      tb_IRQ1<='1';
      wait for 15 ns;
      tb_IRQ1<='0';
      wait for 15 ns;

      wait for 2 ns;
      assert tb_IRQ='1' report "erreur test 2 IRQ "; 
      assert tb_VICPC=x"00000015" report "erreur test 2 VICPC "; 

      tb_IRQ_SERV<='1';
      wait for 15 ns;
      tb_IRQ_SERV<='0';
      wait for 15 ns;
      -- tb_Reset<='1';


      --test 3 IRQ1 +0 pour voir priorité 
      tb_IRQ1<='1';
      wait for 15 ns;
      tb_IRQ1<='0';
      wait for 15 ns;

      tb_IRQ0<='1';
      wait for 15 ns;
      tb_IRQ0<='0';
      wait for 15 ns;

      tb_IRQ1<='1';
      wait for 15 ns;
      tb_IRQ1<='0';
      wait for 15 ns;

      wait for 2 ns;
      assert tb_IRQ='1' report "erreur test 3 IRQ "; 
      assert tb_VICPC=x"00000009" report "erreur test 3 VICPC ";

      tb_IRQ_SERV<='1';
      wait for 15 ns;
      tb_IRQ_SERV<='0';
      wait for 15 ns;
      -- tb_Reset<='1';


      --test 4 IRQ_SERV
      tb_IRQ1<='1';
      wait for 15 ns;
      tb_IRQ1<='0';
      wait for 15 ns;

      tb_IRQ_SERV<='1';
      wait for 15 ns;

      wait for 2 ns;
      assert tb_IRQ='0' report "erreur test 4 IRQ "; 
      assert tb_VICPC=x"00000000" report "erreur test 4 VICPC ";
    
      wait for 1ns;
      Done <= True;
    wait;
    
  end process;

end architecture testbench;
