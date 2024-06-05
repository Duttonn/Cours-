
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decodeurinstruction is
  port (
    instruction : in std_logic_vector(31 downto 0);
    cpsr : in std_logic_vector(31 downto 0);
    nPCSel : out std_logic;
    RegWr : out std_logic;
    ALUSrc : out std_logic;
    ALUCtr : out std_logic_vector(2 downto 0);
    PSREn : out std_logic;
    MemWr : out std_logic;
    WrSrc : out std_logic;
    RegSel : out std_logic;
    RegAff : out std_logic;   
    Rd: out std_logic_vector(3 downto 0);
    Rn: out std_logic_vector(3 downto 0);
    Rm: out std_logic_vector(3 downto 0);
    imm24 : out std_logic_vector(23 downto 0);
    imm8 : out std_logic_vector(7 downto 0);
    IRQ_END : out std_logic
  );
end entity decodeurinstruction;

architecture Behaviour of decodeurinstruction is
  signal PC : unsigned(31 downto 0);
  signal ext_out : std_logic_vector(31 downto 0);
  type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT,BX);
  signal instr_courante: enum_instruction;

begin
      Rn<= instruction(19 downto 16);
      Rd<= instruction(15 downto 12);
      Rm<= instruction(3 downto 0);
      imm24 <= instruction(23 downto 0);
      imm8 <= instruction(7 downto 0);

      
  chooseInstruction : process(instruction)
  begin 
      if instruction(27 downto 26)= "00" then -- traitement de données
            if instruction(24 downto 21)="1101" then -- MOV
                  instr_courante <= MOV;
            
            elsif instruction(24 downto 21)= "0100" then  
                  if instruction(25)='1' then -- ADDi
                        instr_courante <= ADDi;
                  else -- ADDr
                        instr_courante <= ADDr;
                        
                  end if;
            
            elsif instruction(24 downto 21)= "1010" then -- CMP
                  instr_courante <= CMP;
            
            end if ; 
      


      elsif instruction(27 downto 26)= "01" then -- transfert de donnée
            if instruction(20)= '1' then -- LDR
                  instr_courante <= LDR;
            
            else -- STR
                  instr_courante <= STR;
            
            end if ;
      elsif instruction=x"EB000000" then --BX
            instr_courante <= BX;
      elsif instruction(27 downto 26)= "10" then -- Branchement
            if instruction(31 downto 28)= x"E" then --BAL
                  instr_courante <= BAL;
                  
            elsif instruction(31 downto 28)= x"B" then --BLT
                  instr_courante <= BLT;
                  
            end if; 
      
      else 
            instr_courante <= MOV;
      end if;
 

  end process chooseInstruction;


  sigbranch : process (instruction,instr_courante,cpsr)
  begin 
  IRQ_END <='0';
      case instr_courante is
            when MOV =>
                  nPCSel <= '0';
                  RegWr <= '1';
                  ALUSrc <= '1';
                  ALUCtr <= "001";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0';
                    
            when ADDi =>
                  nPCSel <= '0';
                  RegWr <= '1';
                  ALUSrc <= '1';
                  ALUCtr <= "000";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0';
                    
            when ADDr =>
                  nPCSel <= '0';
                  RegWr <= '1';
                  ALUSrc <= '0';
                  ALUCtr <= "000";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0';
                    
            when CMP =>
                  nPCSel <= '0';
                  RegWr <= '0';
                  ALUSrc <= '1';
                  ALUCtr <= "010";
                  PSREn <= '1';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0';
                    
            when LDR =>
                  nPCSel <= '0';
                  RegWr <= '1';
                  ALUSrc <= '1';
                  ALUCtr <= "000";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '1';
                  RegSel <= '0';
                  RegAff <= '0';
                    
            when STR =>
                  nPCSel <= '0';
                  RegWr <= '0';
                  ALUSrc <= '1';
                  ALUCtr <= "000";
                  PSREn <= '0';
                  MemWr <= '1';
                  WrSrc <= '0';
                  RegSel <= '1';
                  RegAff <= '1';
                    
            when BAL =>
                  nPCSel <= '1';
                  RegWr <= '0';
                  ALUSrc <= '0';
                  ALUCtr <= "000";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0';
            when BLT =>
                  nPCSel <= cpsr(31);
                  RegWr <= '0';
                  ALUSrc <= '0';
                  ALUCtr <= "000";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0'; 
            when BX => 
                  IRQ_END <='1';      
            when others =>
                  nPCSel <= '0';
                  RegWr <= '1';
                  ALUSrc <= '1';
                  ALUCtr <= "001";
                  PSREn <= '0';
                  MemWr <= '0';
                  WrSrc <= '0';
                  RegSel <= '0';
                  RegAff <= '0';
        end case;
  end process sigbranch;       


  
end architecture Behaviour;
