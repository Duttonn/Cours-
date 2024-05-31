library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity banc is
  port (
    CLK, Reset, WE : in std_logic;
    W : in std_logic_vector(31 downto 0);
    RA, RB, RW : in std_logic_vector(3 downto 0);
    A, B : out std_logic_vector(31 downto 0)
  );
end entity banc;

architecture Behaviour of banc is

  type table is array(15 downto 0) of std_logic_vector(31 downto 0);
  -- Fonction d'Initialisation du Banc de Registres
  function init_banc return table is 
  variable result : table;
  begin
  for i in 14 downto 0 loop
  result(i) := (others=>'0'); 
  end loop;
  result(15):=X"00000030";
  return result;
  end init_banc;
  -- Déclaration et Initialisation du Banc de Registres 16x32 bits
  signal Banc: table:=init_banc;



begin
  process (CLK, Reset)
  begin
    if Reset = '1' then
      for i in 14 downto 0 loop
        Banc(i) <= (others=>'0'); 
        end loop;
        banc(15)<=X"00000030";
    elsif rising_edge(CLK) then
      if WE = '1' then
        
        Banc(To_integer(Unsigned(RW)))<=W;


      end if;
    end if;
  end process;

    A<=Banc(To_integer(Unsigned(RA)));
    B<=Banc(To_integer(Unsigned(RB)));
    
end architecture Behaviour;
