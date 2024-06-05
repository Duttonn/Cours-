-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_Calculator is
  port (PCin,VICPC,offset,LRin: in Std_logic_vector(31 downto 0);
        npcsel,IRQ,IRQ_END,reset : in std_logic;
        PCout,LRout: out Std_logic_vector(31 downto 0);
        IRQ_SERV: out std_logic
        );
end entity;

architecture Behaviour of PC_Calculator is
  signal PC: unsigned(31 downto 0); 
begin
  process(PCin,VICPC,offset,npcsel,IRQ,IRQ_END,PC)
  begin
      if reset ='1' then 
      PCout<=(others=>'0');
      LRout<=(others=>'0');
      IRQ_SERV<='0';
      end if;
      if IRQ_END ='1' then --fin d'interruption 
            PC<=unsigned(LRin);
      elsif IRQ_END ='0' then
            PC<=unsigned(PCin);
      elsif IRQ ='1' then 
            IRQ_SERV <='1';
            LRout<=PCin;
            PCout<=VICPC;
      else 
            if npcsel ='0' then
                  PC<=PC+1;
            else
                  PC <= PC + 1 + unsigned(offset);
            end if;
      end if;
    end process;
    PCout<=Std_logic_vector(PC);
end architecture;


