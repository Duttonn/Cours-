-- Squelette pour l'exercice alu

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_traitement is
    port (
        CLK, Reset, WE : in std_logic;
        OP : in std_logic_vector(2 downto 0);
        RA, RB, RW : in std_logic_vector(3 downto 0);
        N, Z, C, V : out std_logic
      );
end entity;

architecture Behaviour of unite_traitement is

  signal bus_W : std_logic_vector(31 downto 0);
  signal bus_A, bus_B : std_logic_vector(31 downto 0);


begin
  

    ALU: entity work.alu(Behaviour)
    port map (
        OP => OP,
        A => bus_A,
        B => bus_B,
        S => bus_W,
        N => N,
        Z => Z,
        C => C,
        V => V
    );


    U1 : entity work.banc(Behaviour)
    port map (
      CLK => CLK,
      Reset => Reset,
      WE => WE,
      W => bus_W,
      RA => RA,
      RB => RB,
      RW => RW,
      A => bus_A,
      B => bus_B
    );


end architecture;


