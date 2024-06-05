library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ugi is
  port (
    npcsel,CLK,Reset,IRQ,IRQ_END : in std_logic; 
    VICPC : in  std_logic_vector(31 downto 0);
    -- offset :   std_logic_vector(23 downto 0);
    ext_out : in std_logic_vector(31 downto 0);
    IRQ_SERV : out std_logic;
    instruction : out std_logic_vector(31 downto 0)   -- Sortie étendue sur 32 bits
  );
end entity ugi;

architecture Behaviour of ugi is
  signal PC,LR : unsigned(31 downto 0);

begin
  process(CLK,Reset)
  begin

    if reset ='1' then 
      PC<= (others => '0');
      LR<= (others => '0');
      IRQ_SERV<='0';
    elsif rising_edge(clk) then 

        if IRQ ='1' and (PC<x"00000009") then --interruption
          if npcsel ='0' then
            LR<=PC+1;
          else
            LR <= PC + 1 + unsigned(ext_out);
          end if;
          PC<=unsigned(VICPC);
          IRQ_SERV<='1';
        elsif IRQ_END ='1' then --fin d'interruption 
          PC<=LR;
          IRQ_SERV<='0';
        else 
          if npcsel ='0' then
            PC<=PC+1;
          else
            PC <= PC + 1 + unsigned(ext_out);
          end if;
      end if;
    -- else --partie asyhrone 
    end if; 

  end process;
-- PCout<=std_logic_vector(PC);


  -- SEXT : entity work.Extention(Behaviour)
  -- generic map (
  -- N => offset'LENGTH
  -- )
  -- port map (
  --   E => offset,
  --   S => ext_out
  -- );

  IM : entity work.instruction_memory_IRQ(RTL)
  port map(
  PC => std_logic_vector(PC),
  Instruction => instruction
   );

  
end architecture Behaviour;
