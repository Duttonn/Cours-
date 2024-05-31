library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_gestion_instruction_tb is
end entity unite_gestion_instruction_tb;

architecture testbench of unite_gestion_instruction_tb is
  -- Déclaration des signaux pour le test bench
  signal tb_CLK : std_logic := '0';
  signal tb_Reset : std_logic := '0';
  signal tb_npcsel : std_logic := '0';
  signal tb_offset : std_logic_vector(23 downto 0) := (others => '0');
  signal tb_instruction : std_logic_vector(31 downto 0) := (others => '0');
  
  

  signal Done : boolean := False;

begin

  -- Instanciation de l'entité banc
  UGI : entity work.ugi(Behaviour)
    port map (
      CLK => tb_CLK,
      Reset => tb_Reset,
      npcsel=> tb_npcsel,
      offset=> tb_offset,
      instruction=> tb_instruction
    );
   
    tb_CLK <= '0' when Done else not tb_CLK after 10 ns;
    tb_Reset <= '1', '0' after 1 ns;

  process
  begin

   wait for 2 ns;
   assert tb_instruction=x"E3A01020" report "erreur test 1 ";
   tb_npcsel<='0';
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"E3A02000" report "erreur test 2 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"E6110000" report "erreur test 3 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"E0822000" report "erreur test 4 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"E2811001" report "erreur test 5 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"E351002A" report "erreur test 6 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"BAFFFFFB" report "erreur test 7 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"E6012000" report "erreur test 8 ";
   wait until rising_edge(tb_CLK);
   wait for 1ns;
   assert tb_instruction=x"EAFFFFF7" report "erreur test 9 ";


      tb_npcsel <= '1';
      tb_offset <= "111111111111111111111111"; -- =-1 ici
      wait until rising_edge(tb_CLK);
      wait for 1ns;
      assert tb_instruction=x"EAFFFFF7" report "erreur test 10 ";
      tb_offset <= "111111111111111111111100"; -- =-4 ici
      wait until rising_edge(tb_CLK);
      wait for 1ns;
      assert tb_instruction=x"E351002A" report "erreur test 11 ";





--     RW <=x"5";
--     RA <= x"7";
--     wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
--     wait for 1ns;
--     assert banc_tb(5)=x"FFFFFFD0" report "erreur sur test 5";

    Done <= True;
    -- Fin de la simulation
    wait;
    
  end process;

end architecture testbench;
