LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY assemblage_utt_tb IS
    ---------------------------------------
END ENTITY;
---------------------------------------
ARCHITECTURE TEST OF assemblage_utt_tb IS
    ---------------------------------------
    CONSTANT Period : TIME := 10 us; -- speed up simulation with a 100kHz clock
    SIGNAL tb_CLK : STD_LOGIC := '0';
    SIGNAL tb_Reset : STD_LOGIC := '0';
    SIGNAL tb_RegWr : STD_LOGIC := '0';
    SIGNAL tb_WrEn : STD_LOGIC := '0';
    SIGNAL tb_RA : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_RB : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_RW : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_Imm : STD_LOGIC := '0';
    SIGNAL tb_COM : STD_LOGIC := '0';
    SIGNAL tb_OP : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_N : STD_LOGIC;
    SIGNAL tb_C : STD_LOGIC;
    SIGNAL tb_Z : STD_LOGIC;
    SIGNAL tb_V : STD_LOGIC;
    SIGNAL tb_immediate : std_logic_VECTOR(7 downto 0):= (OTHERS => '0');
    SIGNAL Done : BOOLEAN := false;
BEGIN
    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;
    tb_Reset <= '1', '0' AFTER Period;

    -- Unit Under Test instanciation
    entity_UDT : ENTITY work.assemblage_utt
        PORT MAP(
            CLK => tb_CLK,
            Reset => tb_Reset,
            WEr => tb_RegWr,
            WEm => tb_WrEn,
            RA => tb_RA,
            RB => tb_RB,
            RW => tb_RW,
            MUX1 => tb_Imm,
            MUX2 => tb_COM,
            OP => tb_OP,
            N => tb_N,
            Z => tb_Z,
            V => tb_V,
            C => tb_C,
            immediate=>tb_immediate
        );

    PROCESS
    type table is array(15 downto 0) of std_logic_vector(31 downto 0);
    alias banc_tb : table is << signal .entity_UDT.REG.Banc : table >>;

    -- type mem is array(63 downto 0) of std_logic_vector(31 downto 0);
    -- alias mem_tb : mem is << signal .entity_UDT.MEM.Banc : mem >>;
    BEGIN

        tb_RegWr <= '0';
        tb_WrEn <= '0';
        tb_RA <= (OTHERS => '0');
        tb_RB <= (OTHERS => '0');
        tb_RW <= (OTHERS => '0');
        tb_Imm <= '0';
        tb_COM <= '0';
        tb_OP <= (OTHERS => '0');

        -- Wait for reset to complete
        WAIT FOR Period;


        -- Test addition of 2 registers
        tb_RA <= "0001";
        tb_RB <= "1111";
        tb_RW <= "0001";
        tb_RegWr <= '1';
        tb_WrEn <= '0';
        tb_OP <= "000";
        tb_COM<='0';

        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        assert banc_tb(1)=x"00000030" report "erreur sur test addition 2 registres";

        -- Test addition of register with immediate value
        -- tb_RA <= "0001";
        tb_Imm <= '1';
        -- tb_OP <= "000";
        tb_immediate <="00000011";
        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        assert banc_tb(1)=x"00000033" report "erreur sur test addition registre + valeur immediate";


        -- Test soustraction of 2 registers
        tb_RA <= "0001";
        tb_RB <= "1111";
        tb_RW <= "0010";
        tb_OP <= "010";
        tb_Imm<='0';

        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        assert banc_tb(2)=x"00000003" report "erreur sur test soustraction 2 registres";

        tb_Imm <= '1';
        -- tb_OP <= "000";
        tb_immediate <="00000011";
        tb_RW <= "0001";
        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        assert banc_tb(1)=x"00000030" report "erreur sur test soustraction registre - valeur immediate";

        tb_OP <= "011";
        tb_RA <= "0010";
        tb_RW <= "0011";
        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        assert banc_tb(3)=x"00000003" report "erreur sur test copie registre";

        tb_RegWr <= '0';
        tb_WrEn <= '1';
        tb_RB <= "1111";
        -- a est dejà en 0x3 et on a a en sorti de l'aku donc dans l'adresse 
        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        -- assert mem_tb(3)=x"00000030" report "erreur sur test ecriture memoire";

        tb_COM<='1';
        tb_RW <= "1000";
        tb_RegWr <= '1';
        tb_WrEn <= '0';
        wait until rising_edge(tb_CLK);  -- Attendre un cycle d'horloge
        wait for 1ns;
        assert banc_tb(8)=x"00000030" report "erreur sur lecture memoire";

        WAIT FOR Period;
        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        
        WAIT;
    END PROCESS;

END ARCHITECTURE;