library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_traitement_tb is
end entity unite_traitement_tb;

architecture testbench of unite_traitement_tb is
  -- Déclaration des signaux pour le test bench
  signal CLK : std_logic := '0';
  signal Reset : std_logic := '0';
  signal WE : std_logic := '0';
  signal N : std_logic := '0';
  signal Z : std_logic := '0';
  signal C : std_logic := '0';
  signal V : std_logic := '0';
  signal W : std_logic_vector(31 downto 0) := (others => '0');
  signal OP : std_logic_vector(2 downto 0);
  signal RA, RB, RW : std_logic_vector(3 downto 0) := (others => '0');

  signal Done : boolean := False;



  
  


begin

  -- Instanciation de l'entité banc
  UUT : entity work.unite_traitement(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => WE,
      RA => RA,
      RB => RB,
      RW => RW,
      OP=>OP,
      N => N,
      Z => Z,
      C => C,
      V => V
    );
   
    clk <= '0' when Done else not clk after 10 ns;
    reset <= '1', '0' after 1 ns;

  process

  type table is array(15 downto 0) of std_logic_vector(31 downto 0);
  -- Fonction d'Initialisation du Banc de Registres
  alias banc_tb : table is << signal .UUT.U1.banc : table >>;
  begin

    -- Écriture dans le banc de registres
    WE <= '1';
    RW <= x"1";  
    RA <= x"F";  
    OP <= "011";

    wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1ns;
    assert banc_tb(1)=x"00000030" report "erreur sur test 1";

    
    RA <= x"1";  
    RB <= x"F";
    OP <= "000";
    wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1ns;
    assert banc_tb(1)=x"00000060" report "erreur sur test 2";


    RW <= x"2";  
    wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1ns;
    assert banc_tb(2)=x"00000090" report "erreur sur test 3";


    RW <=x"3";
    OP <= "010";
    wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1ns;
    assert banc_tb(3)=x"00000030" report "erreur sur test 4";


    RW <=x"5";
    RA <= x"7";
    wait until rising_edge(CLK);  -- Attendre un cycle d'horloge
    wait for 1ns;
    assert banc_tb(5)=x"FFFFFFD0" report "erreur sur test 5";

    Done <= True;
    -- Fin de la simulation
    wait;
    
  end process;

end architecture testbench;
