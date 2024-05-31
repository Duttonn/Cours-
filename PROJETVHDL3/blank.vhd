-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (Address: in Std_logic_vector(3 downto 0);
        Data: inout Std_logic_vector(7 downto 0);
        nCS, nWE, nOE: in Std_logic);
end entity;

architecture Behaviour of alu is
  signal AddrLow: std_logic_vector(3 downto 0); 
begin
  process(Address,Data,nCS,nWE,nOE)
  begin
    end process;
end architecture;


