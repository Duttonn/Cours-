library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Extention is
  generic (
    N : integer := 32 
  );
  port (
    E : in std_logic_vector(N-1 downto 0);  -- Entrée à étendre
    S : out std_logic_vector(31 downto 0)   -- Sortie étendue sur 32 bits
  );
end entity Extention;

architecture Behaviour of Extention is
  signal s_add : std_logic_vector(31 downto N);
begin
  process(E)
  begin
   
    if E(N-1) = '0' then
      -- Cas où le nombre est positif, remplir avec des zéros à gauche
      -- S <= (31 downto N => '0') & E;  -- Remplir avec des uns à gauche
       s_add <= (others => '0');
    else
      -- Cas où le nombre est négatif, remplir avec des uns à gauche
      --S <= (31 downto N => '1') & E;  -- Remplir avec des uns à gauche
      s_add <= (others => '1');
    end if;
  end process;
  S<= s_add & E;
end architecture Behaviour;
