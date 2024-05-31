
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity vic is
  port(CLK, RESET,IRQ_SERV, IRQ0, IRQ1: in Std_logic;
       IRQ : out Std_logic;
       VICPC: out Std_logic_vector(31 downto 0)
      );
end entity;

architecture Behaviour of vic is
  signal irq1_past,irq0_past: std_logic; 
  signal IRQ1_memo,IRQ0_memo: std_logic; 
  begin
  process(CLK, RESET)

  if reset ='1' then 
      irq1_past<='0';
      irq0_past<='0';
      IRQ <='0';
      VICPC<=0x"00";
  elsif rising_edge(clk) then  
      irq1_past<=IRQ1;
      irq0_past<=IRQ0;
      if irq0_past='0' and IRQ0='1' then 
            IRQ0_memo<='1';
            VICPC<=0x"00000009";
      elsif irq1_past='0' and IRQ1='1' then 
            IRQ1_memo<='1';
            VICPC<=0x"00000015";
      else 
            VICPC<=0x"00000000";
      end if;
      if IRQ1_memo='1' or IRQ0_memo='1' then 
            IRQ<='1';
      elsif IRQ_SERV ='1' then
            IRQ<='0';
      end if;
  end if;
 

  begin
    end process;
end architecture;


