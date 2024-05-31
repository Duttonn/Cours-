LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TOP_processor IS
	PORT (
		CLOCK_50 : IN STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
		HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
		HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
		HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6)
	);
END ENTITY;

ARCHITECTURE RTL OF TOP_processor IS

	SIGNAL rst, clk, pol : STD_LOGIC;
	signal data_out : STD_LOGIC_VECTOR(31 downto 0);
	signal num1,num2,num3,num4 : STD_LOGIC_VECTOR(3 downto 0);


BEGIN

	clk <= CLOCK_50;
	rst <= SW(0);
	pol <= SW(9);

	Processor : entity work.assemblage_utt_final(Behaviour)
	port map (
        CLK=>clk, 
	  Reset=>rst,
        afficheur=>data_out
      );

	num1 <= data_out(15 downto 12);
	num2 <= data_out(11 downto 8);
	num3 <= data_out(7 downto 4);
	num4 <= data_out(3 downto 0);

	dig1: entity work.SEVEN_SEG(COMB)
	PORT map(
		Data=>num1,
		Pol =>pol,
		Segout =>HEX3
		);
	dig2: entity work.SEVEN_SEG(COMB)
		PORT map(
			Data=>num2,
			Pol =>pol,
			Segout =>HEX2
		);
	dig3: entity work.SEVEN_SEG(COMB)
		PORT map(
			Data=>num3,
			Pol =>pol,
			Segout =>HEX1
		);
	dig4: entity work.SEVEN_SEG(COMB)
		PORT map(
			Data=>num4,
			Pol =>pol,
			Segout =>HEX0
		);


END ARCHITECTURE;