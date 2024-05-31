library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplexeur2vers1 is
  generic (
    N : integer := 32  
  );
  port (
    A, B : in std_logic_vector(N-1 downto 0); 
    COM : in std_logic;                         
    S : out std_logic_vector(N-1 downto 0)      
  );
end entity multiplexeur2vers1;

architecture Behaviour of multiplexeur2vers1 is
begin
  process(A, B, COM)
  begin
    if COM = '0' then
      S <= A;  -- Sélectionne l'entrée A si COM est bas
    else
      S <= B;  -- Sélectionne l'entrée B si COM est haut
    end if;
  end process;
end architecture Behaviour;
