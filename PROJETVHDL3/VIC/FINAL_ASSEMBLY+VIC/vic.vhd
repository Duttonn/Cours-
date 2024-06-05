
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
signal irq1_past,irq0_past: std_logic:='0'; 
signal IRQ1_memo,IRQ0_memo: std_logic:='0'; 
begin
process(CLK, RESET)
      begin
      if reset ='1' then 
            irq1_past<='0';
            irq0_past<='0';
            IRQ0_memo <= '0';
            IRQ1_memo <= '0';
            -- IRQ <='0';
            VICPC<=x"00000000";
      elsif rising_edge(clk) then  
            
            irq1_past<=IRQ1;
            irq0_past<=IRQ0;

            if irq0_past='0' and IRQ0='1' then 
                  IRQ0_memo<='1';
                  VICPC <= X"00000009";
            elsif irq1_past='0' and IRQ1='1' and IRQ0_memo<='0' then 
                  IRQ1_memo<='1';
                  VICPC <= X"00000015";

            elsif IRQ_SERV ='1' then
                  --IRQ<='0';
                  IRQ0_memo<='0';
                  IRQ1_memo<='0';
                  VICPC<=x"00000000";
            end if;
            

      end if;

      IRQ<= IRQ0_memo or IRQ1_memo;

    end process;
end architecture;


