-- Squelette pour l'exercice RamChip

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RamChip is
  port (Address: in Std_logic_vector(3 downto 0);
        Data: inout Std_logic_vector(7 downto 0);
        nCS, nWE, nOE: in Std_logic);
end entity;

architecture Behaviour of RamChip is
  type ramtype is array(0 to 25) of Std_logic_vector(7 downto 0);
  signal RAM : ramtype;  
begin
  process(Address,Data,nCS,nWE,nOE)
  begin
    if (nWE='0' and nCS='0') then 
      RAM(To_integer(Unsigned(Address)))<=Data;
      -- Data <= (others => 'Z');
    elsif (nOE='0' and nCS='0') then 
      Data<=RAM(To_integer(Unsigned(Address)));
    -- RAM(To_integer(Unsigned(Address))) <= (others => '0');
    else 
      Data<=(others=>'Z');
    end if;
    end process;
end architecture;


