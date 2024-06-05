library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrecommande is
  port (
    WE,CLK,Reset : in std_logic; 
    DATAIN: in  std_logic_vector(31 downto 0);
    DATAOUT : out std_logic_vector(31 downto 0)   -- Sortie étendue sur 32 bits
  );
end entity registrecommande;

architecture Behaviour of registrecommande is
  signal datasig : std_logic_vector(31 downto 0);

begin
  process(CLK,Reset)
  begin

    if reset ='1' then 
      datasig<= (others => '0');
    elsif rising_edge(clk) then 
      if WE ='1' then
        datasig<=DATAIN;
      end if;
    end if; 
  end process;
  dataout<=datasig;
end architecture Behaviour;
