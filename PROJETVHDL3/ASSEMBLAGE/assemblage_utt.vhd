-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity assemblage_utt is
    port (
        CLK, Reset, WEr, WEm, MUX1, MUX2: in std_logic;
        OP : in std_logic_vector(2 downto 0);
        RA, RB, RW : in std_logic_vector(3 downto 0);
        N, Z, C, V : out std_logic;
        immediate : in std_logic_vector(7 downto 0)
      );
end entity;

architecture Behaviour of assemblage_utt is

  signal bus_W,alu_out, ext_out,mux1_out,mem_out : std_logic_vector(31 downto 0);
  signal bus_A, bus_B : std_logic_vector(31 downto 0);
  signal imm : std_logic_vector(7 downto 0);


begin
  imm<=immediate;

    ALU: entity work.alu(Behaviour)
    port map (
        OP => OP,
        A => bus_A,
        B => mux1_out,
        S => alu_out,
        N => N,
        Z => Z,
        C => C,
        V => V
    );


    REG : entity work.banc(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => WEr,
      W => bus_W,
      RA => RA,
      RB => RB,
      RW => RW,
      A => bus_A,
      B => bus_B
    );

    SEXT : entity work.Extention(Behaviour)
    generic map (
      N => imm'LENGTH
    )
    port map (
      E => imm,
      S => ext_out
    );

    MEM : entity work.mem(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => WEm,
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
      B => ext_out,
      COM => MUX1,
      S => mux1_out
    );

    MUX2e : entity work.multiplexeur2vers1(Behaviour)
    generic map (
      N => 32
    )
    port map (
      A => alu_out,
      B => mem_out,
      COM => MUX2,
      S => bus_W
    );


end architecture;


