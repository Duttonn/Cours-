library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_tb is
end entity mem_tb;

architecture testbench of mem_tb is
  -- Déclaration des signaux pour le test bench
  signal CLK, Reset, WE : std_logic;
  signal DATAin, DATAout : std_logic_vector(31 downto 0);
  signal Addr : std_logic_vector(5 downto 0);
  signal Done : boolean := False;
  
begin
  -- Instanciation du composant mem (entity work)
  mem : entity work.mem(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => WE,
      DATAin => DATAin,
      Addr => Addr,
      DATAout => DATAout
    );

  -- Processus de génération du signal d'horloge (Clock process)
  -- CLK <= '0' when Done else not CLK after 10 ns;
  Reset <= '1', '0' after 1 ns;
 

  -- Processus de stimulation (stimulus process)
  process

  -- type table is array(63 downto 0) of std_logic_vector(31 downto 0);
  -- alias banc_tb : table is << signal .mem.Banc : table >>;

  begin
    WE <= '0';
    clk <='0';
    -- Écrire des données dans la mémoire
    wait for 20 ns;
    DATAin <= x"00000001";  -- Exemple de données à écrire
    Addr <= "000001";       -- Adresse d'écriture
    wait for 10 ns;
    WE <= '1';
    wait for 10 ns;
    CLK<='1';
    -- wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1 ns;
    -- assert banc_tb(1)=x"00000001" report "erreur sur test 1";
    WE <= '0';
    clk <='0';


    wait for 20 ns;
    DATAin <= x"00000002";  -- Exemple de données à écrire
    Addr <= "000010";       -- Adresse d'écriture
    wait for 10 ns;
    WE <= '1';
    wait for 10 ns;
    CLK<='1';
    -- wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1ns;
    -- assert banc_tb(2)=x"00000002" report "erreur sur test 2";
    WE <= '0';
    clk <='0';
 wait for 20 ns;

    Done <= True;
  wait; 
  end process;

end architecture testbench;
