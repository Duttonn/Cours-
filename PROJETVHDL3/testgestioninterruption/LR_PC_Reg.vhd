-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity LR_PC_Reg is
  port (Clock,reset: in Std_logic;
        LRin,PCin: in Std_logic_vector(31 downto 0);
        LRout,PCout: out Std_logic_vector(31 downto 0));
end entity;

architecture Behaviour of LR_PC_Reg is
begin
  process(Clock,reset)
  begin
    if reset ='1' then 
      LRout<=(others => '0');
      PCout<=(others => '0');
    elsif rising_edge(clock) then 
      LRout<=LRin;
      PCout<=PCin;
    end if;
    end process;
end architecture;


