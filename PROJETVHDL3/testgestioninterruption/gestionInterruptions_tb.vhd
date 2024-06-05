-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity gestionInterruptions_tb is
end entity gestionInterruptions_tb;

architecture testbench of gestionInterruptions_tb is
  -- Déclaration des signaux pour le test bench
  signal tb_CLK : std_logic := '0';
  signal tb_Reset : std_logic;
  signal tb_VICPC : std_logic_vector(31 downto 0);
  signal tb_IRQ_SERV, tb_IRQ0, tb_IRQ1,tb_IRQ : std_logic:='0';

  signal tb_cpsr_out  : std_logic_vector(31 downto 0);
  signal tb_instruction,tb_PCout,tb_PCin,tb_LRin, tb_LRout,tb_ext_out  : std_logic_vector(31 downto 0);
  signal tb_nPCSel  : std_logic;
  signal tb_RegWr  : std_logic;
  signal tb_ALUSrc  : std_logic;
  signal tb_ALUCtr  : std_logic_vector(2 downto 0);
  signal tb_PSREn  : std_logic;
  signal tb_MemWr  : std_logic;
  signal tb_WrSrc  : std_logic;
  signal tb_RegSel  : std_logic;
  signal tb_RegAff  : std_logic;   
  signal tb_imm24,tb_offset  : std_logic_vector(23 downto 0);
  signal tb_imm8  : std_logic_vector(7 downto 0);
  signal tb_IRQ_END : std_logic;
  signal tb_Rd : std_logic_vector(3 downto 0);
  signal tb_Rn : std_logic_vector(3 downto 0);
  signal tb_Rm : std_logic_vector(3 downto 0);




  signal Done : boolean := False;

begin

  -- Instanciation de l'entité banc
  VIC : entity work.vic(Behaviour)
    port map (
      CLK=>tb_CLK,
      RESET=>tb_Reset,
      IRQ_SERV=>tb_IRQ_SERV,
      IRQ0=>tb_IRQ0,
      IRQ1=>tb_IRQ1,
      IRQ =>tb_IRQ,
      VICPC=> tb_VICPC
    );
    -- UGI : entity work.ugi(Behaviour)
    -- port map (
    --   CLK => tb_CLK,
    --   Reset => tb_Reset,
    --   npcsel=> tb_npcsel,
    --   offset=> tb_offset,
    --   instruction=> tb_instruction,
    --   IRQ=>tb_IRQ,
    --   IRQ_END=>tb_IRQ_END,
    --   IRQ_SERV=>tb_IRQ_SERV,
    --   VICPC=>tb_VICPC
    -- );
    EXT : entity work.Extention(Behaviour)
      generic map (
        N => tb_offset'LENGTH
      )
      port map(
        E=>tb_offset,
        S=>tb_ext_out
      );


    calc : entity work.PC_Calculator(Behaviour)
      port map(PCin =>tb_PCout,
              RESET=>tb_Reset,
              VICPC=>tb_VICPC, 
              offset=>tb_ext_out, 
              LRin=> tb_LRout,
              npcsel=> tb_npcsel , 
              IRQ=> tb_IRQ ,  
              IRQ_END=> tb_IRQ_END ,
              PCout=> tb_PCin ,  
              LRout=>  tb_LRin ,
              IRQ_SERV=>  tb_IRQ_SERV
            );


    LRPC : entity work.LR_PC_Reg(Behaviour)
      port map (CLocK=>tb_CLK,
            RESET=>tb_Reset,
            LRin=> tb_LRin,
            PCin => tb_PCin,
            LRout=>tb_LRout,
            PCout => tb_PCout
            );



    instmem :entity work.instruction_memory_IRQ(RTL)
    port map(
      PC => tb_PCout,
      instruction => tb_instruction
      );


    DCODE : entity work.decodeurinstruction(Behaviour)

    port map (
    instruction => tb_instruction ,
    cpsr => tb_cpsr_out  ,
    nPCSel =>tb_nPCSel ,
    RegWr =>tb_RegWr  ,
    ALUSrc =>tb_ALUSrc ,
    ALUCtr => tb_ALUCtr ,
    PSREn => tb_PSREn ,
    MemWr => tb_MemWr ,
    WrSrc => tb_WrSrc ,
    RegSel => tb_RegSel ,
    RegAff => tb_RegAff , 
    Rd=> tb_Rd ,
    Rn=> tb_Rn ,
    Rm=> tb_Rm ,
    imm24 => tb_imm24 ,
    imm8 => tb_imm8,
    IRQ_END=>tb_IRQ_END
  );


    tb_CLK <= '0' when Done else not tb_CLK after 5 ns;
    tb_Reset <= '1', '0' after 1 ns;

  process
  begin
  
      --test 1 IRQ0 seul
      wait for 15 ns;
      tb_IRQ0<='1';
      wait for 15 ns;
      tb_IRQ0<='0';
      wait for 15 ns;

      wait for 1 ns;
      assert tb_IRQ='1' report "erreur test 1 IRQ "; 
      assert tb_VICPC=x"00000009" report "erreur test 1 VICPC "; 
      
      wait for 100ns;
      
      --add pc lr et npcsel

    --   --test 2 IRQ1 seul
    --   wait for 15ns;
    --   wait for 15ns;
    --   tb_IRQ1<='1';
    --   wait for 15 ns;
    --   tb_IRQ1<='0';
    --   wait for 15 ns;

    --   wait for 2 ns;
    --   assert tb_IRQ='1' report "erreur test 2 IRQ "; 
    --   assert tb_VICPC=x"00000015" report "erreur test 2 VICPC "; 

    --  wait for 15ns;


    --   --test 3 IRQ1 +0 pour voir priorité 
    --   wait for 15ns;
    --   wait for 15ns;
    --   tb_IRQ1<='1';
    --   tb_IRQ0<='1';
    --   wait for 15 ns;
    --   tb_IRQ0<='0';
    --   tb_IRQ1<='0';
    --   wait for 15 ns;

    --   wait for 2 ns;
    --   assert tb_IRQ='1' report "erreur test 3 IRQ "; 
    --   assert tb_VICPC=x"00000009" report "erreur test 3 VICPC ";
    --  wait for 15ns;

    --   --test 4 IRQ_SERV auto
    --   wait for 15ns;
    --   tb_IRQ1<='1';
    --   wait for 15 ns;
    --   tb_IRQ1<='0';
    --   wait for 15 ns;

    --   wait for 2 ns;
    --   wait for 15ns;
    --   wait for 15ns;
      
    --   assert tb_IRQ='0' report "erreur test 4 IRQ "; 
    --   assert tb_VICPC=x"00000000" report "erreur test 4 VICPC ";
    
    --   wait for 1ns;
      Done <= True;
    wait;
    
  end process;

end architecture testbench;
