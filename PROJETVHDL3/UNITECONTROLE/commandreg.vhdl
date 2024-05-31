library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity commandreg is
  port (
    WE,CLK,Reset : in std_logic; 
    DATAIN: in  std_logic_vector(31 downto 0);
    DATAOUT : out std_logic_vector(31 downto 0)   -- Sortie étendue sur 32 bits
  );
end entity commandreg;

architecture Behaviour of commandreg is
  signal PC : unsigned(31 downto 0);
  signal ext_out : std_logic_vector(31 downto 0);

begin
  process(CLK,Reset)
  begin

    if reset ='1' then 
      DATAOUT<= (others => '0');
    elsif rising_edge(clk) then 
      if WE ='1' then
        DATAOUT<=DATAIN;
      end if;
    end if; 
    

    
  end process;
  
end architecture Behaviour;
