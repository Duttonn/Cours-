library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
  port (
    CLK, Reset, WE : in std_logic;
    DATAin : in std_logic_vector(31 downto 0);
    Addr : in std_logic_vector(5 downto 0);
    DATAout : out std_logic_vector(31 downto 0)
  );
end entity mem;

architecture Behaviour of mem is

  type table is array(63 downto 0) of std_logic_vector(31 downto 0);
  -- Fonction d'Initialisation du Banc de Registres
  function init_banc return table is 
  variable result : table;
  begin
  for i in 63 downto 1 loop
      result(i) := (others=>'0'); 
  end loop;
  for i in 41 downto 32 loop
      result(i):= X"00000001"; 
  end loop;
  result(0):=X"00000030";
  return result;
  end init_banc;
  -- Déclaration et Initialisation du Banc de Registres 16x32 bits
  signal Banc: table:=init_banc;
begin
  process (CLK, Reset)
  begin
    if Reset = '1' then
      Banc<=init_banc;
    elsif rising_edge(CLK) then
      if WE = '1' then
        Banc(To_integer(Unsigned(ADdr)))<=DATAin;
        
      end if;
    end if;
  end process;
    DATAout<=Banc(To_integer(Unsigned(Addr)));
end architecture Behaviour;
