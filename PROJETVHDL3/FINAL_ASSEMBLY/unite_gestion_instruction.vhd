library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ugi is
  port (
    npcsel,CLK,Reset : in std_logic; 
    offset : in  std_logic_vector(23 downto 0);
    instruction : out std_logic_vector(31 downto 0)   -- Sortie étendue sur 32 bits
  );
end entity ugi;

architecture Behaviour of ugi is
  signal PC : unsigned(31 downto 0);
  signal ext_out : std_logic_vector(31 downto 0);

begin
  process(CLK,Reset)
  begin

    if reset ='1' then 
      PC<= (others => '0');
    elsif rising_edge(clk) then 
      if npcsel ='0' then
        PC<=PC+1;
      else
        PC <= PC + 1 + unsigned(ext_out);
      end if;
    end if; 
    

    
  end process;

  SEXT : entity work.Extention(Behaviour)
  generic map (
  N => offset'LENGTH
  )
  port map (
    E => offset,
    S => ext_out
  );

  IM : entity work.instruction_memory(RTL)
  port map(
  PC => std_logic_vector(PC),
  Instruction => instruction
   );

  
end architecture Behaviour;
