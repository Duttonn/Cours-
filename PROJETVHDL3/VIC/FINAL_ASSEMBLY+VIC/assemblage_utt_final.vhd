-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity assemblage_utt_final is
    port (
        CLK, Reset,IRQ0,IRQ1 : in std_logic;
        afficheur : out std_logic_vector(31 downto 0)
      );
end entity;

architecture Behaviour of assemblage_utt_final is

  signal bus_W,alu_out, ext_out1,ext_out2,mux1_out,mem_out : std_logic_vector(31 downto 0);
  signal bus_A, bus_B : std_logic_vector(31 downto 0);
  signal sig_RB : std_logic_vector(3 downto 0);
  signal sig_instruction  : std_logic_vector(31 downto 0);
  signal sig_cpsr_in  : std_logic_vector(31 downto 0):=x"00000000";
  signal sig_cpsr_out  : std_logic_vector(31 downto 0);
  signal sig_nPCSel  : std_logic;
  signal sig_RegWr  : std_logic;
  signal sig_ALUSrc  : std_logic;
  signal sig_ALUCtr  : std_logic_vector(2 downto 0);
  signal sig_PSREn  : std_logic;
  signal sig_MemWr  : std_logic;
  signal sig_WrSrc  : std_logic;
  signal sig_RegSel  : std_logic;
  signal sig_RegAff  : std_logic;   
  signal sig_Rd : std_logic_vector(3 downto 0);
  signal sig_Rn : std_logic_vector(3 downto 0);
  signal sig_Rm : std_logic_vector(3 downto 0);
  signal sig_imm24  : std_logic_vector(23 downto 0);
  signal sig_imm8  : std_logic_vector(7 downto 0);
  signal sig_VICPC : std_logic_vector(31 downto 0);
  signal sig_IRQ_SERV,sig_IRQ,sig_IRQ_END : std_logic;


begin

  
    ALU: entity work.alu(Behaviour)
    port map (
        OP => sig_ALUCtr,
        A => bus_A,
        B => mux1_out,
        S => alu_out,
        N => sig_cpsr_in(31),
        Z => sig_cpsr_in(30),
        C => sig_cpsr_in(29),
        V => sig_cpsr_in(28)
    );
    


    BANCREG : entity work.banc(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => sig_RegWr,
      W => bus_W,
      RA => sig_Rn,
      RB => sig_RB,
      RW => sig_Rd,
      A => bus_A,
      B => bus_B
    );

    EXT8 : entity work.Extention(Behaviour)
    generic map (
      N => sig_imm8'LENGTH
    )
    port map (
      E => sig_imm8,
      S => ext_out1
    );

    MEM : entity work.mem(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => sig_MemWr,
      DATAin => bus_B,
      Addr => alu_out(5 downto 0),
      DATAout => mem_out
    );


    MUX1e : entity work.multiplexeur2vers1(Behaviour)
    generic map (
      N => 32
    )
    port map (
      A => bus_B,
      B => ext_out1,
      COM => sig_ALUSrc,
      S => mux1_out
    );

    MUX2e : entity work.multiplexeur2vers1(Behaviour)
    generic map (
      N => 32
    )
    port map (
      A => alu_out,
      B => mem_out,
      COM => sig_WrSrc,
      S => bus_W
    );


    MuxREG: entity work.multiplexeur2vers1(Behaviour)
    generic map (
      N => 4
    )
    port map (
      A => sig_Rm,
      B => sig_Rd,
      COM => sig_RegSel,
      S => sig_RB
    );

    DCODE : entity work.decodeurinstruction(Behaviour)

    port map (
    instruction => sig_instruction ,
    cpsr => sig_cpsr_out  ,
    nPCSel =>sig_nPCSel ,
    RegWr =>sig_RegWr  ,
    ALUSrc =>sig_ALUSrc ,
    ALUCtr => sig_ALUCtr ,
    PSREn => sig_PSREn ,
    MemWr => sig_MemWr ,
    WrSrc => sig_WrSrc ,
    RegSel => sig_RegSel ,
    RegAff => sig_RegAff , 
    Rd=> sig_Rd ,
    Rn=> sig_Rn ,
    Rm=> sig_Rm ,
    imm24 => sig_imm24 ,
    imm8 => sig_imm8,
    IRQ_END=>sig_IRQ_END
  );

  RegPSR : entity work.registrecommande(Behaviour)
  
  port map (
    WE=>  sig_PSREn ,
    CLK=>  CLK ,
    Reset=>  Reset , 
    DATAIN=>   sig_cpsr_in,
    DATAOUT =>sig_cpsr_out
  );

  RegAff : entity work.registrecommande(Behaviour)
  
  port map (
    WE=>  sig_RegAff ,
    CLK=>  CLK ,
    Reset=>  Reset , 
    DATAIN=>   bus_B,
    DATAOUT =>afficheur
  );

  VIC : entity work.vic(Behaviour)
    port map (
      CLK=>CLK,
      RESET=>Reset,
      IRQ_SERV=>sig_IRQ_SERV,
      IRQ0=>IRQ0,
      IRQ1=>IRQ1,
      IRQ =>sig_IRQ,
      VICPC=> sig_VICPC
    );

   SEXT : entity work.Extention(Behaviour)
  generic map (
  N => sig_imm24'LENGTH
  )
  port map (
    E => sig_imm24,
    S => ext_out2
  );
   
  UGI : entity work.ugi(Behaviour)

  port map (
    npcsel =>sig_nPCSel,
    CLK =>CLK,
    Reset =>Reset,
    ext_out =>ext_out2, 
    instruction => sig_instruction,
    IRQ=>sig_IRQ,
    IRQ_END=>sig_IRQ_END,
    IRQ_SERV=>sig_IRQ_SERV,
    VICPC=>sig_VICPC
  );

end architecture;


